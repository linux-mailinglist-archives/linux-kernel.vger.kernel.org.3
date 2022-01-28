Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A44D49EF2E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbiA1ATJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbiA1ATI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:19:08 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307BCC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:19:08 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id m6so13617835ybc.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DCG3jSFRCxm0g2kfV3cHNqgsx01TK2wuMVMrv3kOZs=;
        b=nJX6+UI8YTCimbpcv+pq777gCdLu0/GnEx3ZTjHpS2o0yUjh9ly2WBhhLtEun0n18v
         0w1UV21RMSfZv8hSpUqL1dSFQJ8X5FfR0IOlMgzcb7ywgkd+ZRzMzOcdenlzemlIGqxO
         XRQrQuOw6IbkMajKB5hoZqZS/I91t1ghfvNomkXWxCWOTTxQrPwZTPH3N4gdsOtz814r
         JXfvW7M9c/aS5ykLbFEH0mW8HLFkswy8tt2zL9sFb+0rfjAHILk4LoTt38qYFPZ6DnKq
         CJt0+ULHi5RzCfFguwZ+IOVnFREAXtbOkBv9l3rQ+YQhjJDtbkDwvzPsoo6fyIkPPJ7t
         RBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DCG3jSFRCxm0g2kfV3cHNqgsx01TK2wuMVMrv3kOZs=;
        b=jUsw6ZyocU8Fme2tDXL91rgXsESD1NpclPkBBe8s2DYkgC0QZVTKRyqh7qlIeub+66
         ZItDLdgaNZfdpmmKWaBUXxRjCXwAqYFIGnzDEdob9wnci+laxdbs3hz/xqgakMgrHubL
         H2h+6fG/3qKLXj60HIx5WhVEcU8Jtawz4mLgnHRiLyt1f5v188eRy7LsjvrgkQfHWn7i
         tDt4Hko64RWa83mkEEya5oIP5TgLdrfNl1g6vpy6U8rVh+wRv6cFLODtLi7urQZBU1pV
         aQGaWVh8SjEPalHWfMntFkvdoJqlSzfnVgrdXElvyWZF7XzmyEKQfAS4r6fYNsZQaXwm
         4/FA==
X-Gm-Message-State: AOAM531LgBSBel5qQZKcLP8XWQHtxUFbs9iYq0A/zhsE8hgmarsmtv54
        wgxZQa5Gs06msoFWIE1BXt5JW8EJr1Ls1cH6/zRHcg==
X-Google-Smtp-Source: ABdhPJyykXdIj7dPguTyjg62i8Gn1/OIXWg5z8qwoIkr3LKwT6wwILgx7t7DttiqJWU5ru3WZYNPOodW/GSuSJ6/0a8=
X-Received: by 2002:a05:6902:124a:: with SMTP id t10mr8266567ybu.634.1643329147454;
 Thu, 27 Jan 2022 16:19:07 -0800 (PST)
MIME-Version: 1.0
References: <20220127200310.4150981-1-clabbe@baylibre.com>
In-Reply-To: <20220127200310.4150981-1-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Jan 2022 01:18:55 +0100
Message-ID: <CACRpkdY7O=KjhbeBZiokchFhSo8dTM+JAeBOTq+qkKE7-63jPw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: drop mtd/cortina,gemini-flash.txt
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, robh+dt@kernel.org,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 9:03 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> Drop mtd/cortina,gemini-flash.txt since it is nearly already handled by
> Documentation/devicetree/bindings/mtd/mtd-physmap.yaml.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Thanks for fixing this Corentin!

> +      $ref: /schemas/types.yaml#/definitions/phandle
> +      description:
> +        Phandle to the syscom controller

syscon?

With that small fix:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
