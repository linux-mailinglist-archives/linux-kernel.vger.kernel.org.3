Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127DC55A35A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiFXVLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiFXVLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:11:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B4485D1A;
        Fri, 24 Jun 2022 14:11:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B000EB82C3E;
        Fri, 24 Jun 2022 21:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00936C34114;
        Fri, 24 Jun 2022 21:11:28 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.49-rt47
Date:   Fri, 24 Jun 2022 21:08:57 -0000
Message-ID: <165610493706.429737.11730382779996030618@puck.lan>
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
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.49-rt47 stable release. Apologies for the long
gap (5.15.44 -> 5.15.49) but good old printk was giving me issues. I believe I
have it sorted, but please let me know if you encounter any issues.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 9230df41d49f88a88dbc2724f721c0aa9c74e2cd

Or to build 5.15.49-rt47 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.49.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.49-rt47.patch.xz


Enjoy!
Clark

Changes from v5.15.44-rt46:
---

Abhinav Kumar (1):
      drm/msm/dpu: handle pm_runtime_get_sync() errors in bind path

Abhishek Kumar (1):
      ath10k: skip ath10k_halt during suspend for driver state RESTARTING

Adam Ford (3):
      arm64: dts: imx8mm-beacon: Enable RTS-CTS on UART3
      arm64: dts: imx8mn-beacon: Enable RTS-CTS on UART3
      ASoC: wm8962: Fix suspend while playing music

Adam Wujek (1):
      hwmon: (pmbus) Check PEC support before reading other registers

Aditya Garg (1):
      efi: Do not import certificates from UEFI Secure Boot for T2 Macs

Adrian Hunter (1):
      mmc: block: Fix CQE recovery reset success

Aidan MacDonald (1):
      mmc: jz4740: Apply DMA engine limits to maximum segment size

Ajay Singh (1):
      wilc1000: fix crash observed in AP mode with cfg80211_register_netdevice()

Akira Yokosawa (2):
      docs: submitting-patches: Fix crossref to 'The canonical patch format'
      docs/conf.py: Cope with removal of language=None in Sphinx 5.0.0

Al Viro (1):
      percpu_ref_init(): clean ->percpu_count_ref on failure

Alan Previn (1):
      drm/i915/reset: Fix error_state_read ptr + offset use

Albert Wang (1):
      usb: dwc3: gadget: Move null pinter check to proper place

Aleksandr Loktionov (1):
      i40e: Fix call trace in setup_tx_descriptors

Alex Deucher (3):
      drm/amdgpu/psp: move PSP memory alloc from hw_init to sw_init
      drm/amdgpu: add beige goby PCI ID
      drm/amdgpu: update VCN codec support for Yellow Carp

Alex Elder (4):
      net: ipa: compute proper aggregation limit
      net: ipa: ignore endianness if there is no header
      net: ipa: fix page free in ipa_endpoint_trans_release()
      net: ipa: fix page free in ipa_endpoint_replenish_one()

Alexander Aring (2):
      dlm: fix plock invalid read
      dlm: fix missing lkb refcount handling

Alexander Gordeev (1):
      s390/mcck: isolate SIE instruction when setting CIF_MCCK_GUEST flag

Alexander Lobakin (1):
      modpost: fix removing numeric suffixes

Alexander Usyskin (2):
      mei: hbm: drop capability response on early shutdown
      mei: me: add raptor lake point S DID

Alexander Wetzel (1):
      rtl818x: Prevent using not initialized queues

Alexandre Ghiti (1):
      riscv: Initialize thread pointer before calling C functions

Alexandru Elisei (1):
      arm64: compat: Do not treat syscall number as ESR_ELx for a bad syscall

Alexandru Tachici (1):
      iio: adc: ad7124: Remove shift from scan_type

Alexey Dobriyan (1):
      proc: fix dentry/inode overinstantiating under /proc/${pid}/net

Alexey Kardashevskiy (1):
      powerpc/mm: Switch obsolete dssall to .long

Alexey Khoroshilov (1):
      ASoC: max98090: Move check for invalid values before casting in max98090_put_enab_tlv()

Alice Wong (1):
      drm/amdgpu/ucode: Remove firmware load type check in amdgpu_ucode_free_bo

Allen-KH Cheng (1):
      arm64: dts: mt8192: Fix nor_flash status disable typo

Amadeusz Sławiński (1):
      ALSA: jack: Access input_dev under mutex

Amelie Delaunay (2):
      dmaengine: stm32-mdma: remove GISR1 register
      dmaengine: stm32-mdma: fix chan initialization in stm32_mdma_irq_handler()

Amir Goldstein (2):
      inotify: show inotify mask flags in proc fdinfo
      fsnotify: fix wrong lockdep annotations

Ammar Faizi (2):
      x86/MCE/AMD: Fix memory leak when threshold_create_bank() fails
      x86/delay: Fix the wrong asm constraint in delay_loop()

Andre Przywara (3):
      kselftest/arm64: bti: force static linking
      ARM: dts: suniv: F1C100: fix watchdog compatible
      clocksource/drivers/sp804: Avoid error on multiple instances

Andrea Parri (Microsoft) (1):
      Drivers: hv: vmbus: Fix handling of messages with transaction ID of zero

Andreas Gruenbacher (1):
      iomap: iomap_write_failed fix

Andrii Nakryiko (3):
      libbpf: Don't error out on CO-RE relos for overriden weak subprogs
      libbpf: Fix logic for finding matching program for CO-RE relocation
      selftests/bpf: fix selftest after random: Urandom_read tracepoint removal

Andy Chi (1):
      ALSA: hda/realtek: fix right sounds and mute/micmute LEDs for HP machine

Andy Shevchenko (3):
      device property: Allow error pointer to be passed to fwnode APIs
      list: introduce list_is_head() helper and re-use it in list.h
      pvpanic: Fix typos in the comments

Anna Schumaker (1):
      NFS: Create a new nfs_alloc_fattr_with_label() function

Arnaud Pouliquen (1):
      rpmsg: virtio: Fix the unregistration of the device rpmsg_ctrl

Arnd Bergmann (2):
      drbd: fix duplicate array initializer
      ARM: pxa: maybe fix gpio lookup tables

Ashish Kalra (1):
      KVM: SVM: Use kzalloc for sev ioctl interfaces to prevent kernel data leak

August Wikerfors (1):
      platform/x86: gigabyte-wmi: Add support for B450M DS3H-CF

Baochen Qiang (1):
      ath11k: Don't check arvif->is_started before sending management frames

Baokun Li (4):
      ext4: fix race condition between ext4_write and ext4_convert_inline_data
      ext4: fix bug_on in __es_tree_search
      jffs2: fix memory leak in jffs2_do_fill_super
      ext4: fix bug_on ext4_mb_use_inode_pa

Baoquan He (1):
      x86/kexec: fix memory leak of elf header buffer

Bart Van Assche (3):
      scsi: ufs: qcom: Fix ufs_qcom_resume()
      block: Fix the bio.bi_opf comment
      block: Fix handling of offline queues in blk_mq_alloc_request_hctx()

Basavaraj Natikar (2):
      HID: amd_sfh: Modify the bus name
      HID: amd_sfh: Modify the hid name

Bean Huo (1):
      mmc: core: Allows to override the timeout value for ioctl() path

Benjamin Gaignard (2):
      media: hantro: HEVC: unconditionnaly set pps_{cb/cr}_qp_offset values
      media: hantro: HEVC: Fix tile info buffer value computation

Biju Das (1):
      spi: spi-rspi: Remove setting {src,dst}_{addr,addr_width} based on DMA direction

Bjorn Andersson (3):
      drm/msm/dp: Modify prototype of encoder based API
      soc: qcom: llcc: Add MODULE_DEVICE_TABLE()
      usb: typec: mux: Check dev_set_name() return value

Bjorn Helgaas (1):
      PCI/PM: Fix bridge_d3_blacklist[] Elo i2 overwrite of Gigabyte X299

Björn Ardö (1):
      mailbox: forward the hrtimer if not queued and under a lock

Bjørn Mork (1):
      mtdblock: warn if opened on NAND

Bob Peterson (1):
      gfs2: use i_lock spin_lock for inode qadata

Bodo Stroesser (1):
      scsi: target: tcmu: Avoid holding XArray lock when calling lock_page

Borislav Petkov (1):
      x86/microcode: Add explicit CPU vendor dependency

Brian Norris (4):
      PM / devfreq: rk3399_dmc: Disable edev on remove()
      drm/bridge: analogix_dp: Grab runtime PM reference for DP-AUX
      drm/bridge: analogix_dp: Support PSR-exit to disable transition
      drm/atomic: Force bridge self-refresh-exit on CRTC switch

Bryan O'Donoghue (2):
      media: i2c: imx412: Fix reset GPIO polarity
      media: i2c: imx412: Fix power_off ordering

Cai Huoqing (1):
      media: staging: media: rkvdec: Make use of the helper function devm_platform_ioremap_resource()

Caleb Connolly (2):
      pinctrl/rockchip: support deferring other gpio params
      pinctrl/rockchip: support setting input-enable param

Cameron Berkenpas (1):
      ALSA: hda/realtek: Fix for quirk to enable speaker output on the Lenovo Yoga DuetITL 2021

Carl Yin(殷张成) (1):
      USB: serial: option: add Quectel BG95 modem

Chaitanya Kulkarni (1):
      nvme: set non-mdts limits in nvme_scan_work

Changbin Du (1):
      sysrq: do not omit current cpu when showing backtrace of all active CPUs

Changcheng Liu (1):
      net/mlx5: correct ECE offset in query qp output

Chao Yu (10):
      f2fs: support fault injection for dquot_initialize()
      f2fs: fix to do sanity check on inline_dots inode
      f2fs: fix to avoid f2fs_bug_on() in dec_valid_node_count()
      f2fs: fix to do sanity check on block address in f2fs_do_zero_range()
      f2fs: fix to clear dirty inode in f2fs_evict_inode()
      f2fs: fix deadloop in foreground GC
      f2fs: fix to do sanity check on total_data_blocks
      f2fs: fix fallocate to use file_modified to update permissions consistently
      f2fs: fix to do sanity check for inline inode
      f2fs: fix to tag gcing flag on page during file defragment

Charles Keepax (9):
      ASoC: tscs454: Add endianness flag in snd_soc_component_driver
      ASoC: atmel-pdmic: Remove endianness flag on pdmic component
      ASoC: atmel-classd: Remove endianness flag on class d component
      ASoC: cs42l52: Fix TLV scales for mixer controls
      ASoC: cs35l36: Update digital volume TLV
      ASoC: cs53l30: Correct number of volume levels on SX controls
      ASoC: cs42l52: Correct TLV for Bypass Volume
      ASoC: cs42l56: Correct typo in minimum level for SX volume controls
      ASoC: cs42l51: Correct minimum value for SX volume control

Chen Lin (1):
      net: ethernet: mtk_eth_soc: fix misuse of mem alloc interface netdev[napi]_alloc_frag

Chen-Tsung Hsieh (1):
      mtd: spi-nor: core: Check written SR value in spi_nor_write_16bit_sr_and_check()

Chen-Yu Tsai (1):
      media: hantro: Empty encoder capture buffers by default

Chengguang Xu (2):
      scsi: ipr: Fix missing/incorrect resource cleanup in error case
      scsi: pmcraid: Fix missing resource cleanup in error case

Chengming Zhou (2):
      sched/fair: Fix cfs_rq_clock_pelt() for throttled cfs_rq
      sched/psi: report zeroes for CPU full at the system level

Christian Borntraeger (1):
      s390/gmap: voluntarily schedule during key setting

Christian Brauner (2):
      fs: add two trivial lookup helpers
      exportfs: support idmapped mounts

Christoph Hellwig (8):
      target: remove an incorrect unmap zeroes data deduction
      virtio_blk: fix the discard_granularity and discard_alignment queue limits
      dma-direct: factor out a helper for DMA_ATTR_NO_KERNEL_MAPPING allocations
      dma-direct: don't fail on highmem CMA pages in dma_direct_alloc_pages
      dma-direct: factor out dma_set_{de,en}crypted helpers
      dma-direct: don't call dma_set_decrypted for remapped allocations
      dma-direct: always leak memory that can't be re-encrypted
      block: take destination bvec offsets into account in bio_copy_data_iter

Christophe JAILLET (13):
      fs/ntfs3: Fix some memory leaks in an error handling path of 'log_replay()'
      media: aspeed: Fix an error handling path in aspeed_video_probe()
      mt76: mt7921: Fix the error handling path of mt7921_pci_probe()
      hinic: Avoid some over memory allocation
      memory: samsung: exynos5422-dmc: Avoid some over memory allocation
      drivers/base/memory: fix an unlikely reference counting issue in __add_memory_block()
      powerpc/xive: Add some error handling code to 'xive_spapr_init()'
      dmaengine: idxd: Fix the error handling path in idxd_cdev_register()
      staging: fieldbus: Fix the error handling path in anybuss_host_common_probe()
      virtio: pci: Fix an error handling path in vp_modern_probe()
      drm/bridge: sn65dsi83: Fix an error handling path in sn65dsi83_probe()
      stmmac: intel: Fix an error handling path in intel_eth_pci_probe()
      net: bgmac: Fix an erroneous kfree() in bgmac_remove()

Christophe Leroy (1):
      lkdtm/bugs: Don't expect thread termination without CONFIG_UBSAN_TRAP

Christophe de Dinechin (1):
      nodemask.h: fix compilation error with GCC12

Chuanhong Guo (2):
      mtd: spinand: gigadevice: fix Quad IO for GD5F1GQ5UExxG
      arm: mediatek: select arch timer for mt7629

Chuck Lever (3):
      NFSD: Fix possible sleep during nfsd4_release_lockowner()
      SUNRPC: Trap RDMA segment overflows
      SUNRPC: Fix the calculation of xdr->end in xdr_get_next_encode_buffer()

Cixi Geng (2):
      iio: adc: sc27xx: fix read big scale voltage not right
      iio: adc: sc27xx: Fine tune the scale calibration values

Clark Williams (2):
      Merge tag 'v5.15.49' into v5.15-rt
      'Linux 5.15.49-rt47'

Colin Ian King (3):
      ALSA: pcm: Check for null pointer of pointer substream before dereferencing it
      drm/v3d: Fix null pointer dereference of pointer perfmon
      selftests/resctrl: Fix null pointer dereference on open failed

Coly Li (4):
      bcache: improve multithreaded bch_btree_check()
      bcache: improve multithreaded bch_sectors_dirty_init()
      bcache: remove incremental dirty sector counting for bch_sectors_dirty_init()
      bcache: avoid journal no-space deadlock by reserving 1 journal bucket

Corentin Labbe (3):
      crypto: marvell/cesa - ECB does not IV
      crypto: sun8i-ss - rework handling of IV
      crypto: sun8i-ss - handle zero sized sg

Corey Minyard (2):
      ipmi:ssif: Check for NULL msg when handling events and messages
      ipmi: Fix pr_fmt to avoid compilation issues

Craig McLure (1):
      ALSA: usb-audio: Configure sync endpoints before data

Cristian Marussi (1):
      firmware: arm_scmi: Fix list protocols enumeration in the base protocol

Daire McNamara (1):
      PCI: microchip: Fix potential race in interrupt handling

Damien Le Moal (2):
      scsi: sd: Fix potential NULL pointer dereference
      zonefs: fix handling of explicit_open option on mount

Dan Carpenter (13):
      i2c: ismt: prevent memory corruption in ismt_access()
      dm integrity: fix error code in dm_integrity_ctr()
      ath9k_htc: fix potential out of bounds access with invalid rxstatus->rs_keyix
      scsi: iscsi: Fix harmless double shift bug
      drm/msm: return an error pointer in msm_gem_prime_get_sg_table()
      PCI: cadence: Fix find_first_zero_bit() limit
      PCI: rockchip: Fix find_first_zero_bit() limit
      OPP: call of_node_put() on error path in _bandwidth_supported()
      dlm: uninitialized variable on error in dlm_listen_for_all()
      staging: r8188eu: delete rtw_wx_read/write32()
      net: ethernet: mtk_eth_soc: out of bounds read in mtk_hwlro_get_fdir_entry()
      octeontx2-af: fix error code in is_valid_offset()
      extcon: Fix extcon_get_extcon_dev() error handling

Dan Williams (2):
      nvdimm: Fix firmware activation deadlock scenarios
      nvdimm: Allow overwrite in the presence of disabled dimms

Daniel Gibson (1):
      tty: n_tty: Restore EOF push handling behavior

Daniel Latypov (1):
      kunit: fix debugfs code to use enum kunit_status, not bool

Daniel Scally (1):
      device property: Check fwnode->secondary when finding properties

Daniel Thompson (1):
      irqchip/exiu: Fix acknowledgment of edge triggered interrupts

Daniel Vetter (1):
      fbcon: Consistently protect deferred_takeover with console_lock()

Dave Airlie (1):
      drm/amdgpu/cs: make commands with 0 chunks illegal behaviour.

Dave Jiang (2):
      dmaengine: idxd: set DMA_INTERRUPT cap bit
      dmaengine: idxd: add missing callback function to support DMA_INTERRUPT

David Galiffi (1):
      drm/amd/display: Check if modulo is 0 before dividing.

David Gow (1):
      list: test: Add a test for list_is_head()

David Howells (11):
      pipe: Fix missing lock in pipe_resize_ring()
      rxrpc: Return an error to sendmsg if call failed
      rxrpc, afs: Fix selection of abort codes
      afs: Adjust ACK interpretation to try and cope with NAT
      rxrpc: Fix listen() setting the bar too high for the prealloc rings
      rxrpc: Don't try to resend the request if we're receiving the reply
      rxrpc: Fix overlapping ACK accounting
      rxrpc: Don't let ack.previousPacket regress
      rxrpc: Fix decision on when to generate an IDLE ACK
      afs: Fix infinite loop found by xfstest generic/676
      iov_iter: Fix iter_xarray_get_pages{,_alloc}()

David Safford (1):
      KEYS: trusted: tpm2: Fix migratable logic

Davide Caratti (1):
      net/sched: act_police: more accurate MTU policing

Denis Efremov (1):
      staging: r8188eu: prevent ->Ssid overflow in rtw_wx_set_scan()

Dennis Dalessandro (1):
      RDMA/hfi1: Fix potential integer multiplication overflow errors

Dimitri John Ledkov (1):
      cfg80211: declare MODULE_FIRMWARE for regulatory.db

Ding Xiang (1):
      ext4: make variable "count" signed

Dinh Nguyen (1):
      dt-bindings: gpio: altera: correct interrupt-cells

Diogo Ivo (2):
      arm64: tegra: Add missing DFLL reset on Tegra210
      clk: tegra: Add missing reset deassertion

Dmitry Baryshkov (5):
      drm/msm/hdmi: switch to drm_bridge_connector
      drm/msm/dsi: fix error checks and return values for DSI xmit functions
      drm/msm: add missing include to msm_drv.c
      drm/msm/dsi: fix address for second DSI PHY on SDM660
      drm/msm: don't free the IRQ if it was not requested

Dmitry Monakhov (1):
      ext4: mark group as trimmed only if it was fully scanned

Dmitry Torokhov (1):
      Input: stmfts - do not leave device disabled in stmfts_input_open

Dong Aisheng (1):
      Revert "mm/cma.c: remove redundant cma_mutex lock"

Dongliang Mu (4):
      HID: bigben: fix slab-out-of-bounds Write in bigben_probe
      rtlwifi: Use pr_warn instead of WARN_ONCE
      media: ov7670: remove ov7670_power_off from ov7670_remove
      f2fs: remove WARN_ON in f2fs_is_valid_blkaddr

Douglas Miller (2):
      RDMA/hfi1: Prevent panic when SDMA is disabled
      RDMA/hfi1: Prevent use of lock before it is initialized

Duke Lee (1):
      platform/x86/intel: hid: Add Surface Go to VGBS allow list

Duoming Zhou (8):
      NFC: hci: fix sleep in atomic context bugs in nfc_hci_hcp_message_tx
      drivers: staging: rtl8723bs: Fix deadlock in rtw_surveydone_event_callback()
      drivers: staging: rtl8192bs: Fix deadlock in rtw_joinbss_event_prehandle()
      drivers: staging: rtl8192u: Fix deadlock in ieee80211_beacons_stop()
      drivers: staging: rtl8192e: Fix deadlock in rtllib_beacons_stop()
      drivers: tty: serial: Fix deadlock in sa1100_set_termios()
      drivers: usb: host: Fix deadlock in oxu_bus_suspend()
      net: ax25: Fix deadlock caused by skb_recv_datagram in ax25_recvmsg

Eli Cohen (1):
      vdpa: Fix error logic in vdpa_nl_cmd_dev_get_doit

Emmanuel Grumbach (1):
      iwlwifi: mvm: fix assert 1F04 upon reconfig

Eric Biggers (3):
      ext4: reject the 'commit' option on ext2 filesystems
      f2fs: don't use casefolded comparison for "." and ".."
      ext4: only allow test_dummy_encryption when supported

Eric Dumazet (6):
      net: remove two BUG() from skb_checksum_help()
      sctp: read sk->sk_bound_dev_if once in sctp_rcv()
      tcp: add accessors to read/set tp->snd_cwnd
      tcp: tcp_rtx_synack() can be called from process context
      bpf, arm64: Clear prog->jited_len along prog->jited
      tcp: fix tcp_mtup_probe_success vs wrong snd_cwnd

Eric W. Biederman (3):
      ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP
      ptrace/xtensa: Replace PT_SINGLESTEP with TIF_SINGLESTEP
      ptrace: Reimplement PTRACE_KILL by always sending SIGKILL

Etienne van der Linde (1):
      nfp: flower: restructure flow-key for gre+vlan combination

Eugen Hristev (2):
      media: atmel: atmel-sama5d2-isc: fix wrong mask in YUYV format check
      ARM: dts: at91: sama7g5: remove interrupt-parent from gic node

Eugenio Pérez (1):
      vdpasim: allow to enable a vq repeatedly

Evan Green (1):
      USB: hcd-pci: Fully suspend across freeze/thaw cycle

Evan Quan (1):
      drm/amd/pm: fix the compile warning

Fabien Parent (2):
      pinctrl: mediatek: mt8195: enable driver on mtk platforms
      regulator: mt6315-regulator: fix invalid allowed mode

Fabio Estevam (2):
      crypto: caam - fix i.MX6SX entropy delay value
      net: phy: micrel: Allow probing without .driver_data

Felix Fietkau (4):
      mt76: mt7921: accept rx frames with non-standard VHT MCS10-11
      mt76: fix encap offload ethernet type check
      mt76: do not attempt to reorder received 802.3 packets without agg session
      mac80211: upgrade passive scan to active scan on DFS channels after beacon rx

Feras Daoud (1):
      net/mlx5: Rearm the FW tracer after each tracer event

Finn Thain (1):
      macintosh/via-pmu: Fix build failure when CONFIG_INPUT is disabled

Florian Westphal (2):
      netfilter: conntrack: re-fetch conntrack after insertion
      netfilter: nat: really support inet nat without l3 address

Forest Crossman (1):
      ALSA: usb-audio: Don't get sample rate for MCT Trigger 5 USB-to-HDMI

Francesco Dolcini (1):
      PCI: imx6: Fix PERST# start-up sequence

GUO Zihua (1):
      ima: remove the IMA_TEMPLATE Kconfig option

Gal Pressman (1):
      net/mlx4_en: Fix wrong return value on ioctl EEPROM query failure

Gautam Menghani (1):
      tracing: Initialize integer variable to prevent garbage return value

Geert Uytterhoeven (3):
      m68k: atari: Make Atari ROM port I/O write macros return void
      m68k: math-emu: Fix dependencies of math emulation support
      pinctrl: renesas: r8a779a0: Fix GPIO function on I2C-capable pins

Gilad Ben-Yossef (1):
      crypto: ccree - use fine grained DMA mapping dir

Giovanni Cabiddu (4):
      crypto: qat - set CIPHER capability for QAT GEN2
      crypto: qat - set COMPRESSION capability for QAT GEN2
      crypto: qat - set CIPHER capability for DH895XCC
      crypto: qat - set COMPRESSION capability for DH895XCC

Gong Yuanjun (2):
      mips: cpc: Fix refcount leak in mips_cpc_default_phys_base
      drm/radeon: fix a possible null pointer dereference

Greg Kroah-Hartman (6):
      Linux 5.15.45
      Linux 5.15.46
      export: fix string handling of namespace in EXPORT_SYMBOL_NS
      Linux 5.15.47
      Linux 5.15.48
      Linux 5.15.49

Greg Ungerer (3):
      m68knommu: set ZERO_PAGE() to the allocated zeroed page
      m68knommu: fix undefined reference to `_init_sp'
      m68knommu: fix undefined reference to `mach_get_rtc_pll'

Grzegorz Szczurek (2):
      i40e: Fix adding ADQ filter to TC0
      i40e: Fix calculating the number of queue pairs

Guangbin Huang (2):
      net: hns3: set port base vlan tbl_sta to false before removing old vlan
      net: hns3: fix tm port shapping of fibre port is incorrect after driver initialization

Guangguan Wang (1):
      net/smc: fixes for converting from "struct smc_cdc_tx_pend **" to "struct smc_wr_tx_pend_priv *"

Guenter Roeck (2):
      platform/chrome: Re-introduce cros_ec_cmd_xfer and use it for ioctls
      MIPS: Loongson: Use hwmon_device_register_with_groups() to register hwmon

Guilherme G. Piccoli (2):
      misc/pvpanic: Convert regular spinlock into trylock on panic path
      coresight: cpu-debug: Replace mutex with mutex_trylock on panic notifier

Guo Ren (1):
      csky: patch_text: Fixup last cpu should be master

Guoju Fang (1):
      net: sched: add barrier to fix packet stuck problem for lockless qdisc

Guoqing Jiang (1):
      md: protect md_unregister_thread from reentrancy

Gustavo A. R. Silva (5):
      drm/i915: Fix -Wstringop-overflow warning in call to intel_read_wm_latency()
      net: stmmac: selftests: Use kcalloc() instead of kzalloc()
      net: huawei: hinic: Use devm_kcalloc() instead of devm_kzalloc()
      scsi: fcoe: Fix Wstringop-overflow warnings in fcoe_wwn_from_mac()
      staging: r8188eu: Use zeroing allocator in wpa_set_encryption()

Haibo Chen (1):
      gpio: pca953x: use the correct register address to do regcache sync

Hangbin Liu (1):
      selftests/bpf: Add missed ima_setup.sh in Makefile

Hangyu Hua (7):
      media: rga: fix possible memory leak in rga_probe
      drm: msm: fix possible memory leak in mdp5_crtc_cursor_set()
      misc: ocxl: fix possible double free in ocxl_file_register_afu
      usb: usbip: fix a refcount leak in stub_probe()
      rpmsg: virtio: Fix possible double free in rpmsg_probe()
      rpmsg: virtio: Fix possible double free in rpmsg_virtio_add_ctrl_dev()
      char: xillybus: fix a refcount leak in cleanup_dev()

Hannes Reinecke (1):
      scsi: myrb: Fix up null pointer access on myrb_cleanup()

Hans Verkuil (2):
      media: ccs-core.c: fix failure to call clk_disable_unprepare
      media: cec-adap.c: fix is_configuring state

Hans de Goede (2):
      ASoC: Intel: bytcr_rt5640: Add quirk for the HP Pro Tablet 408
      power: supply: axp288_fuel_gauge: Drop BIOS version check from "T3 MRD" DMI quirk

Hao Jia (1):
      sched/core: Avoid obvious double update_rq_clock warning

Hao Luo (1):
      kernfs: Separate kernfs_pr_cont_buf and rename_lock.

Haohui Mai (1):
      drm/amdgpu/sdma: Fix incorrect calculations of the wptr of the doorbells

Haowen Bai (4):
      b43legacy: Fix assigning negative value to unsigned variable
      b43: Fix assigning negative value to unsigned variable
      ipw2x00: Fix potential NULL dereference in libipw_xmit()
      sfc: ef10: Fix assigning negative value to unsigned variable

Haren Myneni (1):
      powerpc/powernv/vas: Assign real address to rx_fifo in vas_rx_win_attr

Hari Bathini (2):
      powerpc/fadump: Fix fadump to work with a different endian capture kernel
      powerpc/fadump: fix PT_LOAD segment for boot memory area

Hari Chandrakanthan (1):
      ath11k: disable spectral scan during spectral deinit

Harini Katakam (1):
      net: macb: Fix PTP one step sync support

He Ying (1):
      powerpc/kasan: Silence KASAN warnings in __get_wchan()

Heiko Carstens (1):
      s390/preempt: disable __preempt_count_add() optimization for PROFILE_ALL_BRANCHES

Heiner Kallweit (1):
      ASoC: sh: rz-ssi: Check return value of pm_runtime_resume_and_get()

Heinrich Schuchardt (1):
      riscv: read-only pages should not be writable

Helge Deller (3):
      parisc/stifb: Implement fb_is_primary_device()
      parisc/stifb: Keep track of hardware path of graphics card
      scsi: mpt3sas: Fix out-of-bounds compiler warning

Heming Zhao (1):
      md/bitmap: don't set sb values if can't pass sanity check

Hoang Le (1):
      tipc: check attribute length for bearer name

Howard Chiu (1):
      ARM: dts: aspeed: ast2600-evb: Enable RX delay for MAC0/MAC1

Huang Guobin (1):
      tty: Fix a possible resource leak in icom_probe

Hui Wang (1):
      ASoC: nau8822: Add operation for internal PLL off and on

Hyunchul Lee (1):
      ksmbd: fix outstanding credits related bugs

Ian Abbott (2):
      spi: cadence-quadspi: fix Direct Access Mode disable for SoCFPGA
      comedi: vmk80xx: fix expression for tx buffer size

Ilpo Järvinen (9):
      serial: 8250_fintek: Check SER_RS485_RTS_* only with RS485
      serial: digicolor-usart: Don't allow CS5-6
      serial: rda-uart: Don't allow CS5-6
      serial: txx9: Don't allow CS5-6
      serial: sh-sci: Don't allow CS5-6
      serial: sifive: Sanitize CSIZE and c_iflag
      serial: st-asc: Sanitize CSIZE and correct PARENB for CS7
      serial: stm32-usart: Correct CSIZE, bits, and parity
      serial: 8250: Store to lsr_save_flags after lsr read

Ilya Maximets (1):
      net: openvswitch: fix misuse of the cached connection on tuple changes

IotaHydrae (1):
      pinctrl: sunxi: fix f1c100s uart2 function

Jacopo Mondi (1):
      media: i2c: max9286: Use "maxim,gpio-poc" property

Jaegeuk Kim (1):
      f2fs: don't need inode lock for system hidden quota

Jagan Teki (1):
      drm/panel: panel-simple: Fix proper bpc for AM-1280800N3TZQW-T00H

Jakob Koschel (2):
      f2fs: fix dereference of stale list iterator after loop body
      staging: greybus: codecs: fix type confusion of list iterator variable

Jakub Kicinski (2):
      eth: tg3: silence the GCC 12 array-bounds warning
      net: stmmac: fix out-of-bounds access in a selftest

James Clark (1):
      perf tools: Use Python devtools for version autodetection rather than runtime

James Smart (8):
      scsi: lpfc: Move cfg_log_verbose check before calling lpfc_dmp_dbg()
      scsi: lpfc: Fix SCSI I/O completion and abort handler deadlock
      scsi: lpfc: Fix call trace observed during I/O with CMF enabled
      scsi: lpfc: Fix resource leak in lpfc_sli4_send_seq_to_ulp()
      scsi: lpfc: Alter FPIN stat accounting logic
      scsi: lpfc: Resolve NULL ptr dereference after an ELS LOGO is aborted
      scsi: lpfc: Fix port stuck in bypassed state after LIP in PT2PT topology
      scsi: lpfc: Allow reduced polling rate for nvme_admin_async_event cmd completion

Jan Kara (15):
      bfq: Relax waker detection for shared queues
      bfq: Allow current waker to defend against a tentative one
      bfq: Avoid false marking of bic as stably merged
      bfq: Avoid merging queues with different parents
      bfq: Split shared queues on move between cgroups
      bfq: Update cgroup information before merging bio
      bfq: Drop pointless unlock-lock pair
      bfq: Remove pointless bfq_init_rq() calls
      bfq: Track whether bfq_group is still online
      bfq: Get rid of __bio_blkcg() usage
      bfq: Make sure bfqg for which we are queueing requests is online
      ext4: verify dir block before splitting it
      ext4: avoid cycles in directory h-tree
      block: fix bio_clone_blkg_association() to associate with proper blkcg_gq
      init: Initialize noop_backing_dev_info early

Jan Kiszka (1):
      efi: Add missing prototype for efi_capsule_setup_info

Jani Nikula (2):
      drm/edid: fix invalid EDID extension block filtering
      drm/i915/dsi: fix VBT send packet port selection for ICL+

Jann Horn (1):
      s390/crypto: fix scatterwalk_unmap() callers in AES-GCM

Janusz Krzysztofik (1):
      ARM: OMAP1: clock: Fix UART rate reporting algorithm

Jason A. Donenfeld (7):
      openrisc: start CPU timer early in boot
      Revert "random: use static branch for crng_ready()"
      random: avoid checking crng_ready() twice in random_init()
      random: mark bootloader randomness code as __init
      random: account for arch randomness in bits
      random: credit cpu and bootloader seeds by default
      crypto: memneq - move into lib/

Jason Wang (1):
      vdpa: ifcvf: set pci driver data in probe

Javier Martinez Canillas (1):
      video: fbdev: vesafb: Fix a use-after-free due early fb_info cleanup

Jchao Sun (1):
      writeback: Fix inode->i_io_list not be protected by inode->i_lock error

Jean-Philippe Brucker (1):
      iommu/arm-smmu-v3-sva: Fix mm use-after-free

Jeff Xie (1):
      tracing: Make tp_printk work on syscall tracepoints

Jens Axboe (1):
      block: make bioset_exit() fully resilient against being called twice

Jeremy Soller (1):
      ALSA: hda/realtek: Add quirk for HP Dev One

Jerome Marchand (1):
      samples: bpf: Don't fail for a missing VMLINUX_BTF when VMLINUX_H is provided

Jessica Zhang (2):
      drm/msm/mdp5: Return error code in mdp5_pipe_release when deadlock is detected
      drm/msm/mdp5: Return error code in mdp5_mixer_release when deadlock is detected

Jia-Ju Bai (1):
      md: bcache: check the return value of kzalloc() in detached_dev_do_request()

Jia-Wei Chang (1):
      cpufreq: mediatek: Use module_init and add module_exit

Jian Shen (2):
      net: hns3: split function hclge_update_port_base_vlan_cfg()
      net: hns3: don't push link state to VF if unalive

Jiantao Zhang (1):
      PCI: dwc: Fix setting error return on MSI DMA mapping failure

Jiasheng Jiang (4):
      drm: mali-dp: potential dereference of null pointer
      lkdtm/bugs: Check for the NULL pointer after calling kmalloc
      staging: r8188eu: add check for kzalloc
      i2c: npcm7xx: Add check for platform_driver_register

Jing Leng (1):
      usb: cdnsp: Fixed setting last_trb incorrectly

Jiri Olsa (1):
      perf build: Fix btf__load_from_kernel_by_id() feature check

Jiri Slaby (1):
      serial: pch: don't overwrite xmit->buf[0] by x_char

Joel Selvaraj (1):
      arm64: dts: qcom: sdm845-xiaomi-beryllium: fix typo in panel's vddio-supply property

Joel Stanley (1):
      net: ftgmac100: Disable hardware checksum on AST2600

Joerg Roedel (1):
      iommu/amd: Increase timeout waiting for GA log enablement

Johan Hovold (7):
      USB: serial: pl2303: fix type detection for odd device
      PCI: qcom: Fix runtime PM imbalance on probe errors
      PCI: qcom: Fix unbalanced PHY init on probe errors
      phy: qcom-qmp: fix struct clk leak on probe errors
      phy: qcom-qmp: fix reset-controller leak on probe errors
      phy: qcom-qmp: fix pipe-clock imbalance on power-on failure
      PCI: qcom: Fix pipe clock imbalance

Johannes Berg (6):
      nl80211: show SSID for P2P_GO interfaces
      nl80211: don't hold RTNL in color change request
      wifi: mac80211: fix use-after-free in chanctx code
      um: Use asm-generic/dma-mapping.h
      um: chan_user: Fix winch_tramp() return value
      um: line: Use separate IRQs per line

John Ogness (5):
      printk: use atomic updates for klogd work
      printk: add missing memory barrier to wake_up_klogd()
      printk: wake waiters for safe and NMI contexts
      serial: meson: acquire port->lock in startup()
      serial: msm_serial: disable interrupts in __msm_console_write()

Jon Lin (2):
      spi: rockchip: Stop spi slave dma receiver when cs inactive
      spi: rockchip: Preset cs-high and clk polarity in setup progress

Jonas Karlman (1):
      media: rkvdec: h264: Fix bit depth wrap in pps packet

Jonathan Bakker (2):
      ARM: dts: s5pv210: Correct interrupt name for bluetooth in Aries
      ARM: dts: s5pv210: Remove spi-cs-high on panel in Aries

Jonathan Teh (1):
      HID: hid-led: fix maximum brightness for Dream Cheeky

Josh Poimboeuf (4):
      x86/speculation: Add missing prototype for unpriv_ebpf_notify()
      scripts/faddr2line: Fix overlapping text section failures
      x86/speculation/mmio: Print SMT warning
      faddr2line: Fix overlapping text section failures, the sequel

Julian Schroeder (1):
      nfsd: destroy percpu stats counters after reply cache shutdown

Jun Miao (1):
      tracing: Fix sleeping function called from invalid context on RT kernel

Junxiao Bi via Ocfs2-devel (1):
      ocfs2: dlmfs: fix error handling of user_dlm_destroy_lock

Justin M. Forbes (1):
      lib/crypto: add prompts back to crypto libraries

Kailang Yang (1):
      ALSA: hda/realtek - Add new type for ALC245

Kajol Jain (2):
      powerpc/perf: Fix the threshold compare group constraint for power10
      powerpc/perf: Fix the threshold compare group constraint for power9

Kan Liang (1):
      perf/x86/intel: Fix event constraints for ICL

Kant Fan (1):
      thermal: devfreq_cooling: use local ops instead of global ops

Kathiravan T (1):
      arm64: dts: qcom: ipq8074: fix the sleep clock frequency

Kees Cook (2):
      lkdtm/usercopy: Expand size of "out of frame" object
      nodemask: Fix return values to be unsigned

Keita Suzuki (2):
      drm/amd/pm: fix double free in si_parse_power_table()
      tracing: Fix potential double free in create_var_ref()

Keith Busch (1):
      nvme: set dma alignment to dword

Kinglong Mee (1):
      xprtrdma: treat all calls not a bcall when bc_serv is NULL

Kirill A. Shutemov (1):
      ACPICA: Avoid cache flush inside virtual machines

Kishon Vijay Abraham I (1):
      usb: core: hcd: Add support for deferring roothub registration

Kiwoong Kim (1):
      scsi: ufs: core: Exclude UECxx from SFR dump list

Konrad Dybcio (3):
      arm64: dts: qcom: msm8994: Fix the cont_splash_mem address
      arm64: dts: qcom: msm8994: Fix BLSP[12]_DMA channels count
      regulator: qcom_smd: Fix up PM8950 regulator configuration

Konstantin Komarov (7):
      fs/ntfs3: Update valid size if -EIOCBQUEUED
      fs/ntfs3: Fix fiemap + fix shrink file size (to remove preallocated space)
      fs/ntfs3: Keep preallocated only if option prealloc enabled
      fs/ntfs3: Check new size for limits
      fs/ntfs3: In function ntfs_set_acl_ex do not change inode->i_mode if called from function ntfs_init_acl
      fs/ntfs3: Update i_ctime when xattr is added
      fs/ntfs3: Restore ntfs_xattr_get_acl and ntfs_xattr_set_acl functions

Kristen Carlson Accardi (1):
      x86/sgx: Set active memcg prior to shmem allocation

Krzysztof Kozlowski (10):
      ARM: dts: ox820: align interrupt controller node name with dtschema
      ARM: dts: socfpga: align interrupt controller node name with dtschema
      ARM: dts: s5pv210: align DMA channels with dtschema
      ARM: dts: exynos: add atmel,24c128 fallback to Samsung EEPROM
      irqchip/aspeed-i2c-ic: Fix irq_of_parse_and_map() return value
      irqchip/aspeed-scu-ic: Fix irq_of_parse_and_map() return value
      pinctrl: mvebu: Fix irq_of_parse_and_map() return value
      rpmsg: qcom_smd: Fix irq_of_parse_and_map() return value
      rpmsg: qcom_smd: Fix returning 0 if irq_of_parse_and_map() fails
      clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map() return value

Kuan-Ying Lee (1):
      scripts/gdb: change kernel config dumping method

Kuldeep Singh (1):
      spi: qcom-qspi: Add minItems to interconnect-names

Kumar Kartikeya Dwivedi (2):
      bpf: Reject writes for PTR_TO_MAP_KEY in check_helper_mem_access
      bpf: Check PTR_TO_MEM | MEM_RDONLY in check_helper_mem_access

Kuninori Morimoto (5):
      ASoC: rsnd: care default case on rsnd_ssiu_busif_err_status_clear()
      ASoC: rsnd: care return value from rsnd_node_fixed_index()
      ASoC: fsl: Use dev_err_probe() helper
      ASoC: samsung: Use dev_err_probe() helper
      i2c: rcar: fix PM ref counts in probe error paths

Kuniyuki Iwashima (3):
      pipe: make poll_usage boolean and annotate its access
      list: fix a data-race around ep->rdllist
      af_unix: Fix a data-race in unix_dgram_peer_wake_me().

KuoHsiang Chou (1):
      drm/ast: Create threshold values for AST2600

Kuogee Hsieh (5):
      drm/msm/dpu: adjust display_v_end for eDP and DP
      drm/msm/dp: stop event kernel thread when DP unbind
      drm/msm/dp: reset DP controller before transmit phy test pattern
      drm/msm/dp: do not stop transmitting phy test pattern during DP phy compliance test
      drm/msm/dp: fix event thread stuck in wait_event after kthread_stop()

Kuppuswamy Sathyanarayanan (1):
      PCI/AER: Clear MULTI_ERR_COR/UNCOR_RCV bits

Kwanghoon Son (1):
      media: exynos4-is: Fix compile warning

Lad Prabhakar (4):
      Input: gpio-keys - cancel delayed work only in case of GPIO
      ASoC: sh: rz-ssi: Propagate error codes returned from platform_get_irq_byname()
      ASoC: sh: rz-ssi: Release the DMA channels in rz_ssi_probe() error path
      rtc: ftrtc010: Use platform_get_irq() to get the interrupt

Lai Jiangshan (1):
      x86/sev: Annotate stack change in the #VC handler

Lang Yu (1):
      drm/amdkfd: add pinned BOs to kfd_bo_list

Larry Finger (1):
      staging: r8188eu: Fix warning of array overflow in ioctl_linux.c

Laurent Dufour (1):
      powerpc/rtas: Keep MSR[RI] set when calling RTAS

Laurent Vivier (1):
      tty: goldfish: Introduce gf_ioread32()/gf_iowrite32()

Laurentiu Palcu (2):
      media: i2c: max9286: fix kernel oops when removing module
      media: i2c: rdacm2x: properly set subdev entity function

Len Brown (1):
      tools/power turbostat: fix ICX DRAM power numbers

Leo Yan (2):
      perf c2c: Use stdio interface if slang is not supported
      perf c2c: Fix sorting in percent_rmt_hitm_cmp()

Leon Romanovsky (1):
      net/mlx5: Don't use already freed action pointer

Li Jun (1):
      extcon: ptn5150: Add queue work sync before driver release

Liao Chang (1):
      RISC-V: use memcpy for kexec_file mode

Lijo Lazar (1):
      drm/amd/pm: Fix missing thermal throttler status

Lin Ma (4):
      nfc: pn533: Fix buggy cleanup order
      ASoC: rt5645: Fix errorenous cleanup order
      NFC: NULL out the dev->rfkill to prevent UAF
      USB: storage: karma: fix rio_karma_init return

Linus Torvalds (5):
      drm: fix EDID struct for old ARM OABI format
      drm: imx: fix compiler warning with gcc-12
      iov_iter: fix build issue due to possible type mis-match
      gcc-12: disable '-Wdangling-pointer' warning for now
      mellanox: mlx5: avoid uninitialized variable warning with gcc-12

Linus Walleij (1):
      usb: isp1760: Fix out-of-bounds array access

Linyu Yuan (2):
      usb: gadget: f_fs: change ep->status safe in ffs_epfile_io()
      usb: gadget: f_fs: change ep->ep safe in ffs_epfile_io()

Liu Jian (1):
      bpf: Enlarge offset check value to INT_MAX in bpf_skb_{load,store}_bytes

Liu Xinpeng (1):
      watchdog: wdat_wdt: Stop watchdog when rebooting the system

Liu Zixian (1):
      drm/virtio: fix NULL pointer dereference in virtio_gpu_conn_get_modes

Liviu Dudau (1):
      drm/komeda: return early if drm_universal_plane_init() fails.

Luca Ceresoli (1):
      spi: rockchip: fix missing error on unsupported SPI_CS_HIGH

Luca Weiss (1):
      media: venus: hfi: avoid null dereference in deinit

Lucas Stach (2):
      drm/bridge: adv7511: clean up CEC adapter when probe fails
      drm/etnaviv: check for reaped mapping in etnaviv_iommu_unmap_gem

Lucas Tanure (1):
      i2c: cadence: Increase timeout per message if necessary

Lukas Wunner (1):
      usbnet: Run unregister_netdev() before unbind() again

Lv Ruyi (9):
      scsi: megaraid: Fix error check return value of register_chrdev()
      drm: msm: fix error check return value of irq_of_parse_and_map()
      powerpc/xics: fix refcount leak in icp_opal_init()
      powerpc/powernv: fix missing of_node_put in uv_init()
      ixp4xx_eth: fix error check return value of platform_get_irq()
      drm/msm/dp: fix error check return value of irq_of_parse_and_map()
      drm/msm/hdmi: fix error check return value of irq_of_parse_and_map()
      mfd: ipaq-micro: Fix error check return value of platform_get_irq()
      drm/msm/dpu: fix error check return value of irq_of_parse_and_map()

Lyude Paul (1):
      drm/nouveau/subdev/bus: Ratelimit logging for fault errors

Maciej Fijalkowski (2):
      xsk: Fix handling of invalid descriptors in XSK TX batching API
      xsk: Fix possible crash when multiple sockets are created

Maciej W. Rozycki (4):
      x86/PCI: Fix ALi M1487 (IBC) PIRQ router link value interpretation
      MIPS: IP27: Remove incorrect `cpu_has_fpu' override
      MIPS: IP30: Remove incorrect `cpu_has_fpu' override
      serial: sifive: Report actual baud base rather than fixed 115200

Magnus Karlsson (1):
      i40e: xsk: Move tmp desc array from driver to pool

Manivannan Sadhasivam (1):
      scsi: ufs: qcom: Add a readl() to make sure ref_clk gets enabled

Mao Jinlong (1):
      coresight: core: Fix coresight device probe failure issue

Maor Dickman (1):
      net/mlx5e: TC NIC mode, fix tc chains miss table

Marc Kleine-Budde (1):
      can: xilinx_can: mark bit timing constants as const

Marc Zyngier (1):
      KVM: arm64: Don't read a HW interrupt pending state in user context

Marco Elver (1):
      signal: Deliver SIGTRAP on perf event asynchronously if blocked

Marek Behún (1):
      net: dsa: mv88e6xxx: use BMSR_ANEGCOMPLETE bit for filling an_complete

Marek Maślanka (1):
      HID: multitouch: Add support for Google Whiskers Touchpad

Marek Szyprowski (1):
      usb: dwc2: gadget: don't reset gadget's driver->bus

Marek Vasut (5):
      drm: bridge: icn6211: Fix register layout
      drm: bridge: icn6211: Fix HFP_HSW_HBP_HI and HFP_MIN handling
      drm/panel: simple: Add missing bus flags for Innolux G070Y2-L01
      ARM: dts: stm32: Fix PHY post-reset delay on Avenger96
      drm/bridge: ti-sn65dsi83: Handle dsi_lanes == 0 as invalid

Mario Limonciello (3):
      ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default
      PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3
      iommu/amd: Enable swiotlb in all cases

Marios Levogiannis (1):
      ALSA: hda/realtek - Fix microphone noise on ASUS TUF B550M-PLUS

Marius Hoch (1):
      Input: soc_button_array - also add Lenovo Yoga Tablet2 1051F to dmi_use_low_level_irq

Mariusz Tkaczyk (1):
      raid5: introduce MD_BROKEN

Mark Bloch (3):
      net/mlx5: fs, delete the FTE when there are no rules attached to it
      net/mlx5: Lag, filter non compatible devices
      net/mlx5: fs, fail conflicting actions

Mark Brown (4):
      ASoC: dapm: Don't fold register value changes into notifications
      ASoC: rt5514: Fix event generation for "DSP Voice Wake Up" control
      ASoC: es8328: Fix event generation for deemphasis control
      ASoC: wm_adsp: Fix event generation for wm_adsp_fw_put()

Mark Rutland (3):
      arm64: stackleak: fix current_top_of_stack()
      arm64: ftrace: fix branch range checks
      arm64: ftrace: consistently handle PLTs.

Mark-PK Tsai (1):
      tracing: Avoid adding tracer option before update_tracer_options

Martin Faltesek (3):
      nfc: st21nfca: fix incorrect validating logic in EVT_TRANSACTION
      nfc: st21nfca: fix memory leaks in EVT_TRANSACTION handling
      nfc: st21nfca: fix incorrect sizing calculations in EVT_TRANSACTION

Martin Habets (1):
      sfc: fix considering that all channels have TX queues

Masahiro Yamada (8):
      xen: unexport __init-annotated xen_xlate_map_ballooned_pages()
      net: mdio: unexport __init-annotated mdio_bus_init()
      net: xfrm: unexport __init-annotated xfrm4_protocol_init()
      net: ipv6: unexport __init-annotated seg6_hmac_init()
      modpost: fix undefined behavior of is_arm_mapping_symbol()
      clocksource: hyper-v: unexport __init-annotated hv_init_clocksource()
      certs/blacklist_hashes.c: fix const confusion in certs blacklist
      powerpc/book3e: get rid of #include <generated/compile.h>

Masami Hiramatsu (1):
      bootconfig: Make the bootconfig.o as a normal object file

Mathias Nyman (2):
      xhci: Allow host runtime PM as default for Intel Alder Lake N xHCI
      Input: bcm5974 - set missing URB_NO_TRANSFER_DMA_MAP urb flag

Matthew Wilcox (Oracle) (2):
      alpha: fix alloc_zeroed_user_highpage_movable()
      quota: Prevent memory allocation recursion while holding dq_lock

Matthias Schiffer (1):
      arm64: dts: ti: k3-am64-mcu: remove incorrect UART base clock rates

Matthieu Baerts (1):
      x86/pm: Fix false positive kmemleak report in msr_build_context()

Max Filippov (1):
      irqchip: irq-xtensa-mx: fix initial IRQ affinity

Max Krummenacher (1):
      ARM: dts: imx6dl-colibri: Fix I2C pinmuxing

Maxim Mikityanskiy (1):
      net/mlx5e: Update netdev features after changing XDP state

Maxime Ripard (4):
      drm/vc4: hvs: Fix frame count register readout
      drm/vc4: hvs: Reset muxes at probe time
      drm/vc4: txp: Don't set TXP_VSTART_AT_EOF
      drm/vc4: txp: Force alpha to be 0xff if it's disabled

Mel Gorman (1):
      mm/page_alloc: always attempt to allocate at least one page during bulk allocation

Menglong Dong (1):
      bpf: Fix probe read error in ___bpf_prog_run()

Miaohe Lin (2):
      drivers/base/node.c: fix compaction sysfs file leak
      mm/memremap: fix missing call to untrack_pfn() in pagemap_range()

Miaoqian Lin (47):
      ASoC: mediatek: Fix error handling in mt8173_max98090_dev_probe
      ASoC: mediatek: Fix missing of_node_put in mt2701_wm8960_machine_probe
      spi: spi-ti-qspi: Fix return value handling of wait_for_completion_timeout
      HID: elan: Fix potential double free in elan_input_configured
      drm/bridge: Fix error handling in analogix_dp_probe
      ASoC: fsl: Fix refcount leak in imx_sgtl5000_probe
      ASoC: imx-hdmi: Fix refcount leak in imx_hdmi_probe
      ASoC: mxs-saif: Fix refcount leak in mxs_saif_probe
      regulator: pfuze100: Fix refcount leak in pfuze_parse_regulators_dt
      ASoC: samsung: Fix refcount leak in aries_audio_probe
      media: exynos4-is: Fix PM disable depth imbalance in fimc_is_probe
      media: st-delta: Fix PM disable depth imbalance in delta_probe
      media: atmel: atmel-isc: Fix PM disable depth imbalance in atmel_isc_probe
      media: exynos4-is: Change clk_disable to clk_disable_unprepare
      ASoC: ti: j721e-evm: Fix refcount leak in j721e_soc_probe_*
      regulator: scmi: Fix refcount leak in scmi_regulator_probe
      drm/msm/a6xx: Fix refcount leak in a6xx_gpu_init
      thermal/drivers/imx_sc_thermal: Fix refcount leak in imx_sc_thermal_probe
      soc: qcom: smp2p: Fix missing of_node_put() in smp2p_parse_ipc
      soc: qcom: smsm: Fix missing of_node_put() in smsm_parse_ipc
      PCI: mediatek: Fix refcount leak in mtk_pcie_subsys_powerup()
      Input: sparcspkr - fix refcount leak in bbc_beep_probe
      powerpc/xive: Fix refcount leak in xive_spapr_init
      powerpc/fsl_rio: Fix refcount leak in fsl_rio_setup
      video: fbdev: clcdfb: Fix refcount leak in clcdfb_of_vram_setup
      tty: serial: owl: Fix missing clk_disable_unprepare() in owl_uart_probe
      serial: 8250_aspeed_vuart: Fix potential NULL dereference in aspeed_vuart_probe
      usb: musb: Fix missing of_node_put() in omap2430_probe
      iio: adc: stmpe-adc: Fix wait_for_completion_timeout return value check
      iio: proximity: vl53l0x: Fix return value check of wait_for_completion_timeout
      soc: rockchip: Fix refcount leak in rockchip_grf_init
      rtc: ftrtc010: Fix error handling in ftrtc010_rtc_probe
      firmware: dmi-sysfs: Fix memory leak in dmi_sysfs_register_handle
      watchdog: rti-wdt: Fix pm_runtime_get_sync() error checking
      watchdog: ts4800_wdt: Fix refcount leak in ts4800_wdt_probe
      net: ethernet: ti: am65-cpsw-nuss: Fix some refcount leaks
      net: dsa: mv88e6xxx: Fix refcount leak in mv88e6xxx_mdios_register
      ata: pata_octeon_cf: Fix refcount leak in octeon_cf_probe
      net: dsa: lantiq_gswip: Fix refcount leak in gswip_gphy_fw_list
      net: altera: Fix refcount leak in altera_tse_mdio_create
      misc: atmel-ssc: Fix IRQ check in ssc_probe
      irqchip/gic/realview: Fix refcount leak in realview_gic_of_init
      irqchip/gic-v3: Fix error handling in gic_populate_ppi_partitions
      irqchip/gic-v3: Fix refcount leak in gic_populate_ppi_partitions
      irqchip/realtek-rtl: Fix refcount leak in map_interrupts
      usb: dwc2: Fix memory leak in dwc2_hcd_init
      usb: gadget: lpc32xx_udc: Fix refcount leak in lpc32xx_udc_probe

Michael Ellerman (4):
      powerpc/64: Only WARN if __pa()/__va() called with bad addresses
      powerpc/kasan: Force thread size increase with KASAN
      powerpc: Don't select HAVE_IRQ_EXIT_ON_IRQ_STACK
      powerpc/32: Fix overread/overwrite of thread_struct via ptrace

Michael Niewöhner (1):
      platform/x86: intel-hid: fix _DSM function index handling

Michael Rodin (1):
      media: vsp1: Fix offset calculation for plane cropping

Michael Walle (1):
      i2c: at91: use dma safe buffers

Michal Kubecek (1):
      Revert "net: af_key: add check for pfkey_broadcast in function pfkey_process"

Mickaël Salaün (21):
      landlock: Add clang-format exceptions
      landlock: Format with clang-format
      selftests/landlock: Add clang-format exceptions
      selftests/landlock: Normalize array assignment
      selftests/landlock: Format with clang-format
      samples/landlock: Add clang-format exceptions
      samples/landlock: Format with clang-format
      landlock: Fix landlock_add_rule(2) documentation
      selftests/landlock: Make tests build with old libc
      selftests/landlock: Extend tests for minimal valid attribute size
      selftests/landlock: Add tests for unknown access rights
      selftests/landlock: Extend access right tests to directories
      selftests/landlock: Fully test file rename with "remove" access
      selftests/landlock: Add tests for O_PATH
      landlock: Change landlock_add_rule(2) argument check ordering
      landlock: Change landlock_restrict_self(2) check ordering
      selftests/landlock: Test landlock_create_ruleset(2) argument check ordering
      landlock: Define access_mask_t to enforce a consistent access mask size
      landlock: Reduce the maximum number of layers to 16
      landlock: Create find_rule() from unmask_layers()
      landlock: Fix same-layer rule unions

Mika Westerberg (2):
      i2c: ismt: Provide a DMA buffer for Interrupt Cause Logging
      thunderbolt: Use different lane for second DisplayPort tunnel

Mike Kravetz (1):
      hugetlb: fix huge_pmd_unshare address update

Mike Tipton (1):
      interconnect: qcom: icc-rpmh: Add BCMs to commit list in pre_aggregate

Mike Travis (1):
      x86/platform/uv: Update TSC sync state for UV5

Mikulas Patocka (5):
      dm crypt: make printing of the key constant-time
      dm stats: add cond_resched when looping over entries
      dma-debug: change allocation mode from GFP_NOWAIT to GFP_ATIOMIC
      objtool: Fix objtool regression on x32 systems
      dm mirror log: round up region bitmap size to BITS_PER_LONG

Miles Chen (2):
      drm/mediatek: Fix mtk_cec_mask()
      iommu/mediatek: Fix NULL pointer dereference when printing dev_name

Mina Almasry (1):
      hugetlbfs: fix hugetlbfs_statfs() locking

Ming Lei (1):
      blk-mq: don't touch ->tagset in blk_mq_get_sq_hctx

Minghao Chi (1):
      scsi: ufs: Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()

Miquel Raynal (1):
      iio: st_sensors: Add a local lock for protecting odr

Monish Kumar R (1):
      USB: new quirk for Dell Gen 2 devices

Muchun Song (2):
      dax: fix cache flush on PMD-mapped pages
      tcp: use alloc_large_system_hash() to allocate table_perturb

Murilo Opsfelder Araujo (1):
      virtio-pci: Remove wrong address verification in vp_del_vqs()

Namjae Jeon (1):
      fs/ntfs3: Fix invalid free in log_replay

Nathan Chancellor (3):
      riscv: Move alternative length validation into subsection
      drm/i915: Fix CFI violation with show_dynamic_id()
      i2c: at91: Initialize dma_buf in at91_twi_xfer()

Naveen N. Rao (1):
      kexec_file: drop weak attribute from arch_kexec_apply_relocations[_add]

Nicholas Piggin (1):
      KVM: PPC: Book3S HV Nested: L2 LPCR should inherit L1 LPES setting

Nico Boehr (1):
      s390/perf: obtain sie_block from the right address

Nicolai Stange (4):
      crypto: drbg - prepare for more fine-grained tracking of seeding state
      crypto: drbg - track whether DRBG was seeded with !rng_is_initialized()
      crypto: drbg - move dynamic ->reseed_threshold adjustments to __drbg_seed()
      crypto: drbg - make reseeding from get_random_bytes() synchronous

Nicolas Belin (1):
      drm: bridge: it66121: Fix the register page length

Nicolas Dufresne (4):
      media: hantro: Stop using H.264 parameter pic_num
      media: rkvdec: h264: Fix dpb_valid implementation
      media: coda: Fix reported H264 profile
      media: coda: Add more H264 levels for CODA960

Nicolas Frattaroli (1):
      ASoC: rk3328: fix disabling mclk on pclk probe failure

Niels Dossche (7):
      mwifiex: add mutex lock for call in mwifiex_dfs_chan_sw_work_queue
      ipv6: fix locking issues with loops over idev->addr_list
      IB/rdmavt: add missing locks in rvt_ruc_loopback
      ath11k: acquire ab->base_lock in unassign when finding the peer by addr
      Bluetooth: use hdev lock in activate_scan for hci_is_adv_monitoring
      Bluetooth: use hdev lock for accept_list and reject_list in conn req
      usb: usbip: add missing device lock on tweak configuration cmd

Nikita Yushchenko (1):
      drm/bridge_connector: enable HPD by default if supported

Niklas Cassel (1):
      binfmt_flat: do not stop relocating GOT entries prematurely on riscv

Niklas Söderlund (1):
      media: i2c: max9286: Use dev_err_probe() helper

Nikolay Borisov (1):
      selftests/bpf: Fix vfs_link kprobe definition

Noralf Trønnes (1):
      dt-bindings: display: sitronix, st7735r: Fix backlight in example

Nuno Sá (1):
      of: overlay: do not break notify on NOTIFY_{OK|STOP}

Nícolas F. R. A. Prado (2):
      regulator: mt6315: Enforce regulator-compatible, not name
      drm/mediatek: dpi: Use mt8183 output formats for mt8192

OGAWA Hirofumi (1):
      fat: add ratelimit to fat*_ent_bread()

Olga Kornievskaia (1):
      NFSv4.1 mark qualified async operations as MOVEABLE tasks

Olivier Matz (2):
      ixgbe: fix bcast packets Rx on VF after promisc removal
      ixgbe: fix unexpected VLAN Rx in promisc mode on VF

Pablo Neira Ayuso (10):
      netfilter: nf_tables: disallow non-stateful expression in sets earlier
      netfilter: nf_tables: sanitize nft_set_desc_concat_parse()
      netfilter: nf_tables: hold mutex on netns pre_exit path
      netfilter: nf_tables: double hook unregistration in netns path
      netfilter: nf_tables: use kfree_rcu(ptr, rcu) to release hooks in clean_net path
      netfilter: nf_tables: delete flowtable hooks via transaction list
      netfilter: nf_tables: always initialize flowtable hook list in transaction
      netfilter: nf_tables: release new hooks on unsupported flowtable flags
      netfilter: nf_tables: memleak flow rule from commit path
      netfilter: nf_tables: bail out early if hardware offload is not supported

Padmanabha Srinivasaiah (1):
      rcu-tasks: Fix race in schedule and flush work

Pali Rohár (1):
      irqchip/armada-370-xp: Do not touch Performance Counter Overflow on A375, A38x, A39x

Paolo Abeni (1):
      mptcp: reset the packet scheduler on PRIO change

Paolo Bonzini (1):
      x86, kvm: use correct GFP flags for preemption disabled

Pascal Hambourg (1):
      md/raid0: Ignore RAID0 layout if the second zone has only one device

Patrice Chotard (1):
      spi: stm32-qspi: Fix wait_cmd timeout in APM mode

Paul Blakey (1):
      net/mlx5: CT: Fix header-rewrite re-use for tupels

Paul E. McKenney (2):
      rcu: Make TASKS_RUDE_RCU select IRQ_WORK
      scftorture: Fix distribution of short handler delays

Paulo Alcantara (1):
      cifs: fix reconnect on smb3 mount types

Pavel Begunkov (2):
      io_uring: fix races with file table unregister
      io_uring: fix races with buffer table unregister

Pavel Skripkin (1):
      media: pvrusb2: fix array-index-out-of-bounds in pvr2_i2c_core_init

Pawan Gupta (10):
      Documentation: Add documentation for Processor MMIO Stale Data
      x86/speculation/mmio: Enumerate Processor MMIO Stale Data bug
      x86/speculation: Add a common function for MD_CLEAR mitigation update
      x86/speculation/mmio: Add mitigation for Processor MMIO Stale Data
      x86/bugs: Group MDS, TAA & Processor MMIO Stale Data mitigations
      x86/speculation/mmio: Enable CPU Fill buffer clearing on idle
      x86/speculation/mmio: Add sysfs reporting for Processor MMIO Stale Data
      x86/speculation/srbds: Update SRBDS mitigation selection
      x86/speculation/mmio: Reuse SRBDS mitigation for SBDS
      KVM: x86/speculation: Disable Fill buffer clear within guests

Peng Fan (2):
      remoteproc: imx_rproc: Ignore create mem entry for resource table
      clk: imx8mp: fix usb_root_clk parent

Peng Wu (3):
      ARM: versatile: Add missing of_node_put in dcscb_init
      ARM: hisi: Add missing of_node_put after of_find_compatible_node
      powerpc/iommu: Add missing of_node_put in iommu_init_early_dart

Peter Seiderer (1):
      mac80211: minstrel_ht: fix where rate stats are stored (fixes debugfs output)

Peter Zijlstra (4):
      objtool: Fix symbol creation
      x86/cpu: Elide KCSAN for cpu_has() and friends
      jump_label,noinstr: Avoid instrumentation for JUMP_LABEL=n builds
      sched: Fix balance_push() vs __sched_setscheduler()

Petr Machata (3):
      mlxsw: spectrum_dcb: Do not warn about priority changes
      mlxsw: Treat LLDP packets as control
      mlxsw: spectrum_cnt: Reorder counter pools

Phil Auld (1):
      kselftest/cgroup: fix test_stress.sh to use OUTPUT dir

Phil Elwell (3):
      ARM: dts: bcm2835-rpi-zero-w: Fix GPIO line name for Wifi/BT
      ARM: dts: bcm2837-rpi-cm3-io3: Fix GPIO line names for SMPS I2C
      ARM: dts: bcm2837-rpi-3-b-plus: Fix GPIO line name of power LED

Philip Yang (1):
      drm/amdkfd: Use mmget_not_zero in MMU notifier

Philipp Zabel (1):
      media: coda: limit frame interval enumeration to supported encoder frame sizes

Phillip Potter (1):
      staging: r8188eu: fix rtw_alloc_hwxmits error detection for now

Pierre Gondois (1):
      ACPI: CPPC: Assume no transition latency if no PCCT

Pierre-Louis Bossart (3):
      ASoC: max98357a: remove dependency on GPIOLIB
      ASoC: rt1015p: remove dependency on GPIOLIB
      soundwire: intel: prevent pm_runtime resume prior to system suspend

Piotr Chmura (1):
      platform/x86: gigabyte-wmi: Add Z690M AORUS ELITE AX DDR4 support

Piyush Malgujar (1):
      drivers: i2c: thunderx: Allow driver to work with ACPI defined TWSI controllers

Po-Hao Huang (1):
      rtw88: 8821c: fix debugfs rssi value

Qi Zheng (1):
      tty: fix deadlock caused by calling printk() under tty_port->lock

QintaoShen (2):
      soc: ti: ti_sci_pm_domains: Check for null return of devm_kcalloc
      soc: bcm: Check for NULL return of devm_kzalloc()

Qu Wenruo (4):
      btrfs: add "0x" prefix for unsupported optional features
      btrfs: return correct error number for __extent_writepage_io()
      btrfs: repair super block num_devices automatically
      btrfs: fix the error handling for submit_extent_page() for btrfs_do_readpage()

Quentin Monnet (1):
      selftests/bpf: Fix parsing of prog types in UAPI hdr for bpftool sync

Quentin Perret (1):
      KVM: arm64: Don't hypercall before EL2 init

Radhey Shyam Pandey (1):
      dmaengine: zynqmp_dma: In struct zynqmp_dma_chan fix desc_size data type

Rafał Miłecki (2):
      ARM: dts: BCM5301X: update CRU block description
      ARM: dts: BCM5301X: Update pin controller node name

Randy Dunlap (9):
      fs/ntfs3: validate BOOT sectors_per_clusters
      x86: Fix return value of __setup handlers
      x86/mm: Cleanup the control_va_addr_alignment() __setup handler
      net: dsa: restrict SMSC_LAN9303_I2C kconfig
      powerpc/8xx: export 'cpm_setbrg' for modules
      powerpc/idle: Fix return value of __setup() handler
      powerpc/4xx/cpm: Fix return value of __setup() handler
      macintosh: via-pmu and via-cuda need RTC_LIB
      pcmcia: db1xxx_ss: restrict to MIPS_DB1XXX boards

Ravi Bangoria (2):
      perf/amd/ibs: Cascade pmu init functions' return value
      perf/amd/ibs: Use interrupt regs ip for stack unwinding

Rei Yamamoto (1):
      mm, compaction: fast_find_migrateblock() should return pfn in the target zone

Reinette Chatre (5):
      x86/sgx: Disconnect backing page references from dirty status
      x86/sgx: Mark PCMD page as dirty when modifying contents
      x86/sgx: Obtain backing storage page with enclave mutex held
      x86/sgx: Fix race between reclaimer and page fault handler
      x86/sgx: Ensure no data in PCMD page after truncate

Rex-BC Chen (1):
      cpufreq: mediatek: Unregister platform device on exit

Rik van der Kemp (1):
      ALSA: hda/realtek: Enable 4-speaker output for Dell XPS 15 9520 laptop

Rob Clark (1):
      dma-debug: make things less spammy under memory pressure

Robert Eckelmann (1):
      USB: serial: io_ti: add Agilent E5805A support

Robert Marko (2):
      arm64: dts: marvell: espressobin-ultra: fix SPI-NOR config
      arm64: dts: marvell: espressobin-ultra: enable front USB3 port

Robin Murphy (1):
      dma-direct: don't over-decrypt memory

Roman Li (1):
      drm/amd/display: Cap OLED brightness per max frame-average luminance

Ronnie Sahlberg (2):
      cifs: fix potential double free during failed mount
      cifs: when extending a file with falloc we should make files not-sparse

Russell King (Oracle) (1):
      net: dsa: mt7530: 1G can also support 1000BASE-X link mode

Saaem Rizvi (1):
      drm/amd/display: Disabling Z10 on DCN31

Saeed Mahameed (1):
      net/mlx5: Fix mlx5_get_next_dev() peer device matching

Sakari Ailus (1):
      ACPI: property: Release subnode properties with data nodes

Sami Tolvanen (1):
      cfi: Fix __cfi_slowpath_diag RCU usage with cpuidle

Samuel Holland (2):
      riscv: Fix irq_work when SMP is disabled
      clocksource/drivers/riscv: Events are stopped during CPU suspend

Saravana Kannan (1):
      driver core: Fix wait_for_device_probe() & deferred_probe_timeout interaction

Sarthak Kukreti (1):
      dm verity: set DM_TARGET_IMMUTABLE feature flag

Sathishkumar S (2):
      drm/amd/pm: update smartshift powerboost calc for smu12
      drm/amd/pm: update smartshift powerboost calc for smu13

Saurabh Sengar (2):
      video: fbdev: hyperv_fb: Allow resolutions with size > 64 MB for Gen1
      Drivers: hv: vmbus: Release cpu lock in error case

Schspa Shi (2):
      cpufreq: Fix possible race in cpufreq online error path
      driver: base: fix UAF when driver_attach failed

Scott Mayhew (1):
      sunrpc: set cl_max_connect when cloning an rpc_clnt

Sean Christopherson (6):
      x86/kvm: Alloc dummy async #PF token outside of raw spinlock
      KVM: x86: avoid calling x86 emulator without a decoded instruction
      KVM: x86: Drop WARNs that assert a triple fault never "escapes" from L2
      KVM: nVMX: Leave most VM-Exit info fields unmodified on failed VM-Entry
      KVM: nVMX: Clear IDT vectoring on nested VM-Exit for double/triple fault
      Kconfig: Add option for asm goto w/ tied outputs to workaround clang-13 bug

Sebastian Andrzej Siewior (1):
      crypto: cryptd - Protect per-CPU resource by disabling BH.

Serge Semin (2):
      gpio: dwapb: Don't print error on -EPROBE_DEFER
      i2c: designware: Use standard optional ref clock implementation

Sergey Shtylyov (2):
      ata: libata-transport: fix {dma|pio|xfer}_mode sysfs files
      ata: libata-core: fix NULL pointer deref in ata_host_alloc_pinfo()

Shawn Lin (1):
      arm64: dts: rockchip: Move drive-impedance-ohm to emmc phy on rk3399

Shengjiu Wang (1):
      ASoC: fsl_sai: Fix FSL_SAI_xDR/xFR definition

Sherry Sun (1):
      tty: serial: fsl_lpuart: fix potential bug when using both of_alias_get_id and ida_simple_get

Sherry Wang (1):
      drm/amd/display: Read Golden Settings Table from VBIOS

Shin'ichiro Kawasaki (1):
      bus: fsl-mc-bus: fix KASAN use-after-free in fsl_mc_bus_remove()

Shuah Khan (1):
      misc: rtsx: set NULL intfdata when probe fails

Shyam Prasad N (1):
      cifs: return errors during session setup during reconnects

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV31 with new baseline

Smith, Kyle Miller (Nimble Kernel) (1):
      nvme-pci: fix a NULL pointer dereference in nvme_alloc_admin_tags

Song Liu (2):
      ftrace: Clean up hash direct_functions on register failures
      selftests/bpf: fix stacktrace_build_id with missing kprobe/urandom_read

Srinivas Kandagatla (1):
      soundwire: qcom: adjust autoenumeration timeout

Stefan Mahnke-Hartmann (1):
      tpm: Fix buffer access in tpm2_get_tpm_pt()

Stefan Wahren (4):
      thermal/drivers/bcm2711: Don't clamp temperature at zero
      ARM: dts: bcm2835-rpi-b: Fix GPIO line names
      gpiolib: of: Introduce hook for missing gpio-ranges
      pinctrl: bcm2835: implement hook for missing gpio-ranges

Stephen Boyd (1):
      interconnect: qcom: sc7180: Drop IP0 interconnects

Stephen Brennan (1):
      assoc_array: Fix BUG_ON during garbage collect

Steve French (3):
      smb3: check for null tcon
      SMB3: EBADF/EIO errors in rename/open caused by race condition in smb2_compound_op
      cifs: version operations for smb20 unneeded when legacy support disabled

Steven Price (1):
      drm/plane: Move range check for format_count earlier

Steven Rostedt (1):
      Bluetooth: hci_qca: Use del_timer_sync() before freeing

Stylon Wang (1):
      Revert "drm/amd/display: Fix DCN3 B0 DP Alt Mapping"

Sudeep Holla (2):
      firmware: arm_ffa: Fix uuid parameter to ffa_partition_probe
      firmware: arm_ffa: Remove incorrect assignment of driver_data

Sultan Alsawaf (1):
      zsmalloc: fix races between asynchronous zspage free and page migration

Sven Schnelle (1):
      s390/stp: clock_delta should be signed

Tadeusz Struk (1):
      exfat: check if cluster num is valid

Takashi Iwai (8):
      ALSA: usb-audio: Workaround for clock setup on TEAC devices
      ALSA: usb-audio: Add missing ep_idx in fixed EP quirks
      ALSA: usb-audio: Optimize TEAC clock quirk
      ALSA: usb-audio: Cancel pending work at closing a MIDI substream
      ALSA: usb-audio: Add quirk bits for enabling/disabling generic implicit fb
      ALSA: usb-audio: Move generic implicit fb quirk entries into quirks.c
      ALSA: usb-audio: Skip generic sync EP parse for secondary EP
      ALSA: usb-audio: Set up (implicit) sync for Saffire 6

Tali Perry (2):
      i2c: npcm: Fix timeout calculation
      i2c: npcm: Handle spurious interrupts

Tan Tee Min (1):
      net: phy: dp83867: retrigger SGMII AN when link change

Tao Jin (1):
      HID: multitouch: add quirks to enable Lenovo X12 trackpoint

Tejas Upadhyay (1):
      iommu/vt-d: Add RPLS to quirk list to skip TE disabling

Tejun Heo (1):
      blk-iolatency: Fix inflight count imbalances and IO hangs on offline

Tetsuo Handa (1):
      media: imon: reorganize serialization

Theodore Ts'o (1):
      ext4: filter out EXT4_FC_REPLAY from on-disk superblock field s_state

Thibaut VARÈNE (1):
      ath9k: fix QCA9561 PA bias level

Thomas Bartschies (1):
      net: af_key: check encryption module availability consistency

Thomas Weißschuh (1):
      nvme: add device name to warning in uuid_show()

Thorsten Scherer (1):
      ARM: dts: ci4x10: Adapt to changes in imx6qdl.dtsi regarding fec clocks

Tobias Klauser (1):
      riscv: Wire up memfd_secret in UAPI header

Tokunori Ikegami (2):
      mtd: cfi_cmdset_0002: Move and rename chip_check/chip_ready/chip_good_for_write
      mtd: cfi_cmdset_0002: Use chip_ready() for write on S29GL064N

Tong Tiangen (1):
      arm64: fix types in copy_highpage()

Tony Lindgren (4):
      tty: n_gsm: Don't ignore write return value in gsmld_output()
      tty: n_gsm: Fix packet data hex dump output
      bus: ti-sysc: Fix warnings for unbind for serial
      tty: n_gsm: Debug output allocation must use GFP_ATOMIC

Trond Myklebust (14):
      NFS: Memory allocation failures are not server fatal errors
      NFS: Do not report EINTR/ERESTARTSYS as mapping errors
      NFS: fsync() should report filesystem errors over EINTR/ERESTARTSYS
      NFS: Don't report ENOSPC write errors twice
      NFS: Do not report flush errors in nfs_write_end()
      NFS: Don't report errors from nfs_pageio_complete() more than once
      NFSv4/pNFS: Do not fail I/O when we fail to allocate the pNFS layout
      NFS: Further fixes to the writeback error handling
      NFS: Always initialise fattr->label in nfs_fattr_alloc()
      NFS: Convert GFP_NOFS to GFP_KERNEL
      NFSv4: Don't hold the layoutget locks across multiple RPC calls
      nfsd: Replace use of rwsem with errseq_t
      pNFS: Don't keep retrying if the server replied NFS4ERR_LAYOUTUNAVAILABLE
      pNFS: Avoid a live lock condition in pnfs_update_layout()

Tyler Hicks (1):
      EDAC/dmc520: Don't print an error for each unconfigured interrupt line

Tyrone Ting (1):
      i2c: npcm: Correct register access width

Tzung-Bi Shih (1):
      platform/chrome: cros_ec: fix error handling in cros_ec_register()

Ulf Hansson (2):
      cpuidle: PSCI: Improve support for suspend-to-RAM for PSCI OSI mode
      PM: domains: Fix initialization of genpd's next_wakeup

Uwe Kleine-König (3):
      char: tpm: cr50_i2c: Suppress duplicated error message in .remove()
      pwm: lp3943: Fix duty calculation in case period was clamped
      pwm: raspberrypi-poe: Fix endianness in firmware struct

Vasily Averin (1):
      tracing: incorrect isolate_mote_t cast in mm_vmscan_lru_isolate

Venky Shankar (1):
      ceph: allow ceph.dir.rctime xattr to be updatable

Vignesh Raghavendra (1):
      drivers: mmc: sdhci_am654: Add the quirk to set TESTCD bit

Vincent Mailhol (1):
      can: mcp251xfd: silence clang's -Wunaligned-access warning

Vincent Ray (1):
      net: sched: fixed barrier to prevent skbuff sticking in qdisc backlog

Vincent Whitchurch (2):
      um: Fix out-of-bounds read in LDT setup
      tty: goldfish: Fix free_irq() on remove

Vinod Koul (1):
      arm64: dts: qcom: qrb5165-rb5: Fix can-clock node name

Vinod Polimera (1):
      drm/msm/disp/dpu1: set vbif hw config to NULL to avoid use after memory free during pm runtime resume

Viresh Kumar (2):
      cpufreq: Avoid unnecessary frequency updates due to mismatch
      Revert "cpufreq: Fix possible race in cpufreq online error path"

Vitaly Chikunov (1):
      crypto: ecrdsa - Fix incorrect use of vli_cmp

Waiman Long (2):
      ipc/mqueue: use get_tree_nodev() in mqueue_get_tree()
      kseltest/cgroup: Make test_stress.sh work if run interactively

Wang Cheng (2):
      staging: rtl8712: fix uninit-value in usb_read8() and friends
      staging: rtl8712: fix uninit-value in r871xu_drv_init()

Wang Weiyang (1):
      tty: goldfish: Use tty_port_destroy() to destroy port

Wang Yufen (1):
      ipv6: Fix signed integer overflow in l2tp_ip6_sendmsg

Wanpeng Li (1):
      KVM: LAPIC: Drop pending LAPIC timer injection when canceling the timer

Wei Yongjun (1):
      regulator: da9121: Fix uninit-value in da9121_assign_chip_model()

Wenli Looi (1):
      ath9k: fix ar9003_get_eepmisc

Wentao Wang (1):
      scsi: vmw_pvscsi: Expand vcpuHint to 16 bits

Wesley Cheng (1):
      usb: dwc3: gadget: Replace list_for_each_entry_safe() if using giveback

Willem de Bruijn (1):
      ip_gre: test csum_start instead of transport header

Xianting Tian (1):
      RISC-V: Mark IORESOURCE_EXCLUSIVE for reserved mem instead of IORESOURCE_BUSY

Xiao Ni (2):
      md: Don't set mddev private to NULL in raid0 pers->free
      md: fix double free of io_acct_set bioset

Xiao Yang (1):
      RDMA/rxe: Generate a completion for unsupported/invalid opcode

Xiaoguang Wang (1):
      scsi: target: tcmu: Fix possible data corruption

Xiaohui Zhang (1):
      nfc: nfcmrvl: Fix memory leak in nfcmrvl_play_deferred

Xiaoke Wang (2):
      iio: dummy: iio_simple_dummy: check the return value of kstrdup()
      staging: rtl8712: fix a potential memory leak in r871xu_drv_init()

Xiaomeng Tong (14):
      KVM: PPC: Book3S HV: fix incorrect NULL check on list iterator
      media: uvcvideo: Fix missing check to determine if element is found in list
      scsi: dc395x: Fix a missing check on list iterator
      drm/nouveau/clk: Fix an incorrect NULL check on list iterator
      drm/nouveau/kms/nv50-: atom: fix an incorrect NULL check on list iterator
      md: fix an incorrect NULL check in does_sb_need_changing
      md: fix an incorrect NULL check in md_reload_sb
      iommu/msm: Fix an incorrect NULL check on list iterator
      carl9170: tx: fix an incorrect use of list iterator
      stm: ltdc: fix two incorrect NULL checks on list iterator
      tilcdc: tilcdc_external: fix an incorrect NULL check on list iterator
      gma500: fix an incorrect NULL check on list iterator
      misc: fastrpc: fix an incorrect NULL check on list iterator
      firmware: stratix10-svc: fix a missing check on list iterator

Xie Yongji (3):
      nbd: Fix hung on disconnect request if socket is closed before
      vringh: Fix loop descriptors check in the indirect cases
      vduse: Fix NULL pointer dereference on sysfs access

Xin Xiong (1):
      ksmbd: fix reference count leak in smb_check_perm_dacl()

Xiu Jianfeng (1):
      tpm: ibmvtpm: Correct the return value in tpm_ibmvtpm_probe()

Xiubo Li (1):
      ceph: flush the mdlog for filesystem sync

Yang Jihong (1):
      perf tools: Add missing headers needed by util/data.h

Yang Yingliang (16):
      pinctrl: renesas: rzn1: Fix possible null-ptr-deref in sh_pfc_map_resources()
      mtd: rawnand: cadence: fix possible null-ptr-deref in cadence_nand_dt_probe()
      mtd: rawnand: intel: fix possible null-ptr-deref in ebu_nand_probe()
      drm/msm/hdmi: check return value after calling platform_get_resource_byname()
      drm/rockchip: vop: fix possible null-ptr-deref in vop_bind()
      spi: spi-fsl-qspi: check return value after calling platform_get_resource_byname()
      media: i2c: ov5648: fix wrong pointer passed to IS_ERR() and PTR_ERR()
      thermal/core: Fix memory leak in __thermal_cooling_device_register()
      ASoC: wm2000: fix missing clk_disable_unprepare() on error in wm2000_anc_transition()
      pinctrl: renesas: core: Fix possible null-ptr-deref in sh_pfc_map_resources()
      hwrng: omap3-rom - fix using wrong clk_disable() in omap_rom_rng_runtime_resume()
      mfd: davinci_voicecodec: Fix possible null-ptr-deref davinci_vc_probe()
      rtc: mt6397: check return value after calling platform_get_resource()
      iommu/arm-smmu: fix possible null-ptr-deref in arm_smmu_device_probe()
      iommu/arm-smmu-v3: check return value after calling platform_get_resource()
      video: fbdev: pxa3xx-gcu: release the resources correctly in pxa3xx_gcu_probe/remove()

Yangyang Li (1):
      RDMA/hns: Add the detection for CMDQ status in the device initialization process

Ye Bin (4):
      ext4: fix use-after-free in ext4_rename_dir_prepare
      ext4: fix warning in ext4_handle_inode_extension
      ext4: fix bug_on in ext4_writepages
      ext4: fix super block checksum incorrect after mount

Yi Yang (1):
      xtensa/simdisk: fix proc_read_simdisk()

Yicong Yang (1):
      PCI: Avoid pci_dev_lock() AB/BA deadlock with sriov_numvfs_store()

Ying Hsu (1):
      Bluetooth: fix dangling sco_conn and use-after-free in sco_sock_timeout

Yixing Liu (1):
      RDMA/hns: Remove the num_cqc_timer variable

Yong Wu (4):
      iommu/mediatek: Fix 2 HW sharing pgtable issue
      iommu/mediatek: Add list_del in mtk_iommu_remove
      iommu/mediatek: Remove clk_disable in mtk_iommu_remove
      iommu/mediatek: Add mutex for m4u_group and m4u_dom in data

Yonghong Song (1):
      selftests/bpf: fix btf_dump/btf_dump due to recent clang change

Yongzhi Liu (1):
      hv_netvsc: Fix potential dereference of NULL pointer

Yu Kuai (3):
      nbd: call genl_unregister_family() first in nbd_cleanup()
      nbd: fix race between nbd_alloc_config() and module removal
      nbd: fix io hung while disconnecting device

Yu Xiao (1):
      nfp: only report pause frame configuration for physical device

Yuanchu Xie (1):
      selftests/damon: add damon to selftests root Makefile

YueHaibing (1):
      serial: cpm_uart: Fix build error without CONFIG_SERIAL_CPM_CONSOLE

Yunfei Wang (1):
      iommu/dma: Fix iova map result check bug

Yuntao Wang (2):
      bpf: Fix potential array overflow in bpf_trampoline_get_progs()
      bpf: Fix excessive memory allocation in stack_map_alloc()

Yupeng Li (1):
      MIPS: Loongson-3: fix compile mips cpu_hwmon as module build error.

Yury Norov (1):
      drm/amd/pm: use bitmap_{from,to}_arr32 where appropriate

Zack Rusin (2):
      drm/vmwgfx: validate the screen formats
      drm/vmwgfx: Fix an invalid read

Zev Weiss (1):
      regulator: core: Fix enable_count imbalance with EXCLUSIVE_GET

Zhang Wensheng (1):
      driver core: fix deadlock in __device_attach

Zhang Yi (1):
      ext4: add reserved GDT blocks check

Zhen Lei (1):
      of: Support more than one crash kernel regions for kexec -s

Zhen Ni (1):
      USB: host: isp116x: check return value after calling platform_get_resource()

Zheng Bin (1):
      net: hinic: add missing destroy_workqueue in hinic_pf_to_mgmt_init

Zheng Yongjun (3):
      spi: img-spfi: Fix pm_runtime_get_sync() error checking
      thermal/drivers/broadcom: Fix potential NULL dereference in sr_thermal_probe
      usb: dwc3: pci: Fix pm_runtime_get_sync() error checking

Zhengjun Xing (1):
      perf jevents: Fix event syntax error caused by ExtSel

Zheyu Ma (4):
      media: pci: cx23885: Fix the error handling in cx23885_initdev()
      media: cx25821: Fix the warning when removing the module
      mtd: rawnand: denali: Use managed device resources
      tty: synclink_gt: Fix null-pointer-dereference in slgt_clean()

Zhihao Cheng (3):
      fs-writeback: writeback_sb_inodes：Recalculate 'wrote' according skipped pages
      ubi: fastmap: Fix high cpu usage of ubi_bgt by making sure wl_pool not empty
      ubi: ubi_create_volume: Fix use-after-free when volume creation failed

Zhou Qingyang (1):
      drm/komeda: Fix an undefined behavior bug in komeda_plane_add()

Zixuan Fu (1):
      fs: jfs: fix possible NULL pointer dereference in dbFree()

bumwoo lee (1):
      extcon: Modify extcon device to be created after driver data is set

chengkaitao (1):
      virtio-mmio: fix missing put_device() when vm_cmdline_parent registration failed

huangwenhui (2):
      ALSA: hda/conexant - Fix loopback issue with CX20632
      ALSA: hda/realtek - Add HW8326 support

jianghaoran (1):
      ipv6: Don't send rs packets to the interface of ARPHRD_TUNNEL

liuyacan (1):
      net/smc: postpone sk_refcnt increment in connect()

Íñigo Huguet (1):
      sfc: fix wrong tx channel offset with efx_separate_tx_channels
---
Documentation/ABI/testing/sysfs-ata                |  11 +-
 Documentation/ABI/testing/sysfs-devices-system-cpu |   1 +
 Documentation/accounting/psi.rst                   |   9 +-
 Documentation/admin-guide/hw-vuln/index.rst        |   1 +
 .../hw-vuln/processor_mmio_stale_data.rst          | 246 +++++++
 Documentation/admin-guide/kernel-parameters.txt    |  36 +
 Documentation/conf.py                              |   2 +-
 .../bindings/display/sitronix,st7735r.yaml         |   1 +
 .../devicetree/bindings/gpio/gpio-altera.txt       |   5 +-
 .../bindings/regulator/mt6315-regulator.yaml       |   6 +-
 .../bindings/spi/qcom,spi-qcom-qspi.yaml           |   1 +
 Documentation/filesystems/f2fs.rst                 |   1 +
 Documentation/process/submitting-patches.rst       |   2 +-
 Documentation/sound/alsa-configuration.rst         |   4 +-
 Documentation/userspace-api/landlock.rst           |   4 +-
 Makefile                                           |   5 +-
 arch/alpha/include/asm/page.h                      |   2 +-
 arch/arm/boot/dts/aspeed-ast2600-evb.dts           |   4 +-
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |  13 +-
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           |  22 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         |   2 +-
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts          |   4 +-
 arch/arm/boot/dts/bcm5301x.dtsi                    |  15 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   4 +-
 arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dts      |   6 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi             |   6 +-
 arch/arm/boot/dts/ox820.dtsi                       |   2 +-
 arch/arm/boot/dts/s5pv210-aries.dtsi               |   5 +-
 arch/arm/boot/dts/s5pv210.dtsi                     |  12 +-
 arch/arm/boot/dts/sama7g5.dtsi                     |   1 -
 arch/arm/boot/dts/socfpga.dtsi                     |   2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi             |   2 +-
 arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |   1 +
 arch/arm/boot/dts/suniv-f1c100s.dtsi               |   4 +-
 arch/arm/kernel/signal.c                           |   1 +
 arch/arm/mach-hisi/platsmp.c                       |   4 +
 arch/arm/mach-mediatek/Kconfig                     |   1 +
 arch/arm/mach-omap1/clock.c                        |   2 +-
 arch/arm/mach-pxa/cm-x300.c                        |   8 +-
 arch/arm/mach-pxa/magician.c                       |   2 +-
 arch/arm/mach-pxa/tosa.c                           |   4 +-
 arch/arm/mach-vexpress/dcscb.c                     |   1 +
 arch/arm64/Kconfig.platforms                       |   1 +
 .../dts/freescale/imx8mm-beacon-baseboard.dtsi     |   3 +
 .../dts/freescale/imx8mn-beacon-baseboard.dtsi     |   3 +
 .../dts/marvell/armada-3720-espressobin-ultra.dts  |   5 -
 arch/arm64/boot/dts/mediatek/mt8192.dtsi           |   2 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   5 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |   8 +-
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |   2 +-
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts      |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   2 +-
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi            |   2 -
 arch/arm64/include/asm/processor.h                 |  10 +-
 arch/arm64/kernel/ftrace.c                         | 137 ++--
 arch/arm64/kernel/signal.c                         |   1 +
 arch/arm64/kernel/signal32.c                       |   1 +
 arch/arm64/kernel/sys_compat.c                     |   2 +-
 arch/arm64/kvm/arm.c                               |   3 +-
 arch/arm64/kvm/vgic/vgic-mmio-v2.c                 |   4 +-
 arch/arm64/kvm/vgic/vgic-mmio.c                    |  19 +-
 arch/arm64/kvm/vgic/vgic-mmio.h                    |   3 +
 arch/arm64/mm/copypage.c                           |   4 +-
 arch/arm64/net/bpf_jit_comp.c                      |   1 +
 arch/csky/kernel/probes/kprobes.c                  |   2 +-
 arch/m68k/Kconfig.cpu                              |   2 +-
 arch/m68k/Kconfig.machine                          |   1 +
 arch/m68k/include/asm/pgtable_no.h                 |   3 +-
 arch/m68k/include/asm/raw_io.h                     |   6 +-
 arch/m68k/kernel/setup_mm.c                        |   7 -
 arch/m68k/kernel/setup_no.c                        |   1 -
 arch/m68k/kernel/signal.c                          |   1 +
 arch/m68k/kernel/time.c                            |   9 +
 .../include/asm/mach-ip27/cpu-feature-overrides.h  |   1 -
 .../include/asm/mach-ip30/cpu-feature-overrides.h  |   1 -
 arch/mips/kernel/mips-cpc.c                        |   1 +
 arch/openrisc/include/asm/timex.h                  |   1 +
 arch/openrisc/kernel/head.S                        |   9 +
 arch/parisc/include/asm/fb.h                       |   4 +
 arch/powerpc/Kconfig                               |   2 -
 arch/powerpc/include/asm/page.h                    |   7 +-
 arch/powerpc/include/asm/ppc-opcode.h              |   2 +
 arch/powerpc/include/asm/thread_info.h             |  10 +-
 arch/powerpc/include/asm/vas.h                     |   2 +-
 arch/powerpc/kernel/entry_64.S                     |  24 +-
 arch/powerpc/kernel/fadump.c                       |   8 +-
 arch/powerpc/kernel/idle.c                         |   4 +-
 arch/powerpc/kernel/idle_6xx.S                     |   2 +-
 arch/powerpc/kernel/l2cr_6xx.S                     |   6 +-
 arch/powerpc/kernel/process.c                      |   4 +-
 arch/powerpc/kernel/ptrace/ptrace-fpu.c            |  20 +-
 arch/powerpc/kernel/ptrace/ptrace.c                |   3 +
 arch/powerpc/kernel/rtas.c                         |   9 +
 arch/powerpc/kernel/swsusp_32.S                    |   2 +-
 arch/powerpc/kernel/swsusp_asm64.S                 |   2 +-
 arch/powerpc/kvm/book3s_hv.c                       |   4 +
 arch/powerpc/kvm/book3s_hv_nested.c                |   3 +-
 arch/powerpc/kvm/book3s_hv_uvmem.c                 |   8 +-
 arch/powerpc/mm/mmu_context.c                      |   2 +-
 arch/powerpc/mm/nohash/kaslr_booke.c               |   8 +-
 arch/powerpc/perf/isa207-common.c                  |  12 +-
 arch/powerpc/platforms/4xx/cpm.c                   |   2 +-
 arch/powerpc/platforms/8xx/cpm1.c                  |   1 +
 arch/powerpc/platforms/powermac/cache.S            |   4 +-
 arch/powerpc/platforms/powernv/opal-fadump.c       |  94 +--
 arch/powerpc/platforms/powernv/opal-fadump.h       |  10 +-
 arch/powerpc/platforms/powernv/ultravisor.c        |   1 +
 arch/powerpc/platforms/powernv/vas-fault.c         |   2 +-
 arch/powerpc/platforms/powernv/vas-window.c        |   4 +-
 arch/powerpc/platforms/powernv/vas.h               |   2 +-
 arch/powerpc/sysdev/dart_iommu.c                   |   6 +-
 arch/powerpc/sysdev/fsl_rio.c                      |   2 +
 arch/powerpc/sysdev/xics/icp-opal.c                |   1 +
 arch/powerpc/sysdev/xive/spapr.c                   |  43 +-
 arch/riscv/include/asm/alternative-macros.h        |   4 +-
 arch/riscv/include/asm/irq_work.h                  |   2 +-
 arch/riscv/include/asm/unistd.h                    |   1 -
 arch/riscv/include/uapi/asm/unistd.h               |   1 +
 arch/riscv/kernel/efi.c                            |   2 +-
 arch/riscv/kernel/head.S                           |   1 +
 arch/riscv/kernel/machine_kexec.c                  |   4 +-
 arch/riscv/kernel/setup.c                          |   4 +-
 arch/s390/crypto/aes_s390.c                        |   4 +-
 arch/s390/include/asm/cio.h                        |   2 +-
 arch/s390/include/asm/kexec.h                      |  10 +
 arch/s390/include/asm/preempt.h                    |  15 +-
 arch/s390/kernel/entry.S                           |   6 +-
 arch/s390/kernel/perf_event.c                      |   2 +-
 arch/s390/kernel/time.c                            |   8 +-
 arch/s390/mm/gmap.c                                |  14 +
 arch/sparc/kernel/signal32.c                       |   1 +
 arch/sparc/kernel/signal_64.c                      |   1 +
 arch/um/drivers/chan_kern.c                        |  10 +-
 arch/um/drivers/chan_user.c                        |   9 +-
 arch/um/drivers/line.c                             |  22 +-
 arch/um/drivers/line.h                             |   4 +-
 arch/um/drivers/ssl.c                              |   2 -
 arch/um/drivers/stdio_console.c                    |   2 -
 arch/um/include/asm/Kbuild                         |   1 +
 arch/um/include/asm/irq.h                          |  22 +-
 arch/um/include/asm/thread_info.h                  |   2 +
 arch/um/kernel/exec.c                              |   2 +-
 arch/um/kernel/process.c                           |   2 +-
 arch/um/kernel/ptrace.c                            |   8 +-
 arch/um/kernel/signal.c                            |   4 +-
 arch/x86/Kconfig                                   |   4 +-
 arch/x86/entry/entry_64.S                          |   1 +
 arch/x86/entry/vdso/vma.c                          |   2 +-
 arch/x86/events/amd/ibs.c                          |  55 +-
 arch/x86/events/intel/core.c                       |   2 +-
 arch/x86/include/asm/acenv.h                       |  14 +-
 arch/x86/include/asm/cpufeature.h                  |   2 +-
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/kexec.h                       |   8 +
 arch/x86/include/asm/msr-index.h                   |  25 +
 arch/x86/include/asm/nospec-branch.h               |   2 +
 arch/x86/include/asm/suspend_32.h                  |   2 +-
 arch/x86/include/asm/suspend_64.h                  |  12 +-
 arch/x86/kernel/apic/apic.c                        |   2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c                 |   8 +-
 arch/x86/kernel/cpu/bugs.c                         | 235 ++++++-
 arch/x86/kernel/cpu/common.c                       |  52 +-
 arch/x86/kernel/cpu/intel.c                        |   2 +-
 arch/x86/kernel/cpu/mce/amd.c                      |  32 +-
 arch/x86/kernel/cpu/sgx/encl.c                     | 218 +++++-
 arch/x86/kernel/cpu/sgx/encl.h                     |   9 +-
 arch/x86/kernel/cpu/sgx/main.c                     |  22 +-
 arch/x86/kernel/kvm.c                              |  41 +-
 arch/x86/kernel/machine_kexec_64.c                 |  12 +-
 arch/x86/kernel/signal_compat.c                    |   2 +
 arch/x86/kernel/step.c                             |   3 +-
 arch/x86/kernel/sys_x86_64.c                       |   7 +-
 arch/x86/kvm/lapic.c                               |   1 +
 arch/x86/kvm/svm/nested.c                          |   3 -
 arch/x86/kvm/svm/sev.c                             |  12 +-
 arch/x86/kvm/vmx/nested.c                          |  48 +-
 arch/x86/kvm/vmx/vmcs.h                            |   5 +
 arch/x86/kvm/vmx/vmx.c                             |  72 ++
 arch/x86/kvm/vmx/vmx.h                             |   2 +
 arch/x86/kvm/x86.c                                 |  34 +-
 arch/x86/lib/delay.c                               |   4 +-
 arch/x86/mm/pat/memtype.c                          |   2 +-
 arch/x86/pci/irq.c                                 |  19 +-
 arch/x86/um/ldt.c                                  |   6 +-
 arch/xtensa/kernel/ptrace.c                        |   4 +-
 arch/xtensa/kernel/signal.c                        |   4 +-
 arch/xtensa/platforms/iss/simdisk.c                |  18 +-
 block/bfq-cgroup.c                                 | 111 +--
 block/bfq-iosched.c                                |  64 +-
 block/bfq-iosched.h                                |   7 +-
 block/bio.c                                        |   9 +-
 block/blk-cgroup.c                                 |   8 +-
 block/blk-iolatency.c                              | 122 ++--
 block/blk-mq.c                                     |   9 +-
 certs/blacklist_hashes.c                           |   2 +-
 crypto/Kconfig                                     |   3 +-
 crypto/Makefile                                    |   2 +-
 crypto/cryptd.c                                    |  26 +-
 crypto/drbg.c                                      | 110 ++-
 crypto/ecrdsa.c                                    |   8 +-
 drivers/acpi/cppc_acpi.c                           |  17 +-
 drivers/acpi/property.c                            |  18 +-
 drivers/acpi/sleep.c                               |  12 +
 drivers/ata/libata-core.c                          |   4 +-
 drivers/ata/libata-transport.c                     |   2 +-
 drivers/ata/pata_octeon_cf.c                       |   3 +
 drivers/base/bus.c                                 |   4 +-
 drivers/base/cpu.c                                 |   8 +
 drivers/base/dd.c                                  |  10 +-
 drivers/base/init.c                                |   2 +
 drivers/base/memory.c                              |   5 +-
 drivers/base/node.c                                |   1 +
 drivers/base/power/domain.c                        |   1 +
 drivers/base/property.c                            |  90 ++-
 drivers/block/drbd/drbd_main.c                     |  11 +-
 drivers/block/nbd.c                                |  50 +-
 drivers/block/virtio_blk.c                         |   7 +-
 drivers/bluetooth/hci_qca.c                        |   4 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |   6 +-
 drivers/bus/ti-sysc.c                              |   4 +-
 drivers/char/Kconfig                               |  50 +-
 drivers/char/hw_random/omap3-rom-rng.c             |   2 +-
 drivers/char/ipmi/ipmi_msghandler.c                |   4 +-
 drivers/char/ipmi/ipmi_ssif.c                      |  23 +
 drivers/char/random.c                              |  29 +-
 drivers/char/tpm/tpm2-cmd.c                        |  11 +-
 drivers/char/tpm/tpm_ibmvtpm.c                     |   1 +
 drivers/char/tpm/tpm_tis_i2c_cr50.c                |   4 +-
 drivers/char/xillybus/xillyusb.c                   |   1 +
 drivers/clk/imx/clk-imx8mp.c                       |   2 +-
 drivers/clk/tegra/clk-dfll.c                       |  12 +
 drivers/clocksource/hyperv_timer.c                 |   1 -
 drivers/clocksource/timer-oxnas-rps.c              |   2 +-
 drivers/clocksource/timer-riscv.c                  |   2 +-
 drivers/clocksource/timer-sp804.c                  |  10 +-
 drivers/comedi/drivers/vmk80xx.c                   |   2 +-
 drivers/cpufreq/cpufreq.c                          |  11 +
 drivers/cpufreq/mediatek-cpufreq.c                 |  18 +-
 drivers/cpuidle/cpuidle-psci.c                     |  46 ++
 .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    | 115 ++--
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c  |  30 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c  |  10 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h       |  14 +-
 drivers/crypto/caam/ctrl.c                         |  18 +
 drivers/crypto/ccree/cc_buffer_mgr.c               |  27 +-
 drivers/crypto/marvell/cesa/cipher.c               |   1 -
 drivers/crypto/nx/nx-common-powernv.c              |   2 +-
 drivers/crypto/qat/qat_common/adf_gen2_hw_data.c   |  18 +-
 drivers/crypto/qat/qat_common/adf_gen2_hw_data.h   |   1 +
 .../crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c |  15 +-
 drivers/devfreq/rk3399_dmc.c                       |   2 +
 drivers/dma/idxd/cdev.c                            |   8 +-
 drivers/dma/idxd/dma.c                             |  23 +
 drivers/dma/stm32-mdma.c                           |  23 +-
 drivers/dma/xilinx/zynqmp_dma.c                    |   5 +-
 drivers/edac/dmc520_edac.c                         |   2 +-
 drivers/extcon/extcon-axp288.c                     |   4 +-
 drivers/extcon/extcon-ptn5150.c                    |  11 +
 drivers/extcon/extcon.c                            |  33 +-
 drivers/firmware/arm_ffa/driver.c                  |   4 +-
 drivers/firmware/arm_scmi/base.c                   |   2 +-
 drivers/firmware/dmi-sysfs.c                       |   2 +-
 drivers/firmware/stratix10-svc.c                   |  12 +-
 drivers/gpio/gpio-dwapb.c                          |   7 +-
 drivers/gpio/gpio-pca953x.c                        |  19 +-
 drivers/gpio/gpio-rockchip.c                       |  24 +-
 drivers/gpio/gpiolib-of.c                          |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  95 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |   3 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |   3 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   8 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   9 +-
 .../amd/display/dc/dcn31/dcn31_dio_link_encoder.c  |   4 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c  |   7 +-
 drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c          |  14 +-
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c          |   8 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |  60 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |   1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c   |  62 +-
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c  |  10 +-
 drivers/gpu/drm/arm/malidp_crtc.c                  |   5 +-
 drivers/gpu/drm/ast/ast_mode.c                     |   5 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |   1 +
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  73 +-
 drivers/gpu/drm/bridge/chipone-icn6211.c           | 155 ++++-
 drivers/gpu/drm/bridge/ite-it66121.c               |   2 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              |  34 +-
 drivers/gpu/drm/drm_atomic_helper.c                |  16 +-
 drivers/gpu/drm/drm_bridge_connector.c             |   4 +-
 drivers/gpu/drm/drm_edid.c                         |   6 +-
 drivers/gpu/drm/drm_plane.c                        |  14 +-
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c              |   6 +
 drivers/gpu/drm/gma500/psb_intel_display.c         |   7 +-
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c       |  33 +-
 drivers/gpu/drm/i915/i915_perf.c                   |   4 +-
 drivers/gpu/drm/i915/i915_perf_types.h             |   2 +-
 drivers/gpu/drm/i915/i915_sysfs.c                  |  15 +-
 drivers/gpu/drm/i915/intel_pm.c                    |   2 +-
 drivers/gpu/drm/imx/ipuv3-crtc.c                   |   2 +-
 drivers/gpu/drm/mediatek/mtk_cec.c                 |   2 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |   4 +-
 drivers/gpu/drm/msm/Makefile                       |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  23 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |  10 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |  14 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c           |   6 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.c         |  15 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_mixer.h         |   4 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.c          |  15 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_pipe.h          |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |  20 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |  16 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |  55 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  21 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c         |   2 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c                    |  22 +-
 drivers/gpu/drm/msm/hdmi/hdmi.h                    |  19 +-
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |  81 ++-
 .../drm/msm/hdmi/{hdmi_connector.c => hdmi_hpd.c}  | 154 +----
 drivers/gpu/drm/msm/msm_drv.c                      |   8 +-
 drivers/gpu/drm/msm/msm_gem_prime.c                |   2 +-
 drivers/gpu/drm/msm/msm_kms.h                      |   1 +
 drivers/gpu/drm/nouveau/dispnv50/atom.h            |   6 +-
 drivers/gpu/drm/nouveau/dispnv50/crc.c             |  27 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h |   2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c    |  14 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c     |   6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c     |   6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c     |   6 +-
 drivers/gpu/drm/panel/panel-simple.c               |   3 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |   4 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   2 +-
 drivers/gpu/drm/stm/ltdc.c                         |  16 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c           |   8 +-
 drivers/gpu/drm/v3d/v3d_perfmon.c                  |   3 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                     |   2 +-
 drivers/gpu/drm/vc4/vc4_drv.h                      |   1 +
 drivers/gpu/drm/vc4/vc4_hvs.c                      |  49 +-
 drivers/gpu/drm/vc4/vc4_regs.h                     |  12 +-
 drivers/gpu/drm/vc4/vc4_txp.c                      |   8 +-
 drivers/gpu/drm/virtio/virtgpu_display.c           |   2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  30 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |   1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |  14 +-
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c              |   4 +-
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h              |   2 +-
 drivers/hid/hid-bigbenff.c                         |   6 +
 drivers/hid/hid-elan.c                             |   2 -
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-led.c                              |   2 +-
 drivers/hid/hid-multitouch.c                       |   9 +
 drivers/hv/channel.c                               |   6 +-
 drivers/hv/channel_mgmt.c                          |   1 +
 drivers/hwmon/pmbus/pmbus_core.c                   |  28 +-
 drivers/hwtracing/coresight/coresight-core.c       |  33 +-
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |   7 +-
 drivers/i2c/busses/i2c-at91-master.c               |  11 +
 drivers/i2c/busses/i2c-cadence.c                   |  12 +-
 drivers/i2c/busses/i2c-designware-common.c         |   3 -
 drivers/i2c/busses/i2c-designware-platdrv.c        |  13 +-
 drivers/i2c/busses/i2c-ismt.c                      |  17 +
 drivers/i2c/busses/i2c-npcm7xx.c                   | 106 ++-
 drivers/i2c/busses/i2c-rcar.c                      |  15 +-
 drivers/i2c/busses/i2c-thunderx-pcidrv.c           |   1 +
 drivers/iio/adc/ad7124.c                           |   1 -
 drivers/iio/adc/sc27xx_adc.c                       |  20 +-
 drivers/iio/adc/stmpe-adc.c                        |   8 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |  24 +-
 drivers/iio/dummy/iio_simple_dummy.c               |  20 +-
 drivers/iio/proximity/vl53l0x-i2c.c                |   7 +-
 drivers/infiniband/hw/hfi1/file_ops.c              |   2 +
 drivers/infiniband/hw/hfi1/init.c                  |   2 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |  12 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |   7 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  24 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |   2 +-
 drivers/infiniband/hw/hns/hns_roce_main.c          |   2 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |   6 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |   2 +-
 drivers/input/keyboard/gpio_keys.c                 |   2 +-
 drivers/input/misc/soc_button_array.c              |   4 +-
 drivers/input/misc/sparcspkr.c                     |   1 +
 drivers/input/mouse/bcm5974.c                      |   7 +-
 drivers/input/touchscreen/stmfts.c                 |  16 +-
 drivers/interconnect/qcom/icc-rpmh.c               |  10 +-
 drivers/interconnect/qcom/sc7180.c                 |  21 -
 drivers/interconnect/qcom/sm8150.c                 |   1 -
 drivers/interconnect/qcom/sm8250.c                 |   1 -
 drivers/interconnect/qcom/sm8350.c                 |   1 -
 drivers/iommu/amd/init.c                           |   2 +-
 drivers/iommu/amd/iommu.c                          |   7 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  13 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |   2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |   5 +-
 drivers/iommu/dma-iommu.c                          |   7 +-
 drivers/iommu/intel/iommu.c                        |   2 +-
 drivers/iommu/msm_iommu.c                          |  11 +-
 drivers/iommu/mtk_iommu.c                          |  30 +-
 drivers/iommu/mtk_iommu.h                          |   2 +
 drivers/iommu/mtk_iommu_v1.c                       |   7 +
 drivers/irqchip/irq-armada-370-xp.c                |  11 +-
 drivers/irqchip/irq-aspeed-i2c-ic.c                |   4 +-
 drivers/irqchip/irq-aspeed-scu-ic.c                |   4 +-
 drivers/irqchip/irq-gic-realview.c                 |   1 +
 drivers/irqchip/irq-gic-v3.c                       |   7 +-
 drivers/irqchip/irq-realtek-rtl.c                  |   2 +-
 drivers/irqchip/irq-sni-exiu.c                     |  25 +-
 drivers/irqchip/irq-xtensa-mx.c                    |  18 +-
 drivers/macintosh/Kconfig                          |   6 +
 drivers/macintosh/Makefile                         |   3 +-
 drivers/macintosh/via-pmu.c                        |   2 +-
 drivers/mailbox/mailbox.c                          |  19 +-
 drivers/md/bcache/btree.c                          |  58 +-
 drivers/md/bcache/btree.h                          |   2 +-
 drivers/md/bcache/journal.c                        |  31 +-
 drivers/md/bcache/journal.h                        |   2 +
 drivers/md/bcache/request.c                        |   6 +
 drivers/md/bcache/super.c                          |   1 +
 drivers/md/bcache/writeback.c                      | 101 +--
 drivers/md/bcache/writeback.h                      |   2 +-
 drivers/md/dm-crypt.c                              |  14 +-
 drivers/md/dm-integrity.c                          |   2 -
 drivers/md/dm-log.c                                |   3 +-
 drivers/md/dm-stats.c                              |   8 +
 drivers/md/dm-verity-target.c                      |   1 +
 drivers/md/md-bitmap.c                             |  44 +-
 drivers/md/md.c                                    |  37 +-
 drivers/md/raid0.c                                 |  32 +-
 drivers/md/raid5.c                                 |  47 +-
 drivers/media/cec/core/cec-adap.c                  |   6 +-
 drivers/media/i2c/ccs/ccs-core.c                   |   7 +-
 drivers/media/i2c/imx412.c                         |   8 +-
 drivers/media/i2c/max9286.c                        | 139 ++--
 drivers/media/i2c/ov5648.c                         |   4 +-
 drivers/media/i2c/ov7670.c                         |   1 -
 drivers/media/i2c/rdacm20.c                        |   2 +-
 drivers/media/i2c/rdacm21.c                        |   2 +-
 drivers/media/pci/cx23885/cx23885-core.c           |   6 +-
 drivers/media/pci/cx25821/cx25821-core.c           |   2 +-
 drivers/media/platform/aspeed-video.c              |   4 +-
 drivers/media/platform/atmel/atmel-sama5d2-isc.c   |   7 +-
 drivers/media/platform/coda/coda-common.c          |  35 +-
 drivers/media/platform/exynos4-is/fimc-is.c        |   6 +-
 drivers/media/platform/exynos4-is/fimc-isp-video.h |   2 +-
 drivers/media/platform/qcom/venus/hfi.c            |   3 +
 drivers/media/platform/rockchip/rga/rga.c          |   6 +-
 drivers/media/platform/sti/delta/delta-v4l2.c      |   6 +-
 drivers/media/platform/vsp1/vsp1_rpf.c             |   6 +-
 drivers/media/rc/imon.c                            |  99 ++-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c            |   7 +-
 drivers/media/usb/uvc/uvc_v4l2.c                   |  20 +-
 drivers/memory/samsung/exynos5422-dmc.c            |   5 +-
 drivers/mfd/davinci_voicecodec.c                   |   6 +-
 drivers/mfd/ipaq-micro.c                           |   2 +-
 drivers/misc/atmel-ssc.c                           |   4 +-
 drivers/misc/cardreader/rtsx_usb.c                 |   1 +
 drivers/misc/fastrpc.c                             |   9 +-
 drivers/misc/lkdtm/bugs.c                          |  10 +-
 drivers/misc/lkdtm/lkdtm.h                         |   8 +-
 drivers/misc/lkdtm/usercopy.c                      |  17 +-
 drivers/misc/mei/hbm.c                             |   3 +-
 drivers/misc/mei/hw-me-regs.h                      |   2 +
 drivers/misc/mei/pci-me.c                          |   2 +
 drivers/misc/ocxl/file.c                           |   2 +
 drivers/misc/pvpanic/pvpanic-mmio.c                |   2 +-
 drivers/misc/pvpanic/pvpanic.c                     |  10 +-
 drivers/mmc/core/block.c                           |  11 +-
 drivers/mmc/host/jz4740_mmc.c                      |  20 +
 drivers/mmc/host/sdhci_am654.c                     |  23 +-
 drivers/mtd/chips/cfi_cmdset_0002.c                | 103 ++-
 drivers/mtd/mtdblock.c                             |   8 +-
 drivers/mtd/nand/raw/cadence-nand-controller.c     |   5 +-
 drivers/mtd/nand/raw/denali_pci.c                  |  15 +-
 drivers/mtd/nand/raw/intel-nand-controller.c       |   2 +-
 drivers/mtd/nand/spi/gigadevice.c                  |  10 +-
 drivers/mtd/spi-nor/core.c                         |   9 +
 drivers/mtd/ubi/fastmap-wl.c                       |  69 +-
 drivers/mtd/ubi/fastmap.c                          |  11 -
 drivers/mtd/ubi/ubi.h                              |   4 +-
 drivers/mtd/ubi/vmt.c                              |   1 -
 drivers/mtd/ubi/wl.c                               |  19 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |   2 +-
 drivers/net/can/xilinx_can.c                       |   4 +-
 drivers/net/dsa/Kconfig                            |   3 +-
 drivers/net/dsa/lantiq_gswip.c                     |   4 +-
 drivers/net/dsa/mt7530.c                           |  14 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   1 +
 drivers/net/dsa/mv88e6xxx/serdes.c                 |  27 +-
 drivers/net/ethernet/altera/altera_tse_main.c      |   6 +-
 drivers/net/ethernet/broadcom/Makefile             |   5 +
 drivers/net/ethernet/broadcom/bgmac-bcma.c         |   1 -
 drivers/net/ethernet/cadence/macb_main.c           |  40 +-
 drivers/net/ethernet/cadence/macb_ptp.c            |   4 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |   5 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  87 ++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |   1 +
 .../net/ethernet/huawei/hinic/hinic_hw_api_cmd.c   |   5 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c  |  10 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c   |   5 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c   |   9 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_mgmt.c  |   2 +
 drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c    |  23 +-
 drivers/net/ethernet/huawei/hinic/hinic_main.c     |  10 +-
 drivers/net/ethernet/huawei/hinic/hinic_tx.c       |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  25 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   5 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  11 -
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   1 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   8 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_cpt.c    |   2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  24 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |  72 +-
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h    |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |  19 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   5 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  38 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  47 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag.c      |  14 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   1 +
 .../ethernet/mellanox/mlx5/core/steering/fs_dr.c   |   9 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.h |   2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_dcb.c |  13 -
 .../net/ethernet/mellanox/mlxsw/spectrum_trap.c    |   2 +-
 .../net/ethernet/netronome/nfp/flower/conntrack.c  |  32 +-
 drivers/net/ethernet/netronome/nfp/flower/match.c  |  16 +-
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   |   4 +-
 drivers/net/ethernet/sfc/ef10.c                    |   2 +-
 drivers/net/ethernet/sfc/efx_channels.c            |   6 +-
 drivers/net/ethernet/sfc/net_driver.h              |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   4 +-
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |  15 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   3 +-
 drivers/net/ethernet/xscale/ptp_ixp46x.c           |   2 +-
 drivers/net/hyperv/netvsc_drv.c                    |   5 +-
 drivers/net/ipa/ipa_endpoint.c                     |  40 +-
 drivers/net/phy/dp83867.c                          |  29 +
 drivers/net/phy/mdio_bus.c                         |   1 -
 drivers/net/phy/micrel.c                           |  11 +-
 drivers/net/usb/asix_devices.c                     |   6 +-
 drivers/net/usb/smsc95xx.c                         |   3 +-
 drivers/net/usb/usbnet.c                           |   6 +-
 drivers/net/wireless/ath/ath10k/mac.c              |  20 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  16 +-
 drivers/net/wireless/ath/ath11k/spectral.c         |  17 +-
 drivers/net/wireless/ath/ath9k/ar9003_eeprom.c     |   2 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.h        |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c      |   8 +
 drivers/net/wireless/ath/carl9170/tx.c             |   3 +
 drivers/net/wireless/broadcom/b43/phy_n.c          |   2 +-
 drivers/net/wireless/broadcom/b43legacy/phy.c      |   2 +-
 drivers/net/wireless/intel/ipw2x00/libipw_tx.c     |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |   3 +
 drivers/net/wireless/marvell/mwifiex/11h.c         |   2 +
 drivers/net/wireless/mediatek/mt76/agg-rx.c        |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    |   8 +-
 drivers/net/wireless/microchip/wilc1000/mon.c      |   4 +-
 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c |   8 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c         |   2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |   4 +
 drivers/nfc/nfcmrvl/usb.c                          |  16 +-
 drivers/nfc/pn533/pn533.c                          |   5 +-
 drivers/nfc/st21nfca/se.c                          |  70 +-
 drivers/nfc/st21nfca/st21nfca.h                    |   1 +
 drivers/nvdimm/core.c                              |   9 -
 drivers/nvdimm/security.c                          |   5 -
 drivers/nvme/host/core.c                           |  25 +-
 drivers/nvme/host/pci.c                            |   1 +
 drivers/of/kexec.c                                 |   9 +
 drivers/of/overlay.c                               |   4 +-
 drivers/opp/of.c                                   |   2 +-
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |   3 +-
 drivers/pci/controller/dwc/pci-imx6.c              |  23 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |   3 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |  15 +-
 drivers/pci/controller/pcie-mediatek.c             |   1 +
 drivers/pci/controller/pcie-microchip-host.c       |   6 +-
 drivers/pci/controller/pcie-rockchip-ep.c          |   3 +-
 drivers/pci/pci-acpi.c                             |  41 +-
 drivers/pci/pci.c                                  |  12 +-
 drivers/pci/pcie/aer.c                             |   7 +-
 drivers/pcmcia/Kconfig                             |   2 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  13 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |  18 +
 drivers/pinctrl/mediatek/Kconfig                   |   1 +
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c        |   2 +-
 drivers/pinctrl/pinctrl-rockchip.c                 |  64 +-
 drivers/pinctrl/pinctrl-rockchip.h                 |   7 +-
 drivers/pinctrl/renesas/core.c                     |   7 +-
 drivers/pinctrl/renesas/pfc-r8a779a0.c             |  29 +
 drivers/pinctrl/renesas/pinctrl-rzn1.c             |  10 +-
 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c      |   2 +-
 drivers/platform/chrome/cros_ec.c                  |  16 +-
 drivers/platform/chrome/cros_ec_chardev.c          |   2 +-
 drivers/platform/chrome/cros_ec_proto.c            |  50 +-
 drivers/platform/mips/Kconfig                      |   2 +-
 drivers/platform/mips/cpu_hwmon.c                  | 127 ++--
 drivers/platform/x86/gigabyte-wmi.c                |   2 +
 drivers/platform/x86/intel/hid.c                   |   8 +-
 drivers/power/supply/axp288_charger.c              |  17 +-
 drivers/power/supply/axp288_fuel_gauge.c           |   1 -
 drivers/power/supply/charger-manager.c             |   7 +-
 drivers/power/supply/max8997_charger.c             |   8 +-
 drivers/pwm/pwm-lp3943.c                           |   1 +
 drivers/pwm/pwm-raspberrypi-poe.c                  |   2 +-
 drivers/regulator/core.c                           |   7 +-
 drivers/regulator/da9121-regulator.c               |   2 +
 drivers/regulator/pfuze100-regulator.c             |   2 +
 drivers/regulator/qcom_smd-regulator.c             |  35 +-
 drivers/regulator/scmi-regulator.c                 |   2 +-
 drivers/remoteproc/imx_rproc.c                     |   3 +
 drivers/rpmsg/qcom_smd.c                           |   4 +-
 drivers/rpmsg/virtio_rpmsg_bus.c                   |   9 +-
 drivers/rtc/rtc-ftrtc010.c                         |  38 +-
 drivers/rtc/rtc-mt6397.c                           |   2 +
 drivers/s390/cio/chsc.c                            |   4 +-
 drivers/scsi/dc395x.c                              |  15 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                      |   2 +-
 drivers/scsi/ipr.c                                 |   4 +-
 drivers/scsi/lpfc/lpfc_els.c                       |  67 +-
 drivers/scsi/lpfc/lpfc_hw4.h                       |   3 +
 drivers/scsi/lpfc/lpfc_init.c                      |  51 +-
 drivers/scsi/lpfc/lpfc_logmsg.h                    |   6 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |   3 +-
 drivers/scsi/lpfc/lpfc_nvme.c                      |  11 +-
 drivers/scsi/lpfc/lpfc_scsi.c                      |  37 +-
 drivers/scsi/lpfc/lpfc_sli.c                       |   6 +-
 drivers/scsi/megaraid.c                            |   2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |  23 +-
 drivers/scsi/myrb.c                                |  11 +-
 drivers/scsi/pmcraid.c                             |   2 +-
 drivers/scsi/sd.c                                  |   1 -
 drivers/scsi/ufs/ti-j721e-ufs.c                    |   6 +-
 drivers/scsi/ufs/ufs-qcom.c                        |  14 +-
 drivers/scsi/ufs/ufshcd.c                          |   7 +-
 drivers/scsi/vmw_pvscsi.h                          |   4 +-
 drivers/soc/bcm/bcm63xx/bcm-pmb.c                  |   3 +
 drivers/soc/qcom/llcc-qcom.c                       |   1 +
 drivers/soc/qcom/smp2p.c                           |   1 +
 drivers/soc/qcom/smsm.c                            |   1 +
 drivers/soc/rockchip/grf.c                         |   2 +
 drivers/soc/ti/ti_sci_pm_domains.c                 |   2 +
 drivers/soundwire/intel.c                          |   3 +
 drivers/soundwire/qcom.c                           |   2 +-
 drivers/spi/spi-cadence-quadspi.c                  |   2 +-
 drivers/spi/spi-fsl-qspi.c                         |   4 +
 drivers/spi/spi-img-spfi.c                         |   2 +-
 drivers/spi/spi-rockchip.c                         | 113 +++-
 drivers/spi/spi-rspi.c                             |  15 +-
 drivers/spi/spi-stm32-qspi.c                       |   3 +-
 drivers/spi/spi-ti-qspi.c                          |   5 +-
 drivers/staging/fieldbus/anybuss/host.c            |   2 +-
 drivers/staging/greybus/audio_codec.c              |   4 +-
 drivers/staging/media/hantro/hantro_g2_hevc_dec.c  |  11 +-
 drivers/staging/media/hantro/hantro_h264.c         |   2 -
 drivers/staging/media/hantro/hantro_v4l2.c         |   8 +-
 drivers/staging/media/rkvdec/rkvdec-h264.c         |  37 +-
 drivers/staging/media/rkvdec/rkvdec.c              |   4 +-
 drivers/staging/r8188eu/core/rtw_xmit.c            |  29 +-
 drivers/staging/r8188eu/include/rtw_xmit.h         |   2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c       | 108 +--
 drivers/staging/rtl8192e/rtllib_softmac.c          |   2 +-
 .../staging/rtl8192u/ieee80211/ieee80211_softmac.c |   2 +-
 drivers/staging/rtl8712/os_intfs.c                 |   1 -
 drivers/staging/rtl8712/usb_intf.c                 |  12 +-
 drivers/staging/rtl8712/usb_ops.c                  |  27 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |  12 +-
 drivers/target/target_core_device.c                |   1 -
 drivers/target/target_core_user.c                  |  50 +-
 drivers/thermal/broadcom/bcm2711_thermal.c         |   5 +-
 drivers/thermal/broadcom/sr-thermal.c              |   3 +
 drivers/thermal/devfreq_cooling.c                  |  25 +-
 drivers/thermal/imx_sc_thermal.c                   |   6 +-
 drivers/thermal/thermal_core.c                     |   1 +
 drivers/thunderbolt/tb.c                           |  19 +-
 drivers/thunderbolt/test.c                         |  16 +-
 drivers/thunderbolt/tunnel.c                       |  11 +-
 drivers/thunderbolt/tunnel.h                       |   4 +-
 drivers/tty/goldfish.c                             |  24 +-
 drivers/tty/n_gsm.c                                |  36 +-
 drivers/tty/n_tty.c                                |  38 +-
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |   2 +
 drivers/tty/serial/8250/8250_fintek.c              |   8 +-
 drivers/tty/serial/8250/8250_port.c                |   2 +
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |   2 +-
 drivers/tty/serial/digicolor-usart.c               |   2 +
 drivers/tty/serial/fsl_lpuart.c                    |  24 +-
 drivers/tty/serial/icom.c                          |   2 +-
 drivers/tty/serial/meson_uart.c                    |  13 +
 drivers/tty/serial/msm_serial.c                    |   5 +
 drivers/tty/serial/owl-uart.c                      |   1 +
 drivers/tty/serial/pch_uart.c                      |  27 +-
 drivers/tty/serial/rda-uart.c                      |   2 +
 drivers/tty/serial/sa1100.c                        |   4 +-
 drivers/tty/serial/serial_txx9.c                   |   2 +
 drivers/tty/serial/sh-sci.c                        |   6 +-
 drivers/tty/serial/sifive.c                        |   8 +-
 drivers/tty/serial/st-asc.c                        |   4 +
 drivers/tty/serial/stm32-usart.c                   |  15 +-
 drivers/tty/synclink_gt.c                          |   2 +
 drivers/tty/sysrq.c                                |  13 +-
 drivers/tty/tty_buffer.c                           |   3 +-
 drivers/usb/cdns3/cdnsp-ring.c                     |  19 +-
 drivers/usb/core/hcd-pci.c                         |   4 +-
 drivers/usb/core/hcd.c                             |  29 +-
 drivers/usb/core/quirks.c                          |   3 +
 drivers/usb/dwc2/gadget.c                          |   1 -
 drivers/usb/dwc2/hcd.c                             |   2 +-
 drivers/usb/dwc3/drd.c                             |   9 +-
 drivers/usb/dwc3/dwc3-pci.c                        |   2 +-
 drivers/usb/dwc3/gadget.c                          |  26 +-
 drivers/usb/gadget/function/f_fs.c                 |  40 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c               |   1 +
 drivers/usb/host/isp116x-hcd.c                     |   6 +-
 drivers/usb/host/oxu210hp-hcd.c                    |   2 +
 drivers/usb/host/xhci-pci.c                        |   2 +
 drivers/usb/isp1760/isp1760-core.c                 |   8 +
 drivers/usb/musb/omap2430.c                        |   1 +
 drivers/usb/phy/phy-omap-otg.c                     |   4 +-
 drivers/usb/serial/io_ti.c                         |   2 +
 drivers/usb/serial/io_usbvend.h                    |   1 +
 drivers/usb/serial/option.c                        |   8 +
 drivers/usb/serial/pl2303.c                        |   3 +
 drivers/usb/storage/karma.c                        |  15 +-
 drivers/usb/typec/mux.c                            |  14 +-
 drivers/usb/typec/tcpm/fusb302.c                   |   4 +-
 drivers/usb/usbip/stub_dev.c                       |   2 +-
 drivers/usb/usbip/stub_rx.c                        |   2 +
 drivers/vdpa/ifcvf/ifcvf_main.c                    |   3 +-
 drivers/vdpa/vdpa.c                                |  13 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c                   |   5 +-
 drivers/vdpa/vdpa_user/vduse_dev.c                 |   7 +-
 drivers/vhost/vringh.c                             |  10 +-
 drivers/video/console/sticon.c                     |   5 +-
 drivers/video/console/sticore.c                    |  32 +-
 drivers/video/fbdev/amba-clcd.c                    |   5 +-
 drivers/video/fbdev/core/fbcon.c                   |   5 +-
 drivers/video/fbdev/hyperv_fb.c                    |  19 +-
 drivers/video/fbdev/pxa3xx-gcu.c                   |  12 +-
 drivers/video/fbdev/sticore.h                      |   3 +
 drivers/video/fbdev/stifb.c                        |   4 +-
 drivers/video/fbdev/vesafb.c                       |   5 +-
 drivers/virtio/virtio_mmio.c                       |   1 +
 drivers/virtio/virtio_pci_common.c                 |   3 +-
 drivers/virtio/virtio_pci_modern_dev.c             |   1 +
 drivers/watchdog/rti_wdt.c                         |   2 +-
 drivers/watchdog/ts4800_wdt.c                      |   5 +-
 drivers/watchdog/wdat_wdt.c                        |   1 +
 drivers/xen/xlate_mmu.c                            |   1 -
 fs/afs/dir.c                                       |   5 +-
 fs/afs/misc.c                                      |   5 +-
 fs/afs/rotate.c                                    |   4 +
 fs/afs/rxrpc.c                                     |   8 +-
 fs/afs/write.c                                     |   1 +
 fs/binfmt_flat.c                                   |  27 +-
 fs/btrfs/disk-io.c                                 |   4 +-
 fs/btrfs/extent_io.c                               |  21 +-
 fs/btrfs/volumes.c                                 |   8 +-
 fs/ceph/mds_client.c                               |  33 +-
 fs/ceph/xattr.c                                    |  10 +-
 fs/cifs/cifsfs.c                                   |  12 +-
 fs/cifs/cifsfs.h                                   |   2 +-
 fs/cifs/cifsglob.h                                 |   4 +-
 fs/cifs/misc.c                                     |  27 +-
 fs/cifs/smb2inode.c                                |   2 -
 fs/cifs/smb2ops.c                                  |  16 +-
 fs/cifs/smb2pdu.c                                  |   3 +
 fs/dax.c                                           |   3 +-
 fs/dlm/lock.c                                      |  11 +-
 fs/dlm/lowcomms.c                                  |   2 +-
 fs/dlm/plock.c                                     |  12 +-
 fs/exfat/balloc.c                                  |   8 +-
 fs/exfat/exfat_fs.h                                |   8 +
 fs/exfat/fatent.c                                  |   8 -
 fs/exportfs/expfs.c                                |   5 +-
 fs/ext4/ext4.h                                     |   6 -
 fs/ext4/extents.c                                  |  20 +-
 fs/ext4/inline.c                                   |  12 +
 fs/ext4/inode.c                                    |  13 +-
 fs/ext4/mballoc.c                                  |  27 +-
 fs/ext4/namei.c                                    |  87 ++-
 fs/ext4/resize.c                                   |  10 +
 fs/ext4/super.c                                    |  40 +-
 fs/f2fs/checkpoint.c                               |   6 +-
 fs/f2fs/dir.c                                      |   3 +-
 fs/f2fs/f2fs.h                                     |  31 +-
 fs/f2fs/file.c                                     |  27 +-
 fs/f2fs/hash.c                                     |  11 +-
 fs/f2fs/inline.c                                   |  31 +-
 fs/f2fs/inode.c                                    |  21 +-
 fs/f2fs/namei.c                                    |  37 +-
 fs/f2fs/recovery.c                                 |   6 +-
 fs/f2fs/segment.c                                  |  42 +-
 fs/f2fs/segment.h                                  |  33 +-
 fs/f2fs/super.c                                    |  22 +-
 fs/f2fs/verity.c                                   |   2 +-
 fs/f2fs/xattr.c                                    |   2 +-
 fs/fat/fatent.c                                    |   7 +-
 fs/fs-writeback.c                                  |  50 +-
 fs/gfs2/quota.c                                    |  32 +-
 fs/hugetlbfs/inode.c                               |   4 +-
 fs/inode.c                                         |   2 +-
 fs/io_uring.c                                      |  15 +
 fs/iomap/buffered-io.c                             |   3 +-
 fs/jffs2/fs.c                                      |   1 +
 fs/jfs/jfs_dmap.c                                  |   3 +-
 fs/kernfs/dir.c                                    |  31 +-
 fs/ksmbd/connection.c                              |   2 +-
 fs/ksmbd/smb2misc.c                                |   2 +-
 fs/ksmbd/smb_common.c                              |   4 +-
 fs/ksmbd/smbacl.c                                  |   1 +
 fs/namei.c                                         |  70 +-
 fs/nfs/callback_proc.c                             |   1 +
 fs/nfs/file.c                                      |  50 +-
 fs/nfs/getroot.c                                   |  17 +-
 fs/nfs/inode.c                                     |  25 +-
 fs/nfs/internal.h                                  |  10 +-
 fs/nfs/nfs4proc.c                                  |  45 +-
 fs/nfs/nfs4state.c                                 |   2 +-
 fs/nfs/pagelist.c                                  |   3 +
 fs/nfs/pnfs.c                                      |  27 +-
 fs/nfs/pnfs.h                                      |   1 +
 fs/nfs/unlink.c                                    |   8 +
 fs/nfs/write.c                                     |  54 +-
 fs/nfsd/filecache.c                                |   1 -
 fs/nfsd/filecache.h                                |   1 -
 fs/nfsd/nfs4proc.c                                 |  16 +-
 fs/nfsd/nfs4state.c                                |  12 +-
 fs/nfsd/nfscache.c                                 |   2 +-
 fs/nfsd/vfs.c                                      |  40 +-
 fs/notify/fdinfo.c                                 |  11 +-
 fs/notify/inotify/inotify.h                        |  12 +
 fs/notify/inotify/inotify_user.c                   |   2 +-
 fs/notify/mark.c                                   |   6 +-
 fs/ntfs3/file.c                                    |  12 +-
 fs/ntfs3/frecord.c                                 |  10 +-
 fs/ntfs3/fslog.c                                   |  12 +-
 fs/ntfs3/inode.c                                   |   8 +-
 fs/ntfs3/super.c                                   |  10 +-
 fs/ntfs3/xattr.c                                   | 112 ++-
 fs/ocfs2/dlmfs/userdlm.c                           |  16 +-
 fs/pipe.c                                          |  33 +-
 fs/proc/generic.c                                  |   3 +
 fs/proc/proc_net.c                                 |   3 +
 fs/quota/dquot.c                                   |  10 +
 fs/zonefs/super.c                                  |  11 +-
 include/crypto/drbg.h                              |  10 +-
 include/drm/drm_edid.h                             |   6 +-
 include/linux/backing-dev.h                        |   2 +
 include/linux/blk_types.h                          |   5 +-
 include/linux/bpf.h                                |   2 +
 include/linux/compat.h                             |   1 +
 include/linux/cpu.h                                |   3 +
 include/linux/efi.h                                |   2 +
 include/linux/export.h                             |   7 +-
 include/linux/extcon.h                             |   2 +-
 include/linux/fwnode.h                             |  10 +-
 include/linux/goldfish.h                           |  15 +-
 include/linux/gpio/driver.h                        |  12 +
 include/linux/iio/common/st_sensors.h              |   3 +
 include/linux/jump_label.h                         |   4 +-
 include/linux/kexec.h                              |  46 +-
 include/linux/list.h                               |  40 +-
 include/linux/mailbox_controller.h                 |   1 +
 include/linux/mlx5/mlx5_ifc.h                      |   5 +-
 include/linux/mtd/cfi.h                            |   1 +
 include/linux/namei.h                              |   6 +
 include/linux/nfs_fs.h                             |  13 +
 include/linux/nfs_fs_sb.h                          |   1 +
 include/linux/nodemask.h                           |  51 +-
 include/linux/pipe_fs_i.h                          |   2 +-
 include/linux/platform_data/cros_ec_proto.h        |   3 +
 include/linux/ptp_classify.h                       |   3 +
 include/linux/ptrace.h                             |   7 -
 include/linux/random.h                             |   2 +-
 include/linux/sched/signal.h                       |   2 +-
 include/linux/usb/hcd.h                            |   2 +
 include/net/flow_offload.h                         |   1 +
 include/net/if_inet6.h                             |   8 +
 include/net/netfilter/nf_conntrack_core.h          |   7 +-
 include/net/netfilter/nf_tables.h                  |   1 -
 include/net/netfilter/nf_tables_offload.h          |   2 +-
 include/net/sch_generic.h                          |  42 +-
 include/net/tcp.h                                  |  19 +-
 include/net/xdp_sock_drv.h                         |   5 +-
 include/net/xsk_buff_pool.h                        |   2 +
 include/scsi/libfcoe.h                             |   3 +-
 include/scsi/libiscsi.h                            |   6 +-
 include/sound/jack.h                               |   1 +
 include/trace/events/rxrpc.h                       |   2 +-
 include/trace/events/tcp.h                         |   2 +-
 include/trace/events/vmscan.h                      |   4 +-
 include/uapi/asm-generic/siginfo.h                 |   7 +
 include/uapi/linux/landlock.h                      |   9 +-
 init/Kconfig                                       |   5 +
 ipc/mqueue.c                                       |  14 +
 kernel/bpf/core.c                                  |  14 +-
 kernel/bpf/stackmap.c                              |   1 -
 kernel/bpf/trampoline.c                            |  18 +-
 kernel/bpf/verifier.c                              |  17 +-
 kernel/cfi.c                                       |  22 +-
 kernel/dma/debug.c                                 |   4 +-
 kernel/dma/direct.c                                | 125 ++--
 kernel/events/core.c                               |   4 +-
 kernel/kexec_file.c                                |  34 -
 kernel/printk/printk.c                             |  61 +-
 kernel/ptrace.c                                    |   5 +-
 kernel/rcu/Kconfig                                 |   1 +
 kernel/rcu/tasks.h                                 |   3 +
 kernel/scftorture.c                                |   5 +-
 kernel/sched/core.c                                |  42 +-
 kernel/sched/deadline.c                            |   5 +-
 kernel/sched/fair.c                                |   8 +-
 kernel/sched/pelt.h                                |   4 +-
 kernel/sched/psi.c                                 |  15 +-
 kernel/sched/rt.c                                  |   5 +-
 kernel/sched/sched.h                               |  37 +-
 kernel/signal.c                                    |  18 +-
 kernel/trace/ftrace.c                              |   5 +-
 kernel/trace/trace.c                               |  13 +-
 kernel/trace/trace_boot.c                          |   2 +-
 kernel/trace/trace_events_hist.c                   |   3 +
 kernel/trace/trace_syscalls.c                      |  35 +-
 lib/Kconfig                                        |   5 +
 lib/Makefile                                       |   3 +-
 lib/assoc_array.c                                  |   8 +
 lib/crypto/Kconfig                                 |  18 +-
 lib/iov_iter.c                                     |  20 +-
 lib/kunit/debugfs.c                                |   2 +-
 lib/list-test.c                                    |  19 +
 {crypto => lib}/memneq.c                           |   0
 lib/nodemask.c                                     |   4 +-
 lib/percpu-refcount.c                              |   1 +
 localversion-rt                                    |   2 +-
 mm/backing-dev.c                                   |  11 +-
 mm/cma.c                                           |   4 +-
 mm/compaction.c                                    |   2 +
 mm/hugetlb.c                                       |   9 +-
 mm/memremap.c                                      |   2 +-
 mm/page_alloc.c                                    |   4 +-
 mm/zsmalloc.c                                      |  37 +-
 net/ax25/af_ax25.c                                 |  34 +-
 net/bluetooth/hci_event.c                          |  15 +-
 net/bluetooth/hci_request.c                        |   2 +
 net/bluetooth/sco.c                                |  21 +-
 net/core/dev.c                                     |   8 +-
 net/core/filter.c                                  |   6 +-
 net/core/flow_offload.c                            |   6 +
 net/ipv4/inet_hashtables.c                         |  10 +-
 net/ipv4/ip_gre.c                                  |  11 +-
 net/ipv4/tcp.c                                     |   8 +-
 net/ipv4/tcp_bbr.c                                 |  20 +-
 net/ipv4/tcp_bic.c                                 |  14 +-
 net/ipv4/tcp_cdg.c                                 |  30 +-
 net/ipv4/tcp_cong.c                                |  18 +-
 net/ipv4/tcp_cubic.c                               |  22 +-
 net/ipv4/tcp_dctcp.c                               |  11 +-
 net/ipv4/tcp_highspeed.c                           |  18 +-
 net/ipv4/tcp_htcp.c                                |  10 +-
 net/ipv4/tcp_hybla.c                               |  18 +-
 net/ipv4/tcp_illinois.c                            |  12 +-
 net/ipv4/tcp_input.c                               |  41 +-
 net/ipv4/tcp_ipv4.c                                |   2 +-
 net/ipv4/tcp_lp.c                                  |   6 +-
 net/ipv4/tcp_metrics.c                             |  12 +-
 net/ipv4/tcp_nv.c                                  |  24 +-
 net/ipv4/tcp_output.c                              |  34 +-
 net/ipv4/tcp_rate.c                                |   2 +-
 net/ipv4/tcp_scalable.c                            |   4 +-
 net/ipv4/tcp_vegas.c                               |  21 +-
 net/ipv4/tcp_veno.c                                |  24 +-
 net/ipv4/tcp_westwood.c                            |   3 +-
 net/ipv4/tcp_yeah.c                                |  30 +-
 net/ipv4/xfrm4_protocol.c                          |   1 -
 net/ipv6/addrconf.c                                |  33 +-
 net/ipv6/seg6_hmac.c                               |   1 -
 net/ipv6/tcp_ipv6.c                                |   2 +-
 net/key/af_key.c                                   |  16 +-
 net/l2tp/l2tp_ip6.c                                |   5 +-
 net/mac80211/chan.c                                |   7 +-
 net/mac80211/ieee80211_i.h                         |   5 +
 net/mac80211/rc80211_minstrel_ht.c                 |   3 +
 net/mac80211/scan.c                                |  20 +
 net/mptcp/pm_netlink.c                             |   2 +
 net/netfilter/nf_tables_api.c                      | 146 ++--
 net/netfilter/nf_tables_offload.c                  |  23 +-
 net/netfilter/nft_nat.c                            |   3 +-
 net/nfc/core.c                                     |   1 +
 net/openvswitch/actions.c                          |   6 +
 net/openvswitch/conntrack.c                        |   4 +-
 net/rxrpc/ar-internal.h                            |  13 +-
 net/rxrpc/call_event.c                             |   7 +-
 net/rxrpc/conn_object.c                            |   2 +-
 net/rxrpc/input.c                                  |  58 +-
 net/rxrpc/output.c                                 |  20 +-
 net/rxrpc/recvmsg.c                                |   8 +-
 net/rxrpc/sendmsg.c                                |   6 +
 net/rxrpc/sysctl.c                                 |   4 +-
 net/sched/act_police.c                             |  16 +-
 net/sctp/input.c                                   |   4 +-
 net/smc/af_smc.c                                   |   2 +-
 net/smc/smc_cdc.c                                  |   2 +-
 net/sunrpc/clnt.c                                  |   1 +
 net/sunrpc/xdr.c                                   |   6 +-
 net/sunrpc/xprtrdma/rpc_rdma.c                     |   5 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c                  |   4 +-
 net/tipc/bearer.c                                  |   3 +-
 net/unix/af_unix.c                                 |   2 +-
 net/wireless/nl80211.c                             |   4 +-
 net/wireless/reg.c                                 |   4 +
 net/xdp/xsk.c                                      |  29 +-
 net/xdp/xsk_buff_pool.c                            |  15 +
 net/xdp/xsk_queue.h                                |  14 +-
 samples/bpf/Makefile                               |   9 +-
 samples/landlock/sandboxer.c                       | 104 +--
 scripts/faddr2line                                 | 179 +++--
 scripts/gdb/linux/config.py                        |   6 +-
 scripts/mod/modpost.c                              |   5 +-
 security/integrity/ima/Kconfig                     |  14 +-
 .../integrity/platform_certs/keyring_handler.h     |   8 +
 security/integrity/platform_certs/load_uefi.c      |  33 +
 security/keys/trusted-keys/trusted_tpm2.c          |   4 +-
 security/landlock/cred.c                           |   4 +-
 security/landlock/cred.h                           |   8 +-
 security/landlock/fs.c                             | 191 ++++--
 security/landlock/fs.h                             |  11 +-
 security/landlock/limits.h                         |   8 +-
 security/landlock/object.c                         |   6 +-
 security/landlock/object.h                         |   6 +-
 security/landlock/ptrace.c                         |  10 +-
 security/landlock/ruleset.c                        |  84 +--
 security/landlock/ruleset.h                        |  35 +-
 security/landlock/syscalls.c                       |  95 +--
 sound/core/jack.c                                  |  34 +-
 sound/core/pcm_memory.c                            |   3 +-
 sound/hda/hdac_device.c                            |   1 +
 sound/pci/hda/patch_conexant.c                     |   7 +
 sound/pci/hda/patch_realtek.c                      |  38 +-
 sound/soc/atmel/atmel-classd.c                     |   1 -
 sound/soc/atmel/atmel-pdmic.c                      |   1 -
 sound/soc/codecs/Kconfig                           |   2 -
 sound/soc/codecs/cs35l36.c                         |   3 +-
 sound/soc/codecs/cs42l51.c                         |   2 +-
 sound/soc/codecs/cs42l52.c                         |   8 +-
 sound/soc/codecs/cs42l56.c                         |   4 +-
 sound/soc/codecs/cs53l30.c                         |  16 +-
 sound/soc/codecs/es8328.c                          |   5 +-
 sound/soc/codecs/max98090.c                        |   6 +-
 sound/soc/codecs/nau8822.c                         |   4 +
 sound/soc/codecs/nau8822.h                         |   3 +
 sound/soc/codecs/rk3328_codec.c                    |   2 +-
 sound/soc/codecs/rt5514.c                          |   2 +-
 sound/soc/codecs/rt5645.c                          |   7 +-
 sound/soc/codecs/tscs454.c                         |  12 +-
 sound/soc/codecs/wm2000.c                          |   6 +-
 sound/soc/codecs/wm8962.c                          |   1 +
 sound/soc/codecs/wm_adsp.c                         |   2 +-
 sound/soc/fsl/fsl-asoc-card.c                      |   3 +-
 sound/soc/fsl/fsl_sai.h                            |   4 +-
 sound/soc/fsl/imx-card.c                           |  17 +-
 sound/soc/fsl/imx-hdmi.c                           |   1 +
 sound/soc/fsl/imx-sgtl5000.c                       |  18 +-
 sound/soc/fsl/imx-spdif.c                          |   4 +-
 sound/soc/intel/boards/bytcr_rt5640.c              |  12 +
 sound/soc/mediatek/mt2701/mt2701-wm8960.c          |   9 +-
 sound/soc/mediatek/mt8173/mt8173-max98090.c        |   5 +-
 sound/soc/mxs/mxs-saif.c                           |   1 +
 sound/soc/samsung/aries_wm8994.c                   |  17 +-
 sound/soc/samsung/arndale.c                        |   5 +-
 sound/soc/samsung/littlemill.c                     |   5 +-
 sound/soc/samsung/lowland.c                        |   5 +-
 sound/soc/samsung/odroid.c                         |   4 +-
 sound/soc/samsung/smdk_wm8994.c                    |   4 +-
 sound/soc/samsung/smdk_wm8994pcm.c                 |   4 +-
 sound/soc/samsung/snow.c                           |   9 +-
 sound/soc/samsung/speyside.c                       |   5 +-
 sound/soc/samsung/tm2_wm5110.c                     |   3 +-
 sound/soc/samsung/tobermory.c                      |   5 +-
 sound/soc/sh/rcar/core.c                           |  15 +-
 sound/soc/sh/rcar/dma.c                            |   9 +-
 sound/soc/sh/rcar/rsnd.h                           |   2 +-
 sound/soc/sh/rcar/src.c                            |   7 +-
 sound/soc/sh/rcar/ssi.c                            |  14 +-
 sound/soc/sh/rcar/ssiu.c                           |  11 +-
 sound/soc/sh/rz-ssi.c                              |  29 +-
 sound/soc/soc-dapm.c                               |   2 -
 sound/soc/ti/j721e-evm.c                           |  44 +-
 sound/usb/clock.c                                  |  11 +
 sound/usb/implicit.c                               |  10 +-
 sound/usb/midi.c                                   |   3 +
 sound/usb/pcm.c                                    |  22 +-
 sound/usb/quirks-table.h                           |  10 +-
 sound/usb/quirks.c                                 |   8 +
 sound/usb/usbaudio.h                               |   6 +
 tools/arch/x86/include/asm/cpufeatures.h           |   1 +
 tools/arch/x86/include/asm/msr-index.h             |  25 +
 .../test-libbpf-btf__load_from_kernel_by_id.c      |   5 +-
 tools/lib/bpf/libbpf.c                             |  20 +-
 tools/objtool/check.c                              |   9 +-
 tools/objtool/elf.c                                | 198 ++++--
 tools/objtool/include/objtool/elf.h                |   4 +-
 tools/perf/Makefile.config                         |  39 +-
 tools/perf/builtin-c2c.c                           |  10 +-
 tools/perf/pmu-events/jevents.c                    |   2 +-
 tools/perf/util/data.h                             |   1 +
 tools/power/x86/turbostat/turbostat.c              |   1 +
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/arm64/bti/Makefile         |   4 +-
 tools/testing/selftests/bpf/Makefile               |   2 +-
 .../bpf/progs/btf_dump_test_case_syntax.c          |   2 +-
 tools/testing/selftests/bpf/progs/profiler.inc.h   |   5 +-
 .../selftests/bpf/progs/test_stacktrace_build_id.c |  12 +-
 .../selftests/bpf/test_bpftool_synctypes.py        |   2 +-
 tools/testing/selftests/cgroup/test_stress.sh      |   2 +-
 tools/testing/selftests/landlock/base_test.c       | 177 +++--
 tools/testing/selftests/landlock/common.h          |  66 +-
 tools/testing/selftests/landlock/fs_test.c         | 753 ++++++++++++++-------
 tools/testing/selftests/landlock/ptrace_test.c     |  40 +-
 .../testing/selftests/net/forwarding/tc_police.sh  |  52 ++
 tools/testing/selftests/netfilter/nft_nat.sh       |  43 ++
 tools/testing/selftests/resctrl/fill_buf.c         |   4 +-
 1139 files changed, 10759 insertions(+), 5686 deletions(-)
---
