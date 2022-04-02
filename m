Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C249B4F0042
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 11:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354217AbiDBJ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 05:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiDBJ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 05:57:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EAA1A61CD
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 02:56:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n35so3045207wms.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 02:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cgXEkA1NsSLqZo2p9htj8GcgXUNKhGzyClMqMaWIvDI=;
        b=QUxAVBIGjxzUGhga2bGVCacVjSav4X+BIyqne/0zdL/4ikLPyuC4Mjo9T5inO7Kfxd
         A9mBSL+/8fh5y8c027vJHrlNiIBlYi1N1/6zLsHYkpl5ApP/7ZLL1C0sVCCQw2nd1aNv
         gndE6vmrp777SW893dYvMN0B6M71FQJ20kdc3KLxeqj8hvQuS8HCfyqA/PksE3ruxMTz
         szpncBtYVQ2rTkKKlzKbMfZJeHAKl5xtnc7GWgWmRuR8BbciBg/b02QYjY4wRE8EVGzZ
         iFbhbM5HW7RbEQ2H25yQ4U/yxlvntt09ODrON3n7UN4WcYSCXmbBJORg6p+Bbfl7fe84
         91tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cgXEkA1NsSLqZo2p9htj8GcgXUNKhGzyClMqMaWIvDI=;
        b=vlyhvNBHjm3WdLgUJeT+6hYfILvSrhDjpQXIiKR7UxoS+5s/6z5cGHeU5tiqocJq9p
         yreXLmZ51+D40FVsJe3FXMAviNWEMUwe99XupF+Q7y4Dws0GbMo6IRSP63RflUbP2KsF
         Ht2hm9agsbBH0UifiWUq2xa1E4Jf8wEGG7p3/br3zbyFBczyHIRIbfWc34CPqkkG3xRU
         jUx0b5WsT53zLGAa0Qf09LVrXgECiAwN8/XhtCC/jPPJgvvh/ByJ/meNI59ZwCX2iJ8T
         N4UHLqeIY3vnHeCnT3SZLinrOx3b/u5zQbRn3wgdWkDQT/V6WvvK1nlUGN40SgbNJ2nQ
         pQBg==
X-Gm-Message-State: AOAM531mfJD2ZinKobjkhOeolmLY6tWxMMTsXMWn0lpiP4x6y219jm5g
        hFQvN7+wQEiEVJbD1M1DwksKbA==
X-Google-Smtp-Source: ABdhPJyO5nRYykQjZ5CMS3S/+vibAHXkJMz2nRlIfC5YDxd6cIz2T4VjeRMkWl0YnnwiCnUamYDmeg==
X-Received: by 2002:a7b:c14d:0:b0:38c:801a:a8b3 with SMTP id z13-20020a7bc14d000000b0038c801aa8b3mr11732685wmi.40.1648893359903;
        Sat, 02 Apr 2022 02:55:59 -0700 (PDT)
Received: from [192.168.0.170] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b0038e1d69af52sm4436420wmq.7.2022.04.02.02.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 02:55:59 -0700 (PDT)
Message-ID: <e7b2d7d3-b0a8-3937-1947-acb65090dc87@linaro.org>
Date:   Sat, 2 Apr 2022 11:55:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] arm64: dts: nuvoton: Add initial support for MA35D1
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Jacky Huang <ychuang3@nuvoton.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org, cfli0@nuvoton.com
References: <20220331024256.14762-1-ychuang3@nuvoton.com>
 <20220331024256.14762-4-ychuang3@nuvoton.com>
 <0c182962-0da0-c3b3-097a-090bf8d871e7@linaro.org>
 <20220401233422.58670C2BBE4@smtp.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220401233422.58670C2BBE4@smtp.kernel.org>
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

On 02/04/2022 01:34, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2022-03-30 23:32:04)
>> On 31/03/2022 04:42, Jacky Huang wrote:
>>> diff --git a/arch/arm64/boot/dts/nuvoton/Makefile b/arch/arm64/boot/dts/nuvoton/Makefile
>>> new file mode 100644
>>> index 000000000000..e1e0c466bf5e
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/nuvoton/Makefile
>>> @@ -0,0 +1,2 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +dtb-$(CONFIG_ARCH_NUVOTON) += ma35d1-evb.dtb
>>
>> NAK
>>
>> This is actually some resend, but you did not version it, did not
>> provide changelog.
>>
>> What is more - you ignored previously received comments.
>>
>> We do not work like this. If you do not agree with a comment, please
>> keep discussion, not resend ignoring it.
>>
> 
> Please be kind to newcomers. Not everyone has been working on the kernel
> for 10+ years.

Sorry for being harsh.

> 
> Please read Documentation/process/submitting-patches.rst. We should
> probably add some more details to that document about including
> changelogs comparing previous rounds, links to previous rounds for ease
> of discovery, cover letters for multi-patch series, etc.

This is in general explained in:
https://elixir.bootlin.com/linux/v5.13/source/Documentation/process/submitting-patches.rst#L311
Just no one really reads it...

I'll extend that section slightly.


Best regards,
Krzysztof
