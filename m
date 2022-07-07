Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088AE56AAB7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbiGGS3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbiGGS20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:28:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFAA5C9F0;
        Thu,  7 Jul 2022 11:27:54 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218472;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/45QXix8kG5JFWRVi652En2NPZwrHx76O3WZWQewOPg=;
        b=hA4lJeTPky0qZ0nISgW7M1XwbSi6lBYAcqvIuy/AtwlHf1Afk1dRjzsHn2IufrGm8j1v7z
        a7/TlfTSIfKFhBQGSyxKIBE1cpF5Ov5jyKQmfniZZzubLA4e5vU16xzmmeAnuKLzR9Fn//
        0rH1iS2cSSdXGNpcbKzfxLkuUu1WvTJCZKLREqnhLl91pTJopcNjoCXg//o+YNkYS6ZTBN
        eaG/PzR++6RpgMzE8bacsN76Iv+nLtDUp93Sr7u1AS6xLGaLyHFR7aaeQgS4OYv+sYBtq5
        iFDMcWReKim/d6xSP3YtxOf2QUxXn/4Xk3TDNsuE+JNRMZTe0bIMAUMYSmlbkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218472;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/45QXix8kG5JFWRVi652En2NPZwrHx76O3WZWQewOPg=;
        b=F2IvD1B65/0hFPIl1Vu4YYYXwhCbutv/pFYC+Yfiw0K+TueOKVvZlBHbQ55rwXu3UayOu0
        vC2Bf+sFl6ObgKDQ==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Rename sgx_encl_ewb_cpumask() as sgx_encl_cpumask()
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd4d08c449450a13d8dd3bb6c2b1af03895586d4f=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cd4d08c449450a13d8dd3bb6c2b1af03895586d4f=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721847152.15455.10704930888669361614.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     bdaa8799f697daa059bf807da40a9444de94d7e3
Gitweb:        https://git.kernel.org/tip/bdaa8799f697daa059bf807da40a9444de94d7e3
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:43 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:02 -07:00

x86/sgx: Rename sgx_encl_ewb_cpumask() as sgx_encl_cpumask()

sgx_encl_ewb_cpumask() is no longer unique to the reclaimer where it
is used during the EWB ENCLS leaf function when EPC pages are written
out to main memory and sgx_encl_ewb_cpumask() is used to learn which
CPUs might have executed the enclave to ensure that TLBs are cleared.

Upcoming SGX2 enabling will use sgx_encl_ewb_cpumask() during the
EMODPR and EMODT ENCLS leaf functions that make changes to enclave
pages. The function is needed for the same reason it is used now: to
learn which CPUs might have executed the enclave to ensure that TLBs
no longer point to the changed pages.

Rename sgx_encl_ewb_cpumask() to sgx_encl_cpumask() to reflect the
broader usage.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/d4d08c449450a13d8dd3bb6c2b1af03895586d4f.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/sgx/encl.c | 6 +++---
 arch/x86/kernel/cpu/sgx/encl.h | 2 +-
 arch/x86/kernel/cpu/sgx/main.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 6953d33..7539cef 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -715,7 +715,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 }
 
 /**
- * sgx_encl_ewb_cpumask() - Query which CPUs might be accessing the enclave
+ * sgx_encl_cpumask() - Query which CPUs might be accessing the enclave
  * @encl: the enclave
  *
  * Some SGX functions require that no cached linear-to-physical address
@@ -740,7 +740,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
  * The following flow is used to support SGX functions that require that
  * no cached linear-to-physical address mappings are present:
  * 1) Execute ENCLS[ETRACK] to initiate hardware tracking.
- * 2) Use this function (sgx_encl_ewb_cpumask()) to query which CPUs might be
+ * 2) Use this function (sgx_encl_cpumask()) to query which CPUs might be
  *    accessing the enclave.
  * 3) Send IPI to identified CPUs, kicking them out of the enclave and
  *    thus flushing all locally cached linear-to-physical address mappings.
@@ -757,7 +757,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
  *
  * Return: cpumask of CPUs that might be accessing @encl
  */
-const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl)
+const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl)
 {
 	cpumask_t *cpumask = &encl->cpumask;
 	struct sgx_encl_mm *encl_mm;
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index c6afa58..ef8cf10 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -105,7 +105,7 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 
 void sgx_encl_release(struct kref *ref);
 int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
-const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl);
+const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl);
 int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 			 struct sgx_backing *backing);
 void sgx_encl_put_backing(struct sgx_backing *backing);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 2a92627..7b53a69 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -251,7 +251,7 @@ static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
 			 * miss cpus that entered the enclave between
 			 * generating the mask and incrementing epoch.
 			 */
-			on_each_cpu_mask(sgx_encl_ewb_cpumask(encl),
+			on_each_cpu_mask(sgx_encl_cpumask(encl),
 					 sgx_ipi_cb, NULL, 1);
 			ret = __sgx_encl_ewb(epc_page, va_slot, backing);
 		}
