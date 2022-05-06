Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7A151D762
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391689AbiEFMVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbiEFMVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:21:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F334F445
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651839446; x=1683375446;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4CMcFB0j7wkTvwvKUn0VshkCVd5KTxBbJ+vcJ0OCSlU=;
  b=kC5wXWYCGQge5XR711wCDskD1n2c25ltqzPZdtnBUcJKKEHWtTWNu20s
   jkTJqCvVbGeLs7IBBtf4N/TpRtQlqmHKCoHBFIopNBp2KFeTKcWgin+AA
   hZG6egVrl3ke56nj+jYBEP3HrANCZ/uwyCzNfrkbPk1KRd5IiiE8w3C0L
   yuxRQ8hu+JoH4ZQRdzW4uyj91AQKLF1GBiR3beepRh2PQOXsmFy1/4HPm
   0ee590YxTmqnupZ2LlIMQUCfPcerscPi3uz0wyPe6YbhwyqfQ9AeQJO6R
   W7JVHqP6TYIsLWNBc6mf0wvTK8SHaPfFNWiXeAT1X5inUE5BUYzgLHgQG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="328996636"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="328996636"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="812368339"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2022 05:17:25 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 6 May 2022 05:17:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 6 May 2022 05:17:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 6 May 2022 05:17:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RilQUrQvD1qvTm+Q+tg2D/+pGI/jVNys5CCPS1wxz8VMxh762htBa3v7DJ7Q1ltf4Ivgnaode0hx9DjKPDYC+1hzVeKTfBub+9wlIgylDX+Xnx3iC8bAipqRm0DFFN3Q7Vbb8oAN8zQDwnWkMjkunZaEy/FtEwGF3dFgZDTdyIdJ9DUGON/XvfZTRTTsgh/jE0DXxTdnxO1F+Mt7s+JN7Eh9W1fGo48O6n0yg8ZkB8F4OUjjYejfmCyCoMS4iv8hfAB85dXoPb9x+lTDT+RmrYfztusEEIrdIulT4GbAESjg7qA05iFARaAXwlXpSVE+EiYuRAlQwuUjTEBrTYaJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP4EcVwdqc/1bqc/ac+yOvji7HTCrTrYX5YZ21SUc3E=;
 b=HdTNQoimuxzBAB7uXtHhKH6DH7mysu31GvL8fwSh7KysWRol4vVhnyKaOj6eEkvoTVM5o8VOguLWCS2T31gS83qVZNz8lFs9vA+KH2QjO6B+G4D+cx8OeWj7lr1/asuJJB6QbsWjHXphPAGmD4WUrn+3cHDpBGDx4gpB1/e1HwM4jXKTF4rvhpeisuQtIDZQccTceibIiaPrRkFD8vWw64BbSRWsYt9kUbxVRzSlrlPuLIh4oiAB+ZvIGzPETEJm1TPK9AEVdaMPw5xBzpMMLOaiFOnpqmWafXpMrsv5AD72yuztH+EMlGbNuGX4sn9TsjLKiKzgs0wYmh/eLmfQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by BN9PR11MB5274.namprd11.prod.outlook.com (2603:10b6:408:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Fri, 6 May
 2022 12:17:22 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff%5]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 12:17:22 +0000
Date:   Fri, 6 May 2022 20:17:11 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     "ying.huang@intel.com" <ying.huang@intel.com>
CC:     Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>, <fengwei.yin@intel.com>
Subject: Re: [mm/page_alloc]  f26b3fa046:  netperf.Throughput_Mbps -18.0%
 regression
Message-ID: <YnURx04+hE0sQ3v3@ziqianlu-desk1>
References: <20220420013526.GB14333@xsang-OptiPlex-9020>
 <YmvMDyx05UoPFtQy@ziqianlu-desk1>
 <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
X-ClientProxiedBy: HK2PR0302CA0011.apcprd03.prod.outlook.com
 (2603:1096:202::21) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bcea116-5250-487e-8f59-08da2f5a5f9b
X-MS-TrafficTypeDiagnostic: BN9PR11MB5274:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN9PR11MB5274CF025657EED1EA3F99788BC59@BN9PR11MB5274.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXQ5ficI4xnOUTg7GeGFPQhO0njO4M1trJkbRkAZsM7/CSgJgGZxqcJMWcRNYh6lzidUa/8w4dOEWXSwS9nhR5GX2BINhSZXJg8TE1Zn9gu/hvc7DHbWLX+sIq0QGd+rG6P38YULlO85YIpwKkniQ9Tg4l1DpNghMKqP2vlUrGfNed900bkF8z1HjasXL/yZIZGaoBkIB6T/e8/MFI0LWXkx32iea7ChL509gSiUnWsaAVVR122aZubwxnKEtFoDltOVFbAWWaXp+cUeUP+qApZf2IpECsqf7ZLFyfTLOdKqBpPrbCsnzzDQTtm9hhy8Cyy22X1pqy602BcvoLmNB9Xroq+QdC/LBDYBff8DRvFa1et8Rxp+yXJiLzAFc81q86xyLYzEUnV0Tt0R9T5XWR9Gezf9fOx+16H2KQbgQl3h/xy/OSAtG+u8+MKnhTdLTmMKC3OUHGV+t00Dv5zakJVYelPnpmUzB/pBxf81hccTue2dTD/yPxBDXnLwCey4G/Mb4tgsn/y1kSF7tkb24z8jmE0YyGtQSvpDFMnYNalQQwc+dMgzOxS3AE9+bgMM5iPdEf3QRBMFHBuYwt2q7IWuo25iFT1Oe77PyQI8k5zlsHfsb4r+veO8NsOsSzEeuZa/TiUVMKY2bvseDCGW49IrSlQSQVmXbrayl+TKvEjDAqsfTMhnU0eC5OaJ44TMLQZe2hrj5AftP/Bnb5V4XN3Ssy5AcsPr+0oI8e4H7mJuY4PeMuOPGUx6vH+MRCbKQ2DRlBmiUFhdxn+gYrVOeKLFM3/8N6QnQ0tPdLu/CpfKzNitosvraEbZn7qw3B1d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(508600001)(44832011)(966005)(6486002)(7416002)(26005)(9686003)(6512007)(86362001)(6506007)(8936002)(6666004)(2906002)(33716001)(82960400001)(4326008)(186003)(38100700002)(83380400001)(66946007)(316002)(66556008)(66476007)(6636002)(54906003)(8676002)(6862004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sam6itOpdkoooafonguvAjVOHTEHxsAJelumSGByBs0C70mbnFs3wm1YRu+F?=
 =?us-ascii?Q?IvoWDlAGReLI41XS6lY1dVvETE2s9eKLJRjpFsbAq8hYp+I/EQ6zhFOj6mHe?=
 =?us-ascii?Q?Kup2p3IXOPt3xYrG4+fR9Fj1WSTAo6NvIW3kbT0WZVYRiqr0EjG0hHpWR5+z?=
 =?us-ascii?Q?rIXdDNwouNrysKrQ8OFv3ADbWhUrgfTMwK518PABELa+J03QsCmTQpKk0ca6?=
 =?us-ascii?Q?CrtHC4w2wmBUgWgCmCtWTDRiOAXiGVhI7KeRd0E95aytPuqf9Q3xBgHLz6IF?=
 =?us-ascii?Q?Mmi5/TVifqIbG1bTYgm+AIopBfCOyk0MeqqLL0zPJPoE800I+xs02FYRqp9a?=
 =?us-ascii?Q?Z1yQiVLBIVCXvelqFhugtST7DpwQodSMVjeCzOIL9Siyp/KYGh75a6J33Ob8?=
 =?us-ascii?Q?V6oPcmWQGe69nWHNMO7rbLsjQygHiFDja6fXvfYLokd89i61c/x/I79QeYbB?=
 =?us-ascii?Q?nfu3GZCkSacAX78UeCNlVdOs6t+R43VL+4tXBFni7JxFs3xaDn3UBQo3NUqy?=
 =?us-ascii?Q?QYX/rRlAfoB5zrjEnti0TUTGwdLiWAWgYMn0D4tLpLmW+lvXZ40wQO9vh/1K?=
 =?us-ascii?Q?8Xda7lJ4vIr1eSfZfE44gTHRTijTdEOW2bR/KBuCi0YTRWryzYys/Lrxu4cu?=
 =?us-ascii?Q?7xY4/ZMmUGLuBsyLEx0IkSVSUzssRuiiFxuQ/EZ0NRGfROihMwJBxPz0qnQO?=
 =?us-ascii?Q?gexvGK3QW2lhy6ZEBi3N4p91r/Q+NNOvIy31n1DAsEWnNsAjn34MbIfLLXAa?=
 =?us-ascii?Q?XvBCQlBvebkd+cfqiV+te30B2wGVzrDyQeqEocvGX+iZyHWoW5lSEpxYLXwo?=
 =?us-ascii?Q?ZCrzHvEnxup6/YNOTGGoZlFIUn2PnqaMamjg51Rnz1A6yPCKHUXwTAbqFLr7?=
 =?us-ascii?Q?6iPK27WXvdMyOY/Y21fPQ1+hcKEAI+S98MAW71Z3zQ0vXcFP10XlM3uh3c9V?=
 =?us-ascii?Q?Vdoe8twAeRyluBZF0nd28VOj6715YXmf6uhhDFvroGNm/nwMdP8pVv2iZyN6?=
 =?us-ascii?Q?1395pirkFPuoCkwLMLwmormKd6SL6AccC/YkcWWyZCs/Uqy0kBRfytduXdWg?=
 =?us-ascii?Q?yUd9diw6TFjq9OEF+Wa/jD2n82F6kTQpuTZJKKTzONmR80PtI2Qcgou0JtSO?=
 =?us-ascii?Q?2u7W2ZalYddRup5r5Awh3eo7Wci6BC1hUeisc3hCHt6KoTzjNuOtwVfvP8N1?=
 =?us-ascii?Q?YlQ+/RP5q6kvQhPpdBImVh0fFcuYIx1RlGfA6ggydGtYJBMBfYGqOk1NAih3?=
 =?us-ascii?Q?0CYNRrv1sHN/PuTY0x0KQFW1XBJkhV5bFbvtpGNr8WkErM9aG+AVqn74+cw2?=
 =?us-ascii?Q?ubS6sNjWiWjS1pEygAb+okhP/NLZutbvsG9OXiXyxSMZkS30WWE269VIk0a2?=
 =?us-ascii?Q?duM9a4VIulg4E9xxj2SjOdnK3cawf0DeanBFCHMZnqWvH36KLbIvNlz/7s3a?=
 =?us-ascii?Q?dpOvF1BZXdETgRAbf0qvoZ7QxLnaGMwudZBP+XSfoEjQlBw3cM6DCHY3H0f3?=
 =?us-ascii?Q?wVHiWUYNXoMQX4HLn5oRoIEMp8jE8LDKasMvtpD+I/buLjSz5u/GzwZ3QqbR?=
 =?us-ascii?Q?EXfBPwOXCzPaoDLCFXSTbrb9Z7YJk99KWkkdTgeQc2ZBmZP1HqEcchBIbIr/?=
 =?us-ascii?Q?ey9HYexhcgnUTjdc+42MX+AbGbV4vN2CKQ24qAv5L4B+A4wYbON4f/pEL/IX?=
 =?us-ascii?Q?1zImhbR0CV5u8kzI8zEHY0w1Ehvp/0ZX3uOnd8NqwoMXp/vh8ITE6nBuTFxv?=
 =?us-ascii?Q?N21RSdgBGw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcea116-5250-487e-8f59-08da2f5a5f9b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 12:17:22.6594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5ayY3/kDTBbnlZZdHmF63fltNiwihfuzP+q4BKtuKI/6+mq7sHCm9+zzryoZPpBXoHBK0ejInwe4VOSKgxGbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5274
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 04:40:45PM +0800, ying.huang@intel.com wrote:
> On Fri, 2022-04-29 at 19:29 +0800, Aaron Lu wrote:
> > Hi Mel,
> > 
> > On Wed, Apr 20, 2022 at 09:35:26AM +0800, kernel test robot wrote:
> > > 
> > > (please be noted we reported
> > > "[mm/page_alloc]  39907a939a:  netperf.Throughput_Mbps -18.1% regression"
> > > on
> > > https://lore.kernel.org/all/20220228155733.GF1643@xsang-OptiPlex-9020/
> > > while the commit is on branch.
> > > now we still observe similar regression when it's on mainline, and we also
> > > observe a 13.2% improvement on another netperf subtest.
> > > so report again for information)
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed a -18.0% regression of netperf.Throughput_Mbps due to commit:
> > > 
> > > 
> > > commit: f26b3fa046116a7dedcaafe30083402113941451 ("mm/page_alloc: limit number of high-order pages on PCP during bulk free")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > 
> > So what this commit did is: if a CPU is always doing free(pcp->free_factor > 0)
> 
> IMHO, this means the consumer and producer are running on different
> CPUs.
>

Right.

> > and if the being freed high-order page's order is <= PAGE_ALLOC_COSTLY_ORDER,
> > then do not use PCP but directly free the page directly to buddy.
> > 
> > The rationale as explained in the commit's changelog is:
> > "
> > Netperf running on localhost exhibits this pattern and while it does not
> > matter for some machines, it does matter for others with smaller caches
> > where cache misses cause problems due to reduced page reuse. Pages
> > freed directly to the buddy list may be reused quickly while still cache
> > hot where as storing on the PCP lists may be cold by the time
> > free_pcppages_bulk() is called.
> > "
> > 
> > This regression occurred on a machine that has large caches so this
> > optimization brings no value to it but only overhead(skipped PCP), I
> > guess this is the reason why there is a regression.
> 
> Per my understanding, not only the cache size is larger, but also the L2
> cache (1MB) is per-core on this machine.  So if the consumer and
> producer are running on different cores, the cache-hot page may cause
> more core-to-core cache transfer.  This may hurt performance too.
>

Client side allocates skb(page) and server side recvfrom() it.
recvfrom() copies the page data to server's own buffer and then releases
the page associated with the skb. Client does all the allocation and
server does all the free, page reuse happens at client side.
So I think core-2-core cache transfer due to page reuse can occur when
client task migrates.

I have modified the job to have the client and server bound to a
specific CPU of different cores on the same node, and testing it on the
same Icelake 2 sockets server, the result is

  kernel      throughput
8b10b465d0e1     125168
f26b3fa04611     102039 -18%

It's also a 18% drop. I think this means c2c is not a factor?

> > I have also tested this case on a small machine: a skylake desktop and
> > this commit shows improvement:
> > 8b10b465d0e1: "netperf.Throughput_Mbps": 72288.76,
> > f26b3fa04611: "netperf.Throughput_Mbps": 90784.4,  +25.6%
> >
> > So this means those directly freed pages get reused by allocator side
> > and that brings performance improvement for machines with smaller cache.
> 
> Per my understanding, the L2 cache on this desktop machine is shared
> among cores.
> 

The said CPU is i7-6700 and according to this wikipedia page,
L2 is per core:
https://en.wikipedia.org/wiki/Skylake_(microarchitecture)#Mainstream_desktop_processors

> > I wonder if we should still use PCP a little bit under the above said
> > condition, for the purpose of:
> > 1 reduced overhead in the free path for machines with large cache;
> > 2 still keeps the benefit of reused pages for machines with smaller cache.
> > 
> > For this reason, I tested increasing nr_pcp_high() from returning 0 to
> > either returning pcp->batch or (pcp->batch << 2):
> > machine\nr_pcp_high() ret: pcp->high   0   pcp->batch (pcp->batch << 2)
> > skylake desktop:             72288   90784   92219       91528
> > icelake 2sockets:           120956   99177   98251      116108
> > 
> > note nr_pcp_high() returns pcp->high is the behaviour of this commit's
> > parent, returns 0 is the behaviour of this commit.
> > 
> > The result shows, if we effectively use a PCP high as (pcp->batch << 2)
> > for the described condition, then this workload's performance on
> > small machine can remain while the regression on large machines can be
> > greately reduced(from -18% to -4%).
> > 
> 
> Can we use cache size and topology information directly?

It can be complicated by the fact that the system can have multiple
producers(cpus that are doing free) running at the same time and getting
the perfect number can be a difficult job.
