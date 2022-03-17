Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB564DBD5A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 04:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357784AbiCQDFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 23:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351200AbiCQDFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 23:05:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF4720F6C;
        Wed, 16 Mar 2022 20:04:14 -0700 (PDT)
X-UUID: b0a3504a0d5b4d20a47500d61da2107b-20220317
X-UUID: b0a3504a0d5b4d20a47500d61da2107b-20220317
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1617154245; Thu, 17 Mar 2022 11:04:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 17 Mar 2022 11:04:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 11:04:07 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [PATCH v2 0/2] Add support for MediaTek PMIC MT6366
Date:   Thu, 17 Mar 2022 11:04:00 +0800
Message-ID: <20220317030402.24894-1-johnson.wang@mediatek.com>
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

This patchset adds support for MediaTek PMIC MT6366.
MT6366 is the primary PMIC for MT8186 and probably other SOCs.

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

