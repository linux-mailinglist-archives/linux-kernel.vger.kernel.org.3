Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542A758C73E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242867AbiHHLHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242787AbiHHLG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:06:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F0B15FED
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:06:45 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so476821wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 04:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=c16ijpz5NNMDTs3mb30Og3o9Sww4mQ03ahV/QOHWVds=;
        b=DrgQ+srR6mq7WUlxI3sRzp45XRaLwh8AdoFWX64QOec03vBhctBLrHtEQ6oAttrxbj
         pufR5eQ5R38WVPEARYyDCUufiGi2xS1gHnOuJCRddGgQoUY6rnJ4yEmDO92o29ao9CUn
         tc4Tkg9bAmzQ1a/EWuV9UC7+ksEx2NuUtct+bC5z9/b9gD563sxFOd7JzYm35xcsfZry
         Ve2uIlcNuUtkUx3w/bPiDjZGAu+xz0FlOxbun2frOESGiInfQED2y0E699NSIxMdiHbD
         vcAgCcJMd0i9kNJPyDNUAytAi+rss7kKL3/ldjhSiBinfkdAJ3sYPw3Z3bdarmIlIdCx
         0MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=c16ijpz5NNMDTs3mb30Og3o9Sww4mQ03ahV/QOHWVds=;
        b=Lf99O/PXjYG1JMgqjU9jxZrEbKwdRt5/RGlDM4rBPRA49PuGl8WmJK1jFls0YBFnIe
         HMHmtP6/1XFPv3P/hGiFkZXOSSkqj669kAnK2R2DoQwlnXg2YuXVR0exnTO0UJrS7RV4
         zTuFZQXIPZvjro9yy6wpe/zNGSOhm3YVOriqxrzID6aUC2JJFnH96QbHML1Fc+eF1Cq2
         QzO+u/tBytcWx3HdC7ZrnugGdmeOAeO1V1tuqYOzVqHdTXNqIFe9e8rgSAZxi0SawcIq
         O8hjf4hR/0lqlG9AxH/q/s3xWvOAhwCfU9USH+QTYJvYAkzbMiE8Hn4xEoLSZ8EgoB4S
         EoPQ==
X-Gm-Message-State: ACgBeo1qMGoS+NaaXa9NbtUUXCrIQ/z9bBrLAdImPOD0T44gTcLx/BFh
        so/TEvpSrNx3aDsqB5sbk3owvg==
X-Google-Smtp-Source: AA6agR7cPa81AJUe5QUESVeNU8FMUZLrA4hGZ5NWQnUDWBHokliPfdeVTyWcpdZkSj1IZp53DvaIJw==
X-Received: by 2002:a7b:cbd7:0:b0:3a5:500e:13bc with SMTP id n23-20020a7bcbd7000000b003a5500e13bcmr300646wmi.83.1659956804248;
        Mon, 08 Aug 2022 04:06:44 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:54d7:57c:c89f:760b? ([2a05:6e02:1041:c10:54d7:57c:c89f:760b])
        by smtp.googlemail.com with ESMTPSA id l8-20020a05600c4f0800b003a17ab4e7c8sm20019016wmq.39.2022.08.08.04.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 04:06:43 -0700 (PDT)
Message-ID: <7c32806f-7ca1-a7f7-4565-84f59f2421be@linaro.org>
Date:   Mon, 8 Aug 2022 13:06:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 00/33] New thermal OF code
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     abailon@baylibre.com, anarsoul@gmail.com, baolin.wang7@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, digetx@gmail.com,
        f.fainelli@gmail.com, glaroque@baylibre.com,
        hayashi.kunihiko@socionext.com, heiko@sntech.de, j-keerthy@ti.com,
        jonathanh@nvidia.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, matthias.bgg@gmail.com,
        mcoquelin.stm32@gmail.com, mhiramat@kernel.org,
        miquel.raynal@bootlin.com, niklas.soderlund@ragnatech.se,
        rafael@kernel.org, rui.zhang@intel.com, shawnguo@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, tiny.windzz@gmail.com,
        Guenter Roeck <linux@roeck-us.net>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220808094216.928018-1-michael@walle.cc>
 <9b6aea8b-23fb-a882-4c47-5cd70cf266bf@linaro.org>
 <5daf2b7ebba3a3227ac37643a919add2@walle.cc>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5daf2b7ebba3a3227ac37643a919add2@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 08/08/2022 12:55, Michael Walle wrote:
> Hi Daniel,

[ ... ]

>>> There seems to be one mistake within the new thermal code:

[ ... ]

>>> This was seen a sl28 board
>>> (arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts).
>>> The same board in the KernelCI also have some more information:
>>> https://lavalab.kontron.com/scheduler/job/151900#L1162
>>>
>>> But I guess even if that is fixed, the driver will not probe due to the
>>> missing trip points? Are they now mandatory? Does it mean we'd need to
>>> update our device trees? But that will then mean older devices trees
>>> don't work anymore.
>>
>> Thanks for reporting, I'll investigate the issues you are reporting.
>>
>> There is no need to update any device tree file. The code does not
>> change the bindings, it is a rewrite of the implementation supposed to
>> be without impact on the existing bindings, thus the existing device
>> tree descriptions.
>>
>> Why are you saying there are missing trip points ? The dts shows trip
>> points for 'core-cluster' and 'ddr-controller' ?
> 
> You are right. I've just looked at the error message:
> 
> [    2.030452] thermal_sys: Failed to find 'trips' node
> [    2.033664] usb 1-1: new high-speed USB device number 2 using xhci-hcd
> [    2.035434] thermal_sys: Failed to find trip points for tmu id=2
> 
> So maybe the code just don't find em.

For the board it seems there is no definition for tmu with id 2


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
