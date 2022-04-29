Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D65514350
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355201AbiD2Heh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355193AbiD2Hee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:34:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65304AFB0F;
        Fri, 29 Apr 2022 00:31:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KqPL76V00z4yST;
        Fri, 29 Apr 2022 17:31:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651217473;
        bh=U8CnZ18cUPpNph2H/TStAvWb1DHzeBO8E39vJ/P5uXI=;
        h=Date:From:To:Cc:Subject:From;
        b=tHcnkghk9K2hZNKHjlkSHIa5hPgXr5VrQpruwFM3O5mO/CgwS3M4X5GdSESKoQQgy
         MIe8qBAwEmRGY993J+ElBpitjgL7x5p2tU4FMVdYCOIFWbdmYdMSurE6FJFwNRngzF
         ScBEU87hUMA/zn7uSPnx842AK7QioCvSHOpGFoXNZvZkZvTVBpC9sAgDSdpNAD0lUc
         vtQWZdRRhlKJ8h66sk9jCrBLawp4zJQhfIGMAZ57DKlf0vImU6enoxWW8brSPNDuKB
         My5HYJqI372KezMZTGccGRjzkwzE+fQAzMv9NiNwYYRZVSSRMPwGT1Zw01RbheYC72
         C/aDO9hnURJ1w==
Date:   Fri, 29 Apr 2022 17:31:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 29
Message-ID: <20220429173108.148ecd67@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cBqKwjOxhdKzgXgBXcZKeys";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cBqKwjOxhdKzgXgBXcZKeys
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220428:

The amdgpu tree gained a conflict against the drm tree.

The input tree still had its build failure so I used the version from
next-20220426.

The kvm tree still had its build failure for which I applied a patch.

The iio tree gained a conflict against the char-misc.current tree.

Non-merge commits (relative to Linus' tree): 7078
 7806 files changed, 394826 insertions(+), 160639 deletions(-)

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

I am currently merging 345 trees (counting Linus' and 94 trees of bug
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
Merging origin/master (249aca0d3d63 Merge tag 'net-5.18-rc5' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging mm-hotfixes/mm-hotfixes (74fedba8f7ad procfs: prevent unprivileged =
processes accessing fdinfo dir)
Merging kbuild-current/fixes (312310928417 Linux 5.18-rc1)
Merging arc-current/for-curr (c6ed4d84a2c4 ARC: remove redundant READ_ONCE(=
) in cmpxchg loop)
Merging arm-current/fixes (9be4c88bb792 ARM: 9191/1: arm/stacktrace, kasan:=
 Silence KASAN warnings in unwind_frame())
Merging arm64-fixes/for-next/fixes (c35fe2a68f29 elf: Fix the arm64 MTE ELF=
 segment name and value)
Merging arm-soc-fixes/arm/fixes (2f477ee3ed92 Revert "arm64: dts: tegra: Fi=
x boolean properties with values")
Merging drivers-memory-fixes/fixes (73039c6c7f36 memory: renesas-rpc-if: Fi=
x HF/OSPI data transfer in Manual Mode)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (0d52a01a266b m68k: defconfig: Disable fbdev=
 on Sun3/3x)
Merging powerpc-fixes/fixes (bb82c574691d powerpc/perf: Fix 32bit compile)
Merging s390-fixes/fixes (8b202ee21839 s390: disable -Warray-bounds)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (249aca0d3d63 Merge tag 'net-5.18-rc5' of git://git.kern=
el.org/pub/scm/linux/kernel/git/netdev/net)
Merging bpf/master (a0df71948e95 tls: Skip tls_append_frag on zero copy siz=
e)
Merging ipsec/master (5bd8baab087d esp: limit skb_page_frag_refill use to a=
 single page)
Merging netfilter/master (05ae2fba821c netfilter: nft_socket: make cgroup m=
atch work in input too)
Merging ipvs/master (05ae2fba821c netfilter: nft_socket: make cgroup match =
work in input too)
Merging wireless/main (4dd4e6f65985 MAINTAINERS: update iwlwifi driver main=
tainer)
Merging rdma-fixes/for-rc (570a4bf7440e RDMA/rxe: Recheck the MR in when ge=
nerating a READ reply)
Merging sound-current/for-linus (eb9d84b0ffe3 ALSA: fireworks: fix wrong re=
turn count shorter than expected by 4 bytes)
Merging sound-asoc-fixes/for-linus (abacd5757270 Merge remote-tracking bran=
ch 'asoc/for-5.17' into asoc-linus)
Merging regmap-fixes/for-linus (312310928417 Linux 5.18-rc1)
Merging regulator-fixes/for-linus (dfd2b37edf7e regulator: dt-bindings: Rev=
ise the rt5190a buck/ldo description)
Merging spi-fixes/for-linus (8868c03f3ca5 spi: spi-mem: check if data buffe=
rs are on stack)
Merging pci-current/for-linus (92597f97a40b PCI/PM: Avoid putting Elo i2 PC=
Ie Ports in D3cold)
Merging driver-core.current/driver-core-linus (ad8d869343ae kernfs: fix NUL=
L dereferencing in kernfs_remove)
Merging tty.current/tty-linus (19317433057d tty: n_gsm: fix sometimes unini=
tialized warning in gsm_dlci_modem_output())
Merging usb.current/usb-linus (03e607cbb293 usb: phy: generic: Get the vbus=
 supply)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (e23e50e7acc8 USB: serial: whiteheat: fi=
x heap overflow in WHITEHEAT_GET_DTR_RTS)
Merging phy/fixes (2c8045d48dee phy: amlogic: fix error path in phy_g12a_us=
b3_pcie_probe())
Merging staging.current/staging-linus (ce522ba9ef7e Linux 5.18-rc2)
Merging iio-fixes/fixes-togreg (b5d6ba09b10d iio: imu: inv_icm42600: Fix I2=
C init possible nack)
Merging counter-fixes/fixes-togreg (ce522ba9ef7e Linux 5.18-rc2)
Merging char-misc.current/char-misc-linus (fda05730f62b Merge tag 'iio-fixe=
s-for-5.18a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio)
Merging soundwire-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging thunderbolt-fixes/fixes (af2d861d4cd2 Linux 5.18-rc4)
Merging input-current/for-linus (4352e23a7ff2 Input: cros-ec-keyb - only re=
gister keyboard if rows/columns exist)
Merging crypto-current/master (aa8e73eed7d3 crypto: x86/sm3 - Fixup SLS)
Merging vfio-fixes/for-linus (1ef3342a934e vfio/pci: Fix vf_token mechanism=
 when device-specific VF drivers are used)
Merging kselftest-fixes/fixes (e8f0c8965932 selftest/vm: add skip support t=
o mremap_test)
Merging modules-fixes/modules-linus (dc0ce6cc4b13 lib/test: use after free =
in register_test_dev_kmod())
Merging dmaengine-fixes/fixes (9889fc4f19e0 dmaengine: idxd: Fix the error =
handling path in idxd_cdev_register())
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (ba7542eb2dd5 mtd: rawnand: qcom: fix memory co=
rruption that causes panic)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (d4cb77112c7b media: isl7998x: select V4L2_FWNO=
DE to fix build error)
Merging reset-fixes/reset/fixes (03cb66463b55 dt-bindings: reset: Add paren=
t "resets" property as optional)
Merging mips-fixes/mips-fixes (b2d229d4ddb1 Linux 5.18-rc3)
Merging at91-fixes/at91-fixes (0c640d9544d0 ARM: dts: at91: fix pinctrl pha=
ndles)
Merging omap-fixes/fixes (46ff3df87215 ARM: dts: logicpd-som-lv: Fix wrong =
pinmuxing on OMAP35)
Merging kvm-fixes/master (e852be8b148e kvm: selftests: introduce and use mo=
re page size-related constants)
Merging kvms390-fixes/master (0e9ff65f455d KVM: s390: preserve deliverable_=
mask in __airqs_kick_single_vcpu)
Merging hwmon-fixes/hwmon (08da09f02804 hwmon: (pmbus) delta-ahe50dc-fan: w=
ork around hardware quirk)
Merging nvdimm-fixes/libnvdimm-fixes (d28820419ca3 cxl/pci: Drop shadowed v=
ariable)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (e4a747ad6e40 Merge branch 'misc-5.18' into =
next-fixes)
Merging vfs-fixes/fixes (9d2231c5d74e lib/iov_iter: initialize "flags" in n=
ew pipe_buffer)
Merging dma-mapping-fixes/for-linus (18a3c5f7abfd Merge tag 'for_linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (eb2fd9b43fae platform/x86/intel: pmc/core:=
 change pmc_lpm_modes to static)
Merging samsung-krzk-fixes/fixes (436ce66003d5 ARM: s3c: mark as deprecated=
 and schedule removal)
Merging pinctrl-samsung-fixes/fixes (ac875df4d854 pinctrl: samsung: fix mis=
sing GPIOLIB on ARM64 Exynos config)
Merging devicetree-fixes/dt/linus (e17fd4bf54fb dt-bindings: leds-mt6360: D=
rop redundant 'unevaluatedProperties')
Merging scsi-fixes/fixes (8be70a842f70 scsi: target: pscsi: Set SCF_TREAT_R=
EAD_AS_NORMAL flag only if there is valid data)
Merging drm-fixes/drm-fixes (c18a2a280c07 Merge tag 'drm-misc-fixes-2022-04=
-22' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (f7e1089f4376 drm/i915/fbc: Co=
nsult hw.crtc instead of uapi.crtc)
Merging mmc-fixes/fixes (4bc31edebde5 mmc: core: Set HS clock speed before =
sending HS CMD13)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (312310928417 Linux 5.18-rc1)
Merging hyperv-fixes/hyperv-fixes (eaa03d345358 Drivers: hv: vmbus: Replace=
 smp_store_mb() with virt_store_mb())
Merging soc-fsl-fixes/fix (a222fd854139 soc: fsl: qe: Check of ioremap retu=
rn value)
Merging risc-v-fixes/fixes (8cb3b0a7f6cf RISC-V-fixes: relocate DTB if it's=
 outside memory region)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging spdx/spdx-linus (312310928417 Linux 5.18-rc1)
Merging gpio-brgl-fixes/gpio/for-current (cc7328af2f85 gpiolib: of: fix bou=
nds check for 'gpio-reserved-ranges')
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
Merging cel-fixes/for-rc (4d5004451ab2 SUNRPC: Fix the svc_deferred_event t=
race class)
Merging irqchip-fixes/irq/irqchip-fixes (544808f7e21c irqchip/gic, gic-v3: =
Prevent GSI to SGI translations)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (a5d20d42a2f2 perf symbol: Remove arch__sy=
mbols__fixup_end())
Merging efi-fixes/urgent (9feaf8b387ee efi: fix return value of __setup han=
dlers)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging drm-misc-fixes/for-linux-next-fixes (dc3ae06c5f21 drm/sun4i: Remove=
 obsolete references to PHYS_OFFSET)
Merging kbuild/for-next (7c39c50dcb74 scripts: dummy-tools, add pahole)
Merging perf/perf/core (e0c1b8f9eba8 Merge remote-tracking branch 'torvalds=
/master' into perf/core)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (3cb4503a3301 x86: remove cruft from <asm/dma-=
mapping.h>)
Merging asm-generic/master (fba2689ee77e Merge branch 'remove-h8300' of git=
://git.infradead.org/users/hch/misc into asm-generic)
CONFLICT (modify/delete): Documentation/devicetree/bindings/memory-controll=
ers/renesas,h8300-bsc.yaml deleted in asm-generic/master and modified in HE=
AD.  Version HEAD of Documentation/devicetree/bindings/memory-controllers/r=
enesas,h8300-bsc.yaml left in tree.
$ git rm -f Documentation/devicetree/bindings/memory-controllers/renesas,h8=
300-bsc.yaml
Merging arc/for-next (6aa98f621786 ARC: bpf: define uapi for BPF_PROG_TYPE_=
PERF_EVENT program type)
Merging arm/for-next (012d2fb6c8c9 Merge branch 'devel-stable' into for-nex=
t)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
CONFLICT (content): Merge conflict in arch/arm/Kconfig
CONFLICT (content): Merge conflict in arch/arm/Kconfig.debug
CONFLICT (content): Merge conflict in arch/arm/boot/compressed/Makefile
CONFLICT (content): Merge conflict in arch/arm/include/asm/switch_to.h
CONFLICT (content): Merge conflict in arch/arm/kernel/traps.c
Merging arm64/for-next/core (8c816adaabd3 Merge branch 'for-next/kselftest'=
 into for-next/core)
Merging arm-perf/for-next/perf (602c873eb52e perf: Replace acpi_bus_get_dev=
ice())
Merging arm-soc/for-next (967ba514d3a6 Merge branch 'arm/multiplatform-late=
' into for-next)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
CONFLICT (content): Merge conflict in drivers/video/fbdev/omap/lcdc.c
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (ed532523b458 Merge branch 'v5.18/fixes' into for-=
next)
Merging aspeed/for-next (d9540eeaa3d1 Merge branches 'nuvoton-dt-for-v5.18'=
 and 'dt-for-v5.18' into for-next)
Merging at91/at91-next (0c640d9544d0 ARM: dts: at91: fix pinctrl phandles)
Merging drivers-memory/for-next (210c095cf053 Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (08021731ef7a Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (54715794cbcd Merge branch 'v5.18-next/soc' into =
for-next)
Merging mvebu/for-next (8885ae5142a4 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (dbcd30706466 Merge branch 'maintainers-take2' into f=
or-next)
Merging qcom/for-next (6f10ad5a38ff Merge branches 'arm64-for-5.19', 'arm64=
-defconfig-for-5.19', 'clk-for-5.19', 'defconfig-for-5.19', 'drivers-for-5.=
19', 'dts-for-5.19' and 'arm64-fixes-for-5.18' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (114240d3fb67 Merge branches 'renesas-arm-defconfig-fo=
r-v5.19', 'renesas-arm-dt-for-v5.19', 'renesas-drivers-for-v5.19' and 'rene=
sas-dt-bindings-for-v5.19' into renesas-next)
Merging reset/reset/next (3f7bdc13154a dt-bindings: reset: uniphier-glue: C=
lean up clocks, resets, and their names using compatible string)
Merging rockchip/for-next (80ff2eb434b6 Merge branch 'v5.18-armsoc/dtsfixes=
' into for-next)
Merging samsung-krzk/for-next (96a93983e538 Merge branch 'for-v5.19/arm-dts=
64-cleanups' into for-next)
Merging scmi/for-linux-next (7afddcced78c Merge branch 'for-next/ffa' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-lin=
ux-next)
Merging stm32/stm32-next (448fb6ea127c ARM: dts: stm32: enable RTC support =
on stm32mp135f-dk)
Merging sunxi/sunxi/for-next (737a9ba0eeb8 Merge branch 'sunxi/fixes-for-5.=
18' into sunxi/for-next)
Merging tee/next (db30e53bf897 Merge branch 'tee_cleanup_for_v5.19' into ne=
xt)
Merging tegra/for-next (a17c2cb30358 Merge branch for-5.19/arm64/defconfig =
into for-next)
Merging ti/ti-next (481ab3ea39f1 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (312310928417 Linux 5.18-rc1)
Merging clk/clk-next (b473708bf4b5 Merge branch 'clk-airoha' into clk-next)
Merging clk-imx/for-next (39772efd98ad clk: imx8mp: Add DISP2 pixel clock)
Merging clk-renesas/renesas-clk (5d33481f5475 clk: renesas: r9a07g043: Add =
WDT clock and reset entries)
Merging clk-samsung/for-next (45bd8166a1d8 clk: samsung: Add initial Exynos=
7885 clock driver)
Merging csky/linux-next (c5acdf12cc24 csky: atomic: Add conditional atomic =
operations' optimization)
Merging m68k/for-next (a96e4ebf3ded m68k: defconfig: Update defconfigs for =
v5.18-rc1)
Merging m68knommu/for-next (2954225f1484 m68k: coldfire: drop ISA_DMA_API s=
upport)
Merging microblaze/next (68cbfae83a72 microblaze: Add support for reserved =
memory defined by DT)
Merging mips/mips-next (7671f9674b47 mips: dts: ingenic: x1000: Add PWM dev=
ice tree node)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (862cf8d5fd98 openrisc/boot: Remove unnecessary i=
nitialisation in memcpy().)
Merging parisc-hd/for-next (e34799ccc126 parisc: Change MAX_ADDRESS to beco=
me unsigned long long)
Merging powerpc/next (ce522ba9ef7e Linux 5.18-rc2)
Merging soc-fsl/next (1ce93cb102e7 soc: fsl: qe: Check of ioremap return va=
lue)
Merging risc-v/for-next (d26eee72d9b9 riscv: dts: rename the node name of d=
ma)
Merging s390/for-next (4ae59ba72cb5 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (82017457957a um: run_helper: Write error message to=
 kernel log on exec failure on host)
Merging xtensa/xtensa-for-next (c8b222cfc804 xtensa: enable ARCH_HAS_DEBUG_=
VM_PGTABLE)
Merging pidfd/for-next (0014edaedfd8 fs: unset MNT_WRITE_HOLD on failure)
Merging fscrypt/master (a7a5bc5fe8ac fscrypt: log when starting to use inli=
ne encryption)
Merging fscache/fscache-next (312310928417 Linux 5.18-rc1)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (8d5f4f1aac5b Merge branch 'for-next-next-v5.18-2022=
0427' into for-next-20220427)
Merging ceph/master (7acae6183cf3 ceph: fix possible NULL pointer dereferen=
ce for req->r_session)
Merging cifs/for-next (a83b2a60011e cifs: flush all dirty pages to server b=
efore read/write)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (011c045788ed erofs: add 'fsid' mount option)
Merging exfat/dev (1d404b899e32 exfat: reduce block requests when zeroing a=
 cluster)
Merging ext3/for_next (cfb73d370782 Pull evictable fsnotify marks work from=
 Amir.)
Merging ext4/dev (23e3d7f7061f jbd2: fix a potential race while discarding =
reserved buffers after an abort)
Merging f2fs/dev (6daa83cbee0d f2fs: extend stat_lock to avoid potential ra=
ce in statfs)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (6b49bc9d8a5f fuse: avoid unnecessary spinlock bump)
Merging gfs2/for-next (db0c1968e935 gfs2: Variable rename)
Merging jfs/jfs-next (0d4837fdb796 fs: jfs: fix possible NULL pointer deref=
erence in dbFree())
Merging ksmbd/ksmbd-for-next (22da5264abf4 Merge tag '5.18-rc3-ksmbd-fixes'=
 of git://git.samba.org/ksmbd)
Merging nfs/linux-next (00c94ebec592 NFSv4: Don't invalidate inode attribut=
es on delegation return)
Merging nfs-anna/linux-next (d19e0183a883 NFS: Do not report writeback erro=
rs in nfs_getattr())
Merging nfsd/for-next (5c2cb3833940 SUNRPC: Remove svc_rqst::rq_xprt_hlen)
Merging ntfs3/master (52e00ea6b26e fs/ntfs3: Update valid size if -EIOCBQUE=
UED)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (94fd19752b28 ovl: don't fail copy up if n=
o fileattr support on upper)
Merging ubifs/next (705757274599 ubifs: rename_whiteout: correct old_dir si=
ze computing)
Merging v9fs/9p-next (22e424feb665 Revert "fs/9p: search open fids first")
Merging xfs/for-next (a44a027a8b2a Merge tag 'large-extent-counters-v9' of =
https://github.com/chandanr/linux into xfs-5.19-for-next)
Merging zonefs/for-next (31a644b3c2ae documentation: zonefs: Document sysfs=
 attributes)
CONFLICT (content): Merge conflict in fs/zonefs/super.c
Merging iomap/iomap-for-next (ebb7fb1557b1 xfs, iomap: limit individual ioe=
nd chain lengths in writeback)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (fd78f28f9f50 Merge branch 'work.namei' into for-next)
Merging printk/for-next (bfc1f2749c23 Merge branch 'rework/kthreads' into f=
or-next)
Merging pci/next (89905ffa4545 Merge branch 'remotes/lorenzo/pci/rockchip')
Merging pstore/for-next/pstore (8126b1c73108 pstore: Don't use semaphores i=
n always-atomic-context code)
Merging hid/for-next (22d0912fc3fd Merge branch 'for-5.18/upstream-fixes' i=
nto for-next)
CONFLICT (content): Merge conflict in drivers/hid/Kconfig
CONFLICT (content): Merge conflict in drivers/hid/Makefile
Merging i2c/i2c/for-next (05b42eff61a5 Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (6cbf8b38dfe3 i3c: fix uninitialized variable use in i=
2c setup)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (8f8db4b5d10c hwmon: (asus-ec-sensors) add=
 PRIME X470-PRO board)
Merging jc_docs/docs-next (a477b94d6578 Documentation: add missing angle br=
acket in cgroup-v2 doc)
Merging v4l-dvb/master (3d59142ad94c media: dvb-usb: dib0700_devices: use a=
n enum for the device number)
Merging v4l-dvb-next/master (6c1c1eb8c87d media: ext-ctrls-codec.rst: fix i=
ndentation)
Merging pm/linux-next (d3fa656ae5f3 Merge branch 'pm-cpuidle-next' into lin=
ux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (a3b8d1b12c6b cpufreq: mediatek:=
 Fix NULL pointer dereference in mediatek-cpufreq)
Merging cpupower/cpupower (312310928417 Linux 5.18-rc1)
Merging devfreq/devfreq-next (5d521a307526 PM / devfreq: rk3399_dmc: Avoid =
static (reused) profile)
Merging opp/opp/linux-next (3e1fac9324f8 dt-bindings: opp: opp-v2-kryo-cpu:=
 Remove SMEM)
Merging thermal/thermal/linux-next (c07a7c8dbcd8 tools/thermal: Add thermal=
 daemon skeleton)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (e425ac99b157 fs: dlm: cast resource pointer to uintptr_t)
Merging rdma/for-next (ff815a89398d RDMA/core: Avoid flush_workqueue(system=
_unbound_wq) usage)
Merging net-next/master (6fd1d51cfa25 net: SO_RCVMARK socket option for SO_=
MARK with recvmsg())
Merging bpf-next/for-next (32c03c4954a0 selftests/bpf: Use target-less SEC(=
) definitions in various tests)
Merging ipsec-next/master (b58b1f563ab7 xfrm: rework default policy structu=
re)
Merging mlx5-next/mlx5-next (2984287c4c19 net/mlx5: Remove not-implemented =
IPsec capabilities)
Merging netfilter-next/master (0c7b27616fbd selftests: netfilter: add fib e=
xpression forward test case)
Merging ipvs-next/master (0c7b27616fbd selftests: netfilter: add fib expres=
sion forward test case)
Merging bluetooth/master (48b57999e387 Bluetooth: btusb: Add a new PID/VID =
0489/e0c8 for MT7921)
Merging wireless-next/main (8c783024d6ac rtlwifi: btcoex: fix if =3D=3D els=
e warning)
Merging mtd/mtd/next (43823c5c56f2 mtd: cfi_cmdset_0002: Rename chip_ready =
variables)
Merging nand/nand/next (079d6348f3be Merge tag 'mtd/mtk-spi-nand-for-5.19' =
into nand/next)
Merging spi-nor/spi-nor/next (37841975b322 mtd: spi-nor: micron-st: Remove =
status polling on volatile registers write)
Merging crypto/master (c6d3ffae0d32 Revert "hwrng: mpfs - Enable COMPILE_TE=
ST")
Merging drm/drm-next (9bda072a7bec Merge tag 'drm-intel-gt-next-2022-04-27'=
 of git://anongit.freedesktop.org/drm/drm-intel into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/radeon/radeon_sync.c
Merging drm-misc/for-linux-next (1e6b8d5df017 drm/dp_mst: Lower down debug =
info level when receive NAK)
Merging amdgpu/drm-next (3da2c38231a4 drm/amdgpu: Free user pages if amdgpu=
_cs_parser_bos failed)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
Applying: fix up for "drm/ttm: rework bulk move handling v5"
Merging drm-intel/for-linux-next (1bc4ae0ccbc6 drm/i915: Add first set of D=
G2 PCI IDs)
Merging drm-tegra/drm/tegra/for-next (b53c24f69199 drm/tegra: Support YVYU,=
 VYUY and YU24 formats)
Merging drm-msm/msm-next (78f815c1cf8f drm/msm: return the average load ove=
r the polling period)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (2829a9fcb738 drm/etnaviv: reap idle softpin m=
appings when necessary)
Merging fbdev/for-next (f443e374ae13 Linux 5.17)
Merging regmap/for-next (d640947562ce regmap: cache: set max_register with =
reg_stride)
Merging sound/for-next (011b559be832 ALSA: pcm: Check for null pointer of p=
ointer substream before dereferencing it)
Merging sound-asoc/for-next (24358b70043b Merge remote-tracking branch 'aso=
c/for-5.19' into asoc-next)
Merging modules/modules-next (eb28e156bfd4 kallsyms: enhance %pS/s/b printi=
ng when KALLSYSMS is disabled)
Merging input/next (75e97ccaf557 Input: sun4i-lradc-keys - add support for =
R329 and D1)
$ git reset --hard HEAD^
Merging next-20220426 version of input
Merging block/for-next (f11ddc0bcd61 Merge branch 'for-5.19/drivers' into f=
or-next)
Merging device-mapper/for-next (e7ea9556985f dm: improve abnormal bio proce=
ssing)
Merging libata/for-next (0cb63670d505 ata: Make use of the helper function =
devm_platform_ioremap_resource())
Merging pcmcia/pcmcia-next (3928cf08334e pcmcia: db1xxx_ss: restrict to MIP=
S_DB1XXX boards)
Merging mmc/next (ac9d25557dcc mmc: core: Add CIDs for cards to the entropy=
 pool)
Merging mfd/for-mfd-next (3474b838f420 dt-bindings: Drop undocumented i.MX =
iomuxc-gpr bindings in examples)
Merging backlight/for-backlight-next (023a8830a628 backlight: backlight: Sl=
ighly simplify devm_of_find_backlight())
Merging battery/for-next (312310928417 Linux 5.18-rc1)
Merging regulator/for-next (14df95a733a6 Merge remote-tracking branch 'regu=
lator/for-5.19' into regulator-next)
Merging security/next-testing (047843bdb316 Merge branch 'landlock_lsm_v34'=
 into next-testing)
Merging apparmor/apparmor-next (c2489617b3b9 apparmor: Fix undefined refere=
nce to `zlib_deflate_workspacesize')
Merging integrity/next-integrity (29d1c2b47ef3 ima: remove redundant initia=
lization of pointer 'file'.)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (6a9e261cbbee selinux: don't sleep when CONFIG_SECURIT=
Y_SELINUX_CHECKREQPROT_VALUE is true)
Merging smack/next (ba6b652bd863 smack: Remove redundant assignments)
Merging tomoyo/master (ae5d03879e63 workqueue: Warn flushing of kernel-glob=
al workqueues)
Merging tpmdd/next (fad7eba9464e certs: Explain the rationale to call panic=
())
Merging watchdog/master (b2d229d4ddb1 Linux 5.18-rc3)
Merging iommu/next (71ff461c3f41 iommu/omap: Fix regression in probe for NU=
LL pointer dereference)
Merging audit/next (312310928417 Linux 5.18-rc1)
Merging devicetree/for-next (8274c8eae1d3 dt-bindings: fsl: convert fsl,lay=
erscape-scfg to YAML)
Merging mailbox/mailbox-for-next (1b0d0f7c12d5 dt-bindings: mailbox: add de=
finition for mt8186)
Merging spi/for-next (4b939e3a3e91 Merge remote-tracking branch 'spi/for-5.=
19' into spi-next)
Merging tip/master (aea1ae1ab93e Merge x86/cpu into tip/master)
CONFLICT (content): Merge conflict in Documentation/admin-guide/kernel-para=
meters.txt
CONFLICT (content): Merge conflict in kernel/sysctl.c
Merging clockevents/timers/drivers/next (49c14f94ccfe clocksource/drivers/t=
imer-of: check return value of of_iomap in timer_of_base_init())
Merging edac/edac-for-next (0455d61c8ecc Merge edac-misc into for-next)
Merging irqchip/irq/irqchip-next (4bde53ab3370 Merge branch irq/gpio-immuta=
ble into irq/irqchip-next)
Merging ftrace/for-next (c87857e21486 Merge branch 'trace/for-next-rtla' in=
to trace/for-next)
Merging rcu/rcu/next (4ccb27d8a0f2 rcutorture: Simplify rcu_torture_read_ex=
it_child() loop)
Merging kvm/next (5d6c7de6446e KVM: x86: Bail to userspace if emulation of =
atomic user access faults)
Applying: fix up for "KVM, SEV: Add KVM_EXIT_SHUTDOWN metadata for SEV-ES"
Merging kvm-arm/next (4e6921a2e6c1 Merge branch kvm-arm64/hyp-stack-guard i=
nto kvmarm-master/next)
Merging kvms390/next (4aa5ac75bf79 KVM: s390: Fix lockdep issue in vm memop)
Merging xen-tip/linux-next (533bec143a4c arm/xen: Fix some refcount leaks)
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (10a5a651e3af workqueue: Restrict kworker in th=
e offline CPU pool running on housekeeping CPUs)
Merging drivers-x86/for-next (b0c07116c894 platform/x86: amd-pmc: Avoid rea=
ding SMU version at probe time)
Merging chrome-platform/for-next (57b888ca2541 platform/chrome: Re-introduc=
e cros_ec_cmd_xfer and use it for ioctls)
Merging hsi/for-next (43c14f8d18a7 HSI: omap_ssi: Fix refcount leak in ssi_=
probe)
Merging leds/for-next (312310928417 Linux 5.18-rc1)
Merging ipmi/for-next (b250fa7e0b68 ipmi: Make two logs unique)
Merging driver-core/driver-core-next (4388f887b857 Revert "firmware_loader:=
 use kernel credentials when reading firmware")
Merging usb/usb-next (bdddc253b093 usb: rework usb_maxpacket() using usb_pi=
pe_endpoint())
CONFLICT (content): Merge conflict in drivers/usb/dwc3/drd.c
Merging thunderbolt/next (9d2d0a5cf0ca thunderbolt: Use different lane for =
second DisplayPort tunnel)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (312310928417 Linux 5.18-rc1)
Merging tty/tty-next (1e70d57e7285 ACPI / property: Document RS485 _DSD pro=
perties)
Merging char-misc/char-misc-next (c268c0a8a330 bus: mhi: ep: Add uevent sup=
port for module autoloading)
Merging coresight/next (c86dd9869128 coresight: etm4x: Cleanup TRCRSCTLRn r=
egister accesses)
Merging fpga/for-next (eee1071ee7df fpga: Use tab instead of space indentat=
ion)
Merging icc/icc-next (fd3abb2525a1 Merge branch 'icc-sdx65' into icc-next)
Merging iio/togreg (26e538545622 dt-bindings: iio: Fix incorrect compatible=
 strings in examples)
CONFLICT (content): Merge conflict in drivers/iio/dac/ti-dac5571.c
Merging phy-next/next (f7f9abc5eab9 phy: freescale: imx8m-pcie: Handle IMX8=
_PCIE_REFCLK_PAD_UNUSED)
Merging soundwire/next (60657fb9b19d dt-bindings: soundwire: qcom: Add bind=
ings for audio clock reset control property)
Merging extcon/extcon-next (dc9620421424 extcon: sm5502: Clarify SM5703's i=
2c device ID)
CONFLICT (content): Merge conflict in drivers/usb/dwc3/drd.c
Applying: fixup for "usb: dwc3: Don't switch OTG -> peripheral if extcon is=
 present"
Merging gnss/gnss-next (312310928417 Linux 5.18-rc1)
Merging vfio/next (f621eb13facb vfio-pci: Provide reviewers and acceptance =
criteria for variant drivers)
Merging staging/staging-next (5fe7856ad59a staging: vt6655: Replace MACvRea=
dISR with VNSvInPortD)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (99faef48e7a3 dmaengine: mv_xor_v2 : Move spin_lock_=
bh() to spin_lock())
Merging cgroup/for-next (5c26993c31f0 cgroup: Add config file to cgroup sel=
ftest suite)
Merging scsi/for-next (5fc5d6fc39a6 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (cd186449fe1c scsi: sr: Add memory allocation fai=
lure handling for get_capabilities())
Merging vhost/linux-next (1c80cf031e02 vdpa: mlx5: synchronize driver statu=
s with CVQ)
Merging rpmsg/for-next (e8d9d4560c51 Merge branches 'rpmsg-next', 'rproc-ne=
xt' and 'hwspinlock-next' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (fae74fb5d525 gpio: pcf857x: Make teardown =
callback return void)
Merging gpio-intel/for-next (edc5601db664 pinctrl: meson: Replace custom co=
de by gpiochip_node_count() call)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (da47917f1f65 Merge branch 'devel' into for-next)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/int=
errupt-controller/qcom,pdc.txt
Merging pinctrl-intel/for-next (0be0b70df661 pinctrl: alderlake: Fix regist=
er offsets for ADL-N variant)
Merging pinctrl-renesas/renesas-pinctrl (f7bc5f52d235 pinctrl: renesas: rzg=
2l: Restore pin config order)
Merging pinctrl-samsung/for-next (ac875df4d854 pinctrl: samsung: fix missin=
g GPIOLIB on ARM64 Exynos config)
Merging pwm/for-next (2bf8ee0faa98 dt-bindings: pwm: Add interrupts propert=
y for MediaTek MT8192)
Merging userns/for-next (9def41809e95 Merge of prlimit-tasklist_lock-for-v5=
.18, per-namespace-ipc-sysctls-for-v5.18, and ptrace-for-v5.18 for testing =
in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (c7b607fa9325 selftests/resctrl: Fix null pointer de=
reference on open failed)
Merging livepatching/for-next (0e1b951d6de0 Merge branch 'for-5.18/selftest=
s-fixes' into for-next)
Merging rtc/rtc-next (312310928417 Linux 5.18-rc1)
Merging nvdimm/libnvdimm-for-next (bb7bf697fed5 nvdimm: Allow overwrite in =
the presence of disabled dimms)
Merging at24/at24/for-next (312310928417 Linux 5.18-rc1)
Merging ntb/ntb-next (e9d0fa5e2482 IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (8a3d3ea66f0d selftests/seccomp: Add SKIP =
for failed unshare())
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (f2af60bb7ce2 fsi: Add trace events in initialization path)
Merging slimbus/for-next (54bf672111ee slimbus: qcom: Fix IRQ check in qcom=
_slim_probe)
Merging nvmem/for-next (2e26a810b679 nvmem: sunplus-ocotp: staticize sp_otp=
_v0)
Merging xarray/main (63b1898fffcd XArray: Disallow sibling entries of nodes)
Merging hyperv/hyperv-next (455880dfe292 PCI: hv: Fix hv_arch_irq_unmask() =
for multi-MSI)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (312310928417 Linux 5.18-rc1)
Merging kunit/test (312310928417 Linux 5.18-rc1)
Merging cfi/cfi/next (312310928417 Linux 5.18-rc1)
Merging kunit-next/kunit (9bf2eed995f9 kunit: add support for kunit_suites =
that reference init code)
CONFLICT (content): Merge conflict in drivers/thunderbolt/test.c
CONFLICT (content): Merge conflict in net/mctp/test/route-test.c
CONFLICT (content): Merge conflict in security/apparmor/policy_unpack_test.c
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (58043faa5f84 bus: mhi: pci_generic: add Telit FN980 v=
1 hardware revision)
Merging memblock/for-next (58ffc34896db memblock tests: Add TODO and README=
 files)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (280302f0e8f6 cxl/mbox: Replace NULL check with IS_ERR() a=
fter vmemdup_user())
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (736e0f2179d3 efi/arm64: libstub: run image in place if ra=
ndomized by the loader)
CONFLICT (content): Merge conflict in drivers/virt/Kconfig
CONFLICT (content): Merge conflict in drivers/virt/Makefile
Merging unicode/for-next (b500d6d7243d unicode: Handle memory allocation fa=
ilures in mkutf8data)
Merging slab/for-next (48ae8244f719 Merge branches 'slab/for-5.19/stackdepo=
t' and 'slab/for-5.19/refactor' into slab/for-next)
Merging random/master (821a9780a9a2 random: insist on random_get_entropy() =
existing in order to simplify)
Merging landlock/next (312310928417 Linux 5.18-rc1)
Merging rust/rust-next (011150424cd9 rust: avoid all GCC plugins, not just =
the randstruct one)
CONFLICT (content): Merge conflict in Makefile
Merging sysctl/sysctl-next (a467257ffe4b kernel/kexec_core: move kexec_core=
 sysctls into its own file)
CONFLICT (content): Merge conflict in kernel/rcu/rcu.h
Merging folio/for-next (98ea02597b99 mm/rmap: Fix handling of hugetlbfs pag=
es in page_vma_mapped_walk)
Merging execve/for-next/execve (70578ff3367d binfmt_flat: Remove shared lib=
rary support)
Merging bitmap/bitmap-for-next (28bf2111f48c include/linux/find: Fix docume=
ntation)
Merging kspp/for-next/kspp (e6f3b3c9c109 cfi: Use __builtin_function_start)
Merging kspp-gustavo/for-next/kspp (6bf825b2731d Merge branch 'for-next/ksp=
p-checkpatch' into for-next/kspp)
Merging mm/mm-everything (6e743d555fee Merge branch 'mm-nonmm-unstable' int=
o mm-everything)
CONFLICT (content): Merge conflict in arch/x86/mm/Makefile
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (dbf9f3888206 kselftest/vm: override TARGETS from argum=
ents)

--Sig_/cBqKwjOxhdKzgXgBXcZKeys
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJrlD0ACgkQAVBC80lX
0GzdBwf/SvqX7zMi8SMOeowz5tXv3nUXf657HKpRHeNERl3Xpr/zkeT8MFrqSNiQ
U6WYvkJximV0734P4RAhpQ3c6mOIFCSWWTQAdSDCcvMW0AdLwgDU+RDeAw5iwTND
xACb6P0/TE5qtkVSzLUIbIV7/yFQTIdW1zbcuvHL/bF7B7hkckt7WH7tVMegyYsJ
O/33a9q20lm21/tRFhd6CURf1T56z4FatjYTj4tGnwC94TDjdNJekLDa1MI9LRrw
Gmje65/knkg/5WWUowW5ArbMpwFUGslT2CF+Zjtc9LR1U/43SGAKfEYhPdZeGDLb
mIACUL03ymjV3513lmkrdKse/Vep1A==
=qKwG
-----END PGP SIGNATURE-----

--Sig_/cBqKwjOxhdKzgXgBXcZKeys--
