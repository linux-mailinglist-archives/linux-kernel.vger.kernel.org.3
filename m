Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929BA4B07B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbiBJIFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:05:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiBJIFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:05:33 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05B41088
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644480336; x=1676016336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3dqzujG+iu/hnAZQDMcD3YhCFWw6Tk0ywCplziOysKk=;
  b=P+jOhXyrAiVEBTBfckk1m9HLn+H+DC3peMpY2hDwOQYXSVF0Z240lEKE
   9aIq2Wz4YMU7YfTJXQ3aAfSLHcHwIMMPk6HEwtphSN75y5cEd/OPAis8M
   dVgRKeK3YQM1z3WmitAkEIXGdHXWgFEsU9ZiYY+rEMPbvdcuJMrQu2fZe
   9Qeg+vlhU6qnEJ0G+0IeRoEBInql474QJjwp9bdztpMMu724sZu0N/Knr
   n9xha3/MJh8GxAKAOJMhr5bM8UBXojMaRgPD5Yasxg39WqXAH0KPFbNnE
   I6SDWkyhnWO6DJu+9pH+Je4VkIO9OTYCPxVl8JkW4My2RqHxcFcJMhYoo
   w==;
IronPort-SDR: 3oEbLFKKKnuDIkyfQcGRsMG3wTfoxH2evRWNlsf0mmaWP/S4va/wV/1Qsk2DIXk8KnyihOo5Yw
 pEPTInyEP4aw8C2VYANRLEuDzz+grcjVkiPp58t/+Q8+hCUxy0YC2pMizQgrubBQmZU6zIeuhV
 +jUwv3YQScl0OM8o4LqJMstUgV386NZdlqMbE+2Ke4OD4pAHHfQylnvh4HPUs3hx+8E9Th6nGL
 J9gk9zJR9KqYtjyneC90FNhZqORXnu6fVJLqYDf7+RS+jYcIli7PhoCCs5IRukGZ2iyQleb10F
 WjEwIUTiT2q4juthmCEeJ6AF
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="152579547"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2022 01:05:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Feb 2022 01:05:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 10 Feb 2022 01:05:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ws2f0KnRqVahoMZ3PCwkfDCzWaUA1+OP1qVgBCTcbJhOYVEcP8SYmd8uaA8VafgCjxy0tbaJYncl9rP8SaoBS4oTY3cM4zfIUgIgA4YVIdiiUzo5SFvpQxhpFhd5jeO5ajkyaKjLaLZogdY46AZkZuYWdodYavEFviPeeB5/7gZr1uy07qlQbUOqr4YJBo8FKZCBueJCM/fY2fcu2nBUDSa4dfx+2AxBSnxvWO5bJGn017kW7xOVAyuD1nn+P9+22NT7v0EKucofTQSJz0baEmHTR1BbrgvpIsBUnxE3vbAZkexQNcqyJPAysKVbj9AtjfhGslm/S3JhjTUTcvFalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dqzujG+iu/hnAZQDMcD3YhCFWw6Tk0ywCplziOysKk=;
 b=NFfN2cqifokMEXwTc20TDdbxCQt+SM6aWj5GJXlQHdKE1SXd/SzkFO2yTbKjXLqC+M9vA0OgAFu+LUuFa45ha2fYvPDkYheElj9xuliWGbOrl15ut4pSyev3YWMGkGaffOj9Rt5sjSvrVOY9VU79eOdqM7HutNeAmKxVOpwOdou/daORwbWgttmBQcuramxHIXi/HagTrfszBkanddMmuYXkX3rP7yxR3t3H+19m7cuHDBytjyEqZjFjDxl1yFa+WQMtKfdFtUmnIxd+LI39HwGGNxbDlpYEY+RB/MgkdZPzFOqJ/cuYsrif1x+2mzG1utO1SeAnVQ+3SHIx/fuLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dqzujG+iu/hnAZQDMcD3YhCFWw6Tk0ywCplziOysKk=;
 b=F7koGr2TA2HSkeQwt1B9vL21StoRZJiH1kxYAf/Vhq53LKZzd9dEmNDG+trUPjGOxYxpR+xofP29CuXnLI81JbANvAylFDHO5pqNLw0I9O8MthsXRQu1g0+Bp/3bbqqvyzAwsx6iUts+Zoz5owczEyALvl8FWdyfM5iZWy5boy4=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by DM6PR11MB2972.namprd11.prod.outlook.com (2603:10b6:5:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 08:05:30 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49cd:dd25:384:e918%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 08:05:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v1 02/14] mtd: spi-nor: slightly refactor the
 spi_nor_setup()
Thread-Topic: [PATCH v1 02/14] mtd: spi-nor: slightly refactor the
 spi_nor_setup()
Thread-Index: AQHYHiphPQSfofc8m0+TtNX2dRXljw==
Date:   Thu, 10 Feb 2022 08:05:30 +0000
Message-ID: <568550c8-c212-573c-5832-3d653c707fff@microchip.com>
References: <20220202145853.4187726-1-michael@walle.cc>
 <20220202145853.4187726-3-michael@walle.cc>
 <f4a7a2c2-579c-f558-3d85-cf0709a6060c@microchip.com>
 <0280538304fe8c837af0356ae469f428@walle.cc>
In-Reply-To: <0280538304fe8c837af0356ae469f428@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7527ef30-3c70-43e0-f42c-08d9ec6c1b0f
x-ms-traffictypediagnostic: DM6PR11MB2972:EE_
x-microsoft-antispam-prvs: <DM6PR11MB2972FF36E85EE2643938362EF02F9@DM6PR11MB2972.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m+oBhpl+lsO+nS2kqVNaeofeG2UwSWKECz9FouowB0Osn6S24AXRrDPwZxVIdCG67WJP1Mof8zEjfvzlCdjkkwmAUysZ4nviA4pfCq24CrhREtHU1bSD3WumPt2USS1SFq1pkjuNIn+GU0a2X6tKN4iYUDPZYvBbhdQc8AAizUZPakqVymdcdoLz92NARL1WfA2wDT4XBCAyjv36pSfsD0v6zx7f54pBLyLAa3v7VSw2drvzEsuXWokHM4PnOBxfCHhBEVvxJBCMC5+s3yEnyxLEtd/riJuaUHpYdtQ9D3LeJG9c7uBgVMO1Q8UdDA0ntyAU7pMRZ3PBMYaIYyErAcT1d/tAMd55xtn4A0eO/J4GGbWIsFeyE8eLObuRck0+1Q47l7cTtdgrZOajEMGpx60bl9/7HE86PJWXqAM/WAqgSRbEf+KTjKkxZA636l9+IH7yILHPTdVKnP9KhzLfI7qAZny6MBrzsGOEjDvSRNzwDynJK8pnDrvUbXsdFAvHd1AmakfWVUH6ESg5ADW7wTDd6xv3S7H2otcAzINNSu5TR9UUnKZYWGrzRkvozUu77Dk3vvr5x+2gE6EQ5v++V78t+HHr9rxZM8o5qt9MVZVY5vL2t8foL9RiYs+tNwGLdNWS0ONacyym3JxGolkS0HdbZAYzDIIwM+1IMQ721aKreplE7MeO1kQg7WdVDioJ0vdv9KVWgb/8DFXx6aHVSwvFlZtRt1IB0EWP+sxUBGHir+ulgsC1t8z8XovvPSbR0RC941WdWRNlzQ/iwkmB6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(4744005)(38100700002)(71200400001)(122000001)(31696002)(36756003)(64756008)(76116006)(4326008)(8676002)(91956017)(66556008)(66476007)(66446008)(86362001)(316002)(66946007)(6916009)(54906003)(31686004)(508600001)(186003)(6486002)(26005)(38070700005)(2616005)(5660300002)(53546011)(6506007)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEdRM0FDWGM5SjhTbWEva0tBS24wTiswWFVHZEk5eTI2ZGZWMmlXcnRMbGJh?=
 =?utf-8?B?dndZbEo2UTNQaGFTendPWDhjY0NpTmNuWE95R2lJTWl2NllVL252elJ5VUll?=
 =?utf-8?B?WUJrNkN6dDNxVHdHdEtxTFQ3d1gwZUJ3RUZMYTdlczNwNW43cnFjKzZ2QnIw?=
 =?utf-8?B?ckZOd3I3TlZhZGFqcmRTd0cxWE42a1BqUzQ1b3JJcHZ0TU9jN3NuTTlXUUxt?=
 =?utf-8?B?R2IwZmp2cjFuUi9yWmkrQ0ZkVW96QVMycDl4VzMvRVB0bUJtcGZkTzVBOVdy?=
 =?utf-8?B?bUF2YVRTUVIxNk5KaFFFRzd1WFdvK1ZtUi9FRUFkR3dBTlN0OEJveHhZdDlv?=
 =?utf-8?B?SEtyb1BOK0M1TlVBWTlScWtqZ0xnVHZXaGsrS0RjdVQ2Yk9HcW5LWlNodkxV?=
 =?utf-8?B?RDc1dE1PWW9kL0pwaFNXM0FkSEQvQjhoUXFqYlAvYWZ2clBtaGNZTDBwTlAw?=
 =?utf-8?B?aUdpZTRYQmVTbE5wL1gzU042dURXUFRYS2hENXY3b3IvTGR3SHlmVjJpdFl0?=
 =?utf-8?B?bTVCR0ZqcmY4UG1SdHg5NXh5SU03NTk4aVJjVE5vb084ZXZib2Y4a1FxRFh5?=
 =?utf-8?B?cXhZTDd5Q1B0WG9xa1U4cHFJZVJLRkpQTUxDWVgxamdJRFlSRWp1VWxYV1Nt?=
 =?utf-8?B?YUJqTkVqaHZYWEQ2RmlzREwzbGtYaGVidjdkc295cmx4WDNjY3h0US9oRGFh?=
 =?utf-8?B?Z0FYOWxmZm9FMzVwVWNIcmQ1TlhxMEN3RWFqYWZUSVpBMXJtZ3BvcEVFTlZJ?=
 =?utf-8?B?b1RVQ2pGTmloQ3BaaW1nQWdzVW9XcXNuREoyOXIzc3VxYzBwaXZPZlRhbFln?=
 =?utf-8?B?NEtkdG1sdGRCOFBmYVVndkhmMFpoeDdGaFhPeUZib1VJbmIvVXNReUszS3Zi?=
 =?utf-8?B?UTBQaG5pVDFDY0ZMM1U4Mlg4M2ZWdjdSSnc4QlRyYUduTDRRRHlrbzY3U09o?=
 =?utf-8?B?V3Ftb0paWVVMR3RDZUxlK2E4TmtQRnpSTFluUzRFWFp2dDhxUGVJNjZ3cmJJ?=
 =?utf-8?B?b3FIdlo5aU9BcGdQNHl1eWR0U0kvRVJJVG16c1ZKbS83eDdnTUJsSGFuQnZt?=
 =?utf-8?B?L2c4eUkzQitkbHpOS1RUb2FhUElUWXpIQkNhaTBBeVFHT2NsS25UWndRTkNO?=
 =?utf-8?B?dU4ybjN0SmtYenlCNG0rVFQxS2luQWpjRjdJd3ZYMGV5ZUZuMnFPaUtQM2lN?=
 =?utf-8?B?UEs5K3JsZDdXSkRVNnNScWdUYWFJemRSNHNyWmxBYll3MEpBWUM4UUErZ2Qz?=
 =?utf-8?B?cGtDcWFmdlNrMm9BdWVCVklEYTBnOFVHaksrYUJBUkZlMXBlOE1KTGhtZzhr?=
 =?utf-8?B?K0ZWcXc5WFVSL2lXcFJKRlhhM2tvaFNQV01vUXd3WGJQbWhFd2h0WHp6ZC9l?=
 =?utf-8?B?d1NWZ3k1ZEt2QmVGWC82UlFqNDNFQmt3QUtmeFJqRE9JYWkzTzNPNVpkNFdF?=
 =?utf-8?B?MmMvVmRVRTloc1ZMa1FNNkJ1VVJzREFFVnlJNHJVT1hQcmZTTnpjSmxXRkhi?=
 =?utf-8?B?QlZwRk45RmZDVDR4TVcwT3pyQitDMkh1Z0c0cmNVaWVFR1JudlNDdjZKWjF4?=
 =?utf-8?B?UGg4YjNnSE04SnRsK3lSTXR5QThpTlhvbmlvSFV2bjV0L3hTL1hGL05xYlhL?=
 =?utf-8?B?OFk1RU55bG5jbk9CZVBpWGN2ZHJlY0l1MDRWeDR1NGM3LzExOThXMXZ4cTJ1?=
 =?utf-8?B?SWZyMGc4SU91amR5NHBCNGVXMnpIWTNKeXhEQjhYRUhZZFJqNk14aGtMZGha?=
 =?utf-8?B?Y3FHOGdNVTUxR2Z6QzhEL2pCdnJJQWpnVGVKeXpLWUNBSmhLUGdEV2hYaGhK?=
 =?utf-8?B?dzFDRnJSSHZIQmFXdlZyWFozQnJXckVzNkt2U0hhUDVyV1RLWS9TRlZwa2wy?=
 =?utf-8?B?akNpT0hOeFpVVVQrRFFQRXM1Y0F2TjJGM3phYXNqMjJXSGtBOG9tRVFQUmpG?=
 =?utf-8?B?cWVUUDlaOVpIOFkyK2s0cDBYL0RkYlpUUnRmUlRGNFczaGdpUGgxU0JIRkp5?=
 =?utf-8?B?YTN0VWFLUCtvMGR2dFVtSisxTkJqZkFlc295Nk5BM3dDVGFmb1B5M0U4elFm?=
 =?utf-8?B?QjFoZW1xNmdaZ1J1TnNYSjZ4eUx5ekgwaWpkZjZ1NFF6Z0d1Tzc3T0RIN1F5?=
 =?utf-8?B?VGlyckh4RStMK01tK2wwS1BRQU1XQm1tZ3hWc3pKWlMvOE5xSGNKck4rT01Y?=
 =?utf-8?B?WXZ0VEtUMm9rdVZyNzAyRjR5ZUxoRWZoa3g5L1ltYzVleERZWFFRRUxlelQ0?=
 =?utf-8?B?VkVpVjZtVThvemNNUGpUcUw4Wm9BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCD23E9F95165C4AB31993174465A77F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7527ef30-3c70-43e0-f42c-08d9ec6c1b0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 08:05:30.3195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28Yuxa8X5dlaLgBlFtK9/GyMg/ZNivI+iDYuIqZGT+8blNMmHl7F2eWKqS+Ey7bDRv6Im9gRDQ5GAlu5+p41I8OGoFex6c0qUQpZMqDrg5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2972
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xMC8yMiAxMDowMSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIyLTAyLTEwIDA0OjAwLCBzY2hyaWViIFR1
ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDIvMi8yMiAxNjo1OCwgTWljaGFlbCBX
YWxsZSB3cm90ZToNCg0KY3V0DQoNCj4+PiBBbHNvIG1hcmsgdGhlIHBhcmFtZXRlciBhcyBvcHRp
b25hbCBub3cuDQoNCk9oLCBJIG1pc3JlYWQsIGluIG15IGhlYWQgSSByZWFkICJmb3Igbm93Ii4g
VGhhdCdzIHdoeSBJIGFza2VkIHdoYXQgc2hvdWxkDQpiZSBkb25lIG5leHQgOikuDQo+Pg0KPj4g
d2hhdCBzaG91bGQgYmUgZG9uZSBpbiB0aGUgZnV0dXJlPw0KPiANCj4gV2hhdCBkbyB5b3UgbWVh
bj8gSU1ITyB0aGUgZGVmYXVsdCBwYXRoIHNob3VsZCBiZSB2aXNpYmxlIGluIHRoZQ0KPiBmdW5j
dGlvbi4gRWcuDQo+IA0KPiBpbnQgc3BpX25vcl9ibGEobm9yKSB7DQo+IMKgwqDCoCBpZiAobm9y
LT5zb21lX2V4Y2VwdGlvbmFsX2NiKQ0KPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbm9yLT5zb21l
X2V4Y2VwdGlvbmFsX2NiKG5vcik7DQo+IA0KPiDCoMKgIHJldHVybiB1c3VhbF9jYihub3IpOw0K
PiB9DQo+IA0KPiAtbWljaGFlbA0K
