Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CD348E378
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 06:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiANFI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 00:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiANFIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 00:08:25 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92E8C061574;
        Thu, 13 Jan 2022 21:08:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JZq7p4W45z4xQp;
        Fri, 14 Jan 2022 16:08:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642136902;
        bh=+gLSPAoB0Vk9Rp/BN47ixgX1tJULDNFZjLOrHHrPgVk=;
        h=Date:From:To:Cc:Subject:From;
        b=fUcCPVwAGXxdBD+BLm8bTNsjyIf60ng04Jf8No3S38amWRiPCaaeIc5JnXQyYXB9l
         g+ZCKWLoTNlD/srjzy5fw+Bu3eYYHDdZSFQiC+MMQLBxKIX4VnqXa9O+veEHVuSibJ
         qSYuN1AtbNHIKBd3F5TIhyCOFbkgTahn3Y63mOHU+okXhnrOnrqVyCuEvMzH7nPTKm
         FmqIvK/GsA4jo43lKX5O3CoLKQUHdfMnYk/o9OfEcneIVFZbBXNYVqU9C9F26+dVyd
         jom153IoSdDva/+yovHvko9cI1APaeMq04kPaTVZDgNBrv8x6SmrIV72tFPjE0wzRX
         mCoyiJRLZSjIA==
Date:   Fri, 14 Jan 2022 16:08:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 14
Message-ID: <20220114160821.18759f9d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LjIygG/55GUc/cffU9b7evc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LjIygG/55GUc/cffU9b7evc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please not add v5.18 related material to your linux-next included branches
until after v5.17-rc1 has been released.

Changes since 20220113:

The perf tree lost its build failure.

The pci tree gained a conflict against Linus' tree.

The amdgpu tree gained a build failure from a bad automatic merge
resolution so I used the version form next-20220113.

The ftrace tree still had its build failure so I used the version from
next-20220111.

The akpm-current tree gained a conflict against the ceph tree.

Non-merge commits (relative to Linus' tree): 3408
 3771 files changed, 140404 insertions(+), 47290 deletions(-)

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

I am currently merging 347 trees (counting Linus' and 94 trees of bug
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
Merging origin/master (fb3b0673b7d5 Merge tag 'mailbox-v5.17' of git://git.=
linaro.org/landing-teams/working/fujitsu/integration)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (e851dfae4371 Merge tag 'kgdb-5.16-rc1' of git=
://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux)
Merging arc-current/for-curr (8f67f65d121c arc: use swap() to make code cle=
aner)
Merging arm-current/fixes (8536a5ef8860 ARM: 9169/1: entry: fix Thumb2 bug =
in iWMMXt exception handling)
Merging arm64-fixes/for-next/fixes (9c5d89bc1055 arm64: kexec: Fix missing =
error code 'ret' warning in load_other_segments())
Merging arm-soc-fixes/arm/fixes (c8013355ead6 ARM: dts: gpio-ranges propert=
y is now required)
Merging drivers-memory-fixes/fixes (8c5ba21c16bd memory: mtk-smi: Fix a nul=
l dereference for the ostd)
Merging tee-fixes/fixes (d58071a8a76d Linux 5.16-rc3)
Merging m68k-current/for-linus (1a0ae068bf6b m68k: defconfig: Update defcon=
figs for v5.16-rc1)
Merging powerpc-fixes/fixes (8d84fca4375e powerpc/ptdump: Fix DEBUG_WX sinc=
e generic ptdump conversion)
Merging s390-fixes/fixes (4eb1782eaa9f recordmcount.pl: fix typo in s390 mc=
ount regex)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (20c9398d3309 net/smc: Resolve the race between SMC-R li=
nk access and clear)
Merging bpf/master (343e53754b21 bpf: Fix incorrect integer literal used fo=
r marking scratched stack.)
Merging ipsec/master (7d6019b602de Revert "net: vertexcom: default to disab=
led on kbuild")
Merging netfilter/master (cf46eacbc156 netfilter: nf_tables: remove unused =
variable)
Merging ipvs/master (5471d5226c3b selftests: Calculate udpgso segment count=
 without header adjustment)
Merging wireless-drivers/master (f7d55d2e439f mt76: mt7921: fix build regre=
ssion)
Merging mac80211/master (dd3ca4c5184e amt: fix wrong return type of amt_sen=
d_membership_update())
Merging rdma-fixes/for-rc (df0cc57e057f Linux 5.16)
Merging sound-current/for-linus (081c73701ef0 ALSA: hda: intel-dsp-config: =
reorder the config table)
Merging sound-asoc-fixes/for-linus (f7a6021aaf02 ASoC: cpcap: Check for NUL=
L pointer after calling of_get_child_by_name)
Merging regmap-fixes/for-linus (9c16529291ad Merge remote-tracking branch '=
regmap/for-5.15' into regmap-linus)
Merging regulator-fixes/for-linus (f2fbbf96ec26 Merge remote-tracking branc=
h 'regulator/for-5.16' into regulator-linus)
Merging spi-fixes/for-linus (238582f974ab Merge remote-tracking branch 'spi=
/for-5.16' into spi-linus)
Merging pci-current/for-linus (87620512681a PCI: apple: Fix PERST# polarity)
Merging driver-core.current/driver-core-linus (feb7a43de5ef Merge tag 'irq-=
msi-2022-01-13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging tty.current/tty-linus (455e73a07f6e Merge tag 'clk-for-linus' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/clk/linux)
Merging usb.current/usb-linus (455e73a07f6e Merge tag 'clk-for-linus' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/clk/linux)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (a7904a538933 Linux 5.16-rc6)
Merging usb-chipidea-fixes/for-usb-fixes (f130d08a8d79 usb: chipidea: ci_hd=
rc_imx: Also search for 'phys' phandle)
CONFLICT (content): Merge conflict in drivers/usb/chipidea/ci_hdrc_imx.c
Merging phy/fixes (f0ae8685b285 phy: HiSilicon: Fix copy and paste bug in e=
rror handling)
Merging staging.current/staging-linus (455e73a07f6e Merge tag 'clk-for-linu=
s' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux)
Merging iio-fixes/fixes-togreg (8f80931a3a4d iio: adc: ti-adc081c: Partial =
revert of removal of ACPI IDs)
Merging char-misc.current/char-misc-linus (c9e6606c7fe9 Linux 5.16-rc8)
Merging soundwire-fixes/fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging thunderbolt-fixes/fixes (df0cc57e057f Linux 5.16)
Merging input-current/for-linus (cf73ed894ee9 Input: zinitix - make sure th=
e IRQ is allocated before it gets enabled)
Merging crypto-current/master (5f21d7d283dd crypto: af_alg - rewrite NULL p=
ointer check)
Merging vfio-fixes/for-linus (8704e8934908 vfio/pci: Fix OpRegion read)
Merging kselftest-fixes/fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging modules-fixes/modules-linus (2a987e65025e Merge tag 'perf-tools-fix=
es-for-v5.16-2021-12-07' of git://git.kernel.org/pub/scm/linux/kernel/git/a=
cme/linux)
Merging dmaengine-fixes/fixes (822c9f2b833c dmaengine: st_fdma: fix MODULE_=
ALIAS)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (27a030e87292 mtd: dataflash: Add device-tree S=
PI IDs)
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
Merging kvm-fixes/master (fffb53237807 KVM: x86: Check for rmaps allocation)
Merging kvms390-fixes/master (0e9ff65f455d KVM: s390: preserve deliverable_=
mask in __airqs_kick_single_vcpu)
Merging hwmon-fixes/hwmon (a7e54735ac43 hwmon: (lm90) Fix sysfs and udev no=
tifications)
Merging nvdimm-fixes/libnvdimm-fixes (3dd60fb9d95d nvdimm/pmem: stop using =
q_usage_count as external pgmap refcount)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (c748b846dab6 Merge branch 'misc-5.16' into =
next-fixes)
Merging vfs-fixes/fixes (25f54d08f12f autofs: fix wait name hash calculatio=
n in autofs_wait())
Merging dma-mapping-fixes/for-linus (18a3c5f7abfd Merge tag 'for_linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (26a8b0943780 platform/x86: intel_pmc_core:=
 fix memleak on registration failure)
Merging samsung-krzk-fixes/fixes (4f5d06d381ba arm64: dts: exynos: drop sam=
sung,ufs-shareability-reg-offset in ExynosAutov9)
Merging pinctrl-samsung-fixes/fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging devicetree-fixes/dt/linus (b398123bff3b efi: apply memblock cap aft=
er memblock_add())
Merging scsi-fixes/fixes (142c779d05d1 scsi: vmw_pvscsi: Set residual data =
length conditionally)
Merging drm-fixes/drm-fixes (936a93775b7c Merge tag 'amd-drm-fixes-5.16-202=
1-12-31' of ssh://gitlab.freedesktop.org/agd5f/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (df0cc57e057f Linux 5.16)
Merging mmc-fixes/fixes (ff31ee0a0f47 mmc: mmci: stm32: clear DLYB_CR after=
 sending tuning command)
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
Merging spdx/spdx-linus (455e73a07f6e Merge tag 'clk-for-linus' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/clk/linux)
Merging gpio-brgl-fixes/gpio/for-current (32e246b02f53 MAINTAINERS: update =
gpio-brcmstb maintainers)
Merging gpio-intel-fixes/fixes (455e73a07f6e Merge tag 'clk-for-linus' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/clk/linux)
Merging pinctrl-intel-fixes/fixes (455e73a07f6e Merge tag 'clk-for-linus' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux)
Merging erofs-fixes/fixes (57bbeacdbee7 erofs: fix deadlock when shrink ero=
fs slab)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging ubifs-fixes/fixes (c3c07fc25f37 ubi: fastmap: Return error code if =
memory allocation fails in add_aeb())
Merging memblock-fixes/fixes (d7f55471db27 memblock: fix memblock_phys_allo=
c() section mismatch error)
Merging cel-fixes/for-rc (c9e6606c7fe9 Linux 5.16-rc8)
Merging irqchip-fixes/irq/irqchip-fixes (c3fbab7767c5 irqchip/irq-bcm7120-l=
2: Add put_device() after of_find_device_by_node())
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (133d9c53c9dc Merge tag 'x86_vdso_for_v5.1=
7_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging efi-fixes/urgent (4bc5e64e6cf3 efi: Move efifb_setup_from_dmi() pro=
totype from arch headers)
Merging zstd-fixes/zstd-linus (d58071a8a76d Linux 5.16-rc3)
Merging drm-misc-fixes/for-linux-next-fixes (54329e6f7bee dma-buf: cma_heap=
: Fix mutex locking section)
Merging kbuild/for-next (c4d7f40b250c kbuild: add cmd_file_size)
Merging perf/perf/core (c0dd94558d0e perf pmu-events: Don't lower case Metr=
icExpr)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (f857acfc457e lib/scatterlist: cleanup macros =
into static inline functions)
Merging asm-generic/master (733e417518a6 asm-generic/error-injection.h: fix=
 a spelling mistake, and a coding style issue)
Merging arc/for-next (6880fa6c5660 Linux 5.15-rc1)
Merging arm/for-next (599fbe7e4044 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (945409a6ef44 Merge branches 'for-next/misc', '=
for-next/cache-ops-dzp', 'for-next/stacktrace', 'for-next/xor-neon', 'for-n=
ext/kasan', 'for-next/armv8_7-fp', 'for-next/atomics', 'for-next/bti', 'for=
-next/sve', 'for-next/kselftest' and 'for-next/kcsan', remote-tracking bran=
ch 'arm64/for-next/perf' into for-next/core)
Merging arm-perf/for-next/perf (3da4390bcdf4 arm64: perf: Don't register us=
er access sysctl handler multiple times)
Merging arm-soc/for-next (317a42bd9204 ARM: Document merges)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (ac4dfd0d1d35 arm64: dts: add support for S4 based=
 Amlogic AQ222)
Merging aspeed/for-next (a7e02e92755c Merge branches 'dt-for-v5.17', 'defco=
nfig-for-v5.17' and 'soc-for-v5.17' into for-next)
Merging at91/at91-next (9be3df0e718c Merge branch 'at91-defconfig' into at9=
1-next)
Merging drivers-memory/for-next (ff086e15d838 Merge branch 'for-v5.17/omap-=
gpmc' into for-next)
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
Merging rockchip/for-next (2a9ed9fa8fe5 Merge branch 'v5.17-armsoc/dts64' i=
nto for-next)
Merging samsung-krzk/for-next (b1cbda0fc343 Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (a0708ab07633 Merge branch 'for-next/scmi' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
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
Merging clk/clk-next (4afd2a9355a9 Merge branches 'clk-ingenic' and 'clk-me=
diatek' into clk-next)
Merging clk-imx/for-next (9dd81021084f clk: imx8mp: Fix the parent clk of t=
he audio_root_clk)
Merging clk-renesas/renesas-clk (f0b62b0bbedc clk: renesas: r9a07g044: Add =
GPU clock and reset entries)
Merging clk-samsung/for-next (45bd8166a1d8 clk: samsung: Add initial Exynos=
7885 clock driver)
Merging csky/linux-next (a0793fdad9a1 csky: fix typo of fpu config macro)
Merging h8300/h8300-next (1ec10274d436 h8300: don't implement set_fs)
Merging m68k/for-next (1a0ae068bf6b m68k: defconfig: Update defconfigs for =
v5.16-rc1)
Merging m68knommu/for-next (a7904a538933 Linux 5.16-rc6)
Merging microblaze/next (7b94b7f0ae24 microblaze: add const to of_device_id)
Merging mips/mips-next (d3115128bdaf MIPS: ath79: drop _machine_restart aga=
in)
Merging nds32/next (07cd7745c6f2 nds32/setup: remove unused memblock_region=
 variable in setup_memory())
CONFLICT (content): Merge conflict in arch/nds32/Kconfig
CONFLICT (content): Merge conflict in arch/nds32/Kbuild
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (7f435e42fd6b openrisc: init: Add support for com=
mon clk)
Merging parisc-hd/for-next (c3c66aa221fa video/fbdev/stifb: Implement the s=
tifb_fillrect() function)
Merging powerpc/next (f1aa0e47c292 powerpc/xmon: Dump XIVE information for =
online-only processors.)
Merging soc-fsl/next (1ce93cb102e7 soc: fsl: qe: Check of ioremap return va=
lue)
Merging risc-v/for-next (b579dfe71a6a RISC-V: Use SBI SRST extension when a=
vailable)
CONFLICT (content): Merge conflict in arch/riscv/boot/dts/sifive/hifive-unm=
atched-a00.dts
Merging s390/for-next (31aca314b16a Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (db0dd9cee822 um: virtio_uml: Allow probing from dev=
icetree)
Merging xtensa/xtensa-for-next (71874374b46b xtensa: use strscpy to copy st=
rings)
Merging pidfd/for-next (317465bcc6f4 Merge branch 'fs.idmapped' into for-ne=
xt)
Merging fscrypt/master (b7e072f9b77f fscrypt: improve a few comments)
Merging fscache/fscache-next (bea21e602d8b cifs: Support fscache indexing r=
ewrite)
CONFLICT (content): Merge conflict in fs/cifs/inode.c
Merging afs/afs-next (52af7105eceb afs: Set mtime from the client for yfs c=
reate operations)
Merging btrfs/for-next (7aa1269834b4 Merge branch 'for-next-next-v5.16-2022=
0107' into for-next-20220107)
Merging ceph/master (a0b3a15eab6b ceph: move CEPH_SUPER_MAGIC definition to=
 magic.h)
Merging cifs/for-next (de4dbbf553ab cifs: fix FILE_BOTH_DIRECTORY_INFO defi=
nition)
Merging configfs/for-next (c42dd069be8d configfs: fix a race in configfs_lo=
okup())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (09c543798c3c erofs: use meta buffers for zmap operations)
Merging exfat/dev (3d966521a824 exfat: fix missing REQ_SYNC in exfat_update=
_bhs())
Merging ext3/for_next (5f0a61886e30 Pull Amir's FAN_RENAME and FAN_REPORT_T=
ARGET_FID support for fanotify.)
Merging ext4/dev (6eeaf88fd586 ext4: don't use the orphan list when migrati=
ng an inode)
Merging f2fs/dev (5fed0be8583f f2fs: do not allow partial truncation on pin=
ned file)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (073c3ab6ae01 Documentation/filesystem/dax: DAX on vi=
rtiofs)
Merging gfs2/for-next (74382e277ae9 gfs2: dump inode object for iopen glock=
s)
Merging jfs/jfs-next (c48a14dca2cb JFS: fix memleak in jfs_mount)
Merging ksmbd/ksmbd-for-next (136dff3a6b71 ksmbd: add smb-direct shutdown)
Merging nfs/linux-next (c9e6606c7fe9 Linux 5.16-rc8)
Merging nfs-anna/linux-next (fda451e77a5f sunrpc: Fix potential race condit=
ions in rpc_sysfs_xprt_state_change())
Merging nfsd/for-next (167208616753 SUNRPC: Fix sockaddr handling in svcsoc=
k_accept_class trace points)
Merging ntfs3/master (52e00ea6b26e fs/ntfs3: Update valid size if -EIOCBQUE=
UED)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (5b0a414d06c3 ovl: fix filattr copy-up fai=
lure)
Merging ubifs/next (aa39cc675799 jffs2: GC deadlock reading a page that is =
used in jffs2_write_begin())
Merging v9fs/9p-next (19d1c32652bb 9p: fix enodata when reading growing fil=
e)
Merging xfs/for-next (4a9bca86806f xfs: fix online fsck handling of v5 feat=
ure bits on secondary supers)
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
CONFLICT (content): Merge conflict in drivers/pci/controller/Kconfig
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/pci=
/ti,am65-pci-ep.yaml
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
Merging jc_docs/docs-next (87d6576ddf8a scripts: sphinx-pre-install: Fix ct=
ex support on Debian)
Merging v4l-dvb/master (68b9bcc8a534 media: ipu3-cio2: Add support for inst=
antiating i2c-clients for VCMs)
Merging v4l-dvb-next/master (8d4ff8187bb2 media: si2157: add support for DV=
B-C Annex C)
Merging pm/linux-next (93e5c8b5e46e Merge branch 'pm-core' into linux-next)
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
Merging mlx5-next/mlx5-next (685b1afd7911 net/mlx5: Introduce log_max_curre=
nt_uc_list_wr_supported bit)
Merging netfilter-next/master (fe8152b38d3a Merge tag 'devprop-5.17-rc1' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging ipvs-next/master (2b71e2c7b56c netfilter: nft_set_pipapo_avx2: remo=
ve redundant pointer lt)
Merging wireless-drivers-next/master (d430dffbe9dd mt76: mt7921: fix a poss=
ible race enabling/disabling runtime-pm)
Merging bluetooth/master (c07ba878ca19 Bluetooth: hci_sync: unlock on error=
 in hci_inquiry_result_with_rssi_evt())
Merging mac80211-next/master (8aaaf2f3af2a Merge git://git.kernel.org/pub/s=
cm/linux/kernel/git/netdev/net)
Merging mtd/mtd/next (9ce47e43a0f0 Merge tag 'nand/for-5.17' into mtd/next)
Merging nand/nand/next (2997e4871621 Merge tag 'memory-controller-drv-omap-=
5.17' into nand/next)
Merging spi-nor/spi-nor/next (5f340402bbfc mtd: spi-nor: Remove debugfs ent=
ries that duplicate sysfs entries)
Merging crypto/master (5f21d7d283dd crypto: af_alg - rewrite NULL pointer c=
heck)
Merging drm/drm-next (cb6846fbb83b Merge tag 'amd-drm-next-5.17-2021-12-30'=
 of ssh://gitlab.freedesktop.org/agd5f/linux into drm-next)
Merging drm-misc/for-linux-next (69e630016ef4 drm/atomic: Check new_crtc_st=
ate->active to determine if CRTC needs disable in self refresh mode)
Merging amdgpu/drm-next (d79cb3aeec11 drm/amdgpu: don't do resets on APUs w=
hich don't support it)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/inc/re=
source.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/core/d=
c_resource.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/core/d=
c.c
$ git reset --hard HEAD^
Merging next-20220113 version of amdgpu
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/inc/re=
source.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/core/d=
c_resource.c
[master a9454b6da91d] next-20220113/amdgpu
Merging drm-intel/for-linux-next (6ef295e34297 drm/i915/ttm: ensure we unma=
p when purging)
Merging drm-intel-gt/for-linux-next-gt (6ef295e34297 drm/i915/ttm: ensure w=
e unmap when purging)
Merging drm-tegra/drm/tegra/for-next (d210919dbdc8 drm/tegra: Add back arm_=
iommu_detach_device())
Merging drm-msm/msm-next (6ed95285382d drm/msm/a5xx: Fix missing CP_PROTECT=
 for SMMU on A540)
Merging imx-drm/imx-drm/next (20fbfc81e390 drm/imx: imx-tve: Make use of th=
e helper function devm_platform_ioremap_resource())
Merging etnaviv/etnaviv/next (cdd156955f94 drm/etnaviv: consider completed =
fence seqno in hang check)
Merging regmap/for-next (b56a7cbf40c8 regmap: debugfs: Fix indentation)
Merging sound/for-next (081c73701ef0 ALSA: hda: intel-dsp-config: reorder t=
he config table)
Merging sound-asoc/for-next (f7a6021aaf02 ASoC: cpcap: Check for NULL point=
er after calling of_get_child_by_name)
Merging modules/modules-next (285ac8dca4df kernel: Fix spelling mistake "co=
mpresser" -> "compressor")
Merging input/next (9df136b55522 Input: zinitix - add compatible for bt532)
CONFLICT (content): Merge conflict in drivers/input/misc/axp20x-pek.c
Merging block/for-next (077113fd4f40 Merge branch 'for-5.17/block' into for=
-next)
Merging device-mapper/for-next (eaac0b590a47 dm sysfs: use default_groups i=
n kobj_type)
Merging libata/for-next (e928da321f0b ata: pata_ali: remove redundant retur=
n statement)
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
Merging regulator/for-next (f2fbbf96ec26 Merge remote-tracking branch 'regu=
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
Merging tpmdd/next (d99a8af48a3d lib: remove redundant assignment to variab=
le ret)
Merging watchdog/master (ffd264bd152c watchdog: msc313e: Check if the WDT w=
as running at boot)
Merging iommu/next (66dc1b791c58 Merge branches 'arm/smmu', 'virtio', 'x86/=
amd', 'x86/vt-d' and 'core' into next)
Merging audit/next (ed98ea2128b6 audit: replace zero-length array with flex=
ible-array member)
Merging devicetree/for-next (e623611b4d3f Merge branch 'dt/linus' into dt/n=
ext)
Merging mailbox/mailbox-for-next (869b6ca39c08 dt-bindings: mailbox: Add mo=
re protocol and client ID)
Merging spi/for-next (238582f974ab Merge remote-tracking branch 'spi/for-5.=
16' into spi-linus)
Merging tip/auto-latest (85538cc07d6b Merge branch into tip/master: 'x86/co=
re')
Merging clockevents/timers/drivers/next (7647204c2e81 dt-bindings: timer: A=
dd Mstar MSC313e timer devicetree bindings documentation)
Merging edac/edac-for-next (3a8cccd0b519 Merge branch 'edac-amd64' into eda=
c-for-next)
Merging irqchip/irq/irqchip-next (cd448b24c621 Merge branch irq/misc-5.17 i=
nto irq/irqchip-next)
Merging ftrace/for-next (fa7e5a516e8c rtla: Add rtla timerlat hist document=
ation)
CONFLICT (content): Merge conflict in scripts/link-vmlinux.sh
$ git reset --hard HEAD^
Merging next-20220111 version of ftrace
Merging rcu/rcu/next (76a2b0bbce2c Merge branch 'kcsan.2021.12.09b' into HE=
AD)
Merging kvm/next (93bd3ba8c58e selftest: kvm: Add amx selftest)
CONFLICT (content): Merge conflict in arch/x86/kvm/pmu.c
CONFLICT (content): Merge conflict in arch/riscv/include/asm/sbi.h
CONFLICT (content): Merge conflict in arch/arm64/kvm/Makefile
CONFLICT (content): Merge conflict in arch/arm64/kvm/Kconfig
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
Merging ipmi/for-next (42e941eae9c0 ipmi: ssif: replace strlcpy with strscp=
y)
Merging driver-core/driver-core-next (feb7a43de5ef Merge tag 'irq-msi-2022-=
01-13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging usb/usb-next (455e73a07f6e Merge tag 'clk-for-linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/clk/linux)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (2585cf9dfaad Linux 5.16-rc5)
Merging usb-chipidea-next/for-usb-next (78665f57c3fa usb: chipidea: udc: ma=
ke controller hardware endpoint primed)
Merging tty/tty-next (455e73a07f6e Merge tag 'clk-for-linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/clk/linux)
Merging char-misc/char-misc-next (d47c7407b4c8 Merge tag 'gnss-5.17-rc1' of=
 https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss into char-misc-=
next)
Merging extcon/extcon-next (2da3db7f498d extcon: Deduplicate code in extcon=
_set_state_sync())
Merging gnss/gnss-next (547d2167c5c3 gnss: usb: add support for Sierra Wire=
less XM1210)
Merging phy-next/next (09d976b3e8e2 phy: cadence: Sierra: Add support for d=
erived reference clock output)
Merging soundwire/next (bb349fd2d580 soundwire: qcom: remove redundant vers=
ion number read)
Merging thunderbolt/next (fa487b2a900d thunderbolt: Add module parameter fo=
r CLx disabling)
Merging vfio/next (2bed2ced40c9 vfio/iommu_type1: replace kfree with kvfree)
Merging staging/staging-next (455e73a07f6e Merge tag 'clk-for-linus' of git=
://git.kernel.org/pub/scm/linux/kernel/git/clk/linux)
Merging iio/togreg (38ac2f038666 iio: chemical: sunrise_co2: set val parame=
ter only on success)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging icc/icc-next (01f8938ad036 Merge branch 'icc-qcm2290' into icc-next)
Merging dmaengine/next (bbd0ff07ed12 dt-bindings: dma-controller: Split int=
errupt fields in example)
Merging cgroup/for-next (27fe872b5169 Merge branch 'for-5.17-fixes' into fo=
r-next)
Merging scsi/for-next (556e72236781 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (2576e153cd98 scsi: nsp_cs: Check of ioremap retu=
rn value)
Merging vhost/linux-next (2e4cda633a22 vdpa/mlx5: Fix tracking of current n=
umber of VQs)
CONFLICT (content): Merge conflict in include/uapi/linux/virtio_iommu.h
CONFLICT (content): Merge conflict in drivers/iommu/virtio-iommu.c
Merging rpmsg/for-next (feb19d833fa1 Merge branches 'rproc-next', 'rpmsg-ne=
xt' and 'hwspinlock-next' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (ffe31c9ed35d gpio: rcar: Propagate errors =
from devm_request_irq())
Merging gpio-intel/for-next (455e73a07f6e Merge tag 'clk-for-linus' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/clk/linux)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (7442936633bd pinctrl: imx: fix assigning groups n=
ames)
Merging pinctrl-intel/for-next (455e73a07f6e Merge tag 'clk-for-linus' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/clk/linux)
Merging pinctrl-renesas/renesas-pinctrl (ea7e26ebe6a9 pinctrl: renesas: r8a=
779a0: Align comments)
Merging pinctrl-samsung/for-next (a382d568f144 pinctrl: samsung: Use platfo=
rm_get_irq_optional() to get the interrupt)
Merging pwm/for-next (3f0565451cc0 dt-bindings: pwm: Avoid selecting schema=
 on node name match)
Merging userns/for-next (a403df29789b ptrace/m68k: Stop open coding ptrace_=
report_syscall)
CONFLICT (content): Merge conflict in fs/nfsd/nfssvc.c
Applying: fix up for "lockd: use svc_set_num_threads() for thread start and=
 stop"
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (e89908201e25 selftests/vm: remove ARRAY_SIZE define=
 from individual tests)
Merging livepatching/for-next (32fdbc45ade0 Merge branch 'for-5.17/kallsyms=
' into for-next)
Merging coresight/next (efa56eddf5d5 coresight: core: Fix typo in a comment)
Merging rtc/rtc-next (a12ac1f0ffa4 dt-bindings: rtc: qcom-pm8xxx-rtc: updat=
e register numbers)
Merging nvdimm/libnvdimm-for-next (9e05e95ca8da iomap: Fix error handling i=
n iomap_zero_iter())
Merging at24/at24/for-next (d08aea21c89d eeprom: at24: Add support for 24c1=
025 EEPROM)
Merging ntb/ntb-next (fd913240d898 IDT: Fix Build warnings on some 32bit ar=
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
CONFLICT (content): Merge conflict in drivers/net/hyperv/netvsc.c
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
Merging mhi/mhi-next (00776ac534cc bus: mhi: pci_generic: Introduce Sierra =
EM919X support)
Merging memblock/for-next (a59466ee91aa memblock: Remove #ifdef __KERNEL__ =
from memblock.h)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging rust/rust-next (5f53f5dd0866 init/Kconfig: Specify the interpreter =
for rust-version.sh)
CONFLICT (modify/delete): tools/include/linux/lockdep.h deleted in HEAD and=
 modified in rust/rust-next. Version rust/rust-next of tools/include/linux/=
lockdep.h left in tree.
CONFLICT (content): Merge conflict in samples/Makefile
CONFLICT (content): Merge conflict in samples/Kconfig
CONFLICT (content): Merge conflict in Documentation/process/changes.rst
$ git rm -f tools/include/linux/lockdep.h
Merging cxl/next (be185c2988b4 cxl/core: Remove cxld_const_init in cxl_deco=
der_alloc())
Merging folio/for-next (6840f9094f2b pagevec: Initialise folio_batch->percp=
u_pvec_drained)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging bitmap/bitmap-master-5.15 (785cb064e2f8 vsprintf: rework bitmap_lis=
t_string)
CONFLICT (content): Merge conflict in drivers/dma/ti/edma.c
CONFLICT (content): Merge conflict in arch/s390/kvm/kvm-s390.c
CONFLICT (content): Merge conflict in arch/powerpc/include/asm/cputhreads.h
CONFLICT (content): Merge conflict in arch/parisc/include/asm/bitops.h
Merging zstd/zstd-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging efi/next (42f4046bc4ba efi: use default_groups in kobj_type)
Merging unicode/for-next (e2a58d2d3416 unicode: only export internal symbol=
s for the selftests)
CONFLICT (content): Merge conflict in fs/f2fs/sysfs.c
Merging slab/for-next (07f910f9b729 mm: Remove slab from struct page)
Merging random/master (7c82c3237147 lib/crypto: add prompts back to crypto =
libraries)
Merging landlock/next (2585cf9dfaad Linux 5.16-rc5)
Merging akpm-current/current (ae1ba7202dd5 ipc/sem: do not sleep with a spi=
n lock held)
CONFLICT (content): Merge conflict in net/ceph/ceph_common.c
CONFLICT (content): Merge conflict in mm/zsmalloc.c
CONFLICT (content): Merge conflict in mm/memremap.c
CONFLICT (content): Merge conflict in kernel/kthread.c
CONFLICT (content): Merge conflict in include/linux/kthread.h
CONFLICT (content): Merge conflict in include/linux/ceph/libceph.h
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (c4d51dbb1e28 mm: hide the FRONTSWAP Kconfig symbol)

--Sig_/LjIygG/55GUc/cffU9b7evc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHhBUYACgkQAVBC80lX
0Gzyrwf+PMTJZqNW7aYQpjeVw9rb/MfypFp35bPGFYsYrzdpHwC4RSaGi5tp2fLM
xVATzzmzyOUpBPlfZ7wHVaeAxGe7dZPMQa22+R6eLNw3DrUrJZoaGOJdtzgvNrls
6bQBWLIazs3SEa0NGiFmudWmnpmUhdSGmHqF2mZBqe/HiRtIA8ywxnxpw7wPoVAN
hxJ2UfPbrm+Rp4sD5wKjEKJlIcCrmJYoXw0WspL6T8TIltoPoavf+sXWLLyyxZo5
GZr3qLUiwIIEVx+t10CSzAwxDlAvZT2dbXjl3kYqbjxVYSPNyrC4l748G8bHSYkH
6vDFfO91waCz9xlFlWjTXUZhLS/LGg==
=8te2
-----END PGP SIGNATURE-----

--Sig_/LjIygG/55GUc/cffU9b7evc--
