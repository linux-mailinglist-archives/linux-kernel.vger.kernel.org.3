Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E9D581689
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbiGZPfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbiGZPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:35:45 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E96BE38
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:35:45 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o21so11200782qkm.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CCRjnPDhR1jbGOCTVOxFGi28TPaJFDcjNhwmtedydJg=;
        b=NwJ7SE8ij3MowuZINcHhVTnm+z2gziKcTcnXqSjx7esh99Q/9vFU4Pqxc6ESEB/ePM
         vZoqKGBeMDaRS0GnzZsRId/vEMB3uOD2fZJNftUMLXG6YQ574uW1S24VX93PWxLtcuHS
         JtY8XEiYpsdwRl7OLWd5OKXGNpSZjMrnvcMMh6MYBSTGUQYmQSlgs4K3TomFwLhXUal0
         PR4MbFAsW5oxJQYtnQuCXuPyjHVatihBuzZX260aZ10pFx5FZRwHegtAXon2WuNmweMv
         vM7Ge/cX/W/ELp8hHs7VjEbPhpi6Ek+PBxd/g5gTnBLxLzE9Hz62DBLuKc9u+stCxYGb
         j4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CCRjnPDhR1jbGOCTVOxFGi28TPaJFDcjNhwmtedydJg=;
        b=kCZSCmLRnZbs94o4mqBGlCIa8G/i7fdB6oIcEfKMi5pmY4jsgo7hGwtmiGth5LGphw
         oFwQgSQA0qUuy4OLbD7RU8vWMOIxF14Y9ADtyArZ6vIjjiFaVOlLRFdlcOaxKzhAmMvu
         3VXlhvCw0484sj3l6PN/kAF+vLLcSuMpxKkbWF+rVRZupo7eiFsbK0y/EBkiMMS/4i0b
         xYIE39nUodUP0+2O9NNOJzW3Uw3UHtDfJIL2qa2W/8L1XjMx7XauE/7in6Vf4mvNb4N8
         3e2Ox1wReofoU91I0PmX7YU7QeyyHBedgxm4KTQC9jA+dg5RyEZ+6upfNyvjLkTDGysD
         RP3w==
X-Gm-Message-State: AJIora/iJVW9i/DQgPXvXHHB9OI4BhQUwY1Zaa0gO02eJe6eMrx9gnrr
        uFN/UHMcXZrdRBl6fqthXXQ=
X-Google-Smtp-Source: AGRyM1sJBkt9P2/IG7NzdM5ZIgaqkq0AxV7QnBKYHw/tHLcE7ldmwYgBXWnfAU9ZGtKECJ/pPgyvAQ==
X-Received: by 2002:a05:620a:4483:b0:6b5:d373:dd02 with SMTP id x3-20020a05620a448300b006b5d373dd02mr12780406qkp.409.1658849744064;
        Tue, 26 Jul 2022 08:35:44 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.fl.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id a4-20020ac87204000000b0031edf8d57bfsm9242730qtp.46.2022.07.26.08.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:35:43 -0700 (PDT)
Date:   Tue, 26 Jul 2022 08:35:43 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.19-rc8
Message-ID: <YuAJzyxRiwhtSqDj@yury-laptop>
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net>
 <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
 <Yt+v9brPqxun0nhA@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt+v9brPqxun0nhA@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:12:21AM +0100, Russell King (Oracle) wrote:
> On Mon, Jul 25, 2022 at 10:55:18AM -0700, Linus Torvalds wrote:
> > On Mon, Jul 25, 2022 at 9:11 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > BUG: KFENCE: out-of-bounds read in _find_next_bit_le+0x10/0x48
> > 
> > Ok, I was hoping somebody more ARMy would look at this, particularly
> > since there is no call trace beyond the actual fault.
> 
> First I'm aware of it. Was it reported to linux-arm-kernel? I'm guessing
> the report wasn't Cc'd to me - I can't find anything in my mailbox about
> it.
> 
> > I think the fix might be something like this:
> > 
> >   diff --git a/arch/arm/lib/findbit.S b/arch/arm/lib/findbit.S
> >   index b5e8b9ae4c7d..b36ca301892e 100644
> >   --- a/arch/arm/lib/findbit.S
> >   +++ b/arch/arm/lib/findbit.S
> >   @@ -83,6 +83,8 @@ ENDPROC(_find_first_bit_le)
> >    ENTRY(_find_next_bit_le)
> >                 teq     r1, #0
> >                 beq     3b
> >   +             cmp     r2, r1
> >   +             bhs     3b
> >                 ands    ip, r2, #7
> >                 beq     1b                      @ If new byte, goto old routine
> >     ARM(                ldrb    r3, [r0, r2, lsr #3]    )
> > 
> > but my ARM asm is so broken that the above is just really random noise
> > that may or may not build - much less work.
> > 
> > I'll leave it to Russell &co to have a tested and working patch.
> 
> I think it needs a bit more than that, but as you point out in later
> emails, the compiler may do a better job for this.
> 
> One of the reasons for using byte loads was to avoid problems in the
> early days of Linux where these took void pointers and thus could be
> misaligned - and using word accesses would have resulted in much
> pain. However, that was changed to unsigned long pointers back in
> 2017, so in theory that should no longer be a concern.
> 
> I don't remember why we used void pointers there originally - that's
> something which dates back to the 1990s.

OK, then I'm sending the patch that switches it to generic code.

Thanks,
Yury
