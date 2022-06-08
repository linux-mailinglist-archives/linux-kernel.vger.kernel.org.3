Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD74542E7F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbiFHK4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbiFHK4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:56:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503E317584
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:56:40 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id fd25so26553171edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 03:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=kIRlqaVdYZXIRIZd+hxgZZVzy6dDxLLFwKImFQpXotU=;
        b=hyU4X40Nz/Lx9qIGeam6AzSooNWmYpAIj+Q+gE+cj8MElb1+Q+hEADV08PBLOgtNrh
         zUR87XGmaeL3NUwDsLr1Sv9xRNo3J3TFTRhhDt8zpuR1D0HrAWt2uFsJ2A3hLaSTZz4p
         hJpZFYuVYZPVcRcefIGSGNcNBmRo4nLAMdeKaGLQ/vkVhlCM+Al2Q4mk/E4O4m3dADIA
         N0bi4lpG3zoPsmV3Lm+TsO1DUxHXTP9RUb57hH9AJDluqpTOTgwbKXXZ6iK8iq+OxE2w
         msKCLpNyAJUUtVk/Oa8mNbz+8X/gYkBND8mb2OTVgHmTkHLIXmgstV/2g1NySuanFSS4
         hBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=kIRlqaVdYZXIRIZd+hxgZZVzy6dDxLLFwKImFQpXotU=;
        b=Bj6CMEEaMO1PRfS5/jVbzPXBY8cbJEUGX31QXj/zySjZjE7Z5lQRgv8CfNPfBt62ZL
         Og7cROhxkdhXgLfZbd/+RowdR/0scSNPsK4Fthav2cRZXNs74gDT7qN5cU5ViEEj3eSu
         /Z79wqKXKXps25UmapgdhOr2qKhQVK0LyMT8/kH2siDPBBQJjMQ8+59VZUB5el3sFmrj
         TqvxJfL9iNpppHdkPMMrExShFCBrZ3PFPS6/3jpZSlwAq7BvHQ6WbXy4X7GSNqMWGohS
         ajWFtv6mGp/S5sgV1ndiEI2xuW1kGLcPNc4nVKi8X+nL/HpQZ95KcJ9kCyJZKyCGP7st
         orPQ==
X-Gm-Message-State: AOAM532ju+qVr0rB6byXv2vDt9TtB/TyRDkpSjUhG1hoSr6YL4HoYuBq
        3C5W/yMDVb2g8m+R/GyTOIYS9g==
X-Google-Smtp-Source: ABdhPJzy5br9NjWAf8PF225RB1/HmWvrycaeauU/GGCLCLTNLM2gmBgGG82ySrg9BgkPsZV1gsG0yQ==
X-Received: by 2002:a05:6402:388b:b0:42b:5f20:c616 with SMTP id fd11-20020a056402388b00b0042b5f20c616mr38538173edb.50.1654685798678;
        Wed, 08 Jun 2022 03:56:38 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i2-20020a056402054200b004315050d7dfsm6014158edx.81.2022.06.08.03.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 03:56:38 -0700 (PDT)
Message-ID: <1334adaa-83f4-8682-7033-1549cfd8af49@linaro.org>
Date:   Wed, 8 Jun 2022 12:56:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 01/12] dt-bindings: vendor-prefixes: add Shift GmbH
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2022 18:45, Krzysztof Kozlowski wrote:
> Add prefix for SHIFT GmbH, phone manufacturer
> (https://www.shiftphones.com/en/).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Bjorn,

A lot of new boards and patches might conflict with these series, so can
you pick it up early?

Best regards,
Krzysztof
