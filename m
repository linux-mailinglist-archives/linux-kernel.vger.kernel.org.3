Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF7A53B53C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiFBIh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiFBIhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:37:51 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D169328ABD4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:37:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h5so5542073wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Hp+R/VJrSoEU+L/wnPS/A0usIlnisMrgdN/kDMl/bds=;
        b=z5Kdxd32pOpnhChbIGmyWofqKjyFz/8nEDvtVgzi/MGrrOyWLMMSZwq1BZZqtHeG2v
         JYr7P4NlHerB12T0gld4mrxHYu66YeR5w69AOJp9Ycr0QJkf/H5oi1pcsi8a7LJ2A5TP
         Fe6XKqCJ67Rv/0e54C4O+BAAvnszDmThVIQfrVAYqFibqIZM+z+gmP0BVx2WOEwu9eRM
         WM5TxdxC0+icvSf+6n5kwWOeAWLXt3bBaAEYyQ3198FDVR/TpRiTfG1zVBH4KNGgFoYg
         Yy/Uz5oCsWff2pfyeDijU+IdJ7jXUbtE0ACf3Q6OTES2/9qRDidLcqbf5uZJxt+BCz0S
         +7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hp+R/VJrSoEU+L/wnPS/A0usIlnisMrgdN/kDMl/bds=;
        b=PE8jPmQHjeG2Xtf8ggsR/jI+xkVGXl7230O504qVbPX4QGBjECt3tsG2R3h8MsRks/
         WSm0EShQokH9F4EZ0mz7k6dPDrCZMk819x1AEGagEuMpepJXi/2ubgLVvd5rd6srZewQ
         E9rYDRWi3kPVuQRLIoyVmRwlQZblwPoSmn0hkb1DB7WVB1Izj0WnjjWt1MpuF1BHPZJX
         2uVZzlVBKgdGW1uFZFN2qzR6W/tbM7eK1Y8Wo1JjQ9QScMTZ7XTrcu+STk3ranUI8mZ7
         DRc9/Dqf3CsMmbG/CFHE13f73olqY/OV4S375d/7eeDxQWLWH88s/x0s+w+RPc415wFE
         P6Mg==
X-Gm-Message-State: AOAM5331Wr4YMq0AUN1TpBeCifcQX2FiaDSM0YoyWBxotl3B/eFu6/1I
        Wv/RXJLPyBy5ytaXrobezfON7g==
X-Google-Smtp-Source: ABdhPJzvv9fvNO8dhVDCVlxNxEjpn/nLeDO4NrJ5aE+CYMAijBScDsgQsoFqZbsbvj9XyVW5Rx91HA==
X-Received: by 2002:adf:d1c4:0:b0:210:18e6:7eb8 with SMTP id b4-20020adfd1c4000000b0021018e67eb8mr2665096wrd.462.1654159069229;
        Thu, 02 Jun 2022 01:37:49 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id n6-20020a05600c4f8600b0039b006bd6d9sm9072510wmq.6.2022.06.02.01.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 01:37:48 -0700 (PDT)
Message-ID: <cb35e356-bc90-2a67-6983-1a4c3a0ea62d@linaro.org>
Date:   Thu, 2 Jun 2022 10:37:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] thermal/sysfs: Remove cooling device sysfs statistics
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, quic_manafm@quicinc.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Todd Kjos <tkjos@google.com>
References: <20220601151441.9128-1-daniel.lezcano@linaro.org>
 <20220601151441.9128-3-daniel.lezcano@linaro.org>
 <be8395e3-98d7-7a8f-7153-c491b22d4463@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <be8395e3-98d7-7a8f-7153-c491b22d4463@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lukasz,

[Adding Todd]

On 01/06/2022 17:33, Lukasz Luba wrote:
> Hi Daniel,
> 
> 
> On 6/1/22 16:14, Daniel Lezcano wrote:
>> The statistics are for debugging purpose and belong to debugfs rather
>> than sysfs. As the previous changes introduced the same statistics in
>> debugfs, those in sysfs are no longer needed and can be removed.
> 
> I just want to let you know that in current Android kernels we cannot
> even compile the kernel with CONFIG_DEBUG_FS.

Right, it makes sense. Precisely, with the sysfs stats they are always 
compiled in for the Android kernel and is a problem for low memory 
systems. While debugfs can fulfill its purpose in the developement and 
will be removed in production systems.

> I have this pain with
> Energy Model there... Some vendors might see useful info via this
> sysfs interface in bring-up of the SoC.

Well alternatively, information can be extracted from procfs in the 
device-tree description.

What prevents to add energy information in sysfs now that the energy 
model is per device ?

> I don't know if there are user-space tools tracking this
> information via sysfs. We probably should check that.
> 
> I agree that these statistics look more like debug info, rather than
> something useful for control.
> 
> Furthermore, we have trace events for the cooling state changes, which
> should be good enough for bring-up and experiments.
> 
> I don't have strong preferences here. I tend to agree to remove this
> interface if there are no user-space tools using it.

I agree userspace can also get information about the transition but the 
goal of the debugfs is also add information about thermal internals like 
average temperature at mitigation time, min and max, timings, etc ...


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
