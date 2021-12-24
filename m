Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6016F47F0E9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 21:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353574AbhLXUKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 15:10:01 -0500
Received: from mout.gmx.net ([212.227.17.20]:38969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353554AbhLXUJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 15:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640376590;
        bh=HaUljJfYvuuqFA8oq7ah3AVLtWQzD8U4K0H8GZmOjlE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jOukcigFF5WM+t+R2pAxcZnVJiLDsKToiHqivqx3e5JrtlOUGcngb1yycwqn6ri5A
         OM5IZvetwEMKagD2l3JvJrKExtQzYM74b/6WmVY+9fWt5OHIo5s9qOo/tc2XQZkE97
         KzHWsjwk75HcWIzz7if0pYtCSaLWita0nVoZhj80=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42jQ-1n0qsw1Dmq-0005sI; Fri, 24
 Dec 2021 21:09:50 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v3 2/9] MAINTAINERS: Match all of bindings/arm/npcm/ as part of NPCM architecture
Date:   Fri, 24 Dec 2021 21:09:28 +0100
Message-Id: <20211224200935.93817-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224200935.93817-1-j.neuschaefer@gmx.net>
References: <20211224200935.93817-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cCU/SFNgBI5ImJJbhV6cEAjapdlPeVcDmss9mIEoZEhJKPwdVB0
 lVHtVYgQ8+rg6EjcgjuJHauhPxusMxTLJfyDCJ6HwehlTnNEindDGOq72eywGLu+wzPD8gl
 NfSizCFBcHDkjkGODLBcSRS/XDWxjMCD7h9D/wDSbSuY66VPEUi6BIIcxhfz3K66AcZl9XH
 KdN2rtfiMrWtGKewwheKA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YI04h/2Zjos=:TILy11D8Mpq2Z6LLcbLZKr
 hnfMTDXslS7BqeYjwcQm/ImljaLJG1unDhQGfMTg02yN43l4Q640ecXZBQZehsEyBMgCFNZU2
 ziLsuFht1l0wApJYvBkeeKiUeZrKsT6J1kQkBw4F7BY+E/wRfFIW4njdAUwhRpEp+bXY1DD9R
 n4Tgy5qNT90x9H+9V2LHcvevPJnTtgNN5JhiEG/liSl9ScCHrOSR0wsfdhmRuMthL7dnhCzU8
 QUsdLV7+rBkA8hRs7K2NXGB0LqtUse+ww0/a83DFtj20Q45sq44lXSi+972HeMtB2qiNLikz7
 U27TtHDJ07nXUMkhnuHenYmxj6DGxYhg+jajCqm3M6/oYrgUn+NrgNX5+BF2Rd7CSythjxN74
 tD8im6/YW8+9nA1I6BUj8TWkyBON560j2df7q7YuDfx61rRC8PUuUE9YcrtgehN8ytfk5xV+E
 zDyRRBPkVyojomJdwtZ6hF9GXXTZ/UyYNWxR/xGQggDWudm4cMbnkmliRrTth3EpkwnLoPB2r
 LCQP1ZMiuav6qIsFcicsLZey/KOvCeMEuhrt3z7tKl5Fia4zaLfOTxgdZJLD11a3OI9t/lQHW
 fy0kKrySvw+kGjfhQyBFwGx7y3K7tHxuduwqFnJM0R0c0DwbJOn33oCJM6YeiqWLXdBJ5RnQb
 ggwC3nenK+NhdI1tABomqPVKc0XCrCt31z9Q2bLWRi/zs4z8TH3tYJ4oGEDuhJpJgkSm28zbT
 Ozh8Qxr8JBUB5Wpqk7mOix++jTp3AAwhmRmqQfv9WdcU6QbjGi4i6bf9+8UoIoL/qyovP8e6v
 a9svSCNs+BHETC/+Wt+1SoFSg6FUi2vhrswE0pNIw7vZK2D6xYUJeWYj7W2uty+du9npY9h0D
 MFIqaqGXS5CAFeRtwSHSE9u4M+Pgzoq+aEleTpQ/e4gC//UZwoT7t+xxktDxAhMih5sEQjZkH
 kNOxVKe2E/ffkB35xOXgjeBdHhm7KWXJTlutVRjExpceGJRecQ4L23KmI7Yv3DdwScSD4QuIJ
 02GGRmsd8gxJdSxML7mFpp3E+EeXVm7P3rO1onbEaCEU/rZkdhSqotStv/CqRMbftiprwi5Um
 Jj4FqK9yVxPCow=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All files in Documentation/devicetree/bindings/arm/npcm/ belong to the
Nuvoton NPCM architecture, even when their names might not spell it out
explicitly.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2, v3:
- no changes

v1:
- https://lore.kernel.org/lkml/20210602120329.2444672-3-j.neuschaefer@gmx.=
net/
=2D--
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8912b2c1260ca..123c967936785 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2338,6 +2338,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subsc=
ribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/*/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
+F:	Documentation/devicetree/bindings/arm/npcm/*
 F:	arch/arm/boot/dts/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
 F:	drivers/*/*npcm*
=2D-
2.30.2

