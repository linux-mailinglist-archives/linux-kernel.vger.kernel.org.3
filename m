Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE204E6B57
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 00:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356700AbiCXXvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 19:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357759AbiCXXuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 19:50:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325713B3F3;
        Thu, 24 Mar 2022 16:48:30 -0700 (PDT)
X-UUID: 25912c82011a4dd9bf92c952f98c2cfa-20220325
X-UUID: 25912c82011a4dd9bf92c952f98c2cfa-20220325
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 50517446; Fri, 25 Mar 2022 07:48:25 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 25 Mar 2022 07:48:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Mar 2022 07:48:23 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <xinlei.lee@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <devicetree@vger.kernel.org>,
        <jitao.shi@mediatek.com>, <lee.jones@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
        <matthias.bgg@gmail.com>, <rex-bc.chen@mediatek.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4,2/6] dt-bindings: pwm: Remove compatible for MediaTek MT8167
Date:   Fri, 25 Mar 2022 07:48:24 +0800
Message-ID: <20220324234824.20588-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <1648101804-3584-3-git-send-email-xinlei.lee@mediatek.com>
References: <1648101804-3584-3-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xinlei,

> Remove dt-binding documentation of pwm for MediaTek MT8167 SoC.
> I did not find the compatiable corresponding to mt8167 
> in the latest version of the pwm-mtk-disp.c driver file.
> It may be disabled but not updated to the dt_binding file.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> index f844695d605a..f18e8bbd13d2 100644
> --- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> @@ -20,9 +20,6 @@ properties:
>            - mediatek,mt2701-disp-pwm
>            - mediatek,mt6595-disp-pwm
>            - mediatek,mt8173-disp-pwm
> -      - items:
> -          - const: mediatek,mt8167-disp-pwm
> -          - const: mediatek,mt8173-disp-pwm

I checked:
grep -e 'mediatek,mt8167-disp-pwm' -e 'mediatek,mt8173-disp-pwm' drivers/ -RnH
drivers/gpu/drm/mediatek/mtk_drm_drv.c:486:     { .compatible = "mediatek,mt8167-disp-pwm",
drivers/gpu/drm/mediatek/mtk_drm_drv.c:488:     { .compatible = "mediatek,mt8173-disp-pwm",

mediatek,mt8167-disp-pwm and mediatek,mt8173-disp-pwm are used in drivers/gpu/drm/mediatek/mtk_drm_drv.c.
(added by commit 58e4c5398200 ("drm/mediatek: Add support for main DDP path on MT8167"))

Is it ok to remove mediatek,mt8167-disp-pwm and mediatek,mt8173-disp-pwm?

Thanks,
Miles
>  
>    reg:
>      maxItems: 1
