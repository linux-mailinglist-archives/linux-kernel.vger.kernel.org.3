Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE45348C61B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbiALOeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiALOeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:34:06 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC0CC061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 06:34:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d19so4715209wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 06:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Oses1sdZzE6O13eZIF71UBM7yla+9G9HCF+w1MELCw=;
        b=rHveY+eHYf20gxvUtQ3ZbD3CRtY15j0Co6y8Vy+0c82fL/vy8jcgRA5hII1ND4X+Uz
         1rnGQcnsq1z34PHma2EBXnaZNCWT5dbKKlltxjXGYSHPyC8zFzACLNcLLNI3xe0G4fOE
         JJm/Zi/+ftK2F2IxiUMFQz4MTSsWaqQiWx/hi4yg3qkZHZkcgrWZRTgE7iXnARR6o9my
         riLlOyHfFt8W1PPI3FdgTOEA23dUp4BYXMuwQ8gafuHMH+OndD8f6AlXR7luEfJnlvWJ
         IPS25MvXra3T3v9iKn8WHiuAyphnAolV4TkxLsf3P7Mkfapp/HjE3iihSlWrI+wwQarL
         bZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4Oses1sdZzE6O13eZIF71UBM7yla+9G9HCF+w1MELCw=;
        b=r5u98znf7/vXZw6+pdGVQAI52tJfJ814RicXHqbePkez6Z4xxXCvf1GNz9wAjxgBtB
         EeJE52KcPWrWUPRvQTzOi7GWtfa4kSp3iuSIw/wKaQhmWedWpvqbwfbc2ThPD1yZRoOE
         n1FV3sXMvZTl08V33yVAcXjow/sSAujRGBSLm2ZjiujxgGkyPlWFoObHYT+KpWZijLXC
         qqriJ40RRWvgOdmrdl4KIWJC4TkhjioCR9z1jD3QOS5t9k5zAU0uePZupetU5uFAMw8V
         SUWTBhzvsGL4pPICLMC3skkIfrxZJYpT1xvM2gN8neibY7ZF+z6bMfn3LPrQkbTMBeq3
         6ltQ==
X-Gm-Message-State: AOAM532z/JuKgkBmbqNLuaNHuvZe3CKP6NzOesRV9c6w1KtgSnStd/At
        x90Akrjw15bWTbx5zDUZPs8AmUpNPFflEw==
X-Google-Smtp-Source: ABdhPJxWIVwvziu7Ekc2HxcKrwLQqn3VV31vWE/7hhVte4oUM7OMRJThUxWG2nlEq9FxgOs0h4P0Kw==
X-Received: by 2002:a5d:584f:: with SMTP id i15mr12405wrf.361.1641998043787;
        Wed, 12 Jan 2022 06:34:03 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:381b:6e50:a892:5269? ([2001:861:44c0:66c0:381b:6e50:a892:5269])
        by smtp.gmail.com with ESMTPSA id g12sm68038wrd.71.2022.01.12.06.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 06:34:03 -0800 (PST)
Subject: Re: [PATCH 3/3] arm64: dts: meson-g12-common: add uart_ao_b pins
 muxing
To:     Gary Bisson <gary.bisson@boundarydevices.com>
Cc:     linux-amlogic@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220103154616.308376-1-gary.bisson@boundarydevices.com>
 <20220103154616.308376-4-gary.bisson@boundarydevices.com>
 <fe58c139-f127-d102-a6a6-b8c2151aac20@baylibre.com> <Yd7RG80hhjZilGs7@p1g2>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <10696e08-80ca-7dcf-9766-60d0a2475c6e@baylibre.com>
Date:   Wed, 12 Jan 2022 15:34:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yd7RG80hhjZilGs7@p1g2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2022 14:01, Gary Bisson wrote:
> Hi,
> 
> On Wed, Jan 12, 2022 at 09:33:42AM +0100, Neil Armstrong wrote:
>> Hi,
>>
>> On 03/01/2022 16:46, Gary Bisson wrote:
>>> - RX/TX signals can be mapped on 2 different pairs of pins so supporting
>>>   both options
>>> - RTS/CTS signals however only have 1 option available
>>>
>>> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
>>> ---
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>>> Cc: Kevin Hilman <khilman@baylibre.com>
>>> Cc: Jerome Brunet <jbrunet@baylibre.com>
>>> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> Cc: devicetree@vger.kernel.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>  .../boot/dts/amlogic/meson-g12-common.dtsi    | 27 +++++++++++++++++++
>>>  1 file changed, 27 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>>> index af1357c48bee..3a7773ffbd08 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>>> @@ -1952,6 +1952,33 @@ mux {
>>>  						};
>>>  					};
>>>  
>>> +					uart_ao_b_1_pins: uart-ao-b-1 {
>>> +						mux {
>>> +							groups = "uart_ao_b_tx_2",
>>> +								 "uart_ao_b_rx_3";
>>> +							function = "uart_ao_b";
>>> +							bias-disable;
>>> +						};
>>> +					};
>>> +
>>> +					uart_ao_b_2_pins: uart-ao-b-2 {
>>> +						mux {
>>> +							groups = "uart_ao_b_tx_8",
>>> +								 "uart_ao_b_rx_9";
>>> +							function = "uart_ao_b";
>>> +							bias-disable;
>>> +						};
>>> +					};
>>
>> I'm not fan of these nodes namings.
>>
>> Perhaps :
>> - uart-ao-b-2-3
>> - uart-ao-b-8-9
>>
>> so the actual pins numbers used are more clear ?
> 
> Sure, I wasn't convinced by that naming either. I although thought
> about:
> - uart-ao-b
> - uart-ao-b-alt

Not sure about these because it means one is the default and the second
is an alternate one, and I'm not sure about that. If it's the case, then
this naming is ok.

> 
> Let me know which one you prefer and I'll respin the patch.
> Also let me know if I should re-send the entire series or just this
> patch.

I'm lazy, so the entire patchset please :-)

Thanks,
Neil

> 
> Regards,
> Gary
> 

