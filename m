Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90694BB51E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiBRJRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:17:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiBRJRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:17:02 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB019FEC;
        Fri, 18 Feb 2022 01:16:40 -0800 (PST)
X-UUID: e3739d75ae834d13ad251c581e80aea4-20220218
X-UUID: e3739d75ae834d13ad251c581e80aea4-20220218
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 749468472; Fri, 18 Feb 2022 17:16:37 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 18 Feb 2022 17:16:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Feb 2022 17:16:35 +0800
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
Subject: [PATCH v2 00/23] Add driver nodes for MT8192 SoC 
Date:   Fri, 18 Feb 2022 17:16:10 +0800
Message-ID: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
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
and apply the below patchs 
https://patchwork.kernel.org/project/linux-mediatek/patch/20220207094024.22674-1-allen-kh.cheng@mediatek.com/
https://patchwork.kernel.org/project/linux-mediatek/patch/20220217135620.10559-1-allen-kh.cheng@mediatek.com/

There some patches are missed in PATCH v1.
I resend series again and also add display related nodes in PATCH v2.

changes since v1:
- add usb-phy node for xhci node
- move infracfg_rst patch in front of PCIe patch
- add display nodes, i2c aliases and pwm node.

Allen-KH Cheng (23):
  arm64: dts: mt8192: Add power domains controller
  arm64: dts: mt8192: Add pwrap node
  arm64: dts: mt8192: Add spmi node
  arm64: dts: mt8192: Add gce node
  arm64: dts: mt8192: Add SCP node
  arm64: dts: mt8192: Add usb-phy node
  arm64: dts: mt8192: Add xhci node
  arm64: dts: mt8192: Add audio-related nodes
  arm64: dts: mt8192: Add infracfg_rst node
  arm64: dts: mt8192: Add PCIe node
  arm64: dts: mt8192: Correct nor_flash status of mt8192
  arm64: dts: mt8192: Add efuse node
  arm64: dts: mt8192: Add mmc device nodes
  arm64: dts: mt8192: Add mipi_tx node
  arm64: dts: mt8192: Add m4u and smi nodes
  arm64: dts: mt8192: Add H264 venc device node
  arm64: dts: mt8192: Add vcodec lat and core nodes
  arm64: dts: mt8192: Add dpi node
  arm64: dts: mt8192: Add i2c aliases
  arm64: dts: mt8192: Add display nodes
  arm64: dts: mt8192: Add dsi node
  arm64: dts: mt8192: Add gce info for display nodes
  arm64: dts: mt8192: Add pwm node

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 1000 +++++++++++++++++++++-
 1 file changed, 989 insertions(+), 11 deletions(-)

-- 
2.18.0

