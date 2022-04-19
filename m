Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B0C507282
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354295AbiDSQHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354299AbiDSQHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:07:21 -0400
X-Greylist: delayed 1075 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Apr 2022 09:04:35 PDT
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851EF2E9F5;
        Tue, 19 Apr 2022 09:04:35 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 704D55FD04;
        Tue, 19 Apr 2022 18:46:36 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1650383196;
        bh=OZC35u/pX5KL6JzsDSXXgbOvjAIdQRhngTiwGq4otJA=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=mI1fcKORKqlL/V2KexK8BSH9A9PhCKTq+k8OJ6/RrFDNv/Fyy/5UZO54A77hceCt9
         XbTzly0H5EfuKFW/A3zNW+GrFJRCRR9HUWgK7g8HgoFL1SO0Cu2vwsYe2zJtbGwAh8
         bMvqCLR8Iby16EBoDRF8t59UaETiFj5un0OmEmyjPV1c4Qv+ArmFOZ3m5rwVxjYihD
         ZrFAMR65+KjOZPnHQRzJsncslc2qwHU/v8G+5QhW+f2EzpQPHpd3g40hoBRZqNsrIw
         X805QdAdOK+aq+IghldW9kGGrbUj9m95fo8nt7wekUIHQHTNLHAuzi6x2L5yYb21uI
         zUo4eJww0oMIQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Tue, 19 Apr 2022 18:46:35 +0300 (MSK)
From:   Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
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
        Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
Subject: [PATCH v1 1/3] dt-bindings: vendor-prefixes: add MEMSensing
 Microsystems Co., Ltd.
Thread-Topic: [PATCH v1 1/3] dt-bindings: vendor-prefixes: add MEMSensing
 Microsystems Co., Ltd.
Thread-Index: AQHYVASMsRh3FoyxH0G3KQJPx6YT3g==
Date:   Tue, 19 Apr 2022 15:45:51 +0000
Message-ID: <20220419154555.24191-2-ddrokosov@sberdevices.ru>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/04/19 10:34:00 #19304456
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
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index 294093d..d8f29ad 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -737,6 +737,8 @@ patternProperties:
     description: Mellanox Technologies
   "^memsic,.*":
     description: MEMSIC Inc.
+  "^memsensing,.*":
+    description: MEMSensing Microsystems Co., Ltd.
   "^menlo,.*":
     description: Menlo Systems GmbH
   "^mentor,.*":
--=20
2.9.5
