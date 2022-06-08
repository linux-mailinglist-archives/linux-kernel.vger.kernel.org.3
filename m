Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120905429A0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiFHIkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiFHIjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:39:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14B4BA9B6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:58:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n10so39841548ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6Q5FdgVP8OZg3GIdsAYNEY53XcA8611Hl5+gVXO7790=;
        b=zs5M0PlpBU5Rj6lc+tLkYZypPtYKTDLqoG/rfhvJL9CckMAyBX+rVUkFz32AhJ/B/P
         qv5MtYuLNGlp3NYHhj63Ue0Z17SIZAuCFqIrpEl5Keoy0fWcxlWGOmDH0++bzcxxb3VD
         Ri8075DQSjzLNjZwsHrT8x3SH7JZ6sHDRSQcJW5SnsIgypZxhT3aoxgdeT0ekYZnEhul
         hCjz6j8BoNAVI2gAxS7D48YlOF5od+8oFa8e1w4ohUzJjaPtD2EqQ+DnExzbWDEnrS7i
         i74zBQKG+Q9VMFAkHsgJm7ftrBPOLMIpGJu67CkLmzOl0Jmk8yaRyfn4FY+NfLQhzeas
         MicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Q5FdgVP8OZg3GIdsAYNEY53XcA8611Hl5+gVXO7790=;
        b=4S835s3naDAZc2x0M0Er5T7VVaFgOvUzoPjGmUmrv6cMmx8OtBW9NKKxxgmtGiLiUk
         bqweUajcVk5lAhr5yGn4X/Zldjxlx/u1xn8nK4qnvEw9/lRs8r7GKJEXUtiZmnFRrlpO
         jyIVXUpHJ8MYoCshra3+HgKlLrkj6x0jtiyodXFKGiaV43W1QsGNYOznymjsqVWIHQrF
         d9z0HCOgjE6xVGTNd5dtXlrlKg7HidwxyoFQDc4XkEEf1rOYEpuoQOhVRJ8lQI2Z3rF1
         OaSrxpYWK2x5CHCRz4NR9tAmiqpAA0E9ABetmpPJVlrY/IMDi2funeBAlxeFMDoH8msf
         nudg==
X-Gm-Message-State: AOAM530MLH3f9yVajGrqa28/gxT/eBFIxfNOvGIvi+ENV00Uyy9fT2Zz
        osSeoY9J5323gqcwNBRkIFxPFg==
X-Google-Smtp-Source: ABdhPJzb/dsRL6rsb5Z4shOLN9Lbi+McEv1tdNHRTqEgCzD+sVevGLREksulT6tWaIIIx587nap+JA==
X-Received: by 2002:a17:906:49d4:b0:6d6:e5ec:9a23 with SMTP id w20-20020a17090649d400b006d6e5ec9a23mr30993322ejv.79.1654675136499;
        Wed, 08 Jun 2022 00:58:56 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y12-20020a170906470c00b00711d0b41bcfsm3584719ejq.0.2022.06.08.00.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 00:58:55 -0700 (PDT)
Message-ID: <543f3e82-9016-9a7e-4533-53ec8d5f0703@linaro.org>
Date:   Wed, 8 Jun 2022 09:58:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/5] dt-bindings: phy: qcom,qmp: Add compatible for
 SC8280XP USB phys
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220607213543.4057620-1-bjorn.andersson@linaro.org>
 <20220607213543.4057620-2-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607213543.4057620-2-bjorn.andersson@linaro.org>
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

On 07/06/2022 23:35, Bjorn Andersson wrote:
> The SC8280XP platform has a pair of 5nm USB3 UNI phys and a pair of
> 5nm USB4/3/DP combo PHYs, add a compatible for these.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
