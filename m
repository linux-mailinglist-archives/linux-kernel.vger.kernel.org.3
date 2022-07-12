Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6417457135B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiGLHp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiGLHp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:45:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6D09B9F1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:45:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id o7so12533854lfq.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=siR3BgH5slJk3knBZkv4TTMZlcCDCcI0G+RmWKGiNJI=;
        b=PcDsBCjoEi7y2zXt0manejyoz9eTHAVOorbVHLfepdzeB7d6Y5KHhdQRIJ3t/hK1gn
         IK5wMZKa4wVLxN01Pp+x5/mnxgBPLB9m5NPTHF5SJRa0W6WEy6+Shyvl9cMAOMBIMB8D
         Fk51VL4LmQrZYo9qKGTgSvUOBTj4/K9cCV4F16zGa6pbBqsZxnDGsBkDil0TIffFk8RW
         WamN21t+0RZNI1iDtPpb2nOylVVtvpBPNWayVwAysgIO59HSuZ0iLAgU2DhDqKAUPgSH
         nwqp3lNipNUWf440glo2oOqWbrKl5LaWQEO5cuYUiJUFeUp4bWc6rqul3w3MqWGeWqqT
         fnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=siR3BgH5slJk3knBZkv4TTMZlcCDCcI0G+RmWKGiNJI=;
        b=6uxhJpnxvb0GOxzuJaKGajXPKcBNL7t2Z0HYFxK2FKVA2iTP+vT6+Y7LCxyGAGMwwJ
         6HrHuDMEiJ/jMdkEuBxkCJHRoaqNFebwjjQLnmgfpe2Pisjnmz97vRzcMnN3Cz+KWQqT
         96xRMzDYROeNOxg+H4jDi9o/UeItX91QZuGFEpSyW+kPSPwEI/tAdlgtIGLFyhYAeB/R
         tjwO/Haj6N07TQGHhs+m4c3r/oL34aktN7Q/SQ/2cxN4EKAGar7gTZfBQKcHaZW2P3vZ
         iXAdfSYzV85llTSQWIw/5dJigzXkw+xpgPerLRUbMFha+P6OirWueVxoUaxzYyZGsfnk
         N5cQ==
X-Gm-Message-State: AJIora/T3SrDGoXySVMJADBLMMmBpTq6sF8g5g3bqLX5ic8RTs1uftd1
        aAUDQcqMsjK83htjiru/TzNUuw==
X-Google-Smtp-Source: AGRyM1u8DsjZupWlTyiGLXLSYB3FvxE1/dKdHt5I6jYe5YV8hK8ZK73y8NLMint5GufUPzx6SZyDyQ==
X-Received: by 2002:a05:6512:23a0:b0:489:d19c:602d with SMTP id c32-20020a05651223a000b00489d19c602dmr8378703lfv.89.1657611953262;
        Tue, 12 Jul 2022 00:45:53 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id j16-20020ac25510000000b0048160c5e625sm2040845lfk.12.2022.07.12.00.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 00:45:52 -0700 (PDT)
Message-ID: <ca8c3003-1bcb-6658-592c-566609fd7bd2@linaro.org>
Date:   Tue, 12 Jul 2022 09:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 1/3] dt-bindings: arm64: bcmbca: Merge BCM4908 into
 BCMBCA
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, f.fainelli@gmail.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712021144.7068-1-william.zhang@broadcom.com>
 <20220712021144.7068-2-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712021144.7068-2-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 04:11, William Zhang wrote:
> Merge BCM4908 SoC device tree description into BCMBCA and combined
> all BCM4908 chip variants into the same BCM4908 chip family item.

Merge means you combine some entries, so I would expect to see the
removal here as well.

> 
> Each compatible string represent the whole chip family. The board
> variants and chip varints go into the first and second enum in the
> compatible string item list.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
>  .../bindings/arm/bcm/brcm,bcmbca.yaml           | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
> index d9dc4f22f4a5..906c3e1de372 100644
> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
> @@ -28,6 +28,23 @@ properties:
>            - const: brcm,bcm47622
>            - const: brcm,bcmbca
>  
> +      - description: BCM4908 Family based boards
> +        items:
> +          - enum:
> +              # BCM4908 SoC based boards
> +              - brcm,bcm94908
> +              - asus,gt-ac5300
> +              - netgear,raxe500
> +              # BCM4906 SoC based boards
> +              - brcm,bcm94906
> +              - netgear,r8000p
> +              - tplink,archer-c2300-v1
> +          - enum:
> +              - brcm,bcm4908
> +              - brcm,bcm4906
> +              - brcm,bcm49408

This is wrong.  brcm,bcm94908 followed by brcm,bcm4906 does not look
like valid list of compatibles.

> +          - const: brcm,bcmbca
> +
>        - description: BCM4912 based boards
>          items:
>            - enum:


Best regards,
Krzysztof
