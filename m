Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40AF50921C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382532AbiDTVeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiDTVeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:34:01 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DF73055D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:31:13 -0700 (PDT)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 5ECF6266D9;
        Wed, 20 Apr 2022 21:31:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id 4A1BD20028;
        Wed, 20 Apr 2022 21:31:06 +0000 (UTC)
Message-ID: <feff60ee8a6d10da7d10b421d18407a5d040680e.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Broadcom internal lists aren't maintainers
From:   Joe Perches <joe@perches.com>
To:     William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 20 Apr 2022 14:31:05 -0700
In-Reply-To: <dd97ffe3-3983-fc45-469b-703900077f2f@broadcom.com>
References: <04eb301f5b3adbefdd78e76657eff0acb3e3d87f.camel@perches.com>
         <db4b9db9-fa02-4b92-3b9a-bd866fa0e73e@gmail.com>
         <b95d9b1058eed13489adba0bccdeb600950eb153.camel@perches.com>
         <dd97ffe3-3983-fc45-469b-703900077f2f@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: 13rjmijud7m98fqu9mu6q9wntnnjekj3
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 4A1BD20028
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18V67XWtsRlfOqFbUCqis+akx6WflBEY9A=
X-HE-Tag: 1650490266-900935
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-20 at 11:50 -0700, William Zhang wrote:
> 
> On 4/19/22 16:11, Joe Perches wrote:
> > On Tue, 2022-04-19 at 12:00 -0700, Florian Fainelli wrote:
> > > On 4/12/2022 11:34 AM, Joe Perches wrote:
> > > > Convert the broadcom internal list M: and L: entries to R: as
> > > > exploder email addresses are neither maintainers nor mailing lists.
> > > > 
> > > > Reorder the entries as necessary.
> > []
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > []
> > > > @@ -3746,7 +3746,7 @@ F:	include/linux/platform_data/b53.h
> > > >    
> > > >    BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
> > > >    M:	Nicolas Saenz Julienne <nsaenz@kernel.org>
> > > > -L:	bcm-kernel-feedback-list@broadcom.com
> > > > +R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
> > 
> > > There is not a "Broadcom Kernel Team", the description of R: appears to
> > > require some kind of full name, hence the choice of L: instead of R:.
> > 
> > If you don't like "Broadcom Kernel Team", perhaps
> > "Broadcom Kernel Reviewers" might work for you.
> > 
> > I think it doesn't matter much.
> > 
> I can see that we shouldn't use M as maintainer for this Broadcom 
> mailing list email. But I honestly don't understand why we have to use 
> R. Just for the sake of full name?  Not everyone in this distribution 
> list is reviewer.  IMHO I would prefer to change all entries to L 
> without a full name.

I think "R:" is a better choice than "L:"

"L:" Mailing list entries have archives that are publicly searchable.

Are the broadcom bcm-kernel-feedback-list entries publicly archived?

If not, these are one-way entries, so someone sends and hopes only.
Replies that are sent from these entries are not visible to the public.


