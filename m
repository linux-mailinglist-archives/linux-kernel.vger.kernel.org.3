Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A49E4EA694
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 06:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiC2Ebf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 00:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiC2Ebb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 00:31:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DDA31DE8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 21:29:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n63-20020a1c2742000000b0038d0c31db6eso709466wmn.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 21:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlF2aB+JhCu4/YboCkIwevoV0JCWHKYkpHYec+xK8yU=;
        b=sH5UDzlazOMgp/F0QFc7WyE98B2OJE1eeHbu1tNEDrCnXNabQkTaN6IbyOt6cfyLtT
         FjjRe/BwF6+Soxf1jFwaxxImiU+kqpK1gFNTD4x6tE/mGnPGoCJcUSTm1C/H0aF9Uy+r
         5opp6MDhAM3Bgx9Lc1YhmVVAjXcW++9QE95jjsFKt4aixqGktffLme1hfzjIFf/Ffq0k
         9+iJ27O8W+TivIe8oGJ6G7HJEu4iHT8V/YPICbSZozFybaym4lDwOOSQWEs6f15y2oen
         J0nCycu2a6/2NXhEyfOP5BSHcuOofrm4ThB/pxYxDRJhOYiGx12JjBoVNXEBd3wkbEli
         ZOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlF2aB+JhCu4/YboCkIwevoV0JCWHKYkpHYec+xK8yU=;
        b=vNP3ENyDwhMJPkltTkWWmnM7xOG5LsfKTzl6OEvb6o9kX7gbZzRg4+xQzHtuVN/qfz
         B8T+sZGnzLYKuLq6pOfD7Gq0IuOwNxrPONhwa3D7oawmiuDM9Wcr75dXGtrklM3zaBkY
         p8FR/hrWejxCFuspL4YL3T2I9ZWwO2RIsZngzP5rmeOm6F+xIEzK0SVEp/JtSiHL/Iqj
         Xl1ZT8KR9mk3zD6AdmZUpGimomDkIOJf9P28Wy8p6mGOa/vOas5dg4+A+9kfgl3z0N1b
         kLyUH6PQ3X7NBIrME5IUQRssvxQ51+GZaSzQSjGiVFfEvjRJViU92Od8ZMkY3tD5cVsY
         inqg==
X-Gm-Message-State: AOAM530duiIo2hi0YxGr+lxG6hehN51IwizfhttmpkJq27+jSUbz0mL5
        +8HbJBsocG02ThX9SZ8KUGmBMzN5L9BkoBEvALgX2w==
X-Google-Smtp-Source: ABdhPJyNFK7OBo01/MPtifFb+6i74vavXN/36eXTCKIvjxpkj92xS+4Xt+srORBU3PHcnLIAaPsTL5GBgeOa809iVtY=
X-Received: by 2002:a7b:c541:0:b0:38c:b0ed:31c4 with SMTP id
 j1-20020a7bc541000000b0038cb0ed31c4mr3961723wmk.141.1648528186728; Mon, 28
 Mar 2022 21:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
In-Reply-To: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
From:   David Gow <davidgow@google.com>
Date:   Tue, 29 Mar 2022 12:29:35 +0800
Message-ID: <CABVgOSkPwn9bQgXTmrnMRuxy5cyeNxoUgrXFX_ayw0UBW9O7=g@mail.gmail.com>
Subject: Re: [PATCH] Documentation: dev-tools: Add a section for static
 analysis tools
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-sparse@vger.kernel.org, cocci@inria.fr,
        smatch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 5:20 AM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Complement the Kernel Testing Guide documentation page by adding a
> section about static analysis tools.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
> Hey everyone,
>
> I think this patch can be a good addition to the documentation as
> discussed in the thread for the testing guide documentation page:
> Link: https://lore.kernel.org/linux-doc/CABVgOS=2iYtqTVdxwH=mcFpcSuLP4cpJ4s6PKP4Gc-SH6jidgQ@mail.gmail.com/
>
> If you think it would be worth it, I can try making something more
> elaborated. Maybe provide some guidance on when to use each tool.
> I've been studying how Linux device drivers are tested.
> Here's a post I wrote talking about some testing tools.
> Link: https://marcelosc.gitlab.io/how-is-linux-tested/
>
> Best regards,
> Marcelo
>

Thanks a lot for adding to this, and for writing that blog post, which
I think is an excellent overview itself. I'd definitely like to see
more of it work its way into this document. (While we've largely stuck
to tools which are in-tree thus far, I think we'd definitely benefit
from discussion of, for example, the different CI systems.)

One thing which isn't totally clear is when to use one of these tools
instead of another. This is a bit awkward, given that there is a bit
more overlap (and the existing documentation is less clear), but
comparing the "calling this specific kernel function incorrectly is
causing this very specific bug" nature of Coccinelle with the "there's
a bunch of typechecking so you can statically prove you didn't forget
an endianness conversion somewhere" things sparse does.

(Take those with a grain of salt, though, as I confess to not being an
expert with any of these tools...)

I've added a few other ideas inline, below, which you can take or
leave as you see fit. Either way, I think this is a great improvement
on not talking about static analysis tools at all, so thanks.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/testing-overview.rst | 29 ++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> index 65feb81edb14..b00511109a9d 100644
> --- a/Documentation/dev-tools/testing-overview.rst
> +++ b/Documentation/dev-tools/testing-overview.rst
> @@ -115,3 +115,32 @@ that none of these errors are occurring during the test.
>  Some of these tools integrate with KUnit or kselftest and will
>  automatically fail tests if an issue is detected.
>
> +Static Analysis Tools
> +======================
> +
> +In addition to testing a running kernel, one may also scout for bugs by
> +analyzing the source code semantics. Three tools are well known for serving this
> +purpose.

It might be worth being a bit more explicit that these run _at compile time_.

Maybe this would also be the right place to document CONFIG_WERROR?
Though that is slightly different yet again...

> +
> +Sparse can help test the kernel by performing type-checking, lock checking,
> +value range checking, in addition to reporting various errors and warnings while
> +examining the code. See the Documentation/dev-tools/sparse.rst documentation
> +page for details on how to use it.

It'd be nice to give an example of the extended type-checking here.
e.g., endianness checks: https://lwn.net/Articles/205624/

> +
> +Smatch extends Sparse and provides additional checks for programming logic
> +mistakes such as missing breaks in switch statements, unused return values on
> +error checking, forgetting to set an error code in the return of an error path,
> +etc. Smatch also has tests against more serious issues such as integer
> +overflows, null pointer dereferences, and memory leaks. See the project page at
> +http://smatch.sourceforge.net/.
> +
> +We also have Coccinelle as an option within static analyzers. Coccinelle is

Nit: _maybe_ it's worth simplifying this to just "Coccinelle is
another static analyzer" or similar, so that all of these paragraphs
start with the name of the tool being talked about. That makes it a
bit easier to skim the page.

> +often used to aid collateral evolution of source code, but it can also help to

Nit: It's not entirely obvious what "collateral evolution of source
code" is. Would "refactoring" be close enough?

> +avoid certain bugs that have been expressed semantically. The types of tests
> +available include API tests, tests for correct usage of kernel iterators, checks
> +for the soundness of free operations, analysis of locking behavior, and further
> +tests known to help keep consistent kernel usage. See the
> +Documentation/dev-tools/coccinelle.rst documentation page for details.

Maybe talk about how Coccinelle is matching specific (and often
kernel-specific) patterns?

> +
> +These static analysis tools support running tests on the whole source tree or
> +over a specific file or directory.
> --
> 2.35.1
>
