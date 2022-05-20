Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B23B52EFB8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351110AbiETPwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350066AbiETPw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:52:29 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AF115FE05
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:52:27 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id v22-20020a05683011d600b0060aeae0b599so2475848otq.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=EhB/lv0xrW5Gf8DJlfv+KquZ+GUpeG3dg1zB16zvTWY=;
        b=QnVwIWj338v0R9Yd4Lfmvj9Ay7nt1uNCKkpcLOoISy5VgilCmjqCAWQglpNwtSQAa8
         CCDWDWsBE9iOGzDN10EUuWazb0nKKu8fw7ogTqXFDt4BYz9KtrEJHSgFtHRis1Je82PA
         7VWrx0oPQf2L04S5h8I65b+vif08qSVT9Wj8yNcpJqBYSZ/O/JesHxJ/47AKqsM9apCE
         mhZld7fAqIx+ra7agM6xCCNOy2qzEgQV4qxSzopSekQ/93F9i9YbZGcL9JRJsbukmlb6
         U4Q57XgMzguK9BhALYV7mVXe8NsSxNKyOxyTz5d7G5zMY/Nbg64LlTYBOXTFny1e3Skt
         nVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=EhB/lv0xrW5Gf8DJlfv+KquZ+GUpeG3dg1zB16zvTWY=;
        b=JV8GhKds71ZFtVyLzl2H1uyE7R25TyNBMut8k1nG+cZceW2JwOkleh7v4z3uXES+fk
         Lrey/dMw5XZzRkXtuOQfRxd+1JPl4gFRJeoz1bl0pVrvLP2MsAdcX3eQvIxD5Ls7ib5J
         DYIvyao6smXjJjXFZcOhrYT66U9t1Bp4yP3MKYxOx0ngQX2F4kU452oAHJ8qPzhieJbX
         3/AAYR+9gepGhZeyjwT7KDOFaFZg2rmtDwl4vmVkbZmNMsEMaDmwougUVvONBnlaO4Zf
         p+/aZyk0PMaCRnsHmXIaACryNz8xVanxulbBay9oGtIM1BjpAFPTudYd1td4R3nJzuMO
         H8QQ==
X-Gm-Message-State: AOAM5305xr59t9J15eT9fYoFVzXrdwJ8+g3odWMrwzhbkyN/neQuh0My
        6RDXLxXMXVBgU7IshseJtqG+Kb7igk+hHQ==
X-Google-Smtp-Source: ABdhPJzPQhsZNAvqPlF3cf7RihR+hJJzn6iTUSxKphaDRW0SDUR1FHp1DQqSM9ckZ6xXySN15vPBgQ==
X-Received: by 2002:a9d:6e5:0:b0:60a:efd6:96b8 with SMTP id 92-20020a9d06e5000000b0060aefd696b8mr1555198otx.11.1653061946398;
        Fri, 20 May 2022 08:52:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h1-20020a056870a3c100b000ee3fdcb51esm1069146oak.8.2022.05.20.08.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 08:52:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e253a579-1388-7c23-6425-13b692815a38@roeck-us.net>
Date:   Fri, 20 May 2022 08:52:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <c15bedc83d90a14fffcd5b1b6bfb32b8a80282c5.1653057096.git.geert@linux-m68k.org>
 <286a1eef-e857-a31f-839b-00a4c835dfa9@roeck-us.net>
 <CAMuHMdX3EYrGPPUEZ3_YPyr6zHnV-xEW3mYB_QyFYaqg_grF-w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] m68k: atari: Make Atari ROM port I/O write macros return
 void
In-Reply-To: <CAMuHMdX3EYrGPPUEZ3_YPyr6zHnV-xEW3mYB_QyFYaqg_grF-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 08:07, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> On Fri, May 20, 2022 at 4:52 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On 5/20/22 07:32, Geert Uytterhoeven wrote:
>>> The macros implementing Atari ROM port I/O writes do not cast away their
>>> output, unlike similar implementations for other I/O buses.
>>> When they are combined using conditional expressions in the definitions of
>>> outb() and friends, this triggers sparse warnings like:
>>>
>>>       drivers/net/appletalk/cops.c:382:17: error: incompatible types in conditional expression (different base types):
>>>       drivers/net/appletalk/cops.c:382:17:    unsigned char
>>>       drivers/net/appletalk/cops.c:382:17:    void
>>>
>>> Fix this by adding casts to "void".
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks!
> 
>>> Removing the casts instead causes issues with functions propagating void
>>> return values (return expression in void function), which BTW sparse
>>> complains about, too.
>>
>> We live and learn. I didn't even know that this was valid syntax.
> 
> I knew about the syntax, but didn't realize immediately why it was
> done that way.
> 
> Initially I thought it was some relic from the "always cast to void
> to make it clear you do not care about the return value"-frenzy, which
> are inside Linux visible mostly in the various "(void)acpi_<foo>(...);"
> calls.  AFAIK these are checked by some external tools.
> In Linux, we have __must_check to annotate the important cases.
> 

I looked at the output of my coccinelle script. To me it looks like
(almost ?) all of the code with "return f(...)" in a function returning
void is just sloppy programming.

In case someone is interested, I attached the script I used below.

Guenter

---
virtual report

@d@
function f;
expression e;
position p;
@@

void f(...)
{
     <...
     return e@p;
     ...>
}

@script:python depends on report@
p << d.p;
f << d.f;
e << d.e;
@@

print "Return in void function %s() at %s:%s: %s" % (f, p[0].file, p[0].line, e)
