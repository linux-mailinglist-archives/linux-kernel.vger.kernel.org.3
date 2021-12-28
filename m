Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B431E480B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbhL1QUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:20:17 -0500
Received: from mout.gmx.net ([212.227.15.15]:41431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235803AbhL1QUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640708389;
        bh=kPS5EfnGgwXkGrSWtnVSZACxfMp0WTeu7Ps3qWfybCs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KjO8J3gyn85/IPnMHQHgBXcgzeIH7+dhbTvo9UQ/PcMhDrNv6azFlgnXTBJ5prYGE
         +Y2y+30bKRUx3FjXpi9aDuS64q9qAQ+qD9FwTb33V1d9kYI4sRQChXpWUaLupM73NI
         d2gHOtMVFer7j5qZPAY0U3aX/nF3mKmN6+hFCD70=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M7Jza-1n5WSf0DC0-007oiM; Tue, 28 Dec 2021 17:19:49 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] Documentation: ABI: Add ABI file for legacy /proc/i8k interface
Date:   Tue, 28 Dec 2021 17:19:24 +0100
Message-Id: <20211228161924.26167-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211228161924.26167-1-W_Armin@gmx.de>
References: <20211228161924.26167-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f9Z2/X5hS/8XTReAsPXTXFV03fzmOEo5uZS/2z9Br+JK5/WlNOP
 GAdysDz8LRXj1qpdbqIPzDeFgXydkK01U+xlLPjq7BSqqWSznTfocX7BJ4rsL3vpal09gnV
 Ph+pgxJb31TxeoB5e7IOSJMFONq0SfrcSFPDAf3dwgNvuoBAzaPn6P+NR/gCrwH7x0f+WPt
 taqgrjc78NGXD7JsbTHrA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KUoe4dz13rE=:z+COSuDiB91j4aMNysrgms
 MMVWUoGnTNx8loWGd1YGMk1wGHrLPtvlsSe9i9IIqBBxa7RcpyJlIr11rUIjq3jevfBiKcEpf
 JJJ/W4yul7LbD2Xw4pbdffTq52tz35CYAHaJJoxuNaeCu7T9Oe4YAoTYNsMZC0cX+vo+CFoUV
 qG99lCDjP/QGDHDwEsbahJQr89WJtHiZPtPSeQKIfbQZPabMogsnWlxRKxFppVW7XppyCjcJc
 MB+W9XuNv46INsdB5eJ6kVU8j7SLl/vVzbJPM8m2Ga00M26n9hoswPDInqleQhgIsDK1+g2Xp
 fcNFoEklPddaJ/5EMzFZ0Ef8+weXpO2DkgPkYho9RFp3ao/o9ndH1W2U6zFsMsZLi67f4L5BX
 W2omHzKi0bMFoRIELcKmvVEXOJq7oWPs6v4AbjmrZ1ThxyJHONOpYcRikuIdDYwukrVunypxt
 7wsTUpwQ0G+AHU+vNV8zJz2JpVsRQsd7GANqZVPC93Iw9MsE0H06K0PrIZZXKJxVdoxIjZSIS
 9ubFGFywP7ZhQI9YxWpQsmQR77lio5YLX3ixXzWjBR13hJ7HVcCpKGiD2rLv1FiYdr+wn9NTz
 c4ZfHk6jeA1GKmRp5fpa0oKUE4rmKKiCYXYv+1N8dZn4G/ke5fONebyu8VJq99YaDnqABZTnC
 ne7u+34/yNSYTje7DSz5W+l40cPeKb0Uxa1Eg00Fse66vUPrDgYO0k5GhknpSpUxWaNUY19o9
 zri98bn1lrKyQ5uiJ0xX2CKz6YE0n06kJGQH8FlbpYymUgOw8fM0cuaDMaaV0KBW6YgP8mE8z
 v9s7EpVk1Txe/Epom0CiYsyOWsq3UOmv5d4QYnw8MJ0PGoVGLecXgJ5MAA+15j9ZMOaF2CSfB
 HbFuHcyM01TcLecxz2OJQBoHiKH87FXw+rPAzXJdsjObuMnX9vC4jdrPWWhBvErWK1B5OxPQq
 D/FRYAbX2ldUqG8nE605uuFj8C4slB8oCzdridq2RbNkKMyaXShCQe7qXGA1kQHw8fem01F4/
 xryLVYdn+bG5OWyP6J1ayGe/+Y5zoUT5gHIk6h3+gwRBLq3L+PswrXUWTSJ6JqnwApukrW5Rm
 1AQbiIFuSE+/IA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ABI file for informing remaining users of the
deprecation of the legacy /proc/i8k interface.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/ABI/obsolete/procfs-i8k | 10 ++++++++++
 MAINTAINERS                           |  1 +
 2 files changed, 11 insertions(+)
 create mode 100644 Documentation/ABI/obsolete/procfs-i8k

diff --git a/Documentation/ABI/obsolete/procfs-i8k b/Documentation/ABI/obs=
olete/procfs-i8k
new file mode 100644
index 000000000000..32df4d5bdd15
=2D-- /dev/null
+++ b/Documentation/ABI/obsolete/procfs-i8k
@@ -0,0 +1,10 @@
+What:		/proc/i8k
+Date:		November 2001
+KernelVersion:	2.4.14
+Contact:	Pali Roh=C3=A1r <pali@kernel.org>
+Description:	Legacy interface for getting/setting sensor information like
+		fan speed, temperature, serial number, hotkey status etc
+		on Dell Laptops.
+		Since the driver is now using the standard hwmon sysfs interface,
+		the procfs interface is deprecated.
+Users:		https://github.com/vitorafsr/i8kutils
diff --git a/MAINTAINERS b/MAINTAINERS
index e7e40563498f..468ee16ee778 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5365,6 +5365,7 @@ F:	drivers/platform/x86/dell/dell-rbtn.*
 DELL LAPTOP SMM DRIVER
 M:	Pali Roh=C3=A1r <pali@kernel.org>
 S:	Maintained
+F:	Documentation/ABI/obsolete/procfs-i8k
 F:	drivers/hwmon/dell-smm-hwmon.c
 F:	include/uapi/linux/i8k.h

=2D-
2.30.2

