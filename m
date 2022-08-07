Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7324D58BC10
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 19:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiHGRg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 13:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHGRgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 13:36:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C26A1BD
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 10:36:52 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-82-FauLCPYfM4KoA62FKx-nlw-1; Sun, 07 Aug 2022 18:36:49 +0100
X-MC-Unique: FauLCPYfM4KoA62FKx-nlw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Sun, 7 Aug 2022 18:36:48 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Sun, 7 Aug 2022 18:36:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
CC:     Harry Wentland <harry.wentland@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        "David Airlie" <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Subject: RE: mainline build failure for x86_64 allmodconfig with clang
Thread-Topic: mainline build failure for x86_64 allmodconfig with clang
Thread-Index: AQHYqQIPfwGtm9+LUkavntQYoCiIfK2jthGw
Date:   Sun, 7 Aug 2022 17:36:48 +0000
Message-ID: <cb3ea155c4e149eca30ca870e3f2546d@AcuMS.aculab.com>
References: <YuwRyQYPCb1FD+mr@debian>
 <CAHk-=whptVSSZL=wSUQJdRBeVfS+Xy_K4anQ7eQOky7XUrXhUQ@mail.gmail.com>
 <CAK8P3a2bEaExue0OtNeLa2CVzBx-1dE9w2HZ2PAV5N8Ct9G=JQ@mail.gmail.com>
 <YuwvfsztWaHvquwC@dev-arch.thelio-3990X>
 <9fb73284-7572-5703-93d3-f83a43535baf@amd.com>
 <CAK8P3a3Fv=_+GV9r=k4jP72zZOjJowL-GOue-51EhyVDBaEfEw@mail.gmail.com>
 <Yu1bMqL5tsbq1ojj@dev-arch.thelio-3990X>
 <CAK8P3a3PAxkctN6AXOsoTBTFgwHhk7_OSYwJ4Rgk7Dbs+bc0Qw@mail.gmail.com>
In-Reply-To: <CAK8P3a3PAxkctN6AXOsoTBTFgwHhk7_OSYwJ4Rgk7Dbs+bc0Qw@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAwNSBBdWd1c3QgMjAyMiAyMDozMg0KLi4uDQo+
IE9uZSB0aGluZyB0byB0cnkgd291bGQgYmUgdG8gY29uZGVuc2UgYSBmdW5jdGlvbiBjYWxsIGxp
a2UNCj4gDQo+ICAgICAgICAgICAgICAgICBkbWwzMl9DYWxjdWxhdGVXYXRlcm1hcmtzTUFMTFVz
ZUFuZERSQU1TcGVlZENoYW5nZVN1cHBvcnQoDQo+IA0KLi4uDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIC4uLi4gLyogbW9yZSBhcmd1bWVudHMgKi8pOw0KPiANCj4gaW50byBjYWxsaW5nIGNv
bnZlbnRpb25zIHRoYXQgdGFrZSBhIHBvaW50ZXIgdG8gJ21vZGVfbGliLT52YmEnIGFuZCBhbm90
aGVyDQo+IG9uZSB0byAndicsIHNvIHRoZXNlIGFyZSBubyBsb25nZXIgcGFzc2VkIG9uIHRoZSBz
dGFjayBpbmRpdmlkdWFsbHkuDQoNCk9yLCBpZiBpdCBpcyBvbmx5IGNhbGxlZCBvbmNlIChJIGNh
bid0IGZpbmQgdGhlIHNvdXJjZSkNCmZvcmNlIGl0IHRvIGJlIGlubGluZWQuDQoNCk9yIGp1c3Qg
c2hvb3QgdGhlIHNvZnR3YXJlIGVuZ2luZWVyIHdobyB0aGlua3MgMTAwIGFyZ3VtZW50cw0KaXMg
c2FuZS4gOi0pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

