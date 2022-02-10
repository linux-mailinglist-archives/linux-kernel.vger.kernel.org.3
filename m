Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3404B13C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244962AbiBJRBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:01:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244255AbiBJRBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:01:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695DCB89;
        Thu, 10 Feb 2022 09:01:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02C3661006;
        Thu, 10 Feb 2022 17:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B830C340EB;
        Thu, 10 Feb 2022 17:01:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ddW9PE2t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644512490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MVDF3xN6NsTNRNKm68HWD6KwsyOvfBrndaVFflx7sXI=;
        b=ddW9PE2tUtvuzN34fFfwVMfOXAssokNW+j8tYyQa2U1k55OsDnXAX6qNqQ4cUMPYu0jcBy
        A6lKa9kzWm/RrT0hgFKqblCPcLWQMNcIupZ9xN3CnEjHtvrpiwQqx/AQl8XWz9vaT0Nmex
        YEne9Ld2hhFUfaHQ+bFioX1uY8ipcfs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 07dcea9c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 10 Feb 2022 17:01:30 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id v186so17390878ybg.1;
        Thu, 10 Feb 2022 09:01:30 -0800 (PST)
X-Gm-Message-State: AOAM5306/LwotGKaXuTel1kx+o/Hm2VYjTHs31ksgwMiD57YHbTSp2gO
        sciHe4VJyPIB/ra3iWjEF2oBhEshNEwe+fVPP1w=
X-Google-Smtp-Source: ABdhPJyWTqoLfCExrTvbsQXmYvr0FqU7oQdUq/REw4f145s+uBHoDeGdC/xeAhfChdGqDLDEca2BhOZ11UUA06FND8c=
X-Received: by 2002:a81:c40d:: with SMTP id j13mr8387844ywi.499.1644512489276;
 Thu, 10 Feb 2022 09:01:29 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9pc5NRLW4wUy57bqd_gX01PBVoydOQp9Z0rWT+j+fAb+Q@mail.gmail.com>
 <20220210161611.157765-1-Jason@zx2c4.com> <YgVCKjDpuYChCKzu@kroah.com>
 <CAHmME9qOSpjzUhwkXoL9OagBzKj51mPr=f-tNNnLCEQsAdWSmg@mail.gmail.com> <YgVEsotBkXVPknAK@kroah.com>
In-Reply-To: <YgVEsotBkXVPknAK@kroah.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 10 Feb 2022 18:01:18 +0100
X-Gmail-Original-Message-ID: <CAHmME9q5uExD5bUdPscZn6mKQYnf80YPq=KqCk8XYuH1uXpS6Q@mail.gmail.com>
Message-ID: <CAHmME9q5uExD5bUdPscZn6mKQYnf80YPq=KqCk8XYuH1uXpS6Q@mail.gmail.com>
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

On Thu, Feb 10, 2022 at 6:00 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 10, 2022 at 05:53:33PM +0100, Jason A. Donenfeld wrote:
> > Hi Greg,
> >
> > Thanks for the review. Comments are inline below.
> >
> > On Thu, Feb 10, 2022 at 5:49 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > Where did the "or later" come from?  I don't see that in the original
> > > text.
> >
> > Yea, this part seems a little bit ambiguous:
> >
> > > > - * ALTERNATIVELY, this product may be distributed under the terms of
> > > > - * the GNU General Public License, in which case the provisions of the GPL are
> > > > - * required INSTEAD OF the above restrictions.  (This clause is
> > > > - * necessary due to a potential bad interaction between the GPL and
> > > > - * the restrictions contained in a BSD-style copyright.)
> > >
> > > I do not see a "or later" here.
> >
> > I don't see a "2.0" either. I think we can infer from context that it
> > couldn't have been < 2.0. So in the absence of a number, maybe this
> > means >= 2.0, and hence "or later"? Or since at the time it probably
> > meant 2.0, do we infer this to mean == 2.0? I really have no idea,
> > which is why I'm glad this list exists.
> >
> > It sounds like your perspective is that this is == 2.0?
>
> Without a "or later" it has to be "2.0" as that is what the overall
> kernel license is.  That's what we did for the big SPDX sweep, so that
> keeps things being decided in the same manner.

Sounds good. v3 incoming.

Jason
