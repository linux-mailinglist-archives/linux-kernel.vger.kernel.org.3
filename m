Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2701C4FE041
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350993AbiDLMg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348150AbiDLMf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:35:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC98344D2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:54:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r13so36852535ejd.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6udN7p84mQQbGIPlPrTSL/PLuG+dh1guReUObCKNXP8=;
        b=DpJ5xce5z1oKLNoQI5H77n+qFkrR2trfG6eiMK3QQPicwsTlh1LbOMYrgQK2Jwkdwj
         LK4vOsQSTqEtifdm6tfTeWzv5O6laFEG0jqXYJI8aqW9qc8WznM4Wh4ljvA2WY057Y2X
         BOGQY5uI3BLeoeBOdfi3C/KNrD9lwiHjVqr88X5WIDgjNizuqzL4SvOf5YrNCrawGh8A
         sXIlPr21fu2tSAT5DJoGwj0mpoVZPaVDZ20xJ6aJQ94w8uMTA94CkuyR12nglFQ5Ks7w
         RaEhnkEIVS+j23IO68YdoptMq+MMdR6wiU1zJDTfHdQgmNoaxVKVcknvT8kKsjeHBk2v
         d0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6udN7p84mQQbGIPlPrTSL/PLuG+dh1guReUObCKNXP8=;
        b=piU4JRnUK2wZDXU87nCNIimJnGhS2887l8Fo0Gz8v0E5V2QF6TquS1lT/T6DULKgU9
         fSxQ660M+GQ8r/x3QKRnbw1/gTyupF5c9QoYwCQsXLBrGN0oo+obOB5sIxiGl7FCbfG8
         XRHYBvxKrqA75Xn+bmZiaTTQfVpnLzss75aS65QdrYsT7F6F7EHQZwhIageUU/EBa4gj
         I+v7bnGHc2a7X8OyA1Msar3c72r7bV7NqWJKk8nfdz/NGkGhhK5u8s2HdGvEOnglke0U
         P3stReFYigM0B7JG81qEytXo+bFKDRDSDpcJT/vhtdNsA0qPoquH0gezRTwQ4evfQOXQ
         kQaw==
X-Gm-Message-State: AOAM5333wO5U6X+gC+pGjnsmeeKYo6u8iKhAtCH2ilm/tAR9CSph55p+
        +gYUohrmGxZeskv/XmnaMqdnZA==
X-Google-Smtp-Source: ABdhPJyJhJm8ZVPk7tw6VD+la4hCwdTsmQiQ9k85Y+ogd6oPi0J+6g0dtxAMCcJdiZDIn+K32a4jtw==
X-Received: by 2002:a17:907:1b1b:b0:6e4:7fac:6ce0 with SMTP id mp27-20020a1709071b1b00b006e47fac6ce0mr34100414ejc.617.1649764485066;
        Tue, 12 Apr 2022 04:54:45 -0700 (PDT)
Received: from [192.168.0.195] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id u4-20020aa7db84000000b004136c2c357csm16632865edt.70.2022.04.12.04.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 04:54:44 -0700 (PDT)
Message-ID: <1b0c00bd-de0e-3096-556d-4d944e5d9b00@linaro.org>
Date:   Tue, 12 Apr 2022 13:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/7] dt-bindings: arm-smmu: Add binding for SDX65 SMMU
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <1649670615-21268-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649670615-21268-5-git-send-email-quic_rohiagar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1649670615-21268-5-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 11:50, Rohit Agarwal wrote:
> Add devicetree binding for Qualcomm SDX65 SMMU.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
