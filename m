Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C548651BA9D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349711AbiEEIjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349692AbiEEIjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:39:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B5C12750
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:35:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id be20so4331022edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8kO7QCHGCne68GYXczGxAGiwBY8jMQXd1Ly9yp866KU=;
        b=Tq2Lj5sQBF9LAGbNoqQ2JGXC62P7kgvSvfVs08YDTPHhMEgdxVdBLz6X7JolcE6LtP
         ndphpXlJi0GcCk0hxQ1wjPkH347gEUYF2Rcw/3DTz25oBUdNG2pW3bVGNEweroW8yBEm
         YEwphZeqEWsXhRIEdzsBrDUhlXkqle6I8i5NTrTKeLMGJ1zNrvM1n4Lmggac0rqcOvV8
         lDnCX3V51kzrXd9dtjJMOmh90I/N0tlRBKQFlUmfL0NEbuRRlSQe/vRgCTiZq3/nIRhK
         vF5PcKa0cfY+eJn+n1TqUxKvriO1vb3v4fzFXEaR0pCfpip1LxZrkagACCPABd4iNq1o
         uZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8kO7QCHGCne68GYXczGxAGiwBY8jMQXd1Ly9yp866KU=;
        b=tihGScDH6RCpmgJuZOoYTvIxaJq2rE/x3O+/5SWa2N0lJLCB4fPK2tf3zYStSuOK/n
         cm+gR/or/coDHn+ZA7LI+/jg8QRAo2b/8Dnwrdnd+f5imQ9+VK4f0AcfyG2iWyU8eKBw
         M3DUIRfUWzkYa8S1xpX7W6Vn5dm+AUcnO9Zhih2D2Ov0rkBt/3XfaoP1qXtc2SbCJvYL
         QCt6SPQW6UbFohKUkfwRlvuiGLRWipfCWxKSHr1N0v8z86x3qf8X37xkDEU/VnVpryFj
         dNETyYJK0qXtKT50mozg4dewijNcNjDmqUgpIhE4x/ywxX/KXKA3mVmRIG6FtBmbPmSn
         OK3A==
X-Gm-Message-State: AOAM530ODBrEtTKsBrUChJk1/M7aU84Dt3USunJAz6QM62VI53yZ7VeJ
        JfYOZFITEL6kZXn0NRQhWx1v/dLPCY8fe+LR
X-Google-Smtp-Source: ABdhPJwIqe09rAc0tNzIO2qX2RWAxzun0hwQjzf2mMISopdokDXCWkTsEVXDFrgW7UE7FTAKReYbgg==
X-Received: by 2002:a05:6402:27c9:b0:427:ba7f:6288 with SMTP id c9-20020a05640227c900b00427ba7f6288mr22398071ede.416.1651739722273;
        Thu, 05 May 2022 01:35:22 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b21-20020aa7c915000000b0042617ba6380sm510483edt.10.2022.05.05.01.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 01:35:21 -0700 (PDT)
Message-ID: <ec1afdc4-54be-71cd-1873-6959e132a45d@linaro.org>
Date:   Thu, 5 May 2022 10:35:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/4] dt-bindings: leds: qcom-lpg: Add compatible for
 PM660L LPG block
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220504205704.699500-1-marijn.suijten@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220504205704.699500-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2022 22:57, Marijn Suijten wrote:
> Document the availability of an LPG configuration for the PM660L PMIC in
> the Qualcomm Light Pulse Generator driver.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 1 +

Hmm, there is no such file in next-20220503...


Best regards,
Krzysztof
