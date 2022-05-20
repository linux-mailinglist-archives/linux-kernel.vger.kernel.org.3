Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCDE52E29F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344799AbiETCqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344812AbiETCqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:46:39 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAC2580CB
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 19:46:37 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id n24so8544377oie.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 19:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AnqtX3sIUNiqX0AppdAYr4oPhPPFHWqLlZIUGIQn0zs=;
        b=D7alRWyO5jd8VytbA5RpfSyBYFMszsTGAQi+xvlrZov0kUZJKA4z3tdX1K1P7CB29W
         TsBMzmv3uVLrdSMbLgV5cyZ3cNnWcwK4Vdv1eOxOFQWr/JOCYHyJ2RjTCmF0nrCSOIOY
         aXAOFpYBxWmz/pH80wzFX0PufkvOhrrd9uB1W85JiWQnu1r9lV6I0J4n/a9oRif43pSs
         A4jhOjYoeODX0Bfw2jzSCSHWtlSMdhEMk/+qGrBGYn+2ipTwqny74ZidzBh9Fxk7VyHP
         KKzN9NBpaxNEq/8/jP4XwWGhIGyqIK+/OngS705CWtcHYc9hNr9+adUM+ekWRzNtTktM
         vjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AnqtX3sIUNiqX0AppdAYr4oPhPPFHWqLlZIUGIQn0zs=;
        b=4RFfcMVUKMIuxK6wnLYE3n2o6FxwfXAddAvPl0xd9/PC6c0Ikea/fackuZhuFlx1Tf
         NplISWyF4ArnGsUqQ6nB4e2U6LWADJysErPgAg3Fz7GgL2x5Mj+FggDnuVKPYPT3ThRE
         8zxKky/lUJPsxMp3u10uP9AGDr2iFDmYireHFv7B20wmIhax5ev4qn6kgeZRhudT4VNR
         ir0h5jEplLe0ZXrIASgK27tS1hBmsEC4GhBcF0G57mxRi2Dxyut4/dpZFTPioLkX+l+p
         vc9lrGPuDAl+iwPPnUA6wHHFszSGXIzFPE2g6kszVSA7X6NXQnDbGelTMNkNzXvrPFZW
         G99A==
X-Gm-Message-State: AOAM5333i1mBnwkJ25evM2Gtmv5a013xidgr7dS8/LTH93BRKUgeLMjf
        EOeWpHteA01oHR+L331u6rA=
X-Google-Smtp-Source: ABdhPJzR+S9embiA4Xg+TDPBmscmZoeu7c01xlUCpq50ChT24U8pnJGfod/8a/vySkePP/GsxssZhA==
X-Received: by 2002:a05:6808:1927:b0:326:9b99:abb6 with SMTP id bf39-20020a056808192700b003269b99abb6mr4579790oib.255.1653014797269;
        Thu, 19 May 2022 19:46:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e12-20020a056820060c00b0035eb4e5a6d8sm490625oow.46.2022.05.19.19.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 19:46:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3b34ce31-486b-7e4d-7b4b-bb97902117a7@roeck-us.net>
Date:   Thu, 19 May 2022 19:46:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/6] x86/entry: Use PUSH_AND_CLEAR_REGS for compat
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@suse.de>
References: <20220506121431.563656641@infradead.org>
 <20220506121631.293889636@infradead.org>
 <20220519162411.GA4095576@roeck-us.net>
 <20220519170009.GL2578@worktop.programming.kicks-ass.net>
 <20220519171129.enw32izjhxsqc2xm@treble>
 <20220519173538.nywtw2h3y7sqfojn@treble>
 <CAJhGHyC0sztc2_jTT+U1M2+OSNxfNgmaKJyZgySwYqKM06q7hg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAJhGHyC0sztc2_jTT+U1M2+OSNxfNgmaKJyZgySwYqKM06q7hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 18:11, Lai Jiangshan wrote:
> On Fri, May 20, 2022 at 1:35 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>>
>> diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
>> index ed2be3615b50..f76e674d22c4 100644
>> --- a/arch/x86/entry/entry_64_compat.S
>> +++ b/arch/x86/entry/entry_64_compat.S
>> @@ -200,7 +200,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
>>   SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
>>          movl    %eax, %eax              /* discard orig_ax high bits */
>>          pushq   %rax                    /* pt_regs->orig_ax */
>> -       PUSH_AND_CLEAR_REGS rax=$-ENOSYS
>> +       PUSH_AND_CLEAR_REGS rcx=%rbp rax=$-ENOSYS
> 
> Some comments need to be here to explain why %rcx is stashed in %rbp.
> 

I am curious. That comment wasn't needed before the problem fixed here
was introduced. The comment is unrelated to the bug fix. Why is it needed
now, and why would it be a prerequisite for fixing a critical bug ?
Shouldn't that comment be added in a separate patch ?

Thanks,
Guenter
