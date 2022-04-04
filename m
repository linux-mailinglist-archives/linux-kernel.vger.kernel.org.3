Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317714F12DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356396AbiDDKRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244282AbiDDKQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:16:57 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D472B1A6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649067301; x=1680603301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k9Gtv0W+HeVk4XEfSmpLwR30gXASasolOPnIV5u/vYM=;
  b=OMWT0p2s1tzajfkz3ka66TG/Uya4WqHT4g+1tcuHjrF+OWs2yu8Pd0ct
   hkCsqrGS8Eo87pOEupZGZBj8legHLV4y/V3AetIxncGC2UYvf3YssFy3y
   qStMA1pj46CtRhK4ajlB7KD+86hGCwmtAO3weRxxEx1v1zm4I9ZXRHDCu
   29i40pw0OHv65YfbKax2ApfSSM3nwcgbLLEYzlX1TNDmh39qkX6GQRvKs
   sanfpeCbX89zVqH3nVlLAAH8D5H0ISFo0MSCncrhWCLE7koed/iq+Lk3J
   M/KqL1lgaZ7lDd/bUv/DUkNAUD6dGzGAIiZNOq82NhwsQaexCXomdPSOO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="321176853"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="321176853"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 03:15:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="522973803"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 03:14:59 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 04 Apr 2022 13:10:27 +0300
Date:   Mon, 4 Apr 2022 13:10:27 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YkrEE0uh9EVCchfl@lahna>
References: <YkQuk7E8AbSEiw59@lahna>
 <b35e4054-4f22-72a2-4313-77299697af7b@fnarfbargle.com>
 <YkRebADER3J9ooPM@lahna>
 <d40f02e5-7274-e834-6e13-82b3dbe11284@fnarfbargle.com>
 <YkRtf2HiXBOWGjna@lahna>
 <eacc22dc-e650-a208-9484-62edd98d5778@fnarfbargle.com>
 <YkXYdcUZ1E18ENle@lahna>
 <5dcee6f7-cc8c-e3ce-920c-4ad3f5d77e14@fnarfbargle.com>
 <YkcMofXKr/ZmOSwH@lahna>
 <7ea44c20-6c65-224f-af7b-aa1bd310d038@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ea44c20-6c65-224f-af7b-aa1bd310d038@fnarfbargle.com>
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

On Fri, Apr 01, 2022 at 11:05:27PM +0800, Brad Campbell wrote:
> On 1/4/22 22:30, Mika Westerberg wrote:
> > Hi,
> > 
> > On Fri, Apr 01, 2022 at 01:48:13PM +0800, Brad Campbell wrote:
> > > That I can do. I didn't crop or grep as I wasn't sure what might be additionally relevant.
> > > 2 machines, 2 ports, 4 cold boots. Each time just the Thnuderbolt displays chained.
> > 
> > Thanks for the logs! It looks like the Apple EFI CM always uses the lane
> > 1 adapter.
> 
> Thanks for sticking with me. This must be a minuscule corner case that
> is buried in a dark room behind a filing cabinet.

Well, it is just that nobody else reported the issue before ;-) I don't
have Light Ridge or Falcon Ridge based Apple hardware anymore so these
won't show up in my regular testing.

> > Can you try the below patch? Fingers crossed that it solves the
> > chaining issue for both ;-) I had to patch the test.c because otherwise
> > unit tests fail to compile when enabled.
> > 
> > This should now setup the second tunnel always through the lane 0
> > adapter and thus share the bandwidth equally between the two lanes.
> > 
> > @@ -1604,7 +1604,7 @@ static void tb_test_tunnel_3dp(struct kunit *test)
> >   	KUNIT_ASSERT_EQ(test, tunnel1->npaths, 3);
> >   	KUNIT_ASSERT_EQ(test, tunnel1->paths[0]->path_length, 3);
> > -	tunnel2 = tb_tunnel_alloc_dp(NULL, in2, out2, 0, 0);
> > +	tunnel2 = tb_tunnel_alloc_dp(NULL, in2, out2, 1, 0, 0);
> >   	KUNIT_ASSERT_TRUE(test, tunnel2 != NULL);
> >   	KUNIT_EXPECT_EQ(test, tunnel2->type, TB_TUNNEL_DP);
> >   	KUNIT_EXPECT_PTR_EQ(test, tunnel2->src_port, in2);
> > @@ -1612,7 +1612,7 @@ static void tb_test_tunnel_3dp(struct kunit *test)
> >   	KUNIT_ASSERT_EQ(test, tunnel2->npaths, 3);
> >   	KUNIT_ASSERT_EQ(test, tunnel2->paths[0]->path_length, 4);
> > -	tunnel3 = tb_tunnel_alloc_dp(NULL, in3, out3, 0, 0);
> > +	tunnel3 = tb_tunnel_alloc_dp(NULL, in3, out3, 1, 0, 0);
> >   	KUNIT_ASSERT_TRUE(test, tunnel3 != NULL);
> >   	KUNIT_EXPECT_EQ(test, tunnel3->type, TB_TUNNEL_DP);
> >   	KUNIT_EXPECT_PTR_EQ(test, tunnel3->src_port, in3);
> 
> These 2 chunks don't apply.
> I can't find a tb_test_tunnel_3dp in any of the trees I have (either
> head or stable). In any case I've updated to current head and applied
> without those chunks.

Indeed, I forgot to drop that hunk. It is based on my local branch that
has some additional code but good that you managed to work it around.

> This fixes *all* cases on the MacBookPro. Cold boot on either port, and hot plug likewise

That's great!

> On the iMac it cold boots on either port. If I boot with the displays plugged in, then unplug-replug we get :
> 
> Apr  1 22:49:41 bkmac kernel: [   24.480306] [drm:radeon_dp_link_train [radeon]] *ERROR* displayport link status failed
> Apr  1 22:49:41 bkmac kernel: [   24.481309] [drm:radeon_dp_link_train [radeon]] *ERROR* clock recovery failed
> 
> The last head on the chain comes up, the first doesn't.
> 
> If I plug the displays in *after* the chime and before the kernel starts up, then both heads come up and hotplug works fine excepting after the second unplug we get lots of this :
> 
> Apr  1 22:52:54 bkmac kernel: [   37.313493] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
> Apr  1 22:52:54 bkmac kernel: [   37.313513] thunderbolt 0000:07:00.0: 0:c: DP IN available
> Apr  1 22:52:54 bkmac kernel: [   37.763482] thunderbolt 0000:07:00.0: 0: timeout reading config space 1 from 0x39
> Apr  1 22:52:54 bkmac kernel: [   37.763489] thunderbolt 0000:07:00.0: 0:d: DP IN available
> Apr  1 22:52:54 bkmac kernel: [   37.763491] thunderbolt 0000:07:00.0: no suitable DP IN adapter available, not tunneling
> Apr  1 22:52:54 bkmac kernel: [   37.763495] thunderbolt 0000:07:00.0: 0:4: got unplug event for disconnected port, ignoring
> Apr  1 22:52:54 bkmac kernel: [   37.763496] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
> Apr  1 22:52:54 bkmac kernel: [   37.763498] thunderbolt 0000:07:00.0: 0:3: got unplug event for disconnected port, ignoring
> 
> And the thunderbolt ports then fail to respond to any plug event until rebooted.

This makes me suspect that there is something else still going on with
the Light Ridge controller that we are missing in the Linux driver.

> Feels like it's nailed excepting some DP routing on the Radeon, but
> I've not been able to put my finger on how that works.
> With your very first patch, hotplug works on the iMac.

Hm, you mean you don't see the timeout errors and stuff with the first
patch applied?

I think I will make this current one a proper patch and submit upstream
later this week (will CC you too). For the iMac issue we may need to
debug it further. Not sure if you answered this one already but on iMac
on macOS does it work always when you plug in the whole chain?
