Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B645400FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbiFGONA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbiFGOM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:12:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F8F19E;
        Tue,  7 Jun 2022 07:12:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF81461578;
        Tue,  7 Jun 2022 14:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15294C385A5;
        Tue,  7 Jun 2022 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654611175;
        bh=tOlTuXrCdHXR6tngcOYuj9xb6Z7sf9Xjv7iA3sFggYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KH4AWZwnRnDjxQDeZmq+Cmgtn6CDh5+jO2Zb7+EQMAhBVKoINQHyhMuThDfmevcBt
         ZTDUUyjmeiOD4Tibu/IbzEYR2NAYUYA59os4W+XauvN7beQS/xos5AiLJDnwVrndUB
         rM5amS1fGMBjy59vEfHyiqOmGRTu9UYaqMyg/YOisI7Va9vKbs3Qac9qJhRxKkexml
         aU8UhPgCJH+avMFetQh4PoMZ0XdyT5aMEOm1EY4vsbeKaZ9Hwl8hfcWkqD8AjYVwK9
         ukNPlmqK55f0NoRDtDaBQC0MTDoeqZPUvqzfB4UPasrcLeVxKToaglkKnnAk9WRCro
         RPY6qgXxQqaTw==
Date:   Tue, 7 Jun 2022 19:42:42 +0530
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
Subject: Re: [PATCH v4 2/2] dt-bindings: mtd: qcom_nandc: document
 qcom,boot-pages binding
Message-ID: <20220607141242.GA1882@thinkpad>
References: <20220519190112.6344-1-ansuelsmth@gmail.com>
 <20220519190112.6344-3-ansuelsmth@gmail.com>
 <20220607091522.GB5410@thinkpad>
 <629f3127.1c69fb81.2590d.39ac@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <629f3127.1c69fb81.2590d.39ac@mx.google.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 09:05:16AM +0200, Ansuel Smith wrote:
> On Tue, Jun 07, 2022 at 02:45:22PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, May 19, 2022 at 09:01:12PM +0200, Ansuel Smith wrote:
> > > Document new qcom,boot-pages binding used to apply special
> > > read/write configuration to boot pages.
> > > 
> > > QCOM apply a special configuration where spare data is not protected
> > > by ECC for some special pages (used for boot partition). Add
> > > Documentation on how to declare these special pages.
> > > 
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  .../devicetree/bindings/mtd/qcom,nandc.yaml   | 26 +++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > > index 84ad7ff30121..a59ae9525f4e 100644
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
> > > +        qcom,boot-pages:
> > 
> > Eventhough the page layout is what making the difference, here the boot
> > partition offset and size are getting specified. So how about, changing it
> > to "qcom,boot-partitions"?
> > 
> > Thanks,
> > Mani
> >
> 
> Yep, you are correct and the naming is confusing. Will do the change.
> Did you check the code if you notice something to improve / an idea of a
> better implementation or better naming?
> Just to skip sending multiple revision with small changes.
> 

Yep, I do have some comments. Will share them.

Thanks,
Mani

> > > +          $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > +          items:
> > > +            items:
> > > +              - description: offset
> > > +              - description: size
> > > +          description:
> > > +            Some special page used by boot partition have spare data
> > > +            not protected by ECC. Use this to declare these special page
> > > +            by defining first the offset and then the size.
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
> > > +        qcom,boot-pages = <0x0 0x58a0000>;
> > > +
> > >          partitions {
> > >            compatible = "fixed-partitions";
> > >            #address-cells = <1>;
> > > -- 
> > > 2.34.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்
> 
> -- 
> 	Ansuel

-- 
மணிவண்ணன் சதாசிவம்
