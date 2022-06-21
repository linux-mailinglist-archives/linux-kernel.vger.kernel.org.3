Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3AA552FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348258AbiFUKYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347235AbiFUKYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:24:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6490028726;
        Tue, 21 Jun 2022 03:23:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z19so1863319edb.11;
        Tue, 21 Jun 2022 03:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=UIabU2pkC2/AvrVTQSBwnJCm7Ly90Sb7abdtPAu5vBs=;
        b=ajb1az5VvNGT+J/HemtLsXsmMKyswA0XxkCXmMw9NxDOAKaI3GjXEH0aHtAmKF6wEX
         mzU7czpoQY4f6XXfd2hPL77gM7k9SPWesdlKTkxD7IZCjoWzJNLcYUt9Sp0X6GR8hGz+
         ibn7CNrTq8WzeH9Y7MoGxUgJTPZ/1/njUH1i6Sp00AAxO5JZJcx0eIqufnnkEOMBJ09w
         /ovv2c4OLtG1npo0wkHmxjA/shsF2Tjljs+96WkBGW8hWId0y4Fjf6OJQsf2tEIJ2rWm
         B0vlddY77Jq9aorSgCWjk43ntmtfiEqtKFOxgkDHJwS7MdBY1C/X5B4leW79MOpIpAzn
         JZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=UIabU2pkC2/AvrVTQSBwnJCm7Ly90Sb7abdtPAu5vBs=;
        b=zkhI8f5BvrOVzIFnOOMu8FK3yY6hRJel8SLfqOGzUpAXlRF0F/WGJHUZbZkaQIJbyo
         swlRJ09CmoyeEa9pcEa5QQHH6gxoPrQfhfi6hxcLtR+9Q3ftWtj5+ZEyRXIhuYwo2FPc
         sqQTcFa/1idyyKKu0tnca9SySf1bpMutKByJXFNlmF83K5zBMB8wYcskKl85uXZAbQhO
         UpBX88iVFabRgPFxDfzt5yRilV16k+9Wmg7AkCFXrRP1q32fvhui7wiXIcpcyVV4JM4r
         6OwQ9V47TeZDG+m2vwRMNKU565nXvKF8kDgs6puGoHJITarUfnHqsJSNWpvcGKlQqMFM
         8KaQ==
X-Gm-Message-State: AJIora8JDxAIOqe3ExWwhxXaslWWeuRs+IhyCRH2T7RYu/BonQ5yrJ65
        /mlsRirfU2HvmPClB97SZLc=
X-Google-Smtp-Source: AGRyM1sKeqzQgg3kXilBxLYi2NDAnuXhA+TCXtQjYOPnmgJc1bzEKOsxrVDDOEldL/oiE9zVuU2mwg==
X-Received: by 2002:a05:6402:128c:b0:435:6a3b:3a0a with SMTP id w12-20020a056402128c00b004356a3b3a0amr22099773edv.237.1655807037880;
        Tue, 21 Jun 2022 03:23:57 -0700 (PDT)
Received: from [192.168.200.12] (p3ee2b637.dip0.t-ipconnect.de. [62.226.182.55])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709063ca900b0072232a898f1sm4466923ejh.103.2022.06.21.03.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 03:23:57 -0700 (PDT)
Message-ID: <0bfb0325-0362-2d51-7f25-f389af4bfb68@message-id.googlemail.com>
Date:   Tue, 21 Jun 2022 12:23:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
 <ad0e83af-b704-53b8-3963-b4dd53853f2b@message-id.googlemail.com>
 <3f3dfbad-9437-2c04-cf56-861649c117fd@redhat.com>
From:   Stefan Seyfried <stefan.seyfried@googlemail.com>
Subject: Re: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all
 hotkeys
In-Reply-To: <3f3dfbad-9437-2c04-cf56-861649c117fd@redhat.com>
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

On 21.06.22 11:26, Hans de Goede wrote:
> Hi,
> 
> On 6/20/22 20:10, Stefan Seyfried wrote:
>> Well, the non-working backlight is coming from the i915 driver, but as this is a very old Chipset (i855 GM) I'd rather be happy it works at all instead of complaining ;-)
>> (I have another machine of similar age, hp nc6000 with ati graphics, and there is no way getting it to work somewhat reliably at all)
> 
> Ah right, you've got a panasonic + a native intel backlight device.
> 
> We are going to need a quirk to (eventually also depending on other changes)
> disable the broken intel backlight device.
> 
> But that won't fix the keys issue, at least not without an extra
> quirk just for that.
> 
> I wonder if your machine supports the backlight control part of
> the ACPI video bus at all. If not that would explain why it is
> not reporting brightness keys and that would also give us a way
> to solve this without an extra quirk.
> 
> And that would actually also avoid the need for a backlight
> quirk too.
> 
> Can you pass "acpi_backlight=video" on the kernel commandline
> and see if a /sys/class/backlight/acpi_video0 device then
> shows up. If it does _not_ show up then indeed there is no
> ACPI backlight control at all.

Nothing new shows up, just panasonic and intel_backlight as before.

> In that case please give the attached patches a try on top
> of my last series.

they do not fix the brightness keys for me.
I did not have time to put in some debugging and will be traveling for 
the rest of the week, but I'll take the toughbook with me and will try 
to debug this later ;-)

> The acpi_video patch should fix your brightness keys then and

apparently it does not :-(

> the extra panasonic-laptop patch should not make any difference
> for the available /sys/class/backlight devices on your laptop,
> while filtering out the broken panasonic backlight on Kenneth's
> device.

Yes, the panasonic backlight does still work on my machine.

Best regards,

	Stefan
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
  public relations, for nature cannot be fooled." -- Richard Feynman
