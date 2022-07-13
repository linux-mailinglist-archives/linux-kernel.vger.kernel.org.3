Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24A25734F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiGMLJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiGMLJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:09:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB52FFE29
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:09:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id n18so16789141lfq.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CaTNeLjgi7h5W4qwYDoG81A9uKPYwd5JFUZwzZb0oUg=;
        b=KU+z1VvBqZvnE32I9brCR0r8W+KtSC4mZ7RSFv1ShP+6ZqhgpnMFXcpNvi52dXjTNX
         iwrRKGdl9O/PBfz4qeJxYRIkGph8d89oZ1RBQNCAVtxpTtbVYliM8diUtyWg2z3feJ3x
         oFPWdSjm1gyOFZxPMqJZ5bx4Fbs1yx1uZr6SVkyUfSngeey3Dnlj53iNdk5XHfiZNF/u
         HdgWs52yXY5sUlPLaHqyn28kuL3RSzJ8dtP7Wjxcl5F6NScRLGGBuF871egNlfBmOsym
         RZ7+ks9+E49nHgyNGKKiXNPjpN+e+8lo7xBwXckrJ2qaCdGm9h9CMwK1K4/KvajEafZR
         qraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CaTNeLjgi7h5W4qwYDoG81A9uKPYwd5JFUZwzZb0oUg=;
        b=BPOKEx0mbYxr890jVYx9FhrYNAUODWBznuuJaEQADQnyJcDzQGRpcwtYhjrYlOU+EX
         vw563VuUCk6zoYvEi7ocFqjUGLwXp0vGk1irDFGyq4FQi+XBqTnkaLv4s654WQwZcOPl
         /+fYLgB/TlYFbsQZeQhcZXgditlRer188Q9c6H2iSmgWHKppJOri47TYXsd7VVsxN3hV
         fdKuGFdtlZecE1Wjub4HCHdy2LX0idnV8AmXnNudwKX6/s8AYgkkadgtVvuKrBqrrA29
         CBsfdHPcJeS5ulhhug+CuByT4EhwriuyHcOJlsh0nnOFlAAN5dHSfAHqEdQBkTQoawwI
         Hc2g==
X-Gm-Message-State: AJIora+JHhYd063reUPbfEKfZ8M0qPSS4tNOOEz6mEQLKe5ONLUWdr58
        IUGZjjzuWU6ydf1bx+36J+1Vdg==
X-Google-Smtp-Source: AGRyM1sZRyvLEI0P4kppiN4/gEs/QKucsHxVMri4qwtywZ6YFlY6K8m92S2vJlHesd+e/cBZI0uFQQ==
X-Received: by 2002:a05:6512:3995:b0:489:d974:33d3 with SMTP id j21-20020a056512399500b00489d97433d3mr1656192lfu.458.1657710582271;
        Wed, 13 Jul 2022 04:09:42 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id i21-20020a2ea235000000b0025d4addbad4sm3069118ljm.91.2022.07.13.04.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 04:09:41 -0700 (PDT)
Message-ID: <7cf0e9b7-4316-1a23-3484-03e5f0491393@linaro.org>
Date:   Wed, 13 Jul 2022 13:09:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 3/3] arm64: dts: bcmbca: update bcm4808 board dts file
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
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
 <b350020eee4de0caf36f88f299e61930@milecki.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b350020eee4de0caf36f88f299e61930@milecki.pl>
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

On 13/07/2022 12:55, Rafał Miłecki wrote:
> On 2022-07-12 17:36, Florian Fainelli wrote:
>> On 7/12/22 00:47, Krzysztof Kozlowski wrote:
>>> On 12/07/2022 04:11, William Zhang wrote:
>>>> Update compatible string based on the new bcmbca binding rule
>>>> for BCM4908 famliy based boards
>>>
>>> Typo - family
>>>
>>> Please explain why breaking the ABI (and users of these DTS_ is 
>>> acceptable.
>>
>> This will be largely targeted towards Rafal who supports these kinds
>> of devices with an upstream kernel. My understanding is that this is
>> OK because we will always ship a DTB matching the Linux kernel, and I
>> believe this is true for both the way that William and his group
>> support these devices, as well as how OpenWrt, buildroot or other
>> build systems envision to support these devices.
>>
>> Rafal, does that sound about right?
> 
> Right - in all cases I'm aware of - Linux gets shipped with DTB files.
> So such change won't actually break anything in real world.

We don't really talk here about Linux, but other projects, like
bootloaders or *BSD...

Best regards,
Krzysztof
