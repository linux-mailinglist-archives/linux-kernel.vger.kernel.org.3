Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CDF480AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 16:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbhL1Ph5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 10:37:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:39765 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235294AbhL1Phy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 10:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640705848;
        bh=kPS5EfnGgwXkGrSWtnVSZACxfMp0WTeu7Ps3qWfybCs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AxezTGMHEE8qUVhmpA6i9S53cdQ5suMw/zET/+XNHe6QAeBCU9GX06JEDV26fabp+
         BAhsJW5Ealo/0SGPBZupDbGDQy20JphQhfBKTV3hvOQp4M3/vJoGEbfSQ25mVZqR3L
         2qOih7++M530cOGQ/q6NnuTx/gKa+pJX061zqKmE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MIMbU-1nGVjw1Pmu-00EPw3; Tue, 28 Dec 2021 16:37:28 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Documentation: ABI: Add ABI file for legacy /proc/i8k interface
Date:   Tue, 28 Dec 2021 16:37:09 +0100
Message-Id: <20211228153709.18317-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211228153709.18317-1-W_Armin@gmx.de>
References: <20211228153709.18317-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J8mEQ+c6SYPp6i+YcC5PdV4fZjzfTA7dETIjgKMS0Ake3y1WPs7
 r5CvpWr0oaVR2gjhz0lnRyRkLC5q8mh7vkS8JEQNdAfKyCCAhVdas+2WtEMCiIcqZakngFT
 sPZ4ixdk9hx+OaX1+P3jMx70thOGPjy4gJhDBx83l/aKONcVavDqZbKCnZEMig83PnQuIIv
 i2/arFfQMLGzdprsDjVXA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZFUnXvHw6fc=:kDORSavUAMP82jiIR3Hxcz
 OvCX6QXgSl9/IZa/Je/EO1VEbNFksfDBZxehXvFW1gFiF31digrPYR9rzfSgFXpTnYJUgJdAi
 lvcTchuk5mJlTAGgk56MBC7sCeAyoas/PSPLf82hJ7jNlCyMfT5alQLCNLg3WaVK5iFQj+0Se
 GMQfesR7MbJ6SKICgeQpZy15F3ojvAlWlCSi1WhVpSomTgLSo0nlETsH9EuHNczIy+xoXFh2u
 i5lZtcW8GaSYbnfpNCe5Mn1mfialfQLeCgVpb2AjxbCcnRJBPdvEkCZ8xDBkmxSx6B5BtxR/v
 cCAPNnQ5fLw6Wuq67gI2cl17bOzdsGyBu2DJSo0CfuRGGlucPvZ1pg5QURCg+Y+ZEcEYF7Txg
 cLAthr3MZhWLu050uaEMsN8EeejDiX/mgWZL4CXJY7WEmSO+mvvD4BeZ4W+dSSFHnIdhsDUth
 ww+cZmtnibW3RBJFnJQ/uDi4Oyng3JMt48JKamhNGFMNyFJ659WRta5rRC6bX9DUYim4yQlXN
 IQsx52EsY4m3kMKnG285gcSvW5K/WE1xJIk5b/a+qeizQ0TzvF+9nHFp5vx/IqPMzbx1gUAyu
 LxA1kXGulAiyBJuVVIiM3M8zuY+lwJqIVKd8eqDrWv3BYN2ds+eAEg8pAvenOUlWlyqkxE5DL
 orUlOx/ecRGr9z+d7xShZdOVd6KFZDX1eqe8lZy2dnyzFNRe0AzSzt3UeND7F1YdIg6BqDiF/
 PzGKpaLbT3BTHlHDqPMPSHQsuzLGEHNqWXEm2HXuH0jP/HS0mbufXb7Elrjg2qgiawstGvPv9
 2s5GpdDkLYuG4c0yZozVSFlqDq+plk4OxW07g1kL4eO+jFbeDmitpUqjk80u3kU5QmVuxuvHR
 bzcxQD7Z50FYBWr3JVh3QeDvh+7zN9UKjddcalPdpQvx9a/+9zdn0iUDvNE4Fc67NXWpZLY/J
 P3Y7VKxFx6CJgn98Jc539TEnatIAIok4ahiihZVq0fDIhjpGcbmQicGtG/dkIpk8n7IH3PdDJ
 QqBwufv0GR0lF8VF92Hsgc6aC56+oW4eMsGO35Va6WxrS8FOVzc+/KNZDo2O0danNE26uNYvy
 5JSsXXuolY8tYM=
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

