Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97B4501BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345384AbiDNTXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbiDNTXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:23:00 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871E4A776F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:20:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t25so10762812lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vp0QTlQ+Ul12qwBiTeo6WQhXUXb0oDOX5cKNXB8aPjA=;
        b=vtTVHj80EGxNxKDlWGtszG3FwMg4Ey5uQHChZ2COAtQ3UUZTlIFf0z5PGKPiraBznp
         nlnwtsO3/u7tW7hBz/zuev7xxyVez2a1UV4nWJzEA+tbDF+toFxvgf3oS+Ph+MAcVJqx
         6pLvnc9UJe5jn4SBNdLYPN5Qax2ShWH+dQdCyYir+zNtxeCkS/MloXri0Byr1k6CWrQn
         DIvXAWCR+AUnhw9m8COyU5g0yWa8VV81TuALFXgSzmLsSb/ODZY/kz9XdUipaRxtpkJK
         cqtoJaVQNx9rfchIoRjAhYaGI2BQb5x1lxq0/4EC3hHEbQsLJBz8UJhBvQ6QjuJxevF5
         4v5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vp0QTlQ+Ul12qwBiTeo6WQhXUXb0oDOX5cKNXB8aPjA=;
        b=0q413d+RiuHu8E8Eb08lXOFlGdff8q+3pxlXpEx2IKcMxBTwecVj6OXNyH5H+CIVWV
         5LZW7wRz4FD4/xM4QT5AN/B++L/8zvv5BmGKAZ4S5RCyIvGEq739TES/vzgXPQtC/rCN
         cSPsHfLgCmtTdynVEWS7BC4c5mRhLS8tLqbH2Upew1ABmej/d8D9scykIfun9fvqYK1U
         k6tNz6tCADkmoXqxIU8Jxg8oS6hS8W/OotVHlpQ7rCgHMAm0B9nmpKDBjENT8YmGgrQ9
         L4wGJvzZectUTSz7CpeV+TzrMJyJfWsmN6C0JjiGXTpotBBjOLw1Ol7YsTP4JhgzHFd2
         eVCg==
X-Gm-Message-State: AOAM530ZMGRtmTY2O6TfGDWbRj6kT6wRBmJKjY5HmhF0yAAJ0Tj7lQvw
        UukxUPb3q0hUrPV+ykM9O/KcWw==
X-Google-Smtp-Source: ABdhPJxo5MHFE963Dq+Wyme7Ct5D7t+GPbOhgBQl/OVd4GpTcR+TbNjtlAMv2Dy5gtjdWO+O9T8iPA==
X-Received: by 2002:a05:6512:4024:b0:46b:fc7e:a455 with SMTP id br36-20020a056512402400b0046bfc7ea455mr2937396lfb.156.1649964032785;
        Thu, 14 Apr 2022 12:20:32 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t1-20020a19dc01000000b0046ba600f866sm83561lfg.180.2022.04.14.12.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 12:20:32 -0700 (PDT)
Message-ID: <20afcd97-4b8d-f770-151a-268b893b7c5a@linaro.org>
Date:   Thu, 14 Apr 2022 22:20:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v7 0/4] Add support for the eDP panel over aux_bus
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
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>
References: <1649938766-6768-1-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=Ui6BAsnTaJ2_TMh1Tnjtaw7FR92aWoUysS+UT=c0qB3Q@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAD=FV=Ui6BAsnTaJ2_TMh1Tnjtaw7FR92aWoUysS+UT=c0qB3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2022 19:40, Doug Anderson wrote:
> Hi,
> 
> On Thu, Apr 14, 2022 at 5:19 AM Sankeerth Billakanti
> <quic_sbillaka@quicinc.com> wrote:
>>
>> This series adds support for generic eDP panel over aux_bus.
>>
>> These changes are dependent on the following series:
>> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=613654&state=*
> 
> You're basically depending on the last two patches of that series.
> What's the plan there? In patchwork they're marked as "Not
> Applicable". If they're good to go, maybe we should land them? If not,
> maybe you should include them (with Dmitry as the author, of course)
> at the beginning of your series?

No, please do not resend patches. The patches in question are marked as 
'Not applicable' as they are really not applicable to Bjorn's tree.
It would be better to point to the correct patchwork:

https://patchwork.freedesktop.org/series/98585/

Note those patches still lack the R-B tag. I can include them anyway, 
basing on Sankeerth's Tested-by tag, but the formal R-B would also be good.


> 
> 
>> Sankeerth Billakanti (4):
>>    drm/msm/dp: Add eDP support via aux_bus
>>    drm/msm/dp: Support only IRQ_HPD and REPLUG interrupts for eDP
>>    drm/msm/dp: wait for hpd high before aux transaction
>>    Support the eDP modes given by panel
> 
> One of these things is not like the others. One of these things just
> doesn't belong. Can you spot which patch is missing the prefix by
> looking at the subject line of all 4 patches? ;-)

:-)


-- 
With best wishes
Dmitry
