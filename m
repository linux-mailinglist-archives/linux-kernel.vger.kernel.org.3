Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904FD4B07B9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbiBJIGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:06:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiBJIGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:06:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A5B1092
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644480415; x=1676016415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R85V00aiw7QcXpmAbuyYZNOPZPAtqazVtuN4lazl4Ng=;
  b=qxkiE2I9KHxlRA1gAQIAb/vBskZxRQt92tmwU32EH6VMWjUKOq9H7CDM
   +g0jJp7ykeHbWvvCwMRoG3dPoNFEqBxeCVp0qgMuzO6w1xDg9OufzAgEw
   Lu859NCsfZp/wJ3q2CzQwFSXCIEpzq0EAXRhCWd8eFj+uCEUgx3BuHNYv
   w+Aj0xOABIaG7Io6Q0OSFGHIE7AEOMkuKBqbObksgVRGauZiz5smeZLfo
   AKtZwz6P+bdTNxxxN2C1WuXk8aMNJVInB78BWjnAd6qHyIRabv/+/49IC
   +Laz+uEWxjFhFQjxHkc9JFoJ+mrC+ogP8823ghxPOGawaArHCJCvRYFKK
   Q==;
IronPort-SDR: eiFCIh/Ymn8yeMf3UGYu6X8deTXwwXeD0G4qn6Mrz3vHkONLf+Gjj5pSsEYjkSal7cTq43MiUR
 PpUR6C36y9M+1vvE68lbvnUMutImVRwDLINZOpvBA6B8pqOsVU5450NHAQq4IkIrUds+C8l+mT
 dMso+4mUSlyWYMoccycivT/Z3u0fqEdzwzjz0v4bnIqDVAvXczk3nLO8ReuG+rxqohU/BQHpXG
 w8fJPt7wFo47tAsRribYI92O3m6T8mwgOOGjR2SQdv+QJYn4PlOmQMW+fWeneqLZxXIGqy18uu
 9XIuBw8z1qyLVWzGsef1RCE8
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="152579686"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2022 01:06:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Feb 2022 01:06:54 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 10 Feb 2022 01:06:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeXahwn5csQ7XjTUCEg9k+N4iSbTdezlohDLDTjXQMMArqZnb8t/cyeatP1LDg8+scOgFiFm+7z3r4yKYqt/bHNC1/TMZSCI2ZflacOb435eoYwtCsuYrJroig8QbTyj9Y9ALlDndJKXoXWxPotR9IULuALCpeQfCIwuJaB19lSHpWGiYjPF+6J+cCuOPSiyVBfcSv0JLnePRJyLqwj9y0MJ7VEVuKXRpIj4l9mDYxCcEKjYHmN8nLiIF6UdJQ4ZgLJ9UodgzuXDpYJszKDJ+6acXxepeacAQdUuNrGIbLDf98HU980C9gfW6yeuUoZaOYGliVBPUfyVH+sa2NzwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R85V00aiw7QcXpmAbuyYZNOPZPAtqazVtuN4lazl4Ng=;
 b=cy8Ual0weVesGYfzbsSywUEuqAhhlj3kUZj/AqXSYAX4a6L8P+VIhJDF/u13S2vB0i5S1LQegXNMno+YlNVffx5Xqr42kFNNu9HsD+4GuMiAHM90SOKeyzIWT982LD4yRhtcYBtsXGtv1JDlaW9DgdjYALZnME29v381fNUF7yg8SSZp30rT2DZB68hn6pI+HRLAEtO0upGQ1xQqiEZJgaAzNUAsHNMkro48sK1Sg64xEr6C6Kl/X3LmxvVrLodfhNw6kTRfUDCWfJUDsmG+evzG7EPgsSRSASltbRD7M83tfnAcDOovSvOI/amXznJCwMzv0oZuvKHBfaUYvc0dVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R85V00aiw7QcXpmAbuyYZNOPZPAtqazVtuN4lazl4Ng=;
 b=j44XyJ2Dq1v3T9Pmg24ahn/BiBKCDCRdnDDUSQ1zf3tDsswQPQQxQSb06frJbRdby5mfCD1bsU7lzMryvTGXihBgDY9HT1DgNj4sahs4uZsN7NQB0PZFtkM1+db1S/xWA7RH8mu20QeLFNBiCHMGo1ZcxkJ/lJ2JzJvjyiKn7uQ=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5195.namprd11.prod.outlook.com (2603:10b6:806:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Thu, 10 Feb
 2022 08:06:53 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 08:06:53 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v1 05/14] mtd: spi-nor: xilinx: rename vendor specific
 functions and defines
Thread-Topic: [PATCH v1 05/14] mtd: spi-nor: xilinx: rename vendor specific
 functions and defines
Thread-Index: AQHYHiuFz8+evF2o8USFiXwNjUvH0Q==
Date:   Thu, 10 Feb 2022 08:06:53 +0000
Message-ID: <d76f21dd-4038-57de-f2f6-6afa947b62cb@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-6-michael@walle.cc>
 <68aa414b-7a9d-1330-531c-37b2db2ab09d@microchip.com>
 <73d3d8ed2cb4ca1b06902b767fe529c3@walle.cc>
In-Reply-To: <73d3d8ed2cb4ca1b06902b767fe529c3@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d1cb7ba-2792-49dc-41cf-08d9ec6c4c9c
x-ms-traffictypediagnostic: SA2PR11MB5195:EE_
x-microsoft-antispam-prvs: <SA2PR11MB5195952989590C23A64D4DDDF02F9@SA2PR11MB5195.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /AK2OhC74v0SQZ+pcVAVvNfFv9JmZs5r2rzWGoBGlOfNMQxwKFKtCpkDFAWxW/2DDzlO2mp8IhgVIGZIf87JKm8EahcKjXcr90WccdXSELyJGt0om1ewuMV5mz0dPjpi2H6OxKytgJYu5o/Ob2tseQ0+Xubue090a7R9B9Iu6x1y4ntbGXF+jnegWwBqoHYyExykRxw76cio/PerK5jgDv8pNYbg2kXGoizNcGXCVJW0EmMAaeHiPyYOrtZsEiGKzSpLlNf/Ektk3dPxAi2yQ8/K0EUZI9ctvXE7ZOk8pLL1/de3d6YblNuJWb7W5dd4d4ucOIRas4Dei66Kcgm+xvcjlzwwrhxWsgM90KCDR4a+Z/99Jg4Q706X2BmDuc0HbcV4Pt5s+8+hlAJub4zCntYc7L1eHOL5CjTO4EPs1MTkcvH2nrGsb5hKX+o6sta1GPL4/N+GJ90VZr9511Wyhum2qEXRmX9X2dUjyTot3HQN68gUh3MNDxpkqL7GG3jYYR5tAUABSQgnJ9Q9iS60RPKC98g4gnDd/hFHBRBLcrzF8xM2CGbGj1s0QZ8I7PNDReabVJ/oNtJTsCr3EKeGOfeJZi5GOQSou//0MgwhBYzpUGP2sJm8el8Zb8p0SKAM11PxPeBeADdsr3mld5BT3x1CVIPP3XkpT0n8hhZm85hl4ctKZf0DHvke4he7/xsEVEb3UQc5jc37qv7oac1T7xvbPo8FbdtnosfdSt45inImEhuPL/6DCwSFSskro292cBHUBYVRkQSHypMfDwSWTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(8936002)(53546011)(8676002)(6512007)(6916009)(66446008)(31696002)(2906002)(4326008)(64756008)(66946007)(54906003)(91956017)(86362001)(38070700005)(76116006)(31686004)(4744005)(36756003)(26005)(5660300002)(6506007)(508600001)(38100700002)(2616005)(6486002)(186003)(71200400001)(316002)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STQyZTJiRGpyMmVrSUYwUDZaY2lHcWFmQnEvWEFKTEJld3U3TnJZb0lQRlNT?=
 =?utf-8?B?ZzBqQnNvb255S0I2NlIxUUxwVXhWSHJNdUlYdEppQ0k4Zlk0RlhvM0tmR0c1?=
 =?utf-8?B?TUd6cWp2MzlEbEhzeVJMWWNTUGI2WW5WNldmS1d5TE5Cb2FTYlppYk9IOTFU?=
 =?utf-8?B?QVpaWDFMZDVxQ1BUVnNoRGxQV014cGFibFlIQnkzTjRxeFFNYWJrbkc5RER3?=
 =?utf-8?B?ZzJiQUJldjRFbzE1SGxZWjNZaE9aNklNYkZaRHMxODBZU2VsbytDMXYrdzNV?=
 =?utf-8?B?MWpMcE82dTBjdFdGbXlKYzVlK3FMMldwaCtjZEhLajRrWWNLbXRyYk1udUZk?=
 =?utf-8?B?OE5rbi96bEZOcW1IeXJCRFkya2hQTUgvdjlBVFZjVTF6dlBSV2xiOEVFc2Nj?=
 =?utf-8?B?KzloNXFsekpuM1BDa0x5ZnBnV2oxQnFkNDBwb0NPZUFHMG9TcVN6UXY3THBz?=
 =?utf-8?B?WitHQmRlNVpLRVY4OFVNeUFQUGhFbzNKV3RrY3pkOFJtL0ZEaWxYUGRNN29Y?=
 =?utf-8?B?TG4vMXdSbUhmcEM4Z2dKUDBsdm1qYThISWpISEhPRHdjSVZBUElrVVZjR28z?=
 =?utf-8?B?YlU5dkgxcTN1dGovbDV6Wm9LWE5SQW0yVFBMeGlsV0dDVTRnZldRQVp2Ynhx?=
 =?utf-8?B?L1Y1VzJTcVltL1RUNzhTKy9DNmR0aFhzaGlTTHp1NmMxNTJyenFqOENBWlla?=
 =?utf-8?B?dk85YzVCQXpha0lQZXZWWkdJb0pvNGg0ek1PcFQvekQvaUYzZC9oaXNLS3pq?=
 =?utf-8?B?bkN3aWR1K2s3cEZKcVBrczNzT0lwdkRlSzlRNzY4OEtPQ3gvczZkNVpVSkNa?=
 =?utf-8?B?RjdvdkIxN0w4NytRbnN0OFl4SHFHZk9oSDcyOFVwQTlkdFV3V1VwKzJ3czBn?=
 =?utf-8?B?c0ltWmhWYXo3RDUvVVJYU0tZdUtKdUU5aVRMazJmQVZWOTJIaHh4VGZ0SVlK?=
 =?utf-8?B?bFZOWlg5QkwvdW41NzNWNE5XQkpTQWthbVRnanNnTlBJM1JES1pSQktKMVFi?=
 =?utf-8?B?MzNtVmpTTi9ucWlyWU5wYnd1di8weGFnb0JDQm0wWCsrZE55ZEI0ZzZCS0l5?=
 =?utf-8?B?eWQyTCsxNk5vY2ZEcllUSEw4SXV5SCswckxBSENacTNkaVVnQ3p6L3djeWZM?=
 =?utf-8?B?WEswR3FzTnFPZnRGRy84S3dWNGtXSmRySXE4TDFaakZGaW84bUhFVG9MSmwy?=
 =?utf-8?B?dnM4ZTIvdi8wWk9rTzk3NkJUUDFWTjhtMUMwdGpucTY0aFlzVjB5WkVqVTJW?=
 =?utf-8?B?a2c4VTRuY0FhV0hFcSszRGdRUTBreTJLYlFsVUk5NUlwYkVWYTgvRlNSWElR?=
 =?utf-8?B?dzE4TW5OdG11aGxueUNFNWJyeEJxZ2JZU2tOVWYySHFBdkFpYy82YXI1anZ6?=
 =?utf-8?B?TkpMVFJLMVVzazNUWjBZTkJSdDNGdU1zZk9oaHFMUngrWVdjSGorTkp2RmNU?=
 =?utf-8?B?SStDd0pOcFhLdnZWV1BrYktHZG9HVk9NYlZIRVFNZWtJbWU5QkJPM0RYb1VQ?=
 =?utf-8?B?dEM0QXFOemN6d240NlBNcEs3UGFBNDhaYjhBcmR0bTZnays2akE0M3RpM3JM?=
 =?utf-8?B?dVJrSklLdVpzZ25uOFVLZWtLODR5VUJKTW5lcjZ3eHlFR0RiWTB1NXFyZ2dB?=
 =?utf-8?B?bjNCZENRZ3FhdHg3alBEQTI1UXBueFFTWnZRMHZlaVF4dVZ4T2JhMndJK1BL?=
 =?utf-8?B?cm5pbW9sOC82L095NnVjcFdsOXh0YU5TdUhyZm5UZ1FvTDNLeWhINUlMVzF4?=
 =?utf-8?B?U0MwTWVsVlQyRTdrNmNaTFgzUGJZaXNualhlZENSaEFNcEVvOHVsYmZOVHZX?=
 =?utf-8?B?UEFzcHB6ZnBpLzJlalZGcEJDaXZzdExWcnBpb1RTZEJBNDdiaDlUMFNSTmZW?=
 =?utf-8?B?YjltVU84b3p4MDNiMmlXWVJCdGFqemFRRUdSNnYyUW4xWXh1QmxnMGV4ZFNF?=
 =?utf-8?B?dXNoaEpROS9HK0FEcEJPYXpZS0k2WDNYR1RpV3crZSt4VVFLOFJic2thcUsr?=
 =?utf-8?B?ODIxaUtwajB3aXNoS0hnUTdobERIWXMwSkQxWFNib3N6ekVnaHV5a1QxQWxE?=
 =?utf-8?B?RkdUNloxOWNqS3ZwNHNJOXZZZkErcGRXZERDaGduWWoxdVA0VjJXcTVROWpN?=
 =?utf-8?B?K1BJOFRLTlR2QWp3SW9lcnVpMGdjRytyanhRTWhzcXVtRWNET2V1ZmpTOUZp?=
 =?utf-8?B?T05tU0tlbGMxK28reHc3bmZKeHJaeXpObGdSRnR2MUdDZGV5WGkxOWpSZGNM?=
 =?utf-8?B?c1ZFK3VERFNhQ2NkaEttamRJTWJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE127C22CC83C442ABB51C6A9E38D2FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1cb7ba-2792-49dc-41cf-08d9ec6c4c9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 08:06:53.4943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: phl2GFKddkvzgyYRGi+euyy1BrdRrOsq/KAdZcgDCRhIKdMMFlVJt40nIMZiChmzAZyUHayFr1RYQUCLbESeY1fRrZ9G9tndLOBh8XVchHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5195
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xMC8yMiAxMDowNCwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTAyLTEwIDA0OjA4LCBzY2hyaWViIFR1
ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDIvMi8yMiAxNjo1OCwgTWljaGFlbCBX
YWxsZSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93DQo+Pj4gdGhlIGNvbnRlbnQgaXMgc2FmZQ0K
Pj4+DQo+Pj4gRHJvcCB0aGUgZ2VuZXJpYyBzcGlfbm9yIHByZWZpeCBmb3IgYWxsIHRoZSB4aWxp
bnggZnVuY3Rpb25zLg0KPj4NCj4+IG1tLCBubywgSSB3b3VsZCBrZWVwIHRoZSBzcGlfbm9yIHBy
ZWZpeCBiZWNhdXNlIHhpbGlueF9zcl9yZWFkeSBpcyB0b28NCj4+IGdlbmVyaWMgYW5kIGNhbiBj
b25mbGljdCB3aXRoIG1ldGhvZHMgZnJvbSBvdGhlciBzdWJzeXN0ZW1zLg0KPiANCj4gQnV0IGFs
bCB0aGUgb3RoZXIgZnVuY3Rpb25zIGluIHRoaXMgZmlsZSBzdGFydCB3aXRoIHhpbGlueF8gOykN
Cj4gDQo+IEkgZG9uJ3QgaGF2ZSBhIHN0cm9uZyBvcGluaW9uIGhlcmUsIG90aGVyIHRoYW4gaXQg
c2hvdWxkbid0DQo+IGJlIGNhbGxlZCBzcGlfbm9yX3JlYWRfYmxhYmEoKSBiZWNhdXNlIHRoYXQg
bG9va3MgbGlrZSBhDQo+IHN0YW5kYXJkIHNwaSBub3IgZnVuY3Rpb24gYmVsb25naW5nIGluIGNv
cmUuYw0KPiANCg0KdGhlbiBsZXQncyBwcmVwZW5kIGFsbCB3aXRoIHNwaV9ub3JfeGlsaW54Xyoo
KT8NCg==
