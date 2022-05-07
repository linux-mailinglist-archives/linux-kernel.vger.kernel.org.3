Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F3051E3CA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 05:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445438AbiEGDbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 23:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442292AbiEGDbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 23:31:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEFE692A0
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 20:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651894076; x=1683430076;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=kqgSoWakex/XnmihE3KfzEcA3hypRrZVJrUeVeuFlVg=;
  b=IiCWZ0cQtWTO5bigoA87itwHQ6bQURaXAWiAmXw8kT8rshsYGR8bBtzu
   DomEzSbIGPWUSMRGdJLdEOEtLXl6x5R4o++ywSWaD4eVh+/Pgf5ytGb4J
   1PoO2mByIx+EqjDzyXD0JNbC6E3Dvjf/d8esdx440NqNSF/tfnxBTYiIi
   UbfjZk95e3umiG1gz++XG99J1Do6jqOWSe1jya/M0NiFW4sGlgIOWAMG5
   KMmW56EMYzSqTqP0RXl6By3j82QUXgtyHgX0Sj5m1Tu6b4QfKEtAl7Ti5
   EqHYIh0NFnEpYXf/Lzh2lKMv/gLOqHrxtDqCPhbfPQdDraunVYoeuNCd4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="268265210"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="268265210"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 20:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="550136577"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 06 May 2022 20:27:56 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 6 May 2022 20:27:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 6 May 2022 20:27:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 6 May 2022 20:27:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U86a3sRMK+fU5JDGu/U5Srm6DOWwHE3yTjT0pS/dFuYePuw8WP9LnECo32lSCmA/h9qRYcWR3NmOCAzMxcowHOgLcbWzh4ZoWypjU0kyyEedQQha2QY4mC/PAUBMqIGdY+c5Z68aK7nSBUwdWk68Fp6QBMP0j8cvxNkqmd6zIEmt+y00eksXMl3U9yOe1O4crcfxVFOqMQJg3SQNNSjErpdEZr/NXeGYlj37rxqu977YY5AtjNgqV2S2pm06uwgt2q3ratpvQwcREN1GEkb/5ZVdnh7LyDgHdybwHlUalEeqlWgUuB9CEYLeGOl0iesIxwYqPnTUUIBGHHqmFylR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0oH3YXcVSKGd5BdBP70qvGwCndWT/jY+/KpVJSx8TY=;
 b=PJKIS4Z22swxfPhTL3luksTBTLvHrGbgq3NibrBy4LzV19jnIPKiSAZ1HVrxD9b/y3NM3tyKWMKHroX1gjBm/3q7UfnyD5Hn5BHHU/sRrk4dqC8+z2Biii6fx7617w4oHvK+PMG2lvN27H9Kk9k1qQOGX3953LUxxScYoGU8avagXM2mM9gnZ5l/UMCGTvmVIwDDg4hlhmdcGUSlICnM0AI50x/JisFGQBY6Vd4EIXCOiuiymzme3gG/VfrNV8XhbkYj2wGaS6kSd9leQJPMMaV5GBpNBudKyxijmHXL2G7c3bt7FZST53+XtOelhcCPwhEpOisB2s5e7wH2Uv9GoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by MN2PR11MB3664.namprd11.prod.outlook.com (2603:10b6:208:f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Sat, 7 May
 2022 03:27:53 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff%5]) with mapi id 15.20.5206.027; Sat, 7 May 2022
 03:27:53 +0000
Date:   Sat, 7 May 2022 11:27:42 +0800
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
Message-ID: <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
References: <20220420013526.GB14333@xsang-OptiPlex-9020>
 <YmvMDyx05UoPFtQy@ziqianlu-desk1>
 <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
 <YnURx04+hE0sQ3v3@ziqianlu-desk1>
 <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
X-ClientProxiedBy: HK2PR0401CA0019.apcprd04.prod.outlook.com
 (2603:1096:202:2::29) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10356a8d-d3c2-416d-1df3-08da2fd991db
X-MS-TrafficTypeDiagnostic: MN2PR11MB3664:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR11MB3664754EC845CFDF741EC8168BC49@MN2PR11MB3664.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFINZpUBEC21RNnPJbxFR15b7r1LD5JUHbK8pvzwfp098EXG9NE6jNhbE9VzNaC4vkIvimNX74M7xVIET1FbYnIbsMZzZSyfjf+z4Bs3w8nXaGTWWen/pm7hINus/E81yfR4EsN4eR82uRnDGLJqpSmRR04lDQaoF2xXEnV/M98uqtdPALHbUDcaCWtUlAXSeRCm8ji4mpJvRzWZzJ1e+3m6mH4Y+kGbYeSXqPggF0rgq4n8ZnbV9I+DwXtEVApEAV+hdXGTJ9rs5Fwzodue9ge8oE5OiMXXk2Tjqkop+V26ZHedW/1qxglBcQe1J57XzalaCeLB4yUPSqcwXXmAbiNDX3QQ6DfKhKjbi+Bmmk2HqzGf7FaSkTMrT08PGv1ctZjlLsyHLsHMOsCSlIVmds2D0ecKxY3jpaDK20TDcXSlPdD7oYZaK1NjqMqXM0NZRXbxQk7uzaHAqEnFAHxtVNeE1RYzbvpY2AFndZ+oGL1YqSeu4tL81EAC8TkqV2GIugoDAsKsY+T61D5y82He7mrKsNtQF6qGc6akGl+5hdJ1NTV+3M103Gh5zaQi2kFTQhGe9div3iZwm1tIMzRdC8Qp9+tyHvR3mEw2ghC38zRgMiEfCTM+10s5Eps7uFibkWxFNMs0/FtGw/GwfRHW5E5jp5KiDdiSY4R7TYJ8MBG8RaGOBTSckNBnQmreLjVObkUzyTjA3cVy6pKm81c+uDMRhZGXAelewiHlTJxRYqqvNPZb+A19ETzjZEBJyck/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(6506007)(38100700002)(6666004)(9686003)(6512007)(26005)(82960400001)(186003)(5660300002)(66476007)(83380400001)(316002)(4326008)(6862004)(66556008)(66946007)(8676002)(33716001)(44832011)(7416002)(2906002)(54906003)(8936002)(6636002)(508600001)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?p3VYpHouVbCMeC5pE9vsbluGatpPI5yA/RNJwJCy8QtfQM3kZSfO3B+Wvi?=
 =?iso-8859-1?Q?G0AZ4Ui6zjLSCRnxTWqZOYMyIhaCd+/T3qydthhIMkD7cJqRvL8riihJ99?=
 =?iso-8859-1?Q?qYzaISS7r+4SYYF0XEEv03mqvlELKp95S+m9BuNkDViCbJe1qMtsa8spmP?=
 =?iso-8859-1?Q?oqA3lrm8Y/R+kJeWGxpv0UUjvYYiepUGKZOvDtr+Ef/JaiHgji0nyQ3HVn?=
 =?iso-8859-1?Q?tfnUvcmiEJDn1ausu5gq8a0UV4m+4QF+w0QkdiIXar7F4A/RbEMXgO1uDJ?=
 =?iso-8859-1?Q?0UFMW6q/9u2/PE8F5X8sJiEejszE8K+vx+IrBf4OmaH1y51/idA4bz0bXh?=
 =?iso-8859-1?Q?BwW8rv/XrbNZ7rEEPAgb/mxNgUfA67rfZcfFJsgn/PoSeQFK9My5aEfSBu?=
 =?iso-8859-1?Q?jYvZ9PaEBw9Jx9CGJkM2Xoh7H77Tkv9IwCj64ouk0UadGKO42XtSNIlcUY?=
 =?iso-8859-1?Q?rI+qFH0XdItNaM+fia9hoxB5qe+CW3wqFokmCck8CATj0ikl9RX/8HHxpn?=
 =?iso-8859-1?Q?8y0Zxn//WR9CdYRiSP2d78035VVkJh+AD9nTP27XLEU+Qkpq+7tqe41q4u?=
 =?iso-8859-1?Q?+kt9yHGKbzQcl4L4wGw/I50s5T7Hpbz6NM0UKDj+SFn99+5UAEokOUHD95?=
 =?iso-8859-1?Q?egHqzhw6pvvJGmQjZ2BPRQDrgeLd3WDUR+E6wOJIfqqK2f8upeFEKZlp55?=
 =?iso-8859-1?Q?WQiCMDeaEF2xcPHDdgEAg3qEmXyDpmHU/kwf6diVcaN8gyLOSTHpJWuD2e?=
 =?iso-8859-1?Q?feJNryxvftSV1hZmOPGp0tO7/hTkqP02lv98cbi4cmJLuWsk2B/IgGjug/?=
 =?iso-8859-1?Q?w6iuc5Q0zU9HcmjO/pqcEigTLENJvvt5+HwmTNd5wibbtzKHMmIjIp/agx?=
 =?iso-8859-1?Q?3mZzuk+5V9bAqC1wIX31vrIdhfKH3byWV7IvZ9fiI7Cb+EQhnCjwtCi/hs?=
 =?iso-8859-1?Q?5xJyPqrQIOegi0T6heqSz+R3piWlv629Lv4n237t4wzWHWdFlGc4yta9Pg?=
 =?iso-8859-1?Q?IXRbyqJeXjonVUNaM2FYeqjpy6U6oCojeSGjPi4A0prLsPS1/6/ohCzY4W?=
 =?iso-8859-1?Q?pwotk5/1ti0jO94qOqOzzms8Rgbv6a11swyVcx5BNfMr8f4G9KrS7Z83Bc?=
 =?iso-8859-1?Q?MhwA8ndt++wHAxXvOCvkD7h/C9PSEprY2z8uTyfWl4qjSbfz33hhS3xP2S?=
 =?iso-8859-1?Q?KsPktJemKgVRgkGjaC9OS3nxX/k36Ll/FM6Pz4Snu2LdbMohQgl1DDx4sg?=
 =?iso-8859-1?Q?f8bo5pMdFJkVfE17FSMPhbHVcMPs15qwq52fHT+UT80sXmlGDaV9at2yJc?=
 =?iso-8859-1?Q?7hiQpitqG/YTFwxMug3YGypOhFkmOfqA8jpvsDMguLXhw4sRbuYSwaeRM2?=
 =?iso-8859-1?Q?c3p1kZpueK571RQCMo6DZZCUGC3cX39Pd1jiU/pClX1DwLJqR34s3q0w/d?=
 =?iso-8859-1?Q?KYtBmEMcucrG/j3KQ/ji4zzHwlFBXQZkEtFSD60yBCISxO6zdw9EzYf2yq?=
 =?iso-8859-1?Q?2wwgdpUvoQyOpUlcSWllWGRo1RPexPKsZ21+R9kqLlcy2mcDnKePpnj8i2?=
 =?iso-8859-1?Q?YI5eCoLK9Mw1BEmjQWpEeivDe7nC2CHEH79lfPk7EbWNTzU3v7+vntsOci?=
 =?iso-8859-1?Q?wp97rBxnVaeG+hq6GJjn4onxHmuZ7Jzlm9S5k0CTStTfLUzb89esPco0lS?=
 =?iso-8859-1?Q?Fv0MnwFWJu4+ZgxOtSsh3jD3p8YT3/KUcLC9dhOqVZptS6CSDhySb6bh+6?=
 =?iso-8859-1?Q?R7LXj9N0K7XYM8EVt1ZDn0h4MoY99hcq/2IMwyXJ57qhC4ZDgipCyjhvMN?=
 =?iso-8859-1?Q?m2KZNEI2lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10356a8d-d3c2-416d-1df3-08da2fd991db
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2022 03:27:53.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVooiR8jv89oc4o76QNxnixYWh9z4VVnEuAf8FPJKO/JE4e7QHcPykN3jb/5fI05CqsUt+CaNw0iGTodGpZmyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3664
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 08:54:35AM +0800, ying.huang@intel.com wrote:
> On Fri, 2022-05-06 at 20:17 +0800, Aaron Lu wrote:
> > On Fri, May 06, 2022 at 04:40:45PM +0800, ying.huang@intel.com wrote:
> > > On Fri, 2022-04-29 at 19:29 +0800, Aaron Lu wrote:
> > > > Hi Mel,
> > > > 
> > > > On Wed, Apr 20, 2022 at 09:35:26AM +0800, kernel test robot wrote:
> > > > > 
> > > > > (please be noted we reported
> > > > > "[mm/page_alloc]  39907a939a:  netperf.Throughput_Mbps -18.1% regression"
> > > > > on
> > > > > https://lore.kernel.org/all/20220228155733.GF1643@xsang-OptiPlex-9020/
> > > > > while the commit is on branch.
> > > > > now we still observe similar regression when it's on mainline, and we also
> > > > > observe a 13.2% improvement on another netperf subtest.
> > > > > so report again for information)
> > > > > 
> > > > > Greeting,
> > > > > 
> > > > > FYI, we noticed a -18.0% regression of netperf.Throughput_Mbps due to commit:
> > > > > 
> > > > > 
> > > > > commit: f26b3fa046116a7dedcaafe30083402113941451 ("mm/page_alloc: limit number of high-order pages on PCP during bulk free")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > > 
> > > > 
> > > > So what this commit did is: if a CPU is always doing free(pcp->free_factor > 0)
> > > 
> > > IMHO, this means the consumer and producer are running on different
> > > CPUs.
> > > 
> > 
> > Right.
> > 
> > > > and if the being freed high-order page's order is <= PAGE_ALLOC_COSTLY_ORDER,
> > > > then do not use PCP but directly free the page directly to buddy.
> > > > 
> > > > The rationale as explained in the commit's changelog is:
> > > > "
> > > > Netperf running on localhost exhibits this pattern and while it does not
> > > > matter for some machines, it does matter for others with smaller caches
> > > > where cache misses cause problems due to reduced page reuse. Pages
> > > > freed directly to the buddy list may be reused quickly while still cache
> > > > hot where as storing on the PCP lists may be cold by the time
> > > > free_pcppages_bulk() is called.
> > > > "
> > > > 
> > > > This regression occurred on a machine that has large caches so this
> > > > optimization brings no value to it but only overhead(skipped PCP), I
> > > > guess this is the reason why there is a regression.
> > > 
> > > Per my understanding, not only the cache size is larger, but also the L2
> > > cache (1MB) is per-core on this machine.  So if the consumer and
> > > producer are running on different cores, the cache-hot page may cause
> > > more core-to-core cache transfer.  This may hurt performance too.
> > > 
> > 
> > Client side allocates skb(page) and server side recvfrom() it.
> > recvfrom() copies the page data to server's own buffer and then releases
> > the page associated with the skb. Client does all the allocation and
> > server does all the free, page reuse happens at client side.
> > So I think core-2-core cache transfer due to page reuse can occur when
> > client task migrates.
> 
> The core-to-core cache transfering can be cross-socket or cross-L2 in
> one socket.  I mean the later one.
> 
> > I have modified the job to have the client and server bound to a
> > specific CPU of different cores on the same node, and testing it on the
> > same Icelake 2 sockets server, the result is
> > 
> >   kernel      throughput
> > 8b10b465d0e1     125168
> > f26b3fa04611     102039 -18%
> > 
> > It's also a 18% drop. I think this means c2c is not a factor?
> 
> Can you test with client and server bound to 2 hardware threads
> (hyperthread) of one core?  The two hardware threads of one core will
> share the L2 cache.
> 

8b10b465d0e1: 89702
f26b3fa04611: 95823 +6.8%

When binding client and server on the 2 threads of the same core, the
bisected commit is an improvement now on this 2 sockets Icelake server.

> > > > I have also tested this case on a small machine: a skylake desktop and
> > > > this commit shows improvement:
> > > > 8b10b465d0e1: "netperf.Throughput_Mbps": 72288.76,
> > > > f26b3fa04611: "netperf.Throughput_Mbps": 90784.4,  +25.6%
> > > > 
> > > > So this means those directly freed pages get reused by allocator side
> > > > and that brings performance improvement for machines with smaller cache.
> > > 
> > > Per my understanding, the L2 cache on this desktop machine is shared
> > > among cores.
> > > 
> > 
> > The said CPU is i7-6700 and according to this wikipedia page,
> > L2 is per core:
> > https://en.wikipedia.org/wiki/Skylake_(microarchitecture)#Mainstream_desktop_processors
> 
> Sorry, my memory was wrong.  The skylake and later server has much
> larger private L2 cache (1MB vs 256KB of client), this may increase the
> possibility of core-2-core transfering.
> 

I'm trying to understand where is the core-2-core cache transfer.

When server needs to do the copy in recvfrom(), there is core-2-core
cache transfer from client cpu to server cpu. But this is the same no
matter page gets reused or not, i.e. the bisected commit and its parent
doesn't have any difference in this step. Then when page gets reused in
the client side, there is no core-2-core cache transfer as the server
side didn't do write to the page's data. So page reuse or not, it
shouldn't cause any difference regarding core-2-core cache transfer.
Is this correct?

> > > > I wonder if we should still use PCP a little bit under the above said
> > > > condition, for the purpose of:
> > > > 1 reduced overhead in the free path for machines with large cache;
> > > > 2 still keeps the benefit of reused pages for machines with smaller cache.
> > > > 
> > > > For this reason, I tested increasing nr_pcp_high() from returning 0 to
> > > > either returning pcp->batch or (pcp->batch << 2):
> > > > machine\nr_pcp_high() ret: pcp->high   0   pcp->batch (pcp->batch << 2)
> > > > skylake desktop:             72288   90784   92219       91528
> > > > icelake 2sockets:           120956   99177   98251      116108
> > > > 
> > > > note nr_pcp_high() returns pcp->high is the behaviour of this commit's
> > > > parent, returns 0 is the behaviour of this commit.
> > > > 
> > > > The result shows, if we effectively use a PCP high as (pcp->batch << 2)
> > > > for the described condition, then this workload's performance on
> > > > small machine can remain while the regression on large machines can be
> > > > greately reduced(from -18% to -4%).
> > > > 
> > > 
> > > Can we use cache size and topology information directly?
> > 
> > It can be complicated by the fact that the system can have multiple
> > producers(cpus that are doing free) running at the same time and getting
> > the perfect number can be a difficult job.
> 
> We can discuss this after verifying whether it's core-2-core transfering
> related.
> 
> Best Regards,
> Huang, Ying
> 
> 
