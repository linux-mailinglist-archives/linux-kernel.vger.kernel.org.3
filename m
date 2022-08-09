Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6CE58D5D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbiHII4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241354AbiHII4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:56:10 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7341B22528;
        Tue,  9 Aug 2022 01:56:05 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f14so8268618qkm.0;
        Tue, 09 Aug 2022 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=75TNeFMMpab+IwYWg9NpTmY1Fu4fM7V/Fo0v6i5Keis=;
        b=lS49Pz3UTnt0lCgaLlSuJxGNgkqjSHeUMWJpOaDeozdQwgNY9/02hcuZXbKdTUcByN
         7d1GnrJY7mH55d/HaEGkuCC0ls0yn+t+lO7TF91UZcRLGmFX7l8RoBLY9I+Ud9zSrQqP
         G2vnDev7yIinbO3EIKmL591jNZG06M+0dmiIco2wg/nyZlNJ5AZzDGOt9SEbaBprItci
         9r2HiTZRXqa7DIwpiqhMkuIjGrH3E2BHB9TBWIeBd08G04aqvclkpEswCajScuBKX22o
         YvuPDgedgsuyaUfQS1eOG7A/0K11lMBpRSTJC7vGtO49rFAPTsQH2I5Klau4znC4OkJJ
         FS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=75TNeFMMpab+IwYWg9NpTmY1Fu4fM7V/Fo0v6i5Keis=;
        b=4NSz8PU6a/Pq7Lsw95NIDd0TCVaQe6TcsldwZOBjXIQcikzO5RpM3Fn7mQyo9xUK9j
         R8oVlzDDgFJnLrqZdRZEjK/HrtvI80jtIw4lYSX1PS6W6+jq/GRFbKD7fcMx64jvMFNS
         HbH1Yvr9sMIQZywXYwg9hOchdxxT3Tmxa+vcvRp2vAs3Mo3o40k7ntP5ilGVFfqzH+wb
         5dF/t+4oAF0EvWco9vUByccM15w6BXbSRB7fRYfWDqCD14CKnh4KodM2JTb+4YiZ6+a5
         nLfQQWV/WHzjfW4uSK9GuPX6MM79NJJzvNeueTeyhOaWbMeAbhNFIxBWVuC9OPi4v0yH
         Ou4g==
X-Gm-Message-State: ACgBeo1h9FLl5t6Hfd+KG2PxprS7aMgPnYBXSwkUNclvY+f0y7Fap7xi
        FZR5vfmUCNB6JyCu8A/7J/cJlKBPHqp7DUaBhjA=
X-Google-Smtp-Source: AA6agR5t1GC5ORK3nJwJ115jDEo07Q9g8lRIvEbVuHL73i8BQvWWcVFjlKulF2OPbmSHgyVvFiWFTx1BNLksMnlw2hw=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr16861453qkp.504.1660035364351; Tue, 09
 Aug 2022 01:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220809025054.1626339-1-luke@ljones.dev>
In-Reply-To: <20220809025054.1626339-1-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 10:55:28 +0200
Message-ID: <CAHp75Vd2vO-V5P8QeLwoz+1RCaFuAg=q8LenKGZcdL920NRkrQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] asus-wmi: Add support for RGB keyboards
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Aug 9, 2022 at 4:51 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> This is a patch series to add RGB support for ASUS laptops.
> The laptops with this RGB tend to be the TUF series of gamer laptops.
>
> The first step is initial bringup of support using the multicolor LED API.
>
> These types of keyboards implement a slightly more complex interface than
> just RGB control however - they also have modes with can be static LED,
> blinking, rainbow, color cycles, and more. They also have some custom
> animations that can play depending on device state, such as suspended
> playing a fancy colour cycle, or playing a "wave" animation.
>
> Two of the patches add support for these features.
>
> One patch adds documentation in:
> Documentation/ABI/testing/sysfs-platform-asus-wmi
> for some features that were added previously.
>
> The final patch adds support for a particular MUX switch found only
> on a few ROG laptops. This patch is added to this series due to some
> conflicts in merge caused by the RGB patch series.
>
> Some notes:
>
> - this patch series obsoletes the previous RGB patches by myself
>
> - it is not possible to add attribute groups to multicolor LED as
>   they get overwritten by `led_multicolor_groups` in
>   `led_classdev_multicolor_register_ext`.
>
> - the methods for RGB control do not provide a way to fetch exisiting
>   state, so these methods are WO.
>
> - There is an existing `asus::kbd_backlight`, this provides a 4-step
>   brightness to the RGB (off,low,med,high) individually to multicolor.
>   I was unsure of the effect of adding a similar path so have used the
>   `asus::multicolour::kbd_backlight` name to be clear about purpose.
>   If the `asus::kbd_backlight` is off, then no RGB is shown at all.

It seems you send too many new versions of the series too fast.

Submitting Patches [1] suggest one week gap between series. I would
recommend reading that document in full and carefully to understand
the Linux kernel process of proposing and submitting changes.

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#don-t-get-discouraged-or-impatient

-- 
With Best Regards,
Andy Shevchenko
