Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BFC48B0BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbiAKPXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:23:07 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:55048 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244282AbiAKPXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641914586; x=1673450586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mM6ZUR2Js9jheEl/8Is3wsiFghgU1V6sdxq9LFb3R54=;
  b=HrrgnzLIt237ZgqMjkvQp+I1pUNXFj00Iskcbfm8sCsk/O+DOPCHKg2K
   64jk9HE+b8+DnHZrNOsv2PfZbdCUoYK2cNiblmcyTnIS+n2dweWHaAbSF
   1qLD33dVvBezFMPU7dPGSMyCvXEopbWGoxEPdTqDUCmCrxJJyLlfxjAc6
   49SgrziPj/rS2n/GeuY3CCFvgUtS5lmRW+hIB277tf/BB3zMhTFMmtzM+
   sbVKTcLAaKb3wMZ09haITVtB+sgwMOSJ8C1vHc2i81dCdbf54ZPYhjoA5
   fvTdjOp5SRkQKUTSFwAKcLVX7+wmufIuaGRnOb8wRB2MnTRq3YDRpelyg
   Q==;
IronPort-SDR: hnxNKfZoC3r/R9DmTOPVkImn2mbL+92++3Ep4YFj91UppCsEJwzowXbVklCg2gSajsfEf2NgSV
 FnES2DyF1hN5fZHm3v4hq0n2ZUh8jFjvkuCl24UoJukKwVCbXT71dKBFSI70UOFbDqnX7zK+9J
 TRdJeATFzf3eDe+BmRr2uMfgBv53dLEZCxm1Bw7s/MW58S1a1mNw4uR3Oxa8he+fFXs5lVvmG7
 MMtDMtU0MdFSHMi/7boFHwioOdYZYCAiyHrwSFcqAF588a9mOsvmFCZ0ULGa/pnhzqyeAY24QH
 o5rNd0eU9fPGLnjOrdzhjPmk
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="149267391"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jan 2022 08:23:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 11 Jan 2022 08:23:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 11 Jan 2022 08:23:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KA635JtJ7z3qB7rYunBZq8d9fV16QwnRqnDOu6tSo5jTNu6z6boqAM7dKx1U1wPThJ50Zd1WaNwabs1N0CnkJ5Wq6jnUKXZnPxaLmzM4JcRXb2IW7lQP+7P1n4l0WwJcy7OY1sf6Q4qIqOXfziIx89TZRW3ta1YahhcN4NibGcXYt09QrftAVw92jCkpc5TWgoMbY14PHVLUOp2DVGS/JHCZxq7LdCPMhpRi2AyWe8Ft+LeqnoUxd8NUZ8tVhHprljc735JFtnrvrJ5RQThd0wITjxsYSO/hO2zbyeLuSeHCo+BgHhOKORfD4XD4HK3vr12YMAVEtEMkq0+4WN2Wqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mM6ZUR2Js9jheEl/8Is3wsiFghgU1V6sdxq9LFb3R54=;
 b=dc7zLIG0PsGpjzxjKfJ8+/VJ3mARNUMlE/wyWtYDS5VGeZ3yNqMi4HxXk2v5VePewhTUsJQOF/nbQnmZxtsRSoY23PTIULTr1V4gLoyT+6LCCRd3vGpqQPB53BbcG8kE4u+6edZsyL7rz4k3lE6CeQS0UOjvzy0IYiCe/YHLhyGHY5pf6IXYlW0yYZP0UtWIwK8Rpqh1IVNl6kNCVY0HwKiw4hHOFz3lc20IIXNjuAqVYSr+H+QI3UDVhBj6J4UUUN7dRC0pmqejXVFdM0pVthq6zRWw+wbgslPfHx3hNQvue0kDbQtkwg6mwBYjxz4urRCOGq0PKCGRL3DS1u09Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mM6ZUR2Js9jheEl/8Is3wsiFghgU1V6sdxq9LFb3R54=;
 b=jkFQ/5fUtrUlyZv7uetSqBJIS+PeaR5VaKSEV0DrYlI5whAb+yX4RQPMeIs2HCC/N1FJUOI4l++5OicN0BjakB6dm+Rh7ARu5bSnRCF5CL9men/wQszIjuX0QPQSCJxEY7a23BqPdzS9NkWtFY4h2Sc2pBezOGlFbetHFXXwwYw=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by BN6PR11MB1939.namprd11.prod.outlook.com (2603:10b6:404:ff::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 15:23:02 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::5cae:e802:4a48:bd0f]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::5cae:e802:4a48:bd0f%6]) with mapi id 15.20.4888.009; Tue, 11 Jan 2022
 15:23:02 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Tudor.Ambarus@microchip.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <robh+dt@kernel.org>,
        <rdunlap@infradead.org>, <unixbhaskar@gmail.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: sama7g5: Allow MCK1 to be exported and
 referenced in DT
Thread-Topic: [PATCH] clk: at91: sama7g5: Allow MCK1 to be exported and
 referenced in DT
Thread-Index: AQHYBv8fEO+hcVN7qEibY31yRBQhkg==
Date:   Tue, 11 Jan 2022 15:23:02 +0000
Message-ID: <528f5d1b-aeeb-6c2a-42a5-e4e2f2fba2c5@microchip.com>
References: <20220111125310.902856-1-tudor.ambarus@microchip.com>
In-Reply-To: <20220111125310.902856-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94ef346c-7ef5-4882-f9da-08d9d5164207
x-ms-traffictypediagnostic: BN6PR11MB1939:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1939AD91E18EB31281B982A387519@BN6PR11MB1939.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y+EWxFV6ytGodts6q6/q7YgZu/58RBYzfHrWls+jwOlToyYdGlhDBT+FvV2R+d50rsiW82pm1xB/P4R+p66zfK33MdKev+YeABWPjW0IiGYWGZN9D25aoUCl+gr7fEYJXrk5zAfzpMXn8J0qmQ+W2J0ZRngBgRYiNesZivNEulR2NYC8arC5Fh76ww1RT0zRgr49Nd8rn9e5tbz+b2OU/Udt9PJhuCR0/rcgiT0+dCSXsgTEiJSmFgjYFYFrtQRCmNAvaEjBP+kryhQ8MCj/j4p+5mv+oOzBWTLNjmZbdJRcnh6jgxHWDFgEmgcm1i6fW9d9Y4MqtupKpzUusN2B//VggG5WI46snbcn/gaPKehz/ZLW7cK1dGjUbDvOSCbNnVfxemVJabT13WpJb+xrHhdQbbXSyYTQvKN5W0xRV1GQeLWsya8UPtnFQ8PbCXkZqXUHzKv5c594JZ7+Eo3GBjek654N3R72q6hB0TUhNgF3duTpUCJzW/TTp6Qramoa+FbDxBnlon4/D0GdH89faCbSRzaswZ2eQ4SYrHLvP7mATDcC7nwtdcZ+72rjqBTjFnPeVOvv53YG2rdwm9X9oIIATdEr1VfZJNj3SJW6/pTAHLLFPh1O5HT/CwSp9HJrSihAx91sKcKcmTlkkma1flhsDXvDP22DtwxhBVqM2iBH7jjbC5tFy7olczTlNiO3SML3Aq+8dufAEA8hQMnoAiBrWibFqUaSG4PMSkXUlvi4d6jIht+VXuc9S+gYb0DprItro81CCkXpRj3XfzrMig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(54906003)(110136005)(66476007)(6486002)(5660300002)(508600001)(2616005)(66446008)(64756008)(66556008)(316002)(36756003)(38070700005)(4326008)(86362001)(91956017)(76116006)(38100700002)(31686004)(53546011)(31696002)(71200400001)(8936002)(26005)(7416002)(8676002)(122000001)(66946007)(83380400001)(6512007)(186003)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djFwUDlGUTZmaEE1V1ZjRDduWWR0bTVoNGp5akRzWnFEYmVVL1BGUnI2V0I3?=
 =?utf-8?B?RDZjVHZlcWJYdk0vMjlLMldmSDZVclBoQ25FZ0h4ODJCK01jRUdpc0htNGV2?=
 =?utf-8?B?UERsSDhtRlVRL1UrSVNBMXc1SlZqWTIzNm02aS8yT0JIV09IeWdCTng1aXQv?=
 =?utf-8?B?OXhsTHR0ZzRLekFHUm84UjUrZTlaNDF4NyswZnJFenFLS1Y1N1BOVlo1MEV5?=
 =?utf-8?B?alYxMldSbXZTZ21WRWZFVVhET0hJZHZPL1ptNlZqdUtQckdYNnh4V1l3dUcz?=
 =?utf-8?B?aXpvaUQxLy91dVdLNDU3bjZRUXB3aHZoZm9wOW1MbFF4TkJYaEh6djhscFlX?=
 =?utf-8?B?TXhKZmw0MkJiMUNMOGZ4MTNkTGQ3Q2U1dnBBSXFTVGRFZC90ejlyVHprb0VF?=
 =?utf-8?B?NlNaNFh6eDJIU0hWQ1J3OVZ3MlB6SVppRVJ0YllJUjJmVGtTUnJTWkZyOXVo?=
 =?utf-8?B?bTd0b0JEMHgrTzNUazI0UEtBSU96dzBEUUFZSnRJU0R0ai9NTFB3SW40cnlO?=
 =?utf-8?B?UWcvdlhVUEdIdElMb3FDVzkxRmhsU2MrV3RLN2ZLMFYzNmYySHZPL3pyeGtE?=
 =?utf-8?B?dnZUNDdmaHh1RlpoL2pTTzR0MXpwUERzREVXUUhYcXpsVFlZcFVWOC9OdFZ6?=
 =?utf-8?B?RUZKTXZOZzkrc0N4L0xTSVRJWkhjSG5wYjVPMzlrY2pIckhXRTh5b01GMDA4?=
 =?utf-8?B?NWE0NDJxWEJNNVg5VmMvRjBmaVpkL0R6alVFMXBYZDZmTnU2U3NhQlpScVZ2?=
 =?utf-8?B?YjdnL3JGbGplVlczR0tsc1AxMzZURFJLQVlJWGNlRitZeWVJOFFuUFZ1RXEz?=
 =?utf-8?B?UHJJRzhNdGpvNVpnTDMwV1ZQSGQ5aVhManhiUGlrV2xJQWdUVkphckdnVUVJ?=
 =?utf-8?B?ZVBVLzlVZVNWdm0yNHRSWEVMV3kyYnQ2T3NhU2tTMG9XKzFMY2h4WkdlKzcw?=
 =?utf-8?B?a0VjdzkxcGRkUDhINUdCREI1aXl5WEh4S0hBT2M5RUNabVlib1NraGhhRU9B?=
 =?utf-8?B?WTNSNjZNWCs5a20xeFRseFVRK2F3ZytxM1VHRitMeVNMVTdSTUZ0d3k5Q1A5?=
 =?utf-8?B?b21oRmJlNC9XZVVINGcrVjYxaXJibUpYRElKWks0aDYxRnZYcUo1eW9Sb2pW?=
 =?utf-8?B?c085NzJsMmVJSUJvS0FnVVYyVnJJcFdtb0RDdmlTb0FqbEx4czU0ZkNXQmlm?=
 =?utf-8?B?L0xLZXZnR3laRVpzSXFPSDhqQ1M1L3hsaVYxMkpnNVJ2RE1WbUl2R0RvZGJj?=
 =?utf-8?B?QzBQU0JocFhoU2ZsUHhib1h0QlpKNE5JckNGUEdoNXNFclI4MmhyQ2hMRVE1?=
 =?utf-8?B?c1c0U01ERCs4bDFsQTdhbVdZaE9SelNzUzRMYXJyUkJ3enZGVnByUngxb3ZS?=
 =?utf-8?B?UXR5aS84TlRiWnJDUjBiUVljbmJSVkUxSmVVVmhLdklMMVBUdHR0ZnlTZnZ0?=
 =?utf-8?B?R2tuRG9LZTYrZ0FsenF4TzBlcU5kNDlZWTZ5QVErTFFkSjl5TFlBOERxanlB?=
 =?utf-8?B?NVRNSG5XdHNta1pmZElKeCtCM1JiVFRKRHhLVE1mb2IvZ0RJRU1nQ2d5R0Zi?=
 =?utf-8?B?dlhtSDBTZWtSNDhMUmNjZ3EycVptbThMMGQzS2prc1AyKzJhb0h0b2VuTmVU?=
 =?utf-8?B?ZHlrcFF5ekpobVI3VGpiRE95TE5JS2NBUjFKYXFmZTZDT0l6a0RQWG03ay91?=
 =?utf-8?B?SWFCTTNEUXZENEFrbDNvL2QvcXVPTGRqZnk1ajBQbDUxdjN2aHVrMXUxTTEy?=
 =?utf-8?B?UlRwTERKL3lRQWp4eG9HWDNmczNjNnc1REVXTDdGRFoycTRZZUFBRUpiUlR4?=
 =?utf-8?B?WUFPZUkxakFEajVMeU9FK1lxOFBMTmFiREhlUGZCUTlJVGtnSUxiL3h1L2lC?=
 =?utf-8?B?bHVjL2czaS9RN1l1aDNDT1hNSHFOT2hUZGdNeXIzLzl5RjlNdmEzZFYzZWE3?=
 =?utf-8?B?OFZ3V1g0bUd3bG0xUHBrbzI5Y2xQYmxoUmN6WnZmZDdMLzhwN29ZQUUyNnQz?=
 =?utf-8?B?cjVsVXI3dHlpQXhYU0pVK0RaVlllWkpZUWxXbmovbHpLVFczM3dlT2JkcG1h?=
 =?utf-8?B?azdCVWRGZGxBVWcxWlBLdTJEY0pmTGZkdThmZ2U2ZVF3WCtKWnB1MzlYTTB3?=
 =?utf-8?B?V3VtdjBqLzFuQzE1WEd1UHdKTFdrTkM3M1ppVmN2SFlzYm53K1B6QkM0cnBO?=
 =?utf-8?B?WEkzdVh1N3hnR3h3eXNZTGRZTXgyM29XcFlvRm1ENUU3R0wyZ2xWTDFYcFZG?=
 =?utf-8?B?SWtEMUwzczdodFlHVG1ya0xOdTlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BF956F8BA01A24DBE16CB380ECFA603@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ef346c-7ef5-4882-f9da-08d9d5164207
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 15:23:02.2501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5N4BLW8MoXBy2rMJjYqVVmRvPIbw0MoF/7+6sbeHOIJkU/l3Fd3fkoGjvLhfTyG9BRQfnoWX6d2O/Gtt6J6RCJOXsmgj9lSKsiG55LfndUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1939
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEuMDEuMjAyMiAxNDo1MywgVHVkb3IgQW1iYXJ1cyB3cm90ZToNCj4gTUNLMSBmZWVkcyB0
aGUgRXh0ZXJuYWwgQnVzIEludGVyZmFjZSAoRUJJKS4gRUJJJ3MgY2xvY2sgcmF0ZSBpcyB1c2Vk
DQo+IHRvIHRyYW5zbGF0ZSBFQkkncyB0aW1taW5ncyB0byBTTUMgdGltaW5ncywgdGh1cyB3ZSBu
ZWVkIHRvIGhhbmRsZSBNQ0sxDQo+IGluIHRoZSBFQkkgZHJpdmVyLiBBbGxvdyBNQ0sxIHRvIGJl
IHJlZmVyZW5jZWQgYXMgYSBQTUNfVFlQRV9DT1JFIGNsb2NrDQo+IGZyb20gcGhhbmRsZSBpbiBE
VC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWlj
cm9jaGlwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5l
YUBtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9jbGsvYXQ5MS9zYW1hN2c1LmMg
ICAgICAgfCA4ICsrKysrKystDQo+ICBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2F0OTEuaCB8
IDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL3NhbWE3ZzUuYyBiL2RyaXZlcnMv
Y2xrL2F0OTEvc2FtYTdnNS5jDQo+IGluZGV4IDM2OWRmYWZhYmJjYS4uZTQzNDU4NjczYWZiIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9hdDkxL3NhbWE3ZzUuYw0KPiArKysgYi9kcml2ZXJz
L2Nsay9hdDkxL3NhbWE3ZzUuYw0KPiBAQCAtMzAyLDYgKzMwMiw3IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgew0KPiAgICogQGVwX2NvdW50OgkJZXh0cmEgcGFyZW50cyBjb3VudA0KPiAgICogQGVw
X211eF90YWJsZToJbXV4IHRhYmxlIGZvciBleHRyYSBwYXJlbnRzDQo+ICAgKiBAaWQ6CQkJY2xv
Y2sgaWQNCj4gKyAqIEBlaWQ6CQlleHBvcnQgaW5kZXggaW4gc2FtYTdnNS0+Y2h3c1tdIGFycmF5
DQo+ICAgKiBAYzoJCQl0cnVlIGlmIGNsb2NrIGlzIGNyaXRpY2FsIGFuZCBjYW5ub3QgYmUgZGlz
YWJsZWQNCj4gICAqLw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCB7DQo+IEBAIC0zMTEsNiArMzEy
LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB7DQo+ICAJdTggZXBfY291bnQ7DQo+ICAJdTggZXBf
bXV4X3RhYmxlWzRdOw0KPiAgCXU4IGlkOw0KPiArCXU4IGVpZDsNCj4gIAl1OCBjOw0KPiAgfSBz
YW1hN2c1X21ja3hbXSA9IHsNCj4gIAl7IC5uID0gIm1jazEiLA0KPiBAQCAtMzE5LDYgKzMyMSw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgew0KPiAgCSAgLmVwX211eF90YWJsZSA9IHsgNSwgfSwN
Cj4gIAkgIC5lcF9jb3VudCA9IDEsDQo+ICAJICAuZXBfY2hnX2lkID0gSU5UX01JTiwNCj4gKwkg
IC5laWQgPSBQTUNfTUNLMSwNCj4gIAkgIC5jID0gMSwgfSwNCj4gIA0KPiAgCXsgLm4gPSAibWNr
MiIsDQo+IEBAIC05MTMsNyArOTE2LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IHNhbWE3ZzVfcG1j
X3NldHVwKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApDQo+ICAJaWYgKElTX0VSUihyZWdtYXApKQ0K
PiAgCQlyZXR1cm47DQo+ICANCj4gLQlzYW1hN2c1X3BtYyA9IHBtY19kYXRhX2FsbG9jYXRlKFBN
Q19DUFUgKyAxLA0KPiArCXNhbWE3ZzVfcG1jID0gcG1jX2RhdGFfYWxsb2NhdGUoUE1DX01DSzEg
KyAxLA0KPiAgCQkJCQluY2soc2FtYTdnNV9zeXN0ZW1jayksDQo+ICAJCQkJCW5jayhzYW1hN2c1
X3BlcmlwaGNrKSwNCj4gIAkJCQkJbmNrKHNhbWE3ZzVfZ2NrKSwgOCk7DQo+IEBAIC0xMDI3LDYg
KzEwMzAsOSBAQCBzdGF0aWMgdm9pZCBfX2luaXQgc2FtYTdnNV9wbWNfc2V0dXAoc3RydWN0IGRl
dmljZV9ub2RlICpucCkNCj4gIAkJCWdvdG8gZXJyX2ZyZWU7DQo+ICANCj4gIAkJYWxsb2NfbWVt
W2FsbG9jX21lbV9zaXplKytdID0gbXV4X3RhYmxlOw0KPiArDQo+ICsJCWlmIChzYW1hN2c1X21j
a3hbaV0uZWlkKQ0KPiArCQkJc2FtYTdnNV9wbWMtPmNod3Nbc2FtYTdnNV9tY2t4W2ldLmVpZF0g
PSBodzsNCj4gIAl9DQo+ICANCj4gIAlodyA9IGF0OTFfY2xrX3NhbWE3ZzVfcmVnaXN0ZXJfdXRt
aShyZWdtYXAsICJ1dG1pY2siLCAibWFpbl94dGFsIik7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2R0LWJpbmRpbmdzL2Nsb2NrL2F0OTEuaCBiL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXQ5
MS5oDQo+IGluZGV4IDk4ZTFiMmFiNjQwMy4uODQ5OGMwY2Q5NWZlIDEwMDY0NA0KPiAtLS0gYS9p
bmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2F0OTEuaA0KPiArKysgYi9pbmNsdWRlL2R0LWJpbmRp
bmdzL2Nsb2NrL2F0OTEuaA0KPiBAQCAtMzUsNiArMzUsNyBAQA0KPiAgI2RlZmluZSBQTUNfQVVE
SU9JT1BMTAkJKFBNQ19NQUlOICsgNykNCj4gICNkZWZpbmUgUE1DX0VUSFBMTAkJKFBNQ19NQUlO
ICsgOCkNCj4gICNkZWZpbmUgUE1DX0NQVQkJCShQTUNfTUFJTiArIDkpDQo+ICsjZGVmaW5lIFBN
Q19NQ0sxCQkoUE1DX01BSU4gKyAxMCkNCj4gIA0KPiAgI2lmbmRlZiBBVDkxX1BNQ19NT1NDUw0K
PiAgI2RlZmluZSBBVDkxX1BNQ19NT1NDUwkJMAkJLyogTU9TQ1MgRmxhZyAqLw0KDQo=
