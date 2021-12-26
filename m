Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C968847F6F2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 14:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhLZNTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 08:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhLZNTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 08:19:16 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4E5C06173E;
        Sun, 26 Dec 2021 05:19:15 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id b1so10091973ilj.2;
        Sun, 26 Dec 2021 05:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ca8Aisgix/GZk82j87aGdziJ5JrKmEcmyharhQENfZU=;
        b=fRtqps8HnJ4GAGhNoR3nkUdmGGsyM40xM8FlmjRoKq/w8a8FGmOph5MPkMNqokZ2Rj
         25D0ZYz8UKh4bZZ+YEmCCS08kJimOwvxO9uzrdCTyX9M7zNJTCcmXoI7/zeDtTseKe7m
         ql/AWKN4YxM8vHPbH6e4WWECaeSuNQvI36WvZobJjq/Q0NZAKaBm+pQgs7HK7izrdO9/
         2GyyCuBmJo9XWP9JtBSupK/tifqmoZPiatXwCWimT6uVsjqqR/PmisE98FPxOD8o26rP
         jysnpXY/GA7TgOCmUGq4Dd/kPwmTUY4xN1HcLAVmu9Rcnxq2w+SBk+j02jrXL9Qura+F
         BcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ca8Aisgix/GZk82j87aGdziJ5JrKmEcmyharhQENfZU=;
        b=mLo/iaHOCVku8zKqEDeP5ZdHEClYHCk2REdl390sHCnNJzwQH2QfijM3+wO5QxXw1D
         OsRMkaHySGgnYbYI6PeXdNNvgvC8ER7erATOsCJKNPNe0rd3UL+Zf1TcDmJYh7cbQi7P
         4RcBybNhNmaF0wfE5P5dZiE8XAIyLcsOGJ+h2OQNDj2CkCTjO8o6xp+qJiTYUFmfjSZP
         XS7Zy1+1COQbyohCBkixn/aty2G8xq1Etb7GD/RCfRNMjJMh1AfmeCAqQkxIXi0qX5l0
         bAUAp1qce+swr3kZzhM8mZjvZR42LgJCGCPYijAReDvKNATbfXgkW7HlesM7e0xixLIv
         W3fg==
X-Gm-Message-State: AOAM5302+Wtw5sHIY+WikhPNTIfK9WpJma4K0h6R8IPSK5+VAfK8d8Ht
        x8kVBtdJlBOoyldvDmow4VO0eQx8oNq0gOK/C6fmJ3jAR/4=
X-Google-Smtp-Source: ABdhPJyNz8OwBngtrRAlXpFx+cXCoXB9vy82xHQ64k8bUNqRL/UzBH5Jk7HtQTdTX7UTv2Q9lmQooNNiOtxzT4Ff1dY=
X-Received: by 2002:a05:6e02:1bec:: with SMTP id y12mr6357024ilv.233.1640524755174;
 Sun, 26 Dec 2021 05:19:15 -0800 (PST)
MIME-Version: 1.0
References: <f55721ade28b2715eaf54b28a1bbfaad7b5adc0d.1640471342.git.andreyknvl@gmail.com>
 <Ycgi7GiU2udbjF2f@kroah.com>
In-Reply-To: <Ycgi7GiU2udbjF2f@kroah.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 26 Dec 2021 14:19:04 +0100
Message-ID: <CA+fCnZeC8PbDg_E3WWtqGBAwUs65Y7=b5DG=whN-CaOEs5uS7g@mail.gmail.com>
Subject: Re: [PATCH] usb: raw-gadget: upgrade license identifier
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     andrey.konovalov@linux.dev, Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 9:08 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Dec 25, 2021 at 11:32:36PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > Most of the USB gadget modules are licensed as GPL-2.0+. There is no
> > reason not to allow using Raw Gadget code under a newer GPL version.
> >
> > Change SPDX identifier from GPL-2.0 to GPL-2.0+.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > ---
> >
> > I don't know whether such license change is possible and what it
> > requires.
>
> It requires the copyright holder to agree to change the license, as well
> as anyone who as contributed to it.  If you so desire to do this, please
> work with them and get the lawyers for those entities to sign off on the
> patch and I will be glad to take it.

Ah, never mind this patch then. I don't care enough to bother with
this. I'm not even sure what the difference is, but having less
restrictions seems better.

I wonder if checkpatch could alert about considering GPL-2.0+ when
adding new files.

Thanks!
