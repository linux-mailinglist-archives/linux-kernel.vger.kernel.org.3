Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BFD57AFBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 06:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbiGTEOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 00:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiGTEOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:14:12 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D14275D1;
        Tue, 19 Jul 2022 21:14:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id mf4so30870631ejc.3;
        Tue, 19 Jul 2022 21:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rhX7idKaFhkhxC5DWUMLGEOvB9DM3umHRJpfG4D3Bu0=;
        b=T7FQcn7KJ6JH5J7rvEmQjAygnd6DDdH0mDPpA7zZe8ubkb5TjSMTvhyCnEZTH+6zPf
         3w88uOTJYHOi51Pguvd/PIlqXVz/SKhn3Sn6WjNMPK/lXCecsGq5zt4wJr8MDf6giChA
         6MTY3zh8jwhy9DgLi4C6OKLLdjsKQ/fBjoHr/MmwC+yxDHFj3uEnGUxatqLx9HIE8fBb
         fKAakQQSfuP2DgZEes6YHBeO1DOAnYS0v1ypxdQMgDneGKw1zmt9tok6s+AP0SqgJDM1
         ISyUVs+5k74pnSWMkr/R+Sp3yDjwPSgpnT1ky3vUjayIyvjs71uCicK1sZ5DrmWyO0U5
         RAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rhX7idKaFhkhxC5DWUMLGEOvB9DM3umHRJpfG4D3Bu0=;
        b=VEK6ye2uFb5TnkgKw8pIEx7cEhGrPE+YywmBKGjCbZtQNY/+9MF94tyVg0HKjztTGN
         8Y9n0xlF6qqShOUr/qNJ32wMLeJA42i+jvFvx7Qh+I2/cA4QUtQ4WfReSEtCCthwVpwF
         pUoRfxIuM/uoz+33/KCi4/OVFwiUX8TZxSy82HLcakvajw806D+vW86ciWFm6DFIyMy1
         ZxHsuFyA+7UbQDXk25vlhuCc9ZPTNYPms2KTO9R2yiX7RQ0r0UvCQz75zhPliEAxoNkN
         rkiulsvVLcirk35tQS9acG4apoBYl74y8rXh+gcRJW2VzfT2boyu4+G62vi6yV4A1KXT
         FEWA==
X-Gm-Message-State: AJIora+RQ0xz9CD7hKoh26aVNxld30xYbVKVq2oyYtOa20DPJ+LNZeym
        r9knVNyoeGynhfuK1eDpw/A=
X-Google-Smtp-Source: AGRyM1vVePz9DbadPKAWAx7sd5Hx4ZxGEqPL0zn2pUEQsC++WQzQWzMnwBWyj5TclK/k0XHJbmfUXA==
X-Received: by 2002:a17:907:60d1:b0:72f:42a0:f3f9 with SMTP id hv17-20020a17090760d100b0072f42a0f3f9mr10057194ejc.727.1658290447296;
        Tue, 19 Jul 2022 21:14:07 -0700 (PDT)
Received: from felia.fritz.box (200116b826a11f008020c2fc6e115b3e.dip.versatel-1u1.de. [2001:16b8:26a1:1f00:8020:c2fc:6e11:5b3e])
        by smtp.gmail.com with ESMTPSA id t6-20020aa7d706000000b0043a85d7d15esm11512978edq.12.2022.07.19.21.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 21:14:06 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [RFC PATCH 2/2] docs: admin-guide: for kernel bugs refer to other kernel documentation
Date:   Wed, 20 Jul 2022 06:13:25 +0200
Message-Id: <20220720041325.15693-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220720041325.15693-1-lukas.bulwahn@gmail.com>
References: <20220720041325.15693-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current section 'If something goes wrong' makes a number of suggestions
for debugging, bug hunting and reporting issues, which are quite briefly
described in that section.

However, the suggestions are also well covered in other kernel
documentation or sometimes simply outdated. Here, each suggestion in that
section is summarized, and then followed with its assessment, and the
derived action for each suggestion:

  - use MAINTAINERS and mailing list: covered in 'Reporting issues',
    summarized in the short guide, detailed in its further section.
    Reporting issues even provides some specific examples that guides
    readers well through the needed steps. Refer to 'Reporting issues'.

  - contact Linus Torvalds: probably outdated as currently described.
    nevertheless covered in 'Reporting issues'. Reporting issues points out
    to contact the relevant kernel maintainers first, and after some
    patience and failed attempts with those maintainers, contacting Linus
    Torvalds might be okay. Refer to 'Reporting issues'.

  - tell what kernel, how to duplicate, the setup, if the problem is new
    or old and when did you notice: covered in 'Reporting issues',
    especially in Step-by-step guide how to report issues to the kernel
    maintainers. Refer to 'Reporting issues'.

  - duplicate kernel bug reports exactly: covered in 'Reporting issues',
    especially in Write and send the report. Refer to 'Reporting issues'.

  - read 'Bug hunting': keep this reference. Refer to 'Bug hunting'.

  - compile the kernel with CONFIG_KALLSYMS: covered in 'Reporting issues',
    especially in Decode failure messages. Refer to 'Reporting issues'.

  - alternatively, use ksymoops: ksymoops at the mentioned URL seems not to
    be maintained anymore. It was released roughly once a year until
    version 2.4.11 in 2005, but has not seen a new release since then. The
    information in ./scripts/ksymoops/README is from 1999, and does not
    give more insight on its actual maintenance state either. Ksymoops is
    mentioned as system utility in changes.rst, but also not recommended
    there. Drop the explanation on using ksymoops.

  - alternatively, lookup dump manually with the EIP and nm to determine
    the function in which the kernel crashes: this method seems already a
    quite advanced and low-level debugging method. Even all the further
    references on bug hunting and debugging do not mention it. Drop this
    alternative method and limit mentioning methods explained in the other
    existing kernel documentation.

  - read 'Reporting issues': keep this reference.
    Refer to 'Reporting issues'.

  - use gdb for debugging: some specific details, e.g., edit
    arch/x86/Makefile, are probably outdated or limited to one (historic
    important) setup. Using gdb is covered in 'Bug hunting', 'Debugging
    kernel and modules via gdb' and 'Using kgdb, kdb and the kernel
    debugger internals'. Refer to those three documents.

Overall, it is sufficient to refer to reporting-issues.rst,
bug-hunting.rst, gdb-kernel-debugging.rst and kgdb.rst and this way cover
the existing suggestions.

'Reporting issues' is quite new and probably up to date. 'Bug hunting',
'Debugging kernel and modules via gdb' and 'Using kgdb, kdb and the kernel
debugger internals' might need some revisit and update, but they are
generally in an acceptable state for referring to them.

Replace the existing suggestions by reference to other existing kernel
documentation covering those suggestions---partly even nicely summarized
and then explained in greater detail.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/admin-guide/README.rst | 89 +++-------------------------
 1 file changed, 7 insertions(+), 82 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index b78fe64b39f6..c47ce4830d4b 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -330,85 +330,10 @@ Compiling the kernel
 If something goes wrong
 -----------------------
 
- - If you have problems that seem to be due to kernel bugs, please check
-   the file MAINTAINERS to see if there is a particular person associated
-   with the part of the kernel that you are having trouble with. If there
-   isn't anyone listed there, then the second best thing is to mail
-   them to me (torvalds@linux-foundation.org), and possibly to any other
-   relevant mailing-list or to the newsgroup.
-
- - In all bug-reports, *please* tell what kernel you are talking about,
-   how to duplicate the problem, and what your setup is (use your common
-   sense).  If the problem is new, tell me so, and if the problem is
-   old, please try to tell me when you first noticed it.
-
- - If the bug results in a message like::
-
-     unable to handle kernel paging request at address C0000010
-     Oops: 0002
-     EIP:   0010:XXXXXXXX
-     eax: xxxxxxxx   ebx: xxxxxxxx   ecx: xxxxxxxx   edx: xxxxxxxx
-     esi: xxxxxxxx   edi: xxxxxxxx   ebp: xxxxxxxx
-     ds: xxxx  es: xxxx  fs: xxxx  gs: xxxx
-     Pid: xx, process nr: xx
-     xx xx xx xx xx xx xx xx xx xx
-
-   or similar kernel debugging information on your screen or in your
-   system log, please duplicate it *exactly*.  The dump may look
-   incomprehensible to you, but it does contain information that may
-   help debugging the problem.  The text above the dump is also
-   important: it tells something about why the kernel dumped code (in
-   the above example, it's due to a bad kernel pointer). More information
-   on making sense of the dump is in Documentation/admin-guide/bug-hunting.rst
-
- - If you compiled the kernel with CONFIG_KALLSYMS you can send the dump
-   as is, otherwise you will have to use the ``ksymoops`` program to make
-   sense of the dump (but compiling with CONFIG_KALLSYMS is usually preferred).
-   This utility can be downloaded from
-   https://www.kernel.org/pub/linux/utils/kernel/ksymoops/ .
-   Alternatively, you can do the dump lookup by hand:
-
- - In debugging dumps like the above, it helps enormously if you can
-   look up what the EIP value means.  The hex value as such doesn't help
-   me or anybody else very much: it will depend on your particular
-   kernel setup.  What you should do is take the hex value from the EIP
-   line (ignore the ``0010:``), and look it up in the kernel namelist to
-   see which kernel function contains the offending address.
-
-   To find out the kernel function name, you'll need to find the system
-   binary associated with the kernel that exhibited the symptom.  This is
-   the file 'linux/vmlinux'.  To extract the namelist and match it against
-   the EIP from the kernel crash, do::
-
-     nm vmlinux | sort | less
-
-   This will give you a list of kernel addresses sorted in ascending
-   order, from which it is simple to find the function that contains the
-   offending address.  Note that the address given by the kernel
-   debugging messages will not necessarily match exactly with the
-   function addresses (in fact, that is very unlikely), so you can't
-   just 'grep' the list: the list will, however, give you the starting
-   point of each kernel function, so by looking for the function that
-   has a starting address lower than the one you are searching for but
-   is followed by a function with a higher address you will find the one
-   you want.  In fact, it may be a good idea to include a bit of
-   "context" in your problem report, giving a few lines around the
-   interesting one.
-
-   If you for some reason cannot do the above (you have a pre-compiled
-   kernel image or similar), telling me as much about your setup as
-   possible will help.  Please read
-   'Documentation/admin-guide/reporting-issues.rst' for details.
-
- - Alternatively, you can use gdb on a running kernel. (read-only; i.e. you
-   cannot change values or set break points.) To do this, first compile the
-   kernel with -g; edit arch/x86/Makefile appropriately, then do a ``make
-   clean``. You'll also need to enable CONFIG_PROC_FS (via ``make config``).
-
-   After you've rebooted with the new kernel, do ``gdb vmlinux /proc/kcore``.
-   You can now use all the usual gdb commands. The command to look up the
-   point where your system crashed is ``l *0xXXXXXXXX``. (Replace the XXXes
-   with the EIP value.)
-
-   gdb'ing a non-running kernel currently fails because ``gdb`` (wrongly)
-   disregards the starting offset for which the kernel is compiled.
+If you have problems that seem to be due to kernel bugs, please follow the
+instructions at 'Documentation/admin-guide/reporting-issues.rst'.
+
+Hints on understanding kernel bug reports are in
+'Documentation/admin-guide/bug-hunting.rst'. More on debugging the kernel
+with gdb is in 'Documentation/dev-tools/gdb-kernel-debugging.rst' and
+'Documentation/dev-tools/kgdb.rst'.
-- 
2.17.1

