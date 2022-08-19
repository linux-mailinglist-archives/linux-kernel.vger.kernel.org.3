Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A0559A7C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbiHSVhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiHSVhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:37:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F103F10DCFC
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:37:32 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-310-4uzKBrtmPjmbhHfl5uTZCQ-1; Fri, 19 Aug 2022 22:37:29 +0100
X-MC-Unique: 4uzKBrtmPjmbhHfl5uTZCQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.38; Fri, 19 Aug 2022 22:37:29 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.040; Fri, 19 Aug 2022 22:37:29 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bagas Sanjaya' <bagasdotme@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 2/3] kconfig: allow to choose the shell for $(shell )
 functions
Thread-Topic: [RFC PATCH 2/3] kconfig: allow to choose the shell for $(shell )
 functions
Thread-Index: AQHYs6n/sZolmSFb/UanaOOils/j2622vzDQ
Date:   Fri, 19 Aug 2022 21:37:29 +0000
Message-ID: <a1b0c5a396fa454183b730cacfb173b0@AcuMS.aculab.com>
References: <20220819065604.295572-1-masahiroy@kernel.org>
 <20220819065604.295572-3-masahiroy@kernel.org>
 <831ebaf6-6fea-65ea-aa60-c47f6f05dbb0@gmail.com>
In-Reply-To: <831ebaf6-6fea-65ea-aa60-c47f6f05dbb0@gmail.com>
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

RnJvbTogQmFnYXMgU2FuamF5YQ0KPiBTZW50OiAxOSBBdWd1c3QgMjAyMiAwOTo1OQ0KPiANCj4g
T24gOC8xOS8yMiAxMzo1NiwgTWFzYWhpcm8gWWFtYWRhIHdyb3RlOg0KPiA+IEdOVSBNYWtlIHVz
ZXMgL2Jpbi9zaCBieSBkZWZhdWx0IGZvciBydW5uaW5nIHJlY2lwZSBsaW5lcyBhbmQgJChzaGVs
bCApDQo+ID4gZnVuY3Rpb25zLiBZb3UgY2FuIGNoYW5nZSB0aGUgc2hlbGwgYnkgc2V0dGluZyB0
aGUgJ1NIRUxMJyB2YXJpYWJsZS4NCj4gPiBVbmxpa2UgbW9zdCB2YXJpYWJsZXMsICdTSEVMTCcg
aXMgbmV2ZXIgc2V0IGZyb20gdGhlIGVudmlyb25tZW50LiBbMV0NCj4gPg0KPiA+IEN1cnJlbnRs
eSwgS2NvbmZpZyBkb2VzIG5vdCBwcm92aWRlIGFueSB3YXkgdG8gY2hhbmdlIHRoZSBkZWZhdWx0
IHNoZWxsLg0KPiA+IC9iaW4vc2ggaXMgYWx3YXlzIHVzZWQgZm9yIHJ1bm5pbmcgJChzaGVsbCwu
Li4pIGJlY2F1c2UgZG9fc2hlbGwoKSBpcw0KPiA+IGltcGxlbWVudGVkIGJ5IHVzaW5nIHBvcGVu
KDMpLg0KPiA+DQo+ID4gVGhpcyBjb21taXQgYWxsb3dzIHVzZXJzIHRvIGNoYW5nZSB0aGUgc2hl
bGwgZm9yIEtjb25maWcgaW4gYSBzaW1pbGFyDQo+ID4gd2F5IHRvIEdOVSBNYWtlOyB5b3UgY2Fu
IHNldCB0aGUgJ1NIRUxMJyB2YXJpYWJsZSBpbiBhIEtjb25maWcgZmlsZSB0bw0KPiA+IG92ZXJy
aWRlIHRoZSBkZWZhdWx0IHNoZWxsLiBJdCBpcyBub3QgdGFrZW4gZnJvbSB0aGUgZW52aXJvbm1l
bnQuIFRoZQ0KPiA+IGNoYW5nZSBpcyBlZmZlY3RpdmUgb25seSBmb3IgJChzaGVsbCwuLi4pIGlu
dm9jYXRpb25zIGNhbGxlZCBhZnRlciB0aGUNCj4gPiAnU0hFTEwnIGFzc2lnbm1lbnQuDQo+ID4N
Cj4gDQo+IEhtbW0uLi4NCj4gDQo+IENhbiB3ZSBzYXkgdGhhdCBpZiB3ZSBydW4gU0hFTEw9L2Jp
bi9iYXNoIG1ha2UgbmNvbmZpZywgS2NvbmZpZyB3aWxsIHVzZQ0KPiAkU0hFTEwgYnV0IHdlIGNh
bid0IHNldCBpdCBhcyBlbnZpcm9ubWVudCB2YXJpYWJsZT8NCg0KVGhhdCBqdXN0IHB1dHMgaXQg
aW50byB0aGUgZW52aXJvbm1lbnQgZm9yIHRoZSBzaW5nbGUgY29tbWFuZC4NCllvdSdkIG5lZWQg
dG8gcGFzcyBpdCBhcyBhIGNvbW1hbmQgbGluZSBhcmd1bWVudCB0byBtYWtlLg0KDQooT3IgcGFz
cyBpdCBpbiBhIGRpZmZlcmVudCBlbnZpcm9ubWVudCB2YXJpYWJsZSBhbmQgdGhlbiBhc3NpZ24N
Cml0IHdpdGhpbiB0aGUgbWFrZWZpbGUuKQ0KDQpPciBqdXN0IHJlbW92ZSB0aGUgY3JhcHB5IGJh
c2hpc21zIGFuZCB3cml0ZSBwb3J0YWJsZSBzaGVsbCBzY3JpcHRzLg0KSnVzdCBiZSBnbGFkIHlv
dSdyZSBub3QgdHJ5aW5nIHRvIHVzZSB0aGUgU1lTViAvYmluL3NoLg0KKEFuZCBhdm9pZCB0aGUg
b3RoZXIgYnVncyB0aGF0IG1ha2UgZGFzaCBmYWlsIHRvIHJ1biBtb3N0IG9mIHRoZQ0Kc2NyaXB0
cyBJIHdyaXRlLikNCg0KQ29tcGV4IGVjaG8gcmVxdWVzdHMgY2FuIGJlIHJlcGxhY2VkIGJ5IHBy
aW50ZiAod2l0aG91dCBwZW5hbHR5DQpzaW5jZSBpdCB3aWxsIGJlIGEgc2hlbGwgYnVpbHRpbiku
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=

