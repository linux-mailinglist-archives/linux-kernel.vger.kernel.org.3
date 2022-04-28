Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75812512ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbiD1FPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiD1FPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:15:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0C174DC8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651122745; x=1682658745;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P9Il/z6EQXF1Os63Ot7aQgqmvA419AwLin21d0S+VKc=;
  b=XgIqfnLO5PjtIl47Qr/+s4HmrsdxM6+lRUKQtvU5uZ+eE00iu+GPQB6E
   hYAnRrjxq9ExNYC811N2734aPlc3AKQMLqn8Xvg24k/lZ/wtPIUOV4p3b
   aUcyNN6ZoEYt60maDX4ZMNgX0P2i5xjbGBVEOgajWquqBouEayIk1p4QN
   zNcO1Abq6CBs8nIaQR9yvb5jCBQD69tKcQZfAepgj4h/ReuP8Gg4HaXg1
   KIqb5XON++8Hw/wO0qy6+QOO6hPGUDnHw5eBCE+DzB4CRJQzEpTqDWS/O
   nzaWwGBH8vvGp2CKx/MkSsBRdsMS4FmyBVFvOy7fsb/uHApwJHURGWlAY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="329107056"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="329107056"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 22:12:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="629362861"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2022 22:12:24 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 27 Apr 2022 22:12:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 27 Apr 2022 22:12:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 27 Apr 2022 22:12:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idqbbjRA2XTfydvlhSSy9c3hOzO9Wnzv8B1Vbt5hsoaTO40MKA809AjWbLgASZvZ1W38jNg6/TLujrGbZqpmUep7bzw7iH1yDFNUGnDFgfEkWI8JOEj2lg3tPEuMMaAenBES3HKlT5LfrZLVmKxAnFm4DQlcPqb3a8qT7WOrkfkXK7xRqnlGL5IQhKI6mc9y86JBRSCbjSPapZq1P4YCubSSx0p/TlLXLHWhLLvz2zb9JYKNrhqumoPeC1xMxsIvknKpBcEh+6hk/pw125MIAGwNPnpwISMsA8qR8yD7Q9tP62s6NntnUZcov2+Za9U8lKVZ7NDl/zFqzkTQPLw8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I22rzyfdY/nGD8iTd+PfpdMrkJJpuZy9ATqmCuuIiCY=;
 b=hJhATz72exgUe0WgS4Wn2xjVVmYf0k5tYmDJpQpV7XkYFd7kl6VehriC1uCJNimqFA3qUoyCfeP5Z/wzkXJtnS7oqIZpGMtceQpv6UMoI1g7rc2E4nS/uHQ1Gq5obk5LyGuIkctmw7Jv0n/bQABME8iFWQIzWP/oDQ6qa4tRYVMjUpXG5ZXmfmrKd7xdp2df5rrgG2Ki19/upSoN1V0icQ+sMmtc9GjeRaWQSvfkDlZnmOfAzEE9gX3xIUgVLcl+VDqJPavA0sFuidKnfrlzVs9DUw2wOzsH8G1YjwHr6XbSZKM0Fuv9lO1KisITWO69fe1Zod9ybcDHwppxmi1eAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MWHPR1101MB2365.namprd11.prod.outlook.com (2603:10b6:300:74::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Thu, 28 Apr
 2022 05:12:17 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2585:f5e4:9eab:5fdf]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2585:f5e4:9eab:5fdf%3]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 05:12:16 +0000
Message-ID: <54bcab1b-2c39-9052-2bc4-4a779fe7b27a@intel.com>
Date:   Thu, 28 Apr 2022 13:12:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [memcg] a8c49af3be: hackbench.throughput -13.7% regression
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>
CC:     kernel test robot <oliver.sang@intel.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
References: <20220420055807.GA16310@xsang-OptiPlex-9020>
 <43598597-72e1-6750-9bee-031fd463fc3b@intel.com>
 <CALvZod4_vNWYxzGR3BksZYgoti-9hOioMGwF2UVRnwcAGpFqXA@mail.gmail.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CALvZod4_vNWYxzGR3BksZYgoti-9hOioMGwF2UVRnwcAGpFqXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR02CA0215.apcprd02.prod.outlook.com
 (2603:1096:201:20::27) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a476a8e-f4ac-414f-9401-08da28d5a995
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2365:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR1101MB2365999F0CC54B3664F7B44EEEFD9@MWHPR1101MB2365.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXMc5wdAP48Yt4FT6qkjdsKaYnVfTzDw7d089fY8s9hbSZ7M/MVvpkLagniAcarnbJdiZoDT13D0zo8E5Gfdzpbn4xJzMDLb0QfudN/4tJ9r/qXCFlHZYec6NWbImV8dvJb4IFGXB6QvBBvM+I6KuiA3CkfMiiB8SL6J8n8bQMO0PjN7+Zv1vlGFgE53moAci7G5tQLwPxlAVgNyjeMiGxDyt1SVtnS9rjnn974/45ni8EiELF3Y6l80zs5ewKesvniAnx+Y6MPIYbbhESU6caQUSa69dSfhVIMZ9ip7Dyxk7O8NzfZEnvFCYXToEzINS8z4zy2mqj2aixjDn7eb9mhzhTyimnrFx5GRAEro9e/WkBBRChzNZmuu1eg3RFlt/OxOUG5PSrBx7NwgRmx+8NQTGLszWA43/VSoFvJ7H2Hqxv22qjyt7oEKWO0+zrtMWYe4QimA5ZJdZXgtNJE29IRZV1Ig/xFojGI9eXokCN3dieU/BlROoLBUfWldX/HaBPOqmFvvK+KWH3GmwLC+fCkyBrEtKUreAonZjCtKCYNk0r7dWt/2BzKmg7J/KToz0FLDD5oFi1qV3UR8V2EmQBCU+QKZjH36LZ5pT5XgznDNtEaRSFxisRJkTPH7HiMO6sC0yJnyLOaqKczk3o9EemHQulMGER7wX49x983ihk4D8M2NaYJG2fULre8xdQLDcktL+smI1qWFhctVptLL1lLXvjC+qtTQ69ehE35BDBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(6486002)(53546011)(8936002)(6666004)(83380400001)(82960400001)(6506007)(508600001)(31696002)(86362001)(7416002)(186003)(6512007)(26005)(2616005)(38100700002)(66476007)(66556008)(66946007)(4326008)(8676002)(6916009)(31686004)(54906003)(36756003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnBid25BVlRWY0UvNXRXeDBFVm5RcTFjTVorTllwUWtsV3FkaVFPRDBOQnhZ?=
 =?utf-8?B?a0loZU15YWh5UG5xTXRzaU5mOEtFOHhjdzNEODFvbWN4MjZ4dHFXazBCbEkz?=
 =?utf-8?B?WFlyZEdmajlpcWpJU1BtR2QrenBJQlpEUlJ0ZHpza0RVSVcyQ1F2d1ViUGVl?=
 =?utf-8?B?UE5oWEV0MzBNMUNrWi9NeTlKQkNDeFZzRnEwZElLSzNaTktTbGJLdW16K0Zr?=
 =?utf-8?B?b0pLbzdVVDRyRkRXd2hzVmdKeUVqMnpZeTZaTXdObjJMazdNVzFtMCtZamNl?=
 =?utf-8?B?K2ppYjJ4bm9aYkR1dVRPNEtFRG50dUNRMUF5bldGYytOajFpUUdnZElldGVV?=
 =?utf-8?B?OVZZTGZ4NlQ2K1RwWkNQRHFtSUdZNjR4NWVlQTMrMXB3di8vcEdQNTkyeUdG?=
 =?utf-8?B?TWtSckFrS1l4TGJkNlFkcXZGNXBaVTlXZHZhWjhlRUU5Zm5IWVVTL2liTnpW?=
 =?utf-8?B?SC9BaWZXWmE3YXRDdUI2U3JEMHNCSUllMjFsWno3Q0tpeGxyektGVkZwa1Qv?=
 =?utf-8?B?M1dCcUhydFBvTkkvWkhKR1RRKzZ3SjkxcjdCeDZPTGtaVFZ5RXJGR2VvYmFv?=
 =?utf-8?B?QXVqRGFIaytkb0J4MkxUZnlPbWFGclEvSyttUFQ1enZ6RXpObzlNaW1ZaXhJ?=
 =?utf-8?B?c2lNdXF0L1MwUm9kTGpHVG5XQ09raDdYWXNxSVo0cDB5QW9sUENwRGFQdTh3?=
 =?utf-8?B?enlOMDBaS2RGMWNhbkVnZWVLTllrZnFRVWxETDZySG1BcmdocVJWRjlwMHVq?=
 =?utf-8?B?K3JYQ1pRcy90VDVwK2pQOGJmYk9WZTU4L2Y5WmJhdHJjTlUyaUdNczkxVjJT?=
 =?utf-8?B?bHhyajJxcnZPemtrcTNSQmRZY1JFYjhsRkpIQXJRK3ZEVVA3MjJhZUV5UUxh?=
 =?utf-8?B?cHQ5WjlZejZPQ2wwK3pFMjlxU0lScUY4VnY2cjFJWENVZkVSUzVObG9maXhG?=
 =?utf-8?B?cEw1UVdaTjhLdDZ1UGlSaG1wT1A2WjdJdlUyQ3BxcWRKbkhWRGNiYUZJU0dT?=
 =?utf-8?B?NTFseVJtazRWMTJDYlFoV1ZHVDNnMjhXU3pFc2o4MFVvM0hIekZrTDhNOFVQ?=
 =?utf-8?B?azVQUDNRYUMxcHJEYTFiSytkeUk2OE5mbGQ3ZXVIWWVnV3B2ODc4SGU5ZUpi?=
 =?utf-8?B?N0wvODZDVGZwVnlVK0Q5c3lpd1JlUzY4NzBuS2hCMVlaNzBwcERheHc4MVVi?=
 =?utf-8?B?RFdySElEbDhic0J5RHZSSDB6K0V2cFl6bHhoaysrTFREUlQwNmU1bFlwUXRX?=
 =?utf-8?B?RmMxY2NNaU5iazhLK01UUTdPckR6NFJHS3NBa1FEejQzVGZ2c1lzSWhLSVVC?=
 =?utf-8?B?a05BQnNreEI5L2FUZ01YZFdoS0JQUGtYTW1wTWxibkR2K2ttblBUVCszNjNE?=
 =?utf-8?B?a3B4YTVxTkdaaVNMaE10NEFFOFRoYTlwQnFreUErenVkN3dDbGtOM3E1clFR?=
 =?utf-8?B?b2NrakhkQkNXeDZCK3E2L2FuNjdIVVVYdGVNMnk4SDZ4b3hGNnJIL29jT0c0?=
 =?utf-8?B?RkJVbHJXWWZJMkxRbnVWTDZVZ2s0TWs3ZDA4SGRwcS9ITG50ZlRxQys0SlQz?=
 =?utf-8?B?bkxmQ2dhTDF5a3ZNZDI0K28wa2FzSU1yeXpteFRpNnVVNURjNWtvR1A5ajZ5?=
 =?utf-8?B?Umc0QkJxeUcvS203cTczMEgwVnBWYXF4aENReDM3YjlxcEI3RUdXODBoeUFr?=
 =?utf-8?B?eS95VDZBVDVPZ1JlaVFvdzkrSUdrTDVmNGM3azVUMG4vMVFYakJKVy80WnVs?=
 =?utf-8?B?ZS94UVRYbWhWOUV3TnlHd3RJSzNsMkdOYTMrZnpxalV4Ry9Bd1ZTVkN1alh2?=
 =?utf-8?B?Z0tuMEtocm81SXVHZ3F3Q2FkUzhVblJNM1ZUM0NWSjkzZlp0SmFycFJvbEtT?=
 =?utf-8?B?cXluN3dEYTR5anFEMTlVTjNDVlJuS0NsQndPclpaOWdSaWpGMmtvSUhOZERx?=
 =?utf-8?B?QTNtNzFOVWVueDBhbUlwOWZkd1EzWFl6clRob0hmU3FWRndWNm5lY29lK2pn?=
 =?utf-8?B?SERhNHhYYW03M1I5Q2k1a1VGbGQ0Y1QvNU1TRE92a3h4OEM4c2Zvd0FlSU1Z?=
 =?utf-8?B?T1BTU3hhNlowdUV5NWZiYzZtUHU3U1RhTDJEbGNxd2pPWGU0NHRRVGxZNjFG?=
 =?utf-8?B?V21pVzdzVGlmR0tyTktObXBhamxzYzlYdTVjSmluQS9DYW0rekI0dkUvYnBI?=
 =?utf-8?B?cHpHRGtrTG9CTlg4aXd5aTArTURGQ3RpS3R0Ny9kbUVMb2pOMGZWQ2hMaDBk?=
 =?utf-8?B?N2hialNoUndpYjl4VmdiK3FJRkR2aWdpODFyUmV5TXF2cmRLYzMvT01sWWFQ?=
 =?utf-8?B?UTFHMm5Sc2pzYWZEcldXYjVSUmFlMzBFMjNUU3pGbXBjSW9oNEE3UT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a476a8e-f4ac-414f-9401-08da28d5a995
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 05:12:16.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfs+NOScSet+hMFe3YU3cXexskbNhqoTtTJw/tY6oFeAluD2s9TAzx0AEYYvXSDg5MyN0x6YZT58vRPorocn+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2365
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

Hi Shakeel,

On 4/27/2022 1:02 PM, Shakeel Butt wrote:
> Can you to comment out the following block instead of the above line
> and see if there is any impact?

Changed the code as following:

+static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
+{
+       mod_memcg_state(memcg, MEMCG_KMEM, nr_pages);
+
+#if    0
+       if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
+               if (nr_pages > 0)
+                       page_counter_charge(&memcg->kmem, nr_pages);
+               else
+                       page_counter_uncharge(&memcg->kmem, -nr_pages);
+       }
+#endif
+}
+

The hackbench test result is 147% better:

086f694a75e1a283 cee08cab8eefaaffdec62343e8d
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
       8691:15      -52942%         750:6     dmesg.timestamp:last
           :15          13%           2:6     last_state.booting
           :15          13%           2:6     last_state.is_incomplete_run
          1:15          -7%            :6     kmsg.common_interrupt:#No_irq_handler_for_vector
          2:15         -18%            :6     kmsg.timestamp:common_interrupt:#No_irq_handler_for_vector
       4656:15      -26039%         750:6     kmsg.timestamp:last
         %stddev     %change         %stddev
             \          |                \
    143619 ±  4%    +147.0%     354807 ±  2%  hackbench.throughput   <------
    475.91 ±  4%     -58.8%     196.09 ±  2%  hackbench.time.elapsed_time


Regards
Yin, Fengwei
