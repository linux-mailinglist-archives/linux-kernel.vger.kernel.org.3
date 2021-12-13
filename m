Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8992472D14
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhLMNTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:19:38 -0500
Received: from mail.emtrion.de ([87.139.198.129]:48565 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233448AbhLMNTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:19:37 -0500
Received: from EMT-KA-S004.emtrion.local (2003:f9:5824:1:c59f:32f4:72e5:b9e1)
 by EMT-KA-S004.emtrion.local (2003:f9:5824:1:c59f:32f4:72e5:b9e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 13 Dec
 2021 14:19:34 +0100
Received: from EMT-KA-S004.emtrion.local ([fe80::c59f:32f4:72e5:b9e1]) by
 EMT-KA-S004.emtrion.local ([fe80::c59f:32f4:72e5:b9e1%11]) with mapi id
 15.02.0922.019; Mon, 13 Dec 2021 14:19:34 +0100
From:   "Mueller, Reinhold" <Reinhold.Mueller@emtrion.de>
To:     'Matti Vaittinen' <mazziesaccount@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "inux-arm-kernel@lists.infradead.org" 
        <inux-arm-kernel@lists.infradead.org>
Subject: AW: [PATCH 2/2] arm64: dts: imx8mm: Add support for emtrion
 emCON-MX8M Mini
Thread-Topic: [PATCH 2/2] arm64: dts: imx8mm: Add support for emtrion
 emCON-MX8M Mini
Thread-Index: AQHX7PWtMgh62TvYt0C+YH8pF7gByKwsF7EAgARVeKA=
Date:   Mon, 13 Dec 2021 13:19:34 +0000
Message-ID: <664b2f30a4b040829bc6cae4b6d6a318@emtrion.de>
References: <20211209120934.4815-1-reinhold.mueller@emtrion.com>
 <20211209120934.4815-3-reinhold.mueller@emtrion.com>
 <29c8eeeb-2dee-6182-a2d3-90821cda975a@gmail.com>
In-Reply-To: <29c8eeeb-2dee-6182-a2d3-90821cda975a@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2003:f9:5824:1:f844:a05a:aa3e:9bf0]
x-c2processedorg: 5b249fcb-306f-4927-9982-5d11b1d300ce
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGksDQoNCnRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KUGxlYXNlIGxvb2sgYXQgdGhl
IGNvbW1lbnQgYmVsb3cuDQoNClJlZ2FyZHMNClJlaW5ob2xkDQoNCg0KUmVpbmhvbGQgTXVlbGxl
cg0KU29mdHdhcmUgZW5naW5lZXINCg0KDQplbXRyaW9uIEdtYkgNCkFtIEhhc2VuYmllbCA2IHwg
NzYyOTcgU3R1dGVuc2VlIHwgR2VybWFueQ0KDQpQaG9uZSArNDkgNzI0NCA2MjY5NCAyMA0KRmF4
ICs0OSA3MjQ0IDYyNjk0IDE5DQpFbWFpbCBSZWluaG9sZC5NdWVsbGVyQGVtdHJpb24uZGUNCk9u
bGluZSB3d3cuZW10cmlvbi5kZQ0KDQoNCg0KDQplbXRyaW9uIEdtYkgg4oCiIEFtdHNnZXJpY2h0
IE1hbm5oZWltIOKAoiBIUkIgMTEwIDMwMCDigKIgR2VzY2jDpGZ0c2bDvGhyZXI6IFJhbW9uYSBN
YXVyZXIsIEFjaG1lZCBIYWRkb3Ug4oCiIFVtc2F0enN0ZXVlcmlkZW50aWZpa2F0aW9uc251bW1l
cjpERTgxMzY5NDI2MCDigKIgSW1wcmVzc3VtOiB3d3cuZW10cmlvbi5kZS9kZS9pbXByZXNzdW0u
aHRtbA0KDQpISU5XRUlTOiBQZXJzb25lbmJlem9nZW5lIERhdGVuLCBkaWUgU2llIHBlciBFLU1h
aWwgYW4gdW5zIMO8YmVybWl0dGVsbiwgd2VyZGVuIGJlaSB1bnMgZ2VzcGVpY2hlcnQgdW5kIHZl
cmFyYmVpdGV0LiBJbmZvcm1hdGlvbmVuIHp1IHVuc2VyZW4gZ2VzZXR6bGljaGVuIEluZm9ybWF0
aW9uc3BmbGljaHRlbiwgenUgdW5zIHVuZCB1bnNlcmVuIERpZW5zdGxlaXN0dW5nZW4gZmluZGVu
IFNpZSBpbiB1bnNlcmVuIERhdGVuc2NodXR6aGlud2Vpc2VuLg0KRGllc2UgRS1NYWlsIGthbm4g
dmVydHJhdWxpY2hlIHVuZCAvIG9kZXIgcmVjaHRsaWNoIGdlc2Now7x0enRlIEluZm9ybWF0aW9u
ZW4gZW50aGFsdGVuLiBXZW5uIFNpZSBuaWNodCBkZXIgcmljaHRpZ2UgQWRyZXNzYXQgc2luZCwg
b2RlciBkaWVzZSBFLU1haWwgaXJydMO8bWxpY2ggZXJoYWx0ZW4gaGFiZW4sIGluZm9ybWllcmVu
IFNpZSBiaXR0ZSBkZW4gQWJzZW5kZXIgdW5kIHZlcm5pY2h0ZW4gZGllc2UgTWFpbC4gRGFzIHVu
ZXJsYXVidGUga29waWVyZW4sIHNvd2llIGRpZSB1bmJlZnVndGUgV2VpdGVyZ2FiZSBkaWVzZXIg
TWFpbCBpc3QgbmljaHQgZ2VzdGF0dGV0Lg0KPiAtLS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNo
dC0tLS0tDQo+IFZvbjogTWF0dGkgVmFpdHRpbmVuIDxtYXp6aWVzYWNjb3VudEBnbWFpbC5jb20+
DQo+IEdlc2VuZGV0OiBGcmVpdGFnLCAxMC4gRGV6ZW1iZXIgMjAyMSAyMTowNQ0KPiBBbjogTXVl
bGxlciwgUmVpbmhvbGQgPFJlaW5ob2xkLk11ZWxsZXJAZW10cmlvbi5kZT47DQo+IHJvYmgrZHRA
a2VybmVsLm9yZw0KPiBDYzogc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25p
eC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4
LWlteEBueHAuY29tOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
DQo+IEJldHJlZmY6IFJlOiBbUEFUQ0ggMi8yXSBhcm02NDogZHRzOiBpbXg4bW06IEFkZCBzdXBw
b3J0IGZvciBlbXRyaW9uDQo+IGVtQ09OLU1YOE0gTWluaQ0KPg0KPiBIaSBkZWUgSG8gUmVpbmhv
bGQsDQo+DQo+DQo+IE9uIDEyLzkvMjEgMTQ6MDksIHJlaW5ob2xkLm11ZWxsZXJAZW10cmlvbi5j
b20gd3JvdGU6DQo+ID4gRnJvbTogUmVpbmhvbGQgTXVlbGxlciA8cmVpbmhvbGQubXVlbGxlckBl
bXRyaW9uLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciB0aGUgZW10
cmlvbiBHbWJIIGVtQ09OLU1YOE0gTWluaQ0KPiBtb2R1bGVzLg0KPiA+IFRoZXkgYXJlIGF2YWls
YWJsZSB3aXRoIE5YUCBpLk1YIDhNIE1pbmkgZXF1aXBwZWQgd2l0aCAyIG9yIDQgR0INCj4gTWVt
b3J5Lg0KPiA+DQo+ID4gVGhlIGRldmljZXRyZWUgaW14OG1tLWVtY29uLmR0c2kgaXMgdGhlIGNv
bW1vbiBwYXJ0IHByb3ZpZGluZyBhbGwNCj4gPiBtb2R1bGUgY29tcG9uZW50cyBhbmQgdGhlIGJh
c2ljIHN1cHBvcnQgZm9yIHRoZSBTb0MuIFRoZSBzdXBwb3J0IGZvciB0aGUNCj4gPiBhdmFyaSBi
YXNlYm9hcmQgaW4gdGhlIGRldmVsb3Blci1raXQgY29uZmlndXJhdGlvbiBpcyBwcm92aWRlZCBi
eSB0aGUNCj4gPiBlbWNvbi1hdmFyaSBkdHMgZmlsZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBSZWluaG9sZCBNdWVsbGVyIDxyZWluaG9sZC5tdWVsbGVyQGVtdHJpb24uY29tPg0KPiA+IC0t
LQ0KPiA+ICAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvTWFrZWZpbGUgICAgICAgIHwg
ICAzICstDQo+ID4gICAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1lbWNvbi1hdmFyaS5k
dHMgfCAgMjMgKw0KPiA+ICAgLi4uL2R0cy9mcmVlc2NhbGUvaW14OG1tLWVtY29uLWF2YXJpLmR0
c2kgICAgIHwgMTQxICsrKysNCj4gPiAgIC4uLi9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWVt
Y29uLmR0c2kgICAgICB8IDY0NQ0KPiArKysrKysrKysrKysrKysrKysNCj4gPiAgIDQgZmlsZXMg
Y2hhbmdlZCwgODExIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZW1jb24tDQo+
IGF2YXJpLmR0cw0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtbS1lbWNvbi0NCj4gYXZhcmkuZHRzaQ0KPiA+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1lbWNvbi5kdHNpDQo+
ID4NCj4NCj4gPiArJmkyYzMgew0KPiA+ICtjbG9jay1mcmVxdWVuY3kgPSA8NDAwMDAwPjsNCj4g
PiArcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiArcGluY3RybC0wID0gPCZwaW5jdHJs
X2kyYzM+Ow0KPiA+ICtzdGF0dXMgPSAib2theSI7DQo+ID4gKw0KPiA+ICtiZDcxODQ3OnBtaWNA
NGIgew0KPiA+ICtjb21wYXRpYmxlID0gInJvaG0sYmQ3MTg0NyI7DQo+ID4gK3JlZyA9IDwweDRi
PjsNCj4gPiArcGluY3RybC0wID0gPCZwaW5jdHJsX3BtaWM+Ow0KPiA+ICtpbnRlcnJ1cHQtcGFy
ZW50ID0gPCZncGlvMz47DQo+ID4gK2ludGVycnVwdHMgPSA8MiBHUElPX0FDVElWRV9MT1c+Ow0K
Pg0KPiBJIGFzc3VtZSB0aGlzIHNob3VsZCBiZSBJUlFfVFlQRV9MRVZFTF9MT1cNCj4NCllvdSBh
cmUgcmlnaHQuIEkgd2lsbCB1cGRhdGUgdGhlIHBhdGNoc2V0Lg0KDQo+IEJlc3QgUmVnYXJkcw0K
PiAtLSBNYXR0aSBWYWl0dGluZW4NCg==
