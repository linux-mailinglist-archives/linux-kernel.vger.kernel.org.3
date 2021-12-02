Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A5046653C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351374AbhLBOaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbhLBOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:30:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3B2C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 06:26:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EF348CE2302
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 14:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979BFC00446;
        Thu,  2 Dec 2021 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638455201;
        bh=nk6ZXWrbT2R4Ish6mgFiyesDFmV61qN7jjgPeIARoDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQZ2X9yNBHmqWy9L7EhxmRrfPkQYtCsz8lKzg9sezm2AwcmRp6xxz96cFp6iRQxiG
         jhJnvU9AL0YADy5VmQ8XTAmEYzYMEDaWp0ada4r12D3SIACSfTn9lViHzZTb/pGCUp
         3Srul+n2NxxUgqdlBJbVs9oCb3abvKT1y7JxBgwc=
Date:   Thu, 2 Dec 2021 15:26:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <len.brown@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 0/3] topology/sysfs: only export used sysfs attributes
Message-ID: <YajXnjVGEWeUmEqA@kroah.com>
References: <20211129130309.3256168-1-hca@linux.ibm.com>
 <YaTdpsVCDQMlscON@hirez.programming.kicks-ass.net>
 <YajWjasdqnibSRJm@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YajWjasdqnibSRJm@osiris>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 03:22:05PM +0100, Heiko Carstens wrote:
> On Mon, Nov 29, 2021 at 03:03:18PM +0100, Peter Zijlstra wrote:
> > On Mon, Nov 29, 2021 at 02:03:06PM +0100, Heiko Carstens wrote:
> > > v2:
> > > As requested by Greg KH: avoid negative logic and use uppercase defines.
> > > 
> > > v1:
> > > Create die and cluster cpu topology sysfs attributes only if an
> > > architecture makes uses of it, instead of creating them always for all
> > > architectures with bogus default values.
> > > Also change the book and drawer cpu topology macros so they match all
> > > all other topology macros.
> > > 
> > > v1: https://lore.kernel.org/lkml/20211128212221.1069726-1-hca@linux.ibm.com/
> > > 
> > > Heiko Carstens (3):
> > >   topology/sysfs: export die attributes only if an architectures has support
> > >   topology/sysfs: export cluster attributes only if an architectures has support
> > >   topology/sysfs: rework book and drawer topology ifdefery
> > > 
> > >  Documentation/admin-guide/cputopology.rst | 33 +++++++++++------------
> > >  drivers/base/topology.c                   | 28 ++++++++++++++-----
> > >  include/linux/topology.h                  | 25 +++++++++++++++++
> > >  3 files changed, 62 insertions(+), 24 deletions(-)
> > 
> > Seems entirely reasonable to me,
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Since there seem to be no objections, who should pick this up?
> I'd assume the s390 tree would not be appropriate.
> 
> Andrew, Greg, Peter?

I will take it, thanks.

greg k-h
