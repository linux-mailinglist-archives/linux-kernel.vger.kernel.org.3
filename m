Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1964E3A07
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiCVIEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiCVIEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:04:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D965A5BC;
        Tue, 22 Mar 2022 01:02:47 -0700 (PDT)
Date:   Tue, 22 Mar 2022 08:02:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647936165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvNTkPDhQaPj8s0AF0E3t0QPzl8IltwCX/h7rPka7HA=;
        b=ZLmaaveylD0Btpd3hQ1O0OZ8UDj5Gz0Pk0uNTqZXIELvLvdS908LQO1EJf9FtZOU+WI4fw
        KIPQXg8k0KVp6PVEE9b7qiQUpwXz3wulgFQK7BishaHCS+7HTBbyriGQmc5t+jDL/NieDe
        7Z76aB44rlW4pblE6Stp/JBu1j53i6nAYF3hEA82Ry1iPjaFVa+Y75Ij66r839ZIKGzZkZ
        0iwMQknJGcbPrHvhXB8y7EYtEvCioMj52Ejg7ebkppx8qIoatCeDBwD8+u2G9yqvDBbmqq
        xp3oDKdyGTuIssprP9pbXvU3kQi+QM9YkaouQTCkEw1NAuw1o7j4s0lh5WcJDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647936165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvNTkPDhQaPj8s0AF0E3t0QPzl8IltwCX/h7rPka7HA=;
        b=28LtrR+8Ifh0+4kksUbzTAWGfgAoI4sexUoolfbhD7SGkg5/5KNtE7BOGUcm0N1RNpk8pF
        aSlNQ/8U02tNwqAQ==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: ARM needs asm/paravirt_api_clock.h too
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220316204146.14000-1-rdunlap@infradead.org>
References: <20220316204146.14000-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <164793616404.389.16948202920332556272.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ffea9fb319360b9ead8befac6bb2db2b54fd53e6
Gitweb:        https://git.kernel.org/tip/ffea9fb319360b9ead8befac6bb2db2b54fd53e6
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Wed, 16 Mar 2022 13:41:46 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Mar 2022 08:53:10 +01:00

sched/headers: ARM needs asm/paravirt_api_clock.h too

Add <asm/paravirt_api_clock.h> for arch/arm/, mapped to <asm/paravirt.h>,
to simplify #ifdeffery in generic code.

Fixes this build error introduced by the scheduler tree:

  In file included from ../kernel/sched/core.c:81:
  ../kernel/sched/sched.h:87:11: fatal error: asm/paravirt_api_clock.h: No such file or directory
     87 | # include <asm/paravirt_api_clock.h>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Fixes: 4ff8f2ca6ccd ("sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h dependencies")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220316204146.14000-1-rdunlap@infradead.org
---
 arch/arm/include/asm/paravirt_api_clock.h | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 arch/arm/include/asm/paravirt_api_clock.h

diff --git a/arch/arm/include/asm/paravirt_api_clock.h b/arch/arm/include/asm/paravirt_api_clock.h
new file mode 100644
index 0000000..65ac7ce
--- /dev/null
+++ b/arch/arm/include/asm/paravirt_api_clock.h
@@ -0,0 +1 @@
+#include <asm/paravirt.h>
