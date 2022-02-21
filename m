Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F2A4BEC39
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiBUVIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:08:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiBUVIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:08:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BE223BCD;
        Mon, 21 Feb 2022 13:08:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B51860EAE;
        Mon, 21 Feb 2022 21:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0EBC340E9;
        Mon, 21 Feb 2022 21:08:10 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.24-rt31
Date:   Mon, 21 Feb 2022 21:03:50 -0000
Message-ID: <164547743031.1846171.11199298322368872251@puck.lan>
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

I'm pleased to announce the 5.15.24-rt31 stable release.

In addition to a rebase to the latest 5.15.24 tree, this release contains
one RT fix:

7acae746a514 net: Write lock dev_base_lock without disabling bottom halves.

This is a fix for a lockdep detected circular locking dependency that shows
up as a lockdep splat; thanks to Luis Claudio Goncalves for pointing out the
problem and the fix.  

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: b835e00d47e5f2f4602cee0b6010590900e1a88c

Or to build 5.15.24-rt31 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.24.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.24-rt31.patch.xz


You can also build from 5.15.21-rt30 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15.21-rt30-rt31.patch.xz

Enjoy!
Clark

Changes from v5.15.21-rt30:
---

Adam Ford (1):
      usb: gadget: udc: renesas_usb3: Fix host to USB_ROLE_NONE transition

Al Cooper (1):
      phy: broadcom: Kconfig: Fix PHY_BRCM_USB config option

Albert Geantă (1):
      ALSA: hda/realtek: Add quirk for ASUS GU603

Alex Deucher (1):
      drm/amdgpu/display: change pipe policy for DCN 2.0

Alexander Stein (1):
      arm64: dts: imx8mq: fix lcdif port node

Amadeusz Sławiński (1):
      PM: hibernate: Remove register_nosave_region_late()

Amelie Delaunay (1):
      usb: dwc2: gadget: don't try to disable ep0 in dwc2_hsotg_suspend

Andi Kleen (1):
      x86/perf: Avoid warning for Arch LBR without XSAVE

Andre Przywara (1):
      pinctrl: sunxi: Fix H616 I2S3 pin data

Andrey Skvortsov (1):
      mmc: core: Wait for command setting 'Power Off Notification' bit to complete

Andy Shevchenko (2):
      pinctrl: intel: Fix a glitch when updating IRQ flags on a preconfigured line
      gpiolib: Never return internal error codes to user space

Anitha Chrisanthus (1):
      drm/kmb: Fix for build errors with Warray-bounds

Anna Schumaker (1):
      sunrpc: Fix potential race conditions in rpc_sysfs_xprt_state_change()

Anshuman Khandual (1):
      arm64: Add Cortex-A510 CPU part definition

Antoine Tenart (3):
      thermal/drivers/int340x: Improve the tcc offset saving for suspend/resume
      net: do not keep the dst cache when uncloning an skb dst and its metadata
      net: fix a memleak when uncloning an skb dst and its metadata

Armin Wolf (1):
      hwmon: (dell-smm) Speed up setting of fan speed

Arnaldo Carvalho de Melo (1):
      tools include UAPI: Sync sound/asound.h copy with the kernel sources

Arnd Bergmann (1):
      thermal: int340x: Limit Kconfig to 64-bit

Arınç ÜNAL (1):
      net: dsa: mt7530: make NET_DSA_MT7530 select MEDIATEK_GE_PHY

Aun-Ali Zaidi (1):
      drm/amd/display: Force link_rate as LINK_RATE_RBR2 for 2018 15" Apple Retina panels

Aurelien Jarno (1):
      riscv: fix build with binutils 2.38

Benjamin Gaignard (1):
      spi: mediatek: Avoid NULL pointer crash in interrupt

Bernard Metzler (1):
      RDMA/siw: Fix broken RDMA Read Fence/Resume logic.

Bob Peterson (1):
      gfs2: Fix gfs2_release for non-writers regression

Brian Norris (1):
      drm/rockchip: vop: Correct RK3399 VOP register fields

Camel Guo (1):
      net: stmmac: dump gmac4 DMA registers correctly

Cameron Williams (1):
      USB: serial: ftdi_sio: add support for Brainboxes US-159/235/320

Changbin Du (1):
      riscv: eliminate unreliable __builtin_frame_address(1)

Christian Lachner (3):
      ALSA: hda/realtek: Add missing fixup-model entry for Gigabyte X570 ALC1220 quirks
      ALSA: hda/realtek: Fix silent output on Gigabyte X570S Aorus Master (newer chipset)
      ALSA: hda/realtek: Fix silent output on Gigabyte X570 Aorus Xtreme after reboot from Windows

Christoph Niedermaier (1):
      drm/panel: simple: Assign data from panel_dpi_probe() correctly

Christophe Leroy (1):
      powerpc/fixmap: Fix VM debug warning on unmap

Chuck Lever (5):
      NFSD: Fix NFSv3 SETATTR/CREATE's handling of large file sizes
      NFSD: Fix ia_size underflow
      NFSD: Clamp WRITE offsets
      NFSD: Fix offset type in I/O trace points
      NFSD: Fix the behavior of READ near OFFSET_MAX

Clark Williams (3):
      Merge tag 'v5.15.23' into v5.15-rt
      Merge tag 'v5.15.24' into v5.15-rt
      Linux 5.15.24-rt31

Colin Foster (1):
      net: mscc: ocelot: fix mutex lock error during ethtool stats read

Dai Ngo (1):
      nfsd: nfsd4_setclientid_confirm mistakenly expires confirmed client.

Dan Carpenter (5):
      RDMA/siw: Fix refcounting leak in siw_create_qp()
      drm/i915/overlay: Prevent divide by zero bugs in scaling
      ASoC: max9759: fix underflow in speaker_gain_control_put()
      phy: stm32: fix a refcount leak in stm32_usbphyc_pll_enable()
      ice: fix an error code in ice_cfg_phy_fec()

Dave Ertman (2):
      ice: Fix KASAN error in LAG NETDEV_UNREGISTER handler
      ice: Avoid RTNL lock when re-creating auxiliary device

Dave Stevenson (1):
      drm/vc4: hdmi: Allow DBLCLK modes even if horz timing is odd.

Dmitry Osipenko (1):
      ASoC: hdmi-codec: Fix OOB memory accesses

Dominique Martinet (1):
      Revert "fs/9p: search open fids first"

Dongjin Kim (2):
      arm64: dts: meson-g12b-odroid-n2: fix typo 'dio2133'
      arm64: dts: meson-sm1-bananapi-m5: fix wrong GPIO domain for GPIOE_2

Eric Biggers (1):
      ima: fix reference leak in asymmetric_verify()

Eric Dumazet (2):
      ipmr,ip6mr: acquire RTNL before calling ip[6]mr_free_table() on failure path
      veth: fix races around rq->rx_notify_masked

Evan Quan (1):
      drm/amd/pm: correct the MGpuFanBoost support for Beige Goby

Fabio Estevam (2):
      ARM: dts: imx23-evk: Remove MX23_PAD_SSP1_DETECT from hog group
      ARM: dts: imx6qdl-udoo: Properly describe the SD card detect

Fabrice Gasnier (1):
      usb: dwc2: drd: fix soft connect when gadget is unconfigured

Filipe Manana (1):
      btrfs: fix use-after-free after failure to create a snapshot

Florian Fainelli (1):
      pinctrl: bcm2835: Fix a few error paths

Florian Westphal (3):
      selftests: nft_concat_range: add test for reload with no element add/del
      selftests: netfilter: check stateless nat udp checksum fixup
      netfilter: ctnetlink: disable helper autoassign

Geert Uytterhoeven (1):
      gpio: aggregator: Fix calling into sleeping GPIO controllers

Greg Kroah-Hartman (6):
      Linux 5.15.22
      moxart: fix potential use-after-free on remove path
      Linux 5.15.23
      Revert "usb: dwc2: drd: fix soft connect when gadget is unconfigured"
      usb: gadget: rndis: check size of RNDIS_MSG_SET command
      Linux 5.15.24

Guenter Roeck (1):
      Revert "ASoC: mediatek: Check for error clk pointer"

Guoqing Jiang (1):
      iommu/vt-d: Fix potential memory leak in intel_setup_irq_remapping()

Haiyue Wang (1):
      gve: fix the wrong AdminQ buffer queue index check

Helge Deller (3):
      Revert "fbcon: Disable accelerated scrolling"
      fbcon: Add option to enable legacy hardware acceleration
      fbcon: Avoid 'cap' set but not used warning

Herbert Xu (1):
      crypto: api - Move cryptomgr soft dependency into algapi

Hou Tao (1):
      bpf: Use VM_MAP instead of VM_ALLOC for ringbuf

Hou Wenlong (1):
      KVM: eventfd: Fix false positive RCU usage warning

Ian Rogers (1):
      perf stat: Fix display of grouped aliased events

Imre Deak (1):
      drm/i915/adlp: Fix TypeC PHY-ready status readout

Jakob Koschel (2):
      vt_ioctl: fix array_index_nospec in vt_setactivate
      vt_ioctl: add array_index_nospec to VT_ACTIVATE

James Clark (1):
      perf: Always wake the parent event

James Morse (2):
      KVM: arm64: Avoid consuming a stale esr value when SError occur
      KVM: arm64: Stop handle_exit() from handling HVC twice when an SError occurs

James Smart (2):
      scsi: lpfc: Remove NVMe support if kernel has NVME_FC disabled
      scsi: lpfc: Reduce log messages seen after firmware download

Janis Schoetterl-Glausch (1):
      KVM: s390: Return error on SIDA memop on normal guest

Jann Horn (2):
      net: usb: ax88179_178a: Fix out-of-bounds accesses in RX fixup
      usb: raw-gadget: fix handling of dual-direction-capable endpoints

Jesse Brandeburg (1):
      ice: fix IPIP and SIT TSO offload

Jiasheng Jiang (2):
      ASoC: cpcap: Check for NULL pointer after calling of_get_child_by_name
      mmc: sdhci-of-esdhc: Check for error num after setting mask

Jim Mattson (1):
      KVM: x86: Report deprecated x87 features in supported CPUID

Jisheng Zhang (3):
      net: stmmac: properly handle with runtime pm in stmmac_dvr_remove()
      net: stmmac: reduce unnecessary wakeups from eee sw timer
      net: stmmac: dwmac-sun8i: use return val of readl_poll_timeout()

Joel Stanley (1):
      net: mdio: aspeed: Add missing MODULE_DEVICE_TABLE

Joerg Roedel (1):
      iommu/amd: Fix loop timeout issue in iommu_ga_log_enable()

Johan Hovold (2):
      USB: serial: cp210x: add NCR Retail IO box id
      USB: serial: cp210x: add CPI Bulk Coin Recycler id

John Garry (1):
      scsi: pm8001: Fix bogus FW crash for maxcpus=1

John Meneghini (1):
      scsi: bnx2fc: Make bnx2fc_recv_frame() mp safe

Jon Maloy (2):
      tipc: improve size validations for received domain records
      tipc: rate limit warning for received illegal binding update

Jonas Hahnfeld (1):
      ALSA: usb-audio: Correct quirk for VF0770

Jonas Malaco (1):
      eeprom: ee1004: limit i2c reads to I2C_SMBUS_BLOCK_MAX

Jordy Zomer (1):
      dma-buf: heaps: Fix potential spectre v1 gadget

Kamal Dasu (1):
      spi: bcm-qspi: check for valid cs before applying chip select

Kees Cook (2):
      seccomp: Invalidate seccomp mode to catch death failures
      signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE

Kishen Maloor (1):
      mptcp: netlink: process IPv6 addrs in creating listening sockets

Kishon Vijay Abraham I (1):
      phy: ti: Fix missing sentinel for clk_div_table

Kiwoong Kim (2):
      scsi: ufs: Use generic error code in ufshcd_set_dev_pwr_mode()
      scsi: ufs: Treat link loss as fatal error

Krzysztof Kozlowski (1):
      ARM: socfpga: fix missing RESET_CONTROLLER

Lang Yu (1):
      mm/kmemleak: avoid scanning potential huge holes

Leon Romanovsky (2):
      RDMA/ucma: Protect mc during concurrent multicast leaves
      RDMA/mlx4: Don't continue event handler after memory allocation failure

Linus Walleij (1):
      ARM: dts: Fix boot regression on Skomer

Lior Nahmanson (2):
      net: macsec: Fix offload support for NETDEV_UNREGISTER event
      net: macsec: Verify that send_sci is on when setting Tx sci explicitly

Liu Ying (1):
      phy: dphy: Correct clk_pre parameter

Louis Peens (1):
      nfp: flower: fix ida_idx not being released

Lutz Koschorreck (2):
      arm64: dts: meson-sm1-odroid: use correct enable-gpio pin for tf-io regulator
      arm64: dts: meson-sm1-odroid: fix boot loop after reboot

Mahesh Bandewar (1):
      bonding: pair enable_port with slave_arr_updates

Maor Gottlieb (1):
      RDMA/cma: Use correct address when leaving multicast group

Marco Elver (1):
      perf: Copy perf_event_attr::sig_data on modification

Mario Limonciello (1):
      drm/amd: avoid suspend on dGPUs w/ s2idle support when runtime PM enabled

Mark Brown (3):
      ASoC: ops: Reject out of bounds values in snd_soc_put_volsw()
      ASoC: ops: Reject out of bounds values in snd_soc_put_volsw_sx()
      ASoC: ops: Reject out of bounds values in snd_soc_put_xr_sx()

Mark Rutland (2):
      kvm: add guest_state_{enter,exit}_irqoff()
      kvm/arm64: rework guest entry logic

Mark Zhang (1):
      IB/cm: Release previously acquired reference counter in the cm_id_priv

Martin Blumenstingl (3):
      ARM: dts: meson: Fix the UART compatible strings
      ARM: dts: meson8: Fix the UART device-tree schema validation
      ARM: dts: meson8b: Fix the UART device-tree schema validation

Martin K. Petersen (1):
      block: bio-integrity: Advance seed correctly for larger interval sizes

Martin Kepplinger (1):
      arm64: dts: imx8mq: fix mipi_csi bidirectional port numbers

Mathias Krause (2):
      misc: fastrpc: avoid double fput() on failed usercopy
      iio: buffer: Fix file related error handling in IIO_BUFFER_GET_FD_IOCTL

Miaoqian Lin (2):
      spi: meson-spicc: add IRQ check in meson_spicc_probe
      ASoC: fsl: Add missing error handling in pcm030_fabric_probe

Mike Marciniszyn (3):
      IB/hfi1: Fix AIP early init panic
      IB/rdmavt: Validate remote_addr during loopback atomic tests
      IB/hfi1: Fix tstats alloc and dealloc

Mike Rapoport (1):
      mm/pgtable: define pte_index so that preprocessor could recognize it

Minghao Chi (1):
      ipc/sem: do not sleep with a spin lock held

Miquel Raynal (4):
      net: ieee802154: hwsim: Ensure proper channel selection at probe time
      net: ieee802154: mcr20a: Fix lifs/sifs periods
      net: ieee802154: ca8210: Stop leaking skb's
      net: ieee802154: Return meaningful error codes from the netlink helpers

Muhammad Usama Anjum (2):
      selftests/exec: Remove pipe from TEST_GEN_FILES
      selftests: futex: Use variable MAKE instead of make

Namjae Jeon (1):
      ksmbd: fix SMB 3.11 posix extension mount failure

Nathan Chancellor (2):
      tools/resolve_btfids: Do not print any commands when building silently
      Makefile.extrawarn: Move -Wunaligned-access to W=1

NeilBrown (1):
      NFS: change nfs_access_get_cached to only report the mask

Nick Lopez (1):
      drm/nouveau: fix off by one in BIOS boundary checking

Niklas Cassel (1):
      gpio: sifive: use the correct register to read output values

Olga Kornievskaia (7):
      NFSv4 only print the label when its queried
      NFSv4 remove zero number of fs_locations entries error check
      NFSv4 store server support for fs_location attribute
      NFSv4.1 query for fs_location attr on a new file system
      NFSv4 expose nfs_parse_server_name function
      NFSv4 handle port presence in fs_location server string
      SUNRPC allow for unspecified transport time in rpc_clnt_add_xprt

Oliver Hartkopp (2):
      can: isotp: fix potential CAN frame reception race in isotp_rcv()
      can: isotp: fix error path in isotp_sendmsg() to unlock wait queue

Padmanabha Srinivasaiah (1):
      drm/vc4: Fix deadlock on DSI device attach error

Paolo Abeni (1):
      mptcp: fix msk traversal in mptcp_nl_cmd_set_flags()

Pasha Tatashin (1):
      mm/debug_vm_pgtable: remove pte entry from the page table

Patrice Chotard (1):
      spi: stm32-qspi: Update spi registering

Paul Hsieh (1):
      drm/amd/display: watermark latencies is not enough on DCN31

Paul Moore (1):
      audit: improve audit queue handling when "audit=1" on cmdline

Pavel Hofman (1):
      usb: gadget: f_uac2: Define specific wTerminalType

Pavel Parkhomenko (2):
      net: phy: marvell: Fix RGMII Tx/Rx delays setting in 88e1121-compatible PHYs
      net: phy: marvell: Fix MDI-x polarity setting in 88e1118-compatible PHYs

Pawel Dembicki (1):
      USB: serial: option: add ZTE MF286D modem

Peter Ujfalusi (1):
      ALSA: hda: Skip codec shutdown in case the codec is not registered

Peter Zijlstra (2):
      x86/perf: Default set FREEZE_ON_SMI for all
      sched: Avoid double preemption in __cond_resched_*lock*()

Phil Sutter (1):
      netfilter: nft_reject_bridge: Fix for missing reply from prerouting

Pingfan Liu (1):
      riscv: cpu-hotplug: clear cpu from numa map when teardown

Qu Wenruo (1):
      btrfs: don't start transaction for scrub if the fs is mounted read-only

Rafael J. Wysocki (2):
      PM: s2idle: ACPI: Fix wakeup interrupts handling
      ACPI: PM: s2idle: Cancel wakeup before dispatching EC GPE

Raju Rangoju (1):
      net: amd-xgbe: disable interrupts during pci removal

Raymond Jay Golo (1):
      drm: panel-orientation-quirks: Add quirk for the 1Netbook OneXPlayer

Reinette Chatre (1):
      x86/sgx: Silence softlockup detection when releasing large enclaves

Ritesh Harjani (2):
      ext4: fix error handling in ext4_restore_inline_data()
      ext4: fix error handling in ext4_fc_record_modified_inode()

Riwen Lu (1):
      rtc: cmos: Evaluate century appropriate

Rob Herring (1):
      ARM: dts: imx7ulp: Fix 'assigned-clocks-parents' typo

Robert Hancock (3):
      ASoC: xilinx: xlnx_formatter_pcm: Make buffer bytes multiple of period bytes
      ASoC: simple-card: fix probe failure on platform component
      phy: xilinx: zynqmp: Fix bus width setting for SGMII

Robert-Ionut Alexa (1):
      dpaa2-eth: unregister the netdev before disconnecting from the PHY

Roberto Sassu (1):
      ima: Allow template selection with ima_template[_fmt]= after ima_hash=

Robin Murphy (1):
      ACPI/IORT: Check node revision for PMCG resources

Roman Gushchin (1):
      mm: memcg: synchronize objcg lists with a dedicated spinlock

Sagi Grimberg (1):
      nvme-tcp: fix bogus request completion when failing to send AER

Samuel Mendoza-Jonas (1):
      ixgbevf: Require large buffers for build_skb on 82599VF

Samuel Thibault (1):
      speakup-dectlk: Restore pitch setting

Sander Vanheule (1):
      irqchip/realtek-rtl: Service all pending interrupts

Sasha Neftin (1):
      e1000e: Separate ADP board type from TGP

Saurav Kashyap (3):
      scsi: qedf: Add stag_work to all the vports
      scsi: qedf: Fix refcount issue when LOGO is received during TMF
      scsi: qedf: Change context reset messages to ratelimited

Sean Anderson (2):
      usb: ulpi: Move of_node_put to ulpi_dev_release
      usb: ulpi: Call of_node_put correctly

Sean Christopherson (2):
      KVM: SVM: Don't kill SEV guest if SMAP erratum triggers in usermode
      KVM: VMX: Set vmcs.PENDING_DBG.BS on #DB in STI/MOVSS blocking shadow

Sebastian Andrzej Siewior (1):
      net: Write lock dev_base_lock without disabling bottom halves.

Sergey Shtylyov (2):
      EDAC/altera: Fix deferred probing
      EDAC/xgene: Fix deferred probing

Shin'ichiro Kawasaki (1):
      btrfs: fix deadlock between quota disable and qgroup rescan worker

Slark Xiao (2):
      bus: mhi: pci_generic: Add mru_default for Foxconn SDX55
      bus: mhi: pci_generic: Add mru_default for Cinterion MV31-W

Song Liu (1):
      perf: Fix list corruption in perf_cgroup_switch()

Srinivas Kandagatla (3):
      ASoC: codecs: wcd938x: fix incorrect used of portid
      ASoC: codecs: lpass-rx-macro: fix sidetone register offsets
      ASoC: codecs: wcd938x: fix return value of mixer put function

Srinivas Pandruvada (1):
      thermal/drivers/int340x: processor_thermal: Suppot 64 bit RFIM responses

Steen Hegelund (1):
      net: sparx5: Fix get_stat64 crash in tcpdump

Stefan Berger (2):
      ima: Remove ima_policy file before directory
      ima: Do not print policy rule with inactive LSM labels

Stephan Brunner (1):
      USB: serial: ch341: add support for GW Instek USB2.0-Serial devices

Stephane Eranian (1):
      perf/x86/rapl: fix AMD event handling

Sumeet Pawnikar (1):
      thermal/drivers/int340x: Fix RFIM mailbox write commands

Szymon Heidrich (1):
      USB: gadget: validate interface OS descriptor requests

TATSUKAWA KOSUKE (立川 江介) (1):
      n_tty: wake up poll(POLLRDNORM) on receiving data

Takashi Iwai (3):
      ALSA: hda: Fix UAF of leds class devs at unbinding
      ALSA: hda: realtek: Fix race at concurrent COEF updates
      ALSA: hda: Fix signedness of sscanf() arguments

Thomas Bogendoerfer (2):
      MIPS: Fix build error due to PTR used in more places
      MIPS: octeon: Fix missed PTR->PTR_WD conversion

Tom Rix (1):
      ALSA: usb-audio: initialize variables that could ignore errors

Tom Zanussi (1):
      tracing: Propagate is_signed to expression

Tong Zhang (1):
      scsi: myrs: Fix crash in error case

Tony Lindgren (1):
      ARM: dts: Fix timer regression for beagleboard revision c

Tristan Hume (1):
      perf/x86/intel/pt: Fix crash with stop filters in single-range mode

Trond Myklebust (2):
      NFS: Fix initialisation of nfs_client cl_flags field
      NFSv4.1: Fix uninitialised variable in devicenotify

Uday Shankar (1):
      nvme-fabrics: fix state check in nvmf_ctlr_matches_baseopts()

Udipto Goswami (2):
      usb: f_fs: Fix use-after-free for epfile
      usb: dwc3: gadget: Prevent core from processing stale TRBs

Uwe Kleine-König (1):
      staging: fbtft: Fix error path in fbtft_driver_module_init()

Victor Nogueira (1):
      net: sched: Clarify error message when qdisc kind is unknown

Vijayanand Jitta (1):
      iommu: Fix potential use-after-free during probe

Ville Syrjälä (3):
      drm/i915: Disable DSB usage for now
      drm/i915: Allow !join_mbus cases for adlp+ dbuf configuration
      drm/i915: Populate pipe dbuf slices more accurately during readout

Vineeth Vijayan (1):
      s390/cio: verify the driver availability for path_event call

Vitaly Kuznetsov (2):
      KVM: nVMX: eVMCS: Filter out VM_EXIT_SAVE_VMX_PREEMPTION_TIMER
      KVM: nVMX: Also filter MSR_IA32_VMX_TRUE_PINBASED_CTLS when eVMCS

Vladimir Oltean (7):
      net: dsa: mv88e6xxx: don't use devres for mdiobus
      net: dsa: ar9331: register the mdiobus under devres
      net: dsa: bcm_sf2: don't use devres for mdiobus
      net: dsa: felix: don't use devres for mdiobus
      net: dsa: mt7530: fix kernel bug in mdiobus_free() when unbinding
      net: dsa: lantiq_gswip: don't use devres for mdiobus
      net: dsa: mv88e6xxx: fix use-after-free in mv88e6xxx_mdios_unregister

Vratislav Bendel (1):
      selinux: fix double free of cond_list on error paths

Waiman Long (1):
      cgroup/cpuset: Fix "suspicious RCU usage" lockdep warning

Wen Gu (1):
      net/smc: Forward wakeup to smc socket waitqueue after fallback

Wu Zheng (1):
      nvme-pci: add the IGNORE_DEV_SUBNQN quirk for Intel P4500/P4600 SSDs

Xiaoke Wang (3):
      integrity: check the return value of audit_log_start()
      nfs: nfs4clinet: check the return value of kstrdup()
      scsi: ufs: ufshcd-pltfrm: Check the return value of devm_kstrdup()

Xin Xiong (1):
      spi: uniphier: fix reference count leak in uniphier_spi_probe()

Xin Yin (3):
      ext4: prevent used blocks from being allocated during fast commit replay
      ext4: modify the logic of ext4_mb_new_blocks_simple
      ext4: fix incorrect type issue during replay_del_range

Xiyu Yang (1):
      net/sunrpc: fix reference count leaks in rpc_sysfs_xprt_state_change

Yang Li (2):
      gpio: idt3243x: Fix an ignored error return from platform_get_irq()
      gpio: mpc8xxx: Fix an ignored error return from platform_get_irq()

Yang Wang (1):
      drm/amd/pm: fix hwmon node of power1_label create issue

Yannick Vignon (1):
      net: stmmac: ensure PTP time register reads are consistent

Yuji Ishikawa (1):
      net: stmmac: dwmac-visconti: No change to ETHER_CLOCK_SEL for unexpected speed request.

Zhan Liu (1):
      drm/amd/display: Correct MPC split policy for DCN301

ZouMingzhe (1):
      scsi: target: iscsi: Make sure the np under each tpg is unique

trondmy@kernel.org (2):
      NFS: Don't overfill uncached readdir pages
      NFS: Don't skip directory entries when doing uncached readdir

Łukasz Bartosik (1):
      pinctrl: intel: fix unexpected interrupt
---
.../devicetree/bindings/arm/omap/omap.txt          |   3 +
 Documentation/gpu/todo.rst                         |  21 ---
 Makefile                                           |   2 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/imx23-evk.dts                    |   1 -
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |   5 +-
 arch/arm/boot/dts/imx7ulp.dtsi                     |   2 +-
 arch/arm/boot/dts/meson.dtsi                       |   8 +-
 arch/arm/boot/dts/meson8.dtsi                      |  24 +--
 arch/arm/boot/dts/meson8b.dtsi                     |  24 +--
 arch/arm/boot/dts/omap3-beagle-ab4.dts             |  47 ++++++
 arch/arm/boot/dts/omap3-beagle.dts                 |  33 ----
 arch/arm/boot/dts/ste-ux500-samsung-skomer.dts     |   4 -
 arch/arm/mach-socfpga/Kconfig                      |   2 +
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dtsi     |   4 +-
 .../boot/dts/amlogic/meson-sm1-bananapi-m5.dts     |   2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi  |   2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |  10 +-
 arch/arm64/include/asm/cputype.h                   |   2 +
 arch/arm64/kvm/arm.c                               |  51 +++---
 arch/arm64/kvm/handle_exit.c                       |   8 +
 arch/arm64/kvm/hyp/include/hyp/switch.h            |   3 +-
 arch/mips/cavium-octeon/octeon-memcpy.S            |   2 +-
 arch/mips/include/asm/asm.h                        |   4 +-
 arch/mips/include/asm/ftrace.h                     |   4 +-
 arch/mips/include/asm/r4kcache.h                   |   4 +-
 arch/mips/include/asm/unaligned-emul.h             | 176 ++++++++++-----------
 arch/mips/kernel/mips-r2-to-r6-emul.c              | 104 ++++++------
 arch/mips/kernel/r2300_fpu.S                       |   6 +-
 arch/mips/kernel/r4k_fpu.S                         |   2 +-
 arch/mips/kernel/relocate_kernel.S                 |  22 +--
 arch/mips/kernel/scall32-o32.S                     |  10 +-
 arch/mips/kernel/scall64-n32.S                     |   2 +-
 arch/mips/kernel/scall64-n64.S                     |   2 +-
 arch/mips/kernel/scall64-o32.S                     |  10 +-
 arch/mips/kernel/syscall.c                         |   8 +-
 arch/mips/lib/csum_partial.S                       |   4 +-
 arch/mips/lib/memcpy.S                             |   4 +-
 arch/mips/lib/memset.S                             |   2 +-
 arch/mips/lib/strncpy_user.S                       |   4 +-
 arch/mips/lib/strnlen_user.S                       |   2 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h       |   1 +
 arch/powerpc/include/asm/book3s/64/pgtable.h       |   2 +
 arch/powerpc/include/asm/fixmap.h                  |   6 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |   1 +
 arch/powerpc/include/asm/nohash/64/pgtable.h       |   1 +
 arch/powerpc/mm/pgtable.c                          |   9 ++
 arch/riscv/Makefile                                |   6 +
 arch/riscv/kernel/cpu-hotplug.c                    |   2 +
 arch/riscv/kernel/stacktrace.c                     |   9 +-
 arch/s390/kvm/kvm-s390.c                           |   2 +
 arch/x86/events/intel/core.c                       |  13 ++
 arch/x86/events/intel/lbr.c                        |   3 +
 arch/x86/events/intel/pt.c                         |   5 +-
 arch/x86/events/rapl.c                             |   9 +-
 arch/x86/kernel/cpu/sgx/encl.c                     |   2 +
 arch/x86/kvm/cpuid.c                               |  13 +-
 arch/x86/kvm/svm/svm.c                             |  16 +-
 arch/x86/kvm/vmx/evmcs.c                           |   1 +
 arch/x86/kvm/vmx/evmcs.h                           |   4 +-
 arch/x86/kvm/vmx/vmx.c                             |  25 +++
 block/bio-integrity.c                              |   2 +-
 crypto/algapi.c                                    |   1 +
 crypto/api.c                                       |   1 -
 drivers/accessibility/speakup/speakup_dectlk.c     |   1 +
 drivers/acpi/arm64/iort.c                          |  14 +-
 drivers/acpi/ec.c                                  |  10 ++
 drivers/acpi/sleep.c                               |  15 +-
 drivers/base/power/wakeup.c                        |  41 ++++-
 drivers/bus/mhi/pci_generic.c                      |   2 +
 drivers/clocksource/timer-ti-dm-systimer.c         |   2 +-
 drivers/dma-buf/dma-heap.c                         |   2 +
 drivers/edac/altera_edac.c                         |   2 +-
 drivers/edac/xgene_edac.c                          |   2 +-
 drivers/gpio/gpio-aggregator.c                     |  18 ++-
 drivers/gpio/gpio-idt3243x.c                       |   2 +-
 drivers/gpio/gpio-mpc8xxx.c                        |   2 +-
 drivers/gpio/gpio-sifive.c                         |   2 +-
 drivers/gpio/gpiolib-cdev.c                        |   6 +-
 drivers/gpio/gpiolib-sysfs.c                       |   7 +-
 drivers/gpio/gpiolib.h                             |  12 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   3 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |  20 +--
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  20 +++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |   2 +-
 .../drm/amd/display/dc/dcn301/dcn301_resource.c    |   2 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   3 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   6 +-
 drivers/gpu/drm/bridge/nwl-dsi.c                   |  12 +-
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |  12 ++
 drivers/gpu/drm/i915/display/intel_overlay.c       |   3 +
 drivers/gpu/drm/i915/display/intel_tc.c            |   3 +-
 drivers/gpu/drm/i915/i915_pci.c                    |   2 +-
 drivers/gpu/drm/i915/intel_pm.c                    |  75 ++++++---
 drivers/gpu/drm/kmb/kmb_plane.c                    |   6 -
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/base.c    |   2 +-
 drivers/gpu/drm/panel/panel-simple.c               |   1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |   8 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |  14 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   2 +
 drivers/hwmon/dell-smm-hwmon.c                     |  12 +-
 drivers/iio/industrialio-buffer.c                  |  14 +-
 drivers/infiniband/core/cm.c                       |   2 +-
 drivers/infiniband/core/cma.c                      |  22 +--
 drivers/infiniband/core/ucma.c                     |  34 ++--
 drivers/infiniband/hw/hfi1/ipoib_main.c            |  27 ++--
 drivers/infiniband/hw/mlx4/main.c                  |   2 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |   2 +
 drivers/infiniband/sw/siw/siw.h                    |   7 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c              |  20 +--
 drivers/infiniband/sw/siw/siw_verbs.c              |   3 +-
 drivers/iommu/amd/init.c                           |   2 +
 drivers/iommu/intel/irq_remapping.c                |  13 +-
 drivers/iommu/iommu.c                              |   9 +-
 drivers/irqchip/irq-realtek-rtl.c                  |   8 +-
 drivers/misc/eeprom/ee1004.c                       |   3 +
 drivers/misc/fastrpc.c                             |   9 +-
 drivers/mmc/core/sd.c                              |   8 +-
 drivers/mmc/host/moxart-mmc.c                      |   2 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |   8 +-
 drivers/net/bonding/bond_3ad.c                     |   3 +-
 drivers/net/dsa/Kconfig                            |   1 +
 drivers/net/dsa/bcm_sf2.c                          |   7 +-
 drivers/net/dsa/lantiq_gswip.c                     |  14 +-
 drivers/net/dsa/mt7530.c                           |   2 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |  15 +-
 drivers/net/dsa/ocelot/felix_vsc9959.c             |   4 +-
 drivers/net/dsa/qca/ar9331.c                       |   3 +-
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c           |   3 +
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |   4 +-
 drivers/net/ethernet/google/gve/gve_adminq.c       |   2 +-
 drivers/net/ethernet/intel/e1000e/e1000.h          |   4 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  20 +++
 drivers/net/ethernet/intel/e1000e/netdev.c         |  33 ++--
 drivers/net/ethernet/intel/ice/ice.h               |   3 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |   3 +-
 drivers/net/ethernet/intel/ice/ice_lag.c           |  34 +++-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  28 +++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |  13 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |   2 +-
 drivers/net/ethernet/mscc/ocelot.c                 |  11 +-
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |  12 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   |   9 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h    |   1 +
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  19 ++-
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |  19 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  19 ++-
 drivers/net/ieee802154/ca8210.c                    |   1 +
 drivers/net/ieee802154/mac802154_hwsim.c           |   1 +
 drivers/net/ieee802154/mcr20a.c                    |   4 +-
 drivers/net/macsec.c                               |  33 ++--
 drivers/net/mdio/mdio-aspeed.c                     |   1 +
 drivers/net/phy/marvell.c                          |  17 +-
 drivers/net/usb/ax88179_178a.c                     |  68 ++++----
 drivers/net/veth.c                                 |  13 +-
 drivers/nvme/host/fabrics.h                        |   1 +
 drivers/nvme/host/pci.c                            |   3 +-
 drivers/nvme/host/tcp.c                            |  10 +-
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c      |   3 +-
 drivers/phy/broadcom/Kconfig                       |   3 +-
 drivers/phy/phy-core-mipi-dphy.c                   |   4 +-
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c   |   3 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |   2 +-
 drivers/phy/ti/phy-j721e-wiz.c                     |   1 +
 drivers/phy/xilinx/phy-zynqmp.c                    |  11 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |  23 ++-
 drivers/pinctrl/intel/pinctrl-intel.c              |  64 ++++----
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c        |   8 +-
 drivers/rtc/rtc-mc146818-lib.c                     |   2 +-
 drivers/s390/cio/device.c                          |   2 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  |  21 ++-
 drivers/scsi/lpfc/lpfc.h                           |  13 +-
 drivers/scsi/lpfc/lpfc_attr.c                      |   4 +-
 drivers/scsi/lpfc/lpfc_init.c                      |   2 +-
 drivers/scsi/lpfc/lpfc_sli.c                       |   8 +-
 drivers/scsi/myrs.c                                |   3 +-
 drivers/scsi/pm8001/pm80xx_hwi.c                   |  16 +-
 drivers/scsi/pm8001/pm80xx_hwi.h                   |   6 +-
 drivers/scsi/qedf/qedf_io.c                        |   1 +
 drivers/scsi/qedf/qedf_main.c                      |   7 +-
 drivers/scsi/ufs/ufshcd-pltfrm.c                   |   7 +
 drivers/scsi/ufs/ufshcd.c                          |   9 +-
 drivers/scsi/ufs/ufshci.h                          |   3 +-
 drivers/soc/mediatek/mtk-scpsys.c                  |  15 +-
 drivers/spi/spi-bcm-qspi.c                         |   2 +-
 drivers/spi/spi-meson-spicc.c                      |   5 +
 drivers/spi/spi-mt65xx.c                           |   2 +-
 drivers/spi/spi-stm32-qspi.c                       |  47 ++----
 drivers/spi/spi-uniphier.c                         |  18 ++-
 drivers/staging/fbtft/fbtft.h                      |   5 +-
 drivers/target/iscsi/iscsi_target_tpg.c            |   3 +
 drivers/thermal/intel/int340x_thermal/Kconfig      |   4 +-
 .../intel/int340x_thermal/int3401_thermal.c        |   8 +-
 .../int340x_thermal/processor_thermal_device.c     |  36 ++++-
 .../int340x_thermal/processor_thermal_device.h     |   4 +-
 .../int340x_thermal/processor_thermal_device_pci.c |  18 ++-
 .../processor_thermal_device_pci_legacy.c          |   8 +-
 .../intel/int340x_thermal/processor_thermal_mbox.c | 104 +++++++-----
 .../intel/int340x_thermal/processor_thermal_rfim.c |  23 +--
 drivers/tty/n_tty.c                                |   4 +-
 drivers/tty/vt/vt_ioctl.c                          |   3 +-
 drivers/usb/common/ulpi.c                          |  10 +-
 drivers/usb/dwc2/gadget.c                          |   2 +-
 drivers/usb/dwc3/gadget.c                          |  13 ++
 drivers/usb/gadget/composite.c                     |   3 +
 drivers/usb/gadget/function/f_fs.c                 |  56 +++++--
 drivers/usb/gadget/function/f_uac2.c               |   4 +-
 drivers/usb/gadget/function/rndis.c                |   9 +-
 drivers/usb/gadget/legacy/raw_gadget.c             |   2 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |   2 +
 drivers/usb/serial/ch341.c                         |   1 +
 drivers/usb/serial/cp210x.c                        |   2 +
 drivers/usb/serial/ftdi_sio.c                      |   3 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   3 +
 drivers/usb/serial/option.c                        |   2 +
 drivers/video/console/Kconfig                      |  20 +++
 drivers/video/fbdev/core/fbcon.c                   |  65 ++++++--
 drivers/video/fbdev/core/fbcon.h                   |  15 +-
 drivers/video/fbdev/core/fbcon_ccw.c               |  10 +-
 drivers/video/fbdev/core/fbcon_cw.c                |  10 +-
 drivers/video/fbdev/core/fbcon_rotate.h            |   4 +-
 drivers/video/fbdev/core/fbcon_ud.c                |  20 +--
 fs/9p/fid.c                                        |   9 +-
 fs/btrfs/block-group.c                             |  13 ++
 fs/btrfs/ioctl.c                                   |   5 +-
 fs/btrfs/qgroup.c                                  |  21 ++-
 fs/btrfs/transaction.c                             |  24 +++
 fs/btrfs/transaction.h                             |   2 +
 fs/ext4/ext4.h                                     |   3 +
 fs/ext4/extents.c                                  |   4 +
 fs/ext4/fast_commit.c                              |  89 ++++++-----
 fs/ext4/inline.c                                   |  10 +-
 fs/ext4/mballoc.c                                  |  26 +--
 fs/gfs2/file.c                                     |   7 +-
 fs/ksmbd/smb2pdu.c                                 |   2 +-
 fs/nfs/callback.h                                  |   2 +-
 fs/nfs/callback_proc.c                             |   2 +-
 fs/nfs/callback_xdr.c                              |  18 +--
 fs/nfs/client.c                                    |   9 +-
 fs/nfs/dir.c                                       |  24 +--
 fs/nfs/nfs4_fs.h                                   |  12 +-
 fs/nfs/nfs4client.c                                |   5 +-
 fs/nfs/nfs4namespace.c                             |  19 ++-
 fs/nfs/nfs4proc.c                                  |  96 ++++++++---
 fs/nfs/nfs4state.c                                 |   6 +-
 fs/nfs/nfs4xdr.c                                   |   9 +-
 fs/nfsd/nfs3proc.c                                 |  13 +-
 fs/nfsd/nfs3xdr.c                                  |   2 +-
 fs/nfsd/nfs4proc.c                                 |  13 +-
 fs/nfsd/nfs4state.c                                |   4 +-
 fs/nfsd/nfs4xdr.c                                  |   8 +-
 fs/nfsd/trace.h                                    |  14 +-
 fs/nfsd/vfs.c                                      |   4 +
 include/linux/kvm_host.h                           | 112 ++++++++++++-
 include/linux/memcontrol.h                         |   5 +-
 include/linux/nfs_fs.h                             |   4 +-
 include/linux/nfs_fs_sb.h                          |   2 +-
 include/linux/nfs_xdr.h                            |   1 +
 include/linux/pgtable.h                            |   1 +
 include/linux/suspend.h                            |  15 +-
 include/net/dst_metadata.h                         |  14 +-
 include/uapi/linux/netfilter/nf_conntrack_common.h |   2 +-
 include/uapi/sound/asound.h                        |   4 +-
 ipc/sem.c                                          |   4 +-
 kernel/audit.c                                     |  62 +++++---
 kernel/bpf/ringbuf.c                               |   2 +-
 kernel/cgroup/cpuset.c                             |  10 ++
 kernel/events/core.c                               |  32 +++-
 kernel/power/main.c                                |   5 +-
 kernel/power/process.c                             |   2 +-
 kernel/power/snapshot.c                            |  21 +--
 kernel/power/suspend.c                             |   2 -
 kernel/sched/core.c                                |  12 +-
 kernel/seccomp.c                                   |  10 ++
 kernel/signal.c                                    |   5 +-
 kernel/trace/trace_events_hist.c                   |   3 +
 localversion-rt                                    |   2 +-
 mm/debug_vm_pgtable.c                              |   2 +
 mm/kmemleak.c                                      |  13 +-
 mm/memcontrol.c                                    |  10 +-
 net/bridge/netfilter/nft_reject_bridge.c           |   8 +-
 net/can/isotp.c                                    |  29 +++-
 net/core/dev.c                                     |  16 +-
 net/core/link_watch.c                              |   4 +-
 net/core/rtnetlink.c                               |   8 +-
 net/hsr/hsr_device.c                               |   6 +-
 net/ieee802154/nl802154.c                          |   8 +-
 net/ipv4/ipmr.c                                    |   2 +
 net/ipv6/ip6mr.c                                   |   2 +
 net/mptcp/pm_netlink.c                             |  42 +++--
 net/netfilter/nf_conntrack_netlink.c               |   3 +-
 net/sched/sch_api.c                                |   2 +-
 net/smc/af_smc.c                                   | 133 ++++++++++++++--
 net/smc/smc.h                                      |  20 ++-
 net/sunrpc/clnt.c                                  |   5 +-
 net/sunrpc/sysfs.c                                 |  41 ++---
 net/tipc/link.c                                    |   9 +-
 net/tipc/monitor.c                                 |   2 +
 net/tipc/name_distr.c                              |   2 +-
 scripts/Makefile.extrawarn                         |   1 +
 security/integrity/digsig_asymmetric.c             |  15 +-
 security/integrity/ima/ima_fs.c                    |   2 +-
 security/integrity/ima/ima_policy.c                |   8 +
 security/integrity/ima/ima_template.c              |  10 +-
 security/integrity/integrity_audit.c               |   2 +
 security/selinux/ss/conditional.c                  |   3 +-
 sound/pci/hda/hda_auto_parser.c                    |   2 +-
 sound/pci/hda/hda_codec.c                          |   4 +
 sound/pci/hda/hda_generic.c                        |  17 +-
 sound/pci/hda/hda_generic.h                        |   3 +
 sound/pci/hda/patch_realtek.c                      |  67 ++++++--
 sound/soc/codecs/cpcap.c                           |   2 +
 sound/soc/codecs/hdmi-codec.c                      |   2 +-
 sound/soc/codecs/lpass-rx-macro.c                  |   8 +-
 sound/soc/codecs/max9759.c                         |   3 +-
 sound/soc/codecs/wcd938x.c                         |  31 ++--
 sound/soc/fsl/pcm030-audio-fabric.c                |  11 +-
 sound/soc/generic/simple-card.c                    |  26 ++-
 sound/soc/soc-ops.c                                |  29 +++-
 sound/soc/xilinx/xlnx_formatter_pcm.c              |  27 +++-
 sound/usb/mixer.c                                  |   4 +
 sound/usb/quirks-table.h                           |   2 +-
 tools/bpf/resolve_btfids/Makefile                  |   6 +-
 tools/include/uapi/sound/asound.h                  |   4 +-
 tools/perf/util/stat-display.c                     |  19 +--
 tools/testing/selftests/exec/Makefile              |   2 +-
 tools/testing/selftests/futex/Makefile             |   4 +-
 .../selftests/netfilter/nft_concat_range.sh        |  72 ++++++++-
 tools/testing/selftests/netfilter/nft_nat.sh       | 152 ++++++++++++++++++
 virt/kvm/eventfd.c                                 |   8 +-
 332 files changed, 2962 insertions(+), 1300 deletions(-)
---
