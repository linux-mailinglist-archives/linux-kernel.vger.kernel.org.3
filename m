Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D714D6E86
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 12:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiCLLmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 06:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiCLLmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 06:42:43 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD8C2241DB;
        Sat, 12 Mar 2022 03:41:38 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id p15so24271121ejc.7;
        Sat, 12 Mar 2022 03:41:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=maGuVPIm8jt7vYFlOH4avp82ShbbjB6n0V5LUhdfWyA=;
        b=agM3ueqiZkO7l/uFm2h/KFiiRst82FVhuvSGgVYjeAWlVZYn7hlcJQsNUAoa53A/1w
         vmvMdnF8f43lH99OKukRh5zz7wUEZiHDyOdRo1EwbjxvuCc1b1Yo9sXu6lSbK72dI5P1
         2lc4cHkH1my89X1ZQihYUgf7knqneH6A/Aq5sEsuYb5ydPmdIn7doPKKOWSti2pD3MPg
         fIR9YPLdvpJJLyYAVIV3ukrBr5+3lCc/lLiZLfhx7kTqcFHbZjIQrO1NMaDV6Rh7ap7v
         Ec50P8TJs4j5Xj6k61UILF4t3ffoT784K2jVOakeiEjZObCj6b2ZNRseE1wyimCpBe3R
         zqPw==
X-Gm-Message-State: AOAM533xQAzC2LtALZbxb6eKvfDzQ3xgSE/+5k/folCJgA7qk8KNg7cY
        +MZISPcEQNq7XnUCCpXxa5insbY14/Y=
X-Google-Smtp-Source: ABdhPJxZniK9oeDfPgTI56uTBXM40JGaNihon/pAiojFBK0gFwRMJwsQTWHFV/71JIfMIF5ngJmiNw==
X-Received: by 2002:a17:906:eb51:b0:6db:a3d:3a0b with SMTP id mc17-20020a170906eb5100b006db0a3d3a0bmr11967498ejb.140.1647085296526;
        Sat, 12 Mar 2022 03:41:36 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id ka6-20020a170907990600b006ce54c95e3csm4205452ejc.161.2022.03.12.03.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 03:41:36 -0800 (PST)
Message-ID: <61df8371-c5ef-9e68-f9ae-19c8d20c64dc@kernel.org>
Date:   Sat, 12 Mar 2022 12:41:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] dt-bindings: gnss: Modify u-blox to use common
 bindings
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220311235119.523374-1-linus.walleij@linaro.org>
 <20220311235119.523374-2-linus.walleij@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220311235119.523374-2-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2022 00:51, Linus Walleij wrote:
> This modifies the existing U-Blox GNSS bindings to reference
> the common GNSS YAML bindings.
> 
> Fixed an unrelated whitespace error while at it.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/gnss/u-blox,neo-6m.yaml        | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
> index 396101a223e7..5dffe722777f 100644
> --- a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
> +++ b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
> @@ -6,6 +6,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: U-blox GNSS Receiver Device Tree Bindings
>  
> +allOf:
> +  - $ref: gnss-common.yaml#
> +
>  maintainers:
>    - Johan Hovold <johan@kernel.org>
>  
> @@ -29,16 +32,13 @@ properties:
>      description: >
>        Main voltage regulator
>  
> -  timepulse-gpios:
> -    maxItems: 1
> -    description: >
> -      Time pulse GPIO
> +  timepulse-gpios: true
>  
>    u-blox,extint-gpios:
>      maxItems: 1
>      description: >
>        GPIO connected to the "external interrupt" input pin
> -  
> +
>    v-bckp-supply:
>      description: >
>        Backup voltage regulator

I propose to change additionalProperties->unevaluatedProperties and
remove current-speed and timepulse-gpios. This way also new properties
from gnss-common can be easily used.

Best regards,
Krzysztof
