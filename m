Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1074B0958
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbiBJJVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:21:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbiBJJVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:21:15 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED5AEB4;
        Thu, 10 Feb 2022 01:21:15 -0800 (PST)
Received: from dggeme761-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JvWRK3nKBz9sZY;
        Thu, 10 Feb 2022 17:19:41 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggeme761-chm.china.huawei.com (10.3.19.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 10 Feb 2022 17:21:13 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2308.021;
 Thu, 10 Feb 2022 17:21:13 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
        "mst@redhat.com" <mst@redhat.com>
Subject: RE: RE: [PATCH 2/3] virtio-crypto: introduce akcipher service
Thread-Topic: RE: [PATCH 2/3] virtio-crypto: introduce akcipher service
Thread-Index: AQHYDm47poB50P1RmUal7n5E+2vGlKyMgQ2Q//+Jc4CAAJcu4A==
Date:   Thu, 10 Feb 2022 09:21:13 +0000
Message-ID: <34ba8701eb86414e826824892e2f0892@huawei.com>
References: <20220121022438.1042547-1-pizhenwei@bytedance.com>
 <20220121022438.1042547-3-pizhenwei@bytedance.com>
 <15e960491a684b649e5d0179a32848a2@huawei.com>
 <540f29e4-12ef-3786-bd54-9a94ba6ee7ab@bytedance.com>
In-Reply-To: <540f29e4-12ef-3786-bd54-9a94ba6ee7ab@bytedance.com>
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
bHRvOnBpemhlbndlaUBieXRlZGFuY2UuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkg
MTAsIDIwMjIgNDoxOCBQTQ0KPiBUbzogR29uZ2xlaSAoQXJlaSkgPGFyZWkuZ29uZ2xlaUBodWF3
ZWkuY29tPg0KPiBDYzogamFzb3dhbmdAcmVkaGF0LmNvbTsgdmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmc7DQo+IGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGhlbGVpLnNpZzExQGJ5dGVkYW5jZS5jb207
IG1zdEByZWRoYXQuY29tDQo+IFN1YmplY3Q6IFJlOiBSRTogW1BBVENIIDIvM10gdmlydGlvLWNy
eXB0bzogaW50cm9kdWNlIGFrY2lwaGVyIHNlcnZpY2UNCj4gDQo+ID4+ICAgLyogVGhlIGFjY2Vs
ZXJhdG9yIGhhcmR3YXJlIGlzIHJlYWR5ICovICAjZGVmaW5lDQo+ID4+IFZJUlRJT19DUllQVE9f
U19IV19SRUFEWSAgKDEgPDwgMCkgQEAgLTQ0Miw2ICs1MjAsNyBAQCBzdHJ1Y3QNCj4gPj4gdmly
dGlvX2NyeXB0b19jb25maWcgew0KPiA+PiAgIAlfX2xlMzIgcmVzZXJ2ZTsNCj4gPj4gICAJLyog
TWF4aW11bSBzaXplIG9mIGVhY2ggY3J5cHRvIHJlcXVlc3QncyBjb250ZW50ICovDQo+ID4+ICAg
CV9fbGU2NCBtYXhfc2l6ZTsNCj4gPj4gKwlfX2xlMzIgYWtjaXBoZXJfYWxnbzsNCj4gPj4gICB9
Ow0KPiA+Pg0KPiA+IFlvdSBjYW4gdXNlIHRoZSByZXNlcnZlIGF0dHJpYnV0ZS4gS2VlcGluZyA2
NC1iaXQgYWxpZ25lZC4NCj4gPg0KPiA+PiAgIHN0cnVjdCB2aXJ0aW9fY3J5cHRvX2luaGRyIHsN
Cj4gPj4gLS0NCj4gPj4gMi4yNS4xDQo+ID4NCj4gDQo+IENhbiBJIHVzZSB0aGUgIl9fbGUzMiBy
ZXNlcnZlOyIgZmllbGQgZGlyZWN0bHk/DQo+IA0KPiBzdHJ1Y3QgdmlydGlvX2NyeXB0b19jb25m
aWcgew0KPiAgICAgICAgICAvKiBTZWUgVklSVElPX0NSWVBUT19PUF8qIGFib3ZlICovDQo+ICAg
ICAgICAgIF9fbGUzMiAgc3RhdHVzOw0KPiANCj4gICAgICAgICAgLyoNCj4gICAgICAgICAgICog
TWF4aW11bSBudW1iZXIgb2YgZGF0YSBxdWV1ZQ0KPiAgICAgICAgICAgKi8NCj4gICAgICAgICAg
X19sZTMyICBtYXhfZGF0YXF1ZXVlczsNCj4gDQo+ICAgICAgICAgIC8qDQo+ICAgICAgICAgICAq
IFNwZWNpZmllcyB0aGUgc2VydmljZXMgbWFzayB3aGljaCB0aGUgZGV2aWNlIHN1cHBvcnQsDQo+
ICAgICAgICAgICAqIHNlZSBWSVJUSU9fQ1JZUFRPX1NFUlZJQ0VfKiBhYm92ZQ0KPiAgICAgICAg
ICAgKi8NCj4gICAgICAgICAgX19sZTMyIGNyeXB0b19zZXJ2aWNlczsNCj4gDQo+ICAgICAgICAg
IC8qIERldGFpbGVkIGFsZ29yaXRobXMgbWFzayAqLw0KPiAgICAgICAgICBfX2xlMzIgY2lwaGVy
X2FsZ29fbDsNCj4gICAgICAgICAgX19sZTMyIGNpcGhlcl9hbGdvX2g7DQo+ICAgICAgICAgIF9f
bGUzMiBoYXNoX2FsZ287DQo+ICAgICAgICAgIF9fbGUzMiBtYWNfYWxnb19sOw0KPiAgICAgICAg
ICBfX2xlMzIgbWFjX2FsZ29faDsNCj4gICAgICAgICAgX19sZTMyIGFlYWRfYWxnbzsNCj4gICAg
ICAgICAgLyogTWF4aW11bSBsZW5ndGggb2YgY2lwaGVyIGtleSAqLw0KPiAgICAgICAgICBfX2xl
MzIgbWF4X2NpcGhlcl9rZXlfbGVuOw0KPiAgICAgICAgICAvKiBNYXhpbXVtIGxlbmd0aCBvZiBh
dXRoZW50aWNhdGVkIGtleSAqLw0KPiAgICAgICAgICBfX2xlMzIgbWF4X2F1dGhfa2V5X2xlbjsN
Cj4gICAgICAgICAgX19sZTMyIHJlc2VydmU7ICAgICAgICAgICAgLS0+ICAgIF9fbGUzMiBha2Np
cGhlcl9hbGdvOw0KPiAgICAgICAgICAvKiBNYXhpbXVtIHNpemUgb2YgZWFjaCBjcnlwdG8gcmVx
dWVzdCdzIGNvbnRlbnQgKi8NCj4gICAgICAgICAgX19sZTY0IG1heF9zaXplOw0KPiB9Ow0KPiAN
Cg0KDQpZZXMsIEkgdGhpbmsgc28uIE90aGVyd2lzZSB5b3Ugd2lsbCBhZGQgb3RoZXIgcmVzZXJ2
ZWQgZmllbGQgOigNCg0KUmVnYXJkcywNCi1Hb25nbGVpDQo=
