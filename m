Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F745A07C3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 06:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiHYECl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 00:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHYECh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 00:02:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EEE9AF9F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 21:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661400156; x=1692936156;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rjO5Gucz962+m+u7NTf7IdMdSbvoIvJf1cOr2O11T6w=;
  b=K9P7yu3a4O4wcvUAsrWwBdTX15Si+7OB0HeMfC6BYKdzzEBK3948L/s/
   pM0q9BQjHyyK2Q5zxwcSEdHDN0tv/dQYuXHJJpu6+G6MDR9mQBEcozZ1u
   wxDswxSTG8B9qiBQYjLEJ+Dnl5C72MS1tooW/9a5jU+KJ1RuDTyXacIpA
   geun426Jb1LCSRDi1tD/tuh56f/UR6E0ofBVpacD1/h1/bk3GC7+qozHY
   r3b8JS0P2RlfMdcYx6MSZkpgOG8q0qEbhtY+2mZNfybhgzKQe4BUNH02F
   K8WIpJYnhuz8AThOwhvYJ5d+q2YBOTTyjC3FZe/ffMnhfa+JQC6yUjHMp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="294918543"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="294918543"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 21:02:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="785864576"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 24 Aug 2022 21:02:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 24 Aug 2022 21:02:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 24 Aug 2022 21:02:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 24 Aug 2022 21:02:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX/X6i6ueZViuaFwSODKoOb04ViNqwX1PDW4a2G7kxA3NcrvnLpC3Wz0WabQq6ZTdpp9eujyAsxfqk5BhwJekbua2VeNtTHE2kq/CbVil0W+MTbS8JhbPmwDCXkFtYioiKkBeZspQHgyICPfGEwFDIA6n0V/23eYXs3qAPBOD3Qvf3hQorXN+5oAYrgJg8bMOb1AwXcaO26K9/ZAlwYWg591cG6ndSrcvSClqmXISGMqsVeiNlaU9Hlw/ve95qdF9cKla7z+4J3ujlPRJHbFno1MiPMLpqOZY0+rGJIHC6iT+gRkYMxApvOfWbgWK3TtcL1oMiroEjHU50FbCQFV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wVACCjpgAswPNUmYK6lYoihqao+ESghA6tSskpHzvY=;
 b=JbCH91i7EBIogePr+eUEXxHxdI8nugcbwS1uHmSVP02JLKUx3J9rakvJXQZk2ZpEAkmZzUVwef1Tjpqw+FL9D71mUY51bUk9eemp4+u9FQl4k0qtPmD3MyDjPDpotd4we9xBoXBm2TVK8lZN2JVZRS5iAS+CkSn8yD3NM8vXIiN9iwfygSS6w4TVgDrMYfd04qofpcPuMSg6V6XGM3fIocw39un3XpxVvYUzI3ngbE4Ohj/PjbvW7a7CPoEuO9XuEXIAbmKCnRXEzEqFifsoyCeh27cfjODesIaZJCutQYu7dkDgldaKRMdXN5aUe7nw/ywBJ7Mh3PJqCtFYorcQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MWHPR11MB1486.namprd11.prod.outlook.com (2603:10b6:301:e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Thu, 25 Aug
 2022 04:02:32 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%5]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 04:02:32 +0000
Date:   Thu, 25 Aug 2022 04:02:07 +0000
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
Subject: Re: [PATCH v3 2/5] x86/microcode/intel: Allow a late-load only if a
 min rev is specified
Message-ID: <Ywb0PwxU7KMMetyu@araj-dh-work>
References: <20220817051127.3323755-1-ashok.raj@intel.com>
 <20220817051127.3323755-3-ashok.raj@intel.com>
 <Yv9vy/GTh/QInBPM@zn.tnic>
 <YwQae9yhJyjAQ5Xy@araj-dh-work>
 <YwaBim3Xt3Il3KXm@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YwaBim3Xt3Il3KXm@zn.tnic>
X-ClientProxiedBy: BY5PR17CA0037.namprd17.prod.outlook.com
 (2603:10b6:a03:167::14) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cb63429-a687-4b59-eafd-08da864ea2e0
X-MS-TrafficTypeDiagnostic: MWHPR11MB1486:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y7b4s3F6RCUVn21KdjbWfrw1W4kZBNUjY6RPOeT5t07e/KlJXeCfUJIwvFzG/WKHN1QWAXgeeui0uPZ8sybDx/z4BTFIKNqe0oMfeceIcWlZ8FBHr7eKpDXWTROjQOg6cemwo1UZKH7mfrqO2MrDzq8k7G3cgih9HlRCJt0/MPUe/1I43TkZJk3hAWpGXb6Z8jwPVDCFsCqmbkiWYytHSjQtyhfqViln3Qqo0n500fLWPYUjJAqmARwew987Xp1eNQ5AbPAP2FRsgS5nMFaP6rDZ7DhocS5GJ+Uzg34akjxHPQF1Ns4tb7oYJXe6Yl4pgSkLmTwc9xhO9PWurGFzeab7UHOHaYGgJKzy2Yj4aNMaOcj7XSexCKFRtqjxNo4asapBS/5RHXQi0k7pdEQz9QGJ6x55xC+ZlGbkMye616Ne5W1uP0DS+cNLosAjD1Rzaeoo09b7agMIdSgRHXEVSUiG2Lp70K86A+PFpG0kvzeCzEYfKybqHQ3nroIS+L5JuOOax8dT/WxFiOkFP2cOFerFGUwL42XKOi3qO7qdGQWP11lh+QGICnhMnoJoDaIpzkpd/B6tMwwirI4xVFNO8FxUsv7qG8c6Px2C43NpJwqHc6Nvgz8qpBIR+2CRq8++gcojJBjau4sMXGV9nSpKddpbaVMTPOempUYbmNCMuAoidibT/IIL9PIyYI4fZxOO2/+HoMqsVKWTDz75zfqt8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(396003)(366004)(136003)(376002)(316002)(6512007)(4326008)(44832011)(6916009)(38100700002)(41300700001)(54906003)(66556008)(107886003)(66946007)(6666004)(8676002)(66476007)(478600001)(5660300002)(8936002)(6486002)(26005)(2906002)(186003)(83380400001)(9686003)(6506007)(33716001)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JZtXPOmiPAUdK4bxacuKBbmZRobgVEtYsoqobuBlF4U4nyN7JoC50qjnTh3c?=
 =?us-ascii?Q?pvr/2/2l1fxqX73VG3I7oMelw9/3B47dWiptsOYVyRlg+atqDomcH1PndR+d?=
 =?us-ascii?Q?IkkPJNfNcRdtqR26gEDPovb/lSOAfdinK84/oFo+/bf8Xg+uSdbcBAidQew6?=
 =?us-ascii?Q?a9+vfP0Ny8njnRccK9QMZ/Vqd+kFD1L9SsMYjlFdkl6X7VPpZkhOn5KSe4jP?=
 =?us-ascii?Q?gSUQGGZ4sUJwfmYTu1K+ZyWXNTeqUBZYzM+4E3jdRXpZi5oxXSwsPaLlRDPX?=
 =?us-ascii?Q?p70ZJ0SF3rrgtV+IV/iro2l4AewXWm/pGk6EnoFjeFV0yhYYxqtcpIYVzNRD?=
 =?us-ascii?Q?Dr+tDAlicserWtWviAcb5Pzf+uJZs6dDx/MULAV2Kkih2HCQzE2k1yxf+9Xm?=
 =?us-ascii?Q?hKpxr2ldtrOz4MshVB47Vn9VjldC1bv6dfFSFqbqCrHJ90Ci4Rrw8neVtyML?=
 =?us-ascii?Q?kzLAzXp7jQ7KzTK++rZsD3j5r0nDLHTNICMYmy3j+U/Rf+Dy+dHBUxk8SSqQ?=
 =?us-ascii?Q?Cb5wQIwriFJjnOga51a8fVmieN6UOlgAkvBuUnxW0rljhkcl11S0jvOV64kj?=
 =?us-ascii?Q?4KUD65OcgsSM+I8iusufFOq8r7+q1NBYGwid2K8psc19Yt4Qfz7X/AMp/M8X?=
 =?us-ascii?Q?D/M+jJ//6JvKXJyAI1psAt4oI8G5NI9LRI29+dvGBLmwUT1ZXDYK16N/nLwW?=
 =?us-ascii?Q?yKAFpq97WK/9wL6Yqe78r0yvy/8J7k6ZKNKRuBE6IQufoGHOUK00StcWDvMO?=
 =?us-ascii?Q?GYBrhYm8QzCNL+jn8oRCw3JvzOCcuYsYGZGkLuHIJZFtahmW2SfcZqJqnbp/?=
 =?us-ascii?Q?Aq/Vx8jkXapN3Lh3s3vGEinHpaIV47o1o8+j0iGl9HMLEVHT2llYG9Uz7qQZ?=
 =?us-ascii?Q?UXPSZFC8IbdF0Kylra2yjNa5/01BiICwoQhTCPfUBTevDi/bxWBUyKUEm8OL?=
 =?us-ascii?Q?6zvzeHXHapVhiNJpE6snrMoOv7iO4713WSzvsG6fUZkRHKDpjj5aHviuAirW?=
 =?us-ascii?Q?Efr/OxZQk5XrcketTgyz6348WxMSLeMaPlS+PgkaGA2U6vyW9vn0O7f3/SM8?=
 =?us-ascii?Q?F96tHh9NU+KOGR6T+fAiWxlMcV0xDDqG4ztSchLvBCjnLGgaQhsyuE09G+aG?=
 =?us-ascii?Q?wn+CqdZ7Tb2O4gCJKuVB1Rrq4ZZezcLtLlMTBAiwILriZiEUm7GZfqpakwsN?=
 =?us-ascii?Q?gFB6v4T5qGQRy39SB4rUB2j+orDfFWBN3ue9xMcknC201HOUdD/B2qyLoFL4?=
 =?us-ascii?Q?pJ1vaD6zy+/1SbgsQH2rYaTUjxI/lTdDpop7t+f8l1R2QIpj6/PB0BV6mfZw?=
 =?us-ascii?Q?r0pSjGz6l+CxOaSwoEQec/Fc5AyGT91vuryDSGUnjX7WEf7TYfgkzFf8Mfbc?=
 =?us-ascii?Q?Hr8hgdZs0S5iTxmlx75YEoMRHuF3ofX0xkyVdpFMDTAjF63RbyUxXhaSrJmb?=
 =?us-ascii?Q?AfOI0tjUjkIk2ppp0VEND1vy5f92kIQgzv3ZdJorrXazpE8ZeXTUOJ7ZWJGG?=
 =?us-ascii?Q?/4y1TGN8fEvFYfP1cX/VuS14pW/As70D70S38P/ShrD5bzHt4sMAH8xndU37?=
 =?us-ascii?Q?kVasRE4huuREN1Znjw8PimxPg6affpzrY+1cXgdJcLlQJI8LxeKFiz+GTsAO?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb63429-a687-4b59-eafd-08da864ea2e0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 04:02:32.6129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9otBEzdxs/YpLYLihYMYoz+0xZ4oLRjVqVcqYue6zIRDimrpWH6WPk92FUMqfGvYWzy4hG8y+Vg728XkgwTsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1486
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

On Wed, Aug 24, 2022 at 09:52:42PM +0200, Borislav Petkov wrote:
> On Tue, Aug 23, 2022 at 12:08:27AM +0000, Ashok Raj wrote:
> > Correct, but print_err parameter is 0 when called from scan_microcode() and 1
> > when called from generic_load_microcode().
> 
> Well, scan_microcode() gets called from save_microcode_in_initrd() which
> is fs_initcall and if we had to be really precise, print_err being 0
> there is wrong.
> 
> Because at fs_initcall time we can very well print error messages. But
> that print_err thing is an old relic so will have to get fixed some
> other day.

Well, the code hasn't changed since 2016, and possibly they migrated from
another file. 
> 
> > We do min_rev enforcement only when print_err is set.
> 
> That's wrong - you need to do min_rev enforcement only when you're
> loading microcode late. I.e., to paste from my previous mail:

True, if this hasn't been used for soo long, I was hoping to simply rename
the variable as late_load, and repurpose it.. 

As you mention we do have some good opportunity to perform some cleanups
here, and could address at that time.

If you feel compelled to turn the print on early boot, I could flip it and
send it along with my other changes? Let me know if you prefer that.


And I'll pursue what you said below. I still like the
microcode_sanity_check(), it sort of falls in that category. I can add
another parameter passing all the way from the request_fw... come through
all the other interceptors and land in the same spot.

The microcode_sanity_check() was nicely isolated Intel only function and
didn't need to perform surgery where it wasn't necessary :-).. 

Good bang for the buck :-)
> 
> "So you'd have to pass down the fact that you're doing late loading from
> request_microcode_fw().
> 
> Now, I'm staring at that ugly refresh_fw bool arg in that function and
> I *think* I did it 10 years ago because it shouldn't try to load from
> the fs when it is resuming because there might not be a fs yet... or
> something to that effect.
> 
> tglx might have a better idea how to check we're in the ->starting
> notifier..."
> 
> IOW, we're going to have to do something like
> 
> ->request_microcode_fw(, ... late_loading=true)

Sure, I'll check with how Thomas prefers it. 
> 
> and I wanted to reuse that refresh_fw arg instead of adding another
> one...
> 
> HTH.

YTH!

Cheers,
Ashok
