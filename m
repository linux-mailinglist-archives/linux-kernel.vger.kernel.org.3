Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C82557791
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiFWKMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiFWKMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:12:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5975649F2F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:12:20 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-268-RyhH9ZQgMa2QvCdbd0ptKg-1; Thu, 23 Jun 2022 11:12:16 +0100
X-MC-Unique: RyhH9ZQgMa2QvCdbd0ptKg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Thu, 23 Jun 2022 11:12:15 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Thu, 23 Jun 2022 11:12:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Subject: RE: mainline build failure due to 281d0c962752 ("fortify: Add Clang
 support")
Thread-Topic: mainline build failure due to 281d0c962752 ("fortify: Add Clang
 support")
Thread-Index: AQHYhokZ+bM+BCkygE6dwDLHinT/1K1cxXww
Date:   Thu, 23 Jun 2022 10:12:15 +0000
Message-ID: <b5982766c36049b595e7a5e8168ba612@AcuMS.aculab.com>
References: <YrLtpixBqWDmZT/V@debian>
 <CAHk-=wiN1ujyVTgyt1GuZiyWAPfpLwwg-FY1V-J56saMyiA1Lg@mail.gmail.com>
 <YrMu5bdhkPzkxv/X@dev-arch.thelio-3990X>
 <CAHk-=wjTS9OJzggD8=tqtj0DoRCKhjjhpYWoB=bPQAv3QMa+eA@mail.gmail.com>
 <YrNQrPNF/XfriP99@debian>
 <CAHk-=wjje8UdsQ_mjGVF4Bc_TcjAWRgOps7E_Cytg4xTbXfyig@mail.gmail.com>
 <CAKwvOdmQKo4tZRLWxK2tTvd+OEtUmKJM7XiijLAF8JWMeUzFMA@mail.gmail.com>
In-Reply-To: <CAKwvOdmQKo4tZRLWxK2tTvd+OEtUmKJM7XiijLAF8JWMeUzFMA@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAyMiBKdW5lIDIwMjIgMjM6NDANCi4uLi4N
Cj4gPiBXZSBkb24ndCBhY3R1YWxseSB0YWtlIGZ1bGwgYWR2YW50YWdlIG9mIHRoYXQsIGJlY2F1
c2Ugd2UgZG8gZW5kIHVwDQo+ID4gZG9pbmcgYSByZWFsICJidWlsZCIgb2YgYW4gZW1wdHkgZmls
ZSwgc28gImNjMSIgZG9lcyBhY3R1YWxseSBnZXQNCj4gPiBleGVjdXRlZCwgYnV0IGV2ZW4gdGhl
biBpdCdzIGRvbmUgZmFpcmx5IGVmZmljaWVudGx5IHdpdGggJ3Zmb3JrKCknLg0KPiA+IFRoYXQg
ImNjLW9wdGlvbiIgcGFydCBvZiB0aGUga2VybmVsIGJ1aWxkIGlzIGFjdHVhbGx5IG5vdGljZWFi
bGUNCj4gPiBkdXJpbmcgY29uZmlndXJhdGlvbiBldGMsIGFuZCBjbGFuZyBpcyAqbXVjaCogc2xv
d2VyIGJlY2F1c2Ugb2YgaG93IGl0DQo+ID4gaXMgYnVpbHQuDQo+ID4NCj4gPiBTZWUNCj4gPg0K
PiA+ICAgICB0aW1lIGNsYW5nIC1XZXJyb3IgLWMgLXggYyAvZGV2L251bGwNCj4gPg0KPiA+IGFu
ZCBjb21wYXJlIGl0IHdpdGggZ2NjLiBBbmQgaWYgeW91IHdhbnQgdG8gc2VlIGEgcmVhbGx5ICpi
aWcqDQo+ID4gZGlmZmVyZW5jZSwgcGljayBhIGNvbW1hbmQgbGluZSBvcHRpb24gdGhhdCBjYXVz
ZXMgYW4gZXJyb3IgYmVjYXVzZSBpdA0KPiA+IGRvZXNuJ3QgZXhpc3QuLg0KPiANCj4gTG9va2lu
ZyBhdCBhIHByb2ZpbGUsIHRoZXJlJ3MgYSBsb3Qgb2Ygc3R1cGlkIHN0dWZmIHdlJ3JlIGRvaW5n
LiAgV2UNCj4gY2FuIHByb2JhYmx5IGdldCBmYXN0ZXIgImF0IGRvaW5nIG5vdGhpbmcuIiBTZWUN
Cj4gaHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vbmlja2Rlc2F1bG5pZXJzLzgxYTg3ZmZhNzg0YzEz
ZDBiZjYwZjYwYjFkNTQ2NTFiDQo+IGZvciB0aGUgcHJvZmlsZSBhbmQgbXkgY29tbWVudGFyeS9p
bml0aWFsIHRob3VnaHRzLg0KPiANCj4gPg0KPiA+IEkgcmVhbGx5IHdpc2ggY2xhbmcgd2Fzbid0
IHNvIG11Y2ggbm90aWNlYWJseSBzbG93ZXIuIEl0J3MgbGltaXRpbmcNCj4gPiB3aGF0IEkgZG8g
d2l0aCBpdCwgYW5kIEkndmUgaGFkIG90aGVyIGRldmVsb3BlcnMgc2F5IHRoZSBzYW1lLg0KPiAN
Cj4gV2UgY2FuIGRvIGJldHRlci4gIEknbGwga2VlcCBwdXNoaW5nIG9uIHRoaXMgdXAgbXkgY2hh
aW4gb2YgY29tbWFuZC4NCj4gVGhhdCBzdGF0ZW1lbnQgc3RhbmRzIGluIHN0YXJrIGNvbnRyYXN0
IHRvIHRoZSBiZWxvdzoNCg0KVGhlIHNsb3cgc3RhcnR1cCBtdXN0IGFsc28gbWFrZSBhIGJpZyBk
aWZmZXJlbmNlIHRvIGFueXRoaW5nDQp0aGF0IHVzZXMgYXV0b2NvbmYuDQpUaGF0IHRlbmRzIHRv
IHJ1biBhIGxvdCBvZiBjb21waWxlcyBvZiB0cml2aWFsIGNvZGUganVzdCB0bw0KZmluZCBvdXQg
dGhhdCB0aGUgc3lzdGVtIGlzICdub3JtYWwnLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

