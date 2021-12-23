Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1534C47E284
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347995AbhLWLnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:43:14 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:53532 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLWLnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1640259793; x=1671795793;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=XCvzxsNgMDuJfKQUaoxY/EkeThhZbfim0CPbrtu+P8w=;
  b=Vzy6mQ4ucGVukQWrbceryCA1lXUxHRnT91lxHRnZf4DWZV9qa9p72xwv
   chrC8J3kEGqvTBEyMskcQ2ofPmkAf52soLuZoYWRTRaRNzd63RJHZwmQn
   PkhRHjCFEbA9gMXfSJapileWwKmkOr+tYziWoPPo6jsWyI29L+uK+su45
   yfd1la0E3qp+45q8srZr9tJ1XrOx6rEQ4zleknXpeDe5AyKtJBS2IyyV9
   oAgT0tuA3330VG+iA9FAAvdua8Ud67XbksuvaPXH8Bf9jkUD1i4y4KkzL
   irGhJqhZK2DdAn3eTRPhSnvPQCpyDKoX1wlXzya/Qa0thYb/ERcN42XRI
   A==;
IronPort-SDR: G+vHFNdBpOTX/a0DJO5bnIQCFCi+Jo5FbSvHx7XI3RBQRVm4MBsIWGprII118qX80GDmEeuINc
 Mk4/YKXHHwunMRs/iJ4MZ5zOkqWLoZyYmA7IcnAp8po4c6Nhx045riawF/jvc8DZn6v8UdtOe+
 XAqapIjbkCufV+UOAubvAKt3s/12Aqm4FOhWaRME2s56mZeq3vgXVEF1uhvpzVfcXFYVQsGonl
 /IvefVvblb7Fcgz4+dTiryYAWxlXyBt4Y95jUGT2qflUgF7TplIVbUbAH6tDIJ66W+pkcXQk5f
 JZ8232pql9oWPJkEkYOcfRJ1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="147601524"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Dec 2021 04:43:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 04:43:11 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 23 Dec 2021 04:43:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YT/FYaDThkFQiv8/i7yV081PI3e/F30aZs8Bfz7zhn0QGZ74EQ/zMNFoT2O+NdpwXy2R138y8A4UOHrh2Ia9yQhnt8zOh2NTNdyFsehTRI3Yk1e+4u1KcvQ5krJiVmisbq/FO4hOy36Ps0MwWbxoqJI7a30xFFfV47t6ShpSsGzytosbjhugMvYpGD0NmxdsdUavG762M/DoDDWeY87szYVd3uRcfF0i7vr2luD8bfCTgUhG23jZoWzlfL3vXvREYpGG3l1ckq5z5las9cGUojG8PXMlsG+sLEgUm+6Re9wIQELp/Gnu+Z8cXyBdibS5gVd6psS/9CVtlO2FN2WzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCvzxsNgMDuJfKQUaoxY/EkeThhZbfim0CPbrtu+P8w=;
 b=MnmUgxigUDM1Unj/jOqloaHnmI9dqp2RrpzapNK0bsFl6roDs8dLd9vx5NdWLYEgvsTOWeQiGBrLpmFDXTLjdH23wNnUtq7STnvPTJHak+lVU2bRYYcDqJWcJ/kPaf7S8ADgb938grF9lX06vSw6RRVYxmLQODjLKIWR1hV9sIwruDZEBs/s4YRTT8GGd6XQXoxVBMbix3502p8L5ltTHDoDf2bbJL36dpS79tZ9OVE9GF+L6u0kgzCzzsAjzPnAxq5qwgyzMRENOqMbeJ1kPfchmE7lKkY1zVGmTf/wjf+TYhcPOFEhQo1N9+xY3+AgJFBGn5DHSoSb3AYKB5efCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCvzxsNgMDuJfKQUaoxY/EkeThhZbfim0CPbrtu+P8w=;
 b=aiFH8CtVMQwQ8psLqXRMKsJYC4ayX96ucNmgqrtVQGbb9enW+BfRqIPsC281bwWKOmViv9BwhJRm1cUVUVguZ2LLXGgqK/ztJTyBUhN83/ii4EeRVlYQn3w/yxmEPJErimheR2bFVRW1M0dpfxddjZZKwLyd34kbZkR6/c6RCBk=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2733.namprd11.prod.outlook.com (2603:10b6:805:58::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 11:43:06 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::5c96:23c3:4407:d3b1%9]) with mapi id 15.20.4801.024; Thu, 23 Dec 2021
 11:43:06 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] spi: spi-mem: reject partial cycle transfers in
 8D-8D-8D mode
Thread-Topic: [PATCH v2 4/6] spi: spi-mem: reject partial cycle transfers in
 8D-8D-8D mode
Thread-Index: AQHX9/JAo9TJkzD7QkOfUKVvV3uyoA==
Date:   Thu, 23 Dec 2021 11:43:06 +0000
Message-ID: <0e22270e-7c4a-9ba3-e468-963d21ab63a0@microchip.com>
References: <20210531181757.19458-1-p.yadav@ti.com>
 <20210531181757.19458-5-p.yadav@ti.com>
In-Reply-To: <20210531181757.19458-5-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ddcc86c-da65-432d-2d7a-08d9c6096311
x-ms-traffictypediagnostic: SN6PR11MB2733:EE_
x-microsoft-antispam-prvs: <SN6PR11MB2733BEE5F514907ED8BB9FFDF07E9@SN6PR11MB2733.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hnJcla3zyr+uH79uBCrYmwYahCQt93YOYbJTxs+SeqS0EDT9UTvTkM25DaZLSAWgxmEaeNEe0meyY4L7NIqCz4M4M/AQvTCaILnq0nluJsP0IRfhTeZUOK07GyAwMxKpTBzD6uA6b//OhA7E9lWz35XhemNt4agaqancHXHRf8DOuUW9Jh/XKmnAbEmL4VJrPzUbr72uBgjvuRJMbvF8cZesWm8T9ME3jyRxKv1ceDqRT4SPySs2DfU0hgeI0YtxPaPjqiEnkER2tqmfyaWD0OpCQnfP6YDhfBMoVebxbL+pVRRd+7Z3kXiU374ktPU/LNrWHW5diMRVPBnxgIIxdr1mpLhjmtolWRIUB3DnMlO+AcQPRxiVyZwhS3D11+45oSHnPpkYmlcYoPLIiq5U8bjg3gmzdKsT2P2zKlLuHt9tRjFedkeATS4FtkwFPQUUdAYjQVEqHLHJGLVAlujYszF1qM/bkEFBYgWL/gLd3/+uI9xx64BCfcwr3STt6UjyZGZOgrXZ69i/TMDiCLSK8wwaYZaq9fkUXwR4jsZPqxQb86V9Ar8gufpu1vhM4Cvte4Q2ltxty9ozW6iHE86kHuAsWcz3s2zFGFhxyCvajkNUun3j9UYsYQBVFGy4MM806jqD/yZaIe/dVSHu8gV3ODgYfH4ErHIoZs3Y1PazjVHdOeAUvg0o1a+LKDl2dxMWSecugFwvAT6+tz+28UenI48aOZ0Qvu0XRBuycAEsYqv7whshvj59sq0eBGwbwdpmWvHcMLEBVrorQ3F9g59t6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(31696002)(66446008)(2906002)(66556008)(66946007)(64756008)(66476007)(76116006)(91956017)(38100700002)(122000001)(2616005)(8676002)(71200400001)(6506007)(53546011)(83380400001)(6486002)(31686004)(508600001)(316002)(36756003)(110136005)(38070700005)(186003)(6512007)(5660300002)(86362001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3JMNGFmSzhSZkpQK0I2ZE9hWndCVlFrS2pqQ2h6dHFUc2IveWNIbXNrM2Yy?=
 =?utf-8?B?NXpMakJQOGlRaHZ5a0F6TElCMmZwTWNBRkNldXF3Zk1vMkRRUlNLUlJadnl0?=
 =?utf-8?B?T012WnU0SjVyNzRtc0NVczNiKzBNSEF0aVFpcFhTRUZsQmJ1MVRob3ZteDJU?=
 =?utf-8?B?NGU0OWtXbk1rekYvQ0JKQjFUMysrMTFtWXhEZ1lHcjQvV1N2Ni82Q2pYV1ps?=
 =?utf-8?B?ckowY2RZeVZrbXZCaHlaT05sZmdISWZuY0JkbFAxQ3VpOUNWcGVOaU5jQ3pY?=
 =?utf-8?B?M1ZzL0V3ZUV1dW9MSUtMelc4ZkdUM2txb3RQTlBCWDAyMWdaajh5c2JHQy9D?=
 =?utf-8?B?NGRSeHRCY3E5bHBkbnBpdXB3RGhwWHl1cTIzOEhXSkEwZUhCY1Exb1JmWmYx?=
 =?utf-8?B?eTBIcEh2M1Zsd0hGdEl5SVlZeXRSWFlPb1d0ZjZEMFYwdUtmRGxISUZIUGc1?=
 =?utf-8?B?cE0xU2JISjc3VUpWOHc1cVMvR3VEWXByTHIvOWl1OE04eDVGdERWMjNIeERF?=
 =?utf-8?B?SmJpeitLSGlzSHMyNjRFc1RmMzJsZVRDZmc1ci9RL002TUVKMVdzbVV2djZp?=
 =?utf-8?B?dlA2aVJZYU5GMzVJMUpzRSt0N2JHOEZRbXlxdFV0c1JmSGF0alhHQU54YU9r?=
 =?utf-8?B?VlpKdXY0eXhjZ00reFpta2hGRktXSGJGOHlsc1BYczFYZUFvajJKeFpZV3Ru?=
 =?utf-8?B?dEpRakIxRzJhZnVOVjZGd1E1RkJJbWIwOHltZ1lXSUI3UnM3Tlpyaml3TjlF?=
 =?utf-8?B?UFRPdU5rZTh6czA1UmdHN3o2SGNkTFg5U0hlZ2c0MDUrUG92amNqaG5EblZP?=
 =?utf-8?B?TnZjL2prdkN6VGNDV0M1ZmU3SWVtcFdETzdyL1NPSXhIVnBSdVFSc3MyYkxK?=
 =?utf-8?B?ekQ0VUNBOS9DMlJzWDFhTUVrNEtRcUd6TDNnVFJzQklCeGQ5UGQzL1ZvWnZY?=
 =?utf-8?B?UUdIM3hLQmlmQ1czaG9WNzJiK1pWa1RTMlc1KzU4bUtxZ3dPNVl5eUVSbGF1?=
 =?utf-8?B?VDVQMHM3b3VxbnpveFZYZTBZaHNqY2lNR0hCaTRBYzFqUDJCYWU3REJsRVRT?=
 =?utf-8?B?YzJxekhBVUtrZWNTZkN4SlczaDBJYWtFK1R4bHVYMHpSSjhuaUhWYnZ6K0tx?=
 =?utf-8?B?OVo1aGRQQlgrTU9pdURVTVIyOEMya1J3VG8zcUJhSklDcktLbWQybkdRZlE3?=
 =?utf-8?B?dmZJT0FyZzFIVW9xQ3FkWDNvQlVSK2V3RjQvWWE4OXI1TVVTZm9WMUNjT2pC?=
 =?utf-8?B?N1ZoaGRFbHlxdURqa0JjemRBWndFL2hJMWwyWVFjMEZoeWJueitMK0s2NzF0?=
 =?utf-8?B?RkhnRVJvSW9CNlhBQ3FMbWRKQzFFbjV4enlIMld0allzQ0ZOU0RIS3VnT0lL?=
 =?utf-8?B?YTZ3NUN4TkxldDdzc1BMZFgwaGprZHN2YzRlS0VmUXQ1d1c3aUdDUjBmZS9r?=
 =?utf-8?B?UXBIUFErMW5RTnl3bVNxdklQSlNiVGhiclZTRXdXYTZGWjFGN0MrM1JmVGFn?=
 =?utf-8?B?VkRlQnVJNkdvMTZpdG1mU2FpbDZadmI0OXFYNkphSHgxcVQ0TDhCTTd4SDJK?=
 =?utf-8?B?cjgzTDljV0ZFbnFUUTFhcVVrYnJOaGdhaFZmZVhWSzQ0QjFndk50N2I2M2xk?=
 =?utf-8?B?SEdTcU1uKzR1TC9CbGFxMTVUQmRadWZUbjFSNjRMRjMxQWUweXQ3cGgzL3JI?=
 =?utf-8?B?bjdpL1c1bXA1Ukp2RHhuaHMrRE9iM1EvOUY0cHUzTWFhajl4V3EzWHhwVzEv?=
 =?utf-8?B?QnFHV0xZcDUyZWU0SENyNUpHSUVRMC9vYnNvN21IelQyODZrZitzSzlRcmVN?=
 =?utf-8?B?M2Q4RXEyN1NQT3NKKzcxeXp0YzJqWkJoM24yems4bmh0Ui91c2tDbDU2c2ox?=
 =?utf-8?B?dlZKMVV1WEFXNE9FMGpPU0NaMURiUmFVMnJadjYrcHZ2ajhkMldPVUFCclpE?=
 =?utf-8?B?MkRYSWZJQnRpU2ZPbzF0eGs1eTFnMlF5MHFQdjd4SGFNeFdsRXBnWWdHaVJH?=
 =?utf-8?B?NHBwbm1nZ3dmcHBpZ0NqUnNIWGZ5OCtJOUtRbkpMVVBPRFY2VldSWVRWSGx0?=
 =?utf-8?B?RG5YMCtJWHByeG1GUzN4V0U5dVhFVWNIRGppbjRSckI3djI0YlJZZ3pFaU5Y?=
 =?utf-8?B?dC9FbGpOOHIwejJDbERqQ0xQOHg0a01RT1pzMjNNZXkvakUvQVFRQStnOG1S?=
 =?utf-8?B?ZTVsQmtjVWFSdUdmSmNWczVBL1BBMXlNM2RIM3M4dVJ0TXZzQm5hL0RDRnZp?=
 =?utf-8?B?dUdQcko0dzUzU0FvbXV0MlFEMGx3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD1E498251AF3E4B873A0E75DA30427B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddcc86c-da65-432d-2d7a-08d9c6096311
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 11:43:06.7815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUHio665tf8UJDhy0PJsv7AIU1Ut/vQVnl96FjPOMxWDQsKfvf8n7HF3ZLKO0ypgUt2co98m/YOOWrExznjgYTrr4vtGBStEFr1BrGTIYnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2733
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zMS8yMSA5OjE3IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBJbiA4RC04RC04RCBtb2RlIHR3byBieXRlcyBh
cmUgdHJhbnNmZXJyZWQgcGVyIGN5Y2xlLiBTbyBhbiBvZGQgbnVtYmVyDQo+IG9mIGJ5dGVzIGNh
bm5vdCBiZSB0cmFuc2ZlcnJlZCBiZWNhdXNlIGl0IHdvdWxkIGxlYXZlIGEgcmVzaWR1YWwgaGFs
Zg0KPiBjeWNsZSBhdCB0aGUgZW5kLiBDb25zaWRlciBzdWNoIGEgdHJhbnNmZXIgaW52YWxpZCBh
bmQgcmVqZWN0IGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUHJhdHl1c2ggWWFkYXYgPHAueWFk
YXZAdGkuY29tPg0KPiBSZXZpZXdlZC1ieTogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3Jn
Pg0KPiANCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIEFkZCBNYXJrJ3MgUi1ieSAo
c3BlbGwgY29ycmVjdGVkKS4NCj4gDQo+ICBkcml2ZXJzL3NwaS9zcGktbWVtLmMgfCAxMiArKysr
KysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLW1lbS5jIGIvZHJpdmVycy9z
cGkvc3BpLW1lbS5jDQo+IGluZGV4IDE1MTM1NTNlNDA4MC4uYWI5ZWVmYmFhMWQ5IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktbWVtLmMNCj4gKysrIGIvZHJpdmVycy9zcGkvc3BpLW1l
bS5jDQo+IEBAIC0xNjIsNyArMTYyLDE3IEBAIHN0YXRpYyBib29sIHNwaV9tZW1fY2hlY2tfYnVz
d2lkdGgoc3RydWN0IHNwaV9tZW0gKm1lbSwNCj4gIGJvb2wgc3BpX21lbV9kdHJfc3VwcG9ydHNf
b3Aoc3RydWN0IHNwaV9tZW0gKm1lbSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b25zdCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3ApDQo+ICB7DQo+IC0gICAgICAgaWYgKG9wLT5jbWQu
bmJ5dGVzICE9IDIpDQo+ICsgICAgICAgaWYgKG9wLT5jbWQuYnVzd2lkdGggPT0gOCAmJiBvcC0+
Y21kLm5ieXRlcyAlIDIpDQoNCiFJU19BTElHTkVEKG9wLT5jbWQubmJ5dGVzLCAyKT8NCg0KPiAr
ICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArDQo+ICsgICAgICAgaWYgKG9wLT5hZGRy
Lm5ieXRlcyAmJiBvcC0+YWRkci5idXN3aWR0aCA9PSA4ICYmIG9wLT5hZGRyLm5ieXRlcyAlIDIp
DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICsNCj4gKyAgICAgICBpZiAob3At
PmR1bW15Lm5ieXRlcyAmJiBvcC0+ZHVtbXkuYnVzd2lkdGggPT0gOCAmJiBvcC0+ZHVtbXkubmJ5
dGVzICUgMikNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gKw0KPiArICAgICAg
IGlmIChvcC0+ZGF0YS5kaXIgIT0gU1BJX01FTV9OT19EQVRBICYmDQo+ICsgICAgICAgICAgIG9w
LT5kdW1teS5idXN3aWR0aCA9PSA4ICYmIG9wLT5kYXRhLm5ieXRlcyAlIDIpDQoNCmR1bW15IGlz
IHNlbnQgb24gdGhlIHNhbWUgYnVzd2lkdGggYXMgZGF0YSdzIGluZGVlZCwgYnV0IEkgd291bGQN
CnMvb3AtPmR1bW15LmJ1c3dpZHRoL29wLT5kYXRhLmJ1c3dpZHRoIGZvciBjb2RlIGNvbnNpc3Rl
bmN5IHJlYXNvbnMuDQoNCj4gICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gDQo+ICAg
ICAgICAgcmV0dXJuIHNwaV9tZW1fY2hlY2tfYnVzd2lkdGgobWVtLCBvcCk7DQo+IC0tDQo+IDIu
MzAuMA0KPiANCg0K
