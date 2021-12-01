Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01E8464997
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347936AbhLAI26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbhLAI25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:28:57 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AABC061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 00:25:37 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w1so98485481edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 00:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kw22QiGwjC/MpLMxqNFKKVjnGkXft82mu8fSQLxtNdg=;
        b=1XqiBUKvbQz2TtvA/8rC/1/xPED27tjAg1sqHsFv2Z6A52iuF1E6PwmpgOWqOZZGGM
         5ZKVbhUSCC2ISrBhb6/OSLVkMek2lkpEmni5AjQv/J18EgO9zURLXQl/Slep8YIKHBEo
         IiFu8K0CMNZedcBEZR/gVzQUz6Em3Pc6xYEEdE3S+vyFR5qaOycJPBfbhYgRYu4oGmyJ
         oPmJpl4UYizT0royo/w0UoeVdCvhu+VFhUxniJ2CwVpvWgV46mevx3JRoRDO5gvHnM/D
         SU1zichbdPCfUo9AQzhNewjZ9Y289X3/l7sFy+F2jEutLKk9g8sLhRig5+1hJJ9c2H7g
         9vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kw22QiGwjC/MpLMxqNFKKVjnGkXft82mu8fSQLxtNdg=;
        b=EUwQ+fN1dzlZbC5qrZbvklR6Y5l5SLBgihqwYymEyjhV7cQ2+k7uUV9b9k59ekZqFj
         jR3iUsokQGubhX1/+UtVtlV3hND9gxJk90HHs2lmU/8wvxGUwHbigCcVqzwjK9V5kDVJ
         wUutLViHRDj7lZW3mYzafILR8rgKGyNRzmTTw1w2a+zH/khVZJccK65N0Df0p7mrrnqT
         oiSfj51K5oIq7OE1Ys53Fq7gtBmJY28BkhiIp2EmXl7IQZHwGJI0+U8PBILTD4O7MaT0
         lzaTulFbCSDg18RxI+yG0dPJnZrFXNz7OESZ5wvv4fMpuNDD5Euhuvs7qvJgdOWwQuCb
         mUQQ==
X-Gm-Message-State: AOAM532MtfaR4flt8j26qsWMg5SOSG0p9hs9U7YSMZppyVkHaj05lJpR
        dwAZl7VA1NOObf2s1TtVqNBy/i5PyOmxkyk57CS6gg==
X-Google-Smtp-Source: ABdhPJzb5BRBjOhXvHPL1fVhXhzMK+PvGhYvVB2OaNLvE9sY9U/PqvQBXbc7exJy5oy1WERmjupClMh4reDxs2hKCTA=
X-Received: by 2002:aa7:cb45:: with SMTP id w5mr6562608edt.405.1638347133203;
 Wed, 01 Dec 2021 00:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20211130195817.2911086-1-robh@kernel.org>
In-Reply-To: <20211130195817.2911086-1-robh@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 1 Dec 2021 09:25:22 +0100
Message-ID: <CAMRc=Mc-8--9+N2uGWhY6whwuJKCg1jtnnTYyQJifdSS2Um+qA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: xlp: Remove Netlogic XLP variants
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 8:58 PM Rob Herring <robh@kernel.org> wrote:
>
> Netlogic XLP was removed in commit 95b8a5e0111a ("MIPS: Remove NETLOGIC
> support"). With those gone, the single platform left to support is
> Cavium ThunderX2. Remove all the Netlogic variants and DT support.
>
> For simplicity, the existing kconfig name is retained.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Fix !OF and ACPI build errors
>

Rob,

This doesn't apply on top of v5.16-rc1. Anything I'm missing?

Bart
