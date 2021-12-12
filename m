Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBE5471EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 00:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhLLXZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 18:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhLLXZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 18:25:13 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E52C06173F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 15:25:12 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r11so46119224edd.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 15:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3b/ytluM62eCnLPa2S2rvS12xwfrzOQIYtndh7SHyJQ=;
        b=Qd9kq7gtGaxQNLAT0/q0Bxx0OC9oKbsAYgCtRGV9lmh/v1hafa0lBGBWP5QUbCJxqX
         S/yrHliqSF7ZjdG2gc61nPkHDGYY1J45RWibwkyhpMUQm5sA9f/eNv4iGDB/CUcQKJgb
         IVnZZ0cLEbrVpcTpILenbiodgklr9q2hiLd+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3b/ytluM62eCnLPa2S2rvS12xwfrzOQIYtndh7SHyJQ=;
        b=6LhIVr7ZWIgm8p/+ZUVqrtRmbCiJR2G5FxJR1zvO17hdJwu6jo3R3V2DiCVOA1buTi
         lWG/oTEYaA4Ts94RGeiGA1ziEv7JD94I1a0qeqTI+6YUpGk+R8yjIIJGw3B4DL6KZ2Lg
         W9tQDPbuPwzXIjw3m2Hx0AbgIeE2UBkOz5FvCo+e1xs8uqJPw6Ntvw0IUon0up+oHG/x
         oNujrIDzXG1s/rGlCK3lM3TbfmxPDxPEhr+LoJPSey71FjKmKrddu6Oqy21Gs8WMy6fh
         oi3FETpjlwKTAJgGh4OJJkI622TkELIe1RfNuyIik24lqBhYPsJZmq+k+tnj5N9KXd0W
         tloA==
X-Gm-Message-State: AOAM532Udn5uIIJq7qUNyAtAl2CpS6pDSBLtNFtkFGSwGhw99vwyY7/6
        /nAyX+WzVCVsS/UJjwfY0DkTI/RkCP54HjLc
X-Google-Smtp-Source: ABdhPJxvCxoc+8ysZvsJ7fv1Z39rNdPyxZKeLoNYAhlK4NspgzC4QI2onspy3kWN6N+301Aivey1Dw==
X-Received: by 2002:a50:eb85:: with SMTP id y5mr60339012edr.173.1639351510138;
        Sun, 12 Dec 2021 15:25:10 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id jg36sm5177586ejc.44.2021.12.12.15.25.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 15:25:09 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id y196so10770338wmc.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 15:25:09 -0800 (PST)
X-Received: by 2002:a1c:800e:: with SMTP id b14mr33478547wmd.155.1639351509090;
 Sun, 12 Dec 2021 15:25:09 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Dec 2021 15:24:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wixe1NPqC0PmgUbV0Xoa8D0Pbyu7X_0sfABYMG+ocLdbQ@mail.gmail.com>
Message-ID: <CAHk-=wixe1NPqC0PmgUbV0Xoa8D0Pbyu7X_0sfABYMG+ocLdbQ@mail.gmail.com>
Subject: Linux 5.16-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So everything looks fairly normal. This rc5 is perhaps a bit bigger
than usual, but it's not like it's breaking any records. I blame
people trying to get stuff done before the holidays, and/or just
random timing effects.

Anyway, I do expect things to calm down over the next couple of weeks,
but we'll see.

As to rc5, the patch is dominated by drivers (network, sound, hid,
rdma, usb... and a lot of other random things) and selftest updates
(bpf, kvm and networking).

The rest is fairly random - filesystems (cifs, btrfs, tracefs), core
kernel and networking. Some fixups to the new damon virtual address
space monitoring code.

Shortlog appended.

Do give it a good testing - with the holidays coming up, things are
probably going to slow down both on the development and testing front,
and as a result I expect that I will also extend the rc series by
another week not because it's necessarily needed (too early to tell,
but doesn't feel that way), but simply because nobody will want to
open the next merge window immediately in the new year.

Anyway, that's the plan right now (based on previous years where we've
done the same), but let's see how this all goes.

                 Linus

---

Adrian Hunter (8):
      perf inject: Fix itrace space allowed for new attributes
      perf intel-pt: Fix some PGE (packet generation enable/control
flow packets) usage
      perf intel-pt: Fix sync state when a PSB (synchronization) packet is =
found
      perf intel-pt: Fix intel_pt_fup_event() assumptions about
setting state type
      perf intel-pt: Fix state setting when receiving overflow (OVF) packet
      perf intel-pt: Fix next 'err' value, walking trace
      perf intel-pt: Fix missing 'instruction' events with 'q' option
      perf intel-pt: Fix error timestamp setting on the decoder error path

Akira Yokosawa (1):
      docs: admin-guide/blockdev: Remove digraph of node-states

Alaa Hleihel (1):
      RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow

Alan Young (1):
      ALSA: ctl: Fix copy of updated id with element read/write

Alex Hung (1):
      platform/x86/intel: hid: add quirk to support Surface Go 3

Alexander Stein (1):
      dt-bindings: net: Reintroduce PHY no lane swap binding

Alexander Sverdlin (1):
      nfsd: Fix nsfd startup race (again)

Alexey Sheplyakov (1):
      clocksource/drivers/dw_apb_timer_of: Fix probe failure

Alyssa Ross (1):
      iio: trigger: stm32-timer: fix MODULE_ALIAS

Ameer Hamza (2):
      gve: fix for null pointer dereference.
      net: dsa: mv88e6xxx: error handling for serdes_power functions

Amelie Delaunay (1):
      phy: stm32: fix st,slow-hs-slew-rate with st,decrease-hs-slew-rate

Andrea Mayer (1):
      seg6: fix the iif in the IPv6 socket control block

Andy Shevchenko (1):
      percpu_ref: Replace kernel.h with the necessary inclusions

Antoine Tenart (1):
      ethtool: do not perform operations on net devices being unregistered

Armin Wolf (1):
      hwmon: (dell-smm) Fix warning on /proc/i8k creation error

Arnaldo Carvalho de Melo (4):
      Documentation: Add minimum pahole version
      tools headers UAPI: Sync s390 syscall table file changed by new
futex_waitv syscall
      tools headers UAPI: Sync powerpc syscall table file changed by
new futex_waitv syscall
      tools build: Remove needless libpython-version feature check
that breaks test-all fast path

Bas Nieuwenhuizen (1):
      drm/syncobj: Deal with signalled fences in drm_syncobj_find_fence.

Benjamin Tissoires (2):
      HID: sony: fix error path in probe
      HID: bigbenff: prevent null pointer dereference

Billy Tsai (2):
      irqchip/aspeed-scu: Replace update_bits with write_bits.
      hwmon: (pwm-fan) Ensure the fan going on in .probe()

Bjorn Andersson (1):
      clk: qcom: clk-alpha-pll: Don't reconfigure running Trion

Bj=C3=B6rn T=C3=B6pel (1):
      bpf, x86: Fix "no previous prototype" warning

Brian Silverman (1):
      can: m_can: Disable and ignore ELO interrupt

Cai Huoqing (1):
      mtd: rawnand: denali: Add the dependency on HAS_IOMEM

Chen Yu (1):
      ACPI: tools: Fix compilation when output directory is not present

Chris Packham (1):
      i2c: mpc: Use atomic read and fix break condition

Christian K=C3=B6nig (1):
      drm/ttm: fix ttm_bo_swapout

Christoph Hellwig (1):
      mtd_blkdevs: don't scan partitions for plain mtdblock

Christophe JAILLET (1):
      RDMA/irdma: Fix a potential memory allocation issue in
'irdma_prm_add_pble_mem()'

Damien Le Moal (1):
      ata: ahci_ceva: Fix id array access in ceva_ahci_read_id()

Dan Carpenter (8):
      phy: HiSilicon: Fix copy and paste bug in error handling
      ASoC: amd: fix uninitialized variable in snd_acp6x_probe()
      net: altera: set a couple error code in probe()
      can: sja1000: fix use after free in ems_pcmcia_add_card()
      net/qla3xxx: fix an error code in ql_adapter_up()
      clk: versatile: clk-icst: use after free on error path
      btrfs: fix error pointer dereference in btrfs_ioctl_rm_dev_v2()
      drm/i915: Fix error pointer dereference in i915_gem_do_execbuffer()

Darrick J. Wong (1):
      xfs: remove all COW fork extents when remounting readonly

Dave Ertman (1):
      ice: Fix problems with DSCP QoS implementation

Dave Young (1):
      MAINTAINERS: update kdump maintainers

David Heidelberg (1):
      ASoC: dt-bindings: wlf,wm8962: add missing interrupt property

David Howells (1):
      netfs: Fix lockdep warning from taking sb_writers whilst holding mmap=
_lock

David Mosberger-Tang (1):
      hwmon: (sht4x) Fix EREMOTEIO errors

Davidlohr Bueso (1):
      block: fix ioprio_get(IOPRIO_WHO_PGRP) vs setuid(2)

Dmitry Baryshkov (1):
      clk: qcom: regmap-mux: fix parent clock lookup

Donghyeok Kim (1):
      irqchip/apple-aic: Mark aic_init_smp() as __init

Doug Ledford (1):
      Remove Doug Ledford from MAINTAINERS

Douglas Anderson (1):
      Revert "usb: dwc3: dwc3-qcom: Enable tx-fifo-resize property by defau=
lt"

Drew DeVault (1):
      Increase default MLOCK_LIMIT to 8 MiB

Eric Biggers (5):
      wait: add wake_up_pollfree()
      binder: use wake_up_pollfree()
      signalfd: use wake_up_pollfree()
      aio: keep poll requests on waitqueue until completed
      aio: fix use-after-free due to missing POLLFREE handling

Eric Dumazet (7):
      inet: use #ifdef CONFIG_SOCK_RX_QUEUE_MAPPING consistently
      tcp: fix another uninit-value (sk_rx_queue_mapping)
      bonding: make tx_rebalance_counter an atomic
      devlink: fix netns refcount leak in devlink_nl_cmd_reload()
      netfilter: conntrack: annotate data-races around ct->timeout
      net, neigh: clear whole pneigh_entry at alloc time
      net/sched: fq_pie: prevent dismantle issue

Erik Ekman (1):
      Documentation/process: fix self reference

Evgeny Boger (1):
      iio: adc: axp20x_adc: fix charging current reporting on AXP22x

Fabrice Gasnier (1):
      iio: adc: stm32: fix a current leak by resetting pcsel before
disabling vdda

Fabrizio Bertocci (1):
      platform/x86: amd-pmc: Fix s2idle failures on certain AMD laptops

Florian Westphal (2):
      netfilter: nfnetlink_queue: silence bogus compiler warning
      selftests: netfilter: switch zone stress to socat

Geert Uytterhoeven (3):
      irqchip/mips-gic: Use bitfield helpers
      dt-bindings: iio: adc: exynos-adc: Fix node name in example
      dt-bindings: input: gpio-keys: Fix interrupts in example

Gerald Schaefer (1):
      mm/slub: fix endianness bug for alloc/free_traces attributes

Geraldo Nascimento (1):
      ALSA: usb-audio: Reorder snd_djm_devices[] entries

German Gomez (1):
      perf tools: Prevent out-of-bounds access to registers

Greg Kroah-Hartman (8):
      HID: add hid_is_usb() function to make it simpler for USB detection
      HID: wacom: fix problems when device is not a valid USB device
      HID: check for valid USB device for many HID drivers
      HID: add USB_HID dependancy on some USB HID drivers
      HID: add USB_HID dependancy to hid-chicony
      HID: add USB_HID dependancy to hid-prodikeys
      USB: gadget: detect too-big endpoint 0 requests
      USB: gadget: zero allocate endpoint 0 buffers

Guo Ren (1):
      mailmap: update email address for Guo Ren

Guoqing Jiang (1):
      RDMA/rtrs: Call {get,put}_cpu_ptr to silence a debug kernel warning

Gwendal Grignou (1):
      iio: at91-sama5d2: Fix incorrect sign extension

Hannes Reinecke (1):
      libata: add horkage for ASMedia 1092

Hans de Goede (5):
      platform/x86: thinkpad_acpi: Restore missing hotkey_tablet_mode
and hotkey_radio_sw sysfs-attr
      platform/x86: thinkpad_acpi: Add lid_logo_dot to the list of safe LED=
s
      platform/x86: touchscreen_dmi: Add TrekStor SurfTab duo W1
touchscreen info
      HID: quirks: Add quirk for the Microsoft Surface 3 type-cover
      HID: Ignore battery for Elan touchscreen on Asus UX550VE

Herve Codina (4):
      mtd: rawnand: Fix nand_erase_op delay
      mtd: rawnand: Fix nand_choose_best_timings() on unsupported interface
      mtd: rawnand: fsmc: Take instruction delay into account
      mtd: rawnand: fsmc: Fix timing computation

Hou Tao (1):
      nvme-multipath: set ana_log_size to 0 after free ana_log_buf

Hui Wang (1):
      ASoC: SOF: Intel: Retry codec probing if it fails

Ian Rogers (3):
      perf tools: Fix SMT detection fast read path
      perf test: Reset shadow counts before loading
      perf header: Fix memory leaks when processing feature headers

Igor Pylypiv (1):
      scsi: pm80xx: Do not call scsi_remove_host() in pm8001_alloc()

J. Bruce Fields (1):
      nfsd: fix use-after-free due to delegation race

Jakub Kicinski (1):
      treewide: Add missing includes masked by cgroup -> bpf dependency

Jeffle Xu (1):
      netfs: fix parameter of cleanup()

Jens Axboe (4):
      io-wq: remove spurious bit clear on task_work addition
      Revert "mtd_blkdevs: don't scan partitions for plain mtdblock"
      io_uring: ensure task_work gets run as part of cancelations
      io-wq: check for wq exit after adding new worker task_work

Jesse Brandeburg (2):
      ice: ignore dropped packets during init
      ice: safer stats processing

Jeya R (1):
      misc: fastrpc: fix improper packet size calculation

Jianglei Nie (1):
      nfp: Fix memory leak in nfp_cpp_area_cache_add()

Jianguo Wu (1):
      udp: using datalen to cap max gso segments

Jiasheng Jiang (1):
      net: bcm4908: Handle dma_set_coherent_mask error codes

Jimmy Assarsson (2):
      can: kvaser_pciefd: kvaser_pciefd_rx_error_frame(): increase
correct stats->{rx,tx}_errors counter
      can: kvaser_usb: get CAN clock frequency from device

Jiri Olsa (4):
      Revert "perf bench: Fix two memory leaks detected with ASan"
      ftrace: Use direct_ops hash in unregister_ftrace_direct
      ftrace: Add cleanup to unregister_ftrace_direct_multi
      ftrace/samples: Add module to test multi direct modify interface

Joakim Zhang (1):
      net: fec: only clear interrupt of handling queue in fec_enet_rx_queue=
()

Johan Almbladh (1):
      mips, bpf: Fix reference to non-existing Kconfig symbol

Johannes Thumshirn (2):
      btrfs: free exchange changeset on failures
      btrfs: zoned: clear data relocation bg on zone finish

John Fastabend (2):
      bpf, sockmap: Attach map progs to psock early for feature probes
      bpf, sockmap: Re-evaluate proto ops when psock is removed from sockma=
p

Jon Hunter (1):
      mtd: dataflash: Add device-tree SPI IDs

Josef Bacik (3):
      btrfs: fail if fstrim_range->start =3D=3D U64_MAX
      btrfs: clear extent buffer uptodate when we fail to write it
      btrfs: call mapping_set_error() on btree inode with a write error

Jos=C3=A9 Exp=C3=B3sito (2):
      net: mana: Fix memory leak in mana_hwc_create_wq
      net: dsa: felix: Fix memory leak in felix_setup_mmio_filtering

Julian Wiedmann (1):
      MAINTAINERS: s390/net: remove myself as maintainer

Kai-Heng Feng (2):
      misc: rtsx: Avoid mangling IRQ during runtime PM
      xhci: Remove CONFIG_USB_DEFAULT_PERSIST to prevent xHCI from
runtime suspending

Kailang Yang (1):
      ALSA: hda/realtek - Add headset Mic support for Lenovo ALC897 platfor=
m

Karen Sornek (1):
      i40e: Fix failed opcode appearing if handling messages from VF

Keith Busch (2):
      nvme: show subsys nqn for duplicate cntlids
      nvme: disable namespace access for unsupported metadata

Kelly Devilliv (1):
      csky: fix typo of fpu config macro

Kister Genesis Jimenez (1):
      iio: gyro: adxrs290: fix data signedness

Krzysztof Kozlowski (1):
      nfc: fix potential NULL pointer deref in nfc_genl_dump_ses_done

Kumar Kartikeya Dwivedi (3):
      bpf: Make CONFIG_DEBUG_INFO_BTF depend upon CONFIG_BPF_SYSCALL
      bpf: Fix bpf_check_mod_kfunc_call for built-in modules
      tools/resolve_btfids: Skip unresolved symbol warning for empty BTF se=
ts

Lai Jiangshan (1):
      KVM: X86: Raise #GP when clearing CR0_PG in 64 bit mode

Lars-Peter Clausen (8):
      iio: ltr501: Don't return error code in trigger handler
      iio: kxsd9: Don't return error code in trigger handler
      iio: stk3310: Don't return error code in interrupt handler
      iio: mma8452: Fix trigger reference couting
      iio: trigger: Fix reference counting
      iio: dln2: Check return value of devm_iio_trigger_register()
      iio: itg3200: Call iio_trigger_notify_done() on error
      iio: ad7768-1: Call iio_trigger_notify_done() on error

Lee Jones (1):
      net: cdc_ncm: Allow for dwNtbOutMaxSize to be unset or zero

Li Zhijian (4):
      selftests/tc-testing: add exit code
      selftests/tc-testing: add missing config
      selftests/tc-testing: Fix cannot create
/sys/bus/netdevsim/new_device: Directory nonexistent
      selftests: net/fcnal-test.sh: add exit code

Liam Beguin (1):
      dt-bindings: phy: zynqmp-psgtr: fix USB phy name

Linus Torvalds (1):
      Linux 5.16-rc5

Loic Poulain (1):
      bus: mhi: core: Add support for forced PM resume

Louis Amas (1):
      net: mvpp2: fix XDP rx queues registering

Lukas Bulwahn (1):
      iio: imx8qxp-adc: fix dependency to the intended ARCH_MXC config

M Chetan Kumar (3):
      net: wwan: iosm: fixes unnecessary doorbell send
      net: wwan: iosm: fixes net interface nonfunctional after fw flash
      net: wwan: iosm: fixes unable to send AT command during mbim tx

Maciej S. Szmigiero (1):
      KVM: x86: selftests: svm_int_ctl_test: fix intercept calculation

Manish Chopra (1):
      qede: validate non LSO skb length

Manish Rangankar (1):
      scsi: qedi: Fix cmd_cleanup_cmpl counter mismatch issue

Manjong Lee (1):
      mm: bdi: initialize bdi_min_ratio when bdi is unregistered

Marc Zyngier (5):
      of/irq: Add a quirk for controllers with their own definition of
interrupt-map
      PCI: apple: Follow the PCIe specifications when resetting the port
      arm64: dts: apple: t8103: Mark PCIe PERST# polarity active low in DT
      PCI: apple: Fix PERST# polarity
      clocksource/drivers/arm_arch_timer: Force inlining of
erratum_set_next_event_generic()

Marek Beh=C3=BAn (1):
      Revert "PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on
emulated bridge"

Markus Hochholdinger (1):
      md: fix update super 1.0 on rdev size change

Martin Botka (1):
      clk: qcom: sm6125-gcc: Swap ops of ice and apps on sdcc1

Matan Ziv-Av (1):
      platform/x86: lg-laptop: Recognize more models

Mateusz Palczewski (1):
      i40e: Fix pre-set max number of queues for VF

Mathias Nyman (1):
      xhci: avoid race between disable slot command and host runtime suspen=
d

Matthew Wilcox (Oracle) (1):
      filemap: remove PageHWPoison check from next_uptodate_page()

Matthias Schiffer (5):
      can: m_can: pci: fix iomap_read_fifo() and iomap_write_fifo()
      can: m_can: pci: fix incorrect reference clock rate
      Revert "can: m_can: remove support for custom bit timing"
      can: m_can: make custom bittiming fields const
      can: m_can: pci: use custom bit timings for Elkhart Lake

Matti Vaittinen (1):
      regulator: Update protection IRQ helper docs

Mauro Carvalho Chehab (1):
      docs: conf.py: fix support for Readthedocs v 1.0.0

Maxim Mikityanskiy (2):
      bpf: Fix the off-by-two error in range markings
      bpf: Add selftests to cover packet access corner cases

Miaoqian Lin (2):
      tracing: Fix possible memory leak in __create_synth_event() error pat=
h
      perf python: Fix NULL vs IS_ERR_OR_NULL() checking

Michal Maloszewski (1):
      iavf: Fix reporting when setting descriptor count

Michal Swiatkowski (2):
      ice: fix choosing UDP header type
      ice: fix adding different tunnels

Mike Marciniszyn (4):
      IB/hfi1: Correct guard on eager buffer deallocation
      IB/hfi1: Insure use of smp_processor_id() is preempt disabled
      IB/hfi1: Fix early init panic
      IB/hfi1: Fix leak of rcvhdrtail_dummy_kvaddr

Mikita Lipski (1):
      drm/amd/display: prevent reading unitialized links

Miles Chen (1):
      clk: imx: use module_platform_driver

Mitch Williams (1):
      iavf: restore MSI state on reset

Naohiro Aota (1):
      btrfs: fix re-dirty process of tree-log nodes

Nicholas Kazlauskas (1):
      drm/amd/display: Fix DPIA outbox timeout after S3/S4/reset

Nicolas Dichtel (1):
      vrf: don't run conntrack on vrf with !dflt qdisc

Nicolas Frattaroli (2):
      spi: spi-rockchip: Add rk3568-spi compatible
      ASoC: rockchip: i2s_tdm: Dup static DAI template

Niklas Cassel (1):
      nvme: report write pointer for a full zone as zone start + zone len

Noralf Tr=C3=B8nnes (1):
      iio: dln2-adc: Fix lockdep complaint

Norbert Zulinski (1):
      i40e: Fix NULL pointer dereference in i40e_dbg_dump_desc

Olivier Moysan (1):
      iio: adc: stm32: fix null pointer on defer_probe error

Pablo Neira Ayuso (1):
      netfilter: nft_exthdr: break evaluation if setting TCP option fails

Pali Roh=C3=A1r (2):
      irqchip/armada-370-xp: Fix return value of armada_370_xp_msi_alloc()
      irqchip/armada-370-xp: Fix support for Multi-MSI interrupts

Paolo Bonzini (1):
      selftests: KVM: avoid failures due to reserved HyperTransport region

Paul Greenwalt (1):
      ice: rearm other interrupt cause register after enabling VFs

Paulo Alcantara (1):
      cifs: fix ntlmssp auth when there is no key exchange

Pavel Begunkov (1):
      block: fix single bio async DIO error handling

Pavel Hofman (2):
      usb: core: config: fix validation of wMaxPacketValue entries
      usb: core: config: using bit mask instead of individual bits

Pavel Skripkin (1):
      RDMA: Fix use-after-free in rxe_queue_cleanup

Peilin Ye (1):
      selftests/fib_tests: Rework fib_rp_filter_test()

Peter Zijlstra (1):
      sched,x86: Don't use cluster topology for x86 hybrid CPUs

Petr Machata (1):
      MAINTAINERS: net: mlxsw: Remove Jiri as a maintainer, add myself

Qu Wenruo (1):
      btrfs: replace the BUG_ON in btrfs_del_root_ref with proper error han=
dling

Rafael J. Wysocki (1):
      PM: runtime: Fix pm_runtime_active() kerneldoc comment

Ralph Siemsen (1):
      nvmem: eeprom: at25: fix FRAM byte_len

Randy Dunlap (1):
      phy: ti: report 2 non-kernel-doc comments

Raviteja Goud Talla (1):
      drm/i915/gen11: Moving WAs to icl_gt_workarounds_init()

Rob Clark (2):
      ASoC: rt5682: Fix crash due to out of scope stack vars
      ASoC: rt5682s: Fix crash due to out of scope stack vars

Rob Herring (2):
      dt-bindings: media: nxp,imx7-mipi-csi2: Drop bad if/then schema
      Revert "kbuild: Enable DT schema checks for %.dtb targets"

Roman Bolshakov (1):
      scsi: qla2xxx: Format log strings only if needed

Ronak Doshi (1):
      vmxnet3: fix minimum vectors alloc issue

Ruozhu Li (1):
      nvme: fix use after free when disconnecting a reconnecting ctrl

Russell King (Oracle) (2):
      net: dsa: mv88e6xxx: fix "don't use PHY_DETECT on internal PHY's"
      net: dsa: mv88e6xxx: allow use of PHYs on CPU and DSA ports

Sagi Grimberg (1):
      nvmet-tcp: fix possible list corruption for unexpected command failur=
e

Salvatore Bonaccorso (1):
      Makefile: Do not quote value for CONFIG_CC_IMPLICIT_FALLTHROUGH

Sameer Pujar (6):
      ASoC: tegra: Balance runtime PM count
      ASoC: tegra: Use normal system sleep for SFC
      ASoC: tegra: Use normal system sleep for MVC
      ASoC: tegra: Use normal system sleep for Mixer
      ASoC: tegra: Use normal system sleep for AMX
      ASoC: tegra: Use normal system sleep for ADX

Sasha Levin (1):
      tools/lib/lockdep: drop leftover liblockdep headers

Sean Christopherson (3):
      KVM: x86: Ignore sparse banks size for an "all CPUs", non-sparse IPI =
req
      KVM: x86: Don't WARN if userspace mucks with RCX during string I/O ex=
it
      selftests: KVM: Add test to verify KVM doesn't explode on "bad" I/O

Sebastian Andrzej Siewior (2):
      Documentation/locking/locktypes: Update migrate_disable() bits.
      bpf: Make sure bpf_disable_instrumentation() is safe vs preemption.

SeongJae Park (13):
      timers: implement usleep_idle_range()
      mm/damon/core: fix fake load reports due to uninterruptible sleeps
      mm/damon/core: use better timer mechanisms selection threshold
      mm/damon/dbgfs: remove an unnecessary error message
      mm/damon/core: remove unnecessary error messages
      mm/damon/vaddr: remove an unnecessary warning message
      mm/damon/vaddr-test: split a test function having >1024 bytes frame s=
ize
      mm/damon/vaddr-test: remove unnecessary variables
      selftests/damon: skip test if DAMON is running
      selftests/damon: test DAMON enabling with empty target_ids case
      selftests/damon: test wrong DAMOS condition ranges input
      selftests/damon: test debugfs file reads/writes with huge count
      selftests/damon: split test cases

Shin'ichiro Kawasaki (1):
      scsi: scsi_debug: Fix buffer size of REPORT ZONES command

Shiraz Saleem (2):
      RDMA/irdma: Fix a user-after-free in add_pble_prm
      RDMA/irdma: Report correct WC errors

Slark Xiao (1):
      bus: mhi: pci_generic: Fix device recovery failed issue

Song Liu (2):
      perf bpf: Fix building perf with BUILD_BPF_SKEL=3D1 by default in
more distros
      perf bpf_skel: Do not use typedef to avoid error on old clang

Srinivas Kandagatla (5):
      ASoC: qdsp6: q6routing: Fix return value from msm_routing_put_audio_m=
ixer
      ASoC: codecs: wcd934x: handle channel mappping list correctly
      ASoC: codecs: wcd934x: return correct value from mixer put
      ASoC: codecs: wsa881x: fix return values from kcontrol put
      MAINTAINERS: add maintainer for Qualcomm FastRPC driver

Stefano Brivio (2):
      nft_set_pipapo: Fix bucket load in AVX2 lookup routine for six
8-bit groups
      selftests: netfilter: Add correctness test for mac,net set type

Steven Rostedt (VMware) (2):
      tracefs: Have new files inherit the ownership of their parent
      tracefs: Set all files to the same group ownership as the mount optio=
n

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

Thierry Reding (1):
      dt-bindings: bq25980: Fixup the example

Thomas Richter (1):
      perf test: Fix 'Simple expression parser' test on arch without
CPU die topology info

Thomas Wei=C3=9Fschuh (1):
      HID: intel-ish-hid: ipc: only enable IRQ wakeup when requested

Tom Lendacky (1):
      x86/sme: Explicitly map new EFI memmap table as encrypted

Vadim Fedorenko (2):
      selftests: tls: add missing AES-CCM cipher tests
      selftests: tls: add missing AES256-GCM cipher

Vincent Mailhol (2):
      can: pch_can: pch_can_rx_normal: fix use after free
      can: m_can: m_can_read_fifo: fix memory leak in error branch

Vincent Whitchurch (2):
      cifs: Fix crash on unload of cifs_arc4.ko
      i2c: virtio: fix completion handling

Vinod Koul (6):
      phy: mvebu-cp110-utmi: Fix kernel-doc warns
      phy: qualcomm: qmp: Add missing struct documentation
      phy: qualcomm: usb-hsic: Fix the kernel-doc warn
      phy: ti: tusb1210: Fix the kernel-doc warn
      phy: qualcomm: ipq806x-usb: Fix kernel-doc style
      phy: ti: omap-usb2: Fix the kernel-doc style

Vitaly Kuznetsov (2):
      KVM: nVMX: Don't use Enlightened MSR Bitmap for L3
      KVM: x86: Wait for IPIs to be delivered when handling Hyper-V
TLB flush hypercall

Vladimir Murzin (2):
      irqchip: nvic: Fix offset for Interrupt Priority Offsets
      percpu: km: ensure it is used with NOMMU (either UP or SMP)

Waiman Long (1):
      mm/memcg: relocate mod_objcg_mlstate(), get_obj_stock() and
put_obj_stock()

Wenbin Mei (1):
      mmc: mediatek: free the ext_csd when mmc_get_ext_csd success

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

Yanteng Si (2):
      net: phy: Remove unnecessary indentation in the comments of phy_devic=
e
      net: phy: Add the missing blank line in the phylink_suspend comment

Ye Guojin (1):
      irqchip/irq-bcm7120-l2: Add put_device() after of_find_device_by_node=
()

Zev Weiss (1):
      hwmon: (nct6775) mask out bank number in nct6775_wmi_read_value()

Zhenguo Yao (1):
      hugetlbfs: fix issue of preallocation of gigantic pages can't work

xiazhengqiao (1):
      HID: google: add eel USB id

zhangyue (1):
      md: fix double free of mddev->private in autorun_array()
