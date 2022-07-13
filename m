Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946A85733D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiGMKJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbiGMKJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:09:11 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352143121C;
        Wed, 13 Jul 2022 03:09:10 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3137316bb69so107029767b3.10;
        Wed, 13 Jul 2022 03:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E2TlXEAIZFvPmK9h/xYib4bfCYK2i9suWn0UJBr3XYM=;
        b=R3H4xNPlytdYvhfcrA/DcKC13l0wft2b74FnHF4HmnuTvRR0I3y2nSP2CYLjeCfDoh
         NJ5qHO0dtSkhIJdJAbf1RveCRGZ9x4/8goj3FTvPgpH3g4PUk9NghmHXKMaiw1DgTYUU
         nwIW9fMp6eKwqHQ3OqbxssE8oSLuHJ8U4vHhD8IpHebZ7OtZ8J9O1OlAZlYBqczLvHhH
         y8gGWMN+iyIkEvad+0efDNndedad2bIfckI5w9cpwqLUtDYvytP1XlvTRRYT4YjX3nc9
         VDZRsSubYRIDE+3U17XV10Ln9L6v+wAhQfzjN7fxM4TW4z89LNoRZTGyuNCF1GyxBjf/
         KKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E2TlXEAIZFvPmK9h/xYib4bfCYK2i9suWn0UJBr3XYM=;
        b=CEP0SwqYLrw78ith4hHL1dJCJi99mahqMKz8oP/qTWF9PJf+qM5mAipvWTo622zufx
         oS0/0UcQv+/tM5JycDiaIBX7NciXG5zgC9o39aqwxUGGmnZ2dZSI+WyhdB/KqZvIsZeZ
         Z1qBbl4N6JZNxs2hF/5pUskXMry0T4tPdIW3DpVPHPy7tdrz75NFaU1y7aMhElfY0xTA
         NyS8gRP7MTTKMlTscVA5OyE2qNU2JGh+uub4lKePeT6ZVraV4DizVsEnYWXBx9cgbNOL
         QTObFk0NNLG6neOPmLAfd+iCC9PzqVZa1eOJll0YNr7ag3cLlaFN8PB/b4n9ptVMmEmR
         Iw6Q==
X-Gm-Message-State: AJIora8vNiFOImUr2XOoT8sZjN3GrdbULVEDx8Tybr0DXrD/ziNA6+Ma
        oYoVDTvhsl/tSmG2I2nlCRag6nyECPMH/pV/5O07zUXJCwWV2A==
X-Google-Smtp-Source: AGRyM1sXzAkkd/7ZVWugsi73rSqHwX/V3GSvpVnMufS8fy6MNP+macidwe8Zs38ZimRkNTGAgbxphdkC5zSaL+YgpI8=
X-Received: by 2002:a81:108f:0:b0:31c:d7ae:9ff1 with SMTP id
 137-20020a81108f000000b0031cd7ae9ff1mr3203739ywq.18.1657706949440; Wed, 13
 Jul 2022 03:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220713013721.68879-1-warthog618@gmail.com>
In-Reply-To: <20220713013721.68879-1-warthog618@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 12:08:33 +0200
Message-ID: <CAHp75Ve-VK8fVy9=sCZHV7yx84zbXKjB9WGBq=Cj0mM8ew=DzQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] gpiolib: cdev: code cleanup following hte integration
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>
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

On Wed, Jul 13, 2022 at 3:38 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> This patch series is a collection of improvements to simplify the
> code, improve readability, and compile out unused code.
> There are no functional changes.
>
> The first patch is a cleanup for my recent linereq_free() fix. I
> noted then that the edge_detector_stop() could probably be safely
> moved inside the line desc check block, but wanted to keep that
> change minimal just in case.  It can be safely moved, and so here
> it is.
>
> Patch 2 makes use of an existing macro to simplify a call.
>
> Patch 3 replaces some more if-else chains with switches, which is
> more readable (YMMV).
>
> Patch 4 reorganizes the line identification code to share code
> common to alternate paths.
>
> Patch 5 consolidates a number of separate flags into one.  This
> reduces code complexity, simplifies any future edge source additions,
> and makes patch 6 significantly simpler.
>
> Patch 6 totally compiles out the hte specific code when CONFIG_HTE
> is not selected.
>
> I've based this series on gpio/for-current, as it requires the fix
> patch -
> commit c8e27a4a5136 ("gpiolib: cdev: fix null pointer dereference in linereq_free()")
> Happy to rebase if that doesn't suit.
>
> Dipen, I don't have any HTE compatible hardware to test with, so
> could you check that this still works for you?

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for uncommented patches.

You may also use it if you are going to address comments as suggested.

> Kent Gibson (6):
>   gpiolib: cdev: simplify linereq_free
>   gpiolib: cdev: simplify parameter in call to hte_edge_setup
>   gpiolib: cdev: replace if-else chains with switches
>   gpiolib: cdev: simplify line event identification
>   gpiolib: cdev: consolidate edge detector configuration flags
>   gpiolib: cdev: compile out HTE unless CONFIG_HTE selected
>
>  drivers/gpio/gpiolib-cdev.c | 286 +++++++++++++++++++-----------------
>  1 file changed, 149 insertions(+), 137 deletions(-)
>
>
> base-commit: 7329b071729645e243b6207e76bca2f4951c991b
> --
> 2.37.0
>


-- 
With Best Regards,
Andy Shevchenko
