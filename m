Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DE94DD724
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbiCRJfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiCRJfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:35:21 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34453EAB8;
        Fri, 18 Mar 2022 02:34:02 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id w12so13172632lfr.9;
        Fri, 18 Mar 2022 02:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=lKlHbqIy06Ai/ILupuRuVIb8OQFBL4S3BVKPW1zPqok=;
        b=6NcH0lgUPqNdc3/iyFBnVJN0Zt1YwUaAnvfxHjuGDr923YNbjfW0x5qPoESMw0WCSt
         OzklHKD2H6Fov+rgEVoRVBRKV6Npm2518t+XCOFj8mojBElNQrqLQAe5DMH4MXL6j/YO
         cbcxxk/9Mltiy6Rm+lZCWBE4E04xfnxPffKkBuQ6paUe8soo/9/G3qsxktqrWNWduhHi
         VTlPa+sGdqkdgP/e76n6gXnLQT4QOt3g10wM6AmOUU0rdSYCXl/feTRInmadvWYPI766
         peL/hV/CCI4Dt997/dlRamqqE3gQeeS2DsCJbLHn8OIbNkVi0wAh8Ew2pOI0KnVwa2K5
         ifqQ==
X-Gm-Message-State: AOAM531ktfOW0Xb0Z1JJpHZq9Ic6q1NPiTvNZLcmDdYtCMuZNZJ3Je5u
        DZWec9FkiPKqEt1RLdKRFMw=
X-Google-Smtp-Source: ABdhPJxsx+3czltj2ewV/qub1jNboUK9LxWZJRrSSt+5gHyCLkDGlg9/N94c5NyOBmBT4FKI7/DYxw==
X-Received: by 2002:a05:6512:260b:b0:444:18:fce5 with SMTP id bt11-20020a056512260b00b004440018fce5mr5450631lfb.119.1647596041179;
        Fri, 18 Mar 2022 02:34:01 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id w27-20020ac2599b000000b004481e254f08sm763354lfn.240.2022.03.18.02.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 02:34:00 -0700 (PDT)
Message-ID: <0a8c7661-806e-f403-8903-b6c1b4e3e23b@kernel.org>
Date:   Fri, 18 Mar 2022 10:33:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 5/5 v2] dt-bindings: gnss: Rewrite Mediatek bindings in
 YAML
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220317225844.1262643-1-linus.walleij@linaro.org>
 <20220317225844.1262643-5-linus.walleij@linaro.org>
In-Reply-To: <20220317225844.1262643-5-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2022 23:58, Linus Walleij wrote:
> This rewrites the Mediatek GNSS bindings in YAML.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - New patch since Krzysztof pointed out there is really just
>   one more binding to convert, so why not.
> ---
>  .../devicetree/bindings/gnss/mediatek.txt     | 35 ------------
>  .../devicetree/bindings/gnss/mediatek.yaml    | 54 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
> deleted file mode 100644
> index 80cb802813c5..000000000000
> --- a/Documentation/devicetree/bindings/gnss/mediatek.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -Mediatek-based GNSS Receiver DT binding
> -
> -Mediatek chipsets are used in GNSS-receiver modules produced by several
> -vendors and can use a UART interface.
> -
> -Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> -properties.
> -
> -Required properties:
> -
> -- compatible	: Must be
> -
> -			"globaltop,pa6h"
> -
> -- vcc-supply	: Main voltage regulator (pin name: VCC)
> -
> -Optional properties:
> -
> -- current-speed		: Default UART baud rate
> -- gnss-fix-gpios	: GPIO used to determine device position fix state
> -			  (pin name: FIX, 3D_FIX)

What happened with this property? It looks not used, but still I am not
sure we should remove it.

> -- reset-gpios		: GPIO used to reset the device (pin name: RESET, NRESET)
> -- timepulse-gpios	: Time pulse GPIO (pin name: PPS1, 1PPS)
> -- vbackup-supply	: Backup voltage regulator (pin name: VBAT, VBACKUP)
> -
> -Example:
> -
> -serial@1234 {
> -	compatible = "ns16550a";
> -
> -	gnss {
> -		compatible = "globaltop,pa6h";
> -		vcc-supply = <&vcc_3v3>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/gnss/mediatek.yaml b/Documentation/devicetree/bindings/gnss/mediatek.yaml
> new file mode 100644
> index 000000000000..273732225c1f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gnss/mediatek.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gnss/mediatek.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek GNSS Receiver Device Tree Bindings
> +
> +allOf:
> +  - $ref: gnss-common.yaml#
> +
> +maintainers:
> +  - Johan Hovold <johan@kernel.org>
> +
> +description:
> +  Mediatek chipsets are used in GNSS-receiver modules produced by several
> +  vendors and can use a UART interface.
> +
> +properties:
> +  compatible:
> +    const: globaltop,pa6h
> +
> +  vcc-supply:
> +    description:
> +      Main voltage regulator, pin name VCC.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: An optional reset line, with names such as RESET or NRESET.
> +      If the line is active low it should be flagged with GPIO_ACTIVE_LOW.
> +
> +  timepulse-gpios:
> +    description: Comes with pin names such as PPS1 or 1PPS.

This should not be needed here (same as patch #3). While changing it,
move also "allOf" just before properties.


Best regards,
Krzysztof
