Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04801588244
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiHBTII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiHBTIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:08:06 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2286DF81
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 12:08:05 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w72so13242054oiw.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PwHROmjdSzYzm0sxl+mb0D7nS/Dpj+aOGIkG9xrIgpc=;
        b=f7Zl01K4rflUNsIJYdTnIL/qMwNba+cHm1OwmbHUKs0Uc1E/UxPLCnG4kO+M/tZ1XG
         cdM0lVuixLt7Vy6sC3Oy4JmK4FAVsibGAf1yztWBj9ZWY22Cnydya4BN0EVOXkqfiikM
         CxOH+8O72Gl6rAldJA0XveG2ofNI/WENHCl8n6nGBdbVCKr/VU7tdBwJd8iNi1uxVn39
         nYYYg5zlkfSzwL13wcXUocP8Mp/h1KjKtpwevOTvf7MIDB1/HH87w8Bge/WleyDf9ed5
         2PCB+0Q47nMjtXQ5sf42cQmfcXzp8fd71u1/EnByY9cjijv9nNTke7pett7wqIVrO705
         D5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PwHROmjdSzYzm0sxl+mb0D7nS/Dpj+aOGIkG9xrIgpc=;
        b=SiCGgCGx60M0igwtQ0kCC7PBPbLH8GR4WnFqO99V8sTMwDEHzbP79ZQR+TtOXO0jsw
         R2Aea5YnKlj2Fpr+/d84XvY+v5RI48ZHE8UhlThpJFDJuhx2djIm1K8/n9MPZQRfcEYV
         L3HtIEpKyawxI4wiax9YB+nYugPP9k9UTlT7WCbZFzeOAd90EmafQPohdA6IKsB8orJB
         14igIqLveVHKXs8pvGqI64Cp/sQ7OC/JQZZG0RxUmkG6XGNsouWW0rKy3q4IFN1FW/AF
         T4IxPeiqVNG4uuCkM0PWMaDT51OKcGHDfWra8Y9Lfw2uy8ChfdTSmen/hP5IlX+KFHcJ
         f/Og==
X-Gm-Message-State: ACgBeo38o7pBdHB9139j8/rHCTodGrhUzLiQcCEWvXGjHdQxEAZXRUiy
        NcB26O5iza8ox/uSCEgxoEe/r2CcR5DQF081ceAL4PZxCF0=
X-Google-Smtp-Source: AA6agR4m9xh2SjOXMzsI9h5tcnGbSBSvt7PbxRYPdDwV2nv8TvNJN2JhpGZUgY9peWFKAIZmgJeLe4CCMg88OH0KxJk=
X-Received: by 2002:a05:6808:11cc:b0:32e:7fc5:3a49 with SMTP id
 p12-20020a05680811cc00b0032e7fc53a49mr359789oiv.166.1659467284951; Tue, 02
 Aug 2022 12:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220731114605epcas1p1afff6b948f542e2062b60d49a8023f6f@epcas1p1.samsung.com>
 <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com> <20220803022549.cc12d4b82fb05974214f8b23@samsung.com>
In-Reply-To: <20220803022549.cc12d4b82fb05974214f8b23@samsung.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 2 Aug 2022 22:07:38 +0300
Message-ID: <CAFCwf12nGdzWUW8TZ46_wopmDGRWPLgh8hanHuPuiu6uRrqzqQ@mail.gmail.com>
Subject: Re: New subsystem for acceleration devices
To:     Jiho Chu <jiho.chu@samsung.com>
Cc:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 8:25 PM Jiho Chu <jiho.chu@samsung.com> wrote:
>
> On Sun, 31 Jul 2022 14:45:34 +0300
> Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> > Hi,
> > Greg and I talked a couple of months ago about preparing a new accel
> > subsystem for compute/acceleration devices that are not GPUs and I
> > think your drivers that you are now trying to upstream fit it as well.
> >
> > Would you be open/interested in migrating your drivers to this new subsystem ?
> >
> > Because there were no outstanding candidates, I have done so far only
> > a basic and partial implementation of the infrastructure for this
> > subsystem, but if you are willing to join I believe I can finish it
> > rather quickly.
> >
> > At start, the new subsystem will provide only a common device
> > character (e.g. /dev/acX) so everyone will do open/close/ioctl on the
> > same device character. Also sysfs/debugfs entries will be under that
> > device and maybe an IOCTL to retrieve information.
> >
> > In the future I plan to move some of habanalabs driver's code into the
> > subsystem itself, for common tasks such as memory management, dma
> > memory allocation, etc.
> >
> > Of course, you will be able to add your own IOCTLs as you see fit.
> > There will be a range of IOCTLs which are device-specific (similar to
> > drm).
> >
> > wdyt ?
> >
> > Thanks,
> > Oded
> >
>
> Hi, Oded.
> Thanks for sharing your idea. And I'm really positive on the subsystem for ai acceleration devices.
>
> Samsung NPU driver is trying to upstream now, so I wonder new subsystem can cover all of the operations.
> I'll appreciate if you share the code when you ready, so I can figure out our driver can be migrated.
I'm working on it.
I'm also preparing a small demo driver so you will be able to better
understand how to integrate a driver with this subsystem.
I believe I will be able to post the link during the weekend.

Oded

>
> Sincerely,
> Jiho Chu
>
>
>
>
>
