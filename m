Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CD8461513
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345197AbhK2Mdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 07:33:53 -0500
Received: from mail-eopbgr80112.outbound.protection.outlook.com ([40.107.8.112]:40835
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229775AbhK2Mbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:31:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqSp6S3LZUoJzUovWpZAELxiKhhX2GVbgJXJVDguUi76mU1OMKP10Y3aDDnAeLTaxaPhHxYlfgb4CDDDYjo/KnE8bOpKU3vH1+yng1AXvJp5DfgaefT3aNmh/pTnviQFhn85a0ehyvQsIZdUCgT/+L9HMfsOSjPBUCKhwKKBG2e16rU3rs3sANym6MykAe+SfPe03izlNbwRjd9dekqFeOiq2g1zThFwqoYSnFA/yX5pzc6Qq5PKU21haKcdJecOC5fbpOOU30I9+Dhw4ovI86wVoEei/Kgjp1jH+FPv9D+egE8U/9E5SaxBxnCWmUbDX97gWlE8OTgy9QkQjBCarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiPRweWz2jWytZQRGyst5gYWLI+67R3yTxhWm4PKODI=;
 b=mQci4JH4nsFn/HFparpr0P4e8bmE1diEE8a8uEx4mzloy6e3sNcfSABmdycV0BMPR216aHnkegP8YwxoZvuKA6LGD1jUYEzGFxj3FH+mfKODAryKyZIkNbdROizHlYg1/SUaztfpLxj9yIZ4myHpQ2LWRD5wa3xKa/XApSpYxvbwsXVKz5QxJEqHHm5NJRfe0YTJOnbMzKD8MOiDns+RXxukWfmWdMlDr27sGOtMXOQoII00AKhMKvNLSUGoahmL5SLPM+UDoZ/8uW1EQn1oykktWJ6c3Z5eKygfQe9F78cndB1V7Vf2AbSMA8AuUZ+WIYkljeMCxp0obyPD30Vo5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiPRweWz2jWytZQRGyst5gYWLI+67R3yTxhWm4PKODI=;
 b=cjlmiw4KSd9GdkgyxpBvstFqmZpdxjEyAsYTlkutfErN/s0r5bgLsnA8HrsiAk6Vo7puS4Ys7NEwGDtpKnoO4/MahnoZj2dWo/Hq2kb9p93+nZm0KUlQ1PxnRpwD75VDY+pcz9qD3x/NAkODti3YvXsuBYK7umxvbcJ4WyZIXso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0201MB2390.eurprd02.prod.outlook.com (2603:10a6:4:35::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 12:28:30 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 12:28:29 +0000
Message-ID: <11e3bb89-d706-28c1-b7a5-e61c5cc99c93@axentia.se>
Date:   Mon, 29 Nov 2021 13:28:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RFC v3 1/4] dt-bindings: mux: Increase the number of
 arguments in mux-controls
Content-Language: en-US
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
 <f6e8cec9-4d74-dda5-d56a-b55ebfadf30a@axentia.se>
 <46644e9a-a9e9-4cdb-47e3-f42ebf49f805@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <46644e9a-a9e9-4cdb-47e3-f42ebf49f805@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0066.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::9)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0066.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Mon, 29 Nov 2021 12:28:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87c4c3f5-88e4-4d9f-9a79-08d9b333c010
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2390:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB23900E9B800EC6F53DC4C97FBC669@DB6PR0201MB2390.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x19C9aYXwb/NlkK2FBnOmAUYzyo0MnO49uCzlRqjC/VNzV2/p7Ywc7G76CNA0DaZsVsTzwepV4gXyTkkNVHp/orZN/TiHNI6e4vhYM0X6SuXbFOZnQzX9e6Roz2n9BS6c9b+FIhtPNypbK9+XYAqQb+9MrF9WZRSTx+tejIp9ybNn5m1lZUwZMc5MoSmdwVjmapwYx/x7zC3YDu///gsyUPbUx5pJIEN1LFjYv8ET1hQwLorxNTM4mefrexhb2oQIw2E0hrjRqrQ9/MhtHXUh8L8aOIXgQS4hAS9SE4OCY/izVZJWr3DrkeZKzWVo6hcfrJj3Do+ORtpehXaqvQPZzYTUh2nC2V7Q/pz9X1R7vkJa0cW4p/hrQodv+NVjesYEw4ToM78XKB8VsMgtXLBNl0cog6wjL05t3OCunBzvNBVZVwMLxnhDgEdHIUVyvP++2PXiiHfPmmxnQDBymbSxv+Wr+4kQthZ8wDSk3SJqYDbb7fapPCc6Ka/LVabWqKIyUKaIdxzpgEq+mHr6rF+Mvf8CjkpiXV9MUjdBKrVKeIiunImcuWHtinHuG5fProH8dA0ERnSb4n14xrGnGWTo+RZL1THMXcD1NKqbNAgSFq+aunMMNu8JfEpRoGzIDzqtgn2jtqgWSMNdqD5KO4Cg4D4smMlirBJ4K2bnnFTcFzkvBtEQDK+J/eUmkqRox8gjNVJnscNDYxl0mw+sY+PIDJRF9dFanqGGAM3uQynd8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(39830400003)(366004)(16576012)(8676002)(6916009)(7416002)(38100700002)(83380400001)(86362001)(53546011)(31686004)(54906003)(8936002)(316002)(36916002)(6486002)(5660300002)(36756003)(66476007)(2906002)(4326008)(508600001)(186003)(66946007)(26005)(956004)(31696002)(4001150100001)(2616005)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjJwVFVpRlA0WjE4Smh5NXd2cTdhclJXYjI4RUxtM2NiejIyMzNzbTU5SUxo?=
 =?utf-8?B?TWVLMUFidHRvWm5tTk94cGxCN2pFREpMQmd3VDRJektPRHY0Y2c1Y25PT3B5?=
 =?utf-8?B?N1dpVXB6WGFlOWtjK3B5T2JwQnkvbjhibjdhOHR2YUE3eTUvRlJiRlVRSmwz?=
 =?utf-8?B?WGJxVko2eG53M1FOa29MS2N2VStiRDZ6Mzh6LzdyMTd5am9EaEZPNFA2ekJs?=
 =?utf-8?B?RzRPTG9KZjVJNEY0ZTRWTzJueEVSM3lVaVFmQ0hTSVdKSUFkdlhvV1ZNQnh1?=
 =?utf-8?B?YXRWT2tTcTBnL1FRNjlQUTZpOWt3d0ljL3JPcWJMNnduNjRuamdBcURVdWNQ?=
 =?utf-8?B?Q0R3eVJyVk9RQko5ck1IcnAyQlozRTd1Y2tSR1JyTDlFU1RTR2c5VHRqMGFW?=
 =?utf-8?B?OGJvRXMyTGZzcVJwZkt0c3V5WEtreVJSRE1IdG03QW05YmNDZnMxVGJwckdE?=
 =?utf-8?B?ZXZ2NjIrSG52ay9rYjduRUpidVlqUFhUSElQSkVVN3ZMRnFmQmwrNG9rbytT?=
 =?utf-8?B?NDRVN1NSWTlLYkh5ckNNSVBMY3JPcmFZNmtvaHgvbUJXZGhWSFdWZXJxdC8y?=
 =?utf-8?B?blFlcDUrV3Z5YUtoTU1pZ2RMMzNWNyt3NDRud2pvUUNiMStod3BKRnRnbEtP?=
 =?utf-8?B?UFlqeW9PVGx5RWFBb0tuWjRQQk8vVjVVaGdKNDhYVmh5dERQWkhWN0dTQ3BX?=
 =?utf-8?B?RTdPTm1NemJRTllYT1lvTC85WEtJWFFOdU1sMGZDYzR3aUJUbEVpUFQvSkdO?=
 =?utf-8?B?cXNmRzJ4N0pMTXF1clVDY2ZUb09WanlubGt6eXlsbUkzM3A0T250NTVWK0M4?=
 =?utf-8?B?cjIwU3dJWFdyOWFORkhzaWZZUG9wZU1TY1JPaVlSTXY1eDVGNlplVzg5eThI?=
 =?utf-8?B?WWlUR0wreTVQcVNWdjBHQ2NqbDQwQmk5ZmlmVkNid25zVVJTMUtuRVNWbmlu?=
 =?utf-8?B?U2QwYWVvUnlzTnp4SDRiSFFNM1ZhLzMzd3NnMFR2WkxEWkpJQkY2K1hieG8r?=
 =?utf-8?B?YThnd2tTZ1ZtSXFyV0RBN0xIT1EyQ01VZ3ErVjVIV1dLWnY3Y2tQcHh0QkFL?=
 =?utf-8?B?UkpRRmhPWUdBUDJsbVFwRFlrclRmbkxCbGk4YjFxTHAzKzgxZzhyVHdNZkUv?=
 =?utf-8?B?dW40Q1VFT21MS2lYTUthOWxQK3dHRkYyaERPYlY4bU5PZTlRSzRKODlGanRh?=
 =?utf-8?B?b3lob3lOK1pxWkQ3aExwVEp5SkswT0JxTFI4VFpkc3ljU0x0T25relpCaGNF?=
 =?utf-8?B?YmZRMlUwdW5SSHhLYkxhbFlLMmxWT3BJTEtmVUpWaE1tZmUxdkdiem40SXRy?=
 =?utf-8?B?a3ZPMmlFSWp0bG5zQVFuMXhFcE8zRHR5MDMvUUJGdUtSY2NYdmc5aFdGdHlQ?=
 =?utf-8?B?bjIrMmtva2s4d3FXQjUvMjY2SVduVG1aSlY2ZkRNMTlWUmFGNUxacTRJUXZ4?=
 =?utf-8?B?ek1hVWphbjFpeGNYVXlIcjI1cGVscjFxY2JvV01YQ2lvajhWbDl1b01XTWZT?=
 =?utf-8?B?aFRqTjNqUzh6QmNneEJ2NjM3WnFRdDRHUCtxbVZTOCtSVE04TGpVWDNkZm9N?=
 =?utf-8?B?b2lUNmdXUGs5Zzg2d0RHVG1VcmRRVlcvbTlpbnk0Qk15YW1KSU84bTU0aGo5?=
 =?utf-8?B?MCsrUjJSbWpOTFQxMmhlN0J2TFd0YUhJWitleFFtdDg4MWsvbjNUWE43UXo4?=
 =?utf-8?B?ZitkVFZZYVNmcjhVWjFmS0V5SUZoR241dW1MS1ZTZjQxeVM1OW9FVTJ6WkVS?=
 =?utf-8?B?c2VZbUFuYTJpNW4xMDh5K2pEY2J2aW5kbE9PUVRxMjFvMXo4NE4rODJhaDFU?=
 =?utf-8?B?LzB4Y1JUb0xpd01UWnB3N29tN3k1S3JzVFRYQjUrSTRibVRNWWF2MnZqVUtF?=
 =?utf-8?B?MkRNVjYzQm9YczE1WFFVRmFsVFZwY2RVRTJFaFBXalZ4a0tCSWxmTDlWNWor?=
 =?utf-8?B?cHZsYTJKQWM4Uy9GN3BtVjBmNkFRQ3dKMC9JQ0R3aFlKZHM5dUhmWm9EUjc5?=
 =?utf-8?B?ZTB2cEFva3F5amdnbE1EWkl3WWdIME9iSENGYi9XRVQrWXhSN1dBYndLWWJY?=
 =?utf-8?B?NDVOV1FacVVENXF2bUprQVZvck9zMHIvaHFLS1kxSEtIY0ZTOGNqenhHZDN1?=
 =?utf-8?Q?8Cnc=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c4c3f5-88e4-4d9f-9a79-08d9b333c010
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 12:28:29.8732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17nYlSy5cHICquOWmlPVqBa9hCSltOaRc51pzA1cuRz5/PUHGJD+R2GF8uPUGyUY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2390
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

On 2021-11-29 10:31, Aswath Govindraju wrote:
> Hi Peter,
> 
> On 29/11/21 1:45 pm, Peter Rosin wrote:
>>
>>
>> On 2021-11-29 05:36, Aswath Govindraju wrote:
>>> Hi Peter,
>>>
>>> On 25/11/21 7:05 pm, Peter Rosin wrote:
>>>> Hi!
>>>>
>>>> You need to have some description on how #mux-control-cells now work.
>>>> The previous description is in mux-consumer.yaml and an update there
>>>> is needed.
>>>>
>>>> However, I have realized that the adg792a binding uses #mux-control-cells
>>>> to indicate if it should expose its three muxes with one mux-control
>>>> and operate the muxes in parallel, or if it should be expose three
>>>> independent mux-controls. So, the approach in this series to always
>>>> have the #mux-control-cells property fixed at <2> when indicating a
>>>> state will not work for that binding. And I see no fix for that binding
>>>> without adding a new property.
>>>>
>>>> So, I would like a different approach. Since I dislike how mux-controls
>>>> -after this series- is not (always) specifying a mux-control like the name
>>>> says, but instead optionally a specific state, the new property I would
>>>> like to add is #mux-state-cells such that it would always be one more
>>>> than #mux-control-cells.
>>>>
>>>> 	mux: mux-controller {
>>>> 		compatible = "gpio-mux";
>>>> 		#mux-control-cells = <0>;
>>>> 		#mux-state-cells = <1>;
>>>>
>>>> 		mux-gpios = <...>;
>>>> 	};
>>>>
>>>> 	can-phy {
>>>> 		compatible = "ti,tcan1043";
>>>> 		...
>>>> 		mux-states = <&mux 1>;
>>>> 	};
>>>>
>>>> That solves the naming issue, the unused argument for mux-conrtrollers
>>>> that previously had #mux-control-cells = <0>, and the binding for adg792a
>>>> need no longer be inconsistent.
>>>>
>>>> Or, how should this be solved? I'm sure there are other options...
>>>>
>>>
>>>
>>> I feel that the new approach using mux-state-cells seems to be
>>> overpopulating the device tree nodes, when the state can be represented
>>> using the control cells. I understand that the definition for
>>> mux-controls is to only specify the control line to be used in a given
>>> mux. Can't it now be upgraded to also represent the state at which the
>>> control line has to be set to?
>>>
>>> With respect to adg792a, it is inline with the current implementation
>>> and the only change I think would be required in the driver is,
>>
>> No, that does not work. See below.
>>
>>>
>>> diff --git a/drivers/mux/adg792a.c b/drivers/mux/adg792a.c
>>> index e8fc2fc1ab09..2cd3bb8a40d4 100644
>>> --- a/drivers/mux/adg792a.c
>>> +++ b/drivers/mux/adg792a.c
>>> @@ -73,8 +73,6 @@ static int adg792a_probe(struct i2c_client *i2c)
>>>         ret = device_property_read_u32(dev, "#mux-control-cells", &cells);
>>>         if (ret < 0)
>>>                 return ret;
>>> -       if (cells >= 2)
>>> -               return -EINVAL;
>>>
>>>         mux_chip = devm_mux_chip_alloc(dev, cells ? 3 : 1, 0);
>>
>> When you add cell #2 with the state, the cells variable will end up
>> as 2 always. Which means that there is no way to alloc one mux
>> control since "cells ? 3 : 1" will always end up as "3", with no
>> easy fix.
>>
>> So, your approach does not work for this driver.
>>
> 
> Sorry, but how is this different from the case of
> 
> #mux-control-cells = 1
> 
> If #mux-control-cells is equal to 1 it means the consumer will use a
> given control line from the mux chip. The same would be the case when we
> will be using, #mux-control-cells is equal to 2, except we can also
> provide the state.
> 
> If the consumer will use all the lines then #mux-control-cells will be
> set to 0. In this condition the state can't be provided from the DT and
> the consumer will be controlling the entire mux chip. If
> #mux-control-cells is greater than 0 then we will not be able to provide
> multiple lines of control using a single mux-controls entry(mux-controls
> = <...>;) right? We would have the using multiple mux-controls
> entries(mux-controls = <...>, <...>;).

I think you misunderstand. The adg792a driver operates the chip in
different modes depending on if you specify 0 or 1 cells. With 0,
it's not just that the consumer operates three muxes. It is also, and
more importantly, that the three muxes are operated in parallel without
the consumer doing anything different with the single mux control it
sees (even if there are three muxes operated by that single mux
control).

That said, yes, you can make it limp along like you describe above.
But why should it not be possible to specify a specific state when
the adg792a driver operates the muxes in parallel? And yes, you could
add some other flag to indicate this mode, but my point is that it
is silly to add special cases like this if you don't need to. Since
adding a specific state is the new thing, that is what should be
added in a way that fits with the old stuff without imposing new
flags on that old stuff.

An example: the three muxes in an adg792a chip could be used as
two muxes for some I2C bus (SCL and SDA signals) and the third mux
for something unrelated. Suppose that you want to operate the adg792a
as three parallel muxes so that you mux SCL and SDA simultaneously
(as is expected by the i2c-mux-gpmux binding, it only expects one
mux control), and that you want to use the third mux as the enable-
state for your phy. With your suggested binding you cannot, unless
you add a mechanism to make the adg792a driver operate its muxes in
parallel even if there are two cells instead of zero. I.e. without
that new flag the i2c-mux-gpmux binding needs to see

	#mux-control-cells = <0>;

while your new phy binding instead needs to see

	#mux-control-cells = <2>;

And you obviously can't have it both ways.

(Sure, it would not be possible to mux the I2C bus while the phy
is enabled in the above example, but there could be some other
limitation in place that makes that invalid anyway. And it's just
an example anyway...)

A mux-control is potentially a shared resource, and bindings have
to take this into account.

Cheers,
Peter
