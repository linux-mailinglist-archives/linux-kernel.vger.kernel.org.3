Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2F254C752
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345278AbiFOLW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344353AbiFOLWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:22:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEC353B49
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:22:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso945258wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 04:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xbDVWYZHwV1Fe0JhlnA6KA0AqbAr0+yv5JqJonTlKqg=;
        b=qYwRUCbx8byMPhQP+iyJDx+xZ9InHykYY5U2itS9jxsMMy4aSpXv7tamWwfCRZRtYP
         EkhLa+/7km4kOd5FG9HLYe3QCM03WryVFFP+GJWOrISKO1onbAuNzNwRQv2lmvsrr3bW
         tqQDqcTHrlRj4Tr0UZtybVpkkRadANm58A2OfAvQLSBBl4J5C7+oduBxaIyFIgYar22R
         44OMYSXQ73cCCZeY2TAtGQFPS6FsmA7M1rgaCHnGusTSTSMSc2g69p6Idc8YgitsHwvD
         ZLKCe50I1PHa3W8N82QvspCCFNhyLj6/t6cwfcMQMAlwDd34q8TGJMeu2Y8+ktp8RDup
         J+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xbDVWYZHwV1Fe0JhlnA6KA0AqbAr0+yv5JqJonTlKqg=;
        b=z98Yl50GsTKX8n3SKDuNwazAkr63nPxBcu2gD57E4Z2UuDalSTfC09Vpo0F6+DBF/m
         q06ZGdQ1f2wAdvvoyICTjU/NqPe7EmIraqsi2PloNYIstwycR9m0A54JxO3skjjQH90N
         KCVT/udL9chTusZve/ztV70LSEket6X7PmIO/yRnWyu9IWWGxrukD0LZht5Wai7Z2yv8
         a+PMUhSF8aD99KC0t5JHGHqkwYVT+rWJtL2n4/X3y2OWEcTUdS5DqkPuA8hwotNTmGRJ
         8mVNo78cO9GCVDSJLwcUxI76JvdU/YalTbOQgsN8ftBVR8x6HncQ/j1X2QtAkYmQA+fV
         VTdw==
X-Gm-Message-State: AOAM533tklY7zqoyspdbqtGx+CS4QIKIcr12/EoRii4yZhA/kuT2/nWD
        wY1acZAEEi0ZH0MVmB+asG/uyNuwdMno
X-Google-Smtp-Source: ABdhPJzhepACrJJ5YrdoTUCZr+R1BL1xPK5J6FF51anuoh9GBBzuutyPZLbUeJ0bAEQqxTRBXPFXVA==
X-Received: by 2002:a05:600c:19c9:b0:39c:72fc:9530 with SMTP id u9-20020a05600c19c900b0039c72fc9530mr9312999wmq.88.1655292129549;
        Wed, 15 Jun 2022 04:22:09 -0700 (PDT)
Received: from localhost.localdomain ([46.53.253.10])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d698a000000b0021020517639sm14104353wru.102.2022.06.15.04.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:22:08 -0700 (PDT)
Date:   Wed, 15 Jun 2022 14:22:06 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: delete unused <linux/uaccess.h> includes
Message-ID: <YqnA3mS7KBt8Z4If@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those aren't necessary after seq files won.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/array.c    |    1 -
 fs/proc/inode.c    |    2 --
 fs/proc/kmsg.c     |    1 -
 fs/proc/nommu.c    |    1 -
 fs/proc/proc_net.c |    3 ---
 fs/proc/proc_tty.c |    2 --
 fs/proc/root.c     |    3 ---
 fs/proc/vmcore.c   |    1 -
 8 files changed, 14 deletions(-)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -69,7 +69,6 @@
 #include <linux/sched/cputime.h>
 #include <linux/proc_fs.h>
 #include <linux/ioport.h>
-#include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -26,8 +26,6 @@
 #include <linux/mount.h>
 #include <linux/bug.h>
 
-#include <linux/uaccess.h>
-
 #include "internal.h"
 
 static void proc_evict_inode(struct inode *inode)
--- a/fs/proc/kmsg.c
+++ b/fs/proc/kmsg.c
@@ -15,7 +15,6 @@
 #include <linux/fs.h>
 #include <linux/syslog.h>
 
-#include <linux/uaccess.h>
 #include <asm/io.h>
 
 extern wait_queue_head_t log_wait;
--- a/fs/proc/nommu.c
+++ b/fs/proc/nommu.c
@@ -21,7 +21,6 @@
 #include <linux/seq_file.h>
 #include <linux/hugetlb.h>
 #include <linux/vmalloc.h>
-#include <linux/uaccess.h>
 #include <asm/tlb.h>
 #include <asm/div64.h>
 #include "internal.h"
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -8,9 +8,6 @@
  *
  *  proc net directory handling functions
  */
-
-#include <linux/uaccess.h>
-
 #include <linux/errno.h>
 #include <linux/time.h>
 #include <linux/proc_fs.h>
--- a/fs/proc/proc_tty.c
+++ b/fs/proc/proc_tty.c
@@ -4,8 +4,6 @@
  *
  * Copyright 1997, Theodore Ts'o
  */
-
-#include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/errno.h>
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -6,9 +6,6 @@
  *
  *  proc root directory handling functions
  */
-
-#include <linux/uaccess.h>
-
 #include <linux/errno.h>
 #include <linux/time.h>
 #include <linux/proc_fs.h>
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -25,7 +25,6 @@
 #include <linux/mutex.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
-#include <linux/uaccess.h>
 #include <linux/uio.h>
 #include <linux/cc_platform.h>
 #include <asm/io.h>
