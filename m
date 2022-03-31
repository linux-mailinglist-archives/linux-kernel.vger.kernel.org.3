Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F4F4ED593
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiCaI2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiCaI15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:27:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B7FC6EFE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:26:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id c10so28091238ejs.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wSpQ7kqPRes8y+BZixCtHBBiimor8r8yx7SKBxj6uhY=;
        b=nWwIJGsTAKrLDuHNXKIXHp9RpvIRgtxeWtzVp+O/Y/A8RzskUgdcBk+Wj+IoIAESe/
         bmX7I7pRcJ3BYrAXmQtTCAekUuCm2oFpWmHoqAau0q7EGeth5Str74hkdeaLuuv4ERck
         m/+shJR/zREUNt+oC2zayqP9aR8d322VREq4FU3eRWzdb1KBsEsHtrhjLTB3yWNAFoOl
         WsldT9mpQf2QyKN9lENzjCaRB+LwNz55KcCuZh0rVc4GqP2KenBKBCZatBVXtKrnQo5O
         XApijhtU+VtZTFtkXzDzAX4nRnKqWphvpVviT5pHsqoYGw8NWdPFZtBOzKVDFJiYdc6j
         IR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wSpQ7kqPRes8y+BZixCtHBBiimor8r8yx7SKBxj6uhY=;
        b=Zz0deWRPVHTNzZ18iRWIjRO4n/g/fj5lArS73z5SumANmXLbW/t7DY5S5R9zJlPnls
         8btY4KCtk1ZldVYQ+8SPyP130H4qynCfjmCQXe34BCqukzRpgAfJwPY+aaZc5AAmcgYU
         aUt9D19XYulGZKbDV5CcxHwfZXM9ioiY+dz/XvApNVDF0AufrDqrsd80aOt9gmdJWznQ
         i30brXowTB2WARP9H1tnYpSRjFx2XIvy5e88MOVr1LuUviZg2Ay9EBadgG0vcTi03Jps
         GsgUYe4iOUj9eIKBJrINZJv6pjb2FlhW8ADYcwbQjzvVCj64kD3tcj44hO+01cfYbaDC
         Obdw==
X-Gm-Message-State: AOAM530nVlCR1InqHUig9+W/Z3im/ODGLW5Ox5mPAexPEfDlNHxkHHZR
        iGS0nsE+AkW4OqYDCmTHH196OQ==
X-Google-Smtp-Source: ABdhPJwF+TCl2dlZMkSxyCJJT3DeIcHZ/t9GgyB741Ak637RCd4tSwotlqumdO66bQuGcUviRlGudQ==
X-Received: by 2002:a17:907:a0c8:b0:6df:ef3c:5eb6 with SMTP id hw8-20020a170907a0c800b006dfef3c5eb6mr4052580ejc.646.1648715168694;
        Thu, 31 Mar 2022 01:26:08 -0700 (PDT)
Received: from [192.168.0.165] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id hs12-20020a1709073e8c00b006dfdfdac005sm9233409ejc.174.2022.03.31.01.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 01:26:08 -0700 (PDT)
Message-ID: <224d1d98-5d6f-515e-feef-a1ebf20a90d9@linaro.org>
Date:   Thu, 31 Mar 2022 10:26:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/5] dt-bindings: sound: Add Apple Macs sound system
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik@cutebit.org>
Cc:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-2-povik+lin@cutebit.org>
 <9e3ba11c-d179-c229-fb7c-bf5611a15b1b@linaro.org>
 <DAFA4249-4B0A-4D1F-A36A-4352FE783488@cutebit.org>
 <0f7677ba-bffa-7ec6-7c74-3fad84a1d2c5@linaro.org>
 <E5F73642-DF9A-46ED-B310-7D69CAE22C82@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <E5F73642-DF9A-46ED-B310-7D69CAE22C82@cutebit.org>
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

On 31/03/2022 10:23, Martin Povišer wrote:
> 
>> There should be some maximum of supported codecs. Hardware might have
>> such constraints. If really unsure, choose some reasonable (small)
>> amount. It could be later raised, if needed.
> 
> There are some constraints but technically not in the driver that binds
> on this binding. I thought no limit is better than an arbitrary one, but
> if the preference is to have one, I will add it, no problem.

Just to clarify this - bindings are not about the driver, but about the
hardware. We model here the hardware and its programming model, not the
driver implementation (although of course it's always somehow related).
Hardware has some limitations for sure. The question is whether we know
them. :)

I prefer even arbitrary limit, because then schema will check DTSes for
simple mistakes. You can also explain this in commit msg, that maxItems
are arbitrary, so whoever in the future wants to change it, will know
the background.

Best regards,
Krzysztof
