Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070EA57D1C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiGUQmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiGUQma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:42:30 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFF348C83
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:42:29 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id j26so2504296lji.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QwbR0un4sxn5vSzlSp+6P02uSZkTlMkJ8tMJt7IV6kQ=;
        b=nVUfHL4iSOBNm987zRPh0ZOiblifeAm2GjJAE6SiGX8pGFxAhUqB746EXBDqIgcGXq
         oSlx8BUtATFMVqXSGNVPqmeCCWh0JNKzIxOuZ2rtvlULAJvSH+tM3hX+cMSG40quAz8h
         9CDD03PRJ9rGsoK7vgnFQfa5fLXugZpHZwgqhlsdgo5xABUWVGRj45krZm/HLcNFUuwN
         NzpNoBq4jg1IgD7vNFRaYclwWHvO0ppr2dqa1MqxT1Nekc4BqzEBYbPQygghXArvdLW6
         dQL2MxFwa1uOEaRab/C8zm43JeZAhx/JdqHi/YvnxcMmnj0jAqr3gCw9Bwi6V5MUARzP
         ouSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QwbR0un4sxn5vSzlSp+6P02uSZkTlMkJ8tMJt7IV6kQ=;
        b=qa3O2orryR0i7uJs8n3IbgKHOUixGbmuzsHSxAFsWbuhy1Nql1RRNsGWF1aoughL6Q
         +Hs9v1h6E1UdqapYHxWvlnpG/ysB24178AP8wdymkjFDBdBsP0JqSsimhV28g8c6yOsm
         bFft75/JxB7D9e3gNfli4cTPFuDjz468auTtKy/377AVSTWnOJzyimXN/C6YzR9LrJlf
         tABmLwWb6m0e6VbywGEt5WP4mtNH8oUctyfd42g2SG4GoOqiGZtZfsQ31bT6pOxLIknE
         n8Gp48mXMae2ETlVAuT0gYpCwVRnLexKhuo1AqRfS2lZNiHTOQBn2ZYBGt4ljHpv9MQI
         7RyA==
X-Gm-Message-State: AJIora+KaFQ5zg0BBxaTlKuvaP7eIgsKfReb7sBR/nI/02EbRLJWiq1x
        XyZw8Tkiv+wyB9nF/+z9lXP4BA==
X-Google-Smtp-Source: AGRyM1uFzos/A5/g2s3woS8FwhO3fIGnF0n24Ur8OHhsXAlgHadMD65zx1KxOEeLV5R+1EdDQWuNxQ==
X-Received: by 2002:a2e:8551:0:b0:25d:e969:3dcd with SMTP id u17-20020a2e8551000000b0025de9693dcdmr1039476ljj.531.1658421747582;
        Thu, 21 Jul 2022 09:42:27 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id bf39-20020a2eaa27000000b0025d75b27fb7sm622512ljb.27.2022.07.21.09.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 09:42:27 -0700 (PDT)
Message-ID: <5d6c94f9-9618-55cc-c715-1931275ff087@linaro.org>
Date:   Thu, 21 Jul 2022 18:42:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 2/2] dt-bindings: arm: fsl: Add Moxa UC8210/8220 series
Content-Language: en-US
To:     Jimmy Chen <u7702045@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     Jimmy Chen <jimmy.chen@moxa.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220719030718.28826-1-jimmy.chen@moxa.com>
 <20220719030718.28826-2-jimmy.chen@moxa.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220719030718.28826-2-jimmy.chen@moxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 05:07, Jimmy Chen wrote:
> Add DT compatible string for Moxa UC8210/8220 i.MX7D board.
> 
> Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.



Best regards,
Krzysztof
