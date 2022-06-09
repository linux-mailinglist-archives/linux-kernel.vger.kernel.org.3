Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E95545616
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 23:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241493AbiFIVBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 17:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiFIVBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 17:01:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61571FA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 14:01:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c4so7815159lfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 14:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4LZi6uXoXAf04ylkz70R28b0LCSIQzk10rMLQpYYnxU=;
        b=IJFJOI4wDiyHohXjZzSfoZMJopDi9LAFFOxMP0hxKvqlA54JQdkXkqf3Xmb42LSMjV
         LSyaDrjZRZlxtcuOJZsoCbYl49FsyZSGThPgsfYKxMLCLdlCZeS2J7PA2nJ1cYND43pi
         5TDZQ8KNqfEKP5sccn2x9bXO5NIjR673Nyxerdn3jfanbcKH4NH2GVZ9tb2eI4nn5dSf
         qAEL3iY4GubJw9gMoPT4GTFTm52Nx6Hl8ceUROfKEmBZgxQw1zx2prsayhbY7KRMLb7g
         uRFmV3KLxGoN+eI/24X7TRkm+PUd7zMTf1BkyjuHBhbVtSSYF0oooJh2qO50y/AMF1Yu
         Zt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LZi6uXoXAf04ylkz70R28b0LCSIQzk10rMLQpYYnxU=;
        b=Ijd8ZTVjuilU54c0jzrL6wcKy+2BxcYjeR6j4BOdzJqiukqt9XKpIv0glUN3li1Uq+
         DzssdX8nsbgppJ9X1ZEQC9SFqGLv/7IWK+lxAaNpqMQy6CO8AGKH23T0+W0kt+HG1Tvh
         5bP7mD4yKTV/rLD1rViYl1XhgL56ugdggC3F2rZT0d25Q77sCkxEx7lrXnLx9VIx3Hlg
         eCDuA+QN6HZ2Mr1doLWefkQt3u4UTssApBsubxdkFR4r0KUnYQhLP/xj2aj3+M0CVIFw
         M4QSzTxVYalsk/1FGyBCERXFoMwM/Vc9KH4yXytuVdempmiTlz9N1zyhlFpmCH6HRBew
         5wwQ==
X-Gm-Message-State: AOAM531keBtya1DsH3fTRWk4C6zxzHjYByi/hTzmAJz+f2V56wdBI2yJ
        TSfKh+hHS1e/rZMDobPbJSXqz6xpk6BkYZ0sU4HQo3rROZ4ySQ==
X-Google-Smtp-Source: ABdhPJxMxQfNyVvbyyxQ0FY3aAHgKV9CAk9O5PPXziHx2dHyjkRw6QZ9YPPp47P544AUT0+wLpWm6uSXt5BXem5yOxc=
X-Received: by 2002:a05:6512:ad6:b0:479:5599:d834 with SMTP id
 n22-20020a0565120ad600b004795599d834mr11546955lfu.103.1654808489773; Thu, 09
 Jun 2022 14:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220609172933.D8187C34114@smtp.kernel.org> <YqJbMzUnzF2WEmU5@localhost.localdomain>
In-Reply-To: <YqJbMzUnzF2WEmU5@localhost.localdomain>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 9 Jun 2022 14:01:17 -0700
Message-ID: <CAKwvOdkV12Wg_dHp-_YDG8eZ3v9y1ssh+hXv9aNNv9rR9=3Gdw@mail.gmail.com>
Subject: Re: + include-uapi-linux-swabh-move-explicit-cast-outside-ternary.patch
 added to mm-nonmm-unstable branch
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        nathan@kernel.org, jstitt007@gmail.com, akpm@linux-foundation.org
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

On Thu, Jun 9, 2022 at 1:42 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Thu, Jun 09, 2022 at 10:29:33AM -0700, Andrew Morton wrote:
> > A cast inside __builtin_constant_p doesn't do anything since it should
> > evaluate as constant at compile time irrespective of this cast.  Instead,
> > I moved this cast outside the ternary to ensure the return type is as
> > expected.
>
> > --- a/include/uapi/linux/swab.h~include-uapi-linux-swabh-move-explicit-cast-outside-ternary
> > +++ a/include/uapi/linux/swab.h
> > @@ -102,7 +102,7 @@ static inline __attribute_const__ __u32
> >  #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
> >  #else
> >  #define __swab16(x)                          \
> > -     (__builtin_constant_p((__u16)(x)) ?     \
> > +     (__u16)(__builtin_constant_p(x) ?       \
>
> This cast is necessary.
>
> >       ___constant_swab16(x) :                 \
> >       __fswab16(x))
> >  #endif
> > @@ -115,7 +115,7 @@ static inline __attribute_const__ __u32
> >  #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
> >  #else
> >  #define __swab32(x)                          \
> > -     (__builtin_constant_p((__u32)(x)) ?     \
> > +     (__u32)(__builtin_constant_p(x) ?       \
> >       ___constant_swab32(x) :                 \
> >       __fswab32(x))
> >  #endif
> > @@ -128,7 +128,7 @@ static inline __attribute_const__ __u32
> >  #define __swab64(x) (__u64)__builtin_bswap64((__u64)(x))
> >  #else
> >  #define __swab64(x)                          \
> > -     (__builtin_constant_p((__u64)(x)) ?     \
> > +     (__u64)(__builtin_constant_p(x) ?       \
> >       ___constant_swab64(x) :                 \
> >       __fswab64(x))
>
> These two aren't? typeof(c ? u32 : u32) is u32.

Correct.

Neither are the casts on the return values of the calls to
__builtin_bswap* in the cases where __HAVE_BUILTIN_BSWAP*__ are
defined. If you want to send a patch on top of Justin's/on top of
mm-nonmm-unstable, I'll ack it.  Or Andrew, you can drop v3 and Justin
can send a v4 with Alexey's suggestions?
-- 
Thanks,
~Nick Desaulniers
