Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5756582173
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiG0Hqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiG0Hqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:46:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C75B41D3C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:46:48 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-401-LM6uYDMgNFSycAGuuC4rNg-1; Wed, 27 Jul 2022 08:46:45 +0100
X-MC-Unique: LM6uYDMgNFSycAGuuC4rNg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Wed, 27 Jul 2022 08:46:43 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Wed, 27 Jul 2022 08:46:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yury Norov' <yury.norov@gmail.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Subject: RE: Linux 5.19-rc8
Thread-Topic: Linux 5.19-rc8
Thread-Index: AQHYoVj/oO3CsBrn9UivDmnjmh+WW62R1mdg
Date:   Wed, 27 Jul 2022 07:46:43 +0000
Message-ID: <2750dc08eb6c4e6dbbd638310f903bce@AcuMS.aculab.com>
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net>
 <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
 <YuAm5h1B6bsrR/9q@fedora>
 <CAHk-=wgYpJTMMxmfbpqc=JVtSK0Zj4b15G=AvEYk6vPNySDSsA@mail.gmail.com>
 <YuAv+lV324G7pmlk@yury-laptop>
 <CAHk-=wg2-j8zocUjurAeg_bimNz7C5h5HDEXKK6PxDmR+DaHRg@mail.gmail.com>
 <YuBEIiLL1xZVyEFl@shell.armlinux.org.uk>
 <CAHk-=wjpYLLoi1m0VRfVoyzGgmMiNwBhQ0XXG0VWwjskcz5Cug@mail.gmail.com>
 <YuCDscyJotkjNQcH@shell.armlinux.org.uk>
 <CAAH8bW-BNfhuXF_2cO+x2Qc51G-DFskFmKw8hzDHhC+3Rn1ZUA@mail.gmail.com>
In-Reply-To: <CAAH8bW-BNfhuXF_2cO+x2Qc51G-DFskFmKw8hzDHhC+3Rn1ZUA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWXVyeSBOb3Jvdg0KPiBTZW50OiAyNyBKdWx5IDIwMjIgMDI6MzQNCi4uLg0KPiBJZiB0
aGUgZGlmZmVyZW5jZSByZWFsbHkgY29uY2VybnMgeW91LCBJJ2Qgc3VnZ2VzdCBydW5uaW5nIHRo
ZSB0ZXN0DQo+IHNldmVyYWwgdGltZXMgdG8gbWVhc3VyZSBjb25maWRlbmNlIGludGVydmFscy4N
Cg0KT3IsIGRvIHdoYXQgSSd2ZSBiZWVuIGRvaW5nIGFuZCBnZXQgYW4gYWNjdXJhdGUgY3ljbGUg
Y291bnQNCmZvciBhIHNpbmdsZSBjYWxsIGFuZCByZXBlYXQgYWJvdXQgMTAgdGltZXMuDQpUaGUg
Zmlyc3QgdmFsdWUgaXMgdHlwaWNhbGx5IHNsb3cgKGxvYWRpbmcgSSQpLCB0aGUNCnJlc3QgdHlw
aWNhbGx5IGlkZW50aWNhbC4NClRoZXkgY2FuIG9mdGVuIGV2ZW4gYmUgbWF0Y2hlZCB0byB0aGUg
ZXhwZWN0ZWQgdmFsdWUhDQpUaGUgZmFzdGVzdCB2YWx1ZSBpcyB0aGUgb25lIHRvIHF1b3RlIQ0K
DQpPbiB4ODYgeW91IGhhdmUgdG8gdXNlIHRoZSBwZXJmIGN5Y2xlIGNvdW50ZXIsIHRoZSB0c2MN
CmlzIGp1c3QgdXNlbGVzcy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

