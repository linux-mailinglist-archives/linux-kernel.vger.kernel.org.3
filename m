Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A88D4B1820
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344947AbiBJW1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:27:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344939AbiBJW1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:27:19 -0500
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E8F262B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:27:18 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id IHuGnjGRR9r2MIHuGnUs0Z; Thu, 10 Feb 2022 23:27:17 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 10 Feb 2022 23:27:17 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jhansen@vmware.com, vdasa@vmware.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, acking@vmware.com, dtor@vmware.com
Cc:     pv-drivers@vmware.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/3] VMCI: Fix the description of vmci_check_host_caps()
Date:   Thu, 10 Feb 2022 23:27:15 +0100
Message-Id: <7f7ad8c171566f6f8716c3451b9ddc2e83fe003f.1644531317.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1644531317.git.christophe.jaillet@wanadoo.fr>
References: <cover.1644531317.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmci_check_host_caps() doesn't return a bool but an int.
Fix the description accordingly.

Fixes: 	782f24453536 ("VMCI: fix error handling path when registering guest driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index aa61a687b3e2..1a1858742f75 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -253,9 +253,9 @@ static void vmci_guest_cid_update(u32 sub_id,
 
 /*
  * Verify that the host supports the hypercalls we need. If it does not,
- * try to find fallback hypercalls and use those instead.  Returns
- * true if required hypercalls (or fallback hypercalls) are
- * supported by the host, false otherwise.
+ * try to find fallback hypercalls and use those instead.  Returns 0 if
+ * required hypercalls (or fallback hypercalls) are supported by the host,
+ * an error code otherwise.
  */
 static int vmci_check_host_caps(struct pci_dev *pdev)
 {
-- 
2.32.0

