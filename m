Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1660D51AE7F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377794AbiEDUBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377805AbiEDUBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:01:40 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865724EDC7;
        Wed,  4 May 2022 12:58:03 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id e144so1114737vke.9;
        Wed, 04 May 2022 12:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PP0v6E0J74PSlvWpBHKPKv2X563T4tZp8Opf3sME7AY=;
        b=oxnb5SWdx6otZKup6ob7ZQ7YzSgDp2BKAWcG96ihZJAx8xLXAGpWaAc3r9qU+/9YZc
         wHTVsiAw5efPwu/XvSO1x2/1aq2b27UQsZN9m4bErqnYEKZ9qkQn0P2BwcFZ95t58e9j
         7/XyzLBwYoKjaEIlIs80l0zsTlj/oWVVg6cmIvAXISaK2JCV9YOFlik7mzUqJpUhNtjR
         r9fTWhzJDK184xF9Io+Xoc+9QJ4UGo3OZJGk58Q8/erNhxodCEDQyqQx2voyJcfb0jAi
         BVi+Jm1L7zMyQKDTFzrbqcovgT/kxpyas1j3tGFBX8edgYLiW0HtsmQrZGnV2wyc+N9g
         GeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PP0v6E0J74PSlvWpBHKPKv2X563T4tZp8Opf3sME7AY=;
        b=LUXRLm/I8RONzudQwjBgvG118TOxBpIDqbkIHiVBNvWtyL0oepLyZkjwHI9A6if9To
         XHgfBfnAIb9hywXUuZ/+sToivMwzPpkAVbBXnzSAnCg5BJ9kGo7uLOircRCoTH8lm2+t
         wbi3ApXK7ipB9oCxvrjdmsYUOe9XvGykjB/b4+QTOsTtPvFi3IJXM5lA2ub1WNo33NS2
         I22vnQyP8y2T9Zwb90kcGnV6P46uyQp3roqBXMTEO4hxpeJOK74kDB6mSlM1k8ivYua5
         P8qH7Xs0H+/mASiY3ILu/ZVCsxpZpuMwjDw+CFEmbHvg/mqtCcVulrlRDuljUBCFTVcx
         7q7g==
X-Gm-Message-State: AOAM5324Ca5lcdewW8isgK2ZrDB7uKsIzPqMVt+btX3xV7d9tbQjaS1S
        6TQUC9ArzGxScJm4n4nz7yto+ubeJmTf0iTEUKw=
X-Google-Smtp-Source: ABdhPJwbmiH9S1vCJd8kJ2hr5R+OzZsd7uOkoQGEEn9iSx3iQQUzAZ9TBzrKX7ZkQ6BOrCQZo5vN3Qqq1syke+EiO9c=
X-Received: by 2002:ac5:c856:0:b0:34e:d0b4:7a10 with SMTP id
 g22-20020ac5c856000000b0034ed0b47a10mr5639395vkm.39.1651694282561; Wed, 04
 May 2022 12:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204241648270.17244@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh+Z+OKH3jRttWGHbWSQq2wVMtdnA=ntDiadZu=VxAC7w@mail.gmail.com>
 <alpine.LRH.2.02.2204250723120.26714@file01.intranet.prod.int.rdu2.redhat.com>
 <YnI7hE4cIfjsdKSF@antec> <YnJI4Ru0AlUgrr9C@zx2c4.com> <YnJOCbLtdATzC+jn@zx2c4.com>
 <YnJQXr3igEMTqY3+@smile.fi.intel.com> <YnJSQ3jJyvhmIstD@zx2c4.com>
 <CAHk-=wgb_eBdjM_mzEvXfRG2EhrSK5MHNGyAj7=4vxvN4U9Rug@mail.gmail.com> <CAHmME9q_-nfGxp8_VCqaritm4N8v8g67AzRjXs9du846JhhpoQ@mail.gmail.com>
In-Reply-To: <CAHmME9q_-nfGxp8_VCqaritm4N8v8g67AzRjXs9du846JhhpoQ@mail.gmail.com>
From:   Stafford Horne <shorne@gmail.com>
Date:   Thu, 5 May 2022 04:57:50 +0900
Message-ID: <CAAfxs77yaLvWx9KnkDZX7E1eDm9N-NVJn5n8=mCK9BU-cSob=A@mail.gmail.com>
Subject: Re: [PATCH v2] hex2bin: make the function hex_to_bin constant-time
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Andy Shevchenko <andy@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Snitzer <msnitzer@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Milan Broz <gmazyland@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 4:43 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Linus,
>
> On Wed, May 4, 2022 at 8:00 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, May 4, 2022 at 3:15 AM Jason A. Donenfeld <Jason@zx2c4.com> wro=
te:
> > >
> > > > Alignment? Compiler bug? HW issue?
> > >
> > > Probably one of those, yea. Removing the instruction addresses, the o=
nly
> > > difference between the two compiles is: https://xn--4db.cc/Rrn8usaX/d=
iff#line-440
> >
> > Well, that address doesn't work for me at all. It turns into =D7=90.cc.
> >
> > I'd love to see the compiler problem, since I find those fascinating
> > (mainly because they scare the hell out of me), but those web
> > addresses you use are not working for me.
>
> =D7=90.cc is correct. If you can't load it, your browser or something in
> your stack is broken. Choosing a non-ASCII domain like that clearly a
> bad decision because people with broken stacks can't load it? Yea,
> maybe. But maybe it's like the arch/alpha/ reordering of dependent
> loads applied to the web... A bit of stretch.

I have uploaded a diff I created here:
  https://gist.github.com/54334556f2907104cd12374872a0597c

It shows the same output.

> > It most definitely looks like an OpenRISC compiler bug - that code
> > doesn't look like it does anything remotely undefined (and with the
> > "unsigned char", nothing implementation-defined either).
>
> I'm not so certain it's in the compiler anymore, actually. The bug
> exhibits itself even when that code isn't actually called. Adding nops
> to unrelated code also makes the problem go away. And removing these
> nops [1] makes the problem go away too. So maybe it's looking more
> like a linker bug (or linker script bug) related to alignment. Or
> whatever is jumping between contexts in the preemption code and
> restoring registers and such is assuming certain things about code
> layout that doesn't always hold. More fiddling is necessary still.

Bisecting definitely came to this patch which is strange. Then reverting
e5be15767e7e ("hex2bin: make the function hex_to_bin constant-time")
did also fix the problem for me.

But it could be any small patch that changes layout could make this go away=
.

I have things to try:
  - more close look at the produced asembly diff
  - newer compiler (I fixed a few bugs in gcc 12 for openrisc, and
this testing came up in gcc 11)
  - trying on FPGA's

I'll report as I find things.

-Stafford
