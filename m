Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EAB583B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiG1Jf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbiG1Jf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:35:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15965727B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:35:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so2254271wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:subject:date:in-reply-to:message-id
         :mime-version;
        bh=k3WJMzc4VlzWe028CTMpp0rc55xqANnpObGj9ASfF4g=;
        b=kOiWRnnN6mtieKOLjkH8T/0NvwhYzh0u+fsDATST0slwNj6In1/nzfpCUEkvXm7Pyk
         O/2OKtZs1s4n4YFLLn78mYDpEhfEGHm62+fkQZWOyUz/SEbcaUnE9VKWANHVfee0vKD+
         QQjzOWZVkRGBmbP+ld5BkAyuZbQ/CaVT+aAvvbFHaNer0Hr8ncc99WZ3ua5goVCC6Ahw
         XG+RS0KBxgVyH7uiruCjp6x3+yowOOT+5dFJZtNdB5qeEcDKQLfrMMlq4WQ5CUxQUJte
         Y7aQe6ROKacO/PpnXLfb8LmfCkEGVkvsb1YrN9d9+qwOmZeKKUz3Mu43NYu27HJBzICF
         QTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:subject:date
         :in-reply-to:message-id:mime-version;
        bh=k3WJMzc4VlzWe028CTMpp0rc55xqANnpObGj9ASfF4g=;
        b=3fTsld+2J/jceL7EWJZ6F7ohb0qlcrgEkGaOJU6yj960aPFd893NbmfZ1PMFSBHRCD
         bztA7OrmlKewV6VOf/I5sLad6KTFwECqRf7B9CT4Nwv/6bug5wb5Fy768QUTsch9Sntq
         dFPHB/TZ+sek9Xl/Vq4YGqRk0mmW5ekjsseAOMSsxLAKG9vgmYDkdUHKN6Su2aBHIcVK
         InGB2lQjsKJu76vnRRBZusuOXUPJKcsjHe5XHlpOom6SyXDIFywtJoCyrcvgYQ3qkEjI
         VrlW87d+1OF9lWm+XASVDmVrpxC8aFAKYPBlK5OgSo9R0ehxoRNud1H2jpTp7EzuCrfE
         y6Og==
X-Gm-Message-State: AJIora+4WtdfvDKDyFURY4WLPSEmMREzdX739Hj9kK8AKPZ3hcF2MGnl
        tZpAJVWFOHIdmXiPi91Uvm3uEg==
X-Google-Smtp-Source: AGRyM1urGG1USTxB/ciyzDD0khYnDOQsI8Zs2PyCwuGAPjHdiKK1K1HzIvms+8txwfUegpyR48kRGg==
X-Received: by 2002:a1c:2783:0:b0:3a2:fd82:bf46 with SMTP id n125-20020a1c2783000000b003a2fd82bf46mr5863699wmn.29.1659000923324;
        Thu, 28 Jul 2022 02:35:23 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b003a2e1883a27sm6126778wmq.18.2022.07.28.02.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 02:35:22 -0700 (PDT)
References: <20220728054202.6981-1-yu.tu@amlogic.com>
 <20220728054202.6981-2-yu.tu@amlogic.com>
 <82e3fd36-df96-a555-4cea-47fabd26502b@linaro.org>
 <1jv8rhfw8h.fsf@starbuckisacylon.baylibre.com>
 <367cf98b-ef06-8f44-76c8-9099a1ec13dc@linaro.org>
User-agent: mu4e 1.8.6; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V2 1/3] dt-bindings: clk: meson: add S4 SoC clock
 controller bindings
Date:   Thu, 28 Jul 2022 11:09:52 +0200
In-reply-to: <367cf98b-ef06-8f44-76c8-9099a1ec13dc@linaro.org>
Message-ID: <1jmtctfuli.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 28 Jul 2022 at 11:02, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 28/07/2022 10:50, Jerome Brunet wrote:
>> 
>> On Thu 28 Jul 2022 at 10:41, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>> 
>>> On 28/07/2022 07:42, Yu Tu wrote:
[...]
>>>> +/*
>>>> + * CLKID index values
>>>> + */
>>>> +
>>>> +#define CLKID_FIXED_PLL			1
>>>> +#define CLKID_FCLK_DIV2			3
>>>> +#define CLKID_FCLK_DIV3			5
>>>> +#define CLKID_FCLK_DIV4			7
>>>> +#define CLKID_FCLK_DIV5			9
>>>> +#define CLKID_FCLK_DIV7			11
>>>
>>> Why these aren't continuous? IDs are expected to be incremented by 1.
>>>
>> 
>> All clocks have IDs, it is one big table in the driver, but we are not exposing them all.
>> For example, with composite 'mux / div / gate' assembly, we usually need
>> only the leaf.
>
> I understand you do not expose them all, but that is not the reason to
> increment ID by 2 or 3... Otherwise these are not IDs and you are not
> expected to put register offsets into the bindings (you do not bindings
> in such case).

Why is it not an IDs if it not continuous in the bindings ?

If there is technical reason, we'll probably end up exposing everything. It
would not be a dramatic change. I asked for this over v1 because we have
done that is the past and I think it makes sense.

I'm happy to be convinced to do things differently. Just looking for the
technical reason that require contiuous exposed IDs.

The other IDs exists, but we do not expose them as bindings.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/meson/gxbb.h#n125

>
>
>> Same has been done for the other AML controllers:
>> For ex:
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/dt-bindings/clock/gxbb-clkc.h
>
> This cannot be fixed now, but it is very poor argument. Like saying "we
> had a bug in other driver, so we implemented the bug here as well".

I agree, "done before" is not a good argument. I was trying to provide a
better picutre. I'm just surprised to have this new requirement that IDs
have to be incremented by 1 (in the bindings) and I'd like to understand
why what we had done could be considered a bug now.

For example the simple-reset driver compute the reset offset from the IDs:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/reset/reset-simple.c
There might be holes in the IDs if not all bits have reset maps.
I don't think that would be a bug either.

>
> Best regards,
> Krzysztof

