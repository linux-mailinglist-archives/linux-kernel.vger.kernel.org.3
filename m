Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512A74FFA5C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiDMPiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiDMPiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:38:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B2964713
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649864189; x=1681400189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iq4ltTTN69V9QzH/TlL8lL1lwJpSTAOC+133meFHn4o=;
  b=Q7xtkVCk0onK6/n8+cL4NIOvuzowSgD9wNSEpLxnq1wECfRfA19TaoML
   yE6Vp2mLAHeppJYPj+UoFsR0bAdzvUaMJ5ZJb39t2JDhgFVCsVw1JQCh9
   yFtRRnAVGSELHtFqmSmT2S4wACqzht/x8urUD/+Wy0Mgq1CEu8KCbdM8v
   sh5k3l8nB72lvKSAW+VGRtllwOE/adl583+t8V2eikSI+QTM9JwVnAPLo
   J8DrRlNGRbwcruvFsD9T8FomeHAvfq1INSkkGz0GpVnkMfW5WrhZov3Zf
   +9vYmnRH5CSewzlwKwUxp614CDKEnNBCZYW04RG9VSz3p+tUVWM14c5wB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="249988009"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="249988009"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 08:36:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="526518653"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 08:36:28 -0700
Date:   Wed, 13 Apr 2022 08:38:24 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: Remove the drivers for the Unisys s-Par
Message-ID: <20220413153824.GA1241369@alison-desk>
References: <20220412215901.31046-1-fmdefrancesco@gmail.com>
 <YlZzP5ghZeR1AtIg@kroah.com>
 <3988824.6PsWsQAL7t@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3988824.6PsWsQAL7t@leap>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:35:53AM +0200, Fabio M. De Francesco wrote:
> On mercoled? 13 aprile 2022 08:52:47 CEST Greg Kroah-Hartman wrote:
> > On Tue, Apr 12, 2022 at 11:59:01PM +0200, Fabio M. De Francesco wrote:
> > > The Unisys sub-tree contains three drivers for the "Unisys Secure 
> Partition"
> > > (s-Par(R)): visorhba, visorinput, visornic.
> > > 
> > > They have no maintainers, in fact the only one that is listed in 
> MAINTAINERS
> > > has an unreacheable email address. During 2021 and 2022 several patches 
> have
> > > been submitted to these drivers but nobody at Unisys cared of reviewing 
> the
> > > changes. Probably, also the "sparmaintainer" internal list of 
> unisys.com is
> > > not anymore read by interested Unisys' engineers.
> > > 
> > > Therefore, remove the ./unisys subdirectory of staging and delete the 
> related
> > > entries in the MAINTAINERS, Kconfig, Makefile files.
> > > 
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >  MAINTAINERS                                   |    8 -
> > 
> > You forgot to at least cc: the people/list on the MAINTAINERS entry that
> > you are removing here, to give them a hint that this is happening in
> > case they want to speak up here (and to give us the ability to point to
> > that years later when they complain they were never notified...)
> 
> Yes, this is a good idea. I'll submit a v2 and add two "Cc:" lines, one to 
> David Kershner and the other to the "sparmaintainer" list at unisys.com.

There is another contact in the TODO file (last updated 2015 though ;))
Ken Cox <jkc@redhat.com>

> 
> > Also, if you are in the "delete code" mood, I think drivers/staging/vme/
> > and drivers/vme/ can probably also be deleted given that the maintainer
> > for that has moved on to other jobs.  Ask them and see!
> 
> I can and will do exactly as you just suggested, but only after April 22nd 
> (unless others want to do these tasks sooner, and in that case they are 
> welcome :)).
> 
> Thanks,
> 
> Fabio M. De Francesco
> 
> 
> 
