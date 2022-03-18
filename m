Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A9F4DDBA3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbiCRO1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbiCRO1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:27:49 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C0E1FCD2F;
        Fri, 18 Mar 2022 07:26:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mm4-20020a17090b358400b001c68e836fa6so4039885pjb.3;
        Fri, 18 Mar 2022 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e9LVXJkPYFMBKXJnnDag3FAe8PKU0RnJXImEy8QBsiI=;
        b=DJMi0bsj3ErbEaJswjOyjUSQQ8RBan8LpxcYP9PmInFdrCJ0NuBBagwiT+/9Ylz8+K
         ssgpF9Sw79PLasGaqq9/qtCdUO35i32QVk8p/byHfW0p73KzbJ8gbNOUFONwcl9qV6yE
         SpFAT3Fz+uXzqXFw7CdRu4m7iDbfCig5F+CUT+ctRUcNga66nE+47JcpIZq0FcxCaj+v
         gg8ivG6wqYBg44HHnSGkeJl9BSd+nSL8+hhuDUXeow9EnJzn1ErOCvqzYzFtpX8bTgjP
         Kt5x/OnaEKErIOdb6VnPNBgoLHNGHBTWg6Gk3ZozYnqHMatbW+2p2kgB4CY2XKmBk4YV
         pxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e9LVXJkPYFMBKXJnnDag3FAe8PKU0RnJXImEy8QBsiI=;
        b=SxkFo9gNxTYv2H/48Jy6ufbCUeMP2g9rgQhg8GgQYg+K0jA8JQpbQxDMMW/lWD6/l0
         spwI2LgfcU6fSEFDKkVtUCVt0glTRjGf3vMuNZNv1Kl/z0Jjw33z3L+RJEED3AuByeoR
         dAZbYcWQ+njhuI3qz4YKg10Mf8VEV0BZQJlfStCcvYLZjyJH2RZtdjyOse/4V8gDFrzR
         540eaJa5gHqKrC095UCVLa08LkVDCsb0TCJrwRa4VTkRR+P3gcelTS20WkdScWfrUi6P
         VyDOLrNHd56IM/e5j4Cyzby2lLuJmNmt2vY3n37J5VDvAurmkDMlqItLJ1CuIpM7JRCi
         pcvw==
X-Gm-Message-State: AOAM530I+bllMQjojMIDFhcSuRaAkOW5D28DEYfE1oLGoOTW6/5XiNvo
        Unuy89H7xUyZld1VWcQ4KpE=
X-Google-Smtp-Source: ABdhPJx/vPMSfk6+dSksj9kt7CIVhYP2bKnXTOJhvwcx3x1Pa3SG2bBuX1UobkUiReDS+yhW8ip51A==
X-Received: by 2002:a17:902:f549:b0:151:f9ce:4ec1 with SMTP id h9-20020a170902f54900b00151f9ce4ec1mr9836166plf.3.1647613589825;
        Fri, 18 Mar 2022 07:26:29 -0700 (PDT)
Received: from localhost.localdomain (2001-b011-20e0-3ff5-1d2d-7804-c968-aa19.dynamic-ip6.hinet.net. [2001:b011:20e0:3ff5:1d2d:7804:c968:aa19])
        by smtp.googlemail.com with ESMTPSA id m11-20020a056a00080b00b004f791d0115esm10690839pfk.171.2022.03.18.07.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 07:26:29 -0700 (PDT)
From:   Chin En Lin <shiyn.lin@gmail.com>
To:     corbet@lwn.net
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Chin En Lin <shiyn.lin@gmail.com>
Subject: [PATCH v2] Documentation: x86: Fix obsolete name of page fault handler
Date:   Fri, 18 Mar 2022 22:25:36 +0800
Message-Id: <20220318142536.116761-1-shiyn.lin@gmail.com>
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

Since commit 91eeafea1e4b ("x86/entry: Switch page fault exception to
IDTENTRY_RAW"), the function name of the page fault handler is out of date.
And because of commit aa37c51b9421 ("x86/mm: Break out user address space
handling"), the description of search_exception_table is not correct
anymore. It may mislead the user who wants to use the documentation to
figure out the page fault handler.

Also, fix typo and add the parentheses after function and macro name.

Signed-off-by: Chin En Lin <shiyn.lin@gmail.com>
---
 Documentation/x86/exception-tables.rst | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/Documentation/x86/exception-tables.rst b/Documentation/x86/exception-tables.rst
index de58110c5ffd..efde1fef4fbd 100644
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
+exc_page_fault() first obtains the inaccessible address from the CPU
 control register CR2. If the address is within the virtual address
 space of the process, the fault probably occurred, because the page
 was not swapped in, write protected or something similar. However,
@@ -57,10 +57,10 @@ Where does fixup point to?
 
 Since we jump to the contents of fixup, fixup obviously points
 to executable code. This code is hidden inside the user access macros.
-I have picked the get_user macro defined in arch/x86/include/asm/uaccess.h
+I have picked the get_user() macro defined in arch/x86/include/asm/uaccess.h
 as an example. The definition is somewhat hard to follow, so let's peek at
 the code generated by the preprocessor and the compiler. I selected
-the get_user call in drivers/char/sysrq.c for a detailed examination.
+the get_user() call in drivers/char/sysrq.c for a detailed examination.
 
 The original code in sysrq.c line 587::
 
@@ -281,12 +281,15 @@ vma occurs?
 
     > c017e7a5 <do_con_write+e1> movb   (%ebx),%dl
 #. MMU generates exception
-#. CPU calls do_page_fault
-#. do page fault calls search_exception_table (regs->eip == c017e7a5);
-#. search_exception_table looks up the address c017e7a5 in the
+#. CPU calls exc_page_fault()
+#. exc_page_fault() calls do_user_addr_fault()
+#. do_user_addr_fault() calls kernelmode_fixup_or_oops()
+#. kernelmode_fixup_or_oops() calls fixup_exception() (regs->eip == c017e7a5);
+#. fixup_exception() calls search_exception_tables()
+#. search_exception_tables() looks up the address c017e7a5 in the
    exception table (i.e. the contents of the ELF section __ex_table)
    and returns the address of the associated fault handle code c0199ff5.
-#. do_page_fault modifies its own return address to point to the fault
+#. fixup_exception() modifies its own return address to point to the fault
    handle code and returns.
 #. execution continues in the fault handling code.
 #. a) EAX becomes -EFAULT (== -14)
@@ -298,9 +301,9 @@ The steps 8a to 8c in a certain way emulate the faulting instruction.
 
 That's it, mostly. If you look at our example, you might ask why
 we set EAX to -EFAULT in the exception handler code. Well, the
-get_user macro actually returns a value: 0, if the user access was
+get_user() macro actually returns a value: 0, if the user access was
 successful, -EFAULT on failure. Our original code did not test this
-return value, however the inline assembly code in get_user tries to
+return value, however the inline assembly code in get_user() tries to
 return -EFAULT. GCC selected EAX to return this value.
 
 NOTE:
-- 
2.25.1

