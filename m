Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B2158E14B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 22:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245712AbiHIUof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 16:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343592AbiHIUoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 16:44:30 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6597B2251E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 13:44:28 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id LW5SoZmsiPMmaLW5SoEzm4; Tue, 09 Aug 2022 22:44:26 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 09 Aug 2022 22:44:26 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] cpu_pm: Fix a typo in a comment
Date:   Tue,  9 Aug 2022 22:44:24 +0200
Message-Id: <803d5d09a793c85888fcf8b9354c35bc0b512396.1659802446.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/cpm_pm/cpu_pm/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
  kernel/cpu_pm.c            and
  include/linux/cpu_pm.h
seem to be orphans in MAINTAINERS. Is it expected?

Changes in v2:
  * fix a typo in the changelog explaining that it was fixing a typo :(
    [Dan Carpenter <dan.carpenter@oracle.com>]
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

