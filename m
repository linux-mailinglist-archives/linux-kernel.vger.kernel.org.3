Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE654C28BD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiBXKAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiBXKAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:00:46 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040DD14994E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:00:17 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c192so771832wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cvKgWT75YNWCz545dId4xR2Ur4aFE/XebHBrnqe+U5o=;
        b=QS46/JJpgvK0E9Hksyx9FuwMUJYpWc0wFaEzvUDevpX6J5/9e3jyF+Kc876uNdhQHr
         Wqmret9M+dr7YxkPMZy+eAYFPgczqqm98JU7kYv5gLwiyeJxj6YgXoaiWHunDJu+pMHc
         aIDn+T0cTm3Ks/tuRRIikq4ZzBHdVO0/l9Cv2czGpWun8b/7dBqlEAzqYrD24wVjEtG0
         AGfm5Xrt3cxYO3u1vFvKyJI8cRHgR0clKJ/b0Anc0Wk6TIAY8jdutUsGH4C4QofALEqY
         cJy6ReFUBlU0JpEAwEHxxCLZ/SwjXwX9CHM1n3qGpQIyEnPSCBKxgfsFPb8gGxpOJA30
         b4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cvKgWT75YNWCz545dId4xR2Ur4aFE/XebHBrnqe+U5o=;
        b=dTbvDVvMXRD8+BIvfzPt9SE7Q8TxArfc4xcQ5E5GrN6ENMg4gxZJy7WCi+6jCAwidX
         hS8d7vJUfcV0t0RryJ8rP99FZNxTgTdy9JzmnwIcpptritiAqBaS6JqcYfvaTAuhRJRm
         /WrugJnKNJXZkLbgF499EIweWT16OFqQRy0BV69Tpco5rs0wn9cfJ/mnSiSQaCp12cgQ
         ts7lv1B3pNAI+y9IOdVTSnD4lVBskY/d0tjspNS9H3k1zukeWjAM9fxELxbPzlQ9QnHW
         yY8tRW+b/3wZydm0EFU/dxk7Wb66gEHtsVdA44ROMltzLncZcEwk/elaG5ACj5OVAk+b
         4xCA==
X-Gm-Message-State: AOAM533Lnlgbryjh2HChv5J793pe94mGmz1Cl14zuInl7A9qlbfh47/S
        GnbWj3fU0AmqtOS+8eBsTLkdpw==
X-Google-Smtp-Source: ABdhPJyyzWs5ThgKjqAtBKK/Mgfo/z0KtDelHMqf0aOGE01yWxHeXoVGgtnx6lgokse5biOs1cuOAA==
X-Received: by 2002:a05:600c:692:b0:37b:c64f:a66d with SMTP id a18-20020a05600c069200b0037bc64fa66dmr11054638wmn.165.1645696815426;
        Thu, 24 Feb 2022 02:00:15 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:aa9c:55a2:dfa7:adcf? ([2a01:e34:ed2f:f020:aa9c:55a2:dfa7:adcf])
        by smtp.googlemail.com with ESMTPSA id 7sm2776349wrb.43.2022.02.24.02.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 02:00:14 -0800 (PST)
Message-ID: <e6d9f7ec-50db-75a4-03df-0d624d184ca3@linaro.org>
Date:   Thu, 24 Feb 2022 11:00:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: thermal: Update the bindings to support
 multiple sensors
Content-Language: en-US
To:     Alexandre Bailon <abailon@baylibre.com>, rafael@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org
References: <20220218084604.1669091-1-abailon@baylibre.com>
 <20220218084604.1669091-2-abailon@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220218084604.1669091-2-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alexandre,

thanks for your series

On 18/02/2022 09:46, Alexandre Bailon wrote:
> This adds two optionals properties and update the thermal-sensors
> property description to support multiple sensors with a thermal zone.


I think it would make sense to first send a patch fixing the missing 
attribute from txt -> yaml translation with the Fixes tag which was:

"A list of thermal sensor phandles and sensor specifier
   Type: list of		used while monitoring the thermal zone"

And add in the description if there are more than one sensor, then the 
max value will be returned. Then provide the code to get the max value.

The second series of changes would be the other aggregations and the 
implementation.


> ---
>   .../bindings/thermal/thermal-zones.yaml       | 30 +++++++++++++++++--
>   1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index 2d34f3ccb2572..9f944c2364589 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -77,10 +77,24 @@ patternProperties:
>   
>         thermal-sensors:
>           $ref: /schemas/types.yaml#/definitions/phandle-array
> -        maxItems: 1
>           description:
> -          The thermal sensor phandle and sensor specifier used to monitor this
> -          thermal zone.
> +          An array of thermal sensor phandle and sensor specifier used to
> +          monitor this thermal zone.
> +          If the array contains more than one sensor then the returned value
> +          is the maximum unless aggregation-min or aggregation-avg properties
> +          are set.
> +
> +      aggregation-min:
> +        type: boolean
> +        description:
> +          Return the minimum temperature when the thermal monitor multiple
> +          sensors.
> +
> +      aggregation-avg:
> +        type: boolean
> +        description:
> +          Return the average temperature when the thermal monitor multiple
> +          sensors.

Maybe 'aggregation' could be a string?

	aggregation = "max";
	aggregation = "min";
	aggregation = "avg";

It should be in the optional section and probably a conditional if 
thermal-sensors has more than one item

>         coefficients:
>           $ref: /schemas/types.yaml#/definitions/uint32-array
> @@ -338,5 +352,15 @@ examples:
>                               };
>                       };
>               };
> +
> +            /* ... */
> +
> +            soc-max-thermal {
> +                    polling-delay-passive = <250>;
> +                    polling-delay = <1000>;
> +                    thermal-sensors = <&tsens0 5>, <&tsens0 11>;
> +                    trips {};
> +                    cooling-maps {};
> +            };
>       };
>   ...


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
