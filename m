Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A38E539090
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344156AbiEaMTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbiEaMT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:19:28 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00072.outbound.protection.outlook.com [40.107.0.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CA9813F3;
        Tue, 31 May 2022 05:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NktgjD0u0IB1+iFPip0PW5ttVP75EUCJr0W0j6FQNrPWVaf1faI46p5qjryiKPdfbxsFN9U5u77llYbCvIVdBf76QR+idSFtNmsKn6SwNq3S0sBap5QG5Y12CvGtC05eaYfFstOqJ4I2qgNFjNB05ePQNkEOGkbsq0qjDwrTFvYCRwC3WV/jU43qru7PTjZRYmjN+GsJVQFnEH4GiQQGvfKXXW3ARd9E75oUKEjvYpc97UGu4iDeXOIow3IUOypMdyr576ykd9DTuIde7HYAcaMp7zQAtOZKq7/P1vzqT+LQ+x+KAiQt+3+ifbb3mYgkvLrd6/+wlYhZzSQnwXE6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFMxpgKu2coUJwuFZbTEz6AYwEtB437i3ZEeDpmGHe4=;
 b=h9Jbw8Q0YQP8FkD3qHA/ZWdA7A1NwJDhQ76FoqmKvDSvo6le7hQKeNSeY1uqL99rKwbTwyAvZ4ZYsEcvpf0HzGX1w0gwHGNNbCAlB1nq46rJ5v4FJdfYt4FjPk/v+K/yUubdUorGk0FBfr4n53P7GLDrA+U+SoqRKEnOqQvymaKBO443OgneZM3f0/vSa0hBRjMw/LwmH40wwu7Sjs8wXNK5PIreP61hHuEHWrOUMY6A99O7dbuVDWkaXrqRpeMJseVogN5YorcQ/9vb8sx5MA4+9MZ0v/ZoQ0mM9YMs0Zd48NfaJTRTZ8GnFIgCXAuY3QLYVJnFRGoOrTCLXHpEgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFMxpgKu2coUJwuFZbTEz6AYwEtB437i3ZEeDpmGHe4=;
 b=Z2lFz18k/oWjdQ/4Xf0HDyPMzxUQ+0ESO4LHEfu5UffZ+KgNrPiaTzez1mIpmbbQJb71E+dlzyiJkQoC4AO93Tjc+FMZ7yUZlgBvJK+SZE4DdVKWJaRpwdzskKMciiqeRHxuxmrjsfxMVoCIvpK4EEfOJKLUvN/2OOev6TTKWBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by DB7PR04MB4393.eurprd04.prod.outlook.com (2603:10a6:5:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 12:19:23 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::880a:6606:6f57:dd0a]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::880a:6606:6f57:dd0a%5]) with mapi id 15.20.5293.018; Tue, 31 May 2022
 12:19:23 +0000
Message-ID: <842dbd3c-856b-e5a8-e942-545ceb6741ca@theobroma-systems.com>
Date:   Tue, 31 May 2022 14:19:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 4/4] media: i2c: ov5675: add .get_selection support
Content-Language: en-US
To:     Jacopo Mondi <jacopo@jmondi.org>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220525145833.1165437-1-foss+kernel@0leil.net>
 <20220525145833.1165437-4-foss+kernel@0leil.net>
 <20220531105011.yxrosmwtw3mpaomb@uno.localdomain>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220531105011.yxrosmwtw3mpaomb@uno.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR04CA0174.eurprd04.prod.outlook.com
 (2603:10a6:20b:530::15) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 408b9bb4-17ad-4532-e437-08da42ffcc0d
X-MS-TrafficTypeDiagnostic: DB7PR04MB4393:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4393348350A735999CF9BB32C2DC9@DB7PR04MB4393.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xen3LErGR/tOU9X/DyX73u3vwDZywpUD7rpt1ZJ52im863g4/gWfLb8empnarQdGZteVxG4oFhFrX7Ich73PG5UJZKML92vRu2Dw8rPSJ6423SC/NRNGDinlhFqBQeS07X3o/87WC6PmFVNobCKpZabtFTbpbnGwZJ1OOqupvISFPJIoyQQ+d8XJZzLp/RmkYunxZfmTUl5hjGP/9aNVDbRC6ReM4mYk77RHaU2trsTf0u0TgunN0DncuuxikgpnXEY0V11egwNmHKu3wvqPnGXKnEc9XoJdo0K1r2TJmm07IQOKO4PJKnI0r4Kuu5g5Ul5kSFUin+5V24JoUiLAh1cJOMxAcWaOHeh2R7gt0NY1g/T5CU/1ekcQf3S4lKhwnsVyNLARWiPN4gmmDPDwpwmE/5gOtWqIIIXFOvf+ZwcLQ8++YTc1KfxjT3TDCPL2/dq09ZzPPo+7IRXAXW4w+o5VbAnVYxNORrp5FIPvmVlS0/2oRZLsja5Fprg5LjgT5ps0vAipqFJOjmG2/uBdZHr0z6PBBqlhkcXIA1FUvgkLUB2+Du5oa0CmAyQyLaPdwwC5JN4wfiYP3Ek6+9RhzEJ9Edrrza8aVGLIM2AQGK27WObjfQXYPldyWnuZGxCgJ1oPXSyCvonoN3TSK9Wx/lbba7biU7i8PjBWyzx/RnBBVZAx+7kyigN9iLVSjsJPyx5EZhxM4f1xXAU+nqRFGpUNIEpaPBQmWN9eb8bFNreYz4uow+Xn4Qi4aqrqInzrUEs5qbj0UcHg07H/XXwF0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(110136005)(316002)(36756003)(508600001)(6486002)(31696002)(186003)(2906002)(8676002)(66556008)(66476007)(2616005)(4326008)(66946007)(86362001)(44832011)(5660300002)(8936002)(83380400001)(26005)(6506007)(6512007)(53546011)(31686004)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHRPWWxDQ2F1bDVVTGFXTXBSdmpFVkRIMjdSeko3WGJ1RmJmTXEvRUkxN3pO?=
 =?utf-8?B?YnVWU29Lalg4a0Z6VGR5RGFKTmRic01CNk1hS0ovWWFIUGFHWUs1emk1M290?=
 =?utf-8?B?eENTVUc5TTlZSDF1L3V6TUdsbHoxTEpnT1NoSCs3ZHlzeVlFVFVpazltbWZu?=
 =?utf-8?B?akVTaU1nZGY4QTUxdG5va2ZVeXpxS2VFUW14NFR3YlJkV2l4Z2cyWVlnRGhQ?=
 =?utf-8?B?bnVZTzlXMGRUK1VLT09tUzBsM2t4Y1l2eEx1cUE3UHpKWUVoSmY5SjgrWXhN?=
 =?utf-8?B?UUR4cGM3UFJNd0RqdlNFY3k0S2VRNFQyYzY0NTNJWVFlZllDc0NZc0NQaktD?=
 =?utf-8?B?NThsUEtZSTEyWEEvdXlTNVo2dDkzLzdkT2ZkeDZ5SjJFemdlNmk3SFlwQzNO?=
 =?utf-8?B?VCtwTGpLM0FPVTVLQVNNa0VuZmZKd0FyQ25TLzVGTytsZXNxdEFWa1F3ZFJw?=
 =?utf-8?B?RU1MQ0EycGRkcTVYVWJOL1lWek9Va3BiM2xSWmp1YTFKcGg2dXRqQUVkdXcz?=
 =?utf-8?B?aHhwbm5tTFkvb0REU01sZGhOQ2xMRk1IbTNZN2FwN3Q4S29sanJwWVFGUUVC?=
 =?utf-8?B?WDVPMVVlellPOUZsRE5heDB1Tng1eWcrZjZoLzRIaTRpWmxwZXdhenNDV09m?=
 =?utf-8?B?U0xzRVhYNEsrdW1oUUI5SUlCbDN3alBuOGVDcXlxK2tFRkdpTmRzWVk3MVph?=
 =?utf-8?B?VXI3N3dXb2lrbXkyalZmRU1Uajdaa1dwVFNiQUN5YnFUcWhjRmNGdXFObG1a?=
 =?utf-8?B?ZWVHdEdRbjduV29BdVVPd2JicXNKeEhNZ0RvUUpUWlRyNUhFT0FONHE2cDgx?=
 =?utf-8?B?OWd6ZjUwaHEvQ0NSeEF2L3JtQWxSaVMvNXcvRmoxNWRlYjI4T3FlOEpwaUFq?=
 =?utf-8?B?M3J2bzdTTEF5cU1RV2haMjdPVk1EZUx0RUkrZ0w2L3lVU0dFamt3RkduQU8z?=
 =?utf-8?B?d3BjNUEwcFlNbXQxU0dLQlpqNzBwQ2N3MWgrcEJ2Qy9PYURoRGdkeDZQRDBR?=
 =?utf-8?B?YXhhRDZDc2pLQXprRzloaU0zNGIwTFgrcCtjNGN6bzcvK1ZlajFVZVh3djJt?=
 =?utf-8?B?V1RTOFgxM3l5bGtBNTErOG85MVlRSWQzcmlpb3d4dmZ6OUpGUjJCQjBaMVp5?=
 =?utf-8?B?WUJWUW5lYzBkNStQUkNXN2RoUDJUQ1hYVUxGVHhoTWZEcnNnQTk1WXgwb3Nm?=
 =?utf-8?B?by83eTNnRXl4VWVaTW50R2NRRitkTHVmV3d4cnpvSC9NS0EybC9lMjVjSCt5?=
 =?utf-8?B?NitwZUxDVmdRN3ZMYjkxY2VYRDBOdjlQeSttdWd5RFJTODE1Z3dhT0hoc0NZ?=
 =?utf-8?B?V1VlSzBJbkpJK1pLMnlLMnhxTG5DdFNYRGpIakpNdTF3Skw0RHZWaldkYVM5?=
 =?utf-8?B?Y3o3ZlNmcUxCVmtMUkRucW5PWHpIQ0lub3JqY21BaSsyZ1dnb3R4anB4U0dz?=
 =?utf-8?B?QXhITHl1Q01WVWpxWUs1R3o4bzYzSDVnZkhxb3VIcWVRNjlMQzZoU29QaytK?=
 =?utf-8?B?SVdXS1o5U05Nejk1SDRBYUhrTE1DQ3ZxMjBWenhIMjdSUU1Bamtzdmc3aHRs?=
 =?utf-8?B?T3BDUnRKb0tZQUp2ekxSQ2Vya2gxaFUxTHFRRENpc0FUU0pFM2ptWmp3cU0w?=
 =?utf-8?B?Sk4wUDZkY3NXaUtNTlFOTGpCaEtxL05aSjVDejh6a2dpclhzWElvTWJsUDlT?=
 =?utf-8?B?aE9lS01XSWtSVEJpQVIwZENlb2E5L3lUTm0xV2lwY0d5UHlIZHRlamN4WDVL?=
 =?utf-8?B?V1ZZN1EwZEg2UWJMUnA0L2x6WDU4UU1xbTQ3Nk1LNFYxREJicFVaQmxzQ1E0?=
 =?utf-8?B?ZCs5Ulc3YzJZaVVUS1Nrem9sN3UyK2s5T2lIT3RLc0lHTHoyRTdlTlgxUTRv?=
 =?utf-8?B?dzIvY2V0SVlGL3pJNzR3OVpjZjBGYnFpTDAzLzhwWE80aFlGRE1JUUh4Q3JM?=
 =?utf-8?B?cDU1QkVFVmc1VHIzMnFWTUF1dUw2NWRTRDdSMm9GK05SRUhuRFU2ZERmTWE5?=
 =?utf-8?B?b05JaUFFeDErSDQwOCtreU4yWDBVWG5LOHBxUFRtZWwzWmVBSUZrUjZjQ01Q?=
 =?utf-8?B?QUVBTktKdTZKQVJERWNvMG00VzFrSktNWXFQc3RRUi9PQzVUT093Y3Bwc1cy?=
 =?utf-8?B?aUdMSlBwUllqQ3kvdW5FTVA2YmFwTHY1YS9aTWhTL09JNFRiTWZqK0ZiOFR5?=
 =?utf-8?B?OHloWE94UUFsNEZIYUthbFVjMEgyUzJwbVlPY3p1SkFsSWtub01rREdBZFh5?=
 =?utf-8?B?cXArNjlIVTlQcjl3dW51T3ZmV1BMc3V5RnBIQlBRSHh0QndTTXc4elhDRGgw?=
 =?utf-8?B?REVWcDRJWitUN1BzcXBydXVGV3hUMjJYa09pdzNaUFNzdndrS1hZVi9Dbkc1?=
 =?utf-8?Q?AMYw4o8xZFWZ6UR6qKVWEJiIqStatUajuDIW6?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408b9bb4-17ad-4532-e437-08da42ffcc0d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 12:19:23.5464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVacjLAdQunNoKjetfS1rH7+60pZxmX0usektiA+2fXJlmXxWVk/qBymy4n0gMamEXtk14chv0sqdMfT1CRy1PeNwUOB0X97l09R+kKB8+qw3OH2djoQfnL4ZrygmjCf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4393
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On 5/31/22 12:50, Jacopo Mondi wrote:
> Hi Quentin
> 
> On Wed, May 25, 2022 at 04:58:33PM +0200, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> The sensor has 2592*1944 active pixels, surrounded by 16 active dummy
>> pixels and there are an additional 24 black rows "at the bottom".
>>
>>                       [2624]
>>          +-----+------------------+-----+
>>          |     |     16 dummy     |     |
>>          +-----+------------------+-----+
>>          |     |                  |     |
>>          |     |     [2592]       |     |
>>          |     |                  |     |
>>          |16   |      valid       | 16  |[2000]
>>          |dummy|                  |dummy|
>>          |     |            [1944]|     |
>>          |     |                  |     |
>>          +-----+------------------+-----+
>>          |     |     16 dummy     |     |
>>          +-----+------------------+-----+
>>          |     |  24 black lines  |     |
>>          +-----+------------------+-----+
>>
>> The top-left coordinate is gotten from the registers specified in the
>> modes which are identical for both currently supported modes.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>>
>> v4:
>>   - explicit a bit more the commit log,
>>   - added drawing in the commit log,
>>   - fixed reporting for V4L2_SEL_TGT_CROP_* thanks to Jacopo's help,
>>
>> added in v3
>>
>>   drivers/media/i2c/ov5675.c | 33 +++++++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
>> index c1f3c387afde0..384a9ea2372c3 100644
>> --- a/drivers/media/i2c/ov5675.c
>> +++ b/drivers/media/i2c/ov5675.c
>> @@ -1121,6 +1121,38 @@ static int ov5675_get_format(struct v4l2_subdev *sd,
>>   	return 0;
>>   }
>>
>> +static int ov5675_get_selection(struct v4l2_subdev *sd,
>> +				struct v4l2_subdev_state *state,
>> +				struct v4l2_subdev_selection *sel)
>> +{
>> +	struct ov5675 *ov5675 = to_ov5675(sd);
>> +
>> +	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
>> +		return -EINVAL;
>> +
>> +	switch (sel->target) {
>> +	case V4L2_SEL_TGT_CROP_BOUNDS:
>> +		sel->r.top = 0;
>> +		sel->r.left = 0;
>> +		sel->r.width = 2624;
>> +		sel->r.height = 2000;
>> +		return 0;
>> +	case V4L2_SEL_TGT_CROP:
>> +		sel->r.top = 16;
>> +		sel->r.left = 16;
>> +		sel->r.width = ov5675->cur_mode->width;
>> +		sel->r.height = ov5675->cur_mode->height;
>> +		return 0;
> 
> I'm afraid this doesn't match exactly my understanding of the
> discussion we had.
> 
> The driver defines the following modes
> 
> /*
>   * OV5670 sensor supports following resolutions with full FOV:
>   * 4:3  ==> {2592x1944, 1296x972, 648x486}
>   * 16:9 ==> {2560x1440, 1280x720, 640x360}
>   */
> static const struct ov5670_mode supported_modes[] = {
> 	{
> 		.width = 2592,
> 		.height = 1944,
> 	},
> 	{
> 		.width = 1296,
> 		.height = 972,
> 	},
> 	{
> 		.width = 648,
> 		.height = 486,
> 	},
> 	{
> 		.width = 2560,
> 		.height = 1440,
> 	},
> 	{
> 		.width = 1280,
> 		.height = 720,
> 	},
> 	{
> 		.width = 640,
> 		.height = 360,
> 	}
> };
> 
> The comment says all modes retain the "full FOV", which I assume it
> implies they are obtained by sub-sampling and not cropping.
> 
> The first three modes (4:3) are indeed obtained by subsampling the
> full active pixel array:
> 
>          (2592,1944) / 2 = (1296,972) / 2 = (648,486)
> 
> The last three are obtained by subsampling a slightly cropped portion
> of the pixel array
> 
>          (2560,1440) / 2 = (1280,720) / 2 = (640,360)
> 
> If you set CROP = cur_mode->[width/height] you will instead report the
> visible width/height, which as said it's obtained by subsampling (of a
> slightly cropped portion of the pixel array for the last three ones)
> 
> The CROP rectangle is then (2592, 1944) for the first three and (2560,
> 1440) for the last three.
> 
> I would add a v4l2_rect to struct ov5670_mode where to record that and
> report it here.
> 

That makes a lot of sense to me, thanks for your patience and explanations.

FYI, you're looking at the wrong driver (ov5670 vs ov5675; a mistake I 
make every now and then too :) ). However, the datasheet does say that 
"The OV5675 supports a binning mode to provide a lower resolution output 
while maintaining the field of view.[...] The OV5675 supports 2x2 
binning." so I assume we're in the same scenario as you just explained.

Since the OV5675 modes currently supported by the drivers are 4/3 only 
and the smaller size mode a result of subsampling, they both have the 
same CROP rectangle.

>> +	case V4L2_SEL_TGT_CROP_DEFAULT:
>> +		sel->r.top = 16;
>> +		sel->r.left = 16;
>> +		sel->r.width = supported_modes[0].width;
>> +		sel->r.height = supported_modes[0].height;
>> +		return 0;
> 
> You could also define these values instead of fishing in the
> supported_modes array, to protect against future changes to the array
> itself. Up to you.
> 

Since there's no cropping involved in the current modes, I assume we 
could just hardcode the width and height and tackle this limitation 
later, once we add more modes or support for configuring cropping (this 
patch only adds the getter and not the setter).

Cheers,
Quentin
