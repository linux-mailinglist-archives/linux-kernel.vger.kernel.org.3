Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A67A4C0C71
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbiBWGM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiBWGM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:12:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A1606E5;
        Tue, 22 Feb 2022 22:11:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A08B61372;
        Wed, 23 Feb 2022 06:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52AEC340E7;
        Wed, 23 Feb 2022 06:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645596718;
        bh=Zzp79czQ3FQU8Aa3rLV91ozFlYAoZO237NxSGoIc2KM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJYkAMFGNzU0dC8I/5eWGEjC7KNcue/AbTZy0tg/Ui7zJMnogyeYmokKFtmrD68hc
         KXJ2cbWw2MuxxW4LgT4Fk6I6bMDOMAi7E4RHYX+aN1EAfx3Qe/+2qJ8KYMqnX0u7TY
         w6wMasYjGj5N62cMKKotdTy3q+0L68ZPNtuSOLuFQ/ubuGldJiw69x5/XkxPmBv5Vz
         V+crRvn/TsrEMsoP5mnlN0HGfHPcSikh6y1Tj6bSxqBNQrZapqt84r7hVrRMj1uQO5
         En0hLVKHuiEMHAzkprlwAjJHX5Jrs2ramR2L9FpbKCzd23y5o7i9ToMc2Mcjc2y5p/
         3S9uYSIctIQ5g==
Date:   Wed, 23 Feb 2022 11:41:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom,qmp: add sc8180x and sc8280xp
 ufs compatibles
Message-ID: <YhXQKiVIa0eOhMFR@matsya>
References: <20220223044213.3776600-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223044213.3776600-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-22, 20:42, Bjorn Andersson wrote:
> Add compatible for the UFS PHY found in the Qualcomm SC8280XP platform
> and document the required clocks for this and the SC8180X UFS PHY.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index e417cd667997..455317dee5ea 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -32,6 +32,7 @@ properties:
>        - qcom,sc8180x-qmp-pcie-phy
>        - qcom,sc8180x-qmp-ufs-phy
>        - qcom,sc8180x-qmp-usb3-phy
> +      - qcom,sc8280xp-qmp-ufs-phy
>        - qcom,sdm845-qhp-pcie-phy
>        - qcom,sdm845-qmp-pcie-phy
>        - qcom,sdm845-qmp-ufs-phy
> @@ -280,6 +281,8 @@ allOf:
>                - qcom,sdm845-qmp-ufs-phy
>                - qcom,sm8150-qmp-ufs-phy
>                - qcom,sm8250-qmp-ufs-phy
> +	      - qcom,sc8180x-qmp-ufs-phy
> +	      - qcom,sc8280xp-qmp-ufs-phy

The indent does not seem to match here

-- 
~Vinod
