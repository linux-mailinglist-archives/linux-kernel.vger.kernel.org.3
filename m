Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5191D49BA82
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiAYRjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355493AbiAYRii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:38:38 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE71C061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:38:33 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id m4so32208214ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ElAqA9onDrcE3b1LB/Qm4CeXxIULTeYtlnRjkAHHhdU=;
        b=DbQzrWW6/5E1N8I7oC6Cqdocm71AzBfAUnV9GmIHGyNV7ENE839MSWXYnKDCjF94vh
         X+RIlrItMTvOMac3eC/mdgrlbfNctpuSJwjLWpHP6cfqvbNQca+2T6cDM7LOKI4QmU5A
         hR5zDxT7XC2lliZcVbxf3tStAK0bMvRz0M8SAMyjYsDC4PG4H2L79kD9R0ixht+Sgo/7
         opFm3ii9vfzKhW19IaYDh3I2mA6s67SlzplXa5q0FJf/SZv2uhRv1fb2UKnM6mnIx1qG
         +N9izoRE9PMWYAdTkRbUZL9+rAf57B88A5o5jaaOIPnOEC76BhUk4qe/kwHt67m8HW5j
         VYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ElAqA9onDrcE3b1LB/Qm4CeXxIULTeYtlnRjkAHHhdU=;
        b=k2ziZL8qnK15jwo0QB9DDXfP4ox645RMarHW1OQAidFcpnHn50VcWdj+rVmCsNP5fN
         +LBAl4hVXNVrYBY115Gido6fEx7Xrw4gBSdmBY+xCeb9H9MWaUCHmWEYyrtK+x/VjxsF
         FbgOYaE4bp83uQUaIOaTAr53kUF+3nyIwuKxNbQCtiEt99E4Xztt8O66nd2QsUC4fG5U
         hDnOySdyTCQPmqjtKxaggxYo8FH8V/CViZvHDWkBocODlmLK3rEkpZRMIlEh6Zjcq34T
         OmTUF2RUYl60srDF3ofqBlNK/hEWpydvKLVs17d/SCxKKSX6320wbQ9vrMrO1DFloEyt
         8rNw==
X-Gm-Message-State: AOAM533anmeeE7k1Jz/ML4FXsH5LG3onULEERKAW05K/hBy+9pMDX632
        260uxgTxm567tI2Pum0QNhXUcnsLhNtYZoXNWC9DMtFoVJ8=
X-Google-Smtp-Source: ABdhPJwrmXjjCaTHpFggSQNjOGEPkhBSh8aztCxr0XWin1xIFuUNzdgHDgDk83HhUs0z2Pz/fPK6obyBtboVDI8MOLo=
X-Received: by 2002:a17:906:5d0f:: with SMTP id g15mr16847415ejt.670.1643132311941;
 Tue, 25 Jan 2022 09:38:31 -0800 (PST)
MIME-Version: 1.0
References: <20220105031242.287751-1-dustin@howett.net> <Ye8RaQcIuR6kpaYj@google.com>
 <CA+Px+wV8Ygz3n=4TtX1F6YB3Gcz8amNmotru09ftn9w776nDuA@mail.gmail.com> <CABXOdTdyHWNckqmB9Ya2tZitghdxPuhNGSXdrLYZPU26w4JO=g@mail.gmail.com>
In-Reply-To: <CABXOdTdyHWNckqmB9Ya2tZitghdxPuhNGSXdrLYZPU26w4JO=g@mail.gmail.com>
From:   Benson Leung <bleung@google.com>
Date:   Tue, 25 Jan 2022 09:38:20 -0800
Message-ID: <CANLzEksGAdewMRz1kLCXdn2dBtTpgkELq3LZgs+UbpwZ4UHzcQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] platform/chrome: Add support for the Framework Laptop
To:     Guenter Roeck <groeck@google.com>
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        "Dustin L. Howett" <dustin@howett.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Tue, Jan 25, 2022 at 8:52 AM Guenter Roeck <groeck@google.com> wrote:
>
> If nothing else helps, you should be able to find and download the
> series from lore.kernel.org/lkml
> (https://lore.kernel.org/lkml/?q=%22framework+laptop%22). Long term it
> might be useful to set up patchwork to track cros related patches.

I've inquired about creating a patchwork for chrome/platform.
Definitely agree that this could be organized better.

Benson

>
> Guenter
>
> On Mon, Jan 24, 2022 at 5:13 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
> >
> > Hi Benson,
> >
> > On Tue, Jan 25, 2022 at 4:52 AM Benson Leung <bleung@google.com> wrote:
> > > Tzung-Bi, could you help take a look at Dustin's series?
> >
> > Pardon me, I didn't subscribe LKML due to it is too noisy.  Could you
> > also forward the 2 patches?
> >
> > I will try some magic
> > (https://chromium.googlesource.com/chromiumos/docs/+/HEAD/kernel_development.md#Downloading-a-patch-from-patchwork-into-IMAP)
> > to get the mail thread.  And subscribe LKML to get further patch
> > series.



-- 
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org
