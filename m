Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EC6500892
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbiDNIo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiDNIoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:44:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BBCC3890
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:41:59 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-195-6ePXgX6JODCJZdbal4aiqQ-1; Thu, 14 Apr 2022 09:41:46 +0100
X-MC-Unique: 6ePXgX6JODCJZdbal4aiqQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Thu, 14 Apr 2022 09:41:20 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Thu, 14 Apr 2022 09:41:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Straube' <straube.linux@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
CC:     Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: staging: r8188eu: struct rt_firmware_header issues
Thread-Topic: staging: r8188eu: struct rt_firmware_header issues
Thread-Index: AQHYT26f1QQqfyXJ/0OBQVPgTDvQ2KzvF5Tg
Date:   Thu, 14 Apr 2022 08:41:20 +0000
Message-ID: <51e706400b914552bfda6353020da17e@AcuMS.aculab.com>
References: <94a72ecc-3acd-758b-15a4-a7d56bf03fbe@gmail.com>
 <86a66ea4-45e3-cfa2-9130-f698ae212bfd@gmail.com>
In-Reply-To: <86a66ea4-45e3-cfa2-9130-f698ae212bfd@gmail.com>
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

RnJvbTogTWljaGFlbCBTdHJhdWJlDQo+IFNlbnQ6IDEzIEFwcmlsIDIwMjIgMjA6NDINCj4gDQo+
IE9uIDQvMTMvMjIgMTg6MjcsIE1pY2hhZWwgU3RyYXViZSB3cm90ZToNCj4gPiBIaSBhbGwsDQo+
ID4NCj4gPiBJIHRoaW5rIHRoZSBydF9maXJtd2FyZV9oZHIgc3RydWN0dXJlIGluIHJ0d19mdy5j
IGhhcyBzb21lIGlzc3Vlcy4NCj4gPg0KPiA+DQo+ID4gc3RydWN0IHJ0X2Zpcm13YXJlX2hkciB7
DQo+ID4gIMKgwqDCoMKgLyrCoCA4LWJ5dGUgYWxpbm1lbnQgcmVxdWlyZWQgKi8NCg0KUHJvYmFi
bHkgbmVlZCBhbiBfX2FsaWduZWQoOCkgYXQgdGhlIGJvdHRvbSB0aGVuPw0KDQo+ID4gIMKgwqDC
oMKgLyrCoCBMT05HIFdPUkQgMCAtLS0tICovDQo+ID4gIMKgwqDCoMKgX19sZTE2wqDCoMKgwqDC
oMKgwqAgU2lnbmF0dXJlO8KgwqDCoCAvKiA5MkMwOiB0ZXN0IGNoaXA7IDkyQywNCj4gPiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIDg4QzA6IHRlc3QgY2hpcDsg
ODhDMTogTVAgQS1jdXQ7DQo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKiA5MkMxOiBNUCBBLWN1dCAqLw0KPiA+ICDCoMKgwqDCoHU4wqDCoMKgwqDCoMKgwqAg
Q2F0ZWdvcnk7wqDCoMKgIC8qwqAgQVAvTklDIGFuZCBVU0IvUENJICovDQo+ID4gIMKgwqDCoMKg
dTjCoMKgwqDCoMKgwqDCoCBGdW5jdGlvbjvCoMKgwqAgLyrCoCBSZXNlcnZlZCBmb3IgZGlmZmVy
ZW50IEZXIGZ1bmN0aW9uDQo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKsKgIGluZGNhdGlvbiwgZm9yIGZ1cnRoZXIgdXNlIHdoZW4NCj4gPiAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqwqAgZHJpdmVyIG5lZWRzIHRvIGRvd25s
b2FkIGRpZmZlcmVudA0KPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICrCoCBGVyBmb3IgZGlmZmVyZW50IGNvbmRpdGlvbnMgKi8NCj4gPiAgwqDCoMKgwqBfX2xl
MTbCoMKgwqDCoMKgwqDCoCBWZXJzaW9uO8KgwqDCoCAvKsKgIEZXIFZlcnNpb24gKi8NCj4gPiAg
wqDCoMKgwqB1OMKgwqDCoMKgwqDCoMKgIFN1YnZlcnNpb247wqDCoMKgIC8qwqAgRlcgU3VidmVy
c2lvbiwgZGVmYXVsdCAweDAwICovDQo+ID4gIMKgwqDCoMKgdTE2wqDCoMKgwqDCoMKgwqAgUnN2
ZDE7DQo+ID4NCj4gPiAgwqDCoMKgwqAvKsKgIExPTkcgV09SRCAxIC0tLS0gKi8NCj4gPiAgwqDC
oMKgwqB1OMKgwqDCoMKgwqDCoMKgIE1vbnRoO8KgwqDCoCAvKsKgIFJlbGVhc2UgdGltZSBNb250
aCBmaWVsZCAqLw0KPiA+ICDCoMKgwqDCoHU4wqDCoMKgwqDCoMKgwqAgRGF0ZTvCoMKgwqAgLyrC
oCBSZWxlYXNlIHRpbWUgRGF0ZSBmaWVsZCAqLw0KPiA+ICDCoMKgwqDCoHU4wqDCoMKgwqDCoMKg
wqAgSG91cjvCoMKgwqAgLyrCoCBSZWxlYXNlIHRpbWUgSG91ciBmaWVsZCAqLw0KPiA+ICDCoMKg
wqDCoHU4wqDCoMKgwqDCoMKgwqAgTWludXRlO8KgwqDCoCAvKsKgIFJlbGVhc2UgdGltZSBNaW51
dGUgZmllbGQgKi8NCj4gPiAgwqDCoMKgwqBfX2xlMTbCoMKgwqDCoMKgwqDCoCBSYW1Db2RlU2l6
ZTvCoMKgwqAgLyrCoCBUaGUgc2l6ZSBvZiBSQU0gY29kZSAqLw0KPiA+ICDCoMKgwqDCoHU4wqDC
oMKgwqDCoMKgwqAgRm91bmRyeTsNCj4gPiAgwqDCoMKgwqB1OMKgwqDCoMKgwqDCoMKgIFJzdmQy
Ow0KPiA+DQo+ID4gIMKgwqDCoMKgLyrCoCBMT05HIFdPUkQgMiAtLS0tICovDQo+ID4gIMKgwqDC
oMKgX19sZTMywqDCoMKgwqDCoMKgwqAgU3ZuSWR4O8KgwqDCoCAvKsKgIFRoZSBTVk4gZW50cnkg
aW5kZXggKi8NCj4gPiAgwqDCoMKgwqB1MzLCoMKgwqDCoMKgwqDCoCBSc3ZkMzsNCj4gPg0KPiA+
ICDCoMKgwqDCoC8qwqAgTE9ORyBXT1JEIDMgLS0tLSAqLw0KPiA+ICDCoMKgwqDCoHUzMsKgwqDC
oMKgwqDCoMKgIFJzdmQ0Ow0KPiA+ICDCoMKgwqDCoHUzMsKgwqDCoMKgwqDCoMKgIFJzdmQ1Ow0K
PiA+IH07DQouLi4NCj4gDQo+IE9rLCBJIGZpZ3VyZWQgaXQgb3V0IGJ5IGxvb2tpbmcgYXQgdGhl
IGhleGR1bXBzIG9mIGZpcm13YXJlIGZpbGVzLiBUaGUNCj4gZmllbGQgUnN2ZDEgc2hvdWxkIGJl
IHU4IGluc3RlYWQgb2YgdTE2LiBJJ2xsIHByZXBhcmUgYSBwYXRjaCBmb3IgdGhpcy4NCg0KSSdk
IGFsc28gYWRkIGEgY29tcGlsZS10aW1lIGFzc2VydCBvbiB0aGUgc2l6ZS4NCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==

