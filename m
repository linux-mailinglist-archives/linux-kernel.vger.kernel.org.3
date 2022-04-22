Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554CD50C1C3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiDVWCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiDVWCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:02:43 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8136D4160DE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:45:49 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2ef5380669cso97520187b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTYVVxfz08ji7LisN1HyvD8Q42QQWkxJnHZuQ3wrXDI=;
        b=CyZGYcQdOD77c4tnXXyDM7egLNC+xD5Lfbo++f/oEd6Mc7YuF4nZcSJzO8litplCwO
         9Hl8ANPegA2yhs1atnyTv3F2IXhNasW6GYJwzObOkSp1IUpm00J+fxtkzcorapDPlSjB
         wP2YAOJ0YRS/HVWxrNoRy+JCkpS9b9oEy7h2uDzLPAXyBisQ4AOVV6l0b5CYEBGu8Lm+
         hCH9vb+4DKR1/NV539hOeSudxUu6kTO+2/+GzaVxDlMjEv3oolcffR8KWHlMwU0FjbN1
         Xjh3xCynw6y1akW6P75hxoxD98mqku4I6Zw+cZjnySE4cxkqbK+/qalL6jdwhx8TQlTl
         zheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTYVVxfz08ji7LisN1HyvD8Q42QQWkxJnHZuQ3wrXDI=;
        b=bGtEK4vF09faf/NoTuXyZOvxEGbNPTzjEidWhlk4cy9M6zvB2SMW9t4jjqS+/ING8u
         cOSbR0KBqHj9vzJCnGYEiHBV6qaAI94CcxTldmWK/lIh21VvIbv2Vi3BXpLZ1DrIM2Lu
         PSfuSoWvi6jPzSt3J/5lGBAKi+EAX5tD7IZ79+IPf0QaVsUFpgcxTON8IaltxnvcE+Zr
         sBD/mdqoLjFE59DFImyDWeHzb/8ey8jNGG9kYe683zoXltMoWEVhnlTHJtES+V//zMP0
         kDmD6ik0hsOoQ/cFmjX9g+3GFojJJ+c/HRG/K707NzQdHSZZzeVDGuC7NatjJ/3xG82p
         WE5g==
X-Gm-Message-State: AOAM533mgzs9CxmifO4/fEzWbgbP9AvuLqr3Zv1xhIHaKRT4L/hPBgZf
        /v7ny+VPADyrmct61S5Oag2fWwCLyEnihNWiWYDYLq+e1FM=
X-Google-Smtp-Source: ABdhPJzq86ruhOqEYU+8gN4yyBiknGW6LZI+KGiMSXNBWuHztdTVyCg6yrBXJo6ofvLK9zohuzrwA6ko4NYCiLa0wzQ=
X-Received: by 2002:a0d:c4c2:0:b0:2f1:6c00:9eb4 with SMTP id
 g185-20020a0dc4c2000000b002f16c009eb4mr6900986ywd.448.1650660348505; Fri, 22
 Apr 2022 13:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220422170920.401914-1-sebastian.reichel@collabora.com> <20220422170920.401914-18-sebastian.reichel@collabora.com>
In-Reply-To: <20220422170920.401914-18-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Apr 2022 22:45:37 +0200
Message-ID: <CACRpkdaBixtCX=rdMCVJb6QgFhBRZxEnPpDYDzsznx93TL4Jgg@mail.gmail.com>
Subject: Re: [PATCHv1 17/19] arm64: dts: rockchip: Add rk3588s pinctrl data
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Jianqun Xu <jay.xu@rock-chips.com>, kernel@collabora.com,
        Shengfei Xu <xsf@rock-chips.com>,
        Damon Ding <damon.ding@rock-chips.com>,
        Steven Liu <steven.liu@rock-chips.com>,
        Jon Lin <jon.lin@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 7:14 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> From: Jianqun Xu <jay.xu@rock-chips.com>
>
> This adds the pin controller data for rk3588.
>
> Signed-off-by: Shengfei Xu <xsf@rock-chips.com>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Signed-off-by: Steven Liu <steven.liu@rock-chips.com>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> [port from vendor tree merging all fixes]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Please funnel this through the SoC tree.

Yours,
Linus Walleij
