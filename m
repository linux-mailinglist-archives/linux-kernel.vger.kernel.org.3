Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC3852C682
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiERWq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiERWq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:46:26 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5B07DE23;
        Wed, 18 May 2022 15:46:25 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id q135so6093612ybg.10;
        Wed, 18 May 2022 15:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r48GKaexilEZNN+sQI3f0KxD7Fc9KKp25yevrNkJt6M=;
        b=Uzpo+Wgkuo7R9nwjoHz1Ywf5spGLvNmVK+Xc6NxnoGeZGsW9V8khu/KycVadRKaXiy
         iq3kVj+dY8e4KMrH8HSV5JV/KPPFunpcLjWea7QhqBHGggAcffOYB2Frt9evVt/HhO2Y
         0mulST3hR6HRg4ftUvKogatrBdZfVpv2crnQuJml1ybZmKZl2IRfEam1UbH4Fx5sR9GC
         ARYrsqhHqqY40hR95yK83uSNwJfkOYJoQDmM5Axo3wMICESqCKQ1dVYgAzqypMr8X8FG
         a5E6revze3QNx75jZgt2mFBXg70+yGgDA1RC+Xd+9z9CclvEK2CPPj8s4XAUsjliPJZa
         p1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r48GKaexilEZNN+sQI3f0KxD7Fc9KKp25yevrNkJt6M=;
        b=Msogf2aF+VwbXxeH/WG8iErOR5qsUImIkPLZWVWm/SUkDE34iatdYRJKZ2Sq5/lvRL
         x+0Ws6VO3q7RvlTaHGwXHDMmEV87bhdkDwpkII0aCEWtF5K8gQmsy+5XKnzFyGm88oMA
         gMgrQlTZZkkZFetLO3nCLimWMKyEHN0Ro5II+hRVVXRh3VnDzVoSLlzzR65Y5F6keczR
         m4vi+AyegTVj2WESP+pQk8XpVeP5MEjmGQ9QMQVZ5EPmMXgxwzJIrcWrfYBQFnv82sa4
         BMoCDiYeClw7cfq+q6piVFkGRcz+OzdHpjSYrD1hKq2rtI+x8vT86vd0/l0aidJScwHN
         ftJQ==
X-Gm-Message-State: AOAM533uiE6pa45OCBjpfJ9MtgkwszDnX2ERq8NOBjtI2CEDxNv9Mb8e
        6Zs3zT8+NWeKIfCzmZY2ONT4IulRce7wpzp/PBFKhiEl
X-Google-Smtp-Source: ABdhPJye/mYo5nOX2hmyGqdD1Ru3j/LwxF30VPrIqOSRotDqSuRuVEvHLiMrmLPSBPHAaE7iXLfqSf7LfaQf75CdokM=
X-Received: by 2002:a25:748b:0:b0:64d:b0ec:2c68 with SMTP id
 p133-20020a25748b000000b0064db0ec2c68mr1790213ybc.173.1652913984223; Wed, 18
 May 2022 15:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220415104951.27104-1-linux@fw-web.de> <20220415104951.27104-2-linux@fw-web.de>
 <11363549.CDJkKcVGEf@phil>
In-Reply-To: <11363549.CDJkKcVGEf@phil>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 18 May 2022 18:46:12 -0400
Message-ID: <CAMdYzYqOEzNqwwRWx2U85uBBXtkz3OfVEWXDS-YCGmFg8Z7q5Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: set display regulators to
 always-on on BPI-R2-Pro
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 2:47 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Freitag, 15. April 2022, 12:49:49 CEST schrieb Frank Wunderlich:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > Set display related regulators to always-on on Banana PI R2 Pro
> > board.
>
> Hmm, I'd expect some sort of explanation for the "why" here.
> It looks like both the gpu patch as well as the vop patch do
> reference the relevant regulators for the gpu+hdmi nodes,
> so in theory this shouldn't be necessary anymore?

I agree the hdmi power nodes don't need to be always on, if the hdmi
driver is handling them correctly. Unfortunately the gpu power supply
needs to stay always on until the issues with power-domains not being
regulator aware is resolved. Otherwise we run into issues like the one
mentioned in Lee's email, and issues where the gpu-regulator gets shut
down and we start getting mmu faults.

>
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> > index 2700fb18a3bc..0950f9659bb4 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> > @@ -225,6 +225,7 @@ regulator-state-mem {
> >
> >                       vdd_gpu: DCDC_REG2 {
> >                               regulator-name = "vdd_gpu";
> > +                             regulator-always-on;
> >                               regulator-init-microvolt = <900000>;
> >                               regulator-initial-mode = <0x2>;
> >                               regulator-min-microvolt = <500000>;
> > @@ -274,6 +275,7 @@ regulator-state-mem {
> >
> >                       vdda0v9_image: LDO_REG1 {
> >                               regulator-name = "vdda0v9_image";
> > +                             regulator-always-on;
> >                               regulator-min-microvolt = <900000>;
> >                               regulator-max-microvolt = <900000>;
> >
> > @@ -369,6 +371,7 @@ regulator-state-mem {
> >
> >                       vcca1v8_image: LDO_REG9 {
> >                               regulator-name = "vcca1v8_image";
> > +                             regulator-always-on;
> >                               regulator-min-microvolt = <1800000>;
> >                               regulator-max-microvolt = <1800000>;
> >
> >
>
>
>
>
