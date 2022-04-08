Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284274F8C63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiDHBAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbiDHBAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:00:15 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3155130777B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 17:58:13 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id a19so2918797oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 17:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=qtnfy5Lluhx3o9lJuyl3hqcTvrYM1NguvnEk/B4576I=;
        b=qwI+2LubghbGX+gGBAi0tgA91R68FMNNdwj5/Siy+2no4MlaDvZvZA/WiVOnPvlG2e
         qSYNBAAYE67YVP51KYlq7EVjBKIXtMgVr8Hs4e5HIgY+bib8ViPjwdRJWB1DFUCRvPS6
         2xItBBnuk8XgH19CG0fbMIFBnOugdKLekeyOmevIovHXLo3Uz1DOUOx9vaxwEsdyWQVK
         0t4cplGy3pfWCrNLidOp5uvQTfKxLCX1HWSbVYlddV4Q5YNJal9b7nb2V//J1caHkZVH
         hHQWlVGAPkS+TaiE+d7ax1lU7tgNifxxgH6BQu+09fQ7/BiWDZjc8iTJlimRHgySAsUg
         1g0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=qtnfy5Lluhx3o9lJuyl3hqcTvrYM1NguvnEk/B4576I=;
        b=bZewM81e1AOuTtXQpJIkqiT038KMdZ+0zgciZeZJtyW5z3/IqBxFMNV1bIzFe4Jql2
         rt0bt9TITQBcwpLJY+pajXPlckIzOADEta1J9c/CsXJt9daFhEkFyopNYoWNeoeAWiSq
         W9QfaBfi0FLqo9KpCfL9eKGfOgpkafgEheBfYBE3K+h3SXxgoMcDQ/uLKcBLDt0FShkT
         Kfj4imPetgmz/WOc9AJn5ND2y+VOVT2Nix4lNAgO05WCxbAdyTnrFspN1+JMN7aVtE2D
         3fGGD5KMcRfRAyMaO7N4V1qiDfXcmIYDwpXUeg0MX7X6FjJ6Jq4ZEtvxgxpGExO363DW
         0k8g==
X-Gm-Message-State: AOAM532EHQucZc2YR1W2MuBjeOdcQwJF7MV0wqgynGX/F9/RV5KEhs6Z
        6fvUTP7ommmNdCTC9UfXQPA=
X-Google-Smtp-Source: ABdhPJxGLQP79OsZ/s8gPHn35e33qYjxgJVz8Xibgyfw4Ev/iA/LmiLh5sj84O9aRLS88lRP9VbENg==
X-Received: by 2002:a05:6808:8f1:b0:2da:5fcb:29b2 with SMTP id d17-20020a05680808f100b002da5fcb29b2mr48562oic.82.1649379492407;
        Thu, 07 Apr 2022 17:58:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p18-20020a056830131200b005ccf8ac6207sm8553172otq.80.2022.04.07.17.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 17:58:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <63d4c8d8-89c6-33ed-8178-be9ea86e53b9@roeck-us.net>
Date:   Thu, 7 Apr 2022 17:58:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, jstultz@google.com,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Eric Dumazet <edumazet@google.com>
References: <20220407161745.7d6754b3@gandalf.local.home>
 <20220407215802.GB186606@roeck-us.net>
 <20220407185144.5ac036b7@gandalf.local.home>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC][PATCH] timers: Add del_time_free() to be called before
 freeing timers
In-Reply-To: <20220407185144.5ac036b7@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/22 15:51, Steven Rostedt wrote:
> On Thu, 7 Apr 2022 14:58:02 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>>> Add a del_timer_free() that not only does a del_timer_sync() but will mark
>>
>> This limits the use case to situations where del_timer_sync() can actually
>> be called. There is, however, code where this is not possible.
>> Specifically, it doesn't work if the code triggered with the timer uses a
>> lock, and del_timer() is also called under that same lock. An example for
>> that is the code in sound/synth/emux/emux.c. How do you suggest to handle
>> that situation ?
> 
> Easy. Tell me how that situation is not a bug?
> 

Sure, fixing the problem is of course the right thing to do. But replacing
del_timer() with your suggested version of del_timer_free() doesn't work
with this code because it would deadlock. Sure, that would not fix the
underlying problem anyway, but that isn't the point I was trying to make:
I think it would be beneficial to be able to replace del_timer() with a
version that can not result in deadlocks but would still identify problems
such as the one in the code in emux.c.

Can we have del_timer_free() and del_timer_sync_free() ? Or am I missing
something and that doesn't really make sense ?

Thanks,
Guenter

> That code you point out at emux.c looks extremely buggy as well. In other
> words, if you can't call del_timer_free() for the reason you mention above,
> the code is very likely to have race conditions. I cannot think of a
> situation that it is safe to do this.
> 
> In fact, I think that just replacing that with del_timer_free() may be good
> enough. At least to show why it blows up later. I'm confused in what they
> are doing by taking that lock. I can see:
> 
> 	CPU1				CPU2
> 	----				----
> 				    snd_emux_timer_callback()
>      spin_lock(voice_lock)
>      if (timer_active)
> 	del_timer()
>      spin_unlock(voice_lock)
> 
> 				    [..]
> 				    	do_again++
> 				    [..]
> 				    if (do_again) {
> 					mod_timer()
> 					timer_active = 1;
> 				    }
> 
>      [..]
>      free(emu);
>  >
> BOOM!!
> 
> Hmm, perhaps I should change the code in __mod_timer() to:
> 
> 	if (WARN_ON(timer->flags & TIMER_FREED))
> 		return;
> 
> To not rearm it.
> 
> -- Steve

