Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1745E4DB1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354509AbiCPN4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbiCPN4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:56:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49EC32DAB3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:55:22 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-10-OIxdLdHeP1as21Jigfr0hw-1; Wed, 16 Mar 2022 13:55:18 +0000
X-MC-Unique: OIxdLdHeP1as21Jigfr0hw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Wed, 16 Mar 2022 13:55:17 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Wed, 16 Mar 2022 13:55:17 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vignesh Raghavendra' <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>
Subject: RE: [PATCH v2 0/6] spi-mem: Allow specifying the byte order in DTR
 mode
Thread-Topic: [PATCH v2 0/6] spi-mem: Allow specifying the byte order in DTR
 mode
Thread-Index: AQHYOQSPIX1seC7nAUuKrYcK6uPoWazCAVMg
Date:   Wed, 16 Mar 2022 13:55:17 +0000
Message-ID: <9bc530d1fdaf4490a00fee150f963ac7@AcuMS.aculab.com>
References: <20220311080147.453483-1-tudor.ambarus@microchip.com>
 <76eb13b6-9263-975f-3196-312259634301@ti.com>
 <b60064231d33581c20279172cf8f765e@walle.cc>
 <0f271365-354b-82e2-02a2-9d69a6ac85b1@ti.com>
In-Reply-To: <0f271365-354b-82e2-02a2-9d69a6ac85b1@ti.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhvdWdodC4uLg0KDQpDYW4geW91IHJlYWQgdGhlIGRldmljZSBpbiBTVFIgbW9kZSB1bnRpbCB5
b3UgZ2V0IGEgc3VpdGFibGUNCm5vbi1wYWxpbmRyb21pYyB2YWx1ZSwgdGhlbiByZWFkIGl0IGlu
IERUUiBtb2RlIGFuZCBkeW5hbWljYWxseQ0KZGV0ZXJtaW5lIHRoZSBieXRlIG9yZGVyPw0KDQpD
bGVhcmx5IHRoaXMgd29uJ3Qgd29yayBpZiB0aGUgZGV2aWNlIGlzIGVyYXNlZCB0byBhbGwgMHhm
Zi4NCkJ1dCBhIGNoZWNrIGNvdWxkIGJlIGRvbmUgb24vYWZ0ZXIgdGhlIGZpcnN0IHdyaXRlLg0K
DQpJIHN1c3BlY3Qgd3JpdGUgdGltZXMgYXJlIGFjdHVhbGx5IGRvbWluYXRlZCBieSB0aGUgdGlt
ZSBzcGVudA0Kd2FpdGluZyBmb3IgdGhlIHdyaXRlIHRvIGNvbXBsZXRlPw0KKE5ldmVyIG1pbmQg
dGhlIGVhcmxpZXIgYmxvY2sgZXJhc2UgdGltZS4pDQpTbyBhbHdheXMgd3JpdGluZyBpbiBTVFIg
bW9kZSBwcm9iYWJseSBtYWtlcyBsaXR0bGUgZGlmZmVyZW5jZT8NCldyaXRlcyByZWFsbHkgb3Vn
aHQgdG8gYmUgdW5jb21tb24gYXMgd2VsbC4NCg0KU3BlZWRpbmcgdXAgcmVhZHMgaXMgYSBkaWZm
ZXJlbnQgbWF0dGVyIC0gYW5kIHByb2JhYmx5IHVzZWZ1bC4NCg0KT2YgY291cnNlLCBpZiB5b3Un
dmUgZ290IGhhcmR3YXJlIHJlYWRpbmcgdGhlIHNwaSBtZW1vcnkgaW4gRFRSDQptb2RlIGZvciBj
b25maWcgZGF0YSB5b3UgbWlnaHQgbmVlZCB0byBieXRlc3dhcCBpdCAoY29tcGFyZWQNCnRvIHRo
ZSBTVFIgd3JpdGVzKSAtIGJ1dCB0aGF0IGlzIHByb2JhYmx5IGEgMm5kIG9yZGVyIHByb2JsZW0u
DQoNCkkndmUgZ290IHNvbWUgYmVzcG9rZSBsb2dpYyBvbiBhbiBQQ0llIGZwZ2EgZm9yIGFjY2Vz
c2luZyBzcGkgbWVtb3J5Lg0KVXNlcyBhZGRyZXNzIGJpdHMgZm9yIHRoZSBjb250cm9sIHNpZ25h
bHMgYW5kIGNvbnZlcnRzIGEgMzJiaXQNCnJlYWQvd3JpdGUgaW50byA4IG5pYmJsZSB0cmFuc2Zl
cnMgdG8gdGhlIGNoaXAuDQoodXNlcyBieXRlIGVuYWJsZXMgLSBkb24ndCBhbiBvZGQgbnVtYmVy
IG9mIGNsb2Nrcy4pDQptbWFwcCgpZWQgdG8gdXNlcnNwYWNlIGZvciB1cGRhdGluZyB0aGUgNk1C
IGZwZ2EgaW1hZ2UuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

