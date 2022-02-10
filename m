Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0674B08A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbiBJImw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:42:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbiBJImu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:42:50 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B867218F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644482571; x=1676018571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3f+jvtAKJcWVa3Zv07febvOzZjeqDBOQxXvJd0CfdU0=;
  b=vVayvpkeoH0wvQPj/hDUfpyNol5IgxN7DjG9q5464GK2Pn5GEqKfEFck
   XSTIb87mxqt4MOH4W3MyzK7ECnsf+1WcQQftP8FyOO5JLFKTOzrt5g4lq
   p5VrKIgmTWYHu7779kXV81Sj6AMV6KY2TGjQRFkpwKuISa42wXL0lsqrL
   gaStfGjmzF7amvnqkBuT8MfLS//YhOTSDjWERJL6NyNqXHaDtUrO+5lVM
   5bDh8VXTDJwHQlBFyNoRkEZxwfQaFAAX5SjDfPXLxEgdlfP5dyuGv8cOU
   ixWxEu1fxlb0tnUEVg6fmsNQNZEbx7CNOruG5zvvKnxmfwtMDLHsQI50t
   g==;
IronPort-SDR: WWZK/mEaX3x3y+H31Bpm+pF1VtL9u/N6GDH4UZFvuwIFG1PViEyhfZpvTrxE1DgIUrYi7JbWbo
 sYl2qN1FdZaxzmzDDeev9gU/OYoNnokw46khF748DtdIskCarNlp6fRSznspCPu3i2YrUPTcMY
 qH5pusarHj9pv7N1RETEzIFw1rheDr19JXg1uR/oxecS3nk5JSNov2na1lUNPOjcijDdTd1ksJ
 339ZMN34Vrki4mutDygwXw0M43BOEgjedScLUkVvKuF+OawGsLc7ET63q8R25G1ebJvlLwyiUK
 oeA17XkA+GNxFD8IyWCQUC8V
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="161756618"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2022 01:42:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Feb 2022 01:42:51 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 10 Feb 2022 01:42:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8zgBc1k6bu88uWPrY5HQPAyIEbmhBrHJ+QjeGfWI+6dz0GxG1ZHYfWLwyWBTR8rUxEfECn/f86EAmHcNgYbi4kNuLjaKAWSZqxepGxm1OPuzOq/+x+BVZv2qV8EL64uobb7RSVEzDXTKnI02MjpnvmxB8TDhOOyAkTjcsgV5zF2fkOvzvkWvhY+5wIswwXqxH/dwselYUgOEv+sn/XdATCiVUOh1BeihEIvB+VpuwO07qIkOcIZHtD4/mYQ8DnMXK1nrxAg4uf5JSxXHFIoTUxZA+mla9xta9oYrNynOeyn7UOJrM66wXZbOKap7BTkeQczk2gljrPt/MFm9GB1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3f+jvtAKJcWVa3Zv07febvOzZjeqDBOQxXvJd0CfdU0=;
 b=Ts0dlGZIcJkIVzkWqlKit2809pkqazLyTvklp3ptL4Dwl/atJzN4CZwd14EozuSYpY9fy2cGrjVfj4jdTGpaUgzSa2mLQJ8+2cVLAC64LKU3BGuQbBXdrWK2X2qRa/nbtddnRpEjdy2s/jgTvNUOxQ8OQpj20YgTP7zT2u1BM4XO6atsI8YwT+ktS0HS0fqFkvvueBgzLwjAwOoC37vzOEr1XAm7cnzv/MGzHAg0tzqQwEh7PYwNtyVmJl2OfUEUpOv/ONjPf68DybZLF6q/KfKbgy8HbhjpXLL5oPs+WwdoSRpPSjd/acPQdCKHFuRk+aWqfOsPcJLkeDYxRElgLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3f+jvtAKJcWVa3Zv07febvOzZjeqDBOQxXvJd0CfdU0=;
 b=GoPoVYeOAgQx7wLrKtrMi6z2KUM/otC+Qx5Ne3AswKapZi+04GSCAmwgSGt31xIs1Pyiito9qpPhK1JjC++KF1wtkJlt/LF/53aGcchnTawp311uTh2KekPvfgu0VvwvpR408y8OIy3UxyRrKoo2aelsr/LHppUbfZduN3Bu2B4=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by CY4PR11MB1767.namprd11.prod.outlook.com (2603:10b6:903:11f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Thu, 10 Feb
 2022 08:42:45 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 08:42:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v1 11/14] mtd: spi-nor: spansion: slightly rework control
 flow in late_init()
Thread-Topic: [PATCH v1 11/14] mtd: spi-nor: spansion: slightly rework control
 flow in late_init()
Thread-Index: AQHYHi4PW04boVsuWkWWgPyXciUsWw==
Date:   Thu, 10 Feb 2022 08:42:45 +0000
Message-ID: <dc8febfc-b8de-abbf-8e0f-659a27fa0fa2@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-12-michael@walle.cc>
 <f004399f-36b0-2099-b2a0-8ab0ecd114b7@microchip.com>
 <ced74caa2ad507615b9cf1645d10fa87@walle.cc>
In-Reply-To: <ced74caa2ad507615b9cf1645d10fa87@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 219d16d2-cd40-4e84-e611-08d9ec714f42
x-ms-traffictypediagnostic: CY4PR11MB1767:EE_
x-microsoft-antispam-prvs: <CY4PR11MB17674C170B97F208F5463479F02F9@CY4PR11MB1767.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zC0f+7J91yPUnNrKohBdBMX9HDGH6fLxJyppn1slaXgkw0nfdnsLwhCDMMePVlZkku6NisNEzxt+80/2U/PeoS1DNWM2AkmMHKX4OGB+oowjYRL1Uu1meO7YKMdm9SWG2TwRUpVo2DknvbAaEkwXWaUvbbMP4cRsv5pdbWJrcaz2L/U8Hejrbvm44pSXNueusubHTpCxKUf59y7aHXhkuR3GFMGaWPvHwHybVujDRhUyxNN6862VP3squx3gUO0ZFGkuFebADD5Irznwi76/b7WhJTcmS43JoAMpY+Rg3wU4cIOTJ4kSkoHFIQPXh5A+1RLrceUWCNC6JnrLit5Veeh0iPhSc9sBHiOqHNs9bSuUcno0dxGesoYk/jqghYrSChSfCYQucOCqETy61wphCgOIkV+JmWr65XY6vUQrfsYZ04jCXPa5znzd0gA8yQF98DKeXS6NUFdVi/a0Mm/KQrLmAo3XwIl5VICWBXgXDRPd1T3BdgjAZMSi4ELsIm2MnIqP4+yC+vm4QLbsUu5WiHTE7YBNuz+umozhPswrIN/SWbrD6wY8H1LtS8kTmXJSQWtK8QeLAVssCd4oeCDp/fEYR9EiESlMi+u3GO17qz6HLTUsMVWEkMMHtE0DcRu42e4xHxmjNSOhYWPfVNTdV8M9ACim7A+CSfszFBCDqaszBK/9SYLMY5HyyxvUitAxVkM/A2IIQxO1TC60mLA2A7izzbiPEqOAjtfoOnJqO1mOv35GOj3I2v66r/XTjP//L7b4zZ0sH0QJeiLZA+Pvdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(186003)(38070700005)(2616005)(2906002)(91956017)(122000001)(66946007)(26005)(316002)(6916009)(36756003)(54906003)(71200400001)(76116006)(53546011)(66476007)(86362001)(4326008)(6512007)(66446008)(31696002)(6486002)(6506007)(66556008)(8936002)(83380400001)(8676002)(64756008)(38100700002)(5660300002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDNhNlNLWFh4cC8xV2k1TFZzN0ZzTEZ4Zjc2MHowa2FIa0ozSEcrZ0tYcVAw?=
 =?utf-8?B?Y3FVZThSWnJRczJvbjlEdkVzM1F1cjZMQVB5T2RZUlpId1JGWnB1dWg1TnNy?=
 =?utf-8?B?dVhidVVyVi9KakhlRElkVjVOWlIxY3VHaVo5NEZqZUFWUXp3OXVVYmgwblBn?=
 =?utf-8?B?OXNBNHZLQzAyUkJHbjNIb0tzQkxnZ3VHUytDdWphNHM4SHEwaHNPQ0xqQXg3?=
 =?utf-8?B?VFRpdGtoN1RzNC9VLzNGd3N6TDdJTERBVEw3NHNDRUtXdkxYOWgzWVg3NitH?=
 =?utf-8?B?N3YrUjIxaG5vUk9WaHZtR2FsVFlGcEI2eFlTUllMVkpsR3ozQnhEOWRCSHJ2?=
 =?utf-8?B?UEthMlFEZmR2NDhZQmlESHlZT3Vhd2NCN3UydXh6czA2d0MxQzJmeno4cDVh?=
 =?utf-8?B?RFM4cDh0NG9LMGFQdnpCOEdIQWwram8yRzBqNWI1dmZqQzFvQzJCclJtUzU0?=
 =?utf-8?B?R3pkdVFPVU8ycU5WOFZqdDN6QUQ1K21EV0JvcUVjaGVGbWJjN1p5cjA5bk0v?=
 =?utf-8?B?cVk1VzlFdnRsWmJyZmxFdnFRdTcraFhBQXYxNnVNWStBRXFVUHZ2L2tvWEpN?=
 =?utf-8?B?QUl0NG96c3lKL0dsSUNQV04vTEpLRU9OeFl2Rzh2aC9LblkyV0JXN2wwUXRF?=
 =?utf-8?B?bzFKVHpCWGovQlZQdWx4WERqdDIyMWtyVGpyMGRmL09EcHJHaWlmTm9ZMy9Y?=
 =?utf-8?B?NmwwVENVQ1VVQ0E0cDlNZ0tRRUQxUklQaE8vWWpBMmpDaTh3WklLZkt4dDBD?=
 =?utf-8?B?STVvTGpBNk5Md0R1RERzWkFXWEQrcFIrVE9nZFp2NnVxOHE3V2RpYmhtek9y?=
 =?utf-8?B?U2FiT00xdG5Dc1FIdnU2aTBrMHVMRmxsYmtxanlnRHIrWm9UMTgxVFNMM1N5?=
 =?utf-8?B?ZHNVMzR2WjJseDhGRmZQZzFreEJ0d1VlbjhxNDF1dEVRMDNCTGRSdC9jekpR?=
 =?utf-8?B?ZTViOUJFY1BkN0VaSkV2V0NHSys2NFoyNlZZRXdCeG1mRnpaeU9yYlQyTWJw?=
 =?utf-8?B?S0xqc2QzUGVFZmtlWmpkWWtxT3ZGWHE0WDZsMk1zanMrU3hrS00wK0ppc0NC?=
 =?utf-8?B?R1ovdnZvLzk3ZTlPd20yWFhIVUdxa2ZERms3NzFuYUpNWDN4SUN1Y0M0OFNq?=
 =?utf-8?B?YTU0UFMwd2lROVJVb3V0WTNhMWNlZ2tpMGczS2wrZ2tnOXU2aU9KbFZUQXNt?=
 =?utf-8?B?dThkRTBuT3lLSkpMbVUxT3gxd0FQRTNUODRBRmx6SFVaMEVMK0EwcTdPbmpQ?=
 =?utf-8?B?NndGNkNEaTF5bUg5VjRYVGdkQjZIdGkxaVBUMzI2LzRiYW14SHdpTEVqalF5?=
 =?utf-8?B?L2Q2bWtITmVOVlhGL1RUNUNibTJRb2JGQ3VDWUVIMXQ1VUZjMjAvcnFlWk5z?=
 =?utf-8?B?V0Y4QlhZZGRzWHY0RjhsMG04OE1HcE9kS3RpQ3ZoT3NvQ1NhYUZsdXdvUXYv?=
 =?utf-8?B?NGNGbGc1MU9Ic2N1aEVDN0xXM1Y5L3VWc1oxeGQyRi82VXRPVHNWRzNwTzZs?=
 =?utf-8?B?dkdFVENYZjRMVHNwb0x0ZkljSWFOOEtiTzV1cERibG45bGZ3VWRTakhCYm9C?=
 =?utf-8?B?MENQRElnakszMnI5Uk8zSFNuK1dJbHpBblVTUGNEOGxCZXdjUHk2VWx2eVJm?=
 =?utf-8?B?QXhSaHJQMFBCc2hGemNIUEpaTlV4aEh6dU5vWWp0emx0ZXlJRTRwR0RyVXJq?=
 =?utf-8?B?K28yMjFKVlpCUkJldVRPNHdxUWptQnd4N0dGaXVEZFZiTmlRc0dTeEpwRTFR?=
 =?utf-8?B?VXVab0lzNjdhWDZ2S3QyV1JEMWc2cVJQY1E5cytPRXkxVUhmNUxxeG1OM003?=
 =?utf-8?B?T29YTHFRTnJ3dytkU3lEb1ExZE9EZVlSalVuOVN0UnduNGdncXNFU3FtOWNw?=
 =?utf-8?B?b2o3V0ZxL0RpSFp2dVlvVW8wdUpRUFljMW96bkhEQWRpV2dGMUlpRExicmcv?=
 =?utf-8?B?SHBTd3dKNURVZnAvaWoyMHFPMnRqUi92S1BLTXA5Tnk3b2hHTDU4dGZRajZo?=
 =?utf-8?B?QTdzR2Y4WDJsTDRxSVRYQjRPd1RiK3puNXNESHE5WjFmQ2szK0E0NzFGV3Qv?=
 =?utf-8?B?SFpQTzliM1VHU3FIWmdtVHlzR1VoWXRtWXhHYlUvOURFTnErakhFWEJNQ2Y2?=
 =?utf-8?B?UjNZQmdPZUJGL1c3VXVvUHdLanh0QXhpbC9yZFo0K0dMUWl1ejdscnVwY0Uy?=
 =?utf-8?B?N2w3b1JxdmFLZEJIMnhXZjV6UmFZUm1XOU02VmNTNnk4KzluaHBtYUxVRGxQ?=
 =?utf-8?B?eTJIazdUR204Q0p3cVhEeGJnSWVBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98E9C582BA756542BBB5D2DFCF8348A3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219d16d2-cd40-4e84-e611-08d9ec714f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 08:42:45.4098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K+pY/FAjWqVEWm4SGzdjqcL2XPFkxTqFHvCZiHDRskbNz9h6aEDeygRZH3h7N24lDk8ieCW0r0ypemUdjovn1cyDg3mWQuOrKFtrk5Ats+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1767
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xMC8yMiAxMDoxNiwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTAyLTEwIDA0OjI2LCBzY2hyaWViIFR1
ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDIvMi8yMiAxNjo1OCwgTWljaGFlbCBX
YWxsZSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93DQo+Pj4gdGhlIGNvbnRlbnQgaXMgc2FmZQ0K
Pj4+DQo+Pj4gSW5jcmVhc2UgcmVhZGFiaWxpdHkgb2YgdGhlIGNvZGUuIEluc3RlYWQgb2YgcmV0
dXJuaW5nIGVhcmx5IGlmIHRoZQ0KPj4+IGZsYXNoIHNpemUgaXMgc21hbGxlciBvciBlcXVhbCB0
aGFuIDE2TWlCIGFuZCB0aGVuIGRvIHRoZSBmaXh1cHMgZm9yDQo+Pj4gbGFyZ2VyIGZsYXNoZXMs
IGRvIGl0IHdpdGhpbiB0aGUgY29uZGl0aW9uLg0KPj4+DQo+Pg0KPj4gbW0sIG5vLCBJJ20gbm90
IHN1cmUgdGhpcyBpbXByb3ZlcyByZWFkYWJpbGl0eSwgSSBzZWUgdGhlIHR3bw0KPj4gZXF1aXZh
bGVudC4NCj4+IFRoZSBvcmlnaW5hbCB2ZXJzaW9uIGhhcyB0aGUgYmVuZWZpdCBvZiBubyBpbmRl
bnRhdGlvbi4gUHJhdHl1c2g/DQo+IA0KPiBUaGlzIGlzIGEgcHJlcGFyYXRpb24gcGF0Y2ggZm9y
IDEyLzE0LCB3aGVyZSB0aGUgY3VycmVudCB2ZXJzaW9uIGlzbid0DQo+IHdvcmtpbmcgYW55d2F5
LiBJZiB0aGF0IGlzIG5vdCBlbm91Z2ggcmVhc29uIHdoeSB0aGlzIGlzIGJhZCBJTUhPLCBJJ2xs
DQo+IGdpdmUgeW91IHR3byBtb3JlLg0KDQp5b3UgY2FuIHB1dCB0aGUgDQorICAgICAgIGlmIChu
b3ItPmZsYWdzICYgU05PUl9GX1VTRV9DTFNSKQ0KKyAgICAgICAgICAgICAgIG5vci0+cGFyYW1z
LT5yZWFkeSA9IHNwaV9ub3Jfc3JfcmVhZHlfYW5kX2NsZWFyOw0KDQphYm92ZSB0aGUgc2l6ZSBj
aGVjayBhbmQgZ2V0IHJpZCBvZiB0aGUgcHJlcmVxdWlzaXRlIHJlcXVpcmVtZW50LCBubz8NCkJ1
dCBpdCB3aWxsIGxvb2sgdWdseSBpbmRlZWQuDQoNCklmIHRoZXNlIHR3byBhcmUgc28gdGlnaHRs
eSByZWxhdGVkLCBob3cgYWJvdXQgc3F1YXNoaW5nIHRoZW0/DQoNCj4gDQo+IEknZCBhZ3JlZSB3
aXRoIHlvdSBpZiB0aGF0IGZ1bmN0aW9uIHdhcyBjYWxsZWQNCj4gc3BhbnNpb25fbGF0ZV9pbml0
X3NtYWxsZXJfZmxhc2hlcygpIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuIEJ1dCBpdCBpcw0KPiBh
IGdlbmVyaWMgZnVuY3Rpb24gdmFsaWQgZm9yIGFsbCBmbGFzaGVzLiBBbmQgaWYgeW91IHJlYWQg
aXQgeW91IG1pZ2h0DQo+IGdldCB0aGUgaW1wcmVzc2lvbiB0aGVyZSBhcmUgb25seSBmbGFzaGVz
IHNtYWxsZXIgb3IgZXF1YWwgdGhhbiAxNk1pQi4NCj4gWW91IGhhdmUgdG8gbG9vayB0d2ljZSB0
byBub3RpY2UgaXQgd2FzIHRoZSBpbnRlbnRpb24gdGhhdCB0aGUNCj4gYXNzaWdubWVudCBhZnRl
cndhcmRzIGFyZSBqdXN0IGZvciB0aGUgc21hbGxlciBmbGFzaGVzIChhbmQgeW91IHdpbGwNCj4g
bmVlZCB0byBub3RpY2UgdGhhdCB0aGVyZSBhcmVuJ3QgYW55IGFzc2lnbm1lbnRzIGZvciBhbGwg
c3BhbnNpb24NCj4gZmxhc2hlcykuIFRoZXJlIGlzIG5vIGRpcmVjdCBjb25uZWN0aW9uIGJldHdl
ZW4gdGhlIGFzc2lnbm1lbnQgYW5kDQo+IHRoZSBjb25kaXRpb24uIFdoZXJlYXMgd2l0aA0KPiDC
oCBpZiAoY29uZGl0aW9uKSB7DQo+IMKgwqDCoCBzb21lX2FjdGlvbigpOw0KPiDCoCB9DQo+IEl0
IGlzIGNsZWFyIHRoYXQgc29tZV9hY3Rpb24oKSB3YXMgaW50ZW5kZWQgdG8gb25seSBleGVjdXRl
IGlmDQo+IGNvbmRpdGlvbiBpcyB0cnVlLg0KPiANCj4gQWxzbyAtIGFuZCB0aGF0IGlzIHdvcnNl
IElNSE8gLSBpdCBtaWdodCBlYXNpbHkgYmUgbWlzc2VkIGFzIHNvbWVvbmUNCj4ganVzdCBhZGQg
c3R1ZmYgdG8gdGhlIGVuZCBvZiB0aGUgZnVuY3Rpb24gd2hpY2ggbWlnaHQgZ29lcyB1bm5vdGlj
ZWQNCj4gYnV0IGl0IHdvbid0IHdvcmsgZm9yIGZsYXNoZXMgPjE2TWlCLg0KPiANCg0KWW91IGRl
ZmluaXRlbHkgY2FyZSBhYm91dCBpdCBpZiB5b3Ugd3JvdGUgc3VjaCBhIGxvbmcgZW1haWwgOiku
IEkgZmluZA0KdGhlIGZpcnN0IGFyZ3VtZW50IHRoZSBzdHJvbmdlc3QsIHRoZXNlIHR3byBhcmUg
Ymlhc2VkIElNTy4gSSdtIHdhaXRpbmcNCmZvciB2MiB3aXRoIHRoaXMgY2hhbmdlIGluY2x1ZGVk
ISA6KQ0KDQpDaGVlcnMsDQp0YQ0KDQo=
