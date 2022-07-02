Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BE9563F7D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 12:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiGBKcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 06:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGBKck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 06:32:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F37EFE08C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 03:32:37 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-190-fq6De5EYPjGIl__1gGDL3A-1; Sat, 02 Jul 2022 11:32:34 +0100
X-MC-Unique: fq6De5EYPjGIl__1gGDL3A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Sat, 2 Jul 2022 11:32:34 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Sat, 2 Jul 2022 11:32:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Tony Luck" <tony.luck@intel.com>
CC:     x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/split_lock: Enable the split lock detect feature on
 Raptor Lake P and Alder Lake N CPUs
Thread-Topic: [PATCH] x86/split_lock: Enable the split lock detect feature on
 Raptor Lake P and Alder Lake N CPUs
Thread-Index: AQHYjVXuNM4DSSBMSUWftbPmvnvuSa1q4dRA
Date:   Sat, 2 Jul 2022 10:32:33 +0000
Message-ID: <aa0ee519f6dc49f9b866abb438bde1e1@AcuMS.aculab.com>
References: <20220701131958.687066-1-fenghua.yu@intel.com>
 <e333c40a-13da-8def-56db-9b61ef46e296@intel.com>
In-Reply-To: <e333c40a-13da-8def-56db-9b61ef46e296@intel.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGF2ZSBIYW5zZW4NCj4gU2VudDogMDEgSnVseSAyMDIyIDE1OjIwDQo+IA0KPiBPbiA3
LzEvMjIgMDY6MTksIEZlbmdodWEgWXUgd3JvdGU6DQo+ID4gVGhlc2UgQ1BVIG1vZGVscyBzdXBw
b3J0IHRoZSBzcGxpdCBsb2NrIGRldGVjdCBmZWF0dXJlLiBBZGQgdGhlbSB0bw0KPiA+IHRoZSB4
ODZfY3B1X2lkcyBtYXRjaCB0YWJsZS4NCj4gDQo+IFdoZW4gaXMgdGhlcmUgZ29pbmcgdG8gYmUg
YXJjaGl0ZWN0dXJhbCBkZXRlY3Rpb24gZm9yIHRoaXMgZmVhdHVyZT8gIE9yLA0KPiBpcyB0aGUg
cGxhbiB0byBqdXN0IGtlZXAgYWRkaW5nIENQVXMgdG8gdGhpcyB0YWJsZSBhcyB0aGV5IGFyZSBh
dmFpbGFibGUuDQoNCkkgc2F3IHRoYXQgYXMgd2VsbCwgaXQgcmVhbGx5IGRvZXNuJ3Qgc2NhbGUg
YXQgYWxsLg0KDQpJc24ndCBpdCB1c3VhbCBmb3IgdGhlIGZsYWcgdG8gbm90IGJlIHNldHRhYmxl
IG9uIG9sZCBjcHU/DQoNCkluIGFueSBjYXNlIHRoZSBmbGFnIGNvdWxkIGJlIHNldCBhbmQgdGhl
biBhICdzcGxpdCBsb2NrJw0KdHJhbnNmZXIgYW5kIHNlZSBpZiBpdCBmYXVsdHMuDQoNCk9UT0gg
d2h5IGJvdGhlciB3aXRoIHRoZSB0ZXN0Pw0KVW5sZXNzIHlvdSB3YW50IHRvIHJlcG9ydCB0aGF0
IHRoZSAnc3BsaXQgbG9jaycgZGV0ZWN0aW9uDQpkb2Vzbid0IHdvcms/DQoNCk9yIGRpZCBJbnRl
bCByZWFsbHkgc2NyZXcgdGhpcyB1cCBhbmQgdXNlIGEgZmxhZyB0aGF0IGhhcw0Kc29tZSBvdGhl
ciB1bmRlc2lyYWJsZSBlZmZlY3Qgb24gKGF0IGxlYXN0IHNvbWUpIG9sZGVyIGNwdS4NCg0KCURh
dmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCg==

