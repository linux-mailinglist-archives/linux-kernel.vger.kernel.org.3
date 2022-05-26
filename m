Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9DF535364
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344485AbiEZSgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348505AbiEZSfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:35:01 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CA42CE3F;
        Thu, 26 May 2022 11:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1653590089;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=M7rHhEC+oPKEf9TWKS8ix13sY2D6weu957Rrs1ZvcVY=;
    b=dd3qHsQZHhyXewQU9xvYf6QJ6YwRrNtknNoojN8/ZZ9dF3Ti/UQf26HyAwUlwxsNPx
    1OgjlXgsoLDvS63Jv/5s75S/xMDHYpv8vu4QywsHj3HQ9QwY7RAVDzI90R32m4vHEHIg
    6mxGUqCKrY3Q1JZfnpe72GxWRo0cD4WBTM3eUsXQpzTY3YYbXfzI0tTqBMd/C1knfOQD
    R6KgWUv3VGE2vb6TJscUIJB5fZqQjl8EA8NH82jL6XKtxWD9IuEg1NmqgpiL5/SSqQFs
    UdnyQ+bRdcX5MdrMMDhjAlNV4drWn37NNOcKYubwGy+bmToIL4oRsmTVEganTzCqC5rm
    ZRmw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLUrKsxlg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id 9056edy4QIYmZFe
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 26 May 2022 20:34:48 +0200 (CEST)
Date:   Thu, 26 May 2022 20:34:41 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Sireesh Kodali <sireeshkodali1@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, bjorn.andersson@linaro.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: msm8916: Fix typo in pronto
 remoteproc node
Message-ID: <Yo/IQU4r6siW3u2Z@gerhold.net>
References: <20220526141740.15834-1-sireeshkodali1@gmail.com>
 <20220526141740.15834-3-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526141740.15834-3-sireeshkodali1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 07:47:40PM +0530, Sireesh Kodali wrote:
> The smem-state properties for the pronto node were incorrectly labelled,
> reading `qcom,state*` rather than `qcom,smem-state*`. Fix that, allowing
> the stop state to be used.
> 
> Fixes: 88106096cbf8 ("ARM: dts: msm8916: Add and enable wcnss node")
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>

My review didn't change just because of an unneeded blank line between
the tags. Thanks again for finding this. :)

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index e34963505e07..7ecd747dc624 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1758,8 +1758,8 @@ pronto: remoteproc@a21b000 {
>  					<&rpmpd MSM8916_VDDMX>;
>  			power-domain-names = "cx", "mx";
>  
> -			qcom,state = <&wcnss_smp2p_out 0>;
> -			qcom,state-names = "stop";
> +			qcom,smem-states = <&wcnss_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
>  
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&wcnss_pin_a>;
> -- 
> 2.36.1
> 
