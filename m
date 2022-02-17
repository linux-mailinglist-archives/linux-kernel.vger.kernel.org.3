Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB464BA46E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242535AbiBQPdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:33:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiBQPdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:33:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77CB7562F;
        Thu, 17 Feb 2022 07:32:57 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id h18so10322482edb.7;
        Thu, 17 Feb 2022 07:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JJul3CaBYsl6nxRMJrhyxqC7q1zMq+Fji1s2Sr14IjM=;
        b=qO7ucopXVA0140FEKclf5DeAHDXRZg2WvIL4kSr+QOStgl0ypy7Op6gTJcWQyUv07W
         a3Gj8wzldoEVmmcQw/yK2h0+etBA5bAhTTKcCEmU3RVqniyFzmjNRqVlR35SOLBcyoBc
         i0xpbcjf3IxzKoIggvt5jqCzihXyjvVNIl7UUwsIDMFXU5B1mtVzTZtTYSu+ZPwAPkFP
         tzp9gKTP98OESBY3Z1cKrjcyjnDRHk1zjiFC7mYsBVE672GWtTYYvTLvIBrdc3ibGJfE
         0pWhg4XlV56EqgI6j3lPxnke4dZhgoYblggBT716bj9S5cnq2ViJMQIK4dRw8SPHXJyS
         NK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JJul3CaBYsl6nxRMJrhyxqC7q1zMq+Fji1s2Sr14IjM=;
        b=dKhs5Jma0snQRm84rI6Q6t9P9q/ZwG8hTlFognnMXTRE12WT86Fs+6+NDShLCLKpkE
         Ys9xTpbUPUZ3cGXtieB/WAfahfSCG9A2p08dkKN/huzArZ/5cM8wbkQzIWdKKzhEU1Xc
         7qnf79SqL45WncsyTEFqHMqsTDqCPjzso/cp4hpT4umkDgIoBPX92petzrOXxJnpFBF6
         MBnB6AuJFxoc1PF9VvUTnHFlUkCTc63rZ/hxHwtIdq6R8S34J2myGGZV3bpuK7d++Wqg
         ZZnaRLxDvdSUH851q6XgNmu4mgHdfZpCdpBfWFLMu5Q7V/14WeuIRTFHPvwAIbjJl5BW
         eveA==
X-Gm-Message-State: AOAM531TGMOynu6WM6r7KT2uixpD0huYZ/tdbQ6U9UmWpKQISXz9iytA
        QqKffu0ZcEDMjDcOXddI/QXl44DLMdg=
X-Google-Smtp-Source: ABdhPJy0NbBdUIk/yAuqmUFrTVkCrzL5DtrdlvxOiEWJxydiZhDgzxfv4ropItP6pHSm5uJYpN6jhA==
X-Received: by 2002:aa7:cf93:0:b0:40d:e8eb:1dd2 with SMTP id z19-20020aa7cf93000000b0040de8eb1dd2mr3221057edx.441.1645111976298;
        Thu, 17 Feb 2022 07:32:56 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id bv2sm1287863ejb.155.2022.02.17.07.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 07:32:56 -0800 (PST)
Date:   Thu, 17 Feb 2022 16:32:47 +0100
From:   Tomasz =?UTF-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] scripts: kernel-doc: Major kernel-doc rework
Message-ID: <20220217163247.03e37c9b@fuji.fritz.box>
In-Reply-To: <8735ki2x62.fsf@meer.lwn.net>
References: <20220205233945.7a4d22d8@fuji.fritz.box>
        <8735ki2x62.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 16:45:25 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> Some overall thoughts:
> 
>  - Work like this needs to be broken up into digestible batches.  Let's
>    start with the POD stuff that I've (finally) commented on; other
>    stuff can come later.

I will prepare the POD part. As for the rest, you will need a porter if you
decide this is the way to go. I could help with explanations if something is
unclear and as long as the questions come soon. The winter is almost over and
I need to switch to other activities like earning money.

>  - The coding style in the new work is very unkernellike; that will make
>    it harder to get this work merged.

Yes. I can only add a thought: it seems unnatural to me to have the same style
for various languages.

>  - But let's take a step back and ask: why are we doing all of this work
>    in the first place?  What is the benefit to the kernel community from
>    all this churn, and a growth of the kernel-doc script by over 2,000
>    lines (even if an awful lot of them are blank)?

My motivation was just climbing this mountain, nothing else. I don't even
know, how important this script is to whom. I can only guess. Neither am I
a C programmer, nor want to become one. So this question is to another part
of the community.

I could though think of the benefits to the maintainers. In this respect I've
moved things forward quite a bit, I gather.

As for the blank lines, they are just one character each and trivial to get
rid of.

> I'm serious about that last question; do we really want to invest that
> kind of effort into this nasty old script?  Or, if we're going to do
> such a thing, should we maybe start with Markus's rewrite into Python
> instead?  If we're going to thrash the code and make it unrecognizable,
> perhaps we should move to a language that is consistent with the rest of
> the docs build system and which, I believe, is easier for more kernel
> developers to deal with?

I understand. I didn't know there was a rewrite. I'm not into Python, but
if you could post a link, I'd take a look out of curiosity.

If the community prefers Python, what can I say about this? Their choice.

Personally, I'd rather play with translating this script to Raku (aka Perl 6).
I also wonder, how Perl 5 will transition to Perl 7. A question to Perl
experts.

> I am *not* saying that this work cannot be accepted, and I certainly do
> not want to alienate somebody who is actually able to look at kernel-doc
> and not have their eyes bleed out.  But I am saying that, before
> launching into a hundreds-of-patches journey, we should know where we're
> going and why we are doing it.

I agree.

> See what I'm getting at?

Yes. Thanks.

Tomasz
