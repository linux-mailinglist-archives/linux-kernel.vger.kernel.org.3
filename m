Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105D75747BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiGNJHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbiGNJHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:07:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A05F32B91
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:07:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bp17so1764269lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O1fNejxW8S6H3wv5VBDx0d1TMHYJMe9L7no5jLI+Oyg=;
        b=FIWHDEbpdoMv9foYW/B/ZPtig8wu4pEhkSnJzoI/DZjVzJm5Uk9JRPlHQyfSJ2FnJA
         jninjZNbhOXQGhuMabXHpPHWKh5WR9VGTUzQsCXD217MLSYM8KOp7AzJrWAtjPvMBaJv
         avXKmhbuigxPKdiIk4Tb1PpAOm6WUX6kh9qL7QgTiyWMGcD99QWRxcagakI6e2hcMPqg
         YAb0ne9PlQ6egBsDjGsQtTWy+c8CNQR4Sa07dV4VxFBcEMu53wKzCNKLK3xJOzVqX2uc
         s+aFlE5Ek/avWAy47EsyUg114ufEFE9i0BADRMpZ1jvB0iu69NxoNNIPnrYytfdW4yRz
         7WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O1fNejxW8S6H3wv5VBDx0d1TMHYJMe9L7no5jLI+Oyg=;
        b=wU1EaYPg2hlNCZzGuD3AYyB4eu2LkPIjgHph7jgtJZAXuIVbi7hybgekbN9CDiVUVs
         SpEZIz7AfrvTka0THFurOxcKBr9AbHS6eIYFysPa2sdtl47bBiz/dzSH0HkVxtj/iGPb
         LKlcihT2+D6USwBdEsR9tlN2kG4acAr2JyWswcfpM3YRcT50aC4mHPTkiAWuOskgJ2wZ
         qdxbehIagiVWa1A2OrWR/3nLo647h1DectkDTr/RGNRI0fn8lx7PH2grX7Mep4K+ivSh
         tkxr2Jx5ZrsH411bQrsgKEJw2yOxNqTcFGfEl8lvCNaCNeINJoot1/ADcH+Voh7r3tUV
         HmDg==
X-Gm-Message-State: AJIora87ykUK1TR/jcUzOVmpVDeaznPLJ5ecZ0pwmtiFjYsC1zUNht9B
        VLNrvvrNRFi4nOm7AW17GoPnsA==
X-Google-Smtp-Source: AGRyM1vtx0KI4Lf85fLv2hVsyciC0HjRj8ejjNeCKGSnn+E/6D2Cog8AfiXPRY1s3r32AKC7+faa2g==
X-Received: by 2002:a05:6512:3b29:b0:489:f0ad:1d18 with SMTP id f41-20020a0565123b2900b00489f0ad1d18mr4710485lfv.3.1657789658590;
        Thu, 14 Jul 2022 02:07:38 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id a27-20020a2eb55b000000b0025d5b505df1sm173151ljn.136.2022.07.14.02.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 02:07:37 -0700 (PDT)
Message-ID: <b1d14a58-5f7e-f013-4f80-c63d3f1951f2@linaro.org>
Date:   Thu, 14 Jul 2022 11:07:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 04/30] dt-bindings: phy: qcom,qmp: fix child node
 description
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220707134725.3512-1-johan+linaro@kernel.org>
 <20220707134725.3512-5-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707134725.3512-5-johan+linaro@kernel.org>
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

On 07/07/2022 15:46, Johan Hovold wrote:
> Fix the incorrect description of the child nodes which claimed that one
> node is required per lane rather than per PHY.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 4 +---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
