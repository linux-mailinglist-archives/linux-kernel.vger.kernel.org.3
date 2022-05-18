Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B1452BC79
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbiERMr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiERMpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:45:53 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102E615EA52
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:42:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h29so3428467lfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 05:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2vgkcgkvD6wC0cwxlemq7x356q295GLVNbkOBzA2YxE=;
        b=rlTF2pGNUZ9xLVv7e1nEF+Z3G5BSfstynEyJnmTmPoeV6RSyZbW1LUGnGw1Q7IYPXM
         Q+VzTkQIlFuiGJ6IdMs+bx3r9/FZIZFKzAqWB4Dt4Si32pe5pXa3Zw7e5I3st9+Ia10B
         TfrsXjgZNHD8xT3A7CyE8qHgCIZr/9xpUKl1Hccz5PUGAB+6Ht3fVRQYbT2vo4ND0JYN
         DcJxaYIV2oSE2Ken3soy+f+wSqSWffY1hf1YTcY0YePoZOFGILCjpP+pbTN24wWQpiAU
         24efTgUqyn4IT6TP0hPnqKM67GA2FdJoheXSM4ncMif9/BKtWp87b+PvDSCEoTGaYZqg
         yFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2vgkcgkvD6wC0cwxlemq7x356q295GLVNbkOBzA2YxE=;
        b=oeRQUQa2v4+5xu374oGmm1AhISM/KSFHunoCGLhuDxJDsZyshASCXRUyZktLU05IRk
         yD58iVbTJQOEDtVDKGz76pNAEnh15Xr/J1CO6V6oQ02JgBQb/g1q7GWTuqkswiqgJa7b
         CgK79n1HMK6+9PSjK09OlnkzHuWOhoOKNcOG2d3UCxIFtuQ8nyca8t4xEU80qPTS9TiV
         fBWV7wnW08R3QCVRBJaXpSt36AKnPJPd4KLzsbjuXLnFBF6XYY+p1oIFvcZwnNF/LlI/
         fx3dflUwne107K6tthrEviVOzVqjlDr3Rox5fmNEnq0wiWGXnAMbG1RqNJOvuwIh3M7e
         2k8w==
X-Gm-Message-State: AOAM530o8Po3dVbXa+hFXly6AOYrxwa9KpZO7n7hFPWYIbybs8xCWkSZ
        Dsu2IDnaGP4C760+TzDdRwv9QVoHp12/nIYw
X-Google-Smtp-Source: ABdhPJxN+RYfgFZsiy+AoktspD9yuD3bHCCzUdtzXetU8hXThMYhg4oVLuLhwc6T+t+3H8Oe3L/TQg==
X-Received: by 2002:a05:6512:3f96:b0:477:c0fe:9b05 with SMTP id x22-20020a0565123f9600b00477c0fe9b05mr103111lfa.109.1652877738130;
        Wed, 18 May 2022 05:42:18 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r10-20020a2e994a000000b0024f3d1dae7dsm210967ljj.5.2022.05.18.05.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 05:42:17 -0700 (PDT)
Message-ID: <9417e665-c1d4-e82c-5c55-a2c5860cc453@linaro.org>
Date:   Wed, 18 May 2022 14:42:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v9 1/2] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rui.zhang@intel.com,
        amitk@kernel.org, kristo@kernel.org
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220517172920.10857-1-j-keerthy@ti.com>
 <20220517172920.10857-2-j-keerthy@ti.com>
 <783127cf-79cf-90f2-4200-30db56a1fd7c@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <783127cf-79cf-90f2-4200-30db56a1fd7c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 10:27, Daniel Lezcano wrote:
> 
> Hi Krzysztof,
> 
> I would like to pick this series, does the DT bindings have your blessing ?


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
