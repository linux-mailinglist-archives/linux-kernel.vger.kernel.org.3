Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2CB4741D9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 12:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhLNLx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 06:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhLNLxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 06:53:55 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE50DC061574;
        Tue, 14 Dec 2021 03:53:54 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e3so62992143edu.4;
        Tue, 14 Dec 2021 03:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x47UB4cctB2CldvAgcv0WT+3EDuXVlmZBLreEVjfGpY=;
        b=OIMZ70B8/XXzIrLeRDPMrsuiFuwmWPnaUFA9IeVs58n3gXem/OVYAG3KdID1VIt55/
         d23rV77R/z518hEY4d5ypLlf71b6UUKcBI+nuM/a2uMvPIuZzDuMqpdSyAxgqfNlBaLk
         HCAWg9FCLFcfBJwGvJiORpcKkSJyx/9EdUC9rEl5sEXyWZPGuPcxIV9zqJkqmFh4oe8r
         NwDUvTZKAW3hMdW8PaWokz45/Cf6G4qCUHzmL8C+nHH6eFaJ6u+eT2SnNEBcDGIslzo8
         lBw5gN8J544Ja990FtfMpOHRpczNHHxEHQnBJuEwRUKU9iVpzkrc9xEIO4hCSrrAP7uF
         e+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x47UB4cctB2CldvAgcv0WT+3EDuXVlmZBLreEVjfGpY=;
        b=OPebSk6sxmUEACZpKJDyRMAl4Wvh597ygR9iJvm8JFCcZudaVN+FeDgwXZ8Jl7WD5N
         Un7LUJAMx/TZlnGGSE5Ybqn3JiK18oHZkPd+1gIjKxOGLxLX5oTpZ+0IaqnbqVD2G7ww
         nZtbccUgfmgDTxSu2b0J6o+NGYJ7g9bJ7NCmA3mArcTtmMP4Lk/1M+ax1Da6r08q24eX
         giQnGMU7sxHu+0YV3NOMoT3OFmfYH0IKko6dzmiB9qGsi4z0zg2hnJUXpLtI0N1J9Ow1
         hHdSxlu0Zy6tloJbrtQLL3M7xMq5rh3kVE8DZRGvonOJNU+MmEFt+GumB2GzxpdqVJhT
         BZPw==
X-Gm-Message-State: AOAM5308jweECbiFtAUFJ28byJSho2jrvUAFMbkydQl7Enu3bpsGuVck
        Ol4PvGgTcu/t/SHXYIiUUVf/x7ztHh/qWLbu/DA=
X-Google-Smtp-Source: ABdhPJx9yE1ynksPDmRxCGdZJ+y1IAKy1NSSrv3P8cLO/ayTrsJZiEoT2yvy+hc9QyJIJuSYPhQM7MdnneHW5zHw9hc=
X-Received: by 2002:aa7:d495:: with SMTP id b21mr7273277edr.363.1639482833327;
 Tue, 14 Dec 2021 03:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20211123151252.143631-1-ariel.dalessandro@collabora.com> <20211123151252.143631-6-ariel.dalessandro@collabora.com>
In-Reply-To: <20211123151252.143631-6-ariel.dalessandro@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 14 Dec 2021 08:53:42 -0300
Message-ID: <CAOMZO5CzowtF8XB9yXtoHSZsafGu_ZpDY6phep9biJYy9eDssw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm: dts: imx8ulz-bsh-smm-m2: Add BSH SMM-M2
 IMX6ULZ SystemMaster
To:     "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, matt@traverse.com.au,
        Matteo Lisi <matteo.lisi@engicam.com>,
        meenakshi.aggarwal@nxp.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        nathan@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 12:13 PM Ariel D'Alessandro
<ariel.dalessandro@collabora.com> wrote:
>
> From: Michael Trimarchi <michael@amarulasolutions.com>
>
> Add DTS of BSH SMM-M2 SystemMaster.
>
> This version comes with:
> - 128 MiB DDR3 RAM
> - 256 MiB Nand
> - wifi
> - bluetooth
>
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  arch/arm/boot/dts/Makefile               |   3 +-
>  arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts | 153 +++++++++++++++++++++++
>  2 files changed, 155 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 0de64f237cd8..e6d4ad497985 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -693,7 +693,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>         imx6ull-phytec-segin-ff-rdk-nand.dtb \
>         imx6ull-phytec-segin-ff-rdk-emmc.dtb \
>         imx6ull-phytec-segin-lc-rdk-nand.dtb \
> -       imx6ulz-14x14-evk.dtb
> +       imx6ulz-14x14-evk.dtb \
> +       imx6ulz-bsh-smm-m2.dts

This should be .dtb instead of .dts
