Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1272A55525F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376600AbiFVR2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbiFVR2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:28:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B3A6167;
        Wed, 22 Jun 2022 10:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655918887; x=1687454887;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PsswCxV20qHXuwmNuLBccgIgEFZRhK92d2zKYiyL1sQ=;
  b=nVXCQhxNk5qjXdil4sDkby65bGs54hWQv44j5BmgZDa1dYJeFonxB98B
   6dAcTmZftFKMSEwV5pgWPDsjrsNpOk6HVNwrAdcJcfmR6lszC3BwlPYdJ
   aSLXyXAeUl60486J1OAIO8GUn1AFzMy57eOfGpSZy3TPSjYkxluRaNsTV
   Wz+M3EsLLQBwzY5KXQ5gZHoojiqG+Kbog0hHqvWxVHks6ZR1I13EkwIQm
   J1HrZ36Pp/2T/gCBsdJUx1ZqyyV16DHiM6rvT7Jts1WkYaVE2gRnalBid
   /d031ylsfRCtB1vSbJeHGXM41XuCkedpX+Bf9CdezmNJczCEtX4nHhAH4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="344473549"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="344473549"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:28:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="644303162"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jun 2022 10:28:02 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 10:28:01 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 10:28:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Jun 2022 10:28:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Jun 2022 10:28:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftDBp15WDohKkWkrtA9GOyT1I5tZCymCxCjo5fPoeghhen8fcaS2G89hqRZZxMFXk2fzJj9EOle+nnG4n9SjbpcyK652Mz7vlgGkqoSIPmJ07UQ0tDt/qJbvx09gvqYp4q+nuAibSBgtMyN1GXg0tNZ6IleKsiEkbTEEsGDlMWgGMRDK1ic6R1vAAxS4GfTDBDkExGLcEiqjDM/DwU+Df7appa2v0Gnix7Q3zC6Ri2ieaA0nq5w0rkASSnCetiwoRUJrIkKqoMOzgOSnTZhCPQ0kDMDUGbVGYF8jCCVBX4vaMApoXs+MMTStFgi7g7C6jpzvGzEdK8dtd5nQjU9TnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JV2OR4nzQTs5bT0GpB/qC6nqcrX94YthKdAhncPXu4s=;
 b=iJdJChGLOli6S3K+H/zCvuRhlmmwSb0QlhQhH2pHv1BGABZitgkmxNVVFKrVwFJNTjy5wXrIsxknbJqyrqwqyMKrE+p/NArvVZrfUuB10Ebnv26uHzb+WQyDUOMSi6T8QsOV+xwJbEey3RGj4Ih1LS1+BStRKzmoC+wTUCmjY9TrEuJCrEQ/Q892jNDUo0URrBZ616m4vZpzrMFZtzYxz/u5ZXivA5aCNbUkTL2Zj6VrwVFOGrUcNiZpWsKtaisfRGQVIiBfglQ5RJHWmiuT+QVS/jn04HqvBDVSuow+EKJMbuEZz+RpojOpxVlpX+adJKBeJ590Wwor4vJI0bpRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 CY4PR11MB0070.namprd11.prod.outlook.com (2603:10b6:910:78::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.16; Wed, 22 Jun 2022 17:27:59 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f0ac:be8f:9429:d262%5]) with mapi id 15.20.5353.018; Wed, 22 Jun 2022
 17:27:58 +0000
Date:   Wed, 22 Jun 2022 10:27:55 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] docs: rename Documentation/vm to Documentation/mm
Message-ID: <YrNRGwrivS5Hx2U7@iweiny-desk3>
References: <20220622132258.457734-1-rppt@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220622132258.457734-1-rppt@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:a03:331::23) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4401875c-12aa-4ef6-afdf-08da54748d29
X-MS-TrafficTypeDiagnostic: CY4PR11MB0070:EE_
X-Microsoft-Antispam-PRVS: <CY4PR11MB0070D866B5DF4F5C35446160F7B29@CY4PR11MB0070.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ti5Rzm2OppgJWJjgdkhhGMlPQWrtYi8QOGfSNpDDCB7FwtJfK2AwRB0D4kvJ9eYFE9CVSFRFdDM6BlPseA/1LomU1Uxa6Rana1IjvO+AAgrViDY+/9nIB4vF3qNoO6PNKjlU6JQ/qwBk5eMgf5le+u5vNu6ikoZ5ruvXLREqunHZiIxMNNxZ6FH3+So1a+HQsmxQjh9M4KrQpfXGZoC5/Lm+LJJ+Dh/LZiWUU+nvzpjhOC+t874YPhCBkRB4ySPHp/Ag9Bs9OwOSM3Xwi/T/wVAEHqMXn/G6KysWCZtaSbNNzIp60IA2g3wJ2ZoQSVXkJVfDrNDG1MJWF5/CpiRQT/0enOWIDPmsxP2UqcUZL4jfuAkdOoGXg8A+B4hptpqwfOeKEY7aGU+PXx8rcA6iWNP3xGWm+2H86WRhuWuQuVLBQ53Bfrx9QpM9gjjnyBq8BodptbLc19fTk3HN1tTig4xCtZoPJl4KF3YLIviMvzkZXDNw1SrpDcBfZQ1h91ZvEdFFV2zDs1lg3zo6pq9Vfgcu3CkNN/HyO1lGMoML82UyueIfbMk/ne844v60ZRfhV4fhjwfrUF1X02y1fKx9hx+99KH5RHDquVLtSGeyzFIanbZ6BUKMIoPpMB+q9daQd+gVMMqdUBFs9yYJ8PfYHHSmJVYEG0G5NlKoWTA99w8beGWxoq8kc9K6aNJVRPDH4olCIp5fPxl6moq9coKANQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(396003)(346002)(136003)(39860400002)(366004)(83380400001)(316002)(38100700002)(66556008)(82960400001)(66946007)(86362001)(8676002)(66476007)(9686003)(6666004)(2906002)(4326008)(478600001)(5660300002)(6506007)(6486002)(8936002)(54906003)(186003)(41300700001)(6916009)(33716001)(26005)(44832011)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?obkh9v6XCuGNzkcp2EJGaLoWILNz7AjUW2t0ePVmO/7roNXOzC7XvQreWZ1X?=
 =?us-ascii?Q?LI+z4JyxkiTQshyC2vo2tnLOWZopX7v8CcX/jRKYJQthKKNA5VWtK1z1kSkW?=
 =?us-ascii?Q?5TTsdhI1h1ODXwCc0JoTUAqKBc8NaHIkW59jHNZJQWUFH2KKdmOkj0YRYm14?=
 =?us-ascii?Q?mA7xfAN9xytWyC2TJHgLrqylT5as7aDENHejqvZFXsNr1NR5OJNg1kSzPOKL?=
 =?us-ascii?Q?jU/7+/fiNyKW8rExRVioGF1KwpV7G7Nnec+OYGcSim2UWtaDI01fDdW30Z++?=
 =?us-ascii?Q?92VB4YkeLvSLxWeSP23xzde7vEIykbq7LE6z67kipdEyaUTh9LnjEmAyDpUh?=
 =?us-ascii?Q?ojNvBH+gQon8DpvTBX7ZbMMYXvuNtllDfcMth0q8mA+o7LnIU4aWuIPkJXxK?=
 =?us-ascii?Q?xmishYqRu5H87CBaCDQa60XBZi+FICJjgjboNueDBUTPdhO2HkXqbNILcFlf?=
 =?us-ascii?Q?6aQYPiCh1D+TDzE1DS52fdjTfUQfRCOG0rAwjwo93biYE4TFjOWwat4WPyjc?=
 =?us-ascii?Q?kj0cBxkznMFdRg32dvK7GUiCxinCK5jruZVzHaREYX+QcHPn2+jo9wWkP/Rr?=
 =?us-ascii?Q?GNTPpUOOJDPjz1KIh/Bwt5rvXirgwZaM9YmLTX0PeXT6kUMgNHxyeSqD9xoF?=
 =?us-ascii?Q?HBg2Da9IzG2P+ha7a2AuzvXvMpPwiUKSKDgFaKqpJiERz+ZHdK2dsijDE8w2?=
 =?us-ascii?Q?czW7UA9meTCPcqaZ1G/AGOTux489bwr4GxergTkKXF6bi+/qw6Z4QNk/g/fP?=
 =?us-ascii?Q?byaf6EURavsKONb99sJCVC6VadoGHvMHIGg7WszbkUAox1rEbwmqBn7vzMi4?=
 =?us-ascii?Q?pGuZSw7k7bPBuCrgzt9bapLYGcsgQOUTThokCFRjEPZCjwT9LwWm3wY+8Ozw?=
 =?us-ascii?Q?GZfNeKBiBxIcxvvKdFXC/hd3xao48iogG1gU7wVryxWQmhB2Y0OJXbsxi79S?=
 =?us-ascii?Q?HDoVx2RXfIYfX2fAxbTYGgf4XjKYWu38z+mzpr8PMQCSyMMS+HuNkPG63u7S?=
 =?us-ascii?Q?IsuuYrOgpraOQCR4/oX0ZzucQKed/kqFBVhbBLneaftJh1RN2gHoqU7kuXlu?=
 =?us-ascii?Q?BXyIiaLuAjl786Az/MLUFfnvwjJ4qxfbK+KR0I2NfM7am7kCeyqvkYsfoaEO?=
 =?us-ascii?Q?xpQJOqMcz2gSo08LplMNkbMkzaP0la9wTj8F7rPY+4v8jeCDkxTkzTskJ6qs?=
 =?us-ascii?Q?FjyX4N3EKW0jXPx+PcZOXjjpkSmu2pLKYZV4CisdkfqWcIuzfX/PnjDlR56I?=
 =?us-ascii?Q?iCXmrMb6dKxkSuKOWVw74+jfY7rHakSPidvKDmJiyKDO97FJdnnrbs4BfHLY?=
 =?us-ascii?Q?FJ0XzutdBdJ3EiRwvlbXYgrzwWwQ+171pRImKkZZrC9hVbgkkZo0NYwO2XTJ?=
 =?us-ascii?Q?XZ5NtVtcpbIfVzja9jlpgzSqAEtdxq3RbB0k8swYjB0mMToBYSVAZ9zt6JGm?=
 =?us-ascii?Q?iaSO6qYbswa3TMj5nWHtiyx2lC9QDKQhCUuijBri2LVEcGSnv1LDh1prRxk4?=
 =?us-ascii?Q?CmDEG/cOMqK/MsKSiw3OYdTLh9QODhjPKVxG8CRLAIjIAlpdbK/yq5yezXRO?=
 =?us-ascii?Q?3wbdjscOEiJwj/FZdKfqQKuRRTex0cgU89GgtH+8ObNVHjEekEHhF9tcap+G?=
 =?us-ascii?Q?xm3nWpyyVUbFmTx3rGIT3lp5WT/FrZKuda9b4ImxJ9Py6ZvkvWSK6Y2GkI+D?=
 =?us-ascii?Q?cDDGZeXcY3wZD9slCOo9Y1m4CbH7+9JCA7dtDyULBAvm2Awyy6tCgN7WAbkI?=
 =?us-ascii?Q?s54HGpxYpg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4401875c-12aa-4ef6-afdf-08da54748d29
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 17:27:58.9168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8Uv4QLyZdOp4RX39buGe5S4j6ijhWBqLjkrtlXjLsIzLVY26BTPjrAIiW2WctdzElbJiNOYoS2Z2Grrd7Nnaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0070
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

On Wed, Jun 22, 2022 at 08:22:58AM -0500, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> so it will be consistent with code mm directory and with
> Documentation/admin-guide/mm and won't be confused with virtual
> machines.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>

Tested-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  Documentation/ABI/testing/sysfs-kernel-mm-ksm        |  2 +-
>  Documentation/ABI/testing/sysfs-kernel-slab          |  4 ++--
>  Documentation/admin-guide/kernel-parameters.txt      | 10 +++++-----
>  Documentation/admin-guide/mm/concepts.rst            |  2 +-
>  Documentation/admin-guide/mm/damon/index.rst         |  2 +-
>  Documentation/admin-guide/mm/damon/reclaim.rst       |  2 +-
>  Documentation/admin-guide/mm/damon/usage.rst         |  8 ++++----
>  Documentation/admin-guide/sysctl/vm.rst              |  2 +-
>  Documentation/core-api/index.rst                     |  2 +-
>  Documentation/filesystems/proc.rst                   |  2 +-
>  Documentation/index.rst                              |  2 +-
>  Documentation/{vm => mm}/active_mm.rst               |  0
>  Documentation/{vm => mm}/arch_pgtable_helpers.rst    |  0
>  Documentation/{vm => mm}/balance.rst                 |  0
>  Documentation/{vm => mm}/bootmem.rst                 |  0
>  Documentation/{vm => mm}/damon/api.rst               |  0
>  Documentation/{vm => mm}/damon/design.rst            |  0
>  Documentation/{vm => mm}/damon/faq.rst               |  0
>  Documentation/{vm => mm}/damon/index.rst             |  0
>  Documentation/{vm => mm}/free_page_reporting.rst     |  0
>  Documentation/{vm => mm}/frontswap.rst               |  0
>  Documentation/{vm => mm}/highmem.rst                 |  0
>  Documentation/{vm => mm}/hmm.rst                     |  0
>  Documentation/{vm => mm}/hugetlbfs_reserv.rst        |  0
>  Documentation/{vm => mm}/hwpoison.rst                |  0
>  Documentation/{vm => mm}/index.rst                   |  0
>  Documentation/{vm => mm}/ksm.rst                     |  0
>  Documentation/{vm => mm}/memory-model.rst            |  2 +-
>  Documentation/{vm => mm}/mmu_notifier.rst            |  0
>  Documentation/{vm => mm}/numa.rst                    |  0
>  Documentation/{vm => mm}/oom.rst                     |  0
>  Documentation/{vm => mm}/overcommit-accounting.rst   |  0
>  Documentation/{vm => mm}/page_allocation.rst         |  0
>  Documentation/{vm => mm}/page_cache.rst              |  0
>  Documentation/{vm => mm}/page_frags.rst              |  0
>  Documentation/{vm => mm}/page_migration.rst          |  0
>  Documentation/{vm => mm}/page_owner.rst              |  0
>  Documentation/{vm => mm}/page_reclaim.rst            |  0
>  Documentation/{vm => mm}/page_table_check.rst        |  0
>  Documentation/{vm => mm}/page_tables.rst             |  0
>  Documentation/{vm => mm}/physical_memory.rst         |  0
>  Documentation/{vm => mm}/process_addrs.rst           |  0
>  Documentation/{vm => mm}/remap_file_pages.rst        |  0
>  Documentation/{vm => mm}/shmfs.rst                   |  0
>  Documentation/{vm => mm}/slab.rst                    |  0
>  Documentation/{vm => mm}/slub.rst                    |  0
>  Documentation/{vm => mm}/split_page_table_lock.rst   |  0
>  Documentation/{vm => mm}/swap.rst                    |  0
>  Documentation/{vm => mm}/transhuge.rst               |  0
>  Documentation/{vm => mm}/unevictable-lru.rst         |  0
>  Documentation/{vm => mm}/vmalloc.rst                 |  0
>  Documentation/{vm => mm}/vmalloced-kernel-stacks.rst |  0
>  Documentation/{vm => mm}/vmemmap_dedup.rst           |  0
>  Documentation/{vm => mm}/z3fold.rst                  |  0
>  Documentation/{vm => mm}/zsmalloc.rst                |  0
>  .../zh_CN/admin-guide/mm/damon/index.rst             |  2 +-
>  .../zh_CN/admin-guide/mm/damon/reclaim.rst           |  2 +-
>  .../zh_CN/admin-guide/mm/damon/usage.rst             |  8 ++++----
>  Documentation/translations/zh_CN/core-api/index.rst  |  2 +-
>  Documentation/translations/zh_CN/index.rst           |  2 +-
>  .../translations/zh_CN/{vm => mm}/active_mm.rst      |  2 +-
>  .../translations/zh_CN/{vm => mm}/balance.rst        |  2 +-
>  .../translations/zh_CN/{vm => mm}/damon/api.rst      |  2 +-
>  .../translations/zh_CN/{vm => mm}/damon/design.rst   |  2 +-
>  .../translations/zh_CN/{vm => mm}/damon/faq.rst      |  2 +-
>  .../translations/zh_CN/{vm => mm}/damon/index.rst    |  5 ++---
>  .../zh_CN/{vm => mm}/free_page_reporting.rst         |  2 +-
>  .../translations/zh_CN/{vm => mm}/frontswap.rst      |  2 +-
>  .../translations/zh_CN/{vm => mm}/highmem.rst        |  2 +-
>  Documentation/translations/zh_CN/{vm => mm}/hmm.rst  |  2 +-
>  .../zh_CN/{vm => mm}/hugetlbfs_reserv.rst            |  2 +-
>  .../translations/zh_CN/{vm => mm}/hwpoison.rst       |  2 +-
>  .../translations/zh_CN/{vm => mm}/index.rst          |  2 +-
>  Documentation/translations/zh_CN/{vm => mm}/ksm.rst  |  2 +-
>  .../translations/zh_CN/{vm => mm}/memory-model.rst   |  2 +-
>  .../translations/zh_CN/{vm => mm}/mmu_notifier.rst   |  2 +-
>  Documentation/translations/zh_CN/{vm => mm}/numa.rst |  2 +-
>  .../zh_CN/{vm => mm}/overcommit-accounting.rst       |  2 +-
>  .../translations/zh_CN/{vm => mm}/page_frags.rst     |  2 +-
>  .../translations/zh_CN/{vm => mm}/page_owner.rst     |  2 +-
>  .../zh_CN/{vm => mm}/page_table_check.rst            |  2 +-
>  .../zh_CN/{vm => mm}/remap_file_pages.rst            |  2 +-
>  .../zh_CN/{vm => mm}/split_page_table_lock.rst       |  2 +-
>  .../translations/zh_CN/{vm => mm}/z3fold.rst         |  2 +-
>  .../translations/zh_CN/{vm => mm}/zsmalloc.rst       |  2 +-
>  Documentation/translations/zh_TW/index.rst           |  2 +-
>  Documentation/vm/.gitignore                          |  3 ---
>  MAINTAINERS                                          | 12 ++++++------
>  arch/loongarch/Kconfig                               |  2 +-
>  arch/powerpc/include/asm/book3s/64/pgtable.h         |  2 +-
>  include/linux/hmm.h                                  |  4 ++--
>  include/linux/memremap.h                             |  2 +-
>  include/linux/mmu_notifier.h                         |  2 +-
>  include/linux/sched/mm.h                             |  4 ++--
>  include/linux/swap.h                                 |  2 +-
>  mm/Kconfig                                           |  2 +-
>  mm/debug_vm_pgtable.c                                |  2 +-
>  mm/frontswap.c                                       |  2 +-
>  mm/huge_memory.c                                     |  2 +-
>  mm/hugetlb.c                                         |  6 +++---
>  mm/hugetlb_vmemmap.c                                 |  2 +-
>  mm/ksm.c                                             |  4 ++--
>  mm/mmap.c                                            |  2 +-
>  mm/rmap.c                                            |  8 ++++----
>  mm/sparse-vmemmap.c                                  |  2 +-
>  mm/util.c                                            |  2 +-
>  tools/vm/page_owner_sort.c                           |  2 +-
>  107 files changed, 88 insertions(+), 92 deletions(-)
>  rename Documentation/{vm => mm}/active_mm.rst (100%)
>  rename Documentation/{vm => mm}/arch_pgtable_helpers.rst (100%)
>  rename Documentation/{vm => mm}/balance.rst (100%)
>  rename Documentation/{vm => mm}/bootmem.rst (100%)
>  rename Documentation/{vm => mm}/damon/api.rst (100%)
>  rename Documentation/{vm => mm}/damon/design.rst (100%)
>  rename Documentation/{vm => mm}/damon/faq.rst (100%)
>  rename Documentation/{vm => mm}/damon/index.rst (100%)
>  rename Documentation/{vm => mm}/free_page_reporting.rst (100%)
>  rename Documentation/{vm => mm}/frontswap.rst (100%)
>  rename Documentation/{vm => mm}/highmem.rst (100%)
>  rename Documentation/{vm => mm}/hmm.rst (100%)
>  rename Documentation/{vm => mm}/hugetlbfs_reserv.rst (100%)
>  rename Documentation/{vm => mm}/hwpoison.rst (100%)
>  rename Documentation/{vm => mm}/index.rst (100%)
>  rename Documentation/{vm => mm}/ksm.rst (100%)
>  rename Documentation/{vm => mm}/memory-model.rst (99%)
>  rename Documentation/{vm => mm}/mmu_notifier.rst (100%)
>  rename Documentation/{vm => mm}/numa.rst (100%)
>  rename Documentation/{vm => mm}/oom.rst (100%)
>  rename Documentation/{vm => mm}/overcommit-accounting.rst (100%)
>  rename Documentation/{vm => mm}/page_allocation.rst (100%)
>  rename Documentation/{vm => mm}/page_cache.rst (100%)
>  rename Documentation/{vm => mm}/page_frags.rst (100%)
>  rename Documentation/{vm => mm}/page_migration.rst (100%)
>  rename Documentation/{vm => mm}/page_owner.rst (100%)
>  rename Documentation/{vm => mm}/page_reclaim.rst (100%)
>  rename Documentation/{vm => mm}/page_table_check.rst (100%)
>  rename Documentation/{vm => mm}/page_tables.rst (100%)
>  rename Documentation/{vm => mm}/physical_memory.rst (100%)
>  rename Documentation/{vm => mm}/process_addrs.rst (100%)
>  rename Documentation/{vm => mm}/remap_file_pages.rst (100%)
>  rename Documentation/{vm => mm}/shmfs.rst (100%)
>  rename Documentation/{vm => mm}/slab.rst (100%)
>  rename Documentation/{vm => mm}/slub.rst (100%)
>  rename Documentation/{vm => mm}/split_page_table_lock.rst (100%)
>  rename Documentation/{vm => mm}/swap.rst (100%)
>  rename Documentation/{vm => mm}/transhuge.rst (100%)
>  rename Documentation/{vm => mm}/unevictable-lru.rst (100%)
>  rename Documentation/{vm => mm}/vmalloc.rst (100%)
>  rename Documentation/{vm => mm}/vmalloced-kernel-stacks.rst (100%)
>  rename Documentation/{vm => mm}/vmemmap_dedup.rst (100%)
>  rename Documentation/{vm => mm}/z3fold.rst (100%)
>  rename Documentation/{vm => mm}/zsmalloc.rst (100%)
>  rename Documentation/translations/zh_CN/{vm => mm}/active_mm.rst (98%)
>  rename Documentation/translations/zh_CN/{vm => mm}/balance.rst (99%)
>  rename Documentation/translations/zh_CN/{vm => mm}/damon/api.rst (91%)
>  rename Documentation/translations/zh_CN/{vm => mm}/damon/design.rst (98%)
>  rename Documentation/translations/zh_CN/{vm => mm}/damon/faq.rst (98%)
>  rename Documentation/translations/zh_CN/{vm => mm}/damon/index.rst (90%)
>  rename Documentation/translations/zh_CN/{vm => mm}/free_page_reporting.rst (97%)
>  rename Documentation/translations/zh_CN/{vm => mm}/frontswap.rst (99%)
>  rename Documentation/translations/zh_CN/{vm => mm}/highmem.rst (99%)
>  rename Documentation/translations/zh_CN/{vm => mm}/hmm.rst (99%)
>  rename Documentation/translations/zh_CN/{vm => mm}/hugetlbfs_reserv.rst (99%)
>  rename Documentation/translations/zh_CN/{vm => mm}/hwpoison.rst (99%)
>  rename Documentation/translations/zh_CN/{vm => mm}/index.rst (96%)
>  rename Documentation/translations/zh_CN/{vm => mm}/ksm.rst (98%)
>  rename Documentation/translations/zh_CN/{vm => mm}/memory-model.rst (99%)
>  rename Documentation/translations/zh_CN/{vm => mm}/mmu_notifier.rst (98%)
>  rename Documentation/translations/zh_CN/{vm => mm}/numa.rst (99%)
>  rename Documentation/translations/zh_CN/{vm => mm}/overcommit-accounting.rst (98%)
>  rename Documentation/translations/zh_CN/{vm => mm}/page_frags.rst (97%)
>  rename Documentation/translations/zh_CN/{vm => mm}/page_owner.rst (99%)
>  rename Documentation/translations/zh_CN/{vm => mm}/page_table_check.rst (97%)
>  rename Documentation/translations/zh_CN/{vm => mm}/remap_file_pages.rst (97%)
>  rename Documentation/translations/zh_CN/{vm => mm}/split_page_table_lock.rst (98%)
>  rename Documentation/translations/zh_CN/{vm => mm}/z3fold.rst (96%)
>  rename Documentation/translations/zh_CN/{vm => mm}/zsmalloc.rst (98%)
>  delete mode 100644 Documentation/vm/.gitignore
> 

[snip]

