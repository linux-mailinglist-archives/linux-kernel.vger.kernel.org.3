Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB7058C529
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241794AbiHHI6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbiHHI62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:58:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9FBB7C4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 01:58:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n4so8330670wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 01:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=GQr0TU/IAVWDYyerbKDk2A4nRN/cuRVyH3JCTSeJRIM=;
        b=EuBRrAcGUlDphP9CSvUyKBNPjkzGNXI7F3QQF5sh29Yxwb0+f6aSzzYondl0RNGGA0
         AK8yTSwb/BGA/3uMesmUuey5epWFb/Ainl7SLizlmBi+U4CAXfarqQ1wdZ9htmTPW6MJ
         9rcM4TE34R6rWF/GQKJFuAgm5sTJm43v81ET61GlEhb7uNCMlN6yEQoVX1Z3ar6BOuLC
         fW1wYRzRZSHB1cXimCVuIW4cKQhh7OYArOgSH5F84mh76Rl19ImJg7AoSb6V/cKVkZK6
         DSa7FhhyILldxbzYOYzjj5lQapQGkshTBLKjEcsZevVWy2r+eV8B8rFvTPvZyWr3ti3k
         XveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=GQr0TU/IAVWDYyerbKDk2A4nRN/cuRVyH3JCTSeJRIM=;
        b=sFyUUA6cCzttnZtOvSqP8XhFeI6j1eKsS/xA7C0xECtvcWfpixPwdgfG1NeFcNdJ4V
         /KFn+dLSuVuSXSaPPVRGobLDVqCDaAPoYf8QsX/KU0YT2I1J8v4w35C2705fPYsjRvo5
         B2VzAoPfYFNosbKkOIhwfFobdppNXPm/Cg+tCr9dgQLzWipgsYxhr8Mgwq1598aPbXsx
         ZKODaP1jq1mqc0ocyehCeO66lTrpANDRAbFzaM74Tjoa52J/eknm/S5f8Jq5z1vWdYOx
         piDDshBZYQaq9L9EmqiqYGzIJ0CKqQKlO3I46rEc5wnJDn1BkjZfKKwjveD73NMFXw8B
         IQqg==
X-Gm-Message-State: ACgBeo1WASn4IjAe5965AcdjMd3+YXNfB/Pt2L9aM0KIj0FAMFK99tM2
        N76+YuepI/E2PZJQ8XjPDayIrA==
X-Google-Smtp-Source: AA6agR4i2A+kqBXuCD9aj5Ri69ZxHbZNvma6EaMsn3YjRzRG8ctjqqPsyJYmw6fbBPbiUP8EyE8CuA==
X-Received: by 2002:adf:fc88:0:b0:220:61dc:d297 with SMTP id g8-20020adffc88000000b0022061dcd297mr10341186wrr.660.1659949104853;
        Mon, 08 Aug 2022 01:58:24 -0700 (PDT)
Received: from [192.168.1.69] (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id a5-20020a1cf005000000b003a500b612fcsm16407224wmb.12.2022.08.08.01.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 01:58:24 -0700 (PDT)
Message-ID: <d47c842b-579d-b119-73f9-e8c95984b30b@baylibre.com>
Date:   Mon, 8 Aug 2022 10:58:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v3 2/2] iio: time: capture-tiecap: capture driver support
 for ECAP
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
Content-Language: en-US
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <YvBZQsiAm6f3yxME@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/08/2022 02:30, William Breathitt Gray wrote:
> Hi Julien,
>
> I've taken a cursory look over the TI ECAP reference guide and your
> descriptions in this thread. I think a device driver for this would fit
> better in the Counter subsystem than IIO.
>
> First I want to correct a minor misunderstanding: the "timestamp"
> member of struct counter_event is simply a way to identify Counter
> events on the system as a way of grouping multiple Counter watches. In
> other words, the "timestamp" member here represents when a Counter event
> was detected by the system, not when an event was logged on the counter
> device hardware. Instead, hardware timestamps such as the CAPx registers
> would be provided by the "value" member of struct counter_event.
>
> Now, I have a few ideas for how we could expose the timestamps using a
> Counter device driver, but first I want to make sure I understand
> correctly what's happening in this device. If I understand correctly, we
> have the following device components:
>
> * CTR: 32-bit counter timer
> * Mod4: 2-bit counter
> * CAP1-CAP4: four 32-bit registers, each indepedently store a timestamp
> * ECAP: input signal providing event trigger edges
>
> Four edge polarities are configured corresponding to each CAPx register,
> yet the input signal is still the same single ECAP pin. The event that
> is fired is instead determined by the Mod4 counter: when Mod4 is 0 and
> the edge of ECAP matches the polarity configured for CAP1 then an event
> is triggered which saves the current CTR value to CAP1 and increments
> Mod4 to 1, etc.
>
> Is my understanding of how this device behaves correct?

Hi William. Thank you for your help.
Yes, your understanding of how this device behaves is correct.

>
> If so, then one possible way to represent this device in the Counter
> sysfs tree is something like this:
>
> * CTR: /sys/bus/counter/devices/counterX/count0/count
> * Mod4: /sys/bus/counter/devices/counterX/count1/count
> * CAP1: /sys/bus/counter/devices/counterX/count1/cap1
> * CAP2: /sys/bus/counter/devices/counterX/count1/cap2
> * CAP3: /sys/bus/counter/devices/counterX/count1/cap3
> * CAP4: /sys/bus/counter/devices/counterX/count1/cap4
> * ECAP: /sys/bus/counter/devices/counterX/signal0/signal
> * polarity1: /sys/bus/counter/devices/counterX/signal0/cap1_polarity
> * polarity2: /sys/bus/counter/devices/counterX/signal0/cap2_polarity
> * polarity3: /sys/bus/counter/devices/counterX/signal0/cap3_polarity
> * polarity4: /sys/bus/counter/devices/counterX/signal0/cap4_polarity
>
> This is just a tentative arrangement (you could also include "enable"
> attributes as well), but it should give you an idea of how it could be
> organized.
>
> In your driver, you could then use counter_push_event() whenever you get
> an event triggered. In userspace, your application will add Counter
> watches for the CAPx registers they want. When an event triggers,
> userspace can then received all four CAP register values at the same
> time via the respective /dev/counterX character device node.
>
> Would this design work for your needs?

Yes, that would work for my needs.
The "how" is not fully clear to me yet, since I never used counter 
subsystem. But the
best way to understand better how it works is probably to start working 
with it. :-)
So, next patch version will be based on counter subsystem.

>
> William Breathitt Gray

