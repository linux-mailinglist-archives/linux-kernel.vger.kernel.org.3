Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B56490896
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbiAQMV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:21:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:35878 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239831AbiAQMV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642422116; x=1673958116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7hL98B8VHA8BYC2ePlx10Jl7+f4j5WgTIvH4DR1v8/A=;
  b=Dj2XJEjNH2WR1p0OE/MqIeNDn+vwwD+anX8ggMhtzdxvST7zO37PlwCC
   qFZEgO2MVZjapuj9apO/0ZNvgicTXMwoT89Exv+8/7yrKLOtZ97nYzKSq
   0Bn5KBX5tC/h1uHn3jfk/+fudF6UOd7WtRNt5IIRcgyNuUmC3m4lUNBzW
   jwXLoHRknZPeKdvPhyDDwXvNwioOR9l+ciC8/Zgd3mTPVFh+DgnIbfNEo
   o2C5zFC3RhggVoTJwtJVKAPaxC9Nopn4o82LGVuGXUBsNcNzCRwXXaJgJ
   L3PwoMgNvz7tRaPAgbWBN9CpzjZHM+paMPJI2jGyK3sZSakTqcgGHG/tC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="244810538"
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="244810538"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 04:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,295,1635231600"; 
   d="scan'208";a="671544346"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 17 Jan 2022 04:21:53 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 17 Jan 2022 14:21:52 +0200
Date:   Mon, 17 Jan 2022 14:21:52 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, linux-usb@vger.kernel.org
Subject: Re: [Bug][5.17-rc0] Between commits daadb3bd0e8d and 455e73a07f6e,
 the kernel stops loading on my devices.
Message-ID: <YeVfYOhxGTgg8VpZ@kuha.fi.intel.com>
References: <CABXGCsNb22JCJ4AyR1sYqFtF4QUnvM3B2zQcc1svcm2mquWxoA@mail.gmail.com>
 <YeUvvIaVJnJrrpYe@kuha.fi.intel.com>
 <CABXGCsO5PYBuZ11YR16NLLa0H07Jom1JQhWHFuETfotfBfzkMw@mail.gmail.com>
 <YeVQsRp7aDMcQKs7@kuha.fi.intel.com>
 <CABXGCsMWXFFQY3L8ixK9K-gYX41_gTjqHRBXNp6gDpUgdnvFfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsMWXFFQY3L8ixK9K-gYX41_gTjqHRBXNp6gDpUgdnvFfg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 04:52:02PM +0500, Mikhail Gavrilov wrote:
> On Mon, 17 Jan 2022 at 16:19, Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> 
> > I don't know which tree you are working on top of, but the patch
> > applies just fine on top of Linus' latest master branch:
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >
> 
> Same here.
> 
> $ git remote -v
> origin    git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> (fetch)
> origin    git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> (push)
> 
> $ git show
> commit 0c947b893d69231a9add855939da7c66237ab44f (HEAD -> master,
> origin/master, origin/HEAD)
> Merge: a6097180d884 9bbf8662a27b
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Mon Jan 17 09:53:21 2022 +0200
> 
>     Merge tag '5.17-rc-part1-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6
> 
>     Pull cifs updates from Steve French:
> 
>      - multichannel patches mostly related to improving reconnect behavior
> 
>      - minor cleanup patches
> 
>     * tag '5.17-rc-part1-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6:
>       cifs: fix FILE_BOTH_DIRECTORY_INFO definition
>       cifs: move superblock magic defitions to magic.h
>       cifs: Fix smb311_update_preauth_hash() kernel-doc comment
>       cifs: avoid race during socket reconnect between send and recv
>       cifs: maintain a state machine for tcp/smb/tcon sessions
>       cifs: fix hang on cifs_get_next_mid()
>       cifs: take cifs_tcp_ses_lock for status checks
>       cifs: reconnect only the connection and not smb session where possible
>       cifs: add WARN_ON for when chan_count goes below minimum
>       cifs: adjust DebugData to use chans_need_reconnect for conn status
>       cifs: use the chans_need_reconnect bitmap for reconnect status
>       cifs: track individual channel status using chans_need_reconnect
>       cifs: remove redundant assignment to pointer p
> 
> $ cat 0001-usb-typec-Test-fix.patch | git apply
> error: patch failed: drivers/usb/typec/port-mapper.c:56
> error: drivers/usb/typec/port-mapper.c: patch does not apply

Have you modified the file, or something else that you have not
committed yet?

        % git status

Checkout the file, and then try to apply the patch:

        % git checkout drivers/usb/typec/port-mapper.c
        % git apply -v 0001-usb-typec-Test-fix.patch

thanks,

-- 
heikki
