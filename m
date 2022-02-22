Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4054C00BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbiBVR7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiBVR7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:59:01 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FD617184E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:58:36 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id w10-20020a4ae08a000000b0031bdf7a6d76so18645913oos.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Y2AqDKUpMQgTsOg3FI79lbQQePJo1iYlm+XyAflgx0=;
        b=LmfyH44UGzXt6wILF+bnLCqYn5OW6LnPIuT7x/JfxAHL5ZgBH/SB0zz1GaU07zcKc/
         4vYk85m6gonT+gcZxME1BSo79mzDwxWs/DQMWtRFmpqqANaKCNGtCNVWZYpUTvyW7pcJ
         s2aiFwVT0mO15/chQySqSzZTEL6OTIoxG7sUkG0CHgcdu6qRTesl53RZEWD1iYvozm0e
         I/ABk/YjAZeMhehY75hopIW0b+A1jb1wO0tDxGW+AoMDSRKNcaz3NsaH9+/dpPirWAT5
         wdoLeS6F2wvtIjEkHbZjwUb3ePZ/CBKeWx4JUssJ9dzTW0PoBgqEI0gCOfbPsDGUL/UL
         HbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Y2AqDKUpMQgTsOg3FI79lbQQePJo1iYlm+XyAflgx0=;
        b=jTE1yynDWoubvG7547hhzJbdQkzqMxM0k2LfN14pW++YPbDrY+OEQ8EVPl16Ry2D7A
         oZt+jWZuy71v0fA4HPLocVYC5rkyPV9G6JaRViivlMQUdkzRcXsA//MI0cBYLGwb4ElR
         nCYnHQ1rkAxAYq0EJiuL6zhMF5ok8L0mOx+5i0yQGf6BSXLbYYKrPLFykmNPdyQtnP/B
         i2F+jB0xZaZFiWoB7ol+iCBQgfvrBxlDuO18MgTnoUk489D5h09NG7ZWrY9o6hBdAvkp
         d8XbDlRyw8tjNef7z8Dpzlmk8D6XY7SXRi55QRIptz/tOnoVIB088HdM9I33jpVEStvq
         P+9Q==
X-Gm-Message-State: AOAM532sq59pkNZTaXsHw+K3x420L/xZEuhHWHwAYpML0TkW4W3TZ4hh
        ZGAn4bYkxRFA+XREbfXtGSuwRQ==
X-Google-Smtp-Source: ABdhPJyj87/YvJOCybKJXx1u/9jXrSrA/hbB7V18Hg9PLPl52iAsQhxw+fIIZM13P1F+EGTEAGWXrA==
X-Received: by 2002:a05:6871:7a8:b0:c5:a1b3:43eb with SMTP id o40-20020a05687107a800b000c5a1b343ebmr2265517oap.103.1645552715430;
        Tue, 22 Feb 2022 09:58:35 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id g18sm1751484otp.17.2022.02.22.09.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 09:58:34 -0800 (PST)
Date:   Tue, 22 Feb 2022 10:00:34 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V4 4/4] arm64: dts: qcom: Enable pm8350c pwm for
 sc7280-idp2
Message-ID: <YhUkwmis0ZY9gypR@ripper>
References: <1645509309-16142-1-git-send-email-quic_c_skakit@quicinc.com>
 <1645509309-16142-5-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645509309-16142-5-git-send-email-quic_c_skakit@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21 Feb 21:55 PST 2022, Satya Priya wrote:

> Enable pm8350c pmic pwm support for backlight on sc7280-idp2.
> 
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> Changes in V3:
>  - New patch added in V3, to enable pwm support on sc7280-idp2 board.
> 
> Changes in V4:
>  - No changes.
> 
>  arch/arm64/boot/dts/qcom/sc7280-idp2.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
> index 73b9911..d4f7cab 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
> @@ -34,3 +34,7 @@
>  &nvme_3v3_regulator {
>  	gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
>  };
> +
> +&pm8350c_pwm {
> +	status = "okay";
> +};
> -- 
> 2.7.4
> 
