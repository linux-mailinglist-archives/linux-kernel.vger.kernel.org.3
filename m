Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E592B4A9F43
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377632AbiBDSgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377611AbiBDSgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:36:32 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1247CC061741
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 10:36:32 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id p5so21159013ybd.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 10:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5Aj1KjYxfLdKjI/WZUbvXzI5x0t228gk/N8Q28NwXc=;
        b=m2yPocPkciKFGCCbvaln3VxAlvAsooZ724bmD/N4oVRNvlL0VoMSE4qNXZ6Dp4VN84
         TMskNSAHGDldEClw1PdUHIrN0kRP0kI/yqSHpPMNihmGdy2UxKXS8Gm5Tq18MkRAinRe
         EdWn3NlqWh12+3X55hF/jc2PCPBonzObBRf0sM/j8oKsDhKedcOjCciXuiAW1EruLmtY
         mBdSkQd1/NxxDo1jv6dDI1lM9SuAS+WEZ9LRGBAiYNqt+tQBpU0N0/fAxT7BMIY4QQMu
         xY1sTyYSg6fr4V+QxtOFxy9rhjoa8sFwIhSkXK2ImsPcFnvdbFhgBmG7iWv7XNtP885n
         D1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5Aj1KjYxfLdKjI/WZUbvXzI5x0t228gk/N8Q28NwXc=;
        b=8C8dOLjU/MHK4XRUOkbDEuc+cAya/mnWwz3F07Dvw9a5TAG14O1BGfb7DNGoIxJydH
         VO5FpBuxrfVq1g63RFGvRClvrU3rlFA9+Dqoq+vUofwTIaiPuYqeUhm+PuBaxW54N4zk
         ArKLcR2m3+lGv+m7BDcE7mKE/40HJNg6Z0BzhfmCkGwKmX6bC1tEUzG2dxgX86osq03E
         /sidbgPPn0g86UwW8oDauQkZw0nOWqTL9wN0UwNgWqGWVWtGfwU4To9G4ghMUnjohnxk
         icj3Oc5b5O9i0zkixDIyrWPAUspiwalaahu2dMp6JEN6WmZPXUIrj6khyx3yBHqysnMz
         1uWQ==
X-Gm-Message-State: AOAM532vGKVThbkGgcawymCa+LXTaXM59/LPLX//Xa/s0FIlWgCR4tLi
        26gPcqsBYfYwCUvEiRYjCH8PYf5+3CMlrp7TOQo=
X-Google-Smtp-Source: ABdhPJxcSUbvJwDw+JlzrS/bulYbjADv05HysQJPJATVorWp5WCcH3QqAPDjvAjAGc8SvpMHCNCL8XrxA9N1cb+TU3s=
X-Received: by 2002:a25:1809:: with SMTP id 9mr434289yby.633.1643999791205;
 Fri, 04 Feb 2022 10:36:31 -0800 (PST)
MIME-Version: 1.0
References: <20220204054028.3123858-1-ztong0001@gmail.com> <Yf025dphJw2rUVR5@kroah.com>
In-Reply-To: <Yf025dphJw2rUVR5@kroah.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Fri, 4 Feb 2022 10:36:20 -0800
Message-ID: <CAA5qM4By97L-QEjJd3HhzJ=9XLve7Fuj_Wo-uO8Lp94XWJDx3g@mail.gmail.com>
Subject: Re: [PATCH] staging: gs_fpgaboot: revert removed board specific code
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Paul Bolle <pebolle@tiscali.nl>, linux-staging@lists.linux.dev,
        open list <linux-kernel@vger.kernel.org>,
        insop.song@gainspeed.com, devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 6:23 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 03, 2022 at 09:40:27PM -0800, Tong Zhang wrote:
> > Loading the driver will always fail since
> > xl_init_io() always returns -1. This driver is broken since 2014 and I
> > doubt anyone is actually using it, we could either remove it or revert
> > to the previous working version.
>
> Let's just remove it obviously no one is using it.
>

I am on the same page with you folks. We should remove it. I sent out
the patch to see if
anyone in the list is still interested in keeping it just in case. I
will send another patch to
remove it from the staging folder.

Thanks!
- Tong
