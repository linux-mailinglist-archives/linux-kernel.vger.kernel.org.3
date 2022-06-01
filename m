Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6050C53ABAB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356284AbiFARR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356283AbiFARRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:17:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3704F465
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 10:17:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jx22so5075742ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rvEstZ8YIWy78PUgcDfFLHa+ABtELWwpbgGgu43O2s=;
        b=0s5XHGMOGGOKEUUjfkhN8iNwsRZ9mx+PaA0J85ChtBmXUl217uNzow9HFCG5MMfhhQ
         VRo3xZr+2cycrvtlJA5CbUzo9qz5bjqfNjX/eYXky7KH4MNgjpJBGNn1RT2Fkde5gmYY
         j3i55w4v6o0Xjqzh4bXEAje33gmws+vTXhVRntr19QU1B7h2v7FFtXyBXiBR4rnsUIs0
         BDi4wlVfLxoHMc/VnUqx6o+mc9Lyx3y6SopcIKnq9Txm3KeG1mVokNICOVwH43ITvLTY
         GErBqo/g9QulgMm+hKlOJxT6Lff1Zw9L8AiS/pBUm3NLVEYC1tPi316b/9QmeVPDcPQ+
         5C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rvEstZ8YIWy78PUgcDfFLHa+ABtELWwpbgGgu43O2s=;
        b=PWcg3GoZOKGzrD/55ZIr3p9+epz+pow3IC4zrWGnM2TBXNB2KYoUOJz83Ou57FRTfs
         Eys9OhA0vB+vkOX16jCni4G849RJgQdIvrHtppTfLF8k1TGiZM6gRXmFyzldlHu8r4Gg
         UG6jqo/8zjzHD7fqMtL0MpUGS13JVf+GfvOmCASpSH26u3t3TLr71jvExnsimoznaRlH
         qRvut2v9o1ZWu6AN7HJ+f/aYUHaCbii34PnAvnh85Sn8jxngHycf9IuyOjA20h7oFDPC
         qwUjBzuM3qf4JYUuoQ9bp3nXU+Kh7j5+OQtK7A2JcoS+7XZ2LaGHhbW4Eh4hpVMR72/z
         cmQg==
X-Gm-Message-State: AOAM530XK4rMJtDmkqMQ8qx4utCbGyxfKfL/NaueWHCsWxcV9+l0BATT
        OJqvdptQR5M1Hv+X3+L1ghSkP7r4nCKl1wItgs349g==
X-Google-Smtp-Source: ABdhPJwvWvNzrOaDpwtNWrwMno130EiItXv/RMx+3bTrm3LIuoqoWd/cQM9cJ2cmBHHlpvFEs6k8eSbGOrYFixXNTc4=
X-Received: by 2002:a17:907:868e:b0:6ff:39e0:2653 with SMTP id
 qa14-20020a170907868e00b006ff39e02653mr532425ejc.734.1654103868101; Wed, 01
 Jun 2022 10:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220530115903.70509-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220530115903.70509-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 1 Jun 2022 19:17:37 +0200
Message-ID: <CAMRc=Md9GQVg5jMH5ghOVamt8fqVoGcH=JZ0dXRDKP9_T7X6bw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] MAINTAINERS: Update Intel GPIO (PMIC and PCH) to Supported
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 1:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The actual status of the code is Supported.
>
> Reported-by: dave.hansen@linux.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 629ddf493555..bacb41953679 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9810,7 +9810,7 @@ F:        drivers/video/fbdev/intelfb/
>  INTEL GPIO DRIVERS
>  M:     Andy Shevchenko <andy@kernel.org>
>  L:     linux-gpio@vger.kernel.org
> -S:     Maintained
> +S:     Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git
>  F:     drivers/gpio/gpio-ich.c
>  F:     drivers/gpio/gpio-merrifield.c
> @@ -10022,7 +10022,7 @@ F:      drivers/platform/x86/intel/pmc/
>
>  INTEL PMIC GPIO DRIVERS
>  M:     Andy Shevchenko <andy@kernel.org>
> -S:     Maintained
> +S:     Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git
>  F:     drivers/gpio/gpio-*cove.c
>
> --
> 2.35.1
>

Applied, thanks!

Bart
