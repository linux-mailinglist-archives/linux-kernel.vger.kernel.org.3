Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13F5502C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354652AbiDOOsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244648AbiDOOr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:47:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25A05F258;
        Fri, 15 Apr 2022 07:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650033923;
        bh=U7dqB8UZdHHYcktusZM81tIBeUrwtsptS8hwCJ84BSQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=X43BrQnSncztZRJImZpjxVHAH4tdWwC1mg3TK029fQVe5t3Vsm9FjvLrhx1LEseRl
         QXPfB7Jer8/hIawzsUUqBVtQ7yDc93uB5N4pUNDpvz8lrsR0rGA9KuxxhOZ3zAfjFN
         UHgXT6/cKRSYVcOMTG+oxIkxyh6zXU1S5UAzb7mQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([185.66.193.41]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVNAr-1nY3652vVH-00SPdx; Fri, 15
 Apr 2022 16:45:22 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v2] ARM: dts: wpcm450: Enable watchdog by default
Date:   Fri, 15 Apr 2022 16:45:18 +0200
Message-Id: <20220415144518.800035-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CqVTFanuaMJnC1Z6w6sDj9tgxzWu5GijeIxMguqHBnYYhkokfWw
 13tsuJUSsMhUZHv9NqBNLVpb4mWXfv/4FM0Slnurg0XLe0f+cd1Ijr/BA6uqo8niJv/WkSS
 vvNGpE45FSMC8RJxIIifsvhtGOjXKJIypse3Zi8A4X4OfD0OkX+UipgN1ReTx2U/ULSbWjK
 33I7CLc4644inmVlcDM3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k0u6G8bhtF8=:gQf5rUo2ESTDBT5j/PSKzU
 ZDyzaomijA0GaJAK8H9BD/W7hd9L5qQHMABuFYjd9yfPED4sXdF2zWGKKfK40pc0/s1nQcl7V
 OWtWhWa3Hjj4D+hAX5yD/Gn78cO+m43TxQ5mwEmLiyv6//mlcgpqkvXZOwcWFcKmfO8f0EGsL
 FoHmeFcOsgcIS7mc5/n3DBE6Yl1qdsJfTZYoA/gBa8u0qmmZo2iQ6LB4eH4FnB8REIx14QADY
 LFVDxGFUk5LGHMKbMgkAnqqCw/jFs2yY4JsV8anpp2ygRnJna2aix3pNBoz2Gv43JEmwo2wtR
 ikrc/pnOn69utRlcOmTCrOPcZ97+I1rxWDWdUOnWAH3klnvdsdjKkEgLjWynb2AvHE8GZ4AtS
 UldfvYt2fXdLVXz+H+iOaEGuX1wT1WXNWRYAenpnfsYHVCKFckPsFLGlJTylkKkHJ2yo09G1t
 9Si+98H3s6d0SvYevTylcyrl8tjGsBgruDdv0ssvyWqM9EXMdOw4gnEy6ITO2MS9tq2gWPles
 LvoS3jKlqNJ775sCcTOtSJoxt7g23sCnSl5DibHJPvfaufNgEA4vMrYdVFq5Og3dofheMusep
 egV5jnJ6gxe4ZG2kOOzWlUZ+vPLa7sZbQvgQlitj1mTWdVldmdCWr126OCdrfXVL2b2ipBZUN
 PTNvG3YZHVsx0qvN5qR0hZF/svIvtNvrwSYxPZ/B7R620gFLQtZP4LyzlBtXwf0O1SYOdscy6
 MEm53gzskZdy6oRVcnd63SVjqJgTkC6yZlSDY65vyznx7Rx6Z9pSB1cyOov8OuFg0ydhqw2bl
 pw0KtSs8FP/rkSx7S4NmNd2aN1SzZdoTcvyz1+QHp1mIsdH+qdE3RGTG5ttojm9TsjQbLkkoy
 kCiZoXJul+9fAjctV4oHCGR0vagTTQr8vntt5B0DQbadpASq+Dgr3RkP3/rYXFV2PJLSiUYWO
 qxgIsPC9YdGTxUj/MahYG1Ke2qkIR9Frc0kUCh3/LpZRT2uI7gKAyLF/9ziZUAnqGuNe+nB8O
 4bkns7XGwhAaVJc73tfO2RRWSzxPfIS9sF83+wmdX0Bvisgu3uotsqFf6fnlcc/xNURD2J63e
 3r1iclEMSgGxec=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The watchdog timer is always usable, regardless of board design, so
there is no point in marking the watchdog device as disabled-by-default
in nuvoton-wpcm450.dtsi.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Joel Stanley <joel@jms.id.au>
=2D--

v2:
- add Reviewed-by tag

v1:
- https://lore.kernel.org/lkml/20220128221054.2002911-1-j.neuschaefer@gmx.=
net/
=2D--
 arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts | 4 ----
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi                      | 1 -
 2 files changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts b=
/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
index 3ee61251a16d0..1ae7ae4804275 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
+++ b/arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts
@@ -77,7 +77,3 @@ &serial1 {
 	/* "Serial over LAN" port. Connected to ttyS2 of the host system. */
 	status =3D "okay";
 };
-
-&watchdog0 {
-	status =3D "okay";
-};
diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nu=
voton-wpcm450.dtsi
index 57943bf5aa4a9..1c63ab14c4383 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
@@ -83,7 +83,6 @@ watchdog0: watchdog@b800101c {
 			interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH>;
 			reg =3D <0xb800101c 0x4>;
 			clocks =3D <&clk24m>;
-			status =3D "disabled";
 		};

 		aic: interrupt-controller@b8002000 {
=2D-
2.35.1

