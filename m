Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA3E598465
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244655AbiHRNkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245165AbiHRNjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:39:35 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25785FF6B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:39:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u9so2145482lfg.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=KSIaXxhyUIHIxlq/rUi5FI75cBAK/krT+tEUbMY1wsg=;
        b=FVZCcLXPj781ifyjzK4x11TqiJbBkK38M1Eu90Wi1nIRgof+t5RQw3C1TLIuCf8jA4
         8uE6TaW8l1RgH66BeiDgE11x/bvPDdmWLSgkCACrV2/Sfvr50y8qWg08VlyiL/X9UG3U
         Di13Pc9xKdvDfsC5F42PTVGkuoi44qFlJZRoAF9ygwVQx9d/mVNHkmtJFRlmnSJ2dDhB
         DgTt68Ej89TbqUgrvw+fnUvus5ZCbQ+Paa9UAT2oI/xA8RpdO7jCASTSP1i7N/Zq7ge/
         oFOIAi5VpcARVyez12RNr3dbrCDpa2h9tpD4Zy8f5/p/qv8kg3RD7NtIKuPV+zx17pFO
         7odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KSIaXxhyUIHIxlq/rUi5FI75cBAK/krT+tEUbMY1wsg=;
        b=Pli9q9JzC7C+GTvQMdv/aeIpXjVFnlDFcyTsltnkZq3IF4Lahd0+qdY9orwDdN+Q+U
         Wivl7vjjPoYgzfsg434rDdFuEFjRVb7x4Ps01H0law9v8UW7EL5EwIiB2rTMsym4JN/9
         WpCeT16U/Fl7kYqwtri6lWKfngUm4NrGui3YF0A+NNZErN4hGsZIlR9OazRGI0IXZEnl
         Jm568zWPKPR7J5JwvSAoc5KN6Qa4aTethq7CJFnY0cXIPukPKPQx5RulE7VpmgoMAA93
         XsfsXel28McZzOw9eNyhuzJFfAPnKIr2NSK+EBzIOv9Zz5odOjVgBHlDS6wKNW4+kw5H
         3d8w==
X-Gm-Message-State: ACgBeo1g6FLF5PoPfm6MVcsNTkRRPEenXsLYzVWZA6tBlaTgrhD+e/Pq
        vEYaD7+xjYxa3vD19kBWJAWHPQ==
X-Google-Smtp-Source: AA6agR5WaeCT380GrnAMAJDvP+dDmL6sElrkgK5h271JvA81tOxhuMDA3YDK2SzQRVeHLS8LmdKuMA==
X-Received: by 2002:a05:6512:3f02:b0:48d:244e:426f with SMTP id y2-20020a0565123f0200b0048d244e426fmr910569lfa.333.1660829956324;
        Thu, 18 Aug 2022 06:39:16 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id d23-20020a193857000000b0048b4690c78esm219975lfj.288.2022.08.18.06.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 06:39:15 -0700 (PDT)
Message-ID: <7f8305ee-d706-a5a3-0691-1aa296a65125@linaro.org>
Date:   Thu, 18 Aug 2022 16:39:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: Convert Xilinx watchdog bindings to
 json-schema
Content-Language: en-US
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, wim@linux-watchdog.org,
        michal.simek@xilinx.com, shubhrajyoti.datta@xilinx.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        git@xilinx.com, git@amd.com, sgoud@xilinx.com,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
References: <20220818124207.61313-1-srinivas.neeli@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220818124207.61313-1-srinivas.neeli@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 15:42, Srinivas Neeli wrote:
> Convert Xilinx watchdog bindings to DT schema format using json-schema
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

Use subject perfixes matching the subsystem (git log --oneline -- ...).


> diff --git a/Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase.yaml b/Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase.yaml
> new file mode 100644
> index 000000000000..fd2e3f2df54c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase.yaml

xlnx,xps-timebase-wdt.yaml
(name should be matching compatibles)

> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/xlnx,xps-timebase.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx AXI/PLB softcore and window Watchdog Timer
> +
> +allOf:
> +  - $ref: "watchdog.yaml#"

No need for quotes. Put the allOf just above "properties".

> +
> +maintainers:
> +  - Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> +  - Srinivas Neeli <srinivas.neeli@xilinx.com>
> +
> +description:
> +  The Timebase watchdog timer(WDT) is a free-running 32 bit counter.
> +  WDT uses a dual-expiration architecture. After one expiration of
> +  the timeout interval, an interrupt is generated and the WDT state
> +  bit is set to one in the status register. If the state bit is not
> +  cleared (by writing a one to the state bit) before the next
> +  expiration of the timeout interval, a WDT reset is generated.
> +
> +properties:
> +  compatible:
> +    oneOf:

There is no other option, so no need for oneOf.

> +      - items:

You do not have items, just one item. Drop items as well.

> +          - enum:
> +              - xlnx,xps-timebase-wdt-1.01.a
> +              - xlnx,xps-timebase-wdt-1.00.a
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1

instead maxItems

> +
> +  clock-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32

No need for ref. This is a standard property.

> +    description: Frequency of clock in Hz

Would be useful to add constraints (minimum/maximum and default), but
that's not a big deal.

> +
> +  xlnx,wdt-interval:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Watchdog timeout interval
> +    minimum: 8
> +    maximum: 32
> +
> +  xlnx,wdt-enable-once:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description: If watchdog is configured as enable once,
> +                 then the watchdog cannot be disabled after
> +                 it has been enabled.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    watchdog@40100000 {
> +      compatible = "xlnx,xps-timebase-wdt-1.00.a";
> +      reg = <0x40100000 0x1000>;
> +      clock-frequency = <50000000>;
> +      clocks = <&clkc 15>;
> +      xlnx,wdt-enable-once = <0x0>;
> +      xlnx,wdt-interval = <0x1b>;
> +    } ;

No need for space after ';'



Best regards,
Krzysztof
