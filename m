Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF3248C125
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352121AbiALJin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:38:43 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:52011 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238079AbiALJim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:38:42 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-3-d2ck_VfmPHmbJ465HcGW0A-1; Wed, 12 Jan 2022 09:38:40 +0000
X-MC-Unique: d2ck_VfmPHmbJ465HcGW0A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Wed, 12 Jan 2022 09:38:40 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Wed, 12 Jan 2022 09:38:40 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?utf-8?B?J01hcnRpbiBMacWha2En?= <mliska@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] objtool: Fix -Wformat-truncation seen with GCC 12.
Thread-Topic: [PATCH] objtool: Fix -Wformat-truncation seen with GCC 12.
Thread-Index: AQHYB5bnH5DyDcc48E6EUO/n3E/np6xfH6FA
Date:   Wed, 12 Jan 2022 09:38:40 +0000
Message-ID: <8ccdb9b4c55b40ba984d4dc333f7a13c@AcuMS.aculab.com>
References: <5168172b-d6f2-a13b-5d43-175cd864ebe9@suse.cz>
In-Reply-To: <5168172b-d6f2-a13b-5d43-175cd864ebe9@suse.cz>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFydGluIExpxaFrYQ0KPiBTZW50OiAxMiBKYW51YXJ5IDIwMjIgMDk6MjkNCj4gDQo+
IFRoZSBwYXRjaCBmaXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmcgdGhhdCBzZWVtcyByZWFzb25h
YmxlOg0KPiANCj4gY2hlY2suYzoyODM2OjU4OiBlcnJvcjogJyVkJyBkaXJlY3RpdmUgb3V0cHV0
IG1heSBiZSB0cnVuY2F0ZWQgd3JpdGluZyBiZXR3ZWVuIDEgYW5kIDEwIGJ5dGVzIGludG8gYQ0K
PiByZWdpb24gb2Ygc2l6ZSA5IFstV2Vycm9yPWZvcm1hdC10cnVuY2F0aW9uPV0NCj4gMjgzNiB8
ICAgICAgICAgICAgICAgICBzbnByaW50Zihwdm5hbWUsIHNpemVvZihwdm5hbWUpLCAicHZfb3Bz
WyVkXSIsIGlkeCk7DQoNCkxvb2tzIHByZXR0eSB1bnJlYXNvbmFibGUgdG8gbWUgOi0pDQpUaGUg
ZG9tYWluIG9mICdpZHgnIGlzIG11Y2ggc21hbGxlciB0aGFuIHRoYXQgb2YgJ2ludCcuDQpJbmRl
ZWQgdGhlIG92ZXJmbG93IGNhbiBvbmx5IGFjdHVhbGx5IGhhcHBlbiBpZiBpdCBpcyBuZWdhdGl2
ZS4NCkJ5IHRoZW4gYWxsIHNvcnRzIG9mIG90aGVyIHRoaW5ncyB3aWxsIGhhdmUgZ29uZSB3cm9u
Zy4NCg0KT1RPSCBjaGFuZ2luZyAxNiB0byA2MCBpcyBvbmUgd2F5IHRvIFNURlUuDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

