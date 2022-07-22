Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF8E57E742
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbiGVTUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiGVTUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:20:00 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6C7904ED
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:19:59 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r14so6527979ljp.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=a4bYXJlSd1ZgaIpQeG4nLdpNWkpj3aQa+2dbGTYQopQ=;
        b=WcTfpkknrk7XnISZBeGeU6xAVW/U/1wZ5p+F3nYz/nNB3qtD8M04Y4t5BYwFAClcIy
         mHZMWH2iJaVCQmAMF6zWYNYFDrlLzGtZAClo8Uli1jABpBC+rRovCHyq0cYEpHBSMeiv
         /U/ezaNHvXvySC9NeRHqXt8rd3riuUq2diOJDj4fY3b+byRU1qdEn6/be9R8tfplIq2/
         AV/qX1QMJ3vZmtnSyFNhYa19HPuMFyEO/v6Pg6esZ0LTqgp9HMJT7xbi30GAeeGBoEoK
         6QU8UQwUcShemor6NM514mp3bzxskBb55Z9pA5tQ5rpGA+XhjPINIouqcqFHnU2lesLo
         Ilmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a4bYXJlSd1ZgaIpQeG4nLdpNWkpj3aQa+2dbGTYQopQ=;
        b=eve2UoA4swI7g5LIHRN6gdj4TNb+xF6fVaA7VxlQNtCK4gcdvh/6G/FGZIyU7R1QAn
         VdAme7mSoiQgA0kPEbk4hT5Ub1llsXNjgabM/f0XskoVMbHR2S1j1W9KURcoR0qjLg+d
         bcaOVhV6GoLiFJM2pgcjexzuHNav4UNBMz99EvmGjNpY3zPL/XNfjnw8qqQw15okxtol
         c5jSFSyRd5Puam1A68KRSEN/6TyNdysjtusT3LSQ2Ootm7UKWIg8BNVi7mM45hYipX2z
         i9eL3e6MlF33NNE2Lv5IHqKRXhH9pNZkSM8ftQCsfeu4saBGYxmgfkzoxI79t742xaeP
         mkOA==
X-Gm-Message-State: AJIora/IRNaZl1culRphWHFG8EieeIKFjCGBfn2kEfbAJnmAMLP7MCz+
        FyEdB9gm72T95wX2QV3DVaPTqQ==
X-Google-Smtp-Source: AGRyM1t3gMejbNbAPY5Pp5d2e2dazkxDwrEFj4lIc1gTz2EEKoMCen8+k7gl5W807i6wy0W+Vs4K8A==
X-Received: by 2002:a2e:b894:0:b0:25d:9db3:5160 with SMTP id r20-20020a2eb894000000b0025d9db35160mr482866ljp.25.1658517597181;
        Fri, 22 Jul 2022 12:19:57 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id r23-20020a2e94d7000000b0025d835fe81esm1276897ljh.115.2022.07.22.12.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 12:19:56 -0700 (PDT)
Message-ID: <0974ebc0-8426-c889-b16a-1d35a4e4309e@linaro.org>
Date:   Fri, 22 Jul 2022 21:19:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] dt-bindings: arm: bcm: Refer to the YAML binding for
 MEMC
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220722184138.2666241-1-f.fainelli@gmail.com>
 <20220722184138.2666241-3-f.fainelli@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220722184138.2666241-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 20:41, Florian Fainelli wrote:
> Remove the list of existing compatible strings and prefer to use the
> YAML binding which more complete and up to date.

Ah, so this is partial conversion from TXT? Then please squash it with
previous commit and extend the commit msg.

> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt      | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 


Best regards,
Krzysztof
