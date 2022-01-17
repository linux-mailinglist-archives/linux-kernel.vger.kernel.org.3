Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F81490361
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbiAQIAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:00:53 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:21152 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbiAQIAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642406440; x=1673942440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AD/vVBI0RI1qNKceKwizWJifdy9F1NT+1AvhatRQB7Y=;
  b=1tZ+8kyWFIoKvTOTaME5JT5VQRTcX2F7qqSF4x2w2jz71vK6zyw4rUNb
   1x9/3rV8Hk5klupQlOqja+F0CEDgciMluo1tQRz5P+ZJ/UeePas82Ql20
   YBi8woOFfutCfk3N8XY2B/dx/vg+7Ecs+vfoR/T8K3/ki7jxJLLZeyCrY
   Bkn2BniR7ELzzrdTv72c6YkewrnAWMMcVctVKYRIUnaA7HaU1CgB9CpUp
   daNK8zQO1vJB1pI467P5BEby6kFDTvV+xye1d1miY73T5pdGcOu38y1NZ
   uIUqP0Tt2jesijrLBeaxu0i1H2V0RMypEekU0cii9uPImHK9rMnU+Y7Sb
   A==;
IronPort-SDR: H6+0AowWtcMwLRYRotpX4hENg1amETQyJ0ZbljfIY28p60TU3HDSY8XbLvtYOmLDl04CONnUYb
 RbleDb4qj2He0vNEHghbhQypwNYeHtUm+rDrM3LoQ9d41LIIkzCEKZYed6NYS7wuJB0cVFM8vY
 qyQ4oeAi184aSQadD8ZcPpGCmoeZTUDqY4fSt51YpQ2ZaSV6/7y37smvgsZP1zvf/l+ys9xeXu
 4KjOtHLN3lj9/5Cw57GpR6lPnFQRnHQo3Eblor5ttPlG1CTt6aVRpjQ2jHWGgoA5cRICxyoJKQ
 Xh4=
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="82694778"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2022 01:00:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 17 Jan 2022 01:00:36 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 17 Jan 2022 01:00:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EI3WgcihNaxtc8EXroA0d6iFk9xAlFKwIziNkS/sW64/ufDAkyOmCOjs45h/sLcfSGkp1IwZco8N9QoJ9boKq41fpkQku9oFItxhvMkUbF33wxT1AgEAlwhvbhqQ+9C+UOw9/VBaU3fR74Nq64DY6NzBkmHfP4BgTWTUOh0CMGyjH5cW2XavJhBw3z/sP0kuianQX9EXk260f4gQ6rb5M1V/QCouEDiyVltuIMDzLkkZJsmmobnQL2ljLP4s9mruI3EG9JB2xxA/PeIfcDRegn0FZREnmIfAqyXWEDv188Rp2ddbitYH8lEjcm5qCa+F44CPs/M36T0Ywu/JTXPRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AD/vVBI0RI1qNKceKwizWJifdy9F1NT+1AvhatRQB7Y=;
 b=lGpPXru6tVU2+gaXI6gYxXXWOGd1yyAlXjvJP9vCaaycSURbB4sogq7Eu3kkkjeNyKH/g6piCpZrlyw58SlETMWcFUuwj8M15acup+Fhe73+IwnrzPiUkpDSG/khr5pzoP5II7lWWJxNpo2IIko0baAc6hkNf8X2zajoi0uf3mOa+lxBdD5OOOdYr0ICvPtxbI4lGVSw2pRM+ZqHV7fkOUnQOFgiDLyFZp2tsvpx8o6Ew4qR9KH/w+TApPWwl//gSOFcZOqDWLl2dl4NVCr7eGAER9IHTYf/S24Rp6jgIZEGi/2iyYX2xsXf5Vy6lK7iFaSt32CqLiAta8IdaGr4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AD/vVBI0RI1qNKceKwizWJifdy9F1NT+1AvhatRQB7Y=;
 b=Gln4FnA1KoAloGOI1PV8y0ooylgW8hui1y6o2S2JASMWhW7rulJxEp04dZ15sYVIxnbANeLGLmkOh/A0V3jDXzFn2/lrmcOJSafe+Bc2j5gTOsdt2z74Bq1RJWQ1TiMAEQPHcOBecoKrGR7LsYuke8O+kCJ2flnaTPd/cO18J0g=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3375.namprd11.prod.outlook.com (2603:10b6:805:c0::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Mon, 17 Jan
 2022 08:00:34 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 08:00:34 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <Ludovic.Desroches@microchip.com>, <linus.walleij@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <robh+dt@kernel.org>, <andy.shevchenko@gmail.com>,
        <prabhakar.csengg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] pinctrl: at91-pio4: Use platform_get_irq() to get the
 interrupt
Thread-Topic: [PATCH v2] pinctrl: at91-pio4: Use platform_get_irq() to get the
 interrupt
Thread-Index: AQHYC3hOw/S2RLQwTkiAt9gM8FZr0w==
Date:   Mon, 17 Jan 2022 08:00:34 +0000
Message-ID: <241bd054-ea30-ffc9-fb36-c30c8e06db7f@microchip.com>
References: <20220104140913.29699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220104140913.29699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e03c69d-0f5c-4746-9475-08d9d98f7093
x-ms-traffictypediagnostic: SN6PR11MB3375:EE_
x-microsoft-antispam-prvs: <SN6PR11MB337597679528646C7DA92141F0579@SN6PR11MB3375.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3KJt3Fmw5wM2WBT/5WNSWE8Dtos7HQratUeqo+AdL0/ZcGZDU2WsrZRqM4RFJ7KHGQsl3rGql1EJWYbIXzTS5UoQI1m0QsOAK3kN0xcG1R2TknHGWDd8EyYGmvPRLSE3oaxjCiStsFrIN9U04MqJq+TPgkJjbkB1C7y9DyDE92K33XswPvMojKNY3nU/zoRdAuDK+G+SXuHycuoKlJM30oy7Cbe1nB1HN+5YniJX+LWNLrHguLdJcUSemJljo4DejyVcBGyef+IxB92ilMK681DIikIkAGKiVx3u0v+QBWuXbQee2zemSNLjmB7xheVJW+/bk/KmO40UxwgBp8E9LfsabEnsD7N9NOZjul133limgzO/QEwCg70eMq6yNZJ7iNQKsfCecF2IWFOXHEJwdMUI/sVr7sxafrJIqEA1HeQ0e4UMegyfyjfd2x+ezK0yCVXbi1cJbjbDaIzusDE80nBhYnxtuJlkbYn4YA9fMULJdT58DtUtkmB0WpAnGXZwdoV3sqAIWKZSVl2woYh8Q8SqiJoPptskAg6fP3iVSVQR6b6yH7t5T2bQLCFDYWsCB/8884axW3OtEz+r1DV5I0h1SCNtPZ9f+Ld3auiqtNE//MZgorhFuFW0vdqBaLXXXanDkEsUOBQsng7yK1NHEyg4wICyWLvsJlJi5dhat8U6vcVRdygVLQdh9DMFfVIEO4n0VjRixhU3TavAPaJOUoi46VTN0S0ICtWJ2k5xsj4kCeD8Plm1XPsgiFtUtujFxR+QQZE7KcK+6DzBXWE0zHnPJV2t/thhxi65xHop2ANNdWlaEFa5v6CgIao3yiAmaVd4SdLlOvDwg502c4cnr4oYpEGgo91q5gTxh9weaITtibnMhNchY1MeLcUiXAeXFt6cGhCflYttt7/S94z2PQALUNU8ntVYiKPnzm/sgWg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(110136005)(38070700005)(36756003)(2906002)(31686004)(6506007)(4326008)(53546011)(71200400001)(2616005)(6512007)(66556008)(26005)(122000001)(38100700002)(186003)(5660300002)(66946007)(76116006)(91956017)(64756008)(66446008)(8936002)(66476007)(508600001)(31696002)(6486002)(316002)(966005)(8676002)(86362001)(83380400001)(15583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmQrUUhrQWV6bGtBaEZ6ZWlDRFh5eDdyUHREaGM3a2ZtalV2aXIzVHlLSGVR?=
 =?utf-8?B?aWRtNnZzS0tYOVFVQmFYY3ZGeTduTGo0MzdkWnJ5c0xCdi9pTng1OWJVM0FG?=
 =?utf-8?B?Tk9IUE1mMUcrZFhycXdZa0hHb29KbEdoWG9hL3dWdUpjTFlMZU5zZVZxU041?=
 =?utf-8?B?QU9oZktUdEdWUFFJVndKOVhiRTVQcmFMZGRPTEV0VEtmb2h1MzhIZFRvNlV1?=
 =?utf-8?B?cVM5UjFSV3M0bUxmd0VCMG9LWUN0KzVNYzZvdVNEYzB4NWF6YU1qR0h6bXlx?=
 =?utf-8?B?UVZadWJLSzhqNDFPQnQwbzBMRysrQUt6SXAxclhvU2dzcmgzYkE4bXMrajRM?=
 =?utf-8?B?RzkwUWlHaWYrY0Y2SFpqRm50ZmFqZ3VwNHAwclEwZ05OMW1aRzI4T0Rubkh5?=
 =?utf-8?B?UGx6TEkySWN0aXl3eHNtMldoenRpcE8yYU8zTmpwRUFMVWtoZnRwVTZTL2FP?=
 =?utf-8?B?dmNrV3dRY0J4dGF1bVB1cU4rTFpINndoVzJURzVSTlpSZHdNczh5Tnc5VjI5?=
 =?utf-8?B?Qm1wU3JuTld1azh1TlpVSHhyUzUzdmxCaXZiL3V1ZTJMbjd4cXVmNHZQM0lP?=
 =?utf-8?B?S0ZEajhoWWgyMWh4MWZ4cERvS0dZeVFVeHFHK0pmbDh3Q0hCWklGbE8ydDRj?=
 =?utf-8?B?TDVPNUMrSjFDMVVpSUtzc3B6RFkvbDdNRUxINWpGWUFERW94eEIvaHg0cmpW?=
 =?utf-8?B?TzJsT3MwM3NCbk5pL2ZTSDE5WWxlMVBtYTNqMElkbHQvL2QyM08xY1hIOEVu?=
 =?utf-8?B?WmMxa0dacUl4S3E5K0ZYUDg5OGkvY24waTJnWVNOY0ljT2F6L3NicTdKeUhQ?=
 =?utf-8?B?Ky9MeG9ZL2E4bFRKK21Welg2b2lNbVdMYmgzNXVGd0JQbkE2by9BNVBEenRP?=
 =?utf-8?B?S1lTSlVjWlJkUnVCMkk5bVRJSEVwdDBrbmY5eWJMVnE5SlZ4NXFUejY0dWNQ?=
 =?utf-8?B?U1RiZzdJdks3MnZ0ek8vUHBmTnl1VDNhbWRLZzJpVmVtNDJmZzdVS1B2WVp4?=
 =?utf-8?B?WDNaKyt4Mk1tbHhzZGtPekhsREplSEdFN1ZXVjdpbU1pTlJiYk11U2RHVWRt?=
 =?utf-8?B?b2lTYUdrM1pwUDlHTUxqbkJHRnNMdW5pVlI1Y2NvdjMzcHJaRTVPZ2prUmts?=
 =?utf-8?B?bE4wNG1CSHAvN25qMkk1azhzYlV5M0J6SE14SVhsWE14aUJZRzRhdGhkZ29G?=
 =?utf-8?B?dm1BdlI0QXlHM3Y1NGFBZWtXaHlTQzNFMHJoU2M2L0N6QXJ3YXdPNXRjTE9Z?=
 =?utf-8?B?OWdINnhrT0JwdjF0QzFIM2FkN2EwQUMwMlVkTjI2cFhSRjlZWis3ckJMdm5J?=
 =?utf-8?B?Q3dZamtiQzA3WHlwRzJkWTBKdVZJZ0FLSHVNQUZ3NUMzaFJMNXBOY0tvWjlY?=
 =?utf-8?B?bVhsOWg3V3VRekR2SmQyZFlCcUpKZXo3UzhlVWNqMDlHYW9QSjd2Rm43K3RS?=
 =?utf-8?B?SUZkR2RwZFhxNHo5VEMrZGlmLzNvNFpkUXFWOVRtTE1kZzBRZ0kvbDVHL01r?=
 =?utf-8?B?SW1QdWM2M21KdEl3Vzh1RytPZ3kvVWpjUjZmNnpueDRlY0krcnVuazNrVHlm?=
 =?utf-8?B?NUFLQVI1WndaNFVXZURRNGV2blFrVmg4SDFBemhnV3BrSUQxeEhndGtmUUhI?=
 =?utf-8?B?MkVjSGZ3ZE9YSHhxV1VnWFpTUDVzYjZFTUc1Z01XN2sybmVLNG1hTVYwV1FJ?=
 =?utf-8?B?RkdPZkZ0MjZ5UVUzUkJUcWYwcmRCQW1wUktEQlprZ1NtQyt1bmlHaUxBUytN?=
 =?utf-8?B?ZTVjY2MzeThreVJxL1ZqV1hpUjZYb3plajl2SDZta1Z1TzJTcmYvdiszNS9N?=
 =?utf-8?B?ZGkxeWttRnZ3Si9MK01wVDJOeEVFUVFkQURSL01jdVlPQkdTUXRldkwxTkI3?=
 =?utf-8?B?MEpzV2FhZitPR001anN5Q0I1RHJlcHIvTUZPZkM0R3dLaHNQeUZNNE4zMmpB?=
 =?utf-8?B?VEhGd0JiNHZVMEh4K2RBR3diL2lUQlhlMFBnWU42ejBwSkxOMnprcDZPUUtE?=
 =?utf-8?B?RDdZd1JZZW9LUDdxREt4aTBxRjlEblhubFR5aDNSTld4NW1iYTZRR1g3NHQ0?=
 =?utf-8?B?TWw0Wkh6OTFiY3oyaGh4bTJkMUx3aVB2WlUzUmpnb2p3N0s0YTZyaXJtOHBD?=
 =?utf-8?B?ZDc3NU5TZXRVcE9IaE50UEMvbkFBZGpvR2Y3MDBLSXE2cE96STIwQUVtQ1M3?=
 =?utf-8?B?bHJ3T1ZLRzFENVZNK2l2QTBRYWRqU2tGaEU1YkpZUXNEaTFHYjRGWTZ0WEsw?=
 =?utf-8?B?cjRPQzVLbnBKSXlqck1sUjhJd2dnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F76AE7533BD8443BF854D330382D2E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e03c69d-0f5c-4746-9475-08d9d98f7093
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 08:00:34.0552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fqn2XqxLcHwUr+h7YdXvQbtHZ35QVQWXBNoJ8VULA4cO0osczrObnn69dnGTQI3XEsHM4eg1EMIGH+ssIa6uCg9oNYaJhrZBT7iszM/3nKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3375
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS80LzIyIDQ6MDkgUE0sIExhZCBQcmFiaGFrYXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElP
UkVTT1VSQ0VfSVJRLCAuLikgcmVsaWVzIG9uIHN0YXRpYw0KPiBhbGxvY2F0aW9uIG9mIElSUSBy
ZXNvdXJjZXMgaW4gRFQgY29yZSBjb2RlLCB0aGlzIGNhdXNlcyBhbiBpc3N1ZQ0KPiB3aGVuIHVz
aW5nIGhpZXJhcmNoaWNhbCBpbnRlcnJ1cHQgZG9tYWlucyB1c2luZyAiaW50ZXJydXB0cyIgcHJv
cGVydHkNCj4gaW4gdGhlIG5vZGUgYXMgdGhpcyBieXBhc3NlcyB0aGUgaGllcmFyY2hpY2FsIHNl
dHVwIGFuZCBtZXNzZXMgdXAgdGhlDQo+IGlycSBjaGFpbmluZy4NCj4gDQo+IEluIHByZXBhcmF0
aW9uIGZvciByZW1vdmFsIG9mIHN0YXRpYyBzZXR1cCBvZiBJUlEgcmVzb3VyY2UgZnJvbSBEVCBj
b3JlDQo+IGNvZGUgdXNlIHBsYXRmb3JtX2dldF9pcnEoKS4NCj4gDQo+IFdoaWxlIGF0IGl0LCBy
ZXBsYWNlIHRoZSBkZXZfZXJyKCkgd2l0aCBkZXZfZGJnKCkgYXMgcGxhdGZvcm1fZ2V0X2lycSgp
DQo+IHByaW50cyBhbiBlcnJvciBtZXNzYWdlIHVwb24gZXJyb3IuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5j
b20+DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hp
cC5jb20+DQpUZXN0ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlw
LmNvbT4NCg0KdGhhbmtzLA0KdGENCj4gLS0tDQo+IHYxLT52Mg0KPiAqIFN3aXRjaGVkIHVzaW5n
IHBsYXRmb3JtX2dldF9pcnEoKQ0KPiAqIFJlcGxhY2VkIGRldl9lcnIoKSB3aXRoIGRldl9kYmco
KQ0KPiANCj4gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMTEyMjQxNDU3NDgu
MTg3NTQtMy1wcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20vDQo+IC0tLQ0K
PiAgZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS1waW80LmMgfCAxNiArKysrKysrLS0tLS0t
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0OTEtcGlvNC5jIGIv
ZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS1waW80LmMNCj4gaW5kZXggZmFmZDFmNTVjYmE3
Li41MTdmMmE2MzMwYWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0
OTEtcGlvNC5jDQo+ICsrKyBiL2RyaXZlcnMvcGluY3RybC9waW5jdHJsLWF0OTEtcGlvNC5jDQo+
IEBAIC0xMDQ1LDcgKzEwNDUsNiBAQCBzdGF0aWMgaW50IGF0bWVsX3BpbmN0cmxfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAgICBjb25zdCBjaGFyICoqZ3JvdXBf
bmFtZXM7DQo+ICAgICAgICAgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqbWF0Y2g7DQo+ICAg
ICAgICAgaW50IGksIHJldDsNCj4gLSAgICAgICBzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gICAg
ICAgICBzdHJ1Y3QgYXRtZWxfcGlvY3RybCAqYXRtZWxfcGlvY3RybDsNCj4gICAgICAgICBjb25z
dCBzdHJ1Y3QgYXRtZWxfcGlvY3RybF9kYXRhICphdG1lbF9waW9jdHJsX2RhdGE7DQo+IA0KPiBA
QCAtMTE2NCwxNiArMTE2MywxNSBAQCBzdGF0aWMgaW50IGF0bWVsX3BpbmN0cmxfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gDQo+ICAgICAgICAgLyogVGhlcmUgaXMgb25l
IGNvbnRyb2xsZXIgYnV0IGVhY2ggYmFuayBoYXMgaXRzIG93biBpcnEgbGluZS4gKi8NCj4gICAg
ICAgICBmb3IgKGkgPSAwOyBpIDwgYXRtZWxfcGlvY3RybC0+bmJhbmtzOyBpKyspIHsNCj4gLSAg
ICAgICAgICAgICAgIHJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNF
X0lSUSwgaSk7DQo+IC0gICAgICAgICAgICAgICBpZiAoIXJlcykgew0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICBkZXZfZXJyKGRldiwgIm1pc3NpbmcgaXJxIHJlc291cmNlIGZvciBncm91cCAl
Y1xuIiwNCj4gKyAgICAgICAgICAgICAgIHJldCA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgaSk7
DQo+ICsgICAgICAgICAgICAgICBpZiAocmV0IDwgMCkgew0KPiArICAgICAgICAgICAgICAgICAg
ICAgICBkZXZfZGJnKGRldiwgIm1pc3NpbmcgaXJxIHJlc291cmNlIGZvciBncm91cCAlY1xuIiwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAnQScgKyBpKTsNCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiByZXQ7DQo+ICAgICAgICAgICAgICAgICB9DQo+IC0gICAgICAgICAgICAgICBhdG1l
bF9waW9jdHJsLT5pcnFzW2ldID0gcmVzLT5zdGFydDsNCj4gLSAgICAgICAgICAgICAgIGlycV9z
ZXRfY2hhaW5lZF9oYW5kbGVyX2FuZF9kYXRhKHJlcy0+c3RhcnQsDQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgIGF0bWVsX2dwaW9faXJxX2hhbmRsZXIsIGF0bWVsX3Bpb2N0cmwpOw0KPiAtICAg
ICAgICAgICAgICAgZGV2X2RiZyhkZXYsICJiYW5rICVpOiBpcnE9JXByXG4iLCBpLCByZXMpOw0K
PiArICAgICAgICAgICAgICAgYXRtZWxfcGlvY3RybC0+aXJxc1tpXSA9IHJldDsNCj4gKyAgICAg
ICAgICAgICAgIGlycV9zZXRfY2hhaW5lZF9oYW5kbGVyX2FuZF9kYXRhKHJldCwgYXRtZWxfZ3Bp
b19pcnFfaGFuZGxlciwgYXRtZWxfcGlvY3RybCk7DQo+ICsgICAgICAgICAgICAgICBkZXZfZGJn
KGRldiwgImJhbmsgJWk6IGlycT0lZFxuIiwgaSwgcmV0KTsNCj4gICAgICAgICB9DQo+IA0KPiAg
ICAgICAgIGF0bWVsX3Bpb2N0cmwtPmlycV9kb21haW4gPSBpcnFfZG9tYWluX2FkZF9saW5lYXIo
ZGV2LT5vZl9ub2RlLA0KPiAtLQ0KPiAyLjE3LjENCj4gDQo+IA0KPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsDQo+
IA0KDQo=
