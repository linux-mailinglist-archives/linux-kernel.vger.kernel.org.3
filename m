Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BF84C8A62
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiCALNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiCALNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:13:47 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F3A4507F;
        Tue,  1 Mar 2022 03:13:05 -0800 (PST)
Received: from kwepemi100011.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K7F1H0NMkzBrN8;
        Tue,  1 Mar 2022 19:11:15 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi100011.china.huawei.com (7.221.188.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 19:13:03 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2308.021;
 Tue, 1 Mar 2022 19:13:03 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        kernel test robot <lkp@intel.com>
Subject: RE: PING: [PATCH v2 3/3] virtio-crypto: implement RSA algorithm
Thread-Topic: PING: [PATCH v2 3/3] virtio-crypto: implement RSA algorithm
Thread-Index: AQHYKJ72Dafkx1irs0SFhYtvGLK8G6yp1gYAgACR8nA=
Date:   Tue, 1 Mar 2022 11:13:02 +0000
Message-ID: <786ae1572eb643a5b7eeaf6f47bfc698@huawei.com>
References: <20220211084108.1254218-1-pizhenwei@bytedance.com>
 <20220211084108.1254218-4-pizhenwei@bytedance.com>
 <c9144b0d82e34566a960f210ddc32696@huawei.com>
 <8ef2f660-bd84-de70-1539-402c73795dfe@bytedance.com>
 <bc2bbc3b-8a34-2f09-41f5-60f1568a6bef@bytedance.com>
 <0c148ada-9f32-3272-8a89-591299ab098d@bytedance.com>
In-Reply-To: <0c148ada-9f32-3272-8a89-591299ab098d@bytedance.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogemhlbndlaSBwaSBbbWFp
bHRvOnBpemhlbndlaUBieXRlZGFuY2UuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAxLCAy
MDIyIDY6MjYgUE0NCj4gVG86IEdvbmdsZWkgKEFyZWkpIDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNv
bT4NCj4gQ2M6IGphc293YW5nQHJlZGhhdC5jb207IG1zdEByZWRoYXQuY29tOw0KPiB2aXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgbGludXgtY3J5cHRvQHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaGVsZWkuc2lnMTFAYnl0
ZWRhbmNlLmNvbTsNCj4gaGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1OyBrZXJuZWwgdGVzdCBy
b2JvdCA8bGtwQGludGVsLmNvbT4NCj4gU3ViamVjdDogUElORzogW1BBVENIIHYyIDMvM10gdmly
dGlvLWNyeXB0bzogaW1wbGVtZW50IFJTQSBhbGdvcml0aG0NCj4gDQo+IFBJTkchDQo+IA0KPiBI
aSwgTGVpDQo+IEkgYWxzbyB0YWtlIGEgbG9vayBhdCBvdGhlciBjcnlwdG8gZHJpdmVycyBxYXQv
Y2NwL2hpc2lsaWNvbiwgdGhleSBzZXBhcmF0ZQ0KPiBha2NpcGhlci9za2NpcGhlciBhbGdvLiBJ
ZiB5b3UgY29uc2lkZXIgdGhhdCByZXVzaW5nDQo+IHZpcnRpb19jcnlwdG9fYWxnc19yZWdpc3Rl
ci91bnJlZ2lzdGVyIHNlZW1zIGJldHRlciwgSSB3aWxsIHRyeSB0byBtZXJnZSB0aGVtDQo+IGlu
dG8gYSBzaW5nbGUgZnVuY3Rpb24uDQo+IA0KDQpJJ20gZmluZSB3aXRoIHNlcGFyYXRpbmcgdGhl
bSBpbiBkaWZmZXJlbnQgYyBmaWxlcy4gVGhlbiBzaG91bGQgd2UgcmVuYW1lIHZpcnRpb19jcnlw
dG9fYWxncy5jDQp0byB2aXJ0aW9fY3J5cHRvX3NrY2lwaGVyX2FsZ28uYz8NCg0KDQpSZWdhcmRz
LA0KLUdvbmdsZWkNCg0KPiBPbiAyLzIzLzIyIDY6MTcgUE0sIHpoZW53ZWkgcGkgd3JvdGU6DQo+
ID4NCj4gPiBPbiAyLzE4LzIyIDExOjEyIEFNLCB6aGVud2VpIHBpIHdyb3RlOg0KPiA+Pj4+ICt2
b2lkIHZpcnRpb19jcnlwdG9fYWtjaXBoZXJfYWxnc191bnJlZ2lzdGVyKHN0cnVjdCB2aXJ0aW9f
Y3J5cHRvDQo+ID4+Pj4gKyp2Y3J5cHRvKSB7DQo+ID4+Pj4gK8KgwqDCoCBpbnQgaSA9IDA7DQo+
ID4+Pj4gKw0KPiA+Pj4+ICvCoMKgwqAgbXV0ZXhfbG9jaygmYWxnc19sb2NrKTsNCj4gPj4+PiAr
DQo+ID4+Pj4gK8KgwqDCoCBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRSh2aXJ0aW9fY3J5cHRv
X2FrY2lwaGVyX2FsZ3MpOyBpKyspDQo+ID4+Pj4gK3sNCj4gPj4+PiArwqDCoMKgwqDCoMKgwqAg
dWludDMyX3Qgc2VydmljZSA9IHZpcnRpb19jcnlwdG9fYWtjaXBoZXJfYWxnc1tpXS5zZXJ2aWNl
Ow0KPiA+Pj4+ICvCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBhbGdvbnVtID0gdmlydGlvX2NyeXB0
b19ha2NpcGhlcl9hbGdzW2ldLmFsZ29udW07DQo+ID4+Pj4gKw0KPiA+Pj4+ICvCoMKgwqDCoMKg
wqDCoCBpZiAodmlydGlvX2NyeXB0b19ha2NpcGhlcl9hbGdzW2ldLmFjdGl2ZV9kZXZzID09IDAg
fHwNCj4gPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAhdmlydGNyeXB0b19hbGdvX2lzX3N1
cHBvcnRlZCh2Y3J5cHRvLCBzZXJ2aWNlLA0KPiA+Pj4+ICthbGdvbnVtKSkNCj4gPj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsNCj4gPj4+PiArDQo+ID4+Pj4gK8KgwqDCoMKg
wqDCoMKgIGlmICh2aXJ0aW9fY3J5cHRvX2FrY2lwaGVyX2FsZ3NbaV0uYWN0aXZlX2RldnMgPT0g
MSkNCj4gPj4+PiArDQo+ID4+Pj4NCj4gPj4+PiBjcnlwdG9fdW5yZWdpc3Rlcl9ha2NpcGhlcigm
dmlydGlvX2NyeXB0b19ha2NpcGhlcl9hbGdzW2ldLmFsZ28pOw0KPiA+Pj4+ICsNCj4gPj4+PiAr
wqDCoMKgwqDCoMKgwqAgdmlydGlvX2NyeXB0b19ha2NpcGhlcl9hbGdzW2ldLmFjdGl2ZV9kZXZz
LS07DQo+ID4+Pj4gK8KgwqDCoCB9DQo+ID4+Pj4gKw0KPiA+Pj4+ICvCoMKgwqAgbXV0ZXhfdW5s
b2NrKCZhbGdzX2xvY2spOw0KPiA+Pj4+ICt9DQo+ID4+Pg0KPiA+Pj4gV2h5IGRvbid0IHlvdSBy
ZXVzZSB0aGUgdmlydGlvX2NyeXB0b19hbGdzX3JlZ2lzdGVyL3VucmVnaXN0ZXINCj4gPj4+IGZ1
bmN0aW9ucz8NCj4gPj4+IFRoZSBjdXJyZW50IGNvZGUgaXMgdG9vIHJlcGV0aXRpdmUuIE1heWJl
IHdlIGRvbid0IG5lZWQgY3JlYXRlIHRoZQ0KPiA+Pj4gbmV3IGZpbGUgdmlydGlvX2NyeXB0b19h
a2NpcGhlcl9hbGdvLmMgYmVjYXVzZSB3ZSBoYWQNCj4gPj4+IHZpcnRpb19jcnlwdG9fYWxncy5j
IHdoaWNoIGluY2x1ZGVzIGFsbCBhbGdvcml0aG1zLg0KPiA+Pj4NCj4gPj4NCj4gPj4gWWVzLCB0
aGlzIGxvb2tzIHNpbWlsYXIgdG8gdmlydGlvX2NyeXB0b19hbGdzX3JlZ2lzdGVyL3VucmVnaXN0
ZXIuDQo+ID4+DQo+ID4+IExldCdzIGxvb2sgYXQgdGhlIGRpZmZlcmVuY2U6DQo+ID4+IHN0cnVj
dCB2aXJ0aW9fY3J5cHRvX2FrY2lwaGVyX2FsZ28gew0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgIHVp
bnQzMl90IGFsZ29udW07DQo+ID4+IMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3Qgc2VydmljZTsN
Cj4gPj4gwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnQgYWN0aXZlX2RldnM7DQo+ID4+IMKg
wqDCoMKgwqDCoMKgwqAgc3RydWN0IGFrY2lwaGVyX2FsZyBhbGdvOw0KPiA+PiB9Ow0KPiA+Pg0K
PiA+PiBzdHJ1Y3QgdmlydGlvX2NyeXB0b19hbGdvIHsNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoCB1
aW50MzJfdCBhbGdvbnVtOw0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IHNlcnZpY2U7
DQo+ID4+IMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IGFjdGl2ZV9kZXZzOw0KPiA+PiDC
oMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBza2NpcGhlcl9hbGcgYWxnbzsgLyogYWtjaXBoZXJfYWxn
IFZTIHNrY2lwaGVyX2FsZyAqLw0KPiA+PiB9Ow0KPiA+Pg0KPiA+PiBJZiByZXVzaW5nIHZpcnRp
b19jcnlwdG9fYWxnc19yZWdpc3Rlci91bnJlZ2lzdGVyLCB3ZSBuZWVkIHRvIG1vZGlmeQ0KPiA+
PiB0aGUgZGF0YSBzdHJ1Y3R1cmUgbGlrZSB0aGlzOg0KPiA+PiBzdHJ1Y3QgdmlydGlvX2NyeXB0
b19ha2NpcGhlcl9hbGdvIHsNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBhbGdvbnVt
Ow0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IHNlcnZpY2U7wqDCoMKgIC8qIHVzZSBz
ZXJ2aWNlIHRvIGRpc3Rpbmd1aXNoDQo+ID4+IGFrY2lwaGVyL3NrY2lwaGVyICovDQo+ID4+IMKg
wqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IGFjdGl2ZV9kZXZzOw0KPiA+PiDCoMKgwqDCoMKg
dW5pb24gew0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBza2NpcGhlcl9hbGcgc2tjaXBo
ZXI7DQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYWtjaXBoZXJfYWxnIGFr
Y2lwaGVyOw0KPiA+PiDCoMKgwqDCoMKgfSBhbGc7DQo+ID4+IH07DQo+ID4+DQo+ID4+IGludCB2
aXJ0aW9fY3J5cHRvX2FrY2lwaGVyX2FsZ3NfcmVnaXN0ZXIoc3RydWN0IHZpcnRpb19jcnlwdG8N
Cj4gPj4gKnZjcnlwdG8pIHsNCj4gPj4gwqDCoMKgwqDCoC4uLg0KPiA+PiDCoMKgwqDCoMKgwqDC
oMKgIGZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHZpcnRpb19jcnlwdG9fYWtjaXBoZXJfYWxn
cyk7DQo+ID4+IGkrKykgew0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1
aW50MzJfdCBzZXJ2aWNlID0NCj4gPj4gdmlydGlvX2NyeXB0b19ha2NpcGhlcl9hbGdzW2ldLnNl
cnZpY2U7DQo+ID4+IMKgwqDCoMKgwqDCoMKgwqAgLi4uDQo+ID4+IMKgwqDCoMKgwqDCoMKgwqAg
LyogdGVzdCBzZXJ2aWNlIHR5cGUgdGhlbiBjYWxsDQo+ID4+IGNyeXB0b19yZWdpc3Rlcl9ha2Np
cGhlci9jcnlwdG9fcmVnaXN0ZXJfc2tjaXBoZXIgKi8NCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgKHNlcnZpY2UgPT0gVklSVElPX0NSWVBUT19TRVJWSUNFX0FLQ0lQ
SEVSKQ0KPiA+PiBjcnlwdG9fcmVnaXN0ZXJfYWtjaXBoZXIoJnZpcnRpb19jcnlwdG9fYWtjaXBo
ZXJfYWxnc1tpXS5hbGdvLmFrY2lwaGUNCj4gPj4gcik7DQo+ID4+IMKgwqDCoMKgwqDCoMKgwqAg
ZWxzZQ0KPiA+PiBjcnlwdG9fcmVnaXN0ZXJfc2tjaXBoZXIoJnZpcnRpb19jcnlwdG9fc2tjaXBo
ZXJfYWxnc1tpXS5hbGdvLnNrY2lwaGUNCj4gPj4gcik7DQo+ID4+IMKgwqDCoMKgwqDCoMKgwqAg
Li4uDQo+ID4+IMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiA+PiDCoMKgwqDCoMKgLi4uDQo+ID4+IH0N
Cj4gPj4NCj4gPj4gQWxzbyB0ZXN0IHNlcnZpY2UgdHlwZSBhbmQgY2FsbA0KPiA+PiBjcnlwdG9f
dW5yZWdpc3Rlcl9za2NpcGhlci9jcnlwdG9fdW5yZWdpc3Rlcl9ha2NpcGhlci4NCj4gPj4NCj4g
Pj4gVGhpcyBnZXRzIHVuY2xlYXIgZnJvbSBjdXJyZW50IHYyIHZlcnNpb24uDQo+ID4+DQo+ID4+
IE9uIHRoZSBvdGhlciBoYW5kLCB0aGUga2VybmVsIHNpZGUgcHJlZmVycyB0byBzZXBhcmF0ZSBz
a2NpcGhlciBhbmQNCj4gPj4gYWtjaXBoZXIoc2VwYXJhdGVkIGhlYWRlciBmaWxlcyBhbmQgaW1w
bGVtZW50YXRpb25zKS4NCj4gPj4NCj4gPg0KPiANCj4gLS0NCj4gemhlbndlaSBwaQ0K
