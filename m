Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC71052007F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbiEIPBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237949AbiEIPBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:01:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7693927A899;
        Mon,  9 May 2022 07:57:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x18so14082481plg.6;
        Mon, 09 May 2022 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=Rv24537FAid4FkoG5vC//ersbcU5Q/QTrNuy2uhLE+c=;
        b=YPkDSwQ5S0E7Oy1AUcGX1O14/o7qtUFAXUSXV/GU1bvmxUPafqgmsbqufLfn3pDvUz
         KinPrlyrMM7g948dadsAtTQTbqkM0/oO4bsBTGY3Rt3uBP0jxW3EXKeWmgsguxTtOqLk
         Ya0E4HH3YiQerNLit6T2CBwt6UPs8VV4vcP10SD/AhQpiJMwRQbR0guT8hMe9MaoMnTW
         dzcvjEWgkvi4gdG4lVMVqzgWP7q4aghJFTwJ7qiGoR3ChpqZSSJpfu02kWGRrOw5+vwA
         c5Esi9//CD67WHWnFWrSa8QFRdAAJ0OTP7+K8TfQ8ln4En7SfcAeJyHu4sGEOPQfmUnD
         lN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=Rv24537FAid4FkoG5vC//ersbcU5Q/QTrNuy2uhLE+c=;
        b=N34x0eL3m+Cu9fks1aKN1puGOwwJ24UlZoEuI/onmBoW6/HmxZoDtb7Z7cgpmrupMu
         tigkTWFEGHCdOKVk2Hly+vcZwkoKrmFLX9shm6YjFJvqCkjAWOpsbTdUsJcTR0oe4KIF
         3bEpM7OrRvip7bVy3NfJV8xcErP2EYTRANwfZpZKPdrVPwGeGxH2oeaslzPKapc4g1qa
         8q6+1DFmi8/Z6ifOwaFV1VEJGqck5wWNIaxfbFgiGAFNCInbu6ysGYCzdwOoQnkg574B
         A1PUw6cU9xA6GD93lR4Xz4ns7ooAKWmjwyIx0sjA3KLm7ny6rz85b5bfdxnPwrBZ1ShR
         yI4w==
X-Gm-Message-State: AOAM531/l5ox8XQTrsWvu0oAa3U90fogP4UPgSo5kbtKvmsUHv43i2eo
        vaJctF68HviASfHWVA6y+Zc=
X-Google-Smtp-Source: ABdhPJwrkAzjNvukP+xrbe/mrqvr3+QVoCnL9nosgzjDlSCxY5RDZLM/k5624oZsIpeWrJEh6LhFcQ==
X-Received: by 2002:a17:90b:4c10:b0:1dc:8289:7266 with SMTP id na16-20020a17090b4c1000b001dc82897266mr26873370pjb.190.1652108228929;
        Mon, 09 May 2022 07:57:08 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id hi1-20020a17090b30c100b001da3780bfd3sm133322pjb.0.2022.05.09.07.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 07:57:08 -0700 (PDT)
Message-ID: <92a7010c-5bb2-65df-edde-0ca88e035c2e@gmail.com>
Date:   Mon, 9 May 2022 23:56:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v6 18/23] docs: add Rust documentation
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Wu XiangCheng <bobwxc@email.cn>, Daniel Xu <dxu@dxuuu.xyz>,
        Gary Guo <gary@garyguo.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yuki Okushi <jtitor@2k36.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Julian Merkle <me@jvmerkle.de>, Finn Behrens <me@kloenk.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Wei Liu <wei.liu@kernel.org>
References: <20220507052451.12890-19-ojeda@kernel.org>
 <7e9c2e77-8b70-6e15-3f3d-905ab42b0fcd@gmail.com>
 <CANiq72mBVo4+htxVjY0wB1Y3GO2PEUiZjZKRYT8ddwx84-hAtg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANiq72mBVo4+htxVjY0wB1Y3GO2PEUiZjZKRYT8ddwx84-hAtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+To: Jon]

On Mon, 9 May 2022 12:41:28 +0200,
Miguel Ojeda wrote:
> Hi Akira,
> 
> On Mon, May 9, 2022 at 6:02 AM Akira Yokosawa <akiyks@gmail.com> wrote:
>>
>> I think you agreed splitting SVG part into its own patch with
>> a proper copying info, etc.  Let me see...  So, here is the link:
> 
> Yes, sorry, will do (in fact, it should have been there in v5 too).
> 
> By the way, the Linux SVG logo (used to make the one here) is pending
> in the linux-doc ML.

So you mean the following post:

    https://lore.kernel.org/lkml/20220207014418.GA28724@kernel.org/

I'm not sure why Jon has not responded.

Jon, was there any issue on this patch?

> 
>> I might have missed v5 of this patch series.
>> That might be because v5's 15/20 was not accepted by linux-doc's
>> lore archive (maybe) due to its size despite it had Cc: linux-doc.
>> v6's 18/23 was also rejected.
> 
> Yes, a few patches get rejected in several lists. We were told this
> was fine as long as LKML gets them (the cover letter has the lists in
> Cc).
> 
>> I have some alternative ideas for table formatting in ReST.
> 
> I was following the LLVM one, but it makes sense to use the other ones
> where possible. I can send a patch for that one too.
> 
>> So here are a couple of alternative ways to represent the table
>>
>> * ASCII-art format:
>> * Literal block format:
> 
> Thanks for taking the time to format the examples, it is useful :)
Glad you like it.  ;-)

        Thanks, Akira

> 
>> As you see, those inline-literal markers of ``xxxx``, which are
>> distracting when the .rst file is read as plain-text, are not
>> necessary in the literal-block approach.  And you can directly
> 
> I agree, it can be better (it is one reason I find Markdown a bit more
> readable since it uses a single backquote for that instead of two).
> 
>> In my opinion, the literal-block approach should be the most
>> reasonable choice here. Of course its your call which one
>> to choose.
> 
> Yeah, that sounds reasonable. I will take a look.
> 
> Thanks for the review!
> 
> Cheers,
> Miguel
