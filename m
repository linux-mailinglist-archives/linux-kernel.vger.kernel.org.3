Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B0B5110F2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358005AbiD0GOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358019AbiD0GOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:14:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1193A2E6BB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:10:55 -0700 (PDT)
X-UUID: 233ba42842b64f70bb20352f1b65878d-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:e41a1cf1-3834-4923-8d9a-9a7e3f6107f0,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:e41a1cf1-3834-4923-8d9a-9a7e3f6107f0,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:daf4da2e-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
        ,BEC:nil
X-UUID: 233ba42842b64f70bb20352f1b65878d-20220427
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2071929021; Wed, 27 Apr 2022 14:10:50 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 27 Apr 2022 14:10:49 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Apr 2022 14:10:49 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 14:10:49 +0800
Message-ID: <ec484303c7ffd2a851c7095d9468e10582666422.camel@mediatek.com>
Subject: Re: [PATCH v2 2/8] mfd: add missing defines necessary for
 mtk-pmic-keys support
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Apr 2022 14:10:49 +0800
In-Reply-To: <20220426135313.245466-3-fparent@baylibre.com>
References: <20220426135313.245466-1-fparent@baylibre.com>
         <20220426135313.245466-3-fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-26 at 15:53 +0200, Fabien Parent wrote:
> Add 2 missing MT6359 registers that are needed to implement
> the keyboard driver.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> v2: no changes
> 
>  include/linux/mfd/mt6359/registers.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/mfd/mt6359/registers.h
> b/include/linux/mfd/mt6359/registers.h
> index 2135c9695918..2a4394a27b1c 100644
> --- a/include/linux/mfd/mt6359/registers.h
> +++ b/include/linux/mfd/mt6359/registers.h
> @@ -8,6 +8,8 @@
>  
>  /* PMIC Registers */
>  #define MT6359_SWCID                         0xa
> +#define MT6359_TOPSTATUS                     0x2a
> +#define MT6359_TOP_RST_MISC                  0x14c
>  #define MT6359_MISC_TOP_INT_CON0             0x188
>  #define MT6359_MISC_TOP_INT_STATUS0          0x194
>  #define MT6359_TOP_INT_STATUS0               0x19e

Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>

Regards,
Macpaul Lin

