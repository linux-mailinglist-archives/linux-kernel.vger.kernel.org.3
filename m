Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8C94F7E1F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244808AbiDGLjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbiDGLjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:39:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF452296EA;
        Thu,  7 Apr 2022 04:37:13 -0700 (PDT)
X-UUID: 57b3179c527f47a4b8d2ce2371b1241d-20220407
X-UUID: 57b3179c527f47a4b8d2ce2371b1241d-20220407
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 361385714; Thu, 07 Apr 2022 19:37:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 7 Apr 2022 19:37:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Apr 2022 19:37:05 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 0/1] mt8192: Add mmc device nodes
Date:   Thu, 7 Apr 2022 19:37:02 +0800
Message-ID: <20220407113703.26423-1-allen-kh.cheng@mediatek.com>
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

Take mmc device patch from series 20220330133816.30806-1-allen-kh.cheng@mediatek.com/
This series are based on matthias.bgg/linux.git, v5.18-next/dts64

In mt8192 SoC.
mmc driver would directly read/write register(11f60000) to control clock configure.
Alos there is no other module using msdc: clock-controller.
In order to not cause duplicate unit-address warning, I remove the clock-controller
entirely.

changes since v1:
- remove msdc clock node

Changes history of mmc:
- mmc: diable the msdc clock node, drop reviewed-by tags.
- mmc: reserve msdc node
- mmc: reorder clocks as specified in the dt-bindings
- mmc: use single line for reg

Allen-KH Cheng (1):
  arm64: dts: mt8192: Add mmc device nodes

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 34 +++++++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

-- 
2.18.0

