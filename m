Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F1F4B3D6D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbiBMU34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:29:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiBMU3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:29:55 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962D3532FA
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 12:29:47 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id z14so5694658lfu.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 12:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TTI4YmA7iALihIfPFZ5dE3BcPJlG8sKgSZ/cF4yb7ts=;
        b=S5Q9ys+m8FwAd4RQCvsIiLLAc1Nd8Q6pk/+dEriJpqxk9JG4vUhH8O6gExlu06RBBa
         rINp85JXxe7PcRoCOwamfSRZpAL2aCzicIKCpngleRzpB2TCoyOoWGQ8+HmMkB7wvY/1
         lbbifu7Q4EimdQkYKtwqSCF5MHRHpxgjueY+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TTI4YmA7iALihIfPFZ5dE3BcPJlG8sKgSZ/cF4yb7ts=;
        b=4ULjiUcnwvZL/3580dEqOLAF7I3xNvXBrbDhsnNlj/7Kqk+AzQFv1pMBmcqDp5aHW5
         TRA6i62BZvVGCOgq48MF5MOcuPFfEt/E3Ew8ytLPUWTjt9O5np71SngBQPrjamCa/f5v
         KtgS7FoHvC48OgUHY0DNhMtMjjjrnunLox0Ppa/ETNrSDfQ3/vArG70E0ObeXpTOtj3i
         WCSD6imcjZ6ixL6ruj8z5y2N5qGCkdGsyWqpJ+Dy8OzJgNqdt9Lwz6hZR3fq0xwcr95m
         lF1xfZtUH59tnnw0jSEXMjes+E33+y7uKDBLRVjOqpEk8Ornwh21bl7RYtc+mwalZL6X
         OK3Q==
X-Gm-Message-State: AOAM533IIhh4ZlwXQM5Pm350asztuK3XmnMvMsDO5XPrJVkCyMZ52Mfr
        KgdVOyW8whB8e31C4F+rlrwqY95ZQpngdIGb
X-Google-Smtp-Source: ABdhPJxIgXHcXrGiUKMn3bDCaqre4/XfB9PRhBOgQppZXamqF63Ei127AYwKSPhuR/iomoeFlfU9SQ==
X-Received: by 2002:a05:6512:2285:: with SMTP id f5mr3129967lfu.537.1644784185305;
        Sun, 13 Feb 2022 12:29:45 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id u27sm420998lfo.98.2022.02.13.12.29.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Feb 2022 12:29:44 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id c15so19598693ljf.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 12:29:44 -0800 (PST)
X-Received: by 2002:a05:651c:b23:: with SMTP id b35mr4123887ljr.358.1644784184224;
 Sun, 13 Feb 2022 12:29:44 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Feb 2022 12:29:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgpOhU0cU+KZHA86OsoN2BxqT4ZoTMYHDMuzbiiiKK1Eg@mail.gmail.com>
Message-ID: <CAHk-=wgpOhU0cU+KZHA86OsoN2BxqT4ZoTMYHDMuzbiiiKK1Eg@mail.gmail.com>
Subject: Linux 5.17-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things continue to look pretty normal for 5.17. Both the diffstat and
the number of commits looks pretty much average for an rc4 release.

About half the changes being to drivers (all over, but as usual gpu
and networking is a noticeable part of driver changes), with arch
updates showing up next (devicetree updates dominate, but there's
"real code" changes too).

Other than that, we've got filesystem fixes, core networking, tooling,
and misc core kernel fixlets.

The appended shortlog gives details as usual, nothing in here looks worriso=
me.

                  Linus

---

Aaron Liu (1):
      drm/amdgpu: add utcl2_harvest to gc 10.3.1

Adam Ford (1):
      usb: gadget: udc: renesas_usb3: Fix host to USB_ROLE_NONE transition

Akira Kawata (1):
      Documentation: KUnit: Fix usage bug

Al Cooper (2):
      phy: usb: Leave some clocks running during suspend
      phy: broadcom: Kconfig: Fix PHY_BRCM_USB config option

Alex Deucher (1):
      drm/amdgpu/display: change pipe policy for DCN 2.0

Alexander Stein (2):
      arm64: dts: freescale: Fix sound card model for MBa8Mx
      arm64: dts: imx8mq: fix lcdif port node

Alim Akhtar (1):
      MAINTAINERS: add reviewer entry for Samsung/Exynos platform

Alviro Iskandar Setiawan (1):
      io_uring: Clean up a false-positive warning from GCC 9.3.0

Andreas Gruenbacher (1):
      Revert "gfs2: check context in gfs2_glock_put"

Andrey Skvortsov (1):
      mmc: core: Wait for command setting 'Power Off Notification' bit
to complete

Andy Shevchenko (2):
      serial: 8250_pericom: Revert "Re-enable higher baud rates"
      gpiolib: Never return internal error codes to user space

Anna Schumaker (1):
      MAINTAINERS: Update my email address

Antoine Tenart (2):
      net: do not keep the dst cache when uncloning an skb dst and its meta=
data
      net: fix a memleak when uncloning an skb dst and its metadata

Arnd Bergmann (1):
      Revert "arm64: dts: imx8mn-venice-gw7902: disable gpu"

Aswath Govindraju (2):
      arm64: dts: ti: k3-j721s2: Move aliases to board dts
      arm64: dts: ti: k3-j721s2-common-proc-board: Alias console uart to se=
rial2

Aurelien Jarno (1):
      riscv: fix build with binutils 2.38

Axel Rasmussen (2):
      pidfd: fix test failure due to stack overflow on some arches
      selftests: fixup build warnings in pidfd / clone3 tests

Bartosz Golaszewski (1):
      gpio: sim: fix hogs with custom chip labels

Bean Huo (1):
      nvme: add nvme_complete_req tracepoint for batched completion

Benjamin Gaignard (1):
      MAINTAINERS: Update Benjamin Gaignard maintainer status

Bjorn Helgaas (1):
      Revert "PCI/portdrv: Do not setup up IRQs if there are no users"

Bob Peterson (1):
      gfs2: Fix gfs2_release for non-writers regression

Brenda Streiff (1):
      kconfig: let 'shell' return enough output for deep path names

Brian Norris (1):
      drm/rockchip: vop: Correct RK3399 VOP register fields

Cai Huoqing (2):
      net: ethernet: litex: Add the dependency on HAS_IOMEM
      xen/pci: Make use of the helper macro LIST_HEAD()

Cameron Williams (1):
      USB: serial: ftdi_sio: add support for Brainboxes US-159/235/320

Changbin Du (1):
      riscv: eliminate unreliable __builtin_frame_address(1)

Chia-Wei Wang (1):
      docs/ABI: testing: aspeed-uart-routing: Escape asterisk

Christian Borntraeger (1):
      MAINTAINERS: downgrade myself to Reviewer for s390

Christian Hewitt (3):
      arm64: dts: meson-gx: add ATF BL32 reserved-memory region
      arm64: dts: meson-g12: add ATF BL32 reserved-memory region
      arm64: dts: meson-g12: drop BL32 region from SEI510/SEI610

Christoph Niedermaier (1):
      drm/panel: simple: Assign data from panel_dpi_probe() correctly

Christophe JAILLET (1):
      optee: Use bitmap_free() to free bitmap

Chuck Lever (7):
      NFSD: Fix the behavior of READ near OFFSET_MAX
      NFSD: Fix ia_size underflow
      NFSD: Fix NFSv3 SETATTR/CREATE's handling of large file sizes
      NFSD: Clamp WRITE offsets
      NFSD: COMMIT operations must not return NFS?ERR_INVAL
      NFSD: Fix offset type in I/O trace points
      NFSD: Deprecate NFS_OFFSET_MAX

Colin Foster (1):
      net: mscc: ocelot: fix mutex lock error during ethtool stats read

Damien Le Moal (2):
      ata: libata-core: Fix ata_dev_config_cpr()
      ata: sata_fsl: fix sscanf() and sysfs_emit() format strings

Dan Aloni (1):
      xprtrdma: fix pointer derefs in error cases of rpcrdma_ep_create

Dan Carpenter (3):
      phy: cadence: Sierra: fix error handling bugs in probe()
      phy: stm32: fix a refcount leak in stm32_usbphyc_pll_enable()
      ice: fix an error code in ice_cfg_phy_fec()

Daniel Bristot de Oliveira (5):
      rtla: Follow kernel version
      rtla/utils: Fix session duration parsing
      rtla/trace: Error message fixup
      rtla: Fix segmentation fault when failing to enable -t
      MAINTAINERS: Add RTLA entry

Daniel Latypov (1):
      kunit: fix missing f in f-string in run_checks.py

Daniel Vetter (1):
      MAINTAINERS: Add entry for fbdev core

Dave Ertman (2):
      ice: Fix KASAN error in LAG NETDEV_UNREGISTER handler
      ice: Avoid RTNL lock when re-creating auxiliary device

Dave Stevenson (3):
      drm/vc4: hdmi: Ensure we don't use 2711 HPD registers on Pi0-3
      drm/vc4: hdmi: Don't try disabling SCDC on Pi0-3.
      drm/vc4: hdmi: Allow DBLCLK modes even if horz timing is odd.

Dmytro Laktyushkin (1):
      drm/amd/display: fix yellow carp wm clamping

Domenico Andreoli (1):
      Fix regression due to "fs: move binfmt_misc sysctl to its own file"

Dongjin Kim (2):
      arm64: dts: meson-g12b-odroid-n2: fix typo 'dio2133'
      arm64: dts: meson-sm1-bananapi-m5: fix wrong GPIO domain for GPIOE_2

Duoming Zhou (2):
      ax25: fix NPD bug in ax25_disconnect
      ax25: fix UAF bugs of net_device caused by rebinding operation

Eric Biggers (1):
      ima: fix reference leak in asymmetric_verify()

Eric Dumazet (5):
      tcp: take care of mixed splice()/sendmsg(MSG_ZEROCOPY) case
      net/smc: fix ref_tracker issue in smc_pnet_add()
      net/smc: use GFP_ATOMIC allocation in smc_pnet_add_eth()
      ipmr,ip6mr: acquire RTNL before calling ip[6]mr_free_table() on
failure path
      veth: fix races around rq->rx_notify_masked

Fabio Estevam (2):
      ARM: dts: imx6qdl-udoo: Properly describe the SD card detect
      ARM: dts: imx23-evk: Remove MX23_PAD_SSP1_DETECT from hog group

Fabio M. De Francesco (1):
      usb: core: Unregister device on component_add() failure

Fabrice Gasnier (1):
      usb: dwc2: drd: fix soft connect when gadget is unconfigured

Florian Westphal (6):
      netfilter: conntrack: don't refresh sctp entries in closed state
      netfilter: nft_payload: don't allow th access for fragments
      netfilter: conntrack: move synack init code to helper
      netfilter: conntrack: re-init state for retransmitted syn-ack
      MAINTAINERS: netfilter: update git links
      netfilter: ctnetlink: disable helper autoassign

Geert Uytterhoeven (2):
      gpio: aggregator: Fix calling into sleeping GPIO controllers
      arm64: Remove ARCH_VULCAN

Greg Kroah-Hartman (3):
      moxart: fix potential use-after-free on remove path
      usb: gadget: rndis: check size of RNDIS_MSG_SET command
      Revert "usb: dwc2: drd: fix soft connect when gadget is unconfigured"

Guo Ren (2):
      dt-bindings: update riscv plic compatible string
      irqchip/sifive-plic: Add missing thead,c900-plic match string

H. Nikolaus Schaller (1):
      MIPS: DTS: CI20: fix how ddc power is enabled

Hans de Goede (2):
      drm/privacy-screen: Fix sphinx warning
      x86/PCI: revert "Ignore E820 reservations for bridge windows on
newer systems"

Heiko Carstens (1):
      MAINTAINERS: add Alexander Gordeev as maintainer for s390

Helge Deller (1):
      fbcon: Avoid 'cap' set but not used warning

Herbert Xu (1):
      crypto: api - Move cryptomgr soft dependency into algapi

Hyunchul Lee (1):
      ksmbd: smbd: validate buffer descriptor structures

Ilya Leoshkevich (1):
      s390/module: fix building test_modules_helpers.o with clang

Jae Hyun Yoo (1):
      soc: aspeed: lpc-ctrl: Block error printing on probe defer cases

JaeSang Yoo (1):
      tracing: Fix tp_printk option related with tp_printk_stop_on_boot

Jakob Koschel (2):
      vt_ioctl: fix array_index_nospec in vt_setactivate
      vt_ioctl: add array_index_nospec to VT_ACTIVATE

James Smart (2):
      scsi: lpfc: Remove NVMe support if kernel has NVME_FC disabled
      scsi: lpfc: Reduce log messages seen after firmware download

Jan Beulich (1):
      xen/x86: obtain full video frame buffer address for Dom0 also under E=
FI

Janis Schoetterl-Glausch (1):
      KVM: s390: Return error on SIDA memop on normal guest

Jann Horn (2):
      usb: raw-gadget: fix handling of dual-direction-capable endpoints
      net: usb: ax88179_178a: Fix out-of-bounds accesses in RX fixup

Jayesh Choudhary (1):
      ARM: dts: am335x-wega: Fix typo in mcasp property rx-num-evt

Jens Wiklander (2):
      optee: add error checks in optee_ffa_do_call_with_arg()
      optee: use driver internal tee_context for some rpc

Jerome Forissier (1):
      tee: optee: do not check memref size on return from Secure World

Jesse Brandeburg (1):
      ice: fix IPIP and SIT TSO offload

Jiapeng Chong (1):
      xen/x2apic: Fix inconsistent indenting

Jiasheng Jiang (2):
      mmc: sdhci-of-esdhc: Check for error num after setting mask
      mmc: sh_mmcif: Check for null res pointer

Jing Leng (1):
      kconfig: fix failing to generate auto.conf

Jisheng Zhang (1):
      riscv: extable: fix err reg writing in dedicated uaccess handler

Joel Stanley (1):
      net: mdio: aspeed: Add missing MODULE_DEVICE_TABLE

Johan Hovold (2):
      USB: serial: cp210x: add NCR Retail IO box id
      USB: serial: cp210x: add CPI Bulk Coin Recycler id

Jon Maloy (2):
      tipc: rate limit warning for received illegal binding update
      tipc: improve size validations for received domain records

Jonas Malaco (1):
      eeprom: ee1004: limit i2c reads to I2C_SMBUS_BLOCK_MAX

Kees Cook (4):
      crypto: octeontx2 - Avoid stack variable overflow
      signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
      seccomp: Invalidate seccomp mode to catch death failures
      samples/seccomp: Adjust sample to also provide kill option

Kishen Maloor (1):
      mptcp: netlink: process IPv6 addrs in creating listening sockets

Kishon Vijay Abraham I (1):
      phy: ti: Fix missing sentinel for clk_div_table

Krzysztof Kozlowski (3):
      ARM: socfpga: fix missing RESET_CONTROLLER
      MAINTAINERS: arm: samsung: add Git tree and IRC
      MAINTAINERS: add IRC to ARM sub-architectures and Devicetree

Linus Torvalds (1):
      Linux 5.17-rc4

Linus Walleij (1):
      ARM: dts: Fix boot regression on Skomer

Liu Ying (1):
      phy: dphy: Correct clk_pre parameter

Louis Peens (1):
      nfp: flower: fix ida_idx not being released

Lucas De Marchi (1):
      drm/i915: Fix header test for !CONFIG_X86

Lutz Koschorreck (2):
      arm64: dts: meson-sm1-odroid: use correct enable-gpio pin for
tf-io regulator
      arm64: dts: meson-sm1-odroid: fix boot loop after reboot

Mahesh Bandewar (1):
      bonding: pair enable_port with slave_arr_updates

Marc St-Amand (1):
      net: macb: Align the dma and coherent dma masks

Marc Zyngier (1):
      irqchip/gic-v3-its: Skip HP notifier when no ITS is registered

Mario Limonciello (2):
      ACPI: PM: Revert "Only mark EC GPE for wakeup on Intel systems"
      display/amd: decrease message verbosity about watermarks table failur=
e

Mark Brown (1):
      arm64: Enable Cortex-A510 erratum 2051678 by default

Martin Blumenstingl (3):
      ARM: dts: meson: Fix the UART compatible strings
      ARM: dts: meson8: Fix the UART device-tree schema validation
      ARM: dts: meson8b: Fix the UART device-tree schema validation

Martin Kepplinger (2):
      arm64: dts: imx8mq: fix mipi_csi bidirectional port numbers
      arm64: dts: imx8mq-librem5: fix mipi_csi1 port number to sensor

Masahiro Yamada (1):
      kconfig: fix missing fclose() on error paths

Mathias Krause (2):
      misc: fastrpc: avoid double fput() on failed usercopy
      iio: buffer: Fix file related error handling in IIO_BUFFER_GET_FD_IOC=
TL

Matthieu Baerts (1):
      selftests: mptcp: add missing join check

Maxime Ripard (1):
      drm/vc4: crtc: Fix redundant variable assignment

Mel Gorman (1):
      mm: vmscan: remove deadlock due to throttling failing to make progres=
s

Michael Walle (2):
      arm64: dts: ls1028a: sl28: re-enable ftm_alarm0
      MAINTAINERS: add myself as a maintainer for the sl28cpld

Mike Rapoport (1):
      fs/binfmt_elf: fix PT_LOAD p_align values for loaders

Myrtle Shah (1):
      riscv: Fix XIP_FIXUP_FLASH_OFFSET

Namjae Jeon (5):
      ksmbd: fix SMB 3.11 posix extension mount failure
      ksmbd: fix same UniqueId for dot and dotdot entries
      ksmbd: don't align last entry offset in smb2 query directory
      ksmbd: reduce smb direct max read/write size
      ksmbd: add support for key exchange

Nathan Chancellor (1):
      Makefile.extrawarn: Move -Wunaligned-access to W=3D1

NeilBrown (1):
      SUNRPC: lock against ->sock changing during sysfs read

Nick Desaulniers (1):
      x86/bug: Merge annotate_reachable() into _BUG_FLAGS() asm

Niklas Cassel (1):
      gpio: sifive: use the correct register to read output values

Oliver Hartkopp (2):
      can: isotp: fix potential CAN frame reception race in isotp_rcv()
      can: isotp: fix error path in isotp_sendmsg() to unlock wait queue

Padmanabha Srinivasaiah (1):
      staging: vc04_services: Fix RCU dereference check

Palmer Dabbelt (2):
      riscv/mm: Add XIP_FIXUP for phys_ram_base
      riscv/mm: Add XIP_FIXUP for riscv_pfn_base

Paul Moore (1):
      audit: don't deref the syscall args when checking the openat2
open_how::flags

Pavel Hofman (1):
      usb: gadget: f_uac2: Define specific wTerminalType

Pavel Parkhomenko (2):
      net: phy: marvell: Fix MDI-x polarity setting in 88e1118-compatible P=
HYs
      net: phy: marvell: Fix RGMII Tx/Rx delays setting in
88e1121-compatible PHYs

Pawel Dembicki (1):
      USB: serial: option: add ZTE MF286D modem

Peng Liu (1):
      kfence: make test case compatible with run time set sample interval

Philippe Cornu (1):
      MAINTAINERS: update drm/stm drm/sti and cec/sti maintainers

Pingfan Liu (1):
      riscv: cpu-hotplug: clear cpu from numa map when teardown

Rafael J. Wysocki (2):
      ACPI: PM: s2idle: Cancel wakeup before dispatching EC GPE
      PM: s2idle: ACPI: Fix wakeup interrupts handling

Raju Rangoju (1):
      net: amd-xgbe: disable interrupts during pci removal

Reinette Chatre (1):
      x86/sgx: Silence softlockup detection when releasing large enclaves

Rob Herring (2):
      ARM: dts: imx7ulp: Fix 'assigned-clocks-parents' typo
      ARM: dts: spear320: Drop unused and undocumented 'irq-over-gpio' prop=
erty

Robert Hancock (2):
      phy: xilinx: zynqmp: Fix bus width setting for SGMII
      usb: dwc3: xilinx: fix uninitialized return value

Robert-Ionut Alexa (1):
      dpaa2-eth: unregister the netdev before disconnecting from the PHY

Roberto Sassu (1):
      ima: Allow template selection with ima_template[_fmt]=3D after ima_ha=
sh=3D

Robin Murphy (1):
      ACPI/IORT: Check node revision for PMCG resources

Roger Pau Monne (1):
      xen/x86: detect support for extended destination ID

Roman Gushchin (1):
      mm: memcg: synchronize objcg lists with a dedicated spinlock

Roman Li (1):
      drm/amd/display: Cap pflip irqs per max otg number

Sagi Grimberg (1):
      nvme-tcp: fix bogus request completion when failing to send AER

Sam Protsenko (1):
      soc: samsung: Fix typo in CONFIG_EXYNOS_USI description

Samuel Mendoza-Jonas (1):
      ixgbevf: Require large buffers for build_skb on 82599VF

Samuel Thibault (1):
      speakup-dectlk: Restore pitch setting

Sascha Hauer (1):
      drm/rockchip: dw_hdmi: Do not leave clock enabled in error case

Sean Anderson (2):
      usb: ulpi: Move of_node_put to ulpi_dev_release
      usb: ulpi: Call of_node_put correctly

Sean Young (1):
      selftests/ir: fix build with ancient kernel headers

Shakeel Butt (1):
      mm: io_uring: allow oom-killer from io_uring_setup

Shyam Prasad N (3):
      cifs: call cifs_reconnect when a connection is marked
      cifs: call helper functions for marking channels for reconnect
      cifs: mark sessions for reconnection in helper function

Slark Xiao (3):
      bus: mhi: pci_generic: Add mru_default for Foxconn SDX55
      bus: mhi: pci_generic: Add mru_default for Cinterion MV31-W
      net: usb: qmi_wwan: Add support for Dell DW5829e

Song Liu (1):
      perf: Fix list corruption in perf_cgroup_switch()

Steen Hegelund (1):
      net: sparx5: Fix get_stat64 crash in tcpdump

Stefan Berger (2):
      ima: Remove ima_policy file before directory
      ima: Do not print policy rule with inactive LSM labels

Stephan Brunner (1):
      USB: serial: ch341: add support for GW Instek USB2.0-Serial devices

Steve French (1):
      [smb3] improve error message when mount options conflict with posix

Sukadev Bhattiprolu (1):
      ibmvnic: don't release napi in __ibmvnic_open()

Sven Peter (1):
      MAINTAINERS: Add Apple watchdog to ARM/APPLE MACHINE SUPPORT

Szymon Heidrich (1):
      USB: gadget: validate interface OS descriptor requests

TATSUKAWA KOSUKE (=E7=AB=8B=E5=B7=9D =E6=B1=9F=E4=BB=8B) (1):
      n_tty: wake up poll(POLLRDNORM) on receiving data

Tadeusz Struk (1):
      sched/fair: Fix fault in reweight_entity

Tao Liu (1):
      gve: Recording rx queue before sending to napi

Tetsuo Handa (1):
      loop: revert "make autoclear operation asynchronous"

Thomas Hellstr=C3=B6m (1):
      drm/i915/ttm: Return some errors instead of trying memcpy move

Tim Harvey (1):
      arm64: dts: imx8mn-venice-gw7902: disable gpu

Tom Rix (1):
      skbuff: cleanup double word in comment

Tommaso Merciai (1):
      usb: usb251xb: add boost-up property support

Tony Lindgren (3):
      ARM: dts: Fix timer regression for beagleboard revision c
      clk: ti: Move dra7 clock devices out of the legacy section
      ARM: dts: Don't use legacy clock defines for dra7 clkctrl

Trond Myklebust (2):
      NFS: Avoid duplicate uncached readdir calls on eof
      NFS: Fix initialisation of nfs_client cl_flags field

Udipto Goswami (2):
      usb: f_fs: Fix use-after-free for epfile
      usb: dwc3: gadget: Prevent core from processing stale TRBs

Uwe Kleine-K=C3=B6nig (1):
      staging: fbtft: Fix error path in fbtft_driver_module_init()

Victor Erminpour (1):
      net: mpls: Fix GCC 12 warning

Ville Syrj=C3=A4l=C3=A4 (5):
      drm/i915: Fix oops due to missing stack depot
      drm/i915: Disable DRRS on IVB/HSW port !=3D A
      drm/i915: Allow !join_mbus cases for adlp+ dbuf configuration
      drm/i915: Populate pipe dbuf slices more accurately during readout
      drm/i915: Workaround broken BIOS DBUF configuration on TGL/RKL

Vineeth Vijayan (1):
      s390/cio: verify the driver availability for path_event call

Vladimir Oltean (10):
      net: mscc: ocelot: fix all IP traffic getting trapped to CPU
with PTP over IP
      net: dsa: mv88e6xxx: don't use devres for mdiobus
      net: dsa: ar9331: register the mdiobus under devres
      net: dsa: bcm_sf2: don't use devres for mdiobus
      net: dsa: felix: don't use devres for mdiobus
      net: dsa: seville: register the mdiobus under devres
      net: dsa: mt7530: fix kernel bug in mdiobus_free() when unbinding
      net: dsa: lantiq_gswip: don't use devres for mdiobus
      net: dsa: fix panic when DSA master device unbinds on shutdown
      net: dsa: mv88e6xxx: fix use-after-free in mv88e6xxx_mdios_unregister

Wan Jiabing (2):
      ARM: OMAP2+: hwmod: Add of_node_put() before break
      phy: phy-mtk-tphy: Fix duplicated argument in phy-mtk-tphy

Xiaoke Wang (1):
      integrity: check the return value of audit_log_start()

Xin Long (2):
      vlan: introduce vlan_dev_free_egress_priority
      vlan: move dev_put into vlan_dev_uninit

Yang Li (1):
      NFS: Fix nfs4_proc_get_locations() kernel-doc comment

Yang Shi (1):
      fs/proc: task_mmu.c: don't read mapcount for migration entry

Yang Wang (1):
      drm/amd/pm: fix hwmon node of power1_label create issue

Ye Guojin (1):
      ARM: OMAP2+: adjust the location of put_device() call in omapdss_init=
_of

Yizhuo Zhai (1):
      fbdev: fbmem: Fix the implicit type casting

Zhan Liu (1):
      drm/amd/display: keep eDP Vdd on when eDP stream is already enabled

Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi (1):
      ata: libata-core: Disable TRIM on M88V29

trondmy@kernel.org (2):
      NFS: Don't overfill uncached readdir pages
      NFS: Don't skip directory entries when doing uncached readdir
