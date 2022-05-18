Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C389652C214
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiERSLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbiERSLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:11:04 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A844123177;
        Wed, 18 May 2022 11:11:02 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-f1d2ea701dso3742306fac.10;
        Wed, 18 May 2022 11:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2SbH21NI1RxYzUW8Fc68yUKxfiyOdhoY7sVVRkwTa5c=;
        b=b0wyhlyp9ooTdbNyTPbV2vY5e4sfyc4FmaTotnr6Xg8E7BS6wgiiHKtqYsR1KEedxB
         dDJ8fiYsHBSciCz+/ZuhEXa1TksqPxdId/27rygiJ0Wvj0RFxsfFOn+BqfczMjTCTcyk
         W7vfHM9VCBYDluBuV02bjwsglMwnj1OOV5RI+VgyyilICd7q8OH78+uHJRLLui2lkrsZ
         ej2xEAPKr5CwIn8p4ip/VK/iLsC9PHpWS7MOh4aOBUv9CO0ZxJWFM7J9FxZjYa1LeqiJ
         0VDMovHoZ6dS3Gdl5UUX6yVjRsB6/7jjg4kOIMMxQMAWvEZBtxke1OM0JkSlJ3/zskZU
         cfwg==
X-Gm-Message-State: AOAM532UjxOCYX5L/qnyid4wi9TFpAtpuRDSYmIrRNXhgznlxTJO2Oyl
        XDPCd7XLMqQRZv7sFXwLyA==
X-Google-Smtp-Source: ABdhPJyY34Vx2sbvEO/kb6TuZqgF4pxQHTW0SZ1pk0lPygem0MFJXB98JiXyUZaeU/emLp1lwUyc5g==
X-Received: by 2002:a05:6870:64a6:b0:f1:e54f:5923 with SMTP id cz38-20020a05687064a600b000f1e54f5923mr798509oab.123.1652897461805;
        Wed, 18 May 2022 11:11:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e133-20020acab58b000000b00325cda1ff99sm1019554oif.24.2022.05.18.11.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:11:00 -0700 (PDT)
Received: (nullmailer pid 3615615 invoked by uid 1000);
        Wed, 18 May 2022 18:11:00 -0000
Date:   Wed, 18 May 2022 13:11:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
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
Message-ID: <20220518181100.GG3302100-robh@kernel.org>
References: <20220503154353.4367-1-ansuelsmth@gmail.com>
 <20220503154353.4367-3-ansuelsmth@gmail.com>
 <20220516184912.GA3063673-robh@kernel.org>
 <62840beb.1c69fb81.9bdaf.070c@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62840beb.1c69fb81.9bdaf.070c@mx.google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 10:56:09PM +0200, Ansuel Smith wrote:
> On Mon, May 16, 2022 at 01:49:12PM -0500, Rob Herring wrote:
> > On Tue, May 03, 2022 at 05:43:53PM +0200, Ansuel Smith wrote:
> > > Document new qcom,boot_pages binding used to apply special
> > 
> > s/boot_pages/boot-pages/
> > 
> > > read/write configuration to boot pages.
> > > 
> > > QCOM apply a special configuration where spare data is not protected
> > > by ECC for some special pages (used for boot partition). Add
> > > Documentation on how to declare these special pages.
> > > 
> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  .../devicetree/bindings/mtd/qcom,nandc.yaml   | 22 +++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > > index 84ad7ff30121..fafeca0cafff 100644
> > > --- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > > +++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > > @@ -102,6 +102,26 @@ allOf:
> > >              - const: rx
> > >              - const: cmd
> > >  
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - qcom,ipq8074-nand
> > > +
> > > +    then:
> > > +      properties:
> > > +        qcom,boot-pages:
> > > +          $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > 
> > You need to define the dimensions. Something like this:
> > 
> >              items:
> >                items:
> >                  - description: offset
> >                  - description: size
> >
> 
> Considering this is not limited to one item how should I declare that an
> user can declare multiple items? (the user can declare multiple zones)
> Declaring minItems without a maxItems? 
> 
> I assume in the suggested form it's assumed
> minItems: 1
> maxItems: 1
> so this would be problematic.

No, the outer 'items' being a schema rather than a list means it applies 
to all items and does not set a size of (offset, size) pairs.

If you do have a maximum number, you could set the range.

Rob
