Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFAD49AE67
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452418AbiAYIsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:48:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:3576 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452098AbiAYIpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643100329; x=1674636329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yQ7GGbQ6YDW3oSMj6icbaNxTlAvHdxcNnTTpnvf2jR4=;
  b=Es1WmWid8Rpq1a6pCTF8Z0mC+fJUYkPhWSfA0ku9RE5yVp6HF65ykT/U
   dzLUKzkSvdrdIaNgjnZF5fjrZp/cEQpj0DfUKjFk3YAjJ1fFDBuLvDJgX
   QEHDzWrTCNtX4ZTNJIcdfwCdkttV0l7Wp7aA5ouH/ZkHU+bnIAj/+xl2/
   nwWzMRv7DgHVJJah2p8M0DnzzsQ7R/t+ZpmnA8Pg9FXxYNxUyYDCDCSBK
   cwnoEVdDeJXpBs5tCefFJMiKzpwoip0spkUDGsAVX2EaoeK8OC1DVwr4H
   lkCMNP44YaPNBrBcNcDzka2dRT2n5XS9L6qRU9lYMzZqmk9md/PzJdYYJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="332609112"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="332609112"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 00:43:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="673923145"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 25 Jan 2022 00:43:31 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 25 Jan 2022 10:43:30 +0200
Date:   Tue, 25 Jan 2022 10:43:30 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Len Brown <lenb@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, linux-usb@vger.kernel.org,
        YongQin Liu <yongqin.liu@linaro.org>
Subject: Re: [Bug][5.17-rc0] Between commits daadb3bd0e8d and 455e73a07f6e,
 the kernel stops loading on my devices.
Message-ID: <Ye+4MpCFeWScLBEr@kuha.fi.intel.com>
References: <YeUvvIaVJnJrrpYe@kuha.fi.intel.com>
 <CABXGCsO5PYBuZ11YR16NLLa0H07Jom1JQhWHFuETfotfBfzkMw@mail.gmail.com>
 <YeVQsRp7aDMcQKs7@kuha.fi.intel.com>
 <CABXGCsMWXFFQY3L8ixK9K-gYX41_gTjqHRBXNp6gDpUgdnvFfg@mail.gmail.com>
 <YeVfYOhxGTgg8VpZ@kuha.fi.intel.com>
 <CABXGCsOwsP7NJ67oyK3HPs2EarSJKLB9EVW7oEh+8bAFihSa8g@mail.gmail.com>
 <Yea8p1b/sZYKNGaB@kuha.fi.intel.com>
 <YebBq/WDeYCIvwYw@kuha.fi.intel.com>
 <CANcMJZDrs418aUoVS4CijQFqgAW3pCbfm_NUCmx+T7HNoiMVnQ@mail.gmail.com>
 <CAJvTdKnMKdQ6KJe63phZ87kJz2SjeQoNTHqajSfv4RJo6+Y6jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJvTdKnMKdQ6KJe63phZ87kJz2SjeQoNTHqajSfv4RJo6+Y6jw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 06:00:24PM -0500, Len Brown wrote:
> Tested-by: Len Brown <len.brown@intelcom>
> 
> The typec_link_ports crash goes away w/ the 2nd patch.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=215529

That patch was already sent out:
https://lore.kernel.org/linux-usb/20220124090228.41396-3-heikki.krogerus@linux.intel.com/

thanks,

> On Fri, Jan 21, 2022 at 4:33 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > On Thu, Jan 20, 2022 at 3:27 AM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > > On Tue, Jan 18, 2022 at 03:12:10PM +0200, Heikki Krogerus wrote:
> > > > I can reproduce this one by simply not creating the component list in
> > > > the code. That function - component_master_add_with_match() - can't
> > > > handle situation where the list is empty. I'll prepare the fix.
> > >
> > > I'm again attaching the proposed fix, just to see if it also gets
> > > corrupted. Can you test does it fix this issue?
> > > You need to apply it on top of the previous one.
> >
> > We've been hitting the null pointer crash from
> > component_master_add_with_match() regression as well on the hikey960
> > board.
> >
> > The patch you attached resolves the issue. It would be great to see it
> > merged upstream soon!
> >
> > Tested-by: John Stultz <john.stultz@linaro.org>
> >
> > thanks
> > -john
> 
> -- 
> Len Brown, Intel Open Source Technology Center

-- 
heikki
