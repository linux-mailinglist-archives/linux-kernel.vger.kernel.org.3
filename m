Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957C24F8A33
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiDGVl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiDGVlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:41:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 578ECFD6E9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:39:21 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-320-WR3U6Ba6MeKh1xc75li2gw-1; Thu, 07 Apr 2022 22:39:18 +0100
X-MC-Unique: WR3U6Ba6MeKh1xc75li2gw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Thu, 7 Apr 2022 22:39:17 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Thu, 7 Apr 2022 22:39:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
CC:     "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: RE: [PATCH 6/7] kbuild: make *.mod not depend on *.o
Thread-Topic: [PATCH 6/7] kbuild: make *.mod not depend on *.o
Thread-Index: AQHYSqlwlFlZ8XvVlkmR3e+Fu9qwr6zk+UXQ
Date:   Thu, 7 Apr 2022 21:39:16 +0000
Message-ID: <eedd7486cd484c359be90e6138b0b2be@AcuMS.aculab.com>
References: <20220406153023.500847-1-masahiroy@kernel.org>
 <20220406153023.500847-7-masahiroy@kernel.org>
 <CAKwvOdm7NBPj43sRw-_dtjzgpHeOHnQ9uB3rSg3rYhUu0_PN7A@mail.gmail.com>
In-Reply-To: <CAKwvOdm7NBPj43sRw-_dtjzgpHeOHnQ9uB3rSg3rYhUu0_PN7A@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAwNyBBcHJpbCAyMDIyIDE4OjU5DQo+IA0K
PiBPbiBXZWQsIEFwciA2LCAyMDIyIGF0IDg6MzEgQU0gTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGly
b3lAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgZGVwZW5kZW5jeQ0KPiA+DQo+ID4g
ICAgICQob2JqKS8lLm1vZDogJChvYmopLyUkKG1vZC1wcmVsaW5rLWV4dCkubw0KPiA+DQo+ID4g
Li4uIGV4aXN0cyBiZWNhdXNlICoubW9kIGZpbGVzIHByZXZpb3VzbHkgY29udGFpbmVkIHVuZGVm
aW5lZCBzeW1ib2xzLA0KPiA+IHdoaWNoIGFyZSBjb21wdXRlZCBmcm9tICoubyBmaWxlcyB3aGVu
IENPTkZJR19UUklNX1VOVVNFRF9LU1lNUz15Lg0KPiA+DQo+ID4gTm93IHRoYXQgdGhlIHVuZGVm
aW5lZCBzeW1ib2xzIGFyZSBwdXQgaW50byBzZXBhcmF0ZSAqLnVzeW1zIGZpbGVzLA0KPiA+IHRo
ZXJlIGlzIG5vIHJlYXNvbiB0byBtYWtlICoubW9kIGRlcGVuZCBvbiAqLm8gZmlsZXMuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3Jn
Pg0KPiA+IC0tLQ0KPiA+DQo+ID4gIE1ha2VmaWxlICAgICAgICAgICAgICAgfCAzICsrLQ0KPiA+
ICBzY3JpcHRzL01ha2VmaWxlLmJ1aWxkIHwgNSArKy0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9N
YWtlZmlsZSBiL01ha2VmaWxlDQo+ID4gaW5kZXggODJlZTg5MzkwOWU5Li5lOTE1YWFjZDAyYjAg
MTAwNjQ0DQo+ID4gLS0tIGEvTWFrZWZpbGUNCj4gPiArKysgYi9NYWtlZmlsZQ0KPiA+IEBAIC0x
NzkyLDcgKzE3OTIsOCBAQCBpZmRlZiBzaW5nbGUtYnVpbGQNCj4gPg0KPiA+ICAjIC5rbyBpcyBz
cGVjaWFsIGJlY2F1c2UgbW9kcG9zdCBpcyBuZWVkZWQNCj4gPiAgc2luZ2xlLWtvIDo9ICQoc29y
dCAkKGZpbHRlciAlLmtvLCAkKE1BS0VDTURHT0FMUykpKQ0KPiA+IC1zaW5nbGUtbm8ta28gOj0g
JChzb3J0ICQocGF0c3Vic3QgJS5rbywlLm1vZCwgJChNQUtFQ01ER09BTFMpKSkNCj4gPiArc2lu
Z2xlLW5vLWtvIDo9ICQoZmlsdGVyLW91dCAkKHNpbmdsZS1rbyksICQoTUFLRUNNREdPQUxTKSkg
XA0KPiA+ICsgICAgICAgICAgICAgICAkKGZvcmVhY2ggeCwgbyBtb2QsICQocGF0c3Vic3QgJS5r
bywgJS4keCwgJChzaW5nbGUta28pKSkNCj4gDQo+IEknbSBvbiBib2FyZCB3aXRoIHRoaXMgcGF0
Y2gsIGFuZCB0aGUgb3ZlcmFsbCBnb2FsIHdpdGggdGhlIHNlcmllcy4gTXkNCj4gYnJhaW4gaXMg
aGF2aW5nIGEgaGFyZCB0aW1lIHBhcnNpbmcgYG8gbW9kYCB0aG91Z2guIENhbiB5b3Ugd2FsayBt
ZQ0KPiB0aHJvdWdoIHRoYXQ/IEFyZSB0aG9zZSB0YXJnZXRzIGZvciAubyBhbmQgLm1vZCBmaWxl
cywgcmVzcGVjdGl2ZWx5Pw0KDQpJIHRoaW5rIEknZCBkbzoNCnNpbmdsZS1uby1rbyA6PSAkKGZp
bHRlci1vdXQgJChzaW5nbGUta28pLCAkKE1BS0VDTURHT0FMUykpDQpzaW5nbGUtbm8ta28gKz0g
JChwYXRzdWJzdCAlLmtvLCAlLm8sICQoc2luZ2xlLWtvKSkNCnNpbmdsZS1uby1rbyArPSAkKHBh
dHN1YnN0ICUua28sICUubW9kLCAkKHNpbmdsZS1rbykpDQoNCkFsdGhvdWdoIHlvdSBjYW4gdXNl
IHRoZSBzaW1wbGVyIFNZU1YgbWFrZSBzdWZmaXggc3Vic3RpdHV0aW9uIHN5bnRheDoNCnNpbmds
ZS1uby1rbyArPSAkKHNpbmdsZS1rbzoua289Lm8pICQoc2luZ2xlLWtvOi5rbz0ubW9kKQ0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

