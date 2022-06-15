Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D1E54C9B8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242616AbiFON0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbiFON0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:26:49 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8573F32D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:26:48 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id l204so20449940ybf.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2uJBdNrvWnRJEqnKZPpIHQmnT1CIlbB2x7GUHZk371o=;
        b=svkVmIzhK2OAHpVq1j7D5Y0BMlGsbs/r5txjoPVTRQ3mxbX2q+KeDYS5dFr9SedA1U
         G+CX/SEC2YDtM171HS1vYVFypF4406i/Gp4cjq9VGt2NKyJlaxFACzAjfml3uTZ3ABTT
         Bpawy4OLBnfnplZabQ57yj1fBScfFeEBlM3hbYQJ1dXlZHVmZbcgjKyDREq5hVzRnN+b
         IB5WjZRUVCHQXSGfEW/U8kRnKjCVfywJVT3+PMNySB+DKE/v2s/UUYLBD+K0l8Krw2UF
         0xuRAJLoVyxOH6swQ4Jjbke53RsOiIGZp5lG8ZzAG07mAFtniFJIWDPlglXPq7A4itVN
         wRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2uJBdNrvWnRJEqnKZPpIHQmnT1CIlbB2x7GUHZk371o=;
        b=W9vujZ0/jmVpv13f3aMhrbOLGpz83wSkYDiv0MRYFrvl5GtuGYlj5a7PgnLezx4QBR
         85wDMh5oam/dSMXCYAA0DXNXafNukuD1/uhXPoe0eAOw7yZv2C0Q/5Yz3qCSsYNmZJEg
         RpvsFzcxT7Nef4+Gz7tTES22x71b/BBZRmHWN/ItwgZ09rXXf5g9A2Qo0B+DfFC1onX4
         GX5gwTcqKx7wN2zYqOdd3PKtUailkNZgzKmUOC7pcbRN053Gwg+hWHRFZiyeIR+PSraN
         se4Ze1TTUyZlLRw6OB8z7qojJvsgrhDFXVgJ3tQi+UbyksgEXs++56vg4h2toZt7FUjN
         hzJQ==
X-Gm-Message-State: AJIora86D/HGReSipDIrlA6h2u7bPCK0E5H63meWNeEZNa4L0fU+puCM
        jJSlpVLU+LPZTutVQlkFo5MIJPYLiE0sWjwPRBtLIg==
X-Google-Smtp-Source: AGRyM1uXbFdzJy6wHZ8d8kshG4hHCgicMvgdaZy4F6zLHljayPXpaH/KNqKvp55V9OEMRLWm5czLWFtEK5L8lLi/+pU=
X-Received: by 2002:a25:dc0b:0:b0:65d:e5d:a87a with SMTP id
 y11-20020a25dc0b000000b0065d0e5da87amr10584832ybe.295.1655299607356; Wed, 15
 Jun 2022 06:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220531053623.43851-1-samuel@sholland.org>
In-Reply-To: <20220531053623.43851-1-samuel@sholland.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jun 2022 15:26:36 +0200
Message-ID: <CACRpkdas0MEu5ShkdJr-5rrM2i5LkrwARmC6J=X_UQGkRrc7EA@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: sunxi: Remove non-existent reset line references
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
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

On Tue, May 31, 2022 at 7:36 AM Samuel Holland <samuel@sholland.org> wrote:

> I assume these properties came from a lack of documentation, and the
> very reasonable assumption that where there's a clock gate bit in the
> CCU, there's a reset bit. But the pin controllers are special and don't
> have a module reset line. The only way to reset the pin controller is to
> reset the whole VDD_SYS power domain.
>
> This series is preparation for converting the PRCM MFD and legacy clock
> drivers to a CCU clock/reset driver like all of the other Allwinner
> SoCs. I don't plan to add reset lines that don't actually exist to the
> new CCU driver. So we might as well get rid of the references now.
> Technically this breaks devicetree compatibility, since the old drivers
> expect the reset. But the CCU conversion will be a compatibility break
> anyway, so it's a bit of a moot point.
>
>
> Samuel Holland (3):
>   pinctrl: sunxi: Remove reset controller consumers
>   ARM: dts: sunxi: Drop resets from r_pio nodes
>   dt-bindings: pinctrl: sunxi: Disallow the resets property

Patches applied for v5.20!

Yours,
Linus Walleij
