Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F269F46FEAB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 11:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhLJK1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 05:27:02 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:5352 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhLJK1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 05:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639131808; x=1670667808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xx9zVas16QEc7OF6nMmp3v3jsg4B0i4Dx/YAao1Sxvg=;
  b=ATT5i5VO02N7TrBW2xLxMPoc5a0Sds+JAE1mAHqu70DA2E42AlAgRlMb
   mG/wA97HcICs57xGMwrU2vMEWCfPP9pbWVDnlk9l0Zwoj3Vn8hZ/1ge7i
   MZsDUwihj/w227JW0WrMAMWdcy9p/InbDLeKFKofSoabXkJPfIAOiVWAp
   FMSy+0zBkvEgLRFRkf0HaNPMaDAGJ5MyxYTAC48WWOCF+sQ5zqHZszbjL
   gfiWu2AelAylzuiuG1q/2vdYguCiu563094GzFosj/A/0Zp9dLBNV41A0
   IFb1sS9ZpslBwW2L5a5i57cdAHCkACvc+FIFfeQr9GicHViLVU6Lr8LyH
   A==;
IronPort-SDR: Aa+2FNKA5vdunXQpyq33ydbFZ9oKxTsZz8eDHkFxZzT8lCrwrbkLw4CZ6/86vjAL3j19li6jL+
 jhRByiT+in2rXVUjQNV30rUHJ3KD/YkNuBDyV0tpoTOM7+JKL10LcAy9iTJ9LqoBo8EtSY/fY2
 e7kSD1KaHF949s8CeDumQsEnVJZ8bVO9zNnlPjL81gaN9jRfZKFcX6e5EoaWyAUNkZLR/th+Vf
 3Y+5d+NsUP+hlHAZSz2dCSbiT16Vbh6778qXtWQgv6qKYwkAN4HyHzlONc0wf1pX8A/NuKLbXp
 aH5L9WhWi2XQ4ikq5T3CLf/7
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="146220878"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Dec 2021 03:23:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Dec 2021 03:23:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 10 Dec 2021 03:23:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeZuUm8Hk3L+mfgXIqwGXzJg7g7gDVJa9TW4z7KzNUMNYs8y5AYU2s0iXEueXhXqFLGpnX7HuPS0GyS+oIm3aiuQpEzedUNCPhTClM2b59w9sKYo9h9XbcnduLo4dlKVU2u6SC6miX1VeoQgG1JnBHurA0QAOcx4auVdUNq/k+Rp2RsnYBOUDOaawyNk+EsyuPfhSQO1sGXXNagqrCSHz6K7zwknFd1w7kj4ExPnQ/sFWhKbWoDdl51ckn2zQaKL2W4Y725CNzYiHQZ/U+7hv53XKvZXQS4xc7L7mjwmF2R4e7+RcPGMd1MVPmzVK7CKKwFG4UFWHjmt0zvCSqFanA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xx9zVas16QEc7OF6nMmp3v3jsg4B0i4Dx/YAao1Sxvg=;
 b=MG4irUCArMjAP6xP4fzIU0hApxmhachGTwuxHNAqd5fHEkbqBpJSKTQZuasqlM/tRDDoYu6ZkqX9mqFprD7wBftOTHHZZOlLXVJp07qK+EOHGAEFIXm9H8eQmbrVC0U+xqXPZG3zZy4D5noxFL3meQ5LMHLMz7aCVlkI5rX2hY+b/eK3i7O5cRt6P1QiOz9KpxqGtX5ckByFisIa8XgBYNb5OzqOY6iA669tp/stBj6ogKD7Ho2xFPpuDbWMY2JLmWRUveiLJyqWTx45+ks72AZKVGEOyET+JEYJZsVw/bZWx+v4XDS9vSy5CTyC/QRUwttnuQKawFQAFIpu/dkJqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xx9zVas16QEc7OF6nMmp3v3jsg4B0i4Dx/YAao1Sxvg=;
 b=gRyPRG/IjpB5CEFav711xaiLts7WYYEyeuL7ihje3NA5BEkUJYWQmmWZmQeGZKi3ixAa20xBUyeXtAyDFcNxKePVwBhZ4HSMSSffDNwumg8H19nUik2TiTMToIFlQTnJyA3j19mZdmZtb+XCxRobC5VIon5sebrkRvG05taR0RU=
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by PH0PR11MB4934.namprd11.prod.outlook.com (2603:10b6:510:30::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 10 Dec
 2021 10:23:20 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::ec81:740d:c5cf:5ad0]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::ec81:740d:c5cf:5ad0%5]) with mapi id 15.20.4755.024; Fri, 10 Dec 2021
 10:23:20 +0000
From:   <Ajish.Koshy@microchip.com>
To:     <john.garry@huawei.com>, <jinpu.wang@cloud.ionos.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <Viswas.G@microchip.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>
Subject: RE: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
Thread-Topic: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
Thread-Index: AQHX4twBpu9E7jx9w0eTfQRflv+fTqwqQHyAgAFNTxA=
Date:   Fri, 10 Dec 2021 10:23:20 +0000
Message-ID: <PH0PR11MB51122D76F40E164C31AFEE54EC719@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <1637940933-107862-1-git-send-email-john.garry@huawei.com>
 <a93da7a3-9cbe-b278-36ce-1ac860ad43d6@huawei.com>
In-Reply-To: <a93da7a3-9cbe-b278-36ce-1ac860ad43d6@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 317e93ff-7e7c-43c3-c977-08d9bbc716f6
x-ms-traffictypediagnostic: PH0PR11MB4934:EE_
x-microsoft-antispam-prvs: <PH0PR11MB493483289B104D71C8CDD613EC719@PH0PR11MB4934.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WKwtW2+u7T1DUWXxY4sJGuAtX5EfzQ+uv0APvGBjtmyu/gvqnZ1sg3jevb9w3Ge/VuZToQ6Zj949PSTUU6EvtgiaixPiORHYqagC8BjkD3PStzGsCp8HkjwzdB8IL6CDvydCphapJ4IuFxchI6i6hKVa7/iG+nsYT9L/dHXD6wauRVHNOq/B6s6ZKGd//75XbcF9vV27aQUpKM9QN0UPC4FrCOSQbOMJDbr10tJYv+F8aHmTPqjl0KGnBghTxt/PXsS8pXgIWsQtbLrZnZp9wvVg0coIa2ZEDMHVbIdBaxFb2x1YoWBbM8aRCYG31oTW6BNunPnUnQJRb/JNmVQLlZPgax7kqBEKIvjE18/UzoMtVoDJF8i9bAHs3AkckpLOwnUcjlZU2lByJw63+7qbrbDCxu6d1vnOnDccMZDvAhlW4waucc782x6Ne/1KG9xTh03K5baT2oRAhUmiXBG1qE9g3B0PVdfedl++ngWLEhxiFDRK/7b/SxW2yVztACNmcgJd8b+7uLVjTA6+c74LxlDZEljo5tRi1sNtbIb42AAYHnwznGwtOdUKdcl+VHMNk6Tdeqf0J854Hm6Zr5xzcI+kvLshQDpQEWcPV86d7g7ih7SyRpVp7r8MaZSQoXrzkbdOjrr3uAM+vT1768pfIhTbPP8IENXVPbX/I5kj276Aox8Ahxhz5Q6FzpCwh4bn1fhN01WbvLDjNHUr7MnQng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5112.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(2906002)(316002)(8936002)(26005)(7696005)(71200400001)(54906003)(53546011)(52536014)(107886003)(508600001)(38070700005)(110136005)(9686003)(33656002)(64756008)(122000001)(186003)(76116006)(66946007)(66446008)(66556008)(66476007)(86362001)(8676002)(5660300002)(55016003)(83380400001)(38100700002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUV6Z3hDSG5QcVZzV0orTUs3RFF0Mm1USWpzMm5LeXZwNUpydkNSdVl6OWZS?=
 =?utf-8?B?cFRlMWhzbFR6OVdPMW5CVG5sOUwyNHJ3WDFweTdSMXFHWGlmd3hrSGlQMWVX?=
 =?utf-8?B?VGc3dERMMHdRVnR0dVhkRmNYSDArTS9ydDlFSENYZEV1QWZLUmxHQmZlLzlR?=
 =?utf-8?B?R3FMZXJPY282YTlpaTYzZmNwT2tDNElVd2pQVmdWdXMrWnRqWVVGMTZFclht?=
 =?utf-8?B?b0NodXpjYThIcldwVG4reC9OQjgwdVlmbDVtZ3VQRDBYUHdaQzdWTUNsa3Zw?=
 =?utf-8?B?NCtzRzg3cmgxZk1kVEFFNGRFUmFSaVRxYm5lT01wQ0h6YWtnSzhPSStPUG85?=
 =?utf-8?B?OVBxczhpdDUxZ0lNVHI4VEdGNlBwa3p2WjlaVFVUVlpEMkx6OTFKWFpMdDZq?=
 =?utf-8?B?QmN5LzFkTHNXZ3F4RWxlMUYyUHBzbEFUQytKcVprZ2xSQXZYS1R1bkU4TlRR?=
 =?utf-8?B?VEU0Nyt5RzNmM2cxV1N3MkgvNnNBN0dmZFBTbVFzenNoN2hDemltekI2S0R5?=
 =?utf-8?B?ajREZ0NlbkcxdlZ5Z2RDcUZDZGlOalhUdEc1NVlkd3pNaVdta2tnS3VKKzRY?=
 =?utf-8?B?UlBzTFZtbHdueFl4ZmZhcGVIWG1vclBnMnVVb1dwQzZMaXUxeW9ScEQ2cXNN?=
 =?utf-8?B?dnY2VTZ1Q0NNaXlNNGZiREVKRlREcUdrZHJaaDFmUjdQRzVUUDZKcnlyczBJ?=
 =?utf-8?B?VnRIMVFxWWdvOGZVMnpIQlhlVEZwQlJIK3gyOGV5eWNCR3pHWkt6dGsvSThF?=
 =?utf-8?B?OUdpVy96eVg5R2cxUWJzWnRFMUdZeDhUV1pUdStEZ0ZTNWF2bXVCQ1B0Q2pz?=
 =?utf-8?B?aFpXYlVIV05MRHZsaU1neDVTSjJvSDR5ODlQSlVYeVlWeDBoY0RvNTYyd0JF?=
 =?utf-8?B?RWNZRDQ2Uyt5cnVPUjRjeGp6VmxLZU1JVDk3Q3NKc1ZaQXhpTlM0RS9odTJQ?=
 =?utf-8?B?MDRHOHRRaVRqRDZpUlJaWDN2YTlFSkdjSXVBMzRBMzZYNEt1clRCRWhUU2FV?=
 =?utf-8?B?YVpvYWhqYVMvWHkydGNKY2FJZUJjK3R1TnVWdjJ4S3pVVWw5UWFuZ3NDVHJZ?=
 =?utf-8?B?M0lHSUdoRmdYMzQ1MytkbGd0UHVGZlZOamptTEpXelBIQjhubEIwKzBvMlFv?=
 =?utf-8?B?Umc3Z0NtTkI1VHgrTHJ4N2xUalo3bW1WUC9tcENrTGlLSEFMKzIzaUo0bEM4?=
 =?utf-8?B?bUZrYXhvU0xVcXM0YnNSbklMVUt2cmdTaGxlc1g5Z1BOMm5SM3dSTGVpWEFX?=
 =?utf-8?B?RWczR2tFL2Q3MHlXcGZvVzRIL0Y0SEp3OFZ6VVRkZVlxS3JIU2VJaElMUHRY?=
 =?utf-8?B?RmRRcVZaYzR3a05yMkQ0NWNwMytzbzVnTmNaNTkxQmVFR3dVOGthZ0YxQW1G?=
 =?utf-8?B?Q05tRG9LV3BkRVhxczhGU2lobTk5b2xzUXhoeHVnbU91VXZTNUZ5bHRad1kw?=
 =?utf-8?B?d0J1OW9BSHgxc3FORlVyOWhyVlJlMkVuM1lRMlRYQzlub21yYnozQVBndlkr?=
 =?utf-8?B?UFRMUHU2a0tkUDFLUVhlUC9QQWlWUjBUV0t4R0ZaZ2RlSDUxTjVqSWdmM0dP?=
 =?utf-8?B?U1NFRDEzUVVJVzlCOW5vZ2lzMi9LM0I3RHBZbElMS2Q1RlRCR2tpVnY3M200?=
 =?utf-8?B?VWRtUHFPSDBOdjdqc0ltYmFNRERJRzJJN2hKWTNPY3Y3eUhaUmwyL3YrbzVy?=
 =?utf-8?B?OStMYWN2K0QrbW8rL3FiWCtEd1lISEtwZ1NyTjlOWGpNem1jWkhqQVA2Z1lm?=
 =?utf-8?B?ZEtJaEg2cUdVNmlTczR2aDZZQXJUU05ZbnNwSmw0Y3JmTW13bGJIeStvajdz?=
 =?utf-8?B?TnNxdGwwSVNJUk45Y0N0T2d1bGFmb2tOdTRZa1g2REcxSkpXUjdHRmtVUjdW?=
 =?utf-8?B?aUtSWVRRRTArVHhnZFRTRkx3OTJlbk5YU3h1SzJsOFd4MmNBWVQwSFlPQVVk?=
 =?utf-8?B?ZVF6NXdNT0lJUk9oT1I2b2FSZm0wakhzT0NRKzRNUEVBVlIzdmd1b1F0UEpR?=
 =?utf-8?B?QXVkS092V1NHaXdGRUxyNWltUkR4WVVpZE5mZGpuZTVNTG1YT0l2L1pvcERT?=
 =?utf-8?B?WGNGTitRSWlHSjFMbjZBTlM5aTNXbUZLeExhMUxjcVBvVmM5bHNUMXhKaktv?=
 =?utf-8?B?SmRsZVJCcVMxVGhZUExPUXdwZ04rWCtOTWdlOFNiNDByQmE1Tm5ZT2JFemgz?=
 =?utf-8?B?dWQvTnpoUmN2UTg1QStzVDYveDlYYWtXdlh0akZmV1dMaFNha3pCN05GMG4y?=
 =?utf-8?B?SFhUQUl2dUNtN3BrR1NWMEp6aWt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317e93ff-7e7c-43c3-c977-08d9bbc716f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 10:23:20.6071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RpzHJpjgP7J2wx3qvy24Mw90U60rBFomuLMCNjhWWvYAg51Hv0V/QVxaAFtvRiDBgGXiDcw00k5uM/EmTiwp8QP7u9py1yWBuqPhepQTbp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4934
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9obiwNCg0KSW4gbXkgaHVtYmxlIG9waW5pb24gd2hhdCB3ZSBvYnNlcnZlZCB2ZXJ5IGVh
cmxpZXIgd2FzIHdpdGggcmVzcGVjdCBzbXBfcmVxdWVzdCgpL3Jlc3BvbnNlKCkgY3Jhc2ggYW5k
IHRoaXMgcGF0Y2ggcmVzb2x2ZWQgaXQuIEdpdmVuIHRoYXQgdGhlIGlzc3VlIHdhcyBub3Qgb25s
eSBzcGVjaWZpYyB0byBBUk0sIGlzc3VlIHdhcyBvYnNlcnZlZCBvbiB4ODYgdG9vIHdpdGggSU9N
TVUgZW5hYmxlZC4gRGV2aWNlIGRpc2NvdmVyeSB3ZW50IGZpbmUgcG9zdCBhcHBsaWNhdGlvbiBv
ZiB0aGlzIHBhdGNoIG9uIHg4Ni4gDQoNCldoYXQgd2UgYXJlIG9ic2VydmluZyByaWdodCBub3cg
b24gZXJyb3IgaGFuZGxpbmcvdGltZW91dHMgZm9yIGNvbW1hbmRzIG9uIGRyaXZlcyB3aWxsIGJl
IGFsdG9nZXRoZXIgZGlmZmVyZW50IGlzc3VlIHRoYXQgbmVlZHMgc2VwYXJhdGUgZGVidWdnaW5n
IG9uIEFSTSBwbGF0Zm9ybSB3aXRoIHNlcGFyYXRlIHBhdGNoIHNpbmNlIHRoaXMgaXMgYSB2ZXJ5
IGluaXRpYWwgZXhlY3V0aW9uIG9mIHBtODB4eCBkcml2ZXIgb24gQVJNIHBsYXRmb3JtLiANCg0K
VGhpcyBwYXRjaCBpcyBhY2NlcHRhYmxlLiBMZXQgbWUga25vdyB5b3VyIGZ1cnRoZXIgdmlld3Mu
IA0KDQpUaGFua3MsDQpBamlzaA0KDQpPbiAyNi8xMS8yMDIxIDE1OjM1LCBKb2huIEdhcnJ5IHdy
b3RlOg0KPiAgICAgICAvKg0KPiBAQCAtNDI4MCw4ICs0MjgzLDkgQEAgc3RhdGljIGludCBwbTgw
eHhfY2hpcF9zbXBfcmVxKHN0cnVjdCBwbTgwMDFfaGJhX2luZm8gKnBtODAwMV9oYSwNCj4gICAg
ICAgICAgICAgICBwbTgwMDFfaGEtPnNtcF9leHBfbW9kZSA9IFNNUF9JTkRJUkVDVDsNCj4NCj4N
Cj4gLSAgICAgdG1wX2FkZHIgPSBjcHVfdG9fbGU2NCgodTY0KXNnX2RtYV9hZGRyZXNzKCZ0YXNr
LT5zbXBfdGFzay5zbXBfcmVxKSk7DQo+IC0gICAgIHByZXFfZG1hX2FkZHIgPSAoY2hhciAqKXBo
eXNfdG9fdmlydCh0bXBfYWRkcik7DQo+ICsgICAgIHNtcF9yZXEgPSAmdGFzay0+c21wX3Rhc2su
c21wX3JlcTsNCj4gKyAgICAgdG8gPSBrbWFwKHNnX3BhZ2Uoc21wX3JlcSkpOw0KDQpUaGlzIHNo
b3VsZCBiZSBhIGttYXBfYXRvbWljKCkgYXMgd2VsbCwgYXMgSSBzZWUgdGhlIGZvbGxvd2luZyBm
b3Igd2hlbg0KQ09ORklHX0RFQlVHX0FUT01JQ19TTEVFUCBpcyBlbmFibGVkOg0KDQpbICAgMjcu
MjIyMTE2XSAgZHVtcF9iYWNrdHJhY2UrMHgwLzB4MmI0DQpbICAgMjcuMjI1Nzc0XSAgc2hvd19z
dGFjaysweDFjLzB4MzANClsgICAyNy4yMjkwODRdICBkdW1wX3N0YWNrX2x2bCsweDY4LzB4ODQN
ClsgICAyNy4yMzI3NDFdICBkdW1wX3N0YWNrKzB4MjAvMHgzYw0KWyAgIDI3LjIzNjA0OV0gIF9f
bWlnaHRfcmVzY2hlZCsweDFkNC8weDI0MA0KWyAgIDI3LjIzOTk2N10gIF9fbWlnaHRfc2xlZXAr
MHg3MC8weGQwDQpbICAgMjcuMjQzNTM2XSAgcG04MHh4X2NoaXBfc21wX3JlcSsweDJjNC8weDU2
Yw0KWyAgIDI3LjI0NzgwMl0gIHBtODAwMV90YXNrX2V4ZWMuY29uc3Rwcm9wLjArMHg3MTgvMHg3
NzANClsgICAyNy4yNTI4NDhdICBwbTgwMDFfcXVldWVfY29tbWFuZCsweDFjLzB4MmMNClsgICAy
Ny4yNTcwMjZdICBzbXBfZXhlY3V0ZV90YXNrX3NnKzB4MWU4LzB4MzcwDQpbICAgMjcuMjYxMjg5
XSAgc2FzX2V4X3BoeV9kaXNjb3ZlcisweDI5Yy8weDMxYw0KWyAgIDI3LjI2NTU1M10gIHNtcF9h
dGFfY2hlY2tfcmVhZHkrMHg3NC8weDE5MA0KWyAgIDI3LjI2OTcyOV0gIGF0YV93YWl0X3JlYWR5
KzB4ZDAvMHgyMjQNClsgICAyNy4yNzM0NzRdICBhdGFfd2FpdF9hZnRlcl9yZXNldCsweDc4LzB4
YWMNClsgICAyNy4yNzc2NTJdICBzYXNfYXRhX2hhcmRfcmVzZXQrMHhmMC8weDE4Yw0KWyAgIDI3
LjI4MTc0Ml0gIGF0YV9kb19yZXNldC5jb25zdHByb3AuMCsweDgwLzB4OWMNClsgICAyNy4yODYy
NjZdICBhdGFfZWhfcmVzZXQrMHhiYTQvMHgxMTcwDQpbICAgMjcuMjkwMDA4XSAgYXRhX2VoX3Jl
Y292ZXIrMHg0YjAvMHgxYjQwDQpbICAgMjcuMjkzOTI0XSAgYXRhX2RvX2VoKzB4OGMvMHgxMTAN
ClsgICAyNy4yOTcyMzJdICBhdGFfc3RkX2Vycm9yX2hhbmRsZXIrMHg4MC8weGIwDQpbICAgMjcu
MzAxNDk1XSAgYXRhX3Njc2lfcG9ydF9lcnJvcl9oYW5kbGVyKzB4M2Q0LzB4OWQwDQpbICAgMjcu
MzA2NDU0XSAgYXN5bmNfc2FzX2F0YV9laCsweDcwLzB4ZjgNClsgICAyNy4zMTAyODVdICBhc3lu
Y19ydW5fZW50cnlfZm4rMHg1Yy8weDFlMA0KWyAgIDI3LjMxNDM3NV0gIHByb2Nlc3Nfb25lX3dv
cmsrMHgzNzgvMHg2MzANClsgICAyNy4zMTgzNzldICB3b3JrZXJfdGhyZWFkKzB4YTgvMHg2YmMN
ClsgICAyNy4zMjIwMzNdICBrdGhyZWFkKzB4MjE0LzB4MjMwDQpbICAgMjcuMzI1MjU2XSAgcmV0
X2Zyb21fZm9yaysweDEwLzB4MjANClsgICAyNy4zMjg4MjVdIHBtODB4eDA6OiBwbTgweHhfY2hp
cF9zbXBfcmVxICA0MjkyOlNNUCBSRVFVRVNUIElORElSRUNUIE1PREUNCg0KQnV0IEkgZG9uJ3Qg
dGhpbmsgdGhhdCB0aGlzIGlzIHRoZSBwcm9ibGVtIHdoaWNoIGNhdXNlcyBlcnJvciBoYW5kbGlu
Zw0KdG8ga2ljayBpbiBsYXRlciwgYXMgZGlzY3Vzc2VkIGluIHRoaXMgdGhyZWFkLg0KDQo+ICsg
ICAgIHBheWxvYWQgPSB0byArIHNtcF9yZXEtPm9mZnNldDsNCj4NCj4gICAgICAgLyogSU5ESVJF
Q1QgTU9ERSBjb21tYW5kIHNldHRpbmdzLiBVc2UgRE1BICovDQo+ICAgICAgIGlmIChwbTgwMDFf
aGEtPnNtcF9leHBfbW9kZSA9PSBTTVBfSU5ESVJFQ1QpIHsNCj4gQEAgLTQyODksNyArNDI5Myw3
IEBAIHN0YXRpYyBpbnQgcG04MHh4X2NoaXBfc21wX3JlcShzdHJ1Y3QgcG04MDAxX2hiYV9pbmZv
ICpwbTgwMDFfaGEsDQo+ICAgICAgICAgICAgICAgLyogZm9yIFNQQ3YgaW5kaXJlY3QgbW9kZS4g
UGxhY2UgdGhlIHRvcCA0IGJ5dGVzIG9mDQo+ICAgICAgICAgICAgICAgICogU01QIFJlcXVlc3Qg
aGVhZGVyIGhlcmUuICovDQo+ICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IDQ7IGkrKykN
Cj4gLSAgICAgICAgICAgICAgICAgICAgIHNtcF9jbWQuc21wX3JlcTE2W2ldID0gKihwcmVxX2Rt
YV9hZGRyICsgaSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICBzbXBfY21kLnNtcF9yZXExNltp
XSA9ICoocGF5bG9hZCArIGkpOw0KDQo=
