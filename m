Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87585A9293
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiIAI7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiIAI64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:58:56 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3571257D7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:58:46 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id p18so13843217ljc.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=mwYkPkbDpVvKnBCUeAO6SqNihrRVFRauQ3ciXakJntA=;
        b=cKwqNiIrCuxruPskUUyXVi0JY9nUNWB8yP5ZQhyNNBSUopD4SsK0P8gePIAcydCr7z
         r4crGQCX9xEDitfqH9Z6UxWKwsc02KM9E3EXGBjDxhJ/U9YJi0znHlHwoseHOaHNqiui
         z5FuuckuAUnshfoG1UFLG0MIPBJq6sEzM/cPdZDPL7TESLplsAH2ky6hEpuJkNgWPfyp
         nhGOokE0WMs01y19cc3exxaVmloPYyb//W6rFybNcFd/Y7AWbYNPBJ3OoozvSHzQjoJc
         RbuI9L+mP6sPKtqx+3EBJKqzFSXH8joq7o6XRrmeh2rpGwQETP24AyyrVOF93bnLkTa9
         8Drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=mwYkPkbDpVvKnBCUeAO6SqNihrRVFRauQ3ciXakJntA=;
        b=u36CVP2l0THPwm2vSURMasopuTLxkZ0Cdv6/hcbxEdzH4Fu9rUu5c3qOzb8RAhtRbL
         2tv75yNhBV9vt0PvZhTkvFAVjxzLnBVTNmFmEZbs2ThV/FNYTnbfmvIS14MWLv5P/+YY
         IMUOVhe5QSRHjptv229XVY3xQtgQhXyj3u+OCWbvqY6eXKtpy3c+CwKeZUQNM9ZIMnjb
         o1RcSP5aUHWRHqCxci5dORL+kRfzghPNwzd4tM95b+Pbjzg5iMZOtiVTPMa5Q7ygDfPx
         e0tqqPzweUR1TQLojUbfbAm/+CT9mL2CMbUE0tDtJK9n9GLmX2lIAQNWelHIv7t1b4Xs
         DCrA==
X-Gm-Message-State: ACgBeo3h1TloINUImi2ZLLmBE4IGKxOXCel+xOyb/bFajTG3SVprVncm
        L85woSKDiZvlSTvaZBOHCRk6XA==
X-Google-Smtp-Source: AA6agR4A/NKeMsV4Ak8gwgmbbPOMBHhorkS3+tj93KcLuvLF0EZl4lxNAvCjmnsb+w611pd+BKfYHg==
X-Received: by 2002:a05:651c:4c9:b0:25e:7979:573a with SMTP id e9-20020a05651c04c900b0025e7979573amr9289821lji.445.1662022724895;
        Thu, 01 Sep 2022 01:58:44 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id f8-20020a05651c03c800b002663afd079fsm1263777ljp.115.2022.09.01.01.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 01:58:44 -0700 (PDT)
Message-ID: <a9f4de46-e1ce-f8cd-2b0d-cd4bf36b1f84@linaro.org>
Date:   Thu, 1 Sep 2022 11:58:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 3/3] ARM: dts: qcom: Add support for Samsung Galaxy Tab
 4 10.1 (SM-T530)
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220831173207.238080-1-matti.lehtimaki@gmail.com>
 <20220831173207.238080-4-matti.lehtimaki@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831173207.238080-4-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2022 20:32, Matti Lehtimäki wrote:
> Add a device tree for the Samsung Galaxy Tab 4 10.1 (SM-T530) wifi tablet
> based on the apq8026 platform.
> 
> Currently supported are accelerometer sensor, hall sensor,
> internal storage, physical buttons (power & volume), screen
> (based on simple-framebuffer set up by the bootloader), sdcard,
> touchscreen and USB.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
> Changes in v4:
>   - Move delete-node to memory-region
>   - Move usb-switch node to blsp_i2c4
> 

(...)

> +};
> +
> +&rpm_requests {
> +	pm8226-regulators {

I don't think this passes bindings. Run `make dtbs_check`. I don't want
to keep accepting DTS which does not validate and none of submiters want
to fix this...

Rebase on top of:
https://lore.kernel.org/linux-devicetree/20220901085609.95624-1-krzysztof.kozlowski@linaro.org/T/#t

Node name should be "regulators".

Be sure your DTS has 0 warning.

Best regards,
Krzysztof
