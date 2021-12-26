Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8FA47F908
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 22:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbhLZVbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 16:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbhLZVbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 16:31:16 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F90C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 13:31:15 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l5so20148509edj.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 13:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/r4DA8OLE1yWDftqwJJNNkkdfVfU3mKBoToY+06P6F8=;
        b=HcSpyZCVrcCks0Mo/BdSBNM8m+n4PlZDv0Jkl7Qp5jh5+8a8kF4MjY8XdjwtaVt568
         U3gEhX8YQyPtph7bzKr4KRFXlQPZdcIlqgrXrocD3BAgkLTl/WATOEvr+654n8pV+2GQ
         IIlg3nAXUjMb2Ve3zB+87aKKFv5IksPYdquE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/r4DA8OLE1yWDftqwJJNNkkdfVfU3mKBoToY+06P6F8=;
        b=mRet0cscuwVr4sijNgVzGeXDyd45A8TepgZpZ8TKKSNrNvNA5ZvJEwrg1qxXyINLRV
         GZQ34s9XIHz8eZtKStU1ELzTm5KWFquREuWIb9tBw+YkTpL8B1HAiC028wZJ34HdvOdy
         GDDaOs1bEa71uZwiD+xsSH5zNylrcZU6tki54zoll110n6YQhE94QmI7dNFui28u5xcM
         xJjzQ4aUeMzT30srQn2uHv135sptTwzBJ4Rjfa2QqV8OI19QrAijjOx/meTkMyE2Lvf2
         n3KfsXRtyMrvr2aBExDaAoHU3qb1Vq4i8zuWc/bkfohfNK/QCQX5khVgH0Aaz4LTXhWc
         DMeQ==
X-Gm-Message-State: AOAM533I9exZ66mx8wvkXmKYTvHCkSFsX6oyTDmugOcYzj8Q6tgIJSf9
        KAJiZMTAS3RCOypxdCyyRRzcXZVINzzxQ4D9
X-Google-Smtp-Source: ABdhPJw9WZ1jyt11SWUEBrD6+REvIvnjTN6Cv78YxxDvYNoN3UjiRqbBB2LWdCxo/Tm+zJIX3s4FXQ==
X-Received: by 2002:a17:906:cc84:: with SMTP id oq4mr7736353ejb.736.1640554273046;
        Sun, 26 Dec 2021 13:31:13 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id r3sm4543952ejr.79.2021.12.26.13.31.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Dec 2021 13:31:12 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id a9so28811641wrr.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 13:31:12 -0800 (PST)
X-Received: by 2002:a5d:6211:: with SMTP id y17mr10793791wru.97.1640554271990;
 Sun, 26 Dec 2021 13:31:11 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Dec 2021 13:30:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgV_v+Enop3TwRFtJY74UjQtw=kfOzGXTQscLx2syW6Eg@mail.gmail.com>
Message-ID: <CAHk-=wgV_v+Enop3TwRFtJY74UjQtw=kfOzGXTQscLx2syW6Eg@mail.gmail.com>
Subject: Linux 5.16-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To the surprise of absolutely nobody, this rc7 is fairly small.

The stats look pretty normal, with about three quarters being drivers
(networking, input, sound, tee, hwmon, rdma..). Somewhat unusually, we
have a PC keyboard controller (not USB - the old legacy kind) fix in
here - one of the earliest supported hardware still hangs around, and
still gets some probe-time changes for odd hardware.

The rest is mainly some kvm and networking fixes, and a few random
stragglers elsewhere.

Obviously the holidays are a big reason it's all small, so it's not
like this is a sign of us having found all bugs, and we'll keep at
this for at least two more weeks.

Hope everybody had a good Xmas (or insert your preferred alternative
holiday) and I'll wish you a happy new year in advance. Because I
suspect the upcoming week will be even quieter since at least _some_
of this past week was "this is my last pull request before xmas".

Shortlog appended, please do give this a whirl.

                    Linus

---

Aleksander Jan Bajkowski (1):
      net: lantiq_xrx200: increase buffer reservation

Alexander Lobakin (1):
      ice: remove dead store on XSK hotpath

Alexey Gladkov (1):
      ucounts: Fix rlimit max values check

Andrea Righi (1):
      Input: elantech - fix stack out of bound access in
elantech_change_report_id()

Andrew Cooper (1):
      x86/pkey: Fix undefined behaviour with PKRU_WD_BIT

Andrew Jones (1):
      selftests: KVM: Fix non-x86 compiling

Andrey Ryabinin (1):
      mm: mempolicy: fix THP allocations escaping mempolicy restrictions

Andy Shevchenko (1):
      platform/x86/intel: Remove X86_PLATFORM_DRIVERS_INTEL

AngeloGioacchino Del Regno (1):
      drm/mediatek: hdmi: Perform NULL pointer check for mtk_hdmi_conf

Ard Biesheuvel (1):
      ARM: 9169/1: entry: fix Thumb2 bug in iWMMXt exception handling

Baokun Li (1):
      kfence: fix memory leak when cat kfence objects

Benjamin Tissoires (1):
      HID: holtek: fix mouse probing

Borislav Petkov (2):
      Revert "x86/boot: Mark prepare_command_line() __init"
      Revert "x86/boot: Pull up cmdline preparation and early param parsing=
"

Bradley Scott (2):
      ALSA: hda/realtek: Amp init fixup for HP ZBook 15 G6
      ALSA: hda/realtek: Add new alc285-hp-amp-init model

Chuck Lever (1):
      NFSD: Fix READDIR buffer overflow

Colin Ian King (1):
      ALSA: drivers: opl3: Fix incorrect use of vp->state

Dan Carpenter (1):
      ksmbd: fix error code in ndr_read_int32()

Derek Fang (1):
      ASoC: rt5682: fix the wrong jack type detected

Dmitry Osipenko (2):
      ASoC: tegra: Add DAPM switches for headphones and mic jack
      ASoC: tegra: Restore headphones jack name on Nyan Big

Dmitry Vyukov (1):
      tomoyo: Check exceeded quota early in tomoyo_domain_quota_is_ok().

Dongliang Mu (1):
      spi: change clk_disable_unprepare to clk_unprepare

Eric Dumazet (2):
      netfilter: nf_tables: fix use-after-free in nft_set_catchall_destroy(=
)
      inet: fully convert sk->sk_rx_dst to RCU rules

Fabien Dessenne (1):
      pinctrl: stm32: consider the GPIO offset to expose all the GPIO lines

Fernando Fernandez Mancera (1):
      bonding: fix ad_actor_system option setting to default

Florian Westphal (1):
      netfilter: ctnetlink: remove expired entries first

George Kennedy (1):
      tun: avoid double free in tun_free_netdev

Giovanni Cabiddu (1):
      crypto: qat - do not handle PFVF sources for qat_4xxx

Guenter Roeck (5):
      hwmon: (lm90) Fix usage of CONFIG2 register in detect function
      hwmon: (lm90) Prevent integer overflow/underflow in hysteresis
calculations
      hwmon: (lm90) Drop critical attribute support for MAX6654
      hwmom: (lm90) Fix citical alarm status for MAX6680/MAX6681
      hwmon: (lm90) Do not report 'busy' status bit as alarm

Guodong Liu (1):
      pinctrl: mediatek: fix global-out-of-bounds issue

Hans de Goede (2):
      Input: goodix - try not to touch the reset-pin on x86/ACPI devices
      Input: goodix - add id->model mapping for the "9111" model

Hayes Wang (2):
      r8152: fix the force speed doesn't work for RTL8156
      r8152: sync ocp base

Heiner Kallweit (1):
      igb: fix deadlock caused by taking RTNL in RPM resume path

Helge Deller (1):
      parisc: Clear stale IIR value on instruction access rights trap

Hoang Le (1):
      Revert "tipc: use consistent GFP flags"

Hugh Dickins (1):
      mm: delete unsafe BUG from page_cache_add_speculative()

Ignacy Gaw=C4=99dzki (1):
      netfilter: fix regression in looped (broad|multi)cast's MAC handling

Ismael Luceno (1):
      uapi: Fix undefined __always_inline on non-glibc systems

Jackie Liu (1):
      memblock: fix memblock_phys_alloc() section mismatch error

Jaroslav Kysela (1):
      ALSA: rawmidi - fix the uninitalized user_pversion

Jeff LaBundy (1):
      Input: iqs626a - prohibit inlining of channel parsing functions

Jens Axboe (1):
      io_uring: zero iocb->ki_pos for stream file types

Jens Wiklander (1):
      tee: handle lookup of shm with reference count 0

Jeremy Szu (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for a HP ProBook

Jernej Skrabec (1):
      bus: sunxi-rsb: Fix shutdown

Jeroen de Borst (1):
      gve: Correct order of processing device options

Jiacheng Shi (1):
      RDMA/hns: Replace kfree() with kvfree()

Jiasheng Jiang (7):
      qlcnic: potential dereference null pointer of rx_queue->page_ring
      HID: potential dereference of null pointer
      fjes: Check for error irq
      drivers: net: smc911x: Check for error irq
      net: ks8851: Check for error irq
      sfc: Check null pointer of rx_queue->page_ring
      sfc: falcon: Check null pointer of rx_queue->page_ring

Johan Hovold (1):
      platform/x86: intel_pmc_core: fix memleak on registration failure

Johannes Berg (1):
      mac80211: fix locking in ieee80211_start_ap error path

John David Anglin (2):
      parisc: Correct completer in lws start
      parisc: Fix mask used to select futex spinlock

Johnny Chuang (1):
      Input: elants_i2c - do not check Remark ID on eKTH3900/eKTH5312

Josh Poimboeuf (1):
      compiler.h: Fix annotation macro misplacement with Clang

Jos=C3=A9 Exp=C3=B3sito (3):
      Input: goodix - fix memory leak in goodix_firmware_upload
      Input: atmel_mxt_ts - fix double free in mxt_read_info_block
      IB/qib: Fix memory leak in qib_user_sdma_queue_pkts()

Juergen Gross (5):
      xen/blkfront: harden blkfront against event channel storms
      xen/netfront: harden netfront against event channel storms
      xen/console: harden hvc_xen against event channel storms
      xen/netback: fix rx queue stall detection
      xen/netback: don't queue unlimited number of packages

Kai Vehmanen (2):
      ASoC: SOF: Intel: pci-tgl: add ADL-N support
      ASoC: SOF: Intel: pci-tgl: add new ADL-P variant

Krzysztof Kozlowski (1):
      regulator: dt-bindings: samsung,s5m8767: add missing op_mode to bucks

Libin Yang (2):
      ALSA: hda: intel-sdw-acpi: harden detection of controller
      ALSA: hda: intel-sdw-acpi: go through HDAS ACPI at max depth of 2

Lin Ma (2):
      hamradio: improve the incomplete fix to avoid NPD
      ax25: NPD bug when detaching AX25 device

Linus Torvalds (1):
      Linux 5.16-rc7

Liu Shixin (1):
      mm/hwpoison: clear MF_COUNT_INCREASED before retrying get_any_page()

Maciej Fijalkowski (5):
      ice: xsk: return xsk buffers back to pool when cleaning the ring
      ice: xsk: allocate separate memory for XDP SW ring
      ice: xsk: do not clear status_error0 for ntu + nb_buffs descriptor
      ice: xsk: allow empty Rx descriptors on XSK ZC data path
      ice: xsk: fix cleaned_count setting

Marc Orr (1):
      KVM: x86: Always set kvm_run->if_flag

Marcos Del Sol Vives (1):
      ksmbd: disable SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1

Mario Limonciello (1):
      platform/x86: amd-pmc: only use callbacks for suspend

Martin Blumenstingl (3):
      ASoC: meson: aiu: fifo: Add missing dma_coerce_mask_and_coherent()
      ASoC: meson: aiu: Move AIU_I2S_MISC hold setting to aiu-fifo-i2s
      mmc: meson-mx-sdhc: Set MANUAL_STOP for multi-block SDIO commands

Martin Haa=C3=9F (1):
      ARM: dts: imx6qdl-wandboard: Fix Ethernet support

Martin Povi=C5=A1er (1):
      ASoC: tas2770: Fix setting of high sample rates

Masahiro Yamada (1):
      parisc: remove ARCH_DEFCONFIG

Matthew Brost (2):
      drm/i915/guc: Use correct context lock when callig clr_context_regist=
ered
      drm/i915/guc: Only assign guc_id.id when stealing guc_id

Mian Yousaf Kaukab (1):
      ipmi: ssif: initialize ssif_info->client early

Miaoqian Lin (1):
      platform/mellanox: mlxbf-pmc: Fix an IS_ERR() vs NULL bug in
mlxbf_pmc_map_counters

Mike Rapoport (1):
      x86/boot: Move EFI range reservation after cmdline parsing

Namjae Jeon (1):
      ksmbd: fix uninitialized symbol 'pntsd_size'

Naoya Horiguchi (1):
      mm, hwpoison: fix condition in free hugetlb page path

Nobuhiro Iwamatsu (1):
      net: stmmac: dwmac-visconti: Fix value of ETHER_CLK_SEL_FREQ_SEL_2P5M

Noralf Tr=C3=B8nnes (1):
      gpio: dln2: Fix interrupts when replugging the device

Paolo Abeni (1):
      veth: ensure skb entering GRO are not cloned.

Paul Blakey (3):
      net/sched: Extend qdisc control block with tc control block
      net/sched: flow_dissector: Fix matching on zone id for invalid conns
      net: openvswitch: Fix matching zone id for invalid conns arriving fro=
m tc

Pavel Skripkin (2):
      asix: fix uninit-value in asix_mdio_read()
      asix: fix wrong return value in asix_check_host_enable()

Phil Elwell (1):
      pinctrl: bcm2835: Change init order for gpio hogs

Philipp Rudo (1):
      kernel/crash_core: suppress unknown crashkernel parameter warning

Prathamesh Shete (1):
      mmc: sdhci-tegra: Fix switch to HS400ES mode

Rafael J. Wysocki (1):
      PM: sleep: Fix error handling in dpm_prepare()

Randy Dunlap (1):
      MAINTAINERS: mark more list instances as moderated

Remi Pommarel (1):
      net: bridge: fix ioctl old_deviceless bridge argument

Robert Marko (1):
      arm64: dts: allwinner: orangepi-zero-plus: fix PHY mode

R=C3=A9mi Denis-Courmont (1):
      phonet/pep: refuse to enable an unbound pipe

Samuel =C4=8Cavoj (1):
      Input: i8042 - enable deferred probe quirk for ASUS UM325UA

Sean Anderson (1):
      docs: networking: dpaa2: Fix DPNI header

Sean Christopherson (6):
      KVM: x86/mmu: Don't advance iterator after restart due to yielding
      KVM: VMX: Always clear vmx->fail on emulation_required
      KVM: nVMX: Synthesize TRIPLE_FAULT for L2 if emulation is required
      KVM: VMX: Fix stale docs for kvm-intel.emulate_invalid_guest_state
      KVM: selftests: Add test to verify TRIPLE_FAULT on invalid L2 guest s=
tate
      KVM: VMX: Wake vCPU when delivering posted IRQ even if vCPU =3D=3D th=
is vCPU

SeongJae Park (1):
      mm/damon/dbgfs: protect targets destructions with kdamond_lock

Sumit Garg (1):
      tee: optee: Fix incorrect page free bug

Takashi Iwai (1):
      Input: i8042 - add deferred probe support

Tetsuo Handa (1):
      tomoyo: use hwight16() in tomoyo_domain_quota_is_ok()

Thadeu Lima de Souza Cascardo (2):
      ipmi: bail out if init_srcu_struct fails
      ipmi: fix initialization when workqueue allocation fails

Thibaut Sautereau (1):
      mm/page_alloc: fix __alloc_size attribute for alloc_pages_exact_nid

Tim Crawford (1):
      platform/x86: system76_acpi: Guard System76 EC specific functionality

Ulf Hansson (1):
      mmc: core: Disable card detect during shutdown

Ville Syrj=C3=A4l=C3=A4 (1):
      ALSA: hda/hdmi: Disable silent stream on GLK

Vincent Whitchurch (1):
      gpio: virtio: remove timeout

Vladimir Murzin (1):
      ARM: 9160/1: NOMMU: Reload __secondary_data after PROCINFO_INITFUNC

Wang Qing (1):
      platform/x86: apple-gmux: use resource_size() with res

Wei Wang (1):
      KVM: x86: remove PMU FIXED_CTR3 from msrs_to_save_all

Werner Sembach (1):
      ALSA: hda/realtek: Fix quirk for Clevo NJ51CU

Willem de Bruijn (3):
      docs: networking: replace skb_hwtstamp_tx with skb_tstamp_tx
      net: accept UFOv6 packages in virtio_net_hdr_to_skb
      net: skip virtio_net_hdr_set_proto if protocol already set

Wu Bo (1):
      ipmi: Fix UAF when uninstall ipmi_si and ipmi_msghandler module

Xiang wangx (1):
      net: fix typo in a comment

Xiaoke Wang (1):
      ALSA: jack: Check the return value of kstrdup()

Xiaolei Wang (1):
      optee: Suppress false positive kmemleak report in optee_handle_rpc()

Xiaoliang Yang (2):
      net: dsa: tag_ocelot: use traffic class to map priority on injected h=
eader
      net: stmmac: ptp: fix potentially overflowing expression

Yangyang Li (1):
      RDMA/hns: Fix RNR retransmission issue for HIP08

Yann Gautier (1):
      mmc: mmci: stm32: clear DLYB_CR after sending tuning command

Yevhen Orlov (2):
      net: marvell: prestera: fix incorrect return of port_find
      net: marvell: prestera: fix incorrect structure access

Zhang Ying-22455 (1):
      arm64: dts: lx2160a: fix scl-gpios property name
