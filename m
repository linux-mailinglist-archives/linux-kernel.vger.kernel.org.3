Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B17E538DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245273AbiEaJeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237326AbiEaJeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:34:09 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11643A71F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:34:07 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2f83983782fso132832847b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0w2fXNQOc3DHaB4s+oXCyoZJeWAMalBiF5eAVeXufrU=;
        b=C4QZ6FMJ5aJLAtnQWNLvLEEDUXO25F0COEmJPF87NnQKZhExYvB92mpAWJf0lPVPBJ
         kdQWE6xMBXjrvcyyAKQfM+XTMO/lH6jlZEDbL+Dxws2W4zPIN+3iU2OspGRfkEIW/a5n
         h/afEYh/M76OJ8kCjZxWQmN9b4LfbKJ2OCpfcwvz7IQpmIpz+6OXqKvEiwLxbC/l15Lo
         7JjFtVLeg7L7vlHGka6YWCxIyM0sgJZiQPKzaDm6gysxAzjNX01+/WYYYfAvHsAYSLRX
         mjK6sRg4Xk4SNfc8B88YvU1SqAgFxaKvuHageZtrKwTYR4orYwo7OIa1ybFJ5IUL2nrj
         95lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0w2fXNQOc3DHaB4s+oXCyoZJeWAMalBiF5eAVeXufrU=;
        b=Kb/YFEUv0anyTw9Cpy59S1zXBbFAKuZKO9Lm9IxKi9N/szzEUkzQ4Lmi6LdVh6tRaU
         7dnqaMLbpTnew/HpqPaQ2iHaniPTKWmTFBF9wDRBZdbH53YeVXTOQoaJ89w7+PY4YsBw
         JrsjpzmsJ1hADKqofthjdUGQtmvOc8vwvZ32aHjPaC5u4R5LarqjFtziisVx8qB69jVr
         0ROaC1aoyfWxeb4XxHAIicVhhsmCxl7Eswu7i/OvVyXV3NhSYd4msektTF/0wimNNWOr
         G0CKiNmpYf0Pi7UNU+ayz5AZWoMgYcyskr02WtuBdHt4vaE/arIx41oQj8kAG/YP1qmA
         YFjw==
X-Gm-Message-State: AOAM532d6/KG5IhsICijjpCoSwS49B6UxJaivTw89WBCT5hYFh9oAQ6X
        2NnLBrlRPz0gHujfkngQ/8RiCzps26X+/eUU2VsnUg==
X-Google-Smtp-Source: ABdhPJzVOfXBYTQoebXOcYGJ+lnLw7+x/Gvfz81biEV7PK3vYDQcPKJgisfe5ZodDgBmCw5OrHus2mbPSAh2SSEqRbY=
X-Received: by 2002:a81:fe0b:0:b0:30c:7e9c:701 with SMTP id
 j11-20020a81fe0b000000b0030c7e9c0701mr6503392ywn.118.1653989647207; Tue, 31
 May 2022 02:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220530160753.100892-1-jo@jsfamily.in> <BY5PR02MB70092E9495F2A52F473DD31AD9DD9@BY5PR02MB7009.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB70092E9495F2A52F473DD31AD9DD9@BY5PR02MB7009.namprd02.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 May 2022 11:33:55 +0200
Message-ID: <CACRpkdZyVTWu=j5rVMmi1PuHBDYfEXhAiH1f0hskBnkS4a+FZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add prefix for EBBG
To:     Joel Selvaraj <jo@jsfamily.in>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Hao Fang <fanghao11@huawei.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
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

On Mon, May 30, 2022 at 6:08 PM Joel Selvaraj <jo@jsfamily.in> wrote:

> Add a prefix for EBBG. They manufacture displays which are used in some
> Xiaomi phones, but I could not find much details about the company.
>
> Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
