Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E83564790
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 15:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiGCNos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 09:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCNor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 09:44:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10275389E;
        Sun,  3 Jul 2022 06:44:46 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n8so8598673eda.0;
        Sun, 03 Jul 2022 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MhWXASV9uAtRYqFy58hR7cUX9m4VJqD2eKZ99FmSWGM=;
        b=pz1hxLte/F5cbuK5ITkMo2QzBCZPG6Vs1r7Y7/87EPI2A1ikkue+RNdrmqVH6gHqtk
         i5ELPBHx+n3Upz/uq4mOKJKOwMnTAS6FCWc7w/4FdJ8ySirkw47wrzmCk9OjdCl3Lph6
         U78DFCceqlQYdtD1umD2AANoM5rqmSRhULwzyc7tp8dzsJkha+d1f+LLQxXDrX/WewhT
         IReW25QCSPJYarnwzgHexTPixYP2WgemEW6yHcIFwKMhmX/H5lho93ClMeH4NaiElg5R
         DyXWirVoFgwu64zAN+vLimk1tAOuMHcYIVxkcCZ8bQzA9CZIPzWmJglIxVPjR+NFsYcv
         hwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MhWXASV9uAtRYqFy58hR7cUX9m4VJqD2eKZ99FmSWGM=;
        b=ed432jK/fwmGcMCaUkwWAg5b+XjDnjgKU8qJvZWIO9LXpDYX7o8je9gTO4ZKX8Zmkm
         OcbO7E/MoT1yTYaxJal/gJfJijW4oK7nBF/lZqMhEee4Ciz7b07rxLbvHN/vPqJQBWSO
         upznOmLO+vnZkM89UoVi33TZC85r9Ns74j5b3AQugCmJolZuEeFJzYnd9zXkECeiJZk1
         loHGw30m/vEX1Z4Y2MByt4ETqiBh2Zk52UzdE/EJH2JkWsPYGaOhlKhJiDFFt7Ssgaet
         h3i8ujztBwNxZeSdtRFpXIu/6PYmvZoaPQFdkUcB5X20EXvSYCZAMnZg9PEe7/vzH846
         lM1w==
X-Gm-Message-State: AJIora/5Naq2m3HFqA7Lm/O9XBYaPB3uTPm5DlzQ/jcReVbmigYhpHCx
        VequFysp2BYqlbRX1l3eCfg=
X-Google-Smtp-Source: AGRyM1uA0tgBD4B80gL1VAX4pYOFZjexmnjnURrl+5D/O1JzsHZ9I3bOzEoYieUnz+TSg3LHVLYWDg==
X-Received: by 2002:a05:6402:1606:b0:43a:2204:8b5e with SMTP id f6-20020a056402160600b0043a22048b5emr4247151edv.316.1656855884434;
        Sun, 03 Jul 2022 06:44:44 -0700 (PDT)
Received: from [10.17.0.7] ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id y21-20020a170906559500b00726dbb16b8dsm7357703ejp.65.2022.07.03.06.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 06:44:44 -0700 (PDT)
Message-ID: <3c5e8227-8110-a949-8045-54206357d63c@gmail.com>
Date:   Sun, 3 Jul 2022 15:44:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/4] platform/surface: Add KIP/POS tablet-mode switch
 driver
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220624183642.910893-1-luzmaximilian@gmail.com>
 <20220624183642.910893-3-luzmaximilian@gmail.com>
 <a49c84ed-c885-fe9b-5971-681a43edb560@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <a49c84ed-c885-fe9b-5971-681a43edb560@redhat.com>
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

On 7/2/22 11:05, Hans de Goede wrote:

[...]

>> A few more notes on the Surface Laptop Studio:
>>
>> A peculiarity of the Surface Laptop Studio is its "slate/tent" mode
>> (symbolized: user> _/\). In this mode, the screen covers the keyboard
>> but leaves the touchpad exposed. This is essentially a mode in-between
>> tablet and laptop, and it is debatable whether tablet-mode should be
>> enabled in this mode. We therefore let the user decide this via a module
>> parameter.
>>
>> In particular, tablet-mode may bring up the on-screen touch keyboard
>> more easily, which would be desirable in this mode. However, some
>> user-space software currently also decides to disable keyboard and, more
>> importantly, touchpad input, while the touchpad is still accessible in
>> the "slate/tent" mode. Furthermore, this mode shares its identifier with
>> "slate/flipped" mode where the screen is flipped 180° and the keyboard
>> points away from the user (symbolized: user> /_). In this mode we would
>> like to enable auto-rotation, something that user-space software may
>> only do when tablet-mode is enabled. We therefore default to the
>> slate-mode enabling the tablet-mode switch.
> 
> Note that you could add a libinput quirk to ignore the tablet-switch
> for keybd/touchpad event suprression since when not used the keyboard /
> touchpad are covered I expect them to not send false input events so
> this should be fine. Then the touchpad will keep working in "slate/tent"
> mode while still enabling the onscreen-kbd since you are reporting
> sw_tablet_mode=1.
> 
> The onscreen-kbd and auto-rotation enabling/disabling lives outside of
> ibinput. Although gnome-shell does use libinput to read the touchpad and
> currently I think the only way to get libinput to ignore the tablet-mode-sw
> is to mark it as unreliable, which I guess might also stop it from reporting
> it to gnome-shell.
> 
> Another option would be to mark the touchpad as "external" with a libinput
> quirk (so not build into the hw) then it also won't suppress events based
> on the tablet-mode-sw state. TL;DR: this can be fixed with a quirk on
> the libinput side, how best to do that needs to be discussed with the libinput
> devs.
> 
> And once solved at the libinput side, you probably don't need
> the module-parameter. Note I'm fine with keeping it, but feel free to
> submit a follow-up patch to remove it, explaining that this is fixed
> in libinput now...

Thanks for that hint!

Turns out libinput has a quirk for that (ModelTabletModeNoSuspend). I'm
working with someone actually owning a SLS and we will submit an entry
to the libinput hwdb once we've fleshed that out.

I'll yet have to think some more about whether it makes sense to keep
the module parameter or not. I think ideally there would be a way to
notify user-space for more states than just tablet/laptop, but that is
very device specific.

Regards,
Max
