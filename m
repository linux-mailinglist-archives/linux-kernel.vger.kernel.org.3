Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D514B1C04
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347193AbiBKCNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 21:13:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347185AbiBKCNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:13:01 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FBA5FAE;
        Thu, 10 Feb 2022 18:12:58 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id t36so2793328pfg.0;
        Thu, 10 Feb 2022 18:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kJaUyGI5OB38GJiiOS4eIX+xTa8bB0i/SOaEo9qgjZA=;
        b=gKUU4tGYQBqLPUVQoNa5Wuaev6ZOfHlXcoF5aGQl5sENbsqigUvlFxHgdsDDwNNaNw
         /AdxcZ9RUakFVB2Moh+4lXC36HwaHGQ+WXJ/fb02x/p9z5ZFDVJNbTJUPwkp7ksNMvzL
         vjjMy9CR4KSSK5jheR/u1MY47oZdIfOsE2B4km7ltCz4umQod6pYu2EJpt6JOZDspEk1
         h1ebWQ/Luqwa+MXWcywa/AtKTgn9rjD2Ff9lpk8BfCW1hH7X3T9j95q8siqP7KnsWSdo
         wc4FqXThacdAuVsWpnGoTa4VtwOyZdRILR+Bn35g8BpbvtIOtgfHS03hLLz5qXAugn+S
         qmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kJaUyGI5OB38GJiiOS4eIX+xTa8bB0i/SOaEo9qgjZA=;
        b=5rzZkWaBJIo9jTGLg3xkzFVVBaOMwFYgMBx3FJvuo6V1xdNKp9h3qh6pVDBBzc0DSK
         A+z7Hcxj28n8Wg+x4XaPcW2AFVvpZbaj2gcfZ/3ubWi5L48CfLptsIhcgICd85VaLzci
         8u5Ibe64mKg+s6wVW0gfwRjMgXgtGJJoku/ZuVzLNNqddrXhBCxvBPjTZylcIHQAB5gH
         D86ooZ/HMHroUH94sABnqMonXqKgZPuRdP7tmdSTiTKLQejoDCwk+vz3cmhG1v+khHJ4
         1y7nnXLHYqQ/4pilwBl6SJ3vhXE6KVK4JqpLYtU9k0qo4AydbD4uH7irGN7sWAJY3wk+
         Zt/A==
X-Gm-Message-State: AOAM531RvZeE5nSuJhmngkAh45+CpyaQ9kvCc73mdlrw/QJ0BticPbX3
        zQ31buYXZaVK832oW3c99Pg=
X-Google-Smtp-Source: ABdhPJzbw3paYgmGtVUNSguKM8gkq5lko5whvrYl/qrk7Zp/IdHcvaUdwo9eI5KwegzLcyvtB/+Jqg==
X-Received: by 2002:a63:b709:: with SMTP id t9mr8633092pgf.248.1644545577879;
        Thu, 10 Feb 2022 18:12:57 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id b1sm9034624pgb.66.2022.02.10.18.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 18:12:57 -0800 (PST)
Message-ID: <52112481-29af-1f8c-b82c-3519582e9850@gmail.com>
Date:   Fri, 11 Feb 2022 11:12:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] docs: Makefile: Add -no-shell-escape option to LATEXOPTS
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <519bd2d9-1bee-03e1-eeb4-d9883c18be0c@gmail.com>
 <87zgmybofe.fsf@meer.lwn.net>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <87zgmybofe.fsf@meer.lwn.net>
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

On Thu, 10 Feb 2022 10:51:17 -0700,
Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
[...]
>>
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index 9f4bd42cef18..64d44c1ecad3 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -26,7 +26,7 @@ SPHINX_CONF   = conf.py
>>  PAPER         =
>>  BUILDDIR      = $(obj)/output
>>  PDFLATEX      = xelatex
>> -LATEXOPTS     = -interaction=batchmode
>> +LATEXOPTS     = -interaction=batchmode -no-shell-escape
> 
> Interesting.  In my digging now and back in 2016 [1] everything I found
> said that \write18 had to be explicitly enabled - and for good reason.
> And I could never figure out *how* we were enabling it...  It turns out
> that the net misinformed me; how come nobody ever told me that could
> happen? :)
> 
> Anyway, I've applied this, but I'm going to tweak the changelog a bit.
> My reason for wanting this isn't to make the warning go away - it's a
> *tiny* piece of the noise of a pdfdocs build.  That warning is there for
> a reason; \write18 is dangerous.  We really don't want any way for
> arbitrary shell commands to be executed via the docs build.  So the new
> text is:
> 
>   It turns out that LaTeX enables \write18, which allows arbitrary shell
>   commands to be executed from the document source, by default.  This the
>   often-seen warning during a pdfdocs build:
> 
>     restricted \write18 enabled
> 
>   That is a potential security problem and is entirely unnecessary; nothing
>   in the kernel PDF docs build needs that capability.  So disable \write18
>   explicitly.

I don't think the "restricted \write18 enabled" mode permits *arbitrary*
shell commands.  This is different from adding -shell-escape, rather the
default option is -shell-restricted.  In this mode, only those commands
listed by "kpsewhich -var-value=shell_escape_commands" are allowed.

In my setting, it lists:
bibtex,bibtex8,extractbb,gregorio,kpsewhich,makeindex,repstopdf,r-mpost,texosquery-jre8,

As you can see, the format of the list indicates that the restriction
concerns only the name of the command, which might be circumvented in
a clever way :-/

-no-shell-escape is expected to plug the hole, but LaTeX/TeX
implementation might have an unknown security issue.  Who knows!

> 
> I think I'll add a Cc: stable while I'm at it.  I know of no actual
> threat, but this is best closed.
> 
> Thanks for fixing this,
> 
> jon
> 
> [1] https://lore.kernel.org/lkml/20161113125250.779df4dd@lwn.net/

Thanks for the link.
This is useful in understanding the early days of Sphinx adoption.

I'm kind of worried that Linus might get another flashback seeing
my updates in LaTeX preamble.  ;-)

        Thanks, Akira
