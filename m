Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7793758B4BA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 11:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241718AbiHFJLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiHFJLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 05:11:16 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C326C11444;
        Sat,  6 Aug 2022 02:11:15 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id v1so3391459qkg.11;
        Sat, 06 Aug 2022 02:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=OyNhF+/iNDq42RbrxdI9AZGi2xTvjwS+AGArGbGORH8=;
        b=qmuSA/QiSnTOrBjeVeODx0lTDUD3Zt6ogtSPcxLot5MpTTao6J7qfkOctGuvz8pBOX
         tRarzLwW5KZHtYOdrUNjEHtj7kVnXLD3N1MkeFzTYcTNOUZ0lC6vRb0pOhwBt3pK9LcU
         MecGzNEnR5wYWSz7G2XOqGO773tWC5O88bo7h93bf1Sst3oVS5nizFb2hEjpbZyco2Y+
         afDOPvCTfWg5WZ0/qSQPA18D4B8QCXjD9r62WyTPwTTAUtatKnPocO/SMToMCWUQYOo5
         x01UlWrPtRbF9IX2MixH230wfNtsBJtrkcqhZ8LngzZ9TVwuGaEMh6QtI94zKVZrTUWK
         9j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OyNhF+/iNDq42RbrxdI9AZGi2xTvjwS+AGArGbGORH8=;
        b=oldTWf4MXpvNmongzRQtdVVCFqQXpGGBAW/nTOOFoN+9r+YEFpRp39cbGKeVOD7iel
         qGqtFyozjV94RHhuuYNcXIy6e3gBgn32ODgzBqYW6NOqzwo1sxa5QljcYL9sqe9ULB8X
         C3vXlzo/uuLP+lTi+2+PbY0L1By3cnNzL+sXS16fM4QUyfHT19BW8kCZ1/WYtkUUvsCN
         5G8K7zIg5nbTkR+Gnlv2MHkQeWdaDIDXNffDb+BARQfjljaQCWr7xcG9mKF5teCiFFFx
         s9CohSYKnUk1S1Ns+7/kduW/nglZgOELCoPz9KPKVHn3lsG0xWEJTT8KiH/A8yjb5vwu
         tZuw==
X-Gm-Message-State: ACgBeo3MAQs4BlgoUROVOfnNXXnyukJ/H7PsirmV8pmGLI09d93DZ+fh
        ENIwcqIlEBzRWlkpR9F2zbSbXAKwtwWFNMDSvpgWZskbTwI=
X-Google-Smtp-Source: AA6agR5ecdGULw8hkfvDEGFbkfLs8QFQMgthdPBCmTg7FkGoOHmAJp3VJdgjUkoaiu2vm9E0y/8PzDmSt+ICssAXSls=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr7911507qko.383.1659777074815; Sat, 06
 Aug 2022 02:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220805081909.10962-1-luke@ljones.dev>
In-Reply-To: <20220805081909.10962-1-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Aug 2022 11:10:37 +0200
Message-ID: <CAHp75Vd4iEGkAE1Ds_Zyqi0P+gQbOyqvGoJctpOHNmMD7cUG0g@mail.gmail.com>
Subject: Re: [PATCH 0/5] asus-wmi: Add support for RGB keyboards
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
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

On Fri, Aug 5, 2022 at 10:20 AM Luke D. Jones <luke@ljones.dev> wrote:
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
> The last patch adds documentation in:
> Documentation/ABI/testing/sysfs-platform-asus-wmi
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
>   If the `asus::kbd_backlight` is off, then no RGB is shown at all.\
>
> I'm hopeful that this patch series addresses all previous feedback related
> to the obsoleted patches.

There are so many patches and versioning of all of this is completely
broken. You really have to clean up the mess and realize what version
of this is. To me it looks like this series is v5 or so of the
previously sent patch(es). Also you missed the changelog between
versions so we can see what you have done from vX to vX+1 for the
whole range (1 ... X+1).

-- 
With Best Regards,
Andy Shevchenko
