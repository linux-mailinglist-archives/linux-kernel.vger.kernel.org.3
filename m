Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A7E52A0CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345561AbiEQLyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345567AbiEQLys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:54:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665A6419BB;
        Tue, 17 May 2022 04:54:40 -0700 (PDT)
X-UUID: 10a6435c58b44ea6be7a5091242888d2-20220517
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:0d8f568d-f922-46b5-b62f-9ea606901178,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:6b3d7fe2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 10a6435c58b44ea6be7a5091242888d2-20220517
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 613556711; Tue, 17 May 2022 19:54:35 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 17 May 2022 19:54:32 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 17 May 2022 19:54:32 +0800
Message-ID: <b2a0449d7d1a1ae09ff9cdeff6a1a59b9aeac6bf.camel@mediatek.com>
Subject: Re: [PATCH v6 1/7] thermal: mediatek: Relocate driver to mediatek
 folder
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Alexandre Bailon <abailon@baylibre.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <daniel.lezcano@linaro.org>,
        <rafael@kernel.org>, <khilman@baylibre.com>,
        <linux-pm@vger.kernel.org>, <amitk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <michael.kao@mediatek.com>,
        <ethan.chang@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        Michael Kao <michael.kao@mediatek.comi>, <rui.zhang@intel.com>,
        <ben.tseng@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <james.lo@mediatek.com>, <fan.chen@mediatek.com>,
        <louis.yu@mediatek.com>
Date:   Tue, 17 May 2022 19:54:32 +0800
In-Reply-To: <20220512122433.1399802-2-abailon@baylibre.com>
References: <20220512122433.1399802-1-abailon@baylibre.com>
         <20220512122433.1399802-2-abailon@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-12 at 14:24 +0200, Alexandre Bailon wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> Add Mediatek proprietary folder to upstream more thermal zone and
> cooler
> drivers. Relocate the original thermal controller driver to it and
> rename
> as soc_temp.c to show its purpose more clearly.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.comi>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/thermal/Kconfig                       | 14 ++++-------
>  drivers/thermal/Makefile                      |  2 +-
>  drivers/thermal/mediatek/Kconfig              | 23
> +++++++++++++++++++
>  drivers/thermal/mediatek/Makefile             |  1 +
>  .../{mtk_thermal.c => mediatek/soc_temp.c}    |  0
>  5 files changed, 29 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/thermal/mediatek/Kconfig
>  create mode 100644 drivers/thermal/mediatek/Makefile
>  rename drivers/thermal/{mtk_thermal.c => mediatek/soc_temp.c} (100%)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e37691e0bf20..8669d7278055 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -410,16 +410,10 @@ config DA9062_THERMAL
>  	  zone.
>  	  Compatible with the DA9062 and DA9061 PMICs.
>  
> -config MTK_THERMAL
> -	tristate "Temperature sensor driver for mediatek SoCs"
> -	depends on ARCH_MEDIATEK || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	depends on NVMEM || NVMEM=n
> -	depends on RESET_CONTROLLER
> -	default y
> -	help
> -	  Enable this option if you want to have support for thermal
> management
> -	  controller present in Mediatek SoCs
> +menu "Mediatek thermal drivers"

Hello Alexandre,

could you help to do this?
s/Mediatek/MediaTek/

and please also apply this to this series.

Thanks.

> +depends on ARCH_MEDIATEK || COMPILE_TEST
> +source "drivers/thermal/mediatek/Kconfig"
> +endmenu
>  
>  config AMLOGIC_THERMAL
>  	tristate "Amlogic Thermal Support"
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index f0c36a1530d5..9ade39bdb525 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -55,7 +55,7 @@ obj-y				+= st/
>  obj-$(CONFIG_QCOM_TSENS)	+= qcom/
>  obj-y				+= tegra/
>  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> -obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
> +obj-$(CONFIG_MTK_THERMAL)	+= mediatek/
>  obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
>  obj-$(CONFIG_UNIPHIER_THERMAL)	+= uniphier_thermal.o
>  obj-$(CONFIG_AMLOGIC_THERMAL)     += amlogic_thermal.o
> diff --git a/drivers/thermal/mediatek/Kconfig
> b/drivers/thermal/mediatek/Kconfig
> new file mode 100644
> index 000000000000..0351e73170b7
> --- /dev/null
> +++ b/drivers/thermal/mediatek/Kconfig
> @@ -0,0 +1,23 @@
> +config MTK_THERMAL
> +	tristate "Mediatek thermal drivers"
> +	depends on THERMAL_OF
> +	help
> +	  This is the option for Mediatek thermal software
> +	  solutions. Please enable corresponding options to
> +	  get temperature information from thermal sensors or
> +	  turn on throttle mechaisms for thermal mitigation.
> +
> +if MTK_THERMAL
> +
> +config MTK_SOC_THERMAL
> +	tristate "Temperature sensor driver for mediatek SoCs"
> +	depends on HAS_IOMEM
> +	depends on NVMEM
> +	depends on RESET_CONTROLLER
> +	help
> +	  Enable this option if you want to get SoC temperature
> +	  information for Mediatek platforms. This driver
> +	  configures thermal controllers to collect temperature
> +	  via AUXADC interface.
> +
> +endif
> diff --git a/drivers/thermal/mediatek/Makefile
> b/drivers/thermal/mediatek/Makefile
> new file mode 100644
> index 000000000000..f75313ddce5e
> --- /dev/null
> +++ b/drivers/thermal/mediatek/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_MTK_SOC_THERMAL)	+= soc_temp.o
> diff --git a/drivers/thermal/mtk_thermal.c
> b/drivers/thermal/mediatek/soc_temp.c
> similarity index 100%
> rename from drivers/thermal/mtk_thermal.c
> rename to drivers/thermal/mediatek/soc_temp.c

We should remain the original file "mtk_thermal.c" ?
I think it's a old hardware structure for mtk socs, like mt8183.

For mt8183, we still need to use this file.

Therefore, I think we should use a config to handle this?
And also, I think we can rename the mtk_thermal.c to mtk_thermal_adc.c.
soc_temp.c to mtk_thermal_lvts.c.

maybe we can discuss the file name offline.

The new owner of mtk thermal is James Lo.
Ben Tseng is no longer in mtk. Please remove this email.
Please also cc these mail in next version.
james.lo@mediatek.com
fan.chen@mediatek.com
louis.yu@mediatek.com
rex-bc.chen@mediatek.com

BRs,
Rex


