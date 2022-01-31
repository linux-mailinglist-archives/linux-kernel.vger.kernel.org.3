Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0374A3E06
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 07:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357838AbiAaG7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 01:59:19 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:22511 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357820AbiAaG7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 01:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643612355; x=1675148355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ewBCsxFsd8fFkzv/ulWWJ8h9q0mecz7KTuknf3I0FaI=;
  b=KYnCW8k05Psds3dgutZd9mP5+5K+Eew1882ZXfAMEdaNFYg8py17T67M
   HjE1ANwTEfE521U2rTQ1x/zYlKp4t9WXbHVvju+qua7vQSgiTimZToNem
   0PFBbrSvC2cY2ELpXBWBV2nndT2zCqBz7cYzj05duOzuKIeMAtGjACvUM
   Ya/DHEgImSKL7PDC6C77OenzjnjvdI65G9B3LLwb5FmhJ5LkYZu3JBNet
   VyY9pryhpVkxbATwj06UxIc/6pXz1yYbtHNi+TLM42XtaYxWARBTl971f
   sd7hhxYpqJPMEwk55+jQisVs8/AkMnBPZke+5Vlr6/uMlwRUdjjT76XLl
   Q==;
IronPort-SDR: A1zBDsW66dlhTuw0BpJm1SYDMpMZ7gUi1UjdfIlBYJCxwfCVEtMl3yvqFxgAluzdu+c2KIRXRr
 ShX9K1PBkcQ2BiC89iRo4HTnjodeNpOHKFWC8iqFaGl5yvNgvUj5z0YrwKH40ttmO3IrI9z5YB
 xkXGZm3ejTqkU+3s5/baOyrf6p36EnYMUD+qxg+9UEwO4cp3agSEKmC9M2mihKVQlQ1cLN4YO8
 zGt5GNd25QTvgEHolOoS/+pbXYAvA75JcI4IV4zqQfuAcvtE1xZGehXMSIIdkFfQGphyTtoLZK
 hB0eDzrWTT6h0aBwR3Hl4Vzd
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="151943928"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2022 23:59:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 30 Jan 2022 23:59:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 30 Jan 2022 23:59:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itrrE1MOzYmXMwu7H1POVhiYpVPqACGp3p/46SjeOCh9DEixF+OKcM+6HNTgCgEA12alVuaRZQZ4KMaqppCac/3PjxMjpyDS+Tlp9H6oIHa3defgoOUUCccuse8SjdQX91SYl0tAJCP4U9wg46eSVNdqxXUdVNqv5wYont0yolxwQlgzkwZHP4s9b3KTXulpjkFudSh4NyC3NOENoNuNvCOUt1A27WJ5jE91cIthJ7lgavgOqho6U7BKA1n950k1BK5QoNmL+G4cMmQ6HpCz2eKodcLQ/JJseAZHpuSUKMTO3EafcIkZ9N9o8DkyKVuMGiXjchW7w5o1/qonYq4/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewBCsxFsd8fFkzv/ulWWJ8h9q0mecz7KTuknf3I0FaI=;
 b=QIg+Q52CkG0eGB6QnMBkmbEm+UDbtmRpPSx66M7TV0woFrJzgOWmi5pPE3mMJaBG1B3L4s6vd0SIeLKfaW8mv6yvGtiu2xhchA1+dP6udb9k4hANVPxcCjcjF0jxQuM21G6BAtYLkroyHJZ+xXHCp5ZQwJrhY6vAorG+8vRIWMzf+KoZfiwgItRuPpdzP+SQ+AI4UZxpDkZMRE987C6RVKSHAlPvBahjLiL9VfF5937675D6yl5IMKlTpIpGBa5PnPPq/22Xt2pGH2mGiES2BcQTiYd72AFKCEI51iWZB4zHQ9wGLSzhu6ZOPHn+s5WMcsvxsRnGtkwaeKEyGPA2uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewBCsxFsd8fFkzv/ulWWJ8h9q0mecz7KTuknf3I0FaI=;
 b=nbJj0KX7vXbiQLU1ezVBfTIsFt3r/r/v9QOybiIxrQGbxOb1wEC5lg1MQ2mIFKXX6qol5VUca1tCXCvCOZBI1ZiP1IFVyB3KaLmpseRQp0W6gY7C1guIv+5kuoLLj2uX+R4RsHEK1Vh2XFwt/prCE0bQMcb5xvBuUjFMlULHkd4=
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by MN2PR11MB4478.namprd11.prod.outlook.com (2603:10b6:208:179::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Mon, 31 Jan
 2022 06:59:02 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::a588:b481:2154:c45e]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::a588:b481:2154:c45e%5]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 06:59:02 +0000
From:   <Ludovic.Desroches@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <linux-crypto@vger.kernel.org>,
        <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: rng: atmel,at91-trng: update maintainers
 entry
Thread-Topic: [PATCH] dt-bindings: rng: atmel,at91-trng: update maintainers
 entry
Thread-Index: AQHYFehOYK8eoSGCXkO/YdROoSAVYqx8tD0A
Date:   Mon, 31 Jan 2022 06:59:02 +0000
Message-ID: <aee5a70d-fcc1-f7a8-75f4-b82905f7883e@microchip.com>
References: <d84760e0b81c338e01f7856e1ce3c5b600b08f23.1643553619.git.nicolas.ferre@microchip.com>
In-Reply-To: <d84760e0b81c338e01f7856e1ce3c5b600b08f23.1643553619.git.nicolas.ferre@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6afcff53-0978-4261-cbe4-08d9e4872a0b
x-ms-traffictypediagnostic: MN2PR11MB4478:EE_
x-microsoft-antispam-prvs: <MN2PR11MB4478D95AD7CD32BE1CDA5C9BEF259@MN2PR11MB4478.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 03nwbca+zqf4vUJUocTkjd5zUmg1N/ftjldDiFI2ymiqpHTplcndjG6PJD13i5dM/mrW2tj9DwfRnZjlXwd9bGyrUcmNELlFENPGzDu9dv/m2AfVcnhZIJQqXeLSjb8qHQb6mK3nVxB/Nl410W0OyFAd1v72NN5BySnlf1EWftdu9pS0y75RekuT0VYmGtFx6VaYHDJfN4y7ybaSbi2OiVIdcxva8CCRk0eravPhivyOPUXDjIH/gExRoTbIB1gBWECyFuDXmDGcqmDEyshUO8gcudDWR7gZnIOlTJbOQUz0Jxo6fuMfzMX0p5p610FL13aOFMKZOl3AQUGM3NIokjaPs/Wqrtx/d6QHTzrCMzDbNv8f+x9f+glaMwgwsmPqNFfJUvIcAptQDdkdSnphOMKqnvmzUQoS7Z0SS7+kG3UOZbWp0XiHS5c6gEocQl8MRSAO7Cjhf+kUOmE1ZgUbUqeHulWQ2h+LWOBBSXan1WxU8uN5W++IinPZBurkKGoZhoyTVcR1vTvPcrUup8NwLVVhsbrC25N6RKUEf1bvl1GdgVD+Ij4RRADs5cRnVOmOY4MapCeHO6t41Ih7ndM/rbhiL9fjJKwpqS8tWLE0dyOyGz6ESpYwPmfBagIKL37/tBwUnAvv450ww52kLRcXOym8gl5iMishOjYY4LFkIqZCA1vHgYLAo+7z7AZaV4WiwIcslhGHgbWF9efclwonS1wMCT+ItShRv9+Td2kpTX0/rnOcPGSkSn1loTO7ucLDz+t4aXUfP8EWQtqV/E0ujl4k1zQc+xBz5pL17rPUE6ZPmcLypkttYVJ0ky0cgTVPYim14CChabVOCJNXdajG9qh4GcOy9Xb4rTbucVecmPw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(54906003)(36756003)(508600001)(110136005)(71200400001)(31686004)(316002)(76116006)(91956017)(966005)(2616005)(6486002)(186003)(26005)(8676002)(8936002)(5660300002)(53546011)(38070700005)(2906002)(4326008)(6512007)(122000001)(15650500001)(6506007)(38100700002)(31696002)(86362001)(64756008)(66556008)(66476007)(66446008)(66946007)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWdkZEQ3MStHaGdVNnhvWE05REthSGtEMnBNNkFwNkNoSVRjTjl6bG5WREYr?=
 =?utf-8?B?UVp2RDJlK3BQVC8yRGVpZ3ZWbDBTNEd1R2JwNUhlSitLQk1jajJpaDVPZ0Za?=
 =?utf-8?B?VFFlSDdBY2hQaE41dnoyVXg0bjhBQkpmN08wV0F3ZWFjZWJKSmw3UUxSVnFa?=
 =?utf-8?B?ZEtHdE1IL3hRenpMTmM3cFZNaEZnVVZvYWNOT2NIZENidkFQY1B0azY1c2tv?=
 =?utf-8?B?RUIwa2VmWGZOZ25IM2UvZDdmQWw4SnBKc2pCTFd3akRTa2NqQUVEa3cwNGZ6?=
 =?utf-8?B?MHo3UXoySnUrUkFZa0w0WThScjAvY2tlTjV2NWxNODI0R1ZjbDBMNGV2elFz?=
 =?utf-8?B?UjBJQTZLUkw1ZG11bXZQNTFnZjV5MlpLMXNtZjFsU3FuZmtHK3NQQlFaRzRk?=
 =?utf-8?B?V3VGL3R0dDFpS01nS3lZdXZ1TG1kcmx5SFdEaGQxOUQ2bXNQWnlDOE44dWgz?=
 =?utf-8?B?SStNZjhLY1NsSTRIcjVNcmJTWXBuRWl4d2pCTkd0WTZKR2NueGJtQXF5THlK?=
 =?utf-8?B?WHd0OW1SQ1h4aFRabHMrRHBrNEVyQ3JWUU9xZGJXdU1tZSs5QjdacFB0a1I2?=
 =?utf-8?B?SWVCT0dmSE9VRThRTnlYTlR2Z3J3c1FLMkQ0dFZXcDgwRDJPYWsxbkN4RHNC?=
 =?utf-8?B?ZnlCY2Z1dnhvWnZBOXdZK3JsM0xNS3NRdTAzOXd3V2hubXZURmlrWnNLZXRW?=
 =?utf-8?B?ZytXaHFUTUJDTzcvRyt2a2dZb2JpM3VkN016SGZyeW0zVDBzaXJRNnF0U0dz?=
 =?utf-8?B?US9kRTIrWmRZUjZQZXhnMmhZK0liUjZ1eVlvZXNxUVNHRGVUYW9Fc1AvZEI3?=
 =?utf-8?B?TEY4YnFEL085SGU2N1RmdHN6enNBQzVSZXZtRDlEWlZFNkxGeHdJVWFDN0wr?=
 =?utf-8?B?OUtBdmRJV0oxeitROThlR3kzNHVnT0tpME4vemZzUlU3T05SaS9CQ2RMUlND?=
 =?utf-8?B?bGRoQ1phajVZZDFkemtpN2p5cVNmM1V4dUs1anhrTWZuTXFIRUwxZHRoSng3?=
 =?utf-8?B?ZHRPZVZlNHcyRVVjWjFxTFZvRjVXTTlGajZHVDNPdDNUSTdtV0JqQnYrekRu?=
 =?utf-8?B?QkxuUmFqTXFNRFA1T3JPU2Y2dUI3RkVCWE14QnhZZWxoNVNyVlFnRUgySUZR?=
 =?utf-8?B?WHdFU0l6ZVhhb29ZeFF4WW5maDFERDJlQ0ZaOXpGUHJmSGRKbmpSYUh5SVA5?=
 =?utf-8?B?dXZFQWNad3BEN2Rtb2k4ZEsxZ1E5TlNRbC9nbmI4TFlDTmVENmhUT0ltaXZO?=
 =?utf-8?B?dStJMUpBYkhsRExxSEJVVzZkR2VqcXAwRk9UR0MrdExINjdPOXIwVTdVanpH?=
 =?utf-8?B?Tks4anpnU3hUczB4YWN3TFVibDhQaWJnYUJhS0JGTEJPQkVSaGQ0Rk4xWnox?=
 =?utf-8?B?cG9JdC9adzgvMWtWc3F3WXVVOXBKUnAvQUdDaXU3UkdBYWFJZ0FTa0hIb2xN?=
 =?utf-8?B?MVdtSmdUSE94T2t4Qy92Vk5kS1lKMjJqbjk5OUpsTjFoU0t6UlEwek9GT0Jx?=
 =?utf-8?B?RzVCdzlHZ1Z2emQ3dXZQRnBWWkVHOUdSMlJZTlhoU2dRbHZuSG81aW9GY0V0?=
 =?utf-8?B?VWZoc2IvLy9hbEFNYURGbDJhUFZrTzdWeCtXTzk0QkpqLzhMSDVVWHZraWhr?=
 =?utf-8?B?bXF4UnNhak5rWDMycUMvLzhVYmFKT245bkJqN2xlVDZFbUVQYUs1cmdnTVlo?=
 =?utf-8?B?NjczU3hHbWtPS2RvNkRSci96cThsbmJoY0xac20rMjE3T0JlMGlPSXVmOGo1?=
 =?utf-8?B?N245amFvM24zVUlmL0xOR1hsemVKSkxNVFdFTndiTktkVE5SQytBclB5TDZJ?=
 =?utf-8?B?TFlPTklRQUxHM0RmYytpQ0tEVVZxbXl5ZE5VOTJDQVlielVmUkVjNzZlb2Jz?=
 =?utf-8?B?WXpXdkRObWthZ1Z1QTRNeFhnU2NXdDFSMm1zRG9YMGY2Tk9yNHo3U3VkTkZ1?=
 =?utf-8?B?UnRPeTgwM3c2cjJXK3JrZmphTDRJcnZ3amdabjI0SGc4WmJVQVZhdXkwTmdj?=
 =?utf-8?B?SUVYTEw4ZnNua3l1NWdOTFIxQlA0RjdxWFhpZ0psemV5NDhGQUx0OU1RRENm?=
 =?utf-8?B?QjRQUEtpYzRsQkY1NXMrTlc0anZwZGlmS1lkUWlxWWZNZ1R6U1B5eWN5bllW?=
 =?utf-8?B?TnVTTFhzTXlFd2tkYThtVi9FZG8zeXFiUzdkMDJlWnR5QURHVUpRY3A2UFY0?=
 =?utf-8?B?aGhXUURCdC90OXhMajgvR3duRFVIalJ4WmROVUgxeS8wWlowaUZrR1VYR2F3?=
 =?utf-8?B?R3JKNitQbXJhQzJHZUZEa0UraFN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF112F9E69C98B4BBEFB65FBCB0CE9B5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afcff53-0978-4261-cbe4-08d9e4872a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 06:59:02.5832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtojinoJqfH5Rqx0FxeAO82YEMuRPAuU8GhlOa+by/URNothNwwXHNmS/8Y0fnzu08LvxMOKarKWVnDfRFLum2UXcDyQSviMDNsyT35aHeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4478
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8zMC8yMDIyIDM6NDcgUE0sIG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbSB3cm90ZToN
Cj4gRnJvbTogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KPiAN
Cj4gVXBkYXRlIGFjY29yZGluZyB0byBuZXcgTUFJTlRBSU5FUlMgZW50cnkuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQoN
CkFja2VkLWJ5OiBMdWRvdmljIERlc3JvY2hlcyA8bHVkb3ZpYy5kZXNyb2NoZXNAbWljcm9jaGlw
LmNvbT4NCg0KPiAtLS0NCj4gSGksDQo+IA0KPiBQYXRjaCBmb3IgbmV3IE1BSU5UQUlORVJTIGVu
dHJ5IGlzIGhlcmU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFybS1rZXJuZWwv
MjM4MTlkOGJhYTYzNTgxNWQwODkzOTU1MTk3NTYxZmU0ZjA0NGQ1ZS4xNjQzNTUzNTAxLmdpdC5u
aWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20vDQo+IA0KPiBSZWdhcmRzLA0KPiAgICBOaWNvbGFz
DQo+IA0KPiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ybmcvYXRtZWwsYXQ5
MS10cm5nLnlhbWwgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3JuZy9hdG1lbCxhdDkxLXRybmcueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9ybmcvYXRtZWwsYXQ5MS10cm5nLnlhbWwNCj4gaW5kZXggYzE1Mjc2Mzdl
Yjc0Li4zY2U0NTQ1NmQ4NjcgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9ybmcvYXRtZWwsYXQ5MS10cm5nLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JuZy9hdG1lbCxhdDkxLXRybmcueWFtbA0KPiBAQCAtOSw3
ICs5LDcgQEAgdGl0bGU6IEF0bWVsIEFUOTEgVHJ1ZSBSYW5kb20gTnVtYmVyIEdlbmVyYXRvcg0K
PiAgIG1haW50YWluZXJzOg0KPiAgICAgLSBOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1p
Y3JvY2hpcC5jb20+DQo+ICAgICAtIEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4YW5kcmUuYmVsbG9u
aUBib290bGluLmNvbT4NCj4gLSAgLSBMdWRvdmljIERlc3JvY2hlcyA8bHVkb3ZpYy5kZXNyb2No
ZXNAbWljcm9jaGlwLmNvbT4NCj4gKyAgLSBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFA
bWljcm9jaGlwLmNvbT4NCj4gICANCj4gICBwcm9wZXJ0aWVzOg0KPiAgICAgY29tcGF0aWJsZToN
Cg0K
