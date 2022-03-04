Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059C94CD705
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbiCDPCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbiCDPC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:02:29 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F0E1BD9BD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 07:01:41 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6A5E93F5F9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 15:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646406100;
        bh=veW4gKIbKo9jmCs1Wuv5XKB6ixDrTo7kj8IuMc2L6jg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pGvlInyP5nsEnv2ieQEJQj0xU33/9KyzT3Y8oL14o5rpl5ZjZPQATtVqT+JEO8ITI
         0Rb0b7IUNCNSdHX/E278DDEA3MyuacQF1L5fWa9AqGqGisGJy7P4ia0f7gBKcqc+ID
         7qcTU57ZyrdKlw62h30WpJLrHl1gq6YfpbdUVZx6hOnjwT7jTt/5STTsjk6K8rA4ZB
         TQoCsgNFaY11kgDvytRP1A+xOmnQ+gIauC2IBjCHd5OFFCpRPY6wMVq7kt7vUZhys4
         SjpCi/Z4Mszjh/QfvIxx74b9MOMSP8Qr/kzjYhaD/T4GMnbcD8vXBH0L74CzlRpgCl
         l8kYKo6OzXqZw==
Received: by mail-ed1-f69.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso4691568edt.20
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 07:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=veW4gKIbKo9jmCs1Wuv5XKB6ixDrTo7kj8IuMc2L6jg=;
        b=fej1P+By+62myn9cN3Gy/iKOivimxSs/SwBzGgU2sxf2kLbbdauYz2dWhjcDZGsCgw
         qnPJ10tHuLvt8rMODaoPo4OQPglakQ9MnqQd0bViYF0flzCbLEzZPB1Jl29DDB3ad0WU
         6DGA6CSj15xyX5uTl4MV/PNtamgchjPYKrd6dMAnkUm/Sxg3kYb1QiHW/Ftl6wUg3Pam
         +YqcONPCBCjroeSaQqBSU19DyOpnIhASqWvW3zcfxik9ku1ImHzUMtbA5Buj7V31FMT9
         SncRDyv/QusbQDi9gM2iItHqRFxf+1/GgQ1a8ewPdTwRpAfFA/NB9TSeQ72Sxg0o4TmJ
         BsTw==
X-Gm-Message-State: AOAM531vTobOa6h7xttE+vrHgfmyu6/x/nnqVOQjZsuaImjRI1wc+LsO
        DK0MVe6HEBKRPkBFnmYqLwAHNN+gdk/i9Fa26nN/oMWSTdfB8TG9JoQZaS3QmCAK7xDjNbenAIo
        0fCPXQYwDHuXUbUmR3we4iM7UMmyIJhTexaZjCkOIIA==
X-Received: by 2002:a05:6402:3489:b0:415:bc37:a81f with SMTP id v9-20020a056402348900b00415bc37a81fmr12512743edc.354.1646406100072;
        Fri, 04 Mar 2022 07:01:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgaVeX2hMApbdyglZkusLEVifJ+zoAKzqcXR0aV/1vWe1MjVa35U8Tzx/bcGq+skX2sVwWTA==
X-Received: by 2002:a05:6402:3489:b0:415:bc37:a81f with SMTP id v9-20020a056402348900b00415bc37a81fmr12512608edc.354.1646406098927;
        Fri, 04 Mar 2022 07:01:38 -0800 (PST)
Received: from [192.168.0.139] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id k3-20020a05640212c300b0041605b2d9c1sm603615edx.58.2022.03.04.07.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 07:01:37 -0800 (PST)
Message-ID: <9113e319-58a2-fd90-6887-fb32eb21fd18@canonical.com>
Date:   Fri, 4 Mar 2022 16:01:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings:pwm:Add bindings doc for Sunplus SoC
 PWM Driver
Content-Language: en-US
To:     Hammer Hsieh <hammerh0314@gmail.com>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com
References: <1646374812-2988-1-git-send-email-hammerh0314@gmail.com>
 <1646374812-2988-2-git-send-email-hammerh0314@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1646374812-2988-2-git-send-email-hammerh0314@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2022 07:20, Hammer Hsieh wrote:
> Add bindings doc for Sunplus SoC PWM Driver

You miss spaces in the subject.

> 
> Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
> ---
> Changes in v2:
>  - Addressed all comments from Rob Herring.
>    modify author's mail match Signed-off-by.
>  - rebase kernel to 5.17 rc5
> 
>  .../devicetree/bindings/pwm/pwm-sunplus.yaml       | 40 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 +++
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml b/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
> new file mode 100644
> index 0000000..19fe5d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-sunplus.yaml#

Is it going to be one binding for all Sunplus SoCs? Existing and future?

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus SoC PWM Controller
> +
> +maintainers:
> +  - Hammer Hsieh <hammerh0314@gmail.com>
> +

allOf with pwm.yaml
Then unevaluatedProperties instead of additionalProperties.


> +properties:
> +  '#pwm-cells':
> +    const: 2
> +
> +  compatible:

Commpatible goes first. Rest of properties you could order
alphabetically. Similar approach in required.


> +    items:
> +      - const: sunplus,sp7021-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:

compatible

> +  - reg
> +  - clocks


> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm: pwm@9c007a00 {
> +      #pwm-cells = <2>;
> +      compatible = "sunplus,sp7021-pwm";

compatible goes first, then reg.


Best regards,
Krzysztof
