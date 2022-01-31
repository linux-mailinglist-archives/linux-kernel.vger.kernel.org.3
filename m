Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7C64A3E51
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 08:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbiAaHsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 02:48:43 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:19011 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiAaHsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 02:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643615321; x=1675151321;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KQ/O34yLn3QJ7rKlF5CKpUnnTEFNJr6dJhE/ISHqFmg=;
  b=FzDbRq0TagB1sLKAg3GwL4921w/PJndJEsrqZQ8jWbUasW91rV//it+t
   5oUZnfQ3wAsiFPke0R1bgmZAYpJHj3W0YTWKl/DyU0mpPKLshcpY4qxf4
   /3dr+lsu+6iED/a/8iSvSVnCOoQ+O3Ed1jsR2+s9I2lFwmAmdIV9cIZef
   QHkvSASO/mPvYONtgriJisYi12J9vsXaKCbBxA9Ke3wYkOKMZoCGdYXTW
   8HSQpyAiolQZcgvCpLjEY68A7fl1JvQF+of4Ry+RN6uNa9pXFQE3GNHMx
   XdbaFzK+3Cfh+ctOYYOwbnXzzMZ2Ck/+VOBjRSTXot2ecgy3YjQQcD7Bf
   A==;
IronPort-SDR: e56PgCSc0SkanuU0p80Jcic3AE2zYlo0+c+PnHbZ/qAp3BMqYgTe8fK7lboMn2jC9ZK7feVTPT
 OgwecRchutFpstsv7/eqsba9jZ19aF0jYnHMEikNijb4OtB3qyvldBlSouHhPoSMpwvoPmg6LM
 POijFu6fI/9kJwn5eRBSOPdtGYbNj85OgujCmlr3bZaSY5wcz6ZQ+eD3SJLeEzPBjjeVB3BplH
 vItquLmk7Xe7upMslut6Ryf6o/GyOujJbJ7/GWVj0fX9rxo78Ut9KWFMV4r2/0Abg8p59DL6Un
 qZO1oEAeP77Iu5jNkEBanPJ9
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="160525664"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jan 2022 00:48:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 31 Jan 2022 00:48:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 31 Jan 2022 00:48:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfpH7/s0vSgwIutPxuyhmVVMCvKkIgdD2zvRLks+oDRWdKREIUQjvTz6+DWFHszxhBAvLUPVfVHTsXWQdUqpgyOtvjdhA1navquiSKh3QMxghvLranFAKf3//h+rSjvoTQ69GjQz8hhBMSZ1lQTh0PWjF+J8wH/2z3/xIlURB8Z6rFtybSCEE4wrEfz4m0CwrbnBpHiQxna3Ox9Z7Liuqr0QdX/EskMMfteoMPf0AWRc3n0YqslNG/2MN18e2obl8eHcwLBN7HZMDKg0gKYbbCiHaMD+YmkVqKvv9oqMiSGeqYCoYRhLTCxR/2WOEJUqq57dnig1bTwkKPAAZHwm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQ/O34yLn3QJ7rKlF5CKpUnnTEFNJr6dJhE/ISHqFmg=;
 b=N8D3CMaDOpHiciVGCHYHvLhTx/6Ce9GwKlxN+MPPuiKRiElNN58U28u1IdSuWiwSXaWXQ8Nzra6HpXT++A6bklPfG136Aa1mdKGG+h3zqr/pNbo5+gswzKHBIVFl2aI/yT70t28ajqOGx65n2qyqo7KJM+LyI1q0US9c22a4hPj9Y15f0MjCnGBIKCL+wVeUJaoavoXyTig4aRNLbpM1FOHa8JxUFE75UGtTZbNfFLi0tf9EleS0QIFANC1opwXt7O2U83DCwXNHmJF2aA6czjQIZN7S4HR1IblyQTkIilaDK5pDxPzbIN3ZwQZhnUtB/bbtJpB7ukmJETwh9yGycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQ/O34yLn3QJ7rKlF5CKpUnnTEFNJr6dJhE/ISHqFmg=;
 b=GWkiI7Tk1kgcxczGjnwg4PM/QFk4658oP3X+lNQ3x9kgibvzKT6wGXgjCAa3rzfOAs+l1FcHu1EE/bixKXbLs424MJydk7vcBElw9Vf+29qV70YKaAqFkTaHKpWm44/bSR/Hn0KXLt4NGdj+7rbkBLt7GSdEbgBAW9UZOgUo8Co=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by DM4PR11MB5470.namprd11.prod.outlook.com (2603:10b6:5:39c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Mon, 31 Jan
 2022 07:48:35 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::5cae:e802:4a48:bd0f]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::5cae:e802:4a48:bd0f%6]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 07:48:35 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux-crypto@vger.kernel.org>,
        <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: rng: atmel,at91-trng: update maintainers
 entry
Thread-Topic: [PATCH] dt-bindings: rng: atmel,at91-trng: update maintainers
 entry
Thread-Index: AQHYFnbzHabzgTFHOkqWg7BxoOLDZw==
Date:   Mon, 31 Jan 2022 07:48:35 +0000
Message-ID: <7fe32b04-1dec-b23a-c8dd-3e7e392796d9@microchip.com>
References: <d84760e0b81c338e01f7856e1ce3c5b600b08f23.1643553619.git.nicolas.ferre@microchip.com>
In-Reply-To: <d84760e0b81c338e01f7856e1ce3c5b600b08f23.1643553619.git.nicolas.ferre@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 642d725d-27be-49f8-d61b-08d9e48e15d3
x-ms-traffictypediagnostic: DM4PR11MB5470:EE_
x-microsoft-antispam-prvs: <DM4PR11MB5470B20A30C479032BFA2B8387259@DM4PR11MB5470.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rvqgRy4yrJYRHwN8U62gN9iGkKhtmrLE8sKSb3NbHDSavebvd5+z1m7uQte8dFV5mc1IA2x0fhjLbFMUfvjqJJVXeMAo1GEMmH8d7M+VWmZOOICQI7qoQnmn3FY7ohdAgAXwTmFJLCO7C/NFWAcSMXbdYtCh4NFd9sysMLbuop0imCIxNIC1+1voVRjwtDBgWO1hzRcdbSpHwnlD6qu4Dyi6CeMUwvCC9RIVO50S9mjaLbGyxGQe8BR7wP5hRJU/pTilYWuaeiYwwgCDzr+eF59ZaxKCUPsuu1J+nWw6N9WXmICEi+2Do7x0OYu6ajtorAmskYMco5oC2eT0hxWxhwY01FqrePIPiZaxjvCtLtEjZx2Z+hIoGT0VtRAvQPbWGuxACu8w3ZeQ61XR9HvKemJ5th2F5TwzS8UxrLJkF+mYiM7eFE8LtRE6d+UBIZY7E/IKibsWivL/TadjvY5W/1hbiPn//pFrJThMdpomJN1erO04pPAXKmnED1kUKOPn9gAppEGdShD1SPIPvkZySDNQ75ovOR5+TMfRcRhixI10veG4dWoTIgMHIpdNEgSlXmjB6QYcGecWa3kkTmk3y8OwsKp4jT59+0GLYa2bpg4oTM79q1eFjzwRqdDZen7rHxrOAPT44zthG5ZrFMosLvmuRGNjfprTV7y5HbJ1PA2UWEXho6mFtlXlBGFHjvA6+uPYZd3oF0S5XQFvVlphjNIuaUy2g/TnTYwucJsdHG87W+2X7lDZt2i5CA5hODgEgM1CImOeCnAIKbfjjlPr/mhPBhfxxgS41VUNDrZZHmRcHv2xbIZhbuOc0cb8ODODNT35x/pm1sriYpFcY0IH3SUoiJjTSlLm0CH9z7phCVA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(15650500001)(316002)(8676002)(31686004)(66446008)(66476007)(66946007)(76116006)(66556008)(64756008)(4326008)(5660300002)(2906002)(36756003)(54906003)(110136005)(8936002)(91956017)(2616005)(53546011)(6512007)(186003)(26005)(966005)(6486002)(71200400001)(6506007)(86362001)(508600001)(83380400001)(38070700005)(38100700002)(122000001)(31696002)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG5TdCtoK25RNUFkSHNZa3A2TnhWdjd3aEU1M3pBN1EyYnNCNEQwWW1BcVNU?=
 =?utf-8?B?SHQ5OGs4SXUzdVFQVGxOZTRSYktmb1ZvaUdWREtHVE9hNzI5a1NTSVVpSXVT?=
 =?utf-8?B?Ync0b3plVnN3d0wvREUrbGs3NEJub3Z6NmNyZWV0VFlPTkdEa3NDbUwwakxt?=
 =?utf-8?B?UmZDOG9xbHZzbTJzdm9vWXlDOC9Wb3N1RzhBZW1FeThMck5BbkFBUGxqcVBw?=
 =?utf-8?B?Z040OGtacFBBdnpIK3lDUEFtQXV4a0ZLWWtGYjE1SG8wOStFZjJSTnN5THpt?=
 =?utf-8?B?Wm80NzZRYW0yUU1FQTZRS2EzZ1Z3YXJSWWRYNWk2QkVEdTB4MFRiNmJydmJH?=
 =?utf-8?B?Qk1mamx6eFE5YVJTd2o0YUlhOWcvY29JWjJVeTlNcDM3UEFoTUN6cTdIOFZH?=
 =?utf-8?B?Z054RGtIQVcyWmk2MmZkSUx4UjJMaUpoa2MvZ25ySDVUT3c2Q24wNFBIbzdG?=
 =?utf-8?B?UFB1Nm5MUjJqOUN2Qm83Y2ZYZzc4TkxveEUrV3RwbmNEU21MclFqcTdheWdQ?=
 =?utf-8?B?eTlPMFZQdmdJd1JUbkh1Y0luNzhKdm00Z3c2MzRvMFhEa2lOUm1Pc3RGUkVW?=
 =?utf-8?B?d21DdzkxV2VMdGF4MUZURUFadlhjSyt5dis2RTdTMCtPSHpKUGVRYytMc0ti?=
 =?utf-8?B?Mmx1U1RwaHltUHZhdHNURmN1RTZhK1hSRjI4Z3dseHJFNnh4UGRFRXpyeEs2?=
 =?utf-8?B?cGxWQUE0QlpOcnRSWitIUUFmb3dzMlphQ05FQnErRU5SbktLVmFSMldDVkVB?=
 =?utf-8?B?MFpWZlk5SElTeTVTR3YxYTF6bEwzOGhsUENiTkdrK01lQUIxTXluT3ZrU3pq?=
 =?utf-8?B?c2FteGNnWDlWTEo1cGVReHowb2x4N3FodHA4WmVCd253RG1vUDVDVXlaZ2xt?=
 =?utf-8?B?Z1ZSN3podnZBaWxGbTE4enJ0aU1rcEVxZ2ZDWnRqSmVnTnVIeUxUQXh2ekZM?=
 =?utf-8?B?Q0ZSa2J3elNnSFFXVmtmVWdpZURCdlJ6UFlXNG1rSHRMVTRIa0ptMWJTdFNC?=
 =?utf-8?B?RjBLcmJUVDcwM2JaNTJhd3NBME9JckZGVFZhaHBxSGtibW4vSjVaTmEzQzNU?=
 =?utf-8?B?a3duVDZRWDRjc2UzZjhGK2ZyMk82Mndwa2ZhR290cnIzMVhXZ1hQK0M4enZr?=
 =?utf-8?B?b1RQYTlCNjVScUo1UllBaWNkUGd5UGFpNTRsdFo2VE16S0x5UDloK1hYZTRm?=
 =?utf-8?B?ZUJsdzZ1UGZXc3Z0YmpieEtBZFk1NkE5M2ljcUtCUmJ2b3ZCNm9NcDNkMk5R?=
 =?utf-8?B?SHhJSENGakdlaTVnWnlIZis0UVg1Q0UyaFA1QUc1RTFhdk5LaERVdk5aWE5x?=
 =?utf-8?B?T1l5bWtzWUNGYllZQTVsZklDWTUyQ25pMHJLSUhxQk1MVVJBWXNZVkM3Q1hX?=
 =?utf-8?B?aTM0eTJmcFlMY3Ayb1doK3c1NDVyTmJ1ZFgzQVNITUt4cWN6NHhNSkx0UlZw?=
 =?utf-8?B?NEdDanVsMmc3a0hmTUZtSm5SV3Q0SkVnSGtqMERVUjJjU1ZTbE92VlpXK0pM?=
 =?utf-8?B?eTNFUXl3RG5hdUdQRjk0NlZlQzZsQVM2dXdiUFhHSVNabXJueWY4VG5tQVJO?=
 =?utf-8?B?Wm9sSlBteG9VOHRxVEExQWFUazdnQWJFdkt3RUxQTTZ4cEFSbklMTEVoRmJJ?=
 =?utf-8?B?c0Vpbm5Yb3pKN3IvVmQzeVQvSUlaMmw2NlhQajdwaDl6OUFhMEVIZFM3SVUw?=
 =?utf-8?B?RmRGcFg5eDh2VlVIcmQ1VjV5cjU5emlrcTlvWWtMUW53N1F4WXFvaDlUbWZs?=
 =?utf-8?B?UDRVNTVzaVpNNlBxbTAzanlPRDBZZ2ZSL3RpMHBBZU8rdWkvVVR2eHVBZ01r?=
 =?utf-8?B?OVJOMUx3cnVRVUd4RFZNMWFOVTJ5TFVIYUdUNDJEb1lITHlOaFZ4dDZVcC9q?=
 =?utf-8?B?SG9zeFdIcytodUJDYnZsMEF2TmVqU1BwQWlrNkdCSlRWR1QyV1Y3ZUZEcjRr?=
 =?utf-8?B?NUVKekdpKy8zR0tPRUdONVo5SVRzSWhRYnd5OW91bXJPZGpDOVBjOEY1RnBa?=
 =?utf-8?B?WHAxYWNpSDhLVVdETldabkpsc0JXRm0zK05RcG5wVzkwVEMxUkNFL05LSVEy?=
 =?utf-8?B?d25zTU1qZFRKNWF6ZzhHNE5vU3Arc1M4eEliZkNXRDhXNFpwMFJ3NW5MOGtO?=
 =?utf-8?B?QldPcER5SzBOejF2eS9jSkY2Z0FwRmZ3TFpwYnB6QzVZeUNPNFhra0QrVzdo?=
 =?utf-8?B?a084aGoyQk9mcTRYb0NnVXlXR3RiN3R3VVhRWEtvcVhXM2l2L0dCNGZ5OXNt?=
 =?utf-8?B?VTBRSU9yQm5YQzNmTHQ4RHV3VGd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA9BDFD506CF624B9F7743702B551A7D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642d725d-27be-49f8-d61b-08d9e48e15d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 07:48:35.1079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWfp/VFw3V5Lh7b3JLsSdV/81eoi2tC4ClOZwlEv6OEg83LwboJoPiP+cTRrJgdAn1F1y9r+W5g2DUQXDjQ2j1z2B3NH8NM8AqiYwJIK4DA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5470
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAuMDEuMjAyMiAxNjo0Nywgbmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tIHdyb3RlOg0K
PiBGcm9tOiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+IA0K
PiBVcGRhdGUgYWNjb3JkaW5nIHRvIG5ldyBNQUlOVEFJTkVSUyBlbnRyeS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCg0K
QWNrZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0K
DQoNCj4gLS0tDQo+IEhpLA0KPiANCj4gUGF0Y2ggZm9yIG5ldyBNQUlOVEFJTkVSUyBlbnRyeSBp
cyBoZXJlOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hcm0ta2VybmVsLzIzODE5
ZDhiYWE2MzU4MTVkMDg5Mzk1NTE5NzU2MWZlNGYwNDRkNWUuMTY0MzU1MzUwMS5naXQubmljb2xh
cy5mZXJyZUBtaWNyb2NoaXAuY29tLw0KPiANCj4gUmVnYXJkcywNCj4gICBOaWNvbGFzDQo+IA0K
PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JuZy9hdG1lbCxhdDkxLXRybmcu
eWFtbCB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9ybmcvYXRtZWwsYXQ5MS10cm5nLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvcm5nL2F0bWVsLGF0OTEtdHJuZy55YW1sDQo+IGluZGV4IGMxNTI3NjM3ZWI3NC4uM2Nl
NDU0NTZkODY3IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvcm5nL2F0bWVsLGF0OTEtdHJuZy55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9ybmcvYXRtZWwsYXQ5MS10cm5nLnlhbWwNCj4gQEAgLTksNyArOSw3IEBA
IHRpdGxlOiBBdG1lbCBBVDkxIFRydWUgUmFuZG9tIE51bWJlciBHZW5lcmF0b3INCj4gIG1haW50
YWluZXJzOg0KPiAgICAtIE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNv
bT4NCj4gICAgLSBBbGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5j
b20+DQo+IC0gIC0gTHVkb3ZpYyBEZXNyb2NoZXMgPGx1ZG92aWMuZGVzcm9jaGVzQG1pY3JvY2hp
cC5jb20+DQo+ICsgIC0gQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5j
b20+DQo+ICANCj4gIHByb3BlcnRpZXM6DQo+ICAgIGNvbXBhdGlibGU6DQoNCg==
