Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB837544952
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243007AbiFIKlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243229AbiFIKku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:40:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104721105DE;
        Thu,  9 Jun 2022 03:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A00B961D98;
        Thu,  9 Jun 2022 10:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D8DC34114;
        Thu,  9 Jun 2022 10:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654771230;
        bh=Wf1dhu5SQZfFcciS3upZkCwdHerc+NxnCZv0l+U13g8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLTslnYCa+oM6PAoLH8GepLVVcc/R2U8AJ6EJEvHCTiFddGWW/AjUau6qbWbXwezQ
         2CRcan9QZd5dfHRgByYGdP9WNSFT6edd90LxCOIE/oWUWIbrzydsqj7Gio3ad5OyVW
         2HFwrNBIyGMU5aaQI+rKk3iZ23PFEeqnGgEBxwhH5lMVt/3LVw3047oiHm+/GRVRqz
         wvm/aQizoP19YBog/Hr2aIyv0LfdKViW6zMfGeUC1VDEQyDffKJTJjYzXOrYWD8vDY
         wFMnMbSyuNSc6MREiqj7QLu1qTmCb4WjTzEBV+d3bleZ1iBjuuTHwjAS+xcP2BY9Y6
         z/VKtPiEdYPIQ==
Date:   Thu, 9 Jun 2022 16:09:44 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: mtd: qcom_nandc: document
 qcom,boot-partitions binding
Message-ID: <20220609103944.GD2758@thinkpad>
References: <20220608001030.18813-1-ansuelsmth@gmail.com>
 <20220608001030.18813-3-ansuelsmth@gmail.com>
 <20220609072029.GA2758@thinkpad>
 <62a1ca9a.1c69fb81.3b355.0b02@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62a1ca9a.1c69fb81.3b355.0b02@mx.google.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 12:25:27PM +0200, Ansuel Smith wrote:
> On Thu, Jun 09, 2022 at 12:50:29PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jun 08, 2022 at 02:10:29AM +0200, Ansuel Smith wrote:
> > > Document new qcom,boot-partition binding used to apply special
> > > read/write layout to boot partitions.
> > > 
> > > QCOM apply a special layout where spare data is not protected
> > > by ECC for some special pages (used for boot partition). Add
> > > Documentation on how to declare these special pages.
> > > 
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  .../devicetree/bindings/mtd/qcom,nandc.yaml   | 26 +++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > > index 84ad7ff30121..a0914ccb95b0 100644
> > > --- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > > +++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > > @@ -102,6 +102,30 @@ allOf:
> > >              - const: rx
> > >              - const: cmd
> > >  
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - qcom,ipq806x-nand
> > > +
> > > +    then:
> > > +      properties:
> > > +        qcom,boot-partitions:
> > > +          $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > 
> > Wondering if u32 is enough for covering all ranges? Other than this,
> > 
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > Thanks,
> > Mani
> >
> 
> I mean they are offset and sizes... Considering it's an old SoC and max
> nand mounted is 1g we should be safe with u32.
> 

I thought so but wanted to confirm...

Thanks,
Mani

> > > +          items:
> > > +            items:
> > > +              - description: offset
> > > +              - description: size
> > > +          description:
> > > +            Boot partition use a different layout where the 4 bytes of spare
> > > +            data are not protected by ECC. Use this to declare these special
> > > +            partitions by defining first the offset and then the size.
> > > +
> > > +            It's in the form of <offset1 size1 offset2 size2 offset3 ...>
> > > +
> > > +            Refer to the ipq8064 example on how to use this special binding.
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > > @@ -135,6 +159,8 @@ examples:
> > >          nand-ecc-strength = <4>;
> > >          nand-bus-width = <8>;
> > >  
> > > +        qcom,boot-partitions = <0x0 0x58a0000>;
> > > +
> > >          partitions {
> > >            compatible = "fixed-partitions";
> > >            #address-cells = <1>;
> > > -- 
> > > 2.36.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்
> 
> -- 
> 	Ansuel

-- 
மணிவண்ணன் சதாசிவம்
