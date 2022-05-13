Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483E3525D27
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378120AbiEMIQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357717AbiEMIP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:15:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E90FDFDB
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:15:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j25so9346805wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mTQPBz30cCLuWgIJk7/NZCaC5miWia1gCjLQnZteLLo=;
        b=y/nWzJG4Fbw8/7Hr2WEQpFWbOnZphvs3gwZ72nPwxDPJfy7dy0gJY7R2lFYGrleewa
         UvN7q6TursJjqMpYGLwvl54QyuMBBG279rXkcLYs8J8YGa9ZZh2XDKFqqevEAFoqYQ8N
         LI8AYCHjsqeJqRXdo95z9Gy5PyyEsRgzj2Hdg+VIhyTudoCxR35KZDtptDp2IZ+MQVpc
         txgGTwv9RJDpztlhSVPQRLtfIoWcXWhQ6ZkBHBOEgBUCbjl7nrhdTIGb0qpz3NDQR/8M
         eV2XuSjmdcXb+EHRGJTaJwOlpIQPvr2Uy5+yffzx+6X9wTEypxD84XizeuvKb1LDBxdJ
         N5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mTQPBz30cCLuWgIJk7/NZCaC5miWia1gCjLQnZteLLo=;
        b=7ZrofZZV2ARTl4aBmZIq//nzgPvfsS2d41Fdk9u2a624TyhK/I9/Wl8jhvrh2wyivy
         0GGxPlhDZcAW0/KcF3YcLjJVZv822vj2gU3BaPXJ/Dfw7Sy6LZrr6Pl233gkh+kVZvuS
         SgatMUjA2dQXijs9DhM/6OrztFmTGeHtAfmTZs9+yJRDxh1zp4ISr+zIu9KYTw51rwUv
         RWcavDhrX7wLpxVCSManQ+nZLzv3lP1UIXnmEKd4HKQoPZ0yfgEfeySebTHOH6Fwmowo
         2i7NeCo1KFalOJz2Fbbg/pNAuKMYYRIpYYmEvTkLFp6OkikQfPalxLMFetck7DGk2t+S
         k7Ow==
X-Gm-Message-State: AOAM531JjYL1TzmQEudHgdaeHYQPxz1L/o6ze3dAnUVLw63K0VaQ2pEv
        7GvvK/+Tdeej4Za9Tk1+xXMwRA==
X-Google-Smtp-Source: ABdhPJwXd3TWdB6hMve0fv2uJKyMa4NDpLkzRHAgkIR+esBN7x+bTCEeukkPdDda8xWohPhizuEaAw==
X-Received: by 2002:a5d:624c:0:b0:20c:d8f3:71b8 with SMTP id m12-20020a5d624c000000b0020cd8f371b8mr2897239wrv.670.1652429752615;
        Fri, 13 May 2022 01:15:52 -0700 (PDT)
Received: from [192.168.0.168] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o19-20020a1c7513000000b003942a244f57sm4708291wmc.48.2022.05.13.01.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:15:52 -0700 (PDT)
Message-ID: <30978e5a-18ef-3ea2-8df3-3ced50f44bfc@linaro.org>
Date:   Fri, 13 May 2022 10:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 1/2] dt-bindings: remoteproc: mediatek: Make l1tcm reg
 exclusive to mt819x
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20220511195452.871897-1-nfraprado@collabora.com>
 <20220511195452.871897-2-nfraprado@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220511195452.871897-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 21:54, Nícolas F. R. A. Prado wrote:

Thank you for your patch. There is something to discuss/improve.

>  
> -if:
> -  properties:
> -    compatible:
> -      enum:
> -        - mediatek,mt8183-scp
> -        - mediatek,mt8192-scp
> -then:
> -  required:
> -    - clocks
> -    - clock-names
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - mediatek,mt8183-scp
> +            - mediatek,mt8192-scp
> +    then:
> +      required:
> +        - clocks
> +        - clock-names
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - mediatek,mt8183-scp
> +            - mediatek,mt8186-scp
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 2
> +        reg-names:
> +          maxItems: 2

Isn't l1tcm required on mt819x? Now it is left optional.


Best regards,
Krzysztof
