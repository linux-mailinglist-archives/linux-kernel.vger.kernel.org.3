Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1FA4EFF87
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 10:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbiDBIIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 04:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiDBIII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:08:08 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A48F3B011
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 01:06:17 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id b18so3927797qtk.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 01:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ws4yj3fg0ILxPJj/9lrXi9irg5Vwgnd7Bl7EJpCplb4=;
        b=KVBpvFHZHv4/9dXvw0FUo4hVWaqn3dWHSWxe9lqX1/n3eViJZr4Y2e0VeR5RGCLxFW
         NXFrH+4UkKpCOQv2iIcJ5otbBV0lRZcoI/qY+0kjrYApl38bNLgFBO4treJcLqT8ww+X
         2f5YRP35MdECqVZDm4RQGngCZznEBRJx8WvcO1zVCYb+Sr9AB+fRvW5yo/H9InO0auiT
         5NIcK2iT9dP+vytoaXwSvDL6GY335M/pUEpar5QBO4SR/+Sah1eT7NLV8fpwBUPgoGNX
         9SqFv3l78EaSmvuCZty3V/y2hsvR4nQLBTTxIiUDCVsaKm2yWDo3oxKCqo/4thKE+kyO
         I11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ws4yj3fg0ILxPJj/9lrXi9irg5Vwgnd7Bl7EJpCplb4=;
        b=unHj2Az72PWEEIkios4BDe+RaZ6RjoQ8syEe8/j25fHzKFxYh/Pczz8jz7GkTo7rgT
         B2zANdqD49wjYb8b0cID3wqHCaX99B3zTiEMj6LFZ75MbViZjQbrR/lkwCcdBAulMCWI
         eyl5jJGxp8eWC21LjV8q35pFFCuDF8XcnAF1iqUeNUhDhY4kBSljm2CTgM3LnKiUHDqI
         /qMZgcDO5nJJO0kYj/z2GC7wmjwuUDDBxQZpkJqLKaBIlyFUBRKJqOItjnqGa07F7j/j
         SYUE6fsBedBewhI+FcTPvM2cNAh3B3y2neh2hbzbz9u2nDFmMwDS5uItG0h5+tOOx3eZ
         uw5g==
X-Gm-Message-State: AOAM533RSxkurqpKZxsZsRdFauWnSetEprtsST35Nmi72RklXlKgZLOt
        dA1VkQIqzDabq41yOY3d2btF8a9oP4Y=
X-Google-Smtp-Source: ABdhPJyX0KLPAV81ICD7wf3I9EYTnSX2te3tj1vy9I/A89gg4uPLy5O1QfHEMAvC6OHVTG0b/Owvtg==
X-Received: by 2002:ac8:5702:0:b0:2e1:ec8a:917a with SMTP id 2-20020ac85702000000b002e1ec8a917amr11061065qtw.682.1648886776230;
        Sat, 02 Apr 2022 01:06:16 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g21-20020ac85815000000b002e06e2623a7sm3431644qtg.0.2022.04.02.01.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 01:06:15 -0700 (PDT)
Message-ID: <624803f7.1c69fb81.972da.2dd0@mx.google.com>
X-Google-Original-Message-ID: <20220402080612.GA2412487@cgel.zte@gmail.com>
Date:   Sat, 2 Apr 2022 08:06:12 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
        kbuild-all@lists.01.org, Zeal Robot <zealci@zte.com.cn>,
        linux-kernel@vger.kernel.org, eparis@redhat.com,
        dai.shixin@zte.com.cn, Yang Yang <yang.yang29@zte.com.cn>,
        ink@jurassic.park.msu.ru, huang.junhua@zte.com.cn,
        guo.xiaofeng@zte.com.cn, mattst88@gmail.com
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
 <CAHC9VhTaCNqfTOi8X5G3AheBFzTYCzGnt_-=fNFc5Z1o8gPm9Q@mail.gmail.com>
 <62465bf3.1c69fb81.d5424.365e@mx.google.com>
 <2777189.mvXUDI8C0e@x2>
 <CAHC9VhRYHhHPx42BKa0gp974uzwHoXZWqmwt9o=1rox7tHyy1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRYHhHPx42BKa0gp974uzwHoXZWqmwt9o=1rox7tHyy1w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 10:16:45AM -0400, Paul Moore wrote:
> On Fri, Apr 1, 2022 at 9:39 AM Steve Grubb <sgrubb@redhat.com> wrote:
> >
> > On Thursday, March 31, 2022 9:57:05 PM EDT CGEL wrote:
> > > On Thu, Mar 31, 2022 at 10:16:23AM -0400, Paul Moore wrote:
> > > > On Wed, Mar 30, 2022 at 10:29 PM CGEL <cgel.zte@gmail.com> wrote:
> > > > > On Wed, Mar 30, 2022 at 10:48:12AM -0400, Paul Moore wrote:
> > > > > > If audit is not generating SYSCALL records, even for invalid/ENOSYS
> > > > > > syscalls, I would consider that a bug which should be fixed.
> > > > >
> > > > > If we fix this bug, do you think audit invalid/ENOSYS syscalls better
> > > > > be forcible or be a rule that can be configure? I think configure is
> > > > > better.
> > > >
> > > > It isn't clear to me exactly what you are asking, but I would expect
> > > > the existing audit syscall filtering mechanism to work regardless if
> > > > the syscall is valid or not.
> > >
> > > Thanks, I try to make it more clear. We found that auditctl would only
> > > set rule with syscall number (>=0 && <2047) ...
> 
> That is exactly why I wrote the warning below in my response ...
>
I think the question is more clear now.

1) libaudit.c wants to forbid setting invalid syscall, but inconsistent
Currently way(>=0 && <2047) is inconsistent, syscall with number 2000 and
syscall with number 3000 are both invalid syscall. But 2000 can be set by
auditctl, and 3000 cannot be set by auditctl.
A better way to do this forbidden is to use __NR_syscalls(asm-generic/unistd.h).

2) if libaudit.c do the right forbidden, kernel better ignore invalid syscall
See this patch.

If we want audit invalid syscall as you said before. libaudit.c should not
do the forbidden, auditctl should allow setting syscall rule with 'any' number.
So do you think we should fix libaudit.c?
> > > > Beware that there are some limitations
> > > > to the audit syscall filter, which are unfortunately baked into the
> > > > current design/implementation, which may affect this to some extent.
> 
> -- 
> paul-moore.com
