Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946D05A2148
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 08:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244128AbiHZG4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 02:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbiHZG4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:56:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25154D21CE
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:56:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id l8so808358lfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=SqbQj8XwvrArbtJKnmt9Zf1uA1kLdRnqK/niNyv1sDc=;
        b=j88ANkqQJSeW3NR1daQ5tE4tYtmyNcsgSA1BVQkSCUw3mcbELOLbWphiKhwmf92yJJ
         OtrU5HXx9qLv6WH0EHC1RS5i6sYo8ukq3UgViC1VWm2zX54C55dNO9OGFVKkq4QkGMod
         4bzcyljIFZEBfflXHtwoh06isKrmwNCKzoAnJcjr/zUD9Ss1ZJaJbAPLRQfyAsTG5Dkz
         W6znPgD/gsEbTMswOE0JYqFXvPz5HBDzb6wfIkrZiJWPKxgC2Dhg0JZmDfg11lg8h7lT
         bjXcKMJfbb4It2RP86L9cbACbNd1vcwqQnlMeSmIe016XKLZnazeAnjfrtXPeEi9R5k9
         jnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=SqbQj8XwvrArbtJKnmt9Zf1uA1kLdRnqK/niNyv1sDc=;
        b=6nMFSKfn0IkdXF78mIy25iD+nXm1jO4xgf/x1a5twZ37L1jnRr7lwjrAOXzzt8zalZ
         aLRUTyKBsEDtqeU5GbnDfLUHmG87bQOTxhbOPAzFkL8aUv+KGdUuhwk/Rfrnr0NUpbQJ
         /GAJYaiWqx6vF/9rakz41trc062U/RT4DQQyjJ0bh+R5xgbaBTQdYxX24lxo3+Py5wcO
         XTu/soOa2sZN8RuauctAV8u1zi7xQr0oAWov47h9lzatcofBHG3E+Oo/tlKdbvD1myqm
         xVoiNeRmLLXa3kLZYXkRaHefVzu9N0OSOdmKHPDEUuxydydGFenOxTiZb2pohcP2CU6n
         qGJw==
X-Gm-Message-State: ACgBeo3vOO75iQc9oSZHZKpGM8IiPab5g3DD5TZID84iR0RReXR9YaTU
        7Lsm4iVq9FzdGbN31wkr9dDcAA==
X-Google-Smtp-Source: AA6agR5rVL6oodMKRPRuVVcPGlhWgFkt0Kmpo1VNGNOt+q7Dp+2Nq5TbqL6j18yUKqxQTBW5pv9fGA==
X-Received: by 2002:a05:6512:1392:b0:48d:a6b7:caff with SMTP id p18-20020a056512139200b0048da6b7caffmr2230437lfa.154.1661496992392;
        Thu, 25 Aug 2022 23:56:32 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id u5-20020a2e1405000000b0025e49aaae10sm337963ljd.12.2022.08.25.23.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 23:56:30 -0700 (PDT)
Message-ID: <9d25d239-8d40-e639-c5e5-a308bc41d22f@linaro.org>
Date:   Fri, 26 Aug 2022 09:56:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/2] Documentation: devicetree: update bindings for
 tps23861
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     =?UTF-8?Q?Andreas_B=c3=b6hler?= <dev@aboehler.at>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220825143737.77732-1-dev@aboehler.at>
 <20220825150236.GB240395@roeck-us.net>
 <CA+HBbNEEvyn7a-CXzbFHywvHBky-Kwu8O3POrqo=huOJf-n2pQ@mail.gmail.com>
 <20220825152934.GA1439919@roeck-us.net>
 <CA+HBbNH5GGrqN4mUB2hByVuTjc02f_t88pdpKEKXNjxScYyrtw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CA+HBbNH5GGrqN4mUB2hByVuTjc02f_t88pdpKEKXNjxScYyrtw@mail.gmail.com>
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

On 25/08/2022 18:31, Robert Marko wrote:
> On Thu, Aug 25, 2022 at 5:29 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Thu, Aug 25, 2022 at 05:07:45PM +0200, Robert Marko wrote:
>>> On Thu, Aug 25, 2022 at 5:02 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On Thu, Aug 25, 2022 at 04:37:36PM +0200, Andreas Böhler wrote:
>>>>> The tps23861 driver does not initialize the chip and relies on it being
>>>>> in auto-mode by default. On some devices, these controllers default to
>>>>> OFF-Mode and hence cannot be used at all.
>>>>>
>>>>> This brings minimal support for initializing the controller in a user-
>>>>> defined mode.
>>>>>
>>>>> Signed-off-by: Andreas Böhler <dev@aboehler.at>
>>>>
>>>> nack for the series, sorry. The suggested properties are not hardware
>>>> monitoring but phy properties. There should be a separate phy driver
>>>> to manage those.
>>>>
>>>> Also, as mentioned, the hwmon 'enable' attribute is abused to control
>>>> port functionality and should be removed.
>>>
>>> Hi Guenter,
>>> Are you referring to an ethernet PHY driver or the generic PHY framework?
>>>
>>
>> Could be both, though ethernet phy sounds about right for me.
>> I don't know where/how similar chips are handled. hwmon is most definitey
>> the wrong place.
> 
> Hi,
> 
> Well, that is the thing, this is definitively not an ethernet PHY nor
> a PHY of any other kind.
> I dont see where it would fit if not hwmon, there is no more specific
> subsystem in the
> kernel.

It's not hwmon. The device has monitoring capabilities, but it's only
one piece and calling something hwmon just because can provide sensor
data is like calling a plane a car, because it has wheels.

Maybe this is similar to these series:
https://lore.kernel.org/linux-devicetree/20220825130211.3730461-1-o.rempel@pengutronix.de/
?

The datasheet says it is a "PSE Controller" so looks similar to the
problem solved above...

Best regards,
Krzysztof
