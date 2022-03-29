Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D87E4EA592
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiC2C4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiC2C4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:56:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BDC5A5B4;
        Mon, 28 Mar 2022 19:54:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KSDfv2NKlz4x7X;
        Tue, 29 Mar 2022 13:54:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648522455;
        bh=P+Is3sVED67eyagzV/Jkc/77LwTMdLNVTkkwwT3mZaU=;
        h=Date:From:To:Cc:Subject:From;
        b=bxSTR/tBp+lFgsfI7DZla2DUibAnZv4X5Wqj9x1AK7MG1OjlAQ9Prp0v3KETwH43M
         cVeDCIuxYJJf2gkzGdn2QZ8yXbmghFRLCxXb7xPakTW0zFdJSLduZrJJ0O3dMEZS8I
         BR5ImEXLNPtKXv5A1B0IjnF+JgK8+JKSJzqCMFM8IWcIqDtAJhhX22TcjvWJTmjh6s
         r82C1wEMSeOzjx/UeUzxzONxrKsoOrvMIZgQ8pPZ07hZO+8zqN/O6Is4ZuUxTPXkbC
         uCR/Cfl5sqJtSgyJe2d2zq0I79ZwWtcGcryzFHH/oTbiYddg+ET0XZT6xAzSsqcckY
         o9ujYfU+EY/5Q==
Date:   Tue, 29 Mar 2022 13:54:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 29
Message-ID: <20220329135414.6288ee69@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P2notgM5WXQlFwxPpArzuI=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P2notgM5WXQlFwxPpArzuI=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do not add any v5.19 material to your linux-next included trees
until after v5.18-rc1 has been released.

Changes since 20220328:

Linus' tree lost its build failure.

Non-merge commits (relative to Linus' tree): 1347
 1565 files changed, 74636 insertions(+), 20834 deletions(-)

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
Merging origin/master (7203062171db Merge tag 'tty-5.18-rc1' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/gregkh/tty)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (754e0b0e3560 Linux 5.17-rc4)
Merging arc-current/for-curr (e783362eb54c Linux 5.17-rc1)
Merging arm-current/fixes (7b83299e5b93 ARM: 9182/1: mmu: fix returns from =
early_param() and __setup() functions)
Merging arm64-fixes/for-next/fixes (316e46f65a54 arm64: errata: avoid dupli=
cate field initializer)
Merging arm-soc-fixes/arm/fixes (6a2f0b2d3b74 dt: amd-seattle: add a descri=
ption of the CPUs and caches)
Merging drivers-memory-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging tee-fixes/fixes (6d8df1f9e8ae Merge tag 'optee-fix2-for-v5.17' into=
 fixes)
Merging m68k-current/for-linus (1a0ae068bf6b m68k: defconfig: Update defcon=
figs for v5.16-rc1)
Merging powerpc-fixes/fixes (48015b632f77 powerpc: Fix STACKTRACE=3Dn build)
Merging s390-fixes/fixes (f443e374ae13 Linux 5.17)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (dcf500065fab net: bnxt_ptp: fix compilation error)
Merging bpf/master (d9142e1cf3bb selftests: net: Add tls config dependency =
for tls selftests)
Merging ipsec/master (4db4075f92af esp6: fix check on ipv6_skip_exthdr's re=
turn value)
Merging netfilter/master (dea2d93a8ba4 Merge branch '100GbE' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/tnguy/net-queue)
Merging ipvs/master (277f2bb14361 ibmvnic: schedule failover only if vioctl=
 fails)
Merging wireless/main (24b488061b97 MAINTAINERS: update Lorenzo's email add=
ress)
Merging rdma-fixes/for-rc (7e57714cd0ad Linux 5.17-rc6)
Merging sound-current/for-linus (5e2baa04e4cd ALSA: hda/cs8409: Add new Dol=
phin HW variants)
Merging sound-asoc-fixes/for-linus (b0793cb5c40e Merge remote-tracking bran=
ch 'asoc/for-5.17' into asoc-linus)
Merging regmap-fixes/for-linus (d04ad245d67a regmap-irq: Update interrupt c=
lear register for proper reset)
Merging regulator-fixes/for-linus (78beedbc6af3 Merge remote-tracking branc=
h 'regulator/for-5.17' into regulator-linus)
Merging spi-fixes/for-linus (d583fe25614f Merge remote-tracking branch 'spi=
/for-5.16' into spi-linus)
Merging pci-current/for-linus (5949965ec934 x86/PCI: Preserve host bridge w=
indows completely covered by E820)
Merging driver-core.current/driver-core-linus (7e57714cd0ad Linux 5.17-rc6)
Merging tty.current/tty-linus (7e57714cd0ad Linux 5.17-rc6)
Merging usb.current/usb-linus (ae085d7f9365 mm: kfence: fix missing objcg h=
ousekeeping for SLAB)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (7e57714cd0ad Linux 5.17-rc6)
Merging usb-chipidea-fixes/for-usb-fixes (f130d08a8d79 usb: chipidea: ci_hd=
rc_imx: Also search for 'phys' phandle)
CONFLICT (content): Merge conflict in drivers/usb/chipidea/ci_hdrc_imx.c
Merging phy/fixes (9a8406ba1a9a phy: dphy: Correct clk_pre parameter)
Merging staging.current/staging-linus (09688c0166e7 Linux 5.17-rc8)
Merging iio-fixes/fixes-togreg (123d838c4e7d iio: adc: xilinx-ams: Fix sing=
le channel switching sequence)
Merging counter-fixes/fixes-togreg (4a14311a3b93 counter: Stop using dev_ge=
t_drvdata() to get the counter device)
Merging char-misc.current/char-misc-linus (01b44ef2bf6b counter: Stop using=
 dev_get_drvdata() to get the counter device)
Merging soundwire-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging thunderbolt-fixes/fixes (f443e374ae13 Linux 5.17)
Merging input-current/for-linus (5600f6986628 Input: aiptek - properly chec=
k endpoint type)
Merging crypto-current/master (7ed7aa4de942 crypto: x86/poly1305 - Fixup SL=
S)
Merging vfio-fixes/for-linus (8704e8934908 vfio/pci: Fix OpRegion read)
Merging kselftest-fixes/fixes (6fec1ab67f8d selftests/ftrace: Do not trace =
do_softirq because of PREEMPT_RT)
Merging modules-fixes/modules-linus (a8e8f851e829 module: fix building with=
 sysfs disabled)
Merging dmaengine-fixes/fixes (cfb92440ee71 Linux 5.17-rc5)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (42da5a4ba170 mtd: rawnand: omap2: Actually pre=
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
Merging kvm-fixes/master (fe83f5eae432 kvm/emulate: Fix SETcc emulation fun=
ction offsets with SLS)
Merging kvms390-fixes/master (0e9ff65f455d KVM: s390: preserve deliverable_=
mask in __airqs_kick_single_vcpu)
Merging hwmon-fixes/hwmon (c1ebdafde1ee hwmon: (xdpe12284) Fix build warnin=
g seen if CONFIG_SENSORS_XDPE122_REGULATOR is disabled)
Merging nvdimm-fixes/libnvdimm-fixes (3dd60fb9d95d nvdimm/pmem: stop using =
q_usage_count as external pgmap refcount)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (95385bb74f40 Merge branch 'misc-5.18' into =
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
Merging devicetree-fixes/dt/linus (f6eafa4022dd dt-bindings: phy: ti,tcan10=
4x-can: Document mux-states property)
Merging scsi-fixes/fixes (733ab7e1b5d1 scsi: fnic: Finish scsi_cmnd before =
dropping the spinlock)
Merging drm-fixes/drm-fixes (f443e374ae13 Linux 5.17)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (09688c0166e7 Linux 5.17-rc8)
Merging mmc-fixes/fixes (6f2e03c11ef6 mmc: block: Check for errors after wr=
ite on SPI)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (e783362eb54c Linux 5.17-rc1)
Merging hyperv-fixes/hyperv-fixes (ffc58bc4af93 Drivers: hv: utils: Make us=
e of the helper macro LIST_HEAD())
Merging soc-fsl-fixes/fix (a222fd854139 soc: fsl: qe: Check of ioremap retu=
rn value)
Merging risc-v-fixes/fixes (0966d385830d riscv: Fix auipc+jalr relocation r=
ange checks)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (8bb7eca972ad Linux 5.15)
Merging spdx/spdx-linus (ae085d7f9365 mm: kfence: fix missing objcg houseke=
eping for SLAB)
Merging gpio-brgl-fixes/gpio/for-current (6556641ded02 gpio: ts4900: Fix co=
mment formatting and grammar)
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
CONFLICT (content): Merge conflict in fs/ubifs/file.c
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (5f7b839d47db SUNRPC: Return true/false (not 1/0) =
from bool functions)
Merging irqchip-fixes/irq/irqchip-fixes (1d4df649cbb4 irqchip/sifive-plic: =
Add missing thead,c900-plic match string)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (a04b1bf574e1 Merge tag 'for-5.18/parisc-1=
' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux)
Merging efi-fixes/urgent (9feaf8b387ee efi: fix return value of __setup han=
dlers)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging drm-misc-fixes/for-linux-next-fixes (d14eb80e2779 drm/panel: ili934=
1: fix optional regulator handling)
Merging kbuild/for-next (63a62caad508 Merge branch 'kbuild' into for-next)
Merging perf/perf/core (ab0809af0bee perf evsel: Improve AMD IBS (Instructi=
on-Based Sampling) error handling messages)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (8ddde07a3d28 dma-mapping: benchmark: extract =
a common header file for map_benchmark definition)
Merging asm-generic/master (aec499c75cf8 nds32: Remove the architecture)
Merging arc/for-next (6880fa6c5660 Linux 5.15-rc1)
Merging arm/for-next (b717496e1158 Merge branch 'devel-stable' into for-nex=
t)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
CONFLICT (content): Merge conflict in arch/arm/Kconfig
CONFLICT (content): Merge conflict in arch/arm/Kconfig.debug
CONFLICT (content): Merge conflict in arch/arm/include/asm/switch_to.h
CONFLICT (content): Merge conflict in arch/arm/kernel/traps.c
Merging arm64/for-next/core (641d80415729 Merge branch 'for-next/spectre-bh=
b' into for-next/core)
Merging arm-perf/for-next/perf (602c873eb52e perf: Replace acpi_bus_get_dev=
ice())
Merging arm-soc/for-next (6a2f0b2d3b74 dt: amd-seattle: add a description o=
f the CPUs and caches)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (305cab6f7645 Merge branch 'v5.18/drivers' into fo=
r-next)
Merging aspeed/for-next (d9540eeaa3d1 Merge branches 'nuvoton-dt-for-v5.18'=
 and 'dt-for-v5.18' into for-next)
Merging at91/at91-next (a845fa592554 Merge branch 'clk-at91' into at91-next)
Merging drivers-memory/for-next (560f9d092a9d Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (45550ada88f0 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (6ceb6a96db4e Merge branch 'v5.17-fixes' into for=
-next)
Merging mvebu/for-next (8885ae5142a4 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (f9ecc209330a Merge branch 'omap-for-v5.18/dt' into f=
or-next)
Merging qcom/for-next (b8277c8275a1 Merge branches 'arm64-defconfig-for-5.1=
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
Merging rockchip/for-next (73b0466cfade Merge branch 'v5.18-armsoc/dts64' i=
nto for-next)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/rockchip/rk356x.d=
tsi
Merging samsung-krzk/for-next (b2d5c4016a34 Merge branch 'for-v5.18/dt-clea=
nup' into for-next)
Merging scmi/for-linux-next (0bf3cf81c78b Merge tag 'scmi-updates-5.18' of =
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
Merging clk/clk-next (3fb2cf242e74 Merge branch 'clk-range' into clk-next)
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
Merging m68knommu/for-next (e6e1e7b19fa1 m68k: coldfire/device.c: only buil=
d for MCF_EDMA when h/w macros are defined)
Merging microblaze/next (fcc619621df5 microblaze/PCI: Remove pci_phys_mem_a=
ccess_prot() dead code)
Merging mips/mips-next (f8f9f21c7848 MIPS: Fix build error for loongson64 a=
nd sgi-ip27)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (862cf8d5fd98 openrisc/boot: Remove unnecessary i=
nitialisation in memcpy().)
Merging parisc-hd/for-next (c33b0499bdfd parisc: Find a new timesync master=
 if current CPU is removed)
Merging powerpc/next (fe2640bd7a62 powerpc/pseries: Fix use after free in r=
emove_phb_dynamic())
Merging soc-fsl/next (1ce93cb102e7 soc: fsl: qe: Check of ioremap return va=
lue)
Merging risc-v/for-next (bbde015227e8 RISC-V: add support for restartable s=
equences)
Merging s390/for-next (faf79934e65a s390/alternatives: avoid using jgnop mn=
emonic)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (82017457957a um: run_helper: Write error message to=
 kernel log on exec failure on host)
Merging xtensa/xtensa-for-next (1c4664faa389 xtensa: define update_mmu_tlb =
function)
Merging pidfd/for-next (6009ff9e8020 Merge branch 'fs.mount_setattr.fixes' =
into for-next)
Merging fscrypt/master (cdaa1b1941f6 fscrypt: update documentation for dire=
ct I/O support)
Merging fscache/fscache-next (ab487a4cdfca afs: Maintain netfs_i_context::r=
emote_i_size)
CONFLICT (content): Merge conflict in fs/9p/vfs_addr.c
CONFLICT (content): Merge conflict in fs/afs/file.c
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (89a925d75608 Merge branch 'for-next-current-v5.16-2=
0220314' into for-next-20220314)
CONFLICT (content): Merge conflict in fs/btrfs/zoned.c
Merging ceph/master (f639d9867eea ceph: fix memory leak in ceph_readdir whe=
n note_last_dentry returns error)
Merging cifs/for-next (6a96c82ac4c5 smb3: cleanup and clarify status of tre=
e connections)
CONFLICT (content): Merge conflict in fs/ksmbd/smb2pdu.h
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (a1108dcd9373 erofs: rename ctime to mtime)
Merging exfat/dev (1413276f228f exfat: do not clear VolumeDirty in writebac=
k)
Merging ext3/for_next (f06e95c3a4ca Merge fsnotify cleanup from Bang Li.)
Merging ext4/dev (c7cded845fc1 ext4: truncate during setxattr leads to kern=
el panic)
Merging f2fs/dev (519129040766 Merge tag 'for-5.18-tag' of git://git.kernel=
.org/pub/scm/linux/kernel/git/kdave/linux)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (0c4bcfdecb1a fuse: fix pipe buffer lifetime for dire=
ct_io)
Merging gfs2/for-next (e75765151025 gfs2: Make sure FITRIM minlen is rounde=
d up to fs block size)
Merging jfs/jfs-next (a53046291020 jfs: prevent NULL deref in diFree)
Merging ksmbd/ksmbd-for-next (5d4c2759d83b ksmbd: replace usage of found wi=
th dedicated list iterator variable)
Merging nfs/linux-next (d02d81efc756 NFS: Don't loop forever in nfs_do_reco=
alesce())
CONFLICT (content): Merge conflict in fs/nfs/file.c
Merging nfs-anna/linux-next (d19e0183a883 NFS: Do not report writeback erro=
rs in nfs_getattr())
Merging nfsd/for-next (0b5e0caf0b90 fs/lock: only call lm_breaker_owns_leas=
e if there is conflict.)
Merging ntfs3/master (52e00ea6b26e fs/ntfs3: Update valid size if -EIOCBQUE=
UED)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (94fd19752b28 ovl: don't fail copy up if n=
o fileattr support on upper)
Merging ubifs/next (705757274599 ubifs: rename_whiteout: correct old_dir si=
ze computing)
Merging v9fs/9p-next (22e424feb665 Revert "fs/9p: search open fids first")
Merging xfs/for-next (01728b44ef1b xfs: xfs_is_shutdown vs xlog_is_shutdown=
 cage fight)
Merging zonefs/for-next (95b115332a83 zonefs: remove redundant null bio che=
ck)
CONFLICT (content): Merge conflict in fs/zonefs/super.c
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
Merging pci/next (611f841830aa Merge branch 'remotes/lorenzo/pci/xgene')
Merging pstore/for-next/pstore (8126b1c73108 pstore: Don't use semaphores i=
n always-atomic-context code)
Merging hid/for-next (3cc519d82627 Merge branch 'for-5.17/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (5db36559df9b Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (6cbf8b38dfe3 i3c: fix uninitialized variable use in i=
2c setup)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (c1ebdafde1ee hwmon: (xdpe12284) Fix build=
 warning seen if CONFIG_SENSORS_XDPE122_REGULATOR is disabled)
Merging jc_docs/docs-next (9df072c73b98 Documentation: kunit: Fix cross-ref=
erencing warnings)
Merging v4l-dvb/master (71e6d0608e4d media: platform: Remove unnecessary pr=
int function dev_err())
Merging v4l-dvb-next/master (ba2c670ae84b media: nxp: Restrict VIDEO_IMX_MI=
PI_CSIS to ARCH_MXC or COMPILE_TEST)
Merging pm/linux-next (d7c37bca37f8 Merge branch 'pm-docs' into linux-next)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging cpufreq-arm/cpufreq/arm/linux-next (b7f2b0d3511a dt-bindings: cpufr=
eq: cpufreq-qcom-hw: Convert to YAML bindings)
Merging cpupower/cpupower (8382dce5e483 cpupower: Add "perf" option to prin=
t AMD P-State information)
Merging devfreq/devfreq-next (9eb1950bb6f4 PM / devfreq: rk3399_dmc: Avoid =
static (reused) profile)
Merging opp/opp/linux-next (f48a0c475c2a Documentation: EM: Describe new re=
gistration method using DT)
Merging thermal/thermal/linux-next (1379d28e840f thermal: rcar_thermal: Use=
 platform_get_irq_optional() to get the interrupt)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (feae43f8aa88 fs: dlm: print cluster addr if non-cluster n=
ode connects)
Merging rdma/for-next (87e0eacb176f RDMA/nldev: Prevent underflow in nldev_=
stat_set_counter_dynamic_doit())
Merging net-next/master (169e77764adc Merge tag 'net-next-5.18' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging bpf-next/for-next (169e77764adc Merge tag 'net-next-5.18' of git://=
git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging ipsec-next/master (b58b1f563ab7 xfrm: rework default policy structu=
re)
Merging mlx5-next/mlx5-next (45fee8edb4b3 net/mlx5: Add clarification on sy=
nc reset failure)
Merging netfilter-next/master (c84d86a0295c Merge branch '100GbE' of git://=
git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue)
Merging ipvs-next/master (c828414ac935 netfilter: nft_compat: suppress comm=
ent match)
Merging bluetooth/master (864cc8a234cd Bluetooth: mt7921s: Fix the incorrec=
t pointer check)
Merging wireless-next/main (e89600ebeeb1 af_vsock: SOCK_SEQPACKET broken bu=
ffer test)
Merging mtd/mtd/next (6cadd424abb6 Merge tag 'nand/for-5.18' into mtd/next)
Merging nand/nand/next (fecbd4a317c9 mtd: rawnand: atmel: fix refcount issu=
e in atmel_nand_controller_init)
Merging spi-nor/spi-nor/next (151c6b49d679 mtd: spi-nor: Skip erase logic w=
hen SPI_NOR_NO_ERASE is set)
Merging crypto/master (0e03b8fd2936 crypto: xilinx - Turn SHA into a trista=
te and allow COMPILE_TEST)
Merging drm/drm-next (2a81dba4b577 fbdev: Fix cfb_imageblit() for arbitrary=
 image widths)
Merging drm-misc/for-linux-next (519f490db07e dma-buf/sync-file: fix warnin=
g about fence containers)
Merging amdgpu/drm-next (749831acb1f6 drm/amdgpu/jpeg: Add jpeg ras error q=
uery support)
Merging drm-intel/for-linux-next (00f4150d27d2 drm/i915: Fix renamed struct=
 field)
Merging drm-tegra/drm/tegra/for-next (b53c24f69199 drm/tegra: Support YVYU,=
 VYUY and YU24 formats)
Merging drm-msm/msm-next (05241de1f69e dt-bindings: display/msm: another fi=
x for the dpu-qcm2290 example)
Merging imx-drm/imx-drm/next (20fbfc81e390 drm/imx: imx-tve: Make use of th=
e helper function devm_platform_ioremap_resource())
Merging etnaviv/etnaviv/next (cdd156955f94 drm/etnaviv: consider completed =
fence seqno in hang check)
Merging fbdev/for-next (894d02fbfa67 video: fbdev: udlfb: properly check en=
dpoint type)
Merging regmap/for-next (c53d92b4b351 Merge remote-tracking branch 'regmap/=
for-5.18' into regmap-next)
Merging sound/for-next (5e2baa04e4cd ALSA: hda/cs8409: Add new Dolphin HW v=
ariants)
Merging sound-asoc/for-next (b0793cb5c40e Merge remote-tracking branch 'aso=
c/for-5.17' into asoc-linus)
Merging modules/modules-next (719fce7539cd Merge tag 'soc-fixes-5.17-2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc)
Merging input/next (a949087c2285 Input: adi - remove redundant variable z)
Merging block/for-next (3b255fe79c9e Merge branch 'for-5.18/drivers' into f=
or-next)
Merging device-mapper/for-next (4d7bca13dd9a dm: consolidate spinlocks in d=
m_io struct)
Merging libata/for-next (d268afa1ff6f ata: pata_pxa: Use platform_get_irq()=
 to get the interrupt)
Merging pcmcia/pcmcia-next (3928cf08334e pcmcia: db1xxx_ss: restrict to MIP=
S_DB1XXX boards)
Merging mmc/next (dc3d879c6ffa dt-bindings: mmc: renesas,sdhi: Document RZ/=
G2UL SoC)
Merging mfd/for-mfd-next (d99460ed5cdc dt-bindings: mfd: syscon: Add microc=
hip,lan966x-cpu-syscon compatible)
Merging backlight/for-backlight-next (023a8830a628 backlight: backlight: Sl=
ighly simplify devm_of_find_backlight())
Merging battery/for-next (c22fca40522e power: ab8500_chargalg: Use CLOCK_MO=
NOTONIC)
Merging regulator/for-next (78beedbc6af3 Merge remote-tracking branch 'regu=
lator/for-5.17' into regulator-linus)
Merging security/next-testing (047843bdb316 Merge branch 'landlock_lsm_v34'=
 into next-testing)
Merging apparmor/apparmor-next (c2489617b3b9 apparmor: Fix undefined refere=
nce to `zlib_deflate_workspacesize')
Merging integrity/next-integrity (4a48b4c428dc MAINTAINERS: add missing sec=
urity/integrity/platform_certs)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (cdbec3ede0b8 selinux: shorten the policy capability e=
num names)
Merging smack/next (a5cd1ab7ab67 Fix incorrect type in assignment of ipv6 p=
ort for audit)
Merging tomoyo/master (47f62eaa117d workqueue: Warn flushing of kernel-glob=
al workqueues)
Merging tpmdd/next (fb5abce6b2bb tpm: use try_get_ops() in tpm-space.c)
Merging watchdog/master (826270373f17 Watchdog: sp5100_tco: Enable Family 1=
7h+ CPUs)
Merging iommu/next (e17c6debd4b2 Merge branches 'arm/mediatek', 'arm/msm', =
'arm/renesas', 'arm/rockchip', 'arm/smmu', 'x86/vt-d' and 'x86/amd' into ne=
xt)
Merging audit/next (272ceeaea355 audit: log AUDIT_TIME_* records only from =
rules)
Merging devicetree/for-next (d635d9bdb52c dt-bindings: net: snps,dwmac: mod=
ify available values of PBL)
Merging mailbox/mailbox-for-next (1b0d0f7c12d5 dt-bindings: mailbox: add de=
finition for mt8186)
Merging spi/for-next (ebcbbd0316bf Merge remote-tracking branch 'spi/for-5.=
18' into spi-next)
Merging tip/master (ba5a91cc154f Merge branch into tip/master: 'x86/urgent')
Merging clockevents/timers/drivers/next (49c14f94ccfe clocksource/drivers/t=
imer-of: check return value of of_iomap in timer_of_base_init())
Merging edac/edac-for-next (d52ba330befa Merge branch 'edac-misc' into edac=
-for-next)
Merging irqchip/irq/irqchip-next (49cdcea1b077 irqchip/gic-v3: Fix GICR_CTL=
R.RWP polling)
CONFLICT (content): Merge conflict in drivers/pinctrl/nuvoton/pinctrl-npcm7=
xx.c
Merging ftrace/for-next (c87857e21486 Merge branch 'trace/for-next-rtla' in=
to trace/for-next)
Merging rcu/rcu/next (3a9ac384153d Merge branch 'clocksource.2022.02.01b' i=
nto HEAD)
Merging kvm/next (c9b8fecddb5b KVM: use kvcalloc for array allocations)
Merging kvm-arm/next (21ea45784275 KVM: arm64: fix typos in comments)
Merging kvms390/next (4aa5ac75bf79 KVM: s390: Fix lockdep issue in vm memop)
Merging xen-tip/linux-next (de2ae403b4c0 xen: fix is_xen_pmu())
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (bc35f7ef9628 workqueue: Convert the type of po=
ol->nr_running to int)
Merging drivers-x86/for-next (b49f72e7f96d platform/x86: think-lmi: Certifi=
cate authentication support)
Merging chrome-platform/for-next (b579f139e470 platform/chrome: cros_ec_typ=
ec: Update mux flags during partner removal)
Merging hsi/for-next (e783362eb54c Linux 5.17-rc1)
Merging leds/for-next (e26557a0aa68 leds: pca955x: Allow zero LEDs to be sp=
ecified)
Merging ipmi/for-next (ae085d7f9365 mm: kfence: fix missing objcg housekeep=
ing for SLAB)
Merging driver-core/driver-core-next (88d99e870143 Documentation: update st=
able review cycle documentation)
Merging usb/usb-next (ae085d7f9365 mm: kfence: fix missing objcg housekeepi=
ng for SLAB)
Merging thunderbolt/next (144c4a77a3e1 thunderbolt: Rename EEPROM handling =
bits to match USB4 spec)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (4ac56b1f1ef8 USB: serial: usb_wwan: remove red=
undant assignment to variable i)
Merging usb-chipidea-next/for-usb-next (78665f57c3fa usb: chipidea: udc: ma=
ke controller hardware endpoint primed)
Merging tty/tty-next (b31c41339f4f vt_ioctl: fix potential spectre v1 in VT=
_DISALLOCATE)
Merging char-misc/char-misc-next (37fd83916da2 firmware: google: Properly s=
tate IOMEM dependency)
Merging coresight/next (286f950545e0 coresight: Drop unused 'none' enum val=
ue for each component)
Merging fpga/for-next (21f0a239ecab fpga: dfl: pci: Remove usage of the dep=
recated "pci-dma-compat.h" API)
Merging icc/icc-next (52c85167e413 Merge branch 'icc-msm8939' into icc-next)
Merging iio/togreg (37fd83916da2 firmware: google: Properly state IOMEM dep=
endency)
Merging phy-next/next (c6455af54899 phy: qcom-qmp: add sc8280xp UFS PHY)
Merging soundwire/next (266fa94673d3 soundwire: qcom: use __maybe_unused fo=
r swrm_runtime_resume())
Merging extcon/extcon-next (4e63832f5daf extcon: sm5502: Add support for SM=
5703)
CONFLICT (content): Merge conflict in drivers/power/supply/max8997_charger.c
Merging gnss/gnss-next (26291c54e111 Linux 5.17-rc2)
Merging vfio/next (f621eb13facb vfio-pci: Provide reviewers and acceptance =
criteria for variant drivers)
Merging staging/staging-next (41197a5f11a4 staging: r8188eu: remove unneces=
sary memset in r8188eu)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (b95044b38425 dmaengine: hisi_dma: fix MSI allocate =
fail when reload hisi_dma)
Merging cgroup/for-next (1be9b7206b7d Merge branch 'for-5.18' into for-next)
Merging scsi/for-next (ee03d7a9c533 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (66daf3e6b993 scsi: scsi_ioctl: Drop needless ass=
ignment in sg_io())
Merging vhost/linux-next (ad6dc1daaf29 vdpa/mlx5: Avoid processing works if=
 workqueue was destroyed)
Merging rpmsg/for-next (9ea79a3861c9 Merge branches 'rpmsg-next', 'rproc-ne=
xt' and 'hwspinlock-next' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (87ba5badc541 gpio: ts4900: Use SPDX header)
Merging gpio-intel/for-next (a1ce76e89907 gpio: tps68470: Allow building as=
 module)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (4a6d01495a16 pinctrl: mediatek: common-v1: fix se=
micolon.cocci warnings)
Merging pinctrl-intel/for-next (d25478e1d8f9 pinctrl: icelake: Add Ice Lake=
-N PCH pin controller support)
Merging pinctrl-renesas/renesas-pinctrl (babe298e9caa pinctrl: renesas: r8a=
779f0: Add Ethernet pins, groups, and functions)
Merging pinctrl-samsung/for-next (3652dc070bad pinctrl: samsung: improve wa=
ke irq info on console)
Merging pwm/for-next (ed14d36498c8 pwm: rcar: Simplify multiplication/shift=
 logic)
Merging userns/for-next (9def41809e95 Merge of prlimit-tasklist_lock-for-v5=
.18, per-namespace-ipc-sysctls-for-v5.18, and ptrace-for-v5.18 for testing =
in linux-next)
CONFLICT (modify/delete): arch/nds32/include/asm/syscall.h deleted in HEAD =
and modified in userns/for-next.  Version userns/for-next of arch/nds32/inc=
lude/asm/syscall.h left in tree.
CONFLICT (modify/delete): arch/nds32/kernel/ptrace.c deleted in HEAD and mo=
dified in userns/for-next.  Version userns/for-next of arch/nds32/kernel/pt=
race.c left in tree.
CONFLICT (modify/delete): arch/nds32/kernel/signal.c deleted in HEAD and mo=
dified in userns/for-next.  Version userns/for-next of arch/nds32/kernel/si=
gnal.c left in tree.
CONFLICT (content): Merge conflict in block/blk-cgroup.c
$ git rm -f arch/nds32/include/asm/syscall.h arch/nds32/kernel/ptrace.c arc=
h/nds32/kernel/signal.c
Applying: fixup for moving of linux/task_work.h
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (f6d344cd5fa6 selftests: Fix build when $(O) points =
to a relative path)
Merging livepatching/for-next (0e1b951d6de0 Merge branch 'for-5.18/selftest=
s-fixes' into for-next)
Merging rtc/rtc-next (81c2f059ab90 rtc: optee: add RTC driver for OP-TEE RT=
C PTA)
Merging nvdimm/libnvdimm-for-next (ada8d8d337ee nvdimm/blk: Fix title level)
CONFLICT (content): Merge conflict in arch/powerpc/platforms/pseries/papr_s=
cm.c
CONFLICT (modify/delete): drivers/nvdimm/blk.c deleted in nvdimm/libnvdimm-=
for-next and modified in HEAD.  Version HEAD of drivers/nvdimm/blk.c left i=
n tree.
$ git rm -f drivers/nvdimm/blk.c
Merging at24/at24/for-next (e783362eb54c Linux 5.17-rc1)
Merging ntb/ntb-next (5cf4bc46c2f2 IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (1d27adee48cf selftests/seccomp: Don't cal=
l read() on TTY from background pgrp)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (f2af60bb7ce2 fsi: Add trace events in initialization path)
Merging slimbus/for-next (0eb1fb16396c slimbus: qcom-ngd-ctrl: Use platform=
_get_irq() to get the interrupt)
Merging nvmem/for-next (bdf79b27260b dt-bindings: nvmem: brcm,nvram: add ba=
sic NVMEM cells)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging xarray/main (22f56b8e890d XArray: Include bitmap.h from xarray.h)
Merging hyperv/hyperv-next (eeda29db98f4 x86/hyperv: Output host build info=
 as normal Windows version number)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (6880fa6c5660 Linux 5.15-rc1)
Merging kunit/test (e783362eb54c Linux 5.17-rc1)
Merging cfi/cfi/next (e783362eb54c Linux 5.17-rc1)
Merging kunit-next/kunit (5debe5bfa02c list: test: Add a test for list_entr=
y_is_head())
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (c65b6a9d1173 bus: mhi: ep: Add uevent support for mod=
ule autoloading)
CONFLICT (content): Merge conflict in drivers/bus/mhi/Kconfig
CONFLICT (content): Merge conflict in drivers/bus/mhi/Makefile
CONFLICT (add/add): Merge conflict in drivers/bus/mhi/common.h
Merging memblock/for-next (58ffc34896db memblock tests: Add TODO and README=
 files)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (05e815539f3f cxl/core/port: Fix NULL but dereferenced coc=
cicheck error)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (e783362eb54c Linux 5.17-rc1)
Merging unicode/for-next (5298d4bfe80f unicode: clean up the Kconfig symbol=
 confusion)
Merging slab/for-next (c0a21b0f6928 Merge branch 'slab/for-5.18/cleanups' i=
nto slab/for-next)
Merging random/master (0396e46dc465 virt: vmgenid: recognize new CID added =
by Hyper-V)
Merging landlock/next (7325fd5614aa Merge Landlock fixes into next)
Merging rust/rust-next (f102e7bc3b29 init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
CONFLICT (content): Merge conflict in Makefile
CONFLICT (content): Merge conflict in samples/Makefile
Merging sysctl/sysctl-next (fc12aa67daba kernel/do_mount_initrd: move real_=
root_dev sysctls to its own file)
CONFLICT (content): Merge conflict in include/linux/sched/sysctl.h
CONFLICT (content): Merge conflict in kernel/sysctl.c
Merging folio/for-next (1a58fcb00cca Merge branch 'fs-folio' into for-next-=
2022-03)
Merging execve/for-next/execve (dd664099002d binfmt_elf: Don't write past e=
nd of notes for regset gap)
Merging kspp/for-next/kspp (723908690e47 Merge branches 'for-next/hardening=
', 'for-next/array-bounds', 'for-next/memcpy', 'for-next/overflow' and 'for=
-next/pending-fixes' into for-next/kspp)
Merging kspp-gustavo/for-next/kspp (452d059ea2b6 drm/amd/display: Fix Wstri=
ngop-overflow warnings in dc_link_dp.c)
Merging akpm-current/current (ec31e5d6e685 ipc/mqueue: use get_tree_nodev()=
 in mqueue_get_tree())
CONFLICT (modify/delete): tools/testing/radix-tree/linux/gfp.h deleted in H=
EAD and modified in akpm-current/current.  Version akpm-current/current of =
tools/testing/radix-tree/linux/gfp.h left in tree.
$ git rm -f tools/testing/radix-tree/linux/gfp.h
Applying: fix up for "tools: Move gfp.h and slab.h from radix-tree to lib"
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (690633ee3a88 kselftest/vm: override TARGETS from argum=
ents)

--Sig_/P2notgM5WXQlFwxPpArzuI=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJCdNYACgkQAVBC80lX
0GzTtwf+OUN4kHBgzDmDwPUq0lsY6a8RvdfmR17DZcnHYGIlW+jSGVfKMCjyzkM2
oKZrKC/DtV2/Ia+kAsJcoEc5vnVygE/zxyzLMOIGI2Ekl9ipBZsef1fPCC+ACLkY
LdVZYwMyBNjSZ1rUuITMVxswU/bF/B4X02+qMedhMlplEe6aH60j+ei+A/oyOzfn
ygG6oblNeiZO1FXUDSSFZmsDC0WZi7nNy1HXM9kpDph7fAq+s5wrG72X1RexXMq5
6ifKmwIZ5b/QRYbwx7jo3NH/Stbw8mTAVruBNcvW98g4N7AkP+fesdbHt2QVVqyA
RexR9mOludzS6mRt3OzaoGUjzbrLMQ==
=0/Ys
-----END PGP SIGNATURE-----

--Sig_/P2notgM5WXQlFwxPpArzuI=--
