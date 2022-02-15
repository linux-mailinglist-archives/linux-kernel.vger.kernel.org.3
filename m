Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E02C4B63C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbiBOGrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:47:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiBOGrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:47:53 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A49B13CEE;
        Mon, 14 Feb 2022 22:47:40 -0800 (PST)
X-UUID: 8a680551181e4ef6b1965dea329c6ddb-20220215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=kuUSzsUy0IuHIHRMUuXKTprsK0rJaAS42u2oTlh7Ol8=;
        b=OJhY4hfE2+qlkc8EqiQSQwioKPD3SBJNwOOb+2qzg9XOfb0IUkU6TewnTs3rpqm1WvSrHqQH1jmeEfg5hi+KpnBI7DKj74uVlXAP2Qmh9QzVbd5eWBfGRG5vUbrTyDb4B1SKGhOS2hb6ZNX3svoa/6wkVzZpppSjtElDMueLPTM=;
X-UUID: 8a680551181e4ef6b1965dea329c6ddb-20220215
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2058819367; Tue, 15 Feb 2022 14:47:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 14:47:33 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 14:47:33 +0800
Subject: Re: [PATCH v2 3/3] pwm: pwm-mediatek: Beautify error messages text
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
CC:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>
References: <20220214140339.112500-1-angelogioacchino.delregno@collabora.com>
 <20220214140339.112500-3-angelogioacchino.delregno@collabora.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <e3222caa-ec69-2e90-ef81-666b03da656d@mediatek.com>
Date:   Tue, 15 Feb 2022 14:47:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220214140339.112500-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="iso-2022-jp"; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xNC8yMiAxMDowMyBQTSwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6DQo+
IEFzIGEgY2hlcnJ5LW9uLXRvcCBjbGVhbnVwLCBtYWtlIGVycm9yIG1lc3NhZ2VzIGNsZWFyZXIg
dG8gcmVhZA0KPiBieSBjaGFuZ2luZyBpbnN0YW5jZXMgb2YgImNsb2NrOiBYWFhYIGZhaWxlZCIg
dG8gYSBtb3JlIHJlYWRhYmxlDQo+ICJGYWlsZWQgdG8gZ2V0IFhYWFggY2xvY2siLiBBbHNvIGFk
ZCAib2YiIHRvIHVuc3VwcG9ydGVkIHBlcmlvZA0KPiBlcnJvci4NCj4gDQo+IFRoaXMgaXMgcHVy
ZWx5IGEgY29zbWV0aWMgY2hhbmdlOyBubyAicmVhbCIgZnVuY3Rpb25hbCBjaGFuZ2VzLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2Fj
Y2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9wd20vcHdt
LW1lZGlhdGVrLmMgfCA4ICsrKystLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20t
bWVkaWF0ZWsuYyBiL2RyaXZlcnMvcHdtL3B3bS1tZWRpYXRlay5jDQo+IGluZGV4IDZiMzlmM2Q2
OWU0MS4uNTY4YjEzYTQ4NzE3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3B3bS9wd20tbWVkaWF0
ZWsuYw0KPiArKysgYi9kcml2ZXJzL3B3bS9wd20tbWVkaWF0ZWsuYw0KPiBAQCAtMTQ2LDcgKzE0
Niw3IEBAIHN0YXRpYyBpbnQgcHdtX21lZGlhdGVrX2NvbmZpZyhzdHJ1Y3QgcHdtX2NoaXAgKmNo
aXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20sDQo+ICAgDQo+ICAgCWlmIChjbGtkaXYgPiBQV01f
Q0xLX0RJVl9NQVgpIHsNCj4gICAJCXB3bV9tZWRpYXRla19jbGtfZGlzYWJsZShjaGlwLCBwd20p
Ow0KPiAtCQlkZXZfZXJyKGNoaXAtPmRldiwgInBlcmlvZCAlZCBub3Qgc3VwcG9ydGVkXG4iLCBw
ZXJpb2RfbnMpOw0KPiArCQlkZXZfZXJyKGNoaXAtPmRldiwgInBlcmlvZCBvZiAlZCBucyBub3Qg
c3VwcG9ydGVkXG4iLCBwZXJpb2RfbnMpOw0KPiAgIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICAgCX0N
Cj4gICANCj4gQEAgLTIyOSwxMiArMjI5LDEyIEBAIHN0YXRpYyBpbnQgcHdtX21lZGlhdGVrX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgCXBjLT5jbGtfdG9wID0gZGV2
bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJ0b3AiKTsNCj4gICAJaWYgKElTX0VSUihwYy0+Y2xrX3Rv
cCkpDQo+ICAgCQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2LCBQVFJfRVJSKHBjLT5j
bGtfdG9wKSwNCj4gLQkJCQkgICAgICJjbG9jazogdG9wIGZhaWxlZFxuIik7DQo+ICsJCQkJICAg
ICAiRmFpbGVkIHRvIGdldCB0b3AgY2xvY2tcbiIpOw0KPiAgIA0KPiAgIAlwYy0+Y2xrX21haW4g
PSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgIm1haW4iKTsNCj4gICAJaWYgKElTX0VSUihwYy0+
Y2xrX21haW4pKQ0KPiAgIAkJcmV0dXJuIGRldl9lcnJfcHJvYmUoJnBkZXYtPmRldiwgUFRSX0VS
UihwYy0+Y2xrX21haW4pLA0KPiAtCQkJCSAgICAgImNsb2NrOiBtYWluIGZhaWxlZFxuIik7DQo+
ICsJCQkJICAgICAiRmFpbGVkIHRvIGdldCBtYWluIGNsb2NrXG4iKTsNCj4gICANCj4gICAJZm9y
IChpID0gMDsgaSA8IHBjLT5zb2MtPm51bV9wd21zOyBpKyspIHsNCj4gICAJCWNoYXIgbmFtZVs4
XTsNCj4gQEAgLTI0NCw3ICsyNDQsNyBAQCBzdGF0aWMgaW50IHB3bV9tZWRpYXRla19wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIAkJcGMtPmNsa19wd21zW2ldID0gZGV2
bV9jbGtfZ2V0KCZwZGV2LT5kZXYsIG5hbWUpOw0KPiAgIAkJaWYgKElTX0VSUihwYy0+Y2xrX3B3
bXNbaV0pKQ0KPiAgIAkJCXJldHVybiBkZXZfZXJyX3Byb2JlKCZwZGV2LT5kZXYsIFBUUl9FUlIo
cGMtPmNsa19wd21zW2ldKSwNCj4gLQkJCQkJICAgICAiY2xvY2s6ICVzIGZhaWxlZFxuIiwgbmFt
ZSk7DQo+ICsJCQkJCSAgICAgIkZhaWxlZCB0byBnZXQgJXMgY2xvY2tcbiIsIG5hbWUpOw0KPiAg
IAl9DQo+ICAgDQo+ICAgCXBjLT5jaGlwLmRldiA9ICZwZGV2LT5kZXY7DQo+IA0KDQpUaGUgZm9y
bWF0IG9mIHRoZXNlIGRlYnVnIG1lc3NhZ2VzICJjbG9jazogdG9wIiBvciAiY2xvY2s6IG1haW4i
IGlzICANCm1lYW50IHRvIGtlZXAgYm90aCBodW1hbiBhbmQgbWFjaGluZSdzIHJlYWRhYmlsaXR5
IGF0IHRoZSBzYW1lIHRpbWUuDQpUaGlzIGtpbmQgb2YgZm9ybWF0IGlzIG11Y2ggbW9yZSBlYXNp
ZXIgdG8gcGFyc2UgYnkgc2NyaXB0cywgd2hpY2ggdGhlICANCmRyaXZlcidzIGNhdGVnb3J5IGFu
ZCBzdWIgbm9kZXMgYXJlIHNlcGFyYXRlZCBieSBkZWxpbWl0ZXJzIC4gSWYgYSBmYWlsICANCmxv
ZyBoYXMgYmVlbiBwcm92aWRlZCwgdGhlIHNjcmlwdCBjb3VsZCBpbmRpY2F0ZWQgd2hlcmUgdGhl
IGlzc3VlIG1pZ2h0ICANCmV4aXN0cyBwcm9iYWJseS4gRGV2aWNlIHZlbmRlciwgZmllbGQgYXBw
bGljYXRpb24gZW5naW5lZXIsIGFuZCBkcml2ZXIgIA0KbWFpbnRhaW5lciBjb3VsZCBiZSBhYmxl
IHRvIHdyaXRlIGFuZCB1c2UgdGhlIGVycm9yIGxvZyBwYXJzZXIgYmVmb3JlICANCmRlYnVnZ2lu
Zy4NCg0KSSdtIG5vdCBzdXJlIGlmIHRoaXMga2luZCBvZiBmb3JtYXQgd2lsbCBiZSBiZXR0ZXIu
IExpa2UsICJGYWlsZWQgdG8gZ2V0ICANCmNsb2NrOiAlcyIuDQoNCklmIG1vc3QgcGVvcGxlIGxp
a2UgdGhpcyBraW5kIG9mIHNvbHV0aW9uICgiRmFpbGVkIHRvIGdldCBjbG9jazogJXNcbiIpLCAg
DQp0aGVuIHlvdSBjYW4gaGF2ZSB0aGUgcmV2aWV3ZWQtYnkgdGFnLg0KVGhhbmtzIQ0KDQpSZXZp
ZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KUmVnYXJk
cywgOikNCk1hY3BhdWwgTGlu

