Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4945513F56
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 02:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351361AbiD2AFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 20:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343984AbiD2AFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 20:05:34 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2700A8BF0C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 17:02:18 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id z21so5255930pgj.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 17:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DdpIeo8qDKopW17YMaGsDZHWirrUhQn+EdqCQKX/F4k=;
        b=BNy9maSppmO/FsAEqCGLKcsJ/KWQmkD7l5ZkZrBA8xfFM1MNp2DS92V31mDrnU7QAS
         sNhze6l0Psf882dKi8FXTYIEoeRJsamv38Lm0qsnTbPNkv/Ik14cp2rY+nPIpvyrXFq+
         oUjAftH1nynlCSPCa/41WBbze9CuCB9NOtPdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DdpIeo8qDKopW17YMaGsDZHWirrUhQn+EdqCQKX/F4k=;
        b=HPikFPN2fdny1iLax0HzErbdm8pR2aB9pwXmlaWI/YEHiiIE3vdk4aV4W+shvwHvYY
         l+0p69QAjdwiYRkx/pBahVA0bMfLlsqI5Zl6mrSRi69B/++rXID+4BwXcL/31Zj1cQJH
         D3e+KHrtgV61M9VZkC6ryF7sq1lHzsOIjepsNgz4lVJUPQWILrAAXqMfzcxZVYVqU9oE
         DVOlfE+GTsdXXEoUmE8BaO2DslV+jtsc5FRyUWewIaJP7dhp/S2tuat28donVDv6aZaH
         PmDPV9c5x5VZV6mnrikKxsKZHqKN4gjAOOadFE+rZkIjTj52uDAfI5uaqNuJciXnZEf+
         W+rg==
X-Gm-Message-State: AOAM5306boSWU+2DK7RnBHoTGjnKg2crM3ZuR3JvMPa9oZxw5uASg6at
        9XE2gEfQ2ysbPKpa3zf4a/WW/Q==
X-Google-Smtp-Source: ABdhPJzMGvektFu4NiNVjiGTUQyk/nKjasrvQhNAKir0f4xmYhQeaY8OqySQJHYDmHR2vr594Vy6QA==
X-Received: by 2002:a05:6a00:2181:b0:4f6:f1b1:1ba7 with SMTP id h1-20020a056a00218100b004f6f1b11ba7mr37393271pfi.73.1651190537681;
        Thu, 28 Apr 2022 17:02:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7d14:5f45:9377:9b6a])
        by smtp.gmail.com with UTF8SMTPSA id c5-20020a17090a1d0500b001cd4989ff69sm7686510pjd.48.2022.04.28.17.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 17:02:17 -0700 (PDT)
Date:   Thu, 28 Apr 2022 17:02:15 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v12 4/4] arm64: dts: qcom: sc7280-herobrine: Add lpi
 pinmux properties for CRD 3.0/3.1
Message-ID: <YmsrB6Q89II5w1+9@google.com>
References: <1651079383-7665-1-git-send-email-quic_srivasam@quicinc.com>
 <1651079383-7665-5-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1651079383-7665-5-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 10:39:43PM +0530, Srinivasa Rao Mandadapu wrote:
> Add LPASS LPI pinctrl properties, which are required for Audio
> functionality on herobrine based platforms of rev5+
> (aka CRD 3.0/3.1) boards.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

I'm not super firm in pinctrl territory, a few maybe silly questions
below.

>  arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 84 +++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> index deaea3a..dfc42df 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> @@ -111,6 +111,90 @@ ap_ts_pen_1v8: &i2c13 {
>   * - If a pin is not hooked up on Qcard, it gets no name.
>   */
>  
> +&lpass_dmic01 {
> +	clk {
> +		drive-strength = <8>;
> +	};
> +};
> +
> +&lpass_dmic01_sleep {
> +	clk {
> +		drive-strength = <2>;

Does the drive strength really matter in the sleep state, is the SoC actively
driving the pin?

> +		bias-disable;

What should this be in active/default state? If I understand correctly
after a transition from 'sleep' to 'default' this setting will remain,
since the default config doesn't specify a setting for bias.

> +	};
> +
> +	data {
> +		pull-down;

Same here, I think the pull-down will still be enabled after a switch from
'sleep' to 'default'.

If I'm not mistaken then the rest of the pins also need to be reviewed.

> +	};
> +};
> +
> +&lpass_dmic23 {
> +	clk {
> +		drive-strength = <8>;
> +	};
> +};
> +
> +&lpass_dmic23_sleep {
> +	clk {
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	data {
> +		pull-down;
> +	};
> +};
> +
> +&lpass_rx_swr {
> +	clk {
> +		drive-strength = <2>;
> +		slew-rate = <1>;
> +		bias-disable;
> +	};
> +
> +	data {
> +		drive-strength = <2>;
> +		slew-rate = <1>;
> +		bias-bus-hold;
> +	};
> +};
> +
> +&lpass_rx_swr_sleep {
> +	clk {
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	data {
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +};
> +
> +&lpass_tx_swr {
> +	clk {
> +		drive-strength = <2>;
> +		slew-rate = <1>;
> +		bias-disable;
> +	};
> +
> +	data {
> +		slew-rate = <1>;
> +		bias-bus-hold;
> +	};
> +};
> +
> +&lpass_tx_swr_sleep {
> +	clk {
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	data {
> +		bias-bus-hold;
> +	};
> +};
> +
>  &mi2s1_data0 {
>  	drive-strength = <6>;
>  	bias-disable;
> -- 
> 2.7.4
> 
