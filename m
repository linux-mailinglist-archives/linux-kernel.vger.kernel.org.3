Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A54A5B046B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIGMz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiIGMzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:55:25 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F5B5AC77;
        Wed,  7 Sep 2022 05:55:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MN2Kh6KMPz4xGG;
        Wed,  7 Sep 2022 22:55:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662555321;
        bh=djLW91L/LSju8eUbMb/E4KGmGJisNTLRonTTTWm41LI=;
        h=Date:From:To:Cc:Subject:From;
        b=NgRdazvGbIYVqPGdMSLEtzyT1hKep/TJqYsGDD72np9AwsJvNFemi03rB8BeodVn8
         5BsGX+VzUSoH3u1fsHvhJsBSMSPdDaGMmdomdRM6mIRscQD0lT3l9NDXpntTVSCewp
         WwZKaGM60V+nQ501msvhL2dZmtau7ERAqxuPJsB/etD7ujjOmD4Rxxq1SE4LM/h2eb
         BrjJXeBR9xBTDYhgIAmmjePkRAlkHRI0VF3zkoKWaxsK6wj9MDtxbWQegP+d1GhLbk
         EyjACeMmBiuo0I3TmrowGRvJDqExk3QtmeQJ3TsaNfs03C1qOL0nXYpccXHPAGM28P
         HzqWsdFjcuMAw==
Date:   Wed, 7 Sep 2022 22:55:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Sep 7
Message-ID: <20220907225519.4d39bffe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3q7dljYXpL/Bmd9V9fmFKk4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3q7dljYXpL/Bmd9V9fmFKk4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220906:

The kbuild tree gained a build failure for which I reverted 4 commits.

The perf tree still had its build failure so I used the version from
next-20220830.

The clk-imx tree lost its build failure.

The btrfs tree gained a build failure so I used the version from
next-20220906.

The crypto tree lost but gained a build failure so I used the version
from next-20220901.

Non-merge commits (relative to Linus' tree): 5166
 6980 files changed, 348573 insertions(+), 106128 deletions(-)

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

I am currently merging 359 trees (counting Linus' and 98 trees of bug
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
Merging origin/master (d2ec799d1c1b Merge tag 'erofs-for-6.0-rc5-fixes' of =
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs)
Merging fixes/fixes (1c23f9e627a7 Linux 6.0-rc2)
Merging mm-hotfixes/mm-hotfixes-unstable (06346a4e00b7 mm: fix dereferencin=
g possible ERR_PTR)
Merging kbuild-current/fixes (1b620d539ccc kbuild: disable header exports f=
or UML in a straightforward way)
Merging arc-current/for-curr (952deecb065e arc: dts: Harmonize EHCI/OHCI DT=
 nodes name)
Merging arm-current/fixes (25af7406df59 ARM: 9229/1: amba: Fix use-after-fr=
ee in amba_read_periphid())
Merging arm64-fixes/for-next/fixes (c0a454b9044f arm64/bti: Disable in kern=
el BTI when cross section thunks are broken)
Merging arm-soc-fixes/arm/fixes (12f09234bde5 Merge tag 'renesas-fixes-for-=
v6.0-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-d=
evel into arm/fixes)
Merging drivers-memory-fixes/fixes (c941e6305958 dt-bindings: memory-contro=
llers: fsl,imx8m-ddrc: drop Leonard Crestez)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (b508128bb0d1 m68k: defconfig: Update defcon=
figs for v5.19-rc1)
Merging powerpc-fixes/fixes (6cf07810e9ef powerpc/papr_scm: Ensure rc is al=
ways initialized in papr_scm_pmu_register())
Merging s390-fixes/fixes (7c8d42fdf1a8 s390/hugetlb: fix prepare_hugepage_r=
ange() check for 2 GB hugepages)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (e1091e226a2b net: usb: qmi_wwan: add Quectel RM520N)
Merging bpf/master (8a7d61bdc2fa selftests/xsk: Add missing close() on netn=
s fd)
Merging ipsec/master (26dbd66eab80 esp: choose the correct inner protocol f=
or GSO on inter address family tunnels)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (2aec909912da wifi: use struct_group to copy addr=
esses)
Merging rdma-fixes/for-rc (bc7a2c9b1777 MAINTAINERS: Update maintainers of =
HiSilicon RoCE)
Merging sound-current/for-linus (37137ec26c2c ALSA: hda: Once again fix reg=
ression of page allocations with IOMMU)
Merging sound-asoc-fixes/for-linus (b1cd3fd42db7 ASoC: fsl_aud2htx: Add err=
or handler for pm_runtime_enable)
Merging regmap-fixes/for-linus (f5723cfc0193 regmap: spi: Reserve space for=
 register address/padding)
Merging regulator-fixes/for-linus (475043fabe8c regulator: Fix qcom,spmi-re=
gulator schema)
Merging spi-fixes/for-linus (9c9c9da7aa10 spi: spi: Fix queue hang if previ=
ous transfer failed)
Merging pci-current/for-linus (0e1fa5155a36 MAINTAINERS: Add Mahesh J Salga=
onkar as EEH maintainer)
Merging driver-core.current/driver-core-linus (c2e406596571 sched/debug: fi=
x dentry leak in update_sched_domain_debugfs)
Merging tty.current/tty-linus (7e18e42e4b28 Linux 6.0-rc4)
Merging usb.current/usb-linus (766a96dc5583 USB: core: Fix RST error in hub=
.c)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (7e18e42e4b28 Linux 6.0-rc4)
Merging phy/fixes (0a6fc70d76bd phy: marvell: phy-mvebu-a3700-comphy: Remov=
e broken reset support)
Merging staging.current/staging-linus (7e18e42e4b28 Linux 6.0-rc4)
Merging iio-fixes/fixes-togreg (0096fc879358 iio: light: cm32181: make cm32=
181_pm_ops static)
Merging counter-fixes/fixes-togreg (568035b01cfb Linux 6.0-rc1)
Merging char-misc.current/char-misc-linus (7e18e42e4b28 Linux 6.0-rc4)
Merging soundwire-fixes/fixes (4ef3f2aff126 soundwire: qcom: fix device sta=
tus array range)
Merging thunderbolt-fixes/fixes (7e18e42e4b28 Linux 6.0-rc4)
Merging input-current/for-linus (9c9c71168f79 Input: iforce - add support f=
or Boeder Force Feedback Wheel)
Merging crypto-current/master (874b301985ef crypto: lib - remove unneeded s=
election of XOR_BLOCKS)
Merging vfio-fixes/for-linus (873aefb376bb vfio/type1: Unpin zero pages)
Merging kselftest-fixes/fixes (bdbf0617bbc3 selftests/vm: fix inability to =
build any vm tests)
Merging modules-fixes/modules-linus (e69a66147d49 module: kallsyms: Ensure =
preemption in add_kallsyms() with PREEMPT_RT)
Merging dmaengine-fixes/fixes (8f2b6bc79c32 dmaengine: xilinx_dma: Report e=
rror in case of dma_set_mask_and_coherent API failure)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (0fddf9ad06fd mtd: rawnand: gpmi: Set WAIT_FOR_=
READY timeout based on program/erase times)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (150f7b11cb59 media: uvcvideo: Fix InterfacePro=
tocol for Quanta camera)
Merging reset-fixes/reset/fixes (51fd191422d9 reset: microchip-sparx5: issu=
e a reset on startup)
Merging mips-fixes/mips-fixes (35508d242409 MIPS: loongson32: ls1c: Fix han=
g during startup)
Merging at91-fixes/at91-fixes (3d074b750d2b ARM: dts: at91: sama5d2_icp: do=
n't keep vdd_other enabled all the time)
Merging omap-fixes/fixes (2a906db2824b Merge branch 'am5748-fix' into fixes)
Merging kvm-fixes/master (29250ba51bc1 Merge tag 'kvm-s390-master-6.0-1' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
Merging kvms390-fixes/master (ca922fecda6c KVM: s390: pci: Hook to access K=
VM lowlevel from VFIO)
Merging hwmon-fixes/hwmon (7e18e42e4b28 Linux 6.0-rc4)
Merging nvdimm-fixes/libnvdimm-fixes (17d9c15c9b9e fsdax: Fix infinite loop=
 in dax_iomap_rw())
Merging cxl-fixes/fixes (e35f5718903b cxl/mbox: Fix missing variable payloa=
d checks in cmd size validation)
Merging btrfs-fixes/next-fixes (351ff18f7481 Merge branch 'misc-6.0' into n=
ext-fixes)
Merging vfs-fixes/fixes (3f61631d47f1 take care to handle NULL ->proc_lseek=
())
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (647e82dbf851 platform/x86: p2sb: Fix UAF w=
hen caller uses resource name)
Merging samsung-krzk-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging pinctrl-samsung-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging devicetree-fixes/dt/linus (40bfe7a86d84 of/device: Fix up of_dma_co=
nfigure_id() stub)
Merging dt-krzk-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging scsi-fixes/fixes (8fe4ce5836e9 scsi: core: Fix a use-after-free)
Merging drm-fixes/drm-fixes (7e18e42e4b28 Linux 6.0-rc4)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (151e0e0fdb4d drm/i915: consid=
er HAS_FLAT_CCS() in needs_ccs_pages)
Merging mmc-fixes/fixes (63f1560930e4 mmc: core: Fix inconsistent sd3_bus_m=
ode at UHS-I SD voltage switch failure)
Merging rtc-fixes/rtc-fixes (568035b01cfb Linux 6.0-rc1)
Merging gnss-fixes/gnss-linus (a111daf0c53a Linux 5.19-rc3)
Merging hyperv-fixes/hyperv-fixes (f0880e2cb7e1 Drivers: hv: Never allocate=
 anything besides framebuffer from framebuffer memory region)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (d958edb9eef1 Merge tag 'dt-fixes-for-palmer-6.0=
-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git into=
 fixes)
Merging risc-v-mc-fixes/dt-fixes (0dec364ffeb6 riscv: dts: microchip: use a=
n mpfs specific l2 compatible)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging spdx/spdx-linus (568035b01cfb Linux 6.0-rc1)
Merging gpio-brgl-fixes/gpio/for-current (6890381720b2 gpio: ws16c48: Make =
irq_chip immutable)
Merging gpio-intel-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging pinctrl-intel-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging erofs-fixes/fixes (2f44013e3998 erofs: fix pcluster use-after-free =
on UP platforms)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (793f55b2971e kunit: fix Kconfig for build-=
in tests USB4 and Nitro Enclaves)
Merging ubifs-fixes/fixes (c3c07fc25f37 ubi: fastmap: Return error code if =
memory allocation fails in add_aeb())
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (6930bcbfb6ce lockd: detect and reject lock argume=
nts that overflow)
Merging irqchip-fixes/irq/irqchip-fixes (c3e88d91e409 irqchip/stm32-exti: R=
emove check on always false condition)
Merging renesas-fixes/fixes (ab2866f12ca1 arm64: dts: renesas: r8a779g0: Fi=
x HSCIF0 interrupt number)
Merging broadcom-fixes/fixes (b6fa04765857 Merge branch 'drivers/fixes' int=
o fixes)
Merging perf-current/perf/urgent (b90cb1053190 Linux 6.0-rc3)
Merging efi-fixes/urgent (1a3887924a7e efi: libstub: Disable struct randomi=
zation)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging battery-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (d91c411c744b drm/ttm: update b=
ulk move object of ghost BO)
Merging kbuild/for-next (2f1e574fb1e7 Revert "kbuild: Make scripts/compile.=
h when sh !=3D bash")
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (6c3bd8d3e01d perf smt: Tidy header guard add SPDX)
$ git reset --hard HEAD^
Merging next-20220830 version of perf
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (5c850d31880e swiotlb: fix passing local varia=
ble to debugfs_create_ulong())
Merging asm-generic/master (8cbb2b50ee2d asm-generic: Conditionally enable =
do_softirq_own_stack() via Kconfig.)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (5d6dd664478f Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (48a3e6c07502 Merge branches 'for-next/misc', '=
for-next/kselftest', 'for-next/doc' and 'for-next/sve' into for-next/core)
Merging arm-perf/for-next/perf (aaaee7b55c9e docs: perf: Include hns3-pmu.r=
st in toctree to fix 'htmldocs' WARNING)
Merging arm-soc/for-next (b224d265f838 soc: document merges)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (727d51a3ed30 Merge branch 'v6.1/dt64' into for-ne=
xt)
Merging aspeed/for-next (7bc156fbb726 ARM: config: aspeed_g5: Enable PECI)
Merging at91/at91-next (778dde11ccc0 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (122de0c73256 Merge branch 'maintainers/next' into ne=
xt)
Merging drivers-memory/for-next (f492ddd4aaad Merge branch 'for-v6.1/mediat=
ek' into for-next)
Merging imx-mxs/for-next (bf6d46c1da57 Merge branch 'imx/dt64' into for-nex=
t)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (63c8a3297683 Merge branch 'v6.0-next/soc' into f=
or-next)
Merging mvebu/for-next (74de3ae81a42 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (ad2fe4582c48 Merge branches 'omap-for-v5.20/omap1', =
'omap-for-v5.20/ti-sysc' and 'omap-for-v5.20/soc' into for-next)
Merging qcom/for-next (44c02daba451 Merge branches 'arm64-defconfig-for-6.1=
', 'arm64-for-6.1', 'clk-for-6.1', 'defconfig-for-6.1', 'drivers-for-6.1', =
'dts-for-6.1' and 'arm64-fixes-for-6.0' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (cb6f1733f0ab Merge branches 'renesas-arm-defconfig-fo=
r-v6.1', 'renesas-arm-dt-for-v6.1', 'renesas-drivers-for-v6.1' and 'renesas=
-dt-bindings-for-v6.1' into renesas-next)
Merging reset/reset/next (d985db836226 reset: tps380x: Fix spelling mistake=
 "Voltags" -> "Voltage")
Merging rockchip/for-next (883ab4bb8ee6 Merge branch 'v6.1-armsoc/dts64' in=
to for-next)
Merging samsung-krzk/for-next (9990f043d543 Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (2cdcbfae5be5 Merge tag 'scmi-fixes-6.0' of git=
://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-linu=
x-next)
Merging stm32/stm32-next (0c8d51cb3762 ARM: dts: stm32: Create separate pin=
mux for qspi cs pin in stm32mp15-pinctrl.dtsi)
Merging sunxi/sunxi/for-next (3930624c3936 clk: sunxi-ng: d1: Limit PLL rat=
es to stable ranges)
Merging tee/next (db30e53bf897 Merge branch 'tee_cleanup_for_v5.19' into ne=
xt)
Merging tegra/for-next (393c6c3a6152 Merge branch for-5.20/arm64/defconfig =
into for-next)
Merging ti/ti-next (6038f1171162 arm64: dts: ti: k3-j7200-main: Add main do=
main watchdog entries)
Merging xilinx/for-next (0413dd4d95da ARM: dts: zynq: add QSPI controller n=
ode)
Merging clk/clk-next (de86412dc79f Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (acc647002eeb clk: imx93: add SAI IPG clk)
Merging clk-renesas/renesas-clk (e312ae92077f dt-bindings: clock: renesas,r=
zg2l: Document RZ/Five SoC)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (45fef4c4b9c9 csky: abiv1: Fixup compile error)
Merging loongarch/loongarch-next (b90cb1053190 Linux 6.0-rc3)
Merging m68k/for-next (feb159347bb0 m68k: Allow kexec on M68KCLASSIC with M=
MU enabled only)
Merging m68knommu/for-next (7728140c8971 m68knommu: fix non-mmu classic 680=
00 legacy timer tick selection)
Merging microblaze/next (568035b01cfb Linux 6.0-rc1)
Merging mips/mips-next (568035b01cfb Linux 6.0-rc1)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (52e0ea900202 openrisc: io: Define iounmap argume=
nt as volatile)
Merging parisc-hd/for-next (b3b4f321a9ca parisc: ccio-dma: Add missing ioun=
map in error path in ccio_probe())
Merging powerpc/next (8b4bb0ad00cb powerpc/code-patching: Speed up page map=
ping/unmapping)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (82c75dca6f95 riscv: enable CD-ROM file systems in =
defconfig)
Merging risc-v-mc/dt-for-next (7eac0081a8e9 riscv: dts: microchip: add qspi=
 compatible fallback)
Merging s390/for-next (c4680f34b418 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (af3e16101cee um: include sys/types.h for size_t)
Merging xtensa/xtensa-for-next (0847d167d0f9 xtensa: enable ARCH_HAS_GCOV_P=
ROFILE_ALL)
Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl'=
 into for-next)
Merging vfs-idmapping/for-next (6344e66970c6 xattr: constify value argument=
 in vfs_setxattr())
Merging fscrypt/master (18136e49cb00 fscrypt: work on block_devices instead=
 of request_queues)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (0e7fbd5972c0 Merge branch 'for-next-next-v6.0-20220=
906' into for-next-20220906)
$ git reset --hard HEAD^
Merging next-20220906 version of btrfs
CONFLICT (content): Merge conflict in fs/btrfs/zoned.c
[master 44e933b3d27e] next-20220906/btrfs
Merging ceph/master (0edddc4160b9 ceph: remove Sage's git tree from documen=
tation)
Merging cifs/for-next (7e18e42e4b28 Linux 6.0-rc4)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (2f44013e3998 erofs: fix pcluster use-after-free on UP pl=
atforms)
Merging exfat/dev (2e9ceb6728f1 exfat: fix overflow for large capacity part=
ition)
Merging ext3/for_next (5b02b6900c8d Pull fsnotify typo fix.)
Merging ext4/dev (d95efb14c0b8 ext4: add ioctls to get/set the ext4 superbl=
ock uuid)
Merging f2fs/dev (4404215ceecd f2fs: use COMPRESS_MAPPING to get compress c=
ache mapping)
Merging fsverity/fsverity (8377e8a24bba fs-verity: use kmap_local_page() in=
stead of kmap())
Merging fuse/for-next (247861c325c2 fuse: retire block-device-based superbl=
ock on force unmount)
Merging gfs2/for-next (204c0300c4e9 gfs2: Switch from strlcpy to strscpy)
Merging jfs/jfs-next (e471e5942c00 fs/jfs: Remove dead code)
Merging ksmbd/ksmbd-for-next (8c9073fa857c ksmbd: constify struct path)
Merging nfs/linux-next (ed06fce0b034 SUNRPC: RPC level errors should set ta=
sk->tk_rpc_status)
Merging nfs-anna/linux-next (4f40a5b55446 NFSv4: Add an fattr allocation to=
 _nfs4_discover_trunking())
Merging nfsd/for-next (f6d1df74e4fe NFSD: drop fname and flen args from nfs=
d_create_locked())
Merging ntfs3/master (3b06a2755758 Merge tag 'ntfs3_for_6.0' of https://git=
hub.com/Paragon-Software-Group/linux-ntfs3)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (4f1196288dfb ovl: fix spelling mistakes)
Merging ubifs/next (8c03a1c21d72 ubi: ubi_create_volume: Fix use-after-free=
 when volume creation failed)
Merging v9fs/9p-next (02ed50db058d net/9p: allocate appropriate reduced mes=
sage buffers)
Merging xfs/for-next (031d166f968e xfs: fix inode reservation space for rem=
oving transaction)
Merging zonefs/for-next (6bac30bb8ff8 zonefs: Call page_address() on page a=
cquired with GFP_KERNEL flag)
Merging iomap/iomap-for-next (478af190cb6c iomap: remove iomap_writepage)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (072e51356cd5 Merge tag 'nfs-for-5.20-2' of g=
it://git.linux-nfs.org/projects/trondmy/linux-nfs)
Merging vfs/for-next (0a97e98ab197 Merge branches 'work.path' and 'work.fil=
e_inode' into for-next)
Merging printk/for-next (c0a684057235 Merge branch 'for-6.1/trivial' into f=
or-next)
Merging pci/next (68fca83a3783 Merge branch 'remotes/lorenzo/pci/qcom')
Merging pstore/for-next/pstore (27001e611bb6 pstore/zone: Use GFP_ATOMIC to=
 allocate zone buffer)
Merging hid/for-next (c8e57ea5b6ec Merge branch 'for-6.0/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (e847867330ea Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (568035b01cfb Linux 6.0-rc1)
Merging dmi/dmi-for-next (d2139dfca361 firmware: dmi: Use the proper access=
or for the version field)
Merging hwmon-staging/hwmon-next (cec18aa4b63a hwmon: (emc2305) Remove unus=
ed including <linux/version.h>)
Applying: hwmon: (emc2305) fix up for "i2c: Make remove callback return voi=
d"
Merging jc_docs/docs-next (7ebeef22dcc2 Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (61890ccaefaf media: platform: mtk-mdp3: add MediaTe=
k MDP3 driver)
Merging v4l-dvb-next/master (fbb6c848dd89 media: destage Hantro VPU driver)
Merging pm/linux-next (f6f4c123bfbc Merge branches 'pm-cpuidle' and 'pm-cpu=
freq' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (ddf958f39741 cpufreq: tegra194:=
 Remove the unneeded result variable)
Merging cpupower/cpupower (568035b01cfb Linux 6.0-rc1)
Merging devfreq/devfreq-next (68831c5f94cb PM / devfreq: mtk-cci: Handle sr=
am regulator probe deferral)
Merging opp/opp/linux-next (c7e31e36d8a2 dt-bindings: opp: Add missing (une=
valuated|additional)Properties on child nodes)
Merging thermal/thermal/linux-next (7be4288625df thermal/of: Remove the the=
rmal_zone_of_get_sensor_id() function)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (56171e0db23a fs: dlm: const void resource name parameter)
Merging rdma/for-next (e58f889e293e RDMA/hfi1: Remove the unneeded result v=
ariable)
Merging net-next/master (2786bcff28bd Merge https://git.kernel.org/pub/scm/=
linux/kernel/git/bpf/bpf-next)
Merging bpf-next/for-next (274052a2b0ab Merge branch 'bpf-allocator')
Merging ipsec-next/master (50c448bbc198 Merge remote-tracking branch 'xfrm:=
 start adding netlink extack support')
Merging mlx5-next/mlx5-next (8a2dd123f12f RDMA/mlx5: Move function mlx5_cor=
e_query_ib_ppcnt() to mlx5_ib)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (c1631dbc00c1 Bluetooth: hci_sync: Fix hci_read_bu=
ffer_size_sync)
Merging wireless-next/for-next (b008f4a195af wifi: rsi: fix kernel-doc warn=
ing)
Merging mtd/mtd/next (7ec4cdb32173 mtd: core: check partition before derefe=
rence)
Merging nand/nand/next (e16eceea863b mtd: rawnand: arasan: Fix clock rate i=
n NV-DDR)
Merging spi-nor/spi-nor/next (f8cd9f632f44 mtd: spi-nor: fix spi_nor_spimem=
_setup_op() call in spi_nor_erase_{sector,chip}())
Merging crypto/master (2be570849efc crypto: aspeed - fix build module error)
$ git reset --hard HEAD^
Merging next-20220901 version of crypto
Merging drm/drm-next (8284bae723f0 Merge tag 'drm-misc-next-2022-08-20-1' o=
f git://anongit.freedesktop.org/drm/drm-misc into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/vc4/vc4_hdmi.c
Merging drm-misc/for-linux-next (07d50b8222d0 drm/panel-edp: Fix typo in ke=
rneldoc comment (appers=3D>appears))
Merging amdgpu/drm-next (32d1ffcd3979 drm/amd/display: fix indentation in c=
ommit_planes_for_stream())
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dml/dc=
n32/dcn32_fpu.c
Merging drm-intel/for-linux-next (78c67d5fc371 Revert "drm: Add missing DP =
DSC extended capability definitions.")
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/icl_dsi.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_ba=
cklight.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_bi=
os.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_bw=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/vlv_dsi.c
Merging drm-tegra/for-next (135f4c551d51 drm/tegra: vic: Use devm_platform_=
ioremap_resource())
Merging drm-msm/msm-next (d6463fd4e975 drm/msm/a6xx: Handle GMU prepare-slu=
mber hfi failure)
Merging drm-msm-lumag/msm-next-lumag (39b34f1ed43e Merge branches 'msm-next=
-lumag-core', 'msm-next-lumag-dpu', 'msm-next-lumag-dp', 'msm-next-lumag-ds=
i' and 'msm-next-lumag-hdmi' into msm-next-lumag)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/msm_gem.h
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (332f847212e4 drm/etnaviv: reap idle mapping i=
f it doesn't match the softpin address)
Merging fbdev/for-next (1c23f9e627a7 Linux 6.0-rc2)
Merging regmap/for-next (e0aa3c751963 Merge remote-tracking branch 'regmap/=
for-6.1' into regmap-next)
Merging sound/for-next (7269734abbf5 ALSA: hda: cs35l41: Utilize acpi_get_s=
ubsystem_id())
Merging sound-asoc/for-next (71bdc775a140 Merge remote-tracking branch 'aso=
c/for-6.1' into asoc-next)
Merging modules/modules-next (554694ba120b module: Replace kmap() with kmap=
_local_page())
Merging input/next (e23c69e33248 Input: xpad - add support for XBOX One Eli=
te paddles)
Merging block/for-next (a7618aa9070e Merge branch 'for-6.1/block' into for-=
next)
Merging device-mapper/for-next (c8e2f5c3682d dm verity: enable WQ_HIGHPRI o=
n verify_wq)
Merging libata/for-next (e9892dce44f2 ata: pata_macio: Remove unneeded word=
 in comments)
Merging pcmcia/pcmcia-next (2ef4bb24ff39 pcmcia: Use platform_get_irq() to =
get the interrupt)
Merging mmc/next (11c528aacde7 dt-bindings: mmc: renesas,sdhi: Add iommus p=
roperty)
Merging mfd/for-mfd-next (3d021aaca7c7 dt-bindings: mfd: mt8195: Add bindin=
gs for MediaTek SCPSYS)
CONFLICT (modify/delete): drivers/mfd/intel_soc_pmic_core.c deleted in mfd/=
for-mfd-next and modified in HEAD.  Version HEAD of drivers/mfd/intel_soc_p=
mic_core.c left in tree.
$ git rm -f drivers/mfd/intel_soc_pmic_core.c
Applying: mfd: fix up for "i2c: Make remove callback return void"
Merging backlight/for-backlight-next (fe201f6fa4cf MAINTAINERS: Use Lee Jon=
es' kernel.org address for Backlight submissions)
Merging battery/for-next (568035b01cfb Linux 6.0-rc1)
Merging regulator/for-next (0ba8c4b3b17d Merge remote-tracking branch 'regu=
lator/for-6.1' into regulator-next)
Merging security/next (abec3d015fdf userfaultfd: open userfaultfds with O_R=
DONLY)
CONFLICT (content): Merge conflict in security/selinux/include/classmap.h
Merging apparmor/apparmor-next (79eb2711c919 apparmor: correct config refer=
ence to intended one)
Merging integrity/next-integrity (5926586f291b ima: fix blocking of securit=
y.ima xattrs of unsupported algorithms)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (6354324d8a3e selinux: declare read-only parameters co=
nst)
Merging smack/next (6dc5849dc6a9 SMACK: Add sk_clone_security LSM hook)
Merging tomoyo/master (841b171b4534 locking/lockdep: add debug_show_all_loc=
k_holders())
Merging tpmdd/next (863ed94c589f tpm: Add check for Failure mode for TPM2 m=
odules)
Merging watchdog/master (b90cb1053190 Linux 6.0-rc3)
Merging iommu/next (c10100a416c1 Merge branches 'arm/exynos', 'arm/mediatek=
', 'arm/msm', 'arm/smmu', 'virtio', 'x86/vt-d', 'x86/amd' and 'core' into n=
ext)
Merging audit/next (501e4bb102ee audit: use time_after to compare time)
Merging devicetree/for-next (d2153e4cdf7b dt-bindings: timer: Add missing (=
unevaluated|additional)Properties on child nodes)
Merging dt-krzk/for-next (a70369e1b7f6 ARM: dts: sunplus: sp7021: drop inco=
rrect spi-max-frequency)
Merging mailbox/mailbox-for-next (8a8dc2b9596e mailbox: imx: clear pending =
interrupts)
Merging spi/for-next (1c5b20ac03b6 Merge remote-tracking branch 'spi/for-6.=
1' into spi-next)
Merging tip/master (b926b4504847 Merge branch into tip/master: 'x86/timers')
Merging clockevents/timers/drivers/next (c19e18637d89 clocksource/drivers/s=
un4i: Remove unnecessary (void*) conversions)
Merging edac/edac-for-next (7acc62a7b2ec Merge branch 'edac-misc' into edac=
-for-next)
Merging irqchip/irq/irqchip-next (2bd1753e8c43 Merge branch irq/misc-5.20 i=
nto irq/irqchip-next)
Merging ftrace/for-next (07a451dae367 Merge branch 'trace/for-next-core' in=
to trace/for-next)
Merging rcu/rcu/next (5951fa40eb5f rcu: Remove duplicate RCU exp QS report =
from rcu_report_dead())
Merging kvm/next (372d07084593 KVM: selftests: Fix ambiguous mov in KVM_ASM=
_SAFE())
Merging kvm-arm/next (0982c8d859f8 Merge branch kvm-arm64/nvhe-stacktrace i=
nto kvmarm-master/next)
Merging kvms390/next (f5ecfee94493 KVM: s390: resetting the Topology-Change=
-Report)
Merging xen-tip/linux-next (e9ea0b30ada0 xen/grants: prevent integer overfl=
ow in gnttab_dma_alloc_pages())
Merging percpu/for-next (a111daf0c53a Linux 5.19-rc3)
Merging workqueues/for-next (c0feea594e05 workqueue: don't skip lockdep wor=
k dependency in cancel_work_sync())
Merging drivers-x86/for-next (76fba1221e30 Merge tag 'backlight-detect-refa=
ctor-1' into review-hans)
Merging chrome-platform/for-next (e8bf17d58a4d platform/chrome: cros_ec: Ex=
pose suspend_timeout_ms in debugfs)
Merging hsi/for-next (551e325bbd3f HSI: omap_ssi_port: Fix dma_map_sg error=
 check)
Merging leds/for-next (568035b01cfb Linux 6.0-rc1)
Merging ipmi/for-next (ba5829c6543f ipmi:ipmb: Fix a vague comment and a ty=
po)
Merging driver-core/driver-core-next (61742a7cd5b1 devres: Slightly optimiz=
e alloc_dr())
Merging usb/usb-next (6690986da1e2 usb: clean up after dropping driver regi=
stration log spam)
Merging thunderbolt/next (d0f1e0c2a699 thunderbolt: Add support for receive=
r lane margining)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (b90cb1053190 Linux 6.0-rc3)
Merging tty/tty-next (35f2e3c267f0 Merge 6.0-rc4 into tty-next)
Merging char-misc/char-misc-next (50e177c5bfd9 Merge 6.0-rc4 into char-misc=
-next)
Merging coresight/next (0a98181f8050 coresight: Make new csdev_access offse=
ts unsigned)
Merging fpga/for-next (939bc5453b8c fpga: prevent integer overflow in dfl_f=
eature_ioctl_set_irq())
Merging icc/icc-next (aff72c797ff0 Merge branch 'icc-ignore-return-val' int=
o icc-next)
Merging iio/togreg (2f61ff827296 iio: pressure: icp10100: Switch from UNIVE=
RSAL to DEFINE_RUNTIME_DEV_PM_OPS().)
Merging phy-next/next (f340ed8664a5 phy: rockchip-inno-usb2: Return zero af=
ter otg sync)
Merging soundwire/next (279e46bc2986 soundwire: intel: cleanup WakeEnable a=
nd WakeStatus)
Merging extcon/extcon-next (822a6200734c extcon: usbc-tusb320: Add USB TYPE=
-C support)
Merging gnss/gnss-next (c0c725d7350e gnss: replace ida_simple API)
Merging vfio/next (245898eb9275 hisi_acc_vfio_pci: Correct the function pre=
fix for hssi_acc_drvdata())
Merging staging/staging-next (28a2a54901f6 Merge 6.0-rc4 into staging-next)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (493c1141f791 dt-bindings: dma: mediatek,uart-dma: A=
dd binding for MT6795 SoC)
Merging cgroup/for-next (538b9e23ed6c Merge branch 'for-6.0-fixes' into for=
-next)
Merging scsi/for-next (eb7f9ca137e3 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (efca52749564 scsi: qla2xxx: Fix spelling mistake=
 "definiton" -> "definition")
Merging vhost/linux-next (8f113a4ad40d virtio: drop vp_legacy_set_queue_siz=
e)
Merging rpmsg/for-next (8e91742629fe Merge branches 'rproc-next' and 'rpmsg=
-next' into for-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (5134272f9f3f gpio: exar: access MPIO regis=
ters on cascaded chips)
Merging gpio-intel/for-next (0ea76c401f92 gpiolib: acpi: Add a quirk for As=
us UM325UAZ)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (4e743cfcffa8 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (568035b01cfb Linux 6.0-rc1)
Merging pinctrl-renesas/renesas-pinctrl (96355be8f0a2 dt-bindings: pinctrl:=
 renesas: Document RZ/Five SoC)
Merging pinctrl-samsung/for-next (9d9292576810 dt-bindings: pinctrl: samsun=
g: deprecate header with register constants)
Merging pwm/for-next (8933d30c5f46 pwm: lpc18xx: Fix period handling)
Merging userns/for-next (a0b88362d2c7 Merge of ucount-rlimits-cleanups-for-=
v5.19, interrupting_kthread_stop-for-v5.20, signal-for-v5.20, and retire_mq=
_sysctls-for-v5.19 for testing in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (997fdfc6b9c0 Documentation: amd-pstate: Add unit te=
st introduction)
CONFLICT (content): Merge conflict in drivers/cpufreq/amd-pstate.c
Merging livepatching/for-next (3ea7cd6069be Merge branch 'for-6.1/fixes' in=
to for-next)
Merging rtc/rtc-next (509451ac03eb rtc: gamecube: Always reset HW_SRNPROT a=
fter read)
Merging nvdimm/libnvdimm-for-next (53fc59511fc4 nvdimm/namespace: drop unne=
eded temporary variable in size_store())
Merging at24/at24/for-next (568035b01cfb Linux 6.0-rc1)
Merging ntb/ntb-next (565aed83d9d9 PCI/AER: Use pci_aer_raw_clear_status() =
to clear root port's AER error status)
Merging seccomp/for-next/seccomp (4e92863862d1 Merge branch 'for-linus/secc=
omp' into for-next/seccomp)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (04823dd2af87 fsi: master-ast-cf: Fix missing of_node_put =
in fsi_master_acf_probe)
Merging slimbus/for-next (568035b01cfb Linux 6.0-rc1)
Merging nvmem/for-next (b7531401aadf nvmem: sort config symbols alphabetica=
lly)
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (d180e0a1be6c Drivers: hv: Create debugfs file w=
ith hyper-v balloon usage information)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (568035b01cfb Linux 6.0-rc1)
Merging kunit/test (568035b01cfb Linux 6.0-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging kunit-next/kunit (568035b01cfb Linux 6.0-rc1)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (acc5495bf764 bus: mhi: host: Fix up null pointer acce=
ss in mhi_irq_handler)
Merging memblock/for-next (42c3ba865818 memblock_tests: move variable decla=
rations to single block)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (1cd8a2537eb0 cxl/hdm: Fix skip allocations vs multiple pm=
em allocations)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (4bf232988200 Merge tag 'efi-loongarch-for-v6.1' into efi/=
next)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (129455392218 Merge branch 'slab/for-6.1/slub_validat=
ion_locking' into slab/for-next)
Applying: bpf: Replace __ksize with ksize.
Merging random/master (4e23eeebb2e5 Merge tag 'bitmap-6.0-rc1' of https://g=
ithub.com/norov/linux)
Merging landlock/next (c6bea81eb6ef Merge branch 'landlock-next-truncate' i=
nto landlock-next)
Merging rust/rust-next (07a3263c2554 init/Kconfig: Specify the interpreter =
for rust_is_available.sh)
CONFLICT (content): Merge conflict in Makefile
Merging sysctl/sysctl-next (374a723c7448 kernel/sysctl.c: Remove trailing w=
hite space)
Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in =
mpage_writepages)
Merging execve/for-next/execve (1c23f9e627a7 Linux 6.0-rc2)
Merging bitmap/bitmap-for-next (057a2f9d6ec6 drivers/base: Fix unsigned com=
parison to -1 in CPUMAP_FILE_MAX_BYTES)
Merging hte/hte/for-next (85ff37e302ef gpiolib: cdev: Fix kernel doc for st=
ruct line)
Merging hte-dp/for-next (568035b01cfb Linux 6.0-rc1)
Merging kspp/for-next/kspp (e9a7815cef69 Merge branches 'for-linus/hardenin=
g' and 'for-next/hardening' into for-next/kspp)
CONFLICT (content): Merge conflict in lib/Kconfig.debug
Merging kspp-gustavo/for-next/kspp (0811296c55b7 exportfs: Replace zero-len=
gth array with DECLARE_FLEX_ARRAY() helper)
Merging mm-stable/mm-stable (b90cb1053190 Linux 6.0-rc3)
Merging mm-nonmm-stable/mm-nonmm-stable (b90cb1053190 Linux 6.0-rc3)
Merging mm/mm-everything (b2ff42824643 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in block/blk-map.c
CONFLICT (content): Merge conflict in crypto/Kconfig
CONFLICT (content): Merge conflict in mm/pagewalk.c
CONFLICT (content): Merge conflict in mm/slub.c
Applying: mm/slab: fix up for "mm: kmsan: call KMSAN hooks from SLUB code"
Applying: crypto: Kconfig: fix up for "crypto: kmsan: disable accelerated c=
onfigs under KMSAN"
Applying: Revert "drm/msm/gem: Evict active GEM objects when necessary"
Applying: Revert "Revert "kbuild: Make scripts/compile.h when sh !=3D bash""
Applying: Revert "scripts/mkcompile_h: move LC_ALL=3DC to '$LD -v'"
Applying: Revert "kbuild: generate include/generated/compile.h in top Makef=
ile"
Applying: Revert "kbuild: build init/built-in.a just once"

--Sig_/3q7dljYXpL/Bmd9V9fmFKk4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMYlLcACgkQAVBC80lX
0GywsggAoV7ERO3mskhhAmiwQjUBnfIp/wB059vSD8ui5MhUyiiSH/zZSqF3G73E
J/Dj3J9Zu9AeJVbLU2/pLVoWPdXrsGAi/AGHtIwWGs4OPzph9QcpJtzJp/2Pwm6A
JyYjs+QhNznd7RG6gQhrbHeFl0PKyRwpxa/ofSr1oiFdtFytYaF+6hOfZOXnSka/
hhHDdHHCYhXxU5526pn8syOCQSVwzPMqaZazBxOdIP0TkoGRkIkLvvcCw9XfviKW
EB0Py0/P6UV2GncA1XOm7rnPxTAPrcgakju8l1NfmZad5f9DsJKVSyvPGx/YEC/2
DKifMxc6bydJzvUUKNnUF1uMpP0q3Q==
=yXvo
-----END PGP SIGNATURE-----

--Sig_/3q7dljYXpL/Bmd9V9fmFKk4--
