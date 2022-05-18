Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A824D52B0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 05:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiERD2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 23:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiERD16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 23:27:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8456AA5D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 20:27:55 -0700 (PDT)
X-UUID: ab63fdc84db9426bb18f9912a3959b37-20220518
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:d01f7d87-f8ec-4dfa-8b44-3e5d40f6e065,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:50
X-CID-INFO: VERSION:1.1.5,REQID:d01f7d87-f8ec-4dfa-8b44-3e5d40f6e065,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:50
X-CID-META: VersionHash:2a19b09,CLOUDID:173293e2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:283834cedcbb,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: ab63fdc84db9426bb18f9912a3959b37-20220518
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 826719575; Wed, 18 May 2022 11:27:51 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 18 May 2022 11:27:50 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 18 May 2022 11:27:49 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 18 May 2022 11:27:49 +0800
Message-ID: <d006d5883b7053d7d4269582dfe3c597a81fdc20.camel@mediatek.com>
Subject: Re: [PATCH v6,1/4] drm/mediatek: Modify dsi funcs to atomic
 operations
From:   CK Hu <ck.hu@mediatek.com>
To:     <xinlei.lee@mediatek.com>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <matthias.bgg@gmail.com>
CC:     <jitao.shi@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <rex-bc.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 18 May 2022 11:27:49 +0800
In-Reply-To: <1652337012-9053-2-git-send-email-xinlei.lee@mediatek.com>
References: <1652337012-9053-1-git-send-email-xinlei.lee@mediatek.com>
         <1652337012-9053-2-git-send-email-xinlei.lee@mediatek.com>
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

Hi, Xinlei:

On Thu, 2022-05-12 at 14:30 +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Because .enable & .disable are deprecated.
> Use .atomic_enable & .atomic_disable instead.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c
> b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index bd3f5b485085..f880136cec09 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -763,14 +763,16 @@ static void mtk_dsi_bridge_mode_set(struct
> drm_bridge *bridge,
>  	drm_display_mode_to_videomode(adjusted, &dsi->vm);
>  }
>  
> -static void mtk_dsi_bridge_disable(struct drm_bridge *bridge)
> +static void mtk_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
> +					  struct drm_bridge_state
> *old_bridge_state)
>  {
>  	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
>  
>  	mtk_output_dsi_disable(dsi);
>  }
>  
> -static void mtk_dsi_bridge_enable(struct drm_bridge *bridge)
> +static void mtk_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
> +					 struct drm_bridge_state
> *old_bridge_state)
>  {
>  	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
>  
> @@ -779,8 +781,8 @@ static void mtk_dsi_bridge_enable(struct
> drm_bridge *bridge)
>  
>  static const struct drm_bridge_funcs mtk_dsi_bridge_funcs = {
>  	.attach = mtk_dsi_bridge_attach,
> -	.disable = mtk_dsi_bridge_disable,
> -	.enable = mtk_dsi_bridge_enable,
> +	.atomic_disable = mtk_dsi_bridge_atomic_disable,
> +	.atomic_enable = mtk_dsi_bridge_atomic_enable,
>  	.mode_set = mtk_dsi_bridge_mode_set,
>  };
>  

