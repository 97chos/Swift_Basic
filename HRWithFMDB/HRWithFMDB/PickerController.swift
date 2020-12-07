//
//  PickerController.swift
//  HRWithFMDB
//
//  Created by sangho Cho on 2020/12/07.
//

import Foundation
import UIKit

class PickerController: UIViewController {

    let departDAO = DepartmentDAO()
    var departList: [(departCd: Int, departTitle: String, departAddr: String)]!

    var pickerView: UIPickerView!

    // 현재 피커뷰에 선택되어 있는 부서의 코드를 가져오는 연산 프로퍼티 정의
    var selectedDepartCd : Int {
        let row = self.pickerView.selectedRow(inComponent: 0)
        return self.departList[row].departCd
    }

    override func viewDidLoad() {
        // 1. DB에서 부서 목록을 가져와 튜플 배열 초기화
        self.departList = departDAO.find()

        // 2. 피커 뷰 객체를 초기화하고, 최상위 뷰의 서브 뷰로 추가
        self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        self.pickerView.dataSource = self
        self.pickerView.delegate = self

        self.view.addSubview(pickerView)

        // 3. 외부에서 뷰 컨트롤러를 참조할 때를 위한 사이즈 지정
        let pWidth = self.pickerView.frame.width
        let pHeight = self.pickerView.frame.height

        self.preferredContentSize = CGSize(width: pWidth, height: pHeight)
    }

}

extension PickerController: UIPickerViewDataSource {
    // 피커 뷰에 표시될 전체 컴포넌트 개수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // 특정 컴포넌트의 행 개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.departList.count
    }

    // 피커 뷰의 각 행에 표시될 뷰를 결정하는 메소드
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        // view : 이전 행에서 스크롤로 가려지면서 캐싱된 행, 재사용 셀 매커니즘과 비슷
        var titleView = view as? UILabel

        if titleView == nil {
            titleView = UILabel()
            titleView?.font = UIFont.systemFont(ofSize: 14)
            titleView?.textAlignment = .center
        }

        titleView?.text = "\(self.departList[row].departTitle)(\(self.departList[row].departAddr))"

        return titleView!
    }
}

extension PickerController: UIPickerViewDelegate {

}
