Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC97C5821BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiG0IFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiG0IFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:05:35 -0400
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9FBDFCF;
        Wed, 27 Jul 2022 01:05:33 -0700 (PDT)
Received: from [10.2.12.24] (unknown [10.2.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id A6319185A249;
        Wed, 27 Jul 2022 10:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1658909131; bh=vWWwngdIeafeNuKPj4NmPnUKMGjnhw3F41ZrxQKTl4c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MN+4/W3g0i9UELUIqhWTuK9tfsosfhq0gp4jZJr2hR7QE6k+haCkPKwHgLwWUiUkw
         AEeY0s+V0rQXdPRfUlGWwqQX6ncgMkgZoDc+NO9+HQQPuQ2JPTHlnT9TiK/OTCrup0
         SuyrX3KmrDth5PH4Nip2XsoaevocUC5QCsoCAAps=
Message-ID: <5c0bb1db-5589-32ca-ac22-4aafb3c15751@schinagl.nl>
Date:   Wed, 27 Jul 2022 10:05:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/13] [RFC] Rust support
Content-Language: nl
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210414184604.23473-1-ojeda@kernel.org>
 <fae4873e-2ff9-df35-0ab9-34bf4417b717@schinagl.nl>
 <CANiq72mRxM-7griYF+0FWqYoSoNL8ad=L-i6a2-GsaCeb0C6qQ@mail.gmail.com>
 <ba8cb315-9d73-2f45-8bf9-d9473d369dca@schinagl.nl>
 <CANiq72kz+Txauo+103_-fN_J8PhhCdJUH5XepShUQmJzW6a4tA@mail.gmail.com>
From:   Olliver Schinagl <oliver+list@schinagl.nl>
In-Reply-To: <CANiq72kz+Txauo+103_-fN_J8PhhCdJUH5XepShUQmJzW6a4tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Miguel,

Just to make it very clear from the beginning, while this is a sensitive 
subject, and I am very passionate about it; In no way, I am being 
offensive, insulting or rude. This would be obvious in a f2f discussion 
of course, but alas. I do try to format my text as friendly as I can, 
but some things get lost in translation ;)

On 20-07-2022 21:23, Miguel Ojeda wrote:
> On Mon, Jul 18, 2022 at 8:56 AM Olliver Schinagl
> <oliver+list@schinagl.nl> wrote:
>>
>> Absolutly, but with the many luitenants, many tree's, and not a single
>> CI source, this would still be tricky in the end; but certainly possible.
> 
> A bot in -next (possibly an existing one) is a single thing to care
> about and the amount of maintainers/trees doesn't have an effect on
> it, thus I don't think it would be tricky.
> 
>> I think this is a pretty poor argument for following Rust's opinionated
>> view of the world. E.g. it's generally bad to copy/paste code to begin
>> with. How many 'bugs' that we know of are copy/paste bugs?
> 
> We will have to disagree. Consistency and simplicity are fine
> arguments in my book, not "pretty poor" ones.
Consitency is absolutly important! Zero argument there. My argument is, 
the consistency should be within the kernel tree, not 'but the rest of 
the world is using style X/Y/Z, lets be consistent with that. In an 
utopia, maybe, but the real world doesn't work that way, sadly. So in an 
attempt to standardize (rustfmt) they just "invented" a new standard. 
Which btw is common, we see this happening every so often, right?

> 
> I don't see the relevance of the copy/paste code discussion here. But
> assuming the analogy makes sense, I don't agree that reusing code is
> "generally bad" either.
Copy/pasting is known to cause bugs. There's actually research from NASA 
on that. Code-reuse (libraries/functions) are not bad. But (worst kind 
of example) copy paste from stack-overflow, or copy/pasting stuff 
without actually looking at the content and forgetting to rename 
something, causes bugs. Why is this relevant? The whole 'lets be 
consistent with the rust codebase of the wrold' argument. E.g. if 
everybody uses the same style (which is idealistic and great) then 
copy/pasting becomes consistent. Where I say, try to be careful when 
copy/pasting code.

> 
> Anyway, given you mention "bugs", I think you are implying that the
> defaults are somehow "incorrect" (not accessible?). In that case, to
> improve things for all Rust developers out there, I would suggest
> opening an issue in https://github.com/rust-dev-tools/fmt-rfcs.
There have been, I've linked them in my first post; the devs basically 
say 'you are right, we are sorry; but this discussion is over' which 
reads as 'we love our style, we think its great, we're not changing it 
for people with reading-disabilitles, figure it out' (yes, I paraphrase 
it much harsher then what they state, but like with people in 
wheelchairs that run into a small staircase (1 or 2 treads), and then 
are being told, sorry, it is what it is, we can't fix this, it's been 
like this for years, it is what it is)

> 
>> Secondly, and more importantly so; you argue 'who cares about people
>> with disablements, atleast its equally hard to read everywhere' which is
>> a very poor argument :p
> 
> No, and I want to be __very__ clear about this: at no point I have
> argued "who cares about people with disabilities" or anything like it.
> It is insulting that you even suggest it.
I appose for feeling insulted, that was surely not my intend! What I am 
stating however is, that by stating 'but rustfmt is great, their 
standard is consistent and simple and amazing', the message implies 
(nofi!) that reading disabilities do not matter, because this new 
standard is so great.

> 
> Likewise, you are the one claiming it is "hard to read", not me.
Yes, as I do suffer from a reading disability, so I know how hard this 
is :) but fear not, I'm not alone, just vocal.

> 
> And then after constructing those straw men, you call them "a very
> poor argument"...
Obviously I do not intend to cunstruct straw-men, as to me, this is all 
very real and painful :)

> 
>> Finally, it must of course be mentioned, that rust is really trying to
>> do an XKCD here, https://xkcd.com/927/ though I'm sure we'll get it
>> right this time around ;)
> 
> How does that even apply here? There is no "standard" for formatting
> across languages, if that is what you are saying.
I'm not, I'm saying 'every language has its own standard(s), lets make 
one that is better then the others'. So instead of rust for example 
following the linux kernel standard (or the Go coding standard, or 
X/Y/Z), they came up with their own. Not bad, but as mentioned earlier, 
requires careful thinking. But it is of course their choice!

> 
> Actually, what is happening here is that there is an "official" tool,
> called rustfmt, that most Rust code out there uses.
> 
> By not using it, it is you the one that may be creating a XKCD
> situation, if anything.
No, do use it! rustfmt is pretty amazing. And rustfmt knows there's not 
a single answer on coding style, so the rustfmt tool, is super 
configurable trying to match any code-base needs, without forcing 
anybodies style. It is actually like you say, below, the defauflts that 
come from the rust group itself.

> 
> And to be clear, we don't necessarily follow "Rust's biased view". For
> instance, there is also an "official" build tool, called Cargo, that
> most Rust code out there uses; yet we are not using it for the kernel.
I'd prefer if we keep it to style and readability (rustfmt) :p as cargo 
is more a technical direction, and not relevant; but point noted.

> 
> We are actually doing things how we think are best for the kernel. Not
> because "Rust" (whatever or whoever that is) is "trying to do an
> XKCD". Not because we are "following Rust's opinionated view of the
> world" or "Rust's biased view".
But if that is the case, why not try to follow the kernels existing 
code-style as close as possible with the rust-fmt configuration? I know 
code-style has been discussed a few times over the decades; but not many 
changes have been done, surely, if there's some codestyle changes that 
are best for the kernel, they would have been 'advised'? '4 space 
indents are better then 8-size tabs, on new code, try to use them' for 
example :p

> 
>> But you are not, only those that follow rust's biased view. Everybody
>> else that has a different opinion (like die-hard C programmers) that
>> care enough (I'm sure there's plenty) would setup their rustfmt config
>> file to resemble their C code; and thus the entire premisis is broken.
>> Though; yes, in a perfect world it could have worked like this, but xkcd
>> again :)
> 
> No. I said we are being consistent with the majority of the Rust code
> out there, not with "everybody".
But why? Why should we not be consistent with the kernels' code-base 
(while yes, that is not rust, but C, but we can follow the same style?)

> 
> If, instead, we try to be consistent with the kernel C style, then you
> are likely not being consistent with the majority of the Rust code out
> there. And you would have to decide exactly how to map the C style to
> Rust constructs and which particular kernel style.
But is this a bad thing? Being consistent within the kernel repo? Who 
cares what the rest of the ruts code does? I know it matters for 
user-space; but I know that my user-space rust code (be it linux, or 
micro) actually follows the kernel style, not the rust style :p becaues 
of my disability, the rust format is not easy to read/parse in my head 
due to small inconsistencies.

> 
> Again: I personally don't mind what the particular style is. As a
> project, what we value the most is having a single style across it and
> not having to think about formatting. Nevertheless, I think there is
> also value in being consistent with the majority of the Rust code out
> there.
So I fully agree with the first part; but not with the last part :p As 
the rust code style, is poor on readability for people with 
reading-disabilities.


> 
>> This though is a fair argument I understand, it would be weird in having
>> 2 styles in user-space and kernel-space code; though I see this
>> happening today as well; where developers follow kernel style for kernel
>> code (obviously) but use their preferred 2 or 3 space style on their
>> userland code. Trying to 'force' this, usually however never gets the
>> intended result ...
> 
> If we follow the usual Rust style in the kernel, I would say it is
> more likely that both styles match.
That is of course the downside, that if user-space is writing their own 
code in their own style, it will either be rust-style, or something 
completly different, we have no control of this anyway; but having it 
'match' is 'nice' from a consistency pov;

Sadly, I've seen so much vendor code (yeah, I know) which doesn't even 
have consistency in their own files ...

> Cheers,
> Miguel

