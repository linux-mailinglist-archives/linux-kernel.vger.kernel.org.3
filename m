Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB964B03C9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiBJDL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:11:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiBJDLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:11:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA3E1EAE0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644462683; x=1675998683;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mpS1oeyvMZJDIFWDKwkSGK2gB78XyfAoro/+Pwtr+dE=;
  b=x9hd1CUthxOrMCnM3tXyVovg3DcawCT9oyWc0k8C8NR2ELNdSOYRSV+q
   mw2UzOC6hDwp9HOtfd2jDa6uRunvE5xhLWhNu39fFFGh3wLQP2i4gjoIg
   JiHBI7p2jtP/RNp6IoWW20C9szZ8W/Eg49eN6t+PUs1rgMIkfW3UPm/XJ
   KiZ19lX1W4b9V6XwjR1gDpfJ5hTWYFCYXwQzHmgKkCpEqVj3TW+SZEpmD
   Nl9iQ3EiyB8yGH/zYLhA4VZtN6sXbaihc0HFjcsPBxIbcegCXi0/A2TIz
   nzdncxIxS7e2Vy2rnyNXb6/8x/92h9qtwVMyITmy6hlHEoCFj2LHVJW2N
   A==;
IronPort-SDR: tBFsp8fkKYWGCMGYqWE0tUvOyCr9EXchA91bn+3Wac2NEhWoQnIhZOzZPpFK+WHem4V+Rs63GU
 Xw+USd4hZ+9WWvFy12N7MBoiZ4MEkD7YfawO/G97aQyDXPhICHFfG5kFOF/xVHijOE4RV8D0uU
 k7PnYXKyCr4f7kJpnOXfPgA5oSppvdasdM85H2C2cijmE8yawYoG6Wt4uQS2HrLo7yp7g4FjiV
 3Zg6vFccIVV3K/+gC0ZOVB7EkBOPi0Qf199VP3IRiZipU+KQuwJS+DFIurtwWwFIZVm83Sc+J3
 3SmdC8mjT0fURsEYsWPzTF3p
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="85252623"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 20:11:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 20:11:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 9 Feb 2022 20:11:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeM4ikEvvc7gQ5HvchTPWjFx758iX6KK+le9Lsi3CpVZiip6SQHpWN+rIVinCcA3zRQamd6hRf5SpaClkKxV27CrXb6sQhHAb5cyY0KXPPqAzPFMdBfu6sGAw25vu1gHpuAjAGjWtMvabNzc7ljdTimWiB+C+M0WJIkwaT+Id8DGH7x+v8jWJizVZkeJv9hVcNnAl5lmMiBjogaOnioKEAufWe7hWciALJ3NA1HX1U80uounA53aVc2BQG+eCmIi+DIvAIYyFuxmZ32N89+HtfNEVax57ar/RxrpdN8JrRAC485/Wy2e4530t7F79PZcF4l64QWUFBm9OxHJ6YqRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpS1oeyvMZJDIFWDKwkSGK2gB78XyfAoro/+Pwtr+dE=;
 b=MujJNiIEQ1ydldIHqw1Cs1+NorlRoSJk8x2xGSvyyTHO+t+gWeB0Hlw9ll0tKGzFY+btJ5r5v6M9bC5U7eKK1jfUBHlslLYNAvaaV/DFxyyR/KsPMBf5HdZ/Pf2SU6UZFd5Gp3812EK/NLvhSKFzpFAnGhNtOolW6dZmrgorwcfBmSXmhei1vt0PFOP25xLmkSLRvwW7Im3PH9QsxFGL70++lOnIsYc6sTFls8nGUCmhqqzHI2z7Cwnw+roODISFNO8p3TvryHWRwFd1+ELhU4EOo92aj2S+siN41+vKTDcFgbw++fEKjCrxt4Xv5kj7DDeoujtBivQP2B1TgJJ0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpS1oeyvMZJDIFWDKwkSGK2gB78XyfAoro/+Pwtr+dE=;
 b=TQbLmwSjNRPv7Wdg7T8kC/Qd0xEevIgDKkVSLkSHTm6xwWbCg372TqFD8PT3jFqKqret6awUaSJ8H3da8teQ79jxMQedZJlBdEQFV3MG6x5CxT9zE0KjFFZCtLXwAlMw2IGDLisaITge57g3uXEfKFYpenCM3papLo4Q64M4hy0=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2896.namprd11.prod.outlook.com (2603:10b6:805:d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 03:11:09 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 03:11:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v1 06/14] mtd: spi-nor: xilinx: correct the debug message
Thread-Topic: [PATCH v1 06/14] mtd: spi-nor: xilinx: correct the debug message
Thread-Index: AQHYHivZbZl9UbAYnUiHbtG0z2o+rw==
Date:   Thu, 10 Feb 2022 03:11:08 +0000
Message-ID: <e3712b8b-9830-5be1-3a31-97daa44f477f@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-7-michael@walle.cc>
In-Reply-To: <20220202145853.4187726-7-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0e40a90-e7a9-4068-f20b-08d9ec42fc0b
x-ms-traffictypediagnostic: SN6PR11MB2896:EE_
x-microsoft-antispam-prvs: <SN6PR11MB28964DC7D3B5C8B93AA79E09F02F9@SN6PR11MB2896.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:348;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Piu63Y6nIAfliICnxg0PnddTOkl5rfP/k5OgHfBiCdOg+tJxdBr96QFQJ5ESj/HxbNok4QS4rMRmHtcYFX/ViHE39vnp8FVsulLM9rOEVoQejJ/NfiJk+7WYLC3JkiskveFXA09oAt/frB96cokqBzGsgc/x5sm4QWzufnlgwDQ6W+DpEyPdxBMXkKknVni11tg5KDa9T/mU6EXic+i1xqOqsMJ1LSCO9yV+5JdqhxwAHLm8bApo84VoPv9PlHASji9NMraoVpxuIZqs5iBaZGjBHuZSxEYvbEsz/60vawquY/z9Z24ftHUUEY0j7vjHkvMvkiqRLUNyWm6KUrpxXmW3D5ot6g+iFF2W1qC668XXxwfycEGbIPX0+nxKeNcJ7BT20Nn8/YrKJxlZ76M9ZOqBNrEytPeUKOI/0KBXnje323USIm0EuL7t/CWKRHB24m9W1W8wfjwyumil//Y+CCtZRu1WnfUrvLy3h51rw8XpjGuBiCW1lL2VmwtTtl8dFW76zFmetAQqkXn1Qsp8GpRPqMPr/tY+tHSOCEIMKuSJQ7sZjTKynhYiIbGXf50/vhiUt0aLElGdOypTkbvSS1LZ8pHvnx9qgpyKN5Dg3fvL3QKf+2v3qsHGYQgjvbOKl48Axlqyu8tYD4KwWUuQ/qRri1ezV9Y7Br43a+3pyUnNAel1AP/JVL3h0YTeiZ6i4AmPVAdR+OumDeBmduZdRUNE6xlNPxoB3rSMV/Fc2p19eheYaudMcycWeXHJMA5BeUgjxOqXimkzbBNWNQ3YAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(83380400001)(6486002)(2616005)(66946007)(66446008)(36756003)(4744005)(4326008)(38100700002)(122000001)(31696002)(76116006)(54906003)(110136005)(86362001)(5660300002)(15650500001)(91956017)(8936002)(6506007)(71200400001)(6512007)(2906002)(53546011)(8676002)(66476007)(38070700005)(31686004)(66556008)(508600001)(316002)(64756008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjB3NUx2cGRtT0tXak81a3prMlQxNkROQzlyU3FUSy9PbUt6TDA5bzNaTE10?=
 =?utf-8?B?OElkeWhtRmRUMXNSTmpPNmhHNVFPTzVJa0RORlFQbDNOdTJWYzV3WFg0RkQr?=
 =?utf-8?B?QVRxNFVRSEJ0YVpQdTdaYnFCOExPdlM0aEkrcWRhUXdUS0ZWb2ZJVkQ0WHN3?=
 =?utf-8?B?VkxMTVpIQXVtMkJmSmlPWWNrNG1naGFrMXNCckpOODJIRUVQT0lTWk40S1Yy?=
 =?utf-8?B?cThGaWFFL0RqVEU5YWJxblR1UTlGSlordmZiMjd1TGtiRnZjOUtleDgvMEM1?=
 =?utf-8?B?eW53ODFOMklvakl4ZVR3MFRib2xqc3RCYlhtaVBVaHhzZ09vMzZCejZ6RGRt?=
 =?utf-8?B?eGh4QSswRVV4ME0vMVh4UGg0YWxLazVmVEFkQ2l5UGRna25KQ2ZBUTFuUGtr?=
 =?utf-8?B?M1REQnJxeHVISzZQVDZOUGF1T0pMcFlmZy9OTGw2QU1DUVhlME1ZNUhMT3dV?=
 =?utf-8?B?emVNRnlvNnNERnlQLzJxLzN4bHlnSzBDaTZQMkh5TXo5dDNGYzhxSE1HZXdk?=
 =?utf-8?B?RTJ5bmxabU9rWWxUV0Y5RW9na3pKS2RzdEZ2bWgyMUU3bGY0dGxIQWt2V29r?=
 =?utf-8?B?Vm84TEdyUWhUTTIvMHl0MHlMRkJDY2hQWU1nZUc3NXRvNW9yVHNaYzZ0b040?=
 =?utf-8?B?OFlVTENodisxVkpvaWxBcUxlVHhmNHBZankwZEJleXV4VHJoM0dhUnRCdTlv?=
 =?utf-8?B?bUVROGkvbFFOSXBvdnZhQ0VRdzFPa3IwUTdrVm80S3dJZkI1R1p3UW41WWFY?=
 =?utf-8?B?bjRWSGxRQ0FLSGhGQWhvNnNIWDhySDhNcUFUd1hvMDY0N0NiQWh6cWlVbzJU?=
 =?utf-8?B?dktsTVZUYzNpdGg4Ym45alI4TVhMZ1dvN3dnRWdPU0VQU3pMSTNCY0pZalJE?=
 =?utf-8?B?dzRnMnBTWmZiUnpWQU1lWGdtUWtIUDMyZU5IeVpldkw5aGdnTks0VHI5ODJq?=
 =?utf-8?B?M0lqQ01hdndKa2o4bDlLRW5iaWxjdmJ1SWdWQmNYZkwxb0N2ZzlBeEUwb1Bh?=
 =?utf-8?B?Z1V6VmwwWHRnTUNhVDRnSFpkUkJmWkxaZGZidEFuMlZhandJS0pTNDEwNThD?=
 =?utf-8?B?U3NPT2NzaktGSjFvbE1LVHM4bWFlcHRSMVYxNGEyd3FFdmRhQStuaThmSG5x?=
 =?utf-8?B?dmxhME5MRllrSUkxUitLTForTmZvNlQ4cE9yMlFXMUdGZlRRclFZUFpZTkxL?=
 =?utf-8?B?dWpNQlVTTjJJTWtTVmxPaG9uVVhNcVFwMEs2aExlWDViTUxLR2hRUjk2K2NM?=
 =?utf-8?B?M1BpV3VvRUxING5xT3cxSExxMUQ2eTJIVUNrWVVuWXZnRENQeFJNQ0hoUms5?=
 =?utf-8?B?YzRTM21aZlU4dUxxNGp1Ni93V3BLaWlOUHhnTkJiRVVOOUgxbUR1MkpZSkJK?=
 =?utf-8?B?MzMyS1ZvU3cweEZUNzZKQVJkeUFIbFdIZmxxYk1xajFVeVBZVCtYS2E4eFIr?=
 =?utf-8?B?YWZ6OEkxeDBHSUNjdXFadWtWcXY3R1gybmtDUWRlWXJ5UGlMZ3BQUlk1bU91?=
 =?utf-8?B?RURMU3hkUUVTVnpQT3dkQXE0NzNCQk5WcC9aeDJnT3c3K2YrQW0wQkxrYXJ2?=
 =?utf-8?B?ajhxNko0TDBkWEhOMVVYMkhjSU1zdmlxSVMvOVA5Uy82c0hIWldEQUxBWmFE?=
 =?utf-8?B?UkxiaTNZZUtkYkJxMHRGM2l0UnhKYkp2bEk2cGlLdmFSSzFzbDJyY0FCZWto?=
 =?utf-8?B?RVhOZzFNaWJJSGpQNjVJY09qcXI0UEVVNHdNTHdUMEx0RXdvdENiVHE0WFI5?=
 =?utf-8?B?WUlQNm1ZSWxBYnJieG84elJlbE53M2VnMTR5aG4yQXFuZ25LRDZob2ZTQ2JP?=
 =?utf-8?B?MzZxRXlGY0FTOElOTlA5K0FnYWQ3VnhyMmMyajBhVmlXdzgzNUR6V0tyYWx5?=
 =?utf-8?B?b1dlKy9BblcyOHhCblV1cHVJbWs5UURGVmZEbHQxZjR2Nzh3b011aU9rQTFY?=
 =?utf-8?B?Vjhtb0RpMFZBeXcvekNRWjJIYUdrS2NhRFRzUnZEdTlrZFI1ZE1RSXJSZWQz?=
 =?utf-8?B?LzY5bUtYcVU4ZmdaQ1dmQzBjTlIwVFVRcTltbklzeG9hMHlSMXlFSWt4UVNQ?=
 =?utf-8?B?dDFZaFpOL3YvVll1M2ZGNmQrRDBXVU5MdFVaR3RkcXZVdXRhOVRrbEViSkhM?=
 =?utf-8?B?dW5CeUVQOXpjMFBtcnMwcnd3UnZtU3M4dGxQOWVRUk42YjRyeUc1Mm1RRzlR?=
 =?utf-8?B?Yk9nejRYSll5a1dZTjVneW0vS2VWbUdlYVVLSHNtbWk3Y1g2c0hoMDYvbWZK?=
 =?utf-8?B?QWJncllZTnJUZmtnTENINzlIemN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C7B9A85463F864181FB3FB21DBCB0D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e40a90-e7a9-4068-f20b-08d9ec42fc0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 03:11:08.6055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9tXbwzT9AKUY7tbwFJ1ipYdC2byiC0s+p7Z/8sSugeGluOMQok/hfepKZouz6zMUHl9mnHxyL5FsqOToOmZ1teCXKP4g6LdtknMysNX2v+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2896
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
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFdlIGFyZSByZWFkaW5nIHRoZSBzdGF0dXMgcmVnaXN0
ZXIsIHRoZXJlIGlzIG5vIFhSRFNSIHJlZ2lzdGVyLg0KDQpkb24ndCB1c2UgdGhlIGNvbW1pdCBt
ZXNzYWdlIGFzIGEgY29udGludWF0aW9uIG9mIHRoZSBzdWJqZWN0LiBUZWxsIGluIHRoZQ0KY29t
bWl0IG1lc3NhZ2Ugd2hhdCB5b3UncmUgZG9pbmcgYW5kIHdoeSBpdCBpcyB3b3J0aCB0YWtpbmcg
aXQuDQoNCndpdGggdGhhdCBmaXhlZDoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRv
ci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdh
bGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IveGls
aW54LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3hpbGlueC5jIGIv
ZHJpdmVycy9tdGQvc3BpLW5vci94aWxpbnguYw0KPiBpbmRleCAzZTg1NTMwZGYxZTQuLjllM2Vk
OTYwOTI1MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci94aWxpbnguYw0KPiAr
KysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3hpbGlueC5jDQo+IEBAIC04Nyw3ICs4Nyw3IEBAIHN0
YXRpYyBpbnQgeGlsaW54X3JlYWRfc3Ioc3RydWN0IHNwaV9ub3IgKm5vciwgdTggKnNyKQ0KPiAg
ICAgICAgIH0NCj4gDQo+ICAgICAgICAgaWYgKHJldCkNCj4gLSAgICAgICAgICAgICAgIGRldl9k
Ymcobm9yLT5kZXYsICJlcnJvciAlZCByZWFkaW5nIFhSRFNSXG4iLCByZXQpOw0KPiArICAgICAg
ICAgICAgICAgZGV2X2RiZyhub3ItPmRldiwgImVycm9yICVkIHJlYWRpbmcgU1JcbiIsIHJldCk7
DQo+IA0KPiAgICAgICAgIHJldHVybiByZXQ7DQo+ICB9DQo+IC0tDQo+IDIuMzAuMg0KPiANCg0K
