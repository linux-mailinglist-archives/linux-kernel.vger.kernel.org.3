Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F073A54F81F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381870AbiFQNHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381727AbiFQNHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:07:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F23D33881;
        Fri, 17 Jun 2022 06:07:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id v1so8642836ejg.13;
        Fri, 17 Jun 2022 06:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=EgM/55Bgwb9NtXmPkvIN9CBkEmMtdD1Usod399h4Ozc=;
        b=Q/4P8EcCJYN+Jn5qumvRFCk34bxXni1uSse9Q7QPgKp+LyCC08tupqcVEPz054rkNv
         vg+HwrK/XDi7cIQPG+o37RXNhrb9o5J+7Hr+d/LmVpn+KWZlY4ZIYag7cqePLcNaPfpl
         ftLkmtoqGF5fL3t2luEa5OYcnWJRUXtaovnZS9fKKom1A2wLA7AXAg8seq/64l5mHni0
         8dtp8R90x9z95qxmqCwNvAe9ir7Tt/HbfX5PJINe9AucrFepvr5u7gid2n59ZdmRZii7
         IeIyPHgI2dWFE/cW9KhygO46XyoYWxm/JXzE1Q7Ya/9q6zBELlvXCCdpCOhMIfg9Lfmr
         aBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=EgM/55Bgwb9NtXmPkvIN9CBkEmMtdD1Usod399h4Ozc=;
        b=Kb2MXwYz2XA7D1JgD9wxC+6IXKmHQ3v6gSQeTa9kihaQY4w41mk2mp0lcPT93x5AHq
         MFxflcu47mONxD/dcm4avajEcNsLnEF/ycydaeAdnVSkmahrEZwvZAfgFWuU4cX+rx14
         GDy5HQTNS2wUNAZS5q+lx20ywYJmJhnv/jtxZF3d234ME1N4EamwDZsh21cWJsdBSozu
         6TIkBB2E9Sh1K0YTwKowb+O2JzBVAhKrva1znn3zyhYoQsFc0aEZxSsXNYt5TO4CR4ZH
         9HhWYlZHzXU+EnYvosI9CWM2mnXryL4vHEQNDV9qB0UtpHOnaRENkgBT7QyrD6OJGEjw
         A0TA==
X-Gm-Message-State: AJIora+UDsc9YCPkPSqYd+jb4J+fwVnrZo6cW1tIozsOQJ4LY9j/F/st
        LepqOT+gssYTnsro03PkW/s=
X-Google-Smtp-Source: AGRyM1s5eS9OJhUK1yYzMMOiQnlTWeu/qJ2WtRUmKrArXBadtAWB0It61i5HZXsA9CJUHpnSYTe9mw==
X-Received: by 2002:a17:907:6e02:b0:719:2c77:37ce with SMTP id sd2-20020a1709076e0200b007192c7737cemr8659054ejc.759.1655471250003;
        Fri, 17 Jun 2022 06:07:30 -0700 (PDT)
Received: from [192.168.200.12] (p5790330e.dip0.t-ipconnect.de. [87.144.51.14])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b006fea2705d18sm2155582ejf.210.2022.06.17.06.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 06:07:29 -0700 (PDT)
Message-ID: <89398c05-92c6-120d-ed51-ab62f1f404eb@message-id.googlemail.com>
Date:   Fri, 17 Jun 2022 15:07:28 +0200
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
From:   Stefan Seyfried <stefan.seyfried@googlemail.com>
Subject: Re: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all
 hotkeys
In-Reply-To: <5f03f5b9-87bb-e27d-ce51-9c1572221f21@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 17.06.22 13:07, Hans de Goede wrote:

> Thank you for providing this info. Can you please give
> the attached patch series a try, this includes Stefan's 1/2 patch
> and replaces Stefan's 2/2 patch.
> 
> This will hopefully fix the double key-presses for you, while
> also keeping everything working for Stefan without requiring
> a module option or DMI quirks.
> 
> Stefan can you also give this series a try please?

Works for me, almost out of the box.
I need to enable "report_key_events=1" in the video module, then the 
panasonic-acpi module starts reporting brightness up/down keys.

Volume and mute keys work without manual changes.

(I tested against 5.18.2 because that's what was already prepared. That 
old machine takes quite some time, even to just compile the platform/x86 
subdirectory ;-) but I don't think this is relevant. If you think it is, 
I can also test against latest 5.19-rc code)

> Looking at this has also brought up an unrelated backlight question:
> 
> Kenneth, since you have acpi-video reporting keypresses you will
> likely also have an acpi_video (or perhaps a native intel) backlight
> under /sys/class/backlight and I noticed that panasonic-laptop
> uncondirionally registers its backlight so you may very well end
> up with 2 backlight controls under /sys/class/backlight, which
> we generally try to avoid (so that userspace does not have to
> guess which one to use).
> 
> Can you do:
> ls /sys/class/backlight

toughbook:~ # ls -l /sys/class/backlight/
total 0
lrwxrwxrwx 1 root root 0 Jun 17 14:45 intel_backlight -> 
../../devices/pci0000:00/0000:00:02.0/drm/card0/card0-LVDS-1/intel_backlight
lrwxrwxrwx 1 root root 0 Jun 17 14:49 panasonic -> 
../../devices/virtual/backlight/panasonic

> and let me know the output?
> 
> Also if there are 2 backlights there then please do:
> cat /sys/class/backlight/<name>/max_brightness
> to find out the range (0-value)

toughbook:/sys/class/backlight # grep . */max_brightness
intel_backlight/max_brightness:19531
panasonic/max_brightness:255

> and then try if they both work by doing:
> 
> echo $number > /sys/class/backlight/<name>/brightness
> 
> with different $number values in the range and see
> if this actually changes the brightness.

intel_backlight: does not work
panasonic: does work

> While we are at it, Stefan can you do the same please?

See above.
But hey, this is an i855GM graphics chip, I'm happy if it is still 
working *at all* (for example I need to avoid the xf86-intel driver and 
use the modesetting driver instead to get a usable sytstem)

And I'm totally happy if all I have to do in the future is a

option video report_key_events=1

modprobe.conf file ;-)

Best regards,

	Stefan
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
  public relations, for nature cannot be fooled." -- Richard Feynman
