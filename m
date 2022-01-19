Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A7A493CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355575AbiASPLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiASPLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:11:38 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC828C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:11:37 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id w21so5031402uan.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5anB1qKvK2H23xAu6C3rLAmFkNsNDqtuvmZ4n6I1f5k=;
        b=nYkP7RSCsY5tI8VOsjbxjBTAKkAtJYn8TrIXoy/HeMG2qDzUZ0JAxvQByeeeTC8z2p
         nnCva2hhi+F+7kzew+MS9WMR17o7Q7mSHvenBMc3ufpLr8HR/PCfvyLxq9GPrVjtaW3b
         eYq8TI60FlxcNmK2rg7vtl9vlxvhDr0yBTBFvnjXzC5VtkOivOPVEUR4MoiJBP2yXwuB
         O89/pgWMHRe82JNQOuGzCjzDC8dKb7LgYcgpAuOeYjdQtL3mGpfe9Wz9RLAKsxgtadaS
         pq4CCo6zPs3Ifu5T4BirYOko+9/uNny6rVXh1TgI5d3sfImNv6qZGh7MUoR7aOjLaxRg
         RuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5anB1qKvK2H23xAu6C3rLAmFkNsNDqtuvmZ4n6I1f5k=;
        b=VxTHm3kByKzb6WrA3NsWjlB94xAbf0YA1HTzPZrbQ4vWFj217QcSFQuPxpmL2wI6/s
         Ejgy4alKMS+Qpb2DMNpe5Bstiq2UF8uqmD7Ju+dovkRKL/4OWNU1BzqyWlOwHcf/tXTi
         sopAfyZxvK7DYnKDH9SgoVfLl5PDQ3hFo0+jAgTBKmDkaP8YApElJZoN5/zwo8MpcEns
         +ie+N+Ka+Z+/Mng6VPRHf6+O3JAWmzlgETicG8GNpK0tZX6Twe2j0EmMUHAGKmppk8GJ
         nAFPCuV1chr4oqzsUJ17J1tKQkRDquyic5FO/SI7qLWxza7TdbLZ+twl3RA9ISoiX5JE
         ZWVw==
X-Gm-Message-State: AOAM533ZCC0naV4soSkC0PVB2tsBlt4n1iID0Rf3j/JGb8WAJHlSLZ0x
        Flp4JgQvr5pdW0Kh2zxc0c95KMIBmoUF+hvPM+hMCg==
X-Google-Smtp-Source: ABdhPJxZTOngZY8mSxHOCjIKQO7ZHkkdS3mwh/b9GyWVf+LVAkWPR5gDWBWXKrk9Zm39CMnsLd7vRxruUSwIXT7CnzE=
X-Received: by 2002:a05:6102:108c:: with SMTP id s12mr11846836vsr.20.1642605097039;
 Wed, 19 Jan 2022 07:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20211227112959.7325-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211227112959.7325-1-krzysztof.kozlowski@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 19 Jan 2022 17:11:25 +0200
Message-ID: <CAPLW+4n-1H5Yu3wQaus-UJ_VW_TjHrNUHaPCGCMURXg8EqxjyA@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: samsung: Second pull for v5.17
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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

Hi Olof, Arnd,

Just want to check if it's possible for those patches to be applied in
v5.17? Sorry for the noise, but that's important to me.

>  arch/arm64/boot/dts/exynos/Makefile               |   1 +
>  arch/arm64/boot/dts/exynos/exynos850-e850-96.dts  | 195 ++++++
>  arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi | 643 ++++++++++++++++++
>  arch/arm64/boot/dts/exynos/exynos850.dtsi         | 759 ++++++++++++++++++++++
>  4 files changed, 1598 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos850.dtsi
