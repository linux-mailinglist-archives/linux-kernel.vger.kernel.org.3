Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46875690D7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiGFRlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiGFRlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:41:09 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AA1B87C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 10:41:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id c15so19405445ljr.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6KthULA5VbxGyqiiOjKStZJbvnL5Ouw6A4+pSTV6Kj8=;
        b=JXpykR9CyoD738BQHWkUG0ypVyu3dd6Wuio2ZR72pj4RAsz4ciU/RABGkmzmDgdlB4
         Y4+EthXDwKUEbv4/QS/by9K1yMizKbQaKZWLKlNrCZ0XZqehFGmqZhJ0ffUsy6ThGHpn
         dXa+hET8TxYmeswjFN+YyEi8iR6gOyvuXVTdt11Ke5epMBmqV9ZJTxSam3rRl7wzqvB1
         4DBrBRbZYxaZNMRpansfPh8og2KF27ng1wSdCxYgWx+/fTVd/j0s6BsFHpwmCd5k9Jma
         gTMqqVsdt/l5PxWeMy/mu8EufPYofY9tudEvR7b7nJaQqU7s3VJPSj6uufQ7XE7qU7X2
         AtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6KthULA5VbxGyqiiOjKStZJbvnL5Ouw6A4+pSTV6Kj8=;
        b=BgmDrSRTEVvMmvxoqKUbL52Mb8Rpmbg3yLa8MDCBReleYWtQggUEOwe5q1SRyxw0Px
         laEmBRVsS4SiugNiUpVDphEujwhBSwd8EH600liGdWwK3JfTfxK7JSvXYq775aEggoc+
         l0xirOBS+gX0htQc/KGL1Z+0fp/mj0boR2kBfo/BMmD1mxebZ+NC1fuCsSE9/W6fETeg
         bpd4vXi88JUL7wFjOH10xuVHa9zF6SfUe/KzDfSfGw3g4nMlNp+rdIMQg8nJce2UMb0V
         NvIs/aqpGnU2BaeqpLp6RQ6N9BeGYoOrBCBg07Eyxwtm3GbSU9VSVIrz5vjMCr+/8OXg
         TxfQ==
X-Gm-Message-State: AJIora8jqQAv+4komJHsVospiAIX9b8KBuV3CjVH+YiTOPwN2Q7r2NeZ
        /GuhuqxF/Y/4MKBs57FdThabhg==
X-Google-Smtp-Source: AGRyM1tQBRHMvjV5LEJGwXYsY62d5osg8L+wM4g39+h6nowDWQdwsVn7zlcHYU8r78KNNQmktRwT3w==
X-Received: by 2002:a2e:b88f:0:b0:25d:4cc0:f03c with SMTP id r15-20020a2eb88f000000b0025d4cc0f03cmr50610ljp.173.1657129265687;
        Wed, 06 Jul 2022 10:41:05 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o13-20020ac25e2d000000b0047f660822e0sm6363586lfg.289.2022.07.06.10.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 10:41:05 -0700 (PDT)
Message-ID: <b85a7423-44ec-1f58-7465-e5322bc32cd3@linaro.org>
Date:   Wed, 6 Jul 2022 20:41:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] drm/msm/dp: make eDP panel as the first connected
 connector
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1657128246-15929-1-git-send-email-quic_khsieh@quicinc.com>
 <86ee9636-8827-7bad-6bd9-22191b2d293c@linaro.org>
 <949ae061-8191-2497-af56-1df74432272d@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <949ae061-8191-2497-af56-1df74432272d@quicinc.com>
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

On 06/07/2022 20:38, Kuogee Hsieh wrote:
> 
> On 7/6/2022 10:25 AM, Dmitry Baryshkov wrote:
>> On 06/07/2022 20:24, Kuogee Hsieh wrote:
>>> Some userspace presumes that the first connected connector is the main
>>> display, where it's supposed to display e.g. the login screen. For
>>> laptops, this should be the main panel.
>>>
>>> This patch call drm_helper_move_panel_connectors_to_head() after
>>> drm_bridge_connector_init() to make sure eDP stay at head of
>>> connected connector list. This fixes unexpected corruption happen
>>> at eDP panel if eDP is not placed at head of connected connector
>>> list.
>>>
>>> Changes in v2:
>>> -- move drm_helper_move_panel_connectors_to_head() to
>>>         dpu_kms_drm_obj_init()
>>>
>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>> ---
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>>> index 2b9d931..50ff666 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>>> @@ -763,6 +763,8 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms 
>>> *dpu_kms)
>>>       if (ret)
>>>           return ret;
>>>   +    drm_helper_move_panel_connectors_to_head(dev);
>>
>> This should be in msm_drv.c unless you have a strong reason to have it 
>> here.
> Can you please  provide more info why should be in msm_drv.c?

Let me quote my message from v1 review:

Please move this call to the msm_drm_init(). Calling this function 
somewhere after the ->kms_init() would make sure that all panel 
connectors are close to the top of the list, whichever MDP/DPU driver is 
used and whichever actual interface is bound to this panel.

>> _dpu_kms_drm_obj_init() create and initialize drm obj one by one and 
>> _dpu_kms_setup_displays() had created system wide connectors/interfaces .
> 
> After that should be fine to move edp to head of connector list.
> 
>>> +
>>>       num_encoders = 0;
>>>       drm_for_each_encoder(encoder, dev)
>>>           num_encoders++;
>>
>>


-- 
With best wishes
Dmitry
