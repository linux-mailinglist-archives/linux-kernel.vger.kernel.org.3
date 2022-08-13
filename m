Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8445919D6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 12:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbiHMKZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 06:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMKZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 06:25:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD73214D00
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 03:25:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i14so5780261ejg.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 03:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc;
        bh=TqpeQov1/t5Jb/7z/3juof4Y019go1XPF1+TUQVJBo0=;
        b=dECD9YYx1F4uMJvRGOP30Supz+5Ktm0dFmu8GDXXfMiGDWMSXc0AYQHDIYMMri8j1R
         5nOWB46IRiudgZ0zuZNUGqdz5iYzC3NLMNRXr4gpz7sw//EC1k11Bl8Z9Q0Rj1r6nA33
         9q/rMW9K36xTz3Ih16bvHVCQEU1l6ATKpA7hk7n+w/TEbnXTyfxoD9grdD0nqoJVH1r8
         xMmW7AMthKI7aWBrQkBjTy0VCrIe/+qVHgNYue5oLIhnJK/tMzeWC+DQWWJ9OqD55FO3
         672H4Dn0+VD6CgEn0xVcdIRB584lGUem+Pjg9C5gkkwzLzoHrT3VbDaSGf88ZQqdeX8a
         krHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc;
        bh=TqpeQov1/t5Jb/7z/3juof4Y019go1XPF1+TUQVJBo0=;
        b=JSYmwwe28VUcaNo+VPN/WtYt3sb13emvyx1oPML+BJ/09MguFqB4VPbuESqiVq71A3
         wfdHNRsLSXStNxjexJwnWVUJxJj1m7+IhlIYQLWRrEkdlYyUGtuIhS8MPOFNtPMEhgzs
         XLgwQvPCbWyvlSyQaf4ggT8J7Ia9czPoxsYjHYZOoltwzMXvOS8/7/GSr9GFGatB6/dh
         GM03P/SjSHcNDovNfmygbOe7l3pk2K043iJ2xjK0f34wG1t2PAxK2lVi64BsvP9P5JvK
         lbG4Zz9CwNXj5Zld1T1wrzhsW1o7P6AOtUV96KPakXQp7nzTbruXengwYtBDIpifkzPX
         7BKA==
X-Gm-Message-State: ACgBeo2qELYDz+rhOyfK604jwBcOrLMohp9Epy30zQosnoj2b4CxjTDE
        /6g7fK5NPdIKGPLFZ/chapE=
X-Google-Smtp-Source: AA6agR7tuO7bHSoRUfOQrr7vBo0tMvPbBL6o/EJKGyBb6gjpnSeHQ8FefKMh19d3tVl3lQCOXKZpkg==
X-Received: by 2002:a17:907:761c:b0:730:babc:11ad with SMTP id jx28-20020a170907761c00b00730babc11admr5120256ejc.98.1660386354352;
        Sat, 13 Aug 2022 03:25:54 -0700 (PDT)
Received: from gmail.com (84-236-113-143.pool.digikabel.hu. [84.236.113.143])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906201100b0072f1e7b06d9sm1727262ejo.59.2022.08.13.03.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 03:25:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 13 Aug 2022 12:25:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [GIT PULL] timer fixes
Message-ID: <Yvd8L0qIbLarxrOQ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2022-08-13

   # HEAD: e362359ace6f87c201531872486ff295df306d13 posix-cpu-timers: Cleanup CPU timers before freeing them during exec

Misc timer fixes:

 - fix a potential use-after-free bug in posix timers
 - correct a prototype
 - address a build warning

 Thanks,

	Ingo

------------------>
Jiri Slaby (1):
      posix-timers: Make do_clock_gettime() static

Thadeu Lima de Souza Cascardo (1):
      posix-cpu-timers: Cleanup CPU timers before freeing them during exec

Youngmin Nam (1):
      time: Correct the prototype of ns_to_kernel_old_timeval and ns_to_timespec64


 fs/exec.c                 | 3 +++
 include/linux/time64.h    | 2 +-
 kernel/time/posix-stubs.c | 3 ++-
 kernel/time/time.c        | 4 ++--
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 5fd73915c62c..f793221f4eb6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1304,6 +1304,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 	bprm->mm = NULL;
 
 #ifdef CONFIG_POSIX_TIMERS
+	spin_lock_irq(&me->sighand->siglock);
+	posix_cpu_timers_exit(me);
+	spin_unlock_irq(&me->sighand->siglock);
 	exit_itimers(me);
 	flush_itimer_signals();
 #endif
diff --git a/include/linux/time64.h b/include/linux/time64.h
index 2fb8232cff1d..f1bcea8c124a 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -145,7 +145,7 @@ static inline s64 timespec64_to_ns(const struct timespec64 *ts)
  *
  * Returns the timespec64 representation of the nsec parameter.
  */
-extern struct timespec64 ns_to_timespec64(const s64 nsec);
+extern struct timespec64 ns_to_timespec64(s64 nsec);
 
 /**
  * timespec64_add_ns - Adds nanoseconds to a timespec64
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index fcb3b21d8bdc..90ea5f373e50 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -70,7 +70,7 @@ SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
 	return do_sys_settimeofday64(&new_tp, NULL);
 }
 
-int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
+static int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 {
 	switch (which_clock) {
 	case CLOCK_REALTIME:
@@ -90,6 +90,7 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 
 	return 0;
 }
+
 SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 		struct __kernel_timespec __user *, tp)
 {
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 29923b20e0e4..526257b3727c 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -449,7 +449,7 @@ time64_t mktime64(const unsigned int year0, const unsigned int mon0,
 }
 EXPORT_SYMBOL(mktime64);
 
-struct __kernel_old_timeval ns_to_kernel_old_timeval(const s64 nsec)
+struct __kernel_old_timeval ns_to_kernel_old_timeval(s64 nsec)
 {
 	struct timespec64 ts = ns_to_timespec64(nsec);
 	struct __kernel_old_timeval tv;
@@ -503,7 +503,7 @@ EXPORT_SYMBOL(set_normalized_timespec64);
  *
  * Returns the timespec64 representation of the nsec parameter.
  */
-struct timespec64 ns_to_timespec64(const s64 nsec)
+struct timespec64 ns_to_timespec64(s64 nsec)
 {
 	struct timespec64 ts = { 0, 0 };
 	s32 rem;
