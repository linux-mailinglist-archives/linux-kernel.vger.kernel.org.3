Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B21A49B970
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356301AbiAYQ6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354980AbiAYQzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:55:54 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD97C0613DE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:52:26 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id p12so64528537edq.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZsW/6ybQopovf9cIbQnk8SDIfcT/L4J0YssZ40jQ2Mk=;
        b=dYdFquldT0TZRb4aE/uo+pg40BmhfOCZhfoL4cvBONq4ntcIo0FSaZIiM52h/OJpsF
         LgmSQAfdQbRSrZX4yqK99CW4ULsyTYhlwaOvOzN9rD8WhzPShzleJC/L1zzbLsCqeVXA
         tXVO45kmsPKSY0519tHd4u/6ALRGDBv/mWcjepzdKpAjHIh8Mfpfqb6a2ckQn5fIQZWp
         TVzqnUzpKu5Wiz6vAqGz8lTdkeme4tTiyXvYPUdMray3i3W7YGuBDhlKllTAfC5T8sow
         uc2fwWBn4j//vogd8x8FPym1OPD5f4hi3Ed4cWgGr6fZsv0sApuaPi1N98G8x4As6Qaw
         zTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZsW/6ybQopovf9cIbQnk8SDIfcT/L4J0YssZ40jQ2Mk=;
        b=K8R7V7tDrhUUleZSO7VucFd+PFJr5Q1kAgeIxY4Yba2gU9efO7pIcm4WJ21MmYaw3b
         U005mhEaHT85QKovypm/jTa61z+yd2kVaWWF5S5NN3lH2XM/H83ZAeiECaDCOs8aPTP8
         e6LQ3vvANYX0QacX+BaOev1DHwmOvb9bx7XshIqf3CLO5dsbAo7kEfY0yH9+MWw4YkaE
         MW/wBr7nLdrudMKJKT5F2hRazlL1kkcCTo6g9lKhXI3QobSw5iEeIqYbWImNjV/6t5cl
         ykYhxq7WCJjnZyZ/0CT4i9G3PUPP17DGirV4qoQY3vsxkhSPGxugy13ejQom6HFAT268
         qO8A==
X-Gm-Message-State: AOAM5332yRsjlEqkuw0bSmr86P82uKiKi20vJIv9uFajOf7fjMUFMKKE
        XTKxAFZcT4Rzfum7ixF2bxJbw4BEQ0jWUJRXuvFuHBzU2yZ9YwXI
X-Google-Smtp-Source: ABdhPJycyZzgR7uakkkgv88qsk0QkOIqjY5R4RVs0WooRkuOJwISUYIW6WI756A3JznrZ4G2jflaYbszzrd1Ugte2og=
X-Received: by 2002:a05:6402:2791:: with SMTP id b17mr21649711ede.173.1643129545040;
 Tue, 25 Jan 2022 08:52:25 -0800 (PST)
MIME-Version: 1.0
References: <20220105031242.287751-1-dustin@howett.net> <Ye8RaQcIuR6kpaYj@google.com>
 <CA+Px+wV8Ygz3n=4TtX1F6YB3Gcz8amNmotru09ftn9w776nDuA@mail.gmail.com>
In-Reply-To: <CA+Px+wV8Ygz3n=4TtX1F6YB3Gcz8amNmotru09ftn9w776nDuA@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 25 Jan 2022 08:52:14 -0800
Message-ID: <CABXOdTdyHWNckqmB9Ya2tZitghdxPuhNGSXdrLYZPU26w4JO=g@mail.gmail.com>
Subject: Re: [PATCH 0/2] platform/chrome: Add support for the Framework Laptop
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Benson Leung <bleung@google.com>,
        "Dustin L. Howett" <dustin@howett.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If nothing else helps, you should be able to find and download the
series from lore.kernel.org/lkml
(https://lore.kernel.org/lkml/?q=%22framework+laptop%22). Long term it
might be useful to set up patchwork to track cros related patches.

Guenter

On Mon, Jan 24, 2022 at 5:13 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> Hi Benson,
>
> On Tue, Jan 25, 2022 at 4:52 AM Benson Leung <bleung@google.com> wrote:
> > Tzung-Bi, could you help take a look at Dustin's series?
>
> Pardon me, I didn't subscribe LKML due to it is too noisy.  Could you
> also forward the 2 patches?
>
> I will try some magic
> (https://chromium.googlesource.com/chromiumos/docs/+/HEAD/kernel_development.md#Downloading-a-patch-from-patchwork-into-IMAP)
> to get the mail thread.  And subscribe LKML to get further patch
> series.
