Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2894453F588
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 07:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbiFGFa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 01:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiFGFax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 01:30:53 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472CDAE25F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 22:30:51 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id r82so29245174ybc.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 22:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GWV3sxfyMJZEBiziDcowHuulDeFvGW2+tTyg46kJqN8=;
        b=HGAZXsUHGHGUFGC+p/XmuXoymjVndwcplbPn1j9X7tlSJKdvY3nmRyRq0B1c5/IVK6
         vMQMf12MObSzMUSJsVQqTZER2e0TGfjq7/CjKrAK0/f0AinrhUZfHgh5dzdrbWkxYfbr
         Xa4rUGXOtiCjWgHgsMcSDxu6XfVwzXqXXNrSw3GE+HwVcMhI/KJmUz2OuBSePLcFOKsV
         AcNEpWkOiH7/fGMvzFSV03pg737oKLrs+qnm38jwKSltebl9NVKxkkDSAtIOaQJn0q6h
         lh7fINFNNsuiWbUjKynYt3kZn8lMZWsrji7DMs9zq6is09K4/QeCHQBC3PXQPDLo1GdI
         gn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWV3sxfyMJZEBiziDcowHuulDeFvGW2+tTyg46kJqN8=;
        b=ej137aaXMRJ/FkvfKJovAkkrS2y+Cx/XHIHPfxRCE1T+mZUAnLMlD2eTALYyRGVbkk
         X561tkrqQV/mqkXdNSXEutmGheLekHDVz6oKW+qD9p+i+EzLcLrPvCwYP4doxOeos+M1
         kRk6I4otkJjnqj8nE06q1gKzyIixZm46if2owMlPSseCG6xoyVOd/aLzuKeTuyZG0koW
         CGH/tR+5uashcLdP0dq/K5NtnTAHHsDxN9uxMz0iGupWsTa5PKejQUEiLrgb3m0zzAb/
         X9fUT+q5MF5WFNrCI1r59nlYlkgW0MN6ullHg5dkFSme5QPR1Px3rdnhzquH/WZ8KoFk
         OzbQ==
X-Gm-Message-State: AOAM5315300d0KZsCRebKboWOjmDw2ZXhLREtilhCWLqtBY0HJCYaaRj
        q+AJbKll833OTGBYrx/vcd6rxyxLQ2zyfhgmQr+ydA==
X-Google-Smtp-Source: ABdhPJzECyyoFWVfJwoEwggMZ1+8i0plJckDQVpk9KXZOC2PZNp/x8vDFpOEP9V6LQBk3eOr+M+PdNhBr7P1QzZimn8=
X-Received: by 2002:a25:4705:0:b0:65d:43f8:5652 with SMTP id
 u5-20020a254705000000b0065d43f85652mr27668502yba.389.1654579850250; Mon, 06
 Jun 2022 22:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYv7fESqpGoeKmHoJsst6wfRNMi2wQLGm+PsjbLDuDjdMQ@mail.gmail.com>
In-Reply-To: <CA+G9fYv7fESqpGoeKmHoJsst6wfRNMi2wQLGm+PsjbLDuDjdMQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Jun 2022 11:00:39 +0530
Message-ID: <CA+G9fYsJThWFAxXTbAcJmjshx+oYxVVd+gMM680hS0X1z37+FQ@mail.gmail.com>
Subject: Re: [next] arm64: boot failed - next-20220606
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Raghuram Thammiraju <raghuram.thammiraju@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vasily Averin <vvs@openvz.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022 at 17:16, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Linux next-20220606 arm64 boot failed. The kernel boot log is empty.
> I am bisecting this problem.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> The initial investigation show that,
>
> GOOD: next-20220603
> BAD:  next-20220606
>
> Boot log:
> Starting kernel ...

Linux next-20220606 and next-20220607 arm64 boot failed.
The kernel panic log showing after earlycon.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

[    0.000000] Booting Linux on physical CPU 0x0000000100 [0x410fd033]
[    0.000000] Linux version 5.19.0-rc1-next-20220606
(tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 11.3.0-3) 11.3.0, GNU
ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT @1654490846
[    0.000000] Machine model: ARM Juno development board (r2)
[    0.000000] earlycon: pl11 at MMIO 0x000000007ff80000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] earlycon: pl11 at MMIO 0x000000007ff80000 (options '115200n8')
[    0.000000] ------------[ cut here ]------------
[    0.000000] console 'pl11' already registered
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/printk/printk.c:3327
register_console+0x64/0x2ec
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
5.19.0-rc1-next-20220606 #1
[    0.000000] Hardware name: ARM Juno development board (r2) (DT)
[    0.000000] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : register_console+0x64/0x2ec
[    0.000000] lr : register_console+0x64/0x2ec
[    0.000000] sp : ffff80000a963c80
[    0.000000] x29: ffff80000a963c80 x28: 00000000820a0018 x27: 0000000000000000
[    0.000000] x26: 00000000fef770dc x25: 0000000000000000 x24: ffff80000acbc000
[    0.000000] x23: 0000000000000000 x22: ffff80000a0b1a30 x21: ffff80000ae39250
[    0.000000] x20: 00000000000050cc x19: ffff80000acbc5e0 x18: ffffffffffffffff
[    0.000000] x17: 0000000000ffa000 x16: 00000009ff006000 x15: ffff80008a963957
[    0.000000] x14: 0000000000000000 x13: 6465726574736967 x12: 6572207964616572
[    0.000000] x11: 6c61202731316c70 x10: ffff80000a9ea6a8 x9 : ffff80000a9926a8
[    0.000000] x8 : 00000000ffffefff x7 : ffff80000a9ea6a8 x6 : 0000000000000000
[    0.000000] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
[    0.000000] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff80000a979e00
[    0.000000] Call trace:
[    0.000000]  register_console+0x64/0x2ec
[    0.000000]  of_setup_earlycon+0x254/0x278
[    0.000000]  early_init_dt_scan_chosen_stdout+0x164/0x1a4
[    0.000000]  acpi_boot_table_init+0x1d8/0x218
[    0.000000]  setup_arch+0x28c/0x5f0
[    0.000000]  start_kernel+0xa4/0x748
[    0.000000]  __primary_switched+0xc0/0xc8
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] NUMA: No NUMA configuration found
login-action: exception
#
[    0.000000] NUMA: Faking a #
[login-action] Waiting for messages, (timeout 00:12:59)
node at [mem 0x0000000080000000-0x00000009ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x9fefd5b40-0x9fefd7fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000009ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000feffffff]
[    0.000000]   node   0: [mem 0x0000000880000000-0x00000009ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000009ffffffff]
[    0.000000] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.000000] cma: Reserved 32 MiB at 0x00000000fd000000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] percpu: Embedded 30 pages/cpu s82792 r8192 d31896 u122880
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: ARM erratum 843419
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 2060288
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: console=ttyAMA0,115200n8
root=/dev/nfs rw
nfsroot=10.66.16.125:/var/lib/lava/dispatcher/tmp/5143101/extract-nfsrootfs-i9fmnadt,tcp,hard,vers=3,wsize=65536
earlycon=pl011,0x7ff80000 console_msg_format=syslog earlycon
default_hugepagesz=2M hugepages=256
sky2.mac_address=0x00,0x02,0xF7,0x00,0x67,0x17 ip=dhcp
<6>[    0.000000] HugeTLB: can optimize 7 vmemmap pages for hugepages-2048kB
<6>[    0.000000] Dentry cache hash table entries: 1048576 (order: 11,
8388608 bytes, linear)
<6>[    0.000000] Inode-cache hash table entries: 524288 (order: 10,
4194304 bytes, linear)
<6>[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
<6>[    0.000000] software IO TLB: mapped [mem
0x00000000f9000000-0x00000000fd000000] (64MB)
<6>[    0.000000] Memory: 8062180K/8372224K available (20032K kernel
code, 4884K rwdata, 11148K rodata, 11008K init, 951K bss, 277276K
reserved, 32768K cma-reserved)
<6>[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
<6>[    0.000000] ftrace: allocating 65019 entries in 254 pages
<6>[    0.000000] ftrace: allocated 254 pages with 7 groups
<6>[    0.000000] trace event string verifier disabled
<6>[    0.000000] rcu: Preemptible hierarchical RCU implementation.
<6>[    0.000000] rcu: RCU event tracing is enabled.
<6>[    0.000000] rcu: RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=6.
<6>[    0.000000] Trampoline variant of Tasks RCU enabled.
<6>[    0.000000] Rude variant of Tasks RCU enabled.
<6>[    0.000000] Tracing variant of Tasks RCU enabled.
<6>[    0.000000] rcu: RCU calculated value of scheduler-enlistment
delay is 25 jiffies.
<6>[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
<6>[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
<6>[    0.000000] Root IRQ handler: gic_handle_irq
<6>[    0.000000] GIC: Using split EOI/Deactivate mode
<6>[    0.000000] GICv2m: range[mem 0x2c1c0000-0x2c1cffff], SPI[224:255]
<6>[    0.000000] GICv2m: range[mem 0x2c1d0000-0x2c1dffff], SPI[256:287]
<6>[    0.000000] GICv2m: range[mem 0x2c1e0000-0x2c1effff], SPI[288:319]
<6>[    0.000000] GICv2m: range[mem 0x2c1f0000-0x2c1fffff], SPI[320:351]
<6>[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
<6>[    0.000000] kfence: initialized - using 2097152 bytes for 255
objects at 0x(____ptrval____)-0x(____ptrval____)
<3>[    0.000000] timer_sp804: timer clock not found: -517
<3>[    0.000000] timer_sp804: arm,sp804 clock not found: -2
<3>[    0.000000] Failed to initialize
'/bus@8000000/motherboard-bus@8000000/iofpga-bus@300000000/timer@110000':
-22
<3>[    0.000000] timer_sp804: timer clock not found: -517
<3>[    0.000000] timer_sp804: arm,sp804 clock not found: -2
<3>[    0.000000] Failed to initialize
'/bus@8000000/motherboard-bus@8000000/iofpga-bus@300000000/timer@120000':
-22
<6>[    0.000000] arch_timer: cp15 and mmio timer(s) running at
50.00MHz (phys/phys).
<6>[    0.000000] clocksource: arch_sys_counter: mask:
0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
<6>[    0.000000] sched_clock: 56 bits at 50MHz, resolution 20ns,
wraps every 4398046511100ns
<6>[    0.009801] Console: colour dummy device 80x25
<6>[    0.014654] Calibrating delay loop (skipped), value calculated
using timer frequency.. 100.00 BogoMIPS (lpj=200000)
<6>[    0.025413] pid_max: default: 32768 minimum: 301
<6>[    0.030453] LSM: Security Framework initializing
<1>[    0.035435] Unable to handle kernel paging request at virtual
address fffffe00002bc248
<1>[    0.043654] Mem abort info:
<1>[    0.046719]   ESR = 0x0000000096000004
<1>[    0.050752]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[    0.056355]   SET = 0, FnV = 0
<1>[    0.059683]   EA = 0, S1PTW = 0
<1>[    0.063105]   FSC = 0x04: level 0 translation fault
<1>[    0.068270] Data abort info:
<1>[    0.071421]   ISV = 0, ISS = 0x00000004
<1>[    0.075539]   CM = 0, WnR = 0
<1>[    0.078780] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000082090000
<1>[    0.085778] [fffffe00002bc248] pgd=0000000000000000, p4d=0000000000000000
<0>[    0.092881] Internal error: Oops: 96000004 [#1] PREEMPT SMP
<4>[    0.098730] Modules linked in:
<4>[    0.102054] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
     5.19.0-rc1-next-20220606 #1
<4>[    0.111214] Hardware name: ARM Juno development board (r2) (DT)
<4>[    0.117407] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT
-SSBS BTYPE=--)
<4>[    0.124652] pc : mem_cgroup_from_obj+0x2c/0x120
<4>[    0.129462] lr : register_pernet_operations+0xf0/0x59c
<4>[    0.134878] sp : ffff80000a963d70
<4>[    0.138458] x29: ffff80000a963d70 x28: 00000000820a0018 x27:
0000000000000000
<4>[    0.145886] x26: ffff80000a0c7688 x25: ffff80000a0c7688 x24:
ffff80000ad5e680
<4>[    0.153313] x23: ffff80000a963dd8 x22: ffff80000ad5e818 x21:
ffff80000a979e00
<4>[    0.160739] x20: ffff80000af09740 x19: ffff80000ad5e720 x18:
0000000000000014
<4>[    0.168166] x17: 00000000beabf81a x16: 00000000d8e898a9 x15:
000000005b20ff98
<4>[    0.175594] x14: 00000000032b2301 x13: 00000000c9e39f56 x12:
0000000014288186
<4>[    0.183021] x11: 00000000bcf02680 x10: 000000008d09a8d9 x9 :
ffff800009146254
<4>[    0.190446] x8 : ffff80000a963d48 x7 : 0000000000000000 x6 :
0000000000000002
<4>[    0.197872] x5 : ffff80000a96f000 x4 : fffffc0000000000 x3 :
ffff80000ad5e680
<4>[    0.205299] x2 : fffffe00002bc240 x1 : 00000200002bc240 x0 :
ffff80000af09740
<4>[    0.212726] Call trace:
<4>[    0.215435]  mem_cgroup_from_obj+0x2c/0x120
<4>[    0.219894]  register_pernet_subsys+0x3c/0x60
<4>[    0.224523]  net_ns_init+0xe4/0x13c
<4>[    0.228285]  start_kernel+0x6d4/0x748
<4>[    0.232222]  __primary_switched+0xc0/0xc8
<0>[    0.236513] Code: b25657e4 d34cfc21 d37ae421 8b040022 (f9400443)
<4>[    0.242886] ---[ end trace 0000000000000000 ]---
<0>[    0.247788] Kernel panic - not syncing: Attempted to kill the idle task!
<0>[    0.254772] ---[ end Kernel panic - not syncing: Attempted to
kill the idle task! ]---





>
> The recent changes show,
>
> # git log --oneline  next-20220603..next-20220606  -- arch/arm64/
> 202693ac55e0 (origin/akpm-base, origin/akpm) Merge branch
> 'mm-everything' of
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> a83bdd6800e3 Merge branch 'rust-next' of
> https://github.com/Rust-for-Linux/linux.git
> 9daba6cb8145 Merge branch 'for-next' of git://github.com/Xilinx/linux-xlnx.git
> 582d5ed4caf7 Merge branch 'master' of
> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
> 1ec6574a3c0a Merge tag 'kthread-cleanups-for-v5.19' of
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
> 21873bd66b6e Merge tag 'arm64-fixes' of
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> a8fc46f5a417 mm: avoid unnecessary page fault retires on shared memory types
> 3c59c47d1a6d arm64: Change elfcore for_each_mte_vma() to use VMA iterator
> 1c826fa748d5 arm64: remove mmap linked list from vdso
> 54c2cc79194c Merge tag 'usb-5.19-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> 09a018176ba2 Merge tag 'arm-late-5.19' of
> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> 96479c09803b Merge tag 'arm-multiplatform-5.19-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
>
>
> Test job link,
> https://lkft.validation.linaro.org/scheduler/job/5136989#L560
>
>
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: 40b58e42584bf5bd9230481dc8946f714fb387de
>   git_describe: next-20220606
>   kernel_version: 5.19.0-rc1
>   kernel-config: https://builds.tuxbuild.com/2ABl8X9kHAAU5MlL3E3xExHFrNy/config
>   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/556237413
>   artifact-location: https://builds.tuxbuild.com/2ABl8X9kHAAU5MlL3E3xExHFrNy
>
>

 --
 Linaro LKFT
 https://lkft.linaro.org
