Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A4A488C1C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiAITon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:44:43 -0500
Received: from mout.gmx.net ([212.227.15.15]:36747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236773AbiAIToe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641757452;
        bh=qPVHr1Cdm7utmJPJfaeNrE6YdKsoKYUI7BwWZ99ZbhQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Xtyy6IzWOjpkqCp0QvthwUmTi4ZZ4alGFT0u0E5ssP8mQTH7s/0gVnDaKYZbiP6Lw
         SirpyaB5vc6MR8TrpiHc7TZtQqCImt0bAXSxmVNGKXXh5wYJzpM7LMEc9gMqC6KiD3
         +RvjJYy8YE3aQ8F00DUoMoEavAO0l5BlG5QtvQtw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MVvL5-1myi2z0Gk1-00RqLA; Sun, 09 Jan 2022 20:44:12 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 2/3] Documentation: admin-guide: Add Documentation for undocumented dell_smm_hwmon parameters
Date:   Sun,  9 Jan 2022 20:43:59 +0100
Message-Id: <20220109194400.58725-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220109194400.58725-1-W_Armin@gmx.de>
References: <20220109194400.58725-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k4vuuxiEuTYynrtzzTLTFeYaypyR6mEbTKd9rEBJq/653rqBD61
 DDGvJak7cKGOaV4jss555kz9DxT21w0oQ5+O67W38Llhg0yskf1XfRAq8OLYeY7ZQAPKb8g
 /5bCOJJHIRBPwhI8RkHZlxagmhYifWaRZ3ArBgA8UG8EIrCvdhehp4cbZaxRrufRD84zc6o
 tGLbEhvSGGJ0JGkR2RtZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DBM0tcQLD/4=:4kx2MA1Z+PM/PShfvSHQDB
 qyBOUbVgWR72e9+h94kadUNjy8E4d728wZ6nPRHEj92pJbVqP1aHPPUNl71eSTYSQ6c4W5b/4
 o4bS1np15VTLRnEmSHz0jIj0b5Kobn9JuLzLX+4WysN4678Unj5Fjwty1JdF/56O5n6K+Tln+
 nON7ra5R0/NLRsKX7CruDkCrPzd4IuyH+AYUAeX7sAQB1XabRP8xJmJzHEIF7hLsQ9AEmogK7
 ie19NCdcPzF7yXwsjYvgogWncpWO0JbMXz6fbWHK7CK4PLTzOXnPzHYO13TbayfZ5UwwKZAn3
 oph15U6haQ1WBH6rRwRUpipJxCiTBjUlOAhQ4Py/cECdlLylPOTp3m3H++Ourz/8WR6X5OrhW
 0ziJ9NkzqO/vU3nkkTwF/SKt6ZiZOVWYOPuUYUtjxjUZwgSxuBS1b+YC8UtQC9cUcaGYc8Or5
 lxc/3o587MpqG7L3eS4MBCvhn/D1s8Y3mc1cJAlcSYCUkwIzhZmZYiF7fiYHUl3N+TDh77xFB
 xH8ncByWehHoIvc5IYrQZX2TGaMlDAI3YBJCd0SbgWgv/B4hn2+Cbq/hwewue/XSbd0PpqOcZ
 Hij65SZJvQTbkq86caklL6CA/0t36ZWQfnU9euJoGvCjqzzj7D5MWl8lCqJ0T/gtB+GN24ZTa
 c5WQp/jsMajVdJmwhBACSJduPsG2ymrDZqSWQ/qiIHidsVMmmkqKFUXwsY6pD63cALhppg0oY
 f1Pk0WYebFmVlc6cYZIxjWzeopakv6WJNeg3XxGVVWzXanTF+HtGf9s17Y9OKeGcIoegooTpl
 EiBj5/GR95sCHfLiAgi6uhuVNHP4Z4IpdFqBK0HRvbeJ1GAvqGw0h/9KmmoW059cb5E28OecB
 9WXO2QHBrCVxPyhT+zPhN8io8lSnG63YGCYKpz6PVLJwuFYlXyRqJ9VLnnDokMHhl9bDswyXy
 IQWTA/hAwMJ0qugjhX023Q9S1y2cLWEd+q8ClbXhNeguW+a7sctzJVugvcAYTzFHZDjLVofUm
 RcSqHO7CIHb7vWUvZaNtvJgmW6aGsRgD/7xSm/dx2qCkRGu5hlCXDzMNDx4GgA+wo8T21n7GB
 sAhCJFM/2PS8sg=
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

