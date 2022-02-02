Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1634D4A6FD5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbiBBLUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:20:47 -0500
Received: from mail-tycjpn01on2138.outbound.protection.outlook.com ([40.107.114.138]:15178
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343891AbiBBLUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:20:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLB2YjiYUf4zgmkotXJoHPG0zoWT+Px7YSE/GmGlHjgqSDYmAWmib+uHdMjeaO2Z5JfwQohjamhqkmFv6vL7h2Z85BbN2dJ8oxVT8rvJKBfPcpRumAyp9Jo1T8hkUukAgL123mMjohZR2NjQEKskIGQ6Jk8ydWiq84wJpDmgzZQhhWyReA1fBy4hGkknX3D9q810Sfi+Sed6f+Z4nF9t0x4/jY52NO8m+MDiQCzAuSUfEzfEddTxACMu2T7Btd7DQsiMfaEgLy3YTBzGbbB5oDGsHdaYuAKrMTgeR2auHSRuHS1zFl/sH+yp4T0lNoCx1SzCC1MW3M2r2CD4lSpe5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhYQ5NGqVBErIhfOfElKMQLZJFbG+RtfdhyEnx2yf3M=;
 b=WOHJVCCRmR9E/XteKeO2Ny8c04UHGWD3BJYrhVz+bxJRnK4N5iJrVxdasJEStVb/zdB2ozDFehfgbrGBUgKp21URCAviXvU/NSidYaqlQUs71+jlHp9q9owh0DttCQZnwN/mEqGrqPYQV8juNI9dD110NMbMDXSK2mRcps2TfsgTay4EFXxbxGdDGRCnG0Q50OexnhAGYBrSsLxs7/b00Pq/mLqg4vjYPI12BfhLKBJjDOsxxSB65QiNp5g9/c4n28Kd5m+ylCBQv8n8KQeo7cbN5yDBPCG0+iikoXerC9eKy4+Ms9fVx2e9UZHO3qX/veGasgt+ahT7nSAsjiCnsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhYQ5NGqVBErIhfOfElKMQLZJFbG+RtfdhyEnx2yf3M=;
 b=gh9HniQE/QiTw4yXlO6X/uA8pwCXg3wEE2owoEQjSc6rJ09GAn4dQNfu/+/0W//uztzFiiZ22lxjl/dEXfrceLgR55nupaSc6CZn/pVaSClfNX/G+Zl3a21QtJ++qsk6MeZzGe1cePXB72v01UCti7QV7h4se2iykA91QRAWrmU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB9770.jpnprd01.prod.outlook.com (2603:1096:604:1ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Wed, 2 Feb
 2022 11:20:35 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619%8]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 11:20:35 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: RE: [PATCH v2] soc: renesas: Add support for reading product revision
 for RZ/G2L family
Thread-Topic: [PATCH v2] soc: renesas: Add support for reading product
 revision for RZ/G2L family
Thread-Index: AQHYDmgBDN/uYbTGvkymPAofYTo7/6x2r/yAgAlkleCAABCggIAACzWg
Date:   Wed, 2 Feb 2022 11:20:35 +0000
Message-ID: <OS0PR01MB59226A1FEA2A836D885C93A086279@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220121014117.21248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUW+7mCLHnWbPQ4oxNO9Awri9TNN8bTDq7uGSYncAdWKw@mail.gmail.com>
 <OS0PR01MB5922ECB3E4DEDB2595D0101786279@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXw3Uy=jOivke6exPrUXg4a-yyg_Sg3ote48tqwTCwDzQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXw3Uy=jOivke6exPrUXg4a-yyg_Sg3ote48tqwTCwDzQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fa4dd1b-4cd8-4c6b-5b4b-08d9e63e08aa
x-ms-traffictypediagnostic: OS3PR01MB9770:EE_
x-microsoft-antispam-prvs: <OS3PR01MB97705A4F71C0B8B56A01DFD086279@OS3PR01MB9770.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:378;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ofh8b/0Iw63D07/7LBKVTSQR2pxefCiDIIp9m/x3CoDmUSa92UuNxf6itS5HgdMCpPwuq6C5RLGwpiIFJYtDqdIUn34aW/xHPPvgdRqamewpRYB0wUCRvka0iVadA0sB6JyLh0Kl89OG7oVqvcwV2oCfAGtliGGkWtabSIoiW9FJ7GRPdM/RIZRuiIPZAWVJVZENJhwW6QO8oVUX6W+l3J2h5++oFGOtFupwN6ZVFTRSWLRYaA3ZwNftRs3ic6KuEZ1jrpxyhvWR5lqjdKnJwaYZGTE34MURRJulQP+kH/7QeJahXEXE587d1aItJLTQP3la2OecpJoPzWun16bjRC5NskbMXS/qrmRT6ATPzlgQkQA4PhlJijLJyQpTarrfix6g2yyRh2iK348JIEf8W01cyNZ8OkY6qd/hfeIxy2q4FctWVktzfYnrMA4R3H7qKcfvr9E7UO0brrw4UQ7wIckwMoUSJnWGYCQI+JGphS1h3NtNJBcfKLoQ1PLyG7Qbl5Vum4mDX7/wTrYkVjMDz9rcCBGeVOKjiI2lZjJ9gF1yhRyLj6VXdR5qGd2aYMU74qgsotAK9fRPiKiU1S2K/5f49M5U8/Qd7KKiSXeAx4/5QUFF7/4F4dDW9aefR/dXtYBCCAs/BG+p2wuIBpAKYBgY9p6HrQx1QtpQI7g6dU6nJP3IENGFDzWzYaLP3cqvCUf6ncv8BIhZfVGH5QOBqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(186003)(26005)(83380400001)(53546011)(316002)(54906003)(2906002)(6916009)(38070700005)(55016003)(52536014)(8676002)(66476007)(6506007)(71200400001)(76116006)(7696005)(9686003)(5660300002)(33656002)(8936002)(4326008)(86362001)(508600001)(66556008)(122000001)(66446008)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym1zU0hwTWN6WForaS9tV2VhaVJLRXlWbEZLZzVsL1VwM2JZMlREd1U3VmMw?=
 =?utf-8?B?WFNaNUJpbmxKN3plYUpVTjYyT29BRUF4L0M0RC9USVVVUVNYeWZuK3dIRHJK?=
 =?utf-8?B?dThBM2gwVlJOMDU2cXhtamw2VFovOTJ5d3FuYWYvQS8xdU4rMEVTa2hxcjVN?=
 =?utf-8?B?ZzMzSE84TmlnUUlzQ0NhS2drMnpjUHI5ZkJSSHhHbm9YQUxqalRNUmJLWC9i?=
 =?utf-8?B?aWNUNzZpcU1naVNGWjNFZmxZVUxDdSt3SlNuZWlWR3pqWDNTbG9jbnB0aUhp?=
 =?utf-8?B?UWhPbFcvdElSM0hlQnJRcGpTbGZTWHNlWERveTFzaVhlcTlOQ01PYmhwOUw2?=
 =?utf-8?B?emc1UXZxdVRvMFBNOE4vME9sUnpyUUp3MCtSMHVMbFRsZjdYY1JtR1E4Qjdm?=
 =?utf-8?B?ZHk3bXpQZVZmZWhobDVRMFdFa0d3ZW11bGVtT1dQZWk1MTlNQzRZdWFYSWU3?=
 =?utf-8?B?WTVWSk11Yys4aU5LaGFiVDdEaXpjSnB3emlZNjFBeVd2RGpQSXhHQytWZTl0?=
 =?utf-8?B?WTZwK0M0M05RMEk5NGluaDBzYUFsK0tmbE1LZkhHbndPRCtmdDhKeWtzY05q?=
 =?utf-8?B?UmsxelBxVWNTaGpXT1QxZm1XVFdIaHhQMU93VEFvWHlhNm1UYlk2Z0h5VWY5?=
 =?utf-8?B?NTNJMStWa2NCZTI0OHdjMXhIUW1nL2tzZVFnZXB3NGVSb3dtVG1OaU83elA0?=
 =?utf-8?B?MjNsTFNlSWZWS0pHRVpSL2dDM3FleUhQaVYxbm1hT21LNFhKTmxmMEthZUwv?=
 =?utf-8?B?aGlzNmlMc1llVk0vL0JkaXYydnJTZWhUUDQ3bDY2SVJzd3N5UGxCQml3d2N0?=
 =?utf-8?B?emlaeWVmSlM1YmgyMkduR3k1REFFN1ovaWE1YnczUHZhNzVHTkV6RmlTWGNm?=
 =?utf-8?B?UFM3ZGlsQTdmekpqakEycWdZZDhEU1J0dThYSGxaRVBiQ05ENU42MEJMRm9j?=
 =?utf-8?B?bWtDTTZ2YkZUUWhkL0VjZVRWSVZHaGhZQzBDOU9EMkE5V3B4eC9jWXloZUtI?=
 =?utf-8?B?WjRiWFpVM3l5UzVsYk1yakN2ZzB1ZCsxcUVkZnMvUkZ1TlZmT01WYTAwc0c0?=
 =?utf-8?B?RGhCVmU1eWFjVVpSd1NxK1F6aTV5ZUdKVGx5YjRwSFg4TGpqSElnNEpiTlNX?=
 =?utf-8?B?VXVMclZwTGF5VWZIZFZ4cWEyMHZIaDEyVFBSaG1ENGNLSUFYRGtsN0xlcTVy?=
 =?utf-8?B?K2Voa2pjQ0NhTXp6NDNSNzJETkVJNS9kbTMyRzdZOEEzRHhwR2FJcEJsaW1x?=
 =?utf-8?B?NStJSWNsMUJhSU10b0ZLblVaWW9pbldxcXJJVTRoY081ZEw2cDVIbmpUWENp?=
 =?utf-8?B?ODE3bEZBQWlOTEpHdjlIa0FLeHY5VmhGV3U1MkhLRytTanUxT1VKNTFZbG94?=
 =?utf-8?B?L3ZxRWVkM0c0QVFqeDI2UWR0ajFwaEhoSlhqbTFVbUNmNFZCQXo5dWZUSG5m?=
 =?utf-8?B?OHdQdDJIdHVvb0M3ajU5ZVYrTWZxTXh2YXpHSUpxUTA1RW1PTDMweGdKcHow?=
 =?utf-8?B?SDhWM2JBZEZ3dk52Q2xXQVlVNitYVUlDTmlGL0JsNFFiNFI4QWxCQVQ1elRm?=
 =?utf-8?B?emhTUzdEVDZoNy8zYWY0RUZhWWlVelBZTjVnYnBBTG9HTkNYV3c4NmxoRFNX?=
 =?utf-8?B?aU5nVXBKUHd6N3cyb0p0YjJmMFMwMFBaTU5vWkF1VGpvMXNtOVNCaER5OTdm?=
 =?utf-8?B?bk82Tm5VRVp5S0FoTGFLdVFjY1hCRU9JMW9qa3c2aHpwaHQ2YVNFOUYyWE1w?=
 =?utf-8?B?RUdPM2h1ZUF5VWNoSFBUd0ZwT3M1SU54UXFnSXdESkRHZHhZT1RTT29kY3Ez?=
 =?utf-8?B?OEE3T0xzMnRrTmE3Z3JOalB5RUdUYnB1UEFGVnI1R09pYjBPcDZ2L3RzTnJY?=
 =?utf-8?B?TElMc1pPbFl2dFFSeUxqcWFmbEhwNGZGNTlLK0Zlb1VQbHRKa1ZibVNGSUpV?=
 =?utf-8?B?VUpFR3RJeFgrUmFobTJleWlvZnZvNExFWlY1ZDZqZlcwekFuMWxqSXdDY1pU?=
 =?utf-8?B?cDdmQXBMbG5ZS2J4ZXdHNjViZFk3S3BYKzZCZ1E4MUJDc2hnYnhGSjlKb1Z0?=
 =?utf-8?B?VHVNbG9XYTR0dUtMNWk2SGpWMDBnRWhMbWNPeDBtcUd5VitzWThtNE5jUGE1?=
 =?utf-8?B?R1BJZXdaWURDZmxyTGwvR21CVnlxSXJTZWZLQkhrcFFtV1hsSjNMQisvYWZW?=
 =?utf-8?B?TnVxbWg4WUJjNUFEeU9HR1B3ODMvbCt0YkQrVlE3eDUyNlREMVZEb3pYWWs4?=
 =?utf-8?B?Qy9GblAzeDNscmNYNnV3ck1xNk5BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa4dd1b-4cd8-4c6b-5b4b-08d9e63e08aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 11:20:35.6753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V6MrIE95SJ2SxgceqAHyCcMrXSN9Htwx/6u7xOES2QHBourl9NzdT5AZ7lJLO2bAiw1cj30AWQYvBu+WfpNSEXlmbjS4ASj9aIJX9SHjEIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9770
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBzb2M6IHJlbmVzYXM6IEFk
ZCBzdXBwb3J0IGZvciByZWFkaW5nIHByb2R1Y3QNCj4gcmV2aXNpb24gZm9yIFJaL0cyTCBmYW1p
bHkNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBXZWQsIEZlYiAyLCAyMDIyIGF0IDEwOjUxIEFN
IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYyXSBzb2M6IHJlbmVzYXM6IEFkZCBzdXBwb3J0IGZvciByZWFk
aW5nDQo+ID4gPiBwcm9kdWN0IHJldmlzaW9uIGZvciBSWi9HMkwgZmFtaWx5IE9uIEZyaSwgSmFu
IDIxLCAyMDIyIGF0IDI6NDEgQU0NCj4gPiA+IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5tYWhh
ZGV2LSBsYWQucmpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4gPiBGcm9tOiBCaWp1IERh
cyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IEFzIHBlciBSWi9HMkwgSFcNCj4gPiA+ID4g
bWFudWFsIChSZXYuMS4wMCBTZXAsIDIwMjEpIERFVl9JRCBbMzE6MjhdIGluZGljYXRlcyBwcm9k
dWN0DQo+ID4gPiA+IHJldmlzaW9uLiBVc2UgdGhpcyBpbmZvcm1hdGlvbiB0byBwb3B1bGF0ZSB0
aGUgcmV2aXNpb24gaW5mbyBmb3INCj4gPiA+ID4gUlovRzJMIGZhbWlseS4NCj4gPiA+ID4NCj4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
Pg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMYWQgUHJhYmhha2FyDQo+ID4gPiA+IDxwcmFiaGFr
YXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+IA0KPiA+ID4gPiAtLS0gYS9kcml2
ZXJzL3NvYy9yZW5lc2FzL3JlbmVzYXMtc29jLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9zb2Mv
cmVuZXNhcy9yZW5lc2FzLXNvYy5jDQo+ID4gPiA+IEBAIC00MDUsNDEgKzQxNywzOCBAQCBzdGF0
aWMgaW50IF9faW5pdCByZW5lc2FzX3NvY19pbml0KHZvaWQpDQo+ID4gPiA+DQo+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGVzaGkgPSAoKHByb2R1Y3QgPj4gNCkgJiAweDBmKSArIDE7
DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGVzbG8gPSBwcm9kdWN0ICYgMHhmOw0K
PiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBzb2NfZGV2X2F0dHItPnJldmlzaW9uID0N
Cj4gPiA+ID4gKyBrYXNwcmludGYoR0ZQX0tFUk5FTCwNCj4gPiA+ICJFUyV1LiV1IiwNCj4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBlc2hpLA0KPiBlc2xvKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIH0gIGVsc2UgaWYg
KGlkID09ICZpZF9yemcybCkgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBlc2hp
ID0gICgocHJvZHVjdCA+PiAyOCkgJiAweDBmKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgc29jX2Rldl9hdHRyLT5yZXZpc2lvbiA9DQo+ID4gPiA+ICsga2FzcHJpbnRmKEdGUF9L
RVJORUwsDQo+ID4gPiAiUmV2ICV1IiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlc2hpKTsNCj4gPiA+DQo+ID4gPiBX
b3VsZCB5b3UgbWluZCBpZiBJIHdvdWxkIGRyb3AgdGhlICJSZXYgIiB3aGlsZSBhcHBseWluZz8N
Cj4gPg0KPiA+IEtlcm5lbCByZXBvcnRzIHRoZSBiZWxvdyBtZXNzYWdlIGFmdGVyIGRyb3BwaW5n
IFJldi4gSXMgaXQgT0s/DQo+ID4NCj4gPiBbICAgIDAuMDE4Mjk3XSBEZXRlY3RlZCBSZW5lc2Fz
IFJaL0cyTCByOWEwN2cwNDQgMQ0KPiANCj4gVGhhdCdzIGluZGVlZCBub3Qgc28gbmljZS4uLg0K
PiANCj4gRWl0aGVyIHdlIGhhdmUgdG8gYWRkIGl0IGJhY2ssIG9yIGRvIHNvbWV0aGluZyBsaWtl
Og0KDQpUaGlzIGlzIG11Y2ggYmV0dGVyLg0KDQpbICAgIDAuMDAzNDI3XSBEZXRlY3RlZCBSZW5l
c2FzIFJaL0cyTCByOWEwN2cwNDQgUmV2IDENCnJvb3RAc21hcmMtcnpnMmw6fiMgZm9yIGkgaW4g
bWFjaGluZSBmYW1pbHkgc29jX2lkIHJldmlzaW9uOyBkbyBlY2hvIC1uICIkaTogIjtjYXQgL3N5
cy9kZXZpY2VzL3NvYzAvJGk7IGRvbmUNCm1hY2hpbmU6IFJlbmVzYXMgU01BUkMgRVZLIGJhc2Vk
IG9uIHI5YTA3ZzA0NGwyDQpmYW1pbHk6IFJaL0cyTA0Kc29jX2lkOiByOWEwN2cwNDQNCnJldmlz
aW9uOiAxDQpyb290QHNtYXJjLXJ6ZzJsOn4jDQoNCj4gDQo+IC0gICAgICAgcHJfaW5mbygiRGV0
ZWN0ZWQgUmVuZXNhcyAlcyAlcyAlc1xuIiwgc29jX2Rldl9hdHRyLT5mYW1pbHksDQo+IC0gICAg
ICAgICAgICAgICBzb2NfZGV2X2F0dHItPnNvY19pZCwgc29jX2Rldl9hdHRyLT5yZXZpc2lvbiA/
OiAiIik7DQo+ICsgICAgICAgcHJfaW5mbygiRGV0ZWN0ZWQgUmVuZXNhcyAlcyAlcyVzJXNcbiIs
IHNvY19kZXZfYXR0ci0+ZmFtaWx5LA0KPiArICAgICAgICAgICAgICAgc29jX2Rldl9hdHRyLT5z
b2NfaWQsIHNvY19kZXZfYXR0ci0+cmV2aXNpb24gPyAiIFJldiAiIDoNCj4gIiIsDQo+ICsgICAg
ICAgICAgICAgICBzb2NfZGV2X2F0dHItPnJldmlzaW9uID86ICIiKTsNCj4gDQoNCldpbGwgeW91
IHBvc3QgdGhpcyBjaGFuZ2Ugb3IgRG8geW91IHdhbnQgbWUgdG8gc2VuZCB0aGUgcGF0Y2g/DQoN
ClBsZWFzZSBsZXQgbWUga25vdy4NCg0KQ2hlZXJzLA0KQmlqdQ0K
