Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9380956CDD8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 10:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiGJIl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 04:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJIlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 04:41:25 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4B0186F6;
        Sun, 10 Jul 2022 01:41:24 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w83so3631812oiw.1;
        Sun, 10 Jul 2022 01:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=pV0ib9A/Zqn3DAPzUpkTVTd8pzK2zpC1aB/N9OYfh5Y=;
        b=kCXhVzyFMw7S+lCU/LwpvzAgmS+/lwBU9Y9wpSCzuN8j/7QA+3wkf7yzUmi/kPbLHf
         J/fixpM0ErV7ewQxrhAqwBZ0k2lmXYEDeSYvh5BzrQYiIrKZo+4fml4ZDjcE5uILr0QT
         AqSR21dHKUr6+RQ0PKm3wpi9AlY8ZMUr4/E+vg+tnu61GeL0YH+TwOSAmbaiBYwn/oke
         Jw09mIja3s3RYDeRIZBvYZxyRWvedwuFXD/TokPlT1FdSwWXdag9pakoy179+DyMKq0r
         Fqph5L4mMCUMLex8y/R8760NWeEbFUpd6jPdgF3CxQTOk8wmYMEWDTBF0WLA6o/RQXcJ
         ZZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=pV0ib9A/Zqn3DAPzUpkTVTd8pzK2zpC1aB/N9OYfh5Y=;
        b=8HwgW9Zx2gAl9EvnsCwN/AOzRlhuFOQfv1nDrfnZpW6gC/Kz4FbITl6sFLzKglWbRh
         Fo5aEYZcoBTV7GiCX2rl6hAj1GsEinswjDUBlwDHcL22r7V+40RDb7SnlPJvNrohKtUu
         ENjSXoFSWGSKmZKSmsx3oWT00ZkQRiWclPX/IsF4JcTRgVKKH4AG5mi6tmOjkHymwMpX
         WAf0uTL9pKJHV0rPgwsHlX2f2jfNhmaPrgspGZru320hku7hlhJX5/B0J/pabMMXUPt4
         efjXGjJCuQ2VBtzBdg+ZcjbCpfGo+tDO7SpsmEXaMH1n0f0UUjE44Orran7oJUDRrobu
         tR9A==
X-Gm-Message-State: AJIora+t+SSp0soQ/2BIsaKLN25nS0DNebdiuPbkSGzZ5nSsWaIV17TF
        NOy6327zRisYHKSzZZm6cy2fCra3RnA00fbwKfO/ADXpSP02eg==
X-Google-Smtp-Source: AGRyM1vCDFTJqvW+Rt/d3cAvtm4skROzzW1zVKfoq0OrYxutUdiMJZfk5XddtrqB1ox7OHdtCEe6EW/NrHNJVRbDq10=
X-Received: by 2002:a05:6808:302b:b0:2f9:eeef:f03 with SMTP id
 ay43-20020a056808302b00b002f9eeef0f03mr4446745oib.128.1657442483540; Sun, 10
 Jul 2022 01:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <9154d66961804027b1bdc26f1ff08012bb7f9df8.1657269675.git.bristot@kernel.org>
In-Reply-To: <9154d66961804027b1bdc26f1ff08012bb7f9df8.1657269675.git.bristot@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 10 Jul 2022 10:40:47 +0200
Message-ID: <CA+icZUUKiODjF0gZ1MaHPgVZS8zKEweR-1NkjHcegsLoRNUQ9w@mail.gmail.com>
Subject: Re: [PATCH] rtla: Fix Makefile when called from -C tools/
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

On Fri, Jul 8, 2022 at 2:17 PM Daniel Bristot de Oliveira
<bristot@kernel.org> wrote:
>
> Sedat Dilek reported an error on rtla Makefile when running:
>

Hi Daniel,

Thanks for the patch.

>     $ make -C tools/

No, that was with...

$ make -C tools/ clean

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
> But the -s is being ignored when rtla's makefile is called from indirectly,
> so the output looks like:
>
>     $ make -C ../../.. kernelversion
>     make: Entering directory '/root/linux'
>     5.19.0-rc4
>     make: Leaving directory '/root/linux'
>
> 'grep -v make' to avoid this problem, e.g.,
>

Missing word at the beginning soething like:

Use 'grep -v make' to avoid this problem ...

>     $ make -C ../../.. kernelversion | grep -v make
>     5.19.0-rc4
>

Shouldn't that be:

$ make -sC ... (missing "s")

Regards,
-Sedat-

> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: 8619e32825fd ("rtla: Follow kernel version")
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
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
