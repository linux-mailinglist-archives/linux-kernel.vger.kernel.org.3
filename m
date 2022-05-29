Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6485372FE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 01:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiE2XrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 19:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiE2XrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 19:47:11 -0400
Received: from sonic315-10.consmr.mail.gq1.yahoo.com (sonic315-10.consmr.mail.gq1.yahoo.com [98.137.65.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A657B50E0E
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 16:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1653868027; bh=PeXSjuSora5gIbODMfCAvFcIo/J8uoJY9VnvIh9vQY4=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=gCZnXgbjcKyrNhIZZikBQU4CQBsL7KBqhITEu8eCZ2pGOHCmnk7jIUL49Xebz7+/345izA6C8Y8DdpIDVmOgjz2B0jL9LGlftAcxNkDN3MM7f/m+4hfVT33q0LIh5pKQQCXh/fat3tLLB89jdWbXaPu+tnFrG6qeXZ2f01i/wLs=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653868027; bh=ErZM8mSj+BJUv7Y6PtsFyA+L+WJ/J6Fwc6TbnU3wue3=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=WcgykPNfq56kDbruHUy9+kZtLME8tWNO9b9yZgQIRddx8VVuAljkiEU+ktfvNecWIvJbcYYKAxOY0zMwUlwGofnI61bRDjr7J5Q8UDL+VyAyw3ogKgz7C8040pbb6Y/xBlp9MoGpBuP2FmI1Xl5Kt8i1Qoa4IWQPkbUWkApYh8hkOxwHyaqMpCqlrLMSD6JEd0gGySvMsVNKjjFTggU48OTnxnN2rnjUvAoVwStK6jNkxw2Yw2f2CFgZUrF4zNbyT2TbKFhEOaVs5w1Zhz494uZ7gXH1qunoLQ44JFFKjKITYhA9XATdIC7liPBi89D2VwN79p474Myi/B1F4LuYGw==
X-YMail-OSG: hh1MzKQVM1mClwnS4zNJCNBDDVLphhg9ScNX9__VOLedN_5DkMz0JNYSdGcYaAT
 CkZffZwTT9o5PMA0kPILCvGnvalOdvMzI5kuXCiI31_AH0I.3StNrfcK.uzlQoHSNpBekBcKU3V_
 nNq.j6Jr9m8guZl4BVQBrjpouYxi45WdGvrOgm6L.cd3Yz8CMjP0eIJRC_6oAr58nHfEqc9jUo8d
 LxjGD.HYJ4kJJdYRraPq2d8pSxtKWrtZtVCmX_WomGunkdfNVj5TZp9HCXj2CQU7yXA0aP1l.sdM
 XbHfYVY6282FNwpCrOLE_Oy9JOmumr7LSSHnfXkTJL.EBKovhLEhAgndTEYR3HDUn8l1Mz0fJQJU
 C6h0BbBP7.EG7x9h7V_rKeuEFpA5vft4XlaFt3QNUctFcGCWyfzzqo8tKsj9XPoellEXKJCVcR1_
 6qwe9rfh6nKdDIEMjm_XEYL0DKk1QPyfNcjmXW_hZYIRTFmmXxzrkp.jGyW0_51Tf_7Kv4bwvkLy
 .HGNP3BZJzKnEFvE8bMfulY6KSJhYcTFHpCAifT8qQ_xlm92qT2pq0a3sKNQoPFvVTvhP1AMstQL
 GR9u8A8mApfmPrW_kVAhvVzWnKA9Y46rpalAbaTEapOPIDTGaeIZyDoxWvwT3jYbZ1dPdnTRSh8b
 EQ5pYeQuaVS12hn3tAzqkqIyyJ0KzHlGkcxC.CTCGKKA8D6tKW_Mz5Ev9sMNq.bOuwq7j7QXuIoo
 .GLqvR5.k2JUuNByOG5_oSAz4P46LdCLK5zlgW5Zf41jfD05IeKCMIb67P8hoa_qNm8ALrmxMQYW
 EjxP8yfiauUrvQNiNYQQsveIIca4gbbSrzR1da19KXRgMfJm0o2nvSe.knSVaqSSa5EMMydV4zKL
 awuWFmI1ZYBAYfPvFwYVeWnZQQn_M9lR2bIp3tOgryqvonyLKI3McSKpBIjo_hC_WifUC8BRpu3I
 Nph2EeNdGz8XdbXSmW7q6MYWGlGuCLo9m0Zawj032tG6SddJE8r0pozM9UwOqT7RdjLmiYOZHSW2
 ffM639YWGjLcXAOBhNm2ieXUEid.zI5id5LB5pe_C0zQkqj7nIQlaf.JWoEx4QLSuF6U1se8ZyvQ
 vkGObUf5zlCuVTt5IkQfte1b6FWwGhun_B3tx69Nk334Oo6i.6ll15y7F2izR4xjKVyxv.HGgjYZ
 wkiNQM318_LVBX1R9GM9cV5TKe3ppXXm8VoYY4TWQ3NulH8ZeaIM2Bqlrbu1pTC6nUHvLHwCPK.7
 .hfkegfeSXFAEt1oKyR6tK2Naguo0P5XLdEqQf5P4BBRZi4qrUiMvvtVotrWcmoogw0mfEOH0ldk
 6Z5Q1R0rEiwxB7.G.f_ClNjJv0obrP63yjE8lCMQ6m3KuCdXnVgMwf2XOx95g122fHtgz0bIIOrg
 ij7wUvNkCe8yKDSnJ.M2yffV..3k8Hu8HfbUcUX.lc7VwKwqO_uIPEBSLsKwgRsTzbqCzT1heyNc
 dypyEyN5eCMM5YGTDQBZla.OUSyiNTdogl.uUrT4N5F2ktCyMUPT2syoFW8Pzx1RJSzX.uhzXNig
 VJr6aANIhY7XY4iEZ5QkJpFp_V0P3gwqpBGsJd2GLcKBsk5ondTWoin4u5PGiEsfkrDGKWu_1pE9
 XiG8naln.FWGh2rBZWwWxCLAejkumCdTtBzA3pZElHEp6v1vflmGrPvIHc7cby37GPiJhEQMmTIt
 ZZuy1LCcycafJto2st2rq3haQUTmgmDBb5ASRiS_SQ4gHpf8Izvn9hCTrwwQmpg15OIgheBNH0jV
 w_YCQq8dD5jBWUamaUNZTLEctv81XOfAOAvm7RVvRvZDrzIfBdwPJ8EYTiyDKvjkPvJNli3QNGi6
 zu_jt5JJ1.nesArxCFCCC4ZrqN4gTYcJleLUZah5Y1xlFMoUrjZPHYtX6MwYuVafItAtBoP.wIKC
 11Sfjwn.oclnJtHM.7182OKDBlfWsEJ.sYECOVOSMfTATZgTCYmLhm2qESrQ1FDR.zywl9Gukf30
 D.ESzL3j3ZwM84FCRyiBjP10G3.lIPsOp2crMvV6dStFtRWqhqafllQJWvjWwKWnOy5QjTR6VRv5
 XhcdQYZu0bXUdA5ZdgwFujDxmsbq5I9SiBmsBeSCVDQyV.IRr8svvPzqUii2lg4X5QethzF3zf8Z
 qdz0fwqAdsl_4WbJuL77igDIcZWiHSAbqXaDSTNJeJfT7eEbEaQT3Av45yIY17vnowWnjMzWW5Di
 m4iTRZ6bjoPTCa3Sl3CqabtqzcNSpCMs-
X-Sonic-MF: <lesrhorer@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sun, 29 May 2022 23:47:07 +0000
Received: by hermes--canary-production-ne1-799d7bd497-d2s2t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8d0743fc930f8163c9bb28b0e12d8b7e;
          Sun, 29 May 2022 23:47:04 +0000 (UTC)
Message-ID: <8de4e4b7-f741-eb4d-9e11-9b23ba65c21a@att.net>
Date:   Sun, 29 May 2022 18:46:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Module failure on new install of Debian Bullseye
Content-Language: en-US
From:   Leslie Rhorer <lesrhorer@att.net>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
References: <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0.ref@att.net>
 <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0@att.net>
 <7999b7b4-3b58-a9c4-4756-445e54404f0f@csgroup.eu>
 <ba2fb3ff-22dd-d68e-fa99-02de39240f20@infradead.org>
 <3b8f2ed6-11fd-b5a7-5442-7cac90348514@att.net>
In-Reply-To: <3b8f2ed6-11fd-b5a7-5442-7cac90348514@att.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20225 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

     Below is the output of dmesg after removing quite a few of what I 
am certain are unrelated lines:

[    0.000000] Linux version 5.10.0-13-amd64 
(debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-6) 10.2.1 
20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP Debian 
5.10.106-1 (2022-03-17)
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.10.0-13-amd64 
root=UUID=944a307b-8423-4092-8d5c-fa5d0f3b646a ro quiet
[    0.000000] random: get_random_u32 called from 
bsp_init_amd+0x284/0x2c0 with crng_init=0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating 
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 
bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000ba788fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ba789000-0x00000000bafd3fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000bbd46000-0x00000000bc89ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000bc8a0000-0x00000000bca11fff] 
type 20
[    0.000000] BIOS-e820: [mem 0x00000000bca12000-0x00000000bca12fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bcc16000-0x00000000bd042fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bd043000-0x00000000bd7f3fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000bd7f4000-0x00000000bd7fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec20000-0x00000000fec20fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed61000-0x00000000fed70fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fef00000-0x00000000ffffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100001000-0x000000013effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.10 by American Megatrends
[    0.000000] secureboot: Secure boot could not be determined (mode 0)
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: To be filled by O.E.M. To be filled by 
O.E.M./SABERTOOTH 990FX R2.0, BIOS 0803 08/15/2012
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3511.666 MHz processor
[    0.001043] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001046] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.007258] AGP: No AGP bridge found
[    0.007315] last_pfn = 0x13f000 max_arch_pfn = 0x400000000
[    0.007319] MTRR default type: uncachable
[    0.007320] MTRR fixed ranges enabled:
[    0.007321]   00000-9FFFF write-back
[    0.007322]   A0000-BFFFF write-through
[    0.007323]   C0000-CFFFF write-protect
[    0.007324]   D0000-DFFFF uncachable
[    0.007325]   E0000-FFFFF write-protect
[    0.007325] MTRR variable ranges enabled:
[    0.007327]   0 base 000000000000 mask FFFF80000000 write-back
[    0.007328]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.007330]   2 base 0000BD800000 mask FFFFFF800000 uncachable
[    0.007331]   3 base 0000BE000000 mask FFFFFE000000 uncachable
[    0.007331]   4 disabled
[    0.007332]   5 disabled
[    0.007333]   6 disabled
[    0.007333]   7 disabled
[    0.007334] TOM2: 000000013f000000 aka 5104M
[    0.008223] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.008337] e820: update [mem 0xbd800000-0xffffffff] usable ==> reserved
[    0.008343] last_pfn = 0xbd800 max_arch_pfn = 0x400000000
[    0.013004] e820: update [mem 0xae852000-0xae854fff] usable ==> reserved
[    0.013019] Using GB pages for direct mapping
[    0.013683] RAMDISK: [mem 0x3296f000-0x354aefff]
[    0.013799] No NUMA configuration found
[    0.013800] Faking a node at [mem 0x0000000000000000-0x000000013effffff]
[    0.014154] Zone ranges:
[    0.014155]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.014156]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.014158]   Normal   [mem 0x0000000100000000-0x000000013effffff]
[    0.014159]   Device   empty
[    0.014160] Movable zone start for each node
[    0.014163] Early memory node ranges
[    0.014164]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.014165]   node   0: [mem 0x0000000000100000-0x00000000ba788fff]
[    0.014166]   node   0: [mem 0x00000000bca12000-0x00000000bca12fff]
[    0.014167]   node   0: [mem 0x00000000bcc16000-0x00000000bd042fff]
[    0.014168]   node   0: [mem 0x00000000bd7f4000-0x00000000bd7fffff]
[    0.014169]   node   0: [mem 0x0000000100001000-0x000000013effffff]
[    0.014170] Initmem setup node 0 [mem 
0x0000000000001000-0x000000013effffff]
[    0.014172] On node 0 totalpages: 1022817
[    0.014173]   DMA zone: 64 pages used for memmap
[    0.014174]   DMA zone: 26 pages reserved
[    0.014175]   DMA zone: 3999 pages, LIFO batch:0
[    0.014176]   DMA32 zone: 11888 pages used for memmap
[    0.014177]   DMA32 zone: 760771 pages, LIFO batch:63
[    0.014178]   Normal zone: 4032 pages used for memmap
[    0.014179]   Normal zone: 258047 pages, LIFO batch:63
[    0.014182] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.014219] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.022647] On node 0, zone DMA32: 8841 pages in unavailable ranges
[    0.022668] On node 0, zone DMA32: 515 pages in unavailable ranges
[    0.022697] On node 0, zone DMA32: 1969 pages in unavailable ranges
[    0.023601] On node 0, zone Normal: 10241 pages in unavailable ranges
[    0.023656] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.024054] IOAPIC[0]: apic_id 9, version 33, address 0xfec00000, GSI 
0-23
[    0.024057] IOAPIC[1]: apic_id 10, version 33, address 0xfec20000, 
GSI 24-55
[    0.024071] efi_bgrt: Ignoring BGRT: invalid image address
[    0.024123] [mem 0xbd800000-0xfebfffff] available for PCI devices
[    0.024124] Booting paravirtualized kernel on bare hardware
[    0.024127] clocksource: refined-jiffies: mask: 0xffffffff 
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.028358] Built 1 zonelists, mobility grouping on.  Total pages: 
1006807
[    0.028359] Policy zone: Normal
[    0.028361] Kernel command line: BOOT_IMAGE=/vmlinuz-5.10.0-13-amd64 
root=UUID=944a307b-8423-4092-8d5c-fa5d0f3b646a ro quiet
[    0.029102] Dentry cache hash table entries: 524288 (order: 10, 
4194304 bytes, linear)
[    0.029377] Inode-cache hash table entries: 262144 (order: 9, 2097152 
bytes, linear)
[    0.029409] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.040712] AGP: Checking aperture...
[    0.046920] AGP: No AGP bridge found
[    0.046924] AGP: Node 0: aperture [bus addr 0xa4000000-0xa5ffffff] (32MB)
[    0.046925] Aperture pointing to e820 RAM. Ignoring.
[    0.046926] AGP: Your BIOS doesn't leave an aperture memory hole
[    0.046926] AGP: Please enable the IOMMU option in the BIOS setup
[    0.046927] AGP: This costs you 64MB of RAM
[    0.046930] AGP: Mapping aperture over RAM [mem 
0xa4000000-0xa7ffffff] (65536KB)
[    0.061742] ftrace: allocating 36453 entries in 143 pages
[    0.075050] ftrace: allocated 143 pages with 5 groups
[    0.075195] rcu: Hierarchical RCU implementation.
[    0.075197]     Rude variant of Tasks RCU enabled.
[    0.075198]     Tracing variant of Tasks RCU enabled.
[    0.075199] rcu: RCU calculated value of scheduler-enlistment delay 
is 25 jiffies.
[    0.079209] NR_IRQS: 524544, nr_irqs: 1032, preallocated irqs: 16
[    0.079537] Console: colour dummy device 80x25
[    0.079550] printk: console [tty0] enabled
[    0.079638] clocksource: hpet: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 133484873504 ns
[    0.079649] APIC: Switch to symmetric I/O mode setup
[    0.080079] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.099652] clocksource: tsc-early: mask: 0xffffffffffffffff 
max_cycles: 0x329e5d4e4cb, max_idle_ns: 440795250690 ns
[    0.099655] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 7023.33 BogoMIPS (lpj=14046664)
[    0.099657] pid_max: default: 32768 minimum: 301
[    0.107532] LSM: Security Framework initializing
[    0.107542] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.107572] AppArmor: AppArmor initialized
[    0.107574] TOMOYO Linux initialized
[    0.107601] Mount-cache hash table entries: 8192 (order: 4, 65536 
bytes, linear)
[    0.107614] Mountpoint-cache hash table entries: 8192 (order: 4, 
65536 bytes, linear)
[    0.107871] LVT offset 1 assigned for vector 0xf9
[    0.107876] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.107877] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.107880] Spectre V1 : Mitigation: usercopy/swapgs barriers and 
__user pointer sanitization
[    0.107881] Spectre V2 : Mitigation: Retpolines
[    0.107882] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling 
RSB on context switch
[    0.107883] Speculative Store Bypass: Mitigation: Speculative Store 
Bypass disabled via prctl and seccomp
[    0.108001] Freeing SMP alternatives memory: 32K
[    0.223653] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.223653] ... version:                0
[    0.223653] ... bit width:              48
[    0.223653] ... generic registers:      6
[    0.223653] ... value mask:             0000ffffffffffff
[    0.223653] ... max period:             00007fffffffffff
[    0.223653] ... fixed-purpose events:   0
[    0.223653] ... event mask:             000000000000003f
[    0.223653] rcu: Hierarchical SRCU implementation.
[    0.223653] NMI watchdog: Enabled. Permanently consumes one hw-PMU 
counter.
[    0.223653] x86: Booting SMP configuration:
[    0.239706] smpboot: Max logical packages: 1
[    0.239706] smpboot: Total of 8 processors activated (56186.65 BogoMIPS)
[    0.249291] node 0 deferred pages initialised in 0ms
[    0.249293] devtmpfs: initialized
[    0.249293] x86/mm: Memory block size: 128MB
[    0.249293] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.249293] futex hash table entries: 2048 (order: 5, 131072 bytes, 
linear)
[    0.249293] pinctrl core: initialized pinctrl subsystem
[    0.249293] NET: Registered protocol family 16
[    0.249293] audit: initializing netlink subsys (disabled)
[    0.249317] audit: type=2000 audit(1653791021.168:1): 
state=initialized audit_enabled=0 res=1
[    0.249317] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 
0xe0000000-0xefffffff] (base 0xe0000000)
[    0.249317] PCI: not using MMCONFIG
[    0.249317] PCI: Using configuration type 1 for base access
[    0.249317] PCI: Using configuration type 1 for extended access
[    0.252299] Kprobes globally optimized
[    0.252304] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.252304] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.425403] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 
0xe0000000-0xefffffff] (base 0xe0000000)
[    0.431325] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM 
ClockPM Segments MSI HPX-Type3]
[    0.431607] PCI host bridge to bus 0000:00
[    0.431609] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.431610] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.431611] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.431612] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.431614] pci_bus 0000:00: root bus resource [mem 
0x000a0000-0x000bffff window]
[    0.431615] pci_bus 0000:00: root bus resource [mem 
0x000c0000-0x000dffff window]
[    0.431616] pci_bus 0000:00: root bus resource [mem 
0xc0000000-0xffffffff window]
[    0.431617] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.431629] pci 0000:00:00.0: [1002:5a14] type 00 class 0x060000
[    0.431755] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
[    0.431771] pci 0000:00:02.0: enabling Extended Tags
[    0.431793] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.431881] pci 0000:00:04.0: [1002:5a18] type 01 class 0x060400
[    0.431896] pci 0000:00:04.0: enabling Extended Tags
[    0.431917] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.432006] pci 0000:00:05.0: [1002:5a19] type 01 class 0x060400
[    0.432021] pci 0000:00:05.0: enabling Extended Tags
[    0.432042] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
[    0.432129] pci 0000:00:09.0: [1002:5a1c] type 01 class 0x060400
[    0.432144] pci 0000:00:09.0: enabling Extended Tags
[    0.432165] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.432249] pci 0000:00:0a.0: [1002:5a1d] type 01 class 0x060400
[    0.432264] pci 0000:00:0a.0: enabling Extended Tags
[    0.432285] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
[    0.432367] pci 0000:00:0b.0: [1002:5a1f] type 01 class 0x060400
[    0.432383] pci 0000:00:0b.0: enabling Extended Tags
[    0.432403] pci 0000:00:0b.0: PME# supported from D0 D3hot D3cold
[    0.432486] pci 0000:00:0c.0: [1002:5a20] type 01 class 0x060400
[    0.432501] pci 0000:00:0c.0: enabling Extended Tags
[    0.432522] pci 0000:00:0c.0: PME# supported from D0 D3hot D3cold
[    0.432604] pci 0000:00:0d.0: [1002:5a1e] type 01 class 0x060400
[    0.432620] pci 0000:00:0d.0: enabling Extended Tags
[    0.432641] pci 0000:00:0d.0: PME# supported from D0 D3hot D3cold
[    0.432735] pci 0000:00:11.0: [1002:4391] type 00 class 0x010601
[    0.432747] pci 0000:00:11.0: reg 0x10: [io  0xf040-0xf047]
[    0.432754] pci 0000:00:11.0: reg 0x14: [io  0xf030-0xf033]
[    0.432760] pci 0000:00:11.0: reg 0x18: [io  0xf020-0xf027]
[    0.432767] pci 0000:00:11.0: reg 0x1c: [io  0xf010-0xf013]
[    0.432774] pci 0000:00:11.0: reg 0x20: [io  0xf000-0xf00f]
[    0.432780] pci 0000:00:11.0: reg 0x24: [mem 0xfe80b000-0xfe80b3ff]
[    0.432887] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    0.432899] pci 0000:00:12.0: reg 0x10: [mem 0xfe80a000-0xfe80afff]
[    0.433024] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    0.433059] pci 0000:00:12.2: reg 0x10: [mem 0xfe809000-0xfe8090ff]
[    0.433117] pci 0000:00:12.2: supports D1 D2
[    0.433118] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.433202] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    0.433214] pci 0000:00:13.0: reg 0x10: [mem 0xfe808000-0xfe808fff]
[    0.433334] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    0.433346] pci 0000:00:13.2: reg 0x10: [mem 0xfe807000-0xfe8070ff]
[    0.433404] pci 0000:00:13.2: supports D1 D2
[    0.433405] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.433491] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    0.433614] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    0.433628] pci 0000:00:14.2: reg 0x10: [mem 0xfe800000-0xfe803fff 64bit]
[    0.433677] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.433755] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    0.433876] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    0.433980] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
[    0.433991] pci 0000:00:14.5: reg 0x10: [mem 0xfe806000-0xfe806fff]
[    0.434117] pci 0000:00:15.0: [1002:43a0] type 01 class 0x060400
[    0.434145] pci 0000:00:15.0: enabling Extended Tags
[    0.434179] pci 0000:00:15.0: supports D1 D2
[    0.434282] pci 0000:00:15.1: [1002:43a1] type 01 class 0x060400
[    0.434310] pci 0000:00:15.1: enabling Extended Tags
[    0.434345] pci 0000:00:15.1: supports D1 D2
[    0.434437] pci 0000:00:15.2: [1002:43a2] type 01 class 0x060400
[    0.434465] pci 0000:00:15.2: enabling Extended Tags
[    0.434499] pci 0000:00:15.2: supports D1 D2
[    0.434595] pci 0000:00:15.3: [1002:43a3] type 01 class 0x060400
[    0.434623] pci 0000:00:15.3: enabling Extended Tags
[    0.434657] pci 0000:00:15.3: supports D1 D2
[    0.434748] pci 0000:00:16.0: [1002:4397] type 00 class 0x0c0310
[    0.434760] pci 0000:00:16.0: reg 0x10: [mem 0xfe805000-0xfe805fff]
[    0.434880] pci 0000:00:16.2: [1002:4396] type 00 class 0x0c0320
[    0.434892] pci 0000:00:16.2: reg 0x10: [mem 0xfe804000-0xfe8040ff]
[    0.434950] pci 0000:00:16.2: supports D1 D2
[    0.434951] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    0.435036] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    0.435106] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    0.435176] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    0.435243] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    0.435311] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    0.435375] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    0.435636] pci 0000:01:00.0: [1103:2722] type 00 class 0x010400
[    0.435647] pci 0000:01:00.0: reg 0x10: [mem 0xfe740000-0xfe75ffff 64bit]
[    0.435656] pci 0000:01:00.0: reg 0x18: [mem 0xfe700000-0xfe73ffff 64bit]
[    0.435666] pci 0000:01:00.0: reg 0x30: [mem 0xfe760000-0xfe76ffff pref]
[    0.435670] pci 0000:01:00.0: enabling Extended Tags
[    0.435706] pci 0000:01:00.0: supports D1
[    0.435707] pci 0000:01:00.0: PME# supported from D0 D1 D3hot
[    0.435760] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.435764] pci 0000:00:02.0:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.435938] pci 0000:02:00.0: [1b21:0612] type 00 class 0x010601
[    0.435950] pci 0000:02:00.0: reg 0x10: [io  0xe050-0xe057]
[    0.435957] pci 0000:02:00.0: reg 0x14: [io  0xe040-0xe043]
[    0.435963] pci 0000:02:00.0: reg 0x18: [io  0xe030-0xe037]
[    0.435970] pci 0000:02:00.0: reg 0x1c: [io  0xe020-0xe023]
[    0.435977] pci 0000:02:00.0: reg 0x20: [io  0xe000-0xe01f]
[    0.435983] pci 0000:02:00.0: reg 0x24: [mem 0xfe600000-0xfe6001ff]
[    0.436085] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.436088] pci 0000:00:04.0:   bridge window [io  0xe000-0xefff]
[    0.436090] pci 0000:00:04.0:   bridge window [mem 0xfe600000-0xfe6fffff]
[    0.436128] pci 0000:03:00.0: [1b21:0612] type 00 class 0x010601
[    0.436140] pci 0000:03:00.0: reg 0x10: [io  0xd050-0xd057]
[    0.436147] pci 0000:03:00.0: reg 0x14: [io  0xd040-0xd043]
[    0.436153] pci 0000:03:00.0: reg 0x18: [io  0xd030-0xd037]
[    0.436160] pci 0000:03:00.0: reg 0x1c: [io  0xd020-0xd023]
[    0.436167] pci 0000:03:00.0: reg 0x20: [io  0xd000-0xd01f]
[    0.436173] pci 0000:03:00.0: reg 0x24: [mem 0xfe500000-0xfe5001ff]
[    0.436272] pci 0000:00:05.0: PCI bridge to [bus 03]
[    0.436275] pci 0000:00:05.0:   bridge window [io  0xd000-0xdfff]
[    0.436277] pci 0000:00:05.0:   bridge window [mem 0xfe500000-0xfe5fffff]
[    0.436318] pci 0000:04:00.0: [1b21:1042] type 00 class 0x0c0330
[    0.436337] pci 0000:04:00.0: reg 0x10: [mem 0xfe400000-0xfe407fff 64bit]
[    0.436430] pci 0000:04:00.0: PME# supported from D3hot D3cold
[    0.436502] pci 0000:00:09.0: PCI bridge to [bus 04]
[    0.436505] pci 0000:00:09.0:   bridge window [mem 0xfe400000-0xfe4fffff]
[    0.436701] pci 0000:00:0a.0: PCI bridge to [bus 05]
[    0.436862] pci 0000:00:0b.0: PCI bridge to [bus 06]
[    0.437039] pci 0000:07:00.0: [14e4:163d] type 00 class 0x020000
[    0.437053] pci 0000:07:00.0: reg 0x10: [mem 0xd3000000-0xd37fffff 
64bit pref]
[    0.437062] pci 0000:07:00.0: reg 0x18: [mem 0xd2800000-0xd2ffffff 
64bit pref]
[    0.437071] pci 0000:07:00.0: reg 0x20: [mem 0xd3800000-0xd380ffff 
64bit pref]
[    0.437077] pci 0000:07:00.0: reg 0x30: [mem 0xfe300000-0xfe37ffff pref]
[    0.437082] pci 0000:07:00.0: enabling Extended Tags
[    0.437142] pci 0000:07:00.0: PME# supported from D0 D3hot D3cold
[    0.437166] pci 0000:07:00.0: reg 0x1e4: [mem 0xd3810000-0xd3817fff 
64bit pref]
[    0.437167] pci 0000:07:00.0: VF(n) BAR0 space: [mem 
0xd3810000-0xd388ffff 64bit pref] (contains BAR0 for 16 VFs)
[    0.437184] pci 0000:07:00.0: reg 0x1f4: [mem 0xd3890000-0xd3891fff 
64bit pref]
[    0.437186] pci 0000:07:00.0: VF(n) BAR4 space: [mem 
0xd3890000-0xd38affff 64bit pref] (contains BAR4 for 16 VFs)
[    0.437284] pci 0000:00:0c.0: PCI bridge to [bus 07]
[    0.437288] pci 0000:00:0c.0:   bridge window [mem 0xfe300000-0xfe3fffff]
[    0.437290] pci 0000:00:0c.0:   bridge window [mem 
0xd2800000-0xd38fffff 64bit pref]
[    0.437460] pci 0000:08:00.0: [10de:10c3] type 00 class 0x030000
[    0.437470] pci 0000:08:00.0: reg 0x10: [mem 0xfd000000-0xfdffffff]
[    0.437478] pci 0000:08:00.0: reg 0x14: [mem 0xc0000000-0xcfffffff 
64bit pref]
[    0.437486] pci 0000:08:00.0: reg 0x1c: [mem 0xd0000000-0xd1ffffff 
64bit pref]
[    0.437492] pci 0000:08:00.0: reg 0x24: [io  0xc000-0xc07f]
[    0.437498] pci 0000:08:00.0: reg 0x30: [mem 0xfe000000-0xfe07ffff pref]
[    0.437502] pci 0000:08:00.0: enabling Extended Tags
[    0.437513] pci 0000:08:00.0: BAR 3: assigned to efifb
[    0.437567] pci 0000:08:00.0: 8.000 Gb/s available PCIe bandwidth, 
limited by 2.5 GT/s PCIe x4 link at 0000:00:0d.0 (capable of 32.000 Gb/s 
with 2.5 GT/s PCIe x16 link)
[    0.437606] pci 0000:08:00.1: [10de:0be3] type 00 class 0x040300
[    0.437615] pci 0000:08:00.1: reg 0x10: [mem 0xfe080000-0xfe083fff]
[    0.437639] pci 0000:08:00.1: enabling Extended Tags
[    0.437722] pci 0000:00:0d.0: PCI bridge to [bus 08]
[    0.437724] pci 0000:00:0d.0:   bridge window [io  0xc000-0xcfff]
[    0.437726] pci 0000:00:0d.0:   bridge window [mem 0xfd000000-0xfe0fffff]
[    0.437729] pci 0000:00:0d.0:   bridge window [mem 
0xc0000000-0xd1ffffff 64bit pref]
[    0.437737] pci_bus 0000:09: extended config space not accessible
[    0.437786] pci 0000:00:14.4: PCI bridge to [bus 09] (subtractive decode)
[    0.437793] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af 
window] (subtractive decode)
[    0.437794] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 
window] (subtractive decode)
[    0.437795] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df 
window] (subtractive decode)
[    0.437796] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff 
window] (subtractive decode)
[    0.437797] pci 0000:00:14.4:   bridge window [mem 
0x000a0000-0x000bffff window] (subtractive decode)
[    0.437798] pci 0000:00:14.4:   bridge window [mem 
0x000c0000-0x000dffff window] (subtractive decode)
[    0.437799] pci 0000:00:14.4:   bridge window [mem 
0xc0000000-0xffffffff window] (subtractive decode)
[    0.438004] pci 0000:00:15.0: PCI bridge to [bus 0a]
[    0.438065] pci 0000:0b:00.0: [10ec:8168] type 00 class 0x020000
[    0.438083] pci 0000:0b:00.0: reg 0x10: [io  0xb000-0xb0ff]
[    0.438107] pci 0000:0b:00.0: reg 0x18: [mem 0xd3a04000-0xd3a04fff 
64bit pref]
[    0.438122] pci 0000:0b:00.0: reg 0x20: [mem 0xd3a00000-0xd3a03fff 
64bit pref]
[    0.438214] pci 0000:0b:00.0: supports D1 D2
[    0.438215] pci 0000:0b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.438314] pci 0000:00:15.1: PCI bridge to [bus 0b]
[    0.438318] pci 0000:00:15.1:   bridge window [io  0xb000-0xbfff]
[    0.438323] pci 0000:00:15.1:   bridge window [mem 
0xd3a00000-0xd3afffff 64bit pref]
[    0.438376] pci 0000:0c:00.0: [1b21:1042] type 00 class 0x0c0330
[    0.438401] pci 0000:0c:00.0: reg 0x10: [mem 0xfe200000-0xfe207fff 64bit]
[    0.438525] pci 0000:0c:00.0: PME# supported from D3hot D3cold
[    0.438608] pci 0000:00:15.2: PCI bridge to [bus 0c]
[    0.438613] pci 0000:00:15.2:   bridge window [mem 0xfe200000-0xfe2fffff]
[    0.438669] pci 0000:0d:00.0: [1b21:1042] type 00 class 0x0c0330
[    0.438694] pci 0000:0d:00.0: reg 0x10: [mem 0xfe100000-0xfe107fff 64bit]
[    0.438816] pci 0000:0d:00.0: PME# supported from D3hot D3cold
[    0.438897] pci 0000:00:15.3: PCI bridge to [bus 0d]
[    0.438902] pci 0000:00:15.3:   bridge window [mem 0xfe100000-0xfe1fffff]
[    0.439863] iommu: Default domain type: Translated
[    0.439885] pci 0000:08:00.0: vgaarb: setting as boot VGA device
[    0.439885] pci 0000:08:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=io+mem,locks=none
[    0.439885] pci 0000:08:00.0: vgaarb: bridge control possible
[    0.439885] vgaarb: loaded
[    0.439885] Registered efivars operations
[    0.439885] NetLabel: Initializing
[    0.439885] NetLabel:  domain hash size = 128
[    0.439885] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.439885] NetLabel:  unlabeled traffic allowed by default
[    0.446441] PCI: pci_cache_line_size set to 64 bytes
[    0.446509] e820: reserve RAM buffer [mem 0xae852000-0xafffffff]
[    0.446510] e820: reserve RAM buffer [mem 0xba789000-0xbbffffff]
[    0.446511] e820: reserve RAM buffer [mem 0xbca13000-0xbfffffff]
[    0.446512] e820: reserve RAM buffer [mem 0xbd043000-0xbfffffff]
[    0.446514] e820: reserve RAM buffer [mem 0xbd800000-0xbfffffff]
[    0.446515] e820: reserve RAM buffer [mem 0x13f000000-0x13fffffff]
[    0.446531] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.446535] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.447721] clocksource: Switched to clocksource tsc-early
[    0.459792] VFS: Disk quotas dquot_6.6.0
[    0.459807] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[    0.459931] AppArmor: AppArmor Filesystem Enabled
[    0.460062] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.460331] system 00:01: [io  0x040b] has been reserved
[    0.460332] system 00:01: [io  0x04d6] has been reserved
[    0.460334] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.460335] system 00:01: [io  0x0c14] has been reserved
[    0.460336] system 00:01: [io  0x0c50-0x0c51] has been reserved
[    0.460338] system 00:01: [io  0x0c52] has been reserved
[    0.460339] system 00:01: [io  0x0c6c] has been reserved
[    0.460340] system 00:01: [io  0x0c6f] has been reserved
[    0.460341] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    0.460342] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    0.460344] system 00:01: [io  0x0cd4-0x0cd5] has been reserved
[    0.460345] system 00:01: [io  0x0cd6-0x0cd7] has been reserved
[    0.460346] system 00:01: [io  0x0cd8-0x0cdf] has been reserved
[    0.460347] system 00:01: [io  0x0800-0x089f] has been reserved
[    0.460349] system 00:01: [io  0x0b20-0x0b3f] has been reserved
[    0.460350] system 00:01: [io  0x0900-0x090f] has been reserved
[    0.460351] system 00:01: [io  0x0910-0x091f] has been reserved
[    0.460352] system 00:01: [io  0xfe00-0xfefe] has been reserved
[    0.460354] system 00:01: [mem 0xfec00000-0xfec00fff] could not be 
reserved
[    0.460356] system 00:01: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.460357] system 00:01: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.460359] system 00:01: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.460361] system 00:01: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.460362] system 00:01: [mem 0xfed00000-0xfed00fff] could not be 
reserved
[    0.460364] system 00:01: [mem 0xff800000-0xffffffff] has been reserved
[    0.460504] system 00:02: [io  0x0290-0x02af] has been reserved
[    0.460595] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.460801] pnp 00:06: [dma 0 disabled]
[    0.461042] system 00:08: [mem 0xfec20000-0xfec200ff] could not be 
reserved
[    0.467314] clocksource: acpi_pm: mask: 0xffffff max_cycles: 
0xffffff, max_idle_ns: 2085701024 ns
[    0.467389] NET: Registered protocol family 2
[    0.467491] IP idents hash table entries: 65536 (order: 7, 524288 
bytes, linear)
[    0.468444] tcp_listen_portaddr_hash hash table entries: 2048 (order: 
3, 32768 bytes, linear)
[    0.468493] TCP established hash table entries: 32768 (order: 6, 
262144 bytes, linear)
[    0.468608] TCP bind hash table entries: 32768 (order: 7, 524288 
bytes, linear)
[    0.468654] TCP: Hash tables configured (established 32768 bind 32768)
[    0.468714] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.468733] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, 
linear)
[    0.468769] NET: Registered protocol family 1
[    0.468777] NET: Registered protocol family 44
[    0.468795] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.468798] pci 0000:00:02.0:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.468802] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.468803] pci 0000:00:04.0:   bridge window [io  0xe000-0xefff]
[    0.468806] pci 0000:00:04.0:   bridge window [mem 0xfe600000-0xfe6fffff]
[    0.468809] pci 0000:00:05.0: PCI bridge to [bus 03]
[    0.468810] pci 0000:00:05.0:   bridge window [io  0xd000-0xdfff]
[    0.468812] pci 0000:00:05.0:   bridge window [mem 0xfe500000-0xfe5fffff]
[    0.468815] pci 0000:00:09.0: PCI bridge to [bus 04]
[    0.468817] pci 0000:00:09.0:   bridge window [mem 0xfe400000-0xfe4fffff]
[    0.468820] pci 0000:00:0a.0: PCI bridge to [bus 05]
[    0.468824] pci 0000:00:0b.0: PCI bridge to [bus 06]
[    0.468828] pci 0000:00:0c.0: PCI bridge to [bus 07]
[    0.468830] pci 0000:00:0c.0:   bridge window [mem 0xfe300000-0xfe3fffff]
[    0.468832] pci 0000:00:0c.0:   bridge window [mem 
0xd2800000-0xd38fffff 64bit pref]
[    0.468834] pci 0000:00:0d.0: PCI bridge to [bus 08]
[    0.468836] pci 0000:00:0d.0:   bridge window [io  0xc000-0xcfff]
[    0.468838] pci 0000:00:0d.0:   bridge window [mem 0xfd000000-0xfe0fffff]
[    0.468839] pci 0000:00:0d.0:   bridge window [mem 
0xc0000000-0xd1ffffff 64bit pref]
[    0.468842] pci 0000:00:14.4: PCI bridge to [bus 09]
[    0.468850] pci 0000:00:15.0: PCI bridge to [bus 0a]
[    0.468857] pci 0000:00:15.1: PCI bridge to [bus 0b]
[    0.468859] pci 0000:00:15.1:   bridge window [io  0xb000-0xbfff]
[    0.468863] pci 0000:00:15.1:   bridge window [mem 
0xd3a00000-0xd3afffff 64bit pref]
[    0.468866] pci 0000:00:15.2: PCI bridge to [bus 0c]
[    0.468869] pci 0000:00:15.2:   bridge window [mem 0xfe200000-0xfe2fffff]
[    0.468874] pci 0000:00:15.3: PCI bridge to [bus 0d]
[    0.468877] pci 0000:00:15.3:   bridge window [mem 0xfe100000-0xfe1fffff]
[    0.468883] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.468884] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.468885] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.468886] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.468887] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff 
window]
[    0.468888] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff 
window]
[    0.468889] pci_bus 0000:00: resource 10 [mem 0xc0000000-0xffffffff 
window]
[    0.468891] pci_bus 0000:01: resource 1 [mem 0xfe700000-0xfe7fffff]
[    0.468892] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
[    0.468893] pci_bus 0000:02: resource 1 [mem 0xfe600000-0xfe6fffff]
[    0.468894] pci_bus 0000:03: resource 0 [io  0xd000-0xdfff]
[    0.468895] pci_bus 0000:03: resource 1 [mem 0xfe500000-0xfe5fffff]
[    0.468896] pci_bus 0000:04: resource 1 [mem 0xfe400000-0xfe4fffff]
[    0.468898] pci_bus 0000:07: resource 1 [mem 0xfe300000-0xfe3fffff]
[    0.468899] pci_bus 0000:07: resource 2 [mem 0xd2800000-0xd38fffff 
64bit pref]
[    0.468900] pci_bus 0000:08: resource 0 [io  0xc000-0xcfff]
[    0.468901] pci_bus 0000:08: resource 1 [mem 0xfd000000-0xfe0fffff]
[    0.468902] pci_bus 0000:08: resource 2 [mem 0xc0000000-0xd1ffffff 
64bit pref]
[    0.468903] pci_bus 0000:09: resource 4 [io  0x0000-0x03af window]
[    0.468904] pci_bus 0000:09: resource 5 [io  0x03e0-0x0cf7 window]
[    0.468905] pci_bus 0000:09: resource 6 [io  0x03b0-0x03df window]
[    0.468906] pci_bus 0000:09: resource 7 [io  0x0d00-0xffff window]
[    0.468907] pci_bus 0000:09: resource 8 [mem 0x000a0000-0x000bffff 
window]
[    0.468909] pci_bus 0000:09: resource 9 [mem 0x000c0000-0x000dffff 
window]
[    0.468910] pci_bus 0000:09: resource 10 [mem 0xc0000000-0xffffffff 
window]
[    0.468911] pci_bus 0000:0b: resource 0 [io  0xb000-0xbfff]
[    0.468912] pci_bus 0000:0b: resource 2 [mem 0xd3a00000-0xd3afffff 
64bit pref]
[    0.468913] pci_bus 0000:0c: resource 1 [mem 0xfe200000-0xfe2fffff]
[    0.468914] pci_bus 0000:0d: resource 1 [mem 0xfe100000-0xfe1fffff]
[    0.551046] pci 0000:08:00.0: Video device with shadowed ROM at [mem 
0x000c0000-0x000dffff]
[    0.551072] pci 0000:08:00.1: D0 power state depends on 0000:08:00.0
[    0.551320] PCI: CLS 64 bytes, default 64
[    0.551366] Trying to unpack rootfs image as initramfs...
[    1.201563] Freeing initrd memory: 44288K
[    1.202141] PCI-DMA: Disabling AGP.
[    1.202206] PCI-DMA: aperture base @ a4000000 size 65536 KB
[    1.202207] PCI-DMA: using GART IOMMU.
[    1.202209] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    1.204959] amd_uncore: 4  amd_nb counters detected
[    1.205145] LVT offset 0 assigned for vector 0x400
[    1.205215] perf: AMD IBS detected (0x000000ff)
[    1.205619] Initialise system trusted keyrings
[    1.205626] Key type blacklist registered
[    1.205693] workingset: timestamp_bits=36 max_order=20 bucket_order=0
[    1.206919] zbud: loaded
[    1.207112] integrity: Platform Keyring initialized
[    1.207114] Key type asymmetric registered
[    1.207115] Asymmetric key parser 'x509' registered
[    1.207162] io scheduler mq-deadline registered
[    1.208510] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.208523] efifb: probing for efifb
[    1.208555] efifb: framebuffer at 0xd1000000, using 3072k, total 3072k
[    1.208556] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    1.208557] efifb: scrolling: redraw
[    1.208558] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.208649] Console: switching to colour frame buffer device 128x48
[    1.212892] fb0: EFI VGA frame buffer device
[    1.213829] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.213953] 00:06: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) 
is a 16550A
[    1.214628] Linux agpgart interface v0.103
[    1.214665] AMD-Vi: AMD IOMMUv2 functionality not available on this 
system - This is not a bug.
[    1.215839] NET: Registered protocol family 10
[    1.222732] Segment Routing with IPv6
[    1.222750] mip6: Mobile IPv6
[    1.222752] NET: Registered protocol family 17
[    1.222795] mpls_gso: MPLS GSO support
[    1.223299] microcode: Microcode Update Driver: v2.2.
[    1.223303] IPI shorthand broadcast: enabled
[    1.223309] sched_clock: Marking stable (1223047001, 
158723)->(1500052192, -276846468)
[    1.223429] registered taskstats version 1
[    1.223432] Loading compiled-in X.509 certificates
[    1.260218] Loaded X.509 cert 'Debian Secure Boot CA: 
6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
[    1.260235] Loaded X.509 cert 'Debian Secure Boot Signer 2021 - 
linux: 4b6ef5abca669825178e052c84667ccbc0531f8c'
[    1.260285] zswap: loaded using pool lzo/zbud
[    1.260491] Key type ._fscrypt registered
[    1.260492] Key type .fscrypt registered
[    1.260493] Key type fscrypt-provisioning registered
[    1.260523] AppArmor: AppArmor sha1 policy hashing enabled
[    1.262489] Freeing unused kernel image (initmem) memory: 2412K
[    1.342202] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.342206] Run /init as init process
[    1.342207]   with arguments:
[    1.342208]     /init
[    1.342209]   with environment:
[    1.342209]     HOME=/
[    1.342210]     TERM=linux
[    1.342210]     BOOT_IMAGE=/vmlinuz-5.10.0-13-amd64
[    1.397501] input: Power Button as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.411773] input: Power Button as 
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.419190] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, 
revision 0
[    1.419197] piix4_smbus 0000:00:14.0: Using register 0x2c for SMBus 
port selection
[    1.419313] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller 
at 0xb20
[    1.420748] r8169 0000:0b:00.0: can't disable ASPM; OS doesn't have 
ASPM control
[    1.433467] r8169 0000:0b:00.0 eth0: RTL8168f/8111f, 
50:46:5d:65:15:9c, XID 480, IRQ 39
[    1.433469] r8169 0000:0b:00.0 eth0: jumbo features [frames: 9194 
bytes, tx checksumming: ko]
[    1.433588] QUIRK: Enable AMD PLL fix
[    1.438896] pps_core: LinuxPPS API ver. 1 registered
[    1.438898] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    1.440290] PTP clock support registered
[    1.458361] r8169 0000:0b:00.0 enp11s0: renamed from eth0
[    1.465675] bnx2x: disagrees about version of symbol module_layout
[    1.549568] MXM: GUID detected in BIOS
[    1.615863] checking generic (d1000000 300000) vs hw (fd000000 1000000)
[    1.615864] checking generic (d1000000 300000) vs hw (c0000000 10000000)
[    1.615865] checking generic (d1000000 300000) vs hw (d0000000 2000000)
[    1.615883] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    1.677057] Console: switching to colour dummy device 80x25
[    1.802818] xhci_hcd 0000:04:00.0: hcc params 0x0200f180 hci version 
0x96 quirks 0x0000000000080000
[    1.803646] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    1.820635] xhci_hcd 0000:0c:00.0: xHCI Host Controller
[    1.927730] xhci_hcd 0000:0c:00.0: hcc params 0x0200f180 hci version 
0x96 quirks 0x0000000000080000
[    1.943842] xhci_hcd 0000:0c:00.0: xHCI Host Controller
[    2.728507] ohci-pci: OHCI PCI platform driver
[    3.516061] xhci_hcd 0000:0d:00.0: xHCI Host Controller
[    3.745927] xhci_hcd 0000:0d:00.0: hcc params 0x0200f180 hci version 
0x96 quirks 0x0000000000080000
[    3.746448] tsc: Refined TSC clocksource calibration: 3511.873 MHz
[    3.746457] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
0x329f211d271, max_idle_ns: 440795246957 ns
[    3.746508] clocksource: Switched to clocksource tsc
[    3.746598] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    3.747158] [TTM] Zone  kernel: Available graphics memory: 1961040 KiB
[    3.747159] [TTM] Initializing pool allocator
[    3.747166] [TTM] Initializing DMA pool allocator
[    3.763216] ohci-pci 0000:00:12.0: irq 18, io mem 0xfe80a000
[    3.763250] xhci_hcd 0000:0d:00.0: xHCI Host Controller
[    3.824063] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    3.824089] ohci-pci 0000:00:13.0: irq 20, io mem 0xfe808000
[    3.846961] Console: switching to colour frame buffer device 170x48
[    3.888123] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    3.888144] ohci-pci 0000:00:14.5: irq 18, io mem 0xfe806000
[    3.952081] ohci-pci 0000:00:16.0: OHCI PCI host controller
[    3.952113] ohci-pci 0000:00:16.0: irq 22, io mem 0xfe805000
[    4.388831] hid: raw HID events driver (C) Jiri Kosina
[    4.751505] random: fast init done
[   10.816509] xor: automatically using best checksumming function   avx
[   10.817149] async_tx: api initialized (async)
[   10.828468] random: crng init done
[   11.413608] PM: Image not found (code -22)
[   11.544183] Not activating Mandatory Access Control as 
/sbin/tomoyo-init does not exist.
[   11.605996] systemd[1]: Inserted module 'autofs4'
[   11.637306] systemd[1]: systemd 247.3-7 running in system mode. (+PAM 
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP 
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD 
+IDN2 -IDN +PCRE2 default-hierarchy=unified)
[   11.659872] systemd[1]: Detected architecture x86-64.
[   11.660225] systemd[1]: Set hostname to <Backup>.
[   11.768173] systemd[1]: 
/lib/systemd/system/plymouth-start.service:16: Unit configured to use 
KillMode=none. This is unsafe, as it disables systemd's process 
lifecycle management for the service. Please update your service to use 
a safer KillMode=, such as 'mixed' or 'control-group'. Support for 
KillMode=none is deprecated and will eventually be removed.
[   11.791051] systemd[1]: Queued start job for default target Graphical 
Interface.
[   11.792183] systemd[1]: Created slice system-getty.slice.
[   11.792404] systemd[1]: Created slice system-modprobe.slice.
[   11.792655] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   11.792820] systemd[1]: Created slice User and Session Slice.
[   11.792873] systemd[1]: Started Forward Password Requests to Wall 
Directory Watch.
[   11.793029] systemd[1]: Set up automount Arbitrary Executable File 
Formats File System Automount Point.
[   11.793091] systemd[1]: Reached target User and Group Name Lookups.
[   11.793102] systemd[1]: Reached target Remote File Systems.
[   11.793111] systemd[1]: Reached target Slices.
[   11.793218] systemd[1]: Listening on Syslog Socket.
[   11.793285] systemd[1]: Listening on fsck to fsckd communication Socket.
[   11.793327] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   11.793440] systemd[1]: Listening on Journal Audit Socket.
[   11.793510] systemd[1]: Listening on Journal Socket (/dev/log).
[   11.793594] systemd[1]: Listening on Journal Socket.
[   11.793841] systemd[1]: Listening on udev Control Socket.
[   11.793913] systemd[1]: Listening on udev Kernel Socket.
[   11.794578] systemd[1]: Mounting Huge Pages File System...
[   11.795318] systemd[1]: Mounting POSIX Message Queue File System...
[   11.796159] systemd[1]: Mounting Kernel Debug File System...
[   11.796945] systemd[1]: Mounting Kernel Trace File System...
[   11.798112] systemd[1]: Starting Set the console keyboard layout...
[   11.798990] systemd[1]: Starting Create list of static device nodes 
for the current kernel...
[   11.799974] systemd[1]: Starting Load Kernel Module configfs...
[   11.800889] systemd[1]: Starting Load Kernel Module drm...
[   11.801846] systemd[1]: Starting Load Kernel Module fuse...
[   11.802390] systemd[1]: Condition check resulted in Set Up Additional 
Binary Formats being skipped.
[   11.802429] systemd[1]: Condition check resulted in File System Check 
on Root Device being skipped.
[   11.804045] systemd[1]: Starting Journal Service...
[   11.805568] systemd[1]: Starting Load Kernel Modules...
[   11.806424] systemd[1]: Starting Remount Root and Kernel File Systems...
[   11.807346] systemd[1]: Starting Coldplug All udev Devices...
[   11.809071] systemd[1]: Mounted Huge Pages File System.
[   11.809187] systemd[1]: Mounted POSIX Message Queue File System.
[   11.809308] systemd[1]: Mounted Kernel Debug File System.
[   11.809413] systemd[1]: Mounted Kernel Trace File System.
[   11.809720] systemd[1]: Finished Create list of static device nodes 
for the current kernel.
[   11.810033] systemd[1]: modprobe@configfs.service: Succeeded.
[   11.810258] systemd[1]: Finished Load Kernel Module configfs.
[   11.810516] systemd[1]: modprobe@drm.service: Succeeded.
[   11.810769] systemd[1]: Finished Load Kernel Module drm.
[   11.811733] systemd[1]: Mounting Kernel Configuration File System...
[   11.813186] fuse: init (API version 7.32)
[   11.814137] systemd[1]: modprobe@fuse.service: Succeeded.
[   11.814348] systemd[1]: Finished Load Kernel Module fuse.
[   11.814473] systemd[1]: Mounted Kernel Configuration File System.
[   11.815284] systemd[1]: Mounting FUSE Control File System...
[   11.817872] systemd[1]: Finished Remount Root and Kernel File Systems.
[   11.818037] systemd[1]: Mounted FUSE Control File System.
[   11.819234] systemd[1]: Condition check resulted in Platform 
Persistent Storage Archival being skipped.
[   11.820051] systemd[1]: Starting Load/Save Random Seed...
[   11.821108] systemd[1]: Starting Create System Users...
[   11.823461] lp: driver loaded but no devices found
[   11.826538] ppdev: user-space parallel port driver
[   11.834836] systemd[1]: Finished Load/Save Random Seed.
[   11.834985] systemd[1]: Condition check resulted in First Boot 
Complete being skipped.
[   11.837125] systemd[1]: Finished Load Kernel Modules.
[   11.837478] systemd[1]: Finished Create System Users.
[   11.838318] systemd[1]: Starting Apply Kernel Variables...
[   11.839128] systemd[1]: Starting Create Static Device Nodes in /dev...
[   11.846814] systemd[1]: Finished Apply Kernel Variables.
[   11.851852] systemd[1]: Finished Create Static Device Nodes in /dev.
[   11.853377] systemd[1]: Starting Rule-based Manager for Device Events 
and Files...
[   11.892490] systemd[1]: Finished Set the console keyboard layout.
[   11.892627] systemd[1]: Reached target Local File Systems (Pre).
[   11.914907] systemd[1]: Started Rule-based Manager for Device Events 
and Files.
[   11.920483] systemd[1]: Finished Coldplug All udev Devices.
[   11.921828] systemd[1]: Starting Helper to synchronize boot up for 
ifupdown...
[   11.922901] systemd[1]: Starting Show Plymouth Boot Screen...
[   11.942248] systemd[1]: Finished Helper to synchronize boot up for 
ifupdown.
[   11.951519] systemd[1]: Started Show Plymouth Boot Screen.
[   11.951644] systemd[1]: Condition check resulted in Dispatch Password 
Requests to Console Directory Watch being skipped.
[   11.951773] systemd[1]: Started Forward Password Requests to Plymouth 
Directory Watch.
[   11.951795] systemd[1]: Reached target Local Encrypted Volumes.
[   11.963476] systemd[1]: Started Journal Service.
[   11.983392] systemd-journald[360]: Received client request to flush 
runtime journal.
[   12.075903] bnx2x: disagrees about version of symbol module_layout
[   12.091742] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[   12.091845] sp5100-tco sp5100-tco: Using 0xfed80b00 for watchdog MMIO 
address
[   12.091927] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec 
(nowayout=0)
[   12.138987] pstore: Using crash dump compression: deflate
[   12.138997] pstore: Registered efi as persistent store backend
[   12.158259] AVX version of gcm_enc/dec engaged.
[   12.158262] AES CTR mode by8 optimization enabled
[   12.166239] asus_wmi: ASUS WMI generic driver loaded
[   12.167334] asus_wmi: Initialization: 0x0
[   12.167367] asus_wmi: BIOS WMI version: 0.9
[   12.167426] asus_wmi: SFUN value: 0x0
[   12.167429] eeepc-wmi eeepc-wmi: Detected ASUSWMI, use DCTS
[   12.168030] input: Eee PC WMI hotkeys as 
/devices/platform/eeepc-wmi/input/input5
[   12.175198] snd_hda_intel 0000:08:00.1: enabling device (0000 -> 0002)
[   12.175237] snd_hda_intel 0000:08:00.1: Disabling MSI
[   12.380349] kvm: Nested Virtualization enabled
[   12.380355] SVM: kvm: Nested Paging enabled
[   12.383000] MCE: In-kernel MCE decoding enabled.
[   12.651813] audit: type=1400 audit(1653791033.935:2): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="lsb_release" pid=679 comm="apparmor_parser"
[   12.652174] audit: type=1400 audit(1653791033.935:3): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="libreoffice-senddoc" pid=675 comm="apparmor_parser"
[   12.652487] audit: type=1400 audit(1653791033.935:4): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="libreoffice-xpdfimport" pid=676 comm="apparmor_parser"
[   12.653514] audit: type=1400 audit(1653791033.935:5): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="libreoffice-oopslash" pid=677 comm="apparmor_parser"
[   12.653933] audit: type=1400 audit(1653791033.935:6): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/sbin/cups-browsed" pid=680 comm="apparmor_parser"
[   12.657835] audit: type=1400 audit(1653791033.939:7): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/lib/x86_64-linux-gnu/lightdm/lightdm-guest-session" pid=682 
comm="apparmor_parser"
[   12.657840] audit: type=1400 audit(1653791033.939:8): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/lib/x86_64-linux-gnu/lightdm/lightdm-guest-session//chromium" 
pid=682 comm="apparmor_parser"
[   12.657904] audit: type=1400 audit(1653791033.939:9): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="nvidia_modprobe" pid=685 comm="apparmor_parser"
[   12.657908] audit: type=1400 audit(1653791033.939:10): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="nvidia_modprobe//kmod" pid=685 comm="apparmor_parser"
[   12.658513] audit: type=1400 audit(1653791033.939:11): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/bin/man" pid=686 comm="apparmor_parser"
[   12.976323] r8169 0000:0b:00.0: firmware: failed to load 
rtl_nic/rtl8168f-1.fw (-2)
[   12.976478] firmware_class: See https://wiki.debian.org/Firmware for 
information about missing firmware
[   12.976632] r8169 0000:0b:00.0: Direct firmware load for 
rtl_nic/rtl8168f-1.fw failed with error -2
[   12.976636] r8169 0000:0b:00.0: Unable to load firmware 
rtl_nic/rtl8168f-1.fw (-2)
[   12.977326] RTL8211E Gigabit Ethernet r8169-0-b00:00: attached PHY 
driver [RTL8211E Gigabit Ethernet] (mii_bus:phy_addr=r8169-0-b00:00, 
irq=IGNORE)
[   13.046445] r8169 0000:0b:00.0 enp11s0: Link is Down
