Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C835008B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbiDNIs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiDNIsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:48:53 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46EA065D0B;
        Thu, 14 Apr 2022 01:46:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 39BB280A4;
        Thu, 14 Apr 2022 08:43:51 +0000 (UTC)
Date:   Thu, 14 Apr 2022 11:46:26 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the omap-fixes tree
Message-ID: <YlffYlfFuH6ur7GP@atomide.com>
References: <20220413070201.248a9b11@canb.auug.org.au>
 <773CBF24-F8B7-481F-BBCE-53C13198FBED@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <773CBF24-F8B7-481F-BBCE-53C13198FBED@goldelico.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [220413 06:19]:
> Hi Stephen,
> 
> > Am 12.04.2022 um 23:02 schrieb Stephen Rothwell <sfr@canb.auug.org.au>:
> > 
> > Hi all,
> > 
> > In commit
> > 
> >  9be24a73de12 ("ARM: dts: Fix mmc order for omap3-gta04")
> > 
> > Fixes tag
> > 
> >  Fixes: commit a1ebdb374199 ("ARM: dts: Fix swapped mmc order for omap3")
> > 
> > has these problem(s):
> > 
> >  - leading word 'commit' unexpected
> 
> Ah, I see.
> Diff of patch is good but the commit message needs editing.
> 
> What is the procedure to fix this case?

Thanks for catching this, no need to do anything. I've fixed it up
and pushed out an updated fixes branch.

Regards,

TOny
