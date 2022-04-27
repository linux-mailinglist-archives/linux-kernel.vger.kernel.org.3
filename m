Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D41D510F05
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357295AbiD0C40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344270AbiD0C4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:56:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFD111D230
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651027992; x=1682563992;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FewiTNh+vA1o3MePu8g265v078i6detT9zAiLHdMuXY=;
  b=LRErGCzO70K76VIfJnGS22mQVvSeI6U2eYvWxIiQEtTJek/9+aq9ET6u
   tGPaQE0HmUBCWMvDntG+Kdwnz2fDbWgx1vussRlt+lshNYWcfp7rpRIT0
   XaNxRCz/I/QvEAGm0PIec+5p3A7pP3CRpItehnawzoO4QL6cR9KArccfM
   LCQgOPKrsSXFp+vCNo6GdI9O6rceJKi91WNFe1UXRnqRQxut8U3kuy9dH
   caGpG6pZIt2ew8ujVg3cgNfR09Jqioh2mlOihB6Po72CoJ4Y1X5+oRCB+
   VPa4UkJzJ3zQ1CsovA7hockO+VEOeICpJC/5Z8hZZGf6AYjqal30UXmt8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="264638907"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="264638907"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 19:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="532980526"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 26 Apr 2022 19:53:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 26 Apr 2022 19:53:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 26 Apr 2022 19:53:10 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 26 Apr 2022 19:53:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRDFPV70P/C2h/90wz5yV/fr3LFVz0ZaJwMP4Ahubsxp/zqiROez0CSKLYHM2KNCAx/eIgyOty1kU6iE3KGF1kR0TBkU9v6HEQzTFbK+98lu6HwvGQ+wQG+uZdVUeDKyJ3TlfgJWG/2DTzDI6DP79qDRjNGdqoADg49xvn7DvVgUBGeQapC0hIfyon1hWNPNR9CBdI2+ToI8KpZyXz4sunYQmVV/DZKX2TOCu+Qm004sl5ErcYrPGYSALbQcP4hiabL/HX4LERja+F6ZA9dBUgmYC7xZ0/Jdzht+tuXpjHs9u3Gv9Rz9UF9LPV5e1PmJfH7bcQPBkEXWs47Q4VZi1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnzHvbRv0Sc53ivE8Rq86Pmi9QLCQYEtz/tXAHael7w=;
 b=nOKSoPk2E/fMEzK6tx9UcFl6ke2/8DlhsJb+SMCCYJ44k0dP+h576R22y1A5+W0ozQJH4lB+0VzoFnqrpyyo9JTFMF1uFBEaysnAx9sM3RjnQ6eSvIeCENzmkN327HOo2IOSq3LqM0aqH1JwIvSw+AGGPdYBAHWXX7Dn+nc6uGDGSGTI8QBqxbM7StfwGFBuRr9jBK2ExQx/0jcGJvAHqhQ5FiQkwjRtHmWLyLNqS404kEJtVrZbv0/RlbuCfXnvHct7aKDMwUFwRCQ+PnEjE6x9p1+ucPYME+9LsSb7rk3lEHqWWr2RHlC8celwEISR9tpBLCyOsh5L9bLCdM+Y2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 by BYAPR11MB3701.namprd11.prod.outlook.com (2603:10b6:a03:fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 02:53:08 +0000
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::100a:9eb5:3716:c6b1]) by SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::100a:9eb5:3716:c6b1%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 02:53:08 +0000
Message-ID: <43598597-72e1-6750-9bee-031fd463fc3b@intel.com>
Date:   Wed, 27 Apr 2022 10:52:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [memcg] a8c49af3be: hackbench.throughput -13.7% regression
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>,
        Yosry Ahmed <yosryahmed@google.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>
References: <20220420055807.GA16310@xsang-OptiPlex-9020>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20220420055807.GA16310@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:202:2e::25) To SJ0PR11MB4831.namprd11.prod.outlook.com
 (2603:10b6:a03:2d2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7015f1d-61d7-413d-5275-08da27f90eda
X-MS-TrafficTypeDiagnostic: BYAPR11MB3701:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB37010B959226AE34C66EF829EEFA9@BYAPR11MB3701.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwJY2K8pWcqgdVGtjIQ1dsa2krVBECQhPLfWjTJLQWjL9ed73KGMPEd6UUc21+d3IHf2bAphHOxJvHGOJ7iam5Q7wIH5moMYFecI4Ry6Ru4tKupLPfrD87mDd8LSD1NuKST67l39aU/l3PIpZD39q9IkKdACuatmAEwhAOeNQbGlkPDTdOD5VwTXxYGFo1SAxcZcfUDKBy9d1i6YTgiivrPLv/LwUCpWLTwm76ctksHeYhNAxWHetBv0aX7MNidtVcCw18syO6ZMGaDLC3vTAk4FSM1jafOiksMu0BuoPVDjsDR3Hdmk9lMqT9Rwx2wCIoPj1Bh5RpdiGx2HvQbN+/T1zj0I94azXUvT3O2a7WP3CPYJlPz/DCn8B3QVIV+7DypoMXyoWqOtNxpHPtriBxAQviEENsBl5uMBaykw5U4G2xq5gh6MNVDC792JHK/oOK1OIpKhyMsOSqHMrw2M4vG3V+inxsP+qztiKvURnMLuvX5WtZRNoL6MJFudy3NhgB20cosSgb/JJLOOSW0uR+dpA+uwJMhZWiXoO+Ibsu6VYVxnKILFWqcoGOSPY7SxPRiDBTfmlzxWP22PR2/gALjiN7kVQenDK4xU0DdmIHEWRXuLXjbCmL7XZAKoOrUvVouwkiRkzSHDLQ3XhaL3VzpWSh5B/S9b+3FBWrYxc4ZUzAdX+WoKUt+zOsCBir5M3tG6PZfLRFibBIk4YF4P8NANDkw6H09Wcba537/OpquAFh7SgtXFwEYYgJ8jBqrWf944dhi1QVW9NRP1MY12dBB2K1l013IATrk/CImXUILuh4Ex9erC8kwWPGBSaa9haOSH6XI9zWnjWavgMIiroCTnMxqOjH0JSQMhJXb6/Oo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4831.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(5660300002)(966005)(36756003)(66946007)(2906002)(53546011)(316002)(54906003)(110136005)(6486002)(508600001)(82960400001)(8676002)(83380400001)(31686004)(86362001)(26005)(6666004)(6512007)(6506007)(7416002)(8936002)(66556008)(66476007)(4326008)(186003)(2616005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmdLVG1XOGRFdWV3bitJKzhMWkw3eHhXb1gyUWM3Z3VFZHJtVG1qWTl2aVdU?=
 =?utf-8?B?RlJsNnJUcjhqZ1Ayck9PUVJQR0gxQVhMa1FOZ0RVVUhTVDFNanZ3dUpnV1U3?=
 =?utf-8?B?endQQnRHQVUxMVhSZzZSMTZQSUN6SVRuellvcS9VOWQwWUd5bFFUMXh6Qks2?=
 =?utf-8?B?eW9rc2xKbUNxNzBVaXVhL1IvQytMc3dkaHhGMzhjWS9TeXRKeld1d2VXSXlM?=
 =?utf-8?B?MnhxQjhtOTB5STE5aUluSEtCYzJoRS8vM3AwRVphZlNmUGdFYlRpWXFrSXZX?=
 =?utf-8?B?MHdIZjFnN29uWE1EcWFKNm0relZ6MFg2b0NXSU0ySWJ3TndUeGprUDRiMlBB?=
 =?utf-8?B?T3FyaFBnZVplUWhkMDlia1E5RkFVSWVkSE5hdUdkM1QwQ3I0TS92RjNuK0VQ?=
 =?utf-8?B?T2R1T0dxeXB1Z2YrekRrSUtBZzZjTzdIaTZDRGZ6U2c0U2VLdGpqZkpCT2tP?=
 =?utf-8?B?eDZXMStTZzZyYngyUE1CUnpTSVVSdGxhRnROOUUxemZZbTZnVlBhcnBlOEhz?=
 =?utf-8?B?K0ZRQzNBNEZVaWR3dzdQZUsxU1JPOFU0bXdVNmFyZnF2NXdPcE9PT2NrcWxj?=
 =?utf-8?B?d0xmT0VNUnhWSzA1aTBtQjBNQkRHNkV6WjZNVDc0cWVTYVBPNEFBZDhqNlJx?=
 =?utf-8?B?TWtPRmNtb2JnZDB0Z2Fjdit5VnFJNndOSy9OckVYVjdsV2laYUFKa21pMzZi?=
 =?utf-8?B?VTZNakZuL25LNExLRDMxYUdLSFN3TlZ5VE5tT0dwMzN1SlMwT2w4TFpOZTkr?=
 =?utf-8?B?YjQ5M2p4UmFIV2FJS1lmaXRrWjlXa2g5ZmJUaTlWb1FrRlE4TlNBVXJXK0hn?=
 =?utf-8?B?OVB0bFkyb0RYcTRGQ05pSXErd2Q2emtEUnM5bFVvVTE4eHVrVXFkWTNNOG9t?=
 =?utf-8?B?TU1rdVRCMFJEQUttYXFZRENUbStYdmhrcTJTK1VnK1ZNT1VFQmJRazNxUnVD?=
 =?utf-8?B?ZGcxekJoQVlncjJITlk3MHh3STY2SVRTM0NOSGdBditqSGMwYmYxSHZLRVZs?=
 =?utf-8?B?N0JiNE43NXprc0IreVhCR1RJMzBXODBDZ1ZPZHlDUzkxQ3dES0psLzlvWXlq?=
 =?utf-8?B?d3lXVnZja3hsZmxxUCtrYXFseU5ZYW44T1dFRnRoNFJKdDNmek52cW5JQVJN?=
 =?utf-8?B?b3RpdnRQem9rYVZzS2V3UGtLVkVEUkhNcnUycnZ6TFp4NTlLWVNIczRLbjZo?=
 =?utf-8?B?aGllYVU1cjRGK0N3d1didE90Uk9TbWtXUDNiYWNNM0twS0JkOCtGUmF3cFNn?=
 =?utf-8?B?N2V0RFhhQ1MwNkljOC9xb3Vmc2tiQWp2K3pWRXFkSVY2WnNKZ2FvdDFNSjB4?=
 =?utf-8?B?bHFzUTZnL3dObldtTVErZmp4UHZuVGxuVUQ4Z3o1d2lZMkExbndCYlUyOGRo?=
 =?utf-8?B?VWcxdXZia1drMlJteFd1TmQ1eEt6WlNtM01rdVd4ZmpxSkNwei9PU21uU1pm?=
 =?utf-8?B?VkJQMlExYnNRanJsTjBQS2wyQWNIeEU1a0NyR2pyTk9YbTNWejMrMDFkZk13?=
 =?utf-8?B?Slhxa0Rxb21WZlRNWjRQQXE1MEhCUWNDOVJRK1lUSVdPVlBIaEtJMlJrS0hL?=
 =?utf-8?B?MTU3V2l1YmxEYnNrOFR0VnJQYTNtbHpSNG45UjdRQ2xXZ3VLek9mMzFYVDJQ?=
 =?utf-8?B?N2wyUjBuV1Q4ZmUvaFhhR3orN1pleUwxWGc2U3NueGs5bU9IMTQxblNIUU5O?=
 =?utf-8?B?RjNrTVpUdkhJeGpDQnhSdkV5ZlNuSXZqc1NnaTNUbEhIbDlOUXBSclZTSTd0?=
 =?utf-8?B?M0xlMmdNR2duVjFWanJKeG1yWEQveXlKUEMwTk9rR09YRDYxZFdBcmZUVlFD?=
 =?utf-8?B?dmlGaDRGVUY5aVNqaU1mT01qaE1HbnRwdWsxZGZHbGxlVmcvYWdaem1lOURN?=
 =?utf-8?B?Vnp2OXgzTVBGMndmaExvcWRyS0hoVTVuTmEvOExnREFMUDBSWjdOT05XSDhn?=
 =?utf-8?B?anpHc1lqYnBSMXdmdXB4eHFWakhLUmNEK1Y0MVlZNTRUVWNJME9sSTFCRXR3?=
 =?utf-8?B?bFdkc3pMU29vRi9oV0dhVWtPdEwrOVBickVqUitUVHNxUmk3MkVwR3p6ZWJX?=
 =?utf-8?B?YUVsRndmNFdqOFI1cHAzdHAwWVk1YU5OZENuR0paaWI1RHVzYmlsT09Md24w?=
 =?utf-8?B?TExFQjU4dXhsRHdCS2pCdFRwTDduYWpBV0d4NUt5UjB3ek8xMUdremtOZGl3?=
 =?utf-8?B?SFNPRFJlQTJmcHJNaGpTRks5NU1jWU9BOUVYbGZvR1greHJhTFEydDFCT0NP?=
 =?utf-8?B?Ym5KcEJIRGRyVXgyUmFxMDlySks5WnNnUDZYOFlTWi8zV1Jpa2lXRXcwVi93?=
 =?utf-8?B?OW1oVHQ0OHQ0V0FtazhweWRCVnZGbWdRWXFuazFxYnZ4OHFFalhwcGdtdi85?=
 =?utf-8?Q?Z8CCKtQQoRj3zRa8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7015f1d-61d7-413d-5275-08da27f90eda
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4831.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 02:53:08.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrDyzoN9FhYhShqMQxbs0wfUZoEV1cSRyt+u4mdtaSscfSdSD07c01N8JAwTyMJo6nN5SmqNPzA1Y7q7WP7cOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3701
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yosry,

On 4/20/2022 1:58 PM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed a -13.7% regression of hackbench.throughput due to commit:
> 
> 
> commit: a8c49af3be5f0b4e105ef678bcf14ef102c270be ("memcg: add per-memcg total kernel memory stat")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: hackbench
> on test machine: 144 threads 4 sockets Intel(R) Xeon(R) Gold 5318H CPU @ 2.50GHz with 128G memory
> with following parameters:
> 
> 	nr_threads: 100%
> 	iterations: 4
> 	mode: process
> 	ipc: socket
> 	cpufreq_governor: performance
> 	ucode: 0x7002402
> 
> test-description: Hackbench is both a benchmark and a stress test for the Linux kernel scheduler.
> test-url: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/sched/cfs-scheduler/hackbench.c
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> =========================================================================================
> compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase/ucode:
>   gcc-11/performance/socket/4/x86_64-rhel-8.3/process/100%/debian-10.4-x86_64-20200603.cgz/lkp-cpl-4sp1/hackbench/0x7002402
> 
> commit: 
>   086f694a75 ("memcg: replace in_interrupt() with !in_task()")
>   a8c49af3be ("memcg: add per-memcg total kernel memory stat")
> 
> 086f694a75e1a283 a8c49af3be5f0b4e105ef678bcf 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>     146519           -13.7%     126397        hackbench.throughput
>     465.89           +16.0%     540.43        hackbench.time.elapsed_time
>     465.89           +16.0%     540.43        hackbench.time.elapsed_time.max
>  1.365e+08          +134.1%  3.195e+08 ±  4%  hackbench.time.involuntary_context_switches
>    1081515            -1.2%    1068489        hackbench.time.minor_page_faults
>      64911           +16.3%      75465        hackbench.time.system_time

Just FYI.

If I comment out one line added by the commit <a8c49af3be> :
static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
{
        /* mod_memcg_state(memcg, MEMCG_KMEM, nr_pages); */  <--- comment out this line.
        if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
                if (nr_pages > 0)
                        page_counter_charge(&memcg->kmem, nr_pages);
                else
                        page_counter_uncharge(&memcg->kmem, -nr_pages);
        }
}

The regression is almost gone:

086f694a75e1a283 9ff9ec89a6dcf39f901ff0a84fd
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
       7632:13      -44932%        1791:3     dmesg.timestamp:last
          1:13          -8%            :3     kmsg.common_interrupt:#No_irq_handler_for_vector
          2:13         -20%            :3     kmsg.timestamp:common_interrupt:#No_irq_handler_for_vector
       4072:13      -24827%         844:3     kmsg.timestamp:last
         %stddev     %change         %stddev
             \          |                \
    144327 ±  3%      -1.9%     141594 ±  5%  hackbench.throughput
                      regression dropped to -1.9% from -13.7%

    473.44 ±  3%      +1.9%     482.23 ±  5%  hackbench.time.elapsed_time


Regards
Yin, Fengwei
