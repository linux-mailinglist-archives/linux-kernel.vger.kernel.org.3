Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5141D4FA90F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 16:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbiDIOiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 10:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbiDIOiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 10:38:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60429DCE19;
        Sat,  9 Apr 2022 07:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649514958;
        bh=ghNr2zs3nB8uWGOaMVInvT80i/YBm7oEAKKakSvfjK4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YgHVQaVRN98ayrwUocBoKQV1ebg1Xk4gO95TJXL28Cv5urL0frJOq/D7AOBNf3Yxp
         r1cENgW6sPoGp2/sOlsRMscoEdkIifSbL/y1YvX+Rpmk8K04UaMUc3Oahokt36E8TX
         i7SnDizvp4YUK8QFTOql/vR6KRlYlBfkuUfVrWEI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([78.35.207.192]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpNy-1oCo7o0gvC-00ZttH; Sat, 09
 Apr 2022 16:35:58 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org
Cc:     Joel Stanley <joel@jms.id.au>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: nuvoton: wpcm450: Add missing aliases for serial0/serial1
Date:   Sat,  9 Apr 2022 16:35:49 +0200
Message-Id: <20220409143549.2447801-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409143309.2446741-1-j.neuschaefer@gmx.net>
References: <20220409143309.2446741-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UDmceD+wOc+uQq+TihNCEBkomyR+dEQoC35DYTAHqnjZc9Jd4ok
 av/sSSAx3tsVPIG0TcugS3QmFbNZA8bhF6Fgh8CLeiZS5bz9jOnJTEoH18WyvNkEjFosuw0
 eZSjRXXhwUdcf1udrukTEG2dAFn9xU6GGQFPy/TWSxsaqBfX0Sg9rjb7FymSH8LOCmhqLaU
 sp9Z264KX/5u4H4PmEDkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QB55vLoh4ws=:Vj6JcyBgIiHxCFNJJfFbPj
 EItxw2ktRq0GOAtn0xsRuGQ7wxsq1OUR5qzVwC9SaHtHQer1f+ihdHxA46VQZVMftNcKi1vqH
 Rpwl0DMD7v2jZRQTL9x/W11YdcUbiHStcHMHlLdHdy0acgrxUpEUpYWwN9rjq8B0nle8jlhCe
 tWut46ZJtJohM5TngVrtKSktY8c1O6rrNOK60fwFVCBj0Ax8eIXI4h7hJCQqS+WXxKoWMY0/R
 xDMgyOlprJq/8qYLIGoy8oiy5+j64RTEaWhQaXJiDaqDcPKeawPnPSG49VQbs9KT31p9UrYyc
 fAQneqpfeBF+P+3sUSSYwsNd5ZYbbJXwpuCEoMfa0jpWb9BI//NT62Pgb1lLy/aEUvnhJZMuO
 rTByJnLa2Ek8EEckntiQE/OVkEuCPc+Oq9i3PZKKLRjdj+6yjd95wC4Mc6x86/Qu0tFInLuOU
 wvY5sO3IEZVYCVNploTKCILWiDyTlz4T6m2McLBqEfFK6sqkH7OUC+M5lkMwRSbX0karzGsEw
 hNVZsHc/H0JQKwvVrvJQp1iilGGIS2bdQI6/Iz91wq9TEFLNRPEGIp09+d0mTGbYVx/P2/CUT
 T0p8MIhzdMJRlRVzHtyah9lAPhcZX0AoE+MUGapDYiSwKFvbxdcQ1hW20kOc8FDEtB0dCeQ2n
 WTdsnVlm/WXbIyFgf7aYqSyMDuhooqpcQAQiKEUhe4FG5LULt0K9TS7XoY3n4EEiAm6xN/l3A
 1kss2jGVQWR/cn339H4kBQjwUdXyoOLMYHmLWLToPbcOxo+d5xVbI6sI2PcLT6mD6lBwunYo8
 Y5TvlDFgOlgBwG1LwqoIvO5LK7V6kBMvZ5EQ5TwqpEHJxurJoMgZrxWWOclyD+QTjQ/PHF5ka
 B2i7ebWwDZ+ZBJwIeI3OVbyuMVP1mYdfHIxPO5gS5kMagEOV0MhGVmUtML+2BbcCkg2S7zjTi
 usZmHWrO7ojTiPi5D/Z9LfKrmMocN4HYaxIBmqlHWtMGFO/reD3o7kua1ss1ZhqwVibwiBcqX
 sTMD4hVpxyadmZh/ienNGUs0qXB4Y/upA1GDqBZLkPYS5K49lVfhyXebJFT1VqQLIIKYDdw5C
 gqi93z/ZIZ4Z9E=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
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

v2:
- mention WPCM450 in the summary
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

