Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D018950CEBC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 04:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbiDXDAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237791AbiDXDAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:00:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2208113F27A;
        Sat, 23 Apr 2022 19:57:50 -0700 (PDT)
X-UUID: 2b76813eb41f48348a21649b3173fd44-20220424
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:343ff536-7bc1-437b-8efa-5c9d1b78a95c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:34
X-CID-INFO: VERSION:1.1.4,REQID:343ff536-7bc1-437b-8efa-5c9d1b78a95c,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:34
X-CID-META: VersionHash:faefae9,CLOUDID:c429b9f0-da02-41b4-b6df-58f4ccd36682,C
        OID:152b11335294,Recheck:0,SF:13|15|28|100|17|19|48|101,TC:nil,Content:0,E
        DM:-3,File:nil,QS:0,BEC:nil
X-UUID: 2b76813eb41f48348a21649b3173fd44-20220424
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1129064879; Sun, 24 Apr 2022 10:57:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 24 Apr 2022 10:57:40 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 24 Apr 2022 10:57:39 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <eddie.huang@mediatek.com>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <fshao@chromium.org>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <tinghan.shen@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <hsin-hsiung.wang@mediatek.com>, <sean.wang@mediatek.com>,
        <macpaul.lin@mediatek.com>, <wen.su@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 0/1] Mediatek PMIC patch 
Date:   Sun, 24 Apr 2022 10:57:37 +0800
Message-ID: <20220424025738.32271-1-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix pwrap time out issue.

Changes in patch v3:
1)add fix tag in patch commmit message
2)fix file mode from "100755" to "100644"

Changes in patch v2:
1)add explation commit message on the patch.

Zhiyong.Tao (1):
  pwrap: mediatek: fix FSM timeout issue

 drivers/soc/mediatek/mtk-pmic-wrap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--
2.18.0


