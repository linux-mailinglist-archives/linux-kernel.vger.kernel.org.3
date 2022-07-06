Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F7A568727
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiGFLq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiGFLqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:46:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E2328E1B;
        Wed,  6 Jul 2022 04:45:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 499B261EEF;
        Wed,  6 Jul 2022 11:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51827C3411C;
        Wed,  6 Jul 2022 11:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657107943;
        bh=aBdtVMhRidxJCeoJx5DEXlpzuQlURSLwQpWLFBNxTts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMVJJ+JukHbibk6ztwsiqZjPY7NNGnu5ye/kkkr65U8rnR50ws1YnUZgNFk5+4LZc
         qrbPtRrZznfI6mp0+7/SBCTIuK0aG3D3ThJ7VLx2nNaiiNl9OpsfDK46GwzWVI7h2s
         5Ddwh1l7nAR/g30vK7bn6t3ky+UZJFIeAD7s8RkA/GT1UGOlPd+fv2yaHwJZYA+LeP
         oGdC0e0RO7pFN3Q/dmlVtqZVcVLeIuY7H1u1dOPKEtzBve5qL1g19QKv7seksr02zn
         lbmy3N4magjeo+Y2st5Z7HoMGPOHMilLgnLHgoDR52kgWGTLrcjbXaeFhwRj7HJn5l
         E+rKgbU5XqcVA==
Date:   Wed, 6 Jul 2022 12:45:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: qcom-iommu: Add Qualcomm MSM8953
 compatible
Message-ID: <20220706114536.GA2403@willie-the-truck>
References: <20220612092218.424809-1-luca@z3ntu.xyz>
 <20220612092218.424809-2-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612092218.424809-2-luca@z3ntu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 11:22:13AM +0200, Luca Weiss wrote:
> Document the compatible used for IOMMU on the msm8953 SoC.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes from v1:
> - new patch
> 
>  Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> index 059139abce35..e6cecfd360eb 100644
> --- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> @@ -10,6 +10,7 @@ to non-secure vs secure interrupt line.
>  - compatible       : Should be one of:
>  
>                          "qcom,msm8916-iommu"
> +                        "qcom,msm8953-iommu"

I'm assuming Andy or Bjorn will pick this up.

Will
