Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F075718BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiGLLk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiGLLk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:40:56 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DEAADD55;
        Tue, 12 Jul 2022 04:40:54 -0700 (PDT)
X-UUID: eca9d4edfe584716b73a5dfbf7b8d069-20220712
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.8,REQID:09c501d6-9bcb-4616-b4d6-2ffcbdec1127,OB:10,L
        OB:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS6885AD
        ,ACTION:quarantine,TS:120
X-CID-INFO: VERSION:1.1.8,REQID:09c501d6-9bcb-4616-b4d6-2ffcbdec1127,OB:10,LOB
        :0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:120
X-CID-META: VersionHash:0f94e32,CLOUDID:edeb1364-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:fff0d761844a,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: eca9d4edfe584716b73a5dfbf7b8d069-20220712
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1310813838; Tue, 12 Jul 2022 19:40:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 12 Jul 2022 19:40:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 12 Jul 2022 19:40:48 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v3 0/5] Complete driver nodes for MT8192 SoC
Date:   Tue, 12 Jul 2022 19:40:41 +0800
Message-ID: <20220712114046.15574-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on matthias.bgg/linux.git, for-next.

I remove vcodec lat and core nodes PATCH from series and will comfirm
clocks usage then resend PATCH.

Also should reference below PATCH for dsi in chunkuang.hu/linux.git
dt-bindings: display: mediatek: dsi: Convert dsi_dtbinding to .yaml

changes since v2:
 - add mmsys #reset-cells PATCH
 - add missing fallback compatible
 - add display aliases
 - remove vcodec lat and core nodes PATCH

changes since v1:
 - add Reviewed-by Tag
 - rename dsi-phy from dsi-dphy
 - add missing power-domains in disp mutex
 - Add remove mt8192 display rdma compatible PATCH in series
 - use "mediatek,mt8183-disp-rdma" as fallback
 - remove mediatek,larb from rdma node
 - remove syscon-dsi and add power-domains in dsi
 - add reset property in dsi and mt8192-resets.h
 - correct Typo: s/ndoe/node in commit message

Allen-KH Cheng (5):
  arm64: dts: mt8192: Add pwm node
  arm64: dts: mt8192: Add mipi_tx node
  arm64: dts: mediatek: Add mmsys #reset-cells property for mt8192
  arm64: dts: mt8192: Add display nodes
  arm64: dts: mt8192: Add dsi node

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 188 +++++++++++++++++++++++
 1 file changed, 188 insertions(+)

-- 
2.18.0

