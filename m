Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19578485928
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 20:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243514AbiAET1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 14:27:53 -0500
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com ([40.107.93.64]:45121
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243475AbiAET1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:27:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKtJLQvA4DWlvRkTQINco5sxg6k5Kw+HHKowQTfRM/R8juV1RBS9xFtpAhUjcgWRbowFN6+52zZWSs/DkD6MAkTrRnRFeLjsLHn6Xz3MYSp6ihu2lwtPcmi7tslaJUkOjklumoH4KYmx17km6N0OunByvfaLYMTiaBLoKgYPILfSGBkrR4G95sbc96hPyhMV7ebh2FF5hg5jaizdiGLwvZioeqaD9Y5+BmxYC/ulaokYccRrzEltes07N58JeYC/mySKRq6AB0m51y6UoXs3m3Lw/gKSAdBmqAwSfXWEZEueVyP4RdDAfcSyovhWJ/mQmtZ20bKkDe/wobs0Sc2Aow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+jkJApFW4WST1wdSww6ZGhiWtZrZIVTZkgm5L2o6C0=;
 b=QlZEzIsGg2smiDNlQKH7w68rj7j+yJYcXkUubI++T35p+RDrn7c/oCwv67v8xmE4t2PM3vmmmHBy/eB8818CHo+OR0B9hN6006U2goc4PuyURrivGa+Pg0a02AixG3UqRGueG4Mig4nBqQIkCt2FaFfjQOFHU+72JqpcuWiATWqm/86D4fBpuQq8mTO6+PeTTFvTm9zu7LAz8OjzsVyexI1UktpOnvlRlcxzP3phpCO/BTnT2l+JD7uWCRTLVmhRXI+8XdvbYJyMa8E6ALvrZkGYF3Ys6iLSDeoXVeLtGlSXeHpiTDAepeEG5AmK+J88ZldlUTRgvWCuuSoVzdVc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+jkJApFW4WST1wdSww6ZGhiWtZrZIVTZkgm5L2o6C0=;
 b=mjofywzG3A6qyJHFkjoS2DIT0p8NS/dA8k7IUwuM1FtiUP/t9TKOyrajAb6TjOX4Gwcmh6fZ9VewAXVnzgYNlaEG8qeeUbfj8ngFTwd6KK8T2yI3qoBmrCi2EfhytlE4S8Z22+HKfa4mZDDpmGhoPHfUGamy+PV0QCaCzKOeNyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 19:27:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 19:27:47 +0000
Subject: Re: [PATCH] drm/amdkfd: make SPDX License expression more sound
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211216094503.10597-1-lukas.bulwahn@gmail.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <642a6389-b8bf-7607-c65a-52d506c240f9@amd.com>
Date:   Wed, 5 Jan 2022 14:27:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211216094503.10597-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::35) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c6b9420-3094-4cc9-75a1-08d9d081747f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5049:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB504963E89756561B67F1B203924B9@BN9PR12MB5049.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g2mTVZEoA+na4hVA0KZ9omkBmJVRvqdWXlFQRr8uJASjph8qs7xeIpm+zS1VwNGG8zZI6+IvLMxy1s4OwuFpqvi7hitGv92DvtX08DRnEEUVJWpn3szTo2OdlzWeSfPWZ5oXSQVRT6x3SYeTGX3JdNnGcdqKXIPo4BHT7FXEgI4GA12YK3DEK0Iol+QONwoa+BUQTAAL66wRPuBRYAU8eXUDzsMBR5HLsRQyY+Y9J6s/r9uLw98O8VsBmQoCJvoQOwaWN7VxpilNSpcfXzho0gYyAC3QQs4kBwUM45pQ+KmXDZDY5qBbdKi5+/iObKZGC6ovA/xsw78otScFMU0lhRscVIPQkf9M1r/g8zaF+sAMqyRT26FICSn0lhsJgefEFmn7IeH5d5UfKmDIAd3gGKG1qfVTHXdJMlqvXFZ5Eh7Qoh6tsBw2ok3yuCpmrF9FMG74NHGfUkB/pb/5zJpJv02Dkj1/5AKm1iFAqVM6q6kWlt63HjV4s6oXRK91ntTeZ/JrddVPsU4gaF9iPez3H2Or0eZEdI09VZQm215JKPXgEwE6DezpNnpAt/l+FeyBXRNH2qSEOStKns5yWZC0YGEhuu168JmP2SQ7cTxfYUBRKVgt4pIKQ7H77yPtpOMnP3Ijw7T40E82vb6mcSxug3ZtLlYM95AAlvWTj0I2i2g3zJHHI77NE6Gev1J5ZR+GdxQx7Jr9PZBTaNjhNDAVrbWyh3Jf0hFJquYsGUxZ8Kgd0flY/HsgRey8mtH5D9v/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(86362001)(31696002)(4001150100001)(6506007)(8936002)(6512007)(316002)(4326008)(26005)(508600001)(66946007)(66556008)(66476007)(38100700002)(110136005)(186003)(2906002)(6486002)(83380400001)(8676002)(5660300002)(44832011)(2616005)(54906003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnV3NGZiM1NGcmxPd2Z2eXdmSHpIUWVidFIwVHoxOUFzWnlkRGV2dkYvKzRE?=
 =?utf-8?B?eVVVMjl1NVdxRGFjM0IwNkdTRldUUGVNM2RNSU5BNG15cXB2YXNGcnhWemND?=
 =?utf-8?B?UitvdzF2M29XeHpmdlM2MVBqUlZJRklMQ3NlOTRPME5JaTlVRlJGWHNkcVo3?=
 =?utf-8?B?QWltanBDekl6VlIxbzZXaUpPODh4aGNXdTBpckVhdTZSWTdUdnhQTEk5eko1?=
 =?utf-8?B?K0dtK1BhT1VoYmd6MzdwSkRkVFN3OTlPaEh5VXgybXdhOHorSVF3U2pHc0dT?=
 =?utf-8?B?V1JDUWhFRWY3cnAwMG1Hc1ZXUkEvbGVZVE9IUDkrVFhoM3llak9WK0kyaFVC?=
 =?utf-8?B?THR4byt3RklKUFZUdUM2cVFyaWFxQVFrTExxTEdvVGVmWlNONSt4TFF1Zkxx?=
 =?utf-8?B?N0VvMWtrWERVaDNOTEQzNHFINGd2d2ozWFE2ejM1b0tVM2E4MmV2dzRFK3Ju?=
 =?utf-8?B?VUIrVWszcDFBQlcrYmtMNlVEVENnVWtxeXpBRXpiR1FmMElya0s1RjJOL3Ry?=
 =?utf-8?B?UGVuRnEwbGd4VVZFNnIyNERveDVnUFlySTFibndraUtqeEpEYit0MVJlVlMw?=
 =?utf-8?B?REVtcmhWK0NEM2QzeVZ2N2ZpL2JhVkE1V3ZXUTVtbTJ1ZDFPSWNBZVZ6UUtM?=
 =?utf-8?B?S2pxZno3SE0rRGJ5TEhKeU9TcG0yb01WWElaSDhUNkV2cWxuWWY3aU1lbzlR?=
 =?utf-8?B?SG92SVZXOVpnR2t5T1hSTkdvRjVsZllkUSs0MTV2V1BiMUJXMVU1RWJqQXNw?=
 =?utf-8?B?OTNxWnl3RFpMZFJRYWRsRWxRY1V6WUtOUVg3TVV6bkVHeEZ5ZHNxRW4zcnV1?=
 =?utf-8?B?ZlE1aDVPckhaMExPRWpkOWVhRmFxSU52dWcvc0dkUTdFaHdtT01lMk5taWJC?=
 =?utf-8?B?UEVYR3hyMFJCQTdsc0ZoL1YvODdwMVBtWkxvZXUvRlZtaHh5M3VmWmpjYll2?=
 =?utf-8?B?OHpvL3k2N1JwZndjR293Z3pXVndld0h5V2pDWlVQWFB1eFh1WVNqVVNqMS9j?=
 =?utf-8?B?Y2VHd1gzNloyQmxYaG1mS0doMlMrdzJiM1dibHhGMFFJMXJyMHlBWXZwNU05?=
 =?utf-8?B?SnFwbXNMTFUxY3R4T2ZXMlM0TXNLdHU5YzRpMHZmS3pxU01OamNDNWVLTU5G?=
 =?utf-8?B?MGNsd2oybmpoNldhNEFjZXRUUVRBU3BlV2diUmhFMXhMeGVodnNPU2YzMzJD?=
 =?utf-8?B?SkMwcmRvZU9IS2c2bE5LdW5tVEkxQ1dJanh0UU00VlpueFBtclVpZEhRSHJ3?=
 =?utf-8?B?TDAvNHBvaTdFRGoyUDZYNHBVc09yaG5oRU1PNkloRGdMRVJ2RjBPWTFKbGVM?=
 =?utf-8?B?WFBQSnQza3paak9BVk9KclJXYTdNYWkzRk9TUWJYcFFMRm8vT2daUWNQYnVK?=
 =?utf-8?B?NU9nYlYrbjVIeWRaOXZ2WktIamdPZFFEYmtWdDhEdXErWXcrNGdadUhBOVdW?=
 =?utf-8?B?cWNVOS9vV2ljeHNXM01MTklvdFEwV0tBQjhXNWwveXY1YjVPS2NFZkgrV3hQ?=
 =?utf-8?B?TFE2S0dDVlhIUlNtdk5ja3FFdUsvNEw5S05QNGRqaE44RStDTzU4Tkd4UGMz?=
 =?utf-8?B?TjhWc29wa3R5enJOWlREQk51Wmc1eXlubkFOY1kyREZKUlkyZXcxT0xGZjRM?=
 =?utf-8?B?WGVHRVpqK1FZSUpkc1hERzVWdCt4b0F2aExldTJpWVRjSU1OU1ZDcFNYUFJU?=
 =?utf-8?B?dGRxUFpLc0hBQ09hVnhERmFPTWxnMXJKZGNCNnZhOGI5bWcwT0Nlc2R5OXdn?=
 =?utf-8?B?WG4vNkt3Z2wreU9xRmxoS3JJWmQreXhsWFVjRE80VUZRaUU3WEloYkQxQVFu?=
 =?utf-8?B?d28zZ0lRZDdOUHhTTGc1dTBDcnNSVmpTNnJzcWVOZ0NpRnNnMjNrTlNFRmFv?=
 =?utf-8?B?a1h2WW9zVnV3aFl3Q2tub3YwTTJFRk8rbDlEM3E1dk1sbU9COFpOWm9FdlRo?=
 =?utf-8?B?dncrSkRhTTZCMzRFRUd3Qmc0UXdacExYWXR4ajV4N2dFRmhjWkMvQm5jL09i?=
 =?utf-8?B?eGZKSnFXZDhzczQ3NklNdTNWcUxuQzZHM0dIaldhdy82UWJRa2hJNDRYYVhW?=
 =?utf-8?B?N2RDSThtemZnc255NjVRNE5wcUU3MEN5Ymx2ZE5wQ0JEYzAzUHdBUnNMSS9F?=
 =?utf-8?B?RFA1eVRnc3BzanhDVTZOODdYdlNoNVRZaHUwNnRYWHIvczY1Z2RPL1VlT2FG?=
 =?utf-8?Q?bWF0liBdKR4W7PjKdQr6eHg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6b9420-3094-4cc9-75a1-08d9d081747f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 19:27:47.6484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ua/BW3kBIneDVwrN/7BeeFnLC9q8z7ILuTZfG9vI0PVN/l4k8A2/hZ8EoJtTYdgUqurwGICq+Tvt4hUd55pMZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-12-16 um 4:45 a.m. schrieb Lukas Bulwahn:
> Commit b5f57384805a ("drm/amdkfd: Add sysfs bitfields and enums to uAPI")
> adds include/uapi/linux/kfd_sysfs.h with the "GPL-2.0 OR MIT WITH
> Linux-syscall-note" SPDX-License expression.
>
> The command ./scripts/spdxcheck.py warns:
>
>   include/uapi/linux/kfd_sysfs.h: 1:48 Exception not valid for license MIT: Linux-syscall-note
>
> For a uapi header, the file under GPLv2 License must be combined with the
> Linux-syscall-note, but combining the MIT License with the
> Linux-syscall-note makes no sense, as the note provides an exception for
> GPL-licensed code, not for permissively licensed code.
>
> So, reorganize the SPDX expression to only combine the note with the GPL
> License condition. This makes spdxcheck happy again.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
> I am not a lawyer and I do not intend to modify the actual licensing of
> this header file. So, I really would like to have an Ack from some AMD
> developer here.
>
> Maybe also a lawyer on the linux-spdx list can check my reasoning on the
> licensing with the exception note?
>
>  include/uapi/linux/kfd_sysfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysfs.h
> index e1fb78b4bf09..3e330f368917 100644
> --- a/include/uapi/linux/kfd_sysfs.h
> +++ b/include/uapi/linux/kfd_sysfs.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 OR MIT WITH Linux-syscall-note */
> +/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
>  /*
>   * Copyright 2021 Advanced Micro Devices, Inc.
>   *
