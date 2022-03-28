Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F4E4EA31B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiC1WjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiC1WjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:39:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AD94925F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:37:41 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h1so18658550edj.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=koFN17ulxhdVtMhymKzO/TIc0UlPzvBHq58ZjJYY7jM=;
        b=AIfvTei1IeVbt+Bk9bsDu8i0OAjWtkFUIv7yu6nVy8c08SnnefFP7cH85NLEj/wNCw
         i2/jbg5t6KzHaYJu21vb1zZZOPfSMKIAjkR+wE9H95LVEpePX5UnIgZg54doj1ggCPBc
         +E5bTjIsBu2ynhVqQIXJaZyKH5zDOCTzn7NjYEQi1hJkAah/ZByHz5rUdih+9IMXoZKn
         kj1nSrlWjgLfiTlk1zuDCj6eG9iDc1KzyG+e9pGVIJXj8bktP0wojYEZJz2sgMCIF8R4
         iQhNT1pJbGBi/pDON8VfwJv3viJtAZLBCCh4o1dGEvU7Ij2Ep6L7qPMlleiNsd5gbyl1
         8vAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=koFN17ulxhdVtMhymKzO/TIc0UlPzvBHq58ZjJYY7jM=;
        b=q1aDl5aD1XQE0ApOQIkfxr7pyd+Dzz/Lc0QCJg66fqf57dcwEBnNN6HFgfk+Qsx6A1
         +zbTNqEphTrgpzu7UiOqSEwldSLiF0WPMO6W+PojZ6EuZLMsb80DSEUwaCUFjzLg1iF8
         dfmbCwXr97Xw9eJoD7unSU4gcQhCPwJvACM/Gv4SJ05TJ5eGd38U+6bATysKtQVWYVUc
         9RGFn/Bfo3jZaKPE8c77IxLorbbnIkekujMfhP8a85a7RFO2YV/BMervPWEsBb7BikFo
         fNpFS1BJNq6tyB9ndun2ONG5NUkn+Zbl60mI25y1K2L0WgA8pQuSeOejS7yob+hWYw+W
         6qNg==
X-Gm-Message-State: AOAM531wZH7NjGodWh50aYCUAgEtesYeJsNR5MDdl/B4FiVRVrIy2RZ3
        2DULgpLYisP5ndEmnV/aTQmsPIxca4H3LrX6bK2aoQ==
X-Google-Smtp-Source: ABdhPJy4H1cvLXKft5SWJwyRx3X+cyr/G//Qw0QJiCqbwIOBZEWToj35RPb4cu1OUszYCjHF8kvRJgf830piojgobh0=
X-Received: by 2002:a50:c307:0:b0:418:ec3b:2242 with SMTP id
 a7-20020a50c307000000b00418ec3b2242mr147905edb.229.1648507059439; Mon, 28 Mar
 2022 15:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
In-Reply-To: <YkImfPbNOzQBq5ZD@marsc.168.1.7>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 28 Mar 2022 17:37:28 -0500
Message-ID: <CAGS_qxpjj1W54BM7v2Cszne4nh5kUXZt89Dq-5nO3nD7RWhsRQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: dev-tools: Add a section for static
 analysis tools
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     corbet@lwn.net, mchehab+huawei@kernel.org, davidgow@google.com,
        linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org,
        cocci@inria.fr, smatch@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 4:20 PM Marcelo Schmitt
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

Nice!
This is definitely worth including, but I'm out of my depth here.
Some ideas below in case they're helpful.

Acked-by: Daniel Latypov <dlatypov@google.com>

> elaborated. Maybe provide some guidance on when to use each tool.
> I've been studying how Linux device drivers are tested.
> Here's a post I wrote talking about some testing tools.
> Link: https://marcelosc.gitlab.io/how-is-linux-tested/
>
> Best regards,
> Marcelo
>
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
> +
> +Sparse can help test the kernel by performing type-checking, lock checking,
> +value range checking, in addition to reporting various errors and warnings while
> +examining the code. See the Documentation/dev-tools/sparse.rst documentation
> +page for details on how to use it.
> +
> +Smatch extends Sparse and provides additional checks for programming logic

Coming from a place of ignorance, when should I use sparse vs smatch?
Is there an existing consensus on this, or is that a controversial question?

I assume other newcomers like me will have the same question and be
unsure if they should spend time learning about sparse.
In general, I think the main point of this page is to explain both
what the tools do and give an idea of _why_ someone might want to
consider using them.

> +mistakes such as missing breaks in switch statements, unused return values on
> +error checking, forgetting to set an error code in the return of an error path,
> +etc. Smatch also has tests against more serious issues such as integer
> +overflows, null pointer dereferences, and memory leaks. See the project page at
> +http://smatch.sourceforge.net/.
> +
> +We also have Coccinelle as an option within static analyzers. Coccinelle is
> +often used to aid collateral evolution of source code, but it can also help to
> +avoid certain bugs that have been expressed semantically. The types of tests
> +available include API tests, tests for correct usage of kernel iterators, checks
> +for the soundness of free operations, analysis of locking behavior, and further
> +tests known to help keep consistent kernel usage. See the
> +Documentation/dev-tools/coccinelle.rst documentation page for details.
> +
> +These static analysis tools support running tests on the whole source tree or
> +over a specific file or directory.

Personal preference:
I'd personally put this up before we go into details about each tool.

E.g. perhaps like

In addition to testing a running kernel, one can also analyze kernel
source code directly (the whole tree or specific files) using **static
analysis** tools.
Some tools commonly used in the kernel are ...

> --
> 2.35.1
>
