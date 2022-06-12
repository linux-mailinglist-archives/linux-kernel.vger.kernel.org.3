Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAD0547A30
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 14:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbiFLMw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 08:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiFLMwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 08:52:25 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8455FAC;
        Sun, 12 Jun 2022 05:52:21 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id B64775FD03;
        Sun, 12 Jun 2022 15:52:18 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1655038338;
        bh=wixm2Rk3ic4J0glv59q+AQGDmb1p23TVRzAMNVKa8X8=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=DFad4pMIWTyl1FWRlH1mHFZdZvFjmRsluP2D9DlxmovnCQWTKHBdjld++nmjuiHwE
         wgdI7jD94Gl0/1QMRlmzv0LOHsGS0O95pyrtNtwC/U+m9KRNiCOygaO1w6QKr4KOV0
         Ep2OUBkxvByxnMR/ejTsK0//FLGNu0cpa8QLYsY4e8V63v1CfbX3QMUDwaJsR0Cdtn
         P2XpSIXzrD5joFryT8CWuVEjkMoVnH0z6dCMtWDfqTb6hYIOL5wrlIRi4G85O0+alS
         nV44cYWl9TgJQXudWvxotpmpcfqUsP2onDd3omIBkXCwV9ik+rHMTyBJCYzkbzctgJ
         E9L1VCBI/AeuA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Sun, 12 Jun 2022 15:52:17 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>
Subject: Re: [PATCH v2 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v2 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYcGNscv5GHcvjkkaBriw+oOvmsq1Lb3aAgAAz8YA=
Date:   Sun, 12 Jun 2022 12:51:34 +0000
Message-ID: <20220612125213.dguu4wj2mk6373sk@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220525181532.6805-1-ddrokosov@sberdevices.ru>
 <20220525181532.6805-3-ddrokosov@sberdevices.ru>
 <9e232b74-6fb0-fd89-a043-71d5faf92cc6@wanadoo.fr>
In-Reply-To: <9e232b74-6fb0-fd89-a043-71d5faf92cc6@wanadoo.fr>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7316D7130744C4469C17EB27A044CCA9@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/06/12 08:04:00 #19750220
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQ2hyaXN0b3BoZSwNCg0KT24gU3VuLCBKdW4gMTIsIDIwMjIgYXQgMTE6NDY6MTlBTSAr
MDIwMCwgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiBMZSAyNS8wNS8yMDIyIMOgIDIwOjE1
LCBEbWl0cnkgUm9rb3NvdiBhIMOpY3JpdMKgOg0KPiA+ICtzdGF0aWMgaW50IG1zYTMxMV9wcm9i
ZShzdHJ1Y3QgaTJjX2NsaWVudCAqaTJjKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgbXNhMzExX3By
aXYgKm1zYTMxMTsNCj4gPiArCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXY7DQo+ID4gKwlzdHJ1
Y3QgZGV2aWNlICpkZXYgPSAmaTJjLT5kZXY7DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiAr
CWluZGlvX2RldiA9IGRldm1faWlvX2RldmljZV9hbGxvYyhkZXYsIHNpemVvZigqbXNhMzExKSk7
DQo+ID4gKwlpZiAoIWluZGlvX2RldikNCj4gPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYs
IC1FTk9NRU0sDQo+ID4gKwkJCQkgICAgICJpaW8gZGV2aWNlIGFsbG9jYXRpb24gZmFpbGVkXG4i
KTsNCj4gPiArDQo+ID4gKwltc2EzMTEgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPiA+ICsJbXNh
MzExLT5pMmMgPSBpMmM7DQo+ID4gKwlpMmNfc2V0X2NsaWVudGRhdGEoaTJjLCBpbmRpb19kZXYp
Ow0KPiA+ICsNCj4gPiArCWVyciA9IG1zYTMxMV9yZWdtYXBfaW5pdChtc2EzMTEpOw0KPiA+ICsJ
aWYgKGVycikNCj4gPiArCQlyZXR1cm4gZXJyOw0KPiA+ICsNCj4gPiArCW11dGV4X2luaXQoJm1z
YTMxMS0+bG9jayk7DQo+ID4gKw0KPiA+ICsJZXJyID0gZGV2bV9wbV9ydW50aW1lX2VuYWJsZShk
ZXYpOw0KPiA+ICsJaWYgKGVycikNCj4gPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIGVy
ciwNCj4gPiArCQkJCSAgICAgImNhbm5vdCBlbmFibGUgcnVudGltZSBQTSAoJWQpXG4iLCBlcnIp
Ow0KPiA+ICsNCj4gDQo+IE5pdDogZGV2X2Vycl9wcm9iZSgpIGFscmVhZHkgcHJpbnQgdGhlICdl
cnInIChpbiBhIGh1bWFuIHJlYWRhYmxlIG1hbmVyKSwgc28NCj4gdW5sZXNzIHRoZSBjb2RlIGl0
c2VsZiBpcyBvZiBhbnkgaW50ZXJlc3QsIGl0IGNhbiBiZSByZW1vdmVkOg0KPiANCj4gaS5lLjoN
Cj4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBlcnIsDQo+ICsJCQkJICAgICAiY2Fubm90
IGVuYWJsZSBydW50aW1lIFBNIik7DQo+IA0KPiBUaGlzIHBhdHRlcm4gaXMgdXNlZCBpbiBtYW55
IHBsYWNlcy4NCg0KVGhhbmsgeW91IGZvciBwb2ludGluZyB0aGlzISBJdCdzIGEgcmVhbGx5IGhl
bHBmdWwgZGV2X2Vycl9wcm9iZSgpIHRyYWl0Lg0KSSdsbCB1c2UgaXQgaW4gdGhlIHYzIHBhdGNo
c2V0Lg0KDQotLSANClRoYW5rIHlvdSwNCkRtaXRyeQ==
