Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEAF463F79
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343813AbhK3Uvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:51:53 -0500
Received: from mail-am6eur05on2093.outbound.protection.outlook.com ([40.107.22.93]:8224
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343801AbhK3Uvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:51:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KN2Ax0R5IJcufHTsXokqsppfuiZCI7gq0N+olv9684le5KSFn0fG9exWUqLZZosiwsEvEzU3n30XOg+A5lcoqHZxskKMGmSbLzlrq9wlibwnuv2A6Lg8a+NYiUNAfM+duPQxYWTsiwGuFd0myQ8JfodHWBMNTv5SNFRsqT+Pi+/g3/5BZBBQy/wuGAJozyrzadVofbB/TfNjGnlyH2S+AztHS0S+univnBYbhW32WOCeIs4OI+h2jzdeCtDO2VLX54waRrVW0bsTI2GMLfjwWiYPIzoWOAf/fO83WwfbWWBEafzj7ojePFjPxZg2cIV0zpdtNOYhAmvsnlh7rfRsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qD+BkvNlSK4CAqOskBn1eQLfQCnPp/c9dVkZYuSQ2o=;
 b=LKuhkfOV6aYT3dglsfxQhBoRskHlQ1fOnFy2kcOEUwSvNhwu2wEqoNFBqchXeijXPBwMYdS0oYBjJP6eKHxGeUTT+jMOgoj16kzPpC8BOkJkpGOSn2P+vYwfu69lMtCbmr1IJkoIEVRoVLTZZi6x5/9m5qd1aDg1QWv5cFPp+WgE7mrlA2ywsj8arYXh7wSK3yYRGHPj269MFmp8KwIzEtpfkrK8nweOxbNibX45D19giYOaq6xvvzqzSG/oDIWw7EhC4Ozxh4E//Ic/3B/F9g6m4tvpHzEySmcbPY6K/zk0G/e+t4j11lZacAXrsdyrJIr59MOCyjrVZBsBaLzlsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qD+BkvNlSK4CAqOskBn1eQLfQCnPp/c9dVkZYuSQ2o=;
 b=KBORVXWsDD3NZWFhetB8WwWRglBSO1oKJWcYRwRTDKFAHM1PQZnISCYnwZBAERIFkk+7HP7H/lLfyKPccl6st1d60078vA9Z3c8Yw0aK2WX5H0aWRA2a6vQ5MOp3NQcY7tZBhb8ee+AErlRJPqriVSmUh11lDkcmPujZttYlzIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB5100.eurprd02.prod.outlook.com (2603:10a6:10:75::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 20:48:10 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 20:48:10 +0000
Message-ID: <6e1474bc-038c-43ec-4814-63ad3eca888c@axentia.se>
Date:   Tue, 30 Nov 2021 21:48:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/2] dt-bindings: mux: Document mux-states property
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20211130121847.11112-1-a-govindraju@ti.com>
 <20211130121847.11112-2-a-govindraju@ti.com>
 <YaaGMtE6n0yZNpAI@robh.at.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <YaaGMtE6n0yZNpAI@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OL1P279CA0061.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:15::12) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by OL1P279CA0061.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 20:48:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07d350f2-6b7d-4961-07ca-08d9b442b82b
X-MS-TrafficTypeDiagnostic: DB7PR02MB5100:
X-Microsoft-Antispam-PRVS: <DB7PR02MB5100669FE2D4494862E2122FBC679@DB7PR02MB5100.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TV7Bt9gv4UvMeD51RAloN4q2h1N+I1bVAiXrk0RUNjeYoA4UyOoQkze0F62db9cCoSOVnQzSv5p60FF+Y5l74m+fZbVK9Geetl9CNPOBAy91p0WQ811RXtijindSOK6MVJtWsYoSl1Z+w6D2ZEIg/68yEgbxcn8PLx9Ryg3txwSUuUqx7q+LtLsCqIDdBq2ZJUzin8SxpMF6GZ9ZCKGTt0D60JPTfZkaO2uYlEImeOtCqsouqiI2S6yTYX5XQZJtStcTTNK5j3+xkZsRpa8p/3F6pBua4y7cHEnpFSMKwTpcUKmFU+A3eirU238+D2O7sICsNPo/ZrXZ7/zyR0AIWJ2Do+ujQS+vbNJxGvtCjxU4SBgvPZZEWm0v8lLmF7cnu3+m5x5qhMTiYMlLzw+/8Z89k8zWf5taLf+YBGnscV9SU1qhubAWBngGSSnPNVjloxFg6e9jvW36nirmqweBvNXYYSjtcVZpcEmHXeLylMX9n70zEPlyGzrLCKoQAfFWckPM+jtmVuzjRwjQ8zqEpfMqlOuCCDj1ol6eIazyKBvJKsI5cqP16FVT+l6EfBtqkuctWE3/6pOVu57bRQTeVlThFElu1B65WrzeB0PIm2NX2yMvKtnpuSLmSwzsZIT5bbP10HELihX1Y/488xJYyYxfWyiOCyHrymZSoaUOzpRfbjYLosIT7u2uYny75XZt99ID3kGYHQEb2vl0Dsom/zPqfO2jDDsts291zkjTw5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39830400003)(366004)(346002)(376002)(8936002)(66476007)(86362001)(66946007)(26005)(53546011)(8676002)(54906003)(316002)(4326008)(38100700002)(31696002)(36916002)(83380400001)(6666004)(66556008)(5660300002)(31686004)(36756003)(508600001)(2616005)(4001150100001)(6486002)(2906002)(956004)(110136005)(16576012)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlBJOUY1TU91RjhRcnllbGhWbldNRzZkQUszZURKYlFsVHU1TGhkVHhvVTFI?=
 =?utf-8?B?N3RxcGVIZHRRRWVub25RNjN0RVQxMWkzcEtkZnQ4YWh0dUt4TDFTdnpxQWZZ?=
 =?utf-8?B?MWNhYlo1Nm42WHZCS0xacHdHS3p1Zkx0amlDRUlDQ1hwOHk5dTcxSFdqV2Rm?=
 =?utf-8?B?cHhRT0l3TVJrek1FVEJ5bmtjNldQU3EyTzM1YjdVbDFaZVRMVHc1NGovRkxI?=
 =?utf-8?B?ZzJSU2xyaFE2cERWWGdtRmJ1NUJTZHVNUGlZbGlJMTVTMmNVUGJpY1lySVVi?=
 =?utf-8?B?V0pxYmhXeVJEV0xpNnovcW54N3NLUjBxTjBDTHF4UXZTdUk1ZXJYZHRuNkNn?=
 =?utf-8?B?KzJTWkVHQVBESis0YnpoZFFSUzVaTndDTXZ2QWcwQ1k0YzJ2Q0ZyclhyeUY2?=
 =?utf-8?B?VTl1c3VuVFFlRGJCNkdCc2w4aHNELzNrZjNTMS9yK255b1lUVWJLUlRsYjNr?=
 =?utf-8?B?VWJYR24ydkc0TGN3RUlmQTZqNWNnYXBhVks4QzhmOTdyVGRrSUs4bzQ1MXEv?=
 =?utf-8?B?bmZ6RXhyTGtqUVlwMUNPK1dNS3FHaG9reXZBdWxnUTVnU2ZEOFF0YmVZUWFS?=
 =?utf-8?B?U29EeEJyTUpBN2Q4YXJXWnNYZFl1eDE1Ylo1VTJYN3hmZlN4NlJjWkIxbHZi?=
 =?utf-8?B?aXk0MU12OTJGajIzbk5uUGl0Z3BTem91eEV2dGdla3lBQlIvTHJmRHR3UXRU?=
 =?utf-8?B?UVlKaEx2OXJvcUwveXZ6NUk1RVkzeFdiSVNLbEl4Q1ZXcjdCR0RneFlhNXJs?=
 =?utf-8?B?L3p2SHpNeE5tYzZaeWdVMitoR29SNHhyWGhmRWRiaWRySFJmSFNiL2J2T0M1?=
 =?utf-8?B?SVBxOTV2QjRDR01PRzNZSmxtR1psck1OVndYaXVNbmE4SGl1V0hGZ2Q1a0NO?=
 =?utf-8?B?NjE0eUJtRUk4T3Z0ZDZqR1RuQzVnMkFPS2FPTVQ5RGs0NStRanpKOFhMeXp4?=
 =?utf-8?B?dDlrTjRQdUgwWkdwTk1pL2NaOFB4bVFoSHg5YlJuWG5BSDRSOEFOa1hWL2xr?=
 =?utf-8?B?OXhtQ2ZIYmF6YWI5NU41eVRmNzJIQU9iZndWSkFZYWFIQnlDbWM3LzNDZWdy?=
 =?utf-8?B?dWZZb0xYTEZ1V2NseDdaR014UXpkRUpjT1NucCs0clBFRXZnTCt1dzk2bTBX?=
 =?utf-8?B?OVo4ZFF1ZWphbFJOMXNaWjZPOThxWlBla1BvT09iem0ra3o1bFJoWFpwdzY0?=
 =?utf-8?B?MkhxNFA3ZThqUW9RdmZOV2ZvTTZXcCtCaWtXL2xTVFlTWTU5SW40bnBEU0x3?=
 =?utf-8?B?RUNLMzg0TDJoNEc0N0tFZ1ZMc1BRcE53K0NKSDR4aTI1VDV4VFcyQ0sxR1NX?=
 =?utf-8?B?UDNsMnovNFIvMWxUbjJ0YUR6YXVUbkNCT3RjbEp0aHVnRTJvRjlMQ1B4aWFl?=
 =?utf-8?B?Mjc2b0t4bnlUTDBmcitpNXZIWXNXY1JkYW4vekFsNHBRVGRyTWR2cExLZkUv?=
 =?utf-8?B?d2YyaElHbU4vS3Vobkw1UE9CRWJxWEhiWlFkaWJwdTBPVE5XZWNwMW45cVgx?=
 =?utf-8?B?dXNIaW1iR3p0Mlg4ZVd6Tlc3alUvT1RvWUtpU3Yvb0tQcS95dGRNQjVKcnJm?=
 =?utf-8?B?aW8yVy82S0dIS1JKZVk4amNXM1RCd20vQ2hjbmpWNE5kTEozcmRGK093QklD?=
 =?utf-8?B?N1dpakQyM1kxbTBEdnBGSTRmNlF3ZmQ2alRIMG9RR01taGd4YWdZV04zQzRz?=
 =?utf-8?B?MlAzcGh2aldVVTV2MTQrM05wTXlIS0lnSFJ3SERTYWc0QU9lQW1UeVFxUlhV?=
 =?utf-8?B?WG5TS2l5T21iclg3aEhXdTZma2dKM0JEMy9XTXg0NGsxSlJYdytWQVExWk5P?=
 =?utf-8?B?S1IraGtkZGlXKytCaEkxR1F0NjBnWDhFcXR6aUtieUpISEUzMDhFQjRYaUdQ?=
 =?utf-8?B?dVhTWTBzQUFzRlhXN1NORTF1M3JwZnhLdkd3OVdFa0QvSTRUWXlrbkhIdDlo?=
 =?utf-8?B?cldENUpKamV1TTFXWDEvR1RSSW1lc0xlUmxDWXpSQjBjSGE1bm9FN0t4YXNu?=
 =?utf-8?B?Ri9wdGR1K1ltOGsvOGRRN2w4TTJWR3FpRUU4eTllT0lraFdlbzVsVGhGbTBx?=
 =?utf-8?B?YURyYldHdVZicC92cVdHNnRCbWthamVsbkYvQVZFd28weFFRcExJV25JR2p3?=
 =?utf-8?Q?S15E=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d350f2-6b7d-4961-07ca-08d9b442b82b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 20:48:10.2133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ja00D2B8T73P0UctOKN70vIFG1glsa9+eObxf8JQKMxAZKotjRDWRGCupRj1xy+Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021-11-30 21:14, Rob Herring wrote:
> On Tue, Nov 30, 2021 at 05:48:46PM +0530, Aswath Govindraju wrote:
>> In some cases, it is required to provide the state to which the mux
>> controller has be set to, from the consumer device tree node. Document the
>> property mux-states that can be used for adding this support.
> 
> I having a hard time understanding why you need this. One consumer 
> configures a mux one way and another consumer another way? How do you 
> arbitrate that? Please elaborate on what 'some cases' are and why it's 
> required.
> 
> Can't you just add a cell for the 'state' allowing for 1-2 cells 
> instead of 0-1?

A mux controller can control several muxes. That happens e.g. when the
same gpio lines are connected to several mux chips in parallel. When
you operate one mux, the other parallel muxes just follow along. If
these muxes are then used orthogonally, coordination is needed. The real
world case I had was I2C and an analog signal connected to an ADC that
went through parallel/dependent muxes like this. It is simply not
possible to freely mux the I2C bus and the analog signal, they are tied
together and dependent and must coordinate their accesses.

The addition now is that Aswath wants a mux control client to "point
at" a single state instead of the whole mux control, and I see that as
a usable addition. It seems like a natural place to specify a single mux
state that some driver needs in some circumstance.

But, since a mux control is inherently a shared resource (see above),
one consumer might need a specific state and some other consumer might
need the whole mux control and manage the states as e.g. the existing
i2c-mux-gpmux binding is doing. So, you need to be able to specify both
ways to point at muxes; either to a single mux state, or to the whole mux
control.

While you could make the extra cell optional, that does not work for
the mux/adi,adg792a binding, since it is using the #mux-control-cells
property to determine which mode it should operate its three muxes in.
Either with one common/parallel mux control, or with three independent
mux controls.

So, that binding is already in the 0-1 territory, and adding an optional
extra cell makes it 0-1-2 with no way to determine what is intended when
the cell count is 1 (three independent mux controls OR one mux control
and a state). I see no way to add the extra state to that binding, short
of adding an extra property somewhere for that driver, but I simply did
not want to go that path because it would get inconsistent when trying
to add that in a backwards compatible way. Or rather, that was my
conclusion.

Suggestions welcome...

Cheers,
Peter
