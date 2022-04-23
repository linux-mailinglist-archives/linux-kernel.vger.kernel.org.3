Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB6350CC97
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 19:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiDWRep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 13:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236584AbiDWRen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 13:34:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9861718C46B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 10:31:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id m20so1286118ejj.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=bKsmqXRYpqUwhmofQJ981p6h75uLhrlYANKDZeRH3Yw=;
        b=AsyhZT5G7Rn1USmiBSUJqjC54KlsVFEdM+LUYDHVCYDWT2uMibekpBmYtuUoUApjvC
         li+cxCy+MjPt4k5Ly6BP1nKgLPiYO92qskFvBmO/yu01Q9G6ftIaVnxSI1NJZITAr5SZ
         RVmU6IQltV8QyJEf99e1IAw3H725Z4goBXgzN6F//2aTelMEMiC4hlyJ9b5+PRpt+rhq
         hzHeDco0ztmw+YZQO/dST6kcgF+EMNWwq/5zp1DsdcD9h5zdr6ETU1d4hnygyqKBNVuU
         wI1XEl9420F6q7aTcQLGUsmajZha053Y5YikkHxdDHh97bARDumge1nYnfW/hWHkBefk
         4bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=bKsmqXRYpqUwhmofQJ981p6h75uLhrlYANKDZeRH3Yw=;
        b=MRwCOEw5E+5Qtvnx6A1pEklZZ2q5BDKPsTPqvzazOawQYVd+qwWKa4gftbrvJQ40h/
         rocNuOOj4Y+osEiKwgFbjADpJecq8XM0xaMCuFyd45hF9eRt76iODSaY01pAaEW3ZLcg
         aqrsOfAOGLhHxcH7sNlFCe8JxEqCBDIZGS5pSyJDrX/5WIiVe/yGaQJtYSIPUjtS6HFb
         RFWicdmYjwFwa6OLF4bMNGO1qTxw4dqNIOOy5be1F9UYwDCfJajRQwy12YXkA7H0SKPL
         q6033Q9vIp/HjKsfJjgw8trCeZagQ1tQz1tVBN0d9J9UOq8wGA6Y1ufkQHdw/w9w1EZ1
         S3Yw==
X-Gm-Message-State: AOAM5334W6HKYbxF9geE0Ctwc889wyPf+Je9tXPr4VC2VvqUhfKhxb0r
        A7DoI8e0eaHhGfkO4Z7xiIr3tyPktFasyg==
X-Google-Smtp-Source: ABdhPJxUIwgdy6uOQIKxuP9OG0OknA6P6MQwfXJgUv6/3CSZgK3CreXhlN5R95v7e9nLbVweqm/4xA==
X-Received: by 2002:a17:906:6a0f:b0:6f0:1d08:3640 with SMTP id qw15-20020a1709066a0f00b006f01d083640mr9294977ejc.264.1650735103121;
        Sat, 23 Apr 2022 10:31:43 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r16-20020a056402019000b00418ed60c332sm2422395edv.65.2022.04.23.10.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 10:31:42 -0700 (PDT)
Message-ID: <34819690-5cb7-bbce-a2f5-3f6e66661049@linaro.org>
Date:   Sat, 23 Apr 2022 19:31:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] media: dt-bindings: media: rockchip-vdec: Add RK3328
 compatible
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Christopher Obbard <chris.obbard@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Alex Bee <knaerzche@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220422133803.989256-1-chris.obbard@collabora.com>
 <20220422133803.989256-2-chris.obbard@collabora.com>
 <ff87d5cb-b0d4-95a2-90b0-7827a2a34d05@linaro.org>
In-Reply-To: <ff87d5cb-b0d4-95a2-90b0-7827a2a34d05@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2022 13:10, Krzysztof Kozlowski wrote:
> On 22/04/2022 15:38, Christopher Obbard wrote:
>> Document the RK3328 compatible for rockchip-vdec.
>>
>> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
>> ---
>>  Documentation/devicetree/bindings/media/rockchip,vdec.yaml | 1 +
>>  1 file changed, 1 insertion(+)
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I acked this but Johan pointed out that your intention was different and
missing patch context is quite important here. Please explain what
exactly you wanted in the patch? Now it looks actually wrong, so my ack
is not correct.

Best regards,
Krzysztof
