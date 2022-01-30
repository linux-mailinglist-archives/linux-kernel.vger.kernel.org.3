Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016504A3685
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 14:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354911AbiA3NtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 08:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354900AbiA3NtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 08:49:01 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D981C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 05:49:01 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w14so21553159edd.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 05:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AGYz6OBmnHGOQznfebmxpQAAG7HzOO8VHzFWnj8+684=;
        b=Wklyu3GmuLnWpyMeAmfRGpIj3EOZR+6/uJipQiECcRuY8AwSn9WW0fDNwfh4rG9Bzg
         zJr4AfnScxxW01MkjynqIKapxme1n0PKrIJ1XZZPI3WxkVo2hx5dOYroGXw7wSWEV1Zn
         5OHjMmMj40mZlZ8ZNXQoYjyEJimzMaWLqtWtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AGYz6OBmnHGOQznfebmxpQAAG7HzOO8VHzFWnj8+684=;
        b=ESRv9l+lFguPaQPGJESDyVC4sSzF93HuhKIM9EeJiPRxE7lzVm5d0NwkeMQFeWsoPw
         IKuQPlKY66nxcNeuonR/nPficW2jFvsZ3VtuzKPN+2ufkSJ5pOnWB7CtiWz/WF7Wnjz8
         i/AkdZ7/61WpwdmPuHdL5PMm/PmjgOrkCLAlS7juWFDWX5oUo4syZtmpDT1AaZSLJ3hO
         CpKxinXy2hYLexjy31R4SbcWWIrrWpS9idD9IU6vNQKM7J/A9ANWTtjC7FcuYf7vnDbQ
         K7yQ95kqtdyh6nVgRpaLK7IgzmiyLc5DQHAwR9fCuvJx/eSE/zW5Hqw857+n6xlQReB+
         sq4g==
X-Gm-Message-State: AOAM5332qSw+OwgMS9iytYAs+Az+9QX2bche9EuosE3TGH1fcaOsJcuT
        nI6oTfftVC0SnGATSYDwnm2xx/Z8AQwyVi5m
X-Google-Smtp-Source: ABdhPJzEi0rUhTs+pitihVQQuehkeFx6OpNh8Ej0BT3wW9OA58MLhvYeOPpcZcKsVUVGYPgpqZ7y3A==
X-Received: by 2002:a05:6402:26d6:: with SMTP id x22mr16614055edd.366.1643550539320;
        Sun, 30 Jan 2022 05:48:59 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id b16sm12270061eja.211.2022.01.30.05.48.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 05:48:58 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id v13so20324373wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 05:48:58 -0800 (PST)
X-Received: by 2002:adf:d087:: with SMTP id y7mr13610198wrh.274.1643550538050;
 Sun, 30 Jan 2022 05:48:58 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 30 Jan 2022 15:48:42 +0200
X-Gmail-Original-Message-ID: <CAHk-=wg4NYVVC58vBAD6Hd6MFfY4AG-aAUHtBCYQBcsKz+4XOg@mail.gmail.com>
Message-ID: <CAHk-=wg4NYVVC58vBAD6Hd6MFfY4AG-aAUHtBCYQBcsKz+4XOg@mail.gmail.com>
Subject: Linux 5.17-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another week, another -rc.

Nothing hugely surprising here - it's a bit on the bigger side for
being an rc2, but maybe part of that is that there's a NFS client
merge-window pull request that got merged late due to it having been
marked as spam.

But more likely it's just the usual random fluctuation, with no deeper reas=
on.

The stats are a bit unusual, with drivers being just a third of the
patch. But that's hardly due to the nfs changes - they show up, but
not nearly as much as all the arch updates. There's just a fair amount
of random spread-out architecture fixes - kvm updates for both arm64
and x86, but also misc perf event updates, powerpc and mips updates
etc.

The rest is random other noise - documentation, networking, tooling.
The appended shortlog gives an overview of the details.

Go forth and test, please,

               Linus

---

Alan Stern (2):
      usb-storage: Add unusual-devs entry for VL817 USB-SATA bridge
      USB: core: Fix hang in usb_kill_urb by adding memory barriers

Alex Deucher (3):
      drm/amdgpu: filter out radeon secondary ids as well
      drm/amdgpu/display: adjust msleep limit in
dp_wait_for_training_aux_rd_interval
      drm/amdgpu/display: use msleep rather than udelay for long delays

Amadeusz S=C5=82awi=C5=84ski (1):
      PM: hibernate: Remove register_nosave_region_late()

Amelie Delaunay (1):
      usb: dwc2: gadget: don't try to disable ep0 in dwc2_hsotg_suspend

Amir Goldstein (2):
      fsnotify: invalidate dcache before IN_DELETE event
      fsnotify: fix fsnotify hooks in pseudo filesystems

Andi Kleen (1):
      x86/perf: Avoid warning for Arch LBR without XSAVE

Andrew Morton (1):
      include/linux/sysctl.h: fix register_sysctl_mount_point() return type

Anna Schumaker (1):
      sunrpc: Fix potential race conditions in rpc_sysfs_xprt_state_change(=
)

Anshuman Khandual (6):
      arm64: Add Cortex-X2 CPU part definition
      arm64: errata: Update ARM64_ERRATUM_[2119858|2224489] with
Cortex-X2 ranges
      arm64: Add Cortex-A510 CPU part definition
      arm64: errata: Add detection for TRBE ignored system register writes
      arm64: errata: Add detection for TRBE invalid prohibited states
      arm64: errata: Add detection for TRBE trace data corruption

Ard Biesheuvel (4):
      ARM: 9179/1: uaccess: avoid alignment faults in
copy_[from|to]_kernel_nofault
      ARM: 9180/1: Thumb2: align ALT_UP() sections in modules sufficiently
      irqchip/gic-v3-its: Fix build for !SMP
      efi: runtime: avoid EFIv2 runtime services on Apple x86 machines

Arnaud Pouliquen (1):
      tty: rpmsg: Fix race condition releasing tty port

Athira Rajeev (2):
      powerpc/perf: Only define power_pmu_wants_prompt_pmi() for CONFIG_PPC=
64
      powerpc/perf: Fix power_pmu_disable to call
clear_pmi_irq_pending only if PMI is pending

Badhri Jagan Sridharan (2):
      usb: typec: tcpm: Do not disconnect while receiving VBUS off
      usb: typec: tcpm: Do not disconnect when receiving VSAFE0V

Bartosz Golaszewski (1):
      gpio: sim: check the label length when setting up device properties

Bas Nieuwenhuizen (3):
      drm/amd/display: Fix FP start/end for dcn30_internal_validate_bw.
      drm/amd/display: Wrap dcn301_calculate_wm_and_dlg for FPU.
      drm/amdgpu/display: Remove t_srx_delay_us.

Bjorn Helgaas (1):
      PCI/sysfs: Find shadow ROM before static attribute initialization

Cameron Williams (1):
      tty: Add support for Brainboxes UC cards.

Catherine Sullivan (1):
      gve: Fix GFP flags when allocing pages

Changcheng Deng (1):
      nvme-fabrics: remove the unneeded ret variable in nvmf_dev_show

Christian Borntraeger (2):
      s390/nmi: handle guarded storage validity failures for KVM guests
      s390/nmi: handle vector validity failures for KVM guests

Christophe JAILLET (5):
      irqchip/loongson-pch-ms: Use bitmap_free() to free bitmap
      net: atlantic: Use the bitmap API instead of hand-writing it
      scsi: 3w-sas: Remove useless DMA-32 fallback configuration
      scsi: hisi_sas: Remove useless DMA-32 fallback configuration
      scsi: bfa: Remove useless DMA-32 fallback configuration

Christophe Leroy (4):
      powerpc/audit: Fix syscall_get_arch()
      powerpc/time: Fix build failure due to do_hard_irq_enable() on PPC32
      powerpc/32s: Fix kasan_init_region() for KASAN
      powerpc/fixmap: Fix VM debug warning on unmap

Chuck Lever (3):
      xprtrdma: Remove final dprintk call sites from xprtrdma
      xprtrdma: Remove definitions of RPCDBG_FACILITY
      SUNRPC: Don't dereference xprt->snd_task if it's a cookie

Colin Ian King (1):
      scsi: 53c700: Remove redundant assignment to pointer SCp

Congyu Liu (1):
      net: fix information leakage in /proc/net/ptype

Cruz Zhao (1):
      sched/core: Accounting forceidle time for all tasks except idle task

Dan Carpenter (2):
      hwmon: (adt7470) Prevent divide by zero in adt7470_fan_write()
      counter: fix an IS_ERR() vs NULL bug

Dave Airlie (1):
      Revert "drm/ast: Support 1600x900 with 108MHz PCLK"

David Howells (1):
      rxrpc: Adjust retransmission backoff

David Matlack (1):
      KVM: selftests: Re-enable access_tracking_perf_test

Denis Valeev (1):
      KVM: x86: nSVM: skip eax alignment check for non-SVM instructions

Dylan Yudaken (1):
      io_uring: fix bug in slow unregistering of nodes

Eric Dumazet (6):
      tcp: add a missing sk_defer_free_flush() in tcp_splice_read()
      ipv6: annotate accesses to fn->fn_sernum
      ipv4: raw: lock the socket in raw_bind()
      ipv4: tcp: send zero IPID in SYNACK messages
      ipv4: avoid using shared IP generator for connected sockets
      ipv4: remove sparse error in ip_neigh_gw4()

Eric W. Biederman (1):
      ucount:  Make get_ucount a safe get_user replacement

Evgenii Stepanov (1):
      arm64: extable: fix load_unaligned_zeropad() reg indices

Filipe Manana (5):
      btrfs: fix too long loop when defragging a 1 byte file
      btrfs: allow defrag to be interruptible
      btrfs: fix deadlock when reserving space during defrag
      btrfs: add back missing dirty page rate limiting to defrag
      btrfs: update writeback index when starting defrag

Florian Westphal (2):
      netfilter: nf_conntrack_netbios_ns: fix helper module alias
      netfilter: conntrack: don't increment invalid counter on NF_REPEAT

Frank Li (1):
      usb: xhci-plat: fix crash when suspend if remote wake enable

Gal Pressman (1):
      tcp: Add a stub for sk_defer_free_flush()

Geert Uytterhoeven (3):
      dt-bindings: irqchip: renesas-irqc: Add R-Car V3U support
      dt-bindings: interrupt-controller: sifive,plic: Fix number of interru=
pts
      dt-bindings: interrupt-controller: sifive,plic: Group interrupt tuple=
s

Geetha sowjanya (5):
      octeontx2-af: Retry until RVU block reset complete
      octeontx2-af: cn10k: Use appropriate register for LMAC enable
      octeontx2-pf: cn10k: Ensure valid pointers are freed to aura
      octeontx2-af: Increase link credit restore polling timeout
      octeontx2-af: cn10k: Do not enable RPM loopback for LPC interfaces

Geliang Tang (1):
      mptcp: fix removing ids bitmap setting

Greg Kroah-Hartman (5):
      NFS: use default_groups in kobj_type
      SUNRPC: use default_groups in kobj_type
      PM: wakeup: simplify the output logic of pm_show_wakelocks()
      Revert "tty: serial: Use fifo in 8250 console driver"
      kbuild: remove include/linux/cyclades.h from header file check

Guenter Roeck (8):
      hwmon: (lm90) Reduce maximum conversion rate for G781
      hwmon: (lm90) Re-enable interrupts after alert clears
      hwmon: (lm90) Mark alert as broken for MAX6654
      hwmon: (lm90) Mark alert as broken for MAX6680
      hwmon: (lm90) Mark alert as broken for MAX6646/6647/6649
      hwmon: (lm90) Fix sysfs and udev notifications
      hwmon: (pmbus/ir38064) Mark ir38064_of_match as __maybe_unused
      hwmon: (nct6775) Fix crash in clear_caseopen

Guillaume Nault (1):
      Revert "ipv6: Honor all IPv6 PIO Valid Lifetime values"

Gustavo A. R. Silva (1):
      nfs41: pnfs: filelayout: Replace one-element array with
flexible-array member

Hangbin Liu (1):
      bonding: use rcu_dereference_rtnl when get bonding active slave

Hangyu Hua (1):
      yam: fix a memory leak in yam_siocdevprivate()

Heikki Krogerus (2):
      usb: typec: Only attempt to link USB ports if there is fwnode
      usb: typec: Don't try to register component master without components

Heiko Carstens (2):
      s390/uaccess: fix compile error
      s390: update defconfigs

Horatiu Vultur (2):
      net: lan966x: Fix sleep in atomic context when injecting frames
      net: lan966x: Fix sleep in atomic context when updating MAC table

Hou Wenlong (1):
      KVM: eventfd: Fix false positive RCU usage warning

Hui Su (1):
      kernel/sched: Remove dl_boosted flag comment

Ido Schimmel (1):
      ipv6_tunnel: Rate limit warning messages

Ilya Leoshkevich (2):
      s390/module: fix loading modules with a lot of relocations
      s390/module: test loading modules with a lot of relocations

Jakub Kicinski (10):
      ipv4: fix ip option filtering for locally generated fragments
      net: fec_mpc52xx: don't discard const from netdev->dev_addr
      ethernet: 3com/typhoon: don't write directly to netdev->dev_addr
      ethernet: tundra: don't write directly to netdev->dev_addr
      ethernet: broadcom/sb1250-mac: don't write directly to netdev->dev_ad=
dr
      ethernet: i825xx: don't write directly to netdev->dev_addr
      ethernet: 8390/etherh: don't write directly to netdev->dev_addr
      ethernet: seeq/ether3: don't write directly to netdev->dev_addr
      MAINTAINERS: add more files to eth PHY
      MAINTAINERS: add missing IPv4/IPv6 header paths

James Clark (1):
      perf: Always wake the parent event

James Morse (1):
      arm64: cpufeature: List early Cortex-A510 parts as having broken dbm

Jan Kara (2):
      udf: Fix NULL ptr deref when converting from inline format
      udf: Restore i_lenAlloc when inode expansion fails

Jedrzej Jagielski (2):
      i40e: Increase delay to 1 s after global EMP reset
      i40e: Fix issue when maximum queues is exceeded

Jeff Layton (2):
      ceph: properly put ceph_string reference after async create attempt
      ceph: set pool_ns in new inode layout for async creates

Jianguo Wu (1):
      net-procfs: show net devices bound packet types

Jiapeng Chong (1):
      SUNRPC: clean up some inconsistent indenting

Jim Mattson (1):
      KVM: VMX: Remove vmcs_config.order

Jisheng Zhang (3):
      net: stmmac: remove unused members in struct stmmac_priv
      net: stmmac: reduce unnecessary wakeups from eee sw timer
      net: stmmac: dwmac-sun8i: use return val of readl_poll_timeout()

Joao Martins (1):
      memory-failure: fetch compound_head after pgmap_pfn_valid()

Jochen Mades (1):
      serial: pl011: Fix incorrect rs485 RTS polarity on set_mctrl

Joe Damato (1):
      i40e: fix unsigned stat widths

John Garry (1):
      scsi: pm8001: Fix bogus FW crash for maxcpus=3D1

John Meneghini (1):
      scsi: bnx2fc: Flush destroy_work queue before calling
bnx2fc_interface_put()

Jon Hunter (1):
      usb: common: ulpi: Fix crash in ulpi_match()

Jonathan Corbet (1):
      docs: Hook the RTLA documents into the kernel docs build

Joseph Qi (2):
      jbd2: export jbd2_journal_[grab|put]_journal_head
      ocfs2: fix a deadlock when commit trans

Jos=C3=A9 Exp=C3=B3sito (2):
      drm/msm/dpu: invalid parameter check in dpu_setup_dspp_pcc
      drm/msm/dsi: invalid parameter check in msm_dsi_phy_enable

Justin Iurman (1):
      selftests: net: ioam: expect support for Queue depth data

Kalle Valo (2):
      MAINTAINERS: add common wireless and wireless-next trees
      MAINTAINERS: remove extra wireless section

Kan Liang (2):
      perf/x86/intel: Add a quirk for the calculation of the number of
counters on Alder Lake
      perf/x86/intel/uncore: Add IMC uncore support for ADL

Karen Sornek (1):
      i40e: Fix for failed to init adminq while VF reset

Kees Cook (3):
      mptcp: Use struct_group() to avoid cross-field memset()
      eeprom: at25: Restore missing allocation
      tracing/perf: Avoid -Warray-bounds warning for __rel_loc macro

Kiran Kumar K (1):
      octeontx2-af: Add KPU changes to parse NGIO as separate layer

Kiwoong Kim (2):
      scsi: ufs: Use generic error code in ufshcd_set_dev_pwr_mode()
      scsi: ufs: Treat link loss as fatal error

Laibin Qiu (1):
      blk-mq: Fix wrong wakeup batch configuration which will cause hang

Leo Yan (2):
      pid: Introduce helper task_is_in_init_pid_ns()
      connector/cn_proc: Use task_is_in_init_pid_ns()

Like Xu (3):
      KVM: x86/cpuid: Exclude unpermitted xfeatures sizes at
KVM_GET_SUPPORTED_CPUID
      KVM: x86: Update vCPU's runtime CPUID on write to MSR_IA32_XSS
      KVM: x86: Sync the states size with the XCR0/IA32_XSS at, any time

Linus Torvalds (2):
      ocfs2: fix subdirectory registration with register_sysctl()
      Linux 5.17-rc2

Linyu Yuan (1):
      usb: roles: fix include/linux/usb/role.h compile issue

Lucas Stach (1):
      drm/etnaviv: relax submit size limits

Lukas Wunner (1):
      serial: core: Initialize rs485 RTS polarity already on probe

Maciej W. Rozycki (1):
      tty: Partially revert the removal of the Cyclades public API

Manasi Navare (1):
      drm/atomic: Add the crtc to affected crtc only if uapi.enable =3D tru=
e

Maor Gottlieb (1):
      tools/testing/scatterlist: add missing defines

Marc Kleine-Budde (5):
      mailmap: update email address of Brian Silverman
      dt-bindings: can: tcan4x5x: fix mram-cfg RX FIFO config
      can: m_can: m_can_fifo_{read,write}: don't read or write from/to
FIFO if length is 0
      can: tcan4x5x: regmap: fix max register value
      can: flexcan: mark RX via mailboxes as supported on MCF5441X

Marc Zyngier (5):
      KVM: arm64: pkvm: Use the mm_ops indirection for cache maintenance
      irqchip/apple-aic: Drop unused ipi_hwirq field
      KVM: arm64: vgic-v3: Restrict SEIS workaround to known broken systems
      KVM: arm64: Use shadow SPSR_EL1 when injecting exceptions on !VHE
      irqchip/gic-v3-its: Reset each ITS's BASERn register before probe

Marco Elver (1):
      kasan: test: fix compatibility with FORTIFY_SOURCE

Marek Beh=C3=BAn (2):
      phylib: fix potential use-after-free
      net: sfp: ignore disabled SFP node

Mark Brown (2):
      kselftest/arm64: Skip VL_INHERIT tests for unsupported vector types
      kselftest/arm64: Correct logging of FPSIMD register read via ptrace

Masami Hiramatsu (2):
      arm64: Mark start_backtrace() notrace and NOKPROBE_SYMBOL
      tracing: Avoid -Warray-bounds warning for __rel_loc macro

Mathias Krause (1):
      drm/vmwgfx: Fix stale file descriptors on failed usercopy

Mathieu Desnoyers (1):
      sched/membarrier: Fix membarrier-rseq fence command missing from
query bitmask

Matthias Kaehlcke (1):
      rpmsg: char: Fix race between the release of rpmsg_eptdev and cdev

Maxim Mikityanskiy (1):
      sch_htb: Fail on unsupported parameters when offload is requested

Meenakshikumar Somasundaram (1):
      drm/amd/display: Fix for otg synchronization logic

Menglong Dong (1):
      net: socket: rename SKB_DROP_REASON_SOCKET_FILTER

Miaoqian Lin (3):
      block: fix memory leak in disk_register_independent_access_ranges
      drm/msm/dsi: Fix missing put_device() call in dsi_get_phy
      drm/msm/hdmi: Fix missing put_device() call in msm_hdmi_get_phy

Michael Kelley (1):
      video: hyperv_fb: Fix validation of screen resolution

Mihai Carabas (1):
      efi/libstub: arm64: Fix image check alignment at entry

Mike Snitzer (3):
      block: add bio_start_io_acct_time() to control start_time
      dm: revert partial fix for redundant bio-based IO accounting
      dm: properly fix redundant bio-based IO accounting

Miles Chen (1):
      usb: gadget: at91_udc: fix incorrect print type

Mohammad Athari Bin Ismail (2):
      net: stmmac: configure PTP clock source prior to PTP initialization
      net: stmmac: skip only stmmac_ptp_register when resume from suspend

Moshe Tal (1):
      ethtool: Fix link extended state for big endian

Namhyung Kim (1):
      perf/core: Fix cgroup event list management

Naveen N. Rao (5):
      bpf: Guard against accessing NULL pt_regs in bpf_get_task_stack()
      powerpc32/bpf: Fix codegen for bpf-to-bpf calls
      powerpc/bpf: Update ldimm64 instructions during extra pass
      tools/bpf: Rename 'struct event' to avoid naming conflict
      powerpc64/bpf: Limit 'ldbrx' to processors compliant with ISA v2.06

NeilBrown (3):
      NFS: change nfs_access_get_cached to only report the mask
      NFS: pass cred explicitly for access tests
      NFS: don't store 'struct cred *' in struct nfs_access_entry

Nicholas Piggin (3):
      powerpc/64s: Mask SRR0 before checking against the masked NIP
      KVM: PPC: Book3S HV Nested: Fix nested HFSCR being clobbered
with multiple vCPUs
      powerpc/64s/interrupt: Fix decrementer storm

Nikolay Aleksandrov (1):
      net: bridge: vlan: fix single net device option dumping

Olga Kornievskaia (8):
      NFSv4 only print the label when its queried
      NFSv4 remove zero number of fs_locations entries error check
      NFSv4 store server support for fs_location attribute
      NFSv4.1 query for fs_location attr on a new file system
      NFSv4 expose nfs_parse_server_name function
      NFSv4 handle port presence in fs_location server string
      SUNRPC allow for unspecified transport time in rpc_clnt_add_xprt
      NFSv4.1 test and add 4.1 trunking transport

Pablo Neira Ayuso (3):
      netfilter: nf_tables: remove unused variable
      netfilter: nf_tables: set last expression in register tracking area
      netfilter: nft_connlimit: memleak if nf_ct_netns_get() fails

Padmanabha Srinivasaiah (1):
      drm/vc4: Fix deadlock on DSI device attach error

Pali Roh=C3=A1r (1):
      Documentation: arm: marvell: Extend Avanta list

Paolo Abeni (2):
      mptcp: fix msk traversal in mptcp_nl_cmd_set_flags()
      selftests: mptcp: fix ipv6 routing setup

Paolo Bonzini (3):
      selftests: kvm: move vm_xsave_req_perm call to amx_test
      KVM: x86: add system attribute to retrieve full set of supported
xsave states
      selftests: kvm: check dynamic bits against KVM_X86_XCOMP_GUEST_SUPP

Paul E. McKenney (1):
      rcu-tasks: Fix computation of CPU-to-list shift counts

Paul Menzel (1):
      docs/vm: Fix typo in *harden*

Pavankumar Kondeti (1):
      usb: gadget: f_sourcesink: Fix isoc transfer for USB_SPEED_SUPER_PLUS

Pawel Laszczak (1):
      usb: cdnsp: Fix segmentation fault in cdns_lost_power function

Peter Collingbourne (1):
      mm, kasan: use compare-exchange operation to set KASAN page tag

Peter Zijlstra (3):
      perf: Fix perf_event_read_local() time
      sched: Avoid double preemption in __cond_resched_*lock*()
      x86,kvm/xen: Remove superfluous .fixup usage

Peter Zijlstra (Intel) (2):
      perf/x86/intel/lbr: Support LBR format V7
      perf/x86/intel/lbr: Add static_branch for LBR INFO flags

Pierguido Lambri (1):
      SUNRPC: Add source address/port to rpc_socket* traces

Qu Wenruo (2):
      btrfs: defrag: fix wrong number of defragged sectors
      btrfs: defrag: properly update range->start for autodefrag

Quanfa Fu (1):
      KVM/X86: Make kvm_vcpu_reload_apic_access_page() static

Randy Dunlap (4):
      remoteproc: qcom: q6v5: fix service routines build errors
      sched/fair: Fix all kernel-doc warnings
      gpio: sim: add doc file to index file
      ia64: make IA64_MCA_RECOVERY bool instead of tristate

Raymond Jay Golo (1):
      drm: panel-orientation-quirks: Add quirk for the 1Netbook OneXPlayer

Rob Clark (3):
      drm/msm/a6xx: Add missing suspend_count increment
      drm/msm/gpu: Wait for idle before suspending
      drm/msm/gpu: Cancel idle/boost work on suspend

Robert Hancock (4):
      net: phy: broadcom: hook up soft_reset for BCM54616S
      usb: dwc3: xilinx: Skip resets and USB3 register settings for USB2.0 =
mode
      usb: dwc3: xilinx: Fix error handling when getting USB3 PHY
      serial: 8250: of: Fix mapped region size when using reg-offset proper=
ty

Sander Vanheule (3):
      irqchip/realtek-rtl: Map control data to virq
      irqchip/realtek-rtl: Fix off-by-one in routing
      irqchip/realtek-rtl: Service all pending interrupts

Saurav Kashyap (3):
      scsi: qedf: Add stag_work to all the vports
      scsi: qedf: Fix refcount issue when LOGO is received during TMF
      scsi: qedf: Change context reset messages to ratelimited

Sean Christopherson (16):
      KVM: VMX: Zero host's SYSENTER_ESP iff SYSENTER is NOT used
      KVM: VMX: Set vmcs.PENDING_DBG.BS on #DB in STI/MOVSS blocking shadow
      KVM: SVM: Never reject emulation due to SMAP errata for !SEV guests
      Revert "KVM: SVM: avoid infinite loop on NPF from bad address"
      KVM: SVM: Don't intercept #GP for SEV guests
      KVM: SVM: Explicitly require DECODEASSISTS to enable SEV support
      KVM: x86: Pass emulation type to can_emulate_instruction()
      KVM: SVM: WARN if KVM attempts emulation on #UD or #GP for SEV guests
      KVM: SVM: Inject #UD on attempted emulation for SEV guest w/o insn bu=
ffer
      KVM: SVM: Don't apply SEV+SMAP workaround on code fetch or PT access
      KVM: SVM: Don't kill SEV guest if SMAP erratum triggers in usermode
      KVM: x86: Forcibly leave nested virt when SMM state is toggled
      KVM: selftests: Don't skip L2's VMCALL in SMM test for SVM guest
      KVM: nVMX: WARN on any attempt to allocate shadow VMCS for vmcs02
      KVM: x86: Free kvm_cpuid_entry2 array on post-KVM_RUN KVM_SET_CPUID{,=
2}
      KVM: x86: Add a helper to retrieve userspace address from kvm_device_=
attr

Sergio Paracuellos (2):
      PCI: mt7621: Drop of_match_ptr() to avoid unused variable
      PCI: mt7621: Remove unused function pcie_rmw()

Shuah Khan (2):
      rtla: Make doc build optional
      tools/tracing: Update Makefile to build rtla

Sing-Han Chen (1):
      ucsi_ccg: Check DEV_INT bit only when starting CCG4

Steffen Maier (1):
      scsi: zfcp: Fix failed recovery on gone remote port with
non-NPIV FCP devices

Stephane Eranian (1):
      perf/x86/rapl: fix AMD event handling

Steven Rostedt (Google) (1):
      ftrace: Have architectures opt-in for mcount build time sorting

Subbaraya Sundeep (2):
      octeontx2-af: Do not fixup all VF action entries
      octeontx2-pf: Forward error codes to VF

Sujit Kautkar (1):
      rpmsg: char: Fix race between the release of rpmsg_ctrldev and cdev

Sukadev Bhattiprolu (4):
      ibmvnic: Allow extra failures before disabling
      ibmvnic: init ->running_cap_crqs early
      ibmvnic: don't spin in tasklet
      ibmvnic: remove unused ->wait_capability

Sunil Goutham (1):
      octeontx2-af: Fix LBK backpressure id count

Suren Baghdasaryan (3):
      psi: Fix uaf issue when psi trigger is destroyed while being polled
      psi: fix "no previous prototype" warnings when CONFIG_CGROUPS=3Dn
      psi: fix "defined but not used" warnings when CONFIG_PROC_FS=3Dn

Sylwester Dziedziuch (1):
      i40e: Fix queues reservation for XDP

Takahiro Itazuri (1):
      docs: fix typo in Documentation/kernel-hacking/locking.rst

Thomas Bogendoerfer (2):
      amd: declance: use eth_hw_addr_set()
      MIPS: Fix build error due to PTR used in more places

Thomas Gleixner (1):
      PCI/MSI: Prevent UAF in error path

Tim Yi (1):
      net: bridge: vlan: fix memory leak in __allowed_ingress

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      net: cpsw: Properly initialise struct page_pool_params

Tom Rix (1):
      quota: cleanup double word in comment

Tom Zanussi (4):
      tracing: Fix smatch warning for null glob in event_hist_trigger_parse=
()
      tracing: Fix smatch warning for do while check in
event_hist_trigger_parse()
      tracing: Propagate is_signed to expression
      tracing: Don't inc err_log entry count if entry allocation fails

Tong Zhang (3):
      scsi: myrs: Fix crash in error case
      drm/privacy-screen: honor acpi=3Doff in detect_thinkpad_privacy_scree=
n
      binfmt_misc: fix crash when load/unload module

Tony Luck (1):
      x86/cpu: Add Xeon Icelake-D to list of CPUs that support PPIN

Trond Myklebust (12):
      NFS: Ensure the server has an up to date ctime before hardlinking
      NFS: Ensure the server has an up to date ctime before renaming
      NFSv4.1: Fix uninitialised variable in devicenotify
      NFSv4: Add some support for case insensitive filesystems
      NFSv4: Just don't cache negative dentries on case insensitive servers
      NFS: Invalidate negative dentries on all case insensitive
directory changes
      NFS: Add a helper to remove case-insensitive aliases
      NFS: Fix the verifier for case sensitive filesystem in nfs_atomic_ope=
n()
      NFSv4: Allow writebacks to request 'blocks used'
      NFSv42: Fallocate and clone should also request 'blocks used'
      NFSv4: Handle case where the lookup of a directory fails
      NFSv4: nfs_atomic_open() can race when looking up a non-regular file

Tvrtko Ursulin (1):
      drm/i915: Flush TLBs before releasing backing store

Usama Arif (1):
      io_uring: remove unused argument from io_rsrc_node_alloc

Valentin Caron (2):
      serial: stm32: prevent TDR register overwrite when sending x_char
      serial: stm32: fix software flow control transfer

Vasily Gorbik (1):
      s390/hypfs: include z/VM guests with access control group set

Victor Nogueira (1):
      net: sched: Clarify error message when qdisc kind is unknown

Vincent Guittot (4):
      sched/pelt: Relax the sync of util_sum with util_avg
      sched/pelt: Continue to relax the sync of util_sum with util_avg
      sched/pelt: Relax the sync of runnable_sum with runnable_avg
      sched/pelt: Relax the sync of load_sum with load_avg

Vincenzo Frascino (1):
      arm64: vdso: Fix "no previous prototype" warning

Vitaly Kuznetsov (9):
      KVM: x86: Move CPUID.(EAX=3D0x12,ECX=3D1) mangling to
__kvm_update_cpuid_runtime()
      KVM: SVM: hyper-v: Enable Enlightened MSR-Bitmap support for real
      KVM: SVM: drop unnecessary code in
svm_hv_vmcb_dirty_nested_enlightenments()
      KVM: x86: Check .flags in kvm_cpuid_check_equal() too
      KVM: nVMX: Also filter MSR_IA32_VMX_TRUE_PINBASED_CTLS when eVMCS
      KVM: nVMX: eVMCS: Filter out VM_EXIT_SAVE_VMX_PREEMPTION_TIMER
      KVM: nVMX: Rename vmcs_to_field_offset{,_table}
      KVM: nVMX: Implement evmcs_field_offset() suitable for handle_vmread(=
)
      KVM: nVMX: Allow VMREAD when Enlightened VMCS is in use

Vivek Goyal (1):
      security, lsm: dentry_init_security() Handle multi LSM registration

Wanpeng Li (1):
      KVM: LAPIC: Also cancel preemption timer during SET_LAPIC

Wei Yang (1):
      mm: page->mapping folio->mapping should have the same offset

Wen Gu (1):
      net/smc: Transitional solution for clcsock race issue

Wu Zheng (1):
      nvme-pci: add the IGNORE_DEV_SUBNQN quirk for Intel P4500/P4600 SSDs

Xianting Tian (2):
      KVM: remove async parameter of hva_to_pfn_remapped()
      drm/msm: Fix wrong size calculation

Xiaoke Wang (3):
      nfs: nfs4clinet: check the return value of kstrdup()
      scsi: ufs: ufshcd-pltfrm: Check the return value of devm_kstrdup()
      tracing/histogram: Fix a potential memory leak for kstrdup()

Xiaoyao Li (1):
      KVM: x86: Keep MSR_IA32_XSS unchanged for INIT

Xin Long (1):
      ping: fix the sk_bound_dev_if match in ping_lookup

Xiubo Li (1):
      ceph: put the requests/sessions when it fails to alloc memory

Xiyu Yang (1):
      net/sunrpc: fix reference count leaks in rpc_sysfs_xprt_state_change

Xu Wang (1):
      sunrpc: Remove unneeded null check

Xu Yang (1):
      usb: typec: tcpci: don't touch CC line if it's Vconn source

Yang Li (2):
      fanotify: remove variable set but not used
      drm/msm: remove variable set but not used

Yang Yingliang (1):
      scsi: elx: efct: Don't use GFP_KERNEL under spin lock

Yanming Liu (1):
      Drivers: hv: balloon: account for vmbus packet header in max_pkt_size

Yazen Ghannam (1):
      x86/MCE/AMD: Allow thresholding interface updates after init

Yu Kuai (1):
      blk-mq: fix missing blk_account_io_done() in error path

Yufeng Mo (1):
      net: hns3: handle empty unknown interrupt for VF

Yuji Ishikawa (2):
      net: stmmac: dwmac-visconti: Fix bit definitions for ETHER_CLK_SEL
      net: stmmac: dwmac-visconti: Fix clock configuration for RMII mode

Zhan Liu (2):
      drm/amd/display: Correct MPC split policy for DCN301
      drm/amd/display: change FIFO reset condition to embedded display only

Zhengjun Xing (1):
      perf/x86/intel/uncore: Fix CAS_COUNT_WRITE issue for ICX

Zhou Qingyang (2):
      drm/amd/display/dc/calcs/dce_calcs: Fix a memleak in calculate_bandwi=
dth()
      ata: pata_platform: Fix a NULL pointer dereference in
__pata_platform_probe()

ZouMingzhe (1):
      scsi: target: iscsi: Make sure the np under each tpg is unique

daniel.starke@siemens.com (1):
      tty: n_gsm: fix SW flow control encoding/handling

sparkhuang (1):
      ARM: 9170/1: fix panic when kasan and kprobe are enabled
