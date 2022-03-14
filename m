Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345FF4D88BB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242882AbiCNQDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbiCNQDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:03:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D520E45ACD;
        Mon, 14 Mar 2022 09:02:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id r12so13931219pla.1;
        Mon, 14 Mar 2022 09:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PcvQcPN5XoKvKQxrvFmbQntxTbKqV4dSuPUsUyk1/VU=;
        b=loHgcdmDNyqZUA5/3x9feCiH8Ec3JeAmEtwKAF4HAFZent55/QExx9FK4FQT5X6JzT
         aPkeG6j9eH4bffZpllzupw/Nmg/nn37qeBADEp8Ui+lQFAmxYzCvxKMfXdwJ8Y4+Gq8k
         +0w2MS9lw56fRluUZSEJgViVv0K5Hh7OUxGZw8eKTey0GtnfS9z8SWjHQlzf2MN7c1Hr
         U6HWPOjQyyeusLHpfroC98VTMgYFd5T6MC5QB9dGdfU6b3O0rac0BBis0IUT2hW7a18x
         Lwav9aZHiJtVhLBwmvbv3zpLWN/WToQnHmBnotVOlAkfiIB4Q5+obxj9M10/IIVpUA2a
         CPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PcvQcPN5XoKvKQxrvFmbQntxTbKqV4dSuPUsUyk1/VU=;
        b=D/YN3Bj7N4A0r2xZDtl17bx5nlKZcR+UoMtJhE7K6SjxqAyoc0Wt5ZUbIIokbqYf0h
         3/BIMXucG6I5l4LIB+tKnluXDB9arxkReXzEBga/y3fud08m4zyanWYzPsHJuMLOSlVm
         1XoyPwN1dHSQaaBzD7jPHmBa6aURCkz8hm9m6f/Usgx6361Mc+iuh5kgm3GJ1vGBO+9I
         9oxvBFvf46prcGBdGEbiItxiHPvT+7czOYtCYar+pbmJtD0MT/whiKR54wKxFbxoUVXa
         O+rmSccWJkFXyJaq0tFCrpAN1CW0Yb15FhpsgNeEOPTv3fZ6alpNbsp7vSjNFevyHRG8
         8Q6g==
X-Gm-Message-State: AOAM532jyW9SZLP2R3m9LW0LXsmIYyd3iWGZQ91JZ7qmXayaAk89dAIC
        G5L0AKcaqvDNCjboeXf/Guk=
X-Google-Smtp-Source: ABdhPJwjdy4jTXNMl0tz+SzVz6fwoQH5DqEth/4JnvhoImqAipGstlKJCFk9sLUX4ZHW10XUeilIYw==
X-Received: by 2002:a17:90a:178f:b0:1bf:5f5a:728 with SMTP id q15-20020a17090a178f00b001bf5f5a0728mr26399573pja.171.1647273733246;
        Mon, 14 Mar 2022 09:02:13 -0700 (PDT)
Received: from localhost.localdomain (2001-b011-20e0-3483-4350-64e3-9d63-74cc.dynamic-ip6.hinet.net. [2001:b011:20e0:3483:4350:64e3:9d63:74cc])
        by smtp.googlemail.com with ESMTPSA id x15-20020a056a00188f00b004f7675962d5sm19022584pfh.175.2022.03.14.09.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:02:12 -0700 (PDT)
From:   Chin En Lin <shiyn.lin@gmail.com>
To:     corbet@lwn.net
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Chin En Lin <shiyn.lin@gmail.com>
Subject: [PATCH] Documentation: x86: Fix obsolete name of page fault handler
Date:   Mon, 14 Mar 2022 23:59:01 +0800
Message-Id: <20220314155901.227257-1-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 91eeafea1e4b ("x86/entry: Switch page fault
exception to IDTENTRY_RAW"), the function name of page
fault handler is out of date. This patch change
do_page_fault() to exc_page_fault().

Signed-off-by: Chin En Lin <shiyn.lin@gmail.com>
---
 Documentation/x86/exception-tables.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/x86/exception-tables.rst b/Documentation/x86/exception-tables.rst
index de58110c5ffd..0140a06b2705 100644
--- a/Documentation/x86/exception-tables.rst
+++ b/Documentation/x86/exception-tables.rst
@@ -32,14 +32,14 @@ Whenever the kernel tries to access an address that is currently not
 accessible, the CPU generates a page fault exception and calls the
 page fault handler::
 
-  void do_page_fault(struct pt_regs *regs, unsigned long error_code)
+  void exc_page_fault(struct pt_regs *regs, unsigned long error_code)
 
 in arch/x86/mm/fault.c. The parameters on the stack are set up by
 the low level assembly glue in arch/x86/entry/entry_32.S. The parameter
 regs is a pointer to the saved registers on the stack, error_code
 contains a reason code for the exception.
 
-do_page_fault first obtains the unaccessible address from the CPU
+exc_page_fault first obtains the unaccessible address from the CPU
 control register CR2. If the address is within the virtual address
 space of the process, the fault probably occurred, because the page
 was not swapped in, write protected or something similar. However,
@@ -281,12 +281,12 @@ vma occurs?
 
     > c017e7a5 <do_con_write+e1> movb   (%ebx),%dl
 #. MMU generates exception
-#. CPU calls do_page_fault
+#. CPU calls exc_page_fault
 #. do page fault calls search_exception_table (regs->eip == c017e7a5);
 #. search_exception_table looks up the address c017e7a5 in the
    exception table (i.e. the contents of the ELF section __ex_table)
    and returns the address of the associated fault handle code c0199ff5.
-#. do_page_fault modifies its own return address to point to the fault
+#. exc_page_fault modifies its own return address to point to the fault
    handle code and returns.
 #. execution continues in the fault handling code.
 #. a) EAX becomes -EFAULT (== -14)
-- 
2.25.1

