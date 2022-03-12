Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB8C4D6E7C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 12:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiCLLkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 06:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiCLLkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 06:40:43 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C2F216A7B;
        Sat, 12 Mar 2022 03:39:38 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id j25so492195edj.11;
        Sat, 12 Mar 2022 03:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=On6v7bBCASSGX7Zr/LqTdopjDgaPfcX0vErsb4IH3p0=;
        b=HfnvI5OaLpsekzL8s2N9q8Tx7isiQ5dEAp4sFcraFrWhdSyghsgYRwR/bfuMb8VOk0
         p9lmF8XqqohOUehqwuSa0peFZWgnvEgBBFXzgQoyWgDQz2GOzWHQyTC9eKVbxKJMyQvt
         UQd+Q74beFI/UAYmvH/GtWIhObja1mcMPBnFZdK8YowfkOjJtTFnpiWBD1L4pQRW/PjP
         ZJr/K6md0DDma9lyluwVWSQaL40G5EPcfq6UrkWQTlyKjBPckCElylpU4XVVJtRglYXX
         87Ji+boBkJATFjHjY2MHLVL2Bg13CAQf5XPVOxAQYhOgT7QUEyJeT2bfcurgZyhgUZLj
         e/NA==
X-Gm-Message-State: AOAM531h+eBLftb5A7SBm+Nh3bvLQmFzU9TP9VsoUMI9sVAFXWMUqwRG
        Do1FVHYdSWtp01M+l+zE9sc=
X-Google-Smtp-Source: ABdhPJzj2+wcTEFUtA3wMh0Yj6TnzVfQuB+HtRm8t+dVVClth3Pwy9vl9wPsrLF3HdW8o0jtX8obIQ==
X-Received: by 2002:a05:6402:4247:b0:416:afdf:806 with SMTP id g7-20020a056402424700b00416afdf0806mr11398317edb.206.1647085176549;
        Sat, 12 Mar 2022 03:39:36 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id o3-20020a17090637c300b006d8631b2935sm4158879ejc.186.2022.03.12.03.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 03:39:35 -0800 (PST)
Message-ID: <46ceccc0-e070-2d62-24ca-7ab6351f013f@kernel.org>
Date:   Sat, 12 Mar 2022 12:39:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] dt-bindings: gnss: Rewrite common bindings in YAML
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220311235119.523374-1-linus.walleij@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220311235119.523374-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2022 00:51, Linus Walleij wrote:
> This rewrites the text-based GNSS common bindings to use
> a YAML schema.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/gnss/gnss-common.yaml | 55 +++++++++++++++++++
>  .../devicetree/bindings/gnss/gnss.txt         | 37 -------------

I see you're updating later sirfstar.txt, but you also have mediatek.txt
referencing old txt file.

>  2 files changed, 55 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gnss/gnss-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/gnss/gnss.txt
> 

With the last gnss.txt reference fixed:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
