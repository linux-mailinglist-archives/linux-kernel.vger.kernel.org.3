Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B819E482082
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 23:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242217AbhL3WJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 17:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhL3WJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:09:14 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B881C061574;
        Thu, 30 Dec 2021 14:09:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id q14so95013852edi.3;
        Thu, 30 Dec 2021 14:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fO4xO7NNKZaCmkJK0S4qOaQjqknEjPN6Tb/y58iIAE=;
        b=jB4HxVZtVS4EyhNwvAkbMTGe/LdlFRTxmCOzQDI89mCYySIaxJuR/SJdKvJ3ufUl/y
         nfz/N855jhI9UT7uzId0A7jJm7t80Tnjwb0vvzLnXtBYk11IdSlImbct7l1dXvJnri8D
         Upn+axPHiZZFsUWMIHBv5kX9INAwm8dbnHeCLRJL4BnbZZQKKPK+nMBzo1B6CEhfevdU
         4At2gSbhQM+iTHI8vTgkJA7rzgb9sVtQjmeEXXQRVihULHitylBLuEV9urMbdGNYp3En
         nineYS7rCe9amOt2rpGy0W45giP5ZPojrMleRQT5UsB6jYBBgjFmAbT9Q1G/aRawVLRd
         M1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fO4xO7NNKZaCmkJK0S4qOaQjqknEjPN6Tb/y58iIAE=;
        b=Ewievfgnhj2aSE/KjfDPucwsNgLNhjcxFjJXl7GWXbrtlXR7Z++wkTKo4YypQS540M
         /des0DMdOlSgJjWkIvCXlHMZBATIQcfO1Q6dThhKQ2tHYOMNNer2JTPGeJgVs14BXCtT
         j1m/IGyUnKlRhypLmARgeGyQYlEPOUK5CPy8Zy8+hDL0ILFIIQ/VB2LuLHWTygci7E8j
         djBh2HAyvXVF3WlOCQzskjiINlEJR3UsteLntkokUISonGuJzOIxCIRuH8OhUzDFTVAs
         7tkVFN1zWuC7NdL9SZl48ACoR218agn1XshZ+kA3QqTt0JuLQNE5yMtpNyeXeeT4lZTb
         x3OA==
X-Gm-Message-State: AOAM533DVm+TP31ZZbm0tEjbP05XcK3U7zKghr4BBrfOfsoHIa2P8qnL
        jnm8yT0dReN75HUV4qq4kurY8xW80OVsbV+VLdI=
X-Google-Smtp-Source: ABdhPJwm1oRq60d2pmgoT5DTcTtrHQ23EXvLPaQWHXG3LWn+TVf6ggb3MjU0IpAfSWv+tjOdzX5jfHxJVZeCmnrjRvY=
X-Received: by 2002:a17:906:685:: with SMTP id u5mr25866667ejb.543.1640902153070;
 Thu, 30 Dec 2021 14:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20211229121605.10513-1-qianggui.song@amlogic.com> <20211229121605.10513-4-qianggui.song@amlogic.com>
In-Reply-To: <20211229121605.10513-4-qianggui.song@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 30 Dec 2021 23:09:02 +0100
Message-ID: <CAFBinCDPtiPHZ7BkTLoqpd1HiNQa1n45MeByzGHtHmK=-oOxzQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] pinctrl: meson: add pinctrl driver support for
 Meson-S4 Soc
To:     Qianggui Song <qianggui.song@amlogic.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 1:16 PM Qianggui Song <qianggui.song@amlogic.com> wrote:
>
> Add new pinctrl driver for Amlogic's Meson-S4 SoC which share the
> same register layout as the previous Meson-A1.
>
> Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
Due to lack of a datasheet to compare this with I cannot properly review this.
Instead I confirm that this generally looks good apart from two very
small nit-picks:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I suggest waiting for Jerome's review before re-sending this series.

[...]
> +static const char * const mclk_1_groups[] = {
> +       "mclk_1_c", "mclk_1_d", "mclk_1_h", "mclk_2",
> +
There's an extraneous empty line here.

[...[
> +static const char * const pwm_b_groups[] = {
> +       "pwm_b_d", "pwm_b_x",
> +
There's an extraneous empty line here.


Best regards,
Martin
