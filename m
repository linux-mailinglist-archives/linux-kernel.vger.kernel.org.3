Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B5D4E2E47
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351348AbiCUQnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344532AbiCUQns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:43:48 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516A8160149;
        Mon, 21 Mar 2022 09:42:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h13so18582193ede.5;
        Mon, 21 Mar 2022 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3mkHbSPd6I9+pLUf+5v33zhbkXtwBKoba4Y44U/ghK4=;
        b=a0Ai9C62qgIb1RVT86zt38NbWnJNQRqkMjoCrmrXiZwPXFeTe6Ht+hsmJNS7tewJna
         scGc491WOFvu5S/IIHi4EV2J8ir37IrE0XDvJwohLd/8WfBWEd5s6DmUbAPP+3B1RINW
         xNuBwtWlj5XkWv3j75+yuzlwruE1gIyH1CkzACIp1XUmrAPj+Cb1/nE1HsauqLI8rnj+
         89GDlqR5aPnr0oJ5osM7/RxBlr80YoR4+wvK42G3kRK4hVtZquBOiWHDPBvb7w6BIBjE
         gEUEPKQvLvmanz0lMW03/xnda1BRRRzZyi6MsPXnbJ4X2CLWm/jO9eI3ZWeIiow/NIUV
         +yOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mkHbSPd6I9+pLUf+5v33zhbkXtwBKoba4Y44U/ghK4=;
        b=5IrMJ2URjhFynzQskU/BafLGsfkbkmbyUh3CjvOSpvyOYDjaEASv1RYBo+gi5UgP5V
         GetKqNpauGjXOLz1hai2sU1bRRqaHbwYc5n3AmBJvZ4pMxsylyRD2w0VO+5usuYDVhej
         ja4VidT6lXkinaHqu8wE2wEGtHxvcJC6+Nuxw21c1pIE8o5NjSoF4Fdk5tuk/5zXnOfk
         phBK5R2WPsvgDsz5vEj1pn7vr+696rbhLAR/H7++HTr6q4ij3TgbaPfr6PjBoQbi3Mu6
         DQm7uZ4VZhuKLhy1UVHUgFNa8Io/k8t/YscbHa9P+JGUitRnbV6knLlM1KzU29F5f29A
         Q3Rw==
X-Gm-Message-State: AOAM531AYMGxV6DBxA+gJxUGGH9ejj6t2Pjr62cepMGzGKIFwnUICWVf
        Sqm18hOjk7ukq7zgpJ7BqrgtN/BSIoZ0nboMckc=
X-Google-Smtp-Source: ABdhPJy6kGu1C15zOwE86ppG4LYIi0tngDeWHbiK2qe/U/8MkbskwiXnxOOq4nCBaUHg8BTEe8Ml6R4CDSJRdAm4d5I=
X-Received: by 2002:aa7:c30f:0:b0:419:2af:4845 with SMTP id
 l15-20020aa7c30f000000b0041902af4845mr20065302edq.296.1647880941751; Mon, 21
 Mar 2022 09:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <1647849919-8778-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1647849919-8778-1-git-send-email-haibo.chen@nxp.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Mar 2022 18:41:11 +0200
Message-ID: <CAHp75Veqswa9nuiRbuGE013EQ7d+-DWAiYqQG2o7p3=EDYk4pQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: Add gpio alias support
To:     BOUGH CHEN <haibo.chen@nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
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

On Mon, Mar 21, 2022 at 11:22 AM <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> This patch allow setting gpio device id via device tree alias.

allows

But read the Submitting Patches document about imperative mode.

Moreover, this commit message is quite bad. Please, read [1] for
making your commit messages meaningful and useful.

[1]: https://cbea.ms/git-commit/

-- 
With Best Regards,
Andy Shevchenko
