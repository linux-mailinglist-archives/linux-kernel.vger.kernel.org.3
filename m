Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D254CF451
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbiCGJLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbiCGJLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:11:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A780D38DBA;
        Mon,  7 Mar 2022 01:10:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBt390rn3z4xRB;
        Mon,  7 Mar 2022 20:10:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646644229;
        bh=STB0w0RWHhxSre1f12rlrn1zvhwcjsewWitXFXYXO94=;
        h=Date:From:To:Cc:Subject:From;
        b=s34i2/mIy6GtKtx9Y73sCMffdrMW3b39eeabBt9Um96FNRHdSN0WAaJYN8Ml6cAWj
         Yzudk7719itAA4RCtMgLsFcgCvekDcg+SP8C/XdfL3/ImGsk2m6z9ymJxy4MdpvHvd
         cAfp8gMu1ok+GQo4pyaYGcui3i5cu6bvC+1lSY4IuLSXtSqvAF94YlYI1xwEINSNV3
         rhjqTZFwtuIsd4aapobHc9wLlxGrl4lVMoUbvFj/v6HIj8hWQvY+2iW0QqorGFYNNG
         X3GOsuBZjiuwy283XDJiJ/IkoJ4+Q8di8VswjJeQ71D9fwkOkao94ntgn6hF/GtBBt
         b4Hj2x4vfRQUw==
Date:   Mon, 7 Mar 2022 20:10:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 7
Message-ID: <20220307201025.18d2a892@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ifDTcMX700MvmTJ4CbUktRx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ifDTcMX700MvmTJ4CbUktRx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220304:

The net-next tree gained a conflict against the net tree.

The amdgpu tree gained a semantic conflict against the spi tree.

The tip tree gained a conflict against the iommu tree.

The scsi tree gained conflicts against the block tree.

The vhost tree gained a conflict against the block tree.

The kspp tree still had its build failure so I applied three upcoming
DRM patches.

Non-merge commits (relative to Linus' tree): 10072
 10143 files changed, 905348 insertions(+), 236805 deletions(-)

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

I am currently merging 346 trees (counting Linus' and 94 trees of bug
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
Merging origin/master (3ee65c0f0778 Merge tag 'for-5.17-rc6-tag' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (754e0b0e3560 Linux 5.17-rc4)
Merging arc-current/for-curr (e783362eb54c Linux 5.17-rc1)
Merging arm-current/fixes (7b83299e5b93 ARM: 9182/1: mmu: fix returns from =
early_param() and __setup() functions)
Merging arm64-fixes/for-next/fixes (4f6de676d94e arm64: Correct wrong label=
 in macro __init_el2_gicv3)
Merging arm-soc-fixes/arm/fixes (a0e897d1b367 arm64: dts: armada-3720-turri=
s-mox: Add missing ethernet0 alias)
Merging drivers-memory-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging tee-fixes/fixes (6d8df1f9e8ae Merge tag 'optee-fix2-for-v5.17' into=
 fixes)
Merging m68k-current/for-linus (1a0ae068bf6b m68k: defconfig: Update defcon=
figs for v5.16-rc1)
Merging powerpc-fixes/fixes (58dbe9b373df powerpc/64s: Fix build failure wh=
en CONFIG_PPC_64S_HASH_MMU is not set)
Merging s390-fixes/fixes (c194dad21025 s390/extable: fix exception table so=
rting)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (afb3cc1a397d net: dsa: unlock the rtnl_mutex when dsa_m=
aster_setup() fails)
Merging bpf/master (18b1ab7aa76b xsk: Fix race at socket teardown)
Merging ipsec/master (4ff2980b6bd2 xfrm: fix tunnel model fragmentation beh=
avior)
Merging netfilter/master (f8e9bd34cedd Merge branch 'smc-fix')
Merging ipvs/master (277f2bb14361 ibmvnic: schedule failover only if vioctl=
 fails)
Merging wireless/main (e6e91ec966db iwlwifi: mvm: return value for request_=
ownership)
Merging rdma-fixes/for-rc (7e57714cd0ad Linux 5.17-rc6)
Merging sound-current/for-linus (cd94df179541 ALSA: usb-audio: add mapping =
for new Corsair Virtuoso SE)
Merging sound-asoc-fixes/for-linus (b7fb0ae09009 ASoC: SOF: Intel: Fix NULL=
 ptr dereference when ENOMEM)
Merging regmap-fixes/for-linus (d04ad245d67a regmap-irq: Update interrupt c=
lear register for proper reset)
Merging regulator-fixes/for-linus (48fdc1fa4d93 Merge remote-tracking branc=
h 'regulator/for-5.16' into regulator-linus)
Merging spi-fixes/for-linus (a7c76d3f0787 Merge remote-tracking branch 'spi=
/for-5.16' into spi-linus)
Merging pci-current/for-linus (3f1271b54edc PCI: Mark all AMD Navi10 and Na=
vi14 GPU ATS as broken)
Merging driver-core.current/driver-core-linus (7e57714cd0ad Linux 5.17-rc6)
Merging tty.current/tty-linus (7e57714cd0ad Linux 5.17-rc6)
Merging usb.current/usb-linus (7e57714cd0ad Linux 5.17-rc6)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (cfc4442c642d USB: serial: option: add T=
elit LE910R1 compositions)
Merging usb-chipidea-fixes/for-usb-fixes (f130d08a8d79 usb: chipidea: ci_hd=
rc_imx: Also search for 'phys' phandle)
CONFLICT (content): Merge conflict in drivers/usb/chipidea/ci_hdrc_imx.c
Merging phy/fixes (9a8406ba1a9a phy: dphy: Correct clk_pre parameter)
Merging staging.current/staging-linus (342e7c6ea582 staging: rtl8723bs: Imp=
rove the comment explaining the locking rules)
Merging iio-fixes/fixes-togreg (123d838c4e7d iio: adc: xilinx-ams: Fix sing=
le channel switching sequence)
Merging counter-fixes/fixes-togreg (4a14311a3b93 counter: Stop using dev_ge=
t_drvdata() to get the counter device)
Merging char-misc.current/char-misc-linus (7e57714cd0ad Linux 5.17-rc6)
Merging soundwire-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging thunderbolt-fixes/fixes (7e57714cd0ad Linux 5.17-rc6)
Merging input-current/for-linus (327b89f0acc4 HID: add mapping for KEY_ALL_=
APPLICATIONS)
Merging crypto-current/master (c6ce9c5831ca crypto: api - Move cryptomgr so=
ft dependency into algapi)
Merging vfio-fixes/for-linus (8704e8934908 vfio/pci: Fix OpRegion read)
Merging kselftest-fixes/fixes (6fec1ab67f8d selftests/ftrace: Do not trace =
do_softirq because of PREEMPT_RT)
Merging modules-fixes/modules-linus (a8e8f851e829 module: fix building with=
 sysfs disabled)
Merging dmaengine-fixes/fixes (cfb92440ee71 Linux 5.17-rc5)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (7cf1de957a98 mtd: rawnand: omap2: Actually pre=
vent invalid configuration and build error)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (d40f0b133b44 media: meson-ir-tx: remove incorr=
ect doc comment)
Merging reset-fixes/reset/fixes (92c959bae2e5 reset: renesas: Fix Runtime P=
M usage)
Merging mips-fixes/mips-fixes (5d8965704fe5 MIPS: ralink: mt7621: use bitwi=
se NOT instead of logical)
Merging at91-fixes/at91-fixes (26077968f838 dt-bindings: ARM: at91: update =
maintainers entry)
Merging omap-fixes/fixes (8840f5460a23 ARM: dts: Use 32KiHz oscillator on d=
evkit8000)
Merging kvm-fixes/master (8d25b7beca7e KVM: x86: pull kvm->srcu read-side t=
o kvm_arch_vcpu_ioctl_run)
Merging kvms390-fixes/master (0e9ff65f455d KVM: s390: preserve deliverable_=
mask in __airqs_kick_single_vcpu)
Merging hwmon-fixes/hwmon (686d303ee630 hwmon: (pmbus) Add mutex to regulat=
or ops)
Merging nvdimm-fixes/libnvdimm-fixes (3dd60fb9d95d nvdimm/pmem: stop using =
q_usage_count as external pgmap refcount)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (e3727c6aef80 Merge branch 'misc-5.17' into =
next-fixes)
Merging vfs-fixes/fixes (9d2231c5d74e lib/iov_iter: initialize "flags" in n=
ew pipe_buffer)
Merging dma-mapping-fixes/for-linus (18a3c5f7abfd Merge tag 'for_linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (21d90aaee8d5 surface: surface3_power: Fix =
battery readings on batteries without a serial number)
Merging samsung-krzk-fixes/fixes (442b0c08db7e soc: samsung: Fix typo in CO=
NFIG_EXYNOS_USI description)
Merging pinctrl-samsung-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging devicetree-fixes/dt/linus (0c0822bcb73f dt-bindings: update Roger Q=
uadros email)
Merging scsi-fixes/fixes (10af11564617 scsi: ufs: core: Fix divide by zero =
in ufshcd_map_queues())
Merging drm-fixes/drm-fixes (8fdb19679722 Merge tag 'drm-misc-fixes-2022-03=
-03' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (08783aa7693f drm/i915: s/JSP2=
/ICP2/ PCH)
Merging mmc-fixes/fixes (f0d2f15362f0 mmc: meson: Fix usage of meson_mmc_po=
st_req())
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (e783362eb54c Linux 5.17-rc1)
Merging hyperv-fixes/hyperv-fixes (ffc58bc4af93 Drivers: hv: utils: Make us=
e of the helper macro LIST_HEAD())
Merging soc-fsl-fixes/fix (a222fd854139 soc: fsl: qe: Check of ioremap retu=
rn value)
Merging risc-v-fixes/fixes (74583f1b92cb riscv: dts: k210: fix broken IRQs =
on hart1)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (8bb7eca972ad Linux 5.15)
Merging spdx/spdx-linus (d8152cfe2f21 Merge tag 'pci-v5.17-fixes-5' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci)
Merging gpio-brgl-fixes/gpio/for-current (ae42f9288846 gpio: Return EPROBE_=
DEFER if gc->to_irq is NULL)
Merging gpio-intel-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging pinctrl-intel-fixes/fixes (6f66db29e241 pinctrl: tigerlake: Revert =
"Add Alder Lake-M ACPI ID")
Merging erofs-fixes/fixes (24331050a3e6 erofs: fix small compressed files i=
nlining)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (92a68053c346 Documentation: KUnit: Fix usa=
ge bug)
Merging ubifs-fixes/fixes (c3c07fc25f37 ubi: fastmap: Return error code if =
memory allocation fails in add_aeb())
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (c306d737691e NFSD: Deprecate NFS_OFFSET_MAX)
Merging irqchip-fixes/irq/irqchip-fixes (1d4df649cbb4 irqchip/sifive-plic: =
Add missing thead,c900-plic match string)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (ac84e82f78cb Merge tag 'block-5.17-2022-0=
3-04' of git://git.kernel.dk/linux-block)
Merging efi-fixes/urgent (9feaf8b387ee efi: fix return value of __setup han=
dlers)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging drm-misc-fixes/for-linux-next-fixes (62929726ef0e drm/vrr: Set VRR =
capable prop only if it is attached to connector)
Merging kbuild/for-next (d4c858643263 kallsyms: ignore all local labels pre=
fixed by '.L')
Merging perf/perf/core (56dce868198c libperf: Add API for allocating new th=
read map array)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (80e439098161 dma-debug: fix return value of _=
_setup handlers)
Merging asm-generic/master (9f15ac318b83 nds32: Remove the architecture)
Merging arc/for-next (6880fa6c5660 Linux 5.15-rc1)
Merging arm/for-next (d5b493b066ca Merge branch 'devel-stable' into for-nex=
t)
Merging arm64/for-next/core (fe500628a097 Merge branch 'for-next/fpsimd' in=
to for-next/core)
Merging arm-perf/for-next/perf (602c873eb52e perf: Replace acpi_bus_get_dev=
ice())
Merging arm-soc/for-next (1c9566edd537 Revert "soc: mediatek: mmsys: add mm=
sys reset control for MT8186")
CONFLICT (content): Merge conflict in arch/arm/Kconfig
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (39369380e729 Merge branch 'v5.18/dt64' into for-n=
ext)
Merging aspeed/for-next (d9540eeaa3d1 Merge branches 'nuvoton-dt-for-v5.18'=
 and 'dt-for-v5.18' into for-next)
Merging at91/at91-next (d355edef55ee soc: microchip: make mpfs_sys_controll=
er_put static)
Merging drivers-memory/for-next (560f9d092a9d Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (45550ada88f0 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (6ceb6a96db4e Merge branch 'v5.17-fixes' into for=
-next)
Merging mvebu/for-next (89756932b780 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (f9ecc209330a Merge branch 'omap-for-v5.18/dt' into f=
or-next)
Merging qcom/for-next (22139a9091fd Merge branches 'arm64-defconfig-for-5.1=
8', 'arm64-for-5.18', 'clk-for-5.18', 'defconfig-for-5.18', 'drivers-for-5.=
18', 'dts-for-5.18', 'arm64-fixes-for-5.17' and 'dts-fixes-for-5.17' into f=
or-next)
CONFLICT (content): Merge conflict in arch/arm/configs/multi_v7_defconfig
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (dff7b84b4d2a Merge branch 'renesas-arm-dt-for-v5.18' =
into renesas-next)
Merging reset/reset/next (89e7a6698fdd reset: uniphier-glue: Use devm_add_a=
ction_or_reset())
Merging rockchip/for-next (ea80f22c4edd Merge branch 'v5.18-armsoc/dts64' i=
nto for-next)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/rockchip/rk356x.d=
tsi
Merging samsung-krzk/for-next (b2d5c4016a34 Merge branch 'for-v5.18/dt-clea=
nup' into for-next)
Merging scmi/for-linux-next (210b966b7e2f Merge tag 'scmi-updates-5.18' of =
git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-l=
inux-next)
Merging stm32/stm32-next (74fa56279651 ARM: dts: stm32: Switch DWMAC RMII c=
lock to MCO2 on DHCOM)
Merging sunxi/sunxi/for-next (f25c47c67629 Merge branch 'sunxi/dt-for-5.18'=
 into sunxi/for-next)
Merging tee/next (3e53bb2bd87b Merge branch 'tee_shm_vmalloc_for_v5.19' int=
o next)
Merging tegra/for-next (6d746e1eb2f6 Merge branch for-5.18/arm64/defconfig =
into for-next)
Merging ti/ti-next (183a6f5c6e1e Merge branches 'ti-k3-dts-next' and 'ti-dr=
ivers-soc-next' into ti-next)
Merging xilinx/for-next (3a14f0e61408 arm64: zynqmp: Rename dma to dma-cont=
roller)
Merging clk/clk-next (7da5e77a1b5f Merge branch 'clk-fixes' into clk-next)
Merging clk-imx/for-next (b09c68dc57c9 clk: imx: pll14xx: Support dynamic r=
ates)
Merging clk-renesas/renesas-clk (73421f2a48e6 clk: renesas: r8a779f0: Add P=
FC clock)
Merging clk-samsung/for-next (45bd8166a1d8 clk: samsung: Add initial Exynos=
7885 clock driver)
Merging csky/linux-next (a0793fdad9a1 csky: fix typo of fpu config macro)
Merging h8300/h8300-next (1ec10274d436 h8300: don't implement set_fs)
CONFLICT (modify/delete): arch/h8300/mm/memory.c deleted in h8300/h8300-nex=
t and modified in HEAD.  Version HEAD of arch/h8300/mm/memory.c left in tre=
e.
$ git rm -f arch/h8300/mm/memory.c
Merging m68k/for-next (0d52a01a266b m68k: defconfig: Disable fbdev on Sun3/=
3x)
Merging m68knommu/for-next (244e6c2d4e4d m68k: m5441x: remove erroneous clo=
ck disable)
Merging microblaze/next (fcc619621df5 microblaze/PCI: Remove pci_phys_mem_a=
ccess_prot() dead code)
Merging mips/mips-next (4a0a1436053b mips: ralink: fix a refcount leak in i=
ll_acc_of_setup())
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (862cf8d5fd98 openrisc/boot: Remove unnecessary i=
nitialisation in memcpy().)
Merging parisc-hd/for-next (d21d3f34cf6e parisc/unaligned: Enhance user-spa=
ce visible output)
CONFLICT (content): Merge conflict in arch/parisc/lib/memcpy.c
Merging powerpc/next (8219d31effa7 powerpc/lib/sstep: Fix build errors with=
 newer binutils)
Merging soc-fsl/next (1ce93cb102e7 soc: fsl: qe: Check of ioremap return va=
lue)
Merging risc-v/for-next (d56201d9440d riscv: defconfig: enable hugetlbfs op=
tion)
Merging s390/for-next (5225811009e5 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (db0dd9cee822 um: virtio_uml: Allow probing from dev=
icetree)
Merging xtensa/xtensa-for-next (26791d481907 xtensa: use XCHAL_NUM_AREGS as=
 pt_regs::areg size)
Merging pidfd/for-next (d52c14f5f9b3 Merge branch 'pidfd.fd_install' into f=
or-next)
Merging fscrypt/master (cdaa1b1941f6 fscrypt: update documentation for dire=
ct I/O support)
Merging fscache/fscache-next (b47a5fca3209 cachefiles: Fix incorrect length=
 to fallocate())
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (28a7327d99dc Merge branch 'for-next-next-v5.17-2022=
0304' into for-next-20220304)
Merging ceph/master (ad5255c1ea9c ceph: misc fix for code style and logs)
Merging cifs/for-next (c9e745fc495d cifs: fix handlecache and multiuser)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (22ba5e99b96f erofs: fix ztailpacking on > 4GiB filesyste=
ms)
Merging exfat/dev (dd81e1c7d5fb Merge tag 'powerpc-5.17-2' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging ext3/for_next (487606687984 Merge reiserfs deprecation patch.)
Merging ext4/dev (cc5095747edf ext4: don't BUG if someone dirty pages witho=
ut asking ext4 first)
Merging f2fs/dev (6c4d1a169863 f2fs: introduce F2FS_UNFAIR_RWSEM to support=
 unfair rwsem)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (c086df490257 fuse: move FUSE_SUPER_MAGIC definition =
to magic.h)
Merging gfs2/for-next (b2963932346f gfs2: Remove return value for gfs2_indi=
rect_init)
Merging jfs/jfs-next (c48a14dca2cb JFS: fix memleak in jfs_mount)
Merging ksmbd/ksmbd-for-next (1a927cda94ac Documentation: ksmbd: update Fea=
ture Status table)
Merging nfs/linux-next (6c984083ec24 NFS: Use of mapping_set_error() result=
s in spurious errors)
Merging nfs-anna/linux-next (d19e0183a883 NFS: Do not report writeback erro=
rs in nfs_getattr())
Merging nfsd/for-next (bf27a962851b fs/lock: only call lm_breaker_owns_leas=
e if there is conflict.)
Merging ntfs3/master (52e00ea6b26e fs/ntfs3: Update valid size if -EIOCBQUE=
UED)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (94fd19752b28 ovl: don't fail copy up if n=
o fileattr support on upper)
Merging ubifs/next (aa39cc675799 jffs2: GC deadlock reading a page that is =
used in jffs2_write_begin())
Merging v9fs/9p-next (22e424feb665 Revert "fs/9p: search open fids first")
Merging xfs/for-next (b97cca3ba909 xfs: only bother with sync_filesystem du=
ring readonly remount)
Merging zonefs/for-next (95b115332a83 zonefs: remove redundant null bio che=
ck)
Merging iomap/iomap-for-next (ebb7fb1557b1 xfs, iomap: limit individual ioe=
nd chain lengths in writeback)
Merging djw-vfs/vfs-for-next (2d86293c7075 xfs: return errors in xfs_fs_syn=
c_fs)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (124f75f864f3 clean overflow checks in count_mounts() =
a bit)
CONFLICT (content): Merge conflict in arch/x86/um/Kconfig
Merging printk/for-next (c5f75d490fc2 Merge branch 'for-5.18' into for-next)
Merging pci/next (b3c57902bef6 Merge branch 'remotes/lorenzo/pci/uniphier')
Merging pstore/for-next/pstore (023bbde3db41 pstore: Add prefix to ECC mess=
ages)
Merging hid/for-next (cde4b57a1c51 Merge branch 'for-5.17/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (867dfe1041a0 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (72a4501b5d08 i3c: support dynamically added i2c devic=
es)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (007e433cf037 hwmon: Add driver for Texas =
Instruments TMP464 and TMP468)
Merging jc_docs/docs-next (0d6356d6cdd0 docs: fix 'make htmldocs' warning i=
n perf)
Merging v4l-dvb/master (2b891d3980f6 media: xilinx: csi2rxss: Use mipi-csi2=
.h)
Merging v4l-dvb-next/master (2881ca629984 media: Makefiles: sort entries wh=
ere it fits)
Merging pm/linux-next (87852f90dc5a Merge branches 'acpi-apei' and 'acpi-do=
cs' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (72951a77c00f cpufreq: blocklist=
 Qualcomm sc8280xp and sa8540p in cpufreq-dt-platdev)
Merging cpupower/cpupower (8382dce5e483 cpupower: Add "perf" option to prin=
t AMD P-State information)
Merging devfreq/devfreq-next (26291c54e111 Linux 5.17-rc2)
Merging opp/opp/linux-next (f48a0c475c2a Documentation: EM: Describe new re=
gistration method using DT)
Merging thermal/thermal/linux-next (cef4b473c499 thermal/drivers/brcmstb_th=
ermal: Interrupt is optional)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (feae43f8aa88 fs: dlm: print cluster addr if non-cluster n=
ode connects)
Merging rdma/for-next (73f7e05609ec RDMA/hns: Refactor the alloc_cqc())
Merging net-next/master (669b258a793d bonding: helper macro __ATTR_RO to ma=
ke code more clear)
CONFLICT (content): Merge conflict in drivers/hwmon/adt7310.c
CONFLICT (content): Merge conflict in net/dsa/dsa2.c
Merging bpf-next/for-next (c344b9fc2108 Merge branch 'bpf: add __percpu tag=
ging in vmlinux BTF')
Merging ipsec-next/master (2ecda181682e xfrm: delete duplicated functions t=
hat calls same xfrm_api_check())
Merging mlx5-next/mlx5-next (45fee8edb4b3 net/mlx5: Add clarification on sy=
nc reset failure)
Merging netfilter-next/master (c828414ac935 netfilter: nft_compat: suppress=
 comment match)
Merging ipvs-next/master (c828414ac935 netfilter: nft_compat: suppress comm=
ent match)
Merging bluetooth/master (669b258a793d bonding: helper macro __ATTR_RO to m=
ake code more clear)
Merging wireless-next/main (e715f10f3d05 rtw89: get channel parameters of 1=
60MHz bandwidth)
CONFLICT (content): Merge conflict in net/mac80211/mlme.c
Merging mtd/mtd/next (2365f91c861c mtd: parsers: trx: allow to use on Media=
Tek MIPS SoCs)
Merging nand/nand/next (ffb16c1c4267 mtd: rawnand: stm32_fmc2: Add NAND Wri=
te Protect support)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mtd=
/nand-controller.yaml
Merging spi-nor/spi-nor/next (3c552889e431 mtd: spi-nor: renumber flags)
Merging crypto/master (280ee3c3aaa8 crypto: octeontx2 - fix missing unlock)
Merging drm/drm-next (6de7e4f02640 Merge tag 'drm-msm-next-2022-03-01' of h=
ttps://gitlab.freedesktop.org/drm/msm into drm-next)
CONFLICT (modify/delete): Documentation/devicetree/bindings/display/mediate=
k/mediatek,disp.txt deleted in drm/drm-next and modified in HEAD.  Version =
HEAD of Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t left in tree.
$ git rm -f Documentation/devicetree/bindings/display/mediatek/mediatek,dis=
p.txt
Applying: fix up for "media: dt-binding: mediatek: Get rid of mediatek,larb=
 for multimedia HW"
Merging drm-misc/for-linux-next (07f380da3ebd drm/panel: simple: Fix Innolu=
x G070Y2-L01 BPP settings)
Merging amdgpu/drm-next (0f3dfaeec830 drm/radeon: Add HD-audio component no=
tifier support (v2))
Merging drm-intel/for-linux-next (6de7e4f02640 Merge tag 'drm-msm-next-2022=
-03-01' of https://gitlab.freedesktop.org/drm/msm into drm-next)
Merging drm-tegra/drm/tegra/for-next (b53c24f69199 drm/tegra: Support YVYU,=
 VYUY and YU24 formats)
Merging drm-msm/msm-next (5f9ffe898033 drm/msm/a6xx: Zap counters across co=
ntext switch)
Merging imx-drm/imx-drm/next (20fbfc81e390 drm/imx: imx-tve: Make use of th=
e helper function devm_platform_ioremap_resource())
Merging etnaviv/etnaviv/next (cdd156955f94 drm/etnaviv: consider completed =
fence seqno in hang check)
Applying: fix up for "spi: make remove callback a void function"
Merging fbdev/for-next (4f01d09b2bbf video: fbdev: sm712fb: Fix crash in sm=
tcfb_write())
Merging regmap/for-next (2d2329787ba2 regmap: irq: cleanup comments)
Merging sound/for-next (fc4cf4293f0d ALSA: x86: Use standard mmap helper fo=
r Intel HDMI LPE audio)
Merging sound-asoc/for-next (6984974883ca Merge remote-tracking branch 'aso=
c/for-5.18' into asoc-next)
Merging modules/modules-next (719fce7539cd Merge tag 'soc-fixes-5.17-2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc)
Merging input/next (f28af984e771 Input: mt6779-keypad - add MediaTek keypad=
 driver)
Merging block/for-next (bf5c73617cf0 Merge branch 'for-5.18/drivers' into f=
or-next)
CONFLICT (content): Merge conflict in fs/iomap/direct-io.c
Merging device-mapper/for-next (c4fdab6d5c6b dm: support bio polling)
Merging libata/for-next (4dd4d3deb502 ata: ahci: Rename CONFIG_SATA_LPM_MOB=
ILE_POLICY configuration item)
Merging pcmcia/pcmcia-next (3928cf08334e pcmcia: db1xxx_ss: restrict to MIP=
S_DB1XXX boards)
Merging mmc/next (1f311c94aabd mmc: rtsx: add 74 Clocks in power on flow)
Merging mfd/for-mfd-next (7a69f34ab44d mfd: atmel-flexcom: fix compilation =
warning)
Merging backlight/for-backlight-next (ec961cf32411 backlight: qcom-wled: Re=
spect enabled-strings in set_brightness)
Merging battery/for-next (75853406fa27 power: supply: Add a driver for Injo=
inic power bank ICs)
Merging regulator/for-next (29bfeed6be0c Merge remote-tracking branch 'regu=
lator/for-5.18' into regulator-next)
Merging security/next-testing (047843bdb316 Merge branch 'landlock_lsm_v34'=
 into next-testing)
Merging apparmor/apparmor-next (c2489617b3b9 apparmor: Fix undefined refere=
nce to `zlib_deflate_workspacesize')
Merging integrity/next-integrity (cd3bc044af48 KEYS: encrypted: Instantiate=
 key with user-provided decrypted data)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (cdbec3ede0b8 selinux: shorten the policy capability e=
num names)
Merging smack/next (a5cd1ab7ab67 Fix incorrect type in assignment of ipv6 p=
ort for audit)
Merging tomoyo/master (b9c20da356db workqueue: Warn flushing of kernel-glob=
al workqueues)
Merging tpmdd/next (998cfca72638 KEYS: asymmetric: properly validate hash_a=
lgo and encoding)
Merging watchdog/master (cfb92440ee71 Linux 5.17-rc5)
Merging iommu/next (963d0c21c009 Merge branches 'arm/mediatek', 'arm/msm', =
'arm/renesas', 'arm/rockchip', 'iommu/fixes', 'x86/vt-d', 'core' and 'x86/a=
md' into next)
Merging audit/next (272ceeaea355 audit: log AUDIT_TIME_* records only from =
rules)
Merging devicetree/for-next (dca669354e6f dt-bindings: Another pass removin=
g cases of 'allOf' containing a '$ref')
Merging mailbox/mailbox-for-next (869b6ca39c08 dt-bindings: mailbox: Add mo=
re protocol and client ID)
Merging spi/for-next (a3d3c11c0424 Merge remote-tracking branch 'spi/for-5.=
18' into spi-next)
CONFLICT (modify/delete): arch/arm/mach-pxa/stargate2.c deleted in HEAD and=
 modified in spi/for-next.  Version spi/for-next of arch/arm/mach-pxa/starg=
ate2.c left in tree.
$ git rm -f arch/arm/mach-pxa/stargate2.c
Merging tip/auto-latest (a66320f04160 Merge branch into tip/master: 'core/c=
ore')
CONFLICT (content): Merge conflict in drivers/iommu/intel/iommu.c
Merging clockevents/timers/drivers/next (e39a56013171 clocksource/drivers/i=
mx-tpm: Move tpm_read_sched_clock() under CONFIG_ARM)
Merging edac/edac-for-next (1e2e0e53092b Merge branch 'edac-amd64' into eda=
c-for-next)
Merging irqchip/irq/irqchip-next (97dcde2a5279 Merge branch irq/meson-gpio =
into irq/irqchip-next)
CONFLICT (content): Merge conflict in drivers/pinctrl/pinctrl-starfive.c
Merging ftrace/for-next (864ea0e10cc9 user_events: Add documentation file)
Merging rcu/rcu/next (1498a74770d7 torture: Enable CSD-lock stall reports f=
or scftorture)
CONFLICT (content): Merge conflict in kernel/rcu/tree_plugin.h
Merging kvm/next (0564eeb71bbb Merge branch 'kvm-bugfixes' into HEAD)
Merging kvm-arm/next (947a4a402d9d Merge branch kvm-arm64/misc-5.18 into kv=
marm-master/next)
Merging kvms390/next (ee6a569d3bf6 KVM: s390: pv: make use of ultravisor AI=
V support)
Merging xen-tip/linux-next (f66edf684edc xen/pci: Make use of the helper ma=
cro LIST_HEAD())
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (bc35f7ef9628 workqueue: Convert the type of po=
ol->nr_running to int)
Merging drivers-x86/for-next (cb18448bbf1c platform/x86: x86-android-tablet=
s: Lenovo Yoga Tablet 2 830/1050 sound support)
CONFLICT (content): Merge conflict in drivers/platform/x86/thinkpad_acpi.c
Merging chrome-platform/for-next (b579f139e470 platform/chrome: cros_ec_typ=
ec: Update mux flags during partner removal)
Merging hsi/for-next (e783362eb54c Linux 5.17-rc1)
Merging leds/for-next (e26557a0aa68 leds: pca955x: Allow zero LEDs to be sp=
ecified)
Merging ipmi/for-next (f4676c8ec396 ipmi: kcs: aspeed: Remove old bindings =
support)
Merging driver-core/driver-core-next (4a248f85b3dd Merge 5.17-rc6 into driv=
er-core-next)
CONFLICT (content): Merge conflict in drivers/power/supply/ab8500_chargalg.c
Merging usb/usb-next (98d107b84614 usb: host: xhci: Remove some unnecessary=
 return value initializations)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/qcom/ipq6018.dtsi
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/xilinx/zynqmp.dtsi
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (e1d15646565b USB: serial: pl2303: add IBM devi=
ce IDs)
Merging usb-chipidea-next/for-usb-next (78665f57c3fa usb: chipidea: udc: ma=
ke controller hardware endpoint primed)
Merging tty/tty-next (3631e48df0db serial: samsung: Add samsung_early_read =
to support early kgdboc)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging char-misc/char-misc-next (3dd9a926ec23 mmc: rtsx: Fix build errors/=
warnings for unused variable)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging extcon/extcon-next (b26c5f03a645 extcon: Fix some kernel-doc commen=
ts)
CONFLICT (content): Merge conflict in drivers/power/supply/max8997_charger.c
Merging gnss/gnss-next (26291c54e111 Linux 5.17-rc2)
Merging phy-next/next (c6455af54899 phy: qcom-qmp: add sc8280xp UFS PHY)
CONFLICT (modify/delete): Documentation/devicetree/bindings/phy/qcom,usb-hs=
-phy.txt deleted in phy-next/next and modified in HEAD.  Version HEAD of Do=
cumentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt left in tree.
$ git rm -f Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
Applying: merge fix for "dt-bindings: phy: qcom,usb-hs-phy: add MSM8226 com=
patible"
Merging soundwire/next (266fa94673d3 soundwire: qcom: use __maybe_unused fo=
r swrm_runtime_resume())
Merging thunderbolt/next (144c4a77a3e1 thunderbolt: Rename EEPROM handling =
bits to match USB4 spec)
Merging vfio/next (f8a665b15947 Merge branches 'v5.18/vfio/next/mlx5-migrat=
ion-v10', 'v5.18/vfio/next/pm-fixes' and 'v5.18/vfio/next/uml-build-fix' in=
to v5.18/vfio/next/next)
Merging staging/staging-next (b25c7dc13fb8 staging: rts5208: fix Lines shou=
ld not end with a '('.)
CONFLICT (content): Merge conflict in drivers/staging/fbtft/fbtft.h
Merging iio/togreg (0bf126163c3e iio: adc: xilinx-ams: Fix single channel s=
witching sequence)
CONFLICT (content): Merge conflict in .mailmap
CONFLICT (content): Merge conflict in drivers/iio/accel/fxls8962af-core.c
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging icc/icc-next (52c85167e413 Merge branch 'icc-msm8939' into icc-next)
Merging dmaengine/next (ea7c8f598c32 dmaengine: idxd: restore traffic class=
 defaults after wq reset)
Merging cgroup/for-next (88ea791b5665 Merge branch 'for-5.17-fixes' into fo=
r-next)
Merging scsi/for-next (f6de306274ab Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in block/blk-lib.c
CONFLICT (content): Merge conflict in block/blk-merge.c
CONFLICT (content): Merge conflict in drivers/block/drbd/drbd_worker.c
CONFLICT (content): Merge conflict in drivers/block/rnbd/rnbd-clt.c
Merging scsi-mkp/for-next (f2ddbbea7780 scsi: lpfc: Copyright updates for 1=
4.2.0.0 patches)
Merging vhost/linux-next (797e2683c561 tools/virtio: fix after premapped bu=
f support)
CONFLICT (content): Merge conflict in drivers/block/virtio_blk.c
Merging rpmsg/for-next (c060cc0014c9 Merge branch 'rproc-next' into for-nex=
t)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (37db988c3629 Merge tag 'intel-gpio-v5.18-1=
' of gitolite.kernel.org:pub/scm/linux/kernel/git/andy/linux-gpio-intel int=
o gpio/for-next)
Merging gpio-intel/for-next (a1ce76e89907 gpio: tps68470: Allow building as=
 module)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (842366d7cb68 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (d25478e1d8f9 pinctrl: icelake: Add Ice Lake=
-N PCH pin controller support)
Merging pinctrl-renesas/renesas-pinctrl (babe298e9caa pinctrl: renesas: r8a=
779f0: Add Ethernet pins, groups, and functions)
Merging pinctrl-samsung/for-next (3652dc070bad pinctrl: samsung: improve wa=
ke irq info on console)
Merging pwm/for-next (ed14d36498c8 pwm: rcar: Simplify multiplication/shift=
 logic)
Merging userns/for-next (0ac983f51203 ucounts: Fix systemd LimitNPROC with =
private users regression)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (f6d344cd5fa6 selftests: Fix build when $(O) points =
to a relative path)
Merging livepatching/for-next (b44a7f076ce1 Merge branch 'for-5.18/selftest=
s-fixes' into for-next)
Merging coresight/next (b54f53bc11a5 coresight: Drop unused 'none' enum val=
ue for each component)
Merging rtc/rtc-next (73ce05302007 rtc: pcf2127: fix bug when reading alarm=
 registers)
Merging nvdimm/libnvdimm-for-next (2166a9974902 dax: make sure inodes are f=
lushed before destroy cache)
Merging at24/at24/for-next (e783362eb54c Linux 5.17-rc1)
Merging ntb/ntb-next (d2bda1500aa8 IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (eed09ad26182 samples/seccomp: Adjust samp=
le to also provide kill option)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (f2af60bb7ce2 fsi: Add trace events in initialization path)
Merging slimbus/for-next (e783362eb54c Linux 5.17-rc1)
Merging nvmem/for-next (bdf79b27260b dt-bindings: nvmem: brcm,nvram: add ba=
sic NVMEM cells)
CONFLICT (add/add): Merge conflict in Documentation/devicetree/bindings/nvm=
em/sunplus,sp7021-ocotp.yaml
CONFLICT (content): Merge conflict in MAINTAINERS
Merging xarray/main (22f56b8e890d XArray: Include bitmap.h from xarray.h)
Merging hyperv/hyperv-next (1d7286729aa6 hv_balloon: rate-limit "Unhandled =
message" warning)
Merging auxdisplay/auxdisplay (9ed331f8a0fb auxdisplay: lcd2s: Use proper A=
PI to free the instance of charlcd object)
Merging kgdb/kgdb/for-next (b77dbc86d604 kdb: Adopt scheduler's task classi=
fication)
Merging hmm/hmm (6880fa6c5660 Linux 5.15-rc1)
Merging fpga/for-next (21f0a239ecab fpga: dfl: pci: Remove usage of the dep=
recated "pci-dma-compat.h" API)
Merging kunit/test (e783362eb54c Linux 5.17-rc1)
Merging cfi/cfi/next (e783362eb54c Linux 5.17-rc1)
Merging kunit-next/kunit (5debe5bfa02c list: test: Add a test for list_entr=
y_is_head())
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (0d02ea60ea13 bus: mhi: ep: Add uevent support for mod=
ule autoloading)
Merging memblock/for-next (2a7ceac9e581 memblock tests: Fix testing with 32=
-bit physical addresses)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (e6e17cc6ed75 cxl/core: Fix cxl_device_lock() class detect=
ion)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (2baa81c83f6f efifb: Remove redundant efifb_setup_from_dmi=
 stub)
Merging unicode/for-next (5298d4bfe80f unicode: clean up the Kconfig symbol=
 confusion)
Merging slab/for-next (d3d59937afdf Merge branch 'for-5.18/trivial' into fo=
r-next)
Merging random/master (d0d793c28700 random: use SipHash as interrupt entrop=
y accumulator)
Merging landlock/next (7325fd5614aa Merge Landlock fixes into next)
Merging rust/rust-next (847245fe812e init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
Merging sysctl/sysctl-next (fc12aa67daba kernel/do_mount_initrd: move real_=
root_dev sysctls to its own file)
CONFLICT (content): Merge conflict in include/linux/sched/sysctl.h
CONFLICT (content): Merge conflict in kernel/sysctl.c
Merging folio/for-next (0488343ba3dd selftests/vm/transhuge-stress: Support=
 file-backed PMD folios)
CONFLICT (modify/delete): arch/nds32/include/asm/pgtable.h deleted in HEAD =
and modified in folio/for-next.  Version folio/for-next of arch/nds32/inclu=
de/asm/pgtable.h left in tree.
CONFLICT (content): Merge conflict in drivers/gpu/drm/drm_cache.c
$ git rm -f arch/nds32/include/asm/pgtable.h
Merging execve/for-next/execve (9e1a3ce0a952 binfmt_elf: Introduce KUnit te=
st)
Merging kspp/for-next/kspp (1b01a23d9a48 Merge branch 'for-next/hardening' =
into for-next/kspp)
Applying: drm/bridge: it6505: Fix the read buffer array bound
Applying: drm/dp: Fix OOB read when handling Post Cursor2 register
Applying: drm/dp: Fix off-by-one in register cache size
Merging kspp-gustavo/for-next/kspp (91adfbb14c00 Merge branch 'for-next/ksp=
p-fam0' into for-next/kspp)
Merging akpm-current/current (a36f330518af ipc/mqueue: use get_tree_nodev()=
 in mqueue_get_tree())
CONFLICT (content): Merge conflict in Documentation/admin-guide/sysctl/kern=
el.rst
CONFLICT (modify/delete): arch/nds32/mm/init.c deleted in HEAD and modified=
 in akpm-current/current.  Version akpm-current/current of arch/nds32/mm/in=
it.c left in tree.
CONFLICT (content): Merge conflict in include/linux/sched/sysctl.h
CONFLICT (content): Merge conflict in lib/Kconfig.debug
CONFLICT (content): Merge conflict in mm/Kconfig
CONFLICT (content): Merge conflict in mm/huge_memory.c
CONFLICT (content): Merge conflict in mm/internal.h
CONFLICT (content): Merge conflict in mm/memcontrol.c
CONFLICT (content): Merge conflict in mm/memory-failure.c
CONFLICT (content): Merge conflict in mm/memory.c
CONFLICT (content): Merge conflict in mm/memremap.c
CONFLICT (content): Merge conflict in mm/rmap.c
CONFLICT (content): Merge conflict in mm/vmscan.c
CONFLICT (modify/delete): tools/testing/radix-tree/linux/gfp.h deleted in H=
EAD and modified in akpm-current/current.  Version akpm-current/current of =
tools/testing/radix-tree/linux/gfp.h left in tree.
$ git rm -f tools/testing/radix-tree/linux/gfp.h arch/nds32/mm/init.c
Applying: fix up for "tools: Move gfp.h and slab.h from radix-tree to lib"
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (709d3cc300d4 kselftest/vm: override TARGETS from argum=
ents)

--Sig_/ifDTcMX700MvmTJ4CbUktRx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIlzAEACgkQAVBC80lX
0GyYjwf+MwFdTE1aVM0NzYkrt1pVN11Xn6Q58KhW2pxGVpfLv+v57TMPJHsnr70l
c0i/qU1cWGgY5/2hetuhcX80xG+LM2V5LvtFGx8TRI1jFCR/qI/vWWZri2lr2Z6S
xvEuWjaLFOWzF3FJHolJA1nYad0HiALCxae2EzJhVaM1UJqGG8adV+O2Zh89/HXh
W4UDPMnRFvlHSI9UI8sZq9eCxQPfSXQ21QBhmA6ls+kyOt3SrYGvN+gDjtQeHuYP
MoOEGjktLB/4NI/AOCP0WEvivf24S8jyhV4hhmRYrP+tZYyLutPBE6LSA+Vwi0sq
Opc7PfCQTmMrHf9Ld7W8lc0yJyZUhw==
=Fupq
-----END PGP SIGNATURE-----

--Sig_/ifDTcMX700MvmTJ4CbUktRx--
