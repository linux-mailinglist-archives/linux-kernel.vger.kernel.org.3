Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C8248BF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351265AbiALHje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:39:34 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:38286 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1351267AbiALHjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:39:32 -0500
X-UUID: f58b5cd259ad49a3a7d031d6a98f96cb-20220112
X-UUID: f58b5cd259ad49a3a7d031d6a98f96cb-20220112
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1094068246; Wed, 12 Jan 2022 15:39:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Jan 2022 15:39:27 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Jan 2022 15:39:27 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <Mark-YW.Chen@mediatek.com>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <michaelfsun@google.com>,
        <mcchou@chromium.org>, <shawnku@google.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] Bluetooth: btmtksdio: run sleep mode by default
Date:   Wed, 12 Jan 2022 15:39:16 +0800
Message-ID: <ed300b791b317f8ee20e22071e0fdcf82656f359.1641972745.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <bddfacd096b6fe927d08e48ad6993c17c9954028.1641972745.git.objelf@gmail.com>
References: <bddfacd096b6fe927d08e48ad6993c17c9954028.1641972745.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Apply sleep mode by default and a smaller idle time to reduce power
consumption further.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 3e8f19556e2c..491f029452ca 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -31,9 +31,9 @@
 
 #define VERSION "0.1"
 
-#define MTKBTSDIO_AUTOSUSPEND_DELAY	8000
+#define MTKBTSDIO_AUTOSUSPEND_DELAY	1000
 
-static bool enable_autosuspend;
+static bool enable_autosuspend = true;
 
 struct btmtksdio_data {
 	const char *fwname;
-- 
2.25.1

