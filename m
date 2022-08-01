Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1C9586EEB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiHAQnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiHAQnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:43:37 -0400
Received: from aer-iport-4.cisco.com (aer-iport-4.cisco.com [173.38.203.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16D51EC73
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=990; q=dns/txt; s=iport;
  t=1659372214; x=1660581814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F+lH4pP/y3g/TAamKgOUQCpvYguFUQgzVOy+l7vRKxY=;
  b=TDI3iQkfVgqza0MhQc4ESUNNF2lPjyaqjIoTJDjoDipDvW8uTARChcWX
   ae7asjr5QXlaQNGPdRJQTp2aO412OrDxo0Cv1+RchoVhOvmEocuGOhqz9
   /fDYaaBgNR/N5lCaK7hSEjOzAZHtBSP5fX0lUO7k7Rtkw0cy9px3n852l
   M=;
X-IronPort-AV: E=Sophos;i="5.93,208,1654560000"; 
   d="scan'208";a="3295290"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 01 Aug 2022 16:43:32 +0000
Received: from hce-anki.rd.cisco.com ([10.47.79.243])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 271GhT0S012552;
        Mon, 1 Aug 2022 16:43:32 GMT
From:   Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
Subject: [v4.9 PATCH v2 3/6] init/main: properly align the multi-line comment
Date:   Mon,  1 Aug 2022 18:43:25 +0200
Message-Id: <20220801164328.2205839-3-hegtvedt@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220801164328.2205839-1-hegtvedt@cisco.com>
References: <20220801164328.2205839-1-hegtvedt@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.79.243, [10.47.79.243]
X-Outbound-Node: aer-core-1.cisco.com
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

Add a tab before it to follow standard practices. Also add the missing
full stop '.'.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
(cherry picked from commit 1b3b3b49b9961401331a1b496db5bec5c7b41ae6)
Signed-off-by: Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
---
 init/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/init/main.c b/init/main.c
index a6ecdd492ed..8b803078d7b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -498,10 +498,10 @@ asmlinkage __visible void __init start_kernel(void)
 	local_irq_disable();
 	early_boot_irqs_disabled = true;
 
-/*
- * Interrupts are still disabled. Do necessary setups, then
- * enable them
- */
+	/*
+	 * Interrupts are still disabled. Do necessary setups, then
+	 * enable them.
+	 */
 	boot_cpu_init();
 	page_address_init();
 	pr_notice("%s", linux_banner);
-- 
2.34.1

