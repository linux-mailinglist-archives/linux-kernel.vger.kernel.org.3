Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A144F00B9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiDBKjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiDBKjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:39:42 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA581AF7E9
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:37:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h7so9081729lfl.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 03:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Jx8e761MNPFyJ2/BAtkY0nyoED7Z8+xj5f0GT++V4DU=;
        b=CM5tAEao5vQ2577zZq46eGT5uUdK6gdVlWEARVuyxYeNLnYiT8lvo5OCG2ZcKhDGfb
         wy6RzILMGSWya1H7UCQr8Y4fjgCHbD+N0bIgO8rFWOwSygD60R87YX12LQBKXes0rNPR
         FQOBFpPb/5zrL2nQxvW2rumRZWeKgIx/p9Ila06gACmYl8sawMjF2PLwS8QtgZb8I5qx
         QyOD88AioP5g/0oCKIYAfuqniXGLgVHDyp5CkITXTV/3iv2MJ1nPjOiTehzvNKJJvomc
         Oa3oNbA/WgWKKW3dNoiI/IVu3xfKKUao07GPXs4EzJA+/sVfrm6CUbZRq58SKFwbCDRs
         CVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Jx8e761MNPFyJ2/BAtkY0nyoED7Z8+xj5f0GT++V4DU=;
        b=crYwIJEkoPF06oyWgvbGgQcNTxEqzlR6OoHrz5yEYu+wAKuONMxf9nB79Ywe0qWDlF
         a9NElrWd66lqFnBD/nRfLgD91dknnwh8f9m5GPCdXAiPSjtwVYY+4uqdqxU/el345Lub
         ko7gWrJkUygl8QDVR0KxNpQ/N1u+qo3VcOBmJBGLJr9VnxeqABOMGOvvsabdsl5PdAN0
         TlNhsS1ee9wb8S8YXL6sgAP4xKUqUl45dsktkR3/eWQ6HFzuiPEjJ4Mtwx8r56N71YRj
         MI0oxpC8VqZzNaOH3Q8/AGkjRW14jAKqN5H0Kp+VqrmP0aFGRHk1NzumeBJLTd4Gr+j6
         VyOw==
X-Gm-Message-State: AOAM531LHE71YW5i1l2aTqggSQAQwtXFPHePl8kzX+Iusjs7M7QM09GN
        azrAgs7K9gPi6MFTzMnJSx+Rag==
X-Google-Smtp-Source: ABdhPJwCW+uY9rOuoWmKzwTgEAQFjN4YRpp4A7QPyITSlGphPJj0f1ExJfTaWODEaAXo0GmLCCHjuw==
X-Received: by 2002:a05:6512:3c90:b0:44a:dc25:ab44 with SMTP id h16-20020a0565123c9000b0044adc25ab44mr4502073lfv.407.1648895865799;
        Sat, 02 Apr 2022 03:37:45 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id i16-20020a056512319000b0044ae52c6365sm264006lfe.88.2022.04.02.03.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 03:37:45 -0700 (PDT)
Message-ID: <392b933f-760c-3c81-1040-c514045df3da@linaro.org>
Date:   Sat, 2 Apr 2022 13:37:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 1/8] drm/msm/dp: Add eDP support via aux_bus
Content-Language: en-GB
To:     Doug Anderson <dianders@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        quic_aravindh@quicinc.com
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com>
 <1648656179-10347-2-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=X+QvjwoT2zGP82KW4kD0oMUY6ZgCizSikNX_Uj8dNDqA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAD=FV=X+QvjwoT2zGP82KW4kD0oMUY6ZgCizSikNX_Uj8dNDqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 01/04/2022 02:22, Doug Anderson wrote:
> Hi,
> 
> On Wed, Mar 30, 2022 at 9:03 AM Sankeerth Billakanti
> <quic_sbillaka@quicinc.com> wrote:
>>
>> @@ -1547,6 +1593,10 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
>>
>>          dp_display->encoder = encoder;
>>
>> +       ret = dp_display_get_next_bridge(dp_display);
>> +       if (ret)
>> +               return ret;
> 
> It feels weird to me that this is in a function called "modeset_init",
> though I certainly don't know the structure of the MSM display code
> well enough to fully comment.

It's called modeset_init() as it initializes KMS objects used by DP 
driver. We have similar functions for dsi and hdmi

> My expectation would have been that
> devm_of_dp_aux_populate_ep_devices() would have been called from your
> probe routine and then you would have returned -EPROBE_DEFER from your
> probe if you were unable to find the panel afterwards.

I don't think it's possible to call it from probe() since 
drm_dp_aux_register() is called only from dp_display_bind().
The PHY also isn't initialized at that moment, so we can not probe AUX 
devices.

The overall semantics of the AUX bus is not clear to me.
Typically the bus is populated (and probed) when devices are accessible. 
But for the display related buses this might not be the case.
For example for the DSI bus we clearly define that DSI transfer are not 
possible before the corresponding bridge's (or panel's) enable call.

Maybe the same approach should be adopted for the AUX bus. This would 
allow us to populate the AUX bus before hardware access is actually 
possible, thus creating all the DRM bridges before the hardware is 
actually up and running.

> Huh, but I guess you _are_ getting called (indirectly) from
> dpu_kms_hw_init() and I can't imagine AUX transfers working before
> that function is called, so maybe I should just accept that it's
> complicated and let those who understand this driver better confirm
> that it's OK. ;-)
> 
> 
>> @@ -140,5 +140,6 @@ struct dp_parser {
>>    * can be parsed using this module.
>>    */
>>   struct dp_parser *dp_parser_get(struct platform_device *pdev);
>> +int dp_parser_find_next_bridge(struct dp_parser *parser);
> 
> Everything else in this file is described w/ kerneldoc. Shouldn't your
> function also have a kerneldoc comment?

-- 
With best wishes
Dmitry
