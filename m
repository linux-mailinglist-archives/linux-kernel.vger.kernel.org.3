Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597785B1B02
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIHLN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIHLNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:13:20 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED72EDFF40
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:13:16 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c10so9978799ljj.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 04:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=vReDt8yJoofW75TqPCK861NZU37LZm5B+5UoGHmyr4g=;
        b=fkvsTa9O0LX4Dm+3T/VX/F7rPoLPQTF5CuDwqd6YAjxeDf0pbsAH4TSr4MRJIbUiMy
         2BExz/DG7E087WStoAiGWcqYskhwHa1gkLnXjk3DP4C/dE4cbYTMEBdUSuoi4Vq8x6HY
         L5BgBMF9Hw92mMUMl6YSfzCGPFBSsQPJ/0Vw8BPt0WmSoJsFfiwe7l2x12MiG8r1HP1e
         X7uAzaXSF7mxLmBXrluMgmJSPfiv30DUlNCOjpqIRqoo5ePHvoi32/qWXMfRAbMIrnmP
         Z3NkVcyvXMYAvv9v1V6sItdJtXMprjh5uL2ByKMHhR5prt5yIiJrcWAcpy3K5v+dov9x
         ZMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vReDt8yJoofW75TqPCK861NZU37LZm5B+5UoGHmyr4g=;
        b=3MFXF4Pa+rSKHpR1jcI8Rx0obm0UqtM2vkzkJoVgsTIi6rjfackYpNgsLldIQp57tl
         Vg30lF1v86UBbtxgOnFTOmZQjcti7eJhEqPkwK0/PN2swKraxZJqx8TSMZSC22Q571Fj
         qdSdTNnitn+RzIkTOsYkczGrVsMChfW/v822VHDo26PVTaWtOD5JBY+jz9KkrIt+NR3m
         7wButwWwrnPQpoyYuczsiSJegOWw4J57chGEBORm80FVQAOQz2g5kSTgtfig0xLd0PpD
         4WkgKfdlExANM8rXHOZNrzVD4+vPR3NOm1z5FnZ0rtH7ZRnvtRNYyAzSiIGFiYuJH6iy
         yGSQ==
X-Gm-Message-State: ACgBeo1+3g20p3mYn/M4cbRWYn4eq2bcTEEJWVMyLvoBmgU8yQXrsKws
        lHAZoIB+fysC0PiZLQRREZmzaw==
X-Google-Smtp-Source: AA6agR4JeCyW9VC1eBsiZRcqPlxlTw0tPz8/qgiwtefT6Tt8bH/qCp4SvFpRtmwO09qh/tCLow0SGg==
X-Received: by 2002:a2e:9447:0:b0:261:e71e:e3d with SMTP id o7-20020a2e9447000000b00261e71e0e3dmr2318222ljh.227.1662635595364;
        Thu, 08 Sep 2022 04:13:15 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w12-20020a05651234cc00b00489d1896c06sm2981545lfr.125.2022.09.08.04.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 04:13:14 -0700 (PDT)
Message-ID: <70f262d5-8d78-1c9a-2491-106af668f81a@linaro.org>
Date:   Thu, 8 Sep 2022 13:13:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 4/4] dt-bindings: qcom-pmic-gpio: Add PM7250B and PM8450
 bindings
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220907201528.9351-1-quic_amelende@quicinc.com>
 <20220907201528.9351-5-quic_amelende@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907201528.9351-5-quic_amelende@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 22:15, Anjelique Melendez wrote:
> Update the Qualcomm Technologies, Inc. PMIC GPIO binding documentation
> to include compatible strings for PM7250B and PM8450 PMICs.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> index 694898f382be..a548323e54f1 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> @@ -24,6 +24,7 @@ properties:
>            - qcom,pm6150-gpio
>            - qcom,pm6150l-gpio
>            - qcom,pm6350-gpio
> +          - qcom,pm7250b-gpio
>            - qcom,pm7325-gpio
>            - qcom,pm8005-gpio
>            - qcom,pm8008-gpio

This is incomplete. You need to update allOf.

Best regards,
Krzysztof
