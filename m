Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C53485387
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 14:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbiAENZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 08:25:19 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4351 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbiAENZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:25:16 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JTVWX3Rm9z67MQZ;
        Wed,  5 Jan 2022 21:22:00 +0800 (CST)
Received: from lhreml717-chm.china.huawei.com (10.201.108.68) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 14:25:14 +0100
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml717-chm.china.huawei.com (10.201.108.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 13:25:13 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.020; Wed, 5 Jan 2022 13:25:13 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "Alexandru.Elisei@arm.com" <Alexandru.Elisei@arm.com>,
        "qperret@google.com" <qperret@google.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v4 0/4] kvm/arm: New VMID allocator based on asid
Thread-Topic: [PATCH v4 0/4] kvm/arm: New VMID allocator based on asid
Thread-Index: AQHX35sqG4N0fL5BTkOeJNZZBpVcWaxUrtTQ
Date:   Wed, 5 Jan 2022 13:25:13 +0000
Message-ID: <d82034bb5c954de692a02bd13ccbf5d8@huawei.com>
References: <20211122121844.867-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20211122121844.867-1-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.25.20]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkEgZ2VudGxlIHBpbmcgb24gdGhpcyBzZXJpZXMuIFBsZWFzZSB0YWtlIGEgbG9vayBh
bmQgbGV0IG1lIGtub3cgdGhlIG5ldyBhcHByb2FjaA0KdGFrZW4gaW4gdGhpcyByZXZpc2lvbiBp
cyBnb29kIGVub3VnaCBvciBub3QuIA0KDQpBcHByZWNpYXRlIHlvdXIgZmVlZGJhY2suDQoNClRo
YW5rcywNClNoYW1lZXINCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBs
aW51eC1hcm0ta2VybmVsIFttYWlsdG86bGludXgtYXJtLWtlcm5lbC1ib3VuY2VzQGxpc3RzLmlu
ZnJhZGVhZC5vcmddDQo+IE9uIEJlaGFsZiBPZiBTaGFtZWVyIEtvbG90aHVtDQo+IFNlbnQ6IDIy
IE5vdmVtYmVyIDIwMjEgMTI6MTkNCj4gVG86IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsga3ZtYXJtQGxpc3RzLmNzLmNvbHVtYmlhLmVkdTsNCj4gbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBDYzogbWF6QGtlcm5lbC5vcmc7IHdpbGxAa2VybmVsLm9yZzsgY2F0
YWxpbi5tYXJpbmFzQGFybS5jb207DQo+IGphbWVzLm1vcnNlQGFybS5jb207IGp1bGllbi50aGll
cnJ5LmtkZXZAZ21haWwuY29tOw0KPiBzdXp1a2kucG91bG9zZUBhcm0uY29tOyBqZWFuLXBoaWxp
cHBlQGxpbmFyby5vcmc7DQo+IEFsZXhhbmRydS5FbGlzZWlAYXJtLmNvbTsgcXBlcnJldEBnb29n
bGUuY29tOyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+
OyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHY0IDAv
NF0ga3ZtL2FybTogTmV3IFZNSUQgYWxsb2NhdG9yIGJhc2VkIG9uIGFzaWQNCj4gDQo+IENoYW5n
ZXMgZnJvbSB2MzoNCj4gLSBNYWluIGNoYW5nZSBpcyBpbiBwYXRjaCAjNCwgd2hlcmUgdGhlIFZN
SUQgaXMgbm93IHNldCB0byBhbg0KPiAgIGludmFsaWQgb25lIG9uIHZDUFUgc2NoZWR1bGUgb3V0
LiBJbnRyb2R1Y2VkIGFuDQo+ICAgSU5WQUxJRF9BQ1RJVkVfVk1JRCB3aGljaCBpcyBiYXNpY2Fs
bHkgYSBWTUlEIDAgd2l0aCBnZW5lcmF0aW9uIDEuDQo+IMKgIFNpbmNlIHRoZSBiYXNpYyBhbGxv
Y2F0b3IgYWxnb3JpdGhtIHJlc2VydmVzIHZtaWQgIzAsIGl0IGlzIG5ldmVyDQo+ICAgdXNlZCBh
cyBhbiBhY3RpdmUgVk1JRC4gVGhpcyAoaG9wZWZ1bGx5KSB3aWxsIGZpeCB0aGUgaXNzdWUgb2YN
Cj4gICB1bm5lY2Vzc2FyaWx5IHJlc2VydmluZyBWTUlEIHNwYWNlIHdpdGggYWN0aXZlX3ZtaWRz
IHdoZW4gdGhvc2UNCj4gICBWTXMgYXJlIG5vIGxvbmdlciBhY3RpdmVbMF0gYW5kIGF0IHRoZSBz
YW1lIHRpbWUgYWRkcmVzcyB0aGUNCj4gICBwcm9ibGVtIG5vdGVkIGluIHYzIHdoZXJlaW4gZXZl
cnl0aGluZyBlbmRzIHVwIGluIHNsb3ctcGF0aFsxXS4NCj4gDQo+IFRlc3Rpbmc6DQo+IMKgLVJ1
biB3aXRoIFZNSUQgYml0IHNldCB0byA0IGFuZCBtYXhjcHVzIHRvIDggb24gRDA2LiBUaGUgdGVz
dA0KPiAgIGludm9sdmVzIHJ1bm5pbmcgY29uY3VycmVudGx5IDUwIGd1ZXN0cyB3aXRoIDQgdkNQ
VXMuIEVhY2gNCj4gICBndWVzdCB3aWxsIHRoZW4gZXhlY3V0ZSBoYWNrYmVuY2ggNSB0aW1lcyBi
ZWZvcmUgZXhpdGluZy4NCj4gICBObyBjcmFzaCB3YXMgb2JzZXJ2ZWQgZm9yIGEgNC1kYXkgY29u
dGludW91cyBydW4uDQo+IMKgIFRoZSBsYXRlc3QgYnJhbmNoIGlzIGhlcmUsDQo+IMKgIMKgaHR0
cHM6Ly9naXRodWIuY29tL2hpc2lsaWNvbi9rZXJuZWwtZGV2L3RyZWUvcHJpdmF0ZS12NS4xNi1y
YzEtdm1pZC12NA0KPiANCj4gwqAtVExBKyBtb2RlbC4gTW9kaWZpZWQgdGhlIGFzaWRhbGxvYyBt
b2RlbCB0byBpbmNvcnBvcmF0ZSB0aGUgbmV3DQo+ICAgVk1JRCBhbGdvLiBUaGUgbWFpbiBkaWZm
ZXJlbmNlcyBhcmUsDQo+IMKgIC1mbHVzaF90bGJfYWxsKCkgaW5zdGVhZCBvZiBsb2NhbF90bGJf
Zmx1c2hfYWxsKCkgb24gcm9sbG92ZXIuDQo+IMKgIC1JbnRyb2R1Y2VkIElOVkFMSURfVk1JRCBh
bmQgdkNQVSBTY2hlZCBPdXQgbG9naWMuDQo+IMKgIC1ObyBDblAgKFJlbW92ZWQgVW5pcXVlQVNJ
REFsbENQVXMgJiBVbmlxdWVBU0lEQWN0aXZlVGFzayBpbnZhcmlhbnRzKS4NCj4gwqAgLVJlbW92
ZWQgwqBVbmlxdWVWTUlEUGVyQ1BVIGludmFyaWFudCBmb3Igbm93IGFzIGl0IGxvb2tzIGxpa2UN
Cj4gICAgYmVjYXVzZSBvZiB0aGUgc3BlY3VsYXRpdmUgZmV0Y2hpbmcgd2l0aCBmbHVzaF90bGJf
YWxsKCkgdGhlcmUNCj4gICAgaXMgYSBzbWFsbCB3aW5kb3cgd2hlcmUgdGhpcyBnZXRzIHRyaWdn
ZXJlZC4gSWYgSSBjaGFuZ2UgdGhlDQo+ICAgIGxvZ2ljIGJhY2sgdG8gbG9jYWxfZmx1c2hfdGxi
X2FsbCgpLCBVbmlxdWVWTUlEUGVyQ1BVIHNlZW1zIHRvDQo+ICAgIGJlIGZpbmUuIFdpdGggbXkg
bGltaXRlZCBrbm93bGVkZ2Ugb24gVExBKyBtb2RlbCwgaXQgaXMgbm90DQo+ICAgIGNsZWFyIHRv
IG1lIHdoZXRoZXIgdGhpcyBpcyBhIHByb2JsZW0gd2l0aCB0aGUgYWJvdmUgbG9naWMNCj4gICAg
b3IgdGhlIFZNSUQgbW9kZWwgaW1wbGVtZW50YXRpb24uIFJlYWxseSBhcHByZWNpYXRlIGFueSBo
ZWxwDQo+ICAgIHdpdGggdGhlIG1vZGVsLg0KPiAgICBUaGUgaW5pdGlhbCBWTUlEIFRMQSsgbW9k
ZWwgaXMgaGVyZSwNCj4gICAgaHR0cHM6Ly9naXRodWIuY29tL3NoYW1pYWxpMjAwOC9rZXJuZWwt
dGxhL3RyZWUvcHJpdmF0ZS12bWlkYWxsb2MtdjENCj4gDQo+IFBsZWFzZSB0YWtlIGEgbG9vayBh
bmQgbGV0IG1lIGtub3cuDQo+IA0KPiBUaGFua3MsDQo+IFNoYW1lZXINCj4gDQo+IFswXQ0KPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9rdm1hcm0vMjAyMTA3MjExNjA2MTQuR0MxMTAwM0B3aWxs
aWUtdGhlLXRydWNrLw0KPiBbMV0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcva3ZtYXJtLzIw
MjEwODAzMTE0MDM0LkdCMzA4NTNAd2lsbGllLXRoZS10cnVjay8NCj4gDQo+IEhpc3Rvcnk6DQo+
IC0tLS0tLS0tDQo+IHYyIC0tPiB2Mw0KPiAgIC1Ecm9wcGVkIGFkZGluZyBhIG5ldyBzdGF0aWMg
a2V5IGFuZCBjcHVmZWF0dXJlIGZvciByZXRyaWV2aW5nDQo+ICAgIHN1cHBvcnRlZCBWTUlEIGJp
dHMuIEluc3RlYWQsIHdlIG5vdyBtYWtlIHVzZSBvZiB0aGUNCj4gICAga3ZtX2FybV92bWlkX2Jp
dHMgdmFyaWFibGUgKHBhdGNoICMyKS4NCj4gDQo+ICAgLVNpbmNlIHdlIGV4cGVjdCBsZXNzIGZy
ZXF1ZW50IHJvbGxvdmVyIGluIHRoZSBjYXNlIG9mIFZNSURzLA0KPiAgICB0aGUgVExCIGludmFs
aWRhdGlvbiBpcyBub3cgYnJvYWRjYXN0ZWQgb24gcm9sbG92ZXIgaW5zdGVhZA0KPiAgICBvZiBr
ZWVwaW5nIHBlciBDUFUgZmx1c2hfcGVuZGluZyBpbmZvIGFuZCBpc3N1aW5nIGEgbG9jYWwNCj4g
ICAgY29udGV4dCBmbHVzaC4NCj4gDQo+ICAgLUNsZWFyIGFjdGl2ZV92bWlkcyBvbiB2Q1BVIHNj
aGVkdWxlIG91dCB0byBhdm9pZCB1bm5lY2Vzc2FyaWx5DQo+ICAgIHJlc2VydmluZyB0aGUgVk1J
RCBzcGFjZShwYXRjaCAjMykuDQo+IA0KPiAgIC1JIGhhdmUga2VwdCB0aGUgc3RydWN0IGt2bV92
bWlkIGFzIGl0IGlzIGZvciBub3coaW5zdGVhZCBvZiBhDQo+ICAgIHR5cGVkZWYgYXMgc3VnZ2Vz
dGVkKSwgYXMgd2UgbWF5IHNvb24gYWRkIGFub3RoZXIgdmFyaWFibGUgdG8NCj4gICAgaXQgd2hl
biB3ZSBpbnRyb2R1Y2UgUGlubmVkIEtWTSBWTUlEIHN1cHBvcnQuDQo+IA0KPiBSRkN2MSAtLT4g
djINCj4gICAgLURyb3BwZWQgInBpbm5lZCBWTUlEIiBzdXBwb3J0IGZvciBub3cuDQo+ICAgIC1E
cm9wcGVkIFJGQyB0YWcuDQo+IFJGQ3YxDQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9r
dm1hcm0vMjAyMTA1MDYxNjUyMzIuMTk2OS0xLXNoYW1lZXJhbGkua29sb3RodQ0KPiBtLnRob2Rp
QGh1YXdlaS5jb20vDQo+IA0KPiBKdWxpZW4gR3JhbGwgKDEpOg0KPiAgIEtWTTogYXJtNjQ6IEFs
aWduIHRoZSBWTUlEIGFsbG9jYXRpb24gd2l0aCB0aGUgYXJtNjQgQVNJRA0KPiANCj4gU2hhbWVl
ciBLb2xvdGh1bSAoMyk6DQo+ICAgS1ZNOiBhcm02NDogSW50cm9kdWNlIGEgbmV3IFZNSUQgYWxs
b2NhdG9yIGZvciBLVk0NCj4gICBLVk06IGFybTY0OiBNYWtlIFZNSUQgYml0cyBhY2Nlc3NpYmxl
IG91dHNpZGUgb2YgYWxsb2NhdG9yDQo+ICAgS1ZNOiBhcm02NDogTWFrZSBhY3RpdmVfdm1pZHMg
aW52YWxpZCBvbiB2Q1BVIHNjaGVkdWxlIG91dA0KPiANCj4gIGFyY2gvYXJtNjQvaW5jbHVkZS9h
c20va3ZtX2hvc3QuaCAgICAgfCAgMTAgKy0NCj4gIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20va3Zt
X21tdS5oICAgICAgfCAgIDQgKy0NCj4gIGFyY2gvYXJtNjQva2VybmVsL2ltYWdlLXZhcnMuaCAg
ICAgICAgfCAgIDMgKw0KPiAgYXJjaC9hcm02NC9rdm0vTWFrZWZpbGUgICAgICAgICAgICAgICB8
ICAgMiArLQ0KPiAgYXJjaC9hcm02NC9rdm0vYXJtLmMgICAgICAgICAgICAgICAgICB8IDEwNiAr
KystLS0tLS0tLS0tLQ0KPiAgYXJjaC9hcm02NC9rdm0vaHlwL252aGUvbWVtX3Byb3RlY3QuYyB8
ICAgMyArLQ0KPiAgYXJjaC9hcm02NC9rdm0vbW11LmMgICAgICAgICAgICAgICAgICB8ICAgMSAt
DQo+ICBhcmNoL2FybTY0L2t2bS92bWlkLmMgICAgICAgICAgICAgICAgIHwgMTk2DQo+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ICA4IGZpbGVzIGNoYW5nZWQsIDIyOCBpbnNlcnRpb25z
KCspLCA5NyBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBhcmNoL2FybTY0L2t2
bS92bWlkLmMNCj4gDQo+IC0tDQo+IDIuMTcuMQ0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCg==
