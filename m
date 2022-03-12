Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74254D6E4D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 12:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiCLLFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 06:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiCLLFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 06:05:41 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D7120D53C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 03:04:36 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id r12so9741448pla.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 03:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xixA67+CyBszDmeLpcJ5bC/ErLQH8CHjHgxpS8GoaOg=;
        b=FaLddWrjzCNwNpV+4oG8wrN5zawUTnx/S2++0S0ZRKYRxMR78ty3GxOil0Zbmj8ikz
         k+chYyEryktbPiwQKEHbPn8RNkffjmIyd740/rFdMw5lTHeZX46BFlrOLiAAwpb9FXrH
         zS5kOtAffkm3QWBtFisz/Qarv/HbKrO0qthDc752+0XABN43fAazTM5BSuee8pMZkHr2
         UDS6uRSdAVjtm/Vmw5Ka4G7RkAtPnpcVsEq43nPVKuvtrj99oO/c+XM0v93FYCWkmFVY
         saf7Ma6zqhQdpP9QMEcPe27O0mEzcmHwtt16uAGyEKCndgR3MG44bf06QArQpwW6w31M
         mlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xixA67+CyBszDmeLpcJ5bC/ErLQH8CHjHgxpS8GoaOg=;
        b=HalfMh3HOgW3OTp5RhP7mY61KuwWea8jpIVs9zuASraSw1Y6oda3udgUPvUHrU2UX6
         wQPUqW7fCxqhCAtFlZOYc+ltU8G90V01RJng8HlnXpOtDz2gubhCtC1cMa26AZcaeq2j
         TquJRUzRX3BSQYSUGce3J8OaYIz78ktE5XEi8CmDUXmdCN/4KgOiDIGMXO6nxcrZ7/bf
         yaUzVPlVo0iKlSyz/KHlrpVZOUtTW/0Hu55jDj8naELmkfkqTRiyUq1DdoLBT+x1DLIE
         AWm40c/Xhk+aUmqnaSGWtjl6awURRg9OUAdWaR0pzJdESLp1OOuzpU4sdvpKKMUps3Pq
         7BAA==
X-Gm-Message-State: AOAM531K1UASfvBc3ubs6wLwhPeWDnI5yIEoXJlRaX3i2/VvPyOyUNy/
        rnJLGat+Z8bMQ0F62c2qxLFmLd+3vhIskQ==
X-Google-Smtp-Source: ABdhPJyAMdhmVdu1pjPZfi4n63j0CbVjP5SByz4pCfc/FT5kaIKcKjAvUJB0tmT20vcopupAUH9oHw==
X-Received: by 2002:a17:902:b614:b0:151:f034:4058 with SMTP id b20-20020a170902b61400b00151f0344058mr15057749pls.84.1647083075766;
        Sat, 12 Mar 2022 03:04:35 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id a20-20020a056a000c9400b004f7ab5a44ebsm1885214pfv.18.2022.03.12.03.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 03:04:35 -0800 (PST)
Date:   Sat, 12 Mar 2022 11:04:30 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Oliver Glitta <glittao@gmail.com>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>
Subject: Re: [mm/slub] ae107fa919: BUG:unable_to_handle_page_fault_for_address
Message-ID: <Yix+Pn9a9yKIiXC4@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220311145427.GA1227220@odroid>
 <667d594b-bdad-4082-09d5-7b0587af2ae3@suse.cz>
 <20220311164600.GA1234616@odroid>
 <YivzD7PYilkFwjFt@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <a8dc8bc4-9a00-b2f7-1f68-273f7a14a14c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8dc8bc4-9a00-b2f7-1f68-273f7a14a14c@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 10:21:25AM +0100, Vlastimil Babka wrote:
> On 3/12/22 02:10, Hyeonggon Yoo wrote:
> > On Fri, Mar 11, 2022 at 04:46:00PM +0000, Hyeonggon Yoo wrote:
> >> On Fri, Mar 11, 2022 at 04:36:47PM +0100, Vlastimil Babka wrote:
> >>> On 3/11/22 15:54, Hyeonggon Yoo wrote:
> >>>> On Wed, Mar 09, 2022 at 10:15:31AM +0800, kernel test robot wrote:
> >>>>>
> >>>>>
> >>>>> Greeting,
> >>>>>
> >>>>> FYI, we noticed the following commit (built with gcc-9):
> >>>>>
> >>>>> commit: ae107fa91914f098cd54ab77e68f83dd6259e901 ("mm/slub: use stackdepot to save stack trace in objects")
> >>>>> https://git.kernel.org/cgit/linux/kernel/git/vbabka/linux.git slub-stackdepot-v3r0
> >>>>>
> >>>>> in testcase: boot
> >>>>>
> >>>>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >>>>>
> >>>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >>>>>
> >>>>
> >>>> [+Cc Vlastimil and linux-mm]
> >>>
> >>> Thanks.
> >>> lkp folks: it would be nice if I was CC'd automatically on this, it's a
> >>> commit from my git tree and with by s-o-b :)
> >>>
> >>>> I _strongly_ suspect that this is because we don't initialize
> >>>> stack_table[i] = NULL when we allocate it from memblock_alloc().
> >>>
> >>> No, Mike (CC'd) suggested to drop the array init cycle, because
> >>> memblock_alloc would zero the area anyway.
> >>
> >> Ah, you are right. My mistake.
> >>
> >>> There has to be a different
> >>> reason. Wondering if dmesg contains the stack depot initialization message
> >>> at all...
> >>
> >> I think I found the reason.
> >> This is because of CONFIG_SLUB_DEBUG_ON.
> >> It can enable debugging without passing boot parameter.
> >>
> >> if CONFIG_SLUB_DEBUG_ON=y && slub_debug is not passed, we do not call
> >> stack_depot_want_early_init(), but the debugging flags are set.
> >>
> >> And we only call stack_depot_init() later in kmem_cache_create_usercopy().
> >>
> >> so it crashed while creating boot cache.
> > 
> > I tested this, and this was the reason.
> > It crashed on CONFIG_SLUB_DEBUG_ON=y because stackdepot always assume
> > that it was initialized in boot step, or failed
> > (stack_depot_disable=true).
> > 
> > But as it didn't even tried to initialize it, stack_table == NULL &&
> > stack_depot_disable == false. So accessing *(NULL + <hash value>)
> 
> Thanks for finding the cause!
> 

;)

> > Ideas? implementing something like kmem_cache_init_early() again?
> 
> I think we could simply make CONFIG_SLUB_DEBUG_ON select/depend on
> STACKDEPOT_ALWAYS_INIT?

Oh, sounds better.

If we make CONFIG_SLUB_DEBUG_ON select STACK_DEPOT_ALWAYS_INIT,
that is simple solution. but stackdepot will be initialized on
slub_debug=- too.

But I think no one will set CONFIG_SLUB_DEBUG_ON=y if not debugging...

I don't think making CONFIG_SLUB_DEBUG_ON depend on
CONFIG_STACKDEPOT_ALWAYS_INIT is good solution. only KASAN selects it.

-- 
Thank you, You are awesome!
Hyeonggon :-)
