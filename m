Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B55584720
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiG1Unc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1Una (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:43:30 -0400
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61016BD74;
        Thu, 28 Jul 2022 13:43:28 -0700 (PDT)
Received: from [10.2.12.24] (unknown [10.2.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id B88AF185B6D2;
        Thu, 28 Jul 2022 22:43:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1659041006; bh=qJaWk8qC2P2wd1+jPTHWOuz/2sxRSrXZLFhJIMpTHm4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EroUtAL77q6ozM32v6QihqjYwnlGD/YWR3ydh2DoDZb6khRDKrt8oR/70Dax/B6h4
         MnAp2seHAt+egV3r9YtsQWz0XrsEmbgwgr3sUXV1gYzo7va2AFlg8e4aYx47gBqAUs
         JxxGKSaLyNNZ33UBE3epA+HUcsfYCDSjx4porpds=
Message-ID: <a4803f2e-2e46-1c7d-0e89-96f5cbb0ad11@schinagl.nl>
Date:   Thu, 28 Jul 2022 22:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/13] [RFC] Rust support
Content-Language: nl
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
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
 <5c0bb1db-5589-32ca-ac22-4aafb3c15751@schinagl.nl>
 <20220728112114.0000003a@garyguo.net>
From:   Olliver Schinagl <oliver+list@schinagl.nl>
In-Reply-To: <20220728112114.0000003a@garyguo.net>
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

Hey Gary,

On 28-07-2022 12:21, Gary Guo wrote:
> Hi Olliver,
> 
> On Wed, 27 Jul 2022 10:05:31 +0200
> Olliver Schinagl <oliver+list@schinagl.nl> wrote:
> 
>> Consitency is absolutly important! Zero argument there. My argument
>> is, the consistency should be within the kernel tree, not 'but the
>> rest of the world is using style X/Y/Z, lets be consistent with that.
>> In an utopia, maybe, but the real world doesn't work that way, sadly.
>> So in an attempt to standardize (rustfmt) they just "invented" a new
>> standard. Which btw is common, we see this happening every so often,
>> right?
> 
> Difference languages have different characteristics and I don't think
> it's necessarily good (and often isn't) to blindly apply coding style
> of one language onto another. So I don't see rustfmt as "inventing yet
> another standard" really, because there aren't many conflicting coding
> style standards in Rust world; almost everyone just settled on using
> rustfmt, mostly using the default, maybe with a few small
> project-specific configuration tweaks.
I was mostly arguing about a) lets look at this and b) having said 
configuration tweaks, rather then blindly (pun not really intended) 
going with rust's defaults :)

> 
> A small example for C and Rust differences:
> 
> Rust requires braces around branches of if expression, and C doesn't.
> So in kernel coding style you often have:
> 
> 	if (condition) do_something();
> 
> Or
> 
> 	if (condition)
> 		do_something();
> 
> But in Rust it will be:
> 
> 	if condition {
> 	    do_something();
> 	}
So kernel style kind of says 'no braces around single statements'; but 
if your rust compiler doesn't allow this; well then there's nothing to 
do. You could even argue to update the kernel C style on this to make it 
consistent again. BUT, this inconsistency makes it cognative 'hard'. If 
this if a C or a rust function? for example during a review. During 
authoring, when writing both C and rust code (due to nececity, not 
constant context switching) you cognitivly constantly have to go 
back/foward. While I'm sure there's people here that can do this all day 
without problem, some of of find this harder then needs to be. Hence the 
request to _try_ to keep consistency within the kernel tree.

> 
> That's just an example of one control flow constructions. There are
> differences between Rust match and C switch, etc. Rust's official
> coding style takes properties of Rust into consideration, so in many
> regards it's a more suitable coding style for Rust code in kernel, then
> applying kernel's C coding standard directly on kernel's Rust code.
> 
> Your earlier email in the thread also mentions about indentation, and I
> have a few things to point out as well.
> 
> First, Rust code typically requires more levels of indentation than C
> code. For example, many functions might be methods and they are inside
> an impl block, which creates one extra level of indentation.
> Statements inside match arms' block are two levels more indented than
> the match statement itself, as opposed to C's switch (as kernel coding
> style doesn't indent the case labels). As a result, 8 spaces for 1 level
> can be a bit excessive for Rust code, and thus the 4 space indentation
> used in rustfmt default.
> 
> Secondly, I don't think the argument about tabs being customisable
> holds; in kernel coding style tabs are strictly 8 characters. For line
Sure, this rule implies that for alignment, tabs should be set to 8 so 
things align nicely. However, nobody forces people to set their editor 
to 8 character width. Not doing so, doesn't break anything. At worst, 
you may commit something that is poorly aligned (but we _should_ be 
using tabs to indent, spaces to align anyway :p, tab == indent has meaning).

With non-tab indentation, this is no longer really possible, or at 
least, editors haven't solved that problem yet, as it tends to still 
break (due to the mixing of indentation and alignment using a single 
character). Maybe once we have AI and ML in our editors though :p

> continuation it's not uncommon to use a series of tabs followed by a
> few spaces, e.g.
> 
> 	int function_name(int first_argument,
> 	< tab  >< tab  >..int second_argument)
> 
> changing tab into 4 spaces will break the layout. (and I'll not go into
> well-known reasons about non-4-space-tab messing up code in terminal
> etc).
> 
>> Copy/pasting is known to cause bugs. There's actually research from
>> NASA on that. Code-reuse (libraries/functions) are not bad. But
>> (worst kind of example) copy paste from stack-overflow, or
>> copy/pasting stuff without actually looking at the content and
>> forgetting to rename something, causes bugs. Why is this relevant?
>> The whole 'lets be consistent with the rust codebase of the wrold'
>> argument. E.g. if everybody uses the same style (which is idealistic
>> and great) then copy/pasting becomes consistent. Where I say, try to
>> be careful when copy/pasting code.
> 
> When we vendor in code as a whole (e.g. like we currently do for
> alloc crate), it is proper code reuse. With different coding style the
> vendored code either diverges from upstream (which makes upstreaming
> much more difficult) or diverge from rest of kernel's Rust code base.
Very fair point of course. Though really, we should fix the upstream 
rust preferred format, but there it was already stated, that 'too bad, 
sorry' which from a developer point of view is fine, your project, your 
choice. From a disabilities point of view, sucks of course.

> 
>> But if that is the case, why not try to follow the kernels existing
>> code-style as close as possible with the rust-fmt configuration? I
>> know code-style has been discussed a few times over the decades; but
>> not many changes have been done, surely, if there's some codestyle
>> changes that are best for the kernel, they would have been 'advised'?
>> '4 space indents are better then 8-size tabs, on new code, try to use
>> them' for example :p
> 
> You do realize that you are creating a new coding style by doing this,
> right? It feels like creating problems rather than solving problems.
> 
> My personal feeling is that it's easier for me to adapt to different
> coding style when switching between languages, but it's rather awkward
> for me when trying to use different coding styles with the same
> language. I find myself no problem switching between 2 spaces when
> coding JavaScript to 4 spaces when coding Rust to 8 spaces(tab) when
> coding C, but it's rather painful to switch between C projects with
> different coding styles. I certainly don't want to switch between Rust
> projects with vastly different coding styles.
And I'm happy for you that you can easily take in 2 and 4 spaces. For 
me, it is extremly hard to read. So it's not a 'personal preference' 
thing. But I suggest to read the earlier posted links, where others at 
length explain it as well, how it is like to feel excluded becaues its 
just hard to read.

> 
>> But why? Why should we not be consistent with the kernels' code-base
>> (while yes, that is not rust, but C, but we can follow the same
>> style?)
> 
> Difference languages have different characteristics, and one size
> doesn't fit them all :)
I'm not even arguing this at all :)

I think the biggest issues i'm speaking of really are the braces and the 
spaces really, where the braces can be argued for/against, it's 
cognitive harder, but can be dealth with (and we can expect 
inconsitencies; but the sapces vs tabs thing, personal configuration vs 
forced with is the point I was trying to raise.

As said before, 'every building is different, some offer wheelchair 
ramps, others do' kind of point, not like 'this building is red, and 
that one is blue, and not every color fits all :p

> 
>> Sadly, I've seen so much vendor code (yeah, I know) which doesn't
>> even have consistency in their own files ...
> 
> That's very true. So when all other Rust code currently follow
> (roughly) the same coding style and this situation doesn't currently
> exist, let's not make it worse...
> 
> Best,
> Gary

