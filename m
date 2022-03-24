Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6C44E602A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348892AbiCXIQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348862AbiCXIQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:16:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E8E6D3BA;
        Thu, 24 Mar 2022 01:14:28 -0700 (PDT)
X-UUID: d810baca48ef4bbfb335a90d1fbddb77-20220324
X-UUID: d810baca48ef4bbfb335a90d1fbddb77-20220324
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1391887995; Thu, 24 Mar 2022 16:14:19 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 24 Mar 2022 16:14:18 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Mar 2022 16:14:17 +0800
From:   Hui-Liu Liu <hui.liu@mediatek.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <eddie.huang@mediatek.com>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <fshao@chromium.org>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <zhiyong.tao@mediatek.com>, <hsin-hsiung.wang@mediatek.com>,
        <sean.wang@mediatek.com>, <macpaul.lin@mediatek.com>,
        <yuchen.huang@mediatek.com>, <wen.su@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2 0/2] Add mt6359 node for MediaTek PMIC MT6359
Date:   Thu, 24 Mar 2022 16:14:11 +0800
Message-ID: <20220324081412.12045-1-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pathset add PMIC MT6359 related nodes.

The series[1] send by Hsin-Hsiung will continue to upstream in this pathset afterwards.
[1] https://patchwork.kernel.org/project/linux-mediatek/patch/1622011927-359-9-git-send-email-hsin-hsiung.wang@mediatek.com/

Changes in patch v2:
1)Only add mt6359.dtsi, mt8192-evb.dts no need update.

Changes in patch v1:
1)Add "SPDX-License-Identifier: (GPL-2.0 OR MIT)" in mt6359.dtsi.

Hui Liu (1):
  arm64: dts: mt6359: add PMIC MT6359 nodes

 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 298 +++++++++++++++++++++++
 1 file changed, 298 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6359.dtsi

--
2.18.0



