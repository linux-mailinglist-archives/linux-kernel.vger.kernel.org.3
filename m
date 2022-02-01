Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCFF4A5801
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiBAHoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:44:21 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:42754 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiBAHoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643701460; x=1675237460;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U7pR5FQTY2JwNN/fxAfdPjqfjWWeezfnNFJ73c5loug=;
  b=v2e939gauC7MwRNW/nXxmkStyaynGO19efdrnebVeg2FbyU8Fn7JGHpN
   /lJ5A9eFb+jr5ByYjrWigZXAmiB7d2UqyXrAeRsFKCL3jCyHPevYyw1XD
   0ML2RGBWdPwqP1HR3quoUq55EwuA8OcxaETduKZlWwcX4CsKJidMbYArO
   eOaTDLz+CRWy+USgota/5ZUHPPF6TThsMrZFi8Eh7AOxtDTyISBHMZoF9
   5uM/w4HV8OKgEjgmFcxaf83ZEDN5rzQ0sut6i0KkpIt09vlhLM9pOwbBC
   nYmtS9h8iwjMFbQljw6Lmbg0z438L4wVwIKZXazGGGCwVV8u5j45otV3R
   A==;
IronPort-SDR: QMW2Pi1eu0sC+fCKh92UxgUjOHLi4EwtpBz4plPNgEn2dSbig7SFUSTcUa5YycPnazDmlmTotE
 R72RSdlArbzWFQqfzm/r24CG3pQXqyJ0srYppouHHchHdK1eqrEPVj3qzAZTvnLHIe6piqe5TH
 xEstT7d2Xb56g0z65RkvW0I3NLPXyGNMtYCq0FjVNJgVwW3SYWjK5vR4IcdkyhVtrGlmuSsiss
 Rs3JZu/PPUowO9GytgsK7jQpPV2mkRB60pk1mF12Kc0fMSyFKfAubZTrpbkTYpoHSm2WwxQ70D
 s7H9uwzGtCEx05D1ytKMzn3f
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="147226263"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Feb 2022 00:44:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 1 Feb 2022 00:44:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 1 Feb 2022 00:44:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REuvjfn4yJ48wOvhJgNsbgD7M68QP7oERcduruSOtMtkU/SwsAMIywJzgd7QIIabs2OXU6eZXcAe11KhYQ/Okau0xVL6I2fm2GRJR8cMVDU/3gg4Bo3xWL7V71NxjfTf/IXant02CaZifbq9iEOlZXoqsA/vsXanDdZI5BbrdcuijKSz+BYRV6rVo4iXOfWfzOGgzxkh3nGQFaIairvd5HyicScDtCVP5AFCiIjb4j863Jid+82B71quKBS4/lTeMx+AgRieXK1pvvladdEuIz5nAPAQhlCGYbppNgpAjGZQjqJ5fcs0uIDEswBlwdJ4yCaPGyqMJ8Du/FfIzq0cJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7pR5FQTY2JwNN/fxAfdPjqfjWWeezfnNFJ73c5loug=;
 b=C+MtvTpnhvLd+Qs3IipQ1Yj8HuaLcBsywbOVoVsUr5RFf9KKcMiDfM0nuqTS7rzgyZjeKlG1E+h1x8vP0+Q//GwbwAa/N8X+ICJLg6l5eUmoplYh74n3P6ijsi974xCooftGpBTn5OavuHkjKrBB1mLbs8BoFtVF8bNGxUP4KN8TA1NtS6LJx1G9t1enllE0PCBkZVMthnTYzi1tJX1YBpOiJuRPbuX4FOJZwZo42F/3MGLUhids7uIfFgT2pM7VtCDbgK4J7RXI9mrCEQoL+gWnPyyJj3hyslf5SMD6CNZoe/HfMgvP9K7oyfOWlviqrlK4M1Twss1tgUPd4Sx3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7pR5FQTY2JwNN/fxAfdPjqfjWWeezfnNFJ73c5loug=;
 b=NxGrc1UJdzrc0uNzDXdiJQxYtVvSYEmuSHbANMojbZ4MInkaoAkC3aLI1gXFAHA7S/V20bmKzbT4hogJTsRxeCR/My7pGSaX40kpBWwAXL5/6f3Jc6p6Gyj7dKdotcHUwJ+99jdtYIK1LXMhzRAv61O1O1Y0kAv1eVVTeL1fQFs=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BN6PR11MB1985.namprd11.prod.outlook.com (2603:10b6:404:46::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 07:44:14 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dd70:c5d5:fa3:7d94]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dd70:c5d5:fa3:7d94%2]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 07:44:13 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <broonie@kernel.org>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>,
        <tkuw584924@gmail.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-mem: check if data buffers are on stack
Thread-Topic: [PATCH] spi: spi-mem: check if data buffers are on stack
Thread-Index: AQHYFz+BS3IM40TunES2XfV2QHH/cg==
Date:   Tue, 1 Feb 2022 07:44:13 +0000
Message-ID: <366bad2d-ebb3-a2a5-330d-ff9019d18733@microchip.com>
References: <20220131114508.1028306-1-p.yadav@ti.com>
In-Reply-To: <20220131114508.1028306-1-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e26a851d-3092-4ff3-9ac4-08d9e556a482
x-ms-traffictypediagnostic: BN6PR11MB1985:EE_
x-microsoft-antispam-prvs: <BN6PR11MB19853F12E0A9A7E3F6E87518F0269@BN6PR11MB1985.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wv/mfrE7tddXiSw2RXvrguxx85WnJiA/FiOyZD2GThbGKENrvbo3CWxvpozEf4F3nfupeTaJFdQQva5T0dShQKCMQKpZ4Sub6Hc/yZg3nwg499tnE05ajNy5vBLBHUM1n/iMgT5p1n+pE5VrOEpQiNBYs72vvXVNa3jZg/BEP/6wDsq00egtFF5m6VFz5e5Bg2xOSK1nAkrrm/BYDN5BiPPIFiv69+r5mKfaMgVhHGAY1OKxsiZEUO6eOq3XOdQzAwu8U1NFAgnHlVNG0z/KC5cBzTmk9/Me0SuNnSm+nfD7K2F0S8ApPKvnNoYA1sx4LOlIjLAkD2Xveamm3fwIpaj/wXnvSDwByrApN27C1wpo0OfkGHB6MwppXnXV4CfqZYZse4Dd0ukTAJ1b3gP/b88Fw8ZQTH4afeUiH3ECg0O6HoAAV0X+lWBwLoHpoXNV71KpeXVpEI/SWzICEPSNr5aNJqZbSTrMEJ+JJUlFCUnnxhPRl4KfOdnZWrqBzr5Xh0pTlrcQpUAA8TvT6YL0T2N0TwRJW+VsMc8NJIoAWaeZyJ2oOcuE35+trSPkie/1ZyQv3ilhc5vKsVcLzuMxyuIMPXbtKEJYDG0kUNro4Q1aDlPYoeQvQpDSMMlHZ8417zIMLDQqsXRuIPhztynRen4f6DlRVm4ZKKu/VgFgUeFaYqpMgGFGtrZn8+0dsZK7m2aCj/KMkUiFs6vSfisbDFm1XCafFpqa84CeTUk7QaTfX8V3b3sTwOK31bppUWmukaqWNaTTaNJY4B8M7thgpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(66476007)(508600001)(86362001)(76116006)(66946007)(66556008)(31696002)(6486002)(316002)(122000001)(31686004)(38100700002)(54906003)(64756008)(8676002)(4326008)(8936002)(91956017)(36756003)(66446008)(71200400001)(5660300002)(26005)(2616005)(2906002)(53546011)(6506007)(186003)(110136005)(6512007)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TCtSV0hNNlVLMWZqZ2hoYXlGc0F1Nm8xV09STmMwWWtOT1NFLzRRWHpNMTFI?=
 =?utf-8?B?bVF2QWc1c21SNUdxTmIxZDA2RU1EOW9pemhIVGNVdU1DQ0dSSElZZ0tkUzVh?=
 =?utf-8?B?Y1hxdTFsR1AzQlRnT2g2UEdnN3Z0YVdvd0tMSUlvaTZkMkhScHlzcUxCbW9S?=
 =?utf-8?B?NTdNNkRFQUxRNWVpRUpVbkJ4bS9wdGpzZ1k4aDJyUUYxRVBhUXpMaG1ZVUxn?=
 =?utf-8?B?ZllxT2RiZG1QSEZwa0syQ3BpQjBadXF6bXdjeWVvYkVFN1hjTmJtUFZ6VGtl?=
 =?utf-8?B?K3RrQzd2eVNmY3JqbW1tUDhhZU1YdFVkQkFiempDNElRK0IxZEgzeXZRNHhl?=
 =?utf-8?B?VzFRRC8vU05NSU1qUWZ6MVh0Um5MNWlXNHRpbVlyclVxTU5nQ1pldDljdEt1?=
 =?utf-8?B?YTRnellGSmZna01VSXF6OGhWRGpaTEp6QkNPdmVlN0N1Q1VocEorbVRNUUFL?=
 =?utf-8?B?MFpOQnhsQ0ZLRG5BRFpVUUR5TTBtWUY3UzlWb1IrRFVONXlHY3pZTGJUVGtX?=
 =?utf-8?B?SnBxdWZIL0hwZmYwdzByeS8wbWIvQUNmeFBpVmIrRzNGdjZpZkVidmpTMnMv?=
 =?utf-8?B?VWNaTm1DR21VUzhrSHpMSThGbmZzajhqMk96clA0LzJsckNsalF2bG1WU1Z5?=
 =?utf-8?B?cWRUZzdMTmxNd2NZZXVnT1hNMlVCYzJheUJWc3Mrck5xTDZ5cnRVc3NRV2oy?=
 =?utf-8?B?YWxEek5EZlVGTGFuS1BsVXNDU0NRdlpzRHN1dGlLOFljWlVFaTIwNXE3b2Ez?=
 =?utf-8?B?ZkFKWm9IazVDckoyQlNmanJSclpwTUhFaHlaL1NzdTRFTmdqOGFaVno4WFZz?=
 =?utf-8?B?ZU5KMTkwV0QxN0Y3SXR3WEZ4TGJ3ZndYUVQzcTNIRGdJYldQV1Q4Y25ubEtZ?=
 =?utf-8?B?QVA3WmlNNnB0Sm9NVmU5dmtKb1REYWZuM2tkUUN3Q0ExNnB6ZWtxMklaNDZG?=
 =?utf-8?B?K21lY0trNXh3NUZMRzFjeHJxeEFGRG5PQ0VRdEJwS1U1V2JmQ0Y1M3NWcGw2?=
 =?utf-8?B?aURZazZjWkJ3SE5zQWxQV3o2TFY2dE0rUHhuQ0xnVVkzNlY5UWNRWjJSRHRV?=
 =?utf-8?B?cUZDa1pTcmVCZU54THo1NHdmdGpEM2huaG5DK1VXblRWWFZRTVB4YmZoU0hG?=
 =?utf-8?B?OWVnQWJ2TXZyY0pzV0IraEhUV2J6TGc1TU1LUWdDb1ZjaktENDJnVTB3NlNL?=
 =?utf-8?B?NWVVWDZCZ1VVOXRkQ2ZzbEVWeEFxbStDdmhyQ1p1cVNsNzRrSm9rM2IwMG9l?=
 =?utf-8?B?UWFKbTZIZnJVakVqOVNzYkNHU3czU0UwL3cwSlBjS3o5Y0hQSnJ5V01IRUEx?=
 =?utf-8?B?anphNVJ1K0lJUWpXQWF4VjVQNk1hRjlJdVBVUWFuVkU0S3NaakdSeWVkM05N?=
 =?utf-8?B?Q0Ftc3JPeVA2NEYvZk9iQlBmTU8xUFBqOGtuVkpjcUxIYUYvY1JqaFI1dmpC?=
 =?utf-8?B?TEdZRHRSOGtjK2Vic0E0N1FraTVIQXVHVjlCc1lMbTk1T1R6b3lBWXJnUzND?=
 =?utf-8?B?cWQ0enQ0VXBqaFNnKzMxT2R2cGd0bUkxN3U0K0NGUXQ3S2RuRzFXcmJHVkI3?=
 =?utf-8?B?VGJWc3BoQUxkNXBucm1MNk00TThKU0NFNDNJTGdzV1dwMFNSOC9OY3R6MmIw?=
 =?utf-8?B?UUZaTXVkTWpFd3pWY0RsYXN4ZDAvUlY0MjVuclkxdGR3ZUpFT0M1Wk9na0JE?=
 =?utf-8?B?RDlFZHYyejFGUUZFK2orSWl0UVBiTk1WVjNSUXB1U0R6TjVITk1BcTJwalRv?=
 =?utf-8?B?ZlhGcnBMMnl0aDROMkxGNUZkQUF5S2MrWC9zR1ByZ0wwNytOTXNiL25Sb1dy?=
 =?utf-8?B?dVlJM1ZnK3JhOGJWT3BtSlpiUUJLNEhRTitPc3c5S2FibklWMGVJWVhCR0Qv?=
 =?utf-8?B?cmVXWlIxWThZblYvMlN5Q055dHllc1Vzcnd6cU9jNEdxYXFQQ1JGSGNUTUlB?=
 =?utf-8?B?ajg3WGU5Y3M2TTUwQ2xYL0psUE1PTExDRmFETXlqNXBNanJ5NVJTMUFPcnVh?=
 =?utf-8?B?TU5Ub1ZZYlpkNXJwb2dBSldhQ3BDZkJiSjFCTFhyM0l4WFgzS29BSzA2Vm9v?=
 =?utf-8?B?U2x2Q2RTdDQ2cmZjSWVZRnBhUXVZWjdINkNRMFpuSHgyOU54amFPKzJEczZq?=
 =?utf-8?B?VWR5aHlwd0FSaVM4OW0rY2ZDMHVZK1czTC9Ua2ZndUp4Vm5tSGpGMEZkUTJM?=
 =?utf-8?B?WjVzNnQxWmx2ZmZpRGVxN3kzVTkxbjdRRVppVnF6ejNycUZrRCtpMzJhWGFC?=
 =?utf-8?B?eng0T3VsTHpKdmxoNitMTHY0UWdBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23A44FAD159A3E48AF998BD0DCF5D6EA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26a851d-3092-4ff3-9ac4-08d9e556a482
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 07:44:13.8668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rdyCAroMmcJiN9JMxDUFpw7mBIDUqGxLqqzt72E71qQZ7fSohFTYwpzIiqxpNqxJfRLqAO98Fb5930Q5vx3tHdW1W2obOtTL1cKxoMEnJ70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1985
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8zMS8yMiAxMzo0NSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhlIGJ1ZmZlcnMgcGFzc2VkIGluIHRoZSBkYXRh
IHBoYXNlIG11c3QgYmUgRE1BLWFibGUuIFByb2dyYW1tZXJzIG9mdGVuDQo+IGRvbid0IHJlYWxp
c2UgdGhpcyByZXF1aXJlbWVudCBhbmQgcGFzcyBpbiBidWZmZXJzIHRoYXQgcmVzaWRlIG9uIHRo
ZQ0KPiBzdGFjay4gVGhpcyBjYW4gYmUgaGFyZCB0byBzcG90IHdoZW4gcmV2aWV3aW5nIGNvZGUu
IFJlamVjdCBvcHMgaWYgdGhlaXINCj4gZGF0YSBidWZmZXIgaXMgb24gdGhlIHN0YWNrIHRvIGF2
b2lkIHRoaXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQcmF0eXVzaCBZYWRhdiA8cC55YWRhdkB0
aS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zcGkvc3BpLW1lbS5jIHwgOSArKysrKysrKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3NwaS9zcGktbWVtLmMgYi9kcml2ZXJzL3NwaS9zcGktbWVtLmMNCj4gaW5kZXggMzdmNDQ0
M2NlOWEwLi5iMzc5M2EyOTc5ZWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc3BpL3NwaS1tZW0u
Yw0KPiArKysgYi9kcml2ZXJzL3NwaS9zcGktbWVtLmMNCj4gQEAgLTIwNyw2ICsyMDcsMTUgQEAg
c3RhdGljIGludCBzcGlfbWVtX2NoZWNrX29wKGNvbnN0IHN0cnVjdCBzcGlfbWVtX29wICpvcCkN
Cj4gICAgICAgICAgICAgIXNwaV9tZW1fYnVzd2lkdGhfaXNfdmFsaWQob3AtPmRhdGEuYnVzd2lk
dGgpKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiArICAgICAgIC8q
IEJ1ZmZlcnMgbXVzdCBiZSBETUEtYWJsZS4gKi8NCj4gKyAgICAgICBpZiAob3AtPmRhdGEuZGly
ID09IFNQSV9NRU1fREFUQV9JTiAmJg0KPiArICAgICAgICAgICBvYmplY3RfaXNfb25fc3RhY2so
b3AtPmRhdGEuYnVmLmluKSkNCg0Kc2hvdWxkIHdlIGFsc28gY2hlY2sgaWYgdGhlIHZpcnQgYWRk
ciBpcyB2YWxpZD8NCmlmIChvYmplY3RfaXNfb25fc3RhY2sob3AtPmRhdGEuYnVmLmluKSB8fCAh
dmlydF9hZGRyX3ZhbGlkKG9wLT5kYXRhLmJ1Zi5pbikpDQo=
