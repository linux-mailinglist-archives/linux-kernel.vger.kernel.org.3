Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1B75A6127
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiH3Kuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiH3KuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:50:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED873898
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:50:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso17527224pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=QYiWsTuY+GQ7jsOXTe4KqbYApR4ujmKIb8Zqeks9eAg=;
        b=gUApZnosIJS0OOpnpZ/scCZkIkxSi+tICZS9tZ5hcTeFb9uKqhOSEsTFx88xwj2MtC
         msCTFFiA6+r2QuKip3v4fD1/qDqu2Pq2EBCg8OMXhOKjEUCp1RHAV0SydUs25oNK2OVC
         VE+3j4alpacFq+/94PsMmH0B+iijQIwm9ch1xR6JYvDyWMsKRU5Ve6TlMNEoZXTGyuxU
         664rvVtokbd1NBN0N1rF0RigInGBPpqIZ+Jofvp2cYX3qJriE+IiwEzmJSb3Snt1ko9l
         4AeGVN4qqm7tREx3Z3wnvot/yeBTKRhkJU5mtaczuYo/Naw+LoklbJRmudUx+fx5palC
         rb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=QYiWsTuY+GQ7jsOXTe4KqbYApR4ujmKIb8Zqeks9eAg=;
        b=WwrXLhuCxk4P5+XDbv4s8ScJQYfocq9vfU5bdUtv55NCKjEmeNWqrMHbZ8PlvAU/Bw
         G22OhDmUYAVB6TonSC80TPtaufR4NH3tk+qMqfRbNVmnF73rE6olc5FEtc0qgGz5tSa/
         Wu/BRmZhRftHd6Nb2wg6Y1n3ZRfntSIlZ4vpsMSeNWyndvQwA6d0DfmOMMyTbsIH25z2
         iITwVQYByz1TOPeTtAGSq1ZhqxEEX0KrczpO9M1H6FopX+KH1OUT/gNJpltJ6Ogd6JTP
         0L9JBYQ0xA7mtYEGgiFV/59NKrc0tn3SqGIB8XqJhWop8Mzbh7gk6EVvPxUV2Jnz4ma3
         X67A==
X-Gm-Message-State: ACgBeo06JRgYmQmWNMv5M6e0oZ0SyL+efpZe6fG0Q2jryV+Jkw0HEo67
        bAxgob4rYd/ehggCgmMC/AM=
X-Google-Smtp-Source: AA6agR5muqNWBxbq/lZBhmFGIMqfHPVcxaI0ppCZwYYhvPHH/K46s5jpuv3LkFVS21ne9ZXfjk8D/Q==
X-Received: by 2002:a17:902:d50c:b0:175:2cb2:e0e7 with SMTP id b12-20020a170902d50c00b001752cb2e0e7mr1185687plg.157.1661856606421;
        Tue, 30 Aug 2022 03:50:06 -0700 (PDT)
Received: from C02FG34WMD6R.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id z5-20020a623305000000b005251f4596f0sm8980052pfz.107.2022.08.30.03.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 03:50:06 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     paul@paul-moore.com, eparis@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] audit: remove obvious unnecessary header files
Date:   Tue, 30 Aug 2022 18:50:01 +0800
Message-Id: <20220830105001.68478-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
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

With updating the code, some header files are unnecessary. Remove
obvious header files.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 kernel/audit.c          |  3 ---
 kernel/audit_fsnotify.c |  5 -----
 kernel/audit_watch.c    |  4 ----
 kernel/auditfilter.c    |  2 --
 kernel/auditsc.c        | 11 +----------
 5 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index a75978ae38ad..f2caa710524f 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -35,13 +35,10 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/atomic.h>
-#include <linux/mm.h>
-#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/kthread.h>
 #include <linux/kernel.h>
-#include <linux/syscalls.h>
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
 #include <linux/mutex.h>
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index c565fbf66ac8..1b7b1cb7033d 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -8,15 +8,10 @@
 
 #include <linux/kernel.h>
 #include <linux/audit.h>
-#include <linux/kthread.h>
-#include <linux/mutex.h>
 #include <linux/fs.h>
 #include <linux/fsnotify_backend.h>
 #include <linux/namei.h>
-#include <linux/netlink.h>
-#include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/security.h>
 #include "audit.h"
 
 /*
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 65075f1e4ac8..68d1fa42426d 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -9,16 +9,12 @@
 #include <linux/file.h>
 #include <linux/kernel.h>
 #include <linux/audit.h>
-#include <linux/kthread.h>
 #include <linux/mutex.h>
 #include <linux/fs.h>
 #include <linux/fsnotify_backend.h>
 #include <linux/namei.h>
-#include <linux/netlink.h>
 #include <linux/refcount.h>
-#include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/security.h>
 #include "audit.h"
 
 /*
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 42d99896e7a6..7287c14dfb97 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -12,8 +12,6 @@
 #include <linux/audit.h>
 #include <linux/kthread.h>
 #include <linux/mutex.h>
-#include <linux/fs.h>
-#include <linux/namei.h>
 #include <linux/netlink.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 9f8c05228d6d..57734fea51fb 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -33,27 +33,19 @@
 
 #include <linux/init.h>
 #include <asm/types.h>
-#include <linux/atomic.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/mm.h>
 #include <linux/export.h>
 #include <linux/slab.h>
-#include <linux/mount.h>
 #include <linux/socket.h>
-#include <linux/mqueue.h>
 #include <linux/audit.h>
 #include <linux/personality.h>
 #include <linux/time.h>
-#include <linux/netlink.h>
-#include <linux/compiler.h>
 #include <asm/unistd.h>
 #include <linux/security.h>
 #include <linux/list.h>
 #include <linux/binfmts.h>
-#include <linux/highmem.h>
-#include <linux/syscalls.h>
-#include <asm/syscall.h>
 #include <linux/capability.h>
 #include <linux/fs_struct.h>
 #include <linux/compat.h>
@@ -61,8 +53,7 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/fsnotify_backend.h>
-#include <uapi/linux/limits.h>
-#include <uapi/linux/netfilter/nf_tables.h>
+#include <linux/limits.h>
 #include <uapi/linux/openat2.h> // struct open_how
 
 #include "audit.h"
-- 
2.20.1

