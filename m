Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11759589228
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbiHCSVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbiHCSVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:21:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B2F6402
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBsvfQ8seFWT9YilWhhXwnMBKkbEgzxvYNIM8yUUQMxMAYOEv/xC0tEpQFJwYgkt1M8jsBqTbpqvAa0TPIJc7UFKKGH2WGFi2tn5+3oM69zHPNea7r0rF4U+1hsOHnalggQWygVJGnMkNuYfNowKZdv2Of/43GxdI0OwKzjjkf04DTmujxsN3jOdnsDo5DyDQIhaViFUeNO6pP0ppXwqd0hdwZDIFcMz0Nge7q2/GfeetVv3GMcsvnjfj2lcEUcIQnoD0684mec4DAxzE8AYEaug/2v+ZT0GlpUn/4489jfOlDRUgmXsBiAnOxKvjNq1WsDX+221yFpQ6SK5rOnKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+28/mjx4H+QmvHuX9ibWvSPj0tAbSgdJRmkiTXpBDHU=;
 b=lsL0ka0/xM9TPBCM3o+f8pK26WRg/RboS+N7w5yL5yG0NXO5CE7Flc0UpsE4GsDgVOwC/GN2zWCvR0Py/NSBQEOnMJJjt1GhHgETEvPt93rm/73TB2zJKLlff6Psj3oYsEo8s6co368pq9HhPZ+5NShPpqYyFnMcCSuPYvlXO9ehannOQH3SiNQEUSedVBbPvPfgFc/l3+xCjYXCktgkVdb13L8r2sGE9AtIuAvN6qW2/v6XLtUCAoQuVR3bU8wkoTm44fi3woCU6y7KShmAFmvctjQMINd8tzpfMXtiR7eJsSCmpNHf2aSvvsgh5pUXoI6qEiqSIfoAluiByUisfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+28/mjx4H+QmvHuX9ibWvSPj0tAbSgdJRmkiTXpBDHU=;
 b=mY1ZuzB9eWiV8kuXlqvSLegTSonZEYePqrXEYwnMCz0jKeBZec320B4v8iJIA9wPWrpfjT/c+ZneHFak9gGXCyh6fJ/7mC0RavZ02T1FSkgpx5prTr4meZYk3irWynF7RRegj/6I6/9lcQGETURY136/7xF9CY/QqIVn/FJ1+s4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BYAPR12MB3430.namprd12.prod.outlook.com (2603:10b6:a03:ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Wed, 3 Aug
 2022 18:21:39 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 18:21:39 +0000
Message-ID: <9f47ed0f-99cc-a237-f09b-45291feffcd3@amd.com>
Date:   Wed, 3 Aug 2022 13:21:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1.1 1/2] x86/sev: Use per-CPU PSC structure in prep for
 unaccepted memory support
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <1b50311c-448b-96aa-1d96-f4bfed409c1f@amd.com>
 <cover.1659550264.git.thomas.lendacky@amd.com>
 <2a2adc3570ae9c24d03fff877c4fe79ed43605e0.1659550264.git.thomas.lendacky@amd.com>
 <d5902382-70f4-be07-99f6-80d17cdfdcaa@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <d5902382-70f4-be07-99f6-80d17cdfdcaa@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:610:54::35) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6568ef42-e1d4-400d-dcf6-08da757d0228
X-MS-TrafficTypeDiagnostic: BYAPR12MB3430:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgZU+71spdlFc/cGP8xKAuU5zqsbhYUCt32OGkN+nEOT/KUlfecTAZH/YaWm2jv5EvkoiLsuJgVLolNjb7zZYKU+kP5lG8rH7fTuuA8bVflYOm9/jq/r+sbV7O/NlxEavO6y7y7n3mlUltMbewX7Ks1siJITaEqUGyJcy6OD9quFzzmxu+u7jHBETKQvpopeJNKIA4FK31SaDT8f//z2P6tmN1IJsQXIcfdz/pQfIn6oREj9w2zxbuISigGyDTlm24KQrIuN4QCUL1X8+29qwRGlfTV3cnU0XcFUpkBMQxnsyJ6cCKaNln+EaNt0LmzUtk0ArpW8i9m7JKRcACSQECJXpBucRNjGqgox4nZnqdaHZLogyPasBmZE0sIDygBnxcGSR5Zzoufw3uLEJt9hmzkE3PYLPCNL4F4GRI7PvavGgzRnVhrMy6w/09EnIqdMQxhYB7MzFb4DboppEvaRRx2FOThFFE4gZJbY3oTTjNkr/dcXJZr2QMwQmdtsKaXH5oGlQeoRN/5HyeoSJbOcd5p0ExcBWI1Tkf2iLx8dhYydFll38i/Y6r2FN2D8OrdtAxhoQSgPRwlamtx3molusdRMOYm+bUbCR+f5NymxFfmAmUAoD8pTeNOWMqQIqtm+PftzrlNKjXux+zhNp5mrP5pGPdJTyQ0rGHu6sizHwPDv0nCc7HdOrkSGU0RS6Qbkjq38DdaFL+vE1eYBRHbqyLdjDVWjTQ68PBZ7aClsA3SWldnS0pzY2731Egw0o1IxTQDOac9IoyV6FqBgqPqDk2pOCY+QGm4lt7YOGl1lVbCn2hcN6rUS11MUPmYSjQcpMEcgWtaww0u0e73871of6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(41300700001)(36756003)(5660300002)(31686004)(2906002)(54906003)(7416002)(83380400001)(478600001)(4744005)(53546011)(6486002)(2616005)(6506007)(38100700002)(8936002)(4326008)(186003)(316002)(66476007)(8676002)(66556008)(66946007)(6512007)(31696002)(26005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk9NZ2RBRjZmdExwU004ZlM1TENQcDN4NzZsWTFCSWFNbUUwbDF0UUk0a2Ux?=
 =?utf-8?B?VVpBR3Rhb2Nrb3BzQVY5UkpTWmtpZGwyaWNZRkx2TEhUc3J0RjFNakZwYkdV?=
 =?utf-8?B?YllnSGtjYlc4TXdKcUo4djE2eDE0T1VpM01TWUVIYTVEd1l3N2VRRzBud3dI?=
 =?utf-8?B?MlZMZEFLbWtELy96ZzBweGpZWnlqTmhMbWZoZDFyclpGZjd5L0ZKMk1VVGJK?=
 =?utf-8?B?NGRJOWNNRDFXK2tCUC83aWJGSEZ0SVgzanRtbkZJTVZXVzJQMHlCZTc4OUlw?=
 =?utf-8?B?Qngyb2l3cWpLazdROUdzMU1TQ0hrREt3S1BPOGRzVUdRN01zZVdjczJLNm1B?=
 =?utf-8?B?UWlOYlZzUzdELzFOTkd0MHgrTytQRzQ2UUpsNlJZR3FTK3NaUlRIRnl5L3B2?=
 =?utf-8?B?eGdhMGtPZkFFVjE5K3o0bE0yT3lKU3VUZlFRVGd3WXlZdU9mOXFOVE1LSnZo?=
 =?utf-8?B?V1NLU013UmM1ak5wRHdCY0pETFZkS3NEREdqZ3lmTmF4UjJtOWZLNTZkUTFM?=
 =?utf-8?B?aFo5VFBNUi9OaEM0amk0MERtNXJHbE93WS93bmY4TkExVmpiZVl6K2p2b2RV?=
 =?utf-8?B?aSsrd2lmQWlWMW1wUWJveXEvQVV0eDZ4WFJxTnA1dUdoK2ZPTkFoYnQ1OU1s?=
 =?utf-8?B?NUFUU2RBTTNkc2hOeGdmbWtjU1JSRHJSanRlNHV2cHcrOTVxc29OTTNyTWRF?=
 =?utf-8?B?eWNGQkhpREtmaGJ4ZFd5SE5pRXJVenBWYThxdGMrN3pZbTE4SnFHNFI0ODR6?=
 =?utf-8?B?dGIyNmlKeU0yNzRIS2Z3d20vNitKTW5zbVBhUW03RFZsV0NpM3hmTCt4Tmln?=
 =?utf-8?B?VWFFZ29EeG9WU1ZObXM5Wk93OWd4TG80SnhaRVBtYm5QVDR3S3ZmYWdTZUJh?=
 =?utf-8?B?bld4eXFoRmJzZ0hicTdab044UEduSDN1SGo3U2J3bE1hZmFWS09rSE5hUWZv?=
 =?utf-8?B?UnIxN05HMlBxTmI1WFIvRmdZR1BEblFNUEZ4dU5lRDZaQlN2SHM3WVNFVjMy?=
 =?utf-8?B?VTA2SUN5RS93YXFnZ0VxNTNrUjhUa2lBNVFPNDRrWnFQaDVtaHl2Nkoyc2NO?=
 =?utf-8?B?cEk0bnVnRVFXK2RSWUJXL1NOakNON0F6QUgzR240SWQwbjFNR0E0c0J0M3U3?=
 =?utf-8?B?YzZCRFJqQ25CYlVyK3VMTGZOR0N2YmVML201UFZzZUllWkMwbjFFTzVjZ2VQ?=
 =?utf-8?B?cDJ6eHEyU1hITW1rSWEyb3hGeXpUcGJVdXFUWjR4SlVtWVJZRU5SQkRadS9J?=
 =?utf-8?B?MFZwRW1qU1pIZzhWQWxwM0VDOWlLdkp2Y3BBbUI3eXR4c0hLdmFQNFpHeDZM?=
 =?utf-8?B?ZVJVTEJjQk9VSVpMdGFRU05XWnlJMUZqZWpaTy9YbnN3NGZwenFJN01lUVVN?=
 =?utf-8?B?ZThQaXdiV3huQWtuMFZ5U1hkc3NqNEMvZTdhVWhzMUsweWdJTDI3a3hheGtV?=
 =?utf-8?B?VGErM2gxZWk2Z1BOemJ4cFE0UzBDdU1EK1BlQUZxcjJ0anRLQWk1QVhoN2E0?=
 =?utf-8?B?MzV3aHRyeXBJa2pDR2RXRTQzOUl0bmxLRTQrTU1NMlNtbmQvbFRBTkZRQ3Vq?=
 =?utf-8?B?U0RUbXVrL0lqeWFCdHRzNGxNYlgvUG9iRnFlWll3Ui9leldFeVhXNlpFZ0hz?=
 =?utf-8?B?WVU0d2FGNW9ob1ZJWjZSQ0dYdC9VT2crc2VrZzczR2VlYjJnVXd1VkhzSDlU?=
 =?utf-8?B?NVcxSStVVkRzVWEyRlpGcG95elh4NlZWS0h4MXlkLzJEdzZVMHFRV2RMN0dB?=
 =?utf-8?B?RjFmOHd6VXVGaEJUTFk1a2wxMkRFRnJNOWZxU25FcitTV1JMTGcza0FpeDZ4?=
 =?utf-8?B?aHp6OGVDYXhqdzFyMTVLRVZpRDJjcUJVU2IzVWpwYStGdTY4SjFRaktiNnB6?=
 =?utf-8?B?eUJCdmV0RGZsdUtoYjRHRVQyREN3STAxN1Y0Wkk3Z1Bpd0hyYjFReDBBbnJk?=
 =?utf-8?B?VmpSdkpOUXd1blpDWUM1b0dheUtEUUFjZS8vSkVBakpJbC9hM2dwRVRvTEpn?=
 =?utf-8?B?TDd6aUN3dEVPNU04SFNqUGhxSjZrenBZUnIxV2JkdjY4MVo4TER2dkt3T2Rz?=
 =?utf-8?B?OU1Kbk5jN282ZVhENkJzTUN3WEJ1OTduK1ZtMll0M1FCSm0rVm82RXBJdFVx?=
 =?utf-8?Q?IxI9dhvZZ1q07CH3tC8i7NI85?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6568ef42-e1d4-400d-dcf6-08da757d0228
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 18:21:39.5034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEMJ2TCz51K9fJqXeZh4kDEvSSP/yf2lgN23Sh5Lkw2F1/9HfWUninpZtEhP3sZUg31xYhoAnqqsycmKl4J1Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3430
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/22 13:17, Dave Hansen wrote:
> On 8/3/22 11:11, Tom Lendacky wrote:
>> +	/*
>> +	 * Use the MSR protocol when either:
>> +	 *   - executing in an NMI to avoid any possibility of a deadlock
>> +	 *   - per-CPU GHCBs are not yet registered, since __vmgexit_psc()
>> +	 *     uses the per-CPU GHCB.
>> +	 */
>> +	if (in_nmi() || !ghcb_percpu_ready)
>> +		return early_set_pages_state(__pa(vaddr), npages, op);
>> +
>> +	spin_lock_irqsave(&psc_desc_lock, flags);
> 
> Would it be simpler to just do a spin_trylock_irqsave()?  You fall back
> to early_set_pages_state() whenever you can't acquire the lock.

I was looking at that and can definitely go that route if this approach is 
preferred.

Thanks,
Tom

> 
> That avoids even having to know what the situations are where you
> _might_ recurse.  If it recurses, the trylock will just naturally fail.
>   You simply can't have bugs where the "(in_nmi() || !ghcb_percpu_ready)"
> conditional was wrong.
