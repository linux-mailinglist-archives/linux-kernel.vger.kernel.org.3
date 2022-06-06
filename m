Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD5753E0E4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiFFFFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiFFFFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:05:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A412E59AF;
        Sun,  5 Jun 2022 21:46:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LGgHl1PrFz4xDK;
        Mon,  6 Jun 2022 14:19:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654489187;
        bh=ZgePkaNxMzQsoE0yuZvyGtmYVufxS0FNH5AnfCbRMBQ=;
        h=Date:From:To:Cc:Subject:From;
        b=ARusE5WcBtNW4P0cR4g9KUPoZCf8uv/WCs6NwOYcVkIM0Fr2mT69AZii/N7xHcy6M
         v5yKMLTD5U0LK3OZBQ/NWNrmhp2VUu0+D5KWS14ksISVaKUugybaq18snN8XjiHAVW
         gMQ+EHJNmF74K5OWYN6RpJUexqNy406yJ7s/oGt2pO2oyNNe6f8Ixzw2GKE1B5807p
         3wY779q17E0dj6fnx9aGErB8vXscGTkfoVmkmrIY3yV1m1lhjmLd7eJU6ewIRlHSbC
         e5OT5TQhunVQApu5JdZ0HhweqP1tAOmftVcdoGbA1VOKhG6QFmu1eHkNTFS8ki3u6f
         eY1x0ZwvMwvJw==
Date:   Mon, 6 Jun 2022 14:19:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jun 6
Message-ID: <20220606141946.14ea958e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lx4dH.B2hN_/8F0Fd1UmA6U";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lx4dH.B2hN_/8F0Fd1UmA6U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220603:

The amdgpu tree still had its build failures, so I used the
version from next-20220601 again.

Non-merge commits (relative to Linus' tree): 549
 678 files changed, 93278 insertions(+), 4547 deletions(-)

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

I am currently merging 350 trees (counting Linus' and 94 trees of bug
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
Merging origin/master (f2906aa86338 Linux 5.19-rc1)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging mm-hotfixes/mm-hotfixes-unstable (7bb127ee833a mm: lru_cache_disabl=
e: use synchronize_rcu_expedited)
Merging kbuild-current/fixes (44688ffd111a Merge tag 'objtool-urgent-2022-0=
6-05' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging arc-current/for-curr (c6ed4d84a2c4 ARC: remove redundant READ_ONCE(=
) in cmpxchg loop)
Merging arm-current/fixes (3cfb30199796 ARM: 9197/1: spectre-bhb: fix loop8=
 sequence for Thumb2)
Merging arm64-fixes/for-next/fixes (1d0cb4c8864a arm64: mte: Ensure the cle=
ared tags are visible before setting the PTE)
Merging arm-soc-fixes/arm/fixes (609a097f5f06 Merge tag 'v5.18-rockchip-dts=
fixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockch=
ip into arm/fixes)
Merging drivers-memory-fixes/fixes (73039c6c7f36 memory: renesas-rpc-if: Fi=
x HF/OSPI data transfer in Manual Mode)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (30b5e6ef4a32 m68k: atari: Make Atari ROM po=
rt I/O write macros return void)
Merging powerpc-fixes/fixes (3e8635fb2e07 powerpc/kasan: Force thread size =
increase with KASAN)
Merging s390-fixes/fixes (a06afe838308 KVM: s390: vsie/gmap: reduce gmap_rm=
ap overhead)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (58f9d52ff689 Merge tag 'net-5.19-rc1' of git://git.kern=
el.org/pub/scm/linux/kernel/git/netdev/net)
Merging bpf/master (d08af2c46881 bpf: Use safer kvmalloc_array() where poss=
ible)
Merging ipsec/master (f85daf0e7253 xfrm: xfrm_policy: fix a possible double=
 xfrm_pols_put() in xfrm_bundle_lookup())
Merging netfilter/master (7fb0269720d7 Merge tag 'for-net-2022-05-23' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth)
Merging ipvs/master (05ae2fba821c netfilter: nft_socket: make cgroup match =
work in input too)
Merging wireless/for-next (58f9d52ff689 Merge tag 'net-5.19-rc1' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging rdma-fixes/for-rc (c5eb0a61238d Linux 5.18-rc6)
Merging sound-current/for-linus (672362cbe6df Merge tag 'asoc-fix-v5.19-rc0=
' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for=
-linus)
Merging sound-asoc-fixes/for-linus (bf0fd5eace2c Merge remote-tracking bran=
ch 'asoc/for-5.18' into asoc-linus)
Merging regmap-fixes/for-linus (312310928417 Linux 5.18-rc1)
Merging regulator-fixes/for-linus (e4296f8578b5 Merge remote-tracking branc=
h 'regulator/for-5.18' into regulator-linus)
Merging spi-fixes/for-linus (ebf2a3521738 spi: core: Display return code wh=
en failing to transfer message)
Merging pci-current/for-linus (833e53a4ffe9 MAINTAINERS: Update Lorenzo Pie=
ralisi's email address)
Merging driver-core.current/driver-core-linus (032dcf09e2bf Merge tag 'gpio=
-fixes-for-v5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl=
/linux)
Merging tty.current/tty-linus (032dcf09e2bf Merge tag 'gpio-fixes-for-v5.19=
-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux)
Merging usb.current/usb-linus (032dcf09e2bf Merge tag 'gpio-fixes-for-v5.19=
-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (42226c989789 Linux 5.18-rc7)
Merging phy/fixes (2c8045d48dee phy: amlogic: fix error path in phy_g12a_us=
b3_pcie_probe())
Merging staging.current/staging-linus (032dcf09e2bf Merge tag 'gpio-fixes-f=
or-v5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux)
Merging iio-fixes/fixes-togreg (dee61a0ffff5 iio: adc: vf610: fix conversio=
n mode sysfs node name)
Merging counter-fixes/fixes-togreg (ce522ba9ef7e Linux 5.18-rc2)
Merging char-misc.current/char-misc-linus (032dcf09e2bf Merge tag 'gpio-fix=
es-for-v5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/lin=
ux)
Merging soundwire-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging thunderbolt-fixes/fixes (4b0986a3613c Linux 5.18)
Merging input-current/for-linus (5f92df8ddacb Input: raspberrypi-ts - add m=
issing HAS_IOMEM dependency)
Merging crypto-current/master (e4e62bbc6aba hwrng: omap3-rom - fix using wr=
ong clk_disable() in omap_rom_rng_runtime_resume())
Merging vfio-fixes/for-linus (1ef3342a934e vfio/pci: Fix vf_token mechanism=
 when device-specific VF drivers are used)
Merging kselftest-fixes/fixes (e8f0c8965932 selftest/vm: add skip support t=
o mremap_test)
CONFLICT (content): Merge conflict in tools/testing/selftests/vm/run_vmtest=
s.sh
Merging modules-fixes/modules-linus (7390b94a3c2d module: merge check_expor=
ted_symbol() into find_exported_symbol_in_section())
Merging dmaengine-fixes/fixes (b00ed48bb0a7 Merge tag 'dmaengine-5.19-rc1' =
of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (ba7542eb2dd5 mtd: rawnand: qcom: fix memory co=
rruption that causes panic)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (d4cb77112c7b media: isl7998x: select V4L2_FWNO=
DE to fix build error)
Merging reset-fixes/reset/fixes (03cb66463b55 dt-bindings: reset: Add paren=
t "resets" property as optional)
Merging mips-fixes/mips-fixes (f0a6c68f6998 MIPS: Fix CP0 counter erratum d=
etection for R4k CPUs)
Merging at91-fixes/at91-fixes (0c640d9544d0 ARM: dts: at91: fix pinctrl pha=
ndles)
Merging omap-fixes/fixes (46ff3df87215 ARM: dts: logicpd-som-lv: Fix wrong =
pinmuxing on OMAP35)
Merging kvm-fixes/master (17718410388f KVM: Don't null dereference ops->des=
troy)
Merging kvms390-fixes/master (242c04f01377 KVM: s390: selftests: Use TAP in=
terface in the reset test)
Merging hwmon-fixes/hwmon (42226c989789 Linux 5.18-rc7)
Merging nvdimm-fixes/libnvdimm-fixes (d28820419ca3 cxl/pci: Drop shadowed v=
ariable)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (48de4dc26894 Merge branch 'misc-5.18' into =
next-fixes)
Merging vfs-fixes/fixes (fb4554c2232e Fix double fget() in vhost_net_set_ba=
ckend())
Merging dma-mapping-fixes/for-linus (18a3c5f7abfd Merge tag 'for_linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (44acfc22c7d0 platform/surface: aggregator:=
 Fix initialization order when compiling as builtin module)
Merging samsung-krzk-fixes/fixes (436ce66003d5 ARM: s3c: mark as deprecated=
 and schedule removal)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
Merging pinctrl-samsung-fixes/fixes (ac875df4d854 pinctrl: samsung: fix mis=
sing GPIOLIB on ARM64 Exynos config)
Merging devicetree-fixes/dt/linus (987cf300e76d dt-bindings: mtd: spi-nand:=
 Add spi-peripheral-props.yaml reference)
Merging scsi-fixes/fixes (d5d92b644084 scsi: ufs: core: Fix referencing inv=
alid rsp field)
Merging drm-fixes/drm-fixes (4b0986a3613c Linux 5.18)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (4b0986a3613c Linux 5.18)
Merging mmc-fixes/fixes (479260419fa4 dt-bindings: mmc: Fix unevaluatedProp=
erties warnings in examples)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (312310928417 Linux 5.18-rc1)
Merging hyperv-fixes/hyperv-fixes (eaa03d345358 Drivers: hv: vmbus: Replace=
 smp_store_mb() with virt_store_mb())
Merging soc-fsl-fixes/fix (4b0986a3613c Linux 5.18)
Merging risc-v-fixes/fixes (c932edeaf6d6 riscv: dts: microchip: fix gpio1 r=
eg property typo)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging spdx/spdx-linus (032dcf09e2bf Merge tag 'gpio-fixes-for-v5.19-rc1' =
of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux)
Merging gpio-brgl-fixes/gpio/for-current (7bb8a0cf49d5 gpio: adp5588: Remov=
e support for platform setup and teardown callbacks)
Merging gpio-intel-fixes/fixes (0c2cae09a765 gpiolib: acpi: Convert type fo=
r pin to be unsigned)
Merging pinctrl-intel-fixes/fixes (7b923e67a4a7 pinctrl: intel: Fix kernel =
doc format, i.e. add return sections)
Merging erofs-fixes/fixes (8b1ac84dcf2c Documentation/ABI: sysfs-fs-erofs: =
Fix Sphinx errors)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (02c7efa43627 Documentation: kunit: fix pat=
h to .kunitconfig in start.rst)
Merging ubifs-fixes/fixes (c3c07fc25f37 ubi: fastmap: Return error code if =
memory allocation fails in add_aeb())
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (9ff9f77f34e4 MAINTAINERS: reciprocal co-maintaine=
rship for file locking and nfsd)
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
Merging drm-misc-fixes/for-linux-next-fixes (6e516faf0431 drm/panfrost: Job=
 should reference MMU not file_priv)
Merging kbuild/for-next (44688ffd111a Merge tag 'objtool-urgent-2022-06-05'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging clang-format/clang-format (781121a7f6d1 clang-format: Fix space aft=
er for_each macros)
Merging perf/perf/core (1bcca2b1bd67 perf vendor events intel: Update metri=
cs for Alderlake)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (e15db62bc564 swiotlb: fix setting ->force_bou=
nce)
Merging asm-generic/master (b2441b3bdce6 h8300: remove stale bindings and s=
ymlink)
Merging arc/for-next (6aa98f621786 ARC: bpf: define uapi for BPF_PROG_TYPE_=
PERF_EVENT program type)
Merging arm/for-next (d2ca1fd2bc70 ARM: 9207/1: amba: fix refcount underflo=
w if amba_device_add() fails)
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
Merging drivers-memory/for-next (1e2b798e9664 Merge branch 'for-v5.19/tegra=
-mc' into for-next)
Merging imx-mxs/for-next (6ed2affe8f7f Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (8434c5a06e3c Merge branch 'v5.18-next/soc' into =
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
Merging renesas/next (7ae962c56cea Merge branch 'renesas-arm-dt-for-v5.19' =
into renesas-next)
Merging reset/reset/next (2ca065dc9468 dt-bindings: reset: st,sti-powerdown=
: Convert to yaml)
Merging rockchip/for-next (09711f1d1f03 Merge branch 'v5.19-clk/next' into =
for-next)
Merging samsung-krzk/for-next (88fb0c4d0aff Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (4b0986a3613c Linux 5.18)
Merging stm32/stm32-next (747a29b9a5a5 dt-bindings: clock: stm32mp1: adapt =
example for "st,stm32mp1-rcc-secure")
Merging sunxi/sunxi/for-next (073220ee354d Merge branch 'sunxi/dt-for-5.19'=
 into sunxi/for-next)
Merging tee/next (db30e53bf897 Merge branch 'tee_cleanup_for_v5.19' into ne=
xt)
Merging tegra/for-next (864067632632 Merge branch for-5.19/arm64/defconfig =
into for-next)
Merging ti/ti-next (4cc89036bc4f Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (63623390c0d6 arm64: dts: zynqmp: add AMS driver to=
 device tree)
Merging clk/clk-next (71cc785d2955 Merge branch 'clk-qcom' into clk-next)
Merging clk-imx/for-next (cf7f3f4fa9e5 clk: imx8mp: fix usb_root_clk parent)
Merging clk-renesas/renesas-clk (23426d1be3c2 clk: renesas: r9a09g011: Add =
eth clock and reset entries)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (64d83f067746 csky: Move $(core-y) into arch/csky/K=
build)
Merging loongarch/loongarch-next (8be4493119b0 MAINTAINERS: Add maintainer =
information for LoongArch)
Merging m68k/for-next (30b5e6ef4a32 m68k: atari: Make Atari ROM port I/O wr=
ite macros return void)
Merging m68knommu/for-next (6b8be804ff37 m68knommu: fix 68000 CPU link with=
 no platform selected)
Merging microblaze/next (78b5f52ab6f6 microblaze: fix typos in comments)
Merging mips/mips-next (7e4fd16b3892 MIPS: RALINK: Define pci_remap_iospace=
 under CONFIG_PCI_DRIVERS_GENERIC)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (83da38d82b2f openrisc: Allow power off handler o=
verriding)
Merging parisc-hd/for-next (4b0986a3613c Linux 5.18)
Merging powerpc/next (6112bd00e84e Merge tag 'powerpc-5.19-1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging soc-fsl/next (4b0986a3613c Linux 5.18)
Merging risc-v/for-next (61114e734ccb riscv: Move alternative length valida=
tion into subsection)
Merging s390/for-next (31c0e4c11a0f Merge branch 'features' into for-next)
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
Merging btrfs/for-next (0a05fafe9def btrfs: zoned: introduce a minimal zone=
 size 4M and reject mount)
Merging ceph/master (b24d20af4c2e fscrypt: add fscrypt_context_for_new_inod=
e)
Merging cifs/for-next (d66016c5cd3d Merge tag '5.19-rc-smb3-client-fixes-pa=
rt2' of git://git.samba.org/sfrench/cifs-2.6)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (4398d3c31b58 erofs: fix 'backmost' member of z_erofs_dec=
ompress_frontend)
Merging exfat/dev (64ba4b15e5c0 exfat: check if cluster num is valid)
Merging ext3/for_next (5c905e1a0180 Pull typo fix from Julia Lawall.)
Merging ext4/dev (5f41fdaea63d ext4: only allow test_dummy_encryption when =
supported)
Merging f2fs/dev (2d1fe8a86bf5 f2fs: fix to tag gcing flag on page during f=
ile defragment)
Merging fsverity/fsverity (e6af1bb07704 fs-verity: Use struct_size() helper=
 in enable_verity())
Merging fuse/for-next (6b49bc9d8a5f fuse: avoid unnecessary spinlock bump)
Merging gfs2/for-next (ab37c305bf89 gfs2: Remove redundant NULL check befor=
e kfree)
Merging jfs/jfs-next (e471e5942c00 fs/jfs: Remove dead code)
Merging ksmbd/ksmbd-for-next (e5b020871332 Merge tag '5.19-rc-ksmbd-server-=
fixes' of git://git.samba.org/ksmbd)
Merging nfs/linux-next (42226c989789 Linux 5.18-rc7)
Merging nfs-anna/linux-next (118f09eda21d NFSv4.1 mark qualified async oper=
ations as MOVEABLE tasks)
Merging nfsd/for-next (f012e95b377c SUNRPC: Trap RDMA segment overflows)
Merging ntfs3/master (724bbe49c5e4 fs/ntfs3: provide block_invalidate_folio=
 to fix memory leak)
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
Merging pci/next (32f479d05a44 Merge branch 'remotes/lorenzo/pci/vmd')
Merging pstore/for-next/pstore (8126b1c73108 pstore: Don't use semaphores i=
n always-atomic-context code)
Merging hid/for-next (b01c83388f54 Revert "HID: Driver for Google Hangouts =
Meet Speakermic")
Merging i2c/i2c/for-next (44e66c3bda45 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (66ed42caf286 MAINTAINERS: rectify entries for some i3=
c drivers after dt conversion)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (8877ecb0fc8d hwmon: (aquacomputer_d5next)=
 Fix an error handling path in aqc_probe())
Merging jc_docs/docs-next (a27e51b45e1b documentation: Format button_dev as=
 a pointer.)
Merging v4l-dvb/master (340ce50f75a6 media: hantro: Enable HOLD_CAPTURE_BUF=
 for H.264)
Merging v4l-dvb-next/master (340ce50f75a6 media: hantro: Enable HOLD_CAPTUR=
E_BUF for H.264)
Merging pm/linux-next (473d7985fed1 Merge branch 'pm-sysoff' into linux-nex=
t)
Merging cpufreq-arm/cpufreq/arm/linux-next (39b360102f3a cpufreq: mediatek:=
 Add support for MT8186)
Merging cpupower/cpupower (312310928417 Linux 5.18-rc1)
Merging devfreq/devfreq-next (2e691421a2c9 PM / devfreq: rk3399_dmc: Block =
PMU during transitions)
Merging opp/opp/linux-next (22079af7df5a opp: Reorder definition of ceil/fl=
oor helpers)
Merging thermal/thermal/linux-next (72b3fc61c752 thermal: k3_j72xx_bandgap:=
 Add the bandgap driver support)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (8e51ec6146fd dlm: use kref_put_lock in __put_lkb)
Merging rdma/for-next (9c477178a0a1 RDMA/rtrs-clt: Fix one kernel-doc comme=
nt)
Merging net-next/master (58f9d52ff689 Merge tag 'net-5.19-rc1' of git://git=
.kernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging bpf-next/for-next (7e062cda7d90 Merge tag 'net-next-5.19' of git://=
git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging ipsec-next/master (0f9008e5c510 Merge  branch 'Be explicit with XFR=
M offload direction')
Merging mlx5-next/mlx5-next (846e437387e7 net/mlx5: Expose mlx5_sriov_block=
ing_notifier_register / unregister APIs)
Merging netfilter-next/master (677fb7525331 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/netdev/net)
Merging ipvs-next/master (0c7b27616fbd selftests: netfilter: add fib expres=
sion forward test case)
Merging bluetooth/master (a589ee43644c Bluetooth: hci_bcm: Add BCM4349B1 va=
riant)
Merging wireless-next/for-next (805cb5aadc2a Merge git://git.kernel.org/pub=
/scm/linux/kernel/git/netfilter/nf-next)
Merging mtd/mtd/next (2c51d0d88020 Merge tag 'nand/for-5.19' into mtd/next)
Merging nand/nand/next (6a2277a0ebe7 mtd: rawnand: renesas: Use runtime PM =
instead of the raw clock API)
Merging spi-nor/spi-nor/next (c47452194641 mtd: spi-nor: debugfs: fix forma=
t specifier)
Merging crypto/master (e4e62bbc6aba hwrng: omap3-rom - fix using wrong clk_=
disable() in omap_rom_rng_runtime_resume())
Merging drm/drm-next (404204340c0d Merge tag 'drm/tegra/for-5.19-prep-work'=
 of https://gitlab.freedesktop.org/drm/tegra into drm-next)
Merging drm-misc/for-linux-next (5ee8c8f930ba drm/rockchip: Change register=
 space names in vop2)
Merging amdgpu/drm-next (0401cdad37f8 drm/amdgpu/display: Protect some func=
tions with CONFIG_DRM_AMD_DC_DCN)
$ git reset --hard HEAD^
Merging next-20220601 version of amdgpu
Merging drm-intel/for-linux-next (0ea917819d12 drm/i915/dsi: fix VBT send p=
acket port selection for ICL+)
Merging drm-tegra/drm/tegra/for-next (b53c24f69199 drm/tegra: Support YVYU,=
 VYUY and YU24 formats)
Merging drm-msm/msm-next (24df12013853 MAINTAINERS: Add Dmitry as MSM DRM d=
river co-maintainer)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (2829a9fcb738 drm/etnaviv: reap idle softpin m=
appings when necessary)
Merging fbdev/for-next (17d9c905ecb7 fbcon: Fix accelerated fbdev scrolling=
 while logo is still shown)
Merging regmap/for-next (5c422f0b970d regmap: Add missing map->bus check)
Merging sound/for-next (672362cbe6df Merge tag 'asoc-fix-v5.19-rc0' of http=
s://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus)
Merging sound-asoc/for-next (bf0fd5eace2c Merge remote-tracking branch 'aso=
c/for-5.18' into asoc-linus)
Merging modules/modules-next (7390b94a3c2d module: merge check_exported_sym=
bol() into find_exported_symbol_in_section())
Merging input/next (69cf890d8b28 Input: mtk-pmic-keys - move long press deb=
ounce mask to mtk_pmic_regs)
Merging block/for-next (75d6654eb3ab Merge branch 'for-5.19/block' into for=
-next)
Merging device-mapper/for-next (4caae58406f8 dm verity: set DM_TARGET_IMMUT=
ABLE feature flag)
Merging libata/for-next (f2906aa86338 Linux 5.19-rc1)
Merging pcmcia/pcmcia-next (2ef4bb24ff39 pcmcia: Use platform_get_irq() to =
get the interrupt)
Merging mmc/next (ded2c4c34500 mmc: sdhci-of-arasan: Add NULL check for dat=
a field)
Merging mfd/for-mfd-next (f93afd8e7567 dt-bindings: cros-ec: Fix a typo in =
description)
Merging backlight/for-backlight-next (023a8830a628 backlight: backlight: Sl=
ighly simplify devm_of_find_backlight())
Merging battery/for-next (da50aad6d867 Merge power-supply 'fixes' branch)
Merging regulator/for-next (e4296f8578b5 Merge remote-tracking branch 'regu=
lator/for-5.18' into regulator-linus)
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
Merging selinux/next (1af0e4a0233f security: declare member holding string =
literal const)
Merging smack/next (ba6b652bd863 smack: Remove redundant assignments)
Merging tomoyo/master (3b8d1c0d6306 workqueue: Wrap flush_workqueue() using=
 a macro)
Merging tpmdd/next (7f3113e3b9f7 MAINTAINERS: add KEYS-TRUSTED-CAAM)
Merging watchdog/master (5d24df3d6908 watchdog: ts4800_wdt: Fix refcount le=
ak in ts4800_wdt_probe)
Merging iommu/next (b0dacee202ef Merge branches 'apple/dart', 'arm/mediatek=
', 'arm/msm', 'arm/smmu', 'ppc/pamu', 'x86/vt-d', 'x86/amd' and 'vfio-notif=
ier-fix' into next)
Merging audit/next (312310928417 Linux 5.18-rc1)
Merging devicetree/for-next (d036d915b61f of/irq: fix typo in comment)
Merging mailbox/mailbox-for-next (79f9fbe30352 mailbox: qcom-ipcc: Fix -Wun=
used-function with CONFIG_PM_SLEEP=3Dn)
Merging spi/for-next (ebf2a3521738 spi: core: Display return code when fail=
ing to transfer message)
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
Merging rcu/rcu/next (409db57c8d45 Merge branch 'lkmm.2022.05.03a' into HEA=
D)
Merging kvm/next (85165781c5d9 KVM: Do not pin pages tracked by gfn=3D>pfn =
caches)
Merging kvm-arm/next (5c0ad551e9aa Merge branch kvm-arm64/its-save-restore-=
fixes-5.19 into kvmarm-master/next)
Merging kvms390/next (b1edf7f159a6 KVM: s390: selftests: Use TAP interface =
in the reset test)
Merging xen-tip/linux-next (41925b105e34 xen: replace xen_remap() with memr=
emap())
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (10a5a651e3af workqueue: Restrict kworker in th=
e offline CPU pool running on housekeeping CPUs)
Merging drivers-x86/for-next (badb81a58b9e platform/x86/intel/ifs: Add CPU_=
SUP_INTEL dependency)
Merging chrome-platform/for-next (abd4fd43f2af platform/chrome: Use imperat=
ive mood for ChromeOS ACPI sysfs ABI descriptions)
Merging hsi/for-next (43c14f8d18a7 HSI: omap_ssi: Fix refcount leak in ssi_=
probe)
Merging leds/for-next (e98a860f6542 leds: qcom-lpg: Require pattern to foll=
ow documentation)
Merging ipmi/for-next (a508e33956b5 ipmi:ipmb: Fix refcount leak in ipmi_ip=
mb_probe)
Merging driver-core/driver-core-next (032dcf09e2bf Merge tag 'gpio-fixes-fo=
r-v5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux)
Merging usb/usb-next (032dcf09e2bf Merge tag 'gpio-fixes-for-v5.19-rc1' of =
git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux)
Merging thunderbolt/next (c7c99a09ef0e thunderbolt: Add KUnit test for devi=
ces with no DisplayPort adapters)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (33b7af2f459d USB: serial: option: add Quectel =
BG95 modem)
Merging tty/tty-next (032dcf09e2bf Merge tag 'gpio-fixes-for-v5.19-rc1' of =
git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux)
Merging char-misc/char-misc-next (032dcf09e2bf Merge tag 'gpio-fixes-for-v5=
.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux)
Applying: fixup for "usb: dwc3: Don't switch OTG -> peripheral if extcon is=
 present"
Merging coresight/next (1adff542d67a coresight: cpu-debug: Replace mutex wi=
th mutex_trylock on panic notifier)
Merging fpga/for-next (ae23f746d744 fpga: dfl: Allow Port to be linked to F=
ME's DFL)
Merging icc/icc-next (3be0ec65fd17 dt-bindings: interconnect: Remove sc7180=
/sdx55 ipa compatibles)
Merging iio/togreg (c321674386d8 iio: adc: rzg2l_adc: Remove unnecessary ch=
annel check from rzg2l_adc_read_label())
Merging phy-next/next (d413a34932f9 phy: qcom-qmp: rename error labels)
Merging soundwire/next (74da272400b4 soundwire: qcom: adjust autoenumeratio=
n timeout)
Merging extcon/extcon-next (5dcc2afe716d extcon: Modify extcon device to be=
 created after driver data is set)
Merging gnss/gnss-next (312310928417 Linux 5.18-rc1)
Merging vfio/next (421cfe6596f6 vfio: remove VFIO_GROUP_NOTIFY_SET_KVM)
Merging staging/staging-next (032dcf09e2bf Merge tag 'gpio-fixes-for-v5.19-=
rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (b00ed48bb0a7 Merge tag 'dmaengine-5.19-rc1' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine)
Merging cgroup/for-next (8a4f243bd5cf Merge branch 'for-5.19' into for-next)
Merging scsi/for-next (5f78d0bdd4aa Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (aa2a4ded0505 scsi: qla2xxx: Remove unused 'ql_dm=
_tgt_ex_pct' parameter)
Merging vhost/linux-next (bd8bb9aed56b vdpa: ifcvf: set pci driver data in =
probe)
Merging rpmsg/for-next (01a1a0c8d456 Merge branches 'rproc-next', 'rpmsg-ne=
xt' and 'hwspinlock-next' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (5a7cb9f3978d gpio: sifive: Make the irqchi=
p immutable)
Merging gpio-intel/for-next (edc5601db664 pinctrl: meson: Replace custom co=
de by gpiochip_node_count() call)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (83969805cc71 pinctrl: apple: Use a raw spinlock f=
or the regmap)
Merging pinctrl-intel/for-next (7b923e67a4a7 pinctrl: intel: Fix kernel doc=
 format, i.e. add return sections)
Merging pinctrl-renesas/renesas-pinctrl (fc883ed5a43e pinctrl: renesas: che=
cker: Add reserved field checks)
Merging pinctrl-samsung/for-next (ac875df4d854 pinctrl: samsung: fix missin=
g GPIOLIB on ARM64 Exynos config)
Merging pwm/for-next (3d593b6e80ad pwm: pwm-cros-ec: Add channel type suppo=
rt)
Merging userns/for-next (a58ea318d8b9 Merge of per-namespace-ipc-sysctls-fo=
r-v5.19, kthread-cleanups-for-v5.19, ptrace_stop-cleanup-for-v5.19, and uco=
unt-rlimits-cleanups-for-v5.19 for testing in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (15477b31db10 kselftests/ir : Improve readability of=
 modprobe error message)
Merging livepatching/for-next (0e11f2076e7f Merge branch 'for-5.19/cleanup'=
 into for-next)
Merging rtc/rtc-next (f78e3d407a33 rtc: mxc: Silence a clang warning)
Merging nvdimm/libnvdimm-for-next (f42e8e5088b9 pmem: implement pmem_recove=
ry_write())
Merging at24/at24/for-next (312310928417 Linux 5.18-rc1)
Merging ntb/ntb-next (e9d0fa5e2482 IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (73a8dbafd31a selftests/seccomp: Fix compi=
le warning when CC=3Dclang)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (f2af60bb7ce2 fsi: Add trace events in initialization path)
Merging slimbus/for-next (54bf672111ee slimbus: qcom: Fix IRQ check in qcom=
_slim_probe)
CONFLICT (content): Merge conflict in drivers/slimbus/qcom-ctrl.c
Merging nvmem/for-next (0f07cbb92a28 nvmem: sfp: Add support for TA 2.1 dev=
ices)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging xarray/main (63b1898fffcd XArray: Disallow sibling entries of nodes)
Merging hyperv/hyperv-next (d27423bf048d hv_balloon: Fix balloon_probe() an=
d balloon_remove() error handling)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (312310928417 Linux 5.18-rc1)
Merging kunit/test (312310928417 Linux 5.18-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging kunit-next/kunit (e7eaffce47b7 kunit: tool: Use qemu-system-i386 fo=
r i386 runs)
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
Merging random/master (aa22d6955596 crc-itu-t: fix typo in CRC ITU-T polyno=
mial comment)
Merging landlock/next (fdaf9a5840ac Merge tag 'folio-5.19' of git://git.inf=
radead.org/users/willy/pagecache)
Merging rust/rust-next (9a5fe747d99e init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
CONFLICT (content): Merge conflict in Makefile
CONFLICT (content): Merge conflict in include/uapi/linux/android/binder.h
Merging sysctl/sysctl-next (494dcdf46e5c sched: Fix build warning without C=
ONFIG_SYSCTL)
Merging folio/for-next (516edb456f12 nilfs2: Fix some kernel-doc comments)
Merging execve/for-next/execve (70578ff3367d binfmt_flat: Remove shared lib=
rary support)
Merging bitmap/bitmap-for-next (0dfe54071d7c nodemask: Fix return values to=
 be unsigned)
Merging hte/hte/for-next (5dad4eccd2b4 dt-bindings: timestamp: Correct id p=
ath)
Merging kspp/for-next/kspp (e1d337335207 cfi: Fix __cfi_slowpath_diag RCU u=
sage with cpuidle)
Merging kspp-gustavo/for-next/kspp (0cf2b91d74b7 Merge branch 'for-next/ksp=
p-stringop-overflow' into for-next/kspp)
Merging mm-stable/mm-stable (54eb8462f21f Merge tag 'rtc-5.19' of git://git=
.kernel.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging mm-nonmm-stable/mm-nonmm-stable (662ce1dc9caf delayacct: track dela=
ys from write-protect copy)
Merging mm/mm-everything (5540d9164158 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (202693ac55e0 Merge branch 'mm-everything' of git://git=
.kernel.org/pub/scm/linux/kernel/git/akpm/mm)

--Sig_/lx4dH.B2hN_/8F0Fd1UmA6U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKdgGIACgkQAVBC80lX
0Gzs6wgAlLuNc2ObfHgze+zYzj2Y/KveQ+w4UUYDVkeQhxt0y77HPGz7dbAJc0AO
ywDo1EVYbnMLjSvMpUV86ugSDMFlB1ZQKZQHB2gyog6heX3klRLQNLAoaPV0nlNg
l/R+I6HPohppx0qaGd/96oFosk4iA+41HThJD3rPN4Td/gRDgo2eMq9OITHTGgDV
u67nmzNaW136iiT+fryD80gIyO4gIHAUjfQjkR5X1iG5xLXC4pFSrodzTii5jlvL
R6XB3VdJEfVSX4QvZq62d+1BNnMxWqERw93bPfIyjAX2nKbP3/F3Fd0g72VbDnf6
gtWdKMiDjUdCsVi27HJSfDwMN7o9uA==
=k9hh
-----END PGP SIGNATURE-----

--Sig_/lx4dH.B2hN_/8F0Fd1UmA6U--
