Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB45455B2F2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 18:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiFZQqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 12:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiFZQql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 12:46:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927E6DFFA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 09:46:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id q6so14310178eji.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 09:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5vpUASIBogS6tthTPhxUlQj4qLuFV0H9+f5WloHSMOc=;
        b=koJOxP42j05kinbyu2SNb1DTGbbFFYikiaqf1dqFMUKvXxdAN6Z2OlwXueuU/Xrit6
         9U85lasBhh3GRY/vt9HH1j5eNLSGb41WabFBZ7e67ho2PiyYdmzF+OA/xnNaCjnOEjfv
         NVQwgUDNwLtvCZ2RMZN/EdCDHXaRqnRGHxdQyzMFNMlXysIp91f0C/SM5zFZcgV+uq8j
         JdgvClCZlps5LtiNrRbJj6hSStVdTLcrw2EPWi01d1aIogypRliBHtqEKdmS1w5q0vsm
         amveemJPk5urtBvW0ebW3yVDXIdYfgHnrkkq3yOT9MwSA04ZcbsoSCsXLNCXWFWbzDO2
         W69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5vpUASIBogS6tthTPhxUlQj4qLuFV0H9+f5WloHSMOc=;
        b=dHWZS1XElUgscx8SLq125FxpytqGqa1WCaOF1uElGHBM2EYCK+g7VtVfe9N5fX2GW3
         Hg435WV1LQyk1P7UKdblOtdwVH1NXv0HpxrXvIuwapyF0FM9ImV+wGgX9NuVtwEKqP0n
         0sn9qUPGlNQ+htj7CpB0psW7l+Gu6vjv7W5GPoe9qGyqmimW23VmHaex6xWGowK4+TIO
         O4B8yiP+a4DSG8ML+uZgI7LuR4fOBzDaicdgZ28B+VGOUqkUWcA2bz7JBCkfCv3WzoOq
         rtq16TvcIkSQ1IeCGYPheT8V9Exs6r/B0cWQ9j8WZFTQr6YRgxGT7uDy3L7QL89cuVTP
         x9sw==
X-Gm-Message-State: AJIora/AQ21rLxFT0iArQXSzeyProsyolaRREu5u7LYslzw+M20LmpsF
        r92mdg6vxqTul3YaSPTkzKDXMg==
X-Google-Smtp-Source: AGRyM1vtMtRrrKSIBN+QrTQV20XAeY3rlGvQDPowu+kMS0M7Miu0TzhQvz97WmNd20I7o/Ja6LzulQ==
X-Received: by 2002:a17:906:378e:b0:726:38df:6f75 with SMTP id n14-20020a170906378e00b0072638df6f75mr8606556ejc.577.1656261999197;
        Sun, 26 Jun 2022 09:46:39 -0700 (PDT)
Received: from [192.168.0.242] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g16-20020a1709064e5000b007072dc80e06sm3882674ejw.190.2022.06.26.09.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 09:46:38 -0700 (PDT)
Message-ID: <1a8cac72-14c9-8a7c-f057-19eab8cdfa3d@linaro.org>
Date:   Sun, 26 Jun 2022 18:46:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/3] ARM: dts: qcom: extend scm compatible to match
 dt-schema
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~okias/devicetree@lists.sr.ht, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220626114634.90850-1-david@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220626114634.90850-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2022 13:46, David Heidelberg wrote:
> First device specific compatible, then general one.
> 
> Cc: Robert Marko <robimarko@gmail.com>
> Cc: Guru Das Srinagesh <quic_gurus@quicinc.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm/boot/dts/qcom-apq8064.dtsi | 2 +-
>  arch/arm/boot/dts/qcom-apq8084.dtsi | 2 +-
>  arch/arm/boot/dts/qcom-ipq4019.dtsi | 2 +-
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
