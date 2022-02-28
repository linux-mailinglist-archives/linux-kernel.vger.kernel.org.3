Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8664C6713
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiB1K2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiB1K2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:28:23 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31EA27FE1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:27:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d3so14659178wrf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uCr16OVWDuSEsQKxJNsm24ttfbU9MwffSycejs9RTnk=;
        b=ZUbe634WUdwhywJ4GsoAKl6hduEOQlgM8D4X1TOTsVJvb6+GZ9EMTRfhcBDrpp06UA
         6hgyt6qOaCIWMfaC4BjthYAtieiqtKpIRA7vsRxDcLPkVrHUQoni9ZjcPVJMK6oDJxkx
         UBmIixpJLH0kiZ6iLMG8XMjYBSzgjK+IbZNQC9wErZGjhY3GlnYfKjwzQOICDNSidlb1
         VAdTwLQe61Ci/zAqkCzlw68QDExhMWz/Nbl4LZ1BpDlWQ3Hp/857BytJ3ZRm81o8T2wN
         8tIO4BQOLGc3f5qvTEzl3IZSmgNQZt7yDYEUg0L6LGS2uygvBc/8DT/jIsf7fXyeR9Nz
         6aYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uCr16OVWDuSEsQKxJNsm24ttfbU9MwffSycejs9RTnk=;
        b=OmJcrPUUUMBHPm//mzY/mYYWlWMwviMiC36otkaVKVHv/2me2r8XhNmUsL0KAS3uch
         7y+ObAPnvamKwwcy3dY8iNbXhlCYOuO1H/Pnd3ip5qMXEG9QYS7vcZokFbl/r94Un+g+
         IsD81HOe4BCy1NPtKSFzBqV03J5c5rgcpR3iqd+gDm6v/7ltFIleeus9fN7jgGxqbWBU
         6EWd9lSfv+sVvP4ghOW+LwXQoSaWwy8N8wzJQiRjZ9iBSA7uPtCmsoHuMCA7yWQWQm9p
         hyU6kZdVp8vnLog0e/5jAPSCn22iD6/RPYau971w4zCorUmr2Pixs08vJFqtCw/uXWST
         Tb1w==
X-Gm-Message-State: AOAM533eH5n92pNjUeM8v3PHrEIiqXaRkPHTQ54mxu4/z70UHzK9jelP
        ygJvfNyWGDRWeKrIIxlu0mfE4A==
X-Google-Smtp-Source: ABdhPJwYCZzz6bNvTctYj1kOHNVO07F8Rb+DN7QVIJZSBzrbPRTFp96IFJpu9Efpf8Vrl0tgM9L5jg==
X-Received: by 2002:a5d:53c5:0:b0:1ed:bf1b:be44 with SMTP id a5-20020a5d53c5000000b001edbf1bbe44mr15621470wrw.285.1646044062158;
        Mon, 28 Feb 2022 02:27:42 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:7f2b:6650:2756:a131? ([2a01:e34:ed2f:f020:7f2b:6650:2756:a131])
        by smtp.googlemail.com with ESMTPSA id g5-20020a5d5545000000b001ed9d3f521csm10058972wrw.113.2022.02.28.02.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 02:27:41 -0800 (PST)
Message-ID: <2e56d310-65a9-e910-98e0-c7c51b88b7f6@linaro.org>
Date:   Mon, 28 Feb 2022 11:27:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v14 4/5] clocksource/drivers: Add a goldfish-timer
 clocksource
Content-Language: en-US
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20220130143333.552646-1-laurent@vivier.eu>
 <20220130143333.552646-5-laurent@vivier.eu>
 <1a0f23f2-361a-25d1-b371-7a229758d248@vivier.eu>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1a0f23f2-361a-25d1-b371-7a229758d248@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2022 15:31, Laurent Vivier wrote:
> Daniel,
> 
> as you reviewed the v12, could you review this version to see if I have 
> addressed your comments?

[ ... ]

> Le 30/01/2022 à 15:33, Laurent Vivier a écrit :
>> Add a clocksource based on the goldfish-rtc device.
>>
>> Move the timer register definition to <clocksource/timer-goldfish.h>
>>
>> This kernel implementation is based on the QEMU upstream implementation:
>>
>>     https://git.qemu.org/?p=qemu.git;a=blob_plain;f=hw/rtc/goldfish_rtc.c
>>
>> Details related to Goldfish devices can be found in:
>>
>>    
>> https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT 
>>
Please do not add pointer in the changelog as this one will stay forever 
but no guarantee for the url.

A description of the timer is enough:

eg.
commit 625022a5f1606
commit a7ad38b0dd3c1


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
