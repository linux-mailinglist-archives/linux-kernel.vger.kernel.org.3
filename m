Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D6E47E3E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348516AbhLWM7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:59:33 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:16337 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348558AbhLWM7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640264372; x=1671800372;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=VdzY4+hA1mxEzJCHgZ77J2UtkOrxYsIVbi/kUbJ5paM=;
  b=H+2s8fkQIHeki/jlO4prcCZVZnwmlvWojJgyP31O9YCJAD+fyFyqZkwJ
   pDPVRSKE97qyaPQt9iwHTB58AX4ifmjbhnxWR+tordoBiHEhzyIC99cs3
   bRr++OnnnL17zM3Ll5ucvlJVz2/L9zsXDsFkjNIAX6BBMeIo+x2kbXQHY
   ZMcEeJDwAd1kL5OuYA7loEKtH+9WnAVvZI4MGqhgSOZHsNDksf1Y8b1EJ
   VjeejVWmtZzqtvBuC4Vet4pw81SuBpSZpmgTS+KgdIR/q7rdg6z7Yq2Jy
   DBVoRpUV08lzjwhl0wnRCxTSgZAZgswecyrvQz0cf+Ge9JDz7YG8O4J8F
   w==;
IronPort-SDR: hsKoFrlD6iV4jAd8Uod8l1wnC1awlOTxoHkB3qixQrKYzyCSl1XpMyhJFB1XNyzWqXPOlI5Rth
 K+OepJFQmfWbedverd0yT1xDheLJBE70rM5bni0jTuG41nhH9V29tRZ0T7syrPA/NS1c3Kc8do
 Dc5yFXNjQlNK9wk+N43sP3DE1ngaAUV9j145XjC8N3tdz96USaCK/LU7Kulbg/IlACaxSqcrSf
 ZSdndno0dcihK30Oc/Yi4qjMFhW8cIuH6z0wiNKC4/+eeNo2lQZ6UAUco4R+FwFaDz0mS7qY4X
 pPhy84W7FuS4L+GxBCnFNuSF
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="147606720"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 05:59:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 05:59:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 23 Dec 2021 05:59:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XB9pRci1qOTWWu4c6EqdlLZTkeAY0p0eA+WRRW7KiVIzkBKM/TInjzkDYqZM896MOGaJhPCj6fP6G4Lys6KmxfD4LktGoGORISy7Xwn3u8/4ONeSamNWXR7GmQcOeFhhuRWgtJvDD6dUJcWsLVOVUOBaS+M8KHFSwKX1+Dia6P5e5LBVVd3PYY3A6xpFOrGsETqpzW3I5Yn/QYEuM5fxSKAvNCl5baDlydj1YMsEH4nySnhlqmJCZVjyhI3TP3+szirjLqGe6HSND213HZWW8QZlaqF0qWL+4UNTF7qqLvyHQk9GC2hCd9wpJCp8xnFiri3hfiqjDS3ggHEzYNiNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdzY4+hA1mxEzJCHgZ77J2UtkOrxYsIVbi/kUbJ5paM=;
 b=UftRiSudcDGECpxLE10YruDO+CKmuTMWylgO3XF9xP5xKH/6x/A5Dozb253bC/1+H+HNe/6tBB5Ch7Oh6UlqfUzw26PnfOhQgv4RDwkc5blTLVSKgm0HS6sp/stMosiL15Dg6Aq8jdcXuZlz+PQ7Qw5l7CzdkeiYBYiqcOWKTZNlGeZrNttBnGNtmlxEyiA/LroeH86wprwhmrqkUNJgYLdWtwYiZE/pVtoP1TgRQ8kl5sXsjciI2GvV3ERmI0iayOZT82iEvfntr9A0jp/zUGLnuB5Y2Lqooe/NEw2E4N73fMubdCd/Ctvv5Qsv7YwW2IflBViU5TwXwQa13C2wVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdzY4+hA1mxEzJCHgZ77J2UtkOrxYsIVbi/kUbJ5paM=;
 b=c4e2Xdjec8DrTC1txvRxP5UN3n9kEkiAJpFeEp/HXxN/t/pVUkUQGIUuf7eVDE/1D9jL87QO8PK9HfEXloNITWmzO/Thxb29ju61oYsPC+0KtIXi1tx2oE9hJWW3ghx3c0RJjg3W1b5Pf8zF24A4YtG+TLzVB5uUtD5HHprTRoQ=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3487.namprd11.prod.outlook.com (2603:10b6:805:c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 23 Dec
 2021 12:59:29 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4801.024; Thu, 23 Dec 2021
 12:59:29 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] mtd: spi-nor: core: avoid odd length/address
 writes in 8D-8D-8D mode
Thread-Topic: [PATCH v2 6/6] mtd: spi-nor: core: avoid odd length/address
 writes in 8D-8D-8D mode
Thread-Index: AQHX9/zrLXrw121yvE+Ca6lw9QdNMw==
Date:   Thu, 23 Dec 2021 12:59:29 +0000
Message-ID: <91d954d5-f301-76ba-2da0-9e088b7ae291@microchip.com>
References: <20210531181757.19458-1-p.yadav@ti.com>
 <20210531181757.19458-7-p.yadav@ti.com>
In-Reply-To: <20210531181757.19458-7-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebe9e656-7e75-46fa-6452-08d9c6140e7f
x-ms-traffictypediagnostic: SN6PR11MB3487:EE_
x-microsoft-antispam-prvs: <SN6PR11MB3487B293B2D11792DAE83187F07E9@SN6PR11MB3487.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h04k355YHTzqSPfR/qPpF79dL944vThugR7rC0cE1ZQQzRs5BARsOB0TqEC/RrjhjikerfJScbZ/qN5ZSTIimtwb3D9E5ar70NEtE9cTF7wkaA7alq5qqSgS3BddvCGmhxbOirDISiz8dBeEl1hn6QslyBC3ufLRU2d4FRqBJA2OgKvPzgKyUXH756XHUVNTzeWwc2cSPmi962IBRKPcNb2mFX2LoPtFBHDvnCfXTGFf0E9HFxJDUYpZGQCke3L35Hzk/eyN1PwQBVV3tsqYNsBVkbRMzHKKWpCFcA3uHVEP5qx7+yd9LOAgESrzLrCQ6oMUVEmqF+Y7OsHNZazbLa1wpQHwfy4fPzZhxwH0wgymX8062ZsOPuNhb7D0jQP9F7ub/XG5yTWjh8F9v7U9/IEsj9eaZtOX+Tmk81KHwqbjuysfhOgbieSU4QrtsW9bq8LgzaEiXXNymWRPFBaBI+z1600BmhTEhQUwFgHdmacgb6LwFIbfqOcEhiyNXn+TJR+7JSXgWXHByMqzdqqEDNi2eVuW0Swp0kVzN3a+qI5opFz9clw4kmfiRpkmmzrJy6kVlhwrnZ7zrofVIz1QPPqDGcImZUteFnK6NFp/2/3Xqv69JumibHNKw9V7UJQO15ZPmvVQlx3MuK+Htd05dXeerE4vSDrDMyhnO9QdZzo+DS9ln8J5kHa0euV6arS59GeCbpF7apKPJCrZef4vrQWm8QkyJASLcu2U3jLcY68P1dbLPnzcEZoY3TO6u5oMvMv1UR0/dX0MmGA951X3bA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(122000001)(31686004)(91956017)(83380400001)(38100700002)(2906002)(38070700005)(8936002)(66446008)(64756008)(66556008)(66476007)(76116006)(508600001)(66946007)(8676002)(5660300002)(186003)(2616005)(71200400001)(86362001)(316002)(6486002)(110136005)(6512007)(36756003)(6506007)(53546011)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2ZJazFBRWZLZzlnYnlwbFQ4VkVWNlZ2N29DVmJSNW15TmRPcVlXRW9YMk1M?=
 =?utf-8?B?d2VjZVpTL3FZaVZyZnphR1JYcGRIZ3dqRUo5K2VubytvVkRMY3dJSEZHWFY3?=
 =?utf-8?B?NDRBRHdla1c3N0RrQ1N2TzY5NXNtM3ozd3pYdmJGTVNMbmFQOENwUi9WaVp6?=
 =?utf-8?B?M0JEb05SREo4TW9UMHlQa3pGZzRBS0hYQ3djaDFlUS9HR3RnbTRIb1dnYWZP?=
 =?utf-8?B?UzlabVc5Z3FVY2Vma0RyTlZGTXRCVUV1VVhjeDJJR0Mrbk1USHI2bUNvUU5s?=
 =?utf-8?B?dmVEM3ZqeWFUZUN4TVhYRzdpUlVTWUZ0VWRIaVBHOWxUdDBrVW13MDFqUHFU?=
 =?utf-8?B?eGxKdVY0cVhSY0hoUllCakxSejB2bWRuNW5tK3NkWEdpdHZYQk4yTURpYk1v?=
 =?utf-8?B?NitkME1vVXdmZW1MdFJXVXhHM3RuV2szVGJ3N0J3QU1LSkFqaEIyNUlqdGVl?=
 =?utf-8?B?aGRPMDJCZ3MwTEpiUTRYWEptdS94Z1NLNkkrc3M4VnJjM3hRMmJndjlTVVZr?=
 =?utf-8?B?VStPWWl1cHJqTkZHM0xhb1FTeVJQblVHSm02R0YzNmdsQ0VwNlBXZWhFdFJ4?=
 =?utf-8?B?WVRuaHVwekkzVG1GTE9aVy9mODBrQXd1dHkrczAvMDFGZDkrVWFlSlFnWUty?=
 =?utf-8?B?VTZLTnlueVJSN1FpaWQ4dDBwUmcrMngxOWZ2YXVucnZKNURrVjhxQnZuN1Qw?=
 =?utf-8?B?Yzd2TXRhVUpNMS9tYVdiZjU4L2wxSmtxZjg3YkRWWkgxTjUzaitaUkRCT2VV?=
 =?utf-8?B?RlNOL3VZYWtqQ0w5UktuYTNLQnhvUHZwZkIrenFxSENHbStXOTdzWElaNHJ6?=
 =?utf-8?B?dkZsTGVZaVZzUXdQanFvQVVTNTRaeTNjdHhCSS9mc3JBMlJWaGJUbEZ5cFJ6?=
 =?utf-8?B?bzJhdzdTVlMwbjRtVi9BTVV3alEva3c0NDFwdTdIT0g2c1BQYWhQanFBZysr?=
 =?utf-8?B?bWVBdkV1d2E2Z1FKdFZlVTk4UkhrNEVVUGEycCtYa29YZTZndW1GcE9RWWpN?=
 =?utf-8?B?QVZwZXJTMmRyZGo0N3c5a0lDdzc5VXZtTGVyUVJ6RXlJaWllTGpuNHpwOG1r?=
 =?utf-8?B?R1A2TE5vcHF6WWtYYmo2QWMvcjdhemxJeGhBZkJWa1YybTcvS3ptQXJVZDdF?=
 =?utf-8?B?VDhGRlhuWjNFZjExRDlmbGllcXVBZU1ZSFQwRllCSVlZSFdpUHJhVm5xakgx?=
 =?utf-8?B?VlRUcElycStRb0pEWnhKQXl3dVVHTWlNRXpqR1gyYkgzL2VNQWFDSVAyeDBB?=
 =?utf-8?B?RytpeVNjRkI3N2REQWdvOGNxYVZaREtFQWZwbXBmUzZtN2hiR2dIdjhPUlM0?=
 =?utf-8?B?YlBHVTVXQlovK2E3cWE3ZkZYaUc2clZ0MmNOa2VhRGxJbGFiSWVIbndlV0kx?=
 =?utf-8?B?cmRYdlkvM29hSFA3OVo0Y3pEU21UMm1YWERweG5oQjBMZ1JweTJjV1FIbW5w?=
 =?utf-8?B?YlV0R0JKVDVnUHhhRWg5cTFNOW5CZC9Hb2kzVUFuNVdJb1Q0bkhsUnNRS2pQ?=
 =?utf-8?B?czdrVVdMNFRKZUZTa0ZzSVJwZkNKS09jQ2dxNGNzSXNwNXhrdnRIYmdNenV4?=
 =?utf-8?B?YWxSVkU4eUllMzZaYkQ4cGJtZ0VDNEhMa0tlSlJndkdSbW12MlBuWFRlVDlN?=
 =?utf-8?B?NVorU0dpdFU1NXNxeGxKMVZzakdsMTk4c1ZraElHRVBtcWNFSjFsZG9CWGEx?=
 =?utf-8?B?TTdWdEtBUDNvUkg3MW4yZ2taSWtyb0FhVjltREx4TWZDekNtejFPSnhVRWc2?=
 =?utf-8?B?VHBhRU0rdWljWm10bGdOM1UwQkY3dEVUU1lyUHFJY3RaRm5UOVV2blpyK1FO?=
 =?utf-8?B?V1E1cTJ1UXR5aUVUbWN5bHVoUktmWUF5US9TOUFMejBuNUVlQ1BIT2RZemJr?=
 =?utf-8?B?emRPQTZFUVNadWUwR2M5UDZmVUsyM3JJV2xaYzIrTHZhdGUrclpLd0I3Z2JD?=
 =?utf-8?B?MzFhWXI4N0F3OWNUR3U3TDBmMWdLOHlrRkhwR2VoTnJiQjBYd2xkU2JOeTc3?=
 =?utf-8?B?ZXc0dTBlSy9vT0FKTC9heWcxWE5RcnZ6ZVlpcG5HaXV4MGM0YnBuMDZMOWxC?=
 =?utf-8?B?RGgrYWRjMEtiUXhvQVpqMFNkdlU0YlVhNW11ZmZEdDFPS3o0VGQ3VndCT0h1?=
 =?utf-8?B?VHVKNjhSdlJhb0piL3laUXhVU0ttWHdIRS9KdVhyYWx3bVdjRWpCSGsrQ1Q5?=
 =?utf-8?B?UzA2djJ5ZW1scEl0RjF0RDB3em93SW9ON0lsNUM5V01EemlPMjFTOXBBclgv?=
 =?utf-8?B?b2h0bnFkcjRpeGU2TFUwOGZqMEtnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E75C826122C62A43B28226D61F1F8611@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe9e656-7e75-46fa-6452-08d9c6140e7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 12:59:29.3286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0SvLu8ehFyS9ULYdUsKB4Fp3qB6NT4l+bbtiyhPgtdw6QpTyW70/3ytckKAzsOlOWFsKOcNdUXQjY3iLgH8dqwUtR7wqm5eX6rkiVBptS64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3487
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zMS8yMSA5OjE3IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBPY3RhbCBEVFIgY2FwYWJsZSBmbGFzaGVz
IGxpa2UgTWljcm9uIFhjZWxsYSB0aGUgd3JpdGVzIGNhbm5vdCBzdGFydA0KPiBvciBlbmQgYXQg
YW4gb2RkIGFkZHJlc3MgaW4gT2N0YWwgRFRSIG1vZGUuIEV4dHJhIDB4ZmYgYnl0ZXMgbmVlZCB0
byBiZQ0KPiBhcHBlbmRlZCBvciBwcmVwZW5kZWQgdG8gbWFrZSBzdXJlIHRoZSBzdGFydCBhZGRy
ZXNzIGFuZCBlbmQgYWRkcmVzcyBhcmUNCj4gZXZlbi4gMHhmZiBpcyB1c2VkIGJlY2F1c2Ugb24g
Tk9SIGZsYXNoZXMgYSBwcm9ncmFtIG9wZXJhdGlvbiBjYW4gb25seQ0KPiBmbGlwIGJpdHMgZnJv
bSAxIHRvIDAsIG5vdCB0aGUgb3RoZXIgd2F5IHJvdW5kLiAwIHRvIDEgZmxpcCBuZWVkcyB0bw0K
PiBoYXBwZW4gdmlhIGVyYXNlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFByYXR5dXNoIFlhZGF2
IDxwLnlhZGF2QHRpLmNvbT4NCj4gDQo+IC0tLQ0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBS
ZXBsYWNlIHNlbWljb2xvbiBpbiBzdWJqZWN0IHdpdGggY29sb24uDQo+IC0gQWRkIGEgY29tbWVu
dCB0aGF0IHJldCA8IDAgYWZ0ZXIgYWRqdXN0aW5nIGZvciBleHRyYSBieXRlcyBpcyBub3QNCj4g
ICBwb3NzaWJsZSwgYW5kIGFkZCBhIFdBUk5fT04oKSBvbiB0aGUgY29uZGl0aW9uIHRvIG1ha2Ug
c3VyZSBpdCBnZXRzDQo+ICAgc3BvdHRlZCBxdWlja2x5IHdoZW4gc29tZSBjaGFuZ2UgdHJpZ2dl
cnMgdGhpcyBidWcuDQo+IA0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgfCA3MyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+IGluZGV4
IGE2OTZhZjZhMWI3MS4uZDJhN2UxNmU2NjdkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiBAQCAt
MjAyMyw2ICsyMDIzLDcyIEBAIHN0YXRpYyBpbnQgc3BpX25vcl9yZWFkKHN0cnVjdCBtdGRfaW5m
byAqbXRkLCBsb2ZmX3QgZnJvbSwgc2l6ZV90IGxlbiwNCj4gICAgICAgICByZXR1cm4gcmV0Ow0K
PiAgfQ0KPiANCj4gKy8qDQoNCmxldCdzIGFkZCBrZXJuZWwtZG9jIGNvbW1lbnRzIGZvciBuZXcg
bWV0aG9kcy4NCg0KPiArICogT24gT2N0YWwgRFRSIGNhcGFibGUgZmxhc2hlcyBsaWtlIE1pY3Jv
biBYY2VsbGEgdGhlIHdyaXRlcyBjYW5ub3Qgc3RhcnQgb3INCg0Kc3RyaXAgInRoZSIgZnJvbSAi
dGhlIHdyaXRlcyIuIEJ1dCBJIHRoaW5rIEkgd291bGQgZ2V0IHJpZCBvZiB0aGUgTWljcm9uIFhj
ZWxsYSBleGFtcGxlLA0Kd2UncmUgdXNpbmcgdGhlc2UgbWV0aG9kcyBmb3IgYWxsIHRoZSA4RC04
RC04RCBmbGFzaGVzLiBZb3UgY2FuIG1lbnRpb24gTWljcm9uIGluIHRoZQ0KY29tbWl0IG1lc3Nh
Z2UgaWYgeW91IHdhbnQsIGJ1dCB3ZSBzaG91bGRuJ3QgbWVudGlvbiBtYW51ZmFjdHVyZXJzIGlu
IHRoZSBjb3JlLg0KDQo+ICsgKiBlbmQgYXQgYW4gb2RkIGFkZHJlc3MgaW4gT2N0YWwgRFRSIG1v
ZGUuIEV4dHJhIDB4ZmYgYnl0ZXMgbmVlZCB0byBiZSBhcHBlbmRlZA0KPiArICogb3IgcHJlcGVu
ZGVkIHRvIG1ha2Ugc3VyZSB0aGUgc3RhcnQgYWRkcmVzcyBhbmQgZW5kIGFkZHJlc3MgYXJlIGV2
ZW4uIDB4ZmYgaXMNCj4gKyAqIHVzZWQgYmVjYXVzZSBvbiBOT1IgZmxhc2hlcyBhIHByb2dyYW0g
b3BlcmF0aW9uIGNhbiBvbmx5IGZsaXAgYml0cyBmcm9tIDEgdG8NCj4gKyAqIDAsIG5vdCB0aGUg
b3RoZXIgd2F5IHJvdW5kLiAwIHRvIDEgZmxpcCBuZWVkcyB0byBoYXBwZW4gdmlhIGVyYXNlcy4N
Cj4gKyAqLw0KPiArc3RhdGljIGludCBzcGlfbm9yX29jdGFsX2R0cl93cml0ZShzdHJ1Y3Qgc3Bp
X25vciAqbm9yLCBsb2ZmX3QgdG8sIHNpemVfdCBsZW4sDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY29uc3QgdTggKmJ1ZikNCj4gK3sNCj4gKyAgICAgICB1OCAqdG1wX2J1
ZjsNCj4gKyAgICAgICBzaXplX3QgYnl0ZXNfd3JpdHRlbjsNCj4gKyAgICAgICBsb2ZmX3Qgc3Rh
cnQsIGVuZDsNCj4gKyAgICAgICBpbnQgcmV0Ow0KPiArDQo+ICsgICAgICAgaWYgKElTX0FMSUdO
RUQodG8sIDIpICYmIElTX0FMSUdORUQobGVuLCAyKSkNCj4gKyAgICAgICAgICAgICAgIHJldHVy
biBzcGlfbm9yX3dyaXRlX2RhdGEobm9yLCB0bywgbGVuLCBidWYpOw0KPiArDQo+ICsgICAgICAg
dG1wX2J1ZiA9IGttYWxsb2Mobm9yLT5wYWdlX3NpemUsIEdGUF9LRVJORUwpOz4gKyAgICAgICBp
ZiAoIXRtcF9idWYpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gKw0KPiAr
ICAgICAgIG1lbXNldCh0bXBfYnVmLCAweGZmLCBub3ItPnBhZ2Vfc2l6ZSk7DQo+ICsNCj4gKyAg
ICAgICBzdGFydCA9IHJvdW5kX2Rvd24odG8sIDIpOw0KPiArICAgICAgIGVuZCA9IHJvdW5kX3Vw
KHRvICsgbGVuLCAyKTsNCj4gKw0KPiArICAgICAgIG1lbWNweSh0bXBfYnVmICsgKHRvIC0gc3Rh
cnQpLCBidWYsIGxlbik7DQo+ICsNCj4gKyAgICAgICByZXQgPSBzcGlfbm9yX3dyaXRlX2RhdGEo
bm9yLCBzdGFydCwgZW5kIC0gc3RhcnQsIHRtcF9idWYpOw0KPiArICAgICAgIGlmIChyZXQgPT0g
MCkgew0KPiArICAgICAgICAgICAgICAgcmV0ID0gLUVJTzsNCj4gKyAgICAgICAgICAgICAgIGdv
dG8gb3V0Ow0KPiArICAgICAgIH0NCj4gKyAgICAgICBpZiAocmV0IDwgMCkNCj4gKyAgICAgICAg
ICAgICAgIGdvdG8gb3V0Ow0KPiArDQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBNb3JlIGJ5
dGVzIGFyZSB3cml0dGVuIHRoYW4gYWN0dWFsbHkgcmVxdWVzdGVkLCBidXQgdGhhdCBudW1iZXIg
Y2FuJ3QNCj4gKyAgICAgICAgKiBiZSByZXBvcnRlZCB0byB0aGUgY2FsbGluZyBmdW5jdGlvbiBv
ciBpdCB3aWxsIGNvbmZ1c2UgaXRzDQo+ICsgICAgICAgICogY2FsY3VsYXRpb25zLiBDYWxjdWxh
dGUgaG93IG1hbnkgb2YgdGhlIF9yZXF1ZXN0ZWRfIGJ5dGVzIHdlcmUNCj4gKyAgICAgICAgKiB3
cml0dGVuLg0KPiArICAgICAgICAqLw0KPiArICAgICAgIGJ5dGVzX3dyaXR0ZW4gPSByZXQ7DQo+
ICsNCj4gKyAgICAgICBpZiAodG8gIT0gc3RhcnQpDQo+ICsgICAgICAgICAgICAgICByZXQgLT0g
dG8gLSBzdGFydDsNCj4gKw0KPiArICAgICAgIC8qDQo+ICsgICAgICAgICogT25seSBhY2NvdW50
IGZvciBleHRyYSBieXRlcyBhdCB0aGUgZW5kIGlmIHRoZXkgd2VyZSBhY3R1YWxseQ0KPiArICAg
ICAgICAqIHdyaXR0ZW4uIEZvciBleGFtcGxlLCBpZiBmb3Igc29tZSByZWFzb24gdGhlIGNvbnRy
b2xsZXIgY291bGQgb25seQ0KPiArICAgICAgICAqIGNvbXBsZXRlIGEgcGFydGlhbCB3cml0ZSB0
aGVuIHRoZSBhZGp1c3RtZW50IGZvciB0aGUgZXh0cmEgYnl0ZXMgYXQNCj4gKyAgICAgICAgKiB0
aGUgZW5kIGlzIG5vdCBuZWVkZWQuDQo+ICsgICAgICAgICovDQo+ICsgICAgICAgaWYgKHN0YXJ0
ICsgYnl0ZXNfd3JpdHRlbiA9PSBlbmQpDQo+ICsgICAgICAgICAgICAgICByZXQgLT0gZW5kIC0g
KHRvICsgbGVuKTsNCj4gKw0KPiArICAgICAgIC8qIFNob3VsZCBub3QgYmUgcG9zc2libGUuICov
DQo+ICsgICAgICAgaWYgKFdBUk5fT04ocmV0IDwgMCkpDQo+ICsgICAgICAgICAgICAgICByZXQg
PSAtRUlPOw0KDQpJcyB0aGlzIHJlYWxseSBuZWVkZWQ/IEFsc28sIEkgdGhpbmsgSSB3b3VsZCBz
cXVhc2ggcGF0Y2ggNSBhbmQgNiwNCml0J3MgdGhlIHNhbWUgaWRlYSwgYW5kIHJlYWRzIGFuZCB3
cml0ZXMgYXJlIHRpZWQgdG9nZXRoZXIuDQoNCkxvb2tzIGdvb2QhDQoNCj4gKw0KPiArb3V0Og0K
PiArICAgICAgIGtmcmVlKHRtcF9idWYpOw0KPiArICAgICAgIHJldHVybiByZXQ7DQo+ICt9DQo+
ICsNCj4gIC8qDQo+ICAgKiBXcml0ZSBhbiBhZGRyZXNzIHJhbmdlIHRvIHRoZSBub3IgY2hpcC4g
IERhdGEgbXVzdCBiZSB3cml0dGVuIGluDQo+ICAgKiBGTEFTSF9QQUdFU0laRSBjaHVua3MuICBU
aGUgYWRkcmVzcyByYW5nZSBtYXkgYmUgYW55IHNpemUgcHJvdmlkZWQNCj4gQEAgLTIwNjcsNyAr
MjEzMywxMiBAQCBzdGF0aWMgaW50IHNwaV9ub3Jfd3JpdGUoc3RydWN0IG10ZF9pbmZvICptdGQs
IGxvZmZfdCB0bywgc2l6ZV90IGxlbiwNCj4gICAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gd3JpdGVfZXJyOw0KPiANCj4gLSAgICAgICAgICAg
ICAgIHJldCA9IHNwaV9ub3Jfd3JpdGVfZGF0YShub3IsIGFkZHIsIHBhZ2VfcmVtYWluLCBidWYg
KyBpKTsNCj4gKyAgICAgICAgICAgICAgIGlmIChub3ItPndyaXRlX3Byb3RvID09IFNOT1JfUFJP
VE9fOF84XzhfRFRSKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBzcGlfbm9yX29j
dGFsX2R0cl93cml0ZShub3IsIGFkZHIsIHBhZ2VfcmVtYWluLA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBidWYgKyBpKTsNCj4gKyAgICAg
ICAgICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gc3BpX25vcl93
cml0ZV9kYXRhKG5vciwgYWRkciwgcGFnZV9yZW1haW4sDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBidWYgKyBpKTsNCj4gICAgICAgICAgICAgICAg
IGlmIChyZXQgPCAwKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHdyaXRlX2VycjsN
Cj4gICAgICAgICAgICAgICAgIHdyaXR0ZW4gPSByZXQ7DQo+IC0tDQo+IDIuMzAuMA0KPiANCg0K
