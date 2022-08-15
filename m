Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4175592AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiHOHoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbiHOHoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:44:03 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33041D0C2;
        Mon, 15 Aug 2022 00:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1660549441; x=1692085441;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SIE66MGxDpRWZ2cps44EOenrs9VP7SJORPjECIaM/J8=;
  b=aY0gkhy6FItAB7lqXiE4xb9u1vFeyoOspms8tB/31nCXS6SMbt+j/aaV
   YL7N8xABz2WuYmM1JmmizN+EhstjBtBWb+Ep0O3VLbmRCrbqb87JSuQWc
   Uo/Te1BE/awb1sX47qjmH0Cmrz8m3LXXjXAxHELitoMWFpuBC7FUCkJVO
   1nzdtcoGZC86CaafH0JBhWN5upGxhSPF+/XDJd+mdAdcMG/UluiJwkY4M
   mNjJNDP4p7ckXvR0xZqw7lLUYhLNnzwyb+YGYICFxBKqVhYI1miyPsoFE
   8HRG5c4E+hU0n2Sy8jp4qMqrOCstBHTUoa7J1ODANCkStzIqFYc+UJ2JH
   A==;
X-IronPort-AV: E=Sophos;i="5.93,237,1654552800"; 
   d="scan'208";a="25601393"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 15 Aug 2022 09:43:57 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 15 Aug 2022 09:43:58 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 15 Aug 2022 09:43:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1660549438; x=1692085438;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SIE66MGxDpRWZ2cps44EOenrs9VP7SJORPjECIaM/J8=;
  b=OPTI+PZvpxikOTum61xgzpOJTqIyb8naeDbElgSclZVGyI9eVyMbyxL+
   Cnu8EMhptZqZ+H3Q2W5xK1Dt3dgwlfAYtCD3mLwAwD3aItQFVjekVEoqQ
   LM8/wyhRvu68wFW6raE3sCVzOXK0tuXrZUtxE2wfd5exJyjNWfTDpNcEC
   cJxPjZB+ahu4wiFM8BH9sWdVH8VLaeZYmC1Qn6KKbky/GC57fm7Xv4Dkr
   odUhmrKnvU+kyR9NBQGAM9acabrFXE+YOtMSXJRTD3Mr0rsjuTqh+4MIP
   FhqrhyRlkj5cHMzrcO/LjySM7gnnpGbS1YzjdzVPQd+lA+CbqYDB7XXwo
   g==;
X-IronPort-AV: E=Sophos;i="5.93,237,1654552800"; 
   d="scan'208";a="25601392"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Aug 2022 09:43:57 +0200
Received: from schifferm-ubuntu (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id ABA9F280056;
        Mon, 15 Aug 2022 09:43:57 +0200 (CEST)
Message-ID: <c434ba87606d3d7696ae076684ceea67bfe662e3.camel@ew.tq-group.com>
Subject: Re: [PATCH 0/9] Input: synaptics-rmi4 - Bootloader v7/v8 firmware
 update improvements
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 Aug 2022 09:43:52 +0200
In-Reply-To: <26790cfecb827245187233bc81f9fb89553bb4a7.camel@ew.tq-group.com>
References: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
         <26790cfecb827245187233bc81f9fb89553bb4a7.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-27 at 10:31 +0200, Matthias Schiffer wrote:
> On Wed, 2022-06-08 at 14:47 +0200, Matthias Schiffer wrote:
> > This fixes the firmware update function with bootloader v8, allows to
> > recover from interrupted updates with v7/v8, and does some code cleanup.
> > 
> > I believe that the code that allows to recover from a broken partition
> > table is also necessary to make flashing a different partition table
> > work at all, but I wasn't able to verify that, as I don't have any firmware
> > images with different partition tables to test with. In any case, I'm
> > pretty sure that it is working correctly now, as recovery from a mostly
> > empty flash without partition table has been tested successfully.
> > 
> > I have only tested the new code with bootloader v8, and I don't have the
> > documentation / interfacing guide for v7, so it would be great if anyone
> > could check that I didn't break updates for v7.
> 
> Hi everyone,
> 
> any news regarding this patch series?
> 
> 
> Kind regards,
> Matthias

Ping - can we get this applied, or at least any kind of feedback?


Kind regards,
Matthias



> 
> 
> 
> > 
> > Matthias Schiffer (9):
> >   Input: synaptics-rmi4 - fix firmware update operations with bootloader
> >     v8
> >   Input: synaptics-rmi4 - introduce rmi_f34v7_check_command_status()
> >     helper
> >   Input: synaptics-rmi4 - fix command completion check for bootloader
> >     v7/v8
> >   Input: synaptics-rmi4 - rewrite partition table unconditionally
> >   Input: synaptics-rmi4 - reset after writing partition table
> >   Input: synaptics-rmi4 - make rmi_f34v7_erase_all() use the "erase all"
> >     command
> >   Input: synaptics-rmi4 - remove unneeded struct register_offset
> >   Input: synaptics-rmi4 - simplify rmi_f34v7_start_reflash()
> >   Input: synaptics-rmi4 - drop useless gotos in rmi_f34v7_do_reflash()
> > 
> >  drivers/input/rmi4/rmi_f34.c   |  16 +-
> >  drivers/input/rmi4/rmi_f34.h   |  17 --
> >  drivers/input/rmi4/rmi_f34v7.c | 349 +++++++--------------------------
> >  3 files changed, 81 insertions(+), 301 deletions(-)
> > 

