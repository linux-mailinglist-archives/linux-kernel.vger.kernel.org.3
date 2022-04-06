Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3CF4F68CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 20:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbiDFSOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 14:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbiDFSO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 14:14:26 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2122C21FF6A;
        Wed,  6 Apr 2022 09:52:09 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-de3ca1efbaso3534790fac.9;
        Wed, 06 Apr 2022 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=3uOnnnRcHyGaYWBW4Eshs7k8QuZm369r3CQ2+mOAwQY=;
        b=ct4X6WqxuU/Q1UMCjoyR9Z012Uf01Ku3mKkW2dTVq7fENlE1OrhMArUQnWla7qXY/0
         rVY929iY98LRRp8e2z1qqXhIZJ9vikZ2vcauuubzw4RJG5nBxGRsxt0jpvcoTiKaQPVs
         vqgLAZ1uWHEZZyuEgXcmXj+ed/kg7vPfJrdMrDncxIoU12szbY8Fq0exTo6eX/Ue7PtZ
         2GXO5K+FdLtO1uFIGuz1OBOu7bGap58RPt761BiW37HDoViGOmoCH0w06Vw/ZlayidCV
         Br0JRxjsUfAR0n/qt4FQrpd0K+z//E/KWxQ8BvgJ1/XRcYKTQzFFH1Y7bBj894ykp1Zg
         iy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=3uOnnnRcHyGaYWBW4Eshs7k8QuZm369r3CQ2+mOAwQY=;
        b=FGh8ENyVS9gEv9ZXHp3oKCU3e9L+tarnrl6U5djElWEZkdgmBIviKBJ3DZZZivzbEQ
         HulA2I1ptupi3XmF4Dr+U25isU3pDMwr507QlaUtc6HcfASwHEO+TnsHGfXoA9iUjZ8a
         m4+vllc0KzVWvG8bH+WuF72VWEXv/zKGOWtRGtajL8FNSYJM3B4b0fqlUqb3sxRy3EZz
         SC6eonYYj3IauzedfoPxMgZpd0d+Giji7ptFqeIIgm7Z6Vb9TgyAj5NA+ItHgMUmcriT
         Gxy5zhMN5lpKVXp8LdWVfAfopjnK7qbJ2Jm9+SLU83V0HYdd9u2rdNTe+YdAjDEZA5Dc
         K/WA==
X-Gm-Message-State: AOAM532XcPOiHw4oG8yqD95BbzUG+KiahZD0SPLZozeiuni3JqvELDXa
        Q+2gZUxxgkkfZBe0pYe0weaEkuhwLAM=
X-Google-Smtp-Source: ABdhPJzIq8kq3b771EmaP3j5xGWSpBUW3dMUn6h+lR60x1GwKAVKSSWQdPM319x8/9myD4UZKiw/Fg==
X-Received: by 2002:a05:6870:c34c:b0:da:b3f:326a with SMTP id e12-20020a056870c34c00b000da0b3f326amr4423684oak.282.1649263928427;
        Wed, 06 Apr 2022 09:52:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s41-20020a05683043a900b005cdb244c9c3sm7284357otv.47.2022.04.06.09.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 09:52:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ebc0923a-48c1-ccd4-6b89-c4ba9ac48da4@roeck-us.net>
Date:   Wed, 6 Apr 2022 09:52:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        will@kernel.org, qperret@google.com, maz@kernel.org
References: <20220405141954.1489782-1-sebastianene@google.com>
 <20220405141954.1489782-3-sebastianene@google.com>
 <20220405211551.GB2121947@roeck-us.net> <Yk3ARqLLPssVIM2/@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] watchdog: Add a mechanism to detect stalls on guest
 vCPUs
In-Reply-To: <Yk3ARqLLPssVIM2/@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 09:31, Sebastian Ene wrote:
> On Tue, Apr 05, 2022 at 02:15:51PM -0700, Guenter Roeck wrote:
>> Sebastian,
>>
> 
> Hello Guenter,
> 
>> On Tue, Apr 05, 2022 at 02:19:55PM +0000, Sebastian Ene wrote:
>>> This patch adds support for a virtual watchdog which relies on the
>>> per-cpu hrtimers to pet at regular intervals.
>>>
>>
>> The watchdog subsystem is not intended to detect soft and hard lockups.
>> It is intended to detect userspace issues. A watchdog driver requires
>> a userspace compinent which needs to ping the watchdog on a regular basis
>> to prevent timeouts (and watchdog drivers are supposed to use the
>> watchdog kernel API).
>>
> 
> Thanks for getting back ! I wanted to create a mechanism to detect
> stalls on vCPUs and I am not sure if the current watchdog subsystem has a way
> to create per-CPU binded watchdogs (in the same way as Power PC has
> kernel/watchdog.c).
> The per-CPU watchdog is needed to account for time that the guest is not
> running(either scheduled out or waiting for an event) to prevent spurious
> reset events caused by the watchdog.
> 
>> What you have here is a CPU stall detection mechanism, similar to the
>> existing soft/hard lockup detection mechanism. This code does not
>> belong into the watchdog subsystem; it is similar to the existing
>> hard/softlockup detection code (kernel/watchdog.c) and should reside
>> at the same location.
>>
> 
> I agree that this doesn't belong to the watchdog subsytem but the current
> stall detection mechanism calls through MMIO into a virtual device
> 'qemu,virt-watchdog'. Calling a device from (kernel/watchdog.c) isn't
> something that we should avoid ?
> 

You are introducing qemu,virt-watchdog, so it seems to me that any argument
along that line doesn't really apply.

I think it is more a matter for core kernel developers to discuss and
decide how this functionality is best instantiated. It doesn't _have_
to be a device, after all, just like the current lockup detection
code is not a device. Either case, I am not really the right person
to discuss this since it is a matter of core kernel code which I am
not sufficiently familiar with. All I can say is that watchdog drivers
in the watchdog subsystem have a different scope.

Guenter

>> Having said that, I could imagine a watchdog driver to be used in VMs,
>> but that would be similar to existing watchdog drivers. The easiest way
>> to get there would probably be to just instantiate one of the watchdog
>> devices already supported by qemu.
>>
> 
> I am looking forward for your response,
> 
>> Guenter
> 
> Cheers,
> Sebastian

