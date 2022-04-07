Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719624F7865
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242484AbiDGH6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbiDGH6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:58:15 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A7524BDE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:56:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qh7so9033662ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 00:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6WVPzKa/oVSlY6ElApmVDHPgbstzzKBIJ8ZBSGYPUNI=;
        b=Bj8U5eCDAIDu0L5hyu3KEs6U6RpCe1XAprdw8cbYuwKLMScU8eUlTzgA/QkrR28zzs
         BSoZwd5cDihHE8xqLqS5+3fKf2ZToq2sT8fywPitz4yVNC1ZexjA4Kvp84C5s0sxCKcz
         6AQ4XVMjBX1qdrfAVVSq+IV19Gqyzf0RgEdoUnaWylNOIwEJQ2HwWNa22u9sG2E2f7Rn
         ofTGgB9m9GSl2IvlW+4htIveFVtfb1nvSzwfzn8W+t8EaO+G0xf0Vsi36EejXf36F/Lj
         picDldHzISN5NBnrqIBB1Rct70iUZj709NEB/ONHDD6id0DuoXQyvy630AUWtqQJzujU
         BBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6WVPzKa/oVSlY6ElApmVDHPgbstzzKBIJ8ZBSGYPUNI=;
        b=ct/+6Vq9mjk9cAdaekIrmFSLTpT4UvL5rkZvFStyk9vQqqY84rqrgomLD9NF7EncUW
         Epq3NYoyaEoDCVqH6+4HAvFB8B1RODCuISG4xqTT52LzmxVCUWbggglS06css9pnV7/d
         7+r48AnCUxZwtaJ/i8emJJoXifG0ixIBcxat5UDIV5hp4O/9EMfn161rDK/Q2shKq4wG
         EX51qJgekBcwkLq82TuXMZzuwO8V6h0u068+FDBpXEO4x+CMHQaZl361Ld0bm4tJPls1
         XfMJFSBfh0ZzAN/vT4Px/AoK1c5wmEqm2ncEo2jFJ4DLEwl+7o13a+KMfF8mPt6rfJvZ
         WV+A==
X-Gm-Message-State: AOAM533sDEZ/5sLnEqgYbwC96rzXde7tGGnnuyWT1/y47JVFELtcL7Jb
        VRIf6izkCh8mmpZ56pcDk99i6w==
X-Google-Smtp-Source: ABdhPJyfkGckurrNepv72gk9ruBCms6U9TvOyrtxxR81N7ay+ksnAyIXhy330FBRomO7hIbsVQMN6A==
X-Received: by 2002:a17:906:f85:b0:6d6:e97b:d276 with SMTP id q5-20020a1709060f8500b006d6e97bd276mr11809288ejj.431.1649318174105;
        Thu, 07 Apr 2022 00:56:14 -0700 (PDT)
Received: from [192.168.0.185] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id qk30-20020a1709077f9e00b006dfae33d969sm7409359ejc.216.2022.04.07.00.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 00:56:13 -0700 (PDT)
Message-ID: <04b5c481-8801-7d56-54ad-beb10bba07d2@linaro.org>
Date:   Thu, 7 Apr 2022 09:56:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/4] dt-bindings: timer: Add am6 compatible for ti-timer
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20220407071006.37031-1-tony@atomide.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407071006.37031-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 09:10, Tony Lindgren wrote:
> Document the dual-mode timers available on am6.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  Documentation/devicetree/bindings/timer/ti,timer.txt | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
