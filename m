Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBD852CFB1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbiESJtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiESJt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:49:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7A26A437;
        Thu, 19 May 2022 02:49:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L3lSM3bKgz4xD8;
        Thu, 19 May 2022 19:49:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652953763;
        bh=Sx1IhYXelHBrVD+4l9M1K3zhRUNRt1plGzrwPprv6nc=;
        h=Date:From:To:Cc:Subject:From;
        b=b5GcfBdEbpxMGwex9kqk1weDTL0knemuJLdMitX3+kFStYhZtnyuPtBpdl28msVTi
         NiBJrOYpY8myXnBTY8volvbuq3zwqc0jT4f4q0mflNF3DEsGBSFvD2jRbkV/+1Y5bs
         zicVkf8zr7SG4dkaXaG0lGoSC6gZH5uCeGIrg9BYCvIDmBsjXUS0lzsZuzTexgjSb7
         jYMWEJqlHEhpWUJvIbsPByZTGfQqxHueDT5UcyR6jlQIc5t5e+HLiRdjxlHObLNI9q
         Lup5yoJFg6c8ZyWw0N49LDBV7caHjqVhDzif+otY7toqbnPZpKHjGGZi2pROa7525f
         GHKu/fgHDPHbA==
Date:   Thu, 19 May 2022 19:49:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for May 19
Message-ID: <20220519194922.5d1bac4a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KQqv9pgJRplOr4.vNtEMCKl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KQqv9pgJRplOr4.vNtEMCKl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220518:

New tree: loongarch

The pm tree gained a conflict against the loongarch tree.

The rdma tree gained a conflict against the net tree.

The net-next tree gained conflicts against the net tree.

The net-next tree still had its build failure for which I applied a patch.

Non-merge commits (relative to Linus' tree): 11762
 11668 files changed, 987242 insertions(+), 238438 deletions(-)

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

I am currently merging 349 trees (counting Linus' and 94 trees of bug
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
Merging origin/master (ef1302160bfb Merge tag 'sound-5.18' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/tiwai/sound)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging mm-hotfixes/mm-hotfixes-unstable (e7f37494f11f assoc_array: Fix BUG=
_ON during garbage collect)
Merging kbuild-current/fixes (312310928417 Linux 5.18-rc1)
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
Merging m68k-current/for-linus (0d52a01a266b m68k: defconfig: Disable fbdev=
 on Sun3/3x)
Merging powerpc-fixes/fixes (ee8348496c77 KVM: PPC: Book3S PR: Enable MSR_D=
R for switch_mmu_context())
Merging s390-fixes/fixes (a06afe838308 KVM: s390: vsie/gmap: reduce gmap_rm=
ap overhead)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (6fd45e79e8b9 net: ftgmac100: Disable hardware checksum =
on AST2600)
Merging bpf/master (f3f19f939c11 Merge tag 'net-5.18-rc7' of git://git.kern=
el.org/pub/scm/linux/kernel/git/netdev/net)
Merging ipsec/master (015c44d7bff3 net: af_key: check encryption module ava=
ilability consistency)
Merging netfilter/master (05ae2fba821c netfilter: nft_socket: make cgroup m=
atch work in input too)
Merging ipvs/master (05ae2fba821c netfilter: nft_socket: make cgroup match =
work in input too)
Merging wireless/main (a36e07dfe6ee rfkill: uapi: fix RFKILL_IOCTL_MAX_SIZE=
 ioctl request definition)
Merging rdma-fixes/for-rc (c5eb0a61238d Linux 5.18-rc6)
Merging sound-current/for-linus (5c62383c0683 ALSA: usb-audio: Restore Rane=
 SL-1 quirk)
Merging sound-asoc-fixes/for-linus (a681e9423ecf Merge remote-tracking bran=
ch 'asoc/for-5.17' into asoc-linus)
Merging regmap-fixes/for-linus (312310928417 Linux 5.18-rc1)
Merging regulator-fixes/for-linus (b11b3d21a94d regulator: qcom_smd: Fix up=
 PM8950 regulator configuration)
Merging spi-fixes/for-linus (0cf8d32600cf spi: stm32-qspi: Always check SR_=
TCF flags in stm32_qspi_wait_cmd())
Merging pci-current/for-linus (4246970a3bcb Revert "PCI: brcmstb: Split brc=
m_pcie_setup() into two funcs")
Merging driver-core.current/driver-core-linus (42226c989789 Linux 5.18-rc7)
Merging tty.current/tty-linus (42226c989789 Linux 5.18-rc7)
Merging usb.current/usb-linus (42226c989789 Linux 5.18-rc7)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (42226c989789 Linux 5.18-rc7)
Merging phy/fixes (2c8045d48dee phy: amlogic: fix error path in phy_g12a_us=
b3_pcie_probe())
Merging staging.current/staging-linus (ce522ba9ef7e Linux 5.18-rc2)
Merging iio-fixes/fixes-togreg (ecdde8bf6e6a iio: gyro: mpu3050: Fix the er=
ror handling in mpu3050_power_up())
Merging counter-fixes/fixes-togreg (ce522ba9ef7e Linux 5.18-rc2)
Merging char-misc.current/char-misc-linus (42226c989789 Linux 5.18-rc7)
Merging soundwire-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging thunderbolt-fixes/fixes (42226c989789 Linux 5.18-rc7)
Merging input-current/for-linus (b26ff9137183 Input: ili210x - use one comm=
on reset implementation)
Merging crypto-current/master (16287397ec5c crypto: qcom-rng - fix infinite=
 loop on requests not multiple of WORD_SZ)
Merging vfio-fixes/for-linus (1ef3342a934e vfio/pci: Fix vf_token mechanism=
 when device-specific VF drivers are used)
Merging kselftest-fixes/fixes (e8f0c8965932 selftest/vm: add skip support t=
o mremap_test)
Merging modules-fixes/modules-linus (dc0ce6cc4b13 lib/test: use after free =
in register_test_dev_kmod())
Merging dmaengine-fixes/fixes (7495a5bbf89f dt-bindings: dmaengine: qcom: g=
pi: Add minItems for interrupts)
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
Merging kvm-fixes/master (6f5adb35045d Merge tag 'kvmarm-fixes-5.18-3' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD)
Merging kvms390-fixes/master (4aa5ac75bf79 KVM: s390: Fix lockdep issue in =
vm memop)
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
Merging pinctrl-samsung-fixes/fixes (ac875df4d854 pinctrl: samsung: fix mis=
sing GPIOLIB on ARM64 Exynos config)
Merging devicetree-fixes/dt/linus (5dc463042651 dt-bindings: pci: apple,pci=
e: Drop max-link-speed from example)
Merging scsi-fixes/fixes (525f447f88b1 scsi: target: Fix incorrect use of c=
pumask_t)
Merging drm-fixes/drm-fixes (42226c989789 Linux 5.18-rc7)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (89e96d822bd5 i915/guc/reset: =
Make __guc_reset_context aware of guilty engines)
Merging mmc-fixes/fixes (da842020c3d1 mmc: core: Fix busy polling for MMC_S=
END_OP_COND again)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (312310928417 Linux 5.18-rc1)
Merging hyperv-fixes/hyperv-fixes (eaa03d345358 Drivers: hv: vmbus: Replace=
 smp_store_mb() with virt_store_mb())
Merging soc-fsl-fixes/fix (a222fd854139 soc: fsl: qe: Check of ioremap retu=
rn value)
Merging risc-v-fixes/fixes (c6fe81191bd7 RISC-V: relocate DTB if it's outsi=
de memory region)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging spdx/spdx-linus (e0208351383c scripts/spdxcheck: Exclude top-level =
README)
Merging gpio-brgl-fixes/gpio/for-current (0d7e3da09a4d gpio: mvebu/pwm: Ref=
use requests with inverted polarity)
Merging gpio-intel-fixes/fixes (0c2cae09a765 gpiolib: acpi: Convert type fo=
r pin to be unsigned)
Merging pinctrl-intel-fixes/fixes (0be0b70df661 pinctrl: alderlake: Fix reg=
ister offsets for ADL-N variant)
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
Merging cel-fixes/for-rc (c5eb0a61238d Linux 5.18-rc6)
Merging irqchip-fixes/irq/irqchip-fixes (544808f7e21c irqchip/gic, gic-v3: =
Prevent GSI to SGI translations)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (42226c989789 Linux 5.18-rc7)
Merging efi-fixes/urgent (9feaf8b387ee efi: fix return value of __setup han=
dlers)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging drm-misc-fixes/for-linux-next-fixes (6e03b13cc7d9 drm/dp/mst: fix a=
 possible memory leak in fetch_monitor_name())
Merging kbuild/for-next (2a66c3124afd modpost: change the license of EXPORT=
_SYMBOL to bool type)
Merging perf/perf/core (6a973e291978 perf test: Add basic stat and topdown =
group test)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (82806744fd7d swiotlb: max mapping size takes =
min align mask into account)
Merging asm-generic/master (678e9c3a9389 Merge branch 'asm-generic-headers-=
cleanup' into asm-generic)
CONFLICT (modify/delete): Documentation/devicetree/bindings/memory-controll=
ers/renesas,h8300-bsc.yaml deleted in asm-generic/master and modified in HE=
AD.  Version HEAD of Documentation/devicetree/bindings/memory-controllers/r=
enesas,h8300-bsc.yaml left in tree.
$ git rm -f Documentation/devicetree/bindings/memory-controllers/renesas,h8=
300-bsc.yaml
Merging arc/for-next (6aa98f621786 ARC: bpf: define uapi for BPF_PROG_TYPE_=
PERF_EVENT program type)
Merging arm/for-next (98da7476882a Merge branches 'misc' and 'fixes' into f=
or-next)
Merging arm64/for-next/core (f3db1da5744b Merge branches 'for-next/sme' and=
 'for-next/misc' into for-next/core)
Merging arm-perf/for-next/perf (c5781212985a perf/arm-cmn: Decode CAL devic=
es properly in debugfs)
Merging arm-soc/for-next (2b7d17d4b7c1 soc: document merges)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (ed532523b458 Merge branch 'v5.18/fixes' into for-=
next)
Merging aspeed/for-next (d9540eeaa3d1 Merge branches 'nuvoton-dt-for-v5.18'=
 and 'dt-for-v5.18' into for-next)
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
Merging qcom/for-next (b0362ef88de4 Merge branches 'arm64-for-5.19', 'arm64=
-defconfig-for-5.19', 'clk-for-5.19', 'defconfig-for-5.19', 'drivers-for-5.=
19', 'dts-for-5.19' and 'arm64-fixes-for-5.18' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (7ae962c56cea Merge branch 'renesas-arm-dt-for-v5.19' =
into renesas-next)
Merging reset/reset/next (2ca065dc9468 dt-bindings: reset: st,sti-powerdown=
: Convert to yaml)
Merging rockchip/for-next (1378fa35abe3 Merge branch 'v5.19-clk/next' into =
for-next)
Merging samsung-krzk/for-next (88fb0c4d0aff Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (42226c989789 Linux 5.18-rc7)
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
Merging clk/clk-next (47f632f939a0 Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (cf7f3f4fa9e5 clk: imx8mp: fix usb_root_clk parent)
Merging clk-renesas/renesas-clk (23426d1be3c2 clk: renesas: r9a09g011: Add =
eth clock and reset entries)
Merging clk-samsung/for-next (b35f27fe73d8 clk: samsung: exynosautov9: add =
cmu_peric1 clock support)
Merging csky/linux-next (64d83f067746 csky: Move $(core-y) into arch/csky/K=
build)
Merging loongarch/loongarch-next (242973415711 LoongArch: Add Loongson-3 de=
fault config file)
Merging m68k/for-next (ed6bc6bf0a7d m68k: math-emu: Fix dependencies of mat=
h emulation support)
Merging m68knommu/for-next (13a55e3a00d1 m68knommu: fix 68000 CPU link with=
 no platform selected)
CONFLICT (content): Merge conflict in arch/m68k/kernel/ptrace.c
Merging microblaze/next (78b5f52ab6f6 microblaze: fix typos in comments)
Merging mips/mips-next (dd089d485849 MIPS: Sibyte: remove unnecessary retur=
n variable)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (065b8ced7c40 openrisc: remove bogus nops and shu=
tdowns)
Merging parisc-hd/for-next (798082be69fe parisc: Fix patch code locking and=
 flushing)
Merging powerpc/next (b6b1c3ce06ca powerpc/rtas: Keep MSR[RI] set when call=
ing RTAS)
Merging soc-fsl/next (1ce93cb102e7 soc: fsl: qe: Check of ioremap return va=
lue)
Merging risc-v/for-next (93c0651617a6 riscv: support for Svpbmt and D1 memo=
ry types)
Merging s390/for-next (4969d2ec2926 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (82017457957a um: run_helper: Write error message to=
 kernel log on exec failure on host)
Merging xtensa/xtensa-for-next (5cc5f19f884a xtensa: improve call0 ABI prob=
ing)
Merging pidfd/for-next (e1bbcd277a53 fs: hold writers when changing mount's=
 idmapping)
Merging fscrypt/master (218d921b581e fscrypt: add new helper functions for =
test_dummy_encryption)
Merging fscache/fscache-next (312310928417 Linux 5.18-rc1)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (a593e0fd315b Merge branch 'for-next-next-v5.18-2022=
0517' into for-next-20220517)
Merging ceph/master (b2ef8cf16c4f fs: change test in inode_insert5 for addi=
ng to the sb list)
Merging cifs/for-next (b6621ebb23fa cifs: fix signed integer overflow when =
fl_end is OFFSET_MAX)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (ba73eadd23d1 erofs: scan devices from device table)
Merging exfat/dev (3ed96c651596 exfat: check if cluster num is valid)
Merging ext3/for_next (1d86bf02e2fc Pull parent mark handling fixes from Am=
ir Goldstein.)
Merging ext4/dev (23e3d7f7061f jbd2: fix a potential race while discarding =
reserved buffers after an abort)
Merging f2fs/dev (677a82b44ebf f2fs: fix to do sanity check for inline inod=
e)
Merging fsverity/fsverity (b0487ede1f7a fs-verity: remove unused parameter =
desc_size in fsverity_create_info())
Merging fuse/for-next (6b49bc9d8a5f fuse: avoid unnecessary spinlock bump)
Merging gfs2/for-next (912a5a5237a6 gfs2: Convert function bh_get to use io=
map)
Merging jfs/jfs-next (e471e5942c00 fs/jfs: Remove dead code)
Merging ksmbd/ksmbd-for-next (158a66b24573 ksmbd: validate length in smb2_w=
rite())
Merging nfs/linux-next (42226c989789 Linux 5.18-rc7)
Merging nfs-anna/linux-next (9c4a5c75a62e NFS: Pass i_size to fscache_unuse=
_cookie() when a file is released)
Merging nfsd/for-next (6d4997ac46d3 SUNRPC: Use RMW bitops in single-thread=
ed hot paths)
Merging ntfs3/master (52e00ea6b26e fs/ntfs3: Update valid size if -EIOCBQUE=
UED)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (bc70682a497c ovl: support idmapped layers)
Merging ubifs/next (705757274599 ubifs: rename_whiteout: correct old_dir si=
ze computing)
Merging v9fs/9p-next (22e424feb665 Revert "fs/9p: search open fids first")
Merging xfs/for-next (efd409a4329f Merge branch 'xfs-5.19-quota-warn-remove=
' into xfs-5.19-for-next)
Merging zonefs/for-next (31a644b3c2ae documentation: zonefs: Document sysfs=
 attributes)
CONFLICT (content): Merge conflict in fs/zonefs/super.c
Merging iomap/iomap-for-next (d74999c8c060 iomap: iomap_write_end cleanup)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (fd78f28f9f50 Merge branch 'work.namei' into for-next)
Merging printk/for-next (a110b11164a5 Merge branch 'rework/kthreads' into f=
or-next)
Merging pci/next (c2c6a829a49d Merge branch 'remotes/lorenzo/pci/vmd')
Merging pstore/for-next/pstore (8126b1c73108 pstore: Don't use semaphores i=
n always-atomic-context code)
Merging hid/for-next (a2a3b5d6c512 Merge branch 'for-5.19/apple' into for-n=
ext)
CONFLICT (content): Merge conflict in drivers/hid/Kconfig
CONFLICT (content): Merge conflict in drivers/hid/Makefile
Merging i2c/i2c/for-next (6f2c48bcb7ed Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (227fab1ee7ca i3c: master: svc: fix returnvar.cocci wa=
rning)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (7a6357c82e7e hwmon: (dimmtemp) Fix bitmap=
 handling)
Merging jc_docs/docs-next (b86f46d5ce3e docs: pdfdocs: Add space for chapte=
r counts >=3D 100 in TOC)
CONFLICT (content): Merge conflict in Documentation/process/embargoed-hardw=
are-issues.rst
Merging v4l-dvb/master (be938c70e292 media: uvcvideo: Add UVC_GUID_FORMAT_H=
265)
Merging v4l-dvb-next/master (340ce50f75a6 media: hantro: Enable HOLD_CAPTUR=
E_BUF for H.264)
Merging pm/linux-next (6b601767c503 Merge branch 'thermal-int340x-fixes' in=
to linux-next)
CONFLICT (content): Merge conflict in include/acpi/actbl2.h
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
Merging rdma/for-next (845517ed04ae RDMA/qedr: Remove unnecessary synchroni=
ze_irq() before free_irq())
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/main.c
Merging net-next/master (a3641ca416a3 net: smc911x: Fix min() use in debug =
code)
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/main.c
CONFLICT (content): Merge conflict in net/mptcp/options.c
CONFLICT (content): Merge conflict in net/mptcp/pm.c
CONFLICT (content): Merge conflict in net/mptcp/subflow.c
CONFLICT (content): Merge conflict in tools/testing/selftests/net/mptcp/mpt=
cp_join.sh
Applying: fix up for "netfilter: conntrack: remove unconfirmed list"
Merging bpf-next/for-next (70a1b25326dd selftests/bpf: Add missed ima_setup=
.sh in Makefile)
CONFLICT (content): Merge conflict in net/core/sysctl_net_core.c
Merging ipsec-next/master (0f9008e5c510 Merge  branch 'Be explicit with XFR=
M offload direction')
Merging mlx5-next/mlx5-next (846e437387e7 net/mlx5: Expose mlx5_sriov_block=
ing_notifier_register / unregister APIs)
Merging netfilter-next/master (0c7b27616fbd selftests: netfilter: add fib e=
xpression forward test case)
Merging ipvs-next/master (0c7b27616fbd selftests: netfilter: add fib expres=
sion forward test case)
Merging bluetooth/master (3b42055388c3 Bluetooth: hci_sync: Fix attempting =
to suspend with unfiltered passive scan)
Merging wireless-next/main (78488a64aea9 iwlwifi: mei: fix potential NULL-p=
tr deref)
Merging mtd/mtd/next (1fefc8ecb834 mtd: st_spi_fsm: add missing clk_disable=
_unprepare() in stfsm_remove())
Merging nand/nand/next (6a2277a0ebe7 mtd: rawnand: renesas: Use runtime PM =
instead of the raw clock API)
Merging spi-nor/spi-nor/next (c47452194641 mtd: spi-nor: debugfs: fix forma=
t specifier)
Merging crypto/master (349d03ffd5f6 crypto: s390 - add crypto library inter=
face for ChaCha20)
Merging drm/drm-next (f8122500a039 Merge branch 'etnaviv/next' of https://g=
it.pengutronix.de/git/lst/linux into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_reg.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_vma.c
Applying: fi up for "drm/i915/dmc: Add MMIO range restrictions"
Merging drm-misc/for-linux-next (5ee8c8f930ba drm/rockchip: Change register=
 space names in vop2)
Merging amdgpu/drm-next (965e4fc0d716 drm/amd/pm: enable memory temp readin=
g for SMU 13.0.0)
Merging drm-intel/for-linux-next (f83493f7d34d Merge tag 'drm-msm-next-2022=
-05-09' of https://gitlab.freedesktop.org/drm/msm into drm-next)
Merging drm-tegra/drm/tegra/for-next (b53c24f69199 drm/tegra: Support YVYU,=
 VYUY and YU24 formats)
Merging drm-msm/msm-next (24df12013853 MAINTAINERS: Add Dmitry as MSM DRM d=
river co-maintainer)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (2829a9fcb738 drm/etnaviv: reap idle softpin m=
appings when necessary)
Merging fbdev/for-next (f443e374ae13 Linux 5.17)
Merging regmap/for-next (5c422f0b970d regmap: Add missing map->bus check)
Merging sound/for-next (03a8b0df757f ALSA: usb-audio: Fix wrong kfree issue=
 in snd_usb_endpoint_free_all)
Merging sound-asoc/for-next (b33f104e416b Merge remote-tracking branch 'aso=
c/for-5.19' into asoc-next)
Merging modules/modules-next (7390b94a3c2d module: merge check_exported_sym=
bol() into find_exported_symbol_in_section())
Merging input/next (038c4bf85ba2 Merge branch 'ib/5.17-cros-ec-keyb' into n=
ext)
Merging block/for-next (f1d22fa8f318 Merge branch 'for-5.19/io_uring' into =
for-next)
Merging device-mapper/for-next (d254c3699fdd dm cache metadata: remove unne=
cessary variable in __dump_mapping)
Merging libata/for-next (71abb4df2981 ata: pata_ftide010: Remove unneeded E=
RROR check before clk_disable_unprepare)
Merging pcmcia/pcmcia-next (3928cf08334e pcmcia: db1xxx_ss: restrict to MIP=
S_DB1XXX boards)
Merging mmc/next (ded2c4c34500 mmc: sdhci-of-arasan: Add NULL check for dat=
a field)
CONFLICT (content): Merge conflict in drivers/mmc/core/queue.c
Merging mfd/for-mfd-next (3474b838f420 dt-bindings: Drop undocumented i.MX =
iomuxc-gpr bindings in examples)
Merging backlight/for-backlight-next (023a8830a628 backlight: backlight: Sl=
ighly simplify devm_of_find_backlight())
Merging battery/for-next (d96a89407e5f power: supply: bq24190_charger: usin=
g pm_runtime_resume_and_get instead of pm_runtime_get_sync)
Merging regulator/for-next (a5b8e4a5ceec Merge remote-tracking branch 'regu=
lator/for-5.19' into regulator-next)
Merging security/next-testing (047843bdb316 Merge branch 'landlock_lsm_v34'=
 into next-testing)
Merging apparmor/apparmor-next (c2489617b3b9 apparmor: Fix undefined refere=
nce to `zlib_deflate_workspacesize')
Merging integrity/next-integrity (048ae41bb080 integrity: Fix sparse warnin=
gs in keyring_handler)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (1af0e4a0233f security: declare member holding string =
literal const)
Merging smack/next (ba6b652bd863 smack: Remove redundant assignments)
Merging tomoyo/master (5015b3b61696 workqueue: Wrap flush_workqueue() using=
 a macro)
Merging tpmdd/next (fad7eba9464e certs: Explain the rationale to call panic=
())
Merging watchdog/master (5b38db0ed51e dt-bindings: watchdog: sunxi: clarify=
 clock support)
Merging iommu/next (807413e871d6 Merge branches 'apple/dart', 'arm/mediatek=
', 'arm/msm', 'ppc/pamu', 'x86/vt-d', 'x86/amd', 'vfio-notifier-fix' and 'a=
rm/smmu' into next)
CONFLICT (content): Merge conflict in MAINTAINERS
CONFLICT (content): Merge conflict in drivers/iommu/amd/iommu.c
Merging audit/next (312310928417 Linux 5.18-rc1)
Merging devicetree/for-next (4a855a957936 dt-bindings: mailbox: zynqmp_ipi:=
 convert to yaml)
Merging mailbox/mailbox-for-next (1b0d0f7c12d5 dt-bindings: mailbox: add de=
finition for mt8186)
Merging spi/for-next (9c63b846e6df spi: spi-mem: Convert Aspeed SMC driver =
to spi-mem)
Merging tip/master (1432c670d96a Merge branch into tip/master: 'x86/sgx')
CONFLICT (content): Merge conflict in Documentation/admin-guide/kernel-para=
meters.txt
CONFLICT (content): Merge conflict in kernel/sysctl.c
Merging clockevents/timers/drivers/next (ff714ee7191b clocksource/drivers/t=
imer-ti-dm: Add compatible for am6 SoCs)
Merging edac/edac-for-next (c363d6018652 Merge edac-misc into for-next)
Merging irqchip/irq/irqchip-next (492449ae4f0a Merge branch irq/gic-v3-nmi-=
fixes-5.19 into irq/irqchip-next)
Merging ftrace/for-next (c87857e21486 Merge branch 'trace/for-next-rtla' in=
to trace/for-next)
Merging rcu/rcu/next (7ab96061e7fd DIAGS rcu: Diagnose extended sync_rcu_do=
_polled_gp() loops)
Merging kvm/next (a3808d884612 KVM: x86/pmu: Expose CPUIDs feature bits PDC=
M, DS, DTES64)
CONFLICT (content): Merge conflict in arch/x86/kvm/pmu.h
Merging kvm-arm/next (5c0ad551e9aa Merge branch kvm-arm64/its-save-restore-=
fixes-5.19 into kvmarm-master/next)
CONFLICT (content): Merge conflict in Documentation/virt/kvm/api.rst
CONFLICT (content): Merge conflict in arch/arm64/kvm/sys_regs.c
CONFLICT (content): Merge conflict in include/uapi/linux/kvm.h
Merging kvms390/next (95c54dd51362 KVM: s390: selftest: Test suppression in=
dication on key prot exception)
Merging xen-tip/linux-next (533bec143a4c arm/xen: Fix some refcount leaks)
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (10a5a651e3af workqueue: Restrict kworker in th=
e offline CPU pool running on housekeeping CPUs)
Merging drivers-x86/for-next (46ecf720f362 platform/x86: toshiba_acpi: use =
kobj_to_dev())
Merging chrome-platform/for-next (7bff62406671 platform/chrome: Use imperat=
ive mood for ChromeOS ACPI sysfs ABI descriptions)
Merging hsi/for-next (43c14f8d18a7 HSI: omap_ssi: Fix refcount leak in ssi_=
probe)
Merging leds/for-next (73bce575ed90 leds: lp50xx: Remove duplicated error r=
eporting in .remove())
Merging ipmi/for-next (a508e33956b5 ipmi:ipmb: Fix refcount leak in ipmi_ip=
mb_probe)
Merging driver-core/driver-core-next (bc443c31def5 driver core: location: C=
heck for allocations failure)
Merging usb/usb-next (74f55a62c4c3 xhci: Allow host runtime PM as default f=
or Intel Alder Lake N xHCI)
Merging thunderbolt/next (c7c99a09ef0e thunderbolt: Add KUnit test for devi=
ces with no DisplayPort adapters)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (e82e7c6dde91 USB: serial: pl2303: fix type det=
ection for odd device)
Merging tty/tty-next (d6da35e0c6d5 Merge 5.18-rc7 into usb-next)
Merging char-misc/char-misc-next (33a1c6618677 nvmem: sfp: Add support for =
TA 2.1 devices)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging coresight/next (1adff542d67a coresight: cpu-debug: Replace mutex wi=
th mutex_trylock on panic notifier)
Merging fpga/for-next (ae23f746d744 fpga: dfl: Allow Port to be linked to F=
ME's DFL)
Merging icc/icc-next (3be0ec65fd17 dt-bindings: interconnect: Remove sc7180=
/sdx55 ipa compatibles)
Merging iio/togreg (8d12e6b62301 iio: dac: cio-dac: Utilize iomap interface)
Merging phy-next/next (d413a34932f9 phy: qcom-qmp: rename error labels)
Merging soundwire/next (74da272400b4 soundwire: qcom: adjust autoenumeratio=
n timeout)
Merging extcon/extcon-next (5dcc2afe716d extcon: Modify extcon device to be=
 created after driver data is set)
CONFLICT (content): Merge conflict in drivers/usb/dwc3/drd.c
Applying: fixup for "usb: dwc3: Don't switch OTG -> peripheral if extcon is=
 present"
Merging gnss/gnss-next (312310928417 Linux 5.18-rc1)
Merging vfio/next (7ab5e10eda02 vfio/pci: Move the unused device into low p=
ower state with runtime PM)
Merging staging/staging-next (e41f7a5521d7 staging: r8188eu: remove unused =
IEEE_* defines)
CONFLICT (content): Merge conflict in drivers/net/wireless/silabs/wfx/sta.c
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (411dccf9d271 dmaengine: idxd: Remove unnecessary sy=
nchronize_irq() before free_irq())
CONFLICT (content): Merge conflict in drivers/dma/idxd/device.c
Merging cgroup/for-next (b7eb2d2c4cda Merge branch 'for-5.19' into for-next)
Merging scsi/for-next (d988290190a7 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (e21b20ba2dd3 scsi: target: tcmu: Avoid holding X=
Array lock when calling lock_page)
Merging vhost/linux-next (acde3929492b vdpa/mlx5: Use consistent RQT size)
Merging rpmsg/for-next (01a1a0c8d456 Merge branches 'rproc-next', 'rpmsg-ne=
xt' and 'hwspinlock-next' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (a998ec3d7bae gpio: ftgpio: Remove unneeded=
 ERROR check before clk_disable_unprepare)
Merging gpio-intel/for-next (edc5601db664 pinctrl: meson: Replace custom co=
de by gpiochip_node_count() call)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (5f3841fafbb2 Merge branch 'devel' into for-next)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/int=
errupt-controller/qcom,pdc.txt
Merging pinctrl-intel/for-next (56da7dc5eb67 pinctrl: intel: Drop unused ir=
qchip member in struct intel_pinctrl)
Merging pinctrl-renesas/renesas-pinctrl (fc883ed5a43e pinctrl: renesas: che=
cker: Add reserved field checks)
Merging pinctrl-samsung/for-next (ac875df4d854 pinctrl: samsung: fix missin=
g GPIOLIB on ARM64 Exynos config)
Merging pwm/for-next (2bf8ee0faa98 dt-bindings: pwm: Add interrupts propert=
y for MediaTek MT8192)
Merging userns/for-next (be5b922836ae Merge of per-namespace-ipc-sysctls-fo=
r-v5.19, kthread-cleanups-for-v5.19, and ptrace_stop-cleanup-for-v5.19 for =
testing in linux-next)
CONFLICT (modify/delete): arch/h8300/kernel/process.c deleted in HEAD and m=
odified in userns/for-next.  Version userns/for-next of arch/h8300/kernel/p=
rocess.c left in tree.
CONFLICT (content): Merge conflict in arch/x86/kernel/process.c
$ git rm -f arch/h8300/kernel/process.c
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (15477b31db10 kselftests/ir : Improve readability of=
 modprobe error message)
Merging livepatching/for-next (0e1b951d6de0 Merge branch 'for-5.18/selftest=
s-fixes' into for-next)
Merging rtc/rtc-next (6ddabcb10628 rtc: gamecube: Add missing iounmap in ga=
mecube_rtc_read_offset_from_sram)
Merging nvdimm/libnvdimm-for-next (f42e8e5088b9 pmem: implement pmem_recove=
ry_write())
Merging at24/at24/for-next (312310928417 Linux 5.18-rc1)
Merging ntb/ntb-next (e9d0fa5e2482 IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (5e91d2a41469 selftests/seccomp: Fix spell=
ing mistake "Coud" -> "Could")
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (f2af60bb7ce2 fsi: Add trace events in initialization path)
Merging slimbus/for-next (54bf672111ee slimbus: qcom: Fix IRQ check in qcom=
_slim_probe)
Merging nvmem/for-next (0f07cbb92a28 nvmem: sfp: Add support for TA 2.1 dev=
ices)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging xarray/main (63b1898fffcd XArray: Disallow sibling entries of nodes)
Merging hyperv/hyperv-next (b4927bd27262 PCI: hv: Fix synchronization betwe=
en channel callback and hv_pci_bus_exit())
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (312310928417 Linux 5.18-rc1)
Merging kunit/test (312310928417 Linux 5.18-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging kunit-next/kunit (e7eaffce47b7 kunit: tool: Use qemu-system-i386 fo=
r i386 runs)
CONFLICT (content): Merge conflict in drivers/thunderbolt/test.c
CONFLICT (content): Merge conflict in net/mctp/test/route-test.c
CONFLICT (content): Merge conflict in security/apparmor/policy_unpack_test.c
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (13b9b814da2d bus: mhi: host: Add support for Foxconn =
T99W373 and T99W368)
Merging memblock/for-next (000605cd1b14 memblock tests: remove completed TO=
DO item)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (e6829d1bd3c4 nvdimm: Fix firmware activation deadlock sce=
narios)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (a6cfe03c34ba efi: stub: prefer mirrored memory for random=
ized allocations)
CONFLICT (content): Merge conflict in drivers/virt/Kconfig
CONFLICT (content): Merge conflict in drivers/virt/Makefile
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (6b2d72729581 Merge branches 'slab/for-5.19/stackdepo=
t' and 'slab/for-5.19/refactor' into slab/for-next)
Merging random/master (0090127adc44 siphash: add SPDX tags as sole licensin=
g authority)
Merging landlock/next (7c2536771184 landlock: Explain how to support Landlo=
ck)
Merging rust/rust-next (425a9fd52cc6 init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
CONFLICT (content): Merge conflict in Makefile
CONFLICT (content): Merge conflict in include/uapi/linux/android/binder.h
Merging sysctl/sysctl-next (494dcdf46e5c sched: Fix build warning without C=
ONFIG_SYSCTL)
CONFLICT (content): Merge conflict in kernel/rcu/rcu.h
CONFLICT (content): Merge conflict in kernel/trace/ftrace.c
Merging folio/for-next (516edb456f12 nilfs2: Fix some kernel-doc comments)
CONFLICT (content): Merge conflict in fs/btrfs/ctree.h
CONFLICT (content): Merge conflict in fs/btrfs/inode.c
CONFLICT (content): Merge conflict in fs/btrfs/send.c
CONFLICT (content): Merge conflict in fs/f2fs/data.c
Applying: fix up for "btrfs: move btrfs_readpage to extent_io.c"
Applying: fixup for "mm,fs: Remove stray references to ->readpage"
Merging execve/for-next/execve (70578ff3367d binfmt_flat: Remove shared lib=
rary support)
Merging bitmap/bitmap-for-next (0fe0e22b04bb nodemask: Fix return values to=
 be unsigned)
Merging hte/hte/for-next (479c5db800e1 hte: Uninitialized variable in hte_t=
s_get())
Merging kspp/for-next/kspp (ed5edd5a70b9 loadpin: stop using bdevname)
CONFLICT (content): Merge conflict in drivers/misc/lkdtm/stackleak.c
Merging kspp-gustavo/for-next/kspp (0cf2b91d74b7 Merge branch 'for-next/ksp=
p-stringop-overflow' into for-next/kspp)
Merging mm-stable/mm-stable (bbe832b9db2e mm, compaction: fast_find_migrate=
block() should return pfn in the target zone)
CONFLICT (content): Merge conflict in arch/x86/mm/Makefile
CONFLICT (content): Merge conflict in fs/nfs/file.c
CONFLICT (content): Merge conflict in include/linux/slab.h
CONFLICT (content): Merge conflict in mm/page_io.c
Merging mm-nonmm-stable/mm-nonmm-stable (c7031c144043 proc/sysctl: make pro=
tected_* world readable)
CONFLICT (content): Merge conflict in include/linux/ptrace.h
Merging mm/mm-everything (004e72ec2b70 Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
Applying: fixup for "mm: change huge_ptep_clear_flush() to return the origi=
nal pte"
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (5872536d1b34 mm/oom_kill.c: fix vm_oom_kill_table[] if=
deffery)

--Sig_/KQqv9pgJRplOr4.vNtEMCKl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKGEqIACgkQAVBC80lX
0Gwt5Af+P6Haq3+7kc+8Lya1Pc/Y2UVPbZsE+cLEHbH1+MbMSmPhu59KnZzvWVj0
8z0XyzphF3XwNWLln5jjvfN1/qFs8FZXYUnaYL0qdvAJLIn+PJQUQIkRmzVCAVFm
5C0pbZ65je/3u6+yNAIy1Sm+mWp6HB+OLK4g+KPTrxmsinOJWzU+BrxuGAKbeEHW
XvHcTzAYasJZejX0JvqdFhtrYY30rY19YwyCQ0XW/+aBnrFT+GsvWNkGqGloCHzM
7KGN9lBKUj9bYFuTqSQKby36J0qfk2hBQsWbOocJGd5KVw8q96WcXMWZWbebbO/v
KPisQs9VYX6NVwlE+wRVCmoIkqvPfw==
=TqZw
-----END PGP SIGNATURE-----

--Sig_/KQqv9pgJRplOr4.vNtEMCKl--
