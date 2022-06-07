Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1DA53FE2E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbiFGL5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243281AbiFGL5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:57:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CEABA1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 04:57:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h19so22701518edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 04:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Sv7ySlJYlyYKUpAcQrKFFpWkB9BOyCw7FGbzXDHtuOg=;
        b=GDFtLI6TiFEB9XBEeWMrxN9/h3S8Vk+tbhLh89pDqWQV8nukxDjJGCz5R+5qf7Iusb
         3C2DUlq5KeVLPq35U1+yTj34Ry49hjaFJ4fDn6pJFKZpzraPxS3GzDUute3X1V6jiWCv
         HeOjJGObw7cB0Gv8dtIYgpP63hDfp1Hnr5w110otrGGPA4Fx2bctY6Rj12MvanBRhryq
         H63YeWzmEQ0Kbe+JtNleE1M7eFaCWBoW/T2ZukS2sTwLlHvIla32rDsFKHUv4wN98vFp
         uVIP8CMwseBiu0nRlFv/watH7oTZmbq5d828E71IxAz6TN3XucT3RkCkfIcX1kWr6nim
         ZoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sv7ySlJYlyYKUpAcQrKFFpWkB9BOyCw7FGbzXDHtuOg=;
        b=WhJJN0yUp7Zu5+wSONHyhG8yjdy8OIhe3GWSi28pBWmLLIahZPIlkmWvTMj4zMC+qJ
         rkghmtb5Jr9wuoG+kagVi1hTols80LCFxxkFqFM5Ztz8V/Obgd5hvOOrZNQ8ZzRNuyIH
         R49rpVEQEj7p0lTc2ThUnDNLBZXPrr3H3xU3bgfY5halhWgf6pCvJXLYrsq59MZIRoxg
         B5TuTw9KWxCS6FQK7tAwXSkoBXc/AoRo+eGD8pmeiq9CUC5UDe+BZVOOjk/iJzLI8Nw7
         g30VO7ar0ROwqeqRmof1Iz8PhZorvEGxME5JzDkoVlY8kgQy6XEwEVoEEl+1bSvmtGMS
         JmdA==
X-Gm-Message-State: AOAM533FRF70gzvr/dJamO5rnfHqCr4aeh9cXqu1Mtc/s6iqDV2B42LQ
        +nEG183URTQepo7/ROEBPWHyJg==
X-Google-Smtp-Source: ABdhPJziqHi5ZgWy6/fdz2QXIjy2GgumEbw1uZDzUdvopDa4v/ubEVhpR/dJQNdOKQbLirBbEaT7pg==
X-Received: by 2002:a05:6402:3482:b0:42d:e063:7c1d with SMTP id v2-20020a056402348200b0042de0637c1dmr32989224edc.40.1654603031110;
        Tue, 07 Jun 2022 04:57:11 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g9-20020aa7c849000000b0042a2d9af0f8sm10036993edt.79.2022.06.07.04.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 04:57:10 -0700 (PDT)
Message-ID: <99398f9a-0516-eabf-62f5-e6f286679657@linaro.org>
Date:   Tue, 7 Jun 2022 13:57:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v17 02/10] dt-bindings: reset: Add bindings for SP7021
 reset driver
Content-Language: en-US
To:     Qin Jian <qinjian@cqplus1.com>, sboyd@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, linux@armlinux.org.uk, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1654565776.git.qinjian@cqplus1.com>
 <9f0b7682ae5f4c29686304db8bf0e15417706115.1654565776.git.qinjian@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9f0b7682ae5f4c29686304db8bf0e15417706115.1654565776.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 03:58, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 reset driver bindings.
> 
> Reviewed-by: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>

Wrong addresses...


Best regards,
Krzysztof
