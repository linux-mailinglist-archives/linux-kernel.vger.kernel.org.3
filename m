Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DCD4A3E18
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 08:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357870AbiAaHLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 02:11:02 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:57093 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357864AbiAaHK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 02:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643613059; x=1675149059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZzWKggvR0p1BwL1Mtik63hUTmQhFKOkDI5RfA0Y+I7Y=;
  b=htKtx2vuWLSzB+YPkeKLxp2g737wNp2Vrio5WmivZpnd45QjQxfrcL3T
   De0qbN7BfGLjScZgBRau9fapWMLhM7JkXNvHyALdgiAZlcuycz2lncCmW
   b7hOILZ7p0P8Bv+LUTChAcrujLTPnlWGR8CTfWkVK93oOAEyi35w1W/GB
   kUXMiedEUHBMhuqkr/pgf0k2O1TimVGbHN1voX1k34thWYvHVcDkQ8ngo
   s1oe56jymnlZP7FxOEWU3G6wL4E9eKS5ih9LXo9+6PkvfR9QCQyoZplLx
   fBm1dc3seli1WESPpAeBWc6pFqHxUYsWmTs7fz4Js5/eMCVwx92CqTBY1
   A==;
IronPort-SDR: ivVS50HfA/RCGGvBDHY2IBovwQZrxBgZnZbIzHKhcfDjqFoGChvrTLbiVn4TQMo5mECIjSpieP
 zVtmIYrTrEg4GzfJKZoQ9ub8bmDGcTyvICRuTpryXr6YiGj+cWy06x3nCfrlp9aYTGBUveW9l8
 ANezW+iHGgWOruPSiZ6DzM9+xSRDhqgxGBF2AY/RvfGpWYAB477JgPE6CmTUPc39yVx9UHqklR
 nCrY/cSiOzhQF5T/vIypu+pMuJm1wj+7t7WJIsNkGCupFmcyv9H+m3pRTZ0kP/AYhYQStX8aod
 c3BH9nC0oRQpkCnKJ30nJyQ6
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="147096817"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jan 2022 00:10:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 31 Jan 2022 00:10:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 31 Jan 2022 00:10:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jb9z2QQoler5VpD1T5yxPeWiIY0fdLcQM2hbOy9DvGOFtNz6xJVzdZv3w9oES/KdAiuO/AyEm0xO1e0i7s+QlnnT6WX+u8flkv9UeyZcNP9X+1ETeLswJeg5ebbooKY0+kDIipF9SJneQfKalBmo5UnCVCchIU9wf0LJdz/p8St1fKu4u06yWoHwo1+/Mm9nAp/gbZGE8phZequuhLhgMvNxfXXa63IHuacSua4z/9yS3H+HkAu7MJV9EdhP23MdEAZAUKV/iTocDfh2+jhEVFaAkEnqbqzlmRoRf5Qc7YAay/iV1jycVrOeuyCxSRhFHdOM7JFIcVwvLJKMLYtDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzWKggvR0p1BwL1Mtik63hUTmQhFKOkDI5RfA0Y+I7Y=;
 b=I6+T00sMwd1OsN6w7RZ2cQV1QMI1g3U+0gy83hTLXfu1u1WNq+tcpgl2EAQ3pqCJpdCrFcBZh8Svl/+CIZs45Y5zietGnuEneMF/XKVvq3EQdVlFDzNx36yoGrEGwNUX5TwDZ68XVLGt3Z7qNCAM5Zv1pgsFhnpFc+xyS/lpcZM8k1JasUDomiUOKmsW1FOryqHoM8NO4sucqv1eCHzCIiRWLP30UcD5pm6g7dssmolV2yFX0NMdNdWhVk3KqlmFPtYq7qAprimE2qU9aJCRFI9TV+ck6AZJHvh8YwJ0Afgq0ouFj1Kpz6NemyIVuzaexgBYK5z+Mf+PVPZco4Bh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzWKggvR0p1BwL1Mtik63hUTmQhFKOkDI5RfA0Y+I7Y=;
 b=jATkG6ZrA2a1o9Pg207LYYNPSdf4pxBFHyogjzj1I9Cm7ybYCq+jkvjndPmoWGh/t+1ONXl1G35izcr08qgIxXvjrjMgEkgNg3+ECovT9ZytaoE9LRCFlVXAUMgkZai/mrPT3rE60KKzj0+HEClmQ7icnvfBNaB7RgLWn7BMZPw=
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by DM6PR11MB4251.namprd11.prod.outlook.com (2603:10b6:5:14f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Mon, 31 Jan
 2022 07:10:54 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::a588:b481:2154:c45e]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::a588:b481:2154:c45e%5]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 07:10:54 +0000
From:   <Ludovic.Desroches@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] MAINTAINERS: replace a Microchip AT91 maintainer
Thread-Topic: [PATCH 1/2] MAINTAINERS: replace a Microchip AT91 maintainer
Thread-Index: AQHYFedDJVTxtJ8RGU6r4jDztmnaXax8t5AA
Date:   Mon, 31 Jan 2022 07:10:54 +0000
Message-ID: <810150de-5099-6110-c5b2-167bf206fc6e@microchip.com>
References: <23819d8baa635815d0893955197561fe4f044d5e.1643553501.git.nicolas.ferre@microchip.com>
In-Reply-To: <23819d8baa635815d0893955197561fe4f044d5e.1643553501.git.nicolas.ferre@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8c55eba-efb0-44ad-0543-08d9e488d278
x-ms-traffictypediagnostic: DM6PR11MB4251:EE_
x-microsoft-antispam-prvs: <DM6PR11MB4251AD4350B1C47989AC51F0EF259@DM6PR11MB4251.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VEhe3ULTJocpJvu90CW5NpUPPdXPeH3/8gf93A0s4zKbd0KTB4ON6SlE7FeEsOEWWqYGM9JK4JQsxOZvjBnF8m8/qftxemGXzI8FLN+X2WFVbKBYKpPcSSAE5dpUmwnjWO7DO1l2Gijs+eqgSvZGYF6cGmtSee4Nmntxh33PanNvbTZfgM8c8yUhlFd+NEkZ1yDqmNnRLwcLt9OSfQhdKz4iSE5OXvzjKpq5l3FkRWsN8cj7HqcAHUGzd9Kg2bzFzRLrwzlrnl6w1SMnNZi6McDHnFCF9UF8tFJY2n1ZTLdOT6JCu8nh+o9ubD1QCWFwSFCLnmR6/8Ry/RC+nuKi+pCaNtaHg2bJ0fH9jesdOuwaG3Q6wuUWawJw+u5sw/UHqSXOMXfJaGNm4pc7BGNVLPlhKfET3L6+mEOpH/q1sWO1KjsSXoP82cOnrrvEsow+PrliT7QS5blUUJicj/WNgmxRum9g+ChblvMZa1RkAv9LWmrQt2ctk1m106YnCyNBwVwgZcMMkahn9gEyH03mAXFqz11MUJpZlfykkZwvq6ZHZY3ima2CupI0Ni0AP0YVlu/2KZd6ZKqMCrMupWVDirn0CKAZxsoPcmIAmuhNYeLMcN2Pogv2PWtuptnXBczKhMG/eub2t5h0s6FDOknsE1cuuDyp0kYeEDAuPzVGGQeDS+9t7lAJft+2X9V/jGuMeD+9S/GIBtX5O3iQlZLPuUrTyufDuNZ3SNLNYmZU+pquIf6gcOVb83clr2qipZY41IRd7mculXfG9bovbaMrSYc1logVRfQpVCjLHVhhwQWQ61ffje7rnUvReS8A3TBZNpL+zjgJr0rmf5X7rCbd3NCfDvfhpWdZYDJN9de4yj50aJo1vpgaFw5tdBcFjzxkjFkdid+o60kEedVXt9riGUS7j/xYhadcHjW9SRcOimc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(6512007)(110136005)(5660300002)(6636002)(38100700002)(966005)(6486002)(83380400001)(71200400001)(122000001)(26005)(186003)(508600001)(66556008)(8676002)(8936002)(64756008)(66446008)(76116006)(6506007)(2906002)(91956017)(36756003)(66946007)(316002)(86362001)(38070700005)(53546011)(2616005)(4326008)(31696002)(31686004)(66476007)(43740500002)(45980500001)(18886065003)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEZyb0RwdUxlbWNaRGFCZElBc0Q3VytRdTc1ZExWZlNyT3dtVWVLdENQaHlE?=
 =?utf-8?B?OE0xSTUrV0xLS1NpRkRwamdibGtXZGdIaGF5R1dWY1hwY0Z0SldFL1lxUXY2?=
 =?utf-8?B?cjVudW80Ynp1VHo4dXJXMmN5bDBjNVlsTUZJWW5EdVo2UUg2UWJsaW41UkJa?=
 =?utf-8?B?Z2MrUkgvRWtBYTdPME15ckFUTDQxZ3Y0RytTSVZrMUtyRUhOTldJQUJ3aVRv?=
 =?utf-8?B?cXRjVm1QVmFYUDZtQ2JWanAyc0FNdGtTZ0dCbCtxZUZpaUtEaTJnNDJMV2Zl?=
 =?utf-8?B?OGtHWWV1ZmgrUi9ZWTlWdlBKcTdaMTRDVDh5RzdnY1JtbFd0U1c3aGhuYXBh?=
 =?utf-8?B?ZnJjNzc0OW84bzRwandiQlduemNJaEdNNWRQODk5RzhiQU50ZCtuRm1naUVv?=
 =?utf-8?B?eG1GQjRSYUMvZUpDRDhOSW92UW5xQU8wdFJCcm5GbEIxWlREa1czcDhuK1NI?=
 =?utf-8?B?Si9rTDlhVlFPQ0szRlluL1ZrVzNTWHlWM25nRkFlNnR0dTNKZ2V0aktxTXd2?=
 =?utf-8?B?bkliUmZxd013RHlZTzNtenA0QVFFMjhxaWt4V2duSm8rSE5xOGZLcXZVNktn?=
 =?utf-8?B?Q3VDZ0hKRG1KZWFzQWs2V0xkWHpnVXVSSjFwQlc2ZWhXZ3BJSmZ3cGFoaWZP?=
 =?utf-8?B?S2pMZzJyeFBZTjNWY3h0VER5L0xrV1Q3My9Sdm8vaWwraEZ4U3RYbHRwMkZJ?=
 =?utf-8?B?UGg3QVJWMUFVVE4vMnlNNExHc01Sc2JMQnNMRVYzRm1YQkNkUWZ0b0k2ekx5?=
 =?utf-8?B?MFdScWFyRkFrWGRmV3hxWU1KMVNwcHlqWmRqeXFaUjdUZDVhWEt0VjU5dStW?=
 =?utf-8?B?Y0c0bkpqdHRCWHI3eXliUm4xZEJublM0dHh5MXFVSGJLU0JMY3MxcnBzZHkv?=
 =?utf-8?B?UGxCNEJDU0RQVHNIaEp6amZCeDZud2tIbDNqSmZIK1FsbGgxV1d0Q1RvL21T?=
 =?utf-8?B?Sk9jTko0QWFGK1NjNmtERktqOUVKQm9icTFMMTRwWmxqTW9oZTdTdWkzalBt?=
 =?utf-8?B?b2xZQ3RlWGFvOHJXTnNkdlp3OExVM285THJiRnZOZWIwem9NeUNTVFA5NnBt?=
 =?utf-8?B?NlA2TUJmME1teHphTDdKdzNjYng1QjhxYUZqWitMVkwyTUNuR0hCeWVOTXVh?=
 =?utf-8?B?cGxmMkRudWcxVlVLc3lnVzR6Y2pQaUlHbW9BU29tYWtzdnBwK2hGN2RIVnFX?=
 =?utf-8?B?bGl0V1p2K0gxc3NFaEkrZW1VZ2xNNW1aUlJ2dE82cEY0OEZ1eU8ybWFpdnhh?=
 =?utf-8?B?V1Y1MnFHM2V3dStPK28rYnY0bmo0V2FWNzJaOElLSkdhWFBtUmwzQ1NPOHlU?=
 =?utf-8?B?MzJRRXhCUnM1bzVGNHpLWk42MktnZjBDblE5VkdnYVpsZllwY1VYQmhkbC9P?=
 =?utf-8?B?SmFrdkJ1dU10aUlDQXFSS0xYZkZFOWl3ZWlkRzloUW5nYkwxYXYyNGZTSG1n?=
 =?utf-8?B?QVRIbWlEYzlnWGFJUUg5bDI2a2VUWDZSenpvRTJibENTOVlMQkNZdjh1c0I5?=
 =?utf-8?B?ZXVEMjNrSDdHaVVTVU9MN1hJbzZCTTJZZzY3YlpUdVR3MXdrOWkwMC94aTAw?=
 =?utf-8?B?Zkg2ZVp4ZzY4NGl5QktLc3RHdVJINDdHMXM1Nnp1cUFzVE5YMzV0VWpDakxx?=
 =?utf-8?B?Zm1TZ1d1RVpFRFRxQlNPcEJLb1h6S1l1TW9ZN1Vlc0pQV1YvaUR6S3gxSU5F?=
 =?utf-8?B?MmUrd0VXUDMxRzJ5NHZ5QVExbDBMM3dHZkZDQTdxdWMzd1Fuakx4LzZQbWVq?=
 =?utf-8?B?L1M4S1hTblRMTzhrTzJlS01jKzdFd0JkTjJMS21FNm9hUG9CMjM5N1BWVHNO?=
 =?utf-8?B?dFJZMmlvSmFkNzcxa1ZNNFpXSU1yRXdhMXg1QVltY251NDJHQ2ZHWmx0ZDRo?=
 =?utf-8?B?blJqVkVYWjBoN3dTSmpjNFhYNnlKV0FESnJ4MURMdFkvdkpaeFd6aEQxaDlL?=
 =?utf-8?B?VzdzQ2JVaklGN3hWalordUFKMEFCcWlISGxGdy9XaGw5U3VJRzdGMXh4M0pn?=
 =?utf-8?B?WFRKcVVNa282dXBtbXVmM01oNGovM2ZIZE9rUnRUSDFnVnlPOVkwQkRvZ0d0?=
 =?utf-8?B?SklxQWNwV0hYa0l0RTV0VmlHUVRnTFBvL3QyU2tHM3NpMWppK3ZyTHFiK3hV?=
 =?utf-8?B?c1FBekxyb0ZzNDFQbGJmekNudWx4QnVGRkVvRzdKOGU3Y1V0QjF2a2hUZEtr?=
 =?utf-8?B?dHRDMWVLeEdKTkNuR2ZLZnFxN0FFTTFuampyMDBvMEp1b2s5bTRYSTNWeEVN?=
 =?utf-8?B?NjVIVjUxdUFKQS9QMWMvZnVpVGxBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3255A9F41208D04DA8879AB1C2DD93D0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c55eba-efb0-44ad-0543-08d9e488d278
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 07:10:54.6152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okq7yJhWjwhAQ0u7PyEujYjUBwxF2MqTgugkTC0ustvTmzwDuBnGdoJ63BSuL3UJxqrK5Kv+diEFR1HwTLqintg81BaUuJz+dWUmFrjtOTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4251
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8zMC8yMDIyIDM6MzkgUE0sIG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbSB3cm90ZToN
Cj4gRnJvbTogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KPiAN
Cj4gQXMgTHVkb3ZpYyBpcyBtb3JlIGZvY3VzaW5nIG9uIG90aGVyIGFzcGVjdHMgb2YgdGhlIE1p
Y3JvY2hpcA0KPiBMaW51eC1iYXNlZCBkZXZlbG9wbWVudCwgcmVwbGFjZSBoaW0gd2l0aCBDbGF1
ZGl1Lg0KPiBFbnRyeSBpcyBhZGRlZCB0byB0aGUgQ1JFRElUUyBmaWxlLg0KPiANCj4gVGhhbmtz
IEx1ZG92aWMgZm9yIHRoZXNlIGdyZWF0IGNvbnRyaWJ1dGlvbnMgaW4gdGhlIGtlcm5lbCBzcGFj
ZSENCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWlj
cm9jaGlwLmNvbT4NCg0KQWNrZWQtYnk6IEx1ZG92aWMgRGVzcm9jaGVzIDxsdWRvdmljLmRlc3Jv
Y2hlc0BtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgIENSRURJVFMgICAgIHwgNiArKysrKysN
Cj4gICBNQUlOVEFJTkVSUyB8IDIgKy0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0NSRURJVFMgYi9DUkVESVRT
DQo+IGluZGV4IGI5NzI1NmQ1YmMyNC4uN2U4NWE1M2I2YTg4IDEwMDY0NA0KPiAtLS0gYS9DUkVE
SVRTDQo+ICsrKyBiL0NSRURJVFMNCj4gQEAgLTg5NSw2ICs4OTUsMTIgQEAgUzogMzAwMCBGT1JF
IERyaXZlDQo+ICAgUzogV2FycmVuZGFsZSwgUGVubnN5bHZhbmlhIDE1MDg2DQo+ICAgUzogVVNB
DQo+ICAgDQo+ICtOOiBMdWRvdmljIERlc3JvY2hlcw0KPiArRTogbHVkb3ZpYy5kZXNyb2NoZXNA
bWljcm9jaGlwLmNvbQ0KPiArRDogTWFpbnRhaW5lciBmb3IgQVJNL01pY3JvY2hpcCAoQVQ5MSkg
U29DIHN1cHBvcnQNCj4gK0Q6IEF1dGhvciBvZiBBREMsIHBpbmN0cmwsIFhETUEgYW5kIFNESENJ
IGRyaXZlcnMgZm9yIHRoaXMgcGxhdGZvcm0NCj4gK1M6IEZyYW5jZQ0KPiArDQo+ICAgTjogTWFy
dGluIERldmVyYQ0KPiAgIEU6IGRldmlrQGNkaS5jeg0KPiAgIFc6IGh0dHA6Ly9sdXhpay5jZGku
Y3ovfmRldmlrL3Fvcy8NCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMN
Cj4gaW5kZXggZWEzZTZjOTE0Mzg0Li42NzRkMTM3MDgzMjQgMTAwNjQ0DQo+IC0tLSBhL01BSU5U
QUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC0yMjUwLDcgKzIyNTAsNyBAQCBGOglk
cml2ZXJzL3BoeS9tZWRpYXRlay8NCj4gICBBUk0vTWljcm9jaGlwIChBVDkxKSBTb0Mgc3VwcG9y
dA0KPiAgIE06CU5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCj4g
ICBNOglBbGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQo+
IC1NOglMdWRvdmljIERlc3JvY2hlcyA8bHVkb3ZpYy5kZXNyb2NoZXNAbWljcm9jaGlwLmNvbT4N
Cj4gK006CUNsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPiAg
IEw6CWxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZyAobW9kZXJhdGVkIGZvciBu
b24tc3Vic2NyaWJlcnMpDQo+ICAgUzoJU3VwcG9ydGVkDQo+ICAgVzoJaHR0cDovL3d3dy5saW51
eDRzYW0ub3JnDQoNCg==
