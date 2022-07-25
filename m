Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030295806E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiGYVkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiGYVkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:40:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912436304
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:40:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z22so15616630edd.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Svnq6PTWJvjcH6wB0IJJSE2qfM0IwlvpgRaFDJ1yXKE=;
        b=NfnvoOHSP3zZm7efaO0Dl+FOW25HLaRUx8Kdh3kllWums9Bbs8NUJjkiUnkjUrxIIA
         X9zaEHrUz+7QYLUI3bOPGVcY2IsaQC3L2m+8yJZdgSsR3atszlfcx/eOrCe6eml95156
         0tPNw/SseoshXxPQHrdnKEeulaYkWUoz6I+Kt2NjvM5RQpTpLYa2K+/Zj8zX+7SjW55n
         eoa7Tp4iUtFKqaWV+Lnuu2wsARKRh0RTEeuaICnVMjBPCDkTOAhxO6FiAT6/F99cjc4a
         kPeSnXv2BIa1GcAG0GQvKUZ1E6XH0T0dXM23iSF1ivD8YmQbqtVqV6W5XkX5VJj9yRiY
         8nYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Svnq6PTWJvjcH6wB0IJJSE2qfM0IwlvpgRaFDJ1yXKE=;
        b=U9zt67wWNBzQkke2dS9CifnQUmAutqA/LRUzLdvlRA9lllbWh8EBxvoNCzObqXz1IX
         8l7/AYNlNzBRvXFd2GyAXgHuPUPBol9+Wfzsi+HSgNDNBi0BAK0VwWCKTm43Lz2rhjjy
         ntRsleckcurkIO2bqozFi2gCUxWgZha7zDDjOVcENjm38LQ7gHDAyluGWI0gfEEkcSsG
         H1Bpt2Hjnmel3fQOI1NETdX3UVroRY8BcJRz/vPCFqM8URUTfSYb//aN6xqC7cBNM31q
         pV9zV+SM8PwJVV7mWe0si2SOjgNkV9p3vn7zGKDRkess696y49M08GBOcJ9swQ9Tylhz
         bqMA==
X-Gm-Message-State: AJIora+poK3uhrEyLSIYwkibGDI/xyz4X7xJmoTv6SbXPX3xkufUZA20
        HCZ1zErH6rn098qxJgOhsxxRDe4sLwUUC+Rz6Qg=
X-Google-Smtp-Source: AGRyM1tfLZqgsFiedCHnAYgm5mfZLxKUiXFOh2IH6B1N1Ehfxj/paKwfZXArGLbbYqi2q6DMTJZheAYu5qUNsUJbA3k=
X-Received: by 2002:a05:6402:1768:b0:43b:c4b0:ffd3 with SMTP id
 da8-20020a056402176800b0043bc4b0ffd3mr14933861edb.163.1658785216157; Mon, 25
 Jul 2022 14:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220723214537.2054208-1-yury.norov@gmail.com>
 <20220723214537.2054208-2-yury.norov@gmail.com> <CAHp75VfOmN=cTEs7gbwxZ7W3hXjBo67N4AmHHiDfcVfFzHkMLA@mail.gmail.com>
 <Yt7CJj8r3eo05pKd@yury-laptop>
In-Reply-To: <Yt7CJj8r3eo05pKd@yury-laptop>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 23:39:39 +0200
Message-ID: <CAHp75VcGPQkY9ApsX2fi6sK5=3U=0vKbrHZZ3x___wUtgrFRSA@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: drop dependency on <asm/machdep.h> in archrandom.h
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

On Mon, Jul 25, 2022 at 6:19 PM Yury Norov <yury.norov@gmail.com> wrote:
> On Mon, Jul 25, 2022 at 09:28:12AM +0200, Andy Shevchenko wrote:
> > On Sun, Jul 24, 2022 at 12:19 AM Yury Norov <yury.norov@gmail.com> wrote:

...

> > >  EXPORT_SYMBOL_GPL(pm_power_off);
> >
> > ^^^ (Note this and read below)
> >
> > ...
> >
> > > +EXPORT_SYMBOL(arch_get_random_seed_long);
> >
> > It can't be like this. Brief browsing of the callees shows that.
>
> Is my understanding correct that you're suggesting to make it GPL?
>
> ppc_md is exported with EXPORT_SYMBOL(), and the function is in header,
> so it's available for non-GPL code now. I don't want to change it.

The symbols your function calls are GPL. As far as I understand (not a
lawyer!) it logically one may not call GPL and pretend to be non-GPL.

-- 
With Best Regards,
Andy Shevchenko
