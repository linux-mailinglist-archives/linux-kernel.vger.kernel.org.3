Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E4F4FE0B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353752AbiDLMmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355484AbiDLMjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:39:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0024C32D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:02:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FDA961017
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B70BC385A5;
        Tue, 12 Apr 2022 12:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649764941;
        bh=RL0TS6TyTsdDUGUm/EuXSEF8ETZ+oamHhp+RILM0/YA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3mHLMHoovRPWuJ8y8P/Vdf5aWsXfBlbwPd/Lv1CC2gAYrz46aDVuZy2dSkGLSWmE
         hpBubU2oQjoy5rFdmrvHhehRBFD4euGUaRkf+8y/ARPVcMFqqMajIZJKh10O45Oc9C
         VsxROyNh+ZUUyk13ISrKKT92HWZsCR8RKZeqBRIs=
Date:   Tue, 12 Apr 2022 14:02:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Liu Junqi <liujunqi@pku.edu.cn>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Remove D. Kershner from Unisys S-PAR
 maintainers
Message-ID: <YlVqStHr6acHnF5o@kroah.com>
References: <20220412103629.8029-1-fmdefrancesco@gmail.com>
 <YlVXV4J41KBzKHtm@kroah.com>
 <2976258.CbtlEUcBR6@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2976258.CbtlEUcBR6@leap>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 01:08:28PM +0200, Fabio M. De Francesco wrote:
> On marted? 12 aprile 2022 12:41:27 CEST Greg Kroah-Hartman wrote:
> > On Tue, Apr 12, 2022 at 12:36:29PM +0200, Fabio M. De Francesco wrote:
> > > The email address of David Kershner is no more reachable. Remove his
> > > entry from the MAINTAINERS file for UNISYS S-PAR DRIVERS and change
> > > the status to "Orphan".
> > > 
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > > 
> > > v1->v2: Change also the status of the entry to "Orphan" and rework the
> > > commit message. (Thanks to Greg Kroah-Hartman).
> > > 
> > >  MAINTAINERS | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 3ed62dcd144e..9283c63565b3 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -20184,9 +20184,8 @@ F:	include/linux/cdrom.h
> > >  F:	include/uapi/linux/cdrom.h
> > >  
> > >  UNISYS S-PAR DRIVERS
> > > -M:	David Kershner <david.kershner@unisys.com>
> > >  L:	sparmaintainer@unisys.com (Unisys internal)
> > 
> > Again, please drop this "list" as it obviously is not going to anyone.
> 
> OK, I'll also drop the "L:" line. I wasn't sure about it because I see 
> that there are other entries marked as "Orphan" and the list is still
> there. But you are right: although the "sparmaintainer" list address is
> not bouncing, it looks like nobody care to read messages there.
>   
> > And really, this whole code should be removed, no one seems to be using
> > it, and if they are, we can easily revert the removal and mark them as
> > the maintainer.
> 
> 1) If I remove the entire drivers/staging/unisys/ I suppose that, in 
> MAINTAINERS I should also remove the whole entry called "UNISYS S-PAR 
> DRIVERS", not only the "L:" line. 

Yes, _AND_ you need to also remove all files that are listed for that
entry.

> 2) Furthermore, I understand that I should also should change the relevant 
> Kbuild files, otherwise all builds of staging would fail. 

Yes.

thanks,

greg k-h
