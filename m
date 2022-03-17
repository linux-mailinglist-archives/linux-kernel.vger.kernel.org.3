Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE9F4DCCFB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbiCQR4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbiCQR4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:56:19 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B56017FD07
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:55:02 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id u103so11605560ybi.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37AUWap0DRE5oFKZqUuu72BqRi1gyfreexPHtBKrZ8c=;
        b=A9V6xVa5QXiJ2q0nqf11yNi6STL/FGEsyrbnX0R4NPdqTVG4B6uzqvsyWMKGM7dH5z
         oYJY2dsAhdn0HfPrxYQ+9FxWRftEm7VK5ZFYMm9qzxvuF75XiWU0/SE9S33umpiUhjQR
         /UyI07yrukZZxks83Xa+e9KKn+Y7anNUAtrsJhaUYe5PItkR2XzgOvX3sX9h4JbrjAK4
         MvxmuEIwN1/XJPfhGm5g2uaQhAZDocMKqAv9PR+ACoHGpOZCTOgEdC1xZY6E5jkn3wm6
         GbN38rTZx0lAgAiby3cD6kA/9TzUKLJ7E6niFAdyvn+oAoeJgXQHtceXjWUOJhYcesPJ
         25Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37AUWap0DRE5oFKZqUuu72BqRi1gyfreexPHtBKrZ8c=;
        b=sarCEFPBeHpFXK2IgXm6JXRZRm+MVa+ReeOz28D+89XCsWxVtu6LmdGX8UKcwxgCZ1
         SHpNpiaLOFha6N4BjPgolIvhDDaDBLq05KXnOaF7GmgG7JKGpG1GzkQpabBOslppMiAR
         SOsyrQse2YklTV1fjOn6gZPNB5ArexDg5blwoT6WVjLbiXq7SFDkTsW1QkTrlRpuzqen
         Qv60CnYay7zYWey8U+uJTH4HZS9/0rqqMKTIyNKvG7v/aNTjOIb5r4srIrmn1AGMJXff
         DsXzgmscshSW8ubQTCi5MwW2AvFRK46WEF+qFXvGdzufy4+17kYCkMqdIl93tEGI2Q54
         izcQ==
X-Gm-Message-State: AOAM531Ap9Sr9hdF//K6b0A6NCBeIqO1sRHOCNqzgd5x5ztoX9F6F3xe
        C2AdoA0NcmMVmbYRx6f0zEsbn1bS2xaZuQJRDf1RMg==
X-Google-Smtp-Source: ABdhPJwBOyZ5MpSCmQLOPjG04OeQ0ocI+pzFDDDNrgL6hc4KG2aFemS2QyzTT7SM1kFVPA8QRO3Kx0RLoONGMhH4v1w=
X-Received: by 2002:a25:f406:0:b0:628:c29b:5c39 with SMTP id
 q6-20020a25f406000000b00628c29b5c39mr6467330ybd.369.1647539701525; Thu, 17
 Mar 2022 10:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220311235119.523374-1-linus.walleij@linaro.org> <46ceccc0-e070-2d62-24ca-7ab6351f013f@kernel.org>
In-Reply-To: <46ceccc0-e070-2d62-24ca-7ab6351f013f@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Mar 2022 18:54:50 +0100
Message-ID: <CACRpkdYZtAfr7hNwdKaXXhw66LMiUYSZKtUyXMFBBrZOeAsGqg@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: gnss: Rewrite common bindings in YAML
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 12:39 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> >  .../devicetree/bindings/gnss/gnss-common.yaml | 55 +++++++++++++++++++
> >  .../devicetree/bindings/gnss/gnss.txt         | 37 -------------
>
> I see you're updating later sirfstar.txt, but you also have mediatek.txt
> referencing old txt file.

You're right, why leave one off. I'll just convert that binding to YAML
as well and be done with it.

Thanks!
Linus Walleij
