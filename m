Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F984E7EB3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 03:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiCZC5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 22:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiCZC5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 22:57:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613FB2B65AB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 19:56:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so3416678wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 19:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TynyZqc/4qYH3QQJEa9xpYm0hZC5c9V8jy9QGxp1bo=;
        b=mRzDyt4+UdZfFT4LhWPuFUivrktYj8qmiUoEUwGBZlNBI+7EtAw28Oqqjwj5fsGZzz
         GT+0PaFan2KLy1ahEIcaebvZWoSi1JsaUgAFckesqWQPfKa46u2WfUCrjfN75lPrfrl1
         /ubo1t/wKjJ8EVGP0BLWA1fHmruLa6Y7IDgrCNfJgJtXqhPQ9MYMTHG3b1YB18dUlPeK
         Qv0Tp9/vWeSMXFUjSlXBEOngjAJFqSk0Ts+1BiA3mP0DK7i67jobEcoQn9KhZir6Bu/6
         Cw7qR+aaIdo+KdjuCpZjfEzJvCz0PBeCSbcoRFmzoPUDRGB6z1OD1L45uSNRpvIHYHis
         QW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TynyZqc/4qYH3QQJEa9xpYm0hZC5c9V8jy9QGxp1bo=;
        b=oxYenGvB9CrDseSGRFUNJQeFKXqL6iVSC/VtWJFf6oDGY9kzftj3iAr6cnNM2NJb07
         0tx2Fr1OOoFeD5hBPp2pVkEFwCAEYWdP+wxDCn40AEF83fYSYJeDXyADfWx+1HdKsies
         +QPx32rbIhI+vyFhfEbdNYwftPW9L6RHjEr9BC9XnBCMV/PlwwpwrXd2ahlu82e3oesb
         KBWhF/pTy6NlaaYRPU8OfWcC9YFWoWZuMlt5Uwl0LOk3MLg8gv+yuvvmBhHEmOrY2BSO
         IGPldB1N2mtcKm387heJQiGlXQ6QCmemEzFCSwHzWS7XPZKV6ckIu4Y+i9sT/5aoT26B
         GVOg==
X-Gm-Message-State: AOAM53323RSKRFdDHLbGl7b00dANOIFlArHE1CPS50FHW/WIoo2nv9SE
        sRru44Jh4eU3w/XdhOr5jj9CDPI7y0z8XVMo727Kvg==
X-Google-Smtp-Source: ABdhPJx4k8LpNcsm7FBHINOia75/EV1DinirlBR+snxBcS4S+MJ5U0vstGN44DglnvIL9XcnVS3ZFtv2uG2PChELQTQ=
X-Received: by 2002:a05:600c:4f48:b0:38c:a460:cb6 with SMTP id
 m8-20020a05600c4f4800b0038ca4600cb6mr13287038wmq.96.1648263372852; Fri, 25
 Mar 2022 19:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220326003356.487828-1-dlatypov@google.com>
In-Reply-To: <20220326003356.487828-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 26 Mar 2022 10:56:01 +0800
Message-ID: <CABVgOSmbQxZmmNtUQLsvMSPkr2FpXB_kdJUUbC=nLrt6xN7e2A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: update kconfig options needed for
 UML coverage
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>, maxime@cerno.tech
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

On Sat, Mar 26, 2022 at 8:34 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Recent changes have made it so the current set is not sufficient.
> Namely, CONFIG_DEBUG_INFO is not being set even when explicitly asked.
>
> Specifying a version of the debug info fixes this.
> Pick CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT as an option that's
> hopefully less fragile (esp. given we're tied to GCC 6 and lower).
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good to me. One idea below, but it's a bit subjective and I'm
fine with this going in as-is if you prefer.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- Daivd

>  Documentation/dev-tools/kunit/running_tips.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
> index 7b6d26a25959..c36f6760087d 100644
> --- a/Documentation/dev-tools/kunit/running_tips.rst
> +++ b/Documentation/dev-tools/kunit/running_tips.rst
> @@ -114,6 +114,7 @@ Instead of enabling ``CONFIG_GCOV_KERNEL=y``, we can set these options:
>
>         CONFIG_DEBUG_KERNEL=y
>         CONFIG_DEBUG_INFO=y
> +       CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
>         CONFIG_GCOV=y
>
>
> @@ -122,7 +123,7 @@ Putting it together into a copy-pastable sequence of commands:
>  .. code-block:: bash
>
>         # Append coverage options to the current config
> -       $ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
> +       $ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
>         $ ./tools/testing/kunit/kunit.py run

Would we want to instead use a chain of --kconfig_add arguments? (I
think there are advantages either way...)


>         # Extract the coverage information from the build dir (.kunit/)
>         $ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/
>
> base-commit: b14ffae378aa1db993e62b01392e70d1e585fb23
> --
> 2.35.1.1021.g381101b075-goog
>
