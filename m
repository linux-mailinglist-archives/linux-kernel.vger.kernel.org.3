Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CAB4F8975
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiDGUoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiDGUol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:44:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B673B38DE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:39:12 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w21so9606876wra.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fqtKr787N6Vy1cwaYaYZc9PI8pUmju7Cz4kLVR3rNO0=;
        b=xd/uN/+Wfa0+DJziXe7CM988LNaoE/LluwkoUHTwQ9+zH3ooZE1UWwe7s2BIb3c1My
         +esS9mC72qFXdlzWLyQnaolMh3gfwuzHDc4OALOUZAkHKljGW/17t6SY2BefhYkzmR9j
         s5w/ym9EyM1G11gyyb8n0f1speuoHsrdCRrMjd4uydyz+uNmsUAz2Bv2uvCsmDDbUTht
         CMAS2VmtJcNiWBQiF3YDbR+DbtTez2CXIt3x89DCv1ZWbq5FeH4kLl8vdIT0pt/NjK/4
         BvErXNsFnFwcldyNvMR5l37DqHw/QXSkKDJ/R0HYkjnkdQD1vH1yozKEsvj1CUz6ui5/
         zp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fqtKr787N6Vy1cwaYaYZc9PI8pUmju7Cz4kLVR3rNO0=;
        b=pQ+lGmcfBSx3AIn4VDascaup9eMl4XLaCzyunh5ojy3eyxXwRE64s20JEAKwLPKdsH
         KNJHk0WgyNvNGvkzgkRVJVUbrUUZKc5r63bJ9SORY30RNfvxQXjNSCFYjPoNTvAeWxtS
         SycxhObeDAx2rGqAoc/zHdONAesIFIbLj4wmMgTXOzKDR3cnsCcRPo4I+YjeMLiqllWb
         V06iV4C3G9On11bImPA2rjcbikaHCSGNxKPkMhhzdoDlKFK0p7p2QbVLI+Z2XGBp2L9B
         SsqRenUYmIh/uIGUKVwdJzigwmjAo8X61ilURDg9G6pNWjovF/O9OnL6ni5zE2OxnQrZ
         a6vA==
X-Gm-Message-State: AOAM530t5WeIyg56ZDvCsAqiNYFhbQ/sYfhoeGzskpjLfWb5miFSkcU5
        br+IVaqpDGjm7+Oirsctu1iHhNxb+8imzEEx
X-Google-Smtp-Source: ABdhPJzFnUZMpklEvBXqWfIprKr3SeUKOVHJYtNHafYjioDtHTrl0Yu/4IrS7rpVQtAYsGOUPaDGmQ==
X-Received: by 2002:a05:600c:28cd:b0:38e:72c5:5259 with SMTP id h13-20020a05600c28cd00b0038e72c55259mr13665875wmd.176.1649363951008;
        Thu, 07 Apr 2022 13:39:11 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcc0b000000b0037e0c362b6dsm8584615wmh.31.2022.04.07.13.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 13:39:10 -0700 (PDT)
Message-ID: <8fa6212c-a914-dcc4-c852-32a3948db99f@linaro.org>
Date:   Thu, 7 Apr 2022 22:39:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: dts: synaptics: add DT for AS370-RDK
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     SoC Team <soc@kernel.org>, Rob Herring <robh@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>
References: <20210820173108.01d5c6de@xhacker.debian>
 <29e96ece-8541-a7a2-c6a9-453be6644eed@canonical.com>
 <20210820182708.51d13e29@xhacker.debian>
 <CAK8P3a2vkZVt1bb7-iDGaSHp20U9d8QXu6AcrUMceJSS9Q_-4Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAK8P3a2vkZVt1bb7-iDGaSHp20U9d8QXu6AcrUMceJSS9Q_-4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2021 21:55, Arnd Bergmann wrote:
> On Fri, Aug 20, 2021 at 12:27 PM Jisheng Zhang
> <Jisheng.Zhang@synaptics.com> wrote:
>> On Fri, 20 Aug 2021 11:59:30 +0200 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
>>> On 20/08/2021 11:31, Jisheng Zhang wrote:
>>>
>>> There is no such binding. You need to update the bindings file (first
>>> patch in the series).
>>
>> This is my plan ;) In fact, "berlin4ct" related binding is also missing.
>> I want to convert Documentation/devicetree/bindings/arm/syna.txt
>> to yaml, then add missing bindings. But it's too late for 5.15,
>>
>> If it's fine to keep as370.dtsi without board user(s), we can drop
>> this patch. I will solve this issue in next development window.
> 
> Yes, doing it for the next cycle is ok.

Hi Arnd and Jisheng,

This patch was discussed in Aug 2021 and since then there was no resend.
I assume that AD370 will not get a board, so I propose to pick up my
removal patch:
https://lore.kernel.org/all/YRbDNInfG7caSr2r@robh.at.kernel.org/

I will resend it.

Best regards,
Krzysztof
