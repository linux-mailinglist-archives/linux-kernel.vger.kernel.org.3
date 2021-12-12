Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D90471C8E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 20:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhLLTai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 14:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhLLTai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 14:30:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0540C061714
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 11:30:37 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so13173689pja.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 11:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uHFphg5cxl9eHx+EM+ayhZRLUX15gEzneKCxjSJWVNc=;
        b=atO3zjkadP5BGnoJZKa+jVrckytkN0sEjwUFaB2f01w6x8zbgy8j/+weAfhlOmPHiL
         aVj2KSLyZxmrlRWsdtTGxT36hrGdBbvn6Lz5I4JJZKHRMZ/Uhp+TY3dLCSzLNPZ7gGiQ
         LqoyVVhhH/tWWHazEMp7uzDQ2E2KHzYNxrIMRAC9RGrV3m7J+vyyyHg1knwjGCvgERAa
         eviLH4PDS7JyN5dPBAoNVznIjDQnj9l7y+aMBFPlrMCgazYHha5EyJxaSyY/4j3UxIX9
         +LkgUk85Wcg7OmiqMSLHrQ0aeQ0XKq5IFUhQ948w8m/8lkPvQk2JNDPSuJOczTN+pl85
         CprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHFphg5cxl9eHx+EM+ayhZRLUX15gEzneKCxjSJWVNc=;
        b=AUhMOB6emXnTG7qu9poFXO8QMKteYcg6bf2XdpqQyeSNpDzadw5/t09VMAYa4uh9aC
         YZQxY7Th09mWD9M8H2hWtLxMFfv6qiLBGDzHqLJP1y8KXqKMlfkg+HPMHPfZW/5wrqUv
         RPL05zE8tGvPCheAbATpzuQFJYalHOSLKS/T55rhnPP5zti9d8H5L8GGczkFA0Z8V2sf
         JtAKsq+y9q+KNc8JnD2+mJ7+K8gH8U5DmueVE8n6UOTtNdhCYAJCJVhSBG9q18fAZrK4
         uEdi1rXbnSm+f1YtoI2NV3xBOg1YIZHh2FSbjGwjyzhn2ef1krzr0vDNBzCx0me7o5Qy
         WTWg==
X-Gm-Message-State: AOAM532uks52t1RpSp3bjULdrNP0PflKQ7rg8yJM9gyzV5QxInFc1BVw
        B//H05ElqmmY+SXQ5wBHIvbL4RvQOBzymWlxbOw=
X-Google-Smtp-Source: ABdhPJxQzS8hVJ0AYMHVxdh0cY0L8hVYy6/U95MBITk75g3JQI7JmApEOGDDpZSsc2jan577YXnozd/CPh1jKmR7Nk0=
X-Received: by 2002:a17:902:904b:b0:143:73ff:eb7d with SMTP id
 w11-20020a170902904b00b0014373ffeb7dmr88504763plz.85.1639337437247; Sun, 12
 Dec 2021 11:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20211211173447.4155374-1-hjl.tools@gmail.com> <CACVxJT-k664=aYp4VkG1LH3PsGHEf50PqP5EA+JWiFVb_JVs2Q@mail.gmail.com>
 <CAMe9rOqM+S_uBO-t5jJ1TLVD0R-LOJEiR6htb+k05c+ak7gF-g@mail.gmail.com>
 <CAHk-=wiEgwj3DGZai2GF9+z-FCSS455kGZ9z2g1qtdPLPWpvxQ@mail.gmail.com>
 <CAMe9rOqYxiMabie_2LN2mTTP7QPa0_mfKwDY10OSzKFj5GYT7A@mail.gmail.com> <CAHk-=whPK-aB34T1YS4CVK0G1m6QU7FZg28+oEeVaGy-b4hZGA@mail.gmail.com>
In-Reply-To: <CAHk-=whPK-aB34T1YS4CVK0G1m6QU7FZg28+oEeVaGy-b4hZGA@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Sun, 12 Dec 2021 11:30:01 -0800
Message-ID: <CAMe9rOoqkH=FL3s331YKeyz_Qjf7pR9M_Cf117XHErrTU-2iRA@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: disallow zero entry point address
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 11:15 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Dec 12, 2021 at 11:06 AM H.J. Lu <hjl.tools@gmail.com> wrote:
> >
> > According to the ELF specification, zero entry point value means
> > there is no entry point.  Such ELF binary doesn't conform to the
> > ELF specification.
>
> Nobody cares about paper specifications.
>
> All that matters is REALITY.
>
> So let me quote my email again, since you clearly didn't actually read
> it (read that "maybe it's not supposed to work" part):
>
> > That's not my main worry - what if somebody has a code section with a
> > zero vaddr and intentionally put the entry at the beginning?
> >
> > Maybe it's not supposed to work by some paper standatd, but afaik
> > currently it _would_ work.
>
> I'm not sure this can happen currently (maybe all tools effectively
> make it so that the ELF headers etc are part of the loaded image).
>
> But no, paper specifications have absolutely no meaning if they don't
> match realty.
>
> And the reality is that I don't think we've ever checked e_entry being
> zero, which means that maybe people have used it.
>
> So convince me that the above cannot happen. I'm perfectly willing to
> be convinced, but "some random paper standard that we've never
> followed" is not the thing to quote.
>

On Linux, the start of the first PT_LOAD segment is the ELF
header and the address 0 points to the ELF magic bytes which
isn't a valid code sequence.

-- 
H.J.
