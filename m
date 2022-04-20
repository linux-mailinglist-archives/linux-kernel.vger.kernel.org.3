Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39754509313
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiDTWpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382975AbiDTWpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:45:11 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331833DA72
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:42:10 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id p65so5502364ybp.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xvgHYkX1gitxHFx0lp3h64Eqoa6L9VIgehho/WG25qA=;
        b=ckup5OEW1GScLDsBEVcIf+nm/kcNKdSSnHfUQ7P60qBEKfYhFMJaCZ9GuX+nKS9/yZ
         9aJPXnvNZ0xmjpDEi6vLws7Ox3DT34yjdg3ydpUd+c0PxZZ90uq0GV7lZYicNFed7N9g
         JlkkmUQ3SxoxBFByZIgqHAAMZM7vJJLW+SPWEvg/+vYBAgYCb+fJ9lF45CXAqu/1kjQ3
         a9saqasBRiwkkbFcFfEF81WRcYVv5in3/egOqp0JEFxPMLBAokK1XXxmwjUuZuaOFsuV
         087g+K3gzhJsfhrpWxI/4DnTZnuoBSleXpOdWjZRC4Q+1rWtL1nt8v+Vx2ns0IL9l3Cx
         eHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xvgHYkX1gitxHFx0lp3h64Eqoa6L9VIgehho/WG25qA=;
        b=NJ/FGW0F6ebIchU4hbWNMshAsFGLcudevqARB/u7fwmOC7IRErfi43V50GVfkleDnh
         OZfoaVpiLTcWIKcJN1i9ZhIzLD1KStPT6eyfdc6GTRFZmUWpIAgWBClb5MxdbPlBKKgG
         OClxOe6JmKijpL16GNi+u85hpzcTL8qVpWwEAcEN4InJ/Qoqodfb0dDNE/Yv8vda9fDi
         snURQV1F2f06Nk2eaP3t2emSYLJMuWZx1hX6YGCe3qznVRwAmN7ICH4dFK7L2TIMXn44
         kkTD4Ymgr6igiu9IwUkb/a5YT6TNcDZFw3QdjrvNKhyPB+/mRc3hxm+MyjjXOaanSF7U
         Jlyw==
X-Gm-Message-State: AOAM532mrC442VQiDPRIhgq72xIrocDgXoWxOTGvQb7DfAhmAGNL7gka
        67FYYQIyAi48DA8cX9YoEIheaBSOzLJVy1Ay4+PtzA==
X-Google-Smtp-Source: ABdhPJzEECoSw57FBizByjTYMqQYVDek90inKa5zx9AxvgyUzaHj0vkksZUgsx5Ylv+ZOjZ6jwguCMe2X12RIRGZthg=
X-Received: by 2002:a25:4e82:0:b0:633:68d7:b864 with SMTP id
 c124-20020a254e82000000b0063368d7b864mr23162602ybb.514.1650494525070; Wed, 20
 Apr 2022 15:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <fd813c7d-888a-ce53-b1e5-d9b41003b58b@sudomaker.com>
In-Reply-To: <fd813c7d-888a-ce53-b1e5-d9b41003b58b@sudomaker.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Apr 2022 00:41:53 +0200
Message-ID: <CACRpkdZXhy3zkwg8UQj=+-4cqooUYhceEwQEcv1MyM-RLwvoLQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: Ingenic: Add missing UART2 group C for X1000/E
To:     Yunian Yang <reimu@sudomaker.com>
Cc:     linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 2:32 PM Yunian Yang <reimu@sudomaker.com> wrote:

> v2: Define PC31 pin only once, noted by Paul Cercueil <paul@crapouillou.net>
>     Confirmed to work on hardware. Although the Ingenic folks did this twice
>     in their 4.4 kernel fork; not sure why.

Put the changelog after the commit text at least please.

> X1000/E has a third UART2 pin group selection, which uses the TDI(G2) as RX
> and TDO(G1) as TX. This configuration is becoming increasingly popular in
> newer core boards, such as the Halley2 v4.1. This is done by enabling
> function 1 of a "virtual pin" PC31. See section 19.3.3 of the X1000
> Programming Manual for details.
>
> Signed-off-by: Yunian Yang <reimu@sudomaker.com>

> @@ -2058,6 +2059,7 @@ static const struct group_desc x1000_groups[] = {
>         INGENIC_PIN_GROUP("uart1-data-d", x1000_uart1_data_d, 1),
>         INGENIC_PIN_GROUP("uart1-hwflow", x1000_uart1_hwflow, 1),
>         INGENIC_PIN_GROUP("uart2-data-a", x1000_uart2_data_a, 2),
> +       INGENIC_PIN_GROUP("uart2-data-c", x1000_uart2_data_c, 1),

This doesn't apply to the current mainline kernel, which doesn't
even have the uart2-data-a designation.

Clearly this patch depend on something that I haven't
yet applied? Something I missed?

Yours,
Linus Walleij
