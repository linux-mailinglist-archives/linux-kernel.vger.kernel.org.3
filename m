Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103EB4B9BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbiBQJNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:13:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiBQJNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:13:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A6317CC51;
        Thu, 17 Feb 2022 01:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645089173; x=1676625173;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nJRfL+8FMvnieYjfbAne5+lj3Po7u5GLKgiFxS4CnyQ=;
  b=j7cqEOaKheWvUE1isu6lWEJABi9kq3TLg1Y889zvW4zJvsBVnNM/H723
   dIG3isSTuzaCHtNe0DDqWFW58Sh4pvttDPpzJWXFmVCxDX7pE3Xa/iLuF
   7JRVEr8/Mv43wmb8mGjCnv4kpZVz9oX+Nvg5Lxa+6cpjKvxup/5XfmgNm
   Nf1t3IwwHhSP93/N5XEEiuIfswpfUaUZw22ILefUGKfBpjlbfB4cBSQv/
   qvZy0Uthwn2TBKM9IV/ihUZKHkgp8KS4I9lEZrHnNGtHW6pGHDf1tq/m6
   Yv+O+TMyakDKd5DN96WpIOoI5vPv1X0o4GNkuYPY11GJq9vBkMptT1mHy
   Q==;
IronPort-SDR: 4KNfpNkZxMfyZQvoBG6O85bxjavqodmM5BF/2XXUFQoh1PpnYRhtk47nKegEhtl0siimBWrQX8
 wIZov77xu3yVDJ0hXaFWYOvMVfFliYBplInbKfGXZNJjdut/ks9H3DmQveP26/wELqLPL4czGX
 dl+m0bVndmr1BQ+GAG6srijNALZ0o/9MWe8v3R/D+0+D3SJrauYpBrWO9nLwFF4UTmvGBfmaY6
 NTHL/F6VbVRyPM1nCo85upQcYI6wQe+7fEX4qILenp34Wa3qnYQ3R4bzFIU0dPCLzNcjI5BH+F
 B0N4W7i4AyNXxVeIAHeT1ZoX
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="153399541"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 02:12:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 02:12:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 17 Feb 2022 02:12:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEL4eIrV126q+XhUYLorfWcg86+9IpmOk79KkFvZzPcYMz3SVkQ8WeO+AdoSSh0WeLZ1+34Sciw62DPtj2RLU4E+QOM/ClV8SQ5L1qrVdzruv06F93TiTmRlJPheWyk09DwvMhZrKw1BiBwZCUd76SpPlZHOFVhsaxs6XaVvxLQxWVSbTLEt0Q8xCtFqwpROWpYpA2OAH8j9oidE4HY462NA/7fYSIx6MafW7MlFcMYjvy/XULb40MPduCD5tcZ3eqzeBculMq/rTzIxLD1VGQOzh6veBI7f4SsTumOunlVl7ZFVYoaAt9jb9Fqpw/skH8J3yUGqhqWxbX7/6NMelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJRfL+8FMvnieYjfbAne5+lj3Po7u5GLKgiFxS4CnyQ=;
 b=PpU5pRL2tFkyptEErTa/O874GZOf+u6OvXPId2N+Ix4AxyHS8yLi78q906Q1pIwiYCbwDe/0u+OG5JfP2Kp7lTHZiDEL6zMI2Bre+QuiO+JZnkL9QKqwWtqR+DmsLI+YJNPGu308xyQgF1S0xfVMJmhyECVAg4JR4YjtVNXho2EnLbOwsxDq76CP6EtjSmmoEOJFOPPkE0T1EqraJwjg7s4OWP+pMZUvOu4YAaOkAvCQ1X4t3uKAXWC+ZRiqaYNbj+D4txXTxfXm9Clt+KGKEEp01a8Q8lRamAOWxRklx6Im2iFHg1+dfLM8luuVslsL6dS59AcJZj3JQik9PmTyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJRfL+8FMvnieYjfbAne5+lj3Po7u5GLKgiFxS4CnyQ=;
 b=YWGjCWVtbq4mhmHH05W1C+8UYJV9JVPnGIKRvo87gTidaxqTGiwbckDs/4uNsy/gzjzOT2srpearsohXUhkLWln4jMI/tf4cyOF+dL8pRTkpsKO+sqLesB83RZN+UZJdpEPAdiWs65EzYCCY/nMdxK4ybGlu5b+hcv9aa6PUm4k=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by MWHPR11MB1952.namprd11.prod.outlook.com (2603:10b6:300:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Thu, 17 Feb
 2022 09:12:46 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::b952:cac0:826c:f0be]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::b952:cac0:826c:f0be%6]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 09:12:46 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: serial: atmel: add earlycon support
Thread-Topic: [PATCH] tty: serial: atmel: add earlycon support
Thread-Index: AQHYI96GfKSNmKHcpkyvSrzv/hb/hA==
Date:   Thu, 17 Feb 2022 09:12:45 +0000
Message-ID: <9e499fdb-19dc-9b5a-0eb7-618acfd61605@microchip.com>
References: <20220216161822.1071245-1-michael@walle.cc>
In-Reply-To: <20220216161822.1071245-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e08ac2ed-a2dc-4be2-b39d-08d9f1f5a969
x-ms-traffictypediagnostic: MWHPR11MB1952:EE_
x-microsoft-antispam-prvs: <MWHPR11MB1952EE598A6E6015529A3BF687369@MWHPR11MB1952.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uVzoQr8Yl1CouQ7v+EkdyzNxVLxQsffiJUDW9bnseOSBr3z9wkSUFebX0KX/QYMQ73b1JL8GBIF1xxos3rLcDbTMHvkFv5Wgw8Zbre+8sgUD/pFYnl3yNOTKW4QQoJ724i9aP6+LfDrdqU5r5HKkTKnW0deCCoD+Z5h5KKj9ubemC6dleljUu79hbYHpdSxTpwj24MemqxAxok7u+w7mmMT2zjU6f2yhXaPqmEfAhlFoun+wfzEfZD4aAmCYCDcNlyLraxLq2O3tsFTa07akHwZzQGqloWLgcOxr86t9/hyyHp5RAzRGIowrbx2W2hCpp3w70IJiuZE/NpNFSWWtgRSj4LG+PAJVx1gwLxymwQa9KQzz2mlFp25AmEeSbMxa3bqR6L1npfvcJWNuYWabvqZlx5+ZaWscT5IeVujlu59ezaOa4jV0bAC7Uaq5Bmc9Mcf0ZswNCO9xK8jAf0G/8jMo39k0CkmD27NDt7vLoeNQnIt+o3MnVm3KDZ4KZ6i4aj/BUpKNPIfNNYU46mKPHVNqVyrMk5258Dhrxzu4Bu+blyjeMYHxftyzmPRam7IsX49ueEqYsvd6teVXB2PZz6wVHHGbfRWQ0glL/0zpETwPxSVMrvOUGJaS5Rk7cUNqXa66iMH8ZIf0UO+mXbrSuT8jV1tkyYnctU4zELSq3ONTIem4v1VWvyjGPC0V7km2aPV8FxXgLiO7XLqVVUuByf/jfCxD+snorm+pYeaHzcEeKmgXtgeu1K0IW6ZCubrol/otXO0IQ+fIr6t1dN8JkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6486002)(54906003)(38070700005)(6512007)(6506007)(8936002)(316002)(122000001)(508600001)(2906002)(53546011)(38100700002)(36756003)(64756008)(86362001)(66446008)(66946007)(76116006)(66476007)(66556008)(8676002)(4326008)(91956017)(31696002)(186003)(26005)(71200400001)(2616005)(110136005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N29Jbis5L2dCM3JWTzErM29kL3p6bEhBK0xJdXFJUjI2bEZHc2ltOUZVK21R?=
 =?utf-8?B?Mm9CYzFCWE8rbXhveVJyaVRDR1dxaVlUOU15Q0d6cGJ6aW5aT0VpaGowMmhV?=
 =?utf-8?B?TVdpaUVpcGt2aEN4bU1naENJMi9iUWFqTUVoQkc1NzZXdFFoV1JpV0UwelNV?=
 =?utf-8?B?OXZ2ekpGeW5XTFNSNHBlVm5TQmZkR0laVU1FYjFSbUhNMC8zTFFIUElEZEFr?=
 =?utf-8?B?QXNQREpZUVN5ZmppcWJ4R3oxaFRvQXA2L0ZWZ2Jkdk00WDAzdzY5SlorbHZI?=
 =?utf-8?B?MzRDVk1mY1h2TlFucFlqRnVTaUN2c1VmdktTeFhsZGhlL1FxcVYyUW1wYjRi?=
 =?utf-8?B?Nzkva3UxRmFqZlZYUDNyby80SXQ5YzdFam9ReWFueUxDSnlWZzZLcHNGZlpP?=
 =?utf-8?B?dDVTSnlDc1ovbWszejJWRk8wQU9iYjJieFlFK2JJNWNUZU9rZ2xkVGVXV1lm?=
 =?utf-8?B?TDkrbFpEL0xJZkcvV3hiY1Y4c1IvOXN4SzFvbmo2Q1ZGdUtOKyt4M3Z4VVdL?=
 =?utf-8?B?SmlnV0dKNVl1N2pKQ1Qwdy9NbUNBZzlIK1g0RlI0MTR5Y3VZT01jWTVOaXB0?=
 =?utf-8?B?ejRZaVFmbnFGajgvek82dmdDU2s2cnVvSUp4RFUvSkhZTUpPNGIwaDQ3RnRW?=
 =?utf-8?B?OGMwQTFzQ1FMMWNaMjg1UWdDZWd0eXdWTHY2cVh4VmRKbytzS1dZcDhNMndV?=
 =?utf-8?B?TmNoQ1RMWjh0YU5LR2JtdkR5OTJDVzJFaGsrNkZPenV2cWNvdnFLT3pUSEFT?=
 =?utf-8?B?amtwSjVsd0dodDBONXAreHg3MVNUTko2UnVIbytRcWVMa3VWTDA4dkpGbzFv?=
 =?utf-8?B?SEViMENFdjdmbUZFUDR6TG1xcjd4aHRmaURPQjBkTUUwbnk2RGhmTmloUjhK?=
 =?utf-8?B?dzJoekR3dDFHcjFoQVV1OTQvbE56R08zbVVOQWdMdjBJVGxhdkFkTVpzMDVq?=
 =?utf-8?B?dlc0TEFHT2J0ajk4aHR0NlFDeUZNWFFjVm9kc3dqbEtPd1h5OCthRXpCOXFW?=
 =?utf-8?B?YnU1dy9NT2VSRmZZSW9IYXgwNnBnVzVOLzNtdlExSVBGL2puTzI5Q2xCaTdw?=
 =?utf-8?B?UTh6WjF4MExxVzB1WjY2dWpHYXVEbGpQV3JoZFdMN2lrTEd4bTZxRE9XUEg2?=
 =?utf-8?B?STd2bE1sLzlEdnhPUFZwYlkvdU4zSGVCVnlWeElid3QxdGdmcnNtRVEySWRk?=
 =?utf-8?B?bS8yaE5mYjh6N09tV1o5YmZwdDdlcGRrK3VDN25VajlpQmtPZi9YN0VRWHJm?=
 =?utf-8?B?bG5MOE90RFl0U0pWaDBQMHJXbWhHUW92bUZWMGEvTDJqTVI0NHBLSHRvbUhi?=
 =?utf-8?B?RUZBaGtKSHJmVkVYKzB0WVVXR0JsMDFUV2s3a0dXazh0OHg4cEMzSGRyY1JO?=
 =?utf-8?B?eTJzM0IzYUplNENkaVBMRFFEOW5POVIvL3llcE8xRm5GWW1WLy9ibWFTVERp?=
 =?utf-8?B?ZS9xSTNHNTVPTVdmemFQSi9ES2E5LzA4SnFITnFmNnpXMXMzZkRLcW81cHY0?=
 =?utf-8?B?SkFhcXRhL1NKUjJDdnplazQzYm9QbTZuc0pMRExwWHFyM2ZGZEJQLzF1YjZ3?=
 =?utf-8?B?aC9wN296clhEZmpWVjA4UlhRazAzWFRiSWVrUkxUQk40YUw2SytvUnJpUWEx?=
 =?utf-8?B?UVF4QndkTlNxUzhrYzdENTJtTXdTQ0hLQXdUY0lwUXNCc1JDQjNDU0JZemlK?=
 =?utf-8?B?UCtNUXdGMUU4ZVBlcWdGamYxWE1yUks5VkVKNUlGWnJMSCtTUkxzZmNCUlpn?=
 =?utf-8?B?R2pqdnB5RVlOd3ROK0wzVjEwRHQrT1Y1RSs2YkoxcGNaT3JONk5LczFxcjVa?=
 =?utf-8?B?cTRwQ3RsMVpnQWlSRW5nSHpNVTlSeElUaTJIQXMwZnpJOStabVNEUTZYNHJ2?=
 =?utf-8?B?VlJSZkVxQ0pXZHl2YWNBN3pxNjU1dzcwK01kUE1WcExoVHFnR3lMc0h0V2Uy?=
 =?utf-8?B?RFp0V0ltTnRVU3BKK285cE1OMEVpeXl0eGRvM2I1RTNEd3hCRFcyaWVTOE5Z?=
 =?utf-8?B?Y0YyU2s0eGM2aWJhQjkxbUJVbG5ISU5kSUhOV2ZFekkrSEdrNUFxc242VTFQ?=
 =?utf-8?B?Vno0aHprWEJ0L0pmQ1VHMHZLa1dpY0J3ZStEbWdkMXdIOWFqTDNTdkhUK3RC?=
 =?utf-8?B?OFRsQUNYVUtabW84dnN1WGNpUE4ySXRERTFmMm9JUzlLZGtaWVJodHlZM25T?=
 =?utf-8?B?UW9DR3l2RGYyUmNTUW55NTYySTBEdjJDQ2I0Q1YvZHErNCtXRzhjbGhqNU1N?=
 =?utf-8?B?NWk4N2c4OXpsa3AvRllFSklSSUZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <060A5C4D83E8DE4AA99E41CC61509B5C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08ac2ed-a2dc-4be2-b39d-08d9f1f5a969
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 09:12:45.9944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NnAPN3JAUbEVnCwwDh3InIY08ifk5UgQcKqhhwgpBRr8JLf3OyVj1DF2VHX2BG0wb4O/cMdmXDYGg6KsoFdvPbPPAOmnOfjG4GKOe613zzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1952
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGVhbCwNCg0KT24gMTYuMDIuMjAyMiAxODoxOCwgTWljaGFlbCBXYWxsZSB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgZWFybHkgY29u
c29sZSBzdXBwb3J0IHdoaWNoIHJlbGllcyBvbiB0aGUgYm9vdGxvYWRlciBmb3IgdGhlDQo+IGlu
aXRpYWxpemF0aW9uIG9mIHRoZSBVQVJULg0KPiBQbGVhc2Ugbm90ZSwgdGhhdCB0aGUgY29tcGF0
aWJsZXMgYXJlIHRha2VuIGZyb20gYXQ5MS11c2FydCBNRkQNCj4gZHJpdmVyLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCj4gLS0tDQo+ICBk
cml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMgfCAyNCArKysrKysrKysrKysrKysrKysr
KysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jIGIvZHJpdmVycy90dHkvc2Vy
aWFsL2F0bWVsX3NlcmlhbC5jDQo+IGluZGV4IDJkMDlhODk5NzRhMi4uNTBmYzZkNTFmZjBkIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4gKysrIGIv
ZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jDQo+IEBAIC0yNjczLDYgKzI2NzMsMzAg
QEAgc3RhdGljIHN0cnVjdCBjb25zb2xlIGF0bWVsX2NvbnNvbGUgPSB7DQo+ICAgICAgICAgLmRh
dGEgICAgICAgICAgID0gJmF0bWVsX3VhcnQsDQo+ICB9Ow0KPiANCj4gK3N0YXRpYyB2b2lkIGF0
bWVsX3NlcmlhbF9lYXJseV93cml0ZShzdHJ1Y3QgY29uc29sZSAqY29uLCBjb25zdCBjaGFyICpz
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IG4p
DQo+ICt7DQo+ICsgICAgICAgc3RydWN0IGVhcmx5Y29uX2RldmljZSAqZGV2ID0gY29uLT5kYXRh
Ow0KPiArDQo+ICsgICAgICAgdWFydF9jb25zb2xlX3dyaXRlKCZkZXYtPnBvcnQsIHMsIG4sIGF0
bWVsX2NvbnNvbGVfcHV0Y2hhcik7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgX19pbml0IGF0
bWVsX2Vhcmx5X2NvbnNvbGVfc2V0dXAoc3RydWN0IGVhcmx5Y29uX2RldmljZSAqZGV2aWNlLA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIg
Km9wdGlvbnMpDQo+ICt7DQo+ICsgICAgICAgaWYgKCFkZXZpY2UtPnBvcnQubWVtYmFzZSkNCj4g
KyAgICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPiArDQo+ICsgICAgICAgZGV2aWNlLT5j
b24tPndyaXRlID0gYXRtZWxfc2VyaWFsX2Vhcmx5X3dyaXRlOw0KPiArDQo+ICsgICAgICAgcmV0
dXJuIDA7DQo+ICt9DQo+ICsNCj4gK09GX0VBUkxZQ09OX0RFQ0xBUkUoYXRtZWxzZXJpYWwsICJh
dG1lbCxhdDkxcm05MjAwLXVzYXJ0IiwNCj4gKyAgICAgICAgICAgICAgICAgICBhdG1lbF9lYXJs
eV9jb25zb2xlX3NldHVwKTsNCj4gK09GX0VBUkxZQ09OX0RFQ0xBUkUoYXRtZWxzZXJpYWwsICJh
dG1lbCxhdDkxc2FtOTI2MC11c2FydCIsDQoNCg0KRm9yIGNvbnNpc3RlbmN5IHdpdGggdGhlIHJl
c3Qgb2YgdGhlIG5hbWluZyBpbiB0aGlzIGZpbGUgY291bGQgeW91IG5hbWUgaXQNCmF0bWVsX3Nl
cmlhbD8NCg0KQWxzbywgaXQgd291bGQgYmUgZ29vZCB0byBzZWxlY3QgU0VSSUFMX0VBUkxZQ09O
IGluIEtjb25maWcgdG8gaGF2ZSBpdA0KYXZhaWxhYmxlIGFsc28gZm9yIHByb2R1Y3Rpb24gdy9v
IGNoYW5naW5nIGRlZmNvbmZpZ3MuDQoNClRoYW5rIHlvdSwNCkNsYXVkaXUgQmV6bmVhDQoNCj4g
KyAgICAgICAgICAgICAgICAgICBhdG1lbF9lYXJseV9jb25zb2xlX3NldHVwKTsNCj4gKw0KPiAg
I2RlZmluZSBBVE1FTF9DT05TT0xFX0RFVklDRSAgICgmYXRtZWxfY29uc29sZSkNCj4gDQo+ICAj
ZWxzZQ0KPiAtLQ0KPiAyLjMwLjINCj4gDQoNCg==
