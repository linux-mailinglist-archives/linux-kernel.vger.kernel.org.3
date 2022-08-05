Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9709858AB36
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbiHENCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbiHENCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:02:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7AB27FE4
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 06:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659704523; x=1691240523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/YHy+UW6b2JCwuDLlbsQHM3sjjmf5ju3H89apsgwvjg=;
  b=VJ8OrvopqwLqx5MHUIotzv5ZKGzaVwv94JwHV4lRduNlpbtbfioPkoLH
   JHcEYIvMyZcW5uu4/750H39WywzvdsKU/q8ydV4bf+4sn+6kBBi49TLSw
   kAzMZ0dQc440otoYwXOCq+jLRMDAg3rF52hCZOXSa9PHTOW0iPOuR4Rtt
   exeJRQqcjTYsbXwMxcOb1aFQ9nFQKeJQFqbm3LdIFMC4JJKU+iQQlc8Kv
   C+pULyruCFYldaFfgfiiEWdwZcigMdGp44HP6J66KP1RKsPQrCHolRNtL
   PFofuQw+aHKGMiHBFoWIpRtHc9w15igPfVULLypFYW+edAp0/Dz8kj8qO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="316084909"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="316084909"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 06:01:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="779736006"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 06:01:46 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 05 Aug 2022 16:01:44 +0300
Date:   Fri, 5 Aug 2022 16:01:44 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <Yu0UuOVGeIv/U+jU@lahna>
References: <YkcMofXKr/ZmOSwH@lahna>
 <7ea44c20-6c65-224f-af7b-aa1bd310d038@fnarfbargle.com>
 <YkrEE0uh9EVCchfl@lahna>
 <d112651d-919d-ce2d-efac-6abbd9de0f07@fnarfbargle.com>
 <YkrqL/wnACNVOpSi@lahna>
 <ae336e2d-8e7c-9167-ab3d-8d642cd4fb2c@fnarfbargle.com>
 <Yk2qMt568oEeTj8H@lahna>
 <49183e52-2e73-b32f-11ad-6036b1040d7c@fnarfbargle.com>
 <Yuz/Q3MTVIhCZU+0@lahna>
 <f5c8b9f0-0d6d-c6db-ae0b-894acb58d078@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5c8b9f0-0d6d-c6db-ae0b-894acb58d078@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 08:43:08PM +0800, Brad Campbell wrote:
> > Well can you try so that you disable PCIe PM for starters? Pass
> > "pcie_port_pm=off" in the command line and see if anything changes. Of
> > course this prevents low power states.
> > 
> 
> That allows me to modprobe thunderbolt from an xterm :

Okay does it work any better if you don't have anything attached to the
TBT ports when you boot up? If it does, how about just adding a single
device (no display connected)?
