Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F478480B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbhL1QUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:20:13 -0500
Received: from mout.gmx.net ([212.227.15.19]:58803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235932AbhL1QUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640708387;
        bh=qPVHr1Cdm7utmJPJfaeNrE6YdKsoKYUI7BwWZ99ZbhQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GQFjHZNlFRWDIW9abTceTfUuj/TMntFz0HCuvGqEE/9fA1e6OxpagO8/rgxeP2B/3
         Gt9zF0CDxkoGD4LBohmWvuzGYjTvny1bDvf56XOkAzLyLqqprpxZYFxQh6t5+SVsQJ
         h76EsP8qLLTIFquFlD5oL6T+w7dbq0O7L+cVdR4E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mnpns-1mdZl33Dq6-00pMWC; Tue, 28 Dec 2021 17:19:47 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] Documentation: admin-guide: Add Documentation for undocumented dell_smm_hwmon parameters
Date:   Tue, 28 Dec 2021 17:19:23 +0100
Message-Id: <20211228161924.26167-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211228161924.26167-1-W_Armin@gmx.de>
References: <20211228161924.26167-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:baCPfdgRXByR9IIV9jZkWY838Z+n87kxe2w0CFF7mEGyZDKCNDW
 qjez2O64zrziipTf1hQ0Suj1Z4U3f9wScWqQqPh/o1w2Ba/SnhB70/3lWVBX/dHr31006We
 czcLTJerAHnYVQtsymk6R0g4Je1j8XAUxZdmKrIInOeMMvUpWLKZHDumuLtaj0ZUIUxGaAs
 aJNLLx1vnZyD/TC6JBYDw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HK9BmJl4qlE=:7MUjprLNZPVYdgZdS1/xL/
 CkDaH0Zl/VvheMRH41pASuz6d+ZiH6xEZ5xfTOMrWIrMEAbZzx6fop98AIRkwXmR88m5OyjUA
 kl5xbHPO5HntnNg0KeaFw/iJ0zBN3ieOakotioAdDa3sn4GUNqjs3KASn6tiwE98cO4SVVq8l
 9mOZiWkVACXATj/4WtNn64NhodT9GZ5Kf34kCC7doryJtZvyXyNzCIzwXNG8RbTGTjLzkc8Fs
 yck3INyrK9yanh1laSAAlc+zbZhx8YSquG4X0AloFb7S3tyrjkqu5PnBm1f0F3YJL0q++u3uy
 k+vUemHvn7PozNYvt3GDu7kQwfBiT3M3zXcMWeCZlu0CRQDhbcdFSnfWFYaznmqZnBGFGmtaM
 GQ12pZw3B8wf0NsLp9msaGBQDK8QxLQ9aDVs1mflT49fUo6GnndkbVczTdAfBLw7SlJ/QBX4b
 TujxEEZ0dvGdisKxikAahPq4jhGVnwQLpSE83RH+y9WcZHNbvCZnXnUd3xcybI8aN92SHpl5S
 xD/CdCrYwEi3uISoY4Hc6jxPU29d6t5QCLkJ/lVOLHwO/BLdoPWKeyHMs5PoXF/Wf8sxegm8B
 aoJ2/CA+tkyNUI/MYeJJzq1l2vP2oXoE3T8RI1Q89joDOzYP7SQDaCx4hZbigJ6dZBLM/zivH
 8wWjfJu2vrzXgk5aJgl72tfYi3lIbBT/73fAFXHTKJ/dKKtwXmnltfny8o8mgniO8Qaea3tvn
 HOH2t0BEbAdGzz0h0Pr3h/0R8OKfie3o2DWDZpa8h/1cWQZk9zHdz0WP4u3mbWKfr2i+Pf7mt
 XD9MiQ3NnXZ5UG8UatscOpJFNF3jzuNHP4Sn2QaBhcVI7j9BKt0GB1ITHIDNvDrxP6WDZH05d
 /Z+6t5dQFPvguzyo7ECkHtgookFW5NMKAJeUR03rFR6Y1J4i/ka889qYCwV2KNqq33+lNTWVR
 R72O175/k8yj6+h85m26kdPo0icAwN1CGH862fE/nQujGXA8fYSFCnKcZQiiFjy3I4gxA42yY
 SVqvEOmmHQL7FVZdw6DjuEeiiBajLRhU6sA99c9NTXsY8fX/qkI2qvLP+9AluoERa81orRc9F
 JJjQlnGJm9fTXk=
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

