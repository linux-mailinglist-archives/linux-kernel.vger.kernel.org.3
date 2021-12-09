Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5837646E803
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbhLIMIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:08:30 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:30045 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbhLIMI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639051495; x=1670587495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K17m8lIgBgNct8OGElizuq9BrgS3VSJVWga6hQ924lY=;
  b=YaVDU66OZdvM8RXOHcxACizMDkQ238jx0EIwUaxML7C5VXHCS1xxtspR
   DU572DqiuDBZABmSboD0IOyPk1auIog1CD4S1FLm72Splw3f2Xh/oiYqB
   5TCz//i1dutW3I4L7OufSHWD4foo6jaxIg3jiajyoG0qM8Wy31lnbdSTU
   klPZ3fMQaVUh28/xdDaEmPHeHlTpphlxiZPYzzhrxPjjyCqJ3ctvg827V
   FAERSqcbOYlBWECzQcrciSAJaYPMOhVyi1GUio+tas3stcO7CkgOaSA0z
   1yHQR5EMruHus/S+sMjoK4SkZEC23qNjYNspGyt2g973jIj1sFoml6vrL
   A==;
IronPort-SDR: pgM8cch4UT8+frehs4/qMhCI8ujDo13WJPQTrzLnbJrLNTVAN71zh3KwN+KjQchsaqixsd3Esl
 RtgZpZuGjVS09D84BoUyfhMKERUQaE75t/d+VH7jzwYLZrufa5E+z2BN99nE97dUhVrcGbiH3f
 4xCgH6Sgi6ahSPFdXeRoEAN6TGtsXvsyPUF0jgiaS3xk08IlOXL6P0yM6c2ISpkn2KEqgDBINp
 T7gGhkK1qGyjUcnwuLfchXJZJ430FiYUaIilL210lwjKqWBYE9Pft4yIpft8fHKVZ6CZjxDGU3
 W4g9bkMj8iT0SZis6uvhyrek
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="154855482"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Dec 2021 05:04:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 05:04:54 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 9 Dec 2021 05:04:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBOrKHmwFnQnWQWhGYEerxzgtQrSnmzOYIBYPeEsEwWKcEhxrhBNbg7FUQDwpzG036lKWAMVUWy7B0QyLQaXiZprRvG7wfcjtjvW+6i2mg85RC7iH8U+drff+CdwwJ85LIpnyf/fAYSgcfO9z2izINEIXyNtCvMRygeqTRJpPmOeP6109hRDUsHUggZIVkvoxMPkmLoMdhmLXikqSnSfF3uxwW/rFmdTAf/Asc/Hc8AwY42I5an0sTlpnIaQm8a09V5rDk5/zpX+vCFOabO1vQkFDQqmZLT221OG1hB1Tw/3ImJseZ0/v4ZeLNe2brVS8lt1NzQSOr/ab69j9V8oHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K17m8lIgBgNct8OGElizuq9BrgS3VSJVWga6hQ924lY=;
 b=Rk5t5zgyrxM4FBdXPuaslgLBaRypDMePkNUQMiRSbiskKChW3Otsck7BC4PD0W0lKU4OA+W493hRnK+xwSCDaRljSgsh7PT26mmzTgoOH+KAqyi6ne+3qRzlprpRfyqxtFAiW7elZzdtZiMgW4jxKFmG6fRpRLgGNaJ+eKpkXVv+cdUhI1lkdqJ9Kl4DGI48tKKHB2Q5Lx8GsjieTH8DaJxHwx/TEVUW45rl6tCTFjaA57OChmM0WaVb6Mtju5TUPTfgYxHidbI3wTgvPgVNR3xswdxEmwaenNHZoG7uhGPcZ8G6fYoD0XaS6aH36buyEMqHUb4v69QncyKFzO55/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K17m8lIgBgNct8OGElizuq9BrgS3VSJVWga6hQ924lY=;
 b=uBpl4rEd0MZ8cMqTRFo+KJh7jl139zHEK/8ZADnuGUGmlNVyZAI2RhzENdXf9sEI6k8nbnAv/MmcpCrHk9iZPzhWUwQ5o4tLJy9WTEPrEHLXFq+OqpPPyQoz2QcD6wg5neHSRIXXSyPXUg/SXqgfKbPdT7by6StCzBUwk3UrsLI=
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 12:04:50 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::ec81:740d:c5cf:5ad0]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::ec81:740d:c5cf:5ad0%5]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 12:04:49 +0000
From:   <Ajish.Koshy@microchip.com>
To:     <john.garry@huawei.com>
CC:     <jinpu.wang@cloud.ionos.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <Viswas.G@microchip.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <damien.lemoal@opensource.wdc.com>, <Niklas.Cassel@wdc.com>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>
Subject: RE: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
Thread-Topic: [PATCH] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
Thread-Index: AQHX4twBpu9E7jx9w0eTfQRflv+fTqwaU8QggArxp4CAAD4CgIABW1WQgAA/aACAAwOrkA==
Date:   Thu, 9 Dec 2021 12:04:49 +0000
Message-ID: <PH0PR11MB51120361EB6F6931CCE023D6EC709@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <1637940933-107862-1-git-send-email-john.garry@huawei.com>
 <PH0PR11MB51123148E4932FE1C64F8052EC669@PH0PR11MB5112.namprd11.prod.outlook.com>
 <a60318ef-dc19-a146-5ac3-16eae38b8c37@huawei.com>
 <Ya4PAu4Xj8UGHEV7@x1-carbon>
 <PH0PR11MB5112E2E7D00D95F32C86677AEC6E9@PH0PR11MB5112.namprd11.prod.outlook.com>
 <6ee6fe1b-e811-cada-0c18-78149c313358@huawei.com>
In-Reply-To: <6ee6fe1b-e811-cada-0c18-78149c313358@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e551dee9-5deb-4c56-c560-08d9bb0c19f4
x-ms-traffictypediagnostic: PH7PR11MB5862:EE_
x-microsoft-antispam-prvs: <PH7PR11MB58623CF87F940D7812E87298EC709@PH7PR11MB5862.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cs8Zt/Xe5D3H8OrKvJiS2UYyqeF2WvAZGQg+//mbZHfmGDgdrHNhcf3dHe8cO49zSnIF0uvO63h60o84fS2ApRglvqx7ymNePevOtLg6HQ09bCH6/GnlvtYjBZS8djh1Xrrv5fMe7pLjrBLSmUdNCfIe70ePYudPiDDKq46Mfhtd0Do01oAzkAVZj73YFD+OPKhtnZeWCnhEUxWkOcemqqvMtyS2wd/RdCC6FuUrUSKyFkZ98OUUUdLIurF3xgk3NFS0HSRkUOt8VJlLKCClNXeudZRDDOzRT6k7u5hCoWNdiBGISGrToZhXLH0YUPXTLEAHD9mDxXv/Vk/4vkVa1UqZeIb2mo5nCEBt4VSJRuYCtoNi+uDFlnnRrX3FhHJmAmmzk+ueJGgSopyavZYIQV2aLoCWtP2USb1NnsZuYl+UiFyf+2VEhgE2M6qNQ22LU23VDt0qPyg2CSLyPCfNBO098wkGQi89hLTDnUV6+FQLUTkNcmMmU279PaArRYcykyVPr2crNs+RD0ugcju24d2uwL8sKwoLopLCJRT3ZD69MTIq8ZZ3byY//LrIEzsM3UOGZhxyz/AWnd06q13G0D8wMi6Zb/qWIK3jUVfJ9CNrULKNixt0xJITZK2MpUbd8IT/o34xwz1LxHb/04mSgcWTIfUwliM/BK45CmRaF6rRf6MT2QIwo4JCTygmQloXnLMthIhpOIcqLeTPJ0841g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5112.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(71200400001)(6506007)(508600001)(53546011)(66476007)(38070700005)(64756008)(8936002)(66556008)(9686003)(5660300002)(66446008)(8676002)(52536014)(122000001)(6916009)(316002)(26005)(38100700002)(86362001)(107886003)(186003)(2906002)(33656002)(76116006)(66946007)(4326008)(83380400001)(55016003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFlSM2FSZklZRStoUDRWVTlUQzB0Q1hKUEM5VGZGcFBVbU81dEdIYUdYYm95?=
 =?utf-8?B?RXJrc0c3UmM5UnlreWN3S2cxbnZESDNRVHVLTDhsUlpYbFJSRU1xVEhQazA2?=
 =?utf-8?B?WTZMeTZyNTF1akp2a2NpcmVDU2dBNkZMTFZQbzFrYWFqS0Y4OUNwSDJCWXRr?=
 =?utf-8?B?QTc0d3ZpVmZJWHQwbzhxaTRqZ2RPWjlPSTRJdXEwSEg4VzBBUEpPN2xFRi9i?=
 =?utf-8?B?bjNCMVFhZE5LS2RYdFVwZm5jdDVXYkdQVE5yREo1SlZ2alowWFExUWlOdUdx?=
 =?utf-8?B?b2JwVlFaVm5QQnVaK1Fnb2h5ZG5UUU1UcytnZEdSVlUyY2doSjVzdHdiTEQv?=
 =?utf-8?B?dGM0VEFEVUZ6cWMvaUl4MElrVkszV3lTRDc4R051RU9HM3IvVks2ekpxa3pB?=
 =?utf-8?B?ZXBpWDNWejlFQkNkZEoyT0YwNy9JdGZpWTBocElsL001MVk0TmlJMFVUMDBo?=
 =?utf-8?B?MFZjSFk5cWUzUnE3a3V0enNwNU1ENDV1dW9PRzFwUFZLOS9YTFNvM2ZVaE5I?=
 =?utf-8?B?NCtmR292bmpIdU9lU1B3R0lySVpVOUR4U0h5bUloZGJPMGREREdQZm5qL0ZO?=
 =?utf-8?B?MVl6SUw4ajQzT3FNWWVvQzArYTUrNnJ1RG5iRUY3SzNaVElORmxwY25lRlh1?=
 =?utf-8?B?OVFiek1hQjhKWG52NUY3STIxODUrUk5YeUVML0Vnb216ZnNpSmJIcEhCbitD?=
 =?utf-8?B?MEI1TVYzTDBWZWpzWHZPUGQxUk9FSXlsaUVKc3hJbDROR0RkVTlYMi9heUxN?=
 =?utf-8?B?SmpmUm9QT2x0eW9mc1ExTk1QZnJPZCtPRkdESEZCdzlsRnJtVVlqclo2THg5?=
 =?utf-8?B?TkNaZnU3VWI0T3k1MmJyeDRoMVVEc1ZGbFBsNHNEcVdzRTJkTkNMbi9nMy9W?=
 =?utf-8?B?ck92RWxvdlNyQjI3a1pjRTdublY0RzlUK2l0YWxMcFVmK2RZVHhWQTBTbzBH?=
 =?utf-8?B?S1lWK1hjaFZqMXB2YjdIVVlZZndYaGtlYm02ekk4b0NMaEZSTGd2VGEyUFhF?=
 =?utf-8?B?REpIT21GTHdPSDEyUTVMRG1KUE00eGEwQUlUazRyWVo1WFFtdWRKVUZYL1o0?=
 =?utf-8?B?OXhJVDlZb2RZdEJSV2RVZGxqblNicXZEd0czUlZZdEZJNGM1cENKUnJTcjB6?=
 =?utf-8?B?RkhubWUrdGp2ZkFySmZTMkZ0UExvNWNHdkFTYjVid0xKTHAxU2hRYUYzUjlw?=
 =?utf-8?B?ZHVjZkE3Zk1lS2x6ajhpUTZyZjBVc044dVB0N3B2WDlBYUhwWC9EcmFKUmQv?=
 =?utf-8?B?eDM5d2w2RHMzUUhWZkw3bHNrTUw0TnNmV0dtUkx4ZisxS0lQTjFQa1RqZ1k0?=
 =?utf-8?B?Y3FHN0V3Rm8ySVA2ZGIxSTlzeXRVc2VVOWtCNWNvejBHZFhPOFk5ZWhVTFBh?=
 =?utf-8?B?ZGhtOTJCeXRjbEFuRG9HdjJ4NHVVbHFYangxbzM1bXhER1M3bnFXOCtSZnFv?=
 =?utf-8?B?WHFDTE8wVWR5Ym1mdlRCYmloZmw4YUVoMHhaa0huYWFidTEzeWFrSjIrZ1N0?=
 =?utf-8?B?YXllc2tFYWZDWFhzVTZBWDJOVm5GMS9EUGE0aW1KTGtML1lPUHNJdG5CNnVV?=
 =?utf-8?B?N1dhckVzcVhielBXU0lDam5IaS91UkpDbFpQRktmTnlrVm12MmJFbytad2hi?=
 =?utf-8?B?QzBtNkJERFdubnJXdmdjTVZSbGlxK01xdHQzaGxFTEE2bmgvUnFRV0V5WmhE?=
 =?utf-8?B?NGVQZVl1N1lsaUgzZWc2THhTNUdrSGZGVmovMkV1OEdCaGZVdjFucSs3NkpD?=
 =?utf-8?B?NzBkdm84aEZHWEE4VmJkRzhOTzQyc3dqQUZjYmZFcGZsWUxZTmx5eEVTZFR6?=
 =?utf-8?B?a2d6ajRycHo4SngrYTlibk12WVBxYUQ4QlQvNDhtUXc5Y0MvVXVUSzBCRDFq?=
 =?utf-8?B?LzRkL2syUExId25XT2FZUUNCOWkxdkc3anVPb3ZCaG54Z0JaUnZnNHRCTG41?=
 =?utf-8?B?ejZ0R29DT2tTTk9ZOVI5bSs5QnRwZEFHWmV5bWRFN1QvbndKQ096OWxXOFdo?=
 =?utf-8?B?M0FyV005WmNVdUQxN1ZMVnJPbklqVW9qQ1A4VnR5L2pKWGt2K01ydVMzczBq?=
 =?utf-8?B?ZG15NkZ1NzJKenR4aVFjdkovczd5U1JRbDM3bDJhTWprNURqWFlCMDVRT1RP?=
 =?utf-8?B?S1Z1VldBRkt6MEl1VkRDYzBsNDA2QU02aGY1QWZYak4rdkxueVNHNVREcHZG?=
 =?utf-8?B?dHZmcHRKNkhqcTBWZ0J5UFZzVW1wVmp6cFJYSWdFRU1lMkx3c0trZVBJb2Uw?=
 =?utf-8?B?MGVnR3k1SHVVU0NEK2tkUzEvbk13PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e551dee9-5deb-4c56-c560-08d9bb0c19f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 12:04:49.7984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbe64XT9Qnvo14d3xFEaVs4jsWlLlOlMV6D/gwlNPC4hRnnEQRhpRHDuHRDhGZI3yvofDVbWDiJjMl72e5UNnrtxwJSTk2vEZHVCRzHaiCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5862
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9obiwNCg0KV2FzIHRlc3RpbmcgdGhlIHBhdGNoIG9uIGFybSBzZXJ2ZXIuIERpZG4ndCBz
ZWUgY3Jhc2ggdGhlcmUgYnV0IG9ic2VydmluZyB0aW1lb3V0cyBhbmQgZXJyb3IgDQpoYW5kbGlu
ZyBnZXR0aW5nIHRyaWdnZXJlZCBmb3IgZHJpdmVzLiBCdXQgdGhlIHNhbWUgY29kZSB3b3JrcyBm
aW5lIG9uIHg4Ni4NCg0KQXQgeW91ciBlbmQgZG8geW91IHN0aWxsIGZhY2Ugc2ltaWxhciBzaXR1
YXRpb24gb24gYXJtIHNlcnZlciA/DQoNClRoYW5rcywNCkFqaXNoDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+IA0K
U2VudDogVHVlc2RheSwgRGVjZW1iZXIgNywgMjAyMSAwNzoyNCBQTQ0KVG86IEFqaXNoIEtvc2h5
IC0gSTMwOTIzIDxBamlzaC5Lb3NoeUBtaWNyb2NoaXAuY29tPg0KQ2M6IGppbnB1LndhbmdAY2xv
dWQuaW9ub3MuY29tOyBqZWpiQGxpbnV4LmlibS5jb207IG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUu
Y29tOyBWaXN3YXMgRyAtIEkzMDY2NyA8Vmlzd2FzLkdAbWljcm9jaGlwLmNvbT47IGxpbnV4LXNj
c2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkYW1pZW4u
bGVtb2FsQG9wZW5zb3VyY2Uud2RjLmNvbTsgTmlrbGFzLkNhc3NlbEB3ZGMuY29tOyBWYXNhbnRo
YWxha3NobWkgVGhhcm1hcmFqYW4gLSBJMzA2NjQgPFZhc2FudGhhbGFrc2htaS5UaGFybWFyYWph
bkBtaWNyb2NoaXAuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gc2NzaTogcG04MDAxOiBGaXgg
cGh5c190b192aXJ0KCkgdXNhZ2Ugb24gZG1hX2FkZHJfdA0KDQpFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCg0KT24gMDcvMTIvMjAyMSAxMDozNiwgQWppc2guS29zaHlAbWljcm9j
aGlwLmNvbSB3cm90ZToNCj4gV2VsbCBJIGNvdWxkIHNlZSB0aGlzIGtlcm5lbCBwYW5pYyBbICAx
MjYuODQzOTU4XSBSSVA6IDAwMTA6cG04MHh4X2NoaXBfc21wX3JlcSsweDFkNi8weDJlMCBbcG04
MHh4XSB3aXRoIHJlc3BlY3QgdG8gZXhpc3RpbmcgZHJpdmVyIG9uIG15IGN1cnJlbnQgc3lzdGVt
IHg4NiA2NGJpdCBhZnRlciBlbmFibGluZyB0aGUgZm9sbG93aW5nIDIga2VybmVsIGJvb3QgYXJn
dW1lbnRzOg0KPiAtaW50ZWxfaW9tbXU9b24NCj4gLWlvbW11LnBhc3N0aHJvdWdoPTANCj4NCk9L
LCBzbyBpdCBzZWVtcyB0aGF0IGl0IHdhcyB0aGUga2VybmVsIHdoaWNoIHdhcyBqdXN0IG5vdCBl
bmFibGluZyB0aGUgSU9NTVUgcHJldmlvdXNseSwgd2hpY2ggd291bGQgYmUgY29uc2lzdGVudCB3
aXRoIHdoYXQgTmlrbGFzIG1lbnRpb25lZC4NCg0KQW55d2F5LCBwbGVhc2Ugc3VwcGx5IHJldmll
d2VkLWJ5IGFuZC9vciB0ZXN0ZWQtYnkgdGFncyBzbyB0aGF0IHRoZSBTQ1NJIG1haW50YWluZXJz
IGNhbiBwaWNrIGl0IHVwLg0KDQpJIHN1cHBvc2UgdGhhdCB3ZSBzaG91bGQgYWxzbyBoYXZlOg0K
DQpGaXhlczogZjU4NjA5OTJkYjU1ICgiW1NDU0ldIHBtODB4eDogQWRkZWQgU1BDdi92ZSBzcGVj
aWZpYyBoYXJkd2FyZSBmdW5jdGlvbmFsaXRpZXMgYW5kIHJlbGV2YW50IGNoYW5nZXMgaW4gY29t
bW9uIGZpbGVzIikNCg0KVGhhbmtzIGZvciB0ZXN0aW5nLA0KSm9obg0K
