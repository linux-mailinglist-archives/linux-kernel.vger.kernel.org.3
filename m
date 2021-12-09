Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680E546E0D9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhLIC0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhLIC0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:26:39 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D667C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 18:23:06 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bf8so6768878oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 18:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ce+3ZLHZVFn6hr/avmz5qPikAqGOU695ooOcBJXu3dg=;
        b=if2gZp4ZdriFndAsWg8EmVfq9toVFPf33VIceGqgnQvA4udSDGbEZcGFr56gzeqYlB
         MRr5DwSssiy8+YCF4ya+1z8ql3zlWPf75hsMxeD84VeFGTuJBrHHIwrXcYJ8UU6F4Iti
         IeItRDbLedrZOCCTPKmXI3tNR2ez8XpCQFdkISpV7YJChxY8/6fFLk88wICt0PbWgMXY
         YceB2c9q+ne3RjSr6uu4IRccxr0cxl9jGYdilPrn5KzMkLrZ3Mw+K0eTn8Xx+mkdynQX
         gtO0CJBr2sgx0zl7JA6rvR5ivmBqqOsmhOAb4F6c+LlBBi9lcQp/mkRPA0341pDlfq0s
         1EXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ce+3ZLHZVFn6hr/avmz5qPikAqGOU695ooOcBJXu3dg=;
        b=Q767MWIi435qkOkgjZka+RDH5Q9Pjh2hUxSyYsp24Ovw0wRNrbgiTW6t7DAh7oy5zQ
         HI4p/YRpZlXs8bZCpPC/4tmSoUyFtzYo5U+yNWnV3CHh3rkwyFTP030pTMEk0CFmJ3GI
         /TGTvVddWE8mjQIZZCvvd9ou+KEpW+Fo909vlZlR2yF92/nsA3cnJypngnOnX2Dk/S+i
         B9cRGw4BRU5NkTh2OIri2vIz7jnhqenwrpYb4zL//niB0HI9fiiP6m9DWvM2HbpgcB7H
         cPgGqN7us0iepbo5aUaSmWrrZW7pN8q6qYjZHLqQrAnd5gkMfkXkuWbbVCpocIzENLLL
         PAuQ==
X-Gm-Message-State: AOAM531/wScZP5qoqtRojhCqw/o8EG2rx+s8bNFKFzv/C0/mCggnsCSJ
        16BCZ+tMTBj30orioD267Z+dZGF6dqaL+J5zc7k+kA==
X-Google-Smtp-Source: ABdhPJyoHCqxuoxzuTYEd7z891USU7AXAoWKFpOZjUl4jhTMLZS9p0jYjZ44oG9JaxR+O6bsYdARh6LMzmzhOafU7Cs=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr3172519oih.162.1639016585914;
 Wed, 08 Dec 2021 18:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20211201072626.19599-1-lakshmi.sowjanya.d@intel.com> <20211201072626.19599-2-lakshmi.sowjanya.d@intel.com>
In-Reply-To: <20211201072626.19599-2-lakshmi.sowjanya.d@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Dec 2021 03:22:54 +0100
Message-ID: <CACRpkdYFJf=A_isumOO6F5_oYbsdpA5KyCSj1niFRumKW7VJjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: Add bindings for Intel
 Thunderbay pinctrl driver
To:     lakshmi.sowjanya.d@intel.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        bgolaszewski@baylibre.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, tamal.saha@intel.com,
        pandith.n@intel.com, kenchappa.demakkanavar@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lakshmi,

On Wed, Dec 1, 2021 at 8:26 AM <lakshmi.sowjanya.d@intel.com> wrote:

> +patternProperties:
> +  '^gpio@[0-9a-f]*$':
> +    type: object
> +
> +    description:
> +      Child nodes can be specified to contain pin configuration information,
> +      which can then be utilized by pinctrl client devices.
> +      The following properties are supported.
> +
> +    properties:
> +      pins:
> +        description: |
> +          The name(s) of the pins to be configured in the child node.
> +          Supported pin names are "GPIO0" up to "GPIO66".
> +
> +      bias-disable: true
> +
> +      bias-pull-down: true
> +
> +      bias-pull-up: true
> +
> +      drive-strength:
> +        description: Drive strength for the pad.
> +        enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
> +
> +      bias-bus-hold:
> +        type: boolean
> +
> +      input-schmitt-enable:
> +        type: boolean
> +
> +      slew-rate:
> +        description: GPIO slew rate control.
> +                      0 - Slow
> +                      1 - Fast
> +        enum: [0, 1]
> +
> +additionalProperties: false

Can't you reference
Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
here?

Look at for example:
Documentation/devicetree/bindings/pinctrl/actions,s500-pinctrl.yaml

Yours,
Linus Walleij
