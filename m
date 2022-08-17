Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F02A597031
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbiHQNtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbiHQNtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:49:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8A55FAF4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:49:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p12-20020a7bcc8c000000b003a5360f218fso1029700wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=7qbpEvIyfUHxThcPUBZWCycHTTxb6B7CEiL7PZR60n0=;
        b=P6ZccQqkWLpVNzgKCliKAbmISGdeFwyx7ECG11hFPzT0jYG3g5IfaEeEi1fPcvXBv4
         OX7btMcDpUTqSDBRnCVS/Nvtb23SJdQiWi3O4qX4mJmv63a7mGxItYIMWwuPf2A+wrjv
         8t61miyQk3qUKaCshpcSCxPQZUpQFraqX8bJJfj18CWySp9GPVGYLxWphDfVLAar9NSF
         /Lmw+sbzIKsM4tTSekwVHPzwTVVHUGKF1HwXwzntOpH9BHGGj/3QBlpVN3BARNk/5sez
         I0G6Iiyjrh7l0WANyWbPXJ0TE3AADaqVRSfsfYxc297WVrBn6Ck59uFdmT9+JhDcL5am
         CboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7qbpEvIyfUHxThcPUBZWCycHTTxb6B7CEiL7PZR60n0=;
        b=atfw/NESzgqPa4XSTjWO9orJ4udo4vB0gMT0oDT4cIKq9NTPgeWGdhxywF8yI1pUqe
         pY0FfmLZnOB0cpCb13mqg6XFastRxJ9l08OqNZEhH2OKk+rNZEA5HIJtR3GRSlchIgf4
         +vb/MCQDsyZbsSkcd2H1dpYvDUy6fT5fHs/aA5f4setzPr6+qrNEt/A6nvgr2LXjiAo8
         +B1gXSeivgnZfcgLFtTBcZAjRXA0+yv2/rO2PWQoYCTRf0GDaqZTI7Hgz7/weJXFul1f
         rFwPVMnmLg69jk08w5pR7buzHnZRZ9Of2KwVb1afjpTXlyTX1Kr8wFodEomfkk9bG3ho
         kAAA==
X-Gm-Message-State: ACgBeo2a29X30LmUaMC0ab7Ga4L1tnmX7KwS7cr1Tq8tCKuSayPPfRWv
        Cxx5jm2lVSzXrgIhtTelp+4bjw==
X-Google-Smtp-Source: AA6agR7v+p3ILoDG5S71+9W3OtpIyVNywAsgqRyINzwFNu61vTSLKFtQ4Jm7SHRJkIYqoDLULOijaw==
X-Received: by 2002:a05:600c:1ca5:b0:3a6:c8d:f2f9 with SMTP id k37-20020a05600c1ca500b003a60c8df2f9mr2252015wms.54.1660744140031;
        Wed, 17 Aug 2022 06:49:00 -0700 (PDT)
Received: from [192.168.1.69] (120.205.87.79.rev.sfr.net. [79.87.205.120])
        by smtp.gmail.com with ESMTPSA id p4-20020a5d4584000000b0021e4bc9edbfsm12619768wrq.112.2022.08.17.06.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 06:48:59 -0700 (PDT)
Message-ID: <7509b7fd-4eec-389e-254c-4d343dee1728@baylibre.com>
Date:   Wed, 17 Aug 2022 15:48:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v4 0/3] ECAP support on TI AM62x SoC
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     robh+dt@kernel.org, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mranostay@ti.com
References: <20220810140724.182389-1-jpanis@baylibre.com>
 <Yvk4OijjBj+Wa7fT@fedora>
Content-Language: en-US
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <Yvk4OijjBj+Wa7fT@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/08/2022 20:00, William Breathitt Gray wrote:
> On Wed, Aug 10, 2022 at 04:07:21PM +0200, Julien Panis wrote:
>> The Enhanced Capture (ECAP) module can be used to timestamp events
>> detected on signal input pin. It can be used for time measurements
>> of pulse train signals.
>>
>> ECAP module includes 4 timestamp capture registers. For all 4 sequenced
>> timestamp capture events (1->2->3->4->1->...), edge polarity (falling/rising
>> edge) can be selected.
>>
>> This driver leverages counter subsystem to :
>> - select edge polarity for all 4 capture events (event mode)
>> - log timestamps for each capture event
>> Event polarity, and CAP1/2/3/4 timestamps give all the information
>> about the input pulse train. Further information can easily be computed :
>> period and/or duty cycle if frequency is constant, elapsed time between
>> pulses, etc...
>>
>> Modifications since v3:
>> 	- Migrate driver from IIO to Counter subsystem
>> 	- Minor modification in yaml ($id) to match Counter subsystem
>> 	- Add ABI documentation
>>
>> Userspace commands :
>> 	### SIGNAL ###
>> 	cd /sys/bus/counter/devices/counter0/signal0
>>
>> 	# Get available polarities for each capture event
>> 	cat polarity1_available
>> 	cat polarity2_available
>> 	cat polarity3_available
>> 	cat polarity4_available
>>
>> 	# Get polarity for each capture event
>> 	cat polarity1
>> 	cat polarity2
>> 	cat polarity3
>> 	cat polarity4
>>
>> 	# Set polarity for each capture event
>> 	echo rising > polarity1
>> 	echo falling > polarity2
>> 	echo rising > polarity3
>> 	echo falling > polarity4
>>
>> 	### COUNT ###
>> 	cd /sys/bus/counter/devices/counter0/count0
>>
>> 	# Run ECAP
>> 	echo 1 > enable
>>
>> 	# Get current timebase counter value
>> 	cat count
>>
>> 	# Get captured timestamps
>> 	cat capture1
>> 	cat capture2
>> 	cat capture3
>> 	cat capture4
>>
>> 	# Note that counter watches can also be used to get
>> 	# data from userspace application
>> 	# -> see tools/counter/counter_example.c
>>
>> 	# Stop ECAP
>> 	echo 0 > enable
>>
>> Julien Panis (3):
>>    dt-binding: counter: add ti,am62-ecap-capture.yaml
>>    Documentation: ABI: add sysfs-bus-counter-ecap
>>    counter: capture-tiecap: capture driver support for ECAP
>>
>>   .../ABI/testing/sysfs-bus-counter-ecap        |  64 ++
>>   .../counter/ti,am62-ecap-capture.yaml         |  61 ++
>>   drivers/counter/Kconfig                       |  14 +
>>   drivers/counter/Makefile                      |   1 +
>>   drivers/counter/capture-tiecap.c              | 634 ++++++++++++++++++
>>   include/uapi/linux/counter.h                  |   2 +
>>   6 files changed, 776 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ecap
>>   create mode 100644 Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
>>   create mode 100644 drivers/counter/capture-tiecap.c
>>
>> -- 
>> 2.25.1
> Something that has become apparent to me is the code repetition in this
> driver in order to support the capture buffer. Buffers are common
> components in devices, so it'll be good for us to standardize some of
> what we're exploring here into an interface that other drivers can also
> use. We have two ABIs to consider: the driver interface and the sysfs
> interface.
>
> For the sysfs interface, I think we'll have to expose each element
> individually (e.g. capture1, capture2, etc.) because sysfs attributes
> are suppose to expose only a single datum for any given attribute.
>
> For the driver side, we might want to introduce a new Counter component
> type for buffers and respective macros to streamline some of the code
> for driver authors. For example, a new COUNTER_COMP_BUFFER_U64 enum
> counter_comp_type constant could be introduced to represent a u64 buffer
> element; respective struct counter_comp read callbacks could be
> introduced::
>
>      int (*count_buffer_u64_read)(struct counter_device *counter,
>                                   struct counter_count *count,
> 				 size_t index, u64 *val);
>
> So a driver author can use the "index" parameter to locate the buffer
> element and pass back its value via the "val" parameter. To define the
> buffer, maybe helper macros like this could be introduced::
>
>      COUNTER_COMP_COUNT_BUFFER_U64("capture", ecap_cnt_cap_read, 4)
>
> This would define four u64 buffer elements each named prefixed with
> "capture" and with their read callbacks set to ecap_cnt_cap_read().
>
> One problem however is that I'm not sure if the C preprocessor would be
> able to unroll the COUNTER_COMP_COUNT_BUFFER_U64 to a dynamic number of
> elements based on a macro parameter (maybe there is a GCC extension).
>
> I'm just throwing out ideas, so I'd like to hear some comments and
> suggestions from others about how we should add buffer support to the
> Counter subsystem.
>
> William Breathitt Gray

Hi William,

I am going to send a new version (PATCH v5) without buffers as described 
above
(I added macros for cap1/2/3/4 similar functions). I tried taking into 
account the
comments made by Jonathan and you.

Regarding buffers, I don't know how driver upstream process is done when 
'significant'
subsystem modifications are being considered. Is it a problem for you if 
we continue
driver upstream process until it's merged, and then modify counter 
subsystem (and
ECAP driver with it) to add some buffer functionalities ? Or do you 
prefer adding such
functionalities to counter subsystem while upstreaming ECAP driver, 
without any
intermediate ECAP driver version ?

Julien Panis

