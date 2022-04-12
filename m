Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899ED4FDFAC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349918AbiDLMZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351477AbiDLMZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:25:00 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF6A74842
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:30:55 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id n11so5053760qvl.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EmIj8CIsQl1XMgKvHW9DEhngM3kgzslh2VipMPLIr4Y=;
        b=UCZUXuUONNwn36sGMFQJJISoneJjqJMOj8d49lKzQtTkD/ArlbicVTa4YCX0Y44JiH
         x792rD7rkJyLPBhYk8T1aI+UtnBjbFVE9mPKHZh/RQgZiItPKidpYFyE+tSCW7CPOVHP
         GV0dofYw1KO+xj3DwFTRe61j8J0csJSk+O9KZ2qhd9Dhgex6wn3iauHWmuUvvw2ka4Cj
         4PH41XethCMfUdGjnwWiOewOO0Cfi2ZlY96LOvyYndhM9ppfSPmodbdbY0tOeClJVp4A
         Wf/LClDPVr8JhBup09A9kGSAJ5KuGvv+N188dks2doA+Ji3DLo6HSe5OvSb1pKboa3iL
         uvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EmIj8CIsQl1XMgKvHW9DEhngM3kgzslh2VipMPLIr4Y=;
        b=Wl+M+qX8/ooWg7lpsu/zWBrBm7ll4RIEIgutKhTvNzz1GdpwrigF9/45gVkATIwAGy
         Od3djdYWYC97+x9SIB38L2hHsU+PTGBkgtjBOqrbsIGm0fHVEUWeDlHcaBBf/bSH8Lga
         B4IFwwK3D61kuSVGKN0tCft15QjLkEwwXid+9NrVs3c7XS8SSqUUaro/lzHqMmN+zhsH
         dIqOweJ6z/ARDBZ3uOlRKZ4nt791VIB8S7v4aKixsrW2V3zyNmcFT3zskQdRYqm1JKQB
         ucl/NU5ZGZzMmsYZuyqXxmpyfRTvy7M6tot355KGLxElUw5ZoXHHITNC4soPh9jorDd/
         DhzA==
X-Gm-Message-State: AOAM533ED3eBdrZYmzpl2iCsCZM6hZYWqwchTwCCFUcMwXkXq/lPR/gz
        N1IToKowburozXmwUrV7uOrV7Ye3z7FF08xbb4o=
X-Google-Smtp-Source: ABdhPJxRQarE0ErahkpO4Cbrv/62NgURgoOHCn61vzPjZbfX6LdeNkwvMrRit0ear6/l0ZhBQhjA0H7seBl61Dib/No=
X-Received: by 2002:ad4:5642:0:b0:444:47e1:b244 with SMTP id
 bl2-20020ad45642000000b0044447e1b244mr7255566qvb.4.1649763054331; Tue, 12 Apr
 2022 04:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220412103629.8029-1-fmdefrancesco@gmail.com>
 <YlVXV4J41KBzKHtm@kroah.com> <2976258.CbtlEUcBR6@leap>
In-Reply-To: <2976258.CbtlEUcBR6@leap>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 12 Apr 2022 13:30:43 +0200
Message-ID: <CAMhs-H_JJ7JVccYjdoj5opTt6R5CHRBwQ05tXPuFgenpCuyy4w@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Remove D. Kershner from Unisys S-PAR maintainers
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liu Junqi <liujunqi@pku.edu.cn>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Fabio,

On Tue, Apr 12, 2022 at 1:08 PM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On marted? 12 aprile 2022 12:41:27 CEST Greg Kroah-Hartman wrote:
> > On Tue, Apr 12, 2022 at 12:36:29PM +0200, Fabio M. De Francesco wrote:
> > > The email address of David Kershner is no more reachable. Remove his
> > > entry from the MAINTAINERS file for UNISYS S-PAR DRIVERS and change
> > > the status to "Orphan".
> > >
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >
> > > v1->v2: Change also the status of the entry to "Orphan" and rework the
> > > commit message. (Thanks to Greg Kroah-Hartman).
> > >
> > >  MAINTAINERS | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 3ed62dcd144e..9283c63565b3 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -20184,9 +20184,8 @@ F:  include/linux/cdrom.h
> > >  F: include/uapi/linux/cdrom.h
> > >
> > >  UNISYS S-PAR DRIVERS
> > > -M: David Kershner <david.kershner@unisys.com>
> > >  L: sparmaintainer@unisys.com (Unisys internal)
> >
> > Again, please drop this "list" as it obviously is not going to anyone.
>
> OK, I'll also drop the "L:" line. I wasn't sure about it because I see
> that there are other entries marked as "Orphan" and the list is still
> there. But you are right: although the "sparmaintainer" list address is
> not bouncing, it looks like nobody care to read messages there.
>
> > And really, this whole code should be removed, no one seems to be using
> > it, and if they are, we can easily revert the removal and mark them as
> > the maintainer.
>
> 1) If I remove the entire drivers/staging/unisys/ I suppose that, in
> MAINTAINERS I should also remove the whole entry called "UNISYS S-PAR
> DRIVERS", not only the "L:" line.
>
> 2) Furthermore, I understand that I should also should change the relevant
> Kbuild files, otherwise all builds of staging would fail.

Correct.

>
> I'm sorry for asking but, as you probably recall, I have no prior experience
> with removing drivers from trees and with the Kbuild's infrastructure. I'll
> take some time to read how it works.

Check this patchset [0] I sent a bit time ago removing two drivers from staging,

Hope this helps.

Regards,
    Sergio Paracuellos

[0]: https://lore.kernel.org/all/20211113192045.32153-4-sergio.paracuellos@gmail.com/T/
>
> Are the two arguments above correct?
>
> Thanks,
>
> Fabio M. De Francesco
>
>
>
>
