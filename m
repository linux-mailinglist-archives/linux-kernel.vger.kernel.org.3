Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7DD58F9D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiHKJO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiHKJOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:14:54 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD836F572
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:14:52 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id by6so10279765ljb.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 02:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=x/juwjFOen7SY3rsLYVEyabUqshA+qt0zfFneaC0GRA=;
        b=dz5bka5rUvh+bE/CeY6FGW0uamMGutpYu7OO9ebKmuw+NOHzxRhUFFiywzjI7ae8sy
         vLI6iLFWrat+scT+P5kp5X1S1nePbTgOx9VsdiI2+/VNlDDRMxwA7ks+LMXoHkq1iVj2
         lRPqTebh6xOwM6cUqWUnbsIm1y/8CAtarKPApRDUMh/yzlDEvZ7+NK09wMmYMXYrDLFI
         ND/c4ObJrwyME4Za4W5yl/2Bny7HZbnZX/DgKmFP4zxChT+4POpmGwAd+7b65NQuYOzO
         9YEUWuhp6z+TLX85p0K9+HcvUxlN/q883ll7B3pCj7sSkMQxGQg9zaZ/WMRRMiOHbn7G
         GcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=x/juwjFOen7SY3rsLYVEyabUqshA+qt0zfFneaC0GRA=;
        b=yHIh1AXx+zl/lIeyQhZaCe2Ctyq/6XWc13EQJcu9XcrN2fqC8duIiIXOp27Dp/SueZ
         1f7IVZB7jvp5U/ltNVY6+lWhZrxehytzPw+zTuxgKJ6dRi4PFEUsX70hF/RptvLOJdy2
         8ZteC3/QcJkADIISU3SA7oo9yesgDmDiB4fVj1PFzpIaRXAVGLcRQ3JlAewhkTYGEvCC
         +8g782O16vtfPfquTge3tAk4yavgHep/y3F/Xs1Gks8eJwQXyE7jh+veH+I03togV5Yw
         yNR9jmhRtD5vqTj8w7chSmdUcYYMtH6aT4bUwljN1+F+GViln+GKrDrkkNe2yyxHnSuh
         COrA==
X-Gm-Message-State: ACgBeo2L97jMiBZcYepEuwuNWNg7nMaIDD8Abcb/Wwihg7v/Gl+t/Mle
        /pk4qQpVPv+DmZgVbmHoREU7uw==
X-Google-Smtp-Source: AA6agR6f0GgJG+ALZKrq5SEXqOK11Zl4ZhmWQX25EncUdFLsuHlJxb684szwZrRGv1QdrOHwDwBPyw==
X-Received: by 2002:a2e:8415:0:b0:260:550e:59be with SMTP id z21-20020a2e8415000000b00260550e59bemr1211595ljg.181.1660209290688;
        Thu, 11 Aug 2022 02:14:50 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id c25-20020a056512239900b0048a97042251sm643030lfv.22.2022.08.11.02.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 02:14:50 -0700 (PDT)
Message-ID: <a13bce60-25b4-d075-d56a-d1283e91e3ba@linaro.org>
Date:   Thu, 11 Aug 2022 12:14:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: usb: Introduce GPIO-based SBU mux
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>
References: <20220810204750.3672362-1-bjorn.andersson@linaro.org>
 <20220810204750.3672362-2-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220810204750.3672362-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2022 23:47, Bjorn Andersson wrote:
> Introduce a binding for GPIO-based mux hardware used for connecting,
> disconnecting and switching orientation of the SBU lines in USB Type-C
> applications.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../devicetree/bindings/usb/gpio-sbu-mux.yaml | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> new file mode 100644
> index 000000000000..7d8aca40c7ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/gpio-sbu-mux.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: GPIO-based SBU mux
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description:
> +  In USB Type-C applications the SBU lines needs to be connected, disconnected
> +  and swapped depending on the altmode and orientation. This binding describes
> +  a family of hardware which perform this based on GPIO controls.

+Cc few folks.

This looks familiar to:

https://lore.kernel.org/linux-devicetree/eaf2fda8-0cd6-b518-10cb-4e21b5f8c909@linaro.org/T/#m39254b7f8970b3e1264f9d1a979557bb46ab162c

Rob and Stephen had several concerns about that approach.

Best regards,
Krzysztof
