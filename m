Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36585A68D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiH3Qwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiH3QwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:52:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506548E9AD
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:51:42 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z29so7780110lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=1sF5nJ7Q7XHUasvWbOvS1pvPx5Dhfb6J9h8JpcSJRUc=;
        b=KaxalF3yRrdhxRMA4b5osurOYGklnWpN2vDzlaXLO1pww4FGE6sijGBRQPSCzOpB5N
         ryQhYLGjhUeVh42UNxXItzKjAo676Ko/rOUNiVDLwDZz7MTSNrpc6PSY9zIb9VYe5/YG
         pTDFHJKGIP+CAjBIjzx3KXw0A/uvfKvVvKaSSE4LSrz7n9A3lCznwNKeIyDqRrb1Zz8k
         TzuU2+4G+AJnbduQm+e5EMNn/akm3IMHTebYVa6joxFFcWqpWZxLPJ/GzKVY/amgyOeR
         6LbROrKXEl+a24tlCizB/N/2CP0/8XVfp3eVsjoHlajOA+kRoetzpblBeaYhvXyMj8ak
         h7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1sF5nJ7Q7XHUasvWbOvS1pvPx5Dhfb6J9h8JpcSJRUc=;
        b=OB4cq1RkVLLEjMXd4U/R3RYFyWkw0rr44HeI7MTRpi22PRWCUbELJ3k0kNYYjDhx8n
         uTxfmt7IWVFFnjzkdt3sO1cvlplo/pgKcXcLSaKr9bs6cg3dq/cWzmca8Dc4t38NQXi5
         zny3HdMcIU8nHJSA2gxXOl0KORRenEnTltPXapjyKuJyZJF4sVYsx78EzQ4DP5mnXK6V
         R9GpUuxukQvBhn1QkGj7DbD5666T+urLedGudLtvgFH3iT6V+Wn7lsHO6ycaqGhF2uwL
         4LrUrf94utmm17bM98YRYH9Ku787V5b7G6M4c9WJz0PdgorfKanS/iIuyUPaBEc/O+Jq
         JJAA==
X-Gm-Message-State: ACgBeo0PHzdpucJyIn33Sl2CUNDkuD3vEMOGUcpB1YGb8DqCBmaYu/Zh
        ItOOFcKKtMF3I7r2XfTlEXaJrw==
X-Google-Smtp-Source: AA6agR5MDApTH7E8g6nPTJZs6HqrmqTIBYeQXRE5JLhYEU6vDcF5TVNjWcoW6N3LpKH+Mx2KDyRwbg==
X-Received: by 2002:a05:6512:33c3:b0:48d:2703:7ba2 with SMTP id d3-20020a05651233c300b0048d27037ba2mr8710501lfg.510.1661878299342;
        Tue, 30 Aug 2022 09:51:39 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id w12-20020a05651234cc00b00492eebe1f09sm282607lfr.74.2022.08.30.09.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 09:51:38 -0700 (PDT)
Message-ID: <416ea156-6f66-0d36-c32a-5e897816f6f5@linaro.org>
Date:   Tue, 30 Aug 2022 19:51:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/2] dt-bindings: arm: ti: k3: Sort the SoC definitions
 alphabetically
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220830160507.7726-1-nm@ti.com>
 <20220830160507.7726-3-nm@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830160507.7726-3-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 19:05, Nishanth Menon wrote:
> Use alphabetical sort to organize the SoCs
> 
> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Suggested-by

> Signed-off-by: Nishanth Menon <nm@ti.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
