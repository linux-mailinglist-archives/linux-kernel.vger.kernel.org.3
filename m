Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCA64C50D1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbiBYVjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 16:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiBYVji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:39:38 -0500
X-Greylist: delayed 148 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Feb 2022 13:39:02 PST
Received: from mail1.med.uni-goettingen.de (mail1.med.uni-goettingen.de [134.76.103.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857211AE674
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:39:01 -0800 (PST)
Received: from umg-exc-04.ads.local.med.uni-goettingen.de ([10.76.100.73]:12926)
        by mail1.med.uni-goettingen.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <Martin.Uecker@med.uni-goettingen.de>)
        id 1nNiGK-0001LQ-2t; Fri, 25 Feb 2022 22:36:28 +0100
Received: from umg-exc-01.ads.local.med.uni-goettingen.de (10.76.100.74) by
 umg-exc-04.ads.local.med.uni-goettingen.de (10.76.100.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 25 Feb 2022 22:36:28 +0100
Received: from umg-exc-01.ads.local.med.uni-goettingen.de
 ([fe80::2886:b6b:10e3:deea]) by umg-exc-01.ads.local.med.uni-goettingen.de
 ([fe80::2886:b6b:10e3:deea%13]) with mapi id 15.01.2375.018; Fri, 25 Feb 2022
 22:36:28 +0100
From:   "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
Thread-Topic: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
Thread-Index: AQHYKosGsHPhjhvi7kSF9n6RY4a/rKykuaOA
Date:   Fri, 25 Feb 2022 21:36:28 +0000
Message-ID: <bd43bd47c8eaa4c22c1a1549cee66f7ef960b1fc.camel@med.uni-goettingen.de>
References: <CAHk-=wjtZG_0zjgVt0_0JDZgq=xO4LHYAbH764HTQJsjHTq-oQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjtZG_0zjgVt0_0JDZgq=xO4LHYAbH764HTQJsjHTq-oQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.76.100.66]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA8A6EF5A8291A4CB71C50A05F543E11@med.uni-goettingen.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gTWl0dHdvY2gsIGRlbiAyMy4wMi4yMDIyLCAyMDo1NCArMDAwMCBzY2hyaWViIExpbnVzIFRv
cnZhbGRzOg0KPiBPbiBXZWQsIEZlYiAyMywgMjAyMiBhdCAxMjo0MyBQTSBMaW51cyBUb3J2YWxk
cw0KPiA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiA+IE9mIGNvdXJz
ZSwgdGhlIEMgc3RhbmRhcmQgYmVpbmcgdGhlIGJ1bmNoIG9mIGluY29tcGV0ZW50cyB0aGV5IGFy
ZSwNCj4gPiB0aGV5IGluIHRoZSBwcm9jZXNzIGFwcGFyZW50bHkgbWFkZSBsZWZ0LXNoaWZ0cyB1
bmRlZmluZWQgKHJhdGhlciB0aGFuDQo+ID4gaW1wbGVtZW50YXRpb24tZGVmaW5lZCkuIENocmlz
dCwgdGhleSBrZWVwIG9uIG1ha2luZyB0aGUgc2FtZSBtaXN0YWtlcw0KPiA+IG92ZXIgYW5kIG92
ZXIuIFdoYXQgd2FzIHRoZSBkZWZpbml0aW9uIG9mIGluc2FuaXR5IGFnYWluPw0KDQpJbXBsZW1l
bnRhdGlvbi1kZWZpbmVkIG9ubHkgbWVhbnMgdGhhdCBpdCBuZWVkcyB0byBiZQ0KZG9jdW1lbnRl
ZCAoYW5kIGNsYW5nIGRvZXMgbm90IGV2ZW4gZG8gdGhpcyksIHNvDQpJIGFtIG5vdCBzdXJlIHdo
YXQgZGlmZmVyZW5jZSB0aGlzIHdvdWxkIG1ha2UuDQoNCj4gSGV5LCBzb21lIG1vcmUgZ29vZ2xp
bmcgb24gbXkgcGFydCBzZWVtcyB0byBzYXkgdGhhdCBzb21lYm9keSBzYXcgdGhlDQo+IGxpZ2h0
LCBhbmQgaXQncyBsaWtlbHkgZ2V0dGluZyBmaXhlZCBpbiBuZXdlciBDIHN0YW5kYXJkIHZlcnNp
b24uDQoNCkkgZG9uJ3QgdGhpbmsgaXQgaXMgY2hhbmdlZC4gQnV0IEMyMyB3aWxsIHJlcXVpcmUN
CmludGVnZXJzIHRvIGJlIHJlcHJlZXRlZCB1c2luZyB0d28ncyBjb21wbGVtZW50LA0Kc28gdGhl
cmUgaXMgYSBiZXR0ZXIgY2hhbmNlIHRvIGZpeCB0aGluZ3MNCmxpa2UgdGhpcyBpbiB0aGUgZnV0
dXJlLiANCg0KPiBTbyBpdCB3YXMganVzdCBhIG1pc3Rha2UsIG5vdCBhY3R1YWwgbWFsaWNlLiBN
YXliZSB3ZSBjYW4gaG9wZSB0aGF0DQo+IHRoZSB0aWRlIGlzIHR1cm5pbmcgYWdhaW5zdCB0aGUg
InVuZGVmaW5lZCIgY3Jvd2QgdGhhdCB1c2VkIHRvIHJ1bGUNCj4gdGhlIHJvb3N0IGluIHRoZSBD
IHN0YW5kYXJkcyBib2RpZXMuIE1heWJlIHRoZSBmdW5kYW1lbnRhbCBzZWN1cml0eQ0KPiBpc3N1
ZXMgd2l0aCB1bmRlZmluZWQgYmVoYXZpb3IgZmluYWxseSBjb252aW5jZWQgcGVvcGxlIGhvdyBi
YWQgaXQNCj4gd2FzPw0KDQpUaGUgcmlnaHQgcGVvcGxlIHRvIGNvbXBsYWluIHRvIGFyZSB0aGUN
CmNvbXBpbGVyIHZlbmRvcnMsIGJlY2F1c2UgdGhleSBkZWNpZGUgd2hhdA0KVUIgZG9lcyBpbiB0
aGVpciBpbXBsZW1lbnRhdGlvbi4gIEluIHRoZQ0Kc3RhbmRhcmQgYm9keSB0aGUgc2FtZSBwZW9w
bGUgYXJndWUgdGhhdA0KdGhlIHN0YW5kYXJkIGhhcyB0byBjb2RpZnkgZXhpc3RpbmcNCnByYWN0
aWNlLiAgRXZlbiBpbiBjYXNlcyB3aGVyZSB0aGUgc3RhbmRhcmQNCmRlZmluZXMgYmVoYXZpb3Is
IGNvbXBpbGVycyBzb21ldGltZXMgc2ltcGx5DQppZ25vcmUgdGhpcyAoZS5nLiBwb2ludGVyIGNv
bXBhcmlzb24gb3INCnBvaW50ZXItdG8taW50ZWdlciByb3VuZCAgdHJpcHMpLiBTbyB0aGUNCnBv
d2VyIGlzIHJlYWxseSB3aXRoIHRoZSBjb21waWxlciB3cml0ZXJzLg0KDQoNCk1hcnRpbiANCg0K
DQo=
