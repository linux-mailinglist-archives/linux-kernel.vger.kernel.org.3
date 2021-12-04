Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969834684EC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 14:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384986AbhLDNGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384979AbhLDNGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:06:11 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45E0C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 05:02:45 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bf8so11624526oib.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 05:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lyigg/kQTcXu3DryHRQI8jWfLSbo71uYv1o0gch+DEY=;
        b=qRdO1zp5BPGwqGT0v4KeMXaK8sS26rd0AqvL37ZiiwXXKUDzrkoT+W8oZRr47RFI/B
         /qT3XAN/yDQ4GzYa1LLV/7b334EOXWH0Q0uRx19CG3c9m7OaeYbVgmcLzziF8cOp637A
         aZt7lGJj8W0tPaP3ciI4vXkHaQnrbrK7Aylu8+DqjvM7sBpRTX7pF8FxNXU7xiQ4VUNH
         phBdEMxyT27QwjQxEKdYVXxb13SNnhNaM6zAYkI8aSzlusQSPNPO6suJWoW8lBe+0leR
         mrwFprEr3S5G5v2sO9W8I45wviQOO4/zNyXQTNy/v1YEt16cKlQ4ENX6/a1/sREkRwdu
         Fhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lyigg/kQTcXu3DryHRQI8jWfLSbo71uYv1o0gch+DEY=;
        b=M/4PKzEkw2NxEMEQEaFt717vlG4Q3VJ3OnwyBcR9hLVg7EpSP+u2tc5R2dLH820iCj
         kgyyTFxxc3jRpyYa4S+stOLgfQoUsWSgaYfPO5gumM1yptEytCrCJz9FWiMgtHLnMI0w
         aU5Gua91SWn4Bgq2lyAoXRrQJQFlyWzq5FMxWCUjQwG5ljr3y4Wd0q1boZLH7eLCxR7a
         HBOERIPEICJzhJHi7ig9ZKT4x7lMXzd6gbg/1+KXMWBRzm3uS/uz0KVFQ8jvXV7txWhC
         kExhIZNdIeeTgf5VX64DJ+7M79CInWvxPlkuOnmqDfwHQ6avkzderuI9XNXFVWI2o23p
         OUyQ==
X-Gm-Message-State: AOAM533JBQhtOemShFZk1k9cBhxyd73gdpsp7evHVjOS8R/DUwEh0nRT
        WMpqhcu7GyadPFa6hGh2iAhmAmdNPM4C4euamxs9zfwTGA827w==
X-Google-Smtp-Source: ABdhPJwH+JtmdokSYQHfLLjwF1956RPrvjJQytOqUO62TnAptmUZZyirfPRY3vgij3zysw8DlQT7WxMLwICyEoZWAOo=
X-Received: by 2002:a05:6808:1903:: with SMTP id bf3mr14948150oib.7.1638622964883;
 Sat, 04 Dec 2021 05:02:44 -0800 (PST)
MIME-Version: 1.0
References: <202112041334.X44uWZXf-lkp@intel.com>
In-Reply-To: <202112041334.X44uWZXf-lkp@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Sat, 4 Dec 2021 14:02:33 +0100
Message-ID: <CANpmjNOpoYrgk85hsOroh67TqUPtawWCnbk1GwqdUnGEKrOP+w@mail.gmail.com>
Subject: Re: [paulmck-rcu:dev.2021.12.02a 31/43] include/asm-generic/barrier.h:70:30:
 warning: 'kcsan_rmb' is static but used in inline function
 'pte_offset_kernel' which is not static
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Dec 2021 at 06:33, kernel test robot <lkp@intel.com> wrote:
[...]
> >> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pte_offset_kernel' which is not static
>       70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
>          |                              ^~~~~~~~~
>    arch/alpha/include/asm/pgtable.h:303:9: note: in expansion of macro 'smp_rmb'
>      303 |         smp_rmb(); /* see above */
>          |         ^~~~~~~
> >> include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
>       70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
>          |                              ^~~~~~~~~
>    arch/alpha/include/asm/pgtable.h:293:9: note: in expansion of macro 'smp_rmb'
>      293 |         smp_rmb(); /* see above */
>          |         ^~~~~~~

I had been wondering if barriers could be static __always_inline, like
we do for atomic_t operations. Apparently this answers that questions.

This should fix it:
https://lkml.kernel.org/r/20211204125703.3344454-1-elver@google.com

Unrelatedly, I wonder if I can get the test robot to also check some
of my branches:
https://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git/
That'd be very useful, to catch things like this early, and avoid
disturbing Paul too much. :-)

Thanks,
-- Marco
