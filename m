Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653274BF0CC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 05:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbiBVDaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 22:30:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbiBVDaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:30:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF4722B2A;
        Mon, 21 Feb 2022 19:29:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 435A5B81851;
        Tue, 22 Feb 2022 03:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CF6C340E8;
        Tue, 22 Feb 2022 03:29:39 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.19.230-rt103
Date:   Tue, 22 Feb 2022 03:28:36 -0000
Message-ID: <164550051670.2032118.4060063572083963150@puck.lan>
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
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.230-rt103 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: def5573a0d376e69eae523ceb45bea87301b24d2

Or to build 4.19.230-rt103 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.230.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.230-rt103.patch.xz


You can also build from 4.19.227-rt102 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.227-rt102-rt103.patch.xz

Enjoy!
Clark

Changes from v4.19.227-rt102:
---

Alan Stern (2):
      usb-storage: Add unusual-devs entry for VL817 USB-SATA bridge
      USB: core: Fix hang in usb_kill_urb by adding memory barriers

Amelie Delaunay (1):
      usb: dwc2: gadget: don't try to disable ep0 in dwc2_hsotg_suspend

Antoine Tenart (2):
      net: do not keep the dst cache when uncloning an skb dst and its metadata
      net: fix a memleak when uncloning an skb dst and its metadata

Armin Wolf (1):
      hwmon: (dell-smm) Speed up setting of fan speed

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Do not disconnect while receiving VBUS off

Benjamin Gaignard (1):
      spi: mediatek: Avoid NULL pointer crash in interrupt

Brian Gix (1):
      Bluetooth: refactor malicious adv data check

Cameron Williams (2):
      tty: Add support for Brainboxes UC cards.
      USB: serial: ftdi_sio: add support for Brainboxes US-159/235/320

Christian Lachner (3):
      ALSA: hda/realtek: Add missing fixup-model entry for Gigabyte X570 ALC1220 quirks
      ALSA: hda/realtek: Fix silent output on Gigabyte X570S Aorus Master (newer chipset)
      ALSA: hda/realtek: Fix silent output on Gigabyte X570 Aorus Xtreme after reboot from Windows

Christophe Leroy (1):
      powerpc/32: Fix boot failure with GCC latent entropy plugin

Chuck Lever (2):
      NFSD: Clamp WRITE offsets
      NFSD: Fix offset type in I/O trace points

Clark Williams (2):
      Merge tag 'v4.19.230' into v4.19-rt
      Linux 4.19.230-rt103

Congyu Liu (1):
      net: fix information leakage in /proc/net/ptype

Dai Ngo (1):
      nfsd: nfsd4_setclientid_confirm mistakenly expires confirmed client.

Dan Carpenter (2):
      drm/i915/overlay: Prevent divide by zero bugs in scaling
      ASoC: max9759: fix underflow in speaker_gain_control_put()

Daniel Borkmann (1):
      bpf: Add kconfig knob for disabling unpriv bpf by default

Eric Dumazet (9):
      ipv4: avoid using shared IP generator for connected sockets
      ipv6: annotate accesses to fn->fn_sernum
      ipv4: raw: lock the socket in raw_bind()
      ipv4: tcp: send zero IPID in SYNACK messages
      tcp: fix possible socket leaks in internal pacing mode
      rtnetlink: make sure to refresh master_dev/m_ops in __rtnl_newlink()
      af_packet: fix data-race in packet_setsockopt / packet_setsockopt
      ipmr,ip6mr: acquire RTNL before calling ip[6]mr_free_table() on failure path
      veth: fix races around rq->rx_notify_masked

Eric W. Biederman (1):
      cgroup-v1: Require capabilities to set release_agent

Fabio Estevam (2):
      ARM: dts: imx23-evk: Remove MX23_PAD_SSP1_DETECT from hog group
      ARM: dts: imx6qdl-udoo: Properly describe the SD card detect

Florian Westphal (2):
      netfilter: nat: remove l4 protocol port rovers
      netfilter: nat: limit port clash resolution attempts

Georgi Valkov (1):
      ipheth: fix EOVERFLOW in ipheth_rcvbulk_callback

Greg Kroah-Hartman (6):
      PM: wakeup: simplify the output logic of pm_show_wakelocks()
      Linux 4.19.228
      moxart: fix potential use-after-free on remove path
      Linux 4.19.229
      usb: gadget: rndis: check size of RNDIS_MSG_SET command
      Linux 4.19.230

Guenter Roeck (2):
      hwmon: (lm90) Reduce maximum conversion rate for G781
      Revert "ASoC: mediatek: Check for error clk pointer"

Guoqing Jiang (1):
      iommu/vt-d: Fix potential memory leak in intel_setup_irq_remapping()

Hangyu Hua (1):
      yam: fix a memory leak in yam_siocdevprivate()

Ido Schimmel (1):
      ipv6_tunnel: Rate limit warning messages

Jakob Koschel (2):
      vt_ioctl: fix array_index_nospec in vt_setactivate
      vt_ioctl: add array_index_nospec to VT_ACTIVATE

Jan Kara (2):
      udf: Restore i_lenAlloc when inode expansion fails
      udf: Fix NULL ptr deref when converting from inline format

Jedrzej Jagielski (2):
      i40e: Increase delay to 1 s after global EMP reset
      i40e: Fix issue when maximum queues is exceeded

Jianguo Wu (1):
      net-procfs: show net devices bound packet types

Jiasheng Jiang (2):
      ASoC: cpcap: Check for NULL pointer after calling of_get_child_by_name
      mmc: sdhci-of-esdhc: Check for error num after setting mask

Jisheng Zhang (1):
      net: stmmac: dwmac-sun8i: use return val of readl_poll_timeout()

Joe Damato (1):
      i40e: fix unsigned stat widths

Joerg Roedel (1):
      iommu/amd: Fix loop timeout issue in iommu_ga_log_enable()

Johan Hovold (2):
      USB: serial: cp210x: add NCR Retail IO box id
      USB: serial: cp210x: add CPI Bulk Coin Recycler id

John Meneghini (2):
      scsi: bnx2fc: Flush destroy_work queue before calling bnx2fc_interface_put()
      scsi: bnx2fc: Make bnx2fc_recv_frame() mp safe

Jon Hunter (1):
      usb: common: ulpi: Fix crash in ulpi_match()

Jon Maloy (2):
      tipc: improve size validations for received domain records
      tipc: rate limit warning for received illegal binding update

José Expósito (1):
      drm/msm/dsi: invalid parameter check in msm_dsi_phy_enable

Kamal Dasu (1):
      spi: bcm-qspi: check for valid cs before applying chip select

Kees Cook (1):
      seccomp: Invalidate seccomp mode to catch death failures

Leon Romanovsky (1):
      RDMA/mlx4: Don't continue event handler after memory allocation failure

Lior Nahmanson (1):
      net: macsec: Verify that send_sci is on when setting Tx sci explicitly

Lucas Stach (1):
      drm/etnaviv: relax submit size limits

Mahesh Bandewar (1):
      bonding: pair enable_port with slave_arr_updates

Marek Behún (2):
      net: sfp: ignore disabled SFP node
      phylib: fix potential use-after-free

Mark Brown (3):
      ASoC: ops: Reject out of bounds values in snd_soc_put_volsw()
      ASoC: ops: Reject out of bounds values in snd_soc_put_volsw_sx()
      ASoC: ops: Reject out of bounds values in snd_soc_put_xr_sx()

Martin Blumenstingl (1):
      ARM: dts: meson: Fix the UART compatible strings

Martin K. Petersen (1):
      block: bio-integrity: Advance seed correctly for larger interval sizes

Matthias Kaehlcke (1):
      rpmsg: char: Fix race between the release of rpmsg_eptdev and cdev

Miaoqian Lin (2):
      spi: meson-spicc: add IRQ check in meson_spicc_probe
      ASoC: fsl: Add missing error handling in pcm030_fabric_probe

Miquel Raynal (4):
      net: ieee802154: hwsim: Ensure proper channel selection at probe time
      net: ieee802154: mcr20a: Fix lifs/sifs periods
      net: ieee802154: ca8210: Stop leaking skb's
      net: ieee802154: Return meaningful error codes from the netlink helpers

Muhammad Usama Anjum (1):
      selftests: futex: Use variable MAKE instead of make

Nick Lopez (1):
      drm/nouveau: fix off by one in BIOS boundary checking

Nikolay Aleksandrov (1):
      net: bridge: fix stale eth hdr pointer in br_dev_xmit

Olga Kornievskaia (3):
      NFSv4 only print the label when its queried
      NFSv4 remove zero number of fs_locations entries error check
      NFSv4 expose nfs_parse_server_name function

Pablo Neira Ayuso (1):
      netfilter: nft_payload: do not update layer 4 checksum when mangling fragments

Paul Moore (1):
      audit: improve audit queue handling when "audit=1" on cmdline

Pavankumar Kondeti (1):
      usb: gadget: f_sourcesink: Fix isoc transfer for USB_SPEED_SUPER_PLUS

Pavel Parkhomenko (1):
      net: phy: marvell: Fix MDI-x polarity setting in 88e1118-compatible PHYs

Pawel Dembicki (1):
      USB: serial: option: add ZTE MF286D modem

Raju Rangoju (2):
      net: amd-xgbe: ensure to reset the tx_timer_active flag
      net: amd-xgbe: disable interrupts during pci removal

Ritesh Harjani (1):
      ext4: fix error handling in ext4_restore_inline_data()

Riwen Lu (1):
      rtc: cmos: Evaluate century appropriate

Robert Hancock (1):
      serial: 8250: of: Fix mapped region size when using reg-offset property

Roberto Sassu (1):
      ima: Allow template selection with ima_template[_fmt]= after ima_hash=

Samuel Mendoza-Jonas (1):
      ixgbevf: Require large buffers for build_skb on 82599VF

Sean Anderson (2):
      usb: ulpi: Move of_node_put to ulpi_dev_release
      usb: ulpi: Call of_node_put correctly

Sergey Shtylyov (2):
      EDAC/altera: Fix deferred probing
      EDAC/xgene: Fix deferred probing

Shyam Sundar S K (1):
      net: amd-xgbe: Fix skb data length underflow

Song Liu (1):
      perf: Fix list corruption in perf_cgroup_switch()

Stefan Berger (1):
      ima: Remove ima_policy file before directory

Steffen Maier (1):
      scsi: zfcp: Fix failed recovery on gone remote port with non-NPIV FCP devices

Stephan Brunner (1):
      USB: serial: ch341: add support for GW Instek USB2.0-Serial devices

Sujit Kautkar (1):
      rpmsg: char: Fix race between the release of rpmsg_ctrldev and cdev

Sukadev Bhattiprolu (2):
      ibmvnic: init ->running_cap_crqs early
      ibmvnic: don't spin in tasklet

Sylwester Dziedziuch (1):
      i40e: Fix queues reservation for XDP

Szymon Heidrich (1):
      USB: gadget: validate interface OS descriptor requests

TATSUKAWA KOSUKE (立川 江介) (1):
      n_tty: wake up poll(POLLRDNORM) on receiving data

Trond Myklebust (6):
      NFSv4: Handle case where the lookup of a directory fails
      NFSv4: nfs_atomic_open() can race when looking up a non-regular file
      NFS: Ensure the server has an up to date ctime before hardlinking
      NFS: Ensure the server has an up to date ctime before renaming
      NFS: Fix initialisation of nfs_client cl_flags field
      NFSv4.1: Fix uninitialised variable in devicenotify

Udipto Goswami (2):
      usb: f_fs: Fix use-after-free for epfile
      usb: dwc3: gadget: Prevent core from processing stale TRBs

Uwe Kleine-König (1):
      staging: fbtft: Fix error path in fbtft_driver_module_init()

Valentin Caron (1):
      serial: stm32: fix software flow control transfer

Vasily Gorbik (1):
      s390/hypfs: include z/VM guests with access control group set

Victor Nogueira (1):
      net: sched: Clarify error message when qdisc kind is unknown

Xianting Tian (1):
      drm/msm: Fix wrong size calculation

Xiaoke Wang (2):
      integrity: check the return value of audit_log_start()
      nfs: nfs4clinet: check the return value of kstrdup()

Xin Long (1):
      ping: fix the sk_bound_dev_if match in ping_lookup

Yannick Vignon (1):
      net: stmmac: ensure PTP time register reads are consistent

Zechuan Chen (1):
      perf probe: Fix ppc64 'perf probe add events failed' case

ZouMingzhe (1):
      scsi: target: iscsi: Make sure the np under each tpg is unique

daniel.starke@siemens.com (1):
      tty: n_gsm: fix SW flow control encoding/handling
---
Documentation/sysctl/kernel.txt                    |  21 ++++
 Makefile                                           |   2 +-
 arch/arm/boot/dts/imx23-evk.dts                    |   1 -
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |   5 +-
 arch/arm/boot/dts/meson.dtsi                       |   8 +-
 arch/powerpc/kernel/Makefile                       |   1 +
 arch/powerpc/lib/Makefile                          |   3 +
 arch/s390/hypfs/hypfs_vm.c                         |   6 +-
 block/bio-integrity.c                              |   2 +-
 drivers/edac/altera_edac.c                         |   2 +-
 drivers/edac/xgene_edac.c                          |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c       |   4 +-
 drivers/gpu/drm/i915/intel_overlay.c               |   3 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   4 +-
 drivers/gpu/drm/msm/msm_drv.c                      |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/base.c    |   2 +-
 drivers/hwmon/dell-smm-hwmon.c                     |  12 ++-
 drivers/hwmon/lm90.c                               |   2 +-
 drivers/infiniband/hw/mlx4/main.c                  |   2 +-
 drivers/iommu/amd_iommu_init.c                     |   2 +
 drivers/iommu/intel_irq_remapping.c                |  13 ++-
 drivers/mmc/host/moxart-mmc.c                      |   2 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |   8 +-
 drivers/net/bonding/bond_3ad.c                     |   3 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |  14 ++-
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c           |   3 +
 drivers/net/ethernet/ibm/ibmvnic.c                 | 112 +++++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e.h             |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  44 ++++----
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  59 +++++++++++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |  13 +--
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |  19 ++--
 drivers/net/hamradio/yam.c                         |   4 +-
 drivers/net/ieee802154/ca8210.c                    |   1 +
 drivers/net/ieee802154/mac802154_hwsim.c           |   1 +
 drivers/net/ieee802154/mcr20a.c                    |   4 +-
 drivers/net/macsec.c                               |   9 ++
 drivers/net/phy/marvell.c                          |   7 +-
 drivers/net/phy/phy_device.c                       |   6 +-
 drivers/net/phy/phylink.c                          |   5 +
 drivers/net/usb/ipheth.c                           |   6 +-
 drivers/net/veth.c                                 |  13 ++-
 drivers/rpmsg/rpmsg_char.c                         |  22 +---
 drivers/rtc/rtc-mc146818-lib.c                     |   2 +-
 drivers/s390/scsi/zfcp_fc.c                        |  13 ++-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  |  41 ++++----
 drivers/soc/mediatek/mtk-scpsys.c                  |  15 +--
 drivers/spi/spi-bcm-qspi.c                         |   2 +-
 drivers/spi/spi-meson-spicc.c                      |   5 +
 drivers/spi/spi-mt65xx.c                           |   2 +-
 drivers/staging/fbtft/fbtft.h                      |   5 +-
 drivers/target/iscsi/iscsi_target_tpg.c            |   3 +
 drivers/tty/n_gsm.c                                |   4 +-
 drivers/tty/n_tty.c                                |   4 +-
 drivers/tty/serial/8250/8250_of.c                  |  11 +-
 drivers/tty/serial/8250/8250_pci.c                 | 100 +++++++++++++++++-
 drivers/tty/serial/stm32-usart.c                   |   2 +-
 drivers/tty/vt/vt_ioctl.c                          |   5 +-
 drivers/usb/common/ulpi.c                          |  17 +++-
 drivers/usb/core/hcd.c                             |  14 +++
 drivers/usb/core/urb.c                             |  12 +++
 drivers/usb/dwc2/gadget.c                          |   2 +-
 drivers/usb/dwc3/gadget.c                          |  13 +++
 drivers/usb/gadget/composite.c                     |   3 +
 drivers/usb/gadget/function/f_fs.c                 |  56 ++++++++---
 drivers/usb/gadget/function/f_sourcesink.c         |   1 +
 drivers/usb/gadget/function/rndis.c                |   9 +-
 drivers/usb/serial/ch341.c                         |   1 +
 drivers/usb/serial/cp210x.c                        |   2 +
 drivers/usb/serial/ftdi_sio.c                      |   3 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   3 +
 drivers/usb/serial/option.c                        |   2 +
 drivers/usb/storage/unusual_devs.h                 |  10 ++
 drivers/usb/typec/tcpm.c                           |   3 +-
 fs/ext4/inline.c                                   |  10 +-
 fs/nfs/callback.h                                  |   2 +-
 fs/nfs/callback_proc.c                             |   2 +-
 fs/nfs/callback_xdr.c                              |  18 ++--
 fs/nfs/client.c                                    |   2 +-
 fs/nfs/dir.c                                       |  22 ++++
 fs/nfs/nfs4_fs.h                                   |   3 +-
 fs/nfs/nfs4client.c                                |   5 +-
 fs/nfs/nfs4namespace.c                             |   4 +-
 fs/nfs/nfs4state.c                                 |   3 +
 fs/nfs/nfs4xdr.c                                   |   9 +-
 fs/nfsd/nfs3proc.c                                 |   5 +
 fs/nfsd/nfs4proc.c                                 |   5 +-
 fs/nfsd/nfs4state.c                                |   4 +-
 fs/nfsd/trace.h                                    |  14 +--
 fs/udf/inode.c                                     |   9 +-
 include/linux/netdevice.h                          |   1 +
 include/net/dst_metadata.h                         |  14 ++-
 include/net/ip.h                                   |  21 ++--
 include/net/ip6_fib.h                              |   2 +-
 include/net/netfilter/nf_nat_l4proto.h             |   2 +-
 init/Kconfig                                       |  10 ++
 kernel/audit.c                                     |  62 ++++++++----
 kernel/bpf/syscall.c                               |   3 +-
 kernel/cgroup/cgroup-v1.c                          |  24 +++++
 kernel/events/core.c                               |   4 +-
 kernel/power/wakelock.c                            |  12 +--
 kernel/seccomp.c                                   |  10 ++
 kernel/sysctl.c                                    |  29 +++++-
 localversion-rt                                    |   2 +-
 net/bluetooth/hci_event.c                          |  10 +-
 net/bridge/br_device.c                             |   6 +-
 net/core/net-procfs.c                              |  38 ++++++-
 net/core/rtnetlink.c                               |   6 +-
 net/ieee802154/nl802154.c                          |   8 +-
 net/ipv4/ip_output.c                               |  11 +-
 net/ipv4/ipmr.c                                    |   2 +
 net/ipv4/ping.c                                    |   3 +-
 net/ipv4/raw.c                                     |   5 +-
 net/ipv4/tcp_output.c                              |  31 ++++--
 net/ipv6/ip6_fib.c                                 |  23 +++--
 net/ipv6/ip6_tunnel.c                              |   8 +-
 net/ipv6/ip6mr.c                                   |   2 +
 net/ipv6/route.c                                   |   2 +-
 net/netfilter/nf_nat_proto_common.c                |  37 ++++---
 net/netfilter/nf_nat_proto_dccp.c                  |   5 +-
 net/netfilter/nf_nat_proto_sctp.c                  |   5 +-
 net/netfilter/nf_nat_proto_tcp.c                   |   5 +-
 net/netfilter/nf_nat_proto_udp.c                   |  10 +-
 net/netfilter/nft_payload.c                        |   3 +
 net/packet/af_packet.c                             |  10 +-
 net/sched/sch_api.c                                |   2 +-
 net/tipc/link.c                                    |   5 +-
 net/tipc/monitor.c                                 |   2 +
 net/tipc/name_distr.c                              |   2 +-
 security/integrity/ima/ima_fs.c                    |   2 +-
 security/integrity/ima/ima_template.c              |  10 +-
 security/integrity/integrity_audit.c               |   2 +
 sound/pci/hda/patch_realtek.c                      |   5 +-
 sound/soc/codecs/cpcap.c                           |   2 +
 sound/soc/codecs/max9759.c                         |   3 +-
 sound/soc/fsl/pcm030-audio-fabric.c                |  11 +-
 sound/soc/soc-ops.c                                |  29 +++++-
 tools/perf/util/probe-event.c                      |   3 +
 tools/testing/selftests/futex/Makefile             |   4 +-
 141 files changed, 1049 insertions(+), 408 deletions(-)
---
