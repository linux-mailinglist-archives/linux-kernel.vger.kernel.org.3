Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12BE51629C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244046AbiEAIQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbiEAIQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:16:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F99C15FF8
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 01:13:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i27so22746655ejd.9
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 01:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XrKlK/wlEuAV8r4Uf6E1ukYjJx77nczax1aunKH5Q+4=;
        b=YXINqYqsI0H9E96YUKV9+Mjzm52tkYI1g7ZqF8iLgJkMSH9V6NboFQLX3+U09VaasC
         1Cis79Ded3Ql2O3zeNDUdojx0Lryo2uqklTYBces9JIway60hBgeHf0G7HNFSEt4RTgp
         gCxNhm2+SZSmmsiSd6Xe3OXN6pleuh9F8IywWLaGMoKLJBl+7sUdYSx/9jzHA/lxnrH+
         ZWN8pAKLurFJ0gg/ayepSUraNgr8/zPGPWQQeNr3OxdDhaW4EVfD4rsjiw/8qyAKDJ3G
         tSqSTe8ey/7N+6DEAEFV4b71o382zMgdXAqxyZQ9Mo0rDLaIwGFLoDHx2dCm3K/01bt2
         m7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XrKlK/wlEuAV8r4Uf6E1ukYjJx77nczax1aunKH5Q+4=;
        b=PnDMnw4JbqH6x/avmtSir9Sa/0Y2YYDWl/8jL83MlFXMvxRDdKzk781jE1hnT+J6i5
         Y0ayAfqY1pg04OFlMuZjKRLgwyFVlp23WuNya37jtjblsCTULub7rklXflcYpOtEMbGo
         KCk/j9Nz3gwoQn1ZOHBJLLBvLzdyJCnZouu38fXhQh6edX3VaU1oysT8lUoZcjN4m7WU
         G8DYg76I+ax8WlmMETV8yycKrKc+PehFuhQGPjfkP+aqy683NtOg/1KZxRZ4BShgPuP2
         9257hjE635yewxK8UwnyjofgLaaHnFZan1cYYZ5IfrloEn4DMzdjwu5CasbGjSw7U+9X
         Hr9w==
X-Gm-Message-State: AOAM531PPDiGbUuV3xHHui7vAe9oj2goMHJOt4hLrW3xbAlsk+fXLBuk
        rSLVPDALwzfgQLsgotEiFOsSTg==
X-Google-Smtp-Source: ABdhPJwXuUt0sftDa1TvYqXx+d7cm+eB/BhcX08Oq5n1MDafYYfJxDamHA1BTbHyE/MfVzuLR/AHJw==
X-Received: by 2002:a17:906:2319:b0:6f3:ad55:8fee with SMTP id l25-20020a170906231900b006f3ad558feemr6692397eja.26.1651392786726;
        Sun, 01 May 2022 01:13:06 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j12-20020aa7c40c000000b0042617ba63cbsm5047785edq.85.2022.05.01.01.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 01:13:06 -0700 (PDT)
Message-ID: <c58c2d00-2b07-8873-2146-738199855492@linaro.org>
Date:   Sun, 1 May 2022 10:13:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/7] dt-bindings: arm: rockchip: Add Pine64 Quartz64
 Model B
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220429115252.2360496-1-pgwipeout@gmail.com>
 <20220429115252.2360496-2-pgwipeout@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220429115252.2360496-2-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 13:52, Peter Geis wrote:
> The Quartz64 Model B is a compact single board computer from Pine64
> based on the rk3566 SoC. It outputs on uart2 for the debug console.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
