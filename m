Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8153E488CA0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbiAIVn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:43:29 -0500
Received: from mout.gmx.net ([212.227.15.15]:33883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237142AbiAIVnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641764580;
        bh=kPS5EfnGgwXkGrSWtnVSZACxfMp0WTeu7Ps3qWfybCs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EargdCVjrW8hyz0hpJDLEpIyEyyrzJYx5Wt2VlQkWG2+ETVlsB5MURrXnTJR58/BE
         Uctqj4nBb4Oopw8pVAptW3KCinm3avYW1SJxtTvJNVrFhRXfSFvM6lRBYRPs6Op/nx
         b2+iO6Uodg017Qolnv4Ltqv3be5qDZQkHVgWcgtc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mk0JW-1meG1k2AZM-00kQwh; Sun, 09 Jan 2022 22:43:00 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        rdunlap@infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] Documentation: ABI: Add ABI file for legacy /proc/i8k interface
Date:   Sun,  9 Jan 2022 22:42:48 +0100
Message-Id: <20220109214248.61759-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220109214248.61759-1-W_Armin@gmx.de>
References: <20220109214248.61759-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n+Gp0jcMptB/ibifqTC4swiyOJdkSR41SHtq4gEjSHmAcNhIidl
 OAtn9CKXGhfaBRpTAD7s6VVky/QEU8rgxiZGOgs4zw7h+yeaB3HsYkaDzhVofQakJ68nN0E
 qtTe/yvOR4iXk7D8kWE47xtVsZ+CnodaChGmee85gWUda4SzmizJxYtUozy3zQpWVjg14AW
 3w3eaJFpgFyhfFY3fSeBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:e0yMiVrNWQk=:hkKPhYwmbYC+3p3i7+msaT
 NR4RwYHXMncPXYKUEbqsQJobPwSrqZy8mWuq46TSrGX8fOspF8jyp/QRfTmz2nSGXOmMs7axR
 oiGNg23KJxIIS57Ch7H784K6CMsJyVtSCkGKh+b47Jpv9qT7nr1F1uceAJaUnYObwNw0AaDDp
 TgHY9/uIvMmsulGB0LwgDFugd0G0/9r9Rwr1tXUjHQlvwpMvXhLZHwXrFB4lEVqErloEO2Un/
 YTxpzh5Ikk+RfCUhBjb6dsvzl1Zidck1qc3ErLvvgHiUwAaVAYVPjcGYYbXCNmTVRIPGPoRuo
 nCvB0cEkKE5uovf+ll0/WKU2jc9vRJw3Tfnat8K71Ch+Rsq9qsFR0hpSFPMRage2M37jKysxE
 aS6W0/NykJE0bccFyrYDHNdhHPbGaC2GCRcTVaJlPpihucje9cPNMeyGmgjs25Oy2i3CASCum
 Xac6TzDr7Tgyzm1JNXy24MX7AHXZbBm6ZmwazdlSlRBHuImncz+NfwDlf62rSE3cVJE/VhQ8Y
 DchhWe+ebWIFinOEmy/jRxdNSgdtI7y/l9v+E8/D56SmtKkZ4OnmdMkfUDLZikopJUskAqS5R
 GW7ZHi/+SOqJ5hTNBDVuIZmo8qtaMPGxn+GKdxHYpobqRj4zPuQkdG6/KjKG7EVJmplTLESe7
 mn0Np34lE9VrL67FklIq3bODdV5jaBXTXLgbxZ2K6yGQh5ESedqiO7QUU9meiak0nORY2O0OS
 E8Q6icgB5ogIdUZsZ7UNFaXuKsAs3qYq+0sQM9AUnNZCokAdb9RvLkyrnuieQp+6pJtEKDW06
 CrIBx//GtIiMNV9JHmHMUN0h/+Dcly3I5YZNXqhI1mTpkTstd7ZmojTgusqenAbr+rX+3LYuo
 fC28Bj1Cb9eKH9FYIfsSegT7mk0vpBgI58BaTgQT8AX07rUVL8/qY0NYypUglLbYv8LijJnnH
 PylwMBiiasFyFGKnlUVWMnzOQEKZAHgUI0h6i1c/cbnFbdVKnYocc3JU7LG+wy5Xjl1CmXb30
 SaKI32Ec0Snd2vu31lQQ60NGtcSPk/+axrJ7DgrRtjDhZvwLF8Lkf/JsIXy9LDyI6yQSD9qkS
 lBDJHciJHfPrA8=
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

