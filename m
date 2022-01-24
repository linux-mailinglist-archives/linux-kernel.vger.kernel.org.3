Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292E2497A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242130AbiAXIWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbiAXIWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:22:05 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E493DC06173D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:22:04 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p15so19143840ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FAFB33t+2Qkjx9X9nv00JP5JosdgwKF5FoC1J64pQA=;
        b=1iQguK17dNmGjo07g3VoPTorMbJ1BquDbB0ueWBKR9ayVr17p44Zz9ppmDCiQ9hjBu
         96UU7fD6MOm5d78THBXufjnVyeGn5h9oNAHYa/v8UlSZK1f+gRTS+CfdUkIYaKqM2YUP
         Iyolq3fyk0wFTpd9devm7YB+8T7XBJze773uGThiPYY2ob1XWEkifiBeUYSk1Fro0Yp5
         ZO3Nu8TvJPGoUe9d51sDybVLV1LLaZhtjXgzGxJO45G6MMXADwEHbjTzAsUlcbCyXf2i
         kjsGXj4cqOcnqyOj7bozuLyVyqyIVF5Z0v/OPOX0Nx3nuyem1iwJ2UR8JeQKTqRGTvqb
         oQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FAFB33t+2Qkjx9X9nv00JP5JosdgwKF5FoC1J64pQA=;
        b=Qe/xnoewQE+kBxKeHfR6hMtlJSumWuJ08megg88pdDgcRW89CsijPW646j62pad1TD
         U5GbfjUTuDYwFs7+Q/h1zI5IEUonSqPuxWXDIPJlXi5ms+mShYdOwXQLJ64ExTQmubZi
         hTtkG3ryUor3fsyZoddgvJHcajTF/lfR/eZ/qO1W6LwNssDhMAhbG7q6eI8kY/Y/cQ3J
         3aZ7rKEyknRVw0Kzqzbvs68NhpQ4CsMtgYn6VRN5vpehKrnaQQk9ZCArMkPiIcu7zm+0
         4VpEEcMQ86XWzWeZMqFUihp/n5oPMSembTT6kfCGt25ztqBioMDhpINOxECdCjzCKijU
         ZMcw==
X-Gm-Message-State: AOAM530IbQq40VHdSMn8cOpKG9kx6kVh2k6nSQUHwCF3IeB9QKecnX7s
        HDRvqA+UAny769oNJ4ODivdfTLHpXSBjbvt6iOr3OA==
X-Google-Smtp-Source: ABdhPJwH5p6BLfavo5gGZUAy5CnEAgK66nA/Fqz4XwUHUaB0YjSnGdGqeRWPP/fN9YO9bjScYdUWk/5bxeswGFIP21s=
X-Received: by 2002:a17:907:3f93:: with SMTP id hr19mr11903724ejc.697.1643012523450;
 Mon, 24 Jan 2022 00:22:03 -0800 (PST)
MIME-Version: 1.0
References: <20220123073536.12193-1-rdunlap@infradead.org>
In-Reply-To: <20220123073536.12193-1-rdunlap@infradead.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 24 Jan 2022 09:21:52 +0100
Message-ID: <CAMRc=MeEeryzxWHBKE6ntjGYjo7FXWi9efovMPHY0bkJ9-Bb1g@mail.gmail.com>
Subject: Re: [PATCH ?next?] gpio: sim: add doc file to index file
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 8:35 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Include the gpio-sim.rst file in the GPIO index (toc/table of contents).
>
> Quietens this doc build warning:
>
> Documentation/admin-guide/gpio/gpio-sim.rst: WARNING: document isn't included in any toctree
>
> Fixes: b48f6b466e44 ("gpio: sim: new testing module")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  Documentation/admin-guide/gpio/index.rst |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20220121.orig/Documentation/admin-guide/gpio/index.rst
> +++ linux-next-20220121/Documentation/admin-guide/gpio/index.rst
> @@ -10,6 +10,7 @@ gpio
>      gpio-aggregator
>      sysfs
>      gpio-mockup
> +    gpio-sim
>
>  .. only::  subproject and html
>

Applied, thanks!

Bart
