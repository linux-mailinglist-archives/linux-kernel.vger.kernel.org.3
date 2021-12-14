Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321E4474BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbhLNTcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbhLNTcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:32:00 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFD6C061401
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:31:59 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b1so38740706lfs.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sharpeleven-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CSsQizS2Alccn09uVVHMhRrxYpQSyu5zyJjpNQE3tlI=;
        b=sf8PduFp6j+NjHLIpIDvQ4RC318EDH6SD3pXBY8xfLup36IkrZVN9oQ+iwUc+uldQE
         XfARii3Mm4ENAJDWhQ2aqollunGkuGZQqDuyEhBie3Qzb4qdcwLZmMc5+0CKeFL3NiRr
         Lm9gGApSYH53GjDTMQcbbMXqwjFAbIQtPHvpL3uo4xNqUgXY6zdIzQIl8iie1hfdPqwZ
         lLgv3NrQA9H1tLpvfl/Ti7SwOb/pzX3wIhn6gZfUmExuxM4eZI/omnNoTvAHKthYywNU
         s8LcP8l8Ye4ax2Vru+5+asaMOfzIr3AXQpo3D2mWkeb6a36bIyJTNPo5LqHk0KI09ETS
         /fMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSsQizS2Alccn09uVVHMhRrxYpQSyu5zyJjpNQE3tlI=;
        b=nhO8B76zlp5YLX8Pl/ad7GdIyALnA5uN6EtCFuO6Q3Hyd+RDHs9pkdIkdot9NwSs8O
         y9sMXgi2YoqMBZlyalXHeEnpKJrLUy0laNkhCAKDwwam+KEA36ShZ37pXt4vSXpFUBPS
         Juwk0cXV87oKXbItmW98Lrf3gWfmMcNwicJTJFqv0++ob60umVMvQFFmkBym1sOSKpys
         ZTU1MqYHNrms/V/BTPZUHVlnxYmT1DDMrsWyPODzaPowqfU4FoN0BBo/kz16+MILn9GE
         zotERYOHHUPUOu7MdVJv3iwAjcc6EEKcjocRTwoS8ceugQvZKQIutME66dK09cgn+Iil
         1GYQ==
X-Gm-Message-State: AOAM531e9L9i7e1HQaP+z83MyyAt3ogzeZlDuB34pThjLMSZmdiVRyMP
        ASUQIZdYiKLN87Ft9aEQy5Dr92qAGhdsIlGpvTJU+d29572RdjK5
X-Google-Smtp-Source: ABdhPJzLUx4mda4fQ7H0Ga9lBWntpZB7VpWdQX2o1dcRwm3prFV7nNv/EX6mBWmoe0www35mz1g39dVYV3eVfxoc5SQ=
X-Received: by 2002:ac2:5499:: with SMTP id t25mr6633200lfk.674.1639510317616;
 Tue, 14 Dec 2021 11:31:57 -0800 (PST)
MIME-Version: 1.0
References: <20211029184500.2821444-1-mcgrof@kernel.org> <20211029184500.2821444-4-mcgrof@kernel.org>
 <Yao3vtSKBKLyQY1E@kroah.com> <YbFgaSPPw4Y3pJoB@bombadil.infradead.org>
In-Reply-To: <YbFgaSPPw4Y3pJoB@bombadil.infradead.org>
From:   Richard Fontana <fontana@sharpeleven.org>
Date:   Tue, 14 Dec 2021 14:31:46 -0500
Message-ID: <CAGT84B35yEjPxtu=cShoxCNzi8kaYDBbHDsu9-g0UhdFrCS6Lg@mail.gmail.com>
Subject: Re: [copyleft-next] Re: [PATCH v9 3/6] selftests: add tests_sysfs module
To:     Discussion and development of copyleft-next 
        <copyleft-next@lists.fedorahosted.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        jeyu@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, shuah@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-spdx@vger.kernel.org,
        tj@kernel.org, dan.j.williams@intel.com, bvanassche@acm.org,
        linux-kselftest@vger.kernel.org, joe@perches.com,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        minchan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Dec 8, 2021 at 8:52 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Dec 03, 2021 at 04:29:02PM +0100, Greg KH wrote:
> > On Fri, Oct 29, 2021 at 11:44:57AM -0700, Luis Chamberlain wrote:

> > > diff --git a/lib/test_sysfs.c b/lib/test_sysfs.c
> > > new file mode 100644
> > > index 000000000000..2a6ec072da60
> > > --- /dev/null
> > > +++ b/lib/test_sysfs.c
> > > @@ -0,0 +1,894 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
> >
> > Again, sorry, but no, I am going to object to this license as you are
> > only accessing a GPL-v2-only api.  Any other license on a file that
> > interacts with that, especially for core stuff like testing the
> > functionality of this code, needs to have that same license.  Sorry.
>
> Huh? The license is GPL-v2 compatible, and when used in the kernel the
> GPLv2 applies.
>
> Likewise, are you taking the position that permissively licensed code,
> say BSD or ISC licensed code, cannot use EXPORT_SYMBOL_GPL() symbols?

Just chiming in here, not really because of any association with the
copyleft-next license (or GPLv2 for that matter) but because of
general personal immersion in open source licensing. I would think
that code interacting with a GPLv2-only api could be under any
GPLv2-only-compatible license, such as ISC, GPLv2-or-later, or
copyleft-next. That said, of course kernel maintainers can establish
stricter policies around acceptable forms of licensing.

Richard
