Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111734BC45F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbiBSBHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 20:07:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240758AbiBSBHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 20:07:19 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5C84CD43
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:07:00 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2d07ae0b1c4so83566347b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=92HmhncqwIJbwlHAajhn+8XBIuPierpa7s2uzXAun+4=;
        b=acZPgi1FruVkoeZSr0gyncEXALkeYWnMuQJajOwtagvoouxuV3yMtlseyInLvDvktI
         zHUmr1z7BJ2KW1KKeArTzjMGfiZ5OdnoNGz293FSS3Og8eOZI3t9QecsdXqUVonK7sAl
         y27j0dm+XiRie7DCn09pK5uPsUurt9mUXnFZTeyUE4NyP1K47I0KteLBUF9UmcLNlPNw
         1asrO9NJ+zNydQICRxdWerJQMrAT9SUxEmEVidHWiQDvxwD08IbUcnY+JHQsitcjd+WQ
         DHPVEmviYaqAZMgIEjpN6g8LkAgGe6/mE7fa+ZywllFXPeV/akHWWgtS2GddDPAFAvI4
         P1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=92HmhncqwIJbwlHAajhn+8XBIuPierpa7s2uzXAun+4=;
        b=TqCi5PGHeWV0fle3fCAxriU1jbhRRF/wC0Ei7ftUP0aURD0jOfECfPJAHHSZMrHFX5
         XuQ5TkEsOexsyDNvWTyU9++UURH3fCNAR+Iy2TrydvcqVYKf2A3iV4WtcjjSlVR/JNvk
         YJhbHOAN3pxzlwAWnJMjLoTWoxkfjmhq6Z4v6HydzkOLfGKDXIEogSLsJEBBrhl0EWOy
         77GaZWrgA7SR64hznQcDcCn/WRxQWtGb78lLi+Kq18nTGJekzTZf/10LpeGogVFaMRsK
         PU+aCKy4NsiZzjLgk77TmhBctao0E7rM1u9+bLNN3nHut4M8PxnosNni+hfYF06uX1nw
         cYoA==
X-Gm-Message-State: AOAM531qaY/7x/m9esD/h3roODzZbLgyVDoLs6LdFE8LNoJyw0NIais7
        ddU5miaQMny/foZTscd0hvb3FkjbdcrJCAvzZsScfA==
X-Google-Smtp-Source: ABdhPJzHwRbcVu2/LZrLyXxrBzXQraRUiAp+FMxeZxXTPfeXMmbkWKmTc6Lzsu483jeGdlR98tZUnSZ8gzN2Mq/gow0=
X-Received: by 2002:a0d:e447:0:b0:2d0:d223:2d17 with SMTP id
 n68-20020a0de447000000b002d0d2232d17mr10604370ywe.437.1645232820147; Fri, 18
 Feb 2022 17:07:00 -0800 (PST)
MIME-Version: 1.0
References: <20220215174220.11054-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220215174220.11054-1-krzysztof.kozlowski@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 19 Feb 2022 02:06:49 +0100
Message-ID: <CACRpkdZyjuL-vkAe=9UyFLGx95nSWWJHtB39MfjTGnQ8013F-A@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: samsung: pull for v5.18
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 6:42 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:

> Parts of this pull was shared with ARM SoC guys (tags/samsung-dt-pinctrl-5.18):
> https://lore.kernel.org/lkml/20220129115352.13274-1-krzysztof.kozlowski@canonical.com/
>
> This pull request is on top of it, in a fast-forward way, no rebases.
>
> You can pull this one alone, or tags/samsung-dt-pinctrl-5.18 +
> tags/samsung-pinctrl-5.18-2 together.

Pulled in, thanks! Excellent order and exciting code!

Yours,
Linus Walleij
