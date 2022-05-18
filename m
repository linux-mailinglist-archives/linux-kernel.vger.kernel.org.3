Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0391852BF7B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbiERQG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbiERQGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:06:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24E46973C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652889982; x=1684425982;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FPku9nn5boWf3btOgtqyxEvZgH9gmAr4LK29gXIdtiU=;
  b=WZc+1mbnNqQXNpwTW9S+KTf6TqWBe0hok15024SG6Ekev4Wme29pFBQ8
   6rNsBz3htWX4gC5+CgZ7x3vA2sIa4Qi91QKF58XadxiQ7+xnH1fPagQMr
   0tT6pVkvGD45KaN/IR3J2kLURiFqCsTjO3RcLVB6QJkiiUJSt7fAZKIc2
   /SGTM2zt3VKmkDEH4YlhYcutzmt5/OymEwPTp8NXFAq985whkxp6bSfNt
   HVn3nfOkKUW3cbc8AESuBWkqgbKEuFLnlUZ5IVs2ozYe937j1SHVHxQs3
   KtDiAeBskOqSWcwNSCWSefE8Y1NAnMHLE+MoZr86ch5ZieaIiUrOGLuLS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="297041877"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="297041877"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 09:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="545537551"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2022 09:06:21 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 18 May 2022 09:06:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 18 May 2022 09:06:21 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 18 May 2022 09:06:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEd0haq/C5LCYSarKbquHQEFWWtHV7GE5WXF8V87XhA+E4Wlt7ev4g8J+PVIRLujOVuutnrB9/NV5dGxpj2HrHbzHCZWFlUnjspf2PQddSRfsURvoRihLJgD52+UwO/O9Zl5u1niYEdNo68j8rA2TBkyOt+I00o+xBUqLYXxAsRqP9MBbvHGta6VFKoDAO2HanpUaaAIQmGTce2RWQcP9+CoLSRaCVxvY4f5CR7UpCtiLjksiPHncV8YYSbD4eYisvFwvz06zYFKx7oqv0g8ECNx09V3YWc8qWM7Ag7Ksn9V5+jSE80Z5T/YF8B8wP3d02IOCJ8xOzZzlVepO8emjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltk+njOXVXFNoV4t7QpRQn5CcWHnQfXUCDS3s2lBJJk=;
 b=JCIb8bGgc+/k5ho3Jrfa4/+H8tOwLMPz20kfmdEOUpPUz2o82TQlBEtE++CLsqP7UPA8Vq/xGpqdIC3FjDmX73OO0UaiXyfSK4vzI4Jwr3aLjPtNvJqIMT2tcGZllLyA1P29TVCsd/95R89GZi/0L587+FCiIbctX2btG2TIJefs3QiQNRzvmLQfC5UOvkELifqh5SYiCGfzAZRsmPPr3q76M/XnDBAiiUd8hwcbPn/jyqjWc26Z8/yp7xRPnGk6hMUrbu+kVV2iej8l1Hug4yUUqis94jreJ8/hBRF7yTNZEIGRUPAxpKXXzTHIIxRZ56hBHUV0BQqD/Nm/PBB5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CH2PR11MB4229.namprd11.prod.outlook.com (2603:10b6:610:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 16:06:18 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 16:06:18 +0000
Message-ID: <2da64be9-6cf3-199f-27af-597b6283d724@intel.com>
Date:   Wed, 18 May 2022 09:06:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH v4 07/21] x86/resctrl: Create mba_sc configuration in the
 rdt_domain
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Xin Hao" <xhao@linux.alibaba.com>, <xingxin.hx@openanolis.org>,
        <baolin.wang@linux.alibaba.com>
References: <20220412124419.30689-1-james.morse@arm.com>
 <20220412124419.30689-8-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220412124419.30689-8-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0120.namprd05.prod.outlook.com
 (2603:10b6:a03:334::35) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 221ee7b5-7fe2-4fa9-b288-08da38e857c4
X-MS-TrafficTypeDiagnostic: CH2PR11MB4229:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CH2PR11MB4229B21663682C88BDE7631AF8D19@CH2PR11MB4229.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POohtouLFMUW23N6KyX69PDbMLS+ZuWaY9T/I7f6SlaBy/6+7p2dBLETvl9OCbdkudwHugc2WaMMi/U36RDvYvfaLhzWyyjfbcKXvyuIJpaQT9XNNBtV+cWbuXrLEhzlIwkNRpU5zKaZ7cU3h7I5TkH7oU/xhWw40a9YjQsCbcXJO6L6PJr9Rxqbey80n9WWtwR8MzfK0KdygsRi2TJ38kMOKK9mAD3xnU1xnXvDrm8ynHpRhNdo3Mv8L+YPIit7MSRhIMjbK3G/mIngQrIBeh3ddyF0GN+D7KjXwW//xa4J/t13tripofORekBvRkqdzPnfse39YuCj7z0tnbKVJPHSPl/AZrBrjZSWAd+e/UX647LKfJQ8l8H2uABFd14nZWBXG8Q40atuTEJAdeqX+1rrEZ/jH5YKVVRTEv4NdiRkyWgDpPfDZ8NrpLdUYvuV1KSBKF8oFWZz7eOwZGaIs3VzkZNHhvTMoKCia3/qzsBtCbv4XwXbHD9DmrfPs35LE5GLt1dl7T8IDp2B6UsKCMqZ1Rer2qDwi+6+w68GQkTCn5r+/fX1coPkUxgGEWHLMifekmnBaaOgFNaZlxvrtrt3AnhHTUlCF9m2gUZxmbOKk6FQf7wEoIw3f3IgT49TQQ7Jx3oj+XlcUrh8rMyxn24b2DeFZus1r35IwhkFUDnz7thn4PmDK4lMzdnVbh9TP0hzXt4Oh2oq2aVtjrXZhwZ7tXxMgcREURSTLH2mVz0QSqrs70EVlh1mz7EBLwpO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(31686004)(6506007)(186003)(31696002)(44832011)(2906002)(508600001)(54906003)(82960400001)(6486002)(26005)(6512007)(83380400001)(38100700002)(2616005)(66946007)(8676002)(4326008)(66556008)(66476007)(6666004)(7416002)(8936002)(5660300002)(86362001)(53546011)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHNVMkJMdFVrbDUvWnFXZjMrc3U3elZBZTJ2Q2p6cnBkRmQzbEFsSjlqZWEy?=
 =?utf-8?B?aHh1UWFpMndDWUdJbFRzR2JwOGNkNFZoeWwzNTkrZnFqanpTWDdETUE4RzJE?=
 =?utf-8?B?UHdZQmRscjBpNm5WVVl5R3JjREhBVFlIYUE5MUhNUFJiWitFT3lnblplMnVx?=
 =?utf-8?B?M0Q1Z1dCNkZVWTFuWGpKNHVEUGZKSnMvTHhaMG9ZaEF1aTA4YmZ3UyszcFl2?=
 =?utf-8?B?dDBSVDlNbWEvNXJmYUM0ZmpZUHR5Ums4VlRvMEIycFhsTStIWGt1bVlTTExn?=
 =?utf-8?B?Ryt5YW9pR1V5YjYyVnViRUZaMnJzSk5FZDJnN2tQQm53MHdod0dQN25DdVRF?=
 =?utf-8?B?Q3RJaDQvK3FmMUdjc1EzTnJ3YWpTL3FUeFZSY0I5dEo5dTVyZDB1LzRKRzNq?=
 =?utf-8?B?QVdPblNTWmFET1RMa2YzTnlOYlNwNW9SRmlQVjd0Z2dJNVM0RVllVlNtRS9H?=
 =?utf-8?B?aDRJWUg0L3k4RldvbUV6eDRLNkU3TEVPNElnRGE1U2Q4aXdYcm1lTTVrQzBH?=
 =?utf-8?B?MXFSN2hQeTdMUDdzaExrQU05M1U4clh3b0lXNG8waHJPN2JYZy9hZVp0cjNt?=
 =?utf-8?B?c1ViaEEzME95cXI4d1NuM3ZzRERZa2xQanFtekRhZStBek03aDRiR2d4QUZk?=
 =?utf-8?B?MWc3RUtuTzg1dmdwdGhRbElpVm5SZGRPNjBsdmN1NWE1T3QxMW9IYmJma24r?=
 =?utf-8?B?THhSWXZzandhZmMxUXhSR1JtOFBiNCtUT21oZXZaZ0xXanppR081eUV2emcw?=
 =?utf-8?B?dlFTbzFhUmRxaXA3dkFkUk94dmQ2WUl1WnpNWXRBMGFRMGsyWjZDZGw3ZVB4?=
 =?utf-8?B?dWdURW15V3A3R0RXQWJybEx1NlB4K3Q2YzFLcmkyOXB3VW9udDNISnVOZ2tk?=
 =?utf-8?B?eWN1cDdKS3ZubnV1a1R3R3JmVmNPT0hjWG1TcGlaZHFJSHdiU1lWRkRaS3dW?=
 =?utf-8?B?MTRuM1FKbXVRVmNseTFzVkFmblZOSzN6UGIzaTJKdnc1Q3U3TzlCR3VNeXNT?=
 =?utf-8?B?WitkSmdkYjFkeEdmT2srOE5UUFN4KzZibk1JK2NEcEYvTFp6SkY1ZW1NR2JL?=
 =?utf-8?B?ZVdCblpQZmJBVHBUTEpldDlCclZueXB5MDVNLy9iQXJBaGFzSkxSbmpMNDBF?=
 =?utf-8?B?S1JtQlBSeS8rcVpkSEl6aUpXdlVRY0t2SDJUN0RSNDEzQUdmTklYN0dlZDFk?=
 =?utf-8?B?cnhQWldhZlZHQ3RRY0xwZVM3bnkvYmc5RWQwOWlDazRvU0hsUzFmcU1ocEZi?=
 =?utf-8?B?ek4wU0dFYkdSQzh2Q0lNQitwemR4MTZSNUJ1dFhCNUxobjhYc3N2clhMWDZJ?=
 =?utf-8?B?azJmdkpaU0Zyb29LZmg0am5uRlBqZ1QrcnJieDByZ2VEczZZVVpHV0RvM1RD?=
 =?utf-8?B?VFRUYTkraDdaeFJleExvQW9kdC9nRTlRSWdkTFNRZHR6UWhUUHlXd1lPRm5W?=
 =?utf-8?B?NGdHUzVXL1did3E3V3ZjMFQwa0tONjRyVzFhL1daNm1KODZ3SjZlSFBrNVhi?=
 =?utf-8?B?SmxqcUVDUjhjdTVYZEJyVU51YUZ0MEU4S1lPOTBvWlRXemVHWEZpRXp3VmZB?=
 =?utf-8?B?SEdWU0xRQUpzQzRRU0E4TnRWNFo4MDQ4WnF3VkV6a1hZaWJGRGFrQ3U1QVBw?=
 =?utf-8?B?YW9ObnU2THVRb2FraDVhVXMyU28rd211WG9jZG9McUdxcy9iaWJRNHdESStV?=
 =?utf-8?B?SUtCdHAzMnFyN2NlNTFqUUgyS3g5U1djKzVtUThueTBiU1hjV3NvTll3aEVM?=
 =?utf-8?B?eFY3V3hPaDNtYTdvREJXZEhpQzNMOUk4WEo2MllsY2IvSXZHWDVkK3B2Wmlq?=
 =?utf-8?B?Umdid1VhZitZcTFhUEh6SkVMQS81N2lNcXdyNDB6MDE5d2NHblJYbEp0WUJx?=
 =?utf-8?B?aUZlWVgrSk1VWHlCVXVKQ0tBRjB1d1lTTnA4dmI1SnB4N1p3WXFIR0JKUm1u?=
 =?utf-8?B?RmRmOCtrTnFDT1BWRzdTZit3amwyMFJsYXFka3BHbWhIWVNWVUpBbFppVXRr?=
 =?utf-8?B?TGtGUUcreFY2K0pXdWtTSjRQZ3BvdUNIVGkwbytrZXdicWhUTEtXdkNINS9Q?=
 =?utf-8?B?WUlKbUczaUw3aFRweXlBalA4MVVXc09rVE9hTS9Qek53YnArWTVZa2Nld3A4?=
 =?utf-8?B?ODk4VWt4TXlzQ2N3THNZaUpzSGhpaUR3ZkdncDVVUHRnSU1yL29wNmhxb2ND?=
 =?utf-8?B?ZmtLZy8xZ0pHUmtJUXlGbjFGQ2poWVphU2VwNHBpOGxXeExndjFMSUZmTzEy?=
 =?utf-8?B?ZDZuQkl0L3pLRmE0UlBNbGdLVXhNV21OQUNlM2R5MVFJOUZ4YTJibnZzZzRU?=
 =?utf-8?B?cjRTbWlZRU9KcEhXWkh1b0RaazYrK0lIb2RmeDRqRlZ6amRuVVVHNmRENEtY?=
 =?utf-8?Q?Mr2sFsAXALLPPwlw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 221ee7b5-7fe2-4fa9-b288-08da38e857c4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 16:06:18.6186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 906BtlrcDHD1DKntHed8SQMTN1EKUILAUReCCc1OFOlrqbfE6GovmxB9fqGN9JmPo0RyvChwTH8kDJNyOPln/OM4/X4vP/U2tt8n9uH5MjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4229
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/12/2022 5:44 AM, James Morse wrote:
..

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 5d283bdd6162..46ab9fb5562e 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -15,6 +15,9 @@ int proc_resctrl_show(struct seq_file *m,
>  
>  #endif
>  
> +/* max value for struct rdt_domain's mbps_val */
> +#define MBA_MAX_MBPS   U32_MAX
> +
>  /**
>   * enum resctrl_conf_type - The type of configuration.
>   * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.
> @@ -53,6 +56,9 @@ struct resctrl_staged_config {
>   * @cqm_work_cpu:	worker CPU for CQM h/w counters
>   * @plr:		pseudo-locked region (if any) associated with domain
>   * @staged_config:	parsed configuration to be applied
> + * @mbps_val:		When mba_sc is enabled, this holds the array of user
> + * 			specified control values for mba_sc in MBps, indexed
> + *			by closid
>   */
>  struct rdt_domain {
>  	struct list_head		list;

Please watch out for usage of spaces before tabs to ensure a clean pass
from checkpatch.pl.

Reinette
