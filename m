Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81DF50FD00
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349943AbiDZMbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349911AbiDZMbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:31:53 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B8469CC8;
        Tue, 26 Apr 2022 05:28:46 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g9so15938855pgc.10;
        Tue, 26 Apr 2022 05:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8YVviuIvF1Vs/9Y044PRi6lOsrZwzKHwgSOceG4aTrw=;
        b=LYumgclYx9M6WNj/MDXDA6BaRhX/nU8G5Z5yllRPhvK6ZRwLqsLnaGmIW3Bobg572l
         qzR9PiT9130d84GKLcjTLub0xOqVmkkUv9XYZIK0Arg2ca4qJJAgZgZRqv1Ps8tAM27i
         oJ1hqjm75YDIPhr8aZs3DWOHTUQ5+QNcRtp/EJFiWDUH3K+gd+2RK4zCW6GI2u9Bl+yJ
         XUzQ5uphyJfCnOvewTVsWXc/qz/56L2/XHKhPQs0A7dmEiFLYQykazqYxJB3HHma8/nP
         U1yfX4H4np9t1ipHw9WKHs5qK0o/sgHkF9pVsPsDK5cMFFfm6ngf5+zqbRQqTdg3N7/s
         N+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8YVviuIvF1Vs/9Y044PRi6lOsrZwzKHwgSOceG4aTrw=;
        b=adwfQet9rWXC7Qa1n8kZM37iGkpX5BWwpFXt5MR7d8V1eHZWDMij8QaJZeWTGWXrNZ
         fP+8C6KKwvweEcxIT5cMoopdrogxkOu1YrCangTZgZvSkrm/bluauZh8Mn7Cm45BhCOa
         fYdF0DsRe3Nx7xb+PPQ2mhA6PQEe6O1LiPYOY5CBUQNfbwVcryPnqR67Z/nFem60Pu4H
         8ZLwHbhOke6DndEDDqC7Sc5O1wqpKA+K+QVuKbKxTZlDqcrhQI9aqJA9EESe0O6HnLDH
         XfnvQAl1Ac0guynxk/Zx7qSIy4CMaYMeod/edkaIeoVppWM3BtU+TS9B+biWBseIPlRY
         zzvQ==
X-Gm-Message-State: AOAM533+1etdTd7Xzu4PcmnrUTvjdGJ5JRgwYO4gmk/fIOL+bteRPxKx
        j7XqzCD2mjMVehCOEsM6IOiw4N7t/TXEbPnjp+U=
X-Google-Smtp-Source: ABdhPJyTHaeNCROY3RcIpV9sv1FtAIaRdBav+n0FBFk2fenj+R8Fq2zJhervX20i9zZaRBKgNkuDhIULooNeCZdZDxs=
X-Received: by 2002:a05:6a00:26cf:b0:4f6:fc52:7b6a with SMTP id
 p15-20020a056a0026cf00b004f6fc527b6amr24197355pfw.39.1650976125478; Tue, 26
 Apr 2022 05:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220420211105.14654-1-jagathjog1996@gmail.com>
 <CAHp75VdyPekY7t8Y4-nyVXNt7wFZKB+yL2i6MNe1WLez178a6Q@mail.gmail.com> <CAHp75VfCxD13X4RdL0ZtiB_MXODck9votoek2s3sUc457AXOrA@mail.gmail.com>
In-Reply-To: <CAHp75VfCxD13X4RdL0ZtiB_MXODck9votoek2s3sUc457AXOrA@mail.gmail.com>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Tue, 26 Apr 2022 17:58:34 +0530
Message-ID: <CAM+2Eu++bEUmgY-TPWYA4NCd5-ihJFO+0BRHbAezDigW-r08vA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] iio: accel: bma400: Add buffer, step and activity/inactivity
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

On Tue, Apr 26, 2022 at 4:35 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Apr 26, 2022 at 1:04 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Wed, Apr 20, 2022 at 11:11 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> > >
> > > This patch series adds trigger buffer support with data ready interrupt,
> > > separate channel for step counter, an event for step change interrupt,
> > > activity recognition and activity/inactivity event support.
> >
> > You forgot to add tags from the previous round of review, please be
> > respectful to reviewers.
>
> That said, send a new version with properly added tags for what it was given.

I have followed your comments from previous series and added the 'Fixes' tag for
patch 1, also added your 'Reviewed-by' tag for patch number 2 and 3 for which
you have given previously.

>
> --
> With Best Regards,
> Andy Shevchenko
