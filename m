Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BE94DE6B1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 08:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242383AbiCSH0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 03:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242364AbiCSH0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 03:26:10 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6A6252A4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 00:24:48 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B7AA75C00FE;
        Sat, 19 Mar 2022 03:24:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 19 Mar 2022 03:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:date:date:from:from:in-reply-to
        :message-id:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=6zsYak
        eys530iM/BufaiZKRdl2xMfzAFt+qW/2GIDJY=; b=K0yn7r70r13ys/2KTFFWAA
        Mn4A0lAcRLo1OCtcK5lQI4Yu3RkOtGA+dtqzgd5qB6LFkg+tgKnC/OYBxvYVzihJ
        t100GsarQ4VmBmu86y4CXiV+c1DXMYaAzY0mxOEGjS5HpuB4FGBOrtR2gpzlW4tG
        Gwjj4TCsFtupu/SbMae1tWN+1yEIS8s4tBUqtC33yqxIXEnAbz7ZsN10lUO5TvnQ
        Hhjj6/V3f36b1EzoKEqoNU52CLKntPNMhCltB5OrtIYWiflPB/EII6mFTaI47KIg
        OR5ndgFPi6M00IJsiRVL1PrF21VdNYsed50s6UfCK4Ig+uz8ZHsL4bhv8yglAuKA
        ==
X-ME-Sender: <xms:PIU1Ym1RBhG-CszhjxyrKdZvm21eJKOR2A5l4Y29NzNM9YeaRSlZOw>
    <xme:PIU1YpG1SssAAQwJhwqld2XIx2A774vYi0qBQZ9-Gs9uYV-WhQSiddgEuG-aXZjk9
    2OR01GRYCkGiIFl4LA>
X-ME-Received: <xmr:PIU1Yu7s-8THufQZP2Jo9qE4trc14-DMf0S-5w32PjACt97Rp0dT7BCwnlHsZBbuZVkjKR0lB0l_jjMdSAnlIwBbTsz85r6iOXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefvkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghi
    nhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrh
    hnpedtleetkeelkeekvdeujeehkefgvddtheehhfetieethfetfeeghfduheevveelleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrg
    hinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:PYU1Yn0hbUqKMKjyOI9YdIVjlsmnAhoa9ax9sqEMx5uEh48rfpFe-g>
    <xmx:PYU1YpFUDT7abG8j8WDsxG6L0RNE16PtFxDN_GVRBBzk0-VeaYm3xg>
    <xmx:PYU1Yg_kOZpIYZ9L8uW_aJGWOD_TiQVC9suZV8-_9ayxrIztZZxjdg>
    <xmx:PYU1YnP_RfU1ODldtHZCp5e2hxXK3TNnK9bMm-OzOepQ_Zb_9Epn8Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Mar 2022 03:24:42 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "Randy Dunlap" <rdunlap@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <650f5577599a701fdd632cdd469a9cea9788cdf3.1647674431.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] macintosh/via-pmu: Fix compiler warnings when CONFIG_PROC_FS
 is disabled
Date:   Sat, 19 Mar 2022 18:20:31 +1100
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/macintosh/via-pmu.c:897:12: warning: 'pmu_battery_proc_show' defined but not used [-Wunused-function]
 static int pmu_battery_proc_show(struct seq_file *m, void *v)
            ^~~~~~~~~~~~~~~~~~~~~
drivers/macintosh/via-pmu.c:871:12: warning: 'pmu_irqstats_proc_show' defined but not used [-Wunused-function]
 static int pmu_irqstats_proc_show(struct seq_file *m, void *v)
            ^~~~~~~~~~~~~~~~~~~~~~
drivers/macintosh/via-pmu.c:860:12: warning: 'pmu_info_proc_show' defined but not used [-Wunused-function]
 static int pmu_info_proc_show(struct seq_file *m, void *v)
            ^~~~~~~~~~~~~~~~~~

Rearrange some code and add some #ifdefs to avoid unused code warnings
when CONFIG_PROC_FS is disabled.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/macintosh/via-pmu.c | 61 ++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 55afa6dfa263..5ffebf29b630 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -173,10 +173,15 @@ static unsigned long async_req_locks;
 #define NUM_IRQ_STATS 13
 static unsigned int pmu_irq_stats[NUM_IRQ_STATS];
 
+#ifdef CONFIG_PROC_FS
 static struct proc_dir_entry *proc_pmu_root;
 static struct proc_dir_entry *proc_pmu_info;
 static struct proc_dir_entry *proc_pmu_irqstats;
 static struct proc_dir_entry *proc_pmu_options;
+static struct proc_dir_entry *proc_pmu_batt[PMU_MAX_BATTERIES];
+static void pmu_proc_setup(void);
+#endif
+
 static int option_server_mode;
 
 int pmu_battery_count;
@@ -185,7 +190,6 @@ unsigned int pmu_power_flags = PMU_PWR_AC_PRESENT;
 struct pmu_battery_info pmu_batteries[PMU_MAX_BATTERIES];
 static int query_batt_timer = BATTERY_POLLING_COUNT;
 static struct adb_request batt_req;
-static struct proc_dir_entry *proc_pmu_batt[PMU_MAX_BATTERIES];
 
 int asleep;
 
@@ -204,11 +208,7 @@ static int init_pmu(void);
 static void pmu_start(void);
 static irqreturn_t via_pmu_interrupt(int irq, void *arg);
 static irqreturn_t gpio1_interrupt(int irq, void *arg);
-static int pmu_info_proc_show(struct seq_file *m, void *v);
-static int pmu_irqstats_proc_show(struct seq_file *m, void *v);
-static int pmu_battery_proc_show(struct seq_file *m, void *v);
 static void pmu_pass_intr(unsigned char *data, int len);
-static const struct proc_ops pmu_options_proc_ops;
 
 #ifdef CONFIG_ADB
 const struct adb_driver via_pmu_driver = {
@@ -551,26 +551,9 @@ static int __init via_pmu_dev_init(void)
 	}
 #endif /* CONFIG_PPC32 */
 
-	/* Create /proc/pmu */
-	proc_pmu_root = proc_mkdir("pmu", NULL);
-	if (proc_pmu_root) {
-		long i;
-
-		for (i=0; i<pmu_battery_count; i++) {
-			char title[16];
-			sprintf(title, "battery_%ld", i);
-			proc_pmu_batt[i] = proc_create_single_data(title, 0,
-					proc_pmu_root, pmu_battery_proc_show,
-					(void *)i);
-		}
-
-		proc_pmu_info = proc_create_single("info", 0, proc_pmu_root,
-				pmu_info_proc_show);
-		proc_pmu_irqstats = proc_create_single("interrupts", 0,
-				proc_pmu_root, pmu_irqstats_proc_show);
-		proc_pmu_options = proc_create("options", 0600, proc_pmu_root,
-						&pmu_options_proc_ops);
-	}
+#ifdef CONFIG_PROC_FS
+	pmu_proc_setup();
+#endif
 	return 0;
 }
 
@@ -857,6 +840,7 @@ query_battery_state(void)
 			2, PMU_SMART_BATTERY_STATE, pmu_cur_battery+1);
 }
 
+#ifdef CONFIG_PROC_FS
 static int pmu_info_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, "PMU driver version     : %d\n", PMU_DRIVER_VERSION);
@@ -978,6 +962,33 @@ static const struct proc_ops pmu_options_proc_ops = {
 	.proc_write	= pmu_options_proc_write,
 };
 
+static void pmu_proc_setup(void)
+{
+	long i;
+
+	/* Create /proc/pmu */
+	proc_pmu_root = proc_mkdir("pmu", NULL);
+	if (!proc_pmu_root)
+		return;
+
+	for (i = 0; i < pmu_battery_count; i++) {
+		char title[16];
+
+		sprintf(title, "battery_%ld", i);
+		proc_pmu_batt[i] =
+			proc_create_single_data(title, 0, proc_pmu_root,
+						pmu_battery_proc_show, (void *)i);
+	}
+
+	proc_pmu_info = proc_create_single("info", 0, proc_pmu_root,
+					   pmu_info_proc_show);
+	proc_pmu_irqstats = proc_create_single("interrupts", 0, proc_pmu_root,
+					       pmu_irqstats_proc_show);
+	proc_pmu_options = proc_create("options", 0600, proc_pmu_root,
+				       &pmu_options_proc_ops);
+}
+#endif /* CONFIG_PROC_FS */
+
 #ifdef CONFIG_ADB
 /* Send an ADB command */
 static int pmu_send_request(struct adb_request *req, int sync)
-- 
2.32.0

