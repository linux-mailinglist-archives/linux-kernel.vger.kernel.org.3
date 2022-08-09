Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7435E58DAE7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244812AbiHIPQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244779AbiHIPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:16:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5A699584
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:16:30 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-272-zpkONdTzPdWH-Kj0IJX1Bg-1; Tue, 09 Aug 2022 16:16:27 +0100
X-MC-Unique: zpkONdTzPdWH-Kj0IJX1Bg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 9 Aug 2022 16:16:26 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 9 Aug 2022 16:16:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Damien Le Moal' <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>,
        kernel test robot <oliver.sang@intel.com>
CC:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>
Subject: RE: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
Thread-Topic: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
Thread-Index: AQHYrAAmXDHshJwwj0GxX5X1j6JqC62mrM6g
Date:   Tue, 9 Aug 2022 15:16:26 +0000
Message-ID: <c4b45c0e06af473abe17e3471e1bb948@AcuMS.aculab.com>
References: <YuzPMMnnY739Tnit@xsang-OptiPlex-9020>
 <1f498d4a-f93f-ceb4-b713-753196e5e08d@opensource.wdc.com>
 <3451fa5a-6229-073f-ae18-0c232cd48ed5@huawei.com>
 <e4106ffa-3842-45c0-9756-5226cfcfa17d@opensource.wdc.com>
In-Reply-To: <e4106ffa-3842-45c0-9756-5226cfcfa17d@opensource.wdc.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
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

Li4uDQo+ID4+IFdpdGhvdXQga25vd2luZyB3aGF0IHRoZSBkZXZpY2UgYWRhcHRlciBpcywgaGFy
ZCB0byBzYXkgd2hlcmUgdGhlIHByb2JsZW0gaXMuIEkNCj4gPj4gc3VzcGVjdCB0aGF0IHdpdGgg
dGhlIHBhdGNoIGFwcGxpZWQsIHdlIG1heSBiZSBlbmRpbmcgdXAgd2l0aCBhIHNtYWxsIGRlZmF1
bHQNCj4gPj4gbWF4X3NlY3RvcnMgdmFsdWUsIGNhdXNpbmcgb3ZlcmhlYWQgZHVlIHRvIG1vcmUg
Y29tbWFuZHMgdGhhbiBuZWNlc3NhcnkuDQo+ID4+DQo+ID4+IFdpbGwgY2hlY2sgd2hhdCBJIHNl
ZSB3aXRoIG15IHRlc3QgcmlnLg0KPiA+DQo+ID4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgdGhpcyBw
YXRjaCBzaG91bGQgbm90IG1ha2UgYSBkaWZmZXJlbmNlIHVubGVzcyB0aGUNCj4gPiBBVEEgc2hv
c3QgZHJpdmVyIGlzIHNldHRpbmcgdGhlIG1heF9zZWN0b3JzIHZhbHVlIHVubmVjZXNzYXJpbHkg
bG93Lg0KPiANCj4gVGhhdCBpcyBteSBodW5jaCB0b28sIGhlbmNlIG15IHF1ZXN0aW9uIGFib3V0
IHdoaWNoIGhvc3QgZHJpdmVyIGlzIGJlaW5nIHVzZWQNCj4gZm9yIHRoaXMgdGVzdC4uLiBUaGF0
IGlzIG5vdCBhcHBhcmVudCBmcm9tIHRoZSBwcm9ibGVtIHJlcG9ydC4NCg0KTm8gb25lJ3MgZmFs
bGVuIG92ZXIgdGhlIG9sZCBwcm9ibGVtIGFuZCBtYW5hZ2VkIHRvIGxpbWl0DQp0aGUgbnVtYmVy
IG9mIHNlY3RvcnMgaW4gYSByZWFkIHRvIHRoZSBudW1iZXIgb2Ygc2VjdG9ycw0KaW4gKElJUkMp
IGEgJ211bHRpIHNlY3RvcicgcmVhZCB0aGF0IHVzZXMgYSBzaW5nbGUgRE1BIGJ1cnN0Pw0KDQpX
YXMgYWx3YXlzIGEgZ29vZCB3YXkgb2Yga2lsbGluZyBkaXNrIHBlcmZvcm1hbmNlLg0KDQpJSVJD
IHRoZSBtYXhpbXVtIG51bWJlciBvZiBzZWN0b3JzIGZvciBhbiBBVEEgZGlzayB0cmFuc2ZlciBp
cyAyNTUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

