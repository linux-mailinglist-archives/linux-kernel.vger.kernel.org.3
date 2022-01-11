Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D83F48B49E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344696AbiAKRxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbiAKRxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:53:41 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE1DC061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:53:41 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c3so18376010pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+mGatMIL4VwyqgHTcP6kkKtTRPzLU2meJOf8t3nLgc=;
        b=C5z7M9LZemOKJQ9H06SLYyc7uhsDmzRdafOKFa/IooHAH7N5BeqFJPwtoi1wQKd05L
         K5LWhOvY9B+ks3D8wudjCZm4kZVgdBNyOZTQFZ/rkROeHf+lxMs16Ff8A2LTmI4AUo78
         GyUtfoZFce02luLPwE+IAyqhkfq7WZvZy6azLkaxaxeoa3dvDEZHZXmc3rHFXwSeLqnd
         3EnGaKzzEtINFoiDK4wFCt2zuSjYSevXPxvpuKU5pNnjnnVtpo7rvTeDZ0Mse5h3lEzq
         lGNso8PppUyUoJaXHwpWow14ZtpVlt+JGE67831+jvrDdLFn0snhRV43EnOEENwbdhW0
         bdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+mGatMIL4VwyqgHTcP6kkKtTRPzLU2meJOf8t3nLgc=;
        b=wLSfPqi9IuL1LTyISKyoIzbXVJP4wiheToMU9rwLtHh7WiGED+EzS6VLd91RRiJnJy
         LymvbHBPeC4/QQ++LfY29UMtceKGsS06OCY5LEXPVbZCjkUFoFgcIrAq5eWz40ckUfuA
         EHCSEj9N/utgqG0yJjzuyijRy8x+8a8ToOJmDCA2IOQUvTqMUJXDQnG7E++A2pCD1xVV
         tyXK5Itvp3omhPAoZDlNvXpznBUdMvtGYx41obZy5Wj6rDtP7fS0cJdY7+G1syebRC6I
         NdcfA1EIdsuqNtiVkE3cIxjQyoNoEs9y7SB9Fz+v7uivu9iWge1vgEUsae1vRlmXeRsm
         TTUw==
X-Gm-Message-State: AOAM5339hfO8RegzYBhpVf5ltUkJ5wV3EQUSJsapzQ1+4gtQq8aktAs2
        f7neska/oyO9OkHH6jQaRJ+rdIadftYT1wiNI7c4fA==
X-Google-Smtp-Source: ABdhPJxWuP0nvl+xWI5neKPU9cGsEPMSq/AaHNLRfRZrjvhEFVjJFM1JDRJ+8q0InOrCgUtv2Z72h6eUIYhv0MCea+8=
X-Received: by 2002:a17:902:ceca:b0:14a:3eba:41ed with SMTP id
 d10-20020a170902ceca00b0014a3eba41edmr5394056plg.118.1641923621108; Tue, 11
 Jan 2022 09:53:41 -0800 (PST)
MIME-Version: 1.0
References: <20211214213630.14819-1-tharvey@gateworks.com> <CAJ+vNU0U7HknAZcnua39r9to+kJBea6Fg3NiJ9ybZ1xygKoF4g@mail.gmail.com>
 <2226437.ElGaqSPkdT@steina-w>
In-Reply-To: <2226437.ElGaqSPkdT@steina-w>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 11 Jan 2022 09:53:29 -0800
Message-ID: <CAJ+vNU2PxF=9VwMv4f8N5W5Gs2Ynxdn9jHTSkWH7zd3Fo5hBiw@mail.gmail.com>
Subject: Re: (EXT) Re: [PATCH] arm64: dts: imx8mm-venice-gw73xx-0x: add dt
 overlays for serial modes
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:20 PM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Am Dienstag, 11. Januar 2022, 01:00:21 CET schrieb Tim Harvey:
> > [SNIP]
> > > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > > b/arch/arm64/boot/dts/freescale/Makefile index a14a6173b765..5ec8d59347b6
> > > 100644
> > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > @@ -44,6 +44,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
> > >
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw71xx-0x.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x.dtb
> > >
> > > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs232-rts.dtbo
> > > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs422.dtbo
> > > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs485.dtbo
> > >
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7901.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw7902.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-beacon-kit.dtb
> > >
> > [SNIP]
> > I'm mostly interested to see if my approach to dt fragments here and
> > the naming of the files makes sense to others.
> >
> > This patch causes the kernel to build dtbo files for:
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtbo
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtbo
> > arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtbo
> >
> > The intention is that these files are used by boot firmware (U-Boot)
> > to adjust the dtb before passing it to the kernel.
>
> Hi Tim,
>
> do these dtbo actually work? I'm wondering because I was trying to useoverlays
> myself and noticed that the had to be compiled with -@ for u-boot to be able
> to apply them. Apparently there are 2 possibilities:

Alexander,

Yes, they work, but I do manually set DTC_FLAGS=-@ when building
kernel dtbs to make them work.

> * Set "DTC_FLAGS_[dtb] := -@" yourself
> See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> commit/?id=e426d63e752bdbe7d5ba2d872319dde9ab844a07
>
> * Use dedicated overlay target
> See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> commit/?id=15d16d6dadf6947ac7f9a686c615995c5a426ce2
>
> You use neither of them. IIRC just naming the target file .dtbo will not apply
> symbols (-Q) during dtc call. Can you verify using 'V=1'
> Also I'm wondering which way is the best to go.
>

I wasn't aware there was a way to do this via Makefiles. It seems that
perhaps Rob's approach with 'kbuild: Add generic rule to apply
fdtoverlay' is a way to avoid having to add them all manually in the
first approach? I must admit I'm not sure how to use that.

Best regards,

Tim
