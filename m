Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BB3532642
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiEXJUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiEXJUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:20:11 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF36E6D391
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:20:10 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id i23so20160532ljb.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gmC1VcL8yscCI1x9Ja1ww8OKwee0RnTTrztFQlz77Bc=;
        b=o4XvKcc2tDfYpFiGcIER/TkQLhWEG2NxgGdVOxts/6PecWelAhA4ZFGPNSGH+clTjA
         eVVRKwj3bZsR3XujzfOZDuLsxqer9PqF+7/9THqEj86Q9dv3UqDBTF3zk7LFt0CpfU+T
         OlW5k++WMSn8Oi99afEDvxYriEt2tENWgR0rLuJyG6p0iiCnFx0Tkwtvx83RVbIAvUUJ
         +mDvthDpqAq2/Qe2ppbqVKkgNT1ERAaYJPWiKFCDVo/xiYxvwhumP4pJN7OGGSCqxvxg
         nKaShYV3SHGTX/08yc3Y9nqIG7JasCJqQ3h9CBimib4ZQ0zxLceq/LfqFAzzInr4186O
         529A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gmC1VcL8yscCI1x9Ja1ww8OKwee0RnTTrztFQlz77Bc=;
        b=kcJqGY8ZGPHZUZjanw3dCtGCNUP7/0hT6+JYJ2fh7W9zcOJusJi7CvjrB57l4Jwj37
         gs0Lq8Kn9jyU1XbMsjUlYQlRUQl/HEY8jS/QnfaLi/e3um9+Pbqq/agCMesdLQgfKPA3
         be+mqqbYRnFtM2cQrM3+yHgMpMft7NeARU5OzYkHCsmV69TYgcxqtTDDgIkQVR5KHHIN
         VW9VmIW/7o9Oo+mFoTid+Q8ersnJNUdb6Vxwk7RGlYfgf5vDbqtvCH7Tm78bZ3fYJ0PB
         oqz0NHtQFapxrwmFfBtxGx3YzyZtzWms8HMH3LDixlRhygbnq5nw0D/IzjALFphZGWKm
         Wdyg==
X-Gm-Message-State: AOAM532QkZO8JGG7qUV4NF6wIoNxjJEZPnvvYbvHk0+dQJHn5P2uPM7C
        T1WDALgtIaYKJL2Dkiohrg/Bhg==
X-Google-Smtp-Source: ABdhPJwsP8QIHu0YwsuqV3LIiclR/+y+mpo9Hp0+N+CZrmjMY1lkIzPrYWaAmSBYM5tGyraII/mBLw==
X-Received: by 2002:a2e:a41a:0:b0:253:c96a:4e15 with SMTP id p26-20020a2ea41a000000b00253c96a4e15mr14939717ljn.195.1653384009037;
        Tue, 24 May 2022 02:20:09 -0700 (PDT)
Received: from [172.20.68.48] ([91.221.145.6])
        by smtp.gmail.com with ESMTPSA id b8-20020ac24108000000b0047408564c31sm2429755lfi.286.2022.05.24.02.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 02:20:08 -0700 (PDT)
Message-ID: <1546297c-6627-574e-4b30-4b8dbf95a851@linaro.org>
Date:   Tue, 24 May 2022 11:20:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] ARM: dts: imx: Add devicetree for Kobo Aura 2
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de,
        alexander.stein@ew.tq-group.com, marcel.ziswiler@toradex.com,
        linux@rempel-privat.de, matthias.schiffer@ew.tq-group.com,
        cniedermaier@dh-electronics.com, sebastian.reichel@collabora.com,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        nicolecrivain@gmail.com
References: <20220522214415.254959-1-andreas@kemnade.info>
 <20220522214415.254959-3-andreas@kemnade.info>
 <402c7e38-7ad0-581f-146d-3db88e77d37c@linaro.org>
 <20220523210542.0735dd5f@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220523210542.0735dd5f@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 21:05, Andreas Kemnade wrote:
> On Mon, 23 May 2022 12:03:09 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> [...]
>>> +
>>> +	gpio_keys: gpio-keys {
>>> +		compatible = "gpio-keys";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&pinctrl_gpio_keys>;
>>> +
>>> +		cover {  
>>
>> Generic node names. You could add suffix if needed, so either key or
>> key-cover.
>>
> hmm, the example in
> Documentation/devicetree/bindings/input/gpio-keys.yaml
> 
> shows names like I did. I usually expect to trust binding documentation
> to have something acceptable.

It's only an example and no one usually cares about correcting it, once
it got merged.


Best regards,
Krzysztof
