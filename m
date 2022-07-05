Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8491F5667A5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiGEKSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiGEKSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:18:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A033B13F52
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:18:41 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z21so19679740lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hudqrHCKHjHnY86E2cbabmocgs4f7VaQ7Yht6ne0FPY=;
        b=qZrwpYGNFxwAtgnqKYHB3OuuvuoHrRVVEC7FiFeIXT6xzlnCaRvRptQdnBh674uozV
         kgxLmUqWZkrt3AGS13cn0RZq8DZ1ej/DCnRxsYzNRDr9FOTRGYmK9s/oQJISUjOCHEkz
         t3RhRbfpY1Xw7xbx1YTqltxLnpz3Afrgst27KGpgZGp3XDWVtpSnDuS1K4qtiPhVup4e
         Qahr+G4PEhGzGu7399bNB5nTZPcFyOlxcKa7pjJaTqHDD3IO4WQ6StJDVzQxa3KKrx+Q
         zznSflZSNji8VEtzRPioP4P5hdxScaBOazt9qxLA78VhetX0kDn/+MSEEtqonQ08O5Sd
         Zshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hudqrHCKHjHnY86E2cbabmocgs4f7VaQ7Yht6ne0FPY=;
        b=YVwDNVFS1Oh9Z4fRspCk/LhX12L0KswpLuBm8Ubdw9MhhkRy/oYNPDyS+D+K/cuP+w
         rekqlT2+AOCpaHS9e+NGC7+UfD/8e53QMv5jtPBwWPzELSEWy29kNHtTvs1mPB2ZTcpk
         lsuVBwg/xYUMdJ70Dj65Qh02qym6i9+2EkZviXZO7Cc1BQL9vu/zwVnzuY8NPpTxNko5
         LwmmsPdqgRfsGVNwxiXlH2S1TrqCh4zoqB6mgiRlOj9B4olUKZVQnTk4tinSamnb6SgA
         NDvAEQX1yDUgBj8R+r3H1ksPQufAcplh4532WyvzGzqAZhB6OiiJB7dyUpFcQA1jj2kT
         URxg==
X-Gm-Message-State: AJIora+yRky2P28HqAN8ek+eiFO55jQE0NgEHF9XaHOuhnngh9wpnYyO
        oYZTTAx+aqW1wSkfAbv/3BNpvg==
X-Google-Smtp-Source: AGRyM1uFV7Za3xwFdWCy8zr8muTdlxFxisFa4jDiP6HibmXwfHK9EEbNydOI2aOLzu9QqTL+3l8/vw==
X-Received: by 2002:a19:640e:0:b0:479:5347:b86e with SMTP id y14-20020a19640e000000b004795347b86emr21079887lfb.563.1657016320034;
        Tue, 05 Jul 2022 03:18:40 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id b15-20020a19644f000000b0048329aa6c92sm411178lfj.139.2022.07.05.03.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 03:18:39 -0700 (PDT)
Message-ID: <4bc79a1c-66b1-225d-5026-ddf3e6f7d22c@linaro.org>
Date:   Tue, 5 Jul 2022 12:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 17/43] dt-bindings: phy: qcom,qmp-pcie: add missing child
 node schema
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
 <20220705094239.17174-18-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705094239.17174-18-johan+linaro@kernel.org>
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

On 05/07/2022 11:42, Johan Hovold wrote:
> Add the missing the description of the PHY-provider child node which was
> ignored when converting to DT schema.
> 
> Also fix up the incorrect description that claimed that one child node
> per lane was required.
> 
> Fixes: ccf51c1cedfd ("dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../bindings/phy/qcom,qmp-pcie-phy.yaml       | 88 ++++++++++++++++++-
>  1 file changed, 85 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
> index ff1577f68a00..5a1ebf874559 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
> @@ -69,9 +69,37 @@ properties:
>  patternProperties:
>    "^phy@[0-9a-f]+$":
>      type: object
> -    description:
> -      Each device node of QMP PHY is required to have as many child nodes as
> -      the number of lanes the PHY has.
> +    description: Single PHY-provider child node.
> +    properties:
> +      reg:
> +        minItems: 3
> +        maxItems: 6
> +
> +      clocks:
> +        items:
> +          - description: PIPE clock
> +
> +      clock-names:
> +        items:
> +          - const: pipe0
> +
> +      "#clock-cells":
> +        const: 0
> +
> +      clock-output-names: true
> +
> +      "#phy-cells":
> +        const: 0
> +
> +    required:
> +      - reg
> +      - clocks
> +      - clock-names
> +      - "#clock-cells"
> +      - clock-output-names
> +      - "#phy-cells"
> +
> +    additionalProperties: false
>  
>  required:
>    - compatible
> @@ -180,3 +208,57 @@ allOf:
>        required:
>          - vdda-phy-supply
>          - vdda-pll-supply
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm8250-qmp-gen3x2-pcie-phy
> +              - qcom,sm8250-qmp-modem-pcie-phy
> +              - qcom,sm8450-qmp-gen4x2-pcie-phy
> +    then:
> +      patternProperties:
> +        "^phy@[0-9a-f]+$":
> +          properties:
> +            reg:
> +              items:
> +                - description: TX lane 1
> +                - description: RX lane 1
> +                - description: PCS
> +                - description: TX lane 2
> +                - description: RX lane 2
> +                - description: PCS_MISC
> +    else:
> +      patternProperties:
> +        "^phy@[0-9a-f]+$":
> +          properties:
> +            reg:
> +              minItems: 3
> +              maxItems: 4
> +              items:
> +                - description: TX
> +                - description: RX
> +                - description: PCS
> +                - description: PCS_MISC
> +      if:

Do not include if within other if. Just split the entire section to its
own if:.


> +        properties:
> +          compatible:
> +            contains:
> +              enum:
> +                - qcom,ipq6018-qmp-pcie-phy
> +                - qcom,ipq8074-qmp-pcie-phy
> +                - qcom,msm8998-qmp-pcie-phy
> +                - qcom,sdm845-qhp-pcie-phy
> +      then:
> +        patternProperties:
> +          "^phy@[0-9a-f]+$":
> +            properties:
> +              reg:
> +                maxItems: 3
> +      else:
> +        patternProperties:
> +          "^phy@[0-9a-f]+$":
> +            properties:
> +              reg:
> +                minItems: 4


Best regards,
Krzysztof
