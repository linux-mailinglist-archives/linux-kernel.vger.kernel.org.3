Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8FE46737B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379343AbhLCIuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379337AbhLCIug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:50:36 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFC7C06173E;
        Fri,  3 Dec 2021 00:47:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J55zf1Z4Lz4xYy;
        Fri,  3 Dec 2021 19:47:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638521230;
        bh=lpR0sgVnZrBZhvi/baEvDrJmEzZSrAVWNWObjhSrPhc=;
        h=Date:From:To:Cc:Subject:From;
        b=s/WZ7wQzq2xQEw1nQh4D9EoA4SjVR3HygE++mmbJFTZEy3kwllUWV4kYStSXnTPAz
         ueJ9AucdEgHI+/8mVqE56WvqcKmhm2lp9npPbrHeemovCVjszZc/bhateO4xeMONex
         Odf4xC6ATZ1vx4ZW8RJ53DKytPb43UvdOzmiYuL8KBx6/Yj1/nnaW9KAozdUO2gxVV
         FTkB3xcrEksWiJVWJLzLvxfl80y3oA/E2DMghOeXiAmb9N5zJ+E9BgKdofLFrD5Kzn
         TQJmvOkRp7lX05QETgST+yLfgUXH30T0nDt/jvSiZ/uGP5DhnWsYZW58gAidCddnR+
         R6feQhad9saAw==
Date:   Fri, 3 Dec 2021 19:47:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Dec 3
Message-ID: <20211203194709.3bcfb3a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dJq4YmqGORoe6/5ibX5QKrm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dJq4YmqGORoe6/5ibX5QKrm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

News: I will (probably) do no linux-next releases between Dec 9 and Dec
19, inclusive (i.e. that means 3 releases next week and none the week
after).

Changes since 20211202:

New trees: slab, random

The cifs tree gained conflicts against the fscache tree.

The pm tree still had its build failure so I used the version from
next-20211201.

The hid tree gained a build failure so I marked a driver BROKEN.

The bpf-next tree gained build failures so I used the version from
next-20211202.

The amdgpu tree gained a mismerge (due to a duplicated patch) for which
I applied a merge fix patch.

The gpio-brgl tree still had its build failure so I used the version from
next-20211115.

The rust tree gained conflicts against the kbuild tree.

The akpm-current tree gained conflicts against the slab tree.

Non-merge commits (relative to Linus' tree): 4365
 4907 files changed, 194675 insertions(+), 93303 deletions(-)

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
Merging origin/master (a51e3ac43ddb Merge tag 'net-5.16-rc4' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (e851dfae4371 Merge tag 'kgdb-5.16-rc1' of git=
://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux)
Merging arc-current/for-curr (b9cac915c541 ARC: thread_info.h: correct two =
typos in a comment)
Merging arm-current/fixes (418ace9992a7 ARM: 9156/1: drop cc-option fallbac=
ks for architecture selection)
Merging arm64-fixes/for-next/fixes (35b6b28e6998 arm64: ftrace: add missing=
 BTIs)
Merging arm-soc-fixes/arm/fixes (383a44aec91c memory: mtk-smi: Fix a null d=
ereference for the ostd)
Merging drivers-memory-fixes/fixes (8c5ba21c16bd memory: mtk-smi: Fix a nul=
l dereference for the ostd)
Merging tee-fixes/fixes (d58071a8a76d Linux 5.16-rc3)
Merging m68k-current/for-linus (8a3c0a74ae87 m68k: defconfig: Update defcon=
figs for v5.15-rc1)
Merging powerpc-fixes/fixes (3dc709e518b4 powerpc/85xx: Fix oops when CONFI=
G_FSL_PMC=3Dn)
Merging s390-fixes/fixes (3c088b1e82cf s390: update defconfigs)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (a51e3ac43ddb Merge tag 'net-5.16-rc4' of git://git.kern=
el.org/pub/scm/linux/kernel/git/netdev/net)
Merging bpf/master (099f83aa2d06 mips, bpf: Fix reference to non-existing K=
config symbol)
Merging ipsec/master (ec3bb890817e xfrm: fix dflt policy check when there i=
s no policy configured)
Merging netfilter/master (b43c2793f5e9 netfilter: nfnetlink_queue: silence =
bogus compiler warning)
Merging ipvs/master (619ca0d0108a selftests: add arp_ndisc_evict_nocarrier =
to Makefile)
Merging wireless-drivers/master (191587cd1a5f mt76: fix key pointer overwri=
te in mt7921s_write_txwi/mt7663_usb_sdio_write_txwi)
Merging mac80211/master (1eda919126b4 nl80211: reset regdom when reloading =
regdb)
Merging rdma-fixes/for-rc (db6169b5bac1 RDMA/rtrs: Call {get,put}_cpu_ptr t=
o silence a debug kernel warning)
Merging sound-current/for-linus (b6409dd6bdc0 ALSA: ctl: Fix copy of update=
d id with element read/write)
Merging sound-asoc-fixes/for-linus (7dddcb7fe014 Merge remote-tracking bran=
ch 'asoc/for-5.15' into asoc-linus)
Merging regmap-fixes/for-linus (459e1cd0d5ec Merge remote-tracking branch '=
regmap/for-5.15' into regmap-linus)
Merging regulator-fixes/for-linus (6966df483d7b regulator: Update protectio=
n IRQ helper docs)
Merging spi-fixes/for-linus (4095fa088b56 Merge remote-tracking branch 'spi=
/for-5.15' into spi-linus)
Merging pci-current/for-linus (39bd54d43b3f Revert "PCI: aardvark: Fix supp=
ort for PCI_ROM_ADDRESS1 on emulated bridge")
Merging driver-core.current/driver-core-linus (136057256686 Linux 5.16-rc2)
Merging tty.current/tty-linus (bb1201d4b38e serial: 8250_pci: rewrite peric=
om_do_set_divisor())
Merging usb.current/usb-linus (d58071a8a76d Linux 5.16-rc3)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (d58071a8a76d Linux 5.16-rc3)
Merging usb-chipidea-fixes/for-usb-fixes (f130d08a8d79 usb: chipidea: ci_hd=
rc_imx: Also search for 'phys' phandle)
CONFLICT (content): Merge conflict in drivers/usb/chipidea/ci_hdrc_imx.c
Merging phy/fixes (f0ae8685b285 phy: HiSilicon: Fix copy and paste bug in e=
rror handling)
Merging staging.current/staging-linus (d58071a8a76d Linux 5.16-rc3)
Merging iio-fixes/fixes-togreg (784b470728f5 iio: adc: stm32: fix null poin=
ter on defer_probe error)
Merging char-misc.current/char-misc-linus (d58071a8a76d Linux 5.16-rc3)
Merging soundwire-fixes/fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging thunderbolt-fixes/fixes (d58071a8a76d Linux 5.16-rc3)
Merging input-current/for-linus (1d72d9f960cc Input: elantech - fix stack o=
ut of bound access in elantech_change_report_id())
Merging crypto-current/master (beaaaa37c664 crypto: api - Fix boot-up crash=
 when crypto manager is disabled)
Merging vfio-fixes/for-linus (8704e8934908 vfio/pci: Fix OpRegion read)
Merging kselftest-fixes/fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging modules-fixes/modules-linus (0d67e332e6df module: fix clang CFI wit=
h MODULE_UNLOAD=3Dn)
Merging dmaengine-fixes/fixes (fa51b16d0558 dmaengine: idxd: fix calling wq=
 quiesce inside spinlock)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (bed96b1b5b2c mtd: rawnand: fsmc: Fix timing co=
mputation)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (d40f0b133b44 media: meson-ir-tx: remove incorr=
ect doc comment)
Merging reset-fixes/reset/fixes (69125b4b9440 reset: tegra-bpmp: Revert Han=
dle errors in BPMP response)
Merging mips-fixes/mips-fixes (d58071a8a76d Linux 5.16-rc3)
Merging at91-fixes/at91-fixes (dbe68bc9e82b ARM: dts: at91: sama7g5ek: to n=
ot touch slew-rate for SDMMC pins)
Merging omap-fixes/fixes (80d680fdccba ARM: dts: omap3430-sdp: Fix NAND dev=
ice node)
Merging kvm-fixes/master (7cfc5c653b07 KVM: fix avic_set_running for preemp=
table kernels)
Merging kvms390-fixes/master (0e9ff65f455d KVM: s390: preserve deliverable_=
mask in __airqs_kick_single_vcpu)
Merging hwmon-fixes/hwmon (0e4190d762ef hwmon: (sht4x) Fix EREMOTEIO errors)
Merging nvdimm-fixes/libnvdimm-fixes (3dd60fb9d95d nvdimm/pmem: stop using =
q_usage_count as external pgmap refcount)
Merging cxl-fixes/fixes (fae8817ae804 cxl/mem: Fix memory device capacity p=
robing)
Merging btrfs-fixes/next-fixes (0426549c5d7d Merge branch 'misc-5.16' into =
next-fixes)
Merging vfs-fixes/fixes (25f54d08f12f autofs: fix wait name hash calculatio=
n in autofs_wait())
Merging dma-mapping-fixes/for-linus (18a3c5f7abfd Merge tag 'for_linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging i3c-fixes/i3c/fixes (fe07bfda2fb9 Linux 5.12-rc1)
Merging drivers-x86-fixes/fixes (49201b90af81 platform/x86: amd-pmc: Fix s2=
idle failures on certain AMD laptops)
Merging samsung-krzk-fixes/fixes (4f5d06d381ba arm64: dts: exynos: drop sam=
sung,ufs-shareability-reg-offset in ExynosAutov9)
Merging pinctrl-samsung-fixes/fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging devicetree-fixes/dt/linus (913d3a3f8408 dt-bindings: watchdog: sunx=
i: fix error in schema)
Merging scsi-fixes/fixes (7dc9fb47bc9a scsi: ufs: ufs-pci: Add support for =
Intel ADL)
Merging drm-fixes/drm-fixes (52e81b695432 Merge tag 'amd-drm-fixes-5.16-202=
1-12-01' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (72641d8d6040 Revert "drm/i915=
: Implement Wa_1508744258")
Merging mmc-fixes/fixes (7dba402807a8 mmc: renesas_sdhi: initialize variabl=
e properly when tuning)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (136057256686 Linux 5.16-rc2)
Merging hyperv-fixes/hyperv-fixes (1dc2f2b81a6a hv: utils: add PTP_1588_CLO=
CK to Kconfig to fix build)
Merging soc-fsl-fixes/fix (7e5e744183bb soc: fsl: dpio: fix qbman alignment=
 error in the virtualization context)
Merging risc-v-fixes/fixes (298d03c2d7f1 riscv: dts: unmatched: Add gpio ca=
rd detect to mmc-spi-slot)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (8bb7eca972ad Linux 5.15)
Merging spdx/spdx-linus (fa55b7dcdc43 Linux 5.16-rc1)
Merging gpio-brgl-fixes/gpio/for-current (d6912b1251b4 gpio: rockchip: need=
s GENERIC_IRQ_CHIP to fix build errors)
Merging gpio-intel-fixes/fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging pinctrl-intel-fixes/fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging erofs-fixes/fixes (57bbeacdbee7 erofs: fix deadlock when shrink ero=
fs slab)
Merging integrity-fixes/fixes (843385694721 evm: Fix a small race in init_d=
esc())
Merging kunit-fixes/kunit-fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging ubifs-fixes/fixes (78c7d49f55d8 ubifs: journal: Make sure to not di=
rty twice for auth nodes)
Merging memblock-fixes/fixes (b5013d084e03 Merge tag '5.16-rc-part1-smb3-cl=
ient-fixes' of git://git.samba.org/sfrench/cifs-2.6)
Merging cel-fixes/for-rc (8bb7eca972ad Linux 5.15)
Merging irqchip-fixes/irq/irqchip-fixes (c5e0cbe2858d irqchip: nvic: Fix of=
fset for Interrupt Priority Offsets)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (8b98436af2c0 Merge tag 'perf-tools-fixes-=
for-v5.16-2021-11-19' of git://git.kernel.org/pub/scm/linux/kernel/git/acme=
/linux)
Merging efi-fixes/urgent (8f1dd76c9b55 x86/sme: Explicitly map new EFI memm=
ap table as encrypted)
Merging zstd-fixes/zstd-linus (7416cdc9b9c1 lib: zstd: Don't add -O3 to cfl=
ags)
Merging drm-misc-fixes/for-linux-next-fixes (679d94cd7d90 dma-buf: system_h=
eap: Use 'for_each_sgtable_sg' in pages free flow)
Merging kbuild/for-next (373c0a890520 [for -next only] kconfig: generate in=
clude/generated/rustc_cfg)
Merging perf/perf/core (8ab774587903 Merge tag 'trace-v5.16-5' of git://git=
.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace)
Merging compiler-attributes/compiler-attributes (7c00621dcaee compiler_type=
s: mark __compiletime_assert failure as __noreturn)
Merging dma-mapping/for-next (9fbd8dc19aa5 dma-mapping: use 'bitmap_zalloc(=
)' when applicable)
Merging asm-generic/master (7efbbe6e1414 qcom_scm: hide Kconfig symbol)
CONFLICT (content): Merge conflict in arch/riscv/Kconfig
Merging arc/for-next (6880fa6c5660 Linux 5.15-rc1)
Merging arm/for-next (0ce29cae5ba4 Merge branches 'devel-stable', 'misc' an=
d 'fixes' into for-next)
Merging arm64/for-next/core (d58071a8a76d Linux 5.16-rc3)
Merging arm-perf/for-next/perf (e656972b6986 drivers/perf: Improve build te=
st coverage)
Merging arm-soc/for-next (b86314b30dee Merge branch 'arm/fixes' into for-ne=
xt)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (996b0777eaca Merge branch 'v5.17/dt64' into for-n=
ext)
Merging aspeed/for-next (16d6dc8d8030 ARM: dts: aspeed: mtjade: Add uefi pa=
rtition)
Merging at91/at91-next (f3c0366411d6 ARM: dts: at91: sama7g5-ek: use blocks=
 0 and 1 of TCB0 as cs and ce)
Merging drivers-memory/for-next (7dda5cc4dca0 Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (ee4fb9b87b3c Merge branch 'imx/dt64' into for-nex=
t)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (c7f6a2bf61cb Merge branch 'v5.16-next/dts64' int=
o for-next)
Merging mvebu/for-next (04e78a787b74 arm/arm64: dts: Enable 2.5G Ethernet p=
ort on CN9130-CRB)
Merging omap/for-next (92d190433bd8 Merge branch 'omap-for-v5.16/gpmc' into=
 for-next)
Merging qcom/for-next (6ac480d16afc Merge branches 'arm64-for-5.17', 'drive=
rs-for-5.17' and 'dts-for-5.17' into for-next)
Merging raspberrypi/for-next (0b8152b86818 ARM: dts: bcm2711-rpi-4-b: Add g=
pio offsets to line name array)
Merging renesas/next (168c85dfca17 Merge branch 'renesas-drivers-for-v5.17'=
 into renesas-next)
Merging reset/reset/next (c4f5b30dda01 reset: Add of_reset_control_get_opti=
onal_exclusive())
Merging rockchip/for-next (e862cef6cdda Merge branch 'v5.16-armsoc/soc-fixe=
s' into for-next)
Merging samsung-krzk/for-next (7b8664f50180 Merge branch 'next/soc' into fo=
r-next)
Merging scmi/for-linux-next (ca54383f2adb Merge branch 'for-next/scmi' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (1149ccc5e891 ARM: dts: stm32: fix stusb1600 pinct=
rl used on stm32mp157c-dk)
Merging sunxi/sunxi/for-next (c9a8f2f1da7b Merge branch 'sunxi/dt-for-5.17'=
 into sunxi/for-next)
Merging tee/next (ce352be35ba0 Merge branch 'async_notif' into next)
Merging tegra/for-next (bbd827b4de7e Merge branch for-5.16/arm64/defconfig =
into for-next)
Merging ti/ti-next (71907ae8e0c0 Merge branch 'ti-drivers-soc-next' into ti=
-next)
Merging xilinx/for-next (326b5e9db528 Merge branch 'zynqmp/soc' into for-ne=
xt)
Merging clk/clk-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging clk-imx/for-next (9dd81021084f clk: imx8mp: Fix the parent clk of t=
he audio_root_clk)
Merging clk-renesas/renesas-clk (33b22d9c3272 clk: renesas: r9a07g044: Add =
TSU clock and reset entry)
Merging clk-samsung/for-next (bcda841f9bf2 clk: samsung: exynos850: Registe=
r clocks early)
Merging csky/linux-next (e21e52ad1e01 csky: Make HAVE_TCM depend on !COMPIL=
E_TEST)
Merging h8300/h8300-next (1ec10274d436 h8300: don't implement set_fs)
Merging m68k/for-next (376e3fdecb0d m68k: Enable memtest functionality)
Merging m68knommu/for-next (d58071a8a76d Linux 5.16-rc3)
Merging microblaze/next (54b54ea061a8 microblaze: fix typo in a comment)
Merging mips/mips-next (97ad1d89624d MIPS: TXx9: Let MACH_TX49XX select BOO=
T_ELF32)
Merging nds32/next (07cd7745c6f2 nds32/setup: remove unused memblock_region=
 variable in setup_memory())
CONFLICT (content): Merge conflict in arch/nds32/Kconfig
CONFLICT (content): Merge conflict in arch/nds32/Kbuild
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (27dff9a9c247 openrisc: fix SMP tlb flush NULL po=
inter dereference)
Merging parisc-hd/for-next (8d88382b7436 parisc/agp: Annotate parisc agp in=
it functions with __init)
Merging powerpc/next (af3fdce4ab07 Revert "powerpc/code-patching: Improve v=
erification of patchability")
Merging soc-fsl/next (38a895d7dacf soc: fsl: Replace kernel.h with the nece=
ssary inclusions)
Merging risc-v/for-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging s390/for-next (272534ad304c Merge branch 'fixes' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (ab6ff1fda1e8 uml: x86: add FORCE to user_constants.=
h)
Merging xtensa/xtensa-for-next (bd47cdb78997 xtensa: move section symbols t=
o asm/sections.h)
Merging pidfd/for-next (0f8821da4845 fs/namespace: Boost the mount_lock.loc=
k owner instead of spinning on PREEMPT_RT.)
Merging fscrypt/master (b7e072f9b77f fscrypt: improve a few comments)
Merging fscache/fscache-next (b3c088faf78b fscache: Rewrite documentation)
CONFLICT (content): Merge conflict in Documentation/filesystems/netfs_libra=
ry.rst
Merging afs/afs-next (52af7105eceb afs: Set mtime from the client for yfs c=
reate operations)
Merging btrfs/for-next (279373dee83e Fixup merge-to-merge conflict in lzo_c=
ompress_pages)
Merging ceph/master (fd84bfdddd16 ceph: fix up non-directory creation in SG=
ID directories)
Merging cifs/for-next (b1f962ba272b cifs: avoid use of dstaddr as key for f=
scache client cookie)
CONFLICT (content): Merge conflict in fs/cifs/fscache.c
CONFLICT (content): Merge conflict in fs/cifs/connect.c
Merging configfs/for-next (c42dd069be8d configfs: fix a race in configfs_lo=
okup())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (a0961f351d82 erofs: don't trigger WARN() when decompress=
ion fails)
Merging exfat/dev (a671c22ee2d3 exfat: move super block magic number to mag=
ic.h)
Merging ext3/for_next (a48fc69fe658 udf: Fix crash after seekdir)
Merging ext4/dev (124e7c61deb2 ext4: fix error code saved on super block du=
ring file system abort)
Merging f2fs/dev (cbd1bb370a0b f2fs: show number of pending discard command=
s)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (3e2b6fdbdc9a fuse: send security context of inode on=
 file)
Merging gfs2/for-next (f19b52de3ae5 gfs2: Fix gfs2_instantiate description)
Merging jfs/jfs-next (c48a14dca2cb JFS: fix memleak in jfs_mount)
Merging ksmbd/ksmbd-for-next (d58071a8a76d Linux 5.16-rc3)
Merging nfs/linux-next (064a91771f7a SUNRPC: use different lock keys for IN=
ET6 and LOCAL)
Merging nfs-anna/linux-next (8cfb9015280d NFS: Always provide aligned buffe=
rs to the RPC read layers)
Merging nfsd/nfsd-next (136057256686 Linux 5.16-rc2)
Merging cel/for-next (4547ece9de7c NFSD: Fix inconsistent indenting)
Merging ntfs3/master (52e00ea6b26e fs/ntfs3: Update valid size if -EIOCBQUE=
UED)
Merging orangefs/for-next (ac2c63757f4f orangefs: Fix sb refcount leak when=
 allocate sb info failed.)
Merging overlayfs/overlayfs-next (5b0a414d06c3 ovl: fix filattr copy-up fai=
lure)
Merging ubifs/next (9aaa6cc099f6 ubifs: Document sysfs nodes)
Merging v9fs/9p-next (6e195b0f7c8e 9p: fix a bunch of checkpatch warnings)
Merging xfs/for-next (e445976537ad xfs: remove incorrect ASSERT in xfs_rena=
me)
Merging zonefs/for-next (95b115332a83 zonefs: remove redundant null bio che=
ck)
Merging iomap/iomap-for-next (5ad448ce2976 iomap: iomap_read_inline_data cl=
eanup)
Merging djw-vfs/vfs-for-next (d03ef4daf33a fs: forbid invalid project ID)
Merging file-locks/locks-next (80d8e4d3f313 fs/locks: fix fcntl_getlk64/fcn=
tl_setlk64 stub prototypes)
Merging vfs/for-next (8f40da9494cf Merge branch 'misc.namei' into for-next)
Merging printk/for-next (06cf63cb69be Merge branch 'for-5.16-fixup' into fo=
r-next)
Merging pci/next (77dd98624efc Merge branch 'pci/errors')
Merging pstore/for-next/pstore (a5d05b07961a pstore/ftrace: Allow immediate=
 recording)
Merging hid/for-next (afbf9a26b193 Merge branch 'for-5.17/core' into for-ne=
xt)
Merging i2c/i2c/for-next (4bca26c18f7b Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (a3587e2c0578 i3c: fix incorrect address slot lookup o=
n 64-bit)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (253402129b1a hwmon: (sht4x) Add device tr=
ee match table)
Merging jc_docs/docs-next (065db2d90c6b docs/zh_CN: Add zh_CN/accounting/ta=
skstats.rst)
Merging v4l-dvb/master (1f1517fafda5 media: cx18: drop an unused macro)
Merging v4l-dvb-next/master (8cc7a1b2aca0 media: venus: core: Fix a resourc=
e leak in the error handling path of 'venus_probe()')
Merging pm/linux-next (44e0749b647e Merge branch 'pm-cpufreq' into linux-ne=
xt)
$ git reset --hard HEAD^
Merging next-20211201 version of pm
Merging cpufreq-arm/cpufreq/arm/linux-next (3ed6dfbd3bb9 cpufreq: qcom-hw: =
Set CPU affinity of dcvsh interrupts)
Merging cpupower/cpupower (79a0dc5530a9 tools: cpupower: fix typo in cpupow=
er-idle-set(1) manpage)
Merging devfreq/devfreq-next (5cf79c293821 PM / devfreq: Strengthen check f=
or freq_table)
Merging opp/opp/linux-next (7ca81b690e59 dt-bindings: opp: Allow multi-word=
ed OPP entry name)
Merging thermal/thermal/linux-next (673c68bd4839 thermal/drivers: Add TSU d=
river for RZ/G2L)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (1b9beda83e27 fs: dlm: fix build with CONFIG_IPV6 disabled)
Merging rdma/for-next (81ff48ddda0b RDMA/bnxt_re: Use bitmap_zalloc() when =
applicable)
Merging net-next/master (fc993be36f9e Merge git://git.kernel.org/pub/scm/li=
nux/kernel/git/netdev/net)
Merging bpf-next/for-next (080a70b21f47 Merge branch 'Deprecate bpf_prog_lo=
ad_xattr() API')
CONFLICT (content): Merge conflict in Documentation/bpf/index.rst
$ git reset --hard HEAD^
Merging next-20211202 version of bpf-next
CONFLICT (content): Merge conflict in Documentation/bpf/index.rst
[master fa37b43bc1bd] next-20211202/bpf-next
Merging ipsec-next/master (ac1077e92825 net: xfrm: drop check of pols[0] fo=
r the second time)
Merging mlx5-next/mlx5-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging netfilter-next/master (632cb151ca53 netfilter: ctnetlink: remove us=
eless type conversion to bool)
Merging ipvs-next/master (ec574d9ee5d2 net: phylink: add 1000base-KX to phy=
link_caps_to_linkmodes())
Merging wireless-drivers-next/master (69831173fcbb rtlwifi: rtl8192de: Styl=
e clean-ups)
Merging bluetooth/master (dbf6811abbfc Bluetooth: Limit duration of Remote =
Name Resolve)
Merging mac80211-next/master (75c5bd68b699 ieee80211: change HE nominal pac=
ket padding value defines)
Merging mtd/mtd/next (67bcbe202b48 mtd: core: clear out unregistered device=
s a bit more)
Merging nand/nand/next (f53d4c109a66 mtd: rawnand: gpmi: Add ERR007117 prot=
ection for nfc_apply_timings)
Merging spi-nor/spi-nor/next (228e80459960 MAINTAINERS: Add myself as SPI N=
OR co-maintainer)
Merging crypto/master (330507fbc9d8 crypto: des - disallow des3 in FIPS mod=
e)
Merging drm/drm-next (c305ae99dfd4 Merge tag 'drm-intel-next-2021-11-30' of=
 git://anongit.freedesktop.org/drm/drm-intel into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/vc4/vc4_kms.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_dp=
_aux_backlight.c
Merging drm-misc/for-linux-next (4ff22f487f8c drm: Return error codes from =
struct drm_driver.gem_create_object)
Merging amdgpu/drm-next (ee641f210a83 drm/amdgpu: bump driver version for P=
ROFILE IOCTL)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/nv.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_vcn=
.c
Merging drm-intel/for-linux-next (0e959b4e993b drm/i915: Add PLANE_CUS_CTL =
restriction in max_width)
Merging drm-intel-gt/for-linux-next-gt (96b1c450b386 drm/i915: Add workarou=
nd numbers to GEN7_COMMON_SLICE_CHICKEN1 whitelisting)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/display/intel_fb=
c.c
Merging drm-tegra/drm/tegra/for-next (cef3fb370da3 drm/tegra: Mark nvdec PM=
 functions as __maybe_unused)
CONFLICT (content): Merge conflict in drivers/gpu/drm/tegra/gem.c
Merging drm-msm/msm-next (fee328076333 mailmap: add and update email addres=
ses)
Merging imx-drm/imx-drm/next (20fbfc81e390 drm/imx: imx-tve: Make use of th=
e helper function devm_platform_ioremap_resource())
Merging etnaviv/etnaviv/next (96894b795967 drm/etnaviv: constify static str=
uct cooling_ops)
Applying: fix up for "drm/amdgpu: cancel the correct hrtimer on exit"
Merging regmap/for-next (02d6fdecb9c3 regmap: allow to define reg_update_bi=
ts for no bus configuration)
Merging sound/for-next (1e583aef12aa ALSA: usb-audio: Drop superfluous '0' =
in Presonus Studio 1810c's ID)
Merging sound-asoc/for-next (0695ad92fe1a ASoC: cs35l41: Fix undefined refe=
rence to core functions)
Merging modules/modules-next (ced75a2f5da7 MAINTAINERS: Add Luis Chamberlai=
n as modules maintainer)
Merging input/next (fafc66387dc0 Input: wacom_i2c - clean up the query devi=
ce fields)
Merging block/for-next (c3c48be50691 Merge branch 'for-5.17/block' into for=
-next)
Merging device-mapper/for-next (1b8d2789dad0 dm btree remove: fix use after=
 free in rebalance_children())
Merging libata/for-next (06d5d558f5a3 ata: replace snprintf in show functio=
ns with sysfs_emit)
Merging pcmcia/pcmcia-next (e39cdacf2f66 pcmcia: i82092: fix a null pointer=
 dereference bug)
Merging mmc/next (f9962ac595d2 mmc: sdhci-esdhc-imx: Add sdhc support for i=
.MXRT series)
Merging mfd/for-mfd-next (5dc6dafe6209 mfd: simple-mfd-i2c: Select MFD_CORE=
 to fix build error)
Merging backlight/for-backlight-next (3976e974df1f video: backlight: ili932=
0: Make ili9320_remove() return void)
Merging battery/for-next (9652c02428f3 power: bq25890: add POWER_SUPPLY_PRO=
P_TEMP)
Merging regulator/for-next (d69e19723f88 regulator: qcom-rpmh: Add support =
for PM8450 regulators)
Merging security/next-testing (047843bdb316 Merge branch 'landlock_lsm_v34'=
 into next-testing)
Merging apparmor/apparmor-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging integrity/next-integrity (32ba540f3c2a evm: mark evm_fixmode as __r=
o_after_init)
Merging keys/keys-next (e377c31f788f integrity: Load mokx variables into th=
e blacklist keyring)
CONFLICT (content): Merge conflict in certs/system_keyring.c
Merging safesetid/safesetid-next (1b8b71922919 LSM: SafeSetID: Mark safeset=
id_initialized as __initdata)
Merging selinux/next (6326948f940d lsm: security_task_getsecid_subj() -> se=
curity_current_getsecid_subj())
Merging smack/next (0934ad42bb2c smackfs: use netlbl_cfg_cipsov4_del() for =
deleting cipso_v4_doi)
Merging tomoyo/master (5d9f4cf36721 Merge tag 'selinux-pr-20211123' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux)
Merging tpmdd/next (7eba41fe8c7b tpm_tis_spi: Add missing SPI ID)
Merging watchdog/master (c738888032ff watchdog: db8500_wdt: Rename symbols)
Merging iommu/next (86dc40c7ea9c iommu/vt-d: Fix unmap_pages support)
Merging audit/next (fa55b7dcdc43 Linux 5.16-rc1)
Merging devicetree/for-next (4e5b6de1f46d dt-bindings: net: cdns,macb: Conv=
ert to json-schema)
Merging mailbox/mailbox-for-next (97961f78e8bc mailbox: imx: support i.MX8U=
LP S4 MU)
Merging spi/for-next (e9d7c323cfbb dt-bindings: mtd: spi-nor: Add a referen=
ce to spi-peripheral-props.yaml)
Merging tip/auto-latest (b6c28e3cc445 Merge x86/core into tip/master)
Merging clockevents/timers/drivers/next (453e2cadc97c dt-bindings: timer: t=
pm-timer: Add imx8ulp compatible string)
Merging edac/edac-for-next (a9e6b3819b36 dt-bindings: memory: Add entry for=
 version 3.80a)
Merging irqchip/irq/irqchip-next (11e45471abea Merge branch irq/misc-5.16 i=
nto irq/irqchip-next)
Merging ftrace/for-next (a55f224ff5f2 tracing: Fix pid filtering when trigg=
ers are attached)
Merging rcu/rcu/next (4ed01fd08c86 EXP workqueue: Fix unbind_workers() VS w=
q_worker_sleeping() race)
Merging kvm/next (da1bfd52b930 KVM: x86: Drop arbitrary KVM_SOFT_MAX_VCPUS)
Merging kvm-arm/next (3d9601d85d14 Merge branch kvm-arm64/misc-5.17 into kv=
marm-master/next)
Merging kvms390/next (3fd8417f2c72 KVM: s390: add debug statement for diag =
318 CPNC data)
Merging xen-tip/linux-next (00db58cf2118 xen: make HYPERVISOR_set_debugreg(=
) always_inline)
Merging percpu/for-next (a81a52b325ec Merge branch 'for-5.14-fixes' into fo=
r-next)
Merging workqueues/for-next (45c753f5f24d workqueue: Fix unbind_workers() V=
S wq_worker_sleeping() race)
Merging drivers-x86/for-next (a602f5111fdd platform/x86: amd-pmc: Fix s2idl=
e failures on certain AMD laptops)
Merging chrome-platform/for-next (297d34e73d49 platform/chrome: cros_ec_pro=
to: Use ec_command for check_features)
Merging hsi/for-next (a1ee1c08fcd5 HSI: core: Fix return freed object in hs=
i_new_client)
Merging leds/for-next (66340b5a6f86 leds: leds-fsg: Drop FSG3 LED driver)
Merging ipmi/for-next (56733fa5eb45 ipmi/watchdog: Constify ident)
Merging driver-core/driver-core-next (2043727c2882 driver core: platform: M=
ake use of the helper function dev_err_probe())
Merging usb/usb-next (4d012040161c Merge 5.16-rc3 into usb-next)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (d58071a8a76d Linux 5.16-rc3)
Merging usb-chipidea-next/for-usb-next (78665f57c3fa usb: chipidea: udc: ma=
ke controller hardware endpoint primed)
Merging tty/tty-next (3f19fed8d0da Documentation: add TTY chapter)
Merging char-misc/char-misc-next (5d331b592255 Merge 5.16-rc3 into char-mis=
c-next)
Merging extcon/extcon-next (9e6ef3a25e5e dt-bindings: extcon: usbc-tusb320:=
 Add TUSB320L compatible string)
Merging phy-next/next (17dcc120fb8d phy: lan966x: Extend lan966x to support=
 multiple phy interfaces.)
Merging soundwire/next (bb349fd2d580 soundwire: qcom: remove redundant vers=
ion number read)
Merging thunderbolt/next (d58071a8a76d Linux 5.16-rc3)
Merging vfio/next (3bf1311f351e vfio/ccw: Convert to use vfio_register_emul=
ated_iommu_dev())
Merging staging/staging-next (24cd719712ae Merge 5.16-rc3 into staging-next)
Merging iio/togreg (7d71d289e1ba iio: light: ltr501: Added ltr303 driver su=
pport)
Merging mux/for-next (3516bd729358 Merge tag 's390-5.11-3' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/s390/linux)
Merging icc/icc-next (78e488c462e5 Merge branch 'icc-msm8996' into icc-next)
Merging dmaengine/next (7eafa6eed7f1 dmaengine: ppc4xx: remove unused varia=
ble `rval')
Merging cgroup/for-next (e14da77113bb cgroup: Trace event cgroup id fields =
should be u64)
Merging scsi/for-next (32f4b58cc162 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (bf3f120fd61c scsi: sd_zbc: Clean up sd_zbc_parse=
_report() setting of wp)
Merging vhost/linux-next (4bd5d4c69825 iommu/virtio: Support identity-mappe=
d domains)
Merging rpmsg/for-next (c4b39a582b9b Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (4f4534893407 dt-bindings: gpio: sifive,gpi=
o: Group interrupt tuples)
$ git reset --hard HEAD^
Merging next-20211115 version of gpio-brgl
Merging gpio-intel/for-next (e1610431b95c gpio: dwapb: clarify usage of the=
 register file version)
Merging gpio-sim/gpio/gpio-sim (5065e08e4ef3 gpio: sim: fix missing unlock =
on error in gpio_sim_config_commit_item())
CONFLICT (content): Merge conflict in tools/testing/selftests/gpio/Makefile
Merging pinctrl/for-next (c1ba797af83b Merge branch 'devel' into for-next)
Merging pinctrl-intel/for-next (db1b2a8caf5b pinctrl: cherryview: Use tempo=
rary variable for struct device)
Merging pinctrl-renesas/renesas-pinctrl (7c50a407b868 pinctrl: renesas: Rem=
ove unneeded locking around sh_pfc_read() calls)
Merging pinctrl-samsung/for-next (16dd3bb5c190 pinctrl: samsung: Make symbo=
l 'exynos7885_pin_ctrl' static)
Merging pwm/for-next (b6ce2af8766c pwm: img: Use only a single idiom to get=
 a runtime PM reference)
Merging userns/for-next (5ae9497dda62 signal: requeuing undeliverable signa=
ls)
Merging ktest/for-next (170f4869e662 ktest.pl: Fix the logic for truncating=
 the size of the log file for email)
Merging kselftest/next (60726e868227 selftests/ftrace: make kprobe profile =
testcase description unique)
Merging livepatching/for-next (cd2d68f2d6b2 Merge branch 'for-5.15/cpu-hotp=
lug' into for-next)
Merging coresight/next (f9809d565135 Documentation: coresight: Update cores=
ight configuration docs)
Merging rtc/rtc-next (a478c433d72b rtc: da9063: switch to RTC_FEATURE_UPDAT=
E_INTERRUPT)
Merging nvdimm/libnvdimm-for-next (e765f13ed126 nvdimm/pmem: move dax_attri=
bute_group from dax to pmem)
Merging at24/at24/for-next (92e1764787e5 eeprom: at24: remove struct at24_c=
lient)
Merging ntb/ntb-next (f96cb827ce49 ntb: ntb_pingpong: remove redundant init=
ialization of variables msg_data and spad_data)
Merging seccomp/for-next/seccomp (1e6d69c7b9cd selftests/seccomp: Report ev=
ent mismatches more clearly)
Merging kspp/for-next/kspp (879f756fa9bf Merge branches 'for-next/hardening=
', 'for-next/overflow' and 'for-next/thread_info/cpu' into for-next/kspp)
Merging kspp-gustavo/for-next/kspp (64bc5a949ae1 Merge branch 'for-linus/ks=
pp' into for-next/kspp)
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging gnss/gnss-next (b15c90153fd9 gnss: drop stray semicolons)
Merging fsi/next (7cc2f34e1f4d fsi: sbefifo: Use interruptible mutex lockin=
g)
Merging slimbus/for-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging nvmem/for-next (42f65ea5a727 nvmem: mtk-efuse: support minimum one =
byte access stride and granularity)
Merging xarray/main (f2aa11fd5144 tools: Fix math.h breakage)
Merging hyperv/hyperv-next (285f68afa8b2 x86/hyperv: Protect set_hv_tscchan=
ge_cb() against getting preempted)
Merging auxdisplay/auxdisplay (4daa9ff89ef2 auxdisplay: charlcd: checking f=
or pointer reference before dereferencing)
Merging kgdb/kgdb/for-next (b77dbc86d604 kdb: Adopt scheduler's task classi=
fication)
Merging hmm/hmm (6880fa6c5660 Linux 5.15-rc1)
Merging fpga/for-next (ea59fc1beff1 fpga: stratix10-soc: Do not use ret uni=
nitialized in s10_probe())
Merging kunit/test (fa55b7dcdc43 Linux 5.16-rc1)
Merging cfi/cfi/next (baaf965f9430 mtd: hyperbus: rpc-if: fix bug in rpcif_=
hb_remove)
Merging kunit-next/kunit (fa55b7dcdc43 Linux 5.16-rc1)
Merging trivial/for-next (9ff9b0d392ea Merge tag 'net-next-5.10' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging mhi/mhi-next (46827f596963 bus: mhi: pci_generic: Simplify code and=
 axe the use of a deprecated API)
Merging memblock/for-next (e888fa7bb882 memblock: Check memory add/cap orde=
ring)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging rust/rust-next (988f45dfe7ea MAINTAINERS: Rust)
CONFLICT (content): Merge conflict in scripts/kconfig/confdata.c
CONFLICT (content): Merge conflict in scripts/Makefile.modfinal
CONFLICT (content): Merge conflict in samples/Makefile
CONFLICT (content): Merge conflict in samples/Kconfig
CONFLICT (content): Merge conflict in Makefile
CONFLICT (content): Merge conflict in Documentation/process/changes.rst
Applying: Kbuild: fix for "kbuild: split DEBUG_CFLAGS out to scripts/Makefi=
le.debug"
Merging cxl/next (53989fad1286 cxl/pmem: Fix module reload vs workqueue sta=
te)
Merging folio/for-next (c03571399870 mm: Add functions to zero portions of =
a folio)
Merging bitmap/bitmap-master-5.15 (785cb064e2f8 vsprintf: rework bitmap_lis=
t_string)
CONFLICT (content): Merge conflict in drivers/dma/ti/edma.c
CONFLICT (content): Merge conflict in arch/parisc/include/asm/bitops.h
Merging zstd/zstd-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging efi/next (720dff78de36 efi: Allow efi=3Druntime)
Merging unicode/for-next (e2a58d2d3416 unicode: only export internal symbol=
s for the selftests)
CONFLICT (content): Merge conflict in fs/f2fs/sysfs.c
Merging slab/slab-next (d395d823b3ae bootmem: Use page->index instead of pa=
ge->freelist)
Merging random/master (442e8775c9e5 random: document add_hwgenerator_random=
ness() with other input functions)
Applying: mark HID_CHICONY as broken for now
Merging akpm-current/current (3e4cab64cd9b lib/Kconfig.debug: make TEST_KMO=
D depend on PAGE_SIZE_LESS_THAN_256KB)
CONFLICT (content): Merge conflict in mm/zsmalloc.c
CONFLICT (content): Merge conflict in mm/memcontrol.c
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (be775b064ef6 lib/stackdepot: always do filter_irq_stac=
ks() in stack_depot_save())

--Sig_/dJq4YmqGORoe6/5ibX5QKrm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGp2Y0ACgkQAVBC80lX
0GwOXQf6Ajykouido11kBtIxCsoy4J8s5EIPjtf63MuL496PBQSFHhH9aEfTBggX
iDw6hrViJStUfrttXU3iV29TziDG4Tt/fQZkkbZAGklkVVzvnzVzV9cZiS4Nd8l3
jXPP9Gu+BNyMtzm/y2tDZioqu57jVl7hx4rDicSvWDUTPetfCJ8QvGgWos+EpEvr
HvijmqWwaJDJupS7CGsM9ISDAQadFuVFg1GghdggDlQkYP6rUb9espm6oXjKjCB9
DpQ/rk+HnbuK98nvjZ47woL/Sl2BaR5zVeMZIzXQ14iog7p3Q28+fVZb7s6Z+Tsb
9H8Ikvo7MQJRN1SwE+mSd4bweoG6Eg==
=pKkV
-----END PGP SIGNATURE-----

--Sig_/dJq4YmqGORoe6/5ibX5QKrm--
