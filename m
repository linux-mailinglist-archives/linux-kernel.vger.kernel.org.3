Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686ED5142B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354809AbiD2G57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353499AbiD2G5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:57:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25CDBCB59;
        Thu, 28 Apr 2022 23:54:37 -0700 (PDT)
X-UUID: c6e9701ec3244b9789c6d93cd1eb86c9-20220429
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:0903472b-a29f-43fe-a6eb-556425391ebd,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:95
X-CID-INFO: VERSION:1.1.4,REQID:0903472b-a29f-43fe-a6eb-556425391ebd,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:95
X-CID-META: VersionHash:faefae9,CLOUDID:f00ceec6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:d4a98fd054f3,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: c6e9701ec3244b9789c6d93cd1eb86c9-20220429
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 379590242; Fri, 29 Apr 2022 14:54:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 29 Apr 2022 14:54:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Apr 2022 14:54:30 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>
CC:     <neal.liu@mediatek.com>, <runyang.chen@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH 0/2] Support MediaTek devapc for MT8186
Date:   Fri, 29 Apr 2022 14:54:27 +0800
Message-ID: <20220429065429.7957-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is for supporting devapc implementation in MT8186.

V1:
- Add dt-binding and add devapc data for MT8186.

Rex-BC Chen (2):
  dt-bindings: soc: mediatek: devapc: Add bindings for MT8186
  soc: mediatek: devapc: Add support for MT8186

 .../devicetree/bindings/soc/mediatek/devapc.yaml  |  1 +
 drivers/soc/mediatek/mtk-devapc.c                 | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

-- 
2.18.0

