Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520B855393C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351436AbiFURyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiFURyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:54:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630FE1C93E;
        Tue, 21 Jun 2022 10:54:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id mf9so8781607ejb.0;
        Tue, 21 Jun 2022 10:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=1eMvpQGmuzfMVoYRI7eriOn5I/gqQSujwrf47DAtefA=;
        b=UGWyICoF0B6YAXeThrkyJcBSimG+HS00n7Gx8AhzRX4CghUiSLthzUaKBi/411M2yl
         2iSc4Jec/rFJ/DvO2P2hrKrVepnspC08bx0xUdrtxpLUXVU8nNyoC9oIoXAQbBErQyNj
         HDc7iskJUBOFini7+bDfUM5+WhXz0JNoGfBA8YDEt+Bhud67l4ZSab9XqMw0bvOHV6Hc
         vZPaNYmDX/ZcMQx0Mbjg4Ix8plra/vOMzvwLg5st5eKRZ2y9BXqbPrJS8q2uhlE3Tftf
         kn3f/Ma5AI36xdit1zmuOfqBx723UhVhCDigRUoFF2A3t6T45HuSVHim3Pg459fq/0EI
         5oiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=1eMvpQGmuzfMVoYRI7eriOn5I/gqQSujwrf47DAtefA=;
        b=sRccOTL4fECdLQ9cyJT1apsHjGnyfpltvuy2I4pY3F9BqsgJv2XqVEtWZ9ivgLecVu
         T3Bj7TOk/34Lrym4QEKV5ol/27x0CGi2T3MVChRgDYNVFUwLLFwtUv2wVLzvCZ4TdMoe
         u8PThQTa6x2b9gr/JSZ9EAYIoFb4yvbHqwddkvxjkgL6o77vH3H7baqslZNmisIkc6ze
         IK8BiYRh0Sz8MBwtU4oEZi5/Y3h/HHtXAB8i6Bg7CCpcKhImRJ+0YUyzaYrJAX4txFm0
         A2Wq1ueG1Ztr94eZxUHTvD3/McE5MIsYpGPfByC+iR6bNogO1RjOv/uakFakuK9EKTYP
         C7Mg==
X-Gm-Message-State: AJIora9CavdKffyhvKEvyR/h+peI8c5AWJBWZOZem2qMa0jm3D5WML/Z
        7FTWV2M3vq4CX35MUTMDxf0=
X-Google-Smtp-Source: AGRyM1tqDwkFqvkz9vkf9hEiAlt4g87Egh+XWoOYQty1n7xTXN7pTEIHixXgs7oOfA3enuHtIXgGAw==
X-Received: by 2002:a17:906:7c0c:b0:6f9:1fc:ebf3 with SMTP id t12-20020a1709067c0c00b006f901fcebf3mr27654186ejo.403.1655834087798;
        Tue, 21 Jun 2022 10:54:47 -0700 (PDT)
Received: from [192.168.43.195] (p57bfe813.dip0.t-ipconnect.de. [87.191.232.19])
        by smtp.gmail.com with ESMTPSA id lb25-20020a170907785900b006febc1e9fc8sm8047977ejc.47.2022.06.21.10.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 10:54:47 -0700 (PDT)
Message-ID: <d885a607-4db8-4c76-3931-627951a26ccd@message-id.googlemail.com>
Date:   Tue, 21 Jun 2022 19:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all
 hotkeys
Content-Language: en-US
From:   Stefan Seyfried <stefan.seyfried@googlemail.com>
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
 <0bfb0325-0362-2d51-7f25-f389af4bfb68@message-id.googlemail.com>
In-Reply-To: <0bfb0325-0362-2d51-7f25-f389af4bfb68@message-id.googlemail.com>
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

the patched ACPI video module DOES WORK.

I just managed to actually compile the unmodified source code m(
After patching acpi_video.c, compiling and installing it so that it 
actually gets used, everything works fine now.

On 21.06.22 12:23, Stefan Seyfried wrote:
> Hi Hans,
> 
> On 21.06.22 11:26, Hans de Goede wrote:
>> Hi,
>>
>> On 6/20/22 20:10, Stefan Seyfried wrote:
>>> Well, the non-working backlight is coming from the i915 driver, but 
>>> as this is a very old Chipset (i855 GM) I'd rather be happy it works 
>>> at all instead of complaining ;-)
>>> (I have another machine of similar age, hp nc6000 with ati graphics, 
>>> and there is no way getting it to work somewhat reliably at all)
>>
>> Ah right, you've got a panasonic + a native intel backlight device.
>>
>> We are going to need a quirk to (eventually also depending on other 
>> changes)
>> disable the broken intel backlight device.
>>
>> But that won't fix the keys issue, at least not without an extra
>> quirk just for that.
>>
>> I wonder if your machine supports the backlight control part of
>> the ACPI video bus at all. If not that would explain why it is
>> not reporting brightness keys and that would also give us a way
>> to solve this without an extra quirk.
>>
>> And that would actually also avoid the need for a backlight
>> quirk too.
>>
>> Can you pass "acpi_backlight=video" on the kernel commandline
>> and see if a /sys/class/backlight/acpi_video0 device then
>> shows up. If it does _not_ show up then indeed there is no
>> ACPI backlight control at all.
> 
> Nothing new shows up, just panasonic and intel_backlight as before.
> 
>> In that case please give the attached patches a try on top
>> of my last series.
> 
> they do not fix the brightness keys for me.

YES they do fix it. I just need to actually use the patched module :-)

> I did not have time to put in some debugging and will be traveling for 
> the rest of the week, but I'll take the toughbook with me and will try 
> to debug this later ;-)
> 
>> The acpi_video patch should fix your brightness keys then and
> 
> apparently it does not :-(
It does.

Thanks
	Stefan
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
  public relations, for nature cannot be fooled." -- Richard Feynman
