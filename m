Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7D54DC296
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiCQJ06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCQJ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:26:55 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11CB1D4C09
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:25:38 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 17 Mar
 2022 17:25:38 +0800
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by
 IT-EXMB-1-125.meizu.com (172.16.1.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 17 Mar 2022 17:25:36 +0800
Received: from IT-EXMB-1-125.meizu.com ([fe80::7481:7d92:3801:4575]) by
 IT-EXMB-1-125.meizu.com ([fe80::7481:7d92:3801:4575%3]) with mapi id
 15.01.2308.014; Thu, 17 Mar 2022 17:25:36 +0800
From:   =?gb2312?B?sNe6xs7E?= <baihaowen@meizu.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBtYWNpbnRvc2g6IG1hY2lvLWFkYjogRml4IHdhcm5p?=
 =?gb2312?Q?ng_comparing_pointer_to_0?=
Thread-Topic: [PATCH] macintosh: macio-adb: Fix warning comparing pointer to 0
Thread-Index: AQHYOabo3BwHvCJ/Yk25NGjKvICrOazCv78AgACOsvc=
Date:   Thu, 17 Mar 2022 09:25:36 +0000
Message-ID: <1ae49db9e2354e28a80cea49c1bfb4a4@meizu.com>
References: <1647484201-11738-1-git-send-email-baihaowen@meizu.com>,<0d00b06f-52e5-bd9b-5592-f3c0ae7cc860@csgroup.eu>
In-Reply-To: <0d00b06f-52e5-bd9b-5592-f3c0ae7cc860@csgroup.eu>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.137.70]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnksIFRoYXQncyBteSBmYXVsdC4gSSd2ZSBzZW50IGFnYWluLg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBDaHJpc3RvcGhlIExlcm95IDxjaHJp
c3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQq3osvNyrG85DogMjAyMsTqM9TCMTfI1SAxNjo1NDox
Ng0KytW8/sjLOiCw17rGzsQ7IGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZzsgbWFzYWhpcm95QGtl
cm5lbC5vcmc7IGFkb2JyaXlhbkBnbWFpbC5jb20NCrOty806IGxpbnV4cHBjLWRldkBsaXN0cy5v
emxhYnMub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQrW98ziOiBSZTogW1BBVENI
XSBtYWNpbnRvc2g6IG1hY2lvLWFkYjogRml4IHdhcm5pbmcgY29tcGFyaW5nIHBvaW50ZXIgdG8g
MA0KDQpMZSAxNy8wMy8yMDIyIKikIDAzOjMwLCBIYW93ZW4gQmFpIGEgqKZjcml0IDoNCj4gQXZv
aWQgcG9pbnRlciB0eXBlIHZhbHVlIGNvbXBhcmVkIHdpdGggMCB0byBtYWtlIGNvZGUgY2xlYXIu
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IEhhb3dlbiBCYWkgPGJhaWhhb3dlbkBtZWl6dS5jb20+DQoN
ClRoaXMgcGF0Y2ggZG9lc24ndCBhcHBseToNCg0KQXBwbHlpbmcgcGF0Y2ggIzE2MDYzNjYgdXNp
bmcgImdpdCBhbSAtcyAtMyAtbSINCkRlc2NyaXB0aW9uOiBtYWNpbnRvc2g6IG1hY2lvLWFkYjog
Rml4IHdhcm5pbmcgY29tcGFyaW5nIHBvaW50ZXIgdG8gMA0KQXBwbHlpbmc6IG1hY2ludG9zaDog
bWFjaW8tYWRiOiBGaXggd2FybmluZyBjb21wYXJpbmcgcG9pbnRlciB0byAwDQplcnJvcjogY29y
cnVwdCBwYXRjaCBhdCBsaW5lIDM3DQplcnJvcjogY291bGQgbm90IGJ1aWxkIGZha2UgYW5jZXN0
b3INClBhdGNoIGZhaWxlZCBhdCAwMDAxIG1hY2ludG9zaDogbWFjaW8tYWRiOiBGaXggd2Fybmlu
ZyBjb21wYXJpbmcgcG9pbnRlcg0KdG8gMA0KaGludDogVXNlICdnaXQgYW0gLS1zaG93LWN1cnJl
bnQtcGF0Y2g9ZGlmZicgdG8gc2VlIHRoZSBmYWlsZWQgcGF0Y2gNCldoZW4geW91IGhhdmUgcmVz
b2x2ZWQgdGhpcyBwcm9ibGVtLCBydW4gImdpdCBhbSAtLWNvbnRpbnVlIi4NCklmIHlvdSBwcmVm
ZXIgdG8gc2tpcCB0aGlzIHBhdGNoLCBydW4gImdpdCBhbSAtLXNraXAiIGluc3RlYWQuDQpUbyBy
ZXN0b3JlIHRoZSBvcmlnaW5hbCBicmFuY2ggYW5kIHN0b3AgcGF0Y2hpbmcsIHJ1biAiZ2l0IGFt
IC0tYWJvcnQiLg0KJ2dpdCBhbScgZmFpbGVkIHdpdGggZXhpdCBzdGF0dXMgMTI4DQoNCg0KDQo+
IC0tLQ0KPiAgIGRyaXZlcnMvbWFjaW50b3NoL21hY2lvLWFkYi5jIHwgNiArKystLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tYWNpbnRvc2gvbWFjaW8tYWRiLmMgYi9kcml2ZXJzL21hY2ludG9z
aC9tYWNpby1hZGIuYw0KPiBpbmRleCBkYzYzNGMyLi41MWFmYTQ2IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL21hY2ludG9zaC9tYWNpby1hZGIuYw0KPiArKysgYi9kcml2ZXJzL21hY2ludG9zaC9t
YWNpby1hZGIuYw0KPiBAQCAtOTcsNyArOTcsNyBAQCBpbnQgbWFjaW9faW5pdCh2b2lkKQ0KPiAg
ICAgICB1bnNpZ25lZCBpbnQgaXJxOw0KPg0KPiAgICAgICBhZGJzID0gb2ZfZmluZF9jb21wYXRp
YmxlX25vZGUoTlVMTCwgImFkYiIsICJjaHJwLGFkYjAiKTsNCj4gLSAgICAgaWYgKGFkYnMgPT0g
MCkNCj4gKyAgICAgaWYgKCFhZGJzKQ0KPiAgICAgICAgICAgICAgIHJldHVybiAtRU5YSU87DQo+
DQo+ICAgICAgIGlmIChvZl9hZGRyZXNzX3RvX3Jlc291cmNlKGFkYnMsIDAsICZyKSkgew0KPiBA
QCAtMTgwLDcgKzE4MCw3IEBAIHN0YXRpYyBpbnQgbWFjaW9fc2VuZF9yZXF1ZXN0KHN0cnVjdCBh
ZGJfcmVxdWVzdCAqcmVxLCBpbnQgc3luYykNCj4gICAgICAgcmVxLT5yZXBseV9sZW4gPSAwOw0K
Pg0KPiAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmbWFjaW9fbG9jaywgZmxhZ3MpOw0KPiAtICAg
ICBpZiAoY3VycmVudF9yZXEgIT0gMCkgew0KPiArICAgICBpZiAoY3VycmVudF9yZXEpIHsNCj4g
ICAgICAgICAgICAgICBsYXN0X3JlcS0+bmV4dCA9IHJlcTsNCj4gICAgICAgICAgICAgICBsYXN0
X3JlcSA9IHJlcTsNCj4gICAgICAgfSBlbHNlIHsNCj4gQEAgLTIxMCw3ICsyMTAsNyBAQCBzdGF0
aWMgaXJxcmV0dXJuX3QgbWFjaW9fYWRiX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICphcmcpDQo+
ICAgICAgIHNwaW5fbG9jaygmbWFjaW9fbG9jayk7DQo+ICAgICAgIGlmIChpbl84KCZhZGItPmlu
dHIucikgJiBUQUcpIHsNCj4gICAgICAgICAgICAgICBoYW5kbGVkID0gMTsNCj4gLSAgICAgICAg
ICAgICBpZiAoKHJlcSA9IGN1cnJlbnRfcmVxKSAhPSAwKSB7DQo+ICsgICAgICAgICAgICAgcmVx
ID0gY3VycmVudF9yZXE7DQo+ICsgICAgICAgICAgICAgaWYgKHJlcSkgew0KPiAgICAgICAgICAg
ICAgICAgICAgICAgLyogcHV0IHRoZSBjdXJyZW50IHJlcXVlc3QgaW4gKi8NCj4gICAgICAgICAg
ICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCByZXEtPm5ieXRlczsgKytpKQ0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBvdXRfOCgmYWRiLT5kYXRhW2ldLnIsIHJlcS0+ZGF0YVtp
XSk7DQo=
