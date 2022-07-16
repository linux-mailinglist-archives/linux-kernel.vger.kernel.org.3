Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDF0576E32
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiGPNcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGPNcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:32:04 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36921903F;
        Sat, 16 Jul 2022 06:31:58 -0700 (PDT)
X-QQ-mid: bizesmtp76t1657978299tkxijqkf
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 21:31:35 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: tnN4C/PdIDUH5M3+9HbKBvi8qoEujs23VsHfFNI7f625tUkxiBLMBU51wYxgi
        TbX7sXTD34GnB0y+o83Yirrl4qmDiC9sbTGVCk1kCxbhQtaEStznEqbrGyPJJV7keu59r6f
        +X7HfbD7gmXzyzkbCDYMaBH42UpA1RfWhssWBY+h/L4jQLqVUTgI9SZXgEM/4ZLnQvJX92R
        j56Cb76y37lWa+OgMlodpKi5SDOJOcB+RVnA2bQTBah1rvc2juWUKxclVy2JaL3g7O4lPYC
        GP6J3AMW0wLAN+csJ0U0NjB1/yqFxOqYsGKsPo7CTodvZSlQRGAnqNgwUyEIUseSUazR/qq
        jclbsIViDsIB7yZ9CVmt4n+SmG0f0vRsOGXnTD1juFvAMqVX70vnZSvyKURpg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        mathias.nyman@intel.com
Cc:     linux-usb@vger.kernel.org, inux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/host: fix repeated words in comments
Date:   Sat, 16 Jul 2022 21:31:29 +0800
Message-Id: <20220716133129.40575-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'to'.
 Delete the redundant word 'the'.
 Delete the redundant word 'then'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/host/uhci-platform.c | 2 +-
 drivers/usb/host/uhci-q.c        | 2 +-
 drivers/usb/host/xhci-ring.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
index b2049b47a08d..c7ef58c05276 100644
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -20,7 +20,7 @@ static int uhci_platform_init(struct usb_hcd *hcd)
 	if (!uhci->rh_numports)
 		uhci->rh_numports = uhci_count_ports(hcd);
 
-	/* Set up pointers to to generic functions */
+	/* Set up pointers to generic functions */
 	uhci->reset_hc = uhci_generic_reset_hc;
 	uhci->check_and_reset_hc = uhci_generic_check_and_reset_hc;
 
diff --git a/drivers/usb/host/uhci-q.c b/drivers/usb/host/uhci-q.c
index 35fcb826152c..e7f4c1f28349 100644
--- a/drivers/usb/host/uhci-q.c
+++ b/drivers/usb/host/uhci-q.c
@@ -345,7 +345,7 @@ static int uhci_cleanup_queue(struct uhci_hcd *uhci, struct uhci_qh *qh,
 		goto done;
 	}
 
-	/* If the QH element pointer is UHCI_PTR_TERM then then currently
+	/* If the QH element pointer is UHCI_PTR_TERM then currently
 	 * executing URB has already been unlinked, so this one isn't it. */
 	if (qh_element(qh) == UHCI_PTR_TERM(uhci))
 		goto done;
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 46d0b9ad6f74..ad81e9a508b1 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1964,7 +1964,7 @@ static void handle_port_status(struct xhci_hcd *xhci,
 
 	/*
 	 * Check to see if xhci-hub.c is waiting on RExit to U0 transition (or
-	 * RExit to a disconnect state).  If so, let the the driver know it's
+	 * RExit to a disconnect state).  If so, let the driver know it's
 	 * out of the RExit state.
 	 */
 	if (!DEV_SUPERSPEED_ANY(portsc) && hcd->speed < HCD_USB3 &&
-- 
2.36.1

