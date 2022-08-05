Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D3558AEA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbiHERJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiHERJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:09:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAE673900
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659719366; x=1691255366;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n6rhEVUt1ice3LfwoMzPXU37MTTGimZ8ITUQIkMMquY=;
  b=Bpwsjhm+HRlq+7TwoxpiqyQ3f4e9V0Uws8b/bvZEtmvds8HFiL5TLiNl
   IQYcpGSOwVzvO5ZM/I636A2B0QIdqkLDJY9I6P0XusT5Bqly+9akWIV6F
   u59ryWbrBe0IlbsGqr0qfkSM3T/LtLwmpDUJQ8aHUU3PpKN/MSpvvLceg
   8wffZFjq5lgBsqfB21P+U5OMdVXbbj2epCqpVcuz9oTSIDq4rmm/jiuLv
   cBZmG+Stu5kKBxfuwl4JzuwaWGUdUDTDV1xPqEDuI29O60HCdZqJ9KHAG
   n1bq7bhORFqQ7Vm19qv7qHDTmprWZMeO7Gwd1yD8eHOoCmDpNsp3SQ8fG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="270630447"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="270630447"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 10:09:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="603656566"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 05 Aug 2022 10:09:25 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 10:09:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 5 Aug 2022 10:09:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 5 Aug 2022 10:09:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFQvIYniKrnHWdq1BkblMOX3ZsMCrMhbK+mSU2TAWCHfO0+NmuA8Wx93aGrcoaoW5JcD5kr31ajIWelOjH0B+OlqrvbjgJrYO5ogclx+SyfDEw/ibNEdmqx1T2CONggp1VoF5cnJroVEJ9SdLFXBu33WbEVLw3Gca7vDHucy/WOZ6lhQT9PsJ7loeFi3Oow8G55Zp2UFpR+6va9nRT31Ow7XspbTI/LdA/xAvezGVGv+lxRzmrMX5RAsRdNxCaiOwntnfH2XDIh7bTuKUFifO2+qS3ZXveSuzvkSGbsra1eok1k7MkOo6uULtkXrIgDNt4iL3eYEjIVSMetkpVjMfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eVvSWuiJFd5f4ui5o2KtzfpLvEhZoSl/e6+ezNYVOI=;
 b=KiZJOHTHpj2jZKSf7jVIr433M0ivLi+w4CtyobjVTJeXvBs/Ga0xO6svBmMmV6XVfqCSCrl8QHCtKYbG0STBiSlfD1r2qtsPGOaYRMy0tPVeJ0aLWgOcrotDrtnuZwhCAMSLau7kiixagCeyvgAZl3Cax2WuddNheJV1UYqwhGZrcI3e39ZzGzEeFZcMsyGYqm/xXtGC1vzHhnWAufgOLsUlow7WhZUwXKJmYvg76GyeciW4Er16TOOGbswkZBX8AMl63pNR/suxFvppyyDskCAIv4a3g9V6HL3B1CmEEa9Uh6XH1u9GMeqnRgZOWZdf4vXf1Nr18m5HCk7/JEmWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 SJ0PR11MB5664.namprd11.prod.outlook.com (2603:10b6:a03:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 5 Aug
 2022 17:09:21 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058%4]) with mapi id 15.20.5504.015; Fri, 5 Aug 2022
 17:09:21 +0000
Date:   Fri, 5 Aug 2022 10:09:15 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Rik van Riel <riel@surriel.com>, Ingo Molnar <mingo@kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, "Dave Hansen" <dave.hansen@intel.com>
Subject: Re: [PATCH v3] x86,mm: print likely CPU at segfault time
Message-ID: <Yu1OuwMhaoF6DQiu@iweiny-desk3>
References: <20220805101644.2e674553@imladris.surriel.com>
 <Yu0o3J2T5QwKtoan@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yu0o3J2T5QwKtoan@zn.tnic>
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 960080a9-0df6-4d52-bb42-08da77053d2e
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5664:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ehIz4ZmAoUGXJmiVuJs0n43UD0itOT1ZlUvuvDQbvnfk+Fneivghe2AWOhWPR44AK1ZeG7GI5y5/5Iv1COOc51OrSGgCOc3f336LfM6jYEPEnnjLFf9aeQZhXD/IHe86VqiCgmLZQStx+uDrVPCJlSLY56tjnyxJxmNlGT8S3bVDc2kYC+IsR7hTJ5JjCfbrpz092UhKF9XQpgIEUGeMoLC21Mp8l1z9UUSvDfTB3CypmZWQgseNnm4+Bj7PWJkW6nVmRXbn2wDYFRTXvLzhK30LC9cBUt9CmMS8qv4jjN7BhnzuRKp0jEZKlZ4ITUQuifN44u9it/40CUtjGF7WbUfA0e73oUZMEr8S8u2hKjKy0rinm136e0vH/ZMC6LeLxaI38C4cuPNu0pnOSrtONfufLw2A1wQDeV+++V0rBkelRhZxoZY2dl81OzxGUU75OWYvPdb3rWuGmGscc1Qq28EPTM3hFD5mlBtf/+BiFZp63ahnnBNNU/TjdBz9qHWtTrnxJpQucgJqHpA7PEhtFpr20gp4Df3A5M8qBMAV6A5v08gSncmMSn74qfRVTurWhcdotAS11NTDtdkxdzi6ZBN2O4afGej3608WI4oJIqdC8VUJd5sGbM6Dlaz42c1Qyuyj5pkBYA6ctxhTXgdNdIjeMNkcUMNWmgKvOWSuTj45TC0nmebNoewVdtB004qsXDI+1BRItPcU3QRYi6Gu+yNegqQzFZGj9LkQSV1I5xKiZwq/GRRJIfWoEipfvFj3ekDmPnCaeyZ/Rd8jy5HYpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(39860400002)(136003)(346002)(376002)(6506007)(66556008)(8936002)(41300700001)(6666004)(8676002)(66946007)(66476007)(4326008)(5660300002)(6512007)(82960400001)(9686003)(26005)(86362001)(966005)(54906003)(6916009)(316002)(33716001)(6486002)(478600001)(2906002)(107886003)(186003)(44832011)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aX5o32ugwsWUe5Y9vKusqnBaa+y7FMZgJLdPskNxUi4y8aadkwovpEXmoo9/?=
 =?us-ascii?Q?+g1u9FwrcCo7u839nzKWAwLPP2eBCBmOAl12T59ygWHqxyDRD5xRAP1q9xBB?=
 =?us-ascii?Q?IUK2OipStReY6hcinaDuO2vTupkgHWvIE4eQbgDHUqIxEuxQ6aRFr7ko59CU?=
 =?us-ascii?Q?oI7Rb1m3C+HjvUCCitrGws9wFtAw6TQRes3rQKSgVNKAB270ij7Pcac1Gfuv?=
 =?us-ascii?Q?Z8Q2xVxuyh9+XLDFXJO+rYGqquJRGguY3UEK3hiEVml4NeZR2Rif3EG1kwsP?=
 =?us-ascii?Q?oATIsK9LqhGt2z3nVVnm3C5zPNfXvr0O4SWVhROymta/Afaidc2m8pUafV7k?=
 =?us-ascii?Q?ee0K5Wy+yABTLjH/L09jREjmujy+GeVAsDgnIuXt3xwDcTx/wm64iGpQcFb6?=
 =?us-ascii?Q?9rNkrpTA4Xycb6vEvI7nFwjYm24jYJMsJa38/JiKTLJ/zHE+lbb5UHFGRcpD?=
 =?us-ascii?Q?otQi0EIC24cIJZ7BjJSB7VcjF6dY4iirSQB+3fBU4j/knfXLOFXx88JC23TP?=
 =?us-ascii?Q?rSCMyUFcSIGtgd4LyobzeuPORVs3NMFEZMDTZfGh7fFan5swffQxk44U/Vkr?=
 =?us-ascii?Q?a5KMDMjqQHHkg9eAH6WFT/4xXCWERdAMVo4HmId9YotpjbVvnrwA7cj82F5a?=
 =?us-ascii?Q?t+MDl24bihjAQyBArTRITPGWwQZ7WYRgTx/6j53/4l03Gv1e/Sz4RkDrxZh+?=
 =?us-ascii?Q?SSF1Mhz4fVhq7WbZzyT5HKb3pToc++WXVMCeZ96ydqfex7iL9oiN+82OXsD4?=
 =?us-ascii?Q?v/KRJdROoH7YcmTpovO7RIY2KBJRjpqtDktqE0Uz7QFqrwptZZmipNxFw4WC?=
 =?us-ascii?Q?I3N2po2Wnb5zPondTz/+CpZwrS2sd27kRVVNki4hag7yKlDg9jnhDWuShaHZ?=
 =?us-ascii?Q?CBmOh8a0SDBjbzoUu1ipDX06XOK9ktql+85gt2O+N3vm2mq81VCmR1NyFXvg?=
 =?us-ascii?Q?aylLNobSfEJDCTsR5A9ooYln2+Ly1ObzJQn8hJUqZAFCZwTrbaFH8MNNFSDy?=
 =?us-ascii?Q?54/qvq2weoI1e+KSitXs5yjq9SZkz55Uxrz1XkOIUZXcu0tXts5R42WdJ7b7?=
 =?us-ascii?Q?frYIlAcwdnmc+frfH4jVeTsi/o9P6TOLb2tFlUfXUVvW2E/UewzFFj1JwzyW?=
 =?us-ascii?Q?PvVqOvMlgltyoV4wGL+GVUtAPmyrcNE15pvO88oNNfTuqak+PlXOqUUVs2Qd?=
 =?us-ascii?Q?oHosDn8eoFI4K6XxPXyd4Y09pwqOakfgQk5+34Pr9Uv7PEyP56RM8Solrgd3?=
 =?us-ascii?Q?lWzBVdR48l3r+uWcO2VUKSCbF+UwRviN2f3ZSBMBuXw0X+b7yJZtk4Duf2+n?=
 =?us-ascii?Q?tsDhY6LoyB3XaSno21/u/WTW4YIhUOoEzp/994FwSBNS5KLOWK52JGWfTiyJ?=
 =?us-ascii?Q?Ys1kuXK6yC6tdzdsPGSF5mMyVGjtrGgk0FLwHEEDkzWVCzb9jV5TOqzSLfvb?=
 =?us-ascii?Q?bv0LUYpOHc5Vwyd4GBqWzZbf15HBjs3s5jUpt9hx5pa7FMy1ZmmnH+mvPfvr?=
 =?us-ascii?Q?Y1ITAbqEXHzrUuci+Grka/aZ9LMVgdxlFe8TZgmxMuE1+qllDmGHZHqZEA4U?=
 =?us-ascii?Q?cBufEWTZSgi+OwM+UI2qeMf7fX49rd2sco+OVJNa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 960080a9-0df6-4d52-bb42-08da77053d2e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 17:09:21.2767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zimIWpvR7yTtmMur5tWn3vZWI4ZBJ1VDnbzNBC/jEbzgPmBpuSpunwfMS+YIEY6NrJqvhJxU2G1OgyxNZRi+MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5664
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

On Fri, Aug 05, 2022 at 04:27:40PM +0200, Borislav Petkov wrote:
> On Fri, Aug 05, 2022 at 10:16:44AM -0400, Rik van Riel wrote:
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index fad8faa29d04..c7a5bbf40367 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -769,6 +769,8 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
> >  		unsigned long address, struct task_struct *tsk)
> >  {
> >  	const char *loglvl = task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG;
> > +	/* This is a racy snapshot, but it's better than nothing. */
> > +	int cpu = raw_smp_processor_id();
> 
> Please read this in exc_page_fault() and hand it down to helpers.
> 
> Alternatively, I'm being told there's a patchset in the works which
> will allow for any exception handler to pass in additional information
> downwards through an extended pt_regs. Then, saving the CPU number on
> which the handler is running would work generically everywhere.

Indeed that was part of the PKS series.[1]

I've thrown together a quick RFC with the relevant patches from that series and
Rik's code in show_signal_msg().

I'll post it shortly,
Ira

[1] https://lore.kernel.org/lkml/20220419170649.1022246-18-ira.weiny@intel.com/

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
