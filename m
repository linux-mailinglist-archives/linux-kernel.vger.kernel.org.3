Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC63597297
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbiHQPHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbiHQPHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:07:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E182C9DB76
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660748815; x=1692284815;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5xatiUCHFarHrM2TbH3x/v5urpChGovrryAoXWilEUI=;
  b=fw609FAFZWyoRRTT6wntSN4tEywO5gYe0t3O1chBWTGSd/bh61hxu+9W
   5J6P9/gNlOs4p8Sjk2T+miVmoq5iTbYtMahqvkwxaqSnVMvDw663HzPyR
   i/xr4iFuEiG+hU8QBE2dNjEoN/uSJc33nMf8vAKwyw9De4sQw5uq9NxZz
   PsHwxXqt8vd9kfzw8q6278SbMO+yvEPVIVvbTwek8aje6nlW7o/YL4tL/
   ty5D10Y7Sd3lqo3QJJuPYn67bmWy2zLxOxmC8vDgGOUFT78fZfDZtw+o4
   gsCmQZDJ1HuWWsxGayrWZzFm8SCxIZu1cQ41iHj9R07Tfu3chlFdQvj2R
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="293305826"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="293305826"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 08:06:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="935397247"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2022 08:06:53 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 08:06:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 08:06:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 08:06:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5MKndHY8EAWh6kwhwHsGQ3NN3cAMJZ6uVGHw3F/aKfubpQ3Mwqd1kCikj/m2PHXUU6VpHN2peYqcp77GDdfHe0e4bCFfK7YRKnCGYHDlUGp1QlhfHMB6q3fNmDJXhEx223l+uW3YFgx/2hn2N6ZhOpLm7f68Geu5MTacLdcLtlCYoEohOpmyXORC8XMLpt25YBqdaAQAidDCTByPV/TH4r4IlYHVeEfaGaklsgZbDeXCY7GJRL1N1bh6vaqm9il/vvWnR62BbqhVC/didPMbmNUIbmCN7/kYfXlkgsZg7BeUEHdlQi7jGmHC8XtdFBq0TwbN+b0oo/+5F2AFIV9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EWIAHi5IC52DBlV5i9tc2Es2oVHrcYAQTE46Z4PeIU=;
 b=gRC/E/WLV8elDvaXoOhii5XYKzplcGh/tz3f6fyiNKYuRuKLRo/wzsvymjw6aqLQDmlPyDwS1J7fizc0PTr230izd3pprfgGlTXBkPkhwCLSXYLE/TVNjnuWc9Il49jNnRiZ+qjOTE9JBWbKInTnXmsTXnzINH19/6xFMPTlzQbLUpN7/DL/idAcZCsYlVFkBpmNWNQZ7RAOYc4LXXW9XLTr8jSfQifSLt6i/jMIsPdZzz0o/X1ENBxmIKdkcnfRdlN0S0N9fG8fe/1KzjmiXfXSmreEvcYg6D3bH1FuhoVaXKw+XyEl2PzDosjG2Y2J+1Lm2t8iV/x7DSm2pnLH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SN6PR11MB2719.namprd11.prod.outlook.com (2603:10b6:805:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 17 Aug
 2022 15:06:46 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%6]) with mapi id 15.20.5525.017; Wed, 17 Aug 2022
 15:06:45 +0000
Date:   Wed, 17 Aug 2022 15:06:27 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tony Luck" <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        "Andy Lutomirski" <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 3/5] x86/microcode: Avoid any chance of MCE's during
 microcode update
Message-ID: <Yv0D88jxFkXcc18o@araj-dh-work>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-4-ashok.raj@intel.com>
 <Yvybq+hYT4tG/yAg@gmail.com>
 <Yvyfi9XC8bu0cOG+@gmail.com>
 <YvyiHGMbp2MtV0Vr@zn.tnic>
 <YvzXsf0mGEcOlZC5@araj-dh-work>
 <Yvzay5jOu5XBJpWa@zn.tnic>
 <YvzfebgOWVKYLClJ@araj-dh-work>
 <Yvz4/ASoX4SiXbhp@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yvz4/ASoX4SiXbhp@zn.tnic>
X-ClientProxiedBy: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec3700b4-7cb2-4356-c774-08da806219f1
X-MS-TrafficTypeDiagnostic: SN6PR11MB2719:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 86lvI46ArE7NdY09cidPTPOlOcMHYrhE/yFcAV6wfSQRYSUe8ZWy/FTHKMe8EC5XsRu/gBkJQoYl3UAmIRDcLXft1f+D/RL9A5FROGOpSlGCC9h+usl8NS/kA/3ECQb6PmJVPMVQU6G+L51WqshExiyhLVeB4V3ZL2sqw498zyYqJ7GcCfsu1Z7ICw6xcedbfg5AZaEGEg0Qy2PikIlrfY94BlVYg3HDOYZGfDEkuIdF8vvP4rAbk3gW+WD5PScbdIBQG5BaK0pcVRL4BmMO1OEjvVjGGPQG52OpzU+WK17PSd5CigeBrZnXCIDJ2Y075RxS3/eo9bXWe++UXiwxZIh1v7IGptdxu3Ry1z8zON3T3WD++L+izVhMlW9fj9dUv2Lp5eM9rUNfjGZiJjHmdspW0ExADy3zxksYHbfdpULOvPzt1lMfOMFPLY7BDFbIscGGHp01lUyqWMxOJJBTBcZz3efrgf70YsHvXjW65KH1rzqfk70jNio2yXKsd5nONcs96ifitUDhMpmPUTGH3bDN+Winqr7VWmiucE9Wj4g0vf1XSg7OmoLPDLZY5Nhg3/CyZLFhza4Rlk7JAyNK1UyIk9dx5cVcaN4jukHw6061l09WNKv65JA4c1EfO/1GLbUcNdkFXRr5L4VrgSLnaDYZqmfYvGm953/uULZIRA9ybiqL+TQN0/3KLTWvdtsRWMQ2ctfE1DSY9G6B2CsxIwY+84ubxegZ7yx5e8QUofMtI9eL8fmhQkbkji2IU8sU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(396003)(136003)(39860400002)(376002)(66946007)(38100700002)(66476007)(66556008)(4326008)(316002)(54906003)(6916009)(5660300002)(8676002)(33716001)(8936002)(44832011)(2906002)(15650500001)(86362001)(82960400001)(41300700001)(478600001)(9686003)(26005)(6666004)(6506007)(6486002)(6512007)(83380400001)(186003)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RyQK5a2OuB3/HRhKe/TIRfD7lLD5TFVaDadEYY4e8Yr3UA2UvuNG5yq6OcW6?=
 =?us-ascii?Q?oDARAVGMpCfsTf7WQXirzPq1PJp7HP6xz/Oey/kIoS4FpYADb5gD9/3GgjNW?=
 =?us-ascii?Q?Sq4XyPV4daCxYGDA+/n0iGVHJ+JhELPo6B1zir0gi2Wp4HNkJQantNVWNs/3?=
 =?us-ascii?Q?zOZN87Rl5RS0DJ1JtHH0nBkwBs0Rdbk0YyQbgVajR/5LrfktF8MNQYAAg/25?=
 =?us-ascii?Q?CSEY1yA+XhugOYEkq0csyC41PqBxr9nn9IjP0Z5wc/SRYxh3oqoeT6XKJT+v?=
 =?us-ascii?Q?T0VVuIXVZM8E9b7N1H99/ACduQX3WUG6KZwjPhLCHLaGka5N8H8GCqCqJTL0?=
 =?us-ascii?Q?im1b46O42hDmEkvfrKgy4ObNFUhqICQpJKPnZG1FOzR+qkCcwVAcsAH1iY6n?=
 =?us-ascii?Q?Y8s2pt6taIyG/LRwWsLUizwMpJhvdJOEWDnha18n3/A4dx0ajWvzEz3IqeWU?=
 =?us-ascii?Q?u/rpWEMLqzshXt8ciJUQ4RFUEjlZJJjk1BH0yFNFqlyoXlP7+ZNYwYDqCq/n?=
 =?us-ascii?Q?l4uZhL6Z8DwLCafmGiJLk38xuW4WBP5Q23SSqeyUFgHsQPdIVH8I0wM/xXJs?=
 =?us-ascii?Q?Nv4HGVpBCC7KKHLLwtvjY92zAlTI8LpJYcQEz0p4/isC/z/QFwmUkT2WR1dt?=
 =?us-ascii?Q?9ddRQMkv/4ILvwt5zzB8fp4fDBWyoP2P2cmTZ1rWTFT/DkQPGHDt2bRr6R4L?=
 =?us-ascii?Q?DSIb3KEWUNNJ7bQxuASAfmI9iJClVJrRdMH3zGzNg8vowU2xF+SZbmwqVtzm?=
 =?us-ascii?Q?eVJeXVF0eh56hoyo72U+lwCQhDPwzpgnwvxIWJqqyP/YrAISKGi6sRqxu+7H?=
 =?us-ascii?Q?cldGWEUamCanRa5VKVyXb4AWxEfo7SrmC0yj5HHLuUcRRwiqkCAUcAvgkOaN?=
 =?us-ascii?Q?IBwdl1CYe8/+Dv0y+lr+yoK/S7zNfMWoNnnKCHc+yquL7Q7D+mBfiAmtIjd/?=
 =?us-ascii?Q?AcZwBfFCnHGV58kNZ7+xOHAGo4J67KkwOegfus4hkmhZmZrNs+qGn93RnfyN?=
 =?us-ascii?Q?pKVcWuMh0dKDFkKvE/DFmb9W+6UNbyKXClL0L/ZHMDz/6yg/3854NYsghb8x?=
 =?us-ascii?Q?T9IQTY4pDMKgsj9Y1KLGULai0wGqbdTqzEZsc2DFZKUJJRjMLmw8/9nhB7dX?=
 =?us-ascii?Q?DxNH2GhMaNpmbtM/iqCMcXUK8DEJbqI9PnNrFG0JsinPnUbcCX3uznqyCIWz?=
 =?us-ascii?Q?aY8pRl6Q6Vb0oL1YeEB9Q9ngmHuqonyt59O017ySWlVTrraxq6gcVirFieKn?=
 =?us-ascii?Q?lcTZ31k0O2s8bCKISUnylXQTy5fcHjB5cE2YHSWOj4zlWmr7f+NL56R7m90c?=
 =?us-ascii?Q?8GUd30UCiDI56oecHa0/w2vrBrRXiDyVWdQ5R74b82Y98lQOnA9cL/NEUlna?=
 =?us-ascii?Q?Dq4u10gOsOr1GFpN5Z5SKldT0C29cNbYehSkcbxS2HCv6rQ8eOf3SlB6MGSo?=
 =?us-ascii?Q?yFYDrIjzk3IgUYtVmn7FA8kZWSkd5BE1uzZ1sMwY5PZsXdhTSX3Cxb5W9keE?=
 =?us-ascii?Q?zn2o4J4lF+wEw559SojDsK3lt8V6os2al+1qES764h8J25vNlGfYg+euORYo?=
 =?us-ascii?Q?spxGdhMG1Iy8r1rZ9ruXeJaEEheCrbqBnP65zWbUoVhkLQziFrnkNvP1B5re?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3700b4-7cb2-4356-c774-08da806219f1
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 15:06:45.8347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8As3tnd9bS3+QZKkaB9CsA5MIEKb+Iu1UfhKaJhzPuWcnZuVION8WPs+BZ0571N7bgdiVjzeGgtIn97XshVLAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2719
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 04:19:40PM +0200, Borislav Petkov wrote:
> On Wed, Aug 17, 2022 at 12:30:49PM +0000, Ashok Raj wrote:
> > You will find out when system returns after reboot and hopefully wasn't
> > promoted to a cold-boot which will loose MCE banks.
> 
> Not good enough!

I probably misread your question.. are you suggesting we add some WARN when
we initiate late_load? I thought you were asking if the HW must signal
something and OS should log when an MCE happens if MCIP=1


> 
> This should issue a warning in dmesg that a potential MCE while update
> is running would cause a lockup. That is if we don't disable MCE around
> it.
> 
> If we decide to disable MCE, it should say shutdown.

Ok, that clarifies it.. "IF we choose to set MCIP=1, we should tell users
that hell can break loose, get under the table" :-)

> 
> > Meaning deal with the effect of a really rare MCE. Rather than trying to
> > avoid it. Taking the MCE is more important than finishing the update,
> > and loosing what the error signaled was trying to convey.
> 
> Right now I'm inclined to not do anything and warn of a potential rare
> situation.

Encouraging.. So I'll drop that patch from the list next time around.

> 
> > > > Shutdown, shutdown.. There is only 1 MCE no matter how many CPUs you have.
> > > 
> > > Because all CPUs are executing the loop? Or how do you decide this?
> > 
> > Fatal errors signaled with PCC=1 in the MCAx.STATUS is *ALWAYS*
> 
> What does that have to do with
> 
> "There is only 1 MCE no matter how many CPUs you have."
> 
> ?
> 
> That's bullsh*t. Especially if the machine can do LMCE.

Well, not outlandish :)

LMCE is only for recoverable errors. When we have a fatal error, sometimes
the signalling and consumption of poison are going in different directions.
In order to minimize exposure of bad data from being consumed,
*ALL* Intel processors have always broadcast fatal errors. This is the
history behind why we broadcast.

BTW: This is all legacy behavior. Nothing should come as surprise.

LMCE is best effort. This is the current state.

Cheers,
Ashok
