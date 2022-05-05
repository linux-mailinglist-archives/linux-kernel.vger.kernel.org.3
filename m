Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7B451B65B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbiEEDSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiEEDSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:18:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0DA434BE;
        Wed,  4 May 2022 20:14:43 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KtzLz6CNXzhYx9;
        Thu,  5 May 2022 11:14:19 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 11:14:41 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2375.024;
 Thu, 5 May 2022 11:14:41 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     zhenwei pi <pizhenwei@bytedance.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: PING: [PATCH v4 0/5] virtio-crypto: Improve performance
Thread-Topic: PING: [PATCH v4 0/5] virtio-crypto: Improve performance
Thread-Index: AQHYV8hyMXkGqKxZB02P/aEBjf+Trq0PG9WAgACQlMA=
Date:   Thu, 5 May 2022 03:14:40 +0000
Message-ID: <7f7ab8ae46174ed6b0888b5fbeb5849b@huawei.com>
References: <20220424104140.44841-1-pizhenwei@bytedance.com>
 <cc9eb4aa-2e40-490f-f5a0-beee3a57313b@bytedance.com>
In-Reply-To: <cc9eb4aa-2e40-490f-f5a0-beee3a57313b@bytedance.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogemhlbndlaSBwaSBbbWFp
bHRvOnBpemhlbndlaUBieXRlZGFuY2UuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDUsIDIw
MjIgMTA6MzUgQU0NCj4gVG86IEdvbmdsZWkgKEFyZWkpIDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNv
bT47IG1zdEByZWRoYXQuY29tOw0KPiBqYXNvd2FuZ0ByZWRoYXQuY29tDQo+IENjOiBoZXJiZXJ0
QGdvbmRvci5hcGFuYS5vcmcuYXU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1jcnlwdG9Admdl
ci5rZXJuZWwub3JnOw0KPiBoZWxlaS5zaWcxMUBieXRlZGFuY2UuY29tOyBkYXZlbUBkYXZlbWxv
ZnQubmV0DQo+IFN1YmplY3Q6IFBJTkc6IFtQQVRDSCB2NCAwLzVdIHZpcnRpby1jcnlwdG86IElt
cHJvdmUgcGVyZm9ybWFuY2UNCj4gDQo+IEhpLCBMZWkNCj4gDQo+IEphc29uIHJlcGxpZWQgaW4g
YW5vdGhlciBwYXRjaDoNCj4gU3RpbGwgaHVuZHJlZHMgb2YgbGluZXMgb2YgY2hhbmdlcywgSSdk
IGxlYXZlIHRoaXMgY2hhbmdlIHRvIG90aGVyIG1haW50YWluZXJzIHRvDQo+IGRlY2lkZS4NCj4g
DQo+IFF1aXRlIGZyYW5rbHksIHRoZSB2aXJ0aW8gY3J5cHRvIGRyaXZlciBjaGFuZ2VkIG9ubHkg
YSBmZXcgaW4gdGhlIHBhc3QsIGFuZCB0aGUNCj4gcGVyZm9ybWFuY2Ugb2YgY29udHJvbCBxdWV1
ZSBpcyBub3QgZ29vZCBlbm91Z2guIEkgYW0gaW4gZG91YnQgYWJvdXQgdGhhdCB0aGlzDQo+IGRy
aXZlciBpcyBub3QgdXNlZCB3aWRlbHkuIFNvIEknZCBsaWtlIHRvIHJld29yayBhIGxvdCwgaXQg
d291bGQgYmUgYmVzdCB0byBjb21wbGV0ZQ0KPiB0aGlzIHdvcmsgaW4gNS4xOCB3aW5kb3cuDQo+
IA0KPiBUaGlzIGdldHMgZGlmZmVyZW50IHBvaW50IHdpdGggSmFzb24uIEkgd291bGQgYXBwcmVj
aWF0ZSBpdCBpZiB5b3UgY291bGQgZ2l2ZSBtZQ0KPiBhbnkgaGludC4NCj4gDQoNClRoaXMgaXMg
YWxyZWFkeSBpbiBteSB0b2RvIGxpc3QuDQoNClJlZ2FyZHMsDQotR29uZ2xlaQ0KDQo+IE9uIDQv
MjQvMjIgMTg6NDEsIHpoZW53ZWkgcGkgd3JvdGU6DQo+ID4gSGksIExlaQ0KPiA+IEknZCBsaWtl
IHRvIG1vdmUgaGVscGVyIGFuZCBjYWxsYmFjayBmdW5jdGlvbnMoRWcsIHZpcnRjcnlwdG9fY2xl
YXJfcmVxdWVzdA0KPiA+ICAgYW5kIHZpcnRjcnlwdG9fY3RybHFfY2FsbGJhY2spIGZyb20geHhf
Y29yZS5jIHRvIHh4X2NvbW1vbi5jLCB0aGVuDQo+ID4gdGhlIHh4X2NvcmUuYyBzdXBwb3J0czoN
Cj4gPiAgICAtIHByb2JlL3JlbW92ZS9pcnEgYWZmaW5pdHkgc2V0aW5nIGZvciBhIHZpcnRpbyBk
ZXZpY2UNCj4gPiAgICAtIGJhc2ljIHZpcnRpbyByZWxhdGVkIG9wZXJhdGlvbnMNCj4gPg0KPiA+
IHh4X2NvbW1vbi5jIHN1cHBvcnRzOg0KPiA+ICAgIC0gY29tbW9uIGhlbHBlcnMvZnVuY3Rpb25z
IGZvciBhbGdvcw0KPiA+DQo+ID4gRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb24gYWJvdXQgdGhp
cz8NCj4gPg0KPiA+IHYzIC0+IHY0Og0KPiA+ICAgLSBEb24ndCBjcmVhdGUgbmV3IGZpbGUgdmly
dGlvX2NvbW1vbi5jLCB0aGUgbmV3IGZ1bmN0aW9ucyBhcmUgYWRkZWQNCj4gPiAgICAgaW50byB2
aXJ0aW9fY3J5cHRvX2NvcmUuYw0KPiA+ICAgLSBTcGxpdCB0aGUgZmlyc3QgcGF0Y2ggaW50byB0
d28gcGFydHM6DQo+ID4gICAgICAgMSwgY2hhbmdlIGNvZGUgc3R5bGUsDQo+ID4gICAgICAgMiwg
dXNlIHByaXZhdGUgYnVmZmVyIGluc3RlYWQgb2Ygc2hhcmVkIGJ1ZmZlcg0KPiA+ICAgLSBSZW1v
dmUgcmVsZXZhbnQgY2hhbmdlLg0KPiA+ICAgLSBPdGhlciBtaW5vciBjaGFuZ2VzLg0KPiA+DQo+
ID4gdjIgLT4gdjM6DQo+ID4gICAtIEphc29uIHN1Z2dlc3RlZCB0aGF0IHNwbGl0aW5nIHRoZSBm
aXJzdCBwYXRjaCBpbnRvIHR3byBwYXJ0Og0KPiA+ICAgICAgIDEsIHVzaW5nIHByaXZhdGUgYnVm
ZmVyDQo+ID4gICAgICAgMiwgcmVtb3ZlIHRoZSBidXN5IHBvbGxpbmcNCj4gPiAgICAgUmV3b3Jr
IGFzIEphc29uJ3Mgc3VnZ2VzdGlvbiwgdGhpcyBtYWtlcyB0aGUgc21hbGxlciBjaGFuZ2UgaW4N
Cj4gPiAgICAgZWFjaCBvbmUgYW5kIGNsZWFyLg0KPiA+DQo+ID4gdjEgLT4gdjI6DQo+ID4gICAt
IFVzZSBrZnJlZSBpbnN0ZWFkIG9mIGtmcmVlX3NlbnNpdGl2ZSBmb3IgaW5zZW5zaXRpdmUgYnVm
ZmVyLg0KPiA+ICAgLSBTZXZlcmFsIGNvZGluZyBzdHlsZSBmaXguDQo+ID4gICAtIFVzZSBtZW1v
cnkgZnJvbSBjdXJyZW50IG5vZGUsIGluc3RlYWQgb2YgbWVtb3J5IGNsb3NlIHRvIGRldmljZQ0K
PiA+ICAgLSBBZGQgbW9yZSBtZXNzYWdlIGluIGNvbW1pdCwgYWxzbyBleHBsYWluIHdoeSByZW1v
dmluZyBwZXItZGV2aWNlDQo+ID4gICAgIHJlcXVlc3QgYnVmZmVyLg0KPiA+ICAgLSBBZGQgbmVj
ZXNzYXJ5IGNvbW1lbnQgaW4gY29kZSB0byBleHBsYWluIHdoeSB1c2luZyBremFsbG9jIHRvDQo+
ID4gICAgIGFsbG9jYXRlIHN0cnVjdCB2aXJ0aW9fY3J5cHRvX2N0cmxfcmVxdWVzdC4NCj4gPg0K
PiA+IHYxOg0KPiA+IFRoZSBtYWluIHBvaW50IG9mIHRoaXMgc2VyaWVzIGlzIHRvIGltcHJvdmUg
dGhlIHBlcmZvcm1hbmNlIGZvciB2aXJ0aW8NCj4gPiBjcnlwdG86DQo+ID4gLSBVc2Ugd2FpdCBt
ZWNoYW5pc20gaW5zdGVhZCBvZiBidXN5IHBvbGxpbmcgZm9yIGN0cmwgcXVldWUsIHRoaXMNCj4g
PiAgICByZWR1Y2VzIENQVSBhbmQgbG9jayByYWNpbmcsIGl0J3MgcG9zc2lhYmxlIHRvIGNyZWF0
ZS9kZXN0cm95IHNlc3Npb24NCj4gPiAgICBwYXJhbGxlbGx5LCBRUFMgaW5jcmVhc2VzIGZyb20g
fjQwSy9zIHRvIH4yMDBLL3MuDQo+ID4gLSBFbmFibGUgcmV0cnkgb24gY3J5cHRvIGVuZ2luZSB0
byBpbXByb3ZlIHBlcmZvcm1hbmNlIGZvciBkYXRhIHF1ZXVlLA0KPiA+ICAgIHRoaXMgYWxsb3dz
IHRoZSBsYXJnZXIgZGVwdGggaW5zdGVhZCBvZiAxLg0KPiA+IC0gRml4IGRzdCBkYXRhIGxlbmd0
aCBpbiBha2NpcGhlciBzZXJ2aWNlLg0KPiA+IC0gT3RoZXIgc3R5bGUgZml4Lg0KPiA+DQo+ID4g
bGVpIGhlICgyKToNCj4gPiAgICB2aXJ0aW8tY3J5cHRvOiBhZGp1c3QgZHN0X2xlbiBhdCBvcHMg
Y2FsbGJhY2sNCj4gPiAgICB2aXJ0aW8tY3J5cHRvOiBlbmFibGUgcmV0cnkgZm9yIHZpcnRpby1j
cnlwdG8tZGV2DQo+ID4NCj4gPiB6aGVud2VpIHBpICgzKToNCj4gPiAgICB2aXJ0aW8tY3J5cHRv
OiBjaGFuZ2UgY29kZSBzdHlsZQ0KPiA+ICAgIHZpcnRpby1jcnlwdG86IHVzZSBwcml2YXRlIGJ1
ZmZlciBmb3IgY29udHJvbCByZXF1ZXN0DQo+ID4gICAgdmlydGlvLWNyeXB0bzogd2FpdCBjdHJs
IHF1ZXVlIGluc3RlYWQgb2YgYnVzeSBwb2xsaW5nDQo+ID4NCj4gPiAgIC4uLi92aXJ0aW8vdmly
dGlvX2NyeXB0b19ha2NpcGhlcl9hbGdzLmMgICAgICB8ICA4MyArKysrKystLS0tLQ0KPiA+ICAg
ZHJpdmVycy9jcnlwdG8vdmlydGlvL3ZpcnRpb19jcnlwdG9fY29tbW9uLmggIHwgIDIxICsrLQ0K
PiA+ICAgZHJpdmVycy9jcnlwdG8vdmlydGlvL3ZpcnRpb19jcnlwdG9fY29yZS5jICAgIHwgIDU1
ICsrKysrKy0NCj4gPiAgIC4uLi92aXJ0aW8vdmlydGlvX2NyeXB0b19za2NpcGhlcl9hbGdzLmMg
ICAgICB8IDE0MCArKysrKysrKy0tLS0tLS0tLS0NCj4gPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTgw
IGluc2VydGlvbnMoKyksIDExOSBkZWxldGlvbnMoLSkNCj4gPg0KPiANCj4gLS0NCj4gemhlbndl
aSBwaQ0K
