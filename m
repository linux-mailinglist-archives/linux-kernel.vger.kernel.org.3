Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC40515619
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381074AbiD2UvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356882AbiD2UvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:51:06 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EFEAC06D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:47:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bv19so17559893ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=7XFv0enAym+ID9R3vXfpM3vAOvL5k1kdXEpaRFJe1CA=;
        b=FA9Vla0q5kmg3t9U6lDt1g7PjTCHg7wH9SuQqQKoueF53p/pt0lvTacAT7XeT8nbdi
         AAQIGarG8AuhPBmEHDkxDslSITkeNOLXXlPnsqn9bCtMeESkLt6R3dnxhwwghdkVEZCG
         +N7+WB9MdciyoSV4YPFN9Bwy76n7fAdCGs3jBszl8rRYc8AQMUJZzojy7N5gM6Dqjd5H
         FBhSXmiYTmWV4QB/uEuwXwPk6Ms2xmZYsb97BXGwk3+0vgP9N6dIG3bM6h4ExmmgIR42
         6SFqex9GDbPeI7uAXhDTKDT97XqiC+NkLqepQueJwgwDrbx0DF1CrRs2W1idNPJXLIWp
         ZJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7XFv0enAym+ID9R3vXfpM3vAOvL5k1kdXEpaRFJe1CA=;
        b=r6CmnnDd2gzIvOqmw3fkeNgmY1xkr2GLI/T8HD3XFwIVqYhEwuebGqxDIMK5H/UcDC
         28hMMH24hvPapk3NncNtrQU2gv3BXyOcJGCP1kQqJ7LHMIsApjpYzzw0f9qbxMVYLUpD
         JrAQci93B2kFLY/WpyZQC2V03fgeMTl96C/Ts7B/6StZtTKXCty164YrV0mgbBESMtwM
         XgLKewnj5J7DRGE7vf708gS+SSmaT+k8Lz3F+CYVc76mbKGS/eSef/5Wl9J6ZU87PMiq
         Du7gq19VOqHlA9v11dlQhZ5ynMwpT/3Xlk+sVeHXF+fFXsMOLhYRyGxJDq2VJI/1anf+
         ihFw==
X-Gm-Message-State: AOAM533n+SoE18rOvier3ozmBQurxwiKsFf2guQXBQQtujvV0Yo5cq3k
        LX727rr0rB12iVQX6JPfw7l2pw==
X-Google-Smtp-Source: ABdhPJx8NIy7aI2AgyUS6bXRPo7rEIWxGmXm72s/3A6kmrHKRAvH2T0l9dyQDRkC7PwDU+bTGKI8fA==
X-Received: by 2002:a17:906:2ac9:b0:6ce:dc0f:9139 with SMTP id m9-20020a1709062ac900b006cedc0f9139mr1069924eje.206.1651265265461;
        Fri, 29 Apr 2022 13:47:45 -0700 (PDT)
Received: from [192.168.0.176] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ig1-20020a1709072e0100b006f3ef214e7asm961748ejc.224.2022.04.29.13.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 13:47:44 -0700 (PDT)
Message-ID: <791bb7a7-a717-7d86-eca4-3a270e6b3d0f@linaro.org>
Date:   Fri, 29 Apr 2022 22:47:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/6] dt-bindings: mailbox: set correct #clock-cells
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220429114330.59026-1-robimarko@gmail.com>
 <20220429114330.59026-5-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220429114330.59026-5-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 13:43, Robert Marko wrote:
> IPQ6018 and IPQ8074 require #clock-cells to be set to 1 as their APSS
> clock driver provides multiple clock outputs.
> 
> So allow setting 1 as #clock-cells and check that its set to 1 for IPQ6018
> and IPQ8074, check others for 0 as its currently.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  .../mailbox/qcom,apcs-kpss-global.yaml         | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)


With the changes asked by Jassi:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
