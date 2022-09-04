Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C865AC5FA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 21:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiIDTI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 15:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIDTI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:08:26 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5085F1054D
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 12:08:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p16so10405447lfd.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 12:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=YlkqaOEVfnAcJNdhPnwwyOFkWGniyUwZfTkbWM3JHJU=;
        b=QPTVeGwGHyB4PL/sHpYy7p22E6WFaqGiRYwoqgTJz+HosSqH4kTIcJrx+WvKKcTaif
         X5+5jekS2yhUfmoL43nWc7zFasmiZYcm2Tb5Bk5ERZESMdDXCCe2w1LdA2M961efLlu6
         r5cIuXiOMzfYjYLhFa0qv/5d97ItAlmwnPaqRKqix9TxnrCMbjjaGvL19fTgzlTnNZHT
         +3RqmCDdYOtKu8dlDqIyjCC0nIccSoTH3BNtP6uyGfWpQTnsdb6oYNspTDzu5DnOZo65
         JSZ0cqbwxijrCcbMOkLmdbjvWF450RP2MWtnZYXYus8jYTv7ySiOIMOYQPwb+v6+eBW7
         +nXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YlkqaOEVfnAcJNdhPnwwyOFkWGniyUwZfTkbWM3JHJU=;
        b=gd6Js7fgmS+ygJB5KatscdTA81wnXqyIzHv7aS3v2Ta3RVY2haU+MQJmitIQx9F/od
         VE5ci8+C3P4w+NQy95ZO+j2W7d/srsAHHRdWKmUk4xfJO66yhu5TsuupqtoyIxWeGMK4
         Z26g7Gnz46uZ8+ieeMlIEJVwlA75UmMSvcdr3eyZmJl2dKnDV1v1lOFOsFim46Vj3djB
         hP7HKgBUh+ILe2da6XBTfo44Z1cNvyenEIYr/EAIT8w9MFC9Q+oIcb+nZI+EzUExegKo
         HFsLWRJiBrZh3zocum93qsiwCJJBSpDbtRxGAOo/xMm+nk/B0IDuAR2kbYq3w4GpZdP1
         V86Q==
X-Gm-Message-State: ACgBeo0XrTwOSdKqsrH2lQLJz9+OnuW4TyD1ueKZzmC0MXEFYUNvm+aV
        9jLYOF+gV57rhtE61mdW6E0P5BYaCHSOSYprJI8=
X-Google-Smtp-Source: AA6agR7p5IsnW2ri1U1OVp+ptkLLArOLKqo0mv2HoCsVhvLQZUTZmSmhIRi0jPVkHoGttS5sY9kypQ==
X-Received: by 2002:ac2:4e15:0:b0:48b:7a5f:923c with SMTP id e21-20020ac24e15000000b0048b7a5f923cmr16415296lfr.134.1662318500695;
        Sun, 04 Sep 2022 12:08:20 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a24-20020ac25218000000b0048a7ef09b22sm985464lfl.274.2022.09.04.12.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 12:08:20 -0700 (PDT)
Message-ID: <167a7200-264f-3214-d4b1-e1daaafb6985@linaro.org>
Date:   Sun, 4 Sep 2022 22:08:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/4] dt-bindings: display: Add ClockworkPi CWD686 panel
Content-Language: en-US
To:     Max Fierke <max@maxfierke.com>, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220903183753.25736-1-max@maxfierke.com>
 <20220903183753.25736-3-max@maxfierke.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220903183753.25736-3-max@maxfierke.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2022 21:37, Max Fierke wrote:
> The CWD686 is a 6.86" IPS LCD panel used as the primary
> display in the ClockworkPi DevTerm portable (all cores)
> 
> Signed-off-by: Max Fierke <max@maxfierke.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes in v2 (Krzysztof Kozlowski and Rob Herring's Suggestions)
>  - remove redundant backlight example
>  - add missing regulators
> 
>  .../display/panel/clockworkpi,cwd686.yaml     | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml b/Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml
> new file mode 100644
> index 000000000000..eaf55d629266
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/clockworkpi,cwd686.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ClockworkPi CWD686 6.86" IPS LCD panel
> +
> +maintainers:
> +  - Max Fierke <max@maxfierke.com>
> +
> +description: |
> +  The ClockworkPi CWD686 is a 6.86" ICNL9707-based IPS LCD panel used within the
> +  ClockworkPi DevTerm series of portable devices. The panel has a 480x1280
> +  resolution and uses 24 bit RGB per pixel.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: clockworkpi,cwd686
> +
> +  reg:
> +    description: DSI virtual channel used by that screen
> +    maxItems: 1

You still need blank line here.

> +  iovcc-supply:
> +    description: regulator that supplies the iovcc voltage

And here...

> +  vci-supply:
> +    description: regulator that supplies the vci voltage
> +


Best regards,
Krzysztof
