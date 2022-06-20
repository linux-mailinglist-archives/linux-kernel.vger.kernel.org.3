Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC0A5520B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244034AbiFTPZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243945AbiFTPYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:24:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E702DC4;
        Mon, 20 Jun 2022 08:21:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kq6so21771440ejb.11;
        Mon, 20 Jun 2022 08:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uoD4CohKeFKAdzz/7CKztb2Hub8lOJ4GYMuhlqlAhgY=;
        b=QmzpYUjrtva5X/XApH8CqKDt+tO0hWQclNzbj21drpdHVAo+cFhzyDSNwZaUtv2ggc
         ZYCVsXIMwOJwFeYsT/C8k2ew+tBiPnjhS8vumlzfr7dtfMlelT8YwwnHYSUPZMgUuqV1
         EqEZR5DFBCCV6UAFOmrFR8kAQJI0MYlg6mBf1+MR9BhoqzjDWbj4dCrG+sPG0olRNVTa
         6Y3jBXz3fDGHdm/KAf7zb+bdBOfwDn6pSrCJn/DUW1NALV1I2D3yhPTUuPLRxJvg3OjT
         ZCO2aiDM4yYVbRwn/V/UBO4eeo7r2xL4Qvstr3q8ivJF/sQG1SedP7SvoxNryCbCwq5C
         lAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uoD4CohKeFKAdzz/7CKztb2Hub8lOJ4GYMuhlqlAhgY=;
        b=lQQwkCE4Xig7j9zCpPYhybkCygHLFtDiPLBWGwWsIWsmIE5q+ZG3jRoho74t8dPpqV
         Og32hHJsJpMhn7NUVpLqnpQZenN6iO4aigorYPaJh72k0K8fQ9RgbzX+zw+Go24Quy4y
         H1lqWrDfyAUCfEI7svsg2AcPy/Fi2DGbapY/09T8qmc5nDHO0YVZQz9huGaetW6Rye7h
         N5WMKpm53t2OJGKYISdB7n8ctUy0ClnFbYUtwKwfMTneMc6yfCcKRvdb4coPGHMJ0gIM
         JRXelkLi7SqbZFIKFZSF7fVRaokImPWhjmdRLDH6SUWmemdpBdf0ltQ9gJkEc+V7xeSg
         AfNQ==
X-Gm-Message-State: AJIora+4dynu6h8SHtAZJvgZrqCEZ379IqSuFKCCoDYynCc0MwxT7i2/
        fuk5SevoCSMGVyg3TUd27yyDgVBBDutqs02SRpeqTofH2yknbw==
X-Google-Smtp-Source: AGRyM1tsNJoOGpYiy9dfZ3YVF9KOarwDGw8L6HH59odagQ86io0le2zIpjnitfXnUcEIodk45PEuagnQJWVEn+Pc9Kw=
X-Received: by 2002:a17:907:6e90:b0:711:cb3c:8c1a with SMTP id
 sh16-20020a1709076e9000b00711cb3c8c1amr22207187ejc.516.1655738517835; Mon, 20
 Jun 2022 08:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200821181433.17653-8-kenneth.t.chan@gmail.com>
 <20220612090507.20648-1-stefan.seyfried@googlemail.com> <20220612090507.20648-3-stefan.seyfried@googlemail.com>
 <CAHp75Ve+vrfSu6pD+AKe-eCVA2pC5o520y4gVwLNg9Dtk0U5bw@mail.gmail.com>
 <CAHp75VdFPUHTeDBY5ukFgVqJJn7BbTHxrxKUGOLB6P1UX-utAg@mail.gmail.com>
 <d80789bc-a8fc-de5f-164a-75adf7097311@message-id.googlemail.com>
 <6969ca0e-4a4c-c995-02a2-6645f875338c@redhat.com> <CAPqSeKu9csK_u0S6MiRay_mvfYejUhKbb=wvJO7F_Z-JL6F7DA@mail.gmail.com>
 <5f03f5b9-87bb-e27d-ce51-9c1572221f21@redhat.com>
In-Reply-To: <5f03f5b9-87bb-e27d-ce51-9c1572221f21@redhat.com>
From:   Kenneth Chan <kenneth.t.chan@gmail.com>
Date:   Mon, 20 Jun 2022 23:21:20 +0800
Message-ID: <CAPqSeKtqORkhW4dAMsd2b6e3OwhHZ107znwJtoBADE1h2-dsVA@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86: panasonic-laptop: allow to use all hotkeys
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Seyfried <seife+kernel@b1-systems.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It took quite a while to do a full compile, just to be safe.

On Fri, 17 Jun 2022 at 19:07, Hans de Goede <hdegoede@redhat.com> wrote:
>
>
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

root@jaguar:~# ls -l /sys/class/backlight/
total 0
lrwxrwxrwx 1 root root 0 Jun 19 17:26 acpi_video0 ->
../../devices/pci0000:00/0000:00:02.0/backlight/acpi_video0/
lrwxrwxrwx 1 root root 0 Jun 19 17:26 intel_backlight ->
../../devices/pci0000:00/0000:00:02.0/drm/card0/card0-LVDS-1/intel_backlight/
lrwxrwxrwx 1 root root 0 Jun 19 18:48 panasonic ->
../../devices/virtual/backlight/panasonic/

>
> and let me know the output?
>
> Also if there are 2 backlights there then please do:
> cat /sys/class/backlight/<name>/max_brightness
> to find out the range (0-value)

root@jaguar:~# cat /sys/class/backlight/acpi_video0/max_brightness
20
root@jaguar:~# cat /sys/class/backlight/intel_backlight/max_brightness
6375000
root@jaguar:~# cat /sys/class/backlight/panasonic/max_brightness
21

>
> and then try if they both work by doing:
>
> echo $number > /sys/class/backlight/<name>/brightness
>
> with different $number values in the range and see
> if this actually changes the brightness.

/sys/class/backlight/acpi_video0/brightness: works
/sys/class/backlight/intel_backlight/brightness: works
/sys/class/backlight/panasonic/brightness: does not work

The mute, volume up/down keys are still duplicated by atkbd after
applying 0005-platform-x86-panasonic-laptop-filter-out-duplicate-v.patch.

--
Kenneth
