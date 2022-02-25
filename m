Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD414C41E7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbiBYKCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiBYKCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:02:00 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DA3E195323
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:01:28 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-315-fXO9E7y_OvWFazQc4VIggg-1; Fri, 25 Feb 2022 10:01:25 +0000
X-MC-Unique: fXO9E7y_OvWFazQc4VIggg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Fri, 25 Feb 2022 10:01:23 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Fri, 25 Feb 2022 10:01:23 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drop -Wdeclaration-after-statement
Thread-Topic: [PATCH] Drop -Wdeclaration-after-statement
Thread-Index: AQHYKh/zQ9aUnCTxokON3vzrNPZHbqykB2rQ
Date:   Fri, 25 Feb 2022 10:01:23 +0000
Message-ID: <59387c6677af43c18d434b4f3c1e5430@AcuMS.aculab.com>
References: <YhiQPhsoODiXRAPy@localhost.localdomain>
In-Reply-To: <YhiQPhsoODiXRAPy@localhost.localdomain>
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

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDI1IEZlYnJ1YXJ5IDIwMjIgMDg6MTYNCj4g
DQo+IFB1dHRpbmcgZGVjbGFyYXRpb25zIGJlZm9yZSBzdGF0ZW1lbnQgaXMgcmVsaWN0IG9mIHNp
bmdsZSBwYXNzIGNvbXBpbGVyDQo+IGVyYS4gSXQgd2FzIG5lY2Vzc2FyeSB0byBhbGxvY2F0ZSBz
dGFjayBzbG90cyBiZWZvcmUgZ2VuZXJhdGluZyBjb2RlLg0KPiANCj4gUmVjZW50bHkgYWRkZWQg
c3RhdGljX2Fzc2VydCgpIGlzIGEgZGVjbGFyYXRpb24uIC1XZGVjbGFyYXRpb24tYWZ0ZXItc3Rh
dGVtZW50DQo+IHByZXZlbnRzIGl0cyBwbGFjZW1lbnQgYW55d2hlcmUgaW4gdGhlIGNvZGUgZm9y
IG5vIHJlYXNvbi4NCg0KVGhhdCBjb3VsZCBlbmNsb3NlIGl0cyBkZWNsYXJhdGlvbiBpbnNpZGUg
YSBibG9jay4NCkJ1dCB0aGVuIGl0IHdvdWxkbid0IGJlIHVzYWJsZSBhdCBnbG9iYWwgc2NvcGUg
KGlzIGl0IGFueXdheT8pDQoNCj4gUGxhY2luZyB2YXJpYWJsZSBkZWNsYXJhdGlvbnMgaW4gdGhl
IGJlZ2lubmluZyBvZiB0aGUgYmxvY2sgaW5jcmVhc2VzDQo+IHZhcmlhYmxlICJMT0MgbGlmZXRp
bWUiIHNvIHRvIHNwZWFrIGFuZCBjaGFuY2VzIHRoYXQgaXQgd2lsbCBiZSBtaXN1c2VkLg0KPiBU
aGlzIGlzIHZlcnkgbG93IHByb2JhYmlsaXR5IGJ1ZyBidXQgc3RpbGwuIERlY2xhcmluZyB2YXJp
YWJsZXMgcmlnaHQNCj4gYmVmb3JlIGZpcnN0IHVzZSB3aWxsIG1ha2UgIkxPQyBsaWZldGltZSIg
c21hbGxlci4NCg0KTkFLIGl0IG1ha2VzIGl0IHZlcnkgaGFyZCBmb3IgYSBodW1hbiAoc29tZSBv
ZiB1cyBhcmUpIHRvIGZpbmQNCnRoZSBkZWNsYXJhdGlvbi4NCg0KSW5kZWVkIHB1dHRpbmcgdGhl
bSBhbnl3aGVyZSBvdGhlciB0aGF0IHRoZSB0b3Agb2YgYSBmdW5jdGlvbg0Kb3IgdGhlIHRvcCBv
ZiBhIHZlcnkgc2hvcnQgY29kZSBibG9jayBtYWtlcyB0aGVtIGhhcmQgdG8gZmluZC4NCg0KCURh
dmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCg==

