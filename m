Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBC547E3A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348274AbhLWMmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:42:47 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16569 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhLWMmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640263365; x=1671799365;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=CnkJqZNVjeyp+BTIqhDny/cSYfZJ2DWn/0JpXuN0gcU=;
  b=ksZyD3dDfSjM6W636VW/Ac4ff3Lykkue6BCfwwYCqF9tJXM50UN4Cbm5
   B4lL5pi0Rqih0IwhXczew+9Lnd7/QCuZ597WeP/4M9j5y+laSO124jvA3
   Q9jcXLAjReZW3KBQ5r7AT71K1jZUCm7jzOgvMNnUbDiR+iRxos4CCpPT+
   g8Zr2Mipu42WgucVvwRjcoQTJFKU9qWavxuwiGAd1oiN/nhs9IBgFk188
   88RCLF3hEx/Gif7M0PoPlZ9s4Me4v5q0wvzE7AT1ghibVQilOus1WS6bo
   KNd1Ui2JK3D9a3DeoGZIRS8DH0o+7bz0KjInec1AtTLPGijDt1GqkfyBt
   w==;
IronPort-SDR: 41JYEg6JjqfwrLJNM85ohYvRIvF0eQNRBtmjiP97PW6b9u8MFtJinh9AKsZDTswTuNcAtJEK85
 CGsfRFneR1jVHOfkFX4Dbow04XrRfzJ6YpUIGWqo0dAEcyQwX3SrjJ27HKKwAUbKfTVXLoz0Ht
 9xUzEXCX7kRy887UEbI917JtFEBAOmBQh9xEzAeAvJr9JYUFBDYvlgdt/hum9KMK9wS6pAhVsn
 6E0W7tTkOKyr0hP3sLZ7Lj7MMeoE1JGGKfv7X0jBGVj57GAdWrvkdzz8bKnSufZEjL1qYgbROq
 nD08Ul1FZpUIzznry7Bb4zxS
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="140708543"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 05:42:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 05:42:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 23 Dec 2021 05:42:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QezJAttiA6pgGtuBNPPubSFid3viL9YWmJBB0Tl6IksY5aj4HgqEL3PHuqlXDUoLMc9dIWlBTHqYdTD4XOICp8XvQnmAZf1Uu/Uvb3w+k4iiStmeu+oByIuxpjuLhQUnpHBA2b7tlkogPS0Ssq0fH5vrqjxG9H8cAodbXdUHaGQbe/YACQIb6/76jw5IQxkqzipbeK2hfpaH5vrUVCrgfDo/N2HMOKauObdLxgwDqKPZNi0Zodv7uiFgkZR83YXdw28XcCboA/Oy1M07SMxODVhtGuo+Dti8dpHgTM/k077bgPeAE4JOoUbow3i8uuvq+ouhyFg7vkbphckzpMHLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnkJqZNVjeyp+BTIqhDny/cSYfZJ2DWn/0JpXuN0gcU=;
 b=Y/YGNwDMIlNq/yCJnPERcfm/pD213ygYt9/bqVzIkPdyCaFrFQN90hOWySgnfGj9ozPWor8pqG1B9exKLoHxNNvkBSyUhVKyh+BizemjwhMnnpUBoAGWzewvZ+3wEcz6GVW4rFllhRbNzqDDN+ZbSt31o8zSMzNX9kXHy0hUxpDiemV1QTsBPhwklEg4Z48SSmkE/vQuQucLWJy5mcxGaWY8mhqraV0YXpW6ap0VgyuHEIlFDPpugo2EIsXBC+x19r65FKAD95m3UnY0tlfaEjsDQxB0S9GWex/Ol1pHNxVpNouD35zNIY/9WgoF3eGM5LololOYl40kk2zgKhWGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnkJqZNVjeyp+BTIqhDny/cSYfZJ2DWn/0JpXuN0gcU=;
 b=hU+h5/yHCyCihoRfiJdEcPQuT4vuZ+Yz7D75Nbqn5KdsEtMcfkzcdl+u/VTrdsuP3/J7Lc34kc91rIPePBGxO0pNgJIX55YiXFeeyJUZDby0OBdnY5pkCOXjjb4lt9pP89xNK/c6BtLT23j5cGFZFswluT816mKf57ECOIGD2h4=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA0PR11MB4623.namprd11.prod.outlook.com (2603:10b6:806:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 12:42:30 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4801.024; Thu, 23 Dec 2021
 12:42:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] mtd: spi-nor: core: avoid odd length/address reads
 on 8D-8D-8D mode
Thread-Topic: [PATCH v2 5/6] mtd: spi-nor: core: avoid odd length/address
 reads on 8D-8D-8D mode
Thread-Index: AQHX9/qMFRZUiMjnQEWnEwx8WAKUuQ==
Date:   Thu, 23 Dec 2021 12:42:30 +0000
Message-ID: <86f5c01f-6901-1995-d8ad-a1e6580f5e5e@microchip.com>
References: <20210531181757.19458-1-p.yadav@ti.com>
 <20210531181757.19458-6-p.yadav@ti.com>
In-Reply-To: <20210531181757.19458-6-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82fcc1ef-8ee4-45cf-5f18-08d9c611aefc
x-ms-traffictypediagnostic: SA0PR11MB4623:EE_
x-microsoft-antispam-prvs: <SA0PR11MB462330C2BEC3E81A9BA6B72BF07E9@SA0PR11MB4623.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jYIaMMMPCdIAYoxXzWnKdDDibSB/T894nEsGXGY4CzVwnPYhysl7R5q5Ta79k6q4rI8MANa5A/E0bjpIFrlZ703UDELxzdf1mEgQtOT2fWVHBGviHGoJS2HVEfiDhLpu+9RinL4GBmeXCxTykeOdzVHIE3+QPWPFprdVfZ5TJ1ktzbHlwAytG4ymtFBLomrpJz20kjFwlT3ZDzRp3w/Bp5b8vWAc0r+LW2pD46mtkLkMPYcmidJee9tZmqTszBR2Phiimz8h8YZXnHHZdZWU385LyO2wze7IEDp0YGtXYb5KVzxZ4f4P10KUxCFRvMgycFyzGuC9xqJr4gAaI+SNMpk0xkBNI3nDm5X1G6kVmkAB4ObReE6Aiznj8PLHp8e+HCrDlfoy/PyAFQ4N88Mnkc+fhcgBgk6O04HOWz00yXZ090VvRqFQIPzjEOB1KLXzFc83rjLuJQmTMtcuQuosKgXfKJhT4CYQ24FzcgSJ4m6XHZXauuW5DVWjSBlvQV/Hyn4LubfhHcwMp3OuSkfC020sDfsSZ+cXty03hPu0Gn7jobjI9YZyTJnzkq1nqV5Nn4dVbW4BJ6FNQ03CCCmipg4Sqtd20olI9lVagOT63fcaFJquaTs3SyULbBRvfIVhgtO1Dz9PGxcN2xYJCPx23Dd8ZbmVSaGwMYhBnHnA2Hq8ziEyczU2YFkQOuxktId6UtywXsY72NLpESlaz0oJ2IW/fRX9VqqW2OVn7SAjlxk2TRpdTpHnja/aEiJmM0yfeJhjEXXjCgOEycVOgpSqZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(31696002)(6512007)(6506007)(5660300002)(76116006)(66556008)(26005)(71200400001)(31686004)(66476007)(53546011)(64756008)(8676002)(186003)(2906002)(66946007)(8936002)(6486002)(110136005)(2616005)(86362001)(316002)(122000001)(38100700002)(66446008)(38070700005)(91956017)(83380400001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVQrRWlVWTlqZEZnaFZUYTY0VXBFVitReWo1c214YWYvY200bnQ2a01GUVE2?=
 =?utf-8?B?cmI0OHN5UTVRejBFRWdMOHNWejRabEZoaEhjREVOZE5YeHJwM0h1YUZtOWdz?=
 =?utf-8?B?Tmx4OEtHdmdMZzU2U1NxY1lnT3lDeCtubkZqZElBWWdkNVBKR2c4dndGSXZn?=
 =?utf-8?B?ZXdpa0pUZVF0Nmwzcmpla2I1VVJWeUQ3bEVvSUdld3grVlV2c2hJZ3lqaUY0?=
 =?utf-8?B?ajBVWGJkSHprNmpNSjhaYzUweUg2NnhnTkx6OXREVUJrY0FuVlFGeHdvZUxt?=
 =?utf-8?B?bjB4Um5tVDVOc1BrUGlyZnNKK2pIWjFheG4xQTBjVXNhYkhOSnhXSWJCUGJ0?=
 =?utf-8?B?Z2VmWldOUmVaSmx0S2NicTU2YjhmTGJ1ZlZ4S2ZvdEtzT2tXNEZIMUZtV0lC?=
 =?utf-8?B?UXNiVE1EM3pCMVVjK0FLbHlLNEx0MGt6ZzNQaFo1SzhqeEhVd0YrTkFPSDEr?=
 =?utf-8?B?SWJKaGdMeUhrR3Z6cERTWVlYeEhUWE1TMFp3cjMvVE5tZWN3RCtQOHVTZnZZ?=
 =?utf-8?B?ZjU3eDNkM01sVmN1c0JxSmFNYXVlRlRmdmRjQUxXb1VTcDZnanhWOFlicExO?=
 =?utf-8?B?ZnRacTBveWk3TzBGaEpaRHNMZkRmYzF5TDErUW9yS20zK2FFbEZsU2taOTVq?=
 =?utf-8?B?azZ0aGFEcGJuTTdCR0FmRklPMGZRbUpxajlMeDVaUWl2bDdHMitHUEVOdGg3?=
 =?utf-8?B?TjlLOGcvVWdBYzl3aHg5QVRodElmbnhIU202OFNRVzJ6WlhORmZLei9lUXFR?=
 =?utf-8?B?Zk9QaWVqbGJnMVVWSWRDL0p1VzdrY3N6YzQwRElVcXdwbTE0M0hheDY2eGxp?=
 =?utf-8?B?a0JzZGsrZUZPelJkT2huQm9aSXlvTzdMQ01walAwSTcwNGdpU0hFbDViaWhl?=
 =?utf-8?B?cUdtb1dqZW40VDYxdFp6Zm1MUnlsMmtsMlBLYy81ZUU4eWN5QmIxNGtNazR1?=
 =?utf-8?B?cW92bjVIYnNEM1MvQjdONUs4SnNtZnNSL2ZVaTZlMm5iQnV0cyszUkZqTXVS?=
 =?utf-8?B?VDdEMEpISGd0Wk9LTlo3a2pTK2hwRkdyS2V4SlE4alV4ZHpaNURCaWx1aXpL?=
 =?utf-8?B?ajVQVy9JTHRwMzlNd1o2RmxGKzd5UWdKZ3RUenp5YVZGTXRPOXdCUElHcmFn?=
 =?utf-8?B?RnRpTjkxOTNsVjhlcTdMK1RtYW15VGRzZ0xVWTFQL1FLdkpzaGlNY0JOWVVz?=
 =?utf-8?B?N1NjemRkaG5Nejk3NGJucnk3ZFBoTGN5SXFPQXYwajhJUDErV3lzei90ZnpF?=
 =?utf-8?B?THNHY2dJSVUrKzhVdEpNNjFYU2dzSy83ekNmUW1idGppREVCWDlRNGJyOW94?=
 =?utf-8?B?V2hCdUJXR1Zha0pOZXpHbjRZeHFJUHJ1Tm9CdStucEdnbkhnZjNSNE5qT3Ew?=
 =?utf-8?B?VTJ4aSttbXZlOE5zZFN2WFhQcnJjeXVnZXQvSlBsMGhKNnhyZ3NpMitFdDBi?=
 =?utf-8?B?enBzSHUva2h6Z2k4K29EZHo1WFF4Y2FQQkttN24rdlAzL0xCZ3o2UXhXYnFE?=
 =?utf-8?B?TTVaV21FQW9ScnlzM3liVzBnN051WTJBbzUwMFVVZ2tIQ2xqS2RKeUFDakNs?=
 =?utf-8?B?VHBuanJPRXVaQzZ4YXo1ZmQyVUI1ZHplc3RidXRxVGxQNEdBQjU4LzJXczl0?=
 =?utf-8?B?dHA4cDM4bDR6dFBuTjZWRWJOUDJQV3pVc2VlQnRONGE0ZTVnbnkyK1FHS01H?=
 =?utf-8?B?UXhvYVdpcW9LRUNlT1gxTDZSSFc2SmloL3NPbkFQTEtxckRHMkNWYUZ5MUwy?=
 =?utf-8?B?SWNVcm1vNllDcEh0T0ZiQVRGNllhcUg5L3NaQ0g4OFJ4Sm1NaUV2S1hDVHZW?=
 =?utf-8?B?TFRyS095aURRdUx1amJlbmVxN3pWMFFjYzlDd1dmYU1KZlFzeGNLcUxWVkYx?=
 =?utf-8?B?NmRwYU5KWFRnMkUrTW4xSmVxR0hEMDhuaFFFMVJFR0wvZWhkV21ZTmJRcWs4?=
 =?utf-8?B?OHlIY05vT3BWNUF6SlY2NTRIdFp4NGZiK2p2YXdZQkJYZlRTelFvbEtCcFl5?=
 =?utf-8?B?L3JZUE9kVjZ0c0RCNHZvbTVQTEJLUEdHWm14UjVXT3hVWmRlV1FDck4rNzV5?=
 =?utf-8?B?TU1Qck9wUW44UDN0VUErR1Z6U3hiOTMwSXI3MklaNk9CM0tUUC8yd1FrUTNM?=
 =?utf-8?B?ZGRSUU9rNkVYbFJEaHY4K0Fadk1NdjE4bytNUDRJaXdrcHRpWTdPY2orWTAx?=
 =?utf-8?B?M3EwS1VybHJBRWdqcDJuTlpFSkdld0ppOHBqOXUzNUMyOTlUby9PMWNGNm1U?=
 =?utf-8?B?S09EaVVxVnlUc3MycWo0aEJnN0JBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEAB3427B950DF468E416FFC81F80B76@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fcc1ef-8ee4-45cf-5f18-08d9c611aefc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 12:42:30.0880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2oG8Hosf9jQmuFM4vIQudYNCvxFWBBJwVmKQB/wCK8AMTceokN0wXhGbBI7cC5FHy1PKbzBr+YSnyfWP7ia/JdBvNw6/+wbKx2I4sblQlsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4623
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zMS8yMSA5OjE3IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCg0KSGkhDQoNCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBPY3RhbCBEVFIgY2FwYWJs
ZSBmbGFzaGVzIGxpa2UgTWljcm9uIFhjZWxsYSByZWFkcyBjYW5ub3Qgc3RhcnQgb3INCj4gZW5k
IGF0IGFuIG9kZCBhZGRyZXNzIGluIE9jdGFsIERUUiBtb2RlLiBFeHRyYSBieXRlcyBuZWVkIHRv
IGJlIHJlYWQgYXQNCj4gdGhlIHN0YXJ0IG9yIGVuZCB0byBtYWtlIHN1cmUgYm90aCB0aGUgc3Rh
cnQgYWRkcmVzcyBhbmQgbGVuZ3RoIHJlbWFpbg0KPiBldmVuLg0KPiANCj4gVG8gYXZvaWQgYWxs
b2NhdGluZyB0b28gbXVjaCBleHRyYSBtZW1vcnksIHRoZXJlYnkgcHV0dGluZyB1bm5lY2Vzc2Fy
eQ0KPiBtZW1vcnkgcHJlc3N1cmUgb24gdGhlIHN5c3RlbSwgdGhlIHRlbXBvcmFyeSBidWZmZXIg
Y29udGFpbmluZyB0aGUgZXh0cmENCj4gcGFkZGluZyBieXRlcyBpcyBjYXBwZWQgYXQgUEFHRV9T
SVpFIGJ5dGVzLiBUaGUgcmVzdCBvZiB0aGUgMi1ieXRlDQo+IGFsaWduZWQgcGFydCBzaG91bGQg
YmUgcmVhZCBkaXJlY3RseSBpbiB0aGUgbWFpbiBidWZmZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBQcmF0eXVzaCBZYWRhdiA8cC55YWRhdkB0aS5jb20+DQo+IFJldmlld2VkLWJ5OiBNaWNoYWVs
IFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPiANCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYy
Og0KPiAtIFJlcGxhY2Ugc2VtaWNvbG9uIGluIHN1YmplY3Qgd2l0aCBjb2xvbi4NCj4gLSBBZGQg
YSBjb21tZW50IHRoYXQgcmV0IDwgMCBhZnRlciBhZGp1c3RpbmcgZm9yIGV4dHJhIGJ5dGVzIGlz
IG5vdA0KPiAgIHBvc3NpYmxlLCBhbmQgYWRkIGEgV0FSTl9PTigpIG9uIHRoZSBjb25kaXRpb24g
dG8gbWFrZSBzdXJlIGl0IGdldHMNCj4gICBzcG90dGVkIHF1aWNrbHkgd2hlbiBzb21lIGNoYW5n
ZSB0cmlnZ2VycyB0aGlzIGJ1Zy4NCj4gLSBBZGQgTWljaGFlbCdzIFItYnkuDQo+IA0KPiAgZHJp
dmVycy9tdGQvc3BpLW5vci9jb3JlLmMgfCA4MiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDgxIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2Ry
aXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+IGluZGV4IGQ1MjFjYTU3Nzg4NC4uYTY5NmFmNmEx
YjcxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiArKysgYi9k
cml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiBAQCAtMTkwNCw2ICsxOTA0LDgzIEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyAqc3BpX25vcl9yZWFkX2lkKHN0cnVjdCBzcGlfbm9y
ICpub3IpDQo+ICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT0RFVik7DQo+ICB9DQo+IA0KPiAr
LyoNCj4gKyAqIE9uIE9jdGFsIERUUiBjYXBhYmxlIGZsYXNoZXMgbGlrZSBNaWNyb24gWGNlbGxh
IHJlYWRzIGNhbm5vdCBzdGFydCBvcg0KPiArICogZW5kIGF0IGFuIG9kZCBhZGRyZXNzIGluIE9j
dGFsIERUUiBtb2RlLiBFeHRyYSBieXRlcyBuZWVkIHRvIGJlIHJlYWQNCj4gKyAqIGF0IHRoZSBz
dGFydCBvciBlbmQgdG8gbWFrZSBzdXJlIGJvdGggdGhlIHN0YXJ0IGFkZHJlc3MgYW5kIGxlbmd0
aA0KPiArICogcmVtYWluIGV2ZW4uDQo+ICsgKi8NCj4gK3N0YXRpYyBpbnQgc3BpX25vcl9vY3Rh
bF9kdHJfcmVhZChzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2ZmX3QgZnJvbSwgc2l6ZV90IGxlbiwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVfY2hhciAqYnVmKQ0KPiArew0K
PiArICAgICAgIHVfY2hhciAqdG1wX2J1ZjsNCj4gKyAgICAgICBzaXplX3QgdG1wX2xlbjsNCj4g
KyAgICAgICBsb2ZmX3Qgc3RhcnQsIGVuZDsNCj4gKyAgICAgICBpbnQgcmV0LCBieXRlc19yZWFk
Ow0KPiArDQo+ICsgICAgICAgaWYgKElTX0FMSUdORUQoZnJvbSwgMikgJiYgSVNfQUxJR05FRChs
ZW4sIDIpKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIHNwaV9ub3JfcmVhZF9kYXRhKG5vciwg
ZnJvbSwgbGVuLCBidWYpOw0KPiArICAgICAgIGVsc2UgaWYgKElTX0FMSUdORUQoZnJvbSwgMikg
JiYgbGVuID4gUEFHRV9TSVpFKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIHNwaV9ub3JfcmVh
ZF9kYXRhKG5vciwgZnJvbSwgcm91bmRfZG93bihsZW4sIFBBR0VfU0laRSksDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnVmKTsNCj4gKw0KPiArICAgICAgIHRt
cF9idWYgPSBrbWFsbG9jKFBBR0VfU0laRSwgR0ZQX0tFUk5FTCk7DQo+ICsgICAgICAgaWYgKCF0
bXBfYnVmKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKyAgICAg
ICBzdGFydCA9IHJvdW5kX2Rvd24oZnJvbSwgMik7DQo+ICsgICAgICAgZW5kID0gcm91bmRfdXAo
ZnJvbSArIGxlbiwgMik7DQo+ICsNCj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIEF2b2lkIGFs
bG9jYXRpbmcgdG9vIG11Y2ggbWVtb3J5LiBUaGUgcmVxdWVzdGVkIHJlYWQgbGVuZ3RoIG1pZ2h0
IGJlDQo+ICsgICAgICAgICogcXVpdGUgbGFyZ2UuIEFsbG9jYXRpbmcgYSBidWZmZXIganVzdCBh
cyBsYXJnZSAoc2xpZ2h0bHkgYmlnZ2VyLCBpbg0KPiArICAgICAgICAqIGZhY3QpIHdvdWxkIHB1
dCB1bm5lY2Vzc2FyeSBtZW1vcnkgcHJlc3N1cmUgb24gdGhlIHN5c3RlbS4NCj4gKyAgICAgICAg
Kg0KPiArICAgICAgICAqIEZvciBleGFtcGxlIGlmIHRoZSByZWFkIGlzIGZyb20gMyB0byAxTSwg
dGhlbiB0aGlzIHdpbGwgcmVhZCBmcm9tIDINCj4gKyAgICAgICAgKiB0byA0MDk4LiBUaGUgcmVh
ZHMgZnJvbSA0MDk4IHRvIDFNIHdpbGwgdGhlbiBub3QgbmVlZCBhIHRlbXBvcmFyeQ0KPiArICAg
ICAgICAqIGJ1ZmZlciBzbyB0aGV5IGNhbiBwcm9jZWVkIGFzIG5vcm1hbC4NCj4gKyAgICAgICAg
Ki8NCj4gKyAgICAgICB0bXBfbGVuID0gbWluX3Qoc2l6ZV90LCBlbmQgLSBzdGFydCwgUEFHRV9T
SVpFKTsNCj4gKw0KPiArICAgICAgIHJldCA9IHNwaV9ub3JfcmVhZF9kYXRhKG5vciwgc3RhcnQs
IHRtcF9sZW4sIHRtcF9idWYpOw0KPiArICAgICAgIGlmIChyZXQgPT0gMCkgew0KPiArICAgICAg
ICAgICAgICAgcmV0ID0gLUVJTzsNCj4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiArICAg
ICAgIH0NCj4gKyAgICAgICBpZiAocmV0IDwgMCkNCj4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0
Ow0KPiArDQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBNb3JlIGJ5dGVzIGFyZSByZWFkIHRo
YW4gYWN0dWFsbHkgcmVxdWVzdGVkLCBidXQgdGhhdCBudW1iZXIgY2FuJ3QgYmUNCj4gKyAgICAg
ICAgKiByZXBvcnRlZCB0byB0aGUgY2FsbGluZyBmdW5jdGlvbiBvciBpdCB3aWxsIGNvbmZ1c2Ug
aXRzIGNhbGN1bGF0aW9ucy4NCj4gKyAgICAgICAgKiBDYWxjdWxhdGUgaG93IG1hbnkgb2YgdGhl
IF9yZXF1ZXN0ZWRfIGJ5dGVzIHdlcmUgcmVhZC4NCj4gKyAgICAgICAgKi8NCj4gKyAgICAgICBi
eXRlc19yZWFkID0gcmV0Ow0KPiArDQo+ICsgICAgICAgaWYgKGZyb20gIT0gc3RhcnQpDQo+ICsg
ICAgICAgICAgICAgICByZXQgLT0gZnJvbSAtIHN0YXJ0Ow0KPiArDQo+ICsgICAgICAgLyoNCj4g
KyAgICAgICAgKiBPbmx5IGFjY291bnQgZm9yIGV4dHJhIGJ5dGVzIGF0IHRoZSBlbmQgaWYgdGhl
eSB3ZXJlIGFjdHVhbGx5IHJlYWQuDQo+ICsgICAgICAgICogRm9yIGV4YW1wbGUsIGlmIHRoZSB0
b3RhbCBsZW5ndGggd2FzIHRydW5jYXRlZCBiZWNhdXNlIG9mIHRlbXBvcmFyeQ0KPiArICAgICAg
ICAqIGJ1ZmZlciBzaXplIGxpbWl0IHRoZW4gdGhlIGFkanVzdG1lbnQgZm9yIHRoZSBleHRyYSBi
eXRlcyBhdCB0aGUgZW5kDQo+ICsgICAgICAgICogaXMgbm90IG5lZWRlZC4NCj4gKyAgICAgICAg
Ki8NCj4gKyAgICAgICBpZiAoc3RhcnQgKyBieXRlc19yZWFkID09IGVuZCkNCj4gKyAgICAgICAg
ICAgICAgIHJldCAtPSBlbmQgLSAoZnJvbSArIGxlbik7DQo+ICsNCj4gKyAgICAgICAvKiBTaG91
bGQgbm90IGJlIHBvc3NpYmxlLiAqLw0KPiArICAgICAgIGlmIChXQVJOX09OKHJldCA8IDApKSB7
DQo+ICsgICAgICAgICAgICAgICByZXQgPSAtRUlPOw0KPiArICAgICAgICAgICAgICAgZ290byBv
dXQ7DQo+ICsgICAgICAgfQ0KDQp0aGVuIHdoeSBkbyB3ZSBrZWVwIGl0PyBXaGF0IGFyZSB0aGUg
Y2FzZXMgaW4gd2hpY2ggcmV0IDwgMD8NCg0KQ2hlZXJzLA0KdGENCg0KPiArDQo+ICsgICAgICAg
bWVtY3B5KGJ1ZiwgdG1wX2J1ZiArIChmcm9tIC0gc3RhcnQpLCByZXQpOw0KPiArb3V0Og0KPiAr
ICAgICAgIGtmcmVlKHRtcF9idWYpOw0KPiArICAgICAgIHJldHVybiByZXQ7DQo+ICt9DQo+ICsN
Cj4gIHN0YXRpYyBpbnQgc3BpX25vcl9yZWFkKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBsb2ZmX3Qg
ZnJvbSwgc2l6ZV90IGxlbiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90ICpyZXRs
ZW4sIHVfY2hhciAqYnVmKQ0KPiAgew0KPiBAQCAtMTkyMSw3ICsxOTk4LDEwIEBAIHN0YXRpYyBp
bnQgc3BpX25vcl9yZWFkKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBsb2ZmX3QgZnJvbSwgc2l6ZV90
IGxlbiwNCj4gDQo+ICAgICAgICAgICAgICAgICBhZGRyID0gc3BpX25vcl9jb252ZXJ0X2FkZHIo
bm9yLCBhZGRyKTsNCj4gDQo+IC0gICAgICAgICAgICAgICByZXQgPSBzcGlfbm9yX3JlYWRfZGF0
YShub3IsIGFkZHIsIGxlbiwgYnVmKTsNCj4gKyAgICAgICAgICAgICAgIGlmIChub3ItPnJlYWRf
cHJvdG8gPT0gU05PUl9QUk9UT184XzhfOF9EVFIpDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IHJldCA9IHNwaV9ub3Jfb2N0YWxfZHRyX3JlYWQobm9yLCBhZGRyLCBsZW4sIGJ1Zik7DQo+ICsg
ICAgICAgICAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHNwaV9u
b3JfcmVhZF9kYXRhKG5vciwgYWRkciwgbGVuLCBidWYpOw0KPiAgICAgICAgICAgICAgICAgaWYg
KHJldCA9PSAwKSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIC8qIFdlIHNob3VsZG4ndCBz
ZWUgMC1sZW5ndGggcmVhZHMgKi8NCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVJ
TzsNCj4gLS0NCj4gMi4zMC4wDQo+IA0KDQo=
