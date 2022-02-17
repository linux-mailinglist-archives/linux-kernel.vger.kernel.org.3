Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440684BA189
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbiBQNlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:41:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbiBQNlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:41:02 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47052AF939;
        Thu, 17 Feb 2022 05:40:36 -0800 (PST)
X-UUID: de127025cc724384ab29a0e33f730f5c-20220217
X-UUID: de127025cc724384ab29a0e33f730f5c-20220217
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 159377177; Thu, 17 Feb 2022 21:40:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 17 Feb 2022 21:40:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Feb 2022 21:40:29 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 00/17] Add driver nodes for MT8192 SoC 
Date:   Thu, 17 Feb 2022 21:40:18 +0800
Message-ID: <20220217134027.508-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on tag: next-20220216, linux-next/master
and apply the below patch
https://patchwork.kernel.org/project/linux-mediatek/patch/20220207094024.22674-1-allen-kh.cheng@mediatek.com/

Allen-KH Cheng (17):
  arm64: dts: mt8192: Add power domains controller
  arm64: dts: mt8192: add pwrap node
  arm64: dts: mt8192: add spmi node
  arm64: dts: mt8192: Add gce node
  arm64: dts: mt8192: Add SCP node
  arm64: dts: mt8192: Add xhci node
  arm64: dts: mt8192: Add audio-related nodes
  arm64: dts: mt8192: Add PCIe node
  arm64: dts: mt8192: Correct nor_flash status of mt8192
  arm64: dts: mt8192: Add efuse node
  arm64: dts: mt8192: add mmc device nodes
  arm64: dts: mt8192: Add infracfg_rst node
  arm64: dts: mt8192: Add mipi_tx node
  arm64: dts: mt8192: Add m4u and smi nodes
  arm64: dts: mt8192: Add H264 venc device node
  arm64: dts: mt8192: Add vcodec lat and core node.
  arm64: dts: mt8192: Add dpi node

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 801 ++++++++++++++++++++++-
 1 file changed, 790 insertions(+), 11 deletions(-)

-- 
2.18.0

