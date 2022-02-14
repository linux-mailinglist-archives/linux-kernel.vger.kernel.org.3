Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D324B3FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbiBNDDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:03:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiBNDDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:03:10 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEA150B00;
        Sun, 13 Feb 2022 19:02:58 -0800 (PST)
X-UUID: e207358457774319967e1883b9a9fb3d-20220214
X-UUID: e207358457774319967e1883b9a9fb3d-20220214
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 958469024; Mon, 14 Feb 2022 11:02:54 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 14 Feb 2022 11:02:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Feb
 2022 11:02:53 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Feb 2022 11:02:52 +0800
Message-ID: <4f7fe0940c03f6fba7096b4e1c9239167a5906f7.camel@mediatek.com>
Subject: Re: [PATCH v3 2/3] pinctrl: add pinctrl driver on mt8186
From:   Guodong Liu <guodong.liu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 14 Feb 2022 11:02:52 +0800
In-Reply-To: <332434dc-2c94-5488-e7d0-7db00139d814@collabora.com>
References: <20220210062122.23974-1-guodong.liu@mediatek.com>
         <20220210062122.23974-3-guodong.liu@mediatek.com>
         <332434dc-2c94-5488-e7d0-7db00139d814@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: AngeloGioacchino Del Regno <
angelogioacchino.delregno@collabora.com>
To: Guodong Liu <guodong.liu@mediatek.com>, Linus Walleij <
linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Matthias
Brugger <matthias.bgg@gmail.com>, Sean Wang <sean.wang@kernel.org>
Cc: Sean Wang <sean.wang@mediatek.com>, linux-gpio@vger.kernel.org, 
devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 2/3] pinctrl: add pinctrl driver on mt8186
Date: Thu, 10 Feb 2022 09:57:03 +0100

Il 10/02/22 07:21, Guodong Liu ha scritto:
> This commit includes pinctrl driver for mt8186.
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>   drivers/pinctrl/mediatek/Kconfig              |    7 +
>   drivers/pinctrl/mediatek/Makefile             |    1 +
>   drivers/pinctrl/mediatek/pinctrl-mt8186.c     | 1313 ++++++++++
>   drivers/pinctrl/mediatek/pinctrl-mtk-mt8186.h | 2186
> +++++++++++++++++
>   4 files changed, 3507 insertions(+)
>   create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8186.c
>   create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8186.h
> 
> diff --git a/drivers/pinctrl/mediatek/Kconfig
> b/drivers/pinctrl/mediatek/Kconfig
> index 66db4ac5d169..8dca1ef04965 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -147,6 +147,13 @@ config PINCTRL_MT8183
>   	default ARM64 && ARCH_MEDIATEK
>   	select PINCTRL_MTK_PARIS
>   
> +config PINCTRL_MT8186
> +	bool "Mediatek MT8186 pin control"
> +	depends on OF
> +	depends on ARM64 || COMPILE_TEST
> +	default ARM64 && ARCH_MEDIATEK
> +	select PINCTRL_MTK_PARIS
> +
>   config PINCTRL_MT8192
>   	bool "Mediatek MT8192 pin control"
>   	depends on OF
> diff --git a/drivers/pinctrl/mediatek/Makefile
> b/drivers/pinctrl/mediatek/Makefile
> index 90f43bb9d9a7..31c3784c6089 100644
> --- a/drivers/pinctrl/mediatek/Makefile
> +++ b/drivers/pinctrl/mediatek/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_PINCTRL_MT7986)	+= pinctrl-
> mt7986.o
>   obj-$(CONFIG_PINCTRL_MT8167)	+= pinctrl-mt8167.o
>   obj-$(CONFIG_PINCTRL_MT8173)	+= pinctrl-mt8173.o
>   obj-$(CONFIG_PINCTRL_MT8183)	+= pinctrl-mt8183.o
> +obj-$(CONFIG_PINCTRL_MT8186)	+= pinctrl-mt8186.o
>   obj-$(CONFIG_PINCTRL_MT8192)	+= pinctrl-mt8192.o
>   obj-$(CONFIG_PINCTRL_MT8195)    += pinctrl-mt8195.o
>   obj-$(CONFIG_PINCTRL_MT8365)	+= pinctrl-mt8365.o
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8186.c
> b/drivers/pinctrl/mediatek/pinctrl-mt8186.c
> new file mode 100644
> index 000000000000..1e550b15b9d4
> --- /dev/null
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8186.c
> @@ -0,0 +1,1313 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + *
> + * Author: Guodong Liu <guodong.liu@mediatek.com>
> + *
> + */
> +
> +#include "pinctrl-mtk-mt8186.h"
> +#include "pinctrl-paris.h"
> +
> +/* MT8186 have multiple bases to program pin configuration listed as
> the below:
> + * iocfg[0]:0x10005000, iocfg[1]:0x10002000, iocfg[2]:0x10002200,
> + * iocfg[3]:0x10002400, iocfg[4]:0x10002600, iocfg[5]:0x10002800,
> + * iocfg[6]:0x10002C00.
> + * _i_based could be used to indicate what base the pin should be
> mapped into.
> + */
> +
> +#define PIN_FIELD_BASE(s_pin, e_pin, i_base, s_addr, x_addrs, s_bit,
> x_bits) \
> +	PIN_FIELD_CALC(s_pin, e_pin, i_base, s_addr, x_addrs, s_bit,
> x_bits, \
> +		       32, 0)

Please don't break this line: 84 columns is fine.

Hi Angelo

we will update it for next version.

Thanks
Guodong
> +
> +#define PINS_FIELD_BASE(s_pin, e_pin, i_base, s_addr, x_addrs,
> s_bit, x_bits) \
> +	PIN_FIELD_CALC(s_pin, e_pin, i_base, s_addr, x_addrs, s_bit,
> x_bits,  \
> +		       32, 1)

Same here.

Hi Angelo

we will update it for next version.

Thanks
Guodong
And with that fixed,
Reviewed-by: AngeloGioacchino Del Regno <
angelogioacchino.delregno@collabora.com>



