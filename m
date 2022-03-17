Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF944DCD51
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbiCQSNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbiCQSMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:12:53 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E29E21A8A2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:11:34 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id r22so8339079ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GvRtkI+aajtqCy2c1b2F4MUYD+uMLWJPyiKwyzY7fBQ=;
        b=hne5dkL1r66jaWeZwLdqsQWeaYzLA0jCNqUeaPeX4MK0bcpogrmJFtTsAHSYPHTv37
         F31NNlIDn9bslKYtcs9T7Ma0331NI3pAKkY7Smg4Njyl7fKErwUzZLR77VAJgDJGt60n
         8yoAF2gzIx0ez9xH7e1/L5DkEJjrMCAG7htDNgWR4IVaW+tvIGLmwLqztCBKJVgv8JNg
         9J29bhh2X/xEUKQYCshpyqmTT6OTC0cbzKTXSYQzOMHmhryjwsJyMrPUTkPxAl/m9Ng8
         HHfV7rzkYosyidu3QWTr29KI54SAqAdUXPgypkWcpypqbuGZSPra+xml3A+fuJpxtgBF
         iU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GvRtkI+aajtqCy2c1b2F4MUYD+uMLWJPyiKwyzY7fBQ=;
        b=7P2lJvBcia2pJ0z13ErEOaU0DFko2ocv0bw74WCHmC+HMo6GJnmGkHn4MUlqZsCBUu
         5BA4ZlC6Yj/pRpzUheHGnqpoLsHNFqHd3F6zK23yOptxCPscB/GqwbChm/DOkCtuYiX8
         cfcoJfjL1ayYYXVWSF4jNnmd4tnTcxQ9tS6eExwQyPxnPfRA+Jh6+z6+94sT5Mnb7aiK
         PG8b4JiSvJgostH68C97OSBXd3l8hr2x9sQjNYc1kjBnwUEHvwwbjQ2lQNugvoalkUbU
         UoGabzKkDlMI9BW23B1XLKG7G+Xm6iehBiTK+zYtW4j0/x6CeDLqaugvyVZd2wuF9jzM
         krRA==
X-Gm-Message-State: AOAM532jtq/CP08pZio9awq0w842p2cinWl0dC0hAbyPkNHZbZI23phI
        Qr+GZqHytGFNSasT/1jq5WJGZKgLrvrqm0kf/gFiPw==
X-Google-Smtp-Source: ABdhPJw321RYGnd+eSI0h5Spru1PQ/7vVF+BX9Nro0IcXN12RAcPjoehXMVZPqBvuitiGJFoQTKh96/tVTcy8uPYIkw=
X-Received: by 2002:a05:651c:1791:b0:243:94bd:d94c with SMTP id
 bn17-20020a05651c179100b0024394bdd94cmr3596248ljb.468.1647540692501; Thu, 17
 Mar 2022 11:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213055.2351342-1-morbo@google.com> <YjL6K49CkH+YC4FQ@smile.fi.intel.com>
In-Reply-To: <YjL6K49CkH+YC4FQ@smile.fi.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 17 Mar 2022 11:11:21 -0700
Message-ID: <CAKwvOdkjb3uR+kqjfdKL5gqA8R+00c5=3E7uGGW+mGZ3QRsjqg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: use correct format characters
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bill Wendling <morbo@google.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Thu, Mar 17, 2022 at 2:07 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Mar 16, 2022 at 02:30:55PM -0700, Bill Wendling wrote:
> > When compiling with -Wformat, clang emits the following warning:
> >
> > drivers/gpio/gpiolib-acpi.c:393:4: warning: format specifies type
> > 'unsigned char' but the argument has type 'int' [-Wformat]
> >                         pin);
> >                         ^~~
> >
> > The types of these arguments are unconditionally defined, so this patch
> > updates the format character to the correct ones for ints and unsigned
> > ints.
>
> hhX specifier refers to unsigned char. It's a bug in the compiler.
>
> NAK.

Andy,
Our goal is to enable -Wformat for CC=clang.  Please see also:
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
unnecessary %h[xudi] and %hh[xudi]")
and the lore link it cites.
https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/
(I saw your follow up; this patch is one of the less controversial
ones though since the types are not ones that are promoted).

Bill,
I just remembered that we will want to explicitly set
-Wno-format-pedantic when enabling -Wformat. Remember that -Wformat is
a group flag that turns on other flags, such as -Wformat-security
(currently disabled) and -Wformat-pedantic.  See also:
https://reviews.llvm.org/rGcc01d6421f4a896820c02da2ea92b82d973b431e
commit a8735821d198 ("Kbuild: Disable the -Wformat-security gcc flag")

It may be helpful to cite
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
unnecessary %h[xudi] and %hh[xudi]")
in future commits that change the format flags for types that are promoted.
-- 
Thanks,
~Nick Desaulniers
