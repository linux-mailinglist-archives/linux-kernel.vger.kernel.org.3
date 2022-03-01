Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791D94C943A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiCAT1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbiCAT1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:27:51 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C287069CFA;
        Tue,  1 Mar 2022 11:27:09 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so3143766pjb.0;
        Tue, 01 Mar 2022 11:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sjfszq0s6rA1DoiuWgRAAaEXXX3ctOb/kx6v17T7+bs=;
        b=BUf/UxXV9ZTYi6bHIcNSeiVmUkwhpOMtCQdiWC+ay4Z9S5wpiOYuCXCIxzehzgVk+o
         W1Tz6uC//wm7JDPdHnohPUL8ayfoRdAEJXWOuhp93F6AdjS5zhsdIRdXcMl7LoOxgL5S
         cQ30ZduAtMTvuIT0IWAMAwvVyturUwj7e81GnYaWkgLwpGQx/29YuWDIvgD88vu2/cB6
         lIW0y9fMxEHGPAxzIoTAq6cd1acGDgmWfhBtF0rb1zYTJ9wsVCsqlUD6L5WIt+Ny+URQ
         qK/qz8orT5hZdWRoZ/8JDnt+u1fh9VpSE+nS2ipRNMJp4cJoUQCsCZ7QfPYtwzh2NcxW
         Yddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sjfszq0s6rA1DoiuWgRAAaEXXX3ctOb/kx6v17T7+bs=;
        b=5mJ9AYED6j+w2OH8ffop1Ob7J8Mp1YCNk+fqKEPXibEWIGxUcKXEm9zwHxQVI26kDE
         FKvKjEL5/ji+nHsuWEmhl2aZoO5jhizCAU+k45ZOBifIupq9ZRU3V69DTIHCxoVmlsBW
         dwQeD2jBgORBejHQV/ZTW6jh2hiftr52WTdYiFQGgQr/zZZ01GUA4dgqmxK0ztuSuYwv
         k8W2arnbeJS1+GtVrwRmM2vQJozCcwS+WkkSt8XKN1kBoDjaVBcROvyM+2/lgeGlvwpM
         bZUHVu6GLqQaZOXOqqMwZfqN2AWUKvf/oSrPAwqZvbJvCfc07xpH/dju+w45t4euSVye
         JPuQ==
X-Gm-Message-State: AOAM531CjYnwsB4GLqq7u6i4F+EuMOF+50gfTH8Z2F2cMt+ZKgQ3lPOM
        Pd7UFHD+5A6VLB2qO2EzVxPv9BDet04lNA==
X-Google-Smtp-Source: ABdhPJzLhA38IVBgeS0jS6fmXrfvYXbSfkWLFcH+ksuu9OxckKZQpge4EPfXA8PI1btrQvPsQzH6hA==
X-Received: by 2002:a17:90b:4001:b0:1bc:68ec:ce48 with SMTP id ie1-20020a17090b400100b001bc68ecce48mr23182579pjb.133.1646162828937;
        Tue, 01 Mar 2022 11:27:08 -0800 (PST)
Received: from kitty ([12.231.191.170])
        by smtp.gmail.com with ESMTPSA id u9-20020a056a00158900b004de90b164d0sm19309394pfk.9.2022.03.01.11.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 11:27:08 -0800 (PST)
From:   10maurycy10@gmail.com
X-Google-Original-From: mz@kitty
Date:   Tue, 1 Mar 2022 11:27:16 -0800
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org
Subject: Re: Re: [PATCH RFC v0] random: block in /dev/urandom
Message-ID: <Yh5zA1T9GRBFi5H9@kitty>
References: <20220211210757.612595-1-Jason@zx2c4.com>
 <fcab986b-d0bd-c798-de17-266abcdc7da2@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcab986b-d0bd-c798-de17-266abcdc7da2@gentoo.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 06:05:54PM -0500, Joshua Kinard wrote:
> On 2/11/2022 16:07, Jason A. Donenfeld wrote:
> > This is very much an RFC patch, or maybe even an RFG -- request for
> > grumbles. This topic has come up a million times, and usually doesn't go
> > anywhere. This time I thought I'd bring it up with a slightly narrower
> > focus. Before you read further, realize that I do not intend to merge
> > this without there being an appropriate amount of consensus for it and
> > discussion about it.
> > 
> > Ever since Linus' 50ee7529ec45 ("random: try to actively add entropy
> > rather than passively wait for it"), the RNG does a haveged-style jitter
> > dance around the scheduler, in order to produce entropy (and credit it)
> > for the case when we're stuck in wait_for_random_bytes(). How ever you
> > feel about the Linus Jitter Dance is beside the point: it's been there
> > for three years and usually gets the RNG initialized in a second or so.
> >

What about the case where a small amount of entropy is avalable?

> > 
> > As a matter of fact, this is what happens currently when people use
> > getrandom(2).
> > 
> > So, given that the kernel has grown this mechanism for seeding itself
> > from nothing, and that this procedure happens pretty fast, maybe there's
> > no point any longer in having /dev/urandom give insecure bytes. In the
> > past we didn't want the boot process to deadlock, which was
> > understandable. But now, in the worst case, a second goes by, and the
> > problem is resolved. It seems like maybe we're finally at a point when
> > we can get rid of the infamous "urandom read hole".
> >

Why not keep the distinction between /dev/random and /dev/urandom when a
good entropy source is not avalable?

> > 
> > Maybe. And this is why this is a request for grumbles patch: the Linus
> > Jitter Dance relies on random_get_entropy() returning a cycle counter
> > value. The first lines of try_to_generate_entropy() are:
> > 
> > 	stack.now = random_get_entropy();
> > 	/* Slow counter - or none. Don't even bother */
> > 	if (stack.now == random_get_entropy())
> > 		return;
> > 
> > So it would appear that what seemed initially like a panacea does not in
> > fact work everywhere. Where doesn't it work?
> > 
> > On every platform, random_get_entropy() is connected to get_cycles(),
> > except for three: m68k, MIPS, and RISC-V.
> > 
> 
> [snip]
> 
> > 
> > I think what this adds up to is that this change would positively affect
> > everybody, except for _possibly_ negatively affecting poorly configured
> > non-Amiga m68k systems and the MIPS R6000 and R6000A. Does that analysis
> > seem correct to folks reading, or did I miss something?
> > 
> > Are there other cases where the cycle counter does exist but is simply
> > too slow? Perhaps some computer historians can chime in here.
> > 
> > [snip]


This should realy be a config flag. (URANDOM_SECURE_RANDOM?).

> 
> 
> -- 
> Joshua Kinard
> Gentoo/MIPS
> kumba@gentoo.org
> rsa6144/5C63F4E3F5C6C943 2015-04-27
> 177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943
> 
> "The past tempts us, the present confuses us, the future frightens us.  And
> our lives slip away, moment by moment, lost in that vast, terrible in-between."
> 
> --Emperor Turhan, Centauri Republic
