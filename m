Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61ABC56FE4C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiGKKKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiGKKJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:09:11 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6AA747B0;
        Mon, 11 Jul 2022 02:32:12 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id n12-20020a9d64cc000000b00616ebd87fc4so3624067otl.7;
        Mon, 11 Jul 2022 02:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=c08pgCLInhN4Umov1byC5uUGIuGBTZaxP8TdsEIlMMc=;
        b=BQ3S8BbHUn4BtF4hDZyK0o0aiDdulcsQqEq/MfmJ2IaRll9Ve8b/OALxM+1MnwVFxh
         LLkzB10xDsnDe4XiIUgKhGCyOL7Pn5G6FdN1hG9yINFygUM6dOeoe7JDWyzXuh3WmOQ7
         ItMR2nrfQ2YaSZgMh3Yab1QRD7otZZn8wMiUck1hGtwI7VbV7pP1+rL6ThS/wTfJ70cL
         w0iFtnzi/GT5e2Afbvfsx5OcGJu2rVFdV4UQr15F/YntkXgUw3faPrigfSeb507/6MrR
         8BlWrbaGB3jg31xoPBddu2oTWcphUNR1bBpSbCCaTCF+GMVuKexu//eK7wSWRaw08BR9
         5Mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=c08pgCLInhN4Umov1byC5uUGIuGBTZaxP8TdsEIlMMc=;
        b=D7b9xeo/efwN+Mp7HOk5EPsersJoUeJvmDkmDkaJHvz20F1bl9T+6uoqYPcqaRbJ1p
         EzvG+IcMDDKStNOzJjbPfgafA+BFuxQsKln2dMi9uCnZqvhrqfJhiMv0wTZI8Sjsgm3C
         l0R6VyMYClkeegDfX10pxCjp8yQ8QmgRZSH8agTCM+q6GlZDSN9R9tpPRu05xwZjTERr
         ct1EYkcYjQeg2tL12ik4bk3gqcjXGLRHoVX1+H2U2Hh3imjQQS+e2ba/nQPV2e9YT53g
         U/eQli9LaOEu92G5UawGINbh9WDakB7cUU3uJoodP/Q1lCJNONDPs4Ed2ETwiQ1PEzR1
         VRUg==
X-Gm-Message-State: AJIora+/UvJEccogSFu3UHCXEv9Mj74ZTmQUHCOudRtn3nG92xd4yGKr
        WfihwD+Vtxsw4Sve+A30TES6i2Mn1DNYctN2Ncs=
X-Google-Smtp-Source: AGRyM1tVRJgcqbGgzoaiF+jXUdx4TzOK67DnPoB7b4kMMGwSgecr95Tn3ZN6zo6iJHXRkCWSdGcMtFw3xgSRl05QS1I=
X-Received: by 2002:a05:6830:4489:b0:61c:55ca:ecf3 with SMTP id
 r9-20020a056830448900b0061c55caecf3mr227101otv.198.1657531931525; Mon, 11 Jul
 2022 02:32:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4c8b:0:0:0:0:0 with HTTP; Mon, 11 Jul 2022 02:32:11
 -0700 (PDT)
From:   Greg T <greg.iforce@gmail.com>
Date:   Mon, 11 Jul 2022 11:32:11 +0200
Message-ID: <CAKEH-64aeeKrgZmyVoWu8f=KCW_xBjBD_FJEdHpo8hhOTzYuxg@mail.gmail.com>
Subject: Re: |Question] iforce Boeder Force Feedback Wheel lockup
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

2022-07-04 4:19 GMT+02:00, Greg T <greg.iforce@gmail.com>:

>>> 4. Force feedback seems to work from fftest (at least some of the
>>> functions), but when using it in RVGL or VDrift, the system freezes

> NMI watchdog: Watchdog detected hard LOCKUP on cpu 0
> Modules linked in: joydev serport iforce_serio(OE) iforce(OE) rfkill
> xt_owner ipt_REJECT nf_reject_ipv4 xt_state xt_conntrack
> iptable_filter nf_conntrack_ftp xt_CT nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 iptable_raw ip_tables xt_LOG nf_log_syslog xt_limit
> w83627ehf ip6table_filter hwmon_vid ip6_tables lm90 ppdev edac_mce_amd
> kvm_amd ccp kvm snd_hda_codec_realtek snd_hda_codec_hdmi
> snd_hda_codec_generic ledtrig_audio tuner_simple irqbypass tuner_types
> snd_hda_intel tuner snd_intel_dspcfg msp3400 snd_intel_sdw_acpi
> snd_hda_codec bttv snd_hda_core snd_bt87x snd_hwdep tveeprom tea575x
> snd_seq snd_seq_device videobuf_dma_sg videobuf_core snd_pcm videodev
> snd_timer parport_pc mc snd parport i2c_nforce2 soundcore acpi_cpufreq
> k10temp fuse amdgpu iommu_v2 gpu_sched radeon firewire_ohci
> drm_ttm_helper ata_generic pata_acpi ttm firewire_core serio_raw
> drm_dp_helper sata_nv crc_itu_t forcedeth pata_amd
> CPU: 0 PID: 4353 Comm: xfce4-terminal Kdump: loaded Tainted: G
>   OE     5.18.7-200.fc36.x86_64 #1
> Hardware name: To Be Filled By O.E.M. To Be Filled By
> O.E.M./ALiveNF6G-VSTA, BIOS L2.26 08/26/2009
> RIP: 0010:native_queued_spin_lock_slowpath+0x62/0x1f0
> Code: 00 77 70 f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 08 30 e4
> 09 d0 3d ff 00 00 00 77 4c 85 c0 74 0e 8b 03 84 c0 74 08 f3 90 <8b> 03
> 84 c0 75 f8 b8 01 00 00 00 66 89 03 5b 5d 41 5c c3 cc 8b 37
> RSP: 0000:ffffbb9380db7cd8 EFLAGS: 00000002
> RAX: 0000000000000101 RBX: ffffffff9dc7ebc0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff9dc7ebc0
> RBP: 0000000000000086 R08: ffffffff9ce653a0 R09: 0000000000000002
> R10: 0000000000000000 R11: ffffffff9da9b11f R12: ffffbb9380db7d64
> R13: 0000000000000001 R14: ffff9e5047ba4000 R15: ffff9e50739a44f4
> FS:  00007f0ad0d2ccc0(0000) GS:ffff9e517fc00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2f25167008 CR3: 000000012867e000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  _raw_spin_lock_irqsave+0x41/0x50
>  uart_write+0x69/0x1e0
>  serport_serio_write+0x2b/0x40 [serport]
>  iforce_serio_xmit+0xa8/0x1a0 [iforce_serio]
>  serport_ldisc_write_wakeup+0x59/0x70 [serport]

".write_wakeup   = iforce_serio_write_wakeup," and function
iforce_serio_write_wakeup in iforce-serio.c seem unnecesarry as
iforce_serio_xmit is called from iforce_send_packet without these
anyway. But dropping these alone won't solve the lockups. There's also
some kind of deadlock caused by the input event processing:

PID: 1092   TASK: ffff991005f6cf00  CPU: 0   COMMAND: "Xorg"
 #0 [fffffe000000de60] crash_nmi_callback at ffffffff8e05b6b2
 #1 [fffffe000000de68] nmi_handle at ffffffff8e02ca3d
 #2 [fffffe000000deb0] default_do_nmi at ffffffff8ed32c39
 #3 [fffffe000000ded0] exc_nmi at ffffffff8ed32e77
 #4 [fffffe000000def0] end_repeat_nmi at ffffffff8ee0156b
    [exception RIP: native_queued_spin_lock_slowpath+98]
    RIP: ffffffff8e14a842  RSP: ffffba0d40c2fd70  RFLAGS: 00000002
    RAX: 0000000000000101  RBX: ffff99107b097b6c  RCX: 0000000000000000
    RDX: 0000000000000000  RSI: 0000000000000001  RDI: ffff99107b097b6c
    RBP: 0000000000000092   R8: ffff99100b092810   R9: ffff99113fcb1a40
    R10: 00000000000cc4ac  R11: 0000000000000000  R12: 000000000000000a
    R13: 0000000000000046  R14: 0000000000000000  R15: ffff99100f7d8514
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
--- <NMI exception stack> ---
 #5 [ffffba0d40c2fd70] native_queued_spin_lock_slowpath at ffffffff8e14a842
 #6 [ffffba0d40c2fd88] _raw_spin_lock_irqsave at ffffffff8ed45b21
 #7 [ffffba0d40c2fda0] serport_ldisc_write_wakeup at ffffffffc0fb20be [serport]
 #8 [ffffba0d40c2fdc0] tty_wakeup at ffffffff8e81a843
 #9 [ffffba0d40c2fdd8] tty_port_default_wakeup at ffffffff8e8255eb
#10 [ffffba0d40c2fde8] serial8250_tx_chars at ffffffff8e8432ed
#11 [ffffba0d40c2fe08] serial8250_handle_irq at ffffffff8e84351b
#12 [ffffba0d40c2fe30] serial8250_default_handle_irq at ffffffff8e8435d7
#13 [ffffba0d40c2fe50] serial8250_interrupt at ffffffff8e83f2b2
#14 [ffffba0d40c2fe90] __handle_irq_event_percpu at ffffffff8e158f86
#15 [ffffba0d40c2fec0] handle_irq_event at ffffffff8e159134
#16 [ffffba0d40c2fee0] handle_edge_irq at ffffffff8e15d3af
#17 [ffffba0d40c2ff00] __common_interrupt at ffffffff8e02af16
#18 [ffffba0d40c2ff28] common_interrupt at ffffffff8ed326ec
#19 [ffffba0d40c2ff50] asm_common_interrupt at ffffffff8ee00cde

PID: 343    TASK: ffff99100b092780  CPU: 1   COMMAND: "kworker/u8:5"
 #0 [fffffe0000048e60] crash_nmi_callback at ffffffff8e05b6b2
 #1 [fffffe0000048e68] nmi_handle at ffffffff8e02ca3d
 #2 [fffffe0000048eb0] default_do_nmi at ffffffff8ed32c39
 #3 [fffffe0000048ed0] exc_nmi at ffffffff8ed32e77
 #4 [fffffe0000048ef0] end_repeat_nmi at ffffffff8ee0156b
    [exception RIP: native_queued_spin_lock_slowpath+98]
    RIP: ffffffff8e14a842  RSP: ffffba0d406bfcf8  RFLAGS: 00000002
    RAX: 0000000000000101  RBX: ffff99105ff1d1f0  RCX: 0000000000000001
    RDX: 0000000000000000  RSI: 0000000000000001  RDI: ffff99105ff1d1f0
    RBP: 0000000000000097   R8: 00000000000000bd   R9: ffff991008b85434
    R10: 000000000000000f  R11: fefefefefefefeff  R12: 0000000000000007
    R13: ffff99105ff1d1f0  R14: 000000000000012f  R15: 0000000000000001
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
 #5 [ffffba0d406bfcf8] native_queued_spin_lock_slowpath at ffffffff8e14a842
 #6 [ffffba0d406bfd10] _raw_spin_lock_irqsave at ffffffff8ed45b21
 #7 [ffffba0d406bfd28] input_event at ffffffff8e9d5d69
 #8 [ffffba0d406bfd60] iforce_process_packet at ffffffffc0ff1c7e [iforce]
 #9 [ffffba0d406bfd90] iforce_serio_irq at ffffffffc0ffa44f [iforce_serio]
#10 [ffffba0d406bfda8] serio_interrupt at ffffffff8e9cf1c6
#11 [ffffba0d406bfdd8] serport_ldisc_receive at ffffffffc0fb218f [serport]
#12 [ffffba0d406bfe20] tty_ldisc_receive_buf at ffffffff8e8246bd
#13 [ffffba0d406bfe30] tty_port_default_receive_buf at ffffffff8e824f6d
#14 [ffffba0d406bfe58] flush_to_ldisc at ffffffff8e824b54
#15 [ffffba0d406bfe90] process_one_work at ffffffff8e102797
#16 [ffffba0d406bfed8] worker_thread at ffffffff8e10299d
#17 [ffffba0d406bff18] kthread at ffffffff8e10a0c9
#18 [ffffba0d406bff50] ret_from_fork at ffffffff8e001c12

PID: 4109   TASK: ffff991092b34f00  CPU: 3   COMMAND: "rvgl.64"
 #0 [fffffe00000bee60] crash_nmi_callback at ffffffff8e05b6b2
 #1 [fffffe00000bee68] nmi_handle at ffffffff8e02ca3d
 #2 [fffffe00000beeb0] default_do_nmi at ffffffff8ed32c39
 #3 [fffffe00000beed0] exc_nmi at ffffffff8ed32e77
 #4 [fffffe00000beef0] end_repeat_nmi at ffffffff8ee0156b
    [exception RIP: native_queued_spin_lock_slowpath+98]
    RIP: ffffffff8e14a842  RSP: ffffba0d4133bc50  RFLAGS: 00000002
    RAX: 0000000000000101  RBX: ffffffff90c7ebc0  RCX: 0000000000000000
    RDX: 0000000000000000  RSI: 0000000000000001  RDI: ffffffff90c7ebc0
    RBP: 0000000000000086   R8: 0000000000000003   R9: 0000000000000003
    R10: 0000000000000000  R11: 0000000000000001  R12: ffffba0d4133bcdc
    R13: 0000000000000001  R14: ffff991000c8c000  R15: ffffba0d4133bd65
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
 #5 [ffffba0d4133bc50] native_queued_spin_lock_slowpath at ffffffff8e14a842
 #6 [ffffba0d4133bc68] _raw_spin_lock_irqsave at ffffffff8ed45b21
 #7 [ffffba0d4133bc80] uart_write at ffffffff8e83e269
 #8 [ffffba0d4133bcd0] serport_serio_write at ffffffffc0fb202b [serport]
 #9 [ffffba0d4133bce0] iforce_serio_xmit at ffffffffc0ffa0a8 [iforce_serio]
#10 [ffffba0d4133bd18] iforce_send_packet at ffffffffc0ff1a15 [iforce]
#11 [ffffba0d4133bd58] iforce_control_playback at ffffffffc0ff1f2c [iforce]
#12 [ffffba0d4133bd80] iforce_playback at ffffffffc0ff1081 [iforce]
#13 [ffffba0d4133bd88] input_ff_event at ffffffff8e9d7e1e
#14 [ffffba0d4133bd90] input_handle_event at ffffffff8e9d5807
#15 [ffffba0d4133bdc0] input_inject_event at ffffffff8e9d5e36
#16 [ffffba0d4133be00] evdev_write at ffffffff8e9daab9
#17 [ffffba0d4133be58] vfs_write at ffffffff8e38c383
#18 [ffffba0d4133be88] ksys_write at ffffffff8e38c84c
#19 [ffffba0d4133beb8] do_syscall_64 at ffffffff8ed3113b
#20 [ffffba0d4133bf18] syscall_exit_to_user_mode at ffffffff8ed35dd7
#21 [ffffba0d4133bf28] do_syscall_64 at ffffffff8ed31147
#22 [ffffba0d4133bf50] entry_SYSCALL_64_after_hwframe at ffffffff8ee0007c

That problem vanishes if we don't call iforce_process_packet directly
from iforce_serio_irq, but from a tasklet. Is that a right approach.
If not, how should we fix it? If so, how to initialize and disable the
tasklet properly? From iforce_serio_connect and
iforce_serio_disconnect? The tasklet only gets an unsigned long
parameter, not a pointer to a struct like iforce_serio.
