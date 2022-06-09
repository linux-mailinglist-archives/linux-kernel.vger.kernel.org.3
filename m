Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9565544260
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 06:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiFIEOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 00:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFIEOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 00:14:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F50D25380B;
        Wed,  8 Jun 2022 21:14:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LJW1g75Pvz4xD1;
        Thu,  9 Jun 2022 14:13:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654748040;
        bh=ufYQzR7Qm9T+zHyrXfuOLJSLBF1T08GFcwViB2g4diE=;
        h=Date:From:To:Cc:Subject:From;
        b=NUEWadA0/AlXNdKb9beQElWjWRimGVBakmFlKHcObja6hp5a9Yqbwb889kzE2DnSP
         NY2skFwkI+59Ew1ixpOa43A0bufxzrSzUor7N662NpcleqU6CYFr3nOm7tarRPLzyV
         COeZrH/WyTsyTHYInxFOBgMzfv4uksJ+iLb1k+jRJnfiVYd0zfRlF7ZZhWUTA6Krzi
         MCVD4p14Lg+50pM3utq8xz134vZYLppxkXR4p6ngLYwWVPEE+BUaghowSZfuocahMx
         acMbUINzVhDWRjkqT0tetQxsVuazj84y7og2MME+NONVSjwToKSXAm6d6NX7YN75K7
         wxTRtiA7QKhDQ==
Date:   Thu, 9 Jun 2022 14:13:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jun 9
Message-ID: <20220609141358.5a545130@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mjG8Ah_8x1FzrnnKVlXeMTm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mjG8Ah_8x1FzrnnKVlXeMTm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

News: there will be no linux-next release on Monday.

Changes since 20220608:

The amdgpu tree still had its build failures, so I used the
version from next-20220601 again.

The kvm tree gained a conflict against Linus' tree.

Non-merge commits (relative to Linus' tree): 1692
 1806 files changed, 142605 insertions(+), 18190 deletions(-)

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

I am currently merging 352 trees (counting Linus' and 95 trees of bug
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
Merging origin/master (6bfb56e93bce cert host tools: Stop complaining about=
 deprecated OpenSSL functions)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging mm-hotfixes/mm-hotfixes-unstable (4798f2befab9 MAINTAINERS: add Mia=
ohe Lin as a memory-failure reviewer)
Merging kbuild-current/fixes (c531e24c7011 scripts/check-local-export: avoi=
d 'wait $!' for process substitution)
Merging arc-current/for-curr (f978e8023f33 ARC: bitops: Change __fls to ret=
urn unsigned long)
Merging arm-current/fixes (3cfb30199796 ARM: 9197/1: spectre-bhb: fix loop8=
 sequence for Thumb2)
Merging arm64-fixes/for-next/fixes (f539316fe810 arm64/sme: Fix SVE/SME typ=
o in ABI documentation)
Merging arm-soc-fixes/arm/fixes (609a097f5f06 Merge tag 'v5.18-rockchip-dts=
fixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockch=
ip into arm/fixes)
Merging drivers-memory-fixes/fixes (1332661e0930 memory: samsung: exynos542=
2-dmc: Fix refcount leak in of_get_dram_timings)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (30b5e6ef4a32 m68k: atari: Make Atari ROM po=
rt I/O write macros return void)
Merging powerpc-fixes/fixes (3e8635fb2e07 powerpc/kasan: Force thread size =
increase with KASAN)
Merging s390-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (a6958951ebe7 au1000_eth: stop using virt_to_bus())
Merging bpf/master (7c217aca85dd MAINTAINERS: Add a maintainer for bpftool)
Merging ipsec/master (f85daf0e7253 xfrm: xfrm_policy: fix a possible double=
 xfrm_pols_put() in xfrm_bundle_lookup())
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (05ae2fba821c netfilter: nft_socket: make cgroup match =
work in input too)
Merging wireless/for-next (58f9d52ff689 Merge tag 'net-5.19-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging rdma-fixes/for-rc (118f767413ad RDMA/qedr: Fix reporting QP timeout=
 attribute)
Merging sound-current/for-linus (5f3d696eea91 ALSA: hda/realtek: Add quirk =
for HP Dev One)
Merging sound-asoc-fixes/for-linus (d1d66d35fb70 Merge remote-tracking bran=
ch 'asoc/for-5.18' into asoc-linus)
Merging regmap-fixes/for-linus (cc993887f347 Merge remote-tracking branch '=
regmap/for-5.18' into regmap-linus)
Merging regulator-fixes/for-linus (122e951eb804 regulator: qcom_smd: correc=
t MP5496 ranges)
Merging spi-fixes/for-linus (6aa27071e435 spi: dt-bindings: Fix unevaluated=
Properties warnings in examples)
Merging pci-current/for-linus (f2906aa86338 Linux 5.19-rc1)
Merging driver-core.current/driver-core-linus (f2906aa86338 Linux 5.19-rc1)
Merging tty.current/tty-linus (f2906aa86338 Linux 5.19-rc1)
Merging usb.current/usb-linus (f2906aa86338 Linux 5.19-rc1)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (f2906aa86338 Linux 5.19-rc1)
Merging phy/fixes (f2906aa86338 Linux 5.19-rc1)
Merging staging.current/staging-linus (96f0a54e8e65 staging: r8188eu: Fix w=
arning of array overflow in ioctl_linux.c)
Merging iio-fixes/fixes-togreg (dee61a0ffff5 iio: adc: vf610: fix conversio=
n mode sysfs node name)
Merging counter-fixes/fixes-togreg (f2906aa86338 Linux 5.19-rc1)
Merging char-misc.current/char-misc-linus (f2906aa86338 Linux 5.19-rc1)
Merging soundwire-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging thunderbolt-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging input-current/for-linus (6ab2e51898cd Input: soc_button_array - als=
o add Lenovo Yoga Tablet2 1051F to dmi_use_low_level_irq)
Merging crypto-current/master (e4e62bbc6aba hwrng: omap3-rom - fix using wr=
ong clk_disable() in omap_rom_rng_runtime_resume())
Merging vfio-fixes/for-linus (1ef3342a934e vfio/pci: Fix vf_token mechanism=
 when device-specific VF drivers are used)
Merging kselftest-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging modules-fixes/modules-linus (7390b94a3c2d module: merge check_expor=
ted_symbol() into find_exported_symbol_in_section())
Merging dmaengine-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (ba7542eb2dd5 mtd: rawnand: qcom: fix memory co=
rruption that causes panic)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (d4cb77112c7b media: isl7998x: select V4L2_FWNO=
DE to fix build error)
Merging reset-fixes/reset/fixes (03cb66463b55 dt-bindings: reset: Add paren=
t "resets" property as optional)
Merging mips-fixes/mips-fixes (f2906aa86338 Linux 5.19-rc1)
Merging at91-fixes/at91-fixes (0c640d9544d0 ARM: dts: at91: fix pinctrl pha=
ndles)
Merging omap-fixes/fixes (46ff3df87215 ARM: dts: logicpd-som-lv: Fix wrong =
pinmuxing on OMAP35)
Merging kvm-fixes/master (6cd88243c7e0 KVM: x86: do not report a vCPU as pr=
eempted outside instruction boundaries)
Merging kvms390-fixes/master (242c04f01377 KVM: s390: selftests: Use TAP in=
terface in the reset test)
Merging hwmon-fixes/hwmon (ac6888ac5a11 hwmon: (occ) Lock mutex in shutdown=
 to prevent race with occ_active)
Merging nvdimm-fixes/libnvdimm-fixes (d28820419ca3 cxl/pci: Drop shadowed v=
ariable)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (5f414c4e30de Merge branch 'misc-5.19' into =
next-fixes)
Merging vfs-fixes/fixes (fb4554c2232e Fix double fget() in vhost_net_set_ba=
ckend())
Merging dma-mapping-fixes/for-linus (18a3c5f7abfd Merge tag 'for_linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (44acfc22c7d0 platform/surface: aggregator:=
 Fix initialization order when compiling as builtin module)
Merging samsung-krzk-fixes/fixes (c4c79525042a ARM: exynos: Fix refcount le=
ak in exynos_map_pmu)
Merging pinctrl-samsung-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging devicetree-fixes/dt/linus (927c63e07810 dt-bindings: Drop more redu=
ndant 'maxItems/minItems' in if/then schemas)
Merging scsi-fixes/fixes (ec1e8adcbdf6 scsi: pmcraid: Fix missing resource =
cleanup in error case)
Merging drm-fixes/drm-fixes (4b0986a3613c Linux 5.18)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (f2906aa86338 Linux 5.19-rc1)
Merging mmc-fixes/fixes (f616ec25d0bf mmc: sdhci-pci-o2micro: Fix card dete=
ct by dealing with debouncing)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (f2906aa86338 Linux 5.19-rc1)
Merging hyperv-fixes/hyperv-fixes (f5f93d7f5a5c HID: hyperv: Correctly acce=
ss fields declared as __le16)
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging risc-v-mc-fixes/dt-fixes (f2906aa86338 Linux 5.19-rc1)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (f2906aa86338 Linux 5.19-rc1)
Merging spdx/spdx-linus (f2906aa86338 Linux 5.19-rc1)
Merging gpio-brgl-fixes/gpio/for-current (f2906aa86338 Linux 5.19-rc1)
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
Merging cel-fixes/for-rc (da9e94fe000e SUNRPC: Remove pointer type casts fr=
om xdr_get_next_encode_buffer())
Merging irqchip-fixes/irq/irqchip-fixes (544808f7e21c irqchip/gic, gic-v3: =
Prevent GSI to SGI translations)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (eaea45fc0e7b Merge tag 'perf-tools-fixes-=
for-v5.18-2022-05-21' of git://git.kernel.org/pub/scm/linux/kernel/git/acme=
/linux)
Merging efi-fixes/urgent (9feaf8b387ee efi: fix return value of __setup han=
dlers)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging drm-misc-fixes/for-linux-next-fixes (e54a4424925a drm/atomic: Force=
 bridge self-refresh-exit on CRTC switch)
Merging kbuild/for-next (44688ffd111a Merge tag 'objtool-urgent-2022-06-05'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (9886142c7a22 Merge tag 'input-for-v5.19-rc1' of git=
://git.kernel.org/pub/scm/linux/kernel/git/dtor/input)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (e15db62bc564 swiotlb: fix setting ->force_bou=
nce)
Merging asm-generic/master (b2441b3bdce6 h8300: remove stale bindings and s=
ymlink)
Merging arc/for-next (f2906aa86338 Linux 5.19-rc1)
Merging arm/for-next (bafa10435c4f ARM: 9209/1: Spectre-BHB: avoid pr_info(=
) every time a CPU comes out of idle)
Merging arm64/for-next/core (78c09c0f4df8 kselftest/arm64: signal: Skip SVE=
 signal test if not enough VLs supported)
Merging arm-perf/for-next/perf (c5781212985a perf/arm-cmn: Decode CAL devic=
es properly in debugfs)
Merging arm-soc/for-next (cd4a1a61fd72 soc: document merges)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
CONFLICT (content): Merge conflict in arch/arm/Makefile
CONFLICT (modify/delete): arch/arm/configs/imote2_defconfig deleted in Temp=
orary merge branch 2 and modified in Temporary merge branch 1.  Version Tem=
porary merge branch 1 of arch/arm/configs/imote2_defconfig left in tree.
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (1dac6e1d8385 Merge branch 'v5.20/drivers' into fo=
r-next)
Merging aspeed/for-next (bfcbea2c93e5 ARM: dts: aspeed: nuvia: rename vendo=
r nuvia to qcom)
Merging at91/at91-next (3519476d99a4 Merge branch 'at91-dt' into at91-next)
Merging drivers-memory/for-next (44a5f0330d32 Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (6ed2affe8f7f Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (b7fb186ebab3 Merge branch 'v5.19-next/soc' into =
for-next)
Merging mvebu/for-next (58ec0844bd13 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (b5418fc0478c Merge branch 'omap-for-v5.19/dt' into f=
or-next)
Merging qcom/for-next (5faa5cd718a4 Merge branches 'arm64-for-5.19', 'arm64=
-defconfig-for-5.19', 'clk-for-5.19', 'defconfig-for-5.19', 'drivers-for-5.=
19', 'dts-for-5.19' and 'arm64-fixes-for-5.18' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (6f4a1ec70aec Merge branch 'renesas-arm-dt-for-v5.20' =
into renesas-next)
Merging reset/reset/next (2ca065dc9468 dt-bindings: reset: st,sti-powerdown=
: Convert to yaml)
Merging rockchip/for-next (f7898b33dbb0 Merge branch 'v5.20-armsoc/dts64' i=
nto for-next)
Merging samsung-krzk/for-next (3e2df9e51e79 Merge branch 'next/soc' into fo=
r-next)
Merging scmi/for-linux-next (9cbe729756e4 Merge branch 'for-next/scmi' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (f2906aa86338 Linux 5.19-rc1)
Merging sunxi/sunxi/for-next (076b8d7194c3 Merge branch 'sunxi/dt-for-5.20'=
 into sunxi/for-next)
Merging tee/next (db30e53bf897 Merge branch 'tee_cleanup_for_v5.19' into ne=
xt)
Merging tegra/for-next (22cd13a29127 Merge branch for-5.20/arm64/defconfig =
into for-next)
Merging ti/ti-next (f2906aa86338 Linux 5.19-rc1)
Merging xilinx/for-next (63623390c0d6 arm64: dts: zynqmp: add AMS driver to=
 device tree)
Merging clk/clk-next (f2906aa86338 Linux 5.19-rc1)
Merging clk-imx/for-next (cf7f3f4fa9e5 clk: imx8mp: fix usb_root_clk parent)
Merging clk-renesas/renesas-clk (02c96ed9e4cd clk: renesas: rzg2l: Fix rese=
t status function)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (64d83f067746 csky: Move $(core-y) into arch/csky/K=
build)
Merging loongarch/loongarch-next (8be4493119b0 MAINTAINERS: Add maintainer =
information for LoongArch)
Merging m68k/for-next (30b5e6ef4a32 m68k: atari: Make Atari ROM port I/O wr=
ite macros return void)
Merging m68knommu/for-next (c5ac8a9fcfab m68k: coldfire/device.c: protect F=
LEXCAN blocks)
Merging microblaze/next (78b5f52ab6f6 microblaze: fix typos in comments)
Merging mips/mips-next (f2906aa86338 Linux 5.19-rc1)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (83da38d82b2f openrisc: Allow power off handler o=
verriding)
Merging parisc-hd/for-next (1d0811b03eb3 parisc/stifb: Fix fb_is_primary_de=
vice() only available with CONFIG_FB_STI)
Merging powerpc/next (6112bd00e84e Merge tag 'powerpc-5.19-1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (f2906aa86338 Linux 5.19-rc1)
Merging risc-v-mc/dt-for-next (294b2111ff10 riscv: dts: microchip: remove s=
pi-max-frequency property)
Merging s390/for-next (f2906aa86338 Linux 5.19-rc1)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (2a4a62a14be1 um: Fix out-of-bounds read in LDT setu=
p)
Merging xtensa/xtensa-for-next (dc60001e1a30 xtensa: Return true/false (not=
 1/0) from bool function)
Merging pidfd/for-next (e1bbcd277a53 fs: hold writers when changing mount's=
 idmapping)
Merging fscrypt/master (218d921b581e fscrypt: add new helper functions for =
test_dummy_encryption)
Merging fscache/fscache-next (713423282ae1 netfs: Fix gcc-12 warning by emb=
edding vfs inode in netfs_i_context)
CONFLICT (content): Merge conflict in fs/ceph/caps.c
CONFLICT (content): Merge conflict in include/linux/netfs.h
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (4077c8c19c72 Merge branch 'for-next-next-v5.19-2022=
0608' into for-next-20220608)
Merging ceph/master (b24d20af4c2e fscrypt: add fscrypt_context_for_new_inod=
e)
Merging cifs/for-next (8c7a741fd417 cifs: populate empty hostnames for extr=
a channels)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (f2906aa86338 Linux 5.19-rc1)
Merging exfat/dev (64ba4b15e5c0 exfat: check if cluster num is valid)
Merging ext3/for_next (537e11cdc7a6 quota: Prevent memory allocation recurs=
ion while holding dq_lock)
Merging ext4/dev (5f41fdaea63d ext4: only allow test_dummy_encryption when =
supported)
Merging f2fs/dev (b69c95858779 f2fs: use the updated test_dummy_encryption =
helper functions)
Merging fsverity/fsverity (e6af1bb07704 fs-verity: Use struct_size() helper=
 in enable_verity())
Merging fuse/for-next (6b49bc9d8a5f fuse: avoid unnecessary spinlock bump)
Merging gfs2/for-next (ab37c305bf89 gfs2: Remove redundant NULL check befor=
e kfree)
Merging jfs/jfs-next (e471e5942c00 fs/jfs: Remove dead code)
Merging ksmbd/ksmbd-for-next (f2906aa86338 Linux 5.19-rc1)
Merging nfs/linux-next (42226c989789 Linux 5.18-rc7)
Merging nfs-anna/linux-next (304791255a2d sunrpc: set cl_max_connect when c=
loning an rpc_clnt)
Merging nfsd/for-next (f012e95b377c SUNRPC: Trap RDMA segment overflows)
Merging ntfs3/master (dc8965ab5e33 fs/ntfs3: Remove redundant assignment to=
 variable vcn)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (bc70682a497c ovl: support idmapped layers)
Merging ubifs/next (8c03a1c21d72 ubi: ubi_create_volume: Fix use-after-free=
 when volume creation failed)
Merging v9fs/9p-next (22e424feb665 Revert "fs/9p: search open fids first")
Merging xfs/for-next (7146bda743e6 Merge branch 'guilt/xfs-5.19-larp-cleanu=
ps' into xfs-5.19-for-next)
Merging zonefs/for-next (31a644b3c2ae documentation: zonefs: Document sysfs=
 attributes)
Merging iomap/iomap-for-next (e9c3a8e820ed iomap: don't invalidate folios a=
fter writeback errors)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (e9921ffd594f Merge branches 'work.namei', 'work.mount=
' and 'work.fd' into for-next)
Merging printk/for-next (d55663695b60 Merge branch 'rework/kthreads' into f=
or-next)
Merging pci/next (f2906aa86338 Linux 5.19-rc1)
Merging pstore/for-next/pstore (8126b1c73108 pstore: Don't use semaphores i=
n always-atomic-context code)
Merging hid/for-next (221bd70be2e8 Merge branch 'for-5.19/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (fbecd5a0d391 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (f2906aa86338 Linux 5.19-rc1)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (2ca97cc163ad hwmon: (lm90) Read the chann=
el's temperature offset from device-tree)
Merging jc_docs/docs-next (f2906aa86338 Linux 5.19-rc1)
Merging v4l-dvb/master (f2906aa86338 Linux 5.19-rc1)
Merging v4l-dvb-next/master (f2906aa86338 Linux 5.19-rc1)
Merging pm/linux-next (28e0b92ca611 Merge branch 'pm-sysoff' into linux-nex=
t)
Merging cpufreq-arm/cpufreq/arm/linux-next (39b360102f3a cpufreq: mediatek:=
 Add support for MT8186)
Merging cpupower/cpupower (f2906aa86338 Linux 5.19-rc1)
Merging devfreq/devfreq-next (f2906aa86338 Linux 5.19-rc1)
Merging opp/opp/linux-next (acf77c478ca4 OPP: Use generic key finding helpe=
rs for bandwidth key)
Merging thermal/thermal/linux-next (72b3fc61c752 thermal: k3_j72xx_bandgap:=
 Add the bandgap driver support)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (8e51ec6146fd dlm: use kref_put_lock in __put_lkb)
Merging rdma/for-next (158e71bb69e3 RDMA/mlx5: Add a umr recovery flow)
Merging net-next/master (a84a434baf94 net: constify some inline functions i=
n sock.h)
Merging bpf-next/for-next (d352bd889b6a Merge branch 'bpf: Add 64bit enum v=
alue support')
Merging ipsec-next/master (0f9008e5c510 Merge  branch 'Be explicit with XFR=
M offload direction')
Merging mlx5-next/mlx5-next (f2906aa86338 Linux 5.19-rc1)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (0c7b27616fbd selftests: netfilter: add fib expres=
sion forward test case)
Merging bluetooth/master (0b537674e072 Bluetooth: use memset avoid memory l=
eaks)
Merging wireless-next/for-next (85393ca610de wifi: rtw89: support MULTI_BSS=
ID and correct BSSID mask of H2C)
Merging mtd/mtd/next (2c51d0d88020 Merge tag 'nand/for-5.19' into mtd/next)
Merging nand/nand/next (6a2277a0ebe7 mtd: rawnand: renesas: Use runtime PM =
instead of the raw clock API)
Merging spi-nor/spi-nor/next (c47452194641 mtd: spi-nor: debugfs: fix forma=
t specifier)
Merging crypto/master (e4e62bbc6aba hwrng: omap3-rom - fix using wrong clk_=
disable() in omap_rom_rng_runtime_resume())
Merging drm/drm-next (f2906aa86338 Linux 5.19-rc1)
Merging drm-misc/for-linux-next (5ee8c8f930ba drm/rockchip: Change register=
 space names in vop2)
Merging amdgpu/drm-next (64f6516e60b0 drm/amdgpu: always flush the TLB on g=
fx8)
$ git reset --hard HEAD^
Merging next-20220601 version of amdgpu
Merging drm-intel/for-linux-next (24b8b74eb2eb drm/i915: Parse max link rat=
e from the eDP BDB block)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dm=
c_regs.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gt/intel_rps.c
Merging drm-tegra/drm/tegra/for-next (b53c24f69199 drm/tegra: Support YVYU,=
 VYUY and YU24 formats)
Merging drm-msm/msm-next (24df12013853 MAINTAINERS: Add Dmitry as MSM DRM d=
river co-maintainer)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (2829a9fcb738 drm/etnaviv: reap idle softpin m=
appings when necessary)
Merging fbdev/for-next (f1b03cf05746 fbcon: Fix accelerated fbdev scrolling=
 while logo is still shown)
Merging regmap/for-next (687e2ae18602 Merge remote-tracking branch 'regmap/=
for-5.20' into regmap-next)
Merging sound/for-next (5f3d696eea91 ALSA: hda/realtek: Add quirk for HP De=
v One)
Merging sound-asoc/for-next (bfbf93f35479 Merge remote-tracking branch 'aso=
c/for-5.20' into asoc-next)
Merging modules/modules-next (7390b94a3c2d module: merge check_exported_sym=
bol() into find_exported_symbol_in_section())
Merging input/next (69cf890d8b28 Input: mtk-pmic-keys - move long press deb=
ounce mask to mtk_pmic_regs)
Merging block/for-next (75d6654eb3ab Merge branch 'for-5.19/block' into for=
-next)
Merging device-mapper/for-next (4caae58406f8 dm verity: set DM_TARGET_IMMUT=
ABLE feature flag)
Merging libata/for-next (d326e046e3a5 ata: libata-core: fix sloppy typing i=
n ata_id_n_sectors())
Merging pcmcia/pcmcia-next (2ef4bb24ff39 pcmcia: Use platform_get_irq() to =
get the interrupt)
Merging mmc/next (6aa26be14d2a dt-bindings: mmc: renesas,sdhi: Document R-C=
ar S4-8 and generic Gen4 support)
Merging mfd/for-mfd-next (f93afd8e7567 dt-bindings: cros-ec: Fix a typo in =
description)
Merging backlight/for-backlight-next (023a8830a628 backlight: backlight: Sl=
ighly simplify devm_of_find_backlight())
Merging battery/for-next (f2906aa86338 Linux 5.19-rc1)
Merging regulator/for-next (aa3562673c25 Merge remote-tracking branch 'regu=
lator/for-5.20' into regulator-next)
Merging security/next-testing (047843bdb316 Merge branch 'landlock_lsm_v34'=
 into next-testing)
Merging apparmor/apparmor-next (c2489617b3b9 apparmor: Fix undefined refere=
nce to `zlib_deflate_workspacesize')
CONFLICT (content): Merge conflict in security/apparmor/policy_unpack_test.c
Merging integrity/next-integrity (048ae41bb080 integrity: Fix sparse warnin=
gs in keyring_handler)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (4d3d0ed60ee0 selinux: drop unnecessary NULL check)
Merging smack/next (ba6b652bd863 smack: Remove redundant assignments)
Merging tomoyo/master (f2906aa86338 Linux 5.19-rc1)
Merging tpmdd/next (dda5384313a4 KEYS: trusted: tpm2: Fix migratable logic)
Merging watchdog/master (5d24df3d6908 watchdog: ts4800_wdt: Fix refcount le=
ak in ts4800_wdt_probe)
Merging iommu/next (b0dacee202ef Merge branches 'apple/dart', 'arm/mediatek=
', 'arm/msm', 'arm/smmu', 'ppc/pamu', 'x86/vt-d', 'x86/amd' and 'vfio-notif=
ier-fix' into next)
Merging audit/next (5ee6cfdd11aa audit: remove redundant data_len check)
Merging devicetree/for-next (cbf9c4b9617b of: check previous kernel's ima-k=
exec-buffer against memory bounds)
Merging mailbox/mailbox-for-next (79f9fbe30352 mailbox: qcom-ipcc: Fix -Wun=
used-function with CONFIG_PM_SLEEP=3Dn)
Merging spi/for-next (762834bd705f Merge remote-tracking branch 'spi/for-5.=
20' into spi-next)
Merging tip/master (23e79f6c0760 Merge branch into tip/master: 'x86/mm')
CONFLICT (content): Merge conflict in arch/x86/Kconfig
CONFLICT (content): Merge conflict in arch/x86/Kconfig
Merging clockevents/timers/drivers/next (ff714ee7191b clocksource/drivers/t=
imer-ti-dm: Add compatible for am6 SoCs)
Merging edac/edac-for-next (92705c9f9956 Merge edac-misc into for-next)
Merging irqchip/irq/irqchip-next (492449ae4f0a Merge branch irq/gic-v3-nmi-=
fixes-5.19 into irq/irqchip-next)
Merging ftrace/for-next (01dca6d03bb3 Merge branch 'trace/for-next-rtla' in=
to trace/for-next)
Merging rcu/rcu/next (504312bb6d39 rcu-tasks: Update comments)
CONFLICT (content): Merge conflict in kernel/rcu/rcu.h
Merging kvm/next (b172862241b4 KVM: x86: PIT: Preserve state of speaker por=
t data bit)
CONFLICT (content): Merge conflict in arch/x86/kvm/x86.c
Merging kvm-arm/next (5c0ad551e9aa Merge branch kvm-arm64/its-save-restore-=
fixes-5.19 into kvmarm-master/next)
Merging kvms390/next (b1edf7f159a6 KVM: s390: selftests: Use TAP interface =
in the reset test)
Merging xen-tip/linux-next (dbac14a5a05f xen: unexport __init-annotated xen=
_xlate_map_ballooned_pages())
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (873a400938b3 workqueue: Fix type of cpu in tra=
ce event)
Merging drivers-x86/for-next (badb81a58b9e platform/x86/intel/ifs: Add CPU_=
SUP_INTEL dependency)
Merging chrome-platform/for-next (8d5976089c97 platform/chrome: cros_ec_com=
mands: Fix syntax errors in comments)
Merging hsi/for-next (43c14f8d18a7 HSI: omap_ssi: Fix refcount leak in ssi_=
probe)
Merging leds/for-next (f2906aa86338 Linux 5.19-rc1)
Merging ipmi/for-next (a508e33956b5 ipmi:ipmb: Fix refcount leak in ipmi_ip=
mb_probe)
Merging driver-core/driver-core-next (f2906aa86338 Linux 5.19-rc1)
Merging usb/usb-next (f2906aa86338 Linux 5.19-rc1)
Merging thunderbolt/next (7ec58378a985 thunderbolt: Add support for Intel R=
aptor Lake)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (f2906aa86338 Linux 5.19-rc1)
Merging tty/tty-next (f2906aa86338 Linux 5.19-rc1)
Merging char-misc/char-misc-next (f2906aa86338 Linux 5.19-rc1)
Applying: fixup for "usb: dwc3: Don't switch OTG -> peripheral if extcon is=
 present"
Merging coresight/next (1adff542d67a coresight: cpu-debug: Replace mutex wi=
th mutex_trylock on panic notifier)
Merging fpga/for-next (a5e3d775d088 fpga: Directly use ida_alloc()/free())
Merging icc/icc-next (3be0ec65fd17 dt-bindings: interconnect: Remove sc7180=
/sdx55 ipa compatibles)
Merging iio/togreg (c321674386d8 iio: adc: rzg2l_adc: Remove unnecessary ch=
annel check from rzg2l_adc_read_label())
Merging phy-next/next (f7fdc4db071f phy: samsung: exynosautov9-ufs: correct=
 TSRV register configurations)
Merging soundwire/next (f2906aa86338 Linux 5.19-rc1)
Merging extcon/extcon-next (51bd0abd873d extcon: fsa9480: Drop no-op remove=
 function)
Merging gnss/gnss-next (f2906aa86338 Linux 5.19-rc1)
Merging vfio/next (421cfe6596f6 vfio: remove VFIO_GROUP_NOTIFY_SET_KVM)
Merging staging/staging-next (3e763d3dc626 staging: r8188eu: use u8, u16 in=
 issue_action_BA prototype)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (f2906aa86338 Linux 5.19-rc1)
Merging cgroup/for-next (5f69a6577bc3 psi: dont alloc memory for psi by def=
ault)
Merging scsi/for-next (5f78d0bdd4aa Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (3fd3a52ca672 scsi: core: iscsi: Directly use ida=
_alloc()/ida_free())
Merging vhost/linux-next (b27ee76c74dc vduse: Fix NULL pointer dereference =
on sysfs access)
Merging rpmsg/for-next (01a1a0c8d456 Merge branches 'rproc-next', 'rpmsg-ne=
xt' and 'hwspinlock-next' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (f2906aa86338 Linux 5.19-rc1)
Merging gpio-intel/for-next (b93a8b2c5161 gpio: dln2: make irq_chip immutab=
le)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (83969805cc71 pinctrl: apple: Use a raw spinlock f=
or the regmap)
Merging pinctrl-intel/for-next (ba79c5e45eec MAINTAINERS: Update Intel pin =
control to Supported)
Merging pinctrl-renesas/renesas-pinctrl (5223c511eb4f pinctrl: renesas: rzg=
2l: Return -EINVAL for pins which have input disabled)
Merging pinctrl-samsung/for-next (c98ebe065e07 pinctrl: samsung: do not use=
 bindings header with constants)
Merging pwm/for-next (3d593b6e80ad pwm: pwm-cros-ec: Add channel type suppo=
rt)
Merging userns/for-next (a58ea318d8b9 Merge of per-namespace-ipc-sysctls-fo=
r-v5.19, kthread-cleanups-for-v5.19, ptrace_stop-cleanup-for-v5.19, and uco=
unt-rlimits-cleanups-for-v5.19 for testing in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (f2906aa86338 Linux 5.19-rc1)
Merging livepatching/for-next (0e11f2076e7f Merge branch 'for-5.19/cleanup'=
 into for-next)
Merging rtc/rtc-next (f2906aa86338 Linux 5.19-rc1)
Merging nvdimm/libnvdimm-for-next (f42e8e5088b9 pmem: implement pmem_recove=
ry_write())
Merging at24/at24/for-next (312310928417 Linux 5.18-rc1)
Merging ntb/ntb-next (e9d0fa5e2482 IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (73a8dbafd31a selftests/seccomp: Fix compi=
le warning when CC=3Dclang)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (f2af60bb7ce2 fsi: Add trace events in initialization path)
Merging slimbus/for-next (4ad3deabeea2 slimbus: messaging: fix typos in com=
ments)
Merging nvmem/for-next (6b291610dd57 nvmem: microchip-otpc: add support)
Merging xarray/main (63b1898fffcd XArray: Disallow sibling entries of nodes)
Merging hyperv/hyperv-next (d27423bf048d hv_balloon: Fix balloon_probe() an=
d balloon_remove() error handling)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (457c42326fb9 RDMA/erdma: Add driver to kernel build enviro=
nment)
Merging kunit/test (f2906aa86338 Linux 5.19-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging kunit-next/kunit (f2906aa86338 Linux 5.19-rc1)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (13b9b814da2d bus: mhi: host: Add support for Foxconn =
T99W373 and T99W368)
Merging memblock/for-next (000605cd1b14 memblock tests: remove completed TO=
DO item)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (34e37b4c432c cxl/port: Enable HDM Capability after valida=
ting DVSEC Ranges)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (75ed63d91940 efi: clean up Kconfig dependencies on CONFIG=
_EFI)
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (6b2d72729581 Merge branches 'slab/for-5.19/stackdepo=
t' and 'slab/for-5.19/refactor' into slab/for-next)
Merging random/master (9efdb19590e8 random: remove rng_has_arch_random())
Merging landlock/next (fdaf9a5840ac Merge tag 'folio-5.19' of git://git.inf=
radead.org/users/willy/pagecache)
Merging rust/rust-next (9a5fe747d99e init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
CONFLICT (content): Merge conflict in Makefile
CONFLICT (content): Merge conflict in include/uapi/linux/android/binder.h
Merging sysctl/sysctl-next (494dcdf46e5c sched: Fix build warning without C=
ONFIG_SYSCTL)
Merging folio/for-next (1ad7b636a136 mm/folio-compat: Remove migration comp=
atibility functions)
Merging execve/for-next/execve (70578ff3367d binfmt_flat: Remove shared lib=
rary support)
Merging bitmap/bitmap-for-next (0dfe54071d7c nodemask: Fix return values to=
 be unsigned)
Merging hte/hte/for-next (5dad4eccd2b4 dt-bindings: timestamp: Correct id p=
ath)
Merging kspp/for-next/kspp (e1d337335207 cfi: Fix __cfi_slowpath_diag RCU u=
sage with cpuidle)
Merging kspp-gustavo/for-next/kspp (f2906aa86338 Linux 5.19-rc1)
Merging mm-stable/mm-stable (f2906aa86338 Linux 5.19-rc1)
Merging mm-nonmm-stable/mm-nonmm-stable (f2906aa86338 Linux 5.19-rc1)
Merging mm/mm-everything (0643e2954b07 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in mm/damon/reclaim.c
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (049c2925d07b Merge branch 'mm-everything' of git://git=
.kernel.org/pub/scm/linux/kernel/git/akpm/mm)

--Sig_/mjG8Ah_8x1FzrnnKVlXeMTm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKhc4YACgkQAVBC80lX
0Gw+tAf/WOMEvr5r6XV4FsWuDLm+uKQhn6ZpfmzZiA1feDUQc2D1wP6vNH/5Niwz
QMPw6l91TQWmjwECfOwemDVVg1LLb6deDn3nUcWe7IYOt2NAGjfAnsFitN+qmXVp
54LVbY2GeTNUu4uKK7eBeNo3Jdpy2hBehDZ98DUXInpPwMuTnxdS+OPJyzRtzmSA
W2IU13UsPIukjonuYI2NrXEodD3FHuJPfSeF5FLiNmQ2I00/wDxBPMJuEIpLxvQh
QK5+WAl+SGAJWWjaoxsAUEYFa0EyKaQRAQ5e9ydXo3xyqLaNVAQoczQFNnU/a+T6
bSvDT/rgZSpWG3VTWchvycLf8D2rdQ==
=E+qr
-----END PGP SIGNATURE-----

--Sig_/mjG8Ah_8x1FzrnnKVlXeMTm--
