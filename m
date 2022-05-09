Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E1E520843
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiEIXTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiEIXTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:19:21 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA822A376E;
        Mon,  9 May 2022 16:15:26 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id h10-20020a056830400a00b00605e92cc450so11101392ots.11;
        Mon, 09 May 2022 16:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VlZ9NTH9fu3pqFxNk7Bf2+YqFMFkydcVnpc8dIcGFDU=;
        b=qpnvEl5DDPtXKM46kOOYT+iy4jUlZB2OjwIqmVKmKNc52UUNSD8Re60PO0xfNzQEPb
         klsKfDgW50906FYzAKCp7qATDSnX4FOoiypqqdbwpcueXh4PgKHWCbITsw592hVwcTsM
         k52+V3tLQDaIeGAq5Hd4RfUU9PsqSwsisWfC7D0S/r6muIrDMogE4CzboArhZqbIXXUP
         sRsdfD9cnIbwIT44YplLs3j1fNuzAkXhMSH69U6nettgglvda98PbtzEUXURbJT7OMbn
         hYH/pF1BwpPEM8AiDOTSyJjXkfj7LkG4jX+1ffGRxSVZLNKrlVjujYwzGpXyvpvzZ2it
         LEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VlZ9NTH9fu3pqFxNk7Bf2+YqFMFkydcVnpc8dIcGFDU=;
        b=UpjhMjn7Y/d511JKurkSI38Fm/cfcUi+6JLPFn777Z4Djv2qIobNmG6zEWCIqgo7Fe
         TNUCr8fCJ28UtyF1sq7BuzlHajB0oJaS7032Cqibnehn0M+LbWPTsEosJdzNVRRy30Nw
         eqybCtY92x1VBpuefW79Y/MrNkhYHQMC0ld5jhBBMWK4h5e59rjGao14Lh4NV+Dws2wr
         3zgEnskqoID17Ou7rwe2AKjJSeKJzDGseT2oFLVnvSRmXDh6ibINfvJD7H+Ia1CuMucr
         u0LWz/dxQOyi+UJmvK9u5c2MQVvDuMZL99HfEW4T1z2C9XwuIsojC2O/sOotQ3AEc0T8
         JEAw==
X-Gm-Message-State: AOAM533sxysqlwsRUl391aql9JhArPA3SbNnpMx7ifXReMYRUoW46QUO
        KJosND7PskxFKSbxEAv6mus=
X-Google-Smtp-Source: ABdhPJyCWQNSswuT2wag/aifPUNjcw6imCiwDC+bS5fSMyomniLnx7g42y3+PP0gFkYoEfR/5+pttA==
X-Received: by 2002:a05:6830:911:b0:606:36b4:69b3 with SMTP id v17-20020a056830091100b0060636b469b3mr6653039ott.176.1652138125448;
        Mon, 09 May 2022 16:15:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g126-20020aca3984000000b0032643374d17sm4893619oia.41.2022.05.09.16.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 16:15:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8a48ba53-7182-10fa-72cd-fbcee0e4369a@roeck-us.net>
Date:   Mon, 9 May 2022 16:15:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] Watchdog: sp5100_tco: Lower verbosity of disabled
 watchdog hardware
Content-Language: en-US
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     "ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>
References: <20220509163304.86-1-mario.limonciello@amd.com>
 <b394bfcf-9f0d-b27c-5bc0-3d628de98755@roeck-us.net>
 <BL1PR12MB51578AC7D4CCBFBCD1DF19E4E2C69@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <BL1PR12MB51578AC7D4CCBFBCD1DF19E4E2C69@BL1PR12MB5157.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/22 16:10, Limonciello, Mario wrote:
> [Public]
> 
> 
> 
>> -----Original Message-----
>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
>> Sent: Monday, May 9, 2022 17:56
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Wim Van Sebroeck
>> <wim@linux-watchdog.org>; open list:WATCHDOG DEVICE DRIVERS <linux-
>> watchdog@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
>> Cc: ionut_n2001@yahoo.com
>> Subject: Re: [PATCH] Watchdog: sp5100_tco: Lower verbosity of disabled
>> watchdog hardware
>>
>> On 5/9/22 09:33, Mario Limonciello wrote:
>>> If watchdog hardware has been disabled, currently the kernel driver
>>> will show at err level during probe:
>>>
>>> "Watchdog hardware is disabled"
>>>
>>> This is unnecessarily verbose as there is already a -ENODEV returned.
>>> Lower the level to debug.
>>
>> Is it ? Without this message, a user may try to load the driver,
>> get an error message, and have no idea why the driver was not
>> enabled even though the hardware exists. If anything , -ENODEV
>> is less than perfect. Unfortunately there does not seem to be
>> a better error code, or at least I don't see one.
> 
> If it didn't have modaliases and users only manually loaded it; I would agree
> with you.  However it has MODULE_DEVICE_TABLE, so if that PCI device is around
> then the driver will load either way.  That would translate into an "error message"
> on every boot if you have this module compiled and didn't manually try to load it.
> 

Why don't you just blacklist the driver ?

Guenter
