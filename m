Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC16A528BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244293AbiEPRPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344136AbiEPRPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:15:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0CF326ED;
        Mon, 16 May 2022 10:15:29 -0700 (PDT)
X-UUID: 7087c81598f04a41b7702ad54b02fc2b-20220517
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:c5c59f6d-aa11-42fa-8db9-33892bdd6538,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:d53e3794-563e-4fc2-8a0d-fda4821947ab,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 7087c81598f04a41b7702ad54b02fc2b-20220517
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1498098034; Tue, 17 May 2022 01:15:24 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 17 May 2022 01:15:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 17 May 2022 01:15:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 17 May 2022 01:15:22 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hverkuil@xs4all.nl>, <yj.chiang@mediatek.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH v3 1/2] media: mantis: Kconfig: add depends on DVB_CORE for MANTIS_CORE
Date:   Tue, 17 May 2022 01:15:14 +0800
Message-ID: <20220516171515.16404-2-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220516171515.16404-1-lecopzer.chen@mediatek.com>
References: <20220516171515.16404-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MANTIS_CORE needs DVB_CORE, set 'depends on' explicitly

ERROR: modpost: "dvb_dmx_init" [drivers/media/pci/mantis/mantis_core.ko] undefined!
ERROR: modpost: "dvb_unregister_adapter" [drivers/media/pci/mantis/mantis_core.ko] undefined!
ERROR: modpost: "dvb_register_frontend" [drivers/media/pci/mantis/mantis_core.ko] undefined!
ERROR: modpost: "dvb_ca_en50221_camchange_irq" [drivers/media/pci/mantis/mantis_core.ko] undefined!
ERROR: modpost: "dvb_unregister_frontend" [drivers/media/pci/mantis/mantis_core.ko] undefined!
>> ERROR: modpost: "dvb_ca_en50221_camready_irq" [drivers/media/pci/mantis/mantis_core.ko] undefined!
>> ERROR: modpost: "dvb_frontend_detach" [drivers/media/pci/mantis/mantis_core.ko] undefined!
>> ERROR: modpost: "dvb_dmxdev_release" [drivers/media/pci/mantis/mantis_core.ko] undefined!
>> ERROR: modpost: "dvb_dmx_swfilter" [drivers/media/pci/mantis/mantis_core.ko] undefined!

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 drivers/media/pci/mantis/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/mantis/Kconfig b/drivers/media/pci/mantis/Kconfig
index 9dfaf2c9a7b3..374b8f382f62 100644
--- a/drivers/media/pci/mantis/Kconfig
+++ b/drivers/media/pci/mantis/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config MANTIS_CORE
 	tristate "Mantis/Hopper PCI bridge based devices"
-	depends on PCI && I2C && INPUT && RC_CORE
+	depends on PCI && I2C && INPUT && RC_CORE && DVB_CORE
 
 	help
 	  Support for PCI cards based on the Mantis and Hopper PCi bridge.
-- 
2.18.0

