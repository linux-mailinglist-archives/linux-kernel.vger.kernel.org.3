Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6A5494E89
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244839AbiATNCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:02:35 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:55330 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244869AbiATNCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:02:33 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-33-Vn3vaJQAO5ObVFev711Zzw-1; Thu, 20 Jan 2022 13:02:29 +0000
X-MC-Unique: Vn3vaJQAO5ObVFev711Zzw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 20 Jan 2022 13:02:27 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 20 Jan 2022 13:02:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>, Guo Ren <guoren@kernel.org>
CC:     linux-s390 <linux-s390@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Drew Fustini <drew@beagleboard.org>,
        Anup Patel <anup@brainfault.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "inux-parisc@vger.kernel.org" <inux-parisc@vger.kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        liush <liush@allwinnertech.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Wei Fu <wefu@redhat.com>
Subject: RE: [PATCH V3 03/17] asm-generic: compat: Cleanup duplicate
 definitions
Thread-Topic: [PATCH V3 03/17] asm-generic: compat: Cleanup duplicate
 definitions
Thread-Index: AQHYDfvLsUgI09Yi+EGR4Ve6KMrB5Kxr3nRg
Date:   Thu, 20 Jan 2022 13:02:27 +0000
Message-ID: <f2c1a3a10bf643d693afed6d23b3baf9@AcuMS.aculab.com>
References: <20220120073911.99857-4-guoren@kernel.org>
 <CAK8P3a1UmnjHk8B6hSULiKv3FKoY5BW9=4=ESerQzc+4=LR5Zw@mail.gmail.com>
In-Reply-To: <CAK8P3a1UmnjHk8B6hSULiKv3FKoY5BW9=4=ESerQzc+4=LR5Zw@mail.gmail.com>
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

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAyMCBKYW51YXJ5IDIwMjIgMTE6NTINCi4uDQo+
IEFzIHdpdGggY29tcGF0X2Zsb2NrLCB0aGUgcGFja2VkIGF0dHJpYnV0ZSBoYXMgbm8gaW1wYWN0
IG9uIHRoZSBsYXlvdXQNCj4gaGVyZSwgYnV0IHBsZWFzZSBkcm9wIGl0IGFueXdheSBmb3IgY29u
c2lzdGVuY3kuDQoNCk5ldmVyIG1pbmQgdGhlIHN0cnVjdHVyZSBsYXlvdXQsIGJlY2F1c2UgJ3Bh
Y2tlZCcgYWxsb3dzIHRoZQ0Kc3RydWN0dXJlIHRvIGJlIGFsaWduZWQgb24gYW55IGJvdW5kYXJ5
IGl0IGZvcmNlcyB0aGUgY29tcGlsZXINCnRvIHVzZSBieXRlIG1lbW9yeSBhY2Nlc3NlcyBhbmQg
c2hpZnRzIG9uIHNvbWUgYXJjaGl0ZWN0dXJlcy4NClRoaXMgaXMgYSBob3JyaWQgcGVyZm9ybWFu
Y2UgcGVuYWx0eS4NCg0KJ3BhY2tlZCcgc2hvdWxkIG9ubHkgYmUgc3BlY2lmaWVkIGZvciBzdHJ1
Y3R1cmVzIHRoYXQgY2FuDQpvY2N1ciBvbiBhbnkgYWRkcmVzcyBib3VuZGFyeS4NCmllIGJhc2lj
YWxseSBuZXZlci4NCg0KSWYgeW91IG5lZWQgdG8gcmVtb3ZlIHRoZSBpbXBsaWNpdCBwYWQgYmVm
b3JlIGEgZmllbGQgKGVnIDY0Yml0DQpmaWVsZHMgb24geDY0LTMyKSB0aGVuIHlvdSBjYW4gbWFy
ayB0aGUgZmllbGQgaXRzZWxmIGFzICdwYWNrZWQnLg0KQWx0aG91Z2gsIGluIHRoYXQgY2FzZSwg
cHV0dGluZyB0aGUgYXR0cmlidXRlIG9uIHRoZSB0eXBlIChjb21wYXRfczY0KQ0KaXMgZ2VuZXJh
bGx5IGNsZWFuZXIuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

