Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3DF4A3E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 08:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiAaHrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 02:47:16 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49843 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiAaHrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 02:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643615234; x=1675151234;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/XXZFwtsqZg0CMmx114PclfW39860mOqZk261m/fxJA=;
  b=DGNdb55vfyugwmSB1EuxMwJh/5ckmHI8SCSsio+/RBQCqsnQBzrvqwY3
   7RdXiY3lfMdO6X8e8oVMocm5i6Mykphl8zPxaxJZy9+sndrk5KGBVf2u/
   p6oVqyM0KWA4PS0UqMcEQh2n158ziKFB/jVi1DLcQQDb1xuhNoLT54htF
   JXbqASkb2NE0zaF62fe73+7R/8OcqZzX7Q8zwkWmCU5jq5j3PKwLJuJuZ
   i8USTRiTFbjZONKHzgOq5IpbBEZJiuCigmO1EcpquX2XP5Nxo/zmbFP/Y
   8kLOq6s1k82CNdo0ib/K0UoG7cD3c17YGUMALlRUOh8OwAR8NLclixo5y
   g==;
IronPort-SDR: O2EthfHcvG+22vqDktdLX5MVWAy5Xvv5MYKXYc5tsjPZYN99rtQVdALWhdUSZw27JN/J/XuAf6
 DWIbKDI+PYKk053OgmpiEjpDVfKl4SiqyHdrnMcNJ96WWycDg8N+adBecNzUtuI8ByvnyIjt9Z
 LxpVFYXWpUanaxeFrJCZrU8uQkHvU/N15a0zkLayD9xBz0JY8QvWjiDV6miMnQfl1dBFI/SOh5
 zOuDoXiCqcKy8hRpQpna5MHF80mzclo7zdxYXKVIzP14UhnkqJ+CYJHmFU+GGjxgP/EfG05mCb
 15COw2W+Wyt04iPA9p8VLxyt
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="160525563"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jan 2022 00:47:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 31 Jan 2022 00:47:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 31 Jan 2022 00:47:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxAzsbt/LJkR7T5FdeMcrwyg2yHmu83f6hInVlKVKKUxS36JpNTXtDongLCgUQiWo9X2J+fxMFWSH4e8wwHqwQQHavF/HrvZh6NGoZ9x0874mqia9f5TTlYHcuN96+/NVoOpi/8nvNw+gW+JIcmhAY7iW7S7SBvGL+TKlIKrvp9dvJpoEcNO7VleVsy2CVNnN+Pyuo4mX2DLIwyjURioZMbpJGnsUjUy5PSjMESuXJySD2CfOshBDP2sz7r4bwCff9ckMFS+hwl0Cytfdj1YhybTOl7t8IupFS9D36E4MZ3Pql5X6nw7DyrSXNCNlmBueLA+DiO9Bvzh0Q8bCNplvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XXZFwtsqZg0CMmx114PclfW39860mOqZk261m/fxJA=;
 b=DD15wsa5DUXoYnSc4OsT4n4GC0r86NA0dU2yPbug/CN2J+nP2gUzt2prKzrhoHZt5ONJwslsRR6wzwYBY/G8ZAZ3t6CfygUWoSdzHXIMIbvSCTz67+wZWKknEjgitjNp+n2HSX6aYGqgpQ7GeYiF+eQnQIZLOEqdvZtn4HyVJClF7UtRS1Sr9kLQ59mzVpX23dmw98JGerdJ1mZ/BDiTQLYP8JaZNsOfFvCI0dcYn/evfbB3JIrPmqcGkSv9tmc5J9jbxgTLNzQ6qpklxVdRtlVGYrHEArdORS4Ql196F2fcnbIYYdgd3b+TAXSmOPsbbtGOn7CYayO7730Ki5oH5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XXZFwtsqZg0CMmx114PclfW39860mOqZk261m/fxJA=;
 b=TIgUIetQdqS8JJT0VGiDexRcaA1xyRBb+zFqdKf6jh5mlCUO4R292uiXoXq7gMeGjvQAHyy3jsKPlMjJTKNv0EVZIyXi6J+N6L7Xs2X8jMhaWAe3Pto9V2egBkQ2J3u7t6zND0ZlgUIe+fJWeRqSQZM+DT9JVq0y23N1wL8drLI=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Mon, 31 Jan
 2022 07:47:02 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::5cae:e802:4a48:bd0f]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::5cae:e802:4a48:bd0f%6]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 07:47:02 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] MAINTAINERS: replace a Microchip AT91 maintainer
Thread-Topic: [PATCH 1/2] MAINTAINERS: replace a Microchip AT91 maintainer
Thread-Index: AQHYFna8Z2riHvmqzk6UUlkectq50A==
Date:   Mon, 31 Jan 2022 07:47:02 +0000
Message-ID: <9aa5be01-d0e0-3267-a347-7cd456830677@microchip.com>
References: <23819d8baa635815d0893955197561fe4f044d5e.1643553501.git.nicolas.ferre@microchip.com>
In-Reply-To: <23819d8baa635815d0893955197561fe4f044d5e.1643553501.git.nicolas.ferre@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b229f8c-6cdc-4749-fb32-08d9e48ddec0
x-ms-traffictypediagnostic: PH7PR11MB5817:EE_
x-microsoft-antispam-prvs: <PH7PR11MB5817170F1326AE284FD8DF8087259@PH7PR11MB5817.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hE1kAxRFkMRix+thKrwExjaK3I+rzSwup0A90PsNJlKpakwRyR6A+8LemcMhAUeyOBxYot4hjrWy6GGa2086ci/Joq6gFYsI1nj+i023HZR2lS230ocbfThfcv+a6huyK2QNwtsNdJTXmzRuHhS8COZw3S1hOg1ZJQJcSja1C4GYYKnB40UmIM0EMDrz5HDrh9YFxkRa770faPlX+b/md5GBT3f9LD++3+EU1kt/1EqWUGvnXaTbk/XMTbxVl0cpuf0wvR08f/S7u0GIG6taPXAsuQdHW62xZ1b/Bj+157wwKWXT9JEQZtyt41UcsPQOuHDeSEwzsIs3dxWUP8T9VqRERBnjV9VU/yhPuFDKSDrylJYPEFnfvT+tYoTaM94V4LL62qeQaNh6DOAnkaQ3JIstZGU++2gz3WCt5qhX44I5uTZjLd4pYX1GiQg9vXudrQHyWSy01bVa/Clq+ptfJVcZs16vcfVlsl2RK9dFso4NjshFOoaKBXw+JY59Tih/23Scs9kd0f/4tXnGlyz4TLe5C+Hasb4GBWEZzzDmeq/UAJiVPdYOf2pQtgXX5HXYh2mU8D71KyMajEhPZFvDkaOKGRjsV9MgcRVWo4GLHX4YhSRUXilWFtxyjeS0GWy7SNyoADzejYw83750E6ljVH+pWoZ3o5wlXBzkNIITZtc9lPST7XsrgJM8enqK8EOKsZExMavmGa2oUM9Thwm/FeArDVSp9sIK83dwSx4gTdtFQB50C8imcc7Ot6QFsVtKB96Hb3/4Yxgu8lOvgr0no5X4p9bvUOag/0ZQnAQ50CrGDHE3CLtANBMtoWLkNaGUiqV0ujpBOWOvWONck9uckJBpbnsks6VMhBiiUHroJRJgRHAoy4j757X6ucVwFDHzEkKEGZh78dHkfHycleYTOLckvKeFa+O2sB+wmfZkHI4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6486002)(71200400001)(26005)(2906002)(6506007)(6636002)(53546011)(31686004)(54906003)(966005)(2616005)(110136005)(6512007)(36756003)(316002)(4326008)(86362001)(122000001)(8676002)(91956017)(5660300002)(64756008)(38070700005)(83380400001)(66946007)(76116006)(508600001)(66556008)(66476007)(31696002)(38100700002)(66446008)(8936002)(45980500001)(43740500002)(18886065003)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2M3aHo3SGpxcEYzRUQ4NWhLVWttR09PNGRvTEVLci9RVjhha0dSbWFESUs5?=
 =?utf-8?B?N1BGYkdwcGtFdUpHVjZZYlVpQnVqaUJiVDdaeHBUWjZ5UHA4V3Jncm11Q1Vu?=
 =?utf-8?B?UzFaejgyazlFYmk4Mmh2dzBuNnVKV2tXMm9MRC95RFJUaTg1Y21zdkhrL29j?=
 =?utf-8?B?bVJPZGNNV2J0VlRjS1Vwa1FQRFcvZ1BYcjVZY3J3cU95ZmE2eEloK25XVm8x?=
 =?utf-8?B?V0h4VUtaRGhuQ05QMGltZWZUVFp1bnBsNjJidkM2UXpHWmh6MDcyTzE5WkxS?=
 =?utf-8?B?bTdqOHB1dVA4UGZMVGMwUURydi9ocDVOWTRTTXhpYXFNbzZ2d0VZcDVWRnlF?=
 =?utf-8?B?WkFXc1JJN1RPN2N6M0djYU5LZE9IS05ma3puT1liNTlsUmVhbXFoSnZROEkw?=
 =?utf-8?B?aFBUODBmeFpJL0NQazg4UkgvRXJhTCtVVExKTlJWWGtLbVhMa3MzQkxIUkxS?=
 =?utf-8?B?ZW1KOVViaEFhYjlya2IyMEVPbmlPU096aVF0eFNDZkM3cHEwRHREb2VyTVh2?=
 =?utf-8?B?Vkt6MlVHMWVqZEJNWEZwVkNXdkx5LzBLM3B4Y2QrdFlSWllKZTNkTmxsZ2M5?=
 =?utf-8?B?NHN0TDJ3VzF0dFlFYVNtY3NzZ00zSFFPUEFXazVvZ09QcXM2YzR4dVdIZmJI?=
 =?utf-8?B?bUVHdU5tQlAreFBnK3FNcS9UdVZLeFFRb2ZSL1FmRGlna3ZvaVhUNnFWc1gy?=
 =?utf-8?B?dlZBTGFTTG82cXVzV1lWYmdlNkk1QUhsMk9qWUlrQUY1RXJkc0hrblVZaU1X?=
 =?utf-8?B?UEhZdEJGUktENmlreTFBbTVqdHArYXNMeVpOaVc4MzNqV3htOFJ5dk9FUVg5?=
 =?utf-8?B?dlg5K3VqUzIxUFdVb0RhVjRMNGZ2Ly9ZT0hRNC84SWgrWnhGaHN1ZlFPb1pZ?=
 =?utf-8?B?QU1YR3lPOHVyYUQvYnNwWkg0cFczbmFZdnFHZ1R3K1JpSzNjcE1NMjF0M2Nh?=
 =?utf-8?B?UXlZYW9sQnRsZUZGalVkNGlML0tOdnQ4TlFlYXBiaTl4bFNrVUtZV2pVUUhC?=
 =?utf-8?B?S1RESmVDems1ZXd6UjRPZGVMM2YvQ0NoazFvMGZDdTBWUDJRdUJEYUc0NWdP?=
 =?utf-8?B?bWRpTndUdlV5R0dqZlN2TE52dHdxNjRvZFA0MjZnbk9JeVRscnV2S0dhMjdK?=
 =?utf-8?B?djIwWVgySlVBUjEzK09SZWNxcWRlenYrUkZabHc1WUo5dVN6TlFNcnBiakd3?=
 =?utf-8?B?eXJGMG0xOW5LSyt5NHhRRVNXQ3hEUXdGbkQwQ2JFQUs4SDVoRGU1TVdudXZr?=
 =?utf-8?B?dzBJWVZSQk9hNE9ZUHhHbUEyNSt1OWh3V0k5Z3JwT1FHOEFqSXYwWnIrMlA5?=
 =?utf-8?B?UENBTmhZcGdIUTZjMS9jT1JkbDRHeEJLNENnK3hlaWlGM0xFN1BOM2NENHZ1?=
 =?utf-8?B?MHF1SlN4a3FNTGJUTnZVVGttYTZSc0QzRkJ0Ukp6azBUM2JOaytha1k4a3BO?=
 =?utf-8?B?WUswY3BYQlAwL0wvU0FsUXZXcG5keHNJNkkyNnN6MnhlRlFiZm84Ny95a0gv?=
 =?utf-8?B?cW1uRThLVFZGWVN3enRxbERremVhWWozTGZXa1JCWE5JSlZVZDNPTDJjd3VY?=
 =?utf-8?B?RnZkZVhCcm8zMi9JMmFWVENHaURTb2ZoQ0U2UDZKMVpidnVGY1haVFQwN2pn?=
 =?utf-8?B?VlhEbmdFTi9PM0p3ZU9xbzlWQUc2bmU5TDczZzJ3L3VqbDI3TkdCTC81Ri9v?=
 =?utf-8?B?TUJNRVdaSXdjR1h4YzlHNnhZVlZ2ZWNGNjZmNW01ZGQxWnMwUW9xZHEwdTBP?=
 =?utf-8?B?MEx4bk1zKyswdnlYOU9NeTYzU2wydTVZNUxLU2xraEhPbjQyTDZlUThTd0x1?=
 =?utf-8?B?cW51K2tucTFOc2k4UG5VRzZGdFlFRGtTWWNuK3phWERFdko0UmZqMXo3T25h?=
 =?utf-8?B?UXQ3WnZYRWN4RUxBdndidjRtOVhVRlNxTjh4RjZHUnNRSzVOa0ZxZlYrd25X?=
 =?utf-8?B?c3pncno3dVJyS1N6R1hLc2JZdSt2cWE0dWtLNG1ETzRhYlNFdXJNR0ZVOExZ?=
 =?utf-8?B?WnVYRjRlMU4vd0pwT0dYdWI0Q3BCdjlTTVlPUkF2clZ2K0NiOVZIeHJjd2J0?=
 =?utf-8?B?NlRnaDQ4cW1oVDRLQ05ET2cvWnJlTEZxOGJSb2RoUWpWY2dBZU45T2ZuaVZF?=
 =?utf-8?B?UGRCOFh0dm1DdnVXZ21vTzdZd2dBdk5UQzBoeCtHQlNkZnpyTnZLVDQxOHU3?=
 =?utf-8?B?SllsbFAyV215QXpzY0k0ZXl0MkQ4TFl0NFNHc2RESDlVSGZvU1hsclZrUDBZ?=
 =?utf-8?B?Z2ZpT2Z3VjF6a3lTWlpMNjZrK2NnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17E2F029C1E30D4C9432627659861AEB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b229f8c-6cdc-4749-fb32-08d9e48ddec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 07:47:02.6940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZUhokgprKNNqdPHbZesH+4LvK2G9Zqf2N+xxWs4019zN0wc3Bo6TV54JtOQAsJ150P+N6Om7zJA0iw6mFsviqR+ybBI2zqYOp9xzsMK9bX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAuMDEuMjAyMiAxNjozOSwgbmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tIHdyb3RlOg0K
PiBGcm9tOiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+IA0K
PiBBcyBMdWRvdmljIGlzIG1vcmUgZm9jdXNpbmcgb24gb3RoZXIgYXNwZWN0cyBvZiB0aGUgTWlj
cm9jaGlwDQo+IExpbnV4LWJhc2VkIGRldmVsb3BtZW50LCByZXBsYWNlIGhpbSB3aXRoIENsYXVk
aXUuDQo+IEVudHJ5IGlzIGFkZGVkIHRvIHRoZSBDUkVESVRTIGZpbGUuDQo+IA0KPiBUaGFua3Mg
THVkb3ZpYyBmb3IgdGhlc2UgZ3JlYXQgY29udHJpYnV0aW9ucyBpbiB0aGUga2VybmVsIHNwYWNl
IQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNy
b2NoaXAuY29tPg0KDQpBY2tlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1p
Y3JvY2hpcC5jb20+DQoNCg0KPiAtLS0NCj4gIENSRURJVFMgICAgIHwgNiArKysrKysNCj4gIE1B
SU5UQUlORVJTIHwgMiArLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9DUkVESVRTIGIvQ1JFRElUUw0KPiBpbmRl
eCBiOTcyNTZkNWJjMjQuLjdlODVhNTNiNmE4OCAxMDA2NDQNCj4gLS0tIGEvQ1JFRElUUw0KPiAr
KysgYi9DUkVESVRTDQo+IEBAIC04OTUsNiArODk1LDEyIEBAIFM6IDMwMDAgRk9SRSBEcml2ZQ0K
PiAgUzogV2FycmVuZGFsZSwgUGVubnN5bHZhbmlhIDE1MDg2DQo+ICBTOiBVU0ENCj4gIA0KPiAr
TjogTHVkb3ZpYyBEZXNyb2NoZXMNCj4gK0U6IGx1ZG92aWMuZGVzcm9jaGVzQG1pY3JvY2hpcC5j
b20NCj4gK0Q6IE1haW50YWluZXIgZm9yIEFSTS9NaWNyb2NoaXAgKEFUOTEpIFNvQyBzdXBwb3J0
DQo+ICtEOiBBdXRob3Igb2YgQURDLCBwaW5jdHJsLCBYRE1BIGFuZCBTREhDSSBkcml2ZXJzIGZv
ciB0aGlzIHBsYXRmb3JtDQo+ICtTOiBGcmFuY2UNCj4gKw0KPiAgTjogTWFydGluIERldmVyYQ0K
PiAgRTogZGV2aWtAY2RpLmN6DQo+ICBXOiBodHRwOi8vbHV4aWsuY2RpLmN6L35kZXZpay9xb3Mv
DQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4IGVhM2U2
YzkxNDM4NC4uNjc0ZDEzNzA4MzI0IDEwMDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiArKysg
Yi9NQUlOVEFJTkVSUw0KPiBAQCAtMjI1MCw3ICsyMjUwLDcgQEAgRjoJZHJpdmVycy9waHkvbWVk
aWF0ZWsvDQo+ICBBUk0vTWljcm9jaGlwIChBVDkxKSBTb0Mgc3VwcG9ydA0KPiAgTToJTmljb2xh
cyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KPiAgTToJQWxleGFuZHJlIEJl
bGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPg0KPiAtTToJTHVkb3ZpYyBEZXNy
b2NoZXMgPGx1ZG92aWMuZGVzcm9jaGVzQG1pY3JvY2hpcC5jb20+DQo+ICtNOglDbGF1ZGl1IEJl
em5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4gIEw6CWxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZyAobW9kZXJhdGVkIGZvciBub24tc3Vic2NyaWJlcnMpDQo+
ICBTOglTdXBwb3J0ZWQNCj4gIFc6CWh0dHA6Ly93d3cubGludXg0c2FtLm9yZw0KDQo=
