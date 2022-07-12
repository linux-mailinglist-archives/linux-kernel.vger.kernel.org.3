Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF051572254
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiGLSTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiGLSTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:19:04 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F1D24093
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:19:03 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id p6so8032906ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 11:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JMQ1Fi79A0irIgGyUI6PCh63flvImOH2aGttq9qDyQs=;
        b=y9r7FhafnYvsSz00A1RwZZhtcyDeUlxPoSJaq4eDskAgQegtb06JvvJBQmgxjTxayH
         G55b8QAbWHkyo/JGBUculJi2pqTIWWJ79SEadMsTIY1Di8YVIbcmHrLhdxz4G5nFHvse
         bc+OIH22tPsQ71EYxKdGw5IsF0JNxhBctA54rxOiuhi1+PtcrnW4xnJKkc6yy8ZrvM98
         4iOoPcRztj4evF/vVZWXyaTUIaDjh5VpPgvKvgtYSThWj84LK/c6rbWMATbFPW9wycJC
         XRhr1NJJrDLcT6dDXAC3tb9XU373VffnpQsIfB7Zq2+hZaXeOBt4CQ+qIp2pF+F+x9qq
         FgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JMQ1Fi79A0irIgGyUI6PCh63flvImOH2aGttq9qDyQs=;
        b=NxN/iAICXcGmpCafN9p9+jGj6SRJnD+qVcT25fuDvPJoPTIq2yQ4e4MGvnGndHusgu
         PIB9lR3vdkI0IHXxztY0IzAfUU6Hct2d3hQ3scUDgu1q+09S1aiePonjDjkjwvZslX6B
         bY9tAqJ4G52VH7IvQBkglYbPWqKT5OgqQqeweBzTipyXZgd1R8caCxZKDRc7r1TVgTsi
         NriUrWqBogy3Y7KKyKdOuQESUInPNZ9yac48WKWUVWdAyyzlXUa0Fm7ex0Pv9kupn93Z
         cIAuKfS+7Q3q6hTItDmiH8iu5JU7+HzX5GfY41L81UbG1+XOpwKL6BSiPOAuwNAZ+xRD
         XsGA==
X-Gm-Message-State: AJIora+v5Hi4gP1ViwXGk7O54I3qfVNDWtz6hBw/k7U1HK1leCPYzV/x
        xHuctTW94qQk3Hn5zlKgVW39yg==
X-Google-Smtp-Source: AGRyM1tC/q9gDYFNopU+9HAIbDNxNonrgeLFGrJ13IUtbK5ZlYSmdteLoZQ1OfR0Hjc5cWoZJOcL6g==
X-Received: by 2002:a2e:9695:0:b0:25d:65f9:fb95 with SMTP id q21-20020a2e9695000000b0025d65f9fb95mr8153763lji.302.1657649942181;
        Tue, 12 Jul 2022 11:19:02 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id m5-20020a2ea885000000b0025a7338317esm2511199ljq.64.2022.07.12.11.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 11:19:01 -0700 (PDT)
Message-ID: <c40f20c7-59ee-99f4-9a11-e928b41eda9f@linaro.org>
Date:   Tue, 12 Jul 2022 20:18:59 +0200
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
        linux-kernel@vger.kernel.org, rafal@milecki.pl
References: <20220712021144.7068-1-william.zhang@broadcom.com>
 <20220712021144.7068-2-william.zhang@broadcom.com>
 <ca8c3003-1bcb-6658-592c-566609fd7bd2@linaro.org>
 <94b0ab39-279d-d3c2-98a4-054c10ad041c@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <94b0ab39-279d-d3c2-98a4-054c10ad041c@broadcom.com>
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

On 12/07/2022 19:37, William Zhang wrote:
>>> +      - description: BCM4908 Family based boards
>>> +        items:
>>> +          - enum:
>>> +              # BCM4908 SoC based boards
>>> +              - brcm,bcm94908
>>> +              - asus,gt-ac5300
>>> +              - netgear,raxe500
>>> +              # BCM4906 SoC based boards
>>> +              - brcm,bcm94906
>>> +              - netgear,r8000p
>>> +              - tplink,archer-c2300-v1
>>> +          - enum:
>>> +              - brcm,bcm4908
>>> +              - brcm,bcm4906
>>> +              - brcm,bcm49408
>>
>> This is wrong.  brcm,bcm94908 followed by brcm,bcm4906 does not look
>> like valid list of compatibles.
>>
> For 4908 board variant, it will need to be followed by 4908 chip. Sorry 
> for the basic question but is there any requirement to enforce this kind 
> of rule?  I would assume dts writer know what he/she is doing and select 
> the right combination.

The entire point of DT schema is to validate DTS. Combination like above
prevents that goal.

Best regards,
Krzysztof
