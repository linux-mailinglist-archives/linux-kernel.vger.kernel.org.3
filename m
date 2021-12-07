Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FB246B29F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhLGFw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:52:58 -0500
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90]:23651 "EHLO
        esa9.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhLGFwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1638856165; x=1670392165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FzkjOvWKZbz2Vl7VWRn+oUqJPobqjOPwCCc+q+2zwlw=;
  b=B7bg7HoBLNRxMPQ5YoWtPKEjPAoAas0uyv8VYN3s6o2TpVDyfz9o/hkY
   TTuHDSkKC/pK8etHSceEPVZrUnzlxyxsksMQm1Ud/xIlElEuO1IAu7Ane
   e3Z3tWpdPyGkMB/U84KxyDcbuEJai0at5Q0Cae37A5ATEO+l+3mSNwdoW
   5OsAiWmd/drL11ItS88wx1xzxKGYi9fQC9DrkopVOVqFAhRafeERKQ17I
   gmpPmjdx89F2nGdgBMkDHdy8L1dm4b+nDXUITMRBhF0fRg+qBcZlhn4s1
   5WwoM/ViGfkPdmRLduzYUeN1rpxu2YUe6bIz9QTRq95cMz3gkX663EsCM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="45449711"
X-IronPort-AV: E=Sophos;i="5.87,293,1631545200"; 
   d="scan'208";a="45449711"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 14:49:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSTuAw4XBNBF+J0RiNc4LgGl91OzYNyQprWWR53XvouqJPt1oLkI87Hwvk+X75G0fySNKH5VrsVx+dOkpeeP1MZq/i2MDOsVZr/Kwrqtck0/crKajG/VsSQkE86NQ8fRX5RtaoofJmxSsX2eiTVtY/8D7qB/EcEI7IxK9mw1ON74HClrCXi4i0ZaVZwbBQ2EaV2fLJqFdf9SCqghUUmnr9cqHN3WfS5ctyY3Sb1b7QnXmxHW0bH2yZRITGyOS2LsQoxNtQYto/Mo8Uo2KO5Yx4y7oj8788gLSu9mFhSfMBNg/IGW8jJFyTJ1ETS2APv2Y3pNeRvjldz6iscioDRXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzkjOvWKZbz2Vl7VWRn+oUqJPobqjOPwCCc+q+2zwlw=;
 b=mdDSeGsKXjyHLq0fbOMnpCpNtRZSYGiljxC1x0rL+P32tmHSw/LWD77Yaz0ygawf5qsYflv9F97M0IBU9R0XDiWScJxe58Yd8Km+XYWHX9sxXM/67E0VHJC3u8rMKAU7egLjkL1fRlGVp31PKYD9f22YQc3jP6n9MYre7JeD+QowtMi6blYGbjJtgFh1USfmbxH17hs7zYkm27pqlK6NaVh6GUT71ud9WK0oQ+DsWvscz6j67fLsl4aFbtaNcMCbZs5qp8mVxlehhPiAUzHmemAz5kgguh0QqcW+98C3lR862rvSP+Vk2jSzObDdpacTzn+0Q4gKn5HrfBy2g17QZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzkjOvWKZbz2Vl7VWRn+oUqJPobqjOPwCCc+q+2zwlw=;
 b=e7soVVfKezXyvG5qbLID1gpE2hO6vs/1gLs+Eq09MB5aXurPGedoti/v53reMPYY2KHrOWBwsrCJzppWQtjRQEVw0UvKetmhJzbcmbFX+xNkDaJPPl7QV/PehzBu74qJEWnQpdTsL67rlAQ67FoShxPdm3KusObQJLxOlidWU6Y=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSBPR01MB2472.jpnprd01.prod.outlook.com (2603:1096:604:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 05:49:17 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::2c38:ad18:39de:3042]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::2c38:ad18:39de:3042%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 05:49:17 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: libperf: lack of interface
Thread-Topic: libperf: lack of interface
Thread-Index: AQHXnxU1v7C7yDhEy0Gzl7rxTcNZhquPLp8AgAE//ACAHexCH4AqXPW2gANjt4CAArnVuoBCHup+gAYl4Rw=
Date:   Tue, 7 Dec 2021 05:49:16 +0000
Message-ID: <OSBPR01MB46003CB99B9AAC0A574D341DF76E9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <OSBPR01MB460016842A4310264B1CC5A0F7CD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YS+B6PVHtiTmqZS+@kernel.org> <YTCOVGyffe+VwL6G@krava>
 <OSBPR01MB4600E7C8C79D64125270D034F7A19@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <OSBPR01MB4600A616AD3341EAF6AA3DE8F7BC9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YXAJhTC9aqOS/GWy@krava>
 <OSBPR01MB460067F4CE80D8EF6B707D4CF7809@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <OSBPR01MB46002D1F64E2349CA9E742A4F76A9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB46002D1F64E2349CA9E742A4F76A9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-12-07T05:49:16.312Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: 4cbeeb21-f494-c85a-26ad-f9effdb6fefd
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2b129b1-fed3-4fee-07b3-08d9b9454e87
x-ms-traffictypediagnostic: OSBPR01MB2472:EE_
x-microsoft-antispam-prvs: <OSBPR01MB24726E6A4AA17B283A3FAFB4F76E9@OSBPR01MB2472.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O4DuLHD7LdvNDrBQ8Z2DYxycqwtbECBbaCQ13deHp70degYTPtDAOYCkfcNBxtxJ3+klzMtBRqMgYEoVPHz+dsXR5G0NmpaLHtR3brbR+5Ij/5suQs99KwNbKG4k58fc1/0nBAtbPIjnrREIhrkh/ikOrYBKbAkaC/GV4YQM92pi4Yc0+Bkgib9FWWpDJFkke8oqpAr8hXWZubg/n8VMsHP1QfbhuhRXqUZ5X3HlAqSjn+SwV/5ZUQf80FEpCMxJ6i1DZeT+18w1jVR5PNRFshYxFhEGUfcV2gufwTzkafDdAVxvR4tiwNRmEpw6ptpfUeBY5F6QKOjnYeebMtW/TFCleCwsZxVmW1k1471DaDLgE1eoALE7BSt+UImnI7Q1q5tz+bUFeI/4krbRqtLTbrsPKiyxBCSCqmfA0Z8Hdxh/WkJvwYV2oHY6Pw38dAs/obCOlG0DsSnf5H2Bp8HebpmAH+YDKE7Qi458sZhGLmYo3hnFXZ+uC4RTKdnBGy0LS+IVA939avMtk1tfVF5Y4Wqpu4FUWdz1jmAHv7wLfgDLThDVAW3Lh2TeyRlbgVyKe4OnA1nmw5wTpxdSLcmPEn9Q9rtKFIGXLZW6KVjVIZDMd2HubAvGvGysJ7oo9CvrmTWaZ3NDCkQIwIDOr4tjUO9Kp5o7XLMjaBZdfBQm4ynFsc//t2mCgyOPTc++Hfs+y5XoSecs1FOo90c77ICtQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(26005)(8676002)(8936002)(83380400001)(6916009)(54906003)(66446008)(55016003)(64756008)(186003)(122000001)(9686003)(38070700005)(66556008)(66476007)(7416002)(66946007)(7696005)(91956017)(76116006)(4326008)(6506007)(52536014)(86362001)(5660300002)(2906002)(508600001)(33656002)(85182001)(71200400001)(316002)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEdqRTMrbjNaSzgvZWQ5VWsrZjhuNUIrZy9ydUdoNVJEYzZ1aHZibEhaRHZ4?=
 =?utf-8?B?dlpvQjlYQVVRUTZaWnZER2xBRjJXajU4eERGQ0hZbHNEb0M2L0FYcENCMzcz?=
 =?utf-8?B?bHJDSGRhekRwRlpUZmt3RWNuZU84SHQvQzNyR0tHaS9Xdzh2ckJrNWhSNTZF?=
 =?utf-8?B?VWovZVpsL0VWRFJBYlFybUszSzMrMTJKNzd3cUs4Tjk2c2NpUGM5RU52VG9L?=
 =?utf-8?B?ZENvMThtN0NhblNHNHFkUUxkSFRSRWxqd29FZWNmRFVpK3dPM0g4c2d3OEcv?=
 =?utf-8?B?bWRLUzd1NG5IWHBWd1pyWU9qTVBNUXh3UGxtdGE3M01nVWZ4ZTdTQTdvNkJx?=
 =?utf-8?B?dVZqQi9ERUhtQU1TUUlOcUxwWTZudmRTblJ2dDE2dDBiL210RmlKbFdqMDQ5?=
 =?utf-8?B?d0ovVk4xdVVRRzFaMFJqeXRCVmJxc1pDY3BETVJzVVhhQjBZc1FsM3JoYWY2?=
 =?utf-8?B?R0pJaDZIelVvSXk0SGFrdllFdGxmdHoyYzFZNi9QdFhGVUFXRk9IUDYvMlBl?=
 =?utf-8?B?VDlmSFczM1c4ZmpZT2FqL0RtZERKZjkvMm9UNmZhMWN6NDJNOTl0bHVPOHNm?=
 =?utf-8?B?WVQvZVFaS2RkU21Hakd0Y3JhSUJkN2tTWERwS0JQSGhXYTZkWDFyQVlKVXlh?=
 =?utf-8?B?MDEyMHRTeFc1Q3ROVWdpbS93THgvdFhNTGNzaU9RMWkvOWtaclg4Vmh4NFZs?=
 =?utf-8?B?N2hWRjRTSkRxTWxhcnkxczNGdm1ib0g3d2hOc3BCL0JhL3UyZHFMVFFEcTl6?=
 =?utf-8?B?RUt1cTdzVHhueVVCUGYrYmFxN0RzTnhZaEtTSlBlYW53ZWlKZXZNTnBJWkVX?=
 =?utf-8?B?M3N5b0hxZVZVaUtrM3VXZ3Q3R1lINWpQVWlCZll1d2NyMWZid1UwMEVicGJ5?=
 =?utf-8?B?THFybTVSNEtCZFh5MitWZFM0c0hUenA2NmpKVXNRYnJYb2JyenZlKzRuUlh5?=
 =?utf-8?B?bFdJazdnMXNUS1pmNEcrVy9yYmFNWlpmOFRDMnptdFlOV294bmduY3NDdXZV?=
 =?utf-8?B?OTk0OTNYRUs4TjVyUjJCM1NkRjRWYm9wZ0d0UjFIZUlBSGV4dkoycG13aGhY?=
 =?utf-8?B?T2dIa1dNR3U4NXE5NzFtb2h0RXFra3VDUTluTlJMQ2hFYjNLNHlVc09hWk8y?=
 =?utf-8?B?Y0pGRU5wMUUrNzFPTnR2UTNRRWcwZjlxelp0REZKR050bUtEWVNsZE9EY2hr?=
 =?utf-8?B?bHo4YXZSSEVXQ092Wmt6WnFaaEUyYmxZTTVVVm9qSmtGZXZVaVg0TXJpMHRm?=
 =?utf-8?B?RzRER0s0dUM1RHJzZnJ6V3d5dThJTG8xVVlNWkJqc3BnSWZpREw5dk9wUDY3?=
 =?utf-8?B?eW5rRi9sRHVyeVZaN1FrenJtUkszdWRvaGIvb21tNTBKakVOL1ZxeExza2xW?=
 =?utf-8?B?SjRYeWNXc211TTRTSXQ3cCt3aWtkZ1JBWk96QWZWbEppQ2JyUzlyMU55V2Nh?=
 =?utf-8?B?LzA0QWsrcDVaeUltbzFacXNzaXJITTN0OW4zRUxIRjJOYVhEL3pzT3N3dDhs?=
 =?utf-8?B?MHFHR253Vm9ncERjSFdEU1FDdkREZitWcHlvS1pqUk5OMmJ2Ym42RHVidnNa?=
 =?utf-8?B?MW56VVovWWlvVGlKS2o5b2NkSDNuUDFrZjlnQkdGYko2RXpCMEN4bUNySGJp?=
 =?utf-8?B?anYvUGh5NmlHRStWNHU5a3JHL3ZVNVpYcXo5WDJUa1FINk5wNnFramNlS0ND?=
 =?utf-8?B?eW5QRHFnYzdHTjh1U3ZNZUs5SXEyR0srelZZR2tBVStGQUFvck52R3dRdVRI?=
 =?utf-8?B?a2JkVExoR2J3TmtLTHQ5WXhvbTZEcHdrMmF2WUxSVk92S0x3YSs3TTVNcE5L?=
 =?utf-8?B?Q2cxdjFvcjk0TS9wSkE0eitPNm9aL1JSTDdDN3BsQkRSRnI1WjlPSFBSWmw1?=
 =?utf-8?B?OWd6MkF3cTQ4YXJESjFJOGZ6Y3l3Vm41SjNXeUE0Y0JTa2dkS0ZYWXFrRDQ3?=
 =?utf-8?B?ZFpmQXM3T1pJd3Z6K1NNanpudlJ1UlVsa2tobTVZbUVmeHFyL1UyVkZwUFBN?=
 =?utf-8?B?eDFKMW1HVnBOUU5DVkxSVUEvOVVZQXBmOU8xekhId0ZxNHZwVjdLR1NLcU1I?=
 =?utf-8?B?RlFiem9UclhJeDVHczRFUUdwSkI3Q2F4RTh4bjVPWmdPbUd4dTVVaXV3RFJK?=
 =?utf-8?B?aDhrS2xoeHZzb25wbkpxcmlha0ZTOWFGeXJjeWtEamV4T1d1a21WQWZ2bUw2?=
 =?utf-8?B?L3JzWW9OZG5rd04vTGY5NnAxTDNkV2tyV05nTUZxL3V4T251bjJlMHdlQlA1?=
 =?utf-8?B?MEhvN29jbEE2NVNGcUVhRXhYZDFRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b129b1-fed3-4fee-07b3-08d9b9454e87
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 05:49:16.9700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dLTUlA/a9JMpvDjiaMEU6V3D8QZdPoisi4svTAl8xpdfT+kMxXTrzKyyzqZwvAaOcMdl7aHDgVFaDxfSMwKYLfNwxqB5BN2Ngn+KC0nb1kU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2472
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgamlya2EKCj4gPiA+IE9uIE1vbiwgT2N0IDE4LCAyMDIxIGF0IDA4OjU3OjIwQU0gKzAwMDAs
IG5ha2FtdXJhLnNodW5AZnVqaXRzdS5jb20gd3JvdGU6Cj4gPiA+ID4gSGkKPiA+ID4gPiAKPiA+
ID4gPiA+wqA+IE9uIFdlZCwgU2VwIDAxLCAyMDIxIGF0IDEwOjM2OjQwQU0gLTAzMDAsIEFybmFs
ZG8gQ2FydmFsaG8gZGUgTWVsbyB3cm90ZToKPiA+ID4gPiA+wqA+ID4gRW0gV2VkLCBTZXAgMDEs
IDIwMjEgYXQgMDk6NDU6MTBBTSArMDAwMCwgbmFrYW11cmEuc2h1bkBmdWppdHN1LmNvbSBlc2Ny
ZXZldToKPiA+ID4gPiA+wqA+ID4gPiBIZWxsby4KPiA+ID4gPiA+wqA+ID4gPgo+ID4gPiA+ID7C
oD4gPiA+IEknbSB0cnlpbmcgdG8gY2hhbmdlIHJkcG1jIHRlc3QgaW4gcGVyZl9ldmVudF90ZXN0
c1sxXSB0byB1c2UgbGlicGVyZiwgYnV0IGxpYnBlcmYgZG9lc24ndCBoYXZlIGVub3VnaCBpbnRl
cmZhY2VzLgo+ID4gPiA+ID7CoD4gPiA+IERvZXMgYW55b25lIHBsYW4gdG8gaW1wbGVtZW50IGFu
eSBvZiB0aGVzZSBsaWJwZXJmIGZlYXR1cmVzPwo+ID4gPiA+ID7CoD4gPiA+Cj4gPiA+ID4gPsKg
PiA+ID4gLSBJbnRlcmZhY2VzIHRoYXQgY2FuIHJ1biBpb2N0bCAoUEVSRl9FVkVOVF9JT0NfUkVT
RVQpIGZyb20gdXNlcmxhbmQKPiA+ID4gPiA+wqA+ID4gPiAtIEludGVyZmFjZXMgdGhhdCBjYW4g
cnVuIGZjbnRsIChTSUdJTykgZnJvbSB1c2VybGFuZAo+ID4gPiA+ID7CoD4KPiA+ID4gPiA+wqA+
IGhpLAo+ID4gPiA+ID7CoD4gd2UgY291bGQgYWRkIHBlcmZfZXZzZWxfX2ZkIGxpa2UgYmVsb3cs
IHdvdWxkIGl0IGhlbHAgeW91ciB1c2VjYXNlPwo+ID4gPiA+ID7CoD4KPiA+ID4gPiA+wqA+IGlm
IHlvdSBkZXNjcmliZWQgeW91ciB1c2VjYXNlcyBpbiBtb3JlIGRldGFpbHMgd2UgY291bGQKPiA+
ID4gPiA+wqA+IHNlZSBpZiB3ZSBjb3VsZCBhZGQvbW92ZSBzb21ldGhpbmcgdG8gbGlicGVyZiBm
b3IgdGhhdAo+ID4gPiA+ID7CoD4KPiA+ID4gPiA+wqA+IGFzIEFybmFsZG8gc2FpZCBiZWxvdyBp
dCBjb3VsZCBiZSBhbHJlYWR5IGluIHRvb2xzL3BlcmYvdXRpbC8qLmMKPiA+ID4gPiA+wqA+IHNv
bWV3aGVyZSA7LSkKPiA+ID4gPiA+wqAKPiA+ID4gPiA+wqBBcyBQZXRlciBzYXlzLCBJIHVuZGVy
c3Rvb2QgdGhhdCBmb3IgcmRwbWMsIG5vIHJlc2V0IGlzIG5lZWRlZC4KPiA+ID4gPiA+wqAKPiA+
ID4gPiA+wqBIb3dldmVyLCBQQVBJIHJlc2V0cyBpdCBleHBsaWNpdGx5LCBmb3IgZXhhbXBsZSwg
YXQgUEFQSV9yZXNldC4KPiA+ID4gPiA+wqBJbiBvdGhlciwgUEFQSSBhbHNvIGhhcyB0aGUgYWJp
bGl0eSB0byBjYWxsIFBFUkZfRVZFTlRfSU9DX1JFRkxFU0ggb24gb3ZlcmZsb3cgdG8gY2FsbCBh
IHVzZXItcmVnaXN0ZXJlZCBoYW5kbGVyLCB1c2luZyBTSUdJTy4KPiA+ID4gPiA+wqAKPiA+ID4g
PiA+wqBJIHRoaW5rIGl0IGlzIGRlc2lyYWJsZSB0byBiZSBhYmxlIHRvIGFjaGlldmUgc2ltaWxh
ciBmdW5jdGlvbmFsaXR5Lgo+ID4gPiA+IAo+ID4gPiA+IERvZXMgYW55b25lIGhhdmUgYW55IGNv
bW1lbnRzPwo+ID4gPiAKPiA+ID4gSSdsbCB0cnkgdG8gYWRkIHRoYXQgZnVuY3Rpb25hbGl0eSBz
b29uLAo+ID4gPiBJJ2xsIGNjIHlvdSBvbiBwYXRjaAo+ID4gCj4gPiBUaGFuayB5b3UuCj4gPiBJ
IGxvb2sgZm9yd2FyZCB0byB5b3VyIHBhdGNoLgo+IAo+IERvIHlvdSBoYXZlIGEgc3BlY2lmaWMg
cGxhbj8gCj4gSSB3b3VsZCBsaWtlIHRvIGtub3cgdGhlIHJvdWdoIHBlcmlvZCB1bnRpbCB5b3Vy
IHBhdGNoIGlzIG1hZGUuCiAKSSB3aWxsIGFsc28gdHJ5IHRvIGltcGxlbWVudCB0aGVzZSBpbnRl
cmZhY2VzLgoKQmVzdCBSZWdhcmRzClNodW5zdWtl
