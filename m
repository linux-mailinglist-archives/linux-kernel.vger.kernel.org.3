Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FBF4B832C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiBPInK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:43:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBPInJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:43:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8363916EAB1;
        Wed, 16 Feb 2022 00:42:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzBL60Chjz4xcY;
        Wed, 16 Feb 2022 19:42:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645000974;
        bh=kSDguMKgP7u69pofwb7TEwfMbSpeYSb0qccbIGWsb1s=;
        h=Date:From:To:Cc:Subject:From;
        b=YhYtXXbJv+XsQ80yjWxWjeaStLOh6GngXnDX3udqeKg0ORBlXPxp25ejdJPsDHHY1
         uX6RgQAUlhGBM/Fm0ojiNQnWPO0PCcireslIU4qEjzhC2wFclPRn/rB2aekA8W6a0X
         MzZfL4ZmC7zD163m2tgPpCnSfLgyqqQbZD3/XVuSWMmmAkjJoYT+0zgwVCnR9fw3t8
         2HvZq7hvuesUj5k802XfYRx7nqwLuXC26Navk7EJkXwowW/+NfczfGd10OHL+mztdR
         Z4AFWmWLN+tXevrS2uHmtviWjTs6f1GkvtteQOPyW+kcGMNXlcRtT3wWS/m90U3F/U
         P4WZCdS36nscA==
Date:   Wed, 16 Feb 2022 19:42:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 16
Message-ID: <20220216194253.21614057@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//Syxf+RbvnhwachUzD=IFmq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//Syxf+RbvnhwachUzD=IFmq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

News: there will be no linux-next releases from Friday Feb 18 until
Friday Feb 25 inclusive.

Changes since 20220215:

The amdgpu tree still had its build failure so I used the version from
next-20220214.

The drm-intel tree still had its build failure so I used the version from
next-20220214.

The fbdev tree gained a build failure so I used the version from
next-20220215.

The spi tree gained a build failure for whihc I reverted a commit.

The folio tree lost its build failure.

The akpm-current tree gained conflicts against the tip and folio trees.
It also gained a boot time warning for which I applied a patch.

Non-merge commits (relative to Linus' tree): 5543
 6256 files changed, 294543 insertions(+), 143914 deletions(-)

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
Merging origin/master (c5d9ae265b10 Merge tag 'for-linus' of git://git.kern=
el.org/pub/scm/virt/kvm/kvm)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (754e0b0e3560 Linux 5.17-rc4)
Merging arc-current/for-curr (f982d9b7c628 arc: remove set_fs())
Merging arm-current/fixes (9f80ccda53b9 ARM: 9180/1: Thumb2: align ALT_UP()=
 sections in modules sufficiently)
Merging arm64-fixes/for-next/fixes (4f6de676d94e arm64: Correct wrong label=
 in macro __init_el2_gicv3)
Merging arm-soc-fixes/arm/fixes (5e5eddd94c89 Revert "arm64: dts: imx8mn-ve=
nice-gw7902: disable gpu")
Merging drivers-memory-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging tee-fixes/fixes (7e3c6eb44c91 Merge tags 'optee-fixes-for-v5.17' an=
d 'optee-fix-for-v5.17' into fixes)
Merging m68k-current/for-linus (1a0ae068bf6b m68k: defconfig: Update defcon=
figs for v5.16-rc1)
Merging powerpc-fixes/fixes (9bb162fa26ed powerpc/603: Fix boot failure wit=
h DEBUG_PAGEALLOC and KFENCE)
Merging s390-fixes/fixes (dd9cb842fa9d s390/cio: verify the driver availabi=
lity for path_event call)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (8d2b1a1ec9f5 CDC-NCM: avoid overflow in sanity checking)
Merging bpf/master (61d06f01f971 selftests: bpf: Check bpf_msg_push_data re=
turn value)
Merging ipsec/master (7c76ecd9c99b xfrm: enforce validity of offload input =
flags)
Merging netfilter/master (59085208e4a2 net: mscc: ocelot: fix all IP traffi=
c getting trapped to CPU with PTP over IP)
Merging ipvs/master (59085208e4a2 net: mscc: ocelot: fix all IP traffic get=
ting trapped to CPU with PTP over IP)
Merging wireless/main (bf8e59fd315f atl1c: fix tx timeout after link flap o=
n Mikrotik 10/25G NIC)
Merging rdma-fixes/for-rc (dfd42facf1e4 Linux 5.17-rc3)
Merging sound-current/for-linus (5948342a526f Merge tag 'asoc-fix-v5.17-rc4=
' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for=
-linus)
Merging sound-asoc-fixes/for-linus (a887f9c7a4d3 ASoC: wm_adsp: Correct con=
trol read size when parsing compressed buffer)
Merging regmap-fixes/for-linus (b56a7cbf40c8 regmap: debugfs: Fix indentati=
on)
Merging regulator-fixes/for-linus (a472cca485bb Merge remote-tracking branc=
h 'regulator/for-5.16' into regulator-linus)
Merging spi-fixes/for-linus (9fdb6d8d4658 Merge remote-tracking branch 'spi=
/for-5.16' into spi-linus)
Merging pci-current/for-linus (c49ae619905e PCI: mvebu: Fix device enumerat=
ion regression)
Merging driver-core.current/driver-core-linus (e783362eb54c Linux 5.17-rc1)
Merging tty.current/tty-linus (754e0b0e3560 Linux 5.17-rc4)
Merging usb.current/usb-linus (243a1dd7ba48 xhci: Prevent futile URB re-sub=
missions due to incorrect return value.)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (6ca0c6283340 USB: serial: cp210x: add C=
PI Bulk Coin Recycler id)
Merging usb-chipidea-fixes/for-usb-fixes (f130d08a8d79 usb: chipidea: ci_hd=
rc_imx: Also search for 'phys' phandle)
CONFLICT (content): Merge conflict in drivers/usb/chipidea/ci_hdrc_imx.c
Merging phy/fixes (9a8406ba1a9a phy: dphy: Correct clk_pre parameter)
Merging staging.current/staging-linus (b6821b0d9b56 staging: fbtft: fb_st77=
89v: reset display before initialization)
Merging iio-fixes/fixes-togreg (ea85bf906466 iio: imu: st_lsm6dsx: wait for=
 settling time in st_lsm6dsx_read_oneshot)
Merging char-misc.current/char-misc-linus (754e0b0e3560 Linux 5.17-rc4)
Merging soundwire-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging thunderbolt-fixes/fixes (754e0b0e3560 Linux 5.17-rc4)
Merging input-current/for-linus (762f99f4f3cb Merge branch 'next' into for-=
linus)
Merging crypto-current/master (c6ce9c5831ca crypto: api - Move cryptomgr so=
ft dependency into algapi)
Merging vfio-fixes/for-linus (8704e8934908 vfio/pci: Fix OpRegion read)
Merging kselftest-fixes/fixes (6fec1ab67f8d selftests/ftrace: Do not trace =
do_softirq because of PREEMPT_RT)
Merging modules-fixes/modules-linus (2a987e65025e Merge tag 'perf-tools-fix=
es-for-v5.16-2021-12-07' of git://git.kernel.org/pub/scm/linux/kernel/git/a=
cme/linux)
Merging dmaengine-fixes/fixes (455896c53d5b dmaengine: shdma: Fix runtime P=
M imbalance on error)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (36415a796471 mtd: rawnand: brcmnand: Fixed inc=
orrect sub-page ECC status)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (d40f0b133b44 media: meson-ir-tx: remove incorr=
ect doc comment)
Merging reset-fixes/reset/fixes (92c959bae2e5 reset: renesas: Fix Runtime P=
M usage)
Merging mips-fixes/mips-fixes (d9565bf40da2 MIPS: DTS: CI20: fix how ddc po=
wer is enabled)
Merging at91-fixes/at91-fixes (26077968f838 dt-bindings: ARM: at91: update =
maintainers entry)
Merging omap-fixes/fixes (80d680fdccba ARM: dts: omap3430-sdp: Fix NAND dev=
ice node)
Merging kvm-fixes/master (710c47651431 KVM: x86/pmu: Use AMD64_RAW_EVENT_MA=
SK for PERF_TYPE_RAW)
Merging kvms390-fixes/master (0e9ff65f455d KVM: s390: preserve deliverable_=
mask in __airqs_kick_single_vcpu)
Merging hwmon-fixes/hwmon (bb9bb9c75482 hwmon: (ntc_thermistor) Underscore =
Samsung thermistor)
Merging nvdimm-fixes/libnvdimm-fixes (3dd60fb9d95d nvdimm/pmem: stop using =
q_usage_count as external pgmap refcount)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (1af5bc8a7fbe Merge branch 'misc-5.17' into =
next-fixes)
Merging vfs-fixes/fixes (25f54d08f12f autofs: fix wait name hash calculatio=
n in autofs_wait())
Merging dma-mapping-fixes/for-linus (18a3c5f7abfd Merge tag 'for_linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (e3d13da7f77d platform/x86: asus-wmi: Fix r=
egression when probing for fan curve control)
Merging samsung-krzk-fixes/fixes (442b0c08db7e soc: samsung: Fix typo in CO=
NFIG_EXYNOS_USI description)
Merging pinctrl-samsung-fixes/fixes (e783362eb54c Linux 5.17-rc1)
Merging devicetree-fixes/dt/linus (fa4300f060e5 of: unittest: update text o=
f expected warnings)
Merging scsi-fixes/fixes (10af11564617 scsi: ufs: core: Fix divide by zero =
in ufshcd_map_queues())
Merging drm-fixes/drm-fixes (754e0b0e3560 Linux 5.17-rc4)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (26ace8793aae drm/i915/fbc: Fi=
x the plane end Y offset check)
Merging mmc-fixes/fixes (54309fde1a35 mmc: block: fix read single on recove=
ry logic)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (e783362eb54c Linux 5.17-rc1)
Merging hyperv-fixes/hyperv-fixes (ffc58bc4af93 Drivers: hv: utils: Make us=
e of the helper macro LIST_HEAD())
Merging soc-fsl-fixes/fix (8120bd469f55 soc: fsl: dpaa2-console: free buffe=
r before returning from dpaa2_console_read)
Merging risc-v-fixes/fixes (5feef64f4c67 RISC-V: Fix IPI/RFENCE hmask on no=
n-monotonic hartid ordering)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (8bb7eca972ad Linux 5.15)
Merging spdx/spdx-linus (e783362eb54c Linux 5.17-rc1)
Merging gpio-brgl-fixes/gpio/for-current (c162ca0bcbfb gpio: sim: fix hogs =
with custom chip labels)
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
Merging memblock-fixes/fixes (d7f55471db27 memblock: fix memblock_phys_allo=
c() section mismatch error)
Merging cel-fixes/for-rc (c306d737691e NFSD: Deprecate NFS_OFFSET_MAX)
Merging irqchip-fixes/irq/irqchip-fixes (1d4df649cbb4 irqchip/sifive-plic: =
Add missing thead,c900-plic match string)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (dfd42facf1e4 Linux 5.17-rc3)
Merging efi-fixes/urgent (f5390cd0b43c efi: runtime: avoid EFIv2 runtime se=
rvices on Apple x86 machines)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging drm-misc-fixes/for-linux-next-fixes (59f39bfa6553 drm/cma-helper: S=
et VM_DONTEXPAND for mmap)
Merging kspp/for-next/kspp (e1558b5e29c6 Merge branch 'for-next/pending-fix=
es' into for-next/kspp)
Merging kspp-gustavo/for-next/kspp (757856e8836b Merge branch 'for-next/ksp=
p-fam0' into for-next/kspp)
Merging kbuild/for-next (5c8166419acf kbuild: replace $(if A,A,B) with $(or=
 A,B))
Merging perf/perf/core (be5764c4e276 perf vendor events: Update TremontX)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (e62c17f0455a MAINTAINERS: update maintainer l=
ist of DMA MAPPING BENCHMARK)
Merging asm-generic/master (733e417518a6 asm-generic/error-injection.h: fix=
 a spelling mistake, and a coding style issue)
Merging arc/for-next (6880fa6c5660 Linux 5.15-rc1)
Merging arm/for-next (ed43eed0a6ac Merge branch 'devel-stable' into for-nex=
t)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
Merging arm64/for-next/core (bb425a759847 arm64: mm: apply __ro_after_init =
to memory_limit)
Merging arm-perf/for-next/perf (602c873eb52e perf: Replace acpi_bus_get_dev=
ice())
Merging arm-soc/for-next (4a64f2d3527a MAINTAINERS: add myself as a maintai=
ner for the sl28cpld)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (2c420d79dae4 arm64: dts: meson-g12-common: add ua=
rt_ao_b pins muxing)
Merging aspeed/for-next (a7e02e92755c Merge branches 'dt-for-v5.17', 'defco=
nfig-for-v5.17' and 'soc-for-v5.17' into for-next)
Merging at91/at91-next (9be3df0e718c Merge branch 'at91-defconfig' into at9=
1-next)
Merging drivers-memory/for-next (b7c3f95f32e0 Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (551c8a926246 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (896f47a2c39c Merge branch 'v5.17-next/dts64' int=
o for-next)
Merging mvebu/for-next (fecc54c7ccfe Merge branch 'mvebu/arm' into mvebu/fo=
r-next)
Merging omap/for-next (61b6b9cfada4 Merge branch 'omap-for-v5.17/fixes-not-=
urgent' into for-next)
Merging qcom/for-next (1b2ab1a30acb Merge branches 'arm64-defconfig-for-5.1=
8', 'arm64-for-5.18', 'clk-for-5.18', 'defconfig-for-5.18', 'drivers-for-5.=
18', 'dts-for-5.18', 'arm64-fixes-for-5.17' and 'dts-fixes-for-5.17' into f=
or-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (65a3b7e58076 Merge branches 'renesas-arm-dt-for-v5.18=
' and 'renesas-drivers-for-v5.18' into renesas-next)
Merging reset/reset/next (89e7a6698fdd reset: uniphier-glue: Use devm_add_a=
ction_or_reset())
Merging rockchip/for-next (82ca450db051 Merge branch 'v5.18-armsoc/dts32' i=
nto for-next)
Merging samsung-krzk/for-next (9f6408ce5dfa Merge branch 'next/dt64' into f=
or-next)
Merging scmi/for-linux-next (77c6e3825c8f Merge branch 'for-next/scmi/updat=
es' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux int=
o for-linux-next)
Merging stm32/stm32-next (a0977e3dbcb4 ARM: dts: stm32: remove timer5 dupli=
cate unit-address on stm32f7 series)
Merging sunxi/sunxi/for-next (d7ab185b353f Merge branch 'sunxi/dt-for-5.18'=
 into sunxi/for-next)
Merging tee/next (eafbff34f15c Merge branch 'amdtee_for_v5.18' into next)
Merging tegra/for-next (33e9d249ce3e Merge branch for-5.18/arm64/dt into fo=
r-next)
Merging ti/ti-next (3be5bf60d055 Merge branch 'ti-k3-dts-next' into ti-next)
Merging xilinx/for-next (3a14f0e61408 arm64: zynqmp: Rename dma to dma-cont=
roller)
Merging clk/clk-next (28c7bbb2a3fc Merge branch 'clk-kunit' into clk-next)
Merging clk-imx/for-next (036a4b4b4dfa clk: imx: Add imx8dxl clk driver)
Merging clk-renesas/renesas-clk (a1bcf50a99dd clk: renesas: rzg2l-cpg: Add =
support for RZ/V2L SoC)
Merging clk-samsung/for-next (45bd8166a1d8 clk: samsung: Add initial Exynos=
7885 clock driver)
Merging csky/linux-next (a0793fdad9a1 csky: fix typo of fpu config macro)
Merging h8300/h8300-next (1ec10274d436 h8300: don't implement set_fs)
Merging m68k/for-next (469d56485c1b m68k: mm: Remove check for VM_IO to fix=
 deferred I/O)
Merging m68knommu/for-next (128542976f8e m68k: m5441x: remove erroneous clo=
ck disable)
Merging microblaze/next (fcc619621df5 microblaze/PCI: Remove pci_phys_mem_a=
ccess_prot() dead code)
Merging mips/mips-next (c47c7ab9b536 MIPS: Malta: Enable BLK_DEV_INITRD)
Merging nds32/next (07cd7745c6f2 nds32/setup: remove unused memblock_region=
 variable in setup_memory())
CONFLICT (content): Merge conflict in arch/nds32/Kbuild
CONFLICT (content): Merge conflict in arch/nds32/Kconfig
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (f4f4d0fba0c5 openrisc: remove CONFIG_SET_FS)
Merging parisc-hd/for-next (d86e15b40c9c parisc: Always use the self-extrac=
ting kernel feature)
Merging powerpc/next (5a72345e6a78 powerpc: Fix STACKTRACE=3Dn build)
Merging soc-fsl/next (1ce93cb102e7 soc: fsl: qe: Check of ioremap return va=
lue)
Merging risc-v/for-next (67ff2f262619 riscv: mm: init: mark satp_mode __ro_=
after_init)
Merging s390/for-next (00abcf534675 Merge branch 'features' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (db0dd9cee822 um: virtio_uml: Allow probing from dev=
icetree)
Merging xtensa/xtensa-for-next (8a900dc390da xtensa: Remove unused early_re=
ad_config_byte() et al declarations)
Merging pidfd/for-next (d52c14f5f9b3 Merge branch 'pidfd.fd_install' into f=
or-next)
Merging fscrypt/master (cdaa1b1941f6 fscrypt: update documentation for dire=
ct I/O support)
Merging fscache/fscache-next (dd81e1c7d5fb Merge tag 'powerpc-5.17-2' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (7ba32505eb7f Merge branch 'for-next-next-v5.17-2022=
0215' into for-next-20220215)
Merging ceph/master (038b8d1d1ab1 libceph: optionally use bounce buffer on =
recv path in crc mode)
Merging cifs/for-next (5279203f772d cifs: use a different reconnect helper =
for non-cifsd threads)
Merging configfs/for-next (c42dd069be8d configfs: fix a race in configfs_lo=
okup())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (dfd42facf1e4 Linux 5.17-rc3)
Merging exfat/dev (dd81e1c7d5fb Merge tag 'powerpc-5.17-2' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging ext3/for_next (ee12595147ac fanotify: Fix stale file descriptor in =
copy_event_to_user())
Merging ext4/dev (dfd42facf1e4 Linux 5.17-rc3)
Merging f2fs/dev (2df83a0575ff f2fs: avoid an infinite loop in f2fs_sync_di=
rty_inodes)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (073c3ab6ae01 Documentation/filesystem/dax: DAX on vi=
rtiofs)
Merging gfs2/for-next (a4e8145edcfd gfs2: Initialize gh_error in gfs2_glock=
_nq)
Merging jfs/jfs-next (c48a14dca2cb JFS: fix memleak in jfs_mount)
Merging ksmbd/ksmbd-for-next (1a927cda94ac Documentation: ksmbd: update Fea=
ture Status table)
Merging nfs/linux-next (754e0b0e3560 Linux 5.17-rc4)
Merging nfs-anna/linux-next (e0caaf75d443 NFS: LOOKUP_DIRECTORY is also ok =
with symlinks)
Merging nfsd/for-next (9bc6a67e9f0c fs/lock: only call lm_breaker_owns_leas=
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
Merging printk/for-next (cfab610f0005 Merge branch 'for-5.18' into for-next)
Merging pci/next (e783362eb54c Linux 5.17-rc1)
Merging pstore/for-next/pstore (a5d05b07961a pstore/ftrace: Allow immediate=
 recording)
Merging hid/for-next (cc64431a9607 Merge branch 'for-5.17/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (75560f01a8af Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (13462ba1815d i3c: master: dw: check return of dw_i3c_=
master_get_free_pos())
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (cf7ff6f04130 hwmon: (asus-ec-sensors) add=
 CPU core voltage)
Merging jc_docs/docs-next (6b22ce002f75 docs: Makefile: Add -no-shell-escap=
e option to LATEXOPTS)
Merging v4l-dvb/master (68a99f6a0ebf media: lirc: report ir receiver overfl=
ow)
Merging v4l-dvb-next/master (127efdbc51fe media: atomisp: fix dummy_ptr che=
ck to avoid duplicate active_bo)
Merging pm/linux-next (be8b582111d6 Merge branch 'acpi-tables-fixes' into l=
inux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (ec1c7ad47664 cpufreq: CPPC: Fix=
 performance/frequency conversion)
Merging cpupower/cpupower (101025ff8e47 tools/power/cpupower/{ToDo =3D> TOD=
O}: Rename the todo file)
Merging devfreq/devfreq-next (26291c54e111 Linux 5.17-rc2)
Merging opp/opp/linux-next (021dbecabc93 opp: Expose of-node's name in debu=
gfs)
Merging thermal/thermal/linux-next (8ee1c0f6526c thermal/drivers/rz2gl: Add=
 error check for reset_control_deassert())
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (feae43f8aa88 fs: dlm: print cluster addr if non-cluster n=
ode connects)
Merging rdma/for-next (2f1b2820b546 Merge branch 'irdma_dscp' into rdma.git=
 for-next)
Merging net-next/master (2c955856da4f net: dm9051: Fix spelling mistake "er=
or" -> "error")
Merging bpf-next/for-next (8cbf062a250e bpf: Reject kfunc calls that overfl=
ow insn->imm)
Merging ipsec-next/master (2ecda181682e xfrm: delete duplicated functions t=
hat calls same xfrm_api_check())
Merging mlx5-next/mlx5-next (cac3231cc684 mlx5: remove usused static inline=
s)
Merging netfilter-next/master (c828414ac935 netfilter: nft_compat: suppress=
 comment match)
Merging ipvs-next/master (c828414ac935 netfilter: nft_compat: suppress comm=
ent match)
Merging bluetooth/master (952b6d5f1859 Bluetooth: 6lowpan: No need to clear=
 memory twice)
Merging wireless-next/main (167044af3887 rtw89: handle TX/RX 160M bandwidth)
Merging mtd/mtd/next (ad5e35f58384 mtd: Replace the expert mode symbols wit=
h a single helper)
Merging nand/nand/next (8cba323437a4 mtd: rawnand: protect access to rawnan=
d devices while in suspend)
Merging spi-nor/spi-nor/next (e783362eb54c Linux 5.17-rc1)
Merging crypto/master (a69cb445f7d1 crypto: arm/xor - make vectorized C cod=
e Clang-friendly)
Merging drm/drm-next (b9c7babe2c2e Backmerge tag 'v5.17-rc4' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/torvalds/linux into drm-next)
Merging drm-misc/for-linux-next (d3cbc6e323c9 drm: panel-orientation-quirks=
: Add quirk for the 1Netbook OneXPlayer)
Merging amdgpu/drm-next (076172cdc7ab drm/amdgpu: make cyan skillfish suppo=
rt code more consistent)
$ git reset --hard HEAD^
Merging next-20220214 version of amdgpu
Merging drm-intel/for-linux-next (a6e7a006f5d5 drm/i915: Change bigjoiner s=
tate tracking to use the pipe bitmask)
CONFLICT (content): Merge conflict in drivers/gpu/drm/dp/drm_dp.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_module.c
$ git reset --hard HEAD^
Merging next-20220214 version of drm-intel
CONFLICT (content): Merge conflict in drivers/gpu/drm/dp/drm_dp.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_module.c
[master 85b93eccfd8e] next-20220214/drm-intel
Merging drm-tegra/drm/tegra/for-next (22d7ee32f1fb gpu: host1x: Fix hang on=
 Tegra186+)
Merging drm-msm/msm-next (6aa89ae1fb04 drm/msm/gpu: Cancel idle/boost work =
on suspend)
Merging imx-drm/imx-drm/next (20fbfc81e390 drm/imx: imx-tve: Make use of th=
e helper function devm_platform_ioremap_resource())
Merging etnaviv/etnaviv/next (cdd156955f94 drm/etnaviv: consider completed =
fence seqno in hang check)
Merging fbdev/for-next (61038027aa13 video: fbdev: omapfb: Make use of the =
helper component_compare_dev)
$ git reset --hard HEAD^
Merging next-20220215 version of fbdev
Merging regmap/for-next (2d2329787ba2 regmap: irq: cleanup comments)
Merging sound/for-next (a9f73b06ff91 Merge branch 'for-linus' into for-next)
Merging sound-asoc/for-next (f7d344a2bd5e ASoC: soc-core: skip zero num_dai=
 component in searching dai name)
Merging modules/modules-next (a97ac8cb24a3 module: fix signature check fail=
ures when using in-kernel decompression)
Merging input/next (994673dc6657 Input: mtk-pmic-keys - add support for MT6=
358)
CONFLICT (content): Merge conflict in drivers/input/misc/axp20x-pek.c
Merging block/for-next (a102cd383c4a Merge branch 'for-5.18/drivers' into f=
or-next)
CONFLICT (content): Merge conflict in fs/iomap/direct-io.c
Merging device-mapper/for-next (213f63071f1d dm: fix double accounting of f=
lush with data)
Merging libata/for-next (d71c02b0caef pata_mpc52xx: use GFP_KERNEL)
Merging pcmcia/pcmcia-next (3928cf08334e pcmcia: db1xxx_ss: restrict to MIP=
S_DB1XXX boards)
Merging mmc/next (aa622e2b7734 Merge branch 'fixes' into next)
Merging mfd/for-mfd-next (9cb74781a436 mfd: intel_soc_pmic_crc: Set main IR=
Q domain bus token to DOMAIN_BUS_NEXUS)
Merging backlight/for-backlight-next (ec961cf32411 backlight: qcom-wled: Re=
spect enabled-strings in set_brightness)
Merging battery/for-next (5ac121b81b40 power: supply: axp288-charger: Set V=
hold to 4.4V)
Merging regulator/for-next (a94e5cd8457f regulator: tps62864: Fix bindings =
for SW property)
Merging security/next-testing (047843bdb316 Merge branch 'landlock_lsm_v34'=
 into next-testing)
Merging apparmor/apparmor-next (13db6c2acdcd apparmor: fix aa_label_asxprin=
t return check)
Merging integrity/next-integrity (8c54135e2e6d ima: define ima_max_digest_d=
ata struct without a flexible array variable)
Merging keys/keys-next (2d743660786e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (3eb8eaf2ca3e security: implement sctp_assoc_establish=
ed hook in selinux)
Merging smack/next (e783362eb54c Linux 5.17-rc1)
Merging tomoyo/master (f702e1107601 tomoyo: use hwight16() in tomoyo_domain=
_quota_is_ok())
Merging tpmdd/next (a33f5c380c4b Merge tag 'xfs-5.17-merge-3' of git://git.=
kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging watchdog/master (d567f5db412e Merge tag 'regulator-fix-v5.17-rc4' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator)
Merging iommu/next (a9b491f6d6de Merge branches 'arm/msm', 'arm/renesas', '=
arm/rockchip', 'iommu/fixes', 'x86/vt-d' and 'core' into next)
Merging audit/next (e783362eb54c Linux 5.17-rc1)
Merging devicetree/for-next (49364138080e dt-bindings: timer: armv7m-systic=
k: convert to dtschema)
Merging mailbox/mailbox-for-next (869b6ca39c08 dt-bindings: mailbox: Add mo=
re protocol and client ID)
Merging spi/for-next (db91535d7704 spi: amd: Add support for new controller=
 version)
CONFLICT (content): Merge conflict in drivers/hwmon/adt7310.c
Applying: fix up for "spi: make remove callback a void function"
Merging tip/auto-latest (0ef7c79e43d0 Merge x86/pasid into tip/master)
Merging clockevents/timers/drivers/next (e547ffe9e6f4 clocksource/drivers/i=
mx-tpm: Update name of clkevt)
Merging edac/edac-for-next (9e32472d8b3f Merge branch 'edac-urgent' into ed=
ac-for-next)
Merging irqchip/irq/irqchip-next (86c12c738651 Merge branch irq/print_chip =
into irq/irqchip-next)
Merging ftrace/for-next (6b9b6413700e ftrace: Fix assuming build time sort =
works for s390)
Merging rcu/rcu/next (fbc1ed420b65 lib/irq_poll: Declare IRQ_POLL softirq v=
ector as ksoftirqd-parking safe)
Merging kvm/next (db6e7adf8de9 KVM: SVM: Rename AVIC helpers to use "avic" =
prefix instead of "svm")
Merging kvm-arm/next (00e6dae00e3d Merge branch kvm-arm64/pmu-bl into kvmar=
m-master/next)
Merging kvms390/next (08ee38f54935 KVM: s390: pv: make use of ultravisor AI=
V support)
Merging xen-tip/linux-next (f66edf684edc xen/pci: Make use of the helper ma=
cro LIST_HEAD())
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (bc35f7ef9628 workqueue: Convert the type of po=
ol->nr_running to int)
Merging drivers-x86/for-next (ae707d0eb707 platform/x86: intel_cht_int33fe:=
 Move to intel directory)
Merging chrome-platform/for-next (ffebd9053272 platform/chrome: cros_ec_typ=
ec: Check for EC device)
Merging hsi/for-next (e783362eb54c Linux 5.17-rc1)
Merging leds/for-next (cf642faef74f leds: lm3692x: Return 0 from remove cal=
lback)
Merging ipmi/for-next (d134ad2574a1 ipmi: ssif: replace strlcpy with strscp=
y)
Merging driver-core/driver-core-next (27446562a1d9 platform: use dev_err_pr=
obe() in platform_get_irq_byname())
CONFLICT (content): Merge conflict in drivers/power/supply/ab8500_chargalg.c
Merging usb/usb-next (4378e427f705 usbip: vudc: Make use of the helper macr=
o LIST_HEAD())
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/qcom/ipq6018.dtsi
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/xilinx/zynqmp.dtsi
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (26291c54e111 Linux 5.17-rc2)
Merging usb-chipidea-next/for-usb-next (78665f57c3fa usb: chipidea: udc: ma=
ke controller hardware endpoint primed)
Merging tty/tty-next (802d00bd774b Merge 5.17-rc4 into tty-next)
Merging char-misc/char-misc-next (e6cb9c167eeb Merge 5.17-rc4 into char-mis=
c-next)
Merging extcon/extcon-next (b26c5f03a645 extcon: Fix some kernel-doc commen=
ts)
Merging gnss/gnss-next (26291c54e111 Linux 5.17-rc2)
Merging phy-next/next (1e805d190ba5 Merge tag 'phy-fixes-5.17' into next)
CONFLICT (modify/delete): Documentation/devicetree/bindings/phy/qcom,usb-hs=
-phy.txt deleted in phy-next/next and modified in HEAD.  Version HEAD of Do=
cumentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt left in tree.
$ git rm -f Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
Applying: merge fix for "dt-bindings: phy: qcom,usb-hs-phy: add MSM8226 com=
patible"
Merging soundwire/next (63fadaa2c719 soundwire: stream: make enable/disable=
/deprepare idempotent)
Merging thunderbolt/next (7f7b571becf3 thunderbolt: Replace acpi_bus_get_de=
vice())
Merging vfio/next (2bed2ced40c9 vfio/iommu_type1: replace kfree with kvfree)
Merging staging/staging-next (1e7f32f77608 Merge 5.17-rc4 into staging-test=
ing)
CONFLICT (content): Merge conflict in drivers/staging/fbtft/fbtft.h
Merging iio/togreg (342c6c5e2260 iio: adc: cpcap-adc: remove redundant assi=
gnment to variable cal_data_diff)
CONFLICT (content): Merge conflict in .mailmap
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging icc/icc-next (2ccd1d8a2f5d Merge branch 'icc-msm8939' into icc-next)
Merging dmaengine/next (ea7c8f598c32 dmaengine: idxd: restore traffic class=
 defaults after wq reset)
Merging cgroup/for-next (ad9bff39fb84 Merge branch 'for-5.17-fixes' into fo=
r-next)
Merging scsi/for-next (1e0a20264859 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (ac2beb4e3bd7 Merge branch '5.17/scsi-fixes' into=
 5.18/scsi-staging)
CONFLICT (content): Merge conflict in drivers/scsi/pm8001/pm8001_hwi.c
CONFLICT (content): Merge conflict in drivers/scsi/pm8001/pm80xx_hwi.c
Merging vhost/linux-next (fae0bd40fab0 virtio_console: break out of buf pol=
l on remove)
Merging rpmsg/for-next (f5d4b6d998d4 Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (4398693a9e24 gpiolib: make struct comments=
 into real kernel docs)
Merging gpio-intel/for-next (a1ce76e89907 gpio: tps68470: Allow building as=
 module)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (f6aca46db617 Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (689e00887740 pinctrl: baytrail: Clear direc=
t_irq_en flag on broken configs)
Merging pinctrl-renesas/renesas-pinctrl (2e08ab0427fe pinctrl: renesas: rzg=
2l: Improve rzg2l_gpio_register())
Merging pinctrl-samsung/for-next (3652dc070bad pinctrl: samsung: improve wa=
ke irq info on console)
Merging pwm/for-next (657e54e54ba5 pwm: pxa: Implement .apply() callback)
Merging userns/for-next (f9d87929d451 ucount:  Make get_ucount a safe get_u=
ser replacement)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (6d468898d774 selftests: futex: set DEFAULT_INSTALL_=
HDR_PATH)
Merging livepatching/for-next (32fdbc45ade0 Merge branch 'for-5.17/kallsyms=
' into for-next)
Merging coresight/next (a4dabc3d30ea coresight: etm4x: Add lock for reading=
 virtual context ID comparator)
Merging rtc/rtc-next (73ce05302007 rtc: pcf2127: fix bug when reading alarm=
 registers)
Merging nvdimm/libnvdimm-for-next (9e05e95ca8da iomap: Fix error handling i=
n iomap_zero_iter())
Merging at24/at24/for-next (e783362eb54c Linux 5.17-rc1)
Merging ntb/ntb-next (afe1c85b354c IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (eed09ad26182 samples/seccomp: Adjust samp=
le to also provide kill option)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (7cc2f34e1f4d fsi: sbefifo: Use interruptible mutex lockin=
g)
Merging slimbus/for-next (e783362eb54c Linux 5.17-rc1)
Merging nvmem/for-next (902ed4903c19 doc: nvmem: Update example)
Merging xarray/main (22f56b8e890d XArray: Include bitmap.h from xarray.h)
Merging hyperv/hyperv-next (4ee524587105 Drivers: hv: Compare cpumasks and =
not their weights in init_vp_index())
Merging auxdisplay/auxdisplay (4daa9ff89ef2 auxdisplay: charlcd: checking f=
or pointer reference before dereferencing)
Merging kgdb/kgdb/for-next (b77dbc86d604 kdb: Adopt scheduler's task classi=
fication)
Merging hmm/hmm (6880fa6c5660 Linux 5.15-rc1)
Merging fpga/for-next (21f0a239ecab fpga: dfl: pci: Remove usage of the dep=
recated "pci-dma-compat.h" API)
Merging kunit/test (e783362eb54c Linux 5.17-rc1)
Merging cfi/cfi/next (baaf965f9430 mtd: hyperbus: rpc-if: fix bug in rpcif_=
hb_remove)
Merging kunit-next/kunit (c2741453478b kunit: cleanup assertion macro inter=
nal variables)
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (7ba21a082d3e bus: mhi: pci_generic: Add mru_default f=
or Quectel EM1xx series)
Merging memblock/for-next (5b3408a4e5ff memblock tests: Add memblock_free t=
ests)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging cxl/next (be185c2988b4 cxl/core: Remove cxld_const_init in cxl_deco=
der_alloc())
Merging folio-iomap/folio-iomap (4d7bd0eb72e5 iomap: Inline __iomap_zero_it=
er into its caller)
Merging zstd/zstd-next (88a309465b3f lib: zstd: clean up double word in com=
ment.)
Merging efi/next (42f4046bc4ba efi: use default_groups in kobj_type)
Merging unicode/for-next (5298d4bfe80f unicode: clean up the Kconfig symbol=
 confusion)
Merging slab/for-next (07f910f9b729 mm: Remove slab from struct page)
Merging random/master (eb1f9cb7627f random: pull add_hwgenerator_randomness=
() declaration into random.h)
Merging landlock/next (a691b9858300 Merge Landlock fixes into next)
Merging rust/rust-next (847245fe812e init/Kconfig: Specify the interpreter =
for rust-is-available.sh)
Merging folio/for-next (c306078715cb selftests/vm/transhuge-stress: Support=
 file-backed PMD folios)
$ git reset --hard HEAD^
Merging next-20220204 version of folio
Applying: Revert "spi: amd: Add support for version AMDI0062"
Merging akpm-current/current (5e48dd54779f ipc/mqueue: use get_tree_nodev()=
 in mqueue_get_tree())
CONFLICT (content): Merge conflict in Documentation/admin-guide/sysctl/kern=
el.rst
CONFLICT (content): Merge conflict in drivers/gpu/drm/drm_cache.c
CONFLICT (content): Merge conflict in lib/Kconfig.debug
CONFLICT (modify/delete): tools/testing/radix-tree/linux/gfp.h deleted in H=
EAD and modified in akpm-current/current.  Version akpm-current/current of =
tools/testing/radix-tree/linux/gfp.h left in tree.
$ git rm -f tools/testing/radix-tree/linux/gfp.h
Applying: fix up for "tools: Move gfp.h and slab.h from radix-tree to lib"
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (2dbbb3c5ea7a Merge branch 'akpm-current/current')
Applying: fix up for "mm: move oom_kill sysctls to their own file"

--Sig_//Syxf+RbvnhwachUzD=IFmq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIMuQ0ACgkQAVBC80lX
0GziVAf8CEJddy5LWcb5Lo6P53p1NOJm1sLnJ1mcs9qiiPnphGVBXETqB/QLK83/
rbViOhCNJ2SJpfhcRnBnqI9KTz3suQJl0eRe89al7WdYuczKxn/vBcZPMGgJLs+N
E4FK3RgkJZGgOdPFZ4L2wMTO9Q8L3y5Zzponyeyb9mvb41HX15eV02GcV9abXJZ2
iVHSzdwpJAqTwCx+yr3fDIp3qcphxRMWTWLaDYTA6S5OhDC3MzY0GyF14bwVbnw2
9E1rjWxRQVI/XVNSZM58gAUMmxgunsJx0jhABPyneVJCbOQRwgOySpYGYACqDAQo
5f1DVFoRtsO4RZ4xzAhEPNdrMgTZAg==
=q8co
-----END PGP SIGNATURE-----

--Sig_//Syxf+RbvnhwachUzD=IFmq--
