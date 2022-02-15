Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9811B4B75C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241814AbiBOTKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:10:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbiBOTKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:10:52 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B7CC24AE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:10:41 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o2so38830923lfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WMFpeHH/2LlihF+kPrm9P2QAiW9s4yup6CA8c8djDKc=;
        b=Q7Fza7uT9MzvDrNjzgOKE/3nryb9/bWyOoCtZ+VCeySA1EtuNAXGDqISCPSRBOJspw
         g7Yx+kYLhYqc+5XQGELlTT7ExTn1f1mhnG9Z3ubty2EJhwKx3+jDHQPAH3zrYGnWfYdO
         1Or7ZqiSrs2230fVtFM6L1529Vg7oGeXKKBOvjK1fUj9ihfPGNp08tdP85lBXZH+vZwx
         SnDKT7G/28RfcEM8rszaV00cy4kmqPgk7c4o7rE8TL+/aS/l++IUvyd+WeHd4WHSF8P6
         x5WmsIejkZc6/1+KdpdO7V8DII7hNzO1rqf3C28046NwRgqyJH0wHjotNvGcrMhnFF8+
         PnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMFpeHH/2LlihF+kPrm9P2QAiW9s4yup6CA8c8djDKc=;
        b=qy1cWGEYc3SlQ1ROwUGPzF8T76C2bbkD2nfRcs+W4IlyJdHlUnoDtbNM/p2IiHYabH
         mav7ih5K19UumYsqoK3wa9kInvMPQlZbgPGrzdRPf1aGLSKFcuCp6UCcbh9jLv1JZNgV
         bxY6jp/KPV8N+abG98ZWpdtfdyAbJZcZNgIOrVxCmFy+QGwIRpEB4QvJMtIy4WAPaiVK
         x7eGkMoLRCjSbZBT2iPM3aabcD2C4R8+SmUU75XDwtrog1LkFMGVHTx7Eu9nuUWNwQ1i
         FVoP9uu1kmaDDYNkOUQdEj6VSUNT8sr4b2zG4ijRT1o8BGmRmgB5uUORDG+p59UE9UIM
         71Tg==
X-Gm-Message-State: AOAM530/GJQeIolQSFLKqga/XpKtlm8xfJdlxD/HMnDSc4RSutDDpjWb
        LsWpqToMUzpC6iYtmv4+9uBoZbUizccA2T9Nvcvd5w==
X-Google-Smtp-Source: ABdhPJyaSWbdMiG2FSKsMdDp4SYE6wwV2PmswU3VGZUUZh2mvxF1Xr0MrClFP7EQq8zdXlrgsOaLyKQpQomEYSOYCTg=
X-Received: by 2002:ac2:4e10:: with SMTP id e16mr406714lfr.444.1644952239569;
 Tue, 15 Feb 2022 11:10:39 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtR+E52X-ucmvXYG5-9v0q2UEXQsML=nkQRnSf7TwXYqw@mail.gmail.com>
 <Ygp2wVo8JfWh5iOk@dev-arch.archlinux-ax161>
In-Reply-To: <Ygp2wVo8JfWh5iOk@dev-arch.archlinux-ax161>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Feb 2022 11:10:28 -0800
Message-ID: <CAKwvOdmXvC-E_9PSOZVQDDx_UCSadxhF4d9c7qpJPmeFLY_JEA@mail.gmail.com>
Subject: Re: arm64: clang-nightly: net/ipv4/tcp_input.c: clang: error: clang
 frontend command failed with exit code 139
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
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

On Mon, Feb 14, 2022 at 7:35 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Naresh,
>
> On Mon, Feb 14, 2022 at 12:27:17PM +0530, Naresh Kamboju wrote:
> > On Linux mainline master branch with arm64 clang-nightly build failed
> > due to following errors and warnings.
> >
> > make --silent --keep-going --jobs=8
> > O=/home/tuxbuild/.cache/tuxmake/builds/current LLVM=1 LLVM_IAS=1
> > ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> > CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- HOSTCC=clang CC=clang

Thanks for the report. Thanks Nathan for submitting reverts.

Naresh, as a heads up, the above command line can be simplified a
little bit (particularly for newer kernel branches)

LLVM_IAS=1 is implied by LLVM=1 as of v5.15-rc1 via
commit f12b034afeb3 ("scripts/Makefile.clang: default to LLVM_IAS=1").

CROSS_COMPILE is no longer necessary when building with LLVM=1 as of
v5.15-rc1 via:
commit 231ad7f409f1 ("Makefile: infer --target from ARCH for CC=clang")

There is no need for CROSS_COMPILE_COMPAT as of v5.16-rc1 via
commit 3e6f8d1fa184 ("arm64: vdso32: require CROSS_COMPILE_COMPAT for gcc+bfd")
when LLVM=1 is set.

HOSTCC and CC are implied by LLVM=1 as of
commit a0d1c951ef08 ("kbuild: support LLVM=1 to switch the default
tools to Clang/LLVM")
v5.7-rc1.

So the above make invocation could be trimmed down to simply:

$ make --silent --keep-going --jobs=8 \
O=/home/tuxbuild/.cache/tuxmake/builds/current LLVM=1

We might need to discuss further with tuxbuild folks, since I think a
few of those are set implicitly; I would prefer if they needed to be
set explicitly in order to properly test them being _unspecified_ in
our CI.
-- 
Thanks,
~Nick Desaulniers
