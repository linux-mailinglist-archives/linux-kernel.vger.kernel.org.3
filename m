Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FADF495AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378744AbiAUHew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:34:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58450 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245244AbiAUHev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:34:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25422B81F43;
        Fri, 21 Jan 2022 07:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CA6C340E1;
        Fri, 21 Jan 2022 07:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642750488;
        bh=+/7FxM+sY9gU58ZTfPcL7JX+hCTujvO52MJ5lyAAnTw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hfkuqxkh4B/gLrbVvv2IlfD5mqvfRE0kROop3XsAp2DbFJdAbZlf+nOPHF89ws0uw
         G1Y9ScWPttAPdCcHpV4QIQCNp29ZGp8WtPpWi3BNr8ly4vQALJGhk6Fa7/MvKUykoq
         kPVFOX4gZ0NATAx+HZ3OAAbq/UuJi9/OwVcZ2UhVKUF+nectMzGYDYFcLB2yMkYWUJ
         nM7OJNEZZwOxfdkjwxvqphpNz8Jn6H78iPGBIiz2Bc8XJUm7USlsNb6LbsxlPrtZSx
         ParwMo9JPeHatsZL5ZCbVvz43iiLk8OgSntetBSYhCl+IUwgcTuZcmmOnhKCw/oruj
         BPG/wIWK3mwtw==
Received: by mail-pl1-f182.google.com with SMTP id l17so1417707plg.1;
        Thu, 20 Jan 2022 23:34:48 -0800 (PST)
X-Gm-Message-State: AOAM5300jdR6W01HF5keu1z7pk/uyameZ/ZFEwUZkxy19XxkbWRGm8p7
        R1nc8mXRPOK75fXqgjUAYgPz2j+5x20iWcD7Ed8=
X-Google-Smtp-Source: ABdhPJyt0iuBz0RmeqWUlREnas2NhLm6qFWj2HnMy6lhxXMDsjlvv4N3zDosRuTYFWpwxeyMfO+/3GPAcb1eNZL5lBs=
X-Received: by 2002:a17:902:d4d2:b0:14a:7baa:3dd4 with SMTP id
 o18-20020a170902d4d200b0014a7baa3dd4mr2584666plg.143.1642750488258; Thu, 20
 Jan 2022 23:34:48 -0800 (PST)
MIME-Version: 1.0
References: <20220120161442.140800-1-nikita@trvn.ru> <20220120161442.140800-3-nikita@trvn.ru>
In-Reply-To: <20220120161442.140800-3-nikita@trvn.ru>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 21 Jan 2022 08:34:36 +0100
X-Gmail-Original-Message-ID: <CAJKOXPc249vbZZwjXxfg+mEgqQe0P8uhf1GTg8Db9sBeMY3+tA@mail.gmail.com>
Message-ID: <CAJKOXPc249vbZZwjXxfg+mEgqQe0P8uhf1GTg8Db9sBeMY3+tA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: pwm: Document clk based PWM controller
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 at 17:15, Nikita Travkin <nikita@trvn.ru> wrote:
>
> Add YAML devicetree binding for clk based PWM controller
>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> --
> Changes in v2:
>  - fix the file name.
> ---
>  .../devicetree/bindings/pwm/clk-pwm.yaml      | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml
>
> diff --git a/Documentation/devicetree/bindings/pwm/clk-pwm.yaml b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
> new file mode 100644
> index 000000000000..4fb2c1baaad4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/clk-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Clock based PWM controller
> +
> +maintainers:
> +  - Nikita Travkin <nikita@trvn.ru>
> +
> +description: |
> +  Some systems have clocks that can be exposed to external devices.
> +  (e.g. by muxing them to GPIO pins)
> +  It's often possible to control duty-cycle of such clocks which makes them
> +  suitable for generating PWM signal.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: clk-pwm
> +
> +  clocks:
> +    description: Clock used to generate the signal.
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - clocks
> +
> +examples:
> +  - |
> +    pwm-flash {

Node names should be generic (see devicetree specification), so just "pwm".

Best regards,
Krzysztof
