Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E863C4AE06E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384643AbiBHSMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344326AbiBHSMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:12:15 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12320C061576;
        Tue,  8 Feb 2022 10:12:15 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id on2so8728124pjb.4;
        Tue, 08 Feb 2022 10:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQtLM0uGZTqmaNF9UZ+oi/TWbQe36RQ1cY4m3+2cQSI=;
        b=l83IosW3IirO5p1luRL2ZBacfhRFJaHclc9839UiD5gdHqhkE0o4YCrnNlUf2mz+py
         359eQfdM10UZvoUCmhUUyF1FIWixwTBZYnSXIcD3TG3Ool0DjgCIUl/fWHM4RwOkVXEO
         5NJPvhYd1yHPqbVUUGi1wq9mOxim2q7h3wZlxQjw/N6/DeOvU1IUCh0KivytpL/9+ZlF
         fxjXG+tncgN454/dB05R4qL+kQcLcr/89McBCS5ZfY6WgJ/LgfqEwYDsM2/ape66RiPr
         IoIHaImmXyHPypfKbsnlPDAIBGJG51AvsYe73D/Nha9jR/tlpDZQkpIsneWuIOGYBGBn
         oD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQtLM0uGZTqmaNF9UZ+oi/TWbQe36RQ1cY4m3+2cQSI=;
        b=utwnzOoish8MsVdMgdCwXbExyfn0hXi5TovjsCFpsdEYug9oESTTf22yvC2HTXAzwK
         mHHAxOT4fyJpKWlGtYCLITV4TDfFqrlALjfnBHudP7yF70FtdzfxcP5NuKyIuIWy7mj6
         Rw5bCruAdfokB3dlkU7rrmBU55L7VHpyJZt4d1xFU06p4h+h4fzcDeu4CS6voBwYtPIh
         WIwyaLYuBIDed8Iku9v27vsDdph7DeGnF5QcOUUTxpdk/xUEc5tzTUrY3YpHMwWTL+Q0
         9goZG15fW5vWE+rfTfN10BpGHm8XimtXwUaKZOxtS8Chdqh4BPSYE68X2Cc78BFkuNXq
         YZMQ==
X-Gm-Message-State: AOAM5329866QHlaG12dgY+oWkSqSxhJZoWHomIsZflHiPV6gaIb3zaCm
        lX9WFbT7BJKqbuoJx3K4Vi3w20EUzULV3BfjhS8=
X-Google-Smtp-Source: ABdhPJwAWyM84ctSFTYxofbSSB90vGdfJSIohGp7+C5i3KMjS3ib0+jYGeJIKz8+FInmgHdyMM72o/ndnFc3sgomGFo=
X-Received: by 2002:a17:902:9308:: with SMTP id bc8mr5793310plb.147.1644343934227;
 Tue, 08 Feb 2022 10:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20220203060641.119522-1-vimal.agrawal@sophos.com>
 <20220204083933.136096-1-vimal.agrawal@sophos.com> <Yf2fB4mzdLiWtoki@bombadil.infradead.org>
 <CALkUMdRv0tMuLpi3Syw7MndBTa9b0xRLGdb6QvM8Q69zXnmUkw@mail.gmail.com>
 <YgGYL1MKEX9t/ciO@bombadil.infradead.org> <CALkUMdSVV=Vju3TtryObKney7Q1TJLgGd7G7OB4X3FW9eJf4-w@mail.gmail.com>
 <YgKugFcF1kkWPsNa@bombadil.infradead.org>
In-Reply-To: <YgKugFcF1kkWPsNa@bombadil.infradead.org>
From:   Vimal Agrawal <avimalin@gmail.com>
Date:   Tue, 8 Feb 2022 23:42:02 +0530
Message-ID: <CALkUMdQBEWANnNM1UYKcKOmAK=d9Abt1TmgvqNKSKyW9Vqd1JQ@mail.gmail.com>
Subject: Re: [PATCH v5] modules: add heuristic when stripping unneeded symbols
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        nishit.shah@sophos.com, Vimal Agrawal <vimal.agrawal@sophos.com>,
        Dirk VanDerMerwe <Dirk.VanDerMerwe@sophos.com>,
        gregkh@linuxfoundation.org
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

> You are saying that sometimes having "best" evaluated to non zero
> yields incorrect results, where the symbol found is actualy not a .text
> symbol for a text address? If so, is this really true for cases where
> no stripping is used? If so this is bigger news and I'd like to address
> this separately in another commit but we need proof, not just
> speculation.
>
I have not seen this issue without stripping so far as in that case it will find
some better match with some .text address but I have seen this consistently
with stripping.

> And you seem to be suggesting that this seems to hold more true when
> "--strip-unneeded" is used given there are fewer symbols left after
> striping?
>
yes. This is seen with stripping only.

> > without stripping, it will definitely
> > resolve to some .text address closely matching in case of no stripping
>
> OK so there is no issue when stripping is used.
>
yes. I assume you meant when stripping is not used.

> > but it can go wrong with stripping. I have seen it a few times post
> > the first patch during testing.
>
> OK then we need to take care your added heuristics do not affect
> non-stripping.
>
yes. so I tested .init , .text and one data address (without being
stripped) to make
sure there is no affect. Attached the result in my previous mail.

> > best could be incorrect even for text address when --strip-unneeded is used.
> > e.g. in my case, it is resolving .init.text address to __this_module
>
> You should be explicit about this in your commit log.
>
Ok

> When you submit a v2 patch and you change something like that you must
> clarify changes which are not clear either in the commit log or below
> the --- lines after the diffstat and before the actual patch. Each new
> patch iteration should have a set of bullets with all the changes you
> have made so that the maintainer can track what you have done
> differently on each iteration.
>
> Right now you are not making any of this easy on me so I ask that you
> stop submitting new patches willy nilly until we have actualy discussed
> each item, and we decide what to do. I also ask that you keep track of
> each change you are making on each new patch iteration on the patch
> after the --- lines and before the patch, so I can easily tell all the
> changes you have made on each new iteration.
>
Sure. Thanks for educating me.

>   Luis
