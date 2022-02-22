Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8AB4BF46A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiBVJKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiBVJKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:10:08 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D64DB15697F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 01:09:42 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-233-aG9dhGhYN3qDGhKtxOz2-g-1; Tue, 22 Feb 2022 09:09:39 +0000
X-MC-Unique: aG9dhGhYN3qDGhKtxOz2-g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 22 Feb 2022 09:09:38 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 22 Feb 2022 09:09:38 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Masahiro Yamada' <masahiroy@kernel.org>
CC:     "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: RE: [PATCH] fixdep: use fflush() and ferror() to ensure successful
 write to files
Thread-Topic: [PATCH] fixdep: use fflush() and ferror() to ensure successful
 write to files
Thread-Index: AQHYJ0I5ab4KpWmMiEy1rF7ornjtjayelfMAgABYfICAAFpJIA==
Date:   Tue, 22 Feb 2022 09:09:38 +0000
Message-ID: <1b44951e776b4f4d9a5b786f2ba896d4@AcuMS.aculab.com>
References: <20220221164316.113489-1-masahiroy@kernel.org>
 <04d06889d8ea41589628995a6cb53874@AcuMS.aculab.com>
 <CAK7LNAQgucSQQLauRoaFza6YHGMBrSr+-ag1m=bmWXas5WEb0A@mail.gmail.com>
In-Reply-To: <CAK7LNAQgucSQQLauRoaFza6YHGMBrSr+-ag1m=bmWXas5WEb0A@mail.gmail.com>
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

RnJvbTogTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGlyb3lAa2VybmVsLm9yZz4NCj4gU2VudDogMjIg
RmVicnVhcnkgMjAyMiAwMzo0NA0KPiANCj4gT24gVHVlLCBGZWIgMjIsIDIwMjIgYXQgNzozMyBB
TSBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+
IEZyb206IE1hc2FoaXJvIFlhbWFkYQ0KPiA+ID4gU2VudDogMjEgRmVicnVhcnkgMjAyMiAxNjo0
Mw0KPiA+ID4gVG86IGxpbnV4LWtidWlsZEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+DQo+ID4gPiBD
aGVja2luZyB0aGUgcmV0dXJuIHZhbHVlIG9mICh2KXByaW50ZiBkb2VzIG5vdCBlbnN1cmUgdGhl
IHN1Y2Nlc3NmdWwNCj4gPiA+IHdyaXRlIHRvIHRoZSAuY21kIGZpbGUuDQo+ID4gPg0KPiA+ID4g
Q2FsbCBmZmx1c2goKSBhbmQgZmVycm9yKCkgdG8gbWFrZSBzdXJlIHRoYXQgZXZlcnl0aGluZyBo
YXMgYmVlbg0KPiA+ID4gd3JpdHRlbiB0byB0aGUgZmlsZS4NCj4gPiA+DQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3JnPg0KPiA+DQo+ID4g
UmV2aWV3ZWQtYnk6IERhdmlkIExhaWdodCA8ZHZpZC5sYWlnaHRAYWN1bGFiLmNvbT4NCj4gPg0K
PiA+IEknbGwgbm90ZSB0aGF0IHlvdSd2ZSBsb3N0IHRoZSBwZXJyb3IoImZpeGRlcCIpLg0KPiA+
IEJ1dCBJIHN1c3BlY3QgdGhhdCBpc24ndCB2ZXJ5IG1lYW5pbmdmdWwuDQo+ID4gSWYgdGhlIGRp
c2sgaXMgZnVsbCBpdCdkIHByb2JhYmx5IGdldCBsb3N0IGFueXdheS4NCj4gDQo+IA0KPiBwZXJy
b3IoKSB3aWxsIGdvIHRvIHN0ZGVyciwgaS5lLiB0dHkgaGVyZS4NCj4gU28sIHRoYXQgaXMgbm90
IHRoZSBpc3N1ZS4NCj4gDQo+IGZlcnJvcigpIGl0c2VsZiBkb2VzIG5vdCBzZXQgZXJybm8gaGVy
ZTsgIm1hbiBmZXJyb3IiIHNheXMsDQo+ICJUaGVzZSAgZnVuY3Rpb25zICBzaG91bGQgIG5vdCAg
ZmFpbCAgYW5kICBkbyAgbm90IHNldCB0aGUgZXh0ZXJuYWwNCj4gdmFyaWFibGUgZXJybm8iDQo+
IA0KPiBTbywgSSBkcm9wcGVkIHBlcnJvcigpIGJlY2F1c2UgSSBhbSBub3Qgc3VyZSBpZiBhbnkg
cmVsYXRlZCBlcnJvcg0KPiBtZXNzYWdlIGlzIHByaW50ZWQgaGVyZS4NCj4gDQo+IFBlcmhhcHMs
IGVycm5vIHdhcyBzZXQgYnkgc29tZSBvZiBwcmVjZWRpbmcgcHJpbnRmKCkgY2FsbHMsDQo+IGJ1
dCBJIGFtIG5vdCBxdWl0ZSBzdXJlIGlmIGl0IGlzIGNhcnJpZWQgYWxsIHRoZSB3YXkgdG8gdGhl
IGVuZA0KPiBvZiB0aGlzIHByb2dyYW0uDQoNCkkgd2FzIHRoaW5raW5nIG9yIGEgc2xpZ2h0bHkg
bW9yZSBkZXNjcmlwdGl2ZSBlcnJvciBtZXNzYWdlIDotKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

