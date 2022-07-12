Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AE7571FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiGLPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiGLPu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:50:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45176B41B1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:50:25 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id o12so7758374ljc.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7xRo1tbRw235GqlWt7H/gMak0ChzgLukcWrxmjFVVnY=;
        b=BsfSiO0DzTQwAXsOVV/eaDqG4Q9ih0+Yp7vHqlvRLtrfeq4nSudPAF/HuwWgxkoOS+
         OVPRQgDWqHoUZB72KJUDnwuJKVndUO36Meo8MAjEkfROPp+wo07CuY+P1yFP6hUrgCUl
         750uDp238dFqPAUqORzLrVj2TRXw52yGI/gGbDvziAd1PwQrgj+RTbCoCBrP7UYsQBMX
         8UzqdzuEZiqVZdRER/kWx9gXJEjgo2M33Ic84TJgT5zmUPtAoL6DdRmVKrBSWsi/BJ+m
         XAOq2Vu8IYR4Un2TJkl8y9WegzUrUDNXX6W6mcdMRGLHAiG2yBA2JHDnNsYpqO8D02Ox
         cC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7xRo1tbRw235GqlWt7H/gMak0ChzgLukcWrxmjFVVnY=;
        b=o9R3O3g9OkScqHcfaBe9B90BdQy1/92KhDbC4S4U6jKShSs3+43UjdJ4FDTcfQQd7b
         Z9kbbFXXDU9I2G0gjSkBY+vC7C1zYmd8SCmsvYQtR5CzsQlBveWs1dFlAvZIAsd+jiWK
         K/y7xl/NbBW0DmNOc9bFxx3mpBccGHZ3qOLvY5vkQ+Eq+dOanuUK/xn93j0Sz5Mil9t5
         8YORyeyFxwJ/XjMQmmm+3h1HqVunx29scEHVor1GC7eUSKc7gF1qU/5WDsgmQXcWuTpH
         +UZyXuCgsSxKlTIo21gyJ6r5tT26GhYK0c5cWrIHTZb4pOEF6brPvWqQ8zMj7+gukiKd
         5Lew==
X-Gm-Message-State: AJIora8p0+K2mICP92dR+7IpIXgirL6/mxwi6OPLuKBeP8Yv8GHa91Bv
        HgbdLPLu2dDzflUaXmDugZWEHQ==
X-Google-Smtp-Source: AGRyM1sdHz15fM6xAwfuLdHc1EeE/3kjXzdcFi7xq2lIR8s/6SQUh2gSPRONWAf4k07wRLj7JjjmWw==
X-Received: by 2002:a2e:be9f:0:b0:25d:6051:971 with SMTP id a31-20020a2ebe9f000000b0025d60510971mr10618934ljr.372.1657641023668;
        Tue, 12 Jul 2022 08:50:23 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id q6-20020a056512210600b00477c0365b20sm2249927lfr.188.2022.07.12.08.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 08:50:23 -0700 (PDT)
Message-ID: <6b7bab04-90ce-6111-35bd-42cb3a1f73f8@linaro.org>
Date:   Tue, 12 Jul 2022 17:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 3/3] arm64: dts: bcmbca: update bcm4808 board dts file
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712021144.7068-1-william.zhang@broadcom.com>
 <20220712021144.7068-4-william.zhang@broadcom.com>
 <d93e55fa-3359-2609-aad5-c80eca78f380@linaro.org>
 <900ac3ed-a77c-3cc0-f5ab-c45267a1a4ba@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <900ac3ed-a77c-3cc0-f5ab-c45267a1a4ba@gmail.com>
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

On 12/07/2022 17:36, Florian Fainelli wrote:
> On 7/12/22 00:47, Krzysztof Kozlowski wrote:
>> On 12/07/2022 04:11, William Zhang wrote:
>>> Update compatible string based on the new bcmbca binding rule
>>> for BCM4908 famliy based boards
>>
>> Typo - family
>>
>> Please explain why breaking the ABI (and users of these DTS_ is acceptable.
> 
> This will be largely targeted towards Rafal who supports these kinds of 
> devices with an upstream kernel. My understanding is that this is OK 
> because we will always ship a DTB matching the Linux kernel, and I 
> believe this is true for both the way that William and his group support 
> these devices, as well as how OpenWrt, buildroot or other build systems 
> envision to support these devices.
> 
> Rafal, does that sound about right?

I am fine, just maybe mention it in the commit because it literally
breaks the DTSes.

I assume you considered all possible uses outside of Linux like U-Boot,
BSD etc?

Best regards,
Krzysztof
