Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76651500ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbiDNKQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiDNKQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:16:55 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF27529CB3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:14:30 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-89-UrdkE9YjP8-8PEFlhH3dQw-1; Thu, 14 Apr 2022 11:14:27 +0100
X-MC-Unique: UrdkE9YjP8-8PEFlhH3dQw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Thu, 14 Apr 2022 11:14:27 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Thu, 14 Apr 2022 11:14:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Straube' <straube.linux@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
CC:     Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: staging: r8188eu: struct rt_firmware_header issues
Thread-Topic: staging: r8188eu: struct rt_firmware_header issues
Thread-Index: AQHYT26f1QQqfyXJ/0OBQVPgTDvQ2KzvF5TggAAH14CAABIl4A==
Date:   Thu, 14 Apr 2022 10:14:26 +0000
Message-ID: <74ff67ec85e14e16bb2e9f57a4fccb17@AcuMS.aculab.com>
References: <94a72ecc-3acd-758b-15a4-a7d56bf03fbe@gmail.com>
 <86a66ea4-45e3-cfa2-9130-f698ae212bfd@gmail.com>
 <51e706400b914552bfda6353020da17e@AcuMS.aculab.com>
 <a40a2a1b-a8f1-e720-be92-48858d4f6678@gmail.com>
In-Reply-To: <a40a2a1b-a8f1-e720-be92-48858d4f6678@gmail.com>
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

RnJvbTogTWljaGFlbCBTdHJhdWJlDQo+IFNlbnQ6IDE0IEFwcmlsIDIwMjIgMTE6MDgNCj4gDQo+
IE9uIDQvMTQvMjIgMTA6NDEsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBGcm9tOiBNaWNoYWVs
IFN0cmF1YmUNCj4gPj4gU2VudDogMTMgQXByaWwgMjAyMiAyMDo0Mg0KPiA+Pg0KPiA+PiBPbiA0
LzEzLzIyIDE4OjI3LCBNaWNoYWVsIFN0cmF1YmUgd3JvdGU6DQo+ID4+PiBIaSBhbGwsDQo+ID4+
Pg0KPiA+Pj4gSSB0aGluayB0aGUgcnRfZmlybXdhcmVfaGRyIHN0cnVjdHVyZSBpbiBydHdfZncu
YyBoYXMgc29tZSBpc3N1ZXMuDQo+ID4+Pg0KPiA+Pj4NCj4gPj4+IHN0cnVjdCBydF9maXJtd2Fy
ZV9oZHIgew0KPiA+Pj4gICDCoMKgwqDCoC8qwqAgOC1ieXRlIGFsaW5tZW50IHJlcXVpcmVkICov
DQo+ID4NCj4gPiBQcm9iYWJseSBuZWVkIGFuIF9fYWxpZ25lZCg4KSBhdCB0aGUgYm90dG9tIHRo
ZW4/DQo+IA0KPiBJIGRvbid0IHNlZSBhbnkgcmVhc29uIHdoeSB0aGlzIGlzIG5lZWRlZC4gRG8g
SSBtaXNzIHNvbWV0aGluZz8NCg0KRHVubm8sIHRoZSBjb21tZW50IG1pZ2h0IGJlIHdyb25nLg0K
DQoJZGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K

