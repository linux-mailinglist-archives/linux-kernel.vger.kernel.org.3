Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F38534EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbiEZMCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiEZMCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:02:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DCFC8BEC
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:02:40 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h13so1525437pfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 05:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=83qsgRrIHOn2RSbwDsfrRxuBXw3apvQPm7JZl44Kav4=;
        b=O7j7RgMIDxEyauRoBqv46L6OxDslw86kOtq4JcWBN0WQWYndBfKPRlXE5MupB3YSP4
         puX6G/Qp+y1wStHgi8q0ncU/U7HMbVAk124D/8Bw8/ktk7YdTYnCjSkZIdDrSkratO1+
         5HlZGcz3dFzPq7k0E8MgXw+Lzgl8HUomCOui+xdsmVPYboqB3ldcell8VoDwfjuobYcz
         YjEcUTCzfB5oAd4+RLI5eMp3PdTDEYbGDp1lXYjkNWDhAkGy3PdgVKm4C6tvjykR+sMX
         KeOXZaIXvHr+zDolJmz0FVYFfnIPyZNrR30xadjhwIOr8d7u8vC7gy+6qxtBtwKUwKYu
         /5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83qsgRrIHOn2RSbwDsfrRxuBXw3apvQPm7JZl44Kav4=;
        b=b3kwMQ8PZcaMZGSfHQMPULAkuRVkAcLggJddRozDllBy15VNyyHfmxQBNUvaKcwxIn
         0siwvCkayjYO6In/Spj02JXdxwpN/Ysm+aXJxYaCcLWTs4/f3ocBgx4GTXW69nQZ3vVB
         r+AbV6geAfmTH8vmN35KXvwb6PTTi4603rbfv2hP3qmSs5Zu9h+xx63686C8swC2zX2E
         B+xlsUtBp9a6MMs8OyM0NZ3/bbabB0vGXQ9drWwHni4zOT3Biv33SSt4grzfMTN3VuMk
         g/4HHi8e2HqXBp7XJX7h/K2YPPUSRrtpDNrI6DMxFsLPiFrT9pq0/8g6f83YwhrVmng3
         NzFQ==
X-Gm-Message-State: AOAM531E8IzHfnuMEzrWzQ06N7HzYnW+bH1LL5T6HF9DBsGRn8KumzEZ
        QUbpAL6gehZMfqZaAxc2tPJyrCv2BzMzTshH1g==
X-Google-Smtp-Source: ABdhPJztL84+s7XSysrxuOWWPlqTmfeaaJCotiYXEiVt+StmbnYBKL+zWXUA4kE5KG8msdXJMia4E5K36wTR4HytGC8=
X-Received: by 2002:a63:4525:0:b0:3db:8a4d:8a77 with SMTP id
 s37-20020a634525000000b003db8a4d8a77mr33354669pga.542.1653566559987; Thu, 26
 May 2022 05:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <Yn9XwHxWsLIJXlHu@kroah.com> <20220514114819.2773691-1-zheyuma97@gmail.com>
 <Yn+va5fTsuaFTxVR@kroah.com> <CAMhUBj=RMJwn2K+rQC9rQ=QEe5QkiJ29rMd8KzEC8B7vtXo+ug@mail.gmail.com>
 <Yocp+WZ0On9/wObu@kroah.com> <CAMhUBj=J5-V_D_kucpiWz6ZdOSSR1N9nRXQxOKgmwRA+LxW17Q@mail.gmail.com>
 <YouxHY48daZt7J/O@kroah.com> <628BBEEB.9010306@gmail.com> <YovBOwJs/A/5Ua7I@kroah.com>
 <628CCE44.6020007@gmail.com>
In-Reply-To: <628CCE44.6020007@gmail.com>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Thu, 26 May 2022 20:02:28 +0800
Message-ID: <CAMhUBjkv-i360rk4NRrMXYoo9u8_UbCzY-mEsd5dybMizTJJQg@mail.gmail.com>
Subject: Re: [PATCH v2] char: xillybus: Check endpoint type before allocing
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 8:24 PM Eli Billauer <eli.billauer@gmail.com> wrote:
>
> On 23/05/22 20:15, Greg KH wrote:
> >> Rather, it works like this: The driver uses the EP 1 IN and OUT endpoints to
> >> >  query the device for a data structure, which contains information on the
> >> >  device's communication channels. The driver sets up device files
> >> >  accordingly, and it also gets informed on which bulk OUT endpoints are
> >> >  present.
> >> >
> >> >  For what it's worth, I think it's fairly safe to assume that if a device
> >> >  returns a legal data structure (which passes a CRC test), it's a XillyUSB
> >> >  device.
> >>
> > Why?  You still need to verify that the requested endpoints match up
> > with what the device really has.
> >
> OK. So to summarize:
>
> EP 1 IN and EP 1 OUT are always present in XillyUSB devices.
>
> On top of these, there might be additional bulk OUT endpoints. The
> driver resolves which ones in setup_channels(), by scanning a data blob
> it has received from the device. This takes place in the for-loop inside
> this function. When (out_desc & 0x80) is true for a given @i in the
> loop, the device has a bulk OUT endpoint with address i+2 (e.g. if this
> condition is met for i==2, the device has a bulk OUT EP 4).
>
> So it seems like setup_channels() would be the right place to make this
> check, since it's called during the device's probe.
>
> I guess it would likewise make sense to check for EP 1 IN and OUT in
> xillyusb_setup_base_eps().
>
> Thanks,
>     Eli

Thanks for the detailed explanation, I will try to send a new version
of the patch to fix the bug.

Thanks,
Zheyu Ma
