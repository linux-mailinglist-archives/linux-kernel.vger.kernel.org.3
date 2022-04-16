Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E2D50334D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiDPARV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 20:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiDPARQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 20:17:16 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB496540A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 17:14:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u19so16128886lff.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 17:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kmCIJYxkSl8+6zNO2ByY5420J4KgV40/Bvhc8LMZxPI=;
        b=xRIu3WmBpfnJtJjdS7zJ1TIJrDKXfG8JAcQGM2+IEJHQwoZKjMRqpbQShS/cPzXpT2
         ba/PDkRnwdfFgMpFSfStxu/5UWGb6E8a+sJbttoSGNijs0Z/0j9zhaSUI11qaJi8vyow
         +zK1rfLD9DF2smFkWIGjKtZrH3Fa3DKoO6e3eHt+/fNk0Okgc5ecC/HsQwmlVoqcGiag
         +vU4Dku2plqC5iFifskXKkg6wy3Bg6sJIUTMPirMElfmjv5mjT/Kq+wVVFS9Qje4RxGU
         bKdGiUC0qzFD6Hn71dFCgfr5AkEEuqALx3pdXK0RgnsaSmxAsm/gyLuxQH3zxY7XZWnh
         sr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kmCIJYxkSl8+6zNO2ByY5420J4KgV40/Bvhc8LMZxPI=;
        b=F6xcQgFs6vNBSun79DP/Tvc85MwgygoPE08Dp0CFp6kIlZfIa57gOnXIdlfIM6Jedu
         CJrlv1pXc3jXZMDmo9FU37HGnDjL3vAiRUY7Q117cwgutkaPhbj8hBdKReqgyrXXGNen
         7jwST39M7Skpo/m3/FmsHZKPy7kOrgbbF3NZDtWFJxE7mp3Me/edpK4b4yAXHyrwWVLl
         KN1isvx/VlGDasV9yGRma6hoIaVv1vPzb+vVyxxqMS80mO1OnAoOMnD05igKRrYkArsE
         4roQVRQ60c7Zwy7OOB8SBy4efHAVv67SK8wEU4uKq1ijm3LgNaL0nQeIhG+J7lF0f2pQ
         8nJQ==
X-Gm-Message-State: AOAM531I9GzW8heyBs5kL/0zkZtfODhyAw2gxPE+laNOYGV3FeRXFQEr
        ZbF/L8t7icDOkl43sMj5it4Clmhm42GYohSN9Co=
X-Google-Smtp-Source: ABdhPJx0kWRhaLh0iMY4qb8BBiz3Hflaw3HkGMBad1UIqlpVfGfYLt5MpAl221/DZHfNaOI/cFYG1Q==
X-Received: by 2002:a05:6512:1688:b0:464:f53f:850f with SMTP id bu8-20020a056512168800b00464f53f850fmr851968lfb.637.1650068083386;
        Fri, 15 Apr 2022 17:14:43 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t25-20020a19dc19000000b0044a16b068c7sm494947lfg.117.2022.04.15.17.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 17:14:42 -0700 (PDT)
Message-ID: <835fa3cd-0777-1dea-972f-3e24d5aeda3a@linaro.org>
Date:   Sat, 16 Apr 2022 03:14:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH 4/6] drm/panel-edp: Take advantage of
 is_hpd_asserted() in struct drm_dp_aux
Content-Language: en-GB
To:     Doug Anderson <dianders@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Robert Foss <robert.foss@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220409023628.2104952-1-dianders@chromium.org>
 <20220408193536.RFC.4.Icea616f57331fbaa3d48c529f300c9a8ebd37fb5@changeid>
 <027b3ca1-fbd3-7bce-1ca0-ec92a5f23fee@linaro.org>
 <CAD=FV=Xu7b=t1C4JHF4U9BsD9wFy_x_GseJFNytHdCKvnS9DoA@mail.gmail.com>
 <CAA8EJppyBTDeFVztS2rTihAwEjJdmJf1Md-Qa3x3MijVvbzSUQ@mail.gmail.com>
 <CAD=FV=XbCggB6kVwE8jj3DO3GWXj=_LeXatST3S9h91kh32nEw@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAD=FV=XbCggB6kVwE8jj3DO3GWXj=_LeXatST3S9h91kh32nEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2022 03:12, Doug Anderson wrote:
> Hi,
> 
> On Fri, Apr 15, 2022 at 3:12 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On Sat, 16 Apr 2022 at 00:17, Doug Anderson <dianders@chromium.org> wrote:
>>>
>>> Hi,
>>>
>>> On Thu, Apr 14, 2022 at 5:51 PM Dmitry Baryshkov
>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>
>>>> On 09/04/2022 05:36, Douglas Anderson wrote:
>>>>> Let's add support for being able to read the HPD pin even if it's
>>>>> hooked directly to the controller. This will allow us to get more
>>>>> accurate delays also lets us take away the waiting in the AUX transfer
>>>>> functions of the eDP controller drivers.
>>>>>
>>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>>>> ---
>>>>>
>>>>>    drivers/gpu/drm/panel/panel-edp.c | 37 ++++++++++++++++++++++++++-----
>>>>>    1 file changed, 31 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
>>>>> index 1732b4f56e38..4a143eb9544b 100644
>>>>> --- a/drivers/gpu/drm/panel/panel-edp.c
>>>>> +++ b/drivers/gpu/drm/panel/panel-edp.c
>>>>> @@ -417,6 +417,19 @@ static int panel_edp_get_hpd_gpio(struct device *dev, struct panel_edp *p)
>>>>>        return 0;
>>>>>    }
>>>>>
>>>>> +static bool panel_edp_can_read_hpd(struct panel_edp *p)
>>>>> +{
>>>>> +     return !p->no_hpd && (p->hpd_gpio || (p->aux && p->aux->is_hpd_asserted));
>>>>> +}
>>>>> +
>>>>> +static bool panel_edp_read_hpd(struct panel_edp *p)
>>>>> +{
>>>>> +     if (p->hpd_gpio)
>>>>> +             return gpiod_get_value_cansleep(p->hpd_gpio);
>>>>> +
>>>>> +     return p->aux->is_hpd_asserted(p->aux);
>>>>> +}
>>>>> +
>>>>>    static int panel_edp_prepare_once(struct panel_edp *p)
>>>>>    {
>>>>>        struct device *dev = p->base.dev;
>>>>> @@ -441,13 +454,21 @@ static int panel_edp_prepare_once(struct panel_edp *p)
>>>>>        if (delay)
>>>>>                msleep(delay);
>>>>>
>>>>> -     if (p->hpd_gpio) {
>>>>> +     if (panel_edp_can_read_hpd(p)) {
>>>>>                if (p->desc->delay.hpd_absent)
>>>>>                        hpd_wait_us = p->desc->delay.hpd_absent * 1000UL;
>>>>>                else
>>>>>                        hpd_wait_us = 2000000;
>>>>>
>>>>> -             err = readx_poll_timeout(gpiod_get_value_cansleep, p->hpd_gpio,
>>>>> +             /*
>>>>> +              * Extra max delay, mostly to account for ps8640. ps8640
>>>>> +              * is crazy and the bridge chip driver itself has over 200 ms
>>>>> +              * of delay if it needs to do the pm_runtime resume of the
>>>>> +              * bridge chip to read the HPD.
>>>>> +              */
>>>>> +             hpd_wait_us += 3000000;
>>>>
>>>> I think this should come in a separate commit and ideally this should be
>>>> configurable somehow. Other hosts wouldn't need such 'additional' delay.
>>>>
>>>> With this change removed:
>>>>
>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>
>>> What would you think about changing the API slightly? Instead of
>>> is_hpd_asserted(), we change it to wait_hpd_asserted() and it takes a
>>> timeout in microseconds. If you pass 0 for the timeout the function is
>>> defined to behave the same as is_hpd_asserted() today--AKA a single
>>> poll of the line.
>>
>> This might work. Can you check it, please?
> 
> Cool. I'll spin with this. Hopefully early next week unless my inbox
> blows up. ...or my main PC's SSD like happened this week. ;-)
> 
> 
>> BTW: are these changes dependent on the first part of the patchset? It
>> might be worth splitting the patchset into two parts.
> 
> Definitely not. As per the cover letter, this is two series jammed
> into one. I'm happy to split them up. The 2nd half seems much less
> controversial.

Great, let's get it in then. As you have time.


-- 
With best wishes
Dmitry
