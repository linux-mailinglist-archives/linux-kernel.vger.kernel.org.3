Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A794F4C1EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbiBWWnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244376AbiBWWm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:42:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB35E60EF;
        Wed, 23 Feb 2022 14:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645656147; x=1677192147;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DEsSI2TJZ02EYzf082PywEmhOz0pOlHBIGT8deX0R0Q=;
  b=QZQtRfdxX5NNW42Dr9dKzhq4IICtakuITt28OWV4o1wj7On7Rwt8X/7Y
   7UP+HABgE/eLRK7uUxN4OKsCuI7HW1uRo1o0JPf7TAw/iC/3A8bJJ5g0L
   d9e1z+5rUv9EpLWtFt7qs/9u5lCIeDxNPorPW6QdCstikuPQWLYkJep2k
   7Ct+2vvvbptb/JEf474K0zKbrxkPs9S2XqLnxCGB+SzHN23vsp5nmGpM0
   v8ryUZ2V0Yn86Rl98PMzOBZpdU6dQBYVs15TyKL/DeUO6r0hZ2v/EeSIx
   29ZRnkRHT6uH3q9lR7LoG6+d/a95E7trmuaROef2AN/4I5EUilFFtDrPn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="235605530"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="235605530"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 14:42:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="707218801"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 23 Feb 2022 14:42:27 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 14:42:26 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 23 Feb 2022 14:42:26 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 23 Feb 2022 14:42:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcLJGewDnSM3jMk+pNBgIi2ccr8AaaXmv4InFmKBj3SCZbugvn5v2IDBUeSJhpsM99SB3fV/5Fq2n91Ms6vkhFbefgSr0Z8v6P2V/XyC2i1BBE30L3933Z/wfF2AuViFv3o/9VZhCU6oOddQ65irpnwC4uoUu1gJqXugcFjT39Yb+Fh9BjKcx38a4eAhDbgQPc2my5Js9Q8FMHZTMXn61pv3UJMFcg2hrKDtpphAcH4WsCPj4mQPYgY/XB2vQZnHvQ4i8WwODpjvGmq5TFqlsL9QWkCXQ5NJ8vj17JFRXniVtDjStCST0dFVi/3jiNaoEqYkQ4es9mAloxYRc41Ulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mn1OjcnmcDtsQ/kojqeVhLGV8SACxqfuV5SySKUYJQE=;
 b=O+W9izspUOVyWc9r5g1RpO2HuXV7Q5pARRX5SwHL0uiUZVj1WkSqvWx/wZIUzVZpJ1oB481/9Hfcne2/JgMtxP+C6uYomlG1PusDvVS+JDV5wCGR4kcvRdUrcUgz9mPE1RY+BdCs6ebYm+y5S3xe1CBJ9//+g5rSjipdYY192Ag+H32vA+KgqYav7uq1p59g16o3fNL+dorHHNb9Qszqq785c4P+6VT8czdaazsO5WuKqqvDmF8+bpSNlHxpRxEOSinMt6MTvM/l5Ccso8Jnc6TZG6K5FG1HAGebTyGfjYXS0Xru2UDISjnTaSrBNEdSyuSOHbfNd0yZmmBfBMlk/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1633.namprd11.prod.outlook.com (2603:10b6:405:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.18; Wed, 23 Feb
 2022 22:42:23 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%4]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 22:42:23 +0000
Message-ID: <77e81306-6b03-4b09-2df2-48e09e2e79d5@intel.com>
Date:   Wed, 23 Feb 2022 14:42:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.0
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0044.namprd14.prod.outlook.com
 (2603:10b6:300:12b::30) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41be2206-0ffa-4efc-3646-08d9f71dc216
X-MS-TrafficTypeDiagnostic: BN6PR11MB1633:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB1633A17B134700AC505498C9F83C9@BN6PR11MB1633.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPc6ay73uxjQ0cP5nU/49IpJfkqRoXlNPSlqmJx5R7GUAukiVgdJHsC+LoWXuPuGNn5Azw4P5VqAkDzkZIPPMSanjCGBfJw/146/v0bqeVifHR4ihjCx9rLw4JkS7sab3QaWXY0vFFsjxG7Ge92sCkablpQnJSliVgCRQjdTLOPnuqroWco5Vc7Jvo6oCKApteoYyOBdP+4OU+jOySIztn9Ou3qRaJXeoFwATCV4NVu2Qd76rZKPynzYDrpCym2sx5TasvYu/n0T4ChFJx41SSgxcQWfHKmpTwlX1uoCGBfoV4wJY0d5BLz7HvdbChcA4pqWxb+jcIt6iKIUbXLq2RaCNozWP4YpQEpa57nHAAHz3t3XT5CnMPkYAIC9KVzm9+NObjbUTMAoBE6QUtjp63yL5+bpUQQTCfERGnGUuZnY7bOouekGEyMcZDnN5+WDEKMBMY9tqdneoLe2LyehdcCVencEPL/Su2CAB7WnlPhk/2kzvdXQrdpoZ9dJth6rSaewbr/HYYU3u1ACo0GoEllQpsKFfN1qXpqbBVTpYoS9yK7xyHUbjaHIqLcCE09CW6GhtkDWYnSYyNatce28AdZHF95OI71VMWKx2mF5fXJnyOcP9NrX4cq3B1KS2FyZg+T21/lJqjVZeIdJMXIBiKmDieXWTv1bcXTM6Wke7DRrEy9uw/Nf7ERqV73breDhFsXXYBigk8XQufQOvreVWbfbNondma0mG/u0KEo8rE63Xh9TdO4TNg9G1gdL2KrFi1LZKOuoaQ3YjTIyyaB98hh4Sw8SLnTOnEnVXeLl3b4H514WqqRoYeHcZpZzsI6ZZ02kiO4tvBzMk0gfs8VD7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(66476007)(86362001)(7416002)(110136005)(5660300002)(66556008)(31696002)(8676002)(66946007)(8936002)(4326008)(6506007)(6666004)(53546011)(316002)(508600001)(6512007)(2616005)(186003)(26005)(83380400001)(966005)(6486002)(38100700002)(82960400001)(2906002)(31686004)(44832011)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVlyWFZHUWloT2lpN21IZkhRWnFUQ04rZWRYT1oxT0FVVUhNcmhacUg1bkhG?=
 =?utf-8?B?MFdhTlN2NG54dXVlSmxIclE4NzFYSGx5UDdZSDRpOXZ0SE9kMVEyYzJLUDFQ?=
 =?utf-8?B?ejdPR0FpaEJrOC9TdkEvRXlWcUFPaGZidnBkb0x6dWdicDdKaEpNRENrdGtW?=
 =?utf-8?B?U1hPQjYrMkwyT1graEk0UkVCMmxZMjM5dklONHhrSW9aZXhGNDZTcHlPYVV6?=
 =?utf-8?B?RGVlSkw5cDVEQVBWNDBEQ0dQdC9yTXBiNEZYNXhsSERYNlhLQjJtem01S2hw?=
 =?utf-8?B?WWljemZRR3R2WGN2Zk9adk1rQVhLMjRzcDNDWnpYUUwzeWNlbmYwQkE3Nlc2?=
 =?utf-8?B?Ym9CajljZmVxbm11Q0tmYUR6R0Evd0hLZWVzQkFoUWlnWEoxMWUvS0Y3M2w3?=
 =?utf-8?B?VGhkcG56Qm1ORGRPM0JlTHMrWGlLZTlMUElNZ2FvdC8vS1NWRThiVlpQVkQr?=
 =?utf-8?B?czNoTVB3STBCbjRvckE2dVhzaFQ2eDFVSGhoWlhvRDkrSWtDY0ZXRFYxMVdh?=
 =?utf-8?B?VUxyVTlDbEw2QzQ4a0ozMU5uRHgxZTd0TWdFVG5NTkhzOTFWL0tYUFNIdjF3?=
 =?utf-8?B?bzBwL0dkaWpsdmhiU1djdUU0RTlzSDBXdTdkNHpaSmQ5ZUlocnFEMVQ3NUVZ?=
 =?utf-8?B?bmNLRlNGTko3aTNWRlRnSTRSY0dSSTVpMTlSQ3ZEWDE2dkFYY3dGWDRNNmZl?=
 =?utf-8?B?ZGFvVENMb2E2MXB4Mng3dndxOFRsSGJyNFVGcDBBdUlxV1ozNHg2MnduT1gv?=
 =?utf-8?B?OWhtT0hiU2NERVJ1bzBqL25URGJydWlhRzFkZThMRGVvcXZOaFg5WTJTY2xv?=
 =?utf-8?B?dXljeDErdVltQVE4YjBPVkw0RFM0UEExczZuQzloRnZ0a2dqeE5vM1NHVXQz?=
 =?utf-8?B?RUJaNjY2UGMwZGphanpvTVFhUDRickFyNEFuTitjMlhRenFuNzVlMDZjRVRM?=
 =?utf-8?B?c3hTc09INXB1VUNCUmlnMnN3QnVlV0F2OXkwV09Kckp6ank0R3R4dXhMTWhS?=
 =?utf-8?B?RnpKM1grT3ZyM0FwUE5OcDJ1YnN2SVJMNFU4Q0JMLzlDeHpGdWdPb0lXMmNL?=
 =?utf-8?B?Zld1WWtNZjJKeDNpc1pzdmhtR2NuWlcxY3IyYlZ4dGh3aDF1c1JveUdLM0Zx?=
 =?utf-8?B?SmFjNHFUQVZKME5DSFMvUmZ6bnVtbHNHaVp0TmdQZUIxMnNTTEROajcyM0Jn?=
 =?utf-8?B?djMrUW1teXVaWjdDbU5qa1c5SjVPT0krMU9qOW0vcGd0NWdTVmc1eEdySVFF?=
 =?utf-8?B?QWdVeVBBb3ZXSnJRQ1UwOG5LdnBUb1BnWDZWK1NZcDRKNnBoWlFvSkFSVGJq?=
 =?utf-8?B?QzB0L3NtTHZSOGhsMi9kNThSK0MremRGWFZ2bU9RTUFvSWpiam9NZFNCOXdM?=
 =?utf-8?B?bzBqTW9BSWZ3bWhtcXVRYnFndHRFYlhrZnZVVzhrUGh3alQ2WWZVQWtVeUdr?=
 =?utf-8?B?bFBxRTFlak1CZmhJZU9scFdGZ2JpTW1MM21rc1dKZHhzcWNwanI5OHJndnZa?=
 =?utf-8?B?NzdJeGwxUXAzTzJIaDMybURxTDN0U0UwNWZEZTRzaVlUVUs5dFRGQU1NTjRa?=
 =?utf-8?B?WDlTbmVTYm1sR2ZRd2pMM2FKcWZtTGtrTU14OVQxVnl0UXA4akgrVis1WHMz?=
 =?utf-8?B?UzMrb3MvSFozZER0WkxtL2hSQTByU0UxQ1k5bkVRNkxvampub2w3U3RrczZy?=
 =?utf-8?B?L1VoQkttaDRmWm92empIYzFCWVYxUFBQVGlvUm1DemFOZFMwRklGcVVLWmp2?=
 =?utf-8?B?cTk3WEQzQjBzRGF5ZDE0N2F3aFlSM3dsNWNSazBsdDQzUndEajhmaHE0TjRy?=
 =?utf-8?B?N2k3Sm4rcC9WNTIwYmFxUnFYWTFpcUc3dDFUZHNBelR4d3Q0eVZ4QlUyMllC?=
 =?utf-8?B?UkFCRFhFcU9KSlBIZkU5Yld1VUtKbHJGSUNXWlRBcERIZWFQb3hUTUJQZEw0?=
 =?utf-8?B?bFVrR0lOZVBtVVA5NG92NFM0MkFXeEpRZVBHV3EyL3kzeXJqZzY0cTlwSWVT?=
 =?utf-8?B?VDBLZEJBcG1FSjFudjljNnVzeVRTSzJiY0JMM1VVY3Y4QXUwdnVNSytDNGRq?=
 =?utf-8?B?bVl5Mk9pdlB6aVFmdURQdVV2VUIyazA4ZnFWYk9GNUFsckwyS0g0cTA3RGV0?=
 =?utf-8?B?eUhFaURqdE9jZVFrRlNOMDd5dDR3em5WdVRtR2ptaVNMZHpOb0ozTUxyR2R5?=
 =?utf-8?B?QVZiazhUYURScllKd2RSSUhWOXAvN21BT3RUVVNRWjBuSUxkZDlmbWN1bEt5?=
 =?utf-8?Q?Jmlq+fT+evxSPePYCPeusgMoVmT6R2aoVKuXRhJorY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41be2206-0ffa-4efc-3646-08d9f71dc216
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 22:42:23.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wst9Np1WYccG8lHKC8CyXdKLOyh3S7aD/6kzU5sH05eagrSA1TLAt9V3vLZIya689NGdrfuKjp17DwQIs6XxrgMvsJiQFA6Wrf48y7JvHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1633
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijay,

On 2/23/2022 11:21 AM, Dhanraj, Vijay wrote:
> Hi All,
> 
> Regarding the recent update of splitting the page permissions changerequest
> into two IOCTLS (RELAX and RESTRICT), can we combine them into one? That is,
> revert to how it was done in the v1 version?

While V1 did have a single ioctl() to handle both relaxing and restricting
permissions it never was possible for the kernel to distinguish what the
user intended. For this reason, even though there was a single ioctl() in V1,
it implemented permission restriction while supporting permission
relaxing as a side effect since the PTEs are flushed and new PTEs will
support the new permission. A consequence was that the V1 SGX_IOC_PAGE_MODP
required ENCLU[EACCEPT] from within the enclave even if it was only intended
to be used to relax permissions. SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS in
V2 is exactly the same as SGX_IOC_PAGE_MODP of V1.

> 
> Why? Currently in Gramine (a library OS for unmodified applications,
> https://gramineproject.io/) with the new proposed change, one needs
> to store the page permission for each page or range of pages. And for
> every request of `mmap` or `mprotect`, Gramine would have to do a lookup
> of the page permissions for the request range and then call the respective
> IOCTL either RESTRICT or RELAX. This seems a little overwhelming.

Gramine would also need to know when to enter the enclave to run EMODPE, which
goes in hand with running SGX_IOC_ENCLAVE_RELAX_PERMISSIONS.

> 
> Request: Instead, can we do `MODPE`,  call `RESTRICT` IOCTL, and then do an
> `EACCEPT` irrespective of RELAX or RESTRICT page permission request? With this
> approach, we can avoid storing  page permissions and simplify the implementation.

This should be possible with the current implementation, similar to previous
implementation, but not optimal if only EMODPE followed by 
SGX_IOC_ENCLAVE_RELAX_PERMISSIONS is what is needed.

> 
> I understand RESTRICT IOCTL would do a `MODPR` and trigger `ETRACK` flows to do
> TLB shootdowns which might not be needed for RELAX IOCTL but I am not sure what
> will be the performance impact. Is there any data point to see the performance impact?

It can be worse than just that. EMODPR requires the EPC page to be present
and thus the page would need to be loaded from swap and decrypted if it
is not present. This may also mean that existing EPC pages need to be
swapped out (first blocked, then encrypted to backing storage, then the
ETRACK flow followed by IPIs to ensure there are no more references to that
page) ... before there is space available for needed page to be loaded and
decrypted.

That only takes care of the EMODPR ... which as you state needs
to be followed by the ETRACK flow and IPIs.

The above is also just for the OS portion - after that there is the
EACCEPT that needs to be run from within the enclave for every page whether
permissions were relaxed or restricted. This would be dependent on the
implementation - whether the enclave is entered once per EACCEPT or once
for all EACCEPTs.

All of the above would be unnecessary if permissions were just relaxed from
within the enclave while SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS used to
perform the OS actions.

The performance impact should be easy to determine: run both ioctl()s
and compare how long they take. Since you are asking about Gramine this may be
best to do in that environment but I can attempt something on your behalf by
using the existing SGX selftest infrastructure.

As an experiment I modified the existing "unclobbered_vdso_oversubscribed_remove"
test case that currently runs the SGX_IOC_ENCLAVE_MODIFY_TYPE on a large memory
region to instead run ioctl()s SGX_IOC_ENCLAVE_RELAX_PERMISSIONS and
SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS. In my test I ran these ioctl()s on a 4GB
memory range to amplify any performance impact since I was just measuring it
by printing timestamps from user space.

My result showed that:
* Running SGX_IOC_ENCLAVE_RELAX_PERMISSIONS on the 4GB region took less than a second
  No EACCEPT needed from user space.

* Running SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS on the 4GB region took about 20 seconds.
* Running EACCEPT on each enclave page took an additional 20 seconds. (Please note that
  this is using a sub obtimal way of entering the enclave for each EACCEPT where it
  would be more efficient to enter the enclave once and run EACCEPT for each page without
  exiting the enclave.)

The performance impact seems significant to me.

Reinette
