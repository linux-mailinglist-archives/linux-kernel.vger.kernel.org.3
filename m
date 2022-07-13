Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7490557366E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiGMMdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiGMMdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:33:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5C9EABE8;
        Wed, 13 Jul 2022 05:33:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LjcVK48zlz4xhp;
        Wed, 13 Jul 2022 22:33:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657715609;
        bh=wI4WYbkYVC5d5dswiasNjuFogLFv2FT+kcFx9i2PL6M=;
        h=Date:From:To:Cc:Subject:From;
        b=aBlhY0FdWkdvAKQX9moZciBzGfI2wFLuNy7RxhTdSbjNPf8NFmRhW/i5l7LbMCW8V
         Um2akVIhi+s/75Qx9DJr/Jf4Ae/Ac9ccO6UgcUe5D2jqlDospDUsWAON298RBN8lOt
         BNLZdNKTILJms2/kjzdQFlkUjc44fOr9MZGjAtzxLelmc9fDA/MpwgtsnYhQUIrTJ7
         +mFvnuys/q4l/10tbjqv5Bq4PF5MYco408aoVCsUQrVuavP0kNFMDBa1rfWyMQxQJM
         X2Xmr+ZMocKQOFXWSWSpabKTHd9l0w6hj5h8UlN8/gysQOnauIZbrEIfrd40ceVGDN
         e2SVMrMDvSQ3Q==
Date:   Wed, 13 Jul 2022 22:33:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 13
Message-ID: <20220713223328.07016b70@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5T0shYThiF=NCGf3.ypGQaG";
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

--Sig_/5T0shYThiF=NCGf3.ypGQaG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220712:

The drm-intel-fixes tree gained a build failure for which I reverted
a commit.

The v9fs tree gained a build failure so I used the version from
next-20220712.

The vfs tree gained conflicts against the v9fs tree.

The net-next tree gained conflicts against the arm-soc tree.

The apparmor tree lost its build failure.

The tip tree gained a conflict against Linus' tree.

The kvm tree gained a conflict against Linus' tree.

The rust tree gained a conflict against Linus' tree.

Non-merge commits (relative to Linus' tree): 9326
 9918 files changed, 1019168 insertions(+), 253159 deletions(-)

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

I am currently merging 357 trees (counting Linus' and 98 trees of bug
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
Merging origin/master (72a8e05d4f66 Merge tag 'ovl-fixes-5.19-rc7' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging mm-hotfixes/mm-hotfixes-unstable (4f0ecfa7412f hugetlb: fix memoryl=
eak in hugetlb_mcopy_atomic_pte)
Merging kbuild-current/fixes (32346491ddf2 Linux 5.19-rc6)
Merging arc-current/for-curr (952deecb065e arc: dts: Harmonize EHCI/OHCI DT=
 nodes name)
Merging arm-current/fixes (3cfb30199796 ARM: 9197/1: spectre-bhb: fix loop8=
 sequence for Thumb2)
Merging arm64-fixes/for-next/fixes (410982303772 arm64: hugetlb: Restore TL=
B invalidation for BBM on contiguous ptes)
Merging arm-soc-fixes/arm/fixes (01277737e9be Merge tag 'imx-fixes-5.19-3' =
of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fi=
xes)
Merging drivers-memory-fixes/fixes (1332661e0930 memory: samsung: exynos542=
2-dmc: Fix refcount leak in of_get_dram_timings)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (30b5e6ef4a32 m68k: atari: Make Atari ROM po=
rt I/O write macros return void)
Merging powerpc-fixes/fixes (887502826549 powerpc/powernv: delay rng platfo=
rm device creation until later in boot)
Merging s390-fixes/fixes (d7d488f41b41 s390/qdio: Fix spelling mistake)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (f946964a9f79 net: marvell: prestera: fix missed deinit =
sequence)
Merging bpf/master (6676d7270ce2 Merge branch 'selftests-forwarding-install=
-two-missing-tests')
Merging ipsec/master (f85daf0e7253 xfrm: xfrm_policy: fix a possible double=
 xfrm_pols_put() in xfrm_bundle_lookup())
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (50e2ab392919 wifi: mac80211: fix queue selection=
 for mesh/OCB interfaces)
Merging rdma-fixes/for-rc (cc0315564d6e RDMA/irdma: Fix sleep from invalid =
context BUG)
Merging sound-current/for-linus (dbe75d314748 ALSA: hda/realtek - Fix heads=
et mic problem for a HP machine with alc671)
Merging sound-asoc-fixes/for-linus (d67c83a1b232 Merge remote-tracking bran=
ch 'asoc/for-5.18' into asoc-linus)
Merging regmap-fixes/for-linus (3f05010f243b regmap-irq: Fix offset/index m=
ismatch in read_sub_irq_data())
Merging regulator-fixes/for-linus (122e951eb804 regulator: qcom_smd: correc=
t MP5496 ranges)
Merging spi-fixes/for-linus (a77c46f2b4d4 MAINTAINERS: change the NXP FSPI =
driver maintainer.)
Merging pci-current/for-linus (a2b36ffbf5b6 x86/PCI: Revert "x86/PCI: Clip =
only host bridge windows for E820 regions")
Merging driver-core.current/driver-core-linus (f2906aa86338 Linux 5.19-rc1)
Merging tty.current/tty-linus (a501ab75e762 tty: use new tty_insert_flip_st=
ring_and_push_buffer() in pty_write())
Merging usb.current/usb-linus (bb160ee61c04 drivers/usb/host/ehci-fsl: Fix =
interrupt setup in host mode.)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (03c765b0e3b4 Linux 5.19-rc4)
Merging phy/fixes (f2906aa86338 Linux 5.19-rc1)
Merging staging.current/staging-linus (32346491ddf2 Linux 5.19-rc6)
Merging iio-fixes/fixes-togreg (315f7e15c261 Merge tag 'iio-fixes-for-5.19a=
' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-mi=
sc-next)
Merging counter-fixes/fixes-togreg (f2906aa86338 Linux 5.19-rc1)
Merging char-misc.current/char-misc-linus (32346491ddf2 Linux 5.19-rc6)
Merging soundwire-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging thunderbolt-fixes/fixes (03c765b0e3b4 Linux 5.19-rc4)
Merging input-current/for-linus (2a96271fb66c Input: document the units for=
 resolution of size axes)
Merging crypto-current/master (87d044096ea6 crypto: ccp - Fix device IRQ co=
unting by using platform_irq_count())
Merging vfio-fixes/for-linus (afe4e376ac5d vfio: Move IOMMU_CAP_CACHE_COHER=
ENCY test to after we know we have a group)
Merging kselftest-fixes/fixes (9b4d5c01eb23 selftests: make use of GUP_TEST=
_FILE macro)
Merging modules-fixes/modules-linus (e69a66147d49 module: kallsyms: Ensure =
preemption in add_kallsyms() with PREEMPT_RT)
Merging dmaengine-fixes/fixes (607a48c78e6b dt-bindings: dma: allwinner,sun=
50i-a64-dma: Fix min/max typo)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (06781a502635 mtd: rawnand: gpmi: Fix setting b=
usy timeout setting)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (3bcc2c1eade4 media: rkvdec: Disable H.264 erro=
r detection)
Merging reset-fixes/reset/fixes (a57f68ddc886 reset: Fix devm bulk optional=
 exclusive control getter)
Merging mips-fixes/mips-fixes (88084a3df167 Linux 5.19-rc5)
Merging at91-fixes/at91-fixes (2fdf15b50a46 ARM: dts: at91: sama5d2: Fix ty=
po in i2s1 node)
Merging omap-fixes/fixes (2eb502f496f7 ARM: dts: am33xx: Fix MMCHS0 dma pro=
perties)
Merging kvm-fixes/master (6defa24d3b12 KVM: SEV: Init target VMCBs in sev_m=
igrate_from)
Merging kvms390-fixes/master (242c04f01377 KVM: s390: selftests: Use TAP in=
terface in the reset test)
Merging hwmon-fixes/hwmon (d0e51022a025 hwmon: (ibmaem) don't call platform=
_device_del() if platform_device_add() fails)
Merging nvdimm-fixes/libnvdimm-fixes (ef9102004a87 nvdimm: Fix badblocks cl=
ear off-by-one error)
Merging cxl-fixes/fixes (e35f5718903b cxl/mbox: Fix missing variable payloa=
d checks in cmd size validation)
Merging btrfs-fixes/next-fixes (7531ec5954ab Merge branch 'misc-5.19' into =
next-fixes)
Merging vfs-fixes/fixes (c3497fd009ef fix short copy handling in copy_mc_pi=
pe_to_iter())
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (b0d55983b2b8 platform/x86: intel_atomisp2_=
led: Also turn off the always-on camera LED on the Asus T100TAF)
Merging samsung-krzk-fixes/fixes (c4c79525042a ARM: exynos: Fix refcount le=
ak in exynos_map_pmu)
Merging pinctrl-samsung-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging devicetree-fixes/dt/linus (0b9431c8221c dt-bindings: display: arm,m=
alidp: remove bogus RQOS property)
Merging dt-krzk-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging scsi-fixes/fixes (ccd3f4490524 scsi: target: Fix WRITE_SAME No Data=
 Buffer crash)
Merging drm-fixes/drm-fixes (3590b44b9434 Merge tag 'drm-misc-fixes-2022-07=
-07-1' of ssh://git.freedesktop.org/git/drm/drm-misc into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (333991c4e66b drm/i915/selftes=
ts: fix subtraction overflow bug)
Merging mmc-fixes/fixes (32346491ddf2 Linux 5.19-rc6)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (a111daf0c53a Linux 5.19-rc3)
Merging hyperv-fixes/hyperv-fixes (49d6a3c062a1 x86/Hyper-V: Add SEV negoti=
ate protocol support in Isolation VM)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (dc5cb7a833e8 riscv: don't warn for sifive errat=
as in modules)
Merging risc-v-mc-fixes/dt-fixes (efa310ba0071 riscv: dts: microchip: hook =
up the mpfs' l2cache)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging spdx/spdx-linus (58301e1c15db Documentation: samsung-s3c24xx: Add b=
lank line after SPDX directive)
Merging gpio-brgl-fixes/gpio/for-current (7329b0717296 gpio: sim: fix the c=
hip_name configfs item)
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
Merging irqchip-fixes/irq/irqchip-fixes (1357d2a65601 irqchip/apple-aic: Ma=
ke symbol 'use_fast_ipi' static)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging broadcom-fixes/fixes (a26f045984e7 Merge branch 'devicetree/fixes' =
into fixes)
Merging perf-current/perf/urgent (ff898552fb32 perf synthetic-events: Ignor=
e dead threads during event synthesis)
Merging efi-fixes/urgent (aa6d1ed107eb efi/x86: libstub: Fix typo in __efi6=
4_argmap* name)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging battery-fixes/fixes (093d27bb6f2d power: supply: core: Fix boundary=
 conditions in interpolation)
Merging drm-misc-fixes/for-linux-next-fixes (925b6e59138c Revert "drm/amdgp=
u: add drm buddy support to amdgpu")
Applying: Revert "Revert "drm/amdgpu: add drm buddy support to amdgpu""
Merging kbuild/for-next (28aa004b6261 init/Kconfig: update KALLSYMS_ALL hel=
p text)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (0d2997f750d1 perf lock: Look up callchain for the c=
ontended locks)
CONFLICT (content): Merge conflict in tools/perf/util/evsel.c
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (26ffb91fa5e0 swiotlb: split up the global swi=
otlb lock)
Merging asm-generic/master (4313a24985f0 arch/*/: remove CONFIG_VIRT_TO_BUS)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (bafa10435c4f ARM: 9209/1: Spectre-BHB: avoid pr_info(=
) every time a CPU comes out of idle)
Merging arm64/for-next/core (eff044f1b04e Merge branch 'for-next/boot' into=
 for-next/core)
Merging arm-perf/for-next/perf (aaaee7b55c9e docs: perf: Include hns3-pmu.r=
st in toctree to fix 'htmldocs' WARNING)
Merging arm-soc/for-next (297b554633ad soc: document merges)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (147c83586707 Merge branch 'v5.20/drivers' into fo=
r-next)
Merging aspeed/for-next (bfcbea2c93e5 ARM: dts: aspeed: nuvia: rename vendo=
r nuvia to qcom)
Merging at91/at91-next (4dd1a613e464 ARM: dts: lan966x: Add UDPHS support)
Merging broadcom/next (8cd8892b7757 Merge branch 'drivers/next' into next)
CONFLICT (modify/delete): arch/arm/mach-bcm/bcm63xx.c deleted in broadcom/n=
ext and modified in HEAD.  Version HEAD of arch/arm/mach-bcm/bcm63xx.c left=
 in tree.
$ git rm -f arch/arm/mach-bcm/bcm63xx.c
Merging drivers-memory/for-next (0d97f2176dec memory: mtk-smi: Add support =
for MT6795 Helio X10)
Merging imx-mxs/for-next (37960df982d0 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (5281655db0e1 Merge branch 'v5.19-next/soc' into =
for-next)
Merging mvebu/for-next (58ec0844bd13 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (ad2fe4582c48 Merge branches 'omap-for-v5.20/omap1', =
'omap-for-v5.20/ti-sysc' and 'omap-for-v5.20/soc' into for-next)
Merging qcom/for-next (ca48adcc40b0 Merge branches 'arm64-for-5.20', 'arm64=
-defconfig-for-5.20', 'clk-for-5.20', 'dts-for-5.20', 'dts-fixes-for-5.19' =
and 'drivers-for-5.20' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (b5468cb7909f Merge branches 'renesas-arm-dt-for-v5.20=
' and 'renesas-dt-bindings-for-v5.20' into renesas-next)
Merging reset/reset/next (18d1909be345 reset: allow building of reset simpl=
e driver if expert config selected)
Merging rockchip/for-next (2e1170c71ec0 Merge branch 'v5.20-armsoc/dts64' i=
nto for-next)
Merging samsung-krzk/for-next (5642cb8ce0f1 Merge branch 'next/dt' into for=
-next)
Merging scmi/for-linux-next (32346491ddf2 Linux 5.19-rc6)
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
Merging xilinx/for-next (516de80d448f Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (16615b92d4dc Merge branch 'clk-renesas' into clk-next)
Merging clk-imx/for-next (c196175acdd3 clk: imx: clk-fracn-gppll: Add more =
freq config for video pll)
Merging clk-renesas/renesas-clk (0e704f6c42dc clk: renesas: rcar-gen4: Fix =
initconst confusion for cpg_pll_config)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (f5ac0fb05b23 csky: Move HEAD_TEXT_SECTION out of _=
_init_begin-end)
Merging loongarch/loongarch-next (a111daf0c53a Linux 5.19-rc3)
Merging m68k/for-next (b508128bb0d1 m68k: defconfig: Update defconfigs for =
v5.19-rc1)
Merging m68knommu/for-next (7ede4785ea97 m68k: Fix syntax errors in comment=
s)
Merging microblaze/next (78b5f52ab6f6 microblaze: fix typos in comments)
Merging mips/mips-next (9044576357b1 MIPS: Make phys_to_virt utilize __va())
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (48bddb89d59e openrisc: unwinder: Fix grammar iss=
ue in comment)
Merging parisc-hd/for-next (03c765b0e3b4 Linux 5.19-rc4)
Merging powerpc/next (ac2a2303016b Merge branch 'topic/ppc-kvm' into next)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (54f0f3b298e2 riscv: Kconfig: Style cleanups)
Merging risc-v-mc/dt-for-next (88d319c6abae riscv: dts: microchip: Add mpfs=
' topology information)
Merging s390/for-next (8c04229c2a88 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (2a4a62a14be1 um: Fix out-of-bounds read in LDT setu=
p)
Merging xtensa/xtensa-for-next (d5ecf8564c32 xtensa: iss: fix handling erro=
r cases in iss_net_configure())
Merging pidfd/for-next (77940f0d96cd mnt_idmapping: align kernel doc and pa=
rameter order)
Merging fscrypt/master (218d921b581e fscrypt: add new helper functions for =
test_dummy_encryption)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (3f0dabb4090c Merge branch 'for-next-next-v5.19-2022=
0712' into for-next-20220712)
Merging ceph/master (db326c9e90e3 fscrypt: add fscrypt_context_for_new_inod=
e)
Merging cifs/for-next (a618dae7f676 smb3: workaround negprot bug in some Sa=
mba servers)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (448b5a1548d8 erofs: avoid consecutive detection for High=
mem memory)
Merging exfat/dev (204e6ceaa103 exfat: use updated exfat_chain directly dur=
ing renaming)
Merging ext3/for_next (e252f2ed1c8c fanotify: introduce FAN_MARK_IGNORE)
Merging ext4/dev (f8dc286e4d94 jbd2: fix outstanding credits assert in jbd2=
_journal_commit_transaction())
Merging f2fs/dev (785c1904b28d f2fs: add a sysfs entry to show zone capacit=
y)
Merging fsverity/fsverity (e6af1bb07704 fs-verity: Use struct_size() helper=
 in enable_verity())
Merging fuse/for-next (6b49bc9d8a5f fuse: avoid unnecessary spinlock bump)
Merging gfs2/for-next (44dab005fd42 gfs2: Minor gfs2_glock_nq_m cleanup)
Merging jfs/jfs-next (e471e5942c00 fs/jfs: Remove dead code)
Merging ksmbd/ksmbd-for-next (732f30694325 Merge tag '5.19-rc4-ksmbd-server=
-fixes' of git://git.samba.org/ksmbd)
Merging nfs/linux-next (32346491ddf2 Linux 5.19-rc6)
Merging nfs-anna/linux-next (4f40a5b55446 NFSv4: Add an fattr allocation to=
 _nfs4_discover_trunking())
Merging nfsd/for-next (73e20cc87f0b NFSD: Ensure nf_inode is never derefere=
nced)
Merging ntfs3/master (604a9d272dc3 fs/ntfs3: Remove unnecessary 'NULL' valu=
es from pointers)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (4a47c6385bb4 ovl: turn of SB_POSIXACL wit=
h idmapped layers temporarily)
Merging ubifs/next (8c03a1c21d72 ubi: ubi_create_volume: Fix use-after-free=
 when volume creation failed)
Merging v9fs/9p-next (c249fb4f9193 9p: roll p9_tag_remove into p9_req_put)
$ git reset --hard HEAD^
Merging next-20220712 version of v9fs
Merging xfs/for-next (0f38063d7a38 xfs: removed useless condition in functi=
on xfs_attr_node_get)
Merging zonefs/for-next (6bac30bb8ff8 zonefs: Call page_address() on page a=
cquired with GFP_KERNEL flag)
Merging iomap/iomap-for-next (f8189d5d5fbf dax: set did_zero to true when z=
eroing successfully)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (51d1c3ac528b Merge branches 'work.misc', 'work.lseek'=
, 'work.iov_iter' and 'work.namei' into for-next)
CONFLICT (content): Merge conflict in fs/btrfs/file.c
Merging printk/for-next (7f6fa2d4a510 Merge branch 'for-5.20' into for-next)
Merging pci/next (62171cf15eb8 Merge branch 'pci/ctrl/vmd')
Merging pstore/for-next/pstore (2c09d1443b9b pstore/zone: cleanup "rcnt" ty=
pe)
Merging hid/for-next (6c55e6cce170 Merge branch 'for-5.20/nintendo' into fo=
r-next)
Merging i2c/i2c/for-next (b91756cecc54 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (f2906aa86338 Linux 5.19-rc1)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (9f6ca00b5be4 hwmon: (asus_wmi_sensors) Sa=
ve a few bytes of memory)
Merging jc_docs/docs-next (75c654242f29 MAINTAINERS: update nvidia,tegra20-=
host1x.yaml reference)
Merging v4l-dvb/master (d8e8aa866ed8 media: mediatek: vcodec: Report suppor=
ted bitrate modes)
Merging v4l-dvb-next/master (e670f5d672ef media: amphion: only insert the f=
irst sequence startcode for vc1l format)
Merging pm/linux-next (e71c5921cc50 Merge branch 'thermal-core' into linux-=
next)
Merging cpufreq-arm/cpufreq/arm/linux-next (aca50780feb9 dt-bindings: opp: =
Add msm8939 to the compatible list)
Merging cpupower/cpupower (f2906aa86338 Linux 5.19-rc1)
Merging devfreq/devfreq-next (98ebac384ad2 PM / devfreq: tegra30: Add error=
 message for devm_devfreq_add_device())
Merging opp/opp/linux-next (1e5fb38442eb OPP: Remove dev{m}_pm_opp_of_add_t=
able_noclk())
Merging thermal/thermal/linux-next (4768f717d85c dt-bindings: thermal: rcar=
-gen3-thermal: Add r8a779f0 support)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (0f24debbb847 fs: dlm: move kref_put assert for lkb struct=
s)
Merging rdma/for-next (2635d2a8d466 IB: Fix spelling of 'writable')
Merging net-next/master (c9ef2a486aa9 Merge branch 'mptcp-support-changes-t=
o-initial-subflow-priority')
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/marvell/armada-70=
40-mochabin.dts
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/marvell/armada-80=
40-mcbin.dtsi
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/marvell/armada-80=
40-puzzle-m801.dts
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/rockchip/rk3568-b=
pi-r2-pro.dts
CONFLICT (content): Merge conflict in include/net/sock.h
Merging bpf-next/for-next (ace2bee839e0 bpf: Make non-preallocated allocati=
on low priority)
Merging ipsec-next/master (5e25c25aa2c0 xfrm: improve wording of comment ab=
ove XFRM_OFFLOAD flags)
Merging mlx5-next/mlx5-next (cdcdce948d64 net/mlx5: Add bits and fields to =
support enhanced CQE compression)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (0cc323d985f9 Bluetooth: hci_sync: Fix resuming sc=
an after suspend resume)
Merging wireless-next/for-next (58b6259d820d wifi: mac80211_hwsim: add back=
 erroneously removed cast)
Merging mtd/mtd/next (ad9b10d1eaad mtd: core: introduce of support for dyna=
mic partitions)
Merging nand/nand/next (e16eceea863b mtd: rawnand: arasan: Fix clock rate i=
n NV-DDR)
Merging spi-nor/spi-nor/next (77d4ac6d3848 mtd: spi-nor: move SECT_4K_PMC s=
pecial handling)
Merging crypto/master (79e6e2f3f3ff crypto: testmgr - populate RSA CRT para=
meters in RSA test vectors)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging drm/drm-next (d9e019bb396f Merge tag 'drm-msm-next-2022-07-10' of h=
ttps://gitlab.freedesktop.org/drm/msm into drm-next)
Merging drm-misc/for-linux-next (bbd60fee2d21 dma-buf: revert "return only =
unsignaled fences in dma_fence_unwrap_for_each v3")
Merging amdgpu/drm-next (0365a66ae443 drm/amd/display: Ensure valid event t=
imestamp for cursor-only commits)
Merging drm-intel/for-linux-next (81cb44274c65 drm/i915: Add Wa_14016291713)
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
Merging fbdev/for-next (7ae7b9c5e47d video: fbdev: atari: Remove unused def=
initions and variables)
Merging regmap/for-next (cf39ed2e8ecd regmap: add WARN_ONCE when invalid ma=
sk is provided to regmap_field_init())
Merging sound/for-next (e35cd6881dd5 ALSA: hda: cs35l41: Improve dev_err_pr=
obe() messaging)
Merging sound-asoc/for-next (f1416233aa12 Merge remote-tracking branch 'aso=
c/for-5.20' into asoc-next)
Merging modules/modules-next (73b4fc92f97d module: Move module's Kconfig it=
ems in kernel/module/)
Merging input/next (39636805cab2 dt-bindings: input: iqs7222: Use central '=
linux,code' definition)
Merging block/for-next (5ad3a1d30b36 Merge branch 'for-5.20/block' into for=
-next)
CONFLICT (content): Merge conflict in drivers/block/mtip32xx/mtip32xx.c
CONFLICT (modify/delete): fs/io_uring.c deleted in block/for-next and modif=
ied in HEAD.  Version HEAD of fs/io_uring.c left in tree.
$ git rm -f fs/io_uring.c
Applying: fixup for "keep iocb_flags() result cached in struct file"
Merging device-mapper/for-next (11093e6f0de9 Documentation: dm writecache: =
Render status list as list)
Merging libata/for-next (0184898dd14d ata: libata-scsi: fix result type of =
ata_ioc32())
Merging pcmcia/pcmcia-next (2ef4bb24ff39 pcmcia: Use platform_get_irq() to =
get the interrupt)
Merging mmc/next (4ec43b8797b8 dt-bindings: mmc: Add compatible for MediaTe=
k MT8188)
Merging mfd/for-mfd-next (30f8f57ce7ae mfd: intel_soc_pmic_bxtwc: Fix spell=
ing in the comment)
Merging backlight/for-backlight-next (023a8830a628 backlight: backlight: Sl=
ighly simplify devm_of_find_backlight())
Merging battery/for-next (a578cc3af5ce power: reset: pwr-mlxbf: change rst_=
pwr_hid and low_pwr_hid from global to local variables)
Merging regulator/for-next (0682a7716443 regulator: output-supply DT suppor=
t)
Merging security/next (ed56f4b5173e MAINTAINERS: update the LSM maintainer =
info)
Merging apparmor/apparmor-next (e2f76ad7d285 apparmor: test: Remove some ca=
sts which are no-longer required)
Merging integrity/next-integrity (607e6609ce9a evm: Use IS_ENABLED to initi=
alize .enabled)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (ef54ccb61616 selinux: selinux_add_opt() callers free =
memory)
Merging smack/next (b50503990d88 smack: Remove the redundant lsm_inode_allo=
c)
Merging tomoyo/master (b13baccc3850 Linux 5.19-rc2)
Merging tpmdd/next (1679eb4a6194 tpm: eventlog: Fix section mismatch for DE=
BUG_SECTION_MISMATCH)
Merging watchdog/master (a111daf0c53a Linux 5.19-rc3)
Merging iommu/next (70f57b51402c Merge branches 'iommu/fixes', 'arm/exynos'=
, 'arm/mediatek', 'x86/amd' and 'core' into next)
Merging audit/next (546093206ba1 audit: make is_audit_feature_set() static)
Merging devicetree/for-next (d17e37c41b7e of: device: Fix missing of_node_p=
ut() in of_dma_set_restricted_buffer)
Merging dt-krzk/for-next (ad0d6ea39195 Merge branch 'for-v5.20/dt-bindings-=
qcom' into next/dt-bindings)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/arm=
/qcom.yaml
Merging mailbox/mailbox-for-next (79f9fbe30352 mailbox: qcom-ipcc: Fix -Wun=
used-function with CONFIG_PM_SLEEP=3Dn)
Merging spi/for-next (a0197626fdd6 Merge remote-tracking branch 'spi/for-5.=
20' into spi-next)
Merging tip/master (3c1ec304a1bc Merge branch into tip/master: 'x86/vmware')
CONFLICT (content): Merge conflict in drivers/idle/intel_idle.c
Merging clockevents/timers/drivers/next (ff714ee7191b clocksource/drivers/t=
imer-ti-dm: Add compatible for am6 SoCs)
Merging edac/edac-for-next (92705c9f9956 Merge edac-misc into for-next)
Merging irqchip/irq/irqchip-next (5d796a6dbe0a Merge branch irq/misc-5.20 i=
nto irq/irqchip-next)
Merging ftrace/for-next (01dca6d03bb3 Merge branch 'trace/for-next-rtla' in=
to trace/for-next)
Merging rcu/rcu/next (88cea4e18ed4 rcu: Make tiny RCU support leak callback=
s for debug-object errors)
CONFLICT (content): Merge conflict in arch/loongarch/Kconfig
Merging kvm/next (4b88b1a518b3 KVM: selftests: Enhance handling WRMSR ICR r=
egister in x2APIC mode)
CONFLICT (content): Merge conflict in arch/x86/kvm/vmx/capabilities.h
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/lib/aarch=
64/ucall.c
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/s390x/mem=
op.c
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/s390x/res=
ets.c
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/s390x/syn=
c_regs_test.c
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/s390x/tpr=
ot.c
Merging kvm-arm/next (df6b5b914e0c Merge branch kvm-arm64/misc-5.20 into kv=
marm-master/next)
Merging kvms390/next (01e39fc2572a Documentation: kvm: extend KVM_S390_ZPCI=
_OP subheading underline)
Merging xen-tip/linux-next (14b963526313 xen: Fix spelling mistake)
Merging percpu/for-next (a111daf0c53a Linux 5.19-rc3)
Merging workqueues/for-next (8bee9dd953b6 workqueue: Switch to new kerneldo=
c syntax for named variable macro argument)
Merging drivers-x86/for-next (fe16ecaa0e62 platform/x86: intel_atomisp2_led=
: Also turn off the always-on camera LED on the Asus T100TAF)
Merging chrome-platform/for-next (3de7203115af platform/chrome: wilco_ec: e=
vent: Fix typo in comment)
Merging hsi/for-next (43c14f8d18a7 HSI: omap_ssi: Fix refcount leak in ssi_=
probe)
Merging leds/for-next (f2906aa86338 Linux 5.19-rc1)
Merging ipmi/for-next (a508e33956b5 ipmi:ipmb: Fix refcount leak in ipmi_ip=
mb_probe)
Merging driver-core/driver-core-next (6c3c267e5fbc Documentation/process: A=
dd embargoed HW contact for LLVM)
Merging usb/usb-next (8affe37c525d usb: dwc3: gadget: fix high speed multip=
lier setting)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging thunderbolt/next (34b9715b7cae thunderbolt: Fix typo in comment)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (7828466cff6b USB: serial: use kmemdup instead =
of kmalloc + memcpy)
Merging tty/tty-next (7e5b4322cde0 tty: n_gsm: fix missing corner cases in =
gsmld_poll())
Merging char-misc/char-misc-next (bc2c6a5ee71b Merge tag 'misc-habanalabs-n=
ext-2022-07-12' of https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/=
linux into char-misc-next)
Merging coresight/next (4d45bc82df66 coresight: etm4x: avoid build failure =
with unrolled loops)
Merging fpga/for-next (ee794221a6f6 fpga: fpga-mgr: Fix spelling mistake "b=
itsream" -> "bitstream")
Merging icc/icc-next (a6339ac8a104 Merge branch 'icc-rpm' into icc-next)
Merging iio/togreg (883f50ead31c iio: adc: stm32-adc: disable adc before ca=
libration)
Merging phy-next/next (08fd292fdffc phy: phy-mtk-dp: change mtk_dp_phy_driv=
er to static)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/dp/dp_parser.h
Merging soundwire/next (3f4a70268d54 soundwire: qcom: Enable software clock=
 gating requirement flag)
CONFLICT (content): Merge conflict in drivers/soundwire/intel.c
Merging extcon/extcon-next (65c1165a7cf0 extcon: Add EXTCON_DISP_CVBS and E=
XTCON_DISP_EDP)
Merging gnss/gnss-next (c0c725d7350e gnss: replace ida_simple API)
Merging vfio/next (2a8ed7ef00b9 Merge branches 'v5.20/vfio/spapr_tce-unused=
-arg-v1', 'v5.20/vfio/comment-typo-v1' and 'v5.20/vfio/vfio-ccw-rework-v4' =
into v5.20/vfio/next)
CONFLICT (content): Merge conflict in drivers/vfio/vfio.c
CONFLICT (content): Merge conflict in include/linux/vfio_pci_core.h
Merging staging/staging-next (042f1a6f434a staging: r8188eu: remove HW_VAR_=
MLME_SITESURVEY from SetHwReg8188EU())
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (4348d99efa01 dmaengine: altera-msgdma: Fixed some i=
nconsistent function name descriptions)
Merging cgroup/for-next (27924b13fcce Merge branch 'for-5.20' into for-next)
Merging scsi/for-next (bf5fe4cadee8 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (9821106213c8 scsi: zfcp: Drop redundant "the" in=
 the comments)
Merging vhost/linux-next (6a9720576cd0 virtio: VIRTIO_HARDEN_NOTIFICATION i=
s broken)
Merging rpmsg/for-next (c6a669485125 Merge branches 'rpmsg-next', 'rproc-ne=
xt' and 'hwspinlock-next' into for-next)
Merging gpio/for-next (e73f0f0ee754 Linux 5.14-rc1)
Merging gpio-brgl/gpio/for-next (d78f210e7676 gpio: GPIO_SAMA5D2_PIOBU shou=
ld depend on ARCH_AT91)
Merging gpio-intel/for-next (b65bb2c14891 gpio: pch: Change PCI device macr=
os)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (2ec1aa95dafb Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (25097de7b236 pinctrl: intel: Add Intel Mete=
or Lake pin controller support)
Merging pinctrl-renesas/renesas-pinctrl (36611d28f513 pinctrl: renesas: r8a=
779g0: Add missing MODSELx for AVBx)
Merging pinctrl-samsung/for-next (c98ebe065e07 pinctrl: samsung: do not use=
 bindings header with constants)
Merging pwm/for-next (394b517585da pwm: mediatek: Add MT8365 support)
Merging userns/for-next (9aafa63eb9f5 Merge of free-mq_sysctls-for-v5.19, p=
trace_unfreeze_fix-for-v5.19, and ucount-rlimits-cleanups-for-v5.19 for tes=
ting in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (67bd292cd281 Makefile: add headers_install to kself=
test targets)
Merging livepatching/for-next (df44b1ee72f4 Merge branch 'for-5.20/selftest=
s-fixes' into for-next)
Merging rtc/rtc-next (592ff0c8d064 rtc: Directly use ida_alloc()/free())
CONFLICT (content): Merge conflict in MAINTAINERS
Merging nvdimm/libnvdimm-for-next (f42e8e5088b9 pmem: implement pmem_recove=
ry_write())
Merging at24/at24/for-next (312310928417 Linux 5.18-rc1)
Merging ntb/ntb-next (ca151bc47cf2 ntb: idt: fix clang -Wformat warnings)
Merging seccomp/for-next/seccomp (73a8dbafd31a selftests/seccomp: Fix compi=
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
Merging hyperv/hyperv-next (bf28462e20b5 drm/hyperv : Removing the restruct=
ion of VRAM allocation with PCI bar size)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (efa0855c5b84 RDMA/erdma: Add driver to kernel build enviro=
nment)
Merging kunit/test (f2906aa86338 Linux 5.19-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging kunit-next/kunit (291cd54e5b05 mmc: sdhci-of-aspeed: test: Use kuni=
t_test_suite() macro)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (9df125af0822 bus: mhi: ep: Check dev_set_name() retur=
n value)
Merging memblock/for-next (fe833b4edc59 memblock tests: remove completed TO=
DO items)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (a111daf0c53a Linux 5.19-rc3)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (df3c9072ef90 Merge branch 'efivars-cleanup' into efi/next)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (b77d5b1b83e3 mm: slab: optimize memcg_slab_free_hook=
())
Merging random/master (5219560da3ec x86/rdrand: Remove "nordrand" flag in f=
avor of "random.trust_cpu")
CONFLICT (content): Merge conflict in arch/powerpc/Kconfig
Merging landlock/next (b13baccc3850 Linux 5.19-rc2)
Merging rust/rust-next (9a5fe747d99e init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
CONFLICT (content): Merge conflict in Makefile
CONFLICT (content): Merge conflict in arch/x86/Makefile
CONFLICT (content): Merge conflict in include/uapi/linux/android/binder.h
Merging sysctl/sysctl-next (acdc07ace871 kernel/sysctl.c: Clean up indentat=
ion, replace spaces with tab.)
Merging folio/for-next (03b33c09ea22 fs: remove the NULL get_block case in =
mpage_writepages)
Merging execve/for-next/execve (5036793d7dbd exec: Fix a spelling mistake)
Merging bitmap/bitmap-for-next (30fd8cdf53a0 lib/test_bitmap: test the tail=
 after bitmap_to_arr64())
Merging hte/hte/for-next (85ff37e302ef gpiolib: cdev: Fix kernel doc for st=
ruct line)
Merging kspp/for-next/kspp (e1d337335207 cfi: Fix __cfi_slowpath_diag RCU u=
sage with cpuidle)
CONFLICT (content): Merge conflict in kernel/cfi.c
Merging kspp-gustavo/for-next/kspp (94dfc73e7cf4 treewide: uapi: Replace ze=
ro-length arrays with flexible-array members)
Merging mm-stable/mm-stable (4f2930c6718a selftests/vm: only run 128TBswitc=
h with 5-level paging)
CONFLICT (content): Merge conflict in Documentation/translations/zh_CN/mm/f=
ree_page_reporting.rst
CONFLICT (content): Merge conflict in Documentation/translations/zh_CN/mm/f=
rontswap.rst
CONFLICT (content): Merge conflict in Documentation/translations/zh_CN/mm/p=
age_frags.rst
CONFLICT (file location): Documentation/translations/zh_CN/vm/page_migratio=
n.rst added in HEAD inside a directory that was renamed in mm-stable/mm-sta=
ble, suggesting it should perhaps be moved to Documentation/translations/zh=
_CN/mm/page_migration.rst.
CONFLICT (file location): Documentation/translations/zh_CN/vm/vmalloced-ker=
nel-stacks.rst added in HEAD inside a directory that was renamed in mm-stab=
le/mm-stable, suggesting it should perhaps be moved to Documentation/transl=
ations/zh_CN/mm/vmalloced-kernel-stacks.rst.
CONFLICT (content): Merge conflict in Documentation/translations/zh_CN/mm/z=
smalloc.rst
CONFLICT (content): Merge conflict in include/linux/pagevec.h
Merging mm-nonmm-stable/mm-nonmm-stable (ee56c3e8eec1 Merge branch 'master'=
 into mm-nonmm-stable)
Merging mm/mm-everything (7fb2af125acd Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in include/kunit/test.h
Applying: fix up for "xfs: pass perag to xfs_alloc_read_agf()"
Applying: Revert "drm/i915/ttm: fix sg_table construction"

--Sig_/5T0shYThiF=NCGf3.ypGQaG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLOu5gACgkQAVBC80lX
0GxvBAf/YYBKOMIV1UvHjmeFV84L7Y38ryaCuRQo6niGqjo1OA798FVY+bekOqWJ
w+tkqCnSPU8OfkB5cEcztlXd4R/ieXWKsQt0Sqt8id0Cw3SpPNOADpFUqS1zmRZ0
uKKVAHop5HUZ7Gzcr6RCds7IEpzoIhAziIpxtWNmyoDaNQ2MoiVV4hGWEDFFQ/U+
P8FQXD/PP8XPFJrVe2l+TWRTBcq1Kx1B2oWNz5+0Rtyb0sfOyv92S385LtZpTK6E
TzB6Ciwb8R1pTh2jzHYVK7ByROMUVkB2Zuf/MthvHBqhcAUH9dJlFlZ1hVjMtYMS
vM154/awjWrpecomDC0luNZMaMpWxQ==
=otAC
-----END PGP SIGNATURE-----

--Sig_/5T0shYThiF=NCGf3.ypGQaG--
