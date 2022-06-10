Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E48546EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350541AbiFJU5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346491AbiFJU5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:57:15 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6BF38236C;
        Fri, 10 Jun 2022 13:57:14 -0700 (PDT)
Received: from g550jk.localnet (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 5D339CD36E;
        Fri, 10 Jun 2022 20:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1654894603; bh=YqnJRmEEGGGLnbon8PyU8VzAUasfE5yXwIodQh5KFrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KQTHnjZF3gH7tUgRDx8wrKjjPzD3VxMmJ+OKVe/YTpsFGZKOseyFJCYRCBXL/dNIw
         r2Eq2Z16NsF7L5l2d3PKRXViSmircruNzsrYFnOhoYJp9+5nCaaVrMFuP4zBIHKAeZ
         bMrWrw1upZG40nSoJjrpgjYZdyAZMeayD2UtNew4=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 07/14] ARM: dts: qcom: msm8974: add required ranges to OCMEM
Date:   Fri, 10 Jun 2022 22:56:43 +0200
Message-ID: <4403116.LvFx2qVVIh@g550jk>
In-Reply-To: <20220607171848.535128-7-krzysztof.kozlowski@linaro.org>
References: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org> <20220607171848.535128-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Dienstag, 7. Juni 2022 19:18:41 CEST Krzysztof Kozlowski wrote:
> The OCMEM bindings require ranges property.
> 
> Fixes: a2cc991ed634 ("ARM: dts: qcom: msm8974: add ocmem node")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

No functional regression on fairphone-fp2. Thanks!

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>
Tested-by: Luca Weiss <luca@z3ntu.xyz>

> ---
> 
> Not tested on HW. Testing might be useful.
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi
> b/arch/arm/boot/dts/qcom-msm8974.dtsi index 5e6b2ae72e62..add03309b3b4
> 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -1608,6 +1608,7 @@ sram@fdd00000 {
>  			reg = <0xfdd00000 0x2000>,
>  			      <0xfec00000 0x180000>;
>  			reg-names = "ctrl", "mem";
> +			ranges = <0 0xfec00000 0x180000>;
>  			clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>,
>  				 <&mmcc OCMEMCX_OCMEMNOC_CLK>;
>  			clock-names = "core", "iface";




