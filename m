Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B5B4BA837
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242237AbiBQS3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:29:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244307AbiBQS2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:28:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B6138BB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:27:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e3so10595084wra.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m7i8XTKn573xDW3h00Hw3tHZvPjE6WSVbAod5YiJM20=;
        b=tp3XN+Vk26cTI4ZXkHGYWn7fHIOWb5xAQkYnV4HJ9Tu7w0WtdV5xcv59x6DDKBSHpX
         y58Vxv2Jd2PBlnESSVYr6m5Xm4EBnD4psyOQr5vwN4RqpBWnSN+mTZYDJV79NrH/T2Yg
         oJnR1e64m3wW2UWeGPHirsOhwj87apeyOvRn4BNngxRzORwqTD/f3mo6XnN+DWtfr0KO
         3kS5C/JKtoH5sLB/Uy9t6nFKA5XVwvR3CvWwgKQb7cmDO/HBzdE+fyPY3M/0HF0DpHrG
         zsN9jm1u8qiFNVbXY6/JHUEpjU3ll6JGZCV20+x0Qnu9sUx1A+tOZ1CcvZADrAHKHlcQ
         5zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m7i8XTKn573xDW3h00Hw3tHZvPjE6WSVbAod5YiJM20=;
        b=bZpt7be4HKYusC6WwzhbaMbKv9cDTLmSOLOAX9dNY3VN5q/yuWSokJv/BxExMWT8j7
         nVqTZwJzUeFHy54RzzNSaRoqV8+CMljle2yATnBFYgQqJsHAVaxJPL4ih3fVKqGUVLuv
         a/osAiw9fTyN+Y4XjL3S9hjKTEi6SL09b7IPjBlyDqWnbX3G+hxjYR3YM9cwSjGvrHEW
         M0AIvTPF0ASTy75V3zGpV1IGwZc/JND3PcIAZS4dFf85TkUHJQm6YVXYzTk76L4GfZz8
         br7yLL8gNDfmTULikTFNuNwjWojfln4DUL9OZjqjDGKsQHfyWQ2EtCB/rHOTX/uw8J2o
         sfJw==
X-Gm-Message-State: AOAM530EzgB3m56aZAOZsbir8fTabkzF1iaDRIzgK4yj8IHJbC2xbHuw
        wyW8V37Tl9ketk4JXI9Ka+M6FQ==
X-Google-Smtp-Source: ABdhPJz6ZW2VMy9C5FA9BuqungODux4OLUkXbJvet9JtvZdITr5z+7gJAVJqV4jUUqdMjSY6sducoQ==
X-Received: by 2002:a5d:4907:0:b0:1e3:b4c:4a66 with SMTP id x7-20020a5d4907000000b001e30b4c4a66mr3272609wrq.273.1645122465788;
        Thu, 17 Feb 2022 10:27:45 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:5828:300b:5226:ef02? ([2a01:e34:ed2f:f020:5828:300b:5226:ef02])
        by smtp.googlemail.com with ESMTPSA id c8sm2615013wmq.34.2022.02.17.10.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 10:27:45 -0800 (PST)
Message-ID: <3651bf48-eb0f-1835-3c5e-1dbdc2730fb4@linaro.org>
Date:   Thu, 17 Feb 2022 19:27:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        amit daniel kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre.Gondois@arm.com, Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        jorcrous@amazon.com, Rob Clark <robdclark@chromium.org>,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com> <YgG+TmLrCSXX4Bvt@google.com>
 <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com> <YgKnnFl7Gp8AS30X@google.com>
 <e4532f65-7f8a-7e89-97c1-85cc61462040@arm.com> <YgQ9XLcto9v0fyTf@google.com>
 <d120110a-7d01-0cfd-f7eb-d160e17ec2a8@arm.com>
 <CAD=FV=VntGw1_AzJPpdOk0zSpOVZRH2X1JNg84JX+zCeU1jvXg@mail.gmail.com>
 <7c059f4f-7439-0cad-c398-96dbde4e49c1@linaro.org>
 <5b8ca53e-3595-85fd-5ae9-a5e8285e8513@arm.com>
 <CAD=FV=WMaMP84YLZxBZbj4DJSgcDLVkSHf4QdDwtFfp8UbyE7A@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAD=FV=WMaMP84YLZxBZbj4DJSgcDLVkSHf4QdDwtFfp8UbyE7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adding Manaf (QCom) in the loop

On 17/02/2022 17:37, Doug Anderson wrote:
> Hi,
> 
> On Thu, Feb 17, 2022 at 2:47 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Daniel,
>>
>> On 2/17/22 10:10 AM, Daniel Lezcano wrote:
>>> On 16/02/2022 18:33, Doug Anderson wrote:
>>>> Hi,
>>>>
>>>> On Wed, Feb 16, 2022 at 7:35 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>>
>>>>> Hi Matthias,
>>>>>
>>>>> On 2/9/22 10:17 PM, Matthias Kaehlcke wrote:
>>>>>> On Wed, Feb 09, 2022 at 11:16:36AM +0000, Lukasz Luba wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2/8/22 5:25 PM, Matthias Kaehlcke wrote:
>>>>>>>> On Tue, Feb 08, 2022 at 09:32:28AM +0000, Lukasz Luba wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>
>>>>> [snip]
>>>>>
>>>>>>>>> Could you point me to those devices please?
>>>>>>>>
>>>>>>>> arch/arm64/boot/dts/qcom/sc7180-trogdor-*
>>>>>>>>
>>>>>>>> Though as per above they shouldn't be impacted by your change,
>>>>>>>> since the
>>>>>>>> CPUs always pretend to use milli-Watts.
>>>>>>>>
>>>>>>>> [skipped some questions/answers since sc7180 isn't actually
>>>>>>>> impacted by
>>>>>>>>      the change]
>>>>>>>
>>>>>>> Thank you Matthias. I will investigate your setup to get better
>>>>>>> understanding.
>>>>>>
>>>>>> Thanks!
>>>>>>
>>>>>
>>>>> I've checked those DT files and related code.
>>>>> As you already said, this patch is safe for them.
>>>>> So we can apply it IMO.
>>>>>
>>>>>
>>>>> -------------Off-topic------------------
>>>>> Not in $subject comments:
>>>>>
>>>>> AFAICS based on two files which define thermal zones:
>>>>> sc7180-trogdor-homestar.dtsi
>>>>> sc7180-trogdor-coachz.dtsi
>>>>>
>>>>> only the 'big' cores are used as cooling devices in the
>>>>> 'skin_temp_thermal' - the CPU6 and CPU7.
>>>>>
>>>>> I assume you don't want to model at all the power usage
>>>>> from the Little cluster (which is quite big: 6 CPUs), do you?
>>>>> I can see that the Little CPUs have small dyn-power-coeff
>>>>> ~30% of the big and lower max freq, but still might be worth
>>>>> to add them to IPA. You might give them more 'weight', to
>>>>> make sure they receive more power during power split.
>>>>>
>>>>> You also don't have GPU cooling device in that thermal zone.
>>>>> Based on my experience if your GPU is a power hungry one,
>>>>> e.g. 2-4Watts, you might get better results when you model
>>>>> this 'hot' device (which impacts your temp sensor reported value).
>>>>
>>>> I think the two boards you point at (homestar and coachz) are just the
>>>> two that override the default defined in the SoC dtsi file. If you
>>>> look in sc7180.dtsi you'll see 'gpuss1-thermal' which has a cooling
>>>> map. You can also see the cooling maps for the littles.
>>>>
>>>> I guess we don't have a `dynamic-power-coefficient` for the GPU,
>>>> though? Seems like we should, but I haven't dug through all the code
>>>> here...
>>>
>>> The dynamic-power-coefficient is available for OPPs which includes
>>> CPUfreq and devfreq. As the GPU is managed by devfreq, setting the
>>> dynamic-power-coefficient makes the energy model available for it.
>>>
>>> However, the OPPs must define the frequency and the voltage. That is the
>>> case for most platforms except on QCom platform.
>>>
>>> That may not be specified as it uses a frequency index and the hardware
>>> does the voltage change in our back. The QCom cpufreq backend get the
>>> voltage table from a register (or whatever) and completes the voltage
>>> values for the OPPs, thus adding the information which is missing in the
>>> device tree. The energy model can then initializes itself and allows the
>>> usage of the Energy Aware Scheduler.
>>>
>>> However this piece of code is missing for the GPU part.
>>>
>>
>> Thank you for joining the discussion. I don't know about that Qcom
>> GPU voltage information is missing.
>>
>> If the voltage is not available (only the frequencies), there is
>> another way. There is an 'advanced' EM which uses registration function:
>> em_dev_register_perf_domain(). It uses a local driver callback to get
>> power for each found frequency. It has benefit because there is no
>> restriction to 'fit' into the math formula, instead just avg power
>> values can be feed into EM. It's called 'advanced' EM [1].
> 
> It seems like there _should_ be a way to get the voltage out for GPU
> operating points, like is done with cpufreq in
> qcom_cpufreq_hw_read_lut(), but it might need someone with Qualcomm
> documentation to help with it. Maybe Rajendra would be able to help?
> Adding Jordon and Rob to this conversation in case they're aware of
> anything.
> 
> As you said, we could just list a power for each frequency, though.
> 
> I'm actually not sure which one would be more accurate across a range
> of devices with different "corners": specifying a dynamic power
> coefficient used for all "corners" and then using the actual voltage
> and doing the math, or specifying a power number for each frequency
> and ignoring the actual voltage used. In any case we're trying to get
> ballpark numbers and not every device will be exactly the same, so
> probably it doesn't matter that much.
> 
> 
>> Now we hit (again) the DT & EM issue (it's an old one, IIRC Morten
>> was proposing from ~2014 this upstream, but EAS wasn't merged back
>> then):
>> where to store these power-freq values, which are then used by the
>> callback. We have the 'dynamic-power-coefficient' in DT, but
>> it has limitations. It would be good to have this simple array
>> attached to the GPU/CPU node. IMHO it meet the requirement of DT,
>> it describes the HW (it would have HZ and Watts values).
>>
>> Doug, Matthias could you have a look at that function and its
>> usage, please [1]?
>> If you guys would support me in this, I would start, with an RFC
>> proposal, a discussion on LKML.
>>
>> [1]
>> https://elixir.bootlin.com/linux/v5.17-rc4/source/Documentation/power/energy-model.rst#L87
> 
> Matthias: I think you've spent more time on the thermal stuff than me
> so I'll assume you'll follow-up here. If not then please yell!
> 
> Ideally, though, someone from Qualcomm would jump in an own this.
> Basically it allows more intelligently throttling the GPU and CPU
> together in tandem instead of treating them separately IIUC, right?
> 
> -Doug


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
