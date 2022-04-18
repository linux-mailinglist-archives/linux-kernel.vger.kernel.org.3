Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE817504FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbiDRMMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiDRMMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:12:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4018B7D4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:09:34 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 11so12212166edw.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SSv/kGw/sPtJ7xffy1Sqnr1P6e8jX6vTWYRNPrJXy+E=;
        b=jl0s2qu3zHzXOOG/XXwBXtdHcq+UyIspnmNveiot9OMZOHyKn4v4BKCOQKD3pkrCK0
         eum9+ZF1+q8e+Rrh7RG1F2HOY0m66DpMB1sr8Yt+ut9a6x0bspNKX5HFWjOpW56YSIri
         oU8+DwbzF8UOaGf3e2FPU4nd6+15wc5vAyCsFKnTQnDNhqLq6wPTDO71rtAMHGmrP8WS
         ICxFiFLJ1Qwsh/Ugwo4zoH3CQl5Iw2J2Ro5IfC/VlHP33UwCBg1/0lWX6CsGMidiKZtV
         c/bcNDX7ErJz2rvQkBkpQxtATla7/1mh6xTifwt7S8mONzxQ5IyJuBuFDgF/FIDHEQL3
         bfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SSv/kGw/sPtJ7xffy1Sqnr1P6e8jX6vTWYRNPrJXy+E=;
        b=h4TDpuXKdBjEUdhjlOl22aWZt56Wj1fVGCRX6vyi2BiduZFgXS+d/Lhn7z403qm7ua
         ry11Be6/w0Vv4dkVWZQyEMJMRE6bHBJw+iTLRAdRuWKUR8Lks59It4o0TnbV9HfZa8Ph
         5sWjUIaTyjMkQrMbIU0AXyNiU95DlKoA4rnFYeTEP0X1vtKvsM2Kzu+Q97AtHWmqHGgA
         S2C9f3vXrwVDyGL4dFJ5z5qhFiwuiDjAqoBJ+zo37AkzMcOfEicjAk2QRMirmLRMihyk
         HG7NIlOnXrg/aHIFwthgMNOa+tx5rZibVgKB9ta9Dtw7gsbwCVKcdQc+CukkPOdP4mgf
         N3mw==
X-Gm-Message-State: AOAM5336C37j2XjLiqEgkAVZ4mXpJSIj0Pf3fvELVK3SvAEq79eZsguB
        KnbY9qGECZVOhwLo3IMXeRBjyQ==
X-Google-Smtp-Source: ABdhPJwA8yjnwIzDfarUC+vVVrE8aSLrawiRP6weL99Jh6WKXgbp7zK0u3Ij8+I1lNxfhsABKRUrJg==
X-Received: by 2002:aa7:ccd0:0:b0:41d:70e5:b87f with SMTP id y16-20020aa7ccd0000000b0041d70e5b87fmr11607725edt.20.1650283773577;
        Mon, 18 Apr 2022 05:09:33 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u26-20020a17090626da00b006e7cb663277sm4541728ejc.90.2022.04.18.05.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 05:09:33 -0700 (PDT)
Message-ID: <f419829d-87f7-17ff-50ce-fd3628df71fe@linaro.org>
Date:   Mon, 18 Apr 2022 14:09:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/5] dt-bindings: clock: add binding for MA35D1 clock
 controller
Content-Language: en-US
To:     Jacky Huang <ychuang3@nuvoton.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ychuang570808@gmail.com
Cc:     robh+dt@kernel.org, sboyd@kernel.org, krzk+dt@kernel.org,
        arnd@arndb.de, olof@lixom.net, will@kernel.org, soc@kernel.org,
        cfli0@nuvoton.com
References: <20220418082738.11301-1-ychuang3@nuvoton.com>
 <20220418082738.11301-2-ychuang3@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220418082738.11301-2-ychuang3@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2022 10:27, Jacky Huang wrote:
> Add the dt-bindings header for Nuvoton MA35D1, that gets shared
> between the clock controller and clock references in the dts.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
