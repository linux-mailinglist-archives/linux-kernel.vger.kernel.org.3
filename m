Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464FE4E97B7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243011AbiC1NQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbiC1NPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:15:55 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB07F1EC62;
        Mon, 28 Mar 2022 06:14:12 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id p189so8369081wmp.3;
        Mon, 28 Mar 2022 06:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iPvyUArGq9N4QP8v+NLNxQC2uqfz6S9nmB3jutwmiOE=;
        b=SfbmC+uV8iVw1RxcAO35azPAgMqEZxgm2qGFSCEFEIFC1sMsFv+/8ETetYQmzt51OE
         RMK+51Xa9ioIO6OOwAgU7amCv+ViHbq3wIB88j3Ymx1LfizMar+NjLGMbhyx0ydAnPh/
         M9IEuCW0bVGCm6c5dbc5r1FVdEkxuReOF7CFu7BoCj0AKyTNB6o9j6VkOHcCJ2jHiM/F
         55v3GOF5TpZeuPnvP+Ny18Qlrk1gxjTQholvaA8CfNsjEJtXYYnglcTeHRaxTTlNeFQf
         e2Rop8pjt/fgKHi6KL2Ovf4TcU0OKNCV56UraYUFGZM76FTekIEf6x6n64aDiZQMPRjZ
         UY2A==
X-Gm-Message-State: AOAM5316gV1iNid7aUG6Yl8Ft0AvYdyrKhMUn5V21vNaWqYIXkJzV6AI
        JI1EKOeksa4COUt7mk6qA5ov1DmeqXdo9A==
X-Google-Smtp-Source: ABdhPJzYuKcvyV6lYJ7GQxgvhESm3wwdExl2S1Dbq3LT0bwMyaYvugeCbyBOVYBMhK3to2eQu60yTg==
X-Received: by 2002:a7b:c24d:0:b0:38c:68a4:eb4b with SMTP id b13-20020a7bc24d000000b0038c68a4eb4bmr35331251wmj.108.1648473251173;
        Mon, 28 Mar 2022 06:14:11 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id o10-20020a5d47ca000000b00203fb25165esm14344396wrc.6.2022.03.28.06.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 06:14:10 -0700 (PDT)
Message-ID: <37da40fe-6e85-af40-756b-d022fe2559aa@kernel.org>
Date:   Mon, 28 Mar 2022 15:14:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/5] arm64: dts: imx8mp: Enable HS400-ES
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Adam Ford <aford173@gmail.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
References: <20220327123835.28329-1-aford173@gmail.com>
 <20220327123835.28329-3-aford173@gmail.com>
 <c964bf2c-f7bf-451c-1691-02903f20c634@pengutronix.de>
 <CAHCN7xL05pBK0uK7zuE7Uq4P9Rzo6bHbJdbOt5XnQRB7Sh3msw@mail.gmail.com>
 <74e74ea8-1554-bf08-b0ea-36e77259cb18@pengutronix.de>
 <5c24c12b-3a12-1e18-9f03-2c54cad30bf9@kernel.org>
 <CAHCN7xJ28t3igV8uHWfLxJx6wWkwzojg-d0QTTZM9jdfGCbTzw@mail.gmail.com>
 <5282b39b-85d5-81d6-10d5-a45c66d4d4e9@kernel.org>
 <010b3600-81dd-f5e3-2d57-8cab8efd58f0@pengutronix.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <010b3600-81dd-f5e3-2d57-8cab8efd58f0@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2022 15:07, Ahmad Fatoum wrote:
> Hello Krzysztof,
> 
> On 28.03.22 14:56, Krzysztof Kozlowski wrote:
>> On 28/03/2022 14:45, Adam Ford wrote:
>>> On Mon, Mar 28, 2022 at 6:49 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>
>>>> On 28/03/2022 13:09, Ahmad Fatoum wrote:
>>>>> Hello Adam,
>>>>>
>>>>> On 28.03.22 12:47, Adam Ford wrote:
>>>>>> On Mon, Mar 28, 2022 at 2:20 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>>>>>
>>>>>>> Hello Adam,
>>>>>>>
>>>>>>> On 27.03.22 14:38, Adam Ford wrote:
>>>>>>>> The SDHC controller in the imx8mp has the same controller
>>>>>>>> as the imx8mm which supports HS400-ES. Change the compatible
>>>>>>>> fallback to imx8mm to enable it.
>>>>>>>
>>>>>>> I believe that's a shortcoming of the Linux driver, which should explicitly list
>>>>>>> fsl,imx8mp-usdhc in its compatibles and enable HS400-ES for it.
>>>>>>>
>>>>>>> I find dropping compatibles problematic, because like Linux matching
>>>>>>> fsl,imx8mm-usdhc, but not fsl,imx8mp-usdhc, other software may match
>>>>>>> fsl,imx7d-usdhc, but not fsl,imx8[mp]-usdhc.
>>>>>>>
>>>>>>> I'd prefer that either the kernel driver gains extra compatibles or that
>>>>>>> the DTS lists extra compatibles and we refrain from dropping existing
>>>>>>> (correct) ones.
>>>>>>>
>>>>>>
>>>>>> I would argue that imx7d is not correct since the IP blocks between
>>>>>> imx7d and imx8mm have different flags/quirks.  One of which includes
>>>>>> HS400-ES, but there are other differences as well.
>>>>>
>>>>> The DTS currently says that an fsl,imx7d-usdhc is a subset of an
>>>>> fsl,imx8mm-usdhc. So a driver could treat both HW the exact same
>>>>> by focusing on the i.MX7D parts. Linux apparently did exactly
>>>>> that so far. Is this not accurate?
>>>>>
>>>>>
>>>>>>> What do you think?
>>>>>>
>>>>>> From my understanding of the fallback compatibility strings is to
>>>>>> avoid having to add more and more compatible strings to the drivers
>>>>>> when they do not serve a functional purpose. Based On a conversation
>>>>>> with Krzysztof [1], he suggested we update the YAML file based on the
>>>>>> fallback, but he wanted NXP to give their feedback as to what the
>>>>>> right fallback strings should be.  Haibo from NXP sent me a hierarchy
>>>>>> [1] which is what I used to update the YAML file.  Based on the YAML
>>>>>> file, the fallback in each DTSI file was updated to ensure the use of
>>>>>> the proper IP block.
>>>>>
>>>>> Myself I am in favor of moving to three compatibles instead of dropping one.
>>>>> For some theoretical fsl,imx8mf-usdhc that's supposed to be exactly the same
>>>>> as a fsl,imx8mm-usdhc, I don't mind omitting the fsl,imx7d-usdhc compatible,
>>>>> but for existing device trees, this may introduce needless potential breakage
>>>>> for other software that also uses Linux device trees.
>>>>>
>>>>
>>>> Affecting existing users is indeed a concern with this approach, because
>>>> in-kernel DTS might be used in other projects as well.
>>>>
>>>> I still cannot find here the answer whether fsl,imx8mm-usdhc is actually
>>>> compatible with fsl,imx7d-usdhc. It's not about driver, but about
>>>> hardware and programming model. imx8mm can support additional features
>>>> and still be compatible with imx7d. However if any flags of imx7d are
>>>> actually not valid for imx8mm, then it's different case.
>>>
>>> The imx7d flags are:
>>>  ESDHC_FLAG_USDHC
>>> ESDHC_FLAG_STD_TUNING
>>>  ESDHC_FLAG_HAVE_CAP1
>>> ESDHC_FLAG_HS200
>>>  ESDHC_FLAG_HS400
>>>  ESDHC_FLAG_STATE_LOST_IN_LPMODE
>>>  ESDHC_FLAG_BROKEN_AUTO_CMD23,
>>>
>>> The imx8mm flags are:
>>>  ESDHC_FLAG_USDHC
>>>  ESDHC_FLAG_STD_TUNING
>>>  ESDHC_FLAG_HAVE_CAP1
>>> ESDHC_FLAG_HS200
>>>  ESDHC_FLAG_HS400
>>>  ESDHC_FLAG_HS400_ES
>>>  ESDHC_FLAG_STATE_LOST_IN_LPMODE
>>>
>>> It does not have the ESDHC_FLAG_BROKEN_AUTO_CMD23 that is present in the imx7d.
>>
>> AFAIU, it looks imx8mm is compatible with imx7d, because the broken
>> acmd23 only limits the features. If imx8mm binds according to imx7d, it
>> will not support acmd23 and HS400-ES.
>>
>> Having three compatibles is therefore also OK.
> 
> My thoughts, exactly.
> 
>> You could also add two cases:
>> 1. three compatibles, deprecated: True,
>> 2. two compatibles, without imx7d.
>>
>> Existing DTS stays with three compatibles for two years and later gets
>> converted to two compatibles. New DTS should use two compatibles.
>>
>> It's quite a lot of churn, but would make in the long term bindings
>> correct and also not break other users/projects.
> 
> I don't see why we need to deprecate the old binding. New SoCs
> can be imx8mm-usdhc compatible from the beginning and need not
> care about the old binding. Existing SoCs can just remain imx7d-usdhc
> compatible as they are now.
> 
> I don't see what the deprecation accomplishes.

It avoids to have too many entries of imx8mm (imx8mm alone,
imx8mm+imx7d, imx8xx+imx8mm+imx7d).

Best regards,
Krzysztof
