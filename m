Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F5522243
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347927AbiEJRYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiEJRY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:24:29 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE2F268652
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:20:32 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id 3so8838125ily.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qBpP6H1QXIcItowN4taveL7xKKbFDSnKJ/RJbBSFPLc=;
        b=Lt7mUYnnSclD1NWgc2asYmgfRPG7Azod9mS1i2Jh8ultjaohoNhp9mUqvPMvwKfeFX
         +3lH2aXb4zAOEjHUEIh/QVpMfpb9lKwD1l33mRtYpWmJOuh9xpwJWcEVBzirx6yRiesk
         WDtra/VPQTon4LSEOjPwOfjDj5UL5OodfpB/IY8DYaUQSBbceMfgj7BfdTiPDcbWkcll
         t5vePG3fWKJma1cjQnbkPeCrEoMcTseLIfxwK+ZqjFpnr0DHujza42/uicb0xoV9VzGW
         pTeZVOaE5ChLPaILdSZp6y/jgaoW5QXbz0KwNageXa1xo4t9su4rAvd/x9qBn+UIntVt
         3dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBpP6H1QXIcItowN4taveL7xKKbFDSnKJ/RJbBSFPLc=;
        b=XcdGTK5NSZrP8BRWtIvbxicU8U7aQ8CnFkpBye5ssuBbPW8Du7LnlcF+aWY13q2y2a
         6ejC20kbazbn5t4ShFSPJkRf4aSoj9GDuJBVApE9VGkgoQoR1M/YlXgv7Gws/9rbbCjS
         X3NEgOxwGc1+KXWjTzYxcsYXbHnT2Ih20YJIsvvDelQgacNfDrm/JpuJBfdntnMZBbr8
         wUQbXdeQYPZozHVa4aFYi3g6HZCze4WcZgpXX/gNVw7pzBCAcBebQzWNMRULAPY7JgnS
         xX+YWFGF+PlqjCVVn1DkuG7A/QOzZc2E39luBaTZX5iYn0vWlOhmuDqzYBe/oFGWYqBb
         hjPw==
X-Gm-Message-State: AOAM533z9cATzjlHLYepb6GFRftUb1A4IR/PjDIc8tZ8CRb4y+uWBY+m
        ygBLRkubTTzo9KS2//e7lwjqTCIlKO5ylYyHkYg=
X-Google-Smtp-Source: ABdhPJwf74Pk1zAv2/dFYx/EPtp9CNrSoRlsl9nMcl48xPvVRkR3cgKz4KPOSlSBn0J9kL7SbZSWcNRZLopRSf3Quhc=
X-Received: by 2002:a92:3609:0:b0:2c6:3595:2a25 with SMTP id
 d9-20020a923609000000b002c635952a25mr9876403ila.233.1652203231521; Tue, 10
 May 2022 10:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <5bd58ebebf066593ce0e1d265d60278b5f5a1874.1652123204.git.andreyknvl@google.com>
 <47afaecec29221347bee49f58c258ac1ced3b429.1652123204.git.andreyknvl@google.com>
 <YnpTJR177vJ5G+HW@elver.google.com>
In-Reply-To: <YnpTJR177vJ5G+HW@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 10 May 2022 19:20:20 +0200
Message-ID: <CA+fCnZcCOFR-E_HFjgpz1GqPbtnothC1+cTK6Nu2fOua_1-iuQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] kasan: clean-up kconfig options descriptions
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, May 10, 2022 at 1:57 PM Marco Elver <elver@google.com> wrote:
>
> > -       Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
> > -       (the resulting kernel does not boot).
> > +       (Incompatible with CONFIG_DEBUG_SLAB: the kernel does not boot.)
>
> Why aren't they made mutually exclusive via Kconfig constraints? Does it
> work these days?
>
> Either KASAN_GENERIC and KASAN_SW_TAGS do "depends on !DEBUG_SLAB ||
> COMPILE_TEST", or DEBUG_SLAB does "depends on !(KASAN_GENERIC || KASAN_SW_TAGS) || COMPILE_TEST".
>
> I feel DEBUG_SLAB might not be used very much these days, so perhaps
> DEBUG_SLAB should add the constraint, also given KASAN is the better
> debugging aid.

They are made exclusive: it's the KASAN option that depends on
!DEBUG_SLAB. And KASAN_HW_TAGS doesn't have this note, as it doesn't
work with SLAB at all at the moment. Moving the constraint to
DEBUG_SLAB might make sense, but let's keep this patchset as a
non-functional change. Thanks!
