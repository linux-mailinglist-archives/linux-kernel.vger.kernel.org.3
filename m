Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEB25733C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbiGMKH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbiGMKHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:07:09 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D480DFA1DA;
        Wed, 13 Jul 2022 03:07:02 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31cf1adbf92so107353457b3.4;
        Wed, 13 Jul 2022 03:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Skl3AJqxVqBRBtNdQLqw384nQnqBsdrM8rXpTLPVNPk=;
        b=Jv4eQ+8cc20+aUJs8W3OaHqJZXGCnh+zd0IRmmbnlMu4rMMcr8dbFqDU0pniKyUowb
         QO8QHTNS7xEat/gKTTmSGb4OGLLNLWS822FH5NHN+7dXY6muB+7kCEHrTyOFD2N0QJ8q
         E1RqyCMDi8ARZ4E42bhmpXRVHjwIhIKbm0cvIcfxDirP5usJrbwVNFEIKKRdtAusTGr8
         B31k4jjwLrdu3Duy7WmcZO61iA39Krb8brGBJSn+p0FbFL/np+iulZwW6D3eEcMqwj0b
         z5WxHaZZmWVXqXqnBLPNvBUr9pnzQeUnOpLGkCwBr73pQWOo1wNDNW0DIIDtq6ShF9Qe
         I//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Skl3AJqxVqBRBtNdQLqw384nQnqBsdrM8rXpTLPVNPk=;
        b=qEV8GfGJwo6jOLvICCKhnpSZ3XUjJqV8ZXNpCgHsu0BA0mk+96i72qzNLZDk7Kyiwt
         9EZQJJhO7d2STDgqPFzhVTjxMDoS8VZVawIyPasKnztB8s+69i2cfrjxkQYl639/KDKN
         MvaxLEXUvjONTO8GfP6tu4cGHMgDANWNCCJkSaOXjl/etEECTYg1e9mIFRFxGjkG1T8O
         BBaJUGRjDA3AB5+RwzPJGWu7u9YjHes+6K8qPFzIviDme8CPWlxkdyGsWP+FThHHR1fi
         qs39f/UymCEeydhJU/FXGDusodNu61yp1lTWJV6sGRiVRHa+CbLX+zUWZpg6+M4WbN7F
         m83g==
X-Gm-Message-State: AJIora8tZFDalJ6vcnws8QzZ0lAMB0mWFRZbXtChbJdv/fXBsTwYDDf2
        nqQs71rtFQX3LzEtOGZb05NPvpx23Fu7kBvYo5VvMMdy
X-Google-Smtp-Source: AGRyM1vlcI4zMzfW9RYypp1pFmYqzjSHPsEhNWBrn2g51ND62KM3VHZdpmxlI+YwVT1lr8PcMP72+bpFu+NoZSPUR90=
X-Received: by 2002:a81:bc8:0:b0:31c:9c04:26a3 with SMTP id
 191-20020a810bc8000000b0031c9c0426a3mr3193215ywl.335.1657706822036; Wed, 13
 Jul 2022 03:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAKXUXMy2WfsRj+nJuNCV4bPNYTvDySLOq3HgpK+gWJSpWS81Kg@mail.gmail.com>
 <1dc0ab09-2cfd-a310-d1da-ef7d3cc47a71@leemhuis.info>
In-Reply-To: <1dc0ab09-2cfd-a310-d1da-ef7d3cc47a71@leemhuis.info>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 13 Jul 2022 12:06:51 +0200
Message-ID: <CAKXUXMy4oW-m_-NQDk6DcoyRE5QprwvaCXa0QF6_FLZ7zL-d4w@mail.gmail.com>
Subject: Re: Update "If something goes wrong" in Documentation/admin-guide/README.rst
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
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

On Wed, Jul 13, 2022 at 11:41 AM Thorsten Leemhuis <linux@leemhuis.info> wrote:
>
> Hi! Lukas, thx for bringing this up.
>
> On 13.07.22 09:26, Lukas Bulwahn wrote:
> >
> > During some other unrelated clean-up work, I stumbled upon the section
> > 'If something goes wrong' in Documentation/admin-guide/README.rst
> > (https://www.kernel.org/doc/html/latest/admin-guide/README.html).
> > README.rst is---as it seems---the intended first summary page of the
> > documentation for any user of the kernel (the kernel's release notes
> > document).
> >
> > The section 'If something goes wrong' describes what to do when
> > encountering a bug and how to report it. The second sentence in that
> > section is especially historic and probably just discouraging for most
> > bug reporters ( ..."the second best thing is to mail them to me
> > (torvalds@linux-foundation.org)"...).
>
> Ha, yeah, guess so :-D
>
> > Some random user (potentially
> > even unknown to the community) sending an email to Linus is most
> > probably the last best thing to do and is most likely just ignored,
> > right?
>
> I'd say it depends on the report and would guess Linus in quite a few
> cases will act on it if the report at least somewhat good -- or about
> something important, like a bisected regression.
>
> > Probably this section in README.rst needs a rewrite (summarizing
> > Thorsten's reporting-issues.rst, or just copying the summary from
> > there) and should then refer to reporting-issues.rst for more details.
>
> Well, any new summary sounds a bit like 'similar code paths for doing
> the same thing'. Sometimes that is necessary when coding, but often it's
> best avoided for known reasons. I think it's not that different for docs.
>
> Maybe just copying the "short guide" from the top of
> reporting-issues.rst might be the most elegant solution for README.rst
> while adding the link your mentioned (maybe while adding a comment to
> reporting-issues.rst saying something like 'if you update this section,
> update the copy over there, too'). But I'm not sure myself right now if
> that's really the best way forward; maybe a few modifications might be
> good here. Let's see what Jonathan says.
>
> Note, the section in README.rst you mentioned also contains a few
> aspects that reporting-issues.rst despite it's size doesn't cover. :-/
> But some of that stuff looks outdated anyway.
>
> > Thorsten, do you have time to prepare a change to that document that
> > gives a short summary on how to report potential issues and
> > regressions? Otherwise, I will happily put that on my todo list and
> > probably can suggest some RFC patch in a week or two.
>
> Then go for it. Normally I'd be interested, but I'm short on time
> currently, as I'm working a lot on bugzilla integration for regzbot,
> have a vacation coming up, and need to prepare talks for two conferences
> (Kernel Summit and Open Source Summit).
>

Then, I will take the points you mentioned as guidance and prepare a
RFC patch and we can discuss what specific changes are needed beyond
my first attempt.

Lukas
