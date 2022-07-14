Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BB75747BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbiGNJHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiGNJHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:07:49 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AC422BFB;
        Thu, 14 Jul 2022 02:07:47 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id r191so1636257oie.7;
        Thu, 14 Jul 2022 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=HtoAKV34fkg7oJD7fYEz8ioi5wZAzA+9Ww8IthJm6js=;
        b=SGUOaQYgjTEUxx3qgHflmR3uXxb9Sdtf8NQ2J3S7+I9Fzk7GslAZLiWW5Tnn1uVSj1
         dU9DoOwvNfecF2lHZxoxVKojNAZz1ta9JDkZycrvSBayPIntBof9VOnGEIbCnAxjWtRt
         j6Awmt5ANPjlm/eLS3eoelzjFAtZvSJp1NgvJcV0/ad/ULiKtEdnBtrBdSNokFgWM/tA
         8NeQSRzcF6CFq5RC3xjMHlKb6Yjlg7Y7L+pF2JW1BIsaApuEXq6M/lWZ8xC+tBtpm6MC
         ep4EYgwdjkPVymQ4/pPO8YAO8PwTMk2A+zPFREd1a1OXDmvbDXd4lofhs+fCLxyKnACG
         DAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=HtoAKV34fkg7oJD7fYEz8ioi5wZAzA+9Ww8IthJm6js=;
        b=BP45e1Mt30I13XuyluJlEyNg6G+y/F+qqV2mxpLV1QIvPIfRIByHtFjKLPy9ajZLjO
         frauyp9s/1AizibtvISi/fjgaXisEj605W1oECFqUNBy1V4zHb1XKUF+SxJr9d7HlLva
         IRr7RokDA8r87KKWVEIiALxE48DlQMKrsc8UG89iAPZpO9C85HmsVT3ukTprScmLUbKt
         joauWorFSl+2VlgEcJwmvZmBW+U4WNt2UltWexRYaJOqIjRZYqrp/aVDYbvg5S4f4xw/
         S2wr5leEmriqqz330DmhzAtM6qL4LmV0UgIeRchY8u7t/Nv+/Cxbx5CgHczqyDMDPrfP
         oXKA==
X-Gm-Message-State: AJIora+axvUoDl3UcyAUEaqaLKJYb1RFa7KrTnOJ3V/4td6X08y3u+8H
        N41arBMKF+43TxJHu7RhWERACD45qmXEoFD/utNMsLITuy0MIw==
X-Google-Smtp-Source: AGRyM1tYqmmTTh5yn+aJRqp7Gt0nH2iHs/VvgL4A/Z2KEfbB9bG1GoGX0CATwSeA424Pn/7rMywZUN2VoUO5xOKXPVk=
X-Received: by 2002:a05:6808:bce:b0:337:aaf6:8398 with SMTP id
 o14-20020a0568080bce00b00337aaf68398mr4096084oik.252.1657789666301; Thu, 14
 Jul 2022 02:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <870c02d4d97a921f02a31fa3b229fc549af61a20.1657747763.git.bristot@kernel.org>
In-Reply-To: <870c02d4d97a921f02a31fa3b229fc549af61a20.1657747763.git.bristot@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 14 Jul 2022 11:07:10 +0200
Message-ID: <CA+icZUVbQNM+MkMCQik83FoiWF_a1v7Mb-4hZX6SZgNcp2x5SA@mail.gmail.com>
Subject: Re: [PATCH V2] rtla: Fix Makefile when called from -C tools/
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
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
> ---

Thanks for v2.
That looks good to me.

Daniel, you are right that not passing -s to make-line will not show
the grep output.

Formally and again my...

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

-Sedat-

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
