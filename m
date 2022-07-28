Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9945583E11
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbiG1Lu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbiG1LuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:50:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A83D108
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:50:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n185so821586wmn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:subject:date:in-reply-to:message-id
         :mime-version;
        bh=FxwqpjhD9/gLaQrnTT9TOXORIlpv5bjNu3/8g5til8A=;
        b=nTEylWFWV5aRYXQnjm2kiRjVJlk7CEQjzrUBHIDJnxn+cY0Vj8Q7ezPN7FgIiJK/+v
         ine2IGE+ebrioKCcdP9pPI+ICu9WtJvFA+PUXlNmr8SoGEJwVEgcyeHUlpHnXNjI/HmY
         pLvlZNwoi1m0h5/WHucjBDABR1SPLS8arubysiloaSV92rt9yiaiMG3l9yCH5l/aQ3/9
         s+IwJzB984E9vKSpdLwuxLICOc1sgE4UtWWOy3UrfagJPHpMHyDvMoK4x3Cyq1tORPeE
         gbi0d45zdtr7iycIpE5AhCbM8wEKpE9OrycAhoQLkNBUjTUoAZMsEcibmKdyhO0fjDjX
         21yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:subject:date
         :in-reply-to:message-id:mime-version;
        bh=FxwqpjhD9/gLaQrnTT9TOXORIlpv5bjNu3/8g5til8A=;
        b=ejaPUmpG9TyNHBpxddyXTDjYWywTTpPbXnPue5AMwaNMENrAmf0ZrAhPtwIrXviVzB
         aUfo8GGZXlFRcr6XDW9Wjq7QZAkqyhNaD9mkIXbMI830RBmPNgcTr2JA2fNDRxJJO7Rl
         CstsPRn8O/uGiBt321iNGvm2kHyhGQItO+Bj6VZSSwJLmVccK97ydUGaejOWICGWVN5O
         czz3znHp28+idzab9sg3rDgSmD/3jzAqVcADV+mlXP6tg51Iz0ybXTYiEc28WtkX11/v
         Yslf9ymjdYouPwo6geSz845wjAVwW00bo2KQ+0AdNzKDw4eKolKLtpnnbpHVoIVtBvW1
         a0mg==
X-Gm-Message-State: AJIora+rb8ILgFf2lJLvPCPzb9cTT9/+LVwN/EIczVMvEPTgAH6/F+eP
        RHxHdRqqeyZZmr5a5O7ojbYbxg==
X-Google-Smtp-Source: AGRyM1v0j0TKqWnZsAUWLQ3B4oY6N7U+8YetS6WSCx/Q+1LpG7g7jTIsnd/U+8JWEBXprZeoB78iww==
X-Received: by 2002:a7b:c453:0:b0:3a3:1c65:ff97 with SMTP id l19-20020a7bc453000000b003a31c65ff97mr6046013wmi.180.1659009015199;
        Thu, 28 Jul 2022 04:50:15 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003a2d6c623f3sm5639135wms.19.2022.07.28.04.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:50:14 -0700 (PDT)
References: <20220728054202.6981-1-yu.tu@amlogic.com>
 <20220728054202.6981-2-yu.tu@amlogic.com>
 <82e3fd36-df96-a555-4cea-47fabd26502b@linaro.org>
 <74cd833a-4773-eeb0-80aa-75ea1cdc093e@amlogic.com>
 <39395257-703b-a5e9-17c3-80f79f67fdc7@linaro.org>
 <ff582551-9661-4404-c00e-853bc60907cc@amlogic.com>
User-agent: mu4e 1.8.6; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
Date:   Thu, 28 Jul 2022 13:48:14 +0200
In-reply-to: <ff582551-9661-4404-c00e-853bc60907cc@amlogic.com>
Message-ID: <1jbkt9focq.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 28 Jul 2022 at 18:19, Yu Tu <yu.tu@amlogic.com> wrote:

> On 2022/7/28 18:09, Krzysztof Kozlowski wrote:
>> [ EXTERNAL EMAIL ]
>> On 28/07/2022 12:05, Yu Tu wrote:
>>> Hi Krzysztof,
>>> 	Thanks for your reply.
>>>
>>> On 2022/7/28 16:41, Krzysztof Kozlowski wrote:
>>>> [ EXTERNAL EMAIL ]
>>>>
>>>> On 28/07/2022 07:42, Yu Tu wrote:
>>>>> Add new clock controller compatible and dt-bindings header for the
>>>>> Everything-Else domain of the S4 SoC.
>>>>>
>>>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>>>
>>>>
>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index c1abc53f9e91..f872d0c0c253 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -1775,6 +1775,7 @@ F:	Documentation/devicetree/bindings/clock/amlogic*
>>>>>    F:	drivers/clk/meson/
>>>>>    F:	include/dt-bindings/clock/gxbb*
>>>>>    F:	include/dt-bindings/clock/meson*
>>>>> +F:	include/dt-bindings/clock/s4-clkc.h
>>>>>       ARM/Amlogic Meson SoC Crypto Drivers
>>>>>    M:	Corentin Labbe <clabbe@baylibre.com>
>>>>> diff --git a/include/dt-bindings/clock/s4-clkc.h b/include/dt-bindings/clock/s4-clkc.h
>>>>> new file mode 100644
>>>>> index 000000000000..b686c8877419
>>>>> --- /dev/null
>>>>> +++ b/include/dt-bindings/clock/s4-clkc.h
>>>>
>>>> Filename with vendor prefix, so:
>>>> amlogic,s4-clkc.h
>>> It's fine with me. It's mainly Jerome's opinion.
>> To clarify: I understand such naming might bring inconsistency, but we
>> want to bring some order in the bindings directories. They keep growing
>> and at some point the model names might start conflicting.
> If Jerome agrees, I will change it according to your opinion and make
> another edition.

I'm aligned with Krzysztof on this. Please add the vendor prefix.

It was mistake to omit the vendor prefix. Unfortunately, I don't think
we can fix the old bindings now.

>
>> 
>> Best regards,
>> Krzysztof
>> .

