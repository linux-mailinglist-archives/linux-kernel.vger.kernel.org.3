Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EFA480AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 16:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbhL1Pht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 10:37:49 -0500
Received: from mout.gmx.net ([212.227.17.20]:48187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235184AbhL1Phq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 10:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640705843;
        bh=c91afZdekR7n/9J8hO61bQWbB88jCJyRcF24lRYg36g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=LrtQSWfUHsH2DhJR0+CtP8RuiTvKnbcI1eWt5Z/ltQLdgoQVgR0OG1wc2ug1wg4kK
         1LuTI8DaKPmPgFF7jZLvm4Vo3BglyF2RVAeWo4713UgItWnG3dYkpkEt3LMB5JggxB
         4waQltqioA2x4/ek+u3AIM/p+RRVepmifoN+xF4M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MXXuB-1mvwcO0lNn-00Yzgc; Tue, 28 Dec 2021 16:37:23 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Documentation: admin-guide: Update i8k driver name
Date:   Tue, 28 Dec 2021 16:37:06 +0100
Message-Id: <20211228153709.18317-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R3wtB5k5QB/vaq/gRyG5oDuyqO61cUrzJV+LeYSfaGOguXdVrYf
 eZF4Q+STyuyrBPQmwWT5vtkEWd6mTKW3Dgzu29nGS5pX97jUKPHIQ8wT5QgzBna5bPQy1WH
 qGehtHnHCsDFXJP4lduxcpHrpKNhnrJQfz6XqRWlDiZoTkTN/q8bSj3uLhmlPb6ZoTbNIj1
 RFkMNp7CwL/fBtTbWZrbw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TwV7UsymRnk=:9sCgrwSn1LtprEkzrFaemo
 h9kbE43KVK2xRMnEyb7epcxXTgmKYlb7tYk9m5LXLpikw9Sr5W/NnE4GDjJXWiBj5qMF6YSrI
 wDrBTPXiS3DOI2zgW+FD5adodeYA43onUp2NOEE+OyZ+lAwxt/m0sJ0NAmIhXDJXjXgTwvzvt
 L9ZFZzOL92bMAOpaQNCDxUG/eLchuoVxgbFVfMaui4cNNHoizjHhGRs2GrpoFuG/RAZ4szU0r
 0ITgX664dT0aOi0Ho6uerS+Mr2h4T+1aO2ZZTwR3HnQYCJCSht11sAKVvnDaTSa8l+DE8jrsK
 deIuo/4OimlyVPNNFTuz/YN2qdR0tefEBUZdtIVKpSp1r6Rn21JW6XXnRqbtZQr5BOtkDVjGc
 ZwCvjDDekGiUM8fB6m5RSGesv1AnO3wTxltF4w+zNN2zMVP8gAzkjb0e0fpQW4k+/kITAb5rT
 eae7os+KB5kP0WZYfPsaCNTC1zK3nqtAvubv8hzmLTuzy4blrl2niAsXbVo2bDVoe1fKGmeZc
 aBXMKKc1amecmi4ENOAqR+zCKFz6RwC+Mk7jCOrLpc4KvyWvdyuY25aAwMErwlHCTrEHJBvyV
 UKiDNIkpQTgHaQdIdejsrPB0KjR+24YsAfo2mzvp3u4UrkTm6yytfIn+c4rujKoOCrF6gxVXI
 ZiF4dNR4lHulvRcEMTE2yCy3mDLT0RWduL4V/ypb4qGVIocw98DmAP2o3xR65OnUNnjtRU9rU
 93m2Rw3WtMQ/dD7ga8rAnZ+0lqtWaxyMTc+HmzaBxJWMFlEleWmWeqmJigZAwSlwK9T4BbgwZ
 dklDtCENdoFbbBlNT464aTa7oAUPzEPnnDf+e2eGkU2aLHPGj03+N3BpUn+aBTSq0BKEoRBRv
 TgZpxMEpOlKs7ETKfmeCY15MATajiPYVdJNeYS4DcrOCIwfNxqAUfYAR96K2XN4b34xqRYMBi
 NfA5mv+dPkwNiCqV0rgQlx+mjLFZ/2QHQrd2BLFdycFfz+zrkYo/x/wYB+6SHgZ5OuOGwoS1z
 FKdUzbHPSBNQb72ZdR68o5eMH2g553egYr+2N/MHlUpawm/I0g6qTvHFRQtGnGmAq90c15XmF
 9Ad4NCG07qfyuU=
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
index 2fba82431efb..cb1331f85444 100644
=2D-- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -935,6 +935,24 @@
 			dump out devices still on the deferred probe list after
 			retrying.

+	dell_smm_hwmon.ignore_dmi=3D
+			[HW] Continue probing hardware even if DMI data
+                        indicates that the driver is running on unsupport=
ed
+                        hardware.
+
+        dell_smm_hwmon.force=3D
+			[HW] Activate driver even if SMM BIOS signature does
+			not match list of supported models and enable otherwise
+			blacklisted features.
+
+        dell_smm_hwmon.power_status=3D
+                        [HW] Report power status in /proc/i8k
+                        (disabled by default).
+
+        dell_smm_hwmon.restricted=3D
+			[HW] Allow controlling fans only if SYS_ADMIN
+                        capability is set.
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

