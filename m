Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8F65234AA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244158AbiEKNuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244138AbiEKNuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:50:05 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2B6239782;
        Wed, 11 May 2022 06:50:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id s23so2072854iog.13;
        Wed, 11 May 2022 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPfAjhXsI/sCAXElGiIAWLNhfWDNEi+ZtaHTtSxHBEQ=;
        b=aGnZg3AT2GqkRlrytHTaN/NZj7se3UweBltQbTucUz8qfefhYRjX8D58C1r2q954R4
         6DJFBBvHMc/JilfjHyQ5aqY01UN/ab0jVIyzAY5dvdvZIeqaRUit6kQHk967vXUAo93I
         pB8FjpEP39N8d0YPKBUtmkAzGQERpADWAWEHzgZkXpmv8coKTSst29t7IYGwSgZONziv
         oI4+fIjhM3bVr2+UA+VQvZRxk3miTrNxlZjLwaex+qmsOl01vetgxC5dI5YMOWpvQjc3
         XxgpabVXskv3rcn9yXJv3653A48xMi9ZFSBhEqXtI3PP5+XcVG1qaW97tIAzZBRusZCS
         SidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPfAjhXsI/sCAXElGiIAWLNhfWDNEi+ZtaHTtSxHBEQ=;
        b=Nb95y87xAS8rQvsrczlKK9ref94YMGImjeT860oZAusxTWJZCeC/7LKrvIBdnRAgku
         +OBgPVBg8X189lH5+5WI1cKzBXyE+TBQPAoUOhCDSXsQmNcCs9zf7tIJe/5mORktkyVy
         9ZDSIEgk5bqc7XZVIrl7bK151Wvq5L0h+98iMgpZ9uBaltOKmZYvlHenrH048G0193TM
         qK9r4QsWMcjLxLcHQjA/SCxvNuLzScZFO1IkEQ+NCCqzuHXt2J1w6K/Cy+mSoroajxWm
         QqWsgVzmAulJ73LVaH8X2ow6QgVi0VxzJr3doOEfE+k7pX4Z+e3svLSAOhAAABcMmuaV
         97DA==
X-Gm-Message-State: AOAM5302gSaDbJjhrWq6yyXyegCrGL26Wa3fQxMRaJ6n/sWw05ltk8w3
        1zL5kd3TsWfGU0aTrFBe1M3c5JdzwmSEicY6Fio=
X-Google-Smtp-Source: ABdhPJzjJIGp9s2bo97C4Z9816iV19iujbsRA1+GTtjaKDQ3YsQlDo9tdjEGYQ/NX+clvDAPgUUNuHpBQl2DPlIGM9A=
X-Received: by 2002:a02:8624:0:b0:32b:397d:eeb1 with SMTP id
 e33-20020a028624000000b0032b397deeb1mr12780202jai.264.1652277001693; Wed, 11
 May 2022 06:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-1-ojeda@kernel.org> <20220507052451.12890-19-ojeda@kernel.org>
 <875ymecp6f.fsf@meer.lwn.net>
In-Reply-To: <875ymecp6f.fsf@meer.lwn.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 11 May 2022 15:49:50 +0200
Message-ID: <CANiq72mpYjdhq6yZFBmy8zEo7Cjhh-WjOFc4TfKMZh+w4Fu5WA@mail.gmail.com>
Subject: Re: [PATCH v6 18/23] docs: add Rust documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wu XiangCheng <bobwxc@email.cn>, Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Yuki Okushi <jtitor@2k36.org>, Wei Liu <wei.liu@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, Julian Merkle <me@jvmerkle.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
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

On Tue, May 10, 2022 at 12:32 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Trying to take a closer look this time...
>
> I foresee merge conflicts, but so it goes.  Trying to split this apart
> would not make a lot of sense.

Is there a big change coming to docs? (there are not conflicts in
linux-next within the docs). Or what do you mean?

> Please use normal tables rather than list-table; this kind of thing is
> really unreadable in the source form.

Will do!

> I foresee disagreements over coding style conventions in the
> future... I don't plan to be part of that conversation :)

Do you mean with the tool settings? I guess we may get some proposals
about tweaking them, yeah, but one reason to stick to the defaults is
to avoid that! :)

If you mean enforcing `rustfmt`, please see below.

> I will ask whether we want this, though.  Why would anybody want to
> mass-reformat the entire body of kernel code?  This seems like something
> that would generate an endless stream of "helpful" patches and a lot of
> churn.

So the idea is that, since everything is already formatted, the output
of this is empty (in mainline), like Gaelan/Josh mentioned. Thus
nobody should be sending any formatting patches since there is nothing
to change.

Now, for those developing and not running `rustfmt` automatically in
some way (e.g. in their editors), it can be useful to run it before
submitting the patches: the output should only show changes to
whatever you changed since everything else should be already
formatted.

Of course, as soon as others start submitting patches independently,
mistakes may slip through, but we are enforcing this in our CI (and it
could be done more centrally), so we should notice quickly.

There could be, of course, bugs in the tool; and there are a few
situations where the tool may not guarantee formatting stability, but
hopefully those are rare and small enough so that we can keep
enforcing this. I think it is worth trying.

Cheers,
Miguel
