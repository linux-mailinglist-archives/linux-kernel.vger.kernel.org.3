Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951644C37F7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 22:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiBXVmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 16:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiBXVme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 16:42:34 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB469284C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 13:42:02 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m13-20020a7bca4d000000b00380e379bae2so590334wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 13:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=95Kz0cwVSt+7Sf+leRu54DcFn27kGIFwxoRMYQn155s=;
        b=TskHSrRSAClsNWy/osGrf9N8tZVPsIzNFG9FImu4CzS4z3KvxPS29pJPJLpn3U6DKR
         0WenYNPjdQ10OhM7+V32+DzPQF0baUVU5I3KLmLHW4XQduOhPlUXNN5uUPm7Iw3NkwZa
         rPRjXbAZLAKfeGSEN7JyE9WuuBFndwMTuGKMsYG3+SAXdIB2X7+KPvi3g4gfd/TOnWUp
         tWFUg7NZxwDhLODrxmwJEU3yQAzEbAmt3u7SImKjOi7N2gQOrYkw/kycHthrFf3xvcZB
         ca6p4icjbFsgaYp7HbIuecKR43Zk5CDKnIEvwMw6gc710P9i2/HrAEjfZ1wzy5K+9OcG
         zlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=95Kz0cwVSt+7Sf+leRu54DcFn27kGIFwxoRMYQn155s=;
        b=H10PT7YR2Q/MyxKuLgTFMBk9z7O90PSCtDg3MBm9PvOFG70IRVbos54dVDeJca99qg
         q185WWgNPhaCMRIIMOHIbdL/fgEezgTe5RrHQ7nNfd3CF607J3jDYWX1xmodcsTw7hIf
         hK6vR/KfTHH3Pra/PZ1JeFcWxhDg0r4Zsib/5GYmsfSjdhdRdYl77uEQTROswlwlZ3N4
         9+7LAKNs4iT/kuWZd/D5DDPVs4oY2p6b5lZw30VzhX6CWEIpLRnGZNnFvZiDDcpHqs0v
         4KSWr6YIWtEKo+Ey3h8Epq8kgoK63OyPEz+w+QYjHZ+/7vCJV0xQxPgWULA36nMf7Ryb
         5f0w==
X-Gm-Message-State: AOAM530usVyjUdqpJ7CJifesf6nk/+inwAMAh/mnF6SBWZhTuPM/g9V3
        INEavaEgStrDKXNujbRbuJ+8Rg==
X-Google-Smtp-Source: ABdhPJzsPdzdtG7H4jdgtnMyqQAl+jFoO1hKVjMQWOPd72cuoPkq+qQuiiZ2JyZtx/Fu0jNoO7q2sw==
X-Received: by 2002:a7b:cc0d:0:b0:381:220e:a3a0 with SMTP id f13-20020a7bcc0d000000b00381220ea3a0mr54970wmh.59.1645738921363;
        Thu, 24 Feb 2022 13:42:01 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:25a:d4d2:9383:c638? ([2a01:e34:ed2f:f020:25a:d4d2:9383:c638])
        by smtp.googlemail.com with ESMTPSA id v20-20020a7bcb54000000b0037fa63db8aasm3786678wmj.5.2022.02.24.13.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 13:42:00 -0800 (PST)
Message-ID: <3a3320d1-c4a8-d5e0-63ef-dd098711f38e@linaro.org>
Date:   Thu, 24 Feb 2022 22:41:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 0/4] Thermal library and tools
Content-Language: en-US
To:     rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220218125334.995447-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220218125334.995447-1-daniel.lezcano@linaro.org>
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


Hi,

What shall I do with this series? Is everyone ok with it?



On 18/02/2022 13:53, Daniel Lezcano wrote:
> This series provides a thermal library providing the basic callback oriented
> netlink communication and events with the thermal framework, a temperature
> capture tool and a thermal monitoring skeleton using the thermal library.
> 
> Changelog:
>   - V1:
>      - Took into account RFC comments (unsubscribe, error enum, thermal daemon
>        renamed to thermal-engine)
> 
> Daniel Lezcano (4):
>    tools/lib/thermal: Add a thermal library
>    tools/thermal: Add util library
>    tools/thermal: A temperature capture tool
>    tools/thermal: Add thermal daemon skeleton
> 
>   tools/Makefile                                |  36 +-
>   tools/lib/thermal/.gitignore                  |   2 +
>   tools/lib/thermal/Build                       |   5 +
>   tools/lib/thermal/Makefile                    | 165 ++++++++
>   tools/lib/thermal/commands.c                  | 351 ++++++++++++++++
>   tools/lib/thermal/events.c                    | 164 ++++++++
>   tools/lib/thermal/include/thermal.h           | 141 +++++++
>   tools/lib/thermal/libthermal.map              |  25 ++
>   tools/lib/thermal/libthermal.pc.template      |  12 +
>   tools/lib/thermal/sampling.c                  |  75 ++++
>   tools/lib/thermal/thermal.c                   | 126 ++++++
>   tools/lib/thermal/thermal_nl.c                | 215 ++++++++++
>   tools/lib/thermal/thermal_nl.h                |  46 ++
>   tools/thermal/lib/Build                       |   3 +
>   tools/thermal/lib/Makefile                    | 158 +++++++
>   .../thermal/lib/libthermal_tools.pc.template  |  12 +
>   tools/thermal/lib/log.c                       |  77 ++++
>   tools/thermal/lib/log.h                       |  31 ++
>   tools/thermal/lib/mainloop.c                  | 135 ++++++
>   tools/thermal/lib/mainloop.h                  |  14 +
>   tools/thermal/lib/thermal-tools.h             |  10 +
>   tools/thermal/lib/uptimeofday.c               |  40 ++
>   tools/thermal/lib/uptimeofday.h               |  12 +
>   tools/thermal/thermal-engine/Build            |   2 +
>   tools/thermal/thermal-engine/Makefile         |  27 ++
>   tools/thermal/thermal-engine/thermal-engine.c | 287 +++++++++++++
>   tools/thermal/thermometer/Build               |   2 +
>   tools/thermal/thermometer/Makefile            |  23 +
>   tools/thermal/thermometer/thermometer.c       | 393 ++++++++++++++++++
>   tools/thermal/thermometer/thermometer.conf    |   5 +
>   30 files changed, 2591 insertions(+), 3 deletions(-)
>   create mode 100644 tools/lib/thermal/.gitignore
>   create mode 100644 tools/lib/thermal/Build
>   create mode 100644 tools/lib/thermal/Makefile
>   create mode 100644 tools/lib/thermal/commands.c
>   create mode 100644 tools/lib/thermal/events.c
>   create mode 100644 tools/lib/thermal/include/thermal.h
>   create mode 100644 tools/lib/thermal/libthermal.map
>   create mode 100644 tools/lib/thermal/libthermal.pc.template
>   create mode 100644 tools/lib/thermal/sampling.c
>   create mode 100644 tools/lib/thermal/thermal.c
>   create mode 100644 tools/lib/thermal/thermal_nl.c
>   create mode 100644 tools/lib/thermal/thermal_nl.h
>   create mode 100644 tools/thermal/lib/Build
>   create mode 100644 tools/thermal/lib/Makefile
>   create mode 100644 tools/thermal/lib/libthermal_tools.pc.template
>   create mode 100644 tools/thermal/lib/log.c
>   create mode 100644 tools/thermal/lib/log.h
>   create mode 100644 tools/thermal/lib/mainloop.c
>   create mode 100644 tools/thermal/lib/mainloop.h
>   create mode 100644 tools/thermal/lib/thermal-tools.h
>   create mode 100644 tools/thermal/lib/uptimeofday.c
>   create mode 100644 tools/thermal/lib/uptimeofday.h
>   create mode 100644 tools/thermal/thermal-engine/Build
>   create mode 100644 tools/thermal/thermal-engine/Makefile
>   create mode 100644 tools/thermal/thermal-engine/thermal-engine.c
>   create mode 100644 tools/thermal/thermometer/Build
>   create mode 100644 tools/thermal/thermometer/Makefile
>   create mode 100644 tools/thermal/thermometer/thermometer.c
>   create mode 100644 tools/thermal/thermometer/thermometer.conf
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
