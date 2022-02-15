Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD544B5FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiBOA43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:56:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiBOA41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:56:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B80FB89;
        Mon, 14 Feb 2022 16:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WpSEHq3AzyjnrkFj+WFiaIslQhMuyFMbEeZ42fue6pM=; b=oSVjpsDaCxJmJVgxebhAW/30zq
        8dBRZhJAi/ADNiRvbZcxImx9MH4REHSsj1NLLSFIB3FP5csGe5/32gJvCsYvvVFDkpZC6MNvIpj14
        5B/SL2ZhNJiQsn8wFMEduz+eHyAYP/Jib2BBP34c/PNuPvZDQ7FF66mvTBJytkYUo7DQl5U9XhOkG
        s8l6Ef1i0GrwKY49MtErA6Z4Zx53FgILIIGwdbXnyjegWNhDmyXBB+N/GVidSoSBoR5hVoGqVNmfn
        9LhgAfiP9V5VQTt1vcxxg238OVDWodimrzD4KMSXNtqAP/dp3SZpStqaha2FV+73vMYROlzNZbn0v
        ZyyvmmNg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJm8e-00HOzp-5I; Tue, 15 Feb 2022 00:56:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Docs: printk: add 'console=null|""' to admin/kernel-parameters
Date:   Mon, 14 Feb 2022 16:56:15 -0800
Message-Id: <20220215005615.11244-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tell about 'console=null|""' and how to use it.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-next-20220214.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-next-20220214/Documentation/admin-guide/kernel-parameters.txt
@@ -724,6 +724,12 @@
 		hvc<n>	Use the hypervisor console device <n>. This is for
 			both Xen and PowerPC hypervisors.
 
+		{ null | "" }
+			Use to disable console output, i.e., to have kernel
+			console messages discarded.
+			This must be the first (or only) console= string
+			used on the kernel command line.
+
 		If the device connected to the port is not a TTY but a braille
 		device, prepend "brl," before the device type, for instance
 			console=brl,ttyS0
