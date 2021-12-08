Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3877E46D22D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhLHLbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:31:38 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:57082 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhLHLbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638962886; x=1670498886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ns59OfVOD0WZJcJhHAZwvBl1oRZjJSqtt4wD1kG5Zu0=;
  b=mn1kMSK/1m/VvoG/Jj3h1dgmVXXSJqBZNuHlSdaFauVAzRJNybUxwtUv
   hQWVlT3IwwfHpOeRuMl5a0nZT/lbDUEqRJVx81LHZb+Ofp7hH/dMKpr/R
   V5ML2pSrIOl3YxTSHicakXi5nBE191Ro5Gpty11s4ib/BdMQyUenVc2OI
   BI8hRlacOVunKeErz4BpaHQrCNXLM3C9CZRIcHrXlxIXvO/hyHG3li5bC
   Ew8H6XnGsAOYy9DlWGvgd3LRmyXEDJGK8nMgesjvpxUP6KAduYLZSxwKC
   CKMiRObh5h6W6IstX7rM3hpfbLD9CtGuuyZC28w/KbM7kgkd8DfqKT8yq
   w==;
IronPort-SDR: WQJqQ7/OWABuyJj9f0h+RFQU3v1Ce1atzZHeYFwnBGU3FnUGH6VnHdu2bD0YRfCpxrcWWgBC03
 QOrjVW/7CXzfx6L0BfVSvNkPadaqdMT8IjdzgqKgjaKi50HSA7XzTY4NuiqGA6KhT8MSqugfnB
 g/Aj1VD8cvvW8uiizUi3vcKkCGlK6v7W8hUQRm6FA4Q0N3ILjhyWbg18VHqvnSBggQSO1l9EQM
 llKC7D3r74DmCAnFjYQ1l74NrEGLA9CMq3NI3jOjCm5HUVOGYFSKJyGrjh2WLe6QXCui2nlFtR
 dcMxkVDqH3R+QkLMyVhsCErt
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="145929035"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2021 04:27:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 8 Dec 2021 04:27:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Wed, 8 Dec 2021 04:27:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEWaypTv7/kFlAO5MvBus9jQ+9bYLc84kpT7aAE4Et4KYVdys5tRTm8+sWZYm7HqTz47IOL5cqMY62nGtbh/l9eqqTcR2U1Oaz5Y+1T/t6HJ0Me3cvV9Z0kz7R32m57dD5t0wq8ChVOfD15oTsVQKBu1E68OIZQKX474JGhV0YLlQ8tgx9H4Z36tF5+A9CK7AGVbPyhvK+BXZ0x+huQ+glxZ1PnVkPHeqAOJ2l7zrjV48YxFs3pJYsX/AV1ccZyoa/UOoUhhTU3+D50CmTQg/VsdHBTB+pozg2+knpfvAYbywBCXkiOVPFNeU7Sn+ydxvsfA5IgQBcedY4svCT6GHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNFfLmrc4E4fHQNda2brox+fdvpqtLCy3cr/0YKVkDE=;
 b=QkuOIq7yb/sUgNr92avOy33AAfOvRv+PKkez5WBTefrOUeGKtWAbtx2yOU4+IDKJL7tsBpqqux5+vGFTDU3PPJdFmfv/bchU0TgBKnQyYDGwe7W2WpuhSpT0jegeCTb04/0zYfQ9MYvC0SPqRGAtYo90GpU+k1Bj0e70UdMvwgCll0Znkz/7KnTYR52XEVZl6PL/RZHhp7c4CpTiVnNOhMCclcsycm6HtQFSsJzzIwEobgacgFsXFbRu3QzB93JW1+tD7t2A9z6Af1SvQfaTTto1lUw6zwY3HW11OLxMgPVqhPgC1tH0H94X2/eZkCKFnaY0fG3RCsweVZFVHiIx6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNFfLmrc4E4fHQNda2brox+fdvpqtLCy3cr/0YKVkDE=;
 b=olejvDdfWNXRneFguktWS5qoovRh3d/HttbOsBnFAJciukDZLswRmrHsWib6sF1/t4B6v5OTNr2PnvuX9f9izhXLylEFRanhIruuj0WJvj4JOvgSZVSGqFOIcfnCGbAs/OAhbo7+xAF4Iis0DPhFZFV1mRPQ1BtykhrqB22DvD4=
Received: from PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22)
 by PH0PR11MB5904.namprd11.prod.outlook.com (2603:10b6:510:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 8 Dec
 2021 11:27:44 +0000
Received: from PH0PR11MB4920.namprd11.prod.outlook.com
 ([fe80::1433:9dcf:4912:b8f]) by PH0PR11MB4920.namprd11.prod.outlook.com
 ([fe80::1433:9dcf:4912:b8f%9]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 11:27:44 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <devicetree@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Mihai.Sain@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2_xplained: remove
 PA11__SDMMC0_VDDSEL from pinctrl
Thread-Topic: [PATCH] ARM: dts: at91: sama5d2_xplained: remove
 PA11__SDMMC0_VDDSEL from pinctrl
Thread-Index: AQHXymxb5xC4iJlwgE+oBKrTcDSgSqwotsuAgAABlAA=
Date:   Wed, 8 Dec 2021 11:27:44 +0000
Message-ID: <f943539b-bc95-35c9-a634-ad75f9df54b0@microchip.com>
References: <20211026132034.678655-1-eugen.hristev@microchip.com>
 <28f0898c-0d6c-a77e-4068-b49c6dd0aa64@microchip.com>
In-Reply-To: <28f0898c-0d6c-a77e-4068-b49c6dd0aa64@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85c2dc74-08f7-40b7-afec-08d9ba3dc149
x-ms-traffictypediagnostic: PH0PR11MB5904:
x-microsoft-antispam-prvs: <PH0PR11MB590495FF0B6AC20E90A87E63E86F9@PH0PR11MB5904.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /btHwabJUkvGEYXk3B1vJtz4IOv0XaK64q9501GIa6C54DMbH4owBwMPknls+pB2wEifVlWB+Zxu9uBu8qNEkFf7VYXSIDaEEvMSgixfRYqxDa5hVKa4yQPo8Jz17ZcdPFgfW1ZtSy/RvFMP0p2Hxuo6KQ1RtY4K4++NTn8etkOXjGzJQWGAMQzcdK3U9vlGb2F5wEw4hv0jCyQO3+utWVtt1VrU+0Y7wisPkJFlSfi75FQC6dmc+ZAYDJc8qFVlqeVJlw0DcJ/cQdjvp+C/GJuT3hP7rvhlfa9Tcrf0T+zg7xmqhG2jZFoF62T0vbmSACzIHEZ2Qsbg0D/IEZ5nwdJM9YDabQiDQb1O7rLPDr5uKBxh212x0LDEn2bzMk2O5XZghkHxQeWh4lqxOhmlElXxiAE92g5vO3yOpp+VYXhjOnqlC8SSS/p4Lu3vV2zp4tZzgNuH3yLMXGACT1N/ZtWqkDAzcR4t3zjf/ZLOUZmR6FfqIhUNYjXITIvzLdFWcr7cxJVAIHKpajktRb0xTSCvd4bQmT3sIX5uCjMv+KwP7l1pPhWsGDjTmed5WoDbIR2OhXDONE/VJbIMNS2dHqFO0B2lrqVsDZ+u2XI18cP+rvTKj4acxs87Yip1YqiMNU/ZntXbEMjNiXpjs0hdLfuVqSNAP24IhMyk4iR62RiwunvD9z92E6JaEHAb2RZTXd6whLr0uxsdWKMPNYRx+R0slo4kpxUPxnprw+Xn1Jy9KyHmsIbezGTj+cVF4XxDATwzZbOEXIPM2D3RcK2hhAwJU9L3pMwmm7iGcP/Cu5W6Ph0rPa53kgBH00YP5aEV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4920.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(186003)(36756003)(316002)(110136005)(54906003)(6486002)(38070700005)(2616005)(6506007)(83380400001)(107886003)(66446008)(64756008)(31696002)(2906002)(26005)(5660300002)(86362001)(71200400001)(31686004)(8676002)(66556008)(66946007)(76116006)(4326008)(66476007)(6512007)(508600001)(38100700002)(8936002)(122000001)(91956017)(101420200003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?2c4KFmcCIkFZClSxIPPdP//8u3OHAikDMr6s7RAYth+Yd/OhtX1Sf5Qb?=
 =?Windows-1252?Q?JMZ5qL0dFiZ+bSrvMeookzm9SsygMD9ZiBm2xzzlFi8tViOab/rxWyco?=
 =?Windows-1252?Q?7KWwD49gKnmSrDjN/WjfFWoX9pVT7HRY8vxAPnjPDisZ3qbrkH1/J5ql?=
 =?Windows-1252?Q?GjEE+YgKNlbIxMApIS8TdD3bIX9AfRShAfP5wUcSV/0uPIwQNWHLsEfx?=
 =?Windows-1252?Q?P1swesSj8uCi689Uc+LK4uLAxPK3Nw0py/AEiWqb35OIlxv5OdP7MT78?=
 =?Windows-1252?Q?A59i/TthQE6Q/5JFXroDusS1FmeHGvxBhYohS3mOLVyZw6RqXiyhbXXx?=
 =?Windows-1252?Q?mwt+hx56gfPvCPayPBYdpnzagsjUIMbdvPhZgisEw07e8AuAw2+nH+yt?=
 =?Windows-1252?Q?32W75wyp9wh9tssiQA5Ex/DeGpF5lyzWiP305M58WKGk7MGgCR6xj2Tr?=
 =?Windows-1252?Q?k7QPq5bPHka2M8dgVdkWCFp3DmJQGN2XdN+N0RJnXSqsQBBSSKGbHVlP?=
 =?Windows-1252?Q?it6d6fOBssqJ52cKQsepnU2vhLCr3UY4F8iFUoqcTtNQ8IMVHza5EqCa?=
 =?Windows-1252?Q?gwSA0XOpIH6cYS56XuTt+nSEv1uwhsdRN3szQCU/F5sZBSyTXWV0gk28?=
 =?Windows-1252?Q?oByk8xOrZH6SKuqWllowk0I+yj5/trmiLx5BlOFhZfVfwVDJt2fZXlAe?=
 =?Windows-1252?Q?hKxy2yFGYO1tvFk0TAk3N+dP+1sC9bnT1SCjSnfHoTyWsRKlEGdM/jUQ?=
 =?Windows-1252?Q?pUur7MMGV5DFfRSyd+Cf65E+Zfb/L7+FMEiQsZhqOqqkW28thhTmLBGd?=
 =?Windows-1252?Q?dlXvEW7gBwD41Je0ls7gZV+kUacw54dD6X0rCI1nBMZqkyHbzDn/sSGY?=
 =?Windows-1252?Q?TEUQsB7+u3v0DvudDysXoFt4FTN+Ux6TSvqGNmLbYdN36Hgm4480psFv?=
 =?Windows-1252?Q?9u5/0QcSIOIjPE4X1dc+ACICRW/tIA5b9IFaFdeEu046FKJY4l0VGWRz?=
 =?Windows-1252?Q?E/UXm0aPKJ/0ux//S5CtKr6BhBRbDD/Qj3HB0D0lTXCd0qm5sCV5sb+P?=
 =?Windows-1252?Q?wiavpZNeBxT8vr2mwKRO9ravTw9pVCWs/TSYmgrSYUc4NNllnvU8j8EK?=
 =?Windows-1252?Q?Cw4ctVy6S21rAWXus+SKZ8lDFT5NGN8qBGjaaCEj5Zqxs9bN1elLfM/Y?=
 =?Windows-1252?Q?+a30AzPGP6Y6WbkjAYRvvQ5HUf6vKpD40MacUU60bUXqSBx8O+YggTvz?=
 =?Windows-1252?Q?IGjezXxjoMZCP5INYhwyJNVUFo7UKnbcuQwgRmjwfMEnUtn1z+OM1ew9?=
 =?Windows-1252?Q?EcjddU1Y+wYhLxajSXLokbK35qZVoMhaZlR8KhExY4d4FZxSvkVlOkXo?=
 =?Windows-1252?Q?poxpU6jQ6g9ab2GBc/GUrQFCUjDb+pldVF+Cqz4zmLX50J3Qi8PgIIHf?=
 =?Windows-1252?Q?HIprR71xFN4Fg9lsm3nFs3Q8qpF8t95DhbtPr+mXBXldRokjS27q35iy?=
 =?Windows-1252?Q?eavzHzh60qjcGH39NvrEBqznZs/Jxs7hsEZ8JDO7CKO/g6KNIe2rL269?=
 =?Windows-1252?Q?rA41vj2gzHiGktBJa7WkAq2QlejB6Vif448ZrKdEYfgnDIGDKnZ7uXnP?=
 =?Windows-1252?Q?544nSJsbYv55wTclOzg3V0hzJwcARFhJIcEWo3hIZWq8geV+/+bfPJHA?=
 =?Windows-1252?Q?anpbEINVlhhMBWsz5jrMBTVYzOgUZMmaIf+mJ/2DhSYXiygEDZ00pOR9?=
 =?Windows-1252?Q?WMPpS6g+1dqa9MP08chWdCeorgTFgBDjl6Eo51K7zzw0Nq5jRbYoAv6t?=
 =?Windows-1252?Q?NmnH6Q=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <D052519973D32B489BF382D0EBB88915@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4920.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c2dc74-08f7-40b7-afec-08d9ba3dc149
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 11:27:44.7104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8JwiT1JqU/84Di4eCjzQnWBMd1jzDzdWppYrBOutlxhnt/QImwd4IV7DBKG3PYSYP2181YJ+KGucKa5GzG7gP4EyIMVLNIwLGHVM5ffp2ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5904
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/21 1:22 PM, Nicolas Ferre wrote:
> On 26/10/2021 at 15:20, Eugen Hristev wrote:
>> From: Mihai Sain <mihai.sain@microchip.com>
>>
>> I/O voltage for eMMC is always 3.3V because PA11__SDMMC0_VDDSEL is
>> tied with 10K resistor to GND. U13 switch S1 is always selected as
>> voltage rail of 3.3V for VCCQ power pin from MPU controller and eMMC=20
>> flash.
>> Removing PA11 from pinctrl because it remains unused.
>>
>> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
>=20
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

You can also add my
Reviewed-by: Eugen Hristev <eugen.hristev@microchip.com>

and also
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
because I sent the patch.


>=20
> Thanks, best regards,
>  =A0 Nicolas
>=20
>> ---
>> =A0 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 5 ++---
>> =A0 1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts=20
>> b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>> index b1e854f658de..9bf2ec0ba3e2 100644
>> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
>> @@ -66,7 +66,7 @@ sdmmc0: sdio-host@a0000000 {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pinctrl-names =3D "default";
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pinctrl-0 =3D <&pinctrl_sdmmc0_d=
efault>;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 non-removable;
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mmc-ddr-1_8v;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mmc-ddr-3_3v;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 status =3D "okay";
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 };
>> @@ -619,10 +619,9 @@ cmd_data {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 bias-disable;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ck_cd_rstn_vd=
dsel {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ck_cd_rstn {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 pinmux =3D <PIN_PA0__SDMMC0_CK>,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 <PIN_PA10__SDMMC0_RSTN>,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 <PIN_PA11__SDMMC0_VDDSEL>,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 <PIN_PA13__SDMMC0_CD>;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 bias-disable;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };
>>
>=20
>=20

