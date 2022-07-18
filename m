Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1746F577ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiGRJki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiGRJkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:40:19 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84AC17E14
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:40:17 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id l11so19750148ybu.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iE4O9Cu378EJtqo0H2CKMhex7ENncDoyJzJfljjWc34=;
        b=atbdkpmn7BTglOlpaWDqAQ8u472jPWWGzY/LgcBZ2DEW1a+r4dKCNnj6/84iCmlk6A
         g6oUSSQx1+8PDI6C0zFmkDo37/Tq9z4kqSn8QYkU8rYuUxaUVFwzP+YlU6M74YjHPojt
         h0R8+K7mjpEvV1Kp8kIy29ViBrc/Uhsf3Z+F2cvkHoJSBREOvvDoEyKGEUV/EBhbXgJT
         3tYVQ+oP7jJC2JqLR9m8n1ObRvhNycmZjKk5iS6KMzqya5a60eALHnhHtaqbzBV0WcZF
         DEGMqTyoP5H5zWL8GYWE1dtJQVvyl9prp2L2rT4aAsLDdy7knFM8CTggbYMkX02mfb8S
         0UOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iE4O9Cu378EJtqo0H2CKMhex7ENncDoyJzJfljjWc34=;
        b=2vKHWsjnQxNYX4VBaLoLaK/h+QrGtM3K+vGaNT1tel3Kz0SJsKmmWEr+x5GpX134f6
         9mC6aHBh/cFg0TkY61+FDk1wx6LpTrk5iqHxmzS2DJi9/+UOun4IRPMCs8IC8TkGz8PU
         KWV3pBPA4UPB3LrTCip7i0hPDwZ//oe8aYl9DXal4xvGmqDjbnQz5UkgCkjq2DG+Gi4r
         7ySBr4SXjwGBaarIggznjoeWEDp4WjQ4hJqkaaNo4ZdV7LWAKTl/ZjEKNPJsZMPcmPTa
         EU1SSE9q7UWwuf4UcvTdDLSnyeb2PwM7HxDDtIvwS2okZ5J6j4QXOyXqO+0kFG0ZGjNj
         hv8A==
X-Gm-Message-State: AJIora9+oack3fT645cAbnsgiS+Xj8KlJlk4mp5HfzWQjKwuQyMIj7vG
        RrnoWGT2z78lmbFvCJWOzG2IfuSnj7rGVJgiYnroqA==
X-Google-Smtp-Source: AGRyM1untAtN1WYQrJZsigBhKn2EAZObctQZWEj9UO7eADOFB1CYKYePpRc3z7bi0EcjTCtmqdei+tsdUnJrI6FmTOI=
X-Received: by 2002:a5b:9c5:0:b0:66e:cbbf:2904 with SMTP id
 y5-20020a5b09c5000000b0066ecbbf2904mr24704895ybq.220.1658137217225; Mon, 18
 Jul 2022 02:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220713025233.27248-1-samuel@sholland.org>
In-Reply-To: <20220713025233.27248-1-samuel@sholland.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 11:40:06 +0200
Message-ID: <CACRpkdb2ZGDTe6+X6fBZKRNs9GMt0ZT4D=hZJAc9L1d_W=W0OA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] pinctrl: sunxi: Allwinner D1 support
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
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

On Wed, Jul 13, 2022 at 4:52 AM Samuel Holland <samuel@sholland.org> wrote:

> In the interest of keeping the series ready for v5.20, I decided to drop
> the D1s bits so we can decide how to handle the compatibles next cycle.
>
> This series adds pinctrl support for the Allwinner D1 SoC. First,
> it updates the I/O bias code to support the new mode found on the D1
> (as well as some existing SoCs). Then it refactors the driver to support
> the new register layout found on the D1. Finally, it adds the new
> driver.
>
> The code size impact of the dynamic register layout ends up being just
> over 100 bytes:
>
>    text    data     bss     dec     hex filename
>   11293     564       0   11857    2e51 pinctrl-sunxi.o (patch 3)
>   11405     564       0   11969    2ec1 pinctrl-sunxi.o (patch 6)
>
> This series was tested on A64, H6, and D1.
>
> Changes in v2:
>  - Drop D1s compatible for now, due to ongoing discussion
>  - Fix PE3 function "csi0" -> "ncsi0"
>  - Fix comments for JTAG DI/DO pins
>  - Include channel numbers in PWM functions
>  - Drop the separate D1s variant, since D1s is a non-conflicting subset
>  - Enable the driver for MACH_SUN8I to cover T113 (same die, but ARMv7)

Took out v1 and applied this v2 instead!

Thanks!
Linus Walleij
