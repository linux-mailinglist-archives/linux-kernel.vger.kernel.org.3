Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6799C526B51
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384313AbiEMU3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384271AbiEMU26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:28:58 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BD815793A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:28:48 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id o130so1653436ybc.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J2l+7pycfnV5tL/FeqC4BRRTmDMvEO1d4ShvU8Pi4JY=;
        b=Z8HRsEVnERpdmjZslZsddk0NgJt8PEAh8MLOqTqCEajMguIFpTBGJVNEC721C/Z7PM
         +/Sit+OyXmXiBrLslU5E+sr2R6BWDwkSRBIGVRonJqwM4SASdDDcdcSAbDxwglEOOfOk
         xDXSkH+WKLARytcpIm6K8R7RbOwnLmQNuJ49g97xOc+HKI2SqLQT/OA3xTH5YzZga8AF
         tkdZqb2wMTsdoXNwz3OKQDe6n1SbT8104I2jd7mY1gh4p0AnmhmoK/nyrETO2rDTRZne
         G3p6f3NXN3BNYnx8ckYsKss5J5EYCea2C7tt6x/DUfZehN/XxeU8ljG/iEmJ4dxc46St
         Itqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J2l+7pycfnV5tL/FeqC4BRRTmDMvEO1d4ShvU8Pi4JY=;
        b=klSaOPhHTL/2EhfrucG32+GUC88IQ4v+9hQDFNI8o/tAIfMg1AEcylkFLVmovB2QoM
         A60PTEMmF2obleW153EWojlmaKXCmcy4ZCgTA34coOmYC/PQPkv9rJR4CHUt6Ps7FGWa
         Bu/y7xiy4Bz/VrALWY1vjoe7M/VNUaQvmFU7sAqaZAPMgJcUBZTB3tqC8gMURNPm1yWL
         3STP3Bq3gpQD8dTrKcEUI0LfDnFbXENZUAW6ZTDvLBJ5LhTTXBIfVQ9/rzoNYxjcYU/t
         8hkP5QlZ93V2AZlTY10IJ2ENpqdAsufjrLbJaGAzhitNDtKulqgOSc8fLIyWMK9M/yS6
         G1aA==
X-Gm-Message-State: AOAM533CILQ1MJd3s//Nc2OMJoZlr5l7f691aUQcyO7+UnfLx6j1ECBz
        fw2qFPfUIzdzzHknW9jfD6+Xf/Ayu7Cv9rHwHHybGQ==
X-Google-Smtp-Source: ABdhPJzpsIprE1mVevIiKrqLa1rexOsJwYJXY46LUj9YMdYjW6XP8MscpQDLdK6N5tP7dIpU5bfhNO1Vc+OXpXCWczg=
X-Received: by 2002:a25:e684:0:b0:645:d429:78e9 with SMTP id
 d126-20020a25e684000000b00645d42978e9mr6876546ybh.369.1652473727879; Fri, 13
 May 2022 13:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1652245767.git.jo@jsfamily.in> <BY5PR02MB7009F6D4CC6CA1C433912C56D9C89@BY5PR02MB7009.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB7009F6D4CC6CA1C433912C56D9C89@BY5PR02MB7009.namprd02.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 May 2022 22:28:36 +0200
Message-ID: <CACRpkdb=Ub7sEQQAhjvhOq7xYdd0yZBnT8W6xi7QrD+j7T8j1A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: display: Add bindings for EBBG FT8719
To:     Joel Selvaraj <jo@jsfamily.in>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Hao Fang <fanghao11@huawei.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
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

On Wed, May 11, 2022 at 7:28 AM Joel Selvaraj <jo@jsfamily.in> wrote:

> Add bindings for the EBBG FT8719 6.18" 2246x1080 DSI video mode panel,
> which can be found on some Xiaomi Poco F1 phones. The backlight is
> managed through the QCOM WLED driver.
>
> Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
> ---
> Changes in v2: (Krzysztof Kozlowski's Suggestions)
>  - Specify maxItems for reg
>  - Cleanup and simplify the panel properties
>  - In example change "|+" to "|' and "dsi0" to "dsi"

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
