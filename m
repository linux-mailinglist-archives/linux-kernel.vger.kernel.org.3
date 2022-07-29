Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1B558558D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiG2TYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiG2TYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:24:18 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8009666139;
        Fri, 29 Jul 2022 12:24:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id p22so6215833lji.10;
        Fri, 29 Jul 2022 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=4vuRxn65MSewpko88kTh0jDq0+QyMBlrpC0zwEayAqY=;
        b=bWlOsSG+5MMRwd0eW6TZc3oIaYRStO7pEW9wQ6UKFqOCR1rPLBRS3Grcb52xPu+zUD
         anHLwxnfhTnN+wD/0+ER4q2ws8Gq59q3tHUEdzpHxSQQuhOJxOjlKPg/IEBtuwU8CvOj
         e/PPL28t5Imr+caQ1c+5eacutQx4NBDeH0A7Map30MqV/4o/TOvNFaNPmqZoeAI0PCpM
         jo94ob0EFvKqYLMzqE6iQmqp9cClNHv8N+vlj+AflTxOJ2U7trhXRKF5AbicWllfVwFc
         3T+fEQ8kfJ6bTS9ybPtdj67UEfY3eS+xEqOcs1KfsW2Zc8Oo4Fi1hdfyal/kFp5DaKFV
         EMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=4vuRxn65MSewpko88kTh0jDq0+QyMBlrpC0zwEayAqY=;
        b=S53RMVPHCZTZbKmG1L1e5oeXQ79DH9nTI/XeOOof0iCcNrDoDHSA2nOyFWTmXsruhZ
         JbU9yzM7uR/E5W8yJclYL47uA/bhXV7H3avsvq0Y3nUxlT+HIIBdwjXFsn7L294kLNQg
         NCXSUayWlv5tLwkBtp9lUElWrtSBRGhKBU4axEwu5EibS1d8fwa/9h/n0UxAqNMPgUNf
         Zx9oRGoWBAIbVL5D4RIAoCWW6GO5wlcXaiH+E8lafDD1uwA16RLcDwuq7DDA1Pw/KLyQ
         uMVypay5jIVLhoDVNx1hLQ/OrJNeMGZkfyp9hWvgH23JiB9IaoFfGCK2q6smoJBKnaOB
         itLA==
X-Gm-Message-State: AJIora8MpaxiFNsMko5kdrG9phX8tvaIdi3TisDUI7e2xAH/QpSKhpB8
        rFgfitW+LgdCO0HHRWaJXqwu0jFb4ZPdibg4wBg=
X-Google-Smtp-Source: AGRyM1vp3oxqQLRCZqL+pNA0wwwfRtIsdiywNZFY50fE5FNkO/nG8492nlGVj2fVIP3XSyF2lWYxycoeG9y4Kc1Sck4=
X-Received: by 2002:a2e:a887:0:b0:25e:3174:fb67 with SMTP id
 m7-20020a2ea887000000b0025e3174fb67mr1497923ljq.337.1659122654500; Fri, 29
 Jul 2022 12:24:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:b5a2:0:0:0:0:0 with HTTP; Fri, 29 Jul 2022 12:24:13
 -0700 (PDT)
From:   Greg Tulli <greg.iforce@gmail.com>
Date:   Fri, 29 Jul 2022 21:24:13 +0200
Message-ID: <CAKEH-64YKTnb444AZsgm0MudN=KMM_EWv8SsNUwZGh9OGm4ayA@mail.gmail.com>
Subject: Re: [Question] iforce_serio lockup
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was advised to use a vanilla kernel with CONFIG_PROVE_LOCKING and
decode the symbols in the report. So I followed
https://kernelnewbies.org/OutreachyfirstpatchSetup and here's the
result. Thanks, Tetsuo Handa.

WARNING: possible circular locking dependency detected
5.19.0-rc6iforce-00194-gf3a76018dd55 #2 Not tainted
------------------------------------------------------
kworker/1:4/392 is trying to acquire lock:
ffff8e358419e030 (&iforce->xmit_lock){-...}-{2:2}, at:
iforce_serio_xmit (drivers/input/joystick/iforce/iforce-serio.c:38)
iforce_serio

but task is already holding lock:
ffff8e3586c6dec8 (&serport->lock){-...}-{2:2}, at:
serport_ldisc_write_wakeup (drivers/input/serio/serport.c:263) serport

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&serport->lock){-...}-{2:2}:
_raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:111
kernel/locking/spinlock.c:162)
serport_ldisc_write_wakeup (drivers/input/serio/serport.c:263) serport
tty_wakeup (drivers/tty/tty_io.c:531)
tty_port_default_wakeup (drivers/tty/tty_port.c:52)
tty_port_tty_wakeup (drivers/tty/tty_port.c:415)
uart_write_wakeup (drivers/tty/serial/serial_core.c:113 (discriminator 2))
serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1864)
serial8250_handle_irq.part.0 (./include/linux/serial_core.h:531
drivers/tty/serial/8250/8250_port.c:1956)
serial8250_default_handle_irq
(drivers/tty/serial/8250/8250_port.c:1924
drivers/tty/serial/8250/8250_port.c:1971)
serial8250_interrupt (drivers/tty/serial/8250/8250_core.c:125)
__handle_irq_event_percpu (kernel/irq/handle.c:158)
handle_irq_event_percpu (kernel/irq/handle.c:195)
handle_irq_event (kernel/irq/handle.c:212)
handle_edge_irq (kernel/irq/chip.c:820)
__common_interrupt (./include/asm-generic/irq_regs.h:28 (discriminator
22) arch/x86/kernel/irq.c:263 (discriminator 22))
common_interrupt (arch/x86/kernel/irq.c:240 (discriminator 14))
asm_common_interrupt (./arch/x86/include/asm/idtentry.h:640)
__cond_resched (kernel/sched/core.c:8228)
iforce_init_device (drivers/input/joystick/iforce/iforce.h:118
drivers/input/joystick/iforce/iforce-main.c:261) iforce
iforce_serio_connect
(drivers/input/joystick/iforce/iforce-serio.c:207) iforce_serio
serio_connect_driver (drivers/input/serio/serio.c:48)
serio_driver_probe (drivers/input/serio/serio.c:779)
really_probe (drivers/base/dd.c:555 drivers/base/dd.c:634
drivers/base/dd.c:579)
__driver_probe_device (drivers/base/dd.c:764)
driver_probe_device (drivers/base/dd.c:794)
__driver_attach (drivers/base/dd.c:1164)
bus_for_each_dev (drivers/base/bus.c:301)
driver_attach (drivers/base/dd.c:1181)
serio_handle_event (drivers/input/serio/serio.c:808
drivers/input/serio/serio.c:227)
process_one_work (./arch/x86/include/asm/jump_label.h:27
./include/linux/jump_label.h:207
./include/trace/events/workqueue.h:108 kernel/workqueue.c:2294)
worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2437)
kthread (kernel/kthread.c:376)
ret_from_fork (arch/x86/entry/entry_64.S:308)

-> #1 (&port_lock_key){-...}-{2:2}:
_raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:111
kernel/locking/spinlock.c:162)
uart_write (drivers/tty/serial/serial_core.c:577 (discriminator 1))
serport_serio_write (drivers/input/serio/serport.c:48) serport
iforce_serio_xmit (drivers/input/joystick/iforce/iforce-serio.c:51) iforce_serio
iforce_send_packet (drivers/input/joystick/iforce/iforce-packets.c:84) iforce
iforce_serio_get_id (./include/linux/kernel.h:110
drivers/input/joystick/iforce/iforce-serio.c:84) iforce_serio
iforce_init_device (drivers/input/joystick/iforce/iforce.h:118
drivers/input/joystick/iforce/iforce-main.c:261) iforce
iforce_serio_connect
(drivers/input/joystick/iforce/iforce-serio.c:207) iforce_serio
serio_connect_driver (drivers/input/serio/serio.c:48)
serio_driver_probe (drivers/input/serio/serio.c:779)
really_probe (drivers/base/dd.c:555 drivers/base/dd.c:634
drivers/base/dd.c:579)
__driver_probe_device (drivers/base/dd.c:764)
driver_probe_device (drivers/base/dd.c:794)
__driver_attach (drivers/base/dd.c:1164)
bus_for_each_dev (drivers/base/bus.c:301)
driver_attach (drivers/base/dd.c:1181)
serio_handle_event (drivers/input/serio/serio.c:808
drivers/input/serio/serio.c:227)
process_one_work (./arch/x86/include/asm/jump_label.h:27
./include/linux/jump_label.h:207
./include/trace/events/workqueue.h:108 kernel/workqueue.c:2294)
worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2437)
kthread (kernel/kthread.c:376)
ret_from_fork (arch/x86/entry/entry_64.S:308)

-> #0 (&iforce->xmit_lock){-...}-{2:2}:
__lock_acquire (kernel/locking/lockdep.c:3096
kernel/locking/lockdep.c:3214 kernel/locking/lockdep.c:3829
kernel/locking/lockdep.c:5053)
lock_acquire (kernel/locking/lockdep.c:466
kernel/locking/lockdep.c:5667 kernel/locking/lockdep.c:5630)
_raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:111
kernel/locking/spinlock.c:162)
iforce_serio_xmit (drivers/input/joystick/iforce/iforce-serio.c:38) iforce_serio
iforce_serio_write_wakeup
(drivers/input/joystick/iforce/iforce-serio.c:125) iforce_serio
serport_ldisc_write_wakeup (./include/linux/serio.h:133
drivers/input/serio/serport.c:265) serport
tty_wakeup (drivers/tty/tty_io.c:531)
tty_port_default_wakeup (drivers/tty/tty_port.c:52)
tty_port_tty_wakeup (drivers/tty/tty_port.c:415)
uart_write_wakeup (drivers/tty/serial/serial_core.c:113 (discriminator 2))
serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1864)
serial8250_handle_irq.part.0 (./include/linux/serial_core.h:531
drivers/tty/serial/8250/8250_port.c:1956)
serial8250_default_handle_irq
(drivers/tty/serial/8250/8250_port.c:1924
drivers/tty/serial/8250/8250_port.c:1971)
serial8250_interrupt (drivers/tty/serial/8250/8250_core.c:125)
__handle_irq_event_percpu (kernel/irq/handle.c:158)
handle_irq_event_percpu (kernel/irq/handle.c:195)
handle_irq_event (kernel/irq/handle.c:212)
handle_edge_irq (kernel/irq/chip.c:820)
__common_interrupt (./include/asm-generic/irq_regs.h:28 (discriminator
22) arch/x86/kernel/irq.c:263 (discriminator 22))
common_interrupt (arch/x86/kernel/irq.c:240 (discriminator 14))
asm_common_interrupt (./arch/x86/include/asm/idtentry.h:640)
__cond_resched (kernel/sched/core.c:8228)
iforce_init_device (drivers/input/joystick/iforce/iforce.h:118
drivers/input/joystick/iforce/iforce-main.c:261) iforce
iforce_serio_connect
(drivers/input/joystick/iforce/iforce-serio.c:207) iforce_serio
serio_connect_driver (drivers/input/serio/serio.c:48)
serio_driver_probe (drivers/input/serio/serio.c:779)
really_probe (drivers/base/dd.c:555 drivers/base/dd.c:634
drivers/base/dd.c:579)
__driver_probe_device (drivers/base/dd.c:764)
driver_probe_device (drivers/base/dd.c:794)
__driver_attach (drivers/base/dd.c:1164)
bus_for_each_dev (drivers/base/bus.c:301)
driver_attach (drivers/base/dd.c:1181)
serio_handle_event (drivers/input/serio/serio.c:808
drivers/input/serio/serio.c:227)
process_one_work (./arch/x86/include/asm/jump_label.h:27
./include/linux/jump_label.h:207
./include/trace/events/workqueue.h:108 kernel/workqueue.c:2294)
worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2437)
kthread (kernel/kthread.c:376)
ret_from_fork (arch/x86/entry/entry_64.S:308)

other info that might help us debug this:

Chain exists of:
&iforce->xmit_lock --> &port_lock_key --> &serport->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&serport->lock);
                               lock(&port_lock_key);
                               lock(&serport->lock);
  lock(&iforce->xmit_lock);

*** DEADLOCK ***

9 locks held by kworker/1:4/392:
#0: ffff8e358104f548 ((wq_completion)events_long){+.+.}-{0:0}, at:
process_one_work (./arch/x86/include/asm/atomic64_64.h:34
./include/linux/atomic/atomic-long.h:41
./include/linux/atomic/atomic-instrumented.h:1280
kernel/workqueue.c:636 kernel/workqueue.c:663 kernel/workqueue.c:2260)
#1: ffffb437c0efbe48 (serio_event_work){+.+.}-{0:0}, at:
process_one_work (./arch/x86/include/asm/atomic64_64.h:34
./include/linux/atomic/atomic-long.h:41
./include/linux/atomic/atomic-instrumented.h:1280
kernel/workqueue.c:636 kernel/workqueue.c:663 kernel/workqueue.c:2260)
#2: ffffffffae31dd90 (serio_mutex){+.+.}-{3:3}, at: serio_handle_event
(drivers/input/serio/serio.c:155 drivers/input/serio/serio.c:205)
#3: ffff8e3599326308 (&dev->mutex){....}-{3:3}, at:
__device_driver_lock (drivers/base/dd.c:1055)
#4: ffff8e35993261e8 (&serio->drv_mutex){+.+.}-{3:3}, at:
serio_connect_driver (drivers/input/serio/serio.c:47)
#5: ffff8e359e3d5f30 (&i->lock){-...}-{2:2}, at: serial8250_interrupt
(drivers/tty/serial/8250/8250_core.c:117)
#6: ffffffffaf3c1fb8 (&port_lock_key){-...}-{2:2}, at:
serial8250_handle_irq.part.0 (./include/linux/serial_core.h:265
drivers/tty/serial/8250/8250_port.c:1929)
#7: ffff8e35833b48a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref
(drivers/tty/tty_ldisc.c:264)
#8: ffff8e3586c6dec8 (&serport->lock){-...}-{2:2}, at:
serport_ldisc_write_wakeup (drivers/input/serio/serport.c:263) serport

stack backtrace:
CPU: 1 PID: 392 Comm: kworker/1:4 Not tainted
5.19.0-rc6iforce-00194-gf3a76018dd55 #2
Hardware name: System manufacturer System Product Name/V-P5G41E, BIOS
0204    12/21/2009
Workqueue: events_long serio_handle_event
Call Trace:
 <IRQ>
dump_stack_lvl (lib/dump_stack.c:107)
dump_stack (lib/dump_stack.c:114)
print_circular_bug.isra.0.cold (kernel/locking/lockdep.c:2053)
check_noncircular (kernel/locking/lockdep.c:2178)
__lock_acquire (kernel/locking/lockdep.c:3096
kernel/locking/lockdep.c:3214 kernel/locking/lockdep.c:3829
kernel/locking/lockdep.c:5053)
lock_acquire (kernel/locking/lockdep.c:466
kernel/locking/lockdep.c:5667 kernel/locking/lockdep.c:5630)
? iforce_serio_xmit (drivers/input/joystick/iforce/iforce-serio.c:38)
iforce_serio
? find_held_lock (kernel/locking/lockdep.c:5156)
_raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:111
kernel/locking/spinlock.c:162)
? iforce_serio_xmit (drivers/input/joystick/iforce/iforce-serio.c:38)
iforce_serio
iforce_serio_xmit (drivers/input/joystick/iforce/iforce-serio.c:38) iforce_serio
iforce_serio_write_wakeup
(drivers/input/joystick/iforce/iforce-serio.c:125) iforce_serio
serport_ldisc_write_wakeup (./include/linux/serio.h:133
drivers/input/serio/serport.c:265) serport
tty_wakeup (drivers/tty/tty_io.c:531)
tty_port_default_wakeup (drivers/tty/tty_port.c:52)
tty_port_tty_wakeup (drivers/tty/tty_port.c:415)
uart_write_wakeup (drivers/tty/serial/serial_core.c:113 (discriminator 2))
serial8250_tx_chars (drivers/tty/serial/8250/8250_port.c:1864)
serial8250_handle_irq.part.0 (./include/linux/serial_core.h:531
drivers/tty/serial/8250/8250_port.c:1956)
serial8250_default_handle_irq
(drivers/tty/serial/8250/8250_port.c:1924
drivers/tty/serial/8250/8250_port.c:1971)
serial8250_interrupt (drivers/tty/serial/8250/8250_core.c:125)
__handle_irq_event_percpu (kernel/irq/handle.c:158)
handle_irq_event_percpu (kernel/irq/handle.c:195)
handle_irq_event (kernel/irq/handle.c:212)
handle_edge_irq (kernel/irq/chip.c:820)
__common_interrupt (./include/asm-generic/irq_regs.h:28 (discriminator
22) arch/x86/kernel/irq.c:263 (discriminator 22))
common_interrupt (arch/x86/kernel/irq.c:240 (discriminator 14))
 </IRQ>
 <TASK>
asm_common_interrupt (./arch/x86/include/asm/idtentry.h:640)
RIP: 0010:__cond_resched (kernel/sched/core.c:8228)
Code: 52 a9 ff ff ff 7f 74 01 c3 9c 58 f6 c4 02 74 f8 55 48 89 e5 e8
51 ff ff ff 5d c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 <0f> 1f
44 00 00 65 8b 15 14 60 ab 52 85 d2 74 03 31 c0 c3 55 48 89
All code
========
   0:	52                   	push   %rdx
   1:	a9 ff ff ff 7f       	test   $0x7fffffff,%eax
   6:	74 01                	je     0x9
   8:	c3                   	retq
   9:	9c                   	pushfq
   a:	58                   	pop    %rax
   b:	f6 c4 02             	test   $0x2,%ah
   e:	74 f8                	je     0x8
  10:	55                   	push   %rbp
  11:	48 89 e5             	mov    %rsp,%rbp
  14:	e8 51 ff ff ff       	callq  0xffffffffffffff6a
  19:	5d                   	pop    %rbp
  1a:	c3                   	retq
  1b:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  22:	00 00 00 00
  26:	0f 1f 40 00          	nopl   0x0(%rax)
  2a:*	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)		<-- trapping instruction
  2f:	65 8b 15 14 60 ab 52 	mov    %gs:0x52ab6014(%rip),%edx        # 0x52ab604a
  36:	85 d2                	test   %edx,%edx
  38:	74 03                	je     0x3d
  3a:	31 c0                	xor    %eax,%eax
  3c:	c3                   	retq
  3d:	55                   	push   %rbp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   5:	65 8b 15 14 60 ab 52 	mov    %gs:0x52ab6014(%rip),%edx        # 0x52ab6020
   c:	85 d2                	test   %edx,%edx
   e:	74 03                	je     0x13
  10:	31 c0                	xor    %eax,%eax
  12:	c3                   	retq
  13:	55                   	push   %rbp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
RSP: 0018:ffffb437c0efbbb8 EFLAGS: 00000286
RAX: 0000000000000000 RBX: ffff8e358419e000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffffaddc1e7a RDI: 00000000ffffffff
RBP: ffffb437c0efbc20 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000253 R12: 0000000000000014
R13: ffffb437c0efbc48 R14: ffff8e35841c6000 R15: ffffb437c0efbc38
? iforce_serio_get_id
(drivers/input/joystick/iforce/iforce-serio.c:84) iforce_serio
? debug_mutex_init (kernel/locking/mutex-debug.c:89)
iforce_init_device (drivers/input/joystick/iforce/iforce.h:118
drivers/input/joystick/iforce/iforce-main.c:261) iforce
? serport_serio_open (drivers/input/serio/serport.c:60) serport
iforce_serio_connect
(drivers/input/joystick/iforce/iforce-serio.c:207) iforce_serio
serio_connect_driver (drivers/input/serio/serio.c:48)
serio_driver_probe (drivers/input/serio/serio.c:779)
really_probe (drivers/base/dd.c:555 drivers/base/dd.c:634
drivers/base/dd.c:579)
__driver_probe_device (drivers/base/dd.c:764)
driver_probe_device (drivers/base/dd.c:794)
__driver_attach (drivers/base/dd.c:1164)
? __device_attach_driver (drivers/base/dd.c:1116)
bus_for_each_dev (drivers/base/bus.c:301)
driver_attach (drivers/base/dd.c:1181)
serio_handle_event (drivers/input/serio/serio.c:808
drivers/input/serio/serio.c:227)
process_one_work (./arch/x86/include/asm/jump_label.h:27
./include/linux/jump_label.h:207
./include/trace/events/workqueue.h:108 kernel/workqueue.c:2294)
worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2437)
? process_one_work (kernel/workqueue.c:2379)
kthread (kernel/kthread.c:376)
? kthread_complete_and_exit (kernel/kthread.c:331)
ret_from_fork (arch/x86/entry/entry_64.S:308)
 </TASK>


2022-07-11 11:32 GMT+02:00, Greg T <greg.iforce@gmail.com>:

> That problem vanishes if we don't call iforce_process_packet directly
> from iforce_serio_irq, but from a tasklet. Is that a right approach?
