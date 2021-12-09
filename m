Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B12B46ECBE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhLIQLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:11:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40242 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbhLIQKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:49 -0500
Date:   Thu, 09 Dec 2021 16:07:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066034;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SWPEI9IB/XTFaw7Jbjz93bYshMe1mr+dxuwQFTn1zkw=;
        b=au+tJl6sYesWf5HoUoyEA5mEu9tNJhFbtwXnVxXc+rdIvNNtbtdK4YrOUTQbvPNrcR2tdW
        XQB1L+7yZAwRj3wJjf5yBBkRQZpgwCtscLuEhJ+joxYPicb91/wqQyeesO/sJzKSWa5wio
        a2rcqwP6jjozhW3oFeojUayNeqvQF+i8C5ER70OMEDLx7/+ULO7Wrl2VsnlfqK+jxoamcX
        euN3VwESzq/oqMNkeUPoErqS8/QMHWuSpp0hqlPkxKIdR49sd4paXm9u0Xdn6SS6xL10HN
        VNrAMd7QwoGNkv5UI0Rlr8hR+9k/NfC1qVvLt+x/YVdnDUJ6SESWbSauI3jRBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066034;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SWPEI9IB/XTFaw7Jbjz93bYshMe1mr+dxuwQFTn1zkw=;
        b=A/XzQLTEh4/GDfoh58Z0Koqow/IGAeu16f+eiyW74PNVOhUeB+59QNssQqVYUhYkdEgdF4
        dkBhLPZxCXvmnrCA==
From:   tip-bot2 for =?utf-8?q?C=C3=A9dric?= Le Goater 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] powerpc/4xx: Complete removal of MSI support
Cc:     clg@kaod.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <e92f2bb3-b5e1-c870-8151-3917a789a640@kaod.org>
References: <e92f2bb3-b5e1-c870-8151-3917a789a640@kaod.org>
MIME-Version: 1.0
Message-ID: <163906603372.11128.647819037430288325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     eca213152a36b381724251afaa5ce04ac551e3f7
Gitweb:        https://git.kernel.org/tip/eca213152a36b381724251afaa5ce04ac55=
1e3f7
Author:        C=C3=A9dric Le Goater <clg@kaod.org>
AuthorDate:    Tue, 07 Dec 2021 16:32:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:20 +01:00

powerpc/4xx: Complete removal of MSI support

Finish the work by removing all references to the PPC4xx_MSI config
and the associated device nodes in the DTs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/e92f2bb3-b5e1-c870-8151-3917a789a640@kaod.org
---
 arch/powerpc/boot/dts/bluestone.dts   | 25 +-----------------------
 arch/powerpc/boot/dts/canyonlands.dts | 18 +-----------------
 arch/powerpc/boot/dts/katmai.dts      | 18 +-----------------
 arch/powerpc/boot/dts/kilauea.dts     | 28 +--------------------------
 arch/powerpc/boot/dts/redwood.dts     | 19 +------------------
 arch/powerpc/platforms/40x/Kconfig    |  1 +-
 arch/powerpc/platforms/44x/Kconfig    |  4 +----
 7 files changed, 113 deletions(-)

diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dts/blue=
stone.dts
index aa1ae94..6971595 100644
--- a/arch/powerpc/boot/dts/bluestone.dts
+++ b/arch/powerpc/boot/dts/bluestone.dts
@@ -366,30 +366,5 @@
 				0x0 0x0 0x0 0x3 &UIC3 0xe 0x4 /* swizzled int C */
 				0x0 0x0 0x0 0x4 &UIC3 0xf 0x4 /* swizzled int D */>;
 		};
-
-		MSI: ppc4xx-msi@C10000000 {
-			compatible =3D "amcc,ppc4xx-msi", "ppc4xx-msi";
-			reg =3D < 0xC 0x10000000 0x100
-				0xC 0x10000000 0x100>;
-			sdr-base =3D <0x36C>;
-			msi-data =3D <0x00004440>;
-			msi-mask =3D <0x0000ffe0>;
-			interrupts =3D<0 1 2 3 4 5 6 7>;
-			interrupt-parent =3D <&MSI>;
-			#interrupt-cells =3D <1>;
-			#address-cells =3D <0>;
-			#size-cells =3D <0>;
-			msi-available-ranges =3D <0x0 0x100>;
-			interrupt-map =3D <
-				0 &UIC3 0x18 1
-				1 &UIC3 0x19 1
-				2 &UIC3 0x1A 1
-				3 &UIC3 0x1B 1
-				4 &UIC3 0x1C 1
-				5 &UIC3 0x1D 1
-				6 &UIC3 0x1E 1
-				7 &UIC3 0x1F 1
-			>;
-		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/ca=
nyonlands.dts
index c5fbb08..5db1bff 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -544,23 +544,5 @@
 				0x0 0x0 0x0 0x3 &UIC3 0x12 0x4 /* swizzled int C */
 				0x0 0x0 0x0 0x4 &UIC3 0x13 0x4 /* swizzled int D */>;
 		};
-
-		MSI: ppc4xx-msi@C10000000 {
-			compatible =3D "amcc,ppc4xx-msi", "ppc4xx-msi";
-			reg =3D < 0xC 0x10000000 0x100>;
-			sdr-base =3D <0x36C>;
-			msi-data =3D <0x00000000>;
-			msi-mask =3D <0x44440000>;
-			interrupt-count =3D <3>;
-			interrupts =3D <0 1 2 3>;
-			interrupt-parent =3D <&UIC3>;
-			#interrupt-cells =3D <1>;
-			#address-cells =3D <0>;
-			#size-cells =3D <0>;
-			interrupt-map =3D <0 &UIC3 0x18 1
-					1 &UIC3 0x19 1
-					2 &UIC3 0x1A 1
-					3 &UIC3 0x1B 1>;
-		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.=
dts
index a8f3532..4262b2b 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -442,24 +442,6 @@
 				0x0 0x0 0x0 0x4 &UIC3 0xb 0x4 /* swizzled int D */>;
 		};
=20
-		MSI: ppc4xx-msi@400300000 {
-				compatible =3D "amcc,ppc4xx-msi", "ppc4xx-msi";
-				reg =3D < 0x4 0x00300000 0x100>;
-				sdr-base =3D <0x3B0>;
-				msi-data =3D <0x00000000>;
-				msi-mask =3D <0x44440000>;
-				interrupt-count =3D <3>;
-				interrupts =3D<0 1 2 3>;
-				interrupt-parent =3D <&UIC0>;
-				#interrupt-cells =3D <1>;
-				#address-cells =3D <0>;
-				#size-cells =3D <0>;
-				interrupt-map =3D <0 &UIC0 0xC 1
-					1 &UIC0 0x0D 1
-					2 &UIC0 0x0E 1
-					3 &UIC0 0x0F 1>;
-		};
-
 		I2O: i2o@400100000 {
 			compatible =3D "ibm,i2o-440spe";
 			reg =3D <0x00000004 0x00100000 0x100>;
diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilaue=
a.dts
index a709fb4..c07a752 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -403,33 +403,5 @@
 				0x0 0x0 0x0 0x3 &UIC2 0xd 0x4 /* swizzled int C */
 				0x0 0x0 0x0 0x4 &UIC2 0xe 0x4 /* swizzled int D */>;
 		};
-
-		MSI: ppc4xx-msi@C10000000 {
-			compatible =3D "amcc,ppc4xx-msi", "ppc4xx-msi";
-			reg =3D <0xEF620000 0x100>;
-			sdr-base =3D <0x4B0>;
-			msi-data =3D <0x00000000>;
-			msi-mask =3D <0x44440000>;
-			interrupt-count =3D <12>;
-			interrupts =3D <0 1 2 3 4 5 6 7 8 9 0xA 0xB 0xC 0xD>;
-			interrupt-parent =3D <&UIC2>;
-			#interrupt-cells =3D <1>;
-			#address-cells =3D <0>;
-			#size-cells =3D <0>;
-			interrupt-map =3D <0 &UIC2 0x10 1
-					1 &UIC2 0x11 1
-					2 &UIC2 0x12 1
-					2 &UIC2 0x13 1
-					2 &UIC2 0x14 1
-					2 &UIC2 0x15 1
-					2 &UIC2 0x16 1
-					2 &UIC2 0x17 1
-					2 &UIC2 0x18 1
-					2 &UIC2 0x19 1
-					2 &UIC2 0x1A 1
-					2 &UIC2 0x1B 1
-					2 &UIC2 0x1C 1
-					3 &UIC2 0x1D 1>;
-		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/redwood.dts b/arch/powerpc/boot/dts/redwoo=
d.dts
index f38035a..3c849e2 100644
--- a/arch/powerpc/boot/dts/redwood.dts
+++ b/arch/powerpc/boot/dts/redwood.dts
@@ -358,25 +358,6 @@
 				0x0 0x0 0x0 0x4 &UIC3 0xb 0x4 /* swizzled int D */>;
 		};
=20
-		MSI: ppc4xx-msi@400300000 {
-				compatible =3D "amcc,ppc4xx-msi", "ppc4xx-msi";
-				reg =3D < 0x4 0x00300000 0x100
-					0x4 0x00300000 0x100>;
-				sdr-base =3D <0x3B0>;
-				msi-data =3D <0x00000000>;
-				msi-mask =3D <0x44440000>;
-				interrupt-count =3D <3>;
-				interrupts =3D<0 1 2 3>;
-				interrupt-parent =3D <&UIC0>;
-				#interrupt-cells =3D <1>;
-				#address-cells =3D <0>;
-				#size-cells =3D <0>;
-				interrupt-map =3D <0 &UIC0 0xC 1
-					1 &UIC0 0x0D 1
-					2 &UIC0 0x0E 1
-					3 &UIC0 0x0F 1>;
-		};
-
 	};
=20
=20
diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/=
Kconfig
index e3e5217..614ea6d 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -23,7 +23,6 @@ config KILAUEA
 	select PPC4xx_PCI_EXPRESS
 	select FORCE_PCI
 	select PCI_MSI
-	select PPC4xx_MSI
 	help
 	  This option enables support for the AMCC PPC405EX evaluation board.
=20
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/=
Kconfig
index 83975ef..25b80cd 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -23,7 +23,6 @@ config BLUESTONE
 	select APM821xx
 	select FORCE_PCI
 	select PCI_MSI
-	select PPC4xx_MSI
 	select PPC4xx_PCI_EXPRESS
 	select IBM_EMAC_RGMII if IBM_EMAC
 	help
@@ -73,7 +72,6 @@ config KATMAI
 	select FORCE_PCI
 	select PPC4xx_PCI_EXPRESS
 	select PCI_MSI
-	select PPC4xx_MSI
 	help
 	  This option enables support for the AMCC PPC440SPe evaluation board.
=20
@@ -115,7 +113,6 @@ config CANYONLANDS
 	select FORCE_PCI
 	select PPC4xx_PCI_EXPRESS
 	select PCI_MSI
-	select PPC4xx_MSI
 	select IBM_EMAC_RGMII if IBM_EMAC
 	select IBM_EMAC_ZMII if IBM_EMAC
 	help
@@ -141,7 +138,6 @@ config REDWOOD
 	select FORCE_PCI
 	select PPC4xx_PCI_EXPRESS
 	select PCI_MSI
-	select PPC4xx_MSI
 	help
 	  This option enables support for the AMCC PPC460SX Redwood board.
=20
