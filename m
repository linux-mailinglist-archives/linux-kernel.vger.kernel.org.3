Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EAF523C17
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345949AbiEKR5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241439AbiEKR5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:57:45 -0400
X-Greylist: delayed 174 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 May 2022 10:57:44 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31013694A2;
        Wed, 11 May 2022 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1652291501;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=yDhDyiG143+NERzD1Q8ObYJHTt8duWx1100elYLk5Lw=;
    b=r8NeX8j4jl8lZZEDENr2QyYz9IuHVl07+1svJVb03mdDMKhJIiCJebebK6r1SdasDL
    wCKoyTZalQ6afuDiXvQLs8Jh0AzhRv1mTTPPtIIMhSZogPMPymE7HoSDVLloF3YvgZai
    AjYGwIOPvTakRCmeJemsat+wwM9rLUgCIn5gTvXBb1fnon2l6m7gQQlsJL4W0gnatZsa
    w5l5aM87bRodTTMOB4oJfY0FvG9YLL9ZXgvNtw0b7g1XOtNPA0NIx5BgHiqT1yyutoZ8
    Lex2gFOxdj5C0drn/K6S2xPFFNEpq8H+kclxF/mAzVKUm0HIYtgs5EEgIJiTpnZ7zNtZ
    myTg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLUrK88/6Y="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.42.2 AUTH)
    with ESMTPSA id u05e50y4BHpf2o2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 11 May 2022 19:51:41 +0200 (CEST)
Date:   Wed, 11 May 2022 19:51:32 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Sireesh Kodali <sireeshkodali1@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, bjorn.andersson@linaro.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8916: Fix typo in pronto
 remoteproc node
Message-ID: <Ynv3pE3gkLW39jNk@gerhold.net>
References: <20220510042654.71152-1-sireeshkodali1@gmail.com>
 <20220510042654.71152-3-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510042654.71152-3-sireeshkodali1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 09:56:54AM +0530, Sireesh Kodali wrote:
> The smem-state properties for the pronto node were incorrectly labelled,
> reading `qcom,state*` rather than `qcom,smem-state*`. Fix that, allowing
> the stop state to be used.
> 
> Fixes: 88106096cbf8 ("ARM: dts: msm8916: Add and enable wcnss node")
> 
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>

Thanks for finding this!

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
> 2.36.0
> 
