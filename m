Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F8D493BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiASOgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355251AbiASOfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:35:30 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A610C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 06:35:13 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id f24so4781442uab.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 06:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLgxgM2afbaDj1scoJJyoJXdiR5WXv+QSndG8neOGUo=;
        b=g1zH2Kto7io35PJPi5MA+AdWvRs/0eqilwW0xwumESemPMzRmJ4FiG5KL20XG4a9+E
         ee+c7e0BCEU59SOEeNqGgDnjB8x6U+ECkau1S+4XFUMlWLjcFQr9uxY0xdaArjtHALyP
         //yLUvFGrW79FCQZNZbEHvWdwYyVsA4x7pMj+ePO6p7ryavNQUweENCuLgUYF8ArNmsP
         4YRRNO6GUQpsRoqaLYBkyVi7xCj/2FoyuguxApYPuhWpKsRmgyWhHU2iBR26OgQknxPW
         AmIJH+RDicT11VS5ehBInkko6OnJ/9ggrYuRUeNFJ3bXyeg+4qdx0ffE3xIpdB6pMvtk
         HUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLgxgM2afbaDj1scoJJyoJXdiR5WXv+QSndG8neOGUo=;
        b=SLush5MgyUaj3jPsoZ6ndeyin3Z1BadjtFRLWjND9EH73l3nQYgre6W8JAw2GDedjd
         /7jkKSxCjsaRkSFWTnbmwsJQIVW8NiFU53oAzE1KnHc6m4zo+mC2RkP66Jvwdoj51hol
         V8LVHjn2xt/pJb1by7bt9ZZTDc86WpZiytf+j4szL1k/LTetlDwm+AJfabnLAOfqhONB
         1Km1JLYLx9kIr+4jOfThhQO5KA96QazkAar924U/AR3WqThsCni5ekpQ27XMcCqmgCAz
         6LIg63XbSj96dv5dJmvZOZyG1hbmCXX9/EH0ZunDu1x3uYwg0g/DEM7uNiQYxIgojJRO
         qGmQ==
X-Gm-Message-State: AOAM533r5CJH/jQwME4Z5Pvu6JNb4TdQtRPmUbBCZT0kPnLLDvZDTd4a
        Ookku0g07l8gVEjlMSafud54vWRxU9hRGAWc8vYe6g==
X-Google-Smtp-Source: ABdhPJxOruJaoz/pWwTVy4wuzkYZkvTsWWKQ2sxSaYu79R6cOGJjr6S5WsMsXxmmNtYFC++JOIanZkWJ/VmgFGUTkfk=
X-Received: by 2002:a05:6102:108c:: with SMTP id s12mr11738010vsr.20.1642602912348;
 Wed, 19 Jan 2022 06:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20211227112959.7325-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211227112959.7325-1-krzysztof.kozlowski@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 19 Jan 2022 16:35:01 +0200
Message-ID: <CAPLW+4=vEYm6dGSCXtmiXUVe7FT6p=6Uk=MCvEsEgcdTz-R0NA@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: samsung: Second pull for v5.17
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 at 13:30, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Hi,
>
> Second pull with DTS for ARM64, on top of previous pull.
>
> Best regards,
> Krzysztof
>
>
> The following changes since commit 51b1a5729469cef57a3c97aa014aa6e1d2b8d864:
>
>   dt-bindings: pinctrl: samsung: Add pin drive definitions for Exynos850 (2021-12-20 10:35:32 +0100)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.17-2
>
> for you to fetch changes up to a1828d772e0738c30a383a7d335aded2f2baf908:
>
>   arm64: dts: exynos: Add initial E850-96 board support (2021-12-22 12:31:13 +0100)
>
> ----------------------------------------------------------------
> Samsung DTS ARM64 changes for v5.17, part two
>
> Add initial Exynos850 support and WinLink E850-96 board using it.
>
> ----------------------------------------------------------------
> Sam Protsenko (2):
>       arm64: dts: exynos: Add initial Exynos850 SoC support
>       arm64: dts: exynos: Add initial E850-96 board support
>

Hi Krzysztof,

Do you know if this series is going to land in v5.17? The prediction
(by phb-crystal-ball) is that MW closes on 23 Jan. I can see those
patches in soc/for-next [1], but want to be sure those are scheduled
for v5.17.

Thanks!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=for-next
