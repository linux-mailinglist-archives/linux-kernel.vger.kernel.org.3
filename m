Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F3F550077
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbiFQXPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383540AbiFQXNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:13:50 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE6E5D5D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:13:47 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f16so4040388pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=10mVd//XJbMVb3Cy5Pks+pC6niMtAwguM0D0PFkeb/0=;
        b=ftsgA9iCXVg14SM3UhGJNZroNcKteQOV8fhn/TQ4qmubLGEYc9goTyY9cqxWv/Vujz
         vvqm9Hc1xj1CilJkuFjGUkxiPQmxIGRA6ZWY937f+DBGH4jZKoO1kMpGaa8atsr2iy+c
         jInXea+ezAu5ezkR5e9DqoDPRxhK80c23I0Rxem6Hv76djU0l3rMSkohW6NtZA/wT8Xq
         kkbN94pT99l5RfQhhgeyyK0XqowM7S3hyzY9US2HlPGSSPmBn1VE+8RMyrvOvwk/qSQO
         VuNIIi8ERnbIixzMX8MQ/LZDa52WzzLDJSlri5vEF8FF0NVgt/kmQO5wufOCoypheUaN
         mQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=10mVd//XJbMVb3Cy5Pks+pC6niMtAwguM0D0PFkeb/0=;
        b=vOHmax+Bl3elOWY6ToZef/mqs2Ins99CKjElFpQSmYZywhPU5bAV1pyIcNo5XILlc6
         79Pxja+o3+Gqtu/3ed6Z+B6zsD04F2o0ewK9eUqxdIepcyaqi3CKRQ5zTWiwwhBgnL0q
         axg8qdBSHlffdQJgmXD0fdGmDlB+0qi/fluSSs4n/2kwUA29lW3Oi1QbCyJUsLBbXXv/
         YFr+p9HqPhn8K+40/SkQ2PYsmPJ0g987maYwzuCORu6eRey69qxIqslPdwYtLcxG5zuV
         svPPJv+8EJ1v1VvnAgnycZ11/nBJ+f7JCl5/q3s8XwhrHVOrZQbPfOhJHWPp+d1DwylB
         ME1Q==
X-Gm-Message-State: AJIora8+MKFtNA+frhwbxvy4Gxm1tvje15gOe7afTnzIOFbIQ5lhbOOE
        p5dAIY3dLVjzwNHuYwCy46+Gsw==
X-Google-Smtp-Source: AGRyM1t/dM7EAh0Y7mmMWaeiTHeXaEw5ea7tY/IXesEX0mn/1dH62oUOXAC46KuZhDOj2XfNQPbrog==
X-Received: by 2002:a17:90b:3701:b0:1ea:9f82:59ef with SMTP id mg1-20020a17090b370100b001ea9f8259efmr13153806pjb.239.1655507627413;
        Fri, 17 Jun 2022 16:13:47 -0700 (PDT)
Received: from [172.31.235.92] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id j1-20020a170903028100b0016784c93f23sm4054315plr.197.2022.06.17.16.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 16:13:46 -0700 (PDT)
Message-ID: <9b567f78-e12b-d665-2f11-96436fe9ed08@linaro.org>
Date:   Fri, 17 Jun 2022 16:13:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 05/15] dt-bindings: backlight: Add Mediatek MT6370
 backlight
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        lee.jones@linaro.org, Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiYuan Huang <cy_huang@richtek.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
 <20220613111146.25221-6-peterwu.pub@gmail.com>
 <9c38f708-1376-aa89-2c56-c08d320bcf2b@linaro.org>
 <CABtFH5KhijZDRA+K=stpOV0t8K3cqCMoLXpLShcdm9F8emrKCA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABtFH5KhijZDRA+K=stpOV0t8K3cqCMoLXpLShcdm9F8emrKCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2022 03:35, ChiaEn Wu wrote:
> +        - 3: 6
>>
>> Nope, I said last time:
>> "In any case you cannot have values mapping"
>>
>> Please use proper real world value, not some register bits. The property
>> name also needs fixing.
> 
> I so apologized for misunderstanding your meaning...
> I try to modify it like below.
> --------
> mediatek,bled-pwm-hys-input-threshold-steps:
>   $ref: /schemas/types.yaml#/definitions/uint8
>   enum: [1, 4, 16, 64]
>   description: |
>     The selection of the upper and lower bounds threshold of backlight
>     PWM resolution. If we choose selection 64, the variation of PWM
>     resolution needs over 64 steps.
> --------
> If these changes meet your expectations, I will try to modify
> "bled-ovp-microvolt" and "bled-ocp-microamp" in the same way.
> Thank you so much.
> 

This looks good. Thank you.


Best regards,
Krzysztof
