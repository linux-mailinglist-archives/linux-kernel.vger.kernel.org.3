Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E0E5A8DDA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiIAF7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiIAF7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:59:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D48310DE6F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 22:59:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d5so8424403wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 22:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=q6PFOqpKmYyLxZjeSDCGsGBIQz8zT4aoax/wQsmKE8E=;
        b=TLwbUpVo8TEEVjNV1j+KSP0jJYgUo+OMkPmaqZUI9tnjnDs+WJyugsU9wX1Hsdc9E9
         Ctk90qzvDabls7KQCVCYE/Rc0ERzbKaeC9q9o2M28wggxOoxnxjCpXO32xTQYxbQQ47h
         2ftrsglRLlXGecjOYfYaarg1veKJBu1JDDMTSCgRtnpVfDQNnlBvjVJSHgEvFju2/OZy
         RwOI0KP0ALpOxKiSrCKbHO5HCCeBSRBhytAf8zQ3ToPeBRwr3VYK09JiOEWutSBJogMn
         TsDXLSbeZarTdKDLZGFT7dH65jwShwCQEFYORzd0bP5gnP4qYzlMs6MuLwaWTpiz8nvJ
         N+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=q6PFOqpKmYyLxZjeSDCGsGBIQz8zT4aoax/wQsmKE8E=;
        b=gC+1lx8yA2X3AXYU0jkTFmHCF52PI4djM5606XqAsftm6STKVm94/BBFwnkz8f7s2B
         uG8Hn00vQW+mTFUAT9ScV5A5jMgoCnXlIjJUNwjDdpXHmRP+WS12zfdNgqsamGn5te6I
         FTI8gnMEQVE5yPG9iiJk6+51klVhKJFcUxNrFlolB1FX8L5nkqLP/hFnQIjW2jJxly+q
         RRMWfDXAQzM038fdi1Flftr6lfpklD5Ktvx/mXON2NawERsqmawAm3/8wxjA4Gv6y531
         XoFgvTXoarVVGPkWLnPlTr6v3MtBVTK9JUCfEUwCNKSLL4tv3Hg1QAMzskYCIOIA9QU/
         r9sg==
X-Gm-Message-State: ACgBeo2k1hWScl+yLr61IM+3sEdNgjIzNk76Ui/P10KbCBe0MwxGU9lY
        MqYNl1duDC4ZY/09lZda04pIxTq/1pu/bw==
X-Google-Smtp-Source: AA6agR7LfsWI9xpyRJMxc5NfZ24BUKLV76WMMcY/OJdLZ9ThXrmqZHDI6uKd1LcvSgPV2Nm3EzFkow==
X-Received: by 2002:a05:600c:6009:b0:3a5:b069:5d34 with SMTP id az9-20020a05600c600900b003a5b0695d34mr3930057wmb.115.1662011980052;
        Wed, 31 Aug 2022 22:59:40 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b003a342933727sm4376692wmb.3.2022.08.31.22.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 22:59:39 -0700 (PDT)
Message-ID: <be354f9e-47c7-bd6e-c570-e7364858ced4@linaro.org>
Date:   Thu, 1 Sep 2022 07:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: thermal driver patch
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Steven J Abner <pheonix.sja@att.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
References: <DL9RGR.8W3XFSCFFYXI2.ref@att.net> <DL9RGR.8W3XFSCFFYXI2@att.net>
 <0f961ea6-4948-0b7a-e01d-d62ca4065af8@infradead.org>
 <L9MDHR.JVBXTJ2L6TPP2@att.net>
 <cf3a3cbd-c189-a120-124f-98d6adac058d@infradead.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <cf3a3cbd-c189-a120-124f-98d6adac058d@infradead.org>
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

On 30/08/2022 00:06, Randy Dunlap wrote:
> Hi Steven,
> 
> [adding Rafael, Daniel, linux-pm]
> 
> 
>> [    5.244369] thermal thermal_zone0: failed to read out thermal zone (-61)
> 
> Some driver is returning -ENODATA to the thermal core....
> 
> Any suggestions?

Could it be related to this bug?

https://bugzilla.kernel.org/show_bug.cgi?id=201761

Is it possible to give the thermal zone 'type'


> On 8/29/22 05:20, Steven J Abner wrote:
>>
>>
>> On Mon, Aug 29, 2022 at 05:47, Randy Dunlap <rdunlap@infradead.org> wrote:
>>> a. the exact message(s) [copy-paste]
>>> c. what kernel version is causing the problem
>>
>> [    0.000000] Linux version 5.18.12-051812-generic (kernel@sita) (gcc (Ubuntu 11.3.0-4ubuntu1) 11.3.0, GNU ld (GNU Binutils for Ubuntu) 2.38.50.20220629) #202207150942 SMP PREEMPT_DYNAMIC Fri Jul 15 10:10:55 UTC 2022
>> [    5.244369] thermal thermal_zone0: failed to read out thermal zone (-61)
>>
>> [    0.000000] Linux version 5.4.204-0504204-generic (kernel@kathleen) (gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.1)) #202207071639 SMP Thu Jul 7 16:59:09 UTC 2022
>> [    5.207243] thermal thermal_zone0: failed to read out thermal zone (-61)
>>
>> as to reproduce, can only think of saying: boot up kernel without patched?
>>
>> additional info that may? help:
>> I did not trace what calls 'update_temperature', just saw any call to it
>> will cause message due to it's call to 'thermal_zone_get_temp', which states
>> no thermal_zone_device should provide or be requesting an update.
>> It may be that if 'thermal_zone_get_temp' where removed was actual function's
>> intent, and all instances in this file and other function's use was a case of designer debugging or signaling a deprecated API? That was my intent on saying
>> 'for you to do and review', because it looked like a lot of functions could be
>> updated to take into account that no device should call functions that start off
>> by calling 'thermal_zone_get_temp'.
>>   It is more probable that my patch suggestion is wrong and calls to
>> 'update_temperature' are suppose to fail with return -ENODEV always allowing
>> other calls to 'update_temperature' to fail also. With proposed code, I've not
>> seen adverse side effects. It just removed dmesg error, but was hoping I would
>> get lucky and it was the reason for CPUTIN -62C without actually hard work of
>> finding real reason.
>>
>> additional dmesg info:
>> only other 'thermal' are 'thermal_sys' loading governors
>> smpboot: CPU0: AMD Ryzen 5 2400G with Radeon Vega Graphics (family: 0x17, model: 0x11, stepping: 0x0)
>> from lspci:
>> Kernel driver in use: k10temp
>> from lsmod:
>> nct6775
>> hwmon_vid
>> these 2 removed in personal configs, but used in the two ubuntu kernel builds:
>> wmi
>> wmi_bmof
>>
>> Steve
>>
>>
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
