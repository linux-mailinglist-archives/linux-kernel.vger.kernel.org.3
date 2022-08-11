Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC0758F5C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiHKCP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbiHKCP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:15:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822C513FB9;
        Wed, 10 Aug 2022 19:15:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M39Ph0qm8z4x1L;
        Thu, 11 Aug 2022 12:15:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660184120;
        bh=iWpvhkBAbQLx7MgByfLNM9RwpfvnJeyBKmNQ+a80W+A=;
        h=Date:From:To:Cc:Subject:From;
        b=cOBaH+vQt8jgztRkABfAonGcqZ77qBBPw1rNs2wTtWoLT+YAAHY0+RE3XPH1kdC3p
         OzfRP5hS4d92yG0L5eWREEOoNkMJy/xvF3gOLez9F/xkgFq6j/DwWp//UETDKEcdeP
         O45hbAhNCkZdakcgjedKzHfOcE0qxH4dB4l5MYwgSvCuUanH/MTbF5Pv09eGHbBJ8G
         a3ufE47+wmbRHRGg0xD+pwrONESyZ0eVCuJySZPR+BfSw8f34FuHp+dBjjhSm0kagT
         s1qgYQeyAKnpNvYAZhSizi9eY6DzYpw9pci4ht/FkGxEgAc1SvoZTF7eCb5ydeQ096
         Qhx54glxRn+1A==
Date:   Thu, 11 Aug 2022 12:15:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Aug 11
Message-ID: <20220811121518.046bf301@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ChOSne0LCXAymos7sT_g=G2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ChOSne0LCXAymos7sT_g=G2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do not add any v6.1 destined code to your linux-next included
branches until after v6.0-rc1 has been released.

Changes since 20220810:

The loongarch tree gained a conflict against the irqchip-fixes tree.

Non-merge commits (relative to Linus' tree): 1021
 970 files changed, 42893 insertions(+), 11128 deletions(-)

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

I am currently merging 356 trees (counting Linus' and 98 trees of bug
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
Merging origin/master (aeb6e6ac18c7 Merge tag 'nfs-for-5.20-1' of git://git=
.linux-nfs.org/projects/trondmy/linux-nfs)
Merging fixes/fixes (4a57a8400075 vf/remap: return the amount of bytes actu=
ally deduplicated)
Merging mm-hotfixes/mm-hotfixes-unstable (536db7c2766a mm: re-allow pinning=
 of zero pfns (again))
Merging kbuild-current/fixes (32346491ddf2 Linux 5.19-rc6)
Merging arc-current/for-curr (952deecb065e arc: dts: Harmonize EHCI/OHCI DT=
 nodes name)
Merging arm-current/fixes (ec85bd369fd2 ARM: findbit: fix overflowing offse=
t)
Merging arm64-fixes/for-next/fixes (410982303772 arm64: hugetlb: Restore TL=
B invalidation for BBM on contiguous ptes)
Merging arm-soc-fixes/arm/fixes (3cbd67384677 MAINTAINERS: add the Polarfir=
e SoC's i2c driver)
Merging drivers-memory-fixes/fixes (1332661e0930 memory: samsung: exynos542=
2-dmc: Fix refcount leak in of_get_dram_timings)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (b508128bb0d1 m68k: defconfig: Update defcon=
figs for v5.19-rc1)
Merging powerpc-fixes/fixes (83ee9f23763a powerpc/kexec: Fix build failure =
from uninitialised variable)
Merging s390-fixes/fixes (918e75f77af7 s390/archrandom: prevent CPACF trng =
invocations in interrupt context)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (f329a0ebeaba genetlink: correct uAPI defines)
Merging bpf/master (e7c677bdd03d Merge branch 'fixes for bpf map iterator')
Merging ipsec/master (ba953a9d89a0 af_key: Do not call xfrm_probe_algs in p=
arallel)
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (677fb7525331 Merge git://git.kernel.org/pub/scm/linux/=
kernel/git/netdev/net)
Merging wireless/for-next (bc3c8fe3c79b plip: avoid rcu debug splat)
Merging rdma-fixes/for-rc (cc0315564d6e RDMA/irdma: Fix sleep from invalid =
context BUG)
Merging sound-current/for-linus (6b2394bad503 ALSA: usb-audio: make read-on=
ly array marker static const)
Merging sound-asoc-fixes/for-linus (dc40b9ea09d2 Merge remote-tracking bran=
ch 'asoc/for-5.19' into asoc-linus)
Merging regmap-fixes/for-linus (3f05010f243b regmap-irq: Fix offset/index m=
ismatch in read_sub_irq_data())
Merging regulator-fixes/for-linus (d511e8a7e850 regulator: core: Fix missin=
g error return from regulator_bulk_get())
Merging spi-fixes/for-linus (4188e495dd66 Merge remote-tracking branch 'spi=
/for-5.19' into spi-linus)
Merging pci-current/for-linus (f2906aa86338 Linux 5.19-rc1)
Merging driver-core.current/driver-core-linus (d4252071b97d add barriers to=
 buffer_uptodate and set_buffer_uptodate)
Merging tty.current/tty-linus (d4252071b97d add barriers to buffer_uptodate=
 and set_buffer_uptodate)
Merging usb.current/usb-linus (d4252071b97d add barriers to buffer_uptodate=
 and set_buffer_uptodate)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (ff6992735ade Linux 5.19-rc7)
Merging phy/fixes (f2906aa86338 Linux 5.19-rc1)
Merging staging.current/staging-linus (d4252071b97d add barriers to buffer_=
uptodate and set_buffer_uptodate)
Merging iio-fixes/fixes-togreg (b3e6b165f59f iio: adc: mcp3911: use correct=
 formula for AD conversion)
Merging counter-fixes/fixes-togreg (f2906aa86338 Linux 5.19-rc1)
Merging char-misc.current/char-misc-linus (d4252071b97d add barriers to buf=
fer_uptodate and set_buffer_uptodate)
Merging soundwire-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging thunderbolt-fixes/fixes (3d7cb6b04c3f Linux 5.19)
Merging input-current/for-linus (8bb5e7f4dcd9 Merge branch 'next' into for-=
linus)
Merging crypto-current/master (af5d35b83f64 crypto: tcrypt - Remove the sta=
tic variable initialisations to NULL)
Merging vfio-fixes/for-linus (afe4e376ac5d vfio: Move IOMMU_CAP_CACHE_COHER=
ENCY test to after we know we have a group)
Merging kselftest-fixes/fixes (9b4d5c01eb23 selftests: make use of GUP_TEST=
_FILE macro)
Merging modules-fixes/modules-linus (e69a66147d49 module: kallsyms: Ensure =
preemption in add_kallsyms() with PREEMPT_RT)
Merging dmaengine-fixes/fixes (607a48c78e6b dt-bindings: dma: allwinner,sun=
50i-a64-dma: Fix min/max typo)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (0fddf9ad06fd mtd: rawnand: gpmi: Set WAIT_FOR_=
READY timeout based on program/erase times)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (3bcc2c1eade4 media: rkvdec: Disable H.264 erro=
r detection)
Merging reset-fixes/reset/fixes (a57f68ddc886 reset: Fix devm bulk optional=
 exclusive control getter)
Merging mips-fixes/mips-fixes (88084a3df167 Linux 5.19-rc5)
Merging at91-fixes/at91-fixes (ef0324b6415d ARM: dts: lan966x: fix sys_clk =
frequency)
Merging omap-fixes/fixes (2eb502f496f7 ARM: dts: am33xx: Fix MMCHS0 dma pro=
perties)
Merging kvm-fixes/master (6348aafa8d24 KVM: VMX: Adjust number of LBR recor=
ds for PERF_CAPABILITIES at refresh)
Merging kvms390-fixes/master (cf5029d5dd7c KVM: x86: Protect the unused bit=
s in MSR exiting flags)
Merging hwmon-fixes/hwmon (f4e6960f4f16 hwmon: (nct6775) Fix platform drive=
r suspend regression)
Merging nvdimm-fixes/libnvdimm-fixes (17d9c15c9b9e fsdax: Fix infinite loop=
 in dax_iomap_rw())
Merging cxl-fixes/fixes (e35f5718903b cxl/mbox: Fix missing variable payloa=
d checks in cmd size validation)
Merging btrfs-fixes/next-fixes (af39011ec0c7 Merge branch 'misc-5.19' into =
next-fixes)
Merging vfs-fixes/fixes (c3497fd009ef fix short copy handling in copy_mc_pi=
pe_to_iter())
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (5ad26161a371 ACPI: video: Fix acpi_video_h=
andles_brightness_key_presses())
Merging samsung-krzk-fixes/fixes (c4c79525042a ARM: exynos: Fix refcount le=
ak in exynos_map_pmu)
Merging pinctrl-samsung-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging devicetree-fixes/dt/linus (2ac2920cd8d9 dt-bindings: mailbox: arm,m=
hu: Make secure interrupt optional)
Merging dt-krzk-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging scsi-fixes/fixes (f5c2976e0cb0 scsi: ufs: core: Fix a race conditio=
n related to device management)
Merging drm-fixes/drm-fixes (3d7cb6b04c3f Linux 5.19)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (3d7cb6b04c3f Linux 5.19)
Merging mmc-fixes/fixes (51189eb9ddc8 mmc: sdhci-omap: Fix a lockdep warnin=
g for PM runtime init)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (a111daf0c53a Linux 5.19-rc3)
Merging hyperv-fixes/hyperv-fixes (49d6a3c062a1 x86/Hyper-V: Add SEV negoti=
ate protocol support in Isolation VM)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (88bd24d73d5b riscv: compat: vdso: Fix vdso_inst=
all target)
Merging risc-v-mc-fixes/dt-fixes (efa310ba0071 riscv: dts: microchip: hook =
up the mpfs' l2cache)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging spdx/spdx-linus (d4252071b97d add barriers to buffer_uptodate and s=
et_buffer_uptodate)
Merging gpio-brgl-fixes/gpio/for-current (e0dccc3b76fb Linux 5.19-rc8)
Merging gpio-intel-fixes/fixes (b93a8b2c5161 gpio: dln2: make irq_chip immu=
table)
Merging pinctrl-intel-fixes/fixes (ba79c5e45eec MAINTAINERS: Update Intel p=
in control to Supported)
Merging erofs-fixes/fixes (8b1ac84dcf2c Documentation/ABI: sysfs-fs-erofs: =
Fix Sphinx errors)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (f2906aa86338 Linux 5.19-rc1)
Merging ubifs-fixes/fixes (c3c07fc25f37 ubi: fastmap: Return error code if =
memory allocation fails in add_aeb())
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (1197eb5906a5 lockd: fix nlm_close_files)
Merging irqchip-fixes/irq/irqchip-fixes (7e4fd7a1a6fd irqchip/loongarch: Fi=
x irq_domain_alloc_fwnode() abuse)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging broadcom-fixes/fixes (a26f045984e7 Merge branch 'devicetree/fixes' =
into fixes)
Merging perf-current/perf/urgent (bb83c99d3d0a Merge tag 'perf-tools-fixes-=
for-v5.19-2022-07-29' of git://git.kernel.org/pub/scm/linux/kernel/git/acme=
/linux)
Merging efi-fixes/urgent (aa6d1ed107eb efi/x86: libstub: Fix typo in __efi6=
4_argmap* name)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging battery-fixes/fixes (093d27bb6f2d power: supply: core: Fix boundary=
 conditions in interpolation)
Merging drm-misc-fixes/for-linux-next-fixes (cf4b7387c0a8 drm/ttm: Fix dumm=
y res NULL ptr deref bug)
Merging kbuild/for-next (672fb6740cbf modpost: remove .symbol_white_list fi=
eld entirely)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (b39c9e1b101d perf machine: Fix missing free of mach=
ine->kallsyms_filename)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (5c850d31880e swiotlb: fix passing local varia=
ble to debugfs_create_ulong())
Merging asm-generic/master (82dc270146a8 Merge branch 'asm-generic-fixes' i=
nto asm-generic)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (3eaecd0677e1 Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (892f7237b3ff arm64: Delay initialisation of cp=
uinfo_arm64::reg_{zcr,smcr})
Merging arm-perf/for-next/perf (aaaee7b55c9e docs: perf: Include hns3-pmu.r=
st in toctree to fix 'htmldocs' WARNING)
Merging arm-soc/for-next (87a5b37a8f02 Merge branch 'arm/late' into for-nex=
t)
CONFLICT (content): Merge conflict in arch/arm/mach-s3c/Kconfig.s3c64xx
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (147c83586707 Merge branch 'v5.20/drivers' into fo=
r-next)
Merging aspeed/for-next (bfcbea2c93e5 ARM: dts: aspeed: nuvia: rename vendo=
r nuvia to qcom)
Merging at91/at91-next (38b729bf1ee6 Merge branch 'at91-dt' into at91-next)
Merging broadcom/next (ade0d6ecf54a Merge branch 'drivers/next' into next)
Merging drivers-memory/for-next (1b33eb4acdc8 Merge branch 'for-v5.20/mem-c=
trl-next-late' into for-next)
Merging imx-mxs/for-next (37960df982d0 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (5281655db0e1 Merge branch 'v5.19-next/soc' into =
for-next)
Merging mvebu/for-next (bc50bfd4f018 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (ad2fe4582c48 Merge branches 'omap-for-v5.20/omap1', =
'omap-for-v5.20/ti-sysc' and 'omap-for-v5.20/soc' into for-next)
Merging qcom/for-next (58b9ca29ff61 Merge branches 'arm64-for-5.20', 'arm64=
-defconfig-for-5.20', 'clk-for-5.20', 'dts-for-5.20', 'dts-fixes-for-5.19' =
and 'drivers-for-5.20' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (b5468cb7909f Merge branches 'renesas-arm-dt-for-v5.20=
' and 'renesas-dt-bindings-for-v5.20' into renesas-next)
Merging reset/reset/next (d985db836226 reset: tps380x: Fix spelling mistake=
 "Voltags" -> "Voltage")
Merging rockchip/for-next (2e1170c71ec0 Merge branch 'v5.20-armsoc/dts64' i=
nto for-next)
Merging samsung-krzk/for-next (5642cb8ce0f1 Merge branch 'next/dt' into for=
-next)
Merging scmi/for-linux-next (3d7cb6b04c3f Linux 5.19)
Merging stm32/stm32-next (4b43ff02d2a4 ARM: dts: stm32: Add ST MIPID02 bind=
ings to AV96)
Merging sunxi/sunxi/for-next (3a83b092dd59 Merge branch 'sunxi/dt-for-5.20'=
 into sunxi/for-next)
Merging tee/next (db30e53bf897 Merge branch 'tee_cleanup_for_v5.19' into ne=
xt)
Merging tegra/for-next (393c6c3a6152 Merge branch for-5.20/arm64/defconfig =
into for-next)
Merging ti/ti-next (62b9e4033c13 Merge branches 'ti-drivers-soc-next' and '=
ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (b2a88c212e65 Merge tag 'xfs-5.20-merge-6' of git:/=
/git.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging clk/clk-next (08fc500fe3d4 Merge branch 'clk-allwinner' into clk-ne=
xt)
Merging clk-imx/for-next (c196175acdd3 clk: imx: clk-fracn-gppll: Add more =
freq config for video pll)
Merging clk-renesas/renesas-clk (0e704f6c42dc clk: renesas: rcar-gen4: Fix =
initconst confusion for cpg_pll_config)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (45fef4c4b9c9 csky: abiv1: Fixup compile error)
Merging loongarch/loongarch-next (fceb991307c3 docs/zh_CN/LoongArch: Add I1=
4 description)
CONFLICT (content): Merge conflict in arch/loongarch/include/asm/irq.h
Merging m68k/for-next (b508128bb0d1 m68k: defconfig: Update defconfigs for =
v5.19-rc1)
Merging m68knommu/for-next (472e68df4a5e m68k: Fix syntax errors in comment=
s)
Merging microblaze/next (4e23eeebb2e5 Merge tag 'bitmap-6.0-rc1' of https:/=
/github.com/norov/linux)
Merging mips/mips-next (74de14fe05dd MIPS: tlbex: Explicitly compare _PAGE_=
NO_EXEC against 0)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (52e0ea900202 openrisc: io: Define iounmap argume=
nt as volatile)
Merging parisc-hd/for-next (3d7cb6b04c3f Linux 5.19)
Merging powerpc/next (cae4199f9319 Merge tag 'powerpc-6.0-1' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (8f2f74b4b6e6 RISC-V: Canaan devicetree fixes)
Merging risc-v-mc/dt-for-next (88d319c6abae riscv: dts: microchip: Add mpfs=
' topology information)
Merging s390/for-next (53897c8b7f82 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (af3e16101cee um: include sys/types.h for size_t)
Merging xtensa/xtensa-for-next (0847d167d0f9 xtensa: enable ARCH_HAS_GCOV_P=
ROFILE_ALL)
Merging pidfd/for-next (6a857ab5b57c Merge branch 'fs.idmapped.overlay.acl'=
 into for-next)
Merging fscrypt/master (218d921b581e fscrypt: add new helper functions for =
test_dummy_encryption)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (6130a25681d4 Merge branch 'for-next-next-v5.20-2022=
0804' into for-next-20220804)
Merging ceph/master (a8af0d682ae0 libceph: clean up ceph_osdc_start_request=
 prototype)
Merging cifs/for-next (773891ffd4d6 cifs: fix lock length calculation)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (ecce9212d0fd erofs: update ctx->pos for every emitted di=
rent)
Merging exfat/dev (df13a3477635 MAINTAINERS: Add Namjae's exfat git tree)
Merging ext3/for_next (5b02b6900c8d Pull fsnotify typo fix.)
Merging ext4/dev (d95efb14c0b8 ext4: add ioctls to get/set the ext4 superbl=
ock uuid)
Merging f2fs/dev (5d5d353bed32 Merge tag 'rproc-v5.20' of git://git.kernel.=
org/pub/scm/linux/kernel/git/remoteproc/linux)
Merging fsverity/fsverity (8da572c52a9b fs-verity: mention btrfs support)
Merging fuse/for-next (247861c325c2 fuse: retire block-device-based superbl=
ock on force unmount)
Merging gfs2/for-next (446279168e03 Merge part of branch 'for-next.instanti=
ate' into for-next)
Merging jfs/jfs-next (e471e5942c00 fs/jfs: Remove dead code)
Merging ksmbd/ksmbd-for-next (eb555cb5b794 Merge tag '5.20-rc-ksmbd-server-=
fixes' of git://git.samba.org/ksmbd)
Merging nfs/linux-next (3fa5cbdc44de NFS: Improve readpage/writepage tracin=
g)
Merging nfs-anna/linux-next (4f40a5b55446 NFSv4: Add an fattr allocation to=
 _nfs4_discover_trunking())
Merging nfsd/for-next (9905ce116c9b NFSD: fix use-after-free on source serv=
er when doing inter-server copy)
Merging ntfs3/master (d4073595d0c6 fs/ntfs3: uninitialized variable in ntfs=
_set_acl_ex())
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (4f1196288dfb ovl: fix spelling mistakes)
Merging ubifs/next (8c03a1c21d72 ubi: ubi_create_volume: Fix use-after-free=
 when volume creation failed)
Merging v9fs/9p-next (aa7aeee16948 net/9p: Initialize the iounit field duri=
ng fid creation)
Merging xfs/for-next (d62113303d69 xfs: Fix false ENOSPC when performing di=
rect write on a delalloc extent in cow fork)
Merging zonefs/for-next (6bac30bb8ff8 zonefs: Call page_address() on page a=
cquired with GFP_KERNEL flag)
Merging iomap/iomap-for-next (478af190cb6c iomap: remove iomap_writepage)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (9de1f9c8ca51 Merge tag 'irq-core-2022-08-01'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging vfs/for-next (ed5fce76b5ea vfs: escape hash as well)
Merging printk/for-next (a7e796c88820 Merge branch 'for-5.20' into for-next)
Merging pci/next (c4f36c3ab065 Merge branch 'pci/header-cleanup-immutable')
Merging pstore/for-next/pstore (2c09d1443b9b pstore/zone: cleanup "rcnt" ty=
pe)
Merging hid/for-next (a60885b6a97b Merge branch 'for-5.20/uclogic' into for=
-linus)
Merging i2c/i2c/for-next (0c42dacaa607 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (f2906aa86338 Linux 5.19-rc1)
Merging dmi/dmi-for-next (d2139dfca361 firmware: dmi: Use the proper access=
or for the version field)
Merging hwmon-staging/hwmon-next (525d34124e55 dt-bindings: hwmon: sparx5: =
use correct clock)
Merging jc_docs/docs-next (339170d8d3da docs: efi-stub: Fix paths for x86 /=
 arm stubs)
Merging v4l-dvb/master (485ade76c95a media: hantro: Remove dedicated contro=
l documentation)
Merging v4l-dvb-next/master (485ade76c95a media: hantro: Remove dedicated c=
ontrol documentation)
Merging pm/linux-next (ad393690b235 Merge branch 'acpi-properties' into lin=
ux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (33fe1cb20cf4 cpufreq: tegra194:=
 Staticize struct tegra_cpufreq_soc instances)
Merging cpupower/cpupower (f2906aa86338 Linux 5.19-rc1)
Merging devfreq/devfreq-next (53f853d55e31 PM / devfreq: tegra30: Add error=
 message for devm_devfreq_add_device())
Merging opp/opp/linux-next (1d95af02f230 venus: pm_helpers: Fix warning in =
OPP during probe)
Merging thermal/thermal/linux-next (ca48ad71717d thermal/core: Move the mut=
ex inside the thermal_zone_device_update() function)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (958589892218 fs: dlm: move kref_put assert for lkb struct=
s)
Merging rdma/for-next (6b822d408b58 RDMA/ib_srpt: Unify checking rdma_cm_id=
 condition in srpt_cm_req_recv())
Merging net-next/master (f86d1fbbe785 Merge tag 'net-next-6.0' of git://git=
.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging bpf-next/for-next (f86d1fbbe785 Merge tag 'net-next-6.0' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging ipsec-next/master (5e25c25aa2c0 xfrm: improve wording of comment ab=
ove XFRM_OFFLOAD flags)
Merging mlx5-next/mlx5-next (b0bb369ee451 net/mlx5: fs, allow flow table cr=
eation with a UID)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (84a0a27ea39a Bluetooth: hci_event: Fix vendor (un=
known) opcode status handling)
Merging wireless-next/for-next (35610745d71d Merge ath-next from git://git.=
kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging mtd/mtd/next (7ec4cdb32173 mtd: core: check partition before derefe=
rence)
Merging nand/nand/next (e16eceea863b mtd: rawnand: arasan: Fix clock rate i=
n NV-DDR)
Merging spi-nor/spi-nor/next (f8cd9f632f44 mtd: spi-nor: fix spi_nor_spimem=
_setup_op() call in spi_nor_erase_{sector,chip}())
Merging crypto/master (af5d35b83f64 crypto: tcrypt - Remove the static vari=
able initialisations to NULL)
Merging drm/drm-next (5493ee1919ea Merge tag 'amd-drm-next-5.20-2022-07-29'=
 of https://gitlab.freedesktop.org/agd5f/linux into drm-next)
Merging drm-misc/for-linux-next (2939deac1fa2 drm/gem: Properly annotate WW=
 context on drm_gem_lock_reservations() error)
Merging amdgpu/drm-next (268eba2b0c24 drm/amd/display: include soc._clock_t=
mp[] into DC's scratch region)
Merging drm-intel/for-linux-next (9d50bff40e3e drm/i915: pass a pointer for=
 tlb seqno at vma_invalidate_tlb())
Merging drm-tegra/for-next (135f4c551d51 drm/tegra: vic: Use devm_platform_=
ioremap_resource())
Merging drm-msm/msm-next (cb77085b1f0a drm/msm/dpu: Fix for non-visible pla=
nes)
Merging drm-msm-lumag/msm-next-lumag (1ff1da40d6fc Merge branches 'msm-next=
-lumag-core', 'msm-next-lumag-dpu', 'msm-next-lumag-dp', 'msm-next-lumag-ds=
i', 'msm-next-lumag-hdmi', 'msm-next-lumag-mdp5' and 'msm-next-lumag-mdp4' =
into msm-next-lumag)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (2829a9fcb738 drm/etnaviv: reap idle softpin m=
appings when necessary)
Merging fbdev/for-next (ff6992735ade Linux 5.19-rc7)
Merging regmap/for-next (739f872e48d4 regmap: permit to set reg_update_bits=
 with bulk implementation)
Merging sound/for-next (6b2394bad503 ALSA: usb-audio: make read-only array =
marker static const)
Merging sound-asoc/for-next (dc40b9ea09d2 Merge remote-tracking branch 'aso=
c/for-5.19' into asoc-linus)
Merging modules/modules-next (554694ba120b module: Replace kmap() with kmap=
_local_page())
Merging input/next (51c88597517d Input: mt6779-keypad - support double keys=
 matrix)
Merging block/for-next (ece775e9aa82 Merge branch 'for-5.20/block' into for=
-next)
Merging device-mapper/for-next (b7f362d6413e dm writecache: fix smatch warn=
ing about invalid return from writecache_map)
Merging libata/for-next (b3b2bec9646e ata: sata_mv: Fixes expected number o=
f resources now IRQs are gone)
Merging pcmcia/pcmcia-next (2ef4bb24ff39 pcmcia: Use platform_get_irq() to =
get the interrupt)
Merging mmc/next (527f36f5efa4 mmc: mediatek: add support for SDIO eint wak=
up IRQ)
Merging backlight/for-backlight-next (fe201f6fa4cf MAINTAINERS: Use Lee Jon=
es' kernel.org address for Backlight submissions)
Merging battery/for-next (c9d8468158ad power: supply: olpc_battery: Hold th=
e reference returned by of_find_compatible_node)
Merging regulator/for-next (d511e8a7e850 regulator: core: Fix missing error=
 return from regulator_bulk_get())
Merging security/next (ed56f4b5173e MAINTAINERS: update the LSM maintainer =
info)
Merging apparmor/apparmor-next (79eb2711c919 apparmor: correct config refer=
ence to intended one)
Merging integrity/next-integrity (1d212f9037b0 Merge remote-tracking branch=
 'linux-integrity/kexec-keyrings' into next-integrity)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (64b634830c91 LSM: SafeSetID: add setgroup=
s() testing to selftest)
Merging selinux/next (ef54ccb61616 selinux: selinux_add_opt() callers free =
memory)
Merging smack/next (b50503990d88 smack: Remove the redundant lsm_inode_allo=
c)
Merging tomoyo/master (05fe531eb3f1 kernel/hung_task: show backtrace of tas=
ks with locks held)
Merging tpmdd/next (863ed94c589f tpm: Add check for Failure mode for TPM2 m=
odules)
Merging watchdog/master (2d27e5284109 watchdog: armada_37xx_wdt: check the =
return value of devm_ioremap() in armada_37xx_wdt_probe())
Merging iommu/next (c10100a416c1 Merge branches 'arm/exynos', 'arm/mediatek=
', 'arm/msm', 'arm/smmu', 'virtio', 'x86/vt-d', 'x86/amd' and 'core' into n=
ext)
Merging audit/next (546093206ba1 audit: make is_audit_feature_set() static)
Merging devicetree/for-next (7e7a24c3c6c9 dt-bindings: mtd: microchip,mchp4=
8l640: use spi-peripheral-props.yaml)
Merging dt-krzk/for-next (12f158808510 dt-bindings: arm: aspeed: add Aspeed=
 Evaluation boards)
Merging mailbox/mailbox-for-next (8a8dc2b9596e mailbox: imx: clear pending =
interrupts)
Merging spi/for-next (4188e495dd66 Merge remote-tracking branch 'spi/for-5.=
19' into spi-linus)
Merging tip/master (0dc2dd2cb4ad Merge branch into tip/master: 'WIP/fixes')
Merging clockevents/timers/drivers/next (c19e18637d89 clocksource/drivers/s=
un4i: Remove unnecessary (void*) conversions)
Merging edac/edac-for-next (5e2805d53796 EDAC/ghes: Set the DIMM label unco=
nditionally)
Merging irqchip/irq/irqchip-next (2bd1753e8c43 Merge branch irq/misc-5.20 i=
nto irq/irqchip-next)
Merging ftrace/for-next (07a451dae367 Merge branch 'trace/for-next-core' in=
to trace/for-next)
Merging rcu/rcu/next (21714867a12a Merge branch 'lkmm-dev.2022.06.20a' into=
 HEAD)
Merging kvm/next (6348aafa8d24 KVM: VMX: Adjust number of LBR records for P=
ERF_CAPABILITIES at refresh)
Merging kvm-arm/next (0982c8d859f8 Merge branch kvm-arm64/nvhe-stacktrace i=
nto kvmarm-master/next)
Merging kvms390/next (f5ecfee94493 KVM: s390: resetting the Topology-Change=
-Report)
Merging xen-tip/linux-next (251e90e7e346 xen: don't require virtio with gra=
nts for non-PV guests)
Merging percpu/for-next (a111daf0c53a Linux 5.19-rc3)
Merging workqueues/for-next (46a4d679ef88 workqueue: Avoid a false warning =
in unbind_workers())
Merging drivers-x86/for-next (3d46d7848075 platform/x86/intel/vsec: Fix wro=
ng type for local status variables)
Merging chrome-platform/for-next (afef1e1a0223 platform/chrome: cros_kunit_=
util: add default value for `msg->result`)
Merging hsi/for-next (43c14f8d18a7 HSI: omap_ssi: Fix refcount leak in ssi_=
probe)
Merging leds/for-next (38ba0bb291aa leds: is31fl319x: use simple i2c probe =
function)
Merging ipmi/for-next (4aebcc9059d8 dt-binding: ipmi: add fallback to npcm8=
45 compatible)
Merging driver-core/driver-core-next (d4252071b97d add barriers to buffer_u=
ptodate and set_buffer_uptodate)
Merging usb/usb-next (d4252071b97d add barriers to buffer_uptodate and set_=
buffer_uptodate)
Merging thunderbolt/next (34b9715b7cae thunderbolt: Fix typo in comment)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (688ee1d1785c USB: serial: fix tty-port initial=
ized comments)
Merging tty/tty-next (d4252071b97d add barriers to buffer_uptodate and set_=
buffer_uptodate)
Merging char-misc/char-misc-next (d4252071b97d add barriers to buffer_uptod=
ate and set_buffer_uptodate)
Merging coresight/next (4d45bc82df66 coresight: etm4x: avoid build failure =
with unrolled loops)
Merging fpga/for-next (ee794221a6f6 fpga: fpga-mgr: Fix spelling mistake "b=
itsream" -> "bitstream")
Merging icc/icc-next (009c963eefa0 Merge branch 'icc-rpm' into icc-next)
Merging iio/togreg (180c6cb6b9b7 dt-bindings: iio: adc: Add compatible for =
MT8188)
Merging phy-next/next (08680588d340 dt-bindings: phy: mediatek: tphy: add c=
ompatible for mt8188)
Merging soundwire/next (3f4a70268d54 soundwire: qcom: Enable software clock=
 gating requirement flag)
Merging extcon/extcon-next (3a06ed80265f extcon: Add EXTCON_DISP_CVBS and E=
XTCON_DISP_EDP)
Merging gnss/gnss-next (c0c725d7350e gnss: replace ida_simple API)
Merging vfio/next (0f3e72b5c8cf vfio: Move vfio.c to vfio_main.c)
Merging staging/staging-next (d4252071b97d add barriers to buffer_uptodate =
and set_buffer_uptodate)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (a1873f837f9e dmaengine: mediatek: mtk-hsdma: Fix ty=
po 'the the' in comment)
Merging cgroup/for-next (3109920b3d95 Merge branch 'for-5.20' into for-next)
Merging scsi/for-next (0f8c3a1df936 Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in drivers/ufs/host/ufshcd-pltfrm.c
Merging scsi-mkp/for-next (c6380f992427 scsi: pm8001: Fix typo 'the the' in=
 comment)
Merging vhost/linux-next (d6100747982e virtio-blk: Avoid use-after-free on =
suspend/resume)
Merging rpmsg/for-next (c55988e5e96a Merge branches 'rpmsg-next' and 'hwspi=
nlock-next' into for-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (c4f0d16daa6d dt-bindings: gpio: fsl-imx-gp=
io: Add i.MXRT compatibles)
Merging gpio-intel/for-next (b65bb2c14891 gpio: pch: Change PCI device macr=
os)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (5b045200b53a dt-bindings: pinctrl: qcom,pmic-gpio=
: add PM8226 constraints)
Merging pinctrl-intel/for-next (25097de7b236 pinctrl: intel: Add Intel Mete=
or Lake pin controller support)
Merging pinctrl-renesas/renesas-pinctrl (36611d28f513 pinctrl: renesas: r8a=
779g0: Add missing MODSELx for AVBx)
Merging pinctrl-samsung/for-next (c98ebe065e07 pinctrl: samsung: do not use=
 bindings header with constants)
Merging pwm/for-next (8933d30c5f46 pwm: lpc18xx: Fix period handling)
Merging userns/for-next (a0b88362d2c7 Merge of ucount-rlimits-cleanups-for-=
v5.19, interrupting_kthread_stop-for-v5.20, signal-for-v5.20, and retire_mq=
_sysctls-for-v5.19 for testing in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (b1d34b1375f9 selftests/landlock: fix broken include=
 of linux/landlock.h)
Merging livepatching/for-next (df44b1ee72f4 Merge branch 'for-5.20/selftest=
s-fixes' into for-next)
Merging rtc/rtc-next (03c4cd6f89e0 rtc: spear: set range max)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging nvdimm/libnvdimm-for-next (53fc59511fc4 nvdimm/namespace: drop unne=
eded temporary variable in size_store())
Merging at24/at24/for-next (312310928417 Linux 5.18-rc1)
Merging ntb/ntb-next (b8c0aa9b16bb NTB: EPF: Tidy up some bounds checks)
Merging seccomp/for-next/seccomp (3ce4b78f73e8 selftests/seccomp: Fix compi=
le warning when CC=3Dclang)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (04823dd2af87 fsi: master-ast-cf: Fix missing of_node_put =
in fsi_master_acf_probe)
Merging slimbus/for-next (4ad3deabeea2 slimbus: messaging: fix typos in com=
ments)
Merging nvmem/for-next (432ee5a3cfcf nvmem: mtk-efuse: Simplify with devm_p=
latform_get_and_ioremap_resource())
Merging xarray/main (69cb69ea5542 ida: Remove assertions that an ID was all=
ocated)
Merging hyperv/hyperv-next (d180e0a1be6c Drivers: hv: Create debugfs file w=
ith hyper-v balloon usage information)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (ca7fd6cff3b8 RDMA/erdma: Add driver to kernel build enviro=
nment)
Merging kunit/test (f2906aa86338 Linux 5.19-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging kunit-next/kunit (4c392516accf Documentation: KUnit: Fix example wi=
th compilation error)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (bb3c64f6a017 bus: mhi: host: Fix up null pointer acce=
ss in mhi_irq_handler)
Merging memblock/for-next (04d9490986d1 memblock test: Modify the obsolete =
description in README)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (1cd8a2537eb0 cxl/hdm: Fix skip allocations vs multiple pm=
em allocations)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (df3c9072ef90 Merge branch 'efivars-cleanup' into efi/next)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (3041808b5220 mm/slab_common: move generic bulk alloc=
/free functions to SLOB)
Merging random/master (4e23eeebb2e5 Merge tag 'bitmap-6.0-rc1' of https://g=
ithub.com/norov/linux)
Merging landlock/next (b13baccc3850 Linux 5.19-rc2)
Merging rust/rust-next (07a3263c2554 init/Kconfig: Specify the interpreter =
for rust_is_available.sh)
CONFLICT (content): Merge conflict in Makefile
Merging sysctl/sysctl-next (374a723c7448 kernel/sysctl.c: Remove trailing w=
hite space)
Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in =
mpage_writepages)
Merging execve/for-next/execve (c6e8e36c6ae4 exec: Call kmap_local_page() i=
n copy_string_kernel())
Merging bitmap/bitmap-for-next (36d4b36b6959 lib/nodemask: inline next_node=
_in() and node_random())
Merging hte/hte/for-next (85ff37e302ef gpiolib: cdev: Fix kernel doc for st=
ruct line)
Merging kspp/for-next/kspp (27603a606fda dm: verity-loadpin: Drop use of dm=
_table_get_num_targets())
Merging kspp-gustavo/for-next/kspp (94dfc73e7cf4 treewide: uapi: Replace ze=
ro-length arrays with flexible-array members)
Merging mm-stable/mm-stable (a9e9c93966af Documentation/mm: add details abo=
ut kmap_local_page() and preemption)
Merging mm-nonmm-stable/mm-nonmm-stable (c8a684e2e110 Merge tag 'leds-5.20-=
rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds)
Merging mm/mm-everything (95257c9846ea Merge branch 'mm-nonmm-unstable' int=
o mm-everything)

--Sig_/ChOSne0LCXAymos7sT_g=G2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL0ZjYACgkQAVBC80lX
0GyLBgf+KvW685HZnrjDzn9k72RIVTZmwD9hjmAAnUBU8rnvO06eEktB7pMh7lX1
J8BUAabE39/2tDMXTtFsd/0USB0Wfime2CH0WaJwJoe76bBKFES20bLKoC6W0PVf
MAK5KmS0yXqpdpA0sr/x3/42zsKeIw0YQnOcN5UGbtxJHzsNokVXwIcWQ9RxJWLE
DxSJONa0UDuTZ0yky4lkBZCrvN9iDVA2Dd4Yr5ILFHL30Wiy5KRf29WEBw8qPl0X
7r73OLuvHVhlv+521mbvyb4b/MArdnnfsma0JgwxXlAaM5xv2yVqEiDFYnJApaj8
bPnVB2ZLwdkQbqel52UddXJD+lJ7mQ==
=oG2v
-----END PGP SIGNATURE-----

--Sig_/ChOSne0LCXAymos7sT_g=G2--
