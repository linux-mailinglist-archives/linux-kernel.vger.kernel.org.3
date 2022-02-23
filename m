Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386B44C1EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244519AbiBWWf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244205AbiBWWfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:35:46 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B89B50E15
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:35:15 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-317-KFU4k30iPlqkQIaat-4inA-1; Wed, 23 Feb 2022 22:35:12 +0000
X-MC-Unique: KFU4k30iPlqkQIaat-4inA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Wed, 23 Feb 2022 22:35:11 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Wed, 23 Feb 2022 22:35:11 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Armin Wolf' <W_Armin@gmx.de>,
        =?utf-8?B?J1BhbGkgUm9ow6FyJw==?= <pali@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-assembly@vger.kernel.org" <linux-assembly@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] hwmon: (dell-smm) Improve assembly code
Thread-Topic: [PATCH v4] hwmon: (dell-smm) Improve assembly code
Thread-Index: AQHYKBTirAZeqAMZek+3xwZDQ1am1ayf9nqAgAG05QCAAA5MMA==
Date:   Wed, 23 Feb 2022 22:35:11 +0000
Message-ID: <63a04993864f4c08923ed753d83cdf37@AcuMS.aculab.com>
References: <20220220190851.17965-1-W_Armin@gmx.de>
 <20220222165432.GA255373@roeck-us.net> <20220222175150.qs32v4outislnqj6@pali>
 <b3cecea1376f4080929f47da2529685c@AcuMS.aculab.com>
 <4b5ca065-06a4-c1ff-ed16-3bbb038ee6e0@gmx.de>
In-Reply-To: <4b5ca065-06a4-c1ff-ed16-3bbb038ee6e0@gmx.de>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJtaW4gV29sZg0KPiBTZW50OiAyMyBGZWJydWFyeSAyMDIyIDIxOjM5DQouLi4NCj4g
PiBBcyBmYXIgYXMgdGhpcyBwYXRjaCBnb2VzIEkgdGhpbmsgSSdkIGFkZCBhICdzdGMnIChzZXQg
Y2FycnkpDQo+ID4gaW5zdHJ1Y3Rpb24gYmVmb3JlIHRoZSBmaXJzdCAnb3V0YicuDQo+ID4gVGhl
biBpZiB0aGUgJ3NvbWV0aGluZyBtYWdpYyBoYXBwZW5zIGhlcmUnIGRvZXNuJ3QgaGFwcGVuIChi
ZWNhdXNlDQo+ID4geW91IGFyZW4ndCBvbiB0aGUgcmlnaHQga2luZCBvZiBtb3RoZXJib2FyZCkg
dGhlIGFjdGlvbiBmYWlscy4NCj4gPg0KPiA+IAlEYXZpZA0KPiANCj4gV2UgYWxyZWFkeSBjaGVj
ayBmb3Igc3VjaCBzY2VuYXJpb3MgYnkgY2hlY2tpbmcgaWYgZWF4IGNoYW5nZWQuDQo+IEkgd291
bGQgbm90IHNldCB0aGUgY2FycnkgZmxhZyBiZWZvcmUgZG9pbmcgYSBTTU0gY2FsbCBzaW5jZSBp
bQ0KPiBub3Qgc3VyZSBpZiB0aGUgZmlybXdhcmUgY29kZSBhbHdheXMgY2xlYXJzIHRoZSBjYXJy
eSBmbGFnIHdoZW4NCj4gdGhlIGNhbGwgd2FzIHN1Y2Nlc3NmdWwuDQo+IElmIGZvciBleGFtcGxl
IHRoZSBmaXJtd2FyZSBjb2RlIG9ubHkgc2V0cyB0aGUgY2FycnkgZmxhZyBvbg0KPiBlcnJvciBh
bmQgb3RoZXJ3aXNlIGlnbm9yZXMgdGhlIGNhcnJ5IGZsYWcsIHdlIG1pZ2h0IGNyZWF0ZSBzb21l
DQo+IGZhbHNlIG5lZ2F0aXZlcyB3aGVuIGEgc3VjY2Vzc2Z1bCBTTU0gY2FsbCBsZWF2ZXMgdGhl
IGNhcnJ5IGZsYWcgc2V0Lg0KDQpJZiB5b3UgYXJlIHdvcnJpZWQgYWJvdXQgdGhhdCB5b3Ugc2hv
dWxkIGJlIGNsZWFyaW5nIGNhcnJ5IG9uIGVudHJ5Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

