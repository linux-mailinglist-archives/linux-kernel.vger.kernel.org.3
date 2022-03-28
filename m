Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA164E97BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243017AbiC1NQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243012AbiC1NQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:16:10 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BB81F607
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:14:29 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id y38so23273912ybi.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upE3SDU3C7PmeiFHIHw5TJWEmI++MEjL3taGlr4esD0=;
        b=EfZv6Bq8GrxdsUN0ohm2KNMCUo5KMF5yi14/mzkINXkalQGBmEbg5JnshyBfFMwYEi
         L0bRXIflaiMXmklQuDXjTbOQ8VVwmJ6RBp2b24Po26k/l0O3ZpHv+ejllmFxJVnuUzUI
         lndDpXOlYS+7zcXZFG/mjgzvFX3wOdek+LgXZ20NI8aMIUztkQacHCQDLPyBdrbTfjvm
         HqjQEbyJoGqeEvKI/nRjWCLaG2b6S289WkZL7OIHIzjUVF2eb9Z3Kcx6+BRxb6bGgaII
         LEc/9VwrqJIbpg171Sd+Z7jfdIVILS3gDjWcd8LeECY+XO9A8THOyIvQCnm10fXhIJ+3
         gPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upE3SDU3C7PmeiFHIHw5TJWEmI++MEjL3taGlr4esD0=;
        b=UDRsN1nHZvl8kaCu9/PN6UvlaAmxb66SM9R8Rzw2qDGPv7KDw1vDSVbWYm0Bflh2FS
         9NJMznbwaF1Bk8rrLaE0ng+tRFYrnL2x1h/LEVCrinLstJ5bNDeSqPUDtLfkCwLnFc1w
         oJxhFwtq3griUG3fF6KnQtrLJB0EdYB6zCWHp6vvjySF6GCX+YVar2uhUXyXARXvvaM+
         b9Fu1zjXQl7ep5mCZbEPav+o4J5JT34NkNzunXIvKSpLJm3P4atFqIT537kWJs6Vq5pJ
         LhQTIKwe9PhLE/TlSw2u+T/bBcP/1i8YeVNFvzuA0vA6UQ/jbYdb7kOBqtJJ0vHZ7Sc/
         iFJw==
X-Gm-Message-State: AOAM533pKxciSLoQXlxYlgWOvKBjqzI/Rsdl6NacFXBe+/8zjjfnEE2o
        RSkyEnlaPH2nvr6Jaye8/viPYAyBUpbUG3Fvc7Q3bQ==
X-Google-Smtp-Source: ABdhPJwNqWgS6omUR48daj1YAMojuzfje+uKRUJNG5FJfnkTUr8jft6B+QSyKWFojDCzCMz8v9pllzOTRFMprgvq+A4=
X-Received: by 2002:a25:d088:0:b0:633:b902:2d29 with SMTP id
 h130-20020a25d088000000b00633b9022d29mr22281939ybg.626.1648473268863; Mon, 28
 Mar 2022 06:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220311043015.4027-1-pshete@nvidia.com> <YjsTCRdc3yCLZkVY@orome>
In-Reply-To: <YjsTCRdc3yCLZkVY@orome>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Mar 2022 15:14:17 +0200
Message-ID: <CACRpkdY2E+8quTVVkCqoph-h6Ye+hEb+z+D5+2g=ArmfLpGR1A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: tegra: Set SFIO mode to Mux Register
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Prathamesh Shete <pshete@nvidia.com>, jonathanh@nvidia.com,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, smangipudi@nvidia.com,
        EJ Hsu <ejh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 1:31 PM Thierry Reding <thierry.reding@gmail.com> wrote:

> So this is basically what tegra_pinctrl_gpio_disable_free() does. I'm
> wondering if we need to do both, though. Are ->gpio_disable_free() and
> ->set_mux() always called in tandem? I suspect they are not because
> otherwise this wouldn't be needed.
>
> On the other hand, if ->set_mux() can be called in a code path without
> ->gpio_disable_free() then this may be necessary to get the pin out of
> SF mode. But that doesn't necessarily mean that the reverse is true.
> If it isn't possible for ->gpio_disable_free() to be called in a code
> path that doesn't have ->set_mux() then this patch would make the former
> implementation redundant.
>
> That said, upon inspecting the pinmux core, I don't see a 1:1
> correlation between the two, so this seems fine.

Yups that's how it works. .gpio_*() callbacks are just a shortcut
for enabling/disabling pins into GPIO mode, some drivers
don't even use it and rely on users to set
up the pin mux with explicit muxing instead. So these APIs
are orthogonal.

I'll wait for a version of the patch with your explicit reviewed-by
though.

Yours,
Linus Walleij
