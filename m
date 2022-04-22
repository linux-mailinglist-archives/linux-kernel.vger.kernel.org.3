Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376EC50B0C5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444489AbiDVGqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379429AbiDVGqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:46:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF9A50B35
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650609799; x=1682145799;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=D0d9+C3LysAav5VAkHgldZOFxOqSqnDlFSVPpwITS/U=;
  b=heVBXzXF6kcpwy4zW10aLFuM77JhDu3GSTqSC9WWnZ6OBBSstrrJoRNR
   4TV+gTUCt5g1T+h+vQXGdhaZ2XGxj3ugZetG5I3GFz2DUe2/peaaRdKTu
   Hhv9T9sDXPs3UOWIC9hjiKppK5ktpvghqLULAvddPO4pV/OOcjDHkdckI
   6C5nmxpF8qsuNeD7BRAv1tZcIMFxy/FVBUYFWSDSPqosHpuqcgY/hBpKa
   un2FNGmzvLBl10gWEsXU1R3E9/enH/33t5W7N3Y51gTZWt5c3Ukyl0XyI
   AgwR5nIsYPXUFZmWZJ3am7wRncw+oDGHU6TFyx9XgY92Ed0Uhe0XyPRLH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289711297"
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="289711297"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 23:43:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,281,1643702400"; 
   d="scan'208";a="615273050"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2022 23:43:18 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 23:43:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Apr 2022 23:43:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Apr 2022 23:43:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2r2V807vUA1h3GGON5uy79OP/6WZzr8YZa4O/ejQI+OKAXlPAZPm0okEH177gKNkq0woSHhVCnqaZhX291dxRr1TVQH3n/s2x2wVbDG087R3VP8CFUzO9N3BclNZwCw8vEXg76zktE9ezfwKG4n5ffrhgLDkBOT/VLAHRxgnmRwc7WAS/q5+4XifQIx/Ujt72Z6mtwPVojtcmgqAVR2jFFigs+g20QKItACIBFMX/JQg1GA8F586avvr6GnnlNl8r4Yu9o64lPrmT9dpdSDNmugMQaW4JkqV7MQtSKssQmJvI7bKjEnJV21+rdLRrz6WguRGXbJd5c1X0Hb7E1ISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91U+8xd/wDiDpgZyCBqP3zSnuFCYI04UoNaLPGIMheU=;
 b=Vg1JNqshC0/fJjcGqXU3ypWD3TfPsOLFfKe5EnnbbE7q/8QNH+8GH29YiG4/6Ii0R1KUY1Z3zbruSBt3nKz0PLO+18QhYrlhlNeAFqdn1FRzUVBaplS8968suKJmQmwAuA7XKL/yApMuOx2RsU3b5ja1mE5njkALKtY6wkcjwkDedaKrLPjkgqL9ZqToZj5d7pALJtLuem541n5yEqAjpioUCIUKBStM4f7d46mORqS6dKfGkzgaW5U58kVD6GprcqFfRhcxNKiONMZ9eG5iCoj7RDFpiR+R2cvG1xPxWWG0aDApEW8I8S0n1sewvSaUJ5phQJlfF9UpcKekHC2WEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CY4PR1101MB2088.namprd11.prod.outlook.com (2603:10b6:910:17::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Fri, 22 Apr
 2022 06:43:10 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::30f5:ac84:8cae:c977]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::30f5:ac84:8cae:c977%6]) with mapi id 15.20.5164.026; Fri, 22 Apr 2022
 06:43:10 +0000
Date:   Fri, 22 Apr 2022 14:43:03 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     "ying.huang@intel.com" <ying.huang@intel.com>
CC:     Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
Message-ID: <YmJOd5BlyNvB9fX4@ziqianlu-desk1>
References: <20220407020953.475626-1-shy828301@gmail.com>
 <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
 <CAHbLzkq+eKcKCsxXDTiOcBxk8FjMdWBqOxwi4N_NG7PZWbAAkA@mail.gmail.com>
 <Yl/FS9enAD4V8jG3@ziqianlu-nuc9qn>
 <f27ec36beb3cf1dbbfc3b8835e586d5d6fe7f561.camel@intel.com>
 <YmETEHnK/FiNbLO7@ziqianlu-desk1>
 <6f7210be7353d1c01dc9f872b2692b83f87f5452.camel@intel.com>
 <YmJKBaq1yj6/iBJ3@ziqianlu-desk1>
 <4f1bc4dc65117a185833555ff8df30a944453499.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f1bc4dc65117a185833555ff8df30a944453499.camel@intel.com>
X-ClientProxiedBy: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 995b9b2f-ad8d-45d1-f9d0-08da242b5e08
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2088:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2088CA068EFFF13B6F1867C88BF79@CY4PR1101MB2088.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKntLZiC2st0ute0g2ZCmpK1h8t/xQun9hQbjrxoP2sncR2i7hvJCCaGCKfUeoBJrkq8GjJkrskcioec1RurIo8xDOQAsuX/s3FVgA2rUig61YHGEk8qLDiysqA4FxNkH7Zp21GY6cR5euULgxgZ6NB+f+pIi0RJmpjDUwVD/H/kBv/GWfvzt5VDsJdRyN5NPS9fICIy+E9G6qJxxlXCCCtssbNC7Gp6JyDLIzjuLN7J54o8MNMnmbFaEOGLmvta4+Vccr1PI4kRMZoUTys+RRlwbL+A9eu48HEFO76Bj7CQHin5RTaE81WYcI0jwwqYvyA+YmIrRZgXaSaW2smH9HOhGfEVWhNtSzYul+otxO6iN0gUPRyDspprrIv6I4GiXgnrnZxypLirunHmcnhXsOcACqfTW055gzlvpRPqgqEO12wUhrdDrm38wtAGifJbfRjn2U5I/pKuCDFtTF4NWDlOXViKpvjqYW0onxD5GNzINt2ZueUQI393sSjON5eQ16MxmIjFbeN/ZC3u51pnv6jAe9LUgG+jQ+k9AME01JaxzrGctvK3XmJDifaI2tLq67I7Z50gGYyw60aLagXsfRXXyH0Z498iD++7FMRRPpqQ5tOTTXQ8p3ySnOB9d6iwXG1t8DkI9gEwPD2Yc6ukNmLOm3d2yK+l+QrEhYOgKeM+JIkOq0MUXsz99jEC3y+KMMadeF126Rg5SQGGKPvsOF1zIZyGUHsp0frNpByQyXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(66946007)(4326008)(966005)(8936002)(316002)(44832011)(86362001)(2906002)(8676002)(66556008)(33716001)(66476007)(38100700002)(83380400001)(82960400001)(6506007)(186003)(6486002)(6862004)(6666004)(508600001)(26005)(9686003)(6512007)(54906003)(6636002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?RepuYTYSo8O+lFoaPVviYJ5HxxYWct1yeJDNDGFN/PpQxC6R28gvPC/zbE?=
 =?iso-8859-1?Q?Ukq48I+0p1StFU9mTJT/ERmS0xcproTIQXqGrWrIKYW75/r+62buHNI7A0?=
 =?iso-8859-1?Q?pPp2Tp5hhjDmxjBse/aCfTYkWi9zXuStzzf2Fp1AFSy9RvpTE3Mk6fODI9?=
 =?iso-8859-1?Q?sT0xhFtwtTqr54Sfi4k+A9iIQ/zFSNTPXNAhe5UhHCnTZcHFs3Yd2KWDzi?=
 =?iso-8859-1?Q?i7qVrlk4z0+2nEoHKwsHpcg4NAr6TIUmtiu92jwGD4Bo78PG/KWUOu9A/B?=
 =?iso-8859-1?Q?sfMppwD+lrTffQcisyEseXVtGc/qmK9Z+4HbFp0PIgLhyifjYMF/fGe0Ba?=
 =?iso-8859-1?Q?hoU7+gsc4Y9UpXhGBIdQpUBJZiIvIl/1YPHLHrY3R/LWPUlr5gBartNZqI?=
 =?iso-8859-1?Q?xA0he/uLbrE0pKJb4Bxb2abOpvUd6hWNjen8yypGXNnHC2KW0EfS0CitRc?=
 =?iso-8859-1?Q?M0alM+P6F+7kWXtHlQw1u4DcgMpuEaskHJk6Vrt28B6xnrz5koXhyX+PrJ?=
 =?iso-8859-1?Q?COlnIAWpgw0V/QN3eoVH6ZHQyfpS0LgL/5wyynazxSyXsqaKd27u6w1tRj?=
 =?iso-8859-1?Q?aLca0KQ9cp8p3JqSnmh4ci9hH01MHoC/NkbBAM+uJAblRa6bgR0SMi6ZDh?=
 =?iso-8859-1?Q?mcmp3Bz3hHbcCJZfKogwoCXqL9yZ5ZLP1N5XrFhugqytyPhB2vsigUXhNd?=
 =?iso-8859-1?Q?07vlrkTgLysy0At1d2o6sFf4y7pkxu2XGLI/KwajUYqnu+qgyZG3Hhv8GQ?=
 =?iso-8859-1?Q?8CWW50UIYzVMhgvg2xe7xE3F8SX0PVt0KOZrRHHd8lHcezConud72eUQB9?=
 =?iso-8859-1?Q?rZ7hIXp93niVSfphLd9LY28U50MYqC0d1S/+4HEkHGHQcacFY6zz86aV0y?=
 =?iso-8859-1?Q?nIvJN0Wx+zQcClBQfRrxSwMUMaSgZs+wiyR9F2kaniCIcMa/nF2Cfde1rI?=
 =?iso-8859-1?Q?bDZrhZI2uk0q4A+KUI0VwWnxE509rJOZ8LBDIYm5d6pf4tWsYcx91q8SoB?=
 =?iso-8859-1?Q?PEj3mfLFm+9NyFeIHiFcuoTubTElT90hcmSCvWdEfguYmTbTFSkqvCLhU6?=
 =?iso-8859-1?Q?Rccl1Td6OQa/yaFU8BT6M1UCFsKbau5lJ5jSdgfo1f0a3LMdvAUe50iPLt?=
 =?iso-8859-1?Q?BLyICNn8wkaqtSqwuF0aQ7C+ypMBSbA0R6b1N3klkLEMGDzckdXwCoiFUb?=
 =?iso-8859-1?Q?JAeeiQcYFvB2ggpI9hsxQl9NPh525/CgyH3P1+eputpChoW3tMkG5JLi5D?=
 =?iso-8859-1?Q?DS2JBLxtnUY5ogFllcFg8btcN64x1l4vR4/jgrG5pONpHWaC+wsG6DcTfq?=
 =?iso-8859-1?Q?syym7mwElwxOGT6EdEAJEzIZETwnHhuuekky3YLI2AZzOxH1N9Tqv20o8I?=
 =?iso-8859-1?Q?9Ckd/Se3PDSVFQvKW8TGVNt/7/fJuozKFzhaOx3QDwCf2nqdXSH6BqRHRW?=
 =?iso-8859-1?Q?vUSfSj35BuJmPN6IthWQaDMo53fa+dOIiugCvcYmkVM3RO9BQiv/ADo37H?=
 =?iso-8859-1?Q?E/btuZNiBDSWszHehqN/zLwEi4xFhuvKZOZV263LpXUzBOLfCXzgLtf+oa?=
 =?iso-8859-1?Q?/g2mKqETPoqK//jItZ3UdpFm918WbdtVbX537GAH3E5nl5FkwO6Jpw9fb/?=
 =?iso-8859-1?Q?ejVvlkQBFOVP7U48iW2p6wgaQsNS6R59rUKbzHwUtKF1UqXxhm+ewhu3i+?=
 =?iso-8859-1?Q?BBJPeEQ05PW6GNucL4BrwkgH0iwhe8v8oUsUgcFox3u9kcUu+oDtLokmtT?=
 =?iso-8859-1?Q?7DHJDZQa6XUwJrLXvsYohQPeZCSsNwns4KYV3jD/0wZzaKsv6vvCIBGiOF?=
 =?iso-8859-1?Q?5ie7+Z0gdg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 995b9b2f-ad8d-45d1-f9d0-08da242b5e08
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 06:43:10.7436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exTLAip5B+TPt2UXCRWaNv/Rw0FRj+Iwxel7C7H9JN9lwSmgtVomPnDy759DcvJ8+dZZnJzhrTDQdgYuVkMasA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2088
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 02:27:45PM +0800, ying.huang@intel.com wrote:
> On Fri, 2022-04-22 at 14:24 +0800, Aaron Lu wrote:
> > On Thu, Apr 21, 2022 at 04:34:09PM +0800, ying.huang@intel.com wrote:
> > > On Thu, 2022-04-21 at 16:17 +0800, Aaron Lu wrote:
> > > > On Thu, Apr 21, 2022 at 03:49:21PM +0800, ying.huang@intel.com wrote:
> > 
> > ... ...
> > 
> > > > > For swap-in latency, we can use pmbench, which can output latency
> > > > > information.
> > > > > 
> > > > 
> > > > OK, I'll give pmbench a run, thanks for the suggestion.
> > > 
> > > Better to construct a senario with more swapin than swapout.  For
> > > example, start a memory eater, then kill it later.
> > 
> > What about vm-scalability/case-swapin?
> > https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-swapin
> > 
> > I think you are pretty familiar with it but still:
> > 1) it starts $nr_task processes and each mmaps $size/$nr_task area and
> >    then consumes the memory, after this, it waits for a signal;
> > 2) start another process to consume $size memory to push the memory in
> >    step 1) to swap device;
> > 3) kick processes in step 1) to start accessing their memory, thus
> >    trigger swapins. The metric of this testcase is the swapin throughput.
> > 
> > I plan to restrict the cgroup's limit to $size.
> > 
> > Considering there is only one NVMe drive attached to node 0, I will run
> > the test as described before:
> > 1) bind processes to run on node 0, allocate on node 1 to test the
> >    performance when reclaimer's node id is the same as swap device's.
> > 2) bind processes to run on node 1, allocate on node 0 to test the
> >    performance when page's node id is the same as swap device's.
> > 
> > Ying and Yang,
> > 
> > Let me know what you think about the case used and the way the test is
> > conducted.
> 
> The test case looks good to me.  And, do you have a way to measure swap
> in latency?  Better to compare between enabling and disabling per-node

By swap in latency, do you mean the time it takes for a fault that is
served by swap in?

Since the test is swap in only, I think throughput can tell us the
average swap in latency?

> swap device support too to make sure per-node support has performance
> impact on this system.

I think we can tell by conducting two more tests:
1) bind processes to run on node 0, allocate on node 0;
2) bind processes to run on node 1, allocate on node 1.
If case 1) is faster, we can say per-node support has performance impact
on this system.
