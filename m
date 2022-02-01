Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519314A63E4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiBASc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:32:27 -0500
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:16480
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238397AbiBAScZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:32:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkFFyqt+MPCgls11axg4Wc0cmSMN6J5JHHLQ9lOt7oZP/BP9FhrE523pZGxGF+x05+QG8qU2CnkAW+Amvtnha3mYSTK8oselLZMoaJr+IaGF0n8/Rdf7nHC06pK+DQTW47eiynrvIbCyZSc7rfrj12vxbJyBRw46bQVcDtpQ7Ow71vDKC9XpPE69GrN0ziyWb5WWZuAxx86QGXugtk/y77OKDj4WMx6uoDRQeKose06949akOQpVtipYIEzhCQ6EM60QjA1DlZ3ZdL+tNsH+E4kb3KEXjRGgESSxx8Vs4n/77uKLqxiSVc8Sta/PdNQoOXwfkIrtP5Bv3/iIg5lp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDprhl4Vj248zwEConocOvkLZ8MBBm33kfHkVewxiuI=;
 b=AuGGTeVLzHKPs1CMQ0IjTTYUb6B2KkCq8STuOSMtjEl3iHwvPfKN3ubCkHdxj3Eg/h58n3rsC7hnNdC1qC3zs7dgfl/0siYUnlvBbkiMXejuPUKIbZ7FL7GJT18MUfqgckywtUgkCMvVksp7NRBAl4PvcG7nidQM/DwIdHVBzt5awd62EkcsNpIylkPMERDWgLcdddXIoeK3db+APNuR4ksWDNbZ+BvOZjTJa6mMcsxtaeUf8TDw5t5ItyZkQMoCrXPuDAC5Sgd2lndZ+p4vD4Gmismks/wz4h24XfbixLjnDvCWCWvwmQk906xneSzjLt+peSpCumXiWP3RGftI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDprhl4Vj248zwEConocOvkLZ8MBBm33kfHkVewxiuI=;
 b=TmAnBkuzGjSYh8BhRTyyXeqyqmFcXC0GgNCcm2I7XySFx8d1lL+Kxac3ac18c67obFuXMofO0QR/zoRs9mp7/UXGl2RHZ2+Gl7HtfNWMK4FcI7QdlinQq91EnxQTI5BT+9f48lOBbn9drcFdK+P5cp3J0rR7sN8BZellRaBkzQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CY4PR1201MB0071.namprd12.prod.outlook.com (2603:10b6:910:1f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 1 Feb
 2022 18:32:23 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 18:32:23 +0000
Message-ID: <b679648e-929c-9885-9690-70f8918bfa05@amd.com>
Date:   Tue, 1 Feb 2022 12:32:21 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220201143201.1883c3aa@canb.auug.org.au>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220201143201.1883c3aa@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:610:52::31) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86937714-0c46-45d2-fa0d-08d9e5b1306d
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0071:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00711476CF4C8342BF9442BDE2269@CY4PR1201MB0071.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ezubzxs+ZfU8uWtms8/qLvpBnkcRFLr32S8UcDAek0t89kToK38PkxRK+XG8qUJVavL4vA/je0bkxxgbbmfxVxWZ6EM8NQZDBUGvivOZkbCsjmJ53EJXUXZVJ1EdSQBYVDW4sMv8b/12iMvkOKEbUhqaUbtLr7u+8dxyRFlIOQw3xjNZgSfnBX1R2sFg5gpWGJiy12wQBNgE2+d0cpOLUlQYl5OWjFQfx605O/n2VD344BlVI0NCOUQjCC3B8BcSA2vSz9Dkce9ETKBxbWXryojC6hNy6BZudn3aJ78QxJfJ/JGi4Ebwr5JczxH/wMj9MhlkKMa17GNdoI+XxbiZfHn1WmwYAZOik4zyc7mNM1eeab5FA2pcDa3sWNeEDTzY8PbjR7Xxtdcs8bGMIkI+kJFxLhPF5PrcVsSNh0w+7Sy94UwWJa87vto3Ud4lofhdu8G6/jnZMDh66dQOKCNi+HtKHDVBkUIpz6q8ovh5FYGgK8LGDPJV/kx4Odm7mlaVZqQVXWoVyZD6ft8x9INQuN45maWad7CbpEWJMUgNLyc+RoxuBKmRYhad7PMYI5v/Ga/cXn44ntU40VZb+FSpYGWjwQCWPMxxK4J4+hTvAm0lK9K+M6fDhJykxbZipsBCfyhgMG+b4Dq4/hc8vnM7/J62I97nXL8Zim6ZknmzIY659mZUWtFrNPokeP3fPkSfDV6PJaucGHRM0+4Vrm1SJ43styw5PyYCXTUOT1kkJX3qtFnaerGWN0InOZg99Qge
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(31686004)(83380400001)(316002)(36756003)(110136005)(26005)(186003)(54906003)(38100700002)(8936002)(66946007)(6512007)(2906002)(66476007)(31696002)(2616005)(5660300002)(66556008)(4326008)(8676002)(508600001)(6506007)(53546011)(86362001)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXhZSHNpMnpyOWxZMkFDQ2JKbkNLVy9zTDlLUDJIZVhIVmdBWVRDQlZlcksx?=
 =?utf-8?B?dDJQaWtrMENqL3RPSTc2UXMzQ3dxOVIwSGk0bW5TczBDSzgySE5pYXk5ZnJk?=
 =?utf-8?B?UExSMkpLU2ZydXRVS1ZYU0dncW94RGllak1jSFBDcFJjVGRQSzcybHFuV3lO?=
 =?utf-8?B?UE1sUTdmYkZKTE5VZjNSdndqV3hneGF1V2RwM2lJaUE1M3B2SmhlWDlMOUhC?=
 =?utf-8?B?VjNFTzNuMnNsSkxZYW83dkRsRi9QaGlPNWtWSCsyMjN4V2tjNEgxTUtqd2U4?=
 =?utf-8?B?UmdLVHROUnU1SnU5aUtISmpNVVRyTit1dHk5YW94SHRWQTB1aE1BQ0J3ZEJZ?=
 =?utf-8?B?VmVWVm8zaGk2QWF5QlN1K3RnVUpvZ0RyNEFBWTJiOVZLNUF6eEtwN0Q0VFBj?=
 =?utf-8?B?MXlxbDBBVmhxeFJsdjZZY0RMMGt0ckJWVS9OcUNBU2JDUGMyeWtkN0NXQ3Uv?=
 =?utf-8?B?VVFiV290ZFlnbXdaYmZiR1drZ3U4cmUwNFRFdTVmaFVpbGJNTXdnbUUrdkFO?=
 =?utf-8?B?RlpLN3F2aTdHamQ1K1ZOYWFsOUxzSHA5TGlya3BEaW0rTlZFT1FKL2dUQ2VO?=
 =?utf-8?B?cCtUU0I0VGMvdzhDK2lQQlR3UlUvZURvanZwN1MvR2x4dlFvV3R5Y3FCU09K?=
 =?utf-8?B?QTNnVktGZ3FsK1JqaGcyVnhDOVhZU3ZGK25Vem44djQrSWpaYzAxRmdmSXQw?=
 =?utf-8?B?bUlqUkw0QitxSE1HejgwenljNDI5QXVEM2xkSGZpcWtwNzlFN1VHV0p1aHNF?=
 =?utf-8?B?aHJ0c005NHczVVQ2ZGJIQXVPOHBkY2UybVAwR1RVSTNFNU9sMlB3Y0xhcUdT?=
 =?utf-8?B?eUFaQko5UmdwWXVWQk9aQUNJRk1xQVA1dUN6dWdRYnkzY0Jqbm9MbG4yYTVO?=
 =?utf-8?B?ZFFlN2VYbHk0SWVndXhxZExqUWpMZDZzTit5czE0b3Z1SHFJOE1ya1lvcGlp?=
 =?utf-8?B?WnFqRC93SjlLclpWcmM0TmZncUFlUUlKVG5vbEduV0lUU05XeDNsUkZuSjBI?=
 =?utf-8?B?ZW9sR2pWSGpSWnkwbEplM0FTQmxoUGtWVU91K054SmZ2WFNISldIdGROV1M4?=
 =?utf-8?B?K2RtWDVNQ0xSNDNxaWlaVS8xYk5QNVdFUnFyOXMyWURIRnh4QXdpSHVRakJn?=
 =?utf-8?B?NHp1OTlVc0VpWExXVzEzU0pjdEpHQ0dCeTk2RFVZWm0rVmU2QjZDSG43OXpK?=
 =?utf-8?B?NnM1ZUJFV2dUakV5QkRxejdxOEl4dklCYTBNS2lTdS9OTVo5TG1reEkwUnhl?=
 =?utf-8?B?T0hZMWNsZGlSekZSeVErZ0MwaEtyalE0V091azdvUERuOWV4ZTd2M3h1T2FY?=
 =?utf-8?B?cktYdEdZZjhIVC9QWSs0Qzd4a1ZyUU1sSlBYZytVbW82bnRzT3ltY25qUnpT?=
 =?utf-8?B?Wi8vSHJjbmw2akRFNnJ3MHJRK1VaTEJoaGd4bVRxYXNoS1NmeXk5S3FKd2ZQ?=
 =?utf-8?B?aE52Q215SHdpdDB3eEp6YmZvR3AyM1oya3FTR2UxbUNFODRyM3ViN0ZEK05R?=
 =?utf-8?B?aUlJY3hYOEZGNC9ZNmZpeDhIakRRakR5em5SNEFhVVlDSUVPVHdpRnk0NDlX?=
 =?utf-8?B?d050UDlSdVpFNUVTMlR0TWovaTFtUUw1bUp1dzZ6emtXMk5MRzFVTWNWSi9O?=
 =?utf-8?B?ZnlEVHc4cDVkNFI5RmE1MWo2Y3laM0tWZUY1dHhRS3Y1SWM1eENzbTJMa25G?=
 =?utf-8?B?UEljZnlxc3VFMHBFbWUySGNBaTA1RDZQK2hNeHRlOGIxTDhKTTlGV2hSbkor?=
 =?utf-8?B?QTIvYlZTaXIxaEpLV3dIWjlRenhvWnlCRS96MldSaDB4ZzIycW5yOHBSdGR5?=
 =?utf-8?B?aGRFRzJ1UnViRGE2Lzd3a1cxcEFBTUZsZk5mamFOUHFTNGNEK2xZRDE2OVp1?=
 =?utf-8?B?TGtsRUFzQ2FtdHpsd0tDV0lKN1F4VS85NmRLZndjWHo5YS91bXNmZHR1QkZK?=
 =?utf-8?B?YlQ5TDBYVlNHcE56YUNhdU9sYVJ5NythTzhxdW1tZUZKUlRGeldCcVJaa0Mv?=
 =?utf-8?B?dXVuV1c4WHZpRnFnK1crckZnRlVkYmpUdXMrbGxzYllPdFRKbG9rTktrNnVu?=
 =?utf-8?B?ZldZZ0c0Vkw4cWpSM1FkWTZ5SFdUYnUvWTNRQW1zOWV2eWQrdE9ZTFY4d0oy?=
 =?utf-8?B?TVMrVW45THhJcSt4SDU2c0t0N2pVSW1XekthOWhMWkNNN3UxUWpLZSt5M25q?=
 =?utf-8?Q?xQ5YizmmsmLyzP7/IU7oMGY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86937714-0c46-45d2-fa0d-08d9e5b1306d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 18:32:23.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1zz8hK8sbJiD9fuX/EOcS4Xu/BZD8VihAf1Yr3kRnwEqFOyPz7AA4Mm/bm4TWwSFhcXC4MygMg9DxvctBr82Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the fix.

Alex if no concerns I'll push this patch from Stephen to 
amd-staging-drm-next with my tag.

On 1/31/2022 21:32, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the amdgpu tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:43:
> drivers/gpu/drm/amd/amdgpu/amdgpu.h: In function 'amdgpu_acpi_is_s3_active':
> drivers/gpu/drm/amd/amdgpu/amdgpu.h:1428:87: error: expected ';' before '}' token
>   1428 | static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
>        |                                                                                       ^~
>        |                                                                                       ;
> 
> (and many more)
> 
> Caused by commit
> 
>    11bc42ea179d ("drm/amd: add support to check whether the system is set to s3")
> 
> I have applied the following patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 1 Feb 2022 14:24:40 +1100
> Subject: [PATCH] drm/amd: fix semicolon positioning
> 
> Fixes: 11bc42ea179d ("drm/amd: add support to check whether the system is set to s3")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index e61078cec072..2931c8ff4cc6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1425,7 +1425,7 @@ bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
>   bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
>   #else
>   static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
> -static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
> +static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
>   #endif
>   
>   int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,

