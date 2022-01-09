Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDD4488C1D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbiAITop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:44:45 -0500
Received: from mout.gmx.net ([212.227.15.18]:55783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236776AbiAITof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641757453;
        bh=kPS5EfnGgwXkGrSWtnVSZACxfMp0WTeu7Ps3qWfybCs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=em2vBcBd/6+LdZfGI8RjVBiU+MNgz1y7QCdWrt73kokzm0+MlAVtQtB6UWkFBip0S
         uNxe2LS3qflqIUHl9rIkVYBUJHuW99jh2b7IJUqlVPe5g7bnPndOzaMcxfqhusjbRV
         Lgbk7zqPZyzSGORlNXqtdC7xBrzAw5KEABOGRpQU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MwwZd-1m8bRO15Fj-00yUjA; Sun, 09 Jan 2022 20:44:13 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 3/3] Documentation: ABI: Add ABI file for legacy /proc/i8k interface
Date:   Sun,  9 Jan 2022 20:44:00 +0100
Message-Id: <20220109194400.58725-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220109194400.58725-1-W_Armin@gmx.de>
References: <20220109194400.58725-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JEQ52nxrMFsfxy1JnoEUzH10MJYD6S3NCw0kV1Jcn6dkFBs9qbZ
 VUMEOoWysfScbF8A15MJ/F8OGFZptA2fci77hD+Mh9GeSSIs07ONOB49m+bagYl5VPT1nzL
 wbW6A/wYi3KprFg+7TqiDp6FhBl8IoKQWi9wJUTiCZCV6LOWyLIuk5rHfcdKZ0n7RlMYH5Q
 Cp5cUosXb8zserQFIlQWA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:o4+CAvDT8Xg=:IqteRKnyxpmEFMjx52xLLZ
 mPjMR4sJ6JEuhqezL/uzCP3G8d/GSWpF6ncQCjNEDIYyFvpPMHHAVk34Lz4m2TPXDhahkumwB
 WRiZKKeFuIRncm+KqVmszY8JUMcV+vGeKxeOrdqJ4+UxkV8CzhtKm5Rwh6O9oAHhIhJhddrmy
 A8rJME3UQWRNSyDydFoqD+c4xumIR9izZnG6HJYJgj+rVH+G2Ari83EJkZG9ifFa78YUvgImE
 8IcsPqPlfTA7sUgCTNDdUxCcgXMPVMVmzFEWAfTLX/GkMnyDtC5H8ZxXkaiLLbYLbgx5ThUVr
 sGdZXBz9dYkS6Qh64/saKAJyGJE8FDmZ82NEWzR6srV5udpniw17FpblY0xgeHb2pfaUdGCVH
 ZXglCkdS3iqiZ6Zv1hMKUp7/zgyNOf3Ayig1TWU3+6B/KojDJDhYi4IWi9x05czqGRBb5iyMa
 oV6uUTQFb3FsmaGry189bMLEBAYpsqyxfhgfEQUXecl0cfxHeiPpqiETyrcpFXd6NhTZK4eHd
 NXFOSyM6bx0/8p7NcnbPL/uwZaGKXxwV1eFCgxiriO5I5WU2N9qhtsxPBsbRFHiRfN36CRkUz
 d+pBMGEbW8A9WsAYDOVjueITfMFg7/nJJpcyhLbxVXxEonjH5PTvNgr1010ZsSRSvPbxcKE4G
 J1DF0T7sPISjFVvi5eX//VkNKb2ZHiQOey8WcJ7gkezeKQXoqJwfWBpR6h3SU48EcyZGugKOr
 hPpy5D4E9NA51IyJ7wtqMeCApWuj/XNggS/aq+v/i6Da8ZDZ8d5X803+D4hUKq0EeiNBV9wDI
 om9716/2pJhXpIadf8edBxDzLgb3va4YgcAl/O0jL8wAwlIn3HBumjKz/5IrIj3raUd9paaEL
 tICvgCMyusQK4H4t3mygxnSSpG08p2aoEHNE50ARIPSGFYKH0XsgEHNPfkNp7jwnMB5MAv64H
 H/bgVi434Ss2343P3eIQXV61ws5VJ2uktOZXLyqXxPW1aoo2uTfyJTlNnB08KHC4GCyn0PFEz
 yRjF6qRZTP2QhuL1HLvIydbSrqjbFj+8RUj6HbP5vKhTo2IaBSncBUzRaUOdSiWUE025vtK80
 hxu/e5E5uWDZFI=
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

