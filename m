Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD3D48DF99
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiAMV3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:29:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42964 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiAMV33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:29:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA3EA61A35;
        Thu, 13 Jan 2022 21:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C10C36AE3;
        Thu, 13 Jan 2022 21:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642109368;
        bh=9/oOB+KtddzUtsBpBbqkWxiDI2s1C2hymkyNpoOLJTc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OsIKhQXyXasXp2N/sLLW7xq2ve1JZOCWXYONBZAC9Pbr2YnDa8XP00CIsmsEw2rVH
         3ohIB/eR+QbS0Ptg3jkXLYTWwYBHfk11lCSnPJHOkp6sAkQNaasknv3BWNxT0fiSIp
         /rIBrToENKK7ytyp1rtOxycWciEtY7yOWXtjSk/G/Qvk/Ca4JNOqeK4stSg1erxZ7E
         GXj/ZKGSIb1UBAB3qw9++K5IhOE/Dwrriq5hAxNGqBikjoqM2F8G5TAEdQLX3+NQsP
         P3G5FgkELvVyf/dzNgCbrkvhawHAo6I9IXgqRnIKlqxm+UhjxIOBnrZpZRbR8NKcPu
         n+kG2Du4suSvA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220113115745.45826-3-liang.yang@amlogic.com>
References: <20220113115745.45826-1-liang.yang@amlogic.com> <20220113115745.45826-3-liang.yang@amlogic.com>
Subject: Re: [PATCH v9 2/4] clk: meson: add emmc sub clock phase delay driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org
Date:   Thu, 13 Jan 2022 13:29:26 -0800
User-Agent: alot/0.9.1
Message-Id: <20220113212928.28C10C36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Liang Yang (2022-01-13 03:57:43)
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index b3ef5f67820f..c450f38d3801 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_PLL) +=3D clk-pll.o
>  obj-$(CONFIG_COMMON_CLK_MESON_REGMAP) +=3D clk-regmap.o
>  obj-$(CONFIG_COMMON_CLK_MESON_SCLK_DIV) +=3D sclk-div.o
>  obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) +=3D vid-pll-div.o
> +obj-$(CONFIG_COMMON_CLK_MESON_PHASE_DELAY) +=3D clk-phase-delay.o

Sort by Kconfig symbol?

> =20
>  # Amlogic Clock controllers
>
