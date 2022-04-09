Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6486B4FA905
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 16:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbiDIOfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 10:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242338AbiDIOf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 10:35:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2770637AA7;
        Sat,  9 Apr 2022 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649514793;
        bh=8hN+2AVbFXleT27mHGzC218qFEUyVtCqOPDIaAbNPX0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=VYtBQJ4ZBZgI2YKC51XQHYkbw2j5rDmErWTNFYKXbXO3ZXAYDGhXezPvSqnP7vQBm
         ZtzisTD6h/05mU9+ZLcvA5w+YxM7TBt9PfZYh/GB+FnnnAt92QMYsun3z/1EoEFmfH
         9V63dxMcGk+wfmBT2+kn+ueKToa68O2qYITDZlNs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([78.35.207.192]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQgC-1nqJDs3vvs-00vPuC; Sat, 09
 Apr 2022 16:33:12 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     Joel Stanley <joel@jms.id.au>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: nuvoton: Add missing aliases for serial0/serial1
Date:   Sat,  9 Apr 2022 16:33:09 +0200
Message-Id: <20220409143309.2446741-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iIZmxWytLTz+5+OF4HAMOkkSGGLVy/iwOE4rQF3lm0xhe1C8IgA
 mP/2HFSpfKUGUR5HhsLAbjIZhplUAPi3xtGMOOlq0HatVIJOvbG9ABGJvMkilaKnyPasI/7
 Ghe1SK+JUV6u5GPvWD3u5g1G90+y0CdRSy+vOo4nS5k1nm445bdDn0SIMsiVKxPzGx81iz0
 fr2CtmMkSgjsmn0LjdXKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/LlXazknttE=:+z+MkVSa87IJ4Xv6hrvBc+
 Sfo0R2vSjFWmfRFwJq83Qn2u1D4+v5pdJAe8CTqPaHpJxXqJii2Ca44B32K7ue8N1xuk6dXw1
 CydANBAsinVCRybAcwh2jnUVS/RZzIobX6WJo6WrKDY3LG0EOnOoGmA/NYABpguF8UOe6P5id
 By3HCrUubrFBKW+3b2ElstNE4CP6bNZ6hhbWontQmWKIxNVyVGrKq4zwab+JlgpcQQrkNtcsb
 /PjjFXRLpeGd/nA9k/IDcez3LwtvXrXAmX5No1/aeiNuDBWxPXDMrKx4diInCBELPzJf2m7ax
 EN3GmdKm0go3Lai4KY3SIFFO7gia5SPj6QnByfFw9P4VKHYNwcjyDbo8w16RyoUQ+VzOETKdY
 ZTAPD7VpjDo2guXVbQfnC8E2se80rnqsGjPOHxHJDjkXZaAY0bWpIPxF9wOp0GJxJAPq9UA5S
 tZpsvpKL2Ls9r3hsv6UA/OTLbfwYDlr6t0DFPGmLDMsI6GoJ/XCH4KriMTeyb7zhnIEOAjNkZ
 utajzHMf6PqYPb26VTM01GfbZPX/yeTwghfA58lFxzt9z9LBf71SV5WbH5c/Wa0VOeGPwMFMF
 gHimbfn5Uwau+yGYIStS9L9pyQhsL0khyVcRf7cWR0CpHXdCU6VbLq42aniLCOjhLEYZVebC+
 spLR+kADqTfEU1xUgasT5WYUysfWXE0vJ+Uo5VTs33sqy4YFOd9uBo5fU7P+7AHz+HLQJJO6y
 elVYDJ2ATHZjZG8UoOI7P6uLNonpvp4MN5PLSBNgcHxwV307XpfUKKznKZx/EsIJSiHzlBjtt
 esNUShDyjdfTNbkZbPcH9a5kN5542jzZSmElaepeweP/MZcprOrXbkvNz91li0rk5RV2/eEJm
 L6zomOqUXTXNKF4XuaUVp0eENJCUlMppB3atjK69qXOj5LycR/C/zPSmwuJ18oB6hxky54GoW
 KRtms2U4strSZ6Kh6RR7q+cZwNnm53Gqmu0RTqV7A1Z8a6gcbl7//pFxvpcF6/ShY1eQJUMld
 u1zcpq4w+/R7TtoxCLnXH1zzvydWN4Tyj/x7JoSgCJxItyJoEI1HOedcBnypIOHHNWHXeAiFj
 gidGV207Ov6X3g=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without these, /chosen/stdout-path =3D "serial0:115200n8", as done in
nuvoton-wpcm450-supermicro-x9sci-ln4f.dts, does not work.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/nu=
voton-wpcm450.dtsi
index 93595850a4c3c..57943bf5aa4a9 100644
=2D-- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
+++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
@@ -17,6 +17,8 @@ aliases {
 		gpio5 =3D &gpio5;
 		gpio6 =3D &gpio6;
 		gpio7 =3D &gpio7;
+		serial0 =3D &serial0;
+		serial1 =3D &serial1;
 	};

 	cpus {
=2D-
2.35.1

