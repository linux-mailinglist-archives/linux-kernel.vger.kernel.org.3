Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B44358B408
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 08:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiHFGNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 02:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241522AbiHFGNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 02:13:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3543A20BCA
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 23:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659766431; x=1691302431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rnGoIqlgHnpHyW30pzBJBZ0XkdzXtBv1kgOaR1Ujoh4=;
  b=CHPbNqd7mFAFAUdpDz0xfUxfauRgyE+fGQ7D1a7Ho3HsYfUDBQrN1fGC
   cex8i/iDT4BAYh4zAWdcsUj2yZbzjhUzJzcvfjpgKMNR03R/Nl5f0MN3H
   sN/kriNbdrDKM1A0kSUaOAu9AdNjSDw/chkM0yoSiZio+7oclvMY4ozVT
   XUxz6nBTHxQbR/3i/QG5I9C+Z4rrbuPtVtRVISinzKFFTNJooAMdtE6YA
   2DaJqfAjYzU4AeL5LHe9swTrL2+3v6UCCdp4JLlSqlX6Y3m3SG3yH1gCJ
   JPYIGcPXWLZnoeDKYm20Mi+IWL27utCXvQyISySSxyAJyAc9HHGH/MoNP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="376638238"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="376638238"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 23:13:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="671926830"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 23:13:49 -0700
Received: by lahna (sSMTP sendmail emulation); Sat, 06 Aug 2022 09:13:46 +0300
Date:   Sat, 6 Aug 2022 09:13:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <Yu4Gmkous7asng6h@lahna>
References: <YkrqL/wnACNVOpSi@lahna>
 <ae336e2d-8e7c-9167-ab3d-8d642cd4fb2c@fnarfbargle.com>
 <Yk2qMt568oEeTj8H@lahna>
 <49183e52-2e73-b32f-11ad-6036b1040d7c@fnarfbargle.com>
 <Yuz/Q3MTVIhCZU+0@lahna>
 <f5c8b9f0-0d6d-c6db-ae0b-894acb58d078@fnarfbargle.com>
 <Yu0UuOVGeIv/U+jU@lahna>
 <d484d7e5-f1aa-1096-e6fb-bbf16ce28699@fnarfbargle.com>
 <Yu0nWro4xXURbSX6@lahna>
 <87c1a001-ef79-6390-dfe2-06d2850f6e84@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87c1a001-ef79-6390-dfe2-06d2850f6e84@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brad,

On Fri, Aug 05, 2022 at 10:43:54PM +0800, Brad Campbell wrote:
> On 5/8/22 22:21, Mika Westerberg wrote:
> 
> > They are pretty standard so I suspect myself the display side of things.
> > Not sure if it is possible (I think it is from sysfs /sys/class/drm/*)
> > to disable the tunneled DP connections and see if that makes it not
> > hang. Alternatively you can try to comment out the call to
> > tb_tunnel_dp() from the driver. Let me know if you want me to make hack
> > patch that does it for you.
> > 
> 
> I used this :
> 
> iff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index 9a3214fb5038..eae7523af78b 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -865,7 +865,7 @@ static void tb_tunnel_dp(struct tb *tb)
>         struct tb_cm *tcm = tb_priv(tb);
>         struct tb_port *port, *in, *out;
>         struct tb_tunnel *tunnel;
> -
> +       return;
>         if (!tb_acpi_may_tunnel_dp()) {
>                 tb_dbg(tb, "DP tunneling disabled, not creating tunnel\n");
>                 return;
> 
> I'm now using Linus GIT head. No change in behaviour really.
> 
> No tunnels were created. None of the TB displays light up in Linux or BIOS. System still locks
> up on reboot and the first time I attempted to compose this reply it locked up hard before I
> had a chance to finish it because I attempted to verify the devices were present with an lspci -tv.
> 
> If I do an lspci -tv after the module load, it locks hard instantly and reproducibly.

Okay, let's try to deal with one issue at the time so first the hang
that appears after the OS is booted up. Do you still have the
"pcie_port_pm=off" in the kernel command line? The hang that happens
afterwards sounds exactly like that the runtime PM would kick in but the
parameter should prevent that from happening. Since you are connecting
Thunderbolt 1 devices there is really no PM we can do for them at all
and the TBT driver should block it too.

Is it possible to narrow this down to a single device connected and then
get me the full dmesg output (with CONFIG_PCI_DEBUG=y) and output of
'sudo lspci -vv'?
