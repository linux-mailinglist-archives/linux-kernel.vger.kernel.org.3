Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0761B50DBC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiDYI6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiDYI6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:58:39 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EDF13DCA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:55:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dk23so4923203ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IcmGf7R5oIWNJUW6YdAgXljamJfNzgr+F6RCVbOHK3E=;
        b=lnUMKK+1OUk9P/nASz5GkwqePWMvnfPG+lQJXZnZkCmVP4gQrMoFLGORFc2hEqvtZK
         sAb2sZQC8Fdx16dteLPlaMVwYzc07q+My98+bFhcwvZ2Tc4T7zlDoq0YuBAr5W1MeCIW
         4HghiKVjdKGLQp+/LutqOTTazYWT1v2za6tbR00yDrK036UXNGvWVe7auEC2ckESqqwh
         Dhz9QIdvpTrJvAJ+AMtG21UdzhQVOK56D5HzpmwzLXsAzKxwunKrBjGFXE2VfsxRbUzv
         cv7XDo2P/2VaJtvuBDJW9PSyA3dqjQ4w/LrPHrbvk3rc+IC4oI6yB0nDHKHRS+j+Ddif
         hAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IcmGf7R5oIWNJUW6YdAgXljamJfNzgr+F6RCVbOHK3E=;
        b=weI7jHRZgVBI2wHGsO0xio9w/IVPiTcV6id5wgRlzW0AHD2fHCr4A2WBEUPN6vKh3t
         saXLeFiDCv/69lPgbYnRZQcX7SdwzKtQJo5ieboXsYj6xMI7oB/vMDw2Iyu2JI1lONdi
         h8VFUd4XCOVU2bYSOTb19LkpHQnJDKJ8/cgTjGTS2MH6QcI/qfeSe2Tqm5wYpH8moJCS
         1fm/p/ZyVZgIetElpwrOcVRCA5FIjvX1lXanlnvwgbOJGlPMdFMUMKT66cRmxDGIXTMo
         USLD4e5emCOy45zsPbro6r/bTb5IybNgVAxKEZy5SgV91URQ/8PODjSFPHcTz4c75TcJ
         GZGQ==
X-Gm-Message-State: AOAM533a6q0URrfwc68l7kuhPOmksXl+gFidR/frfejiQfeEmbp6igAJ
        GTLeztCubl1cn/WnC0XDHeShIA==
X-Google-Smtp-Source: ABdhPJzVqoCmpWy0gNz3RLiWwx/wLVbIA8e6fPMteVvo0inali36p0hVI/pVtBzsJGwIy/owIIIRYw==
X-Received: by 2002:a17:906:49d4:b0:6d6:e5ec:9a23 with SMTP id w20-20020a17090649d400b006d6e5ec9a23mr15443661ejv.79.1650876930923;
        Mon, 25 Apr 2022 01:55:30 -0700 (PDT)
Received: from [192.168.0.240] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm3368048ejz.57.2022.04.25.01.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 01:55:30 -0700 (PDT)
Message-ID: <7873f0fa-25c3-191f-5096-3ceb9afd50cc@linaro.org>
Date:   Mon, 25 Apr 2022 10:55:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 01/14] dt-bindings: cpufreq: mediatek: Add MediaTek CCI
 property
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
 <20220422075239.16437-2-rex-bc.chen@mediatek.com>
 <f2e5a34b-ed02-91a1-bc7b-fecaa95e227e@linaro.org>
 <811bf944-a230-ab9b-583a-840e57af8a1e@linaro.org>
 <28f75ac2995b116af9b2accf760786d1d1798c93.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <28f75ac2995b116af9b2accf760786d1d1798c93.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 08:19, Rex-BC Chen wrote:
> On Fri, 2022-04-22 at 19:34 +0200, Krzysztof Kozlowski wrote:
>> On 22/04/2022 19:26, Krzysztof Kozlowski wrote:
>>> On 22/04/2022 09:52, Rex-BC Chen wrote:
>>>> MediaTek Cache Coherent Interconnect (CCI) uses software devfreq
>>>> module
>>>> for scaling clock frequency and adjust voltage.
>>>> The phandle could be linked between CPU and MediaTek CCI for some
>>>> MediaTek SoCs, like MT8183 and MT8186.
>>>> Therefore, we add this property in cpufreq-mediatek.txt.
>>>>
>>>> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
>>>> ---
>>>>  .../devicetree/bindings/cpufreq/cpufreq-mediatek.txt         | 5
>>>> +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-
>>>> mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-
>>>> mediatek.txt
>>>> index b8233ec91d3d..3387e1e2a2df 100644
>>>> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-
>>>> mediatek.txt
>>>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-
>>>> mediatek.txt
>>>> @@ -20,6 +20,11 @@ Optional properties:
>>>>  	       Vsram to fit SoC specific needs. When absent, the
>>>> voltage scaling
>>>>  	       flow is handled by hardware, hence no software "voltage
>>>> tracking" is
>>>>  	       needed.
>>>> +- mediatek,cci:
>>>> +	MediaTek Cache Coherent Interconnect (CCI) uses the software
>>>> devfreq module to
>>>> +	scale the clock frequency and adjust the voltage.
>>>
>>> Devfreq is a SW mechanism, it should not be part of bindings
>>> description.
> 
> Hello Krzysztof,
> 
> The reason we want to get the "mediatek,cci":
> We need to check the mediatek cci is ready and probed done.
> Because cpufreq and mediatek cci are sharing the same regulator in
> little core cpus.
> Therefore, to prevent high frequency low voltage issue, we need to make
> sure the mediatek cci is ready.
> 
> If mediatek cci is ready, cpufreq and mediatek cci will register the
> same regulator and from regulator's implementation, if there are two
> device using the same regulator, the framwork will make sure it's using
> the max voltage.

Thanks for explanation. The property should be described with what you
said here. The property and description should match hardware, so there
is no place for devfreq. Instead mention that power rail is shared or
voltage regulators are common.

However I am not sure if you solved your problem... see below:

> For example:
> mediatek cci set 1.2V originally. When cpufreq want to adjust lower
> frequency adn set voltage to 1.0V.
> The framework will remain using 1.2V to prevent crash of mediatek cci.

No, regulator_set_voltage() for proc_reg says:
"NOTE: If the regulator is shared between several devices then the lowest
 request voltage that meets the system constraints will be used."

Not the highest. So when your devfreq and cpufreq boots, calling
regulator_set_voltage will still cause high frequency and low voltage.

> 
> Therefore, we need to confirm the mediatek cci is ready and register
> the regulator.
>
>>>
>>>> +	For details, please refer to
>>>> +	Documentation/devicetree/bindings/interconnect/mediatek,cci.yam
>>>> l
>>>
>>> Since the file does not exist, I have troubles reviewing it. First
>>> of
>>> all, you already have "mediatek,cci-control" property in DT, so why
>>> using different name?
> 
> I am not sure where is "mediatek,cci-control". I think this name is not
> used before.
> 

Documentation/devicetree/bindings/net/mediatek-net.txt

>>>
>>> Second, it looks like you want to put devfreq into bindings instead
>>> of
>>> using proper interconnect bindings.
>>
>> Actually judging by the driver this looks like some
>> device-boot-time-ordering, so I wonder whether this is a proper way
>> to
>> express it.
> 
> Yes, we need to get the mediatek cci node and let cpufreq and mediatek
> cci link succefully. In that case, we can know the mediatek cci is
> ready. And we can set the voltage using the regulator framwork.
> 
> [1]: 
> https://patchwork.kernel.org/project/linux-mediatek/patch/20220422075239.16437-11-rex-bc.chen@mediatek.com/

Yes, I see the use case. I am not convinced yet whether this is proper
approach...


Best regards,
Krzysztof
