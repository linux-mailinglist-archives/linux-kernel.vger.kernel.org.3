Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEFD460FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 08:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbhK2H6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 02:58:01 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:52275 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbhK2H4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 02:56:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J2cyf28vFz4xR7;
        Mon, 29 Nov 2021 18:52:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638172362;
        bh=1gun9GgUhAMafUc+VwVRfk8gxVVVTBgGt15sSKJ7Zd8=;
        h=Date:From:To:Cc:Subject:From;
        b=pZ1WfcsMmLGxYvzyXiohqS3tiWi8fN/1ju35ERiGuDx6AqlgtBmRboxi7gaG7szxH
         CGBxfKfVKx17uT5h6TEYHEpzIjWkodJve36YsxtgE7LG12OdtZdN3eYCD/9ZG6rac0
         zua3lxopAnUwWy9eiUz0Fu684tAHyNJaz2K8NBt2YTJLFSRXOZfXV+D5wL4mCyhbP7
         PNjOV7yyvuAH+v8iaH2Oae+8AgqfBrX1mAsuthIaJeMWqb4S5iRc1isOp94A2byCrt
         lbrA5QDl90A45hn/Q8/SbjjE9p+xgGbLLo7xSCZJLYETFt+j6tIXg5zffZI14j5zFQ
         1AzJVXnODQyVw==
Date:   Mon, 29 Nov 2021 18:52:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Nov 29
Message-ID: <20211129185241.716acaef@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/asX/qlOxu4uX=3yC5NinvMR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/asX/qlOxu4uX=3yC5NinvMR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20211126:

My fixes tree is empty again.

The sound-asoc tree gained a conflict against the sound-current tree.

The tip tree still has its build failure for which I reverted 2 commits.

The gpio-brgl tree still had its build failure so I used the version from
next-20211115.

Non-merge commits (relative to Linus' tree): 3485
 4013 files changed, 161829 insertions(+), 65749 deletions(-)

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

I am currently merging 344 trees (counting Linus' and 94 trees of bug
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
Merging origin/master (d06c942efea4 Merge tag 'for_linus' of git://git.kern=
el.org/pub/scm/linux/kernel/git/mst/vhost)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (e851dfae4371 Merge tag 'kgdb-5.16-rc1' of git=
://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux)
Merging arc-current/for-curr (b9cac915c541 ARC: thread_info.h: correct two =
typos in a comment)
Merging arm-current/fixes (418ace9992a7 ARM: 9156/1: drop cc-option fallbac=
ks for architecture selection)
Merging arm64-fixes/for-next/fixes (94902d849e85 arm64: uaccess: avoid bloc=
king within critical sections)
Merging arm-soc-fixes/arm/fixes (383a44aec91c memory: mtk-smi: Fix a null d=
ereference for the ostd)
Merging drivers-memory-fixes/fixes (8c5ba21c16bd memory: mtk-smi: Fix a nul=
l dereference for the ostd)
Merging tee-fixes/fixes (d246d81cdbc4 Merge tag 'optee-fix-for-v5.16' into =
fixes)
Merging m68k-current/for-linus (8a3c0a74ae87 m68k: defconfig: Update defcon=
figs for v5.15-rc1)
Merging powerpc-fixes/fixes (5bb60ea611db powerpc/32: Fix hardlockup on vma=
p stack overflow)
Merging s390-fixes/fixes (53ae72309181 s390/test_unwind: use raw opcode ins=
tead of invalid instruction)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (c5c17547b778 Merge tag 'net-5.16-rc3' of git://git.kern=
el.org/pub/scm/linux/kernel/git/netdev/net)
Merging bpf/master (c0d95d3380ee bpf, sockmap: Re-evaluate proto ops when p=
sock is removed from sockmap)
Merging ipsec/master (ec3bb890817e xfrm: fix dflt policy check when there i=
s no policy configured)
Merging netfilter/master (619ca0d0108a selftests: add arp_ndisc_evict_nocar=
rier to Makefile)
Merging ipvs/master (c45231a7668d litex_liteeth: Fix a double free in the r=
emove function)
Merging wireless-drivers/master (2a9e9857473b mt76: fix possible pktid leak)
Merging mac80211/master (8f9dcc295666 mac80211: fix a memory leak where sta=
_info is not freed)
Merging rdma-fixes/for-rc (b0969f83890b RDMA/hns: Do not destroy QP resourc=
es in the hw resetting phase)
Merging sound-current/for-linus (dcd46eb7a957 Merge tag 'asoc-fix-v5.16-rc3=
' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for=
-linus)
Merging sound-asoc-fixes/for-linus (f0e5dae34bb2 Merge remote-tracking bran=
ch 'asoc/for-5.15' into asoc-linus)
Merging regmap-fixes/for-linus (459e1cd0d5ec Merge remote-tracking branch '=
regmap/for-5.15' into regmap-linus)
Merging regulator-fixes/for-linus (6966df483d7b regulator: Update protectio=
n IRQ helper docs)
Merging spi-fixes/for-linus (682ecf32bc9c Merge remote-tracking branch 'spi=
/for-5.15' into spi-linus)
Merging pci-current/for-linus (fa55b7dcdc43 Linux 5.16-rc1)
Merging driver-core.current/driver-core-linus (136057256686 Linux 5.16-rc2)
Merging tty.current/tty-linus (bb1201d4b38e serial: 8250_pci: rewrite peric=
om_do_set_divisor())
Merging usb.current/usb-linus (a88db2ecc2d2 Merge tag 'usb-serial-5.16-rc3'=
 of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into u=
sb-linus)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (88459e3e4276 USB: serial: option: add F=
ibocom FM101-GL variants)
Merging usb-chipidea-fixes/for-usb-fixes (f130d08a8d79 usb: chipidea: ci_hd=
rc_imx: Also search for 'phys' phandle)
CONFLICT (content): Merge conflict in drivers/usb/chipidea/ci_hdrc_imx.c
Merging phy/fixes (f0ae8685b285 phy: HiSilicon: Fix copy and paste bug in e=
rror handling)
Merging staging.current/staging-linus (b535917c51ac staging: rtl8192e: Fix =
use after free in _rtl92e_pci_disconnect())
Merging iio-fixes/fixes-togreg (784b470728f5 iio: adc: stm32: fix null poin=
ter on defer_probe error)
Merging char-misc.current/char-misc-linus (c5c17547b778 Merge tag 'net-5.16=
-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net)
Merging soundwire-fixes/fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging thunderbolt-fixes/fixes (136057256686 Linux 5.16-rc2)
Merging input-current/for-linus (efe6f16c6faf Merge branch 'next' into for-=
linus)
Merging crypto-current/master (beaaaa37c664 crypto: api - Fix boot-up crash=
 when crypto manager is disabled)
Merging vfio-fixes/for-linus (42de956ca7e5 vfio/ap_ops: Add missed vfio_uni=
nit_group_dev())
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
Merging v4l-dvb-fixes/fixes (62456590b849 media: hi846: remove the of_match=
_ptr macro)
Merging reset-fixes/reset/fixes (69125b4b9440 reset: tegra-bpmp: Revert Han=
dle errors in BPMP response)
Merging mips-fixes/mips-fixes (41ce097f7144 MIPS: use 3-level pgtable for 6=
4KB page size on MIPS_VA_BITS_48)
Merging at91-fixes/at91-fixes (dbe68bc9e82b ARM: dts: at91: sama7g5ek: to n=
ot touch slew-rate for SDMMC pins)
Merging omap-fixes/fixes (80d680fdccba ARM: dts: omap3430-sdp: Fix NAND dev=
ice node)
Merging kvm-fixes/master (30d7c5d60a88 KVM: SEV: expose KVM_CAP_VM_MOVE_ENC=
_CONTEXT_FROM capability)
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
Merging drivers-x86-fixes/fixes (bbb9429a210e platform/x86: touchscreen_dmi=
: Add TrekStor SurfTab duo W1 touchscreen info)
Merging samsung-krzk-fixes/fixes (4f5d06d381ba arm64: dts: exynos: drop sam=
sung,ufs-shareability-reg-offset in ExynosAutov9)
Merging pinctrl-samsung-fixes/fixes (fa55b7dcdc43 Linux 5.16-rc1)
Merging devicetree-fixes/dt/linus (913d3a3f8408 dt-bindings: watchdog: sunx=
i: fix error in schema)
Merging scsi-fixes/fixes (2d62253eb1b6 scsi: scsi_debug: Zero clear zones a=
t reset write pointer)
Merging drm-fixes/drm-fixes (fc026c8b9268 Merge tag 'drm-intel-fixes-2021-1=
1-24' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (b8d8436840ca drm/i915/gt: Hol=
d RPM wakelock during PXP suspend)
Merging mmc-fixes/fixes (5f719948b5d4 mmc: spi: Add device-tree SPI IDs)
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
Merging irqchip-fixes/irq/irqchip-fixes (357a9c4b79f4 irqchip/mips-gic: Use=
 bitfield helpers)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (8b98436af2c0 Merge tag 'perf-tools-fixes-=
for-v5.16-2021-11-19' of git://git.kernel.org/pub/scm/linux/kernel/git/acme=
/linux)
Merging efi-fixes/urgent (38fa3206bf44 efi: Change down_interruptible() in =
virt_efi_reset_system() to down_trylock())
Merging zstd-fixes/zstd-linus (7416cdc9b9c1 lib: zstd: Don't add -O3 to cfl=
ags)
Merging drm-misc-fixes/for-linux-next-fixes (e048834c209a drm/hyperv: Fix d=
evice removal on Gen1 VMs)
Merging kbuild/for-next (7528edbafeef [for -next only] kconfig: generate in=
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
Merging arm64/for-next/core (c7c386fbc202 arm64: pgtable: make __pte_to_phy=
s/__phys_to_pte_val inline functions)
Merging arm-perf/for-next/perf (e656972b6986 drivers/perf: Improve build te=
st coverage)
Merging arm-soc/for-next (b86314b30dee Merge branch 'arm/fixes' into for-ne=
xt)
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (1e9fc71213d7 arm64: dts: meson-gxbb-wetek: use up=
dated LED bindings)
Merging aspeed/for-next (16d6dc8d8030 ARM: dts: aspeed: mtjade: Add uefi pa=
rtition)
Merging at91/at91-next (f3c0366411d6 ARM: dts: at91: sama7g5-ek: use blocks=
 0 and 1 of TCB0 as cs and ce)
Merging drivers-memory/for-next (7dbdb198911d Merge branch 'for-v5.17/renes=
as-rpc' into for-next)
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
Merging qcom/for-next (b287e05999e7 Merge branches 'arm64-for-5.17', 'drive=
rs-for-5.17' and 'dts-for-5.17' into for-next)
Merging raspberrypi/for-next (a036b0a5d7d6 ARM: dts: bcm2711-rpi-4-b: Fix u=
sb's unit address)
Merging renesas/next (aeb0ae2627f7 Merge branches 'renesas-arm-dt-for-v5.17=
' and 'renesas-dt-bindings-for-v5.17' into renesas-next)
Merging reset/reset/next (c4f5b30dda01 reset: Add of_reset_control_get_opti=
onal_exclusive())
Merging rockchip/for-next (e862cef6cdda Merge branch 'v5.16-armsoc/soc-fixe=
s' into for-next)
Merging samsung-krzk/for-next (7b8664f50180 Merge branch 'next/soc' into fo=
r-next)
Merging scmi/for-linux-next (13fb3693194d Merge branch 'for-next/scmi' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-li=
nux-next)
Merging stm32/stm32-next (28f645fc9424 ARM: dts: stm32: tune the HS USB PHY=
s on stm32mp157c-ev1)
Merging sunxi/sunxi/for-next (7c6997ef13d4 Merge branch 'sunxi/dt-for-5.17'=
 into sunxi/for-next)
Merging tee/next (de6c9fc2269e Merge branch 'fixes' into next)
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
Merging m68k/for-next (8a3c0a74ae87 m68k: defconfig: Update defconfigs for =
v5.15-rc1)
Merging m68knommu/for-next (136057256686 Linux 5.16-rc2)
Merging microblaze/next (43bdcbd50043 microblaze: timer: Remove unused prop=
erties)
Merging mips/mips-next (136057256686 Linux 5.16-rc2)
Merging nds32/next (07cd7745c6f2 nds32/setup: remove unused memblock_region=
 variable in setup_memory())
CONFLICT (content): Merge conflict in arch/nds32/Kconfig
CONFLICT (content): Merge conflict in arch/nds32/Kbuild
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (27dff9a9c247 openrisc: fix SMP tlb flush NULL po=
inter dereference)
Merging parisc-hd/for-next (1deef82307b8 parisc/agp: Annotate parisc agp in=
it functions with __init)
Merging powerpc/next (3d030e301856 powerpc/watchdog: Fix wd_smp_last_reset_=
tb reporting)
Merging soc-fsl/next (54c8b5b6f8a8 soc: fsl: dpio: rename the enqueue descr=
iptor variable)
Merging risc-v/for-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging s390/for-next (401bf465cf2d Merge branch 'fixes' into for-next)
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
Merging fscache/fscache-next (8bb7eca972ad Linux 5.15)
Merging afs/afs-next (52af7105eceb afs: Set mtime from the client for yfs c=
reate operations)
Merging btrfs/for-next (279373dee83e Fixup merge-to-merge conflict in lzo_c=
ompress_pages)
Merging ceph/master (c02cb7bdc450 ceph: add a new metric to keep track of r=
emote object copies)
Merging cifs/for-next (3498e7f2bb41 Merge tag '5.16-rc2-ksmbd-fixes' of git=
://git.samba.org/ksmbd)
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
Merging f2fs/dev (b3b2202d4299 f2fs: use iomap for direct I/O)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (3e2b6fdbdc9a fuse: send security context of inode on=
 file)
Merging gfs2/for-next (04845dcc465b gfs2: Clear inode glock object when loo=
kup fails)
Merging jfs/jfs-next (c48a14dca2cb JFS: fix memleak in jfs_mount)
Merging ksmbd/ksmbd-for-next (3498e7f2bb41 Merge tag '5.16-rc2-ksmbd-fixes'=
 of git://git.samba.org/ksmbd)
Merging nfs/linux-next (064a91771f7a SUNRPC: use different lock keys for IN=
ET6 and LOCAL)
Merging nfs-anna/linux-next (8cfb9015280d NFS: Always provide aligned buffe=
rs to the RPC read layers)
Merging nfsd/nfsd-next (136057256686 Linux 5.16-rc2)
Merging cel/for-next (24e47575a845 NFSD: Fix sparse warning)
Merging ntfs3/master (52e00ea6b26e fs/ntfs3: Update valid size if -EIOCBQUE=
UED)
Merging orangefs/for-next (ac2c63757f4f orangefs: Fix sb refcount leak when=
 allocate sb info failed.)
Merging overlayfs/overlayfs-next (5b0a414d06c3 ovl: fix filattr copy-up fai=
lure)
Merging ubifs/next (9aaa6cc099f6 ubifs: Document sysfs nodes)
Merging v9fs/9p-next (6e195b0f7c8e 9p: fix a bunch of checkpatch warnings)
Merging xfs/for-next (1090427bf18f xfs: remove xfs_inew_wait)
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
Merging pci/next (ff81d75aa0e4 Merge branch 'pci/switchtec')
Merging pstore/for-next/pstore (a5d05b07961a pstore/ftrace: Allow immediate=
 recording)
Merging hid/for-next (2d05de93b9a8 Merge branches 'for-5.16/upstream-fixes'=
, 'for-5.17/apple', 'for-5.17/i2c-hid', 'for-5.17/logitech' and 'for-5.17/m=
agicmouse' into for-next)
Merging i2c/i2c/for-next (fc27bf4a1b3a Merge branch 'i2c/for-mergewindow' i=
nto i2c/for-next)
Merging i3c/i3c/next (a3587e2c0578 i3c: fix incorrect address slot lookup o=
n 64-bit)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (7844f4722a8c hwmon: (ntc_thermistor) Merg=
e platform data)
Merging jc_docs/docs-next (b96ff02ab2be Documentation/process: fix a cross =
reference)
Merging v4l-dvb/master (999ed03518cb media: atomisp: cleanup qbuf logic)
Merging v4l-dvb-next/master (b1b447e2f3e1 media: mxl5005s: drop some dead c=
ode)
Merging pm/linux-next (7975c7f139bb Merge branches 'acpi-power', 'acpi-dptf=
', 'acpi-processor' and 'acpi-scan' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (3ed6dfbd3bb9 cpufreq: qcom-hw: =
Set CPU affinity of dcvsh interrupts)
Merging cpupower/cpupower (79a0dc5530a9 tools: cpupower: fix typo in cpupow=
er-idle-set(1) manpage)
Merging devfreq/devfreq-next (5cf79c293821 PM / devfreq: Strengthen check f=
or freq_table)
Merging opp/opp/linux-next (7ca81b690e59 dt-bindings: opp: Allow multi-word=
ed OPP entry name)
Merging thermal/thermal/linux-next (a67a46af4ad6 thermal/core: Deprecate ch=
anging cooling device state from userspace)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (1b9beda83e27 fs: dlm: fix build with CONFIG_IPV6 disabled)
Merging rdma/for-next (0e938533d96d RDMA/bnxt_re: Remove dynamic pkey table)
Merging net-next/master (d40ce48cb3a6 Merge branch 'af_unix-replace-unix_ta=
ble_lock-with-per-hash-locks')
Merging bpf-next/for-next (e32cb12ff52a bpf, mips: Fix build errors about _=
_NR_bpf undeclared)
CONFLICT (content): Merge conflict in Documentation/bpf/index.rst
Merging ipsec-next/master (2e1809208a4a xfrm: Remove duplicate assignment)
Merging mlx5-next/mlx5-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging netfilter-next/master (ec574d9ee5d2 net: phylink: add 1000base-KX t=
o phylink_caps_to_linkmodes())
Merging ipvs-next/master (cc0356d6a02e Merge tag 'x86_core_for_v5.16_rc1' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging wireless-drivers-next/master (d1e69b5492d1 wilc1000: remove '-Wunus=
ed-but-set-variable' warning in chip_wakeup())
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
Merging drm/drm-next (c18c8891111b Merge tag 'drm-misc-next-2021-11-18' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-misc/for-linux-next (69d846126e16 drm: Fix build error caused b=
y missing drm_nomodeset.o)
Merging amdgpu/drm-next (c8d265840be6 drm/amdgpu/UAPI: add new CTX OP for s=
etting profile modes)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
Merging drm-intel/for-linux-next (86c82c8aeebf Revert "drm/i915/dg2: Tile 4=
 plane format support")
Merging drm-intel-gt/for-linux-next-gt (3ccadbce8543 drm/i915/gemfs: don't =
mark huge_opt as static)
Merging drm-tegra/drm/tegra/for-next (cef3fb370da3 drm/tegra: Mark nvdec PM=
 functions as __maybe_unused)
CONFLICT (content): Merge conflict in drivers/gpu/drm/tegra/gem.c
Merging drm-msm/msm-next (afece15a68dc drm: msm: fix building without CONFI=
G_COMMON_CLK)
Merging imx-drm/imx-drm/next (20fbfc81e390 drm/imx: imx-tve: Make use of th=
e helper function devm_platform_ioremap_resource())
Merging etnaviv/etnaviv/next (81fd23e2b3cc drm/etnaviv: Implement mmap as G=
EM object function)
Merging regmap/for-next (02d6fdecb9c3 regmap: allow to define reg_update_bi=
ts for no bus configuration)
Merging sound/for-next (7c72665c5667 ALSA: led: Use restricted type for ifa=
ce assignment)
Merging sound-asoc/for-next (335302dbc2e4 ASoC: SOF: Fixes for Intel HD-Aud=
io DMA stopping)
CONFLICT (content): Merge conflict in sound/soc/sof/intel/hda.c
Merging modules/modules-next (ced75a2f5da7 MAINTAINERS: Add Luis Chamberlai=
n as modules maintainer)
Merging input/next (744d0090a5f6 Input: iforce - fix control-message timeou=
t)
Merging block/for-next (8452a38ac0fd Merge branch 'for-5.17/block' into for=
-next)
CONFLICT (content): Merge conflict in block/bdev.c
Merging device-mapper/for-next (1b8d2789dad0 dm btree remove: fix use after=
 free in rebalance_children())
Merging libata/for-next (cac7e8b5f5fa ata: libata-sata: Declare ata_ncq_sde=
v_attrs static)
Merging pcmcia/pcmcia-next (e39cdacf2f66 pcmcia: i82092: fix a null pointer=
 dereference bug)
Merging mmc/next (967a0b2f17d3 mmc: dw_mmc: exynos: use common_caps)
Merging mfd/for-mfd-next (5dc6dafe6209 mfd: simple-mfd-i2c: Select MFD_CORE=
 to fix build error)
Merging backlight/for-backlight-next (3976e974df1f video: backlight: ili932=
0: Make ili9320_remove() return void)
Merging battery/for-next (0525f34d0275 power: supply: ab8500: Standardize c=
apacity lookup)
Merging regulator/for-next (f8843e5e2dc8 regulator: qcom_spmi: Add pm8226 r=
egulators)
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
Merging devicetree/for-next (3cd6bab2f81d of: property: fw_devlink: Fixup b=
ehaviour when 'node_not_dev' is set)
Merging mailbox/mailbox-for-next (97961f78e8bc mailbox: imx: support i.MX8U=
LP S4 MU)
Merging spi/for-next (f89d2cc3967a spi: tegra210-quad: use devm call for cd=
ata memory)
Merging tip/auto-latest (b1b6b42a35e7 Merge branch 'locking/core')
Applying: Revert "futex: Remove futex_cmpxchg detection"
Applying: Revert "futex: Ensure futex_atomic_cmpxchg_inatomic() is present"
Merging clockevents/timers/drivers/next (eda9a4f7af6e clocksource/drivers/t=
imer-ti-dm: Select TIMER_OF)
Merging edac/edac-for-next (a9e6b3819b36 dt-bindings: memory: Add entry for=
 version 3.80a)
Merging irqchip/irq/irqchip-next (11e45471abea Merge branch irq/misc-5.16 i=
nto irq/irqchip-next)
Merging ftrace/for-next (a55f224ff5f2 tracing: Fix pid filtering when trigg=
ers are attached)
Merging rcu/rcu/next (124a6590f96c rcu/nocb: Merge rcu_spawn_cpu_nocb_kthre=
ad() and rcu_spawn_one_nocb_kthread())
Merging kvm/next (da1bfd52b930 KVM: x86: Drop arbitrary KVM_SOFT_MAX_VCPUS)
Merging kvm-arm/next (5a2acbbb0179 Merge branch kvm/selftests/memslot into =
kvmarm-master/next)
Merging kvms390/next (3fd8417f2c72 KVM: s390: add debug statement for diag =
318 CPNC data)
Merging xen-tip/linux-next (00db58cf2118 xen: make HYPERVISOR_set_debugreg(=
) always_inline)
Merging percpu/for-next (a81a52b325ec Merge branch 'for-5.14-fixes' into fo=
r-next)
Merging workqueues/for-next (f9eaaa82b474 workqueue: doc: Call out the non-=
reentrance conditions)
Merging drivers-x86/for-next (c15f86856bec platform/x86: thinkpad_acpi: Acc=
ept ibm_init_struct.init() returning -ENODEV)
Merging chrome-platform/for-next (297d34e73d49 platform/chrome: cros_ec_pro=
to: Use ec_command for check_features)
Merging hsi/for-next (a1ee1c08fcd5 HSI: core: Fix return freed object in hs=
i_new_client)
Merging leds/for-next (2c702b9c8e9b dt-bindings: leds: Replace moonlight wi=
th indicator in mt6360 example)
Merging ipmi/for-next (29dbee57174a ipmi: Add the git repository to the MAI=
NTAINERS file)
Merging driver-core/driver-core-next (2043727c2882 driver core: platform: M=
ake use of the helper function dev_err_probe())
Merging usb/usb-next (c4bc515d73b5 usb: dwc2: gadget: use existing helper)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (136057256686 Linux 5.16-rc2)
Merging usb-chipidea-next/for-usb-next (78665f57c3fa usb: chipidea: udc: ma=
ke controller hardware endpoint primed)
Merging tty/tty-next (3f19fed8d0da Documentation: add TTY chapter)
Merging char-misc/char-misc-next (cd455ebb748c most: usb: replace snprintf =
in show functions with sysfs_emit)
Merging extcon/extcon-next (9e6ef3a25e5e dt-bindings: extcon: usbc-tusb320:=
 Add TUSB320L compatible string)
Merging phy-next/next (77ba6e7ffbd8 phy: stm32: adopt dev_err_probe for reg=
ulators)
Merging soundwire/next (bb349fd2d580 soundwire: qcom: remove redundant vers=
ion number read)
Merging thunderbolt/next (136057256686 Linux 5.16-rc2)
Merging vfio/next (3bf1311f351e vfio/ccw: Convert to use vfio_register_emul=
ated_iommu_dev())
Merging staging/staging-next (84c365f8ff8f staging: r8188eu: remove the _ca=
ncel_workitem_sync wrapper)
Merging iio/togreg (7d71d289e1ba iio: light: ltr501: Added ltr303 driver su=
pport)
Merging mux/for-next (3516bd729358 Merge tag 's390-5.11-3' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/s390/linux)
Merging icc/icc-next (91f83ea3491e Merge branch 'icc-msm8996' into icc-next)
Merging dmaengine/next (7eafa6eed7f1 dmaengine: ppc4xx: remove unused varia=
ble `rval')
Merging cgroup/for-next (588e5d876648 cgroup: bpf: Move wrapper for __cgrou=
p_bpf_*() to kernel/bpf/cgroup.c)
Merging scsi/for-next (069dd8d37475 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (659109a45c6c scsi: ufs: Fix double space in SCSI=
_UFS_HWMON description)
Merging vhost/linux-next (4bd5d4c69825 iommu/virtio: Support identity-mappe=
d domains)
Merging rpmsg/for-next (612de6839c55 Merge branches 'rpmsg-next' and 'rproc=
-next' into for-next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (ea708ac5bf41 gpio: xlp: Remove Netlogic XL=
P variants)
$ git reset --hard HEAD^
Merging next-20211115 version of gpio-brgl
Merging gpio-intel/for-next (be3dc15ffe64 gpiolib: acpi: Unify debug and ot=
her messages format)
Merging gpio-sim/gpio/gpio-sim (5065e08e4ef3 gpio: sim: fix missing unlock =
on error in gpio_sim_config_commit_item())
CONFLICT (content): Merge conflict in tools/testing/selftests/gpio/Makefile
Merging pinctrl/for-next (2c1aa55d819d Merge branch 'devel' into for-next)
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
Merging kselftest/next (a21296a51119 selftests: clone3: clone3: add case CL=
ONE3_ARGS_NO_TEST)
Merging livepatching/for-next (cd2d68f2d6b2 Merge branch 'for-5.15/cpu-hotp=
lug' into for-next)
Merging coresight/next (66bd1333abd7 Documentation: coresight: Fix document=
ation issue)
Merging rtc/rtc-next (fa55b7dcdc43 Linux 5.16-rc1)
Merging nvdimm/libnvdimm-for-next (e765f13ed126 nvdimm/pmem: move dax_attri=
bute_group from dax to pmem)
Merging at24/at24/for-next (fa55b7dcdc43 Linux 5.16-rc1)
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
Merging xarray/main (2c7e57a02708 idr test suite: Improve reporting from id=
r_find_test_1)
Merging hyperv/hyperv-next (285f68afa8b2 x86/hyperv: Protect set_hv_tscchan=
ge_cb() against getting preempted)
Merging auxdisplay/auxdisplay (4daa9ff89ef2 auxdisplay: charlcd: checking f=
or pointer reference before dereferencing)
Merging kgdb/kgdb/for-next (b77dbc86d604 kdb: Adopt scheduler's task classi=
fication)
Merging hmm/hmm (6880fa6c5660 Linux 5.15-rc1)
Merging fpga/for-next (8886a579744f fpga: region: Use standard dev_release =
for class driver)
Merging kunit/test (fa55b7dcdc43 Linux 5.16-rc1)
Merging cfi/cfi/next (baaf965f9430 mtd: hyperbus: rpc-if: fix bug in rpcif_=
hb_remove)
Merging kunit-next/kunit (fa55b7dcdc43 Linux 5.16-rc1)
Merging trivial/for-next (9ff9b0d392ea Merge tag 'net-next-5.10' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/netdev/net-next)
Merging mhi/mhi-next (77c0bbfcd2ea mhi: pci_generic: Graceful shutdown on f=
reeze)
Merging memblock/for-next (e888fa7bb882 memblock: Check memory add/cap orde=
ring)
Merging init/init-user-pointers (38b082236e77 initramfs: use vfs_utimes in =
do_copy)
Merging counters/counters (e71ba9452f0b Linux 5.11-rc2)
Merging rust/rust-next (988f45dfe7ea MAINTAINERS: Rust)
CONFLICT (content): Merge conflict in scripts/kconfig/confdata.c
CONFLICT (content): Merge conflict in scripts/Makefile.modfinal
CONFLICT (content): Merge conflict in Makefile
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
Merging akpm-current/current (e0fecc6cf633 configs: introduce debug.config =
for CI-like setup)
Applying: mm: kasan: fix VM_DELAY_KMEMLEAK typo
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (5a362df0f3f5 lib/stackdepot: allow optional init and s=
tack_table allocation by kvmalloc() - fixup3)

--Sig_/asX/qlOxu4uX=3yC5NinvMR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGkhskACgkQAVBC80lX
0Gx7bAgAoL8Y0d8UiQVlWNrmGRDGkKflxv83pwOfyz2Oxkf8/cj+7OHOOllvZVBg
VbqFw1vvuhvgQl2m5/qsugCv2g2Mkw24YNO3UxLVcLJ4cu57iByVU6WUje4iNMJE
4V+GylhNjTX3lH1rZIfsXXnVxCP/BRFICTSbKf+6FEE7dA5rO8TAgTUGuYl5VKwT
fD+Je6dozbq+FYTtp5BT5u74/L7WZYZObyvoUGstLrDxuBHUZmcU478biFFCYVw2
HNcf6r71KNbIWO4e7yrxR6tblpHRCSyd4lJGQPMhd225TGUauy6P7s/QiWiRAMfA
961ni7pB7Q6UaCeWDKnEdMErti2dsQ==
=UIRK
-----END PGP SIGNATURE-----

--Sig_/asX/qlOxu4uX=3yC5NinvMR--
