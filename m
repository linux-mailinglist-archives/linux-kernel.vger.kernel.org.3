Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E6659559F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiHPIwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiHPIwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:52:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A919331EDF;
        Mon, 15 Aug 2022 23:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660633044; x=1692169044;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=uN4NRxLuK/Aw5suZZTIqTCe1QzUwQdl0NiArFChapvs=;
  b=UpK8AoktxADKTd4qQP/nUeldYLVY0ameuP9jTUwe91jKAtI26NA1IHl2
   PgWNRySNwXNZHv12OXXEr9LVKCu9mOt6wF52Op0DTU/rUxQejblbeCefJ
   xRxo+xSh33av/3vadFIYGCw7jZxIjQPJZaIhZTVlcpiO4W1weq3ZdOhTv
   KKs+54CqGexBZTMUNa+YT+KG6ykhYHbAzUKTyfTwxKmALI1vT091sFBN6
   GwVlaV42ez0SZ3S3DWEalEMVOm35zxQ8PVXdyMdilScAVUrsmFINhJf5x
   pLKMPuCsRDRq1zchHWRq1gCcLqR/3sW/eTBpkvKeKNXCcgneEydp/shcQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="353886113"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="353886113"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 23:57:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="733187641"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 15 Aug 2022 23:57:21 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 23:57:21 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 23:57:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 23:57:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 23:57:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njy1VZn6PD8LI1hEcRCJCRkgumZ57MQjBMOL1xwwCuahoeC2ZbTi8fWwTghMlc2MqK0F4/I9K94FhD5nFDciiSu+kiaw2f3NC/pe8g1r06K93ttKQSrt/kkLb9R/GT9u3Vg2ZsxSGD3qNSNpEvsYKbyVEknPBF4Kna6C/MBhUW5BZzyk+DJAC5j84nu+5wSgVi9vquAhdmbEu4wMgFyw4riPJPLdouyT4xdj7TdMCtD8EAbPSxTPNbuCFe2KUIzPJnqhqpaBH9Nrd6cooG3f03Tc46f0KwDPs5qtkmxxlyu+Sb3AIORObInluMKLX63h6i4p9UegAs41RP2L2+0zvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0i016rQBWIXZmKOU8Xn21XrFArchAhDB7Hs3ok5qlaU=;
 b=Zty2yjHnwP4b3xP9QXQaHqLx3I1L+WuxYTvpqH1Nb7MEx+pnC/DygZKFo6TRYzAeh4np/Jhnfvi9ubXvQaRlVYY3SlvpUhZQL3QNvXTOaNIOFpXD3l8fy5aCVl4b+0A1H2jzZGc0ZnukoBTrGVAxi97Y/A8+d11GZqjFKpyNE/Dzc3nOVIgqNf4fGmcG9oZiiNetfm15YrN+Gc9bl6eRfUSMG9VykCRzs6lEV+LRdermpOWnD2PwFYTJaF86drOBCFq3vvMqI0Mt8MDEBxzdRtMFvoBXnN3SoMcr9BuOZvQmxVqduzew7xMITSXSHGvOcPD60qYRSw8oFDWVx2VzKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by MN2PR11MB4565.namprd11.prod.outlook.com (2603:10b6:208:26a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 06:57:18 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::f906:b045:d73e:8e49]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::f906:b045:d73e:8e49%9]) with mapi id 15.20.5525.010; Tue, 16 Aug 2022
 06:57:18 +0000
Date:   Tue, 16 Aug 2022 14:57:07 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     John Garry <john.garry@huawei.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-ide@vger.kernel.org>, <lkp@lists.01.org>, <lkp@intel.com>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>, <fengwei.yin@intel.com>
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
Message-ID: <Yvs/w93KUkgD9f7/@xsang-OptiPlex-9020>
References: <YuzPMMnnY739Tnit@xsang-OptiPlex-9020>
 <1f498d4a-f93f-ceb4-b713-753196e5e08d@opensource.wdc.com>
 <3451fa5a-6229-073f-ae18-0c232cd48ed5@huawei.com>
 <e4106ffa-3842-45c0-9756-5226cfcfa17d@opensource.wdc.com>
 <YvXeuCAK780OuJPz@xsang-OptiPlex-9020>
 <2e9cf5a6-c043-5ccf-e363-097c6c941891@huawei.com>
 <f1c3d717-339d-ba2b-9775-fc0e00f57ae3@huawei.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1c3d717-339d-ba2b-9775-fc0e00f57ae3@huawei.com>
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d90bf48-44a9-4d20-692e-08da7f548ef5
X-MS-TrafficTypeDiagnostic: MN2PR11MB4565:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FjsVkpQN4lF9lFSSl5QxI6unjdAhDbdj/7jbpPyhsnF6OWOEqF6McAW6epERrmFlU60e3MF+IhJmuWPrIq8ehpuhNNlcEpVId3OV0gMtIhJRUjg+ZM937yJkrV2SjJA1eMUfqagQcWXQ1z1aG2097znzSPeDnAhtpeOm59gKr6scnyk/CV2JDhHtDGwRvOAJMmt7GmU5nFuIs9s5ZKlC4cvxilDk9I9h8GCjwBUp5te0i/DA2JoCCu82RqSOWKGRsl3HDjaR4oaFaVRQlNt45llglVFJd/8oOr9H2JCBALQZAHsLpOuAfQMqFpvA4d3kmRBFyuIUvCqaYbOGXW4Tj/C7SYoIEISHZW9J0rdgAoC+zuKbUcVd+ZwVvaI4J9VKeJM56OUT+PMMUIRWNHZh/auNO2H9nUiUR7FiJgD3zKVT6qrjDoJb+FQqXGyHciCVMeR4nRlnliD1+xkdveVsMFe9OAn2+cgBM/3uiYyaT0nhMLRBic1QP8KjCsvG2XUFVa0KwSAFsw+ucUqgEnucGt7NnPMGWbSZNR6BON2W7/iTrwpnMreUWSA/OITcMovLGM26m08alvjxdDZqo72qbut81cDiOvWDcoWkb2O34WEOwc7w/PDtUBBspaVR9Sd1/jd6DhHLG0oXhbfoWhlcZ8heHDlYYHkGVkdltP3T2vyUxYYZ/UW4S5J/UOU4CdiMJiFs4o9mlRv6dQUPGgbmJztSKla/QCddZhu7Je/6zl8FzL1oW64kMbbjp4A6fTh/kU2Zwf6psX/zYjKRkDD4eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(396003)(346002)(39860400002)(376002)(366004)(966005)(41300700001)(54906003)(316002)(478600001)(38100700002)(4326008)(33716001)(6486002)(26005)(66946007)(8676002)(8936002)(44832011)(66556008)(5660300002)(6916009)(66476007)(2906002)(53546011)(186003)(86362001)(6506007)(82960400001)(6666004)(6512007)(83380400001)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3PKtVRFGOgLYEwzUkb+5f7Dd19fZG06B4hFwfjEKEGJoCsJS5kZwGbK/PO?=
 =?iso-8859-1?Q?pBmbvb8okb4BtdO8+tE14js7gnwny9XtKVsJ7o8ZlD5gvnTKDHdbk/F7Z5?=
 =?iso-8859-1?Q?8jhjCIvzg9FE7BIQQn828AHGHTAJlMwF3hb7a36LoaRL/T2w0HgG6LGSfk?=
 =?iso-8859-1?Q?JM6adJz56KqJS/l2/0XzIGHN1g295YQVpugLRAzbjtsm9WMu1/oHyg2Agm?=
 =?iso-8859-1?Q?VMN/2yvvu/wUTGRS36Zu45DGPoCTT+TtlhJsVJd5IqTqjyOlGrhpzIL0pv?=
 =?iso-8859-1?Q?AEcB84dHwTIFh2gMH0AGoLSdkDgaDAcIjgNmrtlv5OiAir604hkpRMhfw/?=
 =?iso-8859-1?Q?5IL/OaotkLb2kNM4SyqUnLDf+HKVCgPwXrQ5VISjollEFzEPMn8QLt8JC6?=
 =?iso-8859-1?Q?KrgNAVjRtLPHKBKpPre1/DNLUvmLgHBTRXDxuWbOcahgEjp48lH9bei4p1?=
 =?iso-8859-1?Q?2I40HYjrMq8/EvyAQPSXDRcNZ2H9FCxpsHwEHDZFjtVECuxlFeuuFdCPc4?=
 =?iso-8859-1?Q?tRtdSmi350DLI9BSNEcwnTS5IYN8cWL4gIS3FacErMWfNRgqpEHLXKpLef?=
 =?iso-8859-1?Q?5Xr279fcReGo5YJz4mg76boPxs58LehI1Ek5PjcbXzdJCcLjdNpnVaKlK5?=
 =?iso-8859-1?Q?a8aDSiH7Y8tstlnAYWQUJAlZ3utmDyTzwUlah+PBWlIoY0aI8IZWp6+r8Q?=
 =?iso-8859-1?Q?FMwP3RqavRy8KTxByQqagWBC3FeI8Rvh9VpueZhW4quPuP+Yf8C91wEZc+?=
 =?iso-8859-1?Q?crejCH0oRMOtoH+C8eIZ7JBs59VSWH0+A5sB0khPEUm51Ci5mD0KDmp6gp?=
 =?iso-8859-1?Q?daNf64LbNiIerRw2MGUnCYZFALQhAYTSiGAZQorPwPhI6QpiN9mg5poe9S?=
 =?iso-8859-1?Q?abIRkW5K9naG+SPJ58TW7u9hZw+4UHIteUeZWKJF7212PZVdQbvQvND0Wt?=
 =?iso-8859-1?Q?HxapPUblE0bTGv0kVtTfMhkZzYXPOjKIauLxrxaJcwwJnswsJwjXyqxCCx?=
 =?iso-8859-1?Q?I0KVYHTqYxAlJBM6Go+2+k25gnBR0WPuZ35EcigBYKoT7RcgFnMB3Hk0Em?=
 =?iso-8859-1?Q?KOTlX4Cmn6QfSjz1Mj8gGZbSl31/ziQCUGMjv7hPpFGuFqDh6A+hP8BnyE?=
 =?iso-8859-1?Q?SUPoVvEMVojwAgahZIwgmQASrvnp9PrY2DsdBEr0v/2ZPjVcdn9gghuX1C?=
 =?iso-8859-1?Q?wopewVvUGEUy5zm6w16RQyjK8CtSmVoZr4ugm2re0+pi35dzXNAtXke+Wg?=
 =?iso-8859-1?Q?o7nePULvlRya1S1ww0gVQBgVWrCq9LpgwgmqqbnLTQkOs0FzELDMhvRn+t?=
 =?iso-8859-1?Q?KytiPObmmX+DNpXM4IXTIRERlFU1BmH/4Bo0ElDYhgipUToQDVBeXmF3bl?=
 =?iso-8859-1?Q?qiAQiNgkou3BKBX9w6jpmkBqBJoSe7ZH1nMeCY1Ns/x5kvq8eDQ0Hv/9D7?=
 =?iso-8859-1?Q?YcyepGlZzkNHhNTN0nF9hTMMRF8VUa64A27pNgiCguP8anuTjkvVYaBJME?=
 =?iso-8859-1?Q?5I01pT7Ri2Avh07H+O0zTC8Be0bUPmi5SG+dIeC6ZUgshC+s1i/Y9F3LK2?=
 =?iso-8859-1?Q?oFVRY+63j/vEnDq74wOLlnlMzX+RV5vb3xJmTmqe/e5fh7L1hJJqXupjd/?=
 =?iso-8859-1?Q?9tSD3yDBth+RDletCxYCjOJnYuQNbKMl1Nr1CbzOxwSPPJTIe/dUIlzw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d90bf48-44a9-4d20-692e-08da7f548ef5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 06:57:18.2224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6xrSHdU/9R9nRN+rfkp7qUlQjeo4DrLuY7C/j8dsZS2Q3Q6PW98BhbWI8s6BItkicMVQOZq2ycHaOVsEW3pLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4565
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Aug 12, 2022 at 03:58:14PM +0100, John Garry wrote:
> On 12/08/2022 12:13, John Garry wrote:
> > > On Tue, Aug 09, 2022 at 07:55:53AM -0700, Damien Le Moal wrote:
> > > > On 2022/08/09 2:58, John Garry wrote:
> > > > > On 08/08/2022 15:52, Damien Le Moal wrote:
> > > > > > On 2022/08/05 1:05, kernel test robot wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > Greeting,
> > > > > > > 
> > > > > > > FYI, we noticed a -15.0% regression of
> > > > > > > stress-ng.copy-file.ops_per_sec due to commit:
> > > > > > > 
> > > > > > > 
> > > > > > > commit: 0568e6122574dcc1aded2979cd0245038efe22b6
> > > > > > > ("ata: libata-scsi: cap ata_device->max_sectors
> > > > > > > according to shost->max_sectors")
> > > > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git
> > > > > > > master
> > > > > > > 
> > > > > > > in testcase: stress-ng
> > > > > > > on test machine: 96 threads 2 sockets Ice Lake with 256G memory
> > > > > > > with following parameters:
> > > > > > > 
> > > > > > >     nr_threads: 10%
> > > > > > >     disk: 1HDD
> > > > > > >     testtime: 60s
> > > > > > >     fs: f2fs
> > > > > > >     class: filesystem
> > > > > > >     test: copy-file
> > > > > > >     cpufreq_governor: performance
> > > > > > >     ucode: 0xb000280
> > > > > > 
> > > > > > Without knowing what the device adapter is, hard to say
> > > > > > where the problem is. I
> > > > > > suspect that with the patch applied, we may be ending up
> > > > > > with a small default
> > > > > > max_sectors value, causing overhead due to more commands
> > > > > > than necessary.
> > > > > > 
> > > > > > Will check what I see with my test rig.
> > > > > 
> > > > > As far as I can see, this patch should not make a difference unless the
> > > > > ATA shost driver is setting the max_sectors value unnecessarily low.
> > > > 
> > > > That is my hunch too, hence my question about which host driver
> > > > is being used
> > > > for this test... That is not apparent from the problem report.
> > > 
> > > we noticed the commit is already in mainline now, and in our tests,
> > > there is
> > > still similar regression and also on other platforms.
> > > could you guide us how to check "which host driver is being used for this
> > > test"? hope to supply some useful information.
> > > 
> > 
> > For me, a complete kernel log may help.
> 
> and since only 1HDD, the output of the following would be helpful:
> 
> /sys/block/sda/queue/max_sectors_kb
> /sys/block/sda/queue/max_hw_sectors_kb
> 
> And for 5.19, if possible.

for commit
0568e61225 ("ata: libata-scsi: cap ata_device->max_sectors according to shost->max_sectors")

root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_sectors_kb
512
root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_hw_sectors_kb
512

for both commit
4cbfca5f77 ("scsi: scsi_transport_sas: cap shost opt_sectors according to DMA optimal limit")
and v5.19

root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_sectors_kb
1280
root@lkp-icl-2sp1 ~# cat /sys/block/sda/queue/max_hw_sectors_kb
32767

> 
> Thanks!
> 
> > 
> > > > 
> > > > > 
> 
