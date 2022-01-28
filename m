Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A994A03F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242147AbiA1Wty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345913AbiA1Wtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:49:50 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E09FC061714;
        Fri, 28 Jan 2022 14:49:50 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id r144so9571364iod.9;
        Fri, 28 Jan 2022 14:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rowmvAmTTdWPSz3VgnbrOIVvtdQwSdsDvikmta5yHAo=;
        b=Qy4s10w87IGz1C1MmC8ILbMgdGQK5XdJ/X6iw09TQkoF3K3Prp6FCzo69gashLAn7m
         khjO0lWapRbpStleuIl7iDs+jLo5fuY+zl1EVzgtRVMtIV4WIgoWP2aWS0UU9MBFhkdm
         4dGsmqIO99YlTR2XD8V2Gc5TraD2CPVEEitENfdzInS5Z7Vzq9DHbrc+CqNbVItxjHjA
         JzAI/uiFXp0pKciOaekIrN0w5t9gEvL5CA2/+i5zLl9LSrFYXPlPav+QifoFa+k4UWta
         DefmAmMtWcJv7kVWlOhIEdmnyVHAszfE/ZHh0bO4Ms7JLLd1G8t3CyANiQRZRIUUEtSq
         oApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rowmvAmTTdWPSz3VgnbrOIVvtdQwSdsDvikmta5yHAo=;
        b=2JCXJalHnjMzs+zt1i0CIRoZJF/JaRjXdvcttU064uU7exnTKBGMv+/BWIIFTlDh1T
         XheaIjWRX7qCsLyoQU/GL1LJiSURrfVb1pmjSeiRJNpPfWcX6sZBpu4prxWSsmaMXrs+
         ydMvN3vAXW2DRKJmP61CQrAvW4vtVw4Yf1lC6Eh4qMeI7ATX5hh2Lk9Mu2Lk3mV0xeWb
         9ycoQSA28UgtgVj77mkGEnFsAkl0/3gfRRchb3B1aK4344PwWyIEljbwFUqHnWsA+CWr
         5ayGoGgx6znzs7mUMuObHuLmtjmFsWKsc51Cb/jllsaZcYhOrocJSgxlXkUpzSb7Ld8D
         T2RQ==
X-Gm-Message-State: AOAM533ttvQdFvR5m2zGIanFNf0sBiPqTMtk/1HzXrN/lGT9dthcHZSo
        V6CJXFEjuFVGzWdck883KUr3EzKyScq5E0/EV0ABqu5O
X-Google-Smtp-Source: ABdhPJxw16F/gmk8D++UBLYtnI5TtAgL4IZ0ucUn920e0HY7qBSF6GLokFG8hORSpxZ7mf+vBVvQvXXEFxrTNxAD6tg=
X-Received: by 2002:a05:6638:102c:: with SMTP id n12mr5910132jan.218.1643410189479;
 Fri, 28 Jan 2022 14:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20220128144801.73f5ced0@canb.auug.org.au>
In-Reply-To: <20220128144801.73f5ced0@canb.auug.org.au>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 28 Jan 2022 23:49:38 +0100
Message-ID: <CA+fCnZerhcaF+uQM0SLLG0fpGUB2U+LatTReshOMAkz+4Dp35w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 4:48 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the akpm-current tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> lib/test_kasan.c: In function 'vmalloc_oob':
> lib/test_kasan.c:1113:71: error: array subscript 2035 is outside array bounds of 'char[2035]' [-Werror=array-bounds]
>  1113 |                 KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)v_ptr)[size]);
>       |                                               ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> lib/test_kasan.c:96:9: note: in definition of macro 'KUNIT_EXPECT_KASAN_FAIL'
>    96 |         expression;                                                     \
>       |         ^~~~~~~~~~
> lib/test_kasan.c:1096:17: note: referencing an object of size 2035 allocated by 'vmalloc'
>  1096 |         v_ptr = vmalloc(size);
>       |                 ^~~~~~~~~~~~~
> lib/test_kasan.c:1116:63: error: array subscript 2040 is outside array bounds of 'char[2035]' [-Werror=array-bounds]
>  1116 |         KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)v_ptr)[size + 5]);
>       |                                       ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
> lib/test_kasan.c:96:9: note: in definition of macro 'KUNIT_EXPECT_KASAN_FAIL'
>    96 |         expression;                                                     \
>       |         ^~~~~~~~~~
> lib/test_kasan.c:1096:17: note: referencing an object of size 2035 allocated by 'vmalloc'
>  1096 |         v_ptr = vmalloc(size);
>       |                 ^~~~~~~~~~~~~
>
> Caused by commit
>
>   96304a5b9bff ("kasan: improve vmalloc tests")
>
> interacting with commit
>
>   d4e0dad4a0cd ("Makefile: Enable -Warray-bounds")
>
> from the kspp tree.
>
> Since the KASAN tests are doing this deliberately, I added the below
> hack for today.  Is there something better?

No, this looks good. I'll add this change into the next version of the
KASAN vmalloc patchset.

Thanks, Stephen!
