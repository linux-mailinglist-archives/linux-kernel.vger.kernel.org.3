Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB96B49F27F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 05:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346036AbiA1E2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 23:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbiA1E2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 23:28:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDAEC061714;
        Thu, 27 Jan 2022 20:28:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JlPbZ0Y0Zz4xcH;
        Fri, 28 Jan 2022 15:28:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643344122;
        bh=wzp31bKjSTaUnpVUnQUlTXu4uMkXwkQ79P7XuWsQf8c=;
        h=Date:From:To:Cc:Subject:From;
        b=GT/d9Ty5a6qI6o2cC9t/MVu6/uC9Sw45A5ewQWrQeV3U8mO9Nj2qiTVH07sCLG3Jg
         H6hjtIH/uvdAJPrwxgmfQ8XAprDgX389aHUpbR3t7g7RFEOFvIDowOLcvxua+K3GNa
         tr68hHzV0zPqf8sNDGvT8YzpL4Fh/s0BsDXtJOf7e4w2zIV7tKUaN8PYHCgYFxF9Pp
         of0KwNIP1svxmd5s+itckfFG7WtTuSdhS7ASbQ1AmwNyzEPutN/K5rIufmFhYdhQi9
         8AzRz7Aecj1ASk9IDwW4z1Hnf7mGwtjKPY1iGSADdjUD6jUywTebVPp6IbrUy+TvR6
         1a3vdMiORavaw==
Date:   Fri, 28 Jan 2022 15:28:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 28
Message-ID: <20220128152840.1ffb8a74@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tnhu=8.B/RBamuEtFrQO=YL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tnhu=8.B/RBamuEtFrQO=YL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220127:

The amdgpu tree lost its build failure.

The phy-next tree gained a conflict against the qcom tree.

The akpm-current tree gained a semantic conflict against the kspp tree.

Non-merge commits (relative to Linus' tree): 2232
 2603 files changed, 104436 insertions(+), 31567 deletions(-)

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

I am currently merging 345 trees (counting Linus' and 93 trees of bug
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
Merging origin/master (23a46422c561 Merge tag 'net-5.17-rc2' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (e6340b6526ee certs: Fix build error when CONF=
IG_MODULE_SIG_KEY is empty)
Merging arc-current/for-curr (e783362eb54c Linux 5.17-rc1)
Merging arm-current/fixes (9f80ccda53b9 ARM: 9180/1: Thumb2: align ALT_UP()=
 sections in modules sufficiently)
Merging arm64-fixes/for-next/fixes (3758a6c74e08 arm64: extable: fix load_u=
naligned_zeropad() reg indices)
Merging arm-soc-fixes/arm/fixes (c8013355ead6 ARM: dts: gpio-ranges propert=
y is now required)
Merging drivers-memory-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging tee-fixes/fixes (d58071a8a76d Linux 5.16-rc3)
Merging m68k-current/for-linus (1a0ae068bf6b m68k: defconfig: Update defcon=
figs for v5.16-rc1)
Merging powerpc-fixes/fixes (8defc2a5dd8f powerpc/64s/interrupt: Fix decrem=
enter storm)
Merging s390-fixes/fixes (663d34c8df98 s390/hypfs: include z/VM guests with=
 access control group set)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (23a46422c561 Merge tag 'net-5.17-rc2' of git://git.kern=
el.org/pub/scm/linux/kernel/git/netdev/net)
Merging bpf/master (e2bcbd7769ee tools headers UAPI: remove stale lirc.h)
Merging ipsec/master (e03c3bba351f xfrm: Fix xfrm migrate issues when addre=
ss family changes)
Merging netfilter/master (eda0cf1202ac selftests: nft_concat_range: add tes=
t for reload with no element add/del)
Merging ipvs/master (eda0cf1202ac selftests: nft_concat_range: add test for=
 reload with no element add/del)
Merging wireless/main (67ab55956e64 Merge tag 'wireless-2022-01-21' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless)
Merging rdma-fixes/for-rc (e783362eb54c Linux 5.17-rc1)
Merging sound-current/for-linus (3da4b7403db8 ALSA: usb-audio: initialize v=
ariables that could ignore errors)
Merging sound-asoc-fixes/for-linus (4cf28e9ae6e2 ASoC: ops: Reject out of b=
ounds values in snd_soc_put_xr_sx())
Merging regmap-fixes/for-linus (b56a7cbf40c8 regmap: debugfs: Fix indentati=
on)
Merging regulator-fixes/for-linus (90a242e43045 Merge remote-tracking branc=
h 'regulator/for-5.16' into regulator-linus)
Merging spi-fixes/for-linus (99b6b7150060 Merge remote-tracking branch 'spi=
/for-5.16' into spi-linus)
Merging pci-current/for-linus (d884a217c4c5 PCI/sysfs: Find shadow ROM befo=
re static attribute initialization)
Merging driver-core.current/driver-core-linus (e783362eb54c Linux 5.17-rc1)
Merging tty.current/tty-linus (d1ad2721b1eb kbuild: remove include/linux/cy=
clades.h from header file check)
Merging usb.current/usb-linus (79aa3e19fe8f usb: cdnsp: Fix segmentation fa=
ult in cdns_lost_power function)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (e783362eb54c Linux 5.17-rc1)
Merging usb-chipidea-fixes/for-usb-fixes (f130d08a8d79 usb: chipidea: ci_hd=
rc_imx: Also search for 'phys' phandle)
CONFLICT (content): Merge conflict in drivers/usb/chipidea/ci_hdrc_imx.c
Merging phy/fixes (46e994717807 phy: phy-mtk-tphy: Fix duplicated argument =
in phy-mtk-tphy)
Merging staging.current/staging-linus (426aca16e903 staging: fbtft: Fix err=
or path in fbtft_driver_module_init())
Merging iio-fixes/fixes-togreg (ccbed9d8d2a5 iio: accel: fxls8962af: add pa=
dding to regmap for SPI)
Merging char-misc.current/char-misc-linus (fc55e63e148f counter: fix an IS_=
ERR() vs NULL bug)
Merging soundwire-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging thunderbolt-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging input-current/for-linus (762f99f4f3cb Merge branch 'next' into for-=
linus)
Merging crypto-current/master (5f21d7d283dd crypto: af_alg - rewrite NULL p=
ointer check)
Merging vfio-fixes/for-linus (8704e8934908 vfio/pci: Fix OpRegion read)
Merging kselftest-fixes/fixes (908a26e139e8 selftests/exec: Remove pipe fro=
m TEST_GEN_FILES)
Merging modules-fixes/modules-linus (2a987e65025e Merge tag 'perf-tools-fix=
es-for-v5.16-2021-12-07' of git://git.kernel.org/pub/scm/linux/kernel/git/a=
cme/linux)
Merging dmaengine-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (9161f365c916 mtd: rawnand: gpmi: don't leak PM=
 reference in error path)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (d40f0b133b44 media: meson-ir-tx: remove incorr=
ect doc comment)
Merging reset-fixes/reset/fixes (92c959bae2e5 reset: renesas: Fix Runtime P=
M usage)
Merging mips-fixes/mips-fixes (fa62f39dc7e2 MIPS: Fix build error due to PT=
R used in more places)
Merging at91-fixes/at91-fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging omap-fixes/fixes (80d680fdccba ARM: dts: omap3430-sdp: Fix NAND dev=
ice node)
Merging kvm-fixes/master (05a9e065059e KVM: x86: Sync the states size with =
the XCR0/IA32_XSS at, any time)
Merging kvms390-fixes/master (0e9ff65f455d KVM: s390: preserve deliverable_=
mask in __airqs_kick_single_vcpu)
Merging hwmon-fixes/hwmon (79da533d3cc7 hwmon: (nct6775) Fix crash in clear=
_caseopen)
Merging nvdimm-fixes/libnvdimm-fixes (3dd60fb9d95d nvdimm/pmem: stop using =
q_usage_count as external pgmap refcount)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (2e3528388d25 Merge branch 'misc-5.17' into =
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
Merging scsi-fixes/fixes (4db09593af0b scsi: myrs: Fix crash in error case)
Merging drm-fixes/drm-fixes (e783362eb54c Linux 5.17-rc1)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (e783362eb54c Linux 5.17-rc1)
Merging mmc-fixes/fixes (379f56c24e69 mmc: core: Wait for command setting '=
Power Off Notification' bit to complete)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (e783362eb54c Linux 5.17-rc1)
Merging hyperv-fixes/hyperv-fixes (9ff5549b1d1d video: hyperv_fb: Fix valid=
ation of screen resolution)
Merging soc-fsl-fixes/fix (8120bd469f55 soc: fsl: dpaa2-console: free buffe=
r before returning from dpaa2_console_read)
Merging risc-v-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (8bb7eca972ad Linux 5.15)
Merging spdx/spdx-linus (e783362eb54c Linux 5.17-rc1)
Merging gpio-brgl-fixes/gpio/for-current (8aa0f94b0a8d gpio: sim: add doc f=
ile to index file)
Merging gpio-intel-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging pinctrl-intel-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging erofs-fixes/fixes (7865827c432b erofs: avoid unnecessary z_erofs_de=
compressqueue_work() declaration)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (235528072f28 kunit: tool: Import missing i=
mportlib.abc)
Merging ubifs-fixes/fixes (c3c07fc25f37 ubi: fastmap: Return error code if =
memory allocation fails in add_aeb())
Merging memblock-fixes/fixes (d7f55471db27 memblock: fix memblock_phys_allo=
c() section mismatch error)
Merging cel-fixes/for-rc (3cb875519f0a nfsd: nfsd4_setclientid_confirm mist=
akenly expires confirmed client.)
Merging irqchip-fixes/irq/irqchip-fixes (c733ebb7cb67 irqchip/gic-v3-its: R=
eset each ITS's BASERn register before probe)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (e783362eb54c Linux 5.17-rc1)
Merging efi-fixes/urgent (f5390cd0b43c efi: runtime: avoid EFIv2 runtime se=
rvices on Apple x86 machines)
Merging zstd-fixes/zstd-linus (d58071a8a76d Linux 5.16-rc3)
Merging drm-misc-fixes/for-linux-next-fixes (7fde14d70598 drm/privacy-scree=
n: honor acpi=3Doff in detect_thinkpad_privacy_screen)
Merging kspp/for-next/kspp (04b68140dd39 Revert "ARM: stackprotector: prefe=
r compiler for TLS based per-task protector")
Applying: scsi: hack for building with -Warray-bounds
[master 4089c0125462] hack for building with -Warray-bounds
Applying: Revert "samples/trace_event: Add '__rel_loc' using sample event"
[master 7d8b0f88550e] hack for building with -Warray-bounds
Merging kspp-gustavo/for-next/kspp (c9e6606c7fe9 Linux 5.16-rc8)
Merging kbuild/for-next (c6553cd5dec6 usr/include/Makefile: add linux/nfc.h=
 to the compile-test coverage)
Merging perf/perf/core (e783362eb54c Linux 5.17-rc1)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (404f9373c4e5 swiotlb: simplify array allocati=
on)
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
Merging drivers-memory/for-next (691396e21c14 Merge branch 'for-v5.18/tegra=
' into for-next)
Merging imx-mxs/for-next (e104ee240f57 Merge branch 'imx/dt64' into for-nex=
t)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (896f47a2c39c Merge branch 'v5.17-next/dts64' int=
o for-next)
Merging mvebu/for-next (d835946fc3d8 Merge branch 'mvebu/dt' into mvebu/for=
-next)
Merging omap/for-next (61b6b9cfada4 Merge branch 'omap-for-v5.17/fixes-not-=
urgent' into for-next)
Merging qcom/for-next (2e4bf68168fa Merge branches 'arm64-for-5.18', 'dts-f=
or-5.18' and 'dts-fixes-for-5.17' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (1d26428af3fa Merge branches 'renesas-arm-dt-for-v5.18=
', 'renesas-drivers-for-v5.18' and 'renesas-dt-bindings-for-v5.18' into ren=
esas-next)
Merging reset/reset/next (89e7a6698fdd reset: uniphier-glue: Use devm_add_a=
ction_or_reset())
Merging rockchip/for-next (e022219292b5 Merge branch 'v5.17-armsoc/dtsfixes=
' into for-next)
Merging samsung-krzk/for-next (69fa3547bb9f Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (dd81e1c7d5fb Merge tag 'powerpc-5.17-2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging stm32/stm32-next (3ff0810ffc47 ARM: dts: stm32: Add Engicam i.Core =
STM32MP1 C.TOUCH 2.0 10.1" OF)
Merging sunxi/sunxi/for-next (d1c4c136bab7 Merge branch 'sunxi/dt-for-5.18'=
 into sunxi/for-next)
Merging tee/next (ce352be35ba0 Merge branch 'async_notif' into next)
Merging tegra/for-next (3a8b00198194 Merge branch for-5.17/arm/defconfig in=
to for-next)
Merging ti/ti-next (e66d73b2aa76 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (3a14f0e61408 arm64: zynqmp: Rename dma to dma-cont=
roller)
Merging clk/clk-next (28c7bbb2a3fc Merge branch 'clk-kunit' into clk-next)
Merging clk-imx/for-next (b3b1283eba5c clk: imx: Add imx8dxl clk driver)
Merging clk-renesas/renesas-clk (9b621b6adff5 clk: renesas: r8a779a0: Add C=
ANFD module clock)
Merging clk-samsung/for-next (45bd8166a1d8 clk: samsung: Add initial Exynos=
7885 clock driver)
Merging csky/linux-next (a0793fdad9a1 csky: fix typo of fpu config macro)
Merging h8300/h8300-next (1ec10274d436 h8300: don't implement set_fs)
Merging m68k/for-next (a9940f83a6e2 m68k: Add asm/config.h)
Merging m68knommu/for-next (7d436b2671fe m68knommu: fix ucsimm sparse warni=
ngs)
Merging microblaze/next (fcc619621df5 microblaze/PCI: Remove pci_phys_mem_a=
ccess_prot() dead code)
Merging mips/mips-next (e783362eb54c Linux 5.17-rc1)
Merging nds32/next (07cd7745c6f2 nds32/setup: remove unused memblock_region=
 variable in setup_memory())
CONFLICT (content): Merge conflict in arch/nds32/Kbuild
CONFLICT (content): Merge conflict in arch/nds32/Kconfig
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (7f435e42fd6b openrisc: init: Add support for com=
mon clk)
Merging parisc-hd/for-next (408e65598f96 parisc: Fix data TLB miss in sba_u=
nmap_sg)
Merging powerpc/next (29ec39fcf11e Merge tag 'powerpc-5.17-1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging soc-fsl/next (1ce93cb102e7 soc: fsl: qe: Check of ioremap return va=
lue)
Merging risc-v/for-next (e783362eb54c Linux 5.17-rc1)
Merging s390/for-next (ce7eefa1c265 Merge branch 'fixes' into for-next)
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
Merging fscache/fscache-next (dd81e1c7d5fb Merge tag 'powerpc-5.17-2' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging afs/afs-next (52af7105eceb afs: Set mtime from the client for yfs c=
reate operations)
Merging btrfs/for-next (36793b90df30 Merge branch 'for-next-next-v5.17-2022=
0126' into for-next-20220126)
Merging ceph/master (4584a768f22b ceph: set pool_ns in new inode layout for=
 async creates)
Merging cifs/for-next (e783362eb54c Linux 5.17-rc1)
Merging configfs/for-next (c42dd069be8d configfs: fix a race in configfs_lo=
okup())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (e783362eb54c Linux 5.17-rc1)
Merging exfat/dev (dd81e1c7d5fb Merge tag 'powerpc-5.17-2' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging ext3/for_next (1a26188f0b18 Pull UDF inode fixes and quota cleanup.)
Merging ext4/dev (b0544c1f23dd jbd2: refactor wait logic for transaction up=
dates into a common function)
Merging f2fs/dev (7d19e3dab000 f2fs: fix to enable ATGC correctly via gc_id=
le sysfs interface)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (073c3ab6ae01 Documentation/filesystem/dax: DAX on vi=
rtiofs)
Merging gfs2/for-next (72744f509650 gfs2: Fix gfs2_release for non-writers =
regression)
Merging jfs/jfs-next (c48a14dca2cb JFS: fix memleak in jfs_mount)
Merging ksmbd/ksmbd-for-next (9ca8581e79e5 ksmbd: fix SMB 3.11 posix extens=
ion mount failure)
Merging nfs/linux-next (c9e6606c7fe9 Linux 5.16-rc8)
Merging nfs-anna/linux-next (aed28b7a2d62 SUNRPC: Don't dereference xprt->s=
nd_task if it's a cookie)
Merging nfsd/for-next (35cdb07f917d SUNRPC: Remove the .svo_enqueue_xprt me=
thod)
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
Merging iomap/iomap-for-next (ebb7fb1557b1 xfs, iomap: limit individual ioe=
nd chain lengths in writeback)
Merging djw-vfs/vfs-for-next (d03ef4daf33a fs: forbid invalid project ID)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (8f40da9494cf Merge branch 'misc.namei' into for-next)
Merging printk/for-next (65c2c0709d8e Merge branch 'rework/fast-next-seq' i=
nto for-next)
Merging pci/next (87c71931633b Merge branch 'pci/driver-cleanup')
Merging pstore/for-next/pstore (a5d05b07961a pstore/ftrace: Allow immediate=
 recording)
Merging hid/for-next (9fc23e57bb60 Merge branch 'for-5.18/amd-sfh' into for=
-next)
Merging i2c/i2c/for-next (e783362eb54c Linux 5.17-rc1)
Merging i3c/i3c/next (13462ba1815d i3c: master: dw: check return of dw_i3c_=
master_get_free_pos())
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (468630091675 hwmon: (powr1220) Add suppor=
t for Lattice's POWR1014 power manager IC)
Merging jc_docs/docs-next (869f496e1aa6 docs: process: submitting-patches: =
Clarify the Reported-by usage)
Merging v4l-dvb/master (e783362eb54c Linux 5.17-rc1)
Merging v4l-dvb-next/master (7dc5fc6d3bd6 media: mtk-cir: simplify code)
Merging pm/linux-next (52d883c7bbae Merge branches 'acpica', 'acpi-osl' and=
 'acpi-properties' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (d776790a5536 cpufreq: mediatek-=
hw: Fix double devm_remap in hotplug case)
Merging cpupower/cpupower (101025ff8e47 tools/power/cpupower/{ToDo =3D> TOD=
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
Merging rdma/for-next (e783362eb54c Linux 5.17-rc1)
Merging net-next/master (72d044e4bfa6 Merge git://git.kernel.org/pub/scm/li=
nux/kernel/git/netdev/net)
Merging bpf-next/for-next (b6ec79518ef0 bpf, x86: Remove unnecessary handli=
ng of BPF_SUB atomic op)
Merging ipsec-next/master (fe8152b38d3a Merge tag 'devprop-5.17-rc1' of git=
://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging mlx5-next/mlx5-next (cac3231cc684 mlx5: remove usused static inline=
s)
Merging netfilter-next/master (40cd4f1550d0 nfp: flower: Use struct_size() =
helper in kmalloc())
Merging ipvs-next/master (40cd4f1550d0 nfp: flower: Use struct_size() helpe=
r in kmalloc())
Merging bluetooth/master (91cb4c19118a Bluetooth: Increment management inte=
rface revision)
Merging wireless-next/main (53243d412ec5 net: use bool values to pass bool =
param of phy_init_eee())
Merging mtd/mtd/next (ca6263a0c950 mtd_blkdevs: avoid soft lockups with som=
e mtd/spi devices)
Merging nand/nand/next (d430e4acd99f mtd: rawnand: brcmnand: Fix sparse war=
nings in bcma_nand)
Merging spi-nor/spi-nor/next (5f340402bbfc mtd: spi-nor: Remove debugfs ent=
ries that duplicate sysfs entries)
Merging crypto/master (5f21d7d283dd crypto: af_alg - rewrite NULL pointer c=
heck)
Merging drm/drm-next (e783362eb54c Linux 5.17-rc1)
Merging drm-misc/for-linux-next (d3cbc6e323c9 drm: panel-orientation-quirks=
: Add quirk for the 1Netbook OneXPlayer)
Merging amdgpu/drm-next (af60f9540e16 drm/amdgpu/smu11.5: restore cclks in =
vangogh_set_performance_level)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_drv=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dce110=
/dce110_hw_sequencer.c
Merging drm-intel/for-linux-next (516b33460c5b drm/i915/adlp: Fix TypeC PHY=
-ready status readout)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_reg.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_pm.c
Merging drm-intel-gt/for-linux-next-gt (c36846f39179 drm/i915: delete shado=
w "ret" variable)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_drv.h
Applying: merge fix for "drm/i915: split out i915_gem_evict.h from i915_drv=
.h"
Applying: extra merge fix for "drm/i915: split out i915_gem_evict.h from i9=
15_drv.h"
Applying: extra 2 merge fix for "drm/i915: split out i915_gem_evict.h from =
i915_drv.h"
Merging drm-tegra/drm/tegra/for-next (22d7ee32f1fb gpu: host1x: Fix hang on=
 Tegra186+)
Merging drm-msm/msm-next (6aa89ae1fb04 drm/msm/gpu: Cancel idle/boost work =
on suspend)
Merging imx-drm/imx-drm/next (20fbfc81e390 drm/imx: imx-tve: Make use of th=
e helper function devm_platform_ioremap_resource())
Merging etnaviv/etnaviv/next (cdd156955f94 drm/etnaviv: consider completed =
fence seqno in hang check)
Merging fbdev/for-next (f7d4ead792c8 video: fbdev: controlfb: Fix COMPILE_T=
EST build)
Merging regmap/for-next (1056c41634d4 regmap-irq: Fix typo in comment)
Merging sound/for-next (88b613224894 kselftest: alsa: Add test case for wri=
ting invalid values)
Merging sound-asoc/for-next (acfa1e2c2ff5 ASoC: sh: rz-ssi: Remove duplicat=
e macros)
Merging modules/modules-next (a97ac8cb24a3 module: fix signature check fail=
ures when using in-kernel decompression)
Merging input/next (87a0b2fafc09 Merge tag 'v5.16' into next)
CONFLICT (content): Merge conflict in drivers/input/misc/axp20x-pek.c
Merging block/for-next (bb1debf80c33 Merge branch 'for-5.18/block' into for=
-next)
Merging device-mapper/for-next (eaac0b590a47 dm sysfs: use default_groups i=
n kobj_type)
Merging libata/for-next (b875b39e7373 ata: pata_octeon_cf: fix call to trac=
e_ata_bmdma_stop())
Merging pcmcia/pcmcia-next (fbb3485f1f93 pcmcia: fix setting of kthread tas=
k states)
Merging mmc/next (c7d3bacbbfbb Merge branch 'fixes' into next)
Merging mfd/for-mfd-next (e565615c5486 mfd: google,cros-ec: Fix property na=
me for MediaTek rpmsg)
Merging backlight/for-backlight-next (ec961cf32411 backlight: qcom-wled: Re=
spect enabled-strings in set_brightness)
Merging battery/for-next (e783362eb54c Linux 5.17-rc1)
Merging regulator/for-next (8e9977e48c7c regulator: pfuze100: Add missing r=
egulator names)
Merging security/next-testing (047843bdb316 Merge branch 'landlock_lsm_v34'=
 into next-testing)
Merging apparmor/apparmor-next (5f42e6a8ca26 apparmor: Use struct_size() he=
lper in kmalloc())
Merging integrity/next-integrity (65e38e32a959 selftests/kexec: Enable secu=
reboot tests for PowerPC)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (b5e68162f859 selinux: drop unused macro)
Merging smack/next (e783362eb54c Linux 5.17-rc1)
Merging tomoyo/master (f702e1107601 tomoyo: use hwight16() in tomoyo_domain=
_quota_is_ok())
Merging tpmdd/next (a33f5c380c4b Merge tag 'xfs-5.17-merge-3' of git://git.=
kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging watchdog/master (ffd264bd152c watchdog: msc313e: Check if the WDT w=
as running at boot)
Merging iommu/next (66dc1b791c58 Merge branches 'arm/smmu', 'virtio', 'x86/=
amd', 'x86/vt-d' and 'core' into next)
Merging audit/next (e783362eb54c Linux 5.17-rc1)
Merging devicetree/for-next (a55e715b7c71 dt-bindings: watchdog: fsl-imx7ul=
p-wdt: Fix assigned-clock-parents)
Merging mailbox/mailbox-for-next (869b6ca39c08 dt-bindings: mailbox: Add mo=
re protocol and client ID)
Merging spi/for-next (474fc2e6395d spi: spi-mtk-nor: make some internal var=
iables static)
Merging tip/auto-latest (8954ec22b654 Merge perf/urgent into tip/master)
Merging clockevents/timers/drivers/next (7647204c2e81 dt-bindings: timer: A=
dd Mstar MSC313e timer devicetree bindings documentation)
Merging edac/edac-for-next (625c6b556997 EDAC: Use default_groups in kobj_t=
ype)
Merging irqchip/irq/irqchip-next (cd448b24c621 Merge branch irq/misc-5.17 i=
nto irq/irqchip-next)
Merging ftrace/for-next (6b9b6413700e ftrace: Fix assuming build time sort =
works for s390)
Merging rcu/rcu/next (96a9263ec15d srcu: Use invalid initial value for srcu=
_node GP sequence numbers)
Merging kvm/next (05a9e065059e KVM: x86: Sync the states size with the XCR0=
/IA32_XSS at, any time)
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
Merging chrome-platform/for-next (664de6a26b7f MAINTAINERS: platform-chrome=
: Add new chrome-platform@lists.linux.dev list)
Merging hsi/for-next (e783362eb54c Linux 5.17-rc1)
Merging leds/for-next (d949edb503b1 leds: lp55xx: initialise output directi=
on from dts)
Merging ipmi/for-next (d134ad2574a1 ipmi: ssif: replace strlcpy with strscp=
y)
Merging driver-core/driver-core-next (c6479f19e257 ubifs: use default_group=
s in kobj_type)
Merging usb/usb-next (993a44fa85c1 usb: gadget: f_uac2: allow changing inte=
rface name via configfs)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (e783362eb54c Linux 5.17-rc1)
Merging usb-chipidea-next/for-usb-next (78665f57c3fa usb: chipidea: udc: ma=
ke controller hardware endpoint primed)
Merging tty/tty-next (e41752c0e79b serial: mcf: use helpers in mcf_tx_chars=
())
Merging char-misc/char-misc-next (710f8af199ee eeprom: at25: Replace strncp=
y() with strscpy())
Merging extcon/extcon-next (2da3db7f498d extcon: Deduplicate code in extcon=
_set_state_sync())
Merging gnss/gnss-next (e783362eb54c Linux 5.17-rc1)
Merging phy-next/next (e7393b60a14f dt-bindings: phy: convert Qualcomm USB =
HS phy to yaml)
CONFLICT (modify/delete): Documentation/devicetree/bindings/phy/qcom,usb-hs=
-phy.txt deleted in phy-next/next and modified in HEAD.  Version HEAD of Do=
cumentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt left in tree.
$ git rm -f Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
Applying: merge fix for "dt-bindings: phy: qcom,usb-hs-phy: add MSM8226 com=
patible"
Merging soundwire/next (e783362eb54c Linux 5.17-rc1)
Merging thunderbolt/next (97486e981ffb thunderbolt: Remove useless DMA-32 f=
allback configuration)
Merging vfio/next (2bed2ced40c9 vfio/iommu_type1: replace kfree with kvfree)
Merging staging/staging-next (64b2d6ffff86 staging: mt7621-dts: align reset=
s with binding documentation)
Merging iio/togreg (38ac2f038666 iio: chemical: sunrise_co2: set val parame=
ter only on success)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging icc/icc-next (01f8938ad036 Merge branch 'icc-qcm2290' into icc-next)
Merging dmaengine/next (e783362eb54c Linux 5.17-rc1)
Merging cgroup/for-next (27fe872b5169 Merge branch 'for-5.17-fixes' into fo=
r-next)
Merging scsi/for-next (9583aa8cb59e Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (0790797aca03 scsi: scsi_debug: Add environmental=
 reporting log subpage)
Merging vhost/linux-next (fae0bd40fab0 virtio_console: break out of buf pol=
l on remove)
Merging rpmsg/for-next (d42cd7930649 Merge branches 'hwspinlock-next', 'rpr=
oc-fixes' and 'rpmsg-fixes' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (8bdc849f7696 dt-bindings: gpio: fix gpio-h=
og example)
Merging gpio-intel/for-next (a1ce76e89907 gpio: tps68470: Allow building as=
 module)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (8ef7a5bfbb60 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (689e00887740 pinctrl: baytrail: Clear direc=
t_irq_en flag on broken configs)
Merging pinctrl-renesas/renesas-pinctrl (9d6ae5b72f78 pinctrl: renesas: Kco=
nfig: Select PINCTRL_RZG2L if RZ/V2L SoC is enabled)
Merging pinctrl-samsung/for-next (0d1b662c374c pinctrl: samsung: add FSD So=
C specific data)
Merging pwm/for-next (3f0565451cc0 dt-bindings: pwm: Avoid selecting schema=
 on node name match)
Merging userns/for-next (f9d87929d451 ucount:  Make get_ucount a safe get_u=
ser replacement)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (57765eb4d4b7 selftests/kselftest/runner.sh: Pass op=
tional command parameters in environment)
Merging livepatching/for-next (32fdbc45ade0 Merge branch 'for-5.17/kallsyms=
' into for-next)
Merging coresight/next (cc3154d9fe55 coresight: trbe: Work around the trace=
 data corruption)
Merging rtc/rtc-next (5ceee540fdc7 rtc: sunplus: fix return value in sp_rtc=
_probe())
Merging nvdimm/libnvdimm-for-next (9e05e95ca8da iomap: Fix error handling i=
n iomap_zero_iter())
Merging at24/at24/for-next (e783362eb54c Linux 5.17-rc1)
Merging ntb/ntb-next (b31b0d5d6379 IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (1e6d69c7b9cd selftests/seccomp: Report ev=
ent mismatches more clearly)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (7cc2f34e1f4d fsi: sbefifo: Use interruptible mutex lockin=
g)
Merging slimbus/for-next (e783362eb54c Linux 5.17-rc1)
Merging nvmem/for-next (8043480a8cef nvmem: qfprom: fix kerneldoc warning)
Merging xarray/main (1c9f4b00b3cf XArray: Document the locking requirement =
for the xa_state)
Merging hyperv/hyperv-next (4eea5332d67d scsi: storvsc: Fix storvsc_queueco=
mmand() memory leak)
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
Merging kunit-next/kunit (6125a5c70acd kunit: decrease macro layering for E=
Q/NE asserts)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (fd692f3d8ff3 bus: mhi: Add mru_default for Cinterion =
MV31-W)
Merging memblock/for-next (a59466ee91aa memblock: Remove #ifdef __KERNEL__ =
from memblock.h)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (be185c2988b4 cxl/core: Remove cxld_const_init in cxl_deco=
der_alloc())
Merging folio/for-next (3abb28e275bf filemap: Use folio_put_refs() in filem=
ap_free_folio())
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging efi/next (42f4046bc4ba efi: use default_groups in kobj_type)
Merging unicode/for-next (5298d4bfe80f unicode: clean up the Kconfig symbol=
 confusion)
Merging slab/for-next (07f910f9b729 mm: Remove slab from struct page)
Merging random/master (86ece078c890 lib/crypto: blake2s: avoid indirect cal=
ls to compression function for Clang CFI)
Merging landlock/next (2585cf9dfaad Linux 5.16-rc5)
Merging rust/rust-next (ced9f62ec435 init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
CONFLICT (content): Merge conflict in Documentation/process/changes.rst
CONFLICT (content): Merge conflict in samples/Kconfig
CONFLICT (content): Merge conflict in samples/Makefile
Merging akpm-current/current (205934f054d2 ipc/sem: do not sleep with a spi=
n lock held)
Applying: similar to "kasan: test: fix compatibility with FORTIFY_SOURCE"
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (76dd1181ca89 sysctl: documentation: fix table format w=
arning)

--Sig_/tnhu=8.B/RBamuEtFrQO=YL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHzcPkACgkQAVBC80lX
0GydMAf+Ka6MXdRw571H7xE5Sjh22pxX7ve1TukAkCPoFOXCAbH+dlxcO/3RJNTE
IaQ02pjsKo6MshvsVns9e+cHDgX0Rw1IF+IAuEHzGz6uKK56foa17gShlnEOMeCr
ObKPPwa4u4tfSF2GfiqOJBHh6bqNjhhtSK2kIWsS2Xmh+4uBMYKdmUkVpSSvLDq+
LJAJ4pecXQW/1R+Q/4KW+szdRDez8sJPLHFPKcfINYYCLb+EynuUg/qu5ENjyTRT
tctHRxyRjlCqURi5/Pa/3nxIsjirD3UAvfR7881AioYc0jWFgT8RTrlsWbYgthyw
UjF5Us497kgXQab23+FIwfTL/y/vAQ==
=Dbg4
-----END PGP SIGNATURE-----

--Sig_/tnhu=8.B/RBamuEtFrQO=YL--
