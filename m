Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A352B5624A3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbiF3U4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiF3U4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:56:05 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C77730543
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:56:04 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t24so414004lfr.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ChOtKHwRJoKjAcC9z8ZRdCOei/XBaTbfevNHf17DEI=;
        b=Q8WTSMc+YZr+5Ty2lAUT360shOXmmKLKvU6lqblmOJWs/JUZdiN4aLhzt9n5h6vj/G
         rZKS+q0y5H+Mi22clQRVcI/cULX/vVZ4b9zlOY38QN1Kf4IgmBhS6j/IQW8KdU4ihyG0
         rroxiTzhJV28QDlNsLyHpPwRNQasA7P6XZMzrzuZXAqeWzWqa/wuAis5B9Qri3c5zsJm
         DIeejK+J3W4gLK4pd8xeF3MpVaaHBwCSrePvn0leurp6HjrgmqOMrRw9U5pmCiXdXKcU
         10EUBMNxcn3lKgFAVOtJacFsFPx0y8y70Qkxt230WNkQJzUwg9C+G1iw2Md09g0RjqbT
         9kmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ChOtKHwRJoKjAcC9z8ZRdCOei/XBaTbfevNHf17DEI=;
        b=7inVYPjiczfiQsfZFpfyxIlKhp5rYvHu5yaOX4qOFp2kS+2uWLTbiO0AtBCDncyUxC
         mujXO/vpEdhq5lBiCqNvJEbbsLr88Qw+IMjLQpOxh5Kj5dgpra0VOuApWB6Iznr6XiQW
         Q8etp1YUKADoSb7xTVut6yIk+6eew3TWkBrs+P1GXnlZU7nycVv/rqvEUhXc9G5/6o7a
         g4Xs9JbKxIfsnEDc6Kvg/pT/MaVrqS/81A5pSn1jE7W7GYlge2O2FvkXhBqgCpBGRzUm
         zs+GwGu4s3TqhlU9P+YaUvh8DUV45L0JFv1t0RzMd25ApllonppyfkkbUeseyXgIl2xs
         6otw==
X-Gm-Message-State: AJIora8rHMi0AearBT2hHiuyTCVyaBc7Q1/qHs4axLjE8Nj8rEXOj9mh
        BQzDqU1Yvixpg2o7gVEqqhtz1pGJoSDAMJT9KbnBGg==
X-Google-Smtp-Source: AGRyM1uEPehKhzCqbW4u7PMt0spuSRhI49qzB6qHixDXeQf5ZlFMYhntWhnpRytxXhdLWW5WI63u0TIuQyvwEee+Us0=
X-Received: by 2002:a05:6512:118f:b0:47f:69ef:91b4 with SMTP id
 g15-20020a056512118f00b0047f69ef91b4mr6597075lfr.100.1656622562171; Thu, 30
 Jun 2022 13:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220630080935.316394-1-masahiroy@kernel.org>
In-Reply-To: <20220630080935.316394-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 30 Jun 2022 13:55:50 -0700
Message-ID: <CAKwvOdn7o3KFKiaq+Xbjw-RuFfuawZiKSHfzcAAFDHFOKn0zPQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: remove unused cmd_none in scripts/Makefile.modinst
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
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

On Thu, Jun 30, 2022 at 1:10 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Commit 65ce9c38326e ("kbuild: move module strip/compression code into
> scripts/Makefile.modinst") added this unused code.
>
> Perhaps, I thought cmd_none was useful for CONFIG_MODULE_COMPRESS_NONE,
> but I did not use it after all.

LGTM
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/Makefile.modinst | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index c2c43a0ecfe0..16a02e9237d3 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -28,9 +28,6 @@ modules := $(patsubst $(extmod_prefix)%, $(dst)/%$(suffix-y), $(modules))
>  __modinst: $(modules)
>         @:
>
> -quiet_cmd_none =
> -      cmd_none = :
> -
>  #
>  # Installation
>  #
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
