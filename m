Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1C3488CA1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbiAIVna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:43:30 -0500
Received: from mout.gmx.net ([212.227.15.19]:53371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237166AbiAIVn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641764576;
        bh=ya9Bsaklh3s8y+uei3uvaHAV5bFUoBRNM50qZnB/OTI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Mz830yC5K5Z5HU2V7AxizqnF2jXjojFiauwJep5ABpJRnRDEyscbUoaAWoaCJrqHO
         MSolwbERN8iA5B24GrlUZFfwoGZ4f2/QCLhEY7egkcec02dcgewPLHQIbfGBqiAmcJ
         7siuvJ8BQdd/Y7//RqirEYvly/dR2V/NS+qeg+cc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N9dsV-1mLBZt2W6H-015bgf; Sun, 09 Jan 2022 22:42:56 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        rdunlap@infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] Documentation: admin-guide: Update i8k driver name
Date:   Sun,  9 Jan 2022 22:42:46 +0100
Message-Id: <20220109214248.61759-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220109214248.61759-1-W_Armin@gmx.de>
References: <20220109214248.61759-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HkGcuEhonPWgkx/Bdh5ku/XiW0odT7eYwVlzJd1IFE2UutpCtsh
 9+fimn+CJrRIcYgH3yuOsgzXKU7mDc1Oz+xPS3LPVYsWi4if7n2QCsybxonjMByMATOMZMY
 9Rkct3scclOEw0tcumSZhbAzNT6sJV5S8/TpHpYdgjtDbaitPcJdBWRwecCfVaAur0mrvxn
 04l29arh5dzonS+mUSKow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E8ADvt6FE70=:qvgPE3EtQyZwhdWlZNf62g
 9mTgNdSxtF135Nw7zlb9jVWCBTSOfdw1epgUceyXeqa9UkCvAsOiikpDFpqmR0rkOFtHDkSfH
 9kBX74SIfaxGQAgVHjTggdcG2l/CZLHobQPY0vEgbY04ACcbkXiiPjkdGSs12lnq7kwQVt5eK
 k21bJ51tyW+0IzaEibsSd3c4y0sDdrPvqqVtvATTqoKfY7i8GiuhWzYttQ2KGlv+FW+yIAjG/
 3xFdyTPw5H45icHdRFidBeAcufKS0b9XtdI/GhEGL9vd5fUp3K+7ssB5h+DZfbF7elDd3GRcd
 GeUKk1+EbFp3lZOVkr8ri7SYJNd4ZVHAuXsE6Ofaa6/9UIq9gJdBqM+VAS3Qd8/0oXRSXoqgz
 GkD1AuUj7Ge4PqWlxiOtCdPmMFXIsHWZS8JYdUpew/R7Vor9YWzm+REs7e02QC+2zSAuOk9zR
 WBRAzQUcaa7XARQxGnyKFtiVUh0CtgmtXhQn6iGgXiSsVSW/SHserHRTMrQee7ssa4XOOJwAX
 xeJNYqDVsTLcXtL5Mem3j+6CfWaS8es7SaQhjIaRP+rCak8p3+FDoir0/UCVbeKtX/dysUDjC
 JuJ59PMZ9DdwsrSNY3IC059mpS/uGklZP6O88pHtVCYsB+Pi/itkoJjPXZCVASsf3xQdV412F
 sg9fw7MpOZinUMiKDaNhGFQs69tfot+2DdM6DYaFgUsXgvflO8CRRlqkBnePI8svJ14Jlehe8
 J8nQTL75xgs/ukyiWFvYSZiYdE3231AG8LUViaZpZpsKJIgjWsRvs5x4Cow++8x56EPCeGkkO
 QcMrypoUhAskwtQNHW0IOz/N80S3vQl8m+njmBg30v38G2V9Co11gCc3/vAsmalhR9i6wdAKa
 RJxJhHzIBoXilDAJ6izcUYCXrygriwGoiBzJITv5CRswGWhKXhiZpwsCiBIT93J0IogPaQC0o
 /Pc65cCq3qJ7AgrqUUk4WCDu00vntjL8p+knmxaftrFUljSdzYUjSMniFwYSJmwGTCk3JWRv4
 b/ULhlibAuBwbk3QQcb0++3ByAVcsui1JPfWkiZX7W4xJwo31jz0O5KJWCzMI4DxQI/6oW9ot
 6MQTOkQ5DWhyNo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver should be called dell_smm_hwmon, i8k is only
an alias now.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 .../admin-guide/kernel-parameters.txt         | 29 ++++++++++++-------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentati=
on/admin-guide/kernel-parameters.txt
index 2fba82431efb..52de7cd06858 100644
=2D-- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -935,6 +935,24 @@
 			dump out devices still on the deferred probe list after
 			retrying.

+	dell_smm_hwmon.ignore_dmi=3D
+			[HW] Continue probing hardware even if DMI data
+			indicates that the driver is running on unsupported
+			hardware.
+
+	dell_smm_hwmon.force=3D
+			[HW] Activate driver even if SMM BIOS signature does
+			not match list of supported models and enable otherwise
+			blacklisted features.
+
+	dell_smm_hwmon.power_status=3D
+			[HW] Report power status in /proc/i8k
+			(disabled by default).
+
+	dell_smm_hwmon.restricted=3D
+			[HW] Allow controlling fans only if SYS_ADMIN
+			capability is set.
+
 	dfltcc=3D		[HW,S390]
 			Format: { on | off | def_only | inf_only | always }
 			on:       s390 zlib hardware support for compression on
@@ -1694,17 +1712,6 @@

 	i810=3D		[HW,DRM]

-	i8k.ignore_dmi	[HW] Continue probing hardware even if DMI data
-			indicates that the driver is running on unsupported
-			hardware.
-	i8k.force	[HW] Activate i8k driver even if SMM BIOS signature
-			does not match list of supported models.
-	i8k.power_status
-			[HW] Report power status in /proc/i8k
-			(disabled by default)
-	i8k.restricted	[HW] Allow controlling fans only if SYS_ADMIN
-			capability is set.
-
 	i915.invert_brightness=3D
 			[DRM] Invert the sense of the variable that is used to
 			set the brightness of the panel backlight. Normally a
=2D-
2.30.2

