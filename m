Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166CF471A98
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 15:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhLLONn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 09:13:43 -0500
Received: from smtpbg587.qq.com ([113.96.223.105]:38268 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231360AbhLLONj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 09:13:39 -0500
X-QQ-mid: bizesmtp49t1639318378tou9orcr
Received: from wangx.lan (unknown [171.221.148.2])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 22:12:49 +0800 (CST)
X-QQ-SSF: 0100000000200080C000B00A0000000
X-QQ-FEAT: +MMDnLImGVVTC1Y2RYorhmu8nk9J8RChUqXXevMrV+3vYon+084Qlh4gFse78
        zDeN2m82ojdIL0JGarQj75sgX8DcwG1jaV8/Q0QAc1SGC9a435pj8vapG2QPYYk61hyHaqa
        1J6IfbjoHPEvkwRQrfoDuRFAB/SaGZKFrgkiJxs3vTkLcSR0K0SmZFd2zDCsPp9JV3AfA1q
        8MvThskcPDOs2QOiOgZrGaAx8d4q8NN5JcYnGf2uK4eBdIl+kbmKWTkcG9lkRdznGFiF8O4
        BxPSBMan5FW0oyc497T4lejyoYTI57F1+R/53W+/21w/ZVJoJEyFdXuefF/iThF1lEcJTm2
        NixdVap517PNBxRfck=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     monstr@monstr.eu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] microblaze: add const to of_device_id
Date:   Sun, 12 Dec 2021 22:12:48 +0800
Message-Id: <20211212141248.7134-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct of_device_id should normally be const.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 arch/microblaze/pci/xilinx_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/pci/xilinx_pci.c b/arch/microblaze/pci/xilinx_pci.c
index b800909ddccf..f4cb86fffcee 100644
--- a/arch/microblaze/pci/xilinx_pci.c
+++ b/arch/microblaze/pci/xilinx_pci.c
@@ -27,7 +27,7 @@
 #define PCI_HOST_ENABLE_CMD (PCI_COMMAND_SERR | PCI_COMMAND_PARITY | \
 				PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY)
 
-static struct of_device_id xilinx_pci_match[] = {
+static const struct of_device_id xilinx_pci_match[] = {
 	{ .compatible = "xlnx,plbv46-pci-1.03.a", },
 	{}
 };
-- 
2.20.1

