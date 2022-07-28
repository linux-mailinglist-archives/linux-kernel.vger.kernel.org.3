Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753DC5839F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbiG1ICe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiG1ICc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:02:32 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076A161721;
        Thu, 28 Jul 2022 01:02:30 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so1441839fac.13;
        Thu, 28 Jul 2022 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=WyC5/v+5IjvoemGWKh+2qqBs6Wuz7i46xSTO71cG+9s=;
        b=BFI5/328iN0kxg2Bi10CZZ74ZzAisCFBTtDRAZHDUI2S7jDo2YpoQy7ofjPuhnc0kI
         9NvRepgwoPXUiYtdMbb5Cm/mdtfK0HaqMEyOfCq4UFHrYWbqGjl8faKGjSxNSG4/l+uY
         noBwc8K1Td1sJCKR9rp0HLqlj5CC4QA4CuVpIls6Hlw0mBur/2zeKSbKkeZphar4waxZ
         XQ6FGvXPeqOnPgaTX8c5bwLCVxcPpzCLfMikERwDq80VbBswslYLmGf47G/DvNwXwRPc
         nrkw+evpaZc/Fzw89xGH9OA5D+iej3RUBzmgOJ3LEQDNICxWMoHlCC1mRUO1CtaIy1jj
         03vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=WyC5/v+5IjvoemGWKh+2qqBs6Wuz7i46xSTO71cG+9s=;
        b=NI5jP3UnJ9Dye+AbdeEqNbrTlGZAGTKv/9G6yPlOfrNZKa2AIZ6DD+Gh5kQcD8zufu
         GpSMsH8ekchHm5/VTMnyDMlal/ba3CLBMoAZO9bPgwQlXqzMXVth6XPKa45/3iyapXzZ
         KFJLsX1/4EqshaUCcT5A5JXK/XyA4+42We3Bas32SeBWNpvQD0yRnF2+I26Gl2oeOOCf
         iQ3zdbo+Jcg3qlm5jQm/d5KeCaOP7HEIFe2l7I6E2HPZlLIpz9jQ4z9gFKxzle7mYY4U
         9GrNoDLDjcvWGy9dPEr4V1PMg78q7v+jY+JZA843fP6Eb0ZywNCm57fDPKK/HfzF+slu
         WA3g==
X-Gm-Message-State: AJIora+7Rw10aeNwjPkmFHhQaPWi1jhZ4HZZmgvfo4qu2D1x3fO4HMyv
        vmxl0cIhd6LZLzOJhLEjCh62Q1Qy0HLOV4D9RYRxwIXBc9c=
X-Google-Smtp-Source: AGRyM1sG1Bmj8eaRzDU0dxS/0b2tIJuV3nnAV8LnmtK7EO+lQZc65EuzA3HP+405P/cBx0k1i4n5Io8ptq1WpJhc2cg=
X-Received: by 2002:a05:6870:e30e:b0:10d:c6b4:6396 with SMTP id
 z14-20020a056870e30e00b0010dc6b46396mr4156894oad.128.1658995349146; Thu, 28
 Jul 2022 01:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <870c02d4d97a921f02a31fa3b229fc549af61a20.1657747763.git.bristot@kernel.org>
In-Reply-To: <870c02d4d97a921f02a31fa3b229fc549af61a20.1657747763.git.bristot@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 28 Jul 2022 10:01:52 +0200
Message-ID: <CA+icZUV9waE16ZW4RNEDeiemv6eRd=MetzdGbF-vpfT_u1N4_w@mail.gmail.com>
Subject: Re: [PATCH V2] rtla: Fix Makefile when called from -C tools/
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 11:32 PM Daniel Bristot de Oliveira
<bristot@kernel.org> wrote:
>
> Sedat Dilek reported an error on rtla Makefile when running:
>
>     $ make -C tools/ clean
>     [...]
>     make[2]: Entering directory
>     '/home/dileks/src/linux-kernel/git/tools/tracing/rtla'
>     [...]
>     '/home/dileks/src/linux-kernel/git/Documentation/tools/rtla'
>     /bin/sh: 1: test: rtla-make[2]:: unexpected operator    <------ The problem
>     rm: cannot remove '/home/dileks/src/linux-kernel/git': Is a directory
>     make[2]: *** [Makefile:120: clean] Error 1
>     make[2]: Leaving directory
>
> This occurred because the rtla calls kernel's Makefile to get the
> version in silence mode, e.g.,
>
>     $ make -sC ../../.. kernelversion
>     5.19.0-rc4
>
> But the -s is being ignored when rtla's makefile is called indirectly,
> so the output looks like this:
>
>     $ make -C ../../.. kernelversion
>     make: Entering directory '/root/linux'
>     5.19.0-rc4
>     make: Leaving directory '/root/linux'
>
> Using 'grep -v make' avoids this problem, e.g.,
>
>     $ make -C ../../.. kernelversion | grep -v make
>     5.19.0-rc4
>
> Thus, add | grep -v make.
>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: 8619e32825fd ("rtla: Follow kernel version")
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>

Hi,

what is the status of this patch?

Is it missing some ACKs e.g. from Steven?

Can this go directly to Linus tree as I wanted to see it in Linux v5.19 FINAL?

Thanks.

Regards,
-Sedat-

> ---
>  tools/tracing/rtla/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index 3822f4ea5f49..1bea2d16d4c1 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -1,6 +1,6 @@
>  NAME   :=      rtla
>  # Follow the kernel version
> -VERSION :=     $(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion)
> +VERSION :=     $(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion | grep -v make)
>
>  # From libtracefs:
>  # Makefiles suck: This macro sets a default value of $(2) for the
> --
> 2.32.0
>
