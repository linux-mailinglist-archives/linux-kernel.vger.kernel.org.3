Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5BA49A7FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1315783AbiAYCyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3408501AbiAYAWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:22:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352DBC036BE4;
        Mon, 24 Jan 2022 14:06:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2767615CF;
        Mon, 24 Jan 2022 22:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACCBC340F8;
        Mon, 24 Jan 2022 22:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643061989;
        bh=s0Q2iLX9dyK6zBfXvE6AmOg6Y4MPmiUDjoi2MZ8nbRI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BB8Mpx1LnwvDuTkbA0cXddeZ/rQmtoz8pUu0UU6grzafB6tLVMViJeDK0RQZji0pa
         ALjXmDrGSFz3XxbxVxzAwQI37Jrd1WyjAs4m0uinFAz/wQMNAGxQ+XlElHAM7N9Z2O
         CNuHrOf/n3Osqripl7Pwbn+uu34DRbgdl8p2qx+km9d9A51sLduueP3C2eCmviHrQM
         kWhX/ZhSpD9LMiR/NvcdNf5eocL/fFS9RK/MFN7rIxhtS4ddTPaXsHQfQq7uGT86Nf
         TVaZfoKOH0mQklFjLmq4GHpu0BEGXBmTNPAQqUG/7IbD9zXl2timujV65yhcCpbQFr
         HTcL+lDGlz7Yg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DDF295C0FCD; Mon, 24 Jan 2022 14:06:28 -0800 (PST)
Date:   Mon, 24 Jan 2022 14:06:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-sparse@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32
 degrades to integer
Message-ID: <20220124220628.GL4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202201221028.YKA8kSdm-lkp@intel.com>
 <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
 <91901e7b-7d82-116c-aaf2-c74c6a6b999c@infradead.org>
 <CAK-6q+j2jc3pBmbvQ-DCmxveC-UMV75SFc2nC1zwXKe9wm4YPg@mail.gmail.com>
 <20220124124530.GS1951@kadam>
 <CAK-6q+iZfY=FyOxJfS7cY7MqScs+nU=U3B4NnLnvcLH3fofuAg@mail.gmail.com>
 <CAK-6q+ga2zT2h4oY0=aCXFeU=oaFHbSXGzuVRptB8Hg-YKR7Gw@mail.gmail.com>
 <CAK-6q+jfA2k1TFrLqK4YN2vshgLidD=6r_CCV6df_VRFMFO7ag@mail.gmail.com>
 <20220124201417.GI4285@paulmck-ThinkPad-P17-Gen-1>
 <CAK-6q+gGx68Wx8mBJAdo0ygpBWPoHW+L+HD11U6UQSOjSXVP3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK-6q+gGx68Wx8mBJAdo0ygpBWPoHW+L+HD11U6UQSOjSXVP3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 04:36:55PM -0500, Alexander Aring wrote:
> Hi,
> 
> On Mon, Jan 24, 2022 at 3:23 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Jan 24, 2022 at 12:41:04PM -0500, Alexander Aring wrote:
> > > Hi,
> > >
> > > On Mon, Jan 24, 2022 at 12:36 PM Alexander Aring <aahringo@redhat.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Mon, Jan 24, 2022 at 12:21 PM Alexander Aring <aahringo@redhat.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Mon, Jan 24, 2022 at 7:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > > > >
> > > > > > On Sun, Jan 23, 2022 at 01:41:52PM -0500, Alexander Aring wrote:
> > > > > > >
> > > > > > > I see also:
> > > > > > >
> > > > > > > fs/dlm/midcomms.c:213:1: sparse: sparse: symbol
> > > > > > > '__srcu_struct_nodes_srcu' was not declared. Should it be static?
> > > > > > >
> > > > > >
> > > > > > Why not just do this?  (Untested.  Maybe I don't understand?)
> > > > > >
> > > > > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > > > > index cb1f4351e8ba..a164089abec4 100644
> > > > > > --- a/include/linux/srcutree.h
> > > > > > +++ b/include/linux/srcutree.h
> > > > > > @@ -121,7 +121,7 @@ struct srcu_struct {
> > > > > >  #ifdef MODULE
> > > > > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > > > > >         is_static struct srcu_struct name;                              \
> > > > > > -       struct srcu_struct * const __srcu_struct_##name                 \
> > > > > > +       is_static struct srcu_struct * const __srcu_struct_##name       \
> > > > > >                 __section("___srcu_struct_ptrs") = &name
> > > > > >  #else
> > > > > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > > > > >
> > > > >
> > > > > I tried it and yes it will fix the issue and introduce another one
> > > > > about "is_static struct srcu_struct * const __srcu_struct_##name" is
> > > > > unused ("-Wunused-const-variable").
> > > > > I added a __maybe_unused after the introduced is_static and it seems
> > > > > to fix the introduced issue, now it compiles and sparse is happy. I am
> > > > > not sure if this is the right fix?
> > > >
> > > > it is obviously unused, but it has something to do with
> > > > "__section("___srcu_struct_ptrs")" and during module loading it, I
> > > > suppose, srcu tries to access it to find whatever needs to be
> > > > registered?
> > >
> > > Sorry, but if this is true then it can't be declared as static... and
> > > we are at the beginning again.
> >
> > Welcome to my world!!!  ;-)
> >
> > More seriously, thank you for chasing this down.  But would it work to
> > add a declaration just before?
> >
> 
> only if I add an "extern" in front of the declaration before, so it looks like:
> 
> extern struct srcu_struct * const __srcu_struct_##name;
> 
> (compile and sparse tested only)

If that works for everyone, it seems worth persuing.

One way to test this is as follows:

1.	Build a kernel with CONFIG_RCU_TORTURE_TEST=m.  Boot this and
	type "modprobe rcutorture torture_type=srcu".

	If you want to stop the torture test, type "rmmod rcutorture".

	This will test DEFINE_SRCU() for the module case.

2.	At the top-level directory of your Linux-kernel source tree,
	type "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3 --configs 'SRCU-N' --trust-make"

	This will test DEFINE_SRCU() for the non-module case.

If those both work, and if there are no other objections or complications,
please do send a patch.

							Thanx, Paul
