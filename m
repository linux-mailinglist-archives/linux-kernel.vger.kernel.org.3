Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4EB4E239F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346024AbiCUJwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343803AbiCUJv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:51:59 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8A09BAD8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:50:34 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 509585C015A;
        Mon, 21 Mar 2022 05:50:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 21 Mar 2022 05:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:date:date:from:from:in-reply-to
        :message-id:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xqO+J3
        qYKvWooJVksUuAiiLBEJdNT3Gcv0iTkRapBjk=; b=lYjtzbmNgu9kHcHHiK3Z4S
        Dsr8cAsC3eoZ21FA9GYNMArW6agjvK34YkZm2IEL1eCgxxG+GAUOvyrTMRBe0XS7
        tTvfqzH3OPwq9SA4GblDIrIvWMiuK1oPZMglsLgZuJ1stUj9bHz632S3MKnF2Pag
        G9K0mdfMJmPCfXnvRU17VNSMEGwiRtYVyFomfAbL5Mq0RFmYYwExJ1LtOlR6sw1Z
        HtfNDswkO+q5oj2vGe2IulefbYLhZFdoTmNPJjYvwoX6BX0Tctmjl+QFcLhB6Bfg
        WTwyOwjDAU+uU2+uoC9CIF1YKHWVMczeVwW0J17OgewZWMHTrHMNFDheA7O2Jm6w
        ==
X-ME-Sender: <xms:ako4Yux8q43usDDm96wgdu2H1deV3FakXwGGIf5m_REAzk1_28HdBg>
    <xme:ako4YqRUxn2xzKbzU7Id-vLVlkC36KLiCZs8tkWKKH1oHfGzsFn_YchXSvCDeqOT4
    pimMjGugYTDdPFVRwM>
X-ME-Received: <xmr:ako4YgW6DfRERd-rdV_8o6HjweYOy6i0qBZXdZWNIcjnv5J_hJsZ6yohXljdl9EQV1xlceP-3-hZfARUAdRyTBbsUfQSWt-RFW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvffkhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfvhhgrihhn
    uceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvghrnh
    eptdelteekleekkedvueejheekgfdvtdehhefhteeitefhteefgefhudehveevleelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrih
    hnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:ako4YkgeeFYL9MUuHfcBrJUPWJTYuzijYp2tN2l3UjwySb7xHJQG2Q>
    <xmx:ako4YgBZ_VIRae9Wn588l_eKRby8MK8zlr80RZSeZsKhT_gmXif-zQ>
    <xmx:ako4YlKBu4AWNY8YP5qVw4Mc5NtRTKhWBcqwdqfbKZsSeyaECSztwA>
    <xmx:ako4YjOGuqakraTt_B-LeleQlEcEKwzY3o_m6BwrvOnJBY-YueV63Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 05:50:32 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "Randy Dunlap" <rdunlap@infradead.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <0c11c0770fc4ec7e80a4b2e0ffce1055b792cfdb.1647854880.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2] macintosh/via-pmu: Avoid compiler warnings when
 CONFIG_PROC_FS is disabled
Date:   Mon, 21 Mar 2022 20:28:00 +1100
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

Add some #ifdefs to avoid unused code warnings when CONFIG_PROC_FS is
disabled.

Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v1:
 - Simplified to take advantage of the fact that proc_mkdir() is stubbed
   out when CONFIG_PROC_FS=n. Hence that call doesn't need to move
   within the #ifdef.
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

