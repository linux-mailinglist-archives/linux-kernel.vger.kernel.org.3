Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8963959FC4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbiHXNy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbiHXNyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:54:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B5F9A9C0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:51:52 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-209-9PM6a2biPai05R89GFQwYw-1; Wed, 24 Aug 2022 14:51:50 +0100
X-MC-Unique: 9PM6a2biPai05R89GFQwYw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.38; Wed, 24 Aug 2022 14:51:48 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.040; Wed, 24 Aug 2022 14:51:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mario Limonciello' <mario.limonciello@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Kent Gibson <warthog618@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pinctrl: amd: Pick some different unicode symbols
Thread-Topic: [PATCH] pinctrl: amd: Pick some different unicode symbols
Thread-Index: AQHYt0UmrHCkk4SnVUqt8/jCLWV97a2+EkkQ
Date:   Wed, 24 Aug 2022 13:51:47 +0000
Message-ID: <6ffb775a97384ff59676d9c4337481f0@AcuMS.aculab.com>
References: <20220823230753.14799-1-mario.limonciello@amd.com>
In-Reply-To: <20220823230753.14799-1-mario.limonciello@amd.com>
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

RnJvbTogTWFyaW8gTGltb25jaWVsbG8NCj4gU2VudDogMjQgQXVndXN0IDIwMjIgMDA6MDgNCj4g
DQo+IEZlZWRiYWNrIGZyb20gS2VudCBoYWQgc2hvd2VkIHNvbWUgYmV0dGVyIHNlbGVjdGlvbnMg
Zm9yIHN5bWJvbHMgdG8NCj4gdXNlIGZvciBwaW5jdHJsLWFtZCBkZWJ1Z2ZzIG91dHB1dC4gIEFk
b3B0IHNvbWUgb2YgdGhvc2UgaW5zdGVhZC4NCg0KSSBob3BlIEknbSBuZXZlciB0aGUgcGVyc29u
IHlvdSB0cmllcyB0byB3cml0ZSBhIHRlc3Qgc2NyaXB0DQp0byBjaGVjayB0aGUgb3V0cHV0Li4u
Lg0KT3IgZGVzY3JpYmUgdGhlbSB0byBzb21lb25lIGVsc2UuLi4NCg0KCURhdmlkDQoNCj4gRml4
ZXM6IGU4MTI5YTA3NmE1MCAoInBpbmN0cmw6IGFtZDogVXNlIHVuaWNvZGUgZm9yIGRlYnVnZnMg
b3V0cHV0IikNCg0KVGhlIGJlc3QgJ2ZpeCcgaXMgdG8gcmVtb3ZlIGFsbCB0aGUgc3R1cGlkIGNo
YXJhY3RlcnMuDQoNCj4gU3VnZ2VzdGVkLWJ5OiBLZW50IEdpYnNvbiA8d2FydGhvZzYxOEBnbWFp
bC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNp
ZWxsb0BhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvcGluY3RybC9waW5jdHJsLWFtZC5jIHwg
MjggKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGlu
c2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGluY3RybC9waW5jdHJsLWFtZC5jIGIvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYW1kLmMNCj4g
aW5kZXggNDY5MWEzM2JjMzc0Li5mZGE0MTkwN2M0ZjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
cGluY3RybC9waW5jdHJsLWFtZC5jDQo+ICsrKyBiL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWFt
ZC5jDQo+IEBAIC0yNDYsNyArMjQ2LDcgQEAgc3RhdGljIHZvaWQgYW1kX2dwaW9fZGJnX3Nob3co
c3RydWN0IHNlcV9maWxlICpzLCBzdHJ1Y3QgZ3Bpb19jaGlwICpnYykNCj4gIAkJfQ0KPiAgCQlz
ZXFfcHJpbnRmKHMsICJHUElPIGJhbmslZFxuIiwgYmFuayk7DQo+ICAJCWZvciAoOyBpIDwgcGlu
X251bTsgaSsrKSB7DQo+IC0JCQlzZXFfcHJpbnRmKHMsICLwn5OMJWRcdCIsIGkpOw0KPiArCQkJ
c2VxX3ByaW50ZihzLCAiIyVkXHQiLCBpKTsNCj4gIAkJCXJhd19zcGluX2xvY2tfaXJxc2F2ZSgm
Z3Bpb19kZXYtPmxvY2ssIGZsYWdzKTsNCj4gIAkJCXBpbl9yZWcgPSByZWFkbChncGlvX2Rldi0+
YmFzZSArIGkgKiA0KTsNCj4gIAkJCXJhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKCZncGlvX2Rl
di0+bG9jaywgZmxhZ3MpOw0KPiBAQCAtMjc4LDMyICsyNzgsMzIgQEAgc3RhdGljIHZvaWQgYW1k
X2dwaW9fZGJnX3Nob3coc3RydWN0IHNlcV9maWxlICpzLCBzdHJ1Y3QgZ3Bpb19jaGlwICpnYykN
Cj4gIAkJCX0NCj4gDQo+ICAJCQlpZiAocGluX3JlZyAmIEJJVChJTlRFUlJVUFRfTUFTS19PRkYp
KQ0KPiAtCQkJCWludGVycnVwdF9tYXNrID0gIi0iOw0KPiArCQkJCWludGVycnVwdF9tYXNrID0g
IvCfmJsiOw0KPiAgCQkJZWxzZQ0KPiAtCQkJCWludGVycnVwdF9tYXNrID0gIisiOw0KPiAtCQkJ
c2VxX3ByaW50ZihzLCAiaW50ICVzICjwn46tICVzKXwgYWN0aXZlLSVzfCAlcy3wn5SrfCAiLA0K
PiArCQkJCWludGVycnVwdF9tYXNrID0gIvCfmLciOw0KPiArCQkJc2VxX3ByaW50ZihzLCAiaW50
ICVzICglcyl8IGFjdGl2ZS0lc3wgJXMt4pqhfCAiLA0KPiAgCQkJCSAgIGludGVycnVwdF9lbmFi
bGUsDQo+ICAJCQkJICAgaW50ZXJydXB0X21hc2ssDQo+ICAJCQkJICAgYWN0aXZlX2xldmVsLA0K
PiAgCQkJCSAgIGxldmVsX3RyaWcpOw0KPiANCj4gIAkJCWlmIChwaW5fcmVnICYgQklUKFdBS0Vf
Q05UUkxfT0ZGX1MwSTMpKQ0KPiAtCQkJCXdha2VfY250cmwwID0gIisiOw0KPiArCQkJCXdha2Vf
Y250cmwwID0gIuKPsCI7DQo+ICAJCQllbHNlDQo+IC0JCQkJd2FrZV9jbnRybDAgPSAi4oiFIjsN
Cj4gLQkJCXNlcV9wcmludGYocywgIlMwaTMg8J+MhSAlc3wgIiwgd2FrZV9jbnRybDApOw0KPiAr
CQkJCXdha2VfY250cmwwID0gIiDiiIUiOw0KPiArCQkJc2VxX3ByaW50ZihzLCAiUzBpMyAlc3wg
Iiwgd2FrZV9jbnRybDApOw0KPiANCj4gIAkJCWlmIChwaW5fcmVnICYgQklUKFdBS0VfQ05UUkxf
T0ZGX1MzKSkNCj4gLQkJCQl3YWtlX2NudHJsMSA9ICIrIjsNCj4gKwkJCQl3YWtlX2NudHJsMSA9
ICLij7AiOw0KPiAgCQkJZWxzZQ0KPiAtCQkJCXdha2VfY250cmwxID0gIuKIhSI7DQo+IC0JCQlz
ZXFfcHJpbnRmKHMsICJTMyDwn4yFICVzfCAiLCB3YWtlX2NudHJsMSk7DQo+ICsJCQkJd2FrZV9j
bnRybDEgPSAiIOKIhSI7DQo+ICsJCQlzZXFfcHJpbnRmKHMsICJTMyAlc3wgIiwgd2FrZV9jbnRy
bDEpOw0KPiANCj4gIAkJCWlmIChwaW5fcmVnICYgQklUKFdBS0VfQ05UUkxfT0ZGX1M0KSkNCj4g
LQkJCQl3YWtlX2NudHJsMiA9ICIrIjsNCj4gKwkJCQl3YWtlX2NudHJsMiA9ICLij7AiOw0KPiAg
CQkJZWxzZQ0KPiAtCQkJCXdha2VfY250cmwyID0gIuKIhSI7DQo+IC0JCQlzZXFfcHJpbnRmKHMs
ICJTNC9TNSDwn4yFICVzfCAiLCB3YWtlX2NudHJsMik7DQo+ICsJCQkJd2FrZV9jbnRybDIgPSAi
IOKIhSI7DQo+ICsJCQlzZXFfcHJpbnRmKHMsICJTNC9TNSAlc3wgIiwgd2FrZV9jbnRybDIpOw0K
PiANCj4gIAkJCWlmIChwaW5fcmVnICYgQklUKFBVTExfVVBfRU5BQkxFX09GRikpIHsNCj4gIAkJ
CQlwdWxsX3VwX2VuYWJsZSA9ICIrIjsNCj4gQEAgLTM2Nyw3ICszNjcsNyBAQCBzdGF0aWMgdm9p
ZCBhbWRfZ3Bpb19kYmdfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHN0cnVjdCBncGlvX2NoaXAg
KmdjKQ0KPiAgCQkJCWRlYm91bmNlX2VuYWJsZSA9ICIgIOKIhSI7DQo+ICAJCQl9DQo+ICAJCQlz
bnByaW50ZihkZWJvdW5jZV92YWx1ZSwgc2l6ZW9mKGRlYm91bmNlX3ZhbHVlKSwgIiV1IiwgdGlt
ZSAqIHVuaXQpOw0KPiAtCQkJc2VxX3ByaW50ZihzLCAiZGVib3VuY2UgJXMgKOKPsCAlc3VzKXwg
IiwgZGVib3VuY2VfZW5hYmxlLCBkZWJvdW5jZV92YWx1ZSk7DQo+ICsJCQlzZXFfcHJpbnRmKHMs
ICJkZWJvdW5jZSAlcyAo8J+VkSAlc3VzKXwgIiwgZGVib3VuY2VfZW5hYmxlLCBkZWJvdW5jZV92
YWx1ZSk7DQo+ICAJCQlzZXFfcHJpbnRmKHMsICIgMHgleFxuIiwgcGluX3JlZyk7DQo+ICAJCX0N
Cj4gIAl9DQo+IC0tDQo+IDIuMzQuMQ0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

