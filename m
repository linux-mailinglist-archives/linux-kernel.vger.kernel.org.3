Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7494DD080
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiCQWH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCQWH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:07:57 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57461B2555
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:06:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so6734788pjp.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U0V6btb7u9qS5nips1+z31k5lj0QWB0ykav3g0r1fcM=;
        b=Ivk9Nz5JQfBEUCvXJZ8aedgkaMnIdetggSGbiI5czKkd3qVQDU3IS1SUC+V77Jt3gN
         gheOG3jG07BrNOAlBHuWA3wrXJnTfKw4jxoK6tt3yTRfyqzE/kPf+QxupGl1b0qJhwgv
         TOEB1VfbJbmM8umvzrh+igG0e4QNK+gQkYX3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U0V6btb7u9qS5nips1+z31k5lj0QWB0ykav3g0r1fcM=;
        b=B/ajDi3Tn7EAo5G7OuckSI1Mv9Uz+AEfheMt8gZ7ggk7fCgRSgG680uLqHbBh1i6M7
         R/iyedFABvdoq19y5JI+Axfc8ZS+QSgGWhALLABRQ43Y+B0/M8vCR3w9L9p9gURllvZW
         dMmBjECu+GmmhldgZhQOF43R6HyyB4+J4jnFjIAOogtntUsfUtjMavAembIcM8PAnjpi
         /Qhm2VWaW+Fpu03HjHt/grnHcTjcdbHOmPVuJfhWbMbN33L01PGTT4JVaklF6UMVbJ/9
         ZfE+VAGKuDEohbY15n+XMA7qzsGRC9QdCqJ9JgffEbWEbKU0EJ8lGyu3HSjVI+GIy/OF
         IpFQ==
X-Gm-Message-State: AOAM53175wY597ZPNyFmrs7jnu/+O000F2XmhSlxd3AMem3qd+lCzF5s
        24ep+l19NFjC53uprQ2Tt1jJqg==
X-Google-Smtp-Source: ABdhPJzShZ++fg8Q2pUXjZ2UcKHktHjFy5/vKxu4tiir2AiVMhnD58yfAFvoeO75YMbkV41305cLHg==
X-Received: by 2002:a17:90a:4a91:b0:1be:e51a:47df with SMTP id f17-20020a17090a4a9100b001bee51a47dfmr7849937pjh.40.1647554800254;
        Thu, 17 Mar 2022 15:06:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:ae74:932d:af6a:6079])
        by smtp.gmail.com with UTF8SMTPSA id t11-20020a056a00138b00b004f7664328a0sm8291039pfg.162.2022.03.17.15.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 15:06:39 -0700 (PDT)
Date:   Thu, 17 Mar 2022 15:06:38 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Fully describe fingerprint node on
 Herobrine
Message-ID: <YjOw7sutyNWnbdRU@google.com>
References: <20220317010640.2498502-1-swboyd@chromium.org>
 <20220317010640.2498502-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220317010640.2498502-3-swboyd@chromium.org>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 06:06:40PM -0700, Stephen Boyd wrote:
> Update the fingerprint node on Herobrine to match the fingerprint DT
> binding. This will allow us to drive the reset and boot gpios from the
> driver when it is re-attached after flashing. We'll also be able to boot
> the fingerprint processor if the BIOS isn't doing it for us.
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Depends on https://lore.kernel.org/r/20220317005814.2496302-1-swboyd@chromium.org
> 
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index 984a7faf0888..282dda78ba3f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -396,13 +396,16 @@ ap_spi_fp: &spi9 {
>  	cs-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
>  
>  	cros_ec_fp: ec@0 {
> -		compatible = "google,cros-ec-spi";
> +		compatible = "google,cros-ec-fp";
>  		reg = <0>;
>  		interrupt-parent = <&tlmm>;
>  		interrupts = <61 IRQ_TYPE_LEVEL_LOW>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&fp_to_ap_irq_l>, <&fp_rst_l>, <&fpmcu_boot0>;
> +		boot0-gpios = <&tlmm 68 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&tlmm 78 GPIO_ACTIVE_LOW>;
>  		spi-max-frequency = <3000000>;
> +		vdd-supply = <&pp3300_fp_mcu>;

IIUC userspace controls this regulator. Do you add it just for completeness
even though the kernel doesn't use it?

>  	};
>  };
