Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D424EE5DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 03:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243908AbiDAB7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 21:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiDAB7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 21:59:01 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F58525846E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:57:10 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id d65so1062523qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 18:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=its5ZVzLNySBxXzZdl/ejpOgC699lFgiSCphdNqxw3M=;
        b=C+GinWkGW9kXz8S6iY+9Pa9rt93JXP8qXPcM7cyM/jl5JN0MK/MszALO65g7eVVcNo
         moXRGmHiuJcQWFwiOgIjWa+tDd9pU344v6THdrDj/wl4eFD4I051N/1xdLob+ilsA6rb
         gVbS1yJI9UAm/3LHAIclPG45LI6qw3xBwRwr9D5wMgLREvzX6Ie2NSZ4ivgpOMe0QgXl
         BB1gsGEOaO1InqfxQAEmO/kUsu6LhCc9NxFvJs0e6u+HyJA12v6rJdIsGZqPUJ/MuzAp
         tJxvdzG7jnekAAIQAhQ2ICFITGWS70nHoVdgbjbmPy0iRvi6xm9cylIgnzdWXk5nqLLU
         /Vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=its5ZVzLNySBxXzZdl/ejpOgC699lFgiSCphdNqxw3M=;
        b=B/hTDzk4osJu72t9x6hc2YCWRonEopDfaOhco1rcpsHw+QEHrNsyPjqt7ykWtntaCf
         Ipw49ARdA5Wrr2wVNz0f4T/4R7D31cgU5FXMbN5FiSi1c0CV3hPT2T5z0XP8w9tXN4SB
         XmtMtHDScCyAoCJt6Esh4VFrUbR5W9oJnCTsSysZ8WWLk6mFLFYyx65cQK5gdJTQXhPu
         xh/8U3Ld/1T2QMtLszBovNzBzPREazQGupUhXFYeW45uv/vkbRi6m8mIl6MydPfws1+5
         kwCfb2t4Om42u6rNe1NRrvY2Jk5XpTu+TfoWL5iA2/NmR45J3R+wvP3jDo4QQQS9FtSx
         WVQg==
X-Gm-Message-State: AOAM533aQXZo7ROnIoiTplx9Cqq4wyJF3QZGyJ+UX2eG0/7Q9PJu1U5K
        G+CigKbAI10xynRrTKI671Q=
X-Google-Smtp-Source: ABdhPJw5E4iL6lKbhxPnTqk3ytLmMT3d0XS35G1p5m72cwroJPbaVszP2yOmiqWTcX/HWoqtsqrWfw==
X-Received: by 2002:a05:620a:17a6:b0:67d:85e6:a86b with SMTP id ay38-20020a05620a17a600b0067d85e6a86bmr5161830qkb.771.1648778229629;
        Thu, 31 Mar 2022 18:57:09 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p64-20020a37a643000000b0067d9afad07asm540901qke.76.2022.03.31.18.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 18:57:07 -0700 (PDT)
Message-ID: <62465bf3.1c69fb81.d5424.365e@mx.google.com>
X-Google-Original-Message-ID: <20220401015705.GB2404167@cgel.zte@gmail.com>
Date:   Fri, 1 Apr 2022 01:57:05 +0000
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
 <6245121e.1c69fb81.ea0ab.0c2e@mx.google.com>
 <CAHC9VhTaCNqfTOi8X5G3AheBFzTYCzGnt_-=fNFc5Z1o8gPm9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTaCNqfTOi8X5G3AheBFzTYCzGnt_-=fNFc5Z1o8gPm9Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:16:23AM -0400, Paul Moore wrote:
> On Wed, Mar 30, 2022 at 10:29 PM CGEL <cgel.zte@gmail.com> wrote:
> > On Wed, Mar 30, 2022 at 10:48:12AM -0400, Paul Moore wrote:
> > >
> > > If audit is not generating SYSCALL records, even for invalid/ENOSYS
> > > syscalls, I would consider that a bug which should be fixed.
> >
> > If we fix this bug, do you think audit invalid/ENOSYS syscalls better
> > be forcible or be a rule that can be configure? I think configure is
> > better.
> 
> It isn't clear to me exactly what you are asking, but I would expect
> the existing audit syscall filtering mechanism to work regardless if
> the syscall is valid or not.  

Thanks, I try to make it more clear. We found that auditctl would only
set rule with syscall number (>=0 && <2047). So if userspace using
syscall whose number is (<0 || >=2047), there seems no meaning for
kernel audit to handle it, since this kind of syscall will never hit
any audit rule(this rule could not be set by auditctl).

By the way it's a little strange for auditctl(using libaudit.c) to limit
syscall number (>=0 && <2047)(see audit_rule_syscall_data()), especially
we know NR_syscalls is the real limit in kernel, you can see how other
kernel code to the similar thing in ftrace_syscall_enter():

	static void ftrace_syscall_enter(void *data, struct pt_regs
	*regs, long id)
	{
		...
		syscall_nr = trace_get_syscall_nr(current, regs);
		if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
			return;
		...
	}

Thanks.
> Beware that there are some limitations
> to the audit syscall filter, which are unfortunately baked into the
> current design/implementation, which may affect this to some extent.
> 
> -- 
> paul-moore.com
