Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AF0479648
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhLQVbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhLQVbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:31:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671C3C061574;
        Fri, 17 Dec 2021 13:31:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAD2B623E3;
        Fri, 17 Dec 2021 21:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C86C36AE2;
        Fri, 17 Dec 2021 21:31:36 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.221-rt99
Date:   Fri, 17 Dec 2021 21:30:51 -0000
Message-ID: <163977665182.1250088.11049848941535534253@puck.lan>
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

I'm pleased to announce the 4.19.221-rt99 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 05b6e5620cf50793e8fa48cf5e003b6ef650fee0

Or to build 4.19.221-rt99 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.221.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.221-rt99.patch.xz


You can also build from 4.19.219-rt98 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.219-rt98-rt99.patch.xz

Enjoy!
Clark

Changes from v4.19.219-rt98:
---

Alain Volmat (2):
      i2c: stm32f7: recover the bus on access timeout
      i2c: stm32f7: stop dma transfer in case of NACK

Alan Young (1):
      ALSA: ctl: Fix copy of updated id with element read/write

Alexander Mikhalitsyn (1):
      shm: extend forced shm destroy to support objects from several IPC nses

Alyssa Ross (1):
      iio: trigger: stm32-timer: fix MODULE_ALIAS

Andrea Mayer (1):
      seg6: fix the iif in the IPv6 socket control block

Andreas Gruenbacher (1):
      gfs2: Fix length of holes reported at end-of-file

Arnaldo Carvalho de Melo (1):
      tools build: Remove needless libpython-version feature check that breaks test-all fast path

Arnd Bergmann (1):
      siphash: use _unaligned version by default

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Wait in SNK_DEBOUNCED until disconnect

Baokun Li (2):
      sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl
      sata_fsl: fix warning in remove_proc_entry when rmmod sata_fsl

Benjamin Coddington (1):
      NFSv42: Fix pagecache invalidation after COPY/CLONE

Benjamin Poirier (1):
      net: mpls: Fix notifications when deleting a device

Brian Silverman (1):
      can: m_can: Disable and ignore ELO interrupt

Clark Williams (2):
      Merge tag 'v4.19.221' into v4.19-rt
      Linux 4.19.221-rt99

Cong Wang (1):
      net_sched: fix a crash in tc_new_tfilter()

Dan Carpenter (3):
      can: sja1000: fix use after free in ems_pcmcia_add_card()
      net: altera: set a couple error code in probe()
      net/qla3xxx: fix an error code in ql_adapter_up()

Davidlohr Bueso (1):
      block: fix ioprio_get(IOPRIO_WHO_PGRP) vs setuid(2)

Dmitry Baryshkov (1):
      clk: qcom: regmap-mux: fix parent clock lookup

Eiichi Tsukata (1):
      rxrpc: Fix rxrpc_local leak in rxrpc_lookup_peer()

Eric Biggers (5):
      wait: add wake_up_pollfree()
      binder: use wake_up_pollfree()
      signalfd: use wake_up_pollfree()
      aio: keep poll requests on waitqueue until completed
      aio: fix use-after-free due to missing POLLFREE handling

Eric Dumazet (3):
      net: annotate data-races on txq->xmit_lock_owner
      bonding: make tx_rebalance_counter an atomic
      net, neigh: clear whole pneigh_entry at alloc time

Evgeny Boger (1):
      iio: adc: axp20x_adc: fix charging current reporting on AXP22x

Geert Uytterhoeven (1):
      of: clk: Make <linux/of_clk.h> self-contained

Greg Kroah-Hartman (10):
      Linux 4.19.220
      HID: add hid_is_usb() function to make it simpler for USB detection
      HID: add USB_HID dependancy to hid-prodikeys
      HID: add USB_HID dependancy to hid-chicony
      HID: add USB_HID dependancy on some USB HID drivers
      HID: wacom: fix problems when device is not a valid USB device
      HID: check for valid USB device for many HID drivers
      USB: gadget: detect too-big endpoint 0 requests
      USB: gadget: zero allocate endpoint 0 buffers
      Linux 4.19.221

Gwendal Grignou (1):
      iio: at91-sama5d2: Fix incorrect sign extension

Hannes Reinecke (1):
      libata: add horkage for ASMedia 1092

Helge Deller (3):
      parisc: Fix KBUILD_IMAGE for self-extracting kernel
      parisc: Fix "make install" on newer debian releases
      parisc: Mark cr16 CPU clocksource unstable on all SMP machines

Herve Codina (1):
      mtd: rawnand: fsmc: Take instruction delay into account

Ian Rogers (1):
      perf hist: Fix memory leak of a perf_hpp_fmt

Ioanna Alifieraki (1):
      ipmi: Move remove_work to dedicated workqueue

Jens Axboe (1):
      fs: add fget_many() and fput_many()

Jesse Brandeburg (1):
      ice: ignore dropped packets during init

Jianglei Nie (1):
      nfp: Fix memory leak in nfp_cpp_area_cache_add()

Jianguo Wu (1):
      udp: using datalen to cap max gso segments

Jimmy Assarsson (1):
      can: kvaser_usb: get CAN clock frequency from device

Joakim Zhang (1):
      net: fec: only clear interrupt of handling queue in fec_enet_rx_queue()

Joerg Roedel (1):
      x86/64/mm: Map all kernel memory into trampoline_pgd

Johan Hovold (1):
      serial: core: fix transmit-buffer reset and memleak

Kai-Heng Feng (1):
      xhci: Remove CONFIG_USB_DEFAULT_PERSIST to prevent xHCI from runtime suspending

Krzysztof Kozlowski (1):
      nfc: fix potential NULL pointer deref in nfc_genl_dump_ses_done

Lars-Peter Clausen (7):
      iio: trigger: Fix reference counting
      iio: stk3310: Don't return error code in interrupt handler
      iio: mma8452: Fix trigger reference couting
      iio: ltr501: Don't return error code in trigger handler
      iio: kxsd9: Don't return error code in trigger handler
      iio: itg3200: Call iio_trigger_notify_done() on error
      iio: dln2: Check return value of devm_iio_trigger_register()

Lee Jones (1):
      net: cdc_ncm: Allow for dwNtbOutMaxSize to be unset or zero

Linus Torvalds (1):
      fget: check that the fd still exists after getting a ref to it

Maciej W. Rozycki (1):
      vgacon: Propagate console boot parameters before calling `vc_resize'

Manaf Meethalavalappu Pallikunhi (1):
      thermal: core: Reset previous low and high trip during thermal zone init

Manish Chopra (1):
      qede: validate non LSO skb length

Manjong Lee (1):
      mm: bdi: initialize bdi_min_ratio when bdi is unregistered

Mario Limonciello (1):
      ata: ahci: Add Green Sardine vendor ID as board_ahci_mobile

Masami Hiramatsu (1):
      kprobes: Limit max data_size of the kretprobe instances

Mateusz Palczewski (1):
      i40e: Fix pre-set max number of queues for VF

Mathias Nyman (2):
      xhci: Fix commad ring abort, write all 64 bits to CRCR register.
      xhci: avoid race between disable slot command and host runtime suspend

Maxim Mikityanskiy (1):
      bpf: Fix the off-by-two error in range markings

Mike Christie (1):
      scsi: iscsi: Unblock session then wake up error handler

Mike Marciniszyn (1):
      IB/hfi1: Correct guard on eager buffer deallocation

Noralf Trønnes (1):
      iio: dln2-adc: Fix lockdep complaint

Ole Ernst (1):
      USB: NO_LPM quirk Lenovo Powered USB-C Travel Hub

Pali Rohár (2):
      irqchip/armada-370-xp: Fix return value of armada_370_xp_msi_alloc()
      irqchip/armada-370-xp: Fix support for Multi-MSI interrupts

Pavel Hofman (2):
      usb: core: config: fix validation of wMaxPacketValue entries
      usb: core: config: using bit mask instead of individual bits

Pierre Gondois (1):
      serial: pl011: Add ACPI SBSA UART match id

Randy Dunlap (1):
      natsemi: xtensa: fix section mismatch warnings

Rob Clark (1):
      drm/msm: Do hw_init() before capturing GPU state

Slark Xiao (1):
      platform/x86: thinkpad_acpi: Fix WWAN device disabled issue after S3 deep

Srinivas Kandagatla (1):
      ASoC: qdsp6: q6routing: Fix return value from msm_routing_put_audio_mixer

Stephen Suryaputra (1):
      vrf: Reset IPCB/IP6CB when processing outbound pkts in vrf dev xmit

Steven Rostedt (VMware) (2):
      tracefs: Have new files inherit the ownership of their parent
      tracefs: Set all files to the same group ownership as the mount option

Sven Eckelmann (1):
      tty: serial: msm_serial: Deactivate RX DMA for polling support

Sven Schuchmann (1):
      net: usb: lan78xx: lan78xx_phy_init(): use PHY_POLL instead of "0" if no IRQ is available

Takashi Iwai (3):
      ALSA: pcm: oss: Fix negative period/buffer sizes
      ALSA: pcm: oss: Limit the period size to 16MB
      ALSA: pcm: oss: Handle missing errors in snd_pcm_oss_change_params*()

Teng Qi (2):
      ethernet: hisilicon: hns: hns_dsaf_misc: fix a possible array overflow in hns_dsaf_ge_srst_by_port()
      net: ethernet: dec: tulip: de4x5: fix possible array overflows in type3_infoblock()

Tony Lu (1):
      net/smc: Keep smc_close_final rc during active close

Vasily Gorbik (1):
      s390/setup: avoid using memblock_enforce_memory_limit

Vincent Mailhol (1):
      can: pch_can: pch_can_rx_normal: fix use after free

Vlad Buslov (5):
      net: core: netlink: add helper refcount dec and lock function
      net: sched: rename qdisc_destroy() to qdisc_put()
      net: sched: extend Qdisc with rcu
      net: sched: add helper function to take reference to Qdisc
      net: sched: use Qdisc rcu API instead of relying on rtnl lock

Vladimir Murzin (1):
      irqchip: nvic: Fix offset for Interrupt Priority Offsets

Wang Yugui (1):
      btrfs: check-integrity: fix a warning on write caching disabled disk

Wei Yongjun (2):
      ipmi: msghandler: Make symbol 'remove_work_wq' static
      net: sched: make function qdisc_free_cb() static

William Kucharski (1):
      net/rds: correct socket tunable error in rds_tcp_tune()

Wudi Wang (1):
      irqchip/irq-gic-v3-its.c: Force synchronisation when issuing INVALL

Yang Yingliang (1):
      iio: accel: kxcjk-1013: Fix possible memory leak in probe and remove

Zekun Shen (1):
      atlantic: Fix OOB read and write in hw_atl_utils_fw_rpc_wait

Zhou Qingyang (2):
      net: qlogic: qlcnic: Fix a NULL pointer dereference in qlcnic_83xx_add_rings()
      net/mlx4_en: Fix an use-after-free bug in mlx4_en_try_alloc_resources()

liuguoqiang (1):
      net: return correct error code

xiazhengqiao (1):
      HID: google: add eel USB id

zhangyue (1):
      net: tulip: de4x5: fix the problem that the array 'lp->phy[8]' may be out of bound
---
Makefile                                           |   2 +-
 arch/parisc/Makefile                               |   5 +
 arch/parisc/install.sh                             |   1 +
 arch/parisc/kernel/time.c                          |  24 +--
 arch/s390/kernel/setup.c                           |   3 -
 arch/x86/realmode/init.c                           |  12 +-
 block/ioprio.c                                     |   3 +
 drivers/android/binder.c                           |  21 +--
 drivers/ata/ahci.c                                 |   1 +
 drivers/ata/libata-core.c                          |   2 +
 drivers/ata/sata_fsl.c                             |  20 ++-
 drivers/char/ipmi/ipmi_msghandler.c                |  13 +-
 drivers/clk/qcom/clk-regmap-mux.c                  |   2 +-
 drivers/clk/qcom/common.c                          |  12 ++
 drivers/clk/qcom/common.h                          |   2 +
 drivers/gpu/drm/msm/msm_debugfs.c                  |   1 +
 drivers/hid/Kconfig                                |  10 +-
 drivers/hid/hid-asus.c                             |   2 +-
 drivers/hid/hid-chicony.c                          |   8 +-
 drivers/hid/hid-corsair.c                          |   7 +-
 drivers/hid/hid-elan.c                             |   2 +-
 drivers/hid/hid-elo.c                              |   3 +
 drivers/hid/hid-google-hammer.c                    |   2 +
 drivers/hid/hid-holtek-kbd.c                       |   9 +-
 drivers/hid/hid-holtek-mouse.c                     |   9 +
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-lg.c                               |  10 +-
 drivers/hid/hid-prodikeys.c                        |  10 +-
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
 drivers/hid/hid-uclogic.c                          |   3 +
 drivers/hid/wacom_sys.c                            |  19 ++-
 drivers/i2c/busses/i2c-stm32f7.c                   |  11 +-
 drivers/iio/accel/kxcjk-1013.c                     |   5 +-
 drivers/iio/accel/kxsd9.c                          |   6 +-
 drivers/iio/accel/mma8452.c                        |   2 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |   3 +-
 drivers/iio/adc/axp20x_adc.c                       |  18 +-
 drivers/iio/adc/dln2-adc.c                         |  21 ++-
 drivers/iio/gyro/itg3200_buffer.c                  |   2 +-
 drivers/iio/industrialio-trigger.c                 |   1 -
 drivers/iio/light/ltr501.c                         |   2 +-
 drivers/iio/light/stk3310.c                        |   6 +-
 drivers/iio/trigger/stm32-timer-trigger.c          |   2 +-
 drivers/infiniband/hw/hfi1/init.c                  |   2 +-
 drivers/irqchip/irq-armada-370-xp.c                |  16 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   2 +-
 drivers/irqchip/irq-nvic.c                         |   2 +-
 drivers/mtd/nand/raw/fsmc_nand.c                   |   4 +
 drivers/net/bonding/bond_alb.c                     |  14 +-
 drivers/net/can/m_can/m_can.c                      |  14 +-
 drivers/net/can/pch_can.c                          |   2 +-
 drivers/net/can/sja1000/ems_pcmcia.c               |   7 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c   | 101 ++++++++---
 drivers/net/ethernet/altera/altera_tse_main.c      |   9 +-
 .../aquantia/atlantic/hw_atl/hw_atl_utils.c        |  10 ++
 drivers/net/ethernet/dec/tulip/de4x5.c             |  34 ++--
 drivers/net/ethernet/freescale/fec.h               |   3 +
 drivers/net/ethernet/freescale/fec_main.c          |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |   4 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   5 -
 drivers/net/ethernet/intel/ice/ice_main.c          |   3 +
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |   9 +-
 drivers/net/ethernet/natsemi/xtsonic.c             |   2 +-
 .../ethernet/netronome/nfp/nfpcore/nfp_cppcore.c   |   4 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c         |   7 +
 drivers/net/ethernet/qlogic/qla3xxx.c              |  19 +--
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |  10 +-
 drivers/net/usb/cdc_ncm.c                          |   2 +
 drivers/net/usb/lan78xx.c                          |   2 +-
 drivers/net/vrf.c                                  |   2 +
 drivers/platform/x86/thinkpad_acpi.c               |  12 --
 drivers/scsi/scsi_transport_iscsi.c                |   6 +-
 drivers/thermal/thermal_core.c                     |   2 +
 drivers/tty/serial/amba-pl011.c                    |   1 +
 drivers/tty/serial/msm_serial.c                    |   3 +
 drivers/tty/serial/serial_core.c                   |  13 +-
 drivers/usb/core/config.c                          |   6 +-
 drivers/usb/core/quirks.c                          |   3 +
 drivers/usb/gadget/composite.c                     |  14 +-
 drivers/usb/gadget/legacy/dbgp.c                   |  15 +-
 drivers/usb/gadget/legacy/inode.c                  |  16 +-
 drivers/usb/host/xhci-hub.c                        |   1 +
 drivers/usb/host/xhci-ring.c                       |  22 ++-
 drivers/usb/host/xhci.c                            |  26 +--
 drivers/usb/typec/tcpm.c                           |   4 -
 drivers/video/console/vgacon.c                     |  14 +-
 fs/aio.c                                           | 184 ++++++++++++++++----
 fs/btrfs/disk-io.c                                 |  14 +-
 fs/file.c                                          |  19 ++-
 fs/file_table.c                                    |   9 +-
 fs/gfs2/bmap.c                                     |   2 +-
 fs/nfs/nfs42proc.c                                 |   5 +-
 fs/signalfd.c                                      |  12 +-
 fs/tracefs/inode.c                                 |  76 +++++++++
 include/linux/file.h                               |   2 +
 include/linux/fs.h                                 |   4 +-
 include/linux/hid.h                                |   5 +
 include/linux/ipc_namespace.h                      |  15 ++
 include/linux/kprobes.h                            |   2 +
 include/linux/netdevice.h                          |  19 ++-
 include/linux/of_clk.h                             |   3 +
 include/linux/rtnetlink.h                          |   7 +
 include/linux/sched/task.h                         |   2 +-
 include/linux/siphash.h                            |  14 +-
 include/linux/wait.h                               |  26 +++
 include/net/bond_alb.h                             |   2 +-
 include/net/pkt_sched.h                            |   1 +
 include/net/sch_generic.h                          |  17 +-
 include/uapi/asm-generic/poll.h                    |   2 +-
 ipc/shm.c                                          | 189 ++++++++++++++++-----
 kernel/bpf/verifier.c                              |   2 +-
 kernel/kprobes.c                                   |   3 +
 kernel/sched/wait.c                                |   7 +
 lib/siphash.c                                      |  12 +-
 localversion-rt                                    |   2 +-
 mm/backing-dev.c                                   |   7 +
 net/core/dev.c                                     |   7 +-
 net/core/neighbour.c                               |   2 +-
 net/core/rtnetlink.c                               |   6 +
 net/ipv4/devinet.c                                 |   2 +-
 net/ipv4/udp.c                                     |   2 +-
 net/ipv6/seg6_iptunnel.c                           |   8 +
 net/mpls/af_mpls.c                                 |  68 ++++++--
 net/nfc/netlink.c                                  |   6 +-
 net/rds/tcp.c                                      |   2 +-
 net/rxrpc/peer_object.c                            |  14 +-
 net/sched/cls_api.c                                |  81 +++++++--
 net/sched/sch_api.c                                |  24 ++-
 net/sched/sch_atm.c                                |   2 +-
 net/sched/sch_cbq.c                                |   2 +-
 net/sched/sch_cbs.c                                |   2 +-
 net/sched/sch_drr.c                                |   4 +-
 net/sched/sch_dsmark.c                             |   2 +-
 net/sched/sch_fifo.c                               |   2 +-
 net/sched/sch_generic.c                            |  48 ++++--
 net/sched/sch_hfsc.c                               |   2 +-
 net/sched/sch_htb.c                                |   4 +-
 net/sched/sch_mq.c                                 |   4 +-
 net/sched/sch_mqprio.c                             |   4 +-
 net/sched/sch_multiq.c                             |   6 +-
 net/sched/sch_netem.c                              |   2 +-
 net/sched/sch_prio.c                               |   6 +-
 net/sched/sch_qfq.c                                |   4 +-
 net/sched/sch_red.c                                |   4 +-
 net/sched/sch_sfb.c                                |   4 +-
 net/sched/sch_tbf.c                                |   4 +-
 net/smc/smc_close.c                                |   8 +-
 sound/core/control_compat.c                        |   3 +
 sound/core/oss/pcm_oss.c                           |  37 ++--
 sound/soc/qcom/qdsp6/q6routing.c                   |   8 +-
 tools/build/Makefile.feature                       |   1 -
 tools/build/feature/Makefile                       |   4 -
 tools/build/feature/test-all.c                     |   5 -
 tools/build/feature/test-libpython-version.c       |  11 --
 tools/perf/Makefile.config                         |   2 -
 tools/perf/ui/hist.c                               |  28 +--
 tools/perf/util/hist.h                             |   1 -
 167 files changed, 1355 insertions(+), 525 deletions(-)
---
