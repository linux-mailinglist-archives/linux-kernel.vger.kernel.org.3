Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4121C4A7236
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbiBBNvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:51:55 -0500
Received: from mail-tycjpn01on2092.outbound.protection.outlook.com ([40.107.114.92]:7552
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344861AbiBBNvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:51:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uh9R5iY7G9/bcVNyxDGv1gkJbbuHtD1cQW5DJTHifVnl9Z0QA83Uk7ivh+mCyUKhMVRP8kQI/H5EAfZzgStsJize0rHJBixMuiztB6aATOKdrcuZJQj3gpoKMAHwDQt3Ns/6jb7gA+RTLKojklwbCiO/7ka1WCPubNNRIOCricWS8bYYdyn6MBPyqiuZtnmZCNbMFTH5rbbl99XF52mFm/Egr5j2ArkPhdzfdvrrU8biZZRoz8/vVhZUJqEdqlk/RQQ9hCz/t58cYLrPFDw3HreKCy6MHvtN8Lo7F3ZVadP9fGPDUlG6kHBXD/Y1fSpTSqi1DnZQJBwvgjSteNuZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhDFZxrugWTjwIFJLhSnnTmvMjSjC+al4rocfmN0R1U=;
 b=l61Hgf+2s34oAzN6vOXJ+0lVN1ozZ+qewdpGONFstXb+s7GarBPpwlKLy+Z9THCG37GB9SsDyLQBSlm2X3dEUWRQS2178sjSq55NaqmdGF843L0e52tSB6dSzgnDTrWl5gnDIp/SZfEM4sYxge/GJQ1SueX61ims+wuXYxTDGEzPI87+h2TyGpe3nJfvYeXyKocHsdHQ9cy43n/DBnX2cHI6Fl4BzKt4PymZwGTBQaNqZulucvPfMkt7HoQVypV4u2+Fst/ekOCbCwSeh4co5JHZOH3k+HoD632judAMcOSXFcpBdqRhWemZhbnelqrTc9qxDyFeVrehUGc8fIyJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhDFZxrugWTjwIFJLhSnnTmvMjSjC+al4rocfmN0R1U=;
 b=RySbJW2iD26WoLBcl+0//GWTqoLo3WCjBaz/kJMNSw3PhcQnvifnqI+Kuw1CMuTDD5rQ6eb7k3SUBEBDKutgMqQmMWqhQh5qou3CNZkUD9K9NRLOAGqnyPX9BWfFWF0Mdl59IGc7SZSJKV2h/UlEyFA/zv5fpBYvHd5ncxY886k=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8678.jpnprd01.prod.outlook.com (2603:1096:400:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 13:51:29 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619%8]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 13:51:29 +0000
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
Thread-Index: AQHYDmgBDN/uYbTGvkymPAofYTo7/6x2r/yAgAlkleCAABCggIAACzWggAAmo4CAAAPrAA==
Date:   Wed, 2 Feb 2022 13:51:29 +0000
Message-ID: <OS0PR01MB592274CF43055727D0AE68DD86279@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220121014117.21248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUW+7mCLHnWbPQ4oxNO9Awri9TNN8bTDq7uGSYncAdWKw@mail.gmail.com>
 <OS0PR01MB5922ECB3E4DEDB2595D0101786279@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXw3Uy=jOivke6exPrUXg4a-yyg_Sg3ote48tqwTCwDzQ@mail.gmail.com>
 <OS0PR01MB59226A1FEA2A836D885C93A086279@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdVOWrc5i508wedtVndTTndZ_sW8=CDUWX1qg=Tmpie-fA@mail.gmail.com>
In-Reply-To: <CAMuHMdVOWrc5i508wedtVndTTndZ_sW8=CDUWX1qg=Tmpie-fA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9ab6986-6261-4ba3-5798-08d9e6531d27
x-ms-traffictypediagnostic: TYCPR01MB8678:EE_
x-microsoft-antispam-prvs: <TYCPR01MB86786DA4CF59E838644F2BDD86279@TYCPR01MB8678.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Ugwfj3taPRLPqjtgXduKdu1Dt6SeUvxs24t7CuLptkalNUI2ogvtmsbD+4RFZ4jkePxDlC+RwcTaFgx0FlglYDVb4AFK92JX705w7DaOPXlqZkleORSCSeEXleVAVRtrwSV5+ARUe0E6FX5IoZNggrrgWBtJz4JPTwgbDZ6wOwd3f/zpjp/ZsctG9AnRgfqOekmwweUqTuaOmcINmSApfTaAitfTe2a8ucoEiombaMNYozyQsFpaYniLNIUqd33FVDq+mSpYX8nWrgE0ZQwl5ztm87LaF5N0vsYHf4OiIKkR2GL7Em2NFFDWCZfsJpSNNmPUKI2INylbvf6ZdsrXxGD20HBAMv7oaBPIG5A/Nr/L/YGZGiWi8SmJii9t6/cO9OesvhFuhpF/3oNcXNGqra1vvAWw8p2P0coD6jX64VsCApKT7aMFeoV1zW491c1c94u8PdGY6W2FNz0Pg0i3Yezjr9pWfucSrPyGFpPz4tDjr6YEyfYT6fpRwApQh4ULAfdEnrLoXeJrTsUn/TJLE5TXmrtkLe3M3FOtcqx/Mck15tx3sv/Kr6y/KEi0+idbFmMh6Fwqg6f62gcUD2ZY8sOQ4DJav07VuMgz/FnM/obakY5RaujbNxFgNT871G41J3lZlnciSRGXstliXTltzJcYgnnlYqzyKhDo6MRtvLAb40xfml3hCACQs/YAm1pLySqXcK8EKqwwAiAZzcsmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(38100700002)(71200400001)(66446008)(53546011)(4326008)(26005)(54906003)(7696005)(6506007)(66476007)(66556008)(6916009)(9686003)(64756008)(316002)(186003)(33656002)(508600001)(122000001)(83380400001)(55016003)(66946007)(8936002)(76116006)(38070700005)(5660300002)(52536014)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWtPUXU3TytBemNrSWNUT3ZkRzh6SGt3OGpTWWs2c1JNclB5OHJJaEJxYlA2?=
 =?utf-8?B?OGRTaHVqQkZ6eURqN2MzVGdpUjg2V3F3ejAwVzRjZVNGUG42QVRIMHFLOFZ4?=
 =?utf-8?B?YUtjai9ZcXVjTlBselRDcFpvUGR6VTVsbEpoYXBuWUhZZ1psdzBjc214NHE1?=
 =?utf-8?B?a21FS2lNK1NEWHFOZGlxdEZVOEk4dXNuMndHdzdDOVhTTThuaW9IdzVZUUx1?=
 =?utf-8?B?WmthbTg5MW4rclhGRUxIcDdkWEpLVTJlUWtZa0c2VHlUcWNjY0U5UExVQVdH?=
 =?utf-8?B?YmhuQUdqcGdRTUFmUWVKTk5TMXJHM0poMzFndTViWlFJZ1ZHTnUrNWVLbVFY?=
 =?utf-8?B?MFF0TkU1dTNWZGlHcGV2cVJZMk54TVRsR0Vkc09kT2xieWdMNU9Kc2pFUXBK?=
 =?utf-8?B?WnBURzdDM2xldFltTTVtZm9XdmExLzRQZElJRkk5MzRwRHl4V2xOT0ZGVGc0?=
 =?utf-8?B?bGg0NGFZYzJJbEltWjdEK0tvSW53TEJTbFVlRm0rNFdVSUoydkQ2TVoyYTlp?=
 =?utf-8?B?YmJ0U1daZyt6UjZZanhGVXVoek52KzQwam1ZcU1ucW1DaWl5Q2JCRi82K2xU?=
 =?utf-8?B?aWxwUU8rZzJwa0QyUXpaS3ZaZVNqSDdWMzJFNk1nQ09GYjQ1WTVKbHdPekVa?=
 =?utf-8?B?RTJpdkg3ME03aXQ2TU53Q0luY2UzS0poQ3V2WE5pQWY5QWlqV3lhNTJ1YXN1?=
 =?utf-8?B?U3pSVXFSREUzV050dzdHMUU3Q0FUY0dUQ2hkZ0ZBbWNNeDQrMjh0dTdOZnpu?=
 =?utf-8?B?M0dadDZxeFMwcXBOTVBwd0dWZ0QzZVJLTmJtc0E5UTUrSnJQc0djVm10dkZm?=
 =?utf-8?B?UkRkK2RFUGkzcDJmMXZXVUI4ZlFZWEs4VHFsK2ZZVGxadzZ2R1h3MXgxektB?=
 =?utf-8?B?OVhnaE5MY3JqTjhKWHdmNHA1THFvSkw2bXFPMCs2V1RnU0Y3RW1rS2habnRr?=
 =?utf-8?B?RHNieWtuVk5SazVMTU4yVmt0ajhNNzdTRVI5TXMwbXBueElyYUU2bGk3alpH?=
 =?utf-8?B?S0FhaGM3M3FvTGpsWHA0TE0wQ2xxQUhTdDBhdjZBNjV4czhpMmpYUkVJRElq?=
 =?utf-8?B?TzZaemlCUzN1QVovNG81M3ZoRGNQYnNndWRLTHk1cjFnU01yUUJLZ2QvUEVr?=
 =?utf-8?B?OFIwUEwwYTdHMEt2MmtkOUptdzZWMzBuZ1B6eGRrQksvckJKZXFWeEk5MmQ3?=
 =?utf-8?B?S3lNTXZMekZxdThGdUNhR0dOaEVzVnRDaTUxclhFeUxsaTBOMlFBVkdNOFJJ?=
 =?utf-8?B?WktZVEljNjFkeW5YTHhDbUJhTVF2WjJ4REJOaG5vVlNGVEQ2TWcrZ0prQ3cw?=
 =?utf-8?B?UDFyeEVOTGJPUllXSXUvRURUdG1sU0VURklRdUxELzUyaWliNGMwQ1huaGtz?=
 =?utf-8?B?OWRhUkRqYTVEUUFBYzN0bS9vcy9OOW1CbDIwMmFJVTFQcHRVY3YvR2VNdmJq?=
 =?utf-8?B?aTBFYytqeUhaTGZOQWZzdEZNb002T1ZpN09uWm04d2YrYXEyUksvZk96Nzhi?=
 =?utf-8?B?eWgvZGN4VlpJM0JBUHZuTS8rQUsraFNCS0tEWkxrOGQ1L0FrSklJWkhzazRX?=
 =?utf-8?B?R1puMVdWR2FlOGNVdmtBeDM3VE9zWWhtaFpid0ROUHlvZ0xDc1MrWDRueXVn?=
 =?utf-8?B?OWZJcTlPbVd3YkpCaWhFSENCNzJYdUJaSDEwOW1FZWx5UVVYTEVzN05jTnhh?=
 =?utf-8?B?SUdqVVI2OXBWUDdtSG54THpxcHVKeXB5OHBvUC9hSmZjdlZ3VjFwcDIybE1F?=
 =?utf-8?B?NDFMcDdWN1dXenhBNHY5UFcwR21iRkVuSWVFcG1WdXdnZ2ljRTU1S1N1RUVn?=
 =?utf-8?B?ZGkvTTIvWWtDK3pjd2cxdHJBdUsza0g5VGluNURFVWppMmVXbkZnUmZ1dmFm?=
 =?utf-8?B?T04wR2M5TG5YWUwvTWdXaFNRa0tpVEp5MUZjNjlYU3dWbm5QMDAzdlJ5RTM4?=
 =?utf-8?B?bC9DZ1hOZWRWMjJDeDF1eG9lbUVJYWRYYVRmNmkvemZhSGlJYkIvbDM4LzBx?=
 =?utf-8?B?MGg0YUJzWEFia3ZlK2VSZTI1TkRjSmFYdFRzblVRWFkvRzdlSFQxTVV2YlFM?=
 =?utf-8?B?cTBKSHhxbjgxTG9UcFNEd25KM0JDdWJXem1EVnR1ZGJSZE9KemNoZndLSmd1?=
 =?utf-8?B?T1Y0UmFWM3VjZHpqTGRjMnJQM3lad3hUMUVhS1ZZbnhRRll6ZWJndG9uazVO?=
 =?utf-8?B?QWlGT29LT2pDZ1ZoN291K0dHL1ptQXQ2dEcxcUlSM1N6SC9tSXlhcXR5S1hj?=
 =?utf-8?B?QnQ3eXM4eVZrM3JoTFQ4U2kwMy93PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ab6986-6261-4ba3-5798-08d9e6531d27
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 13:51:29.4333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NkvAkdyoy4StbCOcFW1HEFD2l3GQJBIatC40NgF0iqM/eK922gqktuBcUpqsZ9/yPSpkQnVsXS6bEBFQcnYQCMQlhVr8G2i+hXTfzJcSM6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8678
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gc29jOiByZW5lc2FzOiBBZGQg
c3VwcG9ydCBmb3IgcmVhZGluZyBwcm9kdWN0DQo+IHJldmlzaW9uIGZvciBSWi9HMkwgZmFtaWx5
DQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gV2VkLCBGZWIgMiwgMjAyMiBhdCAxMjoyMCBQTSBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+ID4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2Ml0gc29jOiByZW5lc2FzOiBBZGQgc3VwcG9ydCBmb3IgcmVhZGlu
Zw0KPiA+ID4gcHJvZHVjdCByZXZpc2lvbiBmb3IgUlovRzJMIGZhbWlseSBPbiBXZWQsIEZlYiAy
LCAyMDIyIGF0IDEwOjUxIEFNDQo+ID4gPiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNh
cy5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBz
b2M6IHJlbmVzYXM6IEFkZCBzdXBwb3J0IGZvciByZWFkaW5nDQo+ID4gPiA+ID4gcHJvZHVjdCBy
ZXZpc2lvbiBmb3IgUlovRzJMIGZhbWlseSBPbiBGcmksIEphbiAyMSwgMjAyMiBhdCAyOjQxDQo+
ID4gPiA+ID4gQU0gTGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1haGFkZXYtIGxhZC5yakBicC5y
ZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiBGcm9tOiBCaWp1IERhcyA8YmlqdS5kYXMu
anpAYnAucmVuZXNhcy5jb20+IEFzIHBlciBSWi9HMkwgSFcNCj4gPiA+ID4gPiA+IG1hbnVhbCAo
UmV2LjEuMDAgU2VwLCAyMDIxKSBERVZfSUQgWzMxOjI4XSBpbmRpY2F0ZXMgcHJvZHVjdA0KPiA+
ID4gPiA+ID4gcmV2aXNpb24uIFVzZSB0aGlzIGluZm9ybWF0aW9uIHRvIHBvcHVsYXRlIHRoZSBy
ZXZpc2lvbiBpbmZvDQo+ID4gPiA+ID4gPiBmb3IgUlovRzJMIGZhbWlseS4NCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVu
ZXNhcy5jb20+DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMYWQgUHJhYmhha2FyDQo+ID4g
PiA+ID4gPiA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+ID4N
Cj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvc29jL3JlbmVzYXMvcmVuZXNhcy1zb2MuYw0KPiA+
ID4gPiA+ID4gKysrIGIvZHJpdmVycy9zb2MvcmVuZXNhcy9yZW5lc2FzLXNvYy5jDQo+ID4gPiA+
ID4gPiBAQCAtNDA1LDQxICs0MTcsMzggQEAgc3RhdGljIGludCBfX2luaXQgcmVuZXNhc19zb2Nf
aW5pdCh2b2lkKQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGVzaGkgPSAoKHByb2R1Y3QgPj4gNCkgJiAweDBmKSArIDE7DQo+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICBlc2xvID0gcHJvZHVjdCAmIDB4ZjsNCj4gPiA+ID4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHNvY19kZXZfYXR0ci0+cmV2aXNpb24gPQ0KPiA+ID4gPiA+
ID4gKyBrYXNwcmludGYoR0ZQX0tFUk5FTCwNCj4gPiA+ID4gPiAiRVMldS4ldSIsDQo+ID4gPiA+
ID4gPiArDQo+ID4gPiA+ID4gPiArIGVzaGksDQo+ID4gPiBlc2xvKTsNCj4gPiA+ID4gPiA+ICsg
ICAgICAgICAgICAgICB9ICBlbHNlIGlmIChpZCA9PSAmaWRfcnpnMmwpIHsNCj4gPiA+ID4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIGVzaGkgPSAgKChwcm9kdWN0ID4+IDI4KSAmIDB4MGYp
Ow0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgc29jX2Rldl9hdHRyLT5yZXZp
c2lvbiA9DQo+ID4gPiA+ID4gPiArIGthc3ByaW50ZihHRlBfS0VSTkVMLA0KPiA+ID4gPiA+ICJS
ZXYgJXUiLA0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyBlc2hpKTsNCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IFdvdWxkIHlvdSBtaW5kIGlmIEkgd291bGQgZHJvcCB0aGUgIlJldiAiIHdoaWxl
IGFwcGx5aW5nPw0KPiA+ID4gPg0KPiA+ID4gPiBLZXJuZWwgcmVwb3J0cyB0aGUgYmVsb3cgbWVz
c2FnZSBhZnRlciBkcm9wcGluZyBSZXYuIElzIGl0IE9LPw0KPiA+ID4gPg0KPiA+ID4gPiBbICAg
IDAuMDE4Mjk3XSBEZXRlY3RlZCBSZW5lc2FzIFJaL0cyTCByOWEwN2cwNDQgMQ0KPiA+ID4NCj4g
PiA+IFRoYXQncyBpbmRlZWQgbm90IHNvIG5pY2UuLi4NCj4gPiA+DQo+ID4gPiBFaXRoZXIgd2Ug
aGF2ZSB0byBhZGQgaXQgYmFjaywgb3IgZG8gc29tZXRoaW5nIGxpa2U6DQo+ID4NCj4gPiBUaGlz
IGlzIG11Y2ggYmV0dGVyLg0KPiA+DQo+ID4gWyAgICAwLjAwMzQyN10gRGV0ZWN0ZWQgUmVuZXNh
cyBSWi9HMkwgcjlhMDdnMDQ0IFJldiAxDQo+ID4gcm9vdEBzbWFyYy1yemcybDp+IyBmb3IgaSBp
biBtYWNoaW5lIGZhbWlseSBzb2NfaWQgcmV2aXNpb247IGRvIGVjaG8NCj4gPiAtbiAiJGk6ICI7
Y2F0IC9zeXMvZGV2aWNlcy9zb2MwLyRpOyBkb25lDQo+ID4gbWFjaGluZTogUmVuZXNhcyBTTUFS
QyBFVksgYmFzZWQgb24gcjlhMDdnMDQ0bDINCj4gPiBmYW1pbHk6IFJaL0cyTA0KPiA+IHNvY19p
ZDogcjlhMDdnMDQ0DQo+ID4gcmV2aXNpb246IDENCj4gPiByb290QHNtYXJjLXJ6ZzJsOn4jDQo+
ID4NCj4gPiA+DQo+ID4gPiAtICAgICAgIHByX2luZm8oIkRldGVjdGVkIFJlbmVzYXMgJXMgJXMg
JXNcbiIsIHNvY19kZXZfYXR0ci0+ZmFtaWx5LA0KPiA+ID4gLSAgICAgICAgICAgICAgIHNvY19k
ZXZfYXR0ci0+c29jX2lkLCBzb2NfZGV2X2F0dHItPnJldmlzaW9uID86ICIiKTsNCj4gPiA+ICsg
ICAgICAgcHJfaW5mbygiRGV0ZWN0ZWQgUmVuZXNhcyAlcyAlcyVzJXNcbiIsIHNvY19kZXZfYXR0
ci0+ZmFtaWx5LA0KPiA+ID4gKyAgICAgICAgICAgICAgIHNvY19kZXZfYXR0ci0+c29jX2lkLCBz
b2NfZGV2X2F0dHItPnJldmlzaW9uID8gIiBSZXYgIg0KPiA6DQo+ID4gPiAiIiwNCj4gPiA+ICsg
ICAgICAgICAgICAgICBzb2NfZGV2X2F0dHItPnJldmlzaW9uID86ICIiKTsNCj4gPiA+DQo+ID4N
Cj4gPiBXaWxsIHlvdSBwb3N0IHRoaXMgY2hhbmdlIG9yIERvIHlvdSB3YW50IG1lIHRvIHNlbmQg
dGhlIHBhdGNoPw0KPiA+DQo+ID4gUGxlYXNlIGxldCBtZSBrbm93Lg0KPiANCj4gSSdsbCBzZW5k
IGEgcGF0Y2gsIHRvIGJlIGZvbGRlZCBpbiB0byB0aGUgb3JpZ2luYWwuDQoNClRoYW5rcywNCg0K
QmlqdQ0K
