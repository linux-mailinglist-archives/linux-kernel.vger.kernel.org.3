Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E548151211C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242947AbiD0Q2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242991AbiD0Q2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:28:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D8336B4C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651076552; x=1682612552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xbVkhqUprSffI6k9578RyOtKLKT5PDGpfnHI0RkdbJg=;
  b=JVUdczBuYwTQhyiAmWr9YqIp/5bBFtV7HkGSuMKGPJxvtaM1l//LSmLJ
   QOSeQxxrwyKUqF14p6nXU++SdkoJPFWgcPZB6+ab+sVyqbxls3xwtu88F
   9EVX43CHW1HQVd3LQxecgZui6v+ybP42d2GqwojrzuDA30P2t6vOVtXzt
   D6Bn+eRXJq84S7yvi+egR64dpsukeX4YvQ7Hl+IRqrc8ZaKHbeoOQBmyO
   +57MdplUdF9FI8hvCw6Qr0/kwZbdV3c9rzWHiiLjN+vQZR7r+745NsHzl
   MB1Wgkrw2if/dess860uBBjCWWzQE2gK9i2BTwmc7awLe/17Hsq2yTF54
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="247919498"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="247919498"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 09:15:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="533293590"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 09:15:06 -0700
Date:   Wed, 27 Apr 2022 09:16:33 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bruno Moreira-Guedes <codeagain@codeagain.dev>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v3 0/3] staging: vme: Cleanup driver tree old structures
Message-ID: <20220427161633.GA1314857@alison-desk>
References: <cover.1650321310.git.codeagain@codeagain.dev>
 <YmA4QIRfx2QPhEJi@kroah.com>
 <3e91b72a86294b542acf460657d0fd94adeb252e.camel@welchs.me.uk>
 <YmJNqMjXEc4KGrJ8@kroah.com>
 <20220427121851.4e2rjbbabw5sh3lk@AN5Bruno>
 <Ymk3qimGl1tTjpSL@kroah.com>
 <20220427124114.woiiuxr6pnxvadwg@AN5Bruno>
 <YmlA1w124Ws2z/RV@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmlA1w124Ws2z/RV@kroah.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 03:10:47PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 27, 2022 at 09:41:14AM -0300, Bruno Moreira-Guedes wrote:
> > On Wed, Apr 27, 2022 at 02:31:38PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Apr 27, 2022 at 09:18:51AM -0300, Bruno Moreira-Guedes wrote:
> > > > Hello,
> > > > 
> > > > On Fri, Apr 22, 2022 at 08:39:36AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Thu, Apr 21, 2022 at 08:16:05PM +0100, Martyn Welch wrote:
> > > > > > On Wed, 2022-04-20 at 18:43 +0200, Greg Kroah-Hartman wrote:
> > > > > > > On Mon, Apr 18, 2022 at 08:29:49PM -0300, Bruno Moreira-Guedes wrote:
> > > > > > > > This patch series modify the vme_user driver's place in
> > > > > > > > menuconfig (1/3), fixes a missing `depends on` line in a Kconfig
> > > > > > > > file
> > > > > > > > (2/3), and rearrages the directory tree for the driver allowing a
> > > > > > > > more
> > > > > > > > straightforward comprehension of its contents (3/3).
> > > > > > > > 
> > > > > > > > The 'vme_user/' driver is the only remaining vme-family driver in
> > > > > > > > the
> > > > > > > > 'staging/' tree, but its structure, entry in menuconfig and
> > > > > > > > building
> > > > > > > > routines are still attached to the 'vme/' subtree now outside
> > > > > > > > 'staging/'. The present patchset fixes it.
> > > > > > > > 
> > > > > > > > Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
> > > > > > > 
> > > > > > > What about deleting the vme drivers entirely?
> > > > > > 
> > > > > > I assume you're suggesting deleting the "vme_user" driver from the
> > > > > > staging directory?
> > > > > 
> > > > > Yes, at the very least given that no one has tried to fix it up and get
> > > > > it out of staging in many years.
> > > > 
> > > > While I cannot comment anything on that regard, I imagine the v4 I sent
> > > > a couple of days ago will wait for that decision, right?
> > > 
> > > I do not know what you are referring to, sorry.  My staging patch queue
> > > is empty right now.
> > Ohhh, okay, no problem, I have sent a v4 around 6 days ago and thought
> > you were waiting on this definition.

Bruno - I see your patches was applied to staging-testing
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/log/?h=staging-testing


> 
> If I did not take it, please resend.
> 
> thanks,
> 
> greg k-h
> 
