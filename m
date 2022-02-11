Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E684B21FC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348643AbiBKJaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:30:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiBKJax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:30:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF435102F;
        Fri, 11 Feb 2022 01:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644571849; x=1676107849;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pJ5+ppoj5ecqGvPRI+5WGdk8he/kjv7pD4/yVUcZdeE=;
  b=fAh9bgYDCbp+dr7Rsr/xb6S71Qy2SiowUCi7jPq2T1Q8bNrxDD8AXNA3
   Vr6liwAI0AX/fnyvI4sEwN0vMIKNgk4RL9xvZpcesSNG6oqoEjMFPE/e/
   LyU+gZn54eb4Wy78E1rNG/fi34lnHBrYT2V0JYurV9NY+Fe10gP8nir0w
   drT2GTcsNhoi4tuuaNRtMrcqSa55PcXh446NEdPe1x2q5S7IdhVTYqfp+
   zvkHv7ndHLmmSbPylMjHn9aiB9IBKJaHvX4mZY1ztsUKclCRrvDqHgWeL
   bFb7Ii/TrxswDXbB/x5hVkZoYPnkSSfptdeG6zJ0J3jisG3np/2oSjLGj
   g==;
IronPort-SDR: 0uraGhHe+CoelwYF/0ozg551BEhJkYEnDuRqYPc9SCseqKr11J6ZwFXyXeOtto4MeUem2CizA1
 2tSY8sW7hyukjF7LxWpA9VrjxwZrHPrMRf08X43ea3fKpVwRZFwESR3EqMRc9f/fd7+1ht/peG
 YusCJA9IQQbvQQaAtjJFqOBo01VHSc/91+ACMvHIyUIOhe0MPJF9noE4J/SazKr7cHJ0r7940X
 Jz669nThFPRDEqX60WZsyM9x1d5qVr773fhfgjX3nSsxkFlrU3yMUFreVkTvNstSYtr6MlTWWI
 sKiPhL4NVJ4x4M5FC7ekYbQj
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="152739208"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2022 02:30:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 02:30:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 11 Feb 2022 02:30:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlIz1rI9rdPWvgKSHsAeRW3xXpbJ6ymSdliYNl80BGbZDKFIhhS01ooZdtUBrbbfGI3vrYCmhob8MYNqL6h8hSFt5DDZKWZ+m7rjBFHO7ivdhhXusNZe/lWSZl+YcpvyuRKlAOfqTiw/Mm6b39Qir+06Pa7ticO//r6SBSG2N3M/qF923jvDJawnKFbLEto2I/G0yLjtX38ny2wxePcovRmiXB/OxX1ofHzXDt4yzOZbK0xKEUpxZVs3d2vNRVO/ydVQa6B0CrNzGlgm/XgvZBUiXRwREYUIBzlA//KK3m50Mj08HKGj4gf7e0Mis+qRDheNW+uBPJzUtwUiRFN4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJ5+ppoj5ecqGvPRI+5WGdk8he/kjv7pD4/yVUcZdeE=;
 b=nFkH6XPtUqff1YaKeerFfPtfIkUacq3bSOdSaSsaIjS0yMFjMUAygEDQ5GfRq7FbDTZCnOoTXa2TkaHf0Xso/ZahCpLbCp91IF83UW0TpwBeN/LUvwcFBmRK+rKaj6kNZ6txc9o3gKEnFaw5g9yT/lBLPVWgYrIc+JAs3VQyWaEneOJFVyg2j8qlaIcyd2bvng3p+ue72oK72CjeCwZA5SAF9m6xeiREarO7dgzxhZyfQzn5pUJw86cO+o+2QhbzYDQfDHdV9VHVGXzxEt2CYOZiHePgTs67pR1tAFQeBs/4kcWQEsMnpIybHlzoh1Xd9aJjmGwdQeXASQpDZ2nBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJ5+ppoj5ecqGvPRI+5WGdk8he/kjv7pD4/yVUcZdeE=;
 b=vHPc4OY2jkXo1JuV/vLsJiUjvplOSFW5+leejMfblXudHurgU5jw2/4z/hr5gC7jC3IoqWqE9Ns9GBYmpRaqbUoBxKjuKgi+18X6Yk+JIRWksF6rj3G4yN79/IqgRkK922yVt3tnA79ZsOnI4TUxlNkjVJdwxoFzpWs3Sm4yuxk=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by SJ0PR11MB4974.namprd11.prod.outlook.com (2603:10b6:a03:2d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 09:30:43 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::5cae:e802:4a48:bd0f]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::5cae:e802:4a48:bd0f%5]) with mapi id 15.20.4975.015; Fri, 11 Feb 2022
 09:30:43 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Kavyasree.Kotagiri@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <robh+dt@kernel.org>, <lee.jones@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Manohar.Puri@microchip.com>
Subject: Re: [PATCH 2/2] mfd: atmel-flexcom: Add support for lan966 flexcom
 shared configurations
Thread-Topic: [PATCH 2/2] mfd: atmel-flexcom: Add support for lan966 flexcom
 shared configurations
Thread-Index: AQHYHyoJhjiC4TUbPEusrwR4Fv+lCA==
Date:   Fri, 11 Feb 2022 09:30:43 +0000
Message-ID: <c7995f92-18c0-9201-3ae1-d6c820579ebc@microchip.com>
References: <20220210074546.30669-1-kavyasree.kotagiri@microchip.com>
 <20220210074546.30669-3-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220210074546.30669-3-kavyasree.kotagiri@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 755277e6-b32e-4f00-0f19-08d9ed412d02
x-ms-traffictypediagnostic: SJ0PR11MB4974:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB49740F3DFA0FE8E630660AED87309@SJ0PR11MB4974.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0tXIlefiZqcfHSe2A6v9Y0eeW3sH2JJH39k+mDBDqYRfhBAI5dyzYVQCTk0fEuRiQwGe9fTYxCWZdYs+B9EcF/QLKFUPm/AZud7pHipOx+s7L5o2Jtkv6V7nC1pOnB8sS7k1DuxVjgHSU/Z4KsRmUO3TAZAHZNQdGoFSZpteBLCihh8HVylfpPmYKI2Mjklk+rFP6s8rWsE7w1bxQJPO3UOnK9KJ4QPkMqpW/GN7TOhRZvGUdP+ITCGVb47KIU4d5Cm9wf86/tUzIg1o06MZSx1adyN+aqO7FTN6DrjcFmPPDVPJFspWYuoLGIzTop276C6y82ABuyBWLL4nPqNwk5GRLLpERHEz3RxvDCHWQazkQZc1euo/APsbBEY5zC9Rj7MeUt5sirgDNv9TVxoNC0ccf3DN32G9JsL0bD2E6vy8SLvqrKp97suf4tqUvvV2ZEp2MahF5bzKfezO1PAh1p5BA97lCyUJQubXmkraKCh6w7uF7LJ5SxnAQZu23RE1b67PMo+NUzOOwsJLNrfXjWMQZEcKeShHELSkzLwUMk4MwPLinPgYsSBlhs4L4xKMWu7l8vscPBYC2kRFQN7hyklko7yLFYR6WBFKrKjJSDOtXHvw0LIKk3tvJxSG+XMJbHe2McuGYpTkYMiSzVNiqairwLLE3QCAYovehhgOMmZFJcdawHVyxM8An8LBstZw72vQA5Fo/PooJLxVdsnNnSRZ7gRTiiHB3Su26zyaneEGppySU9G0W32PLGn01slmyszh06HZWXrQrB39fX4p932XhWHRi2nBx3Ezl9IijHRmYeQKosRWHtRhSI7dHD6fgjvblafWAPs3bk0Yk8bEB2PTFmFD/AnzlIL4pBj+Nn4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(6506007)(31686004)(53546011)(86362001)(71200400001)(8676002)(64756008)(8936002)(31696002)(83380400001)(66946007)(66556008)(508600001)(76116006)(66446008)(4326008)(54906003)(91956017)(186003)(26005)(38100700002)(2906002)(316002)(38070700005)(110136005)(6486002)(966005)(2616005)(122000001)(107886003)(36756003)(5660300002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnlrMFJJbVdvaThVVHFnOE1sNEFHQ1ZsckJEc3BBTjZWZzhtL0FCWHoza0wy?=
 =?utf-8?B?M3IrUmxMY3pvV252eXB3bzF3SE5GUlNCSFFxbkx3QkJGYUkvZExSM0JCR2hr?=
 =?utf-8?B?bjBzZFRsczIrVUhFa01iRmM1ZlUxWE82R1hRYUpFMzFuZnRMYWRjbDEya2Ix?=
 =?utf-8?B?UElybVpoWWtwWWhDVXByZGhHZ01UYWg3b3dMbjR6U2laSDJZcWVZRGJqbGsy?=
 =?utf-8?B?cGUzN0pNbnQ1UTJxckdrUjcrSjNwYTVObmo5V1BsdVlkbEhRc0o5WVljcGhF?=
 =?utf-8?B?WFdtVlBScUNRNkVSbzFkellOWFdsZ0kyUld6dDlaRkJteG5scUNBc2ZZcUts?=
 =?utf-8?B?aVUzK3Y4cDRsZk1hVDlEUWROT2xjWVdjNVIyVzdJWVZxK2FKTGpmTnQ0TlIv?=
 =?utf-8?B?eHZDRkdMeVZaOTEvUG9NUG50MDcxSVNvVVdmYkNrVUpkR09ReUZWYWZEcVVV?=
 =?utf-8?B?andGdStLelNQOEk5TWU1dS9UUFh1UVV4bk1wc0p6UG1xZ1YrSGF6RUZLK1FJ?=
 =?utf-8?B?cU9hUDZ0Kzc3b3BUZ1lEV3J3NkdObGt2ZG1LaXdTL0Q2VGIrVVdWbjVmZnl6?=
 =?utf-8?B?WHRNaDRoWTlwVnNRSDVNeWNKUXRjQ1pjMXNQdWxicWp6cXpHSDhtaVdkNEpq?=
 =?utf-8?B?ajlVUFZlZllwSElHNXVZZWd0RXBUNjczRTZkQUtweEdHMEJtcWs4ZFAyWGNu?=
 =?utf-8?B?UzdjSXVqc0ZBdTIvRCtTbTQ1OTQza2k0NVc2K1BpK1I1d0ZaRjZKRGx3aTdr?=
 =?utf-8?B?aDR3cXpoTk8wamppOWpSK0ZUSjdXSlZROGZoZThERkZnd0txcElQc2MyU2Nz?=
 =?utf-8?B?dm5ZNC91K0ZwakdGb3JFYjVRdEpGVHdaaSt4Q2FZbS9pSmxtWmQvRGpJaDhE?=
 =?utf-8?B?VGVqZEI4RzlBRTR3dmxRWVZ1NkFOelE4VlNSVEZhVXFJNmdJajAxOEg0V0Vu?=
 =?utf-8?B?TE8xTkE3LzRIUDhtZVVCVXY0bmVBajl0Y2ZpS2dNN0dTTFNuSVRlK280S3V1?=
 =?utf-8?B?YThwZ2gybXZHbGlhQ3VxekZjZGxNRHJPVHZ5Nkk3aXRZVWVYNG5INmsvekg5?=
 =?utf-8?B?TWdQS0VFWnFFSDV1bnJBYVRrMklCQW5YdnNsQndFR0NieFJQU09laUNEU2c0?=
 =?utf-8?B?TUNrekZMK3hZMmluQm1KZHBoVklVazdOc2IvYWNMV0RtdkdzRDNrY1R3dFBp?=
 =?utf-8?B?MTJkaXo0d3ZiKy9XZklpMm83c2Jzbi94TE9qNlhvMHkxLzRseDdzNzFwcnJ2?=
 =?utf-8?B?dTBIU2FlS0Ezc2VIUnByVVE3amVib3hObFRYazhTMDNpZnIxVXJNV1RRRVNP?=
 =?utf-8?B?a1NwNzY3UWZUZElxV09rdkh5K3BSazA3Umc0c05LQ0IzUE5XaWk4dUYxcmJF?=
 =?utf-8?B?ejlpRVl6RXpmWHRhZUhocHE3d0xFd3g0eDMzVFlTR0MyOXNOL2ltZlFMY2ty?=
 =?utf-8?B?YlJvVmp0TUxDQytKMi94YjNDNGtPZ3JERW51Vk9CU2cwb2twdTRqZ3UvdVZo?=
 =?utf-8?B?RTZhdTd4d2ozOUtjYXdadFZTSnQ0Q1BJdmZhS3czTHBoZEsxVG5VV2VUWVps?=
 =?utf-8?B?ek5OWmVKOElRUzZnbTByVlpzdkNvaEEvdElHTUF5Rm1Ba2VkS09jN1JtVUFt?=
 =?utf-8?B?SlQ4b3lDcnhleU1LYS9LUG8yTWl4QTZWRThwRmlUUkROS1BqUnJyV3NpRzFO?=
 =?utf-8?B?Nmk1cFBsdi9LSGNkU05LSW10dUxFazNPZXdsZWh4TWRDS1Fudlp3ZlFtTXRx?=
 =?utf-8?B?eWV2anJyQ2ZQQnhZSkp5Skk5bldXejBHMGE2WUwvUzZ0eGhOZmIxdk4zSEUv?=
 =?utf-8?B?eEtXeTZMK0V0YlpXZXYzaGVBZlBCVENBT1VZM3F4WFFHTVdWWm9UV0RRTFdX?=
 =?utf-8?B?YUNPaVJrbzZSZEdhb1Q2enBXM1JhWEhCMkdoR3g2Vkc1T0h3N1FkTXJOVkc2?=
 =?utf-8?B?NTc5ckhnc0NzV1l5VTlVTTVFM1ZncGlyRSsyK0ZISjJoYjdHS3g5RG84dkND?=
 =?utf-8?B?UWtTNlkrOWlyZEVmdUxCL09ZWFBPUEV0ZCs3eW9ERmhqMHByU1Y0d0NOZEZT?=
 =?utf-8?B?RjdqOGtxZnNxcVgzV05XNlhtc3dxQ05sL2YzZFRhTDI3UUQySmdML3k5NjdN?=
 =?utf-8?B?MC90cWJ3cDRsNlA3cFByd0cwL25mQnduVjdjUnVWV3lFbndJM012NVovZXB5?=
 =?utf-8?B?T0hnVEY0ek05bWVMQ3o4RFpWL09wNDRsRm9jYjViVS9XcFpaOEZjemY3T3h4?=
 =?utf-8?B?Kys3TVFOMHg3d0lXQjBKdk5MbUZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACF31B409408B246A4815C46320DA03B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755277e6-b32e-4f00-0f19-08d9ed412d02
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 09:30:43.1996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2AhXK/yXuiqwAZb9qu20WMkYzChYG9xXyChkop+TEkFGq3Uv8FwDtcJJfGszx2cPinE/2uW7H1ckhjxoqV4rX8YWQzuiG5gh4o19oxQwXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4974
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMDIuMjAyMiAwOTo0NSwgS2F2eWFzcmVlIEtvdGFnaXJpIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEVhY2ggZmxleGNvbSBvZiBMQU45NjYg
U29DIGhhcyAyIGNoaXAgc2VsZWN0cy4gRm9yIGVhY2ggY2hpcA0KPiBzZWxlY3Qgb2YgZWFjaCBm
bGV4Y29tIHRoZXJlIGlzIGEgY29uZmlndXJhdGlvbiByZWdpc3Rlcg0KPiBGTEVYQ09NX1NIQVJF
RFswLTRdOlNTX01BU0tbMC0xXS4gVGhlIHdpZHRoIG9mIGNvbmZpZ3VyYXRpb24NCj4gcmVnaXN0
ZXIgaXMgMjEgYmVjYXVzZSB0aGVyZSBhcmUgMjEgc2hhcmVkIHBpbnMgb24gZWFjaCBvZg0KPiB3
aGljaCB0aGUgY2hpcCBzZWxlY3QgY2FuIGJlIG1hcHBlZC4gRWFjaCBiaXQgb2YgdGhlIHJlZ2lz
dGVyDQo+IHJlcHJlc2VudHMgYSBkaWZmZXJlbnQgRkxFWENPTV9TSEFSRUQgcGluLg0KDQpIaSBL
YXZ5YXNyZWUsDQoNCkkgbWF5IGhhdmUgd3JvbmdseSB1bmRlcnN0b29kIGJ1dCBpdCBzZWVtcyB0
byBtZSBsaWtlIHlvdSBoYXZlIGEgbGl0dGxlIHBpbg0KY29udHJvbGxlciAobWFwcGVkIGF0IGEg
ZGlmZmVyZW50IGFkZHJlc3MgdGhhbiBmbGV4Y29tIGl0c2VsZikgdGhhdA0KY29ubmVjdHMgdG8g
ZWFjaCBmbGV4Y29tIGNoaXAgc2VsZWN0cyAoYW5kIG1heWJlIHRvIG90aGVyIElQcyBDU3MpLiBJ
biB0aGF0DQpjYXNlLCBpbiBteSBvcGluaW9uLCBpdCB3b3VsZCBiZSBiZXN0IHRvIG1vZGVsIHRo
ZSBwaW4gY29udHJvbGxlciB3aXRoIGENCkdQSU8gZHJpdmVyIChleGFtcGxlcyBpbiBkcml2ZXJz
L2dwaW8pIGFuZCB0byBwYXNzIHRvIGZsZXhjb20gb25seSBvbmUNCmJpbmRpbmcgc29tZXRoaW5n
IGxpa2U6DQoNCmNzLWdwaW9zID0gPCZ5b3VyX3Bpbl9jb250cm9sbGVyIHBpbl9udW1iZXIgc3Rh
dGU+Ow0KDQphbmQgdG8gZG8gcHJvcGVyIEdQSU8gaGFuZGxpbmcgaW4gZmxleGNvbSB3aXRoIEdQ
SU8gQVBJcy4NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogS2F2eWFzcmVlIEtvdGFnaXJpIDxrYXZ5YXNyZWUua290YWdpcmlAbWljcm9jaGlwLmNv
bT4NCj4gLS0tDQo+ICBkcml2ZXJzL21mZC9hdG1lbC1mbGV4Y29tLmMgfCA0OSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDkgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL2F0bWVsLWZsZXhjb20uYyBi
L2RyaXZlcnMvbWZkL2F0bWVsLWZsZXhjb20uYw0KPiBpbmRleCA1NTllYjRkMzUyYjYuLmI4ZmM0
NzZlNDExZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZmQvYXRtZWwtZmxleGNvbS5jDQo+ICsr
KyBiL2RyaXZlcnMvbWZkL2F0bWVsLWZsZXhjb20uYw0KPiBAQCAtMjcsNiArMjcsMTIgQEANCj4g
ICNkZWZpbmUgRkxFWF9NUl9PUE1PREVfTUFTSyAgICAoMHgzIDw8IEZMRVhfTVJfT1BNT0RFX09G
RlNFVCkNCj4gICNkZWZpbmUgRkxFWF9NUl9PUE1PREUob3Btb2RlKSAoKChvcG1vZGUpIDw8IEZM
RVhfTVJfT1BNT0RFX09GRlNFVCkgJiAgXA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBGTEVYX01SX09QTU9ERV9NQVNLKQ0KPiArI2lmZGVmIENPTkZJR19TT0NfTEFOOTY2DQo+
ICsvKiBMQU45NjYgcmVnaXN0ZXIgb2Zmc2V0cyAqLw0KPiArI2RlZmluZSBGTEVYX1NIUkRfU1Nf
TUFTS18wIDB4MA0KPiArI2RlZmluZSBGTEVYX1NIUkRfU1NfTUFTS18xIDB4NA0KPiArI2RlZmlu
ZSBGTEVYX1NIUkRfTUFTSyAgICAgIDB4MUZGRkZGDQo+ICsjZW5kaWYNCj4gDQo+ICBzdHJ1Y3Qg
YXRtZWxfZmxleGNvbSB7DQo+ICAgICAgICAgdm9pZCBfX2lvbWVtICpiYXNlOw0KPiBAQCAtMzks
NiArNDUsMTAgQEAgc3RhdGljIGludCBhdG1lbF9mbGV4Y29tX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYt
PmRldi5vZl9ub2RlOw0KPiAgICAgICAgIHN0cnVjdCByZXNvdXJjZSAqcmVzOw0KPiAgICAgICAg
IHN0cnVjdCBhdG1lbF9mbGV4Y29tICpkZGF0YTsNCj4gKyNpZmRlZiBDT05GSUdfU09DX0xBTjk2
Ng0KPiArICAgICAgIHUzMiBsYW45NjZ4X3NzX3BpbiwgbGFuOTY2eF9jcywgdmFsOw0KPiArICAg
ICAgIHZvaWQgX19pb21lbSAqc2hhcmVkX2Jhc2U7DQo+ICsjZW5kaWYNCj4gICAgICAgICBpbnQg
ZXJyOw0KPiANCj4gICAgICAgICBkZGF0YSA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXpl
b2YoKmRkYXRhKSwgR0ZQX0tFUk5FTCk7DQo+IEBAIC03Niw2ICs4Niw0NSBAQCBzdGF0aWMgaW50
IGF0bWVsX2ZsZXhjb21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAg
ICAgICAgKi8NCj4gICAgICAgICB3cml0ZWwoRkxFWF9NUl9PUE1PREUoZGRhdGEtPm9wbW9kZSks
IGRkYXRhLT5iYXNlICsgRkxFWF9NUik7DQo+IA0KPiArI2lmZGVmIENPTkZJR19TT0NfTEFOOTY2
DQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBGbGV4Y29tIFNoYXJlZCBSZWdpc3RlciBDb25m
aWd1cmF0aW9uczoNCj4gKyAgICAgICAgKiBJbiBvcmRlciB0byBtYXAgY2hpcCBzZWxlY3QgaW5k
ZXggWCBvZiBGbGV4Y29tIFkgdG8gRkxFWENPTV9TSEFSRUQgWiwNCj4gKyAgICAgICAgKiB3cml0
ZSAwIHRvIGJpdCBpbmRleCBaIG9mIEZMRVhDT01fU0hBUkVEW1ldOlNTX01BU0tbWF0uDQo+ICsg
ICAgICAgICovDQo+ICsgICAgICAgaWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwgImxhbjk2
NngtZmx4LXNoYXJlZC1jZmciKSkgew0KPiArICAgICAgICAgICAgICAgLyogU2hhcmVkIHBpbiAq
Lw0KPiArICAgICAgICAgICAgICAgZXJyID0gb2ZfcHJvcGVydHlfcmVhZF91MzIobnAsICJsYW45
NjZ4LXNzLXBpbiIsICZsYW45NjZ4X3NzX3Bpbik7DQo+ICsgICAgICAgICAgICAgICBpZiAoZXJy
KQ0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiArDQo+ICsgICAgICAg
ICAgICAgICBpZiAobGFuOTY2eF9zc19waW4gPiAyMCkNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIC8qIGNoaXAtc2VsZWN0
ICovDQo+ICsgICAgICAgICAgICAgICBlcnIgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgImxh
bjk2NngtY3MiLCAmbGFuOTY2eF9jcyk7DQo+ICsgICAgICAgICAgICAgICBpZiAoZXJyKQ0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiArDQo+ICsgICAgICAgICAgICAg
ICBpZiAobGFuOTY2eF9jcyA+IDEpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAt
RUlOVkFMOw0KPiArDQo+ICsgICAgICAgICAgICAgICBzaGFyZWRfYmFzZSA9IGRldm1faW9yZW1h
cF9yZXNvdXJjZSgmcGRldi0+ZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMSkpOw0KPiArICAg
ICAgICAgICAgICAgaWYgKElTX0VSUihzaGFyZWRfYmFzZSkpIHsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgZGV2X2RiZygmcGRldi0+ZGV2LCAiTm8gRmxleGNvbSBzaGFyZWQgcmVnaXN0ZXIg
Y29uZmlnXG4iKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoc2hh
cmVkX2Jhc2UpOw0KPiArICAgICAgICAgICAgICAgfQ0KPiArDQo+ICsgICAgICAgICAgICAgICB2
YWwgPSB+KDEgPDwgbGFuOTY2eF9zc19waW4pICYgRkxFWF9TSFJEX01BU0s7DQo+ICsNCj4gKyAg
ICAgICAgICAgICAgIGlmIChsYW45NjZ4X2NzID09IDApDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHdyaXRlbCh2YWwsIHNoYXJlZF9iYXNlICsgRkxFWF9TSFJEX1NTX01BU0tfMCk7DQo+ICsg
ICAgICAgICAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHdyaXRlbCh2YWws
IHNoYXJlZF9iYXNlICsgRkxFWF9TSFJEX1NTX01BU0tfMSk7DQo+ICsgICAgICAgfQ0KPiArI2Vu
ZGlmDQo+ICsNCj4gICAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUoZGRhdGEtPmNsayk7DQo+
IA0KPiAgICAgICAgIHJldHVybiBkZXZtX29mX3BsYXRmb3JtX3BvcHVsYXRlKCZwZGV2LT5kZXYp
Ow0KPiAtLQ0KPiAyLjE3LjENCj4gDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsDQoNCg==
