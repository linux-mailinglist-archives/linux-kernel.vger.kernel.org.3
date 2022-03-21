Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0769D4E263B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347295AbiCUMWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347027AbiCUMWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:22:44 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17CBE165A9B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:21:05 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(7815:0:AUTH_RELAY)
        (envelope-from <xt.hu@cqplus1.com>); Mon, 21 Mar 2022 20:19:46 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Mar 2022 20:20:15 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Mon, 21 Mar 2022 20:20:15 +0800
From:   =?utf-8?B?eHQuaHVb6IOh5YWI6Z+sXQ==?= <xt.hu@cqplus1.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>,
        Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v7 1/2] dt-bindings: watchdog: Add watchdog yaml file for
 Sunplus SP7021
Thread-Topic: [PATCH v7 1/2] dt-bindings: watchdog: Add watchdog yaml file for
 Sunplus SP7021
Thread-Index: AQHYL5/Q1yVPqanKh0adMWWXRxc4MazJQxOAgACSokA=
Date:   Mon, 21 Mar 2022 12:20:14 +0000
Message-ID: <d752e8ad9d634332954bee930d4050eb@cqplus1.com>
References: <20220304081209.672-1-xt.hu@cqplus1.com>
 <20220304081209.672-2-xt.hu@cqplus1.com>
 <20220321111005.w27blherwnon6kwk@krzk-bin>
In-Reply-To: <20220321111005.w27blherwnon6kwk@krzk-bin>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.110.16]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBLcnp5c3p0b2YNCglUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgW21haWx0bzprcnpr
QGtlcm5lbC5vcmddDQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMjEsIDIwMjIgNzoxMCBQTQ0KPiBU
bzogeHQuaHVb6IOh5YWI6Z+sXSA8eHQuaHVAY3FwbHVzMS5jb20+DQo+IENjOiB3aW1AbGludXgt
d2F0Y2hkb2cub3JnOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBsaW51eC13YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4QHJvZWNr
LXVzLm5ldDsgcm9iaCtkdEBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsN
Cj4gV2VsbHMgTHUg5ZGC6Iqz6aiwIDx3ZWxscy5sdUBzdW5wbHVzLmNvbT47IHFpbmppYW5b6KaD
5YGlXSA8cWluamlhbkBjcXBsdXMxLmNvbT47IFJvYiBIZXJyaW5nDQo+IDxyb2JoQGtlcm5lbC5v
cmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMS8yXSBkdC1iaW5kaW5nczogd2F0Y2hkb2c6
IEFkZCB3YXRjaGRvZyB5YW1sIGZpbGUgZm9yIFN1bnBsdXMgU1A3MDIxDQo+IA0KPiBPbiBGcmks
IE1hciAwNCwgMjAyMiBhdCAwNDoxMjowOFBNICswODAwLCBYaWFudGFvIEh1IHdyb3RlOg0KPiA+
IFRoaXMgYWRkcyB0aGUgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIGRldmljZXRyZWUgYmluZGluZ3Mg
b2YgdGhlIFN1bnBsdXMNCj4gPiBTUDcwMjEgd2F0Y2hkb2cgZHJpdmVyLCBmb3VuZCBmcm9tIFNQ
NzAyMSBTb0NzIGFuZCBuZXdlci4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8
cm9iaEBrZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFhpYW50YW8gSHUgPHh0Lmh1QGNx
cGx1czEuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3Mvd2F0Y2hkb2cvc3VucGx1cyxz
cDcwMjEtd2R0LnlhbWwgfCA0NyArKysrKysrKysrKysrKysrKysrDQo+ID4gIE1BSU5UQUlORVJT
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICsrKw0KPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy9zdW5wbHVzLHNwNzAyMS13ZHQu
eWFtbA0KPiANCj4gUGxlYXNlIHVzZSBzY3JpcHRzL2dldF9tYWludGFpbmVyLnBsIG9uIHJlY2Vu
dCBrZXJuZWwgKG5ld2VzdCBtYWlubGluZSBvcg0KPiByZWNlbnQgbGludXgtbmV4dCkgdG8gZ2V0
IHRoZSBsaXN0IG9mIHBlb3BsZSB0byBDQy4NCj4gDQoNCkkgd2lsbCBkbyBpdCBpbiB0aGUgbmV4
dCBwYXRjaC4NCg0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy93YXRjaGRvZy9zdW5wbHVzLHNwNzAyMS13ZHQueWFtbA0KPiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy9zdW5wbHVzLHNwNzAyMS13ZHQueWFt
bA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwLi45YTliZmUx
NTANCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3dhdGNoZG9nL3N1bnBsdXMsc3A3MDIxLXdkdC55YW1sDQo+ID4gQEAgLTAsMCAr
MSw0NyBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9S
IEJTRC0yLUNsYXVzZSkNCj4gPiArIyBDb3B5cmlnaHQgKEMpIFN1bnBsdXMgQ28uLCBMdGQuIDIw
MjENCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9zY2hlbWFzL3dhdGNoZG9nL3N1bnBsdXMsc3A3MDIxLXdkdC55YW1sIw0KPiA+ICskc2No
ZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiAr
DQo+ID4gK3RpdGxlOiBTdW5wbHVzIFNvQ3MgV2F0Y2hkb2cgRGV2aWNlIFRyZWUgQmluZGluZ3MN
Cj4gDQo+IHMvRGV2aWNlIFRyZWUgQmluZGluZ3MvLw0KPiANCg0KSSB3aWxsIGRyb3AgdGhlIHN0
cmluZyAiRGV2aWNlIFRyZWUgQmluZGluZ3MiLg0KDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoN
Cj4gPiArICAtIFhpYW5UYW8gSHUgPHh0Lmh1QGNxcGx1czEuY29tPg0KPiA+ICsNCj4gPiArYWxs
T2Y6DQo+ID4gKyAgLSAkcmVmOiB3YXRjaGRvZy55YW1sIw0KPiA+ICsNCj4gPiArcHJvcGVydGll
czoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgY29uc3Q6IHN1bnBsdXMsc3A3MDIxLXdk
dA0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBkZXNj
cmlwdGlvbjogd2F0Y2hkb2cgcmVnaXN0ZXJzIHJlZ2lvbnMNCj4gPiArICAgICAgLSBkZXNjcmlw
dGlvbjogbWlzY2VsbGFuZW91cyBjb250cm9sIHJlZ2lzdGVycyByZWdpb25zDQo+ID4gKw0KPiA+
ICsgIGNsb2NrczoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIHJlc2V0czoN
Cj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNv
bXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gY2xvY2tzDQo+ID4gKyAgLSByZXNldHMN
Cj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiArZXhh
bXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICB3YXRjaGRvZzogd2F0Y2hkb2dAOWMwMDA2MzAg
ew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAic3VucGx1cyxzcDcwMjEtd2R0IjsNCj4gPiAr
ICAgICAgICByZWcgPSA8MHg5YzAwMDYzMCAweDA4PiwgPDB4OUMwMDAyNzQgMHgwND47DQo+IA0K
PiBsb3dlcmNhc2UgaGV4IChTZWNvbmQgcmVnKQ0KPiANCg0KSSBqdXN0IHJlYWxpemVkIHRoZSBk
cml2ZXIgZG9uJ3QgdXNlIHNlY29uZCByZWcgYW55bW9yZS4gSSB3aWxsIGRyb3AgaXQgYW5kIA0K
bW9kaWZ5IHRoZSBkZXNjcmlwdGlvbiBvZiByZWcuDQoNCj4gQ2FuIGJlIGZpeGVkIHdoaWxlIGFw
cGx5aW5nLCBzbyBpbiBzdWNoIGNhc2U6DQo+IFJldmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93
c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IA0KDQpJIGdvdCBpdC4NCg0KQmVzdCByZWdhcmRzLA0K
WGlhbi10YW8NCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
