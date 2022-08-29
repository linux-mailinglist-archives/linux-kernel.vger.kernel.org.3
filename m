Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6545A4BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiH2MbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiH2Mac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:30:32 -0400
Received: from ixit.cz (ip-94-112-206-30.bb.vodafone.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46742B4EAA;
        Mon, 29 Aug 2022 05:14:38 -0700 (PDT)
Received: from [10.0.0.163] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 383D12007F;
        Mon, 29 Aug 2022 14:13:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1661775205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+bTG3oiKbyZ1hTkd242602K3nngKlfoNMtweqkgv9aE=;
        b=dopkX+7F9hlcUQr1FoV8Yw5dsAEx3tlQGx2niCO+wBl+R+Km1x9TnpOgt5Sb+UGgu2N6+4
        JKBbWfvLHIjI+LWGG4fgiqH4tk12lDHI2t0cQtGLlZb5ALnaURx/c5gk3ahUz2vFpuHjkR
        r2gkPq5ZMkS5ZmhxjAmgMt6ncALG464=
Message-ID: <16f31036-e4ca-a6d8-3321-f5ed8acfbab3@ixit.cz>
Date:   Mon, 29 Aug 2022 14:13:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH] dt-bindings: mfd: qcom,spmi-pmic: add missing compatibles
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220828065123.39734-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <20220828065123.39734-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for catching this!

Reviewed-by: David Heidelberg <david@ixit.cz>

On 28/08/2022 08:51, Krzysztof Kozlowski wrote:
> Conversion from TXT to DT schema lost several compatibles.
>
> Fixes: 3f5117be9584 ("dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> index 2a5bafe0660a..f4e1e64a6ea0 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -43,9 +43,11 @@ properties:
>             - qcom,pm8005
>             - qcom,pm8009
>             - qcom,pm8019
> +          - qcom,pm8028
>             - qcom,pm8110
>             - qcom,pm8150
>             - qcom,pm8150b
> +          - qcom,pm8150c
>             - qcom,pm8150l
>             - qcom,pm8226
>             - qcom,pm8350
> @@ -56,6 +58,7 @@ properties:
>             - qcom,pm8916
>             - qcom,pm8941
>             - qcom,pm8950
> +          - qcom,pm8953
>             - qcom,pm8994
>             - qcom,pm8998
>             - qcom,pma8084
> @@ -64,6 +67,7 @@ properties:
>             - qcom,pmi8962
>             - qcom,pmi8994
>             - qcom,pmi8998
> +          - qcom,pmk8002
>             - qcom,pmk8350
>             - qcom,pmm8155au
>             - qcom,pmr735a

-- 
David Heidelberg
Consultant Software Engineer

Matrix: @okias:matrix.org

