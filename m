Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DF450F1F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343759AbiDZHQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242040AbiDZHQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:16:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80133A730
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:13:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y3so13778435ejo.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=796okj7fUhfEo6Z+Bxk5e2KE1IFo6Dc7db5MBQ6gCi4=;
        b=Xg8xaGl3qOynNGE6l19Z5REqd7o4IHyJY6pnHNqA2NQsZ4xuKKdM1MOZnQkyw5w+VL
         uY9s5qBh0MgEdIl6r8Yf0gT9CeJpbE4TX73rynqCDd7GkJBn5mhNSyDDHlH4B0qoXJCw
         SHZFY47RNajDkrMT+nMKMGyjSNdEg1lJ7Iun3uHI0FfbdgbQpXn7tZrCTC5VDWguNnGY
         Cv4Kms5dcMhE0XTNVOEN1OYATjIVXwBS0Zc8qsFuuIgal5KQHmx9yrWxDSQbXwbXPGBF
         /gI3vMXFNJrnUlR3CxzLcvIOswGFemjF+HqCsOBWXAomC1nyc00/T4tB4Oedxl77m/w4
         IDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=796okj7fUhfEo6Z+Bxk5e2KE1IFo6Dc7db5MBQ6gCi4=;
        b=SEj6suweht0gQ/gCHtP3PGuDoVZMCCw544CySvmYYwU+kkYnjc2h4GcdBpQKzv4WC8
         kNIE1tDq0o0xaP2xNKHDguqhvpUw3fAhT8p0qXT9pUCbRfNudV4/juHyrsDzuZD8RumB
         CQQD9k1TY8ckiIG7TxZ2KKuvewomlAVjwjzBBkEsVW2Gae6i4BzGQh2GKk42EShQIc5f
         5+ECqjVspE2J9WkaLnZ4dFBEU+uo3m2jGXHEKCmqJXLiznVhdQFDGvevOZEEMLhy4jK9
         DROI7PmYG4TBROK8sywlIlZ8aQWniL9qbmSIQ8hQyMDbJWYHLlR08vkh4SQrCsGicBRs
         2Gbg==
X-Gm-Message-State: AOAM531Jw0bGAvRwy648rCOsuOub+vw8o1x1el6ALGy/+fDJ2+C3dRrT
        1h/MPXhawMHnRw9Z2vn6Xipvog==
X-Google-Smtp-Source: ABdhPJzX1cqLrcHhd4KQ3AKjehHP29V8LYMhJeuJd1XE420U3ovR0yd62G4tmz9dpqk/GrepN+5mwg==
X-Received: by 2002:a17:907:c243:b0:6f3:953d:6e2 with SMTP id tj3-20020a170907c24300b006f3953d06e2mr8363720ejc.506.1650957209401;
        Tue, 26 Apr 2022 00:13:29 -0700 (PDT)
Received: from [192.168.0.244] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170907774500b006e1382b8192sm4499892ejc.147.2022.04.26.00.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 00:13:28 -0700 (PDT)
Message-ID: <ebdc9fe8-f54c-9b11-a167-54219b124cde@linaro.org>
Date:   Tue, 26 Apr 2022 09:13:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 24/33] dt-bindings: crypto: convert rockchip-crypto to
 YAML
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, heiko@sntech.de,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20220425202119.3566743-1-clabbe@baylibre.com>
 <20220425202119.3566743-25-clabbe@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220425202119.3566743-25-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 22:21, Corentin Labbe wrote:
> Convert rockchip-crypto to YAML.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
