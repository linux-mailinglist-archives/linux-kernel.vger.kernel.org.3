Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75394623F0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhK2WHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:07:13 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44740 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229779AbhK2WFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:05:13 -0500
X-UUID: e9d9054cb79340fb9cfe2a5e45159849-20211130
X-UUID: e9d9054cb79340fb9cfe2a5e45159849-20211130
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 537633194; Tue, 30 Nov 2021 06:01:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 30 Nov 2021 06:01:49 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Nov 2021 06:01:49 +0800
From:   <sean.wang@mediatek.com>
To:     <lb@semihalf.com>
CC:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <upstream@semihalf.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Sean Wang" <sean.wang@mediatek.com>
Subject: =?UTF-8?q?Re=3A=5BPATCH=20v1=5D=20Bluetooth=3A=20btmtksdio=3A=20enable=20msft=20opcode?=
Date:   Tue, 30 Nov 2021 06:01:48 +0800
Message-ID: <1638223308-32622-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <20211126221034.21331-1-lukasz.bartosik@semihalf.com--annotate>
References: <20211126221034.21331-1-lukasz.bartosik@semihalf.com--annotate>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>Enable msft opcode for btmtksdio driver.
>
>Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
>---
> drivers/bluetooth/btmtksdio.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c index d9cf0c492e29..2a7a615663b9 100644
>--- a/drivers/bluetooth/btmtksdio.c
>+++ b/drivers/bluetooth/btmtksdio.c
>@@ -887,6 +887,7 @@ static int btmtksdio_setup(struct hci_dev *hdev)
>	if (enable_autosuspend)
>		pm_runtime_allow(bdev->dev);
>
>+	hci_set_msft_opcode(hdev, 0xFD30);

Hi Łukasz,

msft feature is supposed only supported on mt7921. Could you help rework the patch to enalbe msft opocde only for mt7921?

	Sean

>	bt_dev_info(hdev, "Device setup in %llu usecs", duration);
>
>	return 0;
>
