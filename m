Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEB54E5763
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343523AbiCWRZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbiCWRY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:24:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872515D5D2;
        Wed, 23 Mar 2022 10:23:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b24so2663459edu.10;
        Wed, 23 Mar 2022 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=juL17s/J9mHVgJHyYqq8vpqD2uO1Y1nLtpoOVNs7FRw=;
        b=lAFBZ8r8drRioCv3odbctBgVd5UXVvEZNxPD/cyYarQZ0akXdf+zZURhaa42WuRsC9
         1nTAwT6OpMQENK6Ho4GBKKZ/hZa511Pc5vW0yHzYTMEOKsAePNbwRYZLqieKRji5HekH
         3yRi7Lvv2Fo5VcfcbrNfl34KJiwvpIvB+BkVrTWaMnAojaGZSSpNDLWJcAtlkA5u2njt
         ZRUf6aAkfZT+Kgq3U9BAowcmCrhdTbPZQNKgmNIgAV2Wzhljs6ZsH0B+mtYpwhHe97lZ
         pVS5UxfJIkIimYwK4rIupe86mSI/sFwHi7Q4/7ilUxPC4XaaKFzK/JW+/603iTjn7K22
         WhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=juL17s/J9mHVgJHyYqq8vpqD2uO1Y1nLtpoOVNs7FRw=;
        b=Ir33r7Ue0NilSh4DwEmwtdJltv5tkTpLad2cxEr/jWM6seRKLk9m7Bn0OLvC3GVVRk
         u4iee9KuuMHk3MQTIQ97gp93SKqMJa0+v0mHalgUaju7MxzMRifhWHtLj/leniIKmOH5
         DBmbEOSwr8ujsC2p7Vl+v+M//UwOA8E/qbko9IFgmyoDCwi5FHuXz2VoL5SrCAxgHNQa
         jvzpGmxlkWOjDeg7t0ZUVEKTMYxR6vuMtlHqD9wCuvgYry9mZj6mcE2sdWfs1+R/GLWa
         rniMaWhEIggZCeOPGcosFmEoAzPC5ZQJFJFw6LIJW8oYtUtrPr4jyRCNzL3u465zssHP
         hLAA==
X-Gm-Message-State: AOAM532drBDvt+4t1dtd3/3Z8u75kpioAeNNwP4RmRo4tva/NAHRqH1o
        jHxFxb1aNbCY3ZXu/OLglyVk0Tt/MoiMegHT7SjZm1Ps
X-Google-Smtp-Source: ABdhPJyft3K9bCkUSLrNX6JZW9BLNtJ57TArhGm3JaTHjtmeZOA2hxLe9EQ03TB1Tv8j4DwJrud2AiOB1S7a0xyZtUU=
X-Received: by 2002:a05:6402:2142:b0:413:6531:bd9e with SMTP id
 bq2-20020a056402214200b004136531bd9emr1464059edb.5.1648056207837; Wed, 23 Mar
 2022 10:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220323134019.3796178-1-aford173@gmail.com> <35f58894-ed6d-0af0-e483-7a161ad6625a@kernel.org>
 <CAHCN7x+RLAFnES8b3UMoc6n69ZVSFGOmAZyMeeY1g3aoiDNbZg@mail.gmail.com> <354951e0-d2a8-bf4f-e0c5-081e836bb3c3@kernel.org>
In-Reply-To: <354951e0-d2a8-bf4f-e0c5-081e836bb3c3@kernel.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 23 Mar 2022 12:23:16 -0500
Message-ID: <CAHCN7xLWoUGi-jfxR2a0gvEFkPT3USUEb+8U3CCqCb5wWEJ8xw@mail.gmail.com>
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

On Wed, Mar 23, 2022 at 9:11 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 23/03/2022 15:00, Adam Ford wrote:
> > On Wed, Mar 23, 2022 at 8:56 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On 23/03/2022 14:40, Adam Ford wrote:
> >>> The SDHC controller in the imx8mn and imx8mp have the same controller
> >>> as the imx8mm which is slightly different than that of the imx7d.
> >>> Using the fallback of the imx8mm enables the controllers to support
> >>> HS400-ES which is not available on the imx7d.
> >>>
> >>> Signed-off-by: Adam Ford <aford173@gmail.com>
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> >>> index 7dbbcae9485c..d6ea73d76bdd 100644
> >>> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> >>> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> >>> @@ -39,14 +39,14 @@ properties:
> >>>        - items:
> >>>            - enum:
> >>>                - fsl,imx8mm-usdhc
> >>
> >> Your change looks reasonable, but why imx8mm is compatible with imx7d?
> >
> > I saw that, and I wasn't sure the best way to go about  fixing it.  If
> > I move the 8mm out of the imx7d category, do I need to add it to the
> > enum list associated with the imx8mm, or can I just delete it from the
> > enum leaving the const for imx8mm good enough?
> >
>
> The DTS is using:
>   compatible = "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc"
> which looks incorrect, based on what you wrote in commit description.
> Since fsl,imx8mm-usdhc has its own compatibility-group and defines the
> properties for entire family (imx8mm + imx8mn + imx8mp), then I would
> assume that either fsl,imx8mm-usdhc is not be compatible with imx7d or
> everything is compatible with imx7d. IOW, DTS and bindings should be
> changed to one of following:
> 1. Everything compatible with imx7d:
>   compatible = "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
>   compatible = "fsl,imx8mq-usdhc", "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";
>
> 2. A new group:
>   compatible = "fsl,imx8mm-usdhc";
>   compatible = "fsl,imx8mq-usdhc", "fsl,imx8mm-usdhc";
>
> Which one, I am not sure. My commit 80fd350b95 organized it in (1)
> approach, because also that time there was no new group for 8mm (added
> in commit 431fae8). I assume NXP engineer knows better, so the better
> solution would be (2). In such case, imx8mm has to be moved to the first
> enum and all DTS have to be adjusted.

I pulled NXP's downtream kernel based on 5.15.y, and grepped the code
for imx8mm-usdhc.  It looks like the imx8mm, imx8mn, imx8mp, and
imx8ulp use the imx8mm compatible flag.
The imx8mq uses the older imx7d.  I'll do a second revision later
today or tomorrow.  Looking inside the driver, it appears there are
some other quirks that different between the imx7d and imx8mm beyond
just support for HS400-ES, so I think your option 2 is appropriate.
Hopefully someone from NXP can comment.

adam
>
>
> Best regards,
> Krzysztof
