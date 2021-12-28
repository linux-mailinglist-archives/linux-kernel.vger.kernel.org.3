Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF473480B35
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhL1QUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:20:06 -0500
Received: from mout.gmx.net ([212.227.15.18]:52269 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235803AbhL1QUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640708383;
        bh=c91afZdekR7n/9J8hO61bQWbB88jCJyRcF24lRYg36g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iiO1LPfRd8dbVY0cmeVzqtjwzDSYJ7K9haOVhrhDnRzVGpzRNemw3LhEB/W+GLIAq
         ONeGsiWn8ZvG9UolAMk2Dnpf+PUORQ95QgC79tGvb30dWGtuaWIVK/11qEchMstZvM
         rN5BlgjVoKdyyXEVNzdRaGxhTHNZxkmr9dDMe2X0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MBlxW-1n9uB12ldE-00CCPG; Tue, 28 Dec 2021 17:19:43 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] Documentation: admin-guide: Update i8k driver name
Date:   Tue, 28 Dec 2021 17:19:22 +0100
Message-Id: <20211228161924.26167-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211228161924.26167-1-W_Armin@gmx.de>
References: <20211228161924.26167-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oEf9xYTbx4frIdpcTOmIK+qJrksnu87+jVjkkC1Y5L8Tke8L/s7
 Z49VWSRfh8kU/+bb/m0KaeiDKbyxHX/rAgTkF8BpsgS8U/ijKaCgLmr9GYJrtYrm+PI9tdh
 dmh16wgSC3sfe4UzdGSXrs0urorAp89pNZKcoY9H9+bJQMWO7GovDpSMCBRMDvvx7RojCZ2
 xZZh+fDt//rJkdfokM1AA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hXoFNjrkM3w=:vhU0OXcAe3XNLJiQ5Liudq
 oR+O11TVNLoWdhNQa3ij9nbxAPOLyCKsz6n5jU9Wr5UKhld8lxvwSw8rTmogxS+EyiOKlQeBF
 nlhjcPg7+Ox0FOMsmTDY8DQG7PWJEmqwETt2S7k9J74esZXFWSSOIx7XX5a/v0EYLTaOCGZ0E
 IztSDIrTX6mzc5j4A+SmfPnYune/a2DS6D/RWo4b2s2S0N2+mYgm3xWoqQbrs2f12GS+LeStn
 uf2umBrgjTSl8RLV/+AIAHc5OIb0Z5qY+ificmgPuXNEeboDxZf8xRancmofsPshB+Fx06Det
 ZXqon4kWZ9vbRc8F1+IdhVYZ3iSkD8CbS25aAv4v/QoOQ+b1P458d2tBUT2AzOzr4Ctv2sUhg
 YNDM6lZh4walzZrcrIVK45kYzeTW6m4Vfyk/eZFx1fHdYJQ3DnoB3gVW8jYkr7pMBc9du2Ltc
 8DjM7e3dKDqksvChj0A0bDRaYrBVWdqetHLyp9vBUonr7UVabtGbXeBKzFjpm2B2z5+h5eSMr
 HrBXLa6EKpwmAtY77i3dvLPYhUz/+Ixe34md8MJ718svJLi9Gr148Vg6M/9p+qj7vSwauZ0OE
 fUMxyR+O3yxt1nWN8NJ4HnkDBZhRoNq557aZTZ/dnpeO5UXOLORhu2VQgfigKycSsFFxNwE82
 UyFYAL7GpiJhoC62tqC1fp4Azlf1b8FUfzS3MxT0rB5kQ9yM4Quny39jjtcQRntZUEtdwHNdX
 ZD4RsIhn/tt0l/10UQDz0nrdyzUnuXT5fKjBv1TOH1SLZt39RwiBQxAZhspCEKF95INm0ByF9
 ZnUvtXUv23DVPi0QmtneLoolVWXiqQTUQOaTU/v4s51zpjitOQD7yvrv5WW+gFJWLc99WzeQY
 4c1EcsU2mR82ZE44/6AWY6lz2l6Dd8gf7mlRmPMK+EKb9bqLwMNVxxuBXe6Wh109bB+LRoxBA
 BCvb6Gp7pAwCvd4K4J7aZHYNkaZmSRMsOVfsYgwdQTd56nUCmm2EmnpJ+M+X0JICf0WxjIIYg
 x15+uoRqs+smNwi8u9PGB+/XD0GJVX8mDPZww2DR5jHVrvXNurrBF3AGClJU8S/7gSA/xaJU/
 s6goLcNabaGZD0=
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

