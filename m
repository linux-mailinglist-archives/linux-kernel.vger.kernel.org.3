Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598DA4EAE41
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbiC2NVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiC2NVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:21:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B178F13E9D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:19:29 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-20-W4MrfOwKNYyyVGBWIKZP5Q-1; Tue, 29 Mar 2022 14:19:26 +0100
X-MC-Unique: W4MrfOwKNYyyVGBWIKZP5Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Tue, 29 Mar 2022 14:19:25 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Tue, 29 Mar 2022 14:19:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthias Schiffer' <matthias.schiffer@ew.tq-group.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>,
        Lukas Wunner <lukas@wunner.de>
Subject: RE: [PATCH] serial: Revert RS485 polarity change on UART open
Thread-Topic: [PATCH] serial: Revert RS485 polarity change on UART open
Thread-Index: AQHYQ1k5q26PsxFKq0WuXVn++R8i1qzWT4pQ///zlACAABGw4A==
Date:   Tue, 29 Mar 2022 13:19:25 +0000
Message-ID: <df0034da2db14b6b9993c37422a6711d@AcuMS.aculab.com>
References: <20220329085050.311408-1-matthias.schiffer@ew.tq-group.com>
         <20220329100328.GA2090@wunner.de>
         <b2f29129f966685105e09781620b85c8f4f1a88e.camel@ew.tq-group.com>
         <749eee7dd2c7464a8c4d9ea5972205fa@AcuMS.aculab.com>
 <82266d339e09ad16963e16014cd836fa670b3a0c.camel@ew.tq-group.com>
In-Reply-To: <82266d339e09ad16963e16014cd836fa670b3a0c.camel@ew.tq-group.com>
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

RnJvbTogTWF0dGhpYXMgU2NoaWZmZXINCj4gU2VudDogMjkgTWFyY2ggMjAyMiAxNDowMw0KPiAN
Cj4gT24gVHVlLCAyMDIyLTAzLTI5IGF0IDEyOjU1ICswMDAwLCBEYXZpZCBMYWlnaHQgd3JvdGU6
DQo+ID4gRnJvbTogTWF0dGhpYXMgU2NoaWZmZXINCj4gPiA+IFNlbnQ6IDI5IE1hcmNoIDIwMjIg
MTE6MzkNCj4gPiAuLi4NCj4gPiA+IEkgZ3Vlc3MgdGhhdCB3b3VsZCB3b3JrLiBUaGUgZmFjdCB0
aGF0IGV2ZW4gdGhlIGRpZmZlcmVudA0KPiA+ID4gdmFyaWFudHMgb2YgdGhlIDgyNTAgYXJlIGlt
cGxlbWVudGVkIGluY29uc2lzdGVudGx5IG1ha2VzIHRoaXMNCj4gPiA+IGVzcGVjaWFsbHkgdWds
eS4uLiBJdCBjZXJ0YWlubHkgcHV0cyBhIGRhbXBlciBvbiB0aGUgZWZmb3J0cyB0bw0KPiA+ID4g
bWFrZQ0KPiA+ID4gdGhlIGhhbmRsaW5nIG9mIFJTNDg1IGluIHNlcmlhbCBkcml2ZXJzIG1vcmUg
Z2VuZXJpYy4NCj4gPg0KPiA+IE9uZSB0aGluZyB0byByZW1lbWJlciBpcyB0aGF0IFJTMjMyIChJ
SVJDIHJlYWxseSBWLjM4KSBsaW5lIGRyaXZlcg0KPiA+IGNoaXBzIGFyZSB0eXBpY2FsbHkgaW52
ZXJ0aW5nLg0KPiA+DQo+ID4gU28gdGhlIG1vZGVtIHNpZ25hbHMgb24gYSBUVEwgbGV2ZWwgb3V0
cHV0IHdpbGwgaGF2ZSB0aGUNCj4gPiBvcHBvc2l0ZSBwb2xhcml0eSB0byB0aGF0IHJlcXVpcmVk
IG9uIHRoZSBhY3R1YWwgY29ubmVjdG9yLg0KPiA+DQo+ID4gTm9ybWFsbHkgYSBVQVJUIHdpbGwg
aGF2ZSBhbiAnYWN0aXZlIGhpZ2gnIHJlZ2lzdGVyIGJpdCBmb3INCj4gPiBhIG1vZGVtIHNpZ25h
bCB0aGF0IGRyaXZlcyBhbmQgJ2FjdGl2ZSBsb3cnIHBpbiBzbyB5b3UgZ2V0DQo+ID4gdGhlIGNv
cnJlY3QgcG9sYXJpdHkgd2l0aCBhbiBpbnZlcnRpbmcgbGluZSBkcml2ZXIuDQo+ID4NCj4gPiAJ
RGF2aWQNCj4gPg0KPiANCj4gSW5kZWVkLiBBcyBmYXIgYXMgSSBjYW4gdGVsbCwgdGhpcyBwcm9w
ZXJ0eSBvZiBVQVJUcyBpcyB3aGF0IGdvdCB1cw0KPiBpbnRvIHRoaXMgbWVzczogU29tZSBwZW9w
bGUgaW50ZXJwcmV0ZWQgU0VSX1JTNDg1X1JUU19PTl9TRU5EIGFzICJzZXQNCj4gdGhlIFJUUyBm
bGFnIGluIHRoZSBNQ1IgcmVnaXN0ZXIgb24gc2VuZCIsIHdoaWxlIG90aGVyIHRob3VnaHQgaXQN
Cj4gc2hvdWxkIG1lYW4gInNldCB0aGUgUlRTIHBpbiB0byBoaWdoIG9uIHNlbmQiLCBsZWFkaW5n
IHRvIG9wcG9zaXRlDQo+IGJlaGF2aW91cnMgaW4gZGlmZmVyZW50IFVBUlQgZHJpdmVycyAoYW5k
IGV2ZW4gZGlmZmVyZW50IFVBUlQgdmFyaWFudHMNCj4gaW4gdGhlIHNhbWUgZHJpdmVyLCBpbiB0
aGUgY2FzZSBvZiB0aGUgODI1MCBmYW1pbHkpLg0KDQpIbW1tLi4uIEEgY29tcGxldGUgbWVzcy4N
ClRoZSAnUlRTIHBpbicgdGhhdCBuZWVkcyB0byBnbyBoaWdoIGlzIHRoZSBvbmUgb24gdGhlICh0
eXBpY2FsbHkpICdEJw0KY29ubmVjdG9yIGFmdGVyIHRoZSBpbnZlcnRpbmcgbGluZSBkcml2ZXIu
DQpOb3QgdGhlIHBpbiBvbiB0aGUgdWFydCBwYWNrYWdlLg0KSSdkIGV4cGVjdCBUVEwgbGV2ZWwg
c2VyaWFsIGludGVyZmFjZXMgdG8gcmVxdWlyZSBhY3RpdmUgbG93DQptb2RlbSBzaWduYWxzLg0K
DQpJZiBSUzQ4NSBpcyB0cnlpbmcgdG8gZG8gaGFsZiBkdXBsZXggdXNpbmcgUlRTIChyZXF1ZXN0
IHRvIHNlbmQpDQphbmQgQ1RTIChjbGVhciB0byBzZW5kKSB5b3UndmUgdHlwaWNhbGx5IGdvdCBi
aWdnZXIgcHJvYmxlbXMNCnRoYW4gYXNzZXJ0aW5nIFJUUyBiZWZvcmUgYSB0cmFuc21pdC4NClRo
ZSByZWFsIHByb2JsZW0gaXMgcmVtb3ZpbmcgUlRTIG9uY2UgdGhlIGxhc3QgdHJhbnNtaXQgZGF0
YSBiaXQNCih0aGUgc3RvcCBiaXQpIGhhcyBsZWZ0IHRoZSBVQVJUIHBpbi4NCkkndmUgdXNlZCBs
b2NhbCBsb29wYmFjayAodHggdG8gcngpIHRvIGRldGVjdCB0aGF0IGluIHRoZSBwYXN0Lg0KDQpP
ZiBjb3Vyc2UsIGlmIGl0IGlzIGp1c3QgZG9pbmcgZmxvdyBjb250cm9sIHRoYXQgc2hvdWxkIHVz
ZSBSRlMNCihyZWFkeSBmb3Igc2VuZGluZykgdG8gaW5kaWNhdGUgc3BhY2UgaW4gdGhlIHJlY2Vp
dmUgZmlmbyBidXQNCnVzaW5nIHRoZSBSVFMgcGluIGluc3RlYWQgdGhhdCBpcyBhIGRpZmZlcmVu
dCBtYXR0ZXIuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

