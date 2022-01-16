Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6235B48FC7B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 13:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiAPMGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 07:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiAPMGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 07:06:10 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31E8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:06:10 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id a10-20020a9d260a000000b005991bd6ae3eso2610684otb.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 04:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2JKr0VhVhkCrnxhwrKxEZLONnSfW5FQCdXEB+dx8FvY=;
        b=ndUhiroZpnTdKQO7j2D83aBoJKHUMDbe5XUno1L/grKwtiT0At6LN8nqxwzRtR4gXM
         YofEm1SkkjAENJbnKq+ZQKnA2Hmc4uJu8vXBc11m9CJpYhkqDuDSQYzrWHEPnGc2NcRu
         5awSzFrm5WgY3U3DdrRLr+sbrWPwUdPJ51bPZZTvmYfOqKZ1WdFq+/F6t8+uS+xpH2iu
         VzbW2TLFTo1Jw0ldbpQrkuDrIpxsgeqYPsGdymvWqRR8ODASjyUhHaOLos8M/Tr9VIsi
         2Rmw9H8HGOiG8z/GzjkJWaUVLW2WgniE08yzhKpHEP01hnQNgS13olQ/73KWsVVKaLCb
         ju/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2JKr0VhVhkCrnxhwrKxEZLONnSfW5FQCdXEB+dx8FvY=;
        b=fos6eZ6FSwwmuTGe1kLYvRQF5Yn2nr3lTesGufK5ftd470TeXMS0vGIjhNlSUQAYbD
         8kcYDUriCoPuixNhLWHkeBnbqNod6OIAsSQk7sncWfW3oRK8sa3p3ypI0TcUH2bNb3rB
         lD4CxXNT8ts3GwA9EFGnstQo8/VcGp/jGiaiea+m65u/G4aygoErpNwMr+LD1Itnv3X7
         KaxA10tHkavVLGuJIqhDBN8cQzZz9OCW5l915Q/NwXQQ78Dza06fbeZFZElHeuTTr+7Z
         ab0XQ03ahEOayrS7glcYIcxLfEB0sL3H/wuXL9p3OCwcKx26lSNlOuBzyXvbJVxZlYvN
         uFJw==
X-Gm-Message-State: AOAM53216mfo6lU1afFO4szqhrzB0JMRRIWwo5ySzAG2b/Tdh2ICiIE0
        HjcaNwOBtL1+Qgm+jwaBSUZRWYtW+Ubq/4O9WrKcdQ==
X-Google-Smtp-Source: ABdhPJyZW2DY7OLm4V7AlnhiprfBMzKMRJwLFYA5jTMMRX+gM8CvfOrsMi4mM4UdWZfAdLOYxGGTFjyOrhpoeYpQKkg=
X-Received: by 2002:a9d:a42:: with SMTP id 60mr13235569otg.179.1642334770136;
 Sun, 16 Jan 2022 04:06:10 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220113122400epcas5p34363ba8f477b4c273d601d0b64324afa@epcas5p3.samsung.com>
 <20220113121143.22280-1-alim.akhtar@samsung.com> <20220113121143.22280-12-alim.akhtar@samsung.com>
In-Reply-To: <20220113121143.22280-12-alim.akhtar@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Jan 2022 13:05:57 +0100
Message-ID: <CACRpkdaRshgkwrAgF-zhpsDxjPPC9GTOYXvnXL927GyjDhbu=g@mail.gmail.com>
Subject: Re: [PATCH 11/23] pinctrl: samsung: add FSD SoC specific data
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        catalin.marinas@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, Ajay Kumar <ajaykumar.rs@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 1:24 PM Alim Akhtar <alim.akhtar@samsung.com> wrote:

> This patch adds Tesla FSD SoC specific data to enable pinctrl.
> FSD SoC has similar pinctrl controller as found in the most
> samsung/exynos SoCs.
>
> Cc: linux-fsd@tesla.com
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Looks good to me once Krysztof is happy with this I expect to get the
pin control portions from him by a pull request.
FWIW
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
