Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C662951FA42
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiEIKss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiEIKsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:48:30 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6E82D5701;
        Mon,  9 May 2022 03:42:34 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id c125so14802290iof.9;
        Mon, 09 May 2022 03:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUbxlyQv9Rnrcr0jkzwd4nmwPYsVNPj/1DE7vk0W4dU=;
        b=mJE0VdjpRsTxZTx6Swa30zi8jr6E8MfARPwt1GzzQ07K9cPVY0gRLQxTuuwhsP+1OE
         Bnk1zeZmKSmjGhp7cHj2GOZb9j/rvF5Q/+W8auc7ldzjnhgL2h/jHQODIpiEFs9qh3tK
         cP/G3iz/dTOjCdbI1hNs+lFx9ZjInX4RX6DFesdvcjvQCAQqRtWV002eNEK5VwMYcgV1
         dc8xIeVBhUia8oQaSzQ1ckle87ZDyhAVdvL6GGKlKZvD2wUBFhIsnVxv6tjm6HgrcPKY
         B2HGCCxzfrZ2HJmqLQsZdrEUm/jtl8bmWhI3NeRiBYEs5djhP3IsVCZshZrE7oLqePbP
         N5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUbxlyQv9Rnrcr0jkzwd4nmwPYsVNPj/1DE7vk0W4dU=;
        b=k9wC5iMbgvkbBkbKRvAphSs+IwTQDYoYT5WNG2lKrJyG6KTZRuAGt29LrxICEzBJT6
         C1k9GAEdnB9HyDca8vFiB1m8dReG4sEaGI3fX0I3BTrja50LmbrF1mqsmeHzY114vSJ5
         Xl3im2aOEo2gJZild6EBkwSAR1cb0pWJREoH+Ud5KI7N5/Im01I8Hnl3N9npqMhkcHsw
         tkX68mwFhyHQ4qebGw/HplNkQCPv7rrWo9ZHYsNXlfGmyCU6syLO9Rphf0R4nz998lht
         xVi/y9evmqQ6tpXnDm2s/tKdjEH5Nzz5jv9mR+k/nJOOY2ZXQyT+L/TmzCf7gBmJIKdc
         qFtg==
X-Gm-Message-State: AOAM533DtQp3K8cGD2jY+bqydX+jSnkW5mRTyGDbizmZdFYrTr++MB/9
        RhpgaZTsCbDTQ/w4gsJIfQ2n7N36D8u1wS9sEdO11YJJ
X-Google-Smtp-Source: ABdhPJxKzpzb9+WG2tCZaHirmDD6/FM40ugx3aBOyzAzMNEUY/Hcd40wj9X4GSSMG5tONefq4BgcVCHeqoCwpvXnjp4=
X-Received: by 2002:a05:6602:2d90:b0:63d:b41e:e4e4 with SMTP id
 k16-20020a0566022d9000b0063db41ee4e4mr6088084iow.172.1652092899514; Mon, 09
 May 2022 03:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-19-ojeda@kernel.org> <7e9c2e77-8b70-6e15-3f3d-905ab42b0fcd@gmail.com>
In-Reply-To: <7e9c2e77-8b70-6e15-3f3d-905ab42b0fcd@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 9 May 2022 12:41:28 +0200
Message-ID: <CANiq72mBVo4+htxVjY0wB1Y3GO2PEUiZjZKRYT8ddwx84-hAtg@mail.gmail.com>
Subject: Re: [PATCH v6 18/23] docs: add Rust documentation
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Wu XiangCheng <bobwxc@email.cn>,
        Jonathan Corbet <corbet@lwn.net>, Daniel Xu <dxu@dxuuu.xyz>,
        Gary Guo <gary@garyguo.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yuki Okushi <jtitor@2k36.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Julian Merkle <me@jvmerkle.de>, Finn Behrens <me@kloenk.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Wei Liu <wei.liu@kernel.org>
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

Hi Akira,

On Mon, May 9, 2022 at 6:02 AM Akira Yokosawa <akiyks@gmail.com> wrote:
>
> I think you agreed splitting SVG part into its own patch with
> a proper copying info, etc.  Let me see...  So, here is the link:

Yes, sorry, will do (in fact, it should have been there in v5 too).

By the way, the Linux SVG logo (used to make the one here) is pending
in the linux-doc ML.

> I might have missed v5 of this patch series.
> That might be because v5's 15/20 was not accepted by linux-doc's
> lore archive (maybe) due to its size despite it had Cc: linux-doc.
> v6's 18/23 was also rejected.

Yes, a few patches get rejected in several lists. We were told this
was fine as long as LKML gets them (the cover letter has the lists in
Cc).

> I have some alternative ideas for table formatting in ReST.

I was following the LLVM one, but it makes sense to use the other ones
where possible. I can send a patch for that one too.

> So here are a couple of alternative ways to represent the table
>
> * ASCII-art format:
> * Literal block format:

Thanks for taking the time to format the examples, it is useful :)

> As you see, those inline-literal markers of ``xxxx``, which are
> distracting when the .rst file is read as plain-text, are not
> necessary in the literal-block approach.  And you can directly

I agree, it can be better (it is one reason I find Markdown a bit more
readable since it uses a single backquote for that instead of two).

> In my opinion, the literal-block approach should be the most
> reasonable choice here. Of course its your call which one
> to choose.

Yeah, that sounds reasonable. I will take a look.

Thanks for the review!

Cheers,
Miguel
