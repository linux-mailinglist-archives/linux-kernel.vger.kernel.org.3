Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FE54AED86
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiBIJER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:04:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiBIJEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:04:14 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3809C1DF8DA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 01:04:08 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cz16so3635786edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 01:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4MJZRpDu7px3hzAL62uWvtStglik1kTMv6esLPZmHkQ=;
        b=GAU2UQ/RY2pIX2GmuJ7MaIMU7gN67xhuckkp6l7CJoUXKE6KRXl8YpT7gq7hSd26/X
         to2r8r5aGhIg525KpxEuFMeV0mVFrHZIe+1WLgYtKm5apOxZCVSedOtgUYiLIrVis5MO
         s3haBaz2cUcKSs38t58gXcPz2fwbsgjD049wdiS2dIY1lBE8vISTsxEo/JlCPKflliaM
         OXQbS3Suv4JGc2ehJ+epZDtxmTprkhTfdTJZQ/KreSIxu5PERMen4Szp0r9/BY0H7QHt
         IpTPrvEw/sEhW2CiyPJflMT+dlNbz4TVWe+cmqUnbEiSiGXQfNhrtp9K774bWbIrdgs7
         dxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4MJZRpDu7px3hzAL62uWvtStglik1kTMv6esLPZmHkQ=;
        b=XFO2cbDScl1zYRACykB+yB1mFLxpab3inGPsNZLp7unkmcePttFiEBZhwW8CEl0sGo
         as9L5T2YHSXMpYjqu3c96UH2UUMYW3NGUyI1Hg2RRN9GF55hOPtiagOJEshCtiOq0vSf
         4r9CvfsRcAC2xViumjKHLwrTt2amFVcCkcLoXIpsXsMV4fIWQ0j81KxxyTEf83Wxv9BU
         attHcK3J4obNH1jcn0bkh8venKFoivERzQbK+oJYZ771eMs6tZcywKpEMIP4yfKF9DkC
         QxMeBnwli3By8HER5/5sfvgSCaI8wkMFQBzhECO8gDJ2UIVcpK3OUWmnI+LDujdTz3KF
         kEwg==
X-Gm-Message-State: AOAM532zkG+CkmykoD+N4YkHUVTvRmpbOJWlulpln34YozMUUBLUEwF4
        2pdxYRmTzfRl9R5f01ST/KouWYVhop7IuWyXL1IbKg==
X-Google-Smtp-Source: ABdhPJyKoXmsTwTN4HrstgLy4ApxQgcwa+O8Y9wd29EmwhIN8g4C3xsnxpN75JPBscEQOgAoqsgIwR3g+uY4PfKIArI=
X-Received: by 2002:aa7:c947:: with SMTP id h7mr1292056edt.447.1644397418840;
 Wed, 09 Feb 2022 01:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20220209085258.1468649-1-clabbe@baylibre.com>
In-Reply-To: <20220209085258.1468649-1-clabbe@baylibre.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 9 Feb 2022 10:03:28 +0100
Message-ID: <CAMRc=MfFbU=QgTgcXFwOa7xVEZD7ugPjQ1uXXQqqKpGrUQY1JQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: gpio: convert faraday,ftgpio01 to yaml
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     krzysztof.kozlowski@canonical.com, linus.walleij@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 9:53 AM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> Converts gpio/faraday,ftgpio010.txt to yaml.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---

Applied for next, thanks!

Bart
