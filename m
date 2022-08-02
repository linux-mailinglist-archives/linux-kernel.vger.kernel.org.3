Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13A65884EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiHBXyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiHBXyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:54:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F6E5464E;
        Tue,  2 Aug 2022 16:54:42 -0700 (PDT)
X-UUID: 29ffd97a8f0c475bbce18b9c714f8db8-20220803
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:290dd0ef-930b-4f35-ab16-617b4ca1eac6,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:90
X-CID-INFO: VERSION:1.1.8,REQID:290dd0ef-930b-4f35-ab16-617b4ca1eac6,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:90
X-CID-META: VersionHash:0f94e32,CLOUDID:377e1525-a982-4824-82d2-9da3b6056c2a,C
        OID:7d9806452e3c,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 29ffd97a8f0c475bbce18b9c714f8db8-20220803
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 436032328; Wed, 03 Aug 2022 07:54:39 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 3 Aug 2022 07:54:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 3 Aug 2022 07:54:38 +0800
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
Subject: [PATCH v5 0/5] scsi: ufs-mediatek: Provide features and fixes in MediaTek platforms
Date:   Wed, 3 Aug 2022 07:54:32 +0800
Message-ID: <20220802235437.4547-1-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

This series provides some features and fixes in MediaTek UFS platforms.
Please consider this patch series for kernel v5.20.

Changes since v4:
 - Fix typo in the patch "scsi: ufs: ufs-mediatek: Support clk-scaling to optimize power consumption"
 
Changes since v3:
 - Fix some type errors caught by Coverity Tool

Changes since v2:
 - Remove Change-ID tag in patch "scsi: ufs: ufs-mediatek: Remove redundant header files" (Bart)
 - Move const string table to ufs-mediatek.c from ufs-mediatek.h (Bart)

Changes since v1:
 - Remove unnecessary changes in patch "scsi: ufs: ufs-mediatek: Fix performance scaling"

Peter Wang (2):
  scsi: ufs: ufs-mediatek: Dump more registers
  scsi: ufs: ufs-mediatek: Fix performance scaling

Po-Wen Kao (1):
  scsi: ufs: ufs-mediatek: Support clk-scaling to optimize power
    consumption

Stanley Chu (2):
  scsi: ufs: ufs-mediatek: Remove redundant header files
  scsi: ufs: ufs-mediatek: Provide detailed description for UIC errors

 drivers/ufs/host/ufs-mediatek-trace.h |  27 +++-
 drivers/ufs/host/ufs-mediatek.c       | 205 +++++++++++++++++++++++++-
 drivers/ufs/host/ufs-mediatek.h       |   7 +
 3 files changed, 230 insertions(+), 9 deletions(-)

-- 
2.18.0

