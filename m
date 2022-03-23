Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639F64E53D6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244593AbiCWOCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241736AbiCWOCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:02:39 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6AE7484E;
        Wed, 23 Mar 2022 07:01:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id p15so3023918ejc.7;
        Wed, 23 Mar 2022 07:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCVIhfUSnU8IPSagUHAJ0Zv4n7o7gQntDTvbCX+nFt8=;
        b=juExcyDTlT2UxKk3zCaBuoiQGJhree5ifHR7oGTRpSsDRiZfWhNHEoZbt2uL1Td94d
         UgBQB/rsoeFcq09aZyEYqUBXv4ocQJxhTOjHBBpvRSiUyznxb30omlPbg7F22O844Ejr
         Yv4ihxVXOZrftdmtmeQK6hM9H0KB5mUkphorU2Cnphc7xm7grwbmT7m3lfRZxHqi83HA
         VRjLZyVoWHwrJSl1x+MrYsHb1QwZelcKyDWXAm/A4ZqH6m0/JNGBotpnpgR8R4vbBthF
         a76LWrQdQ7vwvcJhNQhpu3aGoufB9zv7NN9uedQxRZ0NSY9B/mSXEGp8BX+qoJ4/q0xR
         bb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCVIhfUSnU8IPSagUHAJ0Zv4n7o7gQntDTvbCX+nFt8=;
        b=iqBCRxS6V4YpCpQBZJPZul4wa0t9avga/tRoyVw3WCnylvKz+9hLpBPwDuYZPi8oqV
         YiPcXXnKflsj2GrDrZEiszcmNNERWby5yk8vyvpAd+JZ354friBRpY207dzy32U0WLFn
         FJ1oN2pmcxZJKfdx8yHqA9kgazyHkKNXeQpYgYigQ5DKwfiSYcOZ9N2H20cEXwrWfgBA
         XoeIPV4aXIYkJlKd+H9whpfkdy4ta/utWHt5TQxa/otcu2R2QiPxCx6fuLJbxmnjOqB2
         vfonHU6lvMFuKjsyGs56Ut2eY8u3LbOslI/COUNTjWxRT3Pogi26x6ozrfa/ukjsNjJY
         PQbw==
X-Gm-Message-State: AOAM530ZbkdMLbWfqvjZ5ww7sFAg0geRHPlsOBRCmq3rhJtEetlhb11g
        RivM1hq1J/B2vEFwsseI9UvR/6NEl1r9s5f9K20=
X-Google-Smtp-Source: ABdhPJyqw2t5SZvLPazfXOr5THRD2EXHKAd2jXnzzMePxhtG4B2gyboCh8jzuJpoks8a2B4rBbdXNqpPs7XxSF/vJi8=
X-Received: by 2002:a17:906:9e11:b0:6df:a9d8:cbad with SMTP id
 fp17-20020a1709069e1100b006dfa9d8cbadmr115397ejc.32.1648044068495; Wed, 23
 Mar 2022 07:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220323134019.3796178-1-aford173@gmail.com> <35f58894-ed6d-0af0-e483-7a161ad6625a@kernel.org>
In-Reply-To: <35f58894-ed6d-0af0-e483-7a161ad6625a@kernel.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 23 Mar 2022 09:00:57 -0500
Message-ID: <CAHCN7x+RLAFnES8b3UMoc6n69ZVSFGOmAZyMeeY1g3aoiDNbZg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: imx-esdhc: Change imx8mn and imx8mp
 compatible fallback
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
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

On Wed, Mar 23, 2022 at 8:56 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 23/03/2022 14:40, Adam Ford wrote:
> > The SDHC controller in the imx8mn and imx8mp have the same controller
> > as the imx8mm which is slightly different than that of the imx7d.
> > Using the fallback of the imx8mm enables the controllers to support
> > HS400-ES which is not available on the imx7d.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > index 7dbbcae9485c..d6ea73d76bdd 100644
> > --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > @@ -39,14 +39,14 @@ properties:
> >        - items:
> >            - enum:
> >                - fsl,imx8mm-usdhc
>
> Your change looks reasonable, but why imx8mm is compatible with imx7d?

I saw that, and I wasn't sure the best way to go about  fixing it.  If
I move the 8mm out of the imx7d category, do I need to add it to the
enum list associated with the imx8mm, or can I just delete it from the
enum leaving the const for imx8mm good enough?

I am not very good with YAML files yet, so please forgive my ignorance.

adam
>
> > -              - fsl,imx8mn-usdhc
> > -              - fsl,imx8mp-usdhc
> >                - fsl,imx8mq-usdhc
> >                - fsl,imx8qm-usdhc
> >                - fsl,imx8qxp-usdhc
> >            - const: fsl,imx7d-usdhc
> >        - items:
> >            - enum:
> > +              - fsl,imx8mn-usdhc
> > +              - fsl,imx8mp-usdhc
> >                - fsl,imx93-usdhc
> >                - fsl,imx8ulp-usdhc
> >            - const: fsl,imx8mm-usdhc
>
>
> Best regards,
> Krzysztof
