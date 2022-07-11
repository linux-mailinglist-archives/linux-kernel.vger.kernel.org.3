Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A588E570000
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiGKLRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiGKLQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:16:27 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A32D6422
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:38:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bf9so7937823lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NQoLzRBeO+sL0DWQtHTbM5QZDiRRY6R4q4RQs20xXvA=;
        b=VuG4aVjx+zQiHH6/kPNj8R2eOimlBGti8XEdbUYQ2Vzl8PAd+e6IKmdsu/22AD/P9J
         GBLC8aPdQl4arslGU3tOOFwPWIDP2UMS/J8MIRBRf4cndEtQQkmEmPGM7T0hqSHMpkrF
         tAtnCKNGdc6oKwIdwA36bJn4wyo5/LkekRWOLymdOn1fWMrn2XtvywH5xvHp1TrP/avW
         iX6YLCwq8rCRB9v8xv2rY6x8nhXIQGklitoDpL3NYTrSeVbbkvGJDJJoKWomVVeE5Mvl
         AiUG7/szAUZVaOF6hGneN2SDoMLOqoB9Dx+8uw4kNZge2pcZ2lc5Knd6JVVSpI+bj4Yy
         +aFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NQoLzRBeO+sL0DWQtHTbM5QZDiRRY6R4q4RQs20xXvA=;
        b=wANZdxvbC80sv/nybp2y5oJ8jumtHORVxvPv++2/mRKZhnHjnwV+21+C1i+2JRQDJM
         1K5Jvmtuk1jqsA7O15ZGoRZrFStU9KE320WsbsYOj/QbNvWQ4+8HQsHl3TTGbLWPACHQ
         DHmQbtd5vUTj0xP9+Vqzv5Gq0DL2tp+qUSoZy8cru9FgiXCL0fvI4GW1nt1tHcGLZKM0
         QgamTzvqKvSafhjvPZ2g94G0hSvQQIl0IrdBMEG5uSBpOF27DW0O7ggGMQYGOI6xTKtY
         oqDLwR4wk/TA6JzSZoOBal9+w47sj46WfI3f1bIpN+GsaF8nx7UZnfgC+zeiJb0iNW6q
         Ut6A==
X-Gm-Message-State: AJIora+k6k/w0/7WRSjRU608hnBef68ZOykMizSf4/Om1d3lQKijTZKV
        TWY72i0rGyNzZTKBkglEbssnCw==
X-Google-Smtp-Source: AGRyM1tquCCB6Z0O+3aVgYSykP26Ez+/mnUfsPpGejuwSkfD9boKKoCZ6uAeHfwKQYC2bBpSQDcrLQ==
X-Received: by 2002:a05:6512:1151:b0:481:1675:f343 with SMTP id m17-20020a056512115100b004811675f343mr10988046lfg.280.1657535911823;
        Mon, 11 Jul 2022 03:38:31 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id p13-20020a2e804d000000b0025a885a135csm1665054ljg.119.2022.07.11.03.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 03:38:31 -0700 (PDT)
Message-ID: <c68e4ae9-c435-c74e-91cd-b153be6de92f@linaro.org>
Date:   Mon, 11 Jul 2022 12:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/3] dt-binding: power: power-domain: add
 power-supply-needs-irq
Content-Language: en-US
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, rafael@kernel.org,
        khilman@kernel.org, ulf.hansson@linaro.org, robh@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220711094549.3445566-1-martin.kepplinger@puri.sm>
 <20220711094549.3445566-2-martin.kepplinger@puri.sm>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711094549.3445566-2-martin.kepplinger@puri.sm>
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

On 11/07/2022 11:45, Martin Kepplinger wrote:
> Add the power-supply-needs-irq board description property for power domains.

Where is a board description here? I think you just meant
"power-supply-needs-irq property"?
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  .../devicetree/bindings/power/power-domain.yaml        | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
> index 889091b9814f..e82c2f7ccb97 100644
> --- a/Documentation/devicetree/bindings/power/power-domain.yaml
> +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
> @@ -70,6 +70,16 @@ properties:
>        by the given provider should be subdomains of the domain specified
>        by this binding.
>  
> +  power-supply: true

This is a new property not described in the commit msg.

> +
> +  power-supply-needs-irq:
> +    type: boolean
> +    description:
> +      A power-supply can link for example to a regulator controlled via
> +      i2c or otherwise needing interrupts enabled to be able to enable and
> +      disable. 

Not really a property of power domain. How the regulator supply works is
entirely up to regulator. Otherwise such property should appear for
every device.

> This property makes various callbacks usually run in the
> +      noirq phase, being run when interrupts are available.

Last sentence does not fit - you embed Linux implementation into DT
bindings. noirq phase is Linux specific.

> +
>  required:
>    - "#power-domain-cells"
>  


Best regards,
Krzysztof
