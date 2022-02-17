Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF234B9F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbiBQMBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:01:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240173AbiBQMBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:01:17 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEF729412D;
        Thu, 17 Feb 2022 04:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645099261; x=1676635261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1TZIwI5rSgy+1i4KqaUjlmAbpbuVXHBoyaNwYwr4WkA=;
  b=GNQn4Jg2yVu3ULORNqtZTTja6NQKTce2cC7sNjg3C1VwJeUeIdancIW6
   abJDrH3LeSksvmjnKf+OHDFsHr9iZlV+VwfldH3HgkVUT4GqI5GDEk1Ot
   FAKDhTtZ8RjnSmYE9tbPKhJGDRGfHyDGtGD6KE9C0xgL4RE9pRFxDwt2j
   tCsqZawzjv2NnEuvJd0yDeDyN2pBqm0B8wWqq7n7IT9iyrWLu4V6j8RnO
   KEIYm6asaeU129Mi6HuwZRbK3CRfGvoJr0IWjnKqInlY04qnkuI1q71Hg
   T/t59EhPh1JNW/ep6r90O2CvQfEQFvavdGQf6jNU5oTzqYpd7hObN53BE
   Q==;
IronPort-SDR: f0AYG9bi1Vio+e+OfLwkKLcBcuik1XiY8S7+2TTb8YooZHb8eJN/q4GcoEyvwq4wjZvDfMIw4f
 VJHFOYXM8tbt6zAdGqaLBvBDQ3IfGPPtw4l8anx1gMROueoq1s98wHI54aHlFS6uMIdl0Q35Vw
 ORMg7Yi1NCGJ7RoWU8s0I5Di/iNgtVhQBjG83BFk9jZ777V1Gatj2zdZbjKq0tUWCiF/qlFoIm
 7US9X2wc8H92TQDpvoikIY99egzLVaTt3S6nBvzMO/jfz3x7iMTTTo2d/PhcXnnABNDmjAKKUy
 aS07kU3LmPETpNwGXHQs+msJ
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="162619845"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 05:01:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 05:01:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 17 Feb 2022 05:01:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7cNxBaIRDlYZVwBVpP8wZIx9v8CoLRQuSCEAgcp8FEVPUQu4eP/tuyXneS7CQF06e2D+rGFMjkEA/u8uao87RJtmHrllLNrlKIEGP5dKWBoEhGAx2VFKncr6eAF6s60mlSTZmBEtSEIhdnU+EV3p5qOX7quzKCmuifcaCqLwlJEAIaC5eModUANb1krpg6AYvP3pdj5SaWADvSFkmH4fwIaEc+2YF0S4RNgacU10qVtLEXALcJ+KViT6oGCyvaV1ED+gApmEhFbEhF7cW/4GJZJFbA7B84Dc6Did5trtNoxDi2GPKerByBTJ/Bx6+670Ui4Q4HPLygWOMSaLp7ZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TZIwI5rSgy+1i4KqaUjlmAbpbuVXHBoyaNwYwr4WkA=;
 b=OPbodZiKLeSlFZQ+DEUMClCKMDUX24Btw4faJHjHvQ0wNQmEru8HUXGrOehDLLW+yC7O9H3b1WFdFkMyGEfsnI8cqZDrTksi8KwStBygd1lw7cb8R8TggpJ7nsfih9NZw38y+/licwXBYcUKo+WfY8wjSMJmKXZ1R18cXaie2tjZx6G3iAr/Bl5Pv1rS3hbg+0B1oZLG20OAdagdDTL1yBRl+Q+gQSVUP01sLXhs8DPh7UFheHl5db5FtkqlEinYuh58N4cTTB5VDt7WfcMsSk2mXFVnEVb+j4C/Z0ujRisl8B8vCIdk4Gq5OXzvrVJZGpn9t9y8jdMdHj7LqP+asA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TZIwI5rSgy+1i4KqaUjlmAbpbuVXHBoyaNwYwr4WkA=;
 b=IzHHmLa8zhn2+NoDH1yC+EiD8XraTBM+ABDNwX1ztGEGbweDAZqaOOjnxrz9qP/QmIuc/sk0AmSSa6LtcJzE0GDoHZanGitt599w2jt5S28T3TpS1HwwPRpAadh/2XjrlXLGajaXBAeWyYK3w0IcAeTzPJCasgoN0CAT0CVr+w8=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by SA2PR11MB5066.namprd11.prod.outlook.com (2603:10b6:806:110::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Thu, 17 Feb
 2022 12:00:54 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::28cc:a34a:d10d:bb99]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::28cc:a34a:d10d:bb99%3]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 12:00:54 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <a.zummo@towertech.it>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: rtc: convert at91sam9 bindings to
 json-schema
Thread-Topic: [PATCH] dt-bindings: rtc: convert at91sam9 bindings to
 json-schema
Thread-Index: AQHYIntm1Pqq+yVd7kOEGEIGfPFGg6yUvAKAgALrDgA=
Date:   Thu, 17 Feb 2022 12:00:54 +0000
Message-ID: <6689d4e5-55b5-2863-574f-38c6f72c0c37@microchip.com>
References: <20220215144649.14378-1-sergiu.moga@microchip.com>
 <YgvGSVs4v8IK/nwr@piout.net>
In-Reply-To: <YgvGSVs4v8IK/nwr@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 156f6a76-48cb-4a70-61c1-08d9f20d26b9
x-ms-traffictypediagnostic: SA2PR11MB5066:EE_
x-microsoft-antispam-prvs: <SA2PR11MB5066A91F300BB867FED6B40AE8369@SA2PR11MB5066.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KqX2L/LBmbtsZSNohsy8GDM+SVJlIQSl5u2J8nrKVVEIG2GP3txZOWAojl3pDdPIPZh2JvfSSOkCZwHNZdrVH4qzJZwJey5qUm4IKDxbxnTdHRYLVJvEx6QLJOA7af3aTFuB81lH6pLXr9i9S5dOh6be9YA3PRiOFLDKIHXavMQvn2qA/kmcJYyQkphkZwZNWFrUeW6ubBef/BLu53zPsHHFsO7IcqtVMRvbyePJYaX8r++XyyGx/amufsESGcFLJGnOu1tLiEvu0ztWfwekgQZmbeGI+07NAZh4J9tuWqvgbA1JH1jJp5XchzYpMDQPk3+GJdAVSnQJF2LexQdeDHK+SNLDiszBssCox20h8kqK+XVtCXkI9EEMaXMz/ukiD3K4aVJNk9fDD+1Yra5WtyZemmiJyWfsgWMoGeVN90Dl4HBTsojTMbJKYJH4Zy+kDYj0vlxK4YpPVfgLv+Bl+6kM6nLVStLqtTLcWbnah5XZhwCe1gfkj0tMiuGIEsFR7UzLpjrxQsaM2MWuVL6ZDNwi4+OHPNChzKD8jFqvSQsWVZuII/w8fnVohuWCNZ5dICWW2xLXNraBz82FWe0Erm12CygHYisFOD4/9XaHBgzqX6j+MJuWMPsCvqRKQJjPw6RyaXmwbrFrQeXHHBpAUh1kIw+9HTgeLF84yRBlthH6eaTEdpBiMlSshs5Ib5GxstQT4ys6352kKqlPrDqcJzUEnM/4fQoqU98MuCsc8aXzCg8eef6S32EVCOelmaw7IqyVkoxPk9CN2+Chlj07uGXHu7nmrnLo75enGpeKt8qpqizTGcbrTE61eSMO33LyErTVwU8Nz8pF9cRdvXyIGWuv6lAAPE8+34mT5E2xnaKNTt4dv/7zOCZGy/uApoM2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(4326008)(76116006)(66476007)(66556008)(122000001)(66446008)(26005)(66946007)(8676002)(64756008)(38100700002)(6506007)(54906003)(316002)(71200400001)(6916009)(53546011)(6486002)(966005)(86362001)(38070700005)(31696002)(8936002)(508600001)(83380400001)(31686004)(2906002)(2616005)(5660300002)(186003)(6512007)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUZhRHVDZ2xvK3BJQkJTUFJjS1UzRWpSMnVsMklmODJSVnk2SG5kWTNvNnlw?=
 =?utf-8?B?aEJiT3NrN1hYOGUrK1A2ditScXFya0I3QXcvYTdZcjQvblNadXdmVDI4dHhC?=
 =?utf-8?B?NUwwZnZXWXY4cFFEWXJ3R0VqQUUzM0gveVMrRjZLR29LUlpuOUhBdklqelNi?=
 =?utf-8?B?YUwwd29BMjFkRCtHUEV0WU1xS0ZaaUx5WUpNRmtpU0hYRzJkRHMzMFNMK3dw?=
 =?utf-8?B?WXhZd1J6UGRHcDFLZGNWZ1JjNk9mem9qY2JQWi9rNkdmbXkzUHNScXZMWEwx?=
 =?utf-8?B?ZVRqdFhudWdlZzcwelBSV3RtZUlDY3hWbzhGaURicTFYVGEzYXJOYTVSMDZV?=
 =?utf-8?B?MndscGtBMnpxbENPdlo4d2MzSWFLS3R0NS9ob01YcEhJOEMyTCtjZXlLSkJk?=
 =?utf-8?B?ZFh5ZWhDV2dPcTJDWXAvc3J5dUtZWkx6RnhyQ0FydHB5OEd5bVM3MCtKbnNh?=
 =?utf-8?B?Q2Z4T2hFdmU5UVhUTm05RHM2WklyOTdqUFZZanV6OTVyMW1lLy9wa0lDZktu?=
 =?utf-8?B?SzMzU01xZTQ0UHlUUFNuNDRoR2VUWDVGOE1VZDY4M0l6UVlZMEQrSGJWWjRx?=
 =?utf-8?B?Wjd0RVFMZmdER0U5K2pXMC9ocmxoL2NCMld0eE5TQkJkclM5MDUzbnZZdG9w?=
 =?utf-8?B?WUVTYlFNWXJwS3hyVWpMU2E1OERJVGxETzdmTDRCUllqN1YxN0syOHMyckRV?=
 =?utf-8?B?ckR5aGYwWExIamN6WXZDYmNoQjdSMHVmYUZkcjI1OXQrYkhFM3dEOEowaXkx?=
 =?utf-8?B?VE9PK2JjcTFtSkZSL1Z2a3lDN2U0L3ZyQkZ4dDJDRXhDQmlzQnlnMU1VdVNQ?=
 =?utf-8?B?d2pvaDhsV1lyS1pORVE2ZURYZHlvQ3JnTU1ZWWxXSXpHclkzYjNsSXBhdkox?=
 =?utf-8?B?Zk84RE9TYWxydnNDUXVwY0l1NDdTUGZFWFp2YlppdytFdksvb25RRDAvZ0Q4?=
 =?utf-8?B?dWlaa203blhTQ0xkSno4Tm00MHYzWm94OWF5ZzJLZUFiQjhRVjhsT2Z3UmI3?=
 =?utf-8?B?UFlaMWlidElob0R5bEphTVFKRjlNa2g1Y1JQZzF5Q2NuQkFZdVhuLzJSVnph?=
 =?utf-8?B?KzF2U3BXSTJYdU5PcmJtOWRaWlQ1Tk9wemwxZHFibmk3d3BubTM0U0ZLd3RL?=
 =?utf-8?B?Y2RvYmVGNlBraE0rbFplQS84MkFuT2dKVVNUbXVTUVlBakJOOHEvR0JacUxF?=
 =?utf-8?B?aWt6ckIxODRiZEFFVFkwUy9XNU5sVmZnYks1czI0V1puTnU3TGFoSGpCNE5K?=
 =?utf-8?B?K3ZyOCtsclIvOS9KRURBOEZJQ2ZiVkMvdW0wWEtLa3hkM2pMWXloSHV6eVE1?=
 =?utf-8?B?Znd6R2dNbkE4WnFDZkhqNHpqaEhyaEVHaVVIU2tDUm1uV29yV2lhaTB0MUJV?=
 =?utf-8?B?VUNjZXhWSmExbmw2WlB5cVl4clNRT0hzR24yMkt5M0c3ZWVwRFlHR0RYV09k?=
 =?utf-8?B?MFZkQWpQc1BaNDBhSWNiTmJnQmxYSDNRbFU4UVlqVExnaWh1TktxTE1jWDUx?=
 =?utf-8?B?cGJjZ2VDYzJjZStMNVh0d3BEZ3RFbGJwTnEvSnpIbmJBVDVCM0ZGdGlQcXA1?=
 =?utf-8?B?RWgzdUFGMndsTFY2TndxMS9VaG1ZSDM5MjN0R0llNEhyZ3g4eUlkbDZvWXhQ?=
 =?utf-8?B?TWxhUE5VZVlWTUc1elNCeldwT2xNZzhLQThidFJNSTdJOGVzeHZqc1g3d0tK?=
 =?utf-8?B?cEF4RjE1U21Ca2xvTTVhRzVhU0JoWnJsS1dCSlBoQlNCSk8zZTVCTzFBNHZV?=
 =?utf-8?B?UEU2b1BtMUlORVFtUW40RjFVOTdSYWlIenhNNjZNRno4NVp0ZlI4RWpCNzhx?=
 =?utf-8?B?eTdhQlB2VEdQY0JBTDRzSUw3TWVURTR2eVByb2tCTkpDQ3pEaXl6V3h0K2RD?=
 =?utf-8?B?VTg1Y0RQY09vREExN2dLVHJjVjd4R1cvUVJHTWVteldmSG0xWWZkWkRRcXds?=
 =?utf-8?B?aTNDZjg3T0ZvcDd1OURGM0JSdU52dCtRMnI3TlMrMFMyWmpKOWRtSm1ZVDdp?=
 =?utf-8?B?MDVBTXZUY083UXNWNEdKSEY1cmhxaTJueUx3RlRVZCtTQmVKY3JxRlpYeDly?=
 =?utf-8?B?UUtDdkZmaVVubStUL0lmbFh1OC9UQkFJR2xMZFNMR0RQRmkvZkhRTTl3d1BE?=
 =?utf-8?B?MkJkaDRYSk9NOVBDK0xMaVNJUEp4THEvZ0pmcFBBVmxSQzlyRkYrblp4NDB3?=
 =?utf-8?B?NlhmY2dEbkR2NGNEaTdad0JGL3o3R0c2N3JDRk1NSXBybVdqWXNaUE9kTEVk?=
 =?utf-8?B?SWF5OGNiZkdvMmVScnlxejZtckFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA9F617377CED8439594944063B26AAB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156f6a76-48cb-4a70-61c1-08d9f20d26b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 12:00:54.6878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76gAS40kendTUQ5rDyaHkeCf5Ps8VFV0Gl9Q1FJAThlzaVP3PzztNUIztWMaUnqEDoGX1UI0bovQKbUbyKUGPdhH66p5z48iIOmQ0Zxqnbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5066
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCk9uIDE1LjAyLjIwMjIgMTc6MjcsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0K
PiBIZWxsbywNCj4NCj4gT24gMTUvMDIvMjAyMiAxNjo0Njo0OSswMjAwLCBTZXJnaXUgTW9nYSB3
cm90ZToNCj4+IENvbnZlcnQgUlRDIGJpbmRpbmcgZm9yIEF0bWVsL01pY3JvY2hpcCBTb0NzIHRv
IERldmljZSBUcmVlIFNjaGVtYQ0KPj4gZm9ybWF0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNl
cmdpdSBNb2dhIDxzZXJnaXUubW9nYUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9i
aW5kaW5ncy9ydGMvYXRtZWwsYXQ5MXNhbTktcnRjLnR4dCAgICAgICB8IDI1IC0tLS0tLS0tDQo+
PiAgIC4uLi9iaW5kaW5ncy9ydGMvYXRtZWwsYXQ5MXNhbTktcnRjLnlhbWwgICAgICB8IDYxICsr
KysrKysrKysrKysrKysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCsp
LCAyNSBkZWxldGlvbnMoLSkNCj4+ICAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvYXRtZWwsYXQ5MXNhbTktcnRjLnR4dA0KPj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9hdG1l
bCxhdDkxc2FtOS1ydGMueWFtbA0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcnRjL2F0bWVsLGF0OTFzYW05LXJ0Yy50eHQgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2F0bWVsLGF0OTFzYW05LXJ0Yy50eHQNCj4+IGRl
bGV0ZWQgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggM2YwZTJhNTk1MGViLi4wMDAwMDAwMDAw
MDANCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvYXRtZWws
YXQ5MXNhbTktcnRjLnR4dA0KPj4gKysrIC9kZXYvbnVsbA0KPj4gQEAgLTEsMjUgKzAsMCBAQA0K
Pj4gLUF0bWVsIEFUOTFTQU05MjYwIFJlYWwgVGltZSBUaW1lcg0KPj4gLQ0KPj4gLVJlcXVpcmVk
IHByb3BlcnRpZXM6DQo+PiAtLSBjb21wYXRpYmxlOiBzaG91bGQgYmUgb25lIG9mIHRoZSBmb2xs
b3dpbmc6DQo+PiAtICAgICAtICJhdG1lbCxhdDkxc2FtOTI2MC1ydHQiDQo+PiAtICAgICAtICJt
aWNyb2NoaXAsc2FtOXg2MC1ydHQiLCAiYXRtZWwsYXQ5MXNhbTkyNjAtcnR0Ig0KPj4gLS0gcmVn
OiBzaG91bGQgZW5jb2RlIHRoZSBtZW1vcnkgcmVnaW9uIG9mIHRoZSBSVFQgY29udHJvbGxlcg0K
Pj4gLS0gaW50ZXJydXB0czogcnR0IGFsYXJtL2V2ZW50IGludGVycnVwdA0KPj4gLS0gY2xvY2tz
OiBzaG91bGQgY29udGFpbiB0aGUgMzIgS0h6IHNsb3cgY2xrIHRoYXQgd2lsbCBkcml2ZSB0aGUg
UlRUIGJsb2NrLg0KPj4gLS0gYXRtZWwscnR0LXJ0Yy10aW1lLXJlZzogc2hvdWxkIGVuY29kZSB0
aGUgR1BCUiByZWdpc3RlciB1c2VkIHRvIHN0b3JlDQo+PiAtICAgICB0aGUgdGltZSBiYXNlIHdo
ZW4gdGhlIFJUVCBpcyB1c2VkIGFzIGFuIFJUQy4NCj4+IC0gICAgIFRoZSBmaXJzdCBjZWxsIHNo
b3VsZCBwb2ludCB0byB0aGUgR1BCUiBub2RlIGFuZCB0aGUgc2Vjb25kIG9uZQ0KPj4gLSAgICAg
ZW5jb2RlIHRoZSBvZmZzZXQgd2l0aGluIHRoZSBHUEJSIGJsb2NrIChvciBpbiBvdGhlciB3b3Jk
cywgdGhlDQo+PiAtICAgICBHUEJSIHJlZ2lzdGVyIHVzZWQgdG8gc3RvcmUgdGhlIHRpbWUgYmFz
ZSkuDQo+PiAtDQo+PiAtDQo+PiAtRXhhbXBsZToNCj4+IC0NCj4+IC1ydHRAZmZmZmZkMjAgew0K
Pj4gLSAgICAgY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxc2FtOTI2MC1ydHQiOw0KPj4gLSAgICAg
cmVnID0gPDB4ZmZmZmZkMjAgMHgxMD47DQo+PiAtICAgICBpbnRlcnJ1cHRzID0gPDEgNCA3PjsN
Cj4+IC0gICAgIGNsb2NrcyA9IDwmY2xrMzJrPjsNCj4+IC0gICAgIGF0bWVsLHJ0dC1ydGMtdGlt
ZS1yZWcgPSA8JmdwYnIgMHgwPjsNCj4+IC19Ow0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvYXRtZWwsYXQ5MXNhbTktcnRjLnlhbWwgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2F0bWVsLGF0OTFzYW05LXJ0Yy55YW1s
DQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5jNzhhOGMx
YzkzMTQNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9ydGMvYXRtZWwsYXQ5MXNhbTktcnRjLnlhbWwNCj4+IEBAIC0wLDAgKzEsNjEg
QEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0y
LUNsYXVzZSkNCj4+ICsjIENvcHlyaWdodCAoQykgMjAyMiBNaWNyb2NoaXAgVGVjaG5vbG9neSwg
SW5jLiBhbmQgaXRzIHN1YnNpZGlhcmllcw0KPj4gKyVZQU1MIDEuMg0KPj4gKy0tLQ0KPj4gKyRp
ZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcnRjL2F0bWVsLGF0OTFzYW05LXJ0Yy55
YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29y
ZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBBdG1lbCBBVDkxIFJUVCBEZXZpY2UgVHJlZSBCaW5k
aW5ncw0KPj4gKw0KPj4gK2FsbE9mOg0KPj4gKyAgLSAkcmVmOiAicnRjLnlhbWwjIg0KPj4gKw0K
Pj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBBbGV4YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJl
bGxvbmlAYm9vdGxpbi5jb20+DQo+PiArDQo+PiArcHJvcGVydGllczoNCj4+ICsgIGNvbXBhdGli
bGU6DQo+PiArICAgIG9uZU9mOg0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiArICAgICAgICAtIGNv
bnN0OiBhdG1lbCxhdDkxc2FtOTI2MC1ydHQNCj4+ICsgICAgICAtIGl0ZW1zOg0KPj4gKyAgICAg
ICAgLSBjb25zdDogbWljcm9jaGlwLHNhbTl4NjAtcnR0DQo+PiArICAgICAgICAtIGNvbnN0OiBh
dG1lbCxhdDkxc2FtOTI2MC1ydHQNCj4+ICsNCj4+ICsgIHJlZzoNCj4+ICsgICAgbWF4SXRlbXM6
IDENCj4+ICsNCj4+ICsgIGludGVycnVwdHM6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+
PiArICBjbG9ja3M6DQo+PiArICAgIG1heEl0ZW1zOiAxDQo+PiArDQo+PiArICBhdG1lbCxydHQt
cnRjLXRpbWUtcmVnOg0KPj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy91aW50MzItYXJyYXkNCj4+ICsgICAgZGVzY3JpcHRpb246IHwNCj4+ICsgICAgICBTaG91
bGQgZW5jb2RlIHRoZSBHUEJSIHJlZ2lzdGVyIHVzZWQgdG8gc3RvcmUgdGhlIHRpbWUgYmFzZSB3
aGVuIHRoZQ0KPj4gKyAgICAgIFJUVCBpcyB1c2VkIGFzIGFuIFJUQy4gVGhlIGZpcnN0IGNlbGwg
c2hvdWxkIHBvaW50IHRvIHRoZSBHUEJSIG5vZGUNCj4+ICsgICAgICBhbmQgdGhlIHNlY29uZCBv
bmUgZW5jb2RlcyB0aGUgb2Zmc2V0IHdpdGhpbiB0aGUgR1BCUiBibG9jayAob3IgaW4NCj4+ICsg
ICAgICBvdGhlciB3b3JkcywgdGhlIEdQQlIgcmVnaXN0ZXIgdXNlZCB0byBzdG9yZSB0aGUgdGlt
ZSBiYXNlKS4NCj4+ICsgICAgaXRlbXM6DQo+PiArICAgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4g
VGhpcyBpcyBtaXNzaW5nIHN0YXJ0LXllYXIgd2hpY2ggaXMgc3VwcG9ydGVkIGJ5IHRoZSBkcml2
ZXINCj4NCk5vdGVkLiBXaWxsIGFkZCB0aGUgY2hhbmdlIGluIHRoZSBuZXh0IHZlcnNpb24gb2Yg
dGhlIHBhdGNoLg0KDQo+PiArcmVxdWlyZWQ6DQo+PiArICAtIGNvbXBhdGlibGUNCj4+ICsgIC0g
cmVnDQo+PiArICAtIGludGVycnVwdHMNCj4+ICsgIC0gY2xvY2tzDQo+PiArICAtIGF0bWVsLHJ0
dC1ydGMtdGltZS1yZWcNCj4+ICsNCj4+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4+
ICsNCj4+ICtleGFtcGxlczoNCj4+ICsgIC0gfA0KPj4gKyAgICBydHRAZmZmZmZkMjAgew0KPj4g
KyAgICAgICAgY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxc2FtOTI2MC1ydHQiOw0KPj4gKyAgICAg
ICAgcmVnID0gPDB4ZmZmZmZkMjAgMHgxMD47DQo+PiArICAgICAgICBpbnRlcnJ1cHRzID0gPDEg
NCA3PjsNCj4+ICsgICAgICAgIGNsb2NrcyA9IDwmY2xrMzJrPjsNCj4+ICsgICAgICAgIGF0bWVs
LHJ0dC1ydGMtdGltZS1yZWcgPSA8JmdwYnIgMHgwPjsNCj4+ICsgICAgfTsNCj4+IC0tDQo+PiAy
LjI1LjENCj4+DQo+IC0tDQo+IEFsZXhhbmRyZSBCZWxsb25pLCBjby1vd25lciBhbmQgQ09PLCBC
b290bGluDQo+IEVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCj4gaHR0cHM6
Ly9ib290bGluLmNvbQ0KDQpUaGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjay4NCg0KU2VyZ2l1DQoN
Cg==
