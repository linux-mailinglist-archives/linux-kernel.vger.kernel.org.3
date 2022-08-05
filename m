Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C7558AE3F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbiHEQh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiHEQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:37:25 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA42917AA6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:37:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id p10so3813814wru.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Jfp/EtpEG6qo6OMuAe522j8e+zV5R8oPt8iblzqNd7c=;
        b=y2imUW//ZeRpPSmlTXLHDXgNAORsIqksqVSBuH+RhwuIlSjr1Kla2tBW4afOpEEoZk
         PIOA5q/PfeQWfgZXvwEh27bVxYwZTFghX9DLkBUe+IL/ipypUrAAzfjhIodqlyKTrNQz
         BKDOFUxEHPDYtdNYcVBXWDSc4A88Mutrb79Kmo6GkE6UzQEjctQMcogwUeyNYEnbro7c
         cyfSlj+G4z9+nMcVjenpoIjqFMIJyxa0jbaPrjoyujN7fewi7pFnwG+neoMDppor3TTw
         JebM1SKhf9kcWZRI9WfrVG5UWyUejEqwN26wDBBghgRuBwi40R8U8YVqSyvWj7FTVfBL
         bR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Jfp/EtpEG6qo6OMuAe522j8e+zV5R8oPt8iblzqNd7c=;
        b=hhhlAzs3cQDg8N0G8XYmYbwyNWE6lT5350UyEleeqRPu/ZpalepuqhVUysOhH512Wx
         rd/4lJy82h0StyKzbSW4J9/sIVhj4tMYaqz6iz490qlhGR5WwgLr+voy/UbVRFJHYPJo
         /0rqHrg0lXX1e806xRaQUWPYv8FZ+sV2TR4smLrJadms3EXmR48VxRhPc4wsXCswIVS8
         EL8EkXUAA7kSa5lpTAY8D1WKsnyNeqDJ1qcA3P6EsVXmUEucz4rx/ghF0YhUhIIiUAnI
         J7ONXfCc39yB22uo+JSAVq8RDZ5M05v8dJ12wWRamrijfSaKxUTF9dmy7rUOL3d3Vcaa
         d6bg==
X-Gm-Message-State: ACgBeo1wCYF+5CamIQZx+wSz21I36TDxJ5toHMBZtWpmqDYeu8eNYleO
        0VL9aHIEA8AAXlgTxLhENLcG2Q==
X-Google-Smtp-Source: AA6agR5L3BarDWIfJaXyZ+9r08uJ94DcLrt53xqiX23qwNDpiHhqcfaOj2HIAkloYYbR2z0UMOoXMw==
X-Received: by 2002:a5d:5848:0:b0:221:6d80:ced8 with SMTP id i8-20020a5d5848000000b002216d80ced8mr2405988wrf.705.1659717442338;
        Fri, 05 Aug 2022 09:37:22 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:aef0:8606:da6b:79ef? ([2a05:6e02:1041:c10:aef0:8606:da6b:79ef])
        by smtp.googlemail.com with ESMTPSA id j42-20020a05600c1c2a00b003a30c3d0c9csm10528223wms.8.2022.08.05.09.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 09:37:22 -0700 (PDT)
Message-ID: <c2f6c89b-a96d-ba13-5e85-c1a84eaec678@linaro.org>
Date:   Fri, 5 Aug 2022 18:37:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/5] thermal/core: Rearm the monitoring only one time
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>
References: <20220805153834.2510142-1-daniel.lezcano@linaro.org>
 <CAJZ5v0jVp+AW06MqgOmQV=AmGtb7VdY_FYSxC6wT2BZw9uzxnQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jVp+AW06MqgOmQV=AmGtb7VdY_FYSxC6wT2BZw9uzxnQ@mail.gmail.com>
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


Hi Rafael,

On 05/08/2022 18:29, Rafael J. Wysocki wrote:
> On Fri, Aug 5, 2022 at 5:38 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> The current code calls monitor_thermal_zone() inside the
>> handle_thermal_trip() function. But this one is called in a loop for
>> each trip point which means the monitoring is rearmed several times
>> for nothing (assuming there could be several passive and active trip
>> points).
>>
>> Move the monitor_thermal_zone() function out of the
>> handle_thermal_trip() function and after the thermal trip loop, so the
>> timer will be disabled or rearmed one time.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Does this series depend on any other? >
> You've been sending quite a lot of material lately and it is not
> always easy to tell what the dependencies between the different patch
> series are.

Yes I understand.

This series does not depend on any other. It is not related to any 
pending changes.

It may have trivial conflicts with the other 26 patches series but it 
would be the case for any submissions posted by someone else anyway.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
