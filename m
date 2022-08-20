Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E38259AF02
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 18:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242954AbiHTQWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 12:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHTQWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 12:22:17 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2205049B6E;
        Sat, 20 Aug 2022 09:22:16 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id w28so5293080qtc.7;
        Sat, 20 Aug 2022 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HdF47He1obOe/z7bMXQ34hAtRqKgVWrmpmNXRVq1I2Q=;
        b=lnk0sD/AncNwd1SYmUouALIuAEoEvIHTr0TQVTmUKeZQoyow3fZLEADMSPcp2Xg2TY
         yUEoTwD7Ig6pnmuqszVaavBxf1QbySDwnRqI7TVlU/OwKWjFYz+bQUVLV+AK1WVdC8/8
         8hzzq+HZ1/QQmjiYGjiYjLyia7DPducVEpUBS663yU4KU5LuWdtS0bRywOBnWcRT4OSN
         HihJAr6tRGto0v6085YJAW9ql3BW3HmoOwLT0Qt6jQ7ORmSqacsV7O+WWQhKOd9shR8g
         WTfct6hTPv88t0wCwJIYzNq+0iuVj5Bbkt04GEaMHWuMxciALdhJdQf1kMVv/ZhT9o44
         fvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HdF47He1obOe/z7bMXQ34hAtRqKgVWrmpmNXRVq1I2Q=;
        b=ctbRAmKGDL49II8LvIS0BWuGVvoUye++lOtG926agnh/03liG/NjfbB4k55P6CjZlI
         arYeyfa5G0MRY6xO0E0YOmRtvp0n9kFsHjPQLHscqPhl+ILAq76bVvPy7RIUhs72nbkK
         gvLWGovtpWBp/6veCLFtSGxFw2ui/3ntf2Cp+gQR/ZwuWyggdz6NTdmhJ9mS1Nv22mYJ
         IVPWznTLf3Cj6nthJT37iuDaxqcrQ7bTtZHG8S3Raqb9/L8GASnfTFbg+iseVvb2ezIA
         F6YMuDv8xlNHBxmHMgWElqPru/1FW1V7eMTEgHjQZzUmY3IrjFjUq3oOAU4NrrWJXKjn
         xZxQ==
X-Gm-Message-State: ACgBeo2BD2hP9dGZLjAdkEHOJCZ9vhvYtWs3DusikEaEJ08uSWmIShkU
        vnH75NhKVZ6T9+B3nSZOS+FPK8tq8aptPksipe8=
X-Google-Smtp-Source: AA6agR70Z5H7Vg0+3oP8uKmGUOo8d+x6CNo1WV7ZbQcYwW/pMxZFJoO4OdetZj/DvK19nmoR9yrto/8Cu44BM2alDWY=
X-Received: by 2002:ac8:7dd0:0:b0:344:afc1:b11d with SMTP id
 c16-20020ac87dd0000000b00344afc1b11dmr2057287qte.195.1661012535127; Sat, 20
 Aug 2022 09:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <3fd11489356b1c73a3d7b4bd9dec7e12c9fe8788.1660934107.git.mazziesaccount@gmail.com>
 <CAHp75VePr790pXZ5AiRnrPmxkOgZ3YKRTbABE6dvk+udQYrXGA@mail.gmail.com>
 <795d16f2-4dee-7492-4a87-e928020efebe@fi.rohmeurope.com> <CAHp75VdGhXpD8YgwkVPLCBEMmupBiTDS4FChocJFVo+BBZ-2KA@mail.gmail.com>
 <0823a6e8-b325-78c5-d060-c5f9442e3df8@fi.rohmeurope.com> <CAHp75VdMA5mkxkMrtiRTGn5F-5GWjxKyuD5iBuj3HKWqZZMxkg@mail.gmail.com>
 <cff8d041-f3c4-3faf-85a9-acabe60d2de2@gmail.com>
In-Reply-To: <cff8d041-f3c4-3faf-85a9-acabe60d2de2@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Aug 2022 19:21:39 +0300
Message-ID: <CAHp75VcVziFMbPtKi1FgD1VR42HjeLUJ5fzxYSRqEbfSZ185oQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] iio: bmg160_core: Simplify using devm_regulator_*get_enable()
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 1:05 PM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
> On 8/20/22 10:18, Andy Shevchenko wrote:
> > On Sat, Aug 20, 2022 at 9:48 AM Vaittinen, Matti
> > <Matti.Vaittinen@fi.rohmeurope.com> wrote:
> >> On 8/20/22 09:25, Andy Shevchenko wrote:
> >>> On Sat, Aug 20, 2022 at 9:19 AM Vaittinen, Matti
> >>> <Matti.Vaittinen@fi.rohmeurope.com> wrote:
> >>>> On 8/20/22 02:30, Andy Shevchenko wrote:
> >>>>> On Fri, Aug 19, 2022 at 10:21 PM Matti Vaittinen
> >>>>> <mazziesaccount@gmail.com> wrote:
> >>>
> >>> What did I miss?
> >>
> >>   >>>>           struct bmg160_data *data;
> >>   >>>>           struct iio_dev *indio_dev;
> >>
> >> This does already violate the rule.
> >
> > Indeed, I am reading this with an MTA that has True Type fonts, and I
> > can't see it at the first glance. But this breaks that rule slightly
> > while your added line breaks it significantly.
>
> Yes. As I said, I think the reverse xmas tree rule is not too well
> justified. Bunch of the subsystems do not really follow it, nor did this
> function. Yet, as I said, I can move the array to the first line in the
> function when I respin the series..

You still can do better in _your_ series, right?

> >>>>> this case you even can move it out of the function, so we will see
> >>>>> clearly that this is (not a hidden) global variable.
> >>>>
> >>>> Here I do disagree with you. Moving the array out of the function makes
> >>>> it _much_ less obvious it is not used outside this function. Reason for
> >>>> making is "static const" is to allow the data be placed in read-only
> >>>> area (thanks to Guenter who originally gave me this tip).
>
> Just wanted to correct - it was Sebastian Reichel, not Guenter who
> explained me why doing local static const arrays is better than plain const.

Did he suggest putting it inside the function?

> >>> "static" in C language means two things (that's what come to my mind):
> >>> - for functions this tells that a function is not used outside of the module;
> >>> - for variables that it is a _global_ variable.
> >>>
> >>> Hiding static inside functions is not a good coding practice since it
> >>> hides scope of the variable.
> >>
> >> For const arrays the static in function does make sense. Being able to
> >> place the data in read-only areas do help with the memory on limited
> >> systems.
> >
> > I'm not sure we are on the same page. I do not object to the "const"
> > part and we are _not_ talking about that.
>
> Maybe the explanation by Sebastian here can put us on the same page:
> https://lore.kernel.org/all/20190502073539.GB7864@localhost.localdomain/
> https://lore.kernel.org/all/322fa765ddd72972aba931c706657661ca685afa.camel@fi.rohmeurope.com/

Again, you are too focused on "const", I'm talking about "static". The
above doesn't clear a bit regarding why you hide the global variable
inside a function. I don't see either Sebastian's clear point on this.

> >>> And if you look into the kernel code, I
> >>> believe the use you are proposing is in minority.
> >>
> >> I don't know about the statistics. What I know is that we do have a
> >> technical benefits when we use static const arrays instead of non static
> >> ones in the functions. I do also believe placing the variables in blocks
> >> is a good practice.
> >
> > Yes, and global variables are better to be seen as global variables.
> >
> >> I tend to agree with you that using local, non const statics has
> >> pitfalls - but the pitfalls do not really apply with const ones. You
> >> know the value and have no races. Benefit is that just by seeing that no
> >> pointer is returned you can be sure that no "sane code" uses the data
> >> outside the function it resides.
> >
> > Putting a global variable (const or non-const) to the function will
> > hide its scope and it is prone to getting two variables with the same
> > or very similar names with quite different semantics.
>
> I don't see how moving something from a local block to a global scope
> does make conflicts less of an issue?

You may add a static variable inside each function in the same module
and name it "foo" and there will be no conflict, but when you read the
code your brain will be spoiled. This is simply _bad code practice_. I
don't know how else I can explain this to you.

> On the contrary, it makes things
> worse as then the moved variable will collide with any other variable in
> any of the functions in the whole file. Having the array as function
> local static makes the naming collisions to be issue only if another
> global variable has the same name.

Again, you missed my point. I'm talking about reading and analysing
the code. Otherwise (good) compiler should spill a lot of warnings in
case you have global vs. local naming collision.

> And if that happened - the chances
> are code would still be correct as the function here is clearly intended
> to use the local one. If someone really later adds a global with the
> same name - and uses the global in this function - then he should have
> noted we have local variable with same name. Additionally - such user
> would be using terribly bad name for a global variable.
>
> Please note that scope of the function local static variable is limited
> to function even if the life-time is not just the life-time of a function.

Nope. The RO section might be very well flashed into ROM, so...

> > That's why it's
> > really not good practice. I would rather see it outside of the
> > function _esp_ because it's static const.
>
> Sorry, I really don't agree with your reasoning here. :(

So, whom should we listen to here? Because bad code is bad code. And
this is code above.

-- 
With Best Regards,
Andy Shevchenko
