Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8F54EBC26
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243989AbiC3Hxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiC3HxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:53:22 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7F2B39;
        Wed, 30 Mar 2022 00:51:37 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id z10so990616iln.0;
        Wed, 30 Mar 2022 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iB4dSEsEFAg9ox27q446TXSy+mzYtY4Er+pD2+PDVBg=;
        b=oDpdH2Vm5BHkAYypGCGmfKvtGwKPS85qRwHN0oZ49oB/SBH+ynRCoRZKMzDcPME/z5
         zO2vkwktQD9AF7ydD5P5aRzs3Z5ECR4q1QHmM5kWtEBtppFOFfFzbNXHsXMFAdAtiFWV
         mvlTRE82vJ9Ymygaupp3INjc8uIJoOLoicncobStBHGbh/htZNqJSGycPB+jQAKFpzdO
         QzmjDnHBHVsPwIDVbSkFKDNWWiEHSKGHHZY+j9vS4YtEHW7cj8qPtPlHVkDPIN1ykOiq
         5hPu8FnYHfPF88ksGmt37RgGt/lXOuHX0EP6iVjSl72sD6oNWEddcQCLJ+xT2KgqG5js
         fGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iB4dSEsEFAg9ox27q446TXSy+mzYtY4Er+pD2+PDVBg=;
        b=opn8UlzfPiUHv4X+sPmdVVEX2+HZb2app4WYok9APjEvwuTjjW3JhX82U0NerWNX3c
         E3EUGUhWXjrETahpqUyZL/9ggDjGeMFxJLj8NF8lxnN3ePM9Fna4ihCoN7Asxj7mpgYq
         DI/SHrlDrjX2g3gMvwdCNc7oujNYAsktH0Mam2TvSsb5RWuEQp+kuph+PFFeKOeccdLV
         g9MxIxzZPPX5TL93MLm6qvhT/SU4rMKcgb3eJt0aUM33OsXPwnPo/0Z4FTWHrYs9/lvS
         mX/tEK93cM1bZPwD6Hk/xeVr8zeif4//badatt0TBptWs8mXLFKqXSOEtS8bjuRn+aoN
         +85w==
X-Gm-Message-State: AOAM533UvcYaqobCUpnlrSJ0PYD7yK3e9hH4np5cKcuOquOqDfHYFsSX
        eTTqu9nJhmOG7/xzUsOde4vauYs7fFvbXcryiQs=
X-Google-Smtp-Source: ABdhPJxxLLvBQX5aIBjJbJitqy7IOYbpVTWOVOXL5J7uxYwL0CqGJAH1EE1pB5MDy6EVdg+dzFI9j9k5GCXcshxiXSU=
X-Received: by 2002:a05:6e02:1c2f:b0:2c9:ac72:b4b3 with SMTP id
 m15-20020a056e021c2f00b002c9ac72b4b3mr8436849ilh.246.1648626697086; Wed, 30
 Mar 2022 00:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
 <20220327121404.1702631-2-eugene.shalygin@gmail.com> <16a36e23-bab2-4314-54ea-ff6b1011e6d7@roeck-us.net>
 <CAB95QATxYy5aj97P=S=L-kGE9dppuEbTYq=K=HGMBuZYVUBR4g@mail.gmail.com> <1239901b-9b4a-53ef-be86-1aa8337e0f31@roeck-us.net>
In-Reply-To: <1239901b-9b4a-53ef-be86-1aa8337e0f31@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Wed, 30 Mar 2022 09:51:24 +0200
Message-ID: <CAB95QAQGWRT=UsXPn65oiiwBRa1RKj61sg7wq9d7VntnFWzaOg@mail.gmail.com>
Subject: Re: [PATCH 1/4] hwmon: (asus-ec-sensors) introduce ec_board_info
 struct for board data
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
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

On Tue, 29 Mar 2022 at 22:28, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/29/22 12:22, Eugene Shalygin wrote:
> > On Tue, 29 Mar 2022 at 15:44, Guenter Roeck <linux@roeck-us.net> wrote:
> >>>
> >>>    struct ec_sensors_data {
> >>> -     unsigned long board_sensors;
> >>> +     struct ec_board_info board_info;
> >>
> >> Please explain why this needs to be the entire structure and not
> >> just a pointer to it.
> >
> > I marked the board_info array as __initconst assuming that this large
> > array will be unloaded from memory after the init phase, while we keep
> > only a single element. Is that assumption incorrect?
> >
>
> What happens if you build the driver into the kernel and then instantiate
> and de-instantiate it multiple times ?

Sorry, I have no idea because I don't know how to load a built-in
driver multiple times. But since this driver is attached to a
motherboard device, which is persistent and always single, do I need
to consider such a scenario?

>
> >>> +static int sensor_count(const struct ec_board_info *board)
> >>> +{
> >>> +     return hweight_long(board->sensors);
> >>> +}
> >>
> >> This function is called several times. Does it really make sense, or is it
> >> necessary, to re-calculate the number of sensors over and over again
> >> instead of keeping it in ec->nr_sensors as before ? What are the benefits ?
> >> Unless there is a good explanation I see that as unrelated and unnecessary
> >> change.
> >
> > This had something to do with data deduplication. However, I need the
> > count value only for looping over the sensor array, thus I can as well
> > add an invalid element to the end of the array. I rushed to submit
> > this driver to replace the wmi one, and it still has an artifact for
> > the WMI code I'd like to get rid of eventually, which is the read
> > buffer and the registers array. This will remove all the nr_ variables
> > and two dynamically allocated arrays. I will understand, of course, if
> > you ask to submit that refactoring separately.
> >
>
> The rule of "one logical change per patch" still applies. If you start
> intermixing parts of future clean-up efforts into current patches, you'll
> see a very unhappy maintainer - especially since this change makes up
> a significant part of this patch, complicates review significantly,
> and makes me wonder if other unrelated changes are included that I don't
> see right now due to all the noise.
>
> Besides, at least in this patch, I don't buy the "deduplication" argument.
> Keeping a single additional variable in a data structure is much simpler
> and straightforward than calling hweight_long() several times. I'd call
> that "complification".

OK, I'll roll it back until I remove the other size variables and arrays.

Best regards,
Eugene
