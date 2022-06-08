Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7015424A9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiFHGE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 02:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbiFHFxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:53:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E183D3FD4;
        Tue,  7 Jun 2022 20:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654660290; x=1686196290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xIcozfLdj0wmlKDo/KeNlOUgX9nLL33V5khVHg6L5cw=;
  b=HeipGJE1YzPf55S7sWokvQD54aI9Hfi0GkiUOPPEoGyxD8+PI5oBTAcM
   fnNl/vzar2vF2c3QtdEX2ejk+/TkN18N5vN41PbNu1qQaj0U9WLytowoU
   xoaI6i003A23I52yWoCK1rseLAmLhSLZvb/8tjChfOnyC/VFnrj0w9VTB
   rgaLoJzjIUJE6C9DzLE/Fklim+dOgiX2np4CU1Ym5ZSOR9Z7d6HznDMuj
   9XGX80nA+kjSQOHWqBNmow9YFDDzlYBxAsOCzP+RgOy1fUSh9Dd+KoJmy
   3Ub4HNGQBqsJskHq0iuJQGEbIgPnWU59pXbXfUhTSNPTKEI4xHol+LmC8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="274317878"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="274317878"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 20:51:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="636530713"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.142])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 20:51:26 -0700
Date:   Wed, 8 Jun 2022 11:49:53 +0800
From:   Philip Li <philip.li@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-all] Re: [linux-next:master 728/1207]
 fs/xfs/xfs_file.c:1266:31: sparse: sparse: incorrect type in return
 expression (different base types)
Message-ID: <YqAcYYydYqMef+wi@rli9-dbox>
References: <202206071511.FI7WLdZo-lkp@intel.com>
 <20220607160546.2a0a826d29bec858ca402720@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607160546.2a0a826d29bec858ca402720@linux-foundation.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 04:05:46PM -0700, Andrew Morton wrote:
> On Tue, 7 Jun 2022 15:09:18 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > head:   73d0e32571a0786151eb72634f1a4c5891166176
> > commit: d5f5b32dee7c09e3152cbbce45c73f0b1ea7d94c [728/1207] xfs: support CoW in fsdax mode
> > config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220607/202206071511.FI7WLdZo-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.4-18-g56afb504-dirty
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d5f5b32dee7c09e3152cbbce45c73f0b1ea7d94c
> >         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >         git fetch --no-tags linux-next master
> >         git checkout d5f5b32dee7c09e3152cbbce45c73f0b1ea7d94c
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/xfs/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > 
> > sparse warnings: (new ones prefixed by >>)
> > >> fs/xfs/xfs_file.c:1266:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted vm_fault_t @@
> >    fs/xfs/xfs_file.c:1266:31: sparse:     expected int
> >    fs/xfs/xfs_file.c:1266:31: sparse:     got restricted vm_fault_t
> > >> fs/xfs/xfs_file.c:1260:1: sparse: sparse: symbol 'xfs_dax_fault' was not declared. Should it be static?
> > >> fs/xfs/xfs_file.c:1314:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted vm_fault_t [usertype] ret @@     got int @@
> >    fs/xfs/xfs_file.c:1314:21: sparse:     expected restricted vm_fault_t [usertype] ret
> >    fs/xfs/xfs_file.c:1314:21: sparse:     got int
> > 
> > Please review and possibly fold the followup patch.
> 
> Well yes, the followup patch
> (https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/xfs-support-cow-in-fsdax-mode-fix.patch)
> will most definitely be folded.

Sorry, currently we disable the auto patch, this sentence "Please review and possibly fold the followup patch"
is misleading. We will not have follow up patch before we can have human to
do a check.

> 
> Can you suggest how this can be communicated to the robot in order to
> suppress this notification?  A Fixes: won't work, as neither of these
> patches have yet been promoted to a "stable" state.  Their hashes will
> change.

Got it, we also think the Fixes tag in the proposed patch brings confusion
if the "bad" commit is in development state. So far, we haven't exposed a
way to feedback the "Fixes: won't work", but we will work on some level
of mail based communication in 2nd half this year, which can simplify the
communication like this.

Anyway, we now disable the auto patch to avoid bring confusion and sometimes
wrong patch without human check.

> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
