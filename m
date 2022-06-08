Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB135430FC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbiFHNFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbiFHNFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:05:45 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70042.outbound.protection.outlook.com [40.107.7.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B7B91573;
        Wed,  8 Jun 2022 06:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1dNKbhTjw43Gv6rm0tMwGSQSETRxwIh6mq7kfwooEXzUJ4nFEy/hVzw2SzV19Fu2vMPjN4Qwlz8lMkDZ6nh0AnEa05tRldECk0I/YVKca7CTPR2dmO9qHQzGnGtjrzPsRIZZR3nZvxzl1yr82xga3lqXTWXED9fzt2DMl2ekzNLUi9eK0/H1nJbL1ktuYzIGqxhfT9AqQsRPcAXpJRkDzou64YnQcp1R1I8LRqmqP2HVl7ZeTyQmL60fWF/fRmh6Rh8maeqXbhLGDOSWctbtYAGKs0BnbcUHYNSr4l+TCl0h4YoT5dI7Ji65jLUF6CxfVUqGuVhLpz41WxeO4OAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjGA93lymzpgHYAL9uJXcqmqPNsL3V0fyUYYmgfY07M=;
 b=ZiVzcOk3b7cWBS1G2+J4nhk5j15sFH0tOIlY14k+BzfEtF+zHB8JxnQ4qVO982OI1UU7/m4a7MCD/dHFUjSQTEv99Rqts463nVE+81pp3IFH/h95iAwb6EJOtov6j4krARx0PiUQGKuqgultqiaSjnd2FWvgJpzk+qN+8BPxAqCUrRDXd8ScGsIfvludVmhP44K/VA+hMjaRLhHVVXDoZ0/d7AcRMwgH5KghCuIJmXhAWw8Lhd8PcuAJXy8MUjfcIChYxHdVyZGrbTfc9Eo+Ojz0Z3Ne67fvyWknNLbCKuId/VeAPHtVKKbljUG7CyTAVvhY1tGyBkjLWXu8Gl6NQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjGA93lymzpgHYAL9uJXcqmqPNsL3V0fyUYYmgfY07M=;
 b=kpux2ujM7vTsR2zPhVteMF5xK4MnWnkgBbTBDMzYdN19l1S1zI/i2TI9q7SYPoLaggN4Fi6tdOJQK9bKkBbRSfZE0aI+YydmCNmhwR63eAgLm7uHNXRgTKqs4mAkGyXaw9d3jzpBBovGfOosb1zFrm1iDJSlVvBDKDQUV96NPVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Wed, 8 Jun
 2022 13:05:37 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::880a:6606:6f57:dd0a]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::880a:6606:6f57:dd0a%6]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 13:05:37 +0000
Message-ID: <941c3300-05e9-18b3-999a-1885585cf972@theobroma-systems.com>
Date:   Wed, 8 Jun 2022 15:05:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 4/4] media: i2c: ov5675: add .get_selection support
Content-Language: en-US
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, shawnx.tu@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220607153335.875956-1-foss+kernel@0leil.net>
 <20220607153335.875956-4-foss+kernel@0leil.net>
 <20220607165136.bmriu2n7yorc7fx6@uno.localdomain>
 <20220607220405.GB821506@tom-ThinkPad-T14s-Gen-2i>
 <20220608064209.roub7uk7kx4k4muf@uno.localdomain>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220608064209.roub7uk7kx4k4muf@uno.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0002.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::7) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14157ff0-d3e7-496a-bb21-08da494f946b
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB9510524B06D3AFCCC7D6FA1EC2A49@AS8PR04MB9510.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5iMwOhqZH65jck17Pjw61ym7rPnb4jJptjNdFjdHjni3gdzxDeNhjNgrQ2fEJm2wjqWe8PdWcnfRZl5LdYUKBHwyvMUS3ZaSBoEkxMkgCQF1tWqqzlQwi6OrxfqRsG13WG6UXixOsUDIxRk6nrb69bBvLRHqro+nBiVllydV7l0I03B1VeTs5h1APMJU5xqknwqYZoowW6I8sVdXQ77Qg5bv7AOCjQf29IMkIC491vDqp/deMYz/Ey5qjEIZ1IWvaV9ifYZ7Ozz27FAR0wgxABmOm9HJ4PD9v3ovZySlQaKNEtnGA2oXSNyisspE2ybp6vfFb5qtcPOV2QPCQiKdHkr8Q+40hDEZalpp4qZdn0O/fZVPFMBQiFSWxq6yns02N9x8YiJpH9Z+WxM5tX+t3Fp9ubblYV7ii9cQlLNb84HX5u97jrQPlTyWyqbJcUKbLXmDElWJ++PLFtau2oBREWmRNU5nlg09uFlfmAC+cn+vxdqo4PhAE51fzmd++iE9xEEPXEJTe5waN3R1oCiUFStFsFhUoefQfB3d9NgJ1sptrMzkJAFo829FwYXDoGomIewBnIjMgGaTJss2mPCx4p5aMriPL0EkomgxR4Zu3KgmftjaCwZPoX9v/Jn3KMDoZuX3z98GaEwBchsy+Fvf031Rr36AXCAwtl+ghfZJPKtK8iBd9nhiDq/gytY4d4JhhAta6NL+WNeWQai2KvNx4i4SLNE0zpLrKex9gr8tKP0qVxizCFyAHjvHrL5Tyyi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(53546011)(8676002)(66476007)(86362001)(31696002)(66556008)(4326008)(316002)(6486002)(186003)(2616005)(6512007)(110136005)(44832011)(66946007)(8936002)(6506007)(31686004)(38100700002)(5660300002)(6666004)(36756003)(2906002)(7416002)(26005)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzMzVHlNcjAyRUtPeEtDMm8rYnJ6ZnczdDRrZW9sTGI5eis5ZzZXeGFzdStx?=
 =?utf-8?B?a1llTXI5NVB3WlpJeDhtWndQODZPNFdpeGFGZko0Rk90MVJIc0xnZWI2SHU2?=
 =?utf-8?B?OUwwUW1RME9rcnVsZmxCNmJ5czFaaUxESHRBeGRaK0tSc2s1TGMrZkZvbDJB?=
 =?utf-8?B?bDMrM1V1RzlqZnp5eW1CYzliNmltR0RHZ1dFR3NXK3NHREIwTVhWcWU3bnpJ?=
 =?utf-8?B?d2pwNitLY3FBSmRQT3NhOEo1NFRENUUzSUxUOHlueDF6MW1Tb05Ob0lzOGx4?=
 =?utf-8?B?OStVUVk3QXlGTHZuMDEwUHQyM3A4Wmd6L05ReDRSMUpSZ3l0WDhuR204eURa?=
 =?utf-8?B?aVZuYVpLa3lTVjIzdnlKYXBqMGdST042ZG1WalMwczkvUFM1MHBITG9XQ3hW?=
 =?utf-8?B?WktLN2l2VmRGZDJETlArVWJwS3lZZDZvK2hyVTl4bE1oUEtFYnFMUGtMcVlQ?=
 =?utf-8?B?WXdLNUYwS2xaamdVbGg2OHJaWTRJb1NNNUFUb1Zlb25SZnp5dnJqRVlycDZI?=
 =?utf-8?B?MC95TkZSbWNKdFNpcXR3T21XRURQcENPUHRmMFZOYnJoL2JOWmNnRGZHdnpo?=
 =?utf-8?B?VmlCZFh1OXRyMCswVUtISWRETE5VbHR5aVVad1VRcjZFYUZRQ240SDBZUVY5?=
 =?utf-8?B?ckJPc05KSEp5MGdQWW16Zm5WYk9Lc3dDRkdXTndOSEhwaHVybzMxdGJ0OXZk?=
 =?utf-8?B?TnExWDdwZFA3VzN1cHIybHFzUDN2dFdaZGNJQm9QU25DVUFxZm1GU01jMmVD?=
 =?utf-8?B?WXpNTFlwei9GQVB2bnRkTi9teG1EUEFPTmlFVHkvSzg3WDVsZHdXbkl1RTNT?=
 =?utf-8?B?dTJ3NjdzMlpUdzBreGVQb29xR2xTKzgzOEFHaGYrSEwzTzZOa0ZDU2oydE1V?=
 =?utf-8?B?RUhIYUU4UTR1VGNDYXVuSlY2dDJWK3ZTaUJYVEJBcTIrWTJUQmV2MGk4Wk9X?=
 =?utf-8?B?Vkk0M3RMa3l1MmlLQ3MzaHZMOXNOSlNtUEZldERROUo1S3BCaUM4akFmclJk?=
 =?utf-8?B?TGNPSFk3RlZQOFlOK1pnNzM2L3g4bklWbzhQaUE3eHRDT0NDcW93UmI1Z1cv?=
 =?utf-8?B?amNHNStVY3NETWRDT0FBWFBnTWh6UlE0ZjQ1RGw5T1BETG1tNTFFOXRVQU5W?=
 =?utf-8?B?czVCdEtSM0FYWWdnTllBR2JjYmNYZ3M2eko0UXBjTUFCUUN6OWJIcEpoOGVa?=
 =?utf-8?B?NU85WjgyUk5qRjUrY1VaMzk0dUdqV1Vac2VIYzVqOGxVRUJHcEdpa1gzQjFP?=
 =?utf-8?B?eHhRWHRxYWNLQ040UWRacDdSUzFSWXBDdU10TlhoUnNhSllJOHhjMFRweDMr?=
 =?utf-8?B?L1lmZVVnaWVPVWtDelpiZWliOTF3TmFSa2Y2LzkvZjYzd09BQlMyTWZGcmVE?=
 =?utf-8?B?Tm1zRXlJYWJvbDBkK2FNSlB4YWFNVitaYzZzb2xzWWQ3MHcwQUgwWlhJQlRq?=
 =?utf-8?B?cW1OY01Fb3oyNEpaSGp3WHBKeWxnNmNzZ1VIY25kWTRzcTBFUUJHRlNBNjBR?=
 =?utf-8?B?aE5BVHBjOElZU1h2WnYyTWRJT1l1QXRLREVDUU0yeFhyQ0RQSGcwZjhpdkN0?=
 =?utf-8?B?RklTalc3OWlWSlVBZHM1YURPMmRvQXlZajR5MHhPdkVaVFQ4V0owR0hYRU5Q?=
 =?utf-8?B?MXpDcHI2dlprdzgvd3hiNlpvQzgwdCt1UWtrcXdrdHhBVWFGRXRlSUI4aGlB?=
 =?utf-8?B?UGRNYkpxaUhIQVJ6THpZUVJQWVlNOXNNNUhkSkxvZXlVem4rOTJYRnhNSnoz?=
 =?utf-8?B?RUVVQlVGYkxybnJOUm5VZU5FS3RLeHVKc1pCNjhQRjNxL28xdDFzMlBZWDJ6?=
 =?utf-8?B?MVhHUFJaRk41dEdya1BMTUVjYlRHRng1ZzlrT1pzdFh0WitUWWpwN2tIMm0r?=
 =?utf-8?B?N2dDWHlPZ1l6Lzc3c2xhc1hVM2xwNEMvSW9oTzd4N0lycHFqdGNmdUU3SHU3?=
 =?utf-8?B?NUtzSmU1VlNvYmVYaXhMYk5JVGp2OFRodjEyNkNhU1JVQ25JZmJUU2N5Ukth?=
 =?utf-8?B?czQzZ0lvbDVVeExvZi9kdy9VOG5FTm1LSUhVYlZqcUkwdzRYWnhnMkdyUUdi?=
 =?utf-8?B?NG1yNGg5K1FyV1pEZ1hocWFZQmRKWFZQb0NVZkxvV2ErOXVUMVdsbEZBMlZD?=
 =?utf-8?B?K2F2Q1Y5TnhTN2F1aUxpOXZ3TkZmaGErRzcrQzBTbmxHM01mVTVwN0E1bTBt?=
 =?utf-8?B?WTIyVnMzZE43RVhzeFQ4WXVRd3BHMmcxMnVFMDNwZStTVEExaGRrN0N2UHpy?=
 =?utf-8?B?UlJrR1AwQUZKajZ2SkdEWG9HaWpUQXNVTWdPLzdZbU1JbVljbG95RXNKTUZF?=
 =?utf-8?B?ZmpTZ2RSUnkrSlNqUUI3a0ZzVlZzU3p0a25mOTNqR1BEanNqU0RCNDYySEx3?=
 =?utf-8?Q?CIUMZadI8upCXiGffQAayjx3ABTsSY2VrnRPo?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14157ff0-d3e7-496a-bb21-08da494f946b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 13:05:36.9553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URu57IXnZ23EqdHj6de5upU12GDokJYBa8O5HHwFIvsnSPrYS80TUaxbl/XEu9XDe/9jMfDDdVgq9RTDa8mcqOCeI0v0v10MQF/xTsDiXrmujIZVFe2ivmlh30svq/Vy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacopo, Tommaso,

On 6/8/22 08:42, Jacopo Mondi wrote:
> Hi
> 
> On Wed, Jun 08, 2022 at 12:04:05AM +0200, Tommaso Merciai wrote:
>> Hi Quentin/Jacopo,
>>
>> On Tue, Jun 07, 2022 at 06:51:36PM +0200, Jacopo Mondi wrote:
>>> Hi Quentin,
>>>
>>> On Tue, Jun 07, 2022 at 05:33:35PM +0200, Quentin Schulz wrote:
>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>
>>>> The sensor has 2592*1944 active pixels, surrounded by 16 active dummy
>>>> pixels and there are an additional 24 black rows "at the bottom".
>>>>
>>>>                       [2624]
>>>>          +-----+------------------+-----+
>>>>          |     |     16 dummy     |     |
>>>>          +-----+------------------+-----+
>>>>          |     |                  |     |
>>>>          |     |     [2592]       |     |
>>>>          |     |                  |     |
>>>>          |16   |      valid       | 16  |[2000]
>>>>          |dummy|                  |dummy|
>>>>          |     |            [1944]|     |
>>>>          |     |                  |     |
>>>>          +-----+------------------+-----+
>>>>          |     |     16 dummy     |     |
>>>>          +-----+------------------+-----+
>>>>          |     |  24 black lines  |     |
>>>>          +-----+------------------+-----+
>>>>
>>>> The top-left coordinate is gotten from the registers specified in the
>>>> modes which are identical for both currently supported modes.
>>>>
>>>> There are currently two modes supported by this driver: 2592*1944 and
>>>> 1296*972. The second mode is obtained thanks to subsampling while
>>>> keeping the same field of view (FoV). No cropping involved, hence the
>>>> harcoded values.
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>> ---
>>>>
>>>> v6:
>>>>   - explicit a bit more the commit log around subsampling for lower
>>>>   resolution modes,
>>>>   - (again) fixed reporting for V4L2_SEL_TGT_CROP_* thanks to Jacopo's help,
>>>>
>>>> v4:
>>>>   - explicit a bit more the commit log,
>>>>   - added drawing in the commit log,
>>>>   - fixed reporting for V4L2_SEL_TGT_CROP_* thanks to Jacopo's help,
>>>>
>>>> added in v3
>>>>
>>>>   drivers/media/i2c/ov5675.c | 21 +++++++++++++++++++++
>>>>   1 file changed, 21 insertions(+)
>>>>
>>>> diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
>>>> index 80840ad7bbb0..2230ff47ef49 100644
>>>> --- a/drivers/media/i2c/ov5675.c
>>>> +++ b/drivers/media/i2c/ov5675.c
>>>> @@ -1121,6 +1121,26 @@ static int ov5675_get_format(struct v4l2_subdev *sd,
>>>>   	return 0;
>>>>   }
>>>>
>>>> +static int ov5675_get_selection(struct v4l2_subdev *sd,
>>>> +				struct v4l2_subdev_state *state,
>>>> +				struct v4l2_subdev_selection *sel)
>>>> +{
>>>> +	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
>>>> +		return -EINVAL;
>>>> +
>>>> +	switch (sel->target) {
>>>> +	case V4L2_SEL_TGT_CROP:
>>>> +	case V4L2_SEL_TGT_CROP_BOUNDS:
>>>
>>> Seem like we have trouble understanding each other, or better, I have
>>> troubles explaining myself most probably :)
>>>
>>> If the dummy/black area is readable, this should just be (0, 0, 2624,
>>> 2000) like it was in your previous version. What has changed that I
>>> have missed ?
>>

I wouldn't say there's some misunderstanding, it's just super hard to 
figure out how to match what the datasheet says to what the kernel 
wants. Yay to obscure/confusing datasheets \o/

I just did things too quickly, nothing changed. Sorry, will send a v7.

>> Taking as reference drivers/media/i2c/ov5693.c and others,
>> seems ok what Quentin have done from my side.
>>
>> Just one thing: maybe is better to avoid magic numbers with more
>> explicit defines like:
>>
>>   + case V4L2_SEL_TGT_CROP_DEFAULT:
>>   +           sel->r.top = OV5675_ACTIVE_START_TOP;
>>   +           sel->r.left = OV5693_ACTIVE_START_LEFT;
>>   +           sel->r.width = OV5693_ACTIVE_WIDTH;
>>   +           sel->r.height = OV5693_ACTIVE_HEIGHT;
>>

They are hardcoded today but actually depend on what;s set in the 
registers too, which might differ if we add more modes in the future? 
It's anyway auto-magic and it's the only place it's used, so not sure it 
brings much especially since the variable names on the left hand side of 
the operator are pretty self-explanatory (not talking about 
V4L2_SEL_TGT_CROP_* :p)? Not that I'm against it.

Cheers,
Quentin
