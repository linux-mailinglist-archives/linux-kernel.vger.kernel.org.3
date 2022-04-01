Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39D64EE976
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344155AbiDAIEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344126AbiDAIE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:04:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009CA1CABCE;
        Fri,  1 Apr 2022 01:02:35 -0700 (PDT)
X-UUID: 93d2fd38057740cc9e3ce94c513447b5-20220401
X-UUID: 93d2fd38057740cc9e3ce94c513447b5-20220401
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 320020926; Fri, 01 Apr 2022 16:02:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 1 Apr 2022 16:02:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Apr 2022 16:02:26 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [RESEND v2 0/2] Add support for MediaTek PMIC MT6366
Date:   Fri, 1 Apr 2022 16:02:10 +0800
Message-ID: <20220401080212.27383-1-johnson.wang@mediatek.com>
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

This patchset adds support for MediaTek PMIC MT6366.
MT6366 is the primary PMIC for MT8186 and probably other SOCs.

Resend v2:
- rebase on Linux 5.17

Changes in v2:
- rebase on Linux 5.17-rc8
- change subject line

Johnson Wang (2):
  regulator: mt6366: Add support for MT6366 regulator
  dt-bindings: regulator: Add BUCK and LDO document for MT6358 and
    MT6366

 .../bindings/regulator/mt6358-regulator.txt   |  22 +-
 drivers/regulator/mt6358-regulator.c          | 213 +++++++++++++++++-
 include/linux/regulator/mt6358-regulator.h    |  45 ++++
 3 files changed, 270 insertions(+), 10 deletions(-)

-- 
2.18.0

