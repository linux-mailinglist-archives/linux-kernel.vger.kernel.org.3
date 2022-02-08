Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA174AE580
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbiBHXgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiBHXga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:36:30 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A9A1C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:36:29 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-314-yKUP0R1ROeSG8Jqez4S79Q-1; Tue, 08 Feb 2022 23:36:26 +0000
X-MC-Unique: yKUP0R1ROeSG8Jqez4S79Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Tue, 8 Feb 2022 23:36:25 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Tue, 8 Feb 2022 23:36:25 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>, Hugh Dickins <hughd@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: x86: should clear_user() have alternatives?
Thread-Topic: x86: should clear_user() have alternatives?
Thread-Index: AQHYHOq85MEK9qlbxkOnyE8hF1HtfqyKS9+Q
Date:   Tue, 8 Feb 2022 23:36:25 +0000
Message-ID: <b22c6d5a17474ef4a96788309dbfc4c0@AcuMS.aculab.com>
References: <2f5ca5e4-e250-a41c-11fb-a7f4ebc7e1c9@google.com>
 <YgJnhB+bAxoNsiSB@zn.tnic>
In-Reply-To: <YgJnhB+bAxoNsiSB@zn.tnic>
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

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDA4IEZlYnJ1YXJ5IDIwMjIgMTI6NTMNCj4g
DQo+IE9uIE1vbiwgRmViIDA3LCAyMDIyIGF0IDA5OjQ1OjM2UE0gLTA4MDAsIEh1Z2ggRGlja2lu
cyB3cm90ZToNCj4gPiBJIHJlYWxpemUgdGhhdCBkZCdpbmcgZnJvbSAvZGV2L3plcm8gdG8gL2Rl
di9udWxsLCBhbmQgc3BhcnNlIGZpbGVzIG9uDQo+ID4gdG1wZnMsIGFyZSBub3QgcHJpbWUgY2Fu
ZGlkYXRlcyBmb3Igb3B0aW1pemF0aW9uOyBhbmQgSSd2ZSBubyBpZGVhIGhvdw0KPiA+IG11Y2gg
Y2xlYXJfdXNlcigpIG5vcm1hbGx5IGdldHMgdXNlZCBmb3IgbG9uZyBjbGVhcnMuDQo+IA0KPiBS
aWdodCwgd2UgdXN1YWxseSBkb24ndCB0YWtlIHN1Y2ggIm9wdGltaXphdGlvbnMiIGJlY2F1c2Ug
dGhlIGZvbGtzIHdobw0KPiBzZW5kIHRoZW0gYWx3YXlzIGNvbWUgdXAgd2l0aCBlaXRoZXIgbWlj
cm9iZW5jaG1hcmtzIG9yIG9ubHkgdGVzdCBvbiBhDQo+IHNpbmdsZSBtYWNoaW5lLg0KDQpJIHRo
aW5rIGl0IGlzIHJlYXNvbmFibGUgdG8gdXNlIG1pY3JvYmVuY2htYXJrcyB0byBzZWUgaG93IGZh
c3QNCmEgcGFydGljdWxhciBsb29wIHJ1bnMgb24gYSBzcGVjaWZpYyBjcHUgLSBzaW5jZSB5b3Ug
Y2FuIHdvcmsgb3V0DQp0aGUgbnVtYmVyIG9mIGNsb2NrcyBwZXIgaXRlcmF0aW9uIGFuZCBkaXJl
Y3RseSBjb21wYXJlIGRpZmZlcmVudA0KdmVyc2lvbnMuDQoNClRoZSBwcm9ibGVtIHdpdGggbWlj
cm9iZW5jaG1hcmtzIGlzIHdoZW4gdGhleSBnZXQgdXNlZCBvbiB1bnJvbGxlZCBsb29wcy4NClJ1
biBzb21ldGhpbmcgMTAwMDAgdGltZXMgd2l0aCBob3QtY2FjaGUgZGF0YSBhbmQgdW5yb2xsZWQg
bG9vcHMNCmFsbW9zdCBhbHdheXMgc2VlbSBiZXN0Lg0KQ29sZCBjYWNoZSBvciB0aGUgZWZmZWN0
cyBvZiBkaXNwbGFjaW5nIG90aGVyIGNvZGUgZnJvbSB0aGUgSS1jYWNoZQ0KY2FuIG1ha2UgbG9v
cCB1bnJvbGxpbmcgYSBiaWcgbG9zcy4NCkVzcGVjaWFsbHkgb24gY3VycmVudCBjcHUgdGhhdCBl
eGVjdXRlIG11bHRpcGxlIGluc3RydWN0aW9ucy9jbG9jaw0KYW5kIG91dC1vZi1vcmRlciBleGVj
dXRpb24uDQoNCkxvb3BzIG9ubHkgbmVlZCB1bnJvbGxpbmcganVzdCBlbm91Z2ggdG8gaGl0IHNv
bWUgYXJjaGl0ZWN0dXJhbCBsaW1pdC4NCkZvciBtZW1zZXQoKSAodXNpbmcgbm9ybWFsIGluc3Ry
dWN0aW9ucykgdGhhdCBpcyAxIHdyaXRlIHBlciBjbG9jay4NCg0KQSBjbGFzc2ljIGV4YW1wbGUg
aGFzIHRvIGJlIHRoZSBzcGFyYyBkaXZpZGUgcmVtYWluZGVyIGZ1bmN0aW9uDQppbiB0aGUgb3Jp
Z2luYWwgQ1k3QzYwMCBib29rICh3aGljaCBJIGhhcHBlbiB0byBzdGlsbCBoYXZlKS4NCkknbSBu
b3Qgc3VyZSBob3cgbWFueSBpbnN0cnVjdGlvbnMgaXQgaXMgLSBidXQgaXQgaXMgcHJpbnRlZA0K
b24gNCBwYWdlcy4gSXQganVzdCBoYXMgdG8gYmxvdyBhbnl0aGluZyBlbHNlIG91dCBvZiB0aGUN
CnNtYWxsIEktY2FjaGUgdGhvc2UgY3B1IGhhZC4NCkl0IG1pZ2h0IGJlIGZhc3RlciAtIGJ1dCBv
bmx5IGlmIHlvdSBhcmUgZG9pbmcgYSBsb3Qgb2YgZGl2aWRlcy4NCiANCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=

