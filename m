Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE44B592D62
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242203AbiHOKhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiHOKhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:37:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E919A11C13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:37:45 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-122-Hgrs_dzPPQ2BICeey52XBw-1; Mon, 15 Aug 2022 11:37:43 +0100
X-MC-Unique: Hgrs_dzPPQ2BICeey52XBw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.38; Mon, 15 Aug 2022 11:37:42 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.040; Mon, 15 Aug 2022 11:37:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Joe Perches <joe@perches.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Justin Stitt <justinstitt@google.com>
Subject: RE: mainline build failure for arm64 allmodconfig with clang
Thread-Topic: mainline build failure for arm64 allmodconfig with clang
Thread-Index: AQHYrbmR1EwWNARIT0SmjROGCil0pq2vyTZA
Date:   Mon, 15 Aug 2022 10:37:42 +0000
Message-ID: <de9ccf7da0aa441b855fdfbd7761115a@AcuMS.aculab.com>
References: <YvSxeDkmwxcJL+Z0@debian> <YvUZ+9kJ/AvUMxzO@dev-arch.thelio-3990X>
 <CAHk-=wivP4zipYnwNWCLF5cd24GLs3m8=Sp7M-CmmPva_UC+3Q@mail.gmail.com>
 <CAKwvOdnQjgtwqFXLv+QtWPfpHosM5fxE5oqbX0VUD53F8L6bRg@mail.gmail.com>
 <CAHk-=wgJA=e-CLcvU5LRKu0bMLeAewXtOM6as1hFVeQAVkMPbg@mail.gmail.com>
In-Reply-To: <CAHk-=wgJA=e-CLcvU5LRKu0bMLeAewXtOM6as1hFVeQAVkMPbg@mail.gmail.com>
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

Li4uDQo+IEFuZCBvZnRlbiB0aGF0IGNoYXIgaXNuJ3QgYWN0dWFsbHkgYSAnY2hhcicsIGl0IGlz
IGFjdHVhbGx5IGFuICdpbnQnLA0KPiBlaXRoZXIgYmVjYXVzZSB5b3UgaGF2ZSBzaXR1YXRpb25z
IGxpa2UgJ2dldGNoKCknLCBvciB5b3UgaGF2ZSBzaW1wbHkNCj4ganVzdCB0aGUgdXN1YWwgQyBl
eHByZXNzaW9uIHJ1bGVzLCBpZSB5b3UgaGF2ZSBzb21ldGhpbmcgbGlrZQ0KPiANCj4gICAgICAg
ICBpc3ByaW50KGMpID8gYyA6ICcuJw0KPiANCj4gd2hlcmUgZXZlbiBpZiAnYycgaXMgb2YgdHlw
ZSAnY2hhcicsIHRoZSBlbmQgcmVzdWx0IGlzICdpbnQnLg0KDQpXaGljaCBpcywgb2YgY291cnNl
LCBpbnZhbGlkIEMgOi0pDQpUaGUgZG9tYWluIG9mIHRoZSBpc3h4eHgoKSBmdW5jdGlvbnMgaXMg
J3RoZSB2YWx1ZXMgb2YgY2hhcg0KY2FzdCB0byB1bnNpZ25lZCBpbnQnIGFuZCBFT0YuDQpTbyB0
eXBpY2FsbHkgWy0xIC4uIDI1NV0uDQpQYXNzaW5nIGEgc2lnbmVkIGNoYXIgdmFyaWFibGUgdG8g
aXNwcmludCgpIGlzIGxpa2VseSB0bw0KZ2VuZXJhdGUgdW5kZXNpcmVkIGJlaGF2aW91ciAobGlr
ZSBhIGNvZGUgZHVtcCkuDQoNCkl0IGhhcyB0byBiZSBzYWlkIHRoYXQgSSBkaWQgYSBmdWxsIHRy
YXdsIHRocm91Z2ggdGhlIE5ldEJTRA0KdXNlcnNwYWNlIGNvZGUgYmFzZSB0byBmaXggYWxsIHRo
ZSBpc3h4eCgpIGNhbGxzIGFuZCBmYWlsZWQNCnRvIGZpbmQgYSBzaW5nbGUgb25lIHRoYXQgY291
bGQgYWN0dWFsbHkgcGFzcyBFT0YuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

