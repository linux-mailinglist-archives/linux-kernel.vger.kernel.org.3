Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E0C488C9B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiAIVnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:43:25 -0500
Received: from mout.gmx.net ([212.227.15.15]:33045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232433AbiAIVnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641764578;
        bh=dt9wXy3a+jM1zFlz+Y/QypeIPptP01fG1Tfyyobg9Co=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=U9sYRWBuSXkk7E9wBWO23V/EMLrVXFu9vuna5YirWBRk0RW+IS2qH5AzdDpdLiP5K
         8U1Mm9RXBwmuW3VcBJMs+V7TMhjaRj5DFco79QGT6yFn6b20betuGy7i0LmsmkB+7R
         CEusBxkSgiaHeo2s/fijgLds21eLmq9phj+HcNAE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MNt0M-1miOr345pA-00OKSy; Sun, 09 Jan 2022 22:42:58 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        rdunlap@infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] Documentation: admin-guide: Add Documentation for undocumented dell_smm_hwmon parameters
Date:   Sun,  9 Jan 2022 22:42:47 +0100
Message-Id: <20220109214248.61759-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220109214248.61759-1-W_Armin@gmx.de>
References: <20220109214248.61759-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V5RKSJu05REciv9/JJj9A61gzsSso2AK9Ssd0Be2fWxY/EwcmFu
 LfcPyYpwXl8pgKpOslwJbLBRzc4ckdC0XYe5X7ZQwkm/UXY0wB42xTCYFFjsGn3ZpWJkwLy
 X+GEAP7n8UYdko0B72Tdfl+gXeRWxqmkmT34bNd1lgHInsk/G94vnGnSXXfpBKspkU4EFs/
 96MHQmwfrZ6Q9zE8bU32A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RQHfK5d0WNY=:A9NH+pfufKGnTyaEet5a6F
 G8o3tBco58mvH68Sgi7c2Qq6wlW620CRlKeHxjcUBLsH/469n97IjRgimUQWebEqr86xm/Ayl
 MwwQ5UNFs+ngeREVOZCxGXE8Pg5hQWNBvgphM5FgQxP9ToMEh0M69JODpKqmWCgLx01seqAq/
 4Hg6d0RhnGsyTUgs95ESz53dRtNl8HVRlN7ISiWQx6abEfhmIrwpRYNVG9ky2K6YimDBIeKfF
 LbzVr9JJCG6q91uxLUplUJznPlENgwl8WMUEsZGX5QXvhLdcQaUKw20on/5oG99+uw8D60dLE
 PlusJFSN5pvx0bWGUfIQ4Z2mOEPPtLTcl+PCqorKH/GV3cXimjlon8G2QCMulI5GUIeqA/4+P
 BS1OMIazGZkgntAsikQ2UJA8LfTWCiTAqSMP1OtavrYF2Mcbf98w74bZ17PB8fvCysVkmXUSd
 xtAcEpywZ7AmFNgtN2wu0sT37dtLrevSjoDZVjrOkjnRu8Eo91jDfQsd4vvDaQPVHQE7y89zz
 qd3qiYwyvHfFn26g3s/0tCy1/emE2Rc4NUd1uoweU9atOvlOb9Lar1x3G2g5UsfcjfxK973ce
 9WSUCaIS2TOY6Xl4+jtXCBN/iIcA1HMt0wmPPdo8Cualyd7tZ3CDxT9RSQu+k9lZBWYInMCSn
 SprkpCWJLmjbYQ5T9ZTucXkAp8Q+prjhHgmVcNqdDmtw+WcH1/qKJXuRt9fjo+HYjLBJNDtln
 eGdd9GEq20/HlZIJJQEngvZEjjZYv0bdl0udbs8+T3bhRrjTbOqMGczbmndBooe79Y40N45GE
 ma8oOWRfNqNouNItUrbb23XMrvTIllColGdtp5QVr0BKiFtbm+qvgrRorCTqTGVWHqPmU5Nq2
 tz15BsXa/NtEzO7bnLL2xIYVJPOAX2nOZytJLH5hOSorK0OxjTFRfrDQ1s77UIjYR9DNvAKQi
 yi5X2S5trfqBLVoaoucPpunYTDHhs7ThaNqO3j55atIQJjuxKCN35+/dZM72ojTEejdV26VfZ
 raAGm/B/ojn2SQlobHvYpFuUn2LqtbgKfBruc5QVvzRp5jbSALOvwDlSIdEqOd4YlG/jbC1Tm
 EM6eqW1QWVlQHU=
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
index 52de7cd06858..5baf4df501e0 100644
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

