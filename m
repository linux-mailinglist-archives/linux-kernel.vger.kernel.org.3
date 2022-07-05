Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD5356764D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiGESVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiGESV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:21:28 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FBB140BB;
        Tue,  5 Jul 2022 11:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657045281;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=UQh/AeOwYOytT9lqqjisAb47n38WBxn//wzctNCCTb8=;
    b=F3fNQ79by2v5AKFvK+zRv9SKkf0apyfCvsx+N92TJvadUYg7J0WihSKHGF9SiaL8kU
    DyAksPcDRyWyDkk8ZcZcygD38a76rQLfJHWhmY2OgOT7F55LQFy7uRMWOS13gM5P0Rak
    BTvLhejkSg8OjDfw8eAE5cRgSKreJcAzixCwZmbf/mrryMy0/iGgk/O6DnODBp3Sl3ew
    9l3T5ujxr+/3DzoYJxNsjI3Fw5P2y5p8Suc/6ug/kiUcCsAoVHRKEmRN6hdjsg5OyonK
    YMKOTP6fWL4uaywR4oL1Vo95Q71c+QPrpNplngB1uVeVGIAAJVHMkWDJcncjw8lQFqlw
    Isrw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrK85/aY="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.46.1 AUTH)
    with ESMTPSA id yfdd30y65ILKJAG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 5 Jul 2022 20:21:20 +0200 (CEST)
Date:   Tue, 5 Jul 2022 20:21:10 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: qcom,sm8250: add SDM845 sound
Message-ID: <YsSBFjW6riKOZZcz@gerhold.net>
References: <20220705174702.763247-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705174702.763247-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 07:47:02PM +0200, Krzysztof Kozlowski wrote:
> The Qualcomm SDM845 sound card bindings are almost the same as SM8250,
> except "pin-switches" and "widgets" properties.  These were not
> documented in SDM845 text bindings but are actually valid for SDM845.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Integrate into SM8250 instead of creating new file (Stephan).
> 
> Cc: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../devicetree/bindings/sound/qcom,sdm845.txt | 91 -------------------
>  .../bindings/sound/qcom,sm8250.yaml           |  1 +
>  2 files changed, 1 insertion(+), 91 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> deleted file mode 100644
> index de4c604641da..000000000000
> --- a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> +++ /dev/null
> @@ -1,91 +0,0 @@
[...]
> -- compatible:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: must be one of this
> -			"qcom,sdm845-sndcard"
> -			"qcom,db845c-sndcard"
> -			"lenovo,yoga-c630-sndcard"
[...]
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> index 4ecd4080bb96..7cdf9e9f4dd3 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> @@ -18,6 +18,7 @@ properties:
>      enum:
>        - qcom,apq8016-sbc-sndcard
>        - qcom,msm8916-qdsp6-sndcard
> +      - qcom,sdm845-sndcard
>        - qcom,sm8250-sndcard
>        - qcom,qrb5165-rb5-sndcard
>  

Looks like you forgot the db845c and lenovo compatible? :)

If you add them feel free to add my:
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

Thanks!
Stephan
