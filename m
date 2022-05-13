Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7197B526884
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383048AbiEMRbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383093AbiEMRbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:31:09 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDF974DFE;
        Fri, 13 May 2022 10:31:02 -0700 (PDT)
X-UUID: bc9b1bb985924b038a5ac1902bea01cd-20220514
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:74adf0a9-544d-4f9a-a687-31843016f110,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:74adf0a9-544d-4f9a-a687-31843016f110,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:8d5727f2-ab23-4aed-a67b-f96514452486,C
        OID:FAIL,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,Fil
        e:nil,QS:0,BEC:nil
X-UUID: bc9b1bb985924b038a5ac1902bea01cd-20220514
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 923580286; Sat, 14 May 2022 01:30:53 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 14 May 2022 01:30:52 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 14 May 2022 01:30:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 14 May 2022 01:30:40 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hverkuil@xs4all.nl>, <yj.chiang@mediatek.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v2] media: Kconfig: Make DVB_CORE=m possible when MEDIA_SUPPORT=y
Date:   Sat, 14 May 2022 01:30:36 +0800
Message-ID: <20220513173036.10807-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

A case that CONFIG_MEDIA_SUPPORT is y but we need DVB_CORE=m, and
this doesn't work since DVB_CORE is default MEDIA_DIGITAL_TV_SUPPORT
and then follows MEDIA_SUPPORT.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 drivers/media/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index ba6592b3dab2..c64bba94f950 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -182,7 +182,7 @@ config MEDIA_CONTROLLER
 #
 
 config DVB_CORE
-	tristate
+	tristate "DVB Core"
 	depends on MEDIA_DIGITAL_TV_SUPPORT
 	depends on (I2C || I2C=n)
 	default MEDIA_DIGITAL_TV_SUPPORT
-- 
2.18.0

