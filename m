Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544D1585A34
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 13:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiG3LQN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jul 2022 07:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiG3LQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 07:16:10 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49581E3DC
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 04:16:08 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id z11-20020a05660217cb00b0067c63cf0236so2053428iox.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 04:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc;
        bh=q4Cc03TGWW9TKS7N4c28zvRjA9bjadtceUsapNYeJEM=;
        b=TOrIjS7EEt6eVV03OqhBZ4ZiCA2Vwosd1udCRyCn834BMnaP65vBHGAx3XpaOYiCoO
         1UUHlm1ROoMNT4ui0p1JCTsySiLwYuFinyDanjrLMZ6HoSTDcb/QU1QoXqCR6rxbweRJ
         97D+4SdsAkrkz6Y3XdqNeqtlxLoFNzRu9QIM/97NTv0kURYtHgoYOxiLKrtNWwzbR6O1
         AeGKoPSPOmbQdgrYna3h/Nkw9UbTwzqhTok6t1yRQRtetaTr+dWl8M/X1ZtKBymfe8Yr
         eH8wbeJguNodlqnqfYIkgX+CdUmdT6D7vRtZVtKAy7t4+jW7hENoFHm7XULsSDs+/2XT
         5qSg==
X-Gm-Message-State: AJIora/8KsF0Bsx3QWQu98uRTS+bjHChFeUvvz7ZZQvjoF0r6l1dy160
        7UgYEwUJFy+7/NgEzdyejslagBkboXNtvhHUFEYEhY4JG2vk
X-Google-Smtp-Source: AGRyM1vi4PqcwfKyqL4WKcHDoB08Gx9rKAaL7iKK3tft4g5eQ3vVUJfrSPryyGlyOoZvRNgp+WIjLQjW6sd622lFv0dX6PHiTgJA
MIME-Version: 1.0
X-Received: by 2002:a5d:9914:0:b0:67c:2039:caff with SMTP id
 x20-20020a5d9914000000b0067c2039caffmr2468097iol.201.1659179768077; Sat, 30
 Jul 2022 04:16:08 -0700 (PDT)
Date:   Sat, 30 Jul 2022 04:16:08 -0700
In-Reply-To: <20220730094728.1144-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1e29405e503e46f@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in net_tx_action
From:   syzbot <syzbot+3ba0493d523d007b3819@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

3347][    T1] gre: GRE over IPv4 demultiplexor driver
[   13.619124][    T1] ip_gre: GRE over IPv4 tunneling driver
[   13.631725][    T1] IPv4 over IPsec tunneling driver
[   13.640899][    T1] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
[   13.648512][    T1] Initializing XFRM netlink socket
[   13.654216][    T1] IPsec XFRM device driver
[   13.661054][    T1] NET: Registered PF_INET6 protocol family
[   13.679714][    T1] Segment Routing with IPv6
[   13.684244][    T1] RPL Segment Routing with IPv6
[   13.690226][    T1] mip6: Mobile IPv6
[   13.698639][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   13.712191][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   13.721733][    T1] NET: Registered PF_PACKET protocol family
[   13.728154][    T1] NET: Registered PF_KEY protocol family
[   13.734540][    T1] Bridge firewalling registered
[   13.740978][    T1] NET: Registered PF_X25 protocol family
[   13.746924][    T1] X25: Linux Version 0.2
[   13.795301][    T1] NET: Registered PF_NETROM protocol family
[   13.848772][    T1] NET: Registered PF_ROSE protocol family
[   13.854996][    T1] NET: Registered PF_AX25 protocol family
[   13.860824][    T1] can: controller area network core
[   13.866436][    T1] NET: Registered PF_CAN protocol family
[   13.872096][    T1] can: raw protocol
[   13.876009][    T1] can: broadcast manager protocol
[   13.881188][    T1] can: netlink gateway - max_hops=1
[   13.886852][    T1] can: SAE J1939
[   13.890404][    T1] can: isotp protocol
[   13.894929][    T1] Bluetooth: RFCOMM TTY layer initialized
[   13.900900][    T1] Bluetooth: RFCOMM socket layer initialized
[   13.907196][    T1] Bluetooth: RFCOMM ver 1.11
[   13.911864][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   13.918198][    T1] Bluetooth: BNEP filters: protocol multicast
[   13.924303][    T1] Bluetooth: BNEP socket layer initialized
[   13.930379][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   13.936749][    T1] Bluetooth: CMTP socket layer initialized
[   13.936766][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   13.936797][    T1] Bluetooth: HIDP socket layer initialized
[   13.941357][    T1] NET: Registered PF_RXRPC protocol family
[   13.961443][    T1] Key type rxrpc registered
[   13.966003][    T1] Key type rxrpc_s registered
[   13.972441][    T1] NET: Registered PF_KCM protocol family
[   13.978717][    T1] lec:lane_module_init: lec.c: initialized
[   13.984564][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   13.990961][    T1] l2tp_core: L2TP core driver, V2.0
[   13.996263][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   14.001954][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   14.008954][    T1] l2tp_netlink: L2TP netlink interface
[   14.014687][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   14.021503][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
[   14.029452][    T1] NET: Registered PF_PHONET protocol family
[   14.036072][    T1] 8021q: 802.1Q VLAN Support v1.8
[   14.053536][    T1] DCCP: Activated CCID 2 (TCP-like)
[   14.059597][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   14.069073][    T1] sctp: Hash tables configured (bind 32/56)
[   14.077557][    T1] NET: Registered PF_RDS protocol family
[   14.084307][    T1] Registered RDS/infiniband transport
[   14.091043][    T1] Registered RDS/tcp transport
[   14.096039][    T1] tipc: Activated (version 2.0.0)
[   14.101965][    T1] NET: Registered PF_TIPC protocol family
[   14.108528][    T1] tipc: Started in single node mode
[   14.114783][    T1] NET: Registered PF_SMC protocol family
[   14.121190][    T1] 9pnet: Installing 9P2000 support
[   14.127289][    T1] NET: Registered PF_CAIF protocol family
[   14.138968][    T1] NET: Registered PF_IEEE802154 protocol family
[   14.146086][    T1] Key type dns_resolver registered
[   14.151586][    T1] Key type ceph registered
[   14.157602][    T1] libceph: loaded (mon/osd proto 15/24)
[   14.166085][    T1] batman_adv: B.A.T.M.A.N. advanced 2021.2 (compatibility version 15) loaded
[   14.175270][    T1] openvswitch: Open vSwitch switching datapath
[   14.185311][    T1] NET: Registered PF_VSOCK protocol family
[   14.191809][    T1] mpls_gso: MPLS GSO support
[   14.207214][    T1] IPI shorthand broadcast: enabled
[   14.212607][    T1] AVX2 version of gcm_enc/dec engaged.
[   14.218734][    T1] AES CTR mode by8 optimization enabled
[   14.232847][    T1] sched_clock: Marking stable (14200464125, 32247819)->(14235442173, -2730229)
[   14.243629][    T1] registered taskstats version 1
[   14.258146][    T1] Loading compiled-in X.509 certificates
[   14.266298][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: f850c787ad998c396ae089c083b940ff0a9abb77'
[   14.277236][    C0] ------------[ cut here ]------------
[   14.277267][    C0] hrtimer hog tick_sched_timer ran longer than 1 tick
[   14.277332][    C0] WARNING: CPU: 0 PID: 1 at kernel/time/hrtimer.c:1690 __hrtimer_run_queues+0xbf5/0x1230
[   14.277391][    C0] Modules linked in:
[   14.277399][    C0] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc5-syzkaller #0
[   14.277414][    C0] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
[   14.277422][    C0] RIP: 0010:__hrtimer_run_queues+0xbf5/0x1230
[   14.277441][    C0] Code: 10 00 0f 0b e9 70 f6 ff ff bd 01 00 00 00 e8 b2 44 10 00 48 8b 34 24 48 c7 c7 a0 cd 8d 89 c6 05 0b 9e f2 0b 01 e8 75 c9 82 07 <0f> 0b e8 94 44 10 00 31 ff 89 ee e8 cb 4a 10 00 40 84 ed 0f 84 00
[   14.277454][    C0] RSP: 0000:ffffc90000007e20 EFLAGS: 00010086
[   14.277466][    C0] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   14.277474][    C0] RDX: ffff888140160000 RSI: ffffffff815d8865 RDI: fffff52000000fb6
[   14.277483][    C0] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
[   14.277491][    C0] R10: ffffffff815d269e R11: 0000000000000000 R12: ffff8880b9c26d60
[   14.277500][    C0] R13: ffff8880b9c26488 R14: ffff8880b9c26440 R15: ffff8880b9c263c0
[   14.277510][    C0] FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
[   14.277523][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.277532][    C0] CR2: ffff88823ffff000 CR3: 000000000b68e000 CR4: 00000000003506f0
[   14.277541][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   14.277549][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   14.277557][    C0] Call Trace:
[   14.277562][    C0]  <IRQ>
[   14.277566][    C0]  ? get_cpu_iowait_time_us+0x3f0/0x3f0
[   14.277589][    C0]  ? hrtimer_sleeper_start_expires+0x80/0x80
[   14.277605][    C0]  ? ktime_get_update_offsets_now+0x3eb/0x5c0
[   14.277624][    C0]  hrtimer_interrupt+0x31c/0x790
[   14.277647][    C0]  __sysvec_apic_timer_interrupt+0x146/0x530
[   14.277664][    C0]  sysvec_apic_timer_interrupt+0x8e/0xc0
[   14.277688][    C0]  </IRQ>
[   14.277693][    C0]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   14.277709][    C0] RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60
[   14.277724][    C0] Code: 01 f0 4d 89 03 e9 63 fd ff ff b9 ff ff ff ff ba 08 00 00 00 4d 8b 03 48 0f bd ca 49 8b 45 00 48 63 c9 e9 64 ff ff ff 0f 1f 00 <65> 8b 05 59 33 8c 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b
[   14.277736][    C0] RSP: 0000:ffffc90000c67b18 EFLAGS: 00000293
[   14.277747][    C0] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   14.277757][    C0] RDX: ffff888140160000 RSI: ffffffff815d55f3 RDI: 0000000000000003
[   14.277769][    C0] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8fcb98a7
[   14.277778][    C0] R10: ffffffff815d55e9 R11: 0000000000000000 R12: ffffffff8432d7f0
[   14.277786][    C0] R13: 0000000000000200 R14: dffffc0000000000 R15: ffffc90000c67b78
[   14.277796][    C0]  ? univ8250_console_exit+0x70/0x70
[   14.277813][    C0]  ? console_unlock+0x7b9/0xc40
[   14.277828][    C0]  ? console_unlock+0x7c3/0xc40
[   14.277842][    C0]  ? __sanitizer_cov_trace_const_cmp8+0x1d/0x70
[   14.277856][    C0]  console_unlock+0x7c9/0xc40
[   14.277872][    C0]  ? devkmsg_read+0x7d0/0x7d0
[   14.277886][    C0]  ? lock_release+0x720/0x720
[   14.277904][    C0]  ? vprintk+0x8d/0x260
[   14.277918][    C0]  ? vprintk+0x8d/0x260
[   14.277933][    C0]  vprintk_emit+0x1ca/0x560
[   14.277948][    C0]  vprintk+0x8d/0x260
[   14.277961][    C0]  printk+0xba/0xed
[   14.277978][    C0]  ? record_print_text.cold+0x16/0x16
[   14.277997][    C0]  ? copy_regset_to_user+0x160/0x160
[   14.278016][    C0]  load_certificate_list.cold+0x8f/0xa1
[   14.278031][    C0]  ? context_tracking_init+0x86/0x86
[   14.278046][    C0]  do_one_initcall+0x103/0x650
[   14.278062][    C0]  ? perf_trace_initcall_level+0x400/0x400
[   14.278076][    C0]  ? parameq+0xf0/0x170
[   14.278089][    C0]  ? asm_common_interrupt+0x1e/0x40
[   14.278110][    C0]  kernel_init_freeable+0x6b8/0x741
[   14.278128][    C0]  ? rest_init+0x3e0/0x3e0
[   14.278141][    C0]  kernel_init+0x1a/0x1d0
[   14.278152][    C0]  ? rest_init+0x3e0/0x3e0
[   14.278163][    C0]  ret_from_fork+0x1f/0x30
[   14.278186][    C0] Kernel panic - not syncing: panic_on_warn set ...
[   14.278193][    C0] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc5-syzkaller #0
[   14.278206][    C0] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
[   14.278213][    C0] Call Trace:
[   14.278217][    C0]  <IRQ>
[   14.278221][    C0]  dump_stack_lvl+0xcd/0x134
[   14.278240][    C0]  panic+0x306/0x73d
[   14.278252][    C0]  ? __warn_printk+0xf3/0xf3
[   14.278269][    C0]  ? __warn.cold+0x1a/0x44
[   14.278282][    C0]  ? __hrtimer_run_queues+0xbf5/0x1230
[   14.278299][    C0]  __warn.cold+0x35/0x44
[   14.278312][    C0]  ? __hrtimer_run_queues+0xbf5/0x1230
[   14.278328][    C0]  report_bug+0x1bd/0x210
[   14.278344][    C0]  handle_bug+0x3c/0x60
[   14.278364][    C0]  exc_invalid_op+0x14/0x40
[   14.278378][    C0]  asm_exc_invalid_op+0x12/0x20
[   14.278390][    C0] RIP: 0010:__hrtimer_run_queues+0xbf5/0x1230
[   14.278407][    C0] Code: 10 00 0f 0b e9 70 f6 ff ff bd 01 00 00 00 e8 b2 44 10 00 48 8b 34 24 48 c7 c7 a0 cd 8d 89 c6 05 0b 9e f2 0b 01 e8 75 c9 82 07 <0f> 0b e8 94 44 10 00 31 ff 89 ee e8 cb 4a 10 00 40 84 ed 0f 84 00
[   14.278419][    C0] RSP: 0000:ffffc90000007e20 EFLAGS: 00010086
[   14.278430][    C0] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   14.278438][    C0] RDX: ffff888140160000 RSI: ffffffff815d8865 RDI: fffff52000000fb6
[   14.278447][    C0] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
[   14.278455][    C0] R10: ffffffff815d269e R11: 0000000000000000 R12: ffff8880b9c26d60
[   14.278464][    C0] R13: ffff8880b9c26488 R14: ffff8880b9c26440 R15: ffff8880b9c263c0
[   14.278476][    C0]  ? wake_up_klogd.part.0+0x8e/0xd0
[   14.278490][    C0]  ? vprintk+0x95/0x260
[   14.278504][    C0]  ? get_cpu_iowait_time_us+0x3f0/0x3f0
[   14.278524][    C0]  ? hrtimer_sleeper_start_expires+0x80/0x80
[   14.278540][    C0]  ? ktime_get_update_offsets_now+0x3eb/0x5c0
[   14.278559][    C0]  hrtimer_interrupt+0x31c/0x790
[   14.278581][    C0]  __sysvec_apic_timer_interrupt+0x146/0x530
[   14.278597][    C0]  sysvec_apic_timer_interrupt+0x8e/0xc0
[   14.278614][    C0]  </IRQ>
[   14.278619][    C0]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   14.278633][    C0] RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60
[   14.278647][    C0] Code: 01 f0 4d 89 03 e9 63 fd ff ff b9 ff ff ff ff ba 08 00 00 00 4d 8b 03 48 0f bd ca 49 8b 45 00 48 63 c9 e9 64 ff ff ff 0f 1f 00 <65> 8b 05 59 33 8c 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b
[   14.278659][    C0] RSP: 0000:ffffc90000c67b18 EFLAGS: 00000293
[   14.278669][    C0] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   14.278677][    C0] RDX: ffff888140160000 RSI: ffffffff815d55f3 RDI: 0000000000000003
[   14.278686][    C0] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8fcb98a7
[   14.278694][    C0] R10: ffffffff815d55e9 R11: 0000000000000000 R12: ffffffff8432d7f0
[   14.278703][    C0] R13: 0000000000000200 R14: dffffc0000000000 R15: ffffc90000c67b78
[   14.278713][    C0]  ? univ8250_console_exit+0x70/0x70
[   14.278727][    C0]  ? console_unlock+0x7b9/0xc40
[   14.278741][    C0]  ? console_unlock+0x7c3/0xc40
[   14.278755][    C0]  ? __sanitizer_cov_trace_const_cmp8+0x1d/0x70
[   14.278769][    C0]  console_unlock+0x7c9/0xc40
[   14.278785][    C0]  ? devkmsg_read+0x7d0/0x7d0
[   14.278798][    C0]  ? lock_release+0x720/0x720
[   14.278815][    C0]  ? vprintk+0x8d/0x260
[   14.278828][    C0]  ? vprintk+0x8d/0x260
[   14.278843][    C0]  vprintk_emit+0x1ca/0x560
[   14.278858][    C0]  vprintk+0x8d/0x260
[   14.278871][    C0]  printk+0xba/0xed
[   14.278885][    C0]  ? record_print_text.cold+0x16/0x16
[   14.278905][    C0]  ? copy_regset_to_user+0x160/0x160
[   14.278922][    C0]  load_certificate_list.cold+0x8f/0xa1
[   14.278936][    C0]  ? context_tracking_init+0x86/0x86
[   14.278949][    C0]  do_one_initcall+0x103/0x650
[   14.278964][    C0]  ? perf_trace_initcall_level+0x400/0x400
[   14.278982][    C0]  ? parameq+0xf0/0x170
[   14.278995][    C0]  ? asm_common_interrupt+0x1e/0x40
[   14.279015][    C0]  kernel_init_freeable+0x6b8/0x741
[   14.279032][    C0]  ? rest_init+0x3e0/0x3e0
[   14.279044][    C0]  kernel_init+0x1a/0x1d0
[   14.279055][    C0]  ? rest_init+0x3e0/0x3e0
[   14.279066][    C0]  ret_from_fork+0x1f/0x30
[   14.279390][    C0] Kernel Offset: disabled
[   15.085281][    C0] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.17"
GCCGO="gccgo"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mod"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build3435624800=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 9d2ab5dfe
nothing to commit, working tree clean


go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=9d2ab5dfe7727dfea4b9b279f4edf731acb386ef -X 'github.com/google/syzkaller/prog.gitRevisionDate=20210626-071149'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=9d2ab5dfe7727dfea4b9b279f4edf731acb386ef -X 'github.com/google/syzkaller/prog.gitRevisionDate=20210626-071149'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=9d2ab5dfe7727dfea4b9b279f4edf731acb386ef -X 'github.com/google/syzkaller/prog.gitRevisionDate=20210626-071149'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -static -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"9d2ab5dfe7727dfea4b9b279f4edf731acb386ef\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=14ce83da080000


Tested on:

commit:         f80e2148 hrtimer: Unbreak hrtimer_force_reprogram()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=31eef52c6517a0c2
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba0493d523d007b3819
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b49b22080000

