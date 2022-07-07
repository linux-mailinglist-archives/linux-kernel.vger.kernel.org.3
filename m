Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D749856AA96
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbiGGSaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbiGGS3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:29:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4865C941;
        Thu,  7 Jul 2022 11:27:59 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218478;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Dlp6ugu6EIX2hP43ShKsfqp4OKuqHqy+MCaV0DyiPc=;
        b=zKAUj5cdRyymYEU4YZHhF/rFO2pyzHp64DvecohMYbIFYDbvzu8mTWhot8Q+kDMcxYW8K/
        iMjupEcpsQPUlF+i5KRmlfRiwXGD9wqal0/jHph9sJpK7t0BazQrDYWig3h0RLeo+iG8y4
        6yYaJcYHbW05y7Ivrus1zWN+F9CCYOLydO2HJaxPB0mxBh/vujzUUxcNM+gwGWMq7H0hwY
        FlggEaJuQQCoQ8IbDjZr/+5FPYZ1rIGovyyuyrd4ABGTsqg1N1SQ9jnEQ5Xk2/KWnlanSp
        zHWopzy2MZXNVicOVPgKzw5FlqHT5P8y0Xx5b8/mMOmz++O/3maS7eSYXxkvog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218478;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Dlp6ugu6EIX2hP43ShKsfqp4OKuqHqy+MCaV0DyiPc=;
        b=JteTpFnZrPm9lXxOZrv3LS9MiC/X1emktOYhN+netZmvb7Lx5crioul3XowIfF2ZdbH/eS
        qzqWDFKYgbEzwgAg==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add short descriptions to ENCLS wrappers
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C5e78a1126711cbd692d5b8132e0683873398f69e=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C5e78a1126711cbd692d5b8132e0683873398f69e=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721847710.15455.8884335128575566784.tip-bot2@tip-bot2>
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

Commit-ID:     4c3f73584c0c0152b75dd6a090558ada39601159
Gitweb:        https://git.kernel.org/tip/4c3f73584c0c0152b75dd6a090558ada39601159
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:37 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:01 -07:00

x86/sgx: Add short descriptions to ENCLS wrappers

The SGX ENCLS instruction uses EAX to specify an SGX function and
may require additional registers, depending on the SGX function.
ENCLS invokes the specified privileged SGX function for managing
and debugging enclaves. Macros are used to wrap the ENCLS
functionality and several wrappers are used to wrap the macros to
make the different SGX functions accessible in the code.

The wrappers of the supported SGX functions are cryptic. Add short
descriptions of each as a comment.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/5e78a1126711cbd692d5b8132e0683873398f69e.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/sgx/encls.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index fa04a73..0e22fa8 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -136,57 +136,71 @@ static inline bool encls_failed(int ret)
 	ret;						\
 	})
 
+/* Initialize an EPC page into an SGX Enclave Control Structure (SECS) page. */
 static inline int __ecreate(struct sgx_pageinfo *pginfo, void *secs)
 {
 	return __encls_2(ECREATE, pginfo, secs);
 }
 
+/* Hash a 256 byte region of an enclave page to SECS:MRENCLAVE. */
 static inline int __eextend(void *secs, void *addr)
 {
 	return __encls_2(EEXTEND, secs, addr);
 }
 
+/*
+ * Associate an EPC page to an enclave either as a REG or TCS page
+ * populated with the provided data.
+ */
 static inline int __eadd(struct sgx_pageinfo *pginfo, void *addr)
 {
 	return __encls_2(EADD, pginfo, addr);
 }
 
+/* Finalize enclave build, initialize enclave for user code execution. */
 static inline int __einit(void *sigstruct, void *token, void *secs)
 {
 	return __encls_ret_3(EINIT, sigstruct, secs, token);
 }
 
+/* Disassociate EPC page from its enclave and mark it as unused. */
 static inline int __eremove(void *addr)
 {
 	return __encls_ret_1(EREMOVE, addr);
 }
 
+/* Copy data to an EPC page belonging to a debug enclave. */
 static inline int __edbgwr(void *addr, unsigned long *data)
 {
 	return __encls_2(EDGBWR, *data, addr);
 }
 
+/* Copy data from an EPC page belonging to a debug enclave. */
 static inline int __edbgrd(void *addr, unsigned long *data)
 {
 	return __encls_1_1(EDGBRD, *data, addr);
 }
 
+/* Track that software has completed the required TLB address clears. */
 static inline int __etrack(void *addr)
 {
 	return __encls_ret_1(ETRACK, addr);
 }
 
+/* Load, verify, and unblock an EPC page. */
 static inline int __eldu(struct sgx_pageinfo *pginfo, void *addr,
 			 void *va)
 {
 	return __encls_ret_3(ELDU, pginfo, addr, va);
 }
 
+/* Make EPC page inaccessible to enclave, ready to be written to memory. */
 static inline int __eblock(void *addr)
 {
 	return __encls_ret_1(EBLOCK, addr);
 }
 
+/* Initialize an EPC page into a Version Array (VA) page. */
 static inline int __epa(void *addr)
 {
 	unsigned long rbx = SGX_PAGE_TYPE_VA;
@@ -194,6 +208,7 @@ static inline int __epa(void *addr)
 	return __encls_2(EPA, rbx, addr);
 }
 
+/* Invalidate an EPC page and write it out to main memory. */
 static inline int __ewb(struct sgx_pageinfo *pginfo, void *addr,
 			void *va)
 {
