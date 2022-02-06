Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477BA4AB223
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 21:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiBFUkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 15:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiBFUkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 15:40:49 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AC4C061348
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 12:40:47 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u18so25422505edt.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 12:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7rQWm7Qgr6Ir+Wl8VUTK74cJPycwdaTPUEaF/Rdo2Fk=;
        b=iIdpSrhoF26GcV+gP+Ea45eA1rtOnKzOMqSYBMaq1RwqIdkc4KfGvY1DAVye0kkEm/
         0FmJaFo58bLxhowyVQQty0fESfejk6y5kUc2TEH4lPwRdMRuWAebx2O7E0B/ID1CYtwF
         3uE4yeCAx8I2SCOXCY6T15PR1SvTN7rnsZczA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7rQWm7Qgr6Ir+Wl8VUTK74cJPycwdaTPUEaF/Rdo2Fk=;
        b=DEaNOL3YeArqKxVSXNE16Uh+xH1hL4pR2b6hXMipaeULuO/uEVKuoDCg7oBQnAnGvP
         nipc6PgnI2ogk4VR0ZQnKYwQ3Vi7mvKVgmuYxxReEzxLsEC8sP6Trc4b6sZi6Z8RwoKx
         gwrtMZAogiYy/MQIFmajXvUL8zardGWN/4g5Pr15JRvwFBsNtQcjfFtL/qgiEFQL4b7c
         jVNn9fKGxXYJ1/N42agJPCmfLOk1wBb69xlYFIH3PDhHjrC+lHcq8LFQVFY+qQlluWx2
         s9MEgz2s5Wdt0A96TFrrKolbjcdwZJYAPSCGnHZGDH7RyVL7dXmypX3WCf0UqPD7XRDq
         11PQ==
X-Gm-Message-State: AOAM530TgqfF9lDg9XpKy2y55twjVnrxXd/QIzgGI6q7+CeyvPgjfMaf
        z/H8xEpSmecIUR8fNwujQEhf+Vv2/o5n3gj+
X-Google-Smtp-Source: ABdhPJwVVmdlD4UcZuSVWh2+FijaGLun4xEYIejb0QzTBbT48Ox/ToOi2pD7z7+kn/PPr18gS0GSWg==
X-Received: by 2002:a05:6402:184d:: with SMTP id v13mr10462276edy.109.1644180045236;
        Sun, 06 Feb 2022 12:40:45 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id eo14sm978382edb.46.2022.02.06.12.40.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 12:40:44 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id n8so8539176wmk.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 12:40:44 -0800 (PST)
X-Received: by 2002:a7b:c38b:: with SMTP id s11mr5002499wmj.8.1644180044155;
 Sun, 06 Feb 2022 12:40:44 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Feb 2022 12:40:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiKr3q0ABWL0me+ugjN87zBOFXnBi43=-rBu7+WDKwQVA@mail.gmail.com>
Message-ID: <CAHk-=wiKr3q0ABWL0me+ugjN87zBOFXnBi43=-rBu7+WDKwQVA@mail.gmail.com>
Subject: Linux 5.17-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things look fairly normal so far, with a pretty average number of
commits for an rc3 release.

The diffstat shows that we've had more filesystem activity than is
perhaps usual, The filesystem activity is all over, ranging from cifs
re-introducing fscache support after the rewrite, to vfs-level error
handling fixes, to just regular filesystem-specific fixes (btrfs,
ext4, xfs), to some unicode Kconfig cleanups. So it's not one single
thing, it just happened that we had more filesystem stuff than is
perhaps common at this point.

That said, driver fixes (networking, gpu, sound, pin control, platform
drivers,scsi etc) still dominate. On the driver side, some reverts to
re-enable hw-accelerated scrolling for legacy fbdev devices perhaps
stand out.

Outside of that, it's a mixed bag of random stuff - the usual arch
updates (kvm noise stands out), generic networking and core kernel,
and tooling (selftests and perf). And some documentation fixes.

Shortlog appended for more details, but I don't see anything that
makes me worried for the 5.17 release. Knock wood.

Please go test,

           Linus

---

Agustin Gutierrez (1):
      drm/amd/display: Update watermark values for DCN301

Ajish Koshy (1):
      scsi: pm80xx: Fix double completion for SATA devices

Ajit Kumar Pandey (1):
      ASoC: amd: acp-mach: Fix Left and Right rt1019 amp devices

Alain Volmat (2):
      spi: stm32: remove inexistant variables in struct stm32_spi_cfg comme=
nt
      spi: stm32: make SPI_MASTER_MUST_TX flags only specific to STM32F4

Albert Geant=C4=83 (1):
      ALSA: hda/realtek: Add quirk for ASUS GU603

Alex Elder (2):
      dt-bindings: net: qcom,ipa: add optional qcom,qmp property
      net: ipa: request IPA register values be retained

Alexander Kobel (1):
      platform/x86: thinkpad_acpi: Add quirk for ThinkPads without a fan

Alexander Stein (1):
      drm: mxsfb: Fix NULL pointer dereference

Alexei Starovoitov (1):
      bpf: Fix renaming task_getsecid_subj->current_getsecid_subj.

Ameer Hamza (1):
      perf session: Check for NULL pointer before dereference

Andre Przywara (1):
      pinctrl: sunxi: Fix H616 I2S3 pin data

Andy Shevchenko (2):
      pinctrl: Place correctly CONFIG_PINCTRL_ST in the Makefile
      pinctrl: intel: Fix a glitch when updating IRQ flags on a
preconfigured line

Anitha Chrisanthus (1):
      drm/kmb: Fix for build errors with Warray-bounds

Anshuman Khandual (1):
      perf tools: Add missing branch_sample_type to perf_event_attr__fprint=
f()

Anton Lundin (1):
      ata: libata-core: Introduce ATA_HORKAGE_NO_LOG_DIR horkage

Anup Patel (1):
      RISC-V: KVM: Fix SBI implementation version

Arnaldo Carvalho de Melo (7):
      tools include UAPI: Sync sound/asound.h copy with the kernel sources
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources
      tools headers cpufeatures: Sync with the kernel sources
      perf beauty: Make the prctl arg regexp more strict to cope with PR_SE=
T_VMA
      tools headers UAPI: Sync linux/prctl.h with the kernel sources
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      tools include UAPI: Sync sound/asound.h copy with the kernel sources

Ar=C4=B1n=C3=A7 =C3=9CNAL (1):
      net: dsa: mt7530: make NET_DSA_MT7530 select MEDIATEK_GE_PHY

Aun-Ali Zaidi (1):
      drm/amd/display: Force link_rate as LINK_RATE_RBR2 for 2018 15"
Apple Retina panels

Benjamin Gaignard (1):
      spi: mediatek: Avoid NULL pointer crash in interrupt

Bernard Metzler (1):
      RDMA/siw: Fix broken RDMA Read Fence/Resume logic.

Bjorn Helgaas (2):
      PCI: j721e: Initialize pcie->cdns_pcie before using it
      PCI: kirin: Add dev struct for of_device_get_match_data()

Camel Guo (1):
      net: stmmac: dump gmac4 DMA registers correctly

Changbin Du (1):
      perf ftrace: system_wide collection is not effective by default

Chen Wandun (1):
      Revert "mm/page_isolation: unset migratetype directly for non Buddy p=
age"

Christian Brauner (1):
      mailmap: update Christian Brauner's email address

Christian K=C3=B6nig (1):
      drm/amdgpu: fix logic inversion in check

Christian Lachner (3):
      ALSA: hda/realtek: Add missing fixup-model entry for Gigabyte
X570 ALC1220 quirks
      ALSA: hda/realtek: Fix silent output on Gigabyte X570S Aorus
Master (newer chipset)
      ALSA: hda/realtek: Fix silent output on Gigabyte X570 Aorus
Xtreme after reboot from Windows

Christoph Fritz (1):
      ovl: fix NULL pointer dereference in copy up warning

Christoph Hellwig (1):
      unicode: clean up the Kconfig symbol confusion

Christophe JAILLET (1):
      Input: wm97xx: Simplify resource management

Cristian Marussi (4):
      selftests: openat2: Print also errno in failure messages
      selftests: openat2: Add missing dependency in Makefile
      selftests: openat2: Skip testcases that fail with EOPNOTSUPP
      selftests: skip mincore.check_file_mmap when fs lacks needed support

Dai Ngo (1):
      nfsd: nfsd4_setclientid_confirm mistakenly expires confirmed client.

Dan Carpenter (5):
      regulator: max20086: fix error code in max20086_parse_regulators_dt()
      ASoC: max9759: fix underflow in speaker_gain_control_put()
      RDMA/siw: Fix refcounting leak in siw_create_qp()
      drm/i915/overlay: Prevent divide by zero bugs in scaling
      fanotify: Fix stale file descriptor in copy_event_to_user()

Daniel Borkmann (1):
      net, neigh: Do not trigger immediate probes on NUD_FAILED from
neigh_managed_work

Darrick J. Wong (5):
      vfs: make freeze_super abort when sync_filesystem returns error
      vfs: make sync_filesystem return errors from ->sync_fs
      quota: make dquot_quota_sync return errors from ->sync_fs
      xfs: return errors in xfs_fs_sync_fs
      xfs: reject crazy array sizes being fed to XFS_IOC_GETBMAP*

Dave Chinner (6):
      xfs, iomap: limit individual ioend chain lengths in writeback
      xfs: remove XFS_PREALLOC_SYNC
      xfs: fallocate() should call file_modified()
      xfs: set prealloc flag in xfs_alloc_file_space()
      xfs: move xfs_update_prealloc_flags() to xfs_pnfs.c
      xfs: ensure log flush at the end of a synchronous fallocate call

David Howells (5):
      Fix a warning about a malformed kernel doc comment in cifs
      cifs: Transition from ->readpages() to ->readahead()
      netfs, cachefiles: Add a method to query presence of data in the cach=
e
      cifs: Implement cache I/O by accessing the cache directly
      cifs: Fix the readahead conversion to manage the batch when
reading from cache

Demi Marie Obenour (1):
      Improve docs for IOCTL_GNTDEV_MAP_GRANT_REF

Dima Chumak (1):
      net/mlx5: Fix offloading with ESWITCH_IPV4_TTL_MODIFY_ENABLE

Dmitry Osipenko (1):
      ASoC: hdmi-codec: Fix OOB memory accesses

Dmitry V. Levin (1):
      Partially revert "net/smc: Add netlink net namespace support"

Dominik Brodowski (3):
      random: continually use hwgenerator randomness
      random: access primary_pool directly rather than through pointer
      random: only call crng_finalize_init() for primary_crng

Dominique Martinet (1):
      Revert "fs/9p: search open fids first"

Dongliang Mu (1):
      spi: change clk_disable_unprepare to clk_unprepare

Duoming Zhou (3):
      ax25: improve the incomplete fix to avoid UAF and NPD bugs
      ax25: add refcount in ax25_dev to avoid UAF bugs
      ax25: fix reference count leaks of ax25_dev

Eric Dumazet (5):
      net: sched: fix use-after-free in tc_new_tfilter()
      rtnetlink: make sure to refresh master_dev/m_ops in __rtnl_newlink()
      af_packet: fix data-race in packet_setsockopt / packet_setsockopt
      tcp: fix mem under-charging with zerocopy sendmsg()
      tcp: add missing tcp_skb_can_collapse() test in tcp_shift_skb_data()

Eric W. Biederman (1):
      cgroup-v1: Require capabilities to set release_agent

Evan Quan (1):
      drm/amd/pm: correct the MGpuFanBoost support for Beige Goby

Filipe Manana (2):
      btrfs: fix use-after-free after failure to create a snapshot
      btrfs: skip reserved bytes warning on unmount after log cleanup failu=
re

Florian Fainelli (1):
      pinctrl: bcm2835: Fix a few error paths

Florian Westphal (4):
      netfilter: nft_ct: fix use after free when attaching zone template
      selftests: netfilter: reduce zone stress test running time
      selftests: netfilter: check stateless nat udp checksum fixup
      selftests: nft_concat_range: add test for reload with no element add/=
del

Gal Pressman (1):
      net/mlx5e: Fix module EEPROM query

Gao Xiang (3):
      erofs: fix fsdax partition offset handling
      erofs: avoid unnecessary z_erofs_decompressqueue_work() declaration
      erofs: fix small compressed files inlining

Geert Uytterhoeven (2):
      platform/surface: Reinstate platform dependency
      netfilter: Remove flowtable relics

Georgi Valkov (1):
      ipheth: fix EOVERFLOW in ipheth_rcvbulk_callback

Gerhard Engleder (1):
      pinctrl: zynqmp: Revert "Unify pin naming"

German Gomez (1):
      perf tools: Apply correct label to user/kernel symbols in branch mode

Guoqing Jiang (1):
      iommu/vt-d: Fix potential memory leak in intel_setup_irq_remapping()

Haiyue Wang (1):
      gve: fix the wrong AdminQ buffer queue index check

Hans de Goede (8):
      pinctrl: cherryview: Trigger hwirq0 for interrupt-lines without a map=
ping
      platform/x86: x86-android-tablets: Correct crystal_cove_charger
module name
      platform/x86: x86-android-tablets: Add support for disabling
ACPI _AEI handlers
      platform/x86: x86-android-tablets: Add an init() callback to
struct x86_dev_info
      platform/x86: x86-android-tablets: Constify the gpiod_lookup_tables a=
rrays
      platform/x86: intel_crystal_cove_charger: Fix IRQ masking / unmasking
      platform/x86: amd-pmc: Make amd_pmc_stb_debugfs_fops static
      platform/x86: asus-tf103c-dock: Make 2 global structs static

He Fengqing (1):
      bpf: Fix possible race in inc_misses_counter

Helge Deller (3):
      Revert "fbdev: Garbage collect fbdev scrolling acceleration,
part 1 (from TODO list)"
      Revert "fbcon: Disable accelerated scrolling"
      fbcon: Add option to enable legacy hardware acceleration

Horatiu Vultur (1):
      pinctrl: microchip-sgpio: Fix support for regmap

Hou Tao (1):
      bpf: Use VM_MAP instead of VM_ALLOC for ringbuf

Ian Rogers (1):
      perf stat: Fix display of grouped aliased events

Igor Pylypiv (1):
      Revert "module, async: async_synchronize_full() on module init
iff async is used"

Ilya Dryomov (3):
      block: fix DIO handling regressions in blkdev_read_iter()
      libceph: make recv path in secure mode work the same as send path
      libceph: optionally use bounce buffer on recv path in crc mode

Imre Deak (1):
      drm/i915/adlp: Fix TypeC PHY-ready status readout

J. Bruce Fields (2):
      lockd: fix server crash on reboot of client holding lock
      lockd: fix failure to cleanup client locks

Jakub Kicinski (1):
      ethernet: smc911x: fix indentation in get/set EEPROM

James Morse (3):
      KVM: arm64: Avoid consuming a stale esr value when SError occur
      KVM: arm64: Stop handle_exit() from handling HVC twice when an
SError occurs
      KVM: arm64: Workaround Cortex-A510's single-step and PAC trap errata

Jan Beulich (1):
      x86/Xen: streamline (and fix) PV CPU enumeration

Janosch Frank (1):
      kvm: Move KVM_GET_XSAVE2 IOCTL definition at the end of kvm.h

Jason A. Donenfeld (2):
      lib/crypto: blake2s: avoid indirect calls to compression
function for Clang CFI
      random: wake up /dev/random writers after zap

Jean-Philippe Brucker (1):
      tools: Ignore errors from `which' when searching a GCC toolchain

Jedrzej Jagielski (1):
      i40e: Fix reset bw limit when DCB enabled with 1 TC

Jiasheng Jiang (1):
      ASoC: cpcap: Check for NULL pointer after calling of_get_child_by_nam=
e

Jim Mattson (1):
      KVM: x86: Report deprecated x87 features in supported CPUID

Jisheng Zhang (1):
      net: stmmac: properly handle with runtime pm in stmmac_dvr_remove()

Joerg Roedel (1):
      iommu/amd: Fix loop timeout issue in iommu_ga_log_enable()

John Garry (5):
      iommu: Fix some W=3D1 warnings
      scsi: pm8001: Fix warning for undescribed param in process_one_iomb()
      scsi: pm8001: Fix use-after-free for aborted TMF sas_task
      scsi: pm8001: Fix use-after-free for aborted SSP/STP sas_task
      scsi: hisi_sas: Fix setting of hisi_sas_slot.is_internal

John Hubbard (1):
      Revert "mm/gup: small refactoring: simplify try_grab_page()"

John Meneghini (1):
      scsi: bnx2fc: Make bnx2fc_recv_frame() mp safe

Jonas Hahnfeld (1):
      ALSA: usb-audio: Correct quirk for VF0770

Jonathan McDowell (1):
      net: phy: Fix qca8081 with speeds lower than 2.5Gb/s

Jordy Zomer (1):
      dma-buf: heaps: Fix potential spectre v1 gadget

Julian Braha (2):
      ASoC: mediatek: fix unmet dependency on GPIOLIB for SND_SOC_DMIC
      pinctrl: bcm63xx: fix unmet dependency on REGMAP for GPIO_REGMAP

Kamal Dasu (1):
      spi: bcm-qspi: check for valid cs before applying chip select

Karen Sornek (1):
      i40e: Fix reset path while removing the driver

Kees Cook (3):
      net/mlx5e: Use struct_group() for memcpy() region
      net/mlx5e: Avoid field-overflowing memcpy()
      gcc-plugins/stackleak: Use noinstr in favor of notrace

Khalid Manaa (2):
      net/mlx5e: Fix wrong calculation of header index in HW_GRO
      net/mlx5e: Fix broken SKB allocation in HW-GRO

Kunihiko Hayashi (1):
      spi: uniphier: Fix a bug that doesn't point to private data correctly

Lang Yu (2):
      drm/amdgpu: fix a potential GPU hang on cyan skillfish
      mm/kmemleak: avoid scanning potential huge holes

Leo Yan (1):
      perf synthetic-events: Return error if procfs isn't mounted for
PID namespaces

Leon Romanovsky (2):
      RDMA/ucma: Protect mc during concurrent multicast leaves
      RDMA/mlx4: Don't continue event handler after memory allocation failu=
re

Li Zhijian (1):
      kselftest: signal all child processes

Linus Torvalds (1):
      Linux 5.17-rc3

Lior Nahmanson (2):
      net: macsec: Fix offload support for NETDEV_UNREGISTER event
      net: macsec: Verify that send_sci is on when setting Tx sci explicitl=
y

Lubomir Rintel (2):
      platform/x86: x86-android-tablets: Fix the buttons on CZC P10T tablet
      platform/x86: x86-android-tablets: Trivial typo fix for MODULE_AUTHOR

Lukas Czerner (1):
      ext4: fix potential NULL pointer dereference in ext4_fill_super()

Maher Sanalla (1):
      net/mlx5: Use del_timer_sync in fw reset flow of halting poll

Maor Dickman (2):
      net/mlx5e: Fix handling of wrong devices during bond netevent
      net/mlx5: E-Switch, Fix uninitialized variable modact

Maor Gottlieb (1):
      RDMA/cma: Use correct address when leaving multicast group

Marco Elver (3):
      perf: Copy perf_event_attr::sig_data on modification
      selftests/perf_events: Test modification of perf_event_attr::sig_data
      perf: uapi: Document perf_event_attr::sig_data truncation on 32
bit architectures

Mario Limonciello (5):
      platform/x86: amd-pmc: Correct usage of SMU version
      drm/amd: Warn users about potential s0ix problems
      drm/amd: add support to check whether the system is set to s3
      drm/amd: Only run s3 or s0ix if system is configured properly
      drm/amd: avoid suspend on dGPUs w/ s2idle support when runtime PM ena=
bled

Mark Brown (4):
      ASoC: ops: Reject out of bounds values in snd_soc_put_volsw()
      ASoC: ops: Reject out of bounds values in snd_soc_put_volsw_sx()
      ASoC: ops: Reject out of bounds values in snd_soc_put_xr_sx()
      ASoC: ops: Check for negative values before reading them

Mark Pearson (1):
      platform/x86: thinkpad_acpi: Fix incorrect use of platform
profile on AMD platforms

Mark Rutland (5):
      kvm: add guest_state_{enter,exit}_irqoff()
      kvm/mips: rework guest entry logic
      kvm/x86: rework guest entry logic
      kvm/arm64: rework guest entry logic
      kvm/riscv: rework guest entry logic

Mark Zhang (1):
      IB/cm: Release previously acquired reference counter in the cm_id_pri=
v

Martin K. Petersen (1):
      block: bio-integrity: Advance seed correctly for larger interval size=
s

Masanari Iida (1):
      perf bpf: Fix a typo in bpf_counter_cgroup.c

Matthew Brost (2):
      drm/i915: Allocate intel_engine_coredump_alloc with ALLOW_FAIL
      drm/i915: Lock timeline mutex directly in error path of eb_pin_timeli=
ne

Maxim Mikityanskiy (1):
      net/mlx5e: Don't treat small ceil values as unlimited in HTB offload

Mayuresh Chitale (1):
      RISC-V: KVM: make CY, TM, and IR counters accessible in VU mode

Miaoqian Lin (2):
      spi: meson-spicc: add IRQ check in meson_spicc_probe
      ASoC: fsl: Add missing error handling in pcm030_fabric_probe

Michal Koutn=C3=BD (1):
      cgroup/cpuset: Make child cpusets restrict parents on v1 hierarchy

Micha=C5=82 Winiarski (1):
      kunit: tool: Import missing importlib.abc

Micka=C3=ABl Sala=C3=BCn (1):
      printk: Fix incorrect __user type in proc_dointvec_minmax_sysadmin()

Mike Marciniszyn (5):
      IB/hfi1: Fix panic with larger ipoib send_queue_size
      IB/hfi1: Fix alloc failure with larger txqueuelen
      IB/hfi1: Fix AIP early init panic
      IB/hfi1: Fix tstats alloc and dealloc
      IB/rdmavt: Validate remote_addr during loopback atomic tests

Mike Rapoport (2):
      mm/pgtable: define pte_index so that preprocessor could recognize it
      MAINTAINERS: update rppt's email

Miklos Szeredi (1):
      ovl: don't fail copy up if no fileattr support on upper

Ming Lei (1):
      scsi: core: Reallocate device's budget map on queue depth change

Minghao Chi (1):
      ipc/sem: do not sleep with a spin lock held

Miquel Raynal (6):
      net: ieee802154: hwsim: Ensure proper channel selection at probe time
      net: ieee802154: mcr20a: Fix lifs/sifs periods
      net: ieee802154: at86rf230: Stop leaking skb's
      net: ieee802154: ca8210: Stop leaking skb's
      net: ieee802154: Return meaningful error codes from the netlink helpe=
rs
      MAINTAINERS: Remove Harry Morris bouncing address

Muhammad Usama Anjum (2):
      selftests/exec: Remove pipe from TEST_GEN_FILES
      selftests: futex: Use variable MAKE instead of make

Namhyung Kim (1):
      perf annotate: Set error stream of objdump process for TUI

Nathan Chancellor (1):
      tools/resolve_btfids: Do not print any commands when building silentl=
y

Nick Lopez (1):
      drm/nouveau: fix off by one in BIOS boundary checking

Nicolas Frattaroli (1):
      spi: spi-rockchip: Add rk3568-spi compatible

N=C3=ADcolas F. R. A. Prado (2):
      selftests: rtc: Increase test timeout so that all tests run
      selftests: cpufreq: Write test output to stdout as well

Pablo Neira Ayuso (2):
      netfilter: nft_byteorder: track register operations
      netfilter: nf_tables: remove assignment with no effect in chain
blob builder

Pasha Tatashin (4):
      mm/debug_vm_pgtable: remove pte entry from the page table
      mm/page_table_check: use unsigned long for page counters and cleanup
      mm/khugepaged: unify collapse pmd clear, flush and free
      mm/page_table_check: check entries at pmd levels

Patrice Chotard (1):
      spi: stm32-qspi: Update spi registering

Paul Hsieh (1):
      drm/amd/display: watermark latencies is not enough on DCN31

Paul Moore (1):
      audit: improve audit queue handling when "audit=3D1" on cmdline

Peter Ujfalusi (2):
      ASoC: rt5682: Fix deadlock on resume
      ALSA: hda: Skip codec shutdown in case the codec is not registered

Peter Zijlstra (1):
      x86/perf: Default set FREEZE_ON_SMI for all

Phil Sutter (1):
      netfilter: nft_reject_bridge: Fix for missing reply from prerouting

Qu Wenruo (1):
      btrfs: don't start transaction for scrub if the fs is mounted read-on=
ly

Raed Salem (2):
      net/mlx5e: IPsec: Fix crypto offload for non TCP/UDP encapsulated tra=
ffic
      net/mlx5e: IPsec: Fix tunnel mode crypto offload for non TCP/UDP traf=
fic

Rafael J. Wysocki (1):
      ALSA: Replace acpi_bus_get_device()

Rafa=C5=82 Mi=C5=82ecki (2):
      pinctrl: thunderbay: comment process of building functions a bit
      pinctrl: thunderbay: rework loops looking for groups names

Raju Rangoju (1):
      net: amd-xgbe: ensure to reset the tx_timer_active flag

Randy Dunlap (5):
      regulator: MAX20086: add gpio/consumer.h
      ACPI: require CRC32 to build
      MIPS: KVM: fix vz.c kernel-doc notation
      xen: xenbus_dev.h: delete incorrect file name
      xen: update missing ioctl magic numers documentation

Ritesh Harjani (5):
      ext4: fix error handling in ext4_restore_inline_data()
      ext4: remove redundant max inline_size check in
ext4_da_write_inline_data_begin()
      ext4: fix error handling in ext4_fc_record_modified_inode()
      jbd2: cleanup unused functions declarations from jbd2.h
      jbd2: refactor wait logic for transaction updates into a common funct=
ion

Rob Herring (2):
      spi: dt-bindings: Fix 'reg' child node schema
      libperf: Add arm64 support to perf_mmap__read_self()

Robert Hancock (2):
      ASoC: xilinx: xlnx_formatter_pcm: Make buffer bytes multiple of
period bytes
      ASoC: simple-card: fix probe failure on platform component

Roger Pau Monne (1):
      xen/x2apic: enable x2apic mode when supported for HVM

Rohith Surabattula (1):
      Invalidate fscache cookie only when inode attributes are changed.

Roi Dayan (4):
      net/mlx5e: TC, Reject rules with drop and modify hdr action
      net/mlx5e: TC, Reject rules with forward and drop actions
      net/mlx5: Bridge, Fix devlink deadlock on net namespace deletion
      net/mlx5e: Avoid implicit modify hdr for decap drop rule

Ryan Bair (1):
      cifs: fix workstation_name for multiuser mounts

Sagi Grimberg (3):
      nvme: fix a possible use-after-free in controller reset during load
      nvme-tcp: fix possible use-after-free in transport error_recovery wor=
k
      nvme-rdma: fix possible use-after-free in transport error_recovery wo=
rk

Sasha Neftin (2):
      e1000e: Separate ADP board type from TGP
      e1000e: Handshake with CSME starts from ADL platforms

Sean Christopherson (2):
      KVM: x86: Move delivery of non-APICv interrupt into vendor code
      KVM: x86: Use ERR_PTR_USR() to return -EFAULT as a __user pointer

Sean Young (1):
      tools headers UAPI: remove stale lirc.h

Sergei Trofimovich (1):
      objtool: Fix truncated string warning

Sergey Shtylyov (4):
      EDAC/altera: Fix deferred probing
      EDAC/xgene: Fix deferred probing
      MAINTAINERS: add myself as PATA drivers reviewer
      MAINTAINERS: add myself as Renesas R-Car SATA driver reviewer

Shin'ichiro Kawasaki (1):
      btrfs: fix deadlock between quota disable and qgroup rescan worker

Shuah Khan (2):
      docs/kselftest: clarify running mainline tests on stables
      kselftest/vm: revert "tools/testing/selftests/vm/userfaultfd.c:
use swap() to make code cleaner"

Shyam Prasad N (1):
      cifs: unlock chan_lock before calling cifs_put_tcp_session

Shyam Sundar S K (1):
      net: amd-xgbe: Fix skb data length underflow

Song Liu (1):
      md: fix NULL pointer deref with nowait but no mddev->queue

Srinivas Kandagatla (4):
      ASoC: codecs: wcd938x: fix incorrect used of portid
      ASoC: codecs: lpass-rx-macro: fix sidetone register offsets
      ASoC: codecs: wcd938x: fix return value of mixer put function
      ASoC: qdsp6: q6apm-dai: only stop graphs that are started

Srinivas Pandruvada (1):
      platform/x86: ISST: Fix possible circular locking dependency detected

Steen Hegelund (1):
      net: sparx5: do not refer to skb after passing it on

Su Yue (2):
      btrfs: tree-checker: check item_size for inode_item
      btrfs: tree-checker: check item_size for dev_item

Takashi Iwai (5):
      ALSA: hda: Fix UAF of leds class devs at unbinding
      ALSA: hda: Fix signedness of sscanf() arguments
      ASoC: soc-pcm: Fix DPCM lockdep warning due to nested stream locks
      ASoC: soc-pcm: Move debugfs removal out of spinlock
      ALSA: hda: realtek: Fix race at concurrent COEF updates

Thomas Bogendoerfer (1):
      MIPS: octeon: Fix missed PTR->PTR_WD conversion

Thomas Gleixner (1):
      PCI/MSI: Remove bogus warning in pci_irq_get_affinity()

Tianchen Ding (1):
      cpuset: Fix the bug that subpart_cpus updated wrongly in update_cpuma=
sk()

Tom Rix (2):
      ALSA: usb-audio: initialize variables that could ignore errors
      btrfs: fix use of uninitialized variable at rm device ioctl

Tristan Hume (1):
      perf/x86/intel/pt: Fix crash with stop filters in single-range mode

Uday Shankar (1):
      nvme-fabrics: fix state check in nvmf_ctlr_matches_baseopts()

Umesh Nerlige Ramappa (2):
      drm/i915/pmu: Use PM timestamp instead of RING TIMESTAMP for referenc=
e
      drm/i915/pmu: Fix KMD and GuC race on accessing busyness

Vijayanand Jitta (1):
      iommu: Fix potential use-after-free during probe

Vincenzo Frascino (1):
      kselftest: Fix vdso_test_abi return status

Vlad Buslov (2):
      net/mlx5: Bridge, take rtnl lock in init error handler
      net/mlx5: Bridge, ensure dev_name is null-terminated

Vratislav Bendel (1):
      selinux: fix double free of cond_list on error paths

Waiman Long (1):
      cgroup/cpuset: Fix "suspicious RCU usage" lockdep warning

Wen Gu (1):
      net/smc: Forward wakeup to smc socket waitqueue after fallback

Xin Xiong (1):
      spi: uniphier: fix reference count leak in uniphier_spi_probe()

Xin Yin (5):
      ext4: prevent used blocks from being allocated during fast commit rep=
lay
      ext4: modify the logic of ext4_mb_new_blocks_simple
      ext4: fast commit may not fallback for ineligible commit
      ext4: fast commit may miss file actions
      ext4: fix incorrect type issue during replay_del_range

Yang Li (1):
      jbd2: fix kernel-doc descriptions for jbd2_journal_shrink_{scan,count=
}()

Yang Xu (3):
      selftests/zram: Skip max_comp_streams interface on newer kernel
      selftests/zram01.sh: Fix compression ratio calculation
      selftests/zram: Adapt the situation that /dev/zram0 is being used

Yannick Vignon (1):
      net: stmmac: ensure PTP time register reads are consistent

Yuji Ishikawa (1):
      net: stmmac: dwmac-visconti: No change to ETHER_CLOCK_SEL for
unexpected speed request.

Yuka Kawajiri (1):
      platform/x86: touchscreen_dmi: Add info for the RWC NANOTE P8 AY07J 2=
-in-1

Zhan Liu (1):
      drm/amd/display: revert "Reset fifo after enable otg"

hongnanli (1):
      fs/ext4: fix comments mentioning i_mutex

=C5=81ukasz Bartosik (1):
      pinctrl: intel: fix unexpected interrupt
