Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D45757395E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbiGMO5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiGMO5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:57:36 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8193DF2E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:57:34 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a9so19477655lfk.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jsje3ehsR9ECEkj9DfwB4VaXb0L+a8MycN172EG5eN0=;
        b=yvLyC+97xwgjQCTxuOGpEGThaXKimbQEVNC3zZgRfJD7waj7OsQW4SD9tUL+KukEp4
         H9Be1+kNouZZEaM1WPmgQlSQlH78KfEDAjelvzKr3bLJ+cOBBccHVJibqu6yPw6irowR
         /OlBiFNiU0Tg1q3mlL39JvDD8ESfRM2QRB4gfzVCaUS2e3V5MYVFbpfTei7YnvqVTha0
         ux3Gzwj673tn7l7ci1bOi9LIR7zl0vmzXO77Py364nzIGMRV4nqfYgRgOEo3ADxLi56Z
         YUTZ4DAKqMHyCSMflv1sF8hZ2SW9AzbTohAAUj5PcrpMUofnoRuFffBhmw8JMM/iQoed
         a6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jsje3ehsR9ECEkj9DfwB4VaXb0L+a8MycN172EG5eN0=;
        b=tiq3DxHEVlMs1G0Koxr5MNHfV4L7G/yvB5sKNQp4+2ZaviF27usqCKrWNPom9Yn88n
         /AvSmogCwW/X8spB3Pmi6DdYkjm14rphfSPnvxv9zllC5GGS6bRcRIzb/YXUqWqn7yNN
         MwEpY/k1FzIw4huEH4WrbP5ydxp8mmZ+P4Z1W+yj2zLJPzAEMFAioiLM+luoTnVBktnm
         n1J8T3ljYOOd/8sM5tX1DdV3WbSeSMfsBOHORKHJ/vfkhgOvWlhoE8CjJAQISZSWTjD9
         NLyTBZVkPeFWq4WSY1BD46UOxqG5Ds5OjeKpnCdDMgZwpeROGHpvr8x7bk6i7REhCZPE
         /pUw==
X-Gm-Message-State: AJIora+uTVy40G2S57mhqSvHWXj8ZTqZPIXuzG9aYKZHnO+aDMrwK9Dn
        NNnxKbkrvirLKlNFWWQ155e6IA==
X-Google-Smtp-Source: AGRyM1vgRrhj/XY2koHbYAelGs303XVEdbTp0skZTLYnMp+cYfZfwoA4a64JTuw4BRIVm4/zK2SH5Q==
X-Received: by 2002:a05:6512:1091:b0:489:7a4b:c46e with SMTP id j17-20020a056512109100b004897a4bc46emr2241003lfg.151.1657724252969;
        Wed, 13 Jul 2022 07:57:32 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id x26-20020a19f61a000000b0047f963bf815sm2842009lfe.93.2022.07.13.07.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 07:57:32 -0700 (PDT)
Message-ID: <2a43d0a3-cb6e-460c-d17f-abb81de40422@linaro.org>
Date:   Wed, 13 Jul 2022 16:57:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/2] pinctrl: nuvoton: add NPCM8XX pinctrl and GPIO
 driver
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        zhengbin13@huawei.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20220710102110.39748-1-tmaimon77@gmail.com>
 <20220710102110.39748-3-tmaimon77@gmail.com>
 <95d12b72-be9d-5503-c4ea-801303bb7776@linaro.org>
 <CAP6Zq1geFJsKrdQEN5Vqjw6e8bsiArDe1tzJ-jkQm-2XT-0KyQ@mail.gmail.com>
 <d8bc7a14-a9c5-4d34-997a-48a8d27c5edd@linaro.org>
 <CAP6Zq1iAPmV9KVrBVqmRix8sTq0zLsw3T1vPo-t1Q+2RgO4qsA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1iAPmV9KVrBVqmRix8sTq0zLsw3T1vPo-t1Q+2RgO4qsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 16:51, Tomer Maimon wrote:
> On Wed, 13 Jul 2022 at 17:29, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 13/07/2022 15:35, Tomer Maimon wrote:
>>
>>>>> +static int npcm8xx_pinctrl_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +     struct npcm8xx_pinctrl *pctrl;
>>>>> +     int ret;
>>>>> +
>>>>> +     pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
>>>>> +     if (!pctrl)
>>>>> +             return -ENOMEM;
>>>>> +
>>>>> +     pctrl->dev = &pdev->dev;
>>>>> +     dev_set_drvdata(&pdev->dev, pctrl);
>>>>> +
>>>>> +     pctrl->gcr_regmap =
>>>>> +             syscon_regmap_lookup_by_compatible("nuvoton,npcm845-gcr");
>>>>
>>>> No. Use property. By this patchset, I would expect that you learnt from
>>>> previous mistakes around this. Why repeating the same trouble second time?
>>> You suggest to use phandle property like nuvoton,sysgcr even that the
>>> NPCM8XX pin controller driver is used only NPCM8XX SoC, so the only
>>> GCR node in the NPCM8XX SoC is nuvoton,npcm845-gcr?
>>
>> Yes. The previous case (reset driver, AFAIR) was also about driver used
>> only in one SoC, wasn't it?
> Actually not, the NPCM reset driver serves NPCM7XX and NPCM8XX and
> probably other future BMC SoC's

No, when someone developed reset driver, it served only NPCM7XX. So
using this argument - only one SoC is supported - that person use
exactly the same API as here.

And it was wrong...

Now you use the same argument - only one SoC is supported.

I clearly see a pattern here...

> Still, you suggest using the phandle property in the driver even if
> the driver serves one SoC?
>>
>> Best regards,
>> Krzysztof
> 
> Best regards,
> 
> Tomer


Best regards,
Krzysztof
