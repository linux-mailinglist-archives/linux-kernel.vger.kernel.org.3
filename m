Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97BE488BFA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbiAITYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:24:17 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:49692 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236466AbiAITYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:24:16 -0500
X-UUID: 4245f4e59f954e49ac963be9702e01f6-20220110
X-UUID: 4245f4e59f954e49ac963be9702e01f6-20220110
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1934936454; Mon, 10 Jan 2022 03:24:13 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 10 Jan 2022 03:24:11 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Jan 2022 03:24:05 +0800
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
Subject: [PATCH v5 1/5] Bluetooth: btmtksdio: rename btsdio_mtk_reg_read
Date:   Mon, 10 Jan 2022 03:23:57 +0800
Message-ID: <a22b710e69551c3503203f73ea898504cb634815.1641755121.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Using "btmtksdio" as the prefix instead of "btsdio"

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v5: new created to make the series better
---
 drivers/bluetooth/btmtksdio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index b5ea8d3bffaa..891e34b50e44 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -797,7 +797,7 @@ static int mt79xx_setup(struct hci_dev *hdev, const char *fwname)
 	return err;
 }
 
-static int btsdio_mtk_reg_read(struct hci_dev *hdev, u32 reg, u32 *val)
+static int btmtksdio_mtk_reg_read(struct hci_dev *hdev, u32 reg, u32 *val)
 {
 	struct btmtk_hci_wmt_params wmt_params;
 	struct reg_read_cmd {
@@ -844,13 +844,13 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 
 	switch (bdev->data->chipid) {
 	case 0x7921:
-		err = btsdio_mtk_reg_read(hdev, 0x70010200, &dev_id);
+		err = btmtksdio_mtk_reg_read(hdev, 0x70010200, &dev_id);
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to get device id (%d)", err);
 			return err;
 		}
 
-		err = btsdio_mtk_reg_read(hdev, 0x80021004, &fw_version);
+		err = btmtksdio_mtk_reg_read(hdev, 0x80021004, &fw_version);
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to get fw version (%d)", err);
 			return err;
-- 
2.25.1

