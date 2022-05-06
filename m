Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406D451D618
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391115AbiEFLDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391109AbiEFLDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:03:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71385237EA
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:59:26 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-279-PxjpkewpOdqqBNc_gpZY_Q-1; Fri, 06 May 2022 11:59:23 +0100
X-MC-Unique: PxjpkewpOdqqBNc_gpZY_Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 6 May 2022 11:59:22 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 6 May 2022 11:59:22 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?utf-8?B?J0JhbHRhesOhciBSYWRpY3Mn?= <baltazar.radics@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: 9 bit serial / non-blocking TCSADRAIN
Thread-Topic: 9 bit serial / non-blocking TCSADRAIN
Thread-Index: AQHYYKHkIv/T90SmAkOWg5XG/atCOK0RrosQ
Date:   Fri, 6 May 2022 10:59:22 +0000
Message-ID: <bb788810d84d491aa6357d411895242b@AcuMS.aculab.com>
References: <052a814001aaa46eab844f1d9693ddd9d731c164.camel@gmail.com>
In-Reply-To: <052a814001aaa46eab844f1d9693ddd9d731c164.camel@gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQmFsdGF6w6FyIFJhZGljcw0KPiBTZW50OiAwNSBNYXkgMjAyMiAxODowMg0KPiANCj4g
SSB3YW50IHRvIHVzZSBhIHJhc3BiZXJyeSBwaSdzIHNlcmlhbCB0byBjb21tdW5pY2F0ZSBvdmVy
IGEgcHJvdG9jb2wNCj4gdGhhdCB1c2VzIDktYml0IGNoYXJhY3RlcnMsIHNvIGN1cnJlbnRseSBJ
J20gdXNpbmcgdGhlIHN0aWNrIHBhcml0eQ0KPiBtb2RlIChDTVNQQVIpIGFuZCB0b2dnbGluZyBi
ZXR3ZWVuIG9kZCBhbmQgZXZlbiBwYXJpdHksIHRoZW4gdXNpbmcNCj4gdGNzZXRhdHRyIHdpdGgg
VENTQURSQUlOIGFzIHRoZSBzZWNvbmQgYXJndW1lbnQsIHdoaWNoIGJsb2NrcyB1bnRpbCBhbGwN
Cj4gYnl0ZXMgYXJlIHRyYW5zbWl0dGVkLiBJcyB0aGVyZSBhIG5vbi1ibG9ja2luZyBhcGkgdG8g
ZG8gdGhlIHNhbWUNCj4gdGhpbmcsIHNvIEkgY2FuIHVzZSBpdCBmcm9tIHBvbGwgLyBzZWxlY3Q/
IChJZiB0aGVyZSdzIGEgYmV0dGVyIHdheSB0bw0KPiBkbyA5IGJpdCBjaGFyYWN0ZXIgc2l6ZSwg
dGhhdCdkIGJlIGV2ZW4gYmV0dGVyLiBGb3IgbXkgcHJvdG9jb2wsIHRoZQ0KPiA5dGggYml0IGlz
IG9ubHkgdXNlZCB0byB0ZWxsIGFkZHJlc3MgYnl0ZXMgZnJvbSBkYXRhIGJ5dGVzLCBzbyBJIGRv
bid0DQo+IGhhdmUgdG8gY2hhbmdlIGl0IG9mdGVuLCBzbyBJIGd1ZXNzIG15IGN1cnJlbnQgbWV0
aG9kIGlzbid0IHRvbw0KPiBob3JyaWJsZS4pDQoNCkRvZXMgYW55dGhpbmcgZ2l2ZSB0aGUgb3B0
aW9uIG9mIGdlbmVyYXRpbmcgbm9uLWhkbGMgc3luY2hyb25vdXMgZGF0YT8NCllvdSBtaWdodCBi
ZSBhYmxlIHRvIHVzZSB0d28gYnl0ZXMgdG8gZ2VuZXJhdGUgYSBzaW5nbGUgOS1iaXQNCmFzeW5j
IGNoYXJhY3RlciBvciB0aHJlZSBieXRlcyB0byBnZW5lcmF0ZSB0d28gOS1iaXQgY2hhcmFjdGVy
cy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBS
b2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9u
IE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

