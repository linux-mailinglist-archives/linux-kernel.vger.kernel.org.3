Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F46749E2C2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241224AbiA0MnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:43:05 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:41405 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiA0MnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643287384; x=1674823384;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Axqgg4ocos605Tr1CReAPZVLEu1kYsqFrWUs3qu1JdU=;
  b=MMt3gX//vA50CmdpXFyZHgTlUTfUkAsIerHEHZDYPkA8g+6mZqpBH9bU
   YWegsmMlkkYKsX8Wd5jdJGcez8UtUOCtbDWYvybcphWXmVvTYsSzH96nz
   DCZuyhKwFkLJDzb4XUyE4CeZKhv+LGb4YxpsB4Bw7lqAiDKQ5XEErfICF
   L/K8eut2agqMLXwso5sRtgi7rFuKPKUCS4JIeCNGMuaS+au69yDdSWy/C
   8jpQ8FZ09pdpMemhj4tq0rHMsa88A9oNdEmX3/sMYjcxzSrfqo2LXYq12
   GiMfx62iBoQA+yeuRQ+ciicEjK8uRSBacc2V0YCESdZcCbiTHrR0oPgDy
   A==;
IronPort-SDR: PPMBSOXocLuqEpdMwd/ukRET7Kc/Omjgm99M+g1jhqoopY6N54roc7SuOhTj0pvTJ6sJ8tSgpT
 UWVqMJ9jobshJ8npiqiEEYoamzTQACzfcCLjlnxceaAu8E96Y4HRHKWnyv6y1VyepJKX0xoB/M
 T9AISNJhLZr5+h0QHL7mItrqmS8nhCNREdGAWuXL8WGSTCTYhyfsjikjKzpV0NfYffU4m0MPU8
 TiLYuo+l9vAmzuMfDbDL4wH+loSHUB6gW63EM8FNcXiSgvgIBrCOy8Do0Q0cNABqtTfaif3hxu
 jbjOxlgY8a/9Zi9F9xiQPssd
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="146795223"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jan 2022 05:43:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 27 Jan 2022 05:43:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 27 Jan 2022 05:43:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8cJH8dtUKYBZqYBKkE0+eB46dRgRU2nOLlWz+dbHfjkMo64XT8GBCX5F1SUm/VE/zPMfsFYAcqOBKCBUFriVL8R93kmQgJg4mUi1tp+ylOfkm2IUIbr7hye81gR/C1E/5i8e0/zGE3SOpI3TA22F4XSkCntJYQPT1jGd793GBPV4DHRcZpciZA3PtpSGHbmG6Tjdr0h9Ecbqydsvtbzl3zu7vXloxMmDs5Rgy+qj1z7yQFqaJWqbUvUg3ZkM7mMO5EseSeqwjFXrZDBzJXXs64jfH9lS7NE7nHR9iv6fedzaWEjkczO3Wnxqrd/ICGC4W16PCwZmLculFA2TXo6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Axqgg4ocos605Tr1CReAPZVLEu1kYsqFrWUs3qu1JdU=;
 b=mUq5RK04c5zMV4srNKAoSDZ1JBXSz3WSmQ53s3c3gf9L6inhUOfnOGySHFJQ5Aml2DDg7exlDct4jdlxGN9dYsv8EUEEJnA90s2LxRBCFVhI3izbgqu0tIHttOJX2Yt4QFsYrwGKZN22nXWffXJ+lyRYhIxInCMJG9nWViULXQJm5CaLpt2ihApgdXCsRuwsDrHSOHCH0DA9GnFG9SXoQeqB7anWjnJWSCGM7EVKFc9lQ577g+ne3R5Irq9TdRjXoPEQZ4SgSQJ3ZkbrJ8bJ6Ot0D0zN/B5+3+1W7uiMPX1M3AAQngK2adXdXLHLzOViy/f05Mgbnmm6lKzbpc9c2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Axqgg4ocos605Tr1CReAPZVLEu1kYsqFrWUs3qu1JdU=;
 b=dMZWj6dJEMihlKze4cKMZ7Ieb2oGiI+GxFILLeqjp0SYLZO4wukTJNOmOWoTJGVkvCs5z24OzFwJyxasXe/ZLe3cgNOnMfVMtQs1Ax8F8ytZfZ/2NUxML9b1ugVd00Gx/3TufDcZPa1hbB79JyHgcCN/urU+/kSDlCH6vmic+OM=
Received: from DM4PR11MB5358.namprd11.prod.outlook.com (2603:10b6:5:395::7) by
 SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7; Thu, 27 Jan 2022 12:42:58 +0000
Received: from DM4PR11MB5358.namprd11.prod.outlook.com
 ([fe80::d83f:ca51:f5cc:f9da]) by DM4PR11MB5358.namprd11.prod.outlook.com
 ([fe80::d83f:ca51:f5cc:f9da%3]) with mapi id 15.20.4909.017; Thu, 27 Jan 2022
 12:42:58 +0000
From:   <Steen.Hegelund@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Horatiu.Vultur@microchip.com>
CC:     <Lars.Povlsen@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <linus.walleij@linaro.org>, <colin.foster@in-advantage.com>
Subject: Re: [PATCH] pinctrl: microchip-sgpio: Fix support for regmap
Thread-Topic: [PATCH] pinctrl: microchip-sgpio: Fix support for regmap
Thread-Index: AQHYEgYt5tRjs2YLSUyco1D7f9vvfax20qGA
Date:   Thu, 27 Jan 2022 12:42:58 +0000
Message-ID: <7ebaf35c71a15326a7bd9be2676846050ccc8eb4.camel@microchip.com>
References: <20220125161245.418882-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220125161245.418882-1-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.3 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6fd92ff-b39a-4f26-8e9c-08d9e1928c5e
x-ms-traffictypediagnostic: SA2PR11MB5145:EE_
x-microsoft-antispam-prvs: <SA2PR11MB514534CECF51F37E9F0C2EE186219@SA2PR11MB5145.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4T0nRhdylGcGTSCIx3rsZ5Ptr3a3ueKfKV8ijJ6D1rH1KG3keTMl243flLm+MSs4zjnIVIpSqsHflmuS8S8NoB9O58TwqVVyzons8rjykvM4jDH622j9qD4y+7nQubDdMav9DDDDFCwxfCNJ5jH+OSccU9AVAm5WkgOCJ8QeGbwETBuYGQp5UHYB/AdSxBPyLs9JWohwTefO9J2NKQI0bvfQZAlOGKZ86OLWfJ0f9RWbhyglCTjhLRfTdZoFpSLCPsEEYd44FKfozRvV4gQ4z7vRYoHuU/3e783zQk4SdxBSNbNH1KcnaV/8xKsMmJoHhf9ascDCRnJqK35VlcDzzVjoZC2tFA7zg0Eg7iuHeEVFqvj4n9BeAGXO45am+b7VD8J3LPXZgeulcdNl98XOHyvj1aHSboKz6kFQKCkI6/K6mFHUFvvLJxeFMAjrzPcmpHB2E6dk72gD8BkhhILBjPa1A2r0MMxks56zz2Jrn1HybTMOm7j5N2A3RN5j0KMCqVKxzZatTErnMA/9y3kgMULmZ0hfhhTFb8XBbmsu9szRZ8oFkmsyFa/VAUGo9Va68N5ptaGfLY2CftD9tyHZxA/YyF1XNvfszw9aE1q+nzyactHeURmMeXeX8jxCozr72ymetUPv9zFTLH50RfOJrnLniOK6IeLEGeTx7NtX2nBl/LvqepKt00S0YCxqq0jQpLgWiIl7ERswUi69vV+V4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5358.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(38100700002)(64756008)(4326008)(83380400001)(66476007)(122000001)(508600001)(54906003)(5660300002)(71200400001)(6636002)(6512007)(8936002)(6486002)(76116006)(186003)(66946007)(4744005)(8676002)(38070700005)(2616005)(36756003)(86362001)(91956017)(316002)(6506007)(2906002)(66556008)(110136005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amgwa0tLdDdPZ2IvR1c3TTJJRFFGMk53aW1wOWFHY0RpWnVsUDU3dkNPZ2Nm?=
 =?utf-8?B?cnNxR2NMRnBWNkZ0K1l3bXVKUXNRS1YrUzRzdjFxQXhZT2k5b2JKa3NNZk5F?=
 =?utf-8?B?Wk55VFBLQmtOc3IxT1lKcUhiaFZldjJqazdYVzBaWnA5TFJDMTlCam1DUUtv?=
 =?utf-8?B?VzJRbHBGaWVBU0F4Ny9QTXluR2hZYkhra1V4VCsvbC9vaE5vZHU2eHZpYnZm?=
 =?utf-8?B?NzlFTld6ZllzYWxTZERBY2lWcnNhUjY4ZCtnMWkyUHdUUm9NL1BhLzBoTGZN?=
 =?utf-8?B?cTBkUEJJQzNtZDdybnFDMEE4WGFZaWo5bzNHU05zU0Y5Y25RSUpReFhFYTZo?=
 =?utf-8?B?b0k5UmZjYmI3Z3FyeXFlQ21MdWdVdVM4dGUvSU9xY1VDaG1YVlZyVmoyS3F1?=
 =?utf-8?B?RkYzWE9KTGtTUEpVR1A2NnpzVGdzcTBwYjYvUGRaTnFYVnRqYkllYjZMTmlP?=
 =?utf-8?B?cDc1cDJmRjduSEdCV3dodGEzWE5wSXc2S3RjckRScXo4bldGQmlkT3gxRzZO?=
 =?utf-8?B?cVpTbitFbmJWc1BwR1Vsa3pXWWlFRGpVSytITmp2QXh2d0U3WVlBRkR1Qno3?=
 =?utf-8?B?V3JPVU12UU53NWp1bXRpWXVhanhac2ppazhqMWFubURVdmcwQk51cEVqV1g2?=
 =?utf-8?B?T0FVc1NwQW1tTi9LZTIySGduLzZDV1pGbmtwVWFQQmRkN1VLNy84UkI4N0E1?=
 =?utf-8?B?d1V5YUdyZ0UrUDZpZjlNVXc1RGszVURmQk55MUNiOVpJZ3dsOS9KMnprV1Jq?=
 =?utf-8?B?blNXYmdkUWdYdERsOW9pYm96NE55SVUwdENTMFVhVTRhc09JL0tjRGtWSllu?=
 =?utf-8?B?bjNHL1ZVWC9aYVJ4Q0JMYWUxaFhRYkxkZTBEZmk5WjQ0Q3kzei9HOWQ0U3Ro?=
 =?utf-8?B?bnRvUFJXUlY2UDc1TEJGdlNZM2tHVVU1VHY1NkJCWlpnRUJjT2RlOHVVb005?=
 =?utf-8?B?Qms1SHpsMmNiSktZWENZdzlYT3ROZHU4cFlVT1JKY0huSjB5RTFLYmlTb1hn?=
 =?utf-8?B?bGRsVDZpRHhLMGFacWpjb2dndmZLaDdVWWdrUDkvYk1OY3dtZjhhYWlhUGlB?=
 =?utf-8?B?ZHFMNFVHQkRZb0Y0N1AyVUdrVHBkcVFwOW5KMElHMzJUYXlDMlVCbTRyVG1s?=
 =?utf-8?B?WnBkdDlkSjE1MXMrdE9PVURIM2F6TnVQNnBLWmp4Z2wzRm9QSmlmT0NHeks1?=
 =?utf-8?B?MzBCRU1pdjhtelVLWlRNV0JhU09GQjRpa1dvc0s3ZUhFQWxYY2llWXFEaWtq?=
 =?utf-8?B?STRMR1QxYnE5SkpVRFNuc1VIK2pnM2VYeXZMMWdTa1d2aHZ1ZllFMmdhZHE4?=
 =?utf-8?B?THdkUUlnZmc2dXFWa3NaNytuWldHWGNvUDhtN2pmdWpaSHpmYXo3T3NpaGRx?=
 =?utf-8?B?a2V6SnB0KzFzM2ZRVkhkS2xUWUVQdjE4V0tybE1MSTJZNDZMdHdYZitzRTJM?=
 =?utf-8?B?cEZNYlhRbjh5d05VcitKbG1vVkJUSjdzdTdiUC9wK0l5MjdIbzBxellFenBr?=
 =?utf-8?B?TktOdndlZVBIUUJyNWhJb29KRTUxdzQ5WEU5d0dDV3dpMjJzcXNkRjRVVmJj?=
 =?utf-8?B?bXJ0MkwyYkJXVWFxb05XQXFoZTRVa1RCbkhDb3F4Z2pTYXMyZThNRmJjRlRM?=
 =?utf-8?B?K0U3WVBmY0R1ZU9aenFuSUI2cVBrUGZGd0VrWFNIeWttbHlUVno4a1A0NHAx?=
 =?utf-8?B?MURWWjJVMjZjREVDc3FEaVFrVnp2dVZEZXV1bkV3a3ljNTdNb2YrWnYxVXdo?=
 =?utf-8?B?d1dYQmo0c0tmbXdIZ1kvbTlDL0FyTnRrMnZxR3FmRFRPQ2VqU3F0Y29id3Ra?=
 =?utf-8?B?enpmNzkyMTZJMU1HMlBYeXp6dnlPaTc5a0hKY1lTMnRVSGMrNEtnSUVjRFQr?=
 =?utf-8?B?ODhHbEpFbUJadTNXYUFRaEFIUEJaQ25pRTVzeGQxbERlMGY1MU9qK2tnRk1p?=
 =?utf-8?B?dEJsNWRFaEpCdDMycmJ2cDZDYTgwV0pCQmdEekw0elRjYU1LRFlvVWlMUytq?=
 =?utf-8?B?OWtDR1dFbDFQbzdyQXNVZUR3am5jUUlvN1RwVjV5NWdGWk02amRwbmdFUDN4?=
 =?utf-8?B?UkprRXc1ZEZiT0FXTmkrVzZIbmpXd0RGb2p5TEVtRUlMR09FZDY4V2R0cGQr?=
 =?utf-8?B?SFlEejAvVzJqc2VOb0dkOHBPWEhYZGVzTVBCTzFzS3owVndodWRwbkNkeFl0?=
 =?utf-8?B?ZHZQOVl5T0N0SlJmSUc1RUgxeFZBT2Rha0UvelU3VHFpMmZxMExISFM4am5S?=
 =?utf-8?Q?2tn6eab6biXA0G8Ga8VMP9lSoK6uVerpmdYQJP64Mg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA700D0130CB64468C4C55AFDC0AEA81@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fd92ff-b39a-4f26-8e9c-08d9e1928c5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 12:42:58.5024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdY669XxEdyXw/LmqQTeBW6vFEECWKhdqs2kimw1U8I9yobuVbWTs0/dE5b4iXnblH/IXu1mfx7CqsByuIigDy6CSh2lrBMAcpXWZETWV/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R29vZCBjYXRjaCBIb3JhdGl1Lg0KDQpCUg0KU3RlZW4NCg0KQWNrZWQtYnk6wqBTdGVlbiBIZWdl
bHVuZCA8U3RlZW4uSGVnZWx1bmRAbWljcm9jaGlwLmNvbT4NCg0KT24gVHVlLCAyMDIyLTAxLTI1
IGF0IDE3OjEyICswMTAwLCBIb3JhdGl1IFZ1bHR1ciB3cm90ZToNCj4gSW5pdGlhbGx5IHRoZSBk
cml2ZXIgYWNjZXNzZWQgdGhlIHJlZ2lzdGVycyB1c2luZyB1MzIgX19pb21lbSBidXQgdGhlbg0K
PiBpbiB0aGUgYmxhbWVkIGNvbW1pdCBpdCBjaGFuZ2VkIGl0IHRvIHVzZSByZWdtYXAuIFRoZSBw
cm9ibGVtIGlzIHRoYXQgbm93DQo+IHRoZSBvZmZzZXQgb2YgdGhlIHJlZ2lzdGVycyBpcyBub3Qg
Y2FsY3VsYXRlZCBhbnltb3JlIGF0IHdvcmQgb2Zmc2V0IGJ1dA0KPiBhdCBieXRlIG9mZnNldC4g
VGhlcmVmb3JlIG1ha2Ugc3VyZSB0byBtdWx0aXBseSB0aGUgb2Zmc2V0IHdpdGggd29yZCBzaXpl
Lg0KPiANCj4gRml4ZXM6IDJhZmJiYWI0NWMyNjFhICgicGluY3RybDogbWljcm9jaGlwLXNncGlv
OiB1cGRhdGUgdG8gc3VwcG9ydCByZWdtYXAiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBIb3JhdGl1IFZ1
bHR1ciA8aG9yYXRpdS52dWx0dXJAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQouLi4NCg==
