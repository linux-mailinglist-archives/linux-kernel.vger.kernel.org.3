Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E6A565264
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiGDKco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbiGDKcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:32:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2677B65A7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:32:41 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u14so10554943ljh.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 03:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZuC/BxsRzBHEnJgc++FT5TZHprSw0ZRP3DxQz4hVV6c=;
        b=flbdSgG6JFft7KYTaLOQHCBCILWeQswpD+m4dyx0WjwATSyrhVV4zlYj4+YkM+GgpC
         GLHSbuwcMcKOi2SyJvWbAZyrIPg2pTsNxS/UC9wTyCSutQCwAkSi/CzzOAVoGTzSgeuu
         pvO6J+dI9Z5zzw7uptFToRMShQ6MsdBJoE1bBWseQEaZeOiivSzWK5ibGLLuAbpy/5hn
         ofksX+t0Gy5eHxR7NyH/cqjg3KDGlFyeupxtQ9UHJBvr0emQpMMW13RZhgtN6xKcwOsU
         pdGNtbGKoo2RYyOA1XFwTgXOOB9zDLlRXSgEdh7WEE32YMWvbouudrMskHSW3nuLr5w7
         MPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZuC/BxsRzBHEnJgc++FT5TZHprSw0ZRP3DxQz4hVV6c=;
        b=NU24ZuenwbsMpoxpMFjrNKfuToxLbRl1yZC8elKfqEZIYOXduKYI1+/Ql1QY1PjdKA
         EXXogLdNGWsVeh90HjSvDRbngQkw4VAa9W4oClJ3HF095IrmfSNxC3InxkB4TTTZg3Hp
         cjdMkIQaI2en5J3Dw64x9+ut5/9YoqbzPdRvXt5RXDpW8f/1Vw0X7koUbWSajzvGhv1J
         QnODfTBWabxQtdFf7K/QyV69gJ3aLg/K0wmD1PmYRXDxb0xAB3JIwfB+c4QGXPpl9tsQ
         rqodB0RSiy7IGbxiLfpLXewuikuZ+gtoj1Ot+nJ1K7ahGz9T2xf2cch/i1J9R4/hX3Lt
         MCMw==
X-Gm-Message-State: AJIora/589Opye7+KdXj9pXoyaqIV07+HlbPO4Z+s4PqPY79Z8tGrOeE
        oFk9BK/uOXqm8jpLvi41Ttklew==
X-Google-Smtp-Source: AGRyM1uDs/rZNSSzDRN0iLPPWK5ZC85Ls9o9LLev5JcVqgoxbgqg7+El3prkr0jLa0DXP8wJ+nP+7g==
X-Received: by 2002:a2e:a58e:0:b0:25b:f7f2:eb45 with SMTP id m14-20020a2ea58e000000b0025bf7f2eb45mr11950056ljp.507.1656930759525;
        Mon, 04 Jul 2022 03:32:39 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id f13-20020a2eb5ad000000b0025aa51b069esm4786661ljn.5.2022.07.04.03.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 03:32:38 -0700 (PDT)
Message-ID: <6d01e993-cc0b-d7e4-b723-560d34524c2f@linaro.org>
Date:   Mon, 4 Jul 2022 12:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] dt-bindings: qcom: document preferred compatible
 naming
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
References: <20220704101823.82122-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704101823.82122-1-krzysztof.kozlowski@linaro.org>
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

On 04/07/2022 12:18, Krzysztof Kozlowski wrote:
> Compatibles can come in two formats.  Either "vendor,ip-soc" or
> "vendor,soc-ip".  Qualcomm bindings were mixing both of usages, so add a
> DT schema file documenting preferred policy and enforcing it for all new
> compatibles, except few existing patterns.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Add schema instead of readme (Rob).
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Alex Elder <elder@linaro.org>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../devicetree/bindings/arm/qcom-soc.yaml     | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom-soc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> new file mode 100644
> index 000000000000..1af1f16c13ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/qcom-soc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SoC compatibles naming convention
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description: |
> +  Guidelines for new compatibles for SoC blocks/components.
> +  When adding new compatibles in new bindings, use the format::
> +    qcom,SoC-IP
> +
> +  For example::
> +   qcom,sdm845-llcc-bwmon
> +
> +  When adding new compatibles to existing bindings, use the format in the
> +  existing binding, even if it contradicts the above.
> +
> +select:
> +  properties:
> +    compatible:
> +      pattern: "^qcom,.*(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Preferred naming style for compatibles of SoC components
> +        pattern: "^qcom,(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+.*$"

This pattern should be stricter - followed by '-':
"^qcom,(apq|ipq|mdm|msm|qcs|sa|sc|sdm|sdx|sm)[0-9]+-.*$"

and additional pattern added for a variant (or maybe few):
"^qcom,msm[0-9]+pro-.*$"

This way also compatibles like "qcom,sdm630whatever" will be caught.

Best regards,
Krzysztof
