Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EFD50B048
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444238AbiDVGOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444236AbiDVGOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:14:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF9150074;
        Thu, 21 Apr 2022 23:11:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kl3v62Qmqz4xLb;
        Fri, 22 Apr 2022 16:11:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650607874;
        bh=xIq5rqkImq7cPkujf56AWbQH+zwnoR+NMXowsh/A48c=;
        h=Date:From:To:Cc:Subject:From;
        b=sf8vgiJf/R1Vc4hzADCzb+zrmibuAPlxMNkydvdMKLH1zYkDNpU6FKe1q+Y+CPMZE
         gPKbhIByN5Y/kD66JNW7c9PqDWX+zvmC1IhxjEN/JClqDiieejn/N6nUvRMNQPopkb
         UpDJa2Gvz4V2XhrTeLrTqWnBp90OI3iRp2oEjyrVcNx+ksOMwUt4xgX2c1kDapQRLH
         6xSgmvdGmFyEde8P8HVntXCUom7Y4XIOogbF21zboDwL/JOVUPPTx42IrGH9D4XgDF
         XI1mBDwRbplSCU1SHNh9OUVjoPGRdNJKnotKrW7FWVj+UXOM67eifvuw/Sfg35lnZt
         YnadCZqt8Hl7g==
Date:   Fri, 22 Apr 2022 16:11:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 22
Message-ID: <20220422161113.6f347c67@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AoO8U77+ABa_Xl7A8aXM7pQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AoO8U77+ABa_Xl7A8aXM7pQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220421:

The arm-soc tree gained a conflict against the samsung-krzk-fixes tree.

The hid tree gained a conflict against Linus' tree.

The bpf-next tree lost its build failure.

The block tree still had its build failure for which I applied a patch.

The kvm tree still had its build failure for which I applied a patch.

The random tree gained a conflict against the jc_docs tree.

Non-merge commits (relative to Linus' tree): 5184
 5956 files changed, 221253 insertions(+), 113590 deletions(-)

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

I am currently merging 344 trees (counting Linus' and 93 trees of bug
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
Merging origin/master (59f0c2447e25 Merge tag 'net-5.18-rc4' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (312310928417 Linux 5.18-rc1)
Merging arc-current/for-curr (c6ed4d84a2c4 ARC: remove redundant READ_ONCE(=
) in cmpxchg loop)
Merging arm-current/fixes (9be4c88bb792 ARM: 9191/1: arm/stacktrace, kasan:=
 Silence KASAN warnings in unwind_frame())
Merging arm64-fixes/for-next/fixes (0ff74a23e08f arm64: fix typos in commen=
ts)
Merging arm-soc-fixes/arm/fixes (846e24dcae5d Merge tag 'omap-for-v5.18/fix=
es-take2' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-oma=
p into arm/fixes)
Merging drivers-memory-fixes/fixes (73039c6c7f36 memory: renesas-rpc-if: Fi=
x HF/OSPI data transfer in Manual Mode)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (0d52a01a266b m68k: defconfig: Disable fbdev=
 on Sun3/3x)
Merging powerpc-fixes/fixes (bb82c574691d powerpc/perf: Fix 32bit compile)
Merging s390-fixes/fixes (c68c63429319 s390: enable CONFIG_HARDENED_USERCOP=
Y in debug_defconfig)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (bc6de2878429 drivers: net: hippi: Fix deadlock in rr_cl=
ose())
Merging bpf/master (425d239379db bpf: Fix release of page_pool in BPF_PROG_=
RUN in test runner)
Merging ipsec/master (5bd8baab087d esp: limit skb_page_frag_refill use to a=
 single page)
Merging netfilter/master (05ae2fba821c netfilter: nft_socket: make cgroup m=
atch work in input too)
Merging ipvs/master (05ae2fba821c netfilter: nft_socket: make cgroup match =
work in input too)
Merging wireless/main (ef27324e2cb7 nfc: nci: add flush_workqueue to preven=
t uaf)
Merging rdma-fixes/for-rc (ce522ba9ef7e Linux 5.18-rc2)
Merging sound-current/for-linus (86222af07abf ALSA: hda/realtek: Add quirk =
for Clevo NP70PNP)
Merging sound-asoc-fixes/for-linus (d8c1d8dd6bb3 Merge remote-tracking bran=
ch 'asoc/for-5.17' into asoc-linus)
Merging regmap-fixes/for-linus (312310928417 Linux 5.18-rc1)
Merging regulator-fixes/for-linus (908b768f9a8f MAINTAINERS: Fix reviewer i=
nfo for a few ROHM ICs)
Merging spi-fixes/for-linus (8868c03f3ca5 spi: spi-mem: check if data buffe=
rs are on stack)
Merging pci-current/for-linus (92597f97a40b PCI/PM: Avoid putting Elo i2 PC=
Ie Ports in D3cold)
Merging driver-core.current/driver-core-linus (1dc9f1a66e17 arch_topology: =
Do not set llc_sibling if llc_id is invalid)
Merging tty.current/tty-linus (48473802506d tty: n_gsm: fix missing update =
of modem controls after DLCI open)
Merging usb.current/usb-linus (bf95c4d4630c usb: gadget: configfs: clear de=
activation flag in configfs_composite_unbind())
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (e23e50e7acc8 USB: serial: whiteheat: fi=
x heap overflow in WHITEHEAT_GET_DTR_RTS)
Merging phy/fixes (2c8045d48dee phy: amlogic: fix error path in phy_g12a_us=
b3_pcie_probe())
Merging staging.current/staging-linus (ce522ba9ef7e Linux 5.18-rc2)
Merging iio-fixes/fixes-togreg (b5d6ba09b10d iio: imu: inv_icm42600: Fix I2=
C init possible nack)
Merging counter-fixes/fixes-togreg (ce522ba9ef7e Linux 5.18-rc2)
Merging char-misc.current/char-misc-linus (ce522ba9ef7e Linux 5.18-rc2)
Merging soundwire-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging thunderbolt-fixes/fixes (b2d229d4ddb1 Linux 5.18-rc3)
Merging input-current/for-linus (470776c6b034 Input: add Marine Navigation =
Keycodes)
Merging crypto-current/master (aa8e73eed7d3 crypto: x86/sm3 - Fixup SLS)
Merging vfio-fixes/for-linus (1ef3342a934e vfio/pci: Fix vf_token mechanism=
 when device-specific VF drivers are used)
Merging kselftest-fixes/fixes (ce64763c6385 testing/selftests/mqueue: Fix m=
q_perf_tests to free the allocated cpu set)
Merging modules-fixes/modules-linus (dc0ce6cc4b13 lib/test: use after free =
in register_test_dev_kmod())
Merging dmaengine-fixes/fixes (7495a5bbf89f dt-bindings: dmaengine: qcom: g=
pi: Add minItems for interrupts)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (ba7542eb2dd5 mtd: rawnand: qcom: fix memory co=
rruption that causes panic)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (3d59142ad94c media: dvb-usb: dib0700_devices: =
use an enum for the device number)
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
Merging hwmon-fixes/hwmon (4aaaaf0f2798 hwmon: (f71882fg) Fix negative temp=
erature)
Merging nvdimm-fixes/libnvdimm-fixes (d28820419ca3 cxl/pci: Drop shadowed v=
ariable)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (fb95740ffb07 Merge branch 'misc-5.18' into =
next-fixes)
Merging vfs-fixes/fixes (9d2231c5d74e lib/iov_iter: initialize "flags" in n=
ew pipe_buffer)
Merging dma-mapping-fixes/for-linus (18a3c5f7abfd Merge tag 'for_linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (b2dd71f9f728 tools/power/x86/intel-speed-s=
elect: fix build failure when using -Wl,--as-needed)
Merging samsung-krzk-fixes/fixes (436ce66003d5 ARM: s3c: mark as deprecated=
 and schedule removal)
Merging pinctrl-samsung-fixes/fixes (ac875df4d854 pinctrl: samsung: fix mis=
sing GPIOLIB on ARM64 Exynos config)
Merging devicetree-fixes/dt/linus (652980b1541c dt-bindings: display: panel=
-timing: Define a single type for properties)
Merging scsi-fixes/fixes (faad6cebded8 scsi: sr: Do not leak information in=
 ioctl)
Merging drm-fixes/drm-fixes (b2d229d4ddb1 Linux 5.18-rc3)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (bb02330408a7 drm/i915/display=
/psr: Unset enable_psr2_sel_fetch if other checks in intel_psr2_config_vali=
d() fails)
Merging mmc-fixes/fixes (ce522ba9ef7e Linux 5.18-rc2)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (312310928417 Linux 5.18-rc1)
Merging hyperv-fixes/hyperv-fixes (eaa03d345358 Drivers: hv: vmbus: Replace=
 smp_store_mb() with virt_store_mb())
Merging soc-fsl-fixes/fix (a222fd854139 soc: fsl: qe: Check of ioremap retu=
rn value)
Merging risc-v-fixes/fixes (bf9bac40b763 RISC-V: cpuidle: fix Kconfig selec=
t for RISCV_SBI_CPUIDLE)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging spdx/spdx-linus (312310928417 Linux 5.18-rc1)
Merging gpio-brgl-fixes/gpio/for-current (b2d229d4ddb1 Linux 5.18-rc3)
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
Merging perf-current/perf/urgent (f58faed7fb3f perf bench: Fix numa bench t=
o fix usage of affinity for machines with #CPUs > 1K)
Merging efi-fixes/urgent (9feaf8b387ee efi: fix return value of __setup han=
dlers)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging drm-misc-fixes/for-linux-next-fixes (94f4c4965e55 drm/amdgpu: parti=
al revert "remove ctx->lock" v2)
Merging kbuild/for-next (a7fdf95e04f4 scripts: dummy-tools, add pahole)
Merging perf/perf/core (41204da4c160 perf test: Shell - Limit to only run e=
xecutable scripts in tests)
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
Merging arc/for-next (6880fa6c5660 Linux 5.15-rc1)
Merging arm/for-next (012d2fb6c8c9 Merge branch 'devel-stable' into for-nex=
t)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
CONFLICT (content): Merge conflict in arch/arm/Kconfig
CONFLICT (content): Merge conflict in arch/arm/Kconfig.debug
CONFLICT (content): Merge conflict in arch/arm/boot/compressed/Makefile
CONFLICT (content): Merge conflict in arch/arm/include/asm/switch_to.h
CONFLICT (content): Merge conflict in arch/arm/kernel/traps.c
Merging arm64/for-next/core (641d80415729 Merge branch 'for-next/spectre-bh=
b' into for-next/core)
Merging arm-perf/for-next/perf (602c873eb52e perf: Replace acpi_bus_get_dev=
ice())
Merging arm-soc/for-next (44e7aa41c738 Merge branch 'arm/drivers' into for-=
next)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (ed532523b458 Merge branch 'v5.18/fixes' into for-=
next)
Merging aspeed/for-next (d9540eeaa3d1 Merge branches 'nuvoton-dt-for-v5.18'=
 and 'dt-for-v5.18' into for-next)
Merging at91/at91-next (0c640d9544d0 ARM: dts: at91: fix pinctrl phandles)
Merging drivers-memory/for-next (3b8e7e227bd5 Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (7b82dc271190 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (6ceb6a96db4e Merge branch 'v5.17-fixes' into for=
-next)
Merging mvebu/for-next (8885ae5142a4 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (e7b192fae27b Merge branch 'omap-for-v5.19/ti-sysc' i=
nto for-next)
Merging qcom/for-next (260ec87d3b48 Merge branches 'arm64-for-5.19', 'arm64=
-defconfig-for-5.19', 'clk-for-5.19', 'defconfig-for-5.19', 'drivers-for-5.=
19', 'dts-for-5.19' and 'arm64-fixes-for-5.18' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (fc84df8749fa Merge branches 'renesas-arm-defconfig-fo=
r-v5.19' and 'renesas-arm-dt-for-v5.19' into renesas-next)
Merging reset/reset/next (3f7bdc13154a dt-bindings: reset: uniphier-glue: C=
lean up clocks, resets, and their names using compatible string)
Merging rockchip/for-next (80ff2eb434b6 Merge branch 'v5.18-armsoc/dtsfixes=
' into for-next)
Merging samsung-krzk/for-next (ede6d0d54a85 Merge branch 'for-v5.19/arm-dts=
64-cleanups' into for-next)
Merging scmi/for-linux-next (06fd9f1ceb6e Merge branch 'for-next/juno' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (448fb6ea127c ARM: dts: stm32: enable RTC support =
on stm32mp135f-dk)
Merging sunxi/sunxi/for-next (dd8742e8a17d Merge branch 'sunxi/dt-for-5.19'=
 into sunxi/for-next)
Merging tee/next (17522923771d Merge branch 'fixes' into next)
Merging tegra/for-next (aee7f609222b Merge branch for-5.19/arm64/dt into fo=
r-next)
Merging ti/ti-next (d3e3116f2535 soc: ti: knav_dma: Use pm_runtime_resume_a=
nd_get instead of pm_runtime_get_sync)
Merging xilinx/for-next (312310928417 Linux 5.18-rc1)
Merging clk/clk-next (312310928417 Linux 5.18-rc1)
Merging clk-imx/for-next (39772efd98ad clk: imx8mp: Add DISP2 pixel clock)
Merging clk-renesas/renesas-clk (59086e4193f4 clk: renesas: r9a07g043: Add =
SDHI clock and reset entries)
Merging clk-samsung/for-next (45bd8166a1d8 clk: samsung: Add initial Exynos=
7885 clock driver)
Merging csky/linux-next (a8440ece64f1 csky: atomic: Add conditional atomic =
operations' optimization)
Merging m68k/for-next (05d51e42df06 m68k: Introduce a virtual m68k machine)
Merging m68knommu/for-next (b2d229d4ddb1 Linux 5.18-rc3)
Merging microblaze/next (68cbfae83a72 microblaze: Add support for reserved =
memory defined by DT)
Merging mips/mips-next (b2d229d4ddb1 Linux 5.18-rc3)
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
Merging s390/for-next (270a62595741 Merge branch 'fixes' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (82017457957a um: run_helper: Write error message to=
 kernel log on exec failure on host)
Merging xtensa/xtensa-for-next (10b0948de634 xtensa: add hibernation suppor=
t)
Merging pidfd/for-next (0014edaedfd8 fs: unset MNT_WRITE_HOLD on failure)
Merging fscrypt/master (a7a5bc5fe8ac fscrypt: log when starting to use inli=
ne encryption)
Merging fscache/fscache-next (312310928417 Linux 5.18-rc1)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (1983158cf565 Merge branch 'for-next-next-v5.18-2022=
0421' into for-next-20220421)
Merging ceph/master (c4ffd8a5eb94 ceph: remove incorrect session state chec=
k)
Merging cifs/for-next (f5d0f921ea36 cifs: destage any unwritten data to the=
 server before calling copychunk_write)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (a1108dcd9373 erofs: rename ctime to mtime)
Merging exfat/dev (1d404b899e32 exfat: reduce block requests when zeroing a=
 cluster)
Merging ext3/for_next (f06e95c3a4ca Merge fsnotify cleanup from Bang Li.)
Merging ext4/dev (eb7054212eac ext4: update the cached overhead value in th=
e superblock)
Merging f2fs/dev (b79ddd945ea2 f2fs: avoid infinite loop to flush node page=
s)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (8c9f0263968a fuse: Apply flags2 only when userspace =
set the FUSE_INIT_EXT)
Merging gfs2/for-next (1b2de0791571 gfs2: Mark the remaining process-indepe=
ndent glock holders as GL_NOPID)
Merging jfs/jfs-next (0d4837fdb796 fs: jfs: fix possible NULL pointer deref=
erence in dbFree())
Merging ksmbd/ksmbd-for-next (02655a70b7cc ksmbd: set fixed sector size to =
FS_SECTOR_SIZE_INFORMATION)
Merging nfs/linux-next (ff053dbbaffe SUNRPC: Move the call to xprt_send_pag=
edata() out of xprt_sock_sendmsg())
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
Merging xfs/for-next (ce522ba9ef7e Linux 5.18-rc2)
Merging zonefs/for-next (c907372552bb documentation: zonefs: Document sysfs=
 attributes)
Merging iomap/iomap-for-next (ebb7fb1557b1 xfs, iomap: limit individual ioe=
nd chain lengths in writeback)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (fd78f28f9f50 Merge branch 'work.namei' into for-next)
Merging printk/for-next (84d7df104dba Merge branch 'for-5.19' into for-next)
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
Merging hwmon-staging/hwmon-next (a1872eb1a376 hwmon: (intel-m10-bmc-hwmon)=
 use devm_hwmon_sanitize_name())
Merging jc_docs/docs-next (7e204fa217ee Documentation: move watch_queue to =
core-api)
Merging v4l-dvb/master (3d59142ad94c media: dvb-usb: dib0700_devices: use a=
n enum for the device number)
Merging v4l-dvb-next/master (3d59142ad94c media: dvb-usb: dib0700_devices: =
use an enum for the device number)
Merging pm/linux-next (a8a4f8e63bdf Merge branch 'pm-tools' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (f2d9973abd73 cpufreq: mediatek:=
 Enable clocks and regulators)
Merging cpupower/cpupower (312310928417 Linux 5.18-rc1)
Merging devfreq/devfreq-next (5d521a307526 PM / devfreq: rk3399_dmc: Avoid =
static (reused) profile)
Merging opp/opp/linux-next (543256d239b4 PM: opp: simplify with dev_err_pro=
be())
Merging thermal/thermal/linux-next (e08277df1e1a thermal/drivers/thermal_of=
: Add change_mode ops support for thermal_of sensor)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (e425ac99b157 fs: dlm: cast resource pointer to uintptr_t)
Merging rdma/for-next (98c8026331ce RDMA/rxe: Remove reliable datagram supp=
ort)
Merging net-next/master (9c8774e629a1 net: eql: Use kzalloc instead of kmal=
loc/memset)
CONFLICT (content): Merge conflict in drivers/net/ethernet/microchip/lan966=
x/lan966x_main.c
Merging bpf-next/for-next (b71a2ebf74ef libbpf: Remove redundant non-null c=
hecks on obj_elf)
Merging ipsec-next/master (b58b1f563ab7 xfrm: rework default policy structu=
re)
Merging mlx5-next/mlx5-next (2984287c4c19 net/mlx5: Remove not-implemented =
IPsec capabilities)
Merging netfilter-next/master (0c7b27616fbd selftests: netfilter: add fib e=
xpression forward test case)
Merging ipvs-next/master (0c7b27616fbd selftests: netfilter: add fib expres=
sion forward test case)
Merging bluetooth/master (40fc9176241f Bluetooth: btusb: Set HCI_QUIRK_BROK=
EN_ENHANCED_SETUP_SYNC_CONN for QCA)
Merging wireless-next/main (dc4246eff026 rtw89: pci: correct return value h=
andling of rtw89_write16_mdio_mask())
Merging mtd/mtd/next (ec8615bcd6f3 mtd: phram: Allow cached mappings)
Merging nand/nand/next (3380557fc7e2 mtd: rawnand: add support for Toshiba =
TC58NVG0S3HTA00 NAND flash)
Merging spi-nor/spi-nor/next (b2d229d4ddb1 Linux 5.18-rc3)
Merging crypto/master (b0c42232fce4 crypto: hisilicon/qm - remove hisi_qm_g=
et_free_qp_num())
Merging drm/drm-next (c54b39a56522 Merge tag 'drm-intel-next-2022-04-13-1' =
of git://anongit.freedesktop.org/drm/drm-intel into drm-next)
Merging drm-misc/for-linux-next (8f97344aa04b drm/ttm: use kvcalloc() inste=
ad of kvmalloc_array() in ttm_tt v2)
CONFLICT (content): Merge conflict in drivers/gpu/drm/radeon/radeon_sync.c
Merging amdgpu/drm-next (e15c9d06e9ad drm/amd/amdgpu: Update PF2VF header)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn10/=
dcn10_hw_sequencer.c
Applying: fix up for "drm/ttm: rework bulk move handling v5"
Merging drm-intel/for-linux-next (b4b157577cb1 drm/i915: Check EDID for HDR=
 static metadata when choosing blc)
Merging drm-tegra/drm/tegra/for-next (b53c24f69199 drm/tegra: Support YVYU,=
 VYUY and YU24 formats)
Merging drm-msm/msm-next (0371870b9690 drm/msm: Revert "drm/msm: Stop using=
 iommu_present()")
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (2829a9fcb738 drm/etnaviv: reap idle softpin m=
appings when necessary)
Merging fbdev/for-next (610323d8f6f8 video: fbdev: mmp: replace usage of fo=
und with dedicated list iterator variable)
CONFLICT (content): Merge conflict in drivers/video/fbdev/omap/lcdc.c
Merging regmap/for-next (bd941dfaae35 regmap: Constify static regmap_bus st=
ructs)
Merging sound/for-next (67d64069bc08 ALSA: usb-audio: Move generic implicit=
 fb quirk entries into quirks.c)
Merging sound-asoc/for-next (5a0381de4ff5 Merge remote-tracking branch 'aso=
c/for-5.19' into asoc-next)
Merging modules/modules-next (eeaec7801c42 powerpc: Select ARCH_WANTS_MODUL=
ES_DATA_IN_VMALLOC on book3s/32 and 8xx)
Merging input/next (66ab05c75642 Input: iqs7222 - avoid dereferencing a NUL=
L pointer)
Merging block/for-next (3aede974de0c Merge branch 'for-5.19/io_uring' into =
for-next)
CONFLICT (content): Merge conflict in fs/xattr.c
Applying: fix up for "io_uring: store SCM state in io_fixed_file->file_ptr"
Merging device-mapper/for-next (7d8342b5551a dm: improve abnormal bio proce=
ssing)
Merging libata/for-next (0cb63670d505 ata: Make use of the helper function =
devm_platform_ioremap_resource())
Merging pcmcia/pcmcia-next (3928cf08334e pcmcia: db1xxx_ss: restrict to MIP=
S_DB1XXX boards)
Merging mmc/next (ef5c15e1f325 dt-bindings: mmc: imx-esdhc: Add i.MX8DXL co=
mpatible string)
Merging mfd/for-mfd-next (d99460ed5cdc dt-bindings: mfd: syscon: Add microc=
hip,lan966x-cpu-syscon compatible)
Merging backlight/for-backlight-next (023a8830a628 backlight: backlight: Sl=
ighly simplify devm_of_find_backlight())
Merging battery/for-next (312310928417 Linux 5.18-rc1)
Merging regulator/for-next (d6344eb23fcd Merge remote-tracking branch 'regu=
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
Merging devicetree/for-next (fe7ff911938e docs: dt: writing-schema: mention=
 yamllint)
Merging mailbox/mailbox-for-next (1b0d0f7c12d5 dt-bindings: mailbox: add de=
finition for mt8186)
Merging spi/for-next (f00156b83d02 Merge remote-tracking branch 'spi/for-5.=
19' into spi-next)
Merging tip/master (fc6a9cd957e9 Merge objtool/urgent into tip/master)
CONFLICT (content): Merge conflict in Documentation/admin-guide/kernel-para=
meters.txt
CONFLICT (content): Merge conflict in kernel/sysctl.c
Merging clockevents/timers/drivers/next (49c14f94ccfe clocksource/drivers/t=
imer-of: check return value of of_iomap in timer_of_base_init())
Merging edac/edac-for-next (423279d81631 Merge branch 'edac-alloc-cleanup' =
into edac-for-next)
Merging irqchip/irq/irqchip-next (4bde53ab3370 Merge branch irq/gpio-immuta=
ble into irq/irqchip-next)
Merging ftrace/for-next (c87857e21486 Merge branch 'trace/for-next-rtla' in=
to trace/for-next)
Merging rcu/rcu/next (24f4daa283b8 doc: Document the rcutree.rcu_divisor ke=
rnel boot parameter)
Merging kvm/next (5d6c7de6446e KVM: x86: Bail to userspace if emulation of =
atomic user access faults)
Applying: fix up for "KVM, SEV: Add KVM_EXIT_SHUTDOWN metadata for SEV-ES"
Merging kvm-arm/next (21ea45784275 KVM: arm64: fix typos in comments)
Merging kvms390/next (4aa5ac75bf79 KVM: s390: Fix lockdep issue in vm memop)
Merging xen-tip/linux-next (b12d41716e32 arm/xen: Fix some refcount leaks)
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
Merging driver-core/driver-core-next (ce522ba9ef7e Linux 5.18-rc2)
Merging usb/usb-next (312310928417 Linux 5.18-rc1)
Merging thunderbolt/next (9d2d0a5cf0ca thunderbolt: Use different lane for =
second DisplayPort tunnel)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (312310928417 Linux 5.18-rc1)
Merging tty/tty-next (05fe70dd2efd MAINTAINERS: fix location of moxa-smarti=
o.rst)
Merging char-misc/char-misc-next (c50c29a80611 tty: synclink_cs: Use bitwis=
e instead of arithmetic operator for flags)
Merging coresight/next (c86dd9869128 coresight: etm4x: Cleanup TRCRSCTLRn r=
egister accesses)
Merging fpga/for-next (eee1071ee7df fpga: Use tab instead of space indentat=
ion)
Merging icc/icc-next (2fb251c26560 interconnect: qcom: sdx55: Drop IP0 inte=
rconnects)
Merging iio/togreg (b28bc9ebbe23 iio: adc: ti-ads1015: Switch to read_avail)
Merging phy-next/next (f7f9abc5eab9 phy: freescale: imx8m-pcie: Handle IMX8=
_PCIE_REFCLK_PAD_UNUSED)
Merging soundwire/next (60657fb9b19d dt-bindings: soundwire: qcom: Add bind=
ings for audio clock reset control property)
Merging extcon/extcon-next (ddc1e8f1d478 extcon: ptn5150: Add usb role clas=
s support)
Merging gnss/gnss-next (312310928417 Linux 5.18-rc1)
Merging vfio/next (f621eb13facb vfio-pci: Provide reviewers and acceptance =
criteria for variant drivers)
Merging staging/staging-next (55de6cb7f81c staging: rtl8192e: Remove space =
after cast)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (643a4a85b0bc dmaengine: hidma: In hidma_prep_dma_me=
mset treat value as a single byte)
Merging cgroup/for-next (1be9b7206b7d Merge branch 'for-5.18' into for-next)
Merging scsi/for-next (70c954151828 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (f9bdac31cf4b scsi: core: Increase max device que=
ue_depth to 4096)
Merging vhost/linux-next (1c80cf031e02 vdpa: mlx5: synchronize driver statu=
s with CVQ)
Merging rpmsg/for-next (58b7c856519f remoteproc: imx_rproc: Ignore create m=
em entry for resource table)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (4f3e79b36d7f gpio: ixp4xx: Detect special =
machines by compatible)
Merging gpio-intel/for-next (edc5601db664 pinctrl: meson: Replace custom co=
de by gpiochip_node_count() call)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (4402e215c42b Merge branch 'devel' into for-next)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/int=
errupt-controller/qcom,pdc.txt
Merging pinctrl-intel/for-next (0be0b70df661 pinctrl: alderlake: Fix regist=
er offsets for ADL-N variant)
Merging pinctrl-renesas/renesas-pinctrl (f7bc5f52d235 pinctrl: renesas: rzg=
2l: Restore pin config order)
Merging pinctrl-samsung/for-next (ac875df4d854 pinctrl: samsung: fix missin=
g GPIOLIB on ARM64 Exynos config)
Merging pwm/for-next (ed14d36498c8 pwm: rcar: Simplify multiplication/shift=
 logic)
Merging userns/for-next (9def41809e95 Merge of prlimit-tasklist_lock-for-v5=
.18, per-namespace-ipc-sysctls-for-v5.18, and ptrace-for-v5.18 for testing =
in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (abd26d348b2a selftests: mqueue: drop duplicate min =
definition)
Merging livepatching/for-next (0e1b951d6de0 Merge branch 'for-5.18/selftest=
s-fixes' into for-next)
Merging rtc/rtc-next (312310928417 Linux 5.18-rc1)
Merging nvdimm/libnvdimm-for-next (ada8d8d337ee nvdimm/blk: Fix title level)
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
Merging xarray/main (3ed4bb77156d XArray: Update the LRU list in xas_split(=
))
Merging hyperv/hyperv-next (eeda29db98f4 x86/hyperv: Output host build info=
 as normal Windows version number)
Merging auxdisplay/auxdisplay (13de23494f38 auxdisplay: lcd2s: Use array si=
ze explicitly in lcd2s_gotoxy())
Merging kgdb/kgdb/for-next (c1cb81429df4 kdb: Fix the putarea helper functi=
on)
Merging hmm/hmm (312310928417 Linux 5.18-rc1)
Merging kunit/test (312310928417 Linux 5.18-rc1)
Merging cfi/cfi/next (e783362eb54c Linux 5.17-rc1)
Merging kunit-next/kunit (59729170afcd kunit: Make kunit_remove_resource() =
idempotent)
CONFLICT (content): Merge conflict in drivers/thunderbolt/test.c
CONFLICT (content): Merge conflict in net/mctp/test/route-test.c
CONFLICT (content): Merge conflict in security/apparmor/policy_unpack_test.c
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (2ab40dd15f1c bus: mhi: host: Use cached values for ca=
lculating the shared write pointer)
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
Merging efi/next (21b68da7bf4a efi: x86: Set the NX-compatibility flag in t=
he PE header)
CONFLICT (content): Merge conflict in drivers/virt/Kconfig
CONFLICT (content): Merge conflict in drivers/virt/Makefile
Merging unicode/for-next (5298d4bfe80f unicode: clean up the Kconfig symbol=
 confusion)
Merging slab/for-next (48ae8244f719 Merge branches 'slab/for-5.19/stackdepo=
t' and 'slab/for-5.19/refactor' into slab/for-next)
Merging random/master (e385815445c3 random: insist on random_get_entropy() =
existing in order to simplify)
CONFLICT (content): Merge conflict in Documentation/security/siphash.rst
Merging landlock/next (312310928417 Linux 5.18-rc1)
Merging rust/rust-next (011150424cd9 rust: avoid all GCC plugins, not just =
the randstruct one)
CONFLICT (content): Merge conflict in Makefile
Merging sysctl/sysctl-next (383189718496 Merge remote-tracking branch 'bpf-=
next/pr/bpf-sysctl' into sysctl-next)
CONFLICT (content): Merge conflict in kernel/rcu/rcu.h
Merging folio/for-next (98ea02597b99 mm/rmap: Fix handling of hugetlbfs pag=
es in page_vma_mapped_walk)
Merging execve/for-next/execve (c85b5d88951b binfmt_flat: Remove shared lib=
rary support)
Merging bitmap/bitmap-for-next (28bf2111f48c include/linux/find: Fix docume=
ntation)
Merging kspp/for-next/kspp (e6f3b3c9c109 cfi: Use __builtin_function_start)
Merging kspp-gustavo/for-next/kspp (452d059ea2b6 drm/amd/display: Fix Wstri=
ngop-overflow warnings in dc_link_dp.c)
Merging akpm-current/current (4027696bb16e ipc/mqueue: use get_tree_nodev()=
 in mqueue_get_tree())
CONFLICT (content): Merge conflict in arch/x86/mm/Makefile
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (25ddfb0de83f kselftest/vm: override TARGETS from argum=
ents)

--Sig_/AoO8U77+ABa_Xl7A8aXM7pQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJiRwEACgkQAVBC80lX
0Gw1Bgf8DJvvAxC6FL4dh77yxKKiO0odVk17o3oHgkC5H+DvRuqd6MRt5h+/mVur
weaO+ksC+c49Asq3++aFOCP83lrDs85LRuu7q+S5F1LqtDgSLcJMBs0rEdIdsvu6
CTe2K0DDKkaYMrcciETo4UaGQ/nOInHAu5pLJ+ZsuNFCZ2JHeLwwdyF5SxtRiMY1
2h4qgBeucE4FSgF4Mw9uZG3WmA86HjnHp/C7oz5eTj+1C70akMfgc1SHMWLSdzFx
l9NJnIo6keftUY2vsl9mN7FjqPpnyVk43j3C2fjNkggaSqtY9RnSN+R3/69PvOw2
EwYVyYGe3crohKl6ZTOoAnog5SWMig==
=6Qsk
-----END PGP SIGNATURE-----

--Sig_/AoO8U77+ABa_Xl7A8aXM7pQ--
