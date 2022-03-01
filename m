Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9D44C8DCD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiCAOdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiCAOd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:33:29 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E45947059;
        Tue,  1 Mar 2022 06:32:47 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c192so7624058wma.4;
        Tue, 01 Mar 2022 06:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bohhSrnhcAfyQzGT/yWV46WEIYl6Z5VuMJ8D4YNqZ5E=;
        b=QMHGivAqcKpz8T2VTa4RZTNuyV7KU6HOyUeE2s9LjSzItM9akdENp4bf3105Mknf/W
         RrOLkxBdrcphtj+PFAZvIe/htW4vxHqhiWt/UHEeOZWRz8wEe8tcLF1vT+VxbjISfeGh
         psWmV0mbIw3x08irfjp+0FfX4km2GDwzxWxjM5nQZGAgWK6XXu2g/1xltVpoP9ySm+ZL
         07Sf975wKKs7cycl7GdQ7TporQLEW3JQ0ssPPQwUe9Jzme68fdwpg21sr1uN+BTHAw0X
         N2Y6LyjPfls543KO0ees+l3DS1Dbh9NiGKw+5mOZC7KvnlDfw0AXCxbo4syC8Dd+KZ19
         XIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bohhSrnhcAfyQzGT/yWV46WEIYl6Z5VuMJ8D4YNqZ5E=;
        b=yICr+ACtuH2Eozsv484LrvCmQYunZHWOijx0XCn4HwEuj/ylG+NYxPwdK4U76teeOl
         nTBI5icJVY4i1FOIVlir1ESxrpIZBBwTtTd+6R7mQkVMJ/SjA+NFfY1e8Z+NEg3zB66N
         KLVm1qWwoZ2hmKhK0a9+uDs9fvtuNt0AWxoX8puT2tCDg7I6CnnM2MBCG06+7nRD77wR
         GPhbQgVg3WhLee9Odr5yqWxXw5Z1aupajfMUcYvq2EjiDj3tOi5wjwF7IsWGAuXpuyRZ
         karOwXpF4vFBcJPB5d3h73b9Aa2MuAoK0X2kbXxUBmtjZtHGh+JOTv15NJGlJus8nfsz
         bqKg==
X-Gm-Message-State: AOAM531Ka3H4yG7HsTN1JHSFCJicn/8nZ+6x8lLW4xPeg+PHOuA+woMw
        8TOMU6wG2DXDN7lL10LaqrejHp2Fg8A=
X-Google-Smtp-Source: ABdhPJxuvPUZqW89og/pYmTf8T5VJbP1z0uumjHagrIaJ7Mn2PhHGVeo6b7PcIIMPY8dtoLlmGmJUg==
X-Received: by 2002:a1c:740c:0:b0:381:4821:7bfc with SMTP id p12-20020a1c740c000000b0038148217bfcmr12471585wmc.101.1646145165927;
        Tue, 01 Mar 2022 06:32:45 -0800 (PST)
Received: from [192.168.0.118] (88-113-28-27.elisa-laajakaista.fi. [88.113.28.27])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d56c6000000b001edb64e69cdsm13863905wrw.15.2022.03.01.06.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 06:32:45 -0800 (PST)
Message-ID: <56454560-5f62-05b9-1a24-3f51a305140e@gmail.com>
Date:   Tue, 1 Mar 2022 16:32:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH for-5.18/uclogic 0/9] DIGImend patches, part II
Content-Language: en-US
To:     Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220219100157.41920-1-jose.exposito89@gmail.com>
 <nycvar.YFH.7.76.2203011529020.11721@cbobk.fhfr.pm>
From:   Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <nycvar.YFH.7.76.2203011529020.11721@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/22 16:29, Jiri Kosina wrote:
> On Sat, 19 Feb 2022, José Expósito wrote:
> 
>> Hi everyone,
>>
>> This series is a follow up to [1], kindly reviewed and applied
>> by Jiří in hid.git#for-5.18/uclogic.
>>
>> It might look a little bit longer than desired, but most of the
>> patches are code simplification and refactoring in preparation
>> for the last patch which adds support for multiple frame input
>> devices.
>>
>> Thank you very much in advance to maintainers for reviewing it,
>> José Expósito
>>
>> [1] https://lore.kernel.org/linux-input/nycvar.YFH.7.76.2202161642180.11721@cbobk.fhfr.pm/T/
>>
>> Nikolai Kondrashov (9):
>>    HID: uclogic: Remove pen usage masking
>>    HID: uclogic: Replace pen_frame_flag with subreport_list
>>    HID: uclogic: Switch to matching subreport bytes
>>    HID: uclogic: Specify total report size to buttonpad macro
>>    HID: uclogic: Use different constants for frame report IDs
>>    HID: uclogic: Use "frame" instead of "buttonpad"
>>    HID: uclogic: Put version first in rdesc namespace
>>    HID: uclogic: Define report IDs before their descriptors
>>    HID: uclogic: Support multiple frame input devices
>>
>>   drivers/hid/hid-uclogic-core.c   |  79 +++++++------
>>   drivers/hid/hid-uclogic-params.c | 195 ++++++++++++++-----------------
>>   drivers/hid/hid-uclogic-params.h |  86 +++++++-------
>>   drivers/hid/hid-uclogic-rdesc.c  |  53 ++++-----
>>   drivers/hid/hid-uclogic-rdesc.h  |  38 +++---
>>   5 files changed, 221 insertions(+), 230 deletions(-)
> 
> Now queued in hid.git#for-5.18/uclogic.

Thank you for your work, José, and for your reviews Jiri!

Nick
