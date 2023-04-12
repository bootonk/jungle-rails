describe("homepage to product page testing", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("Should navigate to a product page when one is clicked", () => {
    cy.get(".products article").should("be.visible").first().click();
  });
});
