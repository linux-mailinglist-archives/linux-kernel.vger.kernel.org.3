Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5333F480AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 16:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhL1Phv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 10:37:51 -0500
Received: from mout.gmx.net ([212.227.17.20]:36631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235190AbhL1Phq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 10:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640705846;
        bh=bbZNZv7YVts0BSTg8axBu0FBaaXWxw40oFL6h3oO4kU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Xbh8vcA/6H941OgB6NpZwZzzYOWVFOvdoIZFlWu7FmY6DMd2uArFnWqbdetXuL3UE
         H9dKFVS7AtjzGdCA2WnEayVhQv7xXYbiGSc8csg/oXAU1DeTo/nKlTrKUG3KbF2CoA
         g3R7DTK0SgkHgYys0JrfvJCaRtQwT0WyzC57SVWI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mr9G2-1mgtnv49Vm-00oJPa; Tue, 28 Dec 2021 16:37:26 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] docs: hwmon: dell-smm-hwmon.rst: Replace ascii table with flat-table
Date:   Tue, 28 Dec 2021 16:37:08 +0100
Message-Id: <20211228153709.18317-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211228153709.18317-1-W_Armin@gmx.de>
References: <20211228153709.18317-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j5hjnXhSrC44tdrl13+vXX48u5DgbMhMBCCsXS9YoxDMGO5t6Bp
 jjm0uej3cbZxKF0ala+xK8Ohytuyb92Pz+AOHLYVKevJRWVCs76fVAabbQidHdCDAAeqdpw
 U5BXEldKwY0Gh91o7ZvrLsWTFmYfjnooKm+VqMQpFovo5MFDlYmIf1P2sNRzqugT5EXoRj5
 LQmrwH97Aq02J4l3N4pIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:us7u+7OxAkE=:j5psBhkjZbE9nSvP4qRHwE
 WYbPk2d+VyJLYAK/pSAsfF0SBDOcEfBd6syEwaSRh0bgEfYhsE2kfAwOqku+N7/ObSjkErAcM
 4Up4co6iBiguVLlOLwhCL0fqEPhwwoFl0gTLnXir35AJePfDtPj8Bk+expdyH5eiHiw22u8KC
 ToJPefx5MQcZFeZuRTb4rKD/QSdoUSPZve8WHO5ogQ975x938gt9MyUovEeDQeZcZMffuEEot
 lDypFTCQ2Np3Ipm0rKh3DeDl6E/GRJslQoifMtbm1bme0hcUwUYK91LtmfWt60Dcdw6XYg5cG
 EKnL/DqBQeWSJ2otWexEddOwoqR0B9j5Gi6/kw7qTwBcIPvsn2epT//ANZur0BJ7DXvtR2ZWo
 G1cfQbpeBEPY9+PLI+J9hDZcYiOqX2R25zQl8yhbxqNUCZ/oeIjAU4tAZjab6BDH6O1Z7yvOJ
 rbtKOe/HYZUwuARBTkG7/Qf8ZqmXIrSgn0Ak1Yy6XaAKJTz3932BTNgQlSiVtogjPQyQBa6HU
 ux8pLzl3AAFMc6CSl1+ySJip7pTjYd4xbTNDoHwufPUpeQlrT1NfrgrhR/TkMn/X5dsfEw0Gi
 u6bBKO2eGbh27Hr3DHUBPaVmyXJzG6b7h1yuNwzM91HkSJWq3dOcTu9yUWYOdXnOHTO4WKCKz
 /pPh4aCVUbNd1tMCaFqBGUhphKwnaj4PIngE9rC+xBiDlnPYRGdDdLRfqaCDh/KHJg/pvQkSo
 3Z3sXaZujxXCdDTtt86/7HLK4VR79y0Z/5pI3RnDTuTfWmXWS4AGA/8KI/9L6zBUu8a8IxbIY
 vMId8kI+zC7tIEyAFnJtw2U4vH3SgyNp+2Ml2onvROlFON7xvCdRM7Nx2+1pNz4p7Vap+SwvP
 pVuvlNSxwhpttIF71Rd9PlQHpJF742A7KS5dbR0DaIiPMUj1dJnY7qvySGmMronyYlBqKQREd
 O2nZoe09GVD10qbDf7ZN97lNxmWfiPXlZO/RnELDQG6jDo4sOxHXUzz5OPyeQsQeu9akyidFR
 LdhSRW2XPsrkQxhiQYTemYqf+c4WqQPfwSTmiBua+CfIHbnI1bqBqwN6D/7rOpbsfZkDBvd9I
 jYL91pIm5Ml7fA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flat-table is recommended over ascii art tables.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/dell-smm-hwmon.rst | 60 +++++++++++++++++++-------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/=
dell-smm-hwmon.rst
index beec88491171..f1e185e8a3f7 100644
=2D-- a/Documentation/hwmon/dell-smm-hwmon.rst
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -29,22 +29,50 @@ Temperature sensors and fans can be queried and set vi=
a the standard
 ``X`` such that ``/sys/class/hwmon/hwmonX/name`` has content
 ``dell_smm``). A number of other attributes can be read or written:

-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
-Name				Perm	Description
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
-fan[1-3]_input                  RO      Fan speed in RPM.
-fan[1-3]_label                  RO      Fan label.
-fan[1-3]_min                    RO      Minimal Fan speed in RPM
-fan[1-3]_max                    RO      Maximal Fan speed in RPM
-fan[1-3]_target                 RO      Expected Fan speed in RPM
-pwm[1-3]                        RW      Control the fan PWM duty-cycle.
-pwm1_enable                     WO      Enable or disable automatic BIOS =
fan
-                                        control (not supported on all lap=
tops,
-                                        see below for details).
-temp[1-10]_input                RO      Temperature reading in milli-degr=
ees
-                                        Celsius.
-temp[1-10]_label                RO      Temperature sensor label.
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+.. flat-table::
+   :header-rows: 1
+   :widths: 4 1 5
+
+   * - Name
+     - Perm
+     - Description
+
+   * - fan[1-3]_input
+     - RO
+     - Fan speed in RPM
+
+   * - fan[1-3]_label
+     - RO
+     - Fan label
+
+   * - fan[1-3]_min
+     - RO
+     - Minimal Fan speed in RPM
+
+   * - fan[1-3]_max
+     - RO
+     - Maximal Fan speed in RPM
+
+   * - fan[1-3]_target
+     - RO
+     - Expected Fan speed in RPM
+
+   * - pwm[1-3]
+     - RW
+     - Control the fan PWM duty-cycle
+
+   * - pwm1_enable
+     - WO
+     - Enable or disable automatic BIOS fan control (not supported
+       on all laptops, see below for details)
+
+   * - temp[1-10]_input
+     - RO
+     - Temperature reading in milli-degrees Celsius
+
+   * - temp[1-10]_label
+     - RO
+     - Temperature sensor label

 Disabling automatic BIOS fan control
 ------------------------------------
=2D-
2.30.2

