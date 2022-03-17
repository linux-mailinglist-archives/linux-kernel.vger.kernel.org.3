Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9094DBCDE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 03:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbiCQCJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 22:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiCQCJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 22:09:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 829AD1EAC4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 19:08:35 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-246-9A16YFrLNjiCJV0Fd6iksg-1; Thu, 17 Mar 2022 02:08:32 +0000
X-MC-Unique: 9A16YFrLNjiCJV0Fd6iksg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Thu, 17 Mar 2022 02:08:31 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Thu, 17 Mar 2022 02:08:31 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'James Jones' <linux@theinnocuous.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86: Remove a.out support
Thread-Topic: [PATCH] x86: Remove a.out support
Thread-Index: AQHYOaNfiI2rWSVwnUW0pCDz/QTpF6zC1C1w
Date:   Thu, 17 Mar 2022 02:08:31 +0000
Message-ID: <4880a8eeb54d486ca7d3247821dbc8a9@AcuMS.aculab.com>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com>
 <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com>
 <202203151150.1CDB1D8DA@keescook>
 <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com>
 <CAK8P3a28dpyEM2+vM+ePZzeFc539b7w_8FDEoRke-j+3AQVZAA@mail.gmail.com>
 <202203161523.857B469@keescook>
 <59fb3d14-423a-d39b-04cb-1e60ee67d3f1@theinnocuous.com>
In-Reply-To: <59fb3d14-423a-d39b-04cb-1e60ee67d3f1@theinnocuous.com>
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

RnJvbTogSmFtZXMgSm9uZXMNCj4gU2VudDogMTcgTWFyY2ggMjAyMiAwMjowNQ0KPiANCj4gT24g
My8xNi8yMiAzOjMwIFBNLCBLZWVzIENvb2sgd3JvdGU6DQo+ID4gT24gV2VkLCBNYXIgMTYsIDIw
MjIgYXQgMDE6Mzg6MzFQTSArMDEwMCwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gPj4gaXMgaW4g
dGhlIGVuZCwgYnV0IGl0J3MgbGlrZWx5IGVhc2llciB0aGFuIGEgc3RhbmRhbG9uZSBhLm91dCBs
b2FkZXINCj4gPj4gaW4gdXNlciBzcGFjZSwgb3IgYSBjb252ZXJzaW9uIHRvIEVMRiBmb3JtYXQu
DQo+ID4NCj4gPiBZZWFoLCB0aGUgZXhlYyBmb3JtYXQgaXMgcmVhbGx5IHNpbXBsZS4gVGhlIG9u
bHkgdHJpY2t5IGJpdCB3YXMgcHJlcGFyaW5nDQo+ID4gdGhlIHN0YWNrIGFuZCBtYWtpbmcgc3Vy
ZSBldmVyeXRoaW5nIGxhbmRlZCBpbiB0aGUgcmlnaHQgcGxhY2UgZm9yIHRleHQNCj4gPiBhbmQg
ZGF0YS4gSmFtZXMsIGNhbiB5b3UgdHJ5IHRoaXM/IGFsbiBhbmQgbWFjIHJ1biBmb3IgbWUsIGJ1
dCBJJ20gbm90DQo+ID4gYWN0dWFsbHkgZXhlcmNpc2luZyB0aGVtIGJleW9uZCBkdW1waW5nIGFy
Z3VtZW50IGxpc3RzLCBldGM6DQo+ID4NCj4gPiBodHRwczovL2dpdGh1Yi5jb20va2Vlcy9rZXJu
ZWwtdG9vbHMvdHJlZS90cnVuay9hLm91dA0KPiANCj4gWWVzLCB3b3JrcyBwZXJmZWN0bHksIHRo
YW5rIHlvdS4gSSBsaWtlIHRoZSBpZGVhIG9mIHVzaW5nIHRoaXMgbXVjaA0KPiBiZXR0ZXIgdGhh
biBnZXR0aW5nIGVtYWlsZWQgZXZlcnkgdGltZSBzb21lb25lIHdhbnRzIHRvIGRlbGV0ZSB0aGUg
YS5vdXQNCj4gY29kZSBhZ2Fpbi4gQ29uc2lkZXIgbXkgdXNlIGNhc2Ugd2l0aGRyYXduLiBJJ3Zl
IGFscmVhZHkgcHVzaGVkIGFuDQo+IHVwZGF0ZSB0byBteSBqYWd1YXItc2RrIHByb2plY3QgdG8g
dXNlIHRoaXMgdG9vbCBpbnN0ZWFkLg0KDQpKdXN0IGV2ZXJ5IHRpbWUgdGhlIHNvbWVvbmUgd2Fu
dHMgdG8gZGVsZXRlIHRoZSBhc3NvY2lhdGVkDQpzeXN0ZW0gY2FsbHMgOi0pDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

