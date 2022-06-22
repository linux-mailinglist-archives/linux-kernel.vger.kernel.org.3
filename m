Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EAC55515A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359460AbiFVQcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiFVQcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:32:48 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5613668D;
        Wed, 22 Jun 2022 09:32:47 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id a14so6948048pgh.11;
        Wed, 22 Jun 2022 09:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u5s4Wessq1A7+DXt++jA8LoLB/q5K6CiGgznsSyjyCA=;
        b=YsWcgqFmP1TFGw6zMM3er3L/dSZzrqKrMF1bfGb6GOkxLWRhaThLyPS+l7MRSg9fSQ
         46gVrUNYFY93nDrKn0j2t1zxYNz2WJUj9HtoOtIQkZNsALUEefjW1cMUyp7A/C5OvpFJ
         tyKZZViIS5Gk2ijcr2+RESTSbPelCsXaAt3ksFg7iNyenuB6rrK+APYn6PjAPHxxKaf9
         aP5B0JJ2PZHt1Mzlif+N22ad2mfeQ8CoiKOSvI7zx6I6O1si6IRG5zEKihp5AHR/3FIL
         CXI/9seV/cIXB+tCVCReGRjT8NwUySc3+0COj5+AkzXrPq9jmirRc2GVDFcTrYsHX/Wt
         63Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u5s4Wessq1A7+DXt++jA8LoLB/q5K6CiGgznsSyjyCA=;
        b=JUpLUOixpIgF1PbXeWKmdjR7zfId6StSbGkbmyU/txXCwcA/45/8ub8/BYgm1Zorni
         77mF8oC8fy+DuzHZByvDcjkyLKY7bKFFYXcW/43GF4iDThkoHREpJZzNXE4lOpe9Lq4V
         qRSqacNMp/BCYP0gZhdmL4qtON+wxOO49yDoaYdJhkv+hAuJUbl4azlfWXaKqu8Suoam
         CInpgPnVzO4dj2QT5m5472H4uO+wWSBWaJ1+yn2axo61CB8l2BbGLv6ub2j9OByhCv6u
         MH5fQE8bnlnT8/AC7V8kzkgrAwksWV95Yh7s/4AyDCZCU37dp0Ah0yaalh6/wS6W6Upk
         0lfw==
X-Gm-Message-State: AJIora/KXnixlTQxiwTdQNGxcpFRBYuAWvEVulfwjwnLUYWiaKTx3XR/
        15Rq46SMRf+5FW4LfokU8VsEDeqNVNf+hZD/
X-Google-Smtp-Source: AGRyM1sOgjkj3y2T8Fpltj+MQW3x30V4NZh+XtOWvhoD1a+CcRB1b0gYKv5Fvy0nZl0M/9NEXUgjtw==
X-Received: by 2002:a05:6a00:16c6:b0:522:7ed2:4ff0 with SMTP id l6-20020a056a0016c600b005227ed24ff0mr36283735pfc.9.1655915567257;
        Wed, 22 Jun 2022 09:32:47 -0700 (PDT)
Received: from Mahakal ([2401:4900:1cc4:6ac4:7541:33fc:3c9c:4592])
        by smtp.gmail.com with ESMTPSA id z126-20020a626584000000b0051bd9568140sm13800076pfb.109.2022.06.22.09.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jun 2022 09:32:46 -0700 (PDT)
Date:   Wed, 22 Jun 2022 22:02:42 +0530
From:   "<Vishal Badole>" <badolevishal1116@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, mturquette@baylibre.com,
        inux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     chinmoyghosh2001@gmail.com, mintupatel89@gmail.com
Subject: Re: [PATCH] Common clock: =?utf-8?B?4oCL?= =?utf-8?B?4oCLVG8=?= list
 active consumers of clocks
Message-ID: <20220622163209.GA6246@Mahakal>
References: <CAEXpiVQihEadxsNodarz2-wxSAipfpzEaA8zKpnozszC+weYTQ@mail.gmail.com>
 <20220610194013.DD39DC34114@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610194013.DD39DC34114@smtp.kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_MISSP_FREEMAIL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From eba241016ea868b841473ba73ece16173a6b5aee Mon Sep 17 00:00:00 2001
From: Vishal Badole <badolevishal1116@gmail.com>
Date: Tue, 31 May 2022 21:23:34 +0530
Subject: [PATCH] Common clock: To list active consumers of clocks

This feature lists the name of clocks and their consumer devices.
Using this feature user can easily check which device is using a
perticular clock.

for example:
debian@beaglebone:~$ cat /sys/kernel/debug/clk/clk_devices_name
            clock_name                                  devices_name
-------------------------------------------------------------------------
             l4-wkup-clkctrl:0008:0              44e07000.target-module
                l4ls-clkctrl:0074:0              4804c000.target-module
                l4ls-clkctrl:0058:0              48311fe0.target-module
              l4-rtc-clkctrl:0000:0              44e3e074.target-module
                       clk_32768_ck                        44e3e000.rtc
                l4ls-clkctrl:00d8:0              480c8000.target-module
         cpsw-125mhz-clkctrl:0014:0              4a101200.target-module

Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
---
 drivers/clk/Kconfig |   8 ++++
 drivers/clk/clk.c   | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c44247d..549cdda 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -23,6 +23,14 @@ config COMMON_CLK
 menu "Common Clock Framework"
 	depends on COMMON_CLK
 
+config DEBUG_CLK_CONSUMER
+	bool "Debug feature to list clocks and their active consumers"
+	depends on DEBUG_FS && COMMON_CLK
+	help
+	  Clock consumer debug feature supports for clock debugging. Chose y
+	  to get debug entry in file system to list clocks and their active
+	  consumer devices.
+
 config COMMON_CLK_WM831X
 	tristate "Clock driver for WM831x/2x PMICs"
 	depends on MFD_WM831X
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 13332f8..dccbd35 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -105,6 +105,84 @@ struct clk {
 	struct hlist_node clks_node;
 };
 
+#ifdef CONFIG_DEBUG_CLK_CONSUMER
+/*Linked List Node*/
+struct clk_dev_list {
+	struct list_head list;
+	const char *clk_name;
+	const char *dev_name;
+};
+
+/*Declare and init the head node of the linked list*/
+LIST_HEAD(head_node);
+
+static void clk_dev_entry(struct clk *clk_ptr)
+{
+	struct clk_dev_list *new_node_ptr = NULL;
+	struct clk_dev_list *temp_node_ptr = NULL;
+	int repeat_count = 0;
+	static bool is_first_node;
+	const char *clk_name_ptr = NULL;
+	const char *dev_name_ptr = NULL;
+
+	if (clk_ptr->dev) {
+		dev_name_ptr = dev_name(clk_ptr->dev);
+
+		clk_name_ptr = clk_ptr->core->name;
+
+		if (is_first_node) {
+			/* Iterate the list to check duplicate entry */
+			list_for_each_entry(temp_node_ptr, &head_node, list) {
+				if (temp_node_ptr->clk_name == clk_name_ptr &&
+				    temp_node_ptr->dev_name == dev_name_ptr) {
+					repeat_count++;
+					break;
+				}
+			}
+		}
+
+		is_first_node = 1;
+
+		if (!repeat_count && clk_ptr->core->enable_count) {
+			/*Creating Node*/
+			new_node_ptr = kmalloc(sizeof(*new_node_ptr),
+					       GFP_KERNEL);
+			if (!new_node_ptr)
+				return;
+
+			/*Assgin the data that is received*/
+			new_node_ptr->clk_name = clk_name_ptr;
+			new_node_ptr->dev_name = dev_name_ptr;
+
+			/*Init the list within the struct*/
+			INIT_LIST_HEAD(&new_node_ptr->list);
+
+			/*Add Node to Linked List*/
+			list_add_tail(&new_node_ptr->list, &head_node);
+		}
+	}
+}
+
+/* Function to remove the clk and device entry */
+static void clk_dev_dentry(struct clk *clk)
+{
+	struct clk_dev_list *temp_node_ptr = NULL;
+	struct clk_dev_list *cur_node_ptr = NULL;
+
+	if (clk->dev) {
+		/* Go through the list and free the memory */
+		list_for_each_entry_safe(cur_node_ptr, temp_node_ptr,
+					 &head_node, list) {
+			if (cur_node_ptr->clk_name == clk->core->name &&
+			    cur_node_ptr->dev_name == dev_name(clk->dev)) {
+				list_del(&cur_node_ptr->list);
+				kfree(cur_node_ptr);
+			}
+		}
+	}
+}
+#endif
+
 /***           runtime pm          ***/
 static int clk_pm_runtime_get(struct clk_core *core)
 {
@@ -1020,6 +1098,9 @@ void clk_disable(struct clk *clk)
 		return;
 
 	clk_core_disable_lock(clk->core);
+#ifdef CONFIG_DEBUG_CLK_CONSUMER
+	clk_dev_dentry(clk);
+#endif
 }
 EXPORT_SYMBOL_GPL(clk_disable);
 
@@ -1181,10 +1262,21 @@ EXPORT_SYMBOL_GPL(clk_restore_context);
  */
 int clk_enable(struct clk *clk)
 {
+#ifdef CONFIG_DEBUG_CLK_CONSUMER
+	int ret = 0;
+#endif
 	if (!clk)
 		return 0;
 
+#ifndef CONFIG_DEBUG_CLK_CONSUMER
 	return clk_core_enable_lock(clk->core);
+#else
+	ret = clk_core_enable_lock(clk->core);
+	if (!ret)
+		clk_dev_entry(clk);
+
+	return ret;
+#endif
 }
 EXPORT_SYMBOL_GPL(clk_enable);
 
@@ -2986,6 +3078,29 @@ static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
 		   clk_core_get_scaled_duty_cycle(c, 100000));
 }
 
+#ifdef CONFIG_DEBUG_CLK_CONSUMER
+static int clk_devices_show(struct seq_file *s, void *data)
+{
+	struct clk_dev_list *clk_dev_node;
+
+	seq_puts(s, "            clock_name                                  devices_name\n");
+	seq_puts(s, "-------------------------------------------------------------------------\n");
+
+	clk_prepare_lock();
+
+	/*Traversing Linked List and Print its Members*/
+	list_for_each_entry(clk_dev_node, &head_node, list) {
+		seq_printf(s, "%35s %35s\n", clk_dev_node->clk_name,
+			   clk_dev_node->dev_name);
+	}
+
+	clk_prepare_unlock();
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(clk_devices);
+#endif
+
 static void clk_dump_subtree(struct seq_file *s, struct clk_core *c, int level)
 {
 	struct clk_core *child;
@@ -3256,7 +3371,10 @@ static int __init clk_debug_init(void)
 			    &clk_summary_fops);
 	debugfs_create_file("clk_orphan_dump", 0444, rootdir, &orphan_list,
 			    &clk_dump_fops);
-
+#ifdef CONFIG_DEBUG_CLK_CONSUMER
+	debugfs_create_file("clk_devices_name", 0444, rootdir, NULL,
+			    &clk_devices_fops);
+#endif
 	mutex_lock(&clk_debug_lock);
 	hlist_for_each_entry(core, &clk_debug_list, debug_node)
 		clk_debug_create_one(core, rootdir);
-- 
2.7.4

