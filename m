Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F414ED1C5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiCaCcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiCaCbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:31:45 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC2C6E29B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:29:51 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id j21so20374391qta.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=uCWcJ4R53iwqidepmXY3wpACCW/AmRMIeNF6xjQGeOc=;
        b=Kef/8KS7z7TqgVET6ARBolzBVFvYI9j8CYJKfo7hSwognblw01F957Vyoi/Qu2a/zr
         2bnOudujMy/m9msYwRI54CrWcpf2+/u+6Z9ogxi1U9Msj7G+ULqg+H7pSz2sm+Jn7g1c
         eMWyCaUXsJMQ16qvtwCeobpsmxB87MwrgDVlo7JhFQSkfjxusXvna+syq/URPsoOXnqK
         iGTrSApRlf38l6Wvsa1L/DeyQrBK60l5Vkb+epgEZHGhSRh6hZ78GNNdHwhZsHShao08
         Na1GB+90HU4At/eixwr1JEIN8rw1NR80xtpMzE5SU6v/fTOjAnv7JPDV38VbpRmTZvEc
         g0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=uCWcJ4R53iwqidepmXY3wpACCW/AmRMIeNF6xjQGeOc=;
        b=a1Abwv5SrBJ/CIB0LNpPh736l3BoFbi35WnOICUGDAnaDwGZjHRWzHOqXE+FhyPgHq
         UVPLmZJar5R3OEzjFxI8UIDW2UYIKhVzEvEjiZs0s0H1k8Z+FEa6KLUUOSs+V4buEOjI
         sN0Mpop/LSxjb4pd3dyXJbC8sslo8m2NeX33rDwV7VOVe9b1HwwEDJ39ofFxFNt9Kt3E
         bcOAl4opl0i+FEEihElENdiBEPoPCTMhL/jB/tmibcz+jL+qESK8omkRDWsmHu/o8eAi
         b0mZw/R7b9kbZtrod1eAfdSd/ksWMjywwxJSdLl0tMMjK1x/vkSP9E3Il1SbusBuFSYa
         5HFg==
X-Gm-Message-State: AOAM530ngx3YL2MXMpfj3ItCIn4J43eOtwgW/XrJjRyU1pvrYeegPL1b
        kG75M7UIwGJG56Ifw3vbbpU=
X-Google-Smtp-Source: ABdhPJymzCnCSVWIx2jcD0yYYFyYFw0CC9dzDd5JBMgmbFlFaNM+vfgQLY5Lf3/vps8hdUVWS8t1FQ==
X-Received: by 2002:a05:622a:178a:b0:2e1:e7b8:e52e with SMTP id s10-20020a05622a178a00b002e1e7b8e52emr2438304qtk.464.1648693790893;
        Wed, 30 Mar 2022 19:29:50 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r64-20020a37a843000000b0067b0cf40b18sm12062931qke.69.2022.03.30.19.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 19:29:50 -0700 (PDT)
Message-ID: <6245121e.1c69fb81.ea0ab.0c2e@mx.google.com>
X-Google-Original-Message-ID: <20220331022947.GB2390008@cgel.zte@gmail.com>
Date:   Thu, 31 Mar 2022 02:29:47 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        eparis@redhat.com, linux-audit@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, guo.xiaofeng@zte.com.cn,
        huang.junhua@zte.com.cn, dai.shixin@zte.com.cn
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
 <202203270449.WBYQF9X3-lkp@intel.com>
 <62426553.1c69fb81.bb808.345c@mx.google.com>
 <CAHC9VhRNuoPH6AySUbe6h2D6kghhezyVQtTAvm-t-fTpXH6XwQ@mail.gmail.com>
 <62427b5c.1c69fb81.fc2a7.d1af@mx.google.com>
 <CAHC9VhTLTQmHaka9tTyuu=rQOzpsn_K2NxfJ==7-6FSY3KnuFg@mail.gmail.com>
 <6243f1d7.1c69fb81.b19c7.7ec1@mx.google.com>
 <CAHC9VhTxACMG=V_J1OYy_7VjM3LjuNJcwJSf6om1eO8esCDAbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTxACMG=V_J1OYy_7VjM3LjuNJcwJSf6om1eO8esCDAbg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 10:48:12AM -0400, Paul Moore wrote:
> On Wed, Mar 30, 2022 at 1:59 AM CGEL <cgel.zte@gmail.com> wrote:
> > On Tue, Mar 29, 2022 at 09:11:19AM -0400, Paul Moore wrote:
> > > On Mon, Mar 28, 2022 at 11:22 PM CGEL <cgel.zte@gmail.com> wrote:
> > > > On Mon, Mar 28, 2022 at 11:06:12PM -0400, Paul Moore wrote:
> > > > > On Mon, Mar 28, 2022 at 9:48 PM CGEL <cgel.zte@gmail.com> wrote:
> > > > > > Sorry could anybody give a hand to solve this? It works well on x86_64 and arm64.
> > > > > > I have no alpha environment and not familiar to this arch, much thanks!
> > > > >
> > > > > Regardless of if this is fixed, I'm not convinced this is something we
> > > > > want to merge.  After all, a process executed a syscall and we should
> > > > > process it like any other; just because it happens to be an
> > > > > unrecognized syscall on a particular kernel build doesn't mean it
> > > > > isn't security relevant (probing for specific syscall numbers may be a
> > > > > useful attack fingerprint).
> > > >
> > > > Thanks for your reply.
> > > >
> > > > But syscall number less than 0 is even invalid for auditctl. So we
> > > > will never hit this kind of audit rule. And invalid syscall number
> > > > will always cause failure early in syscall handle.
> > > >
> > > > sh-4.2# auditctl -a always,exit -F arch=b64 -S -1
> > > > Syscall name unknown: -1
> > >
> > > You can add an audit filter without explicitly specifying a syscall:
> > >
> > > % auditctl -a exit,always -F auid=1000
> > > % auditctl -l
> > > -a always,exit -S all -F auid=1000
> > >
> > I have tried this, and execute program which call syscall number is -1,
> > audit still didn't record it. It supports that there's no need for audit
> > to handle syscall number less than 0.
> >
> > sh-4.2# auditctl -a exit,always
> > sh-4.2# auditctl -l
> > -a always,exit -S all
> 
> If audit is not generating SYSCALL records, even for invalid/ENOSYS
> syscalls, I would consider that a bug which should be fixed.
>
If we fix this bug, do you think audit invalid/ENOSYS syscalls better
be forcible or be a rule that can be configure? I think configure is 
better.
> -- 
> paul-moore.com
