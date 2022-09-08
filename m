Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E945B19E0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiIHKZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiIHKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:25:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B3C4F19F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 03:25:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u18so14652625lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=57yTkHiGXjWnkXGm6JlceeEsGo2P/r8hSMSqmu8svV0=;
        b=YwlgSLTr0/Ej6GuBRvufQDVAhfDb/6pCyFGFegA1tIVWyKDSs32h1G8r4Usq7bFZlB
         dstYY792pCGAa+M0pX4fmpj0iaSubvKljS1+NeWyl5seE6YSgv/k1U2YiCNWGtR1+H9Z
         cQke2Ojj3knwbDDcIA5Lzsul9C67nRcVlE2iQPrWP8I9VVptC530eMKIX0rLofmlzlAl
         Mbq7ZhmQYgfRroaFAxfU0irYDzqct7KpLgB5B9Bk4er1pqd88A8kTk6Kn7W6YeZiI4vz
         n1j++6i5PKD8CqoG3JhGbade2mL/DwMH5zwctHGpnqIAz5QTxrBzGI7JBas90Gijox+b
         C2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=57yTkHiGXjWnkXGm6JlceeEsGo2P/r8hSMSqmu8svV0=;
        b=KMWt8h8hmEgym9jA4FzmK3nciFtajPV+1IF2fe5xr3K/zuPl5hzdeMvFDPoM3yGHHJ
         JwllAfy18tdPILK5lLbDld0D3OJ+fDSOUsZr46b5XttDK2uK5c9usbAIIqcLt3iBNPKX
         VALV0Xzsq2egZGSWZ79CPPWgwl5XuNPdW9Ikickx6aO6kASG5wdbK/57tqNmjZf6Nvil
         Zg84TqSpKgILukFBQwJK3MVq6hcRKaZSPGuvtSjNYa1V3fY2c5L6JvdIWkL+WPTKhpmm
         b6iKiZNaMW+HpCSNLN6I+MYB5cuPEZHdRJvsrb5jlIJQF8v6M3c1fINUWLQabqQKTpJW
         hP6A==
X-Gm-Message-State: ACgBeo0XBzCkroIkGinsjwlS7wXCUjYLrxtgFvdSQf87asFJB91W4xpX
        j7po8MH6bB7HDtYOqmfNjztbzg==
X-Google-Smtp-Source: AA6agR4X44BfrP900TazaipQinCvCxZnYsuB6qcR5lsq7VC5vKgXbEkDtPpQC7wM5j1HC9YWZDq5wQ==
X-Received: by 2002:a05:6512:1322:b0:492:de5b:dc3c with SMTP id x34-20020a056512132200b00492de5bdc3cmr2357170lfu.503.1662632727392;
        Thu, 08 Sep 2022 03:25:27 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a3-20020a056512200300b0049306939413sm2973669lfb.211.2022.09.08.03.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 03:25:26 -0700 (PDT)
Message-ID: <abad381a-dfe7-9337-ff35-f657bf373d44@linaro.org>
Date:   Thu, 8 Sep 2022 12:25:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3] regulator: dt-bindings: qcom,rpmh: Indicate
 regulator-allow-set-load dependencies
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        johan@kernel.org, Johan Hovold <johan+kernel@kernel.org>
References: <20220907204924.173030-1-ahalaney@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907204924.173030-1-ahalaney@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 22:49, Andrew Halaney wrote:
> For RPMH regulators it doesn't make sense to indicate
> regulator-allow-set-load without saying what modes you can switch to,
> so be sure to indicate a dependency on regulator-allowed-modes.
> 
> In general this is true for any regulators that are setting modes
> instead of setting a load directly, for example RPMH regulators. A
> counter example would be RPM based regulators, which set a load
> change directly instead of a mode change. In the RPM case
> regulator-allow-set-load alone is sufficient to describe the regulator
> (the regulator can change its output current, here's the new load),
> but in the RPMH case what valid operating modes exist must also be
> stated to properly describe the regulator (the new load is this, what
> is the optimum mode for this regulator with that load, let's change to
> that mode now).
> 
> With this in place devicetree validation can catch issues like this:
> 
>     /mnt/extrassd/git/linux-next/arch/arm64/boot/dts/qcom/sm8350-hdk.dtb: pm8350-rpmh-regulators: ldo5: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
>             From schema: /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> 
> Where the RPMH regulator hardware is described as being settable, but
> there are no modes described to set it to!
> 
> Suggested-by: Johan Hovold <johan+kernel@kernel.org>
> Reviewed-by: Johan Hovold <johan+kernel@kernel.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> 
> v2: https://lore.kernel.org/linux-arm-msm/20220906201959.69920-1-ahalaney@redhat.com/
> Changes since v2:
>   - Updated commit message to explain how this is a property of the
>     hardware, and why it only applies to certain regulators like RPMH
>     (Johan + Krzysztof recommendation)
>   - Added Johan + Douglas' R-B tags

You posted before we finished discussion so let me paste it here:

The bindings don't express it, but the regulator core explicitly asks
for set_mode with set_load callbacks in drms_uA_update(), which depends
on REGULATOR_CHANGE_DRMS (toggled with regulator-allow-set-load).

drms_uA_update() later calls regulator_mode_constrain() which checks if
mode changing is allowed (REGULATOR_CHANGE_MODE).

Therefore based on current implementation and meaning of
set-load/allowed-modes properties, I would say that this applies to all
regulators. I don't think that RPMh is special here.

Best regards,
Krzysztof
