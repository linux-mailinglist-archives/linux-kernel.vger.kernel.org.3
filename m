Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0179A460FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242128AbhK2IWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:22:03 -0500
Received: from mail-db8eur05on2100.outbound.protection.outlook.com ([40.107.20.100]:11959
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240603AbhK2IUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:20:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA9wt1MHjH5/XR41G8YfI7W4w6tyZQ6iJmjA7TTNitkmNRObQjd6r1kBy71cxfucShINBz5SIhnSyEhCSX4uGHMwCSgS79hdHf6mOm75CULbGhuXOxqK0VbuKExfyI38JiIKlznmJp1Pmheq4kNRmd+T0Ok1Daz8nmQ80Q/sW42qfHU6bFEkEFZRIawpvowtN978+hAoxBjWgWEU5h+SDgYm2uEaOOyyIiOBpRUjDkNwEhQXo+OD96zUMdB1E+EpiwJy54ksyFK6p6uIRsz5g5BnQp994JEJ32r1BqiUrDTNpVtliH2eEEf3yrbiE0L05eMb50ynpG3hXNGfmzfADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnzwdVN5Yv5x3n9I6ZiqDELMJFDUJBXZpPRM40BpvCg=;
 b=ZX4rRVgYbnto++0eoMACBkIxKQ6nhTJbx6ZHrRtHBYHm50Xu5g5ABfBya8+Y/XciMOkyclcRaftzo+ZBMREit3eHtn3O8eg1SNvFjgafSvLncVnGBfKi5i+tpvqj7dsIADuBuIVFbh3MrkRD1GIrGnUpIPnssxqfm+h1xTR/YqIZ+VZhYd50ZKV8a+xQABxmLq6kD0S3z6iIRgGl4j5O8OEYxMZKkLCA/2Bi36yHjFWaDymcpFV3bJ7UEr6NX5jNNgaYtLilpRMELvX8AQQrHDSVm0sB0qVNOC/Nop24yCqFJY0/pDyGnME7F+rv8Nx2q31BS0OSMXPLO6yEAOB4Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnzwdVN5Yv5x3n9I6ZiqDELMJFDUJBXZpPRM40BpvCg=;
 b=L48nRGj+AouxpEY9CWMLSfXcQQg1YEgIULcTAHRHfgmGPbGQzQDKdrlkWtSjkdytiKO8hrKn1elKCqIMdzWalJxT+WWV3rG3GtrAnwXzRlsS80bovYXxF2+aUZZF/tsIesqYARPVDVrJnCt+svbrzhGcEO+J3izLvXCmw8keaO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB7164.eurprd02.prod.outlook.com (2603:10a6:10:22c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 08:16:42 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 08:16:42 +0000
Message-ID: <f6e8cec9-4d74-dda5-d56a-b55ebfadf30a@axentia.se>
Date:   Mon, 29 Nov 2021 09:15:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RFC v3 1/4] dt-bindings: mux: Increase the number of
 arguments in mux-controls
Content-Language: sv-SE
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20211123081222.27979-1-a-govindraju@ti.com>
 <20211123081222.27979-2-a-govindraju@ti.com>
 <24781209-928b-dea4-de0b-b103dac8de82@axentia.se>
 <5f455c4d-5edb-4382-1193-a519a7a227a5@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <5f455c4d-5edb-4382-1193-a519a7a227a5@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0058.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::28) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0058.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 08:16:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ea4b405-ec4b-4b93-ec57-08d9b310935c
X-MS-TrafficTypeDiagnostic: DB9PR02MB7164:
X-Microsoft-Antispam-PRVS: <DB9PR02MB71641387AC06DD8E2F38FAABBC669@DB9PR02MB7164.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2Tv67YGdNTiWiv7G3v4PPo5ErfWwr72rsJ7HGXmTNgYgj3QGtiX8VYZUK/KuQ2+5DzWUV5U1aGe+3lfB61xc4mmz7vbYskgzCtSgMKh/d0kz5TVJPFbNNldkpZ+BAmwWzlxwNVVNIe2OZVO9CGOOtdyKHTE1C8w4tR8UG80xp0huCxn+bYhiyWeVcsiZLTYsGVG0tcsxZH4EmT2UJQBhVanqtyPGtDoxhIXwmfvwIx1uJMfnbpM4dF3pl01sH712n0TXu6x9GkjpJ8Rl9BRTm6L0Fjc0vjZGOwF5npEdE3AVs8e2JPSvIsVBlx9B0U/95aX9lb/B1rmGEqquysA1t3IVAOlPmh4apW2u+gn2e/M8s53qedqC/VCgvVqytACIxsn/+9nQUVyHyTJCBYDXskeA4C3Mjte5r68zpv+wLHjXdqfKHvYrASmhr0RkpqRj+hxduTHGdYWvrLXHOknvMQCxuZ1NbfzGk0AINpqw9YzBaXo869W0pFxKUEG1tCqQAQcFBjJiXVI7Nk2HnD3AnkDYqjBfcjOxIT4bT6re9rS8+uNXS1wEBQVmDCSiEkt7mk/PMji1DP1Nc66YL5tEDuEiD2z6aB+F3t1ast0qlojAdniiXFYx/2g3rHDTFeMRvDAF3yoEOPDh+A4Tix0yIp5CghHyIHLjcElCupxj4NojXNWEwK17aYK8d+NJVzYcMLW/J/UvQS5XitD1WMkae3oF0NNS0EhyW5Do+6xf2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39830400003)(136003)(366004)(376002)(7416002)(956004)(8676002)(4001150100001)(86362001)(5660300002)(66946007)(6666004)(36916002)(6486002)(26005)(36756003)(66556008)(316002)(186003)(16576012)(66476007)(31686004)(31696002)(6916009)(53546011)(38100700002)(54906003)(508600001)(8936002)(83380400001)(4326008)(2906002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzVCYU5WSSs3bE03eisyM0phODlyRWUwTlRVQkFSRXdnY0t3dHpISGIzRm40?=
 =?utf-8?B?SVVrZ0w0a05HT0pYeS9CZHJhQ2g2RXhzNjFLZmt1V0JodlJwVTRYQWlVY1Q1?=
 =?utf-8?B?TnZ6aitrdGpIdGU3RFhSV1lYdy84OFRuQ3NaQWJCSGdEWGMwcU8rSkpTaUZx?=
 =?utf-8?B?clprRzVqWS8rRUw2cUgwM1ozek44aWlVdDVWaHR4WjYzQjdmQkNERFdUWXRN?=
 =?utf-8?B?VVVVbDFldHVBdnhmNThvcmk5K1o5dkZxMTk5YjJjNzBuak16d2h1NDRBZjRw?=
 =?utf-8?B?cVQvUWQ3WGg0SmN4VWFYdlRJemhEQkZLM2hDOWszS0xTK0VHT056emRKM09t?=
 =?utf-8?B?ejhyaTg4WEZocHUvRGloNzVGNjlDL3FQVFVTaStKL2FtdU1iQW90bU9OSlNK?=
 =?utf-8?B?M2dKZGgrc3Q0OHY0aFN5VngyMXJXQyttNng0UVNDQVNReWR4WWdlOG43RE13?=
 =?utf-8?B?WjB6eTUraVZESkFFMmg0UUtMM0ZEUWROdXN3T3M0eHhBL0xpOUxoeFpvYzhj?=
 =?utf-8?B?aGc2aXlTVy9zTjk0dkQ3QkdUS1F3UWpBVmtxNHkvZWxnZGlGbXZWeExXeEJ0?=
 =?utf-8?B?STBjU2R3aHcvVjBVL2Q2OXAyaGtiM3lOQkJha1JLMG90cHA0QU5DZFBpRVRM?=
 =?utf-8?B?T052MWM5WHFEc2VUWDFib1hVV3JNQjc3RWtSdzl2VlZXZmlHOCtRem1yYllR?=
 =?utf-8?B?Y1Y0YXczcW5wSFNiaFZoMWZWOU5jdHB6MnNYdkJPeWk2aERSdzN4dEtxQjV0?=
 =?utf-8?B?ZHY3TWpiNTcwanBncDVZTFdISWNQOVZ5c0xySkQ5Y2pEemxZdWRxNkFCdk1F?=
 =?utf-8?B?L3FFbDZtNVNWYjdldFVBRWxQQSt3UHkzSHFwWGVmRW5xNUtPNWZ0U0hvbG1M?=
 =?utf-8?B?TGVRb1FXVi8vRFlKQXdDbWhLWDVjRjU2QlQ5U05VK0ZobDNsSGlwb1Zqa2Qr?=
 =?utf-8?B?dElpcXZUWXgzeC9XZWp1TEMzbXBWVFQvbnd5Rnp3VmpkK0VyZkhrdWN6WVFl?=
 =?utf-8?B?eTlzWU8vSnVWVjh6OFA4ckFkRDhFT3ZONjlWN2lDYlZla0dYNjZpS3BwRzBn?=
 =?utf-8?B?enF0dGtoUVBjSmFNQjdPV1dnY3lEQ2tLVzhxZVVaWitlQ1ZXWW9zL0pmeEIz?=
 =?utf-8?B?MkNTbzZCWGdsVDJENTZjS0QrSWYrdGRGL1pKLy80YkgyemFsUW1BU0FTRDRq?=
 =?utf-8?B?U09FZ1ZXU3JCYjFleXdocTYvamt1Q3J3c3dXNEZUQ0o4UVZzZVlSek9mRkc0?=
 =?utf-8?B?M0U2VjFBQm5sdWxSSkxZYko2bG85ZHl3SFZ6YWpkblRtYjhYVFA2TEVza0l2?=
 =?utf-8?B?OGYwdGtNSm9GREx3MFpuaThVZFlORENST3phNkZqMFRpb1NBNWppK05QcDE4?=
 =?utf-8?B?d3JiVkkrMVd0SG9NOE9ISHdnSVJ4d096K1pFMVZJVG9oSEhIUE5hNDJ5Z1RR?=
 =?utf-8?B?dHFsZG1YU21XUzJrcjlqOStCVTB5OXZ1ckhoQ1JpbENVUVB2Y3dCZjRqaU1Y?=
 =?utf-8?B?WWIrNjZ4Ni9JK0dOU0RwRGVOWEN3SEdDNENuTytrK3FseXJadXJiZUxlaGcy?=
 =?utf-8?B?anVWLytLNnpkNmNZcG90cE1VL3RwcXFOL25HV0U4Tk5VRmk3Skd6aEhOZ2Qz?=
 =?utf-8?B?Uk9iZFdERzhqQklzN09xZlJEcThpNjhrRHROS3FDekVqQWVrSVc0Y29lL3BH?=
 =?utf-8?B?Z3pMWDV5VXRSN1RzNis0cFYxVFVQUzVmUHdETnc5SC9zamVHRDVFVWlXNU9s?=
 =?utf-8?B?S0hxMHJoVC93UTlUWUpXK0F0REdsdUhQeUs3bTVxcThEa2w2aXpSYUNya3Y2?=
 =?utf-8?B?SXdtQm4rTFlENGwwNzNWK2k0aVp0cHdTNEpad3lFQ2NrWjJzNm1VbzVETFpr?=
 =?utf-8?B?eFl1NnRIeU9uNW9KMjFTUjFUcE9sRUk4eG85NXBTd0sxNVdGR2R6b3Q0bi9t?=
 =?utf-8?B?RCtUMzJUWXBkbHlEREoxRzRIMFNHczFQZDY2ZnBBVm9zZGY2STVUZGwyV3JT?=
 =?utf-8?B?a0lKK2Z4YlNHWVFNQnM1RFpnSWtoODhCb1RFYXVWekJDUk5rOW03am1UY3V0?=
 =?utf-8?B?NU96UXEyUDRkUU1CTWxrNVJUSC9pc3FGSW5TdVRHalFOTG01TERxT2pxRjIv?=
 =?utf-8?Q?Vyzk=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea4b405-ec4b-4b93-ec57-08d9b310935c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 08:16:42.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNW44FexvrrnL/SqUMOI7M8H2FeFE7wsYYnco6pACVRLhhf/e4LiU55wYpd4Zidn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7164
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021-11-29 05:36, Aswath Govindraju wrote:
> Hi Peter,
> 
> On 25/11/21 7:05 pm, Peter Rosin wrote:
>> Hi!
>>
>> You need to have some description on how #mux-control-cells now work.
>> The previous description is in mux-consumer.yaml and an update there
>> is needed.
>>
>> However, I have realized that the adg792a binding uses #mux-control-cells
>> to indicate if it should expose its three muxes with one mux-control
>> and operate the muxes in parallel, or if it should be expose three
>> independent mux-controls. So, the approach in this series to always
>> have the #mux-control-cells property fixed at <2> when indicating a
>> state will not work for that binding. And I see no fix for that binding
>> without adding a new property.
>>
>> So, I would like a different approach. Since I dislike how mux-controls
>> -after this series- is not (always) specifying a mux-control like the name
>> says, but instead optionally a specific state, the new property I would
>> like to add is #mux-state-cells such that it would always be one more
>> than #mux-control-cells.
>>
>> 	mux: mux-controller {
>> 		compatible = "gpio-mux";
>> 		#mux-control-cells = <0>;
>> 		#mux-state-cells = <1>;
>>
>> 		mux-gpios = <...>;
>> 	};
>>
>> 	can-phy {
>> 		compatible = "ti,tcan1043";
>> 		...
>> 		mux-states = <&mux 1>;
>> 	};
>>
>> That solves the naming issue, the unused argument for mux-conrtrollers
>> that previously had #mux-control-cells = <0>, and the binding for adg792a
>> need no longer be inconsistent.
>>
>> Or, how should this be solved? I'm sure there are other options...
>>
> 
> 
> I feel that the new approach using mux-state-cells seems to be
> overpopulating the device tree nodes, when the state can be represented
> using the control cells. I understand that the definition for
> mux-controls is to only specify the control line to be used in a given
> mux. Can't it now be upgraded to also represent the state at which the
> control line has to be set to?
> 
> With respect to adg792a, it is inline with the current implementation
> and the only change I think would be required in the driver is,

No, that does not work. See below.

> 
> diff --git a/drivers/mux/adg792a.c b/drivers/mux/adg792a.c
> index e8fc2fc1ab09..2cd3bb8a40d4 100644
> --- a/drivers/mux/adg792a.c
> +++ b/drivers/mux/adg792a.c
> @@ -73,8 +73,6 @@ static int adg792a_probe(struct i2c_client *i2c)
>         ret = device_property_read_u32(dev, "#mux-control-cells", &cells);
>         if (ret < 0)
>                 return ret;
> -       if (cells >= 2)
> -               return -EINVAL;
> 
>         mux_chip = devm_mux_chip_alloc(dev, cells ? 3 : 1, 0);

When you add cell #2 with the state, the cells variable will end up
as 2 always. Which means that there is no way to alloc one mux
control since "cells ? 3 : 1" will always end up as "3", with no
easy fix.

So, your approach does not work for this driver.

Cheers,
Peter

>         if (IS_ERR(mux_chip))
> 
> And the following series should be compatible with it. If adg792a driver
> is the only issue then would there be any issue with only changing it
> and using this implementation?
> 
> Thanks,
> Aswath
> 
> 
> 
> 
>> Cheers,
>> Peter
>>
>> On 2021-11-23 09:12, Aswath Govindraju wrote:
>>> Increase the allowed number of arguments in mux-controls to add support for
>>> passing information regarding the state of the mux to be set, for a given
>>> device.
>>>
>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/mux/gpio-mux.yaml       | 2 +-
>>>  Documentation/devicetree/bindings/mux/mux-controller.yaml | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mux/gpio-mux.yaml b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
>>> index 0a7c8d64981a..c810b7df39de 100644
>>> --- a/Documentation/devicetree/bindings/mux/gpio-mux.yaml
>>> +++ b/Documentation/devicetree/bindings/mux/gpio-mux.yaml
>>> @@ -26,7 +26,7 @@ properties:
>>>        List of gpios used to control the multiplexer, least significant bit first.
>>>  
>>>    '#mux-control-cells':
>>> -    const: 0
>>> +    enum: [ 0, 1, 2 ]
>>>  
>>>    idle-state:
>>>      default: -1
>>> diff --git a/Documentation/devicetree/bindings/mux/mux-controller.yaml b/Documentation/devicetree/bindings/mux/mux-controller.yaml
>>> index 736a84c3b6a5..0b4b067a97bf 100644
>>> --- a/Documentation/devicetree/bindings/mux/mux-controller.yaml
>>> +++ b/Documentation/devicetree/bindings/mux/mux-controller.yaml
>>> @@ -73,7 +73,7 @@ properties:
>>>      pattern: '^mux-controller(@.*|-[0-9a-f]+)?$'
>>>  
>>>    '#mux-control-cells':
>>> -    enum: [ 0, 1 ]
>>> +    enum: [ 0, 1, 2 ]
>>>  
>>>    idle-state:
>>>      $ref: /schemas/types.yaml#/definitions/int32
>>>
> 

