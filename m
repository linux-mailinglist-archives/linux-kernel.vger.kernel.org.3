Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52A55A8FD5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiIAHTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiIAHSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:18:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9AC122397;
        Thu,  1 Sep 2022 00:18:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MJC7s5bKcz4x1J;
        Thu,  1 Sep 2022 17:18:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662016713;
        bh=PNnU64eQn3kf8w5+XVU7JM7XKTJLNxrC6usXIWoW9WA=;
        h=Date:From:To:Cc:Subject:From;
        b=UTJLqixtzyyuf7nwuFvLzObrl2uEGcsXUW1CT3DXKyWiu4o5s194YkLJ/keG16Utb
         yHbdOpeL2Qf8+hYKrLBG9fDFH6vEluzs4s7RbnUdNioHL1MgCJ1W2esZSt/qjmvSCR
         +DS3azlXopCe+dlhe5ahduSrb15C9RLaKex/t/niPQ3WiMTwkyBaEq8H9UniP97Rcy
         KSsI/OsQ7ZMzh9xVB8Zl4AXnpLo/nabMaIFkGBAyPRRMViSw6mJEh3KZ4pheeWELi5
         MseXRe4aX/Oda8nsRxMac6/pnyZROzLd5ybwUMS4iMA++Kvaq03CR0ZsdDSkrLFnXR
         uWlbcMAD/wGVw==
Date:   Thu, 1 Sep 2022 17:18:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Sep 1
Message-ID: <20220901171832.78d88aed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/47pYY2R6PGGiXpIWMspZj+/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/47pYY2R6PGGiXpIWMspZj+/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

News: there will be no linux-next releases tomorrow or on Monday.

Changes since 20220831:

New tree: hte-dp (will replace hte)

The perf tree still had its build failure so I used the version from
next-20220830.

The net-next tree gained a conflict against the net tree.

The bpf-next tree gained a conflict against the net tree.

The security tree gained a conflict against Linus' tree.

The usb tree gained a conflict against the usb.current tree.

The scsi-mkp tree still had its build failure so I used the version from
next-20220823.

The mm tree gained a conflict against the block tree.

Non-merge commits (relative to Linus' tree): 4153
 6132 files changed, 271535 insertions(+), 83600 deletions(-)

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
Merging origin/master (c5e4d5e99162 Merge tag 'fscache-fixes-20220831' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs)
Merging fixes/fixes (1c23f9e627a7 Linux 6.0-rc2)
Merging mm-hotfixes/mm-hotfixes-unstable (d3f7b994fe8b x86/mm: disable inst=
rumentations of mm/pgprot.c)
Merging kbuild-current/fixes (c11efc57d4cc scripts/extract-ikconfig: add zs=
td compression support)
Merging arc-current/for-curr (952deecb065e arc: dts: Harmonize EHCI/OHCI DT=
 nodes name)
Merging arm-current/fixes (25af7406df59 ARM: 9229/1: amba: Fix use-after-fr=
ee in amba_read_periphid())
Merging arm64-fixes/for-next/fixes (714f3cbd70a4 arm64/sme: Don't flush SVE=
 register state when handling SME traps)
Merging arm-soc-fixes/arm/fixes (251e5d715e4b ARM: ixp4xx: fix typos in com=
ments)
Merging drivers-memory-fixes/fixes (c941e6305958 dt-bindings: memory-contro=
llers: fsl,imx8m-ddrc: drop Leonard Crestez)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (b508128bb0d1 m68k: defconfig: Update defcon=
figs for v5.19-rc1)
Merging powerpc-fixes/fixes (91926d8b7e71 powerpc/rtas: Fix RTAS MSR[HV] ha=
ndling for Cell)
Merging s390-fixes/fixes (7c8d42fdf1a8 s390/hugetlb: fix prepare_hugepage_r=
ange() check for 2 GB hugepages)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (90fabae8a2c2 sch_cake: Return __NET_XMIT_STOLEN when co=
nsuming enqueued skb)
Merging bpf/master (8a7d61bdc2fa selftests/xsk: Add missing close() on netn=
s fd)
Merging ipsec/master (26dbd66eab80 esp: choose the correct inner protocol f=
or GSO on inter address family tunnels)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (6d0ef7241553 wifi: iwlegacy: 4965: corrected fix=
 for potential off-by-one overflow in il4965_rs_fill_link_cmd())
Merging rdma-fixes/for-rc (27cfde795a96 RDMA/cma: Fix arguments order in ne=
t device validation)
Merging sound-current/for-linus (5f3d9e8161bb ALSA: usb-audio: Add quirk fo=
r LH Labs Geek Out HD Audio 1V5)
Merging sound-asoc-fixes/for-linus (b1cd3fd42db7 ASoC: fsl_aud2htx: Add err=
or handler for pm_runtime_enable)
Merging regmap-fixes/for-linus (f5723cfc0193 regmap: spi: Reserve space for=
 register address/padding)
Merging regulator-fixes/for-linus (475043fabe8c regulator: Fix qcom,spmi-re=
gulator schema)
Merging spi-fixes/for-linus (9ee5b6d53b8c spi: cadence-quadspi: Disable irq=
s during indirect reads)
Merging pci-current/for-linus (0e1fa5155a36 MAINTAINERS: Add Mahesh J Salga=
onkar as EEH maintainer)
Merging driver-core.current/driver-core-linus (a4f124908617 Revert "iommu/o=
f: Delete usage of driver_deferred_probe_check_state()")
Merging tty.current/tty-linus (902e02ea9385 tty: n_gsm: avoid call of sleep=
ing functions from atomic context)
Merging usb.current/usb-linus (58bfe7d8e310 Revert "usb: add quirks for Len=
ovo OneLink+ Dock")
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (41ca302a697b USB: serial: ch341: fix di=
sabled rx timer on older devices)
Merging phy/fixes (0a6fc70d76bd phy: marvell: phy-mvebu-a3700-comphy: Remov=
e broken reset support)
Merging staging.current/staging-linus (e230a4455ac3 staging: rtl8712: fix u=
se after free bugs)
Merging iio-fixes/fixes-togreg (0096fc879358 iio: light: cm32181: make cm32=
181_pm_ops static)
Merging counter-fixes/fixes-togreg (568035b01cfb Linux 6.0-rc1)
Merging char-misc.current/char-misc-linus (5ef251b9b73f Merge tag 'mhi-fixe=
s-for-v6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into =
char-misc-linus)
Merging soundwire-fixes/fixes (c6e50787889c soundwire: qcom: remove duplica=
te reset control get)
Merging thunderbolt-fixes/fixes (93a3c0d4e8bf thunderbolt: Check router gen=
eration before connecting xHCI)
Merging input-current/for-linus (9c9c71168f79 Input: iforce - add support f=
or Boeder Force Feedback Wheel)
Merging crypto-current/master (874b301985ef crypto: lib - remove unneeded s=
election of XOR_BLOCKS)
Merging vfio-fixes/for-linus (afe4e376ac5d vfio: Move IOMMU_CAP_CACHE_COHER=
ENCY test to after we know we have a group)
Merging kselftest-fixes/fixes (bdbf0617bbc3 selftests/vm: fix inability to =
build any vm tests)
Merging modules-fixes/modules-linus (e69a66147d49 module: kallsyms: Ensure =
preemption in add_kallsyms() with PREEMPT_RT)
Merging dmaengine-fixes/fixes (568035b01cfb Linux 6.0-rc1)
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
Merging omap-fixes/fixes (2eb502f496f7 ARM: dts: am33xx: Fix MMCHS0 dma pro=
perties)
Merging kvm-fixes/master (372d07084593 KVM: selftests: Fix ambiguous mov in=
 KVM_ASM_SAFE())
Merging kvms390-fixes/master (ca922fecda6c KVM: s390: pci: Hook to access K=
VM lowlevel from VFIO)
Merging hwmon-fixes/hwmon (f233d2be38db hwmon: (gpio-fan) Fix array out of =
bounds access)
Merging nvdimm-fixes/libnvdimm-fixes (17d9c15c9b9e fsdax: Fix infinite loop=
 in dax_iomap_rw())
Merging cxl-fixes/fixes (e35f5718903b cxl/mbox: Fix missing variable payloa=
d checks in cmd size validation)
Merging btrfs-fixes/next-fixes (af39011ec0c7 Merge branch 'misc-5.19' into =
next-fixes)
Merging vfs-fixes/fixes (3f61631d47f1 take care to handle NULL ->proc_lseek=
())
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (343b62048ba4 platform/x86: thinkpad_acpi: =
Explicitly set to balanced mode on startup)
Merging samsung-krzk-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging pinctrl-samsung-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging devicetree-fixes/dt/linus (40bfe7a86d84 of/device: Fix up of_dma_co=
nfigure_id() stub)
Merging dt-krzk-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging scsi-fixes/fixes (785538bfdd68 scsi: sd: Revert "Rework asynchronou=
s resume support")
Merging drm-fixes/drm-fixes (b90cb1053190 Linux 6.0-rc3)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (0211c2a0ea60 drm/i915: Skip w=
m/ddb readout for disabled pipes)
Merging mmc-fixes/fixes (63f1560930e4 mmc: core: Fix inconsistent sd3_bus_m=
ode at UHS-I SD voltage switch failure)
Merging rtc-fixes/rtc-fixes (568035b01cfb Linux 6.0-rc1)
Merging gnss-fixes/gnss-linus (a111daf0c53a Linux 5.19-rc3)
Merging hyperv-fixes/hyperv-fixes (f15f39fabed2 tools: hv: Remove an extran=
eous "the")
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (1709c70c31e0 Merge branch 'riscv-variable_fixes=
_without_kvm' of git://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux=
.git into fixes)
Merging risc-v-mc-fixes/dt-fixes (0dec364ffeb6 riscv: dts: microchip: use a=
n mpfs specific l2 compatible)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (568035b01cfb Linux 6.0-rc1)
Merging spdx/spdx-linus (568035b01cfb Linux 6.0-rc1)
Merging gpio-brgl-fixes/gpio/for-current (ee0175b3b442 gpio: realtek-otto: =
switch to 32-bit I/O)
Merging gpio-intel-fixes/fixes (b93a8b2c5161 gpio: dln2: make irq_chip immu=
table)
Merging pinctrl-intel-fixes/fixes (1c23f9e627a7 Linux 6.0-rc2)
Merging erofs-fixes/fixes (8b1ac84dcf2c Documentation/ABI: sysfs-fs-erofs: =
Fix Sphinx errors)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (41a55567b9e3 module: kunit: Load .kunit_te=
st_suites section when CONFIG_KUNIT=3Dm)
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
Merging drm-misc-fixes/for-linux-next-fixes (a3f7c10a269d dma-buf/dma-resv:=
 check if the new fence is really later)
Merging kbuild/for-next (144cec848740 nios2: move core-y in arch/nios2/Make=
file to arch/nios2/Kbuild)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (6c3bd8d3e01d perf smt: Tidy header guard add SPDX)
$ git reset --hard HEAD^
Merging next-20220830 version of perf
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (5c850d31880e swiotlb: fix passing local varia=
ble to debugfs_create_ulong())
Merging asm-generic/master (82dc270146a8 Merge branch 'asm-generic-fixes' i=
nto asm-generic)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (5d6dd664478f Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (b90cb1053190 Linux 6.0-rc3)
Merging arm-perf/for-next/perf (aaaee7b55c9e docs: perf: Include hns3-pmu.r=
st in toctree to fix 'htmldocs' WARNING)
Merging arm-soc/for-next (2c77db2b9086 Merge branch 'arm/fixes' into for-ne=
xt)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (d735ce6cafa3 Merge branch 'v6.1/dt64' into for-ne=
xt)
Merging aspeed/for-next (7bc156fbb726 ARM: config: aspeed_g5: Enable PECI)
Merging at91/at91-next (9ff1e8494af5 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (122de0c73256 Merge branch 'maintainers/next' into ne=
xt)
Merging drivers-memory/for-next (f492ddd4aaad Merge branch 'for-v6.1/mediat=
ek' into for-next)
Merging imx-mxs/for-next (a554a9e72736 Merge branch 'imx/dt64' into for-nex=
t)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (63c8a3297683 Merge branch 'v6.0-next/soc' into f=
or-next)
Merging mvebu/for-next (bc50bfd4f018 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (ad2fe4582c48 Merge branches 'omap-for-v5.20/omap1', =
'omap-for-v5.20/ti-sysc' and 'omap-for-v5.20/soc' into for-next)
Merging qcom/for-next (f96be249839f Merge branches 'arm64-defconfig-for-6.1=
', 'arm64-for-6.1', 'clk-for-6.1', 'defconfig-for-6.1', 'drivers-for-6.1', =
'dts-for-6.1' and 'arm64-fixes-for-6.0' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (d561df8d9be0 Merge branches 'renesas-arm-dt-for-v6.1'=
 and 'renesas-dt-bindings-for-v6.1' into renesas-next)
Merging reset/reset/next (d985db836226 reset: tps380x: Fix spelling mistake=
 "Voltags" -> "Voltage")
Merging rockchip/for-next (583fa77c68b4 Merge branch 'v6.1-armsoc/dts64' in=
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
Merging ti/ti-next (b73656582943 dt-bindings: arm: ti: k3: Sort the SoC def=
initions alphabetically)
Merging xilinx/for-next (0413dd4d95da ARM: dts: zynq: add QSPI controller n=
ode)
Merging clk/clk-next (99233aa0121f Merge branch 'clk-mtk' into clk-next)
Merging clk-imx/for-next (c196175acdd3 clk: imx: clk-fracn-gppll: Add more =
freq config for video pll)
Merging clk-renesas/renesas-clk (644814c1070d clk: renesas: r8a779f0: Add M=
SIOF clocks)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (45fef4c4b9c9 csky: abiv1: Fixup compile error)
Merging loongarch/loongarch-next (568035b01cfb Linux 6.0-rc1)
Merging m68k/for-next (1afdc013672b m68k: Move from strlcpy with unused ret=
val to strscpy)
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
Merging powerpc/next (fd20b60aea6a powerpc/82xx: remove spidev node from mg=
coge)
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
Merging fscrypt/master (deb4c809d7e8 fscrypt: work on block_devices instead=
 of request_queues)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (1e6d4089902a Merge branch 'for-next-next-v6.0-20220=
830' into for-next-20220830)
Merging ceph/master (a8af0d682ae0 libceph: clean up ceph_osdc_start_request=
 prototype)
Merging cifs/for-next (27893dfc1285 cifs: fix small mempool leak in SMB2_ne=
gotiate())
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (0d53d2e882f9 erofs: avoid the potentially wrong m_plen f=
or big pcluster)
Merging exfat/dev (bb2bfc5e0772 exfat: fix overflow for large capacity part=
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
Merging nfsd/for-next (bcaa9f42a0d5 NFSD: remove redundant variable status)
Merging ntfs3/master (3b06a2755758 Merge tag 'ntfs3_for_6.0' of https://git=
hub.com/Paragon-Software-Group/linux-ntfs3)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (4f1196288dfb ovl: fix spelling mistakes)
Merging ubifs/next (8c03a1c21d72 ubi: ubi_create_volume: Fix use-after-free=
 when volume creation failed)
Merging v9fs/9p-next (aa7aeee16948 net/9p: Initialize the iounit field duri=
ng fid creation)
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
Merging pstore/for-next/pstore (2c09d1443b9b pstore/zone: cleanup "rcnt" ty=
pe)
Merging hid/for-next (1f21e5bfbac7 Merge branch 'for-6.0/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (e847867330ea Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (568035b01cfb Linux 6.0-rc1)
Merging dmi/dmi-for-next (d2139dfca361 firmware: dmi: Use the proper access=
or for the version field)
Merging hwmon-staging/hwmon-next (9e544d72f31a docs: hwmon: add emc2305.rst=
 to docs)
Applying: hwmon: (emc2305) fix up for "i2c: Make remove callback return voi=
d"
Merging jc_docs/docs-next (7ebeef22dcc2 Merge branch 'docs-mw' into docs-ne=
xt)
Merging v4l-dvb/master (568035b01cfb Linux 6.0-rc1)
Merging v4l-dvb-next/master (fbb6c848dd89 media: destage Hantro VPU driver)
Merging pm/linux-next (41607487f81c Merge branch 'thermal-core' into linux-=
next)
Merging cpufreq-arm/cpufreq/arm/linux-next (3359d52755e5 cpufreq: bmips-cpu=
freq: Use module_init and add module_exit)
Merging cpupower/cpupower (568035b01cfb Linux 6.0-rc1)
Merging devfreq/devfreq-next (68831c5f94cb PM / devfreq: mtk-cci: Handle sr=
am regulator probe deferral)
Merging opp/opp/linux-next (c7e31e36d8a2 dt-bindings: opp: Add missing (une=
valuated|additional)Properties on child nodes)
Merging thermal/thermal/linux-next (06f360551217 Revert "mlxsw: core: Add t=
he hottest thermal zone detection")
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (56171e0db23a fs: dlm: const void resource name parameter)
Merging rdma/for-next (bfb3bde95479 RDMA/hns: Remove redundant member doorb=
ell_qpn of struct hns_roce_qp)
Merging net-next/master (7305b78ae45f r8152: allow userland to disable mult=
icast)
CONFLICT (content): Merge conflict in tools/testing/selftests/net/.gitignore
Merging bpf-next/for-next (c9ae8c966f05 Merge branch 'fixes for concurrent =
htab updates')
CONFLICT (content): Merge conflict in net/core/filter.c
CONFLICT (content): Merge conflict in tools/testing/selftests/bpf/DENYLIST.=
s390x
Merging ipsec-next/master (2c2493b9da91 xfrm: lwtunnel: add lwtunnel suppor=
t for xfrm interfaces in collect_md mode)
Merging mlx5-next/mlx5-next (b0bb369ee451 net/mlx5: fs, allow flow table cr=
eation with a UID)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (177978b29426 Bluetooth: btusb: mediatek: fix WMT =
failure during runtime suspend)
Merging wireless-next/for-next (8d40a13bc35d Merge ath-next from git://git.=
kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging mtd/mtd/next (7ec4cdb32173 mtd: core: check partition before derefe=
rence)
Merging nand/nand/next (e16eceea863b mtd: rawnand: arasan: Fix clock rate i=
n NV-DDR)
Merging spi-nor/spi-nor/next (f8cd9f632f44 mtd: spi-nor: fix spi_nor_spimem=
_setup_op() call in spi_nor_erase_{sector,chip}())
Merging crypto/master (a9a98d49da52 crypto: Kconfig - simplify compression/=
RNG entries)
Merging drm/drm-next (2c2d7a67defa Merge tag 'drm-intel-gt-next-2022-08-24'=
 of git://anongit.freedesktop.org/drm/drm-intel into drm-next)
Merging drm-misc/for-linux-next (e6545831a17b MAINTAINERS: Add myself as a =
reviewer for panel-edp.c)
CONFLICT (content): Merge conflict in drivers/gpu/drm/tiny/simpledrm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/vc4/vc4_hdmi.c
Merging amdgpu/drm-next (a462e4b9a6a8 drm/amd/display: fix documentation fo=
r amdgpu_dm_update_freesync_caps())
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/inc/pmfw=
_if/smu13_driver_if_v13_0_0.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/inc/smu_=
v13_0.h
Merging drm-intel/for-linux-next (a5810f551d0a drm/i915: Allow more varied =
alternate fixed modes for panels)
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
Merging drm-msm/msm-next (1c23f9e627a7 Linux 6.0-rc2)
Merging drm-msm-lumag/msm-next-lumag (7fc1bfe18f16 Merge branches 'msm-next=
-lumag-core', 'msm-next-lumag-dpu', 'msm-next-lumag-dp', 'msm-next-lumag-ds=
i' and 'msm-next-lumag-hdmi' into msm-next-lumag)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (332f847212e4 drm/etnaviv: reap idle mapping i=
f it doesn't match the softpin address)
Merging fbdev/for-next (1c23f9e627a7 Linux 6.0-rc2)
Merging regmap/for-next (1bfa8e736383 Merge remote-tracking branch 'regmap/=
for-6.1' into regmap-next)
Merging sound/for-next (999b95a72d90 ALSA: hda/hdmi: Replace zero-length ar=
ray with DECLARE_FLEX_ARRAY() helper)
Merging sound-asoc/for-next (7c6c54c8af47 Merge remote-tracking branch 'aso=
c/for-6.1' into asoc-next)
Merging modules/modules-next (554694ba120b module: Replace kmap() with kmap=
_local_page())
Merging input/next (ed3d5bd20dcd Input: rt5120 - add power key support)
Merging block/for-next (3009394a00cc Merge branch 'for-6.1/io_uring' into f=
or-next)
Merging device-mapper/for-next (c8e2f5c3682d dm verity: enable WQ_HIGHPRI o=
n verify_wq)
Merging libata/for-next (e9892dce44f2 ata: pata_macio: Remove unneeded word=
 in comments)
Merging pcmcia/pcmcia-next (2ef4bb24ff39 pcmcia: Use platform_get_irq() to =
get the interrupt)
Merging mmc/next (ca93b1faebab mmc: meson-gx: add SDIO interrupt support)
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
Merging regulator/for-next (c2b819c4bbe4 Merge remote-tracking branch 'regu=
lator/for-6.1' into regulator-next)
Merging security/next (abec3d015fdf userfaultfd: open userfaultfds with O_R=
DONLY)
CONFLICT (content): Merge conflict in security/selinux/include/classmap.h
Merging apparmor/apparmor-next (79eb2711c919 apparmor: correct config refer=
ence to intended one)
Merging integrity/next-integrity (88b61b130334 Merge remote-tracking branch=
 'linux-integrity/kexec-keyrings' into next-integrity)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (6354324d8a3e selinux: declare read-only parameters co=
nst)
Merging smack/next (b50503990d88 smack: Remove the redundant lsm_inode_allo=
c)
Merging tomoyo/master (05fe531eb3f1 kernel/hung_task: show backtrace of tas=
ks with locks held)
Merging tpmdd/next (863ed94c589f tpm: Add check for Failure mode for TPM2 m=
odules)
Merging watchdog/master (b90cb1053190 Linux 6.0-rc3)
Merging iommu/next (c10100a416c1 Merge branches 'arm/exynos', 'arm/mediatek=
', 'arm/msm', 'arm/smmu', 'virtio', 'x86/vt-d', 'x86/amd' and 'core' into n=
ext)
Merging audit/next (501e4bb102ee audit: use time_after to compare time)
Merging devicetree/for-next (a536208da6f7 dt-bindings: crypto: ti,sa2ul: dr=
op dma-coherent property)
Merging dt-krzk/for-next (a70369e1b7f6 ARM: dts: sunplus: sp7021: drop inco=
rrect spi-max-frequency)
Merging mailbox/mailbox-for-next (8a8dc2b9596e mailbox: imx: clear pending =
interrupts)
Merging spi/for-next (1adcde45713c Merge remote-tracking branch 'spi/for-6.=
1' into spi-next)
Merging tip/master (f9c08c27f196 Merge branch into tip/master: 'x86/timers')
Merging clockevents/timers/drivers/next (c19e18637d89 clocksource/drivers/s=
un4i: Remove unnecessary (void*) conversions)
Merging edac/edac-for-next (35636db93725 Merge edac-misc into for-next)
Merging irqchip/irq/irqchip-next (2bd1753e8c43 Merge branch irq/misc-5.20 i=
nto irq/irqchip-next)
Merging ftrace/for-next (07a451dae367 Merge branch 'trace/for-next-core' in=
to trace/for-next)
Merging rcu/rcu/next (97a2c50e702a rcutorture: Verify NUM_ACTIVE_RCU_POLL_O=
LDSTATE)
Merging kvm/next (372d07084593 KVM: selftests: Fix ambiguous mov in KVM_ASM=
_SAFE())
Merging kvm-arm/next (0982c8d859f8 Merge branch kvm-arm64/nvhe-stacktrace i=
nto kvmarm-master/next)
Merging kvms390/next (f5ecfee94493 KVM: s390: resetting the Topology-Change=
-Report)
Merging xen-tip/linux-next (c5deb27895e0 xen/privcmd: fix error exit of pri=
vcmd_ioctl_dm_op())
Merging percpu/for-next (a111daf0c53a Linux 5.19-rc3)
Merging workqueues/for-next (c0feea594e05 workqueue: don't skip lockdep wor=
k dependency in cancel_work_sync())
Merging drivers-x86/for-next (c35c7b980597 platform/x86: msi-laptop: Add ms=
i_scm_disable_hw_fn_handling() helper)
Merging chrome-platform/for-next (8a07b45fd3c2 platform/chrome: fix memory =
corruption in ioctl)
Merging hsi/for-next (551e325bbd3f HSI: omap_ssi_port: Fix dma_map_sg error=
 check)
Merging leds/for-next (568035b01cfb Linux 6.0-rc1)
Merging ipmi/for-next (4aebcc9059d8 dt-binding: ipmi: add fallback to npcm8=
45 compatible)
Merging driver-core/driver-core-next (1c23f9e627a7 Linux 6.0-rc2)
Merging usb/usb-next (8f36b3b4e1b5 usbip: add USBIP_URB_* URB transfer flag=
s)
CONFLICT (content): Merge conflict in drivers/usb/dwc3/gadget.c
Merging thunderbolt/next (32249fd8c8cc thunderbolt: Add support for Intel M=
eteor Lake)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (b90cb1053190 Linux 6.0-rc3)
Merging tty/tty-next (cac8f7194111 serial: tegra: Remove custom frame size =
calculation)
Merging char-misc/char-misc-next (568035b01cfb Linux 6.0-rc1)
Merging coresight/next (0a98181f8050 coresight: Make new csdev_access offse=
ts unsigned)
Merging fpga/for-next (e167b2c3a0e6 dt-bindings: fpga: microchip,mpf-spi-fp=
ga-mgr: use spi-peripheral-props.yaml)
Merging icc/icc-next (aff72c797ff0 Merge branch 'icc-ignore-return-val' int=
o icc-next)
Merging iio/togreg (f5ffeca5086f iio: light: ltrf216a: Add raw attribute)
Merging phy-next/next (c8c5d5e89ac5 phy: qcom-qmp-usb: drop pipe clock lane=
 suffix)
Merging soundwire/next (1f2dcf3a154a soundwire: intel: set dev_num_ida_min)
Merging extcon/extcon-next (822a6200734c extcon: usbc-tusb320: Add USB TYPE=
-C support)
Merging gnss/gnss-next (c0c725d7350e gnss: replace ida_simple API)
Merging vfio/next (0f3e72b5c8cf vfio: Move vfio.c to vfio_main.c)
Merging staging/staging-next (6d29e08007c5 staging: vt6655: Rename function=
 MACvSetShortRetryLimit)
CONFLICT (content): Merge conflict in drivers/staging/r8188eu/os_dep/os_int=
fs.c
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (568035b01cfb Linux 6.0-rc1)
Merging cgroup/for-next (5214a36f9afe Merge branch 'for-6.1' into for-next)
Merging scsi/for-next (785538bfdd68 scsi: sd: Revert "Rework asynchronous r=
esume support")
Merging scsi-mkp/for-next (8750aa54da43 scsi: megaraid_sas: Use struct_size=
() in code related to struct MR_PD_CFG_SEQ_NUM_SYNC)
$ git reset --hard HEAD^
Merging next-20220823 version of scsi-mkp
Merging vhost/linux-next (8f113a4ad40d virtio: drop vp_legacy_set_queue_siz=
e)
Merging rpmsg/for-next (729c16326b7f remoteproc: imx_dsp_rproc: fix argumen=
t 2 of rproc_mem_entry_init)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (0e056f414e5b dt-bindings: gpio: stmpe: Rem=
ove node name requirement)
Merging gpio-intel/for-next (9c3c24f08289 gpiolib: acpi: Add a quirk for As=
us UM325UAZ)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (98f0c2fc1fa3 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (1c23f9e627a7 Linux 6.0-rc2)
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
Merging livepatching/for-next (df44b1ee72f4 Merge branch 'for-5.20/selftest=
s-fixes' into for-next)
Merging rtc/rtc-next (509451ac03eb rtc: gamecube: Always reset HW_SRNPROT a=
fter read)
Merging nvdimm/libnvdimm-for-next (53fc59511fc4 nvdimm/namespace: drop unne=
eded temporary variable in size_store())
Merging at24/at24/for-next (568035b01cfb Linux 6.0-rc1)
Merging ntb/ntb-next (7e6bd8246967 net: ethernet: move from strlcpy with un=
used retval to strscpy)
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
Merging memblock/for-next (dcd45ad2ad78 memblock tests: add tests for membl=
ock_trim_memory)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (1cd8a2537eb0 cxl/hdm: Fix skip allocations vs multiple pm=
em allocations)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (bb45d2db8492 Merge tag 'efi-loongarch-for-v6.1' into efi/=
next)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (68704dd63c5e Merge branch 'slab/for-6.1/slub_validat=
ion_locking' into slab/for-next)
Merging random/master (4e23eeebb2e5 Merge tag 'bitmap-6.0-rc1' of https://g=
ithub.com/norov/linux)
Merging landlock/next (e1cdfbfade70 Merge branch 'landlock-next-truncate' i=
nto landlock-next)
Merging rust/rust-next (07a3263c2554 init/Kconfig: Specify the interpreter =
for rust_is_available.sh)
CONFLICT (content): Merge conflict in Makefile
Merging sysctl/sysctl-next (374a723c7448 kernel/sysctl.c: Remove trailing w=
hite space)
Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in =
mpage_writepages)
Merging execve/for-next/execve (1c23f9e627a7 Linux 6.0-rc2)
Merging bitmap/bitmap-for-next (5d7fef0804b0 lib/cpumask_kunit: add tests f=
ile to MAINTAINERS)
Merging hte/hte/for-next (85ff37e302ef gpiolib: cdev: Fix kernel doc for st=
ruct line)
Merging hte-dp/for-next (568035b01cfb Linux 6.0-rc1)
Merging kspp/for-next/kspp (0f094d89b354 overflow: Allow mixed type argumen=
ts)
Merging kspp-gustavo/for-next/kspp (568035b01cfb Linux 6.0-rc1)
Merging mm-stable/mm-stable (ec6624452e36 Merge branch 'linus')
Merging mm-nonmm-stable/mm-nonmm-stable (ec6624452e36 Merge branch 'linus')
Merging mm/mm-everything (671befb18901 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in block/blk-map.c
CONFLICT (content): Merge conflict in mm/memory-failure.c
CONFLICT (content): Merge conflict in mm/page_alloc.c
CONFLICT (content): Merge conflict in mm/vmscan.c

--Sig_/47pYY2R6PGGiXpIWMspZj+/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMQXMgACgkQAVBC80lX
0GzSDwf/cT3mlWTTt0aPvjBJaVb3zxRx6DFNBKtzPil8kZO5NHg0Kxaj4tget7dG
IEDtq0bP4eMJBCD4adJNntOA6lOLg6378xlapT8Y34VIOPDvS/us3TLFYtfAVK8/
AdPu9BFflVck9awymhnwwq/nOpxtaj5VBpiRBf+WJcvYpLVb0HnZWnDRKZeZFfER
bBgK1JZkrTUfC3Rd2FQrtGnDUIU3EJtaj18GqMyWr0A0equNMvVzbgaefg6b6CCK
OcRfWKG/vKZLAkbVYLnxwVIn1p3Di+/DcxIjG19YV3K0WCg0rwFFPgukt2L2wq+P
61Y39qwxYtADWNuSF85Xbxgze/MkEA==
=D0qg
-----END PGP SIGNATURE-----

--Sig_/47pYY2R6PGGiXpIWMspZj+/--
