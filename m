Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A25D47A557
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 08:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbhLTHWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 02:22:09 -0500
Received: from mail.emtrion.de ([87.139.198.129]:49586 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234251AbhLTHWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 02:22:08 -0500
Received: from EMT-KA-S004.emtrion.local (2003:f9:5824:1:c59f:32f4:72e5:b9e1)
 by EMT-KA-S004.emtrion.local (2003:f9:5824:1:c59f:32f4:72e5:b9e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 20 Dec
 2021 08:22:06 +0100
Received: from EMT-KA-S004.emtrion.local ([fe80::c59f:32f4:72e5:b9e1]) by
 EMT-KA-S004.emtrion.local ([fe80::c59f:32f4:72e5:b9e1%11]) with mapi id
 15.02.0922.019; Mon, 20 Dec 2021 08:22:06 +0100
From:   "Mueller, Reinhold" <Reinhold.Mueller@emtrion.de>
To:     'Fabio Estevam' <festevam@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH v3 2/2] arm64: dts: imx8mm: Add support for emtrion
 emCON-MX8M Mini
Thread-Topic: [PATCH v3 2/2] arm64: dts: imx8mm: Add support for emtrion
 emCON-MX8M Mini
Thread-Index: AQHX8p4/qVpEE+5XVkqp76PsxzzPJaw1S+yAgAWw2AA=
Date:   Mon, 20 Dec 2021 07:22:05 +0000
Message-ID: <45a433da4f12450f9f890f181bcd4126@emtrion.de>
References: <20211216165851.64708-1-reinhold.mueller@emtrion.com>
 <20211216165851.64708-3-reinhold.mueller@emtrion.com>
 <CAOMZO5C346Om3QS19RQB3EzPu9Ey2b1jt_V_hzOZCk6bEd9wtQ@mail.gmail.com>
In-Reply-To: <CAOMZO5C346Om3QS19RQB3EzPu9Ey2b1jt_V_hzOZCk6bEd9wtQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2003:f9:5824:1:602d:8cff:3d08:141a]
x-c2processedorg: 5b249fcb-306f-4927-9982-5d11b1d300ce
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaW8sDQoNCnRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KUGxlYXNlIHNlZSB0aGUgY29t
bWVudHMgYXQgdGhlIG1hcmtlZCBpc3N1ZXMgYmVsb3cuDQpJIHdpbGwgc2VuZCBhIG5ldyBwYXRj
aHNldC4NCg0KUmVnYXJkcw0KUmVpbmhvbGQNCg0KDQpSZWluaG9sZCBNdWVsbGVyDQpTb2Z0d2Fy
ZSBlbmdpbmVlcg0KDQoNCmVtdHJpb24gR21iSA0KQW0gSGFzZW5iaWVsIDYgfCA3NjI5NyBTdHV0
ZW5zZWUgfCBHZXJtYW55DQoNClBob25lICs0OSA3MjQ0IDYyNjk0IDIwDQpGYXggKzQ5IDcyNDQg
NjI2OTQgMTkNCkVtYWlsIFJlaW5ob2xkLk11ZWxsZXJAZW10cmlvbi5kZQ0KT25saW5lIHd3dy5l
bXRyaW9uLmRlDQoNCioqKiBNZXJyeSBYLU1hcyAmIEhhcHB5IE5ldyBZZWFyIDIwMjIgKioqDQoN
Cg0KZW10cmlvbiBHbWJIIOKAoiBBbXRzZ2VyaWNodCBNYW5uaGVpbSDigKIgSFJCIDExMCAzMDAg
4oCiIEdlc2Now6RmdHNmw7xocmVyOiBSYW1vbmEgTWF1cmVyLCBBY2htZWQgSGFkZG91IOKAoiBV
bXNhdHpzdGV1ZXJpZGVudGlmaWthdGlvbnNudW1tZXI6REU4MTM2OTQyNjAg4oCiIEltcHJlc3N1
bTogd3d3LmVtdHJpb24uZGUvZGUvaW1wcmVzc3VtLmh0bWwNCg0KSElOV0VJUzogUGVyc29uZW5i
ZXpvZ2VuZSBEYXRlbiwgZGllIFNpZSBwZXIgRS1NYWlsIGFuIHVucyDDvGJlcm1pdHRlbG4sIHdl
cmRlbiBiZWkgdW5zIGdlc3BlaWNoZXJ0IHVuZCB2ZXJhcmJlaXRldC4gSW5mb3JtYXRpb25lbiB6
dSB1bnNlcmVuIGdlc2V0emxpY2hlbiBJbmZvcm1hdGlvbnNwZmxpY2h0ZW4sIHp1IHVucyB1bmQg
dW5zZXJlbiBEaWVuc3RsZWlzdHVuZ2VuIGZpbmRlbiBTaWUgaW4gdW5zZXJlbiBEYXRlbnNjaHV0
emhpbndlaXNlbi4NCkRpZXNlIEUtTWFpbCBrYW5uIHZlcnRyYXVsaWNoZSB1bmQgLyBvZGVyIHJl
Y2h0bGljaCBnZXNjaMO8dHp0ZSBJbmZvcm1hdGlvbmVuIGVudGhhbHRlbi4gV2VubiBTaWUgbmlj
aHQgZGVyIHJpY2h0aWdlIEFkcmVzc2F0IHNpbmQsIG9kZXIgZGllc2UgRS1NYWlsIGlycnTDvG1s
aWNoIGVyaGFsdGVuIGhhYmVuLCBpbmZvcm1pZXJlbiBTaWUgYml0dGUgZGVuIEFic2VuZGVyIHVu
ZCB2ZXJuaWNodGVuIGRpZXNlIE1haWwuIERhcyB1bmVybGF1YnRlIGtvcGllcmVuLCBzb3dpZSBk
aWUgdW5iZWZ1Z3RlIFdlaXRlcmdhYmUgZGllc2VyIE1haWwgaXN0IG5pY2h0IGdlc3RhdHRldC4N
Cj4gLS0tLS1VcnNwcsO8bmdsaWNoZSBOYWNocmljaHQtLS0tLQ0KPiBWb246IEZhYmlvIEVzdGV2
YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gR2VzZW5kZXQ6IERvbm5lcnN0YWcsIDE2LiBEZXpl
bWJlciAyMDIxIDE4OjE5DQo+IEFuOiBNdWVsbGVyLCBSZWluaG9sZCA8UmVpbmhvbGQuTXVlbGxl
ckBlbXRyaW9uLmRlPg0KPiBDYzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgUm9i
IEhlcnJpbmcNCj4gPHJvYmgrZHRAa2VybmVsLm9yZz47IFNhc2NoYSBIYXVlciA8cy5oYXVlckBw
ZW5ndXRyb25peC5kZT47IFNhc2NoYQ0KPiBIYXVlciA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsg
TlhQIExpbnV4IFRlYW0gPGxpbnV4LWlteEBueHAuY29tPjsNCj4gb3BlbiBsaXN0Ok9QRU4gRklS
TVdBUkUgQU5EIEZMQVRURU5FRCBERVZJQ0UgVFJFRSBCSU5ESU5HUw0KPiA8ZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1rZXJuZWwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+DQo+IEJldHJlZmY6IFJlOiBbUEFUQ0ggdjMgMi8yXSBhcm02NDogZHRzOiBpbXg4bW06IEFk
ZCBzdXBwb3J0IGZvciBlbXRyaW9uDQo+IGVtQ09OLU1YOE0gTWluaQ0KPg0KPiBIaSBSZWluaG9s
ZCwNCj4NCj4gT24gVGh1LCBEZWMgMTYsIDIwMjEgYXQgMTo1OSBQTSA8cmVpbmhvbGQubXVlbGxl
ckBlbXRyaW9uLmNvbT4gd3JvdGU6DQo+DQo+ID4gKyAgICAgICByZXNlcnZlZC1tZW1vcnkgew0K
PiA+ICsgICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiArICAgICAgICAg
ICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAgICAgICAgIHJhbmdlczsNCj4g
PiArDQo+ID4gKyAgICAgICAgICAgICAgIHJwbXNnX3Jlc2VydmVkOiBycG1zZ0BiODAwMDAwMCB7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbm8tbWFwOw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHJlZyA9IDwwIDB4YjgwMDAwMDAgMCAweDQwMDAwMD47DQo+ID4gKyAgICAgICAg
ICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBsb2FkZXJfcmVzZXJ2ZWQ6IGxv
YWRlckBiYjcwMDAwMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbm8tbWFwOw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwwIDB4YmI3MDAwMDAgMHgwIDB4MDAxMDAw
MDA+Ow0KPiA+ICsgICAgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAg
cGNpX3Jlc2VydmVkOiBwY2lAYmI4MDAwMDAgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IG5vLW1hcDsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MCAweGJiODAwMDAw
IDB4MCAweDAwMjAwMDAwPjsNCj4gPiArICAgICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAg
ICAgICAgICAgICAgIGl2c2htZW0yX3Jlc2VydmVkOiBpdnNobWVtMkBiYmEwMDAwMCB7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgbm8tbWFwOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHJlZyA9IDwwIDB4YmJhMDAwMDAgMHgwIDB4MDAxMDAwMDA+Ow0KPiA+ICsgICAgICAgICAg
ICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgaXZzaG1lbV9yZXNlcnZlZDogaXZz
aG1lbUBiYmIwMDAwMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbm8tbWFwOw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwwIDB4YmJiMDAwMDAgMHgwIDB4MDAxMDAw
MDA+Ow0KPiA+ICsgICAgICAgICAgICAgICB9Ow0KPiA+ICsgICAgICAgfTsNCj4NCj4gQXJlIHRo
ZXNlIHJlc2VydmVkIG5vZGVzIG5lZWRlZCB3aXRoIG1haW5saW5lPw0KPg0KPiBMb29rcyBsaWtl
IHRoZXkgYXJlIHJlbW5hbnRzIGZyb20gTlhQIHZlbmRvciBCU1AuDQo+DQpUaGUgcmVzZXJ2ZWQg
bWVtb3J5IG5vZGVzIGFyZSBtb3JlIGN1c3RvbSBzcGVjaWZpYywgc28gaSByZW1vdmUgaXQgZnJv
bSB0aGUgdHJlZS4NCj4gPiArJmZlYzEgew0KPiA+ICsgICAgICAgcGluY3RybC1uYW1lcyA9ICJk
ZWZhdWx0IjsNCj4gPiArICAgICAgIHBpbmN0cmwtMCA9IDwmcGluY3RybF9mZWMxPjsNCj4gPiAr
ICAgICAgIHBoeS1tb2RlID0gInJnbWlpLWlkIjsNCj4gPiArICAgICAgIHBoeS1yZXNldC1ncGlv
cyA9IDwmZ3BpbzEgOSAwPjsNCj4NCj4gcGh5LXJlc2V0LWdwaW9zID0gPCZncGlvMSA5IEdQSU9f
QUNUSVZFX0xPVz47DQo+DQo+IEFjdHVhbGx5LCBwaHktcmVzZXQtZ3Bpb3MgaXMgY29uc2lkZXJl
ZCBkZXByZWNhdGVkLg0KPg0KPiBZb3UgY291bGQgYWxzbyBhZGQgYW4gbWRpbyBub2RlIGFzIGZl
YyBjaGlsZCBhbmQ6DQo+IGFkZCByZXNldC1ncGlvcyA9IDwmZ3BpbzEgOSBHUElPX0FDVElWRV9M
T1c+OyB0aGVyZS4NCk9rLCBpIHdpbGwgYWRkIGEgY2hpbGQgaW4gZmVjIGZvcnQgaGUgcmVzZXQg
Z3Bpb3MNCg==
