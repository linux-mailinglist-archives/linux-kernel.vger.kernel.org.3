Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BA84DABE6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353986AbiCPHj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344568AbiCPHjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:39:23 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23E333E0B;
        Wed, 16 Mar 2022 00:38:09 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2e58e59d101so12967287b3.13;
        Wed, 16 Mar 2022 00:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oyzqBAUobH5AqCttvDPX2yRj0zkubG2JVL8MLhBhiis=;
        b=EFiEGOXHpw1QHkLoq6Zb5G8me9dDVX44GNt10gqtJ5bY6VThYCn7lfZgBzWcUbgWnS
         yx0rIeqJhinNle2GAvAKGDJ+2jqTrEVIoCRGGyEyLex4u4YvkaI4/7YAYRZidJ5Zzh87
         p5vAJs3mMDJv5tiE7T1877sgTtU0Vowz/dvElKPINAzhW4cHgWXbM/+0UE6ZSCuVqtrP
         PLNqN40OhKT5rSxg6uVc7SvghC1aANFFeg9bBrJr2ieGn+IqyWx7jxXGoic3idCVo8ce
         1unmjTjSYwj8UCqKpVh6+AHEkfhEExWNdQpLSTT/jd8SBWUEJ/j02+wyb//R8W+LYqcm
         22LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyzqBAUobH5AqCttvDPX2yRj0zkubG2JVL8MLhBhiis=;
        b=BT0LI7GUvbB25Vx+DDqVqdl1CjbCxuPwT6U5WtnMh9wy5auQdACRl2TO4ZakekNSKF
         Gs04C8r4c4lIKSR5tS1jy6/sU3Zr4djXDm0g7tUUkq1qIHUDGfLXbJziW3jCesKmiyZ3
         bYZK688hYtjhXkWBfGrMBJDRQNPvjzcQJ9U6jSmIaSPovXE9ycAx0HMVro9/C4npCWvH
         F61keUDI98CefNhJ9VeKCi8QtHyjHXuzQ+gflWLZMup2YABKBRA9kFFurFpvc8aGyv+K
         +wi/zdu2LMgKts6d5L73gNM2pKI9F6zo3tmotG/bT0Og89l/ILVrHPvmRgaPYTlL9/GJ
         G+vg==
X-Gm-Message-State: AOAM530oS8QrtPZi71ugJrNYr3acVSeZiUEOdvOZvX0g589hEAjG0Ugn
        ttj/2ey0hPK3KjmRCKimK1jda6opecS8tnTHsrI=
X-Google-Smtp-Source: ABdhPJyP4zynEnOKJhPA6/VdLS1G8//zvpj5AamASMzby3h/EFhGf2TKXxmqAXvZB6D3G/cNI4ww1RuxxBh4CuEHTJ8=
X-Received: by 2002:a81:1cc6:0:b0:2d5:427c:a23e with SMTP id
 c189-20020a811cc6000000b002d5427ca23emr28475198ywc.496.1647416289010; Wed, 16
 Mar 2022 00:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647373009.git.vilhelm.gray@gmail.com> <b98d1a3ed4b0b324b261b23defd1bdddddba4d44.1647373009.git.vilhelm.gray@gmail.com>
In-Reply-To: <b98d1a3ed4b0b324b261b23defd1bdddddba4d44.1647373009.git.vilhelm.gray@gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Wed, 16 Mar 2022 13:07:57 +0530
Message-ID: <CACG_h5qPuMhJ-PAwArDXFqVCtn42qDypwNNOm9sP_ae4gPpYJQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 6/6] counter: add defaults to switch-statements
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     gregkh@linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Wed, Mar 16, 2022 at 12:43 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Clang static analysis reports this representative problem
> counter-chrdev.c:482:3: warning: Undefined or garbage value
>   returned to caller
>   return ret;
>   ^~~~~~~~~~
>
> counter_get_data() has a multilevel switches, some without
> defaults, so ret is sometimes not set.
> Add returning -EINVAL similar to other defaults.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Link: https://lore.kernel.org/r/20220227161746.82776-1-trix@redhat.com
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/counter-chrdev.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
> index b7c62f957a6a..69d340be9c93 100644
> --- a/drivers/counter/counter-chrdev.c
> +++ b/drivers/counter/counter-chrdev.c
> @@ -477,6 +477,8 @@ static int counter_get_data(struct counter_device *const counter,
>                 case COUNTER_SCOPE_COUNT:
>                         ret = comp->count_u8_read(counter, parent, &value_u8);
>                         break;
> +               default:
> +                       return -EINVAL;
>                 }
>                 *value = value_u8;
>                 return ret;
> @@ -496,6 +498,8 @@ static int counter_get_data(struct counter_device *const counter,
>                 case COUNTER_SCOPE_COUNT:
>                         ret = comp->count_u32_read(counter, parent, &value_u32);
>                         break;
> +               default:
> +                       return -EINVAL;
>                 }
>                 *value = value_u32;
>                 return ret;
> --
> 2.35.1
>

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>

Thanks
