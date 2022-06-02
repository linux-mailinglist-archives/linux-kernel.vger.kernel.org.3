Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4325253B77A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiFBKqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiFBKp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:45:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B546335
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 03:45:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id fd25so5726905edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 03:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nw6pxzn4DckQbSIrMyIKvslcoovKd9JNNcEV3M74aJU=;
        b=FVtc2GMHaMVFwBTB9n2bmkPgrxq0S/3I/jF+Z5+VjhYWNvNhdvd9FduqFd8H21CXnp
         5CoJBlRBbspU+PTFXH1VuLP74dEZNgdRy0pabuto/4CifAKSH60UJrIP/u0wDj1LjPpZ
         pwN9n0KWujb8LNQ1GokLI6aRvWoP/kuIV4CibHVrjYuCB1sg9UWKqq9nlBBb3+IcyRxM
         oG+8X0jviUubYCuFv0wHF4I2MgJIe0fOxMsZb88UZBXiUgyGXO2IBR03XgFDZDgYBVZj
         nmSUJqmu0Thut+grCufPZRhNpL1Wm/mKbJQEtEjOiUCn2fVSqMR7B0gk0OB/P3jwjSYP
         Vw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nw6pxzn4DckQbSIrMyIKvslcoovKd9JNNcEV3M74aJU=;
        b=xsKx4KLcBAJQR6djFX29nAVEDx6absy0mIeJMMLesDEmkXCXiOSAPaIe6ieySaIr8Z
         KuxqVDaFgaXhxqMvW/shKutpSz7vqAHkwQoMGcHDXnt7IM8NqFInOrj9yiU01du6UwOW
         zfBnAqGcWZPyZbJVt06kNbvM/zZQjnnzOjoU7RpU1J9ch6X+pODbP9d03dEQxMHvYyR6
         /Xd9UNI4sHN2FZwRDukAug2fhhhEz21SHf2Lwstz0gq58vV1T672ke6JwTL/y3kWSDAM
         P/Ry0juLnNvP2Q1RE6EpYfy4C5KudPi/z1iCn4qfefp6vsaOQTa12UFm2qVqZ37y2/rc
         ffbg==
X-Gm-Message-State: AOAM533xe8rtyVeuPuf+X2YodpCuS66UIBqcoIhcQtpKyH+GehRMfy1m
        14wI2wbfx8feoc8Wdq2E0FAiOg==
X-Google-Smtp-Source: ABdhPJyHBWmqVU4LKyl/2v3+gW1nAjEOcRCOkljscEs8ZrboVaNdsEU+GlslnGTpUxxoIj+RBNBgJw==
X-Received: by 2002:a05:6402:3901:b0:42d:f38f:a5c6 with SMTP id fe1-20020a056402390100b0042df38fa5c6mr4551192edb.321.1654166756552;
        Thu, 02 Jun 2022 03:45:56 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090609a200b006f3ef214e63sm1600576eje.201.2022.06.02.03.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 03:45:55 -0700 (PDT)
Message-ID: <9e3f5586-59fa-42cc-770c-b8694b4f2bf3@linaro.org>
Date:   Thu, 2 Jun 2022 12:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1] dt-bindings: dsp: mediatek: add mt8186 dsp document
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220422071534.15653-1-tinghan.shen@mediatek.com>
 <c0a188e5-8a8c-d4a3-5a3d-9b9dd85d8f44@linaro.org>
 <eb4deff1a01c09783518bbaff8fe4e4c4ca6fa5b.camel@mediatek.com>
 <591767ee-e349-7a17-a9e9-b95d0500c7c1@linaro.org>
 <774c075ca4ad815c88be755cfb51889a171e835d.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <774c075ca4ad815c88be755cfb51889a171e835d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022 12:19, Tinghan Shen wrote:
> Hi Krzysztof,
> 
> On Thu, 2022-06-02 at 09:40 +0200, Krzysztof Kozlowski wrote:
>> On 02/06/2022 08:44, Tinghan Shen wrote:
>>>>> +  mbox-names:
>>>>> +    items:
>>>>> +      - const: mbox0
>>>>> +      - const: mbox1
>>>>
>>>> These should be rather some meaningful names, e.g. "rx" and "tx".
>>>
>>> The mbox name has to align with the adsp ipc driver.
>>> The adsp ipc driver is using 'mbox%d' for mailbox channels.
>>>
>>>
>>>
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=9db69df4bdd37eb1f65b6931ee067fb15b9a4d5c__;!!CTRNKA9wMg0ARbw!1TmempNkQhC5QuLBhyfWo_AC97MoLuWipsGV-LPaW9RKNPheU7Bgc-eboNi1JA1nC5I$
>>>  
>>>
>>> 	chan_name = kasprintf(GFP_KERNEL, "mbox%d", i);
>>>
>>> 	/* ...snip... */
>>>
>>> 	adsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
>>>
>>> Is it ok to continue using these names?
>>
>> It is a bit confusing... how did that driver got merged recently without
>> bindings? Why bindings are separate?
>>
>> The bindings always come together in one patchset with the driver
>> implementing them. Bindings are though a separate patch, yet still
>> followed by the driver which uses them.
>>
>> I do not see any compatibles in that driver, which suggests there is no
>> other binding using it. If that's correct, then you need to change the
>> driver.
>>
> 
> The mtk-adsp-ipc driver's sole function is to encapsulate the operations 
> of mailbox framework from adsp ipc users. The mtk-adsp-ipc is not defined 
> in the dts file and we don't need it to be defined. The creation of mtk-adsp-ipc 
> device is requested by adsp ipc users via the use of 'platform_device_register_data'[1].
> 
> the driver implemented the mailbox framework is 'mtk-adsp-mailbox'[2]. it has 
> corresponding hardwares and a yaml file[3] to describe it.

I don't understand how is this related. We talk here about the
mbox-names for this bindings file. You replied, that these bindings are
already used by something, but now you say that they are not? So why do
you need to change anything in any driver?

Simple question - do the bindings here "add mt8186 dsp document" are
used by any specific Linux driver already?



Best regards,
Krzysztof
