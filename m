Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC0857DF51
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiGVJyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiGVJx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:53:59 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E086038E;
        Fri, 22 Jul 2022 02:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OzUVj
        nFEBSG1Mni6LZL4NlaeSFXIxDd6cmqg+IKNI2E=; b=XKwJ7T5K5vZxN2cenHcu5
        nAlDdrP8dvHVaYPIkMKlXPR8fw/lbqkMz/ZjuGeJBmrmYnlSfCC8MY1sqMLTw+nW
        l3ABudc2nfpf+ylOGeae4Au9d24fiiramtm6MwgGOehLT0Ubx7XC2pJn4PrQl/F8
        UTWDOqKx+ZMsBck9RfFakA=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp3 (Coremail) with SMTP id G9xpCgC39aGWc9piDjKVQg--.7748S2;
        Fri, 22 Jul 2022 17:53:28 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] xhci: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 17:53:25 +0800
Message-Id: <20220722095325.78891-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgC39aGWc9piDjKVQg--.7748S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr1kAr4kAF1xAr13urg_yoW3Arc_uF
        yj9r4xG3srCrZIyr1I93Z5ZayIkw18Ww1kZF4IgryrWw17ur18Z34vv3yktF95Cr47Jr9x
        uw45WFy8Z3y8ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRt7KxJUUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiRxlGZFc7YxF04AAAs2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
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
2.25.1

