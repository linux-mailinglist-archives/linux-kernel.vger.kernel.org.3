Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BBA4A2B3D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 03:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352168AbiA2CKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 21:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344877AbiA2CKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 21:10:44 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE9EC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 18:10:44 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id w81so1485002ybg.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 18:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5f2OnK3Rd5Vn0tCTo//kYep8PKjilqOgT9B0rx9Skk=;
        b=RcZP0mo9kQLiE+1boTRVPlI+uR15AOqJ0zvNtNm1+WteMErlFvqLS3Dc/UdHLboU9M
         1LEtspXyTBNQX8egXxjAs9FIFrl7CtqYAQ0YPkvlIPof0VvSAClFXiu/hxjeAKzaceAd
         9CT/4Qhex/xThPEnrTtYKHW5qeAWpyBTjA+ndei9I6TMF2+kpL3JF1aUAnVOMOklA4jz
         Afud+ZzhRUYYrcxjgAgWyZHSiF3zRWEiErCBtEtYsJVVXpjRssnM9Xh1gDN2dRPh4IdX
         w8cfTRrR3dMatGer75DzInLCj/QQe0uzTrMyciaj5OJCZRYskOjYZFn3dA9Iax1FmfIY
         LGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5f2OnK3Rd5Vn0tCTo//kYep8PKjilqOgT9B0rx9Skk=;
        b=fIA9eGk00M0gjdnga0ykPONwxaBou3T7FI3hDplaxMDS3hKTt0+sUOnS/0XJ11h7fK
         yMyjMHRd7fCtlLqzNMLTkJ4AOniD83MAErzbk/JLwFTcwkCCH906XIZxJct/18Scr++z
         ZHdjv4saxK84al9+NNTJ3o0SCWG5bCDI3j0pvfj4k3m1jApHr2p5xkzSNFTsnY6TmJZ7
         H2r26FaFKeDPuVRuQ/1Hv15qRP/1PwHdEFGwKN9Yyf7GDz0TajXjX59r2OnXd9/XpwA5
         LFkD+/68G+yaLYHXknIBuDJsuuiqFtE1sDXgu8NXt3VEeNylo0Onqz2x/ireDc/1rv1K
         u48g==
X-Gm-Message-State: AOAM532EvmYBJ7oE3GkoY6j2ejyADE+K7bnn9qIW3dD9qDNGWJwyeXtK
        GqqoQnDP/F2oaM0/y/4ypYiQFb5zuL6vCEcLNvUhKDcV+Kc=
X-Google-Smtp-Source: ABdhPJzBvJVAHTh7/0zc1+OGqU8AtCF5OhT9dVlcGmxGiDjOvbNcgZ2YHnWBsIQrGWW7fEK0LFQTUbImkyOVoGoH1Hg=
X-Received: by 2002:a25:2451:: with SMTP id k78mr15798461ybk.511.1643422243579;
 Fri, 28 Jan 2022 18:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20220127123028.3992288-1-clabbe@baylibre.com>
In-Reply-To: <20220127123028.3992288-1-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 29 Jan 2022 03:10:32 +0100
Message-ID: <CACRpkdZjKBboJsDWN1_UDyZXh9bT_+mmZ0swX0XDNARPSPJ3ag@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: convert faraday,ftgpio01 to yaml
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     brgl@bgdev.pl, conleylee@foxmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 1:30 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> Converts gpio/faraday,ftgpio010.txt to yaml.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
(...)
> This commit will cause arch/arm/boot/dts/moxart-uc7112lx.dts to fail DT validation,
> but the GPIO driver need an interrupt so the current moxart DT is incomplete and the error is appropriate.

The Linux GPIO driver may need it but that does not mean it is necessary
for all other operating systems. (Could be a Linux bug.)

But I think it should be there because the hardware does support it
and I'm pretty sure that IRQ is available on the Moxart as well,
so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
