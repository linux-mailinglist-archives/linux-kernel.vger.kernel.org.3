Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75605475946
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbhLOND5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:03:57 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.170]:50132 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237376AbhLONDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:03:55 -0500
X-KPN-MessageId: 520415e7-5da7-11ec-8a6e-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 520415e7-5da7-11ec-8a6e-005056ab378f;
        Wed, 15 Dec 2021 14:02:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:subject:to:from:mime-version:date:message-id;
        bh=1S1P2F30he77/E5UA5rfJsGwyX3JCoPUrTRTYijFTP8=;
        b=jPyK0423VuS16vqHe3Vwq92iPZGHG+JyON3E8+58l/pCn68aIRggR2933mSeLQAjEpJ3CuuRmRRUJ
         pEV1ge7f3iaNgsiHtytSN3BZ5e3RONxiNlMRayer98OxE0XZgQI2djEH+hFkhzXLEc21sCAbiLgunl
         5JK3GQoFMOYlbtYlObNAcE5KapAgvP0iB4oF2OH5lKzQr+CkG4uWIDc9kTT/ns9SPjxL/DTwK6WZSP
         W/S4AnFWBnTFCZtWT142o6bi0EiV8W9KjAzlPta/YM8M+EkJ+/8pcuj1LdiGN8OrDJy+7p/72yekg7
         nb1uYg6NayrT8LgxOIsXCq6C/+2dqJQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|3OWWOtZlYHnFfwjW+jZK+6GmLSnn768X8IY4CoGoB+qHOmvnTv2zSDqxMXTTmbl
 iApSN3p9/FJnVAcf9l4943Q==
X-Originating-IP: 82.161.210.87
Received: from [192.168.10.70] (pindarots.xs4all.nl [82.161.210.87])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 7375ee33-5da7-11ec-81f5-005056ab7447;
        Wed, 15 Dec 2021 14:03:52 +0100 (CET)
Message-ID: <1a3510cf-a8a9-458e-4d53-4cb81c86dd58@xs4all.nl>
Date:   Wed, 15 Dec 2021 14:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
From:   Udo van den Heuvel <udovdh@xs4all.nl>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <8d8d7c27-7a32-a85d-dd9a-38d800d76cab@xs4all.nl>
Organization: hierzo
Subject: Re: crash on 5.15.8
In-Reply-To: <8d8d7c27-7a32-a85d-dd9a-38d800d76cab@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

5.15.8 crashes more:

Dec 15 12:34:57 surfplank2 kernel: BUG: scheduling while atomic: 
skypeforlinux/19157/0x00000003
Dec 15 12:34:57 surfplank2 kernel: Modules linked in: snd_seq_dummy 
mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 
xt_u32 xt_multiport iptable_filter nf_conntrack_netbios_ns 
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag
_ipv4 ip6table_filter it87 msr hwmon_vid ip6_tables uvcvideo 
snd_hda_codec_realtek videobuf2_vmalloc videobuf2_memops snd_usb_audio 
snd_hda_codec_generic snd_hda_intel snd_hwdep videobuf2_v4l2 
snd_intel_dspcfg snd_usbmidi_lib snd_hda_codec videodev snd_hda_core 
cdc_acm videobuf2_common snd_rawmidi lzo_rle snd_seq lz
o_compress snd_seq_device snd_pcm snd_timer snd bfq i2c_piix4 evdev 
p_lkrg binfmt_misc fuse configfs zram zsmalloc ip_tables x_tables amdgpu 
aesni_intel drm_ttm_helper ttm gpu_sched sr_mod cdrom hid_generic usbhid 
i2c_dev autofs4
Dec 15 12:34:57 surfplank2 kernel: Preemption disabled at:
Dec 15 12:34:57 surfplank2 kernel: [<ffffffffb9029d4b>] 
optimized_callback+0x1b/0xf0
Dec 15 12:34:57 surfplank2 kernel: CPU: 15 PID: 19157 Comm: 
skypeforlinux Not tainted 5.15.8 #4
Dec 15 12:34:57 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 12:34:57 surfplank2 kernel: Call Trace:
Dec 15 12:34:57 surfplank2 kernel: <TASK>
Dec 15 12:34:57 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 12:34:57 surfplank2 kernel: ? optimized_callback+0x1b/0xf0
Dec 15 12:34:57 surfplank2 kernel: __schedule_bug.cold+0x7c/0x8a
Dec 15 12:34:57 surfplank2 kernel: __schedule+0x5ae/0x7a0
Dec 15 12:34:57 surfplank2 kernel: schedule+0x3e/0xe0
Dec 15 12:34:57 surfplank2 kernel: schedule_timeout+0xbb/0xf0
Dec 15 12:34:57 surfplank2 kernel: ? _raw_spin_lock_irqsave+0x14/0x40
Dec 15 12:34:57 surfplank2 kernel: wait_for_completion+0x84/0xe0
Dec 15 12:34:57 surfplank2 kernel: __flush_work.isra.0+0x15a/0x220
Dec 15 12:34:57 surfplank2 kernel: ? flush_workqueue_prep_pwqs+0x110/0x110
Dec 15 12:34:57 surfplank2 kernel: __drain_all_pages+0x15e/0x1b0
Dec 15 12:34:57 surfplank2 kernel: 
__alloc_pages_slowpath.constprop.0+0x2e1/0xab0
Dec 15 12:34:57 surfplank2 kernel: ? _raw_spin_unlock+0xd/0x20
Dec 15 12:34:57 surfplank2 kernel: ? rmqueue_bulk+0x21e/0x400
Dec 15 12:34:57 surfplank2 kernel: __alloc_pages+0x16c/0x1e0
Dec 15 12:34:57 surfplank2 kernel: cache_alloc_refill+0x23e/0x810
Dec 15 12:34:57 surfplank2 kernel: kmem_cache_alloc+0x105/0x120
Dec 15 12:34:57 surfplank2 kernel: p_dump_task_f+0x19/0xf0 [p_lkrg]
Dec 15 12:34:57 surfplank2 kernel: p_wake_up_new_task_entry+0x6b/0xe0 
[p_lkrg]
Dec 15 12:34:57 surfplank2 kernel: pre_handler_kretprobe+0x8a/0x160
Dec 15 12:34:57 surfplank2 kernel: opt_pre_handler+0x47/0x80
Dec 15 12:34:57 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 12:34:57 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 12:34:57 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 12:34:57 surfplank2 kernel: ? kernel_clone+0xd6/0x3a0
Dec 15 12:34:57 surfplank2 kernel: ? __handle_mm_fault+0xd9d/0x1150
Dec 15 12:34:57 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 12:34:57 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 12:34:57 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 12:34:57 surfplank2 kernel: ? syscall_exit_to_user_mode+0x1d/0x40
Dec 15 12:34:57 surfplank2 kernel: ? do_syscall_64+0x69/0x80
Dec 15 12:34:57 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 12:34:57 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 12:34:57 surfplank2 kernel: </TASK>
Dec 15 12:34:57 surfplank2 kernel: ------------[ cut here ]------------
Dec 15 12:34:57 surfplank2 kernel: DEBUG_LOCKS_WARN_ON(val > 
preempt_count())
Dec 15 12:34:57 surfplank2 kernel: WARNING: CPU: 0 PID: 19157 at 
kernel/sched/core.c:5431 preempt_count_sub+0x55/0x90
Dec 15 12:34:57 surfplank2 kernel: Modules linked in: snd_seq_dummy 
mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 
xt_u32 xt_multiport iptable_filter nf_conntrack_netbios_ns 
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter 
it87 msr hwmon_vid ip6_tables uvcvideo snd_hda_codec_realtek 
videobuf2_vmalloc videobuf2_memops snd_usb_audio snd_hda_codec_generic 
snd_hda_intel snd_hwdep videobuf2_v4l2 snd_intel_dspcfg snd_usbmidi_lib 
snd_hda_codec videodev snd_hda_core cdc_acm videobuf2_common snd_rawmidi 
lzo_rle snd_seq lzo_compress snd_seq_device snd_pcm snd_timer snd bfq 
i2c_piix4 evdev p_lkrg binfmt_misc fuse configfs zram zsmalloc ip_tables 
x_tables amdgpu aesni_intel drm_ttm_helper ttm gpu_sched sr_mod cdrom 
hid_generic usbhid i2c_dev autofs4
Dec 15 12:34:57 surfplank2 kernel: CPU: 0 PID: 19157 Comm: skypeforlinux 
Tainted: G        W         5.15.8 #4
Dec 15 12:34:57 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 12:34:57 surfplank2 kernel: RIP: 0010:preempt_count_sub+0x55/0x90
Dec 15 12:34:57 surfplank2 kernel: Code: 66 f8 46 c3 e8 1c 2e 27 00 85 
c0 74 f6 8b 15 4a 75 06 01 85 d2 75 ec 48 c7 c6 6c 82 e5 b9 48 c7 c7 d9 
3a e5 b9 e8 0e 9d 6c 00 <0f> 0b c3 84 c0 75 c9 e8 ef 2d 27 00 85 c0 74 
c9 8b 05 1d 75 06 01
Dec 15 12:34:57 surfplank2 kernel: RSP: 0018:fffface186f7fc78 EFLAGS: 
00010286
Dec 15 12:34:57 surfplank2 kernel: RAX: 0000000000000000 RBX: 
0000000000000ce0 RCX: 0000000000000000
Dec 15 12:34:57 surfplank2 kernel: RDX: 0000000000000001 RSI: 
ffffffffb9e77d5a RDI: 00000000ffffffff
Dec 15 12:34:57 surfplank2 kernel: RBP: ffffa129d4dfa000 R08: 
ffffa130be2b0ba8 R09: 00000000ffffdfff
Dec 15 12:34:57 surfplank2 kernel: R10: ffffa130bdd50000 R11: 
ffffa130bdd50000 R12: 000000000000952a
Dec 15 12:34:57 surfplank2 kernel: R13: 0000000000000212 R14: 
ffffffffc02bba20 R15: 0000000000000000
Dec 15 12:34:57 surfplank2 kernel: FS:  00007f6c3c24eb00(0000) 
GS:ffffa130bde00000(0000) knlGS:0000000000000000
Dec 15 12:34:57 surfplank2 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Dec 15 12:34:57 surfplank2 kernel: CR2: 00007f45090df370 CR3: 
0000000115b5e000 CR4: 0000000000750ef0
Dec 15 12:34:57 surfplank2 kernel: PKRU: 55555554
Dec 15 12:34:57 surfplank2 kernel: Call Trace:
Dec 15 12:34:57 surfplank2 kernel: <TASK>
Dec 15 12:34:57 surfplank2 kernel: _raw_write_unlock_irqrestore+0x16/0x30
Dec 15 12:34:57 surfplank2 kernel: p_wake_up_new_task_entry+0x8c/0xe0 
[p_lkrg]
Dec 15 12:34:57 surfplank2 kernel: pre_handler_kretprobe+0x8a/0x160
Dec 15 12:34:57 surfplank2 kernel: opt_pre_handler+0x47/0x80
Dec 15 12:34:57 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 12:34:57 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 12:34:57 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 12:34:57 surfplank2 kernel: ? kernel_clone+0xd6/0x3a0
Dec 15 12:34:57 surfplank2 kernel: ? __handle_mm_fault+0xd9d/0x1150
Dec 15 12:34:57 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 12:34:57 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 12:34:57 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 12:34:57 surfplank2 kernel: ? syscall_exit_to_user_mode+0x1d/0x40
Dec 15 12:34:57 surfplank2 kernel: ? do_syscall_64+0x69/0x80
Dec 15 12:34:57 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 12:34:57 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 12:34:57 surfplank2 kernel: </TASK>
Dec 15 12:34:57 surfplank2 kernel: ---[ end trace 08f892da89d90fc8 ]---
Dec 15 12:34:57 surfplank2 kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: skypeforlinux/19157
Dec 15 12:34:57 surfplank2 kernel: caller is opt_pre_handler+0x53/0x80
Dec 15 12:34:57 surfplank2 kernel: CPU: 0 PID: 19157 Comm: skypeforlinux 
Tainted: G        W         5.15.8 #4
Dec 15 12:34:57 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 12:34:57 surfplank2 kernel: Call Trace:
Dec 15 12:34:57 surfplank2 kernel: <TASK>
Dec 15 12:34:57 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 12:34:57 surfplank2 kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 12:34:57 surfplank2 kernel: opt_pre_handler+0x53/0x80
Dec 15 12:34:57 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 12:34:57 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 12:34:57 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 12:34:57 surfplank2 kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 12:34:57 surfplank2 kernel: ? __handle_mm_fault+0xd9d/0x1150
Dec 15 12:34:57 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 12:34:57 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 12:34:57 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 12:34:57 surfplank2 kernel: ? syscall_exit_to_user_mode+0x1d/0x40
Dec 15 12:34:57 surfplank2 kernel: ? do_syscall_64+0x69/0x80
Dec 15 12:34:57 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 12:34:57 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 12:34:57 surfplank2 kernel: </TASK>
Dec 15 12:34:57 surfplank2 kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: skypeforlinux/19157
Dec 15 12:34:57 surfplank2 kernel: caller is optimized_callback+0xc6/0xf0
Dec 15 12:34:57 surfplank2 kernel: CPU: 0 PID: 19157 Comm: skypeforlinux 
Tainted: G        W         5.15.8 #4
Dec 15 12:34:57 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 12:34:57 surfplank2 kernel: Call Trace:
Dec 15 12:34:57 surfplank2 kernel: <TASK>
Dec 15 12:34:57 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 12:34:57 surfplank2 kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 12:34:57 surfplank2 kernel: optimized_callback+0xc6/0xf0
Dec 15 12:34:57 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 12:34:57 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 12:34:57 surfplank2 kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 12:34:57 surfplank2 kernel: ? __handle_mm_fault+0xd9d/0x1150
Dec 15 12:34:57 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 12:34:57 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 12:34:57 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 12:34:57 surfplank2 kernel: ? syscall_exit_to_user_mode+0x1d/0x40
Dec 15 12:34:57 surfplank2 kernel: ? do_syscall_64+0x69/0x80
Dec 15 12:34:57 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 12:34:57 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 12:34:57 surfplank2 kernel: </TASK>
Dec 15 12:35:00 surfplank2 kernel: BUG: scheduling while atomic: 
sh/38198/0x00000003
Dec 15 12:35:00 surfplank2 kernel: Modules linked in: snd_seq_dummy 
mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 
xt_u32 xt_multiport iptable_filter nf_conntrack_netbios_ns 
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter 
it87 msr hwmon_vid ip6_tables uvcvideo snd_hda_codec_realtek 
videobuf2_vmalloc videobuf2_memops snd_usb_audio snd_hda_codec_generic 
snd_hda_intel snd_hwdep videobuf2_v4l2 snd_intel_dspcfg snd_usbmidi_lib 
snd_hda_codec videodev snd_hda_core cdc_acm videobuf2_common snd_rawmidi 
lzo_rle snd_seq lzo_compress snd_seq_device snd_pcm snd_timer snd bfq 
i2c_piix4 evdev p_lkrg binfmt_misc fuse configfs zram zsmalloc ip_tables 
x_tables amdgpu aesni_intel drm_ttm_helper ttm gpu_sched sr_mod cdrom 
hid_generic usbhid i2c_dev autofs4
Dec 15 12:35:00 surfplank2 kernel: Preemption disabled at:
Dec 15 12:35:00 surfplank2 kernel: [<ffffffffb9029d4b>] 
optimized_callback+0x1b/0xf0
Dec 15 12:35:00 surfplank2 kernel: CPU: 0 PID: 38198 Comm: sh Tainted: G 
        W         5.15.8 #4
Dec 15 12:35:00 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 12:35:00 surfplank2 kernel: Call Trace:
Dec 15 12:35:00 surfplank2 kernel: <TASK>
Dec 15 12:35:00 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 12:35:00 surfplank2 kernel: ? optimized_callback+0x1b/0xf0
Dec 15 12:35:00 surfplank2 kernel: __schedule_bug.cold+0x7c/0x8a
Dec 15 12:35:00 surfplank2 kernel: __schedule+0x5ae/0x7a0
Dec 15 12:35:00 surfplank2 kernel: schedule+0x3e/0xe0
Dec 15 12:35:00 surfplank2 kernel: schedule_timeout+0xbb/0xf0
Dec 15 12:35:00 surfplank2 kernel: ? _raw_spin_lock_irqsave+0x14/0x40
Dec 15 12:35:00 surfplank2 kernel: wait_for_completion+0x84/0xe0
Dec 15 12:35:00 surfplank2 kernel: __flush_work.isra.0+0x15a/0x220
Dec 15 12:35:00 surfplank2 kernel: ? flush_workqueue_prep_pwqs+0x110/0x110
Dec 15 12:35:00 surfplank2 kernel: __drain_all_pages+0x15e/0x1b0
Dec 15 12:35:00 surfplank2 kernel: 
__alloc_pages_slowpath.constprop.0+0x2e1/0xab0
Dec 15 12:35:00 surfplank2 kernel: __alloc_pages+0x16c/0x1e0
Dec 15 12:35:00 surfplank2 kernel: cache_alloc_refill+0x23e/0x810
Dec 15 12:35:00 surfplank2 kernel: kmem_cache_alloc+0x105/0x120
Dec 15 12:35:00 surfplank2 kernel: p_dump_task_f+0x19/0xf0 [p_lkrg]
Dec 15 12:35:00 surfplank2 kernel: p_wake_up_new_task_entry+0x6b/0xe0 
[p_lkrg]
Dec 15 12:35:00 surfplank2 kernel: pre_handler_kretprobe+0x8a/0x160
Dec 15 12:35:00 surfplank2 kernel: opt_pre_handler+0x47/0x80
Dec 15 12:35:00 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 12:35:00 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 12:35:00 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 12:35:00 surfplank2 kernel: ? kernel_clone+0xd6/0x3a0
Dec 15 12:35:00 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 12:35:00 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 12:35:00 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 12:35:00 surfplank2 kernel: ? do_syscall_64+0x69/0x80
Dec 15 12:35:00 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 12:35:00 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 12:35:00 surfplank2 kernel: </TASK>
Dec 15 12:35:00 surfplank2 kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: sh/38198
Dec 15 12:35:00 surfplank2 kernel: caller is opt_pre_handler+0x53/0x80
Dec 15 12:35:00 surfplank2 kernel: CPU: 0 PID: 38198 Comm: sh Tainted: G 
        W         5.15.8 #4
Dec 15 12:35:00 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 12:35:00 surfplank2 kernel: Call Trace:
Dec 15 12:35:00 surfplank2 kernel: <TASK>
Dec 15 12:35:00 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 12:35:00 surfplank2 kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 12:35:00 surfplank2 kernel: opt_pre_handler+0x53/0x80
Dec 15 12:35:00 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 12:35:00 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 12:35:00 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 12:35:00 surfplank2 kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 12:35:00 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 12:35:00 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 12:35:00 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 12:35:00 surfplank2 kernel: ? do_syscall_64+0x69/0x80
Dec 15 12:35:00 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 12:35:00 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 12:35:00 surfplank2 kernel: </TASK>
Dec 15 12:35:00 surfplank2 kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: sh/38198
Dec 15 12:35:00 surfplank2 kernel: caller is optimized_callback+0xc6/0xf0
Dec 15 12:35:00 surfplank2 kernel: CPU: 0 PID: 38198 Comm: sh Tainted: G 
        W         5.15.8 #4
Dec 15 12:35:00 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 12:35:00 surfplank2 kernel: Call Trace:
Dec 15 12:35:00 surfplank2 kernel: <TASK>
Dec 15 12:35:00 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 12:35:00 surfplank2 kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 12:35:00 surfplank2 kernel: optimized_callback+0xc6/0xf0
Dec 15 12:35:00 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 12:35:00 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 12:35:00 surfplank2 kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 12:35:00 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 12:35:00 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 12:35:00 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 12:35:00 surfplank2 kernel: ? do_syscall_64+0x69/0x80
Dec 15 12:35:00 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 12:35:00 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 12:35:00 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: BUG: scheduling while atomic: Web 
Content/42095/0x00000003
Dec 15 13:08:23 surfplank2 kernel: Modules linked in: snd_seq_dummy 
mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 
xt_u32 xt_multiport iptable_filter nf_conntrack_netbios_ns 
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter 
it87 msr hwmon_vid ip6_tables uvcvideo snd_hda_codec_realtek 
videobuf2_vmalloc videobuf2_memops snd_usb_audio snd_hda_codec_generic 
snd_hda_intel snd_hwdep videobuf2_v4l2 snd_intel_dspcfg snd_usbmidi_lib 
snd_hda_codec videodev snd_hda_core cdc_acm videobuf2_common snd_rawmidi 
lzo_rle snd_seq lzo_compress snd_seq_device snd_pcm snd_timer snd bfq 
i2c_piix4 evdev p_lkrg binfmt_misc fuse configfs zram zsmalloc ip_tables 
x_tables amdgpu aesni_intel drm_ttm_helper ttm gpu_sched sr_mod cdrom 
hid_generic usbhid i2c_dev autofs4
Dec 15 13:08:23 surfplank2 kernel: Preemption disabled at:
Dec 15 13:08:23 surfplank2 kernel: [<ffffffffb9029d4b>] 
optimized_callback+0x1b/0xf0
Dec 15 13:08:23 surfplank2 kernel: CPU: 10 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: ? optimized_callback+0x1b/0xf0
Dec 15 13:08:23 surfplank2 kernel: __schedule_bug.cold+0x7c/0x8a
Dec 15 13:08:23 surfplank2 kernel: __schedule+0x5ae/0x7a0
Dec 15 13:08:23 surfplank2 kernel: schedule+0x3e/0xe0
Dec 15 13:08:23 surfplank2 kernel: schedule_timeout+0xbb/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? _raw_spin_lock_irqsave+0x14/0x40
Dec 15 13:08:23 surfplank2 kernel: wait_for_completion+0x84/0xe0
Dec 15 13:08:23 surfplank2 kernel: __flush_work.isra.0+0x15a/0x220
Dec 15 13:08:23 surfplank2 kernel: ? flush_workqueue_prep_pwqs+0x110/0x110
Dec 15 13:08:23 surfplank2 kernel: __drain_all_pages+0x15e/0x1b0
Dec 15 13:08:23 surfplank2 kernel: 
__alloc_pages_slowpath.constprop.0+0x2e1/0xab0
Dec 15 13:08:23 surfplank2 kernel: __alloc_pages+0x16c/0x1e0
Dec 15 13:08:23 surfplank2 kernel: cache_alloc_refill+0x23e/0x810
Dec 15 13:08:23 surfplank2 kernel: kmem_cache_alloc+0x105/0x120
Dec 15 13:08:23 surfplank2 kernel: p_dump_task_f+0x19/0xf0 [p_lkrg]
Dec 15 13:08:23 surfplank2 kernel: p_wake_up_new_task_entry+0x6b/0xe0 
[p_lkrg]
Dec 15 13:08:23 surfplank2 kernel: pre_handler_kretprobe+0x8a/0x160
Dec 15 13:08:23 surfplank2 kernel: opt_pre_handler+0x47/0x80
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? kernel_clone+0xd6/0x3a0
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: check_preemption_disabled: 1 
callbacks suppressed
Dec 15 13:08:23 surfplank2 kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: Web Content/42095
Dec 15 13:08:23 surfplank2 kernel: caller is opt_pre_handler+0x53/0x80
Dec 15 13:08:23 surfplank2 kernel: CPU: 10 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 13:08:23 surfplank2 kernel: opt_pre_handler+0x53/0x80
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: Web Content/42095
Dec 15 13:08:23 surfplank2 kernel: caller is optimized_callback+0xc6/0xf0
Dec 15 13:08:23 surfplank2 kernel: CPU: 10 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xc6/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: BUG: scheduling while atomic: Web 
Content/42095/0x00000003
Dec 15 13:08:23 surfplank2 kernel: Modules linked in: snd_seq_dummy 
mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 
xt_u32 xt_multiport iptable_filter nf_conntrack_netbios_ns 
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter 
it87 msr hwmon_vid ip6_tables uvcvideo snd_hda_codec_realtek 
videobuf2_vmalloc videobuf2_memops snd_usb_audio snd_hda_codec_generic 
snd_hda_intel snd_hwdep videobuf2_v4l2 snd_intel_dspcfg snd_usbmidi_lib 
snd_hda_codec videodev snd_hda_core cdc_acm videobuf2_common snd_rawmidi 
lzo_rle snd_seq lzo_compress snd_seq_device snd_pcm snd_timer snd bfq 
i2c_piix4 evdev p_lkrg binfmt_misc fuse configfs zram zsmalloc ip_tables 
x_tables amdgpu aesni_intel drm_ttm_helper ttm gpu_sched sr_mod cdrom 
hid_generic usbhid i2c_dev autofs4
Dec 15 13:08:23 surfplank2 kernel: Preemption disabled at:
Dec 15 13:08:23 surfplank2 kernel: [<ffffffffb9029d4b>] 
optimized_callback+0x1b/0xf0
Dec 15 13:08:23 surfplank2 kernel: CPU: 2 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: ? optimized_callback+0x1b/0xf0
Dec 15 13:08:23 surfplank2 kernel: __schedule_bug.cold+0x7c/0x8a
Dec 15 13:08:23 surfplank2 kernel: __schedule+0x5ae/0x7a0
Dec 15 13:08:23 surfplank2 kernel: schedule+0x3e/0xe0
Dec 15 13:08:23 surfplank2 kernel: schedule_timeout+0xbb/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? _raw_spin_lock_irqsave+0x14/0x40
Dec 15 13:08:23 surfplank2 kernel: wait_for_completion+0x84/0xe0
Dec 15 13:08:23 surfplank2 kernel: __flush_work.isra.0+0x15a/0x220
Dec 15 13:08:23 surfplank2 kernel: ? flush_workqueue_prep_pwqs+0x110/0x110
Dec 15 13:08:23 surfplank2 kernel: __drain_all_pages+0x15e/0x1b0
Dec 15 13:08:23 surfplank2 kernel: 
__alloc_pages_slowpath.constprop.0+0x2e1/0xab0
Dec 15 13:08:23 surfplank2 kernel: ? vm_area_dup+0x7a/0xb0
Dec 15 13:08:23 surfplank2 kernel: __alloc_pages+0x16c/0x1e0
Dec 15 13:08:23 surfplank2 kernel: cache_alloc_refill+0x23e/0x810
Dec 15 13:08:23 surfplank2 kernel: kmem_cache_alloc+0x105/0x120
Dec 15 13:08:23 surfplank2 kernel: p_dump_task_f+0x19/0xf0 [p_lkrg]
Dec 15 13:08:23 surfplank2 kernel: p_wake_up_new_task_entry+0x6b/0xe0 
[p_lkrg]
Dec 15 13:08:23 surfplank2 kernel: pre_handler_kretprobe+0x8a/0x160
Dec 15 13:08:23 surfplank2 kernel: opt_pre_handler+0x47/0x80
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? kernel_clone+0xd6/0x3a0
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: Web Content/42095
Dec 15 13:08:23 surfplank2 kernel: caller is opt_pre_handler+0x53/0x80
Dec 15 13:08:23 surfplank2 kernel: CPU: 2 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 13:08:23 surfplank2 kernel: opt_pre_handler+0x53/0x80
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: Web Content/42095
Dec 15 13:08:23 surfplank2 kernel: caller is optimized_callback+0xc6/0xf0
Dec 15 13:08:23 surfplank2 kernel: CPU: 2 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xc6/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: BUG: scheduling while atomic: Web 
Content/42095/0x00000003
Dec 15 13:08:23 surfplank2 kernel: Modules linked in: snd_seq_dummy 
mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 
xt_u32 xt_multiport iptable_filter nf_conntrack_netbios_ns 
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter 
it87 msr hwmon_vid ip6_tables uvcvideo snd_hda_codec_realtek 
videobuf2_vmalloc videobuf2_memops snd_usb_audio snd_hda_codec_generic 
snd_hda_intel snd_hwdep videobuf2_v4l2 snd_intel_dspcfg snd_usbmidi_lib 
snd_hda_codec videodev snd_hda_core cdc_acm videobuf2_common snd_rawmidi 
lzo_rle snd_seq lzo_compress snd_seq_device snd_pcm snd_timer snd bfq 
i2c_piix4 evdev p_lkrg binfmt_misc fuse configfs zram zsmalloc ip_tables 
x_tables amdgpu aesni_intel drm_ttm_helper ttm gpu_sched sr_mod cdrom 
hid_generic usbhid i2c_dev autofs4
Dec 15 13:08:23 surfplank2 kernel: Preemption disabled at:
Dec 15 13:08:23 surfplank2 kernel: [<ffffffffb9029d4b>] 
optimized_callback+0x1b/0xf0
Dec 15 13:08:23 surfplank2 kernel: CPU: 2 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: ? optimized_callback+0x1b/0xf0
Dec 15 13:08:23 surfplank2 kernel: __schedule_bug.cold+0x7c/0x8a
Dec 15 13:08:23 surfplank2 kernel: __schedule+0x5ae/0x7a0
Dec 15 13:08:23 surfplank2 kernel: schedule+0x3e/0xe0
Dec 15 13:08:23 surfplank2 kernel: schedule_timeout+0xbb/0xf0
Dec 15 13:08:23 surfplank2 kernel: wait_for_completion+0x84/0xe0
Dec 15 13:08:23 surfplank2 kernel: __flush_work.isra.0+0x15a/0x220
Dec 15 13:08:23 surfplank2 kernel: ? flush_workqueue_prep_pwqs+0x110/0x110
Dec 15 13:08:23 surfplank2 kernel: __drain_all_pages+0x15e/0x1b0
Dec 15 13:08:23 surfplank2 kernel: 
__alloc_pages_slowpath.constprop.0+0x2e1/0xab0
Dec 15 13:08:23 surfplank2 kernel: __alloc_pages+0x16c/0x1e0
Dec 15 13:08:23 surfplank2 kernel: cache_alloc_refill+0x23e/0x810
Dec 15 13:08:23 surfplank2 kernel: ? idr_get_free+0x21b/0x2d0
Dec 15 13:08:23 surfplank2 kernel: kmem_cache_alloc+0x105/0x120
Dec 15 13:08:23 surfplank2 kernel: p_dump_task_f+0x19/0xf0 [p_lkrg]
Dec 15 13:08:23 surfplank2 kernel: p_wake_up_new_task_entry+0x6b/0xe0 
[p_lkrg]
Dec 15 13:08:23 surfplank2 kernel: pre_handler_kretprobe+0x8a/0x160
Dec 15 13:08:23 surfplank2 kernel: opt_pre_handler+0x47/0x80
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? kernel_clone+0xd6/0x3a0
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: Web Content: page allocation failure: 
order:7, mode:0x40cc0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
Dec 15 13:08:23 surfplank2 kernel: CPU: 2 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: warn_alloc.cold+0x6f/0xd3
Dec 15 13:08:23 surfplank2 kernel: ? 
__alloc_pages_direct_compact+0x114/0x1b0
Dec 15 13:08:23 surfplank2 kernel: 
__alloc_pages_slowpath.constprop.0+0x71b/0xab0
Dec 15 13:08:23 surfplank2 kernel: __alloc_pages+0x16c/0x1e0
Dec 15 13:08:23 surfplank2 kernel: cache_alloc_refill+0x23e/0x810
Dec 15 13:08:23 surfplank2 kernel: ? idr_get_free+0x21b/0x2d0
Dec 15 13:08:23 surfplank2 kernel: kmem_cache_alloc+0x105/0x120
Dec 15 13:08:23 surfplank2 kernel: p_dump_task_f+0x19/0xf0 [p_lkrg]
Dec 15 13:08:23 surfplank2 kernel: p_wake_up_new_task_entry+0x6b/0xe0 
[p_lkrg]
Dec 15 13:08:23 surfplank2 kernel: pre_handler_kretprobe+0x8a/0x160
Dec 15 13:08:23 surfplank2 kernel: opt_pre_handler+0x47/0x80
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? kernel_clone+0xd6/0x3a0
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: Mem-Info:
Dec 15 13:08:23 surfplank2 kernel: active_anon:8736 
inactive_anon:1702594 isolated_anon:0#012 active_file:841555 
inactive_file:4400633 isolated_file:0#012 unevictable:6166 dirty:100718 
writeback:0#012 slab_reclaimable:199976 slab_unreclaimable:334116#012 
mapped:319039 shmem:173407 pagetables:17064 bounce:0#012 
kernel_misc_reclaimable:0#012 free:215692 free_pcp:335 free_cma:0
Dec 15 13:08:23 surfplank2 kernel: Node 0 active_anon:34944kB 
inactive_anon:6810376kB active_file:3366220kB inactive_file:17602532kB 
unevictable:24664kB isolated(anon):0kB isolated(file):0kB 
mapped:1276156kB dirty:402872kB writeback:0kB shmem:693628kB shmem_thp: 
0kB shmem_pmdmapped: 0kB anon_thp: 2093056kB writeback_tmp:0kB 
kernel_stack:37164kB pagetables:68256kB all_unreclaimable? no
Dec 15 13:08:23 surfplank2 kernel: DMA free:15360kB min:32kB low:44kB 
high:56kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB 
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB 
present:15984kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB 
local_pcp:0kB free_cma:0kB
Dec 15 13:08:23 surfplank2 kernel: lowmem_reserve[]: 0 2337 31487 31487
Dec 15 13:08:23 surfplank2 kernel: DMA32 free:121948kB min:5012kB 
low:7404kB high:9796kB reserved_highatomic:0KB active_anon:508kB 
inactive_anon:304464kB active_file:30344kB inactive_file:1619084kB 
unevictable:0kB writepending:25984kB present:2502164kB managed:2502164kB 
mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
Dec 15 13:08:23 surfplank2 kernel: lowmem_reserve[]: 0 0 29150 29150
Dec 15 13:08:23 surfplank2 kernel: Normal free:725460kB min:62536kB 
low:92384kB high:122232kB reserved_highatomic:2048KB active_anon:34324kB 
inactive_anon:6506584kB active_file:3335904kB inactive_file:15982780kB 
unevictable:24664kB writepending:376816kB present:30379008kB 
managed:29854884kB mlocked:24664kB bounce:0kB free_pcp:1268kB 
local_pcp:0kB free_cma:0kB
Dec 15 13:08:23 surfplank2 kernel: lowmem_reserve[]: 0 0 0 0
Dec 15 13:08:23 surfplank2 kernel: DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Dec 15 13:08:23 surfplank2 kernel: DMA32: 737*4kB (UME) 182*8kB (UM) 
570*16kB (UME) 257*32kB (UME) 72*64kB (UME) 54*128kB (UM) 41*256kB (UM) 
28*512kB (UM) 27*1024kB (U) 14*2048kB (U) 2*4096kB (M) = 122612kB
Dec 15 13:08:23 surfplank2 kernel: Normal: 70574*4kB (UMEH) 20443*8kB 
(UMEH) 7019*16kB (UMEH) 2397*32kB (UMEH) 775*64kB (UMEH) 179*128kB 
(UMEH) 79*256kB (UMH) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 727584kB
Dec 15 13:08:23 surfplank2 kernel: Node 0 hugepages_total=0 
hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Dec 15 13:08:23 surfplank2 kernel: 5419598 total pagecache pages
Dec 15 13:08:23 surfplank2 kernel: 0 pages in swap cache
Dec 15 13:08:23 surfplank2 kernel: Swap cache stats: add 3330, delete 
3330, find 0/0
Dec 15 13:08:23 surfplank2 kernel: Free swap  = 18859000kB
Dec 15 13:08:23 surfplank2 kernel: Total swap = 18874360kB
Dec 15 13:08:23 surfplank2 kernel: 8224289 pages RAM
Dec 15 13:08:23 surfplank2 kernel: 0 pages HighMem/MovableOnly
Dec 15 13:08:23 surfplank2 kernel: 131187 pages reserved
Dec 15 13:08:23 surfplank2 kernel: [p_lkrg] p_alloc_ed_pids() returned 
NULL for pid 42112 :(
Dec 15 13:08:23 surfplank2 kernel: [p_lkrg] <Exploit Detection> 
Error[-1] when trying to add process[42112 |Web Content] for tracking!
Dec 15 13:08:23 surfplank2 kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: Web Content/42095
Dec 15 13:08:23 surfplank2 kernel: caller is opt_pre_handler+0x53/0x80
Dec 15 13:08:23 surfplank2 kernel: CPU: 2 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 13:08:23 surfplank2 kernel: opt_pre_handler+0x53/0x80
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: Web Content/42095
Dec 15 13:08:23 surfplank2 kernel: caller is optimized_callback+0xc6/0xf0
Dec 15 13:08:23 surfplank2 kernel: CPU: 2 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xc6/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: BUG: scheduling while atomic: Web 
Content/42095/0x00000003
Dec 15 13:08:23 surfplank2 kernel: Modules linked in: snd_seq_dummy 
mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 
xt_u32 xt_multiport iptable_filter nf_conntrack_netbios_ns 
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter 
it87 msr hwmon_vid ip6_tables uvcvideo snd_hda_codec_realtek 
videobuf2_vmalloc videobuf2_memops snd_usb_audio snd_hda_codec_generic 
snd_hda_intel snd_hwdep videobuf2_v4l2 snd_intel_dspcfg snd_usbmidi_lib 
snd_hda_codec videodev snd_hda_core cdc_acm videobuf2_common snd_rawmidi 
lzo_rle snd_seq lzo_compress snd_seq_device snd_pcm snd_timer snd bfq 
i2c_piix4 evdev p_lkrg binfmt_misc fuse configfs zram zsmalloc ip_tables 
x_tables amdgpu aesni_intel drm_ttm_helper ttm gpu_sched sr_mod cdrom 
hid_generic usbhid i2c_dev autofs4
Dec 15 13:08:23 surfplank2 kernel: Preemption disabled at:
Dec 15 13:08:23 surfplank2 kernel: [<ffffffffb9029d4b>] 
optimized_callback+0x1b/0xf0
Dec 15 13:08:23 surfplank2 kernel: CPU: 2 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: ? optimized_callback+0x1b/0xf0
Dec 15 13:08:23 surfplank2 kernel: __schedule_bug.cold+0x7c/0x8a
Dec 15 13:08:23 surfplank2 kernel: __schedule+0x5ae/0x7a0
Dec 15 13:08:23 surfplank2 kernel: schedule+0x3e/0xe0
Dec 15 13:08:23 surfplank2 kernel: schedule_timeout+0xbb/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? _raw_spin_lock_irqsave+0x14/0x40
Dec 15 13:08:23 surfplank2 kernel: wait_for_completion+0x84/0xe0
Dec 15 13:08:23 surfplank2 kernel: __flush_work.isra.0+0x15a/0x220
Dec 15 13:08:23 surfplank2 kernel: ? flush_workqueue_prep_pwqs+0x110/0x110
Dec 15 13:08:23 surfplank2 kernel: __drain_all_pages+0x15e/0x1b0
Dec 15 13:08:23 surfplank2 kernel: 
__alloc_pages_slowpath.constprop.0+0x2e1/0xab0
Dec 15 13:08:23 surfplank2 kernel: __alloc_pages+0x16c/0x1e0
Dec 15 13:08:23 surfplank2 kernel: cache_alloc_refill+0x23e/0x810
Dec 15 13:08:23 surfplank2 kernel: kmem_cache_alloc+0x105/0x120
Dec 15 13:08:23 surfplank2 kernel: p_dump_task_f+0x19/0xf0 [p_lkrg]
Dec 15 13:08:23 surfplank2 kernel: p_wake_up_new_task_entry+0x6b/0xe0 
[p_lkrg]
Dec 15 13:08:23 surfplank2 kernel: pre_handler_kretprobe+0x8a/0x160
Dec 15 13:08:23 surfplank2 kernel: opt_pre_handler+0x47/0x80
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? kernel_clone+0xd6/0x3a0
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? handle_mm_fault+0x67/0x1a0
Dec 15 13:08:23 surfplank2 kernel: ? do_user_addr_fault+0x1d4/0x5e0
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: [p_lkrg] p_alloc_ed_pids() returned 
NULL for pid 42113 :(
Dec 15 13:08:23 surfplank2 kernel: [p_lkrg] <Exploit Detection> 
Error[-1] when trying to add process[42113 |Web Content] for tracking!
Dec 15 13:08:23 surfplank2 kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: Web Content/42095
Dec 15 13:08:23 surfplank2 kernel: caller is opt_pre_handler+0x53/0x80
Dec 15 13:08:23 surfplank2 kernel: CPU: 10 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 13:08:23 surfplank2 kernel: opt_pre_handler+0x53/0x80
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? handle_mm_fault+0x67/0x1a0
Dec 15 13:08:23 surfplank2 kernel: ? do_user_addr_fault+0x1d4/0x5e0
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: Web Content/42095
Dec 15 13:08:23 surfplank2 kernel: caller is optimized_callback+0xc6/0xf0
Dec 15 13:08:23 surfplank2 kernel: CPU: 10 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xc6/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? handle_mm_fault+0x67/0x1a0
Dec 15 13:08:23 surfplank2 kernel: ? do_user_addr_fault+0x1d4/0x5e0
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: BUG: scheduling while atomic: Web 
Content/42095/0x00000003
Dec 15 13:08:23 surfplank2 kernel: Modules linked in: snd_seq_dummy 
mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 
xt_u32 xt_multiport iptable_filter nf_conntrack_netbios_ns 
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter 
it87 msr hwmon_vid ip6_tables uvcvideo snd_hda_codec_realtek 
videobuf2_vmalloc videobuf2_memops snd_usb_audio snd_hda_codec_generic 
snd_hda_intel snd_hwdep videobuf2_v4l2 snd_intel_dspcfg snd_usbmidi_lib 
snd_hda_codec videodev snd_hda_core cdc_acm videobuf2_common snd_rawmidi 
lzo_rle snd_seq lzo_compress snd_seq_device snd_pcm snd_timer snd bfq 
i2c_piix4 evdev p_lkrg binfmt_misc fuse configfs zram zsmalloc ip_tables 
x_tables amdgpu aesni_intel drm_ttm_helper ttm gpu_sched sr_mod cdrom 
hid_generic usbhid i2c_dev autofs4
Dec 15 13:08:23 surfplank2 kernel: Preemption disabled at:
Dec 15 13:08:23 surfplank2 kernel: [<ffffffffb9029d4b>] 
optimized_callback+0x1b/0xf0
Dec 15 13:08:23 surfplank2 kernel: CPU: 10 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: ? optimized_callback+0x1b/0xf0
Dec 15 13:08:23 surfplank2 kernel: __schedule_bug.cold+0x7c/0x8a
Dec 15 13:08:23 surfplank2 kernel: __schedule+0x5ae/0x7a0
Dec 15 13:08:23 surfplank2 kernel: schedule+0x3e/0xe0
Dec 15 13:08:23 surfplank2 kernel: schedule_timeout+0xbb/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? resched_curr+0x1b/0x60
Dec 15 13:08:23 surfplank2 kernel: wait_for_completion+0x84/0xe0
Dec 15 13:08:23 surfplank2 kernel: __flush_work.isra.0+0x15a/0x220
Dec 15 13:08:23 surfplank2 kernel: ? flush_workqueue_prep_pwqs+0x110/0x110
Dec 15 13:08:23 surfplank2 kernel: __drain_all_pages+0x15e/0x1b0
Dec 15 13:08:23 surfplank2 kernel: 
__alloc_pages_slowpath.constprop.0+0x2e1/0xab0
Dec 15 13:08:23 surfplank2 kernel: ? irq_work_queue+0xb/0x50
Dec 15 13:08:23 surfplank2 kernel: __alloc_pages+0x16c/0x1e0
Dec 15 13:08:23 surfplank2 kernel: cache_alloc_refill+0x23e/0x810
Dec 15 13:08:23 surfplank2 kernel: kmem_cache_alloc+0x105/0x120
Dec 15 13:08:23 surfplank2 kernel: p_dump_task_f+0x19/0xf0 [p_lkrg]
Dec 15 13:08:23 surfplank2 kernel: p_wake_up_new_task_entry+0x6b/0xe0 
[p_lkrg]
Dec 15 13:08:23 surfplank2 kernel: pre_handler_kretprobe+0x8a/0x160
Dec 15 13:08:23 surfplank2 kernel: opt_pre_handler+0x47/0x80
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? kernel_clone+0xd6/0x3a0
Dec 15 13:08:23 surfplank2 kernel: ? __mod_node_page_state+0x77/0xb0
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_q+0x45/0x80
Dec 15 13:08:23 surfplank2 kernel: ? rwsem_wake.isra.0+0x65/0x90
Dec 15 13:08:23 surfplank2 kernel: ? do_user_addr_fault+0x1d4/0x5e0
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: [p_lkrg] p_alloc_ed_pids() returned 
NULL for pid 42114 :(
Dec 15 13:08:23 surfplank2 kernel: [p_lkrg] <Exploit Detection> 
Error[-1] when trying to add process[42114 |Web Content] for tracking!
Dec 15 13:08:23 surfplank2 kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: Web Content/42095
Dec 15 13:08:23 surfplank2 kernel: caller is opt_pre_handler+0x53/0x80
Dec 15 13:08:23 surfplank2 kernel: CPU: 10 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 13:08:23 surfplank2 kernel: opt_pre_handler+0x53/0x80
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 13:08:23 surfplank2 kernel: ? __mod_node_page_state+0x77/0xb0
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_q+0x45/0x80
Dec 15 13:08:23 surfplank2 kernel: ? rwsem_wake.isra.0+0x65/0x90
Dec 15 13:08:23 surfplank2 kernel: ? do_user_addr_fault+0x1d4/0x5e0
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: Web Content/42095
Dec 15 13:08:23 surfplank2 kernel: caller is optimized_callback+0xc6/0xf0
Dec 15 13:08:23 surfplank2 kernel: CPU: 10 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xc6/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 13:08:23 surfplank2 kernel: ? __mod_node_page_state+0x77/0xb0
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_q+0x45/0x80
Dec 15 13:08:23 surfplank2 kernel: ? rwsem_wake.isra.0+0x65/0x90
Dec 15 13:08:23 surfplank2 kernel: ? do_user_addr_fault+0x1d4/0x5e0
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: BUG: scheduling while atomic: Web 
Content/42095/0x00000003
Dec 15 13:08:23 surfplank2 kernel: Modules linked in: snd_seq_dummy 
mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 
xt_u32 xt_multiport iptable_filter nf_conntrack_netbios_ns 
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter 
it87 msr hwmon_vid ip6_tables uvcvideo snd_hda_codec_realtek 
videobuf2_vmalloc videobuf2_memops snd_usb_audio snd_hda_codec_generic 
snd_hda_intel snd_hwdep videobuf2_v4l2 snd_intel_dspcfg snd_usbmidi_lib 
snd_hda_codec videodev snd_hda_core cdc_acm videobuf2_common snd_rawmidi 
lzo_rle snd_seq lzo_compress snd_seq_device snd_pcm snd_timer snd bfq 
i2c_piix4 evdev p_lkrg binfmt_misc fuse configfs zram zsmalloc ip_tables 
x_tables amdgpu aesni_intel drm_ttm_helper ttm gpu_sched sr_mod cdrom 
hid_generic usbhid i2c_dev autofs4
Dec 15 13:08:23 surfplank2 kernel: Preemption disabled at:
Dec 15 13:08:23 surfplank2 kernel: [<ffffffffb9029d4b>] 
optimized_callback+0x1b/0xf0
Dec 15 13:08:23 surfplank2 kernel: CPU: 10 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: ? optimized_callback+0x1b/0xf0
Dec 15 13:08:23 surfplank2 kernel: __schedule_bug.cold+0x7c/0x8a
Dec 15 13:08:23 surfplank2 kernel: __schedule+0x5ae/0x7a0
Dec 15 13:08:23 surfplank2 kernel: schedule+0x3e/0xe0
Dec 15 13:08:23 surfplank2 kernel: schedule_timeout+0xbb/0xf0
Dec 15 13:08:23 surfplank2 kernel: wait_for_completion+0x84/0xe0
Dec 15 13:08:23 surfplank2 kernel: __flush_work.isra.0+0x15a/0x220
Dec 15 13:08:23 surfplank2 kernel: ? flush_workqueue_prep_pwqs+0x110/0x110
Dec 15 13:08:23 surfplank2 kernel: __drain_all_pages+0x15e/0x1b0
Dec 15 13:08:23 surfplank2 kernel: 
__alloc_pages_slowpath.constprop.0+0x2e1/0xab0
Dec 15 13:08:23 surfplank2 kernel: __alloc_pages+0x16c/0x1e0
Dec 15 13:08:23 surfplank2 kernel: cache_alloc_refill+0x23e/0x810
Dec 15 13:08:23 surfplank2 kernel: kmem_cache_alloc+0x105/0x120
Dec 15 13:08:23 surfplank2 kernel: p_dump_task_f+0x19/0xf0 [p_lkrg]
Dec 15 13:08:23 surfplank2 kernel: p_wake_up_new_task_entry+0x6b/0xe0 
[p_lkrg]
Dec 15 13:08:23 surfplank2 kernel: pre_handler_kretprobe+0x8a/0x160
Dec 15 13:08:23 surfplank2 kernel: opt_pre_handler+0x47/0x80
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? kernel_clone+0xd6/0x3a0
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x69/0x80
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: [p_lkrg] p_alloc_ed_pids() returned 
NULL for pid 42115 :(
Dec 15 13:08:23 surfplank2 kernel: [p_lkrg] <Exploit Detection> 
Error[-1] when trying to add process[42115 |Web Content] for tracking!
Dec 15 13:08:23 surfplank2 kernel: BUG: scheduling while atomic: Web 
Content/42095/0x00000003
Dec 15 13:08:23 surfplank2 kernel: Modules linked in: snd_seq_dummy 
mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 
xt_u32 xt_multiport iptable_filter nf_conntrack_netbios_ns 
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter 
it87 msr hwmon_vid ip6_tables uvcvideo snd_hda_codec_realtek 
videobuf2_vmalloc videobuf2_memops snd_usb_audio snd_hda_codec_generic 
snd_hda_intel snd_hwdep videobuf2_v4l2 snd_intel_dspcfg snd_usbmidi_lib 
snd_hda_codec videodev snd_hda_core cdc_acm videobuf2_common snd_rawmidi 
lzo_rle snd_seq lzo_compress snd_seq_device snd_pcm snd_timer snd bfq 
i2c_piix4 evdev p_lkrg binfmt_misc fuse configfs zram zsmalloc ip_tables 
x_tables amdgpu aesni_intel drm_ttm_helper ttm gpu_sched sr_mod cdrom 
hid_generic usbhid i2c_dev autofs4
Dec 15 13:08:23 surfplank2 kernel: Preemption disabled at:
Dec 15 13:08:23 surfplank2 kernel: [<ffffffffb9029d4b>] 
optimized_callback+0x1b/0xf0
Dec 15 13:08:23 surfplank2 kernel: CPU: 10 PID: 42095 Comm: Web Content 
Tainted: G        W         5.15.8 #4
Dec 15 13:08:23 surfplank2 kernel: Hardware name: Gigabyte Technology 
Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 13:08:23 surfplank2 kernel: Call Trace:
Dec 15 13:08:23 surfplank2 kernel: <TASK>
Dec 15 13:08:23 surfplank2 kernel: dump_stack_lvl+0x34/0x44
Dec 15 13:08:23 surfplank2 kernel: ? optimized_callback+0x1b/0xf0
Dec 15 13:08:23 surfplank2 kernel: __schedule_bug.cold+0x7c/0x8a
Dec 15 13:08:23 surfplank2 kernel: __schedule+0x5ae/0x7a0
Dec 15 13:08:23 surfplank2 kernel: schedule+0x3e/0xe0
Dec 15 13:08:23 surfplank2 kernel: schedule_timeout+0xbb/0xf0
Dec 15 13:08:23 surfplank2 kernel: wait_for_completion+0x84/0xe0
Dec 15 13:08:23 surfplank2 kernel: __flush_work.isra.0+0x15a/0x220
Dec 15 13:08:23 surfplank2 kernel: ? flush_workqueue_prep_pwqs+0x110/0x110
Dec 15 13:08:23 surfplank2 kernel: __drain_all_pages+0x15e/0x1b0
Dec 15 13:08:23 surfplank2 kernel: 
__alloc_pages_slowpath.constprop.0+0x2e1/0xab0
Dec 15 13:08:23 surfplank2 kernel: ? _raw_spin_trylock+0xe/0x50
Dec 15 13:08:23 surfplank2 kernel: ? vt_console_print+0x6f/0x400
Dec 15 13:08:23 surfplank2 kernel: __alloc_pages+0x16c/0x1e0
Dec 15 13:08:23 surfplank2 kernel: cache_alloc_refill+0x23e/0x810
Dec 15 13:08:23 surfplank2 kernel: kmem_cache_alloc+0x105/0x120
Dec 15 13:08:23 surfplank2 kernel: p_dump_task_f+0x19/0xf0 [p_lkrg]
Dec 15 13:08:23 surfplank2 kernel: p_wake_up_new_task_entry+0x6b/0xe0 
[p_lkrg]
Dec 15 13:08:23 surfplank2 kernel: pre_handler_kretprobe+0x8a/0x160
Dec 15 13:08:23 surfplank2 kernel: opt_pre_handler+0x47/0x80
Dec 15 13:08:23 surfplank2 kernel: optimized_callback+0xba/0xf0
Dec 15 13:08:23 surfplank2 kernel: 0xffffffffc01b2294
Dec 15 13:08:23 surfplank2 kernel: ? wake_up_new_task+0x1/0x290
Dec 15 13:08:23 surfplank2 kernel: ? kernel_clone+0xd6/0x3a0
Dec 15 13:08:23 surfplank2 kernel: ? __do_sys_clone+0x60/0x80
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x5c/0x80
Dec 15 13:08:23 surfplank2 kernel: ? handle_mm_fault+0x67/0x1a0
Dec 15 13:08:23 surfplank2 kernel: ? do_user_addr_fault+0x1d4/0x5e0
Dec 15 13:08:23 surfplank2 kernel: ? do_syscall_64+0x69/0x80
Dec 15 13:08:23 surfplank2 kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 13:08:23 surfplank2 kernel: ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 13:08:23 surfplank2 kernel: </TASK>
Dec 15 13:08:23 surfplank2 kernel: [p_lkrg] p_alloc_ed_pids() returned 
NULL for pid 42116 :(
Dec 15 13:08:23 surfplank2 kernel: [p_lkrg] <Exploit Detection> 
Error[-1] when trying to add process[42116 |Web Content] for tracking!
(cut)
(etc, etc, etc)

Udo



On 15-12-2021 05:45, Udo van den Heuvel wrote:
> Hello,
> 
> Found this in messages after a crash this morning.
> How to fix?
> 
> Udo
> 
> 
> 
> Dec 15 03:35:01 crashbox kernel: [47328.827897] BUG: scheduling while 
> atomic: rkhunter/144447/0x00000003
> Dec 15 03:35:01 crashbox kernel: [47328.827905] Modules linked in: 
> snd_seq_dummy mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT 
> nf_reject_ipv4 xt_u32 xt_multiport iptable_filter 
> nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_REJECT 
> nf_reject_ipv6 xt_tcpudp xt_state xt_conntrack nf_conntrack 
> nf_defrag_ipv6 nf_defrag_ipv4 it87 msr ip6table_filter hwmon_vid 
> ip6_tables snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel 
(cut)
