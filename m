Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684755A6C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiH3SkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiH3SkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:40:15 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35A21BEB6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:40:12 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id z23so9453677ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=CH2sJI+/EHW23gGx/MNS2o0Bd1ZGntsk+d3f7yO/CWc=;
        b=U3vJvHzALZt1J5DH2Gy1Bu2Ysxq9QepKsd6g4sHJTAH248qiMSJaaEamAat+U5v9RB
         w5Bur0zB4aHESKvYwayBz9te4/6pTQpMLqEg39s9tpxX4pA7QRu/RyyF2eKplXiPsekt
         kWa1TDXVaS7hlF/KAG38/NunnstiXt8AXBhWmt8m6mK2oPO6ON2dh5rX4/tyG8+OeUMr
         BRHRIr3/jFrDQIvo5k9L7m9nMtoNBOaz0Dy1b0oUPkOffEB//o02zztAox9V8GMqAFrH
         zUyfk28puaDx4/rP+kKvLNQfQt0KeUjGI82xR4MEW/xAg/ywND+L/OJAcv3/IXXUHW8T
         Msgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CH2sJI+/EHW23gGx/MNS2o0Bd1ZGntsk+d3f7yO/CWc=;
        b=6dwbXmmVEXGvgf+VL9rQvyM+cC6rpAhXcBEYpWck+FRpnAWYhtV4ixI/uCE/Ej60iO
         514Ohhi+zqxaZsI3mH7k7ClvOpUZqVfiD+9nmWRigbuewYkXZS5AbLw6/JlWGaFJVDfS
         a3R2Z25YZoOM63uBWA1H5ba8MXvRz04KGTf4OWeX6yqMRovccrviUJ1vbMSbujIpRuUp
         zH1AgdHSy3V39wG+TyZidKctHb+ZfZN61bMagPfUr8ZgPTDwn82LtljWyz8JGVXL04Il
         nYkdgyaJtLc7LKnXGzgFrt12juTOnFQ5tkwrLWUAdAPsNNWULnqFWCmqd6VorjE6v0ZS
         OrMw==
X-Gm-Message-State: ACgBeo2Y2NPH2Na+sTtm6BMvdL8maeGvQjcxVFwbhmeOr9LkHt7AkUMk
        EYAkdgaDj3YHV4D7ZLn7J2bkhw==
X-Google-Smtp-Source: AA6agR5Mj63I86ioy8izFwu1w7QEc/dz5ZGAPKJEer38bm/Y7Tral/tf+edsE1ql9U2+D9yjhw4LRg==
X-Received: by 2002:a2e:9d06:0:b0:261:d208:7475 with SMTP id t6-20020a2e9d06000000b00261d2087475mr7533564lji.113.1661884810974;
        Tue, 30 Aug 2022 11:40:10 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id du13-20020a056512298d00b0048b969ac5cdsm675736lfb.5.2022.08.30.11.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 11:40:10 -0700 (PDT)
Message-ID: <673bafdb-4e76-7dc9-6ab1-a60a44d0c238@linaro.org>
Date:   Tue, 30 Aug 2022 21:40:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 09/11] dt-bindings: PCI: qcom-ep: Define clocks per
 platform
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org
References: <20220830165817.183571-1-manivannan.sadhasivam@linaro.org>
 <20220830165817.183571-10-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830165817.183571-10-manivannan.sadhasivam@linaro.org>
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

On 30/08/2022 19:58, Manivannan Sadhasivam wrote:
> In preparation of adding the bindings for future SoCs, let's define the
> clocks per platform.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thank you for your patch. There is something to discuss/improve.

(....)

>  
>    qcom,perst-regs:
>      description: Reference to a syscon representing TCSR followed by the two
> @@ -112,6 +95,36 @@ required:
>    - reset-names
>    - power-domains
>  
> +allOf:
> +  - $ref: pci-ep.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdx55-pcie-ep
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 7

maxItems is not needed now.


Best regards,
Krzysztof
