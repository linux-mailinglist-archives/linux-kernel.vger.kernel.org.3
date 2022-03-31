Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E1D4EDEE9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240054AbiCaQjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240022AbiCaQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:39:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F07209A45
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648744637; x=1680280637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bNKQn6+d0YFX2qgrZUNGTj09GWw5yyjuKRwIJ6pMmik=;
  b=Vc8/7MLHRwIzJSnQS54PUwOmrOEdfY3VFGkPni/iKUhGEMIK7QJY6Kbv
   IkBB8MiVu+I2+DozDBqea0LmtIEoYCoQmMFPA53yYiZy91dYIFUJxdxxj
   dg1j+XEWtLdJIznTvCbJXxkSZdtD3+vVsCBOQglaJJWDc0pzsnfi+UMj1
   eRFLnnhlD0oRoZaRQpUilcOKGBPpc69/DK7zh7bwju2WCAeVkggRfa45T
   qrOfVIxE9E89D5bPnm3UHSl0RWerbRp6Xpg3GdPSs8grF9aaNhxATX0mK
   kGdiI/1mGi9nzVSXE6OWQA5viXBrSv9qWLhUbFyy44fwFvD9BZbKq6afU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="257470623"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="257470623"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 09:37:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="606184372"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 09:37:15 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 31 Mar 2022 19:36:05 +0300
Date:   Thu, 31 Mar 2022 19:36:05 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YkXYdcUZ1E18ENle@lahna>
References: <YkLt+/kJ54fwCYgy@lahna>
 <0249a7da-9237-806b-b267-7911ad40f4a0@fnarfbargle.com>
 <YkMC4XnfIZix6kBn@lahna>
 <b8894440-41b1-edef-dd2d-5bafabc6fb62@fnarfbargle.com>
 <YkQuk7E8AbSEiw59@lahna>
 <b35e4054-4f22-72a2-4313-77299697af7b@fnarfbargle.com>
 <YkRebADER3J9ooPM@lahna>
 <d40f02e5-7274-e834-6e13-82b3dbe11284@fnarfbargle.com>
 <YkRtf2HiXBOWGjna@lahna>
 <eacc22dc-e650-a208-9484-62edd98d5778@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eacc22dc-e650-a208-9484-62edd98d5778@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 31, 2022 at 05:02:58PM +0800, Brad Campbell wrote:
> On 30/3/22 22:47, Mika Westerberg wrote:
> > Hi,
> > 
> > On Wed, Mar 30, 2022 at 10:24:35PM +0800, Brad Campbell wrote:
> >> Nope, that did the same thing. I wonder though. I'm testing it on the laptop and that reports :
> >> [    0.442832] thunderbolt 0000:07:00.0:  Thunderbolt 2 Switch: 8086:156d (Revision: 0, TB Version: 2)
> >>
> >> Changing "if (in->sw->generation == 1)" to "if (in->sw->generation == 2)" on the laptop solves that.
> > 
> > Heh, indeed I forgot that this is Falcon Ridge.
> > 
> >> I can't test hotplug properly on the iMac due to the radeon training issue.
> >>
> >> The laptop still has the issue of a cold boot working in one socket
> >> and not the other, but hot plug is working correctly.
> > 
> > Let's try this one next:
> > 
> > diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
> > index a473cc7d9a8d..7150b5bc5403 100644
> > --- a/drivers/thunderbolt/tunnel.c
> > +++ b/drivers/thunderbolt/tunnel.c
> > @@ -865,6 +865,8 @@ struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
> >   	struct tb_tunnel *tunnel;
> >   	struct tb_path **paths;
> >   	struct tb_path *path;
> > +	struct tb_port *port;
> > +	int link_nr;
> >   
> 
> On the iMac, it cold boots on either port.
> 
> On the Laptop it is the same as the previous in that it cold boots on
> one port and not the other. Hotplug works in all cases I did try
> (in->sw->generation < 3) just in case, but it didn't change anything
> on the Laptop.
> 
> Testing from here down is on the iMac.
> 
> I've re-tested the original patch and aside from the thunderbolt
> controller locking up, the radeon doesn't fail clock recovery.
> 
> Further investigation on the iMac shows we don't see port 11. I added
> a debug for discovered port.
> 
> So my next thing is to try and figure out if there is a correlation between which link is paired with which DP source.
> 
> I've changed link_nr = in->port == 11 ? 1 : 0; to 12 ? 1 : 0; and that boots, but hotplug still fails if the EFI sets up a display first. I've also tried reversing the 1 : 0, but that fails out of the gate.
> 
> I've just done a test now by booting with the chain disconnected, then
> plugging it in just before the bootloader loads which prevents the EFI
> from getting involved. 
> 
> This works (wait until just before bootloader to plug the chain): 
> 
> brad@bkmac:~$ dmesg | egrep '(Tunnel|in->|in use|DP .* available)'
> [    1.618277] thunderbolt 0000:07:00.0: 0:c: DP IN resource available
> [    1.618280] thunderbolt 0000:07:00.0: 0:d: DP IN resource available
> [    1.618403] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
> [    1.618529] thunderbolt 0000:07:00.0: 0:c: DP IN available
> [    1.618656] thunderbolt 0000:07:00.0: 303:b: DP OUT available
> [    1.618916] thunderbolt 0000:07:00.0: in->port 12
> [    1.618920] thunderbolt 0000:07:00.0: Tunnel 1
> [    1.622751] thunderbolt 0000:07:00.0: 3:b: DP OUT resource available
> [    1.622880] thunderbolt 0000:07:00.0: 0:c: in use
> [    1.623007] thunderbolt 0000:07:00.0: 0:d: DP IN available
> [    1.623135] thunderbolt 0000:07:00.0: 303:b: in use
> [    1.623263] thunderbolt 0000:07:00.0: 3:b: DP OUT available
> [    1.623399] thunderbolt 0000:07:00.0: in->port 13
> [    1.623402] thunderbolt 0000:07:00.0: Tunnel 0
> 
> Both displays are working at this point.
> Unplug -> Replug
> [   45.799923] thunderbolt 0000:07:00.0: 0:c: DP IN available
> [   45.800051] thunderbolt 0000:07:00.0: 0:d: DP IN available
> [   45.800053] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
> [   54.606243] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
> [   54.606371] thunderbolt 0000:07:00.0: 0:c: DP IN available
> [   54.606497] thunderbolt 0000:07:00.0: 303:b: DP OUT available
> [   54.606763] thunderbolt 0000:07:00.0: in->port 12
> [   54.606768] thunderbolt 0000:07:00.0: Tunnel 1
> [   54.615067] thunderbolt 0000:07:00.0: 3:b: DP OUT resource available
> [   54.615176] thunderbolt 0000:07:00.0: 0:c: in use
> [   54.615309] thunderbolt 0000:07:00.0: 0:d: DP IN available
> [   54.615434] thunderbolt 0000:07:00.0: 303:b: in use
> [   54.615561] thunderbolt 0000:07:00.0: 3:b: DP OUT available
> [   54.615692] thunderbolt 0000:07:00.0: in->port 13
> [   54.615694] thunderbolt 0000:07:00.0: Tunnel 0
> 
> Both displays are working
> 
> This doesn't (standard cold boot):
> 
> brad@bkmac:~$ dmesg | egrep '(Tunnel|in->|in use|DP .* available)'
> [    1.611396] thunderbolt 0000:07:00.0: 0:c: DP IN resource available
> [    1.611399] thunderbolt 0000:07:00.0: 0:d: DP IN resource available
> [    1.611521] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
> [    1.611648] thunderbolt 0000:07:00.0: 0:c: in use
> [    1.611777] thunderbolt 0000:07:00.0: 0:d: DP IN available
> [    1.611904] thunderbolt 0000:07:00.0: 303:b: DP OUT available
> [    1.612162] thunderbolt 0000:07:00.0: in->port 13
> [    1.612166] thunderbolt 0000:07:00.0: Tunnel 0
> 
> Both displays are working at this point.
> Unplug -> Replug
> [   72.181366] thunderbolt 0000:07:00.0: 0:c: DP IN available
> [   72.181487] thunderbolt 0000:07:00.0: 0:d: DP IN available
> [   72.181489] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
> [   81.369074] thunderbolt 0000:07:00.0: 3:b: DP OUT resource available
> [   81.369207] thunderbolt 0000:07:00.0: 0:c: DP IN available
> [   81.369335] thunderbolt 0000:07:00.0: 3:b: DP OUT available
> [   81.369468] thunderbolt 0000:07:00.0: in->port 12
> [   81.369471] thunderbolt 0000:07:00.0: Tunnel 1
> [   81.376542] thunderbolt 0000:07:00.0: 303:b: DP OUT resource available
> [   81.376669] thunderbolt 0000:07:00.0: 0:c: in use
> [   81.376797] thunderbolt 0000:07:00.0: 0:d: DP IN available
> [   81.376925] thunderbolt 0000:07:00.0: 3:b: in use
> [   81.377058] thunderbolt 0000:07:00.0: 303:b: DP OUT available
> [   81.377320] thunderbolt 0000:07:00.0: in->port 13
> [   81.377328] thunderbolt 0000:07:00.0: Tunnel 0
> 
> First display in the chain fails clock recovery.

Okay, thanks for testing. I think at this point we need to look a what
the Apple boot firmware actually configures for these paths. Can you
drop my previous patch and apply the below? Then on both problematic
systems boot up with the monitors connected and then send me dmesg.

If possible do this so that you have the chain connected to each port on
the system. I'm hoping we find some pattern here ;-)

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index 299712accfe9..ee03fd75a472 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -166,6 +166,9 @@ struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
 		return NULL;
 	}
 
+	tb_dbg(path->tb, "discovering %s path starting from %llx:%u\n",
+	       path->name, tb_route(src->sw), src->port);
+
 	p = src;
 	h = src_hopid;
 
@@ -198,10 +201,13 @@ struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
 		path->hops[i].out_port = out_port;
 		path->hops[i].next_hop_index = next_hop;
 
+		tb_dump_hop(&path->hops[i], &hop);
+
 		h = next_hop;
 		p = out_port->remote;
 	}
 
+	tb_dbg(path->tb, "path discovery complete\n");
 	return path;
 
 err:
