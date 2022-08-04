Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4018D589F8D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 18:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbiHDQxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 12:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiHDQx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:53:28 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98550252B4;
        Thu,  4 Aug 2022 09:53:24 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 174735FD06;
        Thu,  4 Aug 2022 19:53:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1659632002;
        bh=7VqOZGtBUV2rPszzt+iOd/uivE15FHVsI8evbC3zCPg=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=eHQCywSVaPtlqKMhx494PMfhccsQ6LkWBwuqmwxX0aR3pQ9Dupxm3rEGu27kS82Yd
         MadISbStWePQJuOT4M8KSDFhslHuOJr5ZtnHERDK9Jdg3+7eaiBhf4aMRrbpaB9qJ5
         mEeSZsZHMnGzldlzRn3mKNNNEKxolhHlkRiLaZ6w3aeb3zKeU54qLyUM0EDIXRv7wf
         RBou3VFs5y8L0PWsyG3CD3ulOJfeH8mQkeKwi7VUydTAMlk2QyWSF2OZMav48ytZHo
         WtSXZDLXFlW7SwBjP/vL728whqeweaCpDwzOFbD6xiUgnh/vUoYBIKmBNR6cMfBCKc
         B4L9ecwOLWLJQ==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu,  4 Aug 2022 19:53:20 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: [PATCH v1] arm64: dts: meson-axg: reserve memory region for Amlogic
 TrustOS
Thread-Topic: [PATCH v1] arm64: dts: meson-axg: reserve memory region for
 Amlogic TrustOS
Thread-Index: AQHYqCKmlgn31IcXkUK0U/+U7ZMA5w==
Date:   Thu, 4 Aug 2022 16:52:59 +0000
Message-ID: <20220804165317.29086-1-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/04 12:57:00 #20050432
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the all AXG SoC based boards, which run Amlogic vendor ATF and
TrustOS this memory region 0x5300000-0x6300000 is reserved by BL32,
so tag it as no-map in the kernel iomem.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/d=
ts/amlogic/meson-axg.dtsi
index 3f5254eeb47b..1fa0d3805969 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -142,6 +142,12 @@ secmon_reserved: secmon@5000000 {
 			reg =3D <0x0 0x05000000 0x0 0x300000>;
 			no-map;
 		};
+
+		/* 16 MiB reserved for Amlogic Trust OS (BL32) */
+		secos_reserved: secos@5300000 {
+			reg =3D <0x0 0x05300000 0x0 0x1000000>;
+			no-map;
+		};
 	};
=20
 	scpi {
--=20
2.36.0
