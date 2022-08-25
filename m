Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FBC5A17E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbiHYRUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbiHYRUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:20:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A5BB4AB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:20:03 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m5so18463390lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3RxVSxGedQ4BVA173MTZ77OwZd2QHzVXFfeNvoFT8hM=;
        b=NIoZpAJR1O0BB7LoWxrGL/PLQGtbk7Re/ajyAo/TVFdR513UEmFHV2F0/NQHYT4ek1
         zF4xCY5ATX5lCpaS8SDzhawFNO9Nf/xk5a3KcXEJW8NFyEEFzwkv8QQ3E93vJv1hC7Fw
         wS3gYaac8w74pHP9zHqb+76JVP7+60qoJhQ6DO4imMQZjkPwewvJ/ioaS9aYZpsZszp2
         HrHvaQXauZ5clGc3/gQEsA/aA3/2TOoEZpcfRA+pzCxr1DajVeCe5aTIb0uXjqiCmE3J
         2Dy3RU/mA2141UpS1txR2PsBkba9XpUNwW7yEhAufXwLviJCoA1sQrpqln6V1veVeUkn
         dIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3RxVSxGedQ4BVA173MTZ77OwZd2QHzVXFfeNvoFT8hM=;
        b=dB3AanoqNyOHDL6tOrrVFYvbLlDGoyI6kRj4BnXoktVXwcP3CQMT1RzVlY/MScS0np
         +tLNWPVsZVOGeWDrSyccIHmsJDMcgty5t71UTiQlKLtXCDIWsYbhTJX/nMvFujzOm8az
         jB/VeOkwQ330gDPwzzFWy2Y3s15AmH+fImg2dofgbDsLe82jiLg+sQoqP3aUHg53BDxX
         TAfTv4IDkvGl0nw0+ieLmf3/cG77trXjrVmYhwCJoRVcv4LUOiMrTri4vS7c+4F9NQY8
         amAYOwwXs6wymTdf534IYBBU5NlRG/D5hT5tGthaujP8btgmoMgYTXE1OOfS8Y+135ZL
         JTlg==
X-Gm-Message-State: ACgBeo0RabljsTGcV35S/+yJMTncXgjkdGsdWJjriAY0i09YMv7+raLl
        Gp6yhFAhIbs7JcsxaqEs5KZI1btG6hOIiF+/zodbUA==
X-Google-Smtp-Source: AA6agR67zaeSCHox9rh4ibHqzzyxkXfCRBtY5Nv6Wc5e77Q+sHxQghMJNgEvmuNzTifZrLzcJDcchuX54X2nH6C7oRo=
X-Received: by 2002:a05:6512:33d6:b0:492:c423:1672 with SMTP id
 d22-20020a05651233d600b00492c4231672mr1516211lfg.432.1661448001581; Thu, 25
 Aug 2022 10:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220825091517.30842-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220825091517.30842-1-lukas.bulwahn@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Aug 2022 10:19:49 -0700
Message-ID: <CAKwvOdkY=ye4PKi8KwP-ux73pwZs+J_Oq3wR7ep8S81=aCWtqA@mail.gmail.com>
Subject: Re: [PATCH] scripts: remove obsolete gcc-ld script
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Jiri in case this needs to be carried downstream.

On Thu, Aug 25, 2022 at 2:15 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Since commit 8564ed2b3888 ("Kbuild, lto: Add a gcc-ld script to let run gcc
> as ld") in 2014, there was not specific work on this the gcc-ld script
> other than treewide clean-ups.
>
> There are no users within the kernel tree, and probably no out-of-tree
> users either, and there is no dedicated maintainer in MAINTAINERS.
>
> Delete this obsolete gcc-ld script.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

No callers in-tree; happy to bring it back though should there later
be. Thanks for the patch.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> If there are no objections, I would like to get this patch included
> through the kbuild tree.
>
> Masahiro-san, please pick this patch.
>
>  scripts/gcc-ld | 30 ------------------------------
>  1 file changed, 30 deletions(-)
>  delete mode 100755 scripts/gcc-ld
>
> diff --git a/scripts/gcc-ld b/scripts/gcc-ld
> deleted file mode 100755
> index 997b818c3962..000000000000
> --- a/scripts/gcc-ld
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -# run gcc with ld options
> -# used as a wrapper to execute link time optimizations
> -# yes virginia, this is not pretty
> -
> -ARGS="-nostdlib"
> -
> -while [ "$1" != "" ] ; do
> -       case "$1" in
> -       -save-temps|-m32|-m64) N="$1" ;;
> -       -r) N="$1" ;;
> -       -[Wg]*) N="$1" ;;
> -       -[olv]|-[Ofd]*|-nostdlib) N="$1" ;;
> -       --end-group|--start-group)
> -                N="-Wl,$1" ;;
> -       -[RTFGhIezcbyYu]*|\
> ---script|--defsym|-init|-Map|--oformat|-rpath|\
> --rpath-link|--sort-section|--section-start|-Tbss|-Tdata|-Ttext|\
> ---version-script|--dynamic-list|--version-exports-symbol|--wrap|-m)
> -               A="$1" ; shift ; N="-Wl,$A,$1" ;;
> -       -[m]*) N="$1" ;;
> -       -*) N="-Wl,$1" ;;
> -       *)  N="$1" ;;
> -       esac
> -       ARGS="$ARGS $N"
> -       shift
> -done
> -
> -exec $CC $ARGS
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
