Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECE15B19DB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiIHKXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiIHKXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:23:12 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9319AD2741
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 03:23:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bq23so26952386lfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=71ULh6vj0eJOKdAumyIOV8TqB+wxiHSVYFR9puUSOIA=;
        b=P//ALHVYYciXScMLp7+9vpKQ4XAN0wEETZyPFlT6E3f96d68C+LdDDb9Lk5d0pvkKZ
         LJCbdaMyYDBXzyJK3qmY4lHSTj2cObcRrk8VyU+citDgi4Ni1uTUk+6t/GQSqAxK+3ij
         bRP6dlUkdoYF+bQCwKSpZBlDm8TQDKvj4KBZLJtZiEt4r3IMtVDJQR83Bh/m/sjMP+w/
         otK2YYqfBE1kKgSfHEFjTy6QpXJSUnzD5j512Y6msbAqHp8vLa43fXwh+gl4v+95vBiC
         4TXEqU9O0NdbH0n6qbystDGRKh8oxTo5IZBIAFIEZfFFEL0gmaZkCrRKKrmBuftbrAL9
         Bj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=71ULh6vj0eJOKdAumyIOV8TqB+wxiHSVYFR9puUSOIA=;
        b=xRpeN6TVPiFp0gFhiB80bQijsTkujkVO6qmlafg7NAt6DXb5EcUafSwz1ut7/bpeOy
         mV0/S7Ow1SCPAt6MmT3oSSYUafEWekbYHjA/zL01jJxNn/X6Z+iEGgCzQTGaY6o7TFuR
         7Gvg9E7EcIYK9h0k5IJhOaAE8OrSOPiaU7UAFwdYfsYzhcrPEgwdO1LEUM+Aam425qUe
         2hjDklSfkubQvTUe6nYgep+czGA4BwqwDuCa5tzHAm6d1PL0mBz0vHNBCjA1JiSouvjA
         5yzylaVHAPo0skzmsbAt0ultQ+TJBMFRN7IQ+iUriSvLAi4/CEsLBhY+lfUB09L25MiE
         3fFg==
X-Gm-Message-State: ACgBeo1kDZ38FUWqCU8Gx+XiwKye9gbcmUaxNuKYewTFxg/EVZsPHjqu
        CqJBAgMzBXjTMdpn0Psgt+flag==
X-Google-Smtp-Source: AA6agR6z9LUNGwm1LnmkKQ/7/EjbPVHZgUIgnuJ6rrG2/NIpecHpPVO66VZ5CUbOGXH7j5Q96ZxxkA==
X-Received: by 2002:a05:6512:159e:b0:498:f1eb:f7a with SMTP id bp30-20020a056512159e00b00498f1eb0f7amr358237lfb.425.1662632588959;
        Thu, 08 Sep 2022 03:23:08 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q3-20020a056512210300b004946aef1814sm2276848lfr.137.2022.09.08.03.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 03:23:08 -0700 (PDT)
Message-ID: <51d77893-502d-9581-5d50-e99ff0a730e6@linaro.org>
Date:   Thu, 8 Sep 2022 12:23:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 3/3] regulator: dt-bindings: qcom,rpmh: Indicate
 regulator-allow-set-load dependencies
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dianders@chromium.org, johan@kernel.org
References: <20220902185148.635292-1-ahalaney@redhat.com>
 <20220902185148.635292-4-ahalaney@redhat.com>
 <de24bc67-f608-d9a0-31e7-ba291c469573@linaro.org>
 <20220906144117.wyqulotg52aqru7u@halaneylaptop>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906144117.wyqulotg52aqru7u@halaneylaptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 16:41, Andrew Halaney wrote:
> On Mon, Sep 05, 2022 at 06:50:02PM +0200, Krzysztof Kozlowski wrote:
>> On 02/09/2022 20:51, Andrew Halaney wrote:
>>> For RPMH regulators it doesn't make sense to indicate
>>> regulator-allow-set-load without saying what modes you can switch to,
>>> so be sure to indicate a dependency on regulator-allowed-modes.
>>
>> Hmmmm.... What about other regulators?
>>
> 
> My understanding (which very well might be wrong) is that if your
> regulator is allowed to change modes, and sets regulator-allow-set-load,
> then you have to describe what modes you can switch to.
>> But if you don't allow setting modes (for example qcom_rpm-regulator.c)
> and just allow yourself to set_load() directly, then you don't need it.
> 
> So there is a more general requirement that applies regulator wide, but
> I'm not sure how you would apply that at a higher level. I don't see a
> good way to figure out in dt-binding land what regulator ops each
> binding supports.

The bindings don't express it, but the regulator core explicitly asks
for set_mode with set_load callbacks in drms_uA_update(), which depends
on REGULATOR_CHANGE_DRMS (toggled with regulator-allow-set-load).

drms_uA_update() later calls regulator_mode_constrain() which checks if
mode changing is allowed (REGULATOR_CHANGE_MODE).

Therefore based on current implementation and meaning of
set-load/allowed-modes properties, I would say that this applies to all
regulators. I don't think that RPMh is special here.

Best regards,
Krzysztof
