Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EEE4DA792
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 02:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353020AbiCPBwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 21:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245082AbiCPBwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 21:52:01 -0400
Received: from spam.unicloud.com (smgmail.unic2.com.cn [220.194.70.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F1A5E171
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 18:50:46 -0700 (PDT)
Received: from eage.unicloud.com ([220.194.70.35])
        by spam.unicloud.com with ESMTP id 22G1ePw8004720;
        Wed, 16 Mar 2022 09:40:25 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from zgys-ex-mb09.Unicloud.com (10.10.0.24) by
 zgys-ex-mb09.Unicloud.com (10.10.0.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.17; Wed, 16 Mar 2022 09:40:24 +0800
Received: from zgys-ex-mb09.Unicloud.com ([fe80::eda0:6815:ca71:5aa]) by
 zgys-ex-mb09.Unicloud.com ([fe80::eda0:6815:ca71:5aa%16]) with mapi id
 15.01.2375.017; Wed, 16 Mar 2022 09:40:24 +0800
From:   =?gb2312?B?wt63yQ==?= <luofei@unicloud.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBodWdldGxiZnM6IGZpeCBkZXNjcmlwdGlvbiBhYm91?=
 =?gb2312?B?dCBhdG9taWMgYWxsb2NhdGlvbiBvZiB2bWVtbWFwIHBhZ2VzIHdoZW4gZnJl?=
 =?gb2312?Q?e_huge_page?=
Thread-Topic: [PATCH] hugetlbfs: fix description about atomic allocation of
 vmemmap pages when free huge page
Thread-Index: AQHYOCSEJQtF7F2NS0Ol60FQZC1p/Ky/6v2AgAFPXvg=
Date:   Wed, 16 Mar 2022 01:40:24 +0000
Message-ID: <aa500c4fb8e641e38b888325b2798989@unicloud.com>
References: <20220315042355.362810-1-luofei@unicloud.com>,<CAMZfGtWjnhZLVmRD0BSpMbAWr_vD5BCj5s0ARfNHpHeAAGWYjA@mail.gmail.com>
In-Reply-To: <CAMZfGtWjnhZLVmRD0BSpMbAWr_vD5BCj5s0ARfNHpHeAAGWYjA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.1.7]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: spam.unicloud.com 22G1ePw8004720
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gTm8gbWF0dGVyIHdoYXQgY29udGV4dCB1cGRhdGVfYW5kX2ZyZWVfcGFnZSgpIGlzIGNhbGxl
ZCBpbiwNCj4+IHRoZSBmbGFnIGZvciBhbGxvY2F0aW5nIHRoZSB2bWVtbWFwIHBhZ2UgaXMgZml4
ZWQNCj4+IChHRlBfS0VSTkVMIHwgX19HRlBfTk9SRVRSWSB8IF9fR0ZQX1RISVNOT0RFKSwgYW5k
IG5vIGF0b21pYw0KPj4gYWxsb2NhdGlvbiBpcyBpbnZvbHZlZCwgc28gdGhlIGRlc2NyaXB0aW9u
IG9mIGF0b21pY2l0eSBoZXJlDQo+PiBpcyBzb21ld2hhdCBpbmFwcHJvcHJpYXRlLg0KPj4NCj4+
IGFuZCB0aGUgYXRvbWljIHBhcmFtZXRlciBuYW1pbmcgb2YgdXBkYXRlX2FuZF9mcmVlX3BhZ2Uo
KSBpcw0KPj4gc29tZXdoYXQgbWlzbGVhZGluZy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBsdW9m
ZWkgPGx1b2ZlaUB1bmljbG91ZC5jb20+DQo+PiAtLS0NCj4+ICBtbS9odWdldGxiLmMgfCAxMCAr
KysrLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvbW0vaHVnZXRsYi5jIGIvbW0vaHVnZXRsYi5jDQo+
PiBpbmRleCBmOGNhN2NjYTNjMWEuLjIzOWVmODJiNzg5NyAxMDA2NDQNCj4+IC0tLSBhL21tL2h1
Z2V0bGIuYw0KPj4gKysrIGIvbW0vaHVnZXRsYi5jDQo+PiBAQCAtMTU3MCw4ICsxNTcwLDggQEAg
c3RhdGljIHZvaWQgX191cGRhdGVfYW5kX2ZyZWVfcGFnZShzdHJ1Y3QgaHN0YXRlICpoLCBzdHJ1
Y3QgcGFnZSAqcGFnZSkNCj4+DQo+PiAgLyoNCj4+ICAgKiBBcyB1cGRhdGVfYW5kX2ZyZWVfcGFn
ZSgpIGNhbiBiZSBjYWxsZWQgdW5kZXIgYW55IGNvbnRleHQsIHNvIHdlIGNhbm5vdA0KPj4gLSAq
IHVzZSBHRlBfS0VSTkVMIHRvIGFsbG9jYXRlIHZtZW1tYXAgcGFnZXMuIEhvd2V2ZXIsIHdlIGNh
biBkZWZlciB0aGUNCj4+IC0gKiBhY3R1YWwgZnJlZWluZyBpbiBhIHdvcmtxdWV1ZSB0byBwcmV2
ZW50IGZyb20gdXNpbmcgR0ZQX0FUT01JQyB0byBhbGxvY2F0ZQ0KPj4gKyAqIHVzZSBHRlBfQVRP
TUlDIHRvIGFsbG9jYXRlIHZtZW1tYXAgcGFnZXMuIEhvd2V2ZXIsIHdlIGNhbiBkZWZlciB0aGUN
Cj4+ICsgKiBhY3R1YWwgZnJlZWluZyBpbiBhIHdvcmtxdWV1ZSB0byBwcmV2ZW50IHdhaXRzIGNh
dXNlZCBieSBhbGxvY2F0aW5nDQo+PiAgICogdGhlIHZtZW1tYXAgcGFnZXMuDQo+PiAgICoNCj4+
ICAgKiBmcmVlX2hwYWdlX3dvcmtmbigpIGxvY2tsZXNzbHkgcmV0cmlldmVzIHRoZSBsaW5rZWQg
bGlzdCBvZiBwYWdlcyB0byBiZQ0KPj4gQEAgLTE2MTcsMTYgKzE2MTcsMTQgQEAgc3RhdGljIGlu
bGluZSB2b2lkIGZsdXNoX2ZyZWVfaHBhZ2Vfd29yayhzdHJ1Y3QgaHN0YXRlICpoKQ0KPj4gIH0N
Cj4+DQo+PiAgc3RhdGljIHZvaWQgdXBkYXRlX2FuZF9mcmVlX3BhZ2Uoc3RydWN0IGhzdGF0ZSAq
aCwgc3RydWN0IHBhZ2UgKnBhZ2UsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBib29sIGF0b21pYykNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wg
ZGVsYXkpDQo+DQo+SGkgbHVvZmVpLA0KPg0KPkF0IGxlYXN0LCBJIGRvbid0IGFncmVlIHdpdGgg
dGhpcyBjaGFuZ2UuICBUaGUgImF0b21pYyIgbWVhbnMgaWYgdGhlDQo+Y2FsbGVyIGlzIHVuZGVy
IGF0b21pYyBjb250ZXh0IGluc3RlYWQgb2Ygd2hldGhlciB1c2luZyBhdG9taWMNCj5HRlBfTUFT
Sy4gIFRoZSAiZGVsYXkiIHNlZW1zIHRvIHRlbGwgdGhlIGNhbGxlciB0aGF0IGl0IGNhbiB1bmRl
bGF5DQo+dGhlIGFsbG9jYXRpb24gZXZlbiBpZiBpdCBpcyB1bmRlciBhdG9taWMgY29udGV4dCAo
YWN0dWFsbHksIGl0IGhhcyBubw0KPmNob2ljZSkuICBCdXQgImF0b21pYyIgY2FuIGluZGljYXRl
IHRoZSB1c2VyIGlzIGJlaW5nIGFza2VkIHRvIHRlbGwgdXMNCj5pZiBpdCBpcyB1bmRlciBhdG9t
aWMgY29udGV4dC4NCg0KQmFzZWQgb24gdGhlIGNvbW1lbnRzIHJlbGF0ZWQgdG8gYXZvaWRpbmcg
YXRvbWljIGFsbG9jYXRpb24gcGFnZXMsDQpJIHdvdWxkIGhhdmUgdGhvdWdodCB0aGF0IGF0b21p
YyB2YXJpYWJsZSBoYWQgc29tZXRoaW5nIHRvIGRvIHdpdGgNCnRoaXMsIGl0IHNlZW1zIEkgbWlz
dW5kZXJzdG9vZCB0aGUgbWVhbmluZyBvZiB0aGUgdmFyaWFibGUuDQoNClRoYW5rczopDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IE11Y2h1biBTb25n
IDxzb25nbXVjaHVuQGJ5dGVkYW5jZS5jb20+DQq3osvNyrG85DogMjAyMsTqM9TCMTXI1SAyMToy
OToyNw0KytW8/sjLOiDC3rfJDQqzrcvNOiBNaWtlIEtyYXZldHo7IEFuZHJldyBNb3J0b247IExp
bnV4IE1lbW9yeSBNYW5hZ2VtZW50IExpc3Q7IExLTUwNCtb3zOI6IFJlOiBbUEFUQ0hdIGh1Z2V0
bGJmczogZml4IGRlc2NyaXB0aW9uIGFib3V0IGF0b21pYyBhbGxvY2F0aW9uIG9mIHZtZW1tYXAg
cGFnZXMgd2hlbiBmcmVlIGh1Z2UgcGFnZQ0KDQpPbiBUdWUsIE1hciAxNSwgMjAyMiBhdCAxMjoy
NCBQTSBsdW9mZWkgPGx1b2ZlaUB1bmljbG91ZC5jb20+IHdyb3RlOg0KPg0KPiBObyBtYXR0ZXIg
d2hhdCBjb250ZXh0IHVwZGF0ZV9hbmRfZnJlZV9wYWdlKCkgaXMgY2FsbGVkIGluLA0KPiB0aGUg
ZmxhZyBmb3IgYWxsb2NhdGluZyB0aGUgdm1lbW1hcCBwYWdlIGlzIGZpeGVkDQo+IChHRlBfS0VS
TkVMIHwgX19HRlBfTk9SRVRSWSB8IF9fR0ZQX1RISVNOT0RFKSwgYW5kIG5vIGF0b21pYw0KPiBh
bGxvY2F0aW9uIGlzIGludm9sdmVkLCBzbyB0aGUgZGVzY3JpcHRpb24gb2YgYXRvbWljaXR5IGhl
cmUNCj4gaXMgc29tZXdoYXQgaW5hcHByb3ByaWF0ZS4NCj4NCj4gYW5kIHRoZSBhdG9taWMgcGFy
YW1ldGVyIG5hbWluZyBvZiB1cGRhdGVfYW5kX2ZyZWVfcGFnZSgpIGlzDQo+IHNvbWV3aGF0IG1p
c2xlYWRpbmcuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IGx1b2ZlaSA8bHVvZmVpQHVuaWNsb3VkLmNv
bT4NCj4gLS0tDQo+ICBtbS9odWdldGxiLmMgfCAxMCArKysrLS0tLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
bW0vaHVnZXRsYi5jIGIvbW0vaHVnZXRsYi5jDQo+IGluZGV4IGY4Y2E3Y2NhM2MxYS4uMjM5ZWY4
MmI3ODk3IDEwMDY0NA0KPiAtLS0gYS9tbS9odWdldGxiLmMNCj4gKysrIGIvbW0vaHVnZXRsYi5j
DQo+IEBAIC0xNTcwLDggKzE1NzAsOCBAQCBzdGF0aWMgdm9pZCBfX3VwZGF0ZV9hbmRfZnJlZV9w
YWdlKHN0cnVjdCBoc3RhdGUgKmgsIHN0cnVjdCBwYWdlICpwYWdlKQ0KPg0KPiAgLyoNCj4gICAq
IEFzIHVwZGF0ZV9hbmRfZnJlZV9wYWdlKCkgY2FuIGJlIGNhbGxlZCB1bmRlciBhbnkgY29udGV4
dCwgc28gd2UgY2Fubm90DQo+IC0gKiB1c2UgR0ZQX0tFUk5FTCB0byBhbGxvY2F0ZSB2bWVtbWFw
IHBhZ2VzLiBIb3dldmVyLCB3ZSBjYW4gZGVmZXIgdGhlDQo+IC0gKiBhY3R1YWwgZnJlZWluZyBp
biBhIHdvcmtxdWV1ZSB0byBwcmV2ZW50IGZyb20gdXNpbmcgR0ZQX0FUT01JQyB0byBhbGxvY2F0
ZQ0KPiArICogdXNlIEdGUF9BVE9NSUMgdG8gYWxsb2NhdGUgdm1lbW1hcCBwYWdlcy4gSG93ZXZl
ciwgd2UgY2FuIGRlZmVyIHRoZQ0KPiArICogYWN0dWFsIGZyZWVpbmcgaW4gYSB3b3JrcXVldWUg
dG8gcHJldmVudCB3YWl0cyBjYXVzZWQgYnkgYWxsb2NhdGluZw0KPiAgICogdGhlIHZtZW1tYXAg
cGFnZXMuDQo+ICAgKg0KPiAgICogZnJlZV9ocGFnZV93b3JrZm4oKSBsb2NrbGVzc2x5IHJldHJp
ZXZlcyB0aGUgbGlua2VkIGxpc3Qgb2YgcGFnZXMgdG8gYmUNCj4gQEAgLTE2MTcsMTYgKzE2MTcs
MTQgQEAgc3RhdGljIGlubGluZSB2b2lkIGZsdXNoX2ZyZWVfaHBhZ2Vfd29yayhzdHJ1Y3QgaHN0
YXRlICpoKQ0KPiAgfQ0KPg0KPiAgc3RhdGljIHZvaWQgdXBkYXRlX2FuZF9mcmVlX3BhZ2Uoc3Ry
dWN0IGhzdGF0ZSAqaCwgc3RydWN0IHBhZ2UgKnBhZ2UsDQo+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGJvb2wgYXRvbWljKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBib29sIGRlbGF5KQ0KDQpIaSBsdW9mZWksDQoNCkF0IGxlYXN0LCBJIGRvbid0IGFncmVl
IHdpdGggdGhpcyBjaGFuZ2UuICBUaGUgImF0b21pYyIgbWVhbnMgaWYgdGhlDQpjYWxsZXIgaXMg
dW5kZXIgYXRvbWljIGNvbnRleHQgaW5zdGVhZCBvZiB3aGV0aGVyIHVzaW5nIGF0b21pYw0KR0ZQ
X01BU0suICBUaGUgImRlbGF5IiBzZWVtcyB0byB0ZWxsIHRoZSBjYWxsZXIgdGhhdCBpdCBjYW4g
dW5kZWxheQ0KdGhlIGFsbG9jYXRpb24gZXZlbiBpZiBpdCBpcyB1bmRlciBhdG9taWMgY29udGV4
dCAoYWN0dWFsbHksIGl0IGhhcyBubw0KY2hvaWNlKS4gIEJ1dCAiYXRvbWljIiBjYW4gaW5kaWNh
dGUgdGhlIHVzZXIgaXMgYmVpbmcgYXNrZWQgdG8gdGVsbCB1cw0KaWYgaXQgaXMgdW5kZXIgYXRv
bWljIGNvbnRleHQuDQoNClRoYW5rcy4NCg==
