Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A8B5AC1EB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 02:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbiIDAyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 20:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiIDAyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 20:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B445E4F643
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 17:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662252842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=BzdkHxCdTzj99SJffDVFKOlFJAb1fNVqRDykaw4q/eY=;
        b=VSWIA6QwU6WUx46ni8Zgf08A/UExDqKLpXHKVVo40WClz5e0kY7B4rt7Fj1R06wIbYb5nl
        4l0q5vPlSvlN4f1L0KS7J7X2E3Zy0gzAS2h/zdQ00RC2cbpryEdW3DQo8QaF2ySAriJcEO
        p6LP/j4kou9FlrRI4RFRncFwT7+QOV4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-81fy1TVfNVO2o3bHoHo73g-1; Sat, 03 Sep 2022 20:53:59 -0400
X-MC-Unique: 81fy1TVfNVO2o3bHoHo73g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 372E529AB3EE;
        Sun,  4 Sep 2022 00:53:59 +0000 (UTC)
Received: from localhost (unknown [10.22.16.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 412C640C141D;
        Sun,  4 Sep 2022 00:53:58 +0000 (UTC)
Date:   Sat, 3 Sep 2022 21:53:57 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.140-rt73
Message-ID: <YxP3JSZKpzRMKltJ@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.140-rt73 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 7e0c30501d7e9f87e93474d4702744fadb46e54e

Or to build 5.10.140-rt73 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.140.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.140-rt73.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis


RT-specific Changes from v5.10.131-rt72:
---

Anand Je Saipureddy (1):
      ftrace: Fix improper usage of __trace_stack() function.

Yajun Deng (1):
      locking/rtmutex: switch to EXPORT_SYMBOL() for ww_mutex_lock{,_interruptible}()

---
 kernel/trace/trace_events_trigger.c                |    8 +++-----
 kernel/locking/rtmutex.c                           |    4 ++--
 2 files changed, 5 insertions(+), 7 deletions(-)
---
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 31b374d36d04b..b110fc57f7330 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -2513,7 +2513,7 @@ ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ww_mutex_lock_interruptible);
+EXPORT_SYMBOL(ww_mutex_lock_interruptible);
 
 int __sched
 ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
@@ -2533,7 +2533,7 @@ ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ww_mutex_lock);
+EXPORT_SYMBOL(ww_mutex_lock);
 
 void __sched ww_mutex_unlock(struct ww_mutex *lock)
 {
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 75fef9fcfd0fb..3c6229f16e81d 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1220,12 +1220,10 @@ stacktrace_trigger(struct event_trigger_data *data, void *rec,
 		   struct ring_buffer_event *event)
 {
 	struct trace_event_file *file = data->private_data;
-	unsigned long flags;
 
-	if (file) {
-		local_save_flags(flags);
-		__trace_stack(file->tr, STACK_SKIP, preempt_count());
-	} else
+	if (file)
+		__trace_stack(file->tr, tracing_gen_ctx(), STACK_SKIP);
+	else
 		trace_dump_stack(STACK_SKIP);
 }
 

