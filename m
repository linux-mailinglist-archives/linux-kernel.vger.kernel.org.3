Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0B65B1602
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiIHHu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiIHHuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D8382D36;
        Thu,  8 Sep 2022 00:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD36961B95;
        Thu,  8 Sep 2022 07:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B9DC433C1;
        Thu,  8 Sep 2022 07:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662623420;
        bh=E13i0TiCIL8rpA1HHaY2FZdKu4OVG9nhQDR6NYepAio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+Gj/hj9FTqqDAqFgWFtP3R7f+CBwA10H6qHrI+iv6BFdP433CQDczICqbE5Mmrjj
         hOaSCWhGg8nwvSgz12UOUx4xJm84WaR7b/2IR70sNFltlmBumZCwtNmWDU0N06ekrg
         Q9JsMagpDbCcctAixWMa6BPaCd5N0l1axvISp9gmWk2WK7xUHrppD+lW8URgqnxo5X
         OUEGKysCMyMRoHNJmyzfdpihog0sHqBxAayEuw/j/R6vwCUHZImfQVlVdNcWHfIvtS
         trVh8CR7VyVz9KIHUNk+ZFBfA6eb+dS+wimlJpHvkd/YdfTCocbqsl4H4vLlkNpyih
         EP2/J2nsqGTJA==
Date:   Thu, 8 Sep 2022 08:50:14 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH v2 02/17] dt-bindings: mfd: qcom,tcsr: add QCS404
Message-ID: <YxmetuNRIgDhutKv@google.com>
References: <20220817145901.865977-1-krzysztof.kozlowski@linaro.org>
 <20220817145901.865977-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220817145901.865977-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022, Krzysztof Kozlowski wrote:

> Document new QCS404 TCSR compatible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)

Merge conflict.  Please rebase.

> diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> index 5d7f4ac21a8d..87b173ad9710 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> @@ -18,6 +18,7 @@ properties:
>      items:
>        - enum:
>            - qcom,msm8998-tcsr
> +          - qcom,qcs404-tcsr
>            - qcom,sc7180-tcsr
>            - qcom,sc7280-tcsr
>            - qcom,sdm845-tcsr

-- 
Lee Jones [李琼斯]
