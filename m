Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2D7479555
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 21:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbhLQUQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 15:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbhLQUQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:16:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6ADC061574;
        Fri, 17 Dec 2021 12:16:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B728DB827DC;
        Fri, 17 Dec 2021 20:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7C5C36AE2;
        Fri, 17 Dec 2021 20:16:52 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.10-rt24
Date:   Fri, 17 Dec 2021 20:14:55 -0000
Message-ID: <163977209601.1068092.6478895773420516800@puck.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.10-rt24 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: f9d4aa10e7069f629aa65a3980f2bc3c4c387887

Or to build 5.15.10-rt24 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.10.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.10-rt24.patch.xz


You can also build from 5.15.7-rt23 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15.7-rt23-rt24.patch.xz

Enjoy!
Clark

Changes from v5.15.7-rt23:
---

Adrian Hunter (8):
      perf intel-pt: Fix some PGE (packet generation enable/control flow packets) usage
      perf intel-pt: Fix sync state when a PSB (synchronization) packet is found
      perf intel-pt: Fix intel_pt_fup_event() assumptions about setting state type
      perf intel-pt: Fix state setting when receiving overflow (OVF) packet
      perf intel-pt: Fix next 'err' value, walking trace
      perf intel-pt: Fix missing 'instruction' events with 'q' option
      perf intel-pt: Fix error timestamp setting on the decoder error path
      perf inject: Fix itrace space allowed for new attributes

Akhil P Oommen (2):
      drm/msm: Fix null ptr access msm_ioctl_gem_submit()
      drm/msm/a6xx: Fix uinitialized use of gpu_scid

Alaa Hleihel (1):
      RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow

Alan Young (1):
      ALSA: ctl: Fix copy of updated id with element read/write

Alex Hung (1):
      platform/x86/intel: hid: add quirk to support Surface Go 3

Alexander Stein (2):
      dt-bindings: net: Reintroduce PHY no lane swap binding
      Revert "tty: serial: fsl_lpuart: drop earlycon entry for i.MX8QXP"

Alexander Sverdlin (1):
      nfsd: Fix nsfd startup race (again)

Alexey Sheplyakov (1):
      clocksource/drivers/dw_apb_timer_of: Fix probe failure

Alyssa Ross (1):
      iio: trigger: stm32-timer: fix MODULE_ALIAS

Ameer Hamza (1):
      net: dsa: mv88e6xxx: error handling for serdes_power functions

Andrea Mayer (1):
      seg6: fix the iif in the IPv6 socket control block

Antoine Tenart (1):
      ethtool: do not perform operations on net devices being unregistered

Armin Wolf (1):
      hwmon: (dell-smm) Fix warning on /proc/i8k creation error

Arnaldo Carvalho de Melo (1):
      tools build: Remove needless libpython-version feature check that breaks test-all fast path

Bas Nieuwenhuizen (1):
      drm/syncobj: Deal with signalled fences in drm_syncobj_find_fence.

Benjamin Tissoires (2):
      HID: bigbenff: prevent null pointer dereference
      HID: sony: fix error path in probe

Billy Tsai (2):
      hwmon: (pwm-fan) Ensure the fan going on in .probe()
      irqchip/aspeed-scu: Replace update_bits with write_bits.

Bjorn Andersson (1):
      clk: qcom: clk-alpha-pll: Don't reconfigure running Trion

Björn Töpel (1):
      bpf, x86: Fix "no previous prototype" warning

Brian Silverman (1):
      can: m_can: Disable and ignore ELO interrupt

Chen Jun (1):
      tracing: Fix a kmemleak false positive in tracing_map

Chris Packham (1):
      i2c: mpc: Use atomic read and fix break condition

Christophe JAILLET (1):
      RDMA/irdma: Fix a potential memory allocation issue in 'irdma_prm_add_pble_mem()'

Clark Williams (4):
      Merge tag 'v5.15.8' into v5.15-rt
      Merge tag 'v5.15.9' into v5.15-rt
      Merge tag 'v5.15.10' into v5.15-rt
      Linux 5.15.10-rt24

Dan Carpenter (3):
      can: sja1000: fix use after free in ems_pcmcia_add_card()
      net: altera: set a couple error code in probe()
      net/qla3xxx: fix an error code in ql_adapter_up()

David Howells (1):
      netfs: Fix lockdep warning from taking sb_writers whilst holding mmap_lock

Davidlohr Bueso (1):
      block: fix ioprio_get(IOPRIO_WHO_PGRP) vs setuid(2)

Dmitry Baryshkov (1):
      clk: qcom: regmap-mux: fix parent clock lookup

Douglas Anderson (2):
      Revert "usb: dwc3: dwc3-qcom: Enable tx-fifo-resize property by default"
      drm/msm/dp: Avoid unpowered AUX xfers that caused crashes

Eric Biggers (5):
      wait: add wake_up_pollfree()
      binder: use wake_up_pollfree()
      signalfd: use wake_up_pollfree()
      aio: keep poll requests on waitqueue until completed
      aio: fix use-after-free due to missing POLLFREE handling

Eric Dumazet (6):
      bonding: make tx_rebalance_counter an atomic
      netfilter: conntrack: annotate data-races around ct->timeout
      devlink: fix netns refcount leak in devlink_nl_cmd_reload()
      net/sched: fq_pie: prevent dismantle issue
      net, neigh: clear whole pneigh_entry at alloc time
      inet: use #ifdef CONFIG_SOCK_RX_QUEUE_MAPPING consistently

Erik Ekman (1):
      net/mlx4_en: Update reported link modes for 1/10G

Evgeny Boger (1):
      iio: adc: axp20x_adc: fix charging current reporting on AXP22x

Fabrice Gasnier (1):
      iio: adc: stm32: fix a current leak by resetting pcsel before disabling vdda

Fabrizio Bertocci (1):
      platform/x86: amd-pmc: Fix s2idle failures on certain AMD laptops

Flora Cui (2):
      drm/amdgpu: cancel the correct hrtimer on exit
      drm/amdgpu: check atomic flag to differeniate with legacy path

Florian Westphal (1):
      selftests: netfilter: add a vrf+conntrack testcase

Gerald Schaefer (1):
      mm/slub: fix endianness bug for alloc/free_traces attributes

Geraldo Nascimento (1):
      ALSA: usb-audio: Reorder snd_djm_devices[] entries

Greg Kroah-Hartman (12):
      HID: add hid_is_usb() function to make it simpler for USB detection
      HID: add USB_HID dependancy to hid-prodikeys
      HID: add USB_HID dependancy to hid-chicony
      HID: add USB_HID dependancy on some USB HID drivers
      HID: wacom: fix problems when device is not a valid USB device
      HID: check for valid USB device for many HID drivers
      USB: gadget: detect too-big endpoint 0 requests
      USB: gadget: zero allocate endpoint 0 buffers
      Linux 5.15.8
      netfilter: selftest: conntrack_vrf.sh: fix file permission
      Linux 5.15.9
      Linux 5.15.10

Gwendal Grignou (1):
      iio: at91-sama5d2: Fix incorrect sign extension

Hannes Reinecke (1):
      libata: add horkage for ASMedia 1092

Hans de Goede (2):
      HID: quirks: Add quirk for the Microsoft Surface 3 type-cover
      HID: Ignore battery for Elan touchscreen on Asus UX550VE

Harshit Mogalapalli (1):
      net: netlink: af_netlink: Prevent empty skb by adding a check on len.

Helge Deller (1):
      parisc/agp: Annotate parisc agp init functions with __init

Herve Codina (4):
      mtd: rawnand: fsmc: Take instruction delay into account
      mtd: rawnand: fsmc: Fix timing computation
      mtd: rawnand: Fix nand_erase_op delay
      mtd: rawnand: Fix nand_choose_best_timings() on unsupported interface

Ian Rogers (1):
      perf tools: Fix SMT detection fast read path

Igor Pylypiv (1):
      scsi: pm80xx: Do not call scsi_remove_host() in pm8001_alloc()

Ilie Halip (1):
      s390/test_unwind: use raw opcode instead of invalid instruction

J. Bruce Fields (1):
      nfsd: fix use-after-free due to delegation race

Jens Axboe (1):
      io_uring: ensure task_work gets run as part of cancelations

Jesse Brandeburg (1):
      ice: ignore dropped packets during init

Jeya R (1):
      misc: fastrpc: fix improper packet size calculation

Jianglei Nie (1):
      nfp: Fix memory leak in nfp_cpp_area_cache_add()

Jianguo Wu (1):
      udp: using datalen to cap max gso segments

Jiasheng Jiang (1):
      net: bcm4908: Handle dma_set_coherent_mask error codes

Jimmy Assarsson (2):
      can: kvaser_usb: get CAN clock frequency from device
      can: kvaser_pciefd: kvaser_pciefd_rx_error_frame(): increase correct stats->{rx,tx}_errors counter

Joakim Zhang (1):
      net: fec: only clear interrupt of handling queue in fec_enet_rx_queue()

Johannes Thumshirn (1):
      btrfs: free exchange changeset on failures

John Fastabend (2):
      bpf, sockmap: Attach map progs to psock early for feature probes
      bpf, sockmap: Re-evaluate proto ops when psock is removed from sockmap

Jon Hunter (2):
      mtd: dataflash: Add device-tree SPI IDs
      mmc: spi: Add device-tree SPI IDs

Josef Bacik (1):
      btrfs: clear extent buffer uptodate when we fail to write it

José Expósito (1):
      net: dsa: felix: Fix memory leak in felix_setup_mmio_filtering

Kai Vehmanen (2):
      ALSA: hda: Add Intel DG2 PCI ID and HDMI codec vid
      ALSA: hda/hdmi: fix HDA codec entry table order for ADL-P

Kai-Heng Feng (2):
      xhci: Remove CONFIG_USB_DEFAULT_PERSIST to prevent xHCI from runtime suspending
      misc: rtsx: Avoid mangling IRQ during runtime PM

Kailang Yang (1):
      ALSA: hda/realtek - Add headset Mic support for Lenovo ALC897 platform

Karen Sornek (1):
      i40e: Fix failed opcode appearing if handling messages from VF

Kelly Devilliv (1):
      csky: fix typo of fpu config macro

Kister Genesis Jimenez (1):
      iio: gyro: adxrs290: fix data signedness

Krzysztof Kozlowski (1):
      nfc: fix potential NULL pointer deref in nfc_genl_dump_ses_done

Lars-Peter Clausen (8):
      iio: trigger: Fix reference counting
      iio: stk3310: Don't return error code in interrupt handler
      iio: mma8452: Fix trigger reference couting
      iio: ltr501: Don't return error code in trigger handler
      iio: kxsd9: Don't return error code in trigger handler
      iio: itg3200: Call iio_trigger_notify_done() on error
      iio: dln2: Check return value of devm_iio_trigger_register()
      iio: ad7768-1: Call iio_trigger_notify_done() on error

Lee Jones (1):
      net: cdc_ncm: Allow for dwNtbOutMaxSize to be unset or zero

Loic Poulain (1):
      bus: mhi: core: Add support for forced PM resume

Louis Amas (1):
      net: mvpp2: fix XDP rx queues registering

Manish Chopra (1):
      qede: validate non LSO skb length

Manjong Lee (1):
      mm: bdi: initialize bdi_min_ratio when bdi is unregistered

Marc Zyngier (1):
      KVM: arm64: Save PSTATE early on exit

Marek Behún (1):
      Revert "PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge"

Markus Hochholdinger (1):
      md: fix update super 1.0 on rdev size change

Martin Botka (1):
      clk: qcom: sm6125-gcc: Swap ops of ice and apps on sdcc1

Mateusz Palczewski (1):
      i40e: Fix pre-set max number of queues for VF

Mathias Nyman (1):
      xhci: avoid race between disable slot command and host runtime suspend

Matthias Schiffer (2):
      can: m_can: pci: fix incorrect reference clock rate
      can: m_can: pci: fix iomap_read_fifo() and iomap_write_fifo()

Maxim Mikityanskiy (2):
      bpf: Fix the off-by-two error in range markings
      bpf: Add selftests to cover packet access corner cases

Michal Maloszewski (1):
      iavf: Fix reporting when setting descriptor count

Mike Marciniszyn (4):
      IB/hfi1: Insure use of smp_processor_id() is preempt disabled
      IB/hfi1: Fix early init panic
      IB/hfi1: Fix leak of rcvhdrtail_dummy_kvaddr
      IB/hfi1: Correct guard on eager buffer deallocation

Miklos Szeredi (1):
      fuse: make sure reclaim doesn't write the inode

Miles Chen (1):
      clk: imx: use module_platform_driver

Mitch Williams (1):
      iavf: restore MSI state on reset

Mustapha Ghaddar (1):
      drm/amd/display: Fix for the no Audio bug with Tiled Displays

Naohiro Aota (1):
      btrfs: fix re-dirty process of tree-log nodes

Nicholas Kazlauskas (1):
      drm/amd/display: Fix DPIA outbox timeout after S3/S4/reset

Nicolas Dichtel (1):
      vrf: don't run conntrack on vrf with !dflt qdisc

Nikita Yushchenko (1):
      staging: most: dim2: use device release method

Noralf Trønnes (1):
      iio: dln2-adc: Fix lockdep complaint

Norbert Zulinski (1):
      i40e: Fix NULL pointer dereference in i40e_dbg_dump_desc

Ondrej Jirman (1):
      i2c: rk3x: Handle a spurious start completion interrupt flag

Pablo Neira Ayuso (1):
      netfilter: nft_exthdr: break evaluation if setting TCP option fails

Pali Rohár (2):
      irqchip/armada-370-xp: Fix return value of armada_370_xp_msi_alloc()
      irqchip/armada-370-xp: Fix support for Multi-MSI interrupts

Paolo Bonzini (1):
      selftests: KVM: avoid failures due to reserved HyperTransport region

Pavel Hofman (2):
      usb: core: config: fix validation of wMaxPacketValue entries
      usb: core: config: using bit mask instead of individual bits

Pavel Skripkin (1):
      RDMA: Fix use-after-free in rxe_queue_cleanup

Peilin Ye (1):
      selftests/fib_tests: Rework fib_rp_filter_test()

Perry Yuan (1):
      drm/amd/display: add connector type check for CRC source set

Philip Chen (1):
      drm/msm/dsi: set default num_data_lanes

Philip Yang (2):
      drm/amdkfd: fix double free mem structure
      drm/amdkfd: process_info lock not needed for svm

Qu Wenruo (1):
      btrfs: replace the BUG_ON in btrfs_del_root_ref with proper error handling

Rafael J. Wysocki (1):
      PM: runtime: Fix pm_runtime_active() kerneldoc comment

Ralph Siemsen (1):
      nvmem: eeprom: at25: fix FRAM byte_len

Rob Clark (1):
      ASoC: rt5682: Fix crash due to out of scope stack vars

Rob Herring (1):
      dt-bindings: media: nxp,imx7-mipi-csi2: Drop bad if/then schema

Roman Bolshakov (1):
      scsi: qla2xxx: Format log strings only if needed

Ronak Doshi (1):
      vmxnet3: fix minimum vectors alloc issue

Russell King (Oracle) (2):
      net: dsa: mv88e6xxx: fix "don't use PHY_DETECT on internal PHY's"
      net: dsa: mv88e6xxx: allow use of PHYs on CPU and DSA ports

Sean Christopherson (2):
      KVM: x86: Don't WARN if userspace mucks with RCX during string I/O exit
      KVM: x86: Ignore sparse banks size for an "all CPUs", non-sparse IPI req

Sebastian Andrzej Siewior (2):
      bpf: Make sure bpf_disable_instrumentation() is safe vs preemption.
      Documentation/locking/locktypes: Update migrate_disable() bits.

SeongJae Park (2):
      timers: implement usleep_idle_range()
      mm/damon/core: fix fake load reports due to uninterruptible sleeps

Shin'ichiro Kawasaki (1):
      scsi: scsi_debug: Fix buffer size of REPORT ZONES command

Shiraz Saleem (2):
      RDMA/irdma: Fix a user-after-free in add_pble_prm
      RDMA/irdma: Report correct WC errors

Slark Xiao (1):
      bus: mhi: pci_generic: Fix device recovery failed issue

Song Liu (1):
      perf bpf_skel: Do not use typedef to avoid error on old clang

Srinivas Kandagatla (4):
      ASoC: qdsp6: q6routing: Fix return value from msm_routing_put_audio_mixer
      ASoC: codecs: wsa881x: fix return values from kcontrol put
      ASoC: codecs: wcd934x: handle channel mappping list correctly
      ASoC: codecs: wcd934x: return correct value from mixer put

Stefano Brivio (1):
      nft_set_pipapo: Fix bucket load in AVX2 lookup routine for six 8-bit groups

Steven Rostedt (VMware) (2):
      tracefs: Have new files inherit the ownership of their parent
      tracefs: Set all files to the same group ownership as the mount option

Sumeet Pawnikar (1):
      thermal: int340x: Fix VCoRefLow MMIO bit offset for TGL

Tadeusz Struk (1):
      nfc: fix segfault in nfc_genl_dump_devices_done

Takashi Iwai (3):
      ALSA: pcm: oss: Fix negative period/buffer sizes
      ALSA: pcm: oss: Limit the period size to 16MB
      ALSA: pcm: oss: Handle missing errors in snd_pcm_oss_change_params*()

Tatyana Nikolova (1):
      RDMA/irdma: Don't arm the CQ more than two times if no CE for this CQ

Tetsuo Handa (1):
      loop: Use pr_warn_once() for loop_control_remove() warning

Thomas Haemmerle (1):
      usb: gadget: uvc: fix multiple opens

Thomas Weißschuh (1):
      HID: intel-ish-hid: ipc: only enable IRQ wakeup when requested

Tom Lendacky (1):
      x86/sme: Explicitly map new EFI memmap table as encrypted

Vincent Mailhol (2):
      can: pch_can: pch_can_rx_normal: fix use after free
      can: m_can: m_can_read_fifo: fix memory leak in error branch

Vincent Whitchurch (2):
      cifs: Fix crash on unload of cifs_arc4.ko
      i2c: virtio: fix completion handling

Vitaly Kuznetsov (1):
      KVM: x86: Wait for IPIs to be delivered when handling Hyper-V TLB flush hypercall

Vladimir Murzin (1):
      irqchip: nvic: Fix offset for Interrupt Priority Offsets

Werner Sembach (1):
      ALSA: hda/realtek: Fix quirk for TongFang PHxTxX1

Wilken Gottwalt (1):
      hwmon: (corsair-psu) fix plain integer used as NULL pointer

Wolfram Sang (1):
      mmc: renesas_sdhi: initialize variable properly when tuning

Wudi Wang (1):
      irqchip/irq-gic-v3-its.c: Force synchronisation when issuing INVALL

Xie Yongji (1):
      aio: Fix incorrect usage of eventfd_signal_allowed()

Yahui Cao (1):
      ice: fix FDIR init missing when reset VF

Yang Yingliang (1):
      iio: accel: kxcjk-1013: Fix possible memory leak in probe and remove

Yangyang Li (2):
      RDMA/hns: Do not halt commands during reset until later
      RDMA/hns: Do not destroy QP resources in the hw resetting phase

xiazhengqiao (1):
      HID: google: add eel USB id
---
.../bindings/media/nxp,imx7-mipi-csi2.yaml         |  14 +-
 .../devicetree/bindings/net/ethernet-phy.yaml      |   8 +
 Documentation/locking/locktypes.rst                |   9 +-
 Makefile                                           |   2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |   6 +
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |   7 +-
 arch/csky/kernel/traps.c                           |   4 +-
 arch/s390/lib/test_unwind.c                        |   5 +-
 arch/x86/Kconfig                                   |   1 +
 arch/x86/include/asm/kvm_host.h                    |   2 +-
 arch/x86/kvm/hyperv.c                              |   7 +-
 arch/x86/kvm/x86.c                                 |   9 +-
 arch/x86/platform/efi/quirks.c                     |   3 +-
 block/ioprio.c                                     |   3 +
 drivers/android/binder.c                           |  21 +-
 drivers/ata/libata-core.c                          |   2 +
 drivers/block/loop.c                               |   2 +-
 drivers/bus/mhi/core/pm.c                          |  21 +-
 drivers/bus/mhi/pci_generic.c                      |   2 +-
 drivers/char/agp/parisc-agp.c                      |   6 +-
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 |   2 +-
 drivers/clk/imx/clk-imx8qxp.c                      |   2 +-
 drivers/clk/qcom/clk-alpha-pll.c                   |   9 +
 drivers/clk/qcom/clk-regmap-mux.c                  |   2 +-
 drivers/clk/qcom/common.c                          |  12 +
 drivers/clk/qcom/common.h                          |   2 +
 drivers/clk/qcom/gcc-sm6125.c                      |   4 +-
 drivers/clocksource/dw_apb_timer_of.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |   9 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   7 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |   8 +
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   4 +
 drivers/gpu/drm/drm_syncobj.c                      |  11 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  18 +-
 drivers/gpu/drm/msm/dp/dp_aux.c                    |  17 +
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |   2 +
 drivers/gpu/drm/msm/msm_gem_submit.c               |   1 +
 drivers/hid/Kconfig                                |  10 +-
 drivers/hid/hid-asus.c                             |   6 +-
 drivers/hid/hid-bigbenff.c                         |   2 +-
 drivers/hid/hid-chicony.c                          |   3 +
 drivers/hid/hid-corsair.c                          |   7 +-
 drivers/hid/hid-elan.c                             |   2 +-
 drivers/hid/hid-elo.c                              |   3 +
 drivers/hid/hid-ft260.c                            |   3 +
 drivers/hid/hid-google-hammer.c                    |   2 +
 drivers/hid/hid-holtek-kbd.c                       |   9 +-
 drivers/hid/hid-holtek-mouse.c                     |   9 +
 drivers/hid/hid-ids.h                              |   3 +
 drivers/hid/hid-input.c                            |   2 +
 drivers/hid/hid-lg.c                               |  10 +-
 drivers/hid/hid-logitech-dj.c                      |   2 +-
 drivers/hid/hid-prodikeys.c                        |  10 +-
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/hid/hid-roccat-arvo.c                      |   3 +
 drivers/hid/hid-roccat-isku.c                      |   3 +
 drivers/hid/hid-roccat-kone.c                      |   3 +
 drivers/hid/hid-roccat-koneplus.c                  |   3 +
 drivers/hid/hid-roccat-konepure.c                  |   3 +
 drivers/hid/hid-roccat-kovaplus.c                  |   3 +
 drivers/hid/hid-roccat-lua.c                       |   3 +
 drivers/hid/hid-roccat-pyra.c                      |   3 +
 drivers/hid/hid-roccat-ryos.c                      |   3 +
 drivers/hid/hid-roccat-savu.c                      |   3 +
 drivers/hid/hid-samsung.c                          |   3 +
 drivers/hid/hid-sony.c                             |  24 +-
 drivers/hid/hid-thrustmaster.c                     |   3 +
 drivers/hid/hid-u2fzero.c                          |   2 +-
 drivers/hid/hid-uclogic-core.c                     |   3 +
 drivers/hid/hid-uclogic-params.c                   |   3 +-
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |   6 +-
 drivers/hid/wacom_sys.c                            |  19 +-
 drivers/hwmon/corsair-psu.c                        |   2 +-
 drivers/hwmon/dell-smm-hwmon.c                     |   7 +-
 drivers/hwmon/pwm-fan.c                            |   2 -
 drivers/i2c/busses/i2c-mpc.c                       |   2 +-
 drivers/i2c/busses/i2c-rk3x.c                      |   4 +-
 drivers/i2c/busses/i2c-virtio.c                    |  32 +-
 drivers/iio/accel/kxcjk-1013.c                     |   5 +-
 drivers/iio/accel/kxsd9.c                          |   6 +-
 drivers/iio/accel/mma8452.c                        |   2 +-
 drivers/iio/adc/ad7768-1.c                         |   2 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |   3 +-
 drivers/iio/adc/axp20x_adc.c                       |  18 +-
 drivers/iio/adc/dln2-adc.c                         |  21 +-
 drivers/iio/adc/stm32-adc.c                        |   1 +
 drivers/iio/gyro/adxrs290.c                        |   5 +-
 drivers/iio/gyro/itg3200_buffer.c                  |   2 +-
 drivers/iio/industrialio-trigger.c                 |   1 -
 drivers/iio/light/ltr501.c                         |   2 +-
 drivers/iio/light/stk3310.c                        |   6 +-
 drivers/iio/trigger/stm32-timer-trigger.c          |   2 +-
 drivers/infiniband/hw/hfi1/chip.c                  |   2 +
 drivers/infiniband/hw/hfi1/driver.c                |   2 +
 drivers/infiniband/hw/hfi1/init.c                  |  40 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  14 +-
 drivers/infiniband/hw/irdma/hw.c                   |   7 +-
 drivers/infiniband/hw/irdma/main.h                 |   1 +
 drivers/infiniband/hw/irdma/pble.c                 |   8 +-
 drivers/infiniband/hw/irdma/pble.h                 |   1 -
 drivers/infiniband/hw/irdma/utils.c                |  24 +-
 drivers/infiniband/hw/irdma/verbs.c                |  23 +-
 drivers/infiniband/hw/irdma/verbs.h                |   2 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   6 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  26 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   1 +
 drivers/irqchip/irq-armada-370-xp.c                |  16 +-
 drivers/irqchip/irq-aspeed-scu-ic.c                |   4 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   2 +-
 drivers/irqchip/irq-nvic.c                         |   2 +-
 drivers/md/md.c                                    |   1 +
 drivers/misc/cardreader/rtsx_pcr.c                 |   4 -
 drivers/misc/eeprom/at25.c                         |  38 +-
 drivers/misc/fastrpc.c                             |  10 +-
 drivers/mmc/host/mmc_spi.c                         |   7 +
 drivers/mmc/host/renesas_sdhi_core.c               |   2 +-
 drivers/mtd/devices/mtd_dataflash.c                |   8 +
 drivers/mtd/nand/raw/fsmc_nand.c                   |  36 +-
 drivers/mtd/nand/raw/nand_base.c                   |   6 +-
 drivers/net/bonding/bond_alb.c                     |  14 +-
 drivers/net/can/kvaser_pciefd.c                    |   8 +-
 drivers/net/can/m_can/m_can.c                      |  18 +-
 drivers/net/can/m_can/m_can_pci.c                  |  16 +-
 drivers/net/can/pch_can.c                          |   2 +-
 drivers/net/can/sja1000/ems_pcmcia.c               |   7 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   | 101 +++-
 drivers/net/dsa/mv88e6xxx/chip.c                   |  85 +--
 drivers/net/dsa/mv88e6xxx/serdes.c                 |   8 +-
 drivers/net/dsa/ocelot/felix.c                     |   5 +-
 drivers/net/ethernet/altera/altera_tse_main.c      |   9 +-
 drivers/net/ethernet/broadcom/bcm4908_enet.c       |   4 +-
 drivers/net/ethernet/freescale/fec.h               |   3 +
 drivers/net/ethernet/freescale/fec_main.c          |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   8 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  75 ++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   2 +
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  43 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c          |   3 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c   |   2 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   4 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   6 +-
 .../ethernet/netronome/nfp/nfpcore/nfp_cppcore.c   |   4 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c         |   7 +
 drivers/net/ethernet/qlogic/qla3xxx.c              |  19 +-
 drivers/net/usb/cdc_ncm.c                          |   2 +
 drivers/net/vmxnet3/vmxnet3_drv.c                  |  13 +-
 drivers/net/vrf.c                                  |   8 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |   6 +-
 drivers/pci/controller/pci-aardvark.c              |   9 -
 drivers/platform/x86/amd-pmc.c                     |   2 +-
 drivers/platform/x86/intel/hid.c                   |   7 +
 drivers/scsi/pm8001/pm8001_init.c                  |   6 +-
 drivers/scsi/qla2xxx/qla_dbg.c                     |   3 +
 drivers/scsi/scsi_debug.c                          |   2 +-
 drivers/staging/most/dim2/dim2.c                   |  55 +-
 .../intel/int340x_thermal/processor_thermal_rfim.c |   2 +-
 drivers/tty/serial/fsl_lpuart.c                    |   1 +
 drivers/usb/core/config.c                          |   6 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |  15 -
 drivers/usb/gadget/composite.c                     |  14 +-
 drivers/usb/gadget/function/uvc.h                  |   2 +
 drivers/usb/gadget/function/uvc_v4l2.c             |  49 +-
 drivers/usb/gadget/legacy/dbgp.c                   |  15 +-
 drivers/usb/gadget/legacy/inode.c                  |  16 +-
 drivers/usb/host/xhci-hub.c                        |   1 +
 drivers/usb/host/xhci-ring.c                       |   1 -
 drivers/usb/host/xhci.c                            |  26 +-
 fs/aio.c                                           | 186 ++++--
 fs/btrfs/delalloc-space.c                          |  12 +-
 fs/btrfs/extent_io.c                               |   6 +
 fs/btrfs/root-tree.c                               |   3 +-
 fs/btrfs/tree-log.c                                |   5 +-
 fs/fuse/dir.c                                      |   8 +
 fs/fuse/file.c                                     |  15 +
 fs/fuse/fuse_i.h                                   |   1 +
 fs/fuse/inode.c                                    |   3 +
 fs/io_uring.c                                      |   6 +-
 fs/netfs/read_helper.c                             |  15 +-
 fs/nfsd/nfs4recover.c                              |   1 +
 fs/nfsd/nfs4state.c                                |   9 +-
 fs/nfsd/nfsctl.c                                   |  14 +-
 fs/signalfd.c                                      |  12 +-
 fs/smbfs_common/cifs_arc4.c                        |  13 -
 fs/tracefs/inode.c                                 |  76 +++
 include/linux/bpf.h                                |  17 +-
 include/linux/delay.h                              |  14 +-
 include/linux/filter.h                             |   3 -
 include/linux/hid.h                                |   5 +
 include/linux/mhi.h                                |  13 +
 include/linux/pm_runtime.h                         |   2 +-
 include/linux/wait.h                               |  26 +
 include/net/bond_alb.h                             |   2 +-
 include/net/netfilter/nf_conntrack.h               |   6 +-
 include/uapi/asm-generic/poll.h                    |   2 +-
 kernel/bpf/verifier.c                              |   2 +-
 kernel/sched/wait.c                                |   7 +
 kernel/time/timer.c                                |  16 +-
 kernel/trace/tracing_map.c                         |   3 +
 localversion-rt                                    |   2 +-
 mm/backing-dev.c                                   |   7 +
 mm/damon/core.c                                    |  14 +-
 mm/slub.c                                          |  15 +-
 net/core/devlink.c                                 |  16 +-
 net/core/neighbour.c                               |   3 +-
 net/core/skmsg.c                                   |   5 +
 net/core/sock_map.c                                |  15 +-
 net/ethtool/netlink.c                              |   3 +-
 net/ipv4/inet_connection_sock.c                    |   2 +-
 net/ipv4/udp.c                                     |   2 +-
 net/ipv6/seg6_iptunnel.c                           |   8 +
 net/netfilter/nf_conntrack_core.c                  |   6 +-
 net/netfilter/nf_conntrack_netlink.c               |   2 +-
 net/netfilter/nf_flow_table_core.c                 |   4 +-
 net/netfilter/nft_exthdr.c                         |  11 +-
 net/netfilter/nft_set_pipapo_avx2.c                |   2 +-
 net/netlink/af_netlink.c                           |   5 +
 net/nfc/netlink.c                                  |  12 +-
 net/sched/sch_fq_pie.c                             |   1 +
 sound/core/control_compat.c                        |   3 +
 sound/core/oss/pcm_oss.c                           |  37 +-
 sound/pci/hda/hda_intel.c                          |  12 +-
 sound/pci/hda/patch_hdmi.c                         |   3 +-
 sound/pci/hda/patch_realtek.c                      |  80 ++-
 sound/soc/codecs/rt5682.c                          |  10 +-
 sound/soc/codecs/wcd934x.c                         | 126 ++--
 sound/soc/codecs/wsa881x.c                         |  16 +-
 sound/soc/qcom/qdsp6/q6routing.c                   |   8 +-
 sound/usb/mixer_quirks.c                           |  10 +-
 tools/build/Makefile.feature                       |   1 -
 tools/build/feature/Makefile                       |   4 -
 tools/build/feature/test-all.c                     |   5 -
 tools/build/feature/test-libpython-version.c       |  11 -
 tools/perf/Makefile.config                         |   2 -
 tools/perf/builtin-inject.c                        |   2 +-
 tools/perf/util/bpf_skel/bperf.h                   |  14 -
 tools/perf/util/bpf_skel/bperf_follower.bpf.c      |  16 +-
 tools/perf/util/bpf_skel/bperf_leader.bpf.c        |  16 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  85 ++-
 tools/perf/util/intel-pt.c                         |   1 +
 tools/perf/util/smt.c                              |   2 +-
 .../bpf/verifier/xdp_direct_packet_access.c        | 632 +++++++++++++++++++--
 tools/testing/selftests/kvm/include/kvm_util.h     |   9 +
 tools/testing/selftests/kvm/lib/kvm_util.c         |   2 +-
 tools/testing/selftests/kvm/lib/x86_64/processor.c |  68 +++
 tools/testing/selftests/net/fib_tests.sh           |  59 +-
 tools/testing/selftests/netfilter/Makefile         |   3 +-
 tools/testing/selftests/netfilter/conntrack_vrf.sh | 241 ++++++++
 252 files changed, 2784 insertions(+), 908 deletions(-)
---
