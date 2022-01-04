Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C4F483E5C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiADInH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:43:07 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:11461 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiADInG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641285785; x=1672821785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=w9t7e5pHvXdGc/uv+X9vLwilfShXZLLuD8A0u0cFdrU=;
  b=NodKv25GNiUwgD2ZEi6+SsS8iRxOILGuNI0e4HjxKY6aC871gFYtdxH8
   Fcl4gxtJQOJmW8WVJtJGf5Xp+lq1SWpr6c6ald7CHjG57w1z4sDpGwhfH
   0MElPbDJKgInWBQ/fRdNwKTZTWMW2S7yeqdP23Uq1fE2DTUdtp06MeCze
   +FkmOz5NoIdT7pwYHAQwPtCZ4iXNW9thPw9Zuk59AFZddP5FWTmYHeaLt
   PYZQWj/35IV6PoIjwOv3FuxAH58NG/GvQorUgBFd4Aa9RvNZmM41gZRWA
   iTnT4zUjgb9M9co3EZ+LWVXZlM7BHfVI2B76lv30FlNCNvNxeG/U8GPTz
   A==;
IronPort-SDR: fUCewJPPPmy2NeTn6Ct7UuejKNjhxh3pd70NTBg/e8KDF7ZAmkZDjoeifG2i3qMQk6dbEPbAeI
 hhhbUNz2QsOa7uJ1hkYbCM9Qr07ezqJotgECouYckLA6FPilKul655JNICK+qKGxNQBxv2ZRXb
 kwmSbmV1ya0lkC3+HABK7wTzMyRo/H1/H+Cm/GB/RTYQxgpoZQNxpfcO7XqaDLHbL//KFq8ugE
 fEHXFzvefC9+2ScAy5w9i8d21TPSQCU1bY1ZR7pQcbKGUfUNcq9MtXFq7lDVOYaxdGNkZQ1u60
 BEYSJ4zQCd+Gib4TDjPwyHaf
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="141560620"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jan 2022 01:43:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 4 Jan 2022 01:43:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 4 Jan 2022 01:43:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoegq8Rk+CMzGcU/NpZtdXraFldkzr8JhQdvUalT/tHJ4TN5C1MQ6rcGQ527SObVYS8JrmP3jb4PMnqG6znqRP8L4qyZLw9KDX6iNLCDi/Z23ABKCZKrnAjMh1B+B7Nlvm+3bNRBLh5Nv4ugjxIIKutN5ZuKn4fbD5XpPDwBEqB4FN8LLmWNO1qkZK2r/TuJCYStNRpYAXgY4KzoOnlbkWTv7/YSKvYEkAlODA6ftnfHJ2nAlsqZBsvTeBSAhoYJtjjpJPjYOgtQQLnJd7l2CJ9CvafNh8Eq8RnWAd1XlybSLzC5nTkh2wMOO8Xn/atXKyp7SIYeYu9fPzciP6H8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9t7e5pHvXdGc/uv+X9vLwilfShXZLLuD8A0u0cFdrU=;
 b=QL0Bf+uBQ3y1pIBOAFAwevNh5zBpn6roS1hWKVaEYUnHi6OInOB5/2VUW5FFC6AbzMgm9IcSNgFYyrOCYxmDaQfdxmcQlRuj4r2svX86i8L9zuiwW0EdQaoqkjFCLWGGBN24d1ZnC8pwX4udDyd/Oc4+b+pyciUN7w9ED9BhJQf3cxRcpK17t/Zs2e4bv6Vm3IFYaXzzRfiGii+dS9c+B6javODJbM3oBesvktfWIEvCZ6l5Bsjm0jL/6BpEIM03LdG+jGkeyI0906VN4wzfQhH/YJ4mPb22Ekttosfw60GCxUXHNHIYZktHp7sq60+EHUV9W6tmgepnb/2Ji+zIOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9t7e5pHvXdGc/uv+X9vLwilfShXZLLuD8A0u0cFdrU=;
 b=YvH8jtPg+Wn+nSdGr3x1urgalqKxVJ9oXq4D+pNnZ7jYYpJ3ahqueP8gn/a8JpHc6nQXKOxhRHseCU1NQtcrQYXklsnLRgq3ot1VHAFf3+LoX2U+mOxPYZL+KyGcmadjwI4mqGaTvKhphFsDYMbpnCSM76pA1KtRLZIPylKxhlI=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by CO1PR11MB4947.namprd11.prod.outlook.com (2603:10b6:303:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 08:42:58 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::5cae:e802:4a48:bd0f]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::5cae:e802:4a48:bd0f%4]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 08:42:58 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sama7g5: fix compilation warning
Thread-Topic: [PATCH] ARM: dts: at91: sama7g5: fix compilation warning
Thread-Index: AQHYAUcThV9HKiZYy0OCVCkXdM8Dng==
Date:   Tue, 4 Jan 2022 08:42:58 +0000
Message-ID: <158f6ea1-b903-9bb0-33e4-468940c01f13@microchip.com>
References: <20211220082058.21687-1-claudiu.beznea@microchip.com>
In-Reply-To: <20211220082058.21687-1-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8711fc9-2ae8-43b4-81ed-08d9cf5e3594
x-ms-traffictypediagnostic: CO1PR11MB4947:EE_
x-microsoft-antispam-prvs: <CO1PR11MB494729652EEE708713515063874A9@CO1PR11MB4947.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J3ayofG/3qpsS4LX5PH7ciEoT+Hfl2fFv1hMVzUFAREypeTKpk4KDO3yvXAxN7cIvrzclviTuxFGBGwkRsFJinf8vWP7+bkQHk7TJTvgfLy/9RlUImsDx4EHAL1eoO89lX0w+dd+zO8k+A85P8UUUIXlXJkQLiEUg7MIt5ui39188IqfRYdjhwdxwuunJcB+Hd1qUCKbEBckP463uEYBY+/3HOum5E6RHfq7A9SPyRl+pLLJcoUwh9NrJCF/LPsKUfOflpujwPJZMAKrgSu09Ai/XMu6090zISBCEGdjZD6gdpLi1aR55qr/o5IhlyqeBjP05kf6tIDvHrp8HBfVG2ZJycJ5Qk8LpDtRG2Zo2r9tfVZedZgUpDrJkGXFxlH7KQ+tur85zeGKuKkrauZIgwEpoPsiFmFl0d0Kje+Tcq3ND4e0WpeD7Mvn49VVE/Qo+HkIVktmc14UpXhtvRamKnNCD0utomh3e/jVmaS99xZeLJ7XEZ+1LLWc8LSnrHuBXqvsVUOt9aX9jSBahgVSo5aCQYPNSf6JkaYoUuauYUq19TN309LyDNlHxj0HJJY0J6xBeiHEwo7Uqhy3tLtP4AKR8lj8yGpz2HWRAjvEtmmnp+esUwDCrTifc53Iqb9uy1nM1b+hjYJxo88oUjLSyEoIz0IlBkNSqA7uwIEL+TjhOodnu70TksZcJeARltXypA8qXaAa6B8+0Kd+mZ+MuUFUJchMnUWcdeCL9VNiLhWA4X381LcbyV8iEquB82AD7cAe+u+3swQOkQFaX2OF8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(8676002)(508600001)(66556008)(53546011)(71200400001)(38070700005)(66476007)(4326008)(64756008)(8936002)(316002)(110136005)(66446008)(2906002)(66946007)(38100700002)(122000001)(83380400001)(54906003)(31686004)(6506007)(26005)(6512007)(31696002)(5660300002)(76116006)(36756003)(86362001)(4744005)(6486002)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VStrK3NDY2FzeFVFOFFyeDdxQS9sTjVUeE55d3gzM1ZlQmFZTWNwYVNick4z?=
 =?utf-8?B?YkJIa2QvdkJpZFBQTWZQNUY4RFFwd24yVGlsbWgvN1JTK21ieVFLcXVCKzVH?=
 =?utf-8?B?bnMwSmR0V2wzTW5TVnVEeTM2RWZHdkdlY0VEUmV1OGdCcVBEYXo4Q2w4RmpI?=
 =?utf-8?B?TkQ2ZHY5alUvU1E2czdwNWZzWTFrQnhOdmlQRzA5aCtjT3I3eU1jNktOcVpN?=
 =?utf-8?B?TVNRMDNBSUdhRXo3WmgvcHc1S3BHTXIwcFIyc0ZZTERidkxwRklkWExneGFT?=
 =?utf-8?B?RHJWQWtDUGs3SDVFaDRQK3A3TVdjVnl6dnBya3U4c3JncWh5OEJpa1VOQi9S?=
 =?utf-8?B?TmNTb0VPckhudVd3UEoyVmFSODJhdUJXZDZLYURPcHBBY1NLSDIrdWJnMzd0?=
 =?utf-8?B?TGFTRzdoNU4xOE1RNlhmRVVJdDlHYkNET25sWHFmOEF5eG5lK0hac1VGcEps?=
 =?utf-8?B?QURCekYvdXdITEZGQk1OSHpGWkh2TkpHVFY3TDgwaEdYT2dVTXloanZpVGRi?=
 =?utf-8?B?T0ozcEZNdVJDK2hYUGw5V2NSMDRHZ0F3RjFiVFBwNXZaMmhhYU55YnNXbVlw?=
 =?utf-8?B?SnFSaHh4bDFVVXl4dit0SXJvRWlHNmJLUDBXRjBNbTRGbGx6WTFaLzdTdk51?=
 =?utf-8?B?ZE5wa1ZBazFHbG5GbU1LVkJrZTBwZHRzVkl0czdMUGJoWGkxbzBUNzVoSnpl?=
 =?utf-8?B?T1hXTERCaXVteVpxVTdwZVpHNE5leGZjemQ2RW5VSmU0OWRzN0JYZ3p3RE5l?=
 =?utf-8?B?RkxWaG9BTFhCVTRlcGhkNGJtMEM1NkVKOW56RzMwV1lEWGhNZDhISkZ2RUN0?=
 =?utf-8?B?Mm05UHN0VEVzdVpWTFNOTHBzMWVrcTc5dUxtUDhPYXZiOVFtdFpJNGtkSEV1?=
 =?utf-8?B?UkZpNlgvSHpxcjN3MVV1dHQ5a1FvMG1maEwyQ1JtK3hWT2NWYnk1dERHUFJI?=
 =?utf-8?B?cHcraEZKRjR0VU5pOWM2dzR5SkJ1eTM3dWlsTStNMkcyVUVYTGFVNkhuUU9G?=
 =?utf-8?B?b3NoRzJQTUprZjFLcHhqWXpKUHdyY2hvVFBtc2Ruc0N3Zk5PRVNwYy8yQ2tL?=
 =?utf-8?B?aFBob1FxL1VmczlZSVhrUTdIZllrRDRMOGxxd1hRbDEvK3ozOE4zOWtzeEJu?=
 =?utf-8?B?UENxb2E1b3g3ckp6SGN4dDRXWEFrWWdibDJqMDhhRFQ4a05reDAwRHpuRGhG?=
 =?utf-8?B?WXdIcGF3QTcxaitzNXFQazZ1SFFOUUhJNkdYRFdpbGcyWTkvRU5VMG1JcGl2?=
 =?utf-8?B?QjdRY0Q5MmdyRUV3SkJiZ1Z0NDlnanRFUk5WWnhjTk1WK2xaZkVMeng4RjZD?=
 =?utf-8?B?K3F3Zld2UmZGTzl2cWo5NDZENjJiMXZzNCs2ZW5GcUNyTjliT0daVWZkOFUx?=
 =?utf-8?B?WjNBS0VWL3E3Y2piam1oYnJLZjhCOFFMMEhrVkQ0ck9zOWxHTmhBMENKd1Vo?=
 =?utf-8?B?cnpXdFVrWHlVOEVoZ2k2TE03d2x6dkdtakZYYW5TRWZnYk1uRk85czRZdTRT?=
 =?utf-8?B?N1JQbk1yWHlNU0lWRWx0VExIY3NXRWUxVzllSVFQSHAwMXU4eVB2T202eDEv?=
 =?utf-8?B?OFJFeS9OUEpLQUV5aWwrekRjcHFPbHdUYUE4N0N2djVRYnNzQ05HaUdRVjdh?=
 =?utf-8?B?VHlCNFhrRnVmUlBxSER1N0VnaXNxSlBpeXhpd0plb2x3UUJlOVdvTlJTTG9T?=
 =?utf-8?B?R1VkbWFGVWJFOG42S25yZ00xcHU5SG1CZW52YSttTlRSaW0zRjFGQkRpU3BI?=
 =?utf-8?B?cDhKL0JNaVpuR0R0QjZ6ZWN3U21kY3ZzV0lJdmxWRFphby9BSFhIanNHaENw?=
 =?utf-8?B?ZVdxWWpHMGNjMFFpRjBvcVllVytna1FDaTlLN3E5cCtmZ0Z4UjFXbE15WFVh?=
 =?utf-8?B?OGFzMFFrUGJYc2xLY05FcWNISVBLcm4vdVFvV2t2dkdwc3Q2d3NUQVExNm5G?=
 =?utf-8?B?azNjcDFDSEdhWVlzSGdvVGxhUy9yZ2hQd0N1TVA4VmhRQ3pRZTAxcy8yVDRW?=
 =?utf-8?B?MlkvQmpza01KVTU0emlHY1JuT3IxOHh6eTNtbHRpWlg4VzJQbU15a28xMEtt?=
 =?utf-8?B?ZGw5a1NNZEd5SlY1RDBHMWtSMkRFVEFBdFdpN2E5VU00emJDN1h4RFFNc3p1?=
 =?utf-8?B?YXNFMXRFMytqeVQvQUtzVTdONVdqTVU2VHJxNEdRMVE5bkZMdmt2T2dWaU8w?=
 =?utf-8?B?b04wNS9QWVJZL2JWRk9ucHoya0o3eHJBd2tic2hLNVpLZ1N1Z0s4U200NFI3?=
 =?utf-8?B?RzYyMldRempwbXpkUzRmMkRUTFdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9BDBE545B90C34886695E6A06BC790C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8711fc9-2ae8-43b4-81ed-08d9cf5e3594
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 08:42:58.1185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YK2aCG2w5/i4gLduwcBMVtIhpbWYdFCI05NsifdH6k/YUVhvDKuvsNAokyn6PBGgQ4pdKUz521rjHpDw8639la6pMs647+glEV30kG1YpZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4947
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljb2xhcywNCg0KUGxlYXNlIGlnbm9yZSB0aGlzIGFzIGl0IHNlZW1zIGl0IGlzIGFscmVh
ZHkgaW50ZWdyYXRlZCBvbiBhdDkxLW5leHQuDQoNClRoYW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVh
DQoNCk9uIDIwLjEyLjIwMjEgMTA6MjAsIENsYXVkaXUgQmV6bmVhIHdyb3RlOg0KPiBGaXggdGhl
IGZvbGxvd2luZyBjb21waWxhdGlvbiB3YXJuaW5nOg0KPiAiV2FybmluZyAodW5pdF9hZGRyZXNz
X3ZzX3JlZyk6IC9tZW1vcnk6IG5vZGUgaGFzIGEgcmVnIG9yIHJhbmdlcw0KPiBwcm9wZXJ0eSwg
YnV0IG5vIHVuaXQgbmFtZSIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8
Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybS9ib290L2R0
cy9zYW1hN2c1LmR0c2kgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9zYW1h
N2c1LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9zYW1hN2c1LmR0c2kNCj4gaW5kZXggODk2MWQy
ODUxZGYzLi5jYzc1ZDA1OTM3MjkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3Nh
bWE3ZzUuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9zYW1hN2c1LmR0c2kNCj4gQEAg
LTEwOCw3ICsxMDgsNyBAQCBtYXAxIHsNCj4gIAl9Ow0KPiAgDQo+ICAJLyogNTEyIE0gKi8NCj4g
LQltZW1vcnkgew0KPiArCW1lbW9yeUA2MDAwMDAwMCB7DQo+ICAJCWRldmljZV90eXBlID0gIm1l
bW9yeSI7DQo+ICAJCXJlZyA9IDwweDYwMDAwMDAwIDB4MjAwMDAwMDA+Ow0KPiAgCX07DQoNCg==
