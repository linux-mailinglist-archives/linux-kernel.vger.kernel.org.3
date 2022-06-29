Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FCE55FD72
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiF2KhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiF2KhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:37:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050F83E0D3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:37:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ge10so31682833ejb.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2PLSan2OyFD3C0VPj63Fz6myEBk+Vbaa6VJQ9ANnEas=;
        b=UxJo9ozF3/CeGKF2ChdoWPqjX9OKm5SFdmD8/EoepDqf7UQl2ec7izk1OEqrHFoEo1
         s3/Q53xmmjqy5Us+xtJNOMHKDpgXCX12otf3IHHsa+dFg3ZqQAC6mrQpFYcVF8cJyL4T
         AgRBj4L1NpgDM2455cVdYmzAEt3zZ4QGVTyhubnvtLkssy8k+Q8WNc6BuUhsctBFZw49
         mfvstZazL0mgdJ7ItiwF4cGddIl/4bEDS4lF7cZ2VYqRvqldJiywqEN9A/tCTsdrTl6S
         yXzqa+Tyjp4Y9E95tCefWDwIRWJRrIJfe40PIzRH5SpcuPK9UvS/XcRk5JpDpTKY+Bqn
         HCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2PLSan2OyFD3C0VPj63Fz6myEBk+Vbaa6VJQ9ANnEas=;
        b=2dWkEyaAXsZ2t6Mf6eUTJgeJybZc0B0rLBypUJBJRABe6lcjiK7uN6I68DTtp2yDWn
         0+SxjlOi3htn8TON10kuoZ8HZ9quItYXKifbQF4/lKZ6qFxJkkZ0k6cNLsU2y7z18O8R
         UBJg0Sx9l/zghvrq1hOnnjlMdMkJdmdP56EJYgjuqM7Q2P8/XdqaPGTtEC3nNPTBJBwR
         zTaBhbSteeezTGWBf+16+WbQafnNnqCAd7pg/Gg/h2XDQW/ci1yJ8PJy1sF9WufKmsG0
         luYvqiUjzpJLIOhU+0IwgnBa43SkuSVf4REYadWRuOxwof6R0634bVG9q3g8oFc0KO2E
         0opQ==
X-Gm-Message-State: AJIora8GY4lATPYPYowZZ7U593QKtXPUWB5/j4WS5j3VySumQtQM9CR2
        C7tEeE0DBVxZzBDzXdrrEYIyHg==
X-Google-Smtp-Source: AGRyM1vgCuE18ifvWqla2d2oJ85tPHHMpN/mhtzcqDs24N5WbM2ExYJwWvf9GA8LS68pv2VM3WsGXA==
X-Received: by 2002:a17:907:2d8a:b0:722:e35b:695 with SMTP id gt10-20020a1709072d8a00b00722e35b0695mr2646070ejc.470.1656499036586;
        Wed, 29 Jun 2022 03:37:16 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o16-20020aa7d3d0000000b00437ce7fe1a0sm1244540edr.8.2022.06.29.03.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 03:37:16 -0700 (PDT)
Message-ID: <8b7ff51e-40ae-cefb-3df6-74abd33f277f@linaro.org>
Date:   Wed, 29 Jun 2022 12:37:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] docs: dt: writing-bindings: Update URL to DT schemas
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220627223950.35748-1-paul@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220627223950.35748-1-paul@crapouillou.net>
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

On 28/06/2022 00:39, Paul Cercueil wrote:
> The previous URL was giving a 404 error.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/writing-bindings.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
