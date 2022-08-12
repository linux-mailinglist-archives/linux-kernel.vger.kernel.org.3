Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E7C590F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbiHLKRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbiHLKRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:17:13 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D747A723F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:17:12 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z20so509859ljq.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 03:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3EuQ0CN8gezdE1pLa5bohB3s+q1EfiKeLKioA/7ZW00=;
        b=WKYYtNr/fa3IFP/Or/737fG9GGEhxZxmhu02n1Q9c4HHLYb2q91fSOrxynDFym8xVb
         n9oL8meW0KxtjHKtbLCvJSHd2xOGiFTFkm1+rN57utNFwMCRa2ydVYDIf0L9k9t27Im0
         McpJFKCy9D3tWMGYDQOcT/BIFHhMF8sa2ET0rm0zKWJrNvKPeezxtIwRFAq+rFfqR0Hy
         vLzV811iUKC1/ZwKmTjtdw0JkuUbvvQyyMhgSksbtLEIt1OgSr96xDbwYcXY3Cf9YjMJ
         ql/MHAatWTLbVitN5uoVKW5iDWluTxIEiMB0iEZh1790XvR+9Xkx1dGI1Kq39m7GlSz3
         qkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3EuQ0CN8gezdE1pLa5bohB3s+q1EfiKeLKioA/7ZW00=;
        b=hMUABExQEwfba9Hk71qkUwMycMTlZpKsIhAydiEKaxf5z6IXFaCSHmfQq06Gchfhs8
         YmVATUmlbslRROaisSby8NPo0v/W3tSMNBW2oP3vL1CJw2ADiz950b7FD2DgEuCdI2tv
         Qo1FDHoV/AjRER7iFQ7D0duokC/gURQI7U1fqveePKWYOrNPw/lwufgi6vWtMUrxhAnM
         pCkQWcSJPM+wWWrLsZUF2gCasE4Pya5RH9zCSsMmi88ka3aUf3IvO40UMsInBxNYVlmK
         pWf28TvHlDZTLBf/bOrr7tLvZq4qD61bQ/NTPw4JDDbj/+mEsbR/C3BphBwA6zBOsuA6
         KPoA==
X-Gm-Message-State: ACgBeo3rEYlykq8qhsLz+Kgcuw6CPW24a1ITZ6c27s7Y9oh0YJaypI+r
        S/juN0uumCCQIugBarzkjigroA==
X-Google-Smtp-Source: AA6agR6/eKxyf9cCc2YXWWqIL4n4jU5prTkHu2Rbp6sqmc8P5deaTbYdRI6xrB/8qoK93hfORnbFow==
X-Received: by 2002:a05:651c:1544:b0:25f:5036:ece2 with SMTP id y4-20020a05651c154400b0025f5036ece2mr1022900ljp.73.1660299430454;
        Fri, 12 Aug 2022 03:17:10 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id h18-20020ac24d32000000b0048b304d2a75sm156644lfk.292.2022.08.12.03.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 03:17:10 -0700 (PDT)
Message-ID: <0ce8b731-6cbb-ee3d-0075-b24332deceae@linaro.org>
Date:   Fri, 12 Aug 2022 13:17:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 4/4] dt-bindings: soc: qcom: stats: Document SDM845
 compatible
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Maulik Shah <quic_mkshah@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220812101240.1869605-1-abel.vesa@linaro.org>
 <20220812101240.1869605-4-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220812101240.1869605-4-abel.vesa@linaro.org>
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

On 12/08/2022 13:12, Abel Vesa wrote:
> SDM845 is a special case compared to the other platforms that use RPMh
> stats, since it only has 2 stats (aosd and cxsd), while the others have
> a 3rd one (ddr).
> 
> So in order for the driver to use the dedicated stats config, we added
> the SDM845 dedicated compatible, which we document here.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
