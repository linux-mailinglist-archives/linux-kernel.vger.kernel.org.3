Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFDE480AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 16:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbhL1Phr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 10:37:47 -0500
Received: from mout.gmx.net ([212.227.17.20]:45653 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233403AbhL1Phq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 10:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640705844;
        bh=qPVHr1Cdm7utmJPJfaeNrE6YdKsoKYUI7BwWZ99ZbhQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Tie8b68Xkq+iIQPAjdQae+u7yKEvlhGT1riRgk6dqH2dISgwCW5p5ekSO/NV22yJc
         ZgEQT+p0rtDxjkgK54e0TWH2sRlvU/v9kkKOwbJVY+31313pVXRtbu9kF7/GhqlzT5
         pOYmgkDkCAUCggVQX5ML5zNLchOm9B3X+cZhxVkQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mdvqg-1mTiXC2gas-00b3kM; Tue, 28 Dec 2021 16:37:24 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Documentation: admin-guide: Add Documentation for undocumented dell_smm_hwmon parameters
Date:   Tue, 28 Dec 2021 16:37:07 +0100
Message-Id: <20211228153709.18317-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211228153709.18317-1-W_Armin@gmx.de>
References: <20211228153709.18317-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t0q09+dJktMIkYLEje79XHgVMPeSpXRoIe1bj/Eaq6zjWVLdwYS
 bg6gPAgifd40jlQ0MUzxUxUgGAeO34jIzr6tOhZvaryrWdxkJdGb0JT9ugl0Moh+IVV0lyM
 2rRhS4f+Q1qVU1Rrh5U1+RRw096UGCtC3NsYpHhRQpx6NA5q26ekePX4yo+MI/lZckC5kd+
 03qyYfidrb97bRBDWCJ7g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2AsbUAUm/qo=:BNB+dH9GnMisPdEs7E+Gc8
 ocrP6Myio9Z726EQ7K3FzwaIzxZsLtENRAh06PXv9I+SFPQKPo0EJZ6TuPZnCqRhR9MixxHOl
 x4TrU+/p7YOnl2YhZ2ws742ow6y8dOnZrY6c+DZHsN55dhLNhoeHzoWUPkgT8u6v/heAbO5og
 DKtawjuBhfwFKyZ8q3OKlm1O8Y3jjz8IvsYFaJ4q++1bYdnpq1bHbhJXZaXe5USfE4e86CCNH
 c2SrHEjaaXzEG+tpxDbsEbIutim3vcBXJxOJjU3G6VsJonlBkJxayHKbtkLpd22RbT74XeUcY
 qUOzhjxt5w09NE9vC0A1ba+TRGmUdWV6EsdFEeY78/q3dYO3remAzueyJblHC8buWJYGoxbXb
 8V7XM//OXI6bi5ZBArZhrqa9pCIjdIb8izvII/grFnCCH9IxNeSZinpFA256Gr3ty7zEl5g4B
 gYE/kceSR42GD1ali1WYezSqTRuOxoJmlz4Gh3aX1CI8vL/h3saqC3ZsPC0vrRkvsnPzRG0zp
 sfpOPabODErJO9esDBGL9012OZCjXy9W70jDyObxT5cGO1B3C/ajyhhbANR5wUxk3xcWJga8i
 i0B1rbFH6MCaN77GUha81StlPwWiy1yOjnUwyOlAA23wEHruOq5ffQn1hEnek07vF75nbmlWz
 B70MV7LivgoJu0B02C/9B3LWBCNR3t14cJM42j7GdIIG7OsJ6tDuqIostIz9znk5VNqbXfQLB
 WDAphBHqE1n0ido8INEaM4zvS5fp+B64RunS8NOgqNDSyNaCDU/S7gwOO3Zz28QGaC9dinoSa
 8uRzTpbzkybf+BIQe7+BsnefudKcxwc0A98kJJA7jvGJdMeC5r9mBpFaLjOv9V5xGrWec9qLy
 NiOeWGYSVDqxm0t+ryfZkImRC/Nv8pAAhzA7SCiw3deAtxf8Xdu0lHQ6iDR7Mgj43gc2ddwWe
 +/hhcaL74NmfD5p5lxU4BZpcLcgAq2GOJ3iOWDJbyFvoXvi7a+wFr6jVBefy1MlHNGBBfO4Yd
 AefL2vTUc2zKFoFXNyE2qA80yfXZ7vUSM9LcjSnr4vfZVWLJqjjFA07wxyKdiw06s+CXuekvz
 IH9mzpbz7b/GhQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for fan_mult and fan_max.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentati=
on/admin-guide/kernel-parameters.txt
index cb1331f85444..8dd07ca80934 100644
=2D-- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -953,6 +953,12 @@
 			[HW] Allow controlling fans only if SYS_ADMIN
                         capability is set.

+	dell_smm_hwmon.fan_mult=3D
+			[HW] Factor to multiply fan speed with.
+
+	dell_smm_hwmon.fan_max=3D
+			[HW] Maximum configurable fan speed.
+
 	dfltcc=3D		[HW,S390]
 			Format: { on | off | def_only | inf_only | always }
 			on:       s390 zlib hardware support for compression on
=2D-
2.30.2

