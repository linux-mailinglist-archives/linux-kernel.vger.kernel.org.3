Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65659539B2B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 04:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349119AbiFACUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 22:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347547AbiFACT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 22:19:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA156AA46
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 19:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654049996; x=1685585996;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=muUE4yzt9Qa5VC3EER//nSIH7qMbstrEfWiiVczsOHE=;
  b=jvKNDMSkyUNf48arzRlMy0omgV9U1VNeGK/H+NHU1QSh5yWmXVQ48Q6l
   vtnzJ8QJSf+rIoj+7go3ZBZOWLL7jSUBe9RBWWNXhx0qUWtNufuCqi5sv
   +OVQHXWqFuX4L2mR6RElTW6wg/hS/K8huSdeU4Fca9mKoB7FetWY+bY9U
   7XPlpxXiCJjeT3ZRx44XV1gG5cgkCXa/5SsFixmOG9j2NdGNCeMz9Kk3X
   b9i7UoHNIYrCehCXY9zoL/VNSFo3evZsEtc2KH5EGp7oI9JWIpvL6zLPq
   8e358mMhn60vu1g45QNcM7qTM/P8I59BbNKxslSyx8rbFXlVNk/xpna/k
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="336102800"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="336102800"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 19:19:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="612109960"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 31 May 2022 19:19:52 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 31 May 2022 19:19:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 31 May 2022 19:19:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 31 May 2022 19:19:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeiHALC5a34A470TM39W1zehtvv2mB2ayDAf0b1/8pUucwCx9QBx2H7LJbMm2f1BRvxEvSoI5LE5QDvFxMlxR9pjuLogiJuMdaz15Jk272VdBP/6VvOqcxERcO1FJiDn/w7URmwmMsR8B7b9Zo8ABksHtVbWHMUzZNH12HVbzH8EsY5mdePE/kQz62I4BLtwt5Ccn7uH6EpsA5rsa2rEP0JtDjAHLrH53GyI38cazUOnGyiXzbtDK2uX73INp4axqBJWURCwG0LZqNoW3Ef1YkUEjnKn09JctZoIDMSVqouyKsNb5ZFCpld+gcf/juSlIqNRpMByi4K1/jC4T/2obg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9RiVaHtCUhZ7cVMDaOd7eJYoMOY6EE7WC+pM7oK4Eo=;
 b=BIsl5jfUn2pOD2z+dTpbx6fM4Q8uQ9zCNHFYMWwzqGyykNL8oO51JyECo0ZaGfLTGt6QtMq8dThKFYviGw21JS5JdW3QJNwuSF48UbKeLkAXYwON2IjCpIZEZslEFa/+rSbSR+fs9r94k5XCvk6/+fpTRuEfLMAJfDwc4OqX4xN2RmMDVzGOvh+rUjN0Z8GGlS+jFCSYFyue4uWWIkl9xAo1HIPQ/C+aoI7JypyDxT7nZtCNtiS1wwrXMqWiuSyRpnyUEgOwTjP4yBDvE8Qu+tn0eMSbIC3GkGatSHozzBxcQcTOKWLWyXv+g7koGGkho5zzTn+txvNH3jWYcGRq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3060.namprd11.prod.outlook.com (2603:10b6:208:72::24)
 by MWHPR11MB1424.namprd11.prod.outlook.com (2603:10b6:300:26::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 02:19:49 +0000
Received: from BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::5407:c706:4b0:a19a]) by BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::5407:c706:4b0:a19a%5]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 02:19:49 +0000
Date:   Wed, 1 Jun 2022 10:19:37 +0800
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
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0%
 regression
Message-ID: <YpbMuXtzUyyv5yqC@ziqianlu-desk1>
References: <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
 <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
 <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
 <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com>
 <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
 <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com>
 <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
 <YnswSZQAfRAWr+z0@ziqianlu-desk1>
 <4e9d67b4d2ed8b4851a93b2a79a04e860d1f36b9.camel@intel.com>
 <7a08a1d2-27f3-ae03-5ed8-91ddae2730dc@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a08a1d2-27f3-ae03-5ed8-91ddae2730dc@intel.com>
X-ClientProxiedBy: HK2PR04CA0085.apcprd04.prod.outlook.com
 (2603:1096:202:15::29) To BL0PR11MB3060.namprd11.prod.outlook.com
 (2603:10b6:208:72::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c8db691-7673-481a-3f20-08da437533d9
X-MS-TrafficTypeDiagnostic: MWHPR11MB1424:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB14241AF729B7F053A2E0F5818BDF9@MWHPR11MB1424.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w5bRhgxoRu3mfkkdVhnlXHXvNSJXfN6P3Q2MAxkmJsicI5RInAH2xumMMrxFsdmBWQjS3RmIaXsRseNEVDrIZlOt9sGqvCehQoXctcrJIm7l1B63T/jqO06YIK6YUVpLrEheWPFpXglEjFKKAwEE//nE2mDezm0dyUJj+MLn9Z4I/OIJc7nzyCVvEQ1XRdxKQ6K207Ip/LKPlETi90My1be/nq8dvQRWp+/ImLAa4Oblhls1UDDW4yKssfyjMP0JIpVdpssJDFjfAPm4O27jMUcqjs+zV/1zcIh2agh/Cqxo2NPWgFkW23VkIyrztppYYzV6IfMtpRzNHqj6pWT5aKeUx9MrnZumYpOcICfo9TxpvSGvx0oqGj8JEgmLMJRP7/187JS3vxkdfUvL9QDlKtqHmbDjo0BPbeMvwdYm+vE5GOPpCIgClk4Oi5bBT/1DjUpKZWtL7oQ34WVLDYtQLqbl3EC1QFoeTM/O33pTykUKBO/hiqyonVEGrFottHvHwQMoQSNmZ15Yqv+t0YLU+ZEv+yDewCmjUhjPK/J5ES0pGRXW3/r5widiQyxJN6lidF8so8tokxKDdfjgkd/hm+cFSJApfaQyjgujOVei3X2DXp+bORI0vJeQ9sidlbbrVcg7VP046BILkSlsA/joKersAegIAJrbz6+Iw4fIfuA3HZNayYoJIQt2dSqdI11hp9ZyzlKdOXoLzeh5gIDJaiqFLcntGqD7yf1mgWiwjeslXW2ghYrISWTro8ID0JGadV/MWCeAlnMNw6pRf/eQ8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3060.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(53546011)(44832011)(6506007)(82960400001)(316002)(33716001)(6666004)(6636002)(54906003)(2906002)(66946007)(83380400001)(7416002)(86362001)(8936002)(508600001)(6862004)(8676002)(66476007)(66556008)(5660300002)(4326008)(966005)(6486002)(186003)(6512007)(9686003)(38100700002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?66pWqOPmOEyE5VJ9Tko7aImU7iU0IN11FIQE2kvN9eBKdpOJiLiRCVB8MS?=
 =?iso-8859-1?Q?N4W7G5h1ZhpoTcoWZmtyvWv3xmBTgX8nJU6UKLxV4ruGjyKd1rElM6bDmF?=
 =?iso-8859-1?Q?0Y21MYJTDiCsiS/OiIsa9iVVFObUCYvIG74UK70mWg7DvXyFnliQb9rSDB?=
 =?iso-8859-1?Q?23//i16ZMHRZQbJ7Ou/PWekiaD7rHmH/uV0jbIxpZgkzixSi0tiH9Pa/et?=
 =?iso-8859-1?Q?66AsLp83+eZT6EpwFgLPbvlwq2cd5UucBIYHpmtYmTTnGqTRWfRfUyp9xI?=
 =?iso-8859-1?Q?MJAUkUjSncgsVRXCVwNAk3sezPl2lP6UddBETh1X+OX3ve8hTUY1Dw33Jf?=
 =?iso-8859-1?Q?7zb1GNtVxzGGVJncJ9wGpG1ONF1xbj5dYAJ+WKR4nrs4Kv2oX08Opti1Eq?=
 =?iso-8859-1?Q?w7n6QGXsUDOfhMETXvTsJn7pSGhcisQ4TztyQc2N78EL4tfuf3IapRguAf?=
 =?iso-8859-1?Q?p7t5ig6nP/u3v14frih1XeZiOi7JrLvXdr2DGiQi7SAZKNOBLCsEbntMn9?=
 =?iso-8859-1?Q?0LOhdWWH+LMPGJksn4CtO7m7ICMKv6HcWLa4fGYZwDNw9bb3tggEr/wssQ?=
 =?iso-8859-1?Q?m2QjLz06I25Abd0gzYdtHIHJz9cCPJqIIRPWmI7WDcrq8TItgrWtozS83g?=
 =?iso-8859-1?Q?DPnthg8JootPLoOqmpS11X8cxLq9YAcPTJLvntJGev1WYQnYMPJZpwPwCR?=
 =?iso-8859-1?Q?urKNDwZjtsScHMXI3XZ8tElUxrWLfgardDAL86bNiHtSdkUaJ8PixnJdvw?=
 =?iso-8859-1?Q?hN2CrpQH9NFztUn08PkDpeQMCoPOdfMbDvNrA2MmNZFB9mcf7USdPWcA/f?=
 =?iso-8859-1?Q?B2mxg1eogwKkbq32tOWlBj2isDfUT93VwGnHVxanFeijE6o6UeopnJX020?=
 =?iso-8859-1?Q?i4pa+gJQN3BlK/UFThf8YYariNIq8zmQP8sS9ReSiexnDWPZcL0sCMR7cZ?=
 =?iso-8859-1?Q?9NyhnXbrUwMKRO1oKWmz4S2OdR94Z7eG2ouGYB+WY7KG1CK9xEqHyzk3cI?=
 =?iso-8859-1?Q?Iz6od7yNmcKdZtXwxgq0wmbtL0sQ+KJ7uZE+WotCfSMkKWMI67sed+9hzf?=
 =?iso-8859-1?Q?5xeZ73E+RJ4g37uxeS4qG0NAvUbeI1UhHsSGChbA+CyUdZF8zUHV5kymxl?=
 =?iso-8859-1?Q?A8CHxopAUDaAkZbBoM+05zVM1x/MRn+cU+MgUVGCr1+u4N87BORHPi7/Ul?=
 =?iso-8859-1?Q?/GglB68JseuTdJY0RF984WmXm0EXEJvbzVXpMDd423W2Y78Yv7QuCeTSfu?=
 =?iso-8859-1?Q?IIKJBOrTtkVRk06fQVcxWulkol48oJTLozZeU6T41KErgS2UzOMPSuDkqv?=
 =?iso-8859-1?Q?H+gcFUSoPuetIXqjgBcKpomWT0Wt29ziQum/Mvia+Ny79ehk4SHbMks/7+?=
 =?iso-8859-1?Q?cLUhhBlCeluLY4kAxUa05J5IH0+KtGSSeXIaATRA+6wqzDLbJxfDaLwODt?=
 =?iso-8859-1?Q?CKOlFEn5GiFY2FjgwzbswmSbT+u76RzNZwoafo5QbeNO48BSTNMYDQCNL2?=
 =?iso-8859-1?Q?EN+mOviSz6XfLGr746yrqhHrusApIoLS9yab29K7kK14FUIHY2U6Mg4Ldb?=
 =?iso-8859-1?Q?rtVBCzRcq51RJHzjZl9aygVIosl4Y/f2qRh35HIRkTISeRM9VMTV619VV+?=
 =?iso-8859-1?Q?2hjanBiI/E+xf5YSlTDldNjWrjfdc8dlg51umeL6UnmxLJ/27IpIwNe9gh?=
 =?iso-8859-1?Q?f+0Zp65mPPWt7f+nYItLRbFdTr21rAlKtgIKeyAhAHK4CJPXhlhK6Ciy+L?=
 =?iso-8859-1?Q?vj1U2aDcE7UuImhttyBXm+cH1QnUxaklgbbSDo5KdIEvCTeVfwXyjgEaT/?=
 =?iso-8859-1?Q?fBhAzzDlGA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8db691-7673-481a-3f20-08da437533d9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3060.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 02:19:49.0206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69z2NII8YXBPhy0ipnJeQjbyKWTUYQD+4JBGqHXptt62be7dhGdGVvbWKAV27SDubn5m8c+ac8fzgr0W1dqXoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1424
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

On Wed, May 11, 2022 at 03:53:34PM +0800, Aaron Lu wrote:
> On 5/11/2022 3:32 PM, ying.huang@intel.com wrote:
> > On Wed, 2022-05-11 at 11:40 +0800, Aaron Lu wrote:
> >> On Tue, May 10, 2022 at 02:23:28PM +0800, ying.huang@intel.com wrote:
> >>> On Tue, 2022-05-10 at 11:43 +0800, Aaron Lu wrote:
> >>>> On 5/7/2022 3:44 PM, ying.huang@intel.com wrote:
> >>>>> On Sat, 2022-05-07 at 15:31 +0800, Aaron Lu wrote:
> >>>>
> >>>> ... ...
> >>>>
> >>>>>>
> >>>>>> I thought the overhead of changing the cache line from "shared" to
> >>>>>> "own"/"modify" is pretty cheap.
> >>>>>
> >>>>> This is the read/write pattern of cache ping-pong.  Although it should
> >>>>> be cheaper than the write/write pattern of cache ping-pong in theory, we
> >>>>> have gotten sevious regression for that before.
> >>>>>
> >>>>
> >>>> Can you point me to the regression report? I would like to take a look,
> >>>> thanks.
> >>>
> >>> Sure.
> >>>
> >>> https://lore.kernel.org/all/1425108604.10337.84.camel@linux.intel.com/
> >>>
> >>>>>> Also, this is the same case as the Skylake desktop machine, why it is a
> >>>>>> gain there but a loss here? 
> >>>>>
> >>>>> I guess the reason is the private cache size.  The size of the private
> >>>>> L2 cache of SKL server is much larger than that of SKL client (1MB vs.
> >>>>> 256KB).  So there's much more core-2-core traffic on SKL server.
> >>>>>
> >>>>
> >>>> It could be. The 256KiB L2 in Skylake desktop can only store 8 order-3
> >>>> pages and that means the allocator side may have a higher chance of
> >>>> reusing a page that is evicted from the free cpu's L2 cache than the
> >>>> server machine, whose L2 can store 40 order-3 pages.
> >>>>
> >>>> I can do more tests using different high for the two machines:
> >>>> 1) high=0, this is the case when page reuse is the extreme. core-2-core
> >>>> transfer should be the most. This is the behavior of this bisected commit.
> >>>> 2) high=L2_size, this is the case when page reuse is fewer compared to
> >>>> the above case, core-2-core should still be the majority.
> >>>> 3) high=2 times of L2_size and smaller than llc size, this is the case
> >>>> when cache reuse is further reduced, and when the page is indeed reused,
> >>>> it shouldn't cause core-2-core transfer but can benefit from llc.
> >>>> 4) high>llc_size, this is the case when page reuse is the least and when
> >>>> page is indeed reused, it is likely not in the entire cache hierarchy.
> >>>> This is the behavior of this bisected commit's parent commit for the
> >>>> Skylake desktop machine.
> >>>>
> >>>> I expect case 3) should give us the best performance and 1) or 4) is the
> >>>> worst for this testcase.
> >>>>
> >>>> case 4) is difficult to test on the server machine due to the cap of
> >>>> pcp->high which is affected by the low watermark of the zone. The server
> >>>> machine has 128 cpus but only 128G memory, which makes the pcp->high
> >>>> capped at 421, while llc size is 40MiB and that translates to a page
> >>>> number of 12288.
> >>>>>
> >>>
> >>> Sounds good to me.
> >>
> >> I've run the tests on a 2 sockets Icelake server and a Skylake desktop.
> >>
> >> On this 2 sockets Icelake server(1.25MiB L2 = 320 pages, 48MiB LLC =
> >> 12288 pages):
> >>
> >> pcp->high      score
> >>     0          100662 (bypass PCP, most page resue, most core-2-core transfer)
> >>   320(L2)      117252
> >>   640          133149
> >>  6144(1/2 llc) 134674
> >> 12416(>llc)    103193 (least page reuse)
> >>
> >> Setting pcp->high to 640(2 times L2 size) gives very good result, only
> >> slightly lower than 6144(1/2 llc size). Bypassing PCP to get the most
> >> cache reuse didn't deliver good performance, so I think Ying is right:
> >> core-2-core really hurts.
> >>
> >> On this 4core/8cpu Skylake desktop(256KiB L2 = 64 pages, 8MiB LLC = 2048
> >> pages):
> >>
> >>    0           86780 (bypass PCP, most page reuse, most core-2-core transfer)
> >>   64(L2)       85813
> >>  128           85521
> >> 1024(1/2 llc)  85557
> >> 2176(> llc)    74458 (least page reuse)
> >>
> >> Things are different on this small machine. Bypassing PCP gives the best
> >> performance. I find it hard to explain this. Maybe the 256KiB is too
> >> small that even bypassing PCP, the page still ends up being evicted from
> >> L2 when allocator side reuses it? Or maybe core-2-core transfer is
> >> fast on this small machine?
> > 
> > 86780 / 85813 = 1.011
> > 
> > So, there's almost no measurable difference among the configurations
> > except the last one.  I would rather say the test isn't sensitive to L2
> > size, but sensitive to LLC size on this machine.
> >
> 
> Well, if core-2-core transfer is bad for performance, I expect the
> performance number of pcp->high=0 to be worse than pcp->high=64 and
> pcp->high=128, not as good or even better, that's what I find hard to
> explain.
>

I've found some material that explained how cache transfer works:
https://community.intel.com/t5/Intel-Moderncode-for-Parallel/Core-to-Core-Communication-Latency-in-Skylake-Kaby-Lake/m-p/1061668/highlight/true#M6893

Also a paper on Cascade Lake's latency data(at the end of the paper):
https://arxiv.org/pdf/2204.03290.pdf

core-2-core transfer latency is usually at ~50ns while llc load latency
is ~20ns on server machine, so if data ends up in llc, that would be
faster to load for another core. I think this can explain the test result
on Icelake server where using pcp->high > L2 delivers better result.
Thanks to Ying to bring this up.

The reason why using pcp->high=0 delivers best result on the desktop
machine might be either due to its relative small L2 size such that even
bypassing pcp, the page data may still ends up in llc; or desktop's
core-2-core latency is not much worse than llc-2-core latency, so the
more reuse, the better.

Back to this regression itself, we think reuse cache is generally a good
thing for performance. It's just that for this netperf/single_thread/udp
test case running alone on this Icelake-SP test machine, default pcp->high
makes data placement more friendly for cache transfer, i.e. more
llc-to-core transfer than pcp->high=0. But in real production server,
thing can be more complex and it's hard to say such an advantange can be
kept there.

At the very least, the bisected commit's worst case performance would be
core-2-core latency, it's still better than loading latency from local
dram, which is usually 80+ns. That's where we think reuse cache is
generally a good thing, as long as the cache doesn't come from another
socket's cache hierachy :-)

So for this regression, I think we can keep the bisected commit as is.
We know it can cause subpar result on some server machine when running
a specific test case alone, but I think this commit should bring more
benefit than harm in real production server. The other report on netperf
using nr_task=25% that shows an improvement might be a hint on this.
