Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D767452AD1F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245613AbiEQU41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbiEQU4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:56:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212116335;
        Tue, 17 May 2022 13:56:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r6-20020a1c2b06000000b00396fee5ebc9so13903wmr.1;
        Tue, 17 May 2022 13:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=SttB0Al2SmA1Ml2eTj/wShEo5Nwp1X2GJB1Zw/Jq5fs=;
        b=XAvJ64DTg2filoPTc7irccoZINdkOQRv9oxEwoMQGDhK4O1U80pzXCFuZjJVE3FjWp
         wzyfulpgNydLZVyljEzJHhtWMj9TFHHiioK0yIligTXDdr1L2F7tFsWbpKCz8Nm7vjD1
         yiDrUo8mdB8Jqn5GQhTTPNZVk4ZnTLL07oF7cdSEAGneTPaznZcwQrFAIlMth93g4PyC
         sW2qatOQM3Lek969GECns1t2VlOEOK2/0KvGW+q6kJJ7DqrATSSGGlpJd9aWE8fozGGl
         r7K5fNQnME+1rDbh7xE5bhnLOB9GWe+Ucl/mHSw8/fHLTtRSNGDk5iq8NcGtQP8hlqGG
         h67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=SttB0Al2SmA1Ml2eTj/wShEo5Nwp1X2GJB1Zw/Jq5fs=;
        b=vrw7919geKxjaOng9yRjR3oHJwGJcWur8bkKUKNMqoKTxyjng4IdYiwKnumdNsEHkX
         Hn4MzApmPMoCRwPRNw6Q3Y7nS/olQb1qqeyUZeiibCso5BJiag8unlxSO/v83yLMIsKh
         6lSHTGlYe155U+zFK7nv39smYll8FI4glS5SjneK8WKCfQ5a0EnGkixppXJShfG+hum7
         fO+8RllMD/e3MzoTUEKFkvy0Bw27EJympRf5HL7paBJ1V2vayV5Hw0wsfreQJUCLMh3L
         /MDQjbVWILO9QGSzvwsAtqvwAW/yghBz99w76/oNjlz02vlMegWnDbVW8zzGZC8xrq/k
         ddhA==
X-Gm-Message-State: AOAM5330FBIT5FABY1nzucW94gmcMdJ62dvK/hef0OKOUUo4ouR744Od
        k0BrOIXrj1Hf18FcSrOdXCxOSZ3t2gc=
X-Google-Smtp-Source: ABdhPJxlpNKQuhQSJ2hEFYuSL2olvE3fgInpxw9a5UdtqtVkXl3QVdrp6UlvAJnusHS8jfSHPkGvdg==
X-Received: by 2002:a7b:c5cd:0:b0:38c:8b1b:d220 with SMTP id n13-20020a7bc5cd000000b0038c8b1bd220mr22753995wmk.118.1652820972354;
        Tue, 17 May 2022 13:56:12 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id e25-20020adfa459000000b0020c5253d8dcsm73870wra.40.2022.05.17.13.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:56:11 -0700 (PDT)
Message-ID: <62840beb.1c69fb81.9bdaf.070c@mx.google.com>
X-Google-Original-Message-ID: <YoQL6ULpjb9muRvn@Ansuel-xps.>
Date:   Tue, 17 May 2022 22:56:09 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: mtd: qcom_nandc: document
 qcom,boot-pages binding
References: <20220503154353.4367-1-ansuelsmth@gmail.com>
 <20220503154353.4367-3-ansuelsmth@gmail.com>
 <20220516184912.GA3063673-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516184912.GA3063673-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 01:49:12PM -0500, Rob Herring wrote:
> On Tue, May 03, 2022 at 05:43:53PM +0200, Ansuel Smith wrote:
> > Document new qcom,boot_pages binding used to apply special
> 
> s/boot_pages/boot-pages/
> 
> > read/write configuration to boot pages.
> > 
> > QCOM apply a special configuration where spare data is not protected
> > by ECC for some special pages (used for boot partition). Add
> > Documentation on how to declare these special pages.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../devicetree/bindings/mtd/qcom,nandc.yaml   | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > index 84ad7ff30121..fafeca0cafff 100644
> > --- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > @@ -102,6 +102,26 @@ allOf:
> >              - const: rx
> >              - const: cmd
> >  
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,ipq8074-nand
> > +
> > +    then:
> > +      properties:
> > +        qcom,boot-pages:
> > +          $ref: /schemas/types.yaml#/definitions/uint32-matrix
> 
> You need to define the dimensions. Something like this:
> 
>              items:
>                items:
>                  - description: offset
>                  - description: size
>

Considering this is not limited to one item how should I declare that an
user can declare multiple items? (the user can declare multiple zones)
Declaring minItems without a maxItems? 

I assume in the suggested form it's assumed
minItems: 1
maxItems: 1
so this would be problematic.

> > +          description:
> > +            Some special page used by boot partition have spare data
> > +            not protected by ECC. Use this to declare these special page
> > +            by defining first the offset and then the size.
> > +
> > +            It's in the form of <offset1 size1 offset2 size2 offset3 ...>
> > +
> > +            Refer to the ipq8064 example on how to use this special binding.
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -135,6 +155,8 @@ examples:
> >          nand-ecc-strength = <4>;
> >          nand-bus-width = <8>;
> >  
> > +        qcom,boot-pages = <0x0 0x58a0000>;
> > +
> >          partitions {
> >            compatible = "fixed-partitions";
> >            #address-cells = <1>;
> > -- 
> > 2.34.1
> > 
> > 

-- 
	Ansuel
