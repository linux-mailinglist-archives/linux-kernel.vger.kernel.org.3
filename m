Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9782152CB52
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiESExy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiESExv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:53:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A602B6D86E;
        Wed, 18 May 2022 21:53:48 -0700 (PDT)
X-UUID: 62ccd5c15f0b4ce79265330646a3f7e4-20220519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:35826532-d058-49d4-9326-f8f60b22eac7,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:e307bee2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 62ccd5c15f0b4ce79265330646a3f7e4-20220519
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1331980739; Thu, 19 May 2022 12:53:41 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 19 May 2022 12:53:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 May 2022 12:53:39 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <bgolaszewski@baylibre.com>, <chun-jie.chen@mediatek.com>,
        <ck.hu@mediatek.com>, <devicetree@vger.kernel.org>,
        <fparent@baylibre.com>, <ikjn@chromium.org>,
        <jason-jh.lin@mediatek.com>, <kernel@collabora.com>,
        <konrad.dybcio@somainline.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <marijn.suijten@somainline.org>, <martin.botka@somainline.org>,
        <matthias.bgg@gmail.com>, <miles.chen@mediatek.com>,
        <mturquette@baylibre.com>, <p.zabel@pengutronix.de>,
        <paul.bouchara@somainline.org>, <phone-devel@vger.kernel.org>,
        <rex-bc.chen@mediatek.com>, <robh+dt@kernel.org>,
        <sam.shih@mediatek.com>, <sboyd@kernel.org>,
        <tinghan.shen@mediatek.com>, <weiyi.lu@mediatek.com>,
        <wenst@chromium.org>, <y.oudjana@protonmail.com>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH v2 7/7] clk: mediatek: Add MediaTek Helio X10 MT6795 clock drivers
Date:   Thu, 19 May 2022 12:53:40 +0800
Message-ID: <20220519045340.11198-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220518111652.223727-8-angelogioacchino.delregno@collabora.com>
References: <20220518111652.223727-8-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Angelo,

>Add the clock drivers for the entire clock tree of MediaTek Helio X10
>MT6795, including system clocks (apmixedsys, infracfg, pericfg, topckgen)
>and multimedia clocks (mmsys, mfg, vdecsys, vencsys).
>
>Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>---
> drivers/clk/mediatek/Kconfig                 |  37 ++
> drivers/clk/mediatek/Makefile                |   6 +
> drivers/clk/mediatek/clk-mt6795-apmixedsys.c | 157 +++++
> drivers/clk/mediatek/clk-mt6795-infracfg.c   | 148 +++++
> drivers/clk/mediatek/clk-mt6795-mfg.c        |  50 ++
> drivers/clk/mediatek/clk-mt6795-mm.c         | 106 ++++
> drivers/clk/mediatek/clk-mt6795-pericfg.c    | 160 +++++
> drivers/clk/mediatek/clk-mt6795-topckgen.c   | 611 +++++++++++++++++++
> drivers/clk/mediatek/clk-mt6795-vdecsys.c    |  55 ++
> drivers/clk/mediatek/clk-mt6795-vencsys.c    |  50 ++
> 10 files changed, 1380 insertions(+)
> create mode 100644 drivers/clk/mediatek/clk-mt6795-apmixedsys.c
> create mode 100644 drivers/clk/mediatek/clk-mt6795-infracfg.c
> create mode 100644 drivers/clk/mediatek/clk-mt6795-mfg.c
> create mode 100644 drivers/clk/mediatek/clk-mt6795-mm.c
> create mode 100644 drivers/clk/mediatek/clk-mt6795-pericfg.c
> create mode 100644 drivers/clk/mediatek/clk-mt6795-topckgen.c
> create mode 100644 drivers/clk/mediatek/clk-mt6795-vdecsys.c
> create mode 100644 drivers/clk/mediatek/clk-mt6795-vencsys.c
>
>diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
>index d5936cfb3bee..da8142dff3c3 100644
>--- a/drivers/clk/mediatek/Kconfig
>+++ b/drivers/clk/mediatek/Kconfig
>@@ -259,6 +259,43 @@ config COMMON_CLK_MT6779_AUDSYS
> 	help
> 	  This driver supports Mediatek MT6779 audsys clocks.
> 
>+config COMMON_CLK_MT6795
>+	tristate "Clock driver for MediaTek MT6795"
>+	depends on ARCH_MEDIATEK || COMPILE_TEST
>+	select COMMON_CLK_MEDIATEK
>+	default ARCH_MEDIATEK
>+	help
>+	  This driver supports MediaTek MT6795 basic clocks and clocks
>+	  required for various peripherals found on MediaTek.

Thanks for doing this, I was wondering if we can use only COMMON_CLK_MT6795 to build all
clk-mt6795-*? like CONFIG_COMMON_CLK_MT8195 style:

obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o \
				   clk-mt8195-peri_ao.o clk-mt8195-infra_ao.o \
				   clk-mt8195-cam.o clk-mt8195-ccu.o clk-mt8195-img.o \
				   clk-mt8195-ipe.o clk-mt8195-mfg.o clk-mt8195-scp_adsp.o \
				   clk-mt8195-vdec.o clk-mt8195-vdo0.o clk-mt8195-vdo1.o \
				   clk-mt8195-venc.o clk-mt8195-vpp0.o clk-mt8195-vpp1.o \
				   clk-mt8195-wpe.o clk-mt8195-imp_iic_wrap.o \
				   clk-mt8195-apusys_pll.o

So we do not have to keep other COMMON_CLK_MT6795_* configs.


thanks,
Miles

>+
>+config COMMON_CLK_MT6795_MFGCFG
>+	tristate "Clock driver for MediaTek MT6795 mfgcfg"
>+	depends on COMMON_CLK_MT6795
>+	default COMMON_CLK_MT6795
>+	help
>+	  This driver supports MediaTek MT6795 mfgcfg clocks.
>+
>+config COMMON_CLK_MT6795_MMSYS
>+       tristate "Clock driver for MediaTek MT6795 mmsys"
>+       depends on COMMON_CLK_MT6795
>+	default COMMON_CLK_MT6795
>+       help
>+         This driver supports MediaTek MT6795 mmsys clocks.
>+
>+config COMMON_CLK_MT6795_VDECSYS
>+	tristate "Clock driver for MediaTek MT6795 VDECSYS"
>+	depends on COMMON_CLK_MT6795
>+	default COMMON_CLK_MT6795
>+	help
>+	  This driver supports MediaTek MT6795 vdecsys clocks.
>+
>+config COMMON_CLK_MT6795_VENCSYS
>+	tristate "Clock driver for MediaTek MT6795 VENCSYS"
>+	depends on COMMON_CLK_MT6795
>+	default COMMON_CLK_MT6795
>+	help
>+	  This driver supports MediaTek MT6795 vencsys clocks.
>+
> config COMMON_CLK_MT6797
> 	bool "Clock driver for MediaTek MT6797"
> 	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
>diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
>index caf2ce93d666..57f0bf90e934 100644
>--- a/drivers/clk/mediatek/Makefile
>+++ b/drivers/clk/mediatek/Makefile
>@@ -17,6 +17,12 @@ obj-$(CONFIG_COMMON_CLK_MT6779_VDECSYS) += clk-mt6779-vdec.o
> obj-$(CONFIG_COMMON_CLK_MT6779_VENCSYS) += clk-mt6779-venc.o
> obj-$(CONFIG_COMMON_CLK_MT6779_MFGCFG) += clk-mt6779-mfg.o
> obj-$(CONFIG_COMMON_CLK_MT6779_AUDSYS) += clk-mt6779-aud.o
>+obj-$(CONFIG_COMMON_CLK_MT6795) += clk-mt6795-apmixedsys.o clk-mt6795-infracfg.o \
>+				   clk-mt6795-pericfg.o clk-mt6795-topckgen.o
>+obj-$(CONFIG_COMMON_CLK_MT6795_MFGCFG) += clk-mt6795-mfg.o
>+obj-$(CONFIG_COMMON_CLK_MT6795_MMSYS) += clk-mt6795-mm.o
>+obj-$(CONFIG_COMMON_CLK_MT6795_VDECSYS) += clk-mt6795-vdecsys.o
>+obj-$(CONFIG_COMMON_CLK_MT6795_VENCSYS) += clk-mt6795-vencsys.o



> obj-$(CONFIG_COMMON_CLK_MT6797) += clk-mt6797.o
> obj-$(CONFIG_COMMON_CLK_MT6797_IMGSYS) += clk-mt6797-img.o
> obj-$(CONFIG_COMMON_CLK_MT6797_MMSYS) += clk-mt6797-mm.o
>diff --git a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
>new file mode 100644
>index 000000000000..766e83765cbb
>--- /dev/null
>+++ b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
>@@ -0,0 +1,157 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/*
