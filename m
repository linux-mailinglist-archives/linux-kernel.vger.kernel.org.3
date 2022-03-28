Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39914E96EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242617AbiC1Mrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237500AbiC1Mre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:47:34 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5273E4D638;
        Mon, 28 Mar 2022 05:45:53 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u26so16736479eda.12;
        Mon, 28 Mar 2022 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GzAXCiHKn740WB88VYaXEioW9TMP9IG2kbGPT2sCHE=;
        b=FM8dC5tQYBxg/a9sOblYTVnlbCPwqFdeyQ5ziyOF1PY3H389hZlkzBLbqqy8MwXXAf
         A+dJ+5NOCrBZejlUxbBgQKMOG76kY43DIhH7GNulNDyEM2BWJCrTyjf/fCrvdVV4zNUA
         0xUtrt5k4+5+zra4dHdxU7U0iCMWR13OIruhPGOnrjXswbQFT97Fqp5PP3oZUw7el4Mg
         Sajnpa+xlRqcHYjW/IFTWvlC0Y1LNc38/xUHs6XEG17/JhozHq+3IF3NrsdcdOvrF8mj
         mU/J6sIX1KmyXwzXQrdyPTsx+QbZuik7yZiPsB4vGQeO4Wd/DsLQJ/Xp1Aj4bp1m3KYj
         4+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GzAXCiHKn740WB88VYaXEioW9TMP9IG2kbGPT2sCHE=;
        b=Rws3CDUSt6cqfSqau94G/bKM2rCWbapsoLdf2yBrhIL4gVPXhat6RUjaOBQBC8uJMf
         SgBNFJ5FMThUPhFFXo3II/Zf/phGfJ3m8XuPV2DjwSRk/Yrly/2Sa1fM9x480muRl9xQ
         4IWWog/r5M+JQLp+LrV7ZCzBHUPzUhNA0x4tg8B7FeIMdWfIrTfjN3As3NCyiwiCBv/x
         1Q1fPbMzxCO6e2mVUJn0k+eVXZ6NEgVMXbKr3adjN4g3hMqZbIdOsLoza4Leij7WVxV3
         cpDcZYmDFED6BtYwozVkJs+SFrbgGXlSYGgYg6/+jnLGwJqD2t85pQuxKiCvgRgyAznx
         9o5g==
X-Gm-Message-State: AOAM532NtK8rFw8Cr+ikqrrTO3AzklaYUODPurlc/5oI94qdbfZFUjtu
        UPB3xg6HY2jdh+vjs8OlfvxMdPOHTnWBPyvVpfs=
X-Google-Smtp-Source: ABdhPJz90iB17mVjeopA5CGT2QyLyR4w0yF6S9hmFgwrdk/BNJza7oZqY0QP8HkpjT6efjW64Ha/d+eWXtCw8wKKMHY=
X-Received: by 2002:aa7:c64c:0:b0:418:ecf7:afaa with SMTP id
 z12-20020aa7c64c000000b00418ecf7afaamr16277961edr.38.1648471551479; Mon, 28
 Mar 2022 05:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220327123835.28329-1-aford173@gmail.com> <20220327123835.28329-3-aford173@gmail.com>
 <c964bf2c-f7bf-451c-1691-02903f20c634@pengutronix.de> <CAHCN7xL05pBK0uK7zuE7Uq4P9Rzo6bHbJdbOt5XnQRB7Sh3msw@mail.gmail.com>
 <74e74ea8-1554-bf08-b0ea-36e77259cb18@pengutronix.de> <5c24c12b-3a12-1e18-9f03-2c54cad30bf9@kernel.org>
In-Reply-To: <5c24c12b-3a12-1e18-9f03-2c54cad30bf9@kernel.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 28 Mar 2022 07:45:40 -0500
Message-ID: <CAHCN7xJ28t3igV8uHWfLxJx6wWkwzojg-d0QTTZM9jdfGCbTzw@mail.gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: imx8mp: Enable HS400-ES
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
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

On Mon, Mar 28, 2022 at 6:49 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 28/03/2022 13:09, Ahmad Fatoum wrote:
> > Hello Adam,
> >
> > On 28.03.22 12:47, Adam Ford wrote:
> >> On Mon, Mar 28, 2022 at 2:20 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>>
> >>> Hello Adam,
> >>>
> >>> On 27.03.22 14:38, Adam Ford wrote:
> >>>> The SDHC controller in the imx8mp has the same controller
> >>>> as the imx8mm which supports HS400-ES. Change the compatible
> >>>> fallback to imx8mm to enable it.
> >>>
> >>> I believe that's a shortcoming of the Linux driver, which should explicitly list
> >>> fsl,imx8mp-usdhc in its compatibles and enable HS400-ES for it.
> >>>
> >>> I find dropping compatibles problematic, because like Linux matching
> >>> fsl,imx8mm-usdhc, but not fsl,imx8mp-usdhc, other software may match
> >>> fsl,imx7d-usdhc, but not fsl,imx8[mp]-usdhc.
> >>>
> >>> I'd prefer that either the kernel driver gains extra compatibles or that
> >>> the DTS lists extra compatibles and we refrain from dropping existing
> >>> (correct) ones.
> >>>
> >>
> >> I would argue that imx7d is not correct since the IP blocks between
> >> imx7d and imx8mm have different flags/quirks.  One of which includes
> >> HS400-ES, but there are other differences as well.
> >
> > The DTS currently says that an fsl,imx7d-usdhc is a subset of an
> > fsl,imx8mm-usdhc. So a driver could treat both HW the exact same
> > by focusing on the i.MX7D parts. Linux apparently did exactly
> > that so far. Is this not accurate?
> >
> >
> >>> What do you think?
> >>
> >> From my understanding of the fallback compatibility strings is to
> >> avoid having to add more and more compatible strings to the drivers
> >> when they do not serve a functional purpose. Based On a conversation
> >> with Krzysztof [1], he suggested we update the YAML file based on the
> >> fallback, but he wanted NXP to give their feedback as to what the
> >> right fallback strings should be.  Haibo from NXP sent me a hierarchy
> >> [1] which is what I used to update the YAML file.  Based on the YAML
> >> file, the fallback in each DTSI file was updated to ensure the use of
> >> the proper IP block.
> >
> > Myself I am in favor of moving to three compatibles instead of dropping one.
> > For some theoretical fsl,imx8mf-usdhc that's supposed to be exactly the same
> > as a fsl,imx8mm-usdhc, I don't mind omitting the fsl,imx7d-usdhc compatible,
> > but for existing device trees, this may introduce needless potential breakage
> > for other software that also uses Linux device trees.
> >
>
> Affecting existing users is indeed a concern with this approach, because
> in-kernel DTS might be used in other projects as well.
>
> I still cannot find here the answer whether fsl,imx8mm-usdhc is actually
> compatible with fsl,imx7d-usdhc. It's not about driver, but about
> hardware and programming model. imx8mm can support additional features
> and still be compatible with imx7d. However if any flags of imx7d are
> actually not valid for imx8mm, then it's different case.

The imx7d flags are:
 ESDHC_FLAG_USDHC
ESDHC_FLAG_STD_TUNING
 ESDHC_FLAG_HAVE_CAP1
ESDHC_FLAG_HS200
 ESDHC_FLAG_HS400
 ESDHC_FLAG_STATE_LOST_IN_LPMODE
 ESDHC_FLAG_BROKEN_AUTO_CMD23,

The imx8mm flags are:
 ESDHC_FLAG_USDHC
 ESDHC_FLAG_STD_TUNING
 ESDHC_FLAG_HAVE_CAP1
ESDHC_FLAG_HS200
 ESDHC_FLAG_HS400
 ESDHC_FLAG_HS400_ES
 ESDHC_FLAG_STATE_LOST_IN_LPMODE

It does not have the ESDHC_FLAG_BROKEN_AUTO_CMD23 that is present in the imx7d.

Maybe Haibo can comment on whether or not that would be an issue for the 8m[mnp]

I will defer to Krzysztof and Haibo as to the proper method that we
should add HS400-ES.  I don't have an issue adding the imx8mn or
imx8mp compatible flags to the esdhc driver if that's the decision.
If that is the decision, my follow-up question would be how the YAML
should look, and if it needs to change at all.

adam

>
>
> Best regards,
> Krzysztof
