Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFB556C433
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiGHXBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbiGHXBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:01:09 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A22371B6;
        Fri,  8 Jul 2022 16:01:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so3308187pjl.5;
        Fri, 08 Jul 2022 16:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9KPxum5Y9Isn7rZn2/JGp+nZofr050j4c+jB47X8HOk=;
        b=KYS0zXyXwZT+5D0dhJ20Cs4YuUOGiiwi8M09ADt0H2PEfOTIsyY58EY3Yj3tJ4Yv7G
         KJSO1lKr0HZtOE5MRmmx4tNZpoHYb4yuGfnnXa7yVWYQl7VaNtXsmY1VIo4XZb9iQVI2
         /ZCogSsaPRB5ni5N3FRb+0VrUHi/8lMnN0sIMzSgQhI1yw5xF3yN0aBji3v5W4v0rogF
         0yafMsW5ewimYsgHrZFKmOQxBkxsQtpwY17MeZuPxEh0CFlG0+g62nHP5lkY34O2xD0k
         09CTwR7kugvRB3Ra5vCo/+CJ8k/xkToWH0Adn6+Njdefkou6jsZfOSZ7NZsJZ3fjxX6W
         lDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9KPxum5Y9Isn7rZn2/JGp+nZofr050j4c+jB47X8HOk=;
        b=OLHE14ZiAG2a9gy5CqX5IN4J6w55VAPXTyHagmrNS8GUua6ar6ZquC6zTVJ4r8wgof
         Zyn6y4tuvrC340jj5DE7Bt4BfhQkWsDNhBsmkv9JLeCYRpMEJbyH2AQvTBjWogpzEPqL
         jZrcdccZsMFVV6dCtPI6ci2xcMoyMp/wd1OhEQU4LWNMh1TsnF/9sNiYXPErAlT+Omuw
         v36Y9QVTQnIoox6LVtXkFOWC5XPQ0dFgPBOPdfkWokVQCJvEJei6oVWn8ldUhjVJFDI+
         CtV4t5pjgK5Gka1Ob5HZCoE4/oP8ZKM1CBvn2oUE3YBe4HJSXTUOdc8SUzOMyZLyHVj3
         phpg==
X-Gm-Message-State: AJIora8GjpYiw4DGXkRnm6QcCIUy05rwu2FbYXlMOATdACP1PZRMiDXC
        TC0Z30ESuFkdKi+oXhYMI8s=
X-Google-Smtp-Source: AGRyM1u4XZJAEn/CTPHLS1yEd4fefsa/LStK1szCGHPzWEVtKxkjpDBe9x0F67AFscv8wdqF1YdEFQ==
X-Received: by 2002:a17:902:f7cc:b0:16c:10a6:9e25 with SMTP id h12-20020a170902f7cc00b0016c10a69e25mr6218867plw.162.1657321267602;
        Fri, 08 Jul 2022 16:01:07 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id a6-20020aa795a6000000b00528d752969esm117906pfk.25.2022.07.08.16.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 16:01:07 -0700 (PDT)
Message-ID: <02a76970-78fb-5d09-6890-cc1dc11ca4db@gmail.com>
Date:   Sat, 9 Jul 2022 08:01:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Expectation to --no-pdf option (was Re: [PATCH v2 0/5] Address
 some issues with sphinx detection)
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+huawei@kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <cover.1656756450.git.mchehab@kernel.org>
 <d0e1a08a-b965-ada6-e026-4e1cc38fbd90@gmail.com>
 <20220707211558.438a27d4@sal.lan>
 <3ba5a52e-cab6-05cf-a66e-adc58c467e1f@gmail.com>
 <87bktzhfcj.fsf@meer.lwn.net> <20220708155910.7c4ea35c@sal.lan>
 <d54415bb-9bad-6fd8-5636-218c04d5615a@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <d54415bb-9bad-6fd8-5636-218c04d5615a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[-CC: ksummit-discuss]
On Sat, 9 Jul 2022 00:27:25 +0900, Akira Yokosawa wrote:
> On Fri, 8 Jul 2022 15:59:10 +0100,
> Mauro Carvalho Chehab wrote:
>> Em Fri, 08 Jul 2022 08:02:52 -0600
>> Jonathan Corbet <corbet@lwn.net> escreveu:
>>
>>> Akira Yokosawa <akiyks@gmail.com> writes:
>>>
>>>> In my tests, the mathjax extension works with all the versions of Sphinx
>>>> I tested (1.7.9, 2.4.4, 3.4.3 (debian bullseye), 4.2.0 (openSUSE LEAP 15.4),
>>>> and 5.0.2).
>>>> Note that math expressions should look much sharper (vector fonts)
>>>> than those from imgmath (pixel images).
>>>> The time for a browser to complete the rendering might be longer than
>>>> with imgmath, especially for pages with a lot of math expressions,
>>>> though.  (Yes, I see some of media documents have a lot of them.)
>>>>
>>>> When you are detached from network connections, browsers will give
>>>> up and show those expressions in mathjax source code. 
>>
>>> -extensions.append("sphinx.ext.imgmath")
>>> +extensions.append("sphinx.ext.mathjax")
>>
>> There are two problems with this:
>>
>> 1. mathjax doesn't work for PDF output - nor would work if we add support
>>    for man pages some day;
> 
> Hmm, if I understand what is written in the following page:
>     https://www.sphinx-doc.org/en/master/usage/extensions/math.html
> 
> , both imgmath and mathjax extensions are relevant only for HTML output.
> 
> It says:
> 
>     Changed in version 1.8: Math support for non-HTML builders is integrated
>     to sphinx-core. So mathbase extension is no longer needed.
> 
> When did you see the issue of "mathjax doesn't work for PDF output" ?

For the record,

I tested mathjax and PDF output with Sphinx 1.7.9, whose latex mode
can't handle nested tables.
I had no problem in building userspace-api.pdf and math expressions
in it look perfect.

So I believe mathjax does not affect PDF output.

Mauro wrote:
> As imgmath works everywere, we opted to use it instead. We were
> actually hoping that the lack of proper math support on Sphinx were
> something that later Sphinx versions after 1.3.1 would have fixed. 

I'm not going to test earlier versions of Sphinx and I have no idea
of what issue Mauro saw at the time, but it sounds to me the issue
has been fixed since.

> 
>> 2. Some Kernel developers disable javascript.
> OK, mathjax has no chance, then...

On the second thought, I think mathjax (latex-free "make htmldocs")
is good enough for test build purposes.  When javascript is disabled,
math expressions are rendered in mathjax source.

As conf.py is programmable, it is possible to choose sphinx.ext.imgmath
when dvipng is found on the build system.

As for sphinx-pre-install, what about adding an option

    --no-js   For those who disable javascript in their browser.

which provide the list of required packages for dvipng?
 
Thoughts?

Some comforting news for Jon:

Jon wrote:
> Pulling in a bunch of JavaScript from the net while browsing the kernel
> docs is not an entirely pleasing solution either.  But perhaps it's
> preferable to loading the system with Latex.

With Sphinx >=4.0, mathjax is loaded only when a page with math expressions
is opened.  Sphinx is improving in this regard.
    
        Thanks, Akira

> 
>         Thanks, Akira
> 
