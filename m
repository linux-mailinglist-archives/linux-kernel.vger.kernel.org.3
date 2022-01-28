Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4E249FC64
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348748AbiA1PDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:03:41 -0500
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71]:39488
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346152AbiA1PDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:03:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joqd0eIIaHAd6wR7GUGnuUQaWWcjY+i8jGZf0N1ZRsqJIwHE0Lpi4K/wYFDWpLP5RKWMRQYCbypouXkTQgcTN5Y/KP1rJ4bq4yCO9/srBji1ymnBzRRk3Tf1LUZfODmgXz4dKIDZJgRtvVM6dU3N0l0Gki7Hm/fkuY9ZUAkJnAWQ7KdhSUS1qo8GPEoNuI+RPkUWXGp0F3dY90GQsjiJO5FYFUa4nb+FU//wAeiDESg8kgPu3LvvgzzqbF1stFb4ChP9lCECYGHNXXYPgSCNmPsQ/kGnQxN1yiZNlXUtE2zBhkXO0s+OHtWzOI9xhGbO9YhsptREfhVy8oaZ012Kjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMpktnw7oCNJk0klvmlV2RQOmhKQ3B4AZgXLwNYeMIg=;
 b=T2hbeaWoX1q1F4IAjum9ggB6sYNnuU2+C0kFXc6j6VLkA/fNm9anDcLsZMojeWBT1tsFQOveT7YztPJi4WtsM6v3aWrwzwWYi8oW2hHX8JnahVlzcwD48LhBZwwhaEXCHYhIlaeB3mL4tDfLwTDUe/4HGbJ3HusYIIwvh4+qAjHdnf205kLx99opYr4+pjJMkCxVWaUWUkPrU21Advp2ys1v7FSzN8RQ8UdKxQY9rApJmu0vvcpK9NA0ztklc5ovCEILocK9cfgtcf7h/jHcKfKAf0pdZfNTVLjgVBR4EbWRL4CB0Mp8doeBRDm1ZB+wVWcv/9uPhpt+xW6uuZsnig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMpktnw7oCNJk0klvmlV2RQOmhKQ3B4AZgXLwNYeMIg=;
 b=da4ruht2SiodA2obcs0ckhrDSxHWxZ/VEVPum5XNfA3IroVOgNNrAj9NCCX0Kq8yoLdXC6+/y8CHmpIW5LmqVSPcExqLtJ4B36Oxr/kdwBtNYpC82t6xOZ250TvgyEwYxcG2eoPI+wOn1JDx0Iofz6b3UarJjfY4i8eSLDVJLj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM6PR12MB2908.namprd12.prod.outlook.com (2603:10b6:5:185::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 15:03:31 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4930.017; Fri, 28 Jan 2022
 15:03:28 +0000
Message-ID: <0932bbf6-409e-0d3e-2824-b33914033f81@amd.com>
Date:   Fri, 28 Jan 2022 10:03:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RESEND] drm/amd/display: Force link_rate as LINK_RATE_RBR2
 for 2018 15" Apple Retina panels
Content-Language: en-US
To:     Aditya Garg <gargaditya08@live.com>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "evan.quan@amd.com" <evan.quan@amd.com>,
        "stylon.wang@amd.com" <stylon.wang@amd.com>,
        "wesley.chalmers@amd.com" <wesley.chalmers@amd.com>,
        "qingqing.zhuo@amd.com" <qingqing.zhuo@amd.com>,
        "George.Shen@amd.com" <George.Shen@amd.com>,
        "roman.li@amd.com" <roman.li@amd.com>,
        "solomon.chiu@amd.com" <solomon.chiu@amd.com>,
        "Aurabindo.Pillai@amd.com" <Aurabindo.Pillai@amd.com>,
        "wayne.lin@amd.com" <wayne.lin@amd.com>,
        "mikita.lipski@amd.com" <mikita.lipski@amd.com>,
        "Bhawanpreet.Lakha@amd.com" <Bhawanpreet.Lakha@amd.com>,
        "agustin.gutierrez@amd.com" <agustin.gutierrez@amd.com>,
        "pavle.kotarac@amd.com" <pavle.kotarac@amd.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
References: <139A7689-463E-4AD9-A2D1-A9969C3958D0@live.com>
 <CADnq5_OLpgEJjpN5y9b3gNwCmvdfNTA=puUv8UjOCDH96JgvOQ@mail.gmail.com>
 <58B7B0D4-BA3B-43EA-9F54-06CCEB7EF833@live.com>
From:   Harry Wentland <hwentlan@amd.com>
In-Reply-To: <58B7B0D4-BA3B-43EA-9F54-06CCEB7EF833@live.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:208:239::30) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 187ef551-a837-40a2-6117-08d9e26f56a2
X-MS-TrafficTypeDiagnostic: DM6PR12MB2908:EE_
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR12MB2908B4FFF9A2BC1E830755F08C229@DM6PR12MB2908.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 93yzbUPCv14ZT0MXODJ0dzyXMjV8ZcM6t2Nrm+aaesxBX26DqVrUy4nCYHPvBt+VrszW4suNzoO56Xl5UsilT3V5lPdAxCnSEQOiMhEeIFXQ9wQgRqxJmoqKFUnU7aHwdabOu6CLgLrWstI/JxcU9dc8yINsoJqre4z99uKz/hdLHzRYS/kSk1AP20cjDF4jWl0dOhcWd/ak3ArRiF85215qtmGFQ405TxuzUUe/GOCaLNVJCPl+g0busGM9aBTjAre4RyJqLDO0O1FLstUbne2AU1kVFw/3a1mkwcrzVGvqNAfyBX04q+OnMffB9fMNCB7UCoYKDNp/FvmfooXBN8aDK89coO8IuychG9mUSJeBHqL0KBe1N/KqsR9M0D1s2cRFoBMS0c8inWNpFsrvOiEiDJ4O6Rli31Y0oQQ8umewPcfGOFyo3AVqKBqY0SJ5iEP7dxdOR6tcx+6LEr/ToFAn8XnYBCLVq5sLXjCXkE6qrJytet7uoMaukyNnnQGheeTK+wVY5jEuOM6J8lHlh5iw0sTPUADU3oF/KomIb0o/LmDRL7WCIhQ3sjeUQkYwpSdN146Uf/Ydj6ZpQusyLtikNY/gi4V9933mBb+M+Y4mdDJj7kztGEmLxbZ3AZ/wESBLcq0vwfOPT7x7h+GXwVzq+VB4Fci6CFg7NKw+5MapQSIhGApk5bC72jFyiifaaZA5a7mJWNeKmsigyhb3miXsT8SD6nDAenOcacr+CSCcihoaaCbZ2Rjy6lQD5yD7qcE4pULSWMqDEshYWeKUnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(47660400002)(2616005)(54906003)(6512007)(31686004)(36756003)(2906002)(6486002)(110136005)(5660300002)(508600001)(31696002)(38100700002)(26005)(316002)(6666004)(186003)(66476007)(66946007)(66556008)(4326008)(6506007)(8936002)(8676002)(53546011)(46800400005)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVFzNWYveXpVZXBGbzRkL1A4cW5CVndxQVBjMFdBWGFLc29MWG1aNjdKSXZZ?=
 =?utf-8?B?NXhMMlFTTUdvSFJpV0phNXpGbGhLcjI5RmxPRGY4ZXRKbittQ21YcHk5YnZ1?=
 =?utf-8?B?QjdQd2NKUnRGRUR5d0MzMlZnV0RPaWtCZDI3SG9BSFBNNmMreHlBeHM3M1pk?=
 =?utf-8?B?S3RqZmUxbysxOHlUWnVPd0RpdWJ4eVdGaTRmWUE4WU8yQ1ZyMU1nNmxKUUF1?=
 =?utf-8?B?cHhqcGJEakZ5R1M4WkF2S1ZZTGphVXlmQUx6SXlJNVRsclJ2ZTVjSXd6VHFs?=
 =?utf-8?B?azBXYnFGZ0JvdmwvOUxIL1NFRGNDT0FIcjMvbTFvclQycDhnczZSU0VZYUd0?=
 =?utf-8?B?SlIxK0RSZFRtd3EySnlIdUNLSURnNFRHNUZQQmptVmhybnBBWko0MmtxdE9w?=
 =?utf-8?B?OC9iTFNUTSt1RjRVY2c5WnNNWVVvQTUzYWZ6amhqRFEvQ1QwS2tzNTAwV2ZS?=
 =?utf-8?B?T2xXWENsWjY4VTE2ZTd4Z2cwR244Qys4UkZHVStmcHRTZVhJeEk4d1dvZytV?=
 =?utf-8?B?MnVXcnlxRVZCU25YdDlHT09YeW5iMWNLcGRMRWZMTzFsQ01lajB5WU85NlJ4?=
 =?utf-8?B?Mmt5aFdwT01wUWRsbkFVeHZmQmFZalN4YytMMVZZd0V1OHVNVHUwbkQrZlNG?=
 =?utf-8?B?ekxXajVNaElZVzMyYUVFMDZvSnBmR2swZ1JmejhYV3ZBcDNYZUdNVTBwZUxt?=
 =?utf-8?B?UVgwcDM4YisrN2hlRnhoVlJNOTNHOEY4T3lLQ0VGdC82RWlYcWp1cU1Sbm5X?=
 =?utf-8?B?SDF5Q2J3NGs0VUpQcDgvbThxVkorNzlKWUN6UVhETlZ6ekhNNWQzY1Q2eEdO?=
 =?utf-8?B?NWZsMDhtY3ZmNmR0TkpFY09sNmVVazczdzdQQVVwWWZmcmJFWC9uK1VIZmtK?=
 =?utf-8?B?Y1V5Z1N3aWE4Nnd1K0RFdmltUHRYRkhGOTZZSDR0ZUxBTkIvV09xaDdwRjZX?=
 =?utf-8?B?Uk1oSGpCT2c3aHRvMzFmUjhKR09hTDZTS29ZZnNGOXhjd3ZFZ2xuRmFoWndW?=
 =?utf-8?B?YlBPTDE5b2Z4dW1uMzYycW1xUzBZNjRrSkFMT1ZOcEdiYk5NWHZCSXY1SHhp?=
 =?utf-8?B?SVBhZzZORDlYM0dYdHNVYko4UkF0VFc0NUZvYUErUXdRdGxnQWhSM2pLaHdW?=
 =?utf-8?B?UXk1LzlGNUt4RHZsT0FEVjZzTGJwcXk4VEhhRlZUYjhDUHo4bExOd0VhQUtj?=
 =?utf-8?B?cEltMGNiT3FCVXIxMXRPZHVKRDJzc0Z1akc0d1RJSDRPd3RpNm1MS2VKa1FR?=
 =?utf-8?B?bVpRZm5ybUh4MXlhdGd6dm5ibm45eDlMMXVESGZJRjVsZUcxL3JwdUY1U2xx?=
 =?utf-8?B?cmJac3BqZldMMEJiMC9tMGlkTmZkMmV2QmdUK3VtMGlCdHNoUS9NRGxRQmh1?=
 =?utf-8?B?S0NHME1HaWY1QVdYaEtYODdVZHJWNVF0blFUb0Zud3V3NjlXVmxpM3hZckI2?=
 =?utf-8?B?WXBDK2FYRHlGOTZpM2RMc3NiZmFrbUhKR2tVdnNVdDlKalpGbUxEeXlSM1F0?=
 =?utf-8?B?UG9WbEsvNWFwK0Z5TGtVNm1MRElobEdacUNmMjNNZE1Nc1NHdTlPcHlaakNt?=
 =?utf-8?B?cG5sbGRUSis4U2xiZFlXSXFvL3JxMVBGNGRxRzRGRUQyRHZJcytKNXhHd1Fa?=
 =?utf-8?B?eUlkT1ZOSXhiS21FNDVxUngwMWwrZ1gyZE1iUk4yYXdSVVVkdkhxRU1iejhh?=
 =?utf-8?B?c1MxYmpjTndpTG0rNFUrSDlzNzhEaWplNy94eHBzSnFrS1RJTGdscFRkaUlj?=
 =?utf-8?B?YkdmTXRoV1pzV21PbTc4YnJCZi9tWXVlSm1EeDBpcWw0cEJmTlFVNEI3VnQ1?=
 =?utf-8?B?VmJhSkRNNHd3WFpGajRBRzRDYW1tUUhxbFhIZ3g5b295YVoyMjUwQndtZ1NR?=
 =?utf-8?B?VzQ1aVJpb0xSQVVpRXlSOGJPaWhUY3dtVm9ZRnZ3Z3RCUTFpZ2pQR3pNVkFo?=
 =?utf-8?B?eTh0WFdqNEhkb0JnRi9KR2hVYXlkNnUza2JFUW80NVFXWjRkaWxpZUdXMldN?=
 =?utf-8?B?a0t0aVI3Mk5pM0FFeEZ6a3h1b09EUzNSeU5iRmttSlc2OG5XaTdYcjVNLy9i?=
 =?utf-8?B?elZZVFVQamFHY0xidnh1WThMV2J1OHhuRG1sd2FzdllHU0hROTVBdklwLzhV?=
 =?utf-8?B?ZmdzYTZSbllUYkU1aUNNVFd5bmE4eWNtNTl1SkFBVUE5bHJNQTljVzhabkhZ?=
 =?utf-8?Q?y2hLZ+pqz4pjNZj48/hZFPc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187ef551-a837-40a2-6117-08d9e26f56a2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 15:03:28.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2OpNeA9HHP04ZFyGqW3qlaaCoJXHBVJjaSS4aJxaxW3JrgMJTqCOfwfQiEe4/hk8UtzmjvCLpIavmaL6BD46A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2908
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/22 08:06, Aditya Garg wrote:
> 
> Hi Alex
> 
>> On 27-Jan-2022, at 11:06 PM, Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> C style comments please.
> Shall be fixed in v2
>>   I'll let one of the display guys comment on
>> the rest of the patch.  Seems reasonable, we have a similar quirk for
>> the Apple MBP 2017 15" Retina panel later in this function.  Could you
>> move this next to the other quirk?
> I guess moving it next to the other quirk may break the functionality of this quirk, cause the MBP 2018 one involves stuff regarding firmware revision as well. The original patch applies the quirk after the following lines of the code :-
> 
> 	
> 	core_link_read_dpcd(
> 		link,
> 		DP_SINK_HW_REVISION_START,
> 		(uint8_t *)&dp_hw_fw_revision,
> 		sizeof(dp_hw_fw_revision));
> 
> 	link->dpcd_caps.sink_hw_revision =
> 		dp_hw_fw_revision.ieee_hw_rev;
> 
> 	memmove(
> 		link->dpcd_caps.sink_fw_revision,
> 		dp_hw_fw_revision.ieee_fw_rev,
> 		sizeof(dp_hw_fw_revision.ieee_fw_rev));
> 
> Which seem to related to the firmware stuff. Moving it along with the 2017 quirk doesn't sound right to me, as this shall move the quirk BEFORE these lines of code instead. Maybe the author also knowingly added the quirk after these lines of code?
> 
> As a workaround, could we move the 2017 quirk later, instead of moving the 2018 quirk before? This sounds more logical to me.
> 

I think either leaving the 2017 quirk in its original place or moving it 
down works. I don't have a strong preference.

With the comment style addressed this patch is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Regards
> Aditya
