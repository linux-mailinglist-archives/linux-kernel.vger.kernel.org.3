Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77814D918A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiCOAa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343875AbiCOAaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:30:03 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C47443EF8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:28:00 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2dbc48104beso184432497b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zlK3WC1mVUGbQGst6DyMlPxUP/ifBpvAeEOrFJ5i5EQ=;
        b=hMpFLuIiUKAb3llFmhhX49w1UxxcNjaLfZ8iMGuhlrju3bMe6GglIGbQ0olBtgA8jr
         MXCoxFbtDcDoZ30WI4idtFlek3Uz2MfEOI76o7ABc4Y415w6paJXPGC63/mvJlmNLzQ2
         uECj1ZEptDv63LPH0O4v7BdFsOAhEr+miWZAJYv/8us7vdIOVvkoOlBP+FuPKsprrdig
         zJQ/uSY/QnL+EZ7EeaVSjyW2kia+x0WYEd6AUHUxQ/IUOxkfw4Or1IoPkKlBi/DL0ee/
         J9Tjz7BVVzS98nHS6s9i9osF3tUdhnY3UxfLD42L3Ria3l2bAyobprt4rZQODxEFgecR
         oUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zlK3WC1mVUGbQGst6DyMlPxUP/ifBpvAeEOrFJ5i5EQ=;
        b=XeDi91NhUfBDOXmN0bSztOOS7sI9qBFwcnx3i91DSzLQsHwd1lrmp8WWi5u8Vwds48
         7TKLdrplNwdWb1itT4eaJ0gyyk7MtsUw6k7NMMwCUAEao+jpp4pkfoaOSq1K/woL/1C1
         91qJJ7igv6vtzolS0T8QLCUX67QtKhGd1Q4cmc/hfk5/KTpc4a4UEGXJnuWdf4TziedM
         RbH2a6sQM/RK5bN9/0ywEmz1lK//Sop8fjfZSSKBRtuyLneAvOflLGgDjUrz6qoCSVyG
         zytn31LFooWnlkuMPhy6gq2kih9M1FjDosObrGWHPGxIZe1mh5BmZx/WRTwFZxXnlnum
         mdJw==
X-Gm-Message-State: AOAM5316hyHtpNKfofG4orkhCNONI8J1AjylcRNE/FX8AzafMgnPHf0l
        RMVjeyWxBvnRly6rO7+Vi2cSb3UoYyNTvbvGDjZXEA==
X-Google-Smtp-Source: ABdhPJwNfXZsGtJ2x5cCSKckQ6t0JFF0cV2XOrXT4oYs4BzyLPgK2ZLbtRnVXVHiksdmvlwK9JGm+1CDCViziCKL4IA=
X-Received: by 2002:a0d:db15:0:b0:2dc:b6e4:cd2f with SMTP id
 d21-20020a0ddb15000000b002dcb6e4cd2fmr22599346ywe.118.1647304080133; Mon, 14
 Mar 2022 17:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220216113131.13145-1-tinghan.shen@mediatek.com>
 <20220216113131.13145-3-tinghan.shen@mediatek.com> <8a95a9fb-fede-b2e4-d616-e03c9e6778c8@gmail.com>
In-Reply-To: <8a95a9fb-fede-b2e4-d616-e03c9e6778c8@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 01:27:49 +0100
Message-ID: <CACRpkdax8TCsJTPf6-nWeoDQkm1KVz32NY3+4yWGybL44fDegg@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] dt-bindings: pinctrl: mt8195: Add
 mediatek,drive-strength-adv property
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org, chunfeng.yun@mediatek.com
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

On Mon, Feb 28, 2022 at 11:13 AM Matthias Brugger
<matthias.bgg@gmail.com> wrote:

> Hi Linus,
>
> On 16/02/2022 12:31, Tinghan Shen wrote:
> > Extend driving support for I2C pins on SoC mt8195.
> > This property is already documented in mediatek,mt8183-pinctrl.yaml.
> >
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Will you take this one through your tree or shall I take it. In the latter case
> I'd need an Acked-by from you.

I applied it sorry for being slow.

As it is a DT binding I don't mind if its applied elsewhere as long
as it has Rob's or Mark's ACK.

Yours,
Linus Walleij
