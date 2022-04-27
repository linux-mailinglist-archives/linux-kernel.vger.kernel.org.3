Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2525110FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358018AbiD0GQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358012AbiD0GQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:16:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C054C3FBD9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:13:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r13so1324352ejd.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M6ZPQXjtDv6onFD4afq4GkFFVfxEBQyXu2ilHEOk3B0=;
        b=WXBNan9l5LOdlgI3ht6e86r76ztL3T/1ePM8EyZh5+dGJOPrEACNq6UoxBfBjltjw/
         sma2OsBA00i4yRkh4sjoyyTSfpRqkpIfVj92QM+oCuqG8PXFCol3OYvd5oXo0+OM0GTE
         D1EenVi7orLwNp5SrPxrxeyXPvww4xx5tjpjPkQFq6DeEdDOLWPb6GudI8GC197dDITI
         fF3chFA/Ims/jC9WAUI638aHyR8lkzxp43ZR+fowF16CzFBiug3CnUKEBikwCsia5Cf6
         kq3L4TKGA29I5UR0E3/Vdmcn1tOnRMI/g4NbIfWE5MhHZpvangpE0zVO+7qd7qVM94HA
         YhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M6ZPQXjtDv6onFD4afq4GkFFVfxEBQyXu2ilHEOk3B0=;
        b=cYpJBr6GxKAL12Y0cSV44fhs0r9curquM6qrl4/p79Z7q52sX06ey3ytEDgIcgH8KE
         e9XJUIyTmqMDuDA1GjOV6tIifc4uzfsRNzHPoqecfy4vkF2gVhK/eEIIptVqTrLNetFW
         0joVTWW0v3kUJj9AL3ZrY3azE+g0988sk5Ww+32l+SnDaLd6U3FN2xy79rWzwJUtzQl7
         JNs9CkZRpt27lRmxUt+huJjdDkAZe+b41PJCxeL3sEjryLqVydtwtsMhL6vfUAc1Sbo8
         NkupsZqfikftpzdOiWkCm9VM/PxkBPJXV/6PuJmdF6Ykq4HxsZqSVJRHeefLiqbiU8l3
         6U8w==
X-Gm-Message-State: AOAM532ossqONMLpr7ObDg6tGCURHODB2k7cyxXZem+C4tVuwxhXjJZg
        nKyXOvSuQ3Q0k7vok6c6e3yRMA==
X-Google-Smtp-Source: ABdhPJzg9VXnth/VzikUzUVBYmYJsgTjrbAA1Nt+6D2ECaWb8uK2+mqVueHqYBaayAlbzhxyWBRHOQ==
X-Received: by 2002:a17:906:7d5:b0:6f3:a6a5:28c6 with SMTP id m21-20020a17090607d500b006f3a6a528c6mr9472321ejc.11.1651040014283;
        Tue, 26 Apr 2022 23:13:34 -0700 (PDT)
Received: from [192.168.0.252] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l19-20020a1709067d5300b006e8488d9a80sm6168456ejp.59.2022.04.26.23.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 23:13:33 -0700 (PDT)
Message-ID: <43e42d72-f195-df67-d6ba-8feea1bc7e26@linaro.org>
Date:   Wed, 27 Apr 2022 08:13:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 1/3] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
Content-Language: en-US
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220418125630.2342538-1-gengcixi@gmail.com>
 <20220418125630.2342538-2-gengcixi@gmail.com>
 <714caf6e-5f81-6d73-7629-b2c675f1f1d4@linaro.org>
 <CAF12kFv6uioc7ATtXLpGTTDBFT1wYWZUBoyjQqP1bSUnut0pKA@mail.gmail.com>
 <a5a59f3c-00a3-afc5-24aa-1ae3de2600ec@linaro.org>
 <CAF12kFu5KW+fw=0kP6LrEqOvKYR38mELfPjG64=n+gudRxsZUQ@mail.gmail.com>
 <baa73bda-91af-8a31-67f4-6d5615862c73@linaro.org>
 <CAF12kFsxqdYERwhjC3tq9bNqzWS3P6Sb7VPCwHmQ=StF28Q-+A@mail.gmail.com>
 <5b00db5b-b179-af0f-71e4-e940c6a41018@linaro.org>
 <CAF12kFt=L7CV5RDBViPSNb9Y_Te4JJ-TZrx2N+w_P2px7_FemQ@mail.gmail.com>
 <0423e827-9592-ce6f-74ca-111a099a263f@linaro.org>
 <CAF12kFuwgGJSXpC8e=6L1XgP4zFOjbdLazwuqR0jg=2OJ=RtRA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAF12kFuwgGJSXpC8e=6L1XgP4zFOjbdLazwuqR0jg=2OJ=RtRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 07:40, Cixi Geng wrote:
>> You need to help me here with the naming. What is "global registers"
>> range? Let's focus on sharkl3.dtsi and syscon@4035c000 with "rpll".
>>
>> You have a clock controller @4035c000, which provides several clocks,
>> right? Then you have a rpll also @4035c000, so the register range is the
>> same. The register range is the same, isn't it?
> 
> the anlg_phy_g5_regs is not a clock controller.
> In fact, this is just to provide an address for other modules to call regmap.
> not provide a clk interface or device.
> The clk configuration of rpll is based on the anlg_phy_g5_regs register.
> The analog_g5 asic document is not only used to configure rpll, but also other
> functions can be configured, but currently our driver is only used to provide
> configuration rpll, so the range of the device node of rpll can be less than or
> equal to the range of anlg_phy_g5_regs.
> Hope this could explains your question

I see, thanks for explanation. Indeed making entire @4035c000
(anlg_phy_g5_regs) a clock controller would not match actual hardware,
since rpll clock is a small part of it. I am afraid though, that you
will duplicate such pattern even for the cases where that
design/register range would be suitable to be a clock controller and a
syscon. In one device.

Please fix the other comments in my review - except this discussed here,
the last one from email:
https://lore.kernel.org/all/714caf6e-5f81-6d73-7629-b2c675f1f1d4@linaro.org/


Best regards,
Krzysztof
