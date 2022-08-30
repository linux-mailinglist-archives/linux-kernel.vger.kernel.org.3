Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202BE5A6ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiH3VFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiH3VFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:05:11 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3528A27FD6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:05:09 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso8962915otb.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=b+Kvem5dMGmT18RSkMe+CwrBq1FhWyXbm8AARNnMSu8=;
        b=SZgPYIfx0h0j3nv+O9wFVsipq88SIqX7H7vW3xxBot8qqGjkLFctq2TcAUqczL7PlV
         l5/kZv2UObRBayj2U5hPTl3uvg/iZIMBuIGWw5+m/9Hd8lmKeKYPrCk9Ei38jfkmnrZy
         s6NaKWYJLAhnzp4IH9LEH+h3k6wO6i4ZR1wM3cPXcm8K3MO+f8HvOBqcLDvzNsMXo1X7
         XmLQ2T/61CeGLjoEf+vV1h2VetZ+978vreYE4KaTFOHqND3cwAXkG7yzn5fIfFlF/NYz
         gCNk79Wru31XOR5WvZuANroCffUhtdRKkrnUV3UPqoEv0Lt8fW8sY4wZVyslPdcISRUb
         EeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=b+Kvem5dMGmT18RSkMe+CwrBq1FhWyXbm8AARNnMSu8=;
        b=XhQHkN7JxOKHl9wOzjUe5xJWEzS1wmLKlpz5twaQMELvTwWu+Dx8grORXk0GJ/xq9O
         IJDBWHh51BNy6JJnvdgbDnc38Bgn1qbS3yJrRP8pcO8A95WBINvitjrg57dplFUTGgdj
         hsfEkTvntVYWJwmHl53yvdsFHxuaefIGWsV49Fx30P8ugguhvsJEM+xdiDM4XSWsX/Nd
         1rchL/KxAfysfkZ+GFnvdTPiEtVF0FJggFjfPfjn+aRDVf/9mhg2+b+0BnVa4lAjNeET
         48JN0QTUaBLzKQ5mlIN6iFMqEvy1Q5gnHBtGcyXNI+uqJXWoXRMS6abwzfcBA/orS+zW
         GDoA==
X-Gm-Message-State: ACgBeo1BUZVJkV2N8IUxdPRjMdzlXu8woL9/e54tryfqLSGf+adJ89/x
        iB1fC12y3ak1aylirD/uO0A=
X-Google-Smtp-Source: AA6agR7WegBTeWN1BHYw1vb+PxlPQgFIxk9n5+h+K+bPkxIX608SEniccUFV/SaO0xTIsV1oP/NVQA==
X-Received: by 2002:a9d:3e5d:0:b0:639:2702:b9e8 with SMTP id h29-20020a9d3e5d000000b006392702b9e8mr9104742otg.337.1661893509048;
        Tue, 30 Aug 2022 14:05:09 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id u187-20020acaabc4000000b00342df642fd3sm6640087oie.48.2022.08.30.14.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:05:08 -0700 (PDT)
Date:   Tue, 30 Aug 2022 14:02:56 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Vivek Goyal <vgoyal@redhat.com>,
        Yinghai Lu <yinghai@kernel.org>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
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
Message-ID: <Yw57ABzUuW7Fic9w@yury-laptop>
References: <20220829165748.1008477-5-yury.norov@gmail.com>
 <202208310215.C2IzssKr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208310215.C2IzssKr-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Vivek Goyal <vgoyal@redhat.com>
+ Yinghai Lu <yinghai@kernel.org>
+ H. Peter Anvin <hpa@linux.intel.com>

On Wed, Aug 31, 2022 at 02:33:41AM +0800, kernel test robot wrote:
> Hi Yury,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on tip/x86/core]
> [also build test WARNING on linus/master v6.0-rc3 next-20220830]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yury-Norov/cpumask-cleanup-nr_cpu_ids-vs-nr_cpumask_bits-mess/20220830-010755
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git bc12b70f7d216b36bd87701349374a13e486f8eb
> config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220831/202208310215.C2IzssKr-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> smatch warnings:
> arch/x86/kernel/apic/apic.c:2437 generic_processor_info() warn: always true condition '(num_processors >= (1) - 1) => (0-u32max >= 0)'

This is the code that woke up the smatch:
  /*
   * If boot cpu has not been detected yet, then only allow upto
   * nr_cpu_ids - 1 processors and keep one slot free for boot cpu
   */
  if (!boot_cpu_detected && num_processors >= nr_cpu_ids - 1 &&
      apicid != boot_cpu_physical_apicid) {
          int thiscpu = max + disabled_cpus - 1;

          pr_warn("APIC: NR_CPUS/possible_cpus limit of %i almost"
                  " reached. Keeping one slot for boot cpu."
                  "  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);

          disabled_cpus++;
          return -ENODEV;
  }

It has been added in a patch 14cb6dcf0a023f597 ("x86, boot: Wait for
boot cpu to show up if nr_cpus limit is about to hit")

My patch adds an option FORCE_NR_CPUS that makes nr_cpu_ids a compile-time
defined.

Hence, the num_processors >= nr_cpus - 1,
may become: num_processors >= 0, if NR_CPUS == 1.

So the plain straightforward fix would be:

    if (!boot_cpu_detected &&
 #if (NR_CPUS > 1)
        num_processors >= nr_cpu_ids - 1 &&
 #endif
        apicid != boot_cpu_physical_apicid) { ... }

However, I have a feeling that all the logic above is not needed at
all on UP machines. If that's true, the '#if NR_CPUS > 1' should
protect the whole condition, or even bigger piece of the
generic_processor_info().

Guys, could you please comment on that?

Thanks,
Yury
