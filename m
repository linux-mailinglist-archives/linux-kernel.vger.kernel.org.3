Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E8D5385D3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 18:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiE3QDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 12:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242724AbiE3QCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 12:02:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3EC93;
        Mon, 30 May 2022 09:02:23 -0700 (PDT)
X-UUID: 4827a7887c5a489aa9649e311c4d8c30-20220531
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:c7243481-68b2-439e-9beb-cecbb626aa87,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:14,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:14
X-CID-META: VersionHash:2a19b09,CLOUDID:2f7bceb8-3c45-407b-8f66-25095432a27a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:3,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 4827a7887c5a489aa9649e311c4d8c30-20220531
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 68746084; Tue, 31 May 2022 00:02:16 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 31 May 2022 00:02:15 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 31 May 2022 00:02:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 31 May 2022 00:02:15 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <fparent@baylibre.com>
CC:     <chaotian.jing@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        <matthias.bgg@gmail.com>, <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mtk-sd: fix typo
Date:   Tue, 31 May 2022 00:02:15 +0800
Message-ID: <20220530160215.8749-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220530123857.692076-1-fparent@baylibre.com>
References: <20220530123857.692076-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Fix a typo: Fianl -> Final.
>
>Signed-off-by: Fabien Parent <fparent@baylibre.com>

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 

>---
> drivers/mmc/host/mtk-sd.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
>index 195dc897188b..c7d196f805ec 100644
>--- a/drivers/mmc/host/mtk-sd.c
>+++ b/drivers/mmc/host/mtk-sd.c
>@@ -2318,7 +2318,7 @@ static int msdc_execute_hs400_tuning(struct mmc_host *mmc, struct mmc_card *card
> 	else
> 		val = readl(host->base + PAD_DS_TUNE);
> 
>-	dev_info(host->dev, "Fianl PAD_DS_TUNE: 0x%x\n", val);
>+	dev_info(host->dev, "Final PAD_DS_TUNE: 0x%x\n", val);
> 
> 	return 0;
> 
>-- 
>2.36.1


