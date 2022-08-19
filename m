Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDEB599CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349243AbiHSNY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348748AbiHSNYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:24:24 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F140BCCC1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:24:23 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3378303138bso80611077b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=PE//5FEPNMY6rqPHYV8LuBFuRKOmU7+3QHKdarRxGyc=;
        b=aSYdSnYEKlKxbvpP9TuGgufwIVXR50CGqOvKDmGFW8Vb3+LQ9emC3BrcJ2Z453m8IO
         RtiaQhU74aZklL5kGfsx2dY+HsILotAedaadZ6MkTFMpLHsPhJXakEKi34lHy4ybX53U
         5y0Eseu8EdEnetwCzlvJbdi/1rVJ1QNKkKsHnbBHJlve13Kz+7ToZOUu8pkAse3oI5W5
         2SSzyClZO1qsyZorj/dfrhM5Nd3qLe/agf0EduOQTtOdQ+cXe3+ExkKSlhe6fZowa51x
         zgewUvbyfC7Q2xt/2p8nR5cG2jeltaXsJt5zWWhGGotD1iNxomEAXnsgVvBCY7ymeG6V
         DciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=PE//5FEPNMY6rqPHYV8LuBFuRKOmU7+3QHKdarRxGyc=;
        b=AOBtjiTMBKqL4s6QOF3ICxq7Oj8/Dkr0TlbR64/t+RvVJjfWJRsAPdjkDRm116ynuT
         dwZ/1LsqL9Lfs/tnoTHX+gysBfEsq+G4An7MJEmGNHnfuouAOoUmbrkSOwXYX9U3GNkv
         KCv/lKme4iJoM/SMlLFNHRt+lcgqUtcDtNjw9gorjcAxMIGVqCboGQQRuBDJh1NZh7Nc
         gnUVnDTe9cXXFiZOQezA1jhRdvO3g7bu9lw23c0xeD+AUl/45nV4XI3zouisJ8/sHIaY
         lQvsqqmGM7aK42udh03Nqx9aXAXKGPgfXKEp9vNnl3YIPh+AJ1JiMBST+7r1UPoH78qq
         GktA==
X-Gm-Message-State: ACgBeo3imk4NqYfXSwUGpUgXhGtS9+D1tZAz1xfcUfmsR//VFY2p7xlF
        9QatrdjHOd4NU5q9+Yu4Mz7WV/WCMIGyDafnmnw=
X-Google-Smtp-Source: AA6agR5X7G7uODnDVvm5AgmB6SB4q/bXpLmpHQeI676PpI8u2cJAUuq7mEMdIgZ4TG2cL8C7H5O+n0L/1uhSTsb6IAM=
X-Received: by 2002:a5b:848:0:b0:683:58d:ea95 with SMTP id v8-20020a5b0848000000b00683058dea95mr7145104ybq.565.1660915462320;
 Fri, 19 Aug 2022 06:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220817080332.1052710-1-weiyongjun1@huawei.com> <20220817080332.1052710-4-weiyongjun1@huawei.com>
In-Reply-To: <20220817080332.1052710-4-weiyongjun1@huawei.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Fri, 19 Aug 2022 22:24:10 +0900
Message-ID: <CAC5umyhZrUsOCDbWPznRpuaDwScHf7yKA5m8X8jwVztm6B+meA@mail.gmail.com>
Subject: Re: [PATCH 3/4 -next] fault-injection: make some stack filter attrs
 more readable
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>
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

2022=E5=B9=B48=E6=9C=8817=E6=97=A5(=E6=B0=B4) 16:45 Wei Yongjun <weiyongjun=
1@huawei.com>:
>
> Attributes of stack filter are show as unsigned decimal, such
> as 'require-start', 'require-end'. This patch change to
> show them as unsigned hexadecimal for more readable.
>
> Before:
>   $ echo 0xffffffffc0257000 > /sys/kernel/debug/failslab/require-start
>   $ cat /sys/kernel/debug/failslab/require-start
>   18446744072638263296
>
> After:
>   $ echo 0xffffffffc0257000 > /sys/kernel/debug/failslab/require-start
>   $ cat /sys/kernel/debug/failslab/require-start
>   0xffffffffc0257000
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  lib/fault-inject.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
> index 515fc5aaf032..deca05e7c9b3 100644
> --- a/lib/fault-inject.c
> +++ b/lib/fault-inject.c
> @@ -179,6 +179,14 @@ static void debugfs_create_ul(const char *name, umod=
e_t mode,
>
>  #ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
>
> +DEFINE_SIMPLE_ATTRIBUTE(fops_xl, debugfs_ul_get, debugfs_ul_set, "0x%llx=
\n");
> +
> +static void debugfs_create_xl(const char *name, umode_t mode,
> +                             struct dentry *parent, unsigned long *value=
)
> +{
> +       debugfs_create_file(name, mode, parent, value, &fops_xl);
> +}

How about using an existing `debugfs_create_xul()` instead of defining
a local helper function?
