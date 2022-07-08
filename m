Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC30556B083
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 04:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbiGHCQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 22:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiGHCQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 22:16:12 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC627390B;
        Thu,  7 Jul 2022 19:16:09 -0700 (PDT)
X-UUID: 4b5c6b0d1828476c9f122c7c04ab4503-20220708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:cf60c3dd-b883-45f9-9ba7-8844576a3ab6,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:f7b2ebd6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 4b5c6b0d1828476c9f122c7c04ab4503-20220708
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1888232169; Fri, 08 Jul 2022 10:16:03 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 8 Jul 2022 10:16:02 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Jul 2022 10:16:01 +0800
From:   Xiangsheng Hou <xiangsheng.hou@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bin.zhang@mediatek.com>,
        <benliang.zhao@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: [PATCH V3 0/2] arm64: dts: mt8173: Fix nor flash node
Date:   Fri, 8 Jul 2022 10:15:46 +0800
Message-ID: <20220708021548.21453-1-xiangsheng.hou@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add axi clock since the driver change to DMA mode which need
to enable axi clock in dtsi and dt-binding example for mt8173.
And change spi clock to 26MHz as default.

Changes from v2:
- remove assigned clocks and parents in binding file

Changes from v1:
- Modify nor binding file

Xiangsheng Hou (2):
  arm64: dts: mt8173: Fix nor_flash node
  dt-bindings: mediatek: Add axi clock in mt8173 dts example

 .../devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml      | 4 ++--
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                   | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.25.1

