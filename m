Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59024655F4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243512AbhLATBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:01:02 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:45024 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244948AbhLATAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:00:08 -0500
Received: by mail-oi1-f175.google.com with SMTP id be32so50458545oib.11;
        Wed, 01 Dec 2021 10:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7uVa5rdjojc69V9+uq1AMFnV873CecY+4zRxvlTtQcI=;
        b=6ZEfrR7vPPjWhkzt11EPwwhf5207Ge0g89TS/FCNfkQbqvQ9UuXtbfeCc4s7xvYLFW
         ur4O7DQwLJpm60WvuC+mqAsB5J2SKRpM0sRhr2fOX8C/5EAzQvF4Ei+v+kN+yiLcMT7/
         5J6TPAIxZRKngmvpqawqhPbHSxB8JBcy3f/E55iirObYVSwLFYDim/93x8DNno+VfRwr
         T8n0Ulimji+53F+AZmbp8SmvXntenPKRBabnyhJPizqQvo0IExxceAdSrtPN8VYAMHLO
         8wUkYlfX83DnHhQUPLlPJX/WhKOV9gDR/4Q+dSEH+locoSLNy4WCGs5GPvFvE9xydMJv
         LKsQ==
X-Gm-Message-State: AOAM532ipJz96mC7BAOdl0RyWJTUkTZJPGr6r+VNTLBogR7tvT0RYS69
        qSTLMUHwsgnXxrsfWeJL5aPkcXutAYLHbvTFZ6g=
X-Google-Smtp-Source: ABdhPJyG1ztPHyDpU3JFkK9bLtyyRHLsgCm5rpXgbx728MdM86g1AHwcYqs0JS/af8RzKFOjdk2Mi9W+zyXH/Fa6+zk=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr49555oiw.154.1638385006835;
 Wed, 01 Dec 2021 10:56:46 -0800 (PST)
MIME-Version: 1.0
References: <9821f60a-c562-12e8-bdd4-45dbfe88a117@linaro.org>
 <20211126230820.3441863-1-daniel.lezcano@linaro.org> <9e81f795-6d3a-2078-5ef1-13b965e89a2a@linaro.org>
 <CAAYoRsWEXoe_LjuHuQUL3Tdov0JVW887T4ciUTVOC410mZjgvA@mail.gmail.com>
In-Reply-To: <CAAYoRsWEXoe_LjuHuQUL3Tdov0JVW887T4ciUTVOC410mZjgvA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Dec 2021 19:56:36 +0100
Message-ID: <CAJZ5v0j66jEyooFTcPxv0NaxWGiuQT9Jm7gyB2NAj_HaFeXAgw@mail.gmail.com>
Subject: Re: [PATCH] powercap/drivers/dtpm: Disable dtpm at boot time
To:     Doug Smythies <dsmythies@telus.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 2:13 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On Fri, Nov 26, 2021 at 3:10 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> >
> > Hi Doug,
> >
> > I was unable to reproduce the issue because I don't have an x86 platform.
> >
> > Is it possible to check if this fix is ok?
>
> Hi Daniel,
>
> Yes, confirmed.
>
> Tested-By: Doug Smythies <dsmythies@telus.net>

Applied as 5.16-rc4 material, thanks!
