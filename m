Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A357259B3DA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 15:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiHUNNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 09:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiHUNNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 09:13:50 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3E013D79;
        Sun, 21 Aug 2022 06:13:48 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id e4so6420577qvr.2;
        Sun, 21 Aug 2022 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DVYYQkpgpKgJVH0pRzj4zMYMOUP7iF2KNFjCHXK79jQ=;
        b=pfmYWrgef2IB19viXabZpI/iK2diGQH8ZUwCTEzKcjpWGCuNHCeQ33tnF13l21WtON
         2WnfUXgmF77GjBKWs8EhZ84XCGr4OxqWha7NixDGnE8FN/6eRrBOFVU67hZvR5GSwgPP
         B2ceSvYLspYQNin8H/oo/2ncei6B4i/FRTKlR90bpyUtDlekzobogewHVEJBb1eHjsUr
         Q6zaYQP5BxI8q20dDCRuu+QIbr3+cRbITz5nX6mF5jRFDJEEhHOJLpEPNrBRrqjgUxQ8
         ZNq1e2/dzXVESPmZmh8P5vlFwqfmZaCEL297rGptIwiq9+pBDPDpdz4JcVQMYa++8c0K
         lmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DVYYQkpgpKgJVH0pRzj4zMYMOUP7iF2KNFjCHXK79jQ=;
        b=EeXCblkVxfKuxY4KSF5qPzWGBuvOn2zLBpa5JABeBcuQYZPfziPI6epp3xhaHouf/n
         dE2NC56wc/kUTe5BF2kaW0gGixXqavMlpkcWHcQgnhkvE+IxZfkmI+RYDXyAzKIg3d2x
         pewef0qeahhX6daVW5rgQNBA0bj2/DEVxmjEAQ+nWbc5iaeDXH4nvLWehAGRRkogz/83
         hnDlMyyO97W9MW99D4VB1i7lRE77cc4zDvDHQP5Gk+N5gpQWplmSTGadrmEYH7QLhrXt
         zbYNKqnqOwOWc4QFOu7TWvjgv0da/I2jyRpljicQyuWNbIWEStk1/FBTGTDKTJlrVlzV
         Lw1g==
X-Gm-Message-State: ACgBeo3H3KZHcT4e3ppO1QN/6YUQa/JYnB1CdvOM8CzHKrzz3XB0jIV5
        P9rwr/y9kUFcRVMNJCfEHz+Ka2WT7cYvfPjvuKY=
X-Google-Smtp-Source: AA6agR7RhA4NMn9ulbUAoaHTX1CvY477ewKXaIAGD/vR00gR46ZMbn4dwx0XQ1Ro2eKM0wKxjoVzOvB5nEm08WaBQSA=
X-Received: by 2002:ad4:5baf:0:b0:476:6a9e:b5e1 with SMTP id
 15-20020ad45baf000000b004766a9eb5e1mr12286096qvq.64.1661087627560; Sun, 21
 Aug 2022 06:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <a29493f594c84b3bd852e462bbd3e591a8575a27.1660934107.git.mazziesaccount@gmail.com>
 <20220820122120.57dddcab@jic23-huawei> <412c5d22-d59b-9191-80dd-e3ca11360bc4@gmail.com>
 <CAHp75VdoKtc2QqFcDuJ00KBz6mjg0fnM_WhyVqhCmDVo_3K6kg@mail.gmail.com>
 <01fec744-f3d4-b633-d3ce-bcd86a153132@gmail.com> <CAHp75Vd3vyAZbWpZT9SmyD=ecGTAdVNWK=fs_n4OSAqGtGj_gg@mail.gmail.com>
 <103abfae-6c0d-9a2e-2d59-0da4c8be3eb4@gmail.com>
In-Reply-To: <103abfae-6c0d-9a2e-2d59-0da4c8be3eb4@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 21 Aug 2022 16:13:11 +0300
Message-ID: <CAHp75VchPCHsBcx7mMoGUjz=s4hmfnO6t7DqtpWfg=aGrbo1Fg@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] iio: ltc2688: Simplify using devm_regulator_*get_enable()
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
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

On Sat, Aug 20, 2022 at 10:00 PM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
> On 8/20/22 20:41, Andy Shevchenko wrote:
> > On Sat, Aug 20, 2022 at 8:30 PM Matti Vaittinen
> > <mazziesaccount@gmail.com> wrote:
> >> On 8/20/22 19:09, Andy Shevchenko wrote:
> >>> On Sat, Aug 20, 2022 at 4:45 PM Matti Vaittinen
> >>> <mazziesaccount@gmail.com> wrote:
> >>>> On 8/20/22 14:21, Jonathan Cameron wrote:
> >>>>> On Fri, 19 Aug 2022 22:19:17 +0300
> >>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >
> > ...
> >
> >>>>> For the whole static / vs non static. My personal preference is not
> >>>>> to have the static marking but I don't care that much.
> >>>>
> >>>> I'd like to stick with the static here. I know this one particular array
> >>>> does not have much of a footprint - but I'd like to encourage the habit
> >>>> of considering the memory usage. This discussion serves as an example of
> >>>> how unknown the impact of making const data static is. I didn't know
> >>>> this myself until Sebastian educated me :)  Hence my strong preference
> >>>> on keeping this 'static' as an example for others who are as ignorant as
> >>>> I were ;) After all, having const data arrays static is quite an easy
> >>>> way of improving things - and it really does matter when there is many
> >>>> of arrays - or when they contain large data.
> >>>
> >>> But still the same comment about global scope of the variable is applied.
> >>
> >> I don't understand why you keep claiming the variable is global when it
> >> is not?
> >
> > It is. The static keyword makes it global, but putting the entire
> > definition into the function is asking for troubles.

> Please, describe the trouble we can get with a local static const
> variable? A real concrete threat there is. I have explained the benefit.
> I have also explained the concrete possibility of name collision when we
> really do a global out of local.

I told you, the benefit is not to play dirty tricks on developers,
maintainers and reviewers. It's simply harder to read the code and get
the usage of the variable that lifetime is out of scope of the
function.

> > I guess some C standard chapter describes that in non-understandable language.
> >
> >>> As I explained before, hiding global variables inside a function is a
> >>> bad code practice.
> >>
> >> I don't really get what you mean here. And I definitely don't see any
> >> improvement if we would really use a global variable instead of a local one.
> >
> > The improvement is avoid hiding the global variable to the local namespace.
>
> I guess you mean that you may miss the fact that a variable stays there
> even after execution exits the function, right? Ok, let's assume someone
> misses this point when reading the code. Now, please describe me the
> potential issues this can cause knowing our static is const and doesn't
> change the value.

When you hide the static variable inside the function, you simply
narrow visibility to the compiler, but the variable stays all the time
the module is in.

-- 
With Best Regards,
Andy Shevchenko
