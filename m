Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0EA58D3B3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbiHIGYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbiHIGX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:23:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B64E1FCF2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 23:23:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n4so11423624wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 23:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=yotL3mJO3oRsefgOEKukS5n6DJlaFZd6MhQAm/UDvHI=;
        b=KfIvNwN1ilmfDmcBQzIhYyet0Uijw7QbGc5oSzdw7FKaISqdHq0PezMGxDwailSxcy
         ifLwaq/47CWb49or0IwCpEYI4a3t5xNH6SdapIrNcdxCgOK2wNiPvCo7AK/Q9/yNmyNV
         ixdhbXCVFPqlcngxLTVlPZpWH8O0LHUKrhp6wkIpk/6M0NVMdw09g+v6yxzCHWW4Pbwj
         Sn61PJ+nWdWGJ8lkrBDW0XX9hla5F2Qqm/fGD3VkErYWvl1Om0HQxD4NeS/z5B/9zVWX
         WQHCEsgmipHfk78SNm3SuM51Z25rdoSegfOdwyIiKBtuAVtOBbOt0uklhvol/4iF5JFx
         KbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=yotL3mJO3oRsefgOEKukS5n6DJlaFZd6MhQAm/UDvHI=;
        b=5OJ9xYu30wFQMAp5P1FEp0NND0OaO2MA/FnAtROy1pzv7eH8grkV4pHrit+CJqevKo
         CbUFhCyX+ayNx5gVwYdBls3YkWptFtA13JBR7PmvmvCsDFmgYrdd2P+IZaQ16mQEsrt0
         LY6lO6iKn2CAb9eb6LAGZP3UrdtuE0vIGcmCydg8JSs2lU4e08FIGXQ1zcGJJ4Vwu6WL
         TQxqIk2ZwL8cUjo8PeJBhDue4Ai3Si4LOYU660M4kAO8IsxydLjmR4FJepCwZwDVSOkQ
         P9oWnC6QewjFWEmL40Dv25WvDAr7SOGcCpsRCxGgpZG0OX67vT9vxo30R7ckTw8f9g35
         htPg==
X-Gm-Message-State: ACgBeo1A+LFbuDrWyQ9rJ91lijIhdi8IY6UhMWyQ2sn1eWxjSV28Zem0
        SlhyImAbH3YTBxsmnm9QOXIYUA==
X-Google-Smtp-Source: AA6agR5DlKMWvaY6PzdTHOrY+X1rfox5Qx6YPUaBb7mCDuQBwvAjha0SF9PponGLroBeylMwXOwpGQ==
X-Received: by 2002:a5d:6da6:0:b0:220:78fd:eedb with SMTP id u6-20020a5d6da6000000b0022078fdeedbmr12899656wrs.580.1660026236131;
        Mon, 08 Aug 2022 23:23:56 -0700 (PDT)
Received: from [192.168.1.69] (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id b4-20020adff904000000b0021e9fafa601sm12641999wrr.22.2022.08.08.23.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 23:23:55 -0700 (PDT)
Message-ID: <ee85e515-1265-22d7-109f-5cef94571d76@baylibre.com>
Date:   Tue, 9 Aug 2022 08:23:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v3 2/2] iio: time: capture-tiecap: capture driver support
 for ECAP
Content-Language: en-US
From:   Julien Panis <jpanis@baylibre.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mranostay@ti.com
References: <20220728175124.468461-1-jpanis@baylibre.com>
 <20220728175124.468461-3-jpanis@baylibre.com>
 <20220731164116.30e91f34@jic23-huawei>
 <11b7436b-5c31-671e-ba77-435fe8e3b767@baylibre.com>
 <98d17617-72b5-6330-d4f5-1bece928ceab@baylibre.com> <YvBZQsiAm6f3yxME@fedora>
 <d47c842b-579d-b119-73f9-e8c95984b30b@baylibre.com> <YvE3m+jLPuLvXXdS@fedora>
 <733242ec-2f17-e843-5e36-2f804c040a9d@baylibre.com>
In-Reply-To: <733242ec-2f17-e843-5e36-2f804c040a9d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/08/2022 08:19, Julien Panis wrote:
>
>
> On 08/08/2022 18:19, William Breathitt Gray wrote:
>> The Counter subsystem is relatively nascent so the number of existing
>> Counter device drivers to study is unfortunately sparse. If you
>> encounter any trouble along the way as you work on this, please don't
>> hestitate to reach out and I'll be happy to answer any questions you may
>> have. That said, here are some more hints that can help guide you. :-)
>>
>> Although we've been using CAPx to refer to these registers, in the
>> context of sysfs it'll be better to call the attributes "capture1",
>> "capture2", etc.; that will make their use as capture buffers more
>> obvious. Furthermore, despite my previous example, I think it's better
>> to have these exist underneath the CTR hierarchy rather than Mod4
>> because they are captures of the CTR value:
>>
>> * CTR: /sys/bus/counter/devices/counterX/count0/count
>> * CAP1: /sys/bus/counter/devices/counterX/count0/capture1
>> * CAP2: /sys/bus/counter/devices/counterX/count0/capture2
>> * CAP3: /sys/bus/counter/devices/counterX/count0/capture3
>> * CAP4: /sys/bus/counter/devices/counterX/count0/capture4
>>
>> In your device driver, you would define a struct counter_count to
>> represent CTR. In this struct counter_count there is an "ext" member
>> where you provide an array of struct count_comp. Each CAPx will have a
>> corresponding struct count_comp; it'll look something like this::
>>
>>          static struct counter_comp ctr_count_ext[] = {
>>                  COUNTER_COMP_COUNT_U64("capture1", cap1_read, NULL),
>>                  COUNTER_COMP_COUNT_U64("capture2", cap2_read, NULL),
>>                  COUNTER_COMP_COUNT_U64("capture3", cap3_read, NULL),
>>                  COUNTER_COMP_COUNT_U64("capture4", cap4_read, NULL),
>>          };
>>
>> As you already know, counter_push_event() lets you push Counter events
>> in your interrupt handler. I recommend introducing a new event type
>> under enum counter_event_type in the include/uapi/linux/counter.h header
>> file; something like COUNTER_EVENT_CAPTURE should be descriptive enough.
>>
>> The "channel" member of struct counter_watch refers to Counter event
>> channels; The purpose here is to allow us to support concurrent events
>> of the same type (e.g. two COUNTER_EVENT_OVERFLOW but for different
>> Counts). If I understand the TI ECAP device correctly, we'll be getting
>> a COUNTER_EVENT_CAPTURE event whenever a CAPx register is updated with a
>> new capture. It's up to you if you want to group them under the same
>> channel or separate channels for each CAPx; you would just pass the
>> channel in counter_push_event() to indicate which COUNTER_EVENT_CAPTURE
>> event is being handled.
>
> 2 options, indeed :
> 1) By grouping them under the same channel, the only thing I'm not a 
> great fan of is that
> I will need to use separate functions to read capture registers 
> (cap1_read/cap2_read/
> cap3_read/cap4_read), and also to set/get polarity.
> 2) By using separate channels, code will look more simple but it is 
> likely to be a little bit
> confusing for the user.
> I will probably use option 2.

[ERRATUM] : Sorry, I meant that I will probably use option 1 (not 2), to 
avoid confusion for the user.
