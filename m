Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C11507219
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354028AbiDSPum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354015AbiDSPui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:50:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0CB1DA4F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:47:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ks6so33850228ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rywWV/1Z8bflEpBPWvvVmEX4jfvsS4lw1rTLuCBMv+U=;
        b=yyJYA18i5CR/Ldqx3sEAPjqEpMWAZMqJGwjEfDFdUb2wHw8b7W4PewFQaVqH8r7d8M
         4VzCbyroFDLt1Vak20r4wAvKZrNDkCQYcDu3xco9cX1mm2Xt0jGQAUwt4iX0HlegBuLv
         g4qTkbb/1VPsEPsv1tVwZUPQkgP5WL00o5PdE7Cz6x2c5JWkM0JaLOSnS0RxkO1D/cn7
         XYIiJ4HXZpoLTS1mMxeqzCrCu99gXdKS2lL5f6necH1DD80uSL29exI1RcWUOi3irQXW
         iGARYJE2vZWyV2u1GHkxupev7hA143MgpumBM/KR62nt5Qg9mgD3gGhtGkZULAXNFkrr
         eVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rywWV/1Z8bflEpBPWvvVmEX4jfvsS4lw1rTLuCBMv+U=;
        b=alP+C7LfrOEZx08svlSfX8dV2C9ibfzeEtSIdxW/KP/4PpEzmOuLv6hgR75CfIwnzg
         SUFBHhh7gMx8F4yj/Bewd9TYuUagL/6NE/mv1YxZPPiSeaYMDTbZI50U1OnsYlW6jIm3
         dzlT7NrcQ/bLdruKlZmDDG0aJ04kkU6+zMM2Sxjx1jL82J0O0U6sTf5nRvaJ3mCec06a
         /tAXqdIe313M3VYhDFyUBdwOCELX2iR4E8ds3k3YCysIie262L/r1weLgq+i+BJIlhHF
         ct/Oe3qZWrKQGvSXoW7zOBugn6fJPxSBQNxO/zjJLNFa18+zzn7qF+lhVkH5H0HmHe3n
         eHug==
X-Gm-Message-State: AOAM531Iuf/y7Rwp7pHLgXyIlpHswMWA39GqiINKf3+gZYb1Bz4KrTks
        RcMZ5ho4JrNHOIK006MVwu1NNwSldlwo+w==
X-Google-Smtp-Source: ABdhPJy87hiOiQgRoK0mL7fyRVNX2TPUGk8hoRdfc8hv4EulKC4CHVhnwEIzEbGto5FL+m/hWyHJAQ==
X-Received: by 2002:a17:907:9868:b0:6e8:7ae3:7f42 with SMTP id ko8-20020a170907986800b006e87ae37f42mr14321317ejc.224.1650383273992;
        Tue, 19 Apr 2022 08:47:53 -0700 (PDT)
Received: from [192.168.0.220] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id kk23-20020a170907767700b006e8a6e53a7bsm5779313ejc.139.2022.04.19.08.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 08:47:53 -0700 (PDT)
Message-ID: <606cc762-a0c2-49a4-3e5d-d2dbd4595bc7@linaro.org>
Date:   Tue, 19 Apr 2022 17:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
 <a0eb6bf9-256a-29b1-2211-496df710f531@linaro.org>
 <CAD=FV=UjyLofXZqnj=bL89fza5JS6O5Np9W-A4V4WK+na0hdrw@mail.gmail.com>
 <b7ff08b8-60fb-7629-9399-3d5cca46ab9e@linaro.org>
 <CAD=FV=Vx5g_xTRZGc9wW=ZLnfsOcubTYFcnYQRC5jLm+n3en0w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=Vx5g_xTRZGc9wW=ZLnfsOcubTYFcnYQRC5jLm+n3en0w@mail.gmail.com>
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

On 14/04/2022 19:36, Doug Anderson wrote:
> Hi,
> 
> On Thu, Apr 14, 2022 at 12:10 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 13/04/2022 23:48, Doug Anderson wrote:
>>> I'm actually kinda curious: is there really a good reason for this? I
>>> know I haven't been adding things to
>>> `Documentation/devicetree/bindings/arm/qcom.yaml` for Qualcomm
>>> Chromebooks.  Ironically, it turns out that the script I typically use
>>> to invoke checkpatch happens to have "--no-tree" as an argument and
>>> that seems to disable this check. Doh!
>>>
>>> That being said, though, I do wonder a little bit about the value of
>>> enumerating the top-level compatible like this in a yaml file.
>>> Certainly the yaml schema validation in general can be quite useful,
>>> but this top-level listing seems pure overhead. I guess it makes some
>>> tools happy, but other than that it seems to provide very little
>>> value...
>>
>> If compatible is not part of ABI, it is allowed to change in whatever
>> shape one wishes. In such case, how can anyone (e.g. user-space)
>> identify the board? Model name? Also not part of ABI (not documented)...
> 
> Hmm, it is a good question. I guess one issue is that the way
> Chromebooks interact with the bootloader it's not trivially easy to
> enumerate what exactly the compatible will be in this hardcoded list.
> It all has to do with the whole "revision" and "sku" scheme the
> bootloader on ARM Chromebooks uses. For example, on one Chromebook I
> have the bootloader prints out:
> 
> Compat preference: google,lazor-rev5-sku6 google,lazor-rev5
> google,lazor-sku6 google,lazor
> 
> What that means is that:
> 
> 1. The bootloader will first look for 'google,lazor-rev5-sku6'. If it
> finds a dts with that compatible it will pick it.
> 
> 2. The bootloader will then look for 'google,lazor-rev5'. If it finds
> a dts with that compatible it will pick it.
> 
> 3. The bootloader will then look for 'google,lazor-sku6'. If it finds
> a dts with that compatible it will pick it.
> 
> 4. Finally, the bootloader will look for 'google,lazor'.
> 
> There's a method to the madness. Among other things, this allows
> revving the board revision for a change to the board even if it
> _should_ be invisible to software. The rule is always that the
> "newest" device tree that's in Linux is always listed _without_ a
> board revision number. An example might help.
> 
> a) Assume '-rev5' is the newest revision available. In Linux this
> would be the only dts that advertises "google,lazor" (with no -rev).
> Previous dts file would advertise "-rev3" or "-rev4" or whatever.
> 
> b) We need to spin the board for something that should be invisible to
> software. Just in case, HW guys change the board strappings to -rev6.
> This works _seamlessly_ because the newest dts file always advertises
> just "google,lazor"
> 
> c) We spin the board for something that's _not_ invisible. It will be
> "-rev7". Now, we go back and add "-rev5" and "-rev6" to the old board
> dts file and remove the advertisement for "google,lazor". We create a
> new dts file for -rev7 that advertises "google,lazor".

Except shuffling the compatibles in bindings, you are changing the
meaning of final "google,lazor" compatible. The bootloader works as
expected - from most specific (rev5-sku6) to most generic compatible
(google,lazor) but why do you need to advertise the latest rev as
"google,lazor"? Why the bootloader on latest rev (e.g. rev7) cannot bind
to rev7 compatible?

> Now we can certainly argue back and forth above the above scheme and
> how it's terrible and/or great, but it definitely works pretty well
> and it's what we've been doing for a while now. Before that we used to
> proactively add a whole bunch of "future" revisions "just in case".
> That was definitely worse and had the same problem that we'd have to
> shuffle compatibles. See, for instance `rk3288-veyron-jerry.dts`.
> 
> One thing we _definitely_ don't want to do is to give HW _any_
> incentive to make board spins _without_ changing the revision. HW
> sometimes makes spins without first involving software and if it
> doesn't boot because they updated the board ID then someone in China
> will just put the old ID in and ship it off. That's bad.
> 
> --
> 
> But I guess this doesn't answer your question: how can userspace
> identify what board this is running? I don't have an answer to that,
> but I guess I'd say that the top-level "compatible" isn't really it.

It can, the same as bootloader, by looking at the most specific
compatible (rev7).

> If nothing else, I think just from the definition it's not guaranteed
> to be right, is it? From the spec: "Specifies a list of platform
> architectures with which this platform is compatible." The key thing
> is "a list". If this can be a list of things then how can you use it
> to uniquely identify what one board you're on? 

The most specific compatible identifies or, like recently Rob confirmed
in case of Renesas, the list of compatibles:
https://lore.kernel.org/linux-devicetree/Yk2%2F0Jf151gLuCGz@robh.at.kernel.org/

> If all of the things
> that are different between two boards are things that are probable
> (eDP panels, USB devices, PCIe devices) then two very different boards
> could have the exact same device tree, right? ...and you could have
> one device tree that lists the compatible of both boards?

What is the question here?

> 
> That all being said, I think that on Chrome OS the userspace tools
> _do_ some amount of parsing of the compatible strings here. For
> Chromebooks they leverage the fact that they understand the above
> scheme and thus can figure things out. I think they also use things
> like `/proc/device-tree/firmware/coreboot/board-id` and
> `/proc/device-tree/firmware/coreboot/sku-id`. That doesn't seem to be
> documented, though. :(
> 
> I guess the question is, though, why do you need to know what board you're on?

You might have (and I had in some previous job) single user-space
application working on different HW and responding slightly differently,
depending on the hardware it runs. Exactly the same as kernel behaves
differently, depending on DTB. The differences for example might be in
GPIOs or some other interfaces managed via user-space drivers, not in
presence of devices. Another example are system tests behaving
differently depending on the DUT, where again you run the tests in a
generic way so the DUT is autodetected based on board.

Of course you could say: different hardware, has different DTB, so
user-space should check entire tree, to figure out how to operate that
hardware. Yeah, that's one way, very complex and actually duplicating
kernel's work. Embedded apps are specialized, so it is much easier for
them to check board compatible and make assumptions on that.

Best regards,
Krzysztof
