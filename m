Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF784FA809
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbiDINM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbiDINMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:12:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37063FBD1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:10:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v15so2871693edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r69gfmWYQUj3kQz0ytrjwX6d+x9monu97mTCKGNU34E=;
        b=h+m4IGpyhiTc9J83wjYFv4Kx2b+wzkpm/PX4pYzjtCA+MWKSO84kOXjbhukcjwIXBr
         yDoijQNRCyKwC+IYdJEUtamQyRrgNubKwPOoaA1NjNuq4IncZOVNytFr7LQct0O/UOQC
         UYhOFjInyOzKsk7/t9erLBRY56v3qTTI3jQ821CESpF0OUUCdu6ohTDMDrWimUwa7Lvl
         1s6X0T+kCVcHQckTIuUWiQJiw7cF7fSENgeDDpag0Yc2OMyVv3z7rOUG/eKusSiQGysK
         lnMdJynsSY7QFidTYwmmFV7Z1C9OmebAwFuRI6sld8AOpe48dBByvRkLoaqug3kvUywL
         LqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r69gfmWYQUj3kQz0ytrjwX6d+x9monu97mTCKGNU34E=;
        b=F+lHUXIvRWINip4MXfBGbXgiYjp0MBJCRU50HnIBbQgUxe4TA5t4qFDmMawszdUSHj
         ed5EEkxoGEFxCO+G8heZTGAwhajsDzhWelL1eFOGbtqzBlsuTIqALYKugoYBx+bQ8ycK
         WiU4VyltPjZSFNnkVTppMLr+kD1sN2CfiYIAhb9lFugrAD71wDVnqQF7t+ETHoVrDnRk
         0XXbTr5IwTioUZWY0Wxanmu0Ba9z6q4xuqqW4VPIEkfziQuYvC+89dzb1AAlvfp8HQyI
         fOb2OtDaIWnCo8A3fOK7QHDJd5O/Uy+zD2I+77j24P5MZa3OuaVp0SgCaWzpF8aSou21
         0Rmw==
X-Gm-Message-State: AOAM530XMSSvuaLtZ806zXbf5tshyp7QT4wZ5bNwmU3kjcSnRtZwA0zC
        i4NBjZMARbMIEC4b1bW4KseoGQ==
X-Google-Smtp-Source: ABdhPJx7msdh9mcbYUpr+/xvQ2lU6xwhmzQw8KoD510T6nd7WxDMx4rlZdWmCrcUJuIidGGR+PA0rQ==
X-Received: by 2002:a05:6402:2747:b0:419:4817:ba22 with SMTP id z7-20020a056402274700b004194817ba22mr23622704edd.253.1649509814373;
        Sat, 09 Apr 2022 06:10:14 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id j12-20020a50e0cc000000b0041cd813ac01sm7809179edl.28.2022.04.09.06.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 06:10:13 -0700 (PDT)
Message-ID: <fb3d736e-4943-fba5-949e-f7c00829facf@linaro.org>
Date:   Sat, 9 Apr 2022 15:10:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 01/18] MIPS: DTS: jz4780: remove cpu clock-names as
 reported by dtbscheck
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <064a1f029a82ea3895109efe8fb1f472581d4581.1649443080.git.hns@goldelico.com>
 <0a0cb08a-3992-7e20-61ca-7856ce273005@linaro.org>
 <B8D9DAF0-435B-4701-84E4-580FAA9CE74F@goldelico.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <B8D9DAF0-435B-4701-84E4-580FAA9CE74F@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 15:02, H. Nikolaus Schaller wrote:
> Hi Krzysztof,
> 
>> Am 09.04.2022 um 13:07 schrieb Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>:
>>
>> On 08/04/2022 20:37, H. Nikolaus Schaller wrote:
>>> arch/mips/boot/dts/ingenic/ci20.dtb: cpu@0: clock-names does not match any of the regexes: pinctrl-[0-9]+
>>> 	From schema: Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml
>>> arch/mips/boot/dts/ingenic/ci20.dtb: cpu@1: clock-names does not match any of the regexes: pinctrl-[0-9]+
>>> 	From schema: Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml
>>
>> No need to put the same warning twice (cpu index really does not
>> matter). One warning is enough.
> 
> Well, how can you as a reviewer see immediately that dtbscheck
> warns for both instances and that they are both really fixed by the
> complete patch?
> 
> Assume there were only the first one mentioned and the second one
> forgotten to fix...
> 
> If it is not included here (completely), you have to run dtbscheck 
> yourself to see that there are two instances involved. Or deduce it
> from looking into the source file.
> 
> In both cases much more work for you or other reviewers.
> 
> This is why I have kept this redundancy. One commit hunk for every
> warning line.
> 
> And it may only look redundant in the commit message, not in code 
> where it would really hurt to have duplication.

Sorry, but the second warning is obvious. It really does not bring any
information and better to keep things simple and concise. Concise helps
to read/understand the commit.

> 
>>
>> Fixing warnings is good, but what if the property should be there and
>> the bindings are not correct? If you know the answer, please add it to
>> the commit msg.
> 
> It has of course been tested on real hardware.

Good, but it's not everything. DTS is a description of hardware and we
might want to have the extended description, e.g. with clock-names.

> There was only one case where the bindings seem to be wrong (patch 13/18).
> 
> And usually I simply assume such generic bindings are tested on many
> other platforms and therefore the reference. What are bindings and
> dtbscheck good for if we doubt them as DTS developers?

You should always doubt, knowing how incompletely or poorly bindings
were written or converted (including the ones I was doing myself).

> 
>> This applies to all your patches. Blind fixing of DTS warnings my
>> produce incorrect results. :(
> 
> Every patch of this series has been tested on real hardware to have
> no negative side-effects.

Which is not everything. DTS might be used in other projects - did you
test them as well?


Best regards,
Krzysztof
