Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C6F576BF9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 07:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiGPFVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 01:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGPFVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 01:21:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E93326CD;
        Fri, 15 Jul 2022 22:21:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8ADAB82E5D;
        Sat, 16 Jul 2022 05:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4FCC34114;
        Sat, 16 Jul 2022 05:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657948902;
        bh=Ttih8DVfpdTpvRAEBEvLEtO7g+HeGup/4e3A4hiDRRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RgnUSebY2bHUVHKtVhVWyK0GK7H1SlP2e24Jv8PdQhYF2RJjQOeemiNgMESM3bltq
         QtnfH58gcMqFPrjO9+a+f5NyfEcUmqdJ/Ow2Nev2MoKfEIp6gQFeBmxVwHC7Kzc/Li
         BeVWB9If4gSxKGutwLgn/sIkl5t5fE95CrKZB3sI=
Date:   Sat, 16 Jul 2022 07:21:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 5.20
Message-ID: <YtJK4UYMrvlAs3il@kroah.com>
References: <20220715101021.30109-1-djakov@kernel.org>
 <YtFjOW77wGnToYt8@kroah.com>
 <YtFjbhn3pveplLQb@kroah.com>
 <2a2bb00a-28ae-ecd8-760a-a83cc14c02fa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a2bb00a-28ae-ecd8-760a-a83cc14c02fa@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 06:30:36PM +0300, Georgi Djakov wrote:
> 
> On 15.07.22 15:54, Greg KH wrote:
> > On Fri, Jul 15, 2022 at 02:53:13PM +0200, Greg KH wrote:
> > > On Fri, Jul 15, 2022 at 01:10:21PM +0300, Georgi Djakov wrote:
> > > > Hello Greg,
> > > > 
> > > > This is the pull request with interconnect changes for the 5.20-rc1 merge
> > > > window. It contains driver updates. The details are in the signed tag.
> > > > 
> > > > All patches have been in linux-next during the last few days. No issues have
> > > > been reported so far. Please pull into char-misc-next.
> > > > 
> > > > Thanks,
> > > > Georgi
> > > > 
> > > > The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:
> > > > 
> > > >    Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >    git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.20-rc1
> > > 
> > > Pulled and pushed out, thanks.
> > 
> > Oops, nope, I got the following error:
> > 
> > Fixes tag: Fixes: f0d8048525d7d("interconnect: Add imx core driver")
> > 	Has these problem(s):
> > 		- missing space between the SHA1 and the subject
> > 
> 
> Apologies for missing this. This was in linux-next for more than a week, but nobody
> reported it. I'll create a script to check for this problem to my workflow.
> Now sending you v2 pull request.

That's odd, as my scripts come from Stephen's linux-next scripts, I
would have thought he would have caught it before me.

thanks,

greg k-h
