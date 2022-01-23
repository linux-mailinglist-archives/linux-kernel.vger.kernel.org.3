Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9874A497605
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 23:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbiAWWft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 17:35:49 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:58080 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229944AbiAWWfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 17:35:46 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-146-j431FoBtPWOTRkv9X37z6Q-1; Sun, 23 Jan 2022 22:35:43 +0000
X-MC-Unique: j431FoBtPWOTRkv9X37z6Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Sun, 23 Jan 2022 22:35:40 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Sun, 23 Jan 2022 22:35:40 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'michael@michaelkloos.com'" <michael@michaelkloos.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] Fixed: Misaligned memory access. Fixed pointer
 comparison.
Thread-Topic: [PATCH v2] Fixed: Misaligned memory access. Fixed pointer
 comparison.
Thread-Index: AQHYEHnD40bov+QiXEW/3JioguNB76xxMaEw
Date:   Sun, 23 Jan 2022 22:35:40 +0000
Message-ID: <228cbdb42a5c4c2f9d7214d2685fcaeb@AcuMS.aculab.com>
References: <20220123034518.3717116-1-michael@michaelkloos.com>
 <fed7ee473044432180c67b4adc0eb45d@AcuMS.aculab.com>
 <c184c65e-c960-8ecc-7cfe-d58af1cde0a3@michaelkloos.com>
In-Reply-To: <c184c65e-c960-8ecc-7cfe-d58af1cde0a3@michaelkloos.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogbWljaGFlbEBtaWNoYWVsa2xvb3MuY29tDQo+IFNlbnQ6IDIzIEphbnVhcnkgMjAyMiAx
Njo1NA0KPiANCj4gTm8uICBJdCBvbmx5IHVzZXMgdGFicy4gIFRoZSBwcmV2aW91cyB2ZXJzaW9u
IHVzZWQgc3BhY2VzLg0KDQpBaCwgaXQgd2FzIHRoZSBvbGQgb25lIHRoYXQgd2FzIHdyb25nLg0K
T25lIG9mIHRoZW0gd2FzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

