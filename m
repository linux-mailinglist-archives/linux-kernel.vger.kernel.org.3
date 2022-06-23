Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C45F5579F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiFWMFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFWMFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:05:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F71B4B43C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:05:43 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-146-HnQgmSMqM4G6rapeFXaBOQ-1; Thu, 23 Jun 2022 13:05:41 +0100
X-MC-Unique: HnQgmSMqM4G6rapeFXaBOQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Thu, 23 Jun 2022 13:05:40 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Thu, 23 Jun 2022 13:05:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Philipp Hortmann' <philipp.g.hortmann@gmail.com>,
        Chang Yu <marcus.yu.56@gmail.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
CC:     "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: r8188eu: combine nested if statements into one
Thread-Topic: [PATCH] staging: r8188eu: combine nested if statements into one
Thread-Index: AQHYhr/Y2ulJ9o927EK/4or2W1xFka1c4+jQ
Date:   Thu, 23 Jun 2022 12:05:40 +0000
Message-ID: <06893216a5a04d7e84dfe3e132d333f6@AcuMS.aculab.com>
References: <20220623031515.402691-1-marcus.yu.56@gmail.com>
 <d50c16c1-0bc2-fdc4-16ab-0c27df824ffb@gmail.com>
In-Reply-To: <d50c16c1-0bc2-fdc4-16ab-0c27df824ffb@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4uDQo+IFNlZW1zIHRvIHdvcmsuIEJ1dCB0aGUgcnVsZXMgd2hpY2ggb3BlcmF0aW9uIGlzIGRv
bmUgZmlyc3QgJiYgb3IgPT0gYXJlDQo+IG5vdCB0b28gZWFzeS4NCg0KVGhleSBhcmUgdGhlIHdh
eSBhcm91bmQgeW91IHdhbnQgdGhlbSB0byBiZS4NCj09IGdlbmVyYXRlcyBhIHRydXRoIHZhbHVl
Lg0KJiYgYW5kIHx8IGNvbXBhcmUgdHJ1dGggdmFsdWVzLA0KDQpUaGUgb25seSAnd3JvbmcnIG9w
ZXJhdG9yIHByaW9yaXRpZXMgYXJlICYgYW5kIHwuDQpUaGUgc2hvcnQtY2lyY3VpdGluZyAmJiBh
bmQgfHwgd2VyZW4ndCBpbiB0aGUgdmVyeSBlYXJseQ0KdmVyc2lvbnMgb2YgQyAtIHRoZSBiaXR3
aXNlICYgYW5kIHwgd2VyZSB1c2VkLg0KV2hlbiBLJlIgYWRkZWQgJiYgYW5kIHx8IHRoZXkgbGVm
dCB0aGUgcHJpb3JpdGllcyBvZiAmIGFuIHwgYWxvbmUuDQpJIHRoZXkgdGhleSd2ZSBsYXRlciBz
YWlkIHRoZXkgc2hvdWxkIGhhdmUgYml0dGVuIHRoZSBidWxsZXQNCmFuZCBjaGFuZ2VkIHRoZSBw
cmlvcml0aWVzIGFuZCBhbGwgdGhlIGV4aXN0aW5nIEMgY29kZQ0KDQo+IEkgd291bGQgcHJlZmVy
IHRvIGhhdmU6DQo+IA0KPiBpZiAocGFkYXB0ZXIgJiYgKHBmcmVlX3JlY3ZfcXVldWUgPT0gZnJl
ZV9yZWN2X3F1ZXVlKSkNCj4gDQo+IFNvIGl0IGlzIHZlcnkgZWFzeSB0byByZWFkIHdoYXQgaXMg
ZXZhbHVhdGVkIGZpcnN0Lg0KDQpUaGF0IGp1c3Qgc3RhcnRzIGFkZGluZyB0b28gbWFueSAoKSBh
bmQgbWFrZXMgbW9yZSBjb21wbGV4DQpjb25kaXRpb25hbHMgaGFyZCB0byByZWFkLg0KDQoJRGF2
aWQNCg0KPiANCj4gQnV0IHRoaXMgaXMganVzdCBteSBvcGluaW9uIGFuZCBkb2VzIG5vdCBoYXZl
IHRvIGJlIHJpZ2h0Lg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KPiANCj4gQnllIFBo
aWxpcHANCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

