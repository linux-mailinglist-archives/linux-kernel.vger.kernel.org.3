Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649AE4860BC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 07:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbiAFGyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 01:54:24 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:39110 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234699AbiAFGyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 01:54:23 -0500
X-UUID: 178b2a10122641adbab4db01c6fc3516-20220106
X-UUID: 178b2a10122641adbab4db01c6fc3516-20220106
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1931444049; Thu, 06 Jan 2022 14:54:18 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 6 Jan 2022 14:54:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Jan 2022 14:54:17 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>, <broonie@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [PATCH 0/4] Add Support for MediaTek PMIC MT6366
Date:   Thu, 6 Jan 2022 14:54:03 +0800
Message-ID: <20220106065407.16036-1-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for MediaTek PMIC MT6366.
MT6366 is the primary PMIC for MT8186 and probably other SOCs.

Johnson Wang (4):
  mfd: Add support for the MediaTek MT6366 PMIC
  regulator: mt6366: Add support for MT6366 regulator
  dt-bindings: mfd: Add compatible for the MediaTek MT6366 PMIC
  dt-bindings: regulator: Add MT6358 regulators

 .../devicetree/bindings/mfd/mt6397.txt        |   2 +-
 .../bindings/regulator/mt6358-regulator.txt   |  22 +-
 drivers/mfd/mt6358-irq.c                      |   1 +
 drivers/regulator/mt6358-regulator.c          | 213 +++++++++++++++++-
 include/linux/mfd/mt6358/registers.h          |   7 +
 include/linux/mfd/mt6397/core.h               |   1 +
 include/linux/regulator/mt6358-regulator.h    |  45 ++++
 7 files changed, 280 insertions(+), 11 deletions(-)

-- 
2.18.0

