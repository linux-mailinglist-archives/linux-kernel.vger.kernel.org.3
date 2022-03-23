Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215024E5502
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbiCWPRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiCWPR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:17:29 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE0419297;
        Wed, 23 Mar 2022 08:15:59 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id z92so2194916ede.13;
        Wed, 23 Mar 2022 08:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=+5MDsgaAS/vAQj+VVJW1W9egaGRomv8qKOjhUnZ2xXE=;
        b=0t63jl0lpUKG54uTV1YPZm63FdVhkAYwVE6p3RYMhEfzIpFETH5JGb5kAbughHULsu
         Wy4rDzfqef5LMXv41lzf7GbHXIAWI0rKjpcgj48GNtCGJrSEatLdPJ9+Ch9H48isC6yN
         yw3IUeAIGYKaq1VJY/oWtU/mGlYFEv5GVLCHcXBN6MSw5enj4xyw4Wx4eeyxYYEK9ItK
         N8nlfyaleFLWrFVk5zAX2ul70yYW87X/QY5ki59WBpxb4yznXQm4UF69EdqOSEEfSsPP
         PCv55Lo+apsCPf836gU2yh/qEodSEdFSFX5CPxLlf+A4EQ1xVB0ZJsyKJuGy4XPvGbC/
         7isA==
X-Gm-Message-State: AOAM530+age+reyBCua1nTPhkfXu0OUBWB0hsGAJgQ8qPokPFPg0PjZY
        06JwE2zZxvw09YcEXXilf/w=
X-Google-Smtp-Source: ABdhPJyNts/hRdd+ry5GZYpRRawYywnSMndvLddMIsO40489tAqxrIs0PMAh5LE+ihwFMqj0SGhHVA==
X-Received: by 2002:a05:6402:298c:b0:418:f55e:fdda with SMTP id eq12-20020a056402298c00b00418f55efddamr687608edb.230.1648048558284;
        Wed, 23 Mar 2022 08:15:58 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm50729eje.183.2022.03.23.08.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 08:15:57 -0700 (PDT)
Message-ID: <f44c9881-6f7b-f4f5-8225-e0c74c83fab1@kernel.org>
Date:   Wed, 23 Mar 2022 16:15:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/7] ARM: dts: s5pv210: Adjust I2S entries to match spec
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <CY4PR04MB056784D54ADDBB4F57F82D4ACB189@CY4PR04MB0567.namprd04.prod.outlook.com>
 <4ebe2bb9-4f92-2dff-6737-d057e5950b24@kernel.org>
In-Reply-To: <4ebe2bb9-4f92-2dff-6737-d057e5950b24@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 16:14, Krzysztof Kozlowski wrote:
> On 23/03/2022 16:03, Jonathan Bakker wrote:
>> Based on the device tree spec, clocks should be ordered tx/rx.
>> Re-order from rx/tx to avoid warnings when running make dtbs_check
>>
>> Additionally, the number of #sound-dai-cells should be 1, not 0
>>
>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>> ---
>>  arch/arm/boot/dts/s5pv210-aries.dtsi |  2 +-
>>  arch/arm/boot/dts/s5pv210.dtsi       | 18 +++++++++---------
>>  2 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
>> index 70ff56daf4cb..503b5a50ef1a 100644
>> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
>> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
>> @@ -644,7 +644,7 @@
>>  };
>>  
>>  &i2s0 {
>> -	dmas = <&pdma0 9>, <&pdma0 10>, <&pdma0 11>;
>> +	dmas = <&pdma0 10>, <&pdma0 9>, <&pdma0 11>;
>>  	status = "okay";
> 
> Except that fix that's the same commit as here:
> https://lore.kernel.org/all/20200907161141.31034-26-krzk@kernel.org/
> so just extend it.
> 
> sound-dai-cells should go to a separate commit. But are you sure they
> are correct? The Fascinate 4G seems to be using them as cells=0.

See my previous patch and discussion:
https://lore.kernel.org/all/20200907161141.31034-10-krzk@kernel.org/


Best regards,
Krzysztof
