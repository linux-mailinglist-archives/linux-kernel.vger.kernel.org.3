Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949E34ED29C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiCaEZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiCaEZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:25:24 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6EB18021D;
        Wed, 30 Mar 2022 21:14:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o10so45505399ejd.1;
        Wed, 30 Mar 2022 21:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHLGkaQYu4o1VuLVe04VP5C9UOK2Y5HybQ/7vFAycP4=;
        b=IejV0elzv/fR5v4FKPqWNBF8faVRUyD4+g73zFNzDj84EhCzmnV+cYKflwLA4Otjfi
         VtFOlbHiTPkKvxrwAoDgW53yCHYhQKLJktKQclamHJcHFen5tWhCTdc51fR0fCQxbv92
         dNAYMM275Is6y+5unL7BXYt5RP4MunPV3xMDYp9cgc/vOJGyWud0IsknBQVLOpbSnUHV
         5dDeGZ1Dn3kb/K8CpwisW5DiEaBGUJGNpTwjy3oha1/ImqmlAhyrc6TRaDNh+YEBxHbc
         K7QrSfpP6hKCiv4ttnd7bzOLXob/N2aHt1fzc4xSEcz3LTqwedqPL6O1ONAEBwPc7HGl
         p42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHLGkaQYu4o1VuLVe04VP5C9UOK2Y5HybQ/7vFAycP4=;
        b=DPqxpStyk9JVTOPZD7PH8tDWhe8Jsku9lOlxybpnU/M98blfsxMh4tNAEViV6vCgGe
         sk6Wdnl0L6rR66lRxV4p09BzhfmA081itM5aehB+DdMIsj5aiv09AJ5z7QHH56Ifw02o
         5c4iNaJQ+0yGOynWkEGtVeH8gdeEjJ28WyHMmP2nfSV6ZdN5DqketmLXc0LUS6PcPKMP
         26NwA8eo6HkoTKJHPOIAyQtcb9zwKhh0wIo8WmDkySzq3h0hW/BjJgtRWFQEzrUtjNl+
         vCoxu42E9zpRhTp0D67Wd0SUkujMd08HUo0hkHCRXRxCVMbCzdaMTpqCSAqwUb1jWKr5
         5ZTg==
X-Gm-Message-State: AOAM533tX99T+v1RMAsMNNfaLutZnQBl9ZdZ87Gg9FC2l0Sy4Iivgki7
        +/R12+9Pcr62wjEFoMZgS5E2uoG9kIyZ90i8gRw=
X-Google-Smtp-Source: ABdhPJylV+qIHEhgIiC8pc2ZyVs4dIvULSo9dP3vfdc/QTV15d7mrqgXEUvxiupeD7GQsWsqPD8b71wB8duOxbnPqTU=
X-Received: by 2002:a17:906:3a15:b0:6cf:ea4e:a1cc with SMTP id
 z21-20020a1709063a1500b006cfea4ea1ccmr3304474eje.753.1648700086306; Wed, 30
 Mar 2022 21:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648674305.git.marcelo.schmitt1@gmail.com> <7d793c1b9f87d9cb8ac0e858e561e108c2bf0176.1648674305.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <7d793c1b9f87d9cb8ac0e858e561e108c2bf0176.1648674305.git.marcelo.schmitt1@gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 31 Mar 2022 12:14:19 +0800
Message-ID: <CAD-N9QVvgCqbwiebjVX2_81pH_YhK+j4hhJPG3fbWbAtzFVJTQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Documentation: dev-tools: Add a section for static
 analysis tools
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        dlatypov@google.com, davidgow@google.com,
        linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org,
        cocci@inria.fr, smatch@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        skhan@linuxfoundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>, julia.lawall@inria.fr
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

On Thu, Mar 31, 2022 at 12:07 PM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Complement the Kernel Testing Guide documentation page by adding a
> section about static analysis tools.
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Acked-by: Daniel Latypov <dlatypov@google.com>
> Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Julia Lawall <julia.lawall@inria.fr>
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Change log v2 -> v3:
> - Added Julia's acknowledgment tag
>
> Change log v1 -> v2:
> - Brought generic tool characteristics to the intro paragraph
> - Made explicit that these tools run at compile time
> - Added a note of caution about false positives
> - Updated Coccinelle info to make it sound better and be more skimmable
>
>  Documentation/dev-tools/testing-overview.rst | 31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> index 65feb81edb14..b5e02dd3fd94 100644
> --- a/Documentation/dev-tools/testing-overview.rst
> +++ b/Documentation/dev-tools/testing-overview.rst
> @@ -115,3 +115,34 @@ that none of these errors are occurring during the test.
>  Some of these tools integrate with KUnit or kselftest and will
>  automatically fail tests if an issue is detected.
>
> +Static Analysis Tools
> +=====================
> +
> +In addition to testing a running kernel, one can also analyze kernel source code
> +directly (**at compile time**) using **static analysis** tools. The tools
> +commonly used in the kernel allow one to inspect the whole source tree or just
> +specific files within it. They make it easier to detect and fix problems during
> +the development process.
> +
> +Sparse can help test the kernel by performing type-checking, lock checking,
> +value range checking, in addition to reporting various errors and warnings while
> +examining the code. See the Documentation/dev-tools/sparse.rst documentation
> +page for details on how to use it.
> +
> +Smatch extends Sparse and provides additional checks for programming logic
> +mistakes such as missing breaks in switch statements, unused return values on
> +error checking, forgetting to set an error code in the return of an error path,
> +etc. Smatch also has tests against more serious issues such as integer
> +overflows, null pointer dereferences, and memory leaks. See the project page at
> +http://smatch.sourceforge.net/.
> +
> +Coccinelle is another static analyzer at our disposal. Coccinelle is often used
> +to aid refactoring and collateral evolution of source code, but it can also help
> +to avoid certain bugs that occur in common code patterns. The types of tests
> +available include API tests, tests for correct usage of kernel iterators, checks
> +for the soundness of free operations, analysis of locking behavior, and further
> +tests known to help keep consistent kernel usage. See the
> +Documentation/dev-tools/coccinelle.rst documentation page for details.
> +
> +Beware, though, that static analysis tools suffer from **false positives**.
> +Errors and warns need to be evaluated carefully before attempting to fix them.

Hi Marcelo,

Should we include static analysis tools based on LLVM? For example,
Clang static analysis.

> --
> 2.35.1
>
