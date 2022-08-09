Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201FC58DA76
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244000AbiHIOmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiHIOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:42:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B7D1209D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660056171; x=1691592171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fPcqi12kBbjdY5iJ5EAh3ew1C4SELFqMnMzMrsqC+mI=;
  b=jSDV8fnhq4TRsMY+DEzTrnlRJDA1Kp52D4qGUPx+54EfuRL3V8Ml2XYy
   EGRNYHf43ZNMw7/A5DzUopitucjs91Asqv84AWf3dXEXlqeah7EMDuhu9
   C9ioC5AgT75sh1hrZDYqWKBDPmmuI9Z1MLy7taLv5fjXn1GfM84hivEwI
   te1o5C4TMSif4jTCdwiCHp3sAJp2jZn9S0ZdhzhaKx162TRowCq5l/WZS
   XCIN0jv7DqYw4ogLq1CG2S0ZNH5cigmJnrZFwdbErG7sDer+4STtJU/1B
   64JTfcPS8ZGU7CJScFIaAH/orMe2Id9cqDbHXL3RPqw8xYpjoYpYwB84J
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="290851549"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="290851549"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 07:42:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="747060442"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 07:42:49 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 09 Aug 2022 17:42:47 +0300
Date:   Tue, 9 Aug 2022 17:42:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YvJyZ51H+YkceKJP@lahna>
References: <42e81a8e-e393-7a69-7339-a020ebb57935@fnarfbargle.com>
 <YvDcudE5BRtZAtfM@lahna>
 <a1db1454-63b6-7c39-bbf6-53e53bbd36e6@fnarfbargle.com>
 <5474e599-057a-ec0f-b469-560644155907@fnarfbargle.com>
 <YvEFtPF7SBIwNG/o@lahna>
 <d234ea9b-9303-6088-0a9b-4de887a77bf4@fnarfbargle.com>
 <YvI1lQh+C0SJiG73@lahna>
 <bcebdeb9-4f6a-e931-46f5-b9be899db9a4@fnarfbargle.com>
 <YvI9Cbin4OKQwZ05@lahna>
 <86bec398-7a5b-6d4e-bc02-5941fe6c2e73@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bec398-7a5b-6d4e-bc02-5941fe6c2e73@fnarfbargle.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 09, 2022 at 07:08:42PM +0800, Brad Campbell wrote:
> 
> 
> On 9/8/22 18:55, Mika Westerberg wrote:
> > Hi,
> > 
> > On Tue, Aug 09, 2022 at 06:40:54PM +0800, Brad Campbell wrote:
> >> G'day Mika,
> >>
> >>
> >> On 9/8/22 18:23, Mika Westerberg wrote:
> >>> Hi,
> >>>
> >>> On Mon, Aug 08, 2022 at 09:27:24PM +0800, Brad Campbell wrote:
> >>>> If I don't authorize the PCIe tunnels and just leave the DP enabled it
> >>>> works fine also.
> >>>
> >>> But you say that it fails on boot when the driver discovers the tunnels,
> >>> right? So there is really nothing to authorize (they should be already
> >>> "authorized" by the boot firmware).
> >>>
> >>> If I understand correctly this is how it reproduces (the simplest):
> >>>
> >>>   1. Connect a single Apple TB1 display to the system
> >>>   2. Boot it up
> >>>   3. Wait a while and it hangs
> >>>
> >>> If this is the case, then the driver certainly is not creating any
> >>> PCIe tunnels itself unless there is a bug somewhere.
> >>>
> >>> An additional question, does it reproduce with either TB1 display
> >>> connected or just with specific TB1 display?
> >>>
> >>
> >> No, I've not been clear enough, I'm sorry. I've re-read what I've written below and
> >> I'm still not sure I'm clear enough.
> >>
> >> The firmware never sets anything up. 
> >>
> >> When I cold boot the machine (from power on), the thunderbolt displays and tunnels
> >> remain dark until linux initializes the thunderbolt driver the first time. 
> >>  
> >> If I compile the thunderbolt driver into the kernel, or let the initramfs load it
> >> the displays come up, all PCIe tunnels are established and everything works.
> >>
> >> When I reboot the machine (reset button or warm boot), the firmware continues to
> >> do nothing and all the tunnels remain in place. The machine dies when the thunderbolt 
> >> driver is loaded for a second time.
> >>
> >> That might be a reset/warm boot with it compiled in or loaded from iniramfs.
> >> It may also be me loading it from the command line after booting with it as a
> >> module and blacklisted.
> >>
> >> The problem comes about when the thunderbolt module is loaded while the PCIe tunnels
> >> are already established.
> >>
> >> To reproduce in the easiest manner I compile the thunderbolt driver as a module and
> >> blacklist it. This prevents it from auto-loading.
> >>
> >> I cold boot the machine, let it boot completely then modprobe thunderbolt and authorize
> >> the tunnels. I then warm boot which lets the kernel detect and init the DP displays
> >> and detect/configure all the PCIe devices. The thunderbolt driver is not loaded.
> >>
> >> The machine comes up, all tunnels are established and all devices work.
> >>
> >> If I then modprobe the thunderbolt driver, things break.
> >>
> >> This is the hack in my boot script :
> >>
> >> # Spark up thunderbolt
> >> if [ -z "`grep notb /proc/cmdline`" -a -z "`lsusb | grep '05ac:9227'`" ] ; then
> >> 	modprobe thunderbolt
> >> 	sleep 1
> >> 	echo 1 > /sys/bus/thunderbolt/devices/0-3/authorized
> >> 	echo 1 > /sys/bus/thunderbolt/devices/0-303/authorized
> >> 	reboot
> >> fi
> > 
> > Thanks for the clarification! How about on macOS side, does it work (I
> > would expect yes)?
> > 
> 
> Ahh, forgot about the laptop I'm typing this on. Yes, works fine in MacOS.

Right. Okay does it reproduce with these steps?

1. Boot the system up, nothing connected
2. Plug in a TB1 display (just one)
3. Authorize the PCIe tunnel

  # echo 1 > /sys/bus/thunderbolt/...

4. Unload the TBT driver

  # rmmod thunderbolt

5. Load it back

  # modprobe thunderbolt dyndbg

This should be pretty much the same as with the reboot case.
