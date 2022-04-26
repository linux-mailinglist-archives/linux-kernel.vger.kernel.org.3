Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FC0510C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355990AbiDZXEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbiDZXEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:04:08 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D938D35DD8;
        Tue, 26 Apr 2022 16:00:58 -0700 (PDT)
X-UUID: 04a62838dc4c4a3085931d7f0ddfa6f4-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:ae04e39f-1848-4c54-b543-f650b33a2dba,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:ae04e39f-1848-4c54-b543-f650b33a2dba,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:c36693c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
        ,BEC:nil
X-UUID: 04a62838dc4c4a3085931d7f0ddfa6f4-20220427
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2046245539; Wed, 27 Apr 2022 07:00:51 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 27 Apr 2022 07:00:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 Apr
 2022 07:00:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 07:00:48 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <allen-kh.cheng@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>, <hsinyi@chromium.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <ryder.lee@kernel.org>, <wenst@chromium.org>
Subject: Re: [PATCH v5 2/2] arm64: dts: Add Mediatek SoC MT8186 dts and evaluation board and Makefile
Date:   Wed, 27 Apr 2022 07:00:48 +0800
Message-ID: <20220426230048.20685-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220426125046.17311-3-allen-kh.cheng@mediatek.com>
References: <20220426125046.17311-3-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen, 

> Add basic chip support for Mediatek MT8186.

s/Mediatek/MediaTek/

> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

...snip...

> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)

I think we should use GPL-2.0-only OR BSD-2-Clause for newly added dts files.
i.e.,
// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause

> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + */
> +/dts-v1/;
> +#include "mt8186.dtsi"
> +
> +/ {


..snip...

> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> new file mode 100644
> index 000000000000..e8d8867412e3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -0,0 +1,932 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)

I think we should use GPL-2.0-only OR BSD-2-Clause for newly added dts files.
i.e.,
// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause

> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + * Author: Allen-KH Cheng <allenn-kh.cheng@mediatek.com>
> + */
> +/dts-v1/;
>


thanks,
Miles
