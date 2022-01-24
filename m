Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180D14982BB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbiAXOxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiAXOxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:53:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4E6C06173B;
        Mon, 24 Jan 2022 06:53:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2E7061388;
        Mon, 24 Jan 2022 14:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66412C340E1;
        Mon, 24 Jan 2022 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643035995;
        bh=/UFZn2Ad3U5S5ZRsk1t55iYX+8gryJpTv4IG7nItYc4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xe+iouwjWuuESsP10Y68t7k6Yk0aQoWI+HuNVas6ORg9ZrjsawOjAsOPr/UcJYHHP
         8KaUShnoMa0TT84HpB0JojyeNbuzb3ASxINV9dHu0vCdSKtf0SHhXmLt/tRXALHGeH
         kNHxM7wd3+mbK30y1aBXQgdcmwXIqlio39fvyBR7abnwt97CRijO52Dd0bPeuxxgzH
         uzzwre5HvfOcH/Ammtj6B2l9pmj5l3rejzDyEGknm8J12LyVWYhlCH3X1SdutbN3Ol
         uDOSgl/B6z0v6UHWegE87uCwSvf7pP376SuVTpFoSC2sJcEANI29Y7HdW2aW1NKUJK
         IflS6HHNbnu0Q==
Received: by mail-ej1-f49.google.com with SMTP id j2so21915432ejk.6;
        Mon, 24 Jan 2022 06:53:15 -0800 (PST)
X-Gm-Message-State: AOAM531vj7JY07noyNXohI8iVE7FMQLwBMeGaxQMJXh1DrIRxHcjQfyW
        e1OG5oL4Hwu8QwxY56C4vCzpi3Pgh6k5w+dUBA==
X-Google-Smtp-Source: ABdhPJzKZ0BrDSVscI7GTZTJD8z7zgb4zEFRYYwlxVZkor3vQWVirMqnVnt0UADo/U7N+2UHyxeeQ0FkuTip5UYte6I=
X-Received: by 2002:a17:906:9503:: with SMTP id u3mr12559207ejx.423.1643035993766;
 Mon, 24 Jan 2022 06:53:13 -0800 (PST)
MIME-Version: 1.0
References: <20211217173908.3201517-1-robh@kernel.org>
In-Reply-To: <20211217173908.3201517-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 24 Jan 2022 08:53:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLYXYNHRKM9hAhxZjheJZUxiXN3zCwsmwo1kxVvhKn9VA@mail.gmail.com>
Message-ID: <CAL_JsqLYXYNHRKM9hAhxZjheJZUxiXN3zCwsmwo1kxVvhKn9VA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8qm: Drop CPU 'arm,armv8' compatible
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 11:39 AM Rob Herring <robh@kernel.org> wrote:
>
> The CPU 'arm,armv8' compatible is only for s/w models, so remove it from
> i.MX8QM CPU nodes.
>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Note that the PMU node is also wrong as it should have separate A72 and
> A53 nodes to get uarch specific events, but that needs some GIC changes.
> ---
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Ping

>
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> index aebbe2b84aa1..b13f09ca0404 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> @@ -54,7 +54,7 @@ core1 {
>
>                 A53_0: cpu@0 {
>                         device_type = "cpu";
> -                       compatible = "arm,cortex-a53", "arm,armv8";
> +                       compatible = "arm,cortex-a53";
>                         reg = <0x0 0x0>;
>                         enable-method = "psci";
>                         next-level-cache = <&A53_L2>;
> @@ -62,7 +62,7 @@ A53_0: cpu@0 {
>
>                 A53_1: cpu@1 {
>                         device_type = "cpu";
> -                       compatible = "arm,cortex-a53", "arm,armv8";
> +                       compatible = "arm,cortex-a53";
>                         reg = <0x0 0x1>;
>                         enable-method = "psci";
>                         next-level-cache = <&A53_L2>;
> @@ -70,7 +70,7 @@ A53_1: cpu@1 {
>
>                 A53_2: cpu@2 {
>                         device_type = "cpu";
> -                       compatible = "arm,cortex-a53", "arm,armv8";
> +                       compatible = "arm,cortex-a53";
>                         reg = <0x0 0x2>;
>                         enable-method = "psci";
>                         next-level-cache = <&A53_L2>;
> @@ -78,7 +78,7 @@ A53_2: cpu@2 {
>
>                 A53_3: cpu@3 {
>                         device_type = "cpu";
> -                       compatible = "arm,cortex-a53", "arm,armv8";
> +                       compatible = "arm,cortex-a53";
>                         reg = <0x0 0x3>;
>                         enable-method = "psci";
>                         next-level-cache = <&A53_L2>;
> @@ -86,7 +86,7 @@ A53_3: cpu@3 {
>
>                 A72_0: cpu@100 {
>                         device_type = "cpu";
> -                       compatible = "arm,cortex-a72", "arm,armv8";
> +                       compatible = "arm,cortex-a72";
>                         reg = <0x0 0x100>;
>                         enable-method = "psci";
>                         next-level-cache = <&A72_L2>;
> @@ -94,7 +94,7 @@ A72_0: cpu@100 {
>
>                 A72_1: cpu@101 {
>                         device_type = "cpu";
> -                       compatible = "arm,cortex-a72", "arm,armv8";
> +                       compatible = "arm,cortex-a72";
>                         reg = <0x0 0x101>;
>                         enable-method = "psci";
>                         next-level-cache = <&A72_L2>;
> --
> 2.32.0
>
