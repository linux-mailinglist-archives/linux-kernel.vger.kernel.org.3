Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB7E55AC9F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 22:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiFYUih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 16:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiFYUig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:38:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4941613EAF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:38:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id fd6so7892496edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MfJhDTjDLNxHEOb0O70IYA2LdOjCiYcIoiUYXbrNOZ4=;
        b=JHokDgSBVB0acKRGJoylSeaZb3PORhzalT1OMuL1Xpx6TTt+EtewQAhP3OdWqg5IoT
         mRGcmhAzXpOT9HqrUOXV5VB5tEPz0Kb4pwLONY95kGUEIuLePUBinAPKRvVFMFljKxJ3
         Yp32RJinLVg7pllz/zmVr/+jm6LCOCuvTziT1NXnmqSWZX4ihi8JYglFFSLANHeIW+To
         /OybiTvi+xfAbtjR32QEHksWECEa9lF4FKIn1FMdgjyAcoaUBEXU9loGUWKkUcF0Gtmg
         LTYoQoHgyWMHoIXuToyOcEW4XkVe/jFCQ+wrh1oGqiB8uBxPpuGsbJNPxcugasfqWGP+
         LTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MfJhDTjDLNxHEOb0O70IYA2LdOjCiYcIoiUYXbrNOZ4=;
        b=wYtO6jVkWOyeciqszSpEXI9WHyB39vfxozwdkwZBFx8LfCVV8oYbouu4IX/Qlk8pMP
         VdE9bO/w0qGoGkQgSxghGJjkh57kkC0JKroR/X7eJQE900WrdAcqotMlD5HMZ16izNCF
         R8NFFrCsUiV/uo3emYFAfBWL+lFq+HCtKs9ifHhHIkJaYOWacRznoVoWWe2iLeSEjVz1
         kbpgM2IkF+fjiYck9Y4R0xQ0/JghQQDfws1Yuqx0DSY7eKuEEXlIuiksSPMmSRWQZiqN
         TJ+cqfH6W9TcRkQZoegzdr4xUCwJ6w5odmqMOTOr9x/khoKmY/AJUIuAdDOs3nYmuyYj
         9vrA==
X-Gm-Message-State: AJIora/J7PXZKElQeU5h20Xt0Sz01qUvFAMYEy4AAzU7NZUC8BUiGgdz
        nzR3nTtXwvW2UzvWvc3VObNXvg==
X-Google-Smtp-Source: AGRyM1twbLaxDqEWBJhXOCA/HSV54AxQLykkUVdEnBcNoXWXhA0wOnXIAdRMUyLxgzdJFE5KGxAtnQ==
X-Received: by 2002:a05:6402:1bc1:b0:435:67ef:2f41 with SMTP id ch1-20020a0564021bc100b0043567ef2f41mr6856792edb.85.1656189513876;
        Sat, 25 Jun 2022 13:38:33 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x2-20020aa7d382000000b00435640c141esm4572024edq.93.2022.06.25.13.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 13:38:33 -0700 (PDT)
Message-ID: <62719859-bfed-6c85-76c9-ede0b75d492e@linaro.org>
Date:   Sat, 25 Jun 2022 22:38:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V9 1/3] dt-bindings: rtc: zynqmp: Add clock information
Content-Language: en-US
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        srinivas.neeli@amd.com, neelisrinivas18@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        sgoud@xilinx.com, shubhraj@xilinx.com
Cc:     devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@amd.com, git@xilinx.com, Rob Herring <robh@kernel.org>
References: <20220624120203.2817457-1-srinivas.neeli@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624120203.2817457-1-srinivas.neeli@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2022 14:02, Srinivas Neeli wrote:
> Added clock information and deprecated calibration support.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in V9:
> -Updated clock information in clock-names.
> Changes in V8:
> -None
> Changes in V7:
> -None
> Changes in V6:
> -Removed dtc warnings.
> Changes in V5:
> -Removed quotes and _clk suffix from clocknames.
> Changes in V4:
> - Deprecated calibrtion support
> Changes in V3:
> - New patch
> ---
>  .../devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml     | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
> index bdb72d3ddf2a..9dfe2cc5966a 100644
> --- a/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml
> @@ -23,8 +23,15 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: rtc
> +
>    interrupts:
> -    minItems: 2
> +    maxItems: 2
>  
>    interrupt-names:
>      items:
> @@ -39,6 +46,7 @@ properties:
>      minimum: 0x1
>      maximum: 0x1FFFFF
>      default: 0x198233
> +    deprecated: true
>  
>  required:
>    - compatible
> @@ -61,5 +69,7 @@ examples:
>          interrupts = <0 26 4>, <0 27 4>;
>          interrupt-names = "alarm", "sec";
>          calibration = <0x198233>;
> +        clock-names = "rtc_clk";
> +        clocks = <&rtc_clk>;

Please test your bindings with `make dt_binding_check` before sending.



Best regards,
Krzysztof
