Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02684552397
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245021AbiFTSKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238101AbiFTSKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:10:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0691018;
        Mon, 20 Jun 2022 11:10:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id o7so22694967eja.1;
        Mon, 20 Jun 2022 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=zsLJ/2OoZMKtOlqDazkQ5jelDfz0Teu3KTFolSw+PAc=;
        b=nsiYVaDmS1GrdJE6qWzsoK5WRSuZjGa7VNkhWxNDNp0re8+zob4t/hTb1sS8ZyxEd5
         VKVEY/kr1SQzq5w/C17en3Ab/uCwuSrBQl4p/swSDC+5KBi/SjG8MaCgocUEmyRK1qNT
         ZhKv9ww4OyGzumrj8XzFnbvd25jq75kYaIVkmmY7x28oc5g6xM2aYXPj9obAgvyIwvJ9
         Cv29joFmFDqRe3gdo/q2VUcXmpyaX4q+bMp6N5Bl5GFurAODnUHoYeE+pv4OIJ70yX02
         AXscFri//pwc1a0+cSh2Pi7Ja3A6RrkZy3tcTxHuqvJ0bRgtSeM1IcipQVqByd81PI2d
         mcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=zsLJ/2OoZMKtOlqDazkQ5jelDfz0Teu3KTFolSw+PAc=;
        b=6mBOxMsEjnP4kJCQ5gCz6vO9N/IMm8e+/SYp8azxlMmby8LlttClKyU6u2vE9Ju73f
         tYYP0tmOBgcVrjhYAKOI79bxczgk3Y/hA4jmgaw1JVvS/pcjl1VawhDkwxwqWcZRlIgY
         fmPNypynejjL8cf/A5HoDiZ282Hkfhhwy/EuE+TCPHCUi52cZvqd+fjsuGfO4qj1ou/i
         H0QlfdN5ah5/kg9iG3I2luN6DbrcURod/ShIktNf03nZysXPqFbRNFXLjhqynl3O/OS9
         GzxnCQ+2oP+RhckThoGRZLewFYZaV1KPCkKZu/u8un8UKdulra9buFEnTEFJJaQpCdwM
         gERw==
X-Gm-Message-State: AJIora+k4w4+pQwY9xze4S99M4dYIj737LTMUe22ZCxTd2H17VfzyAPr
        QaK+TCMgdn7M/Vet9mX7zNQ=
X-Google-Smtp-Source: AGRyM1vmz3kSE1eCVEjy41bGig0wxFGvIXK7h3CRJ8lAxAvTmf4MdErDbKVNBKLetxB/p8679AKBTQ==
X-Received: by 2002:a17:907:8a1f:b0:711:da32:8410 with SMTP id sc31-20020a1709078a1f00b00711da328410mr23054767ejc.298.1655748637320;
        Mon, 20 Jun 2022 11:10:37 -0700 (PDT)
Received: from [192.168.200.12] (p3ee2b637.dip0.t-ipconnect.de. [62.226.182.55])
        by smtp.gmail.com with ESMTPSA id z21-20020aa7d415000000b0043566884333sm7696337edq.63.2022.06.20.11.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 11:10:36 -0700 (PDT)
Message-ID: <ad0e83af-b704-53b8-3963-b4dd53853f2b@message-id.googlemail.com>
Date:   Mon, 20 Jun 2022 20:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Seyfried <seife+kernel@b1-systems.com>,
        Stefan Seyfried <seife+kernel@b1-systems.com>
References: <20200821181433.17653-8-kenneth.t.chan@gmail.com>
 <20220612090507.20648-1-stefan.seyfried@googlemail.com>
 <20220612090507.20648-3-stefan.seyfried@googlemail.com>
 <CAHp75Ve+vrfSu6pD+AKe-eCVA2pC5o520y4gVwLNg9Dtk0U5bw@mail.gmail.com>
 <CAHp75VdFPUHTeDBY5ukFgVqJJn7BbTHxrxKUGOLB6P1UX-utAg@mail.gmail.com>
 <d80789bc-a8fc-de5f-164a-75adf7097311@message-id.googlemail.com>
 <6969ca0e-4a4c-c995-02a2-6645f875338c@redhat.com>
 <CAPqSeKu9csK_u0S6MiRay_mvfYejUhKbb=wvJO7F_Z-JL6F7DA@mail.gmail.com>
 <5f03f5b9-87bb-e27d-ce51-9c1572221f21@redhat.com>
 <89398c05-92c6-120d-ed51-ab62f1f404eb@message-id.googlemail.com>
 <19e590f1-e865-ad19-e9e4-df1f9274663c@redhat.com>
From:   Stefan Seyfried <stefan.seyfried@googlemail.com>
Subject: Re: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all
 hotkeys
In-Reply-To: <19e590f1-e865-ad19-e9e4-df1f9274663c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 20.06.22 17:08, Hans de Goede wrote:
> Hi,
> 
> Thank you for the quick testing.
> 
> On 6/17/22 15:07, Stefan Seyfried wrote:
>> Hi Hans,
>>
>> On 17.06.22 13:07, Hans de Goede wrote:
>>
>>> Thank you for providing this info. Can you please give
>>> the attached patch series a try, this includes Stefan's 1/2 patch
>>> and replaces Stefan's 2/2 patch.
>>>
>>> This will hopefully fix the double key-presses for you, while
>>> also keeping everything working for Stefan without requiring
>>> a module option or DMI quirks.
>>>
>>> Stefan can you also give this series a try please?
>>
>> Works for me, almost out of the box.
>> I need to enable "report_key_events=1" in the video module, then the panasonic-acpi module starts reporting brightness up/down keys.
> 
> Ok, so you need another module option that is not really helpful.

Well, I looked into the acpi_video.c module and that one is to blame.
By default, it assumes that both "OUTPUT_KEY_EVENTS" and 
"BRIGHTNESS_KEY_EVENTS" should be handled by this module.
But on the CF-51, this does not happen. "Video Bus" does not generate 
any key events (I'm not sure about output, but plugging in a VGA monitor 
and enabling/disabling it with xrandr or tapping the "display" fn-f3 
hotkey does not get anything from "Video Bus" input device.

> The idea behind the acpi_video_handles_brightness_key_presses() check
> is that if the ACPI video bus device is present it is expected to
> already report brightness up/down keypresses and we want to avoid
> duplicates.

Yes, but the check apparently returns true in my case, because:

         return have_video_busses &&
                (report_key_events & REPORT_BRIGHTNESS_KEY_EVENTS);

apparently i have a video_bus ;-) and report_key_events (== -1) & 2 is true.

This check is totally fine, it's just that *the acpi_video.c* code is 
missing a DMI match for my machine telling it that it handles nothing at 
all.

> Can you check with evtest or evemu-record that the brightness
> events are not already being delivered by the "Video Bus"
> input device ?

I did, nothing at all gets delivered by Video Bus.

>> Volume and mute keys work without manual changes.
> 
> Good.
>   
>> (I tested against 5.18.2 because that's what was already prepared. That old machine takes quite some time, even to just compile the platform/x86 subdirectory ;-) but I don't think this is relevant. If you think it is, I can also test against latest 5.19-rc code)
> 
> Testing against 5.18 is fine .
> 
>>> Looking at this has also brought up an unrelated backlight question:
>>>
>>> Kenneth, since you have acpi-video reporting keypresses you will
>>> likely also have an acpi_video (or perhaps a native intel) backlight
>>> under /sys/class/backlight and I noticed that panasonic-laptop
>>> uncondirionally registers its backlight so you may very well end
>>> up with 2 backlight controls under /sys/class/backlight, which
>>> we generally try to avoid (so that userspace does not have to
>>> guess which one to use).
>>>
>>> Can you do:
>>> ls /sys/class/backlight
>>
>> toughbook:~ # ls -l /sys/class/backlight/
>> total 0
>> lrwxrwxrwx 1 root root 0 Jun 17 14:45 intel_backlight -> ../../devices/pci0000:00/0000:00:02.0/drm/card0/card0-LVDS-1/intel_backlight
>> lrwxrwxrwx 1 root root 0 Jun 17 14:49 panasonic -> ../../devices/virtual/backlight/panasonic
>>
>>> and let me know the output?
>>>
>>> Also if there are 2 backlights there then please do:
>>> cat /sys/class/backlight/<name>/max_brightness
>>> to find out the range (0-value)
>>
>> toughbook:/sys/class/backlight # grep . */max_brightness
>> intel_backlight/max_brightness:19531
>> panasonic/max_brightness:255
>>
>>> and then try if they both work by doing:
>>>
>>> echo $number > /sys/class/backlight/<name>/brightness
>>>
>>> with different $number values in the range and see
>>> if this actually changes the brightness.
>>
>> intel_backlight: does not work
>> panasonic: does work
> 
> Ok, so that suggests that the ACPI video bus on your
> device is defunct, so I guess it also does not report
> key-presses (see above) ?

Yes, it looks like ACPI video driver is totally useless on that machine.

> This will also need some work then because we want to move
> to there only being 1 (actually working) backlight-class
> device. Rather then having multiple and let userspace
> guess which one it needs to use.

Well, the non-working backlight is coming from the i915 driver, but as 
this is a very old Chipset (i855 GM) I'd rather be happy it works at all 
instead of complaining ;-)
(I have another machine of similar age, hp nc6000 with ati graphics, and 
there is no way getting it to work somewhat reliably at all)

>>> While we are at it, Stefan can you do the same please?
>>
>> See above.
>> But hey, this is an i855GM graphics chip, I'm happy if it is still working *at all* (for example I need to avoid the xf86-intel driver and use the modesetting driver instead to get a usable sytstem)
>>
>> And I'm totally happy if all I have to do in the future is a
>>
>> option video report_key_events=1
>>
>> modprobe.conf file ;-)
> 
> We really don't want people to have to specify module-options just
> to have things working.

I understand, but then it's my job to get that DMI match to set this 
parameter into acpi_video.c ;-)

> Stefam, at least for the backlight class-device issue we will need a DMI
> quirk, so can you run:
> 
> sudo dmidecode > dmidecode.txt
> 
> and then attach the output to your next email, or send me a copy
> privately ?

I'll send it privately as it is pretty big, but I think

DMI_BOARD_VENDOR, "Matsushita Electric Industrial Co.,Ltd."
DMI_BOARD_NAME, "CF51-1L"

(Similar to the CF51-2L in acpi/sleep.c) will do.

Best regards,

	Stefan
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
  public relations, for nature cannot be fooled." -- Richard Feynman
