Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F0F572F62
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbiGMHkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiGMHkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:40:11 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28399E4F3B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:40:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bu42so17783914lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VI5KbKkHr71o87v7m/QN1baECd4kMlp4wUo4lndt4PY=;
        b=c5FAHhmyMfRlrsjTSOylh6LHgqsvT63TWt6BjwuX1SQ55wilxRmYeBmvki1Q1orU4T
         0m8JYgj3Auc0nHKDULQ4IUkjBg9Yw9bkHmCIi/OAYB9tYaoFxzWrb0tz8FwKDOPPqQ8Y
         TRj1A1Nwz85j7B1u9sv+2/j0JwsWdDWGdVpd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VI5KbKkHr71o87v7m/QN1baECd4kMlp4wUo4lndt4PY=;
        b=m/4W88uRULFrx8KC4PAzCC3d5zdFJ9uDJIjrg0W/sPOpDyR2dyRzz086FdxD4fNZTI
         Yj6ZrczhcwbfuyrjsMtmNAa7C1lJdDdMe6zJAzeBn/YHgq4BoM965DPOAHDoeC0fHI1w
         xw6KZMlC4efQiTCzTwKieumL/6P0m/YxPcQnbGzbjxfvaJ+fPUWvQF7rpBNRB5qtacwV
         OEF65Rj8c09tO9iLN2DE0YcQmPzqQjwwYYh4wetcNbSA8LHvBvHTCCmTdDg+y/j1o3aT
         PmcVdAp0UwMvAe5anYLitoY7zuQuyrTBK/Ii+gc8qhEFYiRA9PMFAga6tUQsXXlCQfA9
         JgYA==
X-Gm-Message-State: AJIora8HdFjV6MIdsVXMnZBqWV4bf2Jcl8OusV5M2Npz+2bYAj7luyvX
        Ir7cherp6UgKc2r7Q1x/d8DMqy0hwQBOGMi6IaPk5A==
X-Google-Smtp-Source: AGRyM1sFqwkKnI7uWOu3/Zgj7FXemkrwsPwrX4g7qGVWOfSLWlFUa/GB+IZ3UdrHcKNPEGgLSRKWHhooDYPP6Z4J6Hs=
X-Received: by 2002:a05:6512:2610:b0:47f:74dc:3205 with SMTP id
 bt16-20020a056512261000b0047f74dc3205mr1109041lfb.429.1657698006204; Wed, 13
 Jul 2022 00:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <Ysrf1Yc5DaRGN1WE@xsang-OptiPlex-9020> <87wncknkfe.fsf@suse.de>
In-Reply-To: <87wncknkfe.fsf@suse.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Wed, 13 Jul 2022 09:39:54 +0200
Message-ID: <CABGWkvqF9f4vOYUQeYuaDGT7yuB=8=h=yPpuG04VwicNP=wgMA@mail.gmail.com>
Subject: Re: [LTP] [can] c4e54b063f: BUG:sleeping_function_called_from_invalid_context_at_kernel/workqueue.c
To:     rpalethorpe@suse.de
Cc:     kernel test robot <oliver.sang@intel.com>, lkp@intel.com,
        lkp@lists.01.org, Jeroen Hofstee <jhofstee@victronenergy.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-can@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 11, 2022 at 10:05 AM Richard Palethorpe <rpalethorpe@suse.de> w=
rote:
>
> Hello,
>
> kernel test robot <oliver.sang@intel.com> writes:
>
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-11):
> >
> > commit: c4e54b063f42f20a6b3ad1ffa61c574e631e0216 ("can: slcan: use CAN =
network device driver API")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git
> > master
>
> I guess the problem is this may sleep with soft irqs disabled.
>
> static int slc_close(struct net_device *dev)
> {
>         struct slcan *sl =3D netdev_priv(dev);
>         int err;
>
>         spin_lock_bh(&sl->lock); <-- takes lock
>         if (sl->tty) {
>                 if (sl->can.bittiming.bitrate &&
>                     sl->can.bittiming.bitrate !=3D CAN_BITRATE_UNKNOWN) {
>                         spin_unlock_bh(&sl->lock);
>                         err =3D slcan_transmit_cmd(sl, "C\r");
>                         spin_lock_bh(&sl->lock);
>                         if (err)
>                                 netdev_warn(dev,
>                                             "failed to send close command=
 'C\\r'\n");
>                 }
>
>                 /* TTY discipline is running. */
>                 clear_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
>         }
>         netif_stop_queue(dev);
>         close_candev(dev); <-- calls cancel_delayed_work_sync()
>

I would try (since I am unable to replicate the test) to move the
spin_unlock_bh()
before calling close_candev().
Can the patch be sent now or do I have to wait until the code is in mainlin=
e?

Thanks and regards,
Dario

>
>
> >
> > in testcase: ltp
> > version: ltp-x86_64-14c1f76-1_20220625
> > with following parameters:
> >
> >       test: pty
> >       ucode: 0x21
> >
> > test-description: The LTP testsuite contains a collection of tools for =
testing the Linux kernel and related features.
> > test-url: http://linux-test-project.github.io/
> >
> >
> > on test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.=
30GHz with 8G memory
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
> >
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> >
> >
> > [  164.229702][ T3796] BUG: sleeping function called from invalid conte=
xt at kernel/workqueue.c:3010
> > [  164.229710][ T3796] in_atomic(): 1, irqs_disabled(): 0, non_block: 0=
, pid: 3796, name: pty03
> > [  164.229715][ T3796] preempt_count: 201, expected: 0
> > [  164.229719][ T3796] CPU: 1 PID: 3796 Comm: pty03 Tainted: G S       =
         5.19.0-rc3-00630-gc4e54b063f42 #1
> > [  164.229724][ T3796] Hardware name: Hewlett-Packard p6-1451cx/2ADA, B=
IOS 8.15 02/05/2013
> > [  164.229727][ T3796] Call Trace:
> > [  164.229729][ T3796]  <TASK>
> > [ 164.229732][ T3796] dump_stack_lvl (lib/dump_stack.c:107 (discriminat=
or 1))
> > [ 164.229742][ T3796] __might_resched.cold (kernel/sched/core.c:9822)
> > [ 164.229749][ T3796] start_flush_work+0x2a/0x680
> > [ 164.229756][ T3796] __flush_work+0xa1/0x140
> > [ 164.229761][ T3796] ? start_flush_work+0x680/0x680
> > [ 164.229766][ T3796] ? out_of_line_wait_on_bit_timeout (kernel/sched/c=
ompletion.c:100)
> > [ 164.229774][ T3796] ? detach_if_pending (kernel/time/timer.c:1252)
> > [ 164.229779][ T3796] ? try_to_grab_pending+0x23/0x480
> > [ 164.229784][ T3796] __cancel_work_timer (kernel/workqueue.c:3162)
> > [ 164.229789][ T3796] ? start_flush_work+0xac/0x680
> > [ 164.229794][ T3796] ? try_to_grab_pending+0x480/0x480
> > [ 164.229799][ T3796] ? flush_work (kernel/workqueue.c:3074 kernel/work=
queue.c:3096)
> > [ 164.229803][ T3796] ? flush_rcu_work (kernel/workqueue.c:3095)
> > [ 164.229807][ T3796] ? synchronize_rcu_expedited (kernel/rcu/tree.c:38=
35)
> > [ 164.229813][ T3796] ? _raw_spin_lock_bh (arch/x86/include/asm/atomic.=
h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qs=
pinlock.h:111 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h=
:127 kernel/locking/spinlock.c:178)
> > [ 164.229817][ T3796] ? _raw_spin_lock (kernel/locking/spinlock.c:177)
> > [ 164.229824][ T3796] close_candev (drivers/net/can/dev/dev.c:389) can_=
dev
> > [ 164.229835][ T3796] slc_close (drivers/net/can/slcan.c:398) slcan
> > [ 164.229842][ T3796] slcan_close (drivers/net/can/slcan.c:657) slcan
> > [ 164.229849][ T3796] tty_ldisc_hangup (drivers/tty/tty_ldisc.c:282 dri=
vers/tty/tty_ldisc.c:701)
> > [ 164.229855][ T3796] ? fasync_remove_entry (fs/fcntl.c:868)
> > [ 164.229862][ T3796] __tty_hangup+0x410/0x8c0
> > [ 164.229868][ T3796] tty_ioctl (drivers/tty/tty_io.c:2719)
> > [ 164.229873][ T3796] ? tty_release (drivers/tty/tty_io.c:2655)
> > [ 164.229877][ T3796] ? __switch_to (arch/x86/kernel/process.h:38 arch/=
x86/kernel/process_64.c:627)
> > [ 164.229883][ T3796] ? __schedule (kernel/sched/core.c:6340)
> > [ 164.229888][ T3796] ? io_schedule_timeout (kernel/sched/core.c:6340)
> > [ 164.229894][ T3796] ? __fget_files (arch/x86/include/asm/atomic64_64.=
h:22 include/linux/atomic/atomic-arch-fallback.h:2363 include/linux/atomic/=
atomic-arch-fallback.h:2388 include/linux/atomic/atomic-arch-fallback.h:240=
4 include/linux/atomic/atomic-long.h:497 include/linux/atomic/atomic-instru=
mented.h:1854 fs/file.c:882 fs/file.c:913)
> > [ 164.229901][ T3796] __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870 fs/=
ioctl.c:856 fs/ioctl.c:856)
> > [ 164.229907][ T3796] do_syscall_64 (arch/x86/entry/common.c:50 arch/x8=
6/entry/common.c:80)
> > [ 164.229913][ T3796] entry_SYSCALL_64_after_hwframe (arch/x86/entry/en=
try_64.S:115)
> > [  164.229918][ T3796] RIP: 0033:0x7fd1923fbcc7
> > [ 164.229923][ T3796] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 0=
0 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 0=
0 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 00 00                   add    %al,(%rax)
> >    2: 00 48 8b                add    %cl,-0x75(%rax)
> >    5: 05 c9 91 0c 00          add    $0xc91c9,%eax
> >    a: 64 c7 00 26 00 00 00    movl   $0x26,%fs:(%rax)
> >   11: 48 c7 c0 ff ff ff ff    mov    $0xffffffffffffffff,%rax
> >   18: c3                      retq
> >   19: 66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
> >   20: 00 00 00
> >   23: b8 10 00 00 00          mov    $0x10,%eax
> >   28: 0f 05                   syscall
> >   2a:*        48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax  =
       <-- trapping instruction
> >   30: 73 01                   jae    0x33
> >   32: c3                      retq
> >   33: 48 8b 0d 99 91 0c 00    mov    0xc9199(%rip),%rcx        # 0xc91d=
3
> >   3a: f7 d8                   neg    %eax
> >   3c: 64 89 01                mov    %eax,%fs:(%rcx)
> >   3f: 48                      rex.W
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
> >    6: 73 01                   jae    0x9
> >    8: c3                      retq
> >    9: 48 8b 0d 99 91 0c 00    mov    0xc9199(%rip),%rcx        # 0xc91a=
9
> >   10: f7 d8                   neg    %eax
> >   12: 64 89 01                mov    %eax,%fs:(%rcx)
> >   15: 48                      rex.W
> > [  164.229927][ T3796] RSP: 002b:00007fff0f3bfc88 EFLAGS: 00000246 ORIG=
_RAX: 0000000000000010
> > [  164.229934][ T3796] RAX: ffffffffffffffda RBX: 000055ed576c7700 RCX:=
 00007fd1923fbcc7
> > [  164.229938][ T3796] RDX: 0000000000000000 RSI: 0000000000005437 RDI:=
 000000000000000d
> > [  164.229940][ T3796] RBP: 000055ed576c7b20 R08: 000000000003e5d8 R09:=
 0000000000000004
> > [  164.229943][ T3796] R10: 00007fff0f3cd170 R11: 0000000000000246 R12:=
 000000000000000d
> > [  164.229946][ T3796] R13: 0000000000000006 R14: 000055ed576c76a0 R15:=
 0000000000000004
> > [  164.229951][ T3796]  </TASK>
> > [  165.244520][ T3796] BUG: sleeping function called from invalid conte=
xt at kernel/workqueue.c:3010
> > [  165.244528][ T3796] in_atomic(): 1, irqs_disabled(): 0, non_block: 0=
, pid: 3796, name: pty03
> > [  165.244532][ T3796] preempt_count: 201, expected: 0
> > [  165.244537][ T3796] CPU: 0 PID: 3796 Comm: pty03 Tainted: G S      W=
         5.19.0-rc3-00630-gc4e54b063f42 #1
> > [  165.244543][ T3796] Hardware name: Hewlett-Packard p6-1451cx/2ADA, B=
IOS 8.15 02/05/2013
> > [  165.244546][ T3796] Call Trace:
> > [  165.244548][ T3796]  <TASK>
> > [ 165.244551][ T3796] dump_stack_lvl (lib/dump_stack.c:107 (discriminat=
or 1))
> > [ 165.244562][ T3796] __might_resched.cold (kernel/sched/core.c:9822)
> > [ 165.244569][ T3796] start_flush_work+0x2a/0x680
> > [ 165.244576][ T3796] __flush_work+0xa1/0x140
> > [ 165.244582][ T3796] ? start_flush_work+0x680/0x680
> > [ 165.244587][ T3796] ? out_of_line_wait_on_bit_timeout (kernel/sched/c=
ompletion.c:100)
> > [ 165.244594][ T3796] ? __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870 f=
s/ioctl.c:856 fs/ioctl.c:856)
> > [ 165.244601][ T3796] ? detach_if_pending (kernel/time/timer.c:1252)
> > [ 165.244607][ T3796] ? try_to_grab_pending+0x23/0x480
> > [ 165.244612][ T3796] __cancel_work_timer (kernel/workqueue.c:3162)
> > [ 165.244617][ T3796] ? start_flush_work+0xac/0x680
> > [ 165.244622][ T3796] ? try_to_grab_pending+0x480/0x480
> > [ 165.244627][ T3796] ? flush_work (kernel/workqueue.c:3074 kernel/work=
queue.c:3096)
> > [ 165.244632][ T3796] ? flush_rcu_work (kernel/workqueue.c:3095)
> > [ 165.244636][ T3796] ? synchronize_rcu_expedited (kernel/rcu/tree.c:38=
35)
> > [ 165.244641][ T3796] ? _raw_spin_lock_bh (arch/x86/include/asm/atomic.=
h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qs=
pinlock.h:111 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h=
:127 kernel/locking/spinlock.c:178)
> > [ 165.244647][ T3796] ? _raw_spin_lock (kernel/locking/spinlock.c:177)
> > [ 165.244653][ T3796] close_candev (drivers/net/can/dev/dev.c:389) can_=
dev
> > [ 165.244665][ T3796] slc_close (drivers/net/can/slcan.c:398) slcan
> > [ 165.244672][ T3796] slcan_close (drivers/net/can/slcan.c:657) slcan
> > [ 165.244679][ T3796] tty_ldisc_hangup (drivers/tty/tty_ldisc.c:282 dri=
vers/tty/tty_ldisc.c:701)
> > [ 165.244685][ T3796] ? fasync_remove_entry (fs/fcntl.c:868)
> > [ 165.244691][ T3796] __tty_hangup+0x410/0x8c0
> > [ 165.244696][ T3796] tty_ioctl (drivers/tty/tty_io.c:2719)
> > [ 165.244701][ T3796] ? tty_release (drivers/tty/tty_io.c:2655)
> > [ 165.244705][ T3796] ? __switch_to (arch/x86/kernel/process.h:38 arch/=
x86/kernel/process_64.c:627)
> > [ 165.244711][ T3796] ? __schedule (kernel/sched/core.c:6340)
> > [ 165.244716][ T3796] ? io_schedule_timeout (kernel/sched/core.c:6340)
> > [ 165.244721][ T3796] ? __fget_files (arch/x86/include/asm/atomic64_64.=
h:22 include/linux/atomic/atomic-arch-fallback.h:2363 include/linux/atomic/=
atomic-arch-fallback.h:2388 include/linux/atomic/atomic-arch-fallback.h:240=
4 include/linux/atomic/atomic-long.h:497 include/linux/atomic/atomic-instru=
mented.h:1854 fs/file.c:882 fs/file.c:913)
> > [ 165.244727][ T3796] __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870 fs/=
ioctl.c:856 fs/ioctl.c:856)
> > [ 165.244733][ T3796] do_syscall_64 (arch/x86/entry/common.c:50 arch/x8=
6/entry/common.c:80)
> > [ 165.244739][ T3796] entry_SYSCALL_64_after_hwframe (arch/x86/entry/en=
try_64.S:115)
> > [  165.244744][ T3796] RIP: 0033:0x7fd1923fbcc7
> > [ 165.244749][ T3796] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 0=
0 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 0=
0 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 00 00                   add    %al,(%rax)
> >    2: 00 48 8b                add    %cl,-0x75(%rax)
> >    5: 05 c9 91 0c 00          add    $0xc91c9,%eax
> >    a: 64 c7 00 26 00 00 00    movl   $0x26,%fs:(%rax)
> >   11: 48 c7 c0 ff ff ff ff    mov    $0xffffffffffffffff,%rax
> >   18: c3                      retq
> >   19: 66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
> >   20: 00 00 00
> >   23: b8 10 00 00 00          mov    $0x10,%eax
> >   28: 0f 05                   syscall
> >   2a:*        48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax  =
       <-- trapping instruction
> >   30: 73 01                   jae    0x33
> >   32: c3                      retq
> >   33: 48 8b 0d 99 91 0c 00    mov    0xc9199(%rip),%rcx        # 0xc91d=
3
> >   3a: f7 d8                   neg    %eax
> >   3c: 64 89 01                mov    %eax,%fs:(%rcx)
> >   3f: 48                      rex.W
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
> >    6: 73 01                   jae    0x9
> >    8: c3                      retq
> >    9: 48 8b 0d 99 91 0c 00    mov    0xc9199(%rip),%rcx        # 0xc91a=
9
> >   10: f7 d8                   neg    %eax
> >   12: 64 89 01                mov    %eax,%fs:(%rcx)
> >   15: 48                      rex.W
> > [  165.244753][ T3796] RSP: 002b:00007fff0f3bfc88 EFLAGS: 00000246 ORIG=
_RAX: 0000000000000010
> > [  165.244759][ T3796] RAX: ffffffffffffffda RBX: 000055ed576c7700 RCX:=
 00007fd1923fbcc7
> > [  165.244762][ T3796] RDX: 0000000000000000 RSI: 0000000000005437 RDI:=
 000000000000000d
> > [  165.244765][ T3796] RBP: 000055ed576c7b20 R08: 000000000003edc6 R09:=
 0000000000000004
> > [  165.244768][ T3796] R10: 00007fff0f3cd170 R11: 0000000000000246 R12:=
 000000000000000d
> > [  165.244771][ T3796] R13: 0000000000000006 R14: 000055ed576c76a0 R15:=
 0000000000000004
> > [  165.244775][ T3796]  </TASK>
> > [  166.256559][ T3796] BUG: sleeping function called from invalid conte=
xt at kernel/workqueue.c:3010
> > [  166.256569][ T3796] in_atomic(): 1, irqs_disabled(): 0, non_block: 0=
, pid: 3796, name: pty03
> > [  166.256574][ T3796] preempt_count: 201, expected: 0
> > [  166.256578][ T3796] CPU: 0 PID: 3796 Comm: pty03 Tainted: G S      W=
         5.19.0-rc3-00630-gc4e54b063f42 #1
> > [  166.256584][ T3796] Hardware name: Hewlett-Packard p6-1451cx/2ADA, B=
IOS 8.15 02/05/2013
> > [  166.256587][ T3796] Call Trace:
> > [  166.256590][ T3796]  <TASK>
> > [ 166.256592][ T3796] dump_stack_lvl (lib/dump_stack.c:107 (discriminat=
or 1))
> > [ 166.256602][ T3796] __might_resched.cold (kernel/sched/core.c:9822)
> > [ 166.256609][ T3796] start_flush_work+0x2a/0x680
> > [ 166.256617][ T3796] __flush_work+0xa1/0x140
> > [ 166.256622][ T3796] ? start_flush_work+0x680/0x680
> > [ 166.256628][ T3796] ? out_of_line_wait_on_bit_timeout (kernel/sched/c=
ompletion.c:100)
> > [ 166.256634][ T3796] ? __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870 f=
s/ioctl.c:856 fs/ioctl.c:856)
> > [ 166.256642][ T3796] ? detach_if_pending (kernel/time/timer.c:1252)
> > [ 166.256647][ T3796] ? try_to_grab_pending+0x23/0x480
> > [ 166.256652][ T3796] __cancel_work_timer (kernel/workqueue.c:3162)
> > [ 166.256657][ T3796] ? start_flush_work+0xac/0x680
> > [ 166.256662][ T3796] ? try_to_grab_pending+0x480/0x480
> > [ 166.256668][ T3796] ? flush_work (kernel/workqueue.c:3074 kernel/work=
queue.c:3096)
> > [ 166.256672][ T3796] ? flush_rcu_work (kernel/workqueue.c:3095)
> > [ 166.256677][ T3796] ? synchronize_rcu_expedited (kernel/rcu/tree.c:38=
35)
> > [ 166.256683][ T3796] ? _raw_spin_lock_bh (arch/x86/include/asm/atomic.=
h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qs=
pinlock.h:111 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h=
:127 kernel/locking/spinlock.c:178)
> > [ 166.256687][ T3796] ? _raw_spin_lock (kernel/locking/spinlock.c:177)
> > [ 166.256694][ T3796] close_candev (drivers/net/can/dev/dev.c:389) can_=
dev
> > [ 166.256707][ T3796] slc_close (drivers/net/can/slcan.c:398) slcan
> > [ 166.256714][ T3796] slcan_close (drivers/net/can/slcan.c:657) slcan
> > [ 166.256721][ T3796] tty_ldisc_hangup (drivers/tty/tty_ldisc.c:282 dri=
vers/tty/tty_ldisc.c:701)
> > [ 166.256728][ T3796] ? fasync_remove_entry (fs/fcntl.c:868)
> > [ 166.256734][ T3796] __tty_hangup+0x410/0x8c0
> > [ 166.256741][ T3796] tty_ioctl (drivers/tty/tty_io.c:2719)
> > [ 166.256746][ T3796] ? tty_release (drivers/tty/tty_io.c:2655)
> > [ 166.256751][ T3796] ? __switch_to (arch/x86/kernel/process.h:38 arch/=
x86/kernel/process_64.c:627)
> > [ 166.256756][ T3796] ? __schedule (kernel/sched/core.c:6340)
> > [ 166.256761][ T3796] ? io_schedule_timeout (kernel/sched/core.c:6340)
> > [ 166.256767][ T3796] ? __fget_files (arch/x86/include/asm/atomic64_64.=
h:22 include/linux/atomic/atomic-arch-fallback.h:2363 include/linux/atomic/=
atomic-arch-fallback.h:2388 include/linux/atomic/atomic-arch-fallback.h:240=
4 include/linux/atomic/atomic-long.h:497 include/linux/atomic/atomic-instru=
mented.h:1854 fs/file.c:882 fs/file.c:913)
> > [ 166.256773][ T3796] __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870 fs/=
ioctl.c:856 fs/ioctl.c:856)
> > [ 166.256780][ T3796] do_syscall_64 (arch/x86/entry/common.c:50 arch/x8=
6/entry/common.c:80)
> > [ 166.256786][ T3796] entry_SYSCALL_64_after_hwframe (arch/x86/entry/en=
try_64.S:115)
> > [  166.256791][ T3796] RIP: 0033:0x7fd1923fbcc7
> > [ 166.256797][ T3796] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 0=
0 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 0=
0 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 00 00                   add    %al,(%rax)
> >    2: 00 48 8b                add    %cl,-0x75(%rax)
> >    5: 05 c9 91 0c 00          add    $0xc91c9,%eax
> >    a: 64 c7 00 26 00 00 00    movl   $0x26,%fs:(%rax)
> >   11: 48 c7 c0 ff ff ff ff    mov    $0xffffffffffffffff,%rax
> >   18: c3                      retq
> >   19: 66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
> >   20: 00 00 00
> >   23: b8 10 00 00 00          mov    $0x10,%eax
> >   28: 0f 05                   syscall
> >   2a:*        48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax  =
       <-- trapping instruction
> >   30: 73 01                   jae    0x33
> >   32: c3                      retq
> >   33: 48 8b 0d 99 91 0c 00    mov    0xc9199(%rip),%rcx        # 0xc91d=
3
> >   3a: f7 d8                   neg    %eax
> >   3c: 64 89 01                mov    %eax,%fs:(%rcx)
> >   3f: 48                      rex.W
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
> >    6: 73 01                   jae    0x9
> >    8: c3                      retq
> >    9: 48 8b 0d 99 91 0c 00    mov    0xc9199(%rip),%rcx        # 0xc91a=
9
> >   10: f7 d8                   neg    %eax
> >   12: 64 89 01                mov    %eax,%fs:(%rcx)
> >   15: 48                      rex.W
> > [  166.256802][ T3796] RSP: 002b:00007fff0f3bfc88 EFLAGS: 00000246 ORIG=
_RAX: 0000000000000010
> > [  166.256809][ T3796] RAX: ffffffffffffffda RBX: 000055ed576c7700 RCX:=
 00007fd1923fbcc7
> > [  166.256813][ T3796] RDX: 0000000000000000 RSI: 0000000000005437 RDI:=
 000000000000000d
> > [  166.256815][ T3796] RBP: 000055ed576c7b20 R08: 000000000003f5ac R09:=
 0000000000000004
> > [  166.256818][ T3796] R10: 00007fff0f3cd170 R11: 0000000000000246 R12:=
 000000000000000d
> > [  166.256822][ T3796] R13: 0000000000000006 R14: 000055ed576c76a0 R15:=
 0000000000000004
> > [  166.256827][ T3796]  </TASK>
> > [  167.261649][ T3796] BUG: sleeping function called from invalid conte=
xt at kernel/workqueue.c:3010
> > [  167.261657][ T3796] in_atomic(): 1, irqs_disabled(): 0, non_block: 0=
, pid: 3796, name: pty03
> > [  167.261662][ T3796] preempt_count: 201, expected: 0
> > [  167.261666][ T3796] CPU: 2 PID: 3796 Comm: pty03 Tainted: G S      W=
         5.19.0-rc3-00630-gc4e54b063f42 #1
> > [  167.261672][ T3796] Hardware name: Hewlett-Packard p6-1451cx/2ADA, B=
IOS 8.15 02/05/2013
> > [  167.261675][ T3796] Call Trace:
> > [  167.261677][ T3796]  <TASK>
> > [ 167.261680][ T3796] dump_stack_lvl (lib/dump_stack.c:107 (discriminat=
or 1))
> > [ 167.261690][ T3796] __might_resched.cold (kernel/sched/core.c:9822)
> > [ 167.261697][ T3796] start_flush_work+0x2a/0x680
> > [ 167.261705][ T3796] __flush_work+0xa1/0x140
> > [ 167.261711][ T3796] ? start_flush_work+0x680/0x680
> > [ 167.261716][ T3796] ? out_of_line_wait_on_bit_timeout (kernel/sched/c=
ompletion.c:100)
> > [ 167.261724][ T3796] ? __schedule (kernel/sched/core.c:6340)
> > [ 167.261729][ T3796] ? detach_if_pending (kernel/time/timer.c:1252)
> > [ 167.261735][ T3796] ? try_to_grab_pending+0x23/0x480
> > [ 167.261740][ T3796] __cancel_work_timer (kernel/workqueue.c:3162)
> > [ 167.261745][ T3796] ? start_flush_work+0xac/0x680
> > [ 167.261750][ T3796] ? try_to_grab_pending+0x480/0x480
> > [ 167.261756][ T3796] ? flush_work (kernel/workqueue.c:3074 kernel/work=
queue.c:3096)
> > [ 167.261760][ T3796] ? flush_rcu_work (kernel/workqueue.c:3095)
> > [ 167.261765][ T3796] ? synchronize_rcu_expedited (kernel/rcu/tree.c:38=
35)
> > [ 167.261770][ T3796] ? _raw_spin_lock_bh (arch/x86/include/asm/atomic.=
h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qs=
pinlock.h:111 include/linux/spinlock.h:185 include/linux/spinlock_api_smp.h=
:127 kernel/locking/spinlock.c:178)
> > [ 167.261776][ T3796] ? _raw_spin_lock (kernel/locking/spinlock.c:177)
> > [ 167.261782][ T3796] close_candev (drivers/net/can/dev/dev.c:389) can_=
dev
> > [ 167.261794][ T3796] slc_close (drivers/net/can/slcan.c:398) slcan
> > [ 167.261801][ T3796] slcan_close (drivers/net/can/slcan.c:657) slcan
> > [ 167.261809][ T3796] tty_ldisc_hangup (drivers/tty/tty_ldisc.c:282 dri=
vers/tty/tty_ldisc.c:701)
> > [ 167.261816][ T3796] ? fasync_remove_entry (fs/fcntl.c:868)
> > [ 167.261823][ T3796] __tty_hangup+0x410/0x8c0
> > [ 167.261830][ T3796] tty_ioctl (drivers/tty/tty_io.c:2719)
> > [ 167.261835][ T3796] ? tty_release (drivers/tty/tty_io.c:2655)
> > [ 167.261840][ T3796] ? __switch_to (arch/x86/kernel/process.h:38 arch/=
x86/kernel/process_64.c:627)
> > [ 167.261846][ T3796] ? __schedule (kernel/sched/core.c:6340)
> > [ 167.261852][ T3796] ? io_schedule_timeout (kernel/sched/core.c:6340)
> > [ 167.261857][ T3796] ? __fget_files (arch/x86/include/asm/atomic64_64.=
h:22 include/linux/atomic/atomic-arch-fallback.h:2363 include/linux/atomic/=
atomic-arch-fallback.h:2388 include/linux/atomic/atomic-arch-fallback.h:240=
4 include/linux/atomic/atomic-long.h:497 include/linux/atomic/atomic-instru=
mented.h:1854 fs/file.c:882 fs/file.c:913)
> > [ 167.261865][ T3796] __x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:870 fs/=
ioctl.c:856 fs/ioctl.c:856)
> > [ 167.261871][ T3796] do_syscall_64 (arch/x86/entry/common.c:50 arch/x8=
6/entry/common.c:80)
> > [ 167.261877][ T3796] entry_SYSCALL_64_after_hwframe (arch/x86/entry/en=
try_64.S:115)
> > [  167.261883][ T3796] RIP: 0033:0x7fd1923fbcc7
> > [ 167.261888][ T3796] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 0=
0 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 0=
0 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 00 00                   add    %al,(%rax)
> >    2: 00 48 8b                add    %cl,-0x75(%rax)
> >    5: 05 c9 91 0c 00          add    $0xc91c9,%eax
> >    a: 64 c7 00 26 00 00 00    movl   $0x26,%fs:(%rax)
> >   11: 48 c7 c0 ff ff ff ff    mov    $0xffffffffffffffff,%rax
> >   18: c3                      retq
> >   19: 66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
> >   20: 00 00 00
> >   23: b8 10 00 00 00          mov    $0x10,%eax
> >   28: 0f 05                   syscall
> >   2a:*        48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax  =
       <-- trapping instruction
> >   30: 73 01                   jae    0x33
> >   32: c3                      retq
> >   33: 48 8b 0d 99 91 0c 00    mov    0xc9199(%rip),%rcx        # 0xc91d=
3
> >   3a: f7 d8                   neg    %eax
> >   3c: 64 89 01                mov    %eax,%fs:(%rcx)
> >   3f: 48                      rex.W
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
> >    6: 73 01                   jae    0x9
> >    8: c3                      retq
> >    9: 48 8b 0d 99 91 0c 00    mov    0xc9199(%rip),%rcx        # 0xc91a=
9
> >   10: f7 d8                   neg    %eax
> >   12: 64 89 01                mov    %eax,%fs:(%rcx)
> >   15: 48                      rex.W
> > [  167.261893][ T3796] RSP: 002b:00007fff0f3bfc88 EFLAGS: 00000246 ORIG=
_RAX: 0000000000000010
> > [  167.261900][ T3796] RAX: ffffffffffffffda RBX: 000055ed576c7700 RCX:=
 00007fd1923fbcc7
> > [  167.261904][ T3796] RDX: 0000000000000000 RSI: 0000000000005437 RDI:=
 000000000000000d
> > [  167.261907][ T3796] RBP: 000055ed576c7b20 R08: 000000000003fd86 R09:=
 0000000000000004
> > [  167.261910][ T3796] R10: 00007fff0f3cd170 R11: 0000000000000246 R12:=
 000000000000000d
> > [  167.261913][ T3796] R13: 0000000000000006 R14: 000055ed576c76a0 R15:=
 0000000000000004
> > [  167.261918][ T3796]  </TASK>
> > [  167.718896][  T308] Flags:                           fpu vme de pse =
tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi m=
mx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmo=
n pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf pni pclmulq=
dq dtes64 monitor ds_cpl est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 po=
pcnt tsc_deadline_timer xsave avx f16c lahf_lm cpuid_fault epb pti ssbd ibr=
s ibpb stibp fsgsbase smep erms xsaveopt dtherm arat pln pts md_clear flush=
_l1d
> > [  167.718915][  T308]
> > [  167.718952][  T308]
> > [  167.718961][  T308]
> > [  167.719897][  T308] available filesystems:
> > [  167.719908][  T308]
> > [  167.729228][  T308] 9p autofs bdev bpf btrfs cgroup cgroup2 configfs=
 cpuset debugfs devpts devtmpfs ext3 ext4 fuse fuseblk fusectl hugetlbfs mq=
ueue nfs nfs4 pipefs proc pstore ramfs rpc_pipefs securityfs sockfs sysfs t=
mpfs tracefs
> > [  167.729245][  T308]
> > [  167.729281][  T308]
> > [  167.729290][  T308]
> > [  167.731408][  T308] mounted filesystems (/proc/mounts):
> > [  167.731421][  T308]
> > [  167.732603][  T308] rootfs / rootfs rw 0 0
> > [  167.732616][  T308]
> > [  167.734793][  T308] proc /proc proc rw,nosuid,nodev,noexec,relatime =
0 0
> > [  167.734805][  T308]
> > [  167.737074][  T308] sysfs /sys sysfs rw,nosuid,nodev,noexec,relatime=
 0 0
> > [  167.737087][  T308]
> > [  167.740630][  T308] devtmpfs /dev devtmpfs rw,nosuid,noexec,size=3D4=
096k,nr_inodes=3D65536,mode=3D755 0 0
> > [  167.740643][  T308]
> > [  167.743870][  T308] securityfs /sys/kernel/security securityfs rw,no=
suid,nodev,noexec,relatime 0 0
> > [  167.743884][  T308]
> > [  167.745551][  T308] tmpfs /dev/shm tmpfs rw,nosuid,nodev 0 0
> > [  167.745560][  T308]
> > [  167.749122][  T308] devpts /dev/pts devpts rw,nosuid,noexec,relatime=
,gid=3D5,mode=3D620,ptmxmode=3D000 0 0
> > [  167.749137][  T308]
> > [  167.752335][  T308] tmpfs /run tmpfs rw,nosuid,nodev,size=3D1328156k=
,nr_inodes=3D819200,mode=3D755 0 0
> > [  167.752350][  T308]
> > [  167.755303][  T308] tmpfs /run/lock tmpfs rw,nosuid,nodev,noexec,rel=
atime,size=3D5120k 0 0
> > [  167.755317][  T308]
> > [  167.759879][  T308] cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,n=
oexec,relatime,nsdelegate,memory_recursiveprot 0 0
> > [  167.759893][  T308]
> > [  167.762861][  T308] pstore /sys/fs/pstore pstore rw,nosuid,nodev,noe=
xec,relatime 0 0
> > [  167.762875][  T308]
> > [  167.765829][  T308] bpf /sys/fs/bpf bpf rw,nosuid,nodev,noexec,relat=
ime,mode=3D700 0 0
> > [  167.765844][  T308]
> > [  167.771116][  T308] systemd-1 /proc/sys/fs/binfmt_misc autofs rw,rel=
atime,fd=3D30,pgrp=3D1,timeout=3D0,minproto=3D5,maxproto=3D5,direct,pipe_in=
o=3D15317 0 0
> > [  167.771132][  T308]
> > [  167.774045][  T308] hugetlbfs /dev/hugepages hugetlbfs rw,relatime,p=
agesize=3D2M 0 0
> > [  167.774060][  T308]
> > [  167.776802][  T308] mqueue /dev/mqueue mqueue rw,nosuid,nodev,noexec=
,relatime 0 0
> > [  167.776816][  T308]
> > [  167.778953][  T308] sunrpc /run/rpc_pipefs rpc_pipefs rw,relatime 0 =
0
> > [  167.778966][  T308]
> > [  167.781419][  T308] debugfs /sys/kernel/debug debugfs rw,nosuid,node=
v,noexec,relatime 0 0
> > [  167.781429][  T308]
> > [  167.783722][  T308] tracefs /sys/kernel/tracing tracefs rw,nosuid,no=
dev,noexec,relatime 0 0
> > [  167.783736][  T308]
> > [  167.786434][  T308] fusectl /sys/fs/fuse/connections fusectl rw,nosu=
id,nodev,noexec,relatime 0 0
> > [  167.786447][  T308]
> > [  167.789106][  T308] configfs /sys/kernel/config configfs rw,nosuid,n=
odev,noexec,relatime 0 0
> > [  167.789117][  T308]
> > [  167.790149][  T308] tmp /tmp tmpfs rw,relatime 0 0
> > [  167.790157][  T308]
> > [  167.792476][  T308] /dev/sda1 /opt/rootfs btrfs rw,relatime,ssd,spac=
e_cache,subvolid=3D5,subvol=3D/ 0 0
> > [  167.792530][  T308]
> > [  167.792555][  T308]
> > [  167.792560][  T308]
> > [  167.793218][  T308] mounted filesystems (df):
> > [  167.793224][  T308]
> > [  167.795097][  T308] Filesystem     Type      Size  Used Avail Use% M=
ounted on
> > [  167.795108][  T308]
> > [  167.797044][  T308] devtmpfs       devtmpfs  4.0M     0  4.0M   0% /=
dev
> > [  167.797057][  T308]
> > [  167.799451][  T308] tmpfs          tmpfs     3.2G     0  3.2G   0% /=
dev/shm
> > [  167.799465][  T308]
> > [  167.801444][  T308] tmpfs          tmpfs     1.3G  616K  1.3G   1% /=
run
> > [  167.801456][  T308]
> > [  167.803965][  T308] tmpfs          tmpfs     5.0M     0  5.0M   0% /=
run/lock
> > [  167.803977][  T308]
> > [  167.806314][  T308] tmp            tmpfs     3.2G  324K  3.2G   1% /=
tmp
> > [  167.806327][  T308]
> > [  167.809011][  T308] /dev/sda1      btrfs     500G   32G  468G   7% /=
opt/rootfs
> > [  167.809025][  T308]
> >
> >
> > To reproduce:
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         sudo bin/lkp install job.yaml           # job file is attached =
in this email
> >         bin/lkp split-job --compatible job.yaml # generate the yaml fil=
e for lkp run
> >         sudo bin/lkp run generated-yaml-file
> >
> >         # if come across any failure that blocks the test,
> >         # please remove ~/.lkp and /lkp dir to run from a clean state.
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
> >
> >
> > [2. text/plain; config-5.19.0-rc3-00630-gc4e54b063f42]...
> >
> > [3. text/plain; job-script]...
> >
> > [4. application/x-xz; dmesg.xz]...
> >
> > [5. text/plain; ltp]...
> >
> > [6. text/plain; job.yaml]...
> >
> > [7. text/plain; reproduce]...
>
>
> --
> Thank you,
> Richard.



--=20

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
