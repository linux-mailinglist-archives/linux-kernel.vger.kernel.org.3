Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19808507EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358984AbiDTCjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358986AbiDTCjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:39:07 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5925537AAD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:36:20 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e2fa360f6dso615355fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uPpeQw/Svxec6EB5vDEdkM6+QwQAh4U7mOcWgKqa4Vo=;
        b=zLR210LIyC5pG3HErtCaJG3Swm3AE6TefCzVOjS9CFMDRXbeJiI1F3wBEMUNfzTJW5
         UIFvh4TubzbwaoBeJqLobgpOtWdaXkxQ00XPyq93bjlc6bNBF7tRmSpbGJhn0/iqNBkU
         AARav9d7tGA5hGF7FTfhGHS5ZND3IZsLa0cxtwnuaGv5HzVm51wXonnlZ7rIvpkcWCF2
         BdXj6l9SLH4+isw/LqD6YvlOWOmFqxL63EG26MdrvgEp2Hnbjc8toReO/+ZAL0pyqPat
         gOKWn8ABpZAbUzk8jrWL8ZmGYoqSqg0qVu9rvwGZrZxwTk4yX/YZIpO4tOkRrGu3BKus
         /crQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uPpeQw/Svxec6EB5vDEdkM6+QwQAh4U7mOcWgKqa4Vo=;
        b=ApXGH2ysPDyiQzzMgiGXPoJR07GYtauBsuLOmami/5G/q9FGSnd0XOxYU/hHu1qOe9
         JJGh34PLCyw4XcARY7XcNogIOzhnngWyRmehS39qxnjkKImGmEpRVBt/p4yNEUsYHPxE
         xthowr+mVMo772e7IP2utWb7OeMC9Dbv+6U8u3OjN/6YY7D0r3ymo+KPkKwp7eZofDPR
         YX2M01uNlRsA1RmInSZ6izf1HZPTGqHnM6BffPHe0g0vYkrvBywJM2AGdT5urgy4BZKH
         OrtLoqFmH1l2ookjAZkYzb/F85Nhz7fatyBXZS+FC24NGSBgub2fnIgqWiB+557HZlC4
         6Tqw==
X-Gm-Message-State: AOAM532hGsnBrsXUt63NCQ/+gmJCrhXRH5mqEcS+E0PVhmVBkPJS4g/D
        20d3DGhbpugIiaDLTbDDcw/86g==
X-Google-Smtp-Source: ABdhPJyKHPVDEDnzZkxF9L9vrMd3VNFmgySs4pbsIaO2GrjCdMyTc6jlRLdrA0XgQHO0pa/l8eLpvg==
X-Received: by 2002:a05:6870:632a:b0:e5:a05d:3c29 with SMTP id s42-20020a056870632a00b000e5a05d3c29mr653638oao.293.1650422179516;
        Tue, 19 Apr 2022 19:36:19 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id y22-20020a4aea36000000b0033914f661a2sm5077728ood.33.2022.04.19.19.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 19:36:18 -0700 (PDT)
Date:   Tue, 19 Apr 2022 21:36:17 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, dianders@chromium.org
Subject: Re: [V4 1/2] arch: arm64: dts: qcom: sc7280-idp: Configure cts
 pinctrl to bias-bus-hold
Message-ID: <Yl9xoYo8z7z4gSTT@builder.lan>
References: <1650349697-13540-1-git-send-email-quic_vnivarth@quicinc.com>
 <1650349697-13540-2-git-send-email-quic_vnivarth@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650349697-13540-2-git-send-email-quic_vnivarth@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 Apr 01:28 CDT 2022, Vijaya Krishna Nivarthi wrote:

> WLAN rail was leaking power during RBSC/sleep even after turning BT off.
> Change sleep pinctrl configuration to handle same.
> 

As I said before, I would like the subject to contain the word
"bluetooth" (or possibly BT if bluetooth doesn't fit).

And drop "arch: " from the subject prefix. If you're uncertain what to
put there, run below command and follow what everyone else does:

  git log --oneline -- arch/arm64/boot/dts/qcom/sc7280-idp.dtsi

> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
> v4: modify subject of patch to indicate file it is applying to
> v3: apply same change to active state and other sc7280*.dts* as well
> v2: used bias-bus-hold as per review comments
> v1: intial patch used bias-disable for sleep pinctrl in sc7280-idp only
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 015a347..85e7467 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -400,10 +400,10 @@
>  
>  &qup_uart7_cts {
>  	/*
> -	 * Configure a pull-down on CTS to match the pull of
> -	 * the Bluetooth module.
> +	 * Configure a bias-bus-hold on CTS to lower power usage
> +	 * when BT is turned off.

This comment would just leave a future reader with the question about
_why_ does this lower the power usage...

This problem you're seeing is likely to come back in the next platform
and your successor (or even yourself) will have no use of this comment
to figure out what bias to configure on these pins.

Thanks,
Bjorn

>  	 */
> -	bias-pull-down;
> +	bias-bus-hold;
>  };
>  
>  &qup_uart7_rts {
> @@ -495,10 +495,10 @@
>  		pins = "gpio28";
>  		function = "gpio";
>  		/*
> -		 * Configure a pull-down on CTS to match the pull of
> -		 * the Bluetooth module.
> +		 * Configure a bias-bus-hold on CTS to lower power usage
> +		 * when BT is turned off.
>  		 */
> -		bias-pull-down;
> +		bias-bus-hold;
>  	};
>  
>  	qup_uart7_sleep_rts: qup-uart7-sleep-rts {
> -- 
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.
> 
