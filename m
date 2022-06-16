Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B074D54DF50
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376351AbiFPKmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiFPKma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:42:30 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDFF5DBF7;
        Thu, 16 Jun 2022 03:42:26 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 23B8C5FD09;
        Thu, 16 Jun 2022 13:42:25 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1655376145;
        bh=OtqWenvq4gASapb/XNtEZE80wmXH9V3oLPxzbKlJ/yQ=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=qN2UbRGfiO8stF6CLMreQMnZJR8NfbO2CqJ1UUlfwl1GyyvTJGjMKzDrL9StCsiEa
         i4zFb4PtSZ8VEqlizcX/0YHFhV4Wnp9RhFYb4PF/8eHeiWKbigrUg/HjdBM+PcIGgi
         04/wcbNuzX79TmIlvFGIV4N7FyUaJbufP1Zw/MaqhBT6aSb2b3wSbBUdh8kSWG/wpe
         wk9ISPaPQOVmFXFQk2q4ytLs9ylQh2djkmhozHbp2G92alyXe9tyFruoxbzRuhzEns
         L4hFxXPzAGGWsXlLULk4CoWAF0gFYitwoDidZqzibMxg666NRGBEYIY28XaJxNCQNF
         m9+6K/lTWcLWw==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu, 16 Jun 2022 13:42:25 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add MEMSensing
 Microsystems Co., Ltd.
Thread-Topic: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add MEMSensing
 Microsystems Co., Ltd.
Thread-Index: AQHYgW28uZ0t/D2rMk2EgnQ89F4UqQ==
Date:   Thu, 16 Jun 2022 10:42:12 +0000
Message-ID: <20220616104211.9257-2-ddrokosov@sberdevices.ru>
References: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/06/16 07:44:00 #19785775
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MEMSensing Microsystems (Suzhou, China) Co., Ltd. operates as a micro
electromechanical system technology company which produces micro
electromechanical system microphones and sensors.
MEMSensing Microsystems (Suzhou, China) Co., Ltd. applies its products
in consumer electronics, industrial control, medical electronics
and automotive, and other fields.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index 294093d45a23..632afb05fcf7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -735,6 +735,8 @@ patternProperties:
     description: MELFAS Inc.
   "^mellanox,.*":
     description: Mellanox Technologies
+  "^memsensing,.*":
+    description: MEMSensing Microsystems Co., Ltd.
   "^memsic,.*":
     description: MEMSIC Inc.
   "^menlo,.*":
--=20
2.36.0
