Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3596D54CDD9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345699AbiFOQKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiFOQKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:10:06 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DB82A94D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:10:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f65so11783943pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AGXMHAfFawM437d2xbjGn7zTyG/qjpog4xd0dnEFlIg=;
        b=ELrb+58SZ4RRVFmeo0lDvjv47zdVsU/ClHMLv/kcFL6JKL1jmU5MyxdZo1v4F/v9eg
         p7AwNo6AI3Jfw2SwocMTwDKwmv/uZdMWd3L7M5U33KE+oV3m6miN2VRo47xJu8Wksotg
         iaRVBcFo0fAQnc4uCw991KIutWaLFTf8NI7Gb2mw0YjxTBzX7Yoq+BCcq6KzXV0P9Rl7
         08PYQCKQPBh7XJ3uzczwxcOMXoV5VPWqu+eGdN5j4hFFbEYu0rD0FaPqdxuyE+46uZEH
         qktVnHR2FRtu+R6lBp45UeaS61eyTPve40fOf9rRnj6UGCL9zbH9MSny2cm8esGENkkc
         AZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AGXMHAfFawM437d2xbjGn7zTyG/qjpog4xd0dnEFlIg=;
        b=6mrikdleDcFR1GxwKUaFpxx85RjuXAIpN3eL9dFJ/sVeXqvAzr+lpwRMS12sIJL7Wq
         BQCioLW0Ickbh7UJXJPxQDatZfAHTnDjXHQ10vPmcKlquQILR9DiVWBINmKUQEZH1iUN
         LE4oqObkTKVXXYsEQkYobM9lSOCvwpaJ8dOL89yArV3GcZKhEkTGqqXnLsH0BIicSOHa
         g+gw7DAFGL+ESHrlftitPwhscTiuwDhmOXDiWwqHxWjYAmW1rwUHxUB4y+8OLZ6xCStq
         tsvoyc2NwCI/11zM7aCTmlCUOv4snsPLPMjsgs4sLwnLnZFL3MUvgq54/+FNEMnp4kmo
         ZsdQ==
X-Gm-Message-State: AJIora/DsIfdoy6WVuCj2A8OPV0HTjx8MtDZZvMb+zDrMqDy0krk2CVs
        Anb6qbqxHLvlez4q8Wuu3sw=
X-Google-Smtp-Source: AGRyM1thv/7xzTABPs1GV756Nc/sGCMV361AeTQGj6liZHtwY/h4Qq0gg/prvco/LEv2/FoQc+iqzw==
X-Received: by 2002:a63:c5:0:b0:3fe:26a0:7abe with SMTP id 188-20020a6300c5000000b003fe26a07abemr505846pga.152.1655309405114;
        Wed, 15 Jun 2022 09:10:05 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k6-20020a17090a910600b001e31c7aad6fsm1966924pjo.20.2022.06.15.09.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 09:10:04 -0700 (PDT)
Message-ID: <c787dfe6-9639-8797-d07a-048c5ec69ddf@gmail.com>
Date:   Wed, 15 Jun 2022 09:10:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 11/22] firmware: arm_scmi: Add SCMIv3.1 extended names
 protocols support
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-12-cristian.marussi@arm.com>
 <6f865d7f-fde8-d923-3c7e-d12bfbc370a6@gmail.com>
 <YqmVsMGgxKuIT5rx@e120937-lin> <Yqmo/BiIR4gku0Y+@e120937-lin>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Yqmo/BiIR4gku0Y+@e120937-lin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 02:40, Cristian Marussi wrote:
> On Wed, Jun 15, 2022 at 09:18:03AM +0100, Cristian Marussi wrote:
>> On Wed, Jun 15, 2022 at 05:45:11AM +0200, Florian Fainelli wrote:
>>>
>>>
>>> On 3/30/2022 5:05 PM, Cristian Marussi wrote:
>>>> Using the common protocol helper implementation add support for all new
>>>> SCMIv3.1 extended names commands related to all protocols with the
>>>> exception of SENSOR_AXIS_GET_NAME.
>>>>
>>>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>>>
>>> This causes the following splat on a platform where regulators fail to
>>> initialize:
>>>
>>
>> Hi Florian,
>>
>> thanks for the report.
>>
>> It seems a memory error while allocating so it was not meant to be
>> solved by the fixes, anyway, I've never seen this splat in my testing
>> and at first sight I cannot see anything wrong in the devm_k* calls
>> inside scmi_voltage_protocol_init...is there any particular config in
>> your setup ?
>>
>> Moreover, the WARNING line 5402 seems to match v5.19-rc1 and it has
>> slightly changed with -rc-1, so I'll try rebasing on that at first and
>> see if I can reproduce the issue locally.
>>
> 
> I just re-tested the series rebased on v519-rc1 plus fixes and I cannot
> reproduce in my setup with a few (~9) good and bad voltage domains.
> 
> How many voltage domains are advertised by the platform in your setup ?

There are 11 voltage regulators on this platform, and of course, now 
that I am trying to reproduce the splat I reported I just cannot 
anymore... I will let you know if there is anything that needs to be 
done. Thanks for being responsive as usual!
-- 
Florian
