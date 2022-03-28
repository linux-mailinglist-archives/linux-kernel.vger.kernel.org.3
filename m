Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEDF4E9778
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241971AbiC1NJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbiC1NJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:09:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7897A5DA68;
        Mon, 28 Mar 2022 06:07:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b15so16846495edn.4;
        Mon, 28 Mar 2022 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNfsrLmx/5q90lbCKlS7ErLvGKCOjJ1/q+sTtsEgIeE=;
        b=mnZIsI4PSyWO7T8P41vMW5cuZPFFACt4jTrXsiruuRx3JW1oZ8BFxh8UKHNdfORpj/
         GtHhhVAyaKf97xx6pSzYZcARl21K50Z8DdJLB5+vxowc2B04PZFVY0AojbzesbjhMjb9
         ATYrm+rk3ZOV+W+FjXcLh4DUUuzEMzvtD0IZOwbCvDvWtR7pYuazyHSl1daJEVSC0Xhc
         bLqLjtuBi6coAcLGRUhFp26f2vzKaif3ICJzmpuUQDvnJ3zRSMpv2pBfBQ7jgBKAHkv6
         I4qzEXwgz75rcwGliV4eE0zfnmx1aDctboKqL/3bYfELHUJsqr5tyAWu0Vfe8clV2Fk6
         bk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNfsrLmx/5q90lbCKlS7ErLvGKCOjJ1/q+sTtsEgIeE=;
        b=5XAXExaN8mmD04blnVyzppMi2uxNVDuWaikmDGlzx7iVyfhdo9S6zhj/kJUATlHC+h
         QEFa09G3sm46+VOXdp8fcuGOYkuRHYfGd6YYyCqLaq+whQMn2oPm6MDc7NpAuFhdd1vJ
         QuOvFzzoz9WBnKLuofrQb/f+Gf0Ui8q3vBHAyFxWybNHN3jk2wafsBNAkcoh8zt55AFC
         WcXeVDJRLGZObgmITmtOFyb/56EmD+BJ4lcn774ieVxPibcdJ8rfSWKZa6QDYg5hbRB6
         alBntTAKlYog/lc9zsleE8C8IO/ytTTDty6As8iHHEoxEO8BOPELXR7mSBsyWc/oa29j
         y/5g==
X-Gm-Message-State: AOAM530qagj75nKEEPX/Jv8IPUJ9duCtj9CZDyYtrKshFuRcEufY0Lcm
        8Sw/HRNwfKTXmw6lDW/oYug6Rp5B4vMCuTxsMU0aN617ZCc=
X-Google-Smtp-Source: ABdhPJxdDup+7gg0d6Z1huyWsROwg7tN2X+wg3HA93QkKetKCp0e0RBJyTYnO/Yj14GwV6zLuSpyg/SW4LIfuw77wDs=
X-Received: by 2002:aa7:cb18:0:b0:413:3a7a:b5d6 with SMTP id
 s24-20020aa7cb18000000b004133a7ab5d6mr15886561edt.254.1648472815207; Mon, 28
 Mar 2022 06:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220327123835.28329-1-aford173@gmail.com> <20220327123835.28329-3-aford173@gmail.com>
 <c964bf2c-f7bf-451c-1691-02903f20c634@pengutronix.de> <CAHCN7xL05pBK0uK7zuE7Uq4P9Rzo6bHbJdbOt5XnQRB7Sh3msw@mail.gmail.com>
 <74e74ea8-1554-bf08-b0ea-36e77259cb18@pengutronix.de> <5c24c12b-3a12-1e18-9f03-2c54cad30bf9@kernel.org>
 <CAHCN7xJ28t3igV8uHWfLxJx6wWkwzojg-d0QTTZM9jdfGCbTzw@mail.gmail.com> <5282b39b-85d5-81d6-10d5-a45c66d4d4e9@kernel.org>
In-Reply-To: <5282b39b-85d5-81d6-10d5-a45c66d4d4e9@kernel.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 28 Mar 2022 08:06:43 -0500
Message-ID: <CAHCN7x+VZgf3omXek_8wQ9XvZ7tvq5oSENxZNr-pCPdiikZ-Sw@mail.gmail.com>
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

On Mon, Mar 28, 2022 at 7:56 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 28/03/2022 14:45, Adam Ford wrote:
> > On Mon, Mar 28, 2022 at 6:49 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On 28/03/2022 13:09, Ahmad Fatoum wrote:
> >>> Hello Adam,
> >>>
> >>> On 28.03.22 12:47, Adam Ford wrote:
> >>>> On Mon, Mar 28, 2022 at 2:20 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>>>>
> >>>>> Hello Adam,
> >>>>>
> >>>>> On 27.03.22 14:38, Adam Ford wrote:
> >>>>>> The SDHC controller in the imx8mp has the same controller
> >>>>>> as the imx8mm which supports HS400-ES. Change the compatible
> >>>>>> fallback to imx8mm to enable it.
> >>>>>
> >>>>> I believe that's a shortcoming of the Linux driver, which should explicitly list
> >>>>> fsl,imx8mp-usdhc in its compatibles and enable HS400-ES for it.
> >>>>>
> >>>>> I find dropping compatibles problematic, because like Linux matching
> >>>>> fsl,imx8mm-usdhc, but not fsl,imx8mp-usdhc, other software may match
> >>>>> fsl,imx7d-usdhc, but not fsl,imx8[mp]-usdhc.
> >>>>>
> >>>>> I'd prefer that either the kernel driver gains extra compatibles or that
> >>>>> the DTS lists extra compatibles and we refrain from dropping existing
> >>>>> (correct) ones.
> >>>>>
> >>>>
> >>>> I would argue that imx7d is not correct since the IP blocks between
> >>>> imx7d and imx8mm have different flags/quirks.  One of which includes
> >>>> HS400-ES, but there are other differences as well.
> >>>
> >>> The DTS currently says that an fsl,imx7d-usdhc is a subset of an
> >>> fsl,imx8mm-usdhc. So a driver could treat both HW the exact same
> >>> by focusing on the i.MX7D parts. Linux apparently did exactly
> >>> that so far. Is this not accurate?
> >>>
> >>>
> >>>>> What do you think?
> >>>>
> >>>> From my understanding of the fallback compatibility strings is to
> >>>> avoid having to add more and more compatible strings to the drivers
> >>>> when they do not serve a functional purpose. Based On a conversation
> >>>> with Krzysztof [1], he suggested we update the YAML file based on the
> >>>> fallback, but he wanted NXP to give their feedback as to what the
> >>>> right fallback strings should be.  Haibo from NXP sent me a hierarchy
> >>>> [1] which is what I used to update the YAML file.  Based on the YAML
> >>>> file, the fallback in each DTSI file was updated to ensure the use of
> >>>> the proper IP block.
> >>>
> >>> Myself I am in favor of moving to three compatibles instead of dropping one.
> >>> For some theoretical fsl,imx8mf-usdhc that's supposed to be exactly the same
> >>> as a fsl,imx8mm-usdhc, I don't mind omitting the fsl,imx7d-usdhc compatible,
> >>> but for existing device trees, this may introduce needless potential breakage
> >>> for other software that also uses Linux device trees.
> >>>
> >>
> >> Affecting existing users is indeed a concern with this approach, because
> >> in-kernel DTS might be used in other projects as well.
> >>
> >> I still cannot find here the answer whether fsl,imx8mm-usdhc is actually
> >> compatible with fsl,imx7d-usdhc. It's not about driver, but about
> >> hardware and programming model. imx8mm can support additional features
> >> and still be compatible with imx7d. However if any flags of imx7d are
> >> actually not valid for imx8mm, then it's different case.
> >
> > The imx7d flags are:
> >  ESDHC_FLAG_USDHC
> > ESDHC_FLAG_STD_TUNING
> >  ESDHC_FLAG_HAVE_CAP1
> > ESDHC_FLAG_HS200
> >  ESDHC_FLAG_HS400
> >  ESDHC_FLAG_STATE_LOST_IN_LPMODE
> >  ESDHC_FLAG_BROKEN_AUTO_CMD23,
> >
> > The imx8mm flags are:
> >  ESDHC_FLAG_USDHC
> >  ESDHC_FLAG_STD_TUNING
> >  ESDHC_FLAG_HAVE_CAP1
> > ESDHC_FLAG_HS200
> >  ESDHC_FLAG_HS400
> >  ESDHC_FLAG_HS400_ES
> >  ESDHC_FLAG_STATE_LOST_IN_LPMODE
> >
> > It does not have the ESDHC_FLAG_BROKEN_AUTO_CMD23 that is present in the imx7d.
>
> AFAIU, it looks imx8mm is compatible with imx7d, because the broken
> acmd23 only limits the features. If imx8mm binds according to imx7d, it
> will not support acmd23 and HS400-ES.
>
> Having three compatibles is therefore also OK.
>
> You could also add two cases:
> 1. three compatibles, deprecated: True,
> 2. two compatibles, without imx7d.
>
> Existing DTS stays with three compatibles for two years and later gets
> converted to two compatibles. New DTS should use two compatibles.
>
> It's quite a lot of churn, but would make in the long term bindings
> correct and also not break other users/projects.
>
> >
> > Maybe Haibo can comment on whether or not that would be an issue for the 8m[mnp]
> >
> > I will defer to Krzysztof and Haibo as to the proper method that we
> > should add HS400-ES.  I don't have an issue adding the imx8mn or
> > imx8mp compatible flags to the esdhc driver if that's the decision.
>
> I don't get what's the problem with HS400-ES. In any case (your patch
> here, other ideas) your DTS will bind to imx8mm-usdhc which has HS400-ES.

I was under the impression Ahmad didn't want me to add the imx8mm
compatible to the DTS, but instead, add the imx8mp compatible into the
driver so it binds directly to an imx8mp.
Based on that, I was assuming this patch series would be rejected and
I sould focus on just the driver file itself

From what I am reading from you, I should make the imx8mn and imx8mp
device trees respectively read:

compatible = "fsl,imx8mn-usdhc", "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";

and

compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc", "fsl,imx7d-usdhc";

If that's true, do I need to change the YAML at all?

adam
>
> Best regards,
> Krzysztof
