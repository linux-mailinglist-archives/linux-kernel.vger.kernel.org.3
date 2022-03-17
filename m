Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432F04DC219
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiCQJAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiCQJAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:00:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E9AC6EE9;
        Thu, 17 Mar 2022 01:59:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KK1KG0RzTz4xwL;
        Thu, 17 Mar 2022 19:58:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647507538;
        bh=RTTplOPIpc/fEg+jV2VWQ7wTeG/4MaDcp6+8xf11I9Y=;
        h=Date:From:To:Cc:Subject:From;
        b=EjYOcGSGz6GiNCcXAqPAMsgrCeua/ZeTRocI/VZUvkeEqKuxrPKJbKbD/vjguebAM
         a3dntZpggItn6ZjhnHIda0bTJ5Qi5a38gEopGywymvfIT/2yzAqicctp8oJzZSRkeS
         3XjfYGyaao9ggF36HD2Rnoqe0/w30/BvB1ka/VC6ua/x2ERLDm3F+D0Vgd2LMlSdu3
         2WlEQVgQ5sgf1dlEGtEqltQBP6Nf4sKoBh28Sf9bRkisXyqXhQt/HTTtQXfcufD1ma
         ymszPq6FPgWOr6LmKvfwqOGIaaBnZKWa8TiP4WjGFKG7X4I4NQ7GSXs+Wgk53wnnMX
         iY/q9sqyyxFlQ==
Date:   Thu, 17 Mar 2022 19:58:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 17
Message-ID: <20220317195856.19c7a317@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/47IBeWpRo1t/jsr7_Xn0YQh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/47IBeWpRo1t/jsr7_Xn0YQh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220316:

The rust tree gained a conflict against the kbuild tree.

Non-merge commits (relative to Linus' tree): 12259
 12351 files changed, 1015412 insertions(+), 276839 deletions(-)

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
Merging origin/master (56e337f2cf13 Revert "gpio: Revert regression in sysf=
s-gpio (gpiolib.c)")
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (754e0b0e3560 Linux 5.17-rc4)
Merging arc-current/for-curr (e783362eb54c Linux 5.17-rc1)
Merging arm-current/fixes (7b83299e5b93 ARM: 9182/1: mmu: fix returns from =
early_param() and __setup() functions)
Merging arm64-fixes/for-next/fixes (b859ebedd1e7 arm64: kasan: fix include =
error in MTE functions)
Merging arm-soc-fixes/arm/fixes (1447c635802f Revert "arm64: dts: freescale=
: Fix 'interrupt-map' parent address cells")
Merging drivers-memory-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging tee-fixes/fixes (6d8df1f9e8ae Merge tag 'optee-fix2-for-v5.17' into=
 fixes)
Merging m68k-current/for-linus (1a0ae068bf6b m68k: defconfig: Update defcon=
figs for v5.16-rc1)
Merging powerpc-fixes/fixes (48015b632f77 powerpc: Fix STACKTRACE=3Dn build)
Merging s390-fixes/fixes (c194dad21025 s390/extable: fix exception table so=
rting)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (186abea8a80b Merge branch 'master' of git://git.kernel.=
org/pub/scm/linux/kernel/git/klassert/ipsec)
Merging bpf/master (18b1ab7aa76b xsk: Fix race at socket teardown)
Merging ipsec/master (4db4075f92af esp6: fix check on ipv6_skip_exthdr's re=
turn value)
Merging netfilter/master (dea2d93a8ba4 Merge branch '100GbE' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/tnguy/net-queue)
Merging ipvs/master (277f2bb14361 ibmvnic: schedule failover only if vioctl=
 fails)
Merging wireless/main (45b4eb7ee6aa Revert "ath10k: drop beacon and probe r=
esponse which leak from other channel")
Merging rdma-fixes/for-rc (7e57714cd0ad Linux 5.17-rc6)
Merging sound-current/for-linus (c14231cc0433 ALSA: cmipci: Restore aux vol=
 on suspend/resume)
Merging sound-asoc-fixes/for-linus (353bb6a5f2ac ASoC: wm_adsp: Compressed =
stream DSP memory structs should be __packed)
Merging regmap-fixes/for-linus (d04ad245d67a regmap-irq: Update interrupt c=
lear register for proper reset)
Merging regulator-fixes/for-linus (2489d5d9cded Merge remote-tracking branc=
h 'regulator/for-5.16' into regulator-linus)
Merging spi-fixes/for-linus (34bd0ac75cd8 Merge remote-tracking branch 'spi=
/for-5.16' into spi-linus)
Merging pci-current/for-linus (5949965ec934 x86/PCI: Preserve host bridge w=
indows completely covered by E820)
Merging driver-core.current/driver-core-linus (7e57714cd0ad Linux 5.17-rc6)
Merging tty.current/tty-linus (7e57714cd0ad Linux 5.17-rc6)
Merging usb.current/usb-linus (16b1941eac2b usb: gadget: Fix use-after-free=
 bug by not setting udc->dev.driver)
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
Merging thunderbolt-fixes/fixes (09688c0166e7 Linux 5.17-rc8)
Merging input-current/for-linus (5600f6986628 Input: aiptek - properly chec=
k endpoint type)
Merging crypto-current/master (a680b1832ced crypto: qcom-rng - ensure buffe=
r for generate is completely filled)
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
Merging devicetree-fixes/dt/linus (f6eafa4022dd dt-bindings: phy: ti,tcan10=
4x-can: Document mux-states property)
Merging scsi-fixes/fixes (733ab7e1b5d1 scsi: fnic: Finish scsi_cmnd before =
dropping the spinlock)
Merging drm-fixes/drm-fixes (09688c0166e7 Linux 5.17-rc8)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (09688c0166e7 Linux 5.17-rc8)
Merging mmc-fixes/fixes (1760fdb6fe9f mmc: core: Restore (almost) the busy =
polling for MMC_SEND_OP_COND)
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
Merging spdx/spdx-linus (d8152cfe2f21 Merge tag 'pci-v5.17-fixes-5' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci)
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
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (c306d737691e NFSD: Deprecate NFS_OFFSET_MAX)
Merging irqchip-fixes/irq/irqchip-fixes (1d4df649cbb4 irqchip/sifive-plic: =
Add missing thead,c900-plic match string)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (f0e18b03fcaf Merge tag 'x86_urgent_for_v5=
.17_rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging efi-fixes/urgent (9feaf8b387ee efi: fix return value of __setup han=
dlers)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging drm-misc-fixes/for-linux-next-fixes (fc1b6ef7bfb3 drm/panel: simple=
: Fix Innolux G070Y2-L01 BPP settings)
Merging kbuild/for-next (6c4457c324cd Merge branch 'kbuild' into for-next)
Merging perf/perf/core (65eab2bc7dab Merge remote-tracking branch 'torvalds=
/master' into perf/core)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (8ddde07a3d28 dma-mapping: benchmark: extract =
a common header file for map_benchmark definition)
Merging asm-generic/master (aec499c75cf8 nds32: Remove the architecture)
Merging arc/for-next (6880fa6c5660 Linux 5.15-rc1)
Merging arm/for-next (b717496e1158 Merge branch 'devel-stable' into for-nex=
t)
CONFLICT (content): Merge conflict in arch/arm/kernel/traps.c
Merging arm64/for-next/core (641d80415729 Merge branch 'for-next/spectre-bh=
b' into for-next/core)
Merging arm-perf/for-next/perf (602c873eb52e perf: Replace acpi_bus_get_dev=
ice())
Merging arm-soc/for-next (9d3ab161f7b9 Merge tag 'soc-fixes-5.17-3' into fo=
r-next4)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
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
Merging clk/clk-next (34cb85203049 Merge branch 'clk-cleanup' into clk-next)
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
Merging mips/mips-next (588d08201c2d MIPS: Fix wrong comments in asm/prom.h)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (862cf8d5fd98 openrisc/boot: Remove unnecessary i=
nitialisation in memcpy().)
Merging parisc-hd/for-next (0433401dc11d parisc: Avoid calling SMP cache fl=
ush functions on cache-less machines)
CONFLICT (content): Merge conflict in arch/parisc/lib/memcpy.c
Merging powerpc/next (d79976918852 powerpc/64: Add UADDR64 relocation suppo=
rt)
Merging soc-fsl/next (1ce93cb102e7 soc: fsl: qe: Check of ioremap return va=
lue)
Merging risc-v/for-next (9d1f0ec9f717 riscv: Fixed misaligned memory access=
. Fixed pointer comparison.)
Merging s390/for-next (1c95dce9847d Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (82017457957a um: run_helper: Write error message to=
 kernel log on exec failure on host)
Merging xtensa/xtensa-for-next (f406f2d03e07 xtensa: fix stop_machine_cpusl=
ocked call in patch_text)
Merging pidfd/for-next (6009ff9e8020 Merge branch 'fs.mount_setattr.fixes' =
into for-next)
Merging fscrypt/master (cdaa1b1941f6 fscrypt: update documentation for dire=
ct I/O support)
Merging fscache/fscache-next (1819c4a4bd56 afs: Maintain netfs_i_context::r=
emote_i_size)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (89a925d75608 Merge branch 'for-next-current-v5.16-2=
0220314' into for-next-20220314)
Merging ceph/master (ad5255c1ea9c ceph: misc fix for code style and logs)
Merging cifs/for-next (371ce9596552 cifs: fix KASAN warning in parse_server=
_interfaces() during mount)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (500edd095648 erofs: use meta buffers for inode lookup)
Merging exfat/dev (dd81e1c7d5fb Merge tag 'powerpc-5.17-2' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging ext3/for_next (f06e95c3a4ca Merge fsnotify cleanup from Bang Li.)
Merging ext4/dev (919adbfec29d ext4: fix kernel doc warnings)
Merging f2fs/dev (13175afaa144 f2fs: introduce gc_urgent_mid mode)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (0c4bcfdecb1a fuse: fix pipe buffer lifetime for dire=
ct_io)
Merging gfs2/for-next (4acbe0d8bf41 gfs2: Add read/write page 'fault_stats')
Merging jfs/jfs-next (c48a14dca2cb JFS: fix memleak in jfs_mount)
Merging ksmbd/ksmbd-for-next (c7b2c4536cd9 ksmbd: increment reference count=
 of parent fp)
Merging nfs/linux-next (693486d5f895 SUNRPC: change locking for xs_swap_ena=
ble/disable)
Merging nfs-anna/linux-next (d19e0183a883 NFS: Do not report writeback erro=
rs in nfs_getattr())
Merging nfsd/for-next (26ff4e51bb4c fs/lock: only call lm_breaker_owns_leas=
e if there is conflict.)
Merging ntfs3/master (52e00ea6b26e fs/ntfs3: Update valid size if -EIOCBQUE=
UED)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (94fd19752b28 ovl: don't fail copy up if n=
o fileattr support on upper)
Merging ubifs/next (c3c07fc25f37 ubi: fastmap: Return error code if memory =
allocation fails in add_aeb())
Merging v9fs/9p-next (22e424feb665 Revert "fs/9p: search open fids first")
Merging xfs/for-next (744e6c8ada5d xfs: constify xfs_name_dotdot)
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
Merging pci/next (bd147bd4c926 Merge branch 'remotes/lorenzo/pci/uniphier')
Merging pstore/for-next/pstore (8126b1c73108 pstore: Don't use semaphores i=
n always-atomic-context code)
Merging hid/for-next (3cc519d82627 Merge branch 'for-5.17/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (7effd734baa8 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (6cbf8b38dfe3 i3c: fix uninitialized variable use in i=
2c setup)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (fd6ca3f5b80f hwmon: (scpi-hwmon): Use of_=
device_get_match_data())
Merging jc_docs/docs-next (75c05fabb873 docs/kernel-parameters: update desc=
ription of mem=3D)
Merging v4l-dvb/master (2b891d3980f6 media: xilinx: csi2rxss: Use mipi-csi2=
.h)
Merging v4l-dvb-next/master (10ed1ec9c9ca media: spi: Kconfig: Place SPI dr=
ivers on a single menu)
Merging pm/linux-next (ad2ced059eef Merge branch 'acpi-scan-fixes' into lin=
ux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (b7f2b0d3511a dt-bindings: cpufr=
eq: cpufreq-qcom-hw: Convert to YAML bindings)
Merging cpupower/cpupower (8382dce5e483 cpupower: Add "perf" option to prin=
t AMD P-State information)
Merging devfreq/devfreq-next (26291c54e111 Linux 5.17-rc2)
Merging opp/opp/linux-next (f48a0c475c2a Documentation: EM: Describe new re=
gistration method using DT)
Merging thermal/thermal/linux-next (1379d28e840f thermal: rcar_thermal: Use=
 platform_get_irq_optional() to get the interrupt)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (feae43f8aa88 fs: dlm: print cluster addr if non-cluster n=
ode connects)
Merging rdma/for-next (2c25e45267d0 RDMA/qib: Fix typos in comments)
Merging net-next/master (b1351527f1ee Merge branch 'devlink-expose-instance=
-locking-and-simplify-port-splitting')
CONFLICT (content): Merge conflict in drivers/hwmon/adt7310.c
Merging bpf-next/for-next (ad13baf45691 selftests/bpf: Test subprog jit whe=
n toggle bpf_jit_harden repeatedly)
Merging ipsec-next/master (2ecda181682e xfrm: delete duplicated functions t=
hat calls same xfrm_api_check())
Merging mlx5-next/mlx5-next (45fee8edb4b3 net/mlx5: Add clarification on sy=
nc reset failure)
Merging netfilter-next/master (c84d86a0295c Merge branch '100GbE' of git://=
git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue)
Merging ipvs-next/master (c828414ac935 netfilter: nft_compat: suppress comm=
ent match)
Merging bluetooth/master (7c686a32a512 Bluetooth: call hci_le_conn_failed w=
ith hdev lock in hci_le_conn_failed)
Merging wireless-next/main (d179c1f1c370 rtw89: fix uninitialized variable =
of rtw89_append_probe_req_ie())
Merging mtd/mtd/next (8f877b7eab9d mtd: nand: ecc: mxic: Fix compile test i=
ssue)
Merging nand/nand/next (fecbd4a317c9 mtd: rawnand: atmel: fix refcount issu=
e in atmel_nand_controller_init)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/mtd=
/nand-controller.yaml
Merging spi-nor/spi-nor/next (151c6b49d679 mtd: spi-nor: Skip erase logic w=
hen SPI_NOR_NO_ERASE is set)
Merging crypto/master (0e03b8fd2936 crypto: xilinx - Turn SHA into a trista=
te and allow COMPILE_TEST)
Merging drm/drm-next (f6d790e5a7fe Merge tag 'drm-intel-next-fixes-2022-03-=
10' of git://anongit.freedesktop.org/drm/drm-intel into drm-next)
CONFLICT (modify/delete): Documentation/devicetree/bindings/display/mediate=
k/mediatek,disp.txt deleted in drm/drm-next and modified in HEAD.  Version =
HEAD of Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t left in tree.
$ git rm -f Documentation/devicetree/bindings/display/mediatek/mediatek,dis=
p.txt
Applying: fix up for "media: dt-binding: mediatek: Get rid of mediatek,larb=
 for multimedia HW"
Applying: fix up for "spi: make remove callback a void function"
Merging drm-misc/for-linux-next (f6d790e5a7fe Merge tag 'drm-intel-next-fix=
es-2022-03-10' of git://anongit.freedesktop.org/drm/drm-intel into drm-next)
Merging amdgpu/drm-next (426c89aa203b drm/amdgpu: Use drm_mode_copy())
Merging drm-intel/for-linux-next (278da06c0365 drm/i915/display: Do not re-=
enable PSR after it was marked as not reliable)
Merging drm-tegra/drm/tegra/for-next (b53c24f69199 drm/tegra: Support YVYU,=
 VYUY and YU24 formats)
Merging drm-msm/msm-next (05afd57f4d34 drm/msm/gpu: Fix crash on devices wi=
thout devfreq support (v2))
Merging imx-drm/imx-drm/next (20fbfc81e390 drm/imx: imx-tve: Make use of th=
e helper function devm_platform_ioremap_resource())
Merging etnaviv/etnaviv/next (cdd156955f94 drm/etnaviv: consider completed =
fence seqno in hang check)
Merging fbdev/for-next (e445c8b2aa2d video: fbdev: kyro: make read-only arr=
ay ODValues static const)
Merging regmap/for-next (2d2329787ba2 regmap: irq: cleanup comments)
Merging sound/for-next (e6194c8d0653 ALSA: hda/realtek: fix right sounds an=
d mute/micmute LEDs for HP machines)
Merging sound-asoc/for-next (0a105360129c Merge remote-tracking branch 'aso=
c/for-5.18' into asoc-next)
Merging modules/modules-next (719fce7539cd Merge tag 'soc-fixes-5.17-2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc)
Merging input/next (8a3e634dc5a3 HID: google: modify HID device groups of e=
el)
Merging block/for-next (811e8716edcd Merge branch 'for-5.18/io_uring' into =
for-next)
CONFLICT (content): Merge conflict in drivers/block/virtio_blk.c
CONFLICT (content): Merge conflict in fs/iomap/direct-io.c
Merging device-mapper/for-next (e9567332a4a0 dm: update email address in MA=
INTAINERS)
Merging libata/for-next (d268afa1ff6f ata: pata_pxa: Use platform_get_irq()=
 to get the interrupt)
Merging pcmcia/pcmcia-next (3928cf08334e pcmcia: db1xxx_ss: restrict to MIP=
S_DB1XXX boards)
Merging mmc/next (11b51bff0a2e mmc: tmio: remove outdated members from host=
 struct)
Merging mfd/for-mfd-next (022bd5cae497 mfd: intel-lpss: Provide an SSP type=
 to the driver)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/soc=
/samsung/exynos-usi.yaml
Merging backlight/for-backlight-next (ec961cf32411 backlight: qcom-wled: Re=
spect enabled-strings in set_brightness)
Merging battery/for-next (c22fca40522e power: ab8500_chargalg: Use CLOCK_MO=
NOTONIC)
Merging regulator/for-next (6cb9327ca799 Merge remote-tracking branch 'regu=
lator/for-5.18' into regulator-next)
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
Merging tomoyo/master (b9c20da356db workqueue: Warn flushing of kernel-glob=
al workqueues)
Merging tpmdd/next (fb5abce6b2bb tpm: use try_get_ops() in tpm-space.c)
Merging watchdog/master (09688c0166e7 Linux 5.17-rc8)
Merging iommu/next (e17c6debd4b2 Merge branches 'arm/mediatek', 'arm/msm', =
'arm/renesas', 'arm/rockchip', 'arm/smmu', 'x86/vt-d' and 'x86/amd' into ne=
xt)
Merging audit/next (272ceeaea355 audit: log AUDIT_TIME_* records only from =
rules)
Merging devicetree/for-next (593adaa64599 dt-bindings: ata: ahci-platform: =
Add rk3568-dwc-ahci compatible)
Merging mailbox/mailbox-for-next (1b0d0f7c12d5 dt-bindings: mailbox: add de=
finition for mt8186)
Merging spi/for-next (18a5e14a6274 Merge remote-tracking branch 'spi/for-5.=
18' into spi-next)
CONFLICT (modify/delete): arch/arm/mach-pxa/stargate2.c deleted in HEAD and=
 modified in spi/for-next.  Version spi/for-next of arch/arm/mach-pxa/starg=
ate2.c left in tree.
$ git rm -f arch/arm/mach-pxa/stargate2.c
Merging tip/master (61f719d76d1b Merge branch into tip/master: 'core/core')
CONFLICT (content): Merge conflict in arch/powerpc/include/asm/livepatch.h
CONFLICT (content): Merge conflict in arch/x86/net/bpf_jit_comp.c
CONFLICT (content): Merge conflict in drivers/iommu/intel/iommu.c
Merging clockevents/timers/drivers/next (49c14f94ccfe clocksource/drivers/t=
imer-of: check return value of of_iomap in timer_of_base_init())
Merging edac/edac-for-next (d52ba330befa Merge branch 'edac-misc' into edac=
-for-next)
Merging irqchip/irq/irqchip-next (de26a7424331 Merge branch irq/qcom-mpm in=
to irq/irqchip-next)
Merging ftrace/for-next (bc47ee4844d6 tracing/user_events: Use alloc_pages =
instead of kzalloc() for register pages)
CONFLICT (content): Merge conflict in include/trace/trace_events.h
Applying: fix up for "tracing: Move the defines to create TRACE_EVENTS into=
 their own files"
Applying: fixup for "sched/tracing: Don't re-read p->state when emitting sc=
hed_switch event"
Merging rcu/rcu/next (3a9ac384153d Merge branch 'clocksource.2022.02.01b' i=
nto HEAD)
CONFLICT (content): Merge conflict in kernel/rcu/tree_plugin.h
Merging kvm/next (cf5019816d87 Merge tag 'kvm-riscv-5.18-1' of https://gith=
ub.com/kvm-riscv/linux into HEAD)
CONFLICT (content): Merge conflict in arch/s390/lib/uaccess.c
Merging kvm-arm/next (9872e6bc08d6 Merge branch kvm-arm64/psci-1.1 into kvm=
arm-master/next)
Merging kvms390/next (3bcc372c9865 KVM: s390: selftests: Add error memop te=
sts)
Merging xen-tip/linux-next (309b517276f2 arch:x86:xen: Remove unnecessary a=
ssignment in xen_apic_read())
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (bc35f7ef9628 workqueue: Convert the type of po=
ol->nr_running to int)
Merging drivers-x86/for-next (286e937efbc7 platform/x86: hp-wmi: support om=
en thermal profile policy v1)
CONFLICT (content): Merge conflict in drivers/platform/x86/amd-pmc.c
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
Merging usb/usb-next (e4cf6580ac74 usb: dwc3: gadget: Wait for ep0 xfers to=
 complete during dequeue)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/qcom/ipq6018.dtsi
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/xilinx/zynqmp.dtsi
Merging thunderbolt/next (144c4a77a3e1 thunderbolt: Rename EEPROM handling =
bits to match USB4 spec)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (4ac56b1f1ef8 USB: serial: usb_wwan: remove red=
undant assignment to variable i)
Merging usb-chipidea-next/for-usb-next (78665f57c3fa usb: chipidea: udc: ma=
ke controller hardware endpoint primed)
Merging tty/tty-next (3631e48df0db serial: samsung: Add samsung_early_read =
to support early kgdboc)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging char-misc/char-misc-next (d6cd2f85931f Merge tag 'icc-5.18-rc1' of =
git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-nex=
t)
CONFLICT (modify/delete): Documentation/devicetree/bindings/phy/qcom,usb-hs=
-phy.txt deleted in char-misc/char-misc-next and modified in HEAD.  Version=
 HEAD of Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt left in =
tree.
CONFLICT (content): Merge conflict in MAINTAINERS
CONFLICT (content): Merge conflict in drivers/phy/freescale/Kconfig
$ git rm -f Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
Applying: fixup for "dt-bindings: phy: convert Qualcomm USB HS phy to yaml"
Merging fpga/for-next (21f0a239ecab fpga: dfl: pci: Remove usage of the dep=
recated "pci-dma-compat.h" API)
Merging icc/icc-next (52c85167e413 Merge branch 'icc-msm8939' into icc-next)
Merging phy-next/next (c6455af54899 phy: qcom-qmp: add sc8280xp UFS PHY)
Merging soundwire/next (266fa94673d3 soundwire: qcom: use __maybe_unused fo=
r swrm_runtime_resume())
Merging extcon/extcon-next (d88b12efaff7 extcon: usb-gpio: Remove disable i=
rq operation in system sleep)
CONFLICT (content): Merge conflict in drivers/power/supply/max8997_charger.c
Merging gnss/gnss-next (26291c54e111 Linux 5.17-rc2)
Merging vfio/next (4406f46c9bcd hisi_acc_vfio_pci: Use its own PCI reset_do=
ne error handler)
Merging staging/staging-next (ca7918f21466 MAINTAINERS: remove the obsolete=
 file entry for staging in ANDROID DRIVERS)
CONFLICT (content): Merge conflict in drivers/staging/fbtft/fbtft.h
Merging iio/togreg (0bf126163c3e iio: adc: xilinx-ams: Fix single channel s=
witching sequence)
CONFLICT (content): Merge conflict in .mailmap
CONFLICT (content): Merge conflict in drivers/iio/accel/fxls8962af-core.c
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (b95044b38425 dmaengine: hisi_dma: fix MSI allocate =
fail when reload hisi_dma)
Merging cgroup/for-next (1be9b7206b7d Merge branch 'for-5.18' into for-next)
Merging scsi/for-next (428a8907e32b Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in block/blk-lib.c
CONFLICT (content): Merge conflict in block/blk-merge.c
CONFLICT (content): Merge conflict in drivers/block/drbd/drbd_worker.c
CONFLICT (content): Merge conflict in drivers/block/rnbd/rnbd-clt.c
Merging scsi-mkp/for-next (66daf3e6b993 scsi: scsi_ioctl: Drop needless ass=
ignment in sg_io())
Merging vhost/linux-next (b7e51e7a4462 tools/virtio: fix after premapped bu=
f support)
Merging rpmsg/for-next (9ea79a3861c9 Merge branches 'rpmsg-next', 'rproc-ne=
xt' and 'hwspinlock-next' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (226a827e93b5 gpio: Drop CONFIG_DEBUG_GPIO)
Merging gpio-intel/for-next (a1ce76e89907 gpio: tps68470: Allow building as=
 module)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (099785d3adee Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (d25478e1d8f9 pinctrl: icelake: Add Ice Lake=
-N PCH pin controller support)
Merging pinctrl-renesas/renesas-pinctrl (babe298e9caa pinctrl: renesas: r8a=
779f0: Add Ethernet pins, groups, and functions)
Merging pinctrl-samsung/for-next (3652dc070bad pinctrl: samsung: improve wa=
ke irq info on console)
Merging pwm/for-next (ed14d36498c8 pwm: rcar: Simplify multiplication/shift=
 logic)
Merging userns/for-next (cf15d774d4bf Merge of prlimit-tasklist_lock-for-v5=
.18, per-namespace-ipc-sysctls-for-v5.18, and kill-tracehook-for-v5.18 for =
testing in linux-next)
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
Merging livepatching/for-next (b44a7f076ce1 Merge branch 'for-5.18/selftest=
s-fixes' into for-next)
Merging coresight/next (286f950545e0 coresight: Drop unused 'none' enum val=
ue for each component)
Merging rtc/rtc-next (dc1d63a69730 clk: sunxi-ng: sun6i-rtc: Add support fo=
r H6)
Merging nvdimm/libnvdimm-for-next (66908004f055 Merge perf monitor support =
for papr-nvdimms and BLK-aperture support removal for 5.18.)
CONFLICT (content): Merge conflict in arch/powerpc/platforms/pseries/papr_s=
cm.c
CONFLICT (modify/delete): drivers/nvdimm/blk.c deleted in nvdimm/libnvdimm-=
for-next and modified in HEAD.  Version HEAD of drivers/nvdimm/blk.c left i=
n tree.
$ git rm -f drivers/nvdimm/blk.c
Merging at24/at24/for-next (e783362eb54c Linux 5.17-rc1)
Merging ntb/ntb-next (d2bda1500aa8 IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (eed09ad26182 samples/seccomp: Adjust samp=
le to also provide kill option)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (f2af60bb7ce2 fsi: Add trace events in initialization path)
Merging slimbus/for-next (0eb1fb16396c slimbus: qcom-ngd-ctrl: Use platform=
_get_irq() to get the interrupt)
Merging nvmem/for-next (bdf79b27260b dt-bindings: nvmem: brcm,nvram: add ba=
sic NVMEM cells)
CONFLICT (add/add): Merge conflict in Documentation/devicetree/bindings/nvm=
em/sunplus,sp7021-ocotp.yaml
CONFLICT (content): Merge conflict in MAINTAINERS
Merging xarray/main (22f56b8e890d XArray: Include bitmap.h from xarray.h)
Merging hyperv/hyperv-next (eeda29db98f4 x86/hyperv: Output host build info=
 as normal Windows version number)
Merging auxdisplay/auxdisplay (9ed331f8a0fb auxdisplay: lcd2s: Use proper A=
PI to free the instance of charlcd object)
Merging kgdb/kgdb/for-next (b77dbc86d604 kdb: Adopt scheduler's task classi=
fication)
Merging hmm/hmm (6880fa6c5660 Linux 5.15-rc1)
Merging kunit/test (e783362eb54c Linux 5.17-rc1)
Merging cfi/cfi/next (e783362eb54c Linux 5.17-rc1)
Merging kunit-next/kunit (5debe5bfa02c list: test: Add a test for list_entr=
y_is_head())
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (c65b6a9d1173 bus: mhi: ep: Add uevent support for mod=
ule autoloading)
Merging memblock/for-next (58ffc34896db memblock tests: Add TODO and README=
 files)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (74be98774dfb cxl/port: Hold port reference until decoder =
release)
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (e783362eb54c Linux 5.17-rc1)
Merging unicode/for-next (5298d4bfe80f unicode: clean up the Kconfig symbol=
 confusion)
Merging slab/for-next (c0a21b0f6928 Merge branch 'slab/for-5.18/cleanups' i=
nto slab/for-next)
Merging random/master (3e504d2026eb random: check for signal and try earlie=
r when generating entropy)
Merging landlock/next (7325fd5614aa Merge Landlock fixes into next)
Merging rust/rust-next (f102e7bc3b29 init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
CONFLICT (content): Merge conflict in Makefile
Merging sysctl/sysctl-next (fc12aa67daba kernel/do_mount_initrd: move real_=
root_dev sysctls to its own file)
CONFLICT (content): Merge conflict in include/linux/sched/sysctl.h
CONFLICT (content): Merge conflict in kernel/sysctl.c
Merging folio/for-next (5e56fede8656 Merge branch 'fs-folio' into for-next)
CONFLICT (modify/delete): arch/nds32/include/asm/pgtable.h deleted in HEAD =
and modified in folio/for-next.  Version folio/for-next of arch/nds32/inclu=
de/asm/pgtable.h left in tree.
CONFLICT (content): Merge conflict in drivers/gpu/drm/drm_cache.c
CONFLICT (content): Merge conflict in fs/9p/vfs_addr.c
CONFLICT (content): Merge conflict in fs/afs/file.c
CONFLICT (content): Merge conflict in fs/erofs/super.c
CONFLICT (content): Merge conflict in fs/ext4/inode.c
CONFLICT (content): Merge conflict in fs/nfs/file.c
CONFLICT (content): Merge conflict in fs/ubifs/file.c
$ git rm -f arch/nds32/include/asm/pgtable.h
Merging execve/for-next/execve (19e8b701e258 a.out: Stop building a.out/osf=
1 support on alpha and m68k)
Merging kspp/for-next/kspp (723908690e47 Merge branches 'for-next/hardening=
', 'for-next/array-bounds', 'for-next/memcpy', 'for-next/overflow' and 'for=
-next/pending-fixes' into for-next/kspp)
CONFLICT (content): Merge conflict in arch/arm64/Kconfig
Applying: fixup for "pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver"
Merging kspp-gustavo/for-next/kspp (91adfbb14c00 Merge branch 'for-next/ksp=
p-fam0' into for-next/kspp)
Merging akpm-current/current (2033ac0d81ec ipc/mqueue: use get_tree_nodev()=
 in mqueue_get_tree())
CONFLICT (content): Merge conflict in Documentation/admin-guide/sysctl/kern=
el.rst
CONFLICT (modify/delete): arch/nds32/mm/init.c deleted in HEAD and modified=
 in akpm-current/current.  Version akpm-current/current of arch/nds32/mm/in=
it.c left in tree.
CONFLICT (content): Merge conflict in include/linux/compiler_types.h
CONFLICT (content): Merge conflict in include/linux/sched/sysctl.h
CONFLICT (content): Merge conflict in lib/Kconfig.debug
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
Merging akpm/master (5d440718d373 kselftest/vm: override TARGETS from argum=
ents)

--Sig_/47IBeWpRo1t/jsr7_Xn0YQh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIy+FAACgkQAVBC80lX
0Gwfpwf/ZmRPn6quYoFOktUsVm/SsqOxdnm+cLFLrc7DAJiTDesSkW3CNQJhi1AZ
V+Uz87JhVp+ZdZshu3/+QPk40SCSRp3iRV770ZJtAyoNjuuNn9G5dKnfSA2v/FJO
j2x3/6eUo0N8sK/BPBU26MeStqcHtSfU5s85y/dzivGGI28GbQNHUILcGiRNf4AS
aVSLQRkvMvO34Vt3STgkQs48M4JqYh055TEZAcVyDW0WJ0nLxktmf9wH41EbtXtp
7EA2WlPo5SAFtv2Daxx4DKeZqIgit5KgRsG+h0qYBhUNBmvS61i0Y7s09ixALwM/
S7FkT3pxRNmb051ezQBuJrxL4wKaEQ==
=Ztyo
-----END PGP SIGNATURE-----

--Sig_/47IBeWpRo1t/jsr7_Xn0YQh--
