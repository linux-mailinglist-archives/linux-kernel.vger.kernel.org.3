Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9703D597A44
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242317AbiHQXkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiHQXkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:40:16 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762446E2D0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:40:15 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11c4d7d4683so53910fac.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=daKNlzUlISpXfRKkkWFRtUiXLBWJavrHYfPtjh2uJpI=;
        b=Iyf3cvO5rvbYqgr6PC43xyQOHandKHxgBfbSVZfHQBKStNgP7AeUDKY/AvYIjcwuil
         gKDQAf8L1+FMfiFm2F0R/yvNGiqdvVeB4ZwTVZ6Xpil+4bKPW+IR4fPS6bmXUIrlQ61E
         IGeqh/9AkEgJj6Dq6du9u8QTJ+bhiKPRbLZSrVQyF04WUTEU+6Joiv1/DbnGLh9SKhhL
         Ift+3z2ymfxPk3OTDS3+kav9uoNPM0gwRn7U4HmCq0/v3ZPAgg6D7T61Ho84BuNHEjrp
         ql5EZMemsXl7nWH//eVAkD2PnKz6jNfyWHtK5ycOvbg1N71VudGoGhk2kSSfiKdPpnxt
         nKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=daKNlzUlISpXfRKkkWFRtUiXLBWJavrHYfPtjh2uJpI=;
        b=hnA9SIGVCkFz7tWLk0rIQu3WnKvDYHGDKOQU+c+51HX+TUy6HbLYAjV3N9aP0UwOV6
         hRbA/EtReft7gyIbmz+HB8VIiAeMcbiVXwjs41O97x9KfZYP4Pk2VPyDpDz6epx83vqu
         imXFbfRaC+AVX2q7JSPHVypUYUKE+DafmT5mlroB26QO7OfliVj/3El78sGDC43V4YGk
         bIuoFfdJAyQrr6E0XOLRCF6qGCJRwF2s3GKuzhMEo+Oduhq0Lb29MR5TOQG14XYaFd//
         o1TZgN45/0rYVA2k7JoyuHJILpwKmA4fuUwEBL9UfsdWy1nemzjmqd1MMcMRWQaVi1Za
         vz0w==
X-Gm-Message-State: ACgBeo0AJXUp3QnOXKNQgchD8/DjTYfOVIjOaO7UER2rfFPmIg9W3meE
        mqqTyaB7+EO1HN4ici9WV3ueYNYXNBYid+oXmWgRKA==
X-Google-Smtp-Source: AA6agR7JztkGz0UiDLQonDNB7R4KJt4JkbhowjaMaCqhJe0/FNsjgPRFr1i6NaE3WNeRyGl0QT/y2yPeL2tieH7qkMQ=
X-Received: by 2002:a05:6870:5b86:b0:11c:67ba:71dc with SMTP id
 em6-20020a0568705b8600b0011c67ba71dcmr1969668oab.289.1660779614640; Wed, 17
 Aug 2022 16:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <1659635174-2376-1-git-send-email-quic_gurus@quicinc.com>
In-Reply-To: <1659635174-2376-1-git-send-email-quic_gurus@quicinc.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 Aug 2022 16:40:01 -0700
Message-ID: <CAKwvOdnbMs-pLRfo4O-MHOF=9=kAvDuktkeeeX7bkmnLi8LWnw@mail.gmail.com>
Subject: Re: [PATCH] scripts/clang-tools: Remove DeprecatedOrUnsafeBufferHandling
 check
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        Elliot Berman <quic_eberman@quicinc.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 10:46 AM Guru Das Srinagesh
<quic_gurus@quicinc.com> wrote:
>
> This `clang-analyzer` check flags the use of memset(), suggesting a more
> secure version of the API, such as memset_s(), which does not exist in
> the kernel:
>
>   warning: Call to function 'memset' is insecure as it does not provide
>   security checks introduced in the C11 standard. Replace with analogous
>   functions that support length arguments or provides boundary checks such
>   as 'memset_s' in case of C11
>   [clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling]
>
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>  scripts/clang-tools/run-clang-tools.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
> index f754415a..1337ced 100755
> --- a/scripts/clang-tools/run-clang-tools.py
> +++ b/scripts/clang-tools/run-clang-tools.py
> @@ -51,6 +51,7 @@ def run_analysis(entry):
>          checks += "linuxkernel-*"
>      else:
>          checks += "clang-analyzer-*"
> +        checks += ",-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling"

Thanks for the patch! I think it makes sense to add this.  I suspect
the list of checks we might want to disable may grow. Maybe when it
does, we could put these in an array and join them at the end.

Anyways, LGTM
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Masahiro, would you mind picking this up for us, please?

>      p = subprocess.run(["clang-tidy", "-p", args.path, checks, entry["file"]],
>                         stdout=subprocess.PIPE,
>                         stderr=subprocess.STDOUT,
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
