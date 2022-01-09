Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA5A488C17
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbiAIToe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:44:34 -0500
Received: from mout.gmx.net ([212.227.15.18]:38963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236772AbiAITod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641757450;
        bh=c91afZdekR7n/9J8hO61bQWbB88jCJyRcF24lRYg36g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KUQpPcOfe95vD9e5Oh9cITT7GP/xIJ/Bz5IwG+5/cK1dGA5uJjMH+sBwPRRQb42o1
         QTC13dpJ1QTC5W3aGHC8w73qcHdc3U8iM/9u74NYRa1iSU7jxnRJgIyZpaQytU9lDe
         ADp0CHLgizrOA7ugEbf657hmZDB8YEUu4NpXqLns=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MAfYw-1nDCcs2jV2-00B0mY; Sun, 09 Jan 2022 20:44:10 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 1/3] Documentation: admin-guide: Update i8k driver name
Date:   Sun,  9 Jan 2022 20:43:58 +0100
Message-Id: <20220109194400.58725-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220109194400.58725-1-W_Armin@gmx.de>
References: <20220109194400.58725-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rQPbT50102gs63WTVlswzbMmxrTOjkOUFqhKWRlMrZr0QTK8pql
 W/d3VyYMcpiSdyVVphij3BDBBanhm969bDzBvPjZ8yilhdbPCVUNatWGmtgVq2JHSf3T/tI
 MZ3yNpPckSNAIBphe+Qj6egJ+9XM4brP1k6U193J5U9ZONPLnwzBRxUoOLEUuTFYM+Xhac/
 CqXF+mTkQaNLCbam2GxTQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:avxYAcVIP3E=:CSlPKdPz5PPRKGugCW/men
 WpDjND9qW+B71FbioSmT6vgnYr5N751B1bZD63ycAQfQuXn7thBWRAVr68z2au2r1MJEETO16
 b5NQOD/W0zpc+MYrqeD0dLJqhg1UE+ZnywyR2Xu5Ae/YRREbp0oWBY0tllfmwuYwUv2KpjpjU
 INFAb+JHIJgrHksyCOPjNl8DcRaSmxLIziOoFeU/7riei0drJqLzjIJm5U6XNJl4RY2RvFuDH
 o9QyZlZsHyO0FD6u5i8HEVR9mc4xEm00XBqjrsrLgP5DrHQ58Cw/E1O+g+wtoCg/BLV0BSO5s
 jHg27wu/HJfii2KKYu8XPoBxnCRAZTlZCjaIK7g6H7ooYwtsV+ze1oFvppzIykuNFy+x/TbeG
 Et0RjyKWok911rajOubc+lmGcN3Yjv/tMJcu1v+d0a0wG+5PO5+8jBdtXEqB16yUutreqR7nH
 MgFUBCRtHma02/1GoBJVJMYT2S7qADQsgBOqvFze5eRoAl+EnCRM3T3mj4Ax53CP1dVL2F6oU
 ZOu3JoCa4n5ZmA+jADBRZuUiiR7qIz7ErBm1wDyuTQrLI7SckB5ienVISfvlfhz+/vsnI1AQr
 PneG2ayYtmEIw3eMxsmWyH71Tzd+KS00C+V4gHO5oSTBGisPDIk6KAJRAufraizS9RS4wfQVr
 /cLktDp54o18Q5BeAyboDgF85vrfJSEdkPFCLX+0KFjA9jTkgEZWSNVWmhH8J6+zrzTeU9nfJ
 NGzwynx3+mBUm1lpT8ySH9esxPvZgxy5G9JyDUwjqb3vg4qk6iBOgshjIDTr/B+31bCLQcHj/
 4ZBP5gfegIMtOF7twUaPmcYFkFhzKwR7PZfruAZkNcQYLq21d/wfLG1lT3tf5YmbzV5hf+k4l
 VXTZd1PJ6zfhqZ6P+hJjcGYWikxzQwMqA0GjbQHr2TuL9W/XenYeGl03lau4ipO8gXj0XmKCv
 iHnPeqTkoYxyblJ6byacfIzs+H2dVO/p4GFy3ZCNN/8j5pJx58COqL1xrmO1m5MyNlBESE8Uc
 6b9aTulbr1OkdEcX4kx3F8RHgI+H0O/qY6SDhRJZiQUb8F1zvpk3/rmep+QuU6D1VogDOCQ5B
 pmR9E0LQJa44ms=
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

