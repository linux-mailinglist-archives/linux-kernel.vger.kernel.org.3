Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03794B427D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbiBNHGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:06:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiBNHGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:06:51 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1BB57B3D;
        Sun, 13 Feb 2022 23:06:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JxwJ06Jt3z4xmx;
        Mon, 14 Feb 2022 18:06:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644822401;
        bh=+RnnECD0Z+8ZEGBHDNqByTcot5oACUGx7BkMcetGFWA=;
        h=Date:From:To:Cc:Subject:From;
        b=J0PHMzSk8v8gCgTdlLdDDEh46BJ0Nx1cqPvjPoaij361yhFQSPkqpRfioxYMV9i10
         3sDLvJGcNS7+ovBHQipGs5Ak7KGU2Qxb4Dvvf418QVl0mNiRtrg6cArZ18gFVKRxZ+
         VJgvAVWUSdwZk/Eiv59hCDqYKFk34cVvDPIxCsjWXGnpioPeAiaHQzsNh1Sc/sKuqF
         U4rTk1ERNT4T8hSsGMgML/PbW8MtWhqsAz++JSBFR+mgWOJZBFm3A5faxyRD5tJdcn
         z//hLBglTT482p7sKe9q7rpR9eq4mISc4eL1Zf04abxZgDszygiXfPW7FrDXdeJ5wJ
         ilK0/hLJSY2nA==
Date:   Mon, 14 Feb 2022 18:06:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 14
Message-ID: <20220214180640.1dcbdcd4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RDI/Ik=Sj=efgD.A=zTKLEZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RDI/Ik=Sj=efgD.A=zTKLEZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220211:

Removed tree: drm-intel-gt - too many ongoing conflicts against the
	drm-intel tree

The qcom tree gained conflicts against the imx-mxs tree.

The btrfs tree lost its build failure.

The net-next tree lost its build failures.

The bpf-next tree lost its build failure.

The block tree gained a conflict against the fscrypt tree.

The driver-core tree gained a conflict against the battery tree.

The scsi-mkp tree gained a conflict against Linus' tree.

The folio tree still had its build failure so I used the version from
next-20220204.

The akpm-current tree gained a build failure for which I applied a patch.

Non-merge commits (relative to Linus' tree): 5103
 5522 files changed, 219762 insertions(+), 83806 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There are also quilt-import.log and merge.log
files in the Next directory.  Between each merge, the tree was built
with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf. After
the final fixups (if any), I do an x86_64 modules_install followed by
builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386,
arm64, sparc and sparc64 defconfig and htmldocs. And finally, a simple
boot test of the powerpc pseries_le_defconfig kernel in qemu (with and
without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 344 trees (counting Linus' and 93 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.

--=20
Cheers,
Stephen Rothwell

$ git checkout master
$ git reset --hard stable
Merging origin/master (754e0b0e3560 Linux 5.17-rc4)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (1b9e740a81f9 kconfig: fix failing to generate=
 auto.conf)
Merging arc-current/for-curr (f982d9b7c628 arc: remove set_fs())
Merging arm-current/fixes (9f80ccda53b9 ARM: 9180/1: Thumb2: align ALT_UP()=
 sections in modules sufficiently)
Merging arm64-fixes/for-next/fixes (da5fb9e1ad3f ACPI/IORT: Check node revi=
sion for PMCG resources)
Merging arm-soc-fixes/arm/fixes (5e5eddd94c89 Revert "arm64: dts: imx8mn-ve=
nice-gw7902: disable gpu")
Merging drivers-memory-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging tee-fixes/fixes (7e3c6eb44c91 Merge tags 'optee-fixes-for-v5.17' an=
d 'optee-fix-for-v5.17' into fixes)
Merging m68k-current/for-linus (1a0ae068bf6b m68k: defconfig: Update defcon=
figs for v5.16-rc1)
Merging powerpc-fixes/fixes (9bb162fa26ed powerpc/603: Fix boot failure wit=
h DEBUG_PAGEALLOC and KFENCE)
Merging s390-fixes/fixes (dd9cb842fa9d s390/cio: verify the driver availabi=
lity for path_event call)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (143de8d97d79 tipc: fix a bit overflow in tipc_crypto_ke=
y_rcv())
Merging bpf/master (3df9d803163e Merge branch 'bpf: fix a bpf_timer initial=
ization issue')
Merging ipsec/master (7c76ecd9c99b xfrm: enforce validity of offload input =
flags)
Merging netfilter/master (59085208e4a2 net: mscc: ocelot: fix all IP traffi=
c getting trapped to CPU with PTP over IP)
Merging ipvs/master (59085208e4a2 net: mscc: ocelot: fix all IP traffic get=
ting trapped to CPU with PTP over IP)
Merging wireless/main (bf8e59fd315f atl1c: fix tx timeout after link flap o=
n Mikrotik 10/25G NIC)
Merging rdma-fixes/for-rc (dfd42facf1e4 Linux 5.17-rc3)
Merging sound-current/for-linus (3e16dc50d77d ALSA: memalloc: invalidate SG=
 pages before sync)
Merging sound-asoc-fixes/for-linus (a887f9c7a4d3 ASoC: wm_adsp: Correct con=
trol read size when parsing compressed buffer)
Merging regmap-fixes/for-linus (b56a7cbf40c8 regmap: debugfs: Fix indentati=
on)
Merging regulator-fixes/for-linus (1aa6a7957230 Merge remote-tracking branc=
h 'regulator/for-5.16' into regulator-linus)
Merging spi-fixes/for-linus (46c22c5279f7 Merge remote-tracking branch 'spi=
/for-5.16' into spi-linus)
Merging pci-current/for-linus (075b7d363c67 Revert "PCI/portdrv: Do not set=
up up IRQs if there are no users")
Merging driver-core.current/driver-core-linus (e783362eb54c Linux 5.17-rc1)
Merging tty.current/tty-linus (28cb138f559f vt_ioctl: add array_index_nospe=
c to VT_ACTIVATE)
Merging usb.current/usb-linus (736e8d89044c Revert "usb: dwc2: drd: fix sof=
t connect when gadget is unconfigured")
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (6ca0c6283340 USB: serial: cp210x: add C=
PI Bulk Coin Recycler id)
Merging usb-chipidea-fixes/for-usb-fixes (f130d08a8d79 usb: chipidea: ci_hd=
rc_imx: Also search for 'phys' phandle)
CONFLICT (content): Merge conflict in drivers/usb/chipidea/ci_hdrc_imx.c
Merging phy/fixes (9a8406ba1a9a phy: dphy: Correct clk_pre parameter)
Merging staging.current/staging-linus (b81b1829e7e3 Merge tag 'scsi-fixes' =
of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging iio-fixes/fixes-togreg (ea85bf906466 iio: imu: st_lsm6dsx: wait for=
 settling time in st_lsm6dsx_read_oneshot)
Merging char-misc.current/char-misc-linus (c72ea2050361 iio: buffer: Fix fi=
le related error handling in IIO_BUFFER_GET_FD_IOCTL)
Merging soundwire-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging thunderbolt-fixes/fixes (dfd42facf1e4 Linux 5.17-rc3)
Merging input-current/for-linus (762f99f4f3cb Merge branch 'next' into for-=
linus)
Merging crypto-current/master (c6ce9c5831ca crypto: api - Move cryptomgr so=
ft dependency into algapi)
Merging vfio-fixes/for-linus (8704e8934908 vfio/pci: Fix OpRegion read)
Merging kselftest-fixes/fixes (a7e793a867ae selftests/exec: Add non-regular=
 to TEST_GEN_PROGS)
Merging modules-fixes/modules-linus (2a987e65025e Merge tag 'perf-tools-fix=
es-for-v5.16-2021-12-07' of git://git.kernel.org/pub/scm/linux/kernel/git/a=
cme/linux)
Merging dmaengine-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (36415a796471 mtd: rawnand: brcmnand: Fixed inc=
orrect sub-page ECC status)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (d40f0b133b44 media: meson-ir-tx: remove incorr=
ect doc comment)
Merging reset-fixes/reset/fixes (92c959bae2e5 reset: renesas: Fix Runtime P=
M usage)
Merging mips-fixes/mips-fixes (d9565bf40da2 MIPS: DTS: CI20: fix how ddc po=
wer is enabled)
Merging at91-fixes/at91-fixes (26077968f838 dt-bindings: ARM: at91: update =
maintainers entry)
Merging omap-fixes/fixes (80d680fdccba ARM: dts: omap3430-sdp: Fix NAND dev=
ice node)
Merging kvm-fixes/master (66fa226c131f KVM: SVM: fix race between interrupt=
 delivery and AVIC inhibition)
Merging kvms390-fixes/master (0e9ff65f455d KVM: s390: preserve deliverable_=
mask in __airqs_kick_single_vcpu)
Merging hwmon-fixes/hwmon (bb9bb9c75482 hwmon: (ntc_thermistor) Underscore =
Samsung thermistor)
Merging nvdimm-fixes/libnvdimm-fixes (3dd60fb9d95d nvdimm/pmem: stop using =
q_usage_count as external pgmap refcount)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (1af5bc8a7fbe Merge branch 'misc-5.17' into =
next-fixes)
Merging vfs-fixes/fixes (25f54d08f12f autofs: fix wait name hash calculatio=
n in autofs_wait())
Merging dma-mapping-fixes/for-linus (18a3c5f7abfd Merge tag 'for_linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (e3d13da7f77d platform/x86: asus-wmi: Fix r=
egression when probing for fan curve control)
Merging samsung-krzk-fixes/fixes (442b0c08db7e soc: samsung: Fix typo in CO=
NFIG_EXYNOS_USI description)
Merging pinctrl-samsung-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging devicetree-fixes/dt/linus (fa4300f060e5 of: unittest: update text o=
f expected warnings)
Merging scsi-fixes/fixes (f10f582d2822 scsi: qedi: Fix ABBA deadlock in qed=
i_process_tmf_resp() and qedi_process_cmd_cleanup_resp())
Merging drm-fixes/drm-fixes (95e875bdb186 Merge tag 'amd-drm-fixes-5.17-202=
2-02-09' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (4e6f55120c7e drm/i915: Workar=
ound broken BIOS DBUF configuration on TGL/RKL)
Merging mmc-fixes/fixes (54309fde1a35 mmc: block: fix read single on recove=
ry logic)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (e783362eb54c Linux 5.17-rc1)
Merging hyperv-fixes/hyperv-fixes (ffc58bc4af93 Drivers: hv: utils: Make us=
e of the helper macro LIST_HEAD())
Merging soc-fsl-fixes/fix (8120bd469f55 soc: fsl: dpaa2-console: free buffe=
r before returning from dpaa2_console_read)
Merging risc-v-fixes/fixes (6df2a016c0c8 riscv: fix build with binutils 2.3=
8)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (8bb7eca972ad Linux 5.15)
Merging spdx/spdx-linus (e783362eb54c Linux 5.17-rc1)
Merging gpio-brgl-fixes/gpio/for-current (c162ca0bcbfb gpio: sim: fix hogs =
with custom chip labels)
Merging gpio-intel-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging pinctrl-intel-fixes/fixes (500c77eed0fe pinctrl: zynqmp: Revert "Un=
ify pin naming")
Merging erofs-fixes/fixes (24331050a3e6 erofs: fix small compressed files i=
nlining)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (92a68053c346 Documentation: KUnit: Fix usa=
ge bug)
Merging ubifs-fixes/fixes (c3c07fc25f37 ubi: fastmap: Return error code if =
memory allocation fails in add_aeb())
Merging memblock-fixes/fixes (d7f55471db27 memblock: fix memblock_phys_allo=
c() section mismatch error)
Merging cel-fixes/for-rc (c306d737691e NFSD: Deprecate NFS_OFFSET_MAX)
Merging irqchip-fixes/irq/irqchip-fixes (1d4df649cbb4 irqchip/sifive-plic: =
Add missing thead,c900-plic match string)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (dfd42facf1e4 Linux 5.17-rc3)
Merging efi-fixes/urgent (f5390cd0b43c efi: runtime: avoid EFIv2 runtime se=
rvices on Apple x86 machines)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging drm-misc-fixes/for-linux-next-fixes (59f39bfa6553 drm/cma-helper: S=
et VM_DONTEXPAND for mmap)
Merging kspp/for-next/kspp (3803ad40e73c Merge branch 'for-next/hardening' =
into for-next/kspp)
Merging kspp-gustavo/for-next/kspp (26291c54e111 Linux 5.17-rc2)
Merging kbuild/for-next (c6553cd5dec6 usr/include/Makefile: add linux/nfc.h=
 to the compile-test coverage)
Merging perf/perf/core (bcaf0a97858d perf namespaces: Add functions to acce=
ss nsinfo)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (e62c17f0455a MAINTAINERS: update maintainer l=
ist of DMA MAPPING BENCHMARK)
Merging asm-generic/master (733e417518a6 asm-generic/error-injection.h: fix=
 a spelling mistake, and a coding style issue)
Merging arc/for-next (6880fa6c5660 Linux 5.15-rc1)
Merging arm/for-next (ed43eed0a6ac Merge branch 'devel-stable' into for-nex=
t)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
Merging arm64/for-next/core (bb425a759847 arm64: mm: apply __ro_after_init =
to memory_limit)
Merging arm-perf/for-next/perf (602c873eb52e perf: Replace acpi_bus_get_dev=
ice())
Merging arm-soc/for-next (4a64f2d3527a MAINTAINERS: add myself as a maintai=
ner for the sl28cpld)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (2c420d79dae4 arm64: dts: meson-g12-common: add ua=
rt_ao_b pins muxing)
Merging aspeed/for-next (a7e02e92755c Merge branches 'dt-for-v5.17', 'defco=
nfig-for-v5.17' and 'soc-for-v5.17' into for-next)
Merging at91/at91-next (9be3df0e718c Merge branch 'at91-defconfig' into at9=
1-next)
Merging drivers-memory/for-next (b7c3f95f32e0 Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (551c8a926246 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (896f47a2c39c Merge branch 'v5.17-next/dts64' int=
o for-next)
Merging mvebu/for-next (fecc54c7ccfe Merge branch 'mvebu/arm' into mvebu/fo=
r-next)
Merging omap/for-next (61b6b9cfada4 Merge branch 'omap-for-v5.17/fixes-not-=
urgent' into for-next)
Merging qcom/for-next (a457d40e1b5c Merge branches 'arm64-defconfig-for-5.1=
8', 'arm64-for-5.18', 'clk-for-5.18', 'drivers-for-5.18', 'dts-for-5.18', '=
arm64-fixes-for-5.17' and 'dts-fixes-for-5.17' into for-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (65a3b7e58076 Merge branches 'renesas-arm-dt-for-v5.18=
' and 'renesas-drivers-for-v5.18' into renesas-next)
Merging reset/reset/next (89e7a6698fdd reset: uniphier-glue: Use devm_add_a=
ction_or_reset())
Merging rockchip/for-next (390ab8960817 Merge branch 'v5.17-armsoc/dtsfixes=
' into for-next)
Merging samsung-krzk/for-next (9f6408ce5dfa Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (070292540812 Merge branch 'for-next/scmi/fixes=
' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into =
for-linux-next)
Merging stm32/stm32-next (59bb54bca1f5 ARM: dts: stm32: use exti 19 as main=
 interrupt to support RTC wakeup on stm32mp157)
Merging sunxi/sunxi/for-next (d7ab185b353f Merge branch 'sunxi/dt-for-5.18'=
 into sunxi/for-next)
Merging tee/next (ce352be35ba0 Merge branch 'async_notif' into next)
Merging tegra/for-next (33e9d249ce3e Merge branch for-5.18/arm64/dt into fo=
r-next)
Merging ti/ti-next (3be5bf60d055 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (3a14f0e61408 arm64: zynqmp: Rename dma to dma-cont=
roller)
Merging clk/clk-next (28c7bbb2a3fc Merge branch 'clk-kunit' into clk-next)
Merging clk-imx/for-next (036a4b4b4dfa clk: imx: Add imx8dxl clk driver)
Merging clk-renesas/renesas-clk (a1bcf50a99dd clk: renesas: rzg2l-cpg: Add =
support for RZ/V2L SoC)
Merging clk-samsung/for-next (45bd8166a1d8 clk: samsung: Add initial Exynos=
7885 clock driver)
Merging csky/linux-next (a0793fdad9a1 csky: fix typo of fpu config macro)
Merging h8300/h8300-next (1ec10274d436 h8300: don't implement set_fs)
Merging m68k/for-next (469d56485c1b m68k: mm: Remove check for VM_IO to fix=
 deferred I/O)
Merging m68knommu/for-next (021ff8547d2a m68k: m5441x: remove erroneous clo=
ck disable)
Merging microblaze/next (fcc619621df5 microblaze/PCI: Remove pci_phys_mem_a=
ccess_prot() dead code)
Merging mips/mips-next (c47c7ab9b536 MIPS: Malta: Enable BLK_DEV_INITRD)
Merging nds32/next (07cd7745c6f2 nds32/setup: remove unused memblock_region=
 variable in setup_memory())
CONFLICT (content): Merge conflict in arch/nds32/Kbuild
CONFLICT (content): Merge conflict in arch/nds32/Kconfig
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (f4f4d0fba0c5 openrisc: remove CONFIG_SET_FS)
Merging parisc-hd/for-next (517709293b5c parisc: Fix some apparent put_user=
() failures)
Merging powerpc/next (5a72345e6a78 powerpc: Fix STACKTRACE=3Dn build)
Merging soc-fsl/next (1ce93cb102e7 soc: fsl: qe: Check of ioremap return va=
lue)
Merging risc-v/for-next (e783362eb54c Linux 5.17-rc1)
Merging s390/for-next (00abcf534675 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (db0dd9cee822 um: virtio_uml: Allow probing from dev=
icetree)
Merging xtensa/xtensa-for-next (8a900dc390da xtensa: Remove unused early_re=
ad_config_byte() et al declarations)
Merging pidfd/for-next (fdc787974c13 fs: clean up mount_setattr control flo=
w)
Merging fscrypt/master (cdaa1b1941f6 fscrypt: update documentation for dire=
ct I/O support)
Merging fscache/fscache-next (dd81e1c7d5fb Merge tag 'powerpc-5.17-2' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (57b409a8644b Merge branch 'for-next-next-v5.17-2022=
0211' into for-next-20220211)
Merging ceph/master (038b8d1d1ab1 libceph: optionally use bounce buffer on =
recv path in crc mode)
Merging cifs/for-next (3d6cc9898efd cifs: fix double free race when mount f=
ails in cifs_get_root())
Merging configfs/for-next (c42dd069be8d configfs: fix a race in configfs_lo=
okup())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (dfd42facf1e4 Linux 5.17-rc3)
Merging exfat/dev (dd81e1c7d5fb Merge tag 'powerpc-5.17-2' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging ext3/for_next (ee12595147ac fanotify: Fix stale file descriptor in =
copy_event_to_user())
Merging ext4/dev (dfd42facf1e4 Linux 5.17-rc3)
Merging f2fs/dev (2df83a0575ff f2fs: avoid an infinite loop in f2fs_sync_di=
rty_inodes)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (073c3ab6ae01 Documentation/filesystem/dax: DAX on vi=
rtiofs)
Merging gfs2/for-next (224b28edd00e gfs2: Initialize gh_error in gfs2_glock=
_nq)
Merging jfs/jfs-next (c48a14dca2cb JFS: fix memleak in jfs_mount)
Merging ksmbd/ksmbd-for-next (1a927cda94ac Documentation: ksmbd: update Fea=
ture Status table)
Merging nfs/linux-next (754e0b0e3560 Linux 5.17-rc4)
Merging nfs-anna/linux-next (b49ea673e119 SUNRPC: lock against ->sock chang=
ing during sysfs read)
Merging nfsd/for-next (8dfa08baad02 SUNRPC: Record endpoint information in =
trace log)
Merging ntfs3/master (52e00ea6b26e fs/ntfs3: Update valid size if -EIOCBQUE=
UED)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (94fd19752b28 ovl: don't fail copy up if n=
o fileattr support on upper)
Merging ubifs/next (aa39cc675799 jffs2: GC deadlock reading a page that is =
used in jffs2_write_begin())
Merging v9fs/9p-next (22e424feb665 Revert "fs/9p: search open fids first")
Merging xfs/for-next (b97cca3ba909 xfs: only bother with sync_filesystem du=
ring readonly remount)
Merging zonefs/for-next (95b115332a83 zonefs: remove redundant null bio che=
ck)
Merging iomap/iomap-for-next (ebb7fb1557b1 xfs, iomap: limit individual ioe=
nd chain lengths in writeback)
Merging djw-vfs/vfs-for-next (2d86293c7075 xfs: return errors in xfs_fs_syn=
c_fs)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (8f40da9494cf Merge branch 'misc.namei' into for-next)
Merging printk/for-next (14f71764c260 Merge branch 'for-5.18' into for-next)
Merging pci/next (e783362eb54c Linux 5.17-rc1)
Merging pstore/for-next/pstore (a5d05b07961a pstore/ftrace: Allow immediate=
 recording)
Merging hid/for-next (2b3566c337c3 Merge branch 'for-5.17/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (5df51bacc41d Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (13462ba1815d i3c: master: dw: check return of dw_i3c_=
master_get_free_pos())
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (cf7ff6f04130 hwmon: (asus-ec-sensors) add=
 CPU core voltage)
Merging jc_docs/docs-next (27df960cd5e5 Merge branch 'docs-fixes' into docs=
-next)
Merging v4l-dvb/master (68a99f6a0ebf media: lirc: report ir receiver overfl=
ow)
Merging v4l-dvb-next/master (127efdbc51fe media: atomisp: fix dummy_ptr che=
ck to avoid duplicate active_bo)
Merging pm/linux-next (9b044ca4ac33 Merge branch 'thermal-hfi' into linux-n=
ext)
Merging cpufreq-arm/cpufreq/arm/linux-next (ec1c7ad47664 cpufreq: CPPC: Fix=
 performance/frequency conversion)
Merging cpupower/cpupower (101025ff8e47 tools/power/cpupower/{ToDo =3D> TOD=
O}: Rename the todo file)
Merging devfreq/devfreq-next (26291c54e111 Linux 5.17-rc2)
Merging opp/opp/linux-next (021dbecabc93 opp: Expose of-node's name in debu=
gfs)
Merging thermal/thermal/linux-next (8ee1c0f6526c thermal/drivers/rz2gl: Add=
 error check for reset_control_deassert())
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (feae43f8aa88 fs: dlm: print cluster addr if non-cluster n=
ode connects)
Merging rdma/for-next (2f1b2820b546 Merge branch 'irdma_dscp' into rdma.git=
 for-next)
Merging net-next/master (867b1db874c9 net: lan966x: Fix when CONFIG_IPV6 is=
 not set)
Merging bpf-next/for-next (9c3de619e13e libbpf: Use dynamically allocated b=
uffer when receiving netlink messages)
Merging ipsec-next/master (2ecda181682e xfrm: delete duplicated functions t=
hat calls same xfrm_api_check())
Merging mlx5-next/mlx5-next (cac3231cc684 mlx5: remove usused static inline=
s)
Merging netfilter-next/master (c828414ac935 netfilter: nft_compat: suppress=
 comment match)
Merging ipvs-next/master (c828414ac935 netfilter: nft_compat: suppress comm=
ent match)
Merging bluetooth/master (9b9f89c60d64 Bluetooth: btusb: add support for LG=
 LGSBWAC02 (MT7663BUN))
Merging wireless-next/main (b96a79253fff Merge tag 'wireless-next-2022-02-1=
1' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next)
Merging mtd/mtd/next (ad5e35f58384 mtd: Replace the expert mode symbols wit=
h a single helper)
Merging nand/nand/next (8cba323437a4 mtd: rawnand: protect access to rawnan=
d devices while in suspend)
Merging spi-nor/spi-nor/next (e783362eb54c Linux 5.17-rc1)
Merging crypto/master (a69cb445f7d1 crypto: arm/xor - make vectorized C cod=
e Clang-friendly)
Merging drm/drm-next (e7a09cea6483 Merge tag 'drm-intel-next-2022-02-08' of=
 git://anongit.freedesktop.org/drm/drm-intel into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_reg.h
Merging drm-misc/for-linux-next (d3cbc6e323c9 drm: panel-orientation-quirks=
: Add quirk for the 1Netbook OneXPlayer)
Merging amdgpu/drm-next (9d6fb14c4697 drm/amdgpu/smu11.5: restore cclks in =
vangogh_set_performance_level)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_drv=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/core/d=
c_link_dp.c
Merging drm-intel/for-linux-next (02cae05ec4b6 drm/i915: Nuke some dead cod=
e)
CONFLICT (content): Merge conflict in drivers/gpu/drm/dp/drm_dp.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_module.c
Merging drm-tegra/drm/tegra/for-next (22d7ee32f1fb gpu: host1x: Fix hang on=
 Tegra186+)
Merging drm-msm/msm-next (6aa89ae1fb04 drm/msm/gpu: Cancel idle/boost work =
on suspend)
Merging imx-drm/imx-drm/next (20fbfc81e390 drm/imx: imx-tve: Make use of th=
e helper function devm_platform_ioremap_resource())
Merging etnaviv/etnaviv/next (cdd156955f94 drm/etnaviv: consider completed =
fence seqno in hang check)
Merging fbdev/for-next (81a998288956 video: fbdev: udlfb: replace snprintf =
in show functions with sysfs_emit)
Merging regmap/for-next (1056c41634d4 regmap-irq: Fix typo in comment)
Merging sound/for-next (bad03efd11df ALSA: cleanup double word in comment)
Merging sound-asoc/for-next (9193bc0558d1 ASoC: tlv320adc3xxx: Add IIR filt=
er configuration)
Merging modules/modules-next (a97ac8cb24a3 module: fix signature check fail=
ures when using in-kernel decompression)
Merging input/next (994673dc6657 Input: mtk-pmic-keys - add support for MT6=
358)
CONFLICT (content): Merge conflict in drivers/input/misc/axp20x-pek.c
Merging block/for-next (9c63ffcf4786 Merge branch 'for-5.18/drivers' into f=
or-next)
CONFLICT (content): Merge conflict in fs/iomap/direct-io.c
Merging device-mapper/for-next (4e709cf0d225 dm: reduce dm_target_io struct=
 by 8 bytes)
Merging libata/for-next (d71c02b0caef pata_mpc52xx: use GFP_KERNEL)
Merging pcmcia/pcmcia-next (3928cf08334e pcmcia: db1xxx_ss: restrict to MIP=
S_DB1XXX boards)
Merging mmc/next (7fd1f3ba20b7 mmc: core: use sysfs_emit() instead of sprin=
tf())
Merging mfd/for-mfd-next (9cb74781a436 mfd: intel_soc_pmic_crc: Set main IR=
Q domain bus token to DOMAIN_BUS_NEXUS)
Merging backlight/for-backlight-next (ec961cf32411 backlight: qcom-wled: Re=
spect enabled-strings in set_brightness)
Merging battery/for-next (5ac121b81b40 power: supply: axp288-charger: Set V=
hold to 4.4V)
Merging regulator/for-next (e2a01b4e8806 regulator: Add support for TPS6286=
x)
Merging security/next-testing (047843bdb316 Merge branch 'landlock_lsm_v34'=
 into next-testing)
Merging apparmor/apparmor-next (364bd29902ae apparmor: Fix some kernel-doc =
comments)
Merging integrity/next-integrity (e27cd859ac8c MAINTAINERS: add missing "se=
curity/integrity" directory)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (70f4169ab421 selinux: parse contexts for mount option=
s early)
Merging smack/next (e783362eb54c Linux 5.17-rc1)
Merging tomoyo/master (f702e1107601 tomoyo: use hwight16() in tomoyo_domain=
_quota_is_ok())
Merging tpmdd/next (a33f5c380c4b Merge tag 'xfs-5.17-merge-3' of git://git.=
kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging watchdog/master (ffd264bd152c watchdog: msc313e: Check if the WDT w=
as running at boot)
Merging iommu/next (26291c54e111 Linux 5.17-rc2)
Merging audit/next (e783362eb54c Linux 5.17-rc1)
Merging devicetree/for-next (b4ba994f2622 dt-bindings: ltk050h3146w: replac=
e Heiko Stuebner by myself as maintainer)
Merging mailbox/mailbox-for-next (869b6ca39c08 dt-bindings: mailbox: Add mo=
re protocol and client ID)
Merging spi/for-next (2cbfa2128662 spi: make remove callback a void functio=
n)
CONFLICT (content): Merge conflict in drivers/hwmon/adt7310.c
Merging tip/auto-latest (163812a9c80a Merge x86/cpu into tip/master)
Merging clockevents/timers/drivers/next (7647204c2e81 dt-bindings: timer: A=
dd Mstar MSC313e timer devicetree bindings documentation)
Merging edac/edac-for-next (59d0e09374a3 Merge branch 'edac-urgent' into ed=
ac-for-next)
Merging irqchip/irq/irqchip-next (add679d2cb92 Merge branch irq/parent_devi=
ce into irq/irqchip-next)
Merging ftrace/for-next (6b9b6413700e ftrace: Fix assuming build time sort =
works for s390)
Merging rcu/rcu/next (0ba8896d2fd7 lib/irq_poll: Declare IRQ_POLL softirq v=
ector as ksoftirqd-parking safe)
Merging kvm/next (48ebd0cf23f8 KVM: VMX: Use local pointer to vcpu_vmx in v=
mx_vcpu_after_set_cpuid())
Merging kvm-arm/next (00e6dae00e3d Merge branch kvm-arm64/pmu-bl into kvmar=
m-master/next)
Merging kvms390/next (bfced9f96395 KVM: s390: MAINTAINERS: promote Claudio =
Imbrenda)
Merging xen-tip/linux-next (f66edf684edc xen/pci: Make use of the helper ma=
cro LIST_HEAD())
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (bc35f7ef9628 workqueue: Convert the type of po=
ol->nr_running to int)
Merging drivers-x86/for-next (d717e4509af0 platform/x86: asus-wmi: Fix regr=
ession when probing for fan curve control)
Merging chrome-platform/for-next (ffebd9053272 platform/chrome: cros_ec_typ=
ec: Check for EC device)
Merging hsi/for-next (e783362eb54c Linux 5.17-rc1)
Merging leds/for-next (dfd42facf1e4 Linux 5.17-rc3)
Merging ipmi/for-next (d134ad2574a1 ipmi: ssif: replace strlcpy with strscp=
y)
Merging driver-core/driver-core-next (27446562a1d9 platform: use dev_err_pr=
obe() in platform_get_irq_byname())
CONFLICT (content): Merge conflict in drivers/power/supply/ab8500_chargalg.c
Merging usb/usb-next (c18553956f34 arm64: dts: qcom: sc7280: Set the defaul=
t dr_mode for usb2)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/qcom/ipq6018.dtsi
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/xilinx/zynqmp.dtsi
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (26291c54e111 Linux 5.17-rc2)
Merging usb-chipidea-next/for-usb-next (78665f57c3fa usb: chipidea: udc: ma=
ke controller hardware endpoint primed)
Merging tty/tty-next (ad30d108a513 dt-bindings: serial: fsl-lpuart: Remove =
i.MX8QM from enum)
Merging char-misc/char-misc-next (0580565dd717 docs: Add PECI documentation)
Merging extcon/extcon-next (26291c54e111 Linux 5.17-rc2)
Merging gnss/gnss-next (26291c54e111 Linux 5.17-rc2)
Merging phy-next/next (1e805d190ba5 Merge tag 'phy-fixes-5.17' into next)
CONFLICT (modify/delete): Documentation/devicetree/bindings/phy/qcom,usb-hs=
-phy.txt deleted in phy-next/next and modified in HEAD.  Version HEAD of Do=
cumentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt left in tree.
$ git rm -f Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
Applying: merge fix for "dt-bindings: phy: qcom,usb-hs-phy: add MSM8226 com=
patible"
Merging soundwire/next (63fadaa2c719 soundwire: stream: make enable/disable=
/deprepare idempotent)
Merging thunderbolt/next (7f7b571becf3 thunderbolt: Replace acpi_bus_get_de=
vice())
Merging vfio/next (2bed2ced40c9 vfio/iommu_type1: replace kfree with kvfree)
Merging staging/staging-next (f2c461536226 staging: drop fpgaboot driver)
CONFLICT (content): Merge conflict in drivers/staging/fbtft/fbtft.h
Merging iio/togreg (342c6c5e2260 iio: adc: cpcap-adc: remove redundant assi=
gnment to variable cal_data_diff)
CONFLICT (content): Merge conflict in .mailmap
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging icc/icc-next (2ccd1d8a2f5d Merge branch 'icc-msm8939' into icc-next)
Merging dmaengine/next (e783362eb54c Linux 5.17-rc1)
Merging cgroup/for-next (48da2ddc4c78 Merge branch 'for-5.17-fixes' into fo=
r-next)
Merging scsi/for-next (c7f0d7b37291 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (22754f7fbb40 scsi: mpi3mr: Bump driver version t=
o 8.0.0.68.0)
CONFLICT (content): Merge conflict in drivers/scsi/pm8001/pm8001_hwi.c
CONFLICT (content): Merge conflict in drivers/scsi/pm8001/pm80xx_hwi.c
Merging vhost/linux-next (fae0bd40fab0 virtio_console: break out of buf pol=
l on remove)
Merging rpmsg/for-next (f5d4b6d998d4 Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (4398693a9e24 gpiolib: make struct comments=
 into real kernel docs)
Merging gpio-intel/for-next (a1ce76e89907 gpio: tps68470: Allow building as=
 module)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (f6aca46db617 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (689e00887740 pinctrl: baytrail: Clear direc=
t_irq_en flag on broken configs)
Merging pinctrl-renesas/renesas-pinctrl (2e08ab0427fe pinctrl: renesas: rzg=
2l: Improve rzg2l_gpio_register())
Merging pinctrl-samsung/for-next (3652dc070bad pinctrl: samsung: improve wa=
ke irq info on console)
Merging pwm/for-next (657e54e54ba5 pwm: pxa: Implement .apply() callback)
Merging userns/for-next (f9d87929d451 ucount:  Make get_ucount a safe get_u=
ser replacement)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (6d468898d774 selftests: futex: set DEFAULT_INSTALL_=
HDR_PATH)
Merging livepatching/for-next (32fdbc45ade0 Merge branch 'for-5.17/kallsyms=
' into for-next)
Merging coresight/next (a4dabc3d30ea coresight: etm4x: Add lock for reading=
 virtual context ID comparator)
Merging rtc/rtc-next (e783362eb54c Linux 5.17-rc1)
Merging nvdimm/libnvdimm-for-next (9e05e95ca8da iomap: Fix error handling i=
n iomap_zero_iter())
Merging at24/at24/for-next (e783362eb54c Linux 5.17-rc1)
Merging ntb/ntb-next (afe1c85b354c IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (eed09ad26182 samples/seccomp: Adjust samp=
le to also provide kill option)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (7cc2f34e1f4d fsi: sbefifo: Use interruptible mutex lockin=
g)
Merging slimbus/for-next (e783362eb54c Linux 5.17-rc1)
Merging nvmem/for-next (8043480a8cef nvmem: qfprom: fix kerneldoc warning)
Merging xarray/main (22f56b8e890d XArray: Include bitmap.h from xarray.h)
Merging hyperv/hyperv-next (4ee524587105 Drivers: hv: Compare cpumasks and =
not their weights in init_vp_index())
Merging auxdisplay/auxdisplay (4daa9ff89ef2 auxdisplay: charlcd: checking f=
or pointer reference before dereferencing)
Merging kgdb/kgdb/for-next (b77dbc86d604 kdb: Adopt scheduler's task classi=
fication)
Merging hmm/hmm (6880fa6c5660 Linux 5.15-rc1)
Merging fpga/for-next (21f0a239ecab fpga: dfl: pci: Remove usage of the dep=
recated "pci-dma-compat.h" API)
Merging kunit/test (e783362eb54c Linux 5.17-rc1)
Merging cfi/cfi/next (baaf965f9430 mtd: hyperbus: rpc-if: fix bug in rpcif_=
hb_remove)
Merging kunit-next/kunit (c2741453478b kunit: cleanup assertion macro inter=
nal variables)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (7ba21a082d3e bus: mhi: pci_generic: Add mru_default f=
or Quectel EM1xx series)
Merging memblock/for-next (5b3408a4e5ff memblock tests: Add memblock_free t=
ests)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (be185c2988b4 cxl/core: Remove cxld_const_init in cxl_deco=
der_alloc())
Merging folio/for-next (b1ccdc7664f5 selftests/vm/transhuge-stress: Support=
 file-backed PMD folios)
$ git reset --hard HEAD^
Merging next-20220204 version of folio
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (42f4046bc4ba efi: use default_groups in kobj_type)
Merging unicode/for-next (5298d4bfe80f unicode: clean up the Kconfig symbol=
 confusion)
Merging slab/for-next (07f910f9b729 mm: Remove slab from struct page)
Merging random/master (0164b4fd8b0a random: set fast pool count to zero in =
cpuhp teardown)
Merging landlock/next (a691b9858300 Merge Landlock fixes into next)
Merging rust/rust-next (847245fe812e init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
Merging akpm-current/current (c0852bb54c2c ipc/mqueue: use get_tree_nodev()=
 in mqueue_get_tree())
CONFLICT (content): Merge conflict in drivers/gpu/drm/drm_cache.c
CONFLICT (content): Merge conflict in lib/Kconfig.debug
CONFLICT (modify/delete): tools/testing/radix-tree/linux/gfp.h deleted in H=
EAD and modified in akpm-current/current.  Version akpm-current/current of =
tools/testing/radix-tree/linux/gfp.h left in tree.
$ git rm -f tools/testing/radix-tree/linux/gfp.h
Applying: fix up for "tools: Move gfp.h and slab.h from radix-tree to lib"
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (e6cba3979927 Merge branch 'akpm-current/current')
Applying: fix for "mm: don't include <linux/memremap.h> in <linux/mm.h>"

--Sig_/RDI/Ik=Sj=efgD.A=zTKLEZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIJ/4AACgkQAVBC80lX
0GyttQgAnnxIlOmJvK3IuoVfYChBe976Tol8+Ndt2bTWJ81g2iryRi4bL72qYI4q
fEcmnv1VBzggLEq7feUnHIISoaQgfCM+WAGf54cydWT6ABP5uvVmKbXb5LUlG3jV
VUo+MQzaAGdO4bWlZE5hP+2Sb0Nce6DIBseLdNHSzlh53/Rgn3zJr2kGzHnu8/Dl
4NXaRdg2Rs/62tBO7kGy7d0HRMUycZvjnolMdLtQOlRtcHLq6erKqi/onfd28lZx
6Vi/N7pcrTtSgioH6nT5OIdDXDEBCK5U8+fkAw6/fSb2DRdNqg/LgGMZIVTJkRNJ
uresUJBVS/tfu21FnwjqA0MsghOWeQ==
=npLn
-----END PGP SIGNATURE-----

--Sig_/RDI/Ik=Sj=efgD.A=zTKLEZ--
