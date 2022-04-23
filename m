Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EFE50CC3E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 18:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiDWQSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 12:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiDWQR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 12:17:57 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA6F17AA5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 09:15:00 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h83so11568357iof.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IMQZ2RLXAtmsjlcoyG1Ejf9thK9F6e9b1RJe6akdKmw=;
        b=F2azqWjRMT5A5DXNcKJVPvoYcI5e4vIH72e9V0gpj4ILsmdTzCd4+hWO6cJAIshNqg
         M0dLDn9RDNJpvKGd4qZ7ueOIEr4wwpSlAKAXE7rOdUmdTZvx/qVezJCC7W50F9heSVtL
         dnSb1jSNqh6sRcKtjsB2eNbnUlNDzqCoBpEdds/oL1w268tqEbItfNzMHqaqd3HlPQlM
         gDxW5pI/LJlKFxyv42SOU2P04Zo64CgdTVf1otFndIZGvK5GSFzL4jhJBnqWG9G+ZwkA
         Zoi6y0nSq2x/EeA4AEkB6wWnSofvmbvhjG3Xi/KNofvEnW5+Gz6u+kW3rnfp/HaAuCcB
         HfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IMQZ2RLXAtmsjlcoyG1Ejf9thK9F6e9b1RJe6akdKmw=;
        b=cTVSB84jDCQuVAKd1rGUl1GpJ6lBkOPpXrcVY5uOT4Oesa08zQmewe+Wph8IHUlAo6
         FohBip+4syc1JN+Fx1hCcZF22mBTQskfe+X21qdtDkM9RrIN9KHt2Gyfir/fHllm+jNX
         mKux24MMsSIgz2LKMnhff3hZwGOMfHJmRlbjSh1MSmfroGJSSaPImx8VHFLFnD02+fcl
         LyvA83OpzEFsA/+vdFkIA1k0bFFYt0K8r0nh6hpReA/jh0famwuwYOD0XckwXfMnYIU3
         xx7Uycbzdieu/AXcBOWwgSQSjk82ENlXSvhj8vX57uiQjLI/4w40zTXEM3IqMC8O3os4
         BaIg==
X-Gm-Message-State: AOAM533jVBClZAdzdkzxIpSrhcbh0UmVwaHGIbIvCELlCnpMrrJYHpMr
        lxqCk5EETKMIdLGtYpM6EjI3wRTXkfJ16N7MasY=
X-Google-Smtp-Source: ABdhPJxSZpeLH6HLwirF8fz6+F1sM0b9Mk/frQ/bSyt5u1eWasmDJCTDy81yS1/GWLNKUud7CFz3Ispq9cRSoyEWbvU=
X-Received: by 2002:a05:6602:1341:b0:637:d4dc:6f85 with SMTP id
 i1-20020a056602134100b00637d4dc6f85mr3903365iov.155.1650730499411; Sat, 23
 Apr 2022 09:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <8b6b252b-47a6-9d52-f0bd-10d3bc4ad244@digikod.net>
In-Reply-To: <8b6b252b-47a6-9d52-f0bd-10d3bc4ad244@digikod.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 23 Apr 2022 18:14:48 +0200
Message-ID: <CANiq72nLOfmEt-CZBmm2ouEB_x6Jm9ggDVFCVJxYxKw7O0LTzQ@mail.gmail.com>
Subject: Re: clang-format inconsistencies with checkpatch.pl
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Micka=C3=ABl,

On Sat, Apr 23, 2022 at 1:45 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> I also noticed that there is some clang-format configuration lines that
> are commented because of incompatibilities with versions older than 6.
> Shouldn't we require a minimal version, at least the 6th?

I will be increasing this cycle the version to 11, which is the
minimum LLVM supported at the moment, and then keep it sync'd to that
minimum.

> About checkpatch.pl, it incorrectly warns about space between function
> name and open parenthesis for *for_each* functions (specifically
> interpreted as "for" statements in .clang-format, e.g. list_for_each_entr=
y).

Note that the prevailing kernel style is to not have a space. This
should be fixed with the increase to 11.

Cheers,
Miguel
