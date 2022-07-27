Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C91D581E44
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbiG0D2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240317AbiG0D15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:27:57 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AADA3C171;
        Tue, 26 Jul 2022 20:27:55 -0700 (PDT)
X-UUID: ee07098e0f6743d9aacedf7a0c823441-20220727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:fff1a260-252a-4535-87ca-e6b2b7ee5f5b,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:90
X-CID-INFO: VERSION:1.1.8,REQID:fff1a260-252a-4535-87ca-e6b2b7ee5f5b,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:90
X-CID-META: VersionHash:0f94e32,CLOUDID:387d99b3-06d2-48ef-b2dd-540836705165,C
        OID:f495a94944e3,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: ee07098e0f6743d9aacedf7a0c823441-20220727
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 78144957; Wed, 27 Jul 2022 11:27:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 27 Jul 2022 11:27:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 27 Jul 2022 11:27:47 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <bvanassche@acm.org>
CC:     <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <alice.chao@mediatek.com>, <powen.kao@mediatek.com>,
        <mason.zhang@mediatek.com>, <qilin.tan@mediatek.com>,
        <lin.gui@mediatek.com>, <eddie.huang@mediatek.com>,
        <tun-yu.yu@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>,
        <stanley.chu@mediatek.com>
Subject: [PATCH v1 1/5] scsi: ufs: ufs-mediatek: Remove redundant header files
Date:   Wed, 27 Jul 2022 11:27:41 +0800
Message-ID: <20220727032745.31728-2-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220727032745.31728-1-stanley.chu@mediatek.com>
References: <20220727032745.31728-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant header files like
<linux/sched/clock.h>

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index c958279bdd8f..ff6fd8f52ebc 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -19,7 +19,6 @@
 #include <linux/pm_qos.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
-#include <linux/sched/clock.h>
 #include <linux/soc/mediatek/mtk_sip_svc.h>
 
 #include <ufs/ufshcd.h>
-- 
2.18.0

