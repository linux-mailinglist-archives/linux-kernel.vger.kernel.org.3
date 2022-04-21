Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82463509A9A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386586AbiDUIUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376778AbiDUIU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:20:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E433889
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650529058; x=1682065058;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kEAmJUucdM0D29AKJfqux1Y4tKthaJRGqCFdQ62auao=;
  b=LLldYh2li6VQaJvWKnVBmEYoDdtHKFw+QpjsZ17sxFIDl+4TbAUJ+6zj
   x0mHuKdx0IVhTYltMjJrNlvjfPRgGQ99xxvloIA5hulxtCPC6pbz93b++
   DRwpeqhHh0n4jvR6CJhQCIFhNa3qNu0o4Asym9jZz1M/kiBGU15f1zuFu
   fcb5PVF78gpmPgIPdV6QJnS6iC6r9E+ALxlDhH2nQoJZZRu4l2/xtS6km
   nyA+xvwHP9g8ZdwpC55ZPRJVOUUzAfNehUvGAWLsUbzzRoI5FZbHo+a5G
   NFP80UWKqssqxLVz1Nk4x+5SMYdLyE6xZZ2vmm26cbuoHrM85JzTdeGYp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263744404"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="263744404"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 01:17:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="510951527"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 21 Apr 2022 01:17:37 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 01:17:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Apr 2022 01:17:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Apr 2022 01:17:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwMGE2ZNnMEDpgDBlhWNB/9Liws/VhxFN50IpHzJdOX3v6mKLe0CbjgEBVmomC65FmGSh8/M7nIAVf0dx5vsI+0uFVt3rExv1U+JltxzgjsxQNBOlDrVUC9vjobHUQ+9JRQpCzl2PnmPbO4sHpdLm+/ezwbxdkuvYZuvw4d4kI3U5tDbGFc5f5I+9+GTqc/JAj4msliwYKgzJ9p6Cs98h1dv0cd44OeU7Ur6Z5hjT6+K3rGGi+bhUiojy4LVRnr6llnRPHKdMWAa55TWC9OL/qWui+nbVTw6AV/QLFEX5PudPnsDyAJEiRDut8mzHk/PzC4nOkXNw1PK/K5Zgr2Uag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNTxM8bAlRhT+2bOoMX+ixkt/x50OsQ4ZxGNiABDC3Q=;
 b=G7f7TPjiUi7v6WZASYLgw6b2uArN64HnlVc3Hfoa0Uc5KYHzCtLeU0pQ5Gi/YjBEXaVBZ7QXDjZP4HAvpu0R4t4CvVZQkwocxDPEnJTQ0avpf0CdPrcTMh6dCJWg93jtYsJFs8SpLcF7hksMtVU5UW2jDHvv2xzvbwFXYtuSlpqWr4b6G3Fbgt+p9EWlMtpGJh6pIlDTPKHKf9KLd+9lX3I1FDwncRmw0IP1NIJbk7cSpYg2TjHMRAiRJsPVjihkz8SVHkFBhBdhG0UmBFNOznzQx03UbUkTl2uw2lA/DTiLRZvEKNz5TZ62a3WbstsSUN3YWZrnO/NWuHCpyQ10Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SN6PR11MB2752.namprd11.prod.outlook.com (2603:10b6:805:59::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 08:17:29 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::30f5:ac84:8cae:c977]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::30f5:ac84:8cae:c977%6]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 08:17:29 +0000
Date:   Thu, 21 Apr 2022 16:17:20 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     "ying.huang@intel.com" <ying.huang@intel.com>
CC:     Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
Message-ID: <YmETEHnK/FiNbLO7@ziqianlu-desk1>
References: <20220407020953.475626-1-shy828301@gmail.com>
 <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
 <CAHbLzkq+eKcKCsxXDTiOcBxk8FjMdWBqOxwi4N_NG7PZWbAAkA@mail.gmail.com>
 <Yl/FS9enAD4V8jG3@ziqianlu-nuc9qn>
 <f27ec36beb3cf1dbbfc3b8835e586d5d6fe7f561.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f27ec36beb3cf1dbbfc3b8835e586d5d6fe7f561.camel@intel.com>
X-ClientProxiedBy: HK0PR01CA0072.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::36) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 116df0e0-fdd8-4f78-2978-08da236f6070
X-MS-TrafficTypeDiagnostic: SN6PR11MB2752:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB2752AB07B7390A305721A6538BF49@SN6PR11MB2752.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 596OPKW2NhfgYvcgKOUh4SpCJl/p/zcqs+j2bgqiV9y48wtWjrxIBFKVI47eNqX83VSY2jtj0SmkN2VAnQ6ctqbpTv+bhWeBpIrCEvfcB2sQlwx/j49rWynpxuplg7PIwM0JvrnlKlmrlOuY9O4qAxL7Sbv7MHw+ckTfDssWtBjVtFLXB9BaCP4HWydvKaR80lHC8mc/FMiWhTYJjNPuPpnx8RkOxMmv3sX7UgnCo+oYCoYNNnDswxMa47awHtxWm1KLAuTmfWjvRt3qB+Gmw617+7SrpD6YBLQxal8jOUB9rxmoEKeJYsALapczprvq7WJq1OsguQ8FFIzshDuBtMXZHLHCbLNBUxK+gWtdWqkUTwHBhNqB/xP/xTMspBLhKZT3kPI/8e7HHuP/wwfLzbDTcI9rS9EVWJatUZrG39DNQJubVHZyXM77d9HZYCUwsfypMhG544f9b0p4QhTeJ4xwC98gGPCGFdUo0Frk2ngE7ZlxB2AMqjtPOgnwIjzlOIK2FjE3QtdujmujzuhZPA9wsx7vE5xuYdj7mmJOF9ky5na5AI6uSk+BIK4a//DDd2I1c8znL1Q4GyWGOJOSRGPB2lByabvT5C8ZbLxWTeOWv1EECrqU7VpRUhmLzJN6onb5jH/M+YCUnnbk2jZcrG4FC3VYfNkew/TmdtuI076DyIOSAKkiQ37UpG2sZliZrpil0lz78Iv3Xns9xokk3BDEwHGi8dR8xGlFPdb03FE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(83380400001)(8936002)(33716001)(2906002)(6636002)(54906003)(66476007)(316002)(44832011)(66946007)(66556008)(966005)(26005)(38100700002)(5660300002)(82960400001)(53546011)(6506007)(4326008)(6862004)(8676002)(6512007)(6666004)(6486002)(186003)(508600001)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MnGOGXe185BIxuuyQnDPO5dO/AQdWrU6g3rfFwv/n3NrBLviEzDWVwdEZS?=
 =?iso-8859-1?Q?0yDh+9ffuLpjVD3IcU1CA938MtTE02c6L6yA1Vz5J0/HGPQ7WB4LPIZTOJ?=
 =?iso-8859-1?Q?ZQ5r6xXi/7FgJqjpXM3NS96wm5DVEKK0RJCJOawNkoAq/MEvZrJ0fqNcnI?=
 =?iso-8859-1?Q?pcyXmyrqauRw89UkE0ZiVyTmdY3hClI5Pb9a7Ohcg5rup0w85Ave3VOIxW?=
 =?iso-8859-1?Q?37QMl5nXaIX7DPrY0OMITZeyc8qJMv8/eys6yMqeaIUyr/KHyy62OU4b8d?=
 =?iso-8859-1?Q?m8l2K/JNyLXrXZ3IoGKwnDCoYCN/0tS5WUYPZKhL0BSoxnCxYRuWOCGnhn?=
 =?iso-8859-1?Q?OmfeEFpO6DTSTDjTPdHZ+bAHCV1RzqxxXUzuRowzq1wmMECf6m9rdTFvQt?=
 =?iso-8859-1?Q?9OLV2AYVagClb0KcPtNb8ZSENroToq9jxmQXVkm393syfTFqedH/GncxY5?=
 =?iso-8859-1?Q?Iyx2dvFKaRE1gtcjzrDyYlxdMGKl0Y2QIzKYk6iSGF0MfN0C2Ht4nv4hn7?=
 =?iso-8859-1?Q?TXV9IJE4X276gpFRoZC534z8OhU6JtiJ17dhDqcvfRtO0gY/D7HIn14CJb?=
 =?iso-8859-1?Q?Cq2kJX4wLEgknPgpVdU0Os4uwYUoiv9lenLxcobz329gbID2Okl4mRp9Up?=
 =?iso-8859-1?Q?LE7oWl5Us1/Kgjuq4iurDFksEkpZGbeTBcMx9r5kCRUuSaGy0D9pm9qGOo?=
 =?iso-8859-1?Q?/ni4eNJS7plezRylIP9Awb3H9xUplXSojs48IlymD7aFtVmMrSC0rL4TfE?=
 =?iso-8859-1?Q?/QF63DSlNa1anuCx73v97W5GFCBC6gWfgQzyhircv5SNr94movXBoJIdaj?=
 =?iso-8859-1?Q?P3jOSARRH5EUudV6NJe4BwNPKZi8bf52kSxDmFqgih8qtYkoAgIf+2CAEX?=
 =?iso-8859-1?Q?kxfozA85GqivKk4Qrej7WFOhDYQK7/L4PWJVcyMQStxFtl0FJaAAEX5/IO?=
 =?iso-8859-1?Q?qbE4eTN6Ntqb2cUh3pbKhM96JlMhq2IjqiGB3zBct295yYxWO234jcZQ60?=
 =?iso-8859-1?Q?OmN1csw330TeeV5fZ4HXcJ5gJjZfhEe+6hLUxkEHyjFy2mn/SanKOzYiHE?=
 =?iso-8859-1?Q?QK6sETFPj0Y1WeLK2s6HN9ljQBYb+3Gey0mybFa4sWwRzgvQqHsq/HOjtg?=
 =?iso-8859-1?Q?J3t/XXw97NbfG6anTBYxxuSfK/JHeHMLLOo6yIcmvAZJmU4RwLaP1TfYGg?=
 =?iso-8859-1?Q?S7xionX4Xk46101S40FxJCzuxPBQ9j9zw27//RHCTfAEGY7d8Lnm7V2gfm?=
 =?iso-8859-1?Q?iqgszPaW8vVgeBASVzWa6UujJAz1xzCdD3PSXWiDZtWbcxpN9xTRUU28lO?=
 =?iso-8859-1?Q?nOcp1jpH+KnxRuAWx+Fj4UH2UR/3TPotl1mpDzm3kqGdwHJRk/uaja30Ir?=
 =?iso-8859-1?Q?0CxWLyhzt9k+aGAxV+ECSbbxPI+D2NFrKj3WBBhkj3w8u2u0eA/aZdtoxv?=
 =?iso-8859-1?Q?ySt8+3ND/5DVR3v0kgJuO9qasQrBkwKgGTsZKcs7E/53rteeePMqmvcaxv?=
 =?iso-8859-1?Q?XGMh9NOCRaYBqeOvKKrdvDTdcvjKbea/Vgtuq5Q4rq4RmkIBYC3SpOE+MX?=
 =?iso-8859-1?Q?YesU7lUO0mabgvspgbqF585daTPBfQkswWkysyaTIsLAGAY7emfrVcsajD?=
 =?iso-8859-1?Q?n5/QULxcOq4SzJdDTHSC8jVvdVufKIPmwpzyOU2F4e3DGmyl9KYJTpnqZR?=
 =?iso-8859-1?Q?WPSbZex+IynZ44HT0aA1XW6F1KBCpGFpmFQp5h03UvuNwzm1Re+dGPvYgX?=
 =?iso-8859-1?Q?T9YUtZdc5lNqiEYi4whwFNXr6wsY78K/KjneTn8H7S0NsZxfLkrXRM8WVW?=
 =?iso-8859-1?Q?PLHjtl4CGQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 116df0e0-fdd8-4f78-2978-08da236f6070
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 08:17:29.5307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwdVU8+cqJECJ+S3FwcX7+RVAwtvA92g9zC8qjhueI8LrWcLocFsS0dbhZH8IkTAuTCUJAFa6a3rGyoDd2iIVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2752
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 03:49:21PM +0800, ying.huang@intel.com wrote:
> On Wed, 2022-04-20 at 16:33 +0800, Aaron Lu wrote:
> > On Thu, Apr 07, 2022 at 10:36:54AM -0700, Yang Shi wrote:
> > > On Thu, Apr 7, 2022 at 1:12 AM Aaron Lu <aaron.lu@intel.com> wrote:
> > > > 
> > > > On Wed, Apr 06, 2022 at 07:09:53PM -0700, Yang Shi wrote:
> > > > > The swap devices are linked to per node priority lists, the swap device
> > > > > closer to the node has higher priority on that node's priority list.
> > > > > This is supposed to improve I/O latency, particularly for some fast
> > > > > devices.  But the current code gets nid by calling numa_node_id() which
> > > > > actually returns the nid that the reclaimer is running on instead of the
> > > > > nid that the page belongs to.
> > > > > 
> > > > 
> > > > Right.
> > > > 
> > > > > Pass the page's nid dow to get_swap_pages() in order to pick up the
> > > > > right swap device.  But it doesn't work for the swap slots cache which
> > > > > is per cpu.  We could skip swap slots cache if the current node is not
> > > > > the page's node, but it may be overkilling. So keep using the current
> > > > > node's swap slots cache.  The issue was found by visual code inspection
> > > > > so it is not sure how much improvement could be achieved due to lack of
> > > > > suitable testing device.  But anyway the current code does violate the
> > > > > design.
> > > > > 
> > > > 
> > > > I intentionally used the reclaimer's nid because I think when swapping
> > > > out to a device, it is faster when the device is on the same node as
> > > > the cpu.
> > > 
> > > OK, the offline discussion with Huang Ying showed the design was to
> > > have page's nid in order to achieve better I/O performance (more
> > > noticeable on faster devices) since the reclaimer may be running on a
> > > different node from the reclaimed page.
> > > 
> > > > 
> > > > Anyway, I think I can make a test case where the workload allocates all
> > > > its memory on the remote node and its workingset memory is larger then
> > > > the available memory so swap is triggered, then we can see which way
> > > > achieves better performance. Sounds reasonable to you?
> > > 
> > > Yeah, definitely, thank you so much. I don't have a fast enough device
> > > by hand to show the difference right now. If you could get some data
> > > it would be perfect.
> > > 
> > 
> > Failed to find a test box that has two NVMe disks attached to different
> > nodes and since Shanghai is locked down right now, we couldn't install
> > another NVMe on the box so I figured it might be OK to test on a box that
> > has a single NVMe attached to node 0 like this:
> > 
> > 1) restrict the test processes to run on node 0 and allocate on node 1;
> > 2) restrict the test processes to run on node 1 and allocate on node 0.
> > 
> > In case 1), the reclaimer's node id is the same as the swap device's so
> > it's the same as current behaviour and in case 2), the page's node id is
> > the same as the swap device's so it's what your patch proposed.
> > 
> > The test I used is vm-scalability/case-swap-w-rand:
> > https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-swap-w-seq
> > which spawns $nr_task processes and each will mmap $size and then
> > randomly write to that area. I set nr_task=32 and $size=4G, so a total
> > of 128G memory will be needed and I used memory.limit_in_bytes to
> > restrict the available memory to 64G, to make sure swap is triggered.
> > 
> > The reason why cgroup is used is to avoid waking up the per-node kswapd
> > which can trigger swapping with reclaimer/page/swap device all having the
> > same node id.
> > 
> > And I don't see a measuable difference from the result:
> > case1(using reclaimer's node id) vm-scalability.throughput: 10574 KB/s
> > case2(using page's node id)      vm-scalability.throughput: 10567 KB/s
> > 
> > My interpretation of the result is, when reclaiming a remote page, it
> > doesn't matter much which swap device to use if the swap device is a IO
> > device.
> > 
> > Later Ying reminded me we have test box that has optane installed on
> > different nodes so I also tested there: Icelake 2 sockets server with 2
> > optane installed on each node. I did the test there like this:
> > 1) restrict the test processes to run on node 0 and allocate on node 1
> >    and only swapon pmem0, which is the optane backed swap device on node 0;
> > 2) restrict the test processes to run on node 0 and allocate on node 1
> >    and only swapon pmem1, which is the optane backed swap device on node 1.
> > 
> > So case 1) is current behaviour and case 2) is what your patch proposed.
> > 
> > With the same test and the same nr_task/size, the result is:
> > case1(using reclaimer's node id) vm-scalability.throughput: 71033 KB/s
> > case2(using page's node id)      vm-scalability.throughput: 58753 KB/s
> > 
> 
> The per-node swap device support is more about swap-in latency than
> swap-out throughput.  I suspect the test case is more about swap-out
> throughput.  perf profiling can show this.
>

Can you elaborate the "perf profiling" part, like which perf metric can
show this?

I checked the vmstat output. Initially, it's mostly swap out, then swap
in starts to be more and more, but swapout is always more than swapin.

procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu----- -----timestamp-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st                 UTC
20  0      0 259772032      8 2428796    0    0     2     0  365   74  1  1 98  0  0 2022-04-19 11:44:37
 4  0      0 259149824      8 2439084    0    0     0     0 148536 22298  1  3 96  0  0 2022-04-19 11:44:38
35  0      0 236926192   1052 2572000    0    0  2163  2048 392940 3690  1 24 75  0  0 2022-04-19 11:44:39
32  0      0 205170832   1052 2572280    0    0     0     0 193095 1280  2 33 65  0  0 2022-04-19 11:44:40
40  0 136448 192211008   1052 2439412  268 133760     0     0 532052 3571  0 40 59  0  0 2022-04-19 11:44:43
33  0 4224000 192182464   1052 2450936 130636 4211460     0     0 1145644 15600  1 33 65  0  0 2022-04-19 11:44:44
32  0 6908708 192179408   1052 2460836 239456 2924392     0     0 863325 10731  1 34 65  0  0 2022-04-19 11:44:45
33  0 9005036 192163936   1052 2469112 279200 2371924     0     0 739330 9635  1 34 65  0  0 2022-04-19 11:44:46
32  0 10769408 192154864   1052 2476172 305516 2071440     0     0 673619 9044  1 34 65  0  0 2022-04-19 11:44:47
32  0 12318720 192149344   1052 2482708 324312 1875224     0     0 627868 9404  1 35 65  0  0 2022-04-19 11:44:48
33  0 13735796 192146752   1052 2488520 340684 1756308     0     0 601933 11815  1 35 65  0  0 2022-04-19 11:44:49
... ...
32  0 47465984 192000400   1052 2636472 456228 652756     0     0 335570 4359  0 35 65  0  0 2022-04-19 11:46:11
33  0 47652352 191996784   1052 2637932 437368 622652     0     0 328532 3627  1 35 65  0  0 2022-04-19 11:46:12
33  0 47830272 191998800   1052 2639296 428224 607516     0     0 325651 3847  1 35 65  0  0 2022-04-19 11:46:13
34  0 48014492 192001504   1052 2640596 441592 625308     0     0 329752 4199  1 35 65  0  0 2022-04-19 11:46:14
32  0 48200960 191996240   1052 2642148 458724 645744     0     0 333806 3988  0 35 65  0  0 2022-04-19 11:46:15
45  0 48379904 191991904   1052 2643576 442948 621268     0     0 329070 4529  0 35 65  0  0 2022-04-19 11:46:16
33  0 48557504 191996960   1052 2644812 444420 621948     0     0 328916 7249  1 35 64  0  0 2022-04-19 11:46:17
33  0 48729564 191995744   1052 2646272 447396 619376     0     0 329126 4565  0 35 65  0  0 2022-04-19 11:46:18
32  0 48959268 191989024   1052 2647828 595888 825480     0     0 368714 8096  0 35 65  0  0 2022-04-19 11:46:19
32  0 49242368 191990304   1052 2650036 746212 1028524     0     0 411140 10949  0 34 65  0  0 2022-04-19 11:46:20
32  0 49520792 191984080   1052 2652372 758208 1037236     0     0 415505 10094  0 34 65  0  0 2022-04-19 11:46:21
32  0 49799168 191994240   1052 2654724 767236 1046964     0     0 418405 10726  0 35 65  0  0 2022-04-19 11:46:22
32  0 50067712 191989104   1052 2657092 759192 1028600     0     0 415356 10173  0 35 65  0  0 2022-04-19 11:46:23
33  0 50333440 191980320   1052 2659332 750764 1014732     0     0 412144 9197  0 34 65  0  0 2022-04-19 11:46:24
32  0 50584052 191973824   1052 2661576 737720 988964     0     0 406620 8752  0 35 65  0  0 2022-04-19 11:46:25
32  0 50816000 191976080   1052 2663660 689248 921108     0     0 391782 8517  0 34 65  0  0 2022-04-19 11:46:26
32  0 51036416 191970464   1052 2665612 668004 888220     0     0 385112 7310  1 34 65  0  0 2022-04-19 11:46:27
32  0 51256576 191962224   1052 2667536 678464 897872     0     0 388494 12547  0 35 65  0  0 2022-04-19 11:46:28
33  0 51464680 191966304   1052 2669472 654540 862720     0     0 380869 7069  1 34 65  0  0 2022-04-19 11:46:29
32  0 51597232 191971840   1052 2670848 419772 552324     0     0 314325 4029  1 35 65  0  0 2022-04-19 11:46:30
33  0 51722448 191969456   1052 2672072 409300 535892     0     0 310720 4014  1 35 65  0  0 2022-04-19 11:46:31
32  0 51850496 191963472   1052 2673236 413160 541076     0     0 311652 3583  1 35 65  0  0 2022-04-19 11:46:32
32  0 51978872 191968208   1052 2674452 415844 543464     0     0 312411 3579  1 35 65  0  0 2022-04-19 11:46:33
32  0 52105724 191974640   1052 2675616 418104 545728     0     0 312731 4183  1 35 65  0  0 2022-04-19 11:46:34
34  0 52232928 191964336   1052 2676964 426200 552956     0     0 314230 3834  1 35 64  0  0 2022-04-19 11:46:35

The full vmstat is attached.

> For swap-in latency, we can use pmbench, which can output latency
> information.
> 

OK, I'll give pmbench a run, thanks for the suggestion.
