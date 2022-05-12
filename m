Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F049524D49
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353932AbiELMqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353923AbiELMqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:46:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA56252A5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652359559; x=1683895559;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dufGYd1B5FOovbEKYoC6XY2YG250gZUCzfaySOsMidg=;
  b=Cm/CAQxg9EjdljsK/Nh1Za1hMh3HVoxl9I9iZlplMNgmaiwYKfg/4NdG
   I5EKnn1qjY577pEIbLcYrvnncwHF4oSiu18H6oOp/0wdSBSCb3W5fG7/e
   VW2jKmbyqirzqTJMRAhlk8heOJ5LMWBq3452T+iBpTSx837CuvUYtzN3h
   Rk0gsBsLfWm9l1DNJArLUAxMNvmnpmsEw3V1vkngTVKxFpBHfnhgz7IdX
   aF42jHMN6P8W82RcDO0DdrCwlzxxpoNJuRFIEOL8mLppUyIhVaub9h+Iw
   f2zXTvNvC3QkkbBRQNp/YSkZE6oZ5xDTGapr9MnsM9OWVqLm7VID3ir/7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="270117755"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="270117755"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 05:45:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="636835217"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 12 May 2022 05:45:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 12 May 2022 05:45:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 12 May 2022 05:45:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 12 May 2022 05:45:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPbs1VLrxMRObYWu8P8FqckODcgwDqk+u3t9Dvfe8oa082TtgT9Pj4M1qEjxqk03WfGM3nOskt+Op72VuF+43b+S0a6SpEfb13Yx3g+wVveFmo4MJ9CaRdnlaWAY3x7w7P8GToL8niPq2GiMRk19WdC4aBrab8AiIqsXG1b5XRkaDq6GZJmYNG0YidPSdbj1WmmKA7waH1WDbC0ThR2/zJ39QLTNFvD/EllK1NCSJfgogpQkclIQEQfIv1bVcOAy7wf/lM5o6OpXaKKyTlnDPc/hdFF22khUrV2DTsto3BNZ47Oz2Vm9PAVf5M4Svv6ju7E5gkHbCsNI7JuY1Xa4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acM3QZ7NGKjTwPQh1qMY7yFjkeU/O8tDFZIWVc3RZrE=;
 b=d2KYiXGOAzCKrhI9fbGoxN3Rsj39JJUOvzlXDwtNq9dpG7Aqw4KjlWD+PsxE5TyoFDRWcTpkXRN0FbAvbPzSCLqL+71Ab9NP6oe7Zms6XHblD4V1pihthSn7wHzPRCzZKQoFW+UIHm61Xz5J/iLtP5YnNk/oQXCLcgUTOYjWPESt+zMdznDsOR6xxHUAvSBsSOBE7W0Xgq+w04wgZqGSmKszd6wZYKc9wkgCA1mISk6szPpFqQqO3a8WDhTM0a/dlzyN7I9InmtWHrxeMZQ3lqze9DyAetsZib9+CwX+2DitXdPagRrHYPCi2uJ3mT52BabvfGDO6FrXZeQnf7tTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by BN6PR11MB3923.namprd11.prod.outlook.com (2603:10b6:405:78::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Thu, 12 May
 2022 12:45:55 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff%5]) with mapi id 15.20.5227.024; Thu, 12 May 2022
 12:45:55 +0000
Date:   Thu, 12 May 2022 20:45:45 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     "ying.huang@intel.com" <ying.huang@intel.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "kernel test robot" <oliver.sang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        <fengwei.yin@intel.com>
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0%
 regression
Message-ID: <Yn0BeRaUC9ailyzz@ziqianlu-desk1>
References: <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
 <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
 <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com>
 <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
 <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com>
 <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
 <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
 <41c08a5371957acac5310a2e608b2e42bd231558.camel@intel.com>
 <YnuYV3J2ljY88DyQ@ziqianlu-desk1>
 <dfc98503b11e2e54a5a82c21b8ef6afa10eda9b7.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfc98503b11e2e54a5a82c21b8ef6afa10eda9b7.camel@intel.com>
X-ClientProxiedBy: HKAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:d0::18) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4e9ecfa-5f25-42ee-f326-08da34155ab3
X-MS-TrafficTypeDiagnostic: BN6PR11MB3923:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB392349F3072C890010AB2CA78BCB9@BN6PR11MB3923.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /uGDYJpGsy8WkNUZq8PEVpoxpFV1xn8lgv3g1XMRotrNaxenfoYXvii51dIBMXlaOeeRSQ0s9sLuWF8XHCcdvQvieD4Cn/evODIumk6Pv7oVJHjdqCbozD1zOgzzMUa+mAs+rdFr8k/mqNww7RuLgFmSAQP5Gg57S2IfcZR2sVlB1N+lZqKn+HxvXwetCjeciYoqDFLYmTq3dAz9Vjvp14vIsAVhzct5iNiNAxzj/A8elBUxi8EWab7BbFP+Ajn/c556OLigpujwJJyjNn6ENGX2SmeN6EaRmlK3WX5PtpZI3QVsRd70OYKJuS2TDwhCEx9FL0m1WfdIJhEIvu9qX/CQO7/N3osFeyVSX8Hh03o3gKWoyrjVVP48StR90UXSmZelNk9HcFW8Bvv5Ld4FcL5i9CmTWILsNkkG9UGiwTvAtkcjAh/kn9ljWnEAKwtc7oEa188b0LKY3BO7JxFlMwMDG+dRuhIBbUdcz4nSa0xTYxszh+3xvC0N0aN853b4wawYAJxWqxU/bwfGcJCx7VQW7/9WOPtvqQDYxXEUX5PUFEBU8oDsXkRJRFDyyEhqQhsgqTAFNnhIoZirLHf1zpkxUeWZnFU7fAsXmZ0n1BN/qkMmCH2oH/r6OgJ+muFeSya7WpkTWN8vIr21BdOrEXPoAMyPYQ1oHbLrTnoYBma28FmBdz0NDKeURXpVPeriwQxSTcDhBoiyexxqsUt0b/5WbgNTjTTX6yNM0dfVz7q5qwrw7F9mi4nSK2UQ/Nd4sDwY6cpOolNN6hQK2osI8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6636002)(53546011)(83380400001)(6486002)(82960400001)(33716001)(8936002)(66476007)(8676002)(54906003)(6862004)(66946007)(4326008)(66556008)(38100700002)(6512007)(26005)(316002)(9686003)(966005)(508600001)(2906002)(7416002)(5660300002)(6666004)(6506007)(186003)(86362001)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hP5BoB14r5dDtJnVolu9UQvd7YUsQPLqqU2NSav5HtNUyf0YmLOwP03gp6?=
 =?iso-8859-1?Q?9uZfStGhkiaPpXgZpmOd2JRYRgfJPVQfaFKUghl86JWnhXaccn61MXGAbN?=
 =?iso-8859-1?Q?mytW5qzwCnwHu8BixHU81j4i8B7pUGpfh6m590Q9xBncv32OP2nwfJrlr9?=
 =?iso-8859-1?Q?ppxQjeWDTf8yupHJMzMqr0hNPX1ZEQo+qRLwgx3qMascwm7Iks2b0bQopH?=
 =?iso-8859-1?Q?bwK6tQhekFGtX8wpqMnFE4EMSZ+2k+As1cWFVnyQU9cqRrfOLFkQ2Z/c68?=
 =?iso-8859-1?Q?i+Mb9wANEjWoAlUmbHNiXFQmagmAlHwiNYZOVPQwT6sT54/PWiQdM7gi9Z?=
 =?iso-8859-1?Q?qkHk79qcjdgkheKknNA7S3dTaMgkwLFJfkXOCGQgbjrsl7Ho6BhebyI+fw?=
 =?iso-8859-1?Q?MTypZ0X7V6+Z1eV+hBhmNw5jADb9ZGsMhzt2kE+wFrA3EoCAoWNqV5sX4M?=
 =?iso-8859-1?Q?TCbaltKZKYcNP9WLThjCFn/Tudujz/jAEow7CYViL53e8q4cqsuP3B9355?=
 =?iso-8859-1?Q?7/TGvafQLssJl4Z3BtghcqrLcIq5odVKghkI8vdiMHPv67FvrybIAFWHUc?=
 =?iso-8859-1?Q?nUtjcp0VoDO0zikCdwvES9WpQAUs/ug4/fmokN03PUtaB1URBsxazr7wTI?=
 =?iso-8859-1?Q?1N6XaZBNawcvAud51uh5rMJK1wu6cJXqVwPsv9XiPwg0MB9ziIfOutZ7l1?=
 =?iso-8859-1?Q?mh6YoUdp+LFMDjxVXT+OxG1yI/Qr7J9S4W811zZCOUO8GkGIlfLVAHmf2p?=
 =?iso-8859-1?Q?UxF+evJGNpzAymLUSZr0VLxs3Lv7RJ8wWjtiztx4Iss8uJuFtYowlAKYn8?=
 =?iso-8859-1?Q?QJCLOs8o4Prz3huN9mx8AYZYr8Zb1CpsLw4vVwHRQnKjCrcUqWoxdqqzy8?=
 =?iso-8859-1?Q?fma18k8zwjqbdrNK4C/eyy2XbRSRHF1B4P9UlxsfwM9nCZMd7JWd0ZY0A4?=
 =?iso-8859-1?Q?6NkQY9PdVRgwlzOfnL9SSJ/OshixXhWpOwCAgz4dNspz7uzIgHrnsbhrRp?=
 =?iso-8859-1?Q?H+2ZR4iq/buEaKzqSglLXtZ97xiogRJ5L9nXopF8JGGExTdyWVdGGfFU/+?=
 =?iso-8859-1?Q?LPTRGhdf8xMsRfL07i6HmLLDVUZ/0YT/sjUNnJZBQkOb2AHJejgzPc8eJ8?=
 =?iso-8859-1?Q?LfX+rMw3rQDntwiMO3V3xO+Q2AVQzij9jkibux8Xeh1AHj3m1ObOOwILQE?=
 =?iso-8859-1?Q?URvDn5f4iA25zrUGEyIczQ172JV1f+LhxElI4JQ6xY6j3e/FJ7qvfqJCaQ?=
 =?iso-8859-1?Q?nQN9R2XrthQt4wuaJtPM5gm/skrIF5cLunLoirmta5Y1kzvuyxjvWdaA8T?=
 =?iso-8859-1?Q?UDztXZhAPjo1mONJVWP+SOsiD6fYd84BEKw6C8ZqymVylXb0wA5iu9oWG/?=
 =?iso-8859-1?Q?yDCrvJaZoEMhf4ddecn62Wl0Skq9wL0KVZHBjB4XuMREEpulhkp3HNF7Nj?=
 =?iso-8859-1?Q?VFWM8QtM7GVK6Tk2c/YyEo1fKjMxgHqrfnVS6rLrDnHpkpjzO5YH3QbZ3A?=
 =?iso-8859-1?Q?DUB84W/qA84EI6xLPzrH1/XFoygvdtQdTdfkhSt9O35qVSbLdU506WLEzl?=
 =?iso-8859-1?Q?FrjIqU/t2oDv6wRYLdEAHjkuJqelHLMtEGMKkikxAsXccs1G2JtIx/bil/?=
 =?iso-8859-1?Q?PnVGBTAvP0+/a/jYAw9RSekGX/4BRS7uwpWwD2qSFrmtrL0DkMbpibRuw+?=
 =?iso-8859-1?Q?hJOA9ICprvs/2QCYwu1LTAmdtHK4ALt0vJBSvCtijB0OCzmrf/xmLSxmqe?=
 =?iso-8859-1?Q?TFBYnNyItiw/lJIH0hwI5X6Y/hEd92TnGk23F1OuFdQNgznCYZHSFA8mmy?=
 =?iso-8859-1?Q?LP+EG2A8WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e9ecfa-5f25-42ee-f326-08da34155ab3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 12:45:54.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfHrSIlaxbo9xaWx9zbTjbSaR9DB4HOy/jH9O0DzUnjJLEYDJybsurJus7DE1ercWQXBwlh9a5GIIRVgRmaU/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3923
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 11:17:04AM +0800, ying.huang@intel.com wrote:
> On Wed, 2022-05-11 at 19:04 +0800, Aaron Lu wrote:
> > On Wed, May 11, 2022 at 09:58:23AM +0800, ying.huang@intel.com wrote:
> > > On Tue, 2022-05-10 at 11:05 -0700, Linus Torvalds wrote:
> > > > [ Adding locking people in case they have any input ]
> > > > 
> > > > On Mon, May 9, 2022 at 11:23 PM ying.huang@intel.com
> > > > <ying.huang@intel.com> wrote:
> > > > > 
> > > > > > 
> > > > > > Can you point me to the regression report? I would like to take a look,
> > > > > > thanks.
> > > > > 
> > > > > https://lore.kernel.org/all/1425108604.10337.84.camel@linux.intel.com/
> > > > 
> > > > Hmm.
> > > > 
> > > > That explanation looks believable, except that our qspinlocks
> > > > shouldn't be spinning on the lock itself, but spinning on the mcs node
> > > > it inserts into the lock.
> > > 
> > > The referenced regression report is very old (in Feb 2015 for 3.16-
> > > 3.17).  The ticket spinlock was still used at that time.  I believe that
> > > things become much better after we used qspinlock.  We can test that.
> > 
> > 'will-it-scale/page_fault1 process mode' can greatly stress both zone
> > lock and LRU lock when nr_process = nr_cpu with thp disabled. So I run
> > it to see if it still makes a difference with qspinlock.
> > https://github.com/antonblanchard/will-it-scale/blob/master/tests/page_fault1.c
> > 
> > The result on an Icelake 2 sockets server with a total of 48cores/96cpus:
> > 
> > tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/thp_enabled/cpufreq_governor/ucode:
> >   lkp-icl-2sp4/will-it-scale/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/100%/process/page_fault1/never/performance/0xd000331
> > 
> > commit:
> >   v5.18-rc4
> >   731a704c0d8760cfd641af4bf57167d8c68f9b99
> > 
> >        v5.18-rc4 731a704c0d8760cfd641af4bf57
> > ---------------- ---------------------------
> >          %stddev     %change         %stddev
> > 	     \          |                \
> >   12323894           -26.0%    9125299        will-it-scale.128.processes
> > 
> >      22.33 ±  4%     -22.3        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_flush_mmu
> >       9.80            -9.2        0.57 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__pagevec_lru_add.folio_add_lru
> >      36.25            +6.7       42.94        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.rmqueue_bulk.rmqueue.get_page_from_freelist
> >       4.28 ± 10%     +34.6       38.93        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_pcppages_bulk.free_unref_page_list.release_pages
> >      75.05            +7.8       82.83        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
> > 
> > commit 731a704c0d8760cfd641af4bf57 moves zone's lock back to above
> > free_area by reverting commit a368ab67aa55("mm: move zone lock to a
> > different cache line than order-0 free page lists") on top of v5.18-rc4.
> > 
> > The interpretation of the above result is: after the revert, performance
> > dropped 26%, zone lock increased 41% from 40% to 81%, the overall lock
> > contention increased 7.8% from 75% to 82.83%. So it appears it still
> > makes a difference with qspinlock.
> 
> The performance impact is larger than what I have thought before.  The
> test may be too stressing to be realistic?  Can you run the test with
> less process number to check?

What about nr_process=16 and 1?

When nr_process=16, zone lock contention increased about 21% from 6% to
27%, performance dropped 17.8%, overall lock contention increased 14.3%:

commit:
  v5.18-rc4
  731a704c0d8760cfd641af4bf57167d8c68f9b99

       v5.18-rc4 731a704c0d8760cfd641af4bf57
---------------- ---------------------------
             \          |                \
   7179264           -17.8%    5898330        will-it-scale.16.processes

      4.01 ± 11%      -3.5        0.54        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_flush_mmu
      4.53 ±  4%      -3.0        1.58 ±  5%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__pagevec_lru_add.folio_add_lru
      4.61 ± 13%     +10.3       14.90        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.rmqueue_bulk.rmqueue.get_page_from_freelist
      1.58 ± 14%     +11.0       12.62 ±  2%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_pcppages_bulk.free_unref_page_list.release_pages
     15.42 ±  2%     +14.3       29.75        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath

When running single process, there is no measuable performance change
and lock contention change.
