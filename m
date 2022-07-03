Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4310E564543
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 07:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiGCFFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 01:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiGCFF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 01:05:27 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3C6AE61;
        Sat,  2 Jul 2022 22:05:26 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id t21so6144331pfq.1;
        Sat, 02 Jul 2022 22:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hlVxCaScnZLJkKKNNp3S86nS11JatpDEtOn+lvMWbBw=;
        b=b1K+Vbf9Z3OZrQQKZW2Vb2/OZjY9VuA/NPhh7anAKwPa63+Yj12pekJJ6qN0qIMltn
         jz+5RrQ0+PH7Pn2CyNMdDtzpknkpUyQqcozS5rmuy1gD6ST/y1VfCwzcZPo9vT722gk8
         A5upVcUWjyiC/+TNgx/2apef8J91TdI0nuWWd7FDjGcWEw0ScmV0w1PDNVqpfoDbxrFz
         IAwEBrHDfEkf+C0qkA4/BKJOj08wRZyuZxd/b2BsObhR8V0dyPAzu3CE3+STqXXg/MG8
         akx9PJ1b1wCIAMvkV5EyinOHWuqsc3EEkybMI/MJBgcblEigzvimm2LQO/WwFiKnZ75c
         N8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hlVxCaScnZLJkKKNNp3S86nS11JatpDEtOn+lvMWbBw=;
        b=wP4CIhjZFF/VJdlkPkUONPJ6H4wh7AZmxaXs0EpT6ZEDhb99C6JJv1Rv8DGUZZCWVV
         Fcey42Mul4O/qS7M8XJMdvUr4rHm8jNuWNLVxybYcJI3lco1Ej6ULKo/jTMyR0Rs56P+
         Z4oljXTP4OVTV0lW/rW4EmHX+n+mbdPsmQv633UGutrJ93Rzxy/gAagDvU1gv/xoaZQr
         721Kf3pkVNbfTS46ukM4M//03GryjE80oz5qHQAdA6cU5kwAZS/eJmhrMToC2KRAMBRB
         JC9W8ObfKa+ylKOi9Q0gLx8qu5b3elwVaRUb3q7zkzn2hmNteEg+1QRj/W39S+s68msK
         iVMQ==
X-Gm-Message-State: AJIora/S5qwDYlCBnq53d4TV/B/XsudVWUE58MJr+LK4oi9hSmwJI9Vp
        4oF/7MXSslqsdjIHITUMFRc=
X-Google-Smtp-Source: AGRyM1ud0dcsh6HFmY/eo2bh2uzjOLXh1eEPG/4zwN4UO1kmSLaMaLACEuO531Hm+OGZRSuQiUV/1A==
X-Received: by 2002:a05:6a00:1353:b0:525:9f57:1a28 with SMTP id k19-20020a056a00135300b005259f571a28mr27792088pfu.69.1656824726141;
        Sat, 02 Jul 2022 22:05:26 -0700 (PDT)
Received: from archdragon (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id bj28-20020a056a00319c00b0051bc36b7995sm18174355pfb.62.2022.07.02.22.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 22:05:25 -0700 (PDT)
Date:   Sun, 3 Jul 2022 14:05:21 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     axboe@kernel.dk, rostedt@goodmis.org, mingo@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: INFO: task hung in blk_trace_remove
Message-ID: <YsEjkdFvaLkxFo/I@archdragon>
References: <YsEhsEvhZyoJFtSO@archdragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsEhsEvhZyoJFtSO@archdragon>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2022 at 01:57:25PM +0900, Dae R. Jeong wrote:
> Hello,
> 
> We observed an issue "INFO: task hung in blk_trace_remove" during
> fuzzing.

We also observed a similar issue "INFO: task hung in
blk_trace_setup". At this point, we don't know whether these two
issues are caused by the same reason.

Unfortunately, we have not found a reproducer for this crash. We will
inform you if we have any update.

The crash information is attached at the end of this email.


Best regards,
Dae R. Jeong

------

- Kernel commit:
92f20ff72066d

- Crash report:

INFO: task syz-executor.0:13708 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc3-32288-g0f3b08299494 #15
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:26560 pid:13708 ppid:  6772 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x96c/0x10f0 kernel/sched/core.c:6458
 schedule+0xea/0x1b0 kernel/sched/core.c:6530
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
 __mutex_lock_common+0xe0f/0x25e0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 blk_trace_setup+0xa9/0x1b0 kernel/trace/blktrace.c:616
 sg_ioctl_common drivers/scsi/sg.c:1122 [inline]
 sg_ioctl+0x1b61/0x4000 drivers/scsi/sg.c:1164
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0x129/0x1c0 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x478dc9
RSP: 002b:00007f5dde784be8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000077d4a0 RCX: 0000000000478dc9
RDX: 0000000020000340 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000077d4a8
R13: 000000000077d4ac R14: 000000000077d4a0 R15: 00007ffdfb78c900
 </TASK>
INFO: task syz-executor.0:13709 blocked for more than 143 seconds.
      Not tainted 5.19.0-rc3-32288-g0f3b08299494 #15
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:26608 pid:13709 ppid:  6772 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5146 [inline]
 __schedule+0x96c/0x10f0 kernel/sched/core.c:6458
 schedule+0xea/0x1b0 kernel/sched/core.c:6530
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6589
 __mutex_lock_common+0xe0f/0x25e0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 blk_trace_setup+0xa9/0x1b0 kernel/trace/blktrace.c:616
 sg_ioctl_common drivers/scsi/sg.c:1122 [inline]
 sg_ioctl+0x1b61/0x4000 drivers/scsi/sg.c:1164
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0x129/0x1c0 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x478dc9
RSP: 002b:00007f5dde763be8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000077e9c0 RCX: 0000000000478dc9
RDX: 00000000200003c0 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000077e9c8
R13: 000000000077e9cc R14: 000000000077e9c0 R15: 00007ffdfb78c900
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/40:
 #0: ffffffff9071a3e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
1 lock held by systemd-journal/3025:
 #0: ffff8880b933bb58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x25/0x110 kernel/sched/core.c:544
1 lock held by in:imklog/6630:
 #0: ffff88801c6e40e8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x2f3/0x430 fs/file.c:1036
2 locks held by syz-executor.0/13707:
1 lock held by syz-executor.0/13708:
 #0: ffff88814c195ff8 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0xa9/0x1b0 kernel/trace/blktrace.c:616
1 lock held by syz-executor.0/13709:
 #0: ffff88814c195ff8 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0xa9/0x1b0 kernel/trace/blktrace.c:616
