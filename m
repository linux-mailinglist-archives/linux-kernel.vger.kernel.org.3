Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E37519EA4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349184AbiEDL71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349137AbiEDL6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:58:52 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808702CE35;
        Wed,  4 May 2022 04:55:10 -0700 (PDT)
X-UUID: 517ca73b13304fdd86de5c8fc96a84d0-20220504
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:3430fc7a-dc07-4ec4-afa8-7f6fdc023c76,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:1fe38ab2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 517ca73b13304fdd86de5c8fc96a84d0-20220504
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1246745641; Wed, 04 May 2022 19:55:04 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 4 May 2022 19:55:03 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 4 May 2022 19:55:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 4 May 2022 19:55:03 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>
CC:     <runyang.chen@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v2 0/3] Support MediaTek devapc for MT8186
Date:   Wed, 4 May 2022 19:54:58 +0800
Message-ID: <20220504115501.3490-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

This series is for supporting devapc implementation in MT8186.

V2:
- Add a patch to separate register offsets from mtk_devapc_data.

V1:
- Add dt-binding and add devapc data for MT8186.

Rex-BC Chen (3):
  dt-bindings: soc: mediatek: devapc: Add bindings for MT8186
  soc: mediatek: devapc: Separate register offsets from mtk_devapc_data
  soc: mediatek: devapc: Add support for MT8186

 .../bindings/soc/mediatek/devapc.yaml         |  1 +
 drivers/soc/mediatek/mtk-devapc.c             | 45 ++++++++++++-------
 2 files changed, 31 insertions(+), 15 deletions(-)

-- 
2.18.0

