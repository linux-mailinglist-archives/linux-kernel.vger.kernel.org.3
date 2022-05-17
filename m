Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0992552A1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346354AbiEQMrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343954AbiEQMrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:47:14 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F7E3BFA5;
        Tue, 17 May 2022 05:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tdqj+Oqvm9qqGsIdzTNy/vaAWQyezAedidPOJwSif6hxK1mEODTBRIzqmXLsbWCOfOILheccUPXnALod4L+ALTKg0BHhCs5XMFZ0DBE7eil1dfI+7/T660l1VEc2u+5sbQpku9nGQpiKGjRRNkkwsgL+8VY8OqGihFYQKxFYtTbsix/Mha6ZqU+xt+FqfgbpFUi5St3k6hYfTbmdXFlG5OjIm63/NTkT3MS+mXrgnOZhLKY56GigwexT1YsKxIDyGHk5OC91K1L9kKXb5BM4WK/ovOJ5lUy7ckouzPkIYjO+h4nytdElDQQm9/VsEc9z515QGR5AjEr0vY03vDmOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q3GVmc0/W7Fw3s75Q7OGKL5vb5irbBn0GrGfA60BeI=;
 b=P/BIIs4KqxtjN/FofT8tPlpITeXx8Yyo70gH6AyVWqqvYMbMMeCU6l1G3LkNa8WiwhhGcttjtuo9rIcZcfFuJ5hx6zyXuoOE9benQfWOGKTYY4lMMtGtqCIex57IxCTNiW9/0dS/Q1QLjkBaMg3ibA+ADcuG1M5zG5fRYBzN6ETTbnxrXAUrCY5brD3f8VrC/Rd7qrio4NfFljeHongFE88jU5G5E0WhMDXo2oPHjpvEcVr/m5zMi/zBNu3xDuF/maaGegr+SuKF21KA+pR8tHjrAcAlemGrA+t5QnuCS1qkBhzWlhn0Ii988HLnr0++/XB0bcQB2pa4DLPI83J7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Q3GVmc0/W7Fw3s75Q7OGKL5vb5irbBn0GrGfA60BeI=;
 b=IyyY9V3gxwc6FyA+3f+HGKaBtqyS16X1dl3IKHLAxaPj0mHvUTXQs2nkeHELoDZegBGKcdAI7NRyWOMsV3mLX4R/aMt8U3XIqLteWyDkel2U2H20rkBZvpEye9qC18ItvgDu36KFkypSA04BqegAz4L84eoTOjKXv9/qJr3e+Lc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB9PR04MB9378.eurprd04.prod.outlook.com (2603:10a6:10:36a::6)
 by HE1PR0402MB2714.eurprd04.prod.outlook.com (2603:10a6:3:e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 12:47:08 +0000
Received: from DB9PR04MB9378.eurprd04.prod.outlook.com
 ([fe80::4c85:560b:2f85:7522]) by DB9PR04MB9378.eurprd04.prod.outlook.com
 ([fe80::4c85:560b:2f85:7522%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 12:47:08 +0000
Message-ID: <9e1fc111-0a64-5a01-8ec2-77a9b60d1535@theobroma-systems.com>
Date:   Tue, 17 May 2022 14:47:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 4/4] media: i2c: ov5675: add .get_selection support
Content-Language: en-US
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, shawnx.tu@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220509143226.531117-1-foss+kernel@0leil.net>
 <20220509143226.531117-4-foss+kernel@0leil.net>
 <20220512090553.x7mzsj3ff3u5gqxq@uno.localdomain>
 <b77d43d5-4a50-3da2-67b4-65224a82a202@theobroma-systems.com>
 <20220517111814.gcu7zcog4atqzwdc@uno.localdomain>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220517111814.gcu7zcog4atqzwdc@uno.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR05CA0014.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::19) To DB9PR04MB9378.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b19b87c-a46b-4c30-cdab-08da38035a94
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2714:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0402MB27149596C3A29E63E097CF46C2CE9@HE1PR0402MB2714.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TPeE/HoE5ccdwRBUsXuL19vwdm7RXZPktEjN35H0McF+cxXV/9tBaLdgBNNcX24poczUJt1Ptz+MYld1tqNy2jIGnjpu3k1lzT4MhsRs9Try6O1/pn/ncrxrTVwqvN0m21bT0TWyE1JYwEo8F5NKCpUtXhMSWE9Ug7rYw3lvbPMpGAT98zPm6bI5Z8/Jf6IrMmP8ikpLz6rqGP+DD7UhQnre0twFF8l9Ynm85nEWGcBBmwRiAMZ//QkG34kLa1UV3CSioVAmKBL30oE4U6K0bEgjkaZKYx3qQQpfoGQRG9tnh5W4C6KLET66ZjEQxmvCWSBgkeR/+UN9fO9Dgts2WpnDtpUVPxaJDpHulqgHWQ2mR+hKpxKMhYq2VqaMHv4zYl0dJmpi/h8RVijdQPdfEL/scNuS2OYDhm6SDhp6fSpc0OBHOkB4JSZot3ouEDLT3JEHAikvssRMioWYuN5Oqkq73gnstcoE1iKS81tyEBAcOVyzeSr7qDh1nM56X2RSy8ZgnV3wKjhyLBfL8930UrX1FEnj/0WJc7eqiZSLNEt1K/+y+aWLmcz9aEVPi/7Djz0fpWrPoCdiU9cMR+SN8F+MF2wgIbtj35e4O3MHDNem2v3PIgScch8WIiEf1p49Smy/j4mW2WH/av4tWoyExq8lP5sUlBqGxI855qNnJZQM5kPF4XsXGMo99sm6VgFcB6ck6Fqk/ivgc1LSBlBvckdRBYmLCYBGRBxSRPN8J7FDhZysWLGQPRFYe/Cbj0gS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9378.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(83380400001)(31696002)(66476007)(6506007)(53546011)(6916009)(66946007)(5660300002)(8676002)(6512007)(4326008)(38100700002)(2906002)(44832011)(8936002)(2616005)(186003)(36756003)(26005)(31686004)(316002)(86362001)(66556008)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3BHdXlKMDAwRmNPZzFOZmxkOWNaVmg3MlhNN0FwNTFrS0FCOVhKSFVRQWhY?=
 =?utf-8?B?UWJpUUtBcURvcG9FcjM5TDNUZnN3c2p1MG5SNWMwbnB5cjJLZUFYdXV4UTdo?=
 =?utf-8?B?OWs5NHVRbWZ1UENnZTF6dVRVY1Q4TUpJK2h4Vm10OEtLNVUzSTdLdWZLdjg1?=
 =?utf-8?B?MFZXbXF5S2UyOXdKUFNFUlB1YUVpa244UlZSYkU2ZHFDakF5Ry83U0R1YWNW?=
 =?utf-8?B?WHRtcnhWVTFwTklacjhMYnZZNHFieTZkNVlHcGRkOWc2QXcrRnIvK0ZNREc3?=
 =?utf-8?B?MC9ERUo3eEdtcGg4dXIydm5PcDdqSnlNRVNJMGU5ZmhDMEtHeExzN2ZXRXlG?=
 =?utf-8?B?cnhsd3NtUzVBcFBiMEx4b2lBQXNGRGgrMWhzK2txUHJzZHNHWmUyU3VtQUtT?=
 =?utf-8?B?TWkzWkRZd1Z6TDRpbi9EdU9IYXBOT0tXVHBLT0Q5cEw2U0I1Q3dyQWEzQUwx?=
 =?utf-8?B?OWJFYU1NM1BJTlJwT3RRQ0s3Z2pxcjR6TFg3R2dHbTNtUkV3YWUxeTRNK2Rl?=
 =?utf-8?B?NjVnMUtlMWExd09aNjZBRUdHbGpITllyeUhrTFZmNUdVK0ZvOHplVDM0aTkz?=
 =?utf-8?B?Nkt1clZqdnVDcUoyencyam82cWRJUVhwU1ExMmxVT3Z6VUdNYUwxZGF2YzNK?=
 =?utf-8?B?WVhoRjNGT1BCU3ZTa0poQ2xmNDVtS0tZek1BbWRjV2RwdGJreTVtcHlqT0d1?=
 =?utf-8?B?bU1NWmExWmRLaUwwU2JwUm9NWlFyVkQvRDAvSTJnUy9xRU03VmFVZzF2dkVi?=
 =?utf-8?B?RXFpZEh1bmpWcGRMSWxvdit2ZmJvM2ZzRC8rcnRtTDMvTzR5QU5FbnkzUjV6?=
 =?utf-8?B?V2xwSDdkSXdpNEltTlZwdW8raWF0VVdqYXhVMW9OZkQ2ZzI2R1UybExsNm9M?=
 =?utf-8?B?YlVBZ0ZFNWllSVYzZHYxem9yZjE3SW85WUhkbURnWS9rSWZPVWNnVTBaV1pj?=
 =?utf-8?B?OGxEbHJPWEdpTVV1QjNlSWpTa2RuamUyZURJY3RMT2hYNk9hcTdCUHE3NTVY?=
 =?utf-8?B?bE1DbTI3QXFTb0JyVjJWbEtTSVVrWGdHMEpqUFcrVkp5Z1lvamNTcURuSWNP?=
 =?utf-8?B?L21PR0FMMzFHTDNqVk9FNlE2ZzlGYmZFYncwaDR3NmNaWWZwYnJwNTY1R3ky?=
 =?utf-8?B?OS9NSE9TaFljQWZ6U2IwYWNqZFJKNDVFS2VVNGpyLzhLMzJnaUxFQmtiQzky?=
 =?utf-8?B?Y1lxbGRid2tiNHA3Nk1wUWhPNXpNU2xXVXZkSlozUDNrbGZHN2lJajJXY2dW?=
 =?utf-8?B?ZHBReHhTMlBGRU1mLzdWN01JMDBTb3BNeE1SWG9wVmNHS0dOZGpuQ0ExQmVN?=
 =?utf-8?B?SzMycXRrWUt0dmcxdFJCbTR5RWVveGFNM0Zhanp2WDdQTWRJV0RCdTZvc1ZI?=
 =?utf-8?B?NDN5RTIzT0s0TnQySlN4Szc5VGtHcHBhZ00wYzY0cG1FZlh4aUg0bm1HVlZm?=
 =?utf-8?B?RUllZ2R0QWVNNXBWMGthaGlWL1hqYW9sVUQ3aHYxb0JpZXZQVmJBSWh2OC9n?=
 =?utf-8?B?VHorSmROcUxETDJzWmMyRkNJcGR4RzRraGFJVmQyYjJySE1YQjAycTFETXVW?=
 =?utf-8?B?S3pra1RGc3dBWG1xbW54OFZQS1QrcWNZZnJsdnV0d0N1Y3RrZGw3eUVBa2JB?=
 =?utf-8?B?dUw1am1iT0Z1K0V1clR6VkJYY0FLQlNyM3JTc1RzWkFxcUlZM1dWMmtEeUxM?=
 =?utf-8?B?UGpFQUNMOTZOWXpLeFRSUUpOSTFPaTNXSEZLZTJXRnBPbDVsOXR5dXMwVEtM?=
 =?utf-8?B?UmRVRTNERjAzTFNlRXRVZDJsS1U4a2J6Rmpvd2FCeHlLRm8wdGdYais1dGYy?=
 =?utf-8?B?M2hyUy9WRGlZNExjZXJBZW0xZUlhcXhRcnZSRXFDWlNzSFFTdDhSWEF5SEl0?=
 =?utf-8?B?TVdXMnp1VEpCNVNlMFN6TzFRMHNIUmJqZFNXVDZ6M0VJVTZaRHdtMng3OXRZ?=
 =?utf-8?B?QldYdnZXMWZmbXM2M3ZHdlpUc1pkSnRmZWhnY1dNckxab01OS0pJNXFSc3Vq?=
 =?utf-8?B?cEFGbHlRRW9HbWJsUnY4dGZOdnFXQXBRTGFYYmNzZG1KcmJycURYRFpZdVVs?=
 =?utf-8?B?TGt3dkVFZFdSeUVGa3o3UC9QOWRLMzdKNlhTdkJXbGZWNWJXYmFXS3lQekds?=
 =?utf-8?B?cHpTUllNdDhIL2VtNytMb0xwNDBQR3p6dk1INFd3T1JaV2FQdTcyVDZjaWt6?=
 =?utf-8?B?czFiUkpwdmhhSG9sK1hlUXhyUTNYd3pBSWszajZyNmllU2t0ZzcrZlF1VDZy?=
 =?utf-8?B?Y3g1RzFtR3hiRnNkRnl6a3QrMkF3SlJVTFJxQk02K1B2cDQ2eDlFTHIxQS90?=
 =?utf-8?B?ZmVQUWcwU2tmSExyREZmSlh1ZCtxSDZuNGZHcUV6UFZUb05LLzNlQ0h2aGNU?=
 =?utf-8?Q?U3qWUCw0Zxndozg6s3MpDAuLapVmTJzEiyTCx?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b19b87c-a46b-4c30-cdab-08da38035a94
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9378.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 12:47:08.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYDX1u6MYynCmKhuKvF7fcimW90Fp5NnmvGpmzj2EYs+QPRP9N1cNMt1QIL0Ok8ZL3XwDuCEezHAJR5ppMIjIFwxsf1/Kr2qFXK7IL3Ikg2qfpHGBBAgVjIIrF84ey/F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2714
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On 5/17/22 13:18, Jacopo Mondi wrote:
> Hi Quentin
> 
> On Tue, May 17, 2022 at 11:25:17AM +0200, Quentin Schulz wrote:
>> Hi Jacopo,
>>
>> On 5/12/22 11:05, Jacopo Mondi wrote:
>>> Hi Quentin,
>>>
>>> On Mon, May 09, 2022 at 04:32:26PM +0200, Quentin Schulz wrote:
>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>
>>>> The sensor has 2592*1944 active pixels, surrounded by 16 active dummy
>>>> pixels and there are an additional 24 black rows "at the bottom".
>>>>
>>>> As recommended in the SELECTION API documentation, let's put the first
>>>> useful active pixel at the top/left corner (0,0).
>>>>
>>>> This window is the default and maximal crop allowed by the sensor.
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>> ---
>>>>
>>>> added in v3
>>>>
>>>>    drivers/media/i2c/ov5675.c | 25 +++++++++++++++++++++++++
>>>>    1 file changed, 25 insertions(+)
>>>>
>>>> diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
>>>> index 5544e1ae444e..8e3a5bc6c027 100644
>>>> --- a/drivers/media/i2c/ov5675.c
>>>> +++ b/drivers/media/i2c/ov5675.c
>>>> @@ -78,6 +78,9 @@
>>>>    #define OV5675_REG_FORMAT1		0x3820
>>>>    #define OV5675_REG_FORMAT2		0x373d
>>>>
>>>> +#define OV5675_PIXEL_ARRAY_WIDTH	2592U
>>>> +#define OV5675_PIXEL_ARRAY_HEIGHT	1944U
>>>> +
>>>>    #define to_ov5675(_sd)			container_of(_sd, struct ov5675, sd)
>>>>
>>>>    static const char * const ov5675_supply_names[] = {
>>>> @@ -1115,6 +1118,27 @@ static int ov5675_get_format(struct v4l2_subdev *sd,
>>>>    	return 0;
>>>>    }
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
>>>> +	case V4L2_SEL_TGT_CROP_DEFAULT:
>>>> +	case V4L2_SEL_TGT_CROP_BOUNDS:
>>>> +		/* In HW, top/left corner is actually at (16,16) */
>>>> +		sel->r.top = 0;
>>>> +		sel->r.left = 0;
>>>> +		sel->r.width = OV5675_PIXEL_ARRAY_WIDTH;
>>>> +		sel->r.height = OV5675_PIXEL_ARRAY_HEIGHT;
>>>> +		return 0;
>>>> +	}
>>>
>>> CROP_NATIVE = the full pixel array size = 2592x1944
>>>
>>> CROP_BOUNDS = the rectangle that contains all possible crop
>>>                 rectangles, aka the readable portion of your pixel array.
>>>                 If in your case the sensor can read out dummy and non
>>>                 active lines this is == NATIVE
>>>
>>> CROP_DEFAULT = the active/valid pixel area. If there are any
>>>                  dummy/invalid lines the DEFAULT rectangle should not
>>>                  include them
>>>
>>> CROP = the portion of the active pixel area cropped to produce the
>>>          final image. You should look into the modes definition and
>>>          inspect what values are programmed in register 0x380x (I don't
>>>          have a datasheet hence I don't know what corresponds to what)
>>>
>>> Does this make any sense to you ?
>>>
>>
>> It's difficult to make sense of the datasheet to be honest.
>>
> 
> Seems like it is made on purpose, isn't it :)
> 
> 
>> There's a 3296x2480px "full-size" rectangle, then the sensor array output
> 
> Are there that many blank/invalid lines/cols ?
> 

Seems very unlikely, but it's in the schema..

Can't rule out that they just reused the same schema they had for a 
bigger sensor and just didn't update the sizes for the full-size rectangle..

>> area called CROP and configurable through registers 0x380x, then another
>> output area called WIN (for window) also configurable through registers
>> 0x380x. The WIN area seems to be just a mask applied on top of CROP area
>> ("timing is not affected").
>>
>> On top of that, the schema shows 24 black lines - I assume - incorrectly,
>> one after the start of the full-size rectangle, one after the end of the
>> full-size rectangle.
>>
>> Then the sensor array area region in another section explicitly specifies
>> the sensor to be 2624x2000px, active dummy pixels (2 16-pixel rows and
>> columns) and black lines (1 24-pixel line) included. Which makes the actual
>> useful area 2592x1944px.
>>
>> In the datasheet, the default size for the CROP area is
>> 2624x1952px, offset (0,12) and for WIN it is 2592x1944px, offset (16,4)
>> (assumed relative to CROP given the second coordinate).
>>
>> In the kernel driver though, the 2592x1944px mode configures the CROP area
>> to be 2624x1968px offset (0,4) and the WIN area to be 2592x1944px, offset
>> (16,13).
>>
>> The datasheet only ever mentions 2592x1944px as being the max resolution of
>> the sensor though the sensor output area documentation and registers do not
>> mention such a limitation.
>>
>> Since we're not modifying the crop area at the moment, CROP_DEFAULT and CROP
>> would be the same, which would both be 2592x1944px.
>>
>> For the two others, I'm not sure. Any clue or hint with the info I just
>> gave?
> 
> Is my intrpretation of the above correct ?
> 
>                       [2624]
>          +------------------------------+
>          |     |     16 dummy     |     |
>          |------------------------------|
>          |     |                  |     |
>          |     |     [2592]       |     |
>          |     |                  |     |
>          |16   |      valid       | 16  |[2000]
>          |dummy|                  |dummy|
>          |     |            [1944]|     |
>          |     |                  |     |
>          |------------------------------|
>          |     |     24 blacks    |     |
>          |------------------------------|
>          |     |     16 dummy     |     |
>          -------------------------------|
> 

the 24 black lines and 16 dummy pixels rows at the bottom are swapped, 
but otherwise yes.

BTW, did you use a specific tool to make this schema?

> 
> Math looks right at least:
> 
>          2000 - 16 - 24 - 16 = 1944
>          2624 - 16 - 16 = 2592
> 
> As V4L2 selection targets are defined in respect to they larger
> sourrounding target, if the documentation about the full size array
> (3296,2480) doesn't tell you what offset the readable part is, I think
> it's fair to define
>          - NATIVE == BOUNDS = (0, 0, 2624, 2000)
>          - DEFAULT == CROP = (16, 16, 2592, 1944)
> 
> Or maybe better not define NATIVE at all.
> 
> The skipped rows/cols almost seems to match what the datasheet suggests by
> combining the cropping and windowing rectangles top/left offsets (with
> 2 cols more skipped compared to my understanding)
> 
>          crop = (0, 12, 2624, 1952)
>          win = (16, 6, 2592, 1944)
> 
>          CROP = (16, 18, 2592, 1944)
> 
> The driver does that a little differently with:
> 
>          crop = (0, 4, 2624, 1968)
>          win = (16, 13, 2592, 1944)
> 
>          CROP = (16, 17, 2624, 1944)
> 
> Which seems a little off as the driver values for the VTS and HTS
> register counts from 0 hence it seems to be skipping 17 rows and 18
> cols (maybe the driver adjusts when writing the values to registers ?)
> 

Datasheet states that whatever the window, it'll reuse the timings of 
the crop ("Windowing is achieved by masking off the pixels outside of 
the window; thus, the original timing is not affected."). So I assume 
what matters it that the timings are right for the crop.

> If you feel like it you can try to adjust the driver rectangles, but
> in my experience subtle regressions might be introduced by moving
> those values, hence I would not be too concerned and just report
> whatever the driver does. I assume you're doing this in the context of
> pleasing libcamera requirements, and as much as I don't like saying
> this, if we're 1 or 2 columns off when reporting the CROP rectangle,
> it's not a huge issue.
> 

Yes, this patch is for satisfying libcamera requirements.

I also just saw that we actually support two modes for the sensor. So 
I'll need to get the width and height of the currently selected 
supported_modes. Fortunately, the window+crop offsets seem identical so 
there's no need to add some logic for those.

I'll resend patch 3 and 4 separately so they can be merged and I'll 
continue fighting with runtime PM on our camera sensor, looking into HW 
if something's off there.

Cheers,
Quentin
