Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E905A468FD2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 05:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbhLFENc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 23:13:32 -0500
Received: from mail-am6eur05on2068.outbound.protection.outlook.com ([40.107.22.68]:43489
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237098AbhLFENa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 23:13:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REkNlkcJ/h3RaIsU2j9Ym/IWEsH4siimQyzqxkTmwqhIXboNN2SS7ELnoDxV0fsPAOdFbpd5Stx6H9BNDUw9i1jRGFJp8KqclKZw5OKyp0Px3c45CHn5vKSHFx9UOY0HCJANUbyHb9NKnJGv/YT5323u1yG9wXGg7HQrQ7RXYaLjuOB5Dx55zGjxnCzItMMh8vBtT6RETsb2vKaBJ9V6YlW2BKG2piNl3w6EbZ2NQmEJtDSP9yUaafhUTfpImeywqAsdjrDeFjAsW6IdTpJy3jAG1M3pDCXe1QvuB6yC13FjullJXHZflMc/VS2BUiC5QPf//kE2C6NCu6F+F0uS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfPUDpYFS523e2HEKd89ArjkefFgmvDvZyTs2TkIJlU=;
 b=Mf8l95pEDmJoweYbgcd+K2azhuiWCQ7cAgKVj2XOxyX1YiKqf4aFoWKSzx00ivEoyEF3p7v7vtoGflsgyc/WFC7NltE4RfF5SfAeOj+Ot3/G6MrlA+TjuOtWOjgeepFmheNwKYxjwfl/usd496Ips71ETffjGcz3G7YWWmrAgQp21C5vRZbLWnn/YFjLmpgFQ/mZFv18j85uQHAhrH19ULnvT/4pzlzNOCulJVAe3OQcjnfjWl/Yhqm2DJROPT2/w+UvVwq5Wq5xbgkJhbjJ2ZA8zYWi99L69vQCEgbhoUF5a//YdA2x0tRyonBRw2CWp7X0Yo6vCrJNEI6Ap0f5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfPUDpYFS523e2HEKd89ArjkefFgmvDvZyTs2TkIJlU=;
 b=YRy+MuWWc/9NEd56uKYnuEdSsGuy220Bq5+RY3P6kx93Bkq6e1Ru+55eUqZfmUQ6LFAxe+KGLyQxBNfkDVNEczJYuR43UKmmg73WnQ8rCUd6m7HvTDSSFY9HK3o6yTdtwz0TdVVHFPMB3cedbqw0LD6YZEMcmOcPmPYVGphGj1k=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB8PR04MB7084.eurprd04.prod.outlook.com (2603:10a6:10:12e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 04:10:00 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::c005:8cdc:9d35:4079%5]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 04:10:00 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/7] arm64: dts: imx8m: configure FEC PHY VDDIO voltage
Thread-Topic: [PATCH 4/7] arm64: dts: imx8m: configure FEC PHY VDDIO voltage
Thread-Index: AQHX4EDam6k4ckJ/5kqN1vg17UaMcKwkvQSAgAAJvuCAAARIgIAAEgHw
Date:   Mon, 6 Dec 2021 04:10:00 +0000
Message-ID: <DB8PR04MB67953877454E156D86D0B534E66D9@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20211123080506.21424-1-qiangqing.zhang@nxp.com>
 <20211123080506.21424-5-qiangqing.zhang@nxp.com>
 <20211206011531.GM4216@dragon>
 <DB8PR04MB6795F657BDD2962D032F567BE66D9@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <20211206020542.GS4216@dragon>
In-Reply-To: <20211206020542.GS4216@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c600cf8-46db-4890-2e8a-08d9b86e458c
x-ms-traffictypediagnostic: DB8PR04MB7084:
x-microsoft-antispam-prvs: <DB8PR04MB708414D44EB6B9F6502D8CCBE66D9@DB8PR04MB7084.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yWGmAMK80wg0M9vNXqU51QgYxmnmbcKBYgC4npuhYXQ5iSNjpSHxT9QKA0GlHExYJ+8/+58pPPPl2KN3GzkbWGrUdo+UHBUtZB06pj+BhJuW0JZrmDDnsuMIffDojKgHBnPidyKUzDTlYfEPXcS63HJTYpN5OYFyWkMfPvyWSezgkvo+Ae+BTdKZ6fp0Hu8fNATLQtaSJAwmNUXHUdmpGFadoPxD106N0E5BUbwv1XGC2Dpi68wSk7Mb+sYnEt6cE9yvj/U2in9kaRucVip9kLPU7gfE66GLqdrhQqxnx2QzK227ptIkHtcKiTulBufvsS495wXZDxqLkluarWEx8QQzuvJyt3rHSnDA3rwPZuoojdGepOcutPq+7YDXKwdS6MwsLXIO4vqnvjfQ7bTDFzOD80weswS1x74rlmFvX7Jm1nRA9cEL5/Qj5LUJNginaH4ZqgMLBV0NGv9ux83iXb++pXp0kyhmYGCJKwzCERNDjVvtedk9bcjSjBMlJvmefQ+Le9pvlKjQlXzJY/0ZmeOogUODOsxcI2cDF8D5zkkOiqof2RdnMVtp89M84YZEl3aFZdkYAahi0JZYUYXNhW81YPhGuXz+pKC3wqXBIr/YSmJxeq51EV96EJu/9ZLi2Bp7PjyrqKhixi432u/q2dxiAC/XdlSzJsc15qVxl2RNs3LV398ULpqQMZwJCZX70lJRS50id54kKdkm+8wmirjZIx3wrqan/HjN+qRDAPw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(76116006)(6916009)(5660300002)(316002)(33656002)(66446008)(66556008)(64756008)(66476007)(7696005)(38070700005)(8936002)(55016003)(86362001)(186003)(38100700002)(83380400001)(2906002)(53546011)(6506007)(71200400001)(26005)(52536014)(54906003)(508600001)(9686003)(8676002)(122000001)(4326008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QklIZlF1aXM1R3E3ZzJEM3RSZTJ3ZHg1NzIveWtLRW80QmVNejZPeVN3dGFC?=
 =?utf-8?B?eXhGS0pOQi96RVo2dlFqZVB2aTRuWjczTEpFdnppOVI3YkF1Y2FiMkRsK0Q5?=
 =?utf-8?B?a3FkWFh5V2hLanVWSWN2akhMRFFYakxlNzFlZWQ5UVpob3UzZDExSS8rc0xY?=
 =?utf-8?B?ZGtOVWtkY0dsTnppUkFFK1BNdmhLQ1BTSGl6TTBvdURUVUM5M2VYVkhkZ1N4?=
 =?utf-8?B?Rk1aUzhlOFlTaTJhS3RQMm9ORHlaYVRXRkdCaHFhV2w5R2xGWUZjL3F5Z2pU?=
 =?utf-8?B?VERCdzVhLzYwRmh0UkJyazZzRnRadDI4Vjl6VDBpdVBtU0JTRzg0cWsvNXdV?=
 =?utf-8?B?TS81U0xIMWdhZDA3RnF6TlN2S0VDNzBnZ2NKZ3NvbXJqdE5vbU1rQ3lFZkRm?=
 =?utf-8?B?RlYrSGpNbm5Wb01lcDR1cjJQRXhRL25MZHdSdUFUUmc4OGJ2a29STWRvaDlZ?=
 =?utf-8?B?dXgxWi80R1oyUTMrOTNUU1lLVFJuSmtJaEgreTJsazZoYUk3T2U4UldSKzRt?=
 =?utf-8?B?SmhwQTVJODJaL3M2d3lZR1lqY01CL01sL2FPR1lkTUVqOXBSK2VObnQyWlhR?=
 =?utf-8?B?NCtNOVFSVWNZUjU4RjRNT1pydlgrcHZ6cTNMeFpITmE1UGdCU2lOZythTk9s?=
 =?utf-8?B?UmNsY2s2UmxqUVZSOTJJaTdaOWZwN3VMOGk3MGtLaXM1aXZWSkk0WGpmR2dI?=
 =?utf-8?B?SkcwL0w1c1F0N1RVVlVGRlRmK2t0RDBBZnFEald1ckx6aWhITEkxdXJPRzk2?=
 =?utf-8?B?R3hLdUpYN2RJQmcvVWhXUGRMdTJxWkhtUm9ZM1hWR0N3ankxZ2hMRENKMkNT?=
 =?utf-8?B?SjdPVVVnRHZITjFxeEY3Z0p6UWpjeHBrVHFQellUUjRQQU1zb0FrNnlHWmI1?=
 =?utf-8?B?WFkxenpsUXJ3UG13Nm43NjVwZXFPbDFxdVU3SDByQWFIOFR0RVlKTnJTM1Yr?=
 =?utf-8?B?S2FGcHU2eE1aeGlmS21GbFFYQkRkY3lTb1JJTFZCZ2hhUWUvYm9qdUFoenRB?=
 =?utf-8?B?aTZxdXlHTlpGYWYxMW5TUTRNT0xkd1ZXT09rTWhXYzRLeCt6RTQxbU40KzYv?=
 =?utf-8?B?QWJFYmY0ZjRVZUJlcGEwSlNVQzVHU21JVUZaV2k1Ymw2WGlUMWlNcXRKeks3?=
 =?utf-8?B?UUlDeFFhNkNLTjNlUkxaWk9vTnJMeTZDWXZ1c2xOY0V0V2JEMU90emJqMnF4?=
 =?utf-8?B?R05pbDNxWUdJWUE3c2VNaW15RlA5SGpvSTZkMVNZYmt0V2JYaDlGejRIRDNT?=
 =?utf-8?B?S3FqRXJGOThVSEFsR0pwZGN4dlF5eWQ0akVuaGxxVklhVVdEclZ5b21odVFC?=
 =?utf-8?B?MWZ2SXIzS1dwazBEUWRTVmxjMXdzV3FpTGdQR0crVURZZ2FTeU1lRHRDTGtV?=
 =?utf-8?B?dXY4WDVOc2RxRk5VdWdXbnA5NlRqblMycStYMnVOdUVSZWk4N3hKYzZJSk1w?=
 =?utf-8?B?STRzcTJuT2ZVQ1owREZnYWJwRlhpZW9tL2JnYlNQbVdFT1RQM2RzdXJWWVpV?=
 =?utf-8?B?OWMwSEpQK3l0YnM0Mk0yR1NxdEtrak9pcXNOSG96Z1pKYmtHdkRrcjM4dU1k?=
 =?utf-8?B?MldmOUc2UTlSOHhyRXVULzcxaUhMWlpraFJhMS9jUTBKcXAzaDRqOW9wNklY?=
 =?utf-8?B?QVBwYVBGV09KaW9uUStuSE5aMHhxYUtCcUlhVzY4dnZIR2ZCK1dVNlFWUUg5?=
 =?utf-8?B?emdmVWIyRm9hWmQxQ1ZPK2dsT09sSjlPSGFBVUhXQmVES2kwaHpEM2hoZldE?=
 =?utf-8?B?Yi9MVStKR2xjQ2ZGZDBvMUZxQWVwc1lrSzJzeURWR1dIODhNM05wQ3lEcmlN?=
 =?utf-8?B?WnNJL0N3alQwOGEreFpTRnlaNzFTbzlaWXo2dHE3Z0lTdWNOdzFwK3hNdGpP?=
 =?utf-8?B?bGNtamQ1V0R3bDRIV0x2bU5HZGI1a0o5alFpakRKY0tLUVB6NDhud2EyY2c0?=
 =?utf-8?B?Uldub1gwd3JRdDNCdVNxbVpXRjJjVVZpeVUyYitaSE5PeUtHKys1UzI3TGlS?=
 =?utf-8?B?azBPdVNvYlpHaVBCaFZ2Nko0R0tuUi9tc25odHNJSE5aNFdSRzhacEM0MEJE?=
 =?utf-8?B?NkNxM1FFczFNM25rRis3Z0RNYVdpWUlvaGZ1OUtQclAwbCtZMG5oR2pyc3dF?=
 =?utf-8?B?b29XYnZ6bEh2U1dTNUkwV3JxWnBrb1F4dDlvT0NoZ2s1MWcva2d4bjZ0Vk0v?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c600cf8-46db-4890-2e8a-08d9b86e458c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 04:10:00.0492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIzAy721HqkxKDlGfuanjHbAZQVvgcLtFixmq6+/mXaI5S8Ffg0cJDRrwUMXQAn8/xxi03jBpUShB+kFQATZBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBTaGF3biwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3
biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjHlubQxMuaciDbml6UgMTA6
MDYNCj4gVG86IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+IENjOiBy
b2JoK2R0QGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBu
eHAuY29tPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzddIGFybTY0OiBkdHM6IGlteDht
OiBjb25maWd1cmUgRkVDIFBIWSBWRERJTw0KPiB2b2x0YWdlDQo+IA0KPiBPbiBNb24sIERlYyAw
NiwgMjAyMSBhdCAwMTo1OToxOEFNICswMDAwLCBKb2FraW0gWmhhbmcgd3JvdGU6DQo+ID4NCj4g
PiBIaSBTaGF3biwNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+
IEZyb206IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IDIwMjHl
ubQxMuaciDbml6UgOToxNg0KPiA+ID4gVG86IEpvYWtpbSBaaGFuZyA8cWlhbmdxaW5nLnpoYW5n
QG54cC5jb20+DQo+ID4gPiBDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlOw0KPiA+ID4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207
IGRsLWxpbnV4LWlteA0KPiA+ID4gPGxpbnV4LWlteEBueHAuY29tPjsgZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBT
dWJqZWN0OiBSZTogW1BBVENIIDQvN10gYXJtNjQ6IGR0czogaW14OG06IGNvbmZpZ3VyZSBGRUMg
UEhZIFZERElPDQo+ID4gPiB2b2x0YWdlDQo+ID4gPg0KPiA+ID4gT24gVHVlLCBOb3YgMjMsIDIw
MjEgYXQgMDQ6MDU6MDNQTSArMDgwMCwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+ID4gPiBBcyBj
b21taXQgMmY2NjQ4MjNhNDcwICgibmV0OiBwaHk6IGF0ODAzeDogYWRkIGRldmljZSB0cmVlDQo+
ID4gPiA+IGJpbmRpbmciKSBkZXNjcmliZWQsIGNvbmZpZ3VyZSBGRUMgUEhZIFZERElPIHZvbHRh
Z2UgYWNjb3JkaW5nIHRvDQo+IGJvYXJkIGRlc2lnbi4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogSm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gPiA+ID4g
LS0tDQo+ID4gPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0
c2kgfCA2ICsrKysrKw0KPiA+ID4gPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bW4tZXZrLmR0c2kgfCA2ICsrKysrKw0KPiA+ID4gPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVz
Y2FsZS9pbXg4bXEtZXZrLmR0cyAgfCA0ICsrKysNCj4gPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwg
MTYgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHNpDQo+ID4gPiA+IGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHNpDQo+ID4gPiA+IGluZGV4IDUwYjNi
YmI2NjJkNS4uM2JhYzg3YjdlMTQyIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tZXZrLmR0c2kNCj4gPiA+ID4gKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHNpDQo+ID4gPiA+IEBAIC0xMTcsNiAr
MTE3LDEyIEBADQo+ID4gPiA+ICAJCQlyZXNldC1ncGlvcyA9IDwmZ3BpbzQgMjIgR1BJT19BQ1RJ
VkVfTE9XPjsNCj4gPiA+ID4gIAkJCXJlc2V0LWFzc2VydC11cyA9IDwxMDAwMD47DQo+ID4gPiA+
ICAJCQlxY2EsZGlzYWJsZS1zbWFydGVlZTsNCj4gPiA+ID4gKwkJCXZkZGlvLXN1cHBseSA9IDwm
dmRkaW8+Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJCQl2ZGRpbzogdmRkaW8tcmVndWxhdG9yIHsN
Cj4gPiA+ID4gKwkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsNCj4gPiA+
ID4gKwkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsNCj4gPiA+ID4gKwkJ
CX07DQo+ID4gPiA+ICAJCX07DQo+ID4gPiA+ICAJfTsNCj4gPiA+ID4gIH07DQo+ID4gPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4tZXZrLmR0c2kN
Cj4gPiA+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4tZXZrLmR0c2kN
Cj4gPiA+ID4gaW5kZXggMzQyZjU3ZThjZjYxLi5jM2YxNTE5MmI3NmMgMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbi1ldmsuZHRzaQ0KPiA+
ID4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4tZXZrLmR0c2kN
Cj4gPiA+ID4gQEAgLTEwMCw2ICsxMDAsMTIgQEANCj4gPiA+ID4gIAkJCXJlc2V0LWdwaW9zID0g
PCZncGlvNCAyMiBHUElPX0FDVElWRV9MT1c+Ow0KPiA+ID4gPiAgCQkJcmVzZXQtYXNzZXJ0LXVz
ID0gPDEwMDAwPjsNCj4gPiA+ID4gIAkJCXFjYSxkaXNhYmxlLXNtYXJ0ZWVlOw0KPiA+ID4gPiAr
CQkJdmRkaW8tc3VwcGx5ID0gPCZ2ZGRpbz47DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkJCXZkZGlv
OiB2ZGRpby1yZWd1bGF0b3Igew0KPiA+ID4gPiArCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0
ID0gPDE4MDAwMDA+Ow0KPiA+ID4gPiArCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDE4
MDAwMDA+Ow0KPiA+ID4gPiArCQkJfTsNCj4gPiA+ID4gIAkJfTsNCj4gPiA+ID4gIAl9Ow0KPiA+
ID4gPiAgfTsNCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtcS1ldmsuZHRzDQo+ID4gPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1xLWV2ay5kdHMNCj4gPiA+ID4gaW5kZXggYTllMzM1NDhhMmYzLi5jOTZkMjNmZTMw
MTAgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDhtcS1ldmsuZHRzDQo+ID4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtcS1ldmsuZHRzDQo+ID4gPiA+IEBAIC0xNzAsNiArMTcwLDEwIEBADQo+ID4gPiA+ICAJ
CQlyZXNldC1ncGlvcyA9IDwmZ3BpbzEgOSBHUElPX0FDVElWRV9MT1c+Ow0KPiA+ID4gPiAgCQkJ
cmVzZXQtYXNzZXJ0LXVzID0gPDEwMDAwPjsNCj4gPiA+ID4gIAkJCXFjYSxkaXNhYmxlLXNtYXJ0
ZWVlOw0KPiA+ID4gPiArCQkJdmRkaW8tc3VwcGx5ID0gPCZ2ZGRoPjsNCj4gPiA+ID4gKw0KPiA+
ID4gPiArCQkJdmRkaDogdmRkaC1yZWd1bGF0b3Igew0KPiA+ID4gPiArCQkJfTsNCj4gPiA+DQo+
ID4gPiBXaHkgZG9lcyB0aGlzIG5lZWQgdG8gYmUgZGlmZmVyZW50IGZyb20gdGhlIG9uZSBvbiBp
bXg4bW0tZXZrIGFuZA0KPiA+ID4gaW14OG1uLWV2az8NCj4gPg0KPiA+IEl0J3MgZGVwZW5kIG9u
IFJHTUlJX0lPIHZvbHRhZ2Ugb3V0IGZyb20gU29DIGFuZCBQSFkgcmVmZXJlbmNlIGRlc2lnbi4N
Cj4gPg0KPiA+IEZvciA4TU0vTU46DQo+ID4gCVNvQyBSR01JSV9JTyBpcyAxLjhWLCBhbmQgYm9h
cmQgZGVzaWduIHVzZSAiUmVmZXJlbmNlIERlc2lnbiwgMS41LzEuOA0KPiBWIFJHTUlJIEkvTyIs
IFBIWSBkZWZhdWx0IHdvcmsgb24gMS41Viwgc28gd2UgbmVlZCBjb25maWd1cmUgUEhZIHRvIHdv
cmsNCj4gb24gMS44Vi4NCj4gPiBGb3IgOE1ROg0KPiA+IAlTb0MgUkdNSUlfSU8gaXMgMi41Viwg
YW5kIGJvYXJkIGRlc2lnbiB1c2UgIlJlZmVyZW5jZSBEZXNpZ24sIDIuNSBWLw0KPiAzLjMgViBS
R01JSSBJL08iLCBQSFkgZGVmYXVsdCB3b3JrIG9uIDIuNVYuDQo+IA0KPiBIbW0sIHdoeSBkbyB5
b3Ugbm90IHNwZWNpZnkgMi41ViB3aXRoIHJlZ3VsYXRvci1taW5bbWF4XS1taWNyb3ZvbHQgdGhl
bj8NCj4gQWxzbywgd2h5IGlzIHRoZSByZWd1bGF0b3IgbmFtZWQgdmRkaCBpbnN0ZWFkIG9mIHZk
ZGlvPw0KDQpUaGUgUkdNSUkgSS9PIHZvbHRhZ2UgYXQgUEhZIHNpZGUgY291bGQgZnJvbSBWRERJ
T19SRUcgb3IgVkRESF9SRUcsIGl0IGRlcGVuZHMgb24NCmhvdyB0aGUgZGVzaWduIG9mIGJvYXJk
IGFjY29yZGluZyB0byBBVDgwMzEgYmxvY2sgZ3VpZGUuDQoNCkFuZCB0aGUgcGh5IGRyaXZlciBp
bXBsZW1lbnQgdGhpcyBhbGlnbiB0byB0aGUgcGh5IGd1aWRlLiANCkNvdWxkIHlvdSBwbGVhc2Ug
aGF2ZSBhIGxvb2sgYXQgdGhlIGNvbW1pdCBvciB0aGUgYmluZGluZz8NCg0KY29tbWl0IDJmNjY0
ODIzYTQ3MDIxYWUwMjlmZTkxMjcyYWRiZjBhMjIzZTQ3N2YNCkF1dGhvcjogTWljaGFlbCBXYWxs
ZSA8bWljaGFlbEB3YWxsZS5jYz4NCkRhdGU6ICAgV2VkIE5vdiA2IDIzOjM2OjE0IDIwMTkgKzAx
MDANCg0KICAgIG5ldDogcGh5OiBhdDgwM3g6IGFkZCBkZXZpY2UgdHJlZSBiaW5kaW5nDQoNCiAg
ICBBZGQgc3VwcG9ydCBmb3IgY29uZmlndXJpbmcgdGhlIENMS18yNU0gcGluIGFzIHdlbGwgYXMg
dGhlIFJHTUlJIEkvTw0KICAgIHZvbHRhZ2UgYnkgdGhlIGRldmljZSB0cmVlLg0KDQogICAgU2ln
bmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCiAgICBSZXZpZXdl
ZC1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQogICAgU2lnbmVk
LW9mZi1ieTogRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KDQpEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3FjYSxhcjgwM3gueWFtbA0KdmRkaW8tcmVn
dWxhdG9yIGFuZCB2ZGRoLXJlZ3VsYXRvcg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcN
Cj4gU2hhd24NCj4gDQo+ID4NCj4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gSm9ha2ltIFpoYW5nDQo+
ID4gPiBTaGF3bg0KPiA+ID4NCj4gPiA+ID4gIAkJfTsNCj4gPiA+ID4gIAl9Ow0KPiA+ID4gPiAg
fTsNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4xNy4xDQo+ID4gPiA+DQo=
