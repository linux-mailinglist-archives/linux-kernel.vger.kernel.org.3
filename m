Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B6D530693
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 00:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiEVWgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 18:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241209AbiEVWgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 18:36:03 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F78B60EF;
        Sun, 22 May 2022 15:36:01 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id t15so2448838ilg.13;
        Sun, 22 May 2022 15:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ArpLUn2/pj9FP5lFRBkDLCBidWkCamGHeX/50G01bPs=;
        b=DiI+Z83vWb7aN9j7eNGIypx40svWAdoh++1piqY8e96KsvuF5oPXAVVtqhQkMI357+
         qF3wD7UVPlbDbHgc9dmbKwxXFdrp2i5qmzpZXCVwVOsAroG5oWfmHOcs2zFT3GbnR78L
         sz9pPytFp3QWt2ruqRP+4rVEwDDl5y65x857BQ0pLARdhORynU+6vJu/0Zyew0p9bWG9
         oG0bU22HFxMvV6zT0+YZ5C+fiU0T7aZ7BpdCFPoQcbm2sK94Qb18JboNEF4nYQX7uzrU
         Jm+wkRTJsB/V2C/6GTCLGEDWFsWkVjYdOhuPNudY6WD4Uy4l0rhqLGxNhC7JhUpPYnMs
         Kvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ArpLUn2/pj9FP5lFRBkDLCBidWkCamGHeX/50G01bPs=;
        b=a0G0r3XZ5dmsOHfofc5ssBYC9IU1U7s5rHh7/GJaxc3AlgtaZySjRYu7q4q5q9YTH7
         WLT0JJ4XdvtoabZQdQ2uzeqQOWs62qaBWXbLIHVtTwQHdFYj71a5J8Oyhx9Vrwyk+G1K
         YkLNmLopToc2O447y6EJn5ie1Dt0MFUbadZeNejzu+urxGIHXa3KhVMPMUEEb0PK2qp4
         Q0lsBoMFkkVSLVxjhKj20ewPtyT1wyybVWBOHSES20OlvKn/az8uueW8rCp/+ypEXgJ+
         +H4CHh2LgY6F6qYDXxA/VvBu9JqDKL+t9IJMz2hhyXXc73QZPgFMR+uWbRIVTdbpK/iK
         2C8g==
X-Gm-Message-State: AOAM531I2+UAmW3CD95EYY7jUcZ71D+DLdsD8Hj+lPK4UNgUY5HmTnJV
        Y7w5p31GGyf7+nX0rH8Y6IHq0zeWsebmePn8ZSc=
X-Google-Smtp-Source: ABdhPJyGISDr2Z+K29rTdFgt0lIY9GUwyNC5SfnmTm5ZFxVdZbc98PA0cihiMx1/6b7oICIsCaLYkQtBpIghRdlZJ8I=
X-Received: by 2002:a05:6e02:1aa8:b0:2d1:7099:67ba with SMTP id
 l8-20020a056e021aa800b002d1709967bamr7955707ilv.1.1653258961101; Sun, 22 May
 2022 15:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220522160117.599023-1-masahiroy@kernel.org>
In-Reply-To: <20220522160117.599023-1-masahiroy@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 23 May 2022 00:35:25 +0200
Message-ID: <CA+icZUXos=M_6KE3p00tFpT3Pt_jd3HUvVLRxW7+eJoT26X5cQ@mail.gmail.com>
Subject: Re: [PATCH] fixup! kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
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

On Sun, May 22, 2022 at 6:03 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> I will squash this into
>
>   https://patchwork.kernel.org/project/linux-kbuild/patch/20220513113930.10488-3-masahiroy@kernel.org/
>
> Sedat Reported an error:
>
>   https://lore.kernel.org/linux-kbuild/CA+icZUWttwjhDNPO1VuVyiMoReH5e83nsYDd0rEoY8-Uwv6pHw@mail.gmail.com/T/#md82f561e348b7959b7270c33ac86fa3edb0d773a
>
> __used is needed to make the combination of
> CONFIG_MODVERSIONS and CONFIG_LTO_CLANG working.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

I was able to build and boot on bare metal.

Feel free to add my...

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM-14 (x86-64)

-Sedat-

> ---
>
>  include/linux/export-internal.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
> index 77175d561058..c2b1d4fd5987 100644
> --- a/include/linux/export-internal.h
> +++ b/include/linux/export-internal.h
> @@ -10,7 +10,8 @@
>  #include <linux/compiler.h>
>  #include <linux/types.h>
>
> +/* __used is needed to keep __crc_* for LTO */
>  #define SYMBOL_CRC(sym, crc, sec)   \
> -       u32 __section("___kcrctab" sec "+" #sym) __crc_##sym = crc
> +       u32 __section("___kcrctab" sec "+" #sym) __used __crc_##sym = crc
>
>  #endif /* __LINUX_EXPORT_INTERNAL_H__ */
> --
> 2.32.0
>
