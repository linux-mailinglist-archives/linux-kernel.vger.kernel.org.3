Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756465A0A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbiHYHfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbiHYHfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:35:16 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884D04D24A;
        Thu, 25 Aug 2022 00:35:15 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-33da3a391d8so106397057b3.2;
        Thu, 25 Aug 2022 00:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2wSSrVm3pa1V5hQWMblReXhBYfSvBPQ27mkT6JksCsg=;
        b=HlJE+BfhiHh1s2VOJ9goUlxZY7vl7GOf5epTMlea1UChGhf7XOiSaeGw4FrWeIUyZI
         vg8eYQ5OM0bOuhlbGY8kytmyjN6NXp0+mNwe9VEyFUxZ0YM2MWk975pHJRDfCpSWXzPr
         XeePht5DUPza+81Bxjnvt+Hy26d8e0MTetBYAOKgg9HKlys9hFTC7wOt1ApHtMUd8Mqp
         ymUhVO++7FZ0xROUDyOIAgp1QYolp6xhIExUbx7ownIu1Ch78JvHPwN/DRN8p/LxJzIF
         FYKFXCm7tQMtTkmewldwxXqS6vfYTXTYgBjyGu9oVVQr2nsA/VD53WQWA8ntyLQJ5zRE
         yXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2wSSrVm3pa1V5hQWMblReXhBYfSvBPQ27mkT6JksCsg=;
        b=RJSc1tNE2UGL22rbr4DLBQOhpwDmLC6n39mkucRCa9bhJLj4x9xDg6Of2QD0itxPfd
         evEJ7HkmX7PHW9TufiHqcVfJagYa2UUkiN5C6Df/UEW6ISuJs3fM7mSXv3I0B9E1fonf
         BVLAYIK1O2hXevwrR1w0D7jtn6m2w/FkO8aMwBXncO5pzKr8GqALfT+qHp+jKj6fXiaG
         cjnC6hBQoLN6Xprlisc/B+G7N/30GGEgw3woAmGlvY49dYFjVVjTzY7G4QUAduIbrg8O
         VNgMVeMUy+WbAmTaneVKqNWEB607hGzMZIudWP7Qb1zhhezFy+HvZ4VyQ6Lqlf7jDr1w
         eOXw==
X-Gm-Message-State: ACgBeo3e605NbIKVhXChmnDaSlVNunmS43AUBHK8Qa5BwCtITTGuKoJv
        J4BZy7sapxs2G3MRT1rm0Quvi2kLS9+d0q1Ensw=
X-Google-Smtp-Source: AA6agR7sPU2s9bjpip6MZRNuDyBW5ZsILU+1IxceZrULNMzLenldjjYeAw9vC++G1Sx2MXw7yeV4G3k6tZA1NZZxZ5c=
X-Received: by 2002:a05:6902:1616:b0:695:a4c6:b4e0 with SMTP id
 bw22-20020a056902161600b00695a4c6b4e0mr2355954ybb.31.1661412914690; Thu, 25
 Aug 2022 00:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220824080836.23087-1-lukas.bulwahn@gmail.com> <d5eca4a6-8a76-02e0-2f22-645341af8c2b@infradead.org>
In-Reply-To: <d5eca4a6-8a76-02e0-2f22-645341af8c2b@infradead.org>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 25 Aug 2022 09:35:04 +0200
Message-ID: <CAKXUXMwLofvhBXqzdoq_q_89jZ8THU0WX=DY+RnCo=PN7QqspA@mail.gmail.com>
Subject: Re: [PATCH] docs: Update version number from 5.x to 6.x in README.rst
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
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

On Thu, Aug 25, 2022 at 5:24 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 8/24/22 01:08, Lukas Bulwahn wrote:
> > A quick 'grep "5\.x" . -R' on Documentation shows that README.rst,
> > 2.Process.rst and applying-patches.rst all mention the version number "5.x"
> > for kernel releases.
> >
> > As the next release will be version 6.0, updating the version number to 6.x
> > in README.rst seems reasonable.
> >
> > The description in 2.Process.rst is just a description of recent kernel
> > releases, it was last updated in the beginning of 2020, and can be
> > revisited at any time on a regular basis, independent of changing the
> > version number from 5 to 6. So, there is no need to update this document
> > now when transitioning from 5.x to 6.x numbering.
> >
> > The document applying-patches.rst is probably obsolete for most users
> > anyway, a reader will sufficiently well understand the steps, even it
> > mentions version 5 rather than version 6. So, do not update that to a
> > version 6.x numbering scheme.
>
> Yeah. And I suspect that scripts/patch-kernel is even more obsolete
> than applying-patches.rst.
>

Randy, would you know if there are still users out there?
Would it help to replace this script with a minimal script that only
reports to "Please use git to obtain a recent repository. Update
versions and apply patches with git in a controlled way.".

If someone complains, we revert the patch. If no one complains within
a year or two, we could consider shutting down the infrastructure
creating those patch archives as well, and delete the documentation
referring to that.

Lukas
