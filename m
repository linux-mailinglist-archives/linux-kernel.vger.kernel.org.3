Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B1B559D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiFXPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 11:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiFXPXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:23:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36773192B5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 08:23:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so3506008wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iBD6lZMrnBTLHBBN9+Gb5cpKL7uxMI++sU69V4zVy+g=;
        b=Ak3dZ2Fg/xLBIIyG9LmGzCk2rkzcaNGR952atj0QzMZMbTIGExIe9Rm+vHSGhrCoCA
         UakSvLfYUy8kHTrhiADloYV88/2nSm0Fr0CqHTe0vuh8Wiq93OV+rHdFug4+1DAjyv42
         i3tNodeUujyEPioV1ionUmiWkZN1zhyuVJl4zf7cRfEy2bzRIXRpWbRKiQ2eGuNGaY6r
         V5eCkVMf4SYHntosCw9xf2PEec1QSjnIZQRMPegtlF/QodgxsgnsAUdeXuia3UhO/AET
         /Va3oF35C2TBHSxPYE+OCkfjbGcjzl8EZ2Plpml9zyV4SlZmM8RTy3ykTSlwBHHbTKzP
         7LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iBD6lZMrnBTLHBBN9+Gb5cpKL7uxMI++sU69V4zVy+g=;
        b=Tiv/g+RC2xyQzp2+4Na9QjC1lCZC4/IB2LeQ/Yr2wBCcGSz5Ot+yNA84iUtGi3OaU6
         bHmsBeLS4JK9kK/YsZzFnhxwRr1zILeJVKY0u4CRNqjxPRDhtLeJDf5bz5whZsjW3UQf
         s8hI/WyFI2tFFxA9s018p92t/I26g7yUFf0dA9DcA0Yi6XpfrKVbQ++EH3fpFxXSJVQU
         i0y47oDhy2e3WiuLN+pivNJ8GbehAgkczP1Wrm/ktUZJPrZ+VEn2psQhtHTucOAF6y+G
         Z71ABzpp0DChSG9gy1NBXAOScBc/uPr4ISsGX246OEXmCiw0tgFlXBj+HUUCqDuXD8ul
         7JUw==
X-Gm-Message-State: AJIora9A9XkhFnHbK+C9ufL8LtF8P9yZ/XwezyDf/ks3S7kQTxVTuFg9
        BsUTwEhvstqGUBIqTMsIS/Nb5Q==
X-Google-Smtp-Source: AGRyM1sr3Kjpsb3tAD/HFmc2IttIiLbrVd247d2nqDySkiBPggmJRbtunHeTvK6fNv2Hz4I6q88e0A==
X-Received: by 2002:a05:600c:2f90:b0:39e:ee0d:6419 with SMTP id t16-20020a05600c2f9000b0039eee0d6419mr4526237wmn.59.1656084192817;
        Fri, 24 Jun 2022 08:23:12 -0700 (PDT)
Received: from [192.168.0.237] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c35cf00b003a0375c4f73sm2214189wmq.44.2022.06.24.08.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 08:23:12 -0700 (PDT)
Message-ID: <a57042ec-2288-0252-84a8-7ff980ac8e9f@linaro.org>
Date:   Fri, 24 Jun 2022 17:23:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 2/3] dt-bindings: pci: QCOM sc7280 add missing clocks.
Content-Language: en-US
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1656062391-14567-1-git-send-email-quic_krichai@quicinc.com>
 <1656062391-14567-3-git-send-email-quic_krichai@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1656062391-14567-3-git-send-email-quic_krichai@quicinc.com>
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

On 24/06/2022 11:19, Krishna chaitanya chundru wrote:
> Add missing clocks.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 0b69b12..313b981 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -438,6 +438,8 @@ allOf:
>              - const: slave_q2a # Slave Q2A clock
>              - const: tbu # PCIe TBU clock
>              - const: ddrss_sf_tbu # PCIe SF TBU clock
> +            - const: aggre0 # Aggre NoC PCIE CENTER SF AXI clock
> +            - const: aggre1 # Aggre NoC PCIe1 AXI clock

Hi,

This won't work. You need to update other entry. If you test it with
`make dtbs_check` you will see the errors.

Best regards,
Krzysztof
