Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B4F4CB3F3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiCCBCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiCCBCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:02:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F008567E;
        Wed,  2 Mar 2022 17:01:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1D9261150;
        Thu,  3 Mar 2022 01:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA25C004E1;
        Thu,  3 Mar 2022 01:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646269313;
        bh=8eJ5dsYFEqrrmSaPd47mfiFTNIwI5E+294zlQb/oVYo=;
        h=Date:From:To:Subject:From;
        b=oL6ge7T++sJ80/m0eWOnBMmFlrd5IHjOZMXVxAlOCRlIK4S5K4nX0Pt45qN3Xsy4f
         2Gm1RG7MIiEI9zlADhrd77pOOz++65S6eW4+U69qK/m6P+bei5niaA3MdQNhfWH8Qd
         qXoFquG7ygLYbdNlDm4S9yQfippUxIVQEHDDnwjuelv9l/Fdw45uxEUMK3zODeV7A6
         9d+OnhQ8QnDbdkdkYudZq0YaOcfqIIn7NwkOlh6yNpVGw6RWxtg+bG6IUcJPeaFlCa
         Xi3X9x2XezVmT0KdGeIbIkUboHqyPLzdvpGZKhACxUwP8ONtBiLhD3Bpy+arH7ve/a
         0v8ee+MTl9Lig==
Date:   Wed, 2 Mar 2022 17:01:50 -0800
From:   Mark Gross <markgross@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Danie l Wagner <dwagner@suse.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.9.303-rt192
Message-ID: <164626921948.142702.10764904755345048851@T470>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.303-rt192 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 5fdd70d020370e5cd9bfbbb45b25c89ee74bbc70

Or to build 4.9.303-rt192 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.303.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.303-rt192.patch.xz


You can also build from 4.9.297-rt191 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.297-rt191-rt192.patch.xz

Signing key fingerprint:

  A073 BC64 746A 086C DA24  97C8 F92D 73C9 A31A 1C17

Enjoy!
Mark Gross

Changes from v4.9.297-rt191:
---

Alan Stern (4):
      USB: core: Fix bug in resuming hub's handling of wakeup requests
      USB: Fix "slab-out-of-bounds Write" bug in usb_hcd_poll_rh_status
      usb-storage: Add unusual-devs entry for VL817 USB-SATA bridge
      USB: core: Fix hang in usb_kill_urb by adding memory barriers

Alexander Aring (1):
      fs: dlm: filter user dlm messages for kernel locks

Amelie Delaunay (1):
      usb: dwc2: gadget: don't try to disable ep0 in dwc2_hsotg_suspend

Amir Goldstein (1):
      fuse: fix live lock in fuse_iget()

Andy Shevchenko (1):
      mfd: intel-lpss: Fix too early PM enablement in the ACPI ->probe()

Andy Spencer (1):
      gianfar: simplify FCS handling and fix memory leak

Antoine Tenart (2):
      net: do not keep the dst cache when uncloning an skb dst and its metadata
      net: fix a memleak when uncloning an skb dst and its metadata

Armin Wolf (1):
      hwmon: (dell-smm) Speed up setting of fan speed

Arnd Bergmann (2):
      dmaengine: pxa/mmp: stop referencing config->slave_id
      HID: wacom: add USB_HID dependency

Avihai Horon (1):
      RDMA/core: Let ib_find_gid() continue search even after empty entry

Bart Van Assche (1):
      scsi: ufs: Fix race conditions related to driver data

Ben Hutchings (1):
      Revert "gup: document and work around "COW can break either way" issue"

Benjamin Gaignard (1):
      spi: mediatek: Avoid NULL pointer crash in interrupt

Bixuan Cui (1):
      ALSA: oss: fix compile error when OSS_DEBUG is enabled

Brian Gix (1):
      Bluetooth: refactor malicious adv data check

Brian Silverman (1):
      can: gs_usb: gs_can_start_xmit(): zero-initialize hf->{flags,reserved}

Bryan O'Donoghue (1):
      wcn36xx: Indicate beacon not connection loss on MISSED_BEACON_IND

Cameron Williams (2):
      tty: Add support for Brainboxes UC cards.
      USB: serial: ftdi_sio: add support for Brainboxes US-159/235/320

Chengfeng Ye (2):
      crypto: qce - fix uaf on qce_ahash_register_one
      HSI: core: Fix return freed object in hsi_new_client

Chengguang Xu (1):
      RDMA/rxe: Fix a typo in opcode name

Christian König (1):
      drm/radeon: fix error handling in radeon_driver_open_kms

Christoph Hellwig (1):
      scsi: sr: Don't use GFP_DMA

Christophe Leroy (2):
      w1: Misuse of get_user()/put_user() reported by sparse
      powerpc/32: Fix boot failure with GCC latent entropy plugin

Chuck Lever (1):
      NFSD: Clamp WRITE offsets

Congyu Liu (1):
      net: fix information leakage in /proc/net/ptype

Dai Ngo (1):
      nfsd: nfsd4_setclientid_confirm mistakenly expires confirmed client.

Dan Carpenter (1):
      media: firewire: firedtv-avc: fix a buffer overflow in avc_ca_pmt()

Daniel Borkmann (1):
      bpf: Add kconfig knob for disabling unpriv bpf by default

Daniel Rosenberg (2):
      ion: Fix use after free during ION_IOC_ALLOC
      ion: Protect kref from userspace manipulation

Darrick J. Wong (2):
      vfs: make freeze_super abort when sync_filesystem returns error
      quota: make dquot_quota_sync return errors from ->sync_fs

Dave Airlie (1):
      drm/ttm/nouveau: don't call tt destroy callback on alloc failure.

Davidlohr Bueso (2):
      rbtree: cache leftmost node internally
      lib/timerqueue: Rely on rbtree semantics for next timer

Dmitry Baryshkov (1):
      arm64: dts: qcom: msm8916: fix MMC controller aliases

Dominik Brodowski (1):
      pcmcia: fix setting of kthread task states

Duoming Zhou (1):
      ax25: improve the incomplete fix to avoid UAF and NPD bugs

Dāvis Mosāns (1):
      btrfs: send: in case of IO error log it

Eliav Farber (1):
      EDAC: Fix calculation of returned address and next offset in edac_align_ptr()

Eric Biggers (2):
      random: fix data race on crng_node_pool
      random: fix data race on crng init time

Eric Dumazet (10):
      ppp: ensure minimum packet size in ppp_write()
      af_unix: annote lockless accesses to unix_tot_inflight & gc_in_progress
      netns: add schedule point in ops_exit_list()
      ipv4: avoid using shared IP generator for connected sockets
      ipv4: raw: lock the socket in raw_bind()
      ipv4: tcp: send zero IPID in SYNACK messages
      rtnetlink: make sure to refresh master_dev/m_ops in __rtnl_newlink()
      af_packet: fix data-race in packet_setsockopt / packet_setsockopt
      ipmr,ip6mr: acquire RTNL before calling ip[6]mr_free_table() on failure path
      drop_monitor: fix data-race in dropmon_net_event / trace_napi_poll_hit

Eric W. Biederman (2):
      cgroup-v1: Require capabilities to set release_agent
      taskstats: Cleanup the use of task->exit_code

Fabio Estevam (2):
      ARM: dts: imx23-evk: Remove MX23_PAD_SSP1_DETECT from hog group
      ARM: dts: imx6qdl-udoo: Properly describe the SD card detect

Florian Fainelli (1):
      net: mdio: Demote probed message to debug print

Florian Westphal (3):
      netfilter: bridge: add support for pppoe filtering
      netfilter: nat: remove l4 protocol port rovers
      netfilter: nat: limit port clash resolution attempts

Gang Li (1):
      shmem: fix a race between shmem_unused_huge_shrink and shmem_evict_inode

Georgi Valkov (1):
      ipheth: fix EOVERFLOW in ipheth_rcvbulk_callback

Greg Kroah-Hartman (9):
      Linux 4.9.298
      Linux 4.9.299
      PM: wakeup: simplify the output logic of pm_show_wakelocks()
      Linux 4.9.300
      moxart: fix potential use-after-free on remove path
      Linux 4.9.301
      usb: gadget: rndis: check size of RNDIS_MSG_SET command
      Linux 4.9.302
      Linux 4.9.303

Guenter Roeck (1):
      hwmon: (lm90) Reduce maximum conversion rate for G781

Guillaume Bertholon (4):
      Input: i8042 - Fix misplaced backport of "add ASUS Zenbook Flip to noselftest list"
      serial: sh-sci: Fix misplaced backport of "Fix late enablement of AUTORTS"
      ALSA: line6: Fix misplaced backport of "Fix wrong altsetting for LINE6_PODHD500_1"
      Revert "net: axienet: Wait for PhyRstCmplt after core reset"

Guillaume Nault (2):
      libcxgb: Don't accidentally set RTO_ONLINK in cxgb_find_route()
      xfrm: Don't accidentally set RTO_ONLINK in decode_session4()

Hans de Goede (1):
      gpiolib: acpi: Do not set the IRQ type if the IRQ is already in use

Heiner Kallweit (1):
      i2c: i801: Don't silently correct invalid transfer size

Ido Schimmel (1):
      ipv6_tunnel: Rate limit warning messages

Ilan Peer (1):
      iwlwifi: mvm: Increase the scan timeout guard to 30 seconds

JaeSang Yoo (1):
      tracing: Fix tp_printk option related with tp_printk_stop_on_boot

Jakob Koschel (2):
      vt_ioctl: fix array_index_nospec in vt_setactivate
      vt_ioctl: add array_index_nospec to VT_ACTIVATE

Jan Kara (3):
      ext4: avoid trim error on fs with small groups
      udf: Restore i_lenAlloc when inode expansion fails
      udf: Fix NULL ptr deref when converting from inline format

Jann Horn (2):
      HID: uhid: Fix worker destroying device without any protection
      net: usb: ax88179_178a: Fix out-of-bounds accesses in RX fixup

Jason Gerecke (1):
      HID: wacom: Avoid using stale array indicies to read contact count

Jianguo Wu (1):
      net-procfs: show net devices bound packet types

Jiasheng Jiang (3):
      fsl/fman: Check for null pointer after calling devm_ioremap
      can: xilinx_can: xcan_probe(): check for error irq
      ASoC: samsung: idma: Check of ioremap return value

Jim Mattson (1):
      KVM: x86/pmu: Use AMD64_RAW_EVENT_MASK for PERF_TYPE_RAW

Joakim Tjernlund (1):
      i2c: mpc: Correct I2C reset procedure

Joe Thornber (2):
      dm btree: add a defensive bounds check to insert_at()
      dm space map common: add bounds check to sm_ll_lookup_bitmap()

Joerg Roedel (1):
      iommu/amd: Fix loop timeout issue in iommu_ga_log_enable()

Johan Hovold (13):
      Bluetooth: bfusb: fix division by zero in send path
      media: uvcvideo: fix division by zero at stream start
      media: flexcop-usb: fix control-message timeouts
      media: mceusb: fix control-message timeouts
      media: em28xx: fix control-message timeouts
      media: cpia2: fix control-message timeouts
      media: s2255: fix control-message timeouts
      media: redrat3: fix control-message timeouts
      media: pvrusb2: fix control-message timeouts
      media: stk1160: fix control-message timeouts
      can: softing_cs: softingcs_probe(): fix memleak on registration failure
      USB: serial: cp210x: add NCR Retail IO box id
      USB: serial: cp210x: add CPI Bulk Coin Recycler id

Johannes Berg (2):
      iwlwifi: mvm: synchronize with FW after multicast commands
      iwlwifi: pcie: fix locking when "HW not ready"

John David Anglin (3):
      parisc: Avoid calling faulthandler_disabled() twice
      parisc: Fix data TLB miss in sba_unmap_sg
      parisc: Fix sglist access in ccio-dma.c

John Meneghini (2):
      scsi: bnx2fc: Flush destroy_work queue before calling bnx2fc_interface_put()
      scsi: bnx2fc: Make bnx2fc_recv_frame() mp safe

Jon Maloy (2):
      tipc: improve size validations for received domain records
      tipc: rate limit warning for received illegal binding update

Josef Bacik (2):
      btrfs: remove BUG_ON() in find_parent_nodes()
      btrfs: remove BUG_ON(!eie) in find_parent_nodes

José Expósito (1):
      HID: apple: Do not reset quirks when the Fn key is not found

Julia Lawall (4):
      powerpc/6xx: add missing of_node_put
      powerpc/powernv: add missing of_node_put
      powerpc/cell: add missing of_node_put
      powerpc/btext: add missing of_node_put

Kai-Heng Feng (1):
      usb: hub: Add delay for SuperSpeed hub resume to let links transit to U0

Kamal Dasu (1):
      spi: bcm-qspi: check for valid cs before applying chip select

Kamal Heib (2):
      RDMA/hns: Validate the pkey index
      RDMA/cxgb4: Set queue pair state when being queried

Kees Cook (2):
      char/mwave: Adjust io port register size
      libsubcmd: Fix use-after-free for realloc(..., 0)

Kevin Bracey (1):
      net_sched: restore "mpu xxx" handling

Krzysztof Kozlowski (1):
      nfc: llcp: fix NULL error pointer dereference on sendmsg() after failed bind()

Kyeong Yoo (1):
      jffs2: GC deadlock reading a page that is used in jffs2_write_begin()

Lai Jiangshan (1):
      KVM: X86: MMU: Use the correct inherited permissions to get shadow page

Lakshmi Sowjanya D (1):
      i2c: designware-pci: Fix to change data types of hcnt and lcnt parameters

Larry Finger (1):
      rtlwifi: rtl8192cu: Fix WARNING when calling local_irq_restore() with interrupts enabled

Lee Jones (1):
      ion: Do not 'put' ION handle until after its final use

Lino Sanfilippo (1):
      serial: amba-pl011: do not request memory region twice

Linus Torvalds (1):
      gup: document and work around "COW can break either way" issue

Lior Nahmanson (1):
      net: macsec: Verify that send_sci is on when setting Tx sci explicitly

Lukas Wunner (2):
      serial: pl010: Drop CR register reset on set_termios
      serial: core: Keep mctrl register state and cached copy in sync

Luís Henriques (1):
      ext4: set csum seed in tmp inode while migrating to extents

Mahesh Bandewar (1):
      bonding: pair enable_port with slave_arr_updates

Marc Kleine-Budde (2):
      can: gs_usb: fix use of uninitialized variable, detach device on reception of invalid USB data
      can: softing: softing_startstop(): fix set but not used variable warning

Mark Brown (5):
      ASoC: ops: Reject out of bounds values in snd_soc_put_volsw()
      ASoC: ops: Reject out of bounds values in snd_soc_put_volsw_sx()
      ASoC: ops: Reject out of bounds values in snd_soc_put_xr_sx()
      ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw()
      ASoC: ops: Fix stereo change notifications in snd_soc_put_volsw_range()

Mark Gross (2):
      Merge tag 'v4.9.303' into v4.9-rt
      Linux 4.9.303-rt192

Mateusz Jończyk (1):
      rtc: cmos: take rtc_lock while reading from CMOS

Matthias Schiffer (1):
      scripts/dtc: dtx_diff: remove broken example from help text

Mauro Carvalho Chehab (1):
      media: m920x: don't use stack on USB reads

Max Kellermann (1):
      lib/iov_iter: initialize "flags" in new pipe_buffer

Miaoqian Lin (4):
      spi: spi-meson-spifc: Add missing pm_runtime_disable() in meson_spifc_probe
      parisc: pdc_stable: Fix memory leak in pdcs_register_pathentries
      lib82596: Fix IRQ check in sni_82596_probe
      ASoC: fsl: Add missing error handling in pcm030_fabric_probe

Michael Braun (1):
      gianfar: fix jumbo packets+napi+rx overrun crash

Michael Ellerman (1):
      powerpc/smp: Move setup_profiling_timer() under CONFIG_PROFILING

Michael Kuron (1):
      media: dib0700: fix undefined behavior in tuner shutdown

Miklos Szeredi (1):
      fuse: fix bad inode

Miquel Raynal (2):
      net: ieee802154: Return meaningful error codes from the netlink helpers
      net: ieee802154: at86rf230: Stop leaking skb's

Nathan Chancellor (3):
      staging: wlan-ng: Avoid bitwise vs logical OR warning in hfa384x_usb_throttlefn()
      drm/i915: Avoid bitwise vs logical OR warning in snb_wm_latency_quirk()
      Makefile.extrawarn: Move -Wunaligned-access to W=1

Nicholas Bishop (1):
      drm/radeon: Fix backlight control on iMac 12,1

Nicholas Piggin (1):
      KVM: do not allow mapping valid but non-reference-counted pages

Nick Lopez (1):
      drm/nouveau: fix off by one in BIOS boundary checking

Olga Kornievskaia (2):
      NFSv4 only print the label when its queried
      NFSv4 remove zero number of fs_locations entries error check

Paolo Bonzini (2):
      KVM: do not assume PTE is writable after follow_pfn
      KVM: nVMX: fix EPT permissions as reported in exit qualification

Paul Moore (1):
      cipso,calipso: resolve a number of problems with the DOI refcounts

Pavankumar Kondeti (2):
      usb: gadget: f_fs: Use stream_open() for endpoint files
      usb: gadget: f_sourcesink: Fix isoc transfer for USB_SPEED_SUPER_PLUS

Pavel Skripkin (2):
      Bluetooth: stop proccessing malicious adv data
      net: mcs7830: handle usb read errors properly

Pawel Dembicki (1):
      USB: serial: option: add ZTE MF286D modem

Peiwei Hu (1):
      powerpc/prom_init: Fix improper check of prom_getprop()

Petr Cvachoucek (1):
      ubifs: Error path in ubifs_remount_rw() seems to wrongly free write buffers

Rafael J. Wysocki (2):
      ACPICA: Utilities: Avoid deleting the same object twice in a row
      ACPICA: Executer: Fix the REFCLASS_REFOF case in acpi_ex_opcode_1A_0T_1R()

Rafał Miłecki (1):
      i2c: brcmstb: fix support for DSL and CM variants

Raju Rangoju (1):
      net: amd-xgbe: ensure to reset the tx_timer_active flag

Randy Dunlap (4):
      mips: lantiq: add support for clk_set_parent()
      mips: bcm63xx: add support for clk_set_parent()
      um: registers: Rename function names to avoid conflicts and build problems
      serial: parisc: GSC: fix build when IOSAPIC is not set

Ritesh Harjani (1):
      ext4: fix error handling in ext4_restore_inline_data()

Riwen Lu (1):
      rtc: cmos: Evaluate century appropriate

Robert Hancock (2):
      net: axienet: Wait for PhyRstCmplt after core reset
      net: axienet: fix number of TX ring slots for available check

Robert Schlabbach (1):
      media: si2157: Fix "warm" tuner state detection

Ross Zwisler (1):
      mm: add follow_pte_pmd()

Sean Christopherson (1):
      KVM: Use kvm_pfn_t for local PFN variable in hva_to_pfn_remapped()

Sean Young (1):
      media: igorplugusb: receiver overflow should be reported

Sebastian Gottschall (1):
      ath10k: Fix tx hanging

Sergey Shtylyov (3):
      bcmgenet: add WOL IRQ check
      EDAC/altera: Fix deferred probing
      EDAC/xgene: Fix deferred probing

Seth Forshee (1):
      vsock: remove vsock from connected table when connect is interrupted by a signal

Shyam Sundar S K (1):
      net: amd-xgbe: Fix skb data length underflow

Slark Xiao (1):
      net: usb: qmi_wwan: Add support for Dell DW5829e

Stefan Agner (1):
      ARM: 8800/1: use choice for kernel unwinders

Stefan Berger (1):
      ima: Remove ima_policy file before directory

Steffen Maier (1):
      scsi: zfcp: Fix failed recovery on gone remote port with non-NPIV FCP devices

Stephan Brunner (1):
      USB: serial: ch341: add support for GW Instek USB2.0-Serial devices

Sunil Muthuswamy (1):
      vsock: correct removal of socket from the list

Suresh Kumar (1):
      net: bonding: debug: avoid printing debug logs when bond is not notifying peers

Szymon Heidrich (1):
      USB: gadget: validate interface OS descriptor requests

TATSUKAWA KOSUKE (立川 江介) (1):
      n_tty: wake up poll(POLLRDNORM) on receiving data

Takashi Iwai (6):
      ALSA: jack: Add missing rwsem around snd_ctl_remove() calls
      ALSA: PCM: Add missing rwsem around snd_ctl_remove() calls
      ALSA: hda: Add missing rwsem around snd_ctl_remove() calls
      ALSA: seq: Set upper limit of processed events
      ALSA: hda: Fix regression on forced probe mask option
      ALSA: hda: Fix missing codec probe on Shenker Dock 15

Tasos Sahanidis (1):
      floppy: Fix hang in watchdog when disk is ejected

Theodore Ts'o (1):
      ext4: don't use the orphan list when migrating an inode

Tianjia Zhang (1):
      MIPS: Octeon: Fix build errors using clang

Tobias Waldekranz (2):
      powerpc/fsl/dts: Enable WA for erratum A-009885 on fman3l MDIO buses
      net/fsl: xgmac_mdio: Fix incorrect iounmap when removing module

Trond Myklebust (6):
      NFSv4: Initialise connection to the server in nfs4_alloc_client()
      NFSv4: Handle case where the lookup of a directory fails
      NFSv4: nfs_atomic_open() can race when looking up a non-regular file
      NFS: Fix initialisation of nfs_client cl_flags field
      NFS: LOOKUP_DIRECTORY is also ok with symlinks
      NFS: Do not report writeback errors in nfs_getattr()

Tudor Ambarus (6):
      tty: serial: atmel: Check return code of dmaengine_submit()
      tty: serial: atmel: Call dma_async_issue_pending()
      dmaengine: at_xdmac: Don't start transactions at tx_submit level
      dmaengine: at_xdmac: Print debug message after realeasing the lock
      dmaengine: at_xdmac: Fix lld view setting
      dmaengine: at_xdmac: Fix at_xdmac_lld struct definition

Tvrtko Ursulin (1):
      drm/i915: Flush TLBs before releasing backing store

Tzung-Bi Shih (1):
      ASoC: mediatek: mt8173: fix device_node leak

Udipto Goswami (1):
      usb: dwc3: gadget: Prevent core from processing stale TRBs

Uwe Kleine-König (1):
      staging: fbtft: Fix error path in fbtft_driver_module_init()

Valentin Caron (1):
      serial: stm32: fix software flow control transfer

Vasily Gorbik (1):
      s390/hypfs: include z/VM guests with access control group set

Wang Hai (3):
      Bluetooth: cmtp: fix possible panic when cmtp_init_sockets() fails
      media: dmxdev: fix UAF when dvb_register_device() fails
      media: msi001: fix possible null-ptr-deref in msi001_probe()

Wei Yongjun (3):
      usb: ftdi-elan: fix memory leak on device disconnect
      misc: lattice-ecp3-config: Fix task hung when firmware load failed
      Bluetooth: Fix debugfs entry leak in hci_register_dev()

Xianting Tian (1):
      drm/msm: Fix wrong size calculation

Xiaoke Wang (2):
      integrity: check the return value of audit_log_start()
      nfs: nfs4clinet: check the return value of kstrdup()

Xiongwei Song (1):
      floppy: Add max size check for user space request

Yang Xu (3):
      selftests/zram: Skip max_comp_streams interface on newer kernel
      selftests/zram01.sh: Fix compression ratio calculation
      selftests/zram: Adapt the situation that /dev/zram0 is being used

Yauhen Kharuzhy (1):
      power: bq25890: Enable continuous conversion for ADC at charging

Ye Bin (1):
      ext4: Fix BUG_ON in ext4_bread when write quota data

Yifeng Li (1):
      PCI: Add function 1 DMA alias quirk for Marvell 88SE9125 SATA controller

Yixing Liu (1):
      RDMA/hns: Modify the mapping attribute of doorbell to device

Zekun Shen (3):
      ar5523: Fix null-ptr-deref with unexpected WDCMSG_TARGET_START reply
      mwifiex: Fix skb_over_panic in mwifiex_usb_recv()
      ath9k: Fix out-of-bound memcpy in ath9k_hif_usb_rx_stream

Zheyu Ma (1):
      media: b2c2: Add missing check in flexcop_pci_isr:

Zhou Qingyang (8):
      drm/amdgpu: Fix a NULL pointer dereference in amdgpu_connector_lcd_native_mode()
      drm/radeon/radeon_kms: Fix a NULL pointer dereference in radeon_driver_open_kms()
      media: dib8000: Fix a memleak in dib8000_init()
      media: saa7146: mxb: Fix a NULL pointer dereference in mxb_attach()
      pcmcia: rsrc_nonstatic: Fix a NULL pointer dereference in __nonstatic_find_io_region()
      pcmcia: rsrc_nonstatic: Fix a NULL pointer dereference in nonstatic_find_mem_region()
      media: saa7146: hexium_orion: Fix a NULL pointer dereference in hexium_attach()
      media: saa7146: hexium_gemini: Fix a NULL pointer dereference in hexium_attach()

Ziyang Xuan (1):
      can: bcm: fix UAF of bcm op

Zoltán Böszörményi (1):
      ata: libata-core: Disable TRIM on M88V29

ZouMingzhe (1):
      scsi: target: iscsi: Make sure the np under each tpg is unique

daniel.starke@siemens.com (1):
      tty: n_gsm: fix SW flow control encoding/handling
---
Documentation/rbtree.txt                           |  33 +++++
 Documentation/sysctl/kernel.txt                    |  21 ++++
 Documentation/virtual/kvm/mmu.txt                  |   4 +-
 Makefile                                           |   2 +-
 arch/arm/Kconfig.debug                             |  44 ++++---
 arch/arm/boot/dts/imx23-evk.dts                    |   1 -
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |   5 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   4 +-
 arch/mips/bcm63xx/clk.c                            |   6 +
 arch/mips/include/asm/octeon/cvmx-bootinfo.h       |   4 +-
 arch/mips/lantiq/clk.c                             |   6 +
 arch/mips/mm/gup.c                                 |   9 +-
 arch/parisc/kernel/traps.c                         |   2 +-
 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi      |   2 +
 arch/powerpc/kernel/Makefile                       |   1 +
 arch/powerpc/kernel/btext.c                        |   4 +-
 arch/powerpc/kernel/prom_init.c                    |   2 +-
 arch/powerpc/kernel/smp.c                          |   2 +
 arch/powerpc/lib/Makefile                          |   3 +
 arch/powerpc/platforms/cell/iommu.c                |   1 +
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |   1 +
 arch/powerpc/platforms/powernv/opal-lpc.c          |   1 +
 arch/s390/hypfs/hypfs_vm.c                         |   6 +-
 arch/s390/mm/gup.c                                 |   9 +-
 arch/sh/mm/gup.c                                   |   9 +-
 arch/sparc/mm/gup.c                                |   9 +-
 arch/um/include/shared/registers.h                 |   4 +-
 arch/um/os-Linux/registers.c                       |   4 +-
 arch/um/os-Linux/start_up.c                        |   2 +-
 arch/x86/kvm/paging_tmpl.h                         |  44 ++++---
 arch/x86/kvm/pmu.c                                 |   2 +-
 arch/x86/mm/gup.c                                  |   9 +-
 arch/x86/um/syscalls_64.c                          |   3 +-
 drivers/acpi/acpica/exoparg1.c                     |   3 +-
 drivers/acpi/acpica/utdelete.c                     |   1 +
 drivers/ata/libata-core.c                          |   1 +
 drivers/block/floppy.c                             |   6 +-
 drivers/bluetooth/bfusb.c                          |   3 +
 drivers/char/mwave/3780i.h                         |   2 +-
 drivers/char/random.c                              |  61 +++++-----
 drivers/crypto/qce/sha.c                           |   2 +-
 drivers/dma/at_xdmac.c                             |  32 +++--
 drivers/dma/mmp_pdma.c                             |   6 -
 drivers/dma/pxa_dma.c                              |   7 --
 drivers/edac/altera_edac.c                         |   2 +-
 drivers/edac/edac_mc.c                             |   2 +-
 drivers/edac/xgene_edac.c                          |   2 +-
 drivers/gpio/gpiolib-acpi.c                        |  15 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |   6 +
 drivers/gpu/drm/i915/i915_drv.h                    |   5 +-
 drivers/gpu/drm/i915/i915_gem.c                    |  72 +++++++++++
 drivers/gpu/drm/i915/i915_gem_gtt.c                |   4 +
 drivers/gpu/drm/i915/i915_reg.h                    |   6 +
 drivers/gpu/drm/i915/intel_pm.c                    |   6 +-
 drivers/gpu/drm/msm/msm_drv.c                      |   2 +-
 drivers/gpu/drm/nouveau/nouveau_sgdma.c            |   9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/base.c    |   2 +-
 drivers/gpu/drm/radeon/atombios_encoders.c         |   3 +-
 drivers/gpu/drm/radeon/radeon_kms.c                |  42 ++++---
 drivers/gpu/drm/ttm/ttm_tt.c                       |   2 -
 drivers/hid/Kconfig                                |   2 +-
 drivers/hid/hid-apple.c                            |   2 +-
 drivers/hid/uhid.c                                 |  29 ++++-
 drivers/hid/wacom_wac.c                            |   4 +
 drivers/hsi/hsi_core.c                             |   1 +
 drivers/hwmon/dell-smm-hwmon.c                     |  12 +-
 drivers/hwmon/lm90.c                               |   2 +-
 drivers/i2c/busses/i2c-brcmstb.c                   |   2 +-
 drivers/i2c/busses/i2c-designware-pcidrv.c         |   8 +-
 drivers/i2c/busses/i2c-i801.c                      |  15 +--
 drivers/i2c/busses/i2c-mpc.c                       |  23 ++--
 drivers/infiniband/core/device.c                   |   3 +-
 drivers/infiniband/hw/cxgb4/qp.c                   |   1 +
 drivers/infiniband/hw/hns/hns_roce_main.c          |   5 +-
 drivers/infiniband/sw/rxe/rxe_opcode.c             |   2 +-
 drivers/input/serio/i8042-x86ia64io.h              |  11 +-
 drivers/iommu/amd_iommu_init.c                     |   2 +
 drivers/md/persistent-data/dm-btree.c              |   8 +-
 drivers/md/persistent-data/dm-space-map-common.c   |   5 +
 drivers/media/common/saa7146/saa7146_fops.c        |   2 +-
 drivers/media/dvb-core/dmxdev.c                    |  18 ++-
 drivers/media/dvb-frontends/dib8000.c              |   4 +-
 drivers/media/firewire/firedtv-avc.c               |  14 ++-
 drivers/media/firewire/firedtv-ci.c                |   2 +
 drivers/media/pci/b2c2/flexcop-pci.c               |   3 +
 drivers/media/pci/saa7146/hexium_gemini.c          |   7 +-
 drivers/media/pci/saa7146/hexium_orion.c           |   8 +-
 drivers/media/pci/saa7146/mxb.c                    |   8 +-
 drivers/media/rc/igorplugusb.c                     |   4 +-
 drivers/media/rc/mceusb.c                          |   8 +-
 drivers/media/rc/redrat3.c                         |  22 ++--
 drivers/media/tuners/msi001.c                      |   7 ++
 drivers/media/tuners/si2157.c                      |   2 +-
 drivers/media/usb/b2c2/flexcop-usb.c               |  10 +-
 drivers/media/usb/b2c2/flexcop-usb.h               |  12 +-
 drivers/media/usb/cpia2/cpia2_usb.c                |   4 +-
 drivers/media/usb/dvb-usb/dib0700_core.c           |   2 -
 drivers/media/usb/dvb-usb/m920x.c                  |  12 +-
 drivers/media/usb/em28xx/em28xx-core.c             |   4 +-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c            |   8 +-
 drivers/media/usb/s2255/s2255drv.c                 |   4 +-
 drivers/media/usb/stk1160/stk1160-core.c           |   4 +-
 drivers/media/usb/uvc/uvc_video.c                  |   4 +
 drivers/mfd/intel-lpss-acpi.c                      |   7 +-
 drivers/misc/lattice-ecp3-config.c                 |  12 +-
 drivers/mmc/host/moxart-mmc.c                      |   2 +-
 drivers/net/bonding/bond_3ad.c                     |   3 +-
 drivers/net/bonding/bond_main.c                    |   6 +-
 drivers/net/can/softing/softing_cs.c               |   2 +-
 drivers/net/can/softing/softing_fw.c               |  11 +-
 drivers/net/can/usb/gs_usb.c                       |   5 +-
 drivers/net/can/xilinx_can.c                       |   7 +-
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |  14 ++-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  10 +-
 drivers/net/ethernet/chelsio/libcxgb/libcxgb_cm.c  |   3 +-
 drivers/net/ethernet/freescale/fman/mac.c          |  21 +++-
 drivers/net/ethernet/freescale/gianfar.c           |  38 +++---
 drivers/net/ethernet/freescale/xgmac_mdio.c        |   3 +-
 drivers/net/ethernet/i825xx/sni_82596.c            |   3 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   4 +-
 drivers/net/ieee802154/at86rf230.c                 |  13 +-
 drivers/net/macsec.c                               |   9 ++
 drivers/net/phy/mdio_bus.c                         |   2 +-
 drivers/net/ppp/ppp_generic.c                      |   7 +-
 drivers/net/usb/ax88179_178a.c                     |  68 ++++++-----
 drivers/net/usb/ipheth.c                           |   6 +-
 drivers/net/usb/mcs7830.c                          |  12 +-
 drivers/net/usb/qmi_wwan.c                         |   2 +
 drivers/net/wireless/ath/ar5523/ar5523.c           |   4 +
 drivers/net/wireless/ath/ath10k/htt_tx.c           |   3 +
 drivers/net/wireless/ath/ath10k/txrx.c             |   2 -
 drivers/net/wireless/ath/ath9k/hif_usb.c           |   7 ++
 drivers/net/wireless/ath/wcn36xx/smd.c             |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  17 +++
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   3 +-
 drivers/net/wireless/marvell/mwifiex/usb.c         |   3 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/hw.c    |   1 +
 drivers/parisc/ccio-dma.c                          |   3 +-
 drivers/parisc/pdc_stable.c                        |   4 +-
 drivers/parisc/sba_iommu.c                         |   3 +-
 drivers/pci/quirks.c                               |   3 +
 drivers/pcmcia/cs.c                                |   8 +-
 drivers/pcmcia/rsrc_nonstatic.c                    |   6 +
 drivers/power/supply/bq25890_charger.c             |   4 +-
 drivers/rtc/rtc-cmos.c                             |   3 +
 drivers/rtc/rtc-mc146818-lib.c                     |   2 +-
 drivers/s390/scsi/zfcp_fc.c                        |  13 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  |  41 +++----
 drivers/scsi/sr.c                                  |   2 +-
 drivers/scsi/sr_vendor.c                           |   4 +-
 drivers/scsi/ufs/tc-dwc-g210-pci.c                 |   1 -
 drivers/scsi/ufs/ufshcd-pltfrm.c                   |   2 -
 drivers/scsi/ufs/ufshcd.c                          |   7 ++
 drivers/spi/spi-bcm-qspi.c                         |   2 +-
 drivers/spi/spi-meson-spifc.c                      |   1 +
 drivers/spi/spi-mt65xx.c                           |   2 +-
 drivers/staging/android/ion/ion-ioctl.c            |  96 +++++++++++++--
 drivers/staging/android/ion/ion.c                  |  19 ++-
 drivers/staging/android/ion/ion.h                  |   4 +
 drivers/staging/android/ion/ion_priv.h             |   4 +
 drivers/staging/fbtft/fbtft.h                      |   5 +-
 drivers/staging/wlan-ng/hfa384x_usb.c              |  22 ++--
 drivers/target/iscsi/iscsi_target_tpg.c            |   3 +
 drivers/tty/n_gsm.c                                |   4 +-
 drivers/tty/n_tty.c                                |   4 +-
 drivers/tty/serial/8250/8250_gsc.c                 |   2 +-
 drivers/tty/serial/8250/8250_pci.c                 | 100 ++++++++++++++-
 drivers/tty/serial/amba-pl010.c                    |   3 -
 drivers/tty/serial/amba-pl011.c                    |  27 +----
 drivers/tty/serial/atmel_serial.c                  |  14 +++
 drivers/tty/serial/serial_core.c                   |   3 +-
 drivers/tty/serial/sh-sci.c                        |   8 +-
 drivers/tty/serial/stm32-usart.c                   |   2 +-
 drivers/tty/vt/vt_ioctl.c                          |   5 +-
 drivers/usb/core/hcd.c                             |  23 +++-
 drivers/usb/core/hub.c                             |   7 +-
 drivers/usb/core/urb.c                             |  12 ++
 drivers/usb/dwc2/gadget.c                          |   2 +-
 drivers/usb/dwc3/gadget.c                          |  13 ++
 drivers/usb/gadget/composite.c                     |   3 +
 drivers/usb/gadget/function/f_fs.c                 |   4 +-
 drivers/usb/gadget/function/f_sourcesink.c         |   1 +
 drivers/usb/gadget/function/rndis.c                |   9 +-
 drivers/usb/misc/ftdi-elan.c                       |   1 +
 drivers/usb/serial/ch341.c                         |   1 +
 drivers/usb/serial/cp210x.c                        |   2 +
 drivers/usb/serial/ftdi_sio.c                      |   3 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   3 +
 drivers/usb/serial/option.c                        |   2 +
 drivers/usb/storage/unusual_devs.h                 |  10 ++
 drivers/w1/slaves/w1_ds28e04.c                     |  26 +---
 fs/btrfs/backref.c                                 |  21 +++-
 fs/btrfs/send.c                                    |   4 +
 fs/dlm/lock.c                                      |   9 ++
 fs/ext4/inline.c                                   |  10 +-
 fs/ext4/ioctl.c                                    |   2 -
 fs/ext4/mballoc.c                                  |   8 ++
 fs/ext4/migrate.c                                  |  23 ++--
 fs/ext4/super.c                                    |   2 +-
 fs/fuse/acl.c                                      |   6 +
 fs/fuse/dir.c                                      |  40 +++++-
 fs/fuse/file.c                                     |  27 +++--
 fs/fuse/fuse_i.h                                   |  13 ++
 fs/fuse/inode.c                                    |   2 +-
 fs/fuse/xattr.c                                    |   9 ++
 fs/jffs2/file.c                                    |  40 +++---
 fs/nfs/client.c                                    |   2 +-
 fs/nfs/dir.c                                       |  18 +++
 fs/nfs/inode.c                                     |   9 +-
 fs/nfs/nfs4client.c                                |  87 ++++++-------
 fs/nfs/nfs4state.c                                 |   3 +
 fs/nfs/nfs4xdr.c                                   |   9 +-
 fs/nfsd/nfs3proc.c                                 |   5 +
 fs/nfsd/nfs4proc.c                                 |   5 +-
 fs/nfsd/nfs4state.c                                |   4 +-
 fs/quota/dquot.c                                   |  11 +-
 fs/super.c                                         |  19 +--
 fs/ubifs/super.c                                   |   1 -
 fs/udf/inode.c                                     |   9 +-
 include/linux/mm.h                                 |   2 +
 include/linux/netdevice.h                          |   1 +
 include/linux/rbtree.h                             |  21 ++++
 include/linux/rbtree_augmented.h                   |  33 ++++-
 include/linux/timerqueue.h                         |  13 +-
 include/net/dst_metadata.h                         |  14 ++-
 include/net/ip.h                                   |  21 ++--
 include/net/netfilter/nf_nat_l4proto.h             |   2 +-
 include/net/sch_generic.h                          |   5 +
 init/Kconfig                                       |  10 ++
 kernel/bpf/syscall.c                               |   3 +-
 kernel/cgroup.c                                    |  26 ++++
 kernel/power/wakelock.c                            |  12 +-
 kernel/sysctl.c                                    |  29 ++++-
 kernel/trace/trace.c                               |   4 +
 kernel/tsacct.c                                    |   7 +-
 lib/Kconfig.debug                                  |   6 +-
 lib/iov_iter.c                                     |   2 +
 lib/rbtree.c                                       |  34 +++++-
 lib/timerqueue.c                                   |  31 ++---
 localversion-rt                                    |   2 +-
 mm/gup.c                                           |  22 ++--
 mm/memory.c                                        |  37 ++++--
 mm/shmem.c                                         |  37 +++---
 net/ax25/af_ax25.c                                 |   9 +-
 net/bluetooth/cmtp/core.c                          |   4 +-
 net/bluetooth/hci_core.c                           |   1 +
 net/bluetooth/hci_event.c                          |   8 +-
 net/bridge/br_netfilter_hooks.c                    |   7 +-
 net/can/bcm.c                                      |  20 +--
 net/core/drop_monitor.c                            |  11 +-
 net/core/net-procfs.c                              |  38 +++++-
 net/core/net_namespace.c                           |   4 +-
 net/core/rtnetlink.c                               |   6 +-
 net/ieee802154/nl802154.c                          |   8 +-
 net/ipv4/cipso_ipv4.c                              |  11 +-
 net/ipv4/ip_output.c                               |  11 +-
 net/ipv4/ipmr.c                                    |   2 +
 net/ipv4/raw.c                                     |   5 +-
 net/ipv4/xfrm4_policy.c                            |   3 +-
 net/ipv6/calipso.c                                 |  14 +--
 net/ipv6/ip6_tunnel.c                              |   8 +-
 net/ipv6/ip6mr.c                                   |   2 +
 net/netfilter/nf_nat_proto_common.c                |  36 ++++--
 net/netfilter/nf_nat_proto_dccp.c                  |   5 +-
 net/netfilter/nf_nat_proto_sctp.c                  |   5 +-
 net/netfilter/nf_nat_proto_tcp.c                   |   5 +-
 net/netfilter/nf_nat_proto_udp.c                   |   5 +-
 net/netfilter/nf_nat_proto_udplite.c               |   5 +-
 net/netlabel/netlabel_cipso_v4.c                   |   3 +
 net/nfc/llcp_sock.c                                |   5 +
 net/packet/af_packet.c                             |  10 +-
 net/sched/sch_generic.c                            |   1 +
 net/tipc/link.c                                    |   5 +-
 net/tipc/monitor.c                                 |   2 +
 net/tipc/name_distr.c                              |   2 +-
 net/unix/garbage.c                                 |  14 ++-
 net/unix/scm.c                                     |   6 +-
 net/vmw_vsock/af_vsock.c                           |  39 ++----
 scripts/Makefile.extrawarn                         |   1 +
 scripts/dtc/dtx_diff                               |   8 +-
 security/integrity/ima/ima_fs.c                    |   2 +-
 security/integrity/integrity_audit.c               |   2 +
 sound/core/jack.c                                  |   3 +
 sound/core/oss/pcm_oss.c                           |   2 +-
 sound/core/pcm.c                                   |   6 +-
 sound/core/seq/seq_queue.c                         |  14 ++-
 sound/pci/hda/hda_codec.c                          |   3 +
 sound/pci/hda/hda_intel.c                          |   5 +-
 sound/soc/fsl/pcm030-audio-fabric.c                |  11 +-
 sound/soc/mediatek/mt8173/mt8173-max98090.c        |   3 +
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c   |   2 +
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c   |   2 +
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          |   2 +
 sound/soc/samsung/idma.c                           |   2 +
 sound/soc/soc-ops.c                                |  58 +++++++--
 sound/usb/line6/podhd.c                            |   4 +-
 tools/lib/subcmd/subcmd-util.h                     |  11 +-
 tools/testing/selftests/zram/zram.sh               |  15 +--
 tools/testing/selftests/zram/zram01.sh             |  33 ++---
 tools/testing/selftests/zram/zram02.sh             |   1 -
 tools/testing/selftests/zram/zram_lib.sh           | 134 ++++++++++++++-------
 virt/kvm/kvm_main.c                                |  36 +++++-
 303 files changed, 2215 insertions(+), 984 deletions(-)
---
diff --git a/Documentation/rbtree.txt b/Documentation/rbtree.txt
index b9d9cc57be18..9fedfedfd85f 100644
--- a/Documentation/rbtree.txt
+++ b/Documentation/rbtree.txt
@@ -190,6 +190,39 @@ Example:
   for (node = rb_first(&mytree); node; node = rb_next(node))
 	printk("key=%s\n", rb_entry(node, struct mytype, node)->keystring);
 
+Cached rbtrees
+--------------
+
+Computing the leftmost (smallest) node is quite a common task for binary
+search trees, such as for traversals or users relying on a the particular
+order for their own logic. To this end, users can use 'struct rb_root_cached'
+to optimize O(logN) rb_first() calls to a simple pointer fetch avoiding
+potentially expensive tree iterations. This is done at negligible runtime
+overhead for maintanence; albeit larger memory footprint.
+
+Similar to the rb_root structure, cached rbtrees are initialized to be
+empty via:
+
+  struct rb_root_cached mytree = RB_ROOT_CACHED;
+
+Cached rbtree is simply a regular rb_root with an extra pointer to cache the
+leftmost node. This allows rb_root_cached to exist wherever rb_root does,
+which permits augmented trees to be supported as well as only a few extra
+interfaces:
+
+  struct rb_node *rb_first_cached(struct rb_root_cached *tree);
+  void rb_insert_color_cached(struct rb_node *, struct rb_root_cached *, bool);
+  void rb_erase_cached(struct rb_node *node, struct rb_root_cached *);
+
+Both insert and erase calls have their respective counterpart of augmented
+trees:
+
+  void rb_insert_augmented_cached(struct rb_node *node, struct rb_root_cached *,
+				  bool, struct rb_augment_callbacks *);
+  void rb_erase_augmented_cached(struct rb_node *, struct rb_root_cached *,
+				 struct rb_augment_callbacks *);
+
+
 Support for Augmented rbtrees
 -----------------------------
 
diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index ffab8b5caa60..30ba179392d8 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -90,6 +90,7 @@ show up in /proc/sys/kernel:
 - sysctl_writes_strict
 - tainted
 - threads-max
+- unprivileged_bpf_disabled
 - unknown_nmi_panic
 - watchdog
 - watchdog_thresh
@@ -995,6 +996,26 @@ available RAM pages threads-max is reduced accordingly.
 
 ==============================================================
 
+unprivileged_bpf_disabled:
+
+Writing 1 to this entry will disable unprivileged calls to bpf();
+once disabled, calling bpf() without CAP_SYS_ADMIN will return
+-EPERM. Once set to 1, this can't be cleared from the running kernel
+anymore.
+
+Writing 2 to this entry will also disable unprivileged calls to bpf(),
+however, an admin can still change this setting later on, if needed, by
+writing 0 or 1 to this entry.
+
+If BPF_UNPRIV_DEFAULT_OFF is enabled in the kernel config, then this
+entry will default to 2 instead of 0.
+
+  0 - Unprivileged calls to bpf() are enabled
+  1 - Unprivileged calls to bpf() are disabled without recovery
+  2 - Unprivileged calls to bpf() are disabled
+
+==============================================================
+
 unknown_nmi_panic:
 
 The value in this file affects behavior of handling NMI. When the
diff --git a/Documentation/virtual/kvm/mmu.txt b/Documentation/virtual/kvm/mmu.txt
index 481b6a9c25d5..16ddfd6bd6a1 100644
--- a/Documentation/virtual/kvm/mmu.txt
+++ b/Documentation/virtual/kvm/mmu.txt
@@ -152,8 +152,8 @@ Shadow pages contain the following information:
     shadow pages) so role.quadrant takes values in the range 0..3.  Each
     quadrant maps 1GB virtual address space.
   role.access:
-    Inherited guest access permissions in the form uwx.  Note execute
-    permission is positive, not negative.
+    Inherited guest access permissions from the parent ptes in the form uwx.
+    Note execute permission is positive, not negative.
   role.invalid:
     The page is invalid and should not be used.  It is a root page that is
     currently pinned (by a cpu hardware register pointing to it); once it is
diff --git a/Makefile b/Makefile
index 70a11157b240..27d5e129444e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION = 4
 PATCHLEVEL = 9
-SUBLEVEL = 297
+SUBLEVEL = 303
 EXTRAVERSION =
 NAME = Roaring Lionus
 
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index bb8f39fe3a22..8df8cdd093e9 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -15,30 +15,42 @@ config ARM_PTDUMP
 	  kernel.
 	  If in doubt, say "N"
 
-# RMK wants arm kernels compiled with frame pointers or stack unwinding.
-# If you know what you are doing and are willing to live without stack
-# traces, you can get a slightly smaller kernel by setting this option to
-# n, but then RMK will have to kill you ;).
-config FRAME_POINTER
-	bool
-	depends on !THUMB2_KERNEL
-	default y if !ARM_UNWIND || FUNCTION_GRAPH_TRACER
+choice
+	prompt "Choose kernel unwinder"
+	default UNWINDER_ARM if AEABI && !FUNCTION_GRAPH_TRACER
+	default UNWINDER_FRAME_POINTER if !AEABI || FUNCTION_GRAPH_TRACER
+	help
+	  This determines which method will be used for unwinding kernel stack
+	  traces for panics, oopses, bugs, warnings, perf, /proc/<pid>/stack,
+	  livepatch, lockdep, and more.
+
+config UNWINDER_FRAME_POINTER
+	bool "Frame pointer unwinder"
+	depends on !THUMB2_KERNEL && !CC_IS_CLANG
+	select ARCH_WANT_FRAME_POINTERS
+	select FRAME_POINTER
 	help
-	  If you say N here, the resulting kernel will be slightly smaller and
-	  faster. However, if neither FRAME_POINTER nor ARM_UNWIND are enabled,
-	  when a problem occurs with the kernel, the information that is
-	  reported is severely limited.
+	  This option enables the frame pointer unwinder for unwinding
+	  kernel stack traces.
 
-config ARM_UNWIND
-	bool "Enable stack unwinding support (EXPERIMENTAL)"
+config UNWINDER_ARM
+	bool "ARM EABI stack unwinder"
 	depends on AEABI
-	default y
+	select ARM_UNWIND
 	help
 	  This option enables stack unwinding support in the kernel
 	  using the information automatically generated by the
 	  compiler. The resulting kernel image is slightly bigger but
 	  the performance is not affected. Currently, this feature
-	  only works with EABI compilers. If unsure say Y.
+	  only works with EABI compilers.
+
+endchoice
+
+config ARM_UNWIND
+	bool
+
+config FRAME_POINTER
+	bool
 
 config OLD_MCOUNT
 	bool
diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 57e29977ba06..acaa3a7c2fc6 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -48,7 +48,6 @@
 						MX23_PAD_LCD_RESET__GPIO_1_18
 						MX23_PAD_PWM3__GPIO_1_29
 						MX23_PAD_PWM4__GPIO_1_30
-						MX23_PAD_SSP1_DETECT__SSP1_DETECT
 					>;
 					fsl,drive-strength = <MXS_DRIVE_4mA>;
 					fsl,voltage = <MXS_VOLTAGE_HIGH>;
diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index fc4ae2e423bd..b0fdcae66ead 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -9,6 +9,8 @@
  *
  */
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	aliases {
 		backlight = &backlight;
@@ -201,6 +203,7 @@
 				MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
 				MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
 				MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x1b0b0
 			>;
 		};
 
@@ -267,7 +270,7 @@
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3>;
-	non-removable;
+	cd-gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index c2557cf43b3d..d8bf83d732be 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -25,8 +25,8 @@
 	#size-cells = <2>;
 
 	aliases {
-		sdhc1 = &sdhc_1; /* SDC1 eMMC slot */
-		sdhc2 = &sdhc_2; /* SDC2 SD card slot */
+		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
 	};
 
 	chosen { };
diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 4f375050ab8e..3be875a45c83 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -342,6 +342,12 @@ struct clk *clk_get_parent(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_get_parent);
 
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_set_parent);
+
 unsigned long clk_get_rate(struct clk *clk)
 {
 	return clk->rate;
diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
index 62787765575e..ce6e5fddce0b 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
@@ -315,7 +315,7 @@ enum cvmx_chip_types_enum {
 
 /* Functions to return string based on type */
 #define ENUM_BRD_TYPE_CASE(x) \
-	case x: return(#x + 16);	/* Skip CVMX_BOARD_TYPE_ */
+	case x: return (&#x[16]);	/* Skip CVMX_BOARD_TYPE_ */
 static inline const char *cvmx_board_type_to_string(enum
 						    cvmx_board_types_enum type)
 {
@@ -404,7 +404,7 @@ static inline const char *cvmx_board_type_to_string(enum
 }
 
 #define ENUM_CHIP_TYPE_CASE(x) \
-	case x: return(#x + 15);	/* Skip CVMX_CHIP_TYPE */
+	case x: return (&#x[15]);	/* Skip CVMX_CHIP_TYPE */
 static inline const char *cvmx_chip_type_to_string(enum
 						   cvmx_chip_types_enum type)
 {
diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
index 149f0513c4f5..d1de57b86683 100644
--- a/arch/mips/lantiq/clk.c
+++ b/arch/mips/lantiq/clk.c
@@ -165,6 +165,12 @@ struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
 	return NULL;
 }
 
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_set_parent);
+
 static inline u32 get_counter_resolution(void)
 {
 	u32 res;
diff --git a/arch/mips/mm/gup.c b/arch/mips/mm/gup.c
index d8c3c159289a..71a19d20bbb7 100644
--- a/arch/mips/mm/gup.c
+++ b/arch/mips/mm/gup.c
@@ -271,7 +271,14 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
 			goto slow;
-		if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
+		/*
+		 * The FAST_GUP case requires FOLL_WRITE even for pure reads,
+		 * because get_user_pages() may need to cause an early COW in
+		 * order to avoid confusing the normal COW routines. So only
+		 * targets that are already writable are safe to do by just
+		 * looking at the page tables.
+		 */
+		if (!gup_pud_range(pgd, addr, next, 1, pages, &nr))
 			goto slow;
 	} while (pgdp++, addr = next, addr != end);
 	local_irq_enable();
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index 11c91697d5f9..5b41779de233 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -793,7 +793,7 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 	     * unless pagefault_disable() was called before.
 	     */
 
-	    if (fault_space == 0 && !faulthandler_disabled())
+	    if (faulthandler_disabled() || fault_space == 0)
 	    {
 		/* Clean up and return if in exception table. */
 		if (fixup_exception(regs))
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
index 7f60b6060176..39b1c1fa0c81 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
@@ -78,6 +78,7 @@ fman0: fman@400000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfc000 0x1000>;
+		fsl,erratum-a009885;
 	};
 
 	xmdio0: mdio@fd000 {
@@ -85,6 +86,7 @@ fman0: fman@400000 {
 		#size-cells = <0>;
 		compatible = "fsl,fman-memac-mdio", "fsl,fman-xmdio";
 		reg = <0xfd000 0x1000>;
+		fsl,erratum-a009885;
 	};
 
 	ptp_timer0: ptp-timer@fe000 {
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index d80fbf0884ff..bc6c85788b84 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -14,6 +14,7 @@ CFLAGS_prom_init.o      += -fPIC
 CFLAGS_btext.o		+= -fPIC
 endif
 
+CFLAGS_setup_32.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_cputable.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_prom_init.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
 CFLAGS_btext.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index 8275858a434d..2d91ba38b452 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -257,8 +257,10 @@ int __init btext_find_display(int allow_nonstdout)
 			rc = btext_initialize(np);
 			printk("result: %d\n", rc);
 		}
-		if (rc == 0)
+		if (rc == 0) {
+			of_node_put(np);
 			break;
+		}
 	}
 	return rc;
 }
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 1e8c57207346..df3af10b8cc9 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2528,7 +2528,7 @@ static void __init fixup_device_tree_efika_add_phy(void)
 
 	/* Check if the phy-handle property exists - bail if it does */
 	rv = prom_getprop(node, "phy-handle", prop, sizeof(prop));
-	if (!rv)
+	if (rv <= 0)
 		return;
 
 	/*
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 9c6f3fd58059..31675c1d678b 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -759,10 +759,12 @@ void start_secondary(void *unused)
 	BUG();
 }
 
+#ifdef CONFIG_PROFILING
 int setup_profiling_timer(unsigned int multiplier)
 {
 	return 0;
 }
+#endif
 
 #ifdef CONFIG_SCHED_SMT
 /* cpumask of CPUs with asymetric SMT dependancy */
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 309361e86523..3e3370d126ae 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -9,6 +9,9 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 CFLAGS_REMOVE_code-patching.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_feature-fixups.o = $(CC_FLAGS_FTRACE)
 
+CFLAGS_code-patching.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
+CFLAGS_feature-fixups.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
+
 obj-y += string.o alloc.o crtsavres.o code-patching.o \
 	 feature-fixups.o
 
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 7ff51f96a00e..8df43781f5db 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -1107,6 +1107,7 @@ static int __init cell_iommu_fixed_mapping_init(void)
 			if (hbase < dbase || (hend > (dbase + dsize))) {
 				pr_debug("iommu: hash window doesn't fit in"
 					 "real DMA window\n");
+				of_node_put(np);
 				return -1;
 			}
 		}
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index bf4a125faec6..db2ea6b6889d 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -220,6 +220,7 @@ void hlwd_pic_probe(void)
 			irq_set_chained_handler(cascade_virq,
 						hlwd_pic_irq_cascade);
 			hlwd_irq_host = host;
+			of_node_put(np);
 			break;
 		}
 	}
diff --git a/arch/powerpc/platforms/powernv/opal-lpc.c b/arch/powerpc/platforms/powernv/opal-lpc.c
index e4169d68cb32..d28c4a9269c3 100644
--- a/arch/powerpc/platforms/powernv/opal-lpc.c
+++ b/arch/powerpc/platforms/powernv/opal-lpc.c
@@ -401,6 +401,7 @@ void opal_lpc_init(void)
 		if (!of_get_property(np, "primary", NULL))
 			continue;
 		opal_lpc_chip_id = of_get_ibm_chip_id(np);
+		of_node_put(np);
 		break;
 	}
 	if (opal_lpc_chip_id < 0)
diff --git a/arch/s390/hypfs/hypfs_vm.c b/arch/s390/hypfs/hypfs_vm.c
index 012919d9833b..9fed1308670d 100644
--- a/arch/s390/hypfs/hypfs_vm.c
+++ b/arch/s390/hypfs/hypfs_vm.c
@@ -19,6 +19,7 @@
 
 static char local_guest[] = "        ";
 static char all_guests[] = "*       ";
+static char *all_groups = all_guests;
 static char *guest_query;
 
 struct diag2fc_data {
@@ -61,10 +62,11 @@ static int diag2fc(int size, char* query, void *addr)
 
 	memcpy(parm_list.userid, query, NAME_LEN);
 	ASCEBC(parm_list.userid, NAME_LEN);
-	parm_list.addr = (unsigned long) addr ;
+	memcpy(parm_list.aci_grp, all_groups, NAME_LEN);
+	ASCEBC(parm_list.aci_grp, NAME_LEN);
+	parm_list.addr = (unsigned long)addr;
 	parm_list.size = size;
 	parm_list.fmt = 0x02;
-	memset(parm_list.aci_grp, 0x40, NAME_LEN);
 	rc = -1;
 
 	diag_stat_inc(DIAG_STAT_X2FC);
diff --git a/arch/s390/mm/gup.c b/arch/s390/mm/gup.c
index cf045f56581e..be1e2ed6405d 100644
--- a/arch/s390/mm/gup.c
+++ b/arch/s390/mm/gup.c
@@ -261,7 +261,14 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 
 	might_sleep();
 	start &= PAGE_MASK;
-	nr = __get_user_pages_fast(start, nr_pages, write, pages);
+	/*
+	 * The FAST_GUP case requires FOLL_WRITE even for pure reads,
+	 * because get_user_pages() may need to cause an early COW in
+	 * order to avoid confusing the normal COW routines. So only
+	 * targets that are already writable are safe to do by just
+	 * looking at the page tables.
+	 */
+	nr = __get_user_pages_fast(start, nr_pages, 1, pages);
 	if (nr == nr_pages)
 		return nr;
 
diff --git a/arch/sh/mm/gup.c b/arch/sh/mm/gup.c
index 063c298ba56c..7fec66e34af0 100644
--- a/arch/sh/mm/gup.c
+++ b/arch/sh/mm/gup.c
@@ -239,7 +239,14 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
 			goto slow;
-		if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
+		/*
+		 * The FAST_GUP case requires FOLL_WRITE even for pure reads,
+		 * because get_user_pages() may need to cause an early COW in
+		 * order to avoid confusing the normal COW routines. So only
+		 * targets that are already writable are safe to do by just
+		 * looking at the page tables.
+		 */
+		if (!gup_pud_range(pgd, addr, next, 1, pages, &nr))
 			goto slow;
 	} while (pgdp++, addr = next, addr != end);
 	local_irq_enable();
diff --git a/arch/sparc/mm/gup.c b/arch/sparc/mm/gup.c
index cd0e32bbcb1d..685679f87988 100644
--- a/arch/sparc/mm/gup.c
+++ b/arch/sparc/mm/gup.c
@@ -218,7 +218,14 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
 			goto slow;
-		if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
+		/*
+		 * The FAST_GUP case requires FOLL_WRITE even for pure reads,
+		 * because get_user_pages() may need to cause an early COW in
+		 * order to avoid confusing the normal COW routines. So only
+		 * targets that are already writable are safe to do by just
+		 * looking at the page tables.
+		 */
+		if (!gup_pud_range(pgd, addr, next, 1, pages, &nr))
 			goto slow;
 	} while (pgdp++, addr = next, addr != end);
 
diff --git a/arch/um/include/shared/registers.h b/arch/um/include/shared/registers.h
index a74449b5b0e3..12ad7c435e97 100644
--- a/arch/um/include/shared/registers.h
+++ b/arch/um/include/shared/registers.h
@@ -16,8 +16,8 @@ extern int restore_fp_registers(int pid, unsigned long *fp_regs);
 extern int save_fpx_registers(int pid, unsigned long *fp_regs);
 extern int restore_fpx_registers(int pid, unsigned long *fp_regs);
 extern int save_registers(int pid, struct uml_pt_regs *regs);
-extern int restore_registers(int pid, struct uml_pt_regs *regs);
-extern int init_registers(int pid);
+extern int restore_pid_registers(int pid, struct uml_pt_regs *regs);
+extern int init_pid_registers(int pid);
 extern void get_safe_registers(unsigned long *regs, unsigned long *fp_regs);
 extern unsigned long get_thread_reg(int reg, jmp_buf *buf);
 extern int get_fp_registers(int pid, unsigned long *regs);
diff --git a/arch/um/os-Linux/registers.c b/arch/um/os-Linux/registers.c
index 2ff8d4fe83c4..34a5963bd7ef 100644
--- a/arch/um/os-Linux/registers.c
+++ b/arch/um/os-Linux/registers.c
@@ -21,7 +21,7 @@ int save_registers(int pid, struct uml_pt_regs *regs)
 	return 0;
 }
 
-int restore_registers(int pid, struct uml_pt_regs *regs)
+int restore_pid_registers(int pid, struct uml_pt_regs *regs)
 {
 	int err;
 
@@ -36,7 +36,7 @@ int restore_registers(int pid, struct uml_pt_regs *regs)
 static unsigned long exec_regs[MAX_REG_NR];
 static unsigned long exec_fp_regs[FP_SIZE];
 
-int init_registers(int pid)
+int init_pid_registers(int pid)
 {
 	int err;
 
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 22a358ef1b0c..dc06933ba63d 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -334,7 +334,7 @@ void __init os_early_checks(void)
 	check_tmpexec();
 
 	pid = start_ptraced_child();
-	if (init_registers(pid))
+	if (init_pid_registers(pid))
 		fatal("Failed to initialize default registers");
 	stop_ptraced_child(pid, 1, 1);
 }
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index e03225e707b2..d92c7758efad 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -100,8 +100,8 @@ struct guest_walker {
 	gpa_t pte_gpa[PT_MAX_FULL_LEVELS];
 	pt_element_t __user *ptep_user[PT_MAX_FULL_LEVELS];
 	bool pte_writable[PT_MAX_FULL_LEVELS];
-	unsigned pt_access;
-	unsigned pte_access;
+	unsigned int pt_access[PT_MAX_FULL_LEVELS];
+	unsigned int pte_access;
 	gfn_t gfn;
 	struct x86_exception fault;
 };
@@ -285,9 +285,11 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	pt_element_t pte;
 	pt_element_t __user *uninitialized_var(ptep_user);
 	gfn_t table_gfn;
-	unsigned index, pt_access, pte_access, accessed_dirty, pte_pkey;
+	u64 pt_access, pte_access;
+	unsigned index, accessed_dirty, pte_pkey;
 	gpa_t pte_gpa;
 	int offset;
+	u64 walk_nx_mask = 0;
 	const int write_fault = access & PFERR_WRITE_MASK;
 	const int user_fault  = access & PFERR_USER_MASK;
 	const int fetch_fault = access & PFERR_FETCH_MASK;
@@ -301,6 +303,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	pte           = mmu->get_cr3(vcpu);
 
 #if PTTYPE == 64
+	walk_nx_mask = 1ULL << PT64_NX_SHIFT;
 	if (walker->level == PT32E_ROOT_LEVEL) {
 		pte = mmu->get_pdptr(vcpu, (addr >> 30) & 3);
 		trace_kvm_mmu_paging_element(pte, walker->level);
@@ -312,15 +315,14 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	walker->max_level = walker->level;
 	ASSERT(!(is_long_mode(vcpu) && !is_pae(vcpu)));
 
-	accessed_dirty = PT_GUEST_ACCESSED_MASK;
-	pt_access = pte_access = ACC_ALL;
+	pte_access = ~0;
 	++walker->level;
 
 	do {
 		gfn_t real_gfn;
 		unsigned long host_addr;
 
-		pt_access &= pte_access;
+		pt_access = pte_access;
 		--walker->level;
 
 		index = PT_INDEX(addr, walker->level);
@@ -363,6 +365,12 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 		trace_kvm_mmu_paging_element(pte, walker->level);
 
+		/*
+		 * Inverting the NX it lets us AND it like other
+		 * permission bits.
+		 */
+		pte_access = pt_access & (pte ^ walk_nx_mask);
+
 		if (unlikely(!FNAME(is_present_gpte)(pte)))
 			goto error;
 
@@ -371,14 +379,18 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 			goto error;
 		}
 
-		accessed_dirty &= pte;
-		pte_access = pt_access & FNAME(gpte_access)(vcpu, pte);
-
 		walker->ptes[walker->level - 1] = pte;
+
+		/* Convert to ACC_*_MASK flags for struct guest_walker.  */
+		walker->pt_access[walker->level - 1] = FNAME(gpte_access)(vcpu, pt_access ^ walk_nx_mask);
 	} while (!is_last_gpte(mmu, walker->level, pte));
 
 	pte_pkey = FNAME(gpte_pkeys)(vcpu, pte);
-	errcode = permission_fault(vcpu, mmu, pte_access, pte_pkey, access);
+	accessed_dirty = pte_access & PT_GUEST_ACCESSED_MASK;
+
+	/* Convert to ACC_*_MASK flags for struct guest_walker.  */
+	walker->pte_access = FNAME(gpte_access)(vcpu, pte_access ^ walk_nx_mask);
+	errcode = permission_fault(vcpu, mmu, walker->pte_access, pte_pkey, access);
 	if (unlikely(errcode))
 		goto error;
 
@@ -395,7 +407,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	walker->gfn = real_gpa >> PAGE_SHIFT;
 
 	if (!write_fault)
-		FNAME(protect_clean_gpte)(&pte_access, pte);
+		FNAME(protect_clean_gpte)(&walker->pte_access, pte);
 	else
 		/*
 		 * On a write fault, fold the dirty bit into accessed_dirty.
@@ -413,10 +425,9 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 			goto retry_walk;
 	}
 
-	walker->pt_access = pt_access;
-	walker->pte_access = pte_access;
 	pgprintk("%s: pte %llx pte_access %x pt_access %x\n",
-		 __func__, (u64)pte, pte_access, pt_access);
+		 __func__, (u64)pte, walker->pte_access,
+		 walker->pt_access[walker->level - 1]);
 	return 1;
 
 error:
@@ -444,7 +455,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	 */
 	if (!(errcode & PFERR_RSVD_MASK)) {
 		vcpu->arch.exit_qualification &= 0x187;
-		vcpu->arch.exit_qualification |= ((pt_access & pte) & 0x7) << 3;
+		vcpu->arch.exit_qualification |= (pte_access & 0x7) << 3;
 	}
 #endif
 	walker->fault.address = addr;
@@ -578,7 +589,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
 {
 	struct kvm_mmu_page *sp = NULL;
 	struct kvm_shadow_walk_iterator it;
-	unsigned direct_access, access = gw->pt_access;
+	unsigned int direct_access, access;
 	int top_level, ret;
 	gfn_t gfn, base_gfn;
 
@@ -610,6 +621,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
 		sp = NULL;
 		if (!is_shadow_present_pte(*it.sptep)) {
 			table_gfn = gw->table_gfn[it.level - 2];
+			access = gw->pt_access[it.level - 2];
 			sp = kvm_mmu_get_page(vcpu, table_gfn, addr, it.level-1,
 					      false, access);
 		}
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 0827ee7d0e9b..f1aa0b932c54 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -164,7 +164,7 @@ void reprogram_gp_counter(struct kvm_pmc *pmc, u64 eventsel)
 	}
 
 	if (type == PERF_TYPE_RAW)
-		config = eventsel & X86_RAW_EVENT_MASK;
+		config = eventsel & AMD64_RAW_EVENT_MASK;
 
 	pmc_reprogram_counter(pmc, type, config,
 			      !(eventsel & ARCH_PERFMON_EVENTSEL_USR),
diff --git a/arch/x86/mm/gup.c b/arch/x86/mm/gup.c
index 82f727fbbbd2..549f89fb3abc 100644
--- a/arch/x86/mm/gup.c
+++ b/arch/x86/mm/gup.c
@@ -454,7 +454,14 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
 			goto slow;
-		if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
+		/*
+		 * The FAST_GUP case requires FOLL_WRITE even for pure reads,
+		 * because get_user_pages() may need to cause an early COW in
+		 * order to avoid confusing the normal COW routines. So only
+		 * targets that are already writable are safe to do by just
+		 * looking at the page tables.
+		 */
+		if (!gup_pud_range(pgd, addr, next, 1, pages, &nr))
 			goto slow;
 	} while (pgdp++, addr = next, addr != end);
 	local_irq_enable();
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index e6552275320b..40ecacb2c54b 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -9,6 +9,7 @@
 #include <linux/uaccess.h>
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include <os.h>
+#include <registers.h>
 
 long arch_prctl(struct task_struct *task, int code, unsigned long __user *addr)
 {
@@ -32,7 +33,7 @@ long arch_prctl(struct task_struct *task, int code, unsigned long __user *addr)
 	switch (code) {
 	case ARCH_SET_FS:
 	case ARCH_SET_GS:
-		ret = restore_registers(pid, &current->thread.regs.regs);
+		ret = restore_pid_registers(pid, &current->thread.regs.regs);
 		if (ret)
 			return ret;
 		break;
diff --git a/drivers/acpi/acpica/exoparg1.c b/drivers/acpi/acpica/exoparg1.c
index 007300433cde..1cea26a74147 100644
--- a/drivers/acpi/acpica/exoparg1.c
+++ b/drivers/acpi/acpica/exoparg1.c
@@ -1029,7 +1029,8 @@ acpi_status acpi_ex_opcode_1A_0T_1R(struct acpi_walk_state *walk_state)
 						    (walk_state, return_desc,
 						     &temp_desc);
 						if (ACPI_FAILURE(status)) {
-							goto cleanup;
+							return_ACPI_STATUS
+							    (status);
 						}
 
 						return_desc = temp_desc;
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index 03a2282ceb9c..81a9c47973ce 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -440,6 +440,7 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 			ACPI_WARNING((AE_INFO,
 				      "Obj %p, Reference Count is already zero, cannot decrement\n",
 				      object));
+			return;
 		}
 
 		ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a92cbe1aa72a..35db918a1de5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4486,6 +4486,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 
 	/* devices that don't properly handle TRIM commands */
 	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
+	{ "M88V29*",			NULL,	ATA_HORKAGE_NOTRIM, },
 
 	/*
 	 * As defined, the DRAT (Deterministic Read After Trim) and RZAT
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 4496e7a49235..7164be9710e5 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -994,7 +994,7 @@ static DECLARE_DELAYED_WORK(fd_timer, fd_timer_workfn);
 static void cancel_activity(void)
 {
 	do_floppy = NULL;
-	cancel_delayed_work_sync(&fd_timer);
+	cancel_delayed_work(&fd_timer);
 	cancel_work_sync(&floppy_work);
 }
 
@@ -3116,6 +3116,8 @@ static void raw_cmd_free(struct floppy_raw_cmd **ptr)
 	}
 }
 
+#define MAX_LEN (1UL << MAX_ORDER << PAGE_SHIFT)
+
 static int raw_cmd_copyin(int cmd, void __user *param,
 				 struct floppy_raw_cmd **rcmd)
 {
@@ -3153,7 +3155,7 @@ static int raw_cmd_copyin(int cmd, void __user *param,
 	ptr->resultcode = 0;
 
 	if (ptr->flags & (FD_RAW_READ | FD_RAW_WRITE)) {
-		if (ptr->length <= 0)
+		if (ptr->length <= 0 || ptr->length >= MAX_LEN)
 			return -EINVAL;
 		ptr->kernel_data = (char *)fd_dma_mem_alloc(ptr->length);
 		fallback_on_nodma_alloc(&ptr->kernel_data, ptr->length);
diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 3bf4ec60e073..cee2de027e5a 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -644,6 +644,9 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	data->bulk_out_ep   = bulk_out_ep->desc.bEndpointAddress;
 	data->bulk_pkt_size = le16_to_cpu(bulk_out_ep->desc.wMaxPacketSize);
 
+	if (!data->bulk_pkt_size)
+		goto done;
+
 	rwlock_init(&data->lock);
 
 	data->reassembly = NULL;
diff --git a/drivers/char/mwave/3780i.h b/drivers/char/mwave/3780i.h
index 9ccb6b270b07..95164246afd1 100644
--- a/drivers/char/mwave/3780i.h
+++ b/drivers/char/mwave/3780i.h
@@ -68,7 +68,7 @@ typedef struct {
 	unsigned char ClockControl:1;	/* RW: Clock control: 0=normal, 1=stop 3780i clocks */
 	unsigned char SoftReset:1;	/* RW: Soft reset 0=normal, 1=soft reset active */
 	unsigned char ConfigMode:1;	/* RW: Configuration mode, 0=normal, 1=config mode */
-	unsigned char Reserved:5;	/* 0: Reserved */
+	unsigned short Reserved:13;	/* 0: Reserved */
 } DSP_ISA_SLAVE_CONTROL;
 
 
diff --git a/drivers/char/random.c b/drivers/char/random.c
index deb315defe66..4792199d2a1a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -846,8 +846,8 @@ static void do_numa_crng_init(struct work_struct *work)
 		crng_initialize(crng);
 		pool[i] = crng;
 	}
-	mb();
-	if (cmpxchg(&crng_node_pool, NULL, pool)) {
+	/* pairs with READ_ONCE() in select_crng() */
+	if (cmpxchg_release(&crng_node_pool, NULL, pool) != NULL) {
 		for_each_node(i)
 			kfree(pool[i]);
 		kfree(pool);
@@ -860,8 +860,26 @@ static void numa_crng_init(void)
 {
 	schedule_work(&numa_crng_init_work);
 }
+
+static struct crng_state *select_crng(void)
+{
+	struct crng_state **pool;
+	int nid = numa_node_id();
+
+	/* pairs with cmpxchg_release() in do_numa_crng_init() */
+	pool = READ_ONCE(crng_node_pool);
+	if (pool && pool[nid])
+		return pool[nid];
+
+	return &primary_crng;
+}
 #else
 static void numa_crng_init(void) {}
+
+static struct crng_state *select_crng(void)
+{
+	return &primary_crng;
+}
 #endif
 
 static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
@@ -891,7 +909,7 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
 		crng->state[i+4] ^= buf.key[i] ^ rv;
 	}
 	memzero_explicit(&buf, sizeof(buf));
-	crng->init_time = jiffies;
+	WRITE_ONCE(crng->init_time, jiffies);
 	if (crng == &primary_crng && crng_init < 2) {
 		numa_crng_init();
 		crng_init = 2;
@@ -929,12 +947,15 @@ static inline void crng_wait_ready(void)
 static void _extract_crng(struct crng_state *crng,
 			  __u8 out[CHACHA20_BLOCK_SIZE])
 {
-	unsigned long v, flags;
-
-	if (crng_ready() &&
-	    (time_after(crng_global_init_time, crng->init_time) ||
-	     time_after(jiffies, crng->init_time + CRNG_RESEED_INTERVAL)))
-		crng_reseed(crng, crng == &primary_crng ? &input_pool : NULL);
+	unsigned long v, flags, init_time;
+
+	if (crng_ready()) {
+		init_time = READ_ONCE(crng->init_time);
+		if (time_after(READ_ONCE(crng_global_init_time), init_time) ||
+		    time_after(jiffies, init_time + CRNG_RESEED_INTERVAL))
+			crng_reseed(crng, crng == &primary_crng ?
+				    &input_pool : NULL);
+	}
 	spin_lock_irqsave(&crng->lock, flags);
 	if (arch_get_random_long(&v))
 		crng->state[14] ^= v;
@@ -946,15 +967,7 @@ static void _extract_crng(struct crng_state *crng,
 
 static void extract_crng(__u8 out[CHACHA20_BLOCK_SIZE])
 {
-	struct crng_state *crng = NULL;
-
-#ifdef CONFIG_NUMA
-	if (crng_node_pool)
-		crng = crng_node_pool[numa_node_id()];
-	if (crng == NULL)
-#endif
-		crng = &primary_crng;
-	_extract_crng(crng, out);
+	_extract_crng(select_crng(), out);
 }
 
 /*
@@ -983,15 +996,7 @@ static void _crng_backtrack_protect(struct crng_state *crng,
 
 static void crng_backtrack_protect(__u8 tmp[CHACHA20_BLOCK_SIZE], int used)
 {
-	struct crng_state *crng = NULL;
-
-#ifdef CONFIG_NUMA
-	if (crng_node_pool)
-		crng = crng_node_pool[numa_node_id()];
-	if (crng == NULL)
-#endif
-		crng = &primary_crng;
-	_crng_backtrack_protect(crng, tmp, used);
+	_crng_backtrack_protect(select_crng(), tmp, used);
 }
 
 static ssize_t extract_crng_user(void __user *buf, size_t nbytes)
@@ -1911,7 +1916,7 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		if (crng_init < 2)
 			return -ENODATA;
 		crng_reseed(&primary_crng, &input_pool);
-		crng_global_init_time = jiffies - 1;
+		WRITE_ONCE(crng_global_init_time, jiffies - 1);
 		return 0;
 	default:
 		return -EINVAL;
diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index 47e114ac09d0..ff1e788f9276 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -544,8 +544,8 @@ static int qce_ahash_register_one(const struct qce_ahash_def *def,
 
 	ret = crypto_register_ahash(alg);
 	if (ret) {
-		kfree(tmpl);
 		dev_err(qce->dev, "%s registration failed\n", base->cra_name);
+		kfree(tmpl);
 		return ret;
 	}
 
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index a505be9ef96d..c15ca560fe60 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -100,6 +100,7 @@
 #define		AT_XDMAC_CNDC_NDE		(0x1 << 0)		/* Channel x Next Descriptor Enable */
 #define		AT_XDMAC_CNDC_NDSUP		(0x1 << 1)		/* Channel x Next Descriptor Source Update */
 #define		AT_XDMAC_CNDC_NDDUP		(0x1 << 2)		/* Channel x Next Descriptor Destination Update */
+#define		AT_XDMAC_CNDC_NDVIEW_MASK	GENMASK(28, 27)
 #define		AT_XDMAC_CNDC_NDVIEW_NDV0	(0x0 << 3)		/* Channel x Next Descriptor View 0 */
 #define		AT_XDMAC_CNDC_NDVIEW_NDV1	(0x1 << 3)		/* Channel x Next Descriptor View 1 */
 #define		AT_XDMAC_CNDC_NDVIEW_NDV2	(0x2 << 3)		/* Channel x Next Descriptor View 2 */
@@ -232,15 +233,15 @@ struct at_xdmac {
 
 /* Linked List Descriptor */
 struct at_xdmac_lld {
-	dma_addr_t	mbr_nda;	/* Next Descriptor Member */
-	u32		mbr_ubc;	/* Microblock Control Member */
-	dma_addr_t	mbr_sa;		/* Source Address Member */
-	dma_addr_t	mbr_da;		/* Destination Address Member */
-	u32		mbr_cfg;	/* Configuration Register */
-	u32		mbr_bc;		/* Block Control Register */
-	u32		mbr_ds;		/* Data Stride Register */
-	u32		mbr_sus;	/* Source Microblock Stride Register */
-	u32		mbr_dus;	/* Destination Microblock Stride Register */
+	u32 mbr_nda;	/* Next Descriptor Member */
+	u32 mbr_ubc;	/* Microblock Control Member */
+	u32 mbr_sa;	/* Source Address Member */
+	u32 mbr_da;	/* Destination Address Member */
+	u32 mbr_cfg;	/* Configuration Register */
+	u32 mbr_bc;	/* Block Control Register */
+	u32 mbr_ds;	/* Data Stride Register */
+	u32 mbr_sus;	/* Source Microblock Stride Register */
+	u32 mbr_dus;	/* Destination Microblock Stride Register */
 };
 
 /* 64-bit alignment needed to update CNDA and CUBC registers in an atomic way. */
@@ -345,9 +346,6 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
 
 	dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, first);
 
-	if (at_xdmac_chan_is_enabled(atchan))
-		return;
-
 	/* Set transfer as active to not try to start it again. */
 	first->active_xfer = true;
 
@@ -363,7 +361,8 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
 	 */
 	if (at_xdmac_chan_is_cyclic(atchan))
 		reg = AT_XDMAC_CNDC_NDVIEW_NDV1;
-	else if (first->lld.mbr_ubc & AT_XDMAC_MBR_UBC_NDV3)
+	else if ((first->lld.mbr_ubc &
+		  AT_XDMAC_CNDC_NDVIEW_MASK) == AT_XDMAC_MBR_UBC_NDV3)
 		reg = AT_XDMAC_CNDC_NDVIEW_NDV3;
 	else
 		reg = AT_XDMAC_CNDC_NDVIEW_NDV2;
@@ -428,13 +427,12 @@ static dma_cookie_t at_xdmac_tx_submit(struct dma_async_tx_descriptor *tx)
 	spin_lock_irqsave(&atchan->lock, irqflags);
 	cookie = dma_cookie_assign(tx);
 
+	list_add_tail(&desc->xfer_node, &atchan->xfers_list);
+	spin_unlock_irqrestore(&atchan->lock, irqflags);
+
 	dev_vdbg(chan2dev(tx->chan), "%s: atchan 0x%p, add desc 0x%p to xfers_list\n",
 		 __func__, atchan, desc);
-	list_add_tail(&desc->xfer_node, &atchan->xfers_list);
-	if (list_is_singular(&atchan->xfers_list))
-		at_xdmac_start_xfer(atchan, desc);
 
-	spin_unlock_irqrestore(&atchan->lock, irqflags);
 	return cookie;
 }
 
diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index eb3a1f42ab06..e8b2d3e31de8 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -722,12 +722,6 @@ static int mmp_pdma_config(struct dma_chan *dchan,
 
 	chan->dir = cfg->direction;
 	chan->dev_addr = addr;
-	/* FIXME: drivers should be ported over to use the filter
-	 * function. Once that's done, the following two lines can
-	 * be removed.
-	 */
-	if (cfg->slave_id)
-		chan->drcmr = cfg->slave_id;
 
 	return 0;
 }
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 3f56f9ca4482..5bd1ade187d3 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -975,13 +975,6 @@ static void pxad_get_config(struct pxad_chan *chan,
 		*dcmd |= PXA_DCMD_BURST16;
 	else if (maxburst == 32)
 		*dcmd |= PXA_DCMD_BURST32;
-
-	/* FIXME: drivers should be ported over to use the filter
-	 * function. Once that's done, the following two lines can
-	 * be removed.
-	 */
-	if (chan->cfg.slave_id)
-		chan->drcmr = chan->cfg.slave_id;
 }
 
 static struct dma_async_tx_descriptor *
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 6037efa94c9b..6d10bbc65ad3 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -363,7 +363,7 @@ static int altr_sdram_probe(struct platform_device *pdev)
 	if (irq < 0) {
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "No irq %d in DT\n", irq);
-		return -ENODEV;
+		return irq;
 	}
 
 	/* Arria10 has a 2nd IRQ */
diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index c3ee3ad98a63..4fb313f6612c 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -199,7 +199,7 @@ void *edac_align_ptr(void **p, unsigned size, int n_elems)
 	else
 		return (char *)ptr;
 
-	r = (unsigned long)p % align;
+	r = (unsigned long)ptr % align;
 
 	if (r == 0)
 		return (char *)ptr;
diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index bf19b6e3bd12..771927d2b5de 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -1936,7 +1936,7 @@ static int xgene_edac_probe(struct platform_device *pdev)
 			irq = platform_get_irq(pdev, i);
 			if (irq < 0) {
 				dev_err(&pdev->dev, "No IRQ resource\n");
-				rc = -EINVAL;
+				rc = irq;
 				goto out_err;
 			}
 			rc = devm_request_irq(&pdev->dev, irq,
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 986248f7011a..c479280590e4 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -675,10 +675,17 @@ int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 			irq_flags = acpi_dev_get_irq_type(info.triggering,
 							  info.polarity);
 
-			/* Set type if specified and different than the current one */
-			if (irq_flags != IRQ_TYPE_NONE &&
-			    irq_flags != irq_get_trigger_type(irq))
-				irq_set_irq_type(irq, irq_flags);
+			/*
+			 * If the IRQ is not already in use then set type
+			 * if specified and different than the current one.
+			 */
+			if (can_request_irq(irq, irq_flags)) {
+				if (irq_flags != IRQ_TYPE_NONE &&
+				    irq_flags != irq_get_trigger_type(irq))
+					irq_set_irq_type(irq, irq_flags);
+			} else {
+				dev_dbg(&adev->dev, "IRQ %d already in use\n", irq);
+			}
 
 			return irq;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index eb79d0d3d34f..7264169d5f2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -404,6 +404,9 @@ amdgpu_connector_lcd_native_mode(struct drm_encoder *encoder)
 	    native_mode->vdisplay != 0 &&
 	    native_mode->clock != 0) {
 		mode = drm_mode_duplicate(dev, native_mode);
+		if (!mode)
+			return NULL;
+
 		mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
 		drm_mode_set_name(mode);
 
@@ -418,6 +421,9 @@ amdgpu_connector_lcd_native_mode(struct drm_encoder *encoder)
 		 * simpler.
 		 */
 		mode = drm_cvt_mode(dev, native_mode->hdisplay, native_mode->vdisplay, 60, true, false, false);
+		if (!mode)
+			return NULL;
+
 		mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
 		DRM_DEBUG_KMS("Adding cvt approximation of native panel mode %s\n", mode->name);
 	}
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index c4f155663ca9..14cd0a742e79 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1763,6 +1763,8 @@ struct drm_i915_private {
 
 	struct intel_uncore uncore;
 
+	struct mutex tlb_invalidate_lock;
+
 	struct i915_virtual_gpu vgpu;
 
 	struct intel_gvt gvt;
@@ -2211,7 +2213,8 @@ struct drm_i915_gem_object {
 	 * rendering and so a non-zero seqno), and is not set if it i s on
 	 * inactive (ready to be unbound) list.
 	 */
-#define I915_BO_ACTIVE_SHIFT 0
+#define I915_BO_WAS_BOUND_BIT    0
+#define I915_BO_ACTIVE_SHIFT 1
 #define I915_BO_ACTIVE_MASK ((1 << I915_NUM_ENGINES) - 1)
 #define __I915_BO_ACTIVE(bo) \
 	((READ_ONCE((bo)->flags) >> I915_BO_ACTIVE_SHIFT) & I915_BO_ACTIVE_MASK)
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 3fb4f9acacba..9265ac5774c2 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -2185,6 +2185,67 @@ i915_gem_object_put_pages_gtt(struct drm_i915_gem_object *obj)
 	kfree(obj->pages);
 }
 
+static int
+__intel_wait_for_register_fw(struct drm_i915_private *dev_priv,
+			     i915_reg_t reg,
+			     const u32 mask,
+			     const u32 value,
+			     const unsigned int timeout_us,
+			     const unsigned int timeout_ms)
+{
+#define done ((I915_READ_FW(reg) & mask) == value)
+	int ret = wait_for_us(done, timeout_us);
+	if (ret)
+		ret = wait_for(done, timeout_ms);
+	return ret;
+#undef done
+}
+
+static void invalidate_tlbs(struct drm_i915_private *dev_priv)
+{
+	static const i915_reg_t gen8_regs[] = {
+		[RCS]  = GEN8_RTCR,
+		[VCS]  = GEN8_M1TCR,
+		[VCS2] = GEN8_M2TCR,
+		[VECS] = GEN8_VTCR,
+		[BCS]  = GEN8_BTCR,
+	};
+	struct intel_engine_cs *engine;
+
+	if (INTEL_GEN(dev_priv) < 8)
+		return;
+
+	assert_rpm_wakelock_held(dev_priv);
+
+	mutex_lock(&dev_priv->tlb_invalidate_lock);
+	intel_uncore_forcewake_get(dev_priv, FORCEWAKE_ALL);
+
+	for_each_engine(engine, dev_priv) {
+		/*
+		 * HW architecture suggest typical invalidation time at 40us,
+		 * with pessimistic cases up to 100us and a recommendation to
+		 * cap at 1ms. We go a bit higher just in case.
+		 */
+		const unsigned int timeout_us = 100;
+		const unsigned int timeout_ms = 4;
+		const enum intel_engine_id id = engine->id;
+
+		if (WARN_ON_ONCE(id >= ARRAY_SIZE(gen8_regs) ||
+				 !i915_mmio_reg_offset(gen8_regs[id])))
+			continue;
+
+		I915_WRITE_FW(gen8_regs[id], 1);
+		if (__intel_wait_for_register_fw(dev_priv,
+						 gen8_regs[id], 1, 0,
+						 timeout_us, timeout_ms))
+			DRM_ERROR_RATELIMITED("%s TLB invalidation did not complete in %ums!\n",
+					      engine->name, timeout_ms);
+	}
+
+	intel_uncore_forcewake_put(dev_priv, FORCEWAKE_ALL);
+	mutex_unlock(&dev_priv->tlb_invalidate_lock);
+}
+
 int
 i915_gem_object_put_pages(struct drm_i915_gem_object *obj)
 {
@@ -2215,6 +2276,15 @@ i915_gem_object_put_pages(struct drm_i915_gem_object *obj)
 		obj->mapping = NULL;
 	}
 
+	if (test_and_clear_bit(I915_BO_WAS_BOUND_BIT, &obj->flags)) {
+		struct drm_i915_private *i915 = to_i915(obj->base.dev);
+
+		if (intel_runtime_pm_get_if_in_use(i915)) {
+			invalidate_tlbs(i915);
+			intel_runtime_pm_put(i915);
+		}
+	}
+
 	ops->put_pages(obj);
 	obj->pages = NULL;
 
@@ -4627,6 +4697,8 @@ i915_gem_load_init(struct drm_device *dev)
 
 	atomic_set(&dev_priv->mm.bsd_engine_dispatch_index, 0);
 
+	mutex_init(&dev_priv->tlb_invalidate_lock);
+
 	spin_lock_init(&dev_priv->fb_tracking.lock);
 }
 
diff --git a/drivers/gpu/drm/i915/i915_gem_gtt.c b/drivers/gpu/drm/i915/i915_gem_gtt.c
index 16f56f14f4d0..edaff73b7aa9 100644
--- a/drivers/gpu/drm/i915/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/i915_gem_gtt.c
@@ -3685,6 +3685,10 @@ int i915_vma_bind(struct i915_vma *vma, enum i915_cache_level cache_level,
 		return ret;
 
 	vma->flags |= bind_flags;
+
+	if (vma->obj)
+		set_bit(I915_BO_WAS_BOUND_BIT, &vma->obj->flags);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 5468e69bf520..1ff1e33df2c7 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -1698,6 +1698,12 @@ enum skl_disp_power_wells {
 #define GAMT_CHKN_BIT_REG	_MMIO(0x4ab8)
 #define   GAMT_CHKN_DISABLE_DYNAMIC_CREDIT_SHARING	(1<<28)
 
+#define GEN8_RTCR	_MMIO(0x4260)
+#define GEN8_M1TCR	_MMIO(0x4264)
+#define GEN8_M2TCR	_MMIO(0x4268)
+#define GEN8_BTCR	_MMIO(0x426c)
+#define GEN8_VTCR	_MMIO(0x4270)
+
 #if 0
 #define PRB0_TAIL	_MMIO(0x2030)
 #define PRB0_HEAD	_MMIO(0x2034)
diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index 07d2a8e7f78c..202c00b17df2 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -2274,9 +2274,9 @@ static void snb_wm_latency_quirk(struct drm_device *dev)
 	 * The BIOS provided WM memory latency values are often
 	 * inadequate for high resolution displays. Adjust them.
 	 */
-	changed = ilk_increase_wm_latency(dev_priv, dev_priv->wm.pri_latency, 12) |
-		ilk_increase_wm_latency(dev_priv, dev_priv->wm.spr_latency, 12) |
-		ilk_increase_wm_latency(dev_priv, dev_priv->wm.cur_latency, 12);
+	changed = ilk_increase_wm_latency(dev_priv, dev_priv->wm.pri_latency, 12);
+	changed |= ilk_increase_wm_latency(dev_priv, dev_priv->wm.spr_latency, 12);
+	changed |= ilk_increase_wm_latency(dev_priv, dev_priv->wm.cur_latency, 12);
 
 	if (!changed)
 		return;
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index ce32f41fc28a..94fded3daaa3 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -297,7 +297,7 @@ static int msm_init_vram(struct drm_device *dev)
 		of_node_put(node);
 		if (ret)
 			return ret;
-		size = r.end - r.start;
+		size = r.end - r.start + 1;
 		DRM_INFO("using VRAM carveout: %lx@%pa\n", size, &r.start);
 
 		/* if we have no IOMMU, then we need to use carveout allocator.
diff --git a/drivers/gpu/drm/nouveau/nouveau_sgdma.c b/drivers/gpu/drm/nouveau/nouveau_sgdma.c
index db35ab5883ac..d3bfd7912a99 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sgdma.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sgdma.c
@@ -105,12 +105,9 @@ nouveau_sgdma_create_ttm(struct ttm_bo_device *bdev,
 	else
 		nvbe->ttm.ttm.func = &nv50_sgdma_backend;
 
-	if (ttm_dma_tt_init(&nvbe->ttm, bdev, size, page_flags, dummy_read_page))
-		/*
-		 * A failing ttm_dma_tt_init() will call ttm_tt_destroy()
-		 * and thus our nouveau_sgdma_destroy() hook, so we don't need
-		 * to free nvbe here.
-		 */
+	if (ttm_dma_tt_init(&nvbe->ttm, bdev, size, page_flags, dummy_read_page)) {
+		kfree(nvbe);
 		return NULL;
+	}
 	return &nvbe->ttm.ttm;
 }
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/base.c
index f3c30b2a788e..8bff14ae16b0 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/base.c
@@ -38,7 +38,7 @@ nvbios_addr(struct nvkm_bios *bios, u32 *addr, u8 size)
 		*addr += bios->imaged_addr;
 	}
 
-	if (unlikely(*addr + size >= bios->size)) {
+	if (unlikely(*addr + size > bios->size)) {
 		nvkm_error(&bios->subdev, "OOB %d %08x %08x\n", size, p, *addr);
 		return false;
 	}
diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 7bb1e531325b..1b8652cf0218 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -192,7 +192,8 @@ void radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
 	 * so don't register a backlight device
 	 */
 	if ((rdev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE) &&
-	    (rdev->pdev->device == 0x6741))
+	    (rdev->pdev->device == 0x6741) &&
+	    !dmi_match(DMI_PRODUCT_NAME, "iMac12,1"))
 		return;
 
 	if (!radeon_encoder->enc_priv)
diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 61000e3b2e79..b55403c99d80 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -630,6 +630,8 @@ void radeon_driver_lastclose_kms(struct drm_device *dev)
 int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 {
 	struct radeon_device *rdev = dev->dev_private;
+	struct radeon_fpriv *fpriv;
+	struct radeon_vm *vm;
 	int r;
 
 	file_priv->driver_priv = NULL;
@@ -642,48 +644,52 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	/* new gpu have virtual address space support */
 	if (rdev->family >= CHIP_CAYMAN) {
-		struct radeon_fpriv *fpriv;
-		struct radeon_vm *vm;
 
 		fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
 		if (unlikely(!fpriv)) {
 			r = -ENOMEM;
-			goto out_suspend;
+			goto err_suspend;
 		}
 
 		if (rdev->accel_working) {
 			vm = &fpriv->vm;
 			r = radeon_vm_init(rdev, vm);
-			if (r) {
-				kfree(fpriv);
-				goto out_suspend;
-			}
+			if (r)
+				goto err_fpriv;
 
 			r = radeon_bo_reserve(rdev->ring_tmp_bo.bo, false);
-			if (r) {
-				radeon_vm_fini(rdev, vm);
-				kfree(fpriv);
-				goto out_suspend;
-			}
+			if (r)
+				goto err_vm_fini;
 
 			/* map the ib pool buffer read only into
 			 * virtual address space */
 			vm->ib_bo_va = radeon_vm_bo_add(rdev, vm,
 							rdev->ring_tmp_bo.bo);
+			if (!vm->ib_bo_va) {
+				r = -ENOMEM;
+				goto err_vm_fini;
+			}
+
 			r = radeon_vm_bo_set_addr(rdev, vm->ib_bo_va,
 						  RADEON_VA_IB_OFFSET,
 						  RADEON_VM_PAGE_READABLE |
 						  RADEON_VM_PAGE_SNOOPED);
-			if (r) {
-				radeon_vm_fini(rdev, vm);
-				kfree(fpriv);
-				goto out_suspend;
-			}
+			if (r)
+				goto err_vm_fini;
 		}
 		file_priv->driver_priv = fpriv;
 	}
 
-out_suspend:
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+	return 0;
+
+err_vm_fini:
+	radeon_vm_fini(rdev, vm);
+err_fpriv:
+	kfree(fpriv);
+
+err_suspend:
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
 	return r;
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index aee3c00f836e..e4e24be52353 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -195,7 +195,6 @@ int ttm_tt_init(struct ttm_tt *ttm, struct ttm_bo_device *bdev,
 
 	ttm_tt_alloc_page_directory(ttm);
 	if (!ttm->pages) {
-		ttm_tt_destroy(ttm);
 		pr_err("Failed allocating page table\n");
 		return -ENOMEM;
 	}
@@ -228,7 +227,6 @@ int ttm_dma_tt_init(struct ttm_dma_tt *ttm_dma, struct ttm_bo_device *bdev,
 	INIT_LIST_HEAD(&ttm_dma->pages_list);
 	ttm_dma_tt_alloc_page_directory(ttm_dma);
 	if (!ttm->pages) {
-		ttm_tt_destroy(ttm);
 		pr_err("Failed allocating page table\n");
 		return -ENOMEM;
 	}
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index da9813f09d7d..2b5ae00f8df2 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -865,7 +865,7 @@ config THRUSTMASTER_FF
 
 config HID_WACOM
 	tristate "Wacom Intuos/Graphire tablet support (USB)"
-	depends on HID
+	depends on USB_HID
 	select POWER_SUPPLY
 	select NEW_LEDS
 	select LEDS_CLASS
diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 149902619cbc..0074091c27aa 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -390,7 +390,7 @@ static int apple_input_configured(struct hid_device *hdev,
 
 	if ((asc->quirks & APPLE_HAS_FN) && !asc->fn_found) {
 		hid_info(hdev, "Fn key not found (Apple Wireless Keyboard clone?), disabling Fn key handling\n");
-		asc->quirks = 0;
+		asc->quirks &= ~APPLE_HAS_FN;
 	}
 
 	return 0;
diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index e60e41e77502..f7705a057f0f 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -33,11 +33,22 @@
 
 struct uhid_device {
 	struct mutex devlock;
+
+	/* This flag tracks whether the HID device is usable for commands from
+	 * userspace. The flag is already set before hid_add_device(), which
+	 * runs in workqueue context, to allow hid_add_device() to communicate
+	 * with userspace.
+	 * However, if hid_add_device() fails, the flag is cleared without
+	 * holding devlock.
+	 * We guarantee that if @running changes from true to false while you're
+	 * holding @devlock, it's still fine to access @hid.
+	 */
 	bool running;
 
 	__u8 *rd_data;
 	uint rd_size;
 
+	/* When this is NULL, userspace may use UHID_CREATE/UHID_CREATE2. */
 	struct hid_device *hid;
 	struct uhid_event input_buf;
 
@@ -68,9 +79,18 @@ static void uhid_device_add_worker(struct work_struct *work)
 	if (ret) {
 		hid_err(uhid->hid, "Cannot register HID device: error %d\n", ret);
 
-		hid_destroy_device(uhid->hid);
-		uhid->hid = NULL;
+		/* We used to call hid_destroy_device() here, but that's really
+		 * messy to get right because we have to coordinate with
+		 * concurrent writes from userspace that might be in the middle
+		 * of using uhid->hid.
+		 * Just leave uhid->hid as-is for now, and clean it up when
+		 * userspace tries to close or reinitialize the uhid instance.
+		 *
+		 * However, we do have to clear the ->running flag and do a
+		 * wakeup to make sure userspace knows that the device is gone.
+		 */
 		uhid->running = false;
+		wake_up_interruptible(&uhid->report_wait);
 	}
 }
 
@@ -479,7 +499,7 @@ static int uhid_dev_create2(struct uhid_device *uhid,
 	void *rd_data;
 	int ret;
 
-	if (uhid->running)
+	if (uhid->hid)
 		return -EALREADY;
 
 	rd_size = ev->u.create2.rd_size;
@@ -560,7 +580,7 @@ static int uhid_dev_create(struct uhid_device *uhid,
 
 static int uhid_dev_destroy(struct uhid_device *uhid)
 {
-	if (!uhid->running)
+	if (!uhid->hid)
 		return -EINVAL;
 
 	uhid->running = false;
@@ -569,6 +589,7 @@ static int uhid_dev_destroy(struct uhid_device *uhid)
 	cancel_work_sync(&uhid->worker);
 
 	hid_destroy_device(uhid->hid);
+	uhid->hid = NULL;
 	kfree(uhid->rd_data);
 
 	return 0;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index fbf14a14bdd4..bfce62dbe0ac 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1693,6 +1693,10 @@ static void wacom_wac_finger_pre_report(struct hid_device *hdev,
 	struct hid_data* hid_data = &wacom_wac->hid_data;
 	int i;
 
+	hid_data->cc_report = 0;
+	hid_data->cc_index = -1;
+	hid_data->cc_value_index = -1;
+
 	for (i = 0; i < report->maxfield; i++) {
 		struct hid_field *field = report->field[i];
 		int j;
diff --git a/drivers/hsi/hsi_core.c b/drivers/hsi/hsi_core.c
index e9d63b966caf..4a9fd745b8cb 100644
--- a/drivers/hsi/hsi_core.c
+++ b/drivers/hsi/hsi_core.c
@@ -115,6 +115,7 @@ struct hsi_client *hsi_new_client(struct hsi_port *port,
 	if (device_register(&cl->device) < 0) {
 		pr_err("hsi: failed to register client: %s\n", info->name);
 		put_device(&cl->device);
+		goto err;
 	}
 
 	return cl;
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index d19ad92eede9..b7d7f4088568 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -294,7 +294,7 @@ static int i8k_get_fan_nominal_speed(int fan, int speed)
 }
 
 /*
- * Set the fan speed (off, low, high). Returns the new fan status.
+ * Set the fan speed (off, low, high, ...).
  */
 static int i8k_set_fan(int fan, int speed)
 {
@@ -303,7 +303,7 @@ static int i8k_set_fan(int fan, int speed)
 	speed = (speed < 0) ? 0 : ((speed > i8k_fan_max) ? i8k_fan_max : speed);
 	regs.ebx = (fan & 0xff) | (speed << 8);
 
-	return i8k_smm(&regs) ? : i8k_get_fan_status(fan);
+	return i8k_smm(&regs);
 }
 
 static int i8k_get_temp_type(int sensor)
@@ -417,7 +417,7 @@ static int
 i8k_ioctl_unlocked(struct file *fp, unsigned int cmd, unsigned long arg)
 {
 	int val = 0;
-	int speed;
+	int speed, err;
 	unsigned char buff[16];
 	int __user *argp = (int __user *)arg;
 
@@ -478,7 +478,11 @@ i8k_ioctl_unlocked(struct file *fp, unsigned int cmd, unsigned long arg)
 		if (copy_from_user(&speed, argp + 1, sizeof(int)))
 			return -EFAULT;
 
-		val = i8k_set_fan(val, speed);
+		err = i8k_set_fan(val, speed);
+		if (err < 0)
+			return err;
+
+		val = i8k_get_fan_status(val);
 		break;
 
 	default:
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 1e9f029a328a..d899ae5470fa 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -265,7 +265,7 @@ static const struct lm90_params lm90_params[] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT
 		  | LM90_HAVE_BROKEN_ALERT,
 		.alert_alarms = 0x7c,
-		.max_convrate = 8,
+		.max_convrate = 7,
 	},
 	[lm86] = {
 		.flags = LM90_HAVE_OFFSET | LM90_HAVE_REM_LIMIT_EXT,
diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index a658f975605a..fe51d3fb5c6b 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -645,7 +645,7 @@ static int brcmstb_i2c_probe(struct platform_device *pdev)
 
 	/* set the data in/out register size for compatible SoCs */
 	if (of_device_is_compatible(dev->device->of_node,
-				    "brcmstb,brcmper-i2c"))
+				    "brcm,brcmper-i2c"))
 		dev->data_regsz = sizeof(u8);
 	else
 		dev->data_regsz = sizeof(u32);
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 96f8230cd2d3..5c32a7ef476d 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -49,10 +49,10 @@ enum dw_pci_ctl_id_t {
 };
 
 struct dw_scl_sda_cfg {
-	u32 ss_hcnt;
-	u32 fs_hcnt;
-	u32 ss_lcnt;
-	u32 fs_lcnt;
+	u16 ss_hcnt;
+	u16 fs_hcnt;
+	u16 ss_lcnt;
+	u16 fs_lcnt;
 	u32 sda_hold;
 };
 
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 0e04b27e3158..b577c64f3b3e 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -762,6 +762,11 @@ static int i801_block_transaction(struct i801_priv *priv,
 	int result = 0;
 	unsigned char hostc;
 
+	if (read_write == I2C_SMBUS_READ && command == I2C_SMBUS_BLOCK_DATA)
+		data->block[0] = I2C_SMBUS_BLOCK_MAX;
+	else if (data->block[0] < 1 || data->block[0] > I2C_SMBUS_BLOCK_MAX)
+		return -EPROTO;
+
 	if (command == I2C_SMBUS_I2C_BLOCK_DATA) {
 		if (read_write == I2C_SMBUS_WRITE) {
 			/* set I2C_EN bit in configuration register */
@@ -775,16 +780,6 @@ static int i801_block_transaction(struct i801_priv *priv,
 		}
 	}
 
-	if (read_write == I2C_SMBUS_WRITE
-	 || command == I2C_SMBUS_I2C_BLOCK_DATA) {
-		if (data->block[0] < 1)
-			data->block[0] = 1;
-		if (data->block[0] > I2C_SMBUS_BLOCK_MAX)
-			data->block[0] = I2C_SMBUS_BLOCK_MAX;
-	} else {
-		data->block[0] = 32;	/* max for SMBus block reads */
-	}
-
 	/* Experience has shown that the block buffer can only be used for
 	   SMBus (not I2C) block transactions, even though the datasheet
 	   doesn't mention this limitation. */
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 90e4f839eb1c..d153fc28e6bf 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -107,23 +107,30 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
 /* Sometimes 9th clock pulse isn't generated, and slave doesn't release
  * the bus, because it wants to send ACK.
  * Following sequence of enabling/disabling and sending start/stop generates
- * the 9 pulses, so it's all OK.
+ * the 9 pulses, each with a START then ending with STOP, so it's all OK.
  */
 static void mpc_i2c_fixup(struct mpc_i2c *i2c)
 {
 	int k;
-	u32 delay_val = 1000000 / i2c->real_clk + 1;
-
-	if (delay_val < 2)
-		delay_val = 2;
+	unsigned long flags;
 
 	for (k = 9; k; k--) {
 		writeccr(i2c, 0);
-		writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
+		writeb(0, i2c->base + MPC_I2C_SR); /* clear any status bits */
+		writeccr(i2c, CCR_MEN | CCR_MSTA); /* START */
+		readb(i2c->base + MPC_I2C_DR); /* init xfer */
+		udelay(15); /* let it hit the bus */
+		local_irq_save(flags); /* should not be delayed further */
+		writeccr(i2c, CCR_MEN | CCR_MSTA | CCR_RSTA); /* delay SDA */
 		readb(i2c->base + MPC_I2C_DR);
-		writeccr(i2c, CCR_MEN);
-		udelay(delay_val << 1);
+		if (k != 1)
+			udelay(5);
+		local_irq_restore(flags);
 	}
+	writeccr(i2c, CCR_MEN); /* Initiate STOP */
+	readb(i2c->base + MPC_I2C_DR);
+	udelay(15); /* Let STOP propagate */
+	writeccr(i2c, 0);
 }
 
 static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 4b947d5cafe2..c5c175b72f21 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -870,7 +870,8 @@ int ib_find_gid(struct ib_device *device, union ib_gid *gid,
 		for (i = 0; i < device->port_immutable[port].gid_tbl_len; ++i) {
 			ret = ib_query_gid(device, port, i, &tmp_gid, NULL);
 			if (ret)
-				return ret;
+				continue;
+
 			if (!memcmp(&tmp_gid, gid, sizeof *gid)) {
 				*port_num = port;
 				if (index)
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index 87bc7b0db892..2eeac8401c92 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -1974,6 +1974,7 @@ int c4iw_ib_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	memset(attr, 0, sizeof *attr);
 	memset(init_attr, 0, sizeof *init_attr);
 	attr->qp_state = to_ib_qp_state(qhp->attr.state);
+	attr->cur_qp_state = to_ib_qp_state(qhp->attr.state);
 	init_attr->cap.max_send_wr = qhp->attr.sq_num_entries;
 	init_attr->cap.max_recv_wr = qhp->attr.rq_num_entries;
 	init_attr->cap.max_send_sge = qhp->attr.sq_max_sges;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 764e35a54457..0aa2400db8fa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -475,6 +475,9 @@ static int hns_roce_query_gid(struct ib_device *ib_dev, u8 port_num, int index,
 static int hns_roce_query_pkey(struct ib_device *ib_dev, u8 port, u16 index,
 			       u16 *pkey)
 {
+	if (index > 0)
+		return -EINVAL;
+
 	*pkey = PKEY_ID;
 
 	return 0;
@@ -553,7 +556,7 @@ static int hns_roce_mmap(struct ib_ucontext *context,
 		return -EINVAL;
 
 	if (vma->vm_pgoff == 0) {
-		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+		vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
 		if (io_remap_pfn_range(vma, vma->vm_start,
 				       to_hr_ucontext(context)->uar.pfn,
 				       PAGE_SIZE, vma->vm_page_prot))
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index 61927c165b59..e67ed9141cd8 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -137,7 +137,7 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 		}
 	},
 	[IB_OPCODE_RC_SEND_MIDDLE]		= {
-		.name	= "IB_OPCODE_RC_SEND_MIDDLE]",
+		.name	= "IB_OPCODE_RC_SEND_MIDDLE",
 		.mask	= RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_SEND_MASK
 				| RXE_MIDDLE_MASK,
 		.length = RXE_BTH_BYTES,
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 323b86b38b3a..6cd2ae95e21e 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -586,11 +586,6 @@ static const struct dmi_system_id i8042_dmi_forcemux_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
 		},
-	}, {
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
-		},
 	},
 	{ }
 };
@@ -677,6 +672,12 @@ static const struct dmi_system_id i8042_dmi_noselftest_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Z450LA"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
+		},
+	},
 	{ }
 };
 static const struct dmi_system_id __initconst i8042_dmi_reset_table[] = {
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index a3279f303b49..45c809f3d24f 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -28,6 +28,7 @@
 #include <linux/amd-iommu.h>
 #include <linux/export.h>
 #include <linux/iommu.h>
+#include <linux/iopoll.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/gart.h>
@@ -715,6 +716,7 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
 		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
 		if (status & (MMIO_STATUS_GALOG_RUN_MASK))
 			break;
+		udelay(10);
 	}
 
 	if (i >= LOOP_TIMEOUT)
diff --git a/drivers/md/persistent-data/dm-btree.c b/drivers/md/persistent-data/dm-btree.c
index 386215245dfe..85273da5da20 100644
--- a/drivers/md/persistent-data/dm-btree.c
+++ b/drivers/md/persistent-data/dm-btree.c
@@ -83,14 +83,16 @@ void inc_children(struct dm_transaction_manager *tm, struct btree_node *n,
 }
 
 static int insert_at(size_t value_size, struct btree_node *node, unsigned index,
-		      uint64_t key, void *value)
-		      __dm_written_to_disk(value)
+		     uint64_t key, void *value)
+	__dm_written_to_disk(value)
 {
 	uint32_t nr_entries = le32_to_cpu(node->header.nr_entries);
+	uint32_t max_entries = le32_to_cpu(node->header.max_entries);
 	__le64 key_le = cpu_to_le64(key);
 
 	if (index > nr_entries ||
-	    index >= le32_to_cpu(node->header.max_entries)) {
+	    index >= max_entries ||
+	    nr_entries >= max_entries) {
 		DMERR("too many entries in btree node for insert");
 		__dm_unbless_for_disk(value);
 		return -ENOMEM;
diff --git a/drivers/md/persistent-data/dm-space-map-common.c b/drivers/md/persistent-data/dm-space-map-common.c
index ca09ad2a639c..6fa4a68e78b0 100644
--- a/drivers/md/persistent-data/dm-space-map-common.c
+++ b/drivers/md/persistent-data/dm-space-map-common.c
@@ -279,6 +279,11 @@ int sm_ll_lookup_bitmap(struct ll_disk *ll, dm_block_t b, uint32_t *result)
 	struct disk_index_entry ie_disk;
 	struct dm_block *blk;
 
+	if (b >= ll->nr_blocks) {
+		DMERR_LIMIT("metadata block out of bounds");
+		return -EINVAL;
+	}
+
 	b = do_div(index, ll->entries_per_block);
 	r = ll->load_ie(ll, index, &ie_disk);
 	if (r < 0)
diff --git a/drivers/media/common/saa7146/saa7146_fops.c b/drivers/media/common/saa7146/saa7146_fops.c
index 930d2c94d5d3..2c9365a39270 100644
--- a/drivers/media/common/saa7146/saa7146_fops.c
+++ b/drivers/media/common/saa7146/saa7146_fops.c
@@ -524,7 +524,7 @@ int saa7146_vv_init(struct saa7146_dev* dev, struct saa7146_ext_vv *ext_vv)
 		ERR("out of memory. aborting.\n");
 		kfree(vv);
 		v4l2_ctrl_handler_free(hdl);
-		return -1;
+		return -ENOMEM;
 	}
 
 	saa7146_video_uops.init(dev,vv);
diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
index 0418b5a0fb64..32a2e6ffdb09 100644
--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -1225,7 +1225,7 @@ static const struct dvb_device dvbdev_dvr = {
 };
 int dvb_dmxdev_init(struct dmxdev *dmxdev, struct dvb_adapter *dvb_adapter)
 {
-	int i;
+	int i, ret;
 
 	if (dmxdev->demux->open(dmxdev->demux) < 0)
 		return -EUSERS;
@@ -1243,14 +1243,26 @@ int dvb_dmxdev_init(struct dmxdev *dmxdev, struct dvb_adapter *dvb_adapter)
 					    DMXDEV_STATE_FREE);
 	}
 
-	dvb_register_device(dvb_adapter, &dmxdev->dvbdev, &dvbdev_demux, dmxdev,
+	ret = dvb_register_device(dvb_adapter, &dmxdev->dvbdev, &dvbdev_demux, dmxdev,
 			    DVB_DEVICE_DEMUX, dmxdev->filternum);
-	dvb_register_device(dvb_adapter, &dmxdev->dvr_dvbdev, &dvbdev_dvr,
+	if (ret < 0)
+		goto err_register_dvbdev;
+
+	ret = dvb_register_device(dvb_adapter, &dmxdev->dvr_dvbdev, &dvbdev_dvr,
 			    dmxdev, DVB_DEVICE_DVR, dmxdev->filternum);
+	if (ret < 0)
+		goto err_register_dvr_dvbdev;
 
 	dvb_ringbuffer_init(&dmxdev->dvr_buffer, NULL, 8192);
 
 	return 0;
+
+err_register_dvr_dvbdev:
+	dvb_unregister_device(dmxdev->dvbdev);
+err_register_dvbdev:
+	vfree(dmxdev->filter);
+	dmxdev->filter = NULL;
+	return ret;
 }
 
 EXPORT_SYMBOL(dvb_dmxdev_init);
diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index ddf9c44877a2..ea2eab2d5be9 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -4462,8 +4462,10 @@ static struct dvb_frontend *dib8000_init(struct i2c_adapter *i2c_adap, u8 i2c_ad
 
 	state->timf_default = cfg->pll->timf;
 
-	if (dib8000_identify(&state->i2c) == 0)
+	if (dib8000_identify(&state->i2c) == 0) {
+		kfree(fe);
 		goto error;
+	}
 
 	dibx000_init_i2c_master(&state->i2c_master, DIB8000, state->i2c.adap, state->i2c.addr);
 
diff --git a/drivers/media/firewire/firedtv-avc.c b/drivers/media/firewire/firedtv-avc.c
index 280b5ffea592..3a373711f5ad 100644
--- a/drivers/media/firewire/firedtv-avc.c
+++ b/drivers/media/firewire/firedtv-avc.c
@@ -1169,7 +1169,11 @@ int avc_ca_pmt(struct firedtv *fdtv, char *msg, int length)
 		read_pos += program_info_length;
 		write_pos += program_info_length;
 	}
-	while (read_pos < length) {
+	while (read_pos + 4 < length) {
+		if (write_pos + 4 >= sizeof(c->operand) - 4) {
+			ret = -EINVAL;
+			goto out;
+		}
 		c->operand[write_pos++] = msg[read_pos++];
 		c->operand[write_pos++] = msg[read_pos++];
 		c->operand[write_pos++] = msg[read_pos++];
@@ -1181,13 +1185,17 @@ int avc_ca_pmt(struct firedtv *fdtv, char *msg, int length)
 		c->operand[write_pos++] = es_info_length >> 8;
 		c->operand[write_pos++] = es_info_length & 0xff;
 		if (es_info_length > 0) {
+			if (read_pos >= length) {
+				ret = -EINVAL;
+				goto out;
+			}
 			pmt_cmd_id = msg[read_pos++];
 			if (pmt_cmd_id != 1 && pmt_cmd_id != 4)
 				dev_err(fdtv->device, "invalid pmt_cmd_id %d "
 					"at stream level\n", pmt_cmd_id);
 
-			if (es_info_length > sizeof(c->operand) - 4 -
-					     write_pos) {
+			if (es_info_length > sizeof(c->operand) - 4 - write_pos ||
+			    es_info_length > length - read_pos) {
 				ret = -EINVAL;
 				goto out;
 			}
diff --git a/drivers/media/firewire/firedtv-ci.c b/drivers/media/firewire/firedtv-ci.c
index edbb30fdd9d9..93fb4b7312af 100644
--- a/drivers/media/firewire/firedtv-ci.c
+++ b/drivers/media/firewire/firedtv-ci.c
@@ -138,6 +138,8 @@ static int fdtv_ca_pmt(struct firedtv *fdtv, void *arg)
 	} else {
 		data_length = msg->msg[3];
 	}
+	if (data_length > sizeof(msg->msg) - data_pos)
+		return -EINVAL;
 
 	return avc_ca_pmt(fdtv, &msg->msg[data_pos], data_length);
 }
diff --git a/drivers/media/pci/b2c2/flexcop-pci.c b/drivers/media/pci/b2c2/flexcop-pci.c
index 4cac1fc233f2..98e94cd8bfad 100644
--- a/drivers/media/pci/b2c2/flexcop-pci.c
+++ b/drivers/media/pci/b2c2/flexcop-pci.c
@@ -184,6 +184,8 @@ static irqreturn_t flexcop_pci_isr(int irq, void *dev_id)
 		dma_addr_t cur_addr =
 			fc->read_ibi_reg(fc,dma1_008).dma_0x8.dma_cur_addr << 2;
 		u32 cur_pos = cur_addr - fc_pci->dma[0].dma_addr0;
+		if (cur_pos > fc_pci->dma[0].size * 2)
+			goto error;
 
 		deb_irq("%u irq: %08x cur_addr: %llx: cur_pos: %08x, "
 			"last_cur_pos: %08x ",
@@ -225,6 +227,7 @@ static irqreturn_t flexcop_pci_isr(int irq, void *dev_id)
 		ret = IRQ_NONE;
 	}
 
+error:
 	spin_unlock_irqrestore(&fc_pci->irq_lock, flags);
 	return ret;
 }
diff --git a/drivers/media/pci/saa7146/hexium_gemini.c b/drivers/media/pci/saa7146/hexium_gemini.c
index be85a2c4318e..be91a2de81dc 100644
--- a/drivers/media/pci/saa7146/hexium_gemini.c
+++ b/drivers/media/pci/saa7146/hexium_gemini.c
@@ -296,7 +296,12 @@ static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_d
 	hexium_set_input(hexium, 0);
 	hexium->cur_input = 0;
 
-	saa7146_vv_init(dev, &vv_data);
+	ret = saa7146_vv_init(dev, &vv_data);
+	if (ret) {
+		i2c_del_adapter(&hexium->i2c_adapter);
+		kfree(hexium);
+		return ret;
+	}
 
 	vv_data.vid_ops.vidioc_enum_input = vidioc_enum_input;
 	vv_data.vid_ops.vidioc_g_input = vidioc_g_input;
diff --git a/drivers/media/pci/saa7146/hexium_orion.c b/drivers/media/pci/saa7146/hexium_orion.c
index dc07ca37ebd0..e8e96c7a5784 100644
--- a/drivers/media/pci/saa7146/hexium_orion.c
+++ b/drivers/media/pci/saa7146/hexium_orion.c
@@ -366,10 +366,16 @@ static struct saa7146_ext_vv vv_data;
 static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_data *info)
 {
 	struct hexium *hexium = (struct hexium *) dev->ext_priv;
+	int ret;
 
 	DEB_EE("\n");
 
-	saa7146_vv_init(dev, &vv_data);
+	ret = saa7146_vv_init(dev, &vv_data);
+	if (ret) {
+		pr_err("Error in saa7146_vv_init()\n");
+		return ret;
+	}
+
 	vv_data.vid_ops.vidioc_enum_input = vidioc_enum_input;
 	vv_data.vid_ops.vidioc_g_input = vidioc_g_input;
 	vv_data.vid_ops.vidioc_s_input = vidioc_s_input;
diff --git a/drivers/media/pci/saa7146/mxb.c b/drivers/media/pci/saa7146/mxb.c
index 3e8753c9e1e4..849c2a1d09f9 100644
--- a/drivers/media/pci/saa7146/mxb.c
+++ b/drivers/media/pci/saa7146/mxb.c
@@ -694,10 +694,16 @@ static struct saa7146_ext_vv vv_data;
 static int mxb_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_data *info)
 {
 	struct mxb *mxb;
+	int ret;
 
 	DEB_EE("dev:%p\n", dev);
 
-	saa7146_vv_init(dev, &vv_data);
+	ret = saa7146_vv_init(dev, &vv_data);
+	if (ret) {
+		ERR("Error in saa7146_vv_init()");
+		return ret;
+	}
+
 	if (mxb_probe(dev)) {
 		saa7146_vv_release(dev);
 		return -1;
diff --git a/drivers/media/rc/igorplugusb.c b/drivers/media/rc/igorplugusb.c
index 5cf983be07a2..0f4c4c39bf6d 100644
--- a/drivers/media/rc/igorplugusb.c
+++ b/drivers/media/rc/igorplugusb.c
@@ -73,9 +73,11 @@ static void igorplugusb_irdata(struct igorplugusb *ir, unsigned len)
 	if (start >= len) {
 		dev_err(ir->dev, "receive overflow invalid: %u", overflow);
 	} else {
-		if (overflow > 0)
+		if (overflow > 0) {
 			dev_warn(ir->dev, "receive overflow, at least %u lost",
 								overflow);
+			ir_raw_event_reset(ir->rc);
+		}
 
 		do {
 			rawir.duration = ir->buf_in[i] * 85333;
diff --git a/drivers/media/rc/mceusb.c b/drivers/media/rc/mceusb.c
index b78d70685b1c..49122f442b87 100644
--- a/drivers/media/rc/mceusb.c
+++ b/drivers/media/rc/mceusb.c
@@ -1129,7 +1129,7 @@ static void mceusb_gen1_init(struct mceusb_dev *ir)
 	 */
 	ret = usb_control_msg(ir->usbdev, usb_rcvctrlpipe(ir->usbdev, 0),
 			      USB_REQ_SET_ADDRESS, USB_TYPE_VENDOR, 0, 0,
-			      data, USB_CTRL_MSG_SZ, HZ * 3);
+			      data, USB_CTRL_MSG_SZ, 3000);
 	dev_dbg(dev, "set address - ret = %d", ret);
 	dev_dbg(dev, "set address - data[0] = %d, data[1] = %d",
 						data[0], data[1]);
@@ -1137,20 +1137,20 @@ static void mceusb_gen1_init(struct mceusb_dev *ir)
 	/* set feature: bit rate 38400 bps */
 	ret = usb_control_msg(ir->usbdev, usb_sndctrlpipe(ir->usbdev, 0),
 			      USB_REQ_SET_FEATURE, USB_TYPE_VENDOR,
-			      0xc04e, 0x0000, NULL, 0, HZ * 3);
+			      0xc04e, 0x0000, NULL, 0, 3000);
 
 	dev_dbg(dev, "set feature - ret = %d", ret);
 
 	/* bRequest 4: set char length to 8 bits */
 	ret = usb_control_msg(ir->usbdev, usb_sndctrlpipe(ir->usbdev, 0),
 			      4, USB_TYPE_VENDOR,
-			      0x0808, 0x0000, NULL, 0, HZ * 3);
+			      0x0808, 0x0000, NULL, 0, 3000);
 	dev_dbg(dev, "set char length - retB = %d", ret);
 
 	/* bRequest 2: set handshaking to use DTR/DSR */
 	ret = usb_control_msg(ir->usbdev, usb_sndctrlpipe(ir->usbdev, 0),
 			      2, USB_TYPE_VENDOR,
-			      0x0000, 0x0100, NULL, 0, HZ * 3);
+			      0x0000, 0x0100, NULL, 0, 3000);
 	dev_dbg(dev, "set handshake  - retC = %d", ret);
 
 	/* device resume */
diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index 05ba47bc0b61..5f3c1c204f64 100644
--- a/drivers/media/rc/redrat3.c
+++ b/drivers/media/rc/redrat3.c
@@ -427,7 +427,7 @@ static int redrat3_send_cmd(int cmd, struct redrat3_dev *rr3)
 	udev = rr3->udev;
 	res = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0), cmd,
 			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-			      0x0000, 0x0000, data, sizeof(u8), HZ * 10);
+			      0x0000, 0x0000, data, sizeof(u8), 10000);
 
 	if (res < 0) {
 		dev_err(rr3->dev, "%s: Error sending rr3 cmd res %d, data %d",
@@ -493,7 +493,7 @@ static u32 redrat3_get_timeout(struct redrat3_dev *rr3)
 	pipe = usb_rcvctrlpipe(rr3->udev, 0);
 	ret = usb_control_msg(rr3->udev, pipe, RR3_GET_IR_PARAM,
 			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-			      RR3_IR_IO_SIG_TIMEOUT, 0, tmp, len, HZ * 5);
+			      RR3_IR_IO_SIG_TIMEOUT, 0, tmp, len, 5000);
 	if (ret != len)
 		dev_warn(rr3->dev, "Failed to read timeout from hardware\n");
 	else {
@@ -523,7 +523,7 @@ static int redrat3_set_timeout(struct rc_dev *rc_dev, unsigned int timeoutns)
 	ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0), RR3_SET_IR_PARAM,
 		     USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
 		     RR3_IR_IO_SIG_TIMEOUT, 0, timeout, sizeof(*timeout),
-		     HZ * 25);
+		     25000);
 	dev_dbg(dev, "set ir parm timeout %d ret 0x%02x\n",
 						be32_to_cpu(*timeout), ret);
 
@@ -557,32 +557,32 @@ static void redrat3_reset(struct redrat3_dev *rr3)
 	*val = 0x01;
 	rc = usb_control_msg(udev, rxpipe, RR3_RESET,
 			     USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-			     RR3_CPUCS_REG_ADDR, 0, val, len, HZ * 25);
+			     RR3_CPUCS_REG_ADDR, 0, val, len, 25000);
 	dev_dbg(dev, "reset returned 0x%02x\n", rc);
 
 	*val = length_fuzz;
 	rc = usb_control_msg(udev, txpipe, RR3_SET_IR_PARAM,
 			     USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-			     RR3_IR_IO_LENGTH_FUZZ, 0, val, len, HZ * 25);
+			     RR3_IR_IO_LENGTH_FUZZ, 0, val, len, 25000);
 	dev_dbg(dev, "set ir parm len fuzz %d rc 0x%02x\n", *val, rc);
 
 	*val = (65536 - (minimum_pause * 2000)) / 256;
 	rc = usb_control_msg(udev, txpipe, RR3_SET_IR_PARAM,
 			     USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-			     RR3_IR_IO_MIN_PAUSE, 0, val, len, HZ * 25);
+			     RR3_IR_IO_MIN_PAUSE, 0, val, len, 25000);
 	dev_dbg(dev, "set ir parm min pause %d rc 0x%02x\n", *val, rc);
 
 	*val = periods_measure_carrier;
 	rc = usb_control_msg(udev, txpipe, RR3_SET_IR_PARAM,
 			     USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-			     RR3_IR_IO_PERIODS_MF, 0, val, len, HZ * 25);
+			     RR3_IR_IO_PERIODS_MF, 0, val, len, 25000);
 	dev_dbg(dev, "set ir parm periods measure carrier %d rc 0x%02x", *val,
 									rc);
 
 	*val = RR3_DRIVER_MAXLENS;
 	rc = usb_control_msg(udev, txpipe, RR3_SET_IR_PARAM,
 			     USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-			     RR3_IR_IO_MAX_LENGTHS, 0, val, len, HZ * 25);
+			     RR3_IR_IO_MAX_LENGTHS, 0, val, len, 25000);
 	dev_dbg(dev, "set ir parm max lens %d rc 0x%02x\n", *val, rc);
 
 	kfree(val);
@@ -602,7 +602,7 @@ static void redrat3_get_firmware_rev(struct redrat3_dev *rr3)
 	rc = usb_control_msg(rr3->udev, usb_rcvctrlpipe(rr3->udev, 0),
 			     RR3_FW_VERSION,
 			     USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-			     0, 0, buffer, RR3_FW_VERSION_LEN, HZ * 5);
+			     0, 0, buffer, RR3_FW_VERSION_LEN, 5000);
 
 	if (rc >= 0)
 		dev_info(rr3->dev, "Firmware rev: %s", buffer);
@@ -842,14 +842,14 @@ static int redrat3_transmit_ir(struct rc_dev *rcdev, unsigned *txbuf,
 
 	pipe = usb_sndbulkpipe(rr3->udev, rr3->ep_out->bEndpointAddress);
 	ret = usb_bulk_msg(rr3->udev, pipe, irdata,
-			    sendbuf_len, &ret_len, 10 * HZ);
+			    sendbuf_len, &ret_len, 10000);
 	dev_dbg(dev, "sent %d bytes, (ret %d)\n", ret_len, ret);
 
 	/* now tell the hardware to transmit what we sent it */
 	pipe = usb_rcvctrlpipe(rr3->udev, 0);
 	ret = usb_control_msg(rr3->udev, pipe, RR3_TX_SEND_SIGNAL,
 			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-			      0, 0, irdata, 2, HZ * 10);
+			      0, 0, irdata, 2, 10000);
 
 	if (ret < 0)
 		dev_err(dev, "Error: control msg send failed, rc %d\n", ret);
diff --git a/drivers/media/tuners/msi001.c b/drivers/media/tuners/msi001.c
index 3a12ef35682b..64d98517f470 100644
--- a/drivers/media/tuners/msi001.c
+++ b/drivers/media/tuners/msi001.c
@@ -464,6 +464,13 @@ static int msi001_probe(struct spi_device *spi)
 			V4L2_CID_RF_TUNER_BANDWIDTH_AUTO, 0, 1, 1, 1);
 	dev->bandwidth = v4l2_ctrl_new_std(&dev->hdl, &msi001_ctrl_ops,
 			V4L2_CID_RF_TUNER_BANDWIDTH, 200000, 8000000, 1, 200000);
+	if (dev->hdl.error) {
+		ret = dev->hdl.error;
+		dev_err(&spi->dev, "Could not initialize controls\n");
+		/* control init failed, free handler */
+		goto err_ctrl_handler_free;
+	}
+
 	v4l2_ctrl_auto_cluster(2, &dev->bandwidth_auto, 0, false);
 	dev->lna_gain = v4l2_ctrl_new_std(&dev->hdl, &msi001_ctrl_ops,
 			V4L2_CID_RF_TUNER_LNA_GAIN, 0, 1, 1, 1);
diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index 72a47da0db2a..e56837414e2c 100644
--- a/drivers/media/tuners/si2157.c
+++ b/drivers/media/tuners/si2157.c
@@ -89,7 +89,7 @@ static int si2157_init(struct dvb_frontend *fe)
 	dev_dbg(&client->dev, "\n");
 
 	/* Try to get Xtal trim property, to verify tuner still running */
-	memcpy(cmd.args, "\x15\x00\x04\x02", 4);
+	memcpy(cmd.args, "\x15\x00\x02\x04", 4);
 	cmd.wlen = 4;
 	cmd.rlen = 4;
 	ret = si2157_cmd_execute(client, &cmd);
diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
index a93fc1839e13..3d6e991df926 100644
--- a/drivers/media/usb/b2c2/flexcop-usb.c
+++ b/drivers/media/usb/b2c2/flexcop-usb.c
@@ -87,7 +87,7 @@ static int flexcop_usb_readwrite_dw(struct flexcop_device *fc, u16 wRegOffsPCI,
 			0,
 			fc_usb->data,
 			sizeof(u32),
-			B2C2_WAIT_FOR_OPERATION_RDW * HZ);
+			B2C2_WAIT_FOR_OPERATION_RDW);
 
 	if (ret != sizeof(u32)) {
 		err("error while %s dword from %d (%d).", read ? "reading" :
@@ -155,7 +155,7 @@ static int flexcop_usb_v8_memory_req(struct flexcop_usb *fc_usb,
 			wIndex,
 			fc_usb->data,
 			buflen,
-			nWaitTime * HZ);
+			nWaitTime);
 	if (ret != buflen)
 		ret = -EIO;
 
@@ -249,13 +249,13 @@ static int flexcop_usb_i2c_req(struct flexcop_i2c_adapter *i2c,
 		/* DKT 020208 - add this to support special case of DiSEqC */
 	case USB_FUNC_I2C_CHECKWRITE:
 		pipe = B2C2_USB_CTRL_PIPE_OUT;
-		nWaitTime = 2;
+		nWaitTime = 2000;
 		request_type |= USB_DIR_OUT;
 		break;
 	case USB_FUNC_I2C_READ:
 	case USB_FUNC_I2C_REPEATREAD:
 		pipe = B2C2_USB_CTRL_PIPE_IN;
-		nWaitTime = 2;
+		nWaitTime = 2000;
 		request_type |= USB_DIR_IN;
 		break;
 	default:
@@ -282,7 +282,7 @@ static int flexcop_usb_i2c_req(struct flexcop_i2c_adapter *i2c,
 			wIndex,
 			fc_usb->data,
 			buflen,
-			nWaitTime * HZ);
+			nWaitTime);
 
 	if (ret != buflen)
 		ret = -EIO;
diff --git a/drivers/media/usb/b2c2/flexcop-usb.h b/drivers/media/usb/b2c2/flexcop-usb.h
index 25ad43166e78..247c7dbc8a61 100644
--- a/drivers/media/usb/b2c2/flexcop-usb.h
+++ b/drivers/media/usb/b2c2/flexcop-usb.h
@@ -90,13 +90,13 @@ typedef enum {
 	UTILITY_SRAM_TESTVERIFY     = 0x16,
 } flexcop_usb_utility_function_t;
 
-#define B2C2_WAIT_FOR_OPERATION_RW (1*HZ)
-#define B2C2_WAIT_FOR_OPERATION_RDW (3*HZ)
-#define B2C2_WAIT_FOR_OPERATION_WDW (1*HZ)
+#define B2C2_WAIT_FOR_OPERATION_RW 1000
+#define B2C2_WAIT_FOR_OPERATION_RDW 3000
+#define B2C2_WAIT_FOR_OPERATION_WDW 1000
 
-#define B2C2_WAIT_FOR_OPERATION_V8READ (3*HZ)
-#define B2C2_WAIT_FOR_OPERATION_V8WRITE (3*HZ)
-#define B2C2_WAIT_FOR_OPERATION_V8FLASH (3*HZ)
+#define B2C2_WAIT_FOR_OPERATION_V8READ 3000
+#define B2C2_WAIT_FOR_OPERATION_V8WRITE 3000
+#define B2C2_WAIT_FOR_OPERATION_V8FLASH 3000
 
 typedef enum {
 	V8_MEMORY_PAGE_DVB_CI = 0x20,
diff --git a/drivers/media/usb/cpia2/cpia2_usb.c b/drivers/media/usb/cpia2/cpia2_usb.c
index 4f4a130f17af..447d6a52af3b 100644
--- a/drivers/media/usb/cpia2/cpia2_usb.c
+++ b/drivers/media/usb/cpia2/cpia2_usb.c
@@ -565,7 +565,7 @@ static int write_packet(struct usb_device *udev,
 			       0,	/* index */
 			       buf,	/* buffer */
 			       size,
-			       HZ);
+			       1000);
 
 	kfree(buf);
 	return ret;
@@ -597,7 +597,7 @@ static int read_packet(struct usb_device *udev,
 			       0,	/* index */
 			       buf,	/* buffer */
 			       size,
-			       HZ);
+			       1000);
 
 	if (ret >= 0)
 		memcpy(registers, buf, size);
diff --git a/drivers/media/usb/dvb-usb/dib0700_core.c b/drivers/media/usb/dvb-usb/dib0700_core.c
index 4a5ea74c91d4..1b56824fbe51 100644
--- a/drivers/media/usb/dvb-usb/dib0700_core.c
+++ b/drivers/media/usb/dvb-usb/dib0700_core.c
@@ -610,8 +610,6 @@ int dib0700_streaming_ctrl(struct dvb_usb_adapter *adap, int onoff)
 		deb_info("the endpoint number (%i) is not correct, use the adapter id instead", adap->fe_adap[0].stream.props.endpoint);
 		if (onoff)
 			st->channel_state |=	1 << (adap->id);
-		else
-			st->channel_state |=	1 << ~(adap->id);
 	} else {
 		if (onoff)
 			st->channel_state |=	1 << (adap->fe_adap[0].stream.props.endpoint-2);
diff --git a/drivers/media/usb/dvb-usb/m920x.c b/drivers/media/usb/dvb-usb/m920x.c
index eafc5c82467f..5b806779e210 100644
--- a/drivers/media/usb/dvb-usb/m920x.c
+++ b/drivers/media/usb/dvb-usb/m920x.c
@@ -284,6 +284,13 @@ static int m920x_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int nu
 			/* Should check for ack here, if we knew how. */
 		}
 		if (msg[i].flags & I2C_M_RD) {
+			char *read = kmalloc(1, GFP_KERNEL);
+			if (!read) {
+				ret = -ENOMEM;
+				kfree(read);
+				goto unlock;
+			}
+
 			for (j = 0; j < msg[i].len; j++) {
 				/* Last byte of transaction?
 				 * Send STOP, otherwise send ACK. */
@@ -291,9 +298,12 @@ static int m920x_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int nu
 
 				if ((ret = m920x_read(d->udev, M9206_I2C, 0x0,
 						      0x20 | stop,
-						      &msg[i].buf[j], 1)) != 0)
+						      read, 1)) != 0)
 					goto unlock;
+				msg[i].buf[j] = read[0];
 			}
+
+			kfree(read);
 		} else {
 			for (j = 0; j < msg[i].len; j++) {
 				/* Last byte of transaction? Then send STOP. */
diff --git a/drivers/media/usb/em28xx/em28xx-core.c b/drivers/media/usb/em28xx/em28xx-core.c
index eebd5d7088d0..fb3008a7233f 100644
--- a/drivers/media/usb/em28xx/em28xx-core.c
+++ b/drivers/media/usb/em28xx/em28xx-core.c
@@ -99,7 +99,7 @@ int em28xx_read_reg_req_len(struct em28xx *dev, u8 req, u16 reg,
 	mutex_lock(&dev->ctrl_urb_lock);
 	ret = usb_control_msg(dev->udev, pipe, req,
 			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			      0x0000, reg, dev->urb_buf, len, HZ);
+			      0x0000, reg, dev->urb_buf, len, 1000);
 	if (ret < 0) {
 		if (reg_debug)
 			printk(" failed!\n");
@@ -182,7 +182,7 @@ int em28xx_write_regs_req(struct em28xx *dev, u8 req, u16 reg, char *buf,
 	memcpy(dev->urb_buf, buf, len);
 	ret = usb_control_msg(dev->udev, pipe, req,
 			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			      0x0000, reg, dev->urb_buf, len, HZ);
+			      0x0000, reg, dev->urb_buf, len, 1000);
 	mutex_unlock(&dev->ctrl_urb_lock);
 
 	if (ret < 0)
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index 0cb8dd585235..40535db585a0 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -1488,7 +1488,7 @@ static int pvr2_upload_firmware1(struct pvr2_hdw *hdw)
 	for (address = 0; address < fwsize; address += 0x800) {
 		memcpy(fw_ptr, fw_entry->data + address, 0x800);
 		ret += usb_control_msg(hdw->usb_dev, pipe, 0xa0, 0x40, address,
-				       0, fw_ptr, 0x800, HZ);
+				       0, fw_ptr, 0x800, 1000);
 	}
 
 	trace_firmware("Upload done, releasing device's CPU");
@@ -1627,7 +1627,7 @@ int pvr2_upload_firmware2(struct pvr2_hdw *hdw)
 			((u32 *)fw_ptr)[icnt] = swab32(((u32 *)fw_ptr)[icnt]);
 
 		ret |= usb_bulk_msg(hdw->usb_dev, pipe, fw_ptr,bcnt,
-				    &actual_length, HZ);
+				    &actual_length, 1000);
 		ret |= (actual_length != bcnt);
 		if (ret) break;
 		fw_done += bcnt;
@@ -3486,7 +3486,7 @@ void pvr2_hdw_cpufw_set_enabled(struct pvr2_hdw *hdw,
 						      0xa0,0xc0,
 						      address,0,
 						      hdw->fw_buffer+address,
-						      0x800,HZ);
+						      0x800,1000);
 				if (ret < 0) break;
 			}
 
@@ -4011,7 +4011,7 @@ void pvr2_hdw_cpureset_assert(struct pvr2_hdw *hdw,int val)
 	/* Write the CPUCS register on the 8051.  The lsb of the register
 	   is the reset bit; a 1 asserts reset while a 0 clears it. */
 	pipe = usb_sndctrlpipe(hdw->usb_dev, 0);
-	ret = usb_control_msg(hdw->usb_dev,pipe,0xa0,0x40,0xe600,0,da,1,HZ);
+	ret = usb_control_msg(hdw->usb_dev,pipe,0xa0,0x40,0xe600,0,da,1,1000);
 	if (ret < 0) {
 		pvr2_trace(PVR2_TRACE_ERROR_LEGS,
 			   "cpureset_assert(%d) error=%d",val,ret);
diff --git a/drivers/media/usb/s2255/s2255drv.c b/drivers/media/usb/s2255/s2255drv.c
index f7bb78c1873c..fb5636f07e7e 100644
--- a/drivers/media/usb/s2255/s2255drv.c
+++ b/drivers/media/usb/s2255/s2255drv.c
@@ -1913,7 +1913,7 @@ static long s2255_vendor_req(struct s2255_dev *dev, unsigned char Request,
 				    USB_TYPE_VENDOR | USB_RECIP_DEVICE |
 				    USB_DIR_IN,
 				    Value, Index, buf,
-				    TransferBufferLength, HZ * 5);
+				    TransferBufferLength, USB_CTRL_SET_TIMEOUT);
 
 		if (r >= 0)
 			memcpy(TransferBuffer, buf, TransferBufferLength);
@@ -1922,7 +1922,7 @@ static long s2255_vendor_req(struct s2255_dev *dev, unsigned char Request,
 		r = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0),
 				    Request, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 				    Value, Index, buf,
-				    TransferBufferLength, HZ * 5);
+				    TransferBufferLength, USB_CTRL_SET_TIMEOUT);
 	}
 	kfree(buf);
 	return r;
diff --git a/drivers/media/usb/stk1160/stk1160-core.c b/drivers/media/usb/stk1160/stk1160-core.c
index bc029478065a..a526ea2fe587 100644
--- a/drivers/media/usb/stk1160/stk1160-core.c
+++ b/drivers/media/usb/stk1160/stk1160-core.c
@@ -76,7 +76,7 @@ int stk1160_read_reg(struct stk1160 *dev, u16 reg, u8 *value)
 		return -ENOMEM;
 	ret = usb_control_msg(dev->udev, pipe, 0x00,
 			USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			0x00, reg, buf, sizeof(u8), HZ);
+			0x00, reg, buf, sizeof(u8), 1000);
 	if (ret < 0) {
 		stk1160_err("read failed on reg 0x%x (%d)\n",
 			reg, ret);
@@ -96,7 +96,7 @@ int stk1160_write_reg(struct stk1160 *dev, u16 reg, u16 value)
 
 	ret =  usb_control_msg(dev->udev, pipe, 0x01,
 			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			value, reg, NULL, 0, HZ);
+			value, reg, NULL, 0, 1000);
 	if (ret < 0) {
 		stk1160_err("write failed on reg 0x%x (%d)\n",
 			reg, ret);
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 1d724e86f378..2a7d178a9d06 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1716,6 +1716,10 @@ static int uvc_init_video(struct uvc_streaming *stream, gfp_t gfp_flags)
 		if (ep == NULL)
 			return -EIO;
 
+		/* Reject broken descriptors. */
+		if (usb_endpoint_maxp(&ep->desc) == 0)
+			return -EIO;
+
 		ret = uvc_init_video_bulk(stream, ep, gfp_flags);
 	}
 
diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index 6bf8d643d942..31fbfd9c4b11 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -84,6 +84,7 @@ static int intel_lpss_acpi_probe(struct platform_device *pdev)
 {
 	struct intel_lpss_platform_info *info;
 	const struct acpi_device_id *id;
+	int ret;
 
 	id = acpi_match_device(intel_lpss_acpi_ids, &pdev->dev);
 	if (!id)
@@ -97,10 +98,14 @@ static int intel_lpss_acpi_probe(struct platform_device *pdev)
 	info->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	info->irq = platform_get_irq(pdev, 0);
 
+	ret = intel_lpss_probe(&pdev->dev, info);
+	if (ret)
+		return ret;
+
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	return intel_lpss_probe(&pdev->dev, info);
+	return 0;
 }
 
 static int intel_lpss_acpi_remove(struct platform_device *pdev)
diff --git a/drivers/misc/lattice-ecp3-config.c b/drivers/misc/lattice-ecp3-config.c
index 626fdcaf2510..645d26536114 100644
--- a/drivers/misc/lattice-ecp3-config.c
+++ b/drivers/misc/lattice-ecp3-config.c
@@ -81,12 +81,12 @@ static void firmware_load(const struct firmware *fw, void *context)
 
 	if (fw == NULL) {
 		dev_err(&spi->dev, "Cannot load firmware, aborting\n");
-		return;
+		goto out;
 	}
 
 	if (fw->size == 0) {
 		dev_err(&spi->dev, "Error: Firmware size is 0!\n");
-		return;
+		goto out;
 	}
 
 	/* Fill dummy data (24 stuffing bits for commands) */
@@ -108,7 +108,7 @@ static void firmware_load(const struct firmware *fw, void *context)
 		dev_err(&spi->dev,
 			"Error: No supported FPGA detected (JEDEC_ID=%08x)!\n",
 			jedec_id);
-		return;
+		goto out;
 	}
 
 	dev_info(&spi->dev, "FPGA %s detected\n", ecp3_dev[i].name);
@@ -121,7 +121,7 @@ static void firmware_load(const struct firmware *fw, void *context)
 	buffer = kzalloc(fw->size + 8, GFP_KERNEL);
 	if (!buffer) {
 		dev_err(&spi->dev, "Error: Can't allocate memory!\n");
-		return;
+		goto out;
 	}
 
 	/*
@@ -160,7 +160,7 @@ static void firmware_load(const struct firmware *fw, void *context)
 			"Error: Timeout waiting for FPGA to clear (status=%08x)!\n",
 			status);
 		kfree(buffer);
-		return;
+		goto out;
 	}
 
 	dev_info(&spi->dev, "Configuring the FPGA...\n");
@@ -186,7 +186,7 @@ static void firmware_load(const struct firmware *fw, void *context)
 	release_firmware(fw);
 
 	kfree(buffer);
-
+out:
 	complete(&data->fw_loaded);
 }
 
diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 41a5493cb68d..a5b03fb7656d 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -698,12 +698,12 @@ static int moxart_remove(struct platform_device *pdev)
 		if (!IS_ERR(host->dma_chan_rx))
 			dma_release_channel(host->dma_chan_rx);
 		mmc_remove_host(mmc);
-		mmc_free_host(mmc);
 
 		writel(0, host->base + REG_INTERRUPT_MASK);
 		writel(0, host->base + REG_POWER_CONTROL);
 		writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
 		       host->base + REG_CLOCK_CONTROL);
+		mmc_free_host(mmc);
 	}
 	return 0;
 }
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 1e2ee97b9240..578d8e12e2d2 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -971,8 +971,8 @@ static void ad_mux_machine(struct port *port, bool *update_slave_arr)
 				if (port->aggregator &&
 				    port->aggregator->is_active &&
 				    !__port_is_enabled(port)) {
-
 					__enable_port(port);
+					*update_slave_arr = true;
 				}
 			}
 			break;
@@ -1724,6 +1724,7 @@ static void ad_agg_selection_logic(struct aggregator *agg,
 			     port = port->next_port_in_aggregator) {
 				__enable_port(port);
 			}
+			*update_slave_arr = true;
 		}
 	}
 
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2b721ed392ad..0d9226bdf661 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -782,14 +782,14 @@ static bool bond_should_notify_peers(struct bonding *bond)
 	slave = rcu_dereference(bond->curr_active_slave);
 	rcu_read_unlock();
 
-	netdev_dbg(bond->dev, "bond_should_notify_peers: slave %s\n",
-		   slave ? slave->dev->name : "NULL");
-
 	if (!slave || !bond->send_peer_notif ||
 	    !netif_carrier_ok(bond->dev) ||
 	    test_bit(__LINK_STATE_LINKWATCH_PENDING, &slave->dev->state))
 		return false;
 
+	netdev_dbg(bond->dev, "bond_should_notify_peers: slave %s\n",
+		   slave ? slave->dev->name : "NULL");
+
 	return true;
 }
 
diff --git a/drivers/net/can/softing/softing_cs.c b/drivers/net/can/softing/softing_cs.c
index cdc0c7433a4b..9fbed88d6c82 100644
--- a/drivers/net/can/softing/softing_cs.c
+++ b/drivers/net/can/softing/softing_cs.c
@@ -304,7 +304,7 @@ static int softingcs_probe(struct pcmcia_device *pcmcia)
 	return 0;
 
 platform_failed:
-	kfree(dev);
+	platform_device_put(pdev);
 mem_failed:
 pcmcia_bad:
 pcmcia_failed:
diff --git a/drivers/net/can/softing/softing_fw.c b/drivers/net/can/softing/softing_fw.c
index 52fe50725d74..a74c779feb90 100644
--- a/drivers/net/can/softing/softing_fw.c
+++ b/drivers/net/can/softing/softing_fw.c
@@ -576,18 +576,19 @@ int softing_startstop(struct net_device *dev, int up)
 		if (ret < 0)
 			goto failed;
 	}
-	/* enable_error_frame */
-	/*
+
+	/* enable_error_frame
+	 *
 	 * Error reporting is switched off at the moment since
 	 * the receiving of them is not yet 100% verified
 	 * This should be enabled sooner or later
-	 *
-	if (error_reporting) {
+	 */
+	if (0 && error_reporting) {
 		ret = softing_fct_cmd(card, 51, "enable_error_frame");
 		if (ret < 0)
 			goto failed;
 	}
-	*/
+
 	/* initialize interface */
 	iowrite16(1, &card->dpram[DPRAM_FCT_PARAM + 2]);
 	iowrite16(1, &card->dpram[DPRAM_FCT_PARAM + 4]);
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index d21c68882e86..75399aa1ba95 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -328,7 +328,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 	/* device reports out of range channel id */
 	if (hf->channel >= GS_MAX_INTF)
-		goto resubmit_urb;
+		goto device_detach;
 
 	dev = usbcan->canch[hf->channel];
 
@@ -413,6 +413,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 	/* USB failure take down all interfaces */
 	if (rc == -ENODEV) {
+ device_detach:
 		for (rc = 0; rc < GS_MAX_INTF; rc++) {
 			if (usbcan->canch[rc])
 				netif_device_detach(usbcan->canch[rc]->netdev);
@@ -514,6 +515,8 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 
 	hf->echo_id = idx;
 	hf->channel = dev->channel;
+	hf->flags = 0;
+	hf->reserved = 0;
 
 	cf = (struct can_frame *)skb->data;
 
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index e680bab27dd7..ef24b619e0e5 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1302,7 +1302,12 @@ static int xcan_probe(struct platform_device *pdev)
 	spin_lock_init(&priv->tx_lock);
 
 	/* Get IRQ for the device */
-	ndev->irq = platform_get_irq(pdev, 0);
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		goto err_free;
+
+	ndev->irq = ret;
+
 	ndev->flags |= IFF_ECHO;	/* We support local echo */
 
 	platform_set_drvdata(pdev, ndev);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 1df7f5da8411..d412d942cbda 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -494,7 +494,9 @@ static void xgbe_stop_timers(struct xgbe_prv_data *pdata)
 		if (!channel->tx_ring)
 			break;
 
+		/* Deactivate the Tx timer */
 		del_timer_sync(&channel->tx_timer);
+		channel->tx_timer_active = 0;
 	}
 }
 
@@ -1966,6 +1968,14 @@ static int xgbe_rx_poll(struct xgbe_channel *channel, int budget)
 			buf2_len = xgbe_rx_buf2_len(rdata, packet, len);
 			len += buf2_len;
 
+			if (buf2_len > rdata->rx.buf.dma_len) {
+				/* Hardware inconsistency within the descriptors
+				 * that has resulted in a length underflow.
+				 */
+				error = 1;
+				goto skip_data;
+			}
+
 			if (!skb) {
 				skb = xgbe_create_skb(pdata, napi, rdata,
 						      buf1_len);
@@ -1995,8 +2005,10 @@ static int xgbe_rx_poll(struct xgbe_channel *channel, int budget)
 		if (!last || context_next)
 			goto read_again;
 
-		if (!skb)
+		if (!skb || error) {
+			dev_kfree_skb(skb);
 			goto next_packet;
+		}
 
 		/* Be sure we don't exceed the configured MTU */
 		max_len = netdev->mtu + ETH_HLEN;
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index fae551777083..6676924d5f3e 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3358,10 +3358,12 @@ static int bcmgenet_probe(struct platform_device *pdev)
 
 	/* Request the WOL interrupt and advertise suspend if available */
 	priv->wol_irq_disabled = true;
-	err = devm_request_irq(&pdev->dev, priv->wol_irq, bcmgenet_wol_isr, 0,
-			       dev->name, priv);
-	if (!err)
-		device_set_wakeup_capable(&pdev->dev, 1);
+	if (priv->wol_irq > 0) {
+		err = devm_request_irq(&pdev->dev, priv->wol_irq,
+				       bcmgenet_wol_isr, 0, dev->name, priv);
+		if (!err)
+			device_set_wakeup_capable(&pdev->dev, 1);
+	}
 
 	/* Set the needed headroom to account for any possible
 	 * features enabling/disabling at runtime
diff --git a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_cm.c b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_cm.c
index d04a6c163445..da8d10475a08 100644
--- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_cm.c
+++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_cm.c
@@ -32,6 +32,7 @@
 
 #include <linux/tcp.h>
 #include <linux/ipv6.h>
+#include <net/inet_ecn.h>
 #include <net/route.h>
 #include <net/ip6_route.h>
 
@@ -99,7 +100,7 @@ cxgb_find_route(struct cxgb4_lld_info *lldi,
 
 	rt = ip_route_output_ports(&init_net, &fl4, NULL, peer_ip, local_ip,
 				   peer_port, local_port, IPPROTO_TCP,
-				   tos, 0);
+				   tos & ~INET_ECN_MASK, 0);
 	if (IS_ERR(rt))
 		return NULL;
 	n = dst_neigh_lookup(&rt->dst, &peer_ip);
diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 81021f87e4f3..93b7ed361b82 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -96,14 +96,17 @@ static void mac_exception(void *handle, enum fman_mac_exceptions ex)
 		__func__, ex);
 }
 
-static void set_fman_mac_params(struct mac_device *mac_dev,
-				struct fman_mac_params *params)
+static int set_fman_mac_params(struct mac_device *mac_dev,
+			       struct fman_mac_params *params)
 {
 	struct mac_priv_s *priv = mac_dev->priv;
 
 	params->base_addr = (typeof(params->base_addr))
 		devm_ioremap(priv->dev, mac_dev->res->start,
 			     resource_size(mac_dev->res));
+	if (!params->base_addr)
+		return -ENOMEM;
+
 	memcpy(&params->addr, mac_dev->addr, sizeof(mac_dev->addr));
 	params->max_speed	= priv->max_speed;
 	params->phy_if		= priv->phy_if;
@@ -114,6 +117,8 @@ static void set_fman_mac_params(struct mac_device *mac_dev,
 	params->event_cb	= mac_exception;
 	params->dev_id		= mac_dev;
 	params->internal_phy_node = priv->internal_phy_node;
+
+	return 0;
 }
 
 static int tgec_initialization(struct mac_device *mac_dev)
@@ -125,7 +130,9 @@ static int tgec_initialization(struct mac_device *mac_dev)
 
 	priv = mac_dev->priv;
 
-	set_fman_mac_params(mac_dev, &params);
+	err = set_fman_mac_params(mac_dev, &params);
+	if (err)
+		goto _return;
 
 	mac_dev->fman_mac = tgec_config(&params);
 	if (!mac_dev->fman_mac) {
@@ -171,7 +178,9 @@ static int dtsec_initialization(struct mac_device *mac_dev)
 
 	priv = mac_dev->priv;
 
-	set_fman_mac_params(mac_dev, &params);
+	err = set_fman_mac_params(mac_dev, &params);
+	if (err)
+		goto _return;
 
 	mac_dev->fman_mac = dtsec_config(&params);
 	if (!mac_dev->fman_mac) {
@@ -220,7 +229,9 @@ static int memac_initialization(struct mac_device *mac_dev)
 
 	priv = mac_dev->priv;
 
-	set_fman_mac_params(mac_dev, &params);
+	err = set_fman_mac_params(mac_dev, &params);
+	if (err)
+		goto _return;
 
 	if (priv->max_speed == SPEED_10000)
 		params.phy_if = PHY_INTERFACE_MODE_XGMII;
diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 9fd68cfdd973..fc721a59a408 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -2939,29 +2939,21 @@ static bool gfar_add_rx_frag(struct gfar_rx_buff *rxb, u32 lstatus,
 {
 	int size = lstatus & BD_LENGTH_MASK;
 	struct page *page = rxb->page;
-	bool last = !!(lstatus & BD_LFLAG(RXBD_LAST));
-
-	/* Remove the FCS from the packet length */
-	if (last)
-		size -= ETH_FCS_LEN;
 
 	if (likely(first)) {
 		skb_put(skb, size);
 	} else {
 		/* the last fragments' length contains the full frame length */
-		if (last)
+		if (lstatus & BD_LFLAG(RXBD_LAST))
 			size -= skb->len;
 
-		/* Add the last fragment if it contains something other than
-		 * the FCS, otherwise drop it and trim off any part of the FCS
-		 * that was already received.
-		 */
-		if (size > 0)
-			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
-					rxb->page_offset + RXBUF_ALIGNMENT,
-					size, GFAR_RXB_TRUESIZE);
-		else if (size < 0)
-			pskb_trim(skb, skb->len + size);
+		WARN(size < 0, "gianfar: rx fragment size underflow");
+		if (size < 0)
+			return false;
+
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
+				rxb->page_offset + RXBUF_ALIGNMENT,
+				size, GFAR_RXB_TRUESIZE);
 	}
 
 	/* try reuse page */
@@ -3074,6 +3066,9 @@ static void gfar_process_frame(struct net_device *ndev, struct sk_buff *skb)
 	if (priv->padding)
 		skb_pull(skb, priv->padding);
 
+	/* Trim off the FCS */
+	pskb_trim(skb, skb->len - ETH_FCS_LEN);
+
 	if (ndev->features & NETIF_F_RXCSUM)
 		gfar_rx_checksum(skb, fcb);
 
@@ -3117,6 +3112,17 @@ int gfar_clean_rx_ring(struct gfar_priv_rx_q *rx_queue, int rx_work_limit)
 		if (lstatus & BD_LFLAG(RXBD_EMPTY))
 			break;
 
+		/* lost RXBD_LAST descriptor due to overrun */
+		if (skb &&
+		    (lstatus & BD_LFLAG(RXBD_FIRST))) {
+			/* discard faulty buffer */
+			dev_kfree_skb(skb);
+			skb = NULL;
+			rx_queue->stats.rx_dropped++;
+
+			/* can continue normally */
+		}
+
 		/* order rx buffer descriptor reads */
 		rmb();
 
diff --git a/drivers/net/ethernet/freescale/xgmac_mdio.c b/drivers/net/ethernet/freescale/xgmac_mdio.c
index c82c85ef5fb3..c37aea7ba850 100644
--- a/drivers/net/ethernet/freescale/xgmac_mdio.c
+++ b/drivers/net/ethernet/freescale/xgmac_mdio.c
@@ -301,9 +301,10 @@ static int xgmac_mdio_probe(struct platform_device *pdev)
 static int xgmac_mdio_remove(struct platform_device *pdev)
 {
 	struct mii_bus *bus = platform_get_drvdata(pdev);
+	struct mdio_fsl_priv *priv = bus->priv;
 
 	mdiobus_unregister(bus);
-	iounmap(bus->priv);
+	iounmap(priv->mdio_base);
 	mdiobus_free(bus);
 
 	return 0;
diff --git a/drivers/net/ethernet/i825xx/sni_82596.c b/drivers/net/ethernet/i825xx/sni_82596.c
index 2af7f77345fb..e4128e151b85 100644
--- a/drivers/net/ethernet/i825xx/sni_82596.c
+++ b/drivers/net/ethernet/i825xx/sni_82596.c
@@ -122,9 +122,10 @@ static int sni_82596_probe(struct platform_device *dev)
 	netdevice->dev_addr[5] = readb(eth_addr + 0x06);
 	iounmap(eth_addr);
 
-	if (!netdevice->irq) {
+	if (netdevice->irq < 0) {
 		printk(KERN_ERR "%s: IRQ not found for i82596 at 0x%lx\n",
 			__FILE__, netdevice->base_addr);
+		retval = netdevice->irq;
 		goto probe_failed;
 	}
 
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 46fcf3ec2caf..467dc0c60759 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -670,7 +670,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	num_frag = skb_shinfo(skb)->nr_frags;
 	cur_p = &lp->tx_bd_v[lp->tx_bd_tail];
 
-	if (axienet_check_tx_bd_space(lp, num_frag)) {
+	if (axienet_check_tx_bd_space(lp, num_frag + 1)) {
 		if (netif_queue_stopped(ndev))
 			return NETDEV_TX_BUSY;
 
@@ -680,7 +680,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		smp_mb();
 
 		/* Space might have just been freed - check again */
-		if (axienet_check_tx_bd_space(lp, num_frag))
+		if (axienet_check_tx_bd_space(lp, num_frag + 1))
 			return NETDEV_TX_BUSY;
 
 		netif_wake_queue(ndev);
diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index ce3b7fb7eda0..80c8e9abb402 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -108,6 +108,7 @@ struct at86rf230_local {
 	unsigned long cal_timeout;
 	bool is_tx;
 	bool is_tx_from_off;
+	bool was_tx;
 	u8 tx_retry;
 	struct sk_buff *tx_skb;
 	struct at86rf230_state_change tx;
@@ -351,7 +352,11 @@ at86rf230_async_error_recover_complete(void *context)
 	if (ctx->free)
 		kfree(ctx);
 
-	ieee802154_wake_queue(lp->hw);
+	if (lp->was_tx) {
+		lp->was_tx = 0;
+		dev_kfree_skb_any(lp->tx_skb);
+		ieee802154_wake_queue(lp->hw);
+	}
 }
 
 static void
@@ -360,7 +365,11 @@ at86rf230_async_error_recover(void *context)
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
 
-	lp->is_tx = 0;
+	if (lp->is_tx) {
+		lp->was_tx = 1;
+		lp->is_tx = 0;
+	}
+
 	at86rf230_async_state_change(lp, ctx, STATE_RX_AACK_ON,
 				     at86rf230_async_error_recover_complete);
 }
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 774b9db0c811..0d3baa86cf17 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3230,6 +3230,15 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
 
 	macsec->real_dev = real_dev;
 
+	/* send_sci must be set to true when transmit sci explicitly is set */
+	if ((data && data[IFLA_MACSEC_SCI]) &&
+	    (data && data[IFLA_MACSEC_INC_SCI])) {
+		u8 send_sci = !!nla_get_u8(data[IFLA_MACSEC_INC_SCI]);
+
+		if (!send_sci)
+			return -EINVAL;
+	}
+
 	if (data && data[IFLA_MACSEC_ICV_LEN])
 		icv_len = nla_get_u8(data[IFLA_MACSEC_ICV_LEN]);
 	mtu = real_dev->mtu - icv_len - macsec_extra_len(true);
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 92fb664b56fb..0fa6e2da4b5a 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -347,7 +347,7 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 	}
 
 	bus->state = MDIOBUS_REGISTERED;
-	pr_info("%s: probed\n", bus->name);
+	dev_dbg(&bus->dev, "probed\n");
 	return 0;
 
 error:
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 0a29844676f9..6287d2ad77c6 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -71,6 +71,8 @@
 #define MPHDRLEN	6	/* multilink protocol header length */
 #define MPHDRLEN_SSN	4	/* ditto with short sequence numbers */
 
+#define PPP_PROTO_LEN	2
+
 /*
  * An instance of /dev/ppp can be associated with either a ppp
  * interface unit or a ppp channel.  In both cases, file->private_data
@@ -500,6 +502,9 @@ static ssize_t ppp_write(struct file *file, const char __user *buf,
 
 	if (!pf)
 		return -ENXIO;
+	/* All PPP packets should start with the 2-byte protocol */
+	if (count < PPP_PROTO_LEN)
+		return -EINVAL;
 	ret = -ENOMEM;
 	skb = alloc_skb(count + pf->hdrlen, GFP_KERNEL);
 	if (!skb)
@@ -1563,7 +1568,7 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 	}
 
 	++ppp->stats64.tx_packets;
-	ppp->stats64.tx_bytes += skb->len - 2;
+	ppp->stats64.tx_bytes += skb->len - PPP_PROTO_LEN;
 
 	switch (proto) {
 	case PPP_IP:
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 412a36f27de6..738d10fc595c 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1369,59 +1369,69 @@ static int ax88179_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 	u16 hdr_off;
 	u32 *pkt_hdr;
 
-	/* This check is no longer done by usbnet */
-	if (skb->len < dev->net->hard_header_len)
+	/* At the end of the SKB, there's a header telling us how many packets
+	 * are bundled into this buffer and where we can find an array of
+	 * per-packet metadata (which contains elements encoded into u16).
+	 */
+	if (skb->len < 4)
 		return 0;
-
 	skb_trim(skb, skb->len - 4);
 	memcpy(&rx_hdr, skb_tail_pointer(skb), 4);
 	le32_to_cpus(&rx_hdr);
-
 	pkt_cnt = (u16)rx_hdr;
 	hdr_off = (u16)(rx_hdr >> 16);
+
+	if (pkt_cnt == 0)
+		return 0;
+
+	/* Make sure that the bounds of the metadata array are inside the SKB
+	 * (and in front of the counter at the end).
+	 */
+	if (pkt_cnt * 2 + hdr_off > skb->len)
+		return 0;
 	pkt_hdr = (u32 *)(skb->data + hdr_off);
 
-	while (pkt_cnt--) {
+	/* Packets must not overlap the metadata array */
+	skb_trim(skb, hdr_off);
+
+	for (; ; pkt_cnt--, pkt_hdr++) {
 		u16 pkt_len;
 
 		le32_to_cpus(pkt_hdr);
 		pkt_len = (*pkt_hdr >> 16) & 0x1fff;
 
-		/* Check CRC or runt packet */
-		if ((*pkt_hdr & AX_RXHDR_CRC_ERR) ||
-		    (*pkt_hdr & AX_RXHDR_DROP_ERR)) {
-			skb_pull(skb, (pkt_len + 7) & 0xFFF8);
-			pkt_hdr++;
-			continue;
-		}
-
-		if (pkt_cnt == 0) {
-			skb->len = pkt_len;
-			/* Skip IP alignment pseudo header */
-			skb_pull(skb, 2);
-			skb_set_tail_pointer(skb, skb->len);
-			skb->truesize = pkt_len + sizeof(struct sk_buff);
-			ax88179_rx_checksum(skb, pkt_hdr);
-			return 1;
-		}
+		if (pkt_len > skb->len)
+			return 0;
 
-		ax_skb = skb_clone(skb, GFP_ATOMIC);
-		if (ax_skb) {
+		/* Check CRC or runt packet */
+		if (((*pkt_hdr & (AX_RXHDR_CRC_ERR | AX_RXHDR_DROP_ERR)) == 0) &&
+		    pkt_len >= 2 + ETH_HLEN) {
+			bool last = (pkt_cnt == 0);
+
+			if (last) {
+				ax_skb = skb;
+			} else {
+				ax_skb = skb_clone(skb, GFP_ATOMIC);
+				if (!ax_skb)
+					return 0;
+			}
 			ax_skb->len = pkt_len;
 			/* Skip IP alignment pseudo header */
 			skb_pull(ax_skb, 2);
 			skb_set_tail_pointer(ax_skb, ax_skb->len);
 			ax_skb->truesize = pkt_len + sizeof(struct sk_buff);
 			ax88179_rx_checksum(ax_skb, pkt_hdr);
+
+			if (last)
+				return 1;
+
 			usbnet_skb_return(dev, ax_skb);
-		} else {
-			return 0;
 		}
 
-		skb_pull(skb, (pkt_len + 7) & 0xFFF8);
-		pkt_hdr++;
+		/* Trim this packet away from the SKB */
+		if (!skb_pull(skb, (pkt_len + 7) & 0xFFF8))
+			return 0;
 	}
-	return 1;
 }
 
 static struct sk_buff *
diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 0cf5324d493e..52ed3da64f01 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -173,7 +173,7 @@ static int ipheth_alloc_urbs(struct ipheth_device *iphone)
 	if (tx_buf == NULL)
 		goto free_rx_urb;
 
-	rx_buf = usb_alloc_coherent(iphone->udev, IPHETH_BUF_SIZE,
+	rx_buf = usb_alloc_coherent(iphone->udev, IPHETH_BUF_SIZE + IPHETH_IP_ALIGN,
 				    GFP_KERNEL, &rx_urb->transfer_dma);
 	if (rx_buf == NULL)
 		goto free_tx_buf;
@@ -198,7 +198,7 @@ static int ipheth_alloc_urbs(struct ipheth_device *iphone)
 
 static void ipheth_free_urbs(struct ipheth_device *iphone)
 {
-	usb_free_coherent(iphone->udev, IPHETH_BUF_SIZE, iphone->rx_buf,
+	usb_free_coherent(iphone->udev, IPHETH_BUF_SIZE + IPHETH_IP_ALIGN, iphone->rx_buf,
 			  iphone->rx_urb->transfer_dma);
 	usb_free_coherent(iphone->udev, IPHETH_BUF_SIZE, iphone->tx_buf,
 			  iphone->tx_urb->transfer_dma);
@@ -371,7 +371,7 @@ static int ipheth_rx_submit(struct ipheth_device *dev, gfp_t mem_flags)
 
 	usb_fill_bulk_urb(dev->rx_urb, udev,
 			  usb_rcvbulkpipe(udev, dev->bulk_in),
-			  dev->rx_buf, IPHETH_BUF_SIZE,
+			  dev->rx_buf, IPHETH_BUF_SIZE + IPHETH_IP_ALIGN,
 			  ipheth_rcvbulk_callback,
 			  dev);
 	dev->rx_urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
diff --git a/drivers/net/usb/mcs7830.c b/drivers/net/usb/mcs7830.c
index 4f345bd4e6e2..95151b46f200 100644
--- a/drivers/net/usb/mcs7830.c
+++ b/drivers/net/usb/mcs7830.c
@@ -121,8 +121,16 @@ static const char driver_name[] = "MOSCHIP usb-ethernet driver";
 
 static int mcs7830_get_reg(struct usbnet *dev, u16 index, u16 size, void *data)
 {
-	return usbnet_read_cmd(dev, MCS7830_RD_BREQ, MCS7830_RD_BMREQ,
-				0x0000, index, data, size);
+	int ret;
+
+	ret = usbnet_read_cmd(dev, MCS7830_RD_BREQ, MCS7830_RD_BMREQ,
+			      0x0000, index, data, size);
+	if (ret < 0)
+		return ret;
+	else if (ret < size)
+		return -ENODATA;
+
+	return ret;
 }
 
 static int mcs7830_set_reg(struct usbnet *dev, u16 index, u16 size, const void *data)
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index a8c960152a35..003c53a5bb33 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -964,6 +964,8 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x413c, 0x81d7, 0)},	/* Dell Wireless 5821e */
 	{QMI_FIXED_INTF(0x413c, 0x81d7, 1)},	/* Dell Wireless 5821e preproduction config */
 	{QMI_FIXED_INTF(0x413c, 0x81e0, 0)},	/* Dell Wireless 5821e with eSIM support*/
+	{QMI_FIXED_INTF(0x413c, 0x81e4, 0)},	/* Dell Wireless 5829e with eSIM support*/
+	{QMI_FIXED_INTF(0x413c, 0x81e6, 0)},	/* Dell Wireless 5829e */
 	{QMI_FIXED_INTF(0x03f0, 0x4e1d, 8)},	/* HP lt4111 LTE/EV-DO/HSPA+ Gobi 4G Module */
 	{QMI_FIXED_INTF(0x03f0, 0x9d1d, 1)},	/* HP lt4120 Snapdragon X5 LTE */
 	{QMI_FIXED_INTF(0x22de, 0x9061, 3)},	/* WeTelecom WPD-600N */
diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 9f4ee1d125b6..0c6b33c464cd 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -153,6 +153,10 @@ static void ar5523_cmd_rx_cb(struct urb *urb)
 			ar5523_err(ar, "Invalid reply to WDCMSG_TARGET_START");
 			return;
 		}
+		if (!cmd->odata) {
+			ar5523_err(ar, "Unexpected WDCMSG_TARGET_START reply");
+			return;
+		}
 		memcpy(cmd->odata, hdr + 1, sizeof(u32));
 		cmd->olen = sizeof(u32);
 		cmd->res = 0;
diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index ae5b33fe5ba8..374ce35940d0 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -158,6 +158,9 @@ void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt)
 	htt->num_pending_tx--;
 	if (htt->num_pending_tx == htt->max_num_pending_tx - 1)
 		ath10k_mac_tx_unlock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
+
+	if (htt->num_pending_tx == 0)
+		wake_up(&htt->empty_tx_wq);
 }
 
 int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index beeb6be06939..b6c050452b75 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -89,8 +89,6 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 
 	ath10k_htt_tx_free_msdu_id(htt, tx_done->msdu_id);
 	ath10k_htt_tx_dec_pending(htt);
-	if (htt->num_pending_tx == 0)
-		wake_up(&htt->empty_tx_wq);
 	spin_unlock_bh(&htt->tx_lock);
 
 	dma_unmap_single(dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 7c409cd43b70..33a6be0f21ca 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -588,6 +588,13 @@ static void ath9k_hif_usb_rx_stream(struct hif_device_usb *hif_dev,
 			return;
 		}
 
+		if (pkt_len > 2 * MAX_RX_BUF_SIZE) {
+			dev_err(&hif_dev->udev->dev,
+				"ath9k_htc: invalid pkt_len (%x)\n", pkt_len);
+			RX_STAT_INC(skb_dropped);
+			return;
+		}
+
 		pad_len = 4 - (pkt_len & 0x3);
 		if (pad_len == 4)
 			pad_len = 0;
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 914c210c9e60..da2f442cab27 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2052,7 +2052,7 @@ static int wcn36xx_smd_missed_beacon_ind(struct wcn36xx *wcn,
 			wcn36xx_dbg(WCN36XX_DBG_HAL, "beacon missed bss_index %d\n",
 				    tmp->bss_index);
 			vif = wcn36xx_priv_to_vif(tmp);
-			ieee80211_connection_loss(vif);
+			ieee80211_beacon_loss(vif);
 		}
 		return 0;
 	}
@@ -2067,7 +2067,7 @@ static int wcn36xx_smd_missed_beacon_ind(struct wcn36xx *wcn,
 			wcn36xx_dbg(WCN36XX_DBG_HAL, "beacon missed bss_index %d\n",
 				    rsp->bss_index);
 			vif = wcn36xx_priv_to_vif(tmp);
-			ieee80211_connection_loss(vif);
+			ieee80211_beacon_loss(vif);
 			return 0;
 		}
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d46efa8d7073..f8c225a726bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1599,6 +1599,7 @@ static void iwl_mvm_recalc_multicast(struct iwl_mvm *mvm)
 	struct iwl_mvm_mc_iter_data iter_data = {
 		.mvm = mvm,
 	};
+	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -1608,6 +1609,22 @@ static void iwl_mvm_recalc_multicast(struct iwl_mvm *mvm)
 	ieee80211_iterate_active_interfaces_atomic(
 		mvm->hw, IEEE80211_IFACE_ITER_NORMAL,
 		iwl_mvm_mc_iface_iterator, &iter_data);
+
+	/*
+	 * Send a (synchronous) ech command so that we wait for the
+	 * multiple asynchronous MCAST_FILTER_CMD commands sent by
+	 * the interface iterator. Otherwise, we might get here over
+	 * and over again (by userspace just sending a lot of these)
+	 * and the CPU can send them faster than the firmware can
+	 * process them.
+	 * Note that the CPU is still faster - but with this we'll
+	 * actually send fewer commands overall because the CPU will
+	 * not schedule the work in mac80211 as frequently if it's
+	 * still running when rescheduled (possibly multiple times).
+	 */
+	ret = iwl_mvm_send_cmd_pdu(mvm, ECHO_CMD, 0, 0, NULL);
+	if (ret)
+		IWL_ERR(mvm, "Failed to synchronize multicast groups update\n");
 }
 
 static u64 iwl_mvm_prepare_multicast(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index fa9743205491..a8470817689c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1260,7 +1260,7 @@ static int iwl_mvm_check_running_scans(struct iwl_mvm *mvm, int type)
 	return -EIO;
 }
 
-#define SCAN_TIMEOUT 20000
+#define SCAN_TIMEOUT 30000
 
 void iwl_mvm_scan_timeout_wk(struct work_struct *work)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 71edbf7a42ed..1acffca3d75d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1183,8 +1183,7 @@ static int iwl_trans_pcie_start_fw(struct iwl_trans *trans,
 	/* This may fail if AMT took ownership of the device */
 	if (iwl_pcie_prepare_card_hw(trans)) {
 		IWL_WARN(trans, "Exit HW not ready\n");
-		ret = -EIO;
-		goto out;
+		return -EIO;
 	}
 
 	iwl_enable_rfkill_int(trans);
diff --git a/drivers/net/wireless/marvell/mwifiex/usb.c b/drivers/net/wireless/marvell/mwifiex/usb.c
index 2c4225e57c39..3a26add665ca 100644
--- a/drivers/net/wireless/marvell/mwifiex/usb.c
+++ b/drivers/net/wireless/marvell/mwifiex/usb.c
@@ -132,7 +132,8 @@ static int mwifiex_usb_recv(struct mwifiex_adapter *adapter,
 		default:
 			mwifiex_dbg(adapter, ERROR,
 				    "unknown recv_type %#x\n", recv_type);
-			return -1;
+			ret = -1;
+			goto exit_restore_skb;
 		}
 		break;
 	case MWIFIEX_USB_EP_DATA:
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
index 39a6bd314ca3..264c1d57e10b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
@@ -1037,6 +1037,7 @@ int rtl92cu_hw_init(struct ieee80211_hw *hw)
 	_InitPABias(hw);
 	rtl92c_dm_init(hw);
 exit:
+	local_irq_disable();
 	local_irq_restore(flags);
 	return err;
 }
diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index 7a5306bf56c8..f6ef5952e94b 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -1008,7 +1008,7 @@ ccio_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents,
 	ioc->usg_calls++;
 #endif
 
-	while(sg_dma_len(sglist) && nents--) {
+	while (nents && sg_dma_len(sglist)) {
 
 #ifdef CCIO_COLLECT_STATS
 		ioc->usg_pages += sg_dma_len(sglist) >> PAGE_SHIFT;
@@ -1016,6 +1016,7 @@ ccio_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents,
 		ccio_unmap_page(dev, sg_dma_address(sglist),
 				  sg_dma_len(sglist), direction, 0);
 		++sglist;
+		nents--;
 	}
 
 	DBG_RUN_SG("%s() DONE (nents %d)\n", __func__, nents);
diff --git a/drivers/parisc/pdc_stable.c b/drivers/parisc/pdc_stable.c
index 3651c3871d5b..1b4aacf2ff9a 100644
--- a/drivers/parisc/pdc_stable.c
+++ b/drivers/parisc/pdc_stable.c
@@ -992,8 +992,10 @@ pdcs_register_pathentries(void)
 		entry->kobj.kset = paths_kset;
 		err = kobject_init_and_add(&entry->kobj, &ktype_pdcspath, NULL,
 					   "%s", entry->name);
-		if (err)
+		if (err) {
+			kobject_put(&entry->kobj);
 			return err;
+		}
 
 		/* kobject is now registered */
 		write_lock(&entry->rw_lock);
diff --git a/drivers/parisc/sba_iommu.c b/drivers/parisc/sba_iommu.c
index a7f542e784dd..c715af1b6c3c 100644
--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -1061,7 +1061,7 @@ sba_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents,
 	spin_unlock_irqrestore(&ioc->res_lock, flags);
 #endif
 
-	while (sg_dma_len(sglist) && nents--) {
+	while (nents && sg_dma_len(sglist)) {
 
 		sba_unmap_page(dev, sg_dma_address(sglist), sg_dma_len(sglist),
 				direction, 0);
@@ -1070,6 +1070,7 @@ sba_unmap_sg(struct device *dev, struct scatterlist *sglist, int nents,
 		ioc->usingle_calls--;	/* kluge since call is unmap_sg() */
 #endif
 		++sglist;
+		nents--;
 	}
 
 	DBG_RUN_SG("%s() DONE (nents %d)\n", __func__,  nents);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3ff2971102b6..8d34c6d0de79 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3916,6 +3916,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9120,
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9123,
 			 quirk_dma_func1_alias);
+/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c136 */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9125,
+			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9128,
 			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c14 */
diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index c3b615c94b4b..a92cbc952b70 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -665,18 +665,16 @@ static int pccardd(void *__skt)
 		if (events || sysfs_events)
 			continue;
 
+		set_current_state(TASK_INTERRUPTIBLE);
 		if (kthread_should_stop())
 			break;
 
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		schedule();
 
-		/* make sure we are running */
-		__set_current_state(TASK_RUNNING);
-
 		try_to_freeze();
 	}
+	/* make sure we are running before we exit */
+	__set_current_state(TASK_RUNNING);
 
 	/* shut down socket, if a device is still present */
 	if (skt->state & SOCKET_PRESENT) {
diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 5ef7b46a2578..2e96d9273b78 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -693,6 +693,9 @@ static struct resource *__nonstatic_find_io_region(struct pcmcia_socket *s,
 	unsigned long min = base;
 	int ret;
 
+	if (!res)
+		return NULL;
+
 	data.mask = align - 1;
 	data.offset = base & data.mask;
 	data.map = &s_data->io_db;
@@ -812,6 +815,9 @@ static struct resource *nonstatic_find_mem_region(u_long base, u_long num,
 	unsigned long min, max;
 	int ret, i, j;
 
+	if (!res)
+		return NULL;
+
 	low = low || !(s->features & SS_CAP_PAGE_REGS);
 
 	data.mask = align - 1;
diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index f993a55cde20..faf2a6243567 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -521,12 +521,12 @@ static void bq25890_handle_state_change(struct bq25890_device *bq,
 
 	if (!new_state->online) {			     /* power removed */
 		/* disable ADC */
-		ret = bq25890_field_write(bq, F_CONV_START, 0);
+		ret = bq25890_field_write(bq, F_CONV_RATE, 0);
 		if (ret < 0)
 			goto error;
 	} else if (!old_state.online) {			    /* power inserted */
 		/* enable ADC, to have control of charge current/voltage */
-		ret = bq25890_field_write(bq, F_CONV_START, 1);
+		ret = bq25890_field_write(bq, F_CONV_RATE, 1);
 		if (ret < 0)
 			goto error;
 	}
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index b962dbe51750..1dbd8419df7d 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -342,7 +342,10 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
 	min = t->time.tm_min;
 	sec = t->time.tm_sec;
 
+	spin_lock_irq(&rtc_lock);
 	rtc_control = CMOS_READ(RTC_CONTROL);
+	spin_unlock_irq(&rtc_lock);
+
 	if (!(rtc_control & RTC_DM_BINARY) || RTC_ALWAYS_BCD) {
 		/* Writing 0xff means "don't care" or "match all".  */
 		mon = (mon <= 12) ? bin2bcd(mon) : 0xff;
diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index 18a6f15e313d..86b8858917b6 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -82,7 +82,7 @@ unsigned int mc146818_get_time(struct rtc_time *time)
 	time->tm_year += real_year - 72;
 #endif
 
-	if (century > 20)
+	if (century > 19)
 		time->tm_year += (century - 19) * 100;
 
 	/*
diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index f7630cf581cd..fd622021748f 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -518,6 +518,8 @@ static void zfcp_fc_adisc_handler(void *data)
 		goto out;
 	}
 
+	/* re-init to undo drop from zfcp_fc_adisc() */
+	port->d_id = ntoh24(adisc_resp->adisc_port_id);
 	/* port is good, unblock rport without going through erp */
 	zfcp_scsi_schedule_rport_register(port);
  out:
@@ -531,6 +533,7 @@ static int zfcp_fc_adisc(struct zfcp_port *port)
 	struct zfcp_fc_req *fc_req;
 	struct zfcp_adapter *adapter = port->adapter;
 	struct Scsi_Host *shost = adapter->scsi_host;
+	u32 d_id;
 	int ret;
 
 	fc_req = kmem_cache_zalloc(zfcp_fc_req_cache, GFP_ATOMIC);
@@ -555,7 +558,15 @@ static int zfcp_fc_adisc(struct zfcp_port *port)
 	fc_req->u.adisc.req.adisc_cmd = ELS_ADISC;
 	hton24(fc_req->u.adisc.req.adisc_port_id, fc_host_port_id(shost));
 
-	ret = zfcp_fsf_send_els(adapter, port->d_id, &fc_req->ct_els,
+	d_id = port->d_id; /* remember as destination for send els below */
+	/*
+	 * Force fresh GID_PN lookup on next port recovery.
+	 * Must happen after request setup and before sending request,
+	 * to prevent race with port->d_id re-init in zfcp_fc_adisc_handler().
+	 */
+	port->d_id = 0;
+
+	ret = zfcp_fsf_send_els(adapter, d_id, &fc_req->ct_els,
 				ZFCP_FC_CTELS_TMO);
 	if (ret)
 		kmem_cache_free(zfcp_fc_req_cache, fc_req);
diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 68cc332bd6cb..b3dae8a4e5fc 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -79,7 +79,7 @@ static int bnx2fc_bind_pcidev(struct bnx2fc_hba *hba);
 static void bnx2fc_unbind_pcidev(struct bnx2fc_hba *hba);
 static struct fc_lport *bnx2fc_if_create(struct bnx2fc_interface *interface,
 				  struct device *parent, int npiv);
-static void bnx2fc_destroy_work(struct work_struct *work);
+static void bnx2fc_port_destroy(struct fcoe_port *port);
 
 static struct bnx2fc_hba *bnx2fc_hba_lookup(struct net_device *phys_dev);
 static struct bnx2fc_interface *bnx2fc_interface_lookup(struct net_device
@@ -521,7 +521,8 @@ static int bnx2fc_l2_rcv_thread(void *arg)
 
 static void bnx2fc_recv_frame(struct sk_buff *skb)
 {
-	u32 fr_len;
+	u64 crc_err;
+	u32 fr_len, fr_crc;
 	struct fc_lport *lport;
 	struct fcoe_rcv_info *fr;
 	struct fc_stats *stats;
@@ -553,6 +554,11 @@ static void bnx2fc_recv_frame(struct sk_buff *skb)
 	skb_pull(skb, sizeof(struct fcoe_hdr));
 	fr_len = skb->len - sizeof(struct fcoe_crc_eof);
 
+	stats = per_cpu_ptr(lport->stats, get_cpu());
+	stats->RxFrames++;
+	stats->RxWords += fr_len / FCOE_WORD_TO_BYTE;
+	put_cpu();
+
 	fp = (struct fc_frame *)skb;
 	fc_frame_init(fp);
 	fr_dev(fp) = lport;
@@ -604,16 +610,15 @@ static void bnx2fc_recv_frame(struct sk_buff *skb)
 		return;
 	}
 
-	stats = per_cpu_ptr(lport->stats, smp_processor_id());
-	stats->RxFrames++;
-	stats->RxWords += fr_len / FCOE_WORD_TO_BYTE;
+	fr_crc = le32_to_cpu(fr_crc(fp));
 
-	if (le32_to_cpu(fr_crc(fp)) !=
-			~crc32(~0, skb->data, fr_len)) {
-		if (stats->InvalidCRCCount < 5)
+	if (unlikely(fr_crc != ~crc32(~0, skb->data, fr_len))) {
+		stats = per_cpu_ptr(lport->stats, get_cpu());
+		crc_err = (stats->InvalidCRCCount++);
+		put_cpu();
+		if (crc_err < 5)
 			printk(KERN_WARNING PFX "dropping frame with "
 			       "CRC error\n");
-		stats->InvalidCRCCount++;
 		kfree_skb(skb);
 		return;
 	}
@@ -884,9 +889,6 @@ static void bnx2fc_indicate_netevent(void *context, unsigned long event,
 				__bnx2fc_destroy(interface);
 		}
 		mutex_unlock(&bnx2fc_dev_lock);
-
-		/* Ensure ALL destroy work has been completed before return */
-		flush_workqueue(bnx2fc_wq);
 		return;
 
 	default:
@@ -1194,8 +1196,8 @@ static int bnx2fc_vport_destroy(struct fc_vport *vport)
 	mutex_unlock(&n_port->lp_mutex);
 	bnx2fc_free_vport(interface->hba, port->lport);
 	bnx2fc_port_shutdown(port->lport);
+	bnx2fc_port_destroy(port);
 	bnx2fc_interface_put(interface);
-	queue_work(bnx2fc_wq, &port->destroy_work);
 	return 0;
 }
 
@@ -1504,7 +1506,6 @@ static struct fc_lport *bnx2fc_if_create(struct bnx2fc_interface *interface,
 	port->lport = lport;
 	port->priv = interface;
 	port->get_netdev = bnx2fc_netdev;
-	INIT_WORK(&port->destroy_work, bnx2fc_destroy_work);
 
 	/* Configure fcoe_port */
 	rc = bnx2fc_lport_config(lport);
@@ -1632,8 +1633,8 @@ static void __bnx2fc_destroy(struct bnx2fc_interface *interface)
 	bnx2fc_interface_cleanup(interface);
 	bnx2fc_stop(interface);
 	list_del(&interface->list);
+	bnx2fc_port_destroy(port);
 	bnx2fc_interface_put(interface);
-	queue_work(bnx2fc_wq, &port->destroy_work);
 }
 
 /**
@@ -1674,15 +1675,12 @@ static int bnx2fc_destroy(struct net_device *netdev)
 	return rc;
 }
 
-static void bnx2fc_destroy_work(struct work_struct *work)
+static void bnx2fc_port_destroy(struct fcoe_port *port)
 {
-	struct fcoe_port *port;
 	struct fc_lport *lport;
 
-	port = container_of(work, struct fcoe_port, destroy_work);
 	lport = port->lport;
-
-	BNX2FC_HBA_DBG(lport, "Entered bnx2fc_destroy_work\n");
+	BNX2FC_HBA_DBG(lport, "Entered %s, destroying lport %p\n", __func__, lport);
 
 	bnx2fc_if_destroy(lport);
 }
@@ -2522,9 +2520,6 @@ static void bnx2fc_ulp_exit(struct cnic_dev *dev)
 			__bnx2fc_destroy(interface);
 	mutex_unlock(&bnx2fc_dev_lock);
 
-	/* Ensure ALL destroy work has been completed before return */
-	flush_workqueue(bnx2fc_wq);
-
 	bnx2fc_ulp_stop(hba);
 	/* unregister cnic device */
 	if (test_and_clear_bit(BNX2FC_CNIC_REGISTERED, &hba->reg_with_cnic))
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 9b63e46edffc..a2a4c6e22c68 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -882,7 +882,7 @@ static void get_capabilities(struct scsi_cd *cd)
 
 
 	/* allocate transfer buffer */
-	buffer = kmalloc(512, GFP_KERNEL | GFP_DMA);
+	buffer = kmalloc(512, GFP_KERNEL);
 	if (!buffer) {
 		sr_printk(KERN_ERR, cd, "out of memory.\n");
 		return;
diff --git a/drivers/scsi/sr_vendor.c b/drivers/scsi/sr_vendor.c
index 11a238cb2222..629bfe1b2026 100644
--- a/drivers/scsi/sr_vendor.c
+++ b/drivers/scsi/sr_vendor.c
@@ -118,7 +118,7 @@ int sr_set_blocklength(Scsi_CD *cd, int blocklength)
 		density = (blocklength > 2048) ? 0x81 : 0x83;
 #endif
 
-	buffer = kmalloc(512, GFP_KERNEL | GFP_DMA);
+	buffer = kmalloc(512, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
@@ -166,7 +166,7 @@ int sr_cd_check(struct cdrom_device_info *cdi)
 	if (cd->cdi.mask & CDC_MULTI_SESSION)
 		return 0;
 
-	buffer = kmalloc(512, GFP_KERNEL | GFP_DMA);
+	buffer = kmalloc(512, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
diff --git a/drivers/scsi/ufs/tc-dwc-g210-pci.c b/drivers/scsi/ufs/tc-dwc-g210-pci.c
index c09a0fef0fe6..a1785b023966 100644
--- a/drivers/scsi/ufs/tc-dwc-g210-pci.c
+++ b/drivers/scsi/ufs/tc-dwc-g210-pci.c
@@ -140,7 +140,6 @@ tc_dwc_g210_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return err;
 	}
 
-	pci_set_drvdata(pdev, hba);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_allow(&pdev->dev);
 
diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index b47decc1fb5b..e9b0cc4cbb4d 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -350,8 +350,6 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 		goto dealloc_host;
 	}
 
-	platform_set_drvdata(pdev, hba);
-
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index a767d942bfca..cf7946c84016 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6766,6 +6766,13 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	struct Scsi_Host *host = hba->host;
 	struct device *dev = hba->dev;
 
+	/*
+	 * dev_set_drvdata() must be called before any callbacks are registered
+	 * that use dev_get_drvdata() (frequency scaling, clock scaling, hwmon,
+	 * sysfs).
+	 */
+	dev_set_drvdata(dev, hba);
+
 	if (!mmio_base) {
 		dev_err(hba->dev,
 		"Invalid memory reference for mmio_base is NULL\n");
diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index d521adf6ac24..40820904f76c 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -546,7 +546,7 @@ static void bcm_qspi_chip_select(struct bcm_qspi *qspi, int cs)
 	u32 rd = 0;
 	u32 wr = 0;
 
-	if (qspi->base[CHIP_SELECT]) {
+	if (cs >= 0 && qspi->base[CHIP_SELECT]) {
 		rd = bcm_qspi_read(qspi, CHIP_SELECT, 0);
 		wr = (rd & ~0xff) | (1 << cs);
 		if (rd == wr)
diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 616566e793c6..28975b6f054f 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -357,6 +357,7 @@ static int meson_spifc_probe(struct platform_device *pdev)
 	return 0;
 out_clk:
 	clk_disable_unprepare(spifc->clk);
+	pm_runtime_disable(spifc->dev);
 out_err:
 	spi_master_put(master);
 	return ret;
diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index dd0bf25d4550..348f136d9e13 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -440,7 +440,7 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 	else
 		mdata->state = MTK_SPI_IDLE;
 
-	if (!master->can_dma(master, master->cur_msg->spi, trans)) {
+	if (!master->can_dma(master, NULL, trans)) {
 		if (trans->rx_buf) {
 			cnt = mdata->xfer_len / 4;
 			ioread32_rep(mdata->base + SPI_RX_DATA_REG,
diff --git a/drivers/staging/android/ion/ion-ioctl.c b/drivers/staging/android/ion/ion-ioctl.c
index e3596855a703..a27865b94416 100644
--- a/drivers/staging/android/ion/ion-ioctl.c
+++ b/drivers/staging/android/ion/ion-ioctl.c
@@ -30,6 +30,69 @@ union ion_ioctl_arg {
 	struct ion_heap_query query;
 };
 
+/* Must hold the client lock */
+static void user_ion_handle_get(struct ion_handle *handle)
+{
+	if (handle->user_ref_count++ == 0)
+		kref_get(&handle->ref);
+}
+
+/* Must hold the client lock */
+static struct ion_handle *user_ion_handle_get_check_overflow(
+	struct ion_handle *handle)
+{
+	if (handle->user_ref_count + 1 == 0)
+		return ERR_PTR(-EOVERFLOW);
+	user_ion_handle_get(handle);
+	return handle;
+}
+
+/* passes a kref to the user ref count.
+ * We know we're holding a kref to the object before and
+ * after this call, so no need to reverify handle.
+ */
+static struct ion_handle *pass_to_user(struct ion_handle *handle)
+{
+	struct ion_client *client = handle->client;
+	struct ion_handle *ret;
+
+	mutex_lock(&client->lock);
+	ret = user_ion_handle_get_check_overflow(handle);
+	ion_handle_put_nolock(handle);
+	mutex_unlock(&client->lock);
+	return ret;
+}
+
+/* Must hold the client lock */
+static int user_ion_handle_put_nolock(struct ion_handle *handle)
+{
+	int ret;
+
+	if (--handle->user_ref_count == 0)
+		ret = ion_handle_put_nolock(handle);
+
+	return ret;
+}
+
+static void user_ion_free_nolock(struct ion_client *client,
+				 struct ion_handle *handle)
+{
+	bool valid_handle;
+
+	WARN_ON(client != handle->client);
+
+	valid_handle = ion_handle_validate(client, handle);
+	if (!valid_handle) {
+		WARN(1, "%s: invalid handle passed to free.\n", __func__);
+		return;
+	}
+	if (handle->user_ref_count == 0) {
+		WARN(1, "%s: User does not have access!\n", __func__);
+		return;
+	}
+	user_ion_handle_put_nolock(handle);
+}
+
 static int validate_ioctl_arg(unsigned int cmd, union ion_ioctl_arg *arg)
 {
 	int ret = 0;
@@ -96,16 +159,15 @@ long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	{
 		struct ion_handle *handle;
 
-		handle = ion_alloc(client, data.allocation.len,
-						data.allocation.align,
-						data.allocation.heap_id_mask,
-						data.allocation.flags);
+		handle = __ion_alloc(client, data.allocation.len,
+				     data.allocation.align,
+				     data.allocation.heap_id_mask,
+				     data.allocation.flags, true);
 		if (IS_ERR(handle))
 			return PTR_ERR(handle);
-
 		data.allocation.handle = handle->id;
-
 		cleanup_handle = handle;
+		pass_to_user(handle);
 		break;
 	}
 	case ION_IOC_FREE:
@@ -118,7 +180,7 @@ long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			mutex_unlock(&client->lock);
 			return PTR_ERR(handle);
 		}
-		ion_free_nolock(client, handle);
+		user_ion_free_nolock(client, handle);
 		ion_handle_put_nolock(handle);
 		mutex_unlock(&client->lock);
 		break;
@@ -146,10 +208,16 @@ long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		struct ion_handle *handle;
 
 		handle = ion_import_dma_buf_fd(client, data.fd.fd);
-		if (IS_ERR(handle))
+		if (IS_ERR(handle)) {
 			ret = PTR_ERR(handle);
-		else
+		} else {
 			data.handle.handle = handle->id;
+			handle = pass_to_user(handle);
+			if (IS_ERR(handle)) {
+				ret = PTR_ERR(handle);
+				data.handle.handle = 0;
+			}
+		}
 		break;
 	}
 	case ION_IOC_SYNC:
@@ -174,10 +242,16 @@ long ion_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	if (dir & _IOC_READ) {
 		if (copy_to_user((void __user *)arg, &data, _IOC_SIZE(cmd))) {
-			if (cleanup_handle)
-				ion_free(client, cleanup_handle);
+			if (cleanup_handle) {
+				mutex_lock(&client->lock);
+				user_ion_free_nolock(client, cleanup_handle);
+				ion_handle_put_nolock(cleanup_handle);
+				mutex_unlock(&client->lock);
+			}
 			return -EFAULT;
 		}
 	}
+	if (cleanup_handle)
+		ion_handle_put(cleanup_handle);
 	return ret;
 }
diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index aac9b38b8c25..b272f2ab87e8 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -363,8 +363,8 @@ struct ion_handle *ion_handle_get_by_id_nolock(struct ion_client *client,
 	return ERR_PTR(-EINVAL);
 }
 
-static bool ion_handle_validate(struct ion_client *client,
-				struct ion_handle *handle)
+bool ion_handle_validate(struct ion_client *client,
+			 struct ion_handle *handle)
 {
 	WARN_ON(!mutex_is_locked(&client->lock));
 	return idr_find(&client->idr, handle->id) == handle;
@@ -401,9 +401,9 @@ static int ion_handle_add(struct ion_client *client, struct ion_handle *handle)
 	return 0;
 }
 
-struct ion_handle *ion_alloc(struct ion_client *client, size_t len,
-			     size_t align, unsigned int heap_id_mask,
-			     unsigned int flags)
+struct ion_handle *__ion_alloc(struct ion_client *client, size_t len,
+			       size_t align, unsigned int heap_id_mask,
+			       unsigned int flags, bool grab_handle)
 {
 	struct ion_handle *handle;
 	struct ion_device *dev = client->dev;
@@ -453,6 +453,8 @@ struct ion_handle *ion_alloc(struct ion_client *client, size_t len,
 		return handle;
 
 	mutex_lock(&client->lock);
+	if (grab_handle)
+		ion_handle_get(handle);
 	ret = ion_handle_add(client, handle);
 	mutex_unlock(&client->lock);
 	if (ret) {
@@ -462,6 +464,13 @@ struct ion_handle *ion_alloc(struct ion_client *client, size_t len,
 
 	return handle;
 }
+
+struct ion_handle *ion_alloc(struct ion_client *client, size_t len,
+			     size_t align, unsigned int heap_id_mask,
+			     unsigned int flags)
+{
+	return __ion_alloc(client, len, align, heap_id_mask, flags, false);
+}
 EXPORT_SYMBOL(ion_alloc);
 
 void ion_free_nolock(struct ion_client *client,
diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index 93dafb4586e4..cfa50dfb46ed 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -109,6 +109,10 @@ struct ion_handle *ion_alloc(struct ion_client *client, size_t len,
 			     size_t align, unsigned int heap_id_mask,
 			     unsigned int flags);
 
+struct ion_handle *__ion_alloc(struct ion_client *client, size_t len,
+			       size_t align, unsigned int heap_id_mask,
+			       unsigned int flags, bool grab_handle);
+
 /**
  * ion_free - free a handle
  * @client:	the client
diff --git a/drivers/staging/android/ion/ion_priv.h b/drivers/staging/android/ion/ion_priv.h
index 760e41885448..e1dd25eab1db 100644
--- a/drivers/staging/android/ion/ion_priv.h
+++ b/drivers/staging/android/ion/ion_priv.h
@@ -149,6 +149,7 @@ struct ion_client {
  */
 struct ion_handle {
 	struct kref ref;
+	unsigned int user_ref_count;
 	struct ion_client *client;
 	struct ion_buffer *buffer;
 	struct rb_node node;
@@ -459,6 +460,9 @@ int ion_sync_for_device(struct ion_client *client, int fd);
 struct ion_handle *ion_handle_get_by_id_nolock(struct ion_client *client,
 						int id);
 
+bool ion_handle_validate(struct ion_client *client,
+			 struct ion_handle *handle);
+
 void ion_free_nolock(struct ion_client *client, struct ion_handle *handle);
 
 int ion_handle_put_nolock(struct ion_handle *handle);
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 027531990674..a76723a4219a 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -343,7 +343,10 @@ static int __init fbtft_driver_module_init(void)                           \
 	ret = spi_register_driver(&fbtft_driver_spi_driver);               \
 	if (ret < 0)                                                       \
 		return ret;                                                \
-	return platform_driver_register(&fbtft_driver_platform_driver);    \
+	ret = platform_driver_register(&fbtft_driver_platform_driver);     \
+	if (ret < 0)                                                       \
+		spi_unregister_driver(&fbtft_driver_spi_driver);           \
+	return ret;                                                        \
 }                                                                          \
 									   \
 static void __exit fbtft_driver_module_exit(void)                          \
diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index 9d4e3b0d366f..fbaf3c407989 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -3848,18 +3848,18 @@ static void hfa384x_usb_throttlefn(unsigned long data)
 
 	spin_lock_irqsave(&hw->ctlxq.lock, flags);
 
-	/*
-	 * We need to check BOTH the RX and the TX throttle controls,
-	 * so we use the bitwise OR instead of the logical OR.
-	 */
 	pr_debug("flags=0x%lx\n", hw->usb_flags);
-	if (!hw->wlandev->hwremoved &&
-	    ((test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
-	      !test_and_set_bit(WORK_RX_RESUME, &hw->usb_flags)) |
-	     (test_and_clear_bit(THROTTLE_TX, &hw->usb_flags) &&
-	      !test_and_set_bit(WORK_TX_RESUME, &hw->usb_flags))
-	    )) {
-		schedule_work(&hw->usb_work);
+	if (!hw->wlandev->hwremoved) {
+		bool rx_throttle = test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
+				   !test_and_set_bit(WORK_RX_RESUME, &hw->usb_flags);
+		bool tx_throttle = test_and_clear_bit(THROTTLE_TX, &hw->usb_flags) &&
+				   !test_and_set_bit(WORK_TX_RESUME, &hw->usb_flags);
+		/*
+		 * We need to check BOTH the RX and the TX throttle controls,
+		 * so we use the bitwise OR instead of the logical OR.
+		 */
+		if (rx_throttle | tx_throttle)
+			schedule_work(&hw->usb_work);
 	}
 
 	spin_unlock_irqrestore(&hw->ctlxq.lock, flags);
diff --git a/drivers/target/iscsi/iscsi_target_tpg.c b/drivers/target/iscsi/iscsi_target_tpg.c
index 761b065a40bb..b2a76ecb5789 100644
--- a/drivers/target/iscsi/iscsi_target_tpg.c
+++ b/drivers/target/iscsi/iscsi_target_tpg.c
@@ -452,6 +452,9 @@ static bool iscsit_tpg_check_network_portal(
 				break;
 		}
 		spin_unlock(&tpg->tpg_np_lock);
+
+		if (match)
+			break;
 	}
 	spin_unlock(&tiqn->tiqn_tpg_lock);
 
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 1ab9bd433542..67e5b587a106 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -329,6 +329,7 @@ static struct tty_driver *gsm_tty_driver;
 #define GSM1_ESCAPE_BITS	0x20
 #define XON			0x11
 #define XOFF			0x13
+#define ISO_IEC_646_MASK	0x7F
 
 static const struct tty_port_operations gsm_port_ops;
 
@@ -547,7 +548,8 @@ static int gsm_stuff_frame(const u8 *input, u8 *output, int len)
 	int olen = 0;
 	while (len--) {
 		if (*input == GSM1_SOF || *input == GSM1_ESCAPE
-		    || *input == XON || *input == XOFF) {
+		    || (*input & ISO_IEC_646_MASK) == XON
+		    || (*input & ISO_IEC_646_MASK) == XOFF) {
 			*output++ = GSM1_ESCAPE;
 			*output++ = *input++ ^ GSM1_ESCAPE_BITS;
 			olen++;
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 8214b0326b3a..690cb5a63f9a 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1377,7 +1377,7 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 			put_tty_queue(c, ldata);
 			smp_store_release(&ldata->canon_head, ldata->read_head);
 			kill_fasync(&tty->fasync, SIGIO, POLL_IN);
-			wake_up_interruptible_poll(&tty->read_wait, POLLIN);
+			wake_up_interruptible_poll(&tty->read_wait, POLLIN | POLLRDNORM);
 			return 0;
 		}
 	}
@@ -1658,7 +1658,7 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 
 	if (read_cnt(ldata)) {
 		kill_fasync(&tty->fasync, SIGIO, POLL_IN);
-		wake_up_interruptible_poll(&tty->read_wait, POLLIN);
+		wake_up_interruptible_poll(&tty->read_wait, POLLIN | POLLRDNORM);
 	}
 }
 
diff --git a/drivers/tty/serial/8250/8250_gsc.c b/drivers/tty/serial/8250/8250_gsc.c
index b1e6ae9f1ff9..642271c2c48f 100644
--- a/drivers/tty/serial/8250/8250_gsc.c
+++ b/drivers/tty/serial/8250/8250_gsc.c
@@ -30,7 +30,7 @@ static int __init serial_init_chip(struct parisc_device *dev)
 	unsigned long address;
 	int err;
 
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) && defined(CONFIG_IOSAPIC)
 	if (!dev->irq && (dev->id.sversion == 0xad))
 		dev->irq = iosapic_serial_irq(dev);
 #endif
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 550f2f0523d8..3973bbd5ee55 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5238,8 +5238,30 @@ static struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS400,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,    /* 135a.0dc0 */
 		pbn_b2_4_115200 },
+	/* Brainboxes Devices */
 	/*
-	 * BrainBoxes UC-260
+	* Brainboxes UC-101
+	*/
+	{       PCI_VENDOR_ID_INTASHIELD, 0x0BA1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-235/246
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0AA1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_1_115200 },
+	/*
+	 * Brainboxes UC-257
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0861,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-260/271/701/756
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0D21,
 		PCI_ANY_ID, PCI_ANY_ID,
@@ -5247,7 +5269,81 @@ static struct pci_device_id serial_pci_tbl[] = {
 		pbn_b2_4_115200 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x0E34,
 		PCI_ANY_ID, PCI_ANY_ID,
-		 PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00,
+		PCI_CLASS_COMMUNICATION_MULTISERIAL << 8, 0xffff00,
+		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UC-268
+	 */
+	{       PCI_VENDOR_ID_INTASHIELD, 0x0841,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UC-275/279
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0881,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_8_115200 },
+	/*
+	 * Brainboxes UC-302
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x08E1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-310
+	 */
+	{       PCI_VENDOR_ID_INTASHIELD, 0x08C1,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-313
+	 */
+	{       PCI_VENDOR_ID_INTASHIELD, 0x08A3,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-320/324
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0A61,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_1_115200 },
+	/*
+	 * Brainboxes UC-346
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0B02,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UC-357
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0A81,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0A83,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_2_115200 },
+	/*
+	 * Brainboxes UC-368
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0C41,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_b2_4_115200 },
+	/*
+	 * Brainboxes UC-420/431
+	 */
+	{       PCI_VENDOR_ID_INTASHIELD, 0x0921,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
 		pbn_b2_4_115200 },
 	/*
 	 * Perle PCI-RAS cards
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 5d41d5b92619..7f4ba9273966 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -465,14 +465,11 @@ pl010_set_termios(struct uart_port *port, struct ktermios *termios,
 	if ((termios->c_cflag & CREAD) == 0)
 		uap->port.ignore_status_mask |= UART_DUMMY_RSR_RX;
 
-	/* first, disable everything */
 	old_cr = readb(uap->port.membase + UART010_CR) & ~UART010_CR_MSIE;
 
 	if (UART_ENABLE_MS(port, termios->c_cflag))
 		old_cr |= UART010_CR_MSIE;
 
-	writel(0, uap->port.membase + UART010_CR);
-
 	/* Set baud rate */
 	quot -= 1;
 	writel((quot & 0xf00) >> 8, uap->port.membase + UART010_LCRM);
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index f183c7199a1f..58c8103dde48 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2090,32 +2090,13 @@ static const char *pl011_type(struct uart_port *port)
 	return uap->port.type == PORT_AMBA ? uap->type : NULL;
 }
 
-/*
- * Release the memory region(s) being used by 'port'
- */
-static void pl011_release_port(struct uart_port *port)
-{
-	release_mem_region(port->mapbase, SZ_4K);
-}
-
-/*
- * Request the memory region(s) being used by 'port'
- */
-static int pl011_request_port(struct uart_port *port)
-{
-	return request_mem_region(port->mapbase, SZ_4K, "uart-pl011")
-			!= NULL ? 0 : -EBUSY;
-}
-
 /*
  * Configure/autoconfigure the port.
  */
 static void pl011_config_port(struct uart_port *port, int flags)
 {
-	if (flags & UART_CONFIG_TYPE) {
+	if (flags & UART_CONFIG_TYPE)
 		port->type = PORT_AMBA;
-		pl011_request_port(port);
-	}
 }
 
 /*
@@ -2130,6 +2111,8 @@ static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
 		ret = -EINVAL;
 	if (ser->baud_base < 9600)
 		ret = -EINVAL;
+	if (port->mapbase != (unsigned long) ser->iomem_base)
+		ret = -EINVAL;
 	return ret;
 }
 
@@ -2147,8 +2130,6 @@ static struct uart_ops amba_pl011_pops = {
 	.flush_buffer	= pl011_dma_flush_buffer,
 	.set_termios	= pl011_set_termios,
 	.type		= pl011_type,
-	.release_port	= pl011_release_port,
-	.request_port	= pl011_request_port,
 	.config_port	= pl011_config_port,
 	.verify_port	= pl011_verify_port,
 #ifdef CONFIG_CONSOLE_POLL
@@ -2178,8 +2159,6 @@ static const struct uart_ops sbsa_uart_pops = {
 	.shutdown	= sbsa_uart_shutdown,
 	.set_termios	= sbsa_uart_set_termios,
 	.type		= pl011_type,
-	.release_port	= pl011_release_port,
-	.request_port	= pl011_request_port,
 	.config_port	= pl011_config_port,
 	.verify_port	= pl011_verify_port,
 #ifdef CONFIG_CONSOLE_POLL
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 4a7eb85f7c85..5dd04a1145b4 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -928,6 +928,13 @@ static void atmel_tx_dma(struct uart_port *port)
 		desc->callback = atmel_complete_tx_dma;
 		desc->callback_param = atmel_port;
 		atmel_port->cookie_tx = dmaengine_submit(desc);
+		if (dma_submit_error(atmel_port->cookie_tx)) {
+			dev_err(port->dev, "dma_submit_error %d\n",
+				atmel_port->cookie_tx);
+			return;
+		}
+
+		dma_async_issue_pending(chan);
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
@@ -1186,6 +1193,13 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	desc->callback_param = port;
 	atmel_port->desc_rx = desc;
 	atmel_port->cookie_rx = dmaengine_submit(desc);
+	if (dma_submit_error(atmel_port->cookie_rx)) {
+		dev_err(port->dev, "dma_submit_error %d\n",
+			atmel_port->cookie_rx);
+		goto chan_err;
+	}
+
+	dma_async_issue_pending(atmel_port->chan_rx);
 
 	return 0;
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index e97961dc3622..ec458add3883 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2349,7 +2349,8 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		 * We probably don't need a spinlock around this, but
 		 */
 		spin_lock_irqsave(&port->lock, flags);
-		port->ops->set_mctrl(port, port->mctrl & TIOCM_DTR);
+		port->mctrl &= TIOCM_DTR;
+		port->ops->set_mctrl(port, port->mctrl);
 		spin_unlock_irqrestore(&port->lock, flags);
 
 		/*
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b4f528d26bf1..5c6243a31166 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2377,6 +2377,10 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 
 		serial_port_out(port, SCFCR, ctrl);
 	}
+	if (port->flags & UPF_HARD_FLOW) {
+		/* Refresh (Auto) RTS */
+		sci_set_mctrl(port, port->mctrl);
+	}
 
 	scr_val |= s->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0);
 	dev_dbg(port->dev, "SCSCR 0x%x\n", scr_val);
@@ -2391,10 +2395,6 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		 */
 		udelay(DIV_ROUND_UP(10 * 1000000, baud));
 	}
-	if (port->flags & UPF_HARD_FLOW) {
-		/* Refresh (Auto) RTS */
-		sci_set_mctrl(port, port->mctrl);
-	}
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	/*
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index f325019887b2..766941a6e1aa 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -389,7 +389,7 @@ static void stm32_start_tx(struct uart_port *port)
 {
 	struct circ_buf *xmit = &port->state->xmit;
 
-	if (uart_circ_empty(xmit))
+	if (uart_circ_empty(xmit) && !port->x_char)
 		return;
 
 	stm32_transmit_chars(port);
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index e1c1627a3356..e785a8a7f1c2 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -694,6 +694,7 @@ int vt_ioctl(struct tty_struct *tty,
 			ret =  -ENXIO;
 		else {
 			arg--;
+			arg = array_index_nospec(arg, MAX_NR_CONSOLES);
 			console_lock();
 			ret = vc_allocate(arg);
 			console_unlock();
@@ -718,9 +719,9 @@ int vt_ioctl(struct tty_struct *tty,
 		if (vsa.console == 0 || vsa.console > MAX_NR_CONSOLES)
 			ret = -ENXIO;
 		else {
-			vsa.console = array_index_nospec(vsa.console,
-							 MAX_NR_CONSOLES + 1);
 			vsa.console--;
+			vsa.console = array_index_nospec(vsa.console,
+							 MAX_NR_CONSOLES);
 			console_lock();
 			ret = vc_allocate(vsa.console);
 			if (ret == 0) {
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 35220ce86815..e43d8df2d68c 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -760,6 +760,7 @@ void usb_hcd_poll_rh_status(struct usb_hcd *hcd)
 {
 	struct urb	*urb;
 	int		length;
+	int		status;
 	unsigned long	flags;
 	char		buffer[6];	/* Any root hubs with > 31 ports? */
 
@@ -777,11 +778,17 @@ void usb_hcd_poll_rh_status(struct usb_hcd *hcd)
 		if (urb) {
 			clear_bit(HCD_FLAG_POLL_PENDING, &hcd->flags);
 			hcd->status_urb = NULL;
+			if (urb->transfer_buffer_length >= length) {
+				status = 0;
+			} else {
+				status = -EOVERFLOW;
+				length = urb->transfer_buffer_length;
+			}
 			urb->actual_length = length;
 			memcpy(urb->transfer_buffer, buffer, length);
 
 			usb_hcd_unlink_urb_from_ep(hcd, urb);
-			usb_hcd_giveback_urb(hcd, urb, 0);
+			usb_hcd_giveback_urb(hcd, urb, status);
 		} else {
 			length = 0;
 			set_bit(HCD_FLAG_POLL_PENDING, &hcd->flags);
@@ -1661,6 +1668,13 @@ int usb_hcd_submit_urb (struct urb *urb, gfp_t mem_flags)
 		urb->hcpriv = NULL;
 		INIT_LIST_HEAD(&urb->urb_list);
 		atomic_dec(&urb->use_count);
+		/*
+		 * Order the write of urb->use_count above before the read
+		 * of urb->reject below.  Pairs with the memory barriers in
+		 * usb_kill_urb() and usb_poison_urb().
+		 */
+		smp_mb__after_atomic();
+
 		atomic_dec(&urb->dev->urbnum);
 		if (atomic_read(&urb->reject))
 			wake_up(&usb_kill_urb_queue);
@@ -1770,6 +1784,13 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 
 	usb_anchor_resume_wakeups(anchor);
 	atomic_dec(&urb->use_count);
+	/*
+	 * Order the write of urb->use_count above before the read
+	 * of urb->reject below.  Pairs with the memory barriers in
+	 * usb_kill_urb() and usb_poison_urb().
+	 */
+	smp_mb__after_atomic();
+
 	if (unlikely(atomic_read(&urb->reject)))
 		wake_up(&usb_kill_urb_queue);
 	usb_put_urb(urb);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 0abcf8bbb73f..33bf5ba43839 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1070,7 +1070,10 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		} else {
 			hub_power_on(hub, true);
 		}
-	}
+	/* Give some time on remote wakeup to let links to transit to U0 */
+	} else if (hub_is_superspeed(hub->hdev))
+		msleep(20);
+
  init2:
 
 	/*
@@ -1185,7 +1188,7 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 			 */
 			if (portchange || (hub_is_superspeed(hub->hdev) &&
 						port_resumed))
-				set_bit(port1, hub->change_bits);
+				set_bit(port1, hub->event_bits);
 
 		} else if (udev->persist_enabled) {
 #ifdef CONFIG_PM
diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 6785ebc07804..ec8921d09e32 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -684,6 +684,12 @@ void usb_kill_urb(struct urb *urb)
 	if (!(urb && urb->dev && urb->ep))
 		return;
 	atomic_inc(&urb->reject);
+	/*
+	 * Order the write of urb->reject above before the read
+	 * of urb->use_count below.  Pairs with the barriers in
+	 * __usb_hcd_giveback_urb() and usb_hcd_submit_urb().
+	 */
+	smp_mb__after_atomic();
 
 	usb_hcd_unlink_urb(urb, -ENOENT);
 	wait_event(usb_kill_urb_queue, atomic_read(&urb->use_count) == 0);
@@ -725,6 +731,12 @@ void usb_poison_urb(struct urb *urb)
 	if (!urb)
 		return;
 	atomic_inc(&urb->reject);
+	/*
+	 * Order the write of urb->reject above before the read
+	 * of urb->use_count below.  Pairs with the barriers in
+	 * __usb_hcd_giveback_urb() and usb_hcd_submit_urb().
+	 */
+	smp_mb__after_atomic();
 
 	if (!urb->dev || !urb->ep)
 		return;
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index e7ad3ae4ea6b..65bcbbad6d54 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3979,7 +3979,7 @@ int dwc2_hsotg_suspend(struct dwc2_hsotg *hsotg)
 		hsotg->gadget.speed = USB_SPEED_UNKNOWN;
 		spin_unlock_irqrestore(&hsotg->lock, flags);
 
-		for (ep = 0; ep < hsotg->num_of_eps; ep++) {
+		for (ep = 1; ep < hsotg->num_of_eps; ep++) {
 			if (hsotg->eps_in[ep])
 				dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
 			if (hsotg->eps_out[ep])
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e340ef67321e..58c4b745eae1 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -902,6 +902,19 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
 		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(req->request.stream_id);
 
+	/*
+	 * As per data book 4.2.3.2TRB Control Bit Rules section
+	 *
+	 * The controller autonomously checks the HWO field of a TRB to determine if the
+	 * entire TRB is valid. Therefore, software must ensure that the rest of the TRB
+	 * is valid before setting the HWO field to '1'. In most systems, this means that
+	 * software must update the fourth DWORD of a TRB last.
+	 *
+	 * However there is a possibility of CPU re-ordering here which can cause
+	 * controller to observe the HWO bit set prematurely.
+	 * Add a write memory barrier to prevent CPU re-ordering.
+	 */
+	wmb();
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
 	trace_dwc3_prepare_trb(dep, trb);
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index a7c44a3cb2d2..3b8a8e2d3484 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1932,6 +1932,9 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 				if (w_index != 0x5 || (w_value >> 8))
 					break;
 				interface = w_value & 0xFF;
+				if (interface >= MAX_CONFIG_INTERFACES ||
+				    !os_desc_cfg->interface[interface])
+					break;
 				buf[6] = w_index;
 				if (w_length == 0x0A) {
 					count = count_ext_prop(os_desc_cfg,
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 1a31becac203..e3bd904a445e 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -608,7 +608,7 @@ static int ffs_ep0_open(struct inode *inode, struct file *file)
 	file->private_data = ffs;
 	ffs_data_opened(ffs);
 
-	return 0;
+	return stream_open(inode, file);
 }
 
 static int ffs_ep0_release(struct inode *inode, struct file *file)
@@ -1071,7 +1071,7 @@ ffs_epfile_open(struct inode *inode, struct file *file)
 	file->private_data = epfile;
 	ffs_data_opened(epfile->ffs);
 
-	return 0;
+	return stream_open(inode, file);
 }
 
 static int ffs_aio_cancel(struct kiocb *kiocb)
diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
index 1c5745f7abea..16142c321df8 100644
--- a/drivers/usb/gadget/function/f_sourcesink.c
+++ b/drivers/usb/gadget/function/f_sourcesink.c
@@ -587,6 +587,7 @@ static int source_sink_start_ep(struct f_sourcesink *ss, bool is_in,
 
 	if (is_iso) {
 		switch (speed) {
+		case USB_SPEED_SUPER_PLUS:
 		case USB_SPEED_SUPER:
 			size = ss->isoc_maxpacket *
 					(ss->isoc_mult + 1) *
diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index ab6ac1b74ac0..a912b6b9153f 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -642,14 +642,17 @@ static int rndis_set_response(struct rndis_params *params,
 	rndis_set_cmplt_type *resp;
 	rndis_resp_t *r;
 
+	BufLength = le32_to_cpu(buf->InformationBufferLength);
+	BufOffset = le32_to_cpu(buf->InformationBufferOffset);
+	if ((BufLength > RNDIS_MAX_TOTAL_SIZE) ||
+	    (BufOffset + 8 >= RNDIS_MAX_TOTAL_SIZE))
+		    return -EINVAL;
+
 	r = rndis_add_response(params, sizeof(rndis_set_cmplt_type));
 	if (!r)
 		return -ENOMEM;
 	resp = (rndis_set_cmplt_type *)r->buf;
 
-	BufLength = le32_to_cpu(buf->InformationBufferLength);
-	BufOffset = le32_to_cpu(buf->InformationBufferOffset);
-
 #ifdef	VERBOSE_DEBUG
 	pr_debug("%s: Length: %d\n", __func__, BufLength);
 	pr_debug("%s: Offset: %d\n", __func__, BufOffset);
diff --git a/drivers/usb/misc/ftdi-elan.c b/drivers/usb/misc/ftdi-elan.c
index 9a82f8308ad7..0738078fe8b8 100644
--- a/drivers/usb/misc/ftdi-elan.c
+++ b/drivers/usb/misc/ftdi-elan.c
@@ -206,6 +206,7 @@ static void ftdi_elan_delete(struct kref *kref)
 	mutex_unlock(&ftdi_module_lock);
 	kfree(ftdi->bulk_in_buffer);
 	ftdi->bulk_in_buffer = NULL;
+	kfree(ftdi);
 }
 
 static void ftdi_elan_put_kref(struct usb_ftdi *ftdi)
diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index c6ff79360302..a8573da2717a 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -74,6 +74,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x1a86, 0x5523) },
 	{ USB_DEVICE(0x1a86, 0x7522) },
 	{ USB_DEVICE(0x1a86, 0x7523) },
+	{ USB_DEVICE(0x2184, 0x0057) },
 	{ USB_DEVICE(0x4348, 0x5523) },
 	{ USB_DEVICE(0x9986, 0x7523) },
 	{ },
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index dde28ede396b..ddee42e44a33 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -49,6 +49,7 @@ static int cp210x_port_remove(struct usb_serial_port *);
 static void cp210x_dtr_rts(struct usb_serial_port *p, int on);
 
 static const struct usb_device_id id_table[] = {
+	{ USB_DEVICE(0x0404, 0x034C) },	/* NCR Retail IO Box */
 	{ USB_DEVICE(0x045B, 0x0053) }, /* Renesas RX610 RX-Stick */
 	{ USB_DEVICE(0x0471, 0x066A) }, /* AKTAKOM ACE-1001 cable */
 	{ USB_DEVICE(0x0489, 0xE000) }, /* Pirelli Broadband S.p.A, DP-L10 SIP/GSM Mobile */
@@ -66,6 +67,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x0FCF, 0x1004) }, /* Dynastream ANT2USB */
 	{ USB_DEVICE(0x0FCF, 0x1006) }, /* Dynastream ANT development board */
 	{ USB_DEVICE(0x0FDE, 0xCA05) }, /* OWL Wireless Electricity Monitor CM-160 */
+	{ USB_DEVICE(0x106F, 0x0003) },	/* CPI / Money Controls Bulk Coin Recycler */
 	{ USB_DEVICE(0x10A6, 0xAA26) }, /* Knock-off DCU-11 cable */
 	{ USB_DEVICE(0x10AB, 0x10C5) }, /* Siemens MC60 Cable */
 	{ USB_DEVICE(0x10B5, 0xAC70) }, /* Nokia CA-42 USB */
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index fe6b32c2ff1c..5c4fa4fcb1e8 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -964,6 +964,7 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_VX_023_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_VX_034_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_101_PID) },
+	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_159_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_160_1_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_160_2_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_160_3_PID) },
@@ -972,12 +973,14 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_160_6_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_160_7_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_160_8_PID) },
+	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_235_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_257_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_279_1_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_279_2_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_279_3_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_279_4_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_313_PID) },
+	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_320_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_324_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_346_1_PID) },
 	{ USB_DEVICE(BRAINBOXES_VID, BRAINBOXES_US_346_2_PID) },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 3b7cea8df446..006e92d26bab 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1505,6 +1505,9 @@
 #define BRAINBOXES_VX_023_PID		0x1003 /* VX-023 ExpressCard 1 Port RS422/485 */
 #define BRAINBOXES_VX_034_PID		0x1004 /* VX-034 ExpressCard 2 Port RS422/485 */
 #define BRAINBOXES_US_101_PID		0x1011 /* US-101 1xRS232 */
+#define BRAINBOXES_US_159_PID		0x1021 /* US-159 1xRS232 */
+#define BRAINBOXES_US_235_PID		0x1017 /* US-235 1xRS232 */
+#define BRAINBOXES_US_320_PID		0x1019 /* US-320 1xRS422/485 */
 #define BRAINBOXES_US_324_PID		0x1013 /* US-324 1xRS422/485 1Mbaud */
 #define BRAINBOXES_US_606_1_PID		0x2001 /* US-606 6 Port RS232 Serial Port 1 and 2 */
 #define BRAINBOXES_US_606_2_PID		0x2002 /* US-606 6 Port RS232 Serial Port 3 and 4 */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 9479abb9eaaa..4c3ff0706554 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1625,6 +1625,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(2) },
 	{ USB_DEVICE_INTERFACE_CLASS(ZTE_VENDOR_ID, 0x1476, 0xff) },	/* GosunCn ZTE WeLink ME3630 (ECM/NCM mode) */
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x1481, 0xff, 0x00, 0x00) }, /* ZTE MF871A */
+	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x1485, 0xff, 0xff, 0xff),  /* ZTE MF286D */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x1533, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x1534, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x1535, 0xff, 0xff, 0xff) },
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index ec2b7f5c900c..801351f360da 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2308,6 +2308,16 @@ UNUSUAL_DEV(  0x2027, 0xa001, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, usb_stor_euscsi_init,
 		US_FL_SCM_MULT_TARG ),
 
+/*
+ * Reported by DocMAX <mail@vacharakis.de>
+ * and Thomas Weißschuh <linux@weissschuh.net>
+ */
+UNUSUAL_DEV( 0x2109, 0x0715, 0x9999, 0x9999,
+		"VIA Labs, Inc.",
+		"VL817 SATA Bridge",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_UAS),
+
 UNUSUAL_DEV( 0x2116, 0x0320, 0x0001, 0x0001,
 		"ST",
 		"2A",
diff --git a/drivers/w1/slaves/w1_ds28e04.c b/drivers/w1/slaves/w1_ds28e04.c
index 5e348d38ec5c..f4cf54c256fd 100644
--- a/drivers/w1/slaves/w1_ds28e04.c
+++ b/drivers/w1/slaves/w1_ds28e04.c
@@ -39,7 +39,7 @@ static int w1_strong_pullup = 1;
 module_param_named(strong_pullup, w1_strong_pullup, int, 0);
 
 /* enable/disable CRC checking on DS28E04-100 memory accesses */
-static char w1_enable_crccheck = 1;
+static bool w1_enable_crccheck = true;
 
 #define W1_EEPROM_SIZE		512
 #define W1_PAGE_COUNT		16
@@ -346,32 +346,18 @@ static BIN_ATTR_RW(pio, 1);
 static ssize_t crccheck_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
-	if (put_user(w1_enable_crccheck + 0x30, buf))
-		return -EFAULT;
-
-	return sizeof(w1_enable_crccheck);
+	return sysfs_emit(buf, "%d\n", w1_enable_crccheck);
 }
 
 static ssize_t crccheck_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
-	char val;
-
-	if (count != 1 || !buf)
-		return -EINVAL;
+	int err = kstrtobool(buf, &w1_enable_crccheck);
 
-	if (get_user(val, buf))
-		return -EFAULT;
+	if (err)
+		return err;
 
-	/* convert to decimal */
-	val = val - 0x30;
-	if (val != 0 && val != 1)
-		return -EINVAL;
-
-	/* set the new value */
-	w1_enable_crccheck = val;
-
-	return sizeof(w1_enable_crccheck);
+	return count;
 }
 
 static DEVICE_ATTR_RW(crccheck);
diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index bb008ac507fe..16169b35ab6e 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1271,7 +1271,12 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 	ret = btrfs_search_slot(trans, fs_info->extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		goto out;
-	BUG_ON(ret == 0);
+	if (ret == 0) {
+		/* This shouldn't happen, indicates a bug or fs corruption. */
+		ASSERT(ret != 0);
+		ret = -EUCLEAN;
+		goto out;
+	}
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	if (trans && likely(trans->type != __TRANS_DUMMY) &&
@@ -1432,10 +1437,18 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 				goto out;
 			if (!ret && extent_item_pos) {
 				/*
-				 * we've recorded that parent, so we must extend
-				 * its inode list here
+				 * We've recorded that parent, so we must extend
+				 * its inode list here.
+				 *
+				 * However if there was corruption we may not
+				 * have found an eie, return an error in this
+				 * case.
 				 */
-				BUG_ON(!eie);
+				ASSERT(eie);
+				if (!eie) {
+					ret = -EUCLEAN;
+					goto out;
+				}
 				while (eie->next)
 					eie = eie->next;
 				eie->next = ref->inode_list;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 080b12d65b0c..35dea3f86fdf 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4675,6 +4675,10 @@ static ssize_t fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
 			lock_page(page);
 			if (!PageUptodate(page)) {
 				unlock_page(page);
+				btrfs_err(fs_info,
+			"send: IO error at offset %llu for inode %llu root %llu",
+					page_offset(page), sctx->cur_ino,
+					sctx->send_root->root_key.objectid);
 				put_page(page);
 				ret = -EIO;
 				break;
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 3a7f401e943c..ffab7dc88157 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -3975,6 +3975,14 @@ static int validate_message(struct dlm_lkb *lkb, struct dlm_message *ms)
 	int from = ms->m_header.h_nodeid;
 	int error = 0;
 
+	/* currently mixing of user/kernel locks are not supported */
+	if (ms->m_flags & DLM_IFL_USER && ~lkb->lkb_flags & DLM_IFL_USER) {
+		log_error(lkb->lkb_resource->res_ls,
+			  "got user dlm message for a kernel lock");
+		error = -EINVAL;
+		goto out;
+	}
+
 	switch (ms->m_type) {
 	case DLM_MSG_CONVERT:
 	case DLM_MSG_UNLOCK:
@@ -4003,6 +4011,7 @@ static int validate_message(struct dlm_lkb *lkb, struct dlm_message *ms)
 		error = -EINVAL;
 	}
 
+out:
 	if (error)
 		log_error(lkb->lkb_resource->res_ls,
 			  "ignore invalid message %d from %d %x %x %x %d",
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index a0f20a048347..c87558f120fb 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1123,7 +1123,15 @@ static void ext4_restore_inline_data(handle_t *handle, struct inode *inode,
 				     struct ext4_iloc *iloc,
 				     void *buf, int inline_size)
 {
-	ext4_create_inline_data(handle, inode, inline_size);
+	int ret;
+
+	ret = ext4_create_inline_data(handle, inode, inline_size);
+	if (ret) {
+		ext4_msg(inode->i_sb, KERN_EMERG,
+			"error restoring inline_data for inode -- potential data loss! (inode %lu, error %d)",
+			inode->i_ino, ret);
+		return;
+	}
 	ext4_write_inline_data(inode, iloc, buf, 0, inline_size);
 	ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 }
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 75fff707beb6..e7384a6e6a08 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -760,8 +760,6 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		    sizeof(range)))
 			return -EFAULT;
 
-		range.minlen = max((unsigned int)range.minlen,
-				   q->limits.discard_granularity);
 		ret = ext4_trim_fs(sb, &range);
 		if (ret < 0)
 			return ret;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 807331da9dfc..2a7fb2cf19b8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5224,6 +5224,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
  */
 int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 {
+	struct request_queue *q = bdev_get_queue(sb->s_bdev);
 	struct ext4_group_info *grp;
 	ext4_group_t group, first_group, last_group;
 	ext4_grpblk_t cnt = 0, first_cluster, last_cluster;
@@ -5242,6 +5243,13 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	    start >= max_blks ||
 	    range->len < sb->s_blocksize)
 		return -EINVAL;
+	/* No point to try to trim less than discard granularity */
+	if (range->minlen < q->limits.discard_granularity) {
+		minlen = EXT4_NUM_B2C(EXT4_SB(sb),
+			q->limits.discard_granularity >> sb->s_blocksize_bits);
+		if (minlen > EXT4_CLUSTERS_PER_GROUP(sb))
+			goto out;
+	}
 	if (end >= max_blks)
 		end = max_blks - 1;
 	if (end <= first_data_blk)
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index bce2d696d6b9..6967ab3306e7 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -462,12 +462,12 @@ int ext4_ext_migrate(struct inode *inode)
 	percpu_down_write(&sbi->s_writepages_rwsem);
 
 	/*
-	 * Worst case we can touch the allocation bitmaps, a bgd
-	 * block, and a block to link in the orphan list.  We do need
-	 * need to worry about credits for modifying the quota inode.
+	 * Worst case we can touch the allocation bitmaps and a block
+	 * group descriptor block.  We do need need to worry about
+	 * credits for modifying the quota inode.
 	 */
 	handle = ext4_journal_start(inode, EXT4_HT_MIGRATE,
-		4 + EXT4_MAXQUOTAS_TRANS_BLOCKS(inode->i_sb));
+		3 + EXT4_MAXQUOTAS_TRANS_BLOCKS(inode->i_sb));
 
 	if (IS_ERR(handle)) {
 		retval = PTR_ERR(handle);
@@ -484,6 +484,13 @@ int ext4_ext_migrate(struct inode *inode)
 		ext4_journal_stop(handle);
 		goto out_unlock;
 	}
+	/*
+	 * Use the correct seed for checksum (i.e. the seed from 'inode').  This
+	 * is so that the metadata blocks will have the correct checksum after
+	 * the migration.
+	 */
+	ei = EXT4_I(inode);
+	EXT4_I(tmp_inode)->i_csum_seed = ei->i_csum_seed;
 	i_size_write(tmp_inode, i_size_read(inode));
 	/*
 	 * Set the i_nlink to zero so it will be deleted later
@@ -492,7 +499,6 @@ int ext4_ext_migrate(struct inode *inode)
 	clear_nlink(tmp_inode);
 
 	ext4_ext_tree_init(handle, tmp_inode);
-	ext4_orphan_add(handle, tmp_inode);
 	ext4_journal_stop(handle);
 
 	/*
@@ -517,17 +523,10 @@ int ext4_ext_migrate(struct inode *inode)
 
 	handle = ext4_journal_start(inode, EXT4_HT_MIGRATE, 1);
 	if (IS_ERR(handle)) {
-		/*
-		 * It is impossible to update on-disk structures without
-		 * a handle, so just rollback in-core changes and live other
-		 * work to orphan_list_cleanup()
-		 */
-		ext4_orphan_del(NULL, tmp_inode);
 		retval = PTR_ERR(handle);
 		goto out_tmp_inode;
 	}
 
-	ei = EXT4_I(inode);
 	i_data = ei->i_data;
 	memset(&lb, 0, sizeof(lb));
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ca89590d1df5..e17a6396bde6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5602,7 +5602,7 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 	struct buffer_head *bh;
 	handle_t *handle = journal_current_handle();
 
-	if (EXT4_SB(sb)->s_journal && !handle) {
+	if (!handle) {
 		ext4_msg(sb, KERN_WARNING, "Quota write (off=%llu, len=%llu)"
 			" cancelled because transaction is not started",
 			(unsigned long long)off, (unsigned long long)len);
diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index ec85765502f1..990529da5354 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -19,6 +19,9 @@ struct posix_acl *fuse_get_acl(struct inode *inode, int type)
 	void *value = NULL;
 	struct posix_acl *acl;
 
+	if (fuse_is_bad(inode))
+		return ERR_PTR(-EIO);
+
 	if (!fc->posix_acl || fc->no_getxattr)
 		return NULL;
 
@@ -53,6 +56,9 @@ int fuse_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	const char *name;
 	int ret;
 
+	if (fuse_is_bad(inode))
+		return -EIO;
+
 	if (!fc->posix_acl || fc->no_setxattr)
 		return -EOPNOTSUPP;
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 02281fa147dd..25780052b034 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -187,7 +187,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	int ret;
 
 	inode = d_inode_rcu(entry);
-	if (inode && is_bad_inode(inode))
+	if (inode && fuse_is_bad(inode))
 		goto invalid;
 	else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
 		 (flags & LOOKUP_REVAL)) {
@@ -364,6 +364,9 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 	bool outarg_valid = true;
 	bool locked;
 
+	if (fuse_is_bad(dir))
+		return ERR_PTR(-EIO);
+
 	locked = fuse_lock_inode(dir);
 	err = fuse_lookup_name(dir->i_sb, get_node_id(dir), &entry->d_name,
 			       &outarg, &inode);
@@ -504,6 +507,9 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct dentry *res = NULL;
 
+	if (fuse_is_bad(dir))
+		return -EIO;
+
 	if (d_in_lookup(entry)) {
 		res = fuse_lookup(dir, entry, 0);
 		if (IS_ERR(res))
@@ -551,6 +557,9 @@ static int create_new_entry(struct fuse_conn *fc, struct fuse_args *args,
 	int err;
 	struct fuse_forget_link *forget;
 
+	if (fuse_is_bad(dir))
+		return -EIO;
+
 	forget = fuse_alloc_forget();
 	if (!forget)
 		return -ENOMEM;
@@ -672,6 +681,9 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	FUSE_ARGS(args);
 
+	if (fuse_is_bad(dir))
+		return -EIO;
+
 	args.in.h.opcode = FUSE_UNLINK;
 	args.in.h.nodeid = get_node_id(dir);
 	args.in.numargs = 1;
@@ -708,6 +720,9 @@ static int fuse_rmdir(struct inode *dir, struct dentry *entry)
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	FUSE_ARGS(args);
 
+	if (fuse_is_bad(dir))
+		return -EIO;
+
 	args.in.h.opcode = FUSE_RMDIR;
 	args.in.h.nodeid = get_node_id(dir);
 	args.in.numargs = 1;
@@ -786,6 +801,9 @@ static int fuse_rename2(struct inode *olddir, struct dentry *oldent,
 	struct fuse_conn *fc = get_fuse_conn(olddir);
 	int err;
 
+	if (fuse_is_bad(olddir))
+		return -EIO;
+
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE))
 		return -EINVAL;
 
@@ -921,7 +939,7 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
 	if (!err) {
 		if (fuse_invalid_attr(&outarg.attr) ||
 		    (inode->i_mode ^ outarg.attr.mode) & S_IFMT) {
-			make_bad_inode(inode);
+			fuse_make_bad(inode);
 			err = -EIO;
 		} else {
 			fuse_change_attributes(inode, &outarg.attr,
@@ -1114,6 +1132,9 @@ static int fuse_permission(struct inode *inode, int mask)
 	bool refreshed = false;
 	int err = 0;
 
+	if (fuse_is_bad(inode))
+		return -EIO;
+
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
@@ -1251,7 +1272,7 @@ static int fuse_direntplus_link(struct file *file,
 			dput(dentry);
 			goto retry;
 		}
-		if (is_bad_inode(inode)) {
+		if (fuse_is_bad(inode)) {
 			dput(dentry);
 			return -EIO;
 		}
@@ -1349,7 +1370,7 @@ static int fuse_readdir(struct file *file, struct dir_context *ctx)
 	u64 attr_version = 0;
 	bool locked;
 
-	if (is_bad_inode(inode))
+	if (fuse_is_bad(inode))
 		return -EIO;
 
 	req = fuse_get_req(fc, 1);
@@ -1409,6 +1430,9 @@ static const char *fuse_get_link(struct dentry *dentry,
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
 
+	if (fuse_is_bad(inode))
+		return ERR_PTR(-EIO);
+
 	link = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!link)
 		return ERR_PTR(-ENOMEM);
@@ -1707,7 +1731,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 
 	if (fuse_invalid_attr(&outarg.attr) ||
 	    (inode->i_mode ^ outarg.attr.mode) & S_IFMT) {
-		make_bad_inode(inode);
+		fuse_make_bad(inode);
 		err = -EIO;
 		goto error;
 	}
@@ -1763,6 +1787,9 @@ static int fuse_setattr(struct dentry *entry, struct iattr *attr)
 	struct file *file = (attr->ia_valid & ATTR_FILE) ? attr->ia_file : NULL;
 	int ret;
 
+	if (fuse_is_bad(inode))
+		return -EIO;
+
 	if (!fuse_allow_current_process(get_fuse_conn(inode)))
 		return -EACCES;
 
@@ -1821,6 +1848,9 @@ static int fuse_getattr(struct vfsmount *mnt, struct dentry *entry,
 	struct inode *inode = d_inode(entry);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
+	if (fuse_is_bad(inode))
+		return -EIO;
+
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index cea2317e0138..8aef8e56eb1b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -206,6 +206,9 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 			  fc->atomic_o_trunc &&
 			  fc->writeback_cache;
 
+	if (fuse_is_bad(inode))
+		return -EIO;
+
 	err = generic_file_open(inode, file);
 	if (err)
 		return err;
@@ -411,7 +414,7 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	struct fuse_flush_in inarg;
 	int err;
 
-	if (is_bad_inode(inode))
+	if (fuse_is_bad(inode))
 		return -EIO;
 
 	if (fc->no_flush)
@@ -459,7 +462,7 @@ int fuse_fsync_common(struct file *file, loff_t start, loff_t end,
 	struct fuse_fsync_in inarg;
 	int err;
 
-	if (is_bad_inode(inode))
+	if (fuse_is_bad(inode))
 		return -EIO;
 
 	inode_lock(inode);
@@ -771,7 +774,7 @@ static int fuse_readpage(struct file *file, struct page *page)
 	int err;
 
 	err = -EIO;
-	if (is_bad_inode(inode))
+	if (fuse_is_bad(inode))
 		goto out;
 
 	err = fuse_do_readpage(file, page);
@@ -898,7 +901,7 @@ static int fuse_readpages(struct file *file, struct address_space *mapping,
 	int nr_alloc = min_t(unsigned, nr_pages, FUSE_MAX_PAGES_PER_REQ);
 
 	err = -EIO;
-	if (is_bad_inode(inode))
+	if (fuse_is_bad(inode))
 		goto out;
 
 	data.file = file;
@@ -928,6 +931,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct inode *inode = iocb->ki_filp->f_mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
+	if (fuse_is_bad(inode))
+		return -EIO;
+
 	/*
 	 * In auto invalidate mode, always update attributes on read.
 	 * Otherwise, only update if we attempt to read past EOF (to ensure
@@ -1123,7 +1129,7 @@ static ssize_t fuse_perform_write(struct file *file,
 	int err = 0;
 	ssize_t res = 0;
 
-	if (is_bad_inode(inode))
+	if (fuse_is_bad(inode))
 		return -EIO;
 
 	if (inode->i_size < pos + iov_iter_count(ii))
@@ -1180,6 +1186,9 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t err;
 	loff_t endbyte = 0;
 
+	if (fuse_is_bad(inode))
+		return -EIO;
+
 	if (get_fuse_conn(inode)->writeback_cache) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
 		err = fuse_update_attributes(mapping->host, NULL, file, NULL);
@@ -1415,7 +1424,7 @@ static ssize_t __fuse_direct_read(struct fuse_io_priv *io,
 	struct file *file = io->file;
 	struct inode *inode = file_inode(file);
 
-	if (is_bad_inode(inode))
+	if (fuse_is_bad(inode))
 		return -EIO;
 
 	res = fuse_direct_io(io, iter, ppos, 0);
@@ -1438,7 +1447,7 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(file);
 	ssize_t res;
 
-	if (is_bad_inode(inode))
+	if (fuse_is_bad(inode))
 		return -EIO;
 
 	/* Don't allow parallel writes to the same file */
@@ -1911,7 +1920,7 @@ static int fuse_writepages(struct address_space *mapping,
 	int err;
 
 	err = -EIO;
-	if (is_bad_inode(inode))
+	if (fuse_is_bad(inode))
 		goto out;
 
 	data.inode = inode;
@@ -2687,7 +2696,7 @@ long fuse_ioctl_common(struct file *file, unsigned int cmd,
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
-	if (is_bad_inode(inode))
+	if (fuse_is_bad(inode))
 		return -EIO;
 
 	return fuse_do_ioctl(file, cmd, arg, flags);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f84dd6d87d90..7e4b0e298bc7 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -115,6 +115,8 @@ enum {
 	FUSE_I_INIT_RDPLUS,
 	/** An operation changing file size is in progress  */
 	FUSE_I_SIZE_UNSTABLE,
+	/* Bad inode */
+	FUSE_I_BAD,
 };
 
 struct fuse_conn;
@@ -688,6 +690,17 @@ static inline u64 get_node_id(struct inode *inode)
 	return get_fuse_inode(inode)->nodeid;
 }
 
+static inline void fuse_make_bad(struct inode *inode)
+{
+	remove_inode_hash(inode);
+	set_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state);
+}
+
+static inline bool fuse_is_bad(struct inode *inode)
+{
+	return unlikely(test_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state));
+}
+
 /** Device operations */
 extern const struct file_operations fuse_dev_operations;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 7a9b1069d267..77b8f0f26407 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -316,7 +316,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 		unlock_new_inode(inode);
 	} else if ((inode->i_mode ^ attr->mode) & S_IFMT) {
 		/* Inode has changed type, any I/O on the old should fail */
-		make_bad_inode(inode);
+		fuse_make_bad(inode);
 		iput(inode);
 		goto retry;
 	}
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 3caac46b08b0..134bbc432ae6 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -113,6 +113,9 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size)
 	struct fuse_getxattr_out outarg;
 	ssize_t ret;
 
+	if (fuse_is_bad(inode))
+		return -EIO;
+
 	if (!fuse_allow_current_process(fc))
 		return -EACCES;
 
@@ -178,6 +181,9 @@ static int fuse_xattr_get(const struct xattr_handler *handler,
 			 struct dentry *dentry, struct inode *inode,
 			 const char *name, void *value, size_t size)
 {
+	if (fuse_is_bad(inode))
+		return -EIO;
+
 	return fuse_getxattr(inode, name, value, size);
 }
 
@@ -186,6 +192,9 @@ static int fuse_xattr_set(const struct xattr_handler *handler,
 			  const char *name, const void *value, size_t size,
 			  int flags)
 {
+	if (fuse_is_bad(inode))
+		return -EIO;
+
 	if (!value)
 		return fuse_removexattr(inode, name);
 
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index c12476e309c6..eb4e4d784d26 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -135,20 +135,15 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 	struct page *pg;
 	struct inode *inode = mapping->host;
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
+	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
 	pgoff_t index = pos >> PAGE_SHIFT;
 	uint32_t pageofs = index << PAGE_SHIFT;
 	int ret = 0;
 
-	pg = grab_cache_page_write_begin(mapping, index, flags);
-	if (!pg)
-		return -ENOMEM;
-	*pagep = pg;
-
 	jffs2_dbg(1, "%s()\n", __func__);
 
 	if (pageofs > inode->i_size) {
 		/* Make new hole frag from old EOF to new page */
-		struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
 		struct jffs2_raw_inode ri;
 		struct jffs2_full_dnode *fn;
 		uint32_t alloc_len;
@@ -159,7 +154,7 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 		ret = jffs2_reserve_space(c, sizeof(ri), &alloc_len,
 					  ALLOC_NORMAL, JFFS2_SUMMARY_INODE_SIZE);
 		if (ret)
-			goto out_page;
+			goto out_err;
 
 		mutex_lock(&f->sem);
 		memset(&ri, 0, sizeof(ri));
@@ -189,7 +184,7 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 			ret = PTR_ERR(fn);
 			jffs2_complete_reservation(c);
 			mutex_unlock(&f->sem);
-			goto out_page;
+			goto out_err;
 		}
 		ret = jffs2_add_full_dnode_to_inode(c, f, fn);
 		if (f->metadata) {
@@ -204,13 +199,26 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 			jffs2_free_full_dnode(fn);
 			jffs2_complete_reservation(c);
 			mutex_unlock(&f->sem);
-			goto out_page;
+			goto out_err;
 		}
 		jffs2_complete_reservation(c);
 		inode->i_size = pageofs;
 		mutex_unlock(&f->sem);
 	}
 
+	/*
+	 * While getting a page and reading data in, lock c->alloc_sem until
+	 * the page is Uptodate. Otherwise GC task may attempt to read the same
+	 * page in read_cache_page(), which causes a deadlock.
+	 */
+	mutex_lock(&c->alloc_sem);
+	pg = grab_cache_page_write_begin(mapping, index, flags);
+	if (!pg) {
+		ret = -ENOMEM;
+		goto release_sem;
+	}
+	*pagep = pg;
+
 	/*
 	 * Read in the page if it wasn't already present. Cannot optimize away
 	 * the whole page write case until jffs2_write_end can handle the
@@ -220,15 +228,17 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 		mutex_lock(&f->sem);
 		ret = jffs2_do_readpage_nolock(inode, pg);
 		mutex_unlock(&f->sem);
-		if (ret)
-			goto out_page;
+		if (ret) {
+			unlock_page(pg);
+			put_page(pg);
+			goto release_sem;
+		}
 	}
 	jffs2_dbg(1, "end write_begin(). pg->flags %lx\n", pg->flags);
-	return ret;
 
-out_page:
-	unlock_page(pg);
-	put_page(pg);
+release_sem:
+	mutex_unlock(&c->alloc_sem);
+out_err:
 	return ret;
 }
 
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index d322ed5cbc1c..6386875d0a33 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -179,6 +179,7 @@ struct nfs_client *nfs_alloc_client(const struct nfs_client_initdata *cl_init)
 	INIT_LIST_HEAD(&clp->cl_superblocks);
 	clp->cl_rpcclient = ERR_PTR(-EINVAL);
 
+	clp->cl_flags = cl_init->init_flags;
 	clp->cl_proto = cl_init->proto;
 	clp->cl_net = get_net(cl_init->net);
 
@@ -400,7 +401,6 @@ nfs_get_client(const struct nfs_client_initdata *cl_init,
 			list_add_tail(&new->cl_share_link,
 					&nn->nfs_client_list);
 			spin_unlock(&nn->nfs_client_lock);
-			new->cl_flags = cl_init->init_flags;
 			return rpc_ops->init_client(new, cl_init);
 		}
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index b38fc00c323d..866047cbcdfe 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1602,6 +1602,24 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 
 no_open:
 	res = nfs_lookup(dir, dentry, lookup_flags);
+	if (!res) {
+		inode = d_inode(dentry);
+		if ((lookup_flags & LOOKUP_DIRECTORY) && inode &&
+		    !(S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)))
+			res = ERR_PTR(-ENOTDIR);
+		else if (inode && S_ISREG(inode->i_mode))
+			res = ERR_PTR(-EOPENSTALE);
+	} else if (!IS_ERR(res)) {
+		inode = d_inode(res);
+		if ((lookup_flags & LOOKUP_DIRECTORY) && inode &&
+		    !(S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))) {
+			dput(res);
+			res = ERR_PTR(-ENOTDIR);
+		} else if (inode && S_ISREG(inode->i_mode)) {
+			dput(res);
+			res = ERR_PTR(-EOPENSTALE);
+		}
+	}
 	if (switched) {
 		d_lookup_done(dentry);
 		if (!res)
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 99a3655602ed..24ad6ff8d609 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -661,11 +661,8 @@ int nfs_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat)
 
 	trace_nfs_getattr_enter(inode);
 	/* Flush out writes to the server in order to update c/mtime.  */
-	if (S_ISREG(inode->i_mode)) {
-		err = filemap_write_and_wait(inode->i_mapping);
-		if (err)
-			goto out;
-	}
+	if (S_ISREG(inode->i_mode))
+		filemap_write_and_wait(inode->i_mapping);
 
 	/*
 	 * We may force a getattr if the user cares about atime.
@@ -693,7 +690,7 @@ int nfs_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat)
 		if (S_ISDIR(inode->i_mode))
 			stat->blksize = NFS_SERVER(inode)->dtsize;
 	}
-out:
+
 	trace_nfs_getattr_exit(inode, err);
 	return err;
 }
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 3ee60c533217..48baa92846e5 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -177,8 +177,11 @@ void nfs40_shutdown_client(struct nfs_client *clp)
 
 struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 {
-	int err;
+	char buf[INET6_ADDRSTRLEN + 1];
+	const char *ip_addr = cl_init->ip_addr;
 	struct nfs_client *clp = nfs_alloc_client(cl_init);
+	int err;
+
 	if (IS_ERR(clp))
 		return clp;
 
@@ -202,6 +205,44 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 #if IS_ENABLED(CONFIG_NFS_V4_1)
 	init_waitqueue_head(&clp->cl_lock_waitq);
 #endif
+
+	if (cl_init->minorversion != 0)
+		__set_bit(NFS_CS_INFINITE_SLOTS, &clp->cl_flags);
+	__set_bit(NFS_CS_DISCRTRY, &clp->cl_flags);
+	__set_bit(NFS_CS_NO_RETRANS_TIMEOUT, &clp->cl_flags);
+
+	/*
+	 * Set up the connection to the server before we add add to the
+	 * global list.
+	 */
+	err = nfs_create_rpc_client(clp, cl_init, RPC_AUTH_GSS_KRB5I);
+	if (err == -EINVAL)
+		err = nfs_create_rpc_client(clp, cl_init, RPC_AUTH_UNIX);
+	if (err < 0)
+		goto error;
+
+	/* If no clientaddr= option was specified, find a usable cb address */
+	if (ip_addr == NULL) {
+		struct sockaddr_storage cb_addr;
+		struct sockaddr *sap = (struct sockaddr *)&cb_addr;
+
+		err = rpc_localaddr(clp->cl_rpcclient, sap, sizeof(cb_addr));
+		if (err < 0)
+			goto error;
+		err = rpc_ntop(sap, buf, sizeof(buf));
+		if (err < 0)
+			goto error;
+		ip_addr = (const char *)buf;
+	}
+	strlcpy(clp->cl_ipaddr, ip_addr, sizeof(clp->cl_ipaddr));
+
+	err = nfs_idmap_new(clp);
+	if (err < 0) {
+		dprintk("%s: failed to create idmapper. Error = %d\n",
+			__func__, err);
+		goto error;
+	}
+	__set_bit(NFS_CS_IDMAP, &clp->cl_res_state);
 	return clp;
 
 error:
@@ -354,8 +395,6 @@ static int nfs4_init_client_minor_version(struct nfs_client *clp)
 struct nfs_client *nfs4_init_client(struct nfs_client *clp,
 				    const struct nfs_client_initdata *cl_init)
 {
-	char buf[INET6_ADDRSTRLEN + 1];
-	const char *ip_addr = cl_init->ip_addr;
 	struct nfs_client *old;
 	int error;
 
@@ -365,43 +404,6 @@ struct nfs_client *nfs4_init_client(struct nfs_client *clp,
 		return clp;
 	}
 
-	/* Check NFS protocol revision and initialize RPC op vector */
-	clp->rpc_ops = &nfs_v4_clientops;
-
-	if (clp->cl_minorversion != 0)
-		__set_bit(NFS_CS_INFINITE_SLOTS, &clp->cl_flags);
-	__set_bit(NFS_CS_DISCRTRY, &clp->cl_flags);
-	__set_bit(NFS_CS_NO_RETRANS_TIMEOUT, &clp->cl_flags);
-
-	error = nfs_create_rpc_client(clp, cl_init, RPC_AUTH_GSS_KRB5I);
-	if (error == -EINVAL)
-		error = nfs_create_rpc_client(clp, cl_init, RPC_AUTH_UNIX);
-	if (error < 0)
-		goto error;
-
-	/* If no clientaddr= option was specified, find a usable cb address */
-	if (ip_addr == NULL) {
-		struct sockaddr_storage cb_addr;
-		struct sockaddr *sap = (struct sockaddr *)&cb_addr;
-
-		error = rpc_localaddr(clp->cl_rpcclient, sap, sizeof(cb_addr));
-		if (error < 0)
-			goto error;
-		error = rpc_ntop(sap, buf, sizeof(buf));
-		if (error < 0)
-			goto error;
-		ip_addr = (const char *)buf;
-	}
-	strlcpy(clp->cl_ipaddr, ip_addr, sizeof(clp->cl_ipaddr));
-
-	error = nfs_idmap_new(clp);
-	if (error < 0) {
-		dprintk("%s: failed to create idmapper. Error = %d\n",
-			__func__, error);
-		goto error;
-	}
-	__set_bit(NFS_CS_IDMAP, &clp->cl_res_state);
-
 	error = nfs4_init_client_minor_version(clp);
 	if (error < 0)
 		goto error;
@@ -1327,8 +1329,11 @@ int nfs4_update_server(struct nfs_server *server, const char *hostname,
 		goto out;
 	}
 
-	if (server->nfs_client->cl_hostname == NULL)
+	if (server->nfs_client->cl_hostname == NULL) {
 		server->nfs_client->cl_hostname = kstrdup(hostname, GFP_KERNEL);
+		if (server->nfs_client->cl_hostname == NULL)
+			return -ENOMEM;
+	}
 	nfs_server_insert_lists(server);
 
 	error = nfs_probe_destination(server);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 57facf9519b8..22b3c5436146 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1995,6 +1995,9 @@ static int nfs4_try_migration(struct nfs_server *server, struct rpc_cred *cred)
 	}
 
 	result = -NFS4ERR_NXIO;
+	if (!locations->nlocations)
+		goto out;
+
 	if (!(locations->fattr.valid & NFS_ATTR_FATTR_V4_LOCATIONS)) {
 		dprintk("<-- %s: No fs_locations data, migration skipped\n",
 			__func__);
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 0a7c4e30a385..b50c97c6aecb 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -3633,8 +3633,6 @@ static int decode_attr_fs_locations(struct xdr_stream *xdr, uint32_t *bitmap, st
 	if (unlikely(!p))
 		goto out_overflow;
 	n = be32_to_cpup(p);
-	if (n <= 0)
-		goto out_eio;
 	for (res->nlocations = 0; res->nlocations < n; res->nlocations++) {
 		u32 m;
 		struct nfs4_fs_location *loc;
@@ -4177,10 +4175,11 @@ static int decode_attr_security_label(struct xdr_stream *xdr, uint32_t *bitmap,
 		} else
 			printk(KERN_WARNING "%s: label too long (%u)!\n",
 					__func__, len);
+		if (label && label->label)
+			dprintk("%s: label=%.*s, len=%d, PI=%d, LFS=%d\n",
+				__func__, label->len, (char *)label->label,
+				label->len, label->pi, label->lfs);
 	}
-	if (label && label->label)
-		dprintk("%s: label=%s, len=%d, PI=%d, LFS=%d\n", __func__,
-			(char *)label->label, label->len, label->pi, label->lfs);
 	return status;
 
 out_overflow:
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 00b472fe77c1..1bf2e1c47cbf 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -191,6 +191,11 @@ nfsd3_proc_write(struct svc_rqst *rqstp, struct nfsd3_writeargs *argp,
 				(unsigned long long) argp->offset,
 				argp->stable? " stable" : "");
 
+	resp->status = nfserr_fbig;
+	if (argp->offset > (u64)OFFSET_MAX ||
+	    argp->offset + argp->len > (u64)OFFSET_MAX)
+		return rpc_success;
+
 	fh_copy(&resp->fh, &argp->fh);
 	resp->committed = argp->stable;
 	nfserr = nfsd_write(rqstp, &resp->fh, NULL,
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 66985a6a7047..d029decd87e3 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -982,8 +982,9 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	unsigned long cnt;
 	int nvecs;
 
-	if (write->wr_offset >= OFFSET_MAX)
-		return nfserr_inval;
+	if (write->wr_offset > (u64)OFFSET_MAX ||
+	    write->wr_offset + write->wr_buflen > (u64)OFFSET_MAX)
+		return nfserr_fbig;
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 						stateid, WR_STATE, &filp, NULL);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 524d98e3bcf5..d9381ca0ac47 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3424,8 +3424,10 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 			status = nfserr_clid_inuse;
 			if (client_has_state(old)
 					&& !same_creds(&unconf->cl_cred,
-							&old->cl_cred))
+							&old->cl_cred)) {
+				old = NULL;
 				goto out;
+			}
 			status = mark_client_expired_locked(old);
 			if (status) {
 				old = NULL;
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 82a5ecbe2da9..022b237c6a13 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -676,9 +676,14 @@ int dquot_quota_sync(struct super_block *sb, int type)
 	/* This is not very clever (and fast) but currently I don't know about
 	 * any other simple way of getting quota data to disk and we must get
 	 * them there for userspace to be visible... */
-	if (sb->s_op->sync_fs)
-		sb->s_op->sync_fs(sb, 1);
-	sync_blockdev(sb->s_bdev);
+	if (sb->s_op->sync_fs) {
+		ret = sb->s_op->sync_fs(sb, 1);
+		if (ret)
+			return ret;
+	}
+	ret = sync_blockdev(sb->s_bdev);
+	if (ret)
+		return ret;
 
 	/*
 	 * Now when everything is written we can discard the pagecache so
diff --git a/fs/super.c b/fs/super.c
index 377c439477b7..20e9cd2b6488 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1298,11 +1298,9 @@ static void lockdep_sb_freeze_acquire(struct super_block *sb)
 		percpu_rwsem_acquire(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
 }
 
-static void sb_freeze_unlock(struct super_block *sb)
+static void sb_freeze_unlock(struct super_block *sb, int level)
 {
-	int level;
-
-	for (level = SB_FREEZE_LEVELS - 1; level >= 0; level--)
+	for (level--; level >= 0; level--)
 		percpu_up_write(sb->s_writers.rw_sem + level);
 }
 
@@ -1373,7 +1371,14 @@ int freeze_super(struct super_block *sb)
 	sb_wait_write(sb, SB_FREEZE_PAGEFAULT);
 
 	/* All writers are done so after syncing there won't be dirty data */
-	sync_filesystem(sb);
+	ret = sync_filesystem(sb);
+	if (ret) {
+		sb->s_writers.frozen = SB_UNFROZEN;
+		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
+		wake_up(&sb->s_writers.wait_unfrozen);
+		deactivate_locked_super(sb);
+		return ret;
+	}
 
 	/* Now wait for internal filesystem counter */
 	sb->s_writers.frozen = SB_FREEZE_FS;
@@ -1385,7 +1390,7 @@ int freeze_super(struct super_block *sb)
 			printk(KERN_ERR
 				"VFS:Filesystem freeze failed\n");
 			sb->s_writers.frozen = SB_UNFROZEN;
-			sb_freeze_unlock(sb);
+			sb_freeze_unlock(sb, SB_FREEZE_FS);
 			wake_up(&sb->s_writers.wait_unfrozen);
 			deactivate_locked_super(sb);
 			return ret;
@@ -1437,7 +1442,7 @@ int thaw_super(struct super_block *sb)
 	}
 
 	sb->s_writers.frozen = SB_UNFROZEN;
-	sb_freeze_unlock(sb);
+	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out:
 	wake_up(&sb->s_writers.wait_unfrozen);
 	deactivate_locked_super(sb);
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 727a9e3fa806..ce58e857ae3b 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1695,7 +1695,6 @@ static int ubifs_remount_rw(struct ubifs_info *c)
 		kthread_stop(c->bgt);
 		c->bgt = NULL;
 	}
-	free_wbufs(c);
 	kfree(c->write_reserve_buf);
 	c->write_reserve_buf = NULL;
 	vfree(c->ileb_buf);
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 50607673a6a9..fab5a9506bcf 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -259,10 +259,6 @@ int udf_expand_file_adinicb(struct inode *inode)
 	char *kaddr;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	int err;
-	struct writeback_control udf_wbc = {
-		.sync_mode = WB_SYNC_NONE,
-		.nr_to_write = 1,
-	};
 
 	WARN_ON_ONCE(!inode_is_locked(inode));
 	if (!iinfo->i_lenAlloc) {
@@ -306,8 +302,10 @@ int udf_expand_file_adinicb(struct inode *inode)
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
 	/* from now on we have normal address_space methods */
 	inode->i_data.a_ops = &udf_aops;
+	set_page_dirty(page);
+	unlock_page(page);
 	up_write(&iinfo->i_data_sem);
-	err = inode->i_data.a_ops->writepage(page, &udf_wbc);
+	err = filemap_fdatawrite(inode->i_mapping);
 	if (err) {
 		/* Restore everything back so that we don't lose data... */
 		lock_page(page);
@@ -319,6 +317,7 @@ int udf_expand_file_adinicb(struct inode *inode)
 		unlock_page(page);
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
 		inode->i_data.a_ops = &udf_adinicb_aops;
+		iinfo->i_lenAlloc = inode->i_size;
 		up_write(&iinfo->i_data_sem);
 	}
 	put_page(page);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7a4c035b187f..81ee5d0b2642 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1269,6 +1269,8 @@ int copy_page_range(struct mm_struct *dst, struct mm_struct *src,
 			struct vm_area_struct *vma);
 void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows);
+int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
+			     pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp);
 int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 	unsigned long *pfn);
 int follow_phys(struct vm_area_struct *vma, unsigned long address,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b5e891aa9862..de7bfe2fabea 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2253,6 +2253,7 @@ struct packet_type {
 					 struct net_device *);
 	bool			(*id_match)(struct packet_type *ptype,
 					    struct sock *sk);
+	struct net		*af_packet_net;
 	void			*af_packet_priv;
 	struct list_head	list;
 };
diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 25c64474fc27..0a9f442409b9 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -44,10 +44,25 @@ struct rb_root {
 	struct rb_node *rb_node;
 };
 
+/*
+ * Leftmost-cached rbtrees.
+ *
+ * We do not cache the rightmost node based on footprint
+ * size vs number of potential users that could benefit
+ * from O(1) rb_last(). Just not worth it, users that want
+ * this feature can always implement the logic explicitly.
+ * Furthermore, users that want to cache both pointers may
+ * find it a bit asymmetric, but that's ok.
+ */
+struct rb_root_cached {
+	struct rb_root rb_root;
+	struct rb_node *rb_leftmost;
+};
 
 #define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~3))
 
 #define RB_ROOT	(struct rb_root) { NULL, }
+#define RB_ROOT_CACHED (struct rb_root_cached) { {NULL, }, NULL }
 #define	rb_entry(ptr, type, member) container_of(ptr, type, member)
 
 #define RB_EMPTY_ROOT(root)  (READ_ONCE((root)->rb_node) == NULL)
@@ -69,6 +84,12 @@ extern struct rb_node *rb_prev(const struct rb_node *);
 extern struct rb_node *rb_first(const struct rb_root *);
 extern struct rb_node *rb_last(const struct rb_root *);
 
+extern void rb_insert_color_cached(struct rb_node *,
+				   struct rb_root_cached *, bool);
+extern void rb_erase_cached(struct rb_node *node, struct rb_root_cached *);
+/* Same as rb_first(), but O(1) */
+#define rb_first_cached(root) (root)->rb_leftmost
+
 /* Postorder iteration - always visit the parent after its children */
 extern struct rb_node *rb_first_postorder(const struct rb_root *);
 extern struct rb_node *rb_next_postorder(const struct rb_node *);
diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index 36bfb4dd57ae..57c731177224 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -42,7 +42,9 @@ struct rb_augment_callbacks {
 	void (*rotate)(struct rb_node *old, struct rb_node *new);
 };
 
-extern void __rb_insert_augmented(struct rb_node *node, struct rb_root *root,
+extern void __rb_insert_augmented(struct rb_node *node,
+				  struct rb_root *root,
+				  bool newleft, struct rb_node **leftmost,
 	void (*augment_rotate)(struct rb_node *old, struct rb_node *new));
 /*
  * Fixup the rbtree and update the augmented information when rebalancing.
@@ -58,7 +60,16 @@ static inline void
 rb_insert_augmented(struct rb_node *node, struct rb_root *root,
 		    const struct rb_augment_callbacks *augment)
 {
-	__rb_insert_augmented(node, root, augment->rotate);
+	__rb_insert_augmented(node, root, false, NULL, augment->rotate);
+}
+
+static inline void
+rb_insert_augmented_cached(struct rb_node *node,
+			   struct rb_root_cached *root, bool newleft,
+			   const struct rb_augment_callbacks *augment)
+{
+	__rb_insert_augmented(node, &root->rb_root,
+			      newleft, &root->rb_leftmost, augment->rotate);
 }
 
 #define RB_DECLARE_CALLBACKS(rbstatic, rbname, rbstruct, rbfield,	\
@@ -149,6 +160,7 @@ extern void __rb_erase_color(struct rb_node *parent, struct rb_root *root,
 
 static __always_inline struct rb_node *
 __rb_erase_augmented(struct rb_node *node, struct rb_root *root,
+		     struct rb_node **leftmost,
 		     const struct rb_augment_callbacks *augment)
 {
 	struct rb_node *child = node->rb_right;
@@ -156,6 +168,9 @@ __rb_erase_augmented(struct rb_node *node, struct rb_root *root,
 	struct rb_node *parent, *rebalance;
 	unsigned long pc;
 
+	if (leftmost && node == *leftmost)
+		*leftmost = rb_next(node);
+
 	if (!tmp) {
 		/*
 		 * Case 1: node to erase has no more than 1 child (easy!)
@@ -255,9 +270,21 @@ static __always_inline void
 rb_erase_augmented(struct rb_node *node, struct rb_root *root,
 		   const struct rb_augment_callbacks *augment)
 {
-	struct rb_node *rebalance = __rb_erase_augmented(node, root, augment);
+	struct rb_node *rebalance = __rb_erase_augmented(node, root,
+							 NULL, augment);
 	if (rebalance)
 		__rb_erase_color(rebalance, root, augment->rotate);
 }
 
+static __always_inline void
+rb_erase_augmented_cached(struct rb_node *node, struct rb_root_cached *root,
+			  const struct rb_augment_callbacks *augment)
+{
+	struct rb_node *rebalance = __rb_erase_augmented(node, &root->rb_root,
+							 &root->rb_leftmost,
+							 augment);
+	if (rebalance)
+		__rb_erase_color(rebalance, &root->rb_root, augment->rotate);
+}
+
 #endif	/* _LINUX_RBTREE_AUGMENTED_H */
diff --git a/include/linux/timerqueue.h b/include/linux/timerqueue.h
index 7eec17ad7fa1..42868a9b4365 100644
--- a/include/linux/timerqueue.h
+++ b/include/linux/timerqueue.h
@@ -11,8 +11,7 @@ struct timerqueue_node {
 };
 
 struct timerqueue_head {
-	struct rb_root head;
-	struct timerqueue_node *next;
+	struct rb_root_cached rb_root;
 };
 
 
@@ -28,13 +27,14 @@ extern struct timerqueue_node *timerqueue_iterate_next(
  *
  * @head: head of timerqueue
  *
- * Returns a pointer to the timer node that has the
- * earliest expiration time.
+ * Returns a pointer to the timer node that has the earliest expiration time.
  */
 static inline
 struct timerqueue_node *timerqueue_getnext(struct timerqueue_head *head)
 {
-	return head->next;
+	struct rb_node *leftmost = rb_first_cached(&head->rb_root);
+
+	return rb_entry(leftmost, struct timerqueue_node, node);
 }
 
 static inline void timerqueue_init(struct timerqueue_node *node)
@@ -44,7 +44,6 @@ static inline void timerqueue_init(struct timerqueue_node *node)
 
 static inline void timerqueue_init_head(struct timerqueue_head *head)
 {
-	head->head = RB_ROOT;
-	head->next = NULL;
+	head->rb_root = RB_ROOT_CACHED;
 }
 #endif /* _LINUX_TIMERQUEUE_H */
diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index 5a23535a5018..6a6f1d3bf853 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -97,8 +97,20 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
 
 	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
 	       sizeof(struct ip_tunnel_info) + md_size);
+#ifdef CONFIG_DST_CACHE
+	/* Unclone the dst cache if there is one */
+	if (new_md->u.tun_info.dst_cache.cache) {
+		int ret;
+
+		ret = dst_cache_init(&new_md->u.tun_info.dst_cache, GFP_ATOMIC);
+		if (ret) {
+			metadata_dst_free(new_md);
+			return ERR_PTR(ret);
+		}
+	}
+#endif
+
 	skb_dst_drop(skb);
-	dst_hold(&new_md->dst);
 	skb_dst_set(skb, &new_md->dst);
 	return new_md;
 }
diff --git a/include/net/ip.h b/include/net/ip.h
index f987eaf99900..c762fd047ef4 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -377,19 +377,18 @@ static inline void ip_select_ident_segs(struct net *net, struct sk_buff *skb,
 {
 	struct iphdr *iph = ip_hdr(skb);
 
+	/* We had many attacks based on IPID, use the private
+	 * generator as much as we can.
+	 */
+	if (sk && inet_sk(sk)->inet_daddr) {
+		iph->id = htons(inet_sk(sk)->inet_id);
+		inet_sk(sk)->inet_id += segs;
+		return;
+	}
 	if ((iph->frag_off & htons(IP_DF)) && !skb->ignore_df) {
-		/* This is only to work around buggy Windows95/2000
-		 * VJ compression implementations.  If the ID field
-		 * does not change, they drop every other packet in
-		 * a TCP stream using header compression.
-		 */
-		if (sk && inet_sk(sk)->inet_daddr) {
-			iph->id = htons(inet_sk(sk)->inet_id);
-			inet_sk(sk)->inet_id += segs;
-		} else {
-			iph->id = 0;
-		}
+		iph->id = 0;
 	} else {
+		/* Unfortunately we need the big hammer to get a suitable IPID */
 		__ip_select_ident(net, iph, segs);
 	}
 }
diff --git a/include/net/netfilter/nf_nat_l4proto.h b/include/net/netfilter/nf_nat_l4proto.h
index 12f4cc841b6e..630f0f5c3fa3 100644
--- a/include/net/netfilter/nf_nat_l4proto.h
+++ b/include/net/netfilter/nf_nat_l4proto.h
@@ -64,7 +64,7 @@ void nf_nat_l4proto_unique_tuple(const struct nf_nat_l3proto *l3proto,
 				 struct nf_conntrack_tuple *tuple,
 				 const struct nf_nat_range *range,
 				 enum nf_nat_manip_type maniptype,
-				 const struct nf_conn *ct, u16 *rover);
+				 const struct nf_conn *ct);
 
 int nf_nat_l4proto_nlattr_to_range(struct nlattr *tb[],
 				   struct nf_nat_range *range);
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 3a6860f0166d..4585f6d78fc5 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -852,6 +852,7 @@ struct psched_ratecfg {
 	u64	rate_bytes_ps; /* bytes per second */
 	u32	mult;
 	u16	overhead;
+	u16	mpu;
 	u8	linklayer;
 	u8	shift;
 };
@@ -861,6 +862,9 @@ static inline u64 psched_l2t_ns(const struct psched_ratecfg *r,
 {
 	len += r->overhead;
 
+	if (len < r->mpu)
+		len = r->mpu;
+
 	if (unlikely(r->linklayer == TC_LINKLAYER_ATM))
 		return ((u64)(DIV_ROUND_UP(len,48)*53) * r->mult) >> r->shift;
 
@@ -883,6 +887,7 @@ static inline void psched_ratecfg_getrate(struct tc_ratespec *res,
 	res->rate = min_t(u64, r->rate_bytes_ps, ~0U);
 
 	res->overhead = r->overhead;
+	res->mpu = r->mpu;
 	res->linklayer = (r->linklayer & TC_LINKLAYER_MASK);
 }
 
diff --git a/init/Kconfig b/init/Kconfig
index 00b66fb286e1..2596abc5dace 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1633,6 +1633,16 @@ config ADVISE_SYSCALLS
 	  applications use these syscalls, you can disable this option to save
 	  space.
 
+config BPF_UNPRIV_DEFAULT_OFF
+	bool "Disable unprivileged BPF by default"
+	depends on BPF_SYSCALL
+	help
+	  Disables unprivileged BPF by default by setting the corresponding
+	  /proc/sys/kernel/unprivileged_bpf_disabled knob to 2. An admin can
+	  still reenable it by setting it to 0 later on, or permanently
+	  disable it by setting it to 1 (from which no other transition to
+	  0 is possible anymore).
+
 config USERFAULTFD
 	bool "Enable userfaultfd() system call"
 	select ANON_INODES
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e10314223cbf..e30ad1be6841 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -22,7 +22,8 @@
 
 DEFINE_PER_CPU(int, bpf_prog_active);
 
-int sysctl_unprivileged_bpf_disabled __read_mostly;
+int sysctl_unprivileged_bpf_disabled __read_mostly =
+	IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;
 
 static LIST_HEAD(bpf_map_types);
 
diff --git a/kernel/cgroup.c b/kernel/cgroup.c
index b750eb60fe79..03781977e4fd 100644
--- a/kernel/cgroup.c
+++ b/kernel/cgroup.c
@@ -1854,6 +1854,7 @@ static int cgroup_remount(struct kernfs_root *kf_root, int *flags, char *data)
 {
 	int ret = 0;
 	struct cgroup_root *root = cgroup_root_from_kf(kf_root);
+	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
 	struct cgroup_sb_opts opts;
 	u16 added_mask, removed_mask;
 
@@ -1873,6 +1874,13 @@ static int cgroup_remount(struct kernfs_root *kf_root, int *flags, char *data)
 		pr_warn("option changes via remount are deprecated (pid=%d comm=%s)\n",
 			task_tgid_nr(current), current->comm);
 
+	/* See cgroup_mount release_agent handling */
+	if (opts.release_agent &&
+	    ((ns->user_ns != &init_user_ns) || !capable(CAP_SYS_ADMIN))) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	added_mask = opts.subsys_mask & ~root->subsys_mask;
 	removed_mask = root->subsys_mask & ~opts.subsys_mask;
 
@@ -2248,6 +2256,16 @@ static struct dentry *cgroup_mount(struct file_system_type *fs_type,
 		goto out_unlock;
 	}
 
+	/*
+	 * Release agent gets called with all capabilities,
+	 * require capabilities to set release agent.
+	 */
+	if (opts.release_agent &&
+	    ((ns->user_ns != &init_user_ns) || !capable(CAP_SYS_ADMIN))) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	root = kzalloc(sizeof(*root), GFP_KERNEL);
 	if (!root) {
 		ret = -ENOMEM;
@@ -3026,6 +3044,14 @@ static ssize_t cgroup_release_agent_write(struct kernfs_open_file *of,
 
 	BUILD_BUG_ON(sizeof(cgrp->root->release_agent_path) < PATH_MAX);
 
+	/*
+	 * Release agent gets called with all capabilities,
+	 * require capabilities to set release agent.
+	 */
+	if ((of->file->f_cred->user_ns != &init_user_ns) ||
+	    !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	cgrp = cgroup_kn_lock_live(of->kn, false);
 	if (!cgrp)
 		return -ENODEV;
diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index 1896386e16bb..78e354b1c593 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -38,23 +38,19 @@ ssize_t pm_show_wakelocks(char *buf, bool show_active)
 {
 	struct rb_node *node;
 	struct wakelock *wl;
-	char *str = buf;
-	char *end = buf + PAGE_SIZE;
+	int len = 0;
 
 	mutex_lock(&wakelocks_lock);
 
 	for (node = rb_first(&wakelocks_tree); node; node = rb_next(node)) {
 		wl = rb_entry(node, struct wakelock, node);
 		if (wl->ws.active == show_active)
-			str += scnprintf(str, end - str, "%s ", wl->name);
+			len += sysfs_emit_at(buf, len, "%s ", wl->name);
 	}
-	if (str > buf)
-		str--;
-
-	str += scnprintf(str, end - str, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 
 	mutex_unlock(&wakelocks_lock);
-	return (str - buf);
+	return len;
 }
 
 #if CONFIG_PM_WAKELOCKS_LIMIT > 0
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 513e6da318c4..78b445562b81 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -221,6 +221,28 @@ static int sysrq_sysctl_handler(struct ctl_table *table, int write,
 
 #endif
 
+#ifdef CONFIG_BPF_SYSCALL
+static int bpf_unpriv_handler(struct ctl_table *table, int write,
+                             void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret, unpriv_enable = *(int *)table->data;
+	bool locked_state = unpriv_enable == 1;
+	struct ctl_table tmp = *table;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	tmp.data = &unpriv_enable;
+	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+	if (write && !ret) {
+		if (locked_state && unpriv_enable != 1)
+			return -EPERM;
+		*(int *)table->data = unpriv_enable;
+	}
+	return ret;
+}
+#endif
+
 static struct ctl_table kern_table[];
 static struct ctl_table vm_table[];
 static struct ctl_table fs_table[];
@@ -1202,10 +1224,9 @@ static struct ctl_table kern_table[] = {
 		.data		= &sysctl_unprivileged_bpf_disabled,
 		.maxlen		= sizeof(sysctl_unprivileged_bpf_disabled),
 		.mode		= 0644,
-		/* only handle a transition from default "0" to "1" */
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &one,
-		.extra2		= &one,
+		.proc_handler	= bpf_unpriv_handler,
+		.extra1		= &zero,
+		.extra2		= &two,
 	},
 #endif
 #if defined(CONFIG_TREE_RCU) || defined(CONFIG_PREEMPT_RCU)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index df5a3e8db827..b0975f35612c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -228,6 +228,10 @@ __setup("trace_clock=", set_trace_boot_clock);
 
 static int __init set_tracepoint_printk(char *str)
 {
+	/* Ignore the "tp_printk_stop_on_boot" param */
+	if (*str == '_')
+		return 0;
+
 	if ((strcmp(str, "=0") != 0 && strcmp(str, "=off") != 0))
 		tracepoint_printk = 1;
 	return 1;
diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index f8e26ab963ed..06406633d7cd 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -44,11 +44,10 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	/* Convert to seconds for btime */
 	do_div(delta, USEC_PER_SEC);
 	stats->ac_btime = get_seconds() - delta;
-	if (thread_group_leader(tsk)) {
+	if (tsk->flags & PF_EXITING)
 		stats->ac_exitcode = tsk->exit_code;
-		if (tsk->flags & PF_FORKNOEXEC)
-			stats->ac_flag |= AFORK;
-	}
+	if (thread_group_leader(tsk) && (tsk->flags & PF_FORKNOEXEC))
+		stats->ac_flag |= AFORK;
 	if (tsk->flags & PF_SUPERPRIV)
 		stats->ac_flag |= ASU;
 	if (tsk->flags & PF_DUMPCORE)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index bc5ff3a53d4a..e7addfcd302f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1091,7 +1091,7 @@ config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
 	select STACKTRACE
-	select FRAME_POINTER if !MIPS && !PPC && !ARM_UNWIND && !S390 && !MICROBLAZE && !ARC && !SCORE
+	select FRAME_POINTER if !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !SCORE
 	select KALLSYMS
 	select KALLSYMS_ALL
 
@@ -1670,7 +1670,7 @@ config FAULT_INJECTION_STACKTRACE_FILTER
 	depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
 	depends on !X86_64
 	select STACKTRACE
-	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND && !ARC && !SCORE
+	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !SCORE
 	help
 	  Provide stacktrace filter for fault-injection capabilities
 
@@ -1679,7 +1679,7 @@ config LATENCYTOP
 	depends on DEBUG_KERNEL
 	depends on STACKTRACE_SUPPORT
 	depends on PROC_FS
-	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND && !ARC
+	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC
 	select KALLSYMS
 	select KALLSYMS_ALL
 	select STACKTRACE
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 07d735b2eccf..e01bb1c51d87 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -370,6 +370,7 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
 		return 0;
 	pipe->nrbufs++;
 	buf->ops = &page_cache_pipe_buf_ops;
+	buf->flags = 0;
 	get_page(buf->page = page);
 	buf->offset = offset;
 	buf->len = bytes;
@@ -494,6 +495,7 @@ static size_t push_pipe(struct iov_iter *i, size_t size,
 			break;
 		pipe->nrbufs++;
 		pipe->bufs[idx].ops = &default_pipe_buf_ops;
+		pipe->bufs[idx].flags = 0;
 		pipe->bufs[idx].page = page;
 		pipe->bufs[idx].offset = 0;
 		if (left <= PAGE_SIZE) {
diff --git a/lib/rbtree.c b/lib/rbtree.c
index eb8a19fee110..53746be42903 100644
--- a/lib/rbtree.c
+++ b/lib/rbtree.c
@@ -95,10 +95,14 @@ __rb_rotate_set_parents(struct rb_node *old, struct rb_node *new,
 
 static __always_inline void
 __rb_insert(struct rb_node *node, struct rb_root *root,
+	    bool newleft, struct rb_node **leftmost,
 	    void (*augment_rotate)(struct rb_node *old, struct rb_node *new))
 {
 	struct rb_node *parent = rb_red_parent(node), *gparent, *tmp;
 
+	if (newleft)
+		*leftmost = node;
+
 	while (true) {
 		/*
 		 * Loop invariant: node is red
@@ -417,19 +421,38 @@ static const struct rb_augment_callbacks dummy_callbacks = {
 
 void rb_insert_color(struct rb_node *node, struct rb_root *root)
 {
-	__rb_insert(node, root, dummy_rotate);
+	__rb_insert(node, root, false, NULL, dummy_rotate);
 }
 EXPORT_SYMBOL(rb_insert_color);
 
 void rb_erase(struct rb_node *node, struct rb_root *root)
 {
 	struct rb_node *rebalance;
-	rebalance = __rb_erase_augmented(node, root, &dummy_callbacks);
+	rebalance = __rb_erase_augmented(node, root,
+					 NULL, &dummy_callbacks);
 	if (rebalance)
 		____rb_erase_color(rebalance, root, dummy_rotate);
 }
 EXPORT_SYMBOL(rb_erase);
 
+void rb_insert_color_cached(struct rb_node *node,
+			    struct rb_root_cached *root, bool leftmost)
+{
+	__rb_insert(node, &root->rb_root, leftmost,
+		    &root->rb_leftmost, dummy_rotate);
+}
+EXPORT_SYMBOL(rb_insert_color_cached);
+
+void rb_erase_cached(struct rb_node *node, struct rb_root_cached *root)
+{
+	struct rb_node *rebalance;
+	rebalance = __rb_erase_augmented(node, &root->rb_root,
+					 &root->rb_leftmost, &dummy_callbacks);
+	if (rebalance)
+		____rb_erase_color(rebalance, &root->rb_root, dummy_rotate);
+}
+EXPORT_SYMBOL(rb_erase_cached);
+
 /*
  * Augmented rbtree manipulation functions.
  *
@@ -438,9 +461,10 @@ EXPORT_SYMBOL(rb_erase);
  */
 
 void __rb_insert_augmented(struct rb_node *node, struct rb_root *root,
+			   bool newleft, struct rb_node **leftmost,
 	void (*augment_rotate)(struct rb_node *old, struct rb_node *new))
 {
-	__rb_insert(node, root, augment_rotate);
+	__rb_insert(node, root, newleft, leftmost, augment_rotate);
 }
 EXPORT_SYMBOL(__rb_insert_augmented);
 
@@ -485,7 +509,7 @@ struct rb_node *rb_next(const struct rb_node *node)
 	 * as we can.
 	 */
 	if (node->rb_right) {
-		node = node->rb_right; 
+		node = node->rb_right;
 		while (node->rb_left)
 			node=node->rb_left;
 		return (struct rb_node *)node;
@@ -517,7 +541,7 @@ struct rb_node *rb_prev(const struct rb_node *node)
 	 * as we can.
 	 */
 	if (node->rb_left) {
-		node = node->rb_left; 
+		node = node->rb_left;
 		while (node->rb_right)
 			node=node->rb_right;
 		return (struct rb_node *)node;
diff --git a/lib/timerqueue.c b/lib/timerqueue.c
index 782ae8ca2c06..4f99b5c3ac0e 100644
--- a/lib/timerqueue.c
+++ b/lib/timerqueue.c
@@ -38,9 +38,10 @@
  */
 bool timerqueue_add(struct timerqueue_head *head, struct timerqueue_node *node)
 {
-	struct rb_node **p = &head->head.rb_node;
+	struct rb_node **p = &head->rb_root.rb_root.rb_node;
 	struct rb_node *parent = NULL;
-	struct timerqueue_node  *ptr;
+	struct timerqueue_node *ptr;
+	bool leftmost = true;
 
 	/* Make sure we don't add nodes that are already added */
 	WARN_ON_ONCE(!RB_EMPTY_NODE(&node->node));
@@ -48,19 +49,17 @@ bool timerqueue_add(struct timerqueue_head *head, struct timerqueue_node *node)
 	while (*p) {
 		parent = *p;
 		ptr = rb_entry(parent, struct timerqueue_node, node);
-		if (node->expires.tv64 < ptr->expires.tv64)
+		if (node->expires.tv64 < ptr->expires.tv64) {
 			p = &(*p)->rb_left;
-		else
+		} else {
 			p = &(*p)->rb_right;
+			leftmost = false;
+		}
 	}
 	rb_link_node(&node->node, parent, p);
-	rb_insert_color(&node->node, &head->head);
+	rb_insert_color_cached(&node->node, &head->rb_root, leftmost);
 
-	if (!head->next || node->expires.tv64 < head->next->expires.tv64) {
-		head->next = node;
-		return true;
-	}
-	return false;
+	return leftmost;
 }
 EXPORT_SYMBOL_GPL(timerqueue_add);
 
@@ -76,16 +75,10 @@ bool timerqueue_del(struct timerqueue_head *head, struct timerqueue_node *node)
 {
 	WARN_ON_ONCE(RB_EMPTY_NODE(&node->node));
 
-	/* update next pointer */
-	if (head->next == node) {
-		struct rb_node *rbn = rb_next(&node->node);
-
-		head->next = rbn ?
-			rb_entry(rbn, struct timerqueue_node, node) : NULL;
-	}
-	rb_erase(&node->node, &head->head);
+	rb_erase_cached(&node->node, &head->rb_root);
 	RB_CLEAR_NODE(&node->node);
-	return head->next != NULL;
+
+	return !RB_EMPTY_ROOT(&head->rb_root.rb_root);
 }
 EXPORT_SYMBOL_GPL(timerqueue_del);
 
diff --git a/localversion-rt b/localversion-rt
index d68f944b6cad..62fe25bd6258 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt191
+-rt192
diff --git a/mm/gup.c b/mm/gup.c
index 301dd96ef176..0b80bf3878dc 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1567,22 +1567,15 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
 			break;
-		/*
-		 * The FAST_GUP case requires FOLL_WRITE even for pure reads,
-		 * because get_user_pages() may need to cause an early COW in
-		 * order to avoid confusing the normal COW routines. So only
-		 * targets that are already writable are safe to do by just
-		 * looking at the page tables.
-		 */
 		if (unlikely(pgd_huge(pgd))) {
-			if (!gup_huge_pgd(pgd, pgdp, addr, next, 1,
+			if (!gup_huge_pgd(pgd, pgdp, addr, next, write,
 					  pages, &nr))
 				break;
 		} else if (unlikely(is_hugepd(__hugepd(pgd_val(pgd))))) {
 			if (!gup_huge_pd(__hugepd(pgd_val(pgd)), addr,
-					 PGDIR_SHIFT, next, 1, pages, &nr))
+					 PGDIR_SHIFT, next, write, pages, &nr))
 				break;
-		} else if (!gup_pud_range(pgd, addr, next, 1, pages, &nr))
+		} else if (!gup_pud_range(pgd, addr, next, write, pages, &nr))
 			break;
 	} while (pgdp++, addr = next, addr != end);
 	local_irq_restore(flags);
@@ -1612,7 +1605,14 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	int nr, ret;
 
 	start &= PAGE_MASK;
-	nr = __get_user_pages_fast(start, nr_pages, write, pages);
+	/*
+	 * The FAST_GUP case requires FOLL_WRITE even for pure reads,
+	 * because get_user_pages() may need to cause an early COW in
+	 * order to avoid confusing the normal COW routines. So only
+	 * targets that are already writable are safe to do by just
+	 * looking at the page tables.
+	 */
+	nr = __get_user_pages_fast(start, nr_pages, 1, pages);
 	ret = nr;
 
 	if (nr < nr_pages) {
diff --git a/mm/memory.c b/mm/memory.c
index c2890dc104d9..2b2cc69ddcce 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3780,8 +3780,8 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-static int __follow_pte(struct mm_struct *mm, unsigned long address,
-		pte_t **ptepp, spinlock_t **ptlp)
+static int __follow_pte_pmd(struct mm_struct *mm, unsigned long address,
+		pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -3798,11 +3798,20 @@ static int __follow_pte(struct mm_struct *mm, unsigned long address,
 
 	pmd = pmd_offset(pud, address);
 	VM_BUG_ON(pmd_trans_huge(*pmd));
-	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
-		goto out;
 
-	/* We cannot handle huge page PFN maps. Luckily they don't exist. */
-	if (pmd_huge(*pmd))
+	if (pmd_huge(*pmd)) {
+		if (!pmdpp)
+			goto out;
+
+		*ptlp = pmd_lock(mm, pmd);
+		if (pmd_huge(*pmd)) {
+			*pmdpp = pmd;
+			return 0;
+		}
+		spin_unlock(*ptlp);
+	}
+
+	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
 		goto out;
 
 	ptep = pte_offset_map_lock(mm, pmd, address, ptlp);
@@ -3825,9 +3834,23 @@ static inline int follow_pte(struct mm_struct *mm, unsigned long address,
 
 	/* (void) is needed to make gcc happy */
 	(void) __cond_lock(*ptlp,
-			   !(res = __follow_pte(mm, address, ptepp, ptlp)));
+			   !(res = __follow_pte_pmd(mm, address, ptepp, NULL,
+					   ptlp)));
+	return res;
+}
+
+int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
+			     pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp)
+{
+	int res;
+
+	/* (void) is needed to make gcc happy */
+	(void) __cond_lock(*ptlp,
+			   !(res = __follow_pte_pmd(mm, address, ptepp, pmdpp,
+					   ptlp)));
 	return res;
 }
+EXPORT_SYMBOL(follow_pte_pmd);
 
 /**
  * follow_pfn - look up PFN at a user virtual address
diff --git a/mm/shmem.c b/mm/shmem.c
index 31b0c09fe6c6..51aa13f59622 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -436,7 +436,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 	struct shmem_inode_info *info;
 	struct page *page;
 	unsigned long batch = sc ? sc->nr_to_scan : 128;
-	int removed = 0, split = 0;
+	int split = 0;
 
 	if (list_empty(&sbinfo->shrinklist))
 		return SHRINK_STOP;
@@ -451,7 +451,6 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		/* inode is about to be evicted */
 		if (!inode) {
 			list_del_init(&info->shrinklist);
-			removed++;
 			goto next;
 		}
 
@@ -459,12 +458,12 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		if (round_up(inode->i_size, PAGE_SIZE) ==
 				round_up(inode->i_size, HPAGE_PMD_SIZE)) {
 			list_move(&info->shrinklist, &to_remove);
-			removed++;
 			goto next;
 		}
 
 		list_move(&info->shrinklist, &list);
 next:
+		sbinfo->shrinklist_len--;
 		if (!--batch)
 			break;
 	}
@@ -484,7 +483,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		inode = &info->vfs_inode;
 
 		if (nr_to_split && split >= nr_to_split)
-			goto leave;
+			goto move_back;
 
 		page = find_get_page(inode->i_mapping,
 				(inode->i_size & HPAGE_PMD_MASK) >> PAGE_SHIFT);
@@ -498,38 +497,44 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		}
 
 		/*
-		 * Leave the inode on the list if we failed to lock
-		 * the page at this time.
+		 * Move the inode on the list back to shrinklist if we failed
+		 * to lock the page at this time.
 		 *
 		 * Waiting for the lock may lead to deadlock in the
 		 * reclaim path.
 		 */
 		if (!trylock_page(page)) {
 			put_page(page);
-			goto leave;
+			goto move_back;
 		}
 
 		ret = split_huge_page(page);
 		unlock_page(page);
 		put_page(page);
 
-		/* If split failed leave the inode on the list */
+		/* If split failed move the inode on the list back to shrinklist */
 		if (ret)
-			goto leave;
+			goto move_back;
 
 		split++;
 drop:
 		list_del_init(&info->shrinklist);
-		removed++;
-leave:
+		goto put;
+move_back:
+		/*
+		 * Make sure the inode is either on the global list or deleted
+		 * from any local list before iput() since it could be deleted
+		 * in another thread once we put the inode (then the local list
+		 * is corrupted).
+		 */
+		spin_lock(&sbinfo->shrinklist_lock);
+		list_move(&info->shrinklist, &sbinfo->shrinklist);
+		sbinfo->shrinklist_len++;
+		spin_unlock(&sbinfo->shrinklist_lock);
+put:
 		iput(inode);
 	}
 
-	spin_lock(&sbinfo->shrinklist_lock);
-	list_splice_tail(&list, &sbinfo->shrinklist);
-	sbinfo->shrinklist_len -= removed;
-	spin_unlock(&sbinfo->shrinklist_lock);
-
 	return split;
 }
 
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index f4c8567e91b3..c4ef1be59cb1 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -80,6 +80,7 @@ static void ax25_kill_by_device(struct net_device *dev)
 {
 	ax25_dev *ax25_dev;
 	ax25_cb *s;
+	struct sock *sk;
 
 	if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL)
 		return;
@@ -88,13 +89,15 @@ static void ax25_kill_by_device(struct net_device *dev)
 again:
 	ax25_for_each(s, &ax25_list) {
 		if (s->ax25_dev == ax25_dev) {
+			sk = s->sk;
+			sock_hold(sk);
 			spin_unlock_bh(&ax25_list_lock);
-			lock_sock(s->sk);
+			lock_sock(sk);
 			s->ax25_dev = NULL;
-			release_sock(s->sk);
+			release_sock(sk);
 			ax25_disconnect(s, ENETUNREACH);
 			spin_lock_bh(&ax25_list_lock);
-
+			sock_put(sk);
 			/* The entry could have been deleted from the
 			 * list meanwhile and thus the next pointer is
 			 * no longer valid.  Play it safe and restart
diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
index 0bb150e68c53..e2e580c747f4 100644
--- a/net/bluetooth/cmtp/core.c
+++ b/net/bluetooth/cmtp/core.c
@@ -499,9 +499,7 @@ static int __init cmtp_init(void)
 {
 	BT_INFO("CMTP (CAPI Emulation) ver %s", VERSION);
 
-	cmtp_init_sockets();
-
-	return 0;
+	return cmtp_init_sockets();
 }
 
 static void __exit cmtp_exit(void)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b43f31203a43..40e6e5feb1e0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3148,6 +3148,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	return id;
 
 err_wqueue:
+	debugfs_remove_recursive(hdev->debugfs);
 	destroy_workqueue(hdev->workqueue);
 	destroy_workqueue(hdev->req_workqueue);
 err:
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f9484755a9ba..cff87c465bcb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4967,7 +4967,13 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		struct hci_ev_le_advertising_info *ev = ptr;
 		s8 rssi;
 
-		if (ev->length <= HCI_MAX_AD_LENGTH) {
+		if (ptr > (void *)skb_tail_pointer(skb) - sizeof(*ev)) {
+			bt_dev_err(hdev, "Malicious advertising data.");
+			break;
+		}
+
+		if (ev->length <= HCI_MAX_AD_LENGTH &&
+		    ev->data + ev->length <= skb_tail_pointer(skb)) {
 			rssi = ev->data[ev->length];
 			process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
 					   ev->bdaddr_type, NULL, 0, rssi,
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 7104d5e64abb..11d4d18012fe 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -724,6 +724,9 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 	if (nf_bridge->frag_max_size && nf_bridge->frag_max_size < mtu)
 		mtu = nf_bridge->frag_max_size;
 
+	nf_bridge_update_protocol(skb);
+	nf_bridge_push_encap_header(skb);
+
 	if (skb_is_gso(skb) || skb->len + mtu_reserved <= mtu) {
 		nf_bridge_info_free(skb);
 		return br_dev_queue_push_xmit(net, sk, skb);
@@ -741,8 +744,6 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 
 		IPCB(skb)->frag_max_size = nf_bridge->frag_max_size;
 
-		nf_bridge_update_protocol(skb);
-
 		data = this_cpu_ptr(&brnf_frag_data_storage);
 
 		data->vlan_tci = skb->vlan_tci;
@@ -765,8 +766,6 @@ static int br_nf_dev_queue_xmit(struct net *net, struct sock *sk, struct sk_buff
 
 		IP6CB(skb)->frag_max_size = nf_bridge->frag_max_size;
 
-		nf_bridge_update_protocol(skb);
-
 		data = this_cpu_ptr(&brnf_frag_data_storage);
 		data->encap_size = nf_bridge_encap_header_len(skb);
 		data->size = ETH_HLEN + data->encap_size;
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 369326715b9c..bfb507223468 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -761,21 +761,21 @@ static struct bcm_op *bcm_find_op(struct list_head *ops,
 static void bcm_remove_op(struct bcm_op *op)
 {
 	if (op->tsklet.func) {
-		while (test_bit(TASKLET_STATE_SCHED, &op->tsklet.state) ||
-		       test_bit(TASKLET_STATE_RUN, &op->tsklet.state) ||
-		       hrtimer_active(&op->timer)) {
-			hrtimer_cancel(&op->timer);
+		do {
 			tasklet_kill(&op->tsklet);
-		}
+			hrtimer_cancel(&op->timer);
+		} while (test_bit(TASKLET_STATE_SCHED, &op->tsklet.state) ||
+			 test_bit(TASKLET_STATE_RUN, &op->tsklet.state) ||
+			 hrtimer_active(&op->timer));
 	}
 
 	if (op->thrtsklet.func) {
-		while (test_bit(TASKLET_STATE_SCHED, &op->thrtsklet.state) ||
-		       test_bit(TASKLET_STATE_RUN, &op->thrtsklet.state) ||
-		       hrtimer_active(&op->thrtimer)) {
-			hrtimer_cancel(&op->thrtimer);
+		do {
 			tasklet_kill(&op->thrtsklet);
-		}
+			hrtimer_cancel(&op->thrtimer);
+		} while (test_bit(TASKLET_STATE_SCHED, &op->thrtsklet.state) ||
+			 test_bit(TASKLET_STATE_RUN, &op->thrtsklet.state) ||
+			 hrtimer_active(&op->thrtimer));
 	}
 
 	if ((op->frames) && (op->frames != &op->sframe))
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 6d7ff117f379..6655c06a325c 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -224,13 +224,17 @@ static void trace_napi_poll_hit(void *ignore, struct napi_struct *napi,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(new_stat, &hw_stats_list, list) {
+		struct net_device *dev;
+
 		/*
 		 * only add a note to our monitor buffer if:
 		 * 1) this is the dev we received on
 		 * 2) its after the last_rx delta
 		 * 3) our rx_dropped count has gone up
 		 */
-		if ((new_stat->dev == napi->dev)  &&
+		/* Paired with WRITE_ONCE() in dropmon_net_event() */
+		dev = READ_ONCE(new_stat->dev);
+		if ((dev == napi->dev)  &&
 		    (time_after(jiffies, new_stat->last_rx + dm_hw_check_delta)) &&
 		    (napi->dev->stats.rx_dropped != new_stat->last_drop_val)) {
 			trace_drop_common(NULL, NULL);
@@ -345,7 +349,10 @@ static int dropmon_net_event(struct notifier_block *ev_block,
 		mutex_lock(&trace_state_mutex);
 		list_for_each_entry_safe(new_stat, tmp, &hw_stats_list, list) {
 			if (new_stat->dev == dev) {
-				new_stat->dev = NULL;
+
+				/* Paired with READ_ONCE() in trace_napi_poll_hit() */
+				WRITE_ONCE(new_stat->dev, NULL);
+
 				if (trace_state == TRACE_OFF) {
 					list_del_rcu(&new_stat->list);
 					kfree_rcu(new_stat, rcu);
diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index 14d09345f00d..913b7c366cd4 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -208,12 +208,23 @@ static const struct file_operations softnet_seq_fops = {
 	.release = seq_release,
 };
 
-static void *ptype_get_idx(loff_t pos)
+static void *ptype_get_idx(struct seq_file *seq, loff_t pos)
 {
+	struct list_head *ptype_list = NULL;
 	struct packet_type *pt = NULL;
+	struct net_device *dev;
 	loff_t i = 0;
 	int t;
 
+	for_each_netdev_rcu(seq_file_net(seq), dev) {
+		ptype_list = &dev->ptype_all;
+		list_for_each_entry_rcu(pt, ptype_list, list) {
+			if (i == pos)
+				return pt;
+			++i;
+		}
+	}
+
 	list_for_each_entry_rcu(pt, &ptype_all, list) {
 		if (i == pos)
 			return pt;
@@ -234,22 +245,40 @@ static void *ptype_seq_start(struct seq_file *seq, loff_t *pos)
 	__acquires(RCU)
 {
 	rcu_read_lock();
-	return *pos ? ptype_get_idx(*pos - 1) : SEQ_START_TOKEN;
+	return *pos ? ptype_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 }
 
 static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
+	struct net_device *dev;
 	struct packet_type *pt;
 	struct list_head *nxt;
 	int hash;
 
 	++*pos;
 	if (v == SEQ_START_TOKEN)
-		return ptype_get_idx(0);
+		return ptype_get_idx(seq, 0);
 
 	pt = v;
 	nxt = pt->list.next;
+	if (pt->dev) {
+		if (nxt != &pt->dev->ptype_all)
+			goto found;
+
+		dev = pt->dev;
+		for_each_netdev_continue_rcu(seq_file_net(seq), dev) {
+			if (!list_empty(&dev->ptype_all)) {
+				nxt = dev->ptype_all.next;
+				goto found;
+			}
+		}
+
+		nxt = ptype_all.next;
+		goto ptype_all;
+	}
+
 	if (pt->type == htons(ETH_P_ALL)) {
+ptype_all:
 		if (nxt != &ptype_all)
 			goto found;
 		hash = 0;
@@ -278,7 +307,8 @@ static int ptype_seq_show(struct seq_file *seq, void *v)
 
 	if (v == SEQ_START_TOKEN)
 		seq_puts(seq, "Type Device      Function\n");
-	else if (pt->dev == NULL || dev_net(pt->dev) == seq_file_net(seq)) {
+	else if ((!pt->af_packet_net || net_eq(pt->af_packet_net, seq_file_net(seq))) &&
+		 (!pt->dev || net_eq(dev_net(pt->dev), seq_file_net(seq)))) {
 		if (pt->type == htons(ETH_P_ALL))
 			seq_puts(seq, "ALL ");
 		else
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 7630fa80db92..48854eae294f 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -132,8 +132,10 @@ static void ops_exit_list(const struct pernet_operations *ops,
 {
 	struct net *net;
 	if (ops->exit) {
-		list_for_each_entry(net, net_exit_list, exit_list)
+		list_for_each_entry(net, net_exit_list, exit_list) {
 			ops->exit(net);
+			cond_resched();
+		}
 	}
 	if (ops->exit_batch)
 		ops->exit_batch(net_exit_list);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 012143f313a8..d5cad076daf5 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2454,9 +2454,9 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh)
 {
 	struct net *net = sock_net(skb->sk);
 	const struct rtnl_link_ops *ops;
-	const struct rtnl_link_ops *m_ops = NULL;
+	const struct rtnl_link_ops *m_ops;
 	struct net_device *dev;
-	struct net_device *master_dev = NULL;
+	struct net_device *master_dev;
 	struct ifinfomsg *ifm;
 	char kind[MODULE_NAME_LEN];
 	char ifname[IFNAMSIZ];
@@ -2487,6 +2487,8 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh)
 			dev = NULL;
 	}
 
+	master_dev = NULL;
+	m_ops = NULL;
 	if (dev) {
 		master_dev = netdev_master_upper_dev_get(dev);
 		if (master_dev)
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 936371340dc3..c24a1945392a 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1474,7 +1474,7 @@ static int nl802154_send_key(struct sk_buff *msg, u32 cmd, u32 portid,
 
 	hdr = nl802154hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr)
-		return -1;
+		return -ENOBUFS;
 
 	if (nla_put_u32(msg, NL802154_ATTR_IFINDEX, dev->ifindex))
 		goto nla_put_failure;
@@ -1665,7 +1665,7 @@ static int nl802154_send_device(struct sk_buff *msg, u32 cmd, u32 portid,
 
 	hdr = nl802154hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr)
-		return -1;
+		return -ENOBUFS;
 
 	if (nla_put_u32(msg, NL802154_ATTR_IFINDEX, dev->ifindex))
 		goto nla_put_failure;
@@ -1843,7 +1843,7 @@ static int nl802154_send_devkey(struct sk_buff *msg, u32 cmd, u32 portid,
 
 	hdr = nl802154hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr)
-		return -1;
+		return -ENOBUFS;
 
 	if (nla_put_u32(msg, NL802154_ATTR_IFINDEX, dev->ifindex))
 		goto nla_put_failure;
@@ -2020,7 +2020,7 @@ static int nl802154_send_seclevel(struct sk_buff *msg, u32 cmd, u32 portid,
 
 	hdr = nl802154hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr)
-		return -1;
+		return -ENOBUFS;
 
 	if (nla_put_u32(msg, NL802154_ATTR_IFINDEX, dev->ifindex))
 		goto nla_put_failure;
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 553cda6f887a..b7dc20a65b64 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -534,16 +534,10 @@ int cipso_v4_doi_remove(u32 doi, struct netlbl_audit *audit_info)
 		ret_val = -ENOENT;
 		goto doi_remove_return;
 	}
-	if (!atomic_dec_and_test(&doi_def->refcount)) {
-		spin_unlock(&cipso_v4_doi_list_lock);
-		ret_val = -EBUSY;
-		goto doi_remove_return;
-	}
 	list_del_rcu(&doi_def->list);
 	spin_unlock(&cipso_v4_doi_list_lock);
 
-	cipso_v4_cache_invalidate();
-	call_rcu(&doi_def->rcu, cipso_v4_doi_free_rcu);
+	cipso_v4_doi_putdef(doi_def);
 	ret_val = 0;
 
 doi_remove_return:
@@ -600,9 +594,6 @@ void cipso_v4_doi_putdef(struct cipso_v4_doi *doi_def)
 
 	if (!atomic_dec_and_test(&doi_def->refcount))
 		return;
-	spin_lock(&cipso_v4_doi_list_lock);
-	list_del_rcu(&doi_def->list);
-	spin_unlock(&cipso_v4_doi_list_lock);
 
 	cipso_v4_cache_invalidate();
 	call_rcu(&doi_def->rcu, cipso_v4_doi_free_rcu);
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 589fd0904e0d..bd53136c2826 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -159,12 +159,19 @@ int ip_build_and_send_pkt(struct sk_buff *skb, const struct sock *sk,
 	iph->daddr    = (opt && opt->opt.srr ? opt->opt.faddr : daddr);
 	iph->saddr    = saddr;
 	iph->protocol = sk->sk_protocol;
-	if (ip_dont_fragment(sk, &rt->dst)) {
+	/* Do not bother generating IPID for small packets (eg SYNACK) */
+	if (skb->len <= IPV4_MIN_MTU || ip_dont_fragment(sk, &rt->dst)) {
 		iph->frag_off = htons(IP_DF);
 		iph->id = 0;
 	} else {
 		iph->frag_off = 0;
-		__ip_select_ident(net, iph, 1);
+		/* TCP packets here are SYNACK with fat IPv4/TCP options.
+		 * Avoid using the hashed IP ident generator.
+		 */
+		if (sk->sk_protocol == IPPROTO_TCP)
+			iph->id = (__force __be16)prandom_u32();
+		else
+			__ip_select_ident(net, iph, 1);
 	}
 
 	if (opt && opt->opt.optlen) {
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 354926e61f06..58c0ab8894c7 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -242,7 +242,9 @@ static int __net_init ipmr_rules_init(struct net *net)
 	return 0;
 
 err2:
+	rtnl_lock();
 	ipmr_free_table(mrt);
+	rtnl_unlock();
 err1:
 	fib_rules_unregister(ops);
 	return err;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index af75c0a8238e..88ad1b6b3802 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -706,6 +706,7 @@ static int raw_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	int ret = -EINVAL;
 	int chk_addr_ret;
 
+	lock_sock(sk);
 	if (sk->sk_state != TCP_CLOSE || addr_len < sizeof(struct sockaddr_in))
 		goto out;
 	chk_addr_ret = inet_addr_type(sock_net(sk), addr->sin_addr.s_addr);
@@ -718,7 +719,9 @@ static int raw_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 		inet->inet_saddr = 0;  /* Use device */
 	sk_dst_reset(sk);
 	ret = 0;
-out:	return ret;
+out:
+	release_sock(sk);
+	return ret;
 }
 
 /*
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 1805413cd225..0f405045dcd8 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -16,6 +16,7 @@
 #include <net/xfrm.h>
 #include <net/ip.h>
 #include <net/l3mdev.h>
+#include <net/inet_ecn.h>
 
 static struct xfrm_policy_afinfo xfrm4_policy_afinfo;
 
@@ -123,7 +124,7 @@ _decode_session4(struct sk_buff *skb, struct flowi *fl, int reverse)
 	fl4->flowi4_proto = iph->protocol;
 	fl4->daddr = reverse ? iph->saddr : iph->daddr;
 	fl4->saddr = reverse ? iph->daddr : iph->saddr;
-	fl4->flowi4_tos = iph->tos;
+	fl4->flowi4_tos = iph->tos & ~INET_ECN_MASK;
 
 	if (!ip_is_fragment(iph)) {
 		switch (iph->protocol) {
diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index b206415bbde7..7628963ddacc 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -97,6 +97,9 @@ struct calipso_map_cache_entry {
 
 static struct calipso_map_cache_bkt *calipso_cache;
 
+static void calipso_cache_invalidate(void);
+static void calipso_doi_putdef(struct calipso_doi *doi_def);
+
 /* Label Mapping Cache Functions
  */
 
@@ -458,15 +461,10 @@ static int calipso_doi_remove(u32 doi, struct netlbl_audit *audit_info)
 		ret_val = -ENOENT;
 		goto doi_remove_return;
 	}
-	if (!atomic_dec_and_test(&doi_def->refcount)) {
-		spin_unlock(&calipso_doi_list_lock);
-		ret_val = -EBUSY;
-		goto doi_remove_return;
-	}
 	list_del_rcu(&doi_def->list);
 	spin_unlock(&calipso_doi_list_lock);
 
-	call_rcu(&doi_def->rcu, calipso_doi_free_rcu);
+	calipso_doi_putdef(doi_def);
 	ret_val = 0;
 
 doi_remove_return:
@@ -522,10 +520,8 @@ static void calipso_doi_putdef(struct calipso_doi *doi_def)
 
 	if (!atomic_dec_and_test(&doi_def->refcount))
 		return;
-	spin_lock(&calipso_doi_list_lock);
-	list_del_rcu(&doi_def->list);
-	spin_unlock(&calipso_doi_list_lock);
 
+	calipso_cache_invalidate();
 	call_rcu(&doi_def->rcu, calipso_doi_free_rcu);
 }
 
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 4e18ce5b939a..322171a344c0 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1007,12 +1007,12 @@ int ip6_tnl_xmit_ctl(struct ip6_tnl *t,
 			ldev = dev_get_by_index_rcu(net, p->link);
 
 		if (unlikely(!ipv6_chk_addr(net, laddr, ldev, 0)))
-			pr_warn("%s xmit: Local address not yet configured!\n",
-				p->name);
+			pr_warn_ratelimited("%s xmit: Local address not yet configured!\n",
+					    p->name);
 		else if (!ipv6_addr_is_multicast(raddr) &&
 			 unlikely(ipv6_chk_addr(net, raddr, NULL, 0)))
-			pr_warn("%s xmit: Routing loop! Remote address found on this node!\n",
-				p->name);
+			pr_warn_ratelimited("%s xmit: Routing loop! Remote address found on this node!\n",
+					    p->name);
 		else
 			ret = 1;
 		rcu_read_unlock();
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index f38b22f54c09..3dce62ec37ed 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -251,7 +251,9 @@ static int __net_init ip6mr_rules_init(struct net *net)
 	return 0;
 
 err2:
+	rtnl_lock();
 	ip6mr_free_table(mrt);
+	rtnl_unlock();
 err1:
 	fib_rules_unregister(ops);
 	return err;
diff --git a/net/netfilter/nf_nat_proto_common.c b/net/netfilter/nf_nat_proto_common.c
index 7d7466dbf663..a4f709a3cbac 100644
--- a/net/netfilter/nf_nat_proto_common.c
+++ b/net/netfilter/nf_nat_proto_common.c
@@ -38,12 +38,12 @@ void nf_nat_l4proto_unique_tuple(const struct nf_nat_l3proto *l3proto,
 				 struct nf_conntrack_tuple *tuple,
 				 const struct nf_nat_range *range,
 				 enum nf_nat_manip_type maniptype,
-				 const struct nf_conn *ct,
-				 u16 *rover)
+				 const struct nf_conn *ct)
 {
-	unsigned int range_size, min, max, i;
+	unsigned int range_size, min, max, i, attempts;
 	__be16 *portptr;
-	u_int16_t off;
+	u16 off;
+	static const unsigned int max_attempts = 128;
 
 	if (maniptype == NF_NAT_MANIP_SRC)
 		portptr = &tuple->src.u.all;
@@ -84,17 +84,31 @@ void nf_nat_l4proto_unique_tuple(const struct nf_nat_l3proto *l3proto,
 	} else if (range->flags & NF_NAT_RANGE_PROTO_RANDOM_FULLY) {
 		off = prandom_u32();
 	} else {
-		off = *rover;
+		off = prandom_u32();
 	}
 
-	for (i = 0; ; ++off) {
+	attempts = range_size;
+	if (attempts > max_attempts)
+		attempts = max_attempts;
+
+	/* We are in softirq; doing a search of the entire range risks
+	 * soft lockup when all tuples are already used.
+	 *
+	 * If we can't find any free port from first offset, pick a new
+	 * one and try again, with ever smaller search window.
+	 */
+another_round:
+	for (i = 0; i < attempts; i++, off++) {
 		*portptr = htons(min + off % range_size);
-		if (++i != range_size && nf_nat_used_tuple(tuple, ct))
-			continue;
-		if (!(range->flags & NF_NAT_RANGE_PROTO_RANDOM_ALL))
-			*rover = off;
-		return;
+		if (!nf_nat_used_tuple(tuple, ct))
+			return;
 	}
+
+	if (attempts >= range_size || attempts < 16)
+		return;
+	attempts /= 2;
+	off = prandom_u32();
+	goto another_round;
 }
 EXPORT_SYMBOL_GPL(nf_nat_l4proto_unique_tuple);
 
diff --git a/net/netfilter/nf_nat_proto_dccp.c b/net/netfilter/nf_nat_proto_dccp.c
index 15c47b246d0d..e7d27c083393 100644
--- a/net/netfilter/nf_nat_proto_dccp.c
+++ b/net/netfilter/nf_nat_proto_dccp.c
@@ -20,8 +20,6 @@
 #include <net/netfilter/nf_nat_l3proto.h>
 #include <net/netfilter/nf_nat_l4proto.h>
 
-static u_int16_t dccp_port_rover;
-
 static void
 dccp_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		  struct nf_conntrack_tuple *tuple,
@@ -29,8 +27,7 @@ dccp_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		  enum nf_nat_manip_type maniptype,
 		  const struct nf_conn *ct)
 {
-	nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct,
-				    &dccp_port_rover);
+	nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct);
 }
 
 static bool
diff --git a/net/netfilter/nf_nat_proto_sctp.c b/net/netfilter/nf_nat_proto_sctp.c
index cbc7ade1487b..b839373716e8 100644
--- a/net/netfilter/nf_nat_proto_sctp.c
+++ b/net/netfilter/nf_nat_proto_sctp.c
@@ -14,8 +14,6 @@
 
 #include <net/netfilter/nf_nat_l4proto.h>
 
-static u_int16_t nf_sctp_port_rover;
-
 static void
 sctp_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		  struct nf_conntrack_tuple *tuple,
@@ -23,8 +21,7 @@ sctp_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		  enum nf_nat_manip_type maniptype,
 		  const struct nf_conn *ct)
 {
-	nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct,
-				    &nf_sctp_port_rover);
+	nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct);
 }
 
 static bool
diff --git a/net/netfilter/nf_nat_proto_tcp.c b/net/netfilter/nf_nat_proto_tcp.c
index 4f8820fc5148..882e79c6df73 100644
--- a/net/netfilter/nf_nat_proto_tcp.c
+++ b/net/netfilter/nf_nat_proto_tcp.c
@@ -18,8 +18,6 @@
 #include <net/netfilter/nf_nat_l4proto.h>
 #include <net/netfilter/nf_nat_core.h>
 
-static u16 tcp_port_rover;
-
 static void
 tcp_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		 struct nf_conntrack_tuple *tuple,
@@ -27,8 +25,7 @@ tcp_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		 enum nf_nat_manip_type maniptype,
 		 const struct nf_conn *ct)
 {
-	nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct,
-				    &tcp_port_rover);
+	nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct);
 }
 
 static bool
diff --git a/net/netfilter/nf_nat_proto_udp.c b/net/netfilter/nf_nat_proto_udp.c
index b1e627227b6e..ed91bdd8857c 100644
--- a/net/netfilter/nf_nat_proto_udp.c
+++ b/net/netfilter/nf_nat_proto_udp.c
@@ -17,8 +17,6 @@
 #include <net/netfilter/nf_nat_l3proto.h>
 #include <net/netfilter/nf_nat_l4proto.h>
 
-static u16 udp_port_rover;
-
 static void
 udp_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		 struct nf_conntrack_tuple *tuple,
@@ -26,8 +24,7 @@ udp_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		 enum nf_nat_manip_type maniptype,
 		 const struct nf_conn *ct)
 {
-	nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct,
-				    &udp_port_rover);
+	nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct);
 }
 
 static bool
diff --git a/net/netfilter/nf_nat_proto_udplite.c b/net/netfilter/nf_nat_proto_udplite.c
index 58340c97bd83..8be265378de9 100644
--- a/net/netfilter/nf_nat_proto_udplite.c
+++ b/net/netfilter/nf_nat_proto_udplite.c
@@ -17,8 +17,6 @@
 #include <net/netfilter/nf_nat_l3proto.h>
 #include <net/netfilter/nf_nat_l4proto.h>
 
-static u16 udplite_port_rover;
-
 static void
 udplite_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		     struct nf_conntrack_tuple *tuple,
@@ -26,8 +24,7 @@ udplite_unique_tuple(const struct nf_nat_l3proto *l3proto,
 		     enum nf_nat_manip_type maniptype,
 		     const struct nf_conn *ct)
 {
-	nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct,
-				    &udplite_port_rover);
+	nf_nat_l4proto_unique_tuple(l3proto, tuple, range, maniptype, ct);
 }
 
 static bool
diff --git a/net/netlabel/netlabel_cipso_v4.c b/net/netlabel/netlabel_cipso_v4.c
index 422fac2a4a3c..9a256d0fb957 100644
--- a/net/netlabel/netlabel_cipso_v4.c
+++ b/net/netlabel/netlabel_cipso_v4.c
@@ -587,6 +587,7 @@ static int netlbl_cipsov4_list(struct sk_buff *skb, struct genl_info *info)
 
 		break;
 	}
+	cipso_v4_doi_putdef(doi_def);
 	rcu_read_unlock();
 
 	genlmsg_end(ans_skb, data);
@@ -595,12 +596,14 @@ static int netlbl_cipsov4_list(struct sk_buff *skb, struct genl_info *info)
 list_retry:
 	/* XXX - this limit is a guesstimate */
 	if (nlsze_mult < 4) {
+		cipso_v4_doi_putdef(doi_def);
 		rcu_read_unlock();
 		kfree_skb(ans_skb);
 		nlsze_mult *= 2;
 		goto list_start;
 	}
 list_failure_lock:
+	cipso_v4_doi_putdef(doi_def);
 	rcu_read_unlock();
 list_failure:
 	kfree_skb(ans_skb);
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 92c6fbfd51f7..bc59b2b5f983 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -796,6 +796,11 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	lock_sock(sk);
 
+	if (!llcp_sock->local) {
+		release_sock(sk);
+		return -ENODEV;
+	}
+
 	if (sk->sk_type == SOCK_DGRAM) {
 		DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr,
 				 msg->msg_name);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 4e00da5b2045..4256ddf805a2 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1706,6 +1706,7 @@ static int fanout_add(struct sock *sk, u16 id, u16 type_flags)
 		match->prot_hook.dev = po->prot_hook.dev;
 		match->prot_hook.func = packet_rcv_fanout;
 		match->prot_hook.af_packet_priv = match;
+		match->prot_hook.af_packet_net = read_pnet(&match->net);
 		match->prot_hook.id_match = match_fanout_group;
 		list_add(&match->list, &fanout_list);
 	}
@@ -1719,7 +1720,10 @@ static int fanout_add(struct sock *sk, u16 id, u16 type_flags)
 		err = -ENOSPC;
 		if (atomic_read(&match->sk_ref) < PACKET_FANOUT_MAX) {
 			__dev_remove_pack(&po->prot_hook);
-			po->fanout = match;
+
+			/* Paired with packet_setsockopt(PACKET_FANOUT_DATA) */
+			WRITE_ONCE(po->fanout, match);
+
 			po->rollover = rollover;
 			rollover = NULL;
 			atomic_inc(&match->sk_ref);
@@ -3311,6 +3315,7 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
 		po->prot_hook.func = packet_rcv_spkt;
 
 	po->prot_hook.af_packet_priv = sk;
+	po->prot_hook.af_packet_net = sock_net(sk);
 
 	if (proto) {
 		po->prot_hook.type = proto;
@@ -3894,7 +3899,8 @@ packet_setsockopt(struct socket *sock, int level, int optname, char __user *optv
 	}
 	case PACKET_FANOUT_DATA:
 	{
-		if (!po->fanout)
+		/* Paired with the WRITE_ONCE() in fanout_add() */
+		if (!READ_ONCE(po->fanout))
 			return -EINVAL;
 
 		return fanout_set_data(po, optval, optlen);
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 70342d37c89b..251a94f9c67f 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1008,6 +1008,7 @@ void psched_ratecfg_precompute(struct psched_ratecfg *r,
 {
 	memset(r, 0, sizeof(*r));
 	r->overhead = conf->overhead;
+	r->mpu = conf->mpu;
 	r->rate_bytes_ps = max_t(u64, conf->rate, rate64);
 	r->linklayer = (conf->linklayer & TC_LINKLAYER_MASK);
 	r->mult = 1;
diff --git a/net/tipc/link.c b/net/tipc/link.c
index 6fc2fa75503d..2c1350e811e2 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1441,12 +1441,15 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 	u16 peers_tol = msg_link_tolerance(hdr);
 	u16 peers_prio = msg_linkprio(hdr);
 	u16 rcv_nxt = l->rcv_nxt;
-	u16 dlen = msg_data_sz(hdr);
+	u32 dlen = msg_data_sz(hdr);
 	int mtyp = msg_type(hdr);
 	void *data;
 	char *if_name;
 	int rc = 0;
 
+	if (dlen > U16_MAX)
+		goto exit;
+
 	if (tipc_link_is_blocked(l) || !xmitq)
 		goto exit;
 
diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index 0fcfb3916dcf..e1f4538b1653 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -457,6 +457,8 @@ void tipc_mon_rcv(struct net *net, void *data, u16 dlen, u32 addr,
 	state->probing = false;
 
 	/* Sanity check received domain record */
+	if (new_member_cnt > MAX_MON_DOMAIN)
+		return;
 	if (dlen < dom_rec_len(arrv_dom, 0))
 		return;
 	if (dlen != dom_rec_len(arrv_dom, new_member_cnt))
diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index 7ebcaff8c1c4..963f607b3499 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -288,7 +288,7 @@ static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
 			return true;
 		}
 	} else {
-		pr_warn("Unrecognized name table message received\n");
+		pr_warn_ratelimited("Unknown name table message received\n");
 	}
 	return false;
 }
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 8bbe1b8e4ff7..4d283e26d816 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -197,8 +197,11 @@ void wait_for_unix_gc(void)
 {
 	/* If number of inflight sockets is insane,
 	 * force a garbage collect right now.
+	 * Paired with the WRITE_ONCE() in unix_inflight(),
+	 * unix_notinflight() and gc_in_progress().
 	 */
-	if (unix_tot_inflight > UNIX_INFLIGHT_TRIGGER_GC && !gc_in_progress)
+	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
+	    !READ_ONCE(gc_in_progress))
 		unix_gc();
 	wait_event(unix_gc_wait, gc_in_progress == false);
 }
@@ -218,7 +221,9 @@ void unix_gc(void)
 	if (gc_in_progress)
 		goto out;
 
-	gc_in_progress = true;
+	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
+	WRITE_ONCE(gc_in_progress, true);
+
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
 	 * which don't have any external reference.
@@ -304,7 +309,10 @@ void unix_gc(void)
 
 	/* All candidates should have been detached by now. */
 	BUG_ON(!list_empty(&gc_candidates));
-	gc_in_progress = false;
+
+	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
+	WRITE_ONCE(gc_in_progress, false);
+
 	wake_up(&unix_gc_wait);
 
  out:
diff --git a/net/unix/scm.c b/net/unix/scm.c
index df8f636ab1d8..bf1a8fa8c4f1 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -56,7 +56,8 @@ void unix_inflight(struct user_struct *user, struct file *fp)
 		} else {
 			BUG_ON(list_empty(&u->link));
 		}
-		unix_tot_inflight++;
+		/* Paired with READ_ONCE() in wait_for_unix_gc() */
+		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + 1);
 	}
 	user->unix_inflight++;
 	spin_unlock(&unix_gc_lock);
@@ -76,7 +77,8 @@ void unix_notinflight(struct user_struct *user, struct file *fp)
 
 		if (atomic_long_dec_and_test(&u->inflight))
 			list_del_init(&u->link);
-		unix_tot_inflight--;
+		/* Paired with READ_ONCE() in wait_for_unix_gc() */
+		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - 1);
 	}
 	user->unix_inflight--;
 	spin_unlock(&unix_gc_lock);
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 95470d628d34..46ff984da6f4 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -279,7 +279,8 @@ EXPORT_SYMBOL_GPL(vsock_insert_connected);
 void vsock_remove_bound(struct vsock_sock *vsk)
 {
 	spin_lock_bh(&vsock_table_lock);
-	__vsock_remove_bound(vsk);
+	if (__vsock_in_bound_table(vsk))
+		__vsock_remove_bound(vsk);
 	spin_unlock_bh(&vsock_table_lock);
 }
 EXPORT_SYMBOL_GPL(vsock_remove_bound);
@@ -287,7 +288,8 @@ EXPORT_SYMBOL_GPL(vsock_remove_bound);
 void vsock_remove_connected(struct vsock_sock *vsk)
 {
 	spin_lock_bh(&vsock_table_lock);
-	__vsock_remove_connected(vsk);
+	if (__vsock_in_connected_table(vsk))
+		__vsock_remove_connected(vsk);
 	spin_unlock_bh(&vsock_table_lock);
 }
 EXPORT_SYMBOL_GPL(vsock_remove_connected);
@@ -323,35 +325,10 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 }
 EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
 
-static bool vsock_in_bound_table(struct vsock_sock *vsk)
-{
-	bool ret;
-
-	spin_lock_bh(&vsock_table_lock);
-	ret = __vsock_in_bound_table(vsk);
-	spin_unlock_bh(&vsock_table_lock);
-
-	return ret;
-}
-
-static bool vsock_in_connected_table(struct vsock_sock *vsk)
-{
-	bool ret;
-
-	spin_lock_bh(&vsock_table_lock);
-	ret = __vsock_in_connected_table(vsk);
-	spin_unlock_bh(&vsock_table_lock);
-
-	return ret;
-}
-
 void vsock_remove_sock(struct vsock_sock *vsk)
 {
-	if (vsock_in_bound_table(vsk))
-		vsock_remove_bound(vsk);
-
-	if (vsock_in_connected_table(vsk))
-		vsock_remove_connected(vsk);
+	vsock_remove_bound(vsk);
+	vsock_remove_connected(vsk);
 }
 EXPORT_SYMBOL_GPL(vsock_remove_sock);
 
@@ -482,8 +459,7 @@ static void vsock_pending_work(struct work_struct *work)
 	 * incoming packets can't find this socket, and to reduce the reference
 	 * count.
 	 */
-	if (vsock_in_connected_table(vsk))
-		vsock_remove_connected(vsk);
+	vsock_remove_connected(vsk);
 
 	sk->sk_state = SS_FREE;
 
@@ -1244,6 +1220,7 @@ static int vsock_stream_connect(struct socket *sock, struct sockaddr *addr,
 			sk->sk_state = SS_UNCONNECTED;
 			sock->state = SS_UNCONNECTED;
 			vsock_transport_cancel_pkt(vsk);
+			vsock_remove_connected(vsk);
 			goto out_wait;
 		} else if (timeout == 0) {
 			err = -ETIMEDOUT;
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 1532038f6005..e823bf6a413c 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -71,5 +71,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, sign-compare)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-zero-length)
 KBUILD_CFLAGS += $(call cc-disable-warning, uninitialized)
 KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
+KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
 endif
 endif
diff --git a/scripts/dtc/dtx_diff b/scripts/dtc/dtx_diff
index ec47f95991a3..971e74f408a7 100755
--- a/scripts/dtc/dtx_diff
+++ b/scripts/dtc/dtx_diff
@@ -56,12 +56,8 @@ Otherwise DTx is treated as a dts source file (aka .dts).
    or '/include/' to be processed.
 
    If DTx_1 and DTx_2 are in different architectures, then this script
-   may not work since \${ARCH} is part of the include path.  Two possible
-   workarounds:
-
-      `basename $0` \\
-          <(ARCH=arch_of_dtx_1 `basename $0` DTx_1) \\
-          <(ARCH=arch_of_dtx_2 `basename $0` DTx_2)
+   may not work since \${ARCH} is part of the include path.  The following
+   workaround can be used:
 
       `basename $0` ARCH=arch_of_dtx_1 DTx_1 >tmp_dtx_1.dts
       `basename $0` ARCH=arch_of_dtx_2 DTx_2 >tmp_dtx_2.dts
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 853a7d2333b3..51d2fef7cd67 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -477,11 +477,11 @@ int __init ima_fs_init(void)
 
 	return 0;
 out:
+	securityfs_remove(ima_policy);
 	securityfs_remove(violations);
 	securityfs_remove(runtime_measurements_count);
 	securityfs_remove(ascii_runtime_measurements);
 	securityfs_remove(binary_runtime_measurements);
 	securityfs_remove(ima_dir);
-	securityfs_remove(ima_policy);
 	return -1;
 }
diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 90987d15b6fe..6c415667ba67 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -39,6 +39,8 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
 		return;
 
 	ab = audit_log_start(current->audit_context, GFP_KERNEL, audit_msgno);
+	if (!ab)
+		return;
 	audit_log_format(ab, "pid=%d uid=%u auid=%u ses=%u",
 			 task_pid_nr(current),
 			 from_kuid(&init_user_ns, current_cred()->uid),
diff --git a/sound/core/jack.c b/sound/core/jack.c
index 5ddf81f091fa..36cfe1c54109 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -68,10 +68,13 @@ static int snd_jack_dev_free(struct snd_device *device)
 	struct snd_card *card = device->card;
 	struct snd_jack_kctl *jack_kctl, *tmp_jack_kctl;
 
+	down_write(&card->controls_rwsem);
 	list_for_each_entry_safe(jack_kctl, tmp_jack_kctl, &jack->kctl_list, list) {
 		list_del_init(&jack_kctl->list);
 		snd_ctl_remove(card, jack_kctl->kctl);
 	}
+	up_write(&card->controls_rwsem);
+
 	if (jack->private_free)
 		jack->private_free(jack);
 
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 0ce3f42721c4..440c16e0d071 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2122,7 +2122,7 @@ static int snd_pcm_oss_set_trigger(struct snd_pcm_oss_file *pcm_oss_file, int tr
 	int err, cmd;
 
 #ifdef OSS_DEBUG
-	pcm_dbg(substream->pcm, "pcm_oss: trigger = 0x%x\n", trigger);
+	pr_debug("pcm_oss: trigger = 0x%x\n", trigger);
 #endif
 	
 	psubstream = pcm_oss_file->streams[SNDRV_PCM_STREAM_PLAYBACK];
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index cdff5f976480..6ae28dcd7994 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -857,7 +857,11 @@ EXPORT_SYMBOL(snd_pcm_new_internal);
 static void free_chmap(struct snd_pcm_str *pstr)
 {
 	if (pstr->chmap_kctl) {
-		snd_ctl_remove(pstr->pcm->card, pstr->chmap_kctl);
+		struct snd_card *card = pstr->pcm->card;
+
+		down_write(&card->controls_rwsem);
+		snd_ctl_remove(card, pstr->chmap_kctl);
+		up_write(&card->controls_rwsem);
 		pstr->chmap_kctl = NULL;
 	}
 }
diff --git a/sound/core/seq/seq_queue.c b/sound/core/seq/seq_queue.c
index ea1aa0796276..b923059a2227 100644
--- a/sound/core/seq/seq_queue.c
+++ b/sound/core/seq/seq_queue.c
@@ -257,12 +257,15 @@ struct snd_seq_queue *snd_seq_queue_find_name(char *name)
 
 /* -------------------------------------------------------- */
 
+#define MAX_CELL_PROCESSES_IN_QUEUE	1000
+
 void snd_seq_check_queue(struct snd_seq_queue *q, int atomic, int hop)
 {
 	unsigned long flags;
 	struct snd_seq_event_cell *cell;
 	snd_seq_tick_time_t cur_tick;
 	snd_seq_real_time_t cur_time;
+	int processed = 0;
 
 	if (q == NULL)
 		return;
@@ -285,6 +288,8 @@ void snd_seq_check_queue(struct snd_seq_queue *q, int atomic, int hop)
 		if (!cell)
 			break;
 		snd_seq_dispatch_event(cell, atomic, hop);
+		if (++processed >= MAX_CELL_PROCESSES_IN_QUEUE)
+			goto out; /* the rest processed at the next batch */
 	}
 
 	/* Process time queue... */
@@ -294,14 +299,19 @@ void snd_seq_check_queue(struct snd_seq_queue *q, int atomic, int hop)
 		if (!cell)
 			break;
 		snd_seq_dispatch_event(cell, atomic, hop);
+		if (++processed >= MAX_CELL_PROCESSES_IN_QUEUE)
+			goto out; /* the rest processed at the next batch */
 	}
 
+ out:
 	/* free lock */
 	spin_lock_irqsave(&q->check_lock, flags);
 	if (q->check_again) {
 		q->check_again = 0;
-		spin_unlock_irqrestore(&q->check_lock, flags);
-		goto __again;
+		if (processed < MAX_CELL_PROCESSES_IN_QUEUE) {
+			spin_unlock_irqrestore(&q->check_lock, flags);
+			goto __again;
+		}
 	}
 	q->check_blocked = 0;
 	spin_unlock_irqrestore(&q->check_lock, flags);
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 4e67614f15f8..8976da3e1e28 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1608,8 +1608,11 @@ void snd_hda_ctls_clear(struct hda_codec *codec)
 {
 	int i;
 	struct hda_nid_item *items = codec->mixers.list;
+
+	down_write(&codec->card->controls_rwsem);
 	for (i = 0; i < codec->mixers.used; i++)
 		snd_ctl_remove(codec->card, items[i].kctl);
+	up_write(&codec->card->controls_rwsem);
 	snd_array_free(&codec->mixers);
 	snd_array_free(&codec->nids);
 }
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 16a692fc7f64..74ce577de7df 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1424,6 +1424,7 @@ static struct snd_pci_quirk probe_mask_list[] = {
 	/* forced codec slots */
 	SND_PCI_QUIRK(0x1043, 0x1262, "ASUS W5Fm", 0x103),
 	SND_PCI_QUIRK(0x1046, 0x1262, "ASUS W5F", 0x103),
+	SND_PCI_QUIRK(0x1558, 0x0351, "Schenker Dock 15", 0x105),
 	/* WinFast VP200 H (Teradici) user reported broken communication */
 	SND_PCI_QUIRK(0x3a21, 0x040d, "WinFast VP200 H", 0x101),
 	{}
@@ -1609,8 +1610,6 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 
 	assign_position_fix(chip, check_position_fix(chip, position_fix[dev]));
 
-	check_probe_mask(chip, dev);
-
 	chip->single_cmd = single_cmd;
 	azx_check_snoop_available(chip);
 
@@ -1631,6 +1630,8 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 		chip->bus.needs_damn_long_delay = 1;
 	}
 
+	check_probe_mask(chip, dev);
+
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err < 0) {
 		dev_err(card->dev, "Error creating device [card]!\n");
diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index ec731223cab3..72d454899484 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -90,16 +90,21 @@ static int pcm030_fabric_probe(struct platform_device *op)
 		dev_err(&op->dev, "platform_device_alloc() failed\n");
 
 	ret = platform_device_add(pdata->codec_device);
-	if (ret)
+	if (ret) {
 		dev_err(&op->dev, "platform_device_add() failed: %d\n", ret);
+		platform_device_put(pdata->codec_device);
+	}
 
 	ret = snd_soc_register_card(card);
-	if (ret)
+	if (ret) {
 		dev_err(&op->dev, "snd_soc_register_card() failed: %d\n", ret);
+		platform_device_del(pdata->codec_device);
+		platform_device_put(pdata->codec_device);
+	}
 
 	platform_set_drvdata(op, pdata);
-
 	return ret;
+
 }
 
 static int pcm030_fabric_remove(struct platform_device *op)
diff --git a/sound/soc/mediatek/mt8173/mt8173-max98090.c b/sound/soc/mediatek/mt8173/mt8173-max98090.c
index 5524a2c727ec..cab30cb48366 100644
--- a/sound/soc/mediatek/mt8173/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173/mt8173-max98090.c
@@ -183,6 +183,9 @@ static int mt8173_max98090_dev_probe(struct platform_device *pdev)
 	if (ret)
 		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
 			__func__, ret);
+
+	of_node_put(codec_node);
+	of_node_put(platform_node);
 	return ret;
 }
 
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
index 467f7049a288..52fdd766ee82 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
@@ -228,6 +228,8 @@ static int mt8173_rt5650_rt5514_dev_probe(struct platform_device *pdev)
 	if (ret)
 		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
 			__func__, ret);
+
+	of_node_put(platform_node);
 	return ret;
 }
 
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index 1b8b2a778845..5d75b04f074f 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
@@ -285,6 +285,8 @@ static int mt8173_rt5650_rt5676_dev_probe(struct platform_device *pdev)
 	if (ret)
 		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
 			__func__, ret);
+
+	of_node_put(platform_node);
 	return ret;
 }
 
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index ba65f4157a7e..d02a90201b13 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -317,6 +317,8 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 	if (ret)
 		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
 			__func__, ret);
+
+	of_node_put(platform_node);
 	return ret;
 }
 
diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
index 3e408158625d..72014dea7542 100644
--- a/sound/soc/samsung/idma.c
+++ b/sound/soc/samsung/idma.c
@@ -369,6 +369,8 @@ static int preallocate_idma_buffer(struct snd_pcm *pcm, int stream)
 	buf->addr = idma.lp_tx_addr;
 	buf->bytes = idma_hardware.buffer_bytes_max;
 	buf->area = (unsigned char * __force)ioremap(buf->addr, buf->bytes);
+	if (!buf->area)
+		return -ENOMEM;
 
 	return 0;
 }
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 90acdf4d90ed..e2c200c3c135 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -319,7 +319,7 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int sign_bit = mc->sign_bit;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
-	int err;
+	int err, ret;
 	bool type_2r = false;
 	unsigned int val2 = 0;
 	unsigned int val, val_mask;
@@ -327,13 +327,27 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	if (sign_bit)
 		mask = BIT(sign_bit + 1) - 1;
 
-	val = ((ucontrol->value.integer.value[0] + min) & mask);
+	val = ucontrol->value.integer.value[0];
+	if (mc->platform_max && val > mc->platform_max)
+		return -EINVAL;
+	if (val > max - min)
+		return -EINVAL;
+	if (val < 0)
+		return -EINVAL;
+	val = (val + min) & mask;
 	if (invert)
 		val = max - val;
 	val_mask = mask << shift;
 	val = val << shift;
 	if (snd_soc_volsw_is_stereo(mc)) {
-		val2 = ((ucontrol->value.integer.value[1] + min) & mask);
+		val2 = ucontrol->value.integer.value[1];
+		if (mc->platform_max && val2 > mc->platform_max)
+			return -EINVAL;
+		if (val2 > max - min)
+			return -EINVAL;
+		if (val2 < 0)
+			return -EINVAL;
+		val2 = (val2 + min) & mask;
 		if (invert)
 			val2 = max - val2;
 		if (reg == reg2) {
@@ -347,12 +361,18 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	err = snd_soc_component_update_bits(component, reg, val_mask, val);
 	if (err < 0)
 		return err;
+	ret = err;
 
-	if (type_2r)
+	if (type_2r) {
 		err = snd_soc_component_update_bits(component, reg2, val_mask,
-			val2);
+						    val2);
+		/* Don't discard any error code or drop change flag */
+		if (ret == 0 || err < 0) {
+			ret = err;
+		}
+	}
 
-	return err;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw);
 
@@ -427,8 +447,15 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	int err = 0;
 	unsigned int val, val_mask, val2 = 0;
 
+	val = ucontrol->value.integer.value[0];
+	if (mc->platform_max && val > mc->platform_max)
+		return -EINVAL;
+	if (val > max - min)
+		return -EINVAL;
+	if (val < 0)
+		return -EINVAL;
 	val_mask = mask << shift;
-	val = (ucontrol->value.integer.value[0] + min) & mask;
+	val = (val + min) & mask;
 	val = val << shift;
 
 	err = snd_soc_component_update_bits(component, reg, val_mask, val);
@@ -501,7 +528,7 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	unsigned int val, val_mask;
-	int ret;
+	int err, ret;
 
 	if (invert)
 		val = (max - ucontrol->value.integer.value[0]) & mask;
@@ -510,9 +537,10 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 	val_mask = mask << shift;
 	val = val << shift;
 
-	ret = snd_soc_component_update_bits(component, reg, val_mask, val);
-	if (ret < 0)
-		return ret;
+	err = snd_soc_component_update_bits(component, reg, val_mask, val);
+	if (err < 0)
+		return err;
+	ret = err;
 
 	if (snd_soc_volsw_is_stereo(mc)) {
 		if (invert)
@@ -522,8 +550,12 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 		val_mask = mask << shift;
 		val = val << shift;
 
-		ret = snd_soc_component_update_bits(component, rreg, val_mask,
+		err = snd_soc_component_update_bits(component, rreg, val_mask,
 			val);
+		/* Don't discard any error code or drop change flag */
+		if (ret == 0 || err < 0) {
+			ret = err;
+		}
 	}
 
 	return ret;
@@ -894,6 +926,8 @@ int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
 	unsigned int i, regval, regmask;
 	int err;
 
+	if (val < mc->min || val > mc->max)
+		return -EINVAL;
 	if (invert)
 		val = max - val;
 	val &= mask;
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 7133c36f99b6..b3abc4cf7eb0 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -385,7 +385,7 @@ static const struct line6_properties podhd_properties_table[] = {
 		.name = "POD HD500",
 		.capabilities	= LINE6_CAP_PCM
 				| LINE6_CAP_HWMON,
-		.altsetting = 0,
+		.altsetting = 1,
 		.ep_ctrl_r = 0x81,
 		.ep_ctrl_w = 0x01,
 		.ep_audio_r = 0x86,
@@ -396,7 +396,7 @@ static const struct line6_properties podhd_properties_table[] = {
 		.name = "POD HD500",
 		.capabilities	= LINE6_CAP_PCM
 				| LINE6_CAP_HWMON,
-		.altsetting = 1,
+		.altsetting = 0,
 		.ep_ctrl_r = 0x81,
 		.ep_ctrl_w = 0x01,
 		.ep_audio_r = 0x86,
diff --git a/tools/lib/subcmd/subcmd-util.h b/tools/lib/subcmd/subcmd-util.h
index fc2e45d8aaf1..f49dbd1674a6 100644
--- a/tools/lib/subcmd/subcmd-util.h
+++ b/tools/lib/subcmd/subcmd-util.h
@@ -49,15 +49,8 @@ static NORETURN inline void die(const char *err, ...)
 static inline void *xrealloc(void *ptr, size_t size)
 {
 	void *ret = realloc(ptr, size);
-	if (!ret && !size)
-		ret = realloc(ptr, 1);
-	if (!ret) {
-		ret = realloc(ptr, size);
-		if (!ret && !size)
-			ret = realloc(ptr, 1);
-		if (!ret)
-			die("Out of memory, realloc failed");
-	}
+	if (!ret)
+		die("Out of memory, realloc failed");
 	return ret;
 }
 
diff --git a/tools/testing/selftests/zram/zram.sh b/tools/testing/selftests/zram/zram.sh
index 9399c4aeaa26..d4652e295ff8 100755
--- a/tools/testing/selftests/zram/zram.sh
+++ b/tools/testing/selftests/zram/zram.sh
@@ -1,9 +1,6 @@
 #!/bin/bash
 TCID="zram.sh"
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
 . ./zram_lib.sh
 
 run_zram () {
@@ -17,14 +14,4 @@ echo ""
 
 check_prereqs
 
-# check zram module exists
-MODULE_PATH=/lib/modules/`uname -r`/kernel/drivers/block/zram/zram.ko
-if [ -f $MODULE_PATH ]; then
-	run_zram
-elif [ -b /dev/zram0 ]; then
-	run_zram
-else
-	echo "$TCID : No zram.ko module or /dev/zram0 device file not found"
-	echo "$TCID : CONFIG_ZRAM is not set"
-	exit $ksft_skip
-fi
+run_zram
diff --git a/tools/testing/selftests/zram/zram01.sh b/tools/testing/selftests/zram/zram01.sh
index b9566a6478a9..8abc9965089d 100755
--- a/tools/testing/selftests/zram/zram01.sh
+++ b/tools/testing/selftests/zram/zram01.sh
@@ -42,9 +42,7 @@ zram_algs="lzo"
 
 zram_fill_fs()
 {
-	local mem_free0=$(free -m | awk 'NR==2 {print $4}')
-
-	for i in $(seq 0 $(($dev_num - 1))); do
+	for i in $(seq $dev_start $dev_end); do
 		echo "fill zram$i..."
 		local b=0
 		while [ true ]; do
@@ -54,29 +52,17 @@ zram_fill_fs()
 			b=$(($b + 1))
 		done
 		echo "zram$i can be filled with '$b' KB"
-	done
 
-	local mem_free1=$(free -m | awk 'NR==2 {print $4}')
-	local used_mem=$(($mem_free0 - $mem_free1))
+		local mem_used_total=`awk '{print $3}' "/sys/block/zram$i/mm_stat"`
+		local v=$((100 * 1024 * $b / $mem_used_total))
+		if [ "$v" -lt 100 ]; then
+			 echo "FAIL compression ratio: 0.$v:1"
+			 ERR_CODE=-1
+			 return
+		fi
 
-	local total_size=0
-	for sm in $zram_sizes; do
-		local s=$(echo $sm | sed 's/M//')
-		total_size=$(($total_size + $s))
+		echo "zram compression ratio: $(echo "scale=2; $v / 100 " | bc):1: OK"
 	done
-
-	echo "zram used ${used_mem}M, zram disk sizes ${total_size}M"
-
-	local v=$((100 * $total_size / $used_mem))
-
-	if [ "$v" -lt 100 ]; then
-		echo "FAIL compression ratio: 0.$v:1"
-		ERR_CODE=-1
-		zram_cleanup
-		return
-	fi
-
-	echo "zram compression ratio: $(echo "scale=2; $v / 100 " | bc):1: OK"
 }
 
 check_prereqs
@@ -90,7 +76,6 @@ zram_mount
 
 zram_fill_fs
 zram_cleanup
-zram_unload
 
 if [ $ERR_CODE -ne 0 ]; then
 	echo "$TCID : [FAIL]"
diff --git a/tools/testing/selftests/zram/zram02.sh b/tools/testing/selftests/zram/zram02.sh
index 74569b883737..3768cfd2e5f8 100755
--- a/tools/testing/selftests/zram/zram02.sh
+++ b/tools/testing/selftests/zram/zram02.sh
@@ -45,7 +45,6 @@ zram_set_memlimit
 zram_makeswap
 zram_swapoff
 zram_cleanup
-zram_unload
 
 if [ $ERR_CODE -ne 0 ]; then
 	echo "$TCID : [FAIL]"
diff --git a/tools/testing/selftests/zram/zram_lib.sh b/tools/testing/selftests/zram/zram_lib.sh
index 9e73a4fb9b0a..130d193cbd72 100755
--- a/tools/testing/selftests/zram/zram_lib.sh
+++ b/tools/testing/selftests/zram/zram_lib.sh
@@ -14,12 +14,17 @@
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 # Modified: Naresh Kamboju <naresh.kamboju@linaro.org>
 
-MODULE=0
 dev_makeswap=-1
 dev_mounted=-1
-
+dev_start=0
+dev_end=-1
+module_load=-1
+sys_control=-1
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
+kernel_version=`uname -r | cut -d'.' -f1,2`
+kernel_major=${kernel_version%.*}
+kernel_minor=${kernel_version#*.}
 
 trap INT
 
@@ -34,68 +39,104 @@ check_prereqs()
 	fi
 }
 
+kernel_gte()
+{
+	major=${1%.*}
+	minor=${1#*.}
+
+	if [ $kernel_major -gt $major ]; then
+		return 0
+	elif [[ $kernel_major -eq $major && $kernel_minor -ge $minor ]]; then
+		return 0
+	fi
+
+	return 1
+}
+
 zram_cleanup()
 {
 	echo "zram cleanup"
 	local i=
-	for i in $(seq 0 $dev_makeswap); do
+	for i in $(seq $dev_start $dev_makeswap); do
 		swapoff /dev/zram$i
 	done
 
-	for i in $(seq 0 $dev_mounted); do
+	for i in $(seq $dev_start $dev_mounted); do
 		umount /dev/zram$i
 	done
 
-	for i in $(seq 0 $(($dev_num - 1))); do
+	for i in $(seq $dev_start $dev_end); do
 		echo 1 > /sys/block/zram${i}/reset
 		rm -rf zram$i
 	done
 
-}
+	if [ $sys_control -eq 1 ]; then
+		for i in $(seq $dev_start $dev_end); do
+			echo $i > /sys/class/zram-control/hot_remove
+		done
+	fi
 
-zram_unload()
-{
-	if [ $MODULE -ne 0 ] ; then
-		echo "zram rmmod zram"
+	if [ $module_load -eq 1 ]; then
 		rmmod zram > /dev/null 2>&1
 	fi
 }
 
 zram_load()
 {
-	# check zram module exists
-	MODULE_PATH=/lib/modules/`uname -r`/kernel/drivers/block/zram/zram.ko
-	if [ -f $MODULE_PATH ]; then
-		MODULE=1
-		echo "create '$dev_num' zram device(s)"
-		modprobe zram num_devices=$dev_num
-		if [ $? -ne 0 ]; then
-			echo "failed to insert zram module"
-			exit 1
-		fi
-
-		dev_num_created=$(ls /dev/zram* | wc -w)
+	echo "create '$dev_num' zram device(s)"
+
+	# zram module loaded, new kernel
+	if [ -d "/sys/class/zram-control" ]; then
+		echo "zram modules already loaded, kernel supports" \
+			"zram-control interface"
+		dev_start=$(ls /dev/zram* | wc -w)
+		dev_end=$(($dev_start + $dev_num - 1))
+		sys_control=1
+
+		for i in $(seq $dev_start $dev_end); do
+			cat /sys/class/zram-control/hot_add > /dev/null
+		done
+
+		echo "all zram devices (/dev/zram$dev_start~$dev_end" \
+			"successfully created"
+		return 0
+	fi
 
-		if [ "$dev_num_created" -ne "$dev_num" ]; then
-			echo "unexpected num of devices: $dev_num_created"
-			ERR_CODE=-1
+	# detect old kernel or built-in
+	modprobe zram num_devices=$dev_num
+	if [ ! -d "/sys/class/zram-control" ]; then
+		if grep -q '^zram' /proc/modules; then
+			rmmod zram > /dev/null 2>&1
+			if [ $? -ne 0 ]; then
+				echo "zram module is being used on old kernel" \
+					"without zram-control interface"
+				exit $ksft_skip
+			fi
 		else
-			echo "zram load module successful"
+			echo "test needs CONFIG_ZRAM=m on old kernel without" \
+				"zram-control interface"
+			exit $ksft_skip
 		fi
-	elif [ -b /dev/zram0 ]; then
-		echo "/dev/zram0 device file found: OK"
-	else
-		echo "ERROR: No zram.ko module or no /dev/zram0 device found"
-		echo "$TCID : CONFIG_ZRAM is not set"
-		exit 1
+		modprobe zram num_devices=$dev_num
 	fi
+
+	module_load=1
+	dev_end=$(($dev_num - 1))
+	echo "all zram devices (/dev/zram0~$dev_end) successfully created"
 }
 
 zram_max_streams()
 {
 	echo "set max_comp_streams to zram device(s)"
 
-	local i=0
+	kernel_gte 4.7
+	if [ $? -eq 0 ]; then
+		echo "The device attribute max_comp_streams was"\
+		               "deprecated in 4.7"
+		return 0
+	fi
+
+	local i=$dev_start
 	for max_s in $zram_max_streams; do
 		local sys_path="/sys/block/zram${i}/max_comp_streams"
 		echo $max_s > $sys_path || \
@@ -107,7 +148,7 @@ zram_max_streams()
 			echo "FAIL can't set max_streams '$max_s', get $max_stream"
 
 		i=$(($i + 1))
-		echo "$sys_path = '$max_streams' ($i/$dev_num)"
+		echo "$sys_path = '$max_streams'"
 	done
 
 	echo "zram max streams: OK"
@@ -117,15 +158,16 @@ zram_compress_alg()
 {
 	echo "test that we can set compression algorithm"
 
-	local algs=$(cat /sys/block/zram0/comp_algorithm)
+	local i=$dev_start
+	local algs=$(cat /sys/block/zram${i}/comp_algorithm)
 	echo "supported algs: $algs"
-	local i=0
+
 	for alg in $zram_algs; do
 		local sys_path="/sys/block/zram${i}/comp_algorithm"
 		echo "$alg" >	$sys_path || \
 			echo "FAIL can't set '$alg' to $sys_path"
 		i=$(($i + 1))
-		echo "$sys_path = '$alg' ($i/$dev_num)"
+		echo "$sys_path = '$alg'"
 	done
 
 	echo "zram set compression algorithm: OK"
@@ -134,14 +176,14 @@ zram_compress_alg()
 zram_set_disksizes()
 {
 	echo "set disk size to zram device(s)"
-	local i=0
+	local i=$dev_start
 	for ds in $zram_sizes; do
 		local sys_path="/sys/block/zram${i}/disksize"
 		echo "$ds" >	$sys_path || \
 			echo "FAIL can't set '$ds' to $sys_path"
 
 		i=$(($i + 1))
-		echo "$sys_path = '$ds' ($i/$dev_num)"
+		echo "$sys_path = '$ds'"
 	done
 
 	echo "zram set disksizes: OK"
@@ -151,14 +193,14 @@ zram_set_memlimit()
 {
 	echo "set memory limit to zram device(s)"
 
-	local i=0
+	local i=$dev_start
 	for ds in $zram_mem_limits; do
 		local sys_path="/sys/block/zram${i}/mem_limit"
 		echo "$ds" >	$sys_path || \
 			echo "FAIL can't set '$ds' to $sys_path"
 
 		i=$(($i + 1))
-		echo "$sys_path = '$ds' ($i/$dev_num)"
+		echo "$sys_path = '$ds'"
 	done
 
 	echo "zram set memory limit: OK"
@@ -167,8 +209,8 @@ zram_set_memlimit()
 zram_makeswap()
 {
 	echo "make swap with zram device(s)"
-	local i=0
-	for i in $(seq 0 $(($dev_num - 1))); do
+	local i=$dev_start
+	for i in $(seq $dev_start $dev_end); do
 		mkswap /dev/zram$i > err.log 2>&1
 		if [ $? -ne 0 ]; then
 			cat err.log
@@ -191,7 +233,7 @@ zram_makeswap()
 zram_swapoff()
 {
 	local i=
-	for i in $(seq 0 $dev_makeswap); do
+	for i in $(seq $dev_start $dev_end); do
 		swapoff /dev/zram$i > err.log 2>&1
 		if [ $? -ne 0 ]; then
 			cat err.log
@@ -205,7 +247,7 @@ zram_swapoff()
 
 zram_makefs()
 {
-	local i=0
+	local i=$dev_start
 	for fs in $zram_filesystems; do
 		# if requested fs not supported default it to ext2
 		which mkfs.$fs > /dev/null 2>&1 || fs=ext2
@@ -224,7 +266,7 @@ zram_makefs()
 zram_mount()
 {
 	local i=0
-	for i in $(seq 0 $(($dev_num - 1))); do
+	for i in $(seq $dev_start $dev_end); do
 		echo "mount /dev/zram$i"
 		mkdir zram$i
 		mount /dev/zram$i zram$i > /dev/null || \
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index db859b595dba..d9b7001227e3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1513,15 +1513,24 @@ static bool vma_is_valid(struct vm_area_struct *vma, bool write_fault)
 	return true;
 }
 
+static int kvm_try_get_pfn(kvm_pfn_t pfn)
+{
+	if (kvm_is_reserved_pfn(pfn))
+		return 1;
+	return get_page_unless_zero(pfn_to_page(pfn));
+}
+
 static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			       unsigned long addr, bool *async,
 			       bool write_fault, bool *writable,
 			       kvm_pfn_t *p_pfn)
 {
-	unsigned long pfn;
+	kvm_pfn_t pfn;
+	pte_t *ptep;
+	spinlock_t *ptl;
 	int r;
 
-	r = follow_pfn(vma, addr, &pfn);
+	r = follow_pte_pmd(vma->vm_mm, addr, &ptep, NULL, &ptl);
 	if (r) {
 		/*
 		 * get_user_pages fails for VM_IO and VM_PFNMAP vmas and does
@@ -1536,14 +1545,19 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 		if (r)
 			return r;
 
-		r = follow_pfn(vma, addr, &pfn);
+		r = follow_pte_pmd(vma->vm_mm, addr, &ptep, NULL, &ptl);
 		if (r)
 			return r;
+	}
 
+	if (write_fault && !pte_write(*ptep)) {
+		pfn = KVM_PFN_ERR_RO_FAULT;
+		goto out;
 	}
 
 	if (writable)
-		*writable = true;
+		*writable = pte_write(*ptep);
+	pfn = pte_pfn(*ptep);
 
 	/*
 	 * Get a reference here because callers of *hva_to_pfn* and
@@ -1555,11 +1569,21 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 	 * Whoever called remap_pfn_range is also going to call e.g.
 	 * unmap_mapping_range before the underlying pages are freed,
 	 * causing a call to our MMU notifier.
+	 *
+	 * Certain IO or PFNMAP mappings can be backed with valid
+	 * struct pages, but be allocated without refcounting e.g.,
+	 * tail pages of non-compound higher order allocations, which
+	 * would then underflow the refcount when the caller does the
+	 * required put_page. Don't allow those pages here.
 	 */ 
-	kvm_get_pfn(pfn);
+	if (!kvm_try_get_pfn(pfn))
+		r = -EFAULT;
 
+out:
+	pte_unmap_unlock(ptep, ptl);
 	*p_pfn = pfn;
-	return 0;
+
+	return r;
 }
 
 /*
