Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1F25B1678
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiIHIKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiIHIKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:10:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13A272B6D;
        Thu,  8 Sep 2022 01:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E28B2B82041;
        Thu,  8 Sep 2022 08:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F11C433B5;
        Thu,  8 Sep 2022 08:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662624604;
        bh=e0bo8rZUhkvSRbH0Fk0fj81ixP7BxTIuRqWI9mJnPE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YPQ8omMvmEJCe5P9w3xzif87m/V1K6BvHvq/pH+wkY9FpCoGO8R2w19fSoYucuob3
         +qT19yuwFx/EsVEwArvx8r0DP5wMXh8+Khti+lVBzLKr77Bdetc0tqIo+8Cpz22YGp
         3CZdcj+iABGdsFeettLsKDPs6dgP9qHmMRV7yCv0KMudesq6Xogtn97hJm2csdaO0P
         VcHfBWNUK8aIW7mFN6N1JzgRUkmu4Y5wIbtk35LTxBuAyhJmKnZnxihCCMIAXI1nhp
         DNznzMwr6oEDopmOvLK4lrqnKtvC1Mz6tZd3HyiFT5IJqG1JtwYpT1VEHk5d6gtgGp
         i87MgySht6eFQ==
Date:   Thu, 8 Sep 2022 09:09:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH v2 01/14] dt-bindings: mfd: qcom,tcsr: add SC7x80,
 SDM845 and MSM8996/8
Message-ID: <YxmjV7BQ0jDHEWb4@google.com>
References: <20220817130342.568396-1-krzysztof.kozlowski@linaro.org>
 <20220817130342.568396-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220817130342.568396-2-krzysztof.kozlowski@linaro.org>
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

> Document existing (MSM8996, SC7280) and new compatibles for TCSR syscon
> registers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Correct order of compatibles.
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Doesn't apply.

-- 
Lee Jones [李琼斯]
