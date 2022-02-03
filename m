Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587A64A8A35
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352909AbiBCRge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiBCRgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:36:31 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ED5C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 09:36:31 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i186so2863956pfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 09:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WWOapjCQjVg9c89BH1eP10gAd2LFeCCpAH4S3v6BFzM=;
        b=P213NYhnN21etN0dyRcDdZH1ks0gm7dddQKmpVQs65W2g7eXM44L6msfH5gfH8UC2J
         RaR73rUGM74+Ic4NXvnZuOFLv9NsX/uuqynhMcO/8iwQBiphTBw/eJZw+QoCJeplqq6R
         BBOnGRm+heiB55wc5aYXIPRy9yWcrf+dJDSIyi/Jyr2+857zeWimfQly242Q1976GHan
         W0ZCQPCu3ry0kjPJqlov85Q4SVqYU8tomdfGpfOoP8RPrXd4XhJxqccOCnWPqzoxO9IB
         sbHcx86PVw8rcUQH+xXufgd0MUv8bKvh+hfkWH/ZREDQ2Q/toKuGg6IZlVy3GcsxDe/K
         lF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WWOapjCQjVg9c89BH1eP10gAd2LFeCCpAH4S3v6BFzM=;
        b=LasN5NeiIL5VXJhTnU8XmsAxbqd9vfBy1jDBg7tItCY/nGz3/mLzqD2qm6IrMzOTiK
         er00n7U9i2WtAsgP8WBkt3vMM7RdhiOP3bDshHo+UtlrRjnqvT2EFf+PNu0YBb4aQC/H
         BINzrtSx0thX76BcrRFN83djmi+ttMR4F3IzOygQ5aGVtd2S5J22bylPCxJIuWPqdcr1
         LNHqMruT9Uf6PjGyeIEnX1wFKNrex8J+knBoP0pJB94r7/Dascu+XiBIuvGFr50NkMUn
         SrLd+wC3tZqCaBHlN5A5KWIM7CRtZEMk2rVRT9XAPNNBFJur5in74VX9kqYX43if/IA/
         O2Ew==
X-Gm-Message-State: AOAM533JKzqsrRJGnkFvhKssYszNMvuCftGDoJZyM+t03bz3nI4Wamaz
        UYFK4L9EoM08gPPTE6F0vPA=
X-Google-Smtp-Source: ABdhPJz0XM5FGUnkBsgmxaG3ROgwbEnAZC3NNR2Sb6+fKTgrBpP83dx45j4BwZl3P4+JgCf7vD70gA==
X-Received: by 2002:a62:b40e:: with SMTP id h14mr35036831pfn.79.1643909790568;
        Thu, 03 Feb 2022 09:36:30 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id pf4sm12465721pjb.35.2022.02.03.09.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 09:36:30 -0800 (PST)
Message-ID: <34938793-cecc-2ad8-a4eb-81bb278ce9b5@gmail.com>
Date:   Thu, 3 Feb 2022 09:36:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] Broadcom STB PM PSCI extensions
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220122035421.4086618-1-f.fainelli@gmail.com>
 <20220203111435.e3eblv47ljkwkvwf@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220203111435.e3eblv47ljkwkvwf@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2022 3:14 AM, Sudeep Holla wrote:
> On Fri, Jan 21, 2022 at 07:54:17PM -0800, Florian Fainelli wrote:
>> Hi all,
>>
>> This patch series contains the Broadcom STB PSCI extensions which adds
>> some additional functions on top of the existing standard PSCI interface
>> which is the reason for having the driver implement a custom
>> suspend_ops.
>>
>> These platforms have traditionally supported a mode that is akin to
>> ACPI's S2 with the CPU in WFI and all of the chip being clock gated
>> which is entered with "echo standby > /sys/power/state". Additional a
>> true suspend to DRAM as defined in ACPI by S3 is implemented with "echo
>> mem > /sys/power/state".
> 
> How different is the above "standby" state compare to the standard "idle"
> (a.k.a suspend-to-idle which is different from system-to-ram/S3) ?

There are a few differences:

- s2idle does not power gate the secondary CPUs

- s2idle requires the use of in-band interrupts for wake-up

The reasons for implementing "standby" are largely two fold:

- we need to achieve decent power savings (typically below 0.5W for the 
whole system while allowing Wake-on-WLAN, GPIO, RTC, infrared, etc.)

- we have a security subsystem that requires the CPUs to be either power 
gated or idle in order the hardware state machine that lets the system 
enter such a state and allows the out of band interrupts from being 
wake-up sources


> Suspend to idle takes all the CPUs to lowest possible power state instead
> of cpu-hotplug in S2R. Also I assume some userspace has to identify when
> to enter "standby" vs "mem" right ? I am trying to see how addition of
> "idle" changes that(if it does). Sorry for too many questions.
> 

Right that user-space in our case is either custom (like RDK, or 
completely custom), or is Android. For Android it looks like we are 
carrying a patch that makes "mem" de-generate into "standby" but this is 
largely because we had historically problems with "mem" that are being 
addressed (completely orthogonal).

I did not consider it as a viable option at the time, but if we were to 
implement "standby" in drivers/firmware/psci/psci.c would that be 
somewhat acceptable?
-- 
Florian
