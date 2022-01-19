Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD7493A93
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349701AbiASMhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:37:41 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:54034 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1347480AbiASMhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:37:19 -0500
X-UUID: f599c721178142498a9791e33a340fae-20220119
X-UUID: f599c721178142498a9791e33a340fae-20220119
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2019721483; Wed, 19 Jan 2022 20:37:15 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Jan 2022 20:37:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 20:37:14 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     John Crispin <john@phrozen.org>, Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH 1/1] clk: mediatek: relicense mt7986 clock driver to GPL-2.0
Date:   Wed, 19 Jan 2022 20:36:58 +0800
Message-ID: <20220119123658.10095-2-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220119123658.10095-1-sam.shih@mediatek.com>
References: <20220119123658.10095-1-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous mt7986 clock drivers were incorrectly marked as GPL-1.0.
This patch changes the driver to the standard GPL-2.0 license.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 drivers/clk/mediatek/clk-mt7986-apmixed.c  | 2 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c | 2 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986-apmixed.c b/drivers/clk/mediatek/clk-mt7986-apmixed.c
index 76c8ebdeae96..98ec3887585f 100644
--- a/drivers/clk/mediatek/clk-mt7986-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7986-apmixed.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2021 MediaTek Inc.
  * Author: Sam Shih <sam.shih@mediatek.com>
diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
index 3be168c34fc0..f209c559fbc3 100644
--- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2021 MediaTek Inc.
  * Author: Sam Shih <sam.shih@mediatek.com>
diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
index 8550e2be7773..8f6f79b6e31e 100644
--- a/drivers/clk/mediatek/clk-mt7986-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-1.0
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2021 MediaTek Inc.
  * Author: Sam Shih <sam.shih@mediatek.com>
-- 
2.29.2

