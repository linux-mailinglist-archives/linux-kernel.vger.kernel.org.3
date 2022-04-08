Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4523A4F8F59
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiDHHTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiDHHTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:19:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0460021DF22
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:17:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r13so15518586ejd.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 00:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0n61blmIAkKQaBF3fgsPecQx9lDeya+dROG3fR+36zM=;
        b=rDO9wCF+y70cv/4I1pJUnF98waE70HN2mn7xOtAJ9/6tJr21SWhOZql1eQ2iIIAceV
         SouBBS6HQQvDLfzFgnyLqOzIVFl74VSfOqOqLJcXsV/b5g3OJxI6OSGuxKFVvxboDHuU
         dfcG7kxNFAm5pcNpnO+IOiXjDVjG73fGtM9xmBqIFuuPVrhbHvI7AQm8L0ota6qOyL3x
         /3tWERQE7Ufrx//4MJWfnvyL49HaAS3AHb9RPVKBBLG8uBkomK6Ky0gFcm8h8w6I6CK4
         l+cO5AMMgSgJhqe8hB6QpRdhcHJ/zsDOfoSawHbFzY8fLYM2K/+TyRlRhoTe6sVTxkYB
         Gg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0n61blmIAkKQaBF3fgsPecQx9lDeya+dROG3fR+36zM=;
        b=k0UBZmeCI9dXnZQVTEVkRiHrJJHuq0ZeQ+l+z9K4JsqpKtUqQRID2uSUh0JjbShmPx
         7/DAb2GlfXXq4ujS9HnT+T9tQNr0BR8Byxh4miiixiaAyUVdM1rQs+d9GjBNGZdzS0IX
         oXTm5t+mgzaZovEzWIJgiORU40KUAly6JJcXphSWDFZ8FYB85Q06m6/GWdoMxb2ulMTp
         FKPb4avyubGLosSvnQ2fpBLRlHTmEH9lA6zeAYdXRdEIz68M3z56IPy0kq9mURFp1Ips
         HMAVn6P3NhE+1cB7DmzSePzvbeTxtZdsYhFU0KOlHgD+ddFLC0+WDs3R0DzBJXmyZ/lF
         2czw==
X-Gm-Message-State: AOAM530umyyHRIqbGqqhwWcOdj0VRZ2DtAVZrgyhhLEZ9R4gsDcMRBj/
        cezTI1coz5+I037RlTKA7fQrRg==
X-Google-Smtp-Source: ABdhPJxnIy7zF7uE8xRHZ/boIh9E4X89WLB9SMQMnABLEB9K24hPdos6iUbx2cmBnQl1AWhRIsKFYA==
X-Received: by 2002:a17:906:434e:b0:6d0:ed9c:68bc with SMTP id z14-20020a170906434e00b006d0ed9c68bcmr16390976ejm.70.1649402262518;
        Fri, 08 Apr 2022 00:17:42 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bl24-20020a170906c25800b006e809b6bf89sm3720393ejb.221.2022.04.08.00.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 00:17:42 -0700 (PDT)
Message-ID: <9d6ba801-6ad1-80aa-a92a-bfc06c1cf1df@linaro.org>
Date:   Fri, 8 Apr 2022 09:17:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/4] clocksource/drivers/exynos_mct: Support frc-shared
 property
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20220407074432.424578-1-vincent.whitchurch@axis.com>
 <20220407074432.424578-3-vincent.whitchurch@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407074432.424578-3-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 09:44, Vincent Whitchurch wrote:
> When the FRC is shared with another main processor, the other processor
> is assumed to have started it and this processor should not write to the
> global registers.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> 
> Notes:
>     v3:
>     - Split FRC sharing handling from local timer indices handling
>     - Remove addition of global variable.
> 
>  drivers/clocksource/exynos_mct.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 

Looks correct and I hope it works correct. :) I did not test it though.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
