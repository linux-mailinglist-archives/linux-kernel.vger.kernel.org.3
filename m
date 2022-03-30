Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482724EB87A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242114AbiC3CuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbiC3CuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:50:10 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA00DE04
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:48:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c7so724556wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EsX1yG2UY6dKQjdKv6REamOui6sEFEfZYszWn7TYwFQ=;
        b=AeOcNN3TyAZRveUSpBoasKR41s2C51M7345EFMNl2cOgld40Kbjpp0y9767/7ryykU
         UiI/f6e5L84/1Yc4BGm9y3RjPs480QrdIPdMdn1YAZ9Su/mAIvRjaGhWH2PUC9hsJH7X
         Lu6OGequi3R4kpWmn9HtowHTzbUE9dpKnnyHCeXqPfgYzulVgybneHscpZU+xnh19Q6d
         rVFV9WB9B4m/7hnOYczjD8x0x0JPg5F83UJNR28qdLBCFhzQDvrTNXU+dkDIIuJayEer
         lh4Ls31qHB5Y3F/WF2vpNxefEQz1lsaKypoCl/584X2DxzwObkXtXPy9Z0pW4MUEHYH2
         A5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EsX1yG2UY6dKQjdKv6REamOui6sEFEfZYszWn7TYwFQ=;
        b=gADwHcPBUPu4lAhE11zNw2ImBT4dGq284x1tegcAo3LxonHr3FMtk33LAT82RPjuC8
         JhEqlOuhItbCBbmsuTGmHgLrxZHHmKMjfTs1c5bOVgXCFTWVyj8YCKX3eW3bJuM08149
         hAEf6/Lr/Y/oeLWCt3D4xYmCtdREKeiomuCdsBXCtqqnQOujPCVKn0usKx5VSSJFSO2S
         FPU3b2t+ZqWqAkyvWjxw+dG3nvR7CzXkF2uRKbgbWXm0kCRt+2DfoSDwRMATlu3EUWy3
         AXDeue4m/9jvpW6LoLKibNm8Xmn4iY3t+6tWEZ52C4YBYXIYLQjmggzfxs2Jug+fKCSv
         m6qg==
X-Gm-Message-State: AOAM531gEVLPJ60mCr4F7Cl4r1H7139zf+RwNptWsLKohGz8kX85MnEl
        MYDUBygug5TMoafOvk0nzhzkcEQ1dgLRApVglTTusQ==
X-Google-Smtp-Source: ABdhPJyFsvJGvTTAK3+q9dyt4LqD1Wr9tAnEeGd6ZSRdSLYdDJeRdtffEwK9SI/OU0xdqE15FFti1TL4Zr9nxp+kExk=
X-Received: by 2002:a5d:4537:0:b0:204:b35:fa8 with SMTP id j23-20020a5d4537000000b002040b350fa8mr36802985wra.430.1648608504388;
 Tue, 29 Mar 2022 19:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648593132.git.marcelo.schmitt1@gmail.com> <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <11f4750c6d4c175994dfd36d1ff385f68f61bd02.1648593132.git.marcelo.schmitt1@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 30 Mar 2022 10:48:13 +0800
Message-ID: <CABVgOSkb5CpnXDF_m7iy=A7RmN+KmY0T38TeZ4hKbmkdQgt6Yw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Documentation: dev-tools: Enhance static analysis
 section with discussion
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-sparse@vger.kernel.org, cocci@inria.fr,
        smatch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, julia.lawall@inria.fr
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

On Wed, Mar 30, 2022 at 7:23 AM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Enhance the static analysis tools section with a discussion on when to
> use each of them.
>
> This was mainly taken from Dan Carpenter and Julia Lawall's comments on
> the previous documentation patch for static analysis tools.
>
> Lore: https://lore.kernel.org/linux-doc/20220329090911.GX3293@kadam/T/#mb97770c8e938095aadc3ee08f4ac7fe32ae386e6
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Julia Lawall <julia.lawall@inria.fr>
> ---

Thanks: this sort of "when to use which tool" information is really
what the testing guide page needs.

I'm not familiar enough with these tools that I can really review the
details properly, but nothing stands out as obviously wrong to me.
I've made a few comments below regardless, but feel free to ignore
them if they're not quite right.

Acked-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/testing-overview.rst | 33 ++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
> index b5e02dd3fd94..91e479045d3a 100644
> --- a/Documentation/dev-tools/testing-overview.rst
> +++ b/Documentation/dev-tools/testing-overview.rst
> @@ -146,3 +146,36 @@ Documentation/dev-tools/coccinelle.rst documentation page for details.
>
>  Beware, though, that static analysis tools suffer from **false positives**.
>  Errors and warns need to be evaluated carefully before attempting to fix them.
> +
> +When to use Sparse and Smatch
> +-----------------------------
> +
> +Sparse is useful for type checking, detecting places that use ``__user``
> +pointers improperly, or finding endianness bugs. Sparse runs much faster than
> +Smatch.

Given that the __user pointer and endianness stuff is found as a
result of Sparse's type checking support, would rewording this as
"Sparse does type checking, such as [detecting places...]" or similar
be more clear?

> +
> +Smatch does flow analysis and, if allowed to build the function database, it
> +also does cross function analysis. Smatch tries to answer questions like where
> +is this buffer allocated? How big is it? Can this index be controlled by the
> +user? Is this variable larger than that variable?
> +
> +It's generally easier to write checks in Smatch than it is to write checks in
> +Sparse. Nevertheless, there are some overlaps between Sparse and Smatch checks
> +because there is no reason for re-implementing Sparse's check in Smatch.

This last sentence isn't totally clear to me. Should this "because" be "so"?

> +
> +Strong points of Smatch and Coccinelle
> +--------------------------------------
> +
> +Coccinelle is probably the easiest for writing checks. It works before the
> +pre-compiler so it's easier to check for bugs in macros using Coccinelle.
> +Coccinelle also writes patches fixes for you which no other tool does.
> +
> +With Coccinelle you can do a mass conversion from

(Maybe start this with "For example," just to make it clear that this
paragraph is mostly following on from how useful it is that Coccinelle
produces fixes, not just warnings.)

> +``kmalloc(x * size, GFP_KERNEL)`` to ``kmalloc_array(x, size, GFP_KERNEL)``, and
> +that's really useful. If you just created a Smatch warning and try to push the
> +work of converting on to the maintainers they would be annoyed. You'd have to
> +argue about each warning if can really overflow or not.
> +
> +Coccinelle does no analysis of variable values, which is the strong point of
> +Smatch. On the other hand, Coccinelle allows you to do simple things in a simple
> +way.
> --
> 2.35.1
>
