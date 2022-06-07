Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D5C5425FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443413AbiFHCCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588471AbiFGXyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:54:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9954DEAB87;
        Tue,  7 Jun 2022 16:09:57 -0700 (PDT)
Date:   Tue, 07 Jun 2022 23:09:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654643395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31knJ3QXB3grtazMt+b9bY3U/ZDckeFhNjGn1EuvTFE=;
        b=MJl5K8k3SMYaWkE2ICZFiDKbyUZBhahVnqp8FEBFA6di3TbE7fD/a4SnWV9ApTYPUJFP54
        zRVLyR2ao8emN+QzJWwhVPo506TqscDDCAexUiVGC9TcAkPrExJ037JOhMycGB2EVh++Yl
        v+SL6c/1Az5w3dSEH09U4cj7w184tsSQaIfC45WFQgyv+13YUgZ7EeX9jeXyjLh+fFEvlZ
        cKXzW30wKK8m5FxwjQIhnqAKGTzDKEk+d4McQa3FgIiJjBZqCAxjGnkW3b6SneXpm//ElP
        Qcsl4NKs47N6Hp0BpFEiyXj8REFihViFgDY9LMgFo5Y3+LM7JxR/nebANOx40A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654643395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31knJ3QXB3grtazMt+b9bY3U/ZDckeFhNjGn1EuvTFE=;
        b=HjKXp4gN6EUcqfASdXpyxbNTMkYrFFF/GNXtIJ2YNPgW76mBis3OVoy0Jh7VVMJTpICXPO
        UuoY4aA9fIvGneBQ==
From:   "tip-bot2 for Ira Weiny" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] Documentation/protection-keys: Clean up documentation
 for User Space pkeys
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220419170649.1022246-2-ira.weiny@intel.com>
References: <20220419170649.1022246-2-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID: <165464339351.4207.13791430848488231130.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     f8c1d4ca55177326adad1fdc6bf602423a507542
Gitweb:        https://git.kernel.org/tip/f8c1d4ca55177326adad1fdc6bf602423a507542
Author:        Ira Weiny <ira.weiny@intel.com>
AuthorDate:    Tue, 19 Apr 2022 10:06:06 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 07 Jun 2022 16:06:22 -07:00

Documentation/protection-keys: Clean up documentation for User Space pkeys

The documentation for user space pkeys was a bit dated including things
such as Amazon and distribution testing information which is irrelevant
now.

Update the documentation.  This also streamlines adding the Supervisor
pkey documentation later on.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220419170649.1022246-2-ira.weiny@intel.com
---
 Documentation/core-api/protection-keys.rst | 44 ++++++++++-----------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index ec575e7..bf28ac0 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -4,31 +4,29 @@
 Memory Protection Keys
 ======================
 
-Memory Protection Keys for Userspace (PKU aka PKEYs) is a feature
-which is found on Intel's Skylake (and later) "Scalable Processor"
-Server CPUs. It will be available in future non-server Intel parts
-and future AMD processors.
-
-For anyone wishing to test or use this feature, it is available in
-Amazon's EC2 C5 instances and is known to work there using an Ubuntu
-17.04 image.
-
-Memory Protection Keys provides a mechanism for enforcing page-based
-protections, but without requiring modification of the page tables
-when an application changes protection domains.  It works by
-dedicating 4 previously ignored bits in each page table entry to a
-"protection key", giving 16 possible keys.
-
-There is also a new user-accessible register (PKRU) with two separate
-bits (Access Disable and Write Disable) for each key.  Being a CPU
-register, PKRU is inherently thread-local, potentially giving each
+Memory Protection Keys provide a mechanism for enforcing page-based
+protections, but without requiring modification of the page tables when an
+application changes protection domains.
+
+Pkeys Userspace (PKU) is a feature which can be found on:
+        * Intel server CPUs, Skylake and later
+        * Intel client CPUs, Tiger Lake (11th Gen Core) and later
+        * Future AMD CPUs
+
+Pkeys work by dedicating 4 previously Reserved bits in each page table entry to
+a "protection key", giving 16 possible keys.
+
+Protections for each key are defined with a per-CPU user-accessible register
+(PKRU).  Each of these is a 32-bit register storing two bits (Access Disable
+and Write Disable) for each of 16 keys.
+
+Being a CPU register, PKRU is inherently thread-local, potentially giving each
 thread a different set of protections from every other thread.
 
-There are two new instructions (RDPKRU/WRPKRU) for reading and writing
-to the new register.  The feature is only available in 64-bit mode,
-even though there is theoretically space in the PAE PTEs.  These
-permissions are enforced on data access only and have no effect on
-instruction fetches.
+There are two instructions (RDPKRU/WRPKRU) for reading and writing to the
+register.  The feature is only available in 64-bit mode, even though there is
+theoretically space in the PAE PTEs.  These permissions are enforced on data
+access only and have no effect on instruction fetches.
 
 Syscalls
 ========
