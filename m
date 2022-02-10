Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8051C4B1399
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244900AbiBJQxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:53:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244698AbiBJQxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:53:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED86122;
        Thu, 10 Feb 2022 08:53:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D8CD6101F;
        Thu, 10 Feb 2022 16:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4525DC340F1;
        Thu, 10 Feb 2022 16:53:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X4vtb05v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644512026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EGdQtwAMl2JzepeY8u2DDVzhSqe5QZiHUpv9LWGtw2c=;
        b=X4vtb05vqw/OoBqCrjXyIzYeo9WpiGKTAldVWFqLV5zS6KTXgUM3UeTfk9ae4ml1l87dmQ
        OTZFXLhgt+5ekrL17bdE3zQ8+4c1oWc8/DtTkvWNb6kFWkyqVR24k1TzMKyHdzmOoia+XA
        la9VB21ydlUxsGAnVgDhfGrdzd512gk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0e645651 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 10 Feb 2022 16:53:46 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id g14so17235490ybs.8;
        Thu, 10 Feb 2022 08:53:45 -0800 (PST)
X-Gm-Message-State: AOAM531n1haBt77sgbtqf1RCWufuUDFs0xWF7w1F7+cdpknif/mEVRLN
        Njp3XZ3M+PgUJaLPK8iqe0rIs2HXdU7titPPZT0=
X-Google-Smtp-Source: ABdhPJwCMMFG+i1LNzluTDJZjHIpbr8E0nvjXPq1nI2720X4xEg/nRWddg0Vbo8FaJgB2MK+quTLffJTV/+bxcqKucE=
X-Received: by 2002:a81:f10b:: with SMTP id h11mr8197379ywm.396.1644512025227;
 Thu, 10 Feb 2022 08:53:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9pc5NRLW4wUy57bqd_gX01PBVoydOQp9Z0rWT+j+fAb+Q@mail.gmail.com>
 <20220210161611.157765-1-Jason@zx2c4.com> <YgVCKjDpuYChCKzu@kroah.com>
In-Reply-To: <YgVCKjDpuYChCKzu@kroah.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 10 Feb 2022 17:53:33 +0100
X-Gmail-Original-Message-ID: <CAHmME9qOSpjzUhwkXoL9OagBzKj51mPr=f-tNNnLCEQsAdWSmg@mail.gmail.com>
Message-ID: <CAHmME9qOSpjzUhwkXoL9OagBzKj51mPr=f-tNNnLCEQsAdWSmg@mail.gmail.com>
Subject: Re: [PATCH v2] random: add proper SPDX header
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-spdx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for the review. Comments are inline below.

On Thu, Feb 10, 2022 at 5:49 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Where did the "or later" come from?  I don't see that in the original
> text.

Yea, this part seems a little bit ambiguous:

> > - * ALTERNATIVELY, this product may be distributed under the terms of
> > - * the GNU General Public License, in which case the provisions of the GPL are
> > - * required INSTEAD OF the above restrictions.  (This clause is
> > - * necessary due to a potential bad interaction between the GPL and
> > - * the restrictions contained in a BSD-style copyright.)
>
> I do not see a "or later" here.

I don't see a "2.0" either. I think we can infer from context that it
couldn't have been < 2.0. So in the absence of a number, maybe this
means >= 2.0, and hence "or later"? Or since at the time it probably
meant 2.0, do we infer this to mean == 2.0? I really have no idea,
which is why I'm glad this list exists.

It sounds like your perspective is that this is == 2.0?

> > diff --git a/include/linux/random.h b/include/linux/random.h
> > index e92efb39779c..1a6861aa1277 100644
> > --- a/include/linux/random.h
> > +++ b/include/linux/random.h
> > @@ -1,9 +1,4 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > -/*
> > - * include/linux/random.h
> > - *
> > - * Include file for the random number generator.
> > - */
>
> This doesn't have to do with the SPDX change in the other file, it
> belongs in a different patch, sorry.

Ack.

Jason
