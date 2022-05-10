Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E77521210
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbiEJKYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239776AbiEJKYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:24:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1AD2AC6C4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:20:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y21so19420939edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=JAZE3H1GU49hxfnZj4dz1ADpHTYQaP7poHbZZaWlb9w=;
        b=oFt8LN2qwiQkvu709/jiLgEfOL/3nzC2iBaYdt8tOvH9kklDtTP27FTQHV1j1S3rjv
         qD3Fs2qCNq6/oAuSU2uPmPGEMfNlOIAyCUNvnVVUf+BcF6+/cMTOEb78zPx11iQUAmjG
         AyovrymATAnM7csnf3914u9kFxc4/gJGK0lUPATCMspFYwyr42bQiLTCZWnE49jmnVgC
         4nzzPDDBRh1CKW76njeVzbnpbgyn4ltb04FJ/Y0pb4wpvN01ly5AAOVVQQ5AnvIEFKJE
         /+Jlv0d6fNft5WiDK82GYzetMg5EGbd7CmSttsx0EPxz+dGnj6su6blz+AVtoclmJZ8K
         uioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JAZE3H1GU49hxfnZj4dz1ADpHTYQaP7poHbZZaWlb9w=;
        b=L0nPYK2H/abp27o1pzqZ220irzjCZ4vZuQDfqydS5ujgPyk185g/PWlVP2Xh5PRGyi
         PVt1U5qlfj9B4HZD2gPAdZvXLfC+KlE3fUqkHGO4NW7FrxYAWreXp4iy3OTPdNIEOmkJ
         L728AAJ9di0xehFDIabrfGrt8jCAgN+Tbdc2NQjE09erH3hD00/0WqenbPRFeZRvMyYX
         sgM7t1mnArsJVuG+Xfhjqbljywe++cy108YkiaAK7E6Gu15a1bOINPmx909rDoJvCG9i
         e8DBegWIC8diZSXRsG+ofjhHwIv3iS8DHwPPwOqhkvWIuonVczk2u6O4ZWxDiSUSuhyU
         cN9g==
X-Gm-Message-State: AOAM530Gra0kWCmS4d7YzPGo56MSavJBWcdYsKNQH050pMAMs17sjwh5
        FyQu6y3+TpcZcWLEW79G/U1IdA==
X-Google-Smtp-Source: ABdhPJyvoiZDTo7gRyxxJWEXPyfVnVOhX62o9dqmOeexsQlrnzElSpHIuaxfkyFT8WV64l8lsEXooA==
X-Received: by 2002:a05:6402:2692:b0:427:ddba:d811 with SMTP id w18-20020a056402269200b00427ddbad811mr21982456edd.343.1652178014773;
        Tue, 10 May 2022 03:20:14 -0700 (PDT)
Received: from [192.168.0.251] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d29-20020a50cd5d000000b0042617ba6391sm7403282edj.27.2022.05.10.03.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 03:20:14 -0700 (PDT)
Message-ID: <ea77c9a5-107d-dd4b-a87f-5b62d01c51d0@linaro.org>
Date:   Tue, 10 May 2022 12:20:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] dt-bindings: vendor-prefixes: add Methode Electronics
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        shawnguo@kernel.org, linus.walleij@linaro.org, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pali@kernel.org,
        marek.behun@nic.cz
References: <20220509110028.144226-1-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220509110028.144226-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2022 13:00, Robert Marko wrote:
> Add vendor prefix for Methode Electronics, Inc. (https://www.methode.com)
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
