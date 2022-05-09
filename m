Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05EC5201F8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbiEIQK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiEIQKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:10:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BB82609C5
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 09:06:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBSvAr8Z//eXZrVz2HWSCkQzzH970C7lhz6a5txfUzoQdvoHhxt4fxL0kROeE/Z4RYAi32Ow+b9ukb7KaUCXtqe8Xat0s6ugHf34S4T1leRRX1z/6i7tpup1zSPvhF4A19gnyTB3LNh5QJHmnkjPCuGeToG9id66agqoAnU9vK7aw32mZ0VmzW13GVHz3IMZojdQXQWfi3OBDoX1ENpVm5OIBykvBEhjPVUFbymlwuxWD4366Ybx45lUBhFXOvbdM14giSpY+LG1lIYXJk132JgFRc0SdDPhUIsrwKFNjdHBjLtduXr53w4NBVWNGWfivQbq8KrG675B/Qa/lpneqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90XeeYXo757SwrG1O5NrR65fTu54UuDZ7JSJiul292s=;
 b=a7hSilAxLuEqEUiDXbnAUHxyppAS119IOwn2X3jyzFpYSTNYvzYlKqAg9uV6JHHOCQH62u1UNQzBitrp5dQ7XClgCQkd+fqD+TQwzBoNASD5Brk2q/jT9fCOFTiXLCl69hXgsP9C6uQe0v+Un/bGC+3YDG0F/WaoTIypNfMZL9vmNdjt8QahKWarqNefsV0k4DWYEq+zbRtk9g5WM3Sebh1AadS2zq5EBue7gx2PtOrh5o05fkbrPGO3K0+Znyqc0xf1OPrll+cS3WeaJdQtTamkL7O4IT2EUm6VaiAR7YT33ZgiLokWWtObiLyNRcZFuaAtTO1RuMjsNWY7QURXTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90XeeYXo757SwrG1O5NrR65fTu54UuDZ7JSJiul292s=;
 b=n1CRpixFE5UrOfY9NyCvofYnMBcg+3kqiVk+fTVhSJEusG9MG1dDAQtdBqmYhWEGBr/EOlx9mnnCpwxwZ5RzI/UFG8JrnEy0sXMqK6OsR0qJc2ErizMgWCZfQoCYlBuGMvnJ/jyH0S/x4pzKT4GBCNxPDbHSFIMRMrPgGHrXrK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BN8PR12MB3475.namprd12.prod.outlook.com (2603:10b6:408:48::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 16:06:24 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::db8:5b23:acf0:6f9a]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::db8:5b23:acf0:6f9a%4]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 16:06:24 +0000
Message-ID: <56f89895-601e-44c9-bda4-5fae6782e27e@amd.com>
Date:   Mon, 9 May 2022 11:06:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] x86/mm/cpa: set PAGE_KERNEL in __set_pages_p()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20220506051940.156952-1-42.hyeyoo@gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220506051940.156952-1-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:806:d2::21) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 209eb63b-5105-4eb6-c16f-08da31d5ddd7
X-MS-TrafficTypeDiagnostic: BN8PR12MB3475:EE_
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR12MB3475FDB95813E0FB5FB10C91ECC69@BN8PR12MB3475.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nML/+QqkGWAnZpFb52AHNK5TxTBGUQ13XypMxJX86BOWpBAG06LE0P9wnEBNt0lnL/6cL1T2+tZl5SP5KgmyELxfh4fI8Q6sS6HZ1XKPO6mGFZd7fQZFEcJr8eYfa7OCfGFIlVQqN3InwuVQJZG9apswKbGTjLQup/thJ6KOTiAZui940a/jyvFlP7Sq1SfX4v0MF9bgLkv4qWFgjD683igwqAQam7N6U2EYp4yuLYurcgr26U60lleXZ1avE7Nxpbto/sEpWAg8pStXj9wsSeFwkV9htShLCJtuH0a/L2IokgYalI7Jo5MsrmE4k9Pc0FPGCvTWdrFkLmJTUiKaW0kk0fuJKb6WZiS+7o9gXnkYYU7bnHCsc+zHMENbkYr45lCbV+uLqa3tiEhoilq/QkYz0HunGDal95+pzievOKoOcDpRQ5rEhx4/viCve89x9u9GZg4rCLl16fOkd2rNc7CiTyyno7UcRNLQGnqGsxGd0f2JfzUYsImDq/lmxd8xCtXjQbBTDkgUlHkixDUSLuu2OXFUz0yQN3l0oHP71BzPZsYeqq3aEtPuGvWoMaQwIDgR2oMHqZBQd2Oqj2Lklm5A5jl6xH7GgTwTu6RliQMeIJW3WNGfpOrkudr0Upmiv0jQxtLl2HU2Qv9yBFQTwOWxm5hDOdZwkLWP/A6QUzAuokmlzmiaI9bwcwtHph6gweyUf7ICBFuIpSS09VDmMbY6j6TJjnjWyiP9RfQ/cEI800q9akIJO9YpKuRHGc2G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(83380400001)(186003)(2616005)(2906002)(26005)(6512007)(36756003)(110136005)(86362001)(508600001)(5660300002)(6486002)(7416002)(38100700002)(8936002)(31696002)(66476007)(66556008)(66946007)(54906003)(8676002)(4326008)(6506007)(53546011)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHp4TTdrK3ovVnBXTTNta1puaVNSTFZYSC9TcGVTN3lobnliNDV1Rk9QQTFt?=
 =?utf-8?B?UXlwY3BQcDN0eGxiK2locVZHREthbkJWVGNtZUtyaUVNOEJMMXFQQkRDbzN5?=
 =?utf-8?B?ZkcvYlFncUwrcElaQUd1N092OHhqV0trVko4ZVMwYjJrdEVSR0VDdlNROVJ3?=
 =?utf-8?B?VzRhUGduVnc1ZXpqZEY0RGhETGNYajhZTlp0SjZscUpBYnZ5U2pJUEVWRk1Y?=
 =?utf-8?B?ckNxdStzL2xhMjJHc0pxM0NBWG1FVDMrTG15M2dhdEI4MXFXaERXQXJrY0lL?=
 =?utf-8?B?U2g3UlZNZ0k0cnBDYTRTNDhDODhPUWlwR25zelNUTlYxRitjNUhOdTM2SkVt?=
 =?utf-8?B?L1VMOUpmcjIvOXFsdU45b2FqK0o3TkhzaFRzVGVsaTNWWU1UbGVZOXJGa05U?=
 =?utf-8?B?UFpZdm9uU09SVmxxK2JyNmRqdnZLSEJoYUZKRjlPWjU1MTAwN1lkVG1rckhH?=
 =?utf-8?B?THM4UU9HRVJNbGxCT3hnZXFocGRnbW0zMXlXTTBXUEVnYitkUTI3RHJvejZC?=
 =?utf-8?B?L09GSnZWVTZsdGVrQVlCcGRWVUxTNmJjODBwM3YrcllKWlVUUGlVbUpBU1Vp?=
 =?utf-8?B?YUU5RkZMQUJ2MkYvLzdiLzNKQXFuVTJ3eVNVdGZmY0xieVpPeldSSDJRK2RN?=
 =?utf-8?B?NGRKUjJwQVpJMGc3anFzeGRLRnlNYktIQzMzWkVoeW02OTlPOWdLUGloWVN1?=
 =?utf-8?B?K2dxTEdpbDF5TmxKV21XWkROQ1dsR2VQb2ZueGRpWU00WWNBMzlRdE10eDdi?=
 =?utf-8?B?QXVDUjJYUHUvWDVINVBGSlNFYjhEc0VJdUV6YXFuVlE2ZUR2WkJEbFRSbGM5?=
 =?utf-8?B?UjU2eEZVRHlWamU5L1NvdDQySmJ3emdOUW5zNVhTOUgzbWJWemY4a1dLbHAv?=
 =?utf-8?B?YW9tOVlWS2tSNjBsRzFqb2w4WTVKczZFQmoydnQwWkEvSElRZGh1K1N5cEtX?=
 =?utf-8?B?Ykl5U0NwQ2RCb3dwQWl0YW1zZldBZFcrNFM3Ukl1eHBlN2FDV2hDMFVpaVpz?=
 =?utf-8?B?blRPNjR3dVY0MURLa1VlR25nNTh5dzFGM3dvR2tXclp6VngxMHhGdVRCZU9O?=
 =?utf-8?B?V09CblozZjhtUU5zdWZILzFDWHh3WmJibHFsQU1SNy9ZUVIvZUwxaDZzUFVS?=
 =?utf-8?B?SkxlT2pIdHNuY2lVdkxPRkV0eFg2cGJSdTRwRXVHRnZpZ0VrR0MvWVl2YmNm?=
 =?utf-8?B?dmx0S04rOHJCYzNRMno0SzZIZENXS3BhajJQZVErN0dnMXBzOHQ3bnZsNkhW?=
 =?utf-8?B?WWNKTi9TUis0STVYdkZoM2gzTHp6MFVQaWpJWE1tMkl5MHJQYnpjVlVpN2xy?=
 =?utf-8?B?cUV0b2l5MStMc0VmcEVQcmRiUmdHNm9VR2hZSmJpRG9jS3RmblU3UEtNVXNo?=
 =?utf-8?B?Mll0Y3FQMHF0Y3Y5WmZVSXFBWWF3RlR6MVkzVFN2eC9iNTUyOXhWZko1aVRr?=
 =?utf-8?B?N05BckNBa0Q5UFZ0c3V1OExWNXBYZ2I1VHFsYjBWVU8zVlNwV055RzdpcjhW?=
 =?utf-8?B?RElrTkplb21RMzIzQk13M01sOGJKM0dwL21ieFUzTmx6WktSc3kyMUNzYnll?=
 =?utf-8?B?Q3JZRUZESUk0TEF3S1YyQzhOTDh0NFhzZHdBeDNrYlQzckdoN1p6TzhQaGdC?=
 =?utf-8?B?aVBja0JnYUQ4R1crcmNlYlhxZlB6blJIaFJlM2oxbzFKZ2JXek9VeFA2M1JJ?=
 =?utf-8?B?MkZaVFNxS0p6YjJNWHFhUWVnSXBoVzE3VGM2TEROVDNLd1BBZ2p2WThqWCtw?=
 =?utf-8?B?ZmoyVnA4Wms3ZktHcFlJWitFR2hNbEVvYzVjZWFiR0R3RXpuT1Joc2xtMHBm?=
 =?utf-8?B?SzhqWWYzU3dIaXpSUTlocnIrbjIySGhzektYd3Y5em5hQWZiODlZblhnZE5R?=
 =?utf-8?B?UVU1ZEFFNWtQYVd0RS9DSS91eElxWHRwN0ZmaHlZYmhiWDFteGcxV3hnallm?=
 =?utf-8?B?Y3dkKzVMaGgxWXNVdkRsR2lrSk9XSHg1emVUeGwyUDVEajBWa1dVVktFaUts?=
 =?utf-8?B?WGxUZjBNcnQvWTBFQ0E3d2Z5T1RnZDNVZXBjajkveDQ1emFkV0h1bHNDMFpG?=
 =?utf-8?B?ZWd5SzJGcHduMHhMME9WdGYwNUtCNUNkbWxPYUtBdFJ6b01mb3dla0JpcHdI?=
 =?utf-8?B?NFRTZkNxWEtMZkVzUTRVaWNhU3NJdHJPbkt2NEk4WDl3d3RCS2VmN2hZNC9G?=
 =?utf-8?B?R3dWY2VXWkFCSzdoY21uUHNNZURuMnlRaWlsVFc4L3BwbUdJano2b1ZHMEhm?=
 =?utf-8?B?eDc1ZnVpS082ZjJRb3Z6OVZDQlZ0eGFqYjJPWk9TL1hRTytpNmFnc3NxaWFu?=
 =?utf-8?B?ZFNCbXJaQzFkTkhScVhCaXgrcXpmZ2IveW9xYmp0cTFkOXBaOUdCZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209eb63b-5105-4eb6-c16f-08da31d5ddd7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 16:06:24.7608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3i4tgmUwwu9sUkaiQiQOhBi1KtQ/9cxldUq9CLOrUfnagKj4CRYhM/BPk1sEbVOZt0PmjmA4f9bKSZWQziqiAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3475
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/22 00:19, Hyeonggon Yoo wrote:
> __set_pages_np() not only clears _PAGE_PRESENT and _PAGE_RW, but also
> clears _PAGE_GLOBAL to avoid confusing _PAGE_GLOBAL as _PAGE_PROTNONE
> when the PTE is not present.
> 
> Common usage for __set_pages_p() is to call it after __set_pages_np().
> Therefore calling __set_pages_p() after __set_pages_np() clears
> _PAGE_GLOBAL, making it unable to globally shared in TLB.
> 
> As they are called by set_direct_map_{invalid,default}_noflush(),
> pages in direct map cannot be globally shared in TLB after being used by
> vmalloc, secretmem, and hibernation.
> 
> So set PAGE_KERNEL isntead of __pgprot(_PAGE_PRESENT | _PAGE_RW) in
> __set_pages_p().
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>   arch/x86/mm/pat/set_memory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index abf5ed76e4b7..fcb6147c4cd4 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2177,7 +2177,7 @@ static int __set_pages_p(struct page *page, int numpages)
>   	struct cpa_data cpa = { .vaddr = &tempaddr,
>   				.pgd = NULL,
>   				.numpages = numpages,
> -				.mask_set = __pgprot(_PAGE_PRESENT | _PAGE_RW),
> +				.mask_set = PAGE_KERNEL,

With SME/SEV, this will also (unintentionally) set the encryption bit, so 
I don't think this is correct.

Thanks,
Tom

>   				.mask_clr = __pgprot(0),
>   				.flags = 0};
>   
