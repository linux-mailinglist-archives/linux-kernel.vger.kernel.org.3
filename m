Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346DE522D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242807AbiEKHUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242772AbiEKHUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:20:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8814611163
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:20:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ks9so2221499ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1arvzVCGhx/u2B2mNNK8MUC7PUwBoteRJKwb7bxCHBk=;
        b=es/5QJb8i1Apn33h4DppkcttqYKh1l7mWyo9SZwDytH2IUHPf0OgM0LCEVhbLeMVeM
         VZo3MFJkVpTfZqkhS4F5WPCH58M+XOt9VQtYnpvwRXX5QIWhLwjOUQjFOCqiAcaqgkpp
         sAKFeIbMK45BUZ7PBoGWbWVkSO0gSejrfEVfBp98eJA8Ic4ExwjQy3Lqna5t97aJX4SE
         ACnygM+6n24f0T6cTEr/mqM9jJJtO6gmnqssQ9a6Rv11ASu/xGj2+524OTdtDFkg6ONl
         daGlb3NKiR9CQOIyuVCCleVkrAJeMIjd3UYFBu/Si+d2NwXLnXmjwEgeHOyuU397zjzd
         hoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1arvzVCGhx/u2B2mNNK8MUC7PUwBoteRJKwb7bxCHBk=;
        b=y/WyjarYwxW3O9JGUbFLs4a2joJXbvt4iHF1jLzCFOTrGSH0/OLvomtFnFCLVZkYFe
         OezI5uVpbu2T2paloC2oxg6nfc2YnFHqw3DSoM8Qzm0Tb7JUSM4+lvr/QJMv6pYogKoZ
         lT7REZXFx+a8KYaGEva54Ru6FIkP2Bfkttnhp9ameSQTm6zyiKp8alNPdBhvKS0cmJVc
         +36YM8CJOVOFjKZDxfPJlIQLi5mpeU3YD72dON6vmTb5UT+XlALPndT0Z7DllhVGBglw
         i7OSq+2pG0kywrfAFz7waHHgDfA0AGB5HOOQayj45Kfc8n9Jhpqgvb2c40fyVyeD9Mm2
         a0lg==
X-Gm-Message-State: AOAM532Istmb3cWSmB8JZ+3LLdD0OwkOc9DE5hW3qtd2ySjpvt9vs7oY
        jL3KUVYySUFz6iwmDWEZxQRkhg==
X-Google-Smtp-Source: ABdhPJzMGjuwnxoY9B7jruVulbsFMLwsfx518TPhcbHoAP0n/EVq1zmT5G6uKK75BZ6E8vUFuG8ZiQ==
X-Received: by 2002:a17:906:5006:b0:6ce:3762:c72e with SMTP id s6-20020a170906500600b006ce3762c72emr22907379ejj.30.1652253643118;
        Wed, 11 May 2022 00:20:43 -0700 (PDT)
Received: from [192.168.0.253] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q10-20020a1709064c8a00b006f3ef214de2sm616613eju.72.2022.05.11.00.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 00:20:42 -0700 (PDT)
Message-ID: <55dcf917-7ac0-efe9-8531-b77be682125a@linaro.org>
Date:   Wed, 11 May 2022 09:20:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAODwPW857CkH0+ZnBaUeowW4te-hSy6nrdeeX6-OLPOs5TptsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 04:39, Julius Werner wrote:
>> Wait, we agreed that you don't consider them identical, didn't we? If
>> they are identical, you do not need rev4 at all. So they are not
>> identical...
> 
> Well, they are identical until they're not. We intend them to be
> identical. But for practical purposes it does sometimes happen that
> two board revisions which were meant to be indistinguishable by
> software end up needing to be distinguished at a later point, when
> both the hardware and firmware can no longer be changed. We need to
> allow an escape hatch for that case. It does not happen often, so just
> treating them all as separate boards from the start is not a scalable
> solution. DTBs are not free when they all need to be packaged in the
> same kernel image.

You split more important part of my message, ignoring the point.

So you choose they are not identical, fine. Why insisting on adding
fallback compatible while not keeping bindings updated? Just don't add
the compatible and work on rev3 or rev4. Doug even once wrote "_we don't
know_ if -rev7 and -rev8 are compatible", so don't make them compatible.
Don't add fallbacks or some generic unspecified front-compatibles and
just work on revision.

> 
>> Right now it's not possible to validate QCOM DTSes against DT bindings
>> because they throw big fat warnings about undocumented top compatibles.
>> This is a downside for us.
> 
> But that's a solvable problem, right? As I understand, what Doug was
> initially just asking was whether it made _sense_ to document all of
> these... not that we couldn't do it. Then this whole thread went down
> a rabbit hole of whether our compatible assignments are allowed in the
> first place. If we can compromise on this discussion by just doing
> whatever needs to be done to make the tool happy, I think(?) we can
> provide that.

None of recent patches from Chromium were doing it, even after
complaining from my side, so why do you suddenly believe that it is
"doable"? If yes, please start doing it and fix the DTSes which you
already submitted without bindings.

To remind - entire discussion started with Doug saying it is pure
overhead for him.

> 
>> Remember, you do not have to use Devicetree or Linux at all if it causes
>> you some downsides... No one is forced. :) If you choose to use it,
>> sorry, it comes with some requirements like being following Devicetree
>> specification or the binding guidelines.
> 
> Woah... that is maybe a bit extreme, don't you think? 

Yes, it was sarcasting. :) But yeah, using Linux and DTS comes now with
DT schema. Please document the bindings in DT schema. That's the
drawback of using mainline...


Best regards,
Krzysztof
