Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB05B535991
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344146AbiE0GrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbiE0Gqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:46:48 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F6BE2772;
        Thu, 26 May 2022 23:46:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7FDF85DA19;
        Fri, 27 May 2022 08:37:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1653633478; h=from:subject:date:message-id:to;
        bh=RTQ5QtXNVlVLvhfQv0kgnNLTHiqXoF7p72taJmmkFSY=;
        b=nwfBL6Tb69LK2QWqsBTnjAYh+emyr9pVKPNAh9KtaXVoQQhC1OU9ATqU3IIFmfAYKoOtjA
        SadsD1yRxcrVIrdqR/R/rSqlDmnV2cXFzxqENE0wWGcn7xnreifmKCKRqr6qvYrzvBEJpU
        PPIXdok6Yo22anxw6p8Tr707s3pEtB7BnNiA6Prw3mMwBvnFPyESV9hRIbXvitZP88a1Ff
        vG4au8/fOyLnkGAGAK8MkOjej6hf9nScEJ6fZ2F7Jhpd+0l6yOMyxjpyybkHazQ0wJ4p0l
        iFyfUJU1bJIU+KeYFoQ99fNeq1rBFj+1UpxO1nsDEWVTR/njCG2W9uxULXCaYg==
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.19.245-rt109
Date:   Wed, 25 May 2022 07:31:40 -0000
Message-ID: <165346390046.11398.18138245986252936857@beryllium.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.245-rt109 stable release.

This is just an update to the latest stable release. No RT specific
changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 2f7cd037d151824397d030913efd978a215ec161

Or to build 4.19.245-rt109 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.245.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.245-rt109.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.240-rt108:
---

Adam Ford (1):
      ARM: dts: logicpd-som-lv: Fix wrong pinmuxing on OMAP35

Al Viro (1):
      Fix double fget() in vhost_net_set_backend()

Alexandra Winter (3):
      s390/ctcm: fix variable dereferenced before check
      s390/ctcm: fix potential memory leak
      s390/lcs: fix variable dereferenced before check

Andreas Gruenbacher (1):
      gfs2: Fix filesystem block deallocation for short writes

Andreas Larsson (2):
      can: grcan: grcan_probe(): fix broken system id check for errata workaround needs
      can: grcan: only use the NAPI poll budget for RX

Andrei Lalaev (1):
      gpiolib: of: fix bounds check for 'gpio-reserved-ranges'

Andrew Lunn (1):
      net: bridge: Clear offload_fwd_mark when passing frame up bridge interface.

Ard Biesheuvel (2):
      ARM: 9196/1: spectre-bhb: enable for Cortex-A15
      ARM: 9197/1: spectre-bhb: fix loop8 sequence for Thumb2

Armin Wolf (1):
      hwmon: (adt7470) Fix warning on module removal

Borislav Petkov (1):
      x86/cpu: Load microcode during restore_processor_state()

Bruno Thomsen (1):
      USB: serial: cp210x: add PIDs for Kamstrup USB Meter Reader

Camel Guo (1):
      hwmon: (tmp401) Add OF device ID table

ChenXiaoSong (1):
      VFS: Fix memory leak caused by concurrently mounting fs with subtype

Chengfeng Ye (1):
      firewire: fix potential uaf in outbound_phy_packet_callback()

Christophe JAILLET (2):
      bus: sunxi-rsb: Fix the return value of sunxi_rsb_device_create()
      net/qla3xxx: Fix a test in ql_reset_work()

Chuanhong Guo (1):
      mtd: rawnand: fix ecc parameters for mt7622

Codrin Ciubotariu (2):
      ASoC: dmaengine: Restore NULL prepare_slave_config() callback
      clk: at91: generated: consider range when calculating best rate

Dafna Hirschfeld (1):
      media: vicodec: upon release, call m2m release before freeing ctrl handler

Dan Vacura (1):
      usb: gadget: uvc: Fix crash when encoding data for usb request

Daniel Hellstrom (1):
      can: grcan: use ofdev->dev when allocating DMA memory

Daniel Starke (7):
      tty: n_gsm: fix wrong signal octet encoding in convergence layer type 2
      tty: n_gsm: fix malformed counter for out of frame data
      tty: n_gsm: fix insufficient txframe size
      tty: n_gsm: fix missing explicit ldisc flush
      tty: n_gsm: fix wrong command retry handling
      tty: n_gsm: fix wrong command frame length field encoding
      tty: n_gsm: fix incorrect UA handling

Daniel Vetter (1):
      drm/vgem: Close use-after-free race in vgem_gem_create

Daniel Wagner (2):
      Merge tag 'v4.19.245' into v4.19-rt
      Linux 4.19.245-rt109

Daniele Palmas (1):
      USB: serial: option: add Telit 0x1057, 0x1058, 0x1075 compositions

David Gow (1):
      um: Cleanup syscall_handler_t definition/cast, fix warning

David Howells (1):
      afs: Fix afs_getattr() to refetch file status if callback break occurred

Duoming Zhou (6):
      drivers: net: hippi: Fix deadlock in rr_close()
      can: grcan: grcan_close(): fix deadlock
      nfc: replace improper check device_is_registered() in netlink related functions
      nfc: nfcmrvl: main: reorder destructive operations in nfcmrvl_nci_unregister_dev to avoid bugs
      NFC: netlink: fix sleep in atomic bug when firmware download timeout
      NFC: nci: fix sleep in atomic context bugs caused by nci_skb_alloc

Eric Dumazet (6):
      net/sched: cls_u32: fix netns refcount changes in u32_change()
      tcp: fix potential xmit stalls caused by TCP_NOTSENT_LOWAT
      net: igmp: respect RCU rules in ip_mc_source() and ip_mc_msfilter()
      tcp: make sure treq->af_specific is initialized
      netlink: do not reset transport header in netlink_recvmsg()
      tcp: resalt the secret every 10 seconds

Ethan Yang (1):
      USB: serial: qcserial: add support for Sierra Wireless EM7590

Fabio Estevam (1):
      ARM: dts: imx6qdl-apalis: Fix sgtl5000 detection issue

Felix Fietkau (1):
      mac80211: fix rx reordering with non explicit / psmp ack policy

Filipe Manana (1):
      btrfs: always log symlinks in full mode

Florian Westphal (1):
      netfilter: nft_socket: only do sk lookups when indev is available

Francesco Ruggeri (1):
      tcp: md5: incorrect tcp_header_len for incoming connections

Gleb Chesnokov (1):
      scsi: qla2xxx: Fix missed DMA unmap for aborted commands

Grant Grundler (1):
      net: atlantic: verify hw_head_ lies within TX buffer ring

Greg Kroah-Hartman (7):
      Revert "net: ethernet: stmmac: fix altr_tse_pcs function when using a fixed-link"
      lightnvm: disable the subsystem
      Linux 4.19.241
      Linux 4.19.242
      Linux 4.19.243
      Linux 4.19.244
      Linux 4.19.245

Guangguan Wang (1):
      net/smc: non blocking recvmsg() return -EAGAIN when no data and signal_pending

H. Nikolaus Schaller (1):
      ARM: dts: Fix mmc order for omap3-gta04

Haibo Chen (1):
      gpio: gpio-vf610: do not touch other bits when set the target bit

Halil Pasic (1):
      swiotlb: fix info leak with DMA_FROM_DEVICE

Hangyu Hua (2):
      usb: misc: fix improper handling of refcount in uss720_probe()
      drm/dp/mst: fix a possible memory leak in fetch_monitor_name()

Harini Katakam (1):
      net: macb: Increment rx bd head after allocating skb and buffer

Helge Deller (1):
      parisc: Merge model and model name into one line in /proc/cpuinfo

Henry Lin (1):
      xhci: stop polling roothubs after shutdown

Ido Schimmel (1):
      selftests: mirror_gre_bridge_1q: Avoid changing PVID while interface is operational

Itay Iellin (1):
      Bluetooth: Fix the creation of hdev->name

Jakob Koschel (2):
      firewire: remove check of list iterator against head past the loop body
      drbd: remove usage of list iterator variable after loop

Jeff LaBundy (1):
      Input: add bounds checking to input_set_capability()

Ji-Ze Hong (Peter Hong) (1):
      hwmon: (f71882fg) Fix negative temperature

Jian Shen (1):
      net: hns3: add validity check for message data length

Jiasheng Jiang (1):
      net: af_key: add check for pfkey_broadcast in function pfkey_process

Jiazi Li (1):
      dm: fix mempool NULL pointer race when completing IO

Johan Hovold (1):
      serial: imx: fix overrun interrupts in DMA mode

Johannes Berg (1):
      mac80211_hwsim: call ieee80211_tx_prepare_skb under RCU protection

Jonathan Lemon (1):
      net: bcmgenet: hide status block before TX timestamping

Kees Cook (1):
      USB: serial: whiteheat: fix heap overflow in WHITEHEAT_GET_DTR_RTS

Kevin Mitchell (1):
      igb: skip phy status check where unavailable

Krzysztof Kozlowski (1):
      phy: samsung: exynos5250-sata: fix missing device put in probe error paths

Lee Jones (2):
      block: drbd: drbd_nl: Make conversion to 'enum drbd_ret_code' explicit
      drm/amd/display/dc/gpio/gpio_service: Pass around correct dce_{version, environment} types

Lin Ma (2):
      hamradio: defer 6pack kfree after unregister_netdev
      hamradio: remove needs_free_netdev to avoid UAF

Linus Torvalds (1):
      Reinstate some of "swiotlb: rework "fix info leak with DMA_FROM_DEVICE""

Lokesh Dhoundiyal (1):
      ipv4: drop dst in multicast routing path

Lv Ruyi (1):
      pinctrl: pistachio: fix use of irq_of_parse_and_map()

Maciej W. Rozycki (3):
      serial: 8250: Also set sticky MCR bits in console restoration
      serial: 8250: Correct the clock for EndRun PTP/1588 PCIe device
      MIPS: Fix CP0 counter erratum detection for R4k CPUs

Macpaul Lin (1):
      usb: mtu3: fix USB 3.0 dual-role-switch from device to host

Manish Chopra (1):
      bnx2x: fix napi API usage sequence

Mark Brown (4):
      ASoC: wm8958: Fix change notifications for DSP controls
      ASoC: max98090: Reject invalid values in custom control put()
      ASoC: max98090: Generate notifications on changes for custom control
      ASoC: ops: Validate input values in snd_soc_put_volsw_range()

Masami Hiramatsu (3):
      Revert "ia64: kprobes: Fix to pass correct trampoline address to the handler"
      Revert "ia64: kprobes: Use generic kretprobe trampoline handler"
      ia64: kprobes: Fix to pass correct trampoline address to the handler

Max Krummenacher (1):
      ARM: dts: imx6ull-colibri: fix vqmmc regulator

Maxim Mikityanskiy (1):
      net/mlx5e: Properly block LRO when XDP is enabled

Miaoqian Lin (4):
      phy: samsung: Fix missing of_node_put() in exynos_sata_phy_probe
      ARM: OMAP2+: Fix refcount leak in omap_gic_of_init
      mtd: rawnand: Fix return value check of wait_for_completion_timeout
      slimbus: qcom: Fix IRQ check in qcom_slim_probe

Michael Ellerman (1):
      powerpc/64s: Unmerge EX_LR and EX_DAR

Michael Hennerich (1):
      iio: dac: ad5446: Fix read_raw not returning set value

Mike Snitzer (1):
      dm: interlock pending dm_io and dm_wait_for_bios_completion

Mikulas Patocka (3):
      hex2bin: make the function hex_to_bin constant-time
      hex2bin: fix access beyond string end
      x86: __memcpy_flushcache: fix wrong alignment if size > 2^32

Minchan Kim (1):
      mm: fix unexpected zeroed page mapping with zram swap

Muchun Song (2):
      mm: hugetlb: fix missing cache flush in copy_huge_page_from_user()
      mm: userfaultfd: fix missing cache flush in mcopy_atomic_pte() and __mcopy_atomic()

Nathan Chancellor (2):
      MIPS: Use address-of operator on section symbols
      nfp: bpf: silence bitwise vs. logical OR warning

Nicholas Piggin (1):
      powerpc/64/interrupt: Temporarily save PPR on stack to fix register corruption due to SLB miss

Nicolas Dichtel (1):
      ping: fix address binding wrt vrf

Niels Dossche (1):
      firewire: core: extend card->lock in fw_core_handle_bus_reset

Oliver Neukum (2):
      USB: quirks: add a Realtek card reader
      USB: quirks: add STRING quirk for VCOM device

Ondrej Mosnacek (1):
      crypto: qcom-rng - fix infinite loop on requests not multiple of WORD_SZ

Pali Rohár (2):
      PCI: aardvark: Clear all MSIs at setup
      PCI: aardvark: Fix reading MSI interrupt number

Paolo Abeni (2):
      net/sched: act_pedit: really ensure the skb is writable
      net/sched: act_pedit: sanitize shift argument before usage

Peilin Ye (2):
      ip_gre: Make o_seqno start from 0 in native mode
      ip6_gre: Avoid updating tunnel->tun_hlen in __gre6_xmit()

Pengcheng Yang (1):
      ipvs: correctly print the memory size of ip_vs_conn_tab

Peter Zijlstra (1):
      perf: Fix sys_perf_event_open() race against self

Rafael J. Wysocki (1):
      PCI/PM: Avoid putting Elo i2 PCIe Ports in D3cold

Randy Dunlap (1):
      hwmon: (ltq-cputemp) restrict it to SOC_XWAY

Ricky WU (1):
      mmc: rtsx: add 74 Clocks in power on flow

Ronnie Sahlberg (1):
      cifs: destage any unwritten data to the server before calling copychunk_write

Ryusuke Konishi (2):
      nilfs2: fix lockdep warnings in page operations for btree nodes
      nilfs2: fix lockdep warnings during disk space reclamation

Sandipan Das (1):
      kvm: x86/cpuid: Only provide CPUID leaf 0xA if host has architectural PMU

Scott Chen (1):
      USB: serial: pl2303: add device id for HP LM930 Display

Sergey Ryazanov (1):
      usb: cdc-wdm: fix reading stuck on device close

Sergey Shtylyov (1):
      smsc911x: allow using IRQ0

Shravya Kumbham (1):
      net: emaclite: Add error handling for of_address_to_resource()

Slark Xiao (1):
      USB: serial: option: add support for Cinterion MV32-WA/MV32-WB

Sudip Mukherjee (1):
      MIPS: fix allmodconfig build with latest mkimage

Sven Eckelmann (1):
      batman-adv: Don't skb_split skbuffs with frag_list

Sven Schnelle (1):
      s390: disable -Warray-bounds

Sven Schwermer (2):
      USB: serial: option: add Fibocom L610 modem
      USB: serial: option: add Fibocom MA510 modem

Taehee Yoo (1):
      net: sfc: ef10: fix memory leak in efx_ef10_mtd_probe()

Takashi Iwai (6):
      ALSA: pcm: Fix races among concurrent hw_params and hw_free calls
      ALSA: pcm: Fix races among concurrent read/write and buffer changes
      ALSA: pcm: Fix races among concurrent prepare and hw_params/hw_free calls
      ALSA: pcm: Fix races among concurrent prealloc proc writes
      ALSA: pcm: Fix potential AB/BA lock with buffer_mutex and mmap_lock
      ALSA: wavefront: Proper check of get_user() error

Takashi Sakamoto (1):
      ALSA: fireworks: fix wrong return count shorter than expected by 4 bytes

Tariq Toukan (1):
      net: Fix features skip in for_each_netdev_feature()

Thinh Nguyen (2):
      usb: dwc3: core: Fix tx/rx threshold settings
      usb: dwc3: gadget: Return proper request status

Thomas Pfaff (1):
      genirq: Synchronize interrupt thread startup

Thomas Richter (1):
      perf bench numa: Address compiler error on s390

Trond Myklebust (1):
      Revert "SUNRPC: attempt AF_LOCAL connect on setup"

Ulf Hansson (4):
      mmc: core: Cleanup BKOPS support
      mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
      mmc: block: Use generic_cmd6_time when modifying INAND_CMD38_ARG_EXT_CSD
      mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()

Uwe Kleine-König (2):
      usb: typec: tcpci: Don't skip cleanup in .remove() on error
      gpio: mvebu/pwm: Refuse requests with inverted polarity

Vijayavardhan Vennapusa (1):
      usb: gadget: configfs: clear deactivation flag in configfs_composite_unbind()

Waiman Long (1):
      cgroup/cpuset: Remove cpus_allowed/mems_allowed setup in cpuset_init_smp()

Weitao Wang (1):
      USB: Fix xhci event ring dequeue pointer ERDP update issue

Willy Tarreau (2):
      floppy: disable FDRAWCMD by default
      floppy: use a statically allocated error counter

Xiaoke Wang (1):
      MIPS: lantiq: check the return value of kzalloc()

Xin Long (1):
      sctp: check asoc strreset_chunk in sctp_generate_reconf_event

Yang Yingliang (5):
      clk: sunxi: sun9i-mmc: check return value after calling platform_get_resource()
      net: stmmac: dwmac-sun8i: add missing of_node_put() in sun8i_dwmac_register_mdio_mux()
      tty/serial: digicolor: fix possible null-ptr-deref in digicolor_uart_probe()
      ethernet: tulip: fix missing pci_disable_device() on error in tulip_init_one()
      net: stmmac: fix missing pci_disable_device() on error in stmmac_pci_probe()

Zack Rusin (1):
      drm/vmwgfx: Initialize drm_mode_fb_cmd2

Zheng Yongjun (2):
      Input: stmfts - fix reference leak in stmfts_input_open
      crypto: stm32 - fix reference leak in stm32_crc_remove

Zheyu Ma (2):
      iio: magnetometer: ak8975: Fix the error handling in ak8975_power_on()
      ASoC: wm8731: Disable the regulator when probing fails

Zixuan Fu (2):
      net: vmxnet3: fix possible use-after-free bugs in vmxnet3_rq_alloc_rx_buf()
      net: vmxnet3: fix possible NULL pointer dereference in vmxnet3_rq_cleanup()

Zizhuang Deng (1):
      iio: dac: ad5592r: Fix the missing return value.

linyujun (1):
      ARM: 9191/1: arm/stacktrace, kasan: Silence KASAN warnings in unwind_frame()
