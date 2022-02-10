Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282194B03C2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiBJDI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:08:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiBJDIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:08:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553961EAD1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644462533; x=1675998533;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4zTKWLRyIK0f6cUmFREmXE8hoWO036KfYqS+7AylIaE=;
  b=dp5KkS4jvLXk0C4a1hMAWs/FCD1shwAAD8D4H19dcBx2SAeBrBwkwIn4
   UpKdxhpjM5HXDsgIkZXSLUdZZ8KHcFzYr9h0rEPuUAYREYucfRl3x99NN
   mh2re2/eodV4/7QJGJcENTAtse3k/FAQPixK25EzpQ4BHaT7yQPQRN4HZ
   A4tX+YfEaV5ZG5OQ/3LYxVLKeNe/fllHHvSOtx7IzdznykcKhnKXOjYCU
   qxKMGv2+wY7zIds1izm7gD3ioqfWYZea2hVNHsA9DzzBrxHuQI7eEvqhh
   q7jF9yJYdHX9Nw50b1dSK0Quvy7EwRVgzvHglhyiXWHerSmRllGR4InjC
   w==;
IronPort-SDR: 4Q4u/hodyJAhNyR/4XktrOZQADfpqWUcpIvThCFEZPzyx4oXvTRqLvOKDrUvbCAVLMQoDRKyia
 p1u+cwfXv6tFu5VrzZLX7SrTw5UuBGMSh1rZvH5OVJ7it2CQD/yPVfbkWlcqV77WedKhcJttB8
 C0Ej6J3g/iZIu3vojftJ21nfJUy8paWW7wIwedi+XQZxW/s0r6V3QFMdvjP+QgNJfc2cmHouFi
 EAYElUp3gbKgDmAV45Ko4kVWmOB4ij3FZZeBQSamHC8IB4GzwUMLkGVNYdzuqxh7pa/aSZOa1+
 R5xKK2rNSvaCmPwhFRG2C0QA
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="152556500"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 20:08:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 20:08:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 20:08:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evlVp3wDmXiS/cUuFtYrahORPYe9BiqB9lrdiSht4del0P4NnLBiEHXjq/QNtXh3GfgDpX6bmvKKmHseK83ti/iYaF8MuLGqVcTtcG4/5+cGgXmX0QXrbQa3zyOwwMBPLwLXFMErlet6hA/Lxl+0uP/XHYVLhfUHMUeuGAfAs36+2kEdob5Z0rMyEUGEUnLh1OLAUM+KdtlWlYG04qwil1bpshEK/945YQHnbQRxFV5qZpAMQWChaF1mDBEINbaVBHeb4xi/SERiy4LmKasm8t/aGr7U5ahpC0CXmrde8WzQsoqyN1OPAsr0jZLxR5V2o/bs8/mn6Ho386Cq7Wl3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zTKWLRyIK0f6cUmFREmXE8hoWO036KfYqS+7AylIaE=;
 b=kH8OlNfgd5dsxjMwnrsv7NigKv1Mm8QCKWtLJEnHdffhiUqrh7hn36eu15Gjis9ooZ1TqZmwrmotHPr2+NBdT1hBCpZqHOULAT8W/9YeM9Tund9BQrRj1XlyNPpoOLzcoYsVm6bi3z2ttvaAkH2DpJmlCkl2yln0aHoD3tgYMJQyTm7YbWUI20IxHDSC2QwhaMe6Aizjlgr+wpbhxm5g9sUl+xQrAF20YewCsxydVMz9nlzgmWcnawP4AK/ORBsYz+CastKcTOF48fEJOX5Rz1mQTy8kiONxfx8Njdxveg6mPK+wA806X9Bw1mAz4XJTw70OhHwRZ9eiCbTLyQi+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zTKWLRyIK0f6cUmFREmXE8hoWO036KfYqS+7AylIaE=;
 b=Bf6jmwY7l0IevwMdanCjn4n6gVsqIDfFH4nXL8PDENMAawiAFDqwmmD5bezvmSj/5Z6FPsmlf5TGzYn/7WbP6wAwiene2LwKu33alSybpvB9v99ioBPNmayYNZ++5lA8dCCDX6MdDjUxVNV59eArIWaURR69o/hvm9iyFsGTcaY=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BL1PR11MB5255.namprd11.prod.outlook.com (2603:10b6:208:31a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 03:08:47 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 03:08:47 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v1 05/14] mtd: spi-nor: xilinx: rename vendor specific
 functions and defines
Thread-Topic: [PATCH v1 05/14] mtd: spi-nor: xilinx: rename vendor specific
 functions and defines
Thread-Index: AQHYHiuFz8+evF2o8USFiXwNjUvH0Q==
Date:   Thu, 10 Feb 2022 03:08:47 +0000
Message-ID: <68aa414b-7a9d-1330-531c-37b2db2ab09d@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-6-michael@walle.cc>
In-Reply-To: <20220202145853.4187726-6-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 478ad986-fd04-4e28-bf5a-08d9ec42a7a0
x-ms-traffictypediagnostic: BL1PR11MB5255:EE_
x-microsoft-antispam-prvs: <BL1PR11MB5255AE80CFDE5ECFB32117E0F02F9@BL1PR11MB5255.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UjR+FX/+C0R4s+74R96g0w8/3r/oYF61A6UC5coX62JSTMZ9I8Ee9/cV+1OK5jkAaB3DQxB3UmYyq86vyXlV0ylmFrHYucTCxQdxu99mc4GfRiTmPgcBhbyjAsnL/ePessBHxHyQR1iMUXvF9OKDSoTZ594Ak/Y9ggzzF+RX/aZmPci9Tjiwvci6Er3PIl9KIfqwvGk5Y6fyy5wVg74C68xsNLbLHuvhrNNt7X500JrWBDQtMHVdfQMRR7tY0NzwC2oKo9MHRY9anL8wN9yAyI3Eh0rPIw0UTGSHJ+wRB8Bwf0Jmez9gr+YdIKxIzm0HNp+qdm+qrpJb3KGssVjez6Aw77dS6XsrocsfKU0iUAcrArU1ytv+le4qeeDcLXFBHceAB5UV0n798PL4x+UXspj16l7vYU69NduWuErDfcIugidjBYPaoDHguTNNAfgyFNxjipWesWm5eo7ousp9xk2K+e/rhB7VPK4aMmN0ylcYK/mr0JihrNpoz54cy0Nw8mdLeEq79L6lTQ1XgEH+j9vw+7I7RKJUSrynRp3rkMSCaLcaGTUALVtWXnAgFxMYkldJDThWfZTlvunBJ22AeDVefPMNTBA2Pia/ceSMThlfWUKIopakau3vUoPMS7jIrxSEnmuLt2g7xoJ2g1Y1GEZxBRX47ArUGJjlZGteyOp4MGP/DJrIKjaG1KAdbDU3yVxQZjEpiAdvzNveUKeWNyMXbgigcXnBcqyeIVDxk5OECSYwfc/Z4M4yGNgCd97D+6DXRQ/Qilf453GmqVTtsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(6486002)(54906003)(83380400001)(38070700005)(76116006)(316002)(26005)(2906002)(186003)(2616005)(110136005)(31686004)(122000001)(8676002)(6512007)(5660300002)(86362001)(508600001)(31696002)(66476007)(71200400001)(64756008)(38100700002)(36756003)(91956017)(53546011)(6506007)(8936002)(66446008)(66556008)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTVmWmFXejN1d0lUcHFlblZRT0R2eUd2aVNlaXV4azA4cjV5Z1IxbUdlWFBK?=
 =?utf-8?B?UkFSZnRFWCtLQWZ5SHVmZ2V5dTdnTkI4WTlXRk9YU0Y4ajR0dll4ZmRZRDl3?=
 =?utf-8?B?bGJRWGFnWDRxbk1pZDAzeXlSUzVtYW9Kb3R0R0dHdG05RHB5OHErdXpudFFi?=
 =?utf-8?B?R0RXQTh2d1MxeENnUGpTTWF0NjVoVW1LdlJvSVlpU0gwZkpVckJNMDd4MFh3?=
 =?utf-8?B?YURsSGNLQUkzVE9YTGM2djFxZUtwQ2ZUQnpKdnd6YkxEcUUxNXFucXR2QnZ5?=
 =?utf-8?B?dDliOHhLN0FId1ZTWHcrWUptMklLcmNKRWZ6U0dQVEQybXNZZmFkTjVvYm4x?=
 =?utf-8?B?MmpoR0huT2tXZDJpZC84OHBSbVF5UktHNW5XenpBc1RxaW1tK05tdG02VmU5?=
 =?utf-8?B?dEFBNkxZRFBMSUdIb1RNYm9nRzBlR2ZIYmhoc3RJMUdwMmtkb2JnRzNnSGxB?=
 =?utf-8?B?WCtwMVA5QVBBUXBkWjdtYTVtNEhOc2QwKzRHL29wZURMVXN6bll2NjAxVFhi?=
 =?utf-8?B?V3pDWlo0SmJYcHBTNlFndU9jRG9ScVM1T3BxZk9NalliYVF0d3Z6OW4wSmtZ?=
 =?utf-8?B?RjZUYkF4Y1hkdXVHckNZL29VcjFmSG03RlRQTUtZTEpRZWV5bkVDWHhSTDB2?=
 =?utf-8?B?MjBreTRGZFpIeTUvcjJxT3FodWl4eDlpVE0zdUpIbmpKNGVWR09zekxFMVFa?=
 =?utf-8?B?Ulk3ZXY4NUg3UTQzSk04YTUzZEdpNFdKWVZzOHdlZTBDQUdpb2VEVFc4azVy?=
 =?utf-8?B?aXNObUJ3U0g4QzQ4UVc2cTJGS1hWZ2JhOG5nWTFOcEIvRU9WbGlJWTJQdlFR?=
 =?utf-8?B?bWFsUTZUczlqVUFVb2JsdDY4eWtGbythTDlpWUcxOFRmQUQwaHUya3dCZWtt?=
 =?utf-8?B?TmF5QUg4Y2VGbExzQ0xrZWJvK3Qzc0pjMFE2TDNhODc5OE9iSnVqZlNXUjdy?=
 =?utf-8?B?cUxoaEtyT3I3NXp5RVNEZzUzMnBNWVM0Mm94RVR0N25IM1ZFQ3d3a3gvTHdx?=
 =?utf-8?B?Z3VqRk5weGdqT0drMlhNb0xrdlBYaHN4Znk4WndvNG5NODBIVGdISGNqNU9q?=
 =?utf-8?B?b1Y5VGdVZVg3UEMwTFA1U3JzWEplL2tnRWprNFRGVkIxcTFNR2ZOb2FUcnFT?=
 =?utf-8?B?Q0FqRUYyRnh5MFA1QlZaK3ZjTXRVL2xsN2t0bEFub3RmdTN1UmY2QXlYa2JN?=
 =?utf-8?B?N1JpSzNPUFZHa0JzZTh0RmRNWWQ5SjdhdFNvY3V3aTZYdnVzeXg3cHpIOFdE?=
 =?utf-8?B?SU9GQWFFK1JYZkkxTW1pRmlRZm84Y0padHpxY1d5Z0MvYXJGTDA1MytpeVcr?=
 =?utf-8?B?dTVVSGxtV3VaSXlWWVhuSDVabitSKzJFSmN3TUI4MjdLcDlIVjBXTlpnckZ4?=
 =?utf-8?B?VGt1bFNkaE9qTk1oa1U5cno1aSt3YlNFWFpWR3dDYVUreFNacVllbUc3QkI4?=
 =?utf-8?B?aHBaaFlDSm9UVU0vVlpsSExlaGVFODk0N2ZDZEJJeWpxRDhlNXl6SjFOVUpF?=
 =?utf-8?B?ZUJpNzJIR08wSjVBZy9LVndZY2Q4NDZlU01zeUVhYWxUWi9KTFpBS0R5OGNZ?=
 =?utf-8?B?N2U4bXd6Y3lsQ05JZE9SdU5vaHRsRmZ3YldsTG1vZzM0M3A0NzhmWjFiUy9E?=
 =?utf-8?B?QmEvblo4L3RGWjZxQ24xc1lJc24vZE1FNjF3M1RtcHBCZ3JyRXpFVTNtWDh1?=
 =?utf-8?B?a3BlRTZzUTZoN1FTSVhsaHhQak5SWUpuZXI2U3Y4WnJ4NWwyTEVDQXhIR09E?=
 =?utf-8?B?dWY1UjF4dWM1d0x2dTdUamFiZVo1UWFvK29oT1BsNC9ZSGNxVHk5M0Yxd29F?=
 =?utf-8?B?TGdsWE55SnpJdm8vZ0VrczNITkJXMUoybWNaL2lpTUVwMzU3U3pFOWRWUmVE?=
 =?utf-8?B?eCtTd051U1gyR3NYdW0yMGdaYnVVT2pmTmprSW4vajRzRWgrK0hhN0dhV2xo?=
 =?utf-8?B?bE9hVktBcjIxNEJSWVNmYU93VG03YS90N3RsaUxrTUpnTUF4ZEk5blZFYms0?=
 =?utf-8?B?SlFFRGU3YklPenBNQmNHUDNGSGEwUDU3TDVEaFVxcTQ4ckc1SXBLUkY0WUUz?=
 =?utf-8?B?MzNTQ2V1N1QxZFlBUUNyZVJNQ3VtVUV5YkN6L3NMZFBIcXErMkRwa21JVTNh?=
 =?utf-8?B?cmhrU3B3OHZ2Vkk4WTRIZU5nTVFQNWRqMWVCUEFBTGNVRGE4ZzBFVHNHR3hm?=
 =?utf-8?B?UzY1aWw3ZE9RbFZieTVOWUJ2RjlsVDRabFhSRjh0eG9VL1NlR0FRN1puK1JC?=
 =?utf-8?B?TUJhRjl4RnpIZnMwbmttR2tENGZ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C6C0E67CEDCCB45808C98C3BE6B0178@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478ad986-fd04-4e28-bf5a-08d9ec42a7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 03:08:47.3493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZcBWb2Wr9egfE6y6hTQX3Vxyfr+wjtLIEBDvlk2gCBHe2zlwfJ2+1DPAKFt3AQ91+Il2+ao0CLOegzOLNo14Ai6/hQtgr5s5O9Vk2RAjhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5255
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yLzIyIDE2OjU4LCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IERyb3AgdGhlIGdlbmVyaWMgc3BpX25vciBwcmVmaXgg
Zm9yIGFsbCB0aGUgeGlsaW54IGZ1bmN0aW9ucy4NCg0KbW0sIG5vLCBJIHdvdWxkIGtlZXAgdGhl
IHNwaV9ub3IgcHJlZml4IGJlY2F1c2UgeGlsaW54X3NyX3JlYWR5IGlzIHRvbw0KZ2VuZXJpYyBh
bmQgY2FuIGNvbmZsaWN0IHdpdGggbWV0aG9kcyBmcm9tIG90aGVyIHN1YnN5c3RlbXMuDQoNCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+IC0t
LQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci94aWxpbnguYyB8IDI2ICsrKysrKysrKysrKystLS0t
LS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci94aWxpbnguYyBi
L2RyaXZlcnMvbXRkL3NwaS1ub3IveGlsaW54LmMNCj4gaW5kZXggYTg2NWRhZGMyZTVkLi4zZTg1
NTMwZGYxZTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IveGlsaW54LmMNCj4g
KysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci94aWxpbnguYw0KPiBAQCAtOCw5ICs4LDkgQEANCj4g
DQo+ICAjaW5jbHVkZSAiY29yZS5oIg0KPiANCj4gLSNkZWZpbmUgU1BJTk9SX09QX1hTRSAgICAg
ICAgICAweDUwICAgIC8qIFNlY3RvciBlcmFzZSAqLw0KPiAtI2RlZmluZSBTUElOT1JfT1BfWFBQ
ICAgICAgICAgIDB4ODIgICAgLyogUGFnZSBwcm9ncmFtICovDQo+IC0jZGVmaW5lIFNQSU5PUl9P
UF9YUkRTUiAgICAgICAgICAgICAgICAweGQ3ICAgIC8qIFJlYWQgc3RhdHVzIHJlZ2lzdGVyICov
DQo+ICsjZGVmaW5lIFhJTElOWF9PUF9TRSAgICAgICAgICAgMHg1MCAgICAvKiBTZWN0b3IgZXJh
c2UgKi8NCj4gKyNkZWZpbmUgWElMSU5YX09QX1BQICAgICAgICAgICAweDgyICAgIC8qIFBhZ2Ug
cHJvZ3JhbSAqLw0KPiArI2RlZmluZSBYSUxJTlhfT1BfUkRTUiAgICAgICAgIDB4ZDcgICAgLyog
UmVhZCBzdGF0dXMgcmVnaXN0ZXIgKi8NCj4gDQo+ICAjZGVmaW5lIFhTUl9QQUdFU0laRSAgICAg
ICAgICAgQklUKDApICAvKiBQYWdlIHNpemUgaW4gUG8yIG9yIExpbmVhciAqLw0KPiAgI2RlZmlu
ZSBYU1JfUkRZICAgICAgICAgICAgICAgICAgICAgICAgQklUKDcpICAvKiBSZWFkeSAqLw0KPiBA
QCAtNjAsMjAgKzYwLDIwIEBAIHN0YXRpYyB1MzIgczNhbl9jb252ZXJ0X2FkZHIoc3RydWN0IHNw
aV9ub3IgKm5vciwgdTMyIGFkZHIpDQo+ICB9DQo+IA0KPiAgLyoqDQo+IC0gKiBzcGlfbm9yX3hy
ZWFkX3NyKCkgLSBSZWFkIHRoZSBTdGF0dXMgUmVnaXN0ZXIgb24gUzNBTiBmbGFzaGVzLg0KPiAr
ICogeGlsaW54X3JlYWRfc3IoKSAtIFJlYWQgdGhlIFN0YXR1cyBSZWdpc3RlciBvbiBTM0FOIGZs
YXNoZXMuDQo+ICAgKiBAbm9yOiAgICAgICBwb2ludGVyIHRvICdzdHJ1Y3Qgc3BpX25vcicuDQo+
ICAgKiBAc3I6ICAgICAgICAgICAgICAgIHBvaW50ZXIgdG8gYSBETUEtYWJsZSBidWZmZXIgd2hl
cmUgdGhlIHZhbHVlIG9mIHRoZQ0KPiAgICogICAgICAgICAgICAgIFN0YXR1cyBSZWdpc3RlciB3
aWxsIGJlIHdyaXR0ZW4uDQo+ICAgKg0KPiAgICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIC1lcnJu
byBvdGhlcndpc2UuDQo+ICAgKi8NCj4gLXN0YXRpYyBpbnQgc3BpX25vcl94cmVhZF9zcihzdHJ1
Y3Qgc3BpX25vciAqbm9yLCB1OCAqc3IpDQo+ICtzdGF0aWMgaW50IHhpbGlueF9yZWFkX3NyKHN0
cnVjdCBzcGlfbm9yICpub3IsIHU4ICpzcikNCj4gIHsNCj4gICAgICAgICBpbnQgcmV0Ow0KPiAN
Cj4gICAgICAgICBpZiAobm9yLT5zcGltZW0pIHsNCj4gICAgICAgICAgICAgICAgIHN0cnVjdCBz
cGlfbWVtX29wIG9wID0NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgU1BJX01FTV9PUChTUElf
TUVNX09QX0NNRChTUElOT1JfT1BfWFJEU1IsIDApLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBTUElfTUVNX09QKFNQSV9NRU1fT1BfQ01EKFhJTElOWF9PUF9SRFNSLCAwKSwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QX05PX0FERFIsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU1BJX01FTV9PUF9OT19EVU1NWSwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QX0RBVEFfSU4oMSwgc3Is
IDApKTsNCj4gQEAgLTgyLDcgKzgyLDcgQEAgc3RhdGljIGludCBzcGlfbm9yX3hyZWFkX3NyKHN0
cnVjdCBzcGlfbm9yICpub3IsIHU4ICpzcikNCj4gDQo+ICAgICAgICAgICAgICAgICByZXQgPSBz
cGlfbWVtX2V4ZWNfb3Aobm9yLT5zcGltZW0sICZvcCk7DQo+ICAgICAgICAgfSBlbHNlIHsNCj4g
LSAgICAgICAgICAgICAgIHJldCA9IHNwaV9ub3JfY29udHJvbGxlcl9vcHNfcmVhZF9yZWcobm9y
LCBTUElOT1JfT1BfWFJEU1IsIHNyLA0KPiArICAgICAgICAgICAgICAgcmV0ID0gc3BpX25vcl9j
b250cm9sbGVyX29wc19yZWFkX3JlZyhub3IsIFhJTElOWF9PUF9SRFNSLCBzciwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMSk7DQo+ICAg
ICAgICAgfQ0KPiANCj4gQEAgLTk5LDExICs5OSwxMSBAQCBzdGF0aWMgaW50IHNwaV9ub3JfeHJl
YWRfc3Ioc3RydWN0IHNwaV9ub3IgKm5vciwgdTggKnNyKQ0KPiAgICoNCj4gICAqIFJldHVybjog
MSBpZiByZWFkeSwgMCBpZiBub3QgcmVhZHksIC1lcnJubyBvbiBlcnJvcnMuDQo+ICAgKi8NCj4g
LXN0YXRpYyBpbnQgc3BpX25vcl94c3JfcmVhZHkoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gK3N0
YXRpYyBpbnQgeGlsaW54X3NyX3JlYWR5KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+ICB7DQo+ICAg
ICAgICAgaW50IHJldDsNCj4gDQo+IC0gICAgICAgcmV0ID0gc3BpX25vcl94cmVhZF9zcihub3Is
IG5vci0+Ym91bmNlYnVmKTsNCj4gKyAgICAgICByZXQgPSB4aWxpbnhfcmVhZF9zcihub3IsIG5v
ci0+Ym91bmNlYnVmKTsNCj4gICAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgICAgcmV0
dXJuIHJldDsNCj4gDQo+IEBAIC0xMTYsMTIgKzExNiwxMiBAQCBzdGF0aWMgaW50IHhpbGlueF9u
b3Jfc2V0dXAoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gICAgICAgICB1MzIgcGFnZV9zaXplOw0K
PiAgICAgICAgIGludCByZXQ7DQo+IA0KPiAtICAgICAgIHJldCA9IHNwaV9ub3JfeHJlYWRfc3Io
bm9yLCBub3ItPmJvdW5jZWJ1Zik7DQo+ICsgICAgICAgcmV0ID0geGlsaW54X3JlYWRfc3Iobm9y
LCBub3ItPmJvdW5jZWJ1Zik7DQo+ICAgICAgICAgaWYgKHJldCkNCj4gICAgICAgICAgICAgICAg
IHJldHVybiByZXQ7DQo+IA0KPiAtICAgICAgIG5vci0+ZXJhc2Vfb3Bjb2RlID0gU1BJTk9SX09Q
X1hTRTsNCj4gLSAgICAgICBub3ItPnByb2dyYW1fb3Bjb2RlID0gU1BJTk9SX09QX1hQUDsNCj4g
KyAgICAgICBub3ItPmVyYXNlX29wY29kZSA9IFhJTElOWF9PUF9TRTsNCj4gKyAgICAgICBub3It
PnByb2dyYW1fb3Bjb2RlID0gWElMSU5YX09QX1BQOw0KPiAgICAgICAgIG5vci0+cmVhZF9vcGNv
ZGUgPSBTUElOT1JfT1BfUkVBRDsNCj4gICAgICAgICBub3ItPmZsYWdzIHw9IFNOT1JfRl9OT19P
UF9DSElQX0VSQVNFOw0KPiANCj4gQEAgLTE1NSw3ICsxNTUsNyBAQCBzdGF0aWMgaW50IHhpbGlu
eF9ub3Jfc2V0dXAoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gIHN0YXRpYyB2b2lkIHhpbGlueF9s
YXRlX2luaXQoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gIHsNCj4gICAgICAgICBub3ItPnBhcmFt
cy0+c2V0dXAgPSB4aWxpbnhfbm9yX3NldHVwOw0KPiAtICAgICAgIG5vci0+cGFyYW1zLT5yZWFk
eSA9IHNwaV9ub3JfeHNyX3JlYWR5Ow0KPiArICAgICAgIG5vci0+cGFyYW1zLT5yZWFkeSA9IHhp
bGlueF9zcl9yZWFkeTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHNwaV9ub3Jf
Zml4dXBzIHhpbGlueF9maXh1cHMgPSB7DQo+IC0tDQo+IDIuMzAuMg0KPiANCg0K
