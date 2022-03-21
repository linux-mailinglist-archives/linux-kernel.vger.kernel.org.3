Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1B24E231E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345781AbiCUJSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345809AbiCUJSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:18:03 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C130333EA1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:16:38 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 324DA5C00A2;
        Mon, 21 Mar 2022 05:16:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 21 Mar 2022 05:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:date:date:from:from:in-reply-to
        :message-id:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=gNzyaw
        ml6Mx9maRou91ByTbvGdGsig6mwf7OInhrdyE=; b=irk/5onzONs1uDbRQ3SRU3
        unK4ocRvauOhTLinCpwrPn13YJe1nn6XpKfTDLD0b2vikofHoqLJNdfQGqj7XmS3
        jFJulhTTYi65OJWGxd3mRrBNpjIc3h1wHPNnvjDzfEbR5NRE8cJDVOMJLDRwE0FF
        IcPRZexWjkEEMQpxQeZBipCFpiiHOwpRU+ISKtjok6fEZpkd+aoUw8SMYSvwykiV
        KfSluup1dbZzpoDIsrgkk+6EZtf7WnGAyMEt6O/nSDqQ0XzKHQktiMC6MwQMr2H2
        UhckZlHBwee8wVzdaLbV9zQdiL8HDWkcBDqhpvLjbVKMDdZwZaDseohPUr5ETnKA
        ==
X-ME-Sender: <xms:dkI4YmmXyFgxWPP0DWilFaotzABjbQ-e3slgKe9TdZozepgd25e5Ow>
    <xme:dkI4Yt3pMvCVmNxQnlKF-KL0fAIKB7bKV8DcBNg71lGLIvwnHgzQ1kdwKYMOqF_gC
    rEJh8qrcPqgw-3kLnY>
X-ME-Received: <xmr:dkI4Ykp55jg7rY41fNPV-b__JSKUSNxmmFCaXLjmpw_MiIiqQp6WrMVce-9j4hzsflz1cGk9ISOOEz7I5QysZbUcoTpSZIQyLL0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvffkhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    eptdelteekleekkedvueejheekgfdvtdehhefhteeitefhteefgefhudehveevleelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrih
    hnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:dkI4YqmMNYxMOwfPGaL3I8QN3BnV7z-cmPoGJ4mWWkXLM-QgBK88EQ>
    <xmx:dkI4Yk1-PEVzSVymIoWR45MQssvDlSRfm1rfpHdnVpne6ZIYLGHwwA>
    <xmx:dkI4YhuRHYpiS4muO7tgcv45KirbQ-lWx9NIyOHy9kju6uwrMNsUHQ>
    <xmx:dkI4YiAoKlCbzT8lbWvb290h-TAw_5GhRLQC7jjYIYB7-9VbABpTpA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 05:16:36 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "Randy Dunlap" <rdunlap@infradead.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <bb3b2229213f5feaff12e731b7537d03705e15d5.1647854173.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] Subject: [PATCH] macintosh/via-pmu: Avoid compiler warnings
 when CONFIG_PROC_FS is disabled
Date:   Mon, 21 Mar 2022 20:16:13 +1100
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
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
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/macintosh/via-pmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 2109129ea1bb..495fd35b11de 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -204,9 +204,11 @@ static int init_pmu(void);
 static void pmu_start(void);
 static irqreturn_t via_pmu_interrupt(int irq, void *arg);
 static irqreturn_t gpio1_interrupt(int irq, void *arg);
+#ifdef CONFIG_PROC_FS
 static int pmu_info_proc_show(struct seq_file *m, void *v);
 static int pmu_irqstats_proc_show(struct seq_file *m, void *v);
 static int pmu_battery_proc_show(struct seq_file *m, void *v);
+#endif
 static void pmu_pass_intr(unsigned char *data, int len);
 static const struct proc_ops pmu_options_proc_ops;
 
@@ -857,6 +859,7 @@ query_battery_state(void)
 			2, PMU_SMART_BATTERY_STATE, pmu_cur_battery+1);
 }
 
+#ifdef CONFIG_PROC_FS
 static int pmu_info_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, "PMU driver version     : %d\n", PMU_DRIVER_VERSION);
@@ -977,6 +980,7 @@ static const struct proc_ops pmu_options_proc_ops = {
 	.proc_release	= single_release,
 	.proc_write	= pmu_options_proc_write,
 };
+#endif
 
 #ifdef CONFIG_ADB
 /* Send an ADB command */
-- 
2.32.0

