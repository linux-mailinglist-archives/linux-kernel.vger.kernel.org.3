Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED954B7ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbiBPD2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:28:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344279AbiBPD2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:28:53 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5D5FFFA1;
        Tue, 15 Feb 2022 19:28:39 -0800 (PST)
X-UUID: 201295e279514706a3e543ef5dd251c7-20220216
X-UUID: 201295e279514706a3e543ef5dd251c7-20220216
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1044364043; Wed, 16 Feb 2022 11:28:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 16 Feb 2022 11:28:33 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 11:28:33 +0800
Message-ID: <02f147135e6c1458caa10ed9027bf185beee2023.camel@mediatek.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: pinctrl: mt8186: add pinctrl file
 and binding document
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
Date:   Wed, 16 Feb 2022 11:28:33 +0800
In-Reply-To: <87db864e-fc74-189a-a665-bf51db8b5321@collabora.com>
References: <20220214030631.4969-1-guodong.liu@mediatek.com>
         <20220214030631.4969-2-guodong.liu@mediatek.com>
         <87db864e-fc74-189a-a665-bf51db8b5321@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
Subject: Re: [PATCH v4 1/3] dt-bindings: pinctrl: mt8186: add pinctrl
file and binding document
Date: Mon, 14 Feb 2022 10:58:58 +0100

Il 14/02/22 04:06, Guodong Liu ha scritto:
> 1. This patch adds pinctrl file for mt8186.
> 2. This patch adds mt8186 compatible node in binding document.
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>   .../bindings/pinctrl/pinctrl-mt8186.yaml      |  302 +++++
>   include/dt-bindings/pinctrl/mt8186-pinfunc.h  | 1174
> +++++++++++++++++
>   2 files changed, 1476 insertions(+)
>   create mode 100644
> Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
>   create mode 100644 include/dt-bindings/pinctrl/mt8186-pinfunc.h
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-
> mt8186.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-
> mt8186.yaml
> new file mode 100644
> index 000000000000..582d131af4e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml

...snip...

> diff --git a/include/dt-bindings/pinctrl/mt8186-pinfunc.h
> b/include/dt-bindings/pinctrl/mt8186-pinfunc.h
> new file mode 100644
> index 000000000000..dcff86201a61
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/mt8186-pinfunc.h
> @@ -0,0 +1,1174 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + * Author: Guodong Liu <Guodong.Liu@mediatek.com>
> + *
> + */
> +

Hello,
I've just noticed that we have a typo here....

You wrote "MT8168", but this should be "MT8186" instead; please fix it.

P.S.: I'm sorry for not seeing that before!

> +#ifndef __MT8168_PINFUNC_H
> +#define __MT8168_PINFUNC_H
> +

..snip..

> +
> +#endif /* __MT8168-PINFUNC_H */

Thank you,
Angelo

Hello Angelo,

we will update it for next version.

Thanks
Guodong

