Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71A24976C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 01:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbiAXAfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 19:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiAXAfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 19:35:53 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EB5C06173B;
        Sun, 23 Jan 2022 16:35:52 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jhrck0nYRz4xcF;
        Mon, 24 Jan 2022 11:35:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642984550;
        bh=nPAUmJobPrcZN9IL4Q+gzA7M8grSauHdEmfzVYqwIIY=;
        h=Date:From:To:Cc:Subject:From;
        b=qOtFl+/bdJfFjfn2I9sE4TXNHZbrfn5wwPz3AwcbpjW/L3Sjt6w6M7yFUau14t+oF
         qa2+B47+5boIoL9sPx2x3ZW3DMMcCRyDT6KXng0w59KHRfN5gD86flft71gnzvDWdG
         xXeVTgtwWlZziAt/aciYUomufwKrJrgfeZo8PUfRvjbt5jaP3n8lBI7FyK0UbQM4mb
         9EKkRg7dMLyxeBlGTOh28n/z3FkkBtVr3FnqN6k+UKrZAKx4EOyN48zU+isSvNdeCV
         9gHyQg4upl8evPugJFOec7FvKVWFJcKuYi1puE52+IWp6CZIuK9SdLSnuoxXFTHD8c
         Nz+nzlHQ1PVDQ==
Date:   Mon, 24 Jan 2022 11:35:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 24
Message-ID: <20220124113547.1bd1759b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CFRp2Ne74LHSyBI=xgNgq9b";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CFRp2Ne74LHSyBI=xgNgq9b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220121:

The akpm tree lost lots of patches that turned up in Linus' tree.

Non-merge commits (relative to Linus' tree): 854
 1169 files changed, 58676 insertions(+), 11668 deletions(-)

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

I am currently merging 346 trees (counting Linus' and 93 trees of bug
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
Merging origin/master (dd81e1c7d5fb Merge tag 'powerpc-5.17-2' of git://git=
.kernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (e6340b6526ee certs: Fix build error when CONF=
IG_MODULE_SIG_KEY is empty)
Merging arc-current/for-curr (8f67f65d121c arc: use swap() to make code cle=
aner)
Merging arm-current/fixes (9f80ccda53b9 ARM: 9180/1: Thumb2: align ALT_UP()=
 sections in modules sufficiently)
Merging arm64-fixes/for-next/fixes (9c5d89bc1055 arm64: kexec: Fix missing =
error code 'ret' warning in load_other_segments())
Merging arm-soc-fixes/arm/fixes (c8013355ead6 ARM: dts: gpio-ranges propert=
y is now required)
Merging drivers-memory-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging tee-fixes/fixes (d58071a8a76d Linux 5.16-rc3)
Merging m68k-current/for-linus (1a0ae068bf6b m68k: defconfig: Update defcon=
figs for v5.16-rc1)
Merging powerpc-fixes/fixes (aee101d7b95a powerpc/64s: Mask SRR0 before che=
cking against the masked NIP)
Merging s390-fixes/fixes (3d787b392d16 s390/uaccess: fix compile error)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (afa114d987c4 selftests: net: ioam: expect support for Q=
ueue depth data)
Merging bpf/master (baa59504c1cd net: mscc: ocelot: fix using match before =
it is set)
Merging ipsec/master (7d6019b602de Revert "net: vertexcom: default to disab=
led on kbuild")
Merging netfilter/master (03c82e80ec28 Merge branch 'octeontx2-af-fixes')
Merging ipvs/master (5471d5226c3b selftests: Calculate udpgso segment count=
 without header adjustment)
Merging wireless/main (67ab55956e64 Merge tag 'wireless-2022-01-21' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless)
Merging rdma-fixes/for-rc (df0cc57e057f Linux 5.16)
Merging sound-current/for-linus (2a1355f0bf41 ALSA: hda/cs8409: Add new War=
lock SKUs to patch_cs8409)
Merging sound-asoc-fixes/for-linus (579b2c8f72d9 ASoC: mediatek: fix unmet =
dependency on GPIOLIB for SND_SOC_DMIC)
Merging regmap-fixes/for-linus (9c16529291ad Merge remote-tracking branch '=
regmap/for-5.15' into regmap-linus)
Merging regulator-fixes/for-linus (8dde4e76a01a Merge remote-tracking branc=
h 'regulator/for-5.16' into regulator-linus)
Merging spi-fixes/for-linus (353bbc52de1c Merge remote-tracking branch 'spi=
/for-5.16' into spi-linus)
Merging pci-current/for-linus (9c494ca4d3a5 x86/gpu: Reserve stolen memory =
for first integrated Intel GPU)
Merging driver-core.current/driver-core-linus (e783362eb54c Linux 5.17-rc1)
Merging tty.current/tty-linus (e783362eb54c Linux 5.17-rc1)
Merging usb.current/usb-linus (e783362eb54c Linux 5.17-rc1)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (a7904a538933 Linux 5.16-rc6)
Merging usb-chipidea-fixes/for-usb-fixes (f130d08a8d79 usb: chipidea: ci_hd=
rc_imx: Also search for 'phys' phandle)
CONFLICT (content): Merge conflict in drivers/usb/chipidea/ci_hdrc_imx.c
Merging phy/fixes (c2111bb1e3c5 phy: cadence: Sierra: fix error handling bu=
gs in probe())
Merging staging.current/staging-linus (e783362eb54c Linux 5.17-rc1)
Merging iio-fixes/fixes-togreg (ccbed9d8d2a5 iio: accel: fxls8962af: add pa=
dding to regmap for SPI)
Merging char-misc.current/char-misc-linus (a6501e4b380f eeprom: at25: Resto=
re missing allocation)
Merging soundwire-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging thunderbolt-fixes/fixes (df0cc57e057f Linux 5.16)
Merging input-current/for-linus (762f99f4f3cb Merge branch 'next' into for-=
linus)
Merging crypto-current/master (5f21d7d283dd crypto: af_alg - rewrite NULL p=
ointer check)
Merging vfio-fixes/for-linus (8704e8934908 vfio/pci: Fix OpRegion read)
Merging kselftest-fixes/fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging modules-fixes/modules-linus (2a987e65025e Merge tag 'perf-tools-fix=
es-for-v5.16-2021-12-07' of git://git.kernel.org/pub/scm/linux/kernel/git/a=
cme/linux)
Merging dmaengine-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (51935d86998c mtd: phram: Prevent divide by zer=
o bug in phram_setup())
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (d40f0b133b44 media: meson-ir-tx: remove incorr=
ect doc comment)
Merging reset-fixes/reset/fixes (92c959bae2e5 reset: renesas: Fix Runtime P=
M usage)
Merging mips-fixes/mips-fixes (09d97da660ff MIPS: Only define pci_remap_ios=
pace() for Ralink)
Merging at91-fixes/at91-fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging omap-fixes/fixes (80d680fdccba ARM: dts: omap3430-sdp: Fix NAND dev=
ice node)
Merging kvm-fixes/master (e2e83a73d7ce docs: kvm: fix WARNINGs from api.rst)
Merging kvms390-fixes/master (0e9ff65f455d KVM: s390: preserve deliverable_=
mask in __airqs_kick_single_vcpu)
Merging hwmon-fixes/hwmon (fd1e38c44d12 hwmon: (adt7470) Prevent divide by =
zero in adt7470_fan_write())
Merging nvdimm-fixes/libnvdimm-fixes (3dd60fb9d95d nvdimm/pmem: stop using =
q_usage_count as external pgmap refcount)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (ee7c61f30c22 Merge branch 'misc-5.17' into =
next-fixes)
Merging vfs-fixes/fixes (25f54d08f12f autofs: fix wait name hash calculatio=
n in autofs_wait())
Merging dma-mapping-fixes/for-linus (18a3c5f7abfd Merge tag 'for_linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (26a8b0943780 platform/x86: intel_pmc_core:=
 fix memleak on registration failure)
Merging samsung-krzk-fixes/fixes (442b0c08db7e soc: samsung: Fix typo in CO=
NFIG_EXYNOS_USI description)
Merging pinctrl-samsung-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging devicetree-fixes/dt/linus (b398123bff3b efi: apply memblock cap aft=
er memblock_add())
Merging scsi-fixes/fixes (142c779d05d1 scsi: vmw_pvscsi: Set residual data =
length conditionally)
Merging drm-fixes/drm-fixes (936a93775b7c Merge tag 'amd-drm-fixes-5.16-202=
1-12-31' of ssh://gitlab.freedesktop.org/agd5f/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (df0cc57e057f Linux 5.16)
Merging mmc-fixes/fixes (1928e28b3962 mmc: core: Wait for command setting '=
Power Off Notification' bit to complete)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (136057256686 Linux 5.16-rc2)
Merging hyperv-fixes/hyperv-fixes (1dc2f2b81a6a hv: utils: add PTP_1588_CLO=
CK to Kconfig to fix build)
Merging soc-fsl-fixes/fix (7e5e744183bb soc: fsl: dpio: fix qbman alignment=
 error in the virtualization context)
Merging risc-v-fixes/fixes (f6f7fbb89bf8 riscv: dts: sifive unmatched: Link=
 the tmp451 with its power supply)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (8bb7eca972ad Linux 5.15)
Merging spdx/spdx-linus (e783362eb54c Linux 5.17-rc1)
Merging gpio-brgl-fixes/gpio/for-current (9f51ce0b9e73 gpio: mpc8xxx: Fix a=
n ignored error return from platform_get_irq())
Merging gpio-intel-fixes/fixes (2c271fe77d52 Merge tag 'gpio-fixes-for-v5.1=
7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux)
Merging pinctrl-intel-fixes/fixes (2c271fe77d52 Merge tag 'gpio-fixes-for-v=
5.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux)
Merging erofs-fixes/fixes (0a7d31775cc8 erofs: avoid unnecessary z_erofs_de=
compressqueue_work() declaration)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging ubifs-fixes/fixes (c3c07fc25f37 ubi: fastmap: Return error code if =
memory allocation fails in add_aeb())
Merging memblock-fixes/fixes (d7f55471db27 memblock: fix memblock_phys_allo=
c() section mismatch error)
Merging cel-fixes/for-rc (c9e6606c7fe9 Linux 5.16-rc8)
Merging irqchip-fixes/irq/irqchip-fixes (16436f70abee irqchip/gic-v3-its: F=
ix build for !SMP)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (e783362eb54c Linux 5.17-rc1)
Merging efi-fixes/urgent (f5390cd0b43c efi: runtime: avoid EFIv2 runtime se=
rvices on Apple x86 machines)
Merging zstd-fixes/zstd-linus (d58071a8a76d Linux 5.16-rc3)
Merging drm-misc-fixes/for-linux-next-fixes (016017a195b8 drm/ttm: fix comp=
ilation on ARCH=3Dum)
Merging kbuild/for-next (c6553cd5dec6 usr/include/Makefile: add linux/nfc.h=
 to the compile-test coverage)
Merging perf/perf/core (e783362eb54c Linux 5.17-rc1)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (f857acfc457e lib/scatterlist: cleanup macros =
into static inline functions)
Merging asm-generic/master (733e417518a6 asm-generic/error-injection.h: fix=
 a spelling mistake, and a coding style issue)
Merging arc/for-next (6880fa6c5660 Linux 5.15-rc1)
Merging arm/for-next (c8469eb98626 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (bb425a759847 arm64: mm: apply __ro_after_init =
to memory_limit)
Merging arm-perf/for-next/perf (3da4390bcdf4 arm64: perf: Don't register us=
er access sysctl handler multiple times)
Merging arm-soc/for-next (317a42bd9204 ARM: Document merges)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/apple/t8103.dtsi
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (2c420d79dae4 arm64: dts: meson-g12-common: add ua=
rt_ao_b pins muxing)
Merging aspeed/for-next (a7e02e92755c Merge branches 'dt-for-v5.17', 'defco=
nfig-for-v5.17' and 'soc-for-v5.17' into for-next)
Merging at91/at91-next (9be3df0e718c Merge branch 'at91-defconfig' into at9=
1-next)
Merging drivers-memory/for-next (e783362eb54c Linux 5.17-rc1)
Merging imx-mxs/for-next (b95a3922f285 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (ccf7b63aac3e Merge branch 'v5.16-next/dts64' int=
o for-next)
Merging mvebu/for-next (d835946fc3d8 Merge branch 'mvebu/dt' into mvebu/for=
-next)
Merging omap/for-next (61b6b9cfada4 Merge branch 'omap-for-v5.17/fixes-not-=
urgent' into for-next)
Merging qcom/for-next (7e5fe035d019 Merge branches 'arm64-defconfig-for-5.1=
7', 'arm64-for-5.17', 'clk-for-5.17', 'defconfig-for-5.17' and 'drivers-for=
-5.17' into for-next)
CONFLICT (content): Merge conflict in arch/arm/configs/multi_v7_defconfig
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (743002730737 Merge branch 'renesas-arm-dt-for-v5.17' =
into renesas-next)
Merging reset/reset/next (89e7a6698fdd reset: uniphier-glue: Use devm_add_a=
ction_or_reset())
Merging rockchip/for-next (e022219292b5 Merge branch 'v5.17-armsoc/dtsfixes=
' into for-next)
Merging samsung-krzk/for-next (e758cdb29e81 Merge branch 'next/soc' into fo=
r-next)
Merging scmi/for-linux-next (1f40caa08047 Merge tag 'sound-fix-5.17-rc1' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound)
Merging stm32/stm32-next (3ff0810ffc47 ARM: dts: stm32: Add Engicam i.Core =
STM32MP1 C.TOUCH 2.0 10.1" OF)
Merging sunxi/sunxi/for-next (1d21ba6546a5 Merge branch 'sunxi/dt-for-5.17'=
 into sunxi/for-next)
Merging tee/next (ce352be35ba0 Merge branch 'async_notif' into next)
Merging tegra/for-next (707b88674206 Merge branch for-5.17/arm/defconfig in=
to for-next)
Merging ti/ti-next (e66d73b2aa76 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (2eb48e610ef7 Merge remote-tracking branch 'zynqmp/=
dt' into for-next)
Merging clk/clk-next (b4966a7dc072 clk: mediatek: relicense mt7986 clock dr=
iver to GPL-2.0)
Merging clk-imx/for-next (b3b1283eba5c clk: imx: Add imx8dxl clk driver)
Merging clk-renesas/renesas-clk (f0b62b0bbedc clk: renesas: r9a07g044: Add =
GPU clock and reset entries)
Merging clk-samsung/for-next (45bd8166a1d8 clk: samsung: Add initial Exynos=
7885 clock driver)
Merging csky/linux-next (a0793fdad9a1 csky: fix typo of fpu config macro)
Merging h8300/h8300-next (1ec10274d436 h8300: don't implement set_fs)
Merging m68k/for-next (a9940f83a6e2 m68k: Add asm/config.h)
Merging m68knommu/for-next (a7904a538933 Linux 5.16-rc6)
Merging microblaze/next (7b94b7f0ae24 microblaze: add const to of_device_id)
Merging mips/mips-next (d3115128bdaf MIPS: ath79: drop _machine_restart aga=
in)
Merging nds32/next (07cd7745c6f2 nds32/setup: remove unused memblock_region=
 variable in setup_memory())
CONFLICT (content): Merge conflict in arch/nds32/Kbuild
CONFLICT (content): Merge conflict in arch/nds32/Kconfig
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (7f435e42fd6b openrisc: init: Add support for com=
mon clk)
Merging parisc-hd/for-next (ad83ce7c45e2 parisc: Drop __init from map_pages=
 declaration)
Merging powerpc/next (29ec39fcf11e Merge tag 'powerpc-5.17-1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging soc-fsl/next (1ce93cb102e7 soc: fsl: qe: Check of ioremap return va=
lue)
Merging risc-v/for-next (c59cd507fb64 RISC-V: nommu_virt: Drop unused SLAB_=
MERGE_DEFAULT)
Merging s390/for-next (cf78fda3b6d8 Merge branch 'fixes' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (db0dd9cee822 um: virtio_uml: Allow probing from dev=
icetree)
Merging xtensa/xtensa-for-next (8a900dc390da xtensa: Remove unused early_re=
ad_config_byte() et al declarations)
Merging pidfd/for-next (317465bcc6f4 Merge branch 'fs.idmapped' into for-ne=
xt)
Merging fscrypt/master (b7e072f9b77f fscrypt: improve a few comments)
Merging fscache/fscache-next (d8411e7e5132 vfs, fscache: Add an IS_KERNEL_F=
ILE() macro for the S_KERNEL_FILE flag)
Merging afs/afs-next (52af7105eceb afs: Set mtime from the client for yfs c=
reate operations)
Merging btrfs/for-next (7aa1269834b4 Merge branch 'for-next-next-v5.16-2022=
0107' into for-next-20220107)
Merging ceph/master (a0b3a15eab6b ceph: move CEPH_SUPER_MAGIC definition to=
 magic.h)
Merging cifs/for-next (1c52283265a4 Merge branch 'akpm' (patches from Andre=
w))
Merging configfs/for-next (c42dd069be8d configfs: fix a race in configfs_lo=
okup())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (e783362eb54c Linux 5.17-rc1)
Merging exfat/dev (3d966521a824 exfat: fix missing REQ_SYNC in exfat_update=
_bhs())
Merging ext3/for_next (5f0a61886e30 Pull Amir's FAN_RENAME and FAN_REPORT_T=
ARGET_FID support for fanotify.)
Merging ext4/dev (b0544c1f23dd jbd2: refactor wait logic for transaction up=
dates into a common function)
Merging f2fs/dev (1d1df41c5a33 Merge tag 'f2fs-for-5.17-rc1' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (073c3ab6ae01 Documentation/filesystem/dax: DAX on vi=
rtiofs)
Merging gfs2/for-next (72744f509650 gfs2: Fix gfs2_release for non-writers =
regression)
Merging jfs/jfs-next (c48a14dca2cb JFS: fix memleak in jfs_mount)
Merging ksmbd/ksmbd-for-next (67ed868d2371 Merge tag '5.17-rc-ksmbd-server-=
fixes' of git://git.samba.org/ksmbd)
Merging nfs/linux-next (c9e6606c7fe9 Linux 5.16-rc8)
Merging nfs-anna/linux-next (aed28b7a2d62 SUNRPC: Don't dereference xprt->s=
nd_task if it's a cookie)
Merging nfsd/for-next (0fc3812f4554 lockd: fix failure to cleanup client lo=
cks)
Merging ntfs3/master (52e00ea6b26e fs/ntfs3: Update valid size if -EIOCBQUE=
UED)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (94fd19752b28 ovl: don't fail copy up if n=
o fileattr support on upper)
Merging ubifs/next (aa39cc675799 jffs2: GC deadlock reading a page that is =
used in jffs2_write_begin())
Merging v9fs/9p-next (19d1c32652bb 9p: fix enodata when reading growing fil=
e)
Merging xfs/for-next (6191cf3ad59f xfs: flush inodegc workqueue tasks befor=
e cancel)
Merging zonefs/for-next (95b115332a83 zonefs: remove redundant null bio che=
ck)
Merging iomap/iomap-for-next (5ad448ce2976 iomap: iomap_read_inline_data cl=
eanup)
Merging djw-vfs/vfs-for-next (d03ef4daf33a fs: forbid invalid project ID)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (8f40da9494cf Merge branch 'misc.namei' into for-next)
Merging printk/for-next (395cc1cdcbd4 Merge branch 'for-5.17' into for-next)
Merging pci/next (87c71931633b Merge branch 'pci/driver-cleanup')
Merging pstore/for-next/pstore (a5d05b07961a pstore/ftrace: Allow immediate=
 recording)
Merging hid/for-next (1bec0754eaa0 Merge branches 'for-5.16/upstream-fixes'=
, 'for-5.17/apple', 'for-5.17/core', 'for-5.17/hidraw', 'for-5.17/i2c-hid',=
 'for-5.17/letsketch', 'for-5.17/logitech', 'for-5.17/magicmouse' and 'for-=
5.17/thrustmaster' into for-next)
Merging i2c/i2c/for-next (fe37c72debe9 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (13462ba1815d i3c: master: dw: check return of dw_i3c_=
master_get_free_pos())
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (00f5117c5f78 hwmon: (nzxt-smart2) make ar=
ray detect_fans_report static const)
Merging jc_docs/docs-next (b0ac702f3329 Documentation: fix firewire.rst ABI=
 file path error)
Merging v4l-dvb/master (e783362eb54c Linux 5.17-rc1)
Merging v4l-dvb-next/master (bb8c98537ac8 media: mtk-vcodec: Remove mtk_vco=
dec_release_enc_pm)
Merging pm/linux-next (c83f3ae084b3 Merge branch 'thermal-int340x' into lin=
ux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (d776790a5536 cpufreq: mediatek-=
hw: Fix double devm_remap in hotplug case)
Merging cpupower/cpupower (21f61b52868d tools/power/cpupower/{ToDo =3D> TOD=
O}: Rename the todo file)
Merging devfreq/devfreq-next (4667431419e9 PM / devfreq: Reduce log severit=
y for informative message)
Merging opp/opp/linux-next (489a00ef46c9 Documentation: power: Update outda=
ted contents in opp.rst)
Merging thermal/thermal/linux-next (8ee1c0f6526c thermal/drivers/rz2gl: Add=
 error check for reset_control_deassert())
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (feae43f8aa88 fs: dlm: print cluster addr if non-cluster n=
ode connects)
Merging rdma/for-next (c0fe82baaeb2 Merge tag 'v5.16' into rdma.git for-nex=
t)
Merging net-next/master (fe8152b38d3a Merge tag 'devprop-5.17-rc1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging bpf-next/for-next (c25af830ab26 sch_cake: revise Diffserv docs)
Merging ipsec-next/master (fe8152b38d3a Merge tag 'devprop-5.17-rc1' of git=
://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging mlx5-next/mlx5-next (e783362eb54c Linux 5.17-rc1)
Merging netfilter-next/master (fe8152b38d3a Merge tag 'devprop-5.17-rc1' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging ipvs-next/master (2b71e2c7b56c netfilter: nft_set_pipapo_avx2: remo=
ve redundant pointer lt)
Merging bluetooth/master (5201d23cc8e5 Bluetooth: msft: fix null pointer de=
ref on msft_monitor_device_evt)
Merging wireless-next/main (fe8152b38d3a Merge tag 'devprop-5.17-rc1' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging mtd/mtd/next (7f852ec58af6 mtd: aspeed-smc: improve probe resilienc=
e)
Merging nand/nand/next (2212c19e5196 mtd: rawnand: omap_elm: remove redunda=
nt variable 'errors')
Merging spi-nor/spi-nor/next (5f340402bbfc mtd: spi-nor: Remove debugfs ent=
ries that duplicate sysfs entries)
Merging crypto/master (5f21d7d283dd crypto: af_alg - rewrite NULL pointer c=
heck)
Merging drm/drm-next (e783362eb54c Linux 5.17-rc1)
Merging drm-misc/for-linux-next (d3cbc6e323c9 drm: panel-orientation-quirks=
: Add quirk for the 1Netbook OneXPlayer)
Merging amdgpu/drm-next (90487c15a3a2 drm/amdgpu: bump driver version for n=
ew CTX OP to set/get stable pstates)
Merging drm-intel/for-linux-next (e26602be4869 drm/i915/display/adlp: Imple=
ment new step in the TC voltage swing prog sequence)
Merging drm-intel-gt/for-linux-next-gt (e26602be4869 drm/i915/display/adlp:=
 Implement new step in the TC voltage swing prog sequence)
Merging drm-tegra/drm/tegra/for-next (d210919dbdc8 drm/tegra: Add back arm_=
iommu_detach_device())
Merging drm-msm/msm-next (6ed95285382d drm/msm/a5xx: Fix missing CP_PROTECT=
 for SMMU on A540)
Merging imx-drm/imx-drm/next (20fbfc81e390 drm/imx: imx-tve: Make use of th=
e helper function devm_platform_ioremap_resource())
Merging etnaviv/etnaviv/next (cdd156955f94 drm/etnaviv: consider completed =
fence seqno in hang check)
Merging fbdev/for-next (842086bc7262 video: fbdev: controlfb: Fix COMPILE_T=
EST build)
Merging regmap/for-next (b56a7cbf40c8 regmap: debugfs: Fix indentation)
Merging sound/for-next (2a1355f0bf41 ALSA: hda/cs8409: Add new Warlock SKUs=
 to patch_cs8409)
Merging sound-asoc/for-next (579b2c8f72d9 ASoC: mediatek: fix unmet depende=
ncy on GPIOLIB for SND_SOC_DMIC)
Merging modules/modules-next (a97ac8cb24a3 module: fix signature check fail=
ures when using in-kernel decompression)
Merging input/next (87a0b2fafc09 Merge tag 'v5.16' into next)
CONFLICT (content): Merge conflict in drivers/input/misc/axp20x-pek.c
Merging block/for-next (04cbc1acc493 Merge branch 'io_uring-5.17' into for-=
next)
Merging device-mapper/for-next (eaac0b590a47 dm sysfs: use default_groups i=
n kobj_type)
Merging libata/for-next (b875b39e7373 ata: pata_octeon_cf: fix call to trac=
e_ata_bmdma_stop())
Merging pcmcia/pcmcia-next (fbb3485f1f93 pcmcia: fix setting of kthread tas=
k states)
Merging mmc/next (356f3f2c5756 dt-bindings: mmc: synopsys-dw-mshc: integrat=
e Altera and Imagination)
Merging mfd/for-mfd-next (e565615c5486 mfd: google,cros-ec: Fix property na=
me for MediaTek rpmsg)
Merging backlight/for-backlight-next (ec961cf32411 backlight: qcom-wled: Re=
spect enabled-strings in set_brightness)
Merging battery/for-next (25fd330370ac power: supply_core: Pass pointer to =
battery info)
Merging regulator/for-next (8dde4e76a01a Merge remote-tracking branch 'regu=
lator/for-5.16' into regulator-linus)
Merging security/next-testing (047843bdb316 Merge branch 'landlock_lsm_v34'=
 into next-testing)
Merging apparmor/apparmor-next (875e5cc6b065 lsm: Fix kernel-doc)
Merging integrity/next-integrity (65e38e32a959 selftests/kexec: Enable secu=
reboot tests for PowerPC)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (6cd9d4b97891 selinux: minor tweaks to selinux_add_opt=
())
Merging smack/next (0934ad42bb2c smackfs: use netlbl_cfg_cipsov4_del() for =
deleting cipso_v4_doi)
Merging tomoyo/master (f702e1107601 tomoyo: use hwight16() in tomoyo_domain=
_quota_is_ok())
Merging tpmdd/next (a33f5c380c4b Merge tag 'xfs-5.17-merge-3' of git://git.=
kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging watchdog/master (ffd264bd152c watchdog: msc313e: Check if the WDT w=
as running at boot)
Merging iommu/next (66dc1b791c58 Merge branches 'arm/smmu', 'virtio', 'x86/=
amd', 'x86/vt-d' and 'core' into next)
Merging audit/next (ed98ea2128b6 audit: replace zero-length array with flex=
ible-array member)
Merging devicetree/for-next (4fc2be59c5fe dt-bindings: watchdog: fsl-imx7ul=
p-wdt: Fix assigned-clock-parents)
Merging mailbox/mailbox-for-next (869b6ca39c08 dt-bindings: mailbox: Add mo=
re protocol and client ID)
Merging spi/for-next (353bbc52de1c Merge remote-tracking branch 'spi/for-5.=
16' into spi-linus)
Merging tip/auto-latest (94985da003a4 Merge branch into tip/master: 'irq/ur=
gent')
Merging clockevents/timers/drivers/next (7647204c2e81 dt-bindings: timer: A=
dd Mstar MSC313e timer devicetree bindings documentation)
Merging edac/edac-for-next (625c6b556997 EDAC: Use default_groups in kobj_t=
ype)
Merging irqchip/irq/irqchip-next (cd448b24c621 Merge branch irq/misc-5.17 i=
nto irq/irqchip-next)
Merging ftrace/for-next (6b9b6413700e ftrace: Fix assuming build time sort =
works for s390)
Merging rcu/rcu/next (76a2b0bbce2c Merge branch 'kcsan.2021.12.09b' into HE=
AD)
Merging kvm/next (e2e83a73d7ce docs: kvm: fix WARNINGs from api.rst)
Merging kvm-arm/next (1c53a1ae3612 Merge branch kvm-arm64/misc-5.17 into kv=
marm-master/next)
Merging kvms390/next (812de04661c4 KVM: s390: Clarify SIGP orders versus ST=
OP/RESTART)
Merging xen-tip/linux-next (54bb4a91b281 dt-bindings: xen: Clarify "reg" pu=
rpose)
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (bc35f7ef9628 workqueue: Convert the type of po=
ol->nr_running to int)
Merging drivers-x86/for-next (3367d1bd738c power: supply: Provide stubs for=
 charge_behaviour helpers)
Merging chrome-platform/for-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging hsi/for-next (a1ee1c08fcd5 HSI: core: Fix return freed object in hs=
i_new_client)
Merging leds/for-next (d949edb503b1 leds: lp55xx: initialise output directi=
on from dts)
Merging ipmi/for-next (d134ad2574a1 ipmi: ssif: replace strlcpy with strscp=
y)
Merging driver-core/driver-core-next (e783362eb54c Linux 5.17-rc1)
Merging usb/usb-next (e783362eb54c Linux 5.17-rc1)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (2585cf9dfaad Linux 5.16-rc5)
Merging usb-chipidea-next/for-usb-next (78665f57c3fa usb: chipidea: udc: ma=
ke controller hardware endpoint primed)
Merging tty/tty-next (e783362eb54c Linux 5.17-rc1)
Merging char-misc/char-misc-next (e783362eb54c Linux 5.17-rc1)
Merging extcon/extcon-next (2da3db7f498d extcon: Deduplicate code in extcon=
_set_state_sync())
Merging gnss/gnss-next (547d2167c5c3 gnss: usb: add support for Sierra Wire=
less XM1210)
Merging phy-next/next (e783362eb54c Linux 5.17-rc1)
Merging soundwire/next (e783362eb54c Linux 5.17-rc1)
Merging thunderbolt/next (fa487b2a900d thunderbolt: Add module parameter fo=
r CLx disabling)
Merging vfio/next (2bed2ced40c9 vfio/iommu_type1: replace kfree with kvfree)
Merging staging/staging-next (e783362eb54c Linux 5.17-rc1)
Merging iio/togreg (38ac2f038666 iio: chemical: sunrise_co2: set val parame=
ter only on success)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging icc/icc-next (01f8938ad036 Merge branch 'icc-qcm2290' into icc-next)
Merging dmaengine/next (e783362eb54c Linux 5.17-rc1)
Merging cgroup/for-next (27fe872b5169 Merge branch 'for-5.17-fixes' into fo=
r-next)
Merging scsi/for-next (9583aa8cb59e Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (5322359fec13 scsi: bfa: Remove useless DMA-32 fa=
llback configuration)
Merging vhost/linux-next (fae0bd40fab0 virtio_console: break out of buf pol=
l on remove)
Merging rpmsg/for-next (d42cd7930649 Merge branches 'hwspinlock-next', 'rpr=
oc-fixes' and 'rpmsg-fixes' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (ffe31c9ed35d gpio: rcar: Propagate errors =
from devm_request_irq())
Merging gpio-intel/for-next (2c271fe77d52 Merge tag 'gpio-fixes-for-v5.17-r=
c1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (650d15f26aaa pinctrl: sunxi: Fix H616 I2S3 pin da=
ta)
Merging pinctrl-intel/for-next (2c271fe77d52 Merge tag 'gpio-fixes-for-v5.1=
7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux)
Merging pinctrl-renesas/renesas-pinctrl (ea7e26ebe6a9 pinctrl: renesas: r8a=
779a0: Align comments)
Merging pinctrl-samsung/for-next (832ae134ccc1 pinctrl: samsung: add suppor=
t for Exynos850 and ExynosAutov9 wake-ups)
Merging pwm/for-next (3f0565451cc0 dt-bindings: pwm: Avoid selecting schema=
 on node name match)
Merging userns/for-next (a403df29789b ptrace/m68k: Stop open coding ptrace_=
report_syscall)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (e89908201e25 selftests/vm: remove ARRAY_SIZE define=
 from individual tests)
Merging livepatching/for-next (32fdbc45ade0 Merge branch 'for-5.17/kallsyms=
' into for-next)
Merging coresight/next (efa56eddf5d5 coresight: core: Fix typo in a comment)
Merging rtc/rtc-next (5ceee540fdc7 rtc: sunplus: fix return value in sp_rtc=
_probe())
Merging nvdimm/libnvdimm-for-next (9e05e95ca8da iomap: Fix error handling i=
n iomap_zero_iter())
Merging at24/at24/for-next (d08aea21c89d eeprom: at24: Add support for 24c1=
025 EEPROM)
Merging ntb/ntb-next (b31b0d5d6379 IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (1e6d69c7b9cd selftests/seccomp: Report ev=
ent mismatches more clearly)
Merging kspp/for-next/kspp (136057256686 Linux 5.16-rc2)
Merging kspp-gustavo/for-next/kspp (c9e6606c7fe9 Linux 5.16-rc8)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (7cc2f34e1f4d fsi: sbefifo: Use interruptible mutex lockin=
g)
Merging slimbus/for-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging nvmem/for-next (779809c07324 dt-bindings: nvmem: Add missing 'reg' =
property)
Merging xarray/main (1c9f4b00b3cf XArray: Document the locking requirement =
for the xa_state)
Merging hyperv/hyperv-next (4eea5332d67d scsi: storvsc: Fix storvsc_queueco=
mmand() memory leak)
Merging auxdisplay/auxdisplay (4daa9ff89ef2 auxdisplay: charlcd: checking f=
or pointer reference before dereferencing)
Merging kgdb/kgdb/for-next (b77dbc86d604 kdb: Adopt scheduler's task classi=
fication)
Merging hmm/hmm (6880fa6c5660 Linux 5.15-rc1)
Merging fpga/for-next (98ceca2f2932 fpga: region: fix kernel-doc)
Merging kunit/test (fa55b7dcdc43 Linux 5.16-rc1)
Merging cfi/cfi/next (baaf965f9430 mtd: hyperbus: rpc-if: fix bug in rpcif_=
hb_remove)
Merging kunit-next/kunit (ad659ccb5412 kunit: tool: Default --jobs to numbe=
r of CPUs)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (fd692f3d8ff3 bus: mhi: Add mru_default for Cinterion =
MV31-W)
Merging memblock/for-next (a59466ee91aa memblock: Remove #ifdef __KERNEL__ =
from memblock.h)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging rust/rust-next (ced9f62ec435 init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
CONFLICT (content): Merge conflict in Documentation/process/changes.rst
CONFLICT (content): Merge conflict in samples/Kconfig
CONFLICT (content): Merge conflict in samples/Makefile
Merging cxl/next (be185c2988b4 cxl/core: Remove cxld_const_init in cxl_deco=
der_alloc())
Merging folio/for-next (3abb28e275bf filemap: Use folio_put_refs() in filem=
ap_free_folio())
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging bitmap/bitmap-master-5.15 (785cb064e2f8 vsprintf: rework bitmap_lis=
t_string)
CONFLICT (content): Merge conflict in arch/parisc/include/asm/bitops.h
CONFLICT (content): Merge conflict in arch/powerpc/include/asm/cputhreads.h
CONFLICT (content): Merge conflict in arch/s390/kvm/kvm-s390.c
CONFLICT (content): Merge conflict in drivers/dma/ti/edma.c
Merging zstd/zstd-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging efi/next (42f4046bc4ba efi: use default_groups in kobj_type)
Merging unicode/for-next (5298d4bfe80f unicode: clean up the Kconfig symbol=
 confusion)
Merging slab/for-next (07f910f9b729 mm: Remove slab from struct page)
Merging random/master (2869c524fe6e lib/crypto: blake2s: avoid indirect cal=
ls to compression function for Clang CFI)
Merging landlock/next (2585cf9dfaad Linux 5.16-rc5)
Merging akpm-current/current (542ed6d41f2b ipc/sem: do not sleep with a spi=
n lock held)
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
CONFLICT (content): Merge conflict in fs/f2fs/data.c
dropping 352bb555f57a77660caf2079a7b058d202572b7e mm/migrate.c: rework migr=
ation_entry_wait() to not take a pageref -- patch contents already upstream
CONFLICT (content): Merge conflict in fs/proc/proc_sysctl.c
CONFLICT (content): Merge conflict in include/linux/sysctl.h
CONFLICT (content): Merge conflict in fs/proc/proc_sysctl.c
CONFLICT (content): Merge conflict in include/linux/sysctl.h
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in kernel/sysctl.c
dropping 632f21dfe3a5e651675162f7fc1e26802823ddd7 hpet: simplify subdirecto=
ry registration with register_sysctl() -- patch contents already upstream
dropping f1f47a5a80870557eb26e0416799863bd20e47b7 i915: simplify subdirecto=
ry registration with register_sysctl() -- patch contents already upstream
dropping 1d06976b520425261c1778334e982adaa7b99a9d macintosh/mac_hid.c: simp=
lify subdirectory registration with register_sysctl() -- patch contents alr=
eady upstream
dropping deb0865ee0a9c2d78dd9ef8777ef7dc54133aa72 ocfs2: simplify subdirect=
ory registration with register_sysctl() -- patch contents already upstream
dropping 24435439fd59ae9ee7811cad7b51a81a8e97bf90 test_sysctl: simplify sub=
directory registration with register_sysctl() -- patch contents already ups=
tream
CONFLICT (content): Merge conflict in kernel/sysctl.c
dropping df9f2bf03005df27a7f1ce69165a826d2054b734 cdrom: simplify subdirect=
ory registration with register_sysctl() -- patch contents already upstream
CONFLICT (content): Merge conflict in include/linux/sysctl.h
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in include/linux/sysctl.h
dropping c9172a89822879eb190c503debcf702dcc7c8698 random: move the random s=
ysctl declarations to its own file -- patch contents already upstream
dropping 8e0c242df7011a75798d7452fc868c0a76a4a186 sysctl: add helper to reg=
ister a sysctl mount point -- patch contents already upstream
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in kernel/printk/internal.h
CONFLICT (content): Merge conflict in kernel/sysctl.c
dropping de1ab6bd6df9f388566a7bb7d699e84baf1f6c83 stackleak: move stack_era=
sing sysctl to stackleak.c -- patch contents already upstream
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in fs/inode.c
CONFLICT (content): Merge conflict in include/linux/fs.h
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in include/linux/fs.h
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in fs/dcache.c
CONFLICT (content): Merge conflict in kernel/sysctl.c
dropping 623f5831318d6241bdd36238caa977ea3cc397f7 fs/inode: avoid unused-va=
riable warning -- patch contents already upstream
dropping 4ac2f84ef6251f28823e7357457c02f9ff06962f fs/dcache: avoid unused-f=
unction warning -- patch contents already upstream
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (add/add): Merge conflict in fs/sysctls.c
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in include/linux/fs.h
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in fs/exec.c
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in kernel/sysctl.c
CONFLICT (content): Merge conflict in kernel/sysctl.c
dropping fbc6f3753d3fb3fbb53767d000f3bcd5379c7d0a fs: move namespace sysctl=
s and declare fs base directory -- patch contents already upstream
dropping ffbd8d5df3002cb4677b85bac5610e4e81ccc66c kernel/sysctl.c: rename s=
ysctl_init() to sysctl_init_bases() -- patch contents already upstream
dropping 7f6c6a6a8e3b04057e47e4a8fabeb2660441db96 printk: fix build warning=
 when CONFIG_PRINTK=3Dn -- patch contents already upstream
dropping a242d1ad306dc44a39a860d83614842795488950 fs/coredump: move coredum=
p sysctls into its own file -- patch contents already upstream
dropping 991a68643292d8e0eeca977cdf8a0ba93b3506de kprobe: move sysctl_kprob=
es_optimization to kprobes.c -- patch contents already upstream
dropping 3ef82d900956d2e00ae10a290a9cfc90b62c2353 kernel/sysctl.c: remove u=
nused variable ten_thousand -- patch contents already upstream
dropping 169cac58d71018656062df022076adc051e6e8b4 sysctl: returns -EINVAL w=
hen a negative value is passed to proc_doulongvec_minmax -- patch contents =
already upstream
CONFLICT (content): Merge conflict in include/linux/proc_fs.h
dropping ef6f67ed5733e5568fd601d2de7cb1f5e8444fd9 proc: remove PDE_DATA() c=
ompletely -- patch contents already upstream
dropping a2e6024b09553a478e1886a98473ca2b03045f14 lib/stackdepot: allow opt=
ional init and stack_table allocation by kvmalloc() -- patch contents alrea=
dy upstream
dropping cbc92ed42a7955cb9b69177a715e238aeeb63817 lib/stackdepot: always do=
 filter_irq_stacks() in stack_depot_save() -- patch contents already upstre=
am
dropping 84e30f10c83447044391a226f9b12d628347fd5c mm: remove cleancache -- =
patch contents already upstream
CONFLICT (content): Merge conflict in include/linux/frontswap.h
CONFLICT (content): Merge conflict in mm/frontswap.c
CONFLICT (content): Merge conflict in include/linux/frontswap.h
CONFLICT (content): Merge conflict in mm/frontswap.c
CONFLICT (content): Merge conflict in include/linux/frontswap.h
CONFLICT (content): Merge conflict in mm/frontswap.c
CONFLICT (content): Merge conflict in include/linux/frontswap.h
CONFLICT (content): Merge conflict in mm/frontswap.c
CONFLICT (content): Merge conflict in include/linux/frontswap.h
dropping d04d44dafd934e57c89245cccada6bc24f8aac9a frontswap: remove the fro=
ntswap exports -- patch contents already upstream
dropping 1d80ea84ebbb919dcc871c3bd5931d70e59196d8 mm: simplify try_to_unuse=
 -- patch contents already upstream
dropping d9f44553cf5f0800c492ae055cbc91d8cc45cd1e frontswap: remove frontsw=
ap_test -- patch contents already upstream
CONFLICT (content): Merge conflict in mm/frontswap.c
dropping f9bf0957dee94a9ed3c1eb2efb7941799c553078 mm: mark swap_lock and sw=
ap_active_head static -- patch contents already upstream
dropping 8a4a97ff8901feed12ac193e80fa2c1c6c606bac frontswap: remove support=
 for multiple ops -- patch contents already upstream
dropping 4f79ffefe7b7868529d3813d978ced116a736ade mm: hide the FRONTSWAP Kc=
onfig symbol -- patch contents already upstream
Merging akpm/master (93163cc61464 fs/f2fs/data.c: fix mess)

--Sig_/CFRp2Ne74LHSyBI=xgNgq9b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHt9GMACgkQAVBC80lX
0GysfAf+Lw10BOlq8WP57q3zK/PmOGtVorHXq6EZWVFClNX5QxVO4r06TjRFQtQp
a8uukTmeOuQ5gND2rk3l2jPvq1LlF5uDuIBo7S0kqRPZUYwOi7mhxVk4HWG4D0YJ
Mwq2yQB0jn1fXwJY5LS2JN5FtFX9zIl98VzZ0/78AAINYOk1+c6RZ6dglWZH8ZXu
kdm+KtRL9U+J1VMggMtFjuiLLhdonG7qViYMaXKyNBoZZKL3ycMMqwDM/wwY+K+I
QZNxYqi7irN+IFE57p1ZMwT1Ze28zcQSTUHe4WfvwayEPpRvWzkQyYDk1wQJHKRR
ZOM0CPfoUTM2WDQBs0pP3ljfg8tnYQ==
=xmGm
-----END PGP SIGNATURE-----

--Sig_/CFRp2Ne74LHSyBI=xgNgq9b--
