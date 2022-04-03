Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40244F0858
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 09:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbiDCHzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 03:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiDCHz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 03:55:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21A02DC2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 00:53:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q19so3106733wrc.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 00:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uMVDDVYaqLqpFyu7s61yIX+d659Dkm7Pzi1louhm5Io=;
        b=NUOXzjv40K6W0HRFxZmuI/DqUzChoRusBi3rPsW4DSxtr9JU6EhPJiF5GVD/m1+uX3
         jM5/ly8MLGWdrtCdYYzV3wngJKl3MjHhBNvPPzP+vMpPKTWb7t9M5Ya1uSZjfMwnGiW2
         Pjnq98yVh5cEo7IYddYwpLUmdqUEujBOt/ffAZU09B53HmR42KEraeX4+JQjeKgu4SBz
         yGo1JfoiTXN2Lf1Hqvq1lS3erR9A+tq0F/B6qUqSsqdWZZRJEVLngpZwJKz2U5AIW8MF
         bvAyK5eDXrtcFA72r7OxZzT5O4lIl3fRriUnsDZ4H3JjCHB8ztKbRYDZarkd6olkNe3k
         gsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uMVDDVYaqLqpFyu7s61yIX+d659Dkm7Pzi1louhm5Io=;
        b=yRxxwnwEMeHxk5kw09NnBPkMdy7pQzUUlPJkntA1JbOw5iu4t7natNervUdaXhp1R/
         1MRI+xVXHnSgaTp6wz6aKoBwfHoaAjVUqnCfpKGGgPXIEvtyR9FEFSD/0X8VJfljRWCR
         4zMmf4iKtnRWGWEGzmW7Zd9psC6s1yQsJDnAlctGyfzjJ60jBKKXZKMTWQRm+4Vx+/6m
         jnBXNVHIPijAfvTv1Hhi8oZBMhqDv0gwpMfVbLeI4K8Wfobm6bskCUQc+K8WrMlCVsD7
         j/zkJZF2fjKYJbf4UMeeWZPApFLCxNsSCqeApHfvUEIwqL34RMSBzL2/Kp6opwGJbxhf
         2Z8g==
X-Gm-Message-State: AOAM533EfMRMW4Fnzhkk+dZjQzoFpgvMVVPqxv+4ipVVsPYlIvUCm5mE
        mA5etKCwlpU/422At+FTP3YxhngG1AyFUFfG
X-Google-Smtp-Source: ABdhPJybvyTtXUqONL037L1bcHWx4YQVQhxtYXlB4FyjLeNz310jw42sCI0nYzspWw8W1AfIQT3dFA==
X-Received: by 2002:a5d:5255:0:b0:203:ec9c:6d5e with SMTP id k21-20020a5d5255000000b00203ec9c6d5emr13653489wrc.70.1648972413502;
        Sun, 03 Apr 2022 00:53:33 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id k23-20020a7bc417000000b0038ccada7566sm13368075wmi.11.2022.04.03.00.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 00:53:33 -0700 (PDT)
Message-ID: <7c6188c3-6151-06bf-a1b2-a5d6baa2cad8@linaro.org>
Date:   Sun, 3 Apr 2022 09:53:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: bcm: fix BCM53012 and BCM53016
 SoC strings
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <20220402204622.3360-1-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220402204622.3360-1-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2022 22:46, Arınç ÜNAL wrote:
> Fix inaccurate SoC strings brcm,brcm53012 and brcm,brcm53016 to respectively
> brcm,bcm53012 and brcm,bcm53016.
> 
> Fixes: 4cb5201fcb5d ("dt-bindings: arm: bcm: Convert BCM4708 to YAML")
> Fixes: a2e385f5374d ("dt-bindings: ARM: add bindings for the Meraki MR32")
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
