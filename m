Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE2D46E6FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhLIKvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:51:49 -0500
Received: from mail.emtrion.de ([87.139.198.129]:20966 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230283AbhLIKvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:51:49 -0500
Received: from EMT-KA-S004.emtrion.local (2003:f9:5824:1:c59f:32f4:72e5:b9e1)
 by EMT-KA-S004.emtrion.local (2003:f9:5824:1:c59f:32f4:72e5:b9e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 9 Dec 2021
 11:48:13 +0100
Received: from EMT-KA-S004.emtrion.local ([fe80::c59f:32f4:72e5:b9e1]) by
 EMT-KA-S004.emtrion.local ([fe80::c59f:32f4:72e5:b9e1%11]) with mapi id
 15.02.0922.019; Thu, 9 Dec 2021 11:48:13 +0100
From:   "Mueller, Reinhold" <Reinhold.Mueller@emtrion.de>
To:     'Rob Herring' <robh@kernel.org>
CC:     "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH 1/2] dt-bindings: arm/stm32: Add emtrion hardware
 emSBC-Argon
Thread-Topic: [PATCH 1/2] dt-bindings: arm/stm32: Add emtrion hardware
 emSBC-Argon
Thread-Index: AQHX5cKtPvbr3rHvD0CvAl/d/dQRE6wnhZsAgAKA7pA=
Date:   Thu, 9 Dec 2021 10:48:13 +0000
Message-ID: <ba4e038f606b4c51841630e8da0070c5@emtrion.de>
References: <20211130081654.119028-1-reinhold.mueller@emtrion.com>
 <20211130081654.119028-2-reinhold.mueller@emtrion.com>
 <Ya/RRFKQ35shFCzg@robh.at.kernel.org>
In-Reply-To: <Ya/RRFKQ35shFCzg@robh.at.kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2003:f9:5824:1:5c90:40d3:cc94:d44e]
x-c2processedorg: 5b249fcb-306f-4927-9982-5d11b1d300ce
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpwbGVhc2Ugc2VlIHRoZSBjb21tZW50cyBiZWxvdy4NCg0KUmVnYXJkcw0KUmVp
bmhvbGQNCg0KDQpSZWluaG9sZCBNdWVsbGVyDQpTb2Z0d2FyZSBlbmdpbmVlcg0KDQoNCmVtdHJp
b24gR21iSA0KQW0gSGFzZW5iaWVsIDYgfCA3NjI5NyBTdHV0ZW5zZWUgfCBHZXJtYW55DQoNClBo
b25lICs0OSA3MjQ0IDYyNjk0IDIwDQpGYXggKzQ5IDcyNDQgNjI2OTQgMTkNCkVtYWlsIFJlaW5o
b2xkLk11ZWxsZXJAZW10cmlvbi5kZQ0KT25saW5lIHd3dy5lbXRyaW9uLmRlDQoNCg0KDQoNCmVt
dHJpb24gR21iSCDigKIgQW10c2dlcmljaHQgTWFubmhlaW0g4oCiIEhSQiAxMTAgMzAwIOKAoiBH
ZXNjaMOkZnRzZsO8aHJlcjogUmFtb25hIE1hdXJlciwgQWNobWVkIEhhZGRvdSDigKIgVW1zYXR6
c3RldWVyaWRlbnRpZmlrYXRpb25zbnVtbWVyOkRFODEzNjk0MjYwIOKAoiBJbXByZXNzdW06IHd3
dy5lbXRyaW9uLmRlL2RlL2ltcHJlc3N1bS5odG1sDQoNCkhJTldFSVM6IFBlcnNvbmVuYmV6b2dl
bmUgRGF0ZW4sIGRpZSBTaWUgcGVyIEUtTWFpbCBhbiB1bnMgw7xiZXJtaXR0ZWxuLCB3ZXJkZW4g
YmVpIHVucyBnZXNwZWljaGVydCB1bmQgdmVyYXJiZWl0ZXQuIEluZm9ybWF0aW9uZW4genUgdW5z
ZXJlbiBnZXNldHpsaWNoZW4gSW5mb3JtYXRpb25zcGZsaWNodGVuLCB6dSB1bnMgdW5kIHVuc2Vy
ZW4gRGllbnN0bGVpc3R1bmdlbiBmaW5kZW4gU2llIGluIHVuc2VyZW4gRGF0ZW5zY2h1dHpoaW53
ZWlzZW4uDQpEaWVzZSBFLU1haWwga2FubiB2ZXJ0cmF1bGljaGUgdW5kIC8gb2RlciByZWNodGxp
Y2ggZ2VzY2jDvHR6dGUgSW5mb3JtYXRpb25lbiBlbnRoYWx0ZW4uIFdlbm4gU2llIG5pY2h0IGRl
ciByaWNodGlnZSBBZHJlc3NhdCBzaW5kLCBvZGVyIGRpZXNlIEUtTWFpbCBpcnJ0w7xtbGljaCBl
cmhhbHRlbiBoYWJlbiwgaW5mb3JtaWVyZW4gU2llIGJpdHRlIGRlbiBBYnNlbmRlciB1bmQgdmVy
bmljaHRlbiBkaWVzZSBNYWlsLiBEYXMgdW5lcmxhdWJ0ZSBrb3BpZXJlbiwgc293aWUgZGllIHVu
YmVmdWd0ZSBXZWl0ZXJnYWJlIGRpZXNlciBNYWlsIGlzdCBuaWNodCBnZXN0YXR0ZXQuDQo+IC0t
LS0tVXJzcHLDvG5nbGljaGUgTmFjaHJpY2h0LS0tLS0NCj4gVm9uOiBSb2IgSGVycmluZyA8cm9i
aEBrZXJuZWwub3JnPg0KPiBHZXNlbmRldDogRGllbnN0YWcsIDcuIERlemVtYmVyIDIwMjEgMjI6
MjUNCj4gQW46IE11ZWxsZXIsIFJlaW5ob2xkIDxSZWluaG9sZC5NdWVsbGVyQGVtdHJpb24uZGU+
DQo+IENjOiBhbGV4YW5kcmUudG9yZ3VlQGZvc3Muc3QuY29tOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQmV0cmVmZjogUmU6
IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBhcm0vc3RtMzI6IEFkZCBlbXRyaW9uIGhhcmR3YXJl
DQo+IGVtU0JDLUFyZ29uDQo+DQo+IE9uIFR1ZSwgTm92IDMwLCAyMDIxIGF0IDA5OjE2OjUzQU0g
KzAxMDAsIHJlaW5ob2xkLm11ZWxsZXJAZW10cmlvbi5jb20NCj4gd3JvdGU6DQo+ID4gRnJvbTog
UmVpbmhvbGQgTXVlbGxlciA8cmVpbmhvbGQubXVlbGxlckBlbXRyaW9uLmNvbT4NCj4gPg0KPiA+
IFRoaXMgcGF0Y2ggcHJlc2VudHMgdGhlIHlhbWwgcGF0Y2ggZm9yIHRoZSBlbXRyaW9uIEdtYkgN
Cj4gPiBBcmdvbiBib2FyZCBzZXJpZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSZWluaG9s
ZCBNdWVsbGVyIDxyZWluaG9sZC5tdWVsbGVyQGVtdHJpb24uY29tPg0KPiA+IC0tLQ0KPiA+ICBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3N0bTMyL3N0bTMyLnlhbWwgfCA4
DQo+ICsrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3N0
bTMyL3N0bTMyLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L3N0bTMyL3N0bTMyLnlhbWwNCj4gPiBpbmRleCBiY2FmN2JlM2FiMzcuLjcxMDIzMDg0N2RjZCAx
MDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3N0
bTMyL3N0bTMyLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL3N0bTMyL3N0bTMyLnlhbWwNCj4gPiBAQCAtMjgsNiArMjgsMTQgQEAgcHJvcGVydGll
czoNCj4gPiAgICAgICAgICAgIC0gZW51bToNCj4gPiAgICAgICAgICAgICAgICAtIHN0LHN0bTMy
bXAxNTMNCj4gPiAgICAgICAgICAgICAgICAtIHN0LHN0bTMybXAxNTcNCj4gPiArDQo+ID4gKyAg
ICAgIC0gZGVzY3JpcHRpb246IGVtdHJpb24gU1RNMzJNUDEgQXJnb24gYmFzZWQgQm9hcmRzDQo+
ID4gKyAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAg
ICAgICAgLSBlbXRyaW9uLHN0bTMybXAxNTdjLWVtc2JjLWFyZ29uDQo+ID4gKyAgICAgICAgICAt
IGVudW06DQo+ID4gKyAgICAgICAgICAgICAgLSBlbXRyaW9uLHN0bTMybXAxNTdjLWVtc3RhbXAt
YXJnb24NCj4NCj4gSXMgdGhlcmUgZ29pbmcgdG8gYmUgbXVsdGlwbGUgZW50cmllcyBoZXJlPyBJ
ZiBub3QsIHVzZSAnY29uc3QnIGluc3RlYWQNCj4gb2YgJ2VudW0nLg0KPg0KY3VycmVudGx5IG5v
IG1vcmUgZW50cmllcywgaSB3aWxsIHJlc2VudCBhIG1vZGlmaWVkIHBhdGNoc2V0DQo+ID4gKyAg
ICAgICAgICAtIGNvbnN0OiBzdCxzdG0zMm1wMTU3DQo+ID4gICAgICAgIC0gaXRlbXM6DQo+ID4g
ICAgICAgICAgICAtIGVudW06DQo+ID4gICAgICAgICAgICAgICAgLSBzdCxzdG0zMmY0MjlpLWRp
c2NvDQo+ID4gLS0NCj4gPiAyLjIwLjENCj4gPg0KPiA+DQo=
