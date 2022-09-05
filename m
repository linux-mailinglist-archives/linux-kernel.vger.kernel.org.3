Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1275A5AD5FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbiIEPPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbiIEPPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:15:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840AF140CA;
        Mon,  5 Sep 2022 08:15:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19AF5612D7;
        Mon,  5 Sep 2022 15:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5688EC433D7;
        Mon,  5 Sep 2022 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662390923;
        bh=H/TZpaSNH/3isRci5sv0IwXAXjpsEvaJ6CH6e8EAzc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j7W+EhG75b+6wClcVNFMUb0Mwwn9LSUDGvgO7qKtBqYvlPj04GnwSMZdY0yqJCeNI
         p7iyGgnw5MVrE55DGMpeTguVNv9+KU80dHHOxA7OHp/yvNhCDXVvEQpYXBITXTdINa
         IfISzIj1ddgVuB8nUbV2/kveHZBAG9X7urAI0GdqPvaWe8m1vxYfNJ/9jfMydBSUKG
         Qbanv2Sk2o1Mtyat4ooRIvi+18bq73Q8E0cTcRn8nitLwJQQDwWa2MObN7Tgx+W5L6
         /bAO0prXeJ4vB4/FZ3DuQWD2Yf1CB9UGPiUgZYz7k91hqRHjXG2xUOzlxZLjsGNPv7
         4CvJfst2JEDhw==
Date:   Mon, 5 Sep 2022 16:15:09 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH v3 01/16] dt-bindings: mfd: qcom,tcsr: add several
 devices
Message-ID: <YxYSfbpINDvDffGQ@google.com>
References: <20220819083209.50844-1-krzysztof.kozlowski@linaro.org>
 <20220819083209.50844-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220819083209.50844-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022, Krzysztof Kozlowski wrote:

> Document existing (MSM8996, SC7280) and new compatibles for TCSR syscon
> registers (QCS404, SC7180, SDM630, SDM845, SM8150, MSM8998).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

What does RFT mean?

> ---
> 
> Changes since v2:
> 1. Add more compatibles.
> 
> Changes since v1:
> 1. Correct order of compatibles.
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> index 2f816fd0c9ec..d3c25daa995e 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> @@ -18,6 +18,13 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> +              - qcom,msm8998-tcsr
> +              - qcom,qcs404-tcsr
> +              - qcom,sc7180-tcsr
> +              - qcom,sc7280-tcsr
> +              - qcom,sdm630-tcsr
> +              - qcom,sdm845-tcsr
> +              - qcom,sm8150-tcsr
>                - qcom,tcsr-apq8064
>                - qcom,tcsr-apq8084
>                - qcom,tcsr-ipq8064
> @@ -27,6 +34,7 @@ properties:
>                - qcom,tcsr-msm8953
>                - qcom,tcsr-msm8960
>                - qcom,tcsr-msm8974
> +              - qcom,tcsr-msm8996
>            - const: syscon
>        - items:
>            - const: qcom,tcsr-ipq6018

-- 
Lee Jones [李琼斯]
