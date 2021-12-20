Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F1E47B110
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbhLTQ0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:26:36 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:58285 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhLTQ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:26:35 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MjSPq-1mbVvE0QTy-00kvTN; Mon, 20 Dec 2021 17:26:34 +0100
Received: by mail-wm1-f53.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so253952wmd.5;
        Mon, 20 Dec 2021 08:26:33 -0800 (PST)
X-Gm-Message-State: AOAM530RcqF5pDNv/pc0dYzWMFSQfbrsMk2l2Vi4TNA9RpDNJYzXIXvP
        pUpK6JQ3+UBm9ovL1lwMWcDb5u4E6FxTArupyDs=
X-Google-Smtp-Source: ABdhPJzwLrcEdHroPABlE7IJDleIxx8hF8kMeanu6+6idToBCIFPiLRY1JmE/9PmnlEOMB7YuxOroFdtYAkUkDWN3xs=
X-Received: by 2002:a7b:cc90:: with SMTP id p16mr4058397wma.98.1640017593504;
 Mon, 20 Dec 2021 08:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20211220115405.30434-1-krzysztof.kozlowski@canonical.com> <20211220115405.30434-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211220115405.30434-2-krzysztof.kozlowski@canonical.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Dec 2021 17:26:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1A+6f1OsJ-8-8kbmXXbbsrQZTQywOAy59tJoUmdDN49g@mail.gmail.com>
Message-ID: <CAK8P3a1A+6f1OsJ-8-8kbmXXbbsrQZTQywOAy59tJoUmdDN49g@mail.gmail.com>
Subject: Re: [GIT PULL 1/6] samsung: soc: drivers: for v5.17
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eWOF60gc+LvbFpDhWKiA/GiiQT+oM6NriT55/Wr0+bkXD8ns8ir
 GCIZd+t1nGwzfd7l1DPQZVGIKP7bcI3WaPbhgvbPHrEesXHRsyHaYtUhJrTP43nkv6aJNbD
 FK9qilSiyi6ffP1xvkpnkVZBneThyuq6SA3H1QA2+ZA0/S3TV6ZXZjpOm8z2gyuK+iAEtbs
 spvRTueMTfHBXC82LB2yA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uZCFLVqlupU=:ZWzRH0QDIgZnGVckRRNSYT
 lteOKfSY4es1dRM+pZBpcPXKUX0YPj731Hu7x1eBIfzTECC0NcNd0K8UCaklMyIbuJnAdhC/T
 cRpXNYn/giAvM4PexNWatiduU0WTjkKuIsOJ5xQiou+9fDy51N/+TYvLUjtbqrsoR0ocJWClX
 RjdHN66fKmfjaV4sVNzXx/jQpkYyOZEG7HjdWIDoPKbQ/pqN6isMq/2OAwPVwO+UEzIozfwGm
 L1jkEMmvkAWmBBV11dtzdG0naL6sTwskGBJSvUGQ/QuBPCoDaSYEMVnEhWEBlZ+t+/nZ+tOdD
 G53ekIme1W1UIZGJPL4TqkQfZmmFsoImmFqyefbNwwxJgyH9hO0Zjww/gOd4UHWieFXno+bBm
 TeINxiMF1VdD8se5vqCUkeVj5azS+bmvNYkd94J2ZcNTbw1r9nJ6MGENlJiBKhOnN9ro0uU5r
 NdYscGNceXg2wuYw61IDjpT9uzvFBhkYAsQLr7TK8pf6VJ4ytbbSbaL4JJzyMkRzKTGjayzEm
 vcUlZiEVV+yEbI8x0361KdynNrAOKEIQHJeZAuf8UK63fFyuPAdtS9PltK1pYQ6MSYBfLStOK
 6u9avEQ0nERESJODAh8p+ZW/H1+Saa8R4zZwlx7+tYXA6hHezGh7bpUl9ctSti0urHdP26jOF
 qB7kVwqzT56eRyPg9K0zRqMCw8+gwYY/zZ3IC7/g2bEmcH+btfUK6a6vTtJtRWfPKK+bREm6p
 kAVGsAr+bKva15wwNu27ODmCJZswI/1fcMUoRq1TJ810Er30u6j2M/dtL4r7rJHdngxLVusk3
 ZmsGD/EvWcv8ECA/Yc96NhC2UvSsObT3iGcTavZ4K7YqZujGOY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 12:54 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> ----------------------------------------------------------------
> Samsung SoC drivers changes for v5.17
>
> 1. Exynos ChipID: add Exynos7885 support.
> 2. Exynos PMU: add Exynos850 support.
> 3. Minor bindings cleanup.
> 4. Add Exynos USIv2 (Universal Serial Interface) driver. The USI block is
>    a shared IP block between I2C, UART/serial and SPI. Basically one has
>    to choose which feature the USI block will support and later the
>    regular I2C/serial/SPI driver will bind and work.
>    This merges also one commit with dt-binding headers from my dts64
>    pull request.
>
>    Together with a future serial driver change, this will break the ABI.
>
>    Affected: Serial on ExynosAutov9 SADK and out-of-tree ExynosAutov9 boards
>
>    Why: To properly and efficiently support the USI with new hierarchy
>    of USI-{serial,SPI,I2C} devicetree nodes.
>
>    Rationale:
>    Recently added serial and USI support was short-sighted and did not
>    allow to smooth support of other features (SPI and I2C). Adding
>    support for USI-SPI and USI-I2C would effect in code duplication.
>    Adding support for different USI versions (currently supported is
>    USIv2 but support for v1 is planned) would cause even more code
>    duplication and create a solution difficult to maintain.
>    Since USI-serial and ExynosAutov9 have been added recently, are
>    considered fresh development features and there are no supported
>    products using them, the code/solution is being refactored in
>    non-backwards compatible way.  The compatibility is not broken yet.
>    It will be when serial driver changes are accepted.
>    The ABI break was discussed with only known users of ExynosAutov9 and
>    received their permission.

Thanks a lot for the detailed description, very helpful!

I've applied pull requests 1 through 4, though it seems that once more
the automated emails did not go out.

I can't find the two defconfig patches you mentioned in the introductory
mail, neither in patchwork nor in my inbox, I assume these were
numbered 5/6 and 6/6?

        Arnd
