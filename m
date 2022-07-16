Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04867579D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241987AbiGSMwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241705AbiGSMuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:50:15 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB4C8EEF0;
        Tue, 19 Jul 2022 05:19:59 -0700 (PDT)
X-QQ-mid: bizesmtp70t1658233192tb7rcuw9
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:19:51 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: 5pqgkH0Zr9WSYSH9EVvGoHl13qkoiczbT5y7djPQqoHGReBpNCKYWor8+tGcl
        vsupAiOE48SFOK62d61gbv9S3UjRToTQmkH5YR9rcoyjbM3ahUApmjqln0jyjRNQMdQhoRC
        ED3x5n9Sihg6A9DZznrsurSrT4WI7k2d1Fople1P8boWCKh2qknslb9+sVkM3qt/wfBdCUP
        AxsR0qXGWF3dgi679s6HlGLZcAJAaFGGeLwgJYlVcc41ki/4cwuMKLB0iXYu13WdDmnVoyM
        /+EOobLxtDJv0UkLgYrQxIayq5cCcl8yFY7gaDH8AFbSpYUXarMx22YcTfT3wJWePA8zXN+
        WT50w0gL1wOWMTAKJE9DckCsspzVic2HDdinaUtXahiFwwTf+dQawuXQOQizRnAlWTTfIbe
        3zaQKebWtP8=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     gregkh@linuxfoundation.org
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] xhci: Fix comment typo
Date:   Sat, 16 Jul 2022 12:17:55 +0800
Message-Id: <20220716041755.34016-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/usb/host/xhci-ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.35.1

