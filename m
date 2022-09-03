Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354FC5ABC28
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 03:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiICBre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 21:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiICBrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 21:47:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A386F98597;
        Fri,  2 Sep 2022 18:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B14FB82D04;
        Sat,  3 Sep 2022 01:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1B4C43143;
        Sat,  3 Sep 2022 01:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662169649;
        bh=VNBkhEB8UPfoUwOuvNFnhvuSY23Yrnn4bJB/p03igJk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Svvz2igDlSL16t93hNVhmn2vybHyovMu/IQCMkIGskRbLAHpPb1+8FqGipg/4LUwL
         /x2Pf8BEUAwZgvUD3iiKMi2qiD8ryckF1wjzqw8sTJ2cnNrEf+DHn397ua3G6n3eEY
         ti1BZ8V4sBd8LNv7wQJoaI+wVu1JnUU9wnVF43GWEmPv9N090Ag+1fSJjIxpxxAtHd
         Oc+bGKvAMOr70pkjT1mWJqKTGgyuHJ9QcxEtWCwuTvekqBtXDjbiykUIiOvfvCLKbv
         xNGk6xj2Wcq7EsyUW2Iy21cQFJCRq7zWepE5WKaFbGO0VzDjZROnxgv/dsPeUB7CRm
         2lAtABGGuM59Q==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1225219ee46so9082121fac.2;
        Fri, 02 Sep 2022 18:47:29 -0700 (PDT)
X-Gm-Message-State: ACgBeo3Cvz5I4O5JGmRUTb3XIDFWO0Ice4Egt2MPpGxgf4uW2Jl/gpPM
        yTgdaD1BWoL0RxEleHdqG/n0KMkNwiUue8PVkHM=
X-Google-Smtp-Source: AA6agR7uBZjGjvrcNdzmuJlzw5xUBuMmrZJ+0OH5DKLIHefCkqDgmDAGVH8PW+vusGn4PdORlmIERJN1HvALZ0R+0nQ=
X-Received: by 2002:a05:6808:1687:b0:347:cbd3:3dcf with SMTP id
 bb7-20020a056808168700b00347cbd33dcfmr3046504oib.53.1662169648293; Fri, 02
 Sep 2022 18:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220819094354.247273-1-marcel@ziswiler.com> <20220903014337.GA1728671@dragon>
In-Reply-To: <20220903014337.GA1728671@dragon>
From:   Shawn Guo <shawnguo@kernel.org>
Date:   Sat, 3 Sep 2022 09:47:17 +0800
X-Gmail-Original-Message-ID: <CAJBJ56+1_1fgtb+X7PHZuJ+9zpEsTU5Pm13rAvO6S3LwqX3SJA@mail.gmail.com>
Message-ID: <CAJBJ56+1_1fgtb+X7PHZuJ+9zpEsTU5Pm13rAvO6S3LwqX3SJA@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: dts: vf610: ddr pinmux
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 3, 2022 at 9:43 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Fri, Aug 19, 2022 at 11:43:54AM +0200, Marcel Ziswiler wrote:
> > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> >
> > Add DDR pinmux which may be used in U-Boot after synchronising all
> > them device trees (and includes) from Linux.
> >
> > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> >
> > ---
> >
> >  arch/arm/boot/dts/vf610-pinfunc.h | 52 ++++++++++++++++++++++++++++++-
> >  1 file changed, 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/vf610-pinfunc.h b/arch/arm/boot/dts/vf610-pinfunc.h
> > index f1e5a7cf58a9..b7b7322a2d1b 100644
> > --- a/arch/arm/boot/dts/vf610-pinfunc.h
> > +++ b/arch/arm/boot/dts/vf610-pinfunc.h
> > @@ -420,7 +420,7 @@
> >  #define VF610_PAD_PTD29__FTM3_CH2            0x104 0x000 ALT4 0x0
> >  #define VF610_PAD_PTD29__DSPI2_SIN           0x104 0x000 ALT5 0x0
> >  #define VF610_PAD_PTD29__DEBUG_OUT11         0x104 0x000 ALT7 0x0
> > -#define VF610_PAD_PTD28__GPIO_66             0x108 0x000 ALT0 0x0
> > +#define VF610_PAD_PTD28__GPIO_66             0x108 0x000 ALT0 0x0
>
> I mentioned this white-space fix in the commit log.

Ah, never mind, you actually had another patch for this change.

Shawn
