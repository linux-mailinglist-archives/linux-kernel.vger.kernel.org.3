Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7704952F161
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352093AbiETRP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244060AbiETRPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:15:24 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AA3185C99
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:15:23 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e15so9394375iob.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5q9k0da/eVXDTkiJGcgonVdoXFkBjK7hd3VFbFH4vhw=;
        b=czMMupnbSKq4FnJ6sDpWiqRxFmJNvDaZBwGxehqUu02wRBpq48pknNWwA9UzJhsewy
         wHP+g3IPKf+q9B0oB/aI6NMcW3WttDfC6FB9PWRyaijEXBGFcuOQn3OVAWiWKko6sara
         9ehbvUgZyXmcU0izNXqjsYUhW0HOXH1LO+V0tqWRf+LDTyRik3agsLvqif86yLhFIRCk
         yiNMWyViQKeWOVWIHik6Naa6jyT7QJbCOyBr+GCbJBVfhu+/0v9VCv4v4Q3mtTEEK6r8
         kUswfiqgjeCEMA+KYRo03+9xuNlVDxz+m6yQc2YiUko1RorVhb9b6g1YQOy4O5XyD58+
         FQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5q9k0da/eVXDTkiJGcgonVdoXFkBjK7hd3VFbFH4vhw=;
        b=tlGe8rtjYcPGOrRrObS1PanF52qUpyI1hbRvbP/RjWRxrUnoZ9HgIN8V2G93lCtaS5
         9q8oDuMUg5Eqhd9g2D1dJ75RKjbucVhnO7PNLeD862N2GBE6js69CqaRqA5yt5miKjYP
         wfbBeNw17G2uXsahkZPztDZcCmH7xhjB9ytgYzbUfo36sdSswoDp69PscSPy/hXh65fH
         ybosdb4RJ0LqnCLEUA7lGU5VW5bcC34bwlQahcD9IBtVMVtY/inamN/B0MJ6IEzQfeSQ
         61HG3Nq42qhiB2dukjViN/XzuXyTYN6ZS3jhAJccxC8v997mVrn62HVAOgc/uQaQ6PbE
         KJzg==
X-Gm-Message-State: AOAM5331qXFTtRsnDrCf/x8rGK7k3K0DsKvlyiwh9/cGQOVcfjyBlqpC
        mgWvvw5U2aS2nv8wllZPZ0vuGukQBj5PeCv5vhZp+o1+
X-Google-Smtp-Source: ABdhPJz3POU7VbsuvrNoJkvEZ2aJ7n8c9GU3fPmcEACUCVCqqHtueymxozFHYnQ75CSj/2qO50Amq834K51+YvQakYY=
X-Received: by 2002:a5e:c643:0:b0:657:b1b0:8e2d with SMTP id
 s3-20020a5ec643000000b00657b1b08e2dmr5374422ioo.64.1653066922765; Fri, 20 May
 2022 10:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220506160106.522341-1-mic@digikod.net> <20220506160106.522341-5-mic@digikod.net>
In-Reply-To: <20220506160106.522341-5-mic@digikod.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 20 May 2022 19:15:11 +0200
Message-ID: <CANiq72kbp3xTpj-L2BfLQ1Ecx-2Ki0W3e5YLERx8-T9bjb96=g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] clang-format: Fix empty curly braces
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Brian Norris <briannorris@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>, Tom Rix <trix@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 6:00 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
>
> SplitEmptyFunction [1] should be false to not add a new line in an empty
> function body.  This follows the current kernel coding style.

I don't think this is correct. Checking headers in `include/linux/`, I
see ~70 using {} (when not in the same line as the signature), and
~700 in different lines. In `kernel/`, it is even more pronounced: 4
vs. ~200.

Am I missing something?

Cheers,
Miguel
