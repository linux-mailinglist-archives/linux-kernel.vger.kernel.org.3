Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B68E4686D0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385315AbhLDR44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:56:56 -0500
Received: from mout.gmx.net ([212.227.15.19]:58187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385207AbhLDR4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638640383;
        bh=CQTpbcTkwpI1WShRMP/7rpqHv6pcod6ezZLJH7h0kvI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=XaxuZnhFL2ug2+nSoBKdEQyP8w+1E1ytWnkPN6cEBIxzqSZM9fsBYfMSMojiooI1V
         lmybBD4336tphjIBGvPcefsbjhMh0IrSsdxfsQVvXC+OTtqRKm9Tsnyq+oUc2tJqSe
         CmmWNPHLoiaJDKaY9xrZ7ZBmo87g6h74mpSPYaTk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lc9-1msk0L39GN-000wXQ; Sat, 04
 Dec 2021 18:53:03 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev
Subject: [PATCH] MAINTAINERS: Sort entries using parse-maintainers.pl
Date:   Sat,  4 Dec 2021 18:52:55 +0100
Message-Id: <20211204175255.1361385-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P6ON1LQVUvgd6blR/8TisxcF4//ov4/jO0UBZl0T7z3tZQQtcjv
 xgpci/ED7zBAZUSTJnE2s85J6wtQeaqC+f8wEuHUTkGVmFQzvXprd/RsSQ0qbG/m/yIadIJ
 q+ystjzAGEpGE0PCaG7RqQ9gAWk/dRRPhEDmybwfks6zbELvRMfFqa2jBbbVMpwC4FRAPuY
 RyP7NhZ3KAG7rlIiVEA8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:661vS+rpPkg=:LXvC1MpFAiakPS7OOtVEQP
 vPLku7qB51yvb6w3oDO2+pUX5qeyfBfTkGOY00u1DqGaILkAevkGmDkPQ0Leo+REM7fkm/ot9
 fsKJAcAc+yS05QJfnZDyVo+EbKvSN+85j8cCe65fCGwhC/Y4jV0sKzQ6YPQSO5Zf+3Yv7Nc0S
 VlUX6WJMXunarsF4DqwmRfJQYYzpt2N1esh989qt/QNnqd3JZ5PH5J/9CLmNDL9gQCYZjC+pX
 M88cUXyEoVr4KaZC3uh63GPrAx86DEihdETuFlJZ4tIsaceOD/eZDCcze4tIJyPP2ZBohGWgS
 vjafDar3LF6DN4spvTIPIgJLz5QtsUu4akNGQiGvblkgOjEKW0ERFuxc+HDgBBZYHajjRInyK
 j7dJ6XXQPPdN5IMs1iiV7UY1fxDfMJYeF0b0q1Oq6ZkIHyGrdgMzR1Qzv2kT6L7e0uZORvsdr
 uo49UltP55JSCW3Eks13B6d1wzuJmZq0DZnIzxtqjDD8tOGj7iQsD0Vgej3+iDsnAhcSI+rFl
 YIZQsEpK8jgx+Yc6T4rwjLWCW2VKcB+pVrLoc74KHOaaG/NtCFzL1bd9zxu7juWNOOtVro23k
 pNf9MVjTaABIVKneacQdqeAtr8Y3aj4q+xPBHbsdVo2cLH4nxCLkiSznibDEo1YuD8fPi7xGe
 /lCKCv/SWejc+rQtNRdzjU+E0YWtNgGa6sdZk3meFZKQnCKd2utowYmQLjbU/4hxVi+LrBX+Y
 CbSHQy7OXWyuArb9aFb5mNRBaLODa4CCpN3JNUiTY4CAzpwl4iGsEM0fG9ylhHDkqrCheBpQq
 JkKkIOunQ0kZr46UpusbFjSHu7szpBJbouTFBx9VzgKj/gwcXb75TLu2LmmUIE3avP5ewAcUT
 VvS4LUEwFgqjJf/S2lSIjJdwMQ+vMjWKEXP7zFKNHZPhV49ef2tzZzmXcQosw+duY638I+zBC
 II6y2KkRFy4QK/bi9DJH4eewRISxB5+DNVnOZY3vzqKaqJcsACaB/c3jXphEcRYPEC+DRNV9Y
 nfZY+it74lwVP5Pqt6NtaaCo2BMcFsZdlpuP7eHd4gx4vbDfI9grITj428T6oW3/i15O84t6m
 akkT1sJggmrjMo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAINTAINERS file got slightly out of order again, making it
difficult to put new entries at the right (alphabetical) position.

Run parse-maintainers.pl to restore the alphabetical order.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

This patch applies cleanly to v5.16-rc3 and can then be cherry-picked
cleanly onto next-20211203, but applying it directly to next-20211203
(with "git am") fails:

  error: patch failed: MAINTAINERS:967
  error: MAINTAINERS: patch does not apply

Checkpatch warns about a few unordered "F:" lines within sections, but I
left those alone because I wanted this patch to be as automated as possibl=
e.
=2D--
 MAINTAINERS | 710 ++++++++++++++++++++++++++--------------------------
 1 file changed, 355 insertions(+), 355 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 360e9aa0205d6..a8ae86e24cac0 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -967,11 +967,6 @@ F:	drivers/gpu/drm/amd/include/v9_structs.h
 F:	drivers/gpu/drm/amd/include/vi_structs.h
 F:	include/uapi/linux/kfd_ioctl.h

-AMD SPI DRIVER
-M:	Sanjay R Mehta <sanju.mehta@amd.com>
-S:	Maintained
-F:	drivers/spi/spi-amd.c
-
 AMD MP2 I2C DRIVER
 M:	Elie Morisse <syniurge@gmail.com>
 M:	Nehal Shah <nehal-bakulchandra.shah@amd.com>
@@ -1006,13 +1001,6 @@ M:	Tom Lendacky <thomas.lendacky@amd.com>
 S:	Supported
 F:	arch/arm64/boot/dts/amd/

-AMD XGBE DRIVER
-M:	Tom Lendacky <thomas.lendacky@amd.com>
-L:	netdev@vger.kernel.org
-S:	Supported
-F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
-F:	drivers/net/ethernet/amd/xgbe/
-
 AMD SENSOR FUSION HUB DRIVER
 M:	Nehal Shah <nehal-bakulchandra.shah@amd.com>
 M:	Basavaraj Natikar <basavaraj.natikar@amd.com>
@@ -1021,6 +1009,18 @@ S:	Maintained
 F:	Documentation/hid/amd-sfh*
 F:	drivers/hid/amd-sfh-hid/

+AMD SPI DRIVER
+M:	Sanjay R Mehta <sanju.mehta@amd.com>
+S:	Maintained
+F:	drivers/spi/spi-amd.c
+
+AMD XGBE DRIVER
+M:	Tom Lendacky <thomas.lendacky@amd.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
+F:	drivers/net/ethernet/amd/xgbe/
+
 AMS AS73211 DRIVER
 M:	Christian Eggers <ceggers@arri.de>
 L:	linux-iio@vger.kernel.org
@@ -1409,6 +1409,16 @@ S:	Maintained
 F:	drivers/net/arcnet/
 F:	include/uapi/linux/if_arcnet.h

+ARM AND ARM64 SoC SUB-ARCHITECTURES (COMMON PARTS)
+M:	Arnd Bergmann <arnd@arndb.de>
+M:	Olof Johansson <olof@lixom.net>
+M:	soc@kernel.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
+F:	arch/arm/boot/dts/Makefile
+F:	arch/arm64/boot/dts/Makefile
+
 ARM ARCHITECTED TIMER DRIVER
 M:	Mark Rutland <mark.rutland@arm.com>
 M:	Marc Zyngier <maz@kernel.org>
@@ -1525,22 +1535,6 @@ S:	Odd Fixes
 F:	drivers/amba/
 F:	include/linux/amba/bus.h

-ARM PRIMECELL PL35X NAND CONTROLLER DRIVER
-M:	Miquel Raynal <miquel.raynal@bootlin.com>
-M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
-L:	linux-mtd@lists.infradead.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
-F:	drivers/mtd/nand/raw/pl35x-nand-controller.c
-
-ARM PRIMECELL PL35X SMC DRIVER
-M:	Miquel Raynal <miquel.raynal@bootlin.com>
-M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yam=
l
-F:	drivers/memory/pl353-smc.c
-
 ARM PRIMECELL CLCD PL110 DRIVER
 M:	Russell King <linux@armlinux.org.uk>
 S:	Odd Fixes
@@ -1558,6 +1552,22 @@ S:	Odd Fixes
 F:	drivers/mmc/host/mmci.*
 F:	include/linux/amba/mmci.h

+ARM PRIMECELL PL35X NAND CONTROLLER DRIVER
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
+M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
+L:	linux-mtd@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
+F:	drivers/mtd/nand/raw/pl35x-nand-controller.c
+
+ARM PRIMECELL PL35X SMC DRIVER
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
+M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yam=
l
+F:	drivers/memory/pl353-smc.c
+
 ARM PRIMECELL SSP PL022 SPI DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -1594,16 +1604,6 @@ F:	Documentation/devicetree/bindings/iommu/arm,smmu=
*
 F:	drivers/iommu/arm/
 F:	drivers/iommu/io-pgtable-arm*

-ARM AND ARM64 SoC SUB-ARCHITECTURES (COMMON PARTS)
-M:	Arnd Bergmann <arnd@arndb.de>
-M:	Olof Johansson <olof@lixom.net>
-M:	soc@kernel.org
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
-F:	arch/arm/boot/dts/Makefile
-F:	arch/arm64/boot/dts/Makefile
-
 ARM SUB-ARCHITECTURES
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -2256,13 +2256,6 @@ F:	arch/arm64/boot/dts/microchip/
 F:	drivers/pinctrl/pinctrl-microchip-sgpio.c
 N:	sparx5

-Microchip Timer Counter Block (TCB) Capture Driver
-M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-L:	linux-iio@vger.kernel.org
-S:	Maintained
-F:	drivers/counter/microchip-tcb-capture.c
-
 ARM/MILBEAUT ARCHITECTURE
 M:	Taichi Sugaya <sugaya.taichi@socionext.com>
 M:	Takao Orito <orito.takao@socionext.com>
@@ -4106,29 +4099,6 @@ W:	https://github.com/Cascoda/ca8210-linux.git
 F:	Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
 F:	drivers/net/ieee802154/ca8210.c

-CANAAN/KENDRYTE K210 SOC FPIOA DRIVER
-M:	Damien Le Moal <damien.lemoal@wdc.com>
-L:	linux-riscv@lists.infradead.org
-L:	linux-gpio@vger.kernel.org (pinctrl driver)
-F:	Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml
-F:	drivers/pinctrl/pinctrl-k210.c
-
-CANAAN/KENDRYTE K210 SOC RESET CONTROLLER DRIVER
-M:	Damien Le Moal <damien.lemoal@wdc.com>
-L:	linux-kernel@vger.kernel.org
-L:	linux-riscv@lists.infradead.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/reset/canaan,k210-rst.yaml
-F:	drivers/reset/reset-k210.c
-
-CANAAN/KENDRYTE K210 SOC SYSTEM CONTROLLER DRIVER
-M:	Damien Le Moal <damien.lemoal@wdc.com>
-L:	linux-riscv@lists.infradead.org
-S:	Maintained
-F:      Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml
-F:	drivers/soc/canaan/
-F:	include/soc/canaan/
-
 CACHEFILES: FS-CACHE BACKEND FOR CACHING ON MOUNTED FILESYSTEMS
 M:	David Howells <dhowells@redhat.com>
 L:	linux-cachefs@redhat.com (moderated for non-subscribers)
@@ -4251,6 +4221,29 @@ F:	Documentation/networking/j1939.rst
 F:	include/uapi/linux/can/j1939.h
 F:	net/can/j1939/

+CANAAN/KENDRYTE K210 SOC FPIOA DRIVER
+M:	Damien Le Moal <damien.lemoal@wdc.com>
+L:	linux-riscv@lists.infradead.org
+L:	linux-gpio@vger.kernel.org (pinctrl driver)
+F:	Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml
+F:	drivers/pinctrl/pinctrl-k210.c
+
+CANAAN/KENDRYTE K210 SOC RESET CONTROLLER DRIVER
+M:	Damien Le Moal <damien.lemoal@wdc.com>
+L:	linux-kernel@vger.kernel.org
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/reset/canaan,k210-rst.yaml
+F:	drivers/reset/reset-k210.c
+
+CANAAN/KENDRYTE K210 SOC SYSTEM CONTROLLER DRIVER
+M:	Damien Le Moal <damien.lemoal@wdc.com>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/canaan,k210-sysctl.yaml
+F:	drivers/soc/canaan/
+F:	include/soc/canaan/
+
 CAPABILITIES
 M:	Serge Hallyn <serge@hallyn.com>
 L:	linux-security-module@vger.kernel.org
@@ -4500,17 +4493,17 @@ F:	drivers/power/supply/cros_usbpd-charger.c
 N:	cros_ec
 N:	cros-ec

-CHROMEOS EC USB TYPE-C DRIVER
-M:	Prashant Malani <pmalani@chromium.org>
-S:	Maintained
-F:	drivers/platform/chrome/cros_ec_typec.c
-
 CHROMEOS EC USB PD NOTIFY DRIVER
 M:	Prashant Malani <pmalani@chromium.org>
 S:	Maintained
 F:	drivers/platform/chrome/cros_usbpd_notify.c
 F:	include/linux/platform_data/cros_usbpd_notify.h

+CHROMEOS EC USB TYPE-C DRIVER
+M:	Prashant Malani <pmalani@chromium.org>
+S:	Maintained
+F:	drivers/platform/chrome/cros_ec_typec.c
+
 CHRONTEL CH7322 CEC DRIVER
 M:	Joe Tessler <jrt@google.com>
 L:	linux-media@vger.kernel.org
@@ -4615,6 +4608,18 @@ M:	Nelson Escobar <neescoba@cisco.com>
 S:	Supported
 F:	drivers/infiniband/hw/usnic/

+CLANG CONTROL FLOW INTEGRITY SUPPORT
+M:	Sami Tolvanen <samitolvanen@google.com>
+M:	Kees Cook <keescook@chromium.org>
+R:	Nathan Chancellor <nathan@kernel.org>
+R:	Nick Desaulniers <ndesaulniers@google.com>
+L:	llvm@lists.linux.dev
+S:	Supported
+B:	https://github.com/ClangBuiltLinux/linux/issues
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-n=
ext/clang/features
+F:	include/linux/cfi.h
+F:	kernel/cfi.c
+
 CLANG-FORMAT FILE
 M:	Miguel Ojeda <ojeda@kernel.org>
 S:	Maintained
@@ -4634,18 +4639,6 @@ F:	scripts/Makefile.clang
 F:	scripts/clang-tools/
 K:	\b(?i:clang|llvm)\b

-CLANG CONTROL FLOW INTEGRITY SUPPORT
-M:	Sami Tolvanen <samitolvanen@google.com>
-M:	Kees Cook <keescook@chromium.org>
-R:	Nathan Chancellor <nathan@kernel.org>
-R:	Nick Desaulniers <ndesaulniers@google.com>
-L:	llvm@lists.linux.dev
-S:	Supported
-B:	https://github.com/ClangBuiltLinux/linux/issues
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-n=
ext/clang/features
-F:	include/linux/cfi.h
-F:	kernel/cfi.c
-
 CLEANCACHE API
 M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 L:	linux-kernel@vger.kernel.org
@@ -5128,6 +5121,13 @@ S:	Supported
 W:	http://www.chelsio.com
 F:	drivers/crypto/chelsio

+CXGB4 ETHERNET DRIVER (CXGB4)
+M:	Raju Rangoju <rajur@chelsio.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+W:	http://www.chelsio.com
+F:	drivers/net/ethernet/chelsio/cxgb4/
+
 CXGB4 INLINE CRYPTO DRIVER
 M:	Ayush Sawal <ayush.sawal@chelsio.com>
 M:	Vinay Kumar Yadav <vinay.yadav@chelsio.com>
@@ -5137,13 +5137,6 @@ S:	Supported
 W:	http://www.chelsio.com
 F:	drivers/net/ethernet/chelsio/inline_crypto/

-CXGB4 ETHERNET DRIVER (CXGB4)
-M:	Raju Rangoju <rajur@chelsio.com>
-L:	netdev@vger.kernel.org
-S:	Supported
-W:	http://www.chelsio.com
-F:	drivers/net/ethernet/chelsio/cxgb4/
-
 CXGB4 ISCSI DRIVER (CXGB4I)
 M:	Karen Xie <kxie@chelsio.com>
 L:	linux-scsi@vger.kernel.org
@@ -5199,16 +5192,6 @@ CYCLADES PC300 DRIVER
 S:	Orphan
 F:	drivers/net/wan/pc300*

-CYPRESS_FIRMWARE MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
-L:	linux-media@vger.kernel.org
-S:	Maintained
-W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
-Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
-F:	drivers/media/common/cypress_firmware*
-
 CYPRESS CY8CTMA140 TOUCHSCREEN DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-input@vger.kernel.org
@@ -5222,6 +5205,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/input/cypress-sf.yaml
 F:	drivers/input/keyboard/cypress-sf.c

+CYPRESS_FIRMWARE MEDIA DRIVER
+M:	Antti Palosaari <crope@iki.fi>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+W:	https://linuxtv.org
+W:	http://palosaari.fi/linux/
+Q:	http://patchwork.linuxtv.org/project/linux-media/list/
+T:	git git://linuxtv.org/anttip/media_tree.git
+F:	drivers/media/common/cypress_firmware*
+
 CYTTSP TOUCHSCREEN DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-input@vger.kernel.org
@@ -5392,14 +5385,12 @@ L:	Dell.Client.Kernel@dell.com
 S:	Maintained
 F:	drivers/platform/x86/dell/dell-wmi-descriptor.c

-DELL WMI SYSMAN DRIVER
-M:	Divya Bharathi <divya.bharathi@dell.com>
-M:	Prasanth Ksr <prasanth.ksr@dell.com>
+DELL WMI HARDWARE PRIVACY SUPPORT
+M:	Perry Yuan <Perry.Yuan@dell.com>
 L:	Dell.Client.Kernel@dell.com
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	Documentation/ABI/testing/sysfs-class-firmware-attributes
-F:	drivers/platform/x86/dell/dell-wmi-sysman/
+F:	drivers/platform/x86/dell/dell-wmi-privacy.c

 DELL WMI NOTIFICATIONS DRIVER
 M:	Matthew Garrett <mjg59@srcf.ucam.org>
@@ -5407,12 +5398,21 @@ M:	Pali Roh=C3=A1r <pali@kernel.org>
 S:	Maintained
 F:	drivers/platform/x86/dell/dell-wmi-base.c

-DELL WMI HARDWARE PRIVACY SUPPORT
-M:	Perry Yuan <Perry.Yuan@dell.com>
+DELL WMI SYSMAN DRIVER
+M:	Divya Bharathi <divya.bharathi@dell.com>
+M:	Prasanth Ksr <prasanth.ksr@dell.com>
 L:	Dell.Client.Kernel@dell.com
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/dell/dell-wmi-privacy.c
+F:	Documentation/ABI/testing/sysfs-class-firmware-attributes
+F:	drivers/platform/x86/dell/dell-wmi-sysman/
+
+DELTA DPS920AB PSU DRIVER
+M:	Robert Marko <robert.marko@sartura.hr>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/dps920ab.rst
+F:	drivers/hwmon/pmbus/dps920ab.c

 DELTA ST MEDIA DRIVER
 M:	Hugues Fruchet <hugues.fruchet@foss.st.com>
@@ -5422,13 +5422,6 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/platform/sti/delta

-DELTA DPS920AB PSU DRIVER
-M:	Robert Marko <robert.marko@sartura.hr>
-L:	linux-hwmon@vger.kernel.org
-S:	Maintained
-F:	Documentation/hwmon/dps920ab.rst
-F:	drivers/hwmon/pmbus/dps920ab.c
-
 DENALI NAND DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
@@ -5441,13 +5434,6 @@ S:	Maintained
 F:	drivers/dma/dw-edma/
 F:	include/linux/dma/edma.h

-DESIGNWARE XDATA IP DRIVER
-M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
-L:	linux-pci@vger.kernel.org
-S:	Maintained
-F:	Documentation/misc-devices/dw-xdata-pcie.rst
-F:	drivers/misc/dw-xdata-pcie.c
-
 DESIGNWARE USB2 DRD IP DRIVER
 M:	Minas Harutyunyan <hminas@synopsys.com>
 L:	linux-usb@vger.kernel.org
@@ -5462,6 +5448,13 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
 F:	drivers/usb/dwc3/

+DESIGNWARE XDATA IP DRIVER
+M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/misc-devices/dw-xdata-pcie.rst
+F:	drivers/misc/dw-xdata-pcie.c
+
 DEVANTECH SRF ULTRASONIC RANGER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 L:	linux-iio@vger.kernel.org
@@ -5691,6 +5684,12 @@ F:	include/linux/dma/
 F:	include/linux/dmaengine.h
 F:	include/linux/of_dma.h

+DMA MAPPING BENCHMARK
+M:	Barry Song <song.bao.hua@hisilicon.com>
+L:	iommu@lists.linux-foundation.org
+F:	kernel/dma/map_benchmark.c
+F:	tools/testing/selftests/dma/
+
 DMA MAPPING HELPERS
 M:	Christoph Hellwig <hch@lst.de>
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
@@ -5705,12 +5704,6 @@ F:	include/linux/dma-mapping.h
 F:	include/linux/dma-map-ops.h
 F:	kernel/dma/

-DMA MAPPING BENCHMARK
-M:	Barry Song <song.bao.hua@hisilicon.com>
-L:	iommu@lists.linux-foundation.org
-F:	kernel/dma/map_benchmark.c
-F:	tools/testing/selftests/dma/
-
 DMA-BUF HEAPS FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 R:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
@@ -5992,6 +5985,14 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/himax,hx8357d.txt
 F:	drivers/gpu/drm/tiny/hx8357d.c

+DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
+M:	Deepak Rawat <drawat.floss@gmail.com>
+L:	linux-hyperv@vger.kernel.org
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	drivers/gpu/drm/hyperv
+
 DRM DRIVER FOR ILITEK ILI9225 PANELS
 M:	David Lechner <david@lechnology.com>
 S:	Maintained
@@ -6137,14 +6138,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml
 F:	drivers/gpu/drm/panel/panel-samsung-s6d27a1.c

-DRM DRIVER FOR SITRONIX ST7703 PANELS
-M:	Guido G=C3=BCnther <agx@sigxcpu.org>
-R:	Purism Kernel Team <kernel@puri.sm>
-R:	Ondrej Jirman <megous@megous.com>
-S:	Maintained
-F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.y=
aml
-F:	drivers/gpu/drm/panel/panel-sitronix-st7703.c
-
 DRM DRIVER FOR SAVAGE VIDEO CARDS
 S:	Orphan / Obsolete
 F:	drivers/gpu/drm/savage/
@@ -6175,6 +6168,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
 F:	drivers/gpu/drm/panel/panel-sitronix-st7701.c

+DRM DRIVER FOR SITRONIX ST7703 PANELS
+M:	Guido G=C3=BCnther <agx@sigxcpu.org>
+R:	Purism Kernel Team <kernel@puri.sm>
+R:	Ondrej Jirman <megous@megous.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.y=
aml
+F:	drivers/gpu/drm/panel/panel-sitronix-st7703.c
+
 DRM DRIVER FOR SITRONIX ST7735R PANELS
 M:	David Lechner <david@lechnology.com>
 S:	Maintained
@@ -6369,14 +6370,6 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/hisilicon/
 F:	drivers/gpu/drm/hisilicon/

-DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
-M:	Deepak Rawat <drawat.floss@gmail.com>
-L:	linux-hyperv@vger.kernel.org
-L:	dri-devel@lists.freedesktop.org
-S:	Maintained
-T:	git git://anongit.freedesktop.org/drm/drm-misc
-F:	drivers/gpu/drm/hyperv
-
 DRM DRIVERS FOR LIMA
 M:	Qiang Yu <yuq825@gmail.com>
 L:	dri-devel@lists.freedesktop.org
@@ -6524,6 +6517,14 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/xlnx/
 F:	drivers/gpu/drm/xlnx/

+DRM GPU SCHEDULER
+M:	Andrey Grodzovsky <andrey.grodzovsky@amd.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	drivers/gpu/drm/scheduler/
+F:	include/drm/gpu_scheduler.h
+
 DRM PANEL DRIVERS
 M:	Thierry Reding <thierry.reding@gmail.com>
 R:	Sam Ravnborg <sam@ravnborg.org>
@@ -6544,14 +6545,6 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/ttm/
 F:	include/drm/ttm/

-DRM GPU SCHEDULER
-M:	Andrey Grodzovsky <andrey.grodzovsky@amd.com>
-L:	dri-devel@lists.freedesktop.org
-S:	Maintained
-T:	git git://anongit.freedesktop.org/drm/drm-misc
-F:	drivers/gpu/drm/scheduler/
-F:	include/drm/gpu_scheduler.h
-
 DSBR100 USB FM RADIO DRIVER
 M:	Alexey Klimov <klimov.linux@gmail.com>
 L:	linux-media@vger.kernel.org
@@ -6690,6 +6683,15 @@ F:	Documentation/networking/net_dim.rst
 F:	include/linux/dim.h
 F:	lib/dim/

+DYNAMIC THERMAL POWER MANAGEMENT (DTPM)
+M:	Daniel Lezcano <daniel.lezcano@kernel.org>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+B:	https://bugzilla.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
+F:	drivers/powercap/dtpm*
+F:	include/linux/dtpm.h
+
 DZ DECSTATION DZ11 SERIAL DRIVER
 M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
 S:	Maintained
@@ -7037,22 +7039,22 @@ W:	http://www.broadcom.com
 F:	drivers/infiniband/hw/ocrdma/
 F:	include/uapi/rdma/ocrdma-abi.h

-EMULEX/BROADCOM LPFC FC/FCOE SCSI DRIVER
+EMULEX/BROADCOM EFCT FC/FCOE SCSI TARGET DRIVER
 M:	James Smart <james.smart@broadcom.com>
-M:	Dick Kennedy <dick.kennedy@broadcom.com>
+M:	Ram Vegesna <ram.vegesna@broadcom.com>
 L:	linux-scsi@vger.kernel.org
+L:	target-devel@vger.kernel.org
 S:	Supported
 W:	http://www.broadcom.com
-F:	drivers/scsi/lpfc/
+F:	drivers/scsi/elx/

-EMULEX/BROADCOM EFCT FC/FCOE SCSI TARGET DRIVER
+EMULEX/BROADCOM LPFC FC/FCOE SCSI DRIVER
 M:	James Smart <james.smart@broadcom.com>
-M:	Ram Vegesna <ram.vegesna@broadcom.com>
+M:	Dick Kennedy <dick.kennedy@broadcom.com>
 L:	linux-scsi@vger.kernel.org
-L:	target-devel@vger.kernel.org
 S:	Supported
 W:	http://www.broadcom.com
-F:	drivers/scsi/elx/
+F:	drivers/scsi/lpfc/

 ENE CB710 FLASH CARD READER DRIVER
 M:	Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
@@ -8529,6 +8531,12 @@ W:	http://www.highpoint-tech.com
 F:	Documentation/scsi/hptiop.rst
 F:	drivers/scsi/hptiop.c

+HIKEY960 ONBOARD USB GPIO HUB DRIVER
+M:	John Stultz <john.stultz@linaro.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/misc/hisi_hikey_usb.c
+
 HIPPI
 M:	Jes Sorensen <jes@trained-monkey.org>
 L:	linux-hippi@sunsite.dk
@@ -8599,12 +8607,6 @@ W:	http://www.hisilicon.com
 F:	Documentation/devicetree/bindings/net/hisilicon*.txt
 F:	drivers/net/ethernet/hisilicon/

-HIKEY960 ONBOARD USB GPIO HUB DRIVER
-M:	John Stultz <john.stultz@linaro.org>
-L:	linux-kernel@vger.kernel.org
-S:	Maintained
-F:	drivers/misc/hisi_hikey_usb.c
-
 HISILICON PMU DRIVER
 M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
 S:	Supported
@@ -9630,18 +9632,18 @@ F:	Documentation/admin-guide/media/ipu3_rcb.svg
 F:	Documentation/userspace-api/media/v4l/pixfmt-meta-intel-ipu3.rst
 F:	drivers/staging/media/ipu3/

-INTEL IXP4XX CRYPTO SUPPORT
-M:	Corentin Labbe <clabbe@baylibre.com>
-L:	linux-crypto@vger.kernel.org
-S:	Maintained
-F:	drivers/crypto/ixp4xx_crypto.c
-
 INTEL ISHTP ECLITE DRIVER
 M:	Sumesh K Naduvalath <sumesh.k.naduvalath@intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Supported
 F:	drivers/platform/x86/intel/ishtp_eclite.c

+INTEL IXP4XX CRYPTO SUPPORT
+M:	Corentin Labbe <clabbe@baylibre.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	drivers/crypto/ixp4xx_crypto.c
+
 INTEL IXP4XX QMGR, NPE, ETHERNET and HSS SUPPORT
 M:	Krzysztof Halasa <khalasa@piap.pl>
 S:	Maintained
@@ -9784,6 +9786,21 @@ S:	Maintained
 F:	arch/x86/include/asm/intel_scu_ipc.h
 F:	drivers/platform/x86/intel_scu_*

+INTEL SGX
+M:	Jarkko Sakkinen <jarkko@kernel.org>
+R:	Dave Hansen <dave.hansen@linux.intel.com>
+L:	linux-sgx@vger.kernel.org
+S:	Supported
+Q:	https://patchwork.kernel.org/project/intel-sgx/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
+F:	Documentation/x86/sgx.rst
+F:	arch/x86/entry/vdso/vsgx.S
+F:	arch/x86/include/asm/sgx.h
+F:	arch/x86/include/uapi/asm/sgx.h
+F:	arch/x86/kernel/cpu/sgx/*
+F:	tools/testing/selftests/sgx/*
+K:	\bSGX_
+
 INTEL SKYLAKE INT3472 ACPI DEVICE DRIVER
 M:	Daniel Scally <djrscally@gmail.com>
 S:	Maintained
@@ -9878,21 +9895,6 @@ F:	Documentation/x86/intel_txt.rst
 F:	arch/x86/kernel/tboot.c
 F:	include/linux/tboot.h

-INTEL SGX
-M:	Jarkko Sakkinen <jarkko@kernel.org>
-R:	Dave Hansen <dave.hansen@linux.intel.com>
-L:	linux-sgx@vger.kernel.org
-S:	Supported
-Q:	https://patchwork.kernel.org/project/intel-sgx/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
-F:	Documentation/x86/sgx.rst
-F:	arch/x86/entry/vdso/vsgx.S
-F:	arch/x86/include/asm/sgx.h
-F:	arch/x86/include/uapi/asm/sgx.h
-F:	arch/x86/kernel/cpu/sgx/*
-F:	tools/testing/selftests/sgx/*
-K:	\bSGX_
-
 INTERCONNECT API
 M:	Georgi Djakov <djakov@kernel.org>
 L:	linux-pm@vger.kernel.org
@@ -11298,6 +11300,12 @@ F:	drivers/mailbox/arm_mhuv2.c
 F:	include/linux/mailbox/arm_mhuv2_message.h
 F:	Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml

+MAN-PAGES: MANUAL PAGES FOR LINUX -- Sections 2, 3, 4, 5, and 7
+M:	Michael Kerrisk <mtk.manpages@gmail.com>
+L:	linux-man@vger.kernel.org
+S:	Maintained
+W:	http://www.kernel.org/doc/man-pages
+
 MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP)
 M:	Jeremy Kerr <jk@codeconstruct.com.au>
 M:	Matt Johnston <matt@codeconstruct.com.au>
@@ -11310,12 +11318,6 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/

-MAN-PAGES: MANUAL PAGES FOR LINUX -- Sections 2, 3, 4, 5, and 7
-M:	Michael Kerrisk <mtk.manpages@gmail.com>
-L:	linux-man@vger.kernel.org
-S:	Maintained
-W:	http://www.kernel.org/doc/man-pages
-
 MARDUK (CREATOR CI40) DEVICE TREE SUPPORT
 M:	Rahul Bedarkar <rahulbedarkar89@gmail.com>
 L:	linux-mips@vger.kernel.org
@@ -11634,12 +11636,6 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/phy/mxl-gpy.c

-MCBA MICROCHIP CAN BUS ANALYZER TOOL DRIVER
-R:	Yasushi SHOJI <yashi@spacecubics.com>
-L:	linux-can@vger.kernel.org
-S:	Maintained
-F:	drivers/net/can/usb/mcba_usb.c
-
 MCAN MMIO DEVICE DRIVER
 M:	Chandrasekar Ramakrishnan <rcsekar@samsung.com>
 L:	linux-can@vger.kernel.org
@@ -11649,6 +11645,12 @@ F:	drivers/net/can/m_can/m_can.c
 F:	drivers/net/can/m_can/m_can.h
 F:	drivers/net/can/m_can/m_can_platform.c

+MCBA MICROCHIP CAN BUS ANALYZER TOOL DRIVER
+R:	Yasushi SHOJI <yashi@spacecubics.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/usb/mcba_usb.c
+
 MCP2221A MICROCHIP USB-HID TO I2C BRIDGE DRIVER
 M:	Rishi Gupta <gupt21@gmail.com>
 L:	linux-i2c@vger.kernel.org
@@ -12041,13 +12043,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
 F:	drivers/clk/ralink/clk-mt7621.c

-MEDIATEK MT7621/28/88 I2C DRIVER
-M:	Stefan Roese <sr@denx.de>
-L:	linux-i2c@vger.kernel.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/i2c-mt7621.txt
-F:	drivers/i2c/busses/i2c-mt7621.c
-
 MEDIATEK MT7621 PCIE CONTROLLER DRIVER
 M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
 S:	Maintained
@@ -12060,6 +12055,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
 F:	drivers/phy/ralink/phy-mt7621-pci.c

+MEDIATEK MT7621/28/88 I2C DRIVER
+M:	Stefan Roese <sr@denx.de>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i2c/i2c-mt7621.txt
+F:	drivers/i2c/busses/i2c-mt7621.c
+
 MEDIATEK NAND CONTROLLER DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
@@ -12591,6 +12593,13 @@ S:	Supported
 F:	drivers/misc/atmel-ssc.c
 F:	include/linux/atmel-ssc.h

+Microchip Timer Counter Block (TCB) Capture Driver
+M:	Kamel Bouhara <kamel.bouhara@bootlin.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/counter/microchip-tcb-capture.c
+
 MICROCHIP USB251XB DRIVER
 M:	Richard Leitner <richard.leitner@skidata.com>
 L:	linux-usb@vger.kernel.org
@@ -13691,13 +13700,6 @@ F:	drivers/iio/gyro/fxas21002c_core.c
 F:	drivers/iio/gyro/fxas21002c_i2c.c
 F:	drivers/iio/gyro/fxas21002c_spi.c

-NXP i.MX CLOCK DRIVERS
-M:	Abel Vesa <abel.vesa@nxp.com>
-L:	linux-clk@vger.kernel.org
-L:	linux-imx@nxp.com
-S:	Maintained
-F:	drivers/clk/imx/
-
 NXP i.MX 8MQ DCSS DRIVER
 M:	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
 R:	Lucas Stach <l.stach@pengutronix.de>
@@ -13713,6 +13715,21 @@ S:	Supported
 F:	Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
 F:	drivers/iio/adc/imx8qxp-adc.c

+NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER
+M:	Mirela Rabulea <mirela.rabulea@nxp.com>
+R:	NXP Linux Team <linux-imx@nxp.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
+F:	drivers/media/platform/imx-jpeg
+
+NXP i.MX CLOCK DRIVERS
+M:	Abel Vesa <abel.vesa@nxp.com>
+L:	linux-clk@vger.kernel.org
+L:	linux-imx@nxp.com
+S:	Maintained
+F:	drivers/clk/imx/
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
@@ -13750,19 +13767,12 @@ F:	include/drm/i2c/tda998x.h
 F:	include/dt-bindings/display/tda998x.h
 K:	"nxp,tda998x"

-NXP TFA9879 DRIVER
-M:	Peter Rosin <peda@axentia.se>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-S:	Maintained
-F:	Documentation/devicetree/bindings/sound/tfa9879.txt
-F:	sound/soc/codecs/tfa9879*
-
-NXP/Goodix TFA989X (TFA1) DRIVER
-M:	Stephan Gerhold <stephan@gerhold.net>
+NXP TFA9879 DRIVER
+M:	Peter Rosin <peda@axentia.se>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
-F:	sound/soc/codecs/tfa989x.c
+F:	Documentation/devicetree/bindings/sound/tfa9879.txt
+F:	sound/soc/codecs/tfa9879*

 NXP-NCI NFC DRIVER
 R:	Charles Gorand <charles.gorand@effinnov.com>
@@ -13771,13 +13781,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
 F:	drivers/nfc/nxp-nci

-NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER
-M:	Mirela Rabulea <mirela.rabulea@nxp.com>
-R:	NXP Linux Team <linux-imx@nxp.com>
-L:	linux-media@vger.kernel.org
+NXP/Goodix TFA989X (TFA1) DRIVER
+M:	Stephan Gerhold <stephan@gerhold.net>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
-F:	drivers/media/platform/imx-jpeg
+F:	Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
+F:	sound/soc/codecs/tfa989x.c

 NZXT-KRAKEN2 HARDWARE MONITORING DRIVER
 M:	Jonas Malaco <jonas@protocubo.io>
@@ -14567,6 +14576,14 @@ L:	linux-arm-kernel@lists.infradead.org (moderate=
d for non-subscribers)
 S:	Maintained
 F:	drivers/pci/controller/dwc/*layerscape*

+PCI DRIVER FOR FU740
+M:	Paul Walmsley <paul.walmsley@sifive.com>
+M:	Greentime Hu <greentime.hu@sifive.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
+F:	drivers/pci/controller/dwc/pcie-fu740.c
+
 PCI DRIVER FOR GENERIC OF HOSTS
 M:	Will Deacon <will@kernel.org>
 L:	linux-pci@vger.kernel.org
@@ -14585,14 +14602,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
 F:	drivers/pci/controller/dwc/*imx6*

-PCI DRIVER FOR FU740
-M:	Paul Walmsley <paul.walmsley@sifive.com>
-M:	Greentime Hu <greentime.hu@sifive.com>
-L:	linux-pci@vger.kernel.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
-F:	drivers/pci/controller/dwc/pcie-fu740.c
-
 PCI DRIVER FOR INTEL IXP4XX
 M:	Linus Walleij <linus.walleij@linaro.org>
 S:	Maintained
@@ -14865,14 +14874,6 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/controller/dwc/pcie-qcom.c

-PCIE ENDPOINT DRIVER FOR QUALCOMM
-M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
-L:	linux-pci@vger.kernel.org
-L:	linux-arm-msm@vger.kernel.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
-F:	drivers/pci/controller/dwc/pcie-qcom-ep.c
-
 PCIE DRIVER FOR ROCKCHIP
 M:	Shawn Lin <shawn.lin@rock-chips.com>
 L:	linux-pci@vger.kernel.org
@@ -14894,6 +14895,14 @@ L:	linux-pci@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/controller/dwc/*spear*

+PCIE ENDPOINT DRIVER FOR QUALCOMM
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-pci@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+F:	drivers/pci/controller/dwc/pcie-qcom-ep.c
+
 PCMCIA SUBSYSTEM
 M:	Dominik Brodowski <linux@dominikbrodowski.net>
 S:	Odd Fixes
@@ -15153,13 +15162,6 @@ M:	Logan Gunthorpe <logang@deltatee.com>
 S:	Maintained
 F:	drivers/dma/plx_dma.c

-PM6764TR DRIVER
-M:	Charles Hsu	<hsu.yungteng@gmail.com>
-L:	linux-hwmon@vger.kernel.org
-S:	Maintained
-F:	Documentation/hwmon/pm6764tr.rst
-F:	drivers/hwmon/pmbus/pm6764tr.c
-
 PM-GRAPH UTILITY
 M:	"Todd E Brandt" <todd.e.brandt@linux.intel.com>
 L:	linux-pm@vger.kernel.org
@@ -15169,6 +15171,13 @@ B:	https://bugzilla.kernel.org/buglist.cgi?compon=
ent=3Dpm-graph&product=3DTools
 T:	git git://github.com/intel/pm-graph
 F:	tools/power/pm-graph

+PM6764TR DRIVER
+M:	Charles Hsu	<hsu.yungteng@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/pm6764tr.rst
+F:	drivers/hwmon/pmbus/pm6764tr.c
+
 PMBUS HARDWARE MONITORING DRIVERS
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
@@ -15249,15 +15258,6 @@ F:	include/linux/pm_*
 F:	include/linux/powercap.h
 F:	kernel/configs/nopm.config

-DYNAMIC THERMAL POWER MANAGEMENT (DTPM)
-M:	Daniel Lezcano <daniel.lezcano@kernel.org>
-L:	linux-pm@vger.kernel.org
-S:	Supported
-B:	https://bugzilla.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
-F:	drivers/powercap/dtpm*
-F:	include/linux/dtpm.h
-
 POWER STATE COORDINATION INTERFACE (PSCI)
 M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
@@ -16272,12 +16272,6 @@ S:	Supported
 F:	Documentation/devicetree/bindings/i2c/renesas,riic.yaml
 F:	drivers/i2c/busses/i2c-riic.c

-RENESAS USB PHY DRIVER
-M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
-L:	linux-renesas-soc@vger.kernel.org
-S:	Maintained
-F:	drivers/phy/renesas/phy-rcar-gen3-usb*.c
-
 RENESAS RZ/G2L A/D DRIVER
 M:	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
 L:	linux-iio@vger.kernel.org
@@ -16286,6 +16280,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
 F:	drivers/iio/adc/rzg2l_adc.c

+RENESAS USB PHY DRIVER
+M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
+L:	linux-renesas-soc@vger.kernel.org
+S:	Maintained
+F:	drivers/phy/renesas/phy-rcar-gen3-usb*.c
+
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 S:	Maintained
@@ -17116,6 +17116,15 @@ F:	block/sed*
 F:	include/linux/sed*
 F:	include/uapi/linux/sed*

+SECURE MONITOR CALL(SMC) CALLING CONVENTION (SMCCC)
+M:	Mark Rutland <mark.rutland@arm.com>
+M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Sudeep Holla <sudeep.holla@arm.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/firmware/smccc/
+F:	include/linux/arm-smccc.h
+
 SECURITY CONTACT
 M:	Security Officers <security@kernel.org>
 S:	Supported
@@ -17523,15 +17532,6 @@ M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Odd Fixes
 F:	drivers/net/ethernet/smsc/smc91x.*

-SECURE MONITOR CALL(SMC) CALLING CONVENTION (SMCCC)
-M:	Mark Rutland <mark.rutland@arm.com>
-M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
-M:	Sudeep Holla <sudeep.holla@arm.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	drivers/firmware/smccc/
-F:	include/linux/arm-smccc.h
-
 SMM665 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
@@ -18713,6 +18713,14 @@ M:	Thierry Reding <thierry.reding@gmail.com>
 S:	Supported
 F:	drivers/pwm/pwm-tegra.c

+TEGRA QUAD SPI DRIVER
+M:	Thierry Reding <thierry.reding@gmail.com>
+M:	Jonathan Hunter <jonathanh@nvidia.com>
+M:	Sowjanya Komatineni <skomatineni@nvidia.com>
+L:	linux-tegra@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-tegra210-quad.c
+
 TEGRA SERIAL DRIVER
 M:	Laxman Dewangan <ldewangan@nvidia.com>
 S:	Supported
@@ -18723,14 +18731,6 @@ M:	Laxman Dewangan <ldewangan@nvidia.com>
 S:	Supported
 F:	drivers/spi/spi-tegra*

-TEGRA QUAD SPI DRIVER
-M:	Thierry Reding <thierry.reding@gmail.com>
-M:	Jonathan Hunter <jonathanh@nvidia.com>
-M:	Sowjanya Komatineni <skomatineni@nvidia.com>
-L:	linux-tegra@vger.kernel.org
-S:	Maintained
-F:	drivers/spi/spi-tegra210-quad.c
-
 TEGRA VIDEO DRIVER
 M:	Thierry Reding <thierry.reding@gmail.com>
 M:	Jonathan Hunter <jonathanh@nvidia.com>
@@ -18779,13 +18779,6 @@ L:	alsa-devel@alsa-project.org (moderated for non=
-subscribers)
 S:	Maintained
 F:	sound/soc/ti/

-TEXAS INSTRUMENTS' DAC7612 DAC DRIVER
-M:	Ricardo Ribalda <ribalda@kernel.org>
-L:	linux-iio@vger.kernel.org
-S:	Supported
-F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
-F:	drivers/iio/dac/ti-dac7612.c
-
 TEXAS INSTRUMENTS DMA DRIVERS
 M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
 L:	dmaengine@vger.kernel.org
@@ -18799,6 +18792,22 @@ F:	include/linux/dma/k3-udma-glue.h
 F:	include/linux/dma/ti-cppi5.h
 F:	include/linux/dma/k3-psil.h

+TEXAS INSTRUMENTS TPS23861 PoE PSE DRIVER
+M:	Robert Marko <robert.marko@sartura.hr>
+M:	Luka Perkov <luka.perkov@sartura.hr>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
+F:	Documentation/hwmon/tps23861.rst
+F:	drivers/hwmon/tps23861.c
+
+TEXAS INSTRUMENTS' DAC7612 DAC DRIVER
+M:	Ricardo Ribalda <ribalda@kernel.org>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
+F:	drivers/iio/dac/ti-dac7612.c
+
 TEXAS INSTRUMENTS' SYSTEM CONTROL INTERFACE (TISCI) PROTOCOL DRIVER
 M:	Nishanth Menon <nm@ti.com>
 M:	Tero Kristo <kristo@kernel.org>
@@ -18823,15 +18832,6 @@ F:	include/dt-bindings/soc/ti,sci_pm_domain.h
 F:	include/linux/soc/ti/ti_sci_inta_msi.h
 F:	include/linux/soc/ti/ti_sci_protocol.h

-TEXAS INSTRUMENTS TPS23861 PoE PSE DRIVER
-M:	Robert Marko <robert.marko@sartura.hr>
-M:	Luka Perkov <luka.perkov@sartura.hr>
-L:	linux-hwmon@vger.kernel.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
-F:	Documentation/hwmon/tps23861.rst
-F:	drivers/hwmon/tps23861.c
-
 TEXAS INSTRUMENTS' TMP117 TEMPERATURE SENSOR DRIVER
 M:	Puranjay Mohan <puranjay12@gmail.com>
 L:	linux-iio@vger.kernel.org
@@ -19732,6 +19732,13 @@ L:	linux-usb@vger.kernel.org
 S:	Supported
 F:	drivers/usb/class/usblp.c

+USB QMI WWAN NETWORK DRIVER
+M:	Bj=C3=B8rn Mork <bjorn@mork.no>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-class-net-qmi
+F:	drivers/net/usb/qmi_wwan.c
+
 USB RAW GADGET DRIVER
 R:	Andrey Konovalov <andreyknvl@gmail.com>
 L:	linux-usb@vger.kernel.org
@@ -19740,13 +19747,6 @@ F:	Documentation/usb/raw-gadget.rst
 F:	drivers/usb/gadget/legacy/raw_gadget.c
 F:	include/uapi/linux/usb/raw_gadget.h

-USB QMI WWAN NETWORK DRIVER
-M:	Bj=C3=B8rn Mork <bjorn@mork.no>
-L:	netdev@vger.kernel.org
-S:	Maintained
-F:	Documentation/ABI/testing/sysfs-class-net-qmi
-F:	drivers/net/usb/qmi_wwan.c
-
 USB RTL8150 DRIVER
 M:	Petko Manolov <petkan@nucleusys.com>
 L:	linux-usb@vger.kernel.org
@@ -20062,6 +20062,14 @@ S:	Maintained
 F:	drivers/media/common/videobuf2/*
 F:	include/media/videobuf2-*

+VIDTV VIRTUAL DIGITAL TV DRIVER
+M:	Daniel W. S. Almeida <dwlsalmeida@gmail.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+W:	https://linuxtv.org
+T:	git git://linuxtv.org/media_tree.git
+F:	drivers/media/test-drivers/vidtv/*
+
 VIMC VIRTUAL MEDIA CONTROLLER DRIVER
 M:	Helen Koike <helen.koike@collabora.com>
 R:	Shuah Khan <skhan@linuxfoundation.org>
@@ -20091,6 +20099,16 @@ F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c

+VIRTIO BALLOON
+M:	"Michael S. Tsirkin" <mst@redhat.com>
+M:	David Hildenbrand <david@redhat.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/virtio/virtio_balloon.c
+F:	include/uapi/linux/virtio_balloon.h
+F:	include/linux/balloon_compaction.h
+F:	mm/balloon_compaction.c
+
 VIRTIO BLOCK AND SCSI DRIVERS
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
@@ -20128,16 +20146,6 @@ F:	include/linux/virtio*.h
 F:	include/uapi/linux/virtio_*.h
 F:	tools/virtio/

-VIRTIO BALLOON
-M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	David Hildenbrand <david@redhat.com>
-L:	virtualization@lists.linux-foundation.org
-S:	Maintained
-F:	drivers/virtio/virtio_balloon.c
-F:	include/uapi/linux/virtio_balloon.h
-F:	include/linux/balloon_compaction.h
-F:	mm/balloon_compaction.c
-
 VIRTIO CRYPTO DRIVER
 M:	Gonglei <arei.gonglei@huawei.com>
 L:	virtualization@lists.linux-foundation.org
@@ -20199,6 +20207,15 @@ F:	drivers/vhost/
 F:	include/linux/vhost_iotlb.h
 F:	include/uapi/linux/vhost.h

+VIRTIO I2C DRIVER
+M:	Conghui Chen <conghui.chen@intel.com>
+M:	Viresh Kumar <viresh.kumar@linaro.org>
+L:	linux-i2c@vger.kernel.org
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/i2c/busses/i2c-virtio.c
+F:	include/uapi/linux/virtio_i2c.h
+
 VIRTIO INPUT DRIVER
 M:	Gerd Hoffmann <kraxel@redhat.com>
 S:	Maintained
@@ -20220,6 +20237,13 @@ W:	https://virtio-mem.gitlab.io/
 F:	drivers/virtio/virtio_mem.c
 F:	include/uapi/linux/virtio_mem.h

+VIRTIO PMEM DRIVER
+M:	Pankaj Gupta <pankaj.gupta.linux@gmail.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/nvdimm/virtio_pmem.c
+F:	drivers/nvdimm/nd_virtio.c
+
 VIRTIO SOUND DRIVER
 M:	Anton Yakovlev <anton.yakovlev@opensynergy.com>
 M:	"Michael S. Tsirkin" <mst@redhat.com>
@@ -20229,22 +20253,6 @@ S:	Maintained
 F:	include/uapi/linux/virtio_snd.h
 F:	sound/virtio/*

-VIRTIO I2C DRIVER
-M:	Conghui Chen <conghui.chen@intel.com>
-M:	Viresh Kumar <viresh.kumar@linaro.org>
-L:	linux-i2c@vger.kernel.org
-L:	virtualization@lists.linux-foundation.org
-S:	Maintained
-F:	drivers/i2c/busses/i2c-virtio.c
-F:	include/uapi/linux/virtio_i2c.h
-
-VIRTIO PMEM DRIVER
-M:	Pankaj Gupta <pankaj.gupta.linux@gmail.com>
-L:	virtualization@lists.linux-foundation.org
-S:	Maintained
-F:	drivers/nvdimm/virtio_pmem.c
-F:	drivers/nvdimm/nd_virtio.c
-
 VIRTUAL BOX GUEST DEVICE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 M:	Arnd Bergmann <arnd@arndb.de>
@@ -20274,14 +20282,6 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/test-drivers/vivid/*

-VIDTV VIRTUAL DIGITAL TV DRIVER
-M:	Daniel W. S. Almeida <dwlsalmeida@gmail.com>
-L:	linux-media@vger.kernel.org
-S:	Maintained
-W:	https://linuxtv.org
-T:	git git://linuxtv.org/media_tree.git
-F:	drivers/media/test-drivers/vidtv/*
-
 VLYNQ BUS
 M:	Florian Fainelli <f.fainelli@gmail.com>
 L:	openwrt-devel@lists.openwrt.org (subscribers-only)
@@ -20289,18 +20289,6 @@ S:	Maintained
 F:	drivers/vlynq/vlynq.c
 F:	include/linux/vlynq.h

-VME SUBSYSTEM
-M:	Martyn Welch <martyn@welchs.me.uk>
-M:	Manohar Vanga <manohar.vanga@gmail.com>
-M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-L:	linux-kernel@vger.kernel.org
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
-F:	Documentation/driver-api/vme.rst
-F:	drivers/staging/vme/
-F:	drivers/vme/
-F:	include/linux/vme*
-
 VM SOCKETS (AF_VSOCK)
 M:	Stefano Garzarella <sgarzare@redhat.com>
 L:	virtualization@lists.linux-foundation.org
@@ -20314,6 +20302,18 @@ F:	include/uapi/linux/vsockmon.h
 F:	net/vmw_vsock/
 F:	tools/testing/vsock/

+VME SUBSYSTEM
+M:	Martyn Welch <martyn@welchs.me.uk>
+M:	Manohar Vanga <manohar.vanga@gmail.com>
+M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
+F:	Documentation/driver-api/vme.rst
+F:	drivers/staging/vme/
+F:	drivers/vme/
+F:	include/linux/vme*
+
 VMWARE BALLOON DRIVER
 M:	Nadav Amit <namit@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
=2D-
2.30.2

