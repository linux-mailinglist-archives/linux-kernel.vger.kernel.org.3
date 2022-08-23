Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E8159E613
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242903AbiHWPdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243378AbiHWPda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:33:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F8DAA4F9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661253417; x=1692789417;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CgQdIHUtzFD62oK1SvZObs5D+ISlrRpWznYgyqWqG0k=;
  b=VSCRxGPAGf8U6ofrrwS8GKoLdVxp2gdDxvsgKICI3Kz8gwI6Ejy8ktBU
   gnaNu0e3j8JUi7X4vRj8QrXRi2r9u1TUCoGVbYpayhaeC7OJsA7LYbp1S
   wirVbg/4bX9WXL80Lum5VUnQOzZOTZgrxz4xt0d9p6obG+CtQveYoJvYa
   HXur3etRDvUu8QcL9ml2aFkhrVwEqcoJeuNE+35z7Zf1zuvuVTbN4Gut1
   dUJr9p6/bdKmMtJl8n1N3Rc6/gCsUyHqlnBU5MJ0Rx1VOOZwGvyw8vWKf
   AjMIhSlR4UULY985BFoM45DYmth22e/JMC4/DjhLvmK8IryiTb8xKAvM8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="355389668"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="355389668"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 04:13:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="560123383"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 23 Aug 2022 04:13:42 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 04:13:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 04:13:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 04:13:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxFoicZ6b8qOQI6UkA2gdrg4N1dlzVL2wc/V7MDDxkE2bLr4luV8k2IQd5WyIHjikTVEkn40VvTD+9SFR2rIBPGhl9AbsHNzVFIsWg3MSuN16dZ2m5fAbtRfrROQn4N6mn/G5PZ+w3VtWwQ5KbJkLeZJP/EbmyXmHceQBgGKAw0bhBOhc9dnQUkwAxOEZcUdH8nvGvLG+/V0aViu84KPs8pkVwrBaLt14QPtoWOWTfDWIWT8pnqJGPgsHGSuSZvKERghQpsfZ8llgNV0f2SD2ntRLBC3OFzEhp5ObASCAIO6WfThqUYi1SOuispZy3Hy6jG6byg1uULyIkaQKoDjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbTKAX1k7EXhAPMepTjQCuakTkU+bbkE4VkyabIjJ3w=;
 b=mzODGYoiKtqoOgiptrPs60xOgwpgEXy0cH465xleuuGkikpAWw21/7NUIFB4iD8J43a8bi/Q9/3OzaME81rJIobF2uvrI3XH6FlmYHsv5oDk1ejfQBIan2/sP0G+IfKdXsX8P4iQ8iNAjmJvQIHMZszQZPdk9WG0hf8O4tdM6fzCpCtyAs7Huii0/iBy2h8SgF2phR18Z8eBjkkBQ8DfemdxZo735C+FZ3aMYLndgXtu0dmbF+vj6ezOjO00CGuSmlq8eExqDsM6FkrBMMxru64iFpIV/Mv6Xp08TTk6iOcg9wQnzdh9UvB/18HuWtqr6YYtnjrF9G9xlMhSNVMyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by BN6PR1101MB2147.namprd11.prod.outlook.com (2603:10b6:405:57::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 11:13:37 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%5]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 11:13:37 +0000
Date:   Tue, 23 Aug 2022 11:13:13 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 1/5] x86/microcode/intel: Check against CPU signature
 before saving microcode
Message-ID: <YwS2SXBN2J5FQflG@araj-dh-work>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-2-ashok.raj@intel.com>
 <Yv9k6fqRANu4ojK6@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yv9k6fqRANu4ojK6@zn.tnic>
X-ClientProxiedBy: BYAPR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::44) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3700f782-b477-4398-bed2-08da84f886e6
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2147:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLQzQQyzwH14jt43R4+qaU96rtqjigdo22Lalg7D2/bWitk8J97JAYufplVGIg5uJ2VGdxiiuivkCxZF9QWoVaeQZAiMWFY0OQP2LI4jyUFDA3gogTQ8s0sjtGlYlI0h91QEqxS/E9NfP/BWz68gDAXs0IFj7wrPlNLen5KHVIK72GEFb/X6EH1Gn6TJ0IH/BQBRxgJ2ccV9ug1Kwks6Jko1/d9FrdOJaRDQJY+oPkIa0JWgKASW0OXw8ax4JVkAbcbnq2pZghSaEoscEHCRBRsQuGOGv2GWiOtu/NHa7pIrbpJQJay1E/6OZxUMlIpHf7zb4yLyji8ERbhusEBlzMr0WXVI4PLVhtzxoaDo5pYewJhtJX2+wKonqEw/BI+q9sufMBTofyNIfXcht8CCQPw0S0s3wl5LVYRyMW0KCsKGTq+G2tVlEiVZ6qqGX+gTg+rsz47V/rHwXkUwHNBfg5Qx34Oaf/OU2ChfBRla+CYv/qEZcxv07liN+Kn7sM6NFQvacMIPU843wNZybbRzoE0Bx3gY01yxqRdK5qOZD7wdJ2Un0yO/Cf+CGZhiRS6dUUgp/TsnCp7Xrf4Jx60LOc9sIlSLrkmvQKIiVTnmFU9Cebe9FxX6ryAk3RR9/PnAaCMl7loj0J5tI5rpZu8xCNwnjSk539Rlewk6bSN6FxHkL4oJxc2a+Z6RYymE+f0It94CjL3x4w1dzN/dfpf7Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(136003)(39860400002)(376002)(396003)(44832011)(26005)(6666004)(6506007)(5660300002)(6512007)(2906002)(8936002)(9686003)(107886003)(33716001)(38100700002)(86362001)(186003)(83380400001)(478600001)(54906003)(41300700001)(66476007)(66556008)(66946007)(4326008)(8676002)(82960400001)(316002)(6916009)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1BVNU6fhNrYAqIeTNYhnaVbNho0CkKnCE+DeHoYVUJ4e+rN3WU/UTCKQoWlk?=
 =?us-ascii?Q?vRlTp6wZP9aT9zbeAHY+Qr7bMpWEaB78U5SddU+UZeUfZMI/wr/6USMeEtTa?=
 =?us-ascii?Q?X8wi5p/dfU/sCDXEpcSCyQ76Jt9/QJnoS2QUHIIlYHytzYQkz6fAdQcfDUp+?=
 =?us-ascii?Q?XYc5dm0uiam5QsdkMN5RmCIKoZrzvqxeVd+joDXZeTuRQU7bd941eEDsStuH?=
 =?us-ascii?Q?42TmgMzWwfj2e1dbkga9oaEoyeemohhFDnSjaIDTwNXlboK6OHCm3nKXKhzK?=
 =?us-ascii?Q?8y403CLxThUs2NLg1d5raxHAhN3eUnb05FquXQ2r7QkzuaFvowtfPjN5itDP?=
 =?us-ascii?Q?oILLzNKnBgrqLzMubtKNwEnq51wA/67vHQ2S75Yyj+6ULen7B1o5yyu9qBa4?=
 =?us-ascii?Q?GmQ+dPrOKp7b8KiGXLxKV3RxHyEWiYe+kYXVf/fZkUxNbXglK8ZaUQwpvGhP?=
 =?us-ascii?Q?9qANMcBRXD71fw5B4Qiyvwwvvui+7rq4OvmND/iqJ5V8Ir5/w5DcB+Op9mYq?=
 =?us-ascii?Q?82RV472ID/GwlwU5PBppOq5GOD7eNmXH8a/ClBIX2jlL9RR2SpNd9BPqf/2w?=
 =?us-ascii?Q?+s0nVutzQlaZmg4C8tZIBV4mW2Mj1Voe3AgjcE2woHdR02Zq9SuoSVOSPPoo?=
 =?us-ascii?Q?1GnJTToakaKdMFdXrMK2uHwJ+Of6Jezzx/uOyqiHta5W1d3RBUH7xArSmAAP?=
 =?us-ascii?Q?IRrWTpYD2+Nqya0T2uPsD14BlDt/j2bd6BN+GV+j99MX8j0ZZu22qI9EIBc+?=
 =?us-ascii?Q?8tQvDVMAAITZHI+JGD7SqlRfqW5/hFpW/FERnwklVr+fj4GRha2C/PFndBgK?=
 =?us-ascii?Q?f4YB6vkEMODmnECecs21QOmUgrQZsSHoTOn3IO3kB08ss+ES6gvtYyJ+/E87?=
 =?us-ascii?Q?FBM+buEj67TcnI7Mwfn5z3cB02L07zGid/0HiHxEVS6VRlWH03R6z/GXH1Is?=
 =?us-ascii?Q?KWMZFp/Flkkem4CeMzmFb7YSvqNXxmex2nrCf5d4lP4YksJ0vbNkJuysbC9m?=
 =?us-ascii?Q?Vkt9dpUK9NidQnc7T9v/40jUvzuJi7PLsqGCCpNCBfBIiy4A0BV/sOFd41Cw?=
 =?us-ascii?Q?tUM+YxTu1rSTXPQvhbjqwY8Q9BKHff7e7nf5hIlbr+GE2p/35P5mRhBQigyC?=
 =?us-ascii?Q?u64q6qpSGiRATZA1ABDtap8MjSojQJNbHpexhae3KrQ0iJ4XHqgxRRBya9Xj?=
 =?us-ascii?Q?IVspFmK8r08olaHSntbyT2ukE6r5awmJhqbWqNbM7Lmsw69puIhkwfOxAKbW?=
 =?us-ascii?Q?p1o8GkUppSDdLIl0A7UKVdMDO6VAgWBX94t7vF5P9D6tsAPP+E+e8GSiVX50?=
 =?us-ascii?Q?WLB8mlrEWAey9L9IEMooez//4osZqs9IKMzm6MrG/LRpcX7Rohm1Ui3F8Brr?=
 =?us-ascii?Q?o/pb/3/EcZZMsRe1bNaMZIpTUyj9m7Mccxfr2D4sVmMCs0Vzt3VyBuFwYYgY?=
 =?us-ascii?Q?erA22QXqDZqNQYK5jt4dj8d1DM4yJZomgBdH8tqy1FHczPj7GaHMe1RI56tC?=
 =?us-ascii?Q?1Dt4h5+SULL/1os4ty3I9vwTdSxCP39vbnW0UWzPg3SBA0AngvHjeKIUOkEw?=
 =?us-ascii?Q?m5f7kuJOMuAftDHZcEcid/uXi8+2l1WcWnwHDt7jnH2IrKojOi7PSY6gUPJJ?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3700f782-b477-4398-bed2-08da84f886e6
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 11:13:37.7621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ny/Sxl/zXTvKVsfc3U3F4n/SR8fsb8LKl8V28Sg2Yh/JnQqSDREuQfIJbGnqo263FrLKyEF1tlCNDIfJKDjRUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2147
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

On Fri, Aug 19, 2022 at 12:24:41PM +0200, Borislav Petkov wrote:
> On Wed, Aug 17, 2022 at 05:11:23AM +0000, Ashok Raj wrote:
> > When save_microcode_patch() is looking to replace an existing microcode in
> > the cache, current code is *only* checks the CPU sig/pf in the main
> 
> Write those "sig/pf" things out once so that it is clear what that is.

Thanks, will do.
> 
> > header. Microcode can carry additional sig/pf combinations in the extended
> > signature table, which is completely missed today.
> > 
> > For e.g. Current patch is a multi-stepping patch and new incoming patch is
> > a specific patch just for this CPUs stepping.
> > 
> > patch1:
> > fms3 <--- header FMS
> > ...
> > ext_sig:
> > fms1
> > fms2
> > 
> > patch2: new
> > fms2 <--- header FMS
> > 
> > Current code takes only fms3 and checks with patch2 fms2.
> 
> So, find_matching_signature() does all the signatures matching and
> scanning already. If anything, that function should tell its callers
> whether the patch it is looking at - the fms2 one - should replace the
> current one or not.
> 
> I.e., all the logic to say how strong a patch match is, should be
> concentrated there. And then the caller will do the according action.

I updated the commit log accordingly. Basically find_matching_signature()
is only intended to find a CPU's sig/pf against a microcode image and not
intended to compare between two different images. 
> 
> > saved_patch.header.fms3 != new_patch.header.fms2, so save_microcode_patch
> > saves it to the end of list instead of replacing patch1 with patch2.
> > 
> > There is no functional user observable issue since find_patch() skips
> > patch versions that are <= current_patch and will land on patch2 properly.
> > 
> > Nevertheless this will just end up storing every patch that isn't required.
> > Kernel just needs to store the latest patch. Otherwise its a memory leak
> > that sits in kernel and never used.
> 
> Oh well.
> 
> > Cc: stable@vger.kernel.org
> 
> Why?

We have some code to support model specific microcode rollback support.
This code is just internal. That codebase triggered the bug. 

I'll drop the Cc next time.

Cheers,
Ashok
