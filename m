Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F244F5894
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 11:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382728AbiDFJDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444335AbiDFIzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:55:55 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B05CBD7EC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:19:12 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id b18so2003176qtk.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 18:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=emQSRtRyiIFOLZBRRD9ok+SvUgg5HT0mxHFWqehp0vo=;
        b=liEzV1DvukrzML5boo3DbzOsgqEOmW0TeGZTRGeDBUiO58NX4hoZ95SKtZ0x5lxoy/
         D+UyQgPzqMzwbGKoyaljyyvCPgry06NMaGJrvORwjJXzRsgikKeJ59XIt4sCqr0WH0PZ
         foni+TAvduk8iqwj62A/m+7RyRpjJBxUB0ZQuBILLV3XWPtEe0uOWPBOQpClr8ZbCf5y
         zVh7ul4pC0MnQA170gM0tkNixTeWAKfJGqKxvJxx70YiTFBWKtvIabgOhUdKlW7P5lPu
         veOX0IOPELZ3Oq1VYBpIdI3ZRGMHlbBCRZutv8u83QPzUSNJFnymCzyO7+6+Vq8+zHSE
         TpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=emQSRtRyiIFOLZBRRD9ok+SvUgg5HT0mxHFWqehp0vo=;
        b=8PFNyWFedcvGSHVTdsxgLZqOLwtc6cc4d539Um443TxPeIrDQcv8MaAJl1na9+6qZ9
         LsenNuMYoArXYUjfZSFCxR7dzZG+5cYG0OzRzp53gcCd4vv/0S/vnJ06rLo6Kltt0Ehu
         o+/TyldIsvAFEl7USxO0QPrzn7ClAK84CjRwGOEa2n+a2snK31Ru/T11ywHhwkXInxV7
         3Gdgp+s/wgghUqAVyuKp3/M6jVqvx5/Q78M9FwUfruv6NM3DzjTsnQD1TrGdrRABnf6h
         sb1Yk/ncHqFy/Itx+jtzzZ/5/P92S+Te9v4SP3itDMPkz0aoN2FERQ2CXJL/fbtc628y
         OAgg==
X-Gm-Message-State: AOAM532BAlqwa1fZiG6Azv9rCAeRyzxl166jIZ5Ue2TZC6dz7yNOlloN
        PinU0hBytGWRa5wgin39M5hVCadwCc8=
X-Google-Smtp-Source: ABdhPJw3H1ruWxhuQ05X1p8z8JYG/k0+IbQoPX9aYytL4Pwxr7a6RJLhDMF3ORYFkO683VqFRlZ0KQ==
X-Received: by 2002:a05:620a:2886:b0:699:bab7:ae78 with SMTP id j6-20020a05620a288600b00699bab7ae78mr4108850qkp.618.1649207951145;
        Tue, 05 Apr 2022 18:19:11 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x18-20020a05622a001200b002eb856d7786sm12382288qtw.84.2022.04.05.18.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 18:19:10 -0700 (PDT)
Message-ID: <624cea8e.1c69fb81.422be.e03b@mx.google.com>
X-Google-Original-Message-ID: <20220406011907.GA2458824@cgel.zte@gmail.com>
Date:   Wed, 6 Apr 2022 01:19:07 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, kbuild-all@lists.01.org,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
        eparis@redhat.com, dai.shixin@zte.com.cn,
        Yang Yang <yang.yang29@zte.com.cn>, linux-audit@redhat.com,
        ink@jurassic.park.msu.ru, huang.junhua@zte.com.cn,
        guo.xiaofeng@zte.com.cn, mattst88@gmail.com
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
 <CAHC9VhTaCNqfTOi8X5G3AheBFzTYCzGnt_-=fNFc5Z1o8gPm9Q@mail.gmail.com>
 <62465bf3.1c69fb81.d5424.365e@mx.google.com>
 <2777189.mvXUDI8C0e@x2>
 <CAHC9VhRYHhHPx42BKa0gp974uzwHoXZWqmwt9o=1rox7tHyy1w@mail.gmail.com>
 <624803f7.1c69fb81.972da.2dd0@mx.google.com>
 <YksVuhfv8weLCxX/@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YksVuhfv8weLCxX/@madcap2.tricolour.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 11:58:50AM -0400, Richard Guy Briggs wrote:
> On 2022-04-02 08:06, CGEL wrote:
> > On Fri, Apr 01, 2022 at 10:16:45AM -0400, Paul Moore wrote:
> > > On Fri, Apr 1, 2022 at 9:39 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > > > On Thursday, March 31, 2022 9:57:05 PM EDT CGEL wrote:
> > > > > On Thu, Mar 31, 2022 at 10:16:23AM -0400, Paul Moore wrote:
> > > > > > On Wed, Mar 30, 2022 at 10:29 PM CGEL <cgel.zte@gmail.com> wrote:
> > > > > > > On Wed, Mar 30, 2022 at 10:48:12AM -0400, Paul Moore wrote:
> > > > > > > > If audit is not generating SYSCALL records, even for invalid/ENOSYS
> > > > > > > > syscalls, I would consider that a bug which should be fixed.
> > > > > > >
> > > > > > > If we fix this bug, do you think audit invalid/ENOSYS syscalls better
> > > > > > > be forcible or be a rule that can be configure? I think configure is
> > > > > > > better.
> > > > > >
> > > > > > It isn't clear to me exactly what you are asking, but I would expect
> > > > > > the existing audit syscall filtering mechanism to work regardless if
> > > > > > the syscall is valid or not.
> > > > >
> > > > > Thanks, I try to make it more clear. We found that auditctl would only
> > > > > set rule with syscall number (>=0 && <2047) ...
> > > 
> > > That is exactly why I wrote the warning below in my response ...
> > >
> > I think the question is more clear now.
> > 
> > 1) libaudit.c wants to forbid setting invalid syscall, but inconsistent
> > Currently way(>=0 && <2047) is inconsistent, syscall with number 2000 and
> > syscall with number 3000 are both invalid syscall. But 2000 can be set by
> > auditctl, and 3000 cannot be set by auditctl.
> > A better way to do this forbidden is to use __NR_syscalls(asm-generic/unistd.h).
> > 
> > 2) if libaudit.c do the right forbidden, kernel better ignore invalid syscall
> > See this patch.
> > 
> > If we want audit invalid syscall as you said before. libaudit.c should not
> > do the forbidden, auditctl should allow setting syscall rule with 'any' number.
> > So do you think we should fix libaudit.c?
> 
> I'm having a bit of trouble understanding what you've said above.
> 
> The kernel ultimately must protect itself from malice and mistakes, so
> it must verify all data sent to it.
> 
> Userspace can help by knowing what that kernel policy is so it can avoid
> violating that policy or provide useful feedback if it can't.  Userspace
> can be used to make things more efficient, but the kernel is the last
> step for security.
> 
> If userspace and the kernel are mismatched or out of sync, then the
> kernel enforces policy to protect itself.
>
Much appreciate for your interpretation. Have you get any idea of how
to solve the mismatched? From your viewpoint, I think it's better for
kernel to not handle syscall of syscall number<0, because it's invaild
of all arch, and has no value for attacker to probing for specific
syscall numbers.
> > > > > > Beware that there are some limitations
> > > > > > to the audit syscall filter, which are unfortunately baked into the
> > > > > > current design/implementation, which may affect this to some extent.
> > > 
> > > -- 
> > > paul-moore.com
> 
> - RGB
> 
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635
