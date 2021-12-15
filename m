Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1004751CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 06:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbhLOE44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 23:56:56 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.169]:56135 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhLOE4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 23:56:51 -0500
X-Greylist: delayed 662 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Dec 2021 23:56:50 EST
X-KPN-MessageId: 6f969be5-5d61-11ec-9abf-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 6f969be5-5d61-11ec-9abf-005056abad63;
        Wed, 15 Dec 2021 05:42:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:subject:from:to:mime-version:date:message-id;
        bh=fMGpM5SYWNOQtrqBp1uFtWNhFq+B/My0xluMjjqV2/M=;
        b=nghjk3Y10477L9IUurXGo2MOlppiIBjlOnuKqspaBO9CeDH1lceay1NfOlFkyRboIx9XFc5HSdba3
         qrjkNJKIblxlU6mtWz8Q2hftfnh1kBJdAqRCUgEpC55gkWUfaYpwKZBrxd8oabPYUIYYduoMp6ncwS
         5F5yuvgfIzVGAOTE83olRrRBRQj1QV6oMqgxbx2Pl0CUS6ya3o0iThIZJP3zHQc0GbcTFsz3IjooBa
         Ai7GzMWXZgk/4WZCngh+AQQheIFc5FPs/QBVTmDvO08NixZWzn1s1w/lBapcqa565O8xZE6ZSk+O2s
         E8kJ/+hfrNHulnedl6f1JQz1I6a96Jg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|6Y9qzC4AwYSLUanv0+P7a1jgISuzkWj70rZes6E6vjxPtEo7ghANmvwqIJcOwxD
 DvHkoUMpUUh8anZSwu01DwQ==
X-Originating-IP: 82.161.210.87
Received: from [192.168.10.70] (pindarots.xs4all.nl [82.161.210.87])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id ddbe15d5-5d61-11ec-83ab-005056ab1411;
        Wed, 15 Dec 2021 05:45:46 +0100 (CET)
Message-ID: <8d8d7c27-7a32-a85d-dd9a-38d800d76cab@xs4all.nl>
Date:   Wed, 15 Dec 2021 05:45:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: crash on 5.15.8
Organization: hierzo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Found this in messages after a crash this morning.
How to fix?

Udo



Dec 15 03:35:01 crashbox kernel: [47328.827897] BUG: scheduling while 
atomic: rkhunter/144447/0x00000003
Dec 15 03:35:01 crashbox kernel: [47328.827905] Modules linked in: 
snd_seq_dummy mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT 
nf_reject_ipv4 xt_u32 xt_multiport iptable_filter 
nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_REJECT 
nf_reject_ipv6 xt_tcpudp xt_state xt_conntrack nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 it87 msr ip6table_filter hwmon_vid 
ip6_tables snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel 
snd_intel_dspcfg uvcvideo videobuf2_vmalloc snd_hda_codec 
videobuf2_memops snd_usb_audio videobuf2_v4l2 snd_hda_core snd_hwdep 
snd_usbmidi_lib videodev snd_rawmidi snd_seq videobuf2_common 
snd_seq_device cdc_acm lzo_rle snd_pcm lzo_compress snd_timer snd 
i2c_piix4 bfq evdev p_lkrg binfmt_misc fuse configfs zram zsmalloc 
ip_tables x_tables amdgpu drm_ttm_helper aesni_intel ttm gpu_sched 
sr_mod cdrom hid_generic usbhid i2c_dev autofs4
Dec 15 03:35:01 crashbox kernel: [47328.827959] Preemption disabled at:
Dec 15 03:35:01 crashbox kernel: [47328.827960] [<ffffffffa4029d4b>] 
optimized_callback+0x1b/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.827980] CPU: 10 PID: 144447 
Comm: rkhunter Not tainted 5.15.8 #4
Dec 15 03:35:01 crashbox kernel: [47328.827984] Hardware name: Gigabyte 
Technology Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 03:35:01 crashbox kernel: [47328.827986] Call Trace:
Dec 15 03:35:01 crashbox kernel: [47328.827995]  <TASK>
Dec 15 03:35:01 crashbox kernel: [47328.828001]  dump_stack_lvl+0x34/0x44
Dec 15 03:35:01 crashbox kernel: [47328.828013]  ? 
optimized_callback+0x1b/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.828015] 
__schedule_bug.cold+0x7c/0x8a
Dec 15 03:35:01 crashbox kernel: [47328.828020]  __schedule+0x5ae/0x7a0
Dec 15 03:35:01 crashbox kernel: [47328.828028]  schedule+0x3e/0xe0
Dec 15 03:35:01 crashbox kernel: [47328.828030]  schedule_timeout+0xbb/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.828034]  ? resched_curr+0x1b/0x60
Dec 15 03:35:01 crashbox kernel: [47328.828042] 
wait_for_completion+0x84/0xe0
Dec 15 03:35:01 crashbox kernel: [47328.828046] 
__flush_work.isra.0+0x15a/0x220
Dec 15 03:35:01 crashbox kernel: [47328.828052]  ? 
flush_workqueue_prep_pwqs+0x110/0x110
Dec 15 03:35:01 crashbox kernel: [47328.828054] 
__drain_all_pages+0x15e/0x1b0
Dec 15 03:35:01 crashbox kernel: [47328.828057] 
__alloc_pages_slowpath.constprop.0+0x2e1/0xab0
Dec 15 03:35:01 crashbox kernel: [47328.828060]  __alloc_pages+0x16c/0x1e0
Dec 15 03:35:01 crashbox kernel: [47328.828062] 
cache_alloc_refill+0x23e/0x810
Dec 15 03:35:01 crashbox kernel: [47328.828066] 
kmem_cache_alloc+0x105/0x120
Dec 15 03:35:01 crashbox kernel: [47328.828069]  p_dump_task_f+0x19/0xf0 
[p_lkrg]
Dec 15 03:35:01 crashbox kernel: [47328.828083] 
p_wake_up_new_task_entry+0x6b/0xe0 [p_lkrg]
Dec 15 03:35:01 crashbox kernel: [47328.828090] 
pre_handler_kretprobe+0x8a/0x160
Dec 15 03:35:01 crashbox kernel: [47328.828096]  opt_pre_handler+0x47/0x80
Dec 15 03:35:01 crashbox kernel: [47328.828099] 
optimized_callback+0xba/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.828101]  0xffffffffc037d294
Dec 15 03:35:01 crashbox kernel: [47328.828103]  ? 
wake_up_new_task+0x1/0x290
Dec 15 03:35:01 crashbox kernel: [47328.828106]  ? kernel_clone+0xd6/0x3a0
Dec 15 03:35:01 crashbox kernel: [47328.828108]  ? 
exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.828110]  ? __do_sys_clone+0x60/0x80
Dec 15 03:35:01 crashbox kernel: [47328.828112]  ? do_syscall_64+0x5c/0x80
Dec 15 03:35:01 crashbox kernel: [47328.828114]  ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: [47328.828116]  ? 
exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.828117]  ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 03:35:01 crashbox kernel: [47328.828120]  </TASK>
Dec 15 03:35:01 crashbox kernel: [47328.838718] sh: page allocation 
failure: order:7, mode:0x40cc0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
Dec 15 03:35:01 crashbox kernel: [47328.838743] CPU: 5 PID: 144452 Comm: 
sh Tainted: G        W         5.15.8 #4
Dec 15 03:35:01 crashbox kernel: [47328.838749] Hardware name: Gigabyte 
Technology Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 03:35:01 crashbox kernel: [47328.838753] Call Trace:
Dec 15 03:35:01 crashbox kernel: [47328.838759]  <TASK>
Dec 15 03:35:01 crashbox kernel: [47328.838762]  dump_stack_lvl+0x34/0x44
Dec 15 03:35:01 crashbox kernel: [47328.838777]  warn_alloc.cold+0x6f/0xd3
Dec 15 03:35:01 crashbox kernel: [47328.838784]  ? 
__alloc_pages_direct_compact+0x114/0x1b0
Dec 15 03:35:01 crashbox kernel: [47328.838792] 
__alloc_pages_slowpath.constprop.0+0x71b/0xab0
Dec 15 03:35:01 crashbox kernel: [47328.838797]  __alloc_pages+0x16c/0x1e0
Dec 15 03:35:01 crashbox kernel: [47328.838800] 
cache_alloc_refill+0x23e/0x810
Dec 15 03:35:01 crashbox kernel: [47328.838805] 
kmem_cache_alloc+0x105/0x120
Dec 15 03:35:01 crashbox kernel: [47328.838809]  p_dump_task_f+0x19/0xf0 
[p_lkrg]
Dec 15 03:35:01 crashbox kernel: [47328.838822] 
p_wake_up_new_task_entry+0x6b/0xe0 [p_lkrg]
Dec 15 03:35:01 crashbox kernel: [47328.838832] 
pre_handler_kretprobe+0x8a/0x160
Dec 15 03:35:01 crashbox kernel: [47328.838837]  opt_pre_handler+0x47/0x80
Dec 15 03:35:01 crashbox kernel: [47328.838841] 
optimized_callback+0xba/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.838846]  0xffffffffc037d294
Dec 15 03:35:01 crashbox kernel: [47328.838850]  ? 
wake_up_new_task+0x1/0x290
Dec 15 03:35:01 crashbox kernel: [47328.838854]  ? kernel_clone+0xd6/0x3a0
Dec 15 03:35:01 crashbox kernel: [47328.838858]  ? __do_sys_clone+0x60/0x80
Dec 15 03:35:01 crashbox kernel: [47328.838862]  ? do_syscall_64+0x5c/0x80
Dec 15 03:35:01 crashbox kernel: [47328.838865]  ? 
exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.838869]  ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 03:35:01 crashbox kernel: [47328.838874]  </TASK>
Dec 15 03:35:01 crashbox kernel: [47328.838875] Mem-Info:
Dec 15 03:35:01 crashbox kernel: [47328.838878] active_anon:1491 
inactive_anon:544373 isolated_anon:0
Dec 15 03:35:01 crashbox kernel: [47328.838878]  active_file:2682203 
inactive_file:4287582 isolated_file:0
Dec 15 03:35:01 crashbox kernel: [47328.838878]  unevictable:6162 
dirty:11 writeback:0
Dec 15 03:35:01 crashbox kernel: [47328.838878]  slab_reclaimable:102841 
slab_unreclaimable:133000
Dec 15 03:35:01 crashbox kernel: [47328.838878]  mapped:135781 
shmem:26838 pagetables:6608 bounce:0
Dec 15 03:35:01 crashbox kernel: [47328.838878]  kernel_misc_reclaimable:0
Dec 15 03:35:01 crashbox kernel: [47328.838878]  free:100245 
free_pcp:1134 free_cma:0
Dec 15 03:35:01 crashbox kernel: [47328.838885] Node 0 
active_anon:5964kB inactive_anon:2177492kB active_file:10728812kB 
inactive_file:17150328kB unevictable:24648kB isolated(anon):0kB 
isolated(file):0kB mapped:543124kB dirty:44kB writeback:0kB 
shmem:107352kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 1249280kB 
writeback_tmp:0kB kernel_stack:17936kB pagetables:26432kB 
all_unreclaimable? no
Dec 15 03:35:01 crashbox kernel: [47328.838891] DMA free:15360kB 
min:32kB low:44kB high:56kB reserved_highatomic:0KB active_anon:0kB 
inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB 
writepending:0kB present:15984kB managed:15360kB mlocked:0kB bounce:0kB 
free_pcp:0kB local_pcp:0kB free_cma:0kB
Dec 15 03:35:01 crashbox kernel: [47328.838897] lowmem_reserve[]: 0 2443 
31598 31598
Dec 15 03:35:01 crashbox kernel: [47328.838901] DMA32 free:122028kB 
min:5012kB low:7404kB high:9796kB reserved_highatomic:0KB 
active_anon:0kB inactive_anon:15884kB active_file:637304kB 
inactive_file:1722708kB unevictable:0kB writepending:0kB 
present:2502164kB managed:2502164kB mlocked:0kB bounce:0kB free_pcp:0kB 
local_pcp:0kB free_cma:0kB
Dec 15 03:35:01 crashbox kernel: [47328.838906] lowmem_reserve[]: 0 0 
29155 29155
Dec 15 03:35:01 crashbox kernel: [47328.838910] Normal free:263592kB 
min:62536kB low:92384kB high:122232kB reserved_highatomic:0KB 
active_anon:5964kB inactive_anon:2162336kB active_file:10092024kB 
inactive_file:15427852kB unevictable:24648kB writepending:44kB 
present:30379008kB managed:29854884kB mlocked:24648kB bounce:0kB 
free_pcp:4536kB local_pcp:28kB free_cma:0kB
Dec 15 03:35:01 crashbox kernel: [47328.838915] lowmem_reserve[]: 0 0 0 0
Dec 15 03:35:01 crashbox kernel: [47328.838918] DMA: 0*4kB 0*8kB 0*16kB 
0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB 
(M) = 15360kB
Dec 15 03:35:01 crashbox kernel: [47328.838929] DMA32: 37*4kB (UME) 
49*8kB (UME) 41*16kB (ME) 12*32kB (E) 6*64kB (UME) 2*128kB (UE) 2*256kB 
(UM) 3*512kB (UM) 3*1024kB (UM) 2*2048kB (UM) 27*4096kB (UME) = 122028kB
Dec 15 03:35:01 crashbox kernel: [47328.838943] Normal: 9022*4kB (UME) 
5744*8kB (UME) 2412*16kB (UME) 1225*32kB (UME) 834*64kB (UME) 324*128kB 
(UME) 37*256kB (UME) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 264152kB
Dec 15 03:35:01 crashbox kernel: [47328.838956] Node 0 hugepages_total=0 
hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Dec 15 03:35:01 crashbox kernel: [47328.838958] 7000181 total pagecache 
pages
Dec 15 03:35:01 crashbox kernel: [47328.838959] 0 pages in swap cache
Dec 15 03:35:01 crashbox kernel: [47328.838961] Swap cache stats: add 
198, delete 198, find 0/0
Dec 15 03:35:01 crashbox kernel: [47328.838963] Free swap  = 18870264kB
Dec 15 03:35:01 crashbox kernel: [47328.838964] Total swap = 18874360kB
Dec 15 03:35:01 crashbox kernel: [47328.838965] 8224289 pages RAM
Dec 15 03:35:01 crashbox kernel: [47328.838966] 0 pages HighMem/MovableOnly
Dec 15 03:35:01 crashbox kernel: [47328.838967] 131187 pages reserved
Dec 15 03:35:01 crashbox kernel: [47328.838969] [p_lkrg] 
p_alloc_ed_pids() returned NULL for pid 144454 :(
Dec 15 03:35:01 crashbox kernel: [47328.838970] [p_lkrg] <Exploit 
Detection> Error[-1] when trying to add process[144454 |sh] for tracking!
Dec 15 03:35:01 crashbox kernel: [47328.839003] ------------[ cut here 
]------------
Dec 15 03:35:01 crashbox kernel: [47328.839009] DEBUG_LOCKS_WARN_ON(val 
 > preempt_count())
Dec 15 03:35:01 crashbox kernel: [47328.839014] WARNING: CPU: 2 PID: 
144447 at kernel/sched/core.c:5431 preempt_count_sub+0x55/0x90
Dec 15 03:35:01 crashbox kernel: [47328.839023] Modules linked in: 
snd_seq_dummy mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT 
nf_reject_ipv4 xt_u32 xt_multiport iptable_filter 
nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_REJECT 
nf_reject_ipv6 xt_tcpudp xt_state xt_conntrack nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 it87 msr ip6table_filter hwmon_vid 
ip6_tables snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel 
snd_intel_dspcfg uvcvideo videobuf2_vmalloc snd_hda_codec 
videobuf2_memops snd_usb_audio videobuf2_v4l2 snd_hda_core snd_hwdep 
snd_usbmidi_lib videodev snd_rawmidi snd_seq videobuf2_common 
snd_seq_device cdc_acm lzo_rle snd_pcm lzo_compress snd_timer snd 
i2c_piix4 bfq evdev p_lkrg binfmt_misc fuse configfs zram zsmalloc 
ip_tables x_tables amdgpu drm_ttm_helper aesni_intel ttm gpu_sched 
sr_mod cdrom hid_generic usbhid i2c_dev autofs4
Dec 15 03:35:01 crashbox kernel: [47328.839081] CPU: 2 PID: 144447 Comm: 
rkhunter Tainted: G        W         5.15.8 #4
Dec 15 03:35:01 crashbox kernel: [47328.839086] Hardware name: Gigabyte 
Technology Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 03:35:01 crashbox kernel: [47328.839090] RIP: 
0010:preempt_count_sub+0x55/0x90
Dec 15 03:35:01 crashbox kernel: [47328.839095] Code: 66 f8 5b c3 e8 1c 
2e 27 00 85 c0 74 f6 8b 15 4a 75 06 01 85 d2 75 ec 48 c7 c6 6c 82 e5 a4 
48 c7 c7 d9 3a e5 a4 e8 0e 9d 6c 00 <0f> 0b c3 84 c0 75 c9 e8 ef 2d 27 
00 85 c0 74 c9 8b 05 1d 75 06 01
Dec 15 03:35:01 crashbox kernel: [47328.839098] RSP: 
0018:ffff9faf860a7cd0 EFLAGS: 00010286
Dec 15 03:35:01 crashbox kernel: [47328.839102] RAX: 0000000000000000 
RBX: 0000000000000d60 RCX: 0000000000000000
Dec 15 03:35:01 crashbox kernel: [47328.839104] RDX: 0000000000000001 
RSI: ffffffffa4e77d5a RDI: 00000000ffffffff
Dec 15 03:35:01 crashbox kernel: [47328.839107] RBP: ffff978574cac000 
R08: ffff978c7e2b0ba8 R09: 00000000ffffdfff
Dec 15 03:35:01 crashbox kernel: [47328.839109] R10: ffff978c7dd50000 
R11: ffff978c7dd50000 R12: 0000000000023442
Dec 15 03:35:01 crashbox kernel: [47328.839111] R13: 0000000000000216 
R14: ffffffffc0491aa0 R15: 0000000000000000
Dec 15 03:35:01 crashbox kernel: [47328.839113] FS: 
00007fe9e3c51740(0000) GS:ffff978c7de80000(0000) knlGS:0000000000000000
Dec 15 03:35:01 crashbox kernel: [47328.839116] CS:  0010 DS: 0000 ES: 
0000 CR0: 0000000080050033
Dec 15 03:35:01 crashbox kernel: [47328.839118] CR2: 00007f130d31d944 
CR3: 00000001cab6a000 CR4: 0000000000750ee0
Dec 15 03:35:01 crashbox kernel: [47328.839120] PKRU: 55555554
Dec 15 03:35:01 crashbox kernel: [47328.839122] Call Trace:
Dec 15 03:35:01 crashbox kernel: [47328.839125]  <TASK>
Dec 15 03:35:01 crashbox kernel: [47328.839127] 
_raw_write_unlock_irqrestore+0x16/0x30
Dec 15 03:35:01 crashbox kernel: [47328.839133] 
p_wake_up_new_task_entry+0x8c/0xe0 [p_lkrg]
Dec 15 03:35:01 crashbox kernel: [47328.839149] 
pre_handler_kretprobe+0x8a/0x160
Dec 15 03:35:01 crashbox kernel: [47328.839156]  opt_pre_handler+0x47/0x80
Dec 15 03:35:01 crashbox kernel: [47328.839161] 
optimized_callback+0xba/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.839167]  0xffffffffc037d294
Dec 15 03:35:01 crashbox kernel: [47328.839172]  ? 
wake_up_new_task+0x1/0x290
Dec 15 03:35:01 crashbox kernel: [47328.839177]  ? kernel_clone+0xd6/0x3a0
Dec 15 03:35:01 crashbox kernel: [47328.839184]  ? 
exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.839191]  ? __do_sys_clone+0x60/0x80
Dec 15 03:35:01 crashbox kernel: [47328.839195]  ? do_syscall_64+0x5c/0x80
Dec 15 03:35:01 crashbox kernel: [47328.839199]  ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: [47328.839202]  ? 
exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.839207]  ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 03:35:01 crashbox kernel: [47328.839212]  </TASK>
Dec 15 03:35:01 crashbox kernel: [47328.839214] ---[ end trace 
8b5601db1943e98c ]---
Dec 15 03:35:01 crashbox kernel: [47328.839219] BUG: using 
__this_cpu_write() in preemptible [00000000] code: rkhunter/144447
Dec 15 03:35:01 crashbox kernel: [47328.839222] caller is 
opt_pre_handler+0x53/0x80
Dec 15 03:35:01 crashbox kernel: [47328.839226] CPU: 2 PID: 144447 Comm: 
rkhunter Tainted: G        W         5.15.8 #4
Dec 15 03:35:01 crashbox kernel: [47328.839230] Hardware name: Gigabyte 
Technology Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 03:35:01 crashbox kernel: [47328.839232] Call Trace:
Dec 15 03:35:01 crashbox kernel: [47328.839234]  <TASK>
Dec 15 03:35:01 crashbox kernel: [47328.839236]  dump_stack_lvl+0x34/0x44
Dec 15 03:35:01 crashbox kernel: [47328.839242] 
check_preemption_disabled+0xd8/0xe0
Dec 15 03:35:01 crashbox kernel: [47328.839247]  opt_pre_handler+0x53/0x80
Dec 15 03:35:01 crashbox kernel: [47328.839250] 
optimized_callback+0xba/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.839254]  0xffffffffc037d294
Dec 15 03:35:01 crashbox kernel: [47328.839257]  ? 
wake_up_new_task+0x1/0x290
Dec 15 03:35:01 crashbox kernel: [47328.839261]  ? 
arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 03:35:01 crashbox kernel: [47328.839265]  ? 
exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.839268]  ? __do_sys_clone+0x60/0x80
Dec 15 03:35:01 crashbox kernel: [47328.839272]  ? do_syscall_64+0x5c/0x80
Dec 15 03:35:01 crashbox kernel: [47328.839275]  ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: [47328.839278]  ? 
exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.839281]  ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 03:35:01 crashbox kernel: [47328.839286]  </TASK>
Dec 15 03:35:01 crashbox kernel: [47328.839287] BUG: using 
__this_cpu_write() in preemptible [00000000] code: rkhunter/144447
Dec 15 03:35:01 crashbox kernel: [47328.839290] caller is 
optimized_callback+0xc6/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.839294] CPU: 2 PID: 144447 Comm: 
rkhunter Tainted: G        W         5.15.8 #4
Dec 15 03:35:01 crashbox kernel: [47328.839296] Hardware name: Gigabyte 
Technology Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 03:35:01 crashbox kernel: [47328.839298] Call Trace:
Dec 15 03:35:01 crashbox kernel: [47328.839299]  <TASK>
Dec 15 03:35:01 crashbox kernel: [47328.839300]  dump_stack_lvl+0x34/0x44
Dec 15 03:35:01 crashbox kernel: [47328.839305] 
check_preemption_disabled+0xd8/0xe0
Dec 15 03:35:01 crashbox kernel: [47328.839309] 
optimized_callback+0xc6/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.839312]  0xffffffffc037d294
Dec 15 03:35:01 crashbox kernel: [47328.839315]  ? 
wake_up_new_task+0x1/0x290
Dec 15 03:35:01 crashbox kernel: [47328.839319]  ? 
arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 03:35:01 crashbox kernel: [47328.839322]  ? 
exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.839325]  ? __do_sys_clone+0x60/0x80
Dec 15 03:35:01 crashbox kernel: [47328.839329]  ? do_syscall_64+0x5c/0x80
Dec 15 03:35:01 crashbox kernel: [47328.839332]  ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: [47328.839335]  ? 
exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.839338]  ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 03:35:01 crashbox kernel: [47328.839342]  </TASK>
Dec 15 03:35:01 crashbox kernel: [47328.841632] BUG: scheduling while 
atomic: rkhunter/37245/0x00000003
Dec 15 03:35:01 crashbox kernel: [47328.841637] Modules linked in: 
snd_seq_dummy mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT 
nf_reject_ipv4 xt_u32 xt_multiport iptable_filter 
nf_conntrack_netbios_ns nf_conntrack_broadcast ip6t_REJECT 
nf_reject_ipv6 xt_tcpudp xt_state xt_conntrack nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 it87 msr ip6table_filter hwmon_vid 
ip6_tables snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel 
snd_intel_dspcfg uvcvideo videobuf2_vmalloc snd_hda_codec 
videobuf2_memops snd_usb_audio videobuf2_v4l2 snd_hda_core snd_hwdep 
snd_usbmidi_lib videodev snd_rawmidi snd_seq videobuf2_common 
snd_seq_device cdc_acm lzo_rle snd_pcm lzo_compress snd_timer snd 
i2c_piix4 bfq evdev p_lkrg binfmt_misc fuse configfs zram zsmalloc 
ip_tables x_tables amdgpu drm_ttm_helper aesni_intel ttm gpu_sched 
sr_mod cdrom hid_generic usbhid i2c_dev autofs4
Dec 15 03:35:01 crashbox kernel: [47328.841692] Preemption disabled at:
Dec 15 03:35:01 crashbox kernel: [47328.841693] [<ffffffffa4029d4b>] 
optimized_callback+0x1b/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.841706] CPU: 14 PID: 37245 Comm: 
rkhunter Tainted: G        W         5.15.8 #4
Dec 15 03:35:01 crashbox kernel: [47328.841710] Hardware name: Gigabyte 
Technology Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 03:35:01 crashbox kernel: [47328.841712] Call Trace:
Dec 15 03:35:01 crashbox kernel: [47328.841714]  <TASK>
Dec 15 03:35:01 crashbox kernel: [47328.841716]  dump_stack_lvl+0x34/0x44
Dec 15 03:35:01 crashbox kernel: [47328.841723]  ? 
optimized_callback+0x1b/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.841725] 
__schedule_bug.cold+0x7c/0x8a
Dec 15 03:35:01 crashbox kernel: [47328.841728]  __schedule+0x5ae/0x7a0
Dec 15 03:35:01 crashbox kernel: [47328.841732]  schedule+0x3e/0xe0
Dec 15 03:35:01 crashbox kernel: [47328.841735]  schedule_timeout+0xbb/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.841737] 
wait_for_completion+0x84/0xe0
Dec 15 03:35:01 crashbox kernel: [47328.841739] 
__flush_work.isra.0+0x15a/0x220
Dec 15 03:35:01 crashbox kernel: [47328.841742]  ? 
flush_workqueue_prep_pwqs+0x110/0x110
Dec 15 03:35:01 crashbox kernel: [47328.841744] 
__drain_all_pages+0x15e/0x1b0
Dec 15 03:35:01 crashbox kernel: [47328.841747] 
__alloc_pages_slowpath.constprop.0+0x2e1/0xab0
Dec 15 03:35:01 crashbox kernel: [47328.841751]  __alloc_pages+0x16c/0x1e0
Dec 15 03:35:01 crashbox kernel: [47328.841753] 
cache_alloc_refill+0x23e/0x810
Dec 15 03:35:01 crashbox kernel: [47328.841757] 
kmem_cache_alloc+0x105/0x120
Dec 15 03:35:01 crashbox kernel: [47328.841760]  p_dump_task_f+0x19/0xf0 
[p_lkrg]
Dec 15 03:35:01 crashbox kernel: [47328.841771] 
p_wake_up_new_task_entry+0x6b/0xe0 [p_lkrg]
Dec 15 03:35:01 crashbox kernel: [47328.841780] 
pre_handler_kretprobe+0x8a/0x160
Dec 15 03:35:01 crashbox kernel: [47328.841786]  opt_pre_handler+0x47/0x80
Dec 15 03:35:01 crashbox kernel: [47328.841789] 
optimized_callback+0xba/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.841794]  0xffffffffc037d294
Dec 15 03:35:01 crashbox kernel: [47328.841797]  ? 
wake_up_new_task+0x1/0x290
Dec 15 03:35:01 crashbox kernel: [47328.841800]  ? kernel_clone+0xd6/0x3a0
Dec 15 03:35:01 crashbox kernel: [47328.841803]  ? __do_sys_clone+0x60/0x80
Dec 15 03:35:01 crashbox kernel: [47328.841805]  ? do_syscall_64+0x5c/0x80
Dec 15 03:35:01 crashbox kernel: [47328.841807]  ? 
syscall_exit_to_user_mode+0x1d/0x40
Dec 15 03:35:01 crashbox kernel: [47328.841810]  ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: [47328.841811]  ? 
preempt_count_add+0x63/0x90
Dec 15 03:35:01 crashbox kernel: [47328.841813]  ? 
_raw_spin_lock_irq+0xf/0x30
Dec 15 03:35:01 crashbox kernel: [47328.841815]  ? 
_raw_spin_unlock_irq+0xe/0x20
Dec 15 03:35:01 crashbox kernel: [47328.841817]  ? 
exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.841819]  ? 
syscall_exit_to_user_mode+0x1d/0x40
Dec 15 03:35:01 crashbox kernel: [47328.841821]  ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: [47328.841823]  ? 
exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.841825]  ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 03:35:01 crashbox kernel: [47328.841828]  </TASK>
Dec 15 03:35:01 crashbox kernel: [47328.844627] BUG: using 
__this_cpu_write() in preemptible [00000000] code: rkhunter/37245
Dec 15 03:35:01 crashbox kernel: [47328.844633] caller is 
opt_pre_handler+0x53/0x80
Dec 15 03:35:01 crashbox kernel: [47328.844640] CPU: 14 PID: 37245 Comm: 
rkhunter Tainted: G        W         5.15.8 #4
Dec 15 03:35:01 crashbox kernel: [47328.844643] Hardware name: Gigabyte 
Technology Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 03:35:01 crashbox kernel: [47328.844645] Call Trace:
Dec 15 03:35:01 crashbox kernel: [47328.844647]  <TASK>
Dec 15 03:35:01 crashbox kernel: [47328.844649]  dump_stack_lvl+0x34/0x44
Dec 15 03:35:01 crashbox kernel: [47328.844655] 
check_preemption_disabled+0xd8/0xe0
Dec 15 03:35:01 crashbox kernel: [47328.844660]  opt_pre_handler+0x53/0x80
Dec 15 03:35:01 crashbox kernel: [47328.844664] 
optimized_callback+0xba/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.844668]  0xffffffffc037d294
Dec 15 03:35:01 crashbox kernel: [47328.844672]  ? 
wake_up_new_task+0x1/0x290
Dec 15 03:35:01 crashbox kernel: [47328.844676]  ? 
arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 03:35:01 crashbox kernel: [47328.844680]  ? __do_sys_clone+0x60/0x80
Dec 15 03:35:01 crashbox kernel: [47328.844685]  ? do_syscall_64+0x5c/0x80
Dec 15 03:35:01 crashbox kernel: [47328.844688]  ? 
syscall_exit_to_user_mode+0x1d/0x40
Dec 15 03:35:01 crashbox kernel: [47328.844692]  ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: [47328.844695]  ? 
preempt_count_add+0x63/0x90
Dec 15 03:35:01 crashbox kernel: [47328.844697]  ? 
_raw_spin_lock_irq+0xf/0x30
Dec 15 03:35:01 crashbox kernel: [47328.844701]  ? 
_raw_spin_unlock_irq+0xe/0x20
Dec 15 03:35:01 crashbox kernel: [47328.844704]  ? 
exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.844709]  ? 
syscall_exit_to_user_mode+0x1d/0x40
Dec 15 03:35:01 crashbox kernel: [47328.844712]  ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: [47328.844715]  ? 
exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.844718]  ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 03:35:01 crashbox kernel: [47328.844722]  </TASK>
Dec 15 03:35:01 crashbox kernel: [47328.844724] BUG: using 
__this_cpu_write() in preemptible [00000000] code: rkhunter/37245
Dec 15 03:35:01 crashbox kernel: [47328.844726] caller is 
optimized_callback+0xc6/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.844730] CPU: 14 PID: 37245 Comm: 
rkhunter Tainted: G        W         5.15.8 #4
Dec 15 03:35:01 crashbox kernel: [47328.844732] Hardware name: Gigabyte 
Technology Co., Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 03:35:01 crashbox kernel: [47328.844734] Call Trace:
Dec 15 03:35:01 crashbox kernel: [47328.844736]  <TASK>
Dec 15 03:35:01 crashbox kernel: [47328.844737]  dump_stack_lvl+0x34/0x44
Dec 15 03:35:01 crashbox kernel: [47328.844741] 
check_preemption_disabled+0xd8/0xe0
Dec 15 03:35:01 crashbox kernel: [47328.844745] 
optimized_callback+0xc6/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.844749]  0xffffffffc037d294
Dec 15 03:35:01 crashbox kernel: [47328.844752]  ? 
wake_up_new_task+0x1/0x290
Dec 15 03:35:01 crashbox kernel: [47328.844755]  ? 
arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 03:35:01 crashbox kernel: [47328.844759]  ? __do_sys_clone+0x60/0x80
Dec 15 03:35:01 crashbox kernel: [47328.844762]  ? do_syscall_64+0x5c/0x80
Dec 15 03:35:01 crashbox kernel: [47328.844765]  ? 
syscall_exit_to_user_mode+0x1d/0x40
Dec 15 03:35:01 crashbox kernel: [47328.844769]  ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: [47328.844772]  ? 
preempt_count_add+0x63/0x90
Dec 15 03:35:01 crashbox kernel: [47328.844775]  ? 
_raw_spin_lock_irq+0xf/0x30
Dec 15 03:35:01 crashbox kernel: [47328.844778]  ? 
_raw_spin_unlock_irq+0xe/0x20
Dec 15 03:35:01 crashbox kernel: [47328.844781]  ? 
exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.844784]  ? 
syscall_exit_to_user_mode+0x1d/0x40
Dec 15 03:35:01 crashbox kernel: [47328.844787]  ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: [47328.844790]  ? 
exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: [47328.844793]  ? 
entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 03:35:01 crashbox kernel: [47328.844799]  </TASK>
Dec 15 03:35:01 crashbox kernel: BUG: scheduling while atomic: 
rkhunter/144447/0x00000003
Dec 15 03:35:01 crashbox kernel: Modules linked in: snd_seq_dummy 
mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 
xt_u32 xt_multiport iptable_filter nf_conntrack_netbios_ns 
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 it87 msr 
ip6table_filter hwmon_vid ip6_tables snd_hda_codec_realtek 
snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg uvcvideo 
videobuf2_vmalloc snd_hda_codec videobuf2_memops snd_usb_audio 
videobuf2_v4l2 snd_hda_core snd_hwdep snd_usbmidi_lib videodev 
snd_rawmidi snd_seq videobuf2_common snd_seq_device cdc_acm lzo_rle 
snd_pcm lzo_compress snd_timer snd i2c_piix4 bfq evdev p_lkrg 
binfmt_misc fuse configfs zram zsmalloc ip_tables x_tables amdgpu 
drm_ttm_helper aesni_intel ttm gpu_sched sr_mod cdrom hid_generic usbhid 
i2c_dev autofs4
Dec 15 03:35:01 crashbox kernel: Preemption disabled at:
Dec 15 03:35:01 crashbox kernel: [<ffffffffa4029d4b>] 
optimized_callback+0x1b/0xf0
Dec 15 03:35:01 crashbox kernel: CPU: 10 PID: 144447 Comm: rkhunter Not 
tainted 5.15.8 #4
Dec 15 03:35:01 crashbox kernel: Hardware name: Gigabyte Technology Co., 
Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 03:35:01 crashbox kernel: Call Trace:
Dec 15 03:35:01 crashbox kernel: <TASK>
Dec 15 03:35:01 crashbox kernel: dump_stack_lvl+0x34/0x44
Dec 15 03:35:01 crashbox kernel: ? optimized_callback+0x1b/0xf0
Dec 15 03:35:01 crashbox kernel: __schedule_bug.cold+0x7c/0x8a
Dec 15 03:35:01 crashbox kernel: __schedule+0x5ae/0x7a0
Dec 15 03:35:01 crashbox kernel: schedule+0x3e/0xe0
Dec 15 03:35:01 crashbox kernel: schedule_timeout+0xbb/0xf0
Dec 15 03:35:01 crashbox kernel: ? resched_curr+0x1b/0x60
Dec 15 03:35:01 crashbox kernel: wait_for_completion+0x84/0xe0
Dec 15 03:35:01 crashbox kernel: __flush_work.isra.0+0x15a/0x220
Dec 15 03:35:01 crashbox kernel: ? flush_workqueue_prep_pwqs+0x110/0x110
Dec 15 03:35:01 crashbox kernel: __drain_all_pages+0x15e/0x1b0
Dec 15 03:35:01 crashbox kernel: 
__alloc_pages_slowpath.constprop.0+0x2e1/0xab0
Dec 15 03:35:01 crashbox kernel: __alloc_pages+0x16c/0x1e0
Dec 15 03:35:01 crashbox kernel: cache_alloc_refill+0x23e/0x810
Dec 15 03:35:01 crashbox kernel: kmem_cache_alloc+0x105/0x120
Dec 15 03:35:01 crashbox kernel: p_dump_task_f+0x19/0xf0 [p_lkrg]
Dec 15 03:35:01 crashbox kernel: p_wake_up_new_task_entry+0x6b/0xe0 [p_lkrg]
Dec 15 03:35:01 crashbox kernel: pre_handler_kretprobe+0x8a/0x160
Dec 15 03:35:01 crashbox kernel: opt_pre_handler+0x47/0x80
Dec 15 03:35:01 crashbox kernel: optimized_callback+0xba/0xf0
Dec 15 03:35:01 crashbox kernel: 0xffffffffc037d294
Dec 15 03:35:01 crashbox kernel: ? wake_up_new_task+0x1/0x290
Dec 15 03:35:01 crashbox kernel: ? kernel_clone+0xd6/0x3a0
Dec 15 03:35:01 crashbox kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: ? __do_sys_clone+0x60/0x80
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x5c/0x80
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 03:35:01 crashbox kernel: </TASK>
Dec 15 03:35:01 crashbox kernel: sh: page allocation failure: order:7, 
mode:0x40cc0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
Dec 15 03:35:01 crashbox kernel: CPU: 5 PID: 144452 Comm: sh Tainted: G 
       W         5.15.8 #4
Dec 15 03:35:01 crashbox kernel: Hardware name: Gigabyte Technology Co., 
Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 03:35:01 crashbox kernel: Call Trace:
Dec 15 03:35:01 crashbox kernel: <TASK>
Dec 15 03:35:01 crashbox kernel: dump_stack_lvl+0x34/0x44
Dec 15 03:35:01 crashbox kernel: warn_alloc.cold+0x6f/0xd3
Dec 15 03:35:01 crashbox kernel: ? __alloc_pages_direct_compact+0x114/0x1b0
Dec 15 03:35:01 crashbox kernel: 
__alloc_pages_slowpath.constprop.0+0x71b/0xab0
Dec 15 03:35:01 crashbox kernel: __alloc_pages+0x16c/0x1e0
Dec 15 03:35:01 crashbox kernel: cache_alloc_refill+0x23e/0x810
Dec 15 03:35:01 crashbox kernel: kmem_cache_alloc+0x105/0x120
Dec 15 03:35:01 crashbox kernel: p_dump_task_f+0x19/0xf0 [p_lkrg]
Dec 15 03:35:01 crashbox kernel: p_wake_up_new_task_entry+0x6b/0xe0 [p_lkrg]
Dec 15 03:35:01 crashbox kernel: pre_handler_kretprobe+0x8a/0x160
Dec 15 03:35:01 crashbox kernel: opt_pre_handler+0x47/0x80
Dec 15 03:35:01 crashbox kernel: optimized_callback+0xba/0xf0
Dec 15 03:35:01 crashbox kernel: 0xffffffffc037d294
Dec 15 03:35:01 crashbox kernel: ? wake_up_new_task+0x1/0x290
Dec 15 03:35:01 crashbox kernel: ? kernel_clone+0xd6/0x3a0
Dec 15 03:35:01 crashbox kernel: ? __do_sys_clone+0x60/0x80
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x5c/0x80
Dec 15 03:35:01 crashbox kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 03:35:01 crashbox kernel: </TASK>
Dec 15 03:35:01 crashbox kernel: Mem-Info:
Dec 15 03:35:01 crashbox kernel: active_anon:1491 inactive_anon:544373 
isolated_anon:0#012 active_file:2682203 inactive_file:4287582 
isolated_file:0#012 unevictable:6162 dirty:11 writeback:0#012 
slab_reclaimable:102841 slab_unreclaimable:133000#012 mapped:135781 
shmem:26838 pagetables:6608 bounce:0#012 kernel_misc_reclaimable:0#012 
free:100245 free_pcp:1134 free_cma:0
Dec 15 03:35:01 crashbox kernel: Node 0 active_anon:5964kB 
inactive_anon:2177492kB active_file:10728812kB inactive_file:17150328kB 
unevictable:24648kB isolated(anon):0kB isolated(file):0kB 
mapped:543124kB dirty:44kB writeback:0kB shmem:107352kB shmem_thp: 0kB 
shmem_pmdmapped: 0kB anon_thp: 1249280kB writeback_tmp:0kB 
kernel_stack:17936kB pagetables:26432kB all_unreclaimable? no
Dec 15 03:35:01 crashbox kernel: DMA free:15360kB min:32kB low:44kB 
high:56kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB 
active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB 
present:15984kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB 
local_pcp:0kB free_cma:0kB
Dec 15 03:35:01 crashbox kernel: lowmem_reserve[]: 0 2443 31598 31598
Dec 15 03:35:01 crashbox kernel: DMA32 free:122028kB min:5012kB 
low:7404kB high:9796kB reserved_highatomic:0KB active_anon:0kB 
inactive_anon:15884kB active_file:637304kB inactive_file:1722708kB 
unevictable:0kB writepending:0kB present:2502164kB managed:2502164kB 
mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
Dec 15 03:35:01 crashbox kernel: lowmem_reserve[]: 0 0 29155 29155
Dec 15 03:35:01 crashbox kernel: Normal free:263592kB min:62536kB 
low:92384kB high:122232kB reserved_highatomic:0KB active_anon:5964kB 
inactive_anon:2162336kB active_file:10092024kB inactive_file:15427852kB 
unevictable:24648kB writepending:44kB present:30379008kB 
managed:29854884kB mlocked:24648kB bounce:0kB free_pcp:4536kB 
local_pcp:28kB free_cma:0kB
Dec 15 03:35:01 crashbox kernel: lowmem_reserve[]: 0 0 0 0
Dec 15 03:35:01 crashbox kernel: DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 
0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15360kB
Dec 15 03:35:01 crashbox kernel: DMA32: 37*4kB (UME) 49*8kB (UME) 
41*16kB (ME) 12*32kB (E) 6*64kB (UME) 2*128kB (UE) 2*256kB (UM) 3*512kB 
(UM) 3*1024kB (UM) 2*2048kB (UM) 27*4096kB (UME) = 122028kB
Dec 15 03:35:01 crashbox kernel: Normal: 9022*4kB (UME) 5744*8kB (UME) 
2412*16kB (UME) 1225*32kB (UME) 834*64kB (UME) 324*128kB (UME) 37*256kB 
(UME) 0*512kB 0*1024kB 0*2048kB 0*4096kB = 264152kB
Dec 15 03:35:01 crashbox kernel: Node 0 hugepages_total=0 
hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Dec 15 03:35:01 crashbox kernel: 7000181 total pagecache pages
Dec 15 03:35:01 crashbox kernel: 0 pages in swap cache
Dec 15 03:35:01 crashbox kernel: Swap cache stats: add 198, delete 198, 
find 0/0
Dec 15 03:35:01 crashbox kernel: Free swap  = 18870264kB
Dec 15 03:35:01 crashbox kernel: Total swap = 18874360kB
Dec 15 03:35:01 crashbox kernel: 8224289 pages RAM
Dec 15 03:35:01 crashbox kernel: 0 pages HighMem/MovableOnly
Dec 15 03:35:01 crashbox kernel: 131187 pages reserved
Dec 15 03:35:01 crashbox kernel: [p_lkrg] p_alloc_ed_pids() returned 
NULL for pid 144454 :(
Dec 15 03:35:01 crashbox kernel: [p_lkrg] <Exploit Detection> Error[-1] 
when trying to add process[144454 |sh] for tracking!
Dec 15 03:35:01 crashbox kernel: ------------[ cut here ]------------
Dec 15 03:35:01 crashbox kernel: DEBUG_LOCKS_WARN_ON(val > preempt_count())
Dec 15 03:35:01 crashbox kernel: WARNING: CPU: 2 PID: 144447 at 
kernel/sched/core.c:5431 preempt_count_sub+0x55/0x90
Dec 15 03:35:01 crashbox kernel: Modules linked in: snd_seq_dummy 
mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 
xt_u32 xt_multiport iptable_filter nf_conntrack_netbios_ns 
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 it87 msr 
ip6table_filter hwmon_vid ip6_tables snd_hda_codec_realtek 
snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg uvcvideo 
videobuf2_vmalloc snd_hda_codec videobuf2_memops snd_usb_audio 
videobuf2_v4l2 snd_hda_core snd_hwdep snd_usbmidi_lib videodev 
snd_rawmidi snd_seq videobuf2_common snd_seq_device cdc_acm lzo_rle 
snd_pcm lzo_compress snd_timer snd i2c_piix4 bfq evdev p_lkrg 
binfmt_misc fuse configfs zram zsmalloc ip_tables x_tables amdgpu 
drm_ttm_helper aesni_intel ttm gpu_sched sr_mod cdrom hid_generic usbhid 
i2c_dev autofs4
Dec 15 03:35:01 crashbox kernel: CPU: 2 PID: 144447 Comm: rkhunter 
Tainted: G        W         5.15.8 #4
Dec 15 03:35:01 crashbox kernel: Hardware name: Gigabyte Technology Co., 
Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 03:35:01 crashbox kernel: RIP: 0010:preempt_count_sub+0x55/0x90
Dec 15 03:35:01 crashbox kernel: Code: 66 f8 5b c3 e8 1c 2e 27 00 85 c0 
74 f6 8b 15 4a 75 06 01 85 d2 75 ec 48 c7 c6 6c 82 e5 a4 48 c7 c7 d9 3a 
e5 a4 e8 0e 9d 6c 00 <0f> 0b c3 84 c0 75 c9 e8 ef 2d 27 00 85 c0 74 c9 
8b 05 1d 75 06 01
Dec 15 03:35:01 crashbox kernel: RSP: 0018:ffff9faf860a7cd0 EFLAGS: 00010286
Dec 15 03:35:01 crashbox kernel: RAX: 0000000000000000 RBX: 
0000000000000d60 RCX: 0000000000000000
Dec 15 03:35:01 crashbox kernel: RDX: 0000000000000001 RSI: 
ffffffffa4e77d5a RDI: 00000000ffffffff
Dec 15 03:35:01 crashbox kernel: RBP: ffff978574cac000 R08: 
ffff978c7e2b0ba8 R09: 00000000ffffdfff
Dec 15 03:35:01 crashbox kernel: R10: ffff978c7dd50000 R11: 
ffff978c7dd50000 R12: 0000000000023442
Dec 15 03:35:01 crashbox kernel: R13: 0000000000000216 R14: 
ffffffffc0491aa0 R15: 0000000000000000
Dec 15 03:35:01 crashbox kernel: FS:  00007fe9e3c51740(0000) 
GS:ffff978c7de80000(0000) knlGS:0000000000000000
Dec 15 03:35:01 crashbox kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Dec 15 03:35:01 crashbox kernel: CR2: 00007f130d31d944 CR3: 
00000001cab6a000 CR4: 0000000000750ee0
Dec 15 03:35:01 crashbox kernel: PKRU: 55555554
Dec 15 03:35:01 crashbox kernel: Call Trace:
Dec 15 03:35:01 crashbox kernel: <TASK>
Dec 15 03:35:01 crashbox kernel: _raw_write_unlock_irqrestore+0x16/0x30
Dec 15 03:35:01 crashbox kernel: p_wake_up_new_task_entry+0x8c/0xe0 [p_lkrg]
Dec 15 03:35:01 crashbox kernel: pre_handler_kretprobe+0x8a/0x160
Dec 15 03:35:01 crashbox kernel: opt_pre_handler+0x47/0x80
Dec 15 03:35:01 crashbox kernel: optimized_callback+0xba/0xf0
Dec 15 03:35:01 crashbox kernel: 0xffffffffc037d294
Dec 15 03:35:01 crashbox kernel: ? wake_up_new_task+0x1/0x290
Dec 15 03:35:01 crashbox kernel: ? kernel_clone+0xd6/0x3a0
Dec 15 03:35:01 crashbox kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: ? __do_sys_clone+0x60/0x80
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x5c/0x80
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 03:35:01 crashbox kernel: </TASK>
Dec 15 03:35:01 crashbox kernel: ---[ end trace 8b5601db1943e98c ]---
Dec 15 03:35:01 crashbox kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: rkhunter/144447
Dec 15 03:35:01 crashbox kernel: caller is opt_pre_handler+0x53/0x80
Dec 15 03:35:01 crashbox kernel: CPU: 2 PID: 144447 Comm: rkhunter 
Tainted: G        W         5.15.8 #4
Dec 15 03:35:01 crashbox kernel: Hardware name: Gigabyte Technology Co., 
Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 03:35:01 crashbox kernel: Call Trace:
Dec 15 03:35:01 crashbox kernel: <TASK>
Dec 15 03:35:01 crashbox kernel: dump_stack_lvl+0x34/0x44
Dec 15 03:35:01 crashbox kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 03:35:01 crashbox kernel: opt_pre_handler+0x53/0x80
Dec 15 03:35:01 crashbox kernel: optimized_callback+0xba/0xf0
Dec 15 03:35:01 crashbox kernel: 0xffffffffc037d294
Dec 15 03:35:01 crashbox kernel: ? wake_up_new_task+0x1/0x290
Dec 15 03:35:01 crashbox kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 03:35:01 crashbox kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: ? __do_sys_clone+0x60/0x80
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x5c/0x80
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 03:35:01 crashbox kernel: </TASK>
Dec 15 03:35:01 crashbox kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: rkhunter/144447
Dec 15 03:35:01 crashbox kernel: caller is optimized_callback+0xc6/0xf0
Dec 15 03:35:01 crashbox kernel: CPU: 2 PID: 144447 Comm: rkhunter 
Tainted: G        W         5.15.8 #4
Dec 15 03:35:01 crashbox kernel: Hardware name: Gigabyte Technology Co., 
Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 03:35:01 crashbox kernel: Call Trace:
Dec 15 03:35:01 crashbox kernel: <TASK>
Dec 15 03:35:01 crashbox kernel: dump_stack_lvl+0x34/0x44
Dec 15 03:35:01 crashbox kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 03:35:01 crashbox kernel: optimized_callback+0xc6/0xf0
Dec 15 03:35:01 crashbox kernel: 0xffffffffc037d294
Dec 15 03:35:01 crashbox kernel: ? wake_up_new_task+0x1/0x290
Dec 15 03:35:01 crashbox kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 03:35:01 crashbox kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: ? __do_sys_clone+0x60/0x80
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x5c/0x80
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 03:35:01 crashbox kernel: </TASK>
Dec 15 03:35:01 crashbox kernel: BUG: scheduling while atomic: 
rkhunter/37245/0x00000003
Dec 15 03:35:01 crashbox kernel: Modules linked in: snd_seq_dummy 
mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 
xt_u32 xt_multiport iptable_filter nf_conntrack_netbios_ns 
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state 
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 it87 msr 
ip6table_filter hwmon_vid ip6_tables snd_hda_codec_realtek 
snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg uvcvideo 
videobuf2_vmalloc snd_hda_codec videobuf2_memops snd_usb_audio 
videobuf2_v4l2 snd_hda_core snd_hwdep snd_usbmidi_lib videodev 
snd_rawmidi snd_seq videobuf2_common snd_seq_device cdc_acm lzo_rle 
snd_pcm lzo_compress snd_timer snd i2c_piix4 bfq evdev p_lkrg 
binfmt_misc fuse configfs zram zsmalloc ip_tables x_tables amdgpu 
drm_ttm_helper aesni_intel ttm gpu_sched sr_mod cdrom hid_generic usbhid 
i2c_dev autofs4
Dec 15 03:35:01 crashbox kernel: Preemption disabled at:
Dec 15 03:35:01 crashbox kernel: [<ffffffffa4029d4b>] 
optimized_callback+0x1b/0xf0
Dec 15 03:35:01 crashbox kernel: CPU: 14 PID: 37245 Comm: rkhunter 
Tainted: G        W         5.15.8 #4
Dec 15 03:35:01 crashbox kernel: Hardware name: Gigabyte Technology Co., 
Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 03:35:01 crashbox kernel: Call Trace:
Dec 15 03:35:01 crashbox kernel: <TASK>
Dec 15 03:35:01 crashbox kernel: dump_stack_lvl+0x34/0x44
Dec 15 03:35:01 crashbox kernel: ? optimized_callback+0x1b/0xf0
Dec 15 03:35:01 crashbox kernel: __schedule_bug.cold+0x7c/0x8a
Dec 15 03:35:01 crashbox kernel: __schedule+0x5ae/0x7a0
Dec 15 03:35:01 crashbox kernel: schedule+0x3e/0xe0
Dec 15 03:35:01 crashbox kernel: schedule_timeout+0xbb/0xf0
Dec 15 03:35:01 crashbox kernel: wait_for_completion+0x84/0xe0
Dec 15 03:35:01 crashbox kernel: __flush_work.isra.0+0x15a/0x220
Dec 15 03:35:01 crashbox kernel: ? flush_workqueue_prep_pwqs+0x110/0x110
Dec 15 03:35:01 crashbox kernel: __drain_all_pages+0x15e/0x1b0
Dec 15 03:35:01 crashbox kernel: 
__alloc_pages_slowpath.constprop.0+0x2e1/0xab0
Dec 15 03:35:01 crashbox kernel: __alloc_pages+0x16c/0x1e0
Dec 15 03:35:01 crashbox kernel: cache_alloc_refill+0x23e/0x810
Dec 15 03:35:01 crashbox kernel: kmem_cache_alloc+0x105/0x120
Dec 15 03:35:01 crashbox kernel: p_dump_task_f+0x19/0xf0 [p_lkrg]
Dec 15 03:35:01 crashbox kernel: p_wake_up_new_task_entry+0x6b/0xe0 [p_lkrg]
Dec 15 03:35:01 crashbox kernel: pre_handler_kretprobe+0x8a/0x160
Dec 15 03:35:01 crashbox kernel: opt_pre_handler+0x47/0x80
Dec 15 03:35:01 crashbox kernel: optimized_callback+0xba/0xf0
Dec 15 03:35:01 crashbox kernel: 0xffffffffc037d294
Dec 15 03:35:01 crashbox kernel: ? wake_up_new_task+0x1/0x290
Dec 15 03:35:01 crashbox kernel: ? kernel_clone+0xd6/0x3a0
Dec 15 03:35:01 crashbox kernel: ? __do_sys_clone+0x60/0x80
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x5c/0x80
Dec 15 03:35:01 crashbox kernel: ? syscall_exit_to_user_mode+0x1d/0x40
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: ? preempt_count_add+0x63/0x90
Dec 15 03:35:01 crashbox kernel: ? _raw_spin_lock_irq+0xf/0x30
Dec 15 03:35:01 crashbox kernel: ? _raw_spin_unlock_irq+0xe/0x20
Dec 15 03:35:01 crashbox kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: ? syscall_exit_to_user_mode+0x1d/0x40
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 03:35:01 crashbox kernel: </TASK>
Dec 15 03:35:01 crashbox kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: rkhunter/37245
Dec 15 03:35:01 crashbox kernel: caller is opt_pre_handler+0x53/0x80
Dec 15 03:35:01 crashbox kernel: CPU: 14 PID: 37245 Comm: rkhunter 
Tainted: G        W         5.15.8 #4
Dec 15 03:35:01 crashbox kernel: Hardware name: Gigabyte Technology Co., 
Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 03:35:01 crashbox kernel: Call Trace:
Dec 15 03:35:01 crashbox kernel: <TASK>
Dec 15 03:35:01 crashbox kernel: dump_stack_lvl+0x34/0x44
Dec 15 03:35:01 crashbox kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 03:35:01 crashbox kernel: opt_pre_handler+0x53/0x80
Dec 15 03:35:01 crashbox kernel: optimized_callback+0xba/0xf0
Dec 15 03:35:01 crashbox kernel: 0xffffffffc037d294
Dec 15 03:35:01 crashbox kernel: ? wake_up_new_task+0x1/0x290
Dec 15 03:35:01 crashbox kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 03:35:01 crashbox kernel: ? __do_sys_clone+0x60/0x80
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x5c/0x80
Dec 15 03:35:01 crashbox kernel: ? syscall_exit_to_user_mode+0x1d/0x40
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: ? preempt_count_add+0x63/0x90
Dec 15 03:35:01 crashbox kernel: ? _raw_spin_lock_irq+0xf/0x30
Dec 15 03:35:01 crashbox kernel: ? _raw_spin_unlock_irq+0xe/0x20
Dec 15 03:35:01 crashbox kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: ? syscall_exit_to_user_mode+0x1d/0x40
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 03:35:01 crashbox kernel: </TASK>
Dec 15 03:35:01 crashbox kernel: BUG: using __this_cpu_write() in 
preemptible [00000000] code: rkhunter/37245
Dec 15 03:35:01 crashbox kernel: caller is optimized_callback+0xc6/0xf0
Dec 15 03:35:01 crashbox kernel: CPU: 14 PID: 37245 Comm: rkhunter 
Tainted: G        W         5.15.8 #4
Dec 15 03:35:01 crashbox kernel: Hardware name: Gigabyte Technology Co., 
Ltd. X570 AORUS PRO/X570 AORUS PRO, BIOS F35d 10/13/2021
Dec 15 03:35:01 crashbox kernel: Call Trace:
Dec 15 03:35:01 crashbox kernel: <TASK>
Dec 15 03:35:01 crashbox kernel: dump_stack_lvl+0x34/0x44
Dec 15 03:35:01 crashbox kernel: check_preemption_disabled+0xd8/0xe0
Dec 15 03:35:01 crashbox kernel: optimized_callback+0xc6/0xf0
Dec 15 03:35:01 crashbox kernel: 0xffffffffc037d294
Dec 15 03:35:01 crashbox kernel: ? wake_up_new_task+0x1/0x290
Dec 15 03:35:01 crashbox kernel: ? arch_crash_save_vmcoreinfo+0x90/0x90
Dec 15 03:35:01 crashbox kernel: ? __do_sys_clone+0x60/0x80
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x5c/0x80
Dec 15 03:35:01 crashbox kernel: ? syscall_exit_to_user_mode+0x1d/0x40
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: ? preempt_count_add+0x63/0x90
Dec 15 03:35:01 crashbox kernel: ? _raw_spin_lock_irq+0xf/0x30
Dec 15 03:35:01 crashbox kernel: ? _raw_spin_unlock_irq+0xe/0x20
Dec 15 03:35:01 crashbox kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: ? syscall_exit_to_user_mode+0x1d/0x40
Dec 15 03:35:01 crashbox kernel: ? do_syscall_64+0x69/0x80
Dec 15 03:35:01 crashbox kernel: ? exit_to_user_mode_prepare+0x19/0xf0
Dec 15 03:35:01 crashbox kernel: ? entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 15 03:35:01 crashbox kernel: </TASK>
Dec 15 04:06:39 crashbox ntpd[2120]: NTSc: DNS lookup of pi4.rellim.com 
took 0.001 sec
Dec 15 04:06:39 crashbox ntpd[2120]: NTSc: connecting to 
pi4.rellim.com:4460 => 204.17.205.24:4460
Dec 15 04:06:42 crashbox ntpd[2120]: NTSc: connect_TCP_socket: timeout
