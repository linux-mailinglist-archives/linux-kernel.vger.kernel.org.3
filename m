Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBEC50B733
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447427AbiDVM2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447278AbiDVM2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:28:05 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B279A5004E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:25:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lc2so16011631ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lq7WNFbOSrFlSFW0e3kKFkFVp3DEA1SywoNgEtsMpK8=;
        b=FOLY30bIBvIVaRrJQACb/lTEfRKUQOKCk5p6zl+J3W0dT3hgACPMlfRKI0Xaf2Vt4v
         5T2ilx/0rVdPzQPHHQVD7YGvp9iEoBR9iWdpVVU9nmQrphj1rniBGKmQ0Gpt+nOxqcOU
         YB37cLlQHcy/IEXXrxkFBkIVtkhZko/dJ70Oijant1feZDKHb4pYLc1ZvPv9HHsj9azY
         9JgPEGdnO3p6u9pl/i9h6pcSrKSHr6OjsPgfkPX9wQMCBq1EU/06PAZ+Bxk+le/M5HIJ
         f3mW3/vDR7Xc6SLjCZ9lUCBaS7BVEd2yqEEoI1V+lw43GEQFuObAYsV5dLfnuRkQFVCG
         TKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lq7WNFbOSrFlSFW0e3kKFkFVp3DEA1SywoNgEtsMpK8=;
        b=oIzKBtxDzSkiu9zptHtbmwdLmDsagIE5h4oTjgNNrG3TPSyK/wg3RlEt9HoIQJ0SyZ
         ufiVJG7ubKq7pMMPxK0EYJFQitVydt10v/h5/1ZbiLo7/svqU2W7iRfLvTM9uZ8e1e0Y
         IC3zKbxqahxe4Z8WKkqSfgbvjTV5AYxEU6AVcZWFviZyDjXuKJfUuHsUybnaVdKofICl
         JbrHaLths+azXsVdLgFi2YCvAKDtim2zAF2p0ollOMoFpcA/4Zj3WSeUMw12kgFNStSy
         xX+CktCeky80zLh4OW5sQaBpouUW+oTZlsmH5XKBEyDruD6WDlXLp9iAgImJXUzOukeN
         zERQ==
X-Gm-Message-State: AOAM531UkCOVbb7z+Jt76EyJoD1BiG8vgedRn6AQUil4p4sH1T5CeIST
        SKBkM8VNzVQOYbXCRyaYKPY/UQ==
X-Google-Smtp-Source: ABdhPJzEGTEsUDQtA6x5liMjUKZR0MSGG2VTMMS5Y7ay2cMr7XtGMGS1i4wbj8Q9NVxF9rCoi3hFiw==
X-Received: by 2002:a17:906:474d:b0:6e8:89ef:f9a with SMTP id j13-20020a170906474d00b006e889ef0f9amr3959575ejs.322.1650630309014;
        Fri, 22 Apr 2022 05:25:09 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id q7-20020a170906540700b006d5eca5c9cfsm703583ejo.191.2022.04.22.05.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 05:25:07 -0700 (PDT)
Message-ID: <aebb4ddb-e183-67a5-76fe-016b61b568b6@tessares.net>
Date:   Fri, 22 Apr 2022 14:25:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] x86/pm: fix false positive kmemleak report in
 msr_build_context()
Content-Language: en-GB
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chen Yu <yu.c.chen@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220421161520.401946-1-matthieu.baerts@tessares.net>
 <99ac4b6-bea7-325e-1ca-cbf78982f5c1@linux.intel.com>
 <CAJZ5v0i-67mJe2eAVr2XS=POY33FbXD44fMfD3F84yGZq+wx3A@mail.gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAJZ5v0i-67mJe2eAVr2XS=POY33FbXD44fMfD3F84yGZq+wx3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mat, Rafael,

(oops, please ignore the "mptcp-next" tag I added by reflex in the
subject: this is not related to MPTCP :) )

On 22/04/2022 13:51, Rafael J. Wysocki wrote:
> On Fri, Apr 22, 2022 at 1:21 AM Mat Martineau
> <mathew.j.martineau@linux.intel.com> wrote:
>>
>> On Thu, 21 Apr 2022, Matthieu Baerts wrote:
>>
>>> Since commit e2a1256b17b1 ("x86/speculation: Restore speculation related MSRs during S3 resume"),
>>> kmemleak reports this issue:
>>>
>>>  unreferenced object 0xffff888009cedc00 (size 256):
>>>    comm "swapper/0", pid 1, jiffies 4294693823 (age 73.764s)
>>>    hex dump (first 32 bytes):
>>>      00 00 00 00 00 00 00 00 48 00 00 00 00 00 00 00  ........H.......
>>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>    backtrace:
>>>      msr_build_context (include/linux/slab.h:621)
>>>      pm_check_save_msr (arch/x86/power/cpu.c:520)
>>>      do_one_initcall (init/main.c:1298)
>>>      kernel_init_freeable (init/main.c:1370)
>>>      kernel_init (init/main.c:1504)
>>>      ret_from_fork (arch/x86/entry/entry_64.S:304)
>>>
>>> It is easy to reproduce it on my side:
>>>
>>>  - boot the VM with a debug kernel config [1]
>>>  - wait ~1 minute
>>>  - start a kmemleak scan
>>>
>>> It seems kmemleak has an issue with the array allocated in
>>> msr_build_context() and assigned to a pointer in a static structure
>>> (saved_context.saved_msrs->array): there is no leak then.
>>>
>>> It looks like this is a limitation from kmemleak but that's alright,
>>> kmemleak_no_leak() can be used to avoid complaining about that.
>>>
>>> Please note that it looks like this issue is not new, e.g.
>>>
>>>  https://lore.kernel.org/all/9f1bb619-c4ee-21c4-a251-870bd4db04fa@lwfinger.net/
>>>  https://lore.kernel.org/all/94e48fcd-1dbd-ebd2-4c91-f39941735909@molgen.mpg.de/
>>>
>>> But on my side, msr_build_context() is only used since:
>>>
>>>  commit e2a1256b17b1 ("x86/speculation: Restore speculation related MSRs during S3 resume").
>>>
>>> Depending on their CPUs, others have probably the same issue since:
>>>
>>>  commit 7a9c2dd08ead ("x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume"),
>>>
>>> hence the 'Fixes' tag here below to help with the backports. But I
>>> understand if someone says the origin of this issue is more on
>>> kmemleak's side. What is unclear to me is why this issue was not seen by
>>> other people and CIs. Maybe the kernel config [1]?
>>>
>>> [1] https://github.com/multipath-tcp/mptcp_net-next/files/8531660/kmemleak-cpu-sched-bisect.kconfig.txt
>>>
>>
>> Hi Matthieu -
>>
>> It looks like the root cause here is alignment within the packed struct
>> saved_context (from suspend_64.h). Kmemleak only searches for pointers
>> that are aligned, but pahole shows that the saved_msrs struct member and
>> all members after it in the structure are unaligned:

@Mat: Thank you for the analysis and finding the root cause!

>> (gcc 11.2.1, x86_64)
>>
>> struct saved_context {
>>         struct pt_regs             regs;                 /*     0   168 */
>>         /* --- cacheline 2 boundary (128 bytes) was 40 bytes ago --- */
>>         u16                        ds;                   /*   168     2 */
>>         u16                        es;                   /*   170     2 */
>>         u16                        fs;                   /*   172     2 */
>>         u16                        gs;                   /*   174     2 */
>>         long unsigned int          kernelmode_gs_base;   /*   176     8 */
>>         long unsigned int          usermode_gs_base;     /*   184     8 */
>>         /* --- cacheline 3 boundary (192 bytes) --- */
>>         long unsigned int          fs_base;              /*   192     8 */
>>         long unsigned int          cr0;                  /*   200     8 */
>>         long unsigned int          cr2;                  /*   208     8 */
>>         long unsigned int          cr3;                  /*   216     8 */
>>         long unsigned int          cr4;                  /*   224     8 */
>>         u64                        misc_enable;          /*   232     8 */
>>         bool                       misc_enable_saved;    /*   240     1 */
>>
>> /* Note odd offset values for the remainder of this struct    vvv       */
>>
>>         struct saved_msrs          saved_msrs;           /*   241    16 */
>>         /* --- cacheline 4 boundary (256 bytes) was 1 bytes ago --- */
>>         long unsigned int          efer;                 /*   257     8 */
>>         u16                        gdt_pad;              /*   265     2 */
>>         struct desc_ptr            gdt_desc;             /*   267    10 */
>>         u16                        idt_pad;              /*   277     2 */
>>         struct desc_ptr            idt;                  /*   279    10 */
>>         u16                        ldt;                  /*   289     2 */
>>         u16                        tss;                  /*   291     2 */
>>         long unsigned int          tr;                   /*   293     8 */
>>         long unsigned int          safety;               /*   301     8 */
>>         long unsigned int          return_address;       /*   309     8 */
>>
>>         /* size: 317, cachelines: 5, members: 25 */
>>         /* last cacheline: 61 bytes */
>> } __attribute__((__packed__));
>>
>> If I move misc_enable_saved to the end of the struct declaration,
>> saved_msrs fits in before the cacheline 4 boundary and the kmemleak
>> warning goes away. The comment above the saved_context declaration says to
>> check wakeup_64.S and __save/__restore_processor_state() if the struct is
>> modified - looks like it's the members before misc_enable that must be
>> carefully placed.
> 
> Yes, you can move misc_enable_saved to the end of it safely AFAICS.

@Rafael: thank you for the reply!

Before doing that, is it still needed to keep the "packed" attribute?
This attribute was already there before the first Git commit.


Without it, I no longer have the kmemleak and pahole reports this:


  struct saved_context {

  (...)
        bool                       misc_enable_saved;    /*   240   1 */

        /* XXX 7 bytes hole, try to pack */

        struct saved_msrs          saved_msrs;           /*   248  16 */

  (...)

        /* size: 328, cachelines: 6, members: 25 */
        /* sum members: 317, holes: 2, sum holes: 11 */
        /* last cacheline: 8 bytes */
  };


Everything is still at the same place before 'misc_enable' member.

If it is important to reduce the cachelines, it is still interesting to
move the bool to avoid a whole which costs one cacheline.


>> So far I've only tried this on my local machine, I'll work on getting more
>> thorough validation.
>>
>> Looks like struct saved_context in suspend_32.h has similar odd alignment.
> 
> Right, and it can be changed too AFAICS.


Thanks!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
