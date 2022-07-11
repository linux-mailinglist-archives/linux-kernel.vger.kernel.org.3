Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F3357016D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiGKL7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiGKL7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:59:11 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFEC33431
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:59:10 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31c8a1e9e33so46205087b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=soHIZFMckyBtmeqmtltoqEHcx5pmrVpeNEKpf5M8ebI=;
        b=uQTeni90X9vSpuUi2Z5c/mfpYL3euVwMP2PmnjiBH6KAfstQwsqmxqcY0z5Na11zO6
         xLim4X4YwdEHf52ak2pdFpL3D2b7tcJnB1RoIIeLPAUZOVLJ7q7Gy18TaQd10UPQ7uV0
         HmJMpvZf2ALgg68hxnRjm7Ktsx3emiUGiVJ/Hnahm1GIX3+zoTGQGtYUv2LxaBxjUyUL
         IKjs+6l3UkJrDeJizscE50gnTomp7DvCRkaNCEQyIUedn7LPwNP1kHkAgG/LpsFMuMtt
         ZUzYaUxED4sie+luA6WRGHxIX2eAFyPsgQvRvbNTEI89yQyLe0qox+qn6yaCZjYUT4QW
         Zgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=soHIZFMckyBtmeqmtltoqEHcx5pmrVpeNEKpf5M8ebI=;
        b=JqF+s/Bai1q8WxEbb7vP4P5+x5AFJ0wT1pNhPoXy8N0nlFMghXSy9rZVbZxi+DY4mC
         5YNR7FXZZjnY9+G56LQrbbuuZByjQuiXG0JD68q0YxFR69zlmtYZAAJjIlWpYej/7ZG4
         oQrfIdEzwOHOnIUcvkEB72tRz05JtKGaBE7DzP67ZgrDhMmCrtPCNlQi70qWmriDgETI
         lwZNw4Tdc8WZ9EDXb77k2Mc3U3FpkelYcBQg6W0UfpdvK5zMFe+b/GwYWnEGk+mtr2Go
         FI9nJfGaGWqeU/A3D2/7VZbc3Bgf+YawDlVkUmRQoVdC9sUONukZIZcORs3ErIe7fjz/
         x4fg==
X-Gm-Message-State: AJIora/lbARGM9g9u4eSq2IK5OEv+vqdyVz2zjY0EzEw/JYQj5NaSm1k
        IKQT7M0PSZOY0+MxolxjqI4l9DswRn+6gEV2c4sbVw==
X-Google-Smtp-Source: AGRyM1svUfrrpP72tLMZRihy/YrAMA4c44RQU5VYo6DXQhuXv26T2sFNwN3mldeaRom3j44YCBmi2myhto8H8sEtHns=
X-Received: by 2002:a81:cc4:0:b0:31c:839c:7e27 with SMTP id
 187-20020a810cc4000000b0031c839c7e27mr19354375ywm.151.1657540750016; Mon, 11
 Jul 2022 04:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220630131543.225554-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220630131543.225554-1-angelogioacchino.delregno@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 13:58:59 +0200
Message-ID: <CACRpkdYk5_C-cUdCgz8EPS=b4=_svA+YQFGNpXeSNboW=CUDPA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: mt8195: Add and use drive-strength-microamp
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sean.wang@mediatek.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com
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

On Thu, Jun 30, 2022 at 3:15 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:

> As was already done for MT8192 in commit b52e695324bb ("dt-bindings:
> pinctrl: mt8192: Add drive-strength-microamp"), replace the custom
> mediatek,drive-strength-adv property with the standardized pinconf
> 'drive-strength-microamp' one.
>
> Similarly to the mt8192 counterpart, there's no user of property
> 'mediatek,drive-strength-adv', hence removing it is safe.
>
> Fixes: 69c3d58dc187 ("dt-bindings: pinctrl: mt8195: Add mediatek,drive-strength-adv property")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Patch applied.

Yours,
Linus Walleij
