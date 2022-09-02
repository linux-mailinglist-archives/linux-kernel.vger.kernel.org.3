Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E845AB799
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiIBRdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbiIBRdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:33:35 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D867DEA47
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:33:33 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id z22-20020a056830129600b0063711f456ceso1895965otp.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 10:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=otDaO66jYRzgslnU3IM4rTRTJBIZ54VDMBSQV0MUipc=;
        b=hl1hQP+vw9MabIF7SGCUmy6Pyu3Qusx5jgHpKJVCErACc7slm9aUWobpIfl1eAbB88
         1g6/QG3UmjS94K5QLyj50THwC7nENzf3hKkDqlSFi/HzbKmEUn9vx8ZM3YdKDVuOQzBy
         fp4qVfpkvoewNqs7yYSMAXkzk2jrjeERVlFeOFYClTQOnxZRruwy8zcMDaberDDChNdA
         JuNto4q5CxsBgDKrmahqpHC+BZUvYZ7NjZsjwyGkPTwN871broK0v0Z9LkZjEQ0JxccW
         mwSefBwhZZJcxctw2iv/kmwiImZZfGB6RjUiRTzWkxyJZwUFmcxiOSRZUMCjc2doqW52
         wSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=otDaO66jYRzgslnU3IM4rTRTJBIZ54VDMBSQV0MUipc=;
        b=Rs+l1tENfNX7wABcYJYvPkCFOuyD5bTPoConUMZ4eQ/DPliV7WhCd9rhhiQs2JyqB6
         GQc0PXpDVp4189T38JuMPskdDg9jbiruZID5tF4fJGv0eLX9KK/+mHIgQie0CS5KxGZa
         QSx7UMOqX/8kVuBSRst/mQwwGhvP+lQjHCMjdB9r6pvH72mVlFFZmRHbgPdEcn9NJ4u8
         1oMUuH2gHkcuZJKJPXwl2ZCgEZJVKN/vKFyHRJ9AaPaQBLast6ooJG2cUqKMHvl+ecgh
         pmRWdcOXVBOH7JAUG9txThnmpaOCPNCLLmJCKI50Cu4k6G1mKBQIhmoVCswPnxcFTHfY
         TuHQ==
X-Gm-Message-State: ACgBeo3kWM2BfGh9f4sLrOatAM9yUEDUOPH0D43YHmq+9j/dLJm/iJyJ
        3WhJ6axCNdZiT2ogP4LDJVA=
X-Google-Smtp-Source: AA6agR4GeUrjDrurO2YFFaUlnFrTro1/D+WR6ZubAkGeCgQGSHu3b0T39RxrVJqzQt1HeVaB8R5fBg==
X-Received: by 2002:a9d:3609:0:b0:637:3891:48c3 with SMTP id w9-20020a9d3609000000b00637389148c3mr14367675otb.263.1662140012832;
        Fri, 02 Sep 2022 10:33:32 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id o186-20020aca5ac3000000b0034564365bf2sm1217647oib.17.2022.09.02.10.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 10:33:32 -0700 (PDT)
Date:   Fri, 2 Sep 2022 10:31:20 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Vivek Goyal <vgoyal@redhat.com>,
        Yinghai Lu <yinghai@kernel.org>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 4/4] lib/cpumask: add FORCE_NR_CPUS config option
Message-ID: <YxI96NfjexPr2XqN@yury-laptop>
References: <20220829165748.1008477-5-yury.norov@gmail.com>
 <202208310215.C2IzssKr-lkp@intel.com>
 <Yw57ABzUuW7Fic9w@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw57ABzUuW7Fic9w@yury-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 02:05:09PM -0700, Yury Norov wrote:
> + Vivek Goyal <vgoyal@redhat.com>
> + Yinghai Lu <yinghai@kernel.org>
> + H. Peter Anvin <hpa@linux.intel.com>
> 
> On Wed, Aug 31, 2022 at 02:33:41AM +0800, kernel test robot wrote:
> > Hi Yury,
> > 
> > I love your patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on tip/x86/core]
> > [also build test WARNING on linus/master v6.0-rc3 next-20220830]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Yury-Norov/cpumask-cleanup-nr_cpu_ids-vs-nr_cpumask_bits-mess/20220830-010755
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git bc12b70f7d216b36bd87701349374a13e486f8eb
> > config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220831/202208310215.C2IzssKr-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > smatch warnings:
> > arch/x86/kernel/apic/apic.c:2437 generic_processor_info() warn: always true condition '(num_processors >= (1) - 1) => (0-u32max >= 0)'
> 
> This is the code that woke up the smatch:
>   /*
>    * If boot cpu has not been detected yet, then only allow upto
>    * nr_cpu_ids - 1 processors and keep one slot free for boot cpu
>    */
>   if (!boot_cpu_detected && num_processors >= nr_cpu_ids - 1 &&
>       apicid != boot_cpu_physical_apicid) {
>           int thiscpu = max + disabled_cpus - 1;
> 
>           pr_warn("APIC: NR_CPUS/possible_cpus limit of %i almost"
>                   " reached. Keeping one slot for boot cpu."
>                   "  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
> 
>           disabled_cpus++;
>           return -ENODEV;
>   }
> 
> It has been added in a patch 14cb6dcf0a023f597 ("x86, boot: Wait for
> boot cpu to show up if nr_cpus limit is about to hit")
> 
> My patch adds an option FORCE_NR_CPUS that makes nr_cpu_ids a compile-time
> defined.
> 
> Hence, the num_processors >= nr_cpus - 1,
> may become: num_processors >= 0, if NR_CPUS == 1.
> 
> So the plain straightforward fix would be:
> 
>     if (!boot_cpu_detected &&
>  #if (NR_CPUS > 1)
>         num_processors >= nr_cpu_ids - 1 &&
>  #endif
>         apicid != boot_cpu_physical_apicid) { ... }
> 
> However, I have a feeling that all the logic above is not needed at
> all on UP machines. If that's true, the '#if NR_CPUS > 1' should
> protect the whole condition, or even bigger piece of the
> generic_processor_info().

As Dave Hansen said:

  I think it's a reasonable warning, but it's also not something we need
  to hack around.  We can surely only land in here with
  boot_cpu_detected==true if NR_CPUS==1, so the rest of the expression is
  moot.
  
  I don't think it's worth adding the #ifdef.

So, leaving things as they are.

If no other comments, moving the series into bitmap-for-next.

Thanks,
Yury
