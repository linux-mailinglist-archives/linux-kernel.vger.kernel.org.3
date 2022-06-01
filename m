Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4580C539EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350399AbiFAHts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343726AbiFAHtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:49:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949B99CC8E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:49:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n10so2005334ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 00:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Sm++4DrzLTUG9tiCKNeXhjWxZd3ZyuWj0+VaaIO2niE=;
        b=AlhVW3/4AZpS+4A5mn2asiqsGH5B9GKGts+SgUbQhgG2g2gRqeB/phmXsUEiMut/0l
         D/bxWzkivGd/qgJhlef19SWv/8ksgYIiEoaKIKrBNyJ0EuwYOE/i5vcZFYCCPF0ioL+H
         3i4XxaboY/HACuxmNRzH7BFkH67KRvTzQzc6p6L/vdW1BP0WKA9ZSuVlmmIV+XIi1fG0
         XS6uR+D9SrjF7jtBmNDBa/cI7BcZBlvP5zwOdJhG4KsPDtRMvuDzDC/UE/KE3Ba48dPc
         cto03EKypG6CeWwFfIDLpS+XSnfuIACThgZGOSIv9d1zvcV7xv/weL9TrumYmCOwqDTQ
         mxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sm++4DrzLTUG9tiCKNeXhjWxZd3ZyuWj0+VaaIO2niE=;
        b=fMoGfSRAlolad1CbgLF8YFpU5hN7UUePyVuAjom/BG2f8r3DO1CgBewUckyFh4zWtZ
         Z9hEqLMP0KfYHnAcPstfgYE0QOONNUJf1PhqrJaQQIhL6pGqWmGUKdSSslBYmfqcTLIK
         7nvTtcDlCStcRmWpbgA1NVhh3n2oFfyucbmaDPPSi/qsDkCPGioNzyikh8AATs7VaWF8
         gnl5f8RHuBLoTEzSsCpaOuxswnYZq6h5l6dcp6fG9ckjJDglelu7U9m+iB2tvUzOeFVS
         WtXmY0hSFH5T3b1L187g6HRNwfKy35R7ylW/AnGWTDX8SHwg/2bR+y9wW7OJVHCwBGGR
         6/fw==
X-Gm-Message-State: AOAM530MOgx1oXM6RleYOwNdOwSFiN1nB4Mo/Ja+BjPvLT5vp1dKLsy2
        LB7WlVJl2JH97Mz2l1PJNwy2gQ==
X-Google-Smtp-Source: ABdhPJz7UFukrm2jvPWd/lGUDw/WsujyoWdPvF7XRSXo1gYSXArgywz05H3nKoE1XWX/K0U0YOt4pg==
X-Received: by 2002:a17:906:9c82:b0:6df:baa2:9f75 with SMTP id fj2-20020a1709069c8200b006dfbaa29f75mr56556870ejc.762.1654069783167;
        Wed, 01 Jun 2022 00:49:43 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d21-20020a056402001500b0042aa23fa93bsm537869edu.20.2022.06.01.00.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 00:49:42 -0700 (PDT)
Message-ID: <33319cd8-b300-27de-1871-f12bc860330d@linaro.org>
Date:   Wed, 1 Jun 2022 09:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] dt-bindings: display: Add bindings for ClockworkPi
 CWD686
Content-Language: en-US
To:     Max Fierke <max@maxfierke.com>, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220601051748.1305450-1-max@maxfierke.com>
 <20220601051748.1305450-3-max@maxfierke.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601051748.1305450-3-max@maxfierke.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 07:17, Max Fierke wrote:

Subject: remove word "bindings" because you duplicate prefix, so
"dt-bindings: display: Add ClockworkPi CWD686 panel".


> +required:
> +  - compatible
> +  - reg
> +  - backlight
> +  - reset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    backlight: backlight {
> +        compatible = "gpio-backlight";
> +        gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>;
> +    };

No need for backlight example, it is trivial/same for everyone.

With that removed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "clockworkpi,cwd686";
> +            reg = <0>;
> +            backlight = <&backlight>;
> +            reset-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;
> +            rotation = <90>;
> +        };
> +    };


Best regards,
Krzysztof
