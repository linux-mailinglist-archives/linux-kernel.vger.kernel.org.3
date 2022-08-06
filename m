Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7855C58B6B8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiHFQPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHFQPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:15:13 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E3DB2F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 09:15:11 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id KMSCooJPV3uMYKMSCokiFG; Sat, 06 Aug 2022 18:15:09 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Aug 2022 18:15:09 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     paulmck@kernel.org, vschneid@redhat.com,
        rafael.j.wysocki@intel.com, nsaenzju@redhat.com,
        frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] cpu_pm: Fix a typo in a comment
Date:   Sat,  6 Aug 2022 18:15:08 +0200
Message-Id: <763d2d098793c858887cf8b935dc35bcdb522396.1659802446.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/cpm_pm/cpm_pm/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
  kernel/cpu_pm.c            and
  include/linux/cpu_pm.h
seem to be orphans in MAINTAINERS. Is it expected?
---
 include/linux/cpu_pm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpu_pm.h b/include/linux/cpu_pm.h
index 552b8f9ea05e..e8608ccdc134 100644
--- a/include/linux/cpu_pm.h
+++ b/include/linux/cpu_pm.h
@@ -16,7 +16,7 @@
  * When a CPU goes to a low power state that turns off power to the CPU's
  * power domain, the contents of some blocks (floating point coprocessors,
  * interrupt controllers, caches, timers) in the same power domain can
- * be lost.  The cpm_pm notifiers provide a method for platform idle, suspend,
+ * be lost.  The cpu_pm notifiers provide a method for platform idle, suspend,
  * and hotplug implementations to notify the drivers for these blocks that
  * they may be reset.
  *
-- 
2.34.1

