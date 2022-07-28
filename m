Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE19E583A25
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiG1IQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiG1IQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:16:16 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D535A2DE;
        Thu, 28 Jul 2022 01:16:11 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id n206so1640381oia.6;
        Thu, 28 Jul 2022 01:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=7lsW98oKPVkPLCsPCUl6IaHz/uaCklhdsPPA2BI505I=;
        b=H1Z3mYYSuNgVzgTaMnKhTChwXt+zdTh2l2xOuhRSEwAzLofUyuHfBEUdrnklEexybx
         F7SAUywk/419CihGTiYx5D7f3Yt932xZq94tpP8oU10oim8NwhGGXZZ3+lvFvBNBPamt
         gZig97+R4szINucIMvgTQOjtsQOIDZ9HIvYAALDIJoEvFbzELVHjSav+dbEoF1QArtCc
         VWfvmOyWZksumrEcAShJEII3LHYxotFwFBZ4tIY4q3tip5i6BbBcTBkt3zYqR9nBb0OF
         QeZPIcWFSUlc8C9IL97fOjtF/H4fZLkwWi29k6vgQkHpqj01E1ZnXO8blJXMaDJ0voiy
         kVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=7lsW98oKPVkPLCsPCUl6IaHz/uaCklhdsPPA2BI505I=;
        b=dbssjRcc/Nvsitx4NE3huDqNaB6Nk8WrNlqQq5RaeC8xeQj/YyRomr6gbhvVZzlqUB
         lRqHYyvHkZUu45WtHT/VDgePe8W6DQ0A8/ikJROQyhUMr4F05AbyV49Fqc/D4/bfQxse
         5DNJcgiEvyeXDNxc5ZK2+45+hlST3NVLxH3HUrvv/IyIFfRRRV5wNYVtXAfQWSAsAebL
         EpbI4ixUcP9HvYgd/7uCVuByS3ccE3/Mh5dXNbW/wR2m2YbQMKuKrzzZPDUPhtAzyvQL
         ekSkkL9n2Vh64xg5ld+nnE4j0wLFGRgMlaqa0etjQH/jYWZq31Kp5eWKr3RT2S8qyRNS
         muLQ==
X-Gm-Message-State: AJIora9wGUtsbqz40FhC8EesiRRo4pn8qE/TkbDv1cYYrv+dJmHo7tn3
        01wBtvgPbnyw0PlplYLBADKKKUAzizhf7ByVmDQ8BFjcKqPeMA==
X-Google-Smtp-Source: AGRyM1tGfo1Q6iew4ExpxYfhfjIpNHORqOyeSbAd494+gj107w43w2CJ9gxJXOFv/vgtpvTWQLmATunfa20FS1014gg=
X-Received: by 2002:a05:6808:302b:b0:2f9:eeef:f03 with SMTP id
 ay43-20020a056808302b00b002f9eeef0f03mr3518377oib.128.1658996170924; Thu, 28
 Jul 2022 01:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <870c02d4d97a921f02a31fa3b229fc549af61a20.1657747763.git.bristot@kernel.org>
 <CA+icZUV9waE16ZW4RNEDeiemv6eRd=MetzdGbF-vpfT_u1N4_w@mail.gmail.com>
In-Reply-To: <CA+icZUV9waE16ZW4RNEDeiemv6eRd=MetzdGbF-vpfT_u1N4_w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 28 Jul 2022 10:15:34 +0200
Message-ID: <CA+icZUX2v-u8tL-U73hZJ0nNHXJ6XQYPupTRBV9QaQN88OF2bw@mail.gmail.com>
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

On Thu, Jul 28, 2022 at 10:01 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Jul 13, 2022 at 11:32 PM Daniel Bristot de Oliveira
> <bristot@kernel.org> wrote:
> >
> > Sedat Dilek reported an error on rtla Makefile when running:
> >
> >     $ make -C tools/ clean
> >     [...]
> >     make[2]: Entering directory
> >     '/home/dileks/src/linux-kernel/git/tools/tracing/rtla'
> >     [...]
> >     '/home/dileks/src/linux-kernel/git/Documentation/tools/rtla'
> >     /bin/sh: 1: test: rtla-make[2]:: unexpected operator    <------ The problem
> >     rm: cannot remove '/home/dileks/src/linux-kernel/git': Is a directory
> >     make[2]: *** [Makefile:120: clean] Error 1
> >     make[2]: Leaving directory
> >
> > This occurred because the rtla calls kernel's Makefile to get the
> > version in silence mode, e.g.,
> >
> >     $ make -sC ../../.. kernelversion
> >     5.19.0-rc4
> >
> > But the -s is being ignored when rtla's makefile is called indirectly,
> > so the output looks like this:
> >
> >     $ make -C ../../.. kernelversion
> >     make: Entering directory '/root/linux'
> >     5.19.0-rc4
> >     make: Leaving directory '/root/linux'
> >
> > Using 'grep -v make' avoids this problem, e.g.,
> >
> >     $ make -C ../../.. kernelversion | grep -v make
> >     5.19.0-rc4
> >
> > Thus, add | grep -v make.
> >
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Fixes: 8619e32825fd ("rtla: Follow kernel version")
> > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>
> Hi,
>
> what is the status of this patch?
>
> Is it missing some ACKs e.g. from Steven?
>
> Can this go directly to Linus tree as I wanted to see it in Linux v5.19 FINAL?
>
> Thanks.
>

INFO:

Steven's autoresponder says:

I'm currently traveling and may be slow to respond (and may not at all).
I'll be back at my normal hours on Tuesday, Aug 2nd.

Here the lore-link to v2:

[1] https://lore.kernel.org/all/870c02d4d97a921f02a31fa3b229fc549af61a20.1657747763.git.bristot@kernel.org/

-Sedat-

>
> > ---
> >  tools/tracing/rtla/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> > index 3822f4ea5f49..1bea2d16d4c1 100644
> > --- a/tools/tracing/rtla/Makefile
> > +++ b/tools/tracing/rtla/Makefile
> > @@ -1,6 +1,6 @@
> >  NAME   :=      rtla
> >  # Follow the kernel version
> > -VERSION :=     $(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion)
> > +VERSION :=     $(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion | grep -v make)
> >
> >  # From libtracefs:
> >  # Makefiles suck: This macro sets a default value of $(2) for the
> > --
> > 2.32.0
> >
