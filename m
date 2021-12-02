Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36750466A11
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376361AbhLBS5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348584AbhLBS5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:57:35 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A810FC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 10:54:12 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 137so669154pgg.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6IwGVqZy1REKUxcBFcG80oGR30x3aLwEIoJpVG9B4BI=;
        b=l5FrpB2is2mD+Yvpy6mRKdZR+EZBJcnDMdo9rskXBUM4JYrQxzVeRqom4ewzKqsbGg
         90ceyu/O/mYE43MHrI169uqejlosdAmjyTj6W6/LG1l1dnkhvZHwazoKxjqQ5GMW6o/p
         0TXnqq8jC2ZGItrdbBaAbJJepgwrILvssTDFXBp/XwjZjn0Fof/CARZ5WQr03RIyTHdG
         ZeXxwd0Kys1/cFYMjKFueXMc4pUJGwrkIdPfEXVIvOfPGjGAzlOIxPAqVpq5AqKgpJdd
         0eExkIWZ3TnP6VHWsScno8keVx2PSYdxXIVtCXfakPaRMVPLYQhYc88yf1L+N+LEGbQF
         grdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6IwGVqZy1REKUxcBFcG80oGR30x3aLwEIoJpVG9B4BI=;
        b=wVjr1LXwOJZdwiiUqbnI5pq+Nu4HlhBW7SShd8G1sYQBA2QquGun2KxjGlsYY8fTYF
         49P0OiueKJA9NRgZntwRF0K9q0tysCaagJyIxMh+CKqvx/AtPDGTHHmiS5iewXR9CnVG
         MHzid8saOxcx0o4b+pWQblo5Rk9EagG+JKZVFEJHX7pTyhccEnUbYVFhlh3Lak6PciP3
         /9uLzuR3e53a43BDSTm+LnOJiBE1O2B8AaFpXl2nLI7umvWd6F68euzwo+qn0tQKjl2X
         1rUg4xc0iOm6ywFBm1G+qyHjLrLjVQBxjJCPXkZgcIcibWfWg1zvnIaJlwYyG6YWLeOK
         i4HQ==
X-Gm-Message-State: AOAM533+SmbxeHzwvFA7QNUeuibklDRXtmWI0x2axdwlEz0VQfPaQLAN
        nYdVgHY301rP/5oW5xDf1H72wkPBBMLOCMd5GiW6Zw==
X-Google-Smtp-Source: ABdhPJwi22wC79DYnZtEO7vqtswfj3tLd4A6lZf/1ejSzPSSrMf4Izl5TW3rYfgwzjchMlFnu8shi0/bOCSwySauJC4=
X-Received: by 2002:a63:d257:: with SMTP id t23mr729148pgi.533.1638471252152;
 Thu, 02 Dec 2021 10:54:12 -0800 (PST)
MIME-Version: 1.0
References: <20211202041627.291625-1-aford173@gmail.com> <CAHCN7xJHuOFTQBQWk1yKsk3M0iDB7aKc0=L2DisUoSXVeO3xXQ@mail.gmail.com>
In-Reply-To: <CAHCN7xJHuOFTQBQWk1yKsk3M0iDB7aKc0=L2DisUoSXVeO3xXQ@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 2 Dec 2021 10:54:00 -0800
Message-ID: <CAJ+vNU2t7Yp5OGtWj432Y-8hL62nQBbG58zM-gAj5YfuCO__sA@mail.gmail.com>
Subject: Re: [RFC V3 0/2] arm64: imx8mm: Enable Hantro VPUs
To:     Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 4:29 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Wed, Dec 1, 2021 at 10:17 PM Adam Ford <aford173@gmail.com> wrote:
> >
> > The i.MX8M has two Hantro video decoders, called G1 and G2 which appear
> > to be related to the video decoders used on the i.MX8MQ, but because of
> > how the Mini handles the power domains, the VPU driver does not need to
> > handle all the functions, so a new compatible flag is required.
> >
> > V3 is rebased from git://linuxtv.org/hverkuil/media_tree.git for-v5.17c
> > This branch has support for VP9.
> >
> > I set cma=512M, but this may not be enough memory as some tests appeard to run out of memory
> >
> > V3 of this series has several changes:
> >
> > Update imx8m_vpu_hw to add missing 'reg' reference names for G2 and include references to VP9
> > Update device tree to remove IMX8MQ_VPU_RESET, remove some duplicate vpu clock parenting
> > Fix missing reg-names from vpu_g2 node.
> > Apply patch [1] to manage the power domains powering down.
> > [1] - https://lore.kernel.org/linux-arm-kernel/20211016210547.171717-1-marex@denx.de/t/
> >
> > With the above, the following Fluster scores are produced:
> >
> > G1:
> > ./fluster.py run -dGStreamer-H.264-V4L2SL-Gst1.0
> > Ran 90/135 tests successfully               in 74.406 secs
> >
> > ./fluster.py run -d GStreamer-VP8-V4L2SL-Gst1.0
> > Ran 55/61 tests successfully               in 8.080 secs
> >
> > G2:
> > ./fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0
> > Ran 127/303 tests successfully               in 203.873 secs
> >
> > Fluster and G-Streamer were both built from their respective git repos using their respective master/main branches.
> >
>
> I should note, that both interrupts appear to be triggering.
>
> # cat /proc/interrupts |grep codec
>  57:      13442          0          0          0     GICv3  39 Level
>   38300000.video-codec
>  58:       7815          0          0          0     GICv3  40 Level
>   38310000.video-codec
>

Adam,

On another thread you had let me know that you also removed the reset
from the pgc_vpumix power domain which does appear to resolve the
hang:

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index eb9dcd9d1a31..31710af544dc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -681,7 +681,6 @@
                                                clocks = <&clk
IMX8MM_CLK_VPU_DEC_ROOT>;
                                                assigned-clocks =
<&clk IMX8MM_CLK_VPU_BUS>;
                                                assigned-clock-parents
= <&clk IMX8MM_SYS_PLL1_800M>;
-                                               resets = <&src
IMX8MQ_RESET_VPU_RESET>;
                                        };

                                        pgc_vpu_g1: power-domain@7 {

That would make such a patch have a 'Fixes commit d39d4bb15310
("arm64: dts: imx8mm: add GPC node")' but of course that vpu domain
isn't active until your series so I'm not sure if we should send this
separate or squash it with "arm64: dts: imx8mm: Enable VPU-G1 and
VPU-G2". I'm also not clear if removing the reset requires some
further discussion with Lucas.

Best regards,

Tim
