Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033C049EFBC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344808AbiA1A3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344661AbiA1A3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:29:07 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9695C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:29:06 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id p5so13589156ybd.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SO2+JzxHK+hKl3eAB0fkaCgW98RekOQd64uNGQYxMeU=;
        b=tEgpyG1lXt0DjR3AdBgGkabdtrfj9LRT3HUHI47f9rGTsSjqr2C38Vin5QdmK7XsEd
         LiWEkikozqK+Kxlh+Xl5xcNMDicAGx5q+dZYYWj+Ted6Pf3/7HNoXuWRwf9WIA8Hc2x0
         NS5kVyApME5k2VYVyW2kTETR0E1Obydbc5FW+XOqiv10EuDZGN1S5kgRJtu/4j6MFso7
         VDVvfzbrkfN3Oje9jhVXLpRvwmeREmJr4V01GVQtJIUyKfX4DRuCnh89mhCXhJ5Qtktq
         +i1Go/887jxK6IWTNlHheHVqJsFWXKgcJIUSzZdbAwMgm2+J9BOuI7xXuSbknth+kxT4
         4cNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SO2+JzxHK+hKl3eAB0fkaCgW98RekOQd64uNGQYxMeU=;
        b=t8biA6rdFNYlatTXmx2smrkuYHznqH+Yd+sq3pzgo8j7jt2YVmZ+qaP2ZanIGJtden
         MkISour6e12oPY7RaLSkFEzzVLu151IZyXiwUDRiESXmX6G5Ir2Dz7t1bVxyNYb8YFhJ
         Jb9DDVOy+EPx47C8V6jrYIwJ35soukarGuqH4L1u7YpkgTTEMS/DvfKI+6i3bah7+XJ1
         rDFfutAcujkiRUABRAdlB1CPivRJd0pl/qW0ltxb42UPxDBjIcgTMDQ89EnPITDwCu8j
         SZR4kpShINOSNaXoqwGy4URxBJ4Gad3XHw2+ccdXu0ltx9/nMZWnts84XuEcs5UZyoz9
         p/rg==
X-Gm-Message-State: AOAM530AzErLsS4uW8KLprcwDWyNT9XOi8jzpPKoOY1yDniDZMsLE16/
        h0b6Cm05qwdiII0E5YXKQkOAbBNixOmSXrk6g3M3xA==
X-Google-Smtp-Source: ABdhPJxkmqd4rValskDxRgzWGaJtqXQJNt0ZByBJH6fpmka7ZQcBPZ1gNxy5VQjSGPh1I9735XssXyVx0g5aUk+VlaA=
X-Received: by 2002:a25:cfc6:: with SMTP id f189mr8954363ybg.322.1643329746206;
 Thu, 27 Jan 2022 16:29:06 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220125032825epcas5p2c5cf48a773fd26e089b31b0f6ddde83f@epcas5p2.samsung.com>
 <20220125031604.76009-1-alim.akhtar@samsung.com> <20220125031604.76009-3-alim.akhtar@samsung.com>
In-Reply-To: <20220125031604.76009-3-alim.akhtar@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Jan 2022 01:28:55 +0100
Message-ID: <CACRpkdZeXKmKtzZseJA36qQnHen1psjcXqy4tN+pJH2y9XZFzQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] spi: s3c64xx: Add spi port configuration for Tesla
 FSD SoC
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        broonie@kernel.org, andi@etezian.org, linux-spi@vger.kernel.org,
        linux-fsd@tesla.com, Aswani Reddy <aswani.reddy@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 4:28 AM Alim Akhtar <alim.akhtar@samsung.com> wrote:

> Add compatible and port configuration for spi controller
> for Tesla Full Self-Driving SoC.
>
> Cc: linux-fsd@tesla.com
> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Andi Shyti <andi@etezian.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Now I however remember that there was some discussion around
the compatible naming. I do not especially care which naming we end
up with but just make sure the compatible naming is the same in
this compatible as in the rest of the platform.

Yours,
Linus Walleij
