Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0DA5AC60E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 21:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiIDTWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 15:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDTWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:22:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6B52E6B5;
        Sun,  4 Sep 2022 12:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E747461005;
        Sun,  4 Sep 2022 19:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE2BC433D6;
        Sun,  4 Sep 2022 19:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662319363;
        bh=Z/GrSeV4qU3RYHIyax+8B1wkXyHLAQI0ORF1GpohqO4=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=RsqekDoBS9vKHg6XNiMJr7aR4SA+Yd4AH2zMp8w+40Ga6Vmbb3+6XOBj8b3gD9jrw
         0tqaD/eHFJAZ/C8h3Zib5eiSXIf01/R+fSTjtiMqTQJWFDoTV4CLa8UvAufwb0u5CL
         S0SZVHtFQ9eTP4okAe7SQ3h+R0z55bzsK5W+uMwt0sWf/d2EtZRP7wC6d+4HlzIiT9
         +dCUdoRTLLt8KwHf1UIi3cdPyMbByAXKMlKWgENuhjCti2RdARRijlkm74O87e5Tx1
         UQP2mxpESOqJf7ou3BUJb+wK3poyyYt1UeBi0GCnQDTro8paiBAVDO0DflhK/oYp5w
         8gdyGbf4VemdQ==
Message-ID: <42790a40-458a-55ff-7e4b-796e72f474ac@kernel.org>
Date:   Sun, 4 Sep 2022 22:22:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: Remove reg entry for
 pmc8280c_lpg node
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, agross@kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20220903084440.1509562-1-bhupesh.sharma@linaro.org>
Content-Language: en-US
In-Reply-To: <20220903084440.1509562-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2022 11:44, Bhupesh Sharma wrote:
> Commit eeca7d46217c ("arm64: dts: qcom: pm8350c: Drop PWM reg declaration")
> dropped PWM reg declaration for pm8350c pwm(s), but there is a leftover
> 'reg' entry inside the lpg/pwm node in sc8280xp dts file. Remove the same.
> 
> While at it, also remove the unused unit address in the node
> label.
> 
> Fixes: eeca7d46217c ("arm64: dts: qcom: pm8350c: Drop PWM reg declaration")
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> index ae90b97aecb8..2e5cf55afdd5 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> @@ -60,9 +60,8 @@ pmc8280c_gpios: gpio@8800 {
>  			#interrupt-cells = <2>;
>  		};
>  
> -		pmc8280c_lpg: lpg@e800 {
> +		pmc8280c_lpg: lpg {

I wonder why I did not see the errors when testing all DTSes for
https://lore.kernel.org/all/20220828084341.112146-9-krzysztof.kozlowski@linaro.org/

Anyway, it cannot be lpg - binding requires "pwm".

Best regards,
Krzysztof

Best regards,
Krzysztof
