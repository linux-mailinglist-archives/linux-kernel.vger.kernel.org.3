Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA594FFF57
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiDMTdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiDMTcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:32:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBED263A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649878198; x=1681414198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UBmMG/Y1pzjOMY+f80C2PIXPYSoEJlNzIOTHjCL4Elg=;
  b=SKMvbpUv0MQMIRP7B34dEp/nV0VCRpPqrQm+JAEq1+sxGdwMCR5e3rAS
   jy82FWm3FPjXeRb6H11nM+dohoH2QZiuJpw8Jb99hBFV4SqInd+eQR6lB
   toEY4VVf+eR3WiMRhHRpYEwUPxqsXb4TWMosjyrGU8ryjwZcbhJnn6898
   zgwj/Wn81+5V7KfBvkOC/HnZKqad4W4a9/huTeDaZVSe/yb2NnAhkylRd
   NP92NJb0Nt1K7l6H3GJ1Qjo6In1NGwGUpMbrJcpXHLPdZFgGWvRIfg+dJ
   4Fun4Ik8k7QbjMMY+mpMVOleAW19O1C6yP6vTgNDASchVKgCLwgPIKU6b
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="244641606"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="244641606"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 12:29:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="552337805"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 12:29:57 -0700
Date:   Wed, 13 Apr 2022 12:31:52 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>
Subject: Re: [PATCH] staging: Remove the drivers for the Unisys s-Par
Message-ID: <20220413193152.GA1242449@alison-desk>
References: <20220412215901.31046-1-fmdefrancesco@gmail.com>
 <3988824.6PsWsQAL7t@leap>
 <20220413153824.GA1241369@alison-desk>
 <7390243.EvYhyI6sBW@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7390243.EvYhyI6sBW@leap>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 11:57:20AM -0700, Fabio M. De Francesco wrote:
> On mercoled? 13 aprile 2022 17:38:24 CEST Alison Schofield wrote:
> > On Wed, Apr 13, 2022 at 09:35:53AM +0200, Fabio M. De Francesco wrote:
> > > On mercoled? 13 aprile 2022 08:52:47 CEST Greg Kroah-Hartman wrote:
> > > > On Tue, Apr 12, 2022 at 11:59:01PM +0200, Fabio M. De Francesco 
> wrote:
> > > > > The Unisys sub-tree contains three drivers for the "Unisys Secure 
> > > Partition"
> > > > > (s-Par(R)): visorhba, visorinput, visornic.
> > > > > 
> > > > > They have no maintainers, in fact the only one that is listed in 
> > > MAINTAINERS
> > > > > has an unreacheable email address. During 2021 and 2022 several 
> patches 
> > > have
> > > > > been submitted to these drivers but nobody at Unisys cared of 
> reviewing 
> > > the
> > > > > changes. Probably, also the "sparmaintainer" internal list of 
> > > unisys.com is
> > > > > not anymore read by interested Unisys' engineers.
> > > > > 
> > > > > Therefore, remove the ./unisys subdirectory of staging and delete 
> the 
> > > related
> > > > > entries in the MAINTAINERS, Kconfig, Makefile files.
> > > > > 
> > > > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > > ---
> > > > >  MAINTAINERS                                   |    8 -
> > > > 
> > > > You forgot to at least cc: the people/list on the MAINTAINERS entry 
> that
> > > > you are removing here, to give them a hint that this is happening in
> > > > case they want to speak up here (and to give us the ability to point 
> to
> > > > that years later when they complain they were never notified...)
> > > 
> > > Yes, this is a good idea. I'll submit a v2 and add two "Cc:" lines, one 
> to 
> > > David Kershner and the other to the "sparmaintainer" list at 
> unisys.com.
> > 
> > There is another contact in the TODO file (last updated 2015 though ;))
> > Ken Cox <jkc@redhat.com>
> 
> Hi Alison, Greg,
> 
> Thank you very much for noticing that other contact :) 
> 
> In the last 12 months I have sent several patches for Unisys s-Par drivers 
> but I never noticed that other contact simply because I only ever use 
> scripts / get_maintainer.pl to find out who and to which lists to send my 
> works.
> 
> @Greg: 
> 
> Do you think that we should care of a contact that is no more active since 
> 2015 and resubmit a v3 with one more "Cc:" line? I have no problems to 
> resubmit, I just want to be sure that this is the right thing to do.

I didn't see a v2, so confused about a v3. You could simply do a group
reply and add the contact, that'll put a trail in lore. Not my call.
Guessing Greg has a protocol for such removals. 

> 
> Thanks,
> 
> Fabio M. De Francesco
>  
> 
> 
