Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C004F6602
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbiDFQxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbiDFQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:52:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D517C11FE07
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649257017; x=1680793017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F/U+cj87UvGy5lLxu2syFQGQxJxfbuLpFf8x7D/NyD4=;
  b=VysKwanJ++NfYcHoIcpt6ZK34rFJEferTR2GzGrAdqCCtOL4KlqM5a/7
   ACzBF1i2PTIOfc034jrtLF6glUgW4EfS5nkH5bYN/bjEGfk+Ll3K6bCyq
   KvS08MdW6Y07yvVKJBOQea0svTqqxDJA4MFS0kH9T0Z3wiKrQPxDMdlnp
   kMxkfESx8De47UnT55y9FfZraAwL0HQ5QRNdhUuJusu/MVVOhJXg55Fku
   8GjPY2JEUehBZyqBDWG+ywNlUYSJ2PcSAw+dLSUotBAKey6F7gUVkoSmv
   SBYQIG+yGU1IQqP6BhuqJUTTu1owPkp2VGNk5fZY5CuziCzYVi3xh652Z
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="243209608"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="243209608"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 07:56:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="588410796"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 07:56:52 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 06 Apr 2022 17:56:50 +0300
Date:   Wed, 6 Apr 2022 17:56:50 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <Yk2qMt568oEeTj8H@lahna>
References: <YkRtf2HiXBOWGjna@lahna>
 <eacc22dc-e650-a208-9484-62edd98d5778@fnarfbargle.com>
 <YkXYdcUZ1E18ENle@lahna>
 <5dcee6f7-cc8c-e3ce-920c-4ad3f5d77e14@fnarfbargle.com>
 <YkcMofXKr/ZmOSwH@lahna>
 <7ea44c20-6c65-224f-af7b-aa1bd310d038@fnarfbargle.com>
 <YkrEE0uh9EVCchfl@lahna>
 <d112651d-919d-ce2d-efac-6abbd9de0f07@fnarfbargle.com>
 <YkrqL/wnACNVOpSi@lahna>
 <ae336e2d-8e7c-9167-ab3d-8d642cd4fb2c@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae336e2d-8e7c-9167-ab3d-8d642cd4fb2c@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 06, 2022 at 10:51:41AM +0800, Brad Campbell wrote:
> Both included in-line.
> 
> This is cold boot with the chain plugged in. I've re-added the dbg to
> print the link number, and I've included your path discovery debugs.
> Boot with chain plugged in, wait for it to settle, unplug and replug.
> First head in the chain fails with :
> 
> [   65.778129] [drm:radeon_dp_link_train [radeon]] *ERROR* displayport link status failed
> [   65.778158] [drm:radeon_dp_link_train [radeon]] *ERROR* clock recovery failed

Thanks for the logs! 

The DP tunnels look pretty much the same except that the Apple EFI CM
seems to assign 7 buffers for the AUX RX path first hop whereas we
always use 1 buffer. Not sure if that really makes a difference and we
could try to use the same number but first, I realized that the PCI
resource allocation seems not to work properly.

Can you disable PCIe tunneling (if you use Ubuntu/Fedora or similar
there is the "Thunderbolt -> Direct Access" switch that you can turn
off) and try again? Please also take 'sudo lspci -vv' for the resulting
topology. I suspect this might also affect the other issues (the
timeouts) you are seeing. Note this makes the peripherals connected to
the monitors unusable too.
