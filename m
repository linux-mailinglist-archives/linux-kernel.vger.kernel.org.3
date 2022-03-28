Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEBD4E9060
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbiC1IqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiC1IqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:46:23 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA42551E56
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:44:42 -0700 (PDT)
Received: from IT-EXMB-1-123.meizu.com (172.16.1.123) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 28 Mar
 2022 16:44:42 +0800
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by
 IT-EXMB-1-123.meizu.com (172.16.1.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 28 Mar 2022 16:44:40 +0800
Received: from IT-EXMB-1-125.meizu.com ([fe80::7481:7d92:3801:4575]) by
 IT-EXMB-1-125.meizu.com ([fe80::7481:7d92:3801:4575%3]) with mapi id
 15.01.2308.014; Mon, 28 Mar 2022 16:44:39 +0800
From:   =?gb2312?B?sNe6xs7E?= <baihaowen@meizu.com>
To:     Martin Kaiser <martin@kaiser.cx>
CC:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "straube.linux@gmail.com" <straube.linux@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBzdGFnaW5nOiByODE4OGV1OiBEaXJlY3RseSByZXR1?=
 =?gb2312?Q?rn_instead_of_using_local_ret_variable?=
Thread-Topic: [PATCH] staging: r8188eu: Directly return instead of using local
 ret variable
Thread-Index: AQHYQkUCnpcvuYlTKkqXZsBNWXKzyazT60+AgACQGXU=
Date:   Mon, 28 Mar 2022 08:44:39 +0000
Message-ID: <8eaea3ece1ee4452b4eb90774fca1cf4@meizu.com>
References: <1648431715-21333-1-git-send-email-baihaowen@meizu.com>,<20220328080817.4r5n5z375hzqaxjf@viti.kaiser.cx>
In-Reply-To: <20220328080817.4r5n5z375hzqaxjf@viti.kaiser.cx>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.137.70]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IGZvciB5b3VyIHN1Z2dlc3Rpb24sIHJlc2VuZCBhZ2Fpbi4NCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogTWFydGluIEthaXNlciA8bWFy
dGluQHZpdGkua2Fpc2VyLmN4PiC0+rHtIE1hcnRpbiBLYWlzZXIgPG1hcnRpbkBrYWlzZXIuY3g+
DQq3osvNyrG85DogMjAyMsTqM9TCMjjI1SAxNjowODoxNw0KytW8/sjLOiCw17rGzsQNCrOty806
IExhcnJ5LkZpbmdlckBsd2Zpbmdlci5uZXQ7IHBoaWxAcGhpbHBvdHRlci5jby51azsgZ3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc7IHN0cmF1YmUubGludXhAZ21haWwuY29tOyBsaW51eC1zdGFn
aW5nQGxpc3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K1vfM4jog
UmU6IFtQQVRDSF0gc3RhZ2luZzogcjgxODhldTogRGlyZWN0bHkgcmV0dXJuIGluc3RlYWQgb2Yg
dXNpbmcgbG9jYWwgcmV0IHZhcmlhYmxlDQoNClRodXMgd3JvdGUgSGFvd2VuIEJhaSAoYmFpaGFv
d2VuQG1laXp1LmNvbSk6DQoNCj4gRnJvbTogsNe6xs7EIDxiYWloYW93ZW5AbWVpenUuY29tPg0K
DQo+IGZpeGVzIGNvY2NpbmVsbGUgd2FybmluZzoNCj4gLi9kcml2ZXJzL3N0YWdpbmcvcjgxODhl
dS9jb3JlL3J0d19tbG1lX2V4dC5jOjE1MTg6MTQtMTc6IFVubmVlZGVkIHZhcmlhYmxlOiAicmV0
Ii4NCj4gIFJldHVybiAiX0ZBSUwiIG9uIGxpbmUgMTU0OQ0KPiAuL2RyaXZlcnMvc3RhZ2luZy9y
ODE4OGV1L2NvcmUvcnR3X21sbWVfZXh0LmM6MzU3OjUtODogVW5uZWVkZWQgdmFyaWFibGU6ICJy
ZXMiLg0KPiAgUmV0dXJuICJfU1VDQ0VTUyIgb24gbGluZSAzODANCg0KVGhlc2UgYXJlIHR3byB1
bnJlbGF0ZWQgY2hhbmdlcy4gSSBndWVzcyB5b3Ugc2hvdWxkIHNwbGl0IHRoaXMgaW50byB0d28N
CnBhdGNoZXMuDQoNCj4gU2lnbmVkLW9mZi1ieTogsNe6xs7EIDxiYWloYW93ZW5AbWVpenUuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvc3RhZ2luZy9yODE4OGV1L2NvcmUvcnR3X21sbWVfZXh0LmMg
fCA2ICsrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvY29yZS9ydHdf
bWxtZV9leHQuYyBiL2RyaXZlcnMvc3RhZ2luZy9yODE4OGV1L2NvcmUvcnR3X21sbWVfZXh0LmMN
Cj4gaW5kZXggMTBkNWYxMi4uNGI3YjBlZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5n
L3I4MTg4ZXUvY29yZS9ydHdfbWxtZV9leHQuYw0KPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvcjgx
ODhldS9jb3JlL3J0d19tbG1lX2V4dC5jDQo+IEBAIC0zNTQsNyArMzU0LDYgQEAgc3RhdGljIHU4
IGluaXRfY2hhbm5lbF9zZXQoc3RydWN0IGFkYXB0ZXIgKnBhZGFwdGVyLCB1OCBDaGFubmVsUGxh
biwgc3RydWN0IHJ0X2MNCg0KPiAgaW50ICBpbml0X21sbWVfZXh0X3ByaXYoc3RydWN0IGFkYXB0
ZXIgKnBhZGFwdGVyKQ0KPiAgew0KPiAtICAgICBpbnQgICAgIHJlcyA9IF9TVUNDRVNTOw0KPiAg
ICAgICBzdHJ1Y3QgcmVnaXN0cnlfcHJpdiAqcHJlZ2lzdHJ5cHJpdiA9ICZwYWRhcHRlci0+cmVn
aXN0cnlwcml2Ow0KPiAgICAgICBzdHJ1Y3QgbWxtZV9leHRfcHJpdiAqcG1sbWVleHQgPSAmcGFk
YXB0ZXItPm1sbWVleHRwcml2Ow0KPiAgICAgICBzdHJ1Y3QgbWxtZV9wcml2ICpwbWxtZXByaXYg
PSAmcGFkYXB0ZXItPm1sbWVwcml2Ow0KPiBAQCAtMzc3LDcgKzM3Niw3IEBAIGludCAgICAgICBp
bml0X21sbWVfZXh0X3ByaXYoc3RydWN0IGFkYXB0ZXIgKnBhZGFwdGVyKQ0KDQo+ICAgICAgIHBt
bG1lZXh0LT5hY3RpdmVfa2VlcF9hbGl2ZV9jaGVjayA9IHRydWU7DQoNCj4gLSAgICAgcmV0dXJu
IHJlczsNCj4gKyAgICAgcmV0dXJuIF9TVUNDRVNTOw0KPiAgfQ0KDQpUaGUgY2FsbGVyIGRvZXMg
bm90IGNoZWNrIHRoZSByZXR1cm4gdmFsdWUuIFlvdSBzaG91bGQgY2hhbmdlIHRoZQ0KZnVuY3Rp
b24gdG8gdm9pZCBpbml0X21sbWVfZXh0X3ByaXYuLi4NCg0KPiAgdm9pZCBmcmVlX21sbWVfZXh0
X3ByaXYoc3RydWN0IG1sbWVfZXh0X3ByaXYgKnBtbG1lZXh0KQ0KPiBAQCAtMTUxNSw3ICsxNTE0
LDYgQEAgdW5zaWduZWQgaW50IE9uQXRpbShzdHJ1Y3QgYWRhcHRlciAqcGFkYXB0ZXIsIHN0cnVj
dCByZWN2X2ZyYW1lICpwcmVjdl9mcmFtZSkNCg0KPiAgdW5zaWduZWQgaW50IG9uX2FjdGlvbl9z
cGN0KHN0cnVjdCBhZGFwdGVyICpwYWRhcHRlciwgc3RydWN0IHJlY3ZfZnJhbWUgKnByZWN2X2Zy
YW1lKQ0KPiAgew0KPiAtICAgICB1bnNpZ25lZCBpbnQgcmV0ID0gX0ZBSUw7DQo+ICAgICAgIHN0
cnVjdCBzdGFfaW5mbyAqcHN0YSA9IE5VTEw7DQo+ICAgICAgIHN0cnVjdCBzdGFfcHJpdiAqcHN0
YXByaXYgPSAmcGFkYXB0ZXItPnN0YXByaXY7DQo+ICAgICAgIHU4ICpwZnJhbWUgPSBwcmVjdl9m
cmFtZS0+cnhfZGF0YTsNCj4gQEAgLTE1NDYsNyArMTU0NCw3IEBAIHVuc2lnbmVkIGludCBvbl9h
Y3Rpb25fc3BjdChzdHJ1Y3QgYWRhcHRlciAqcGFkYXB0ZXIsIHN0cnVjdCByZWN2X2ZyYW1lICpw
cmVjdl9mDQo+ICAgICAgIH0NCg0KPiAgZXhpdDoNCj4gLSAgICAgcmV0dXJuIHJldDsNCj4gKyAg
ICAgcmV0dXJuIF9GQUlMOw0KPiAgfQ0KPiAgdW5zaWduZWQgaW50IE9uQWN0aW9uX3FvcyhzdHJ1
Y3QgYWRhcHRlciAqcGFkYXB0ZXIsIHN0cnVjdCByZWN2X2ZyYW1lICpwcmVjdl9mcmFtZSkNCj4g
LS0NCj4gMi43LjQNCg0K
