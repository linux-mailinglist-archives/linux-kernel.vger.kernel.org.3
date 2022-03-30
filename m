Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBD64ECADB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349397AbiC3Rjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349342AbiC3Rhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:37:55 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B56B2455
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:36:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c62so25298914edf.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=P0lhRYqIYHGnqARHlbaTecne6PqtYS3ApwLgK/2XwFE=;
        b=F0sGniSa0e3/ySC5seVvyWchRUmignbiVoD+HBv6twtokEpP9am/Yft6GaxjUChWou
         749bGqYuA2gJXs8VexbXmvXq4KFbuT4QCWfV5a9D6eg5Py7vHNv7NJE41qMCYlVhcHS7
         HWnCE/jAIadBYDCqwhWsWNILukF1NQWtahAgg8xz4dNG+IgUBfZIVOdwcA2NZZV+tWtR
         xccD3tb8ErS9bJPrKtg03GoqIAEPNisNE3G1HdIWKttFTGKSEFIgLbt9xZYDbA4RFmMJ
         mWEQ0p8CMv26D+wHOG/1xOGNIh6avvRvYGDK3IOai2M4ilmrucL2fiNhVaFTS4b0EaEt
         j3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P0lhRYqIYHGnqARHlbaTecne6PqtYS3ApwLgK/2XwFE=;
        b=hZ2yBELqVBjuGWBHp353XQKhRoJrDkrZT1ahNZjZ6yCW3MWzLnpvx5zDIjSwmk0/g8
         WK1/PRcBF+pLzSWnMUNQUEi7gIt3S6BnrOwVLw7AWx4V3xxJN4elyZAbGgjFb6CfGpwG
         iXCe5oi/V8qSb/yzCxBqA+TYklKJhE7ErL6qsi7nbmEKSbWXJ6fBoneYqp9AQJtS7A1c
         r6bU0P6C+tO+Gi5459zjOnLSwqG34z1qRyknEz9WBGS6BZQ2L5qOR2p+zvx6fP2yExp/
         4cOAff6BkRcjLMt+fOycyQBJNGUrgLtBV3F/mi3+YBFY/xdHYC6wn2+R3VUjT2Su+ywQ
         A3Nw==
X-Gm-Message-State: AOAM530K+jy87lgZa6rcBFcZ+zR73MMTTVCD1lOCYEWFaZDV/tVsJbfI
        hfEhHI+Ck4Gg2fnY0XQsa637Qw==
X-Google-Smtp-Source: ABdhPJzzS6mJXsdB1TnJ8Wxj6Cjbytd4HW4FXqKXVrVOrnjLhVf6H3Z00F4HQGpUlP1DJsJsocX/bQ==
X-Received: by 2002:aa7:d751:0:b0:419:2558:a78b with SMTP id a17-20020aa7d751000000b004192558a78bmr12099524eds.6.1648661768505;
        Wed, 30 Mar 2022 10:36:08 -0700 (PDT)
Received: from [192.168.0.164] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id jg22-20020a170907971600b006df9ff416ccsm8261364ejc.137.2022.03.30.10.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 10:36:08 -0700 (PDT)
Message-ID: <9e9b4cda-e2e9-98ab-2239-2dc2d8f29440@linaro.org>
Date:   Wed, 30 Mar 2022 19:36:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: power: renesas,apmu: Fix cpus property
 limits
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <9ece1a07bbcb95abc9d80e6a6ecc95806a294a11.1648645279.git.geert+renesas@glider.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9ece1a07bbcb95abc9d80e6a6ecc95806a294a11.1648645279.git.geert+renesas@glider.be>
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

On 30/03/2022 15:04, Geert Uytterhoeven wrote:
> "make dtbs_check":
> 
>     arch/arm/boot/dts/r8a7791-koelsch.dtb: apmu@e6152000: cpus:0: [6, 7] is too long
> 	    From schema: Documentation/devicetree/bindings/power/renesas,apmu.yaml
> 
> Correct the minimum and maximum number of CPUs controlled by a single
> APMU instance.
> 
> Fixes: 39bd2b6a3783b899 ("dt-bindings: Improve phandle-array schemas")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/power/renesas,apmu.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
