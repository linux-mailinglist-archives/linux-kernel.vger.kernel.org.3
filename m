Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEE758D7B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbiHIKzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236832AbiHIKzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:55:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA19326F4
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660042509; x=1691578509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nThm70cbh3yuihLopwrO/iHlRv4329SKFx3NKXGE0C4=;
  b=Iae9b6d9j35BDJ43JBJ/aUGD5UhSsIalPeGDxHO1TsoTRLv37CgiJy3V
   m9xu9zzu5hgd+PtXtEjfR3AWrBqkyTrR9V173EcTb5wbSsJhIcWz9GLym
   YfC18Mn4aLlWyFenumt0Wt9dJNk19oao/6qyLY2426cf7jSXEavPueTLE
   U5cYhwYzR60F3rAjvwevk0o3YVz86m4Ir1VeGjOgNhjaZebHWZPZxkqD1
   47cMiXyHg+PWRgZEeUof9yroLR1HzkluawAnidfCqB2vSxJ6QwcdGBbVk
   vgDWQtiqV2LcFo03W9XFKO9AtqLsvvqMZrphCLUZbnJj/jmUdsAi3KKUs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="316735507"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="316735507"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 03:55:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="850428746"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 03:55:07 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 09 Aug 2022 13:55:05 +0300
Date:   Tue, 9 Aug 2022 13:55:05 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YvI9Cbin4OKQwZ05@lahna>
References: <87c1a001-ef79-6390-dfe2-06d2850f6e84@fnarfbargle.com>
 <Yu4Gmkous7asng6h@lahna>
 <42e81a8e-e393-7a69-7339-a020ebb57935@fnarfbargle.com>
 <YvDcudE5BRtZAtfM@lahna>
 <a1db1454-63b6-7c39-bbf6-53e53bbd36e6@fnarfbargle.com>
 <5474e599-057a-ec0f-b469-560644155907@fnarfbargle.com>
 <YvEFtPF7SBIwNG/o@lahna>
 <d234ea9b-9303-6088-0a9b-4de887a77bf4@fnarfbargle.com>
 <YvI1lQh+C0SJiG73@lahna>
 <bcebdeb9-4f6a-e931-46f5-b9be899db9a4@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcebdeb9-4f6a-e931-46f5-b9be899db9a4@fnarfbargle.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 09, 2022 at 06:40:54PM +0800, Brad Campbell wrote:
> G'day Mika,
> 
> 
> On 9/8/22 18:23, Mika Westerberg wrote:
> > Hi,
> > 
> > On Mon, Aug 08, 2022 at 09:27:24PM +0800, Brad Campbell wrote:
> >> If I don't authorize the PCIe tunnels and just leave the DP enabled it
> >> works fine also.
> > 
> > But you say that it fails on boot when the driver discovers the tunnels,
> > right? So there is really nothing to authorize (they should be already
> > "authorized" by the boot firmware).
> > 
> > If I understand correctly this is how it reproduces (the simplest):
> > 
> >   1. Connect a single Apple TB1 display to the system
> >   2. Boot it up
> >   3. Wait a while and it hangs
> > 
> > If this is the case, then the driver certainly is not creating any
> > PCIe tunnels itself unless there is a bug somewhere.
> > 
> > An additional question, does it reproduce with either TB1 display
> > connected or just with specific TB1 display?
> > 
> 
> No, I've not been clear enough, I'm sorry. I've re-read what I've written below and
> I'm still not sure I'm clear enough.
> 
> The firmware never sets anything up. 
> 
> When I cold boot the machine (from power on), the thunderbolt displays and tunnels
> remain dark until linux initializes the thunderbolt driver the first time. 
>  
> If I compile the thunderbolt driver into the kernel, or let the initramfs load it
> the displays come up, all PCIe tunnels are established and everything works.
> 
> When I reboot the machine (reset button or warm boot), the firmware continues to
> do nothing and all the tunnels remain in place. The machine dies when the thunderbolt 
> driver is loaded for a second time.
> 
> That might be a reset/warm boot with it compiled in or loaded from iniramfs.
> It may also be me loading it from the command line after booting with it as a
> module and blacklisted.
> 
> The problem comes about when the thunderbolt module is loaded while the PCIe tunnels
> are already established.
> 
> To reproduce in the easiest manner I compile the thunderbolt driver as a module and
> blacklist it. This prevents it from auto-loading.
> 
> I cold boot the machine, let it boot completely then modprobe thunderbolt and authorize
> the tunnels. I then warm boot which lets the kernel detect and init the DP displays
> and detect/configure all the PCIe devices. The thunderbolt driver is not loaded.
> 
> The machine comes up, all tunnels are established and all devices work.
> 
> If I then modprobe the thunderbolt driver, things break.
> 
> This is the hack in my boot script :
> 
> # Spark up thunderbolt
> if [ -z "`grep notb /proc/cmdline`" -a -z "`lsusb | grep '05ac:9227'`" ] ; then
> 	modprobe thunderbolt
> 	sleep 1
> 	echo 1 > /sys/bus/thunderbolt/devices/0-3/authorized
> 	echo 1 > /sys/bus/thunderbolt/devices/0-303/authorized
> 	reboot
> fi

Thanks for the clarification! How about on macOS side, does it work (I
would expect yes)?
