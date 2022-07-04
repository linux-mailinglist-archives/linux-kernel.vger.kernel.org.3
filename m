Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F290564B99
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 04:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiGDCTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 22:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiGDCTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:19:48 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0DF5F5A;
        Sun,  3 Jul 2022 19:19:47 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-f2a4c51c45so11483410fac.9;
        Sun, 03 Jul 2022 19:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/5B3DZA3v8YkghJ+NcQNYnuMCeZ2C4F7ogGlxz0CYe0=;
        b=deIadHE+w0E0ngv94TP0FL+WxeyobvwHSi5I1YYcqYfb1Ud01hPeOZX74G3c9QkMpO
         Ww5euBTyVtKwdxnBr4jJo2kCSX9lEIwR0VsNIym6UhL4KKMmkXFeWdbR49UXDAM3KFqB
         sO0YGpHYuVDhm0sZFHOUwZHDdAg8JGMZT1pOTqCzckcS4QmCvABikaFTcFUgRB3uG/d1
         FyNe1oPLTBSkLgeC/Lx5ftNv8XpykPGzB6J3MnEhXDiF16aGapUfzy/BEAHEB/bRh8KL
         KdLHVOLLyAZZmRISC5gKMTxbG+OQCNNGz203AK0CgJzMNEfK2NUjwK9UmNWfC2xQRGzo
         7Fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/5B3DZA3v8YkghJ+NcQNYnuMCeZ2C4F7ogGlxz0CYe0=;
        b=I2p6UzaJeKa3+ZfNAw2OTPdQB0CoQD71zALXbg6+tXFaU3Y4Zfnzcpm9I09yLNCcEp
         7i5NPYS2rcCsWzEYlc6B8x4gpi6NW3PVXoRqbDskPy4dIYfkCW/tpn5xt4WROPpb2AT4
         48jZv5JxwyDUhG3Q7hW+dXzrDAY4ZY0vRXboM5KhNmtSOuD5+hJnJfPsrcGFMS9xcvyN
         HZeBX9VlrWIdcnvOcg/hSw0cP//pV8ByLix/XMcEwyjt7j1N1XrXrt8vE985cCmsWdaT
         rIklMwsDGYfAl8iaR1irvvAbwzV2ncXynCEf3y5fu6WHEt5vBNI1k9t3ocpzWqvjq4ST
         c8Ew==
X-Gm-Message-State: AJIora8gW4ZEnBkhYCsg/mmrgIimDdnpw0O2v8s9Vj5xKV6VtgIasv7j
        2aVUM8YN/92qiLLgnoFwpX+y1/BxgmoagrQlKw165PrLPNE=
X-Google-Smtp-Source: AGRyM1tXlTos8TrxNJ2ApsT/a+tkT8dzvf/Tt1qlPGiPooGHWjh16NCzmHrnT2qlVpahMhJAX7Dto1+UDfu/pdtkmx4=
X-Received: by 2002:a05:6870:1601:b0:108:2d92:5494 with SMTP id
 b1-20020a056870160100b001082d925494mr16396361oae.109.1656901186508; Sun, 03
 Jul 2022 19:19:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:18f1:0:0:0:0 with HTTP; Sun, 3 Jul 2022 19:19:46
 -0700 (PDT)
In-Reply-To: <01b66305-4dc2-3825-eb59-c0882b662bab@infradead.org>
References: <495ce212-addc-8ab1-a851-4fd5f6c5c8d9@gmail.com> <01b66305-4dc2-3825-eb59-c0882b662bab@infradead.org>
From:   Greg T <greg.iforce@gmail.com>
Date:   Mon, 4 Jul 2022 04:19:46 +0200
Message-ID: <CAKEH-64QJ3HbPwNhPy1T2YKR19w5XfDBiFhWD2M1oQqkHfs70A@mail.gmail.com>
Subject: Re: |Question] iforce Boeder Force Feedback Wheel
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-07-03 7:11 GMT+02:00, Randy Dunlap <rdunlap@infradead.org>:
> [add INPUT]

Thanks.

>> 4. Force feedback seems to work from fftest (at least some of the
>> functions), but when using ff in RVGL or VDrift, the system freezes
>> and I can't find anything related in journalctl after hard resetting.
>> How should I debug this problem?
>>
>> It's on Fedora release 34. Kernel/iforce source is from
>> https://gitlab.com/cki-project/kernel-ark/-/tree/fedora-5.17/drivers/input/joystick/iforce
>> and the kernel-devel-5.17.12-100.fc34.x86_64 package.

I've upgraded to Fedora 36 and kernel 5.18.7-200.fc36.x86_64 since then.
I finally have a log of the lockups:

NMI watchdog: Watchdog detected hard LOCKUP on cpu 0
Modules linked in: joydev serport iforce_serio(OE) iforce(OE) rfkill
xt_owner ipt_REJECT nf_reject_ipv4 xt_state xt_conntrack
iptable_filter nf_conntrack_ftp xt_CT nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 iptable_raw ip_tables xt_LOG nf_log_syslog xt_limit
w83627ehf ip6table_filter hwmon_vid ip6_tables lm90 ppdev edac_mce_amd
kvm_amd ccp kvm snd_hda_codec_realtek snd_hda_codec_hdmi
snd_hda_codec_generic ledtrig_audio tuner_simple irqbypass tuner_types
snd_hda_intel tuner snd_intel_dspcfg msp3400 snd_intel_sdw_acpi
snd_hda_codec bttv snd_hda_core snd_bt87x snd_hwdep tveeprom tea575x
snd_seq snd_seq_device videobuf_dma_sg videobuf_core snd_pcm videodev
snd_timer parport_pc mc snd parport i2c_nforce2 soundcore acpi_cpufreq
k10temp fuse amdgpu iommu_v2 gpu_sched radeon firewire_ohci
drm_ttm_helper ata_generic pata_acpi ttm firewire_core serio_raw
drm_dp_helper sata_nv crc_itu_t forcedeth pata_amd
CPU: 0 PID: 4353 Comm: xfce4-terminal Kdump: loaded Tainted: G
  OE     5.18.7-200.fc36.x86_64 #1
Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./ALiveNF6G-VSTA, BIOS L2.26 08/26/2009
RIP: 0010:native_queued_spin_lock_slowpath+0x62/0x1f0
Code: 00 77 70 f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4
09 d0 3d ff 00 00 00 77 4c 85 c0 74 0e 8b 03 84 c0 74 08 f3 90 <8b> 03
84 c0 75 f8 b8 01 00 00 00 66 89 03 5b 5d 41 5c c3 cc 8b 37
RSP: 0000:ffffbb9380db7cd8 EFLAGS: 00000002
RAX: 0000000000000101 RBX: ffffffff9dc7ebc0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff9dc7ebc0
RBP: 0000000000000086 R08: ffffffff9ce653a0 R09: 0000000000000002
R10: 0000000000000000 R11: ffffffff9da9b11f R12: ffffbb9380db7d64
R13: 0000000000000001 R14: ffff9e5047ba4000 R15: ffff9e50739a44f4
FS:  00007f0ad0d2ccc0(0000) GS:ffff9e517fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2f25167008 CR3: 000000012867e000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 _raw_spin_lock_irqsave+0x41/0x50
 uart_write+0x69/0x1e0
 serport_serio_write+0x2b/0x40 [serport]
 iforce_serio_xmit+0xa8/0x1a0 [iforce_serio]
 serport_ldisc_write_wakeup+0x59/0x70 [serport]
 tty_wakeup+0x53/0x60
 tty_port_default_wakeup+0x1b/0x30
 serial8250_tx_chars+0x12d/0x230
 serial8250_handle_irq.part.0+0x12b/0x180
 serial8250_default_handle_irq+0x47/0x80
 serial8250_interrupt+0x62/0xf0
 __handle_irq_event_percpu+0x46/0x180
 handle_irq_event+0x34/0x70
 handle_edge_irq+0x9f/0x240
 __common_interrupt+0x66/0x100
 common_interrupt+0x5c/0xd0
 ? asm_common_interrupt+0x8/0x40
 asm_common_interrupt+0x1e/0x40
RIP: 0033:0x7f0ad4b499c0
Code: 66 2e 0f 1f 84 00 00 00 00 00 8d 40 ff 83 f8 2a 77 cf 31 c0 f0
0f b1 6b 1c eb c6 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 <f3> 0f
1e fa 8b 47 1c 85 c0 75 41 f6 47 30 02 75 2f 48 8b 17 48 8b
RSP: 002b:00007fff84201958 EFLAGS: 00000246
RAX: 000055eb1375e800 RBX: 000055eb13506f50 RCX: 0000000000000001
RDX: 00007fff84201928 RSI: 000055eb1375e800 RDI: 000055eb1375e800
RBP: 000055eb13506830 R08: 0000000000000000 R09: 000000000000000d
R10: 0000000000000000 R11: 0000000000000000 R12: 000055eb138fad70
R13: 00007f0ad5419ee0 R14: 0000000000000000 R15: 000055eb138fad70
 </TASK>
NMI watchdog: Watchdog detected hard LOCKUP on cpu 3
Modules linked in: joydev serport iforce_serio(OE) iforce(OE) rfkill
xt_owner ipt_REJECT nf_reject_ipv4 xt_state xt_conntrack
iptable_filter nf_conntrack_ftp xt_CT nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 iptable_raw ip_tables xt_LOG nf_log_syslog xt_limit
w83627ehf ip6table_filter hwmon_vid ip6_tables lm90 ppdev edac_mce_amd
kvm_amd ccp kvm snd_hda_codec_realtek snd_hda_codec_hdmi
snd_hda_codec_generic ledtrig_audio tuner_simple irqbypass tuner_types
snd_hda_intel tuner snd_intel_dspcfg msp3400 snd_intel_sdw_acpi
snd_hda_codec bttv snd_hda_core snd_bt87x snd_hwdep tveeprom tea575x
snd_seq snd_seq_device videobuf_dma_sg videobuf_core snd_pcm videodev
snd_timer parport_pc mc snd parport i2c_nforce2 soundcore acpi_cpufreq
k10temp fuse amdgpu iommu_v2 gpu_sched radeon firewire_ohci
drm_ttm_helper ata_generic pata_acpi ttm firewire_core serio_raw
drm_dp_helper sata_nv crc_itu_t forcedeth pata_amd
CPU: 3 PID: 6466 Comm: rvgl.64 Kdump: loaded Tainted: G           OE
  5.18.7-200.fc36.x86_64 #1
Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./ALiveNF6G-VSTA, BIOS L2.26 08/26/2009
RIP: 0010:native_queued_spin_lock_slowpath+0x64/0x1f0
Code: 70 f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4 09 d0
3d ff 00 00 00 77 4c 85 c0 74 0e 8b 03 84 c0 74 08 f3 90 8b 03 <84> c0
75 f8 b8 01 00 00 00 66 89 03 5b 5d 41 5c c3 cc 8b 37 b8 00
RSP: 0018:ffffbb9380eefc50 EFLAGS: 00000002
RAX: 0000000000000101 RBX: ffff9e506cfb8018 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9e506cfb8018
RBP: 0000000000000286 R08: 0000000000000000 R09: ffffbb9380eef998
R10: 000000000000002f R11: ffffffff9cf22c90 R12: ffff9e506cfb8018
R13: 0000000000000020 R14: ffffbb9380eefcd5 R15: 0000000000000000
FS:  00007f1348012c80(0000) GS:ffff9e517fd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2f25157008 CR3: 0000000142c46000 CR4: 00000000000006e0
Call Trace:
 <TASK>
 _raw_spin_lock_irqsave+0x41/0x50
 iforce_send_packet+0x31/0x180 [iforce]
 iforce_control_playback+0x4c/0x7c [iforce]
 make_core+0x1ef/0x200 [iforce]
 iforce_upload_constant+0x18b/0x300 [iforce]
 iforce_upload_effect+0x70/0x80 [iforce]
 input_ff_upload+0x1ba/0x2d0
 evdev_do_ioctl+0x646/0xac0
 evdev_ioctl+0x63/0x90
 __x64_sys_ioctl+0x8d/0xc0
 do_syscall_64+0x5b/0x80
 ? asm_sysvec_apic_timer_interrupt+0xa/0x20
 ? asm_sysvec_apic_timer_interrupt+0xa/0x20
 ? __irq_exit_rcu+0x3d/0x140
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f134770776f
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48
89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2
3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffd36151920 EFLAGS: 00200246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000cea3f80 RCX: 00007f134770776f
RDX: 00007ffd36151980 RSI: 0000000040304580 RDI: 0000000000000014
RBP: 00007ffd36151a00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000052 R11: 0000000000200246 R12: 0000000000000000
R13: 000000000d2797f0 R14: 0000000000000000 R15: 00007ffd36151980
 </TASK>
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:         0-...0: (0 ticks this GP) idle=b0f/1/0x4000000000000000
softirq=60606/60606 fqs=14898
rcu:         3-...0: (1 GPs behind) idle=0d9/1/0x4000000000000000
softirq=62802/62804 fqs=14898
        (detected by 2, t=60002 jiffies, g=117205, q=421)
Sending NMI from CPU 2 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 4353 Comm: xfce4-terminal Kdump: loaded Tainted: G
  OE     5.18.7-200.fc36.x86_64 #1
Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./ALiveNF6G-VSTA, BIOS L2.26 08/26/2009
RIP: 0010:native_queued_spin_lock_slowpath+0x64/0x1f0
Code: 70 f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4 09 d0
3d ff 00 00 00 77 4c 85 c0 74 0e 8b 03 84 c0 74 08 f3 90 8b 03 <84> c0
75 f8 b8 01 00 00 00 66 89 03 5b 5d 41 5c c3 cc 8b 37 b8 00
RSP: 0000:ffffbb9380db7cd8 EFLAGS: 00000002
RAX: 0000000000000101 RBX: ffffffff9dc7ebc0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff9dc7ebc0
RBP: 0000000000000086 R08: ffffffff9ce653a0 R09: 0000000000000002
R10: 0000000000000000 R11: ffffffff9da9b11f R12: ffffbb9380db7d64
R13: 0000000000000001 R14: ffff9e5047ba4000 R15: ffff9e50739a44f4
FS:  00007f0ad0d2ccc0(0000) GS:ffff9e517fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2f25167008 CR3: 000000012867e000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 _raw_spin_lock_irqsave+0x41/0x50
 uart_write+0x69/0x1e0
 serport_serio_write+0x2b/0x40 [serport]
 iforce_serio_xmit+0xa8/0x1a0 [iforce_serio]
 serport_ldisc_write_wakeup+0x59/0x70 [serport]
 tty_wakeup+0x53/0x60
 tty_port_default_wakeup+0x1b/0x30
 serial8250_tx_chars+0x12d/0x230
 serial8250_handle_irq.part.0+0x12b/0x180
 serial8250_default_handle_irq+0x47/0x80
 serial8250_interrupt+0x62/0xf0
 __handle_irq_event_percpu+0x46/0x180
 handle_irq_event+0x34/0x70
 handle_edge_irq+0x9f/0x240
 __common_interrupt+0x66/0x100
 common_interrupt+0x5c/0xd0
 ? asm_common_interrupt+0x8/0x40
 asm_common_interrupt+0x1e/0x40
RIP: 0033:0x7f0ad4b499c0
Code: 66 2e 0f 1f 84 00 00 00 00 00 8d 40 ff 83 f8 2a 77 cf 31 c0 f0
0f b1 6b 1c eb c6 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 <f3> 0f
1e fa 8b 47 1c 85 c0 75 41 f6 47 30 02 75 2f 48 8b 17 48 8b
RSP: 002b:00007fff84201958 EFLAGS: 00000246
RAX: 000055eb1375e800 RBX: 000055eb13506f50 RCX: 0000000000000001
RDX: 00007fff84201928 RSI: 000055eb1375e800 RDI: 000055eb1375e800
RBP: 000055eb13506830 R08: 0000000000000000 R09: 000000000000000d
R10: 0000000000000000 R11: 0000000000000000 R12: 000055eb138fad70
R13: 00007f0ad5419ee0 R14: 0000000000000000 R15: 000055eb138fad70
 </TASK>
Sending NMI from CPU 2 to CPUs 3:
NMI backtrace for cpu 3
CPU: 3 PID: 6466 Comm: rvgl.64 Kdump: loaded Tainted: G           OE
  5.18.7-200.fc36.x86_64 #1
Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./ALiveNF6G-VSTA, BIOS L2.26 08/26/2009
RIP: 0010:native_queued_spin_lock_slowpath+0x64/0x1f0
Code: 70 f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4 09 d0
3d ff 00 00 00 77 4c 85 c0 74 0e 8b 03 84 c0 74 08 f3 90 8b 03 <84> c0
75 f8 b8 01 00 00 00 66 89 03 5b 5d 41 5c c3 cc 8b 37 b8 00
RSP: 0018:ffffbb9380eefc50 EFLAGS: 00000002
RAX: 0000000000000101 RBX: ffff9e506cfb8018 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9e506cfb8018
RBP: 0000000000000286 R08: 0000000000000000 R09: ffffbb9380eef998
R10: 000000000000002f R11: ffffffff9cf22c90 R12: ffff9e506cfb8018
R13: 0000000000000020 R14: ffffbb9380eefcd5 R15: 0000000000000000
FS:  00007f1348012c80(0000) GS:ffff9e517fd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2f25157008 CR3: 0000000142c46000 CR4: 00000000000006e0
Call Trace:
 <TASK>
 _raw_spin_lock_irqsave+0x41/0x50
 iforce_send_packet+0x31/0x180 [iforce]
 iforce_control_playback+0x4c/0x7c [iforce]
 make_core+0x1ef/0x200 [iforce]
 iforce_upload_constant+0x18b/0x300 [iforce]
 iforce_upload_effect+0x70/0x80 [iforce]
 input_ff_upload+0x1ba/0x2d0
 evdev_do_ioctl+0x646/0xac0
 evdev_ioctl+0x63/0x90
 __x64_sys_ioctl+0x8d/0xc0
 do_syscall_64+0x5b/0x80
 ? asm_sysvec_apic_timer_interrupt+0xa/0x20
 ? asm_sysvec_apic_timer_interrupt+0xa/0x20
 ? __irq_exit_rcu+0x3d/0x140
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f134770776f
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48
89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2
3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffd36151920 EFLAGS: 00200246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000cea3f80 RCX: 00007f134770776f
RDX: 00007ffd36151980 RSI: 0000000040304580 RDI: 0000000000000014
RBP: 00007ffd36151a00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000052 R11: 0000000000200246 R12: 0000000000000000
R13: 000000000d2797f0 R14: 0000000000000000 R15: 00007ffd36151980
 </TASK>
