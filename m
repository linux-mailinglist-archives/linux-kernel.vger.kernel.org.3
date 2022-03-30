Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCB14EC5DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346274AbiC3NqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240274AbiC3NqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:46:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853536A04F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648647857; x=1680183857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QXl8+YAIyOXHsNHqZZUA3VDYNTjmspExAM2i0woDO4M=;
  b=Lv7LoKRAVnNhelooukUsudrk5Ia8PT0gD3Vfq9F1qdXyw4eE8BsWTQ+s
   RUzYJZMSeSSDeUDu3066aTn2wCYpN23mqxKTq7pVp6874gqB1zWSUnsbc
   Hel83aBH7BarAyJGN+jDmkThJ+Ecj9tOBRoSocgzSVVLCfmgfEPaa9coz
   o/D2OAVgFu5sxWOE7Z1Eaj+332UydhWO15GDhp7IGVjwTtRL2g0BPe22D
   kcE3GZHRw2cMlMGJDJcnKhE4+FXLh1GXDeiszZZ/iYv+pOIDNI30PRhLE
   1WK8or8Ic7P1uhQVL5kj1nYmK8T01MxylO6s42lL1Swvv4uk04C5XYZEE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259518002"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="259518002"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 06:44:17 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="788011712"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 06:44:15 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 30 Mar 2022 16:43:08 +0300
Date:   Wed, 30 Mar 2022 16:43:08 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YkRebADER3J9ooPM@lahna>
References: <acbb3a86-ea15-47ec-90fa-72fbd94921b1@fnarfbargle.com>
 <YkLt+/kJ54fwCYgy@lahna>
 <0249a7da-9237-806b-b267-7911ad40f4a0@fnarfbargle.com>
 <YkMC4XnfIZix6kBn@lahna>
 <b8894440-41b1-edef-dd2d-5bafabc6fb62@fnarfbargle.com>
 <YkQuk7E8AbSEiw59@lahna>
 <b35e4054-4f22-72a2-4313-77299697af7b@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b35e4054-4f22-72a2-4313-77299697af7b@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 30, 2022 at 09:19:52PM +0800, Brad Campbell wrote:
> Hey Mika,
> 
> On 30/3/22 18:18, Mika Westerberg wrote:
> > Hi,
> > 
> > On Tue, Mar 29, 2022 at 10:06:35PM +0800, Brad Campbell wrote:
> >>> Indeed, I did not add this to the "discovery" path yet.
> >>>
> >>> I wonder what happens if you change this:
> >>>
> >>> +       tunnel = tb_tunnel_alloc_dp(tb, in, out, available_up, available_down,
> >>> +                                   first ? 0 : 1);
> >>>
> >>> to this in your tree:
> >>>
> >>> +       tunnel = tb_tunnel_alloc_dp(tb, in, out, available_up, available_down,
> >>> +                                   first ? 1 : 0);
> >>>
> >>
> >> Here's where it gets all "Apple..y". On the iMac this does the job no matter which
> >> port the chain is plugged into. Boots and displays correctly first time, every time.
> >>
> >> It turns out on the laptop, one port works and the other doesn't. Changing the order
> >> simply changes which port works. So I assume the EFI sets up the first display using
> >> the first lane if it's in the first port, and the second if it's in the second.
> >>
> >> That means had I managed to perform the first test in the "other port" consistently,
> >> it would have worked there also.
> > 
> > Can you try the below patch too? I hard-code the lane based on the
> > DP adapter number in TBT gen1.
> > 
> > Let's first figure out proper solution to this issue and then look at
> > the other one.
> > 
> > diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
> > index a473cc7d9a8d..97d36a7bb527 100644
> > --- a/drivers/thunderbolt/tunnel.c
> > +++ b/drivers/thunderbolt/tunnel.c
> > @@ -865,6 +865,7 @@ struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
> 
> This one works from cold boot on both machines regardless of the port the chain is plugged into.
> It fails on both machines on any hotplug with the symptoms of allocating them both the same link.
> I added an extra debug into tunnel.c and verified that.

Hm, okay. What if you change this:

  link_nr = in->port == 11 ? 1 : 0;

to this

  link_nr = in->port == 11 ? 0 : 1;

Please also keep the debugging you added too so we can see if it now
uses both lanes.
