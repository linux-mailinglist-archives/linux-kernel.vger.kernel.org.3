Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874F158A3C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 01:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbiHDXER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 19:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiHDXEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 19:04:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C56C3F314;
        Thu,  4 Aug 2022 16:04:14 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 949DF6601AD1;
        Fri,  5 Aug 2022 00:04:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659654252;
        bh=qN42gDa/BiB/77X0ufrUNqOOLInUMcjW2ugDuF/uQBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U/JjqTM+b6aGMclVuIc/m2ylx6EDkoB1x2zTXI3N3qZ1oB/MyVUSWzZqDwkk0UkOM
         nIoffjd1nMDloeLWzUtUjeLCpJBXBN2te3dss4nKtddxa+jx36/SMdtkI+j/qOF6o1
         2EymjQqGxamnDqJTJOVpFuS+PBOIViI0Jvx8y/jG8jmfccRUS6SXaJf/TyLvdJcdF+
         THKmv5lzgBp6e6Pz5Q3frBkVpEtjknSuv4N4ZOv4AhwMenUyFP5jI53aVjEn9fF4lr
         hW8NOC71akZD6bZB+M8Ctl7VE0WJj7aZ/yJix/ycgCLAEaNGrVQu2kNzazUIqk8Fm4
         CqJq8gGwvgMOA==
Date:   Thu, 4 Aug 2022 19:04:07 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     bchihi@baylibre.com
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: Re: [PATCH v8.1, 1/7] thermal: mediatek: Relocate driver to mediatek
 folder
Message-ID: <20220804230407.kwfsxy74qmmebfsj@notapiano>
References: <20220804130912.676043-1-bchihi@baylibre.com>
 <20220804130912.676043-2-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220804130912.676043-2-bchihi@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balsam,

On Thu, Aug 04, 2022 at 03:09:06PM +0200, bchihi@baylibre.com wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> Add MediaTek proprietary folder to upstream more thermal zone and cooler
> drivers, relocate the original thermal controller driver to it, and rename it
> as "mtxxxx_thermal.c" to show its purpose more clearly.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>  drivers/thermal/Kconfig                       | 14 ++++-------
>  drivers/thermal/Makefile                      |  2 +-
>  drivers/thermal/mediatek/Kconfig              | 23 +++++++++++++++++++
>  drivers/thermal/mediatek/Makefile             |  1 +
>  .../mtxxxx_thermal.c}                         |  2 +-
>  5 files changed, 30 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/thermal/mediatek/Kconfig
>  create mode 100644 drivers/thermal/mediatek/Makefile
>  rename drivers/thermal/{mtk_thermal.c => mediatek/mtxxxx_thermal.c} (99%)
[..]
> --- /dev/null
> +++ b/drivers/thermal/mediatek/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_MTK_SOC_THERMAL)		+= mtxxxx_thermal.o
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mediatek/mtxxxx_thermal.c

When Daniel suggested using a more SoC explicit name like 'mtxxx_thermal' [1]
the xxxx was supposed to be substituted for the actual SoC (family) that makes
use of this driver :-).

From the compatibles looks like we have mt8173, mt2701, mt2712, mt7622, mt8183.
So it doesn't look like it's a single SoC family... What about calling it
auxadc_thermal?

Thanks,
Nícolas

[1] https://lore.kernel.org/linux-mediatek/24250d03-b25f-e521-5abd-f36109885c36@linaro.org/

> similarity index 99%
> rename from drivers/thermal/mtk_thermal.c
> rename to drivers/thermal/mediatek/mtxxxx_thermal.c
> index ede94eadddda..60924f8f98e9 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mediatek/mtxxxx_thermal.c
> @@ -23,7 +23,7 @@
>  #include <linux/reset.h>
>  #include <linux/types.h>
>  
> -#include "thermal_hwmon.h"
> +#include "../thermal_hwmon.h"
>  
>  /* AUXADC Registers */
>  #define AUXADC_CON1_SET_V	0x008
> -- 
> 2.34.1
> 
> 
