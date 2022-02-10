Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBFF4B03AB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiBJDAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:00:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiBJDAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:00:49 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454C2FF7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644462050; x=1675998050;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6zlUx1DcQullhsU56aJhgAnpYomuJ++9pPJo42TQyTs=;
  b=I69rwHOggSP++4bpjprpOovDGW23L6kZEmG1VxdKFfcFcyZFnxLEbQmn
   /sRDPcTk5yv2C8/J9EMdrFLlhb7+793jfOwsDTlx+ecKfHJdc43aU3exd
   NaUEDFxpf6IGcxwKiYsiIPPU7WGcHras/v5z0ftQWV0bSQ6ZcxxwCLAsn
   6lvsQpN3rj80xYqBGy0x+Mzf0D0Ef9GMe/iThPDp2QXTVVMqqupeQ6oJw
   gm1fSTqOIsCLebNkgrP3p9uil1fSw9Unv90FW00t+2BWfaorl85nCJnaP
   veuP6Cs+t+rJp2Em6jyetxJP5k5Vl39Mx+UQGrIewL2+pnbnfF5hdxJWM
   A==;
IronPort-SDR: a8sy+UminCmNyd0fxGMprSHA36xMIMm20O9W7k0b6C9hFdrzblOBYnTbTgubeaYCIrRPCWz5Cv
 P518T5HxwTk3qAPoAdGxCjh5oMiirL1zOECHBtraJrEpXqtu8CRD63X5UQIXw53iE4Cjd9wIfq
 3gCV8OLuu2hn8elI7NzDjpntHEnn1evl3B6KYzc2iKFs4Fs/XQveMA9mZui609l7QYncws1OSs
 Ghau83AflTNsdo6VruotArraAl4T58SHacwJzQkYBQOYR8WgbtTlOqcf1Lwe/fkt/SeecTUk2X
 TJ9vybysNlZdN4MY1bqdiyWI
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="148219404"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 20:00:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 20:00:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 20:00:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OG0kKnWbjBdoPIuQNIYs6Y+Jp7qFNAGOCHbdOB0jxqGtugz2rjKuIPvgp0fd0uPDtGTAB6HzH1QioCp1S5R98+A9rCNbYn6fMghaReUJmz7T6QIVmWHx6RXo+fJwRdmUohLQcQpL72MxQZK9o7jq9mBoNKtNYz5pSInqGwj6yzhz/Kg2jNcZeKiCsjfPUdKLURmhAf9nfYz89aIOmkhjJt6o79pwyhsodZsYDKYJS+QEzhD9660hRUGcQXc9OZV/tH6d2n4eBUou62zno76Oa8HkeNe+sIKK9TG0bZTph+76kXEWF77pTmP2XIaLdKbYAzgWoNPdECe2uyxEbt/c1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zlUx1DcQullhsU56aJhgAnpYomuJ++9pPJo42TQyTs=;
 b=MUe6rsWRicQgFrPmao90UYD5uMmB0POdQortNWogqc/SvWtLmIzAFkNoHC3jZK3zKrKhhJ7sw6Itoks/Iak5MvrL5PhQOdKbTo9ZL/do2xvwgo7kMlB1Fak8cdhlwxM0T1yClgcb3vlvfdDo5nD4+gA5Bv5gIoD2nLx88nfN6vcKxU0ARZSP9yDC1Lre0cKLFwEkLsdHJEZHHNVn6b+1mIBF3CwwsFP3PUyw7zHdszIHCq1WbLRGFWxcUo/WFoHrq5PV29jKU3J2JHiXj+sWTvYfvHV9C66jAxpukGjyhujEvo1x5aLWWOs7wLeak5juDES7ulXpjRHG91rggR6MRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zlUx1DcQullhsU56aJhgAnpYomuJ++9pPJo42TQyTs=;
 b=Ia7gqBznr0RLVBIgwD5zROY6HC8fCv6Qokrn582GNWg9z7dCb0+oT8FlAdvT35GenBEmUDerSJ8PvOse6zB8iIxlaJeZVZqnJTLjucHyzfbB1061b18HVCJxiAyaEbZQrKbMgbX+NFRV6PoAuRBtxssNKXsiRHPjainFYsNBuKw=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BL1PR11MB5255.namprd11.prod.outlook.com (2603:10b6:208:31a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 03:00:38 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 03:00:37 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v1 02/14] mtd: spi-nor: slightly refactor the
 spi_nor_setup()
Thread-Topic: [PATCH v1 02/14] mtd: spi-nor: slightly refactor the
 spi_nor_setup()
Thread-Index: AQHYHiphPQSfofc8m0+TtNX2dRXljw==
Date:   Thu, 10 Feb 2022 03:00:37 +0000
Message-ID: <f4a7a2c2-579c-f558-3d85-cf0709a6060c@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-3-michael@walle.cc>
In-Reply-To: <20220202145853.4187726-3-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0137dea9-0c1a-44da-254b-08d9ec4183d2
x-ms-traffictypediagnostic: BL1PR11MB5255:EE_
x-microsoft-antispam-prvs: <BL1PR11MB52558AF9A12BFE047A9F0C89F02F9@BL1PR11MB5255.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WtasleHLSufO4erkyHXtlL+L+xH0Wr9kUW3OBikDgNE6NB0s/939KkRHq6buEIlCkjuc3e9ovxdUHGAd7HrxYdmSGzTtsONxN4RMoVbCEu6dJn6ltWxr5QtOYag5JxEpMR0f9ptNEKZNIS4WpVTTOHRN1WS6HAjQ/Jr6TMl2JHNy7Ydif+AsLqAJ6PMWnv9LxPBzGBOUdD5Z/RJlBXc2fOWhFJrdMMCqBE4PHFHdo4qyYBk5JI8ECd0verTjCpdgDXIlsBEwdWbbrgCEL/VpjfyoXiGe4NvcCnn0XmD3vYg8eGNLWhJvarb42O+sBd5heTCBvkxYoKywQnaYLaaPWu7QIeRBXO9zEUr42yNUWJngNHnrqtv/4TU/IRvBZYvRnmij+33IVS5VNlPMpgEEOZGAl6LBmP9IoJRICkKmNy/4rUoW8DDJrFyb95Yg/ZRvcwJg3BkniSqHv7a0goXg+EEoSiUP1KFTueWntpnazT2tayrSecq+ZpA701AUBlff/QMomAw9RulwpfCkrtihx3XEqsQQXcjn724rbMBD4cDaY+/P9pz4Bg39ZCLybMTv/VEmTB5Ca3SnrF6SsoQqQqEXa36hH2usLziyhPIqHapxEVqLPmBX2QyLW1cXNOd90G69yPh7eeILKvshLhZWVxPuDpsd6qOg15GDFvQUue/X2Xb6GJceyhr+mgSpXs0lBvGhDqFEKJAFqyytCLIy5HR/5OtyJ3DhFwfFwN/DnxxErFBSrZPeZc33Mc7hQC8TSm2SuiO0uFOKvk4wfqpn8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(6486002)(54906003)(83380400001)(38070700005)(76116006)(316002)(26005)(2906002)(186003)(2616005)(110136005)(31686004)(122000001)(8676002)(6512007)(5660300002)(86362001)(508600001)(31696002)(66476007)(71200400001)(64756008)(38100700002)(36756003)(91956017)(53546011)(6506007)(8936002)(66446008)(66556008)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEV6ZGtjNmNTWDFDSFQyK0xSVjdYSG5mMXZYRitGTDFwZ01tUm9PMWlUUjlP?=
 =?utf-8?B?Q1E2anFCcyt5Y3kyYlNxamhtVFFsU2NZUG9Ia0tLdVlMTC8rUWV1cEZma1dY?=
 =?utf-8?B?WGl4dHNXS1hiN0ZTSk9QbDh5UTRhRFpyWC9maUQzak1vTlNBWXppWWNKalVD?=
 =?utf-8?B?YWNEYkdKcDB1SFJHVTlQNW80VEtyTTIvSUo0cHlvK3lLKzJ4aVVEbGlmcFlu?=
 =?utf-8?B?VnhISG1hT2ZHMHV5YUF6TEM5S2dqZ3NEblh6MnNvN3VWUHVhMm1ZeU41eGdD?=
 =?utf-8?B?b3hYekUxTVhwOUhCWW5nc1NLNytJUDBZc0FmWk5FQWNaNGloZENmUzVXWGlp?=
 =?utf-8?B?bXA3dHpZaCtnWVNOTnM4bE5BcnEvYUtYNTNwQTNNMGRMMmNEcTlrNlAxRFI1?=
 =?utf-8?B?dytwS0pENmw0c2tZQ2NYMFlZcUwwVGFGRWlUN0pZb0lSeU1jVThWL1N6akQ4?=
 =?utf-8?B?UHhvUURiZm5sUUxRanJxdWpCUDJ4Rmw5NWNXd3NzRlRLMTBRa2Y1em5rdTJr?=
 =?utf-8?B?c04yYnpDMWxRajF5Yk41Z1hiL3NmQ1JTQk90dTZWYTMwTEdBaXp3UzhtcWxD?=
 =?utf-8?B?NEFPWVJVdm8xVUk5ZzJ6L0pUV21PSkZmbi9JZVJhdGk2QWJieWNuSjYvMjcx?=
 =?utf-8?B?c0Q3b3M1Qm1yanZiRllxYVhLdVhZVkdVbmltOCtYaWw0TkVxbHpNMG05Q3Zj?=
 =?utf-8?B?NnE4ME1QMHo4cWFnclB2d1g3TFhCNFpXMUNqTmZ2RWlGa2tHWm1XZzgvTlB0?=
 =?utf-8?B?by85M3h6NU5uQTdBRW1XbkRpNHZrV29hT3VhM3lEL3BxSUd2WmhzMG9ZUGRj?=
 =?utf-8?B?eGZKZDVTZ0ZXS3pPRXpDQVArOHNqZHo1ZmkyaG8wVjhxemFvNm85clhGSUVp?=
 =?utf-8?B?L3dOUXJraDZycll4V3d1L3REVjZnWmZBalJyOCtxK1R5WXNVd0RvOGtjbzhp?=
 =?utf-8?B?cWxyWUF3Nm5ZSG1JY2JsbE02VW5Qc1U2WUtybUtTeUlLbU9IZzJTWGtac251?=
 =?utf-8?B?TE1BaEwrL3hldUdFOExTYk5oN3dycnhBSHMyTWdQWUFtZUVsY3diTm45bnpl?=
 =?utf-8?B?WHVIRDgvQTdNeWZCT2NQR3VRdGFZWG9UTkhta1ArMStLenV5bTBHV29RdHV5?=
 =?utf-8?B?NHludWV6dngrNGhNZmQwSHR4a3Z2TmMraWt6b3FreGdqdVRya0pVa3hlc3ov?=
 =?utf-8?B?WWtsbnZLZmJTS0pZWmkvWDBPaXFVYWQ4SlRVN3NMU2pNbE94dU0rMC9jNmNL?=
 =?utf-8?B?OGZINUd3eEUwZklXZjY3WFp4Qm9nWEMxWDVGOVlQM1drN0QyaTFRMHduZzZx?=
 =?utf-8?B?UTdyOWU3QUxibndxallCWEtxeXBCbm5kWmhQcWxrdzBhWU4vQXJacStRTTlO?=
 =?utf-8?B?eWZVbE84dDFyS2QvR0x1NDJ6ZUFuL0g0N3FLN0xVMmQvVmRyNElGeFBuWTRy?=
 =?utf-8?B?UTloUW96UEYrSkVQRmFjK0JUWXR2RnZoOTB2YnNodGxnc00yQTNiTkRJMzRs?=
 =?utf-8?B?eVpmMGlFMlFOenZkS2RyM3RDNDVmcTYzUnZzTms2ZXRVNUVCRTJTUnBpaVdE?=
 =?utf-8?B?TEpUL1ZHc1d4akNTQ2NNblVIMVE1Zk5KNC9MSnJENzVCS01JL24vQWVVVDZ3?=
 =?utf-8?B?U1QwYWRSSE1weDgydzR6ZG0yNEdsektVRFhKd0xtMnN5NHArK1lWY1Z2NFpl?=
 =?utf-8?B?Z1hqcGJYRm5udTBYWnFLTzVKOExock9MWm13TXFJYlQ1aXFpQVFVQi84NzBC?=
 =?utf-8?B?SG9BRm9BMkVtbjNIMERTcXpkWWFiNlN6M2dHKzR2Z240UG1TQXB5NzE5R3Np?=
 =?utf-8?B?OG1vSnd6TjZ5TExlcGw5WlFaYmREODhOWHAzZE5ONHRwTm93U0pmcEQ5YjJK?=
 =?utf-8?B?Mnk2Z01WZ3Z6VGtyYjVyNkpTSjZOWXF3N3Y3S3FHUUZNUnVFODhxalhoVGZU?=
 =?utf-8?B?SjYxaTZHb0RUS3ZSc0ozVWdTSzBZWWI5SWdnZm5aZmRxWXBFYTI4ZjVlQnFF?=
 =?utf-8?B?bHJYVXJmVlcrNW9sMmNGaERxRzhvVzFncy96R2NvME9tTUMxdlpLYXlZTlhk?=
 =?utf-8?B?dnNobTNBeUhYZFYwczNUbGpIemkwcGF2aWpUdkFUek9pQ1BJODYvU3R6Vld1?=
 =?utf-8?B?NTVFYUJwQTB5c0Q5NmhFYUQ2citSSkVjSjBpRzAyZ1hzWm5rK1Z1N0tpSkx5?=
 =?utf-8?B?Q2NIa1lTRDZ4WWZIOGFmYjVlNmhKMzdrV2QvNXpNVitmcFFVdzRyeEFPUG9N?=
 =?utf-8?B?VHpLWkVMSmZ4UzZHMnVibWZNTmV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EB0FEA5CA649F4C8E70873838793EA0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0137dea9-0c1a-44da-254b-08d9ec4183d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 03:00:37.7627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZaxFC/7/TD+G+BbBa4Anny5vKPTGwAHRezxm4dXk8wYCQasXJCBlvQqwnpLmzvpjrOQeWunK9Lbp96S+FEE0pCp/GlpW3aQNVXAYoEW/Lw=
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
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEluc3RlYWQgb2YgYWx3YXlzIHVzaW5nIGEgZnVuY3Rp
b24gcG9pbnRlciAoYW5kIGluaXRpYWxpemluZyBpdCB0byBvdXINCj4gZGVmYXVsdCksIGp1c3Qg
Y2FsbCB0aGUgZGVmYXVsdCBmdW5jdGlvbiBpZiB0aGUgZmxhc2ggZGlkbid0IHNldCBpdHMgb3du
DQo+IG9uZS4gVGhhdCB3aWxsIG1ha2UgdGhlIGNhbGwgZmxvdyBlYXNpZXIgdG8gZm9sbG93Lg0K
PiANCj4gQWxzbyBtYXJrIHRoZSBwYXJhbWV0ZXIgYXMgb3B0aW9uYWwgbm93Lg0KDQp3aGF0IHNo
b3VsZCBiZSBkb25lIGluIHRoZSBmdXR1cmU/DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hh
ZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVz
IDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuYyB8IDEwICsrKysrLS0tLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29y
ZS5oIHwgIDggKysrKy0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA5
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29y
ZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gaW5kZXggZjA1ZWNlNjAxOGRjLi5j
OGNjOTA2Y2Y3NzEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+
ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+IEBAIC0yNTMyLDExICsyNTMyLDEy
IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9zZXR1cChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPiAgew0K
PiAgICAgICAgIGludCByZXQ7DQo+IA0KPiAtICAgICAgIGlmIChub3ItPnBhcmFtcy0+c2V0dXAp
IHsNCj4gKyAgICAgICBpZiAobm9yLT5wYXJhbXMtPnNldHVwKQ0KPiAgICAgICAgICAgICAgICAg
cmV0ID0gbm9yLT5wYXJhbXMtPnNldHVwKG5vciwgaHdjYXBzKTsNCj4gLSAgICAgICAgICAgICAg
IGlmIChyZXQpDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IC0gICAg
ICAgfQ0KPiArICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAgIHJldCA9IHNwaV9ub3JfZGVm
YXVsdF9zZXR1cChub3IsIGh3Y2Fwcyk7DQo+ICsgICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAg
ICAgICAgIHJldHVybiByZXQ7DQo+IA0KPiAgICAgICAgIHJldHVybiBzcGlfbm9yX3NldF9hZGRy
X3dpZHRoKG5vcik7DQo+ICB9DQo+IEBAIC0yNzg2LDcgKzI3ODcsNiBAQCBzdGF0aWMgdm9pZCBz
cGlfbm9yX2luaXRfZGVmYXVsdF9wYXJhbXMoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gDQo+ICAg
ICAgICAgcGFyYW1zLT5xdWFkX2VuYWJsZSA9IHNwaV9ub3Jfc3IyX2JpdDFfcXVhZF9lbmFibGU7
DQo+ICAgICAgICAgcGFyYW1zLT5zZXRfNGJ5dGVfYWRkcl9tb2RlID0gc3BhbnNpb25fc2V0XzRi
eXRlX2FkZHJfbW9kZTsNCj4gLSAgICAgICBwYXJhbXMtPnNldHVwID0gc3BpX25vcl9kZWZhdWx0
X3NldHVwOw0KPiAgICAgICAgIHBhcmFtcy0+b3RwLm9yZyA9ICZpbmZvLT5vdHBfb3JnOw0KPiAN
Cj4gICAgICAgICAvKiBEZWZhdWx0IHRvIDE2LWJpdCBXcml0ZSBTdGF0dXMgKDAxaCkgQ29tbWFu
ZCAqLw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggYi9kcml2ZXJz
L210ZC9zcGktbm9yL2NvcmUuaA0KPiBpbmRleCBjNjU3OGQzZjU5OGIuLjEwZjQ3ODU0N2RjMiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmgNCj4gKysrIGIvZHJpdmVy
cy9tdGQvc3BpLW5vci9jb3JlLmgNCj4gQEAgLTI1NywxMCArMjU3LDEwIEBAIHN0cnVjdCBzcGlf
bm9yX290cCB7DQo+ICAgKiBAY29udmVydF9hZGRyOiAgICAgIGNvbnZlcnRzIGFuIGFic29sdXRl
IGFkZHJlc3MgaW50byBzb21ldGhpbmcgdGhlIGZsYXNoDQo+ICAgKiAgICAgICAgICAgICAgICAg
ICAgICB3aWxsIHVuZGVyc3RhbmQuIFBhcnRpY3VsYXJseSB1c2VmdWwgd2hlbiBwYWdlc2l6ZSBp
cw0KPiAgICogICAgICAgICAgICAgICAgICAgICAgbm90IGEgcG93ZXItb2YtMi4NCj4gLSAqIEBz
ZXR1cDogICAgICAgICAgICAgIGNvbmZpZ3VyZXMgdGhlIFNQSSBOT1IgbWVtb3J5LiBVc2VmdWwg
Zm9yIFNQSSBOT1INCj4gLSAqICAgICAgICAgICAgICAgICAgICAgIGZsYXNoZXMgdGhhdCBoYXZl
IHBlY3VsaWFyaXRpZXMgdG8gdGhlIFNQSSBOT1Igc3RhbmRhcmQNCj4gLSAqICAgICAgICAgICAg
ICAgICAgICAgIGUuZy4gZGlmZmVyZW50IG9wY29kZXMsIHNwZWNpZmljIGFkZHJlc3MgY2FsY3Vs
YXRpb24sDQo+IC0gKiAgICAgICAgICAgICAgICAgICAgICBwYWdlIHNpemUsIGV0Yy4NCj4gKyAq
IEBzZXR1cDogICAgICAgICAgICAgKG9wdGlvbmFsKSBjb25maWd1cmVzIHRoZSBTUEkgTk9SIG1l
bW9yeS4gVXNlZnVsIGZvcg0KPiArICogICAgICAgICAgICAgICAgICAgICBTUEkgTk9SIGZsYXNo
ZXMgdGhhdCBoYXZlIHBlY3VsaWFyaXRpZXMgdG8gdGhlIFNQSSBOT1INCj4gKyAqICAgICAgICAg
ICAgICAgICAgICAgc3RhbmRhcmQgZS5nLiBkaWZmZXJlbnQgb3Bjb2Rlcywgc3BlY2lmaWMgYWRk
cmVzcw0KPiArICogICAgICAgICAgICAgICAgICAgICBjYWxjdWxhdGlvbiwgcGFnZSBzaXplLCBl
dGMuDQo+ICAgKiBAbG9ja2luZ19vcHM6ICAgICAgIFNQSSBOT1IgbG9ja2luZyBtZXRob2RzLg0K
PiAgICovDQo+ICBzdHJ1Y3Qgc3BpX25vcl9mbGFzaF9wYXJhbWV0ZXIgew0KPiAtLQ0KPiAyLjMw
LjINCj4gDQoNCg==
