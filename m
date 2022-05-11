Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E69F523BB2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345657AbiEKRg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiEKRg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:36:56 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2289468300
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:36:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g23so3349769edy.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jwXHsUB6qUpzl3VRnWjzmQKSgk8cDfdgFA5s7nwGaLI=;
        b=bT22W7fDGAySEG7vBs4hb15DD4bL48uTSAqlVdi3MASn69ux2G7d6N/VKWbxFQeXzu
         IgyiHQ6LaCd+Jy6MC9n/t37uslzcQJdkPoDj5+cJEJKwpg5f0JFW2jRrHzzzLJkf9iT4
         QtQSQUI6LtFE/fIizHPmL1xz0u3XWz12sCguANLoXC7jJDbOFe74dMAP5p6lDhtoGNwH
         DFbFezBtzeZP0nBg/lmOWq7iZL6At0YQIyWc6fyuUn3CK6qOaU17FXZxe0d/AgEW+9TG
         J7Jt47UJoYkfeT8yAPruPYcESKHLZfst00coEXtq0vevDQTAQYtBInbCq7t9qf1jIkXW
         U8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jwXHsUB6qUpzl3VRnWjzmQKSgk8cDfdgFA5s7nwGaLI=;
        b=kKfACVe6vDeYU3RUM9Dmgahks7ZyvTIqXf6R7rCK5h3TXmDarhcufn/zc666odA7FN
         sGpB0GVgWteXV9OeSKClVFGlCGEzebndKZKOAEW23164kdvDkL62OQ4WIMXsC0/9cLGO
         S2rACr21z6ypWRjKo0J6lZkJoN8MZTtcc3nqTD4GL6l3GxjFHZC0POiITkK1gD/GusWC
         Z/PQeiR2w7CkuU7t2HZBPnh3bCi2il6TMmBnzNgdJnCbM9dW472xqgay4DMgyftee6wZ
         bQ7viQfTUnpKmFhhCl4D1JKXX/IOyS2tg/EUiOpRCNnt1bjdUdiVnvWNUFA/rTLdIJ91
         BymQ==
X-Gm-Message-State: AOAM531VOe8Drjwnt95SR7T43XRnJgqsgg8gpCIf8vCb6KrwhbezAEGT
        fUwGiLWDo5HYIRwZe3tuTrrjJg==
X-Google-Smtp-Source: ABdhPJyHrA/Ee4SIk42qzBFrUON01ZYdvbhXAObX8J9n0ciqCBlqDatunWcWgBVW2FLF9m2wVcZ9SQ==
X-Received: by 2002:a05:6402:2078:b0:428:1071:d9b2 with SMTP id bd24-20020a056402207800b004281071d9b2mr31020035edb.302.1652290613620;
        Wed, 11 May 2022 10:36:53 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y8-20020a170906524800b006f3ef214d9esm1231008ejm.4.2022.05.11.10.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:36:53 -0700 (PDT)
Message-ID: <b619b455-c944-0cc6-ca83-e65490612ed7@linaro.org>
Date:   Wed, 11 May 2022 19:36:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        =?UTF-8?Q?Krzysztof_Koz=c5=82owski?= <k.kozlowski.k@gmail.com>,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
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
 <606cc762-a0c2-49a4-3e5d-d2dbd4595bc7@linaro.org>
 <CAD=FV=W_SA-3PfDFi-Gkjk9pew5bchFNjQhXX8MkZyuy5UohEQ@mail.gmail.com>
 <CAJKOXPdt5WTg4VU-TEW3dmPHR76dKg63XVxRQfa7ZSKc_jz6Ag@mail.gmail.com>
 <CAD=FV=XQqQSQDNh-zXqEQkwsrax5Qb3OtfKZoQLkncJj_4mcQw@mail.gmail.com>
 <daf66d41-42ac-50dc-3f8d-c261da8e452d@linaro.org>
 <CAD=FV=WhA=n_=Ys6NfedPtNPddL81HnG6Qws_R+vq9w8Nrsn5A@mail.gmail.com>
 <ce2ea308-b63d-ad27-4cea-7353268f8ebb@linaro.org>
 <CAODwPW857CkH0+ZnBaUeowW4te-hSy6nrdeeX6-OLPOs5TptsQ@mail.gmail.com>
 <55dcf917-7ac0-efe9-8531-b77be682125a@linaro.org>
 <CAD=FV=UPKo4CxRVmdHr05rRPaNHFYfaQTqmBJAU5ZF61ccKgEA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=UPKo4CxRVmdHr05rRPaNHFYfaQTqmBJAU5ZF61ccKgEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 18:09, Doug Anderson wrote:
>>
>> So you choose they are not identical, fine. Why insisting on adding
>> fallback compatible while not keeping bindings updated? Just don't add
>> the compatible and work on rev3 or rev4. Doug even once wrote "_we don't
>> know_ if -rev7 and -rev8 are compatible", so don't make them compatible.
>> Don't add fallbacks or some generic unspecified front-compatibles and
>> just work on revision.
> 
> Somehow, it seems like we keep talking past each other here and it
> feels like folks are getting upset and we're not moving forward. Maybe
> the right way to make progress is to find some face-to-face time at a
> future conference and sit in front of a white board and hash it out.
> That being said:
> 
> * Without changing our bootloader or having a big explosion in the
> number of dts files, we really can't change our scheme. The best we
> can do is document it.

That's reasonable.

> 
> * If we want to change our scheme, we'd need to sit down and come to
> an agreement that satisfies everyone, if such a thing is possible.

There is open CFP for ELCE 2022 (in Ireland). Maybe we could organize
some session there? But we for sure would need Rob, so the arrangements
should rather focus on him, not on my availability.

> That would only be able to affect future boards.

I would like to say that if you had bindings, then obviously we would
not break them, but since there are no bindings... :)

> We don't want to
> change the bootloader dts loading scheme on old boards.

Understood.

>>>> Right now it's not possible to validate QCOM DTSes against DT bindings
>>>> because they throw big fat warnings about undocumented top compatibles.
>>>> This is a downside for us.
>>>
>>> But that's a solvable problem, right? As I understand, what Doug was
>>> initially just asking was whether it made _sense_ to document all of
>>> these... not that we couldn't do it. Then this whole thread went down
>>> a rabbit hole of whether our compatible assignments are allowed in the
>>> first place. If we can compromise on this discussion by just doing
>>> whatever needs to be done to make the tool happy, I think(?) we can
>>> provide that.
>>
>> None of recent patches from Chromium were doing it, even after
>> complaining from my side, so why do you suddenly believe that it is
>> "doable"? If yes, please start doing it and fix the DTSes which you
>> already submitted without bindings.
>>
>> To remind - entire discussion started with Doug saying it is pure
>> overhead for him.
> 
> I mean, to be fair I said it _seems_ pure overhead and then said that
> we could do it if it makes some tools happy. ...but before doing that,
> I wanted to make sure it was actually valuable. I still have doubts
> about the assertion that the most specific compatible is guaranteed to
> uniquely identify hardware. So if the whole reason for doing this is
> to make the validation tools happy and there's no other value, then at
> least it's plausible to argue that the tools could simply be fixed to
> allow this and not shout about it. 

Instead of adding bindings, you can indeed change/fix the tools. Go
ahead. :)

> Now, certainly I'm not arguing that
> yaml validation in general is useless. I'm in agreement that we want
> dts files to be able to be formally validated because it catches
> typos, missing properties, and bugs. I am _only_ saying that I still
> haven't seen a good argument for why we need to validate the top-level
> compatible string.

I don't feel expert enough on this topic to give you good answer. Which
does not prove that there isn't or there is such good answer.

> Since there no properties associated with the
> top-level compatible string, it's mostly just checking did some one
> copy-paste the compatible string from one file (the dts file) to the
> other file (the yaml file) correctly. To me, that does not feel like a
> useful check.

Still it can detect messing of SoC compatibles or not defining any
board-level compatible thus pretending that someone's board is just
SC7180. Imagine now user-space or bootloader trying to parse it...

BTW, the bindings validation of top-level compatible might actually help
you - to be sure that DTSes have proper compatibles matching what
bootloader expects.

> The other thing I wanted to make sure was that we weren't just going
> to get NAKed later if/when we had to adjust compatible strings on
> existing dts files.

Stable ABI is more of SoC maintainer decision and I see Bjorn responded
here.

> In any case, I guess I'll make an attempt to document the compatibles
> for existing Chromebooks and we'll see what happens. I'm still not
> convinced of the value, but as long as we're not going to get NAKed
> for documenting reality it's fine.


Best regards,
Krzysztof
