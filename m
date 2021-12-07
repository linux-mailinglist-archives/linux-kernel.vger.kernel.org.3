Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A063746B274
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbhLGFlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:41:23 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28279 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbhLGFlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:41:22 -0500
Received: from kwepemi100007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J7Tb66V4FzbjHn;
        Tue,  7 Dec 2021 13:37:38 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 kwepemi100007.china.huawei.com (7.221.188.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 13:37:50 +0800
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemm600016.china.huawei.com (7.193.23.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 13:37:50 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2308.020;
 Tue, 7 Dec 2021 13:37:50 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Jay Chen <jkchen@linux.alibaba.com>, "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>
Subject: RE: [RFC PATCH] provide per numa cma with an initial default size
Thread-Topic: [RFC PATCH] provide per numa cma with an initial default size
Thread-Index: AQHX5b5WdkB1fqcI6kSRZ5Tsh5qqyawlEoQAgAF5HwA=
Date:   Tue, 7 Dec 2021 05:37:50 +0000
Message-ID: <a3990c9921a44884b0adc448d1281b0a@hisilicon.com>
References: <20211130074556.11091-1-jkchen@linux.alibaba.com>
 <ddcdde8c-5118-048e-d5f8-6b8bc860947d@arm.com>
In-Reply-To: <ddcdde8c-5118-048e-d5f8-6b8bc860947d@arm.com>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.109]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDcs
IDIwMjEgNDowMSBBTQ0KPiBUbzogSmF5IENoZW4gPGprY2hlbkBsaW51eC5hbGliYWJhLmNvbT47
IGhjaEBsc3QuZGU7IG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbTsNCj4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IFNvbmcgQmFv
IEh1YQ0KPiAoQmFycnkgU29uZykgPHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29tPg0KPiBDYzog
emhhbmdsaWd1YW5nQGxpbnV4LmFsaWJhYmEuY29tDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENI
XSBwcm92aWRlIHBlciBudW1hIGNtYSB3aXRoIGFuIGluaXRpYWwgZGVmYXVsdCBzaXplDQo+IA0K
PiBbICtCYXJyeSBdDQo+IA0KPiBPbiAyMDIxLTExLTMwIDA3OjQ1LCBKYXkgQ2hlbiB3cm90ZToN
Cj4gPiAgICBJbiB0aGUgYWN0dWFsIHByb2R1Y3Rpb24gZW52aXJvbm1lbnQsIHdoZW4gd2Ugb3Bl
bg0KPiA+IGNtYSBhbmQgcGVyIG51bWEgY21hLCBpZiB3ZSBkbyBub3QgaW5jcmVhc2UgdGhlIHBl
cg0KPiA+IG51bWEgc2l6ZSBjb25maWd1cmF0aW9uIGluIGNtZGxpbmUsIHdlIGZpbmQgdGhhdCBv
dXINCj4gPiBwZXJmb3JtYW5jZSBoYXMgZHJvcHBlZCBieSAyMCUuDQo+ID4gICAgVGhyb3VnaCBh
bmFseXNpcywgd2UgZm91bmQgdGhhdCB0aGUgZGVmYXVsdCBzaXplIG9mDQo+ID4gcGVyIG51bWEg
aXMgMCwgd2hpY2ggY2F1c2VzIHRoZSBkcml2ZXIgdG8gYWxsb2NhdGUNCj4gPiBtZW1vcnkgZnJv
bSBjbWEsIHdoaWNoIGFmZmVjdHMgcGVyZm9ybWFuY2UuIFRoZXJlZm9yZSwNCj4gPiB3ZSB0aGlu
ayB3ZSBuZWVkIHRvIHByb3ZpZGUgYSBkZWZhdWx0IHNpemUuDQo+IA0KPiBMb29raW5nIGJhY2sg
YXQgc29tZSBvZiB0aGUgcmV2aWV3IGRpc2N1c3Npb25zLCBJIHRoaW5rIGl0IG1heSBoYXZlIGJl
ZW4NCj4gaW50ZW50aW9uYWwgdGhhdCBwZXItbm9kZSBhcmVhcyBhcmUgbm90IGFsbG9jYXRlZCBi
eSBkZWZhdWx0LCBzaW5jZSBpdCdzDQo+IHRoZSBraW5kIG9mIHRoaW5nIHRoYXQgcmVhbGx5IHdh
bnRzIHRvIGJlIHR1bmVkIHRvIHRoZSBwYXJ0aWN1bGFyIHN5c3RlbQ0KPiBhbmQgd29ya2xvYWQs
IGFuZCBhcyBzdWNoIGl0IHNlZW1lZCByZWFzb25hYmxlIHRvIGV4cGVjdCB1c2VycyB0bw0KPiBw
cm92aWRlIGEgdmFsdWUgb24gdGhlIGNvbW1hbmQgbGluZSBpZiB0aGV5IHdhbnRlZCB0aGUgZmVh
dHVyZS4gVGhhdCdzDQo+IGNlcnRhaW5seSB3aGF0IHRoZSBLY29uZmlnIHRleHQgaW1wbGllcy4N
Cj4gDQo+IFRoYW5rcywNCj4gUm9iaW4uDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEpheSBDaGVu
IDxqa2NoZW5AbGludXguYWxpYmFiYS5jb20+DQo+ID4gLS0tDQo+ID4gICBrZXJuZWwvZG1hL2Nv
bnRpZ3VvdXMuYyB8IDIgKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9kbWEvY29udGlndW91
cy5jIGIva2VybmVsL2RtYS9jb250aWd1b3VzLmMNCj4gPiBpbmRleCAzZDYzZDkxY2JhNWMuLjNi
ZWY4YmYzNzFkOSAxMDA2NDQNCj4gPiAtLS0gYS9rZXJuZWwvZG1hL2NvbnRpZ3VvdXMuYw0KPiA+
ICsrKyBiL2tlcm5lbC9kbWEvY29udGlndW91cy5jDQo+ID4gQEAgLTk5LDcgKzk5LDcgQEAgZWFy
bHlfcGFyYW0oImNtYSIsIGVhcmx5X2NtYSk7DQo+ID4gICAjaWZkZWYgQ09ORklHX0RNQV9QRVJO
VU1BX0NNQQ0KPiA+DQo+ID4gICBzdGF0aWMgc3RydWN0IGNtYSAqZG1hX2NvbnRpZ3VvdXNfcGVy
bnVtYV9hcmVhW01BWF9OVU1OT0RFU107DQo+ID4gLXN0YXRpYyBwaHlzX2FkZHJfdCBwZXJudW1h
X3NpemVfYnl0ZXMgX19pbml0ZGF0YTsNCj4gPiArc3RhdGljIHBoeXNfYWRkcl90IHBlcm51bWFf
c2l6ZV9ieXRlcyBfX2luaXRkYXRhID0gc2l6ZV9ieXRlczsNCg0KSSBkb24ndCB0aGluayB0aGUg
c2l6ZSBmb3IgdGhlIGRlZmF1bHQgY21hIGNhbiBhcHBseSB0bw0KcGVyLW51bWEgQ01BLg0KDQpX
ZSBkaWQgaGF2ZSBzb21lIGRpc2N1c3Npb24gcmVnYXJkaW5nIHRoZSBzaXplIHdoZW4gcGVyLW51
bWEgY21hIHdhcw0KYWRkZWQsIGFuZCBpdCB3YXMgZG9uZSBieSBhIEtjb25maWcgb3B0aW9uLiBJ
IHRoaW5rIHdlIGhhdmUgZGVjaWRlZA0KdG8gbm90IGhhdmUgYW55IGRlZmF1bHQgc2l6ZSBvdGhl
ciB0aGFuIDAuIERlZmF1bHQgc2l6ZSAwIGlzIHBlcmZlY3QsDQp0aGlzIHdpbGwgZW5mb3JjZSB1
c2VycyB0byBzZXQgYSBwcm9wZXIgImNtYV9wZXJudW1hPSIgYm9vdGFyZ3MuDQoNCj4gPg0KPiA+
ICAgc3RhdGljIGludCBfX2luaXQgZWFybHlfY21hX3Blcm51bWEoY2hhciAqcCkNCj4gPiAgIHsN
Cj4gPg0KDQpUaGFua3MNCkJhcnJ5DQo=
