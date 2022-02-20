Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD24F4BD09A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 19:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242265AbiBTSDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 13:03:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiBTSDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 13:03:43 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0725341636
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 10:03:20 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-17-xCk5Y2ofP4uDn5acdcKC0A-1; Sun, 20 Feb 2022 18:03:17 +0000
X-MC-Unique: xCk5Y2ofP4uDn5acdcKC0A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Sun, 20 Feb 2022 18:03:15 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Sun, 20 Feb 2022 18:03:15 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Guenter Roeck' <linux@roeck-us.net>,
        'Armin Wolf' <W_Armin@gmx.de>,
        "pali@kernel.org" <pali@kernel.org>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-assembly@vger.kernel.org" <linux-assembly@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] hwmon: (dell-smm) Improve assembly code
Thread-Topic: [PATCH v2] hwmon: (dell-smm) Improve assembly code
Thread-Index: AQHYJdVCkKl8QQjZ0kWJRwIdNPLg26ycWRjggAA4sICAACqL4A==
Date:   Sun, 20 Feb 2022 18:03:15 +0000
Message-ID: <075c56861e1e454188db1088b78d3ee2@AcuMS.aculab.com>
References: <20220219211011.16600-1-W_Armin@gmx.de>
 <d66ab183f32c49b2b901b432d284edc5@AcuMS.aculab.com>
 <7d387f96-1561-2eec-43e2-b971ff79d734@roeck-us.net>
In-Reply-To: <7d387f96-1561-2eec-43e2-b971ff79d734@roeck-us.net>
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
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogR3VlbnRlciBSb2Vjaw0KPiBTZW50OiAyMCBGZWJydWFyeSAyMDIyIDE1OjMwDQo+IA0K
PiBPbiAyLzIwLzIyIDA0OjIwLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gRnJvbTogQXJtaW4g
V29sZg0KPiA+PiBTZW50OiAxOSBGZWJydWFyeSAyMDIyIDIxOjEwDQo+ID4+DQo+ID4+IFRoZSBu
ZXcgYXNzZW1ibHkgY29kZSB3b3JrcyBvbiBib3RoIDMyIGJpdCBhbmQgNjQgYml0DQo+ID4+IGNw
dXMgYW5kIGFsbG93cyBmb3IgbW9yZSBjb21waWxlciBvcHRpbWlzYXRpb25zIGJ5IG5vdA0KPiA+
PiByZXF1aXJpbmcgc21tX3JlZ3MgdG8gYmUgcGFja2VkLiBBbHNvIHNpbmNlIHRoZQ0KPiA+PiBT
TU0gaGFuZGxlciBzZWVtcyB0byBtb2RpZnkgdGhlIGNhcnJ5IGZsYWcsIHRoZSBuZXcNCj4gPj4g
Y29kZSBpbmZvcm1zIHRoZSBjb21waWxlciB0aGF0IHRoZSBmbGFncyByZWdpc3Rlcg0KPiA+PiBu
ZWVkcyB0byBiZSBzYXZlZC9yZXN0b3JlZC4gU2luY2UgY2xhbmcgcnVucyBvdXQgb2YNCj4gPj4g
cmVnaXN0ZXJzIG9uIDMyIGJpdCB4ODYgd2hlbiB1c2luZyBDQ19PVVQsIHdlIG5lZWQNCj4gPj4g
dG8gZXhlY3V0ZSAic2V0YyIgb3Vyc2VsZi4NCj4gPg0KPiA+IFlvdSBhbHdheXMgbmVlZCB0byBz
YXZlIGFueXRoaW5nIGZyb20gdGhlIGZsYWdzIHJlZ2lzdGVyDQo+ID4gaW5zaWRlIHRoZSBhc20g
YmxvY2sgLSBpdCBpcyBuZXZlciB2YWxpdCBhZnRlcndhcmRzLg0KPiA+DQo+IA0KPiBEb2VzIHRo
YXQgbWF0dGVyIGhlcmUgPyBJIHRob3VnaHQgc2V0Y2MgaXMgdXNlZCB0byBnZXQgdGhlIGNhcnJ5
IGZsYWcuDQoNClRoZSBjb2RlIGlzIG9rLCBqdXN0IHRoZSBjb21tZW50IGlzIG5vdCByZWFsbHkg
cmlnaHQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

