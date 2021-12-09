Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4816546F1DA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbhLIRaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:30:39 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:18600 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242888AbhLIRai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639070824; x=1670606824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5yjNIX0nLjm0mYvwtNPsi7rCT9vLoY4lPx35Ejq0CP0=;
  b=vp8OSXWCHkhyUOS/WSF2HPPqZTjEViIkrnb+eowJGSkEuuy7oAjysoi5
   VsRiVwRS8R7SCXXd/fc6dqzGUZsSzBsC9SaFvviB9dEXcpVHJ752CFDGv
   I+hRjDAns1MRYwKxdL5meRZh6gLfP8E269NkH6ebjF7vm8ovYEh4JbSno
   vdVF+lzbXl/S2l0F7hc5rR8KjXXMWPJyMF4qzZxuWt95BCem9iFQWo8WX
   iaqnIBKHJglTQpm+iMO7bFdNBKBb/NlPzH735VX63DCaEuz4aQqy7AXrl
   AWOT4eoJ67oBtq+lRGUKuouKjYBg9dg7gVKVuqg45nVxOy7AxSRSnUNpR
   w==;
IronPort-SDR: TryltKFbnH+xaEx32M/vCkT0w0cXnKckSrnaobm87WdmIWY29FnfCr4Z8ZgCizjOGsp1hmATo1
 pvI7E91z4mliNb1StmbTnZm1d0kMJEwTq4kd4QK/UbeMjc4ObEUqDJi5i9rLmGAfzqVNRuic4k
 VRkNFeOJOweTKZhtNwL3vVzwpraBUuCIFmgj7VZfnxoedYguUWousaeeTJxtwKQDjHXWp7Dd3S
 SHyD03wWSrVoyhwszt5wG/XpSWhkNSgFh/HK223tmIve1BRCoTqgOgNizmFI8D/8Xaa9r3BMmC
 xPT10THlzWZuXePysn8IqAo5
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="139260040"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Dec 2021 10:27:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 10:27:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 9 Dec 2021 10:27:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aks1c6nfuQ77GvX89pDVX3RKHM45adkoBVKJQRxhEV2hSBcECmUOsa3h9xHMNHuGn6pc0moHojNkIOz7bo0Idz6ER9CDk7RPRFuarbgxureCun42HfMu/9h6knNe+2eIvYL/omk3hgQNA7IwvIM0vqsiZumKyAMyeGm5qdP78gIlx26zFRTILvqe+n6++QhX7AmJxQSA0ENLrfNezHaxsgsjxmYDot/SkX4LAjCj+vatc7oxuBCA4pZoPCLwNHBtcrhIecN8NN6U57IYWgs41cmcJJ7Jbwq6lUK8FBcTEhZ8KTtSJq2sP+Eeio+ancVGrXdtKlw+ZfxJJWD1M3nygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yjNIX0nLjm0mYvwtNPsi7rCT9vLoY4lPx35Ejq0CP0=;
 b=niU3L1FyiS7K66Z37ZpQdFd/4eWLAqo3hL6obxFV6x6eqpOth4Yn3NevPFwqZ7cHC/sDXwk5Z9T79r8741gFS1QVIY9Y49RXwF6Ih1Ft+f/mpI2vof+0dEguEqHgHxyUQpZ+5ZmAFZx4ou6ufkzcI5Hsd9rvoCa6eLJ4DM+XDMK+lU1Gu9b3/vFM606uricSZooe8J+ynTJrZUWryW/cs2bB1U4OYq0yuB8BFx/1/ihD49jd7S5QRl+Y7z4wWVJ9zSzCHkmPfw1FX73uTKDpLk5NndqJqKryOhiKBkxm3JamhNrPnLFnxpzTm7ZL7BWlbpIu6zZ7AN1EUsJB3MorlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yjNIX0nLjm0mYvwtNPsi7rCT9vLoY4lPx35Ejq0CP0=;
 b=K6XpHzpG9yXs0/BjnyZclZ5tWwL0D2IPo0dmv0MN/6nh9yrKGXfQIzORW+36ltESzJM78wmuqKcNrhDneVuRvA5gBmsd4THaA2R+U0kScRvRchaOWU7tYUuuwd/TPcNAlfxbOt5CG7c2h68mlaxGq0RvDHz4NIeBN90FLhcOSGM=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2959.namprd11.prod.outlook.com (2603:10b6:805:db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Thu, 9 Dec
 2021 17:26:57 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%6]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 17:26:57 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <broonie@kernel.org>, <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: atmel,quadspi: Convert to
 json-schema
Thread-Topic: [PATCH 1/2] dt-bindings: spi: atmel,quadspi: Convert to
 json-schema
Thread-Index: AQHX7SH3H6J1iWdbhE+0Rp+VrKNU7w==
Date:   Thu, 9 Dec 2021 17:26:57 +0000
Message-ID: <ae9004e6-95b4-63c3-a9c6-d3616bf42561@microchip.com>
References: <20211209122939.339810-1-tudor.ambarus@microchip.com>
 <20211209122939.339810-2-tudor.ambarus@microchip.com>
 <1639069842.758236.3089523.nullmailer@robh.at.kernel.org>
In-Reply-To: <1639069842.758236.3089523.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0b9cf7c-5d69-4c7d-4ae2-08d9bb391a40
x-ms-traffictypediagnostic: SN6PR11MB2959:EE_
x-microsoft-antispam-prvs: <SN6PR11MB295923A535F81A2F76C5F750F0709@SN6PR11MB2959.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UHiNDRqw3xIHnITcB8Lo8lK+CjbZrOhRDUbLmtQ45vT2amknEOVxeBCaumkAJJnDEz0ToDTtudcMJHyojvhZhMJ2/JPsTHc2zPSv9zjWhMz2lLuVcPIE2IvgZDp8bJqesOi5yY96pK2nJektbslzvsewUGz1eq32SN9sciSRNf88No8OMfx4J8qPkLsniJrZW62iNXZ9BiV/bTY0bTdXc2BLROwRnLP4zSyCMDZYxE42Uzc9oQyViNlTJrp2rV+T9k58hPtZVH/+HaCJQB8z6LqwHAxmj4LxkRymiAzfOO8T4XHJYHDzbdw1Tm8DZE9IyfZEmV7gpBOcqa/x9y7gsX1GCBewUtb1V2AZXjS2T5VkpdrcibLNFFETuWMbL05cwvmL5eprym09BeqPVASAf3YrVLVwGyEbJ8d2mDamqK856D84GH6cANPls1GBcMpzUCdHo7yapJYa1vWjo/8ErJdbV23ZWD3YoDrLeu8pyh+TUnyTUYTs46blNcV0AZEMuvBCyXPBYga8JPbdpeD8Kr9kawh773CVV7HZR5meTa1eW7uh+BdehmXXNAAN149HIKOd8O58gwS7LvRH1aoCLswPdmBaGBiltBzMFkbUNGu8SyZc4ToTjZOQF0z9hqc+Y/MCO+kkdlR3nRCKhTSj51k3WnuarTHKV20k2YgeYs9Xh9tF8DLDtmckfrVzYfZPxusUE31uYif8Ufdx5OEmgDI1cdEMKeoD7ZUt9JwoW1Sq22tAbcWl/usdPn/LQtFIqH2kjErzCbtVaOra81h2Lwk1LCMCNJDq4QHo6j+Rves+5705NSWhtVPEvURk0oToEY9sMiLbh9FxJ72P63gk3gCArs6LE7DaO/SLxxP+jds9RFXq27Lt7cqVC3PG1fu5fBTenXk0Hbh3rWRkRCg1mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(2906002)(76116006)(91956017)(8676002)(6916009)(66946007)(26005)(31696002)(4326008)(6486002)(186003)(36756003)(71200400001)(508600001)(966005)(2616005)(6512007)(66446008)(38100700002)(66476007)(31686004)(66556008)(53546011)(6506007)(54906003)(316002)(5660300002)(64756008)(38070700005)(86362001)(83380400001)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzRoYVdibGpBaWgvWVp3SnBzSXMvU2dGQm8xa3oxa3hxdWIxQkZlanJSQm9z?=
 =?utf-8?B?b3RoMW56N3FOdmVnd3lhK0lDZ0FUT1hkMHEvWXdGaVNRU0hBMDd1RllJcDdq?=
 =?utf-8?B?cnhvZXptVktPdVo5eDlRbTdFUVdwc3c0djJ4bkZFcnpYYi9ISjdiK3JWR29s?=
 =?utf-8?B?UTh5NVVDOGxyU0g3bW1KNko2VURQKzBabUZYRDJvcUpTR1ZMazVxRXhrN0p0?=
 =?utf-8?B?blJCbHFFNXVSb2o3K2U2bUZ6MVVCNU9UZllEVjcyeE5ROVpvMXV5eUxqSnFt?=
 =?utf-8?B?WXYrdFAwNFp6VEtlZ3NuYUJ1QmVic3Bzc1NNaGQyTitMMFBwUENDZGlTbXR0?=
 =?utf-8?B?RDRFZFMzWENjY2NoZm5KZjBUYjZ4VnZycWlBSU1aNEE3Q3daQVVJcHNGNUx1?=
 =?utf-8?B?UHpqTVAvdmV3eFR3Ri84TWtCbW9FQVd1c0FNMDdocTd0YnRGSnpacVhSZnly?=
 =?utf-8?B?V3lsTXg3ekVQYkgxSmVBaUlBRXBKb3VUUXVacWdZeVBVTFNzQlNhVWF6NXFP?=
 =?utf-8?B?dmhoWVczT1JEcWxNUTVOSWk1TUM0NEQ5b2M4T1VqVUIzeUxCRWx2MHdOMFpw?=
 =?utf-8?B?ejE4cE92cndEYkgrMmZqSC94bGRxTTd3S2taMFJha3drME9Qd1FUeGdUUTdO?=
 =?utf-8?B?eTIrWUtOYkNoVTFLeWNYYmdhcWI5dEJjd0pNME42cHJ3OTZLcGFWZ1dRdGlF?=
 =?utf-8?B?OWpoVHlFc3A0bjU0L3JPdWk4V3ZQeDJBU2VkRlhiNHQrQ0tDbUxlVWl2d1FS?=
 =?utf-8?B?Vk9UM1dON01mTjRiYmZUS1BkaXpzUXpJdHRFWThuKzZGSkRxQjAxcUgxdlBO?=
 =?utf-8?B?VTNyTDFCV2llajVNTVU4OWxMWmVUR200WVpBaUt2akpIQzhKa05DZEQrL3VK?=
 =?utf-8?B?SVVNNzdmdWsyT0l5NmlsRDlPcHVhR1prMjY1VDVjZDM2eWxDbFVkWnRJUGtW?=
 =?utf-8?B?WDhoUkVUZnZONUZHTGVNR3ZORE5nM3dnRHVBSWUyVkNSMWt5Uk4rNFhSRjls?=
 =?utf-8?B?cW5IQzVsM1lSaS93OUtHcEMvSG1UcFM5UDg4Rm5qYVRUbUFnSXRJTGRkR0ti?=
 =?utf-8?B?VXZ2aTkvWG1QQ0N1SVJXandYVitGR0F1eXNBR1BmSXV2MHVlRFhhcTZSOFZW?=
 =?utf-8?B?ZXBTRVJKUnZTSU9uRXl1eFhSRXc0N1l5VFo3ZUxoWHdadm1rT2syTm5DOVI4?=
 =?utf-8?B?d3hoNXNYbnk3bWNmaTJGWUpkK2tKdndBazlrc3RzSE9RT1ZRWGV1Z1BEMWpt?=
 =?utf-8?B?R0JRejJTY3liTW5IUlZMV2plaVgxelVyb05Fa0VzWlloclJHRHppL1Q0MVhx?=
 =?utf-8?B?ZUZpeVVzTTFrZW9iQVhCMXNucHRMWFBhZWNLMkcyTWFNYjkvRmwvQ2RrQkgy?=
 =?utf-8?B?ZFo5UXgvbWlSQUxNZWl0NnUyN01ta0Y2SW9ZcmVhbUwvRDE4dWJwWTRzTzRi?=
 =?utf-8?B?K2ozMW1aekwrY3RVQ2hkLzZVZDlPMHFzZXBSM2JEQ3VXbTZBeXIvQkd5RVNU?=
 =?utf-8?B?RlpaajgvNnRaVnEveExOWk9kTW40YWtjU1V3TlV0OU5JZnJyVFlBQ1NsRlNG?=
 =?utf-8?B?Y0RGNFRBK0x2bDE4cDk1N3JSQ2h2c1owZ3B6Q3NYUFpGTDNaQkpQdk4ybXAz?=
 =?utf-8?B?UExtZFB1R3dnQjJHYzYwL29zK0ZvQzBsT0FmV3ZKYjlJNEFmcjFtTkFPVmdR?=
 =?utf-8?B?ODJhQml3anpjVnJGa3BzeENsVHVHdkxSZTd3aWVtOTBpRDFGN3JQWlViSXhT?=
 =?utf-8?B?T0tGUUU0YSt0SDArQzlEcVFHckEyMFlDZEJ6cXhXVXc4QnlIZ1FlNjJvbzNK?=
 =?utf-8?B?aTExRmc5Mkl2WVoxOUtYbG1qa0ZzNFljYWpYR0VDYnQxYjV4d2tOeDk4Y0hE?=
 =?utf-8?B?TzV5Z0liTitqNzBacEsyQWVjNjRUbSswbHRHeGNJN1RlbVZwVEd5cUJSODkv?=
 =?utf-8?B?OXhEQTFsaVQ2Q1V5cXcwaDBFVWptdmVqWFJudjdLeVMxZklsUytOQ25CZy9P?=
 =?utf-8?B?RUlqR1VHYUk5T0IxRDlicXNXb0pDT0lHWk9xZ2xvZ0Joa09jM3JrdVFzaTNi?=
 =?utf-8?B?ZUNBRm1idG51RHlXM2tMZGR2MnJ1VDY3WXBYN0kvOGxPbENDRnczWGI4bVkz?=
 =?utf-8?B?QlJlRFMzRy8waWpzVElaY253SXVoZEoxbE85QWlDTVlSQkJmaFFiZlY3WXUz?=
 =?utf-8?B?NGg4MXI4T3JlYWdRWm9uWk1RcGhDL2NTMEM2NnVBOUVCNG1wdGNrWjh5MnVR?=
 =?utf-8?B?QVZNaTQrM1ZGbmNBRVF2VjRISVlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8969F4552E4514FAC3264A234E1C07D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b9cf7c-5d69-4c7d-4ae2-08d9bb391a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 17:26:57.6591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qEzYyWd1M0fVVAerOE+Dp+b5lOhOIh4XYagjjO35Bd7unzuAvkdbPt5EzoPO5nlnIu/qjYzEihldt68u1qPCIuAGW1lnAbTHMej5METcKsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2959
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYiwNCg0KT24gMTIvOS8yMSA3OjEwIFBNLCBSb2IgSGVycmluZyB3cm90ZToNCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIDA5IERlYyAyMDIx
IDE0OjI5OjM4ICswMjAwLCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPj4gQ29udmVydCB0aGUgQXRt
ZWwgUXVhZFNQSSBjb250cm9sbGVyIERldmljZSBUcmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbg0K
Pj4gdG8ganNvbi1zY2hlbWEuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8
dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgLi4uL2JpbmRpbmdzL3Nw
aS9hdG1lbCxxdWFkc3BpLnlhbWwgICAgICAgICAgIHwgODcgKysrKysrKysrKysrKysrKysrKw0K
Pj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1lbC1xdWFkc3BpLnR4dCB8IDM3IC0t
LS0tLS0tDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA4NyBpbnNlcnRpb25zKCspLCAzNyBkZWxldGlv
bnMoLSkNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NwaS9hdG1lbCxxdWFkc3BpLnlhbWwNCj4+ICBkZWxldGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1lbC1xdWFkc3BpLnR4dA0KPj4N
Cj4gDQo+IFJ1bm5pbmcgJ21ha2UgZHRic19jaGVjaycgd2l0aCB0aGUgc2NoZW1hIGluIHRoaXMg
cGF0Y2ggZ2l2ZXMgdGhlDQo+IGZvbGxvd2luZyB3YXJuaW5ncy4gQ29uc2lkZXIgaWYgdGhleSBh
cmUgZXhwZWN0ZWQgb3IgdGhlIHNjaGVtYSBpcw0KPiBpbmNvcnJlY3QuIFRoZXNlIG1heSBub3Qg
YmUgbmV3IHdhcm5pbmdzLg0KPiANCj4gTm90ZSB0aGF0IGl0IGlzIG5vdCB5ZXQgYSByZXF1aXJl
bWVudCB0byBoYXZlIDAgd2FybmluZ3MgZm9yIGR0YnNfY2hlY2suDQo+IFRoaXMgd2lsbCBjaGFu
Z2UgaW4gdGhlIGZ1dHVyZS4NCj4gDQo+IEZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBoZXJlOiBodHRw
czovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzE1NjU3MzQNCj4gDQo+IA0KPiBzcGlAZjAw
MjQwMDA6ICdjbG9jay1uYW1lcycgaXMgYSByZXF1aXJlZCBwcm9wZXJ0eQ0KPiAgICAgICAgIGFy
Y2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMjdfc29tMV9lay5kdC55YW1sDQo+ICAgICAgICAg
YXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQyN193bHNvbTFfZWsuZHQueWFtbA0KPiANCg0K
VGhhbmtzLCBJIHdhcyBhd2FyZSBvZiB0aGF0LiBJIHNwZWNpZmllZCBpbiB0aGUgY292ZXIgbGV0
dGVyIHRoYXQgdGhlc2UgYXJlDQpmaXhlZCB3aXRoIHRoZSBmb2xsb3dpbmcgcGF0Y2g6DQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjExMjA5MTAyNTQyLjI1NDE1My0xLXR1ZG9yLmFt
YmFydXNAbWljcm9jaGlwLmNvbS8NCg0KQ2hlZXJzLA0KdGENCg==
