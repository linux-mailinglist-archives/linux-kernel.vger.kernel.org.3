Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59839590673
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 20:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbiHKSjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbiHKSjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:39:31 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9602594EF7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:39:28 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z20so20176801ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=uknUURtTflTbQ0gGtXa6dIUydyF1mi0HrKwpU5X0dRk=;
        b=YXoXLAzBSz8OdrWcHCDDkhCNBRWKN5NiX8gPHmU+9yseVsP5YoszwIF1rg0pbrQ5xf
         peyfnkEKdmld8A3zk6kBFlMgaOKYe0DyBgVIMjvj2HgW3jREWU5T3u6ri8aGmF2yyWPp
         tOWubduW5HGIsenv44TykOYICvcA3O99J1vNlBlh0tzsDyZYBUAdR6y8VWZJ8IyWy3a2
         Y6XqDr85iUvT1UPpsh9/M2hYA7bJO5ueruWL2v7dWANn84+1W8kxg//M03Y/Df7EkXnB
         smtD4NdOgDF3QwzhzoLZhfbFhL16YL011jcxfSZecBJ08PvXnqhg8Whu5WpopdkZSNjF
         yCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=uknUURtTflTbQ0gGtXa6dIUydyF1mi0HrKwpU5X0dRk=;
        b=CAN8B3vuSgKdkCB1tMyAq2XW3gxmLOA6VL9Hxr8cFRttdv8XAkfx7/fcVwlUv0MAHp
         le9uz6h5KGUOTYjVJFrXW21nh+ePUTP+DPNSfXImnzqWNc8pVPLQwXjVcn+tdzf3JYfx
         6Fmry3fC514XVXzHpTxMruzmhXvEVHnZOVLULqgUXfbdxDdIgv/YFHsYLH/LuN4Xgj/X
         vgMcxchEOpoj4Rh5a8eEsVx2bAwr4o4VurcUXg916eSuxSNct5K7oNM6FtcyhzFr/W+e
         HrmG9BHQEfsKdM6CqHbkhdVm4zINtLmkMgdNr5lfk8VjmgpFDe8MiJU7oi3W2qS/0RIu
         i81Q==
X-Gm-Message-State: ACgBeo0kt9mgX13dFg6Z4Qxy2BSILxTEfVcY3Av5Z8unFBX8Ech1jdGk
        GNKQwssqGqlwNyOK/0/eCP7/gqiwjJrLpGnsJ2E7uw==
X-Google-Smtp-Source: AA6agR7XTTaYi8RLnWWf+Naws8X6HS7OihvdTEknJwY4+WIdMldKbmojcTo1NXA7a4F4Z7AsGY1sMmTBAZ9HtrhSm/4=
X-Received: by 2002:a2e:b5aa:0:b0:261:70f3:fd58 with SMTP id
 f10-20020a2eb5aa000000b0026170f3fd58mr138561ljn.295.1660243166694; Thu, 11
 Aug 2022 11:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <YvSxeDkmwxcJL+Z0@debian> <YvUZ+9kJ/AvUMxzO@dev-arch.thelio-3990X> <CAHk-=wivP4zipYnwNWCLF5cd24GLs3m8=Sp7M-CmmPva_UC+3Q@mail.gmail.com>
In-Reply-To: <CAHk-=wivP4zipYnwNWCLF5cd24GLs3m8=Sp7M-CmmPva_UC+3Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Aug 2022 11:39:15 -0700
Message-ID: <CAKwvOdnQjgtwqFXLv+QtWPfpHosM5fxE5oqbX0VUD53F8L6bRg@mail.gmail.com>
Subject: Re: mainline build failure for arm64 allmodconfig with clang
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Aug 11, 2022 at 8:39 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Aug 11, 2022 at 8:05 AM Nathan Chancellor <nathan@kernel.org> wro=
te:
> >
> > Right, these are exposed by commit 258fafcd0683 ("Makefile.extrawarn:
> > re-enable -Wformat for clang").
>
> Christ. Why is clang's format warning SO COMPLETELY BROKEN?
>
> The warning is *WRONG*, for chrissake. Printing an 'int' with '%hhu'
> is perfectly fine, and has well-defined semantics, and is what you
> *want* to do in some cases.

Generally, printing an int with %hhu may truncate depending on the
value of the int.

Perhaps there's something different we can be doing for literals though.

> I'm going to turn it off again, because honestly, this is a clang bug.
> I don't care one whit if there are pending "fixes" for this clang bug,
> until those fixes are in *clang*, not in the correct kernel code.
>
> For chrissake, the value it is trying to print out as a char is '3'.

If your referring to SOF_ABI_MAJOR from

commit b7bf23c0865f ("ASoC: SOF: ipc3-topology: Fix clang -Wformat warning"=
)

in -next, 3 is an int literal.  No truncation occurs, sure, but just
use the correct format flag!

Otherwise please also considering reverting
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
unnecessary %h[xudi] and %hh[xudi]")
since for the past 3 years, we've been recommending that kernel
developers not use %h or %hh.  You allude to this in your "Admittedly,
" note in
commit 21f9c8a13bb2 ("Revert "Makefile.extrawarn: re-enable -Wformat
for clang"")
. Otherwise, please reinstate this patch.

I don't care which you pick, but let's be consistent?

Because having explicit documented practices then reverting things
when those are followed is quite obnoxious.

> But even if it wasn't, and even if you wanted to print out "0xf365" as
> a "char" value, then that is how C varargs *work*. It's an "int".

This is a different case than using a literal value in which no
truncation would occur.  (Your points about 3 and 'a' (no truncation)
are distinct from 0xf365 (truncation)).

It would be anomolous to the compiler whether the truncation in such a
case was intentional vs accidental.

printf("%hhx\n", 0xf365); // -Wformat: warning: format specifies type
'unsigned char' but the argument has type 'int'

should be

printf("%hhx\n", (unsigned char)0xf365); // intentional truncation, no warn=
ing

A cast in that case helps inform the compiler that "I know what I'm
doing," and a comment helps code reviewers & maintainers.

> In fact, even a *character* is an "int". This program:
>
>         #include <stdio.h>
>
>         int main(int argc, char **argv)
>         {
>                 printf("%hhu\n", 'a');
>         }
>
> generates a warning with "clang -Wformat", and dammit, if you are a
> clang developer and you see no problem with that warning, then I don't
> know what to say.

Yeah, that is noisy.  I think if we had an argument that is a literal,
we should be able to tell then and there whether that value would
result in truncation (and avoiding diagnosing if no truncation occurs,
or split that into -Wformat-me-harder so that we could set
-Wno-format-me-harder).

printf("%hhu\n", 256); // should this produce a warning? Which
compilers do so? ;)

Though, isn't %c the correct format flag for characters?

>
> Nathan, please make clang people see some sense.
>
> Because no, I'm not in the least interested in getting kernel "fixes"
> for this issue. -Wformat for clang goes away until people have gotten
> their heads extracted from their derri=C3=A8res.
>
> This is ridiculous.
>
>               Linus



--
Thanks,
~Nick Desaulniers
