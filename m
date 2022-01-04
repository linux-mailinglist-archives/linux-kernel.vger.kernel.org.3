Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3DA483B77
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 06:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiADFU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 00:20:26 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:30464 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiADFUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 00:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1641273625; x=1672809625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SeIEnNmomHaXswcId1fJgCM16/iM8LET7OUfLFpJi8g=;
  b=dDb0DAfySXCU+83KNKkHLbgY8z4FUBcK/MrbG1woMkAW0tmlo2Vt5MR8
   9cleVq/g4sRisOX3aY6ouKmImKfrXI221ZNJgK3pDl9w1IPWKUEVWNZk1
   a8WvIzKWoX2Hs7zFbOQhWvoDX+KSx27dErM0C1u2N292meY+pAu73372b
   zaHlQOOukJNP+KlcyOqMCHqCXXAS+NyJfGcY9XIVhvOvbRyow8WbEtShy
   oTDyy52mM+X0cqTU0ws7y/EotqlTDKg5TaNyI/AwBxQ5FPqX549GV4/oE
   fTnytGgfKdI3Gur8Arv3xv3/2Wn3RQQMV1RVPYddzh+eT3ktseITgHsDe
   A==;
IronPort-SDR: iKI9r8GDLp8FeeIShD/bPD4B13cKeyE5H6QXZ/CYnTp8g1iPZhrKbBE+aWtRq6C42VHDALQO5v
 DlkgWSWL23SCoEKnm8VF71eFBbSkl7Ys0WSpR+H/SHVrc9TonHk/at0SU866mCWxDUSZWcTDh4
 /j4tAe790hfkO84D1kM+59bfsVni572AUdkQkHI9seFUvgODrplktcp8V7Gvm8ltE26U7Xu7SE
 e64noVMoX2ljngzawTiABhyJzGwmuQClFtb7wJFYeN75WU3VFww7J0C3RCQlv5arIzn9qO9Z3V
 THTCSwYv0WBX81ZkgZqMLiv3
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="148459225"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jan 2022 22:20:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 3 Jan 2022 22:20:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 3 Jan 2022 22:20:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxHjESjtt/smoRkTzokIHDOJHnnOfldZB7C3sff5pdyU7ILyitGBGWBxlnThrb6ZIhs/Y3HPYj+FglDAN44MA3xGOXBdcn5U4HqqFB8z7AWAbEwvmAapcFn6Ty4XS4b7XRCANqa9D9AgX+YO65v+BWim1WSrqEV58PbR2EcGzgxUnupDVXydoNr4+zCpGMN17pIB0z5snKKtTKk5WRTqzBB2FMT1D0IDCtLtrykCk/ApxwjBLFDkgGrgVvN3yB4DBaob4OJ+0dOHIGbNF3nnVZgJsKzt/oPcsfi5TPERYD5Z8d+VYB98G2m9rS8rziba70cEXhJW92H9X6iL25MDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeIEnNmomHaXswcId1fJgCM16/iM8LET7OUfLFpJi8g=;
 b=OLB75fGBGK95jAQ58zHBrNFI+AkjF7RkZxGpz3Iwa27nL2hGOEB8l2x8bQrXNKQmrv7sUZ9PzI2wiFV4sw/0UWdUyh69pBDL6ncx1y4kD5agzOsw7cRxLWYcdNGJ2y+KeKsbBi/8QXG1peacHXvWp8qOy860F0+icXiyRY1SVjdb7hSNyrAtFLbGhsJdNVAajXuzBPBRjzKzaOt3EVGKBLnLzrPfWEgjqn5J/cwDIRCAvVHiesYda0zBvXbg5do0cpwKZx6yo/rni+LWS0slfkAPTQLFiPBd39HUrnY5rnWtbYQJuFINFXC2TIIHIsPFA2CZpNcpPYTwhxKMAYw3nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeIEnNmomHaXswcId1fJgCM16/iM8LET7OUfLFpJi8g=;
 b=bOkOH9LpW/eVvXkPvCx3gHuTM72dyImCP+j1chnqhc1uzLkgi/7tg7hr9ILQks3WnJRsFTjgU008/Z3XILXY8OyrF8JtfU98WESr1D3mk6/Tg2qm6uYf0Ch7EmCWMJfOrP4D9tU4wLAbASHvoCTmXkcuCTO6bICighbPSf/Wg3M=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR1101MB2173.namprd11.prod.outlook.com (2603:10b6:301:5a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 05:20:18 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::b450:2587:13c8:e52d]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::b450:2587:13c8:e52d%7]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 05:20:18 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <Tudor.Ambarus@microchip.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <robh+dt@kernel.org>, <Nicolas.Ferre@microchip.com>
CC:     <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Manohar.Puri@microchip.com>
Subject: RE: [PATCH] ARM: dts: add DT for lan966x SoC and 2-port board pcb8291
Thread-Topic: [PATCH] ARM: dts: add DT for lan966x SoC and 2-port board
 pcb8291
Thread-Index: AQHYAKBSrdKNsl7IFESeRKblogsK0KxRTkAAgAECrCA=
Date:   Tue, 4 Jan 2022 05:20:18 +0000
Message-ID: <CO1PR11MB48651B354ABAF04ABB53FB04924A9@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220103124857.24351-1-kavyasree.kotagiri@microchip.com>
 <76804bd6-00e5-02ab-59df-d32586a55422@microchip.com>
In-Reply-To: <76804bd6-00e5-02ab-59df-d32586a55422@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a8c6fd3-e483-41c2-b0f5-08d9cf41e5d2
x-ms-traffictypediagnostic: MWHPR1101MB2173:EE_
x-microsoft-antispam-prvs: <MWHPR1101MB2173CE88D2BD746BDBEED28A924A9@MWHPR1101MB2173.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5TAzc/Hbe1DYj42TvTJ50x7qnaQq/Oo0paYueaDQrG23RsW3Cwmy5xHEO6/l/T46IVA5ayQu6cPRcBO3Pkk3fQTgNuNlOsFwTlG0rcmM57Hn1ijWW9RM/+nETfLepO9/S7TBQrvCND+zZ7uBliArnoglQS8zUvjB15Kpxa1afBovmBrOkp5p1ghVm6BB4CDxOksI2UrmkC6cOPPtNQQkeDQTBGC+ehAbHyAxJbWBPuQY55cnwlBYhqpAedpTJKMRk5FXNaFJQK4IgubrWq9CWAWQ2ikaakTU5bzORj1O8QrNPRBoikoJwMrvU2FNT7MiTL/akh3uyQ4a903kLEAkT0fjzR4NU12+NThayEpRL5KPgB16N8MrNGjntCfzy/X/+QXbzt1LUDELZuLiImATsMdgXQbFF5R2Sc5HdaxXjpc0WCg6jOGFGr8HuLWiwb/oW/eo7Xybod14Y0u5WT6ulPbn1yNFWjFuYkRNs3nMKw/BPKPCY2L63fiYpIJE8Z/SgPii2TSJ6bZAy5LnB7LM4wx2WuohwkmzB+M3IAScnR8ctYWvliP+VAE8nrU1YD7CZcOeJp11gTGq/xO2pvSp51vEcRMYFRmbN4r8tomqo5WOVCb0Qg4ccdaoyAvNzIQsw+k8ts7B4PkvmGuZBRLPyQTg7VvVsm4J2Qgfd5EUFXeFmvjQgy2tJ3L4dg1c8EMDh4Q9woiou5ZgFTnFCc+kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(107886003)(8676002)(86362001)(122000001)(6636002)(4326008)(2906002)(33656002)(66946007)(316002)(8936002)(54906003)(110136005)(4744005)(55016003)(38100700002)(66446008)(38070700005)(508600001)(66556008)(5660300002)(52536014)(64756008)(76116006)(71200400001)(53546011)(26005)(9686003)(66476007)(6506007)(7696005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckxWRHFQcVBwOUVUbWJld3VyS0VrV3FVMmxLNGxHZnNRN0tWR3ZRdElUdEwx?=
 =?utf-8?B?bWJ3ZzlwU3EyZ3NyUDFMMGZTcGptUkJydGpscmpIWEFyYTIveWFBN0YzanNq?=
 =?utf-8?B?QUhMN3BkYmVFQ2tybHMycEhDOEVqazR4cnBBVTJHRUxIc1RmVVhlVUh3eklD?=
 =?utf-8?B?SDdLbENJMXJGa1JFZEpEUkpLUloxc3FyWDBqLzBESEZjNnlBaDJXM1FFN2Rt?=
 =?utf-8?B?VXErLzVteCtLaEd4R3VpV1VLS2MwV3dPUlJiTm5CdFJpRk16SWpLY0dlVk1w?=
 =?utf-8?B?bkw4SnVNTTlxcGttNzNYSlI1WCtwL3hvbExwdHVhRzU4Uit6VktiSFVBNWlo?=
 =?utf-8?B?VjBhdkhDTGR0U3ZYcVdDNm1qb0ZrNDZxVEEyL2xoL1Y1NUc3N0dtcks1RUpn?=
 =?utf-8?B?dFN1eUJldzczd3cwUFo5K2E1QlcwVHMrQVU5aGRWKzFGOVVidkloUGRYQ094?=
 =?utf-8?B?cVdmRWtxM3A5WGRSRlh0MTFjNnRkcTZqcmk3eWpvK0hYZEU5RHY4Y2NmcnE0?=
 =?utf-8?B?L2s1NThpKzd6dnNDTlFTa3pLZlJjQTAyRVhFMGt2NmREYVVSQUwzc2ZmQnhy?=
 =?utf-8?B?R1B4cUZ1SmZra1N5bFhCSG1uMzB2M0ora2graHBicUI2MVRSZ01CUDJVZDY4?=
 =?utf-8?B?dmFRWDExYjlzMFpMVDN4NjZVK3ZpVkxaZDBaTjlKQzJialJRMXRFOHN0bWhn?=
 =?utf-8?B?UGJWV2t2NU40MDhwVFZXeVpUbkdjaVY1NWtCVjlsYjVoNVViV1NRVitia2pO?=
 =?utf-8?B?VFpHNDJ1bjZBQldOLzhaOVRyOTVEb0prbjI1UEZ4RjlvQjJsLzBQd0ZqVnlR?=
 =?utf-8?B?U0xQblVraXRxUjR6WDV3OEVrY1dpNXRYK1kyMmZyQXd1b1lRWFlnNEhDUGN3?=
 =?utf-8?B?K1V1OWJmT3VacU5aVC8rSnlaeHdGdEtSUEEvd1NsUm1aZFpiZ2l2U3FmVFNv?=
 =?utf-8?B?U00rTmtmdW9iVldvczRNenVLWmUrdmU0K1F1ZEpOSURhSjhEN0dieUVYemg0?=
 =?utf-8?B?c3pNb2lIMFcrdXB4bWZmeDJ6K21IUUhTb2g4RFhLamlpWmNuc0FBZXpEa2N4?=
 =?utf-8?B?a0pwNVFSekhPd3gzQVBPL1RhZzFPQllUbUpmRmdiKzB5S0tNLzdLcWloaGNX?=
 =?utf-8?B?Tnc2WW52bUJBWC95dThQRzJIMEJ4VHk4S1E5dGg0MVQzOEhkS3UrQThqenVF?=
 =?utf-8?B?WDRoZlFEZUZlOFFPZnFJaGFSclBKQURWMzJnZUxzVUlNLzlJVngvb2F2d2FR?=
 =?utf-8?B?OWhrNEcwZ1psTHdVcFA1MzVQejY4ZGphTGJjazJRNUdDSW9DV2k1MUJ4N0ZR?=
 =?utf-8?B?dHVpK2txQVVFY3Z0M29hTlgxOGU2YUtiQlloWmdjTzNPTGJTSDdEbjNQNFhu?=
 =?utf-8?B?WjcvbmlYV3IyakIzMEFmREdoY0huc2tUQmM0ZGp3NDF6VWZIU3VJM3o0S3JO?=
 =?utf-8?B?V1lUcU5jUzVUNW1CY3d0YTVleVlhREVyN1A4bjdvTUxjMGZQTFlDSHRHZGNG?=
 =?utf-8?B?NTFZVDh4WGFMUUw5Q0p5THlkNW5LUm1FaEorQ09DL0k2ZUg0d0lmTlZJTmxq?=
 =?utf-8?B?OGIrMm92Y24rMjA4R0dDbmVoY1FBUEY3RjJpS0hVY0J5RFQ5N28yYWp0ZjIr?=
 =?utf-8?B?UGZUMnpCc1p4N1puQ29Cd2hPRUxuTjVoNWtmMVVPamlrL1EzcC9Ud0lmSXc5?=
 =?utf-8?B?cS9nbHZIRjdUMnRvbHF3N3N5dFIvYllneDFJL1NGdFBYTTlqMkMrcWJFeW1X?=
 =?utf-8?B?dXZHblF5bVUwQU9wTVdQMWVrUXQweXNLQjRwbzNURUZ5STF1UGljYy85NGEx?=
 =?utf-8?B?QWRoVDBRZFRmQktUOTNQV3AwS1dCcE9YbjNBSzlyRi9rOXcramZmTTZuOWJ3?=
 =?utf-8?B?QU5iL0p6N3c1NllNZEdKTURFait0ZWRvYWo1OGNkRFFpbkx2TXVuOWhYSmRj?=
 =?utf-8?B?ckM4bWdOYXNiUjcrQUx5MEoyUTI5UEE2ZHNBdzE5RFQ5Rkg3dm8ybVVPeW9x?=
 =?utf-8?B?RzliUW9sVldxRnIyTUFlaG5OSVhvVlRvOE9OQWZVYmJiNHF2R1FqSXB0eXdB?=
 =?utf-8?B?QlFGa1FzTHVnMGNjamozNmhUWURodlNQRkliTFpCWElVVGY1ZUNyUFBHRnRJ?=
 =?utf-8?B?dUhvaEdMWldWM2JSMUZmM1FnV3dwZzJUQUpzeTlFSHNtT0owMncvRmE0aW13?=
 =?utf-8?B?V2lkZmxJWXdqdVBDb0hiOXo3cTlmVDU0L2FTOFFHVjJHRHQwNFFiV0NpZlU3?=
 =?utf-8?B?MWNmTmwzdmtybkNxL2Q0NmxIOVB0a0JUb2pRZkNvRGRkaGtjOEJWSUF1RHJU?=
 =?utf-8?Q?2ufWNPSGbFCfPHc9WZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8c6fd3-e483-41c2-b0f5-08d9cf41e5d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 05:20:18.3687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWKek5fHVhWVOPtaGxnxfxP8s+NxxproiHrLNdQOZNu8FLvZNTYRtUFuDyBPaHCMQLV/tAbU9s/hNg6NlkkMq0Y6JtFJh9JlWuI7nyU3hUDrnu9iOOl+FJZtHXfDvDIw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2173
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxLzMvMjIgMjo0OCBQTSwgS2F2eWFzcmVlIEtvdGFnaXJpIHdyb3RlOg0KPiA+IGRpZmYg
LS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4X3BjYjgyOTEuZHRzDQo+IGIvYXJjaC9h
cm0vYm9vdC9kdHMvbGFuOTY2eF9wY2I4MjkxLmR0cw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5jZDA0NTRhNzk1ZTcNCj4gPiAtLS0gL2Rldi9udWxs
DQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eF9wY2I4MjkxLmR0cw0KPiA+IEBA
IC0wLDAgKzEsNTUgQEANCj4gDQo+ID4gKyZmbHgzIHsNCj4gPiArICAgICAgIGF0bWVsLGZsZXhj
b20tbW9kZSA9IDxBVE1FTF9GTEVYQ09NX01PREVfVVNBUlQ+Ow0KPiA+ICsgICAgICAgc3RhdHVz
ID0gIm9rYXkiOw0KPiA+ICsNCj4gPiArICAgICAgIHVzYXJ0MDogc2VyaWFsQDIwMCB7DQo+ID4g
KyAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQiOw0K
PiANCj4gVGhlIGZsZXhjb20gdXNhcnQgbW9kZSBzaG91bGQgYmUgZGVmaW5lZCBpbiB0aGUgZHRz
aSBmaWxlLCBzbyB0aGF0IHlvdQ0KPiB3b24ndCBkdXBsaWNhdGUgdGhlIGRlZmluaXRpb24gaW4g
ZWFjaCBkdHMgdGhhdCBpbmNsdWRlcyB0aGUgZHRzaSBmaWxlLg0KPiANCmRlZmluaW5nIGZsZXhj
b20gbW9kZSBpbiBkdHMgYXMgZmx4MyBjYW4gYmUgdXNlZCBhcyBVU0FSVC9JMkMvU1BJIG9uIGRp
ZmZlcmVudCBib2FyZHMuDQpBbmQgaXQgaXMgbm90IHRoZSBzYW1lIG1vZGUgZm9yIGFsbCBib2Fy
ZHMuDQoNCj4gQ2hlZXJzLA0KPiB0YQ0K
