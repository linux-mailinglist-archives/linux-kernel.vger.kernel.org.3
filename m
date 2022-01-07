Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DBC4872C6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiAGFcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:32:00 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:60480 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1346255AbiAGFb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:31:58 -0500
X-UUID: 67204c4a71bf4c8482ea83e435ec6d44-20220107
X-UUID: 67204c4a71bf4c8482ea83e435ec6d44-20220107
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2110010537; Fri, 07 Jan 2022 13:31:54 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 7 Jan 2022 13:31:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 Jan
 2022 13:31:53 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 Jan 2022 13:31:51 +0800
Message-ID: <54af6850e07aba2ca8002e344be86498c810067d.camel@mediatek.com>
Subject: Re: [PATCH] phy: phy-mtk-tphy: Fix dumplicated argument in
 phy-mtk-tphy
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <jiabing.wan@qq.com>
Date:   Fri, 7 Jan 2022 13:31:52 +0800
In-Reply-To: <20220107025050.787720-1-wanjiabing@vivo.com>
References: <20220107025050.787720-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-07 at 10:50 +0800, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/phy/mediatek/phy-mtk-tphy.c:994:6-29: duplicated argument
> to && or ||
> 
> The efuse_rx_imp is duplicate. Here should be efuse_tx_imp.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/phy/mediatek/phy-mtk-tphy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c
> b/drivers/phy/mediatek/phy-mtk-tphy.c
> index 6d307102f4f6..8ee7682b8e93 100644
> --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> @@ -992,7 +992,7 @@ static int phy_efuse_get(struct mtk_tphy *tphy,
> struct mtk_phy_instance *instanc
>  		/* no efuse, ignore it */
>  		if (!instance->efuse_intr &&
>  		    !instance->efuse_rx_imp &&
> -		    !instance->efuse_rx_imp) {
> +		    !instance->efuse_tx_imp) {
>  			dev_warn(dev, "no u3 intr efuse, but dts enable
> it\n");
>  			instance->efuse_sw_en = 0;
>  			break;

Acked-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks a lot


