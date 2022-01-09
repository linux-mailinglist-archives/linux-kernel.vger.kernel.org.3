Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DDD488B48
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbiAIRea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:34:30 -0500
Received: from mout.gmx.net ([212.227.17.22]:55791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234495AbiAIReW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641749655;
        bh=iPSBD2awiftOLogxsCMiyQPe19EVPJ9UGcWv/u2KUGk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ATJsY33T9YmuKdN+uMLJvhbXsPtAxZtIC38JHDnj04sP4X9R4hGGa14virZ3nRrBI
         aTc3/c/TSb9J0vkv/PHg8pJXCQ4iNkBZmah/YR1zwxZgCGjoDxEnU0xu1mhXZKNNeF
         q+PhqNfWAUqKIO8d3earntctczFsQsWN2OPn8vQw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.222.244]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hzj-1mP89B43rb-011i7j; Sun, 09
 Jan 2022 18:34:15 +0100
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
Subject: [PATCH v4 2/9] MAINTAINERS: Match all of bindings/arm/npcm/ as part of NPCM architecture
Date:   Sun,  9 Jan 2022 18:29:53 +0100
Message-Id: <20220109173000.1242703-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220109173000.1242703-1-j.neuschaefer@gmx.net>
References: <20220109173000.1242703-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:COUIWzWI3NV8k793KkNeU7tCZhSj5gGen+76B2rEC21V4/TOUhM
 rFExiA4PoIeY4vfvFVZxtWB6P++xcu/O6mxpK0LsbOp2zxWmddopaqcNqB56rTJmeCHR2b/
 jqVYrGSNgGRuxYGtGkOsoBDjyFQVaY9CgbKbubr7u8MZPoQvFQOiM+8opA4K0XZTAyuef1q
 2r12ZDwiBoWTDYGO1q0qg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JsIHhT4hU4g=:u+Qx8ueXfXPIxFGDu9zfO+
 +TLRmpjHI82Ur694DkG9nrhG/DVtKfcVnoWw8jU3ogq/eTQBbcZUA2a3zd56WnTixyL6PXiwg
 LBPv6pJo0TG8agfJUkh1792X+i+VrAbcpPGN3W9ZHQsyqufSlROgnFsvzMNXwfjaTv4OGEDY5
 lD1XM58N+eSEvR4lfnkBtEv/iNlksZCVfIxDcsEZCsmvTa+16FHGhtwS9Ucicu9t91unEwSeE
 4RO2yV+52tliahtEnfHinmsGRcrw2Rx7UPdkIdGNhegw4I1nV4oHhP0PJHcycOmfXAmfjJqoX
 0pFmETpvKfiCcYGrIrRd7eZoz9aUIUvypxX5NYxcdxmOOISfjkmPfyHsaM+GekVNsxbY2F39J
 LY3clNkEEINnFfHNadlp2ouGBQE6YVyAYDc4WyBluMzQulMw9Tp8yphkdDOj/jGtzME3BESFL
 egV3+HauBSCV6kcmNFDQ6uz2eC7U+d/Sw+TdsnKwHdOofPg9lNKTyi6r3Jyr+fTw6/wtKPLIB
 roaxzqoqrXl4kz9nxj58mDJcR3u1ECy70KZ3m/vfT/uEdDFv6IpzwQq3mQnoi4ALu5+nfRIE9
 qmWeQ2liR5Tj/85UsEaxUTwk6QV+UCPbImSZFQJrJTLgrB9WFKltV89jqws8dYCPavaL3bwH1
 g/q7UTodHnqPTW+J72ucWNL0SqH+gFmE9RKV/IDS7rdmfXskoTBoRW71yK2rW55Zmkhr4ejC/
 gYDhvjNd70g+ArTEgEOP4cylwrYzxyViwV2JVm0EY5E2aUeLoyn/bmOt7S/R4PvUfqwTWS4yO
 JFBx6mNs4a469y9DyW6cHa1Su8av64I/EehnXZWfxXvHaBEmFmdbjyIm/l7BxWMsxw6wfz7eM
 3fwNZZgo1alZxnGq2eqRLvRvNda8LJSCdTY+xXhwG3q5/YViVGTzeQnkCULSe0O9E9e22dVwl
 hVxaYxCVuj3VOFAtQnpi2fqu46jgPODL0Eetd3OlrBxQpt4ko0npnvdD+twRB3I/lMgdrNoWb
 h46jVVpjGdxzA8XsmbnfLzBOgAH2dPAzb+ks7Kp8XsT37hiZDJ8Qpbob/zwiAfdBNFPuYN+/c
 9P0cB6m7JHeluw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All files in Documentation/devicetree/bindings/arm/npcm/ belong to the
Nuvoton NPCM architecture, even when their names might not spell it out
explicitly.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2-v4:
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

