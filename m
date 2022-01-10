Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3581548A1CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343811AbiAJVWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:22:44 -0500
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com ([40.107.236.71]:27969
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241222AbiAJVWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:22:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOj4MK0p7vagkh81LeeWzoeIX4HaEuN1sMymwft3pxwvb5QCpz4bokz161Yr5rx6LVSGqcBi0gwGkDUxmK3EwU1pieRnUIE7nkjTaXSCWbiBoT3rJLloTc0y7rbQJ2sdv6fiJzYcg81sj69dj0nWwGt7DXyZtI8ZvRbvQY3lbu+KFiiJ2adjiDlwohFzVS5yxFCU+oyvf7XUjy77+aM/TvHOt3L7JzzZbOQQQTpdLxa1oNS6Uld2iGsN8WPlJMgzov2F5UV+7JX6575jZob0m89wdIVtXfHupA8qu0LVzEBvTT+XiPJwYpLigiYIA/N2recf50OtDMGWOqiP1q5l9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOBwfmBTFq4vvlj60TLv6rmmuWG+CtFU9e5H6Wrhar4=;
 b=WBeWu8ND4nIXQjgBCesZnVMjsPJTumKv+OdvdVlZhLYkdWUB3Lhx8cTYAC+leS1GxRtTgFgWzvSbckfuUFWbl001EpMG9Ekawfc9emv67/AhkcDs0KuBFQ1VQkbFe91yBR5XrwSuGFkk8FYAM3jVOGydV6RXJrQ9CTwo+jQ5i1c/JXUC0YFNi1kv2WK4m5Y/T20IoQQIdxiPP3N2i+1Dvlo4ScOyqTciwyzACfsaJ2ZFA9BWXpZQ8SGZAmcTbslPJSy8K7+X2Js0fXk7wZBcJFkejqpR67wECePwQdwEvE/VCp86bEKCvL0iEemTE0xe3iXqmZVWEX5o9eosSEwV+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOBwfmBTFq4vvlj60TLv6rmmuWG+CtFU9e5H6Wrhar4=;
 b=Y/Y5purP/D1OvmWiO3NIAzjMZu0lXX4CNFz6pJZBRW9lbOqnHrvRHNFrbJ0w3FAnYhEM6OxX/hsRDYu0cZGWylf5EfEulREagtRxfj2/c2uhoJvHj9cqCGXD1qed+QUVZnBUvRIJLpLYrqPrRj7kaSMgYdVd9+F8Cia+fWZ6Orc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5260.namprd12.prod.outlook.com (2603:10b6:408:101::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 21:22:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 21:22:41 +0000
Subject: Re: [PATCH] drm/amdkfd: make SPDX License expression more sound
From:   Felix Kuehling <felix.kuehling@amd.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
References: <20211216094503.10597-1-lukas.bulwahn@gmail.com>
 <642a6389-b8bf-7607-c65a-52d506c240f9@amd.com>
Organization: AMD Inc.
Message-ID: <0058a913-f308-7c29-5d8c-8f8f1186974a@amd.com>
Date:   Mon, 10 Jan 2022 16:22:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <642a6389-b8bf-7607-c65a-52d506c240f9@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BL0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:208:2d::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad773bdd-6b4b-4f7c-4173-08d9d47f55a2
X-MS-TrafficTypeDiagnostic: BN9PR12MB5260:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB52603BA36ECF0C2348D838D992509@BN9PR12MB5260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zeTbIt4/Z9jdz7VJVorNhGs5MrYdrbwQy1ZEQ0oneUw49KPcfp7gxfu/B7KdObx2LX5GxI07NF6YMedvSwtGOGZBTM+xyvGPq/BXgzzY1OPM9jGF2M1z+oEWFhdOJvcDn8iFO2QtKBe7Im330LGJ0OYOUo2z52t6WB31iBQBljT0/IM2qy0HdM3p/IjNeulrJrHuTi5tOhUEVZBSo8UrFDHFudTzzC9sLoP9tGv6cID1W0mps+1xoDXsCJBSEO2wqlWYGVx4TDKKYpnbyWgUE+xNA8RZmlB1THViKIkGYXFRZPdeHXtrKjHBU5Km5h1amvmHJLeLFpGrafACEBKG7ZUo1FS8LkzQrfhNgm3kgXAH6WJ1a9vECtsEZDQ0CD2X5iIVQi4b/oSTvTSgKGciggMZlcJ/0tq57QgldQnNoysR9XFkp5kARDpBOAqQtc1iS8jzKc3/WQbAkKgS52PcPJcn+HRn1nE+XgZUD4lw78GZoglry+y4GkAwKzMkVhv2eDJflQECMBdmtXzWBy3DAyzGZGhlHrGFW67MGdYPGwGKB2SU305ZdpK82au/9EY5cl+Z5JIfxUzYAhglXzSoUkCJ/0oKmZ8L4r9/S9fi6mlXkF2Q8Og4Jdwuxn7dhPhrfP/5GeDwRjau+c1GqMTMZFW+EpBFzZV3HesJSy0DiLTxZumgwPW7YD2P2Ef/LMC4Z4jX1bURbumn0f7YZDTT0+dHF3on0YcDpr2FHa+5hBUhFhI/qO/6Wmx1K9JgONP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(36756003)(4001150100001)(36916002)(31696002)(31686004)(2906002)(86362001)(66946007)(8936002)(66556008)(66476007)(4326008)(2616005)(44832011)(6486002)(53546011)(26005)(110136005)(6512007)(316002)(186003)(5660300002)(54906003)(6506007)(38100700002)(83380400001)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHkxRmFmRmxkQmUydWx0cjdUMUdmb1Z4d1JLdk1QYUFXcmdYbzJxWTUybmQ4?=
 =?utf-8?B?N2E3VkhhMERpeGpIQ3AzZ2xEU2hTRG1zRllrWUI2ZWYvL0hjQTF1ZWgzUXpy?=
 =?utf-8?B?dWJtdk8xeEhkanFqV0tOd0NGVDlPRGhodlBybTk2MllhVHlTQUl4ODQ5OSs1?=
 =?utf-8?B?R050Q1BVcmkvME1aaVBVMVQ1ZG95NmRjWUVkb1NvS214KzU2ZHY1MFA0eWhr?=
 =?utf-8?B?dTFwZXFJZndTNDdmS0RxT1VtbVY1em1FUnRnZ1hZTG55VVpGMTAvL05aYXFj?=
 =?utf-8?B?VE5BZVNzOE0wTE5pSElvWWRKUERVeGp1OS9zSjF5OXBzaFFMZ3AyRWhwL3dn?=
 =?utf-8?B?WDE0d1c0NktkVUE4U3Y0N20zd0VJbnBCSWRzNVUrdlBIWXFSS0pTVXFKa0Jl?=
 =?utf-8?B?YVhPNUFOa2hJdlRvTE1qQTI3U3F5SU5Xa2g4T0VqTFJYOWJua2ZsZ21IdlF5?=
 =?utf-8?B?MDJUY0tiWkNCRWROMWRGOWFKLzYrWjhxYlhXdG1SY0lraENvWTFuclZaaUpV?=
 =?utf-8?B?LzJlUG1DMy9IK1JpS24rbm42THcvcnlhWE9WMmhXZW9qY3BtOElWaHRoZDdq?=
 =?utf-8?B?RlV6THkzeVpHRTZBZmJyMzRCRWVGaktIVzYrRHVhTnhPTzZNdnk3aTdrQlZF?=
 =?utf-8?B?eHA2eU5neWFtcnZRQkJjOHcrOXhFamxzSGYyNkZmcm9COFJQL0dxcVZPKzRz?=
 =?utf-8?B?YnJoVStCaEdCc21nZUk4cVV6bnJaNzN4WHAxQlhmZllYV2ZaMWVma0orQjJY?=
 =?utf-8?B?UnhJY0U5Z1A0UG1CK3FlM3RLQmxiS281Q1RHaUJ1VUdNTUszUlVnTWs4STc3?=
 =?utf-8?B?TGFTZEZpSHI4dWowZlE0L3cxSjcwQ3JjdkEzVTNTcC9UOVJPUURTZjU5cDF5?=
 =?utf-8?B?cWlUZHpzNTdaSDNyM0FOWmNEMnFqSUJ0b2lxVWY4ZXlOZUFXK1hhZ1FzTTBv?=
 =?utf-8?B?RTdsSnJlRWhja2RSczFSQTFtZHdrU1VkQ1o3QjdSMXZkRmhraWdoWExlUUJR?=
 =?utf-8?B?Vk84UGhVcmNOMzc1RU5UYmNNbEk1Vnc1Y3RqWkpVamV3RTZMOVIrNURQcEYr?=
 =?utf-8?B?VlhjRWF0Y2QrQkI1eDkvZmNpRHh6QUlyeU9tUWFYdTBCV0JqZ1RnQ1pYemFH?=
 =?utf-8?B?N3JpL2h2SEk3ZjJWSU5PVXV6ekdRUlB3aEdaRE9ibVpoNHpJZWxaakpiYkEv?=
 =?utf-8?B?dFVmbTV1WVdCTlFWWXF4RjRPejZ1NUlVSUMzR2tkYWxEYS9YVitZcUFvVnBC?=
 =?utf-8?B?MGYwWkhaZEwzMHR4R3FCa3RGR1J4ZGN0clVjVXhJbHZjWHpkYzdSc0MvY0Uw?=
 =?utf-8?B?NXZVYktwZndtaW95eFNjZmdSM2dKRXFYOTEvbnpLdnQyem1WdCs5N2wzaXd1?=
 =?utf-8?B?S0RYcGd2cEJlVnh2bU9EemJwUEpISGhyU2tWdXllaFFUQmRQakpoMkc3UmV0?=
 =?utf-8?B?MnpaV1pmWk0vVnM0RzRkU3BVMHVDZkxXRURxeERZNkU5amlTV29sY3BQbFk1?=
 =?utf-8?B?T2ErZ2owQWpUMWk3eUNJNmFwZ256WWFGSjFPU0drU2c4MWlrV3ZubzVSLzhD?=
 =?utf-8?B?cy94SkZ5K3ZKNXB5aCtFdnFtS1FJcmZ1cTBSeUlYNWdXSm0vcjd4MGx0OWJj?=
 =?utf-8?B?T3gvVDZzdHh6V2tPb3RHdjAva1Mwd0lucWtRM0Z3OStrR1IrN3dtbld1ay8y?=
 =?utf-8?B?MjlpU0lNdk03VlBQRUFHMkpnczNWdGx1NnAzS1h0eVJ5RVR5WXR1UjFDZ2hr?=
 =?utf-8?B?cHBGMWdndXcyT0l1amU5dHc2SVJaZGJ2SW5pUG45bE96RVVHc1I3WithYWJB?=
 =?utf-8?B?clZsNzVGR2NLYVU2aks2aWdseUlLVzBicUh5MytpeW5meWFTK2F5V3YrUFox?=
 =?utf-8?B?ako2cjhKRzhzeVM5QmpzNEVGS21PbEh0UTA1dk1rbllLbExiS3FhSng2eUdK?=
 =?utf-8?B?NHR0di8zUW9zU3Y5aWdYR3JHdWFlcGd0Ui9ERGZEWFNxaVFqM2MwdS9kQW9H?=
 =?utf-8?B?ZCtvTXd0amZlR1NvVFAzd1llazYwbE5iSzhGdGs4VlpUdkZFck5FMzQycWZT?=
 =?utf-8?B?QVhMdUlJeGhxMTFDK0ZoK29EdXQybDdseHhQN1V4bzRDS2tFRlRpdWx6VlJO?=
 =?utf-8?B?NTJ4cEl6cEZITmtBSTY4UmZrR0tyc3BIU0hwS0RnZzJ2YitqZXlMSHdaZjAw?=
 =?utf-8?Q?K+HAR0Qb3bXun7I1RC1I6sc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad773bdd-6b4b-4f7c-4173-08d9d47f55a2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 21:22:41.5404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPFAdh8OSM/Epiwf/Gw4R0JuB25TjIkkK/+PIpgn8z55aXScfDydWVDSTgnzcmfkyJHby4TIiLakvRiWGht/pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5260
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022-01-05 2:27 p.m., Felix Kuehling wrote:
> Am 2021-12-16 um 4:45 a.m. schrieb Lukas Bulwahn:
>> Commit b5f57384805a ("drm/amdkfd: Add sysfs bitfields and enums to uAPI")
>> adds include/uapi/linux/kfd_sysfs.h with the "GPL-2.0 OR MIT WITH
>> Linux-syscall-note" SPDX-License expression.
>>
>> The command ./scripts/spdxcheck.py warns:
>>
>>    include/uapi/linux/kfd_sysfs.h: 1:48 Exception not valid for license MIT: Linux-syscall-note
>>
>> For a uapi header, the file under GPLv2 License must be combined with the
>> Linux-syscall-note, but combining the MIT License with the
>> Linux-syscall-note makes no sense, as the note provides an exception for
>> GPL-licensed code, not for permissively licensed code.
>>
>> So, reorganize the SPDX expression to only combine the note with the GPL
>> License condition. This makes spdxcheck happy again.
>>
>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

I applied the patch to amd-staging-drm-next.

Regards,
   Felix


>
>
>> ---
>> I am not a lawyer and I do not intend to modify the actual licensing of
>> this header file. So, I really would like to have an Ack from some AMD
>> developer here.
>>
>> Maybe also a lawyer on the linux-spdx list can check my reasoning on the
>> licensing with the exception note?
>>
>>   include/uapi/linux/kfd_sysfs.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysfs.h
>> index e1fb78b4bf09..3e330f368917 100644
>> --- a/include/uapi/linux/kfd_sysfs.h
>> +++ b/include/uapi/linux/kfd_sysfs.h
>> @@ -1,4 +1,4 @@
>> -/* SPDX-License-Identifier: GPL-2.0 OR MIT WITH Linux-syscall-note */
>> +/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
>>   /*
>>    * Copyright 2021 Advanced Micro Devices, Inc.
>>    *
