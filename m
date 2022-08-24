Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C0E5A049E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 01:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiHXX2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 19:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiHXX2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 19:28:30 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7C56EF16
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 16:28:29 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id 83so12273313pfw.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 16:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=G0ySZZcLlbrtg1sbUR0T0eGd+OHbyJMxGcV3YBMLCvg=;
        b=1rT/ChS8YO0DgK8G1nr8mt6aqXCxEhNtJ2/3Zyk3+g08XKCgU77fbvG1K+z1d6XUeD
         j0KJ05E1Qtbxs5rkJAPs6aO04dQw0urMz58xTkGxBC5Za7b0kONxM/fb91HNyzxiWVRb
         /krvOxEuuxfOWw93++6oeYztQRPMdlzJOEDgxupt7tls66ql2mHoVCxTFfjtARc4JyWu
         B/49ky5piEwTopWX2iq6sRANXFDS8Z3w8uhjGEycpH9C0yPTus9wNMeX6Zp+3V0wGv8s
         u5ExH8Aoq00pTP4+qwyv0Jru7nyA6gnIHYetwq06LGobKtEHpLMkZFTcr3qDP7nsjM8a
         vczQ==
X-Gm-Message-State: ACgBeo0/pCYgntvmsA0sZeWTLx6zpzYOu/WfSSZIyoRok+jMF71PQ3/N
        Vv6O293x2UxZmuyb5A2BWknDMRtEYNA=
X-Google-Smtp-Source: AA6agR4iSCV+nKUZ/rufe1pIn5xoSf6icKagqHKE9ogrdTsNvHfJLaYz9+irf7VB10KoQCBZpA7pYQ==
X-Received: by 2002:a65:6849:0:b0:42b:3b1b:94bf with SMTP id q9-20020a656849000000b0042b3b1b94bfmr955024pgt.168.1661383708749;
        Wed, 24 Aug 2022 16:28:28 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:222f:dc9c:99a3:dfb8? ([2620:15c:211:201:222f:dc9c:99a3:dfb8])
        by smtp.gmail.com with ESMTPSA id 203-20020a6215d4000000b005350ea966c7sm13682161pfv.154.2022.08.24.16.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 16:28:27 -0700 (PDT)
Message-ID: <353e5bbd-cdd1-f818-6a2f-9a7c800f9879@acm.org>
Date:   Wed, 24 Aug 2022 16:28:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20220821000737.328590235@goodmis.org>
 <20220821000844.510643400@goodmis.org>
 <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
 <5700ac75-f6a9-877e-4011-9b314f12b5ab@acm.org>
 <CAHk-=wjqkWEr0MRO5hWuBoTDgNUj4qQK8V_Y36et=61mdPztJw@mail.gmail.com>
 <02daa3d6-2847-d7e0-e23e-411076c6d4db@rasmusvillemoes.dk>
 <0163b361-14bf-7b4c-751a-14f1a004b1a9@acm.org>
 <CAHk-=wjMLb30d0WT_RyKBCX+JBkg3QQU6pCYkrV8f58Ya4Rgzw@mail.gmail.com>
 <b79c83af-e9fc-9fa0-dff7-f3a8a39887ff@acm.org>
 <CAHk-=wgV1F7_ErXkXT2wd+07LJd_3Vp-yVUKLROPiEgijeoTrQ@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHk-=wgV1F7_ErXkXT2wd+07LJd_3Vp-yVUKLROPiEgijeoTrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 18:49, Linus Torvalds wrote:
> On Tue, Aug 23, 2022 at 5:09 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> I'm probably doing something wrong but even with sparse commit 658ee8e0f631
>> ("unrestricted values are unrestricted even after a cast") I see warnings
>> being triggered by users of the is_signed_type() macro, warnings that
>> disappear if I change the definition of the is_signed_type() macro into 0:
> 
> That's the
> 
>> It does require that kernel change to make
>>
>>    #define is_signed_type(type)   (((type)(-1)) <= (type)0)
> 
> part I was talking about.
> 
> So your kernel side patch looks fine, except I don't think you need
> the '__force' - the sparse patches in my tree should make sparse happy
> about casting '-1'.
> 
> But I didn't do very much testing.

Hi Linus,

Can you take a look at the following report from the kernel test robot:
https://lore.kernel.org/all/202208250433.EVz5pZkB-lkp@intel.com/ ?

Do I see correctly that gcc reports a new warning for the above 
definition of is_signed_type() with W=1? I'm not sure how to get rid of 
that new gcc warning without reintroducing a sparse warning.

The tree that the kernel robot tested is available here: 
https://github.com/bvanassche/linux/tree/tracing

Thanks,

Bart.
