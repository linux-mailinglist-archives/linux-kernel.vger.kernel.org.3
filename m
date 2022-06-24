Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18319559A90
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiFXNmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiFXNmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:42:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74562D1F4;
        Fri, 24 Jun 2022 06:42:12 -0700 (PDT)
X-UUID: ec960c61baa04437bf56d857c8086f85-20220624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:aecedf80-805d-4a4a-8f5d-3c50ce08cc4c,OB:0,LO
        B:40,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:45
X-CID-INFO: VERSION:1.1.6,REQID:aecedf80-805d-4a4a-8f5d-3c50ce08cc4c,OB:0,LOB:
        40,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:45
X-CID-META: VersionHash:b14ad71,CLOUDID:b80170ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:e10d6b610329,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,IP:nil,
        URL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: ec960c61baa04437bf56d857c8086f85-20220624
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 366130123; Fri, 24 Jun 2022 21:42:05 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 24 Jun 2022 21:42:04 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Jun 2022 21:42:03 +0800
Message-ID: <26b47f385eb4148715aabe0184bd90cc32cdd42f.camel@mediatek.com>
Subject: Re: [PATCH v1 1/4] pinctrl: add generic driving setup property on
 mt8192
From:   Guodong Liu <guodong.liu@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 24 Jun 2022 21:42:03 +0800
In-Reply-To: <20220609181658.s5qdm32f5vhwkkao@notapiano>
References: <20220608053909.1252-1-guodong.liu@mediatek.com>
         <20220608053909.1252-2-guodong.liu@mediatek.com>
         <20220609181658.s5qdm32f5vhwkkao@notapiano>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Nícolas F. R. A. Prado <nfraprado@collabora.com>
To: Guodong Liu <guodong.liu@mediatek.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <
robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Sean
Wang <sean.wang@kernel.org>, Sean Wang <sean.wang@mediatek.com>,
Zhiyong Tao <zhiyong.tao@mediatek.com>, linux-gpio@vger.kernel.org, 
devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v1 1/4] pinctrl: add generic driving setup property
on mt8192
Date: Thu, 9 Jun 2022 14:16:58 -0400

Hi Guodong,

thank you for the patch.

On Wed, Jun 08, 2022 at 01:39:06PM +0800, Guodong Liu wrote:
> This patch provides generic driving setup, which support
> 2/4/6/8/10/12/14/16mA driving, original driver just set
> raw data setup setting when use drive-strength property

You should mention in the commit message that the dt-binding expects
that
drive-strength arguments be passed in mA, but the driver was expecting
raw
values. And that this commit changes the driver so that it is aligned
with the
binding.

Thanks,
Nícolas

will fix it in next version,thanks!
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mt8192.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> index acccde9262ba..9faf7001369d 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8192.c
> @@ -1372,8 +1372,8 @@ static const struct mtk_pin_soc mt8192_data = {
>  	.gpio_m = 0,
>  	.bias_set_combo = mtk_pinconf_bias_set_combo,
>  	.bias_get_combo = mtk_pinconf_bias_get_combo,
> -	.drive_set = mtk_pinconf_drive_set_raw,
> -	.drive_get = mtk_pinconf_drive_get_raw,
> +	.drive_set	= mtk_pinconf_drive_set_rev1,
> +	.drive_get	= mtk_pinconf_drive_get_rev1,
>  	.adv_pull_get = mtk_pinconf_adv_pull_get,
>  	.adv_pull_set = mtk_pinconf_adv_pull_set,
>  	.adv_drive_get = mtk_pinconf_adv_drive_get,
> -- 
> 2.25.5
> 

