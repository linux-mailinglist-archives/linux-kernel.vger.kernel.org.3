Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5656D57F723
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 23:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGXVLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 17:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiGXVLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 17:11:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A631F5B0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 14:11:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m17so13190066wrw.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 14:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I82qCTQ+1+1kumTVL2f6gNoXqjsEJx9FUsiKSkcu270=;
        b=wuSz/1wPl7gCzKBGTUPtom3BFEKJpiqNqxZ4FD9KL0Hvv6Sr3t2FKAN6uNF78WR34c
         VkXBGmwAfh92UQJL5hi0v+DoS1thFimQqc299PmWJ4eRwqmQlS0fhWpMYIGoj7M4n0tY
         BZ9w4bnvFFOngJLuF4NlBh72ajZ/URu435ZULEaG6U6Qp9wm0weonKI9Noe0+t9IGt9m
         z/iQfVQR8b5yuO0GICC+0cOtEYhAX2rtcZJU7WTt6Ala/9jf8ZdmTDM0KZ2uhQ0AnUPt
         nV9qT2SSpKm08WMIO08mf+cnXbJnEapJwhTkJFqRDBAYZlsnEpB2g5pXr6PyOBSDuzNZ
         SOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I82qCTQ+1+1kumTVL2f6gNoXqjsEJx9FUsiKSkcu270=;
        b=N0G+YDZ14+wdquTUEjJAee1bFvDfBaeerJ7uz52ckhXXoIk+cjRaNfjCGhHIf2HrLN
         n+nR0jXppxIzmOieOLn7Wi7yXWB2dQbMyZFxCaZ/K53sGxuM3dE1nfs8158Ouy7aoMbh
         11POg56im9KEzK/nX33TrnvRfGu9NbTTg/Cjskioo1cnzCqcnWEW4kizHYSVsFenuYYN
         iwsCZIaGfyWgvKbcwZHUkedtSlxJooBP9SYU91fXuUN+/9O8tHwDGtV2LQaAY2dmK8Tf
         683ExmGfw78uMDcnPDtA1J1VUEXcdGMYjDwz1dEKQ0Dsru3IW4NY7Fer/cPP2vvQDnhV
         NT+w==
X-Gm-Message-State: AJIora91hQnQN2KRYIwhKvz3G5xb+bQIdUkQ+T28V5L6hj4I+839N3bY
        lXM7WiMG1V95yK5wuEXQKZ7ZZQ==
X-Google-Smtp-Source: AGRyM1sR5s1/uJ/Qo8R7OPhstjMROxTZaEI8GaJ88n/sbN81zRM4xCZiuy2eLE0fYDeQQk6WBMflUw==
X-Received: by 2002:a5d:64e8:0:b0:21d:b277:d4a7 with SMTP id g8-20020a5d64e8000000b0021db277d4a7mr6030105wri.621.1658697109443;
        Sun, 24 Jul 2022 14:11:49 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:feb7:6a58:3e0f:a58f? ([2a05:6e02:1041:c10:feb7:6a58:3e0f:a58f])
        by smtp.gmail.com with ESMTPSA id r16-20020adfdc90000000b0021cf31e1f7csm10382968wrj.102.2022.07.24.14.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 14:11:48 -0700 (PDT)
Message-ID: <e2a56ac3-057c-2b17-7bde-7e860a86807d@linexp.org>
Date:   Sun, 24 Jul 2022 23:11:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 17/33] thermal/drivers/rcar: Switch to new of API
Content-Language: en-US
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        khilman@baylibre.com, abailon@baylibre.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-18-daniel.lezcano@linexp.org>
 <YtZ1IExNlsYaJkC9@oden.dyn.berto.se>
 <18ade2d0-ebda-0526-71f3-65a0b2685068@linexp.org>
 <Yt2W5UCXaB3Memzg@oden.dyn.berto.se>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
In-Reply-To: <Yt2W5UCXaB3Memzg@oden.dyn.berto.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Niklas,

I give another try but failed to reproduce the issue. Perhaps my board 
has a path different from yours.

Thanks for proposing to test the series. I've uploaded the branch here:

https://github.com/dlezcano/linux-thermal


On 24/07/2022 21:00, Niklas Söderlund wrote:
> Hi Daniel,
>
> On 2022-07-24 20:27:54 +0200, Daniel Lezcano wrote:
>> Hi Niklas,
>>
>> I tried to reproduce the issue but without success.
>>
>> What sensor are you using ?
> I was using rcar_gen3_thermal.
>
> I did my tests starting on v5.19-rc7 and then picked '[PATCH v5 00/12]
> thermal OF rework' from [1] and finally applied this full series on-top
> of that. If you have a branch or some specific test you wish me to try
> I'm happy to so.
>
> 1. https://lore.kernel.org/lkml/20220710123512.1714714-1-daniel.lezcano@linexp.org/
>
>>
>> On 19/07/2022 11:10, Niklas Söderlund wrote:
>>> Hi Daniel,
>>>
>>> Thanks for your work.
>>>
>>> On 2022-07-10 23:24:07 +0200, Daniel Lezcano wrote:
>>>> The thermal OF code has a new API allowing to migrate the OF
>>>> initialization to a simpler approach.
>>>>
>>>> Use this new API.
>>> I tested this together with the series it depends on and while
>>> temperature monitoring seems to work fine it breaks the emul_temp
>>> interface (/sys/class/thermal/thermal_zone2/emul_temp).
>>>
>>> Before this change I can write a temperature to this file and have it
>>> trigger actions, in my test-case changing the cooling state, which I
>>> observe in /sys/class/thermal/cooling_device0/cur_state.
>>>
>>> Likewise before this change I could trip the critical trip-point that
>>> would power off the board using the emul_temp interface, this too no
>>> longer works,
>>>
>>>       echo 120000 > /sys/class/thermal/thermal_zone2/emul_temp
>>>
>>> Is this an intention change of the new API?
>>
>>
>>

