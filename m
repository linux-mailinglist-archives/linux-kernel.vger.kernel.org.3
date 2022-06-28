Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3EF55D8FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242933AbiF1C5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiF1C5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:57:02 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CB8BCB0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:57:01 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id k10so8704129qke.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vSypklzz7sQ15cqD5TowlyIuG5uwkM3pNtpcIbosIO0=;
        b=By9ShoqlGRjvTLMhyFzje4xVZ5MGOzM82m2xhZ8ZXrXBdkYMrkGN/CdphYf983uv31
         76xfUCgrkEt5AqybjOvfTgj4Y9CDTu6bDFQaJCwJTYL4jz2IvbG+4D0XhPoe+qJ4nx60
         1as3xnBspvRlNE3fLIB+qh+doWOvHTG0/MiqkWpCKLJUIcIn9KYgz/rcnqpmhQXdy6fP
         tsqS8mRYEfqTKa8dscwHP9uXO+oKLfGsnGiWmnVfZl4NMd/ynvbg25F8mXWCBXCGOuwh
         /Vb+Moonsjj9s/qxO+8iYL5HMX8O3kzaZxvQygKVR/2iWxbjrZ0DmHGanYga40tWZGn7
         O51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vSypklzz7sQ15cqD5TowlyIuG5uwkM3pNtpcIbosIO0=;
        b=5A+k+Ug1ngJzih+OlmgJmSNzosjBmzIv4ZW2hhHOHMBQPO5WCL1FnTqhCgu1UdfOKn
         Mpg8oQo74QGGT3yBOhw9HAWesCb5Z0e95RT3p4RCmkzJA2W+HzXx+SZIi1f+HK0HWMXl
         drlixW67Gfzbrmy5ODhV2a4MNKcE3s7TX/dNudX68fs3oJp59ZdT2ZOCnKs49aQ1XRkL
         NEPiD7zLyNp1Q3CFxzufG57PYXMWiCC6apOYsikFOOmjnx6pg8kKzTSd4pIA4bHDTY3J
         E8dBjiTssEPAR1n/OIZg7TGD4Hx3R8C1RKd/X+nBkB7env0g00byz0UEuiHWcTB+b5Ql
         dAyQ==
X-Gm-Message-State: AJIora+MBdKM5OjGawZQxZPHQoyuZBHhO53/4tXXGb90EDQ1yKA8KdpJ
        WP8bfK95Way0H24lIYRqgg==
X-Google-Smtp-Source: AGRyM1ubUVsowPjUbNvilznEB1L5LyvNYUjvStiOmcudnPw8WNl3zSlw8UIISp0utPRmWyPQzyps1g==
X-Received: by 2002:a05:620a:2892:b0:6ae:bdfa:1d0e with SMTP id j18-20020a05620a289200b006aebdfa1d0emr10246660qkp.235.1656385020464;
        Mon, 27 Jun 2022 19:57:00 -0700 (PDT)
Received: from [192.168.1.210] (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id bi32-20020a05620a31a000b006af3f3b385csm2148527qkb.98.2022.06.27.19.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 19:56:59 -0700 (PDT)
Message-ID: <ff21e07a-a30f-7516-69fb-c6c559e3c1b4@gmail.com>
Date:   Mon, 27 Jun 2022 22:56:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC[ Alloc in vsprintf
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
 <20220620150514.3tjy5dv7pv5frcwd@moria.home.lan>
 <53d77ae6101a0f24cfb694174d4c7699424c57e8.camel@perches.com>
 <20220621005752.ohiq5besmy3r5rjo@moria.home.lan>
 <a795818f9a49ed401bffc7c38ca7e39ae449e9e0.camel@perches.com>
 <c1a92cf059fc9a3c395d87b11e9f757f5ec1ff6a.camel@perches.com>
 <355e912490dbaef8fe4e12df0201c3f5b439565d.camel@perches.com>
 <CAHk-=whwyxSpzgr+roEr7_V5wVenw9fV3EOAZhAYCAuRdEyChQ@mail.gmail.com>
 <a723f5dda62a4c448dd292a3b917fe6d@AcuMS.aculab.com>
From:   Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <a723f5dda62a4c448dd292a3b917fe6d@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 6/27/22 04:25, David Laight wrote:
> From: Linus Torvalds
>> Sent: 26 June 2022 21:19
> ..
>> That does require teaching the sprint_symbol() functions that they
>> need to take a "length of buffer" and return how much they used, but
>> that would seem to be a sensible thing anyway, and what the code
>> should always have done?
> 
> It needs to return the 'length it would have used'.
> While occasionally useful I'm pretty sure this is actually
> a side effect of the was that libc snprintf() was originally
> implemented (sprintf() had an on-stack FILE).
> 
> In any case it might be simplest to pass all these functions
> the write pointer and buffer limit and have them return the
> new write pointer.
> It is likely to generate much better code that passing
> a structure by reference.

I've said it before, and now I'm going to say it again more forcefully:

This obsession with perfect machine code in every situation, regardless 
of whether it's shown up in benchmarks or profiles, regardless of what 
it does to the readability of the C code that we humans work with, has 
to stop.

Has. To. Stop. Full stop.

We have to be thinking about the people who come after us and have to 
read and maintain this stuff. Linux should still be in use 50, 100 years 
from now, and if it's not it's because we _fucked up_, and in software 
the way you fuck up is by writing code no one can understand - by 
writing code that people become afraid to touch without breaking it.

This happens, routinely, and it's _painful_ when it does.

A big learning experience for me when I was a much younger engineer, 
freshly starting at Google, was working next to a bunch of guys who were 
all chasing and fixing bugs in ext4 - and they weren't exactly enjoying 
it. bcache uncovered one or two of them too, and I got to debug that and 
then had to argue that it wasn't a bug in bcache (we were calling 
bio->bi_endio in process context, which uncovered a locking bug in 
ext4). The codebase had become a mess that they were too scared to 
refactor, in part because there were too many options that were 
impossible to test - my big lesson from that is that the code you're 
scared to refactor, that's the code that needs it the most.

And I could name some very senior kernel people who write code that's 
too brittle in the name of chasing performance - in fact I will name 
one, because I know he won't take it personally: the writeback 
throttling code that Jens wrote was buggy for _ages_ and at least one of 
my users was regularly tripping over it and I couldn't make out what the 
hell that code was trying to do, and not for lack of trying.

Other code nightmares:
  - The old O_DIRECT code, which was a huge performance sink but no one 
could touch it without breaking something (I spent months on a beautiful 
refactoring that cut it in half by LOC and improved performance 
drastically, but I couldn't get it to completely pass xfstests. That 
sucked).
  - The old generic_file_buffered_read(), which was a 250 line monster 
filled with gotos - all in the name of performance, mind you - that 
people barely touched, and when people absolutely had to they'd do so in 
the most minimal way possible that ended up just adding to the mess 
(e.g. the IOCB_NOWAIT changes) - up until I finally cut it apart, then 
curiously right after that a ton more patches landed. It's almost like 
cleaning stuff up and prioritizing readability makes it easier for 
people to work on.
  - merge_bvec_fn was also quite the tale - also done in the name of 
performance, noticing a theme here?

I like to write fast code too. Of course I do, I'm a kernel engineer, I 
wouldn't be a real one if I didn't.

But that means writing code that is _optimizable_, which means writing 
code that's easy to go back and modify and change when profiling 
discovers something. Which means keeping things as simple as is 
reasonably possible, and prioritizing good data types and abstractions 
and structure.

When I'm first writing code and thinking about performance, here's what 
I think about:
  - algorithmic complexity
  - good data structures (vectors instead of lists, where it matters - 
it often doesn't)
  - memory layout: keep pointer indirection at an absolute minimum
    memory layout matters
  - locking

And honestly, not much else. Because on modern machines, with the type 
of code we feed our CPUs running in the kernel, memory layout and 
locking are what matter and not much else. Not shaving every cycle.

I already demonstrated this with actual numbers in the printbuf 
discussion, to Rasmus - yes, the compiler constantly reloading is a 
shame and it shows up in the text size, and perhaps we'll want to 
revisit the -fno-strict-aliasing thing someday (I'm fully in agreement 
with Linus on why he hates strict aliasing, it was something the 
compiler people sprung on everyone else without discussion or a clear 
escape hatch or _tooling to deal with existing codebases_ but the 
tooling has improved since thing, it might not be complete insanity anymore)

...but if you look at the actual microbenchmarks I showed Rasmus? It 
turns out to not affect performance pretty much at all, it's in the 
noise. Waiting on loads from memory is what matters to us, and not much 
else.
