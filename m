Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52E45AF04B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiIFQWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiIFQWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:22:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484F57F272;
        Tue,  6 Sep 2022 08:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCD6AB818C2;
        Tue,  6 Sep 2022 15:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CF4C433D6;
        Tue,  6 Sep 2022 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662479437;
        bh=BYEVXIhF2SWOS8eq8Dzey2X1NAl3O4eE3kJjbR8IIbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sljS2LC9tX5SLe3/9hcyN1L/KGbnbmGw7uj/ZY3JHLUjxVqoZNM5IB/TJ4KMTTnjL
         M63pboBjMh7lmZO8pBIcRaTgbX0KFo3pnSHyUGNM0hGBhoz3QKnp/jBkhT+QSUHv9F
         ef6TR1RSxzkAK8oMSpfCZmVgmlR4KuIQKjCBkzYDcBwXfpnWFG8qwiXiwsPl1P/Snp
         1rrgxRnzhwUBpvz+0JJxKz7vdgKtk19zhMMcX2k9DlH6RRad+IszFqImnTsBlAF6b3
         viR+PaeYnplzSFmzWz/C6bNNnXqszLXmGRY1H5dYjk7cSEnyZC7yrfBlUpBscaa80N
         7WNsuLyPANpUQ==
Date:   Tue, 6 Sep 2022 16:50:26 +0100
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
Message-ID: <YxdsQs2fWyA/34wB@google.com>
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
> 
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

Applied, thanks.

-- 
Lee Jones [李琼斯]
