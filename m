Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FE54B959F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 02:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiBQBnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 20:43:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiBQBnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:43:45 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D25121FC58
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645062212; x=1676598212;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DlYMFKlG7MF/YDI72tJeerM43MSq3pv/Rp/e5prl2xM=;
  b=RcfnaucHyHVGzDWM6r6pEaUu1S12X4nyh+h5gv7bi6DAsVfcHS4D7ckW
   5ynGeqxFyJ1/G/XSFIbOHf/Wl/bgep+kCZizfuJ9LrcYgdHaTXBG8cQ3m
   eov67iaje+oDedB5ht0tTJRvgV1aFo7SfZva6XWfG/gXHhHHudrfmrfLP
   il8TM9HOGI8o7cgGo9cTqMvflT4bLDjmpSvlfTo0iGpSME5Ck/L2xUt9i
   Guj+OK46w1dta+OHrB9UvbMROSS+LIyZJtJV+qK3Dw1DZzGOXmwPN68oI
   TTzd6ZCArODlYdp2RKqxzLwKqJgMUU+AaqV6BXp7WlwCQQ4tH764U3yxd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="230728690"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="230728690"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 17:43:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="588916367"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 16 Feb 2022 17:43:32 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 16 Feb 2022 17:43:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 16 Feb 2022 17:43:31 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 16 Feb 2022 17:43:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbX/4v8hPjEE4eLNgg/KjN2QVQ3C3L9zKtofqhOyS5D3UFGjW7FnL1GWF8QEdiEfvsIYi8fZ4SVBMqNO+8UBZt2RlmNwoNRdWLPcFhij0tu0b6jT2ET/rqtEAuIEns8N86ep0uXozDdeNVWg8KQz2M+cD1QFsGGuptjuGu2xmVUYtwF0pNbMtO7RIzASOH9RIbjuAX6rGLlGK3AXiytn5oq21LAP0qoNu4egRe1NWWS81DLAAXOPqxo1bgvJglTsItuKquZq2J63mu/UyHstBCr63MdK2ag7y11hh0Q+dfxSxzMW56olkY8mpYooFl1nhQiJDQCW7xtYi+4YaMbEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtT7cIrFUXWsEp2PwbPGwNCQvTUQAE4YmVKZHRMzQnU=;
 b=SjBfeBevHanwzN670BFDrkdGoUhPcqKu7qexmY+v5nYIc1Z+3/R1yDyRQRmU0OJPJepal0c0S3o4SPMX5aBg69GkOB3A/E44is/TCKTOpXxLzcQyoeZSsSvwZnapSFYVJLrVXaBtH/Di6mZsH7C9HIIN9lk9zJm9ZCB4RGOi4a+RfRiyb0OqQNwQeP7GUehU3Pa0YjDKGy3IAlQXhLiTwGVscVcVSX0OwlrwK/xPDIiO0suOIBy4MFqVhKFSbINRQCyL81VHlhswasWuTWIDS7Y1X5GtQ7J+GnvmYRcPGVMEyF0GlGCbxq+HijSD49sgslxPwZ4Kou0CWffMPNC02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3060.namprd11.prod.outlook.com (2603:10b6:208:72::24)
 by CO1PR11MB4785.namprd11.prod.outlook.com (2603:10b6:303:6f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Thu, 17 Feb
 2022 01:43:30 +0000
Received: from BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::2477:ce52:e1c4:387]) by BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::2477:ce52:e1c4:387%5]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 01:43:29 +0000
Date:   Thu, 17 Feb 2022 09:43:09 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 1/6] mm/page_alloc: Fetch the correct pcp buddy during
 bulk free
Message-ID: <Yg2oLQTRt0ZhEXar@ziqianlu-nuc9qn>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
 <20220217002227.5739-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220217002227.5739-2-mgorman@techsingularity.net>
X-ClientProxiedBy: HK2PR02CA0188.apcprd02.prod.outlook.com
 (2603:1096:201:21::24) To BL0PR11MB3060.namprd11.prod.outlook.com
 (2603:10b6:208:72::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b29e1ef-fa10-4cff-3df8-08d9f1b6dee1
X-MS-TrafficTypeDiagnostic: CO1PR11MB4785:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CO1PR11MB478538E6569E7378E8E027198B369@CO1PR11MB4785.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBMGfBdPLeSwaJFpge/Ew3eNQWZgviQG7vHUqqIweK3I+3IrN0xGjR3BPiFMdYoOPHXd6WtkiD02SFhTRTfRfXoHMVZnCMmrmArtWa99nybeR+GToHgLbKufg7Ayuxt2KNdpQFcCo9qAS54r9GMrlFVs0npAntV3I5SbNN7lYo+zWQO2awPO55E/Oy3L/OlOFYwvM3gWkPZH6eu4q8VEY1IInl2xDPzAuvgBRVCRYlZM5D8zux6edgEqT3m9GJa7kKw2IdM3awEBXGCfl6PyGDQVfsoPJxius0NEFQoOXc2xO2g3gtVzmpSwn2Cw8aiLG1fph7kWIQfGv1tO9dXq9iIpWwTtE3oEgvbBIsuuY5BAJFoTPsmnMQ4wwabvqEccJinBx78PetkoXYFqyk+2E/wEK60y5tcakrlcYV/yPNjHDLAhe2kjzL5o2WTdCt/Fk64HpClUxTsXpP6hy6BPPO4aBdLKJVGER47XPbJ3y0tETjsAk3yUAr8/LSAAiraph4Ef6lv4ErOAL6iisj/vpj2XmfzBlDb7tMni1eBF8NlwIjBbf2S5Lu/P6ZfSrgLFfQuIU6WpFGelSPJ7AY+20LAMy2ZPgUOKpsZck/4vnGiK+Oz3wZDfxadA135oixtxGHDzxPuiB5QEEe/V46/hgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3060.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(6486002)(38100700002)(6916009)(54906003)(9686003)(66556008)(316002)(66476007)(66946007)(4326008)(2906002)(82960400001)(8676002)(508600001)(8936002)(4744005)(83380400001)(5660300002)(26005)(44832011)(33716001)(6512007)(186003)(6506007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dqYy7ihMB8W922UYQWt4lcqsji9Ll5VmlkC+MQ+UhiTl+sFxvsD+0NPZavP6?=
 =?us-ascii?Q?ZTrqtseJyEhdbnauZLvN8x47PlbNxV+QvBRpPcgdATnPx6gZUgqXyBDPvZVv?=
 =?us-ascii?Q?zwTL5ekty3deMDQ/PuwnZQIke3HYExhtriZPyjQ/41xjyA1XongWt2GEXkki?=
 =?us-ascii?Q?Dhom7JpfZLzjIKaMkmqQfh4i98/3UkVKOAa8GAu+cjwnb4hsCN67nLHlH+Gh?=
 =?us-ascii?Q?YzLwvjZ0pfNI9B9oGHWS766QhEnN4zzxnzjOWBAf0UobjecNQBVcbSUbBB/+?=
 =?us-ascii?Q?kBHAR61UB32llF4bmvjLVvbshVAMCNUjM/xfQQN2L1vnIJDU3rNOmZeom/ZJ?=
 =?us-ascii?Q?heby4QKgQiy6tYs8Dhk3vkwSVvqPKi48Mczz/NGkOcxuFlvdCgaKnVi6abL+?=
 =?us-ascii?Q?5AISLlBFKJaKcal0jvLDUtrdM8OBxrKbswhS/PdKsJl/H28cdPFgs9JJwRa8?=
 =?us-ascii?Q?d3OB+alXLChvQxP9QmlOToUQFnvjXVyEtp6LNmRh8u79jDZvXAZy0E/+EknS?=
 =?us-ascii?Q?RAPhhZNInYtctfECBZJuFvKO1p1453zMBBDiE40UcKsqKFzIRRfSv/90IFlc?=
 =?us-ascii?Q?M2tTrfwS2tUeS//z+3wWl6aiNWii4RhDGsroFk3Y52/+wHTEfYLMU8gnHxgl?=
 =?us-ascii?Q?PjQiy0txQZJE85k5aVHcyQfZBRO23IezpUTy3NblCzoGFqNVrhudgnxscAR9?=
 =?us-ascii?Q?XjeTRh+eL8W7mcYe8rK1JT5wrblGayYTMamVw7mVyMvZpGQRI+NT5E4O3Ks3?=
 =?us-ascii?Q?5Rrk6BTpq2rqV1nybpaVRlBhk1NO4EWTEAKCP5SyfZ6/9ZGOqZJrer1rZo77?=
 =?us-ascii?Q?dt8LGG/eveaF1MqRUD8oXJNoAU0b+6LdaCkc620tLUB0eTsgTOqjvwp2ujTd?=
 =?us-ascii?Q?ZbDsqQbQ73LlPSqmN5bb2gtQuZHMmNyJjXRSkLmb1lhPe+p85EsKLvGNA50P?=
 =?us-ascii?Q?pdudq6fnr/YnItIYydGZjnVJQTD+SvVeB53k8ojCErO64zpQR1vrW8plLjCV?=
 =?us-ascii?Q?cUw/wpxG8vh6xV7MjF/zyNBPdtTfoSQqgAP7xecCUuIea77r7ozkfpo39vpy?=
 =?us-ascii?Q?BmBskEiLNlYKt+cTBfLOSLvEAfYQs85WdSRsFYMYIqIPJ5X1l6E5xHIij1yt?=
 =?us-ascii?Q?wUZECNcG+L4jK6eJDK20oSEOeq6RGHz/VOjl4AyUeoNgWAruzJU67zfDTSLj?=
 =?us-ascii?Q?nOZYIToD0TunF568ro/lJxnESPO3opQPvyBVXb3YE+h+9K9p7/HY5gUBGQBt?=
 =?us-ascii?Q?aWCjUmqwteKPnhgXgnDOzj3w2VUk9FFlgIGw//pmguBvpxpYXYtrWAb5mQ5d?=
 =?us-ascii?Q?A31hqboH4g3ga18nEwvySZXzTf530pJwEHymHz/4FSW3WOOniOmxvwDnyGXt?=
 =?us-ascii?Q?CTDm9w5I9i2mIAszMXc7d/ah96yEc+rqUoa//5ItkD7ZegB0y/Jru65EWFet?=
 =?us-ascii?Q?nAca0qwNascmoDDDVF1WYpy8ArgsrB/a7UduB1FhCFgX8mMjy6gzaSXofYlx?=
 =?us-ascii?Q?lh6L9Ma6YL1DB7sz+iZJ4M8BoxhGZuvE3YpQeRz0sZMul7E8+OfX1fgs3ec7?=
 =?us-ascii?Q?nWptkAv3OAIKPpmmSMJrateKH90j6Os0+1DNJhSRpf93rXaTvXFnlyAQUytx?=
 =?us-ascii?Q?DOGNF7isATvDf2uwLxp340Q=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b29e1ef-fa10-4cff-3df8-08d9f1b6dee1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3060.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 01:43:29.0587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZq8rmrpQBDuQDeigtWq7lsZ5c+axW6pJUc3ONcY2JJb3iysGIKXW0dfg4b5pEIGeMPAEeJxwKFGyg+JHjZk/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4785
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 12:22:22AM +0000, Mel Gorman wrote:
> free_pcppages_bulk() prefetches buddies about to be freed but the
> order must also be passed in as PCP lists store multiple orders.
> 
> Fixes: 44042b449872 ("mm/page_alloc: allow high-order pages to be stored on the per-cpu lists")
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Aaron Lu <aaron.lu@intel.com>
