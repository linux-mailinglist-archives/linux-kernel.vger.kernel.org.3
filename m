Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2296A58002B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 15:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiGYNu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGYNu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:50:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E4A15736;
        Mon, 25 Jul 2022 06:50:55 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ls1cl5lxzz9srK;
        Mon, 25 Jul 2022 21:49:43 +0800 (CST)
Received: from dggpemm100004.china.huawei.com (7.185.36.189) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 21:50:41 +0800
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 dggpemm100004.china.huawei.com (7.185.36.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 21:50:40 +0800
Received: from lhrpeml500005.china.huawei.com ([7.191.163.240]) by
 lhrpeml500005.china.huawei.com ([7.191.163.240]) with mapi id 15.01.2375.024;
 Mon, 25 Jul 2022 14:50:38 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     renzhijie <renzhijie2@huawei.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@linaro.org" <lorenzo.pieralisi@linaro.org>
Subject: RE: [PATCH -next] ACPI/IORT: Fix build error
 implicit-function-declaration
Thread-Topic: [PATCH -next] ACPI/IORT: Fix build error
 implicit-function-declaration
Thread-Index: AQHYn1Rr2yHs18MWJkqHuPxOsvvnNK2PFx/Q
Date:   Mon, 25 Jul 2022 13:50:38 +0000
Message-ID: <d59bc043788e4dc796a445588d667ab7@huawei.com>
References: <20220724115423.212932-1-renzhijie2@huawei.com>
In-Reply-To: <20220724115423.212932-1-renzhijie2@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.169.170]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcmVuemhpamllDQo+IFNl
bnQ6IDI0IEp1bHkgMjAyMiAxMjo1NA0KPiBUbzogbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBHdW9o
YW5qdW4gKEhhbmp1biBHdW8pDQo+IDxndW9oYW5qdW5AaHVhd2VpLmNvbT47IHN1ZGVlcC5ob2xs
YUBhcm0uY29tOyByYWZhZWxAa2VybmVsLm9yZzsNCj4gbGVuYkBrZXJuZWwub3JnOyBTaGFtZWVy
YWxpIEtvbG90aHVtIFRob2RpDQo+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5j
b20+OyBqcm9lZGVsQHN1c2UuZGU7DQo+IHJvYmluLm11cnBoeUBhcm0uY29tDQo+IENjOiBsaW51
eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyByZW56aGlqaWUgPHJlbnpoaWpp
ZTJAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIC1uZXh0XSBBQ1BJL0lPUlQ6IEZpeCBi
dWlsZCBlcnJvcg0KPiBpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbg0KPiANCj4gSWYgQ09O
RklHX0FDUElfSU9SVD15IGFuZCBDT05GSUdfSU9NTVVfQVBJIGlzIG5vdCBzZXQsDQo+IG1ha2Ug
QVJDSD1hcm02NCBDUk9TU19DT01QSUxFPWFhcmNoNjQtbGludXgtZ251LSwgd2lsbCBiZSBmYWls
ZWQsIGxpa2UNCj4gdGhpczoNCj4gDQo+IGRyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmM6IEluIGZ1
bmN0aW9uIOKAmGlvcnRfZ2V0X3Jtcl9zaWRz4oCZOg0KPiBkcml2ZXJzL2FjcGkvYXJtNjQvaW9y
dC5jOjE0MDY6MjogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uDQo+IOKA
mGlvcnRfaW9tbXVfcm1yX2dldF9yZXN2X3JlZ2lvbnPigJk7IGRpZCB5b3UgbWVhbg0KPiDigJhp
b3J0X2lvbW11X2dldF9yZXN2X3JlZ2lvbnPigJk/IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9u
LWRlY2xhcmF0aW9uXQ0KPiAgIGlvcnRfaW9tbXVfcm1yX2dldF9yZXN2X3JlZ2lvbnMoaW9tbXVf
Zndub2RlLCBOVUxMLCBoZWFkKTsNCj4gICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
DQo+ICAgaW9ydF9pb21tdV9nZXRfcmVzdl9yZWdpb25zDQo+IGNjMTogc29tZSB3YXJuaW5ncyBi
ZWluZyB0cmVhdGVkIGFzIGVycm9ycw0KPiBtYWtlWzNdOiAqKiogW2RyaXZlcnMvYWNwaS9hcm02
NC9pb3J0Lm9dIEVycm9yIDENCg0KVGhhbmtzIGZvciBzcG90dGluZyB0aGlzLg0KDQo+IFRoZSBm
dW5jdGlvbiBpb3J0X2lvbW11X3Jtcl9nZXRfcmVzdl9yZWdpb25zKCkgaXMgZGVjbGFyZWQgYXQg
I2lmZGVmDQo+IENPTkZJR19JT01NVV9BUEkgYXJlYSwgYW5kIHRoZSBjYWxsZXJzIG9mICBpb3J0
X2dldF9ybXJfc2lkcygpIGFuZA0KPiBpb3J0X3B1dF9ybXJfc2lkcygpIHdvdWxkIHNlbGVjdCBJ
T01NVV9BUEkuDQo+IFRvIGZpeCB0aGlzIGVycm9yLCBtb3ZlIHRoZSBkZWZpbml0aW9ucyB0byAj
aWZkZWYgQ09ORklHX0lPTU1VX0FQSSBhcmVhLg0KDQpUaGF0IG1ha2VzIHNlbnNlLiBBbmQgdGhl
IG9ubHkgY2FsbGVycyBvZiB0aGVzZSBhcmUgU01NVSBkcml2ZXJzIEkgdGhpbmsgd2UNCmRvbid0
IG5lZWQgc3R1YiBmdW5jdGlvbnMgdW5kZXIgIUNPTkZJR19JT01NVV9BUEkoTG9yZW56bywgY291
bGQgeW91DQpwbGVhc2UgZG91YmxlIGNoZWNrIHRoaXMpLiANCg0KTml0OiBQbGVhc2Ugd3JhcCB0
aGUgY29tbWl0IGRlc2NyaXB0aW9uIHRvIGEgbWF4IG9mIDc1IGNoYXJzIHBlciBsaW5lLg0KDQpU
aGFua3MuDQpTaGFtZWVyDQoNCj4gDQo+IEZpeGVzOiBlMzAyZWVhOGY0OTcgKCJBQ1BJL0lPUlQ6
IEFkZCBhIGhlbHBlciB0byByZXRyaWV2ZSBSTVIgaW5mbw0KPiBkaXJlY3RseSIpDQo+IFNpZ25l
ZC1vZmYtYnk6IFJlbiBaaGlqaWUgPHJlbnpoaWppZTJAaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2FjcGkvYXJtNjQvaW9ydC5jIHwgNTYgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMjggZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYyBi
L2RyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMNCj4gaW5kZXggY2QxMzQ5ZDM1NDRlLi5jYTJhZWQ4
NmI1NDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMNCj4gKysrIGIv
ZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYw0KPiBAQCAtMTE2Miw2ICsxMTYyLDM0IEBAIHZvaWQg
aW9ydF9pb21tdV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UNCj4gKmRldiwgc3RydWN0
IGxpc3RfaGVhZCAqaGVhZCkNCj4gIAlpb3J0X2lvbW11X3Jtcl9nZXRfcmVzdl9yZWdpb25zKGZ3
c3BlYy0+aW9tbXVfZndub2RlLCBkZXYsDQo+IGhlYWQpOw0KPiAgfQ0KPiANCj4gKy8qKg0KPiAr
ICogaW9ydF9nZXRfcm1yX3NpZHMgLSBSZXRyaWV2ZSBJT1JUIFJNUiBub2RlIHJlc2VydmVkIHJl
Z2lvbnMgd2l0aA0KPiArICogICAgICAgICAgICAgICAgICAgICBhc3NvY2lhdGVkIFN0cmVhbUlE
cyBpbmZvcm1hdGlvbi4NCj4gKyAqIEBpb21tdV9md25vZGU6IGZ3bm9kZSBhc3NvY2lhdGVkIHdp
dGggSU9NTVUNCj4gKyAqIEBoZWFkOiBSZXNlcmV2ZWQgcmVnaW9uIGxpc3QNCj4gKyAqLw0KPiAr
dm9pZCBpb3J0X2dldF9ybXJfc2lkcyhzdHJ1Y3QgZndub2RlX2hhbmRsZSAqaW9tbXVfZndub2Rl
LA0KPiArCQkgICAgICAgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkNCj4gK3sNCj4gKwlpb3J0X2lv
bW11X3Jtcl9nZXRfcmVzdl9yZWdpb25zKGlvbW11X2Z3bm9kZSwgTlVMTCwgaGVhZCk7DQo+ICt9
DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChpb3J0X2dldF9ybXJfc2lkcyk7DQo+ICsNCj4gKy8qKg0K
PiArICogaW9ydF9wdXRfcm1yX3NpZHMgLSBGcmVlIG1lbW9yeSBhbGxvY2F0ZWQgZm9yIFJNUiBy
ZXNlcnZlZCByZWdpb25zLg0KPiArICogQGlvbW11X2Z3bm9kZTogZndub2RlIGFzc29jaWF0ZWQg
d2l0aCBJT01NVQ0KPiArICogQGhlYWQ6IFJlc2VyZXZlZCByZWdpb24gbGlzdA0KPiArICovDQo+
ICt2b2lkIGlvcnRfcHV0X3Jtcl9zaWRzKHN0cnVjdCBmd25vZGVfaGFuZGxlICppb21tdV9md25v
ZGUsDQo+ICsJCSAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQ0KPiArew0KPiArCXN0cnVj
dCBpb21tdV9yZXN2X3JlZ2lvbiAqZW50cnksICpuZXh0Ow0KPiArDQo+ICsJbGlzdF9mb3JfZWFj
aF9lbnRyeV9zYWZlKGVudHJ5LCBuZXh0LCBoZWFkLCBsaXN0KQ0KPiArCQllbnRyeS0+ZnJlZShO
VUxMLCBlbnRyeSk7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChpb3J0X3B1dF9ybXJfc2lk
cyk7DQo+ICsNCj4gIHN0YXRpYyBpbmxpbmUgYm9vbCBpb3J0X2lvbW11X2RyaXZlcl9lbmFibGVk
KHU4IHR5cGUpDQo+ICB7DQo+ICAJc3dpdGNoICh0eXBlKSB7DQo+IEBAIC0xMzk0LDM0ICsxNDIy
LDYgQEAgaW50IGlvcnRfZG1hX2dldF9yYW5nZXMoc3RydWN0IGRldmljZSAqZGV2LCB1NjQNCj4g
KnNpemUpDQo+ICAJCXJldHVybiBuY19kbWFfZ2V0X3JhbmdlKGRldiwgc2l6ZSk7DQo+ICB9DQo+
IA0KPiAtLyoqDQo+IC0gKiBpb3J0X2dldF9ybXJfc2lkcyAtIFJldHJpZXZlIElPUlQgUk1SIG5v
ZGUgcmVzZXJ2ZWQgcmVnaW9ucyB3aXRoDQo+IC0gKiAgICAgICAgICAgICAgICAgICAgIGFzc29j
aWF0ZWQgU3RyZWFtSURzIGluZm9ybWF0aW9uLg0KPiAtICogQGlvbW11X2Z3bm9kZTogZndub2Rl
IGFzc29jaWF0ZWQgd2l0aCBJT01NVQ0KPiAtICogQGhlYWQ6IFJlc2VyZXZlZCByZWdpb24gbGlz
dA0KPiAtICovDQo+IC12b2lkIGlvcnRfZ2V0X3Jtcl9zaWRzKHN0cnVjdCBmd25vZGVfaGFuZGxl
ICppb21tdV9md25vZGUsDQo+IC0JCSAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQ0KPiAt
ew0KPiAtCWlvcnRfaW9tbXVfcm1yX2dldF9yZXN2X3JlZ2lvbnMoaW9tbXVfZndub2RlLCBOVUxM
LCBoZWFkKTsNCj4gLX0NCj4gLUVYUE9SVF9TWU1CT0xfR1BMKGlvcnRfZ2V0X3Jtcl9zaWRzKTsN
Cj4gLQ0KPiAtLyoqDQo+IC0gKiBpb3J0X3B1dF9ybXJfc2lkcyAtIEZyZWUgbWVtb3J5IGFsbG9j
YXRlZCBmb3IgUk1SIHJlc2VydmVkIHJlZ2lvbnMuDQo+IC0gKiBAaW9tbXVfZndub2RlOiBmd25v
ZGUgYXNzb2NpYXRlZCB3aXRoIElPTU1VDQo+IC0gKiBAaGVhZDogUmVzZXJldmVkIHJlZ2lvbiBs
aXN0DQo+IC0gKi8NCj4gLXZvaWQgaW9ydF9wdXRfcm1yX3NpZHMoc3RydWN0IGZ3bm9kZV9oYW5k
bGUgKmlvbW11X2Z3bm9kZSwNCj4gLQkJICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpDQo+
IC17DQo+IC0Jc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uICplbnRyeSwgKm5leHQ7DQo+IC0NCj4g
LQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoZW50cnksIG5leHQsIGhlYWQsIGxpc3QpDQo+IC0J
CWVudHJ5LT5mcmVlKE5VTEwsIGVudHJ5KTsNCj4gLX0NCj4gLUVYUE9SVF9TWU1CT0xfR1BMKGlv
cnRfcHV0X3Jtcl9zaWRzKTsNCj4gLQ0KPiAgc3RhdGljIHZvaWQgX19pbml0IGFjcGlfaW9ydF9y
ZWdpc3Rlcl9pcnEoaW50IGh3aXJxLCBjb25zdCBjaGFyICpuYW1lLA0KPiAgCQkJCQkgIGludCB0
cmlnZ2VyLA0KPiAgCQkJCQkgIHN0cnVjdCByZXNvdXJjZSAqcmVzKQ0KPiAtLQ0KPiAyLjE3LjEN
Cg0K
