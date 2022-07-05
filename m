Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8CB566783
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiGEKN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGEKN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:13:26 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9462C8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:13:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z21so19659213lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/c35IP8fT9ZTu8bx278sy5MOBFHS+lNYsk/NFdibXS0=;
        b=VRUEgCC90iVnU85xU+RHG/DIde70XjpkA5/TrUXjl6G+LF/BF93AqwJbYN4UTsmiSg
         ZKwoSSubuK5psSk9PwQEwu/gvwmuvxD4JKv+MrMPwkclKYTWK+4bQ4twHvLdU0s+LUi+
         498PUU+gugxVzUdLER/Ft60zv9ChROOE+IOV2YgMlp8eiB/w/69X6kzRdmvPoXp3hdmN
         OUCurpOtcG6tVLGmHEQ1VWlPBoKmVSieQs/kYBeyzy9tbsP9x5Fp6QlcK7CgCUbez243
         plmfL1oa1YytHlkMkW+sOaQGI9XqymTbN9b/JXR4kBz4b7XEU+kvCsLvPXtSaJF0hHJ7
         nuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/c35IP8fT9ZTu8bx278sy5MOBFHS+lNYsk/NFdibXS0=;
        b=QIhl18lS2Y8vSvvsKsePMHjalGBsDuh9t6BJvz00b5XeWPxylLjVzw8L/sjRpfUsqj
         hGxStgHUJh0rE+G1Ws/SQKAHzm0+W7MA824by9P0WoguhX4TWP+GljThME9mw/BCPtAB
         WNLTkp8ZCze4N2ldqZChToi4jZKhaBmdv1L6uIkTeisxZ/bNrya6+iO/Lwj0HFTZ1b2x
         kq94rku9qGjkjcOhoXj6idOWJZZxswtlmvNt2m7y6hgkSwTx56ocz8y2GYBdrpaicaJI
         sy5DzFc0SbrPi2lj4ofdzhz8bp++GgVkBDybZhBFbwE3oLJEjgMhcKRvaTkgTt0Eyf5V
         lO/A==
X-Gm-Message-State: AJIora9HaVZrs1bXN9Mp5Ju5cgCEumZeFwdo7qkKlxWpop+aavCC/gdA
        X3y8FraS8MDcRkJLb0da4Krleg==
X-Google-Smtp-Source: AGRyM1vnKC4Ilv2ZbR68+xe7F6V4OEip7c6vXCKFCLuc1QNyaaJeIbUmjLXrzEe384x81w08hJ181g==
X-Received: by 2002:a05:6512:2622:b0:481:5b17:58e7 with SMTP id bt34-20020a056512262200b004815b1758e7mr14581404lfb.600.1657016003330;
        Tue, 05 Jul 2022 03:13:23 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id f13-20020a2eb5ad000000b0025aa51b069esm5341723ljn.5.2022.07.05.03.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:13:22 -0700 (PDT)
Message-ID: <69207215-f53d-c5b9-9cc9-214e2e3723f4@linaro.org>
Date:   Tue, 5 Jul 2022 12:13:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 12/43] dt-bindings: phy: qcom,qmp: split out PCIe PHY
 binding
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-13-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705094239.17174-13-johan+linaro@kernel.org>
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

On 05/07/2022 11:42, Johan Hovold wrote:
> The QMP PHY DT schema is getting unwieldy. Break out the PCIe PHY
> binding in a separate file.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../bindings/phy/qcom,qmp-pcie-phy.yaml       | 188 ++++++++++++++++++
>  .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  75 -------
>  2 files changed, 188 insertions(+), 75 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
> new file mode 100644
> index 000000000000..d1d4a468acc3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
> @@ -0,0 +1,188 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +

No new line.

> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/qcom,qmp-pcie-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes.

> +
> +title: Qualcomm QMP PHY controller (PCIe)
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +description:
> +  QMP PHY controller supports physical layer functionality for a number of
> +  controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq6018-qmp-pcie-phy
> +      - qcom,ipq8074-qmp-pcie-phy
> +      - qcom,msm8998-qmp-pcie-phy
> +      - qcom,sc8180x-qmp-pcie-phy
> +      - qcom,sdm845-qhp-pcie-phy
> +      - qcom,sdm845-qmp-pcie-phy
> +      - qcom,sdx55-qmp-pcie-phy
> +      - qcom,sm8250-qmp-gen3x1-pcie-phy
> +      - qcom,sm8250-qmp-gen3x2-pcie-phy
> +      - qcom,sm8250-qmp-modem-pcie-phy
> +      - qcom,sm8450-qmp-gen3x1-pcie-phy
> +      - qcom,sm8450-qmp-gen4x2-pcie-phy
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: Address and length of PHY's common serdes block.
> +      - description: Address and length of PHY's DP_COM control block.

All my msm8996-qmp-pcie comments apply.


Best regards,
Krzysztof
