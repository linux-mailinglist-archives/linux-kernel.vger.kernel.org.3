Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ED35852C7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbiG2PgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbiG2PgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:36:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C063B863D0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:36:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bn9so6451904wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=WOyX2y+yK0055b41MICdKQ4YUsD5Kv8I3S4JoEvD3+s=;
        b=xbfzkZERozdMBRcOgicJM58M+/THgvCx3GpKROZViHKS8LplxroCDEH9yBY5Yu3xtw
         nuYfDFK7ctPBCgZjlwG6j4ZFbiB0p+n55irjINmm0//6S6geKc13W6xs6Tx2fcjs+OBj
         CEiYed4SZPcOuTE2JIrZuGPfoFlTiUEd+DRYYt6iFgeK5HNWss0g6Z/m05F9i6QVwanR
         LZN11YEaG11iT31jLUtmWEzQ8O1eyggr/ZQfptO1NDBOPcrvui0u/KT6YxIQBqDQxlVa
         8BJRfhTIRiXpcf48f2/JwbLdWCBq7DEa7l7zsU4npa08t8GSuYEA9EC+lSGXTXRkmJ2A
         pj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WOyX2y+yK0055b41MICdKQ4YUsD5Kv8I3S4JoEvD3+s=;
        b=uCwTW8mSLOfo6naLdekhuYhcjKIqLbTAKiDNKgIAjtuGURu53pLpLTOcspvtvTiwRZ
         AgXWQpN1OElg3BtCV8BjbdZlgqDFaVelAFiNCKWiTYurc7V/udnnSFgwtLTF7xfAtWM8
         dVAo93ua7BLYBsNnRb/x/Vc1/wF/zZCNTDPSPVqx8lMUwpdA6p+R9MyzjUX+YNtIg9+e
         WWcpyK2NmlOTFIAM9DhpWjtCy6p8RKRxwQIhZ1rJWG9lEd3hIuSHX+DZCmwzDVslAfJR
         Fr4qiWA8Accte6ycxjSnSb2mn1zhbocFLBXwwp1a/eX2ZQvAX+ls2VunL6BscdMSSd+l
         zuUg==
X-Gm-Message-State: ACgBeo2zaCRSzmCubdeLLIn6gzpUv18spaGmb5pSl7rGYjmW/aZncyyM
        nEpTXwATloV41Z/ghMwrDLWihl7P8m7Pog==
X-Google-Smtp-Source: AA6agR5m46hlp4+2Ih0uGB6NvQXsjckIOKi97W3GjOn1UxRDc27vQ3IwYtKwGaoHAhPJC8aD3Z3JpQ==
X-Received: by 2002:a05:6000:1849:b0:21d:9ad7:f27f with SMTP id c9-20020a056000184900b0021d9ad7f27fmr2707113wri.445.1659108959123;
        Fri, 29 Jul 2022 08:35:59 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a2b5:2611:bcc1:9aac? ([2a05:6e02:1041:c10:a2b5:2611:bcc1:9aac])
        by smtp.googlemail.com with ESMTPSA id v11-20020a5d43cb000000b0021ec76a0c36sm3806397wrr.106.2022.07.29.08.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 08:35:58 -0700 (PDT)
Message-ID: <9b224465-e9e5-43d3-50eb-3614decbd8b2@linaro.org>
Date:   Fri, 29 Jul 2022 17:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 1/6] thermal: mediatek: Relocate driver to mediatek
 folder
Content-Language: en-US
To:     Balsam CHIHI <bchihi@baylibre.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220726135506.485108-1-bchihi@baylibre.com>
 <20220726135506.485108-2-bchihi@baylibre.com>
 <24250d03-b25f-e521-5abd-f36109885c36@linaro.org>
 <CAGuA+opxZ7DDrWHcnTRhMcm7YveCAypdy9MDSytt58asgekayw@mail.gmail.com>
 <CAGuA+ooOUXaBM+uPvEEohFLtO8sRd4T=DMcc6Fvo9P92gsq4yg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAGuA+ooOUXaBM+uPvEEohFLtO8sRd4T=DMcc6Fvo9P92gsq4yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balsam,

On 29/07/2022 17:21, Balsam CHIHI wrote:
> On Fri, Jul 29, 2022 at 5:19 PM Balsam CHIHI <bchihi@baylibre.com> wrote:

[ ... ]

>>> config MTK_SOC_THERMAL
>>>          tristate "Temperature sensor driver for MediaTek SoCs"
>>>          depends on HAS_IOMEM
>>>          depends on NVMEM
>>>          depends on RESET_CONTROLLER
>>>          help
>>>                  Enable this option if you want to get SoC temperature
>>>                  information for MediaTek platforms. This driver
>>>                  configures thermal controllers to collect temperature
>>>                  via AUXADC interface.
>>>
>>> drivers/thermal/mediatek/Makefile:
>>>
>>> obj-$(MTK_SOC_THERMAL)  += soc_temp.o
>>>
>>> However, rename 'soc_temp' to something more SoC explicit, eg.
>>> mtxxx_thermal.c
>>>
>>> Thanks
>>>
>>>     -- Daniel
>>
>> Hello Daniel,
>>
>> Thank you for the feedback.
>> Changes have been made as you suggested.
>> Resubmitting seen.
> *soon.

You may want to wait next week before sending a new version, I'm still 
reviewing your series (note you can send it anyway if you prefer)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
