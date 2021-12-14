import Foundation

public struct RealestateSoldStateModel {
    public let title: String
    public let logoUrl: String
    public let presentFormButtonTitle: String
    public let agentProfile: AgentProfileModel
    public let questionForm: QuestionFormViewModel
    public let companyProfile: CompanyProfileModel
    public let formSubmitted: RealestateSoldStateFormSubmittedModel
    public let styling: Styling

    public init(
        title: String,
        logoUrl: String,
        presentFormButtonTitle: String,
        agentProfile: AgentProfileModel,
        questionForm: QuestionFormViewModel,
        companyProfile: CompanyProfileModel,
        formSubmitted: RealestateSoldStateFormSubmittedModel,
        styling: Styling
    ) {
        self.title = title
        self.logoUrl = logoUrl
        self.presentFormButtonTitle = presentFormButtonTitle
        self.agentProfile = agentProfile
        self.questionForm = questionForm
        self.companyProfile = companyProfile
        self.formSubmitted = formSubmitted
        self.styling = styling
    }
}