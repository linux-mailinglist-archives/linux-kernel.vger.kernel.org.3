Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156AB58CCB3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243273AbiHHRes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiHHReq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:34:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3498EE24
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659980084; x=1691516084;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O5Iasu0tP+v/DtWjWneLrz3tuvZETxly468dkmslEtA=;
  b=ZrR6vAWCIuhum226f6tYDdCrOHSSUfHxUN5VCtRaG+4sXeZiul8p6nwT
   nO3RivNVa70ppuDKmVrvd8lghr+wyIAXAG52OuBolwqQO0aEw10j+8t19
   jvZM+Q/SJx6B+ZdYsVD0FEu+yergmcWaIgAH0yqJFVCoIhLEn9DJKDE7l
   8YCdVPe8mjw4EmZTN5YtsWrG7+mwm+bMNSBSTLkskeGl6Z8CGKAShl30D
   rQ+XEJuCsjwOuZ2t8tK+heO2QZFKNEQgxOnvcBVp2DGE9PdWDtVQ8sPAY
   OCYYkcC8FQtCz+avoQs/Yy4YOifOiiGMHKukEf+FYZh+z319svU12lSeS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="289409010"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="289409010"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 10:34:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="580444448"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 08 Aug 2022 10:34:41 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 10:34:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 10:34:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 8 Aug 2022 10:34:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 8 Aug 2022 10:34:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kj3DkpLybsSlljBftFO8ecdYNBALY7z/tWADiqA6WzuWIN7hF4AFOd6PN9sPxkMrw0jhhdS60a+jPis/RUzs+fvIs9+k0Ma6vNAMetz4MUMwlYHhH+qmsV+8FqBmO5aBeVDkoUIGpKPhczo1QyJ66sH0dw8GHg00hXoNsRRmmFHeCOOTOG9Sfl3Ji5X21pj0myPUereL8gd73PIz8bgIMMNPEbDkP90Afm8mhArJheXRc6Q8npx539+VS9m4+/1qiuzQoCaVS49uc7ycCCjnDBGpu62tgjVp9byKZWxLurGqjh4uLy89a8zFJ6NQRsIpSI9g2r3bZ0CorC2VTpYanQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr99FE6vDfiHou64Dih3mlZ7Y8rnGX/8yy91JcHsj4Q=;
 b=RaWPFop1DuJppFlA8aXbFEJske8U71mn/rd5EgxfTYCKqb/cwBanqoEGgtzilBwStD0k77KUG5YQD/wjeYwktu52qX09wxboSb8iu3h5GeKHsOqOKbYdmIMsoQP1CDW+w337UFAIS1cDnk1/9WhAnK2iYDARYwuditiA+hhY/WL2nMaydWoBl0t6iydZ7nAVcfI/Lht3wqESOpw/22Gcoe2MZcbKPbIAE4hn8byBJKNlYzAms/nm4UAykJfDS7ltTruYBThJxJielUqiootP8wZkpHMAnSuSGDT80Rgb5y4XYygaAg6FvW/eVDsGU4suy3WE7LKvfyl2jdb20AYSxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DM5PR11MB1353.namprd11.prod.outlook.com (2603:10b6:3:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.17; Mon, 8 Aug 2022 17:34:30 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058%3]) with mapi id 15.20.5504.019; Mon, 8 Aug 2022
 17:34:30 +0000
Date:   Mon, 8 Aug 2022 10:34:19 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [RFC PATCH 1/5] entry: Pass pt_regs to
 irqentry_exit_cond_resched()
Message-ID: <YvFJGxU0k492npYT@iweiny-desk3>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-2-ira.weiny@intel.com>
 <YvDnkALyHl77R/Ug@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YvDnkALyHl77R/Ug@zn.tnic>
X-ClientProxiedBy: SJ0PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:a03:331::17) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4626edf3-2f54-4011-0f7b-08da79643fd3
X-MS-TrafficTypeDiagnostic: DM5PR11MB1353:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdiYLONCQUAxu4RRc0+uDoyfSQLxlzKr7ulN/JK8ZX2zo6m7jLKyxtninKsxM/SR19LPdcw2Hrt7pTsd3AvmSpHZCTY+GhPTiCvldrhYyho+QEOIAb5JonnBa4RdKbyTpuTHiA9JZzrMbcKzxDksqVObq6y/mIG3e1C9xJ3IrdeHoPYrEFfW/86bHThNEC/U7qRDrvfUKqi3A8LHMyCkJeob+zzEpK9zSCXuEmDgw4fAjRSKaZxbgdVphdhKcfBHA0tq8hVPzMu5Cm6orDxkwJHmNl3tSymdbQIB13i1TMGi+U9i8iOjKwtzPSSQMZVOvCZ4pgFwzMZLZ87/Lv1w9FjI/IO9ujxe7ZB5N05sFMdW49erJYgHmz9pc1G/8aGtelMlMF2xhZathGBGQJZImHEWlJKzf5dny3+dvau+P3XxH9of4L3Y7gNVKG/R2glydzxKEMfFzyfeONu/IlVeI2feXOCFgq716GTU2QPk+BQuDbClyXGpRmwUAJAOQnlMgmTFW6dDdCTaJjmVxXYLEa2mvO3MPX7vuLdEw0Ob3GqbGwI8jIDa9WDIcLUbi3cD5qb7gdpvqd9b0ReDbISwEU5eKUWhzitsuelMW7HlAE/8BKN9BTR8ZtpwTOOaeTr1JvhRIFarRAjQBoxti06SECBDMmmh3BOrV7Bx0MfTqhtAPYFxGwfLrgpm3JEL8qbfmrjTANqEexq6YsYtVnzZNF1rhaUDiLS2rO/jnXSvP30qNDSduqoWaj6I6kRlootxIYP/bdWgvTJA2+up06Xk8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(136003)(346002)(39860400002)(376002)(366004)(5660300002)(6916009)(66476007)(66556008)(8676002)(4326008)(316002)(54906003)(33716001)(66946007)(86362001)(478600001)(44832011)(8936002)(2906002)(83380400001)(82960400001)(38100700002)(41300700001)(26005)(6666004)(9686003)(6506007)(6512007)(186003)(966005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sp1yGhP/yUayeFiC2tTvLNnRewXE41EQTNeInXNy04zTiAldsRcwyLBNNwq+?=
 =?us-ascii?Q?AhRGCLXhxaRaoPPU6h2YR4CEEzzt+0cIOvwyXHtNCW/peJn7faHN9x3OpfLz?=
 =?us-ascii?Q?EA6NSJFabsCOUjHKdKMnetNym5sPGSLMHGoQ/CiN9/+NR/AMv9/aM06K4ECI?=
 =?us-ascii?Q?idgGSh+W5HEjxgzNMZV+z5gLzi5OrVoe2m+pax3eyZ6dehZ0/2zkp9z0Q0yF?=
 =?us-ascii?Q?Ysn/00RYPLO/P23GALoGRLoxLddbRIRC9GFLraifPuYYGW/Pts6AR++2K0w5?=
 =?us-ascii?Q?boUwOX/OB8EWlOp1pO5D1/Gkm4WKr49zrWa2qfXglhLeLVOHAI7gaVkLYy9d?=
 =?us-ascii?Q?+Jivl12DZHJRfyERQjXX/y0BmWaWwlggfc8pYa2Mcb7Uh5Of8L2ylYS91BC+?=
 =?us-ascii?Q?D71LtU0NgczhDEnAcUySTDPG8kyf9yvoibeEThephhBmNk8pchmkA40PoSRF?=
 =?us-ascii?Q?F1KORvwFEVAhfC19hRuTev1Jw3iOrLuT6JRL7r6Nxv4i9o8EjrvuyDtSF1I2?=
 =?us-ascii?Q?yBW6ONwU6LeUiNHdiivisGygLilHZkcB4OvlslbBlK2m9mM7VnjtKGiSCB2u?=
 =?us-ascii?Q?VOSZyglS7JctFo/lzxreTWNoX4GWBe2RzBJTb5tK2PZJK7nyZcIO6vLTl6ww?=
 =?us-ascii?Q?SQfG4kBIB2BxwpdgCXCvaqt+fDeZMUr3o/m/xkuvbTdVjHcc/GyEvnYQCHA5?=
 =?us-ascii?Q?9BB4AYqW/9OAjQvm1L0My2BmGDyoVfTwdhCnhxc0amUe1OdA8dBY3Hxmsi6y?=
 =?us-ascii?Q?FyoiISynhK4u3pj29Sw34dTE2Xh/gcicO/nU8UuBdn1Z2Iiq8Z+95t/hNBEI?=
 =?us-ascii?Q?5jO/Qln9uSH52gRqoaSCTwFLNvI2SZulhf40je/AM2mtnY/k8M/YYvS5SC0v?=
 =?us-ascii?Q?G4F/v66iZyfoouaHvSzxvlhTnNaZdkNNnjI5k1tduFPCYOPLnGLAkrbQptt3?=
 =?us-ascii?Q?NKV4pZfgGYRsygIsA3cG6E8eXvtiNxqggKHNbUd5VFouO9OdUCaS5+w51NLy?=
 =?us-ascii?Q?V408US5JWt5DsCDDs7lhiFW610LmhNpwkT0677tl8Z+FTncr/OAiNSMeMg5y?=
 =?us-ascii?Q?2DZ9YsfU8PqVhdDPIogcnUvflkupsmEs8KaWk+ptsPOy3FmdKscm3leSQvLa?=
 =?us-ascii?Q?FKBkh2NDbJyqa/xPxTJnPMPDhL1HjMI4h9f5a3YwBY+4aDV71QyM0Ozv+0iy?=
 =?us-ascii?Q?sbzYmiohmRa2lmiC5eeWZTIpJwIka/z2GxLZsEsUNGqAWfHuwVZznI5ehQQh?=
 =?us-ascii?Q?1WC581UyTGhj/mqCKJmDKRd1OmmcAydN/hHiTa+h7j78a8kfD7fxkRPE8+zC?=
 =?us-ascii?Q?RHK1XPBSw4/+lh15CESCEZDPH+QZUZ057PdjQqyIKWmYNH5bS9Oqso/rdao4?=
 =?us-ascii?Q?+qjsYs+grjv0d40JQcxpAq6nt0jFXLjuMcScZ6WOFLvhTcnyfHR4Xy3cfi6a?=
 =?us-ascii?Q?w43GOWG1vMTjuZy//qsn48QMwjCLFpSILeznFyB/srINRWG+g6pOIjpjyOo+?=
 =?us-ascii?Q?NjhHuuiykciDzEGl9jaSrgFZQd9y2H9dPFcWeHvm1iXB2Hfg/M3HmOSZqS8V?=
 =?us-ascii?Q?eM//eIaktU5/sg1z3Vn+j9h9Nw9qvJaISBJCe9ob?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4626edf3-2f54-4011-0f7b-08da79643fd3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 17:34:30.2564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mKuSe7S/Vojz9ZlIDdnubxNteNUmDMUT95X9ybHWDvE8vw/Ih7982tIv0RHsblPe65RM2g03lG7Ioj4oIBKUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1353
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

On Mon, Aug 08, 2022 at 12:38:08PM +0200, Borislav Petkov wrote:
> On Fri, Aug 05, 2022 at 10:30:05AM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Auxiliary pt_regs space needs to be manipulated by the generic
> > entry/exit code.
> > 
> > Ideally irqentry_exit() would take care of handling any auxiliary
> > pt_regs on exit.  Unfortunately, irqentry_exit() is not the only exit
> > from exception path.  The call to irqentry_exit_cond_resched() from
> > xen_pv_evtchn_do_upcall() bypasses irqentry_exit().
> > 
> > Make irqentry_exit_cond_resched() symmetrical with irqentry_enter() by
> > passing pt_regs to it.  This makes irqentry_exit_cond_resched() capable
> > of handling auxiliary pt_regs in future patches.
> > 
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Forward ported from PKS series:
> > 	https://lore.kernel.org/lkml/20220419170649.1022246-19-ira.weiny@intel.com/
> > ---
> >  arch/arm64/include/asm/preempt.h |  2 +-
> >  arch/arm64/kernel/entry-common.c |  4 ++--
> >  arch/x86/entry/common.c          |  2 +-
> >  include/linux/entry-common.h     | 17 ++++++++------
> >  kernel/entry/common.c            | 13 +++++++----
> >  kernel/sched/core.c              | 40 ++++++++++++++++----------------
> >  6 files changed, 43 insertions(+), 35 deletions(-)
> 
> Why all this churn?
> 
> Why can't you add a parameter to irqentry_exit():
> 
>   noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state, bool cond_resched);

I thought about that but generally have been steered away from using bool
arguments like this.

> 
> and then have all callers except xen_pv_evtchn_do_upcall() pass in false
> and this way have all exit paths end up in irqentry_exit()?
> 
> And, ofc, move the true case which is the body of
> raw_irqentry_exit_cond_resched() to irqentry_exit() and then get rid of
> former.

Looking this over I think this may be a reasonable use of a flag like that.

I'm not sure if this series is going to land given the discussion of
performance.  Would this clean up be welcome on its own?  I'm willing to respin
this patch and submit if so.

Ira

> 
> xen_pv_evtchn_do_upcall() will, ofc, do:
> 
>         if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
>                 irqentry_exit(regs, state, true);
>                 instrumentation_end();
>                 restore_inhcall(inhcall);
>         } else {
>                 instrumentation_end();
>                 irqentry_exit(regs, state, false);
> 
> Hmmm?
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
