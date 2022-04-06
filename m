Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AD34F57B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344046AbiDFHNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 03:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347281AbiDFHAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 03:00:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9185411A56A;
        Tue,  5 Apr 2022 22:28:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KYCjG0GRlz4xLR;
        Wed,  6 Apr 2022 15:28:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649222914;
        bh=eNPufWaACGf12iGflju/CI+bvCsJ05OsPEkFYhBv9Xg=;
        h=Date:From:To:Cc:Subject:From;
        b=A3UwSf3/gI/vD0zC/RP34zIwb03U+O9Qnf83gTXUe0qIRRAgpvFa0xW+FKEACuhZm
         9arv5ryZ4eEatvlx5r3QK/VdIv1pc5QOh0IG3y3fZDcWWowYAgrJBC9a182jFpyuEq
         KFhApxcgO0TqSA1e9IJO6Jhgn+HuxbZPxP36XINbT4uyXDr32yZ9AxDTq3zBkQ2O+5
         Z9BAxC3cCGPF4i8akr4MedrjvwRzc+XyU7238Lf3bp82kBi2hamcAyUiUBb3e9Mxlv
         JOeKmaDsaWavqOXZoBhvU8E1dMsozb3jnRcCEiZolp5+KBZ8RLAHhiIzVrjG336AQg
         r2oZtlja/zKPA==
Date:   Wed, 6 Apr 2022 15:28:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 6
Message-ID: <20220406152833.4e74847b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OuWB9QmD4bJHwu3E2tUc_D4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OuWB9QmD4bJHwu3E2tUc_D4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220405:

Dropped tree: rcu

The drm-misc tree gained a semantic conflict against Linus' tree.

The amdgpu tree gained a conflict against the drm-misc tree.

The rcu tree gained conflicts against the tip tree due to some
experimental code in the rcu tree.  I dropped it for today.

Non-merge commits (relative to Linus' tree): 1954
 2193 files changed, 87174 insertions(+), 34402 deletions(-)

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
Merging origin/master (3e732ebf7316 Merge tag 'for_linus' of git://git.kern=
el.org/pub/scm/linux/kernel/git/mst/vhost)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (312310928417 Linux 5.18-rc1)
Merging arc-current/for-curr (e783362eb54c Linux 5.17-rc1)
Merging arm-current/fixes (9be4c88bb792 ARM: 9191/1: arm/stacktrace, kasan:=
 Silence KASAN warnings in unwind_frame())
Merging arm64-fixes/for-next/fixes (1d8e926a04b9 perf: MARVELL_CN10K_DDR_PM=
U should depend on ARCH_THUNDER)
Merging arm-soc-fixes/arm/fixes (83a1cde5c74b ARM: davinci: da850-evm: Avoi=
d NULL pointer dereference)
Merging drivers-memory-fixes/fixes (4f9f45d0eb0e dt-bindings: memory: snps,=
ddrc-3.80a compatible also need interrupts)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (0d52a01a266b m68k: defconfig: Disable fbdev=
 on Sun3/3x)
Merging powerpc-fixes/fixes (7f921a2d6c93 KVM: PPC: Move kvmhv_on_pseries()=
 into kvm_ppc.h)
Merging s390-fixes/fixes (f443e374ae13 Linux 5.17)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (03eb7daec59f Merge git://git.kernel.org/pub/scm/linux/k=
ernel/git/netfilter/nf)
Merging bpf/master (0a210af6d0a0 bpf: selftests: Test fentry tracing a stru=
ct_ops program)
Merging ipsec/master (748b82c23e25 xfrm: Pass flowi_oif or l3mdev as oif to=
 xfrm_dst_lookup)
Merging netfilter/master (dea2d93a8ba4 Merge branch '100GbE' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/tnguy/net-queue)
Merging ipvs/master (277f2bb14361 ibmvnic: schedule failover only if vioctl=
 fails)
Merging wireless/main (10cb21f4ff3f Revert "ath11k: mesh: add support for 2=
56 bitmap in blockack frames in 11ax")
Merging rdma-fixes/for-rc (4d809f69695d IB/rdmavt: add lock to call to rvt_=
error_qp to prevent a race condition)
Merging sound-current/for-linus (1ef8715975de ALSA: usb-audio: Fix undefine=
d behavior due to shift overflowing the constant)
Merging sound-asoc-fixes/for-linus (8ab89e4e6b5d Merge remote-tracking bran=
ch 'asoc/for-5.17' into asoc-linus)
Merging regmap-fixes/for-linus (312310928417 Linux 5.18-rc1)
Merging regulator-fixes/for-linus (2316f0fc0ad2 regulator: atc260x: Fix mis=
sing active_discharge_on setting)
Merging spi-fixes/for-linus (35d516bdcd92 spi: mxic: Fix an error handling =
path in mxic_spi_probe())
Merging pci-current/for-linus (312310928417 Linux 5.18-rc1)
Merging driver-core.current/driver-core-linus (cdb4f26a63c3 kobject: kobj_t=
ype: remove default_attrs)
Merging tty.current/tty-linus (dbf3f0932214 tty: serial: mpc52xx_uart: make=
 rx/tx hooks return unsigned, part II.)
Merging usb.current/usb-linus (312310928417 Linux 5.18-rc1)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (7e57714cd0ad Linux 5.17-rc6)
Merging usb-chipidea-fixes/for-usb-fixes (f130d08a8d79 usb: chipidea: ci_hd=
rc_imx: Also search for 'phys' phandle)
CONFLICT (content): Merge conflict in drivers/usb/chipidea/ci_hdrc_imx.c
Merging phy/fixes (312310928417 Linux 5.18-rc1)
Merging staging.current/staging-linus (20314bacd2f9 staging: r8188eu: Fix P=
PPoE tag insertion on little endian systems)
Merging iio-fixes/fixes-togreg (108e4d4de2b5 iio:proximity:sx9324: Fix hard=
ware gain read/write)
Merging counter-fixes/fixes-togreg (4a14311a3b93 counter: Stop using dev_ge=
t_drvdata() to get the counter device)
Merging char-misc.current/char-misc-linus (94865e2dcb46 habanalabs: Fix tes=
t build failures)
Merging soundwire-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging thunderbolt-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging input-current/for-linus (8b188fba7519 Revert "Input: clear BTN_RIGH=
T/MIDDLE on buttonpads")
Merging crypto-current/master (aa8e73eed7d3 crypto: x86/sm3 - Fixup SLS)
Merging vfio-fixes/for-linus (8704e8934908 vfio/pci: Fix OpRegion read)
Merging kselftest-fixes/fixes (79ee8aa31d51 selftests/harness: Pass variant=
 to teardown)
Merging modules-fixes/modules-linus (dc0ce6cc4b13 lib/test: use after free =
in register_test_dev_kmod())
Merging dmaengine-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (9fe4e0d3cbfe mtd: rawnand: fix ecc parameters =
for mt7622)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (397c08e66130 media: platform: imx-mipi-csis: A=
dd dependency on VIDEO_DEV)
Merging reset-fixes/reset/fixes (03cb66463b55 dt-bindings: reset: Add paren=
t "resets" property as optional)
Merging mips-fixes/mips-fixes (312310928417 Linux 5.18-rc1)
Merging at91-fixes/at91-fixes (26077968f838 dt-bindings: ARM: at91: update =
maintainers entry)
Merging omap-fixes/fixes (8840f5460a23 ARM: dts: Use 32KiHz oscillator on d=
evkit8000)
Merging kvm-fixes/master (34af78c4e616 Merge tag 'iommu-updates-v5.18' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu)
Merging kvms390-fixes/master (0e9ff65f455d KVM: s390: preserve deliverable_=
mask in __airqs_kick_single_vcpu)
Merging hwmon-fixes/hwmon (4fd45cc8568e hwmon: (asus_wmi_sensors) Fix CROSS=
HAIR VI HERO name)
Merging nvdimm-fixes/libnvdimm-fixes (3dd60fb9d95d nvdimm/pmem: stop using =
q_usage_count as external pgmap refcount)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (873863d594c4 Merge branch 'misc-5.18' into =
next-fixes)
Merging vfs-fixes/fixes (9d2231c5d74e lib/iov_iter: initialize "flags" in n=
ew pipe_buffer)
Merging dma-mapping-fixes/for-linus (18a3c5f7abfd Merge tag 'for_linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (f632b296b007 tools/power/x86/intel-speed-s=
elect: fix build failure when using -Wl,--as-needed)
Merging samsung-krzk-fixes/fixes (1a9f338f9cf9 MAINTAINERS: update Krzyszto=
f Kozlowski's email to Linaro)
Merging pinctrl-samsung-fixes/fixes (abb860ac7e3f pinctrl: samsung: statici=
ze fsd_pin_ctrl)
Merging devicetree-fixes/dt/linus (c3b006819426 dt-bindings: Fix 'enum' lis=
ts with duplicate entries)
Merging scsi-fixes/fixes (733ab7e1b5d1 scsi: fnic: Finish scsi_cmnd before =
dropping the spinlock)
Merging drm-fixes/drm-fixes (312310928417 Linux 5.18-rc1)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (312310928417 Linux 5.18-rc1)
Merging mmc-fixes/fixes (46d4820f949a mmc: renesas_sdhi: special 4tap setti=
ngs only apply to HS400)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (e783362eb54c Linux 5.17-rc1)
Merging hyperv-fixes/hyperv-fixes (b6cae15b5710 Drivers: hv: vmbus: Prevent=
 load re-ordering when reading ring buffer)
Merging soc-fsl-fixes/fix (a222fd854139 soc: fsl: qe: Check of ioremap retu=
rn value)
Merging risc-v-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (8bb7eca972ad Linux 5.15)
Merging spdx/spdx-linus (312310928417 Linux 5.18-rc1)
Merging gpio-brgl-fixes/gpio/for-current (5467801f1fcb gpio: Restrict usage=
 of GPIO chip irq members before initialization)
Merging gpio-intel-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging pinctrl-intel-fixes/fixes (6f66db29e241 pinctrl: tigerlake: Revert =
"Add Alder Lake-M ACPI ID")
Merging erofs-fixes/fixes (24331050a3e6 erofs: fix small compressed files i=
nlining)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (02c7efa43627 Documentation: kunit: fix pat=
h to .kunitconfig in start.rst)
Merging ubifs-fixes/fixes (c3c07fc25f37 ubi: fastmap: Return error code if =
memory allocation fails in add_aeb())
Merging memblock-fixes/fixes (c94afc46cae7 memblock: use kfree() to release=
 kmalloced memblock regions)
Merging cel-fixes/for-rc (999397926ab3 nfsd: Clean up nfsd_file_put())
Merging irqchip-fixes/irq/irqchip-fixes (544808f7e21c irqchip/gic, gic-v3: =
Prevent GSI to SGI translations)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (be2d3ecedd99 Merge tag 'perf-tools-for-v5=
.18-2022-04-02' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux)
Merging efi-fixes/urgent (9feaf8b387ee efi: fix return value of __setup han=
dlers)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging drm-misc-fixes/for-linux-next-fixes (13043d1a12c5 Merge drm-misc/dr=
m-misc-next-fixes into drm-misc-fixes)
Merging kbuild/for-next (d5ea4fece450 kbuild: Allow kernel installation pac=
kaging to override pkg-config)
Merging perf/perf/core (be2d3ecedd99 Merge tag 'perf-tools-for-v5.18-2022-0=
4-02' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (4fe87e818ea4 dma-mapping: move pgprot_decrypt=
ed out of dma_pgprot)
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
Merging arm-soc/for-next (6a2f0b2d3b74 dt: amd-seattle: add a description o=
f the CPUs and caches)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (25d96e699628 Merge branch 'v5.19/dt64' into for-n=
ext)
Merging aspeed/for-next (d9540eeaa3d1 Merge branches 'nuvoton-dt-for-v5.18'=
 and 'dt-for-v5.18' into for-next)
Merging at91/at91-next (a845fa592554 Merge branch 'clk-at91' into at91-next)
Merging drivers-memory/for-next (c5057050a59f Merge branch 'mem-ctrl-next' =
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
Merging renesas/next (eee41de7440d Merge branches 'renesas-arm-defconfig-fo=
r-v5.19', 'renesas-arm-dt-for-v5.19', 'renesas-drivers-for-v5.19' and 'rene=
sas-dt-bindings-for-v5.19' into renesas-next)
Merging reset/reset/next (2c0e0fd1b694 reset: ACPI reset support)
Merging rockchip/for-next (f62180385a21 Merge branch 'v5.19-armsoc/soc32' i=
nto for-next)
Merging samsung-krzk/for-next (f6354da78949 Merge branch 'next/soc' into fo=
r-next)
Merging scmi/for-linux-next (6fb69590182d Merge remote-tracking branch 'kor=
g_sudeep/fixes/vexpress' into for-linux-next)
Merging stm32/stm32-next (74fa56279651 ARM: dts: stm32: Switch DWMAC RMII c=
lock to MCO2 on DHCOM)
Merging sunxi/sunxi/for-next (f25c47c67629 Merge branch 'sunxi/dt-for-5.18'=
 into sunxi/for-next)
Merging tee/next (17522923771d Merge branch 'fixes' into next)
Merging tegra/for-next (6d746e1eb2f6 Merge branch for-5.18/arm64/defconfig =
into for-next)
Merging ti/ti-next (183a6f5c6e1e Merge branches 'ti-k3-dts-next' and 'ti-dr=
ivers-soc-next' into ti-next)
Merging xilinx/for-next (3a14f0e61408 arm64: zynqmp: Rename dma to dma-cont=
roller)
Merging clk/clk-next (859c2c7b1d06 Revert "clk: Drop the rate range on clk_=
put()")
Merging clk-imx/for-next (b09c68dc57c9 clk: imx: pll14xx: Support dynamic r=
ates)
Merging clk-renesas/renesas-clk (3733db1f7713 dt-bindings: clock: renesas: =
Document RZ/G2UL SoC)
Merging clk-samsung/for-next (45bd8166a1d8 clk: samsung: Add initial Exynos=
7885 clock driver)
Merging csky/linux-next (312310928417 Linux 5.18-rc1)
Merging m68k/for-next (0d52a01a266b m68k: defconfig: Disable fbdev on Sun3/=
3x)
Merging m68knommu/for-next (312310928417 Linux 5.18-rc1)
Merging microblaze/next (fcc619621df5 microblaze/PCI: Remove pci_phys_mem_a=
ccess_prot() dead code)
Merging mips/mips-next (312310928417 Linux 5.18-rc1)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (862cf8d5fd98 openrisc/boot: Remove unnecessary i=
nitialisation in memcpy().)
Merging parisc-hd/for-next (e34799ccc126 parisc: Change MAX_ADDRESS to beco=
me unsigned long long)
Merging powerpc/next (af41d2866f7d powerpc/64: Fix build failure with allye=
sconfig in book3s_64_entry.S)
Merging soc-fsl/next (1ce93cb102e7 soc: fsl: qe: Check of ioremap return va=
lue)
Merging risc-v/for-next (312310928417 Linux 5.18-rc1)
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
Merging fscache/fscache-next (312310928417 Linux 5.18-rc1)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (9b58921a376a Merge branch 'for-next-next-v5.18-2022=
0404' into for-next-20220404)
Merging ceph/master (f639d9867eea ceph: fix memory leak in ceph_readdir whe=
n note_last_dentry returns error)
Merging cifs/for-next (7cd1cc415dd8 cifs: update internal module number)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (a1108dcd9373 erofs: rename ctime to mtime)
Merging exfat/dev (0c404308d41f exfat: fix referencing wrong parent directo=
ry information after renaming)
Merging ext3/for_next (f06e95c3a4ca Merge fsnotify cleanup from Bang Li.)
Merging ext4/dev (c7cded845fc1 ext4: truncate during setxattr leads to kern=
el panic)
Merging f2fs/dev (519129040766 Merge tag 'for-5.18-tag' of git://git.kernel=
.org/pub/scm/linux/kernel/git/kdave/linux)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (0c4bcfdecb1a fuse: fix pipe buffer lifetime for dire=
ct_io)
Merging gfs2/for-next (ead638654d75 gfs2: Replace list_prepare_entry() with=
 list_entry())
Merging jfs/jfs-next (a53046291020 jfs: prevent NULL deref in diFree)
Merging ksmbd/ksmbd-for-next (edf5f0548fbb ksmbd: replace usage of found wi=
th dedicated list iterator variable)
Merging nfs/linux-next (585ddde606b3 SUNRPC: Ensure we flush any closed soc=
kets before xs_xprt_free())
Merging nfs-anna/linux-next (d19e0183a883 NFS: Do not report writeback erro=
rs in nfs_getattr())
Merging nfsd/for-next (c1dbd5583235 fs/lock: add helper locks_owner_has_blo=
ckers to check for blockers)
Merging ntfs3/master (52e00ea6b26e fs/ntfs3: Update valid size if -EIOCBQUE=
UED)
Merging orangefs/for-next (40a74870b2d1 orangefs: Fix the size of a memory =
allocation in orangefs_bufmap_alloc())
Merging overlayfs/overlayfs-next (94fd19752b28 ovl: don't fail copy up if n=
o fileattr support on upper)
Merging ubifs/next (705757274599 ubifs: rename_whiteout: correct old_dir si=
ze computing)
Merging v9fs/9p-next (22e424feb665 Revert "fs/9p: search open fids first")
Merging xfs/for-next (919edbadebe1 xfs: drop async cache flushes from CIL c=
ommits.)
Merging zonefs/for-next (95b115332a83 zonefs: remove redundant null bio che=
ck)
CONFLICT (content): Merge conflict in fs/zonefs/super.c
Merging iomap/iomap-for-next (ebb7fb1557b1 xfs, iomap: limit individual ioe=
nd chain lengths in writeback)
Merging djw-vfs/vfs-for-next (49df34221804 fs: fix an infinite loop in ioma=
p_fiemap)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (fd78f28f9f50 Merge branch 'work.namei' into for-next)
Merging printk/for-next (c5f75d490fc2 Merge branch 'for-5.18' into for-next)
Merging pci/next (5e8cf6bbbf3d Merge branch 'pci/resource')
Merging pstore/for-next/pstore (8126b1c73108 pstore: Don't use semaphores i=
n always-atomic-context code)
Merging hid/for-next (ceaaa0282c06 Merge branch 'for-5.18/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (5db36559df9b Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (6cbf8b38dfe3 i3c: fix uninitialized variable use in i=
2c setup)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (a5af7ccaf512 hwmon: (aquacomputer_d5next)=
 Add support for Aquacomputer Octo)
Merging jc_docs/docs-next (4407cca0109c docs/zh_CN: Add schedutil Chinese t=
ranslation)
Merging v4l-dvb/master (312310928417 Linux 5.18-rc1)
Merging v4l-dvb-next/master (535f49a9e1f9 media: platform: imx-mipi-csis: A=
dd dependency on VIDEO_DEV)
Merging pm/linux-next (d8a5a5e3123a Merge branch 'acpi-processor' into linu=
x-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (f84ccad5f566 cpufreq: qcom-cpuf=
req-hw: Fix throttle frequency value on EPSS platforms)
Merging cpupower/cpupower (312310928417 Linux 5.18-rc1)
Merging devfreq/devfreq-next (93515220624f PM / devfreq: rk3399_dmc: Avoid =
static (reused) profile)
Merging opp/opp/linux-next (312310928417 Linux 5.18-rc1)
Merging thermal/thermal/linux-next (1379d28e840f thermal: rcar_thermal: Use=
 platform_get_irq_optional() to get the interrupt)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (feae43f8aa88 fs: dlm: print cluster addr if non-cluster n=
ode connects)
Merging rdma/for-next (22cbc6c2681a IB/rdmavt: add missing locks in rvt_ruc=
_loopback)
Merging net-next/master (0b5c21bbc01e net: ensure net_todo_list is processe=
d quickly)
Merging bpf-next/for-next (042152c27c3b bpf, arm64: Sign return address for=
 JITed code)
Merging ipsec-next/master (b58b1f563ab7 xfrm: rework default policy structu=
re)
Merging mlx5-next/mlx5-next (312310928417 Linux 5.18-rc1)
Merging netfilter-next/master (c84d86a0295c Merge branch '100GbE' of git://=
git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue)
Merging ipvs-next/master (c828414ac935 netfilter: nft_compat: suppress comm=
ent match)
Merging bluetooth/master (38a1944deda4 Bluetooth: btusb: Set HCI_QUIRK_BROK=
EN_ENHANCED_SETUP_SYNC_CONN for QCA)
Merging wireless-next/main (e89600ebeeb1 af_vsock: SOCK_SEQPACKET broken bu=
ffer test)
Merging mtd/mtd/next (4c38eded8070 mtd: parsers: bcm47xxpart: print correct=
 offset on read error)
Merging nand/nand/next (f7c48bccf1a0 mtd: rawnand: print offset instead of =
page number for bad blocks)
Merging spi-nor/spi-nor/next (151c6b49d679 mtd: spi-nor: Skip erase logic w=
hen SPI_NOR_NO_ERASE is set)
Merging crypto/master (0e03b8fd2936 crypto: xilinx - Turn SHA into a trista=
te and allow COMPILE_TEST)
Merging drm/drm-next (312310928417 Linux 5.18-rc1)
Merging drm-misc/for-linux-next (21d139a95682 drm: bridge: icn6211: Fix DSI=
-to-DPI PLL configuration)
Applying: fixup for "spi: make remove callback a void function"
Merging amdgpu/drm-next (78174f477081 drm/amd/display: [FW Promotion] Relea=
se 0.0.111.0)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
Applying: fix up for "drm/ttm: rework bulk move handling v5"
Merging drm-intel/for-linux-next (92bc908af5cd drm/i915/dsb: modified to dr=
m_info in dsb_prepare())
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_bw=
.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_di=
splay.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_pci.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_device_inf=
o.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_pm.c
Merging drm-tegra/drm/tegra/for-next (b53c24f69199 drm/tegra: Support YVYU,=
 VYUY and YU24 formats)
Merging drm-msm/msm-next (05241de1f69e dt-bindings: display/msm: another fi=
x for the dpu-qcm2290 example)
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (cdd156955f94 drm/etnaviv: consider completed =
fence seqno in hang check)
Merging fbdev/for-next (7e4920bf59cb video: fbdev: omap: Make it CCF clk AP=
I compatible)
Merging regmap/for-next (bd941dfaae35 regmap: Constify static regmap_bus st=
ructs)
Merging sound/for-next (b2405aa948b9 firewire: add kernel API to access pac=
ket structure in request structure for AR context)
Merging sound-asoc/for-next (b66751b6e359 Merge remote-tracking branch 'aso=
c/for-5.19' into asoc-next)
Merging modules/modules-next (eeaec7801c42 powerpc: Select ARCH_WANTS_MODUL=
ES_DATA_IN_VMALLOC on book3s/32 and 8xx)
Merging input/next (a949087c2285 Input: adi - remove redundant variable z)
Merging block/for-next (ff0f3f831752 Merge branch 'for-5.19/io_uring-xattr'=
 into for-next)
Merging device-mapper/for-next (7f790f4da003 dm: remove bio polling debug c=
hecks)
Merging libata/for-next (eaeb9fb2739b ata: pata_mpc52xx: Prepare cleanup of=
 powerpc's asm/prom.h)
Merging pcmcia/pcmcia-next (3928cf08334e pcmcia: db1xxx_ss: restrict to MIP=
S_DB1XXX boards)
Merging mmc/next (f95f8307f551 mmc: renesas_sdhi: R-Car V3M also has no HS4=
00)
Merging mfd/for-mfd-next (d99460ed5cdc dt-bindings: mfd: syscon: Add microc=
hip,lan966x-cpu-syscon compatible)
Merging backlight/for-backlight-next (023a8830a628 backlight: backlight: Sl=
ighly simplify devm_of_find_backlight())
Merging battery/for-next (c22fca40522e power: ab8500_chargalg: Use CLOCK_MO=
NOTONIC)
Merging regulator/for-next (025096148086 Merge remote-tracking branch 'regu=
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
Merging selinux/next (81200b0265b1 selinux: checkreqprot is deprecated, add=
 some ssleep() discomfort)
Merging smack/next (ba6b652bd863 smack: Remove redundant assignments)
Merging tomoyo/master (99499a2b0ff0 loop: yet another approach to fix the l=
oop lock order inversions)
Merging tpmdd/next (8467b0ed6ce3 Merge tag 'for-5.18/drivers-2022-04-01' of=
 git://git.kernel.dk/linux-block)
Merging watchdog/master (826270373f17 Watchdog: sp5100_tco: Enable Family 1=
7h+ CPUs)
Merging iommu/next (e17c6debd4b2 Merge branches 'arm/mediatek', 'arm/msm', =
'arm/renesas', 'arm/rockchip', 'arm/smmu', 'x86/vt-d' and 'x86/amd' into ne=
xt)
Merging audit/next (312310928417 Linux 5.18-rc1)
Merging devicetree/for-next (a1a2b7125e10 of/platform: Drop static setup of=
 IRQ resource from DT core)
Merging mailbox/mailbox-for-next (1b0d0f7c12d5 dt-bindings: mailbox: add de=
finition for mt8186)
Merging spi/for-next (d6401954317a Merge remote-tracking branch 'spi/for-5.=
19' into spi-next)
Merging tip/master (176002d0f443 Merge sched/core into tip/master)
Merging clockevents/timers/drivers/next (49c14f94ccfe clocksource/drivers/t=
imer-of: check return value of of_iomap in timer_of_base_init())
Merging edac/edac-for-next (b2fa90ef6255 powerpc/85xx: Remove fsl,85... bin=
dings)
Merging irqchip/irq/irqchip-next (de26a7424331 Merge branch irq/qcom-mpm in=
to irq/irqchip-next)
Merging ftrace/for-next (c87857e21486 Merge branch 'trace/for-next-rtla' in=
to trace/for-next)
Merging rcu/rcu/next (b77b2981bb22 rcu-tasks: Handle sparse cpu_possible_ma=
sk)
CONFLICT (content): Merge conflict in include/linux/sched.h
CONFLICT (content): Merge conflict in kernel/sched/core.c
$ git reset --hard
Merging kvm/next (945024d764a1 KVM: x86: optimize PKU branching in kvm_load=
_{guest|host}_xsave_state)
CONFLICT (content): Merge conflict in arch/x86/kernel/kvm.c
Merging kvm-arm/next (21ea45784275 KVM: arm64: fix typos in comments)
Merging kvms390/next (4aa5ac75bf79 KVM: s390: Fix lockdep issue in vm memop)
Merging xen-tip/linux-next (de2ae403b4c0 xen: fix is_xen_pmu())
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (bc35f7ef9628 workqueue: Convert the type of po=
ol->nr_running to int)
Merging drivers-x86/for-next (b49f72e7f96d platform/x86: think-lmi: Certifi=
cate authentication support)
Merging chrome-platform/for-next (312310928417 Linux 5.18-rc1)
Merging hsi/for-next (e783362eb54c Linux 5.17-rc1)
Merging leds/for-next (312310928417 Linux 5.18-rc1)
Merging ipmi/for-next (ae085d7f9365 mm: kfence: fix missing objcg housekeep=
ing for SLAB)
Merging driver-core/driver-core-next (312310928417 Linux 5.18-rc1)
Merging usb/usb-next (312310928417 Linux 5.18-rc1)
Merging thunderbolt/next (03941ed91c72 thunderbolt: Replace usage of found =
with dedicated list iterator variable)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (4ac56b1f1ef8 USB: serial: usb_wwan: remove red=
undant assignment to variable i)
Merging usb-chipidea-next/for-usb-next (78665f57c3fa usb: chipidea: udc: ma=
ke controller hardware endpoint primed)
Merging tty/tty-next (312310928417 Linux 5.18-rc1)
Merging char-misc/char-misc-next (312310928417 Linux 5.18-rc1)
Merging coresight/next (286f950545e0 coresight: Drop unused 'none' enum val=
ue for each component)
Merging fpga/for-next (21f0a239ecab fpga: dfl: pci: Remove usage of the dep=
recated "pci-dma-compat.h" API)
Merging icc/icc-next (52c85167e413 Merge branch 'icc-msm8939' into icc-next)
Merging iio/togreg (b28bc9ebbe23 iio: adc: ti-ads1015: Switch to read_avail)
Merging phy-next/next (312310928417 Linux 5.18-rc1)
Merging soundwire/next (60657fb9b19d dt-bindings: soundwire: qcom: Add bind=
ings for audio clock reset control property)
Merging extcon/extcon-next (4e63832f5daf extcon: sm5502: Add support for SM=
5703)
CONFLICT (content): Merge conflict in drivers/power/supply/max8997_charger.c
Merging gnss/gnss-next (26291c54e111 Linux 5.17-rc2)
Merging vfio/next (f621eb13facb vfio-pci: Provide reviewers and acceptance =
criteria for variant drivers)
Merging staging/staging-next (e54e00a28837 staging: r8188eu: ps_flag is nev=
er set)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (312310928417 Linux 5.18-rc1)
Merging cgroup/for-next (1be9b7206b7d Merge branch 'for-5.18' into for-next)
Merging scsi/for-next (ee03d7a9c533 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (a6b758b0420b scsi: bnx2i: Fix spelling mistake "=
mis-match" -> "mismatch")
Merging vhost/linux-next (1c80cf031e02 vdpa: mlx5: synchronize driver statu=
s with CVQ)
Merging rpmsg/for-next (9ea79a3861c9 Merge branches 'rpmsg-next', 'rproc-ne=
xt' and 'hwspinlock-next' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (43ebbb92e43f gpio: rcar: Add R-Car Gen4 su=
pport)
Merging gpio-intel/for-next (a1ce76e89907 gpio: tps68470: Allow building as=
 module)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (4a6d01495a16 pinctrl: mediatek: common-v1: fix se=
micolon.cocci warnings)
Merging pinctrl-intel/for-next (d25478e1d8f9 pinctrl: icelake: Add Ice Lake=
-N PCH pin controller support)
Merging pinctrl-renesas/renesas-pinctrl (715c9faa2d2d pinctrl: renesas: r8a=
77990: Add drive-strength)
Merging pinctrl-samsung/for-next (abb860ac7e3f pinctrl: samsung: staticize =
fsd_pin_ctrl)
Merging pwm/for-next (ed14d36498c8 pwm: rcar: Simplify multiplication/shift=
 logic)
Merging userns/for-next (9def41809e95 Merge of prlimit-tasklist_lock-for-v5=
.18, per-namespace-ipc-sysctls-for-v5.18, and ptrace-for-v5.18 for testing =
in linux-next)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (312310928417 Linux 5.18-rc1)
Merging livepatching/for-next (0e1b951d6de0 Merge branch 'for-5.18/selftest=
s-fixes' into for-next)
Merging rtc/rtc-next (915593a7a663 rtc: check if __rtc_read_time was succes=
sful)
Merging nvdimm/libnvdimm-for-next (ada8d8d337ee nvdimm/blk: Fix title level)
Merging at24/at24/for-next (312310928417 Linux 5.18-rc1)
Merging ntb/ntb-next (5cf4bc46c2f2 IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (8a3d3ea66f0d selftests/seccomp: Add SKIP =
for failed unshare())
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (f2af60bb7ce2 fsi: Add trace events in initialization path)
Merging slimbus/for-next (0eb1fb16396c slimbus: qcom-ngd-ctrl: Use platform=
_get_irq() to get the interrupt)
Merging nvmem/for-next (bdf79b27260b dt-bindings: nvmem: brcm,nvram: add ba=
sic NVMEM cells)
CONFLICT (content): Merge conflict in MAINTAINERS
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
CONFLICT (content): Merge conflict in security/apparmor/policy_unpack_test.c
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (5d4be19cbe6a bus: mhi: ep: Add uevent support for mod=
ule autoloading)
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
Merging slab/for-next (38e4e58eb858 Merge branch 'slab/for-5.19/stackdepot'=
 into slab/for-next)
Merging random/master (cd9bb5097995 random: check for signals every PAGE_SI=
ZE chunk of /dev/[u]random)
Merging landlock/next (7325fd5614aa Merge Landlock fixes into next)
Merging rust/rust-next (011150424cd9 rust: avoid all GCC plugins, not just =
the randstruct one)
CONFLICT (content): Merge conflict in Makefile
Merging sysctl/sysctl-next (7cde53da38a3 ftrace: move sysctl_ftrace_enabled=
 to ftrace.c)
Merging folio/for-next (ae86f150c907 btrfs: Remove a use of PAGE_SIZE in bt=
rfs_invalidate_folio())
CONFLICT (content): Merge conflict in mm/readahead.c
Merging execve/for-next/execve (dd664099002d binfmt_elf: Don't write past e=
nd of notes for regset gap)
Merging kspp/for-next/kspp (f4fe9fc39c71 Merge branch 'for-next/hardening' =
into for-next/kspp)
Merging kspp-gustavo/for-next/kspp (452d059ea2b6 drm/amd/display: Fix Wstri=
ngop-overflow warnings in dc_link_dp.c)
Merging akpm-current/current (fd61e89eda93 ipc/mqueue: use get_tree_nodev()=
 in mqueue_get_tree())
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (24d2a2cd9d63 kselftest/vm: override TARGETS from argum=
ents)

--Sig_/OuWB9QmD4bJHwu3E2tUc_D4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJNJQEACgkQAVBC80lX
0GzSrQf/a7sSMNryvgJVPlyH1n0RMHrHvEoLg4I0W7H/Ame156QKl86CR7+LYCAp
haR9iZmDqDRGvIig5IIP84U5DzKcWmB8mO1eK/tP9fnm8rh5IiaRDYMOH2elvzlC
2OBIZ+yr3AqSuihIpH6rHQkcDhs7Vq/V5aV1qGTFFZX8bK2cGyqOHFshWbfZMGsm
UuP1JGBMs66NxlLmOUcwbcfilHr5Ts5oOtVgQZq8LJqT0NGepXHe8xgln8JGmqsa
XzSr8laszhwQzanQaordgr6CXp+1fx/wO9bFjOSEQsFSts/bLGHDr3e3giuf5kYX
Vxyrx4/ZzjwXfmWOEZmyLgpmXrWwiA==
=kV13
-----END PGP SIGNATURE-----

--Sig_/OuWB9QmD4bJHwu3E2tUc_D4--
