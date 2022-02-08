Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFBD4AD015
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 05:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244109AbiBHEFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 23:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240420AbiBHEE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:04:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B66C0401DC;
        Mon,  7 Feb 2022 20:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644293094; x=1675829094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ccxO91GsQPHoA1ooI9+tCFVWi9QqUJybLeTuAA+P5LY=;
  b=oXCDOwvQAN3efQUNiufcbB1W1i/JZ/QVWSsFsSmfoVEgNmlM5WV76dtW
   7ONyiwr/otgf/4JxY1c6mlHoz/o2PoTpb2JGroOzz5sa7ugDRJRC3Q2BG
   8aI0aL644ChZJhCCmQSDToNOE+qlCIvmnQ682ubcHJB6xK0wkXIB8VcO0
   6Z6PFdCkFYdlwL3J/JRN86O50hcqx17Zg2/5qBJDJ98wrN61eBytE304Y
   7ylPX9GqEe+al2JZ59XsNEe9VTeIh4vN2WJfDgqfTvxRtB526hfqdA51H
   /XURWp+nJJLx+AXa2v+qEX0yi4qVcMTT4lBP40YvyTvg8MT/OUni4SrAV
   g==;
IronPort-SDR: 7fn3O7wuU0+fYIK8VaPP6/hkXxw8V+q7NxOrC0RrlTucm3LZbkc1htc7zu+rre3I4OCLQ72OwQ
 jFEo3n04hR4d1kiiEdu/jZ+QQYYhLYSREtFe8R1F1FpXL+jh/vDzEX3zdIXavOJQv+cc8VDfvJ
 bHH4veOqdn9QeEk+ExOpRTQXIH6JijGkgrJsCAJ44sJVaw+TgZ4FNslUr8iCNOqJegwFA2ITFP
 yJEe9B4g5XKHI4EHjv7nFLnOM2P2OGgYdZuUdbNj8dgd1GL/6dYiljLBzWHKs1+qKqFRSa5bF7
 u2EUZoFztBx2EjDDXJX26HOT
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="152262166"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Feb 2022 21:04:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Feb 2022 21:04:52 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 7 Feb 2022 21:04:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZj4XW4JTVouU38pk/WASFlKhD1lzVXrwHCvVVj+OSMTZ2iGyGDkAnOPKC1hpAi3nAd1410DF82ES0ew8hXNORDil3ajL0jhdGShqDBYe1W1lhiX72JIcPly78RUcwxxWWLiY+x4tgpMAGoWDtym2eM5rVYkVgCiI7BWmUHtTth+257tN7APtIkvSJgdSiQ/Mntc39xHcpfCxbbi9MItGXSz/L+PT5zk+CRbMmGgxXr4wQm1TUTANC+9nt23d9TFd3eJkEN3DQ7c6EG9Mzz3Ph2OUk/WrWl1DPMaoZoixUvgRjTpyMJSE3g6J7IPZPWnHoRqbKX/sWdWPUBDO6O7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccxO91GsQPHoA1ooI9+tCFVWi9QqUJybLeTuAA+P5LY=;
 b=dQG2WLBbKNUWw9Y9f5uY6HoO2qqDIzBogUFY2OhbZiriJ04Bbq/WgB0+8C36wEk+HYvWL26lqYIxIPbVKoiPZTMqOueIXThY06X9sRek4lYqvwY7NV0vMgJFUx1Eq8V9y3oHmAj+5y5n97IAHXCqdm5BIu/s6NE8aboaO1d5BC1/6Ed06mRP8cEMfZbrooMQHA1Sgq/9HHxj6q5o4UbWBN0yJeYktTDPUdtoIari0eqJnYex7iYjEUaQJhaZDt1Km7sa7kxgrZ0gonBJtHpSvVpn8d+i14EN9kxXRccU7ezf42uDvLkF80w3tGJaPESNUE2gseAmlr2vwJTEy3HYrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccxO91GsQPHoA1ooI9+tCFVWi9QqUJybLeTuAA+P5LY=;
 b=qPOcY7QECIbYbqSHYZkIdY0AiDMoj5uYlOKy+mXE4/qWbbMPiIYoTHO47uT7LpDDPC0MmpZ2lcaPmmu0nuUQbhjMxt3KeFIh6k1eZrWGsIhSfAPbQwqTnryu9MmFlE4fEV1I3cxLxTEkPuWoeKw/Vk/zLNrKb0gspPnrcN5v2FY=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by MN2PR11MB3951.namprd11.prod.outlook.com (2603:10b6:208:13b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 04:04:38 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%4]) with mapi id 15.20.4951.018; Tue, 8 Feb 2022
 04:04:38 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <herbert@gondor.apana.org.au>,
        <robh+dt@kernel.org>
CC:     <davem@davemloft.net>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: crypto: Convert Atmel TDES to yaml
Thread-Topic: [PATCH 2/3] dt-bindings: crypto: Convert Atmel TDES to yaml
Thread-Index: AQHYHKD9BNP6l8jrfUC2M8gpuOVb8w==
Date:   Tue, 8 Feb 2022 04:04:38 +0000
Message-ID: <6aa72f5a-e9c2-cd8e-ab26-fc8b4ad5cc25@microchip.com>
References: <20220207032405.70733-1-tudor.ambarus@microchip.com>
 <20220207032405.70733-3-tudor.ambarus@microchip.com>
 <c7e160b0-16fb-79ca-c291-05571bbe8341@canonical.com>
In-Reply-To: <c7e160b0-16fb-79ca-c291-05571bbe8341@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecef05ea-f137-4d93-b677-08d9eab82056
x-ms-traffictypediagnostic: MN2PR11MB3951:EE_
x-microsoft-antispam-prvs: <MN2PR11MB3951AE8C85D84674282FA2CFF02D9@MN2PR11MB3951.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fgGKRHGzlSs+riXha0ArdwtHU2D9isdcKtvxXA0EsL52NynOTfo8FvddgW8/sevoNUk2ziYsJU5fOxt6egfGV/U+qphlbPG2QtvDIS73mEny1vHfea+etJuBd/YNQhWe2MyEH0GJEo2CRrAenVK1f7Yk6rAS8S4ya9ebsbOxB039ouf5MCvXc2fnJKVWgtczL0zC8JQuH+aXyGMUSsM6WaZD0KDwvs5gjT0kYk120+d1xtjzNGcixQCfxBxQmL2LA///L1rcQ0X9wGQIvwBDGlyhpjIsHlb+t83oo/fLqLE3ds+PsW98lA+YEZd2UEUcEcC2JIJ9zwoeEwM/JsrmB/OGMGg+fvjRaYCvGV9Dk1o80BU5JhtcznwHXwhs5BRtFh6Yu4Vx658OpNUiamhTdiniKqV+ve44gHpve5vRysHBveAbtKLK8AILa10fIYENnyf+ASG7Yg4bXk5fN3OkWY8eiDgtJZz5r0xHgsi94LmD1pbGIfXNtopK9rtqGTCm2Zgfnj57rjeVFTpTqbLbscQyoKGPapWrKOhPUeU3QGPA4SB5dBPhlMdZK+ATPxcp/FaB0+vlg1GT+lojxxxnHceJwriHsgjSh3el6nFBr02EMA3rlqws8igUIMbmGoEcPjIvMxNc12X4oSG/Sf5+cAIZEFBt/NK9RZ4aH3yTzw6+ZkdTOVCo7NY3HANN0hx8h6oqMDt6aAg1CQNay2h56hB/YCoWXpmLsZYPxyP04P+uohAAcRUvWEfjKm54Q2DsLAOlX3lspHQgb90WKOU+NuPW+nvJqeQdpaFIrf1934Lvn9u2P6IxSAvvVmL4GDZkBjTXKkTVYBu+onoIvD/u3TVKVR0lqL/YfqfOiE3GBLDQzygu7vaHMhbrpGH2R4kYOQbvnho2jAm0oGPiDTE2dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(54906003)(508600001)(36756003)(6512007)(38100700002)(966005)(2906002)(31696002)(110136005)(26005)(66946007)(83380400001)(31686004)(38070700005)(5660300002)(91956017)(122000001)(66446008)(8936002)(4326008)(8676002)(2616005)(66556008)(71200400001)(6486002)(64756008)(53546011)(86362001)(76116006)(66476007)(186003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXc2M2dSRDlGSDRMV3dnMkFvOWRRSis0K2ZNTTVyMUJ6SDNjWGY5K1RZR3Qv?=
 =?utf-8?B?dk5RRFlncVVFeEQ0L1o5UmFTNWpvbm9vQjRQNWZneVdNajVSRlVWdmhKSWZO?=
 =?utf-8?B?UGJIQzhoUGd1VHZSTHRvdEQva1UxTnpWVEFRaWd6VHBqbHFiMk1KdUplMFlS?=
 =?utf-8?B?akdjSytBN2FWZTVGOSs3alJBOVR3ZFlpNHdYcm1sbklZSEh5QnZQY213TGNr?=
 =?utf-8?B?VXFTL2Z4bXp5OExiY1d1OVh1UkZMcm03ai9rWklLS1dFdFBjUVh5NDlhbkJN?=
 =?utf-8?B?NGkvd3craDFLTXlWbTBVMzYxNDZmQkp1WW9oUjBXa1Uwa2I1NExXN1Q4eHRu?=
 =?utf-8?B?L3dlTnA3VFVWTFBveFdtYkZ3RGJYSDdJRitqTyttN01SdXowdE9zd3lhVGR4?=
 =?utf-8?B?MktoTGc0WVRMOW1Sb3ZVa0ZOSU1WR1F2YWVQSy9XNlJycW9kUkFXTG9qNGlI?=
 =?utf-8?B?RGt2L1Y4MDFiM0Y2VGNhanZ6OGVpMXRyUVhrN1BrV2dxVnhqd1QzdkZHWkJM?=
 =?utf-8?B?Skt6QXhGWVl0OWpUS3FyT0hwcERBalk1ZzhKZzFzbG0zamhOMFpnRU81aHRQ?=
 =?utf-8?B?RFZlK3UwREtOUFZYOFNuQkQ0ZzdSaVAyMVlGbVI1VkR4QzI1bmF1eEJTMDFW?=
 =?utf-8?B?V3lRY0Rkellzb0lPckxqNzA2YmtkK3QzWVhUbUJHSVZJYmNMcTdjZ24vY0Zq?=
 =?utf-8?B?enlGUDhlRzkvZklXYXFWcWJtUFFFZTE1amVwTTg1Skc0UU0wOW52NWJwQ05W?=
 =?utf-8?B?QmxVVS9YS2JXZzBZd090bTVxZ1ArbHJTWEl2eStTc09qbkVrTG12TnhRNjhv?=
 =?utf-8?B?bHlBcnBkK2kwbkFkdjJkdnpFZTg3bktLNkw0NXp3S1dQdWNBeWhVYUJxdSs4?=
 =?utf-8?B?cENMNDRLaHZRdS9BTjVQd2k3Z0lyckRFeGxzMXNTUHdRbXJLbXJnNlIrb2Q5?=
 =?utf-8?B?cjNxS1BEUW5Cc3NzU0JBN25MbWNUc3hlNFlVeFZyTkEwQkx0am9mUVR4WFFQ?=
 =?utf-8?B?c0N5d3drejFOUWdxUk1qVXgzRXVEOHNDQkVvN3o0b0ZWeVluL2xFVGc3dU5y?=
 =?utf-8?B?SlQ5OWhFbnJXRExObkxVNVVPM2Z2YnBoQmtadlVvOFRIMFZLb3ZvMTllOFRQ?=
 =?utf-8?B?emo0Vy8wcE1xU0Vndm91c2tqRzNzYTkraDl3UmxyMDh3c3B0dG5YQkhpbjRp?=
 =?utf-8?B?c1RGczZ1YUJ1aDE4Ym9NMktTQjkyMlBpRWF4aTVhVTllbFNLRWJpZllCVW01?=
 =?utf-8?B?alcrK1IzUVpkOHRibFpPa21jZ3dzRTJ3RjhFVkRsZ0hMZnkvb05BM052M2kw?=
 =?utf-8?B?Q3JkaFFZeU9EWG5iWlBkdHpHMjJ5VkM2eTV4bkFhWWU2bFR5WDBxYlJPWTJr?=
 =?utf-8?B?bk1OOHpPeHBycjJNTzZtbG1wZ1ltTGRER043Nms0UVFyT0VURVRLazVIckw3?=
 =?utf-8?B?YmRGWmNvUzJLdG1CVDcwai9Nb2lCazAwTHM5MmtXQzQyMWl3eHBvY29mcFIw?=
 =?utf-8?B?TVQva3BpbzFrRDdkbUwxTzFqcDhyaitlK1NWa2tCVkdvS3NQSUZlcUZvQ0hN?=
 =?utf-8?B?WExZOFVTOVBIMTZ5RDJpUjUvZlhsN3NtZTVQSllwOUdiRnkvdWhOTnJETEZx?=
 =?utf-8?B?Q3I4REZRZ1U0cDZqUEdhc1J0QUVhZHdEZlF6cHVWbUhOZTN5TUZjSE9pZTJH?=
 =?utf-8?B?NGxOYXdJelVJdmNyWjNINGdzWXh4cFB3Zkh4T0JmWkdLS1NFc1E1d1hwNU0r?=
 =?utf-8?B?YVVVblUxa3J3RkQvZ1VWUVhRWDJNV3B3RHRTb0E3MUJNeU5UL2xmVkFVejJw?=
 =?utf-8?B?TWtMVkhlbGtWS2tUWHlEcnpQUGZJSmVOYnNMczl4ZW1JaVJKMGVVUkh3S1Jl?=
 =?utf-8?B?ZGQwNXEvWjZ1bW1aTW1DTVFyRFRwdUtML043ZmlxRUFYcGFiTmhpalZyM1Y2?=
 =?utf-8?B?bTY3eGRrS01DSGs2NXBLRHVBSS8xRkhDbUdZMWxIRUhucTYzSXAzTVYxbjZY?=
 =?utf-8?B?OWNMVjg1cFhmMnY0OGpxak02VDdxRFNSbjZKTi9ZYU1udnJUWTJ4NTFza3BE?=
 =?utf-8?B?RUNmWXY2NWwvcFdGVmVYZUluUjZRV3Y5TVZWVDdtZ1ZuODRWbXhUeTc4aHZT?=
 =?utf-8?B?RXpLcmZZa1ZkWHUrN0MrVldXV1A3a2s4ZjVwNjcvU1o2Rnp5dVVROElIQXJN?=
 =?utf-8?B?NXpWZ0tsU1BNd2I0VlYwelBSZDBnRXBBOGF6QWFsd3h1MUg2NTNWYXd2YXZh?=
 =?utf-8?B?V0dWYmFCbGZNeHNZVUo4c3plaE9BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E46D4D71B0AAF4F84D67CB7C75F97F3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecef05ea-f137-4d93-b677-08d9eab82056
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 04:04:38.6602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLPGXmpIawFqr5pUK2rSBktUvS0S6iHQXim9SzafZHL/ElK/ye4Pmkrn1tvj+AjKPrZ4WAafFE71d3oDUGEUUhRcRD9xPYE398/G8pJR+bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3951
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEtyenlzenRvZiwNCg0KT24gMi83LzIyIDE4OjA0LCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDA3LzAy
LzIwMjIgMDQ6MjQsIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+PiBDb252ZXJ0IEF0bWVsIFRERVMg
ZG9jdW1lbnRhdGlvbiB0byB5YW1sIGZvcm1hdC4gV2l0aCB0aGUgY29udmVyc2lvbiB0aGUNCj4+
IGNsb2NrIGFuZCBjbG9jay1uYW1lcyBwcm9wZXJ0aWVzIGFyZSBtYWRlIG1hbmRhdG9yeS4gVGhl
IGRyaXZlciByZXR1cm5zDQo+PiAtRUlOVkFMIGlmICJ0ZGVzX2NsayIgaXMgbm90IGZvdW5kLCBy
ZWZsZWN0IHRoYXQgaW4gdGhlIGJpbmRpbmdzIGFuZCBtYWtlDQo+PiB0aGUgY2xvY2sgYW5kIGNs
b2NrLW5hbWVzIHByb3BlcnRpZXMgbWFuZGF0b3J5LiBVcGRhdGUgdGhlIGV4YW1wbGUgdG8NCj4+
IGJldHRlciBkZXNjcmliZSBob3cgb25lIHNob3VsZCBkZWZpbmUgdGhlIGR0IG5vZGUuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAu
Y29tPg0KPj4gLS0tDQo+PiAgLi4uL2JpbmRpbmdzL2NyeXB0by9hdG1lbCx0ZGVzLnlhbWwgICAg
ICAgICAgIHwgNjMgKysrKysrKysrKysrKysrKysrKw0KPj4gIC4uLi9iaW5kaW5ncy9jcnlwdG8v
YXRtZWwtY3J5cHRvLnR4dCAgICAgICAgICB8IDIzIC0tLS0tLS0NCj4+ICAyIGZpbGVzIGNoYW5n
ZWQsIDYzIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3J5cHRvL2F0bWVsLHRkZXMu
eWFtbA0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvY3J5cHRvL2F0bWVsLHRkZXMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9jcnlwdG8vYXRtZWwsdGRlcy55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4g
aW5kZXggMDAwMDAwMDAwMDAwLi43ZWZhNWU0YWNhYTENCj4+IC0tLSAvZGV2L251bGwNCj4+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcnlwdG8vYXRtZWwsdGRlcy55
YW1sDQo+PiBAQCAtMCwwICsxLDYzIEBADQo+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vbmx5DQo+PiArJVlBTUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvc2NoZW1hcy9jcnlwdG8vYXRtZWwsdGRlcy55YW1sIw0KPj4gKyRzY2hlbWE6
IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4g
K3RpdGxlOiBBdG1lbCBUcmlwbGUgRGF0YSBFbmNyeXB0aW9uIFN0YW5kYXJkIChUREVTKSBIVyBj
cnlwdG9ncmFwaGljIGFjY2VsZXJhdG9yDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6DQo+PiArICAt
IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+ICsNCj4+ICtw
cm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgY29uc3Q6IGF0bWVsLGF0OTFz
YW05ZzQ2LXRkZXMNCj4+ICsNCj4gDQo+IFNhbWUgY29tbWVudHMgYXMgZm9yIHBhdGNoIDEgcGx1
cyBvbmUgbmV3IChhbHNvIGFwcGx5aW5nIHRvIHByZXZpb3VzDQo+IG9uZSkuIFlvdSBuYW1lZCB0
aGUgZmlsZSBxdWl0ZSBnZW5lcmljICJhdG1lbCx0ZGVzIiBvciAiYXRtZWwsYWVzIiwgYnV0DQo+
IHdoYXQgaWYgc29tZXRoaW5nIG5ld2VyIGNvbWVzIGZvciBhdDkxPyBNYXliZSBuYW1lIGl0IGlu
c3RlYWQNCj4gImF0bWVsLGF0OTFzYW05LWFlcyI/DQo+IA0KDQpGb3IgaGlzdG9yaWNhbCByZWFz
b25zLCB0aGUgYXRtZWwte2Flcyx0ZGVzLHNoYX0gZHJpdmVycyB1c2UgdGhlaXIgb3duDQpmaXhl
ZCBjb21wYXRpYmxlLiBUaGUgZGlmZmVyZW50aWF0aW9uIGJldHdlZW4gdGhlIHZlcnNpb25zIG9m
IHRoZSBzYW1lIElQDQphbmQgdGhlaXIgY2FwYWJpbGl0aWVzIGlzIGRvbmUgYXQgcnVuLXRpbWUs
IGJ5IGludGVycm9nYXRpbmcgYSB2ZXJzaW9uDQpyZWdpc3Rlci4gVGh1cyBJIGV4cGVjdCB0aGF0
IG5vIG5ldyBjb21wYXRpYmxlIHdpbGwgYmUgYWRkZWQgZm9yIG5laXRoZXIgb2YNCnRoZXNlIElQ
cy4NCg0KQ2hlZXJzLA0KdGENCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
