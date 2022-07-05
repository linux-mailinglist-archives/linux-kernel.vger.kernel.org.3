Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEF456644B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiGEHiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGEHh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:37:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A05B13D05;
        Tue,  5 Jul 2022 00:37:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LcZJy3N6Cz4xhp;
        Tue,  5 Jul 2022 17:37:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657006674;
        bh=I9DKFrb3BPb5nz0v31Ns56m52TDsbMoTcOA9rrTy7So=;
        h=Date:From:To:Cc:Subject:From;
        b=jwV4VQjZkeHTz7he65tlJaNsiThgcCIyRBX8KSSz3hY4aI5NzYbc6GsdobJJN+Pve
         aEN7nv4MUdHrJceRX6c+eg8uhp4o3BivcKhOy7Eln3RG8Jl5r40/eealYajX6DzAGW
         vd0VFjywhMj7UweQ5vFEcy2zjpX7rDjT7kmUMKncibsqROuwK22x96jOdYR8rf/kST
         KUMc4YuZ+6kQ0o76DwzSNgIpYbPSkZfeeWrGeuDYNN8i+mv6rbnwmnM9X94mzT2QsG
         B0WOncHRuvAgEUrWYVQp0wl/YBe6onhLzvy3FRcYDDmLuhkXsNYFO2TeSGs0q1rHR7
         jFkKc79JUeA2A==
Date:   Tue, 5 Jul 2022 17:37:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 5
Message-ID: <20220705173752.21b174ac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Hp1+9GkTrzqlMOfN1gENCxj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Hp1+9GkTrzqlMOfN1gENCxj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220704:

The mfd tree gained a build failure so I used the version from
next-20220704.

Non-merge commits (relative to Linus' tree): 7112
 7903 files changed, 691131 insertions(+), 125907 deletions(-)

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
Merging origin/master (c1084b6c5620 Merge tag 'soc-fixes-5.19-2' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/soc/soc)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging mm-hotfixes/mm-hotfixes-unstable (d8f4ccde01e7 mailmap: update Seth=
 Forshee's email address)
Merging kbuild-current/fixes (a4ab14e1d8fe gen_compile_commands: handle mul=
tiple lines per .mod file)
Merging arc-current/for-curr (952deecb065e arc: dts: Harmonize EHCI/OHCI DT=
 nodes name)
Merging arm-current/fixes (3cfb30199796 ARM: 9197/1: spectre-bhb: fix loop8=
 sequence for Thumb2)
Merging arm64-fixes/for-next/fixes (410982303772 arm64: hugetlb: Restore TL=
B invalidation for BBM on contiguous ptes)
Merging arm-soc-fixes/arm/fixes (c0d1a7bd6574 Merge tag 'stm32-dt-for-v5.19=
-fixes-2' of git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32 in=
to arm/fixes)
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
Merging net/master (1b18f09d31cf ibmvnic: Properly dispose of all skbs duri=
ng a failover.)
Merging bpf/master (ea1c3b77bc0b Merge branch 'netdev-docs')
Merging ipsec/master (f85daf0e7253 xfrm: xfrm_policy: fix a possible double=
 xfrm_pols_put() in xfrm_bundle_lookup())
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging wireless/for-next (8d70f33ed720 wifi: cfg80211: Allow P2P client in=
terface to indicate port authorization)
Merging rdma-fixes/for-rc (88084a3df167 Linux 5.19-rc5)
Merging sound-current/for-linus (dd84cfff3cc3 Merge tag 'asoc-fix-v5.19-rc3=
' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for=
-linus)
Merging sound-asoc-fixes/for-linus (94f5ce9feef0 Merge remote-tracking bran=
ch 'asoc/for-5.18' into asoc-linus)
Merging regmap-fixes/for-linus (3f05010f243b regmap-irq: Fix offset/index m=
ismatch in read_sub_irq_data())
Merging regulator-fixes/for-linus (122e951eb804 regulator: qcom_smd: correc=
t MP5496 ranges)
Merging spi-fixes/for-linus (30554a1f0fd6 spi: aspeed: Fix division by zero)
Merging pci-current/for-linus (a2b36ffbf5b6 x86/PCI: Revert "x86/PCI: Clip =
only host bridge windows for E820 regions")
Merging driver-core.current/driver-core-linus (f2906aa86338 Linux 5.19-rc1)
Merging tty.current/tty-linus (b941e487152e serial: 8250: dw: Fix the macro=
 RZN1_UART_xDMACR_8_WORD_BURST)
Merging usb.current/usb-linus (5812175389e2 usb: dwc3-am62: remove unnecesa=
ry clk_put())
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (03c765b0e3b4 Linux 5.19-rc4)
Merging phy/fixes (9293ee00cc1c phy: ti: tusb1210: Don't check for write er=
rors when powering on)
Merging staging.current/staging-linus (ee6c6e734247 staging/wlan-ng: get th=
e correct struct hfa384x in work callback)
Merging iio-fixes/fixes-togreg (315f7e15c261 Merge tag 'iio-fixes-for-5.19a=
' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-mi=
sc-next)
Merging counter-fixes/fixes-togreg (f2906aa86338 Linux 5.19-rc1)
Merging char-misc.current/char-misc-linus (2cd37c2e7244 misc: rtsx_usb: set=
 return value in rsp_buf alloc err path)
Merging soundwire-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging thunderbolt-fixes/fixes (03c765b0e3b4 Linux 5.19-rc4)
Merging input-current/for-linus (039d4ed3428c Input: usbtouchscreen - add d=
river_info sanity check)
Merging crypto-current/master (87d044096ea6 crypto: ccp - Fix device IRQ co=
unting by using platform_irq_count())
Merging vfio-fixes/for-linus (1ef3342a934e vfio/pci: Fix vf_token mechanism=
 when device-specific VF drivers are used)
Merging kselftest-fixes/fixes (9b4d5c01eb23 selftests: make use of GUP_TEST=
_FILE macro)
Merging modules-fixes/modules-linus (7390b94a3c2d module: merge check_expor=
ted_symbol() into find_exported_symbol_in_section())
Merging dmaengine-fixes/fixes (09f7b80fac3e dmaengine: imx-sdma: only resta=
rt cyclic channel when enabled)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (06781a502635 mtd: rawnand: gpmi: Fix setting b=
usy timeout setting)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (750a914adb7d media: mediatek: vcodec: Drop pla=
tform_get_resource(IORESOURCE_IRQ))
Merging reset-fixes/reset/fixes (a57f68ddc886 reset: Fix devm bulk optional=
 exclusive control getter)
Merging mips-fixes/mips-fixes (88084a3df167 Linux 5.19-rc5)
Merging at91-fixes/at91-fixes (91d60e259c0f ARM: at91: pm: Mark at91_pm_sec=
ure_init as __init)
Merging omap-fixes/fixes (46ff3df87215 ARM: dts: logicpd-som-lv: Fix wrong =
pinmuxing on OMAP35)
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
Merging btrfs-fixes/next-fixes (8e71e0e77e30 Merge branch 'misc-5.19' into =
next-fixes)
Merging vfs-fixes/fixes (c3497fd009ef fix short copy handling in copy_mc_pi=
pe_to_iter())
Merging dma-mapping-fixes/for-linus (3be4562584bb dma-direct: use the corre=
ct size for dma_set_encrypted())
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (9ab762a84b80 platform/x86: hp-wmi: Ignore =
Sanitization Mode event)
Merging samsung-krzk-fixes/fixes (c4c79525042a ARM: exynos: Fix refcount le=
ak in exynos_map_pmu)
Merging pinctrl-samsung-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging devicetree-fixes/dt/linus (0b9431c8221c dt-bindings: display: arm,m=
alidp: remove bogus RQOS property)
Merging dt-krzk-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging scsi-fixes/fixes (fce54ed02757 scsi: hisi_sas: Limit max hw sectors=
 for v3 HW)
Merging drm-fixes/drm-fixes (b8f0009bc9ed Merge tag 'drm-misc-fixes-2022-06=
-30' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (79538490fd7a drm/i915: tweak =
the ordering in cpu_write_needs_clflush)
Merging mmc-fixes/fixes (89bcd9a64b84 mmc: mediatek: wait dma stop bit rese=
t to 0)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (a111daf0c53a Linux 5.19-rc3)
Merging hyperv-fixes/hyperv-fixes (49d6a3c062a1 x86/Hyper-V: Add SEV negoti=
ate protocol support in Isolation VM)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (e83031564137 riscv: Fix ALT_THEAD_PMA's asm par=
ameters)
Merging risc-v-mc-fixes/dt-fixes (5e757deddd91 riscv: dts: microchip: re-ad=
d pdma to mpfs device tree)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging spdx/spdx-linus (58301e1c15db Documentation: samsung-s3c24xx: Add b=
lank line after SPDX directive)
Merging gpio-brgl-fixes/gpio/for-current (03c765b0e3b4 Linux 5.19-rc4)
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
Merging cel-fixes/for-rc (a23dd544debc SUNRPC: Fix READ_PLUS crasher)
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
Merging drm-misc-fixes/for-linux-next-fixes (9fc33eaaa979 drm/panfrost: Fix=
 shrinker list corruption by madvise IOCTL)
Merging kbuild/for-next (e1769fb8d04e kbuild: remove sed command from cmd_a=
r_builtin)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (52f28b7bac75 perf script: Add some missing event du=
mps)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (0bf28fc40d89 swiotlb: panic if nslabs is too =
small)
Merging asm-generic/master (4313a24985f0 arch/*/: remove CONFIG_VIRT_TO_BUS)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (bafa10435c4f ARM: 9209/1: Spectre-BHB: avoid pr_info(=
) every time a CPU comes out of idle)
Merging arm64/for-next/core (6a5226cb3b73 Merge branch 'for-next/boot' into=
 for-next/core)
Merging arm-perf/for-next/perf (c5781212985a perf/arm-cmn: Decode CAL devic=
es properly in debugfs)
Merging arm-soc/for-next (5d5f72dbef46 soc: document merges)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (147c83586707 Merge branch 'v5.20/drivers' into fo=
r-next)
Merging aspeed/for-next (bfcbea2c93e5 ARM: dts: aspeed: nuvia: rename vendo=
r nuvia to qcom)
Merging at91/at91-next (f2906aa86338 Linux 5.19-rc1)
Merging broadcom/next (241b73730091 Merge branch 'devicetree-arm64/next' in=
to next)
Merging drivers-memory/for-next (0d97f2176dec memory: mtk-smi: Add support =
for MT6795 Helio X10)
Merging imx-mxs/for-next (333e323e7bd1 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (0c356b3c1158 Merge branch 'v5.19-next/soc' into =
for-next)
Merging mvebu/for-next (58ec0844bd13 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (ad2fe4582c48 Merge branches 'omap-for-v5.20/omap1', =
'omap-for-v5.20/ti-sysc' and 'omap-for-v5.20/soc' into for-next)
Merging qcom/for-next (d014f9463260 Merge branches 'arm64-for-5.20', 'arm64=
-defconfig-for-5.20', 'clk-for-5.20', 'dts-for-5.20', 'dts-fixes-for-5.19' =
and 'drivers-for-5.20' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (5695289da1bf Merge branches 'renesas-arm-dt-for-v5.20=
' and 'renesas-dt-bindings-for-v5.20' into renesas-next)
Merging reset/reset/next (b6b9585876da reset: microchip-sparx5: allow build=
ing as a module)
Merging rockchip/for-next (2e1170c71ec0 Merge branch 'v5.20-armsoc/dts64' i=
nto for-next)
Merging samsung-krzk/for-next (b479089ca1a8 Merge branch 'next/soc' into fo=
r-next)
Merging scmi/for-linux-next (e90e3e31adf0 Merge branch 'for-next/arch_topol=
ogy' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux in=
to for-linux-next)
Merging stm32/stm32-next (2b290a502360 ARM: dts: stm32: Add DHCOR based DRC=
 Compact board)
Merging sunxi/sunxi/for-next (d4b3f892befc Merge branch 'sunxi/fixes-for-5.=
19' into sunxi/for-next)
Merging tee/next (db30e53bf897 Merge branch 'tee_cleanup_for_v5.19' into ne=
xt)
Merging tegra/for-next (190a8de573a4 Merge branch for-5.20/arm64/defconfig =
into for-next)
Merging ti/ti-next (9b123c7c630c Merge branches 'ti-keystone-dts-next', 'ti=
-drivers-soc-next' and 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (516de80d448f Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (16615b92d4dc Merge branch 'clk-renesas' into clk-next)
Merging clk-imx/for-next (c196175acdd3 clk: imx: clk-fracn-gppll: Add more =
freq config for video pll)
Merging clk-renesas/renesas-clk (c2662ae3c228 clk: renesas: rcar-gen4: Fix =
initconst confusion for cpg_pll_config)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (64d83f067746 csky: Move $(core-y) into arch/csky/K=
build)
Merging loongarch/loongarch-next (a111daf0c53a Linux 5.19-rc3)
Merging m68k/for-next (4977636d44b8 m68k: q40: Align '*' in comments)
Merging m68knommu/for-next (a37e6853fcb9 m68k: Fix syntax errors in comment=
s)
Merging microblaze/next (78b5f52ab6f6 microblaze: fix typos in comments)
Merging mips/mips-next (88084a3df167 Linux 5.19-rc5)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (6d76d335d6a8 wireguard: selftests: support OpenR=
ISC)
Merging parisc-hd/for-next (03c765b0e3b4 Linux 5.19-rc4)
Merging powerpc/next (54c15ec3b738 powerpc: dts: Add DTS file for CZ.NIC Tu=
rris 1.x routers)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (54f0f3b298e2 riscv: Kconfig: Style cleanups)
Merging risc-v-mc/dt-for-next (3f8ccf5f1a8c riscv: dts: microchip: remove s=
pi-max-frequency property)
Merging s390/for-next (d7d488f41b41 s390/qdio: Fix spelling mistake)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (2a4a62a14be1 um: Fix out-of-bounds read in LDT setu=
p)
Merging xtensa/xtensa-for-next (a2d9b75b19dc xtensa: change '.bss' to '.sec=
tion .bss')
Merging pidfd/for-next (77940f0d96cd mnt_idmapping: align kernel doc and pa=
rameter order)
Merging fscrypt/master (218d921b581e fscrypt: add new helper functions for =
test_dummy_encryption)
Merging fscache/fscache-next (0885eacdc81f Merge tag 'nfsd-5.19-1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/cel/linux)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (df302b62096a Merge branch 'for-next-next-v5.19-2022=
0622' into for-next-20220622)
Merging ceph/master (152444d50ab5 fscrypt: add fscrypt_context_for_new_inod=
e)
Merging cifs/for-next (ebbfb5ffd692 cifs: remove redundant initialization t=
o variable mnt_sign_enabled)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (dec0a44c82d0 erofs: wake up all waiters after z_erofs_lz=
ma_head ready)
Merging exfat/dev (204e6ceaa103 exfat: use updated exfat_chain directly dur=
ing renaming)
Merging ext3/for_next (e252f2ed1c8c fanotify: introduce FAN_MARK_IGNORE)
Merging ext4/dev (729e657ab8d4 ext4: fix a doubled word "need" in a comment)
Merging f2fs/dev (785c1904b28d f2fs: add a sysfs entry to show zone capacit=
y)
Merging fsverity/fsverity (e6af1bb07704 fs-verity: Use struct_size() helper=
 in enable_verity())
Merging fuse/for-next (6b49bc9d8a5f fuse: avoid unnecessary spinlock bump)
Merging gfs2/for-next (44dab005fd42 gfs2: Minor gfs2_glock_nq_m cleanup)
Merging jfs/jfs-next (e471e5942c00 fs/jfs: Remove dead code)
Merging ksmbd/ksmbd-for-next (732f30694325 Merge tag '5.19-rc4-ksmbd-server=
-fixes' of git://git.samba.org/ksmbd)
Merging nfs/linux-next (88084a3df167 Linux 5.19-rc5)
Merging nfs-anna/linux-next (4f40a5b55446 NFSv4: Add an fattr allocation to=
 _nfs4_discover_trunking())
Merging nfsd/for-next (a56bf306ec75 NFSD: NFSv4 CLOSE should release an nfs=
d_file immediately)
Merging ntfs3/master (e4d2f4fd5341 fs/ntfs3: Enable FALLOC_FL_INSERT_RANGE)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (bc70682a497c ovl: support idmapped layers)
Merging ubifs/next (8c03a1c21d72 ubi: ubi_create_volume: Fix use-after-free=
 when volume creation failed)
Merging v9fs/9p-next (e3baced02a52 9p: Fix some kernel-doc comments)
Merging xfs/for-next (7561cea5dbb9 xfs: prevent a UAF when log IO errors ra=
ce with unmount)
Merging zonefs/for-next (31a644b3c2ae documentation: zonefs: Document sysfs=
 attributes)
Merging iomap/iomap-for-next (f8189d5d5fbf dax: set did_zero to true when z=
eroing successfully)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (b13baccc3850 Linux 5.19-rc2)
Merging printk/for-next (ab3547e3c281 Merge branch 'rework/kthreads' into f=
or-next)
Merging pci/next (20ba3070acb6 Merge branch 'pci/ctrl/vmd')
Merging pstore/for-next/pstore (2c09d1443b9b pstore/zone: cleanup "rcnt" ty=
pe)
Merging hid/for-next (6c55e6cce170 Merge branch 'for-5.20/nintendo' into fo=
r-next)
Merging i2c/i2c/for-next (d893259cd9f9 Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging i3c/i3c/next (f2906aa86338 Linux 5.19-rc1)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (9f6ca00b5be4 hwmon: (asus_wmi_sensors) Sa=
ve a few bytes of memory)
Merging jc_docs/docs-next (4d627ef12b40 docs/doc-guide: Mention make variab=
le SPHINXDIRS)
Merging v4l-dvb/master (945a9a8e448b media: pvrusb2: fix memory leak in pvr=
_probe)
Merging v4l-dvb-next/master (d8e8aa866ed8 media: mediatek: vcodec: Report s=
upported bitrate modes)
Merging pm/linux-next (0ce8d1fe2339 Merge branch 'thermal-core' into linux-=
next)
Merging cpufreq-arm/cpufreq/arm/linux-next (f250ac6ca9d2 cpufreq: qcom-cpuf=
req-hw: use HZ_PER_KHZ macro in units.h)
Merging cpupower/cpupower (f2906aa86338 Linux 5.19-rc1)
Merging devfreq/devfreq-next (fb021366974a PM / devfreq: imx-bus: use NULL =
to pass a null pointer rather than zero)
Merging opp/opp/linux-next (0d741710246c PM / devfreq: tegra30: Register co=
nfig_clks helper)
Merging thermal/thermal/linux-next (4768f717d85c dt-bindings: thermal: rcar=
-gen3-thermal: Add r8a779f0 support)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (0f24debbb847 fs: dlm: move kref_put assert for lkb struct=
s)
Merging rdma/for-next (f5d1f6d63c9a RDMA/rxe: Replace include statement)
Merging net-next/master (874bdbfe624e net: hns: Fix spelling mistakes in co=
mments.)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/rockchip/rk3568-b=
pi-r2-pro.dts
Merging bpf-next/for-next (b0d93b44641a selftests/bpf: Skip lsm_cgroup when=
 we don't have trampolines)
Merging ipsec-next/master (f41b284a2c18 xfrm: change the type of xfrm_regis=
ter_km and xfrm_unregister_km)
Merging mlx5-next/mlx5-next (cdcdce948d64 net/mlx5: Add bits and fields to =
support enhanced CQE compression)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (677fb7525331 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/netdev/net)
Merging bluetooth/master (681ec6abcd7f Bluetooth: btmtksdio: Add in-band wa=
keup support)
Merging wireless-next/for-next (8bc65d38ee46 wifi: nl80211: retrieve EHT re=
lated elements in AP mode)
Merging mtd/mtd/next (ad9b10d1eaad mtd: core: introduce of support for dyna=
mic partitions)
Merging nand/nand/next (e16eceea863b mtd: rawnand: arasan: Fix clock rate i=
n NV-DDR)
Merging spi-nor/spi-nor/next (77d4ac6d3848 mtd: spi-nor: move SECT_4K_PMC s=
pecial handling)
Merging crypto/master (fac76f226089 crypto: arm64/gcm - Select AEAD for GHA=
SH_ARM64_CE)
Merging drm/drm-next (f929217499cf Merge tag 'drm-misc-next-2022-06-30' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/drm_aperture.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dp=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/vc4/vc4_drv.c
Merging drm-misc/for-linux-next (21779cc21c73 drm: bridge: sii8620: fix pos=
sible off-by-one)
Merging amdgpu/drm-next (c5da61cf5bab drm/amdgpu/display: add missing FP_ST=
ART/END checks dcn32_clk_mgr.c)
Merging drm-intel/for-linux-next (3461b040a90d drm/i915/display: clean up c=
omments)
Merging drm-tegra/drm/tegra/for-next (06764bb32be0 MAINTAINERS: Rectify ent=
ry for NVIDIA TEGRA DRM and VIDEO DRIVER)
Merging drm-msm/msm-next (24df12013853 MAINTAINERS: Add Dmitry as MSM DRM d=
river co-maintainer)
Merging drm-msm-lumag/msm-next-lumag (b869963ec132 Merge branches 'msm-next=
-lumag-core', 'msm-next-lumag-dpu', 'msm-next-lumag-dp', 'msm-next-lumag-ds=
i', 'msm-next-lumag-hdmi', 'msm-next-lumag-mdp5' and 'msm-next-lumag-mdp4' =
into msm-next-lumag)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (2829a9fcb738 drm/etnaviv: reap idle softpin m=
appings when necessary)
Merging fbdev/for-next (348cfea25c7a fbcon: Use fbcon_info_from_console() i=
n fbcon_modechange_possible())
Merging regmap/for-next (e129e4138147 regmap-irq cleanups and refactoring)
Merging sound/for-next (c71531007ef0 tracing: ALSA: hda: Remove string mani=
pulation out of the fast path)
Merging sound-asoc/for-next (825cc534a73f Merge remote-tracking branch 'aso=
c/for-5.20' into asoc-next)
Merging modules/modules-next (7390b94a3c2d module: merge check_exported_sym=
bol() into find_exported_symbol_in_section())
Merging input/next (a6a87c36165e Input: i8042 - add TUXEDO devices to i8042=
 quirk tables)
Merging block/for-next (e57e3978bf40 Merge branch 'for-5.20/io_uring-buffer=
ed-writes' into for-next)
Merging device-mapper/for-next (617b365872a2 dm raid: fix KASAN warning in =
raid5_add_disks)
Merging libata/for-next (0184898dd14d ata: libata-scsi: fix result type of =
ata_ioc32())
Merging pcmcia/pcmcia-next (2ef4bb24ff39 pcmcia: Use platform_get_irq() to =
get the interrupt)
Merging mmc/next (fddbf585ab1f mmc: sdhci-of-esdhc: Fixup use of of_find_co=
mpatible_node())
Merging mfd/for-mfd-next (e0d1c4b1c0a8 mfd: mt6397: Add basic support for M=
T6331+MT6332 PMIC)
$ git reset --hard HEAD^
Merging next-20220704 version of mfd
Merging backlight/for-backlight-next (023a8830a628 backlight: backlight: Sl=
ighly simplify devm_of_find_backlight())
Merging battery/for-next (a578cc3af5ce power: reset: pwr-mlxbf: change rst_=
pwr_hid and low_pwr_hid from global to local variables)
Merging regulator/for-next (3dbee7f9e9e0 regulator: qcom_smd: Add PM8909 an=
d fix pm8916_pldo range)
Merging security/next-testing (88c9c5679a06 Merge tag 'v5.18' into next-tes=
ting)
Merging apparmor/apparmor-next (c2489617b3b9 apparmor: Fix undefined refere=
nce to `zlib_deflate_workspacesize')
CONFLICT (content): Merge conflict in security/apparmor/policy_unpack_test.c
Merging integrity/next-integrity (51dd64bb99e4 Revert "evm: Fix memleak in =
init_desc")
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (ef54ccb61616 selinux: selinux_add_opt() callers free =
memory)
Merging smack/next (b50503990d88 smack: Remove the redundant lsm_inode_allo=
c)
Merging tomoyo/master (b13baccc3850 Linux 5.19-rc2)
Merging tpmdd/next (10a1e332f3d3 KEYS: asymmetric: enforce SM2 signature us=
e pkey algo)
Merging watchdog/master (a111daf0c53a Linux 5.19-rc3)
Merging iommu/next (bc11db25f743 Merge branches 'iommu/fixes', 'arm/mediate=
k', 'x86/amd' and 'core' into next)
Merging audit/next (546093206ba1 audit: make is_audit_feature_set() static)
Merging devicetree/for-next (e35330f879cf dt-bindings: watchdog: faraday: F=
ix typo in example 'timeout-sec' property)
Merging dt-krzk/for-next (ad0d6ea39195 Merge branch 'for-v5.20/dt-bindings-=
qcom' into next/dt-bindings)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/arm=
/qcom.yaml
Merging mailbox/mailbox-for-next (79f9fbe30352 mailbox: qcom-ipcc: Fix -Wun=
used-function with CONFIG_PM_SLEEP=3Dn)
Merging spi/for-next (25442613d3ef Merge remote-tracking branch 'spi/for-5.=
20' into spi-next)
Merging tip/master (3c1ec304a1bc Merge branch into tip/master: 'x86/vmware')
Merging clockevents/timers/drivers/next (ff714ee7191b clocksource/drivers/t=
imer-ti-dm: Add compatible for am6 SoCs)
Merging edac/edac-for-next (92705c9f9956 Merge edac-misc into for-next)
Merging irqchip/irq/irqchip-next (ee4aae577721 Merge branch irq/plic-edge-f=
ixes into irq/irqchip-next)
Merging ftrace/for-next (01dca6d03bb3 Merge branch 'trace/for-next-rtla' in=
to trace/for-next)
Merging rcu/rcu/next (ccebf3c56189 rcu: Update rcu_preempt_deferred_qs() co=
mments for !PREEMPT kernels)
Merging kvm/next (4b88b1a518b3 KVM: selftests: Enhance handling WRMSR ICR r=
egister in x2APIC mode)
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
Merging kvm-arm/next (156c5a072a2c Merge branch kvm-arm64/misc-5.20 into kv=
marm-master/next)
Merging kvms390/next (b1edf7f159a6 KVM: s390: selftests: Use TAP interface =
in the reset test)
Merging xen-tip/linux-next (dbe97cff7dd9 xen/gntdev: Avoid blocking in unma=
p_grant_pages())
Merging percpu/for-next (a111daf0c53a Linux 5.19-rc3)
Merging workqueues/for-next (8bee9dd953b6 workqueue: Switch to new kerneldo=
c syntax for named variable macro argument)
Merging drivers-x86/for-next (2ac96c800dd1 platform/x86: hp-wmi: Ignore San=
itization Mode event)
Merging chrome-platform/for-next (3de7203115af platform/chrome: wilco_ec: e=
vent: Fix typo in comment)
Merging hsi/for-next (43c14f8d18a7 HSI: omap_ssi: Fix refcount leak in ssi_=
probe)
Merging leds/for-next (f2906aa86338 Linux 5.19-rc1)
Merging ipmi/for-next (a508e33956b5 ipmi:ipmb: Fix refcount leak in ipmi_ip=
mb_probe)
Merging driver-core/driver-core-next (72b5d5aef246 kernfs: fix potential NU=
LL dereference in __kernfs_remove)
Merging usb/usb-next (90557fa89d3e dt-bindings: usb: atmel: Add Microchip L=
AN9662 compatible string)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging thunderbolt/next (34b9715b7cae thunderbolt: Fix typo in comment)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (7828466cff6b USB: serial: use kmemdup instead =
of kmalloc + memcpy)
Merging tty/tty-next (734966043860 tty: n_gsm: fix resource allocation orde=
r in gsm_activate_mux())
Merging char-misc/char-misc-next (1045a06724f3 remove CONFIG_ANDROID)
Merging coresight/next (c06475910b52 Documentation: coresight: Escape cores=
ight bindings file wildcard)
Merging fpga/for-next (ee794221a6f6 fpga: fpga-mgr: Fix spelling mistake "b=
itsream" -> "bitstream")
Merging icc/icc-next (9f8c52f9a24b Merge branch 'icc-imx8mp' into icc-next)
Merging iio/togreg (883f50ead31c iio: adc: stm32-adc: disable adc before ca=
libration)
Merging phy-next/next (18b3eb79b1cf MAINTAINERS: add include/dt-bindings/ph=
y to GENERIC PHY FRAMEWORK)
Merging soundwire/next (f2906aa86338 Linux 5.19-rc1)
Merging extcon/extcon-next (187dc83647a0 extcon: rt8973a: Drop useless mask=
_invert flag on irqchip)
Merging gnss/gnss-next (c0c725d7350e gnss: replace ida_simple API)
Merging vfio/next (7654a8881a54 Merge branches 'v5.20/vfio/migration-enhanc=
ements-v3', 'v5.20/vfio/simplify-bus_type-determination-v3', 'v5.20/vfio/ch=
eck-vfio_register_iommu_driver-return-v2', 'v5.20/vfio/check-iommu_group_se=
t_name_return-v1', 'v5.20/vfio/clear-caps-buf-v3', 'v5.20/vfio/remove-usele=
ss-judgement-v1' and 'v5.20/vfio/move-device_open-count-v2' into v5.20/vfio=
/next)
Merging staging/staging-next (3355a12760de staging: r8188eu: remove unneede=
d semicolon)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (9bef4929fa21 dmaengine: fsl-edma: remove redundant =
assignment to pointer last_sg)
Merging cgroup/for-next (27924b13fcce Merge branch 'for-5.20' into for-next)
Merging scsi/for-next (1b72be9c3656 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (bcec04b3cce4 scsi: ufs: ufs-qcom: Remove unneede=
d code)
Merging vhost/linux-next (6a9720576cd0 virtio: VIRTIO_HARDEN_NOTIFICATION i=
s broken)
Merging rpmsg/for-next (be67da206339 Merge branches 'rproc-next' and 'rpmsg=
-next' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (097c53a72818 gpio: xgs-iproc: Drop if with=
 an always false condition)
Merging gpio-intel/for-next (b65bb2c14891 gpio: pch: Change PCI device macr=
os)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (1ddcae6cd6c1 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (25097de7b236 pinctrl: intel: Add Intel Mete=
or Lake pin controller support)
Merging pinctrl-renesas/renesas-pinctrl (29a99eb2215a pinctrl: renesas: Add=
 RZ/V2M pin and gpio controller driver)
Merging pinctrl-samsung/for-next (c98ebe065e07 pinctrl: samsung: do not use=
 bindings header with constants)
Merging pwm/for-next (394b517585da pwm: mediatek: Add MT8365 support)
Merging userns/for-next (a58ea318d8b9 Merge of per-namespace-ipc-sysctls-fo=
r-v5.19, kthread-cleanups-for-v5.19, ptrace_stop-cleanup-for-v5.19, and uco=
unt-rlimits-cleanups-for-v5.19 for testing in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (b7ecce6800eb selftests:timers: globals don't need i=
nitialization to 0)
Merging livepatching/for-next (df44b1ee72f4 Merge branch 'for-5.20/selftest=
s-fixes' into for-next)
Merging rtc/rtc-next (592ff0c8d064 rtc: Directly use ida_alloc()/free())
Merging nvdimm/libnvdimm-for-next (f42e8e5088b9 pmem: implement pmem_recove=
ry_write())
Merging at24/at24/for-next (312310928417 Linux 5.18-rc1)
Merging ntb/ntb-next (9297e01b038b drivers/ntb/test: avoid 64-bit modulus o=
peration)
Merging seccomp/for-next/seccomp (73a8dbafd31a selftests/seccomp: Fix compi=
le warning when CC=3Dclang)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (f2af60bb7ce2 fsi: Add trace events in initialization path)
Merging slimbus/for-next (4ad3deabeea2 slimbus: messaging: fix typos in com=
ments)
Merging nvmem/for-next (ccba200e4801 dt-bindings: nvmem: mediatek: efuse: a=
dd support mt8183)
Merging xarray/main (63b1898fffcd XArray: Disallow sibling entries of nodes)
Merging hyperv/hyperv-next (d27423bf048d hv_balloon: Fix balloon_probe() an=
d balloon_remove() error handling)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (efa0855c5b84 RDMA/erdma: Add driver to kernel build enviro=
nment)
Merging kunit/test (f2906aa86338 Linux 5.19-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging kunit-next/kunit (c272612cb4a2 kunit: Taint the kernel when KUnit t=
ests are run)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (2113651ddf3d bus: mhi: host: pci_generic: Add another=
 Foxconn T99W175)
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
Merging random/master (03c765b0e3b4 Linux 5.19-rc4)
Merging landlock/next (b13baccc3850 Linux 5.19-rc2)
Merging rust/rust-next (9a5fe747d99e init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
CONFLICT (content): Merge conflict in Makefile
CONFLICT (content): Merge conflict in include/uapi/linux/android/binder.h
Merging sysctl/sysctl-next (acdc07ace871 kernel/sysctl.c: Clean up indentat=
ion, replace spaces with tab.)
Merging folio/for-next (9e0d6442d867 fs: remove the NULL get_block case in =
mpage_writepages)
Merging execve/for-next/execve (5036793d7dbd exec: Fix a spelling mistake)
Merging bitmap/bitmap-for-next (52cdf267e77d lib/cpumask: move some one-lin=
e wrappers to header file)
Merging hte/hte/for-next (85ff37e302ef gpiolib: cdev: Fix kernel doc for st=
ruct line)
Merging kspp/for-next/kspp (e1d337335207 cfi: Fix __cfi_slowpath_diag RCU u=
sage with cpuidle)
CONFLICT (content): Merge conflict in kernel/cfi.c
Merging kspp-gustavo/for-next/kspp (94dfc73e7cf4 treewide: uapi: Replace ze=
ro-length arrays with flexible-array members)
Merging mm-stable/mm-stable (4f2930c6718a selftests/vm: only run 128TBswitc=
h with 5-level paging)
CONFLICT (file location): Documentation/translations/zh_CN/vm/page_migratio=
n.rst added in HEAD inside a directory that was renamed in mm-stable/mm-sta=
ble, suggesting it should perhaps be moved to Documentation/translations/zh=
_CN/mm/page_migration.rst.
CONFLICT (file location): Documentation/translations/zh_CN/vm/vmalloced-ker=
nel-stacks.rst added in HEAD inside a directory that was renamed in mm-stab=
le/mm-stable, suggesting it should perhaps be moved to Documentation/transl=
ations/zh_CN/mm/vmalloced-kernel-stacks.rst.
CONFLICT (content): Merge conflict in include/linux/pagevec.h
Merging mm-nonmm-stable/mm-nonmm-stable (ee56c3e8eec1 Merge branch 'master'=
 into mm-nonmm-stable)
Merging mm/mm-everything (e7b4b86a533f Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in include/linux/cpumask.h
CONFLICT (content): Merge conflict in include/linux/gfp.h
Applying: fix up for "mm: split include/linux/gfp.h"

--Sig_/Hp1+9GkTrzqlMOfN1gENCxj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLD6lAACgkQAVBC80lX
0GyO7wf+MNMM4agf8ToDNpv5DOCLLI70Ans/d3IFQQLx7TpXutWzduBkOrn5SIiQ
SSK7giDKWUQ/DFk2bBOFcE/z7aDqHv1qyV1p0umgUo7XA4/NOF2ESbMmZlW+DWcV
NijNNg9WOu3g6PQvFJlmU+brYGEDbvB5qyixCsFo44911Cn74O5X7Km2cBeh/W/x
qMCAG1Ivk9R7px7tFOY2/dCY/AYe8C5Sd187+A08IkpXExZ7ZigqsdgtJpCR6J38
xk6V2Va5XW/nbdloxZo1JWejkvvE+LuoXRc5brN9T+FNCWF5l8bkEuGUDl56x7re
/fL3ul1FBkI5jDbyVhtWfpb8ene/Vw==
=EADV
-----END PGP SIGNATURE-----

--Sig_/Hp1+9GkTrzqlMOfN1gENCxj--
