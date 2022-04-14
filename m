Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E011501F28
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 01:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346813AbiDNXg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 19:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244992AbiDNXgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:36:52 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FBEB1C9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:34:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id o16so7873690ljp.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Iui9A+eLQEY/nX+0oDEarv6ntwSJTGA8ToTL+L3pSEo=;
        b=tPx3lgri1J4tM045vBZculeqPJ22HKITNe27W1ZxTmMg3yUfKNn+TV2PX9786JrPSM
         hkQy2xsKJnKixL0NBGE8/p+LrGOb2S5tTuQ+q8ucsxWw2tDvT5PkE4S2ouT1GszK0k5C
         9R9tEFvRgDMIqGGRZEO1sW2b16jHX6+GTxKJ7uRN/bAsIUnTRFyC8iueFCw4b18Spnto
         hvrBogLeJiSc+5K+OZ0NaHIvaL5DwN0Ph5G2+tNpdrhJNIkh/ffjWrzA+QWeIPxx9YJv
         /drw2SkZ4YFuzMUtnPBAKAdWWQzLiSUZ7S8d+s3ReoZLWG605WBm5czCpZDIYv68Mwks
         /lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Iui9A+eLQEY/nX+0oDEarv6ntwSJTGA8ToTL+L3pSEo=;
        b=PO5vPDY2w1pOTw0uLI8vMVilh9lpRRtDdWj2oXJB918iKgI2aIfc1/otW0HTHuJXIw
         Ysx2upzEo9L4FOjfIW1YdCpRVUEk7Lwy19tXEfelfQneXwS+r8GZZZCucpzgmEHqGV4O
         VVZAEdnelztYJGd/3LBvyQB9RMqmQBj/tU+11ex1EatLtX/3WJRrWY18bnDZMq7CvPdH
         ft6zQDLJjf65te7ZKnpouXhKWwTw6BIQQstxQTswOXjPLYpywDZW2SV1mVxzSlvX7/tE
         NA2HLlOVSG9e5a4AW1F6yY6TPX9Clg7jdq4rb5nR9X3IIh1MbCA+Jyfb2bIOIH52ZsuX
         fQ6Q==
X-Gm-Message-State: AOAM531CvD7TbkQxjor1Nwpo27llhknY+R9lD+kYqIJjJgzjWvs4uGQm
        MOrvpofs5qSUXYSzhRbvacKKlA==
X-Google-Smtp-Source: ABdhPJzU0/5iGIGtQknfdNITwXnU5YI4i91HNLcKDS61fNRoBC8iasXpudVYzEAXrHuLyFTN5P8h4w==
X-Received: by 2002:a2e:5cc1:0:b0:24b:112f:9b36 with SMTP id q184-20020a2e5cc1000000b0024b112f9b36mr2938326ljb.337.1649979261871;
        Thu, 14 Apr 2022 16:34:21 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y37-20020a0565123f2500b0044a1e1c6b37sm142795lfa.53.2022.04.14.16.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 16:34:21 -0700 (PDT)
Message-ID: <27bb2732-b322-75b0-3883-773e6eb4b1b9@linaro.org>
Date:   Fri, 15 Apr 2022 02:34:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] drm/msm/dp: enhance both connect and disconnect
 pending_timeout handle
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org,
        quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1649280493-4393-1-git-send-email-quic_khsieh@quicinc.com>
 <625ce8a0-4e25-5513-5599-c1cdebf5a3a5@linaro.org>
 <09fd563f-4a2c-f670-51c2-0e5ff023816d@quicinc.com>
 <CAA8EJpqzucFGf8ndDi2LZqtKiOt_w=_h1oPAUNVCdmUyh_3+zA@mail.gmail.com>
 <2039ef97-4fdb-bffe-1e02-18ae79c18be4@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <2039ef97-4fdb-bffe-1e02-18ae79c18be4@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2022 01:06, Kuogee Hsieh wrote:
> 
> On 4/8/2022 4:59 PM, Dmitry Baryshkov wrote:
>> On Fri, 8 Apr 2022 at 23:30, Kuogee Hsieh <quic_khsieh@quicinc.com> 
>> wrote:
>>>
>>> On 4/8/2022 5:27 AM, Dmitry Baryshkov wrote:
>>>> On 07/04/2022 00:28, Kuogee Hsieh wrote:
>>>>> dp_hpd_plug_handle() is responsible for setting up main link and send
>>>>> uevent to notify user space framework to start video stream. 
>>>>> Similarly,
>>>>> dp_hdp_unplug_handle is responsible to send uevent to notify user 
>>>>> space
>>>>> framework to stop video stream and then tear down main link.
>>>>> However there are rare cases, such as in the middle of system
>>>>> suspending,
>>>>> that uevent could not be delivered to user space framework. Therefore
>>>>> some kind of recover mechanism armed by timer need to be in place 
>>>>> in the
>>>>> case of user space framework does not respond to uevent.
>>>> Hmm, how does userpsace 'respond' to the uevent? The driver should
>>>> send hotplug notifications to userspace, but it must not expect any
>>>> particular reaction. The userspace might be as simple, as fbdev
>>>> emulation, but the driver still should function correctly.
>>> yes, driver is function correctly by setting up main link. but it does
>>> not know which resolution to display.
>>>
>>> It send hotplug notification through uevent to framework after main link
>>> is ready.
>>>
>>> Framework  is responsible to set up MDP timing engine to start video 
>>> stream.
>>>
>>>
>>> However it does not know which
>> It's of no concern to the driver. It is completely the userspace
>> problem. After resuming, it should reread available video output
>> properties. The display could have been changed while the system is
>> suspended.
>>  From your description I still do not understand why you need the
>> 'recovery' mechanism.
> 
> I mean "recovery" means  dp driver may leave stay at link ready 
> mistakenly after dongle unplugged due to missing framework action to 
> tear down main link so that next dongle plug in will not work.
> 
> Currently it was armed with timeout function and it will fired if 
> framework did not call msm_dp_display_disable() after 5 second.

framework = userspace?

Is my understanding correct? Currently DP driver sends a notification to 
userspace that DP is unplugged, waits for userspace to disable DP 
output, and only after that it will shutdown the link. Is this a correct 
description?

If so, then yes, your change is correct. I mean that the kernel 
shouldn't wait for clients to stop using video pipeline if the sink gets 
unplugged. Instead it should tear the video stream down and let the DRM 
client cope with that.

I'm not sure how should the driver react if the client doesn't disable 
the output, but then the sink gets reattached?
And a bit more interesting question: how should the driver behave if the 
new sink is not compatible with the existing video stream.

> 
> Anyway, we think this approach is not good. therefore it is replaced 
> with  below patch.
> 
> drm/msm/dp: tear down main link at unplug handle immediately


-- 
With best wishes
Dmitry
