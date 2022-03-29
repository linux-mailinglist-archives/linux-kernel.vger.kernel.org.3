Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED32D4EB44F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 21:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241089AbiC2TxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 15:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241086AbiC2TxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 15:53:08 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED4318CD3C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 12:51:20 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id z134so16253754vsz.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 12:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6KN4lGULDBsmAO8WThInhf6RYTnI5drESVjIjVz8PHc=;
        b=GdQvZT+cRoZIRbqYEvwgpZe9nM/H19BwopzQDlTvbYaUPlH9LGSxU/i3gNMBD2jSnQ
         rHLwWsnenUoE1vKS64nOoic4sDSuUFSiEv4d1Wa6pIkvnqxW1CS8TZP77hHsuT2ekbBe
         CYKVYwlIr3ekjwLW5X1qh/7M05P9ptL0agopo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6KN4lGULDBsmAO8WThInhf6RYTnI5drESVjIjVz8PHc=;
        b=h4Xco0NxT05tEUrdmQICUfgrrqyDxyf/MpcHyGO649LS/UzYHd/91bp9YjA++lLBt1
         2tAbZBTaxQPVqC+8LOncZ2p2cHwYBc1GY+bYcS4er2H67Yyixx9gTMPo4VAed5nv3YOX
         MxnpD9jQNrCGqYNXLLGKOcdmuAJTbKdlNRLOaEiild3HaWoSGclLBTmLbZqOzBOZn5P+
         ztT4jCqm14ExlnnlMuHd0WQf+KqLeN+1MGjNk1RWD+6UX0wJoW/AzKS6AzlmrnqB20O/
         qHzicyX7kwC4wa63GXh/0Et5Us+NZqp9A/IB+wtjlaL/kJlpkrFBtrviMPwoj1ZRHOG3
         aiIw==
X-Gm-Message-State: AOAM533lFTdSXjcnJLgxnopxn0WzonK6Xru3BXF6jpsmrgZgDDsLXFKq
        mPSjWJv6kquH7PgIIHFY6l9Cwg==
X-Google-Smtp-Source: ABdhPJzmokjNJZMEhATEPoPFN5QTKP5EuXkayczo45VGQFgBWWNLyktfB7rENHAJV3aHOLdcRmlTgg==
X-Received: by 2002:a67:cf0d:0:b0:325:7e1e:60e7 with SMTP id y13-20020a67cf0d000000b003257e1e60e7mr13325078vsl.13.1648583479909;
        Tue, 29 Mar 2022 12:51:19 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id l76-20020a1ffe4f000000b0034330308d00sm220873vki.43.2022.03.29.12.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 12:51:18 -0700 (PDT)
Date:   Tue, 29 Mar 2022 15:51:17 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH] Documentation: kernel-hacking: minor edits for style
Message-ID: <20220329195117.azs4kaflc6ksfzdh@meerkat.local>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5772; h=from:subject;
 bh=Wa5/59CNpSEJn9Xl9p23TnXz0O9e8A8DvCs/HEwQWOI=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGJKck06arr3K/ubUDoMdq7fLuz1+v6G3fRcf/+m3XcKLZLN+
 6c5v7yhlYRDjYpAVU2Qp2xe7KajwoYdceo8pzBxWJpAhDFycAjARZS6GvxI6Jw4ebXyYJHOyLKNpQ+
 WNIxL1nYuPrLMoFZkmUx+id4SR4eZyfe7NfxX5p9/+rXXF9YaGUsdlpV132AvXfHwXfZfDjREA
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty's kernel-hacking guides provide important information, however
they are written in a narrative style that some readers may interpret as
off-putting. Since the goal is to make kernel documentation accessible
to as many new developers as possible, it's best to avoid the turns of
phrase that require a specific cultural context to properly understand.

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
 Documentation/kernel-hacking/hacking.rst | 36 ++++++++++++------------
 Documentation/kernel-hacking/locking.rst |  5 +---
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
index 55bd37a2efb0..ebd9d90882ea 100644
--- a/Documentation/kernel-hacking/hacking.rst
+++ b/Documentation/kernel-hacking/hacking.rst
@@ -112,8 +112,7 @@ time, although different tasklets can run simultaneously.
 .. warning::
 
     The name 'tasklet' is misleading: they have nothing to do with
-    'tasks', and probably more to do with some bad vodka Alexey
-    Kuznetsov had at the time.
+    'tasks'.
 
 You can tell you are in a softirq (or tasklet) using the
 :c:func:`in_softirq()` macro (``include/linux/preempt.h``).
@@ -290,8 +289,8 @@ userspace.
     Unlike :c:func:`put_user()` and :c:func:`get_user()`, they
     return the amount of uncopied data (ie. 0 still means success).
 
-[Yes, this moronic interface makes me cringe. The flamewar comes up
-every year or so. --RR.]
+[Yes, this objectionable interface makes me cringe. The flamewar comes
+up every year or so. --RR.]
 
 The functions may sleep implicitly. This should never be called outside
 user context (it makes no sense), with interrupts disabled, or a
@@ -645,8 +644,9 @@ names in development kernels; this is not done just to keep everyone on
 their toes: it reflects a fundamental change (eg. can no longer be
 called with interrupts on, or does extra checks, or doesn't do checks
 which were caught before). Usually this is accompanied by a fairly
-complete note to the linux-kernel mailing list; search the archive.
-Simply doing a global replace on the file usually makes things **worse**.
+complete note to the appropriate kernel development mailing list; search
+the archives. Simply doing a global replace on the file usually makes
+things **worse**.
 
 Initializing structure members
 ------------------------------
@@ -723,14 +723,14 @@ Putting Your Stuff in the Kernel
 In order to get your stuff into shape for official inclusion, or even to
 make a neat patch, there's administrative work to be done:
 
--  Figure out whose pond you've been pissing in. Look at the top of the
-   source files, inside the ``MAINTAINERS`` file, and last of all in the
-   ``CREDITS`` file. You should coordinate with this person to make sure
-   you're not duplicating effort, or trying something that's already
-   been rejected.
+-  Figure out who are the owners of the code you've been modifying. Look
+   at the top of the source files, inside the ``MAINTAINERS`` file, and
+   last of all in the ``CREDITS`` file. You should coordinate with these
+   people to make sure you're not duplicating effort, or trying something
+   that's already been rejected.
 
-   Make sure you put your name and EMail address at the top of any files
-   you create or mangle significantly. This is the first place people
+   Make sure you put your name and email address at the top of any files
+   you create or modify significantly. This is the first place people
    will look when they find a bug, or when **they** want to make a change.
 
 -  Usually you want a configuration option for your kernel hack. Edit
@@ -748,11 +748,11 @@ make a neat patch, there's administrative work to be done:
    can usually just add a "obj-$(CONFIG_xxx) += xxx.o" line. The syntax
    is documented in ``Documentation/kbuild/makefiles.rst``.
 
--  Put yourself in ``CREDITS`` if you've done something noteworthy,
-   usually beyond a single file (your name should be at the top of the
-   source files anyway). ``MAINTAINERS`` means you want to be consulted
-   when changes are made to a subsystem, and hear about bugs; it implies
-   a more-than-passing commitment to some part of the code.
+-  Put yourself in ``CREDITS`` if you consider what you've done
+   noteworthy, usually beyond a single file (your name should be at the
+   top of the source files anyway). ``MAINTAINERS`` means you want to be
+   consulted when changes are made to a subsystem, and hear about bugs;
+   it implies a more-than-passing commitment to some part of the code.
 
 -  Finally, don't forget to read
    ``Documentation/process/submitting-patches.rst`` and possibly
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index 4cbd50edf277..6805ae6e86e6 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -941,8 +941,7 @@ lock.
 
 A classic problem here is when you provide callbacks or hooks: if you
 call these with the lock held, you risk simple deadlock, or a deadly
-embrace (who knows what the callback will do?). Remember, the other
-programmers are out to get you, so don't do this.
+embrace (who knows what the callback will do?).
 
 Overzealous Prevention Of Deadlocks
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -952,8 +951,6 @@ grabs a read lock, searches a list, fails to find what it wants, drops
 the read lock, grabs a write lock and inserts the object has a race
 condition.
 
-If you don't see why, please stay away from my code.
-
 Racing Timers: A Kernel Pastime
 -------------------------------
 
-- 
2.35.1

