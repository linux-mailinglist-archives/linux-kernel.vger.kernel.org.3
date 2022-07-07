Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA756AA9B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiGGS2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbiGGS1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125B95C954;
        Thu,  7 Jul 2022 11:27:41 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QjKwUSf/0CIc/f3058/tc1u7RV6hPb3aHbLF5iDriU=;
        b=VI8AJl5Ejudeku3Ik+JtKnvnnH90rt9mC5+VnkaLH6MqzX5D40vK3pQiso0c/H0Dp2Z31L
        NWiUVVhC4QjR38PkZC9HACvOX4dCB0Pkxf0IprTWy90zhrxxfnB5Yvz0EweFawCW+EUO5i
        1wGHuGcWEXWF3USSe8YbvpjOBrGXG9zf7aEpWM6Ouc/D0Bu/aHUt8woAFJleBzbWd8JUIj
        4HeHu6YqWV34CwSqXPvnrWFclrz5tSOAFzRs0wU+ULL36eV7J9fsLgY9LC8U22tQXrLGxc
        RTFfo/kF4dpOeMOEW4JSsGdXYhLkx+/K/dtVJLbRQqhoqsewcxdWgDL6KuzDpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218459;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QjKwUSf/0CIc/f3058/tc1u7RV6hPb3aHbLF5iDriU=;
        b=YkagD+6tmWGoaznS1Im18lvkZvvQcGkZYmxGkZj9yDOi+wItA9DwJ9bo6eKkXW2Pk/6m1X
        Ls6iqiCXFmT/AYBg==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] Documentation/x86: Introduce enclave runtime
 management section
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C1da0b9a938b28e68e6870ebd5291490d680e700b=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C1da0b9a938b28e68e6870ebd5291490d680e700b=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721845865.15455.17338393708743099690.tip-bot2@tip-bot2>
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

Commit-ID:     629b5155d01b699e50ee63a3973402c64d0ac5d6
Gitweb:        https://git.kernel.org/tip/629b5155d01b699e50ee63a3973402c64d0ac5d6
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:57 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:03 -07:00

Documentation/x86: Introduce enclave runtime management section

Enclave runtime management is introduced following the pattern
of the section describing enclave building. Provide a brief
summary of enclave runtime management, pointing to the functions
implementing the ioctl()s that will contain details within their
kernel-doc.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/1da0b9a938b28e68e6870ebd5291490d680e700b.1652137848.git.reinette.chatre@intel.com
---
 Documentation/x86/sgx.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index 265568a..2bcbffa 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -100,6 +100,21 @@ pages and establish enclave page permissions.
                sgx_ioc_enclave_init
                sgx_ioc_enclave_provision
 
+Enclave runtime management
+--------------------------
+
+Systems supporting SGX2 additionally support changes to initialized
+enclaves: modifying enclave page permissions and type, and dynamically
+adding and removing of enclave pages. When an enclave accesses an address
+within its address range that does not have a backing page then a new
+regular page will be dynamically added to the enclave. The enclave is
+still required to run EACCEPT on the new page before it can be used.
+
+.. kernel-doc:: arch/x86/kernel/cpu/sgx/ioctl.c
+   :functions: sgx_ioc_enclave_restrict_permissions
+               sgx_ioc_enclave_modify_types
+               sgx_ioc_enclave_remove_pages
+
 Enclave vDSO
 ------------
 
