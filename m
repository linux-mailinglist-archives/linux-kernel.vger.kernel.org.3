Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD4A4AD119
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347065AbiBHFiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243927AbiBHFhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:37:50 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CADCC0302D9;
        Mon,  7 Feb 2022 21:33:57 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JtBWh70Fhz4xdL;
        Tue,  8 Feb 2022 16:33:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644298433;
        bh=9q3sspWS62Ul7lwMciYd3geOTf+LgjEBMaBKhCoL1x4=;
        h=Date:From:To:Cc:Subject:From;
        b=d94dFXWPuDXKhwBmiT87fMwVURimn87CrbOGsPgcQKPNvEretyXYcXoqB3nqtLC8a
         fW+sYwOpayTgQWUGPX0H/tWG5wErJ6GJjL2c3J72swX0yxyyXUYXyEyVHlg03X9FH4
         iZmn9NA8hX6H0BXhfu9a6FrKrjytUx95LptlYGILNlVMa3u6F+HdAO7WsGkLxDlK1a
         JCAQLwlXh+N9TkywWOmPiCz+nYNWaOfyK8euXaP2BVRuW193eC4y2t+kaEzu4TOe0r
         wUlcFUOlSy5CE7ZIMPDIB9lixIX5rUpuJJyr1kqMT6jz+blzP2fyD/8cqUlU+WVSHj
         2ULsBNQs8MGtg==
Date:   Tue, 8 Feb 2022 16:33:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 8
Message-ID: <20220208163351.311bfa25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Lsgoi2bO_X1riE187+3QvdM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Lsgoi2bO_X1riE187+3QvdM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220207:

The pm tree gained a conflict against the i2c tree.

The folio tree still had its build failure so I used the version from
next-20220204.

Non-merge commits (relative to Linus' tree): 3881
 4227 files changed, 162331 insertions(+), 57194 deletions(-)

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
Merging origin/master (2ade8eef993c Merge tag 'ata-5.17-rc4' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/dlemoal/libata)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (e6340b6526ee certs: Fix build error when CONF=
IG_MODULE_SIG_KEY is empty)
Merging arc-current/for-curr (f982d9b7c628 arc: remove set_fs())
Merging arm-current/fixes (9f80ccda53b9 ARM: 9180/1: Thumb2: align ALT_UP()=
 sections in modules sufficiently)
Merging arm64-fixes/for-next/fixes (a4b92cebc31d arm64: Enable Cortex-A510 =
erratum 2051678 by default)
Merging arm-soc-fixes/arm/fixes (dfd42facf1e4 Linux 5.17-rc3)
Merging drivers-memory-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging tee-fixes/fixes (7e3c6eb44c91 Merge tags 'optee-fixes-for-v5.17' an=
d 'optee-fix-for-v5.17' into fixes)
Merging m68k-current/for-linus (1a0ae068bf6b m68k: defconfig: Update defcon=
figs for v5.16-rc1)
Merging powerpc-fixes/fixes (8defc2a5dd8f powerpc/64s/interrupt: Fix decrem=
enter storm)
Merging s390-fixes/fixes (e286f231eab4 s390/module: fix building test_modul=
es_helpers.o with clang)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (94fdd7c02a56 net/smc: use GFP_ATOMIC allocation in smc_=
pnet_add_eth())
Merging bpf/master (fe68195daf34 ixgbevf: Require large buffers for build_s=
kb on 82599VF)
Merging ipsec/master (a6d95c5a628a Revert "xfrm: xfrm_state_mtu should retu=
rn at least 1280 for ipv6")
Merging netfilter/master (59085208e4a2 net: mscc: ocelot: fix all IP traffi=
c getting trapped to CPU with PTP over IP)
Merging ipvs/master (7674b7b559b6 net: amd-xgbe: ensure to reset the tx_tim=
er_active flag)
Merging wireless/main (f0a6fd152706 cfg80211: fix race in netlink owner int=
erface destruction)
Merging rdma-fixes/for-rc (dfd42facf1e4 Linux 5.17-rc3)
Merging sound-current/for-linus (52517d9c0c01 Merge tag 'asoc-fix-v5.17-rc2=
' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for=
-linus)
Merging sound-asoc-fixes/for-linus (618c2dc667c8 ASoC: ops: Fix stereo chan=
ge notifications)
Merging regmap-fixes/for-linus (8419f8e559a7 regmap-irq: Use regmap_irq_upd=
ate_bits instead of regmap_write)
Merging regulator-fixes/for-linus (1301ba2d6596 Merge remote-tracking branc=
h 'regulator/for-5.16' into regulator-linus)
Merging spi-fixes/for-linus (9104f6b46783 Merge remote-tracking branch 'spi=
/for-5.16' into spi-linus)
Merging pci-current/for-linus (7dd3876205df PCI: kirin: Add dev struct for =
of_device_get_match_data())
Merging driver-core.current/driver-core-linus (e783362eb54c Linux 5.17-rc1)
Merging tty.current/tty-linus (28cb138f559f vt_ioctl: add array_index_nospe=
c to VT_ACTIVATE)
Merging usb.current/usb-linus (5432184107cd usb: gadget: f_uac2: Define spe=
cific wTerminalType)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (6ca0c6283340 USB: serial: cp210x: add C=
PI Bulk Coin Recycler id)
Merging usb-chipidea-fixes/for-usb-fixes (f130d08a8d79 usb: chipidea: ci_hd=
rc_imx: Also search for 'phys' phandle)
CONFLICT (content): Merge conflict in drivers/usb/chipidea/ci_hdrc_imx.c
Merging phy/fixes (9a8406ba1a9a phy: dphy: Correct clk_pre parameter)
Merging staging.current/staging-linus (426aca16e903 staging: fbtft: Fix err=
or path in fbtft_driver_module_init())
Merging iio-fixes/fixes-togreg (ea85bf906466 iio: imu: st_lsm6dsx: wait for=
 settling time in st_lsm6dsx_read_oneshot)
Merging char-misc.current/char-misc-linus (05daa805a86c bus: mhi: pci_gener=
ic: Add mru_default for Cinterion MV31-W)
Merging soundwire-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging thunderbolt-fixes/fixes (dfd42facf1e4 Linux 5.17-rc3)
Merging input-current/for-linus (762f99f4f3cb Merge branch 'next' into for-=
linus)
Merging crypto-current/master (c6ce9c5831ca crypto: api - Move cryptomgr so=
ft dependency into algapi)
Merging vfio-fixes/for-linus (8704e8934908 vfio/pci: Fix OpRegion read)
Merging kselftest-fixes/fixes (183f80fd72db selftests/ir: fix build with an=
cient kernel headers)
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
Merging mips-fixes/mips-fixes (dfd42facf1e4 Linux 5.17-rc3)
Merging at91-fixes/at91-fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging omap-fixes/fixes (80d680fdccba ARM: dts: omap3430-sdp: Fix NAND dev=
ice node)
Merging kvm-fixes/master (7e6a6b400db8 Merge tag 'kvmarm-fixes-5.17-2' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
Merging kvms390-fixes/master (0e9ff65f455d KVM: s390: preserve deliverable_=
mask in __airqs_kick_single_vcpu)
Merging hwmon-fixes/hwmon (bb9bb9c75482 hwmon: (ntc_thermistor) Underscore =
Samsung thermistor)
Merging nvdimm-fixes/libnvdimm-fixes (3dd60fb9d95d nvdimm/pmem: stop using =
q_usage_count as external pgmap refcount)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (c30ef1bf06ac Merge branch 'misc-5.17' into =
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
Merging scsi-fixes/fixes (c763ec4c10f7 scsi: hisi_sas: Fix setting of hisi_=
sas_slot.is_internal)
Merging drm-fixes/drm-fixes (dfd42facf1e4 Linux 5.17-rc3)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (4e6f55120c7e drm/i915: Workar=
ound broken BIOS DBUF configuration on TGL/RKL)
Merging mmc-fixes/fixes (bd2db32e7c3e moxart: fix potential use-after-free =
on remove path)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (e783362eb54c Linux 5.17-rc1)
Merging hyperv-fixes/hyperv-fixes (6bf625a4140f Drivers: hv: vmbus: Rework =
use of DMA_BIT_MASK(64))
Merging soc-fsl-fixes/fix (8120bd469f55 soc: fsl: dpaa2-console: free buffe=
r before returning from dpaa2_console_read)
Merging risc-v-fixes/fixes (ca0cb9a60f6d riscv/mm: Add XIP_FIXUP for riscv_=
pfn_base)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (8bb7eca972ad Linux 5.15)
Merging spdx/spdx-linus (e783362eb54c Linux 5.17-rc1)
Merging gpio-brgl-fixes/gpio/for-current (2cba05451a6d gpio: aggregator: Fi=
x calling into sleeping GPIO controllers)
Merging gpio-intel-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging pinctrl-intel-fixes/fixes (500c77eed0fe pinctrl: zynqmp: Revert "Un=
ify pin naming")
Merging erofs-fixes/fixes (24331050a3e6 erofs: fix small compressed files i=
nlining)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (de4d73b16d5d kunit: fix missing f in f-str=
ing in run_checks.py)
Merging ubifs-fixes/fixes (c3c07fc25f37 ubi: fastmap: Return error code if =
memory allocation fails in add_aeb())
Merging memblock-fixes/fixes (d7f55471db27 memblock: fix memblock_phys_allo=
c() section mismatch error)
Merging cel-fixes/for-rc (accd66d0a0a3 NFSD: Deprecate NFS_OFFSET_MAX)
Merging irqchip-fixes/irq/irqchip-fixes (1d4df649cbb4 irqchip/sifive-plic: =
Add missing thead,c900-plic match string)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (dfd42facf1e4 Linux 5.17-rc3)
Merging efi-fixes/urgent (f5390cd0b43c efi: runtime: avoid EFIv2 runtime se=
rvices on Apple x86 machines)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging drm-misc-fixes/for-linux-next-fixes (200e8e3e43c4 drm/privacy-scree=
n: Fix sphinx warning)
Merging kspp/for-next/kspp (9327f2939dc4 Merge branch 'for-next/hardening' =
into for-next/kspp)
Applying: scsi: hack for building with -Warray-bounds
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
Merging arm/for-next (ed43eed0a6ac Merge branch 'devel-stable' into for-nex=
t)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
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
Merging imx-mxs/for-next (afb77a29073e Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (896f47a2c39c Merge branch 'v5.17-next/dts64' int=
o for-next)
Merging mvebu/for-next (fecc54c7ccfe Merge branch 'mvebu/arm' into mvebu/fo=
r-next)
Merging omap/for-next (61b6b9cfada4 Merge branch 'omap-for-v5.17/fixes-not-=
urgent' into for-next)
Merging qcom/for-next (c924e8d6f4a4 Merge branches 'arm64-defconfig-for-5.1=
8', 'arm64-for-5.18', 'drivers-for-5.18', 'dts-for-5.18', 'arm64-fixes-for-=
5.17' and 'dts-fixes-for-5.17' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (c3b08f12c719 Merge branches 'renesas-arm-defconfig-fo=
r-v5.18' and 'renesas-arm-dt-for-v5.18' into renesas-next)
Merging reset/reset/next (89e7a6698fdd reset: uniphier-glue: Use devm_add_a=
ction_or_reset())
Merging rockchip/for-next (a2f1c4909563 Merge branch 'v5.18-armsoc/dts64' i=
nto for-next)
Merging samsung-krzk/for-next (e0995440d460 Merge branch 'next/defconfig' i=
nto for-next)
CONFLICT (add/add): Merge conflict in arch/arm64/boot/dts/exynos/exynos850-=
pinctrl.dtsi
CONFLICT (add/add): Merge conflict in arch/arm64/boot/dts/exynos/exynos850.=
dtsi
Merging scmi/for-linux-next (ffbdf7c8cdd2 Merge branch 'for-next/scmi' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (59bb54bca1f5 ARM: dts: stm32: use exti 19 as main=
 interrupt to support RTC wakeup on stm32mp157)
Merging sunxi/sunxi/for-next (d7ab185b353f Merge branch 'sunxi/dt-for-5.18'=
 into sunxi/for-next)
Merging tee/next (ce352be35ba0 Merge branch 'async_notif' into next)
Merging tegra/for-next (52db893a313e Merge branch for-5.18/arm64/dt into fo=
r-next)
Merging ti/ti-next (3be5bf60d055 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (3a14f0e61408 arm64: zynqmp: Rename dma to dma-cont=
roller)
Merging clk/clk-next (28c7bbb2a3fc Merge branch 'clk-kunit' into clk-next)
Merging clk-imx/for-next (036a4b4b4dfa clk: imx: Add imx8dxl clk driver)
Merging clk-renesas/renesas-clk (678eb67513a9 dt-bindings: clock: renesas: =
Document RZ/V2L SoC)
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
Merging mips/mips-next (e0a8b93efa23 mips: Enable KCSAN)
Merging nds32/next (07cd7745c6f2 nds32/setup: remove unused memblock_region=
 variable in setup_memory())
CONFLICT (content): Merge conflict in arch/nds32/Kbuild
CONFLICT (content): Merge conflict in arch/nds32/Kconfig
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (862cf8d5fd98 openrisc/boot: Remove unnecessary i=
nitialisation in memcpy().)
Merging parisc-hd/for-next (18a1d5e19453 parisc: Add ioread64_lo_hi() and i=
owrite64_lo_hi())
Merging powerpc/next (29ec39fcf11e Merge tag 'powerpc-5.17-1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging soc-fsl/next (1ce93cb102e7 soc: fsl: qe: Check of ioremap return va=
lue)
Merging risc-v/for-next (e783362eb54c Linux 5.17-rc1)
Merging s390/for-next (a086db89b45c Merge branch 'features' into for-next)
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
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (80839488f2a7 Merge branch 'for-next-next-v5.17-2022=
0204' into for-next-20220204)
Merging ceph/master (038b8d1d1ab1 libceph: optionally use bounce buffer on =
recv path in crc mode)
Merging cifs/for-next (dfd42facf1e4 Linux 5.17-rc3)
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
Merging f2fs/dev (728b9b5874f8 f2fs: add a way to limit roll forward recove=
ry time)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (073c3ab6ae01 Documentation/filesystem/dax: DAX on vi=
rtiofs)
Merging gfs2/for-next (9421fdba4215 gfs2: Initialize gh_error in gfs2_glock=
_nq)
Merging jfs/jfs-next (c48a14dca2cb JFS: fix memleak in jfs_mount)
Merging ksmbd/ksmbd-for-next (f9929ef6a2a5 ksmbd: add support for key excha=
nge)
Merging nfs/linux-next (26291c54e111 Linux 5.17-rc2)
Merging nfs-anna/linux-next (a239ba94d191 SUNRPC: lock against ->sock chang=
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
Merging xfs/for-next (cea267c235e1 xfs: ensure log flush at the end of a sy=
nchronous fallocate call)
Merging zonefs/for-next (95b115332a83 zonefs: remove redundant null bio che=
ck)
Merging iomap/iomap-for-next (ebb7fb1557b1 xfs, iomap: limit individual ioe=
nd chain lengths in writeback)
Merging djw-vfs/vfs-for-next (2d86293c7075 xfs: return errors in xfs_fs_syn=
c_fs)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (8f40da9494cf Merge branch 'misc.namei' into for-next)
Merging printk/for-next (65c2c0709d8e Merge branch 'rework/fast-next-seq' i=
nto for-next)
Merging pci/next (e783362eb54c Linux 5.17-rc1)
Merging pstore/for-next/pstore (a5d05b07961a pstore/ftrace: Allow immediate=
 recording)
Merging hid/for-next (2b3566c337c3 Merge branch 'for-5.17/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (b993fe2dc6b5 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (13462ba1815d i3c: master: dw: check return of dw_i3c_=
master_get_free_pos())
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (d7334d055811 hwmon: (adt7x10) Use hwmon_n=
otify_event)
Merging jc_docs/docs-next (869f496e1aa6 docs: process: submitting-patches: =
Clarify the Reported-by usage)
Merging v4l-dvb/master (7dc5fc6d3bd6 media: mtk-cir: simplify code)
Merging v4l-dvb-next/master (68a99f6a0ebf media: lirc: report ir receiver o=
verflow)
Merging pm/linux-next (4e3e936b36f6 Merge branch 'devprop' into linux-next)
CONFLICT (content): Merge conflict in drivers/base/property.c
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
Merging rdma/for-next (0d9c00117b8a RDMA/mlx4: remove redundant assignment =
to variable nreq)
Merging net-next/master (ff62433883b3 net: dsa: mv88e6xxx: Unlock on error =
in mv88e6xxx_port_bridge_join())
Merging bpf-next/for-next (128dac5f21e9 Merge branch 'bpf: Fix strict mode =
calculation')
Merging ipsec-next/master (2ecda181682e xfrm: delete duplicated functions t=
hat calls same xfrm_api_check())
Merging mlx5-next/mlx5-next (cac3231cc684 mlx5: remove usused static inline=
s)
Merging netfilter-next/master (c828414ac935 netfilter: nft_compat: suppress=
 comment match)
Merging ipvs-next/master (e7d786331c62 Merge branch 'udp-ipv6-optimisations=
')
Merging bluetooth/master (4840aa67576b Bluetooth: hci_core: Fix leaking sen=
t_cmd skb)
Merging wireless-next/main (c761161851d3 mac80211: Remove redundent assignm=
ent channel_type)
Merging mtd/mtd/next (ad5e35f58384 mtd: Replace the expert mode symbols wit=
h a single helper)
Merging nand/nand/next (0ff4eb01ffb9 mtd: rawnand: protect access to rawnan=
d devices while in suspend)
Merging spi-nor/spi-nor/next (e783362eb54c Linux 5.17-rc1)
Merging crypto/master (95e26b0391d0 crypto: sl3516 - remove redundant initi=
alizations of pointers in_sg and out_sg)
Merging drm/drm-next (53dbee4926d3 Merge tag 'drm-misc-next-2022-01-27' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-misc/for-linux-next (d3cbc6e323c9 drm: panel-orientation-quirks=
: Add quirk for the 1Netbook OneXPlayer)
Merging amdgpu/drm-next (bb6f1d6cc7c1 drm/amdgpu/smu11.5: restore cclks in =
vangogh_set_performance_level)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_drv=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/core/d=
c_link_dp.c
Merging drm-intel/for-linux-next (722b717d8e27 drm/i915: Fix trailing semic=
olon)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_reg.h
Merging drm-intel-gt/for-linux-next-gt (876f7a438e42 Merge drm/drm-next int=
o drm-intel-gt-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_drv.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_reg.h
Applying: merge fix for "drm/i915: split out i915_gem_evict.h from i915_drv=
.h"
Applying: extra merge fix for "drm/i915: split out i915_gem_evict.h from i9=
15_drv.h"
Applying: extra 2 merge fix for "drm/i915: split out i915_gem_evict.h from =
i915_drv.h"
Applying: fix up for "drm/i915: Move GT registers to their own header file"
Merging drm-tegra/drm/tegra/for-next (22d7ee32f1fb gpu: host1x: Fix hang on=
 Tegra186+)
Merging drm-msm/msm-next (6aa89ae1fb04 drm/msm/gpu: Cancel idle/boost work =
on suspend)
Merging imx-drm/imx-drm/next (20fbfc81e390 drm/imx: imx-tve: Make use of th=
e helper function devm_platform_ioremap_resource())
Merging etnaviv/etnaviv/next (cdd156955f94 drm/etnaviv: consider completed =
fence seqno in hang check)
Merging fbdev/for-next (c5510f53140c video: fbdev: Fix wrong file path for =
pvr2fb.c in Kconfig help text)
Merging regmap/for-next (1056c41634d4 regmap-irq: Fix typo in comment)
Merging sound/for-next (9d73d1928eb8 kselftest: alsa: Declare most function=
s static)
Merging sound-asoc/for-next (d466706b9d0d ASoC: sun4i-i2s: Support for Allw=
inner R329 and D1 SoCs)
Merging modules/modules-next (a97ac8cb24a3 module: fix signature check fail=
ures when using in-kernel decompression)
Merging input/next (87a0b2fafc09 Merge tag 'v5.16' into next)
CONFLICT (content): Merge conflict in drivers/input/misc/axp20x-pek.c
Merging block/for-next (98c626b9d966 Merge branch 'for-5.18/io_uring' into =
for-next)
Merging device-mapper/for-next (eaac0b590a47 dm sysfs: use default_groups i=
n kobj_type)
Merging libata/for-next (0c72a87889d6 libata: make ata_host_suspend() *void=
*)
Merging pcmcia/pcmcia-next (3928cf08334e pcmcia: db1xxx_ss: restrict to MIP=
S_DB1XXX boards)
Merging mmc/next (0cb63fc57859 dt-bindings: mmc: Add compatible for Mediate=
k MT8186)
Merging mfd/for-mfd-next (9cb74781a436 mfd: intel_soc_pmic_crc: Set main IR=
Q domain bus token to DOMAIN_BUS_NEXUS)
Merging backlight/for-backlight-next (ec961cf32411 backlight: qcom-wled: Re=
spect enabled-strings in set_brightness)
Merging battery/for-next (784056d36f27 power: supply: axp288_fuel_gauge: Fi=
x spelling mistake "resisitor" -> "resistor")
Merging regulator/for-next (e4a7e3f741f7 regulator/rpi-panel-attiny: Use tw=
o transactions for I2C read)
Merging security/next-testing (047843bdb316 Merge branch 'landlock_lsm_v34'=
 into next-testing)
Merging apparmor/apparmor-next (364bd29902ae apparmor: Fix some kernel-doc =
comments)
Merging integrity/next-integrity (89677197ae70 ima: Do not print policy rul=
e with inactive LSM labels)
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
Merging devicetree/for-next (d029175f1420 MAINTAINERS: dt-bindings: Add Krz=
ysztof Kozlowski)
Merging mailbox/mailbox-for-next (869b6ca39c08 dt-bindings: mailbox: Add mo=
re protocol and client ID)
Merging spi/for-next (4e28b22225e3 spi: dt-bindings: add mising description=
 type to reg property)
Merging tip/auto-latest (163812a9c80a Merge x86/cpu into tip/master)
Merging clockevents/timers/drivers/next (7647204c2e81 dt-bindings: timer: A=
dd Mstar MSC313e timer devicetree bindings documentation)
Merging edac/edac-for-next (59d0e09374a3 Merge branch 'edac-urgent' into ed=
ac-for-next)
Merging irqchip/irq/irqchip-next (cd448b24c621 Merge branch irq/misc-5.17 i=
nto irq/irqchip-next)
Merging ftrace/for-next (6b9b6413700e ftrace: Fix assuming build time sort =
works for s390)
Merging rcu/rcu/next (d51c69ea4ca3 rcu-tasks: Set ->percpu_enqueue_shift to=
 zero upon contention)
Merging kvm/next (17179d0068b2 Merge tag 'kvmarm-fixes-5.17-1' of git://git=
.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
Merging kvm-arm/next (1c53a1ae3612 Merge branch kvm-arm64/misc-5.17 into kv=
marm-master/next)
Merging kvms390/next (812de04661c4 KVM: s390: Clarify SIGP orders versus ST=
OP/RESTART)
Merging xen-tip/linux-next (e25a8d959992 x86/Xen: streamline (and fix) PV C=
PU enumeration)
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (bc35f7ef9628 workqueue: Convert the type of po=
ol->nr_running to int)
Merging drivers-x86/for-next (34fc68348554 platform/surface: surface3-wmi: =
Simplify resource management)
Merging chrome-platform/for-next (ffebd9053272 platform/chrome: cros_ec_typ=
ec: Check for EC device)
Merging hsi/for-next (e783362eb54c Linux 5.17-rc1)
Merging leds/for-next (d949edb503b1 leds: lp55xx: initialise output directi=
on from dts)
Merging ipmi/for-next (d134ad2574a1 ipmi: ssif: replace strlcpy with strscp=
y)
Merging driver-core/driver-core-next (aa21a1bf97be scripts/get_abi.pl: Igno=
re hidden files)
Merging usb/usb-next (2dac5d2864af usb: gadget: f_uac2: Neaten and reduce s=
ize of afunc_validate_opts)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (26291c54e111 Linux 5.17-rc2)
Merging usb-chipidea-next/for-usb-next (78665f57c3fa usb: chipidea: udc: ma=
ke controller hardware endpoint primed)
Merging tty/tty-next (186ab09930aa serial: core: Drop duplicate NULL check =
in uart_*shutdown())
Merging char-misc/char-misc-next (b86f32951d17 hpet: remove unused writeq/r=
eadq function definitions)
Merging extcon/extcon-next (26291c54e111 Linux 5.17-rc2)
Merging gnss/gnss-next (26291c54e111 Linux 5.17-rc2)
Merging phy-next/next (1e805d190ba5 Merge tag 'phy-fixes-5.17' into next)
CONFLICT (modify/delete): Documentation/devicetree/bindings/phy/qcom,usb-hs=
-phy.txt deleted in phy-next/next and modified in HEAD.  Version HEAD of Do=
cumentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt left in tree.
$ git rm -f Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
Applying: merge fix for "dt-bindings: phy: qcom,usb-hs-phy: add MSM8226 com=
patible"
Merging soundwire/next (e783362eb54c Linux 5.17-rc1)
Merging thunderbolt/next (7f7b571becf3 thunderbolt: Replace acpi_bus_get_de=
vice())
Merging vfio/next (2bed2ced40c9 vfio/iommu_type1: replace kfree with kvfree)
Merging staging/staging-next (74e69e95f13f staging: r8188eu: remove constan=
t variable eRFPath)
Merging iio/togreg (38ac2f038666 iio: chemical: sunrise_co2: set val parame=
ter only on success)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging icc/icc-next (9d6c7ee7c4bb interconnect: imx: Add imx_icc_get_bw fu=
nction to set initial avg and peak)
Merging dmaengine/next (e783362eb54c Linux 5.17-rc1)
Merging cgroup/for-next (48da2ddc4c78 Merge branch 'for-5.17-fixes' into fo=
r-next)
Merging scsi/for-next (7bc8faaf4d50 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (d1d87c33f47d scsi: lpfc: Remove redundant flush_=
workqueue() call)
Merging vhost/linux-next (fae0bd40fab0 virtio_console: break out of buf pol=
l on remove)
Merging rpmsg/for-next (ae6062c4abdb remoteproc: mtk_scp: Use dev_err_probe=
() where possible)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (0868ad385aff gpio: Add support for Airoha =
EN7523 GPIO controller)
Merging gpio-intel/for-next (a1ce76e89907 gpio: tps68470: Allow building as=
 module)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (003c30d8ad1c Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (689e00887740 pinctrl: baytrail: Clear direc=
t_irq_en flag on broken configs)
Merging pinctrl-renesas/renesas-pinctrl (742dd872d37f pinctrl: renesas: r8a=
77995: Restore pin group sort order)
Merging pinctrl-samsung/for-next (3652dc070bad pinctrl: samsung: improve wa=
ke irq info on console)
Merging pwm/for-next (657e54e54ba5 pwm: pxa: Implement .apply() callback)
Merging userns/for-next (f9d87929d451 ucount:  Make get_ucount a safe get_u=
ser replacement)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (57765eb4d4b7 selftests/kselftest/runner.sh: Pass op=
tional command parameters in environment)
Merging livepatching/for-next (32fdbc45ade0 Merge branch 'for-5.17/kallsyms=
' into for-next)
Merging coresight/next (ebbce265bba1 coresight: trbe: Move check for kernel=
 page table isolation from EL0 to probe)
Merging rtc/rtc-next (e783362eb54c Linux 5.17-rc1)
Merging nvdimm/libnvdimm-for-next (9e05e95ca8da iomap: Fix error handling i=
n iomap_zero_iter())
Merging at24/at24/for-next (e783362eb54c Linux 5.17-rc1)
Merging ntb/ntb-next (afe1c85b354c IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (1e6d69c7b9cd selftests/seccomp: Report ev=
ent mismatches more clearly)
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
Merging mhi/mhi-next (b2aa7904752d bus: mhi: pci_generic: Add mru_default f=
or Cinterion MV31-W)
Merging memblock/for-next (a59466ee91aa memblock: Remove #ifdef __KERNEL__ =
from memblock.h)
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
Merging random/master (fdd12bd31843 random: fix locking in crng_fast_load())
Merging landlock/next (a691b9858300 Merge Landlock fixes into next)
Merging rust/rust-next (ced9f62ec435 init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
CONFLICT (content): Merge conflict in Documentation/process/changes.rst
CONFLICT (content): Merge conflict in samples/Kconfig
CONFLICT (content): Merge conflict in samples/Makefile
Merging akpm-current/current (f5f765ac281c ipc/mqueue: use get_tree_nodev()=
 in mqueue_get_tree())
CONFLICT (content): Merge conflict in lib/Kconfig.debug
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (c052f4a3cbf1 Merge branch 'akpm-current/current')

--Sig_/Lsgoi2bO_X1riE187+3QvdM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmICAL8ACgkQAVBC80lX
0GwjGQf+MUASAXw/hBq01w4dgWkqeDur0mRFnzgJm0BNoBnwJuKicFshU36EI3eh
3bDKsBqeqwXCWXVfUjMImau7I7GpwWZqSFPJc+sAXDRXa8uz+7/Jftk4RufT3CTH
GH93L1IU+rj/jtePrraoZPv74xuwyPNg8B8jo7hcPe7RR42/gGtp+cDjChESO7Bw
pvLFiR3e0Ia668nMY7i7t5rs4VYUKZ+U9YipznHkUk2yTMN6al6ak1M+d/6buFtx
YOcZGo9CbiGwUz+LYzstKkKxLmKits3TVLEYkiZXeKOU96v+yJpvfqEwbCTE9DJh
ZQsRN2HHgLme+uFUnyywfwzjLGq78w==
=f+2u
-----END PGP SIGNATURE-----

--Sig_/Lsgoi2bO_X1riE187+3QvdM--
