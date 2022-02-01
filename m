Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7994A5A1D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbiBAKgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:36:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236678AbiBAKgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643711812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaqBrIFOHvMLEnJtoyzrnK2gwLgrZ2ScPtfEFGlgxAY=;
        b=UTlJo8OdsCAk5giON9iSJqA41YHNOkiVF7bKoCiHubF1VzcstSpz0D7EEtkoELp1Y6PoIb
        CtbcVuXlP+ZjcpWhIibsFG1MgCjoBuiET1ZZyX3iv7v58tTetPnmAnQRe54hehO4MYepap
        J6oy1UaNMJ1Svs8CEgE8Rx6aXnle3iM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-1C3FyQkKN6aqq-xI4NDTqQ-1; Tue, 01 Feb 2022 05:36:51 -0500
X-MC-Unique: 1C3FyQkKN6aqq-xI4NDTqQ-1
Received: by mail-wr1-f69.google.com with SMTP id i25-20020adfaad9000000b001e01f5804abso3193316wrc.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 02:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kaqBrIFOHvMLEnJtoyzrnK2gwLgrZ2ScPtfEFGlgxAY=;
        b=MtUIEZi+4xSpH+Exyd6WkmjI1dprhfEyadvK0kKsdXiFaDDRAscyYcFM8qpo69Q9hg
         cmnCosgVM4dnyPGyfDk1HWA/Rt8EPMISNllAGFQbR5R1lYAN1jLAp0Xu5h0Yvsn7QEAN
         wgZOqHGvz6GEYrWlOdbr23jnPBMXCP2xoIXaNtDbMRvcOFWGtptMMxzUjXLZjicSOvVi
         rK/sGAlSEZ3pyvQ7+9gdJiuaYAd+k17pIMk+4KbDB8OxKyswVsyoCo4OnmKZFrYzZOpH
         KaikEwZ4JJJU8BdNCaOmDrLBWn0fu+cR3nadtW+KjwcjAY4FyQXPtpCsw98pExdSmZbz
         upGQ==
X-Gm-Message-State: AOAM531RE76aAH3nk8ELlYjEzMHlKWrJ7hb0nAm2OezzV1DUacVdskhR
        kmfr2LEA5BpO+Cf600kKELIKdVlSNNT7FWPVR5a1Btb3O4PJVaX3EVQTMCP93BY7uBnbaIqj2kD
        KnhcU+2RalzJ06vBsBKzY7/oM
X-Received: by 2002:a7b:c44e:: with SMTP id l14mr1191964wmi.185.1643711810162;
        Tue, 01 Feb 2022 02:36:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwIelI3cz+7Zacd+5ZQQgX/8LYNpRzY3LsR8zgGmcKlb1QIdL+Q4hi84F8M/23d0R26+66jvw==
X-Received: by 2002:a7b:c44e:: with SMTP id l14mr1191934wmi.185.1643711809893;
        Tue, 01 Feb 2022 02:36:49 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k25sm1751285wms.23.2022.02.01.02.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 02:36:49 -0800 (PST)
Message-ID: <1a49a91a-1f6d-51c0-561b-5e5a519f3b49@redhat.com>
Date:   Tue, 1 Feb 2022 11:36:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <CAMuHMdXMayLLRavAJJujmPqT+Vd11dPfycqXie3w_pOkS8i9eA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdXMayLLRavAJJujmPqT+Vd11dPfycqXie3w_pOkS8i9eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

On 2/1/22 09:43, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Mon, Jan 31, 2022 at 9:12 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
>> SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.
> 
> Thanks for your series!
> 
> I'll give it a try on an Adafruit FeatherWing 128x32 OLED, connected
> to an OrangeCrab ECP5 FPGA board running a 64 MHz VexRiscv RISC-V
> softcore.
>

Awesome! let me know if you have any issues. I keep an update-to-date version
at https://github.com/martinezjavier/linux/tree/ssd1307

>> Using the DRM fb emulation, all the tests from Geert Uytterhoeven's fbtest
>> (https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git) passes:
>>
>>      ./fbtest -f /dev/fb1
>>     Using drawops cfb32 (32 bpp packed pixels)
>>     Available visuals:
>>       Monochrome
>>       Grayscale 256
>>       Truecolor 8:8:8:0
> 
> Oh, fake 32-bpp truecolor ;-)
>

Yes :) that's what the repaper drivers does to have maximum compatibility
with existing user-space and I followed the same.
 
> Does it run modetest, too?
>

It does, yes. And for example `modetest -M ssd1307` will print all the
info about encoders, connectors, CRTs, etc.
 
> I'm trying to get modetest working on my atari DRM driver.
> Comparing to the cirrus driver doesn't help much, as modetest doesn't
> seem to work with the cirrus driver (modified to not do hardware
> access, as I don't have cirrus hardware):
> 
>     # modetest -M cirrus -s 31:1024x768-60Hz
>     setting mode 1024x768-60.00Hz on connectors 31, crtc 34
>     failed to set gamma: Function not implemented
>

# modetest -M ssd1307 -c -s 31:128x64-0.12Hz
...
setting mode 128x64-0.12Hz on connectors 31, crtc 33
failed to set gamma: Function not implemented

this seems to be a bug in modetest. I found a patch posted some time ago
but never landed: https://www.spinics.net/lists/dri-devel/msg251356.html
 
> Does there exist another simple test program for showing something
> using the DRM API?
>

I tested with plymouth and gdm that make use of the DRM API, they do
start and I see something on the screen but don't really handle that
well the fact that's a 128x64 resolution.

I didn't test with more DRM programs because was mostly interested in
making sure that the fbdev emulation was working correctly.

Noticed that Simon shared some simple examples, I'll give them a try. 

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

