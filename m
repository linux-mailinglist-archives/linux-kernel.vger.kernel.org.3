Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890F8566A2B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiGELvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiGELvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:51:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87F4175AB;
        Tue,  5 Jul 2022 04:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48099B817CB;
        Tue,  5 Jul 2022 11:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADEFC341CB;
        Tue,  5 Jul 2022 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657021902;
        bh=37ErEos1glNflV0Z8TycaNQrb1sNVtveZKaWkyeGY4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X15yTqoh73uHtWmXjsLZ5BSqB88XR8KYXv2Gj3ZpGsVXg3vZ7aPkzd2B1F1UvFr3h
         1zHdVE5NdYIqqHDgj44DLHqQSUMFZ6etSPHY1GCMi5Vel2BBFzvHM9JWa5urz7vvIj
         lw5de7cWFSlg3Fa0x/ocKJj0x25dJyq+uIcFIyC0Fzd/Cq9KI2/4KGuN2PMcC+8vZX
         rK+Rhaw/aDtcH8gc4OMd/nxdT5JpOuRFZOM6IEjEK6BecLI+GS64HF9kxnjlRdLh2D
         cnnHef330954A4i4mkFnyjBV18vnfc60zMB/p8YlVu22fdPKe+FShIrNJsLskqdn85
         4+nTGKUOHi5vA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o8h5i-00064X-Oq; Tue, 05 Jul 2022 13:51:42 +0200
Date:   Tue, 5 Jul 2022 13:51:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/43] dt-bindings: phy: qcom,qmp-pcie: add missing child
 node schema
Message-ID: <YsQlzr6nyvz761Kz@hovoldconsulting.com>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-18-johan+linaro@kernel.org>
 <4bc79a1c-66b1-225d-5026-ddf3e6f7d22c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bc79a1c-66b1-225d-5026-ddf3e6f7d22c@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 12:18:37PM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 11:42, Johan Hovold wrote:
> > Add the missing the description of the PHY-provider child node which was
> > ignored when converting to DT schema.
> > 
> > Also fix up the incorrect description that claimed that one child node
> > per lane was required.
> > 
> > Fixes: ccf51c1cedfd ("dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml")
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  .../bindings/phy/qcom,qmp-pcie-phy.yaml       | 88 ++++++++++++++++++-
> >  1 file changed, 85 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
> > index ff1577f68a00..5a1ebf874559 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
> > @@ -69,9 +69,37 @@ properties:

> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,sm8250-qmp-gen3x2-pcie-phy
> > +              - qcom,sm8250-qmp-modem-pcie-phy
> > +              - qcom,sm8450-qmp-gen4x2-pcie-phy
> > +    then:
> > +      patternProperties:
> > +        "^phy@[0-9a-f]+$":
> > +          properties:
> > +            reg:
> > +              items:
> > +                - description: TX lane 1
> > +                - description: RX lane 1
> > +                - description: PCS
> > +                - description: TX lane 2
> > +                - description: RX lane 2
> > +                - description: PCS_MISC
> > +    else:
> > +      patternProperties:
> > +        "^phy@[0-9a-f]+$":
> > +          properties:
> > +            reg:
> > +              minItems: 3
> > +              maxItems: 4
> > +              items:
> > +                - description: TX
> > +                - description: RX
> > +                - description: PCS
> > +                - description: PCS_MISC
> > +      if:
> 
> Do not include if within other if. Just split the entire section to its
> own if:.

That sounds like it would just obfuscate the logic. The else clause
specified 3-4 registers and the nested if determines which compatibles
use which by further narrowing the range.

If you move it out to the else: this would be really hard understand and
verify.

> > +        properties:
> > +          compatible:
> > +            contains:
> > +              enum:
> > +                - qcom,ipq6018-qmp-pcie-phy
> > +                - qcom,ipq8074-qmp-pcie-phy
> > +                - qcom,msm8998-qmp-pcie-phy
> > +                - qcom,sdm845-qhp-pcie-phy
> > +      then:
> > +        patternProperties:
> > +          "^phy@[0-9a-f]+$":
> > +            properties:
> > +              reg:
> > +                maxItems: 3
> > +      else:
> > +        patternProperties:
> > +          "^phy@[0-9a-f]+$":
> > +            properties:
> > +              reg:
> > +                minItems: 4

Johan
