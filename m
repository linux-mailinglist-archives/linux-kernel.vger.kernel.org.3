Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890EB586EE9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiHAQnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiHAQnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:43:35 -0400
Received: from aer-iport-6.cisco.com (aer-iport-6.cisco.com [173.38.203.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05121CB2D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=763; q=dns/txt; s=iport;
  t=1659372213; x=1660581813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7bKU/max40ZItAtnxrkqrC/iL7usSK5236VIEYaZO4o=;
  b=EUerD7yJvvw14tteoJNZKuPvRY9udxBnlZjNSlXmYFCVoN7eC1Anvf+l
   AKt9H9gIttwknAvQeYi/+Ha3nkGGUpptQyjUgrKAQGDEe1IC5O90a2aBs
   ZF07Eyvt7n37j1hFEbvvBmi3gazqKizlmwoOVB97NIWixV+HRrPuelQOr
   E=;
X-IronPort-AV: E=Sophos;i="5.93,208,1654560000"; 
   d="scan'208";a="664904"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 01 Aug 2022 16:43:31 +0000
Received: from hce-anki.rd.cisco.com ([10.47.79.243])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 271GhT0R012552;
        Mon, 1 Aug 2022 16:43:30 GMT
From:   Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
Subject: [v4.9 PATCH v2 2/6] init/main: Fix double "the" in comment
Date:   Mon,  1 Aug 2022 18:43:24 +0200
Message-Id: <20220801164328.2205839-2-hegtvedt@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220801164328.2205839-1-hegtvedt@cisco.com>
References: <20220801164328.2205839-1-hegtvedt@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.79.243, [10.47.79.243]
X-Outbound-Node: aer-core-1.cisco.com
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

s/the\ the/the

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
(cherry picked from commit 6623f1c6150c09ce946c8e27a4c814d64919495b)
Signed-off-by: Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 30226a836c8..a6ecdd492ed 100644
--- a/init/main.c
+++ b/init/main.c
@@ -488,7 +488,7 @@ asmlinkage __visible void __init start_kernel(void)
 	debug_objects_early_init();
 
 	/*
-	 * Set up the the initial canary ASAP:
+	 * Set up the initial canary ASAP:
 	 */
 	add_latent_entropy();
 	boot_init_stack_canary();
-- 
2.34.1

