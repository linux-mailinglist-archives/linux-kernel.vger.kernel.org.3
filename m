Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B554FAE49
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243258AbiDJOjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 10:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiDJOi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 10:38:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9444FC51;
        Sun, 10 Apr 2022 07:36:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w18so15262861edi.13;
        Sun, 10 Apr 2022 07:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKkGQ0Mvqi4FBstenNkXAi42Rt/g6fYjLkhfPoyt3WM=;
        b=HkgsCSL58PnbdcUBEOhGnHm6bJa+DOxjnoSIAlawOv1amwFaBpH6xfy629c4kCnBby
         WUoJLA/YSQIcw+yi/FA+hKHSdo3KYfxfCUD2jJoaaZX+Z4GNzz7/urKDCSBz4RrsdN3y
         AkJiaTLVMJScsv258BEFIrZtfrdYd6jPnoPVYU9Cu/jcKLgBaM3zOHQq86qJTKBYy+jW
         y1I9BsvJQAJaIJs81NIZ2zIYMNKVzIav0LtD7aMnebtNLgKkeZ2Cj7uF/utQfsT6NG6C
         pFjqAAHVmA1af2uKYgsOm+Z6tiQqJtj48EtHBFYvIgNQVmzcPhmxGTJbIhHkPO2DaGJo
         QOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKkGQ0Mvqi4FBstenNkXAi42Rt/g6fYjLkhfPoyt3WM=;
        b=xm/sjEWFbZQsUMqPjbNDsuYAz1nm+4A+L4DNGDEAaZloyghKnSz+355oexTBRe9zux
         C7wgK2rAXGwDp2pZyKL5nzBdOd0PUtLfw6zf5trL63AdpVsS/OMODANO+ea6B1C6muLe
         PHqsuQ1WSlxJ9fiKJ8AbrdwXy6+UP5wJThEoWGF4J08xo9bgS6kSKNQB5UCSWNlaZKj0
         DOA3Gzgyq4n2GmsAahX8tVxKBzats/mIY8d8672e87f0sqHG6dkjD24TeO/MYmlenYuc
         0COu3Xc6fXYHFsi4TLGMzfewWQ9Wevwzw4luTl1YE8u8vsyF12qzsxJW5+Yi/gY5QRut
         tczQ==
X-Gm-Message-State: AOAM532TzQYU5yvSB2jDD/CXAyqzxLK/Ki5Io8NQR8xVzdkwm7DbSLtx
        NamUG//l2jNh7I40X7RHXLQPwE24FGeHZFQOhfw=
X-Google-Smtp-Source: ABdhPJzTDZ5SdBgHlmf6b0kuw1eJUXWFsZR/bspw3My95hu+0WpS5LLqUJLEvCUrOzoKmjYfdJiCVqH6U2RA+lZXSss=
X-Received: by 2002:a05:6402:2142:b0:413:6531:bd9e with SMTP id
 bq2-20020a056402214200b004136531bd9emr28703628edb.5.1649601405556; Sun, 10
 Apr 2022 07:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220402193942.744737-1-aford173@gmail.com> <20220402193942.744737-2-aford173@gmail.com>
 <a66f17c6-cec6-3eb8-92df-9990d74dd122@linaro.org>
In-Reply-To: <a66f17c6-cec6-3eb8-92df-9990d74dd122@linaro.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 10 Apr 2022 09:36:34 -0500
Message-ID: <CAHCN7x+mm_oXdkzXOTEQwjCFfDB99p2JG8zZzydbL5_pUVJqCQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] dt-bindings: mmc: imx-esdhc: Update compatible fallbacks
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 2, 2022 at 3:12 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/04/2022 21:39, Adam Ford wrote:
> > The SDHC controller in the imx8mn and imx8mp have the same controller
> > as the imx8mm which is slightly different than that of the imx7d.
> > Using the fallback of the imx8mm enables the controllers to support
> > HS400-ES which is not available on the imx7d. After discussion with NXP,
> > it turns out that the imx8qm should fall back to the imx8qxp, because
> > those have some additional flags not present in the imx8mm.
> >
> > Suggested-by: haibo.chen@nxp.com
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V3:  Marked the imx7d-usdhc as deprecated when there are better
> >      fallback options or the fallback isn't needed.
> >      Leave the deprecated fallback in the YAML to prevent errors
> >      Remove Reviewed-by from Krzysztof Kozlowski due to the above
> >
> > V2:  Update the table per recomendation from Haibo.
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > index 7dbbcae9485c..11f039320d79 100644
> > --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > @@ -34,23 +34,34 @@ properties:
> >            - fsl,imx6ull-usdhc
> >            - fsl,imx7d-usdhc
> >            - fsl,imx7ulp-usdhc
> > +          - fsl,imx8mm-usdhc
> > +          - fsl,imx8qxp-usdhc
> >            - fsl,imxrt1050-usdhc
> >            - nxp,s32g2-usdhc
> >        - items:
> >            - enum:
> >                - fsl,imx8mm-usdhc
> > +              - fsl,imx8mq-usdhc
> > +            # fsl,imx7d-usdhc fallback is deprecated for imx8mm-usdhc
> > +          - const: fsl,imx7d-usdhc
>
> Instead of comment use (I think on the same level as items):
>
> deprecated: true

I have tried various combinations of where to place "deprecated" and
whether or not to use a hyphen, but I always get syntax errors.  Do
you have an example of this I can see?

adam
>
> > +      - items:
> > +          - enum:
> >                - fsl,imx8mn-usdhc
> >                - fsl,imx8mp-usdhc
>
> So if this is a deprecated list, where is a proper one? The list with
> this enum + imx8mm?
>
> IOW, you need to list here:
> 1. Old combinations with "deprecated: true"
> 2. New combinations.
>
> > -              - fsl,imx8mq-usdhc
> > -              - fsl,imx8qm-usdhc
> > -              - fsl,imx8qxp-usdhc
> > +          - const: fsl,imx8mm-usdhc
> > +            # fsl,imx7d-usdhc fallback is deprecated
> >            - const: fsl,imx7d-usdhc
> >        - items:
> >            - enum:
> > -              - fsl,imx93-usdhc
> >                - fsl,imx8ulp-usdhc
> > +              - fsl,imx93-usdhc
> >            - const: fsl,imx8mm-usdhc
> > -
> > +      - items:
> > +          - enum:
> > +              - fsl,imx8qm-usdhc
> > +          - const: fsl,imx8qxp-usdhc
> > +            # fsl,imx7d-usdhc fallback is deprecated
> > +          - const: fsl,imx7d-usdhc
> >    reg:
> >      maxItems: 1
> >
>
>
> Best regards,
> Krzysztof
