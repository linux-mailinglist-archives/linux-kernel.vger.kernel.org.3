Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2349591C0E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 18:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbiHMQ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 12:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbiHMQ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 12:57:12 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECF32D1C2;
        Sat, 13 Aug 2022 09:57:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA4A45DF3C;
        Sat, 13 Aug 2022 18:57:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1660409828; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding; bh=oWe3XaBKG7sQ/K2RGyuBHDy0vDbjP+dVmq4ESm5+oP4=;
        b=mHRhWcCOZnkKlxl0MmnMNe4KQvweb2ITcyX574w6xoD92xzTnS9jKkQP5dp5YLF7FTfUWE
        AC2206CIgHm0gDFTEMAEZCrtXxiJCTjgsq9HgHRseJB1MaLEC7yXe+ymB2OmVbLm25Frvs
        hy/RVH0xKGFhvjwapQdEWe7BkEs2qt09ck3Sr852rZXh4Z0gZK6bmSauJE1xII3gLEbk0q
        ZbCRy2HteoLXTBt2iFoLs/xw23C86e8CcUlNlqXbXY+EW6lWn1SFp377zlmsI8WiwZWNHk
        1tOYjbHkoG1bgpVcApd7WzXHlQKW/gK850KMWtiS+aXfGnsOXfPT01utlG4UGQ==
Date:   Sat, 13 Aug 2022 18:57:05 +0200
From:   Daniel Wagner <wagi@monom.org>
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
Subject: [ANNOUNCE] 4.19.255-rt113
Message-ID: <166040972522.12165.12921192851414170729@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.255-rt113 stable release.

This is just an update to the latest stable release. No RT specific
changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 3f10b93e91ead8aefa01758391b230b8a306e389

Or to build 4.19.255-rt113 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.255.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.255-rt113.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.252-rt112:
---

Alexander Aring (1):
      dlm: fix pending remove if msg allocation fails

Andrea Mayer (3):
      seg6: fix skb checksum evaluation in SRH encapsulation/insertion
      seg6: fix skb checksum in SRv6 End.B6 and End.B6.Encaps behaviors
      seg6: bpf: fix skb checksum in bpf_push_seg6_encap()

Ard Biesheuvel (2):
      ARM: 9214/1: alignment: advance IT state after emulating Thumb instruction
      ARM: 9209/1: Spectre-BHB: avoid pr_info() every time a CPU comes out of idle

Ben Dooks (1):
      riscv: add as-options for modules with assembly compontents

Benjamin Tissoires (2):
      HID: multitouch: simplify the application retrieval
      HID: multitouch: add support for the Smart Tech panel

Chanho Park (1):
      tty: serial: samsung_tty: set dma burst_size to 1

Charles Keepax (1):
      ASoC: wm5110: Fix DRE control

ChenXiaoSong (1):
      ntfs: fix use-after-free in ntfs_ucsncmp()

Daniel Sneddon (1):
      x86/speculation: Add RSB VM Exit protections

Daniel Wagner (2):
      Merge tag 'v4.19.255' into v4.19-rt
      Linux 4.19.255-rt113

Demi Marie Obenour (1):
      xen/gntdev: Ignore failure to unmap INVALID_GRANT_HANDLE

Dmitry Osipenko (1):
      ARM: 9213/1: Print message about disabled Spectre workarounds only once

Duoming Zhou (1):
      sctp: fix sleep in atomic context bug in timer handlers

Eric Dumazet (1):
      bpf: Make sure mac_header was set before using it

Florian Westphal (2):
      netfilter: br_netfilter: do not skip all hooks with 0 priority
      netfilter: nf_queue: do not allow packet truncation below transport header offset

Francesco Dolcini (1):
      ASoC: sgtl5000: Fix noise on shutdown/remove

GUO Zihua (1):
      ima: remove the IMA_TEMPLATE Kconfig option

Gabriel Fernandez (1):
      ARM: dts: stm32: use the correct clock source for CEC on stm32mp151

Greg Kroah-Hartman (4):
      Linux 4.19.253
      Linux 4.19.254
      ARM: crypto: comment out gcc warning that breaks clang builds
      Linux 4.19.255

Hangyu Hua (2):
      net: tipc: fix possible refcount leak in tipc_sk_create()
      xfrm: xfrm_policy: fix a possible double xfrm_pols_put() in xfrm_bundle_lookup()

Harald Freudenberger (1):
      s390/archrandom: prevent CPACF trng invocations in interrupt context

Hristo Venev (1):
      be2net: Fix buffer overflow in be_get_module_eeprom

Ilpo Järvinen (2):
      serial: stm32: Clear prev values before setting RTS delays
      serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle

Jason A. Donenfeld (1):
      Revert "Revert "char/random: silence a lockdep splat with printk()""

Jeffrey Hugo (4):
      PCI: hv: Fix multi-MSI to allow more than one MSI vector
      PCI: hv: Fix hv_arch_irq_unmask() for multi-MSI
      PCI: hv: Reuse existing IRTE allocation in compose_msi_msg()
      PCI: hv: Fix interrupt mapping for multi-MSI

Jianglei Nie (1):
      net: sfp: fix memory leak in sfp_probe()

Jiri Slaby (5):
      tty: drivers/tty/, stop using tty_schedule_flip()
      tty: the rest, stop using tty_schedule_flip()
      tty: drop tty_schedule_flip()
      tty: extract tty_flip_buffer_commit() from tty_flip_buffer_push()
      tty: use new tty_insert_flip_string_and_push_buffer() in pty_write()

Jose Alonso (1):
      net: usb: ax88179_178a needs FLAG_SEND_ZLP

Juergen Gross (2):
      xen/netback: avoid entering xenvif_rx_next_skb() with an empty rx queue
      x86: Clear .brk area at early boot

Junxiao Chang (1):
      net: stmmac: fix dma queue left shift overflow issue

Jyri Sarha (1):
      drm/tilcdc: Remove obsolete crtc_mode_valid() hack

Kai-Heng Feng (1):
      platform/x86: hp-wmi: Ignore Sanitization Mode event

Kris Bahnsen (1):
      ARM: dts: imx6qdl-ts7970: Fix ngpio typo and count

Kuniyuki Iwashima (43):
      inetpeer: Fix data-races around sysctl.
      net: Fix data-races around sysctl_mem.
      cipso: Fix data-races around sysctl.
      icmp: Fix data-races around sysctl.
      icmp: Fix a data-race around sysctl_icmp_ratelimit.
      icmp: Fix a data-race around sysctl_icmp_ratemask.
      ipv4: Fix data-races around sysctl_ip_dynaddr.
      ip: Fix data-races around sysctl_ip_fwd_use_pmtu.
      ip: Fix data-races around sysctl_ip_nonlocal_bind.
      ip: Fix a data-race around sysctl_fwmark_reflect.
      tcp/dccp: Fix a data-race around sysctl_tcp_fwmark_accept.
      tcp: Fix data-races around sysctl_tcp_mtu_probing.
      tcp: Fix a data-race around sysctl_tcp_probe_threshold.
      tcp: Fix a data-race around sysctl_tcp_probe_interval.
      igmp: Fix data-races around sysctl_igmp_llm_reports.
      igmp: Fix a data-race around sysctl_igmp_max_memberships.
      tcp: Fix data-races around sysctl_tcp_reordering.
      tcp: Fix data-races around some timeout sysctl knobs.
      tcp: Fix a data-race around sysctl_tcp_notsent_lowat.
      tcp: Fix a data-race around sysctl_tcp_tw_reuse.
      tcp: Fix data-races around sysctl_tcp_fastopen.
      tcp: Fix a data-race around sysctl_tcp_early_retrans.
      tcp: Fix data-races around sysctl_tcp_recovery.
      tcp: Fix a data-race around sysctl_tcp_thin_linear_timeouts.
      tcp: Fix data-races around sysctl_tcp_slow_start_after_idle.
      tcp: Fix a data-race around sysctl_tcp_retrans_collapse.
      tcp: Fix a data-race around sysctl_tcp_stdurg.
      tcp: Fix a data-race around sysctl_tcp_rfc1337.
      tcp: Fix data-races around sysctl_tcp_max_reordering.
      tcp: Fix data-races around sysctl_tcp_dsack.
      tcp: Fix a data-race around sysctl_tcp_app_win.
      tcp: Fix a data-race around sysctl_tcp_adv_win_scale.
      tcp: Fix a data-race around sysctl_tcp_frto.
      tcp: Fix a data-race around sysctl_tcp_nometrics_save.
      tcp: Fix a data-race around sysctl_tcp_challenge_ack_limit.
      net: ping6: Fix memleak in ipv6_renew_options().
      igmp: Fix data-races around sysctl_igmp_qrv.
      tcp: Fix a data-race around sysctl_tcp_min_tso_segs.
      tcp: Fix a data-race around sysctl_tcp_min_rtt_wlen.
      tcp: Fix a data-race around sysctl_tcp_autocorking.
      tcp: Fix a data-race around sysctl_tcp_invalid_ratelimit.
      tcp: Fix a data-race around sysctl_tcp_comp_sack_delay_ns.
      tcp: Fix a data-race around sysctl_tcp_comp_sack_nr.

Leo Yan (1):
      perf symbol: Correct address for bss symbols

Liang He (3):
      cpufreq: pmac32-cpufreq: Fix refcount leak bug
      scsi: ufs: host: Hold reference returned by of_parse_phandle()
      net: sungem_phy: Add of_node_put() for reference returned by of_get_parent()

Linus Torvalds (1):
      signal handling: don't use BUG_ON() for debugging

Linyu Yuan (1):
      usb: typec: add missing uevent when partner support PD

Lucien Buchmann (1):
      USB: serial: ftdi_sio: add Belimo device ids

Luiz Augusto von Dentz (8):
      Bluetooth: Add bt_skb_sendmsg helper
      Bluetooth: Add bt_skb_sendmmsg helper
      Bluetooth: SCO: Replace use of memcpy_from_msg with bt_skb_sendmsg
      Bluetooth: RFCOMM: Replace use of memcpy_from_msg with bt_skb_sendmmsg
      Bluetooth: Fix passing NULL to PTR_ERR
      Bluetooth: SCO: Fix sco_send_frame returning skb->len
      Bluetooth: Fix bt_skb_sendmmsg not allocating partial chunks
      Bluetooth: L2CAP: Fix use-after-free caused by l2cap_chan_put

Marc Kleine-Budde (1):
      can: m_can: m_can_tx_handler(): fix use after free of skb

Mark Brown (1):
      ASoC: ops: Fix off by one in range control validation

Meng Tang (3):
      ALSA: hda - Add fixup for Dell Latitidue E5430
      ALSA: hda/conexant: Apply quirk for another HP ProDesk 600 G3 model
      ALSA: hda/realtek - Fix headset mic problem for a HP machine with alc221

Miaoqian Lin (1):
      power/reset: arm-versatile: Fix refcount leak in versatile_reboot_probe

Michael Walle (1):
      NFC: nxp-nci: don't print header length mismatch on i2c error

Michal Maloszewski (1):
      i40e: Fix interface init with MSI interrupts (no MSI-X)

Michal Suchanek (1):
      ARM: dts: sunxi: Fix SPI NOR campatible on Orange Pi Zero

Mikael Wikström (1):
      HID: multitouch: Lenovo X1 Tablet Gen3 trackpoint and buttons

Ming Lei (1):
      scsi: core: Fix race between handling STS_RESOURCE and completion

Ning Qiang (1):
      macintosh/adb: fix oob read in do_adb_query() function

Pali Rohár (1):
      serial: mvebu-uart: correctly report configured baudrate value

Pawan Gupta (1):
      x86/speculation: Add LFENCE to RSB fill sequence

Peter Zijlstra (1):
      perf/core: Fix data race between perf_event_set_output() and perf_mmap_close()

Robert Hancock (1):
      i2c: cadence: Change large transfer count reset logic to be unconditional

Ryusuke Konishi (1):
      nilfs2: fix incorrect masking of permission flags for symlinks

Stafford Horne (1):
      irqchip: or1k-pic: Undefine mask_ack for level triggered hardware

Stephan Gerhold (2):
      virtio_mmio: Add missing PM calls to freeze/restore
      virtio_mmio: Restore guest page size on resume

Steven Rostedt (Google) (1):
      net: sock: tracing: Fix sock_exceed_buf_limit not to dereference stale pointer

Takashi Iwai (1):
      ALSA: memalloc: Align buffer allocations in page size

Tariq Toukan (1):
      net/tls: Fix race in TLS device down flow

Tejun Heo (1):
      cgroup: Use separate src/dst nodes when preloading css_sets for migration

Thinh Nguyen (1):
      usb: dwc3: gadget: Fix event pending check

Tony Fischetti (1):
      HID: add ALWAYS_POLL quirk to lenovo pixart mouse

Wang Cheng (1):
      mm/mempolicy: fix uninit-value in mpol_rebind_policy()

Wei Mingzhi (1):
      mt7601u: add USB device ID for some versions of XiaoDu WiFi Dongle.

Werner Sembach (2):
      ACPI: video: Force backlight native for some TongFang devices
      ACPI: video: Shortening quirk list by identifying Clevo by board_name only

William Dean (1):
      pinctrl: ralink: Check for null return of devm_kcalloc

Xiaomeng Tong (1):
      tilcdc: tilcdc_external: fix an incorrect NULL check on list iterator

Xin Long (1):
      Documentation: fix sctp_wmem in ip-sysctl.rst

Yi Yang (1):
      serial: 8250: fix return error code in serial8250_request_std_resource()

Zheng Yejian (1):
      tracing/histograms: Fix memory leak problem

Íñigo Huguet (2):
      sfc: fix use after free when disabling sriov
      sfc: fix kernel panic when creating VF
