Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494A748D037
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiAMBjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiAMBjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:39:01 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF8BC061751
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 17:39:00 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso16022652pjo.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 17:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d70MY5lEBmu1XtB6lDZrJCZ/ytxDWn0OrAuqeIp5b3w=;
        b=AqxT7TnsbYfIukbc3pj25IEx3b5q0QujB0q1L6XEIwTMTShu+R9ew6DHKqWVp7Izaz
         MIbffhsi9QrnlDFqV5hns19goyWoP6qiNFh0ttgJPsrkZP4goLQkp8qzFnwlmgWEe/A4
         yfXoZ0ZFfqaPLAe7Rt/CE7cdlaPFiFv8J+1M2SVrDtu5tJAcphjmqVOY1fp8DJ5MCf1/
         Ixy6X+FVROGavIfjTXsa0JfFXrNYmRDaF32Sy1fscjhYRAkDWuOL3XA5/f6AKuFdtyH1
         iS7mlnY4Ynpf3yK7UKKonoZiuPzJBHiZMXw/qtHJdljhG2tVZ6graoSA0rHoH3WnUGUF
         a4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d70MY5lEBmu1XtB6lDZrJCZ/ytxDWn0OrAuqeIp5b3w=;
        b=rt3yiFRJo0x4Hc0IV5O0hlR6It05hDBwcUnhRe1pREBqHVcB1qanq1upL1HuklVRHh
         M3TAmBhGq1lnewbg1ozvOd/TGbKat04ravm9BJVS523ZUcsDCZu/xx4TD2ay5jdRh2VH
         jc/5sHfB2VfLeJvFIdOYewXgbknxJPSPUtf4Jp/QLacu5OHo+TuQIUUTcaQzfmeXpchE
         BKqPXWPpG0Epj2BaUqmxurX2gNL96ibLa1jEoE+6gY6PXvP1EXvwtBmDp8evtj0tk9t0
         QKJMnpoSF4oUAzdYPZE8OEZJz7a9+Byr2pLxLDK5pUPplgvL9l7N0Eek54oHg+XkLUio
         ffIQ==
X-Gm-Message-State: AOAM531t7iZYtYHzew3TgbN20a/tlGNo6uDwVUZV0kz2b213zNDvUOuj
        D90NU/NUP83/TgXu2Hp4f+U=
X-Google-Smtp-Source: ABdhPJzuEUaVh3pEygB6vOGFoDOh84RNuVIFV7txie9lTE2q4ZRWCoCLJAxyQ2yUf1AYsfpaGcKq3Q==
X-Received: by 2002:a17:90b:4d0e:: with SMTP id mw14mr12126213pjb.44.1642037940170;
        Wed, 12 Jan 2022 17:39:00 -0800 (PST)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id b4sm799990pfl.101.2022.01.12.17.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 17:38:59 -0800 (PST)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v7 4/4] trace/objtrace: Add documentation for objtrace
Date:   Thu, 13 Jan 2022 09:38:35 +0800
Message-Id: <20220113013835.503285-5-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113013835.503285-1-xiehuan09@gmail.com>
References: <20220113013835.503285-1-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added documentation explaining how to use objtrace trigger to get the value
of the object.

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 Documentation/trace/events.rst | 114 +++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 8ddb9b09451c..5e5d5dc31ad2 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -527,6 +527,120 @@ The following commands are supported:
 
   See Documentation/trace/histogram.rst for details and examples.
 
+- objtrace
+
+  This command provides a way to get the value of any object, The object
+  can be obtained from the dynamic event(kprobe_event/uprobe_event) or the
+  static event(tracepoint).
+
+  Usage:
+  When using the kprobe event, only need to set the objtrace(a new trigger),
+  we can get the value of the object. The object is from the setting of the
+  kprobe event.
+
+  For example:
+  For the function bio_add_page():
+
+  int bio_add_page(struct bio *bio, struct page *page,
+	unsigned int len, unsigned int offset)
+
+  Firstly, we can set the base of the object, thus the first string "arg1"
+  stands for the value of the first parameter of this function bio_add_gage(),
+
+  # echo 'p bio_add_page arg1=$arg1' >> ./kprobe_events
+
+  Secondly, we can get the value dynamically base the above object.
+
+  find the offset of the bi_size in struct bio:
+  $ gdb vmlinux
+  (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
+  $1 = (unsigned int *) 0x28
+
+  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
+	p_bio_add_page_0/trigger
+
+  The best way to use this is that we can set the entrance event and exit
+  event, for example, the following example is to set the read_papes as
+  the entrance event, and set the __blk_account_io_start as the exit event.
+
+  # cd /sys/kernel/debug/tracing/
+  # echo 0 > ./tracing_on
+  # echo 'p read_pages' >> ./kprobe_events
+  # echo 'p __blk_account_io_start' >> ./kprobe_events
+  # echo 'traceon if comm == "cat"' > ./events/kprobes/p_read_pages_0/trigger
+  # echo 'traceoff if comm == "cat"' > ./events/kprobes/p___blk_account_io_start_0/trigger
+  # echo 'p bio_add_page arg1=$arg1' >> ./kprobe_events
+  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
+
+  # du -sh /test.txt
+  12.0K   /test.txt
+
+  # cat  /test.txt > /dev/null
+  # cat ./trace
+
+  # tracer: nop
+  #
+  # entries-in-buffer/entries-written: 50/50   #P:1
+  #
+  #                                _-----=> irqs-off
+  #                               / _----=> need-resched
+  #                              | / _---=> hardirq/softirq
+  #                              || / _--=> preempt-depth
+  #                              ||| / _-=> migrate-disable
+  #                              |||| /     delay
+  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+  #              | |         |   |||||     |         |
+             cat-95      [000] .....     1.412065: _raw_spin_unlock_irqrestore <-event_triggers_call object:0xffff888108af6328 value:0x0
+             cat-95      [000] .....     1.412066: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x0
+             cat-95      [000] .....     1.412066: __bio_add_page <-bio_add_page object:0xffff888108af6328 value:0x0
+             cat-95      [000] .....     1.412066: rcu_read_unlock_strict <-xa_load object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412066: bio_add_page <-ext4_mpage_readpages object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412066: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412067: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412067: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412067: __bio_add_page <-bio_add_page object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412067: rcu_read_unlock_strict <-xa_load object:0xffff888108af6328 value:0x2000
+             cat-95      [000] .....     1.412067: bio_add_page <-ext4_mpage_readpages object:0xffff888108af6328 value:0x2000
+             cat-95      [000] .....     1.412067: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x2000
+             cat-95      [000] .....     1.412067: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x2000
+             cat-95      [000] .....     1.412067: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x2000
+             cat-95      [000] .....     1.412068: submit_bio <-ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: submit_bio_noacct <-ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: __submit_bio <-submit_bio_noacct object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: blk_try_enter_queue <-__submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: rcu_read_unlock_strict <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: rcu_read_unlock_strict <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: submit_bio_checks <-__submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: __cond_resched <-submit_bio_checks object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: rcu_all_qs <-__cond_resched object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: should_fail_bio <-submit_bio_checks object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: create_task_io_context <-submit_bio_checks object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: kmem_cache_alloc_node <-create_task_io_context object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: should_failslab <-kmem_cache_alloc_node object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: _raw_spin_lock <-create_task_io_context object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: blk_mq_submit_bio <-__submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: __blk_queue_split <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: bvec_split_segs <-__blk_queue_split object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: __blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: dd_bio_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: _raw_spin_lock <-dd_bio_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: blk_mq_sched_try_merge <-dd_bio_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: elv_merge <-blk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: elv_rqhash_find <-elv_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: dd_request_merge <-blk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: elv_rb_find <-dd_request_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: __blk_mq_alloc_request <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: dd_limit_depth <-__blk_mq_alloc_request object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: blk_mq_get_tag <-__blk_mq_alloc_request object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: __blk_mq_get_tag <-blk_mq_get_tag object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: blk_mq_rq_ctx_init.isra.0 <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: ktime_get <-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: dd_prepare_request <-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: __blk_account_io_start <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x3000
+
 7. In-kernel trace event API
 ============================
 
-- 
2.25.1

