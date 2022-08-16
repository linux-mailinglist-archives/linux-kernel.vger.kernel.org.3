Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CAA5952B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiHPGk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiHPGj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:39:57 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68FE8F971;
        Mon, 15 Aug 2022 20:25:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dc19so16619619ejb.12;
        Mon, 15 Aug 2022 20:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0+fOHte+oOjdt0ZcS9IxeZxJv4FE7v9fXbd9M9vTVIU=;
        b=KpnzdQRG3/WPprMvYVg5B3iZfpc5bUgwIiRuujqtM8qqYLp5nR8x01nJ5ZS1xvL4uy
         871+vwwCOc0PkvDt0siufAeAvqFMyj3JcLqAgmA53l/CKS9Sw87+XeRs4L/vdhGF9Qb8
         vQr4ksYMFRpJxhkifOawB1CCYt5Ez29v4PeyZxtvNg0lZ3xl2hVyclINQ/AJCgyoVP4k
         FW+03YnPcO8gPujo9nCTQ1LI5qEQE3B+Vqy2lUbFwhYO6XFmo0rckz82YVudlT0BQiF6
         2MeZ2KAdjj3yRRykrleJ7rIpNyIWorxYK8y73Jk4M/yBXD8vWI9M2Wd0M6Lx6tvYlOOJ
         M4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0+fOHte+oOjdt0ZcS9IxeZxJv4FE7v9fXbd9M9vTVIU=;
        b=rnsM3rnt7WRz9Phw7Luz5e1w1mWH0xmbbGdPLMFMh6KGDqleshmxLWGZDSphy7n5JK
         mHzo0V5XvZ4WGFinmvcY2j7N/Tx39tCpOw/74aIY8MKdY1asp93+h20lO+x5bo6hERcG
         r4uu8fQWFZ2Y+Qj/ELFDTiGmjMxG9uXqQAJYv4ZtibLrcDLLbIXRZScNW+6eeOzdgWVC
         5Lp2pQHOGVnlBtr/WkdAmVU8wdzBxEreMeOEFHW7feQ2fRCclWXtbrpqJpms9I7dkCJR
         rtJ7hAsnCTNDI3C5Tl+k0ebVMawphHO0Y3fAfd8usNL+gK2IFAirN6gvMHD1wxbgYisl
         j/gA==
X-Gm-Message-State: ACgBeo0SpsGyT3bDHT5iyIQy5/ZE0I8IoaZbMcNtKF51POyaeZOxt1xy
        DVe567ph+1dreIKOkoE+BJkH7OU0xzqweovTLSk=
X-Google-Smtp-Source: AA6agR5oYGYEN7tCYcsQ/OzI6j2xbu1zrOO3eqEuqP57x4iCag+XkjYWhCQ30rAR4Jnv1yY7d+T0zoSsowi2FCi0TFk=
X-Received: by 2002:a17:907:d9e:b0:731:1a5:8c68 with SMTP id
 go30-20020a1709070d9e00b0073101a58c68mr12186610ejc.365.1660620324829; Mon, 15
 Aug 2022 20:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220815175114.23576-1-konishi.ryusuke@gmail.com>
 <YvqP/f2P2YgIIO9U@ZenIV> <CAKFNMomyjXpsz-=BtG+G3q1J7CFUBMEfP13FfxwhWB==9qb++w@mail.gmail.com>
 <YvrQ8xO9Lx7rdKq8@ZenIV> <CAKFNMoniwM5x0w03cezGTFDWt=apNmGWpur83+vjghg3zcawpQ@mail.gmail.com>
In-Reply-To: <CAKFNMoniwM5x0w03cezGTFDWt=apNmGWpur83+vjghg3zcawpQ@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 16 Aug 2022 11:24:10 +0800
Message-ID: <CAD-N9QW5-kVR85t1canTqrF9RMkOjC1Z2q8BSQKxLwaay97Mgg@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix use-after-free bug in nilfs_mdt_destroy()
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiacheng Xu <stitch@zju.edu.cn>
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

On Tue, Aug 16, 2022 at 11:11 AM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> On Tue, Aug 16, 2022 at 8:04 AM Al Viro wrote:
> >
> > On Tue, Aug 16, 2022 at 05:34:12AM +0900, Ryusuke Konishi wrote:
> >
> > > Yes, I agree it's better if security_inode_alloc() is moved to the end as
> > > possible in the sense of avoiding similar issues.
> > > But, would that vfs change be safe to backport to stable trees?
> >
> > Yes.
> >
> > > It looks like the error handling for security_inode_alloc()  is in the
> > > middle of inode_init_always() for a very long time..
> >
> > Look at the initializations done after it.  The only thing with effects
> > outside of inode itself is (since 2010) an increment of nr_inodes.
> >
> > > If you want to see the impact of the vfs change, I think it's one way
> > > to apply this one in advance.  Or if you want to fix it in one step,
> > > I think it's good too.  How do you feel about this ?
> >
> > IMO that should go into inode_init_always(), with Cc:stable.  If you
> > (or Dongliang Mu, or anybody else) would post such variant with
> > reasonable commit message, I'll pick it into vfs.git and feed to Linus
> > in the next window.  E.g. into #work.inode, with that branch being
> > made never-rebased, so that you could pull it into your development
> > branch as soon as it's there...
>
> I agree with your thoughts on the course of action.
> Andrew, I withdraw this patch.
>
> Dongliang (or Jiacheng?), would it be possible for you to post a revised patch
> against inode_init_always() that moves the call of security_inode_alloc()
> instead of i_private initialization (as Al Viro said in a nearby thread [1]) ?
> If you have time, I would like to leave it to you since you wrote the
> original patch for inode_init_always().

Sure, I will post a v2 patch that moves security_inode_alloc to the
location just prior to
        this_cpu_inc(nr_inodes);
with proper commit message.

>
> [1] https://lkml.kernel.org/r/CAO4S-mficMz1mQW06EuCF+o11+mRDiCpufqVfoHkcRbQbs8kVw@mail.gmail.com
>
> Thanks,
> Ryusuke Konishi
