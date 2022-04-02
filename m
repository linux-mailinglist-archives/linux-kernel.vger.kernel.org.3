Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA04F04E1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358086AbiDBQai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358084AbiDBQad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:30:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BD66337
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 09:28:41 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bh17so11750206ejb.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DSB2bZhZo75SSWCziQt2t9Zgl7ePoq+TzKjDyyRKIhM=;
        b=CdAM6q4dxl6fxdnqGxDYrzuFWlpgZHARUlO6m8ZQWVHXoLL8GzUgEGFQ9nYeEXFbF/
         QEvdxMBjShvDOMsgyIvePkgZCnGrsPhBiLX5mZrDBOO7kMlSMUbA486htIWteJxPMrEY
         F98RdgozoM7Aq9GHkhjPR9DKQbHBpowK/JQikESmA7J1c+6qlLLXpJzSYAMnJ/ng+e53
         cibleewvc1eJy0P9F6YEP8CS/LshBzlQ6GVyHFw2vmN0n6zGMVUtUFTSDI5HyJVND3Io
         QIgJYWCMV3GECCWmybW+SDQKxCHEzR0V/aEudcCwdZqGbW+rdk8qigdLpUIPrAc1GFr4
         WijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DSB2bZhZo75SSWCziQt2t9Zgl7ePoq+TzKjDyyRKIhM=;
        b=EBs6dmoValDS7P9u/UsiDTUn096QgWxSaqllwliAzvczSNrOtXzrKLVg5Ei4ekazXg
         cNuJXkD/mPdDwZOlKu7RGAknvOh04GYnlOUhn2/cBOpHR2OJ1CxhM+hv5YCZun5Jvw8L
         U1T+Gyzt0FmnbHQUoNVLsKR7YdySe1h5s0f4HJLQRM3b0KYzn3q2E2r2kMqXas3aFCCj
         vnujUiBrmFxfPasstatc5nXIhWu8p/w0tVBC8aKy0zDCkSwRcRT4CXu3RkWE3xaAoxp4
         dqAOIwe1J97f6eIg9NeGOQTGVd1lfn8hKrT3/L0sy1EFd5HNelC/7meewCw34l4ePQzJ
         ax0w==
X-Gm-Message-State: AOAM533TVRNEV5+zj8OGxlyUUq9qV1LFu9RXQ16h9lf/31AvamWLQRCQ
        BXyBPucxAl6Am+TdMWIIvvJJ8A==
X-Google-Smtp-Source: ABdhPJxwjjPCUC3hgZgk+ER1LyMOtHSTUdEWAISi3E6mNi9/P8EnyHGRuK7vcUs4ZlnWvNYBxnS2wQ==
X-Received: by 2002:a17:907:c05:b0:6db:f118:8834 with SMTP id ga5-20020a1709070c0500b006dbf1188834mr4412970ejc.536.1648916920033;
        Sat, 02 Apr 2022 09:28:40 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id x3-20020a50d9c3000000b0041c8ce4bcd7sm1319798edj.63.2022.04.02.09.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 09:28:39 -0700 (PDT)
Message-ID: <a85dc713-a0b7-372f-1284-e8488b5b11a2@linaro.org>
Date:   Sat, 2 Apr 2022 18:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] dt-bindings: arm: bcm: add bindings for Asus RT-AC88U
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
References: <20220401172427.2806-1-arinc.unal@arinc9.com>
 <20220401172427.2806-2-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220401172427.2806-2-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2022 19:24, Arınç ÜNAL wrote:
> Add Asus RT-AC88U under BCM47094 based boards.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
