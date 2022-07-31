Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9399C58605D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 20:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbiGaS2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 14:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbiGaS2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 14:28:10 -0400
Received: from aer-iport-4.cisco.com (aer-iport-4.cisco.com [173.38.203.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31D6BE1F
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1897; q=dns/txt; s=iport;
  t=1659292087; x=1660501687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z3LO+JP8HDIgBnL70ETLbDLvAFI0OSC3OOOwkBAeHVg=;
  b=D9dQQ6jYsM1oHilB3dsiaPj+NIqvt1AZ+1vtcZjVCNLNzsQihqlBdnA3
   6O4yLp0AGgMkZgNeCD3P00O0PxCeYhc2tjeDoZWxXp7JTFGJ6fAoB1s7D
   dN3IZYCiOTQeMNxjCsrtI4gQC8E1rQjRy6xbi1AO+43nMxND9ipO3mMZD
   o=;
X-IPAS-Result: =?us-ascii?q?A0ANAADAyOZilxbLJq1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AYBAQsBgyRWLBJFjUyIEIsgkVmBJQNUCwEBAQ83CwQBAYUGAoR1JjUIDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEHBBQBAQEBAQEBAQkbBgwFEDWFaA2GQ?=
 =?us-ascii?q?wMDMgFGEB0DMSEoDhmCfQGCZQMyAxCmXYIrgQGDTwGDWA2CTIE9AYYyg0aFJ?=
 =?us-ascii?q?z0GgUlEhH2CIIFcgRWFbgSHHJBpAwkEBwVKRAMLLA8WBQgJFxIQEAIEERoLB?=
 =?us-ascii?q?gMWPwkCBA4DQAgNAxEEAw8YCRIIEAQGAzEMJQsDFAwBBgMGBQMBAxsDFAMFJ?=
 =?us-ascii?q?AcDHA8jDQ0EHx0DAwUlAwICGwcCAgMCBhUGAgI2GDkIBAgEKyMPBQIHLwUEL?=
 =?us-ascii?q?wIeBAUGEQgCFgIGBAQEBBYCEAgCCCcXBxMzGQEFWRAJIRwOGhAFBhMDIG8FB?=
 =?us-ascii?q?z4PKDM1PCsfGwqBEiorFQMEBAMCBhgDAyICEC4xAxUGKRMSLQkqdQkCAyJtA?=
 =?us-ascii?q?wMEKi4DCSEfBwkwHZZEggyBDitRNZNfgzsBqlwsbINbiyKOd4VlGjGFRqMhL?=
 =?us-ascii?q?ZZPhHqIPoNflj2BYgFzgSBNIxWDIwkKPhkPjiwNCYhkhUxCMQIBOAIGCwEBA?=
 =?us-ascii?q?wmMT4I3AQE?=
IronPort-Data: A9a23:B0WYoqlwUvgJVurM4w3f11To5gwXJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIZXj2AOvyLNmP9f9pxb9ix/RkG6pLRnNE3TwtrrSwwEltH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaA4E/raNANlFEkvU2ybuKU5NXsZ2YgHmeIdA970Ug5w7Fi29Yx6TSEK1rlV
 e3a8pW31GCNg1aYAkpMg05UgEoy1BhakGpwUm0WPZinjneH/5UmJM53yZWKEpfNatI88thW6
 Ar05OrREmvxp3/BAz4++1rxWhVirrX6ZWBihpfKMkSvqkAqm8A87ko0HNMXY34PihHYo5ds5
 9VRn7i7ZiUqO7KZzYzxUzEAe81/FaRL4vrMJmKy9JXVxEzdeHyqyPJrZK00FdRHoaAsUScUr
 adecmplghOr34paxJq7R+ZwmMkvMOHgPZgUvTdryjSx4fMOGsqTG/qXvre02h86h+pBH9SPe
 fAWeCI3VUyQTABIIX0uXcdWcOCA3ymjLGIwREiujbYw+XbayABq+LzsNsfFP9KNWMNZl1qZo
 WSA+H72ajkTN8Sa4T6E9G+8w+HIgCX3UZ4TE7v+8eRl6HWVwG87BxoRWl+25/K+jyaWV9tZK
 kEQ/yslpLka+0miT927VBq9yFaYrwIHXPJVEvF85Q2QooLX7guCDW8DTRZKaMYhsc4rQHotz
 FDht9fgDzZorKG9U3+R9r6I6zi1PEA9KWYffyYNZQAC79TqvZs0lBuJScxseIa6lND6GjHYx
 zGMsTgwgKgVgccX1qK9u1fdjFqEopnPUx5w5QjNWG+hxh12aZTjZIGy71Xfq/FaI+6kokKpt
 XUe3smG6/oSSJeEiGqGQf4GG/ei4PPt3CDgbUBHNpIrzmys3y+fOp1/4C1UAExGEMUBZmq8C
 KPMgj956JhWNXqsSKZ4ZYOtFsgnpZTd+cTZuuP8NYURP8AgHOOT1GQ/Oh7KhjGFfF0EyPlnY
 f+mndCQ4WH24JmLLQZapc9AiNfHJQhnmws/oKwXKDz9i9KjiIa9E+ttDbd3RrlRAFm4iAvU6
 c1DEMCB1g9SVubzCgGOr9NCdwhXfSRjXM6twyCySgJlClQ+cI3GI6KBqY7Nh6Q+90iovr6Sp
 yrkChMwJKTX3CWYc21mlUyPmJu2Dcog8hrXzAQnPE2j3DA4cJ2z4aIEH6bbjpF5nNGPOcVcF
 qFfE+3ZW6wnYm2eq1w1MMmsxKQ/JU/DrV/fYEKYjM0XIscIq/rhoYS/IGMCNUAmU0KKiCfJi
 +f4iFiAEcZaG1UK4QS/QKvH8m5ddEM1wIpaN3Yk6PEKEKkw2OCG8xDMs8I=
IronPort-HdrOrdr: A9a23:KuQldqsV6dRfiaj99ePE7Nh57skDc9V00zEX/kB9WHVpmwKj+/
 xG+85rsSMc5wx+ZJhNo7q90ey7MBDhHP1OkOws1MmZPTUO0VHAROpfBMnZsl/d8kbFmdK1u5
 0MT0EHMr3N5ZwQt7ed3OF+eOxQp+W6zA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,206,1654560000"; 
   d="scan'208";a="3280753"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 31 Jul 2022 18:26:59 +0000
Received: from hce-anki.rd.cisco.com ([10.47.79.243])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 26VIQpY0008219;
        Sun, 31 Jul 2022 18:26:59 GMT
From:   Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Laura Abbott <lauraa@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Daniel Micay <danielmicay@gmail.com>,
        Nick Kralevich <nnk@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [v4.9 PATCH 4/6] init: move stack canary initialization after setup_arch
Date:   Sun, 31 Jul 2022 20:26:34 +0200
Message-Id: <20220731182635.1910069-5-hegtvedt@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220731182635.1910069-1-hegtvedt@cisco.com>
References: <20220731182635.1910069-1-hegtvedt@cisco.com>
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

From: Laura Abbott <lauraa@codeaurora.org>

Patch series "Command line randomness", v3.

A series to add the kernel command line as a source of randomness.

This patch (of 2):

Stack canary intialization involves getting a random number.  Getting this
random number may involve accessing caches or other architectural specific
features which are not available until after the architecture is setup.
Move the stack canary initialization later to accommodate this.

Link: http://lkml.kernel.org/r/20170816231458.2299-2-labbott@redhat.com
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
Signed-off-by: Laura Abbott <labbott@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Daniel Micay <danielmicay@gmail.com>
Cc: Nick Kralevich <nnk@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 121388a31362b0d3176dc1190ac8064b98a61b20)
---
 init/main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/init/main.c b/init/main.c
index 8b803078d7b..67fa94c5967 100644
--- a/init/main.c
+++ b/init/main.c
@@ -487,12 +487,6 @@ asmlinkage __visible void __init start_kernel(void)
 	smp_setup_processor_id();
 	debug_objects_early_init();
 
-	/*
-	 * Set up the initial canary ASAP:
-	 */
-	add_latent_entropy();
-	boot_init_stack_canary();
-
 	cgroup_init_early();
 
 	local_irq_disable();
@@ -506,6 +500,11 @@ asmlinkage __visible void __init start_kernel(void)
 	page_address_init();
 	pr_notice("%s", linux_banner);
 	setup_arch(&command_line);
+	/*
+	 * Set up the the initial canary and entropy after arch
+	 */
+	add_latent_entropy();
+	boot_init_stack_canary();
 	mm_init_cpumask(&init_mm);
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
-- 
2.34.1

