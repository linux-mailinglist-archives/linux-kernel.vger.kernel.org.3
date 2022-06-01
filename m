Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17731539E45
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350332AbiFAHfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345986AbiFAHe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:34:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BF2813D2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:34:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id fd25so978835edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 00:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UkKpNYLV+QZV53hwWfH5fNHVrBq7gV6/OoYtJa/OWHg=;
        b=rMnrfEU0hqxNbgO3Ngd4aiEKTa1atj5Akph4RlI7CZIaOcu1EO+hnB5M0SZ23e/3z2
         rN7OEJEvscZpeWlRG7rWq53GkfQjm3Gq7tRIKXdTgw7OU0jszTjSXI/x/abDIi4/YrLW
         y6D4ObKimOf5l5JILct6SzrdKI//yM3Xd3wezrz3e0Jgf6E/GnN4jlSR2xoDvzSA3cEe
         r7+Z2Y2HxfKsW1IK7UxozvJkgXuUlooXD0+gnyqDqslcPpTu3yAt36QJjN/yef+m0H6Z
         5WYBQb3lILHrheefyEo1M+ENIANP5hCJ55qRPEphBhEQNSaOv5FqsoWn1cmcw4pbaHzg
         g/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UkKpNYLV+QZV53hwWfH5fNHVrBq7gV6/OoYtJa/OWHg=;
        b=PoBZROW7Ah3k4G0RZBw86MKWgLTy1OCadZT3bO7jPNESg0ylYzjm52VacfrjZehaSd
         WNUTsr27NPg+SnmPwF+YURTmfDd5ahjqO/dLbsvAws0FitIikejKt/rNta7m4FLK8SY5
         ZOTR8rEJsNwtjCABGz7bs7y3Z6A6gn9Cv8BmhyilmQf7Xc240E7Ix9H1QR7z2d2UJR9I
         cXPoktpEOWH39TJWptOVMlt2YYTHQhJlg4/qeRoNruPhtRKAJMom20Vk1S+jHEOxmCz8
         OjwLGFit69k+ruKxVdVQ9MtbUGvo9jFG25RBOKwoNihugz8WyVSVQ2EhTl+PKeP/g0/u
         gJ6g==
X-Gm-Message-State: AOAM530uQeAPrIh9g/XY2EAlgt0G6s7shavjUlGbBt5+oUUeAurw8In5
        wRa4mw3zvwk53KsDKWtF06drGw==
X-Google-Smtp-Source: ABdhPJz96yqdhicWuQ/1oz1BY3Wwhy9jxY/RrbCB45rlVIhHe75cCdPoQVOlyJGi8PCpDIpC7VcczQ==
X-Received: by 2002:a05:6402:518f:b0:42b:4404:63d4 with SMTP id q15-20020a056402518f00b0042b440463d4mr56379750edd.177.1654068896097;
        Wed, 01 Jun 2022 00:34:56 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k11-20020a056402048b00b0042ab02e3485sm509213edv.44.2022.06.01.00.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 00:34:55 -0700 (PDT)
Message-ID: <6227bc72-fe7c-561a-073d-bd5e6debc68f@linaro.org>
Date:   Wed, 1 Jun 2022 09:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 13/14] dt-bindings: backlight: Add Mediatek MT6370
 backlight binding documentation
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     cy_huang@richtek.com, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20220531102809.11976-1-peterwu.pub@gmail.com>
 <20220531102809.11976-14-peterwu.pub@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531102809.11976-14-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 12:28, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add mt6370 backlight binding documentation.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../backlight/mediatek,mt6370-backlight.yaml  | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
> new file mode 100644
> index 000000000000..81d72ed44be4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/mediatek,mt6370-backlight.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/mediatek,mt6370-backlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT6370 Backlight
> +
> +maintainers:
> +  - ChiaEn Wu <chiaen_wu@richtek.com>
> +
> +description: |
> +  MT6370 is a highly-integrated smart power management IC, which includes a
> +  single cell Li-Ion/Li-Polymer switching battery charger, a USB Type-C &
> +  Power Delivery (PD) controller, dual flash LED current sources, a RGB LED
> +  driver, a backlight WLED driver, a display bias driver and a general LDO for
> +  portable devices.

Do not repeat entire device description, but describe only this part.
Your other pieces of MFD were doing it correctly, so why here it is
different?

> +
> +  For the LCD backlight, it can provide 4 channel WLED driving capability.
> +  Each channel driving current is up to 30mA
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6370-backlight
> +
> +  default-brightness:
> +    minimum: 0
> +    maximum: 2048
> +
> +  max-brightness:
> +    minimum: 0
> +    maximum: 2048
> +
> +  enable-gpios:
> +    description: External backlight 'enable' pin
> +    maxItems: 1
> +
> +  mediatek,bled-pwm-enable:
> +    description: |
> +      Enable external PWM input for backlight dimming
> +    type: boolean
> +
> +  mediatek,bled-pwm-hys-enable:
> +    description: |
> +      Enable the backlight input-hysteresis for PWM mode
> +    type: boolean
> +
> +  mediatek,bled-pwm-hys-sel:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    enum: [0, 1, 2, 3]
> +    description: |
> +      Backlight PWM hysteresis input level selection.
> +      value mapping:
> +        - 0: 1bit
> +        - 1: 2bit
> +        - 2: 4bit
> +        - 3: 6bit

Please explain what is this input level and what is the meaning of
6bit... In any case you cannot have values mapping, but instead you
should use the logical values (so 1, 2, 4, and 6).

If "sel" is shortcut of "selection" please drop it.

> +
> +  mediatek,bled-ovp-shutdown:
> +    description: |
> +      Enable the backlight shutdown when OVP level triggered
> +    type: boolean
> +
> +  mediatek,bled-ovp-level-sel:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    enum: [0, 1, 2, 3]
> +    description: |
> +      Backlight OVP level selection.
> +      value mapping:
> +        - 0: 17V
> +        - 1: 21V
> +        - 2: 25V
> +        - 3: 29V

Logical values in microvolts. Name it according to unit suffices and
drop any useless parts of property name like "level selection". It is
simply - mediatek,bled-ovp-microvolt.

> +
> +  mediatek,bled-ocp-shutdown:
> +    description: |
> +      Enable the backlight shutdown when OCP level triggerred.
> +    type: boolean
> +
> +  mediatek,bled-ocp-level-sel:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    enum: [0, 1, 2, 3]
> +    description: |
> +      Backlight OC level selection.
> +      value mapping:
> +        - 0: 900mA
> +        - 1: 1200mA
> +        - 2: 1500mA
> +        - 3: 1800mA

Same comments.

> +
> +  mediatek,bled-channel-use:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description: |
> +      Backlight LED channel to be used.
> +      Each bit mapping to:
> +        - 0: CH4
> +        - 1: CH3
> +        - 2: CH2
> +        - 3: CH1> +    minimum: 1
> +    maximum: 15
> +
> +required:
> +  - compatible
> +  - mediatek,bled-channel-use
> +
> +additionalProperties: false


Best regards,
Krzysztof
