Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4909A49DAB3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbiA0Gb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:31:58 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:38956 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236754AbiA0Gby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:31:54 -0500
X-UUID: a4aa923f97c94bb3ace7faf3610493cd-20220127
X-UUID: a4aa923f97c94bb3ace7faf3610493cd-20220127
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1501907255; Thu, 27 Jan 2022 14:31:50 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 27 Jan 2022 14:31:49 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 27 Jan 2022 14:31:48 +0800
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
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 0/2] Add pwrap node for MediaTek MT8192 SoC and mt6359 node for MediaTek PMIC MT6359
Date:   Thu, 27 Jan 2022 14:31:43 +0800
Message-ID: <20220127063145.13413-1-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pathset add pwrap node to SoC MT8192, and add PMIC MT6359 related nodes.
MT6359 is the primary PMIC for MT8192 and probably other SoCs.

The series[1] and series[2] send by Hsin-Hsiung will continue to upstream in this pathset afterwards.

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/1615563286-22126-6-git-send-email-hsin-hsiung.wang@mediatek.com/
[2] https://patchwork.kernel.org/project/linux-mediatek/patch/1622011927-359-9-git-send-email-hsin-hsiung.wang@mediatek.com/

Hui Liu (2):
  arm64: dts: mt8192: add PWRAP node
  arm64: dts: mt6359: add PMIC MT6359 related nodes

 arch/arm64/boot/dts/mediatek/mt6359.dtsi    | 298 ++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8192-evb.dts |   1 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi    |  12 +
 3 files changed, 311 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6359.dtsi

--
2.25.1


