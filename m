Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072914A0351
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349788AbiA1WLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:11:12 -0500
Received: from mout.gmx.net ([212.227.15.18]:52023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbiA1WLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643407862;
        bh=bEeUJC3i3htr2+186+xh0G3nfWq3BNhbq5STMlDxzU8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=EH8cb7CRfGs0YUTvH/l16GKFsNxQB07YX1ikEsj13ROfpP8w+G+XaLnKXN2QS1hsC
         Red01BHca3IOiRVGQMsgxf0e2vLCkZ1/sW7SQ3pgkGwGhxKn4uxYT9spcKr75Sj6bT
         haRWXhoVyxPSIob2Mgq8ImQbvyPkA3izsuLsj5Vg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.80.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQiS-1n4C3P3hVG-00AS99; Fri, 28
 Jan 2022 23:11:01 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: wpcm450: Enable watchdog by default
Date:   Fri, 28 Jan 2022 23:10:53 +0100
Message-Id: <20220128221054.2002911-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MFrSRbBqxcvFIu0fH4f2jjf542T47yvK8RSqkovEh64f9ueZ/6c
 Jr8N8OtCAx/OucJW2XgkGiDXB/4ZnBpg3hIPr5Svio06Vfkoba855QMYzg8vUuTFsinWWJU
 3fXMu1IwGRpF2+jy874gIqqdK387TIAQ2DAGZLFepJIIFGCPDyelBRNPaYy3MP1pw5eGoYL
 YrsNy8DUyrQQuqysWQMKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BnV6HWXCrfo=:npCPAtpG1+EP7b0f78X6Bd
 Z+wYWQ6VAcbLOW1hmomXZW+hVgfTZz3lgJnerQ+TM7jn5K6/afq3XRK9IhIhHCA1mmjDqmrsr
 in2BD7J5aBly2ghq0zRUr2xKW7s1UQzmQAjHhdH75A/G6iZ7faEB4pi3+vMrnXi/J9CDHEIrI
 JLxtrfe15SZqfnXmvXboNbS2sU4zaAMhDRYJClysEM6mmCEAP55w88ULXq0sm+0y9qphKKyjc
 eKFySxE2AjbXRyzxJQHAFeQGhaemm+wSckKTtxYKcW5UMDoNQ5miR3xcTN7MlQfXFlCWGcQ7o
 gGt60BbXVdoIK3YV1EpkIuOz7TUXiEGOABr7wSt0M0bLkPLcpsaMTZn6+XHWLs3Edv7G3c4Ol
 floeonwVcT9Xadnw5Am1DjsffCdcoUboo19vkm64yAPo4nw2L7k/ME+qrMkgXvGPDSXsv8bQ9
 +rBUC7wdUU/6hEV9jl89sNQ7S8cKzClsCBgTXqR9qjmzqoE0QTVZpOLvHksqJtqX1FaS3cEe2
 vEEDGq6A2nqSLq0b/ocSVqtLEsz3h/JQtyARyE2m/P6HINyDIXxL7E9ZLVqZmciZJCzntXy9O
 PIdu5qXe0lRbfFQsoqFFQJOkKF/IzBDBq8Jb9Ene27UPwtGsjbwwqkMEwmrFgjOeabHPCSvMP
 gNxYci+ctLmMGNxuEhKFwBlk+WEyUTmauD1PYY3t3m2B3AF6g4cj0VOco46bbi81R5cNFb/3u
 Ymu6xy61StIvGY3d4lhM+ZIbuC9s0pR1YU/QFPnnnpqdbChPTHHlpnQkpkKCA+4M9XEv5QUa5
 nq/i5PJMpXznSj4csaEWsuazKwYFeQL5yVjjdJIupwawEAVUX3LrXUzosBznkeRHLcdkU1DIr
 79PUzgutsKLjb+ORvR5xjGY4MrB8E9goSGQUBnNyYsgODg/4Pl1GJrwJoZMzhp+exW9g7GPm0
 jKM4Q5VfSXJbuYawP3eeXdBKhPDX4cVsGz+HK2aS722pxYjdB6Zg0iKRWg9/A8A7ZuC64Qh6O
 UzIDULQGUlUg6a0pqgpStpbhLXKmsB95EFbxEEnOkEkixjDjViG9kiQwRKjSt4dM8n02Pb4ct
 OUwsumfnzjgm6s=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The watchdog timer is always usable, regardless of board design, so
there is no point in marking the watchdog device as disabled-by-default
in nuvoton-wpcm450.dtsi.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
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
index 93595850a4c3c..b9b669cd632f1 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
@@ -81,7 +81,6 @@ watchdog0: watchdog@b800101c {
 			interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH>;
 			reg =3D <0xb800101c 0x4>;
 			clocks =3D <&clk24m>;
-			status =3D "disabled";
 		};

 		aic: interrupt-controller@b8002000 {
=2D-
2.34.1

