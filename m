Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5B547A2B3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbhLSWji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhLSWjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:39:37 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEFEC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 14:39:36 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z5so31032509edd.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 14:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CLcA+lARLCxb30kKd0TE+5tuCnny0gdvyLZOAp4IiDc=;
        b=LaP7q0R65pNAWZYaS2bjH6ons3pvkLPhJ2jUwnBq6g+5jGGMAMBvVO62PYfuhD3eVj
         fedT3AwH/YxJ05y3P4cw8uwgXxO9S/yQpMgpJl+twpqG+TNMnDMor+p7139vs0S2YXaw
         nKU0IOAG3sM5aeeMsbEGuXXkBYQk5TAzeBKjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CLcA+lARLCxb30kKd0TE+5tuCnny0gdvyLZOAp4IiDc=;
        b=1ku4F8PYpy7R0NL1kXkKwOlCFtLuq+X8REfBFN7r4BP82hEZIyoQRKdOLRoc0Ui/OY
         RsZ0w/2GDZI5rpuJns1x0LA+Xx5N4NOEDMHTF2kew66xucQ7u4MAaf4GtUwGveErrst8
         09uym1KMo07vaZbgiKMGAgHBaP0PcwJWsQBbyiRtwuRMO7mG9KriYMhyZ5mK8NXFRwWE
         BbimHhsHs30aTUenZfw/hwvtsJD7Xl0/wuTTNgKpt8HKgq1CxLC9jANjWICM8r8iB4xA
         rV2mt4iQKlJS0rBvBWGKGhbeCoSVmadavIq/waJoto6Wps9g21S9LuKrMtEuBaeP1DX8
         ahqA==
X-Gm-Message-State: AOAM531OvmRHwlvhJ28LPrvnfCZf08OH5FxomYDEGIKZ523KIxRniyZJ
        Ef5LmzcPCj2l6PfONZX2lFHoiUDc2+4HtmgvYrA=
X-Google-Smtp-Source: ABdhPJzHGXsAdTYE9iK9xDUNyr9gQL2ael/bQNvdgBoUaS8tycOMNrCuITO3D6ABKE3gU1BmxTsifQ==
X-Received: by 2002:a17:907:2d07:: with SMTP id gs7mr2857960ejc.130.1639953574810;
        Sun, 19 Dec 2021 14:39:34 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id nd36sm4774118ejc.17.2021.12.19.14.39.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 14:39:34 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id a9so16309595wrr.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 14:39:34 -0800 (PST)
X-Received: by 2002:a5d:6211:: with SMTP id y17mr10724373wru.97.1639953573791;
 Sun, 19 Dec 2021 14:39:33 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Dec 2021 14:39:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgWuZPhK6dgXsS42iMz4o610Uw4QXeUsTSOQheNo1tf5A@mail.gmail.com>
Message-ID: <CAHk-=wgWuZPhK6dgXsS42iMz4o610Uw4QXeUsTSOQheNo1tf5A@mail.gmail.com>
Subject: Linux 5.16-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things are calming down, and rc6 is fairly small. That's normal for
this time in the release schedule, but it's also normal for this time
of year.

And I expect that the next two weeks will be very quiet, and smaller
still. But maybe people are bored, maybe people are staying in due to
covid picking up again, we'll just see.

Regardless of what happens, I will be making an rc8 - not because this
release looks particularly problematic, but simply due to the seasonal
holidays. There's no point in releasing a final 5.16 and opening the
merge window when people are still on holiday or just coming back. So
we'll have at least one extra week of rc this release, even if no
nasty issues appear. And if issues _do_ appear, that can obviously
delay things further, even if that may look unlikely right now.

Anyway, on the rc6 front, most of the changes here are drivers (mainly
networking, usb, and gpu, with some minor noise elsewhere), although
the bpf seltest additions do show up in the diff quite prominently
too.

There's the usual arch updates too.  A good chunk of of those are to
dts files, so maybe they count as driver updates..  But there's some
other small changes in there: x86 kvm fixes, powerpc, s390 and mips
fixes, arm soc fixes etc.

The rest is spread out - filesystems (btrfs, ceph, ciph) and core
kernel (mostly networking).

I know most of us are preparing for Christmas, but give it a whirl,
ok? How important are those presents (and that family) anyway?

Shortlog appended for people who want to scan the details,

               Linus

---

Adam Ford (1):
      soc: imx: imx8m-blk-ctrl: Fix imx8mm mipi reset

Adrian Hunter (2):
      perf inject: Fix segfault due to close without open
      perf inject: Fix segfault due to perf_data__fd() without open

Ahmed Zaki (1):
      mac80211: fix a memory leak where sta_info is not freed

Alejandro Concepcion-Rodriguez (1):
      drm: simpledrm: fix wrong unit with pixel clock

Alex Bee (1):
      arm64: dts: rockchip: fix audio-supply for Rock Pi 4

Alexander Egorenkov (1):
      s390/kexec: handle R_390_PLT32DBL rela in
arch_kexec_apply_relocations_add()

Alexei Starovoitov (3):
      bpf: Fix extable fixup offset.
      bpf: Fix extable address check.
      selftest/bpf: Add a test that reads various addresses.

Alyssa Ross (1):
      dmaengine: st_fdma: fix MODULE_ALIAS

Amelie Delaunay (1):
      usb: dwc2: fix STM ID/VBUS detection startup delay in dwc2_driver_pro=
be

Andrey Eremeev (1):
      dsa: mv88e6xxx: fix debug print for SPEED_UNFORCED

Arnd Bergmann (4):
      iwlwifi: fix LED dependencies
      brcmsmac: rework LED dependencies
      mt76: mt7921: fix build regression
      virtio: always enter drivers/virtio/

Artem Lapkin (1):
      arm64: dts: rockchip: remove mmc-hs400-enhanced-strobe from
rk3399-khadas-edge

Baowen Zheng (1):
      flow_offload: return EOPNOTSUPP for the unsupported mpls action type

Bin Meng (2):
      riscv: dts: unleashed: Add gpio card detect to mmc-spi-slot
      riscv: dts: unmatched: Add gpio card detect to mmc-spi-slot

Chang S. Bae (1):
      signal: Skip the altstack update when not needed

Christian Brauner (1):
      ceph: fix up non-directory creation in SGID directories

Christophe JAILLET (1):
      dmaengine: dw-edma: Fix return value check for dma_set_mask_and_coher=
ent()

Chunfeng Yun (1):
      usb: xhci-mtk: fix list_del warning when enable list debug

Cyril Novikov (1):
      ixgbe: set X550 MDIO speed before talking to PHY

D. Wythe (1):
      net/smc: Prevent smc_release() from long blocking

Damien Le Moal (1):
      MAITAINERS: Change zonefs maintainer email address

Dan Carpenter (5):
      tee: amdtee: fix an IS_ERR() vs NULL bug
      vduse: fix memory corruption in vduse_dev_ioctl()
      vdpa: check that offsets are within bounds
      vduse: check that offset is within bounds in get_config()
      iavf: missing unlocks in iavf_watchdog_task()

Daniel Borkmann (7):
      bpf: Fix kernel address leakage in atomic fetch
      bpf, selftests: Add test case for atomic fetch on spilled pointer
      bpf: Fix kernel address leakage in atomic cmpxchg's r0 aux reg
      bpf, selftests: Update test case for atomic cmpxchg on r0 with pointe=
r
      bpf: Fix signed bounds propagation after mov32
      bpf: Make 32->64 bounds propagation slightly more robust
      bpf, selftests: Add test case trying to taint map value pointer

Daniele Palmas (2):
      net: usb: qmi_wwan: add Telit 0x1070 composition
      USB: serial: option: add Telit FN990 compositions

Danielle Ratson (2):
      mlxsw: spectrum_router: Consolidate MAC profiles when possible
      selftests: mlxsw: Add a test case for MAC profiles consolidation

Dave Jiang (2):
      dmaengine: idxd: fix calling wq quiesce inside spinlock
      dmaengine: idxd: fix missed completion on abort path

David Ahern (3):
      selftests: Add duplicate config only for MD5 VRF tests
      selftests: Fix raw socket bind tests with VRF
      selftests: Fix IPv6 address bind tests

David Howells (1):
      afs: Fix mmap

David Wu (1):
      net: stmmac: Add GFP_DMA32 for rx buffers if no 64 capability

Davide Caratti (1):
      net/sched: sch_ets: don't remove idle classes from the round-robin li=
st

Dinh Nguyen (1):
      ARM: socfpga: dts: fix qspi node compatible

Eric Dumazet (3):
      sch_cake: do not call cake_destroy() from cake_init()
      inet_diag: fix kernel-infoleak for UDP sockets
      sit: do not call ipip6_dev_free() from sit_init_net()

Evan Quan (1):
      drm/amdgpu: correct the wrong cached state for GMC on PICASSO

Fabio Estevam (1):
      ARM: dts: imx6ull-pinfunc: Fix CSI_DATA07__ESAI_TX0 pad name

Felix Fietkau (3):
      mac80211: fix rate control for retransmitted frames
      mac80211: fix regression in SSN handling of addba tx
      mac80211: send ADDBA requests using the tid/queue of the
aggregation session

Filip Pokryvka (1):
      netdevsim: don't overwrite read only ethtool parms

Filipe Manana (4):
      btrfs: fix double free of anon_dev after failure to create subvolume
      btrfs: fix missing last dir item offset update when logging directory
      btrfs: fix invalid delayed ref after subvolume creation failure
      btrfs: fix warning when freeing leaf after subvolume creation failure

Finn Behrens (2):
      nl80211: reset regdom when reloading regdb
      nl80211: remove reload flag from regulatory_request

Florian Fainelli (1):
      net: systemport: Add global locking for descriptor lifecycle

Florian Klink (1):
      arm64: dts: rockchip: fix poweroff on helios64

Florian Westphal (2):
      mptcp: remove tcp ulp setsockopt support
      mptcp: clear 'kern' flag from fallback sockets

Gal Pressman (1):
      net: Fix double 0x prefix print in SKB dump

George Kennedy (1):
      libata: if T_LENGTH is zero, dma direction should be DMA_NONE

Greg Jesionowski (1):
      net: usb: lan78xx: add Allied Telesis AT29M2-AF

Greg Kroah-Hartman (2):
      USB: gadget: bRequestType is a bitfield, not a enum
      Revert "usb: early: convert to readl_poll_timeout_atomic()"

Haimin Zhang (1):
      netdevsim: Zero-initialize memory for new map's value in
function nsim_bpf_map_alloc

Hangbin Liu (1):
      selftest/net/forwarding: declare NETIFS p9 p10

Hangyu Hua (2):
      phonet: refcount leak in pep_sock_accep
      rds: memory leak in __rds_conn_create()

Harshit Mogalapalli (1):
      drm/i915/display: Fix an unsigned subtraction which can never be nega=
tive.

Hawking Zhang (1):
      drm/amdgpu: don't override default ECO_BITs setting

Hu Weiwen (1):
      ceph: fix duplicate increment of opened_inodes metric

Ilan Peer (2):
      cfg80211: Acquire wiphy mutex on regulatory work
      mac80211: Fix the size used for building probe request

Ioana Ciornei (1):
      dpaa2-eth: fix ethtool statistics

Ivan T. Ivanov (1):
      ARM: rockchip: Use memcpy_toio instead of memcpy on smp bring-up

Janne Grunau (3):
      arm64: dts: apple: change ethernet0 device type to ethernet
      dt-bindings: i2c: apple,i2c: allow multiple compatibles
      arm64: dts: apple: add #interrupt-cells property to pinctrl nodes

Javier Martinez Canillas (1):
      Revert "drm/fb-helper: improve DRM fbdev emulation device names"

Jeff Layton (1):
      ceph: initialize i_size variable in ceph_sync_read

Jens Axboe (3):
      io-wq: drop wqe lock before creating new worker
      block: reduce kblockd_mod_delayed_work_on() CPU consumption
      Revert "block: reduce kblockd_mod_delayed_work_on() CPU consumption"

Jerome Brunet (1):
      arm64: meson: remove COMMON_CLK

Jerome Marchand (2):
      s390/ftrace: remove preempt_disable()/preempt_enable() pair
      recordmcount.pl: look for jgnop instruction as well as bcrl on s390

Ji-Ze Hong (Peter Hong) (1):
      serial: 8250_fintek: Fix garbled text for console

Jianglei Nie (1):
      btrfs: fix memory leak in __add_inode_ref()

Jiasheng Jiang (2):
      drm/ast: potential dereference of null pointer
      sfc_ef100: potential dereference of null pointer

Jie Wang (1):
      net: hns3: fix use-after-free bug in hclgevf_send_mbx_msg

Jie2x Zhou (1):
      selftests: net: Correct ping6 expected rc from 2 to 1

Jimmy Wang (1):
      USB: NO_LPM quirk Lenovo USB-C to Ethernet Adapher(RTL8153-04)

Joe Thornber (1):
      dm btree remove: fix use after free in rebalance_children()

Johan Hovold (1):
      USB: serial: cp210x: fix CP2105 GPIO registration

Johannes Berg (8):
      mac80211: track only QoS data frames for admission control
      mac80211: add docs for ssn in struct tid_ampdu_tx
      iwlwifi: mvm: don't crash on invalid rate w/o STA
      mac80211: agg-tx: don't schedule_and_wake_txq() under sta->lock
      mac80211: validate extended element ID is present
      mac80211: fix lookup when adding AddBA extension element
      mac80211: mark TX-during-stop for TX in in_reconfig
      mac80211: do drv_reconfig_complete() before restarting all

John Garry (1):
      scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t

John Keeping (3):
      arm64: dts: rockchip: fix rk3308-roc-cc vcc-sd supply
      arm64: dts: rockchip: fix rk3399-leez-p710 vcc3v3-lan supply
      net: stmmac: dwmac-rk: fix oob read in rk_gmac_setup

Jon Hunter (1):
      reset: tegra-bpmp: Revert Handle errors in BPMP response

Josef Bacik (1):
      btrfs: check WRITE_ERR when trying to read an extent buffer

Kalle Valo (1):
      MAINTAINERS: update Kalle Valo's email

Karen Sornek (1):
      igb: Fix removal of unicast MAC filters of VFs

Karol Kolacinski (2):
      ice: Use div64_u64 instead of div_u64 in adjfine
      ice: Don't put stale timestamps in the skbtoo

Kumar Kartikeya Dwivedi (1):
      selftests/bpf: Fix OOB write in test_verifier

Lakshmi Ramasubramanian (1):
      arm64: kexec: Fix missing error code 'ret' warning in
load_other_segments()

Lang Yu (1):
      drm/amd/pm: fix a potential gpu_metrics_table memory leak

Le Ma (1):
      drm/amdgpu: correct register access for RLC_JUMP_TABLE_RESTORE

Letu Ren (1):
      igbvf: fix double free in `igbvf_probe`

Lin Feng (1):
      bcache: fix NULL pointer reference in cached_dev_detach_finish

Linus Torvalds (2):
      fget: clarify and improve __fget_files() implementation
      Linux 5.16-rc6

Lv Ruyi (1):
      firmware: tegra: Fix error application of sizeof() to pointer

Magnus Karlsson (1):
      xsk: Do not sleep in poll() when need_wakeup set

Marek Beh=C3=BAn (1):
      net: dsa: mv88e6xxx: Unforce speed & duplex in mac_link_down()

Marian Postevca (1):
      usb: gadget: u_ether: fix race in setting MAC address in setup phase

Mario Limonciello (1):
      drm/amd/pm: fix reading SMU FW version from amdgpu_firmware_info on Y=
C

Martin KaFai Lau (1):
      bpf, selftests: Fix racing issue in btf_skc_cls_ingress test

Martin Kepplinger (1):
      arm64: dts: imx8mq: remove interconnect property from lcdif

Mathew McBride (1):
      arm64: dts: ten64: remove redundant interrupt declaration for gpio-ke=
ys

Matthieu Baerts (1):
      mptcp: add missing documented NL params

Maxim Galaganov (1):
      mptcp: fix deadlock in __mptcp_push_pending()

Maxime Bizon (1):
      mac80211: fix TCP performance on mesh interface

Miaoqian Lin (2):
      net: bcmgenet: Fix NULL vs IS_ERR() checking
      perf expr: Fix missing check for return value of hashmap__new()

Mike Snitzer (1):
      dm integrity: fix data corruption due to improper use of bvec_kmap_lo=
cal

Mike Tipton (1):
      clk: Don't parent clks until the parent is fully registered

Mordechay Goodstein (1):
      mac80211: update channel context before station state

Naohiro Aota (1):
      zonefs: add MODULE_ALIAS_FS

Nathan Chancellor (1):
      soc/tegra: fuse: Fix bitwise vs. logical OR warning

Nehal Bakulchandra Shah (1):
      usb: xhci: Extend support for runtime power management for AMD's
Yellow carp.

Nicholas Kazlauskas (2):
      drm/amd/display: Set exit_optimized_pwr_state for DCN31
      drm/amd/display: Reset DMCUB before HW init

Niklas Schnelle (1):
      s390: enable switchdev support in defconfig

Ong Boon Leong (1):
      net: stmmac: fix tc flower deletion for VLAN priority Rx steering

Paolo Abeni (1):
      mptcp: never allow the PM to close a listener subflow

Parav Pandit (1):
      vdpa: Consider device id larger than 31

Paul Chaignon (2):
      bpf: Fix incorrect state pruning for <8B spill/fill
      selftests/bpf: Tests for state pruning with u32 spill/fill

Paul Moore (1):
      audit: improve robustness of the audit queue handling

Pawel Laszczak (4):
      usb: cdnsp: Fix incorrect calling of cdnsp_died function
      usb: cdnsp: Fix issue in cdnsp_log_ep trace event
      usb: cdnsp: Fix incorrect status for control request
      usb: cdnsp: Fix lack of spin_lock_irqsave/spin_lock_restore

Philipp Rudo (2):
      s390/kexec_file: print some more error messages
      s390/kexec_file: fix error handling when applying relocations

Po-Hsu Lin (1):
      selftests: icmp_redirect: pass xfail=3D0 to log_test()

Randy Dunlap (1):
      hv: utils: add PTP_1588_CLOCK to Kconfig to fix build

Robert Schlabbach (1):
      ixgbe: Document how to enable NBASE-T support

Russell Currey (1):
      powerpc/module_64: Fix livepatching for RO modules

Russell King (Oracle) (1):
      net: phy: add a note about refcounting

Sasha Neftin (1):
      igc: Fix typo in i225 LTR functions

Scott Mayhew (1):
      selinux: fix sleeping function called from invalid context

Sean Christopherson (1):
      KVM: x86: Retry page fault if MMU reload is pending and root has no s=
p

Sergio Paracuellos (1):
      PCI: mt7621: Convert driver into 'bool'

Shin'ichiro Kawasaki (1):
      btrfs: fix missing blkdev_put() call in btrfs_scan_one_device()

Shyam Prasad N (1):
      cifs: ignore resource_id while getting fscache super cookie

Stefan Assmann (1):
      iavf: do not override the adapter state in the watchdog task (again)

Stefan Roese (1):
      PCI/MSI: Mask MSI-X vectors only on success

Stephan Gerhold (1):
      soc: imx: Register SoC device only on i.MX boards

Sudeep Holla (1):
      firmware: arm_scpi: Fix string overflow in SCPI genpd driver

Sven Schnelle (1):
      s390/entry: fix duplicate tracking of irq nesting level

Tejun Heo (1):
      iocost: Fix divide-by-zero on donation from low hweight cgroup

Tetsuo Handa (1):
      tty: n_hdlc: make n_hdlc_tty_wakeup() asynchronous

Thiago Rafael Becker (1):
      cifs: sanitize multiple delimiters in prepath

Thomas Gleixner (1):
      PCI/MSI: Clear PCI_MSIX_FLAGS_MASKALL on error

Tiezhu Yang (1):
      MIPS: Only define pci_remap_iospace() for Ralink

Tim Gardner (1):
      dmaengine: dw-axi-dmac: Fix uninitialized variable in
axi_chan_block_xfer_start()

Vignesh Raghavendra (1):
      dmaengine: ti: k3-udma: Fix smatch warnings

Vincent Pelletier (5):
      riscv: dts: sifive unmatched: Name gpio lines
      riscv: dts: sifive unmatched: Expose the board ID eeprom
      riscv: dts: sifive unmatched: Expose the PMIC sub-functions
      riscv: dts: sifive unmatched: Fix regulator for board rev3
      riscv: dts: sifive unmatched: Link the tmp451 with its power supply

Vitaly Kuznetsov (2):
      KVM: x86: Drop guest CPUID check for host initiated writes to
MSR_IA32_PERF_CAPABILITIES
      KVM: selftests: vmx_pmu_msrs_test: Drop tests mangling guest
visible CPUIDs

Vladimir Oltean (3):
      ARM: dts: imx6qp-prtwd3: update RGMII delays for sja1105 switch
      ARM: dts: ls1021a-tsn: update RGMII delays for sja1105 switch
      arm64: dts: lx2160abluebox3: update RGMII delays for sja1105 switch

Vyacheslav Bocharov (1):
      arm64: meson: fix dts for JetHub D1

Wang Qing (1):
      net: ethernet: ti: add missing of_node_put before return

Wei Wang (1):
      virtio/vsock: fix the transport to work with VMADDR_CID_ANY

Wenliang Wang (1):
      virtio_net: fix rx_drops stat for small pkts

Will Deacon (1):
      virtio_ring: Fix querying of maximum DMA mapping size for virtio devi=
ce

Willem de Bruijn (2):
      selftests/net: toeplitz: fix udp option
      net/packet: rx_owner_map depends on pg_vec

Xiaoming Ni (1):
      powerpc/85xx: Fix oops when CONFIG_FSL_PMC=3Dn

Xing Song (1):
      mac80211: set up the fwd_skb->dev for mesh forwarding

Xiubo Li (1):
      ceph: initialize pathlen variable in reconnect_caps_cb

Xu Yang (1):
      usb: typec: tcpm: fix tcpm unregister port but leave a pending timer

Yu Liao (1):
      timekeeping: Really make sure wall_to_monotonic isn't positive

Yufeng Mo (1):
      net: hns3: fix race condition in debugfs

Zqiang (1):
      locking/rtmutex: Fix incorrect condition in rtmutex_spin_on_owner()
