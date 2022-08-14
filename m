Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE565926D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 00:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiHNWhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 18:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiHNWhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 18:37:47 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2809710557
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 15:37:46 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 822B45C0073;
        Sun, 14 Aug 2022 18:37:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 14 Aug 2022 18:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660516665; x=1660603065; bh=xJ6w7G33I6
        VM5cOLf6AWuRSuv1Cpbxm/3ROPZ5YR5Yg=; b=AKBiuyLbu4oggdqWWuvFtbeU4y
        nCYUizSkUG0B2LuX/h7+ik/FRuD8fqFJDe5tmUcGG232Usupbu1zLXn2s4G7DRup
        aNidt9UQl+aKq2RD8SBWA0mdUv/UwhkmCep5g7Dq32vH53OeFNbHPMgEWQL9lGh8
        fRpMdOaUTSaW1MgD11n2upccRl9ItKHjZVbgoQvzFPixnGIzWmoYDl5cjIOzvYeH
        zcgQjVhIJKotrxcO2ROAJY3yuAq9icI9Pf5alhTcXXYsSsbUaoZaWrDbnKJzo8ga
        wuoMm9Aqa+u4pKSSWXjX6qZjZqcl5yJy60iTIBTDQvk/oWD8K6myVpLFx5hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660516665; x=1660603065; bh=xJ6w7G33I6VM5cOLf6AWuRSuv1Cp
        bxm/3ROPZ5YR5Yg=; b=4Crkckiyp43eAJKbknScqKv0ezXjgAjzEm/u85xpg+Pk
        LN8xV8/aiqVdlTfB0ZDrWPL+IzJQ90iLSKae0NQGJ+UtIlqN6IsrzXy5aoxLcXsB
        KYdNKv45N5IUJaOHii1IHrgHipxSn8+IBd66m/mAdbUjQR7FSmP9NoOKPhXbXbQF
        J6WLS0rP0tNYkoFf0HzhgOgHVfeasjClLez3+EIxF9+3CbwOh7KAghXubQd00Buy
        a7OHF/4idfbqoHWqWyCe5ZhJ2teiHPUh5Oay5X4BFQwP0qpLkEr+VZG4WiVM6L8+
        eAcbxsbPthz9mQJs2C0bpq9kutd/6TDsMUEbtkcf7g==
X-ME-Sender: <xms:OXn5Ymk1K2o0q_UJjVAl1Ogd1QaPHKfnEZ2RY7biqN45jBhFZzCTPA>
    <xme:OXn5Yt0vJJmrW1RL46gpXTt4ijm3pYfgKwvxqPjOAAh4wk31wKCCgaW1tVUtr_51W
    OsD4hujwQqVd7k5vQ>
X-ME-Received: <xmr:OXn5YkpHhXR1YluADzz9e3ivTRCtW7spfppzRS9cvSL9LlHmilQtxniBZnqFHpbATHaluQ9N4i5LaC4Pa45goRcJ9u2UdRZJlwTS0458isW6HKys3HYKerP9nGcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepudejvddtheeufeejjedvtdfgueehgefhgeefheeghefhgfdvffekkeei
    teeuveevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpkhgvrhhnvghlrdgukhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgv
    shesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:OXn5YqlC54NL7q9SGC_T7yZgdBdv5oukW2R5gEHQFEgaNCWuqFXdBA>
    <xmx:OXn5Yk38ai3pQdDdMh3vfcydwOHBHqEZcfT8LU2djMhwSCAspatueQ>
    <xmx:OXn5Yhs3HVOSscAAckA-av94YhNm3wlzyNT-ckxMYkrRNtSL0U1f7A>
    <xmx:OXn5YiBmalQXOspvGBittpjujXRIvRew_P02Vg4hR8LskN4SxxyORQ>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Aug 2022 18:37:45 -0400 (EDT)
Date:   Sun, 14 Aug 2022 15:37:43 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
Message-ID: <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de>
References: <20220814212610.GA3690074@roeck-us.net>
 <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022-08-14 14:40:25 -0700, Linus Torvalds wrote:
> On Sun, Aug 14, 2022 at 2:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Hi all,
> >
> > syscaller reports lots of crashes with the mainline kernel. The latest
> > I have seen, based on the current ToT, is attached. Backtraces are not
> > always the same, but this one is typical.
> >
> > I have not tried to analyze this further.
>
> This smells like the same issue that Andres Freund reported:
>
>    https://lore.kernel.org/all/20220814043906.xkmhmnp23bqjzz4s@awork3.anarazel.de/
>
> he blamed the virtio changes, mainly based on the upstream merges
> between his bad tree and last good tree, ie
>
>     git log --merges --author=torvalds --oneline 7ebfc85e2cd7..69dac8e431af
>
> and assuming those end-points are accurate, that does seem to be the
> most likely area.

That range had different symptoms, I think (networking not working, but not
oopsing). I hit similar issues when tried to reproduce the issue
interactively, to produce more details, and unwisely did git pull instead of
checking out the precise revision, ending up with aea23e7c464b. That's when
symptoms look similar to the above.  So it'd be 69dac8e431af..aea23e7c464b
that I'd be more suspicious off in the context of this thread.

Which would make me look at the following first:
e140f731f980 Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
abe7a481aac9 Merge tag 'block-6.0-2022-08-12' of git://git.kernel.dk/linux-block
1da8cf961bb1 Merge tag 'io_uring-6.0-2022-08-13' of git://git.kernel.dk/linux-block

But I'm not a kernel developer...


> Andres was going to try to bisect it, but if you have some idea where
> this all started, that would help.

I started, but it's one of those days.

First I got sidetracked first by the interactive "serial console" of google
cloud apparently not working during grub, making it harder to recover from a
bad kernel.

Then by a bug in git bisect. For some reason debian sid's git is stuck at:

clear_distance (list=0x5616f56656a0) at ./bisect.c:71
71	./bisect.c: No such file or directory.
(gdb) bt
#0  clear_distance (list=0x5616f56656a0) at ./bisect.c:71
#1  do_find_bisection (bisect_flags=0, weights=0x561701309e50, nr=1120570, list=<optimized out>) at ./bisect.c:332
#2  find_bisection (commit_list=commit_list@entry=0x7ffe32540d50, reaches=reaches@entry=0x7ffe32540c90, all=all@entry=0x7ffe32540c94,
    bisect_flags=bisect_flags@entry=0) at ./bisect.c:428
#3  0x00005616b63636ae in bisect_next_all (r=<optimized out>, prefix=prefix@entry=0x0) at ./bisect.c:1047
#4  0x00005616b628bad7 in bisect_next (terms=terms@entry=0x7ffe32542720, prefix=prefix@entry=0x0) at builtin/bisect--helper.c:637
#5  0x00005616b628be42 in bisect_auto_next (terms=terms@entry=0x7ffe32542720, prefix=0x0) at builtin/bisect--helper.c:656
#6  0x00005616b628c2c0 in bisect_state (terms=terms@entry=0x7ffe32542720, argv=<optimized out>, argv@entry=0x7ffe32543be0, argc=<optimized out>, argc@entry=2)
    at builtin/bisect--helper.c:971
#7  0x00005616b628cc18 in cmd_bisect__helper (argc=2, argv=0x7ffe32543be0, prefix=<optimized out>) at builtin/bisect--helper.c:1356
#8  0x00005616b627f3aa in run_builtin (argv=0x7ffe32543be0, argc=4, p=0x5616b65b6818 <commands+120>) at ./git.c:466
#9  handle_builtin (argc=4, argv=argv@entry=0x7ffe32543be0) at ./git.c:720
#10 0x00005616b6280662 in run_argv (argv=0x7ffe325438e0, argcp=0x7ffe325438ec) at ./git.c:787
#11 cmd_main (argc=<optimized out>, argc@entry=5, argv=<optimized out>, argv@entry=0x7ffe32543bd8) at ./git.c:920
#12 0x00005616b627f085 in main (argc=5, argv=0x7ffe32543bd8) at ./common-main.c:56

I suspect it's somehow related to starting out with a shallow clone and then
fetching the full history. So my next step is going to be start with a fresh
clone. But it's dinner prep time now, so it'll have to wait a bit.

Greetings,

Andres Freund
