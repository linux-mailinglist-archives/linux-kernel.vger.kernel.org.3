Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075F94A7B8D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348043AbiBBXMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347913AbiBBXMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:12:50 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FF1C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 15:12:49 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b9so2171343lfq.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 15:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxLZoNp/4LQPZ5USv0kT/ANrlVIeVswz1mwyMInuRpk=;
        b=Q2moWDCWxi4BS8PPyCaJoqnrPIZQcruQgJjzpamHlvHl8nfkZnrnUwhlebZjL4Qlid
         AZFzASi+lGjNRFfFNjvPEAV2OO1mxc2n/gPx8V0KnqP5u6M4wJHDfXsL1tbK3dOCogdZ
         v5sFcJe1cu9GkyUnxpnJ3HA3l8dpy1RjXvbvrK8Z/rAK9aOYhuhE66KFBdjyjDKqfZlT
         +wq0XncRggDytCxIhnPTtZSQBB8unOSP4gvw0dAqmb2KU9UablWXiH0mbP3wrGYlLrXp
         3dsxxtU1+Z++ZC+wI7jM2kRxCYui1ckWsccWdwkq3TdAX9Dv2DXTOhZ2rgkBuiM3VxZa
         mdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxLZoNp/4LQPZ5USv0kT/ANrlVIeVswz1mwyMInuRpk=;
        b=QMmKTbQ5sMe6IfJoomANXn8dMSSvAmREaNZi17wKUWqjepmKumwCsznc2rqYIa7r/V
         OCMnZVFQ4vkfKXPL9oLfgwsJbZLE4V4+9i5HzjFu8GDpzzCZFDUYgfe9LKEmVpziWVLk
         o87HEuADfL6Kqn3wNSvy3Jq3+Xm6AL3cOhXqFJoCUYCaW/8gKn+gtqVVK+c099cd8j7o
         HNkxd9Ar1HOCwAKf+C8Iarjo1zpRzCg2abrQcHIr8BNm6AskoZ/N4QlfHhRzbuusGbt2
         8ZgBHvGwtuzbFXdztmWyFijry0fGh3CAqAyJqscmRiunsA5fRG8W/VhoZ50hqvZrK/iB
         G4wg==
X-Gm-Message-State: AOAM531WGGLA2IXQVE+eoeh/Ec2MrVoSE/rvaIZuL12dOcG0XlQnYkQt
        CWu1rPwPoqUmdIrIEgovUMPg1ldopCY/ky2qyBDQ+Q==
X-Google-Smtp-Source: ABdhPJwi69J10B5BJjANF390JZYBG3ldtIxVMDaHUe2bQC7/YKzyMziklWm0E/V2hAP0KIVpwrcww6mql102RTB9yMQ=
X-Received: by 2002:ac2:5510:: with SMTP id j16mr24302186lfk.240.1643843567939;
 Wed, 02 Feb 2022 15:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20220202230515.2931333-1-nathan@kernel.org>
In-Reply-To: <20220202230515.2931333-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Feb 2022 15:12:35 -0800
Message-ID: <CAKwvOdkQ__2A3NohrcJgF+JABSDnSyEKzD97qVa4cpM==GPONQ@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile.extrawarn: Move -Wunaligned-access to W=1
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 3:07 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> -Wunaligned-access is a new warning in clang that is default enabled for
> arm and arm64 under certain circumstances within the clang frontend (see
> LLVM commit below). On v5.17-rc2, an ARCH=arm allmodconfig build shows
> 1284 total/70 unique instances of this warning (most of the instances
> are in header files), which is quite noisy.
>
> To keep a normal build green through CONFIG_WERROR, only show this
> warning with W=1, which will allow automated build systems to catch new
> instances of the warning so that the total number can be driven down to
> zero eventually since catching unaligned accesses at compile time would
> be generally useful.
>
> Cc: stable@vger.kernel.org
> Link: https://github.com/llvm/llvm-project/commit/35737df4dcd28534bd3090157c224c19b501278a
> Link: https://github.com/ClangBuiltLinux/linux/issues/1569
> Link: https://github.com/ClangBuiltLinux/linux/issues/1576
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks to you and Arnd for working out whether this is important to
pursue. Sounds like it is.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> v1 -> v2: https://lore.kernel.org/r/20220201232229.2992968-1-nathan@kernel.org/
>
> * Move to W=1 instead of W=2 so that new instances are caught (Arnd).
> * Add links to the ClangBuiltLinux issue tracker.
>
>  scripts/Makefile.extrawarn | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index d53825503874..8be892887d71 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -51,6 +51,7 @@ KBUILD_CFLAGS += -Wno-sign-compare
>  KBUILD_CFLAGS += -Wno-format-zero-length
>  KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
>  KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
> +KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
>  endif
>
>  endif
>
> base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
> --
> 2.35.1
>


-- 
Thanks,
~Nick Desaulniers
