Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0494A6E1C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245596AbiBBJvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:51:32 -0500
Received: from mail-os0jpn01on2117.outbound.protection.outlook.com ([40.107.113.117]:16455
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245593AbiBBJva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:51:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3r6UnXZ69I9jGOkXhgTLiBsC+f/A9ZJF9jrc0cv3Gl713mPVLPR2+EKAh2jomHZn7f+Q6Jf+gEpNkLCIvLbGL6O8ZWMdBesAbxKBFeCmBPjDErZuUWwhK1XUD+tL3/vjGMDtUFYupdqOVop2hJ1IFUzuwQ10JCk6Vos8svn2bIeeG/9gB/RW7XztQKZLVXFxkwUhyMbmjBjAJfZBdeqdGuUuIQOEl/QCoA1fyij7+MeX36qMWuMWAubqpjUi/JTfGNCQXGSSfDnIOrvR6RteZlLx4uHqVid5HJp0tKV9+w7QQSifkyExdD4oWctxerFx7CPN3jK2B8hkltdETaB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6G/LMxfsJGRoQCD0Uin6+tTzPyeWMU6kwthZ0VkMays=;
 b=MPEVHvTVIkfMF0fMseZY5iPJpTqi8JGOFKGKlsCnErI9MDKNpqKa3y7QLJBAqM2odWvR/8xSO2gIJYndZLGqDoBZdsXVKDbclCWYTGltE9MbrTi+gCYNzWSfHQCR6Iv7zLESHF6OCMqIrMBUqOwcaGcL8HN6VePDvK8uOGdzOgeeamOeIIZ/JKrfT4T4hLF6WfNZyFgnkDB+/aZ4eD0ujoQ1uIQre2yuOHF4tAv+liJIZ+G9BBuIP7+S0o5L3OhweN9l69CT7ngeb7qyvIgwRahZcM8HnG+SDwOSOetE89HO2ICFJ872QKOGV6SDIVoCt6cYe0HpShfZgIOHl+F94A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6G/LMxfsJGRoQCD0Uin6+tTzPyeWMU6kwthZ0VkMays=;
 b=hh3TQel4Jbw+ZZoVSi/vF0ia7f/cqdI10iZ4gFj+XvrhDrn0gvczg6D8pfZuG44t+abXP4EHbaaMPghjz0jdRJjtiVFl7MfYRxhJgHxC/1EyB/C7TPQI/zKHgf72mWTrg5OrRhINrp3a77Ti9Kl3sw/oxoNhOgctEC0V/Fnv2UU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5247.jpnprd01.prod.outlook.com (2603:1096:404:120::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 09:51:28 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619%8]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 09:51:28 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC:     Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: RE: [PATCH v2] soc: renesas: Add support for reading product revision
 for RZ/G2L family
Thread-Topic: [PATCH v2] soc: renesas: Add support for reading product
 revision for RZ/G2L family
Thread-Index: AQHYDmgBDN/uYbTGvkymPAofYTo7/6x2r/yAgAlkleA=
Date:   Wed, 2 Feb 2022 09:51:28 +0000
Message-ID: <OS0PR01MB5922ECB3E4DEDB2595D0101786279@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220121014117.21248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUW+7mCLHnWbPQ4oxNO9Awri9TNN8bTDq7uGSYncAdWKw@mail.gmail.com>
In-Reply-To: <CAMuHMdUW+7mCLHnWbPQ4oxNO9Awri9TNN8bTDq7uGSYncAdWKw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 812a9c4c-fe68-4ba6-1e09-08d9e6319563
x-ms-traffictypediagnostic: TYAPR01MB5247:EE_
x-microsoft-antispam-prvs: <TYAPR01MB52477544A88C9C555C84862086279@TYAPR01MB5247.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GPVcFQnJlfOfOb4r39AzJnRp4NCFIqngYTrwQ2QwWFGuP0m0vk27QQjUyUHjn/REAs9NgVViV1HXzvRTixkxIufr5NMK9pLPJMeLOaawSg1DMFudVpdLyTSIBFmiTY9++f+j4V3BfoVpEsov/Xrzf33c2/ffdvgCfrMpclNk6RwH01J4autXolg/XXHVtr35tK2vfjFL+jdsFFStIcZrAu5d8PEwp3DDosDn/kynumF/U5qjAXGuGgHpfZpLdxGxLgTcbk3uFoQKZHq68/VJ76bZMW5dsoYooZIhHp+Z0CjWIMwGRp0CB4QvSNEfOf3Ty/s9j4dbuq20PuggxsJp92rAHxzlHpzvSZM1IMW2qA7NwS5IAyZVP2J4fl7DdzizKwxwOdS7yMpnURLv3DcF5N9y56KZW4op+r+Dn/RSFAaWQw0k+7A3bAWbRD4ysvjpbz35KYLKq8eFGuiURcnONjmd3imNtHWcCPjil8ivqzqddbzS69GHbmx7BkIKnSFPsaTtbuVf5uyCU9SPLIaOtgyDh8j00FLaHH2rOyaWio9/OcCScXiBrPMZ22vaPOfJpylJlmdULB8vIh/Ogh6vZ+g5phMfPsE/ebfXm+MV0OrAHE4qkXuixj4cl+cjP/1Cs1MquGkx27XjkdZhHsBiesEt9+bupcNcU+fdQDOAUH7sctRh79ZPmS3tSRu81wZ81O0YXSJ/Es928opdhzSOfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(7696005)(66946007)(6506007)(55016003)(53546011)(508600001)(52536014)(66476007)(66556008)(64756008)(66446008)(4326008)(76116006)(5660300002)(83380400001)(86362001)(33656002)(38070700005)(110136005)(54906003)(26005)(2906002)(6636002)(9686003)(316002)(8936002)(8676002)(71200400001)(38100700002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU91RTgxK0VEa2pKOCtvakVocWZ2NjNyaGNXelduUGVTQU01SlJESTRlQ0Rh?=
 =?utf-8?B?ZmlXeGlPekIwMVBPQTI1VmkrZ1YxR054akJqSVo0bzJiTXQ2NW4rOVc3T0Zu?=
 =?utf-8?B?ZnptcTNkanpUQW5tbUtFakdaZ0RTbm1HRitGTlZHVDloS3FBdThpMG92dFox?=
 =?utf-8?B?cUR4aEo3dXE2d3lyT1NEczdzUk5wZUtBTkthR01ZTjFLR003b2pKVzBKZllx?=
 =?utf-8?B?WFRoT2M5eTNzZFVCUXdubmc0MCt2bGZ1NGZORGd1Z2FlWkNNcTE1dVlzTmVY?=
 =?utf-8?B?QU1WdVhmOVlqTlYvaFZvRkJ3NjFXM0RYZlhlVUNCQ004bm4vM1U5SUtJRG5S?=
 =?utf-8?B?bEg0VUZTNU83TlM2THpIdGpDd1A1UGp2eXRSVHpaMTVFbHJuYUVrRDF5dnBT?=
 =?utf-8?B?aWQzdjRPbjM5OVViQWtsZUhtV04vQTFXSDd5SDNSa3RHSFdweHMvNEVnYTJN?=
 =?utf-8?B?Vk40bkpXSTZ5TlRRUnh6YU5xcGJXSUswVlZwMWZCaE8yV2ZESm1qcUovM2tW?=
 =?utf-8?B?RnNFNC8yMWErRTBGV0VuVGw3TU1xZVo3ZGszNWNCWGZIUmpFVmtXdGtNYWFU?=
 =?utf-8?B?VjlKVEh5Tm9IcTZpK0UveVF4QjlQL3hEMDFGU0xBU3VFbVZoT3ppeGI2VUc0?=
 =?utf-8?B?a2I0YUVsTVBXanI2R3lUa3Y1ZS91d2R1eEV5YnRnQkdCM2pZV3NwQzlodDI3?=
 =?utf-8?B?RkEwL1h2akZvdGhabWZMWHpQUGw5Zy9kOVVIL1E1c3NFdHN3SnZmMzVhNnBn?=
 =?utf-8?B?ajhXTmtPVDlsSm1lWTBKQlRLVCtHRHBWV3JCMVowdlVMTG5QMVdPUjZ0RXlY?=
 =?utf-8?B?K25ZRThOM1V6MHVHUDFNOTIrckRnNWpBSnllNXI2Q2E0cVdHTTlJbkUrUnp3?=
 =?utf-8?B?WWlkTURoY2psT253OFJJMUpENkJyYThaWk1ieEFxckliTWYvTjBsNXRUR2Rr?=
 =?utf-8?B?SC81ZU1BRVRReGlLanF3akpqRTFMU09mVjBYbitYcmRMUkU3bEZHWkNGWjB6?=
 =?utf-8?B?eVBZY1BTRkcrUnM0NlFLUFJoanJNOFIxenBkbTNYRHpKMVhvbHRDT1NCNkMv?=
 =?utf-8?B?dVc2YUhsWDJMQ3U2c2xjaVZQQjh2WEs1dTlhaVdCZjByUWM5WmlMeG41cnU1?=
 =?utf-8?B?NFlJaGxIWUltS2MzWk1ORzgvZ0NKQ2RFUmY0cW5CeS9jaTNPbzdIVnErYUJJ?=
 =?utf-8?B?UW52NnEyNU1wd3pEbTBtc0gyTXFFZStzSDhvK0NmOVZPK0g3V2tVVWtlalVV?=
 =?utf-8?B?TVRqRlZFRTZHQ3F5K0hOQi8rWEhkTzl2RkxQQnhJM29UL2VTdjJWaHhqV0U4?=
 =?utf-8?B?ZDRDRi9jR01vTFZVYWlQeVZjRnNmdlI4M0lPM2Z2d09oR3ZDbHZDY3BSZGZ3?=
 =?utf-8?B?ZW9YMlpUL2tKYkpjenhMemJ4T2lZWU9ZNmoyWmk0VVc2d29uV2k5T1VlK0NG?=
 =?utf-8?B?MFpBNUplYm5yWmFSc3FjZVR3Ym1obGtMZ0Q3MUVMQUFtZmdNZUlROWsyMldV?=
 =?utf-8?B?Uk5JVTlZUWljRXpML0JTNWZmdmRWNzZsSVkyMi9DWXRwNG9rbUduclpaNmUy?=
 =?utf-8?B?SDRqc3ZmSlFGYXdud1FmcFVNMUpuOVl1VWhFSjZEQjFsa3h4bE4rTDZkN0w3?=
 =?utf-8?B?NDlybkNBRWdOOWZGOFRTeHEwNitrQis4cVk0dW13cWhqSzlneUtzTjBwWldW?=
 =?utf-8?B?Z3VmKzJGQ2xsdUZBWHR4dHBxRTVDaDJHVE8wRE8wTE5vRmxjVWI4alRGSXBv?=
 =?utf-8?B?b1BKbzZ4aCtBVW5vVXViWVhRcEhSSTF5NHB3UzQvTmd4WHp3OU1LZ0N5UGNt?=
 =?utf-8?B?aHVIMmZqdTVKQ0ZtZThDL3pyMjduUFhjZHR5TEkzWjMxVmtVQlFabzhjWjkv?=
 =?utf-8?B?dERKZUQzZVlwSkRTek5xSFE0R0FseU5DQ2xncGpnM0xqcnRrMDZvanJrVllr?=
 =?utf-8?B?Z2haWm5LR3dCVjI5eHIzdDlGQ2lKTGVWVzcvc2E1K1BjcHNmNlMzNW0xc3Nm?=
 =?utf-8?B?ZUx0UWxEdnNUcWxDZGN6Y05qQnhFcEtjMWx4aDBuZFpWeVBjMWVzOUVRejRV?=
 =?utf-8?B?Um1KZzdGNlBSNXJiVWhLWGNtTzF3ZmplUWdRbWdKVlZCL1JtSmEycFVWV0FO?=
 =?utf-8?B?TUNkcVBmOS9YazRhYlAxQWNHRm5QTkhsUXdFYVNnVzY5em91UEt5ZE82Mlg4?=
 =?utf-8?B?alJKczhwSy82cVZiRk8zZHVNQkx0ZzlFZ1pDeXRLc1NHOEhPd1pheXpWR29Q?=
 =?utf-8?B?MWtLcXQxZHZkb2tZOGFzVXJ4ajBBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812a9c4c-fe68-4ba6-1e09-08d9e6319563
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 09:51:28.3097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4N1vt5oF5XVXH3HdJrsks3VCmkaCAFDpN1pZZGIyM6RcH7HrYALMg/iDM7h/GJYNX0E/Q7IsfxRdIXT4Adqv4g7ZgfgNu0o2qd9yHDXsBfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5247
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gc29jOiByZW5lc2FzOiBBZGQg
c3VwcG9ydCBmb3IgcmVhZGluZyBwcm9kdWN0DQo+IHJldmlzaW9uIGZvciBSWi9HMkwgZmFtaWx5
DQo+IA0KPiBIaSBQcmFiaGFrYXIsDQo+IA0KPiBPbiBGcmksIEphbiAyMSwgMjAyMiBhdCAyOjQx
IEFNIExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5tYWhhZGV2LQ0KPiBsYWQucmpAYnAucmVuZXNh
cy5jb20+IHdyb3RlOg0KPiA+IEZyb206IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2Fz
LmNvbT4NCj4gPg0KPiA+IEFzIHBlciBSWi9HMkwgSFcgbWFudWFsIChSZXYuMS4wMCBTZXAsIDIw
MjEpIERFVl9JRCBbMzE6MjhdIGluZGljYXRlcw0KPiA+IHByb2R1Y3QgcmV2aXNpb24uIFVzZSB0
aGlzIGluZm9ybWF0aW9uIHRvIHBvcHVsYXRlIHRoZSByZXZpc2lvbiBpbmZvDQo+ID4gZm9yIFJa
L0cyTCBmYW1pbHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMu
anpAYnAucmVuZXNhcy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGFkIFByYWJoYWthciA8cHJh
Ymhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+IHYxLT52
Mg0KPiA+ICogRml4ZWQgZnJlZWluZyB1cCBzb2NfZGV2X2F0dHIgaW4gZXJyb3IgcGF0aC4NCj4g
DQo+IFRoYW5rcyBmb3IgdGhlIHVwZGF0ZSENCj4gDQo+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0
ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPiBpLmUuIHdpbGwgcXVldWUNCj4gaW4g
cmVuZXNhcy1kZXZlbCBmb3IgdjUuMTguDQo+IA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL3JlbmVz
YXMvcmVuZXNhcy1zb2MuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL3JlbmVzYXMvcmVuZXNhcy1z
b2MuYw0KPiA+IEBAIC00MDUsNDEgKzQxNywzOCBAQCBzdGF0aWMgaW50IF9faW5pdCByZW5lc2Fz
X3NvY19pbml0KHZvaWQpDQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBlc2hpID0g
KChwcm9kdWN0ID4+IDQpICYgMHgwZikgKyAxOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IGVzbG8gPSBwcm9kdWN0ICYgMHhmOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHNvY19k
ZXZfYXR0ci0+cmV2aXNpb24gPSBrYXNwcmludGYoR0ZQX0tFUk5FTCwNCj4gIkVTJXUuJXUiLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZXNoaSwgZXNsbyk7DQo+ID4gKyAgICAgICAgICAgICAgIH0gIGVsc2UgaWYgKGlkID09
ICZpZF9yemcybCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGVzaGkgPSAgKChwcm9k
dWN0ID4+IDI4KSAmIDB4MGYpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHNvY19kZXZf
YXR0ci0+cmV2aXNpb24gPSBrYXNwcmludGYoR0ZQX0tFUk5FTCwNCj4gIlJldiAldSIsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBlc2hpKTsNCj4gDQo+IFdvdWxkIHlvdSBtaW5kIGlmIEkgd291bGQgZHJvcCB0aGUgIlJldiAi
IHdoaWxlIGFwcGx5aW5nPw0KDQpLZXJuZWwgcmVwb3J0cyB0aGUgYmVsb3cgbWVzc2FnZSBhZnRl
ciBkcm9wcGluZyBSZXYuIElzIGl0IE9LPyANCg0KWyAgICAwLjAxODI5N10gRGV0ZWN0ZWQgUmVu
ZXNhcyBSWi9HMkwgcjlhMDdnMDQ0IDENCg0KQ2hlZXJzLA0KQmlqdQ0K
