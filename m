Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528B14E27F4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348033AbiCUNnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348068AbiCUNm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:42:58 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C669762B3;
        Mon, 21 Mar 2022 06:41:33 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id m26-20020a05600c3b1a00b0038c8b999f58so3129109wms.1;
        Mon, 21 Mar 2022 06:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bgZga+iTgZxl29E6bE+yhoQ9768MdEVBvsBU8JRRDE8=;
        b=aZTXxdgLQuVDgf4AjwHLoWcV+afF3tvoJiLPKLgjrKbtFNkMUyj0LpFyKS7qnHLI6O
         DnPm5LvbTGVQXUQAQZvlCI5u4EjB4S28Mrr+9ZnQ6+/CUrQ0VvNmPlnL/gPPKcpUBBfF
         hW7KyNZmilqgI56U8wc/6yKTE9Clp6mZD3Q9/mHj6AUGJN6WN0jlptQi0kUBmfqlKSt0
         iURWASFPtFmsvPo0xwzUu0vzd67sNKPjXfmnH3w3PBH5VrPn7ZATFqcXpWqag9K9xgNe
         S8FnabyTPs+HAKp19lFGy64/hDyaBc1Kdzcun7dVum+JevH0OkVJ0A5jRYRpzMvgind2
         k12g==
X-Gm-Message-State: AOAM531WV3K2/7kZQgx44MHJipoiNZbHJbDiehp/6R2g/8hOPeBQRcXu
        ZXcEqjcW4wGC/1E01HmbHxVJEIaK174=
X-Google-Smtp-Source: ABdhPJyyMzjTIttlNJGT9aSGuFyu/LU1exiN5s7fn3fPiNcvUU7PK+DZCRuW+H0pR2coizCwfUGpWQ==
X-Received: by 2002:a05:600c:5109:b0:38c:a4ce:ca1d with SMTP id o9-20020a05600c510900b0038ca4ceca1dmr5084171wms.169.1647870091636;
        Mon, 21 Mar 2022 06:41:31 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id c24-20020a7bc018000000b0038a18068cf5sm16635323wmb.15.2022.03.21.06.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 06:41:31 -0700 (PDT)
Message-ID: <c662c6a9-032f-01c0-7605-1e6ff58eaa40@kernel.org>
Date:   Mon, 21 Mar 2022 14:41:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/6] dt-bindings: phy: qcom,qmp: Add SM6350 UFS PHY
 bindings
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220321133318.99406-1-luca.weiss@fairphone.com>
 <20220321133318.99406-3-luca.weiss@fairphone.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321133318.99406-3-luca.weiss@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 14:33, Luca Weiss wrote:
> Document the compatible string for the UFS PHY found in SM6350.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Changes in v2:
> - add second hunk for clock validation
> 
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
