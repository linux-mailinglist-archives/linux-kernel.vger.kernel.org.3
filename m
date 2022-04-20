Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97848509334
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383016AbiDTWxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356355AbiDTWxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:53:14 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6102222BED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:50:27 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id b95so5583768ybi.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8s23fLxLi04YEMH4bxBt9AiWpQLyo5GBs2JMum7Vug=;
        b=zUWotnmPLjRieffw34mfhGBLWp6ZmSUK+lMvEh3AAjgoh6G3ietR/j1OUgrrTOk3fB
         oxpLx6YA4m081foKHie5D4iyQqQ0txptgUsovgj4EMtYFuFInJgB19IZRwSVWTAD6R3d
         YPT6DxRtEmWmBD4PqAtWos7uyMz+C6yK9ch3hfoZnPKNif25y+eQhKjszEDXH7B86C5e
         b/AC31Koeyh2SS/8ckGayCEl81M2RkVnMk2kVxqCrfwtExeozqtEen57SpjU+AkIHAAe
         wfpjnftV8FkzqegVexZOxE+fdo/idu+r9ekhIQbruFtIrDyZCsTRd5PAikXzLAhdoCyw
         pHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8s23fLxLi04YEMH4bxBt9AiWpQLyo5GBs2JMum7Vug=;
        b=mpry8smI9qRODdj34cqp4XSbZBL9nbSB7bvY/ap5Jmlx4aK+tSrLNRdddKejnndHiJ
         mrqbA7PXHMOLe2hY9GZwoHepIYK8nIgdFZDLDUysHmcEOjsuzoacReIowwDNw09obyeQ
         FXR0B4LVGSAltWeXbjJ4IyE7mvl47l43ECBBr2azxIyg4qASkPIRG+mahdWn7vIcmCDC
         RrKIOay06RzlYhVXmsGMhjza1FXA6v4at2ZX4zGauLl44Xbuf9be79hTbotwOFVoZ8Zv
         aYIrLSCcmNq+uu/8Fe0VuP1aXbqeU2w6IlDrLsh3lC1Xh0wUeamJxH1NMWDkOkI027Wb
         LNNw==
X-Gm-Message-State: AOAM530GqhQbBLamP1Liot8NNfbEaBVokCLruRQzyJdR4E0rMy06FOpW
        dUnTz0k9tnIvxjWJCD50ZM1COve/XZpQC/AR3dBxbg==
X-Google-Smtp-Source: ABdhPJxG7ifSltsyteZyw+NK8chpzsnfyLwzIcd9/d+dlKaytJ2om9/FWed2AjIrfeGR1DUKfQzCg2kJm8PBQdunyzc=
X-Received: by 2002:a25:e6d5:0:b0:645:7257:8271 with SMTP id
 d204-20020a25e6d5000000b0064572578271mr1390597ybh.291.1650495026644; Wed, 20
 Apr 2022 15:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220409105958.37412-1-yuehaibing@huawei.com>
In-Reply-To: <20220409105958.37412-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Apr 2022 00:50:15 +0200
Message-ID: <CACRpkdYVHPA7GyjyeOU_Q78dZR_VD1-=6pVX74j5FKee7cKpGQ@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: mediatek: moore: Fix build error
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     sean.wang@kernel.org, matthias.bgg@gmail.com,
        light.hsieh@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 9, 2022 at 1:00 PM YueHaibing <yuehaibing@huawei.com> wrote:

> If EINT_MTK is m and PINCTRL_MTK_V2 is y, build fails:
>
> drivers/pinctrl/mediatek/pinctrl-moore.o: In function `mtk_gpio_set_config':
> pinctrl-moore.c:(.text+0xa6c): undefined reference to `mtk_eint_set_debounce'
> drivers/pinctrl/mediatek/pinctrl-moore.o: In function `mtk_gpio_to_irq':
> pinctrl-moore.c:(.text+0xacc): undefined reference to `mtk_eint_find_irq'
>
> Select EINT_MTK for PINCTRL_MTK_V2 to fix this.
>
> Fixes: 8174a8512e3e ("pinctrl: mediatek: make MediaTek pinctrl v2 driver ready for buidling loadable module")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Good catch! Patch applied for fixes.

Yours,
Linus Walleij
