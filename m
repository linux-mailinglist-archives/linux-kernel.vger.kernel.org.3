Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6708E4FEE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiDMF1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiDMF1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:27:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B015B101DE;
        Tue, 12 Apr 2022 22:25:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KdWJ52Nm5z4xLV;
        Wed, 13 Apr 2022 15:25:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649827509;
        bh=BmcvtS2T8dJ6JA8wE50tWkI0KynKfNsP5EciK/anPkg=;
        h=Date:From:To:Cc:Subject:From;
        b=lwuJQ6w08q1ZBWkRP3j7TdkKLfMdoSANOjd/3nQWj6zTBaczsxKejArD7pbRkZUaw
         aV8/MoAcQFAF13EYOE9ep7Lu/O4mNVb5NT9BmN2mLvwB8RIZEb3MeZtbywqegAc5n6
         mq42SII2hFG0LPacRBnA41pxrDNkx3wL3xaEkG3+1XK0FvLRD92EwscldXt5WXXGbr
         DTFN0T/MoCimMf4GK1Ddj6d8fktrvC+4Rp8h5A6Mj3b2+IAsw3HUWNk22EY078Cnr5
         B//arIKYQkSc7g+FKgx8bgAxtZttvePyhKU8m4ZT6f6qwUQlzI0owCEQD/6uNfSsNd
         ZiMHkIQFqxezg==
Date:   Wed, 13 Apr 2022 15:25:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 13
Message-ID: <20220413152508.5b21b54d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vByMfmy/=a7nQA3lXr7Mohm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vByMfmy/=a7nQA3lXr7Mohm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20220412:

The amdgpu tree gained a build failure so I used the version from
next-20220412.

The drm-msm tree gained a conflict against Linus' tree.

The kvm tree gained a conflict against the kvm-fixes tree.

Non-merge commits (relative to Linus' tree): 3471
 4161 files changed, 155555 insertions(+), 71412 deletions(-)

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

I am currently merging 343 trees (counting Linus' and 93 trees of bug
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
Merging origin/master (ce522ba9ef7e Linux 5.18-rc2)
Merging fixes/fixes (d06c942efea4 Merge tag 'for_linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/mst/vhost)
Merging kbuild-current/fixes (312310928417 Linux 5.18-rc1)
Merging arc-current/for-curr (e783362eb54c Linux 5.17-rc1)
Merging arm-current/fixes (9be4c88bb792 ARM: 9191/1: arm/stacktrace, kasan:=
 Silence KASAN warnings in unwind_frame())
Merging arm64-fixes/for-next/fixes (d02b4dd84e1a perf/imx_ddr: Fix undefine=
d behavior due to shift overflowing the constant)
Merging arm-soc-fixes/arm/fixes (475acef9ed48 Merge tag 'reset-fixes-for-v5=
.18' of git://git.pengutronix.de/pza/linux into arm/fixes)
Merging drivers-memory-fixes/fixes (dd8adc713b16 memory: fsl_ifc: populate =
child nodes of buses and mfd devices)
Merging tee-fixes/fixes (98268f2a2a9f Merge branch 'optee_ffa_probe_fix_for=
_v5.18' into fixes)
Merging m68k-current/for-linus (0d52a01a266b m68k: defconfig: Disable fbdev=
 on Sun3/3x)
Merging powerpc-fixes/fixes (ce522ba9ef7e Linux 5.18-rc2)
Merging s390-fixes/fixes (c68c63429319 s390: enable CONFIG_HARDENED_USERCOP=
Y in debug_defconfig)
Merging sparc/master (05a59d79793d Merge git://git.kernel.org:/pub/scm/linu=
x/kernel/git/netdev/net)
Merging fscrypt-current/for-stable (80f6e3080bfc fs-verity: fix signed inte=
ger overflow with i_size near S64_MAX)
Merging net/master (625e8cb8e0e7 Merge git://git.kernel.org/pub/scm/linux/k=
ernel/git/netfilter/nf)
Merging bpf/master (425d239379db bpf: Fix release of page_pool in BPF_PROG_=
RUN in test runner)
Merging ipsec/master (748b82c23e25 xfrm: Pass flowi_oif or l3mdev as oif to=
 xfrm_dst_lookup)
Merging netfilter/master (05ae2fba821c netfilter: nft_socket: make cgroup m=
atch work in input too)
Merging ipvs/master (05ae2fba821c netfilter: nft_socket: make cgroup match =
work in input too)
Merging wireless/main (fb4bccd863cc mac80211: fix ht_capa printout in debug=
fs)
Merging rdma-fixes/for-rc (ce522ba9ef7e Linux 5.18-rc2)
Merging sound-current/for-linus (f20ae5074dfb ALSA: nm256: Don't call card =
private_free at probe error path)
Merging sound-asoc-fixes/for-linus (590c22b926d9 Merge remote-tracking bran=
ch 'asoc/for-5.17' into asoc-linus)
Merging regmap-fixes/for-linus (312310928417 Linux 5.18-rc1)
Merging regulator-fixes/for-linus (908b768f9a8f MAINTAINERS: Fix reviewer i=
nfo for a few ROHM ICs)
Merging spi-fixes/for-linus (317c2045618c spi: spi-mtk-nor: initialize spi =
controller after resume)
Merging pci-current/for-linus (92597f97a40b PCI/PM: Avoid putting Elo i2 PC=
Ie Ports in D3cold)
Merging driver-core.current/driver-core-linus (ce522ba9ef7e Linux 5.18-rc2)
Merging tty.current/tty-linus (ce522ba9ef7e Linux 5.18-rc2)
Merging usb.current/usb-linus (b3fa25de31fb usb: cdns3: Fix issue for clear=
 halt endpoint)
Merging usb-gadget-fixes/fixes (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial-fixes/usb-linus (312310928417 Linux 5.18-rc1)
Merging phy/fixes (a9f17d0c0778 phy: ti: tusb1210: Fix an error handling pa=
th in tusb1210_probe())
Merging staging.current/staging-linus (ce522ba9ef7e Linux 5.18-rc2)
Merging iio-fixes/fixes-togreg (de3b9fe9609a iio:dac:ad3552r: Fix an IS_ERR=
() vs NULL check)
Merging counter-fixes/fixes-togreg (4a14311a3b93 counter: Stop using dev_ge=
t_drvdata() to get the counter device)
Merging char-misc.current/char-misc-linus (ce522ba9ef7e Linux 5.18-rc2)
Merging soundwire-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging thunderbolt-fixes/fixes (ce522ba9ef7e Linux 5.18-rc2)
Merging input-current/for-linus (fd0a4b39870d Input: cypress-sf - register =
a callback to disable the regulators)
Merging crypto-current/master (aa8e73eed7d3 crypto: x86/sm3 - Fixup SLS)
Merging vfio-fixes/for-linus (8704e8934908 vfio/pci: Fix OpRegion read)
Merging kselftest-fixes/fixes (ce64763c6385 testing/selftests/mqueue: Fix m=
q_perf_tests to free the allocated cpu set)
Merging modules-fixes/modules-linus (dc0ce6cc4b13 lib/test: use after free =
in register_test_dev_kmod())
Merging dmaengine-fixes/fixes (ddaa646cb693 dmaengine: dw-edma: Fix unalign=
ed 64bit access)
Merging backlight-fixes/for-backlight-fixes (a38fd8748464 Linux 5.12-rc2)
Merging mtd-fixes/mtd/fixes (9fe4e0d3cbfe mtd: rawnand: fix ecc parameters =
for mt7622)
Merging mfd-fixes/for-mfd-fixes (a61f4661fba4 mfd: intel_quark_i2c_gpio: Re=
vert "Constify static struct resources")
Merging v4l-dvb-fixes/fixes (3ae87d2f25c0 media: si2157: unknown chip versi=
on Si2147-A30 ROM 0x50)
Merging reset-fixes/reset/fixes (03cb66463b55 dt-bindings: reset: Add paren=
t "resets" property as optional)
Merging mips-fixes/mips-fixes (312310928417 Linux 5.18-rc1)
Merging at91-fixes/at91-fixes (26077968f838 dt-bindings: ARM: at91: update =
maintainers entry)
Merging omap-fixes/fixes (da2308ee47ea ARM: dts: logicpd-som-lv: Fix wrong =
pinmuxing on OMAP35)
Merging kvm-fixes/master (42dcbe7d8bac KVM: x86: hyper-v: Avoid writing to =
TSC page without an active vCPU)
Merging kvms390-fixes/master (0e9ff65f455d KVM: s390: preserve deliverable_=
mask in __airqs_kick_single_vcpu)
Merging hwmon-fixes/hwmon (7b2666ce445c hwmon: (adt7470) Fix warning on mod=
ule removal)
Merging nvdimm-fixes/libnvdimm-fixes (d28820419ca3 cxl/pci: Drop shadowed v=
ariable)
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
Merging devicetree-fixes/dt/linus (5dc6ce767dc8 dt-bindings: gpu: mali-bifr=
ost: Document RZ/V2L SoC)
Merging scsi-fixes/fixes (70a3baeec4e8 scsi: iscsi: MAINTAINERS: Add Mike C=
hristie as co-maintainer)
Merging drm-fixes/drm-fixes (88711fa9a14f Merge tag 'drm-misc-fixes-2022-04=
-07' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging amdgpu-fixes/drm-fixes (2c409ba81be2 drm/radeon: fix si_enable_smc_=
cac() failed issue)
Merging drm-intel-fixes/for-linux-next-fixes (1acb34e7dd77 drm/i915: Sunset=
 igpu legacy mmap support based on GRAPHICS_VER_FULL)
Merging mmc-fixes/fixes (ce522ba9ef7e Linux 5.18-rc2)
Merging rtc-fixes/rtc-fixes (bd33335aa93d rtc: cmos: Disable irq around dir=
ect invocation of cmos_interrupt())
Merging gnss-fixes/gnss-linus (312310928417 Linux 5.18-rc1)
Merging hyperv-fixes/hyperv-fixes (eaa03d345358 Drivers: hv: vmbus: Replace=
 smp_store_mb() with virt_store_mb())
Merging soc-fsl-fixes/fix (a222fd854139 soc: fsl: qe: Check of ioremap retu=
rn value)
Merging risc-v-fixes/fixes (312310928417 Linux 5.18-rc1)
Merging pidfd-fixes/fixes (03ba0fe4d09f file: simplify logic in __close_ran=
ge())
Merging fpga-fixes/fixes (f443e374ae13 Linux 5.17)
Merging spdx/spdx-linus (312310928417 Linux 5.18-rc1)
Merging gpio-brgl-fixes/gpio/for-current (ce522ba9ef7e Linux 5.18-rc2)
Merging gpio-intel-fixes/fixes (0c2cae09a765 gpiolib: acpi: Convert type fo=
r pin to be unsigned)
Merging pinctrl-intel-fixes/fixes (0be0b70df661 pinctrl: alderlake: Fix reg=
ister offsets for ADL-N variant)
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
Merging cel-fixes/for-rc (4d5004451ab2 SUNRPC: Fix the svc_deferred_event t=
race class)
Merging irqchip-fixes/irq/irqchip-fixes (544808f7e21c irqchip/gic, gic-v3: =
Prevent GSI to SGI translations)
Merging renesas-fixes/fixes (432b52eea3dc ARM: shmobile: defconfig: Restore=
 graphical consoles)
Merging perf-current/perf/urgent (1862a69c9174 Merge tag 'perf-tools-fixes-=
for-v5.18-2022-04-09' of git://git.kernel.org/pub/scm/linux/kernel/git/acme=
/linux)
Merging efi-fixes/urgent (9feaf8b387ee efi: fix return value of __setup han=
dlers)
Merging zstd-fixes/zstd-linus (88a309465b3f lib: zstd: clean up double word=
 in comment.)
Merging drm-misc-fixes/for-linux-next-fixes (1ecc0c09f19f dt-bindings: disp=
lay: panel: mipi-dbi-spi: Make width-mm/height-mm mandatory)
Merging kbuild/for-next (7972d49b8f70 kbuild: refactor cmd_modversions_S)
Merging perf/perf/core (41204da4c160 perf test: Shell - Limit to only run e=
xecutable scripts in tests)
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
Merging arm-soc/for-next (4f89447fda72 Merge branch 'arm/multiplatform' int=
o for-next)
CONFLICT (content): Merge conflict in arch/arm/Kconfig
Merging actions/for-next (444d018d8d38 ARM: dts: owl-s500-roseapplepi: Add =
ATC2603C PMIC)
Merging amlogic/for-next (ed532523b458 Merge branch 'v5.18/fixes' into for-=
next)
Merging aspeed/for-next (d9540eeaa3d1 Merge branches 'nuvoton-dt-for-v5.18'=
 and 'dt-for-v5.18' into for-next)
Merging at91/at91-next (a845fa592554 Merge branch 'clk-at91' into at91-next)
Merging drivers-memory/for-next (29a87eaccf7e Merge branch 'mem-ctrl-next' =
into for-next)
Merging imx-mxs/for-next (6f46416f472d Merge branch 'imx/dt64' into for-nex=
t)
Merging keystone/next (cb293d3b430e Merge branch 'for_5.15/drivers-soc' int=
o next)
Merging mediatek/for-next (6ceb6a96db4e Merge branch 'v5.17-fixes' into for=
-next)
Merging mvebu/for-next (8885ae5142a4 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (e3c2b4ec8dd3 Merge branch 'fixes' into for-next)
Merging qcom/for-next (0f21291d204b Merge branches 'arm64-for-5.19', 'arm64=
-defconfig-for-5.19', 'defconfig-for-5.19', 'drivers-for-5.19', 'dts-for-5.=
19' and 'arm64-fixes-for-5.18' into for-next)
Merging raspberrypi/for-next (c5915b53d4c2 dt-bindings: soc: bcm: Convert b=
rcm,bcm2835-vchiq to json-schema)
Merging renesas/next (18b3b4968658 Merge branch 'renesas-arm-dt-for-v5.19' =
into renesas-next)
Merging reset/reset/next (3f7bdc13154a dt-bindings: reset: uniphier-glue: C=
lean up clocks, resets, and their names using compatible string)
Merging rockchip/for-next (80ff2eb434b6 Merge branch 'v5.18-armsoc/dtsfixes=
' into for-next)
Merging samsung-krzk/for-next (e7d40b416c50 Merge branch 'next/dt' into for=
-next)
Merging scmi/for-linux-next (da005f876630 Merge tag 'scmi-fixes-5.18' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-lin=
ux-next)
Merging stm32/stm32-next (73ab99aad50c ARM: dts: stm32: Switch DWMAC RMII c=
lock to MCO2 on DHCOM)
Merging sunxi/sunxi/for-next (dd8742e8a17d Merge branch 'sunxi/dt-for-5.19'=
 into sunxi/for-next)
Merging tee/next (17522923771d Merge branch 'fixes' into next)
Merging tegra/for-next (aee7f609222b Merge branch for-5.19/arm64/dt into fo=
r-next)
Merging ti/ti-next (f25d2b2b5541 soc: ti: pruss: using pm_runtime_resume_an=
d_get instead of pm_runtime_get_sync)
Merging xilinx/for-next (312310928417 Linux 5.18-rc1)
Merging clk/clk-next (312310928417 Linux 5.18-rc1)
Merging clk-imx/for-next (2759f38b6c95 clk: imx: scu: fix a potential memor=
y leak in __imx_clk_gpr_scu())
Merging clk-renesas/renesas-clk (9d18f81b3535 clk: renesas: r8a77995: Add R=
PC clocks)
Merging clk-samsung/for-next (45bd8166a1d8 clk: samsung: Add initial Exynos=
7885 clock driver)
Merging csky/linux-next (1bf992059be3 csky: atomic: Add custom atomic.h imp=
lementation)
Merging m68k/for-next (05d51e42df06 m68k: Introduce a virtual m68k machine)
Merging m68knommu/for-next (312310928417 Linux 5.18-rc1)
Merging microblaze/next (312310928417 Linux 5.18-rc1)
Merging mips/mips-next (312310928417 Linux 5.18-rc1)
Merging nios2/for-next (7f7bc20bc41a nios2: Don't use _end for calculating =
min_low_pfn)
Merging openrisc/for-next (862cf8d5fd98 openrisc/boot: Remove unnecessary i=
nitialisation in memcpy().)
Merging parisc-hd/for-next (e34799ccc126 parisc: Change MAX_ADDRESS to beco=
me unsigned long long)
Merging powerpc/next (ce522ba9ef7e Linux 5.18-rc2)
Merging soc-fsl/next (1ce93cb102e7 soc: fsl: qe: Check of ioremap return va=
lue)
Merging risc-v/for-next (312310928417 Linux 5.18-rc1)
Merging s390/for-next (270a62595741 Merge branch 'fixes' into for-next)
Merging sh/for-next (8518e694203d sh: pgtable-3level: Fix cast to pointer f=
rom integer of different size)
Merging sparc-next/master (dd0d718152e4 Merge tag 'spi-fix-v5.8-rc2' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi)
Merging uml/linux-next (82017457957a um: run_helper: Write error message to=
 kernel log on exec failure on host)
Merging xtensa/xtensa-for-next (a524d1566e0f xtensa: patch_text: Fixup last=
 cpu should be master)
Merging pidfd/for-next (6009ff9e8020 Merge branch 'fs.mount_setattr.fixes' =
into for-next)
Merging fscrypt/master (cdaa1b1941f6 fscrypt: update documentation for dire=
ct I/O support)
Merging fscache/fscache-next (312310928417 Linux 5.18-rc1)
Merging afs/afs-next (26291c54e111 Linux 5.17-rc2)
Merging btrfs/for-next (9cff4a31dd1f Merge branch 'for-next-next-v5.18-2022=
0412' into for-next-20220412)
Merging ceph/master (c4ffd8a5eb94 ceph: remove incorrect session state chec=
k)
Merging cifs/for-next (71eec3e11499 cifs: potential buffer overflow in hand=
ling symlinks)
Merging configfs/for-next (84ec758fb2da configfs: fix a race in configfs_{,=
un}register_subsystem())
Merging ecryptfs/next (682a8e2b41ef Merge tag 'ecryptfs-5.13-rc1-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs)
Merging erofs/dev (a1108dcd9373 erofs: rename ctime to mtime)
Merging exfat/dev (1d404b899e32 exfat: reduce block requests when zeroing a=
 cluster)
Merging ext3/for_next (f06e95c3a4ca Merge fsnotify cleanup from Bang Li.)
Merging ext4/dev (c7cded845fc1 ext4: truncate during setxattr leads to kern=
el panic)
Merging f2fs/dev (519129040766 Merge tag 'for-5.18-tag' of git://git.kernel=
.org/pub/scm/linux/kernel/git/kdave/linux)
Merging fsverity/fsverity (07c99001312c fs-verity: support reading signatur=
e with ioctl)
Merging fuse/for-next (0c4bcfdecb1a fuse: fix pipe buffer lifetime for dire=
ct_io)
Merging gfs2/for-next (1b2de0791571 gfs2: Mark the remaining process-indepe=
ndent glock holders as GL_NOPID)
Merging jfs/jfs-next (a53046291020 jfs: prevent NULL deref in diFree)
Merging ksmbd/ksmbd-for-next (edf5f0548fbb ksmbd: replace usage of found wi=
th dedicated list iterator variable)
Merging nfs/linux-next (ff053dbbaffe SUNRPC: Move the call to xprt_send_pag=
edata() out of xprt_sock_sendmsg())
Merging nfs-anna/linux-next (d19e0183a883 NFS: Do not report writeback erro=
rs in nfs_getattr())
Merging nfsd/for-next (ac8fd16a030c fs/lock: add helper locks_owner_has_blo=
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
Merging xfs/for-next (ce522ba9ef7e Linux 5.18-rc2)
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
Merging hid/for-next (e668210e6244 Merge branch 'for-5.18/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (312310928417 Linux 5.18-rc1)
Merging i3c/i3c/next (6cbf8b38dfe3 i3c: fix uninitialized variable use in i=
2c setup)
Merging dmi/dmi-for-next (f97a2103f1a7 firmware: dmi: Move product_sku info=
 to the end of the modalias)
Merging hwmon-staging/hwmon-next (9a282ff1f384 hwmon: (intel-m10-bmc-hwmon)=
 use devm_hwmon_sanitize_name())
Merging jc_docs/docs-next (4407cca0109c docs/zh_CN: Add schedutil Chinese t=
ranslation)
Merging v4l-dvb/master (312310928417 Linux 5.18-rc1)
Merging v4l-dvb-next/master (535f49a9e1f9 media: platform: imx-mipi-csis: A=
dd dependency on VIDEO_DEV)
Merging pm/linux-next (2f7fc67b4d3f Merge branch 'thermal-int340x' into lin=
ux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (f2d9973abd73 cpufreq: mediatek:=
 Enable clocks and regulators)
Merging cpupower/cpupower (312310928417 Linux 5.18-rc1)
Merging devfreq/devfreq-next (93515220624f PM / devfreq: rk3399_dmc: Avoid =
static (reused) profile)
Merging opp/opp/linux-next (543256d239b4 PM: opp: simplify with dev_err_pro=
be())
Merging thermal/thermal/linux-next (1379d28e840f thermal: rcar_thermal: Use=
 platform_get_irq_optional() to get the interrupt)
Merging ieee1394/for-next (54b3bd99f094 firewire: nosy: switch from 'pci_' =
to 'dma_' API)
Merging dlm/next (e425ac99b157 fs: dlm: cast resource pointer to uintptr_t)
Merging rdma/for-next (98c8026331ce RDMA/rxe: Remove reliable datagram supp=
ort)
Merging net-next/master (f45ba67eb74a ixp4xx_eth: fix error check return va=
lue of platform_get_irq())
Merging bpf-next/for-next (0f8619929c57 libbpf: Usdt aarch64 arg parsing su=
pport)
Merging ipsec-next/master (b58b1f563ab7 xfrm: rework default policy structu=
re)
Merging mlx5-next/mlx5-next (2984287c4c19 net/mlx5: Remove not-implemented =
IPsec capabilities)
Merging netfilter-next/master (0c7b27616fbd selftests: netfilter: add fib e=
xpression forward test case)
Merging ipvs-next/master (0c7b27616fbd selftests: netfilter: add fib expres=
sion forward test case)
Merging bluetooth/master (38a1944deda4 Bluetooth: btusb: Set HCI_QUIRK_BROK=
EN_ENHANCED_SETUP_SYNC_CONN for QCA)
Merging wireless-next/main (79649041edc8 Merge branch 'wfx-move-out-of-stag=
ing')
Merging mtd/mtd/next (876a45a50a20 dt-bindings: mtd: jedec, spi-nor: remove=
 unneeded properties)
Merging nand/nand/next (51a4a71d974c mtd: rawnand: omap_elm: Add compatible=
 for AM64 ELM)
Merging spi-nor/spi-nor/next (ce522ba9ef7e Linux 5.18-rc2)
Merging crypto/master (7b2206d88092 crypto: cavium/nitrox - remove check of=
 list iterator against head past the loop body)
Merging drm/drm-next (b85ffe47c4ec Merge tag 'drm-misc-next-2022-04-07' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-misc/for-linux-next (62c6f4f9bb08 fbcon: use min() to make code=
 cleaner)
Merging amdgpu/drm-next (01215dfe2a46 drm/amdkfd: Cleanup IO links during K=
FD device removal)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dc.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn10/=
dcn10_hw_sequencer.c
Applying: fix up for "drm/ttm: rework bulk move handling v5"
$ git reset --hard HEAD^
Merging next-20220412 version of amdgpu
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn10/=
dcn10_hw_sequencer.c
[master f51d0a90fd77] next-20220412/amdgpu
Applying: fix up for "drm/ttm: rework bulk move handling v5"
[master c7b089b38ec1] next-20220412/amdgpu
Merging drm-intel/for-linux-next (d999ad1079f5 drm/i915/display/vrr: Reset =
VRR capable property on a long hpd)
Merging drm-tegra/drm/tegra/for-next (b53c24f69199 drm/tegra: Support YVYU,=
 VYUY and YU24 formats)
Merging drm-msm/msm-next (390d645877ff drm/msm/gpu: Avoid -Wunused-function=
 with !CONFIG_PM_SLEEP)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/disp/mdp5/mdp5_pl=
ane.c
Merging imx-drm/imx-drm/next (927d8fd465ad drm/imx: ipuv3-plane: Remove red=
undant color encoding and range initialisation)
Merging etnaviv/etnaviv/next (2829a9fcb738 drm/etnaviv: reap idle softpin m=
appings when necessary)
Merging fbdev/for-next (610323d8f6f8 video: fbdev: mmp: replace usage of fo=
und with dedicated list iterator variable)
Merging regmap/for-next (bd941dfaae35 regmap: Constify static regmap_bus st=
ructs)
Merging sound/for-next (1b6a6fc5280e ALSA: jack: Access input_dev under mut=
ex)
Merging sound-asoc/for-next (341ccba38f5b Merge remote-tracking branch 'aso=
c/for-5.19' into asoc-next)
Merging modules/modules-next (eeaec7801c42 powerpc: Select ARCH_WANTS_MODUL=
ES_DATA_IN_VMALLOC on book3s/32 and 8xx)
Merging input/next (e505edaedcb9 Input: add support for Azoteq IQS7222A/B/C)
Merging block/for-next (019f3ca23fc6 Merge branch 'for-5.19/io_uring-xattr'=
 into for-next)
Merging device-mapper/for-next (7f790f4da003 dm: remove bio polling debug c=
hecks)
Merging libata/for-next (a28c1ab31271 ata: libata-core: fix parameter type =
in ata_xfer_mode2shift())
Merging pcmcia/pcmcia-next (3928cf08334e pcmcia: db1xxx_ss: restrict to MIP=
S_DB1XXX boards)
Merging mmc/next (0dcf1c1a6ec2 dt-bindings: mmc: imx-esdhc: Update compatib=
le fallbacks)
Merging mfd/for-mfd-next (d99460ed5cdc dt-bindings: mfd: syscon: Add microc=
hip,lan966x-cpu-syscon compatible)
Merging backlight/for-backlight-next (023a8830a628 backlight: backlight: Sl=
ighly simplify devm_of_find_backlight())
Merging battery/for-next (c22fca40522e power: ab8500_chargalg: Use CLOCK_MO=
NOTONIC)
Merging regulator/for-next (9ef9f6b9954c Merge remote-tracking branch 'regu=
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
Merging iommu/next (71ff461c3f41 iommu/omap: Fix regression in probe for NU=
LL pointer dereference)
Merging audit/next (312310928417 Linux 5.18-rc1)
Merging devicetree/for-next (b61b76dfef30 dt-bindings: trivial-devices: Doc=
ument CPLD on Menlo boards)
Merging mailbox/mailbox-for-next (1b0d0f7c12d5 dt-bindings: mailbox: add de=
finition for mt8186)
Merging spi/for-next (763bdde329f7 Merge remote-tracking branch 'spi/for-5.=
19' into spi-next)
Merging tip/master (b2f6191f543b Merge x86/cleanups into tip/master)
Merging clockevents/timers/drivers/next (49c14f94ccfe clocksource/drivers/t=
imer-of: check return value of of_iomap in timer_of_base_init())
Merging edac/edac-for-next (65fd006d5e32 Merge branch 'edac-alloc-cleanup' =
into edac-for-next)
Merging irqchip/irq/irqchip-next (de26a7424331 Merge branch irq/qcom-mpm in=
to irq/irqchip-next)
Merging ftrace/for-next (c87857e21486 Merge branch 'trace/for-next-rtla' in=
to trace/for-next)
Merging rcu/rcu/next (e912cedc79ae rcu-tasks: Handle sparse cpu_possible_ma=
sk in rcu_tasks_invoke_cbs())
Merging kvm/next (945024d764a1 KVM: x86: optimize PKU branching in kvm_load=
_{guest|host}_xsave_state)
CONFLICT (content): Merge conflict in arch/x86/kernel/kvm.c
CONFLICT (content): Merge conflict in arch/x86/kvm/x86.c
Merging kvm-arm/next (21ea45784275 KVM: arm64: fix typos in comments)
Merging kvms390/next (4aa5ac75bf79 KVM: s390: Fix lockdep issue in vm memop)
Merging xen-tip/linux-next (262fc47ac174 xen/balloon: don't use PV mode ext=
ra memory for zone device allocations)
Merging percpu/for-next (4e1f82dce05b Merge branch 'for-5.16-fixes' into fo=
r-next)
Merging workqueues/for-next (bc35f7ef9628 workqueue: Convert the type of po=
ol->nr_running to int)
Merging drivers-x86/for-next (b49f72e7f96d platform/x86: think-lmi: Certifi=
cate authentication support)
Merging chrome-platform/for-next (312310928417 Linux 5.18-rc1)
Merging hsi/for-next (43c14f8d18a7 HSI: omap_ssi: Fix refcount leak in ssi_=
probe)
Merging leds/for-next (312310928417 Linux 5.18-rc1)
Merging ipmi/for-next (ae085d7f9365 mm: kfence: fix missing objcg housekeep=
ing for SLAB)
Merging driver-core/driver-core-next (ce522ba9ef7e Linux 5.18-rc2)
Merging usb/usb-next (312310928417 Linux 5.18-rc1)
Merging thunderbolt/next (03941ed91c72 thunderbolt: Replace usage of found =
with dedicated list iterator variable)
Merging usb-gadget/next (e49d033bddf5 Linux 5.12-rc6)
Merging usb-serial/usb-next (312310928417 Linux 5.18-rc1)
Merging tty/tty-next (ce522ba9ef7e Linux 5.18-rc2)
Merging char-misc/char-misc-next (ce522ba9ef7e Linux 5.18-rc2)
Merging coresight/next (ce522ba9ef7e Linux 5.18-rc2)
Merging fpga/for-next (312310928417 Linux 5.18-rc1)
Merging icc/icc-next (52c85167e413 Merge branch 'icc-msm8939' into icc-next)
Merging iio/togreg (b28bc9ebbe23 iio: adc: ti-ads1015: Switch to read_avail)
Merging phy-next/next (6f3652c952d8 phy: qcom-qmp: Add SM6350 UFS PHY suppo=
rt)
Merging soundwire/next (60657fb9b19d dt-bindings: soundwire: qcom: Add bind=
ings for audio clock reset control property)
Merging extcon/extcon-next (4a17c3246de7 extcon: sm5502: Add support for SM=
5703)
Merging gnss/gnss-next (312310928417 Linux 5.18-rc1)
Merging vfio/next (f621eb13facb vfio-pci: Provide reviewers and acceptance =
criteria for variant drivers)
Merging staging/staging-next (908662dc823e Merge 5.18-rc2 into staging-next)
Merging mux/for-next (0fcfb00b28c0 Linux 5.16-rc4)
Merging dmaengine/next (52126d4c0379 dmaengine: Remove a useless mutex)
CONFLICT (content): Merge conflict in drivers/dma/mediatek/mtk-hsdma.c
Merging cgroup/for-next (1be9b7206b7d Merge branch 'for-5.18' into for-next)
Merging scsi/for-next (70c954151828 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (3a6a7187f09a scsi: megaraid_sas: Remove unnecess=
ary memset)
Merging vhost/linux-next (1c80cf031e02 vdpa: mlx5: synchronize driver statu=
s with CVQ)
Merging rpmsg/for-next (b30026f9ff31 Merge branch 'rproc-fixes' into rproc-=
next)
Merging gpio/for-next (7ac554888233 MAINTAINERS: Remove reference to non-ex=
isting file)
Merging gpio-brgl/gpio/for-next (d3bf3dc4bbbf gpio: realtek-otto: Add RTL93=
1x support)
Merging gpio-intel/for-next (9d0d161bce5b pinctrl: samsung: Switch to use f=
or_each_gpiochip_node() helper)
Merging gpio-sim/gpio/gpio-sim (0fcfb00b28c0 Linux 5.16-rc4)
Merging pinctrl/for-next (4a6d01495a16 pinctrl: mediatek: common-v1: fix se=
micolon.cocci warnings)
Merging pinctrl-intel/for-next (0be0b70df661 pinctrl: alderlake: Fix regist=
er offsets for ADL-N variant)
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
Merging rtc/rtc-next (312310928417 Linux 5.18-rc1)
Merging nvdimm/libnvdimm-for-next (ada8d8d337ee nvdimm/blk: Fix title level)
Merging at24/at24/for-next (312310928417 Linux 5.18-rc1)
Merging ntb/ntb-next (5cf4bc46c2f2 IDT: Fix Build warnings on some 32bit ar=
chitectures.)
Merging seccomp/for-next/seccomp (8a3d3ea66f0d selftests/seccomp: Add SKIP =
for failed unshare())
Merging cisco/for-next (9e98c678c2d6 Linux 5.1-rc1)
Merging fsi/next (f2af60bb7ce2 fsi: Add trace events in initialization path)
Merging slimbus/for-next (54bf672111ee slimbus: qcom: Fix IRQ check in qcom=
_slim_probe)
Merging nvmem/for-next (2bd15847668d nvmem: Add Apple eFuse driver)
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
CONFLICT (content): Merge conflict in net/mctp/test/route-test.c
CONFLICT (content): Merge conflict in security/apparmor/policy_unpack_test.c
Merging trivial/for-next (081c8919b02b Documentation: remove trivial tree)
Merging mhi/mhi-next (3a8003436e6a bus: mhi: host: pci_generic: Flush recov=
ery worker during freeze)
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
Merging slab/for-next (229fce873d6e Merge branch 'slab/for-5.19/refactor' i=
nto slab/for-next)
Merging random/master (3f8dfd3db846 random: make random_get_entropy() retur=
n an unsigned long)
Merging landlock/next (312310928417 Linux 5.18-rc1)
Merging rust/rust-next (011150424cd9 rust: avoid all GCC plugins, not just =
the randstruct one)
CONFLICT (content): Merge conflict in Makefile
Merging sysctl/sysctl-next (8e4e83b2278b ftrace: move sysctl_ftrace_enabled=
 to ftrace.c)
Merging folio/for-next (98ea02597b99 mm/rmap: Fix handling of hugetlbfs pag=
es in page_vma_mapped_walk)
Merging execve/for-next/execve (dd664099002d binfmt_elf: Don't write past e=
nd of notes for regset gap)
Merging kspp/for-next/kspp (8a264f718092 Merge branch 'for-next/hardening' =
into for-next/kspp)
Merging kspp-gustavo/for-next/kspp (452d059ea2b6 drm/amd/display: Fix Wstri=
ngop-overflow warnings in dc_link_dp.c)
Merging akpm-current/current (28eee78b3c7a ipc/mqueue: use get_tree_nodev()=
 in mqueue_get_tree())
CONFLICT (content): Merge conflict in arch/x86/mm/Makefile
$ git checkout -b akpm remotes/origin/akpm/master
$ git rebase --onto master remotes/origin/akpm/master-base
Merging akpm/master (cd270c72cdae kselftest/vm: override TARGETS from argum=
ents)

--Sig_/vByMfmy/=a7nQA3lXr7Mohm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJWXrQACgkQAVBC80lX
0Gz6Dwf/a1gjvmMjbWOCejhSHo2qR+neZKd/QoTLhtUoUAlvn72WZJFg2dyNk7/k
liVewHkUquxBFQKPY94YEo+GSflRd93aBrCSwcnxr2gdpxYQvsdfn5pur7wDgxay
tyW4d1OeLs4LYS3BSO9a6kqHaFcDpGQhq+Pi+6p7623CkgL+RlP1PGaGMQJdqukC
mqV1jQgGAp1ehuyU5YT1YYaayYiFC9gE+r5n6ceNwGUs+X28QvEEIUUo1oxRxogm
kizqIQMqpx0rsWGjoN/mrsv6lbIOK8mo2Uw7aNr5t6CuGsAHxVR1Yrm55K3mGmIE
lxOk3MHa7a/V+Ba4o88UBFi6VLFR3A==
=vws6
-----END PGP SIGNATURE-----

--Sig_/vByMfmy/=a7nQA3lXr7Mohm--
