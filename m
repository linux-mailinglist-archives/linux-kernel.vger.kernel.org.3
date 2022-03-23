Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C6D4E5769
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343544AbiCWR0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiCWR0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:26:33 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2053.outbound.protection.outlook.com [40.92.19.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0389B5D5D2;
        Wed, 23 Mar 2022 10:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6wW/QGirLUEvYh7I7g8xru7GD5LE39k/Ema0GvQOyHloSNoJ3SiLRK592gu5jv+yXjDRzd3vTw0cGaj/yhEVMpOPB3MNOi45SCa2kO8VldZ2I/1q3vAj9smfDI/0CmzVe0Swj9fjTZVrHPpUwcOp0hnNtZHTyOWNWeE6Wv4zfcWAVuTVrb8Fve0Sc3JyYVAS/SwStnbm4ZjfFLM/NkjIS/Fg1P3pLjz0taLkgToCfhfVbhYdsridmdwCTsfGPaslV25+X9sIFa8hLzMfS6IlKXEZAaBovbXJrs5l4N8UDmXg3GrxCajJ69B1eFGTZMF+WTrP4L/xLBf020AA0Jdeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQL7/ftiN9Srr5LmOMicy6R5B4D6wQZQrVNtESdjOpM=;
 b=OG5u/K/Yv0SSdTrYcW+0eJ54pSJj3txmcJAjnLSXluNYOlm2IjuCkQqOdf0VSrmnMFpCYVeX7erPBxCJlwb6YFvCVVdW3KVGhu3Wm5CmU4c619TEX5n9oJzsZwzljD4NngZsu2ZK5+MrS0mUg2wbVqPTgsBuH27ZYn4xOEfDI4m65VNWNKkNkMMHaPTI/aEGxqpqnZrlbPmQ5BOvzBIjQXvqLagiyCIu+oIY/4T5ETTrZTeo3mEKXTqpgyWsf5DrvcHG6aYrlF84yPqifQu61MKxE3UwbWEHEwZHFFc2LAdCcF8T3DMemBnmTJbQd9Gt27mbX7IKgwahDKFQ+ffygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by SA0PR04MB7434.namprd04.prod.outlook.com (2603:10b6:806:ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 23 Mar
 2022 17:25:00 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 17:25:00 +0000
Subject: Re: [PATCH 2/7] ARM: dts: s5pv210: Adjust I2S entries to match spec
To:     Krzysztof Kozlowski <krzk@kernel.org>, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <CY4PR04MB056784D54ADDBB4F57F82D4ACB189@CY4PR04MB0567.namprd04.prod.outlook.com>
 <4ebe2bb9-4f92-2dff-6737-d057e5950b24@kernel.org>
 <f44c9881-6f7b-f4f5-8225-e0c74c83fab1@kernel.org>
From:   Jonathan Bakker <xc-racer2@live.ca>
Message-ID: <CY4PR04MB05677B21384FCE2013EB1B94CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
Date:   Wed, 23 Mar 2022 10:24:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <f44c9881-6f7b-f4f5-8225-e0c74c83fab1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN:  [Ax7r4MYUrHaU9Zn0M6Cog0kc+Nyrj1pQnTXx2zhzepF0HxlMzsb3QqNxuiwtTL32]
X-ClientProxiedBy: CO1PR15CA0052.namprd15.prod.outlook.com
 (2603:10b6:101:1f::20) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <14e8af56-60a9-73c9-4536-0a4fc4c64733@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f3a7e9f-5dc8-4cf2-a443-08da0cf20f3e
X-MS-TrafficTypeDiagnostic: SA0PR04MB7434:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3b75kkb85DEt75md4o/mL6daC8JlExsLzMJtfigROOr5ixcwTx4xsnQCluF389IrUUmq5EO7fgWP9X4HTECiAKPYRhbaqPt6cDS5mZwheOtCJMPYAgVVsVpDAfpSbucDWckAZfRk3NxDkMHwdU4V7tPqGJ+RujXRs/AMPF2k+5P/rTAxnstyYQevO7Bl4dWsWR7wUAOrIgo4gsJqWDIw9BH0lJFVCUdBsIFYMsF/ae8RncaBwhU9916tNImYACI8TjdFOxICHjWYN366yjgLaoO1XpntR0ISM8RvC3uALZ4cVy2WqZPoaDqnKv22L5wC6gwQAOpe0HwlcsLBTQUi1iZ7APRHIL0I9rrwfu9NEhYlcwWmRoyu4jN2Ma2Z3Jdx9AaXdYQBCo+B+Eo1f00jtsFTVsxrsvGhlzPNhjoPhjCSt1ah0sohujHH7t7oRNpSwJuFKMfdZQoxu8xmQh161CYDhxQLmwZPyOppdupJhAr4ZCwGN6BTVJKFe4yZHoQw4AgKwFvTZcY/i3Gv5vlkZSetRAVGpl/q3oBTKJGhA+ghcSApNXdC/PxXdRqnHKe97qGW8RV6mwZNJTuwUb4Nb5II3tFIRDIBu/RwwF80Bzb+c1mBym6LtJgvPY3H3CrK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3diWklkbitCUzlOcDY1SDIyY0xZM3RTSTAyalhiVGpLeXlKRVg0QWNEZXdq?=
 =?utf-8?B?c1VZRnFnWWtIRW5ZQWFsOTdFVlVZbllPdkNSbDhyK0w2czVoZjRUYloxN0Fh?=
 =?utf-8?B?M1p2bm5nbmZTenlyUUVCaTVIOFJhekN0L2gyZjBpSHlkVnFDVFZieldMVnhK?=
 =?utf-8?B?ZlFuTmpNb2xhOTFpYTl3b3hBWFZXWjRyN0d0aTgxQ1pmWms2S1VTODR1RXJJ?=
 =?utf-8?B?VFQ4WC85MFRpYkVCN1N4a0hveXBGMnVhUWFyMDZiaW5VdVZ6R0tVRVpnbDNw?=
 =?utf-8?B?RmhOa3pxd1NzV2xQT3RXWmR0c0tpNzFUVloxTDRDUHNhZjN3dzFXUlFLN2RN?=
 =?utf-8?B?TEE1VmhTcjBsOThsUm1CalM4ZkptZjNFMzQrMVNIbjB6VnVYWWlFMWc0cEZT?=
 =?utf-8?B?YThySVhrejFNNjFGVXJiKzFqKzA1T2tLZ3dkS3hFNEpzalhSSVRwSWRzNDha?=
 =?utf-8?B?SHc4NXhPSlhBM0d2M3JwUjJVK1pWZGxhaGlkM0dTTU5hYlhKa3N0dkhuUXJh?=
 =?utf-8?B?bEVsME5vZjZaUlpGTWF6SUVMV04zWjJEWjJIcnBtaHpQaW1Ic2R4RnJBV0hL?=
 =?utf-8?B?SExxQkhhc3NnUHNiemhBcGNrK1grMllWZTAxY3Faa0psNUtGbUJ4dnF0dHZo?=
 =?utf-8?B?ekozWUJPQUMxKzZFRnk2Qm9mbzNhV0xYVmdYT1Zya1J3ajdXVFhMOEZvWFUx?=
 =?utf-8?B?WHlJaG9Rb1Fpc0dxdVlGWGVZUENVOHFhWW43NVR2VXRQbVpNYncrUGJra2Iw?=
 =?utf-8?B?TWxOREdaMnZlTjdkTExTZ091dmZhSUZESXZ4VjRTQ3FiWEVxdTVmMGMyaUY1?=
 =?utf-8?B?QVVKeXZmSzU4ejVnTFd5Rkhaa2RXSUE5UWhDeXdoakhrNk1KK3RQOEdIdWxw?=
 =?utf-8?B?d05TTzVEUHB0MUI2dnBzalJ2cHBCOHVJMUJlMkhaZXNIeUVnL1pIeFFOM2dN?=
 =?utf-8?B?TTliUVZmYmVXVGlrT2xqblpKMjhncUloa2JWWjVKbDM0NVZjOVc0OTQrNGJp?=
 =?utf-8?B?bFpXMzJpRXR5aXE0NXNveW80NWREaUJTVWtZb0VCWlY0MjdySllCTzcyUXFh?=
 =?utf-8?B?b1lQWUtVR2NZTUZCYWtTU1dWVzFFU25pUzY4NEVXUGNIamhubE5mRG50Mkp6?=
 =?utf-8?B?d3FlOUF6VXN3QUd5VEhwOGxzdEtYOWIvZjdaMG54VGNwbHpMZGlsWCtBaDJH?=
 =?utf-8?B?ZEQvRTh0VnhnOU5NVXVKM1JaK1F4TXd5VlYrVE1NU3p2YzM0ZjJlWWNVSi93?=
 =?utf-8?B?SUxWMFViYUN4dXJsclBjRkJuZE1DdnVoejNoakRKbC9kSHlMMkhDT3RSNzVU?=
 =?utf-8?B?K05xREI0aEZqZVBsNnVlcjA5ZWNJWUlrNXgyMVNsYVlGT0NhNkdSOHJVbmFW?=
 =?utf-8?B?OUlGbnJlQlU0S2FGOGZGR2ZxbGFUcHZ0Sk95OHVxSldjekxvSitVeHhiNUtr?=
 =?utf-8?B?V1liNldreDVud09GT3dtSnNoOXdZY2dselpqb0xpUEFQd21XL05tTnNET1RZ?=
 =?utf-8?B?RDBEQjBOcVdTYUJpVXZ5TlBJMEZkNjhocTlkb2RhZ1BzZTRPMVpscjJWdTVM?=
 =?utf-8?B?SnVRRFRxSHpCYWpVRGpKejU5NTZTTjEvVHFyRWgrYjB3K0ZYdC8rSEZzNEN3?=
 =?utf-8?B?VlNJNnk5NU41cHpzVFFKRzdCWUU5SWc9PQ==?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3a7e9f-5dc8-4cf2-a443-08da0cf20f3e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 17:25:00.6697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7434
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022-03-23 8:15 a.m., Krzysztof Kozlowski wrote:
> On 23/03/2022 16:14, Krzysztof Kozlowski wrote:
>> On 23/03/2022 16:03, Jonathan Bakker wrote:
>>> Based on the device tree spec, clocks should be ordered tx/rx.
>>> Re-order from rx/tx to avoid warnings when running make dtbs_check
>>>
>>> Additionally, the number of #sound-dai-cells should be 1, not 0
>>>
>>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>>> ---
>>>  arch/arm/boot/dts/s5pv210-aries.dtsi |  2 +-
>>>  arch/arm/boot/dts/s5pv210.dtsi       | 18 +++++++++---------
>>>  2 files changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
>>> index 70ff56daf4cb..503b5a50ef1a 100644
>>> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
>>> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
>>> @@ -644,7 +644,7 @@
>>>  };
>>>  
>>>  &i2s0 {
>>> -	dmas = <&pdma0 9>, <&pdma0 10>, <&pdma0 11>;
>>> +	dmas = <&pdma0 10>, <&pdma0 9>, <&pdma0 11>;
>>>  	status = "okay";
>>
>> Except that fix that's the same commit as here:
>> https://lore.kernel.org/all/20200907161141.31034-26-krzk@kernel.org/
>> so just extend it.
>>
>> sound-dai-cells should go to a separate commit. But are you sure they
>> are correct? The Fascinate 4G seems to be using them as cells=0.
> 
> See my previous patch and discussion:
> https://lore.kernel.org/all/20200907161141.31034-10-krzk@kernel.org/
> 

Thanks, I'd totally forgotten about this series from the past.  I'll re-test
those commits and submit your copies of them in v2 if that's OK with you and
that they're confirmed functional?

Jonathan

> 
> Best regards,
> Krzysztof
> 
