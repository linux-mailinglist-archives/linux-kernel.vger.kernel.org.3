Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C834542E3A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbiFHKrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbiFHKrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:47:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979C51A075A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:46:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id fu3so39133135ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 03:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kxxPcF76WWN/bWnsxK2DKATJ83o8YOzutN3QwQabAvk=;
        b=AKYpBbLxmIIqjiTE99uFutcfHAcbNyniUdakftQJgPfpt4iBgGSHol/DU+weHn3QvL
         pB9PTWj4/GuHnFQXFi5qwTqYBhd25yz+bYlqa7sK8esg1044/9XVRvzOU6I+S3WBA6ZN
         vHQ+jGvmGK3DrPWZnxls5oqYBmRaUbuYJ6STAu9FEXTPqlrNLEmnUX+Up6rMx9ohSqcv
         wSDpLCiElrGd4019hbcwPewCE+/iffIRmLZuQNJ9PlYCXwnYdb+iG7XF3ChJrFEkAzM0
         QLYs07A33UWv1+wXAMUI6e+KMjEaKp/aERemW8qgljHxbGsl6dkDakLGbyvdPJJP+iQk
         e8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kxxPcF76WWN/bWnsxK2DKATJ83o8YOzutN3QwQabAvk=;
        b=UKFdo251OvxU8/GE6rDWMxIw4JnTV43v6nxiyPoYottCMJWPzgXIIl9cdEKz47UhZK
         3zFTSjD1JOhFyRmMhnHW/Tw/JjMISrn2BOo12AlF+WFIK1VhVG+Bt7T/DxzAiNkM/lu1
         LFZ+3vZ8Lsf+ssWDtLA72RlAmAF37kJyT7ggtvc1MN0ujq2VsyyfBasGH84b+yPMniPz
         +yUUDXgVT1TyWnq3qZoLWPXsb6VsChWjwYuj/iKvqBZo4oxvSsI5xNsIuqOXA+k8f5FY
         uEFKl0Bv5wR4v1CGtfLdOHSkg8sm4bxLwdCPfTDiuK3CQx6LzU5lo8wUeOiHLklI0/zC
         xQuQ==
X-Gm-Message-State: AOAM533s88LibrXCHIgzxa2Y0e6sIPk2hYPO44UOdH5aO57cYuOkujYJ
        rS3HqHJAh3E3x9MQj6iA6by8og==
X-Google-Smtp-Source: ABdhPJziWlBZguF9KvKsFv8JBh+wIhZgzpTZ4WF5oiXoNhgfWOzlyzCLZHvhUR24Ct+gyNa3oSolNw==
X-Received: by 2002:a17:907:7fa5:b0:711:c8e2:2f4c with SMTP id qk37-20020a1709077fa500b00711c8e22f4cmr16064278ejc.49.1654685216981;
        Wed, 08 Jun 2022 03:46:56 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y12-20020a170906470c00b00711d0b41bcfsm3809957ejq.0.2022.06.08.03.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 03:46:56 -0700 (PDT)
Message-ID: <965a52f2-9416-f6a8-eb01-b83702849508@linaro.org>
Date:   Wed, 8 Jun 2022 12:46:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] dt-bindings: arm: add BCM6855 SoC
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     tomer.yacoby@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, kursad.oney@broadcom.com,
        philippe.reynes@softathome.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        samyon.furman@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220607172646.32369-1-william.zhang@broadcom.com>
 <20220607172646.32369-2-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607172646.32369-2-william.zhang@broadcom.com>
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

On 07/06/2022 19:26, William Zhang wrote:
> Add BCM6855 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
