Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C326751B139
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378830AbiEDVmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357732AbiEDVmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:42:25 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC8D48E65
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:38:48 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2f7d621d1caso30040807b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 14:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VX0Y5lK0oKhUNvSgMz9EtXzVemCwMapBfZK+KjIwWaY=;
        b=QFpWrEBIrRnFFsbRzuQnDhJe4BaSIkFjtC3A5cZVG9hy/hcMauWrIqr2be5/KwrfGo
         NCGCurP8cU79+UY+pB9TmqKhq7oXZZ7qPI7uQbAillCKF63H5X/zuGVkc+JsGOKGae5G
         f+iwI+Dj4ePQuDCx/1Fct2nRPtAuc4Hty7oz//xsfve/iIL9k6svN3NMMvhiwINJ4xTM
         9sMncJOw7LjeeB//tUJa4IoTpI6DRjLlfyj3NRTd/sq9i3txOLixbGmLfCTI0VPt6z/K
         HRTwjUNbVnucCOGaOR4QEyXpnInRsolXUV5HOuBia87QkC+0dAuzdKHwcHKfLed2iZ+D
         Bhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VX0Y5lK0oKhUNvSgMz9EtXzVemCwMapBfZK+KjIwWaY=;
        b=cQRQVAvkaXwvBeLfGzop2RJTURisC0zqUpdFEamgn1z5cutwqt7WkEuTpbKKuW9fZu
         Z8bsnjDHd8ylhPgZuzAUYj3TWgEWdOwkaQ2n29vcpEkq5qkSVb39k8meK9++r7U44rF3
         HfW8ys4TbUp8p81FBpi1mWp1caLiIVOtEzrMnmEiFxAUJOX+gO0+/n0Ugf3Aq11oCaHW
         UsFc/27Hqk1t6YHVFWZoKNzcDHi9L3cteY7Bb0qkGM/rIJ8GfQurlxwPkZstLY7mA8xJ
         WRybmjl6EVJwfibjGLjc9tgY78C8uQppm0UGMO2mu/sIfFhifFyExZzgwTG3RcsPepI9
         s/Tw==
X-Gm-Message-State: AOAM5312MZlNyLbVdXExQcKAbEP9td+7ZnAV5Hn67R4TYOCQQWF/xk6b
        Udg7rqbaEKNHh9hhfJoG3KTfEFZ52wi+soiTOEkBmQ==
X-Google-Smtp-Source: ABdhPJyWaynNr+CEKkTESmGLzWOB0NJ+k01UPdgmFyQnRX5drt8jZsToCyQBLbeZMlkNdUUCDjlKhWmRzv0FXiKAhqI=
X-Received: by 2002:a0d:ddc6:0:b0:2f8:a506:a5c0 with SMTP id
 g189-20020a0dddc6000000b002f8a506a5c0mr22520729ywe.140.1651700327788; Wed, 04
 May 2022 14:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com> <20220428214838.1040278-13-Mr.Bossman075@gmail.com>
In-Reply-To: <20220428214838.1040278-13-Mr.Bossman075@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 May 2022 23:38:36 +0200
Message-ID: <CACRpkdY2MNkAKhVOQ_Eyq0AwOtEW-seSrxgsJ2D8E78u636A8A@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] pinctrl: freescale: Add i.MXRT1170 pinctrl
 driver support
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        stefan@agner.ch, daniel.lezcano@linaro.org, tglx@linutronix.de,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
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

On Thu, Apr 28, 2022 at 11:49 PM Jesse Taube <mr.bossman075@gmail.com> wrote:

> Add the pinctrl driver support for i.MXRT1170.
>
> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1 -> V2:
>  - Nothing done

If I get a review from a Freescale maintainer on this driver and the bindings
I can merge it separately, correct?

Yours,
Linus Walleij
