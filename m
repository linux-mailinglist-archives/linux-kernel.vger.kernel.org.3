Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC494F044D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 17:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357078AbiDBPKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 11:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbiDBPKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 11:10:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61BA1AD99
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 08:08:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ot30so1589393ejb.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 08:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRVHl/t0ZfDdc2WRbM/q/wVK+uD2CLKiVJKjShKUl8Y=;
        b=xFekiRp3zLNyAb55FSUlKPnEqGRId3YMmeaM2WpuO+jdpqccVhFBUPYAB0xHlqz5iZ
         w/QU0XEV8+omQAAegHUDmBVRIczedO/S+rmq7xweZgqURgAaC5eQRsSu0R5bLke8faug
         CIYv73LH2PnahM1y3BOc+k/c4jfSVFbQzI3fYaN2NQDYsV7G7sBDNzjPO6Na9Bw6ydqL
         9g1ERK8eqCinuqFB/8TC3TfTCJRMRK9uxdJ/kItAhRrhx1u+z/y63wr5Gh6e0Y8ZvjzE
         tnsfFFhcxQnRbUq02vmMFm8VwXxFWQBqLCwq9I3Pncd9HcBGtYgPekeKP2ykXBhGt+1u
         S2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRVHl/t0ZfDdc2WRbM/q/wVK+uD2CLKiVJKjShKUl8Y=;
        b=g4hLgi0Ron4CXhbAC+qGIeo1FYZQpdHnAsG9XyyljEATrpL9jNVb5x/QeZ5whkT7nn
         OBW9qRdhUJN9Ih0Al4Y4jD7jPZvuQK5BQmLdgvVnh5V0yzHWIcqPNMIWPiaQJr2yAIqX
         IUKscJMp1UxuFWI38vQUCCyk213OoDbes7CxWy6vBPT1nPg5MartdjkjFP99Cb3HujIO
         ua5QRwNJhdcSLl2o+/7s9E6+FhnnYJ1Rn1bj9PVr4GxiF/KAzfmvo4N4khODDKg6z4/P
         WykRDnsW76sjQSw1llTrC71Rkhk+AckNflyQRFFllqCba0SBjAMhmEyUboAkhDAm0PWT
         eBzw==
X-Gm-Message-State: AOAM531aoIbrquGGlO3lqFE/SiZamFRhAnWi89ni5cJqVwSJGGn7CiH+
        64BzmYjY9R9ggQWyj/RVLLsqTAxCOJPjVKaF1s+X
X-Google-Smtp-Source: ABdhPJxlSVtgq9C/HRjhEg/xfu5YLb3ZCMFQO9CHu3f5MxIokumtinIZDGoB+Fxa3BQ28DVc9IAcOZqInWRbWshasDQ=
X-Received: by 2002:a17:907:216f:b0:6ce:d85f:35cf with SMTP id
 rl15-20020a170907216f00b006ced85f35cfmr4236294ejb.517.1648912088392; Sat, 02
 Apr 2022 08:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
 <CAHC9VhTaCNqfTOi8X5G3AheBFzTYCzGnt_-=fNFc5Z1o8gPm9Q@mail.gmail.com>
 <62465bf3.1c69fb81.d5424.365e@mx.google.com> <2777189.mvXUDI8C0e@x2>
 <CAHC9VhRYHhHPx42BKa0gp974uzwHoXZWqmwt9o=1rox7tHyy1w@mail.gmail.com> <624803f7.1c69fb81.972da.2dd0@mx.google.com>
In-Reply-To: <624803f7.1c69fb81.972da.2dd0@mx.google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 2 Apr 2022 11:07:57 -0400
Message-ID: <CAHC9VhTOQpk8oqyg_1Vh8QDjsMwJC6A-K7tTgRVYBB6ckqJ9qg@mail.gmail.com>
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
To:     CGEL <cgel.zte@gmail.com>
Cc:     Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
        kbuild-all@lists.01.org, Zeal Robot <zealci@zte.com.cn>,
        linux-kernel@vger.kernel.org, eparis@redhat.com,
        dai.shixin@zte.com.cn, Yang Yang <yang.yang29@zte.com.cn>,
        ink@jurassic.park.msu.ru, huang.junhua@zte.com.cn,
        guo.xiaofeng@zte.com.cn, mattst88@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 2, 2022 at 4:06 AM CGEL <cgel.zte@gmail.com> wrote:
> On Fri, Apr 01, 2022 at 10:16:45AM -0400, Paul Moore wrote:
> > On Fri, Apr 1, 2022 at 9:39 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > >
> > > On Thursday, March 31, 2022 9:57:05 PM EDT CGEL wrote:
> > > > On Thu, Mar 31, 2022 at 10:16:23AM -0400, Paul Moore wrote:
> > > > > On Wed, Mar 30, 2022 at 10:29 PM CGEL <cgel.zte@gmail.com> wrote:
> > > > > > On Wed, Mar 30, 2022 at 10:48:12AM -0400, Paul Moore wrote:
> > > > > > > If audit is not generating SYSCALL records, even for invalid/ENOSYS
> > > > > > > syscalls, I would consider that a bug which should be fixed.
> > > > > >
> > > > > > If we fix this bug, do you think audit invalid/ENOSYS syscalls better
> > > > > > be forcible or be a rule that can be configure? I think configure is
> > > > > > better.
> > > > >
> > > > > It isn't clear to me exactly what you are asking, but I would expect
> > > > > the existing audit syscall filtering mechanism to work regardless if
> > > > > the syscall is valid or not.
> > > >
> > > > Thanks, I try to make it more clear. We found that auditctl would only
> > > > set rule with syscall number (>=0 && <2047) ...
> >
> > That is exactly why I wrote the warning below in my response ...
> >
> I think the question is more clear now.
>
> 1) libaudit.c wants to forbid setting invalid syscall, but inconsistent
> Currently way(>=0 && <2047) is inconsistent, syscall with number 2000 and
> syscall with number 3000 are both invalid syscall. But 2000 can be set by
> auditctl, and 3000 cannot be set by auditctl.
> A better way to do this forbidden is to use __NR_syscalls(asm-generic/unistd.h).
>
> 2) if libaudit.c do the right forbidden, kernel better ignore invalid syscall
> See this patch.
>
> If we want audit invalid syscall as you said before. libaudit.c should not
> do the forbidden, auditctl should allow setting syscall rule with 'any' number.
> So do you think we should fix libaudit.c?

I'm really not very clear on what you are proposing, but we can't
change the kernel/userspace API in any way which would break
compatibility with old/existing userspace tools.

-- 
paul-moore.com
