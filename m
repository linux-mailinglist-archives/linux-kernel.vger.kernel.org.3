Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059F44AF725
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbiBIQqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiBIQqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:46:36 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F06C0612BE;
        Wed,  9 Feb 2022 08:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644425199; x=1675961199;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XQwA5H1NZNeoU8rT8JswZxlC/uuAlKITWG+Qpo9gaAI=;
  b=ZQy5ZNTzedtrSDC+aet7Be1LCjTEleybvNxzUMY7vxRv4u8c5d+FSyVV
   PPX1kqSCRLiV0PEO5MLwycfkFBaArp229AxSJxvC+v3X0Q3SMqu9GBOBa
   BFkpt1tbQ+xQRzeVPjWsqmis6O5pglHL0/Jw8YfEG7VIl1g9a2rWYkGJj
   nGpkMdZat4okCDoq0YJiwsBIRmaM0xH0/mRTNXwyDvuCTpobrhDLq2qz1
   b0qc8pilyW1fxdaNkLGUIC37hIUXVWQgjTlc8AyVU4NkD3BtUuXJF3/8z
   TeenVeWY5T8WNaf3bCzT/SvACb4XGdOQy0HV1m1JDeUQ0517WvA891wGk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229216652"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="229216652"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 08:46:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="678698270"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2022 08:46:39 -0800
Received: from gserochi-MOBL.amr.corp.intel.com (unknown [10.209.64.156])
        by linux.intel.com (Postfix) with ESMTP id 28A775801CA;
        Wed,  9 Feb 2022 08:46:39 -0800 (PST)
Message-ID: <a8089aeb10ebc5c66c6ea47a727df2646be5d8ac.camel@linux.intel.com>
Subject: Re: [PATCH V6 0/3] Intel Software Defined Silicon
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Wed, 09 Feb 2022 08:46:38 -0800
In-Reply-To: <4732c476-f380-196f-6f37-a5c3c749dd4e@redhat.com>
References: <20220208005444.487209-1-david.e.box@linux.intel.com>
         <4732c476-f380-196f-6f37-a5c3c749dd4e@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-09 at 13:23 +0100, Hans de Goede wrote:
> Hi David,
> 
> On 2/8/22 01:54, David E. Box wrote:
> > This series adds support for Intel Software Defined Silicon. These
> > patches are the same as patches 4-6 from this series [1]. Patches 1-3 
> > of that series were pulled in during the 5.17 merge window.
> > 
> > [1] 
> > https://lore.kernel.org/lkml/20211216023146.2361174-1-david.e.box@linux.intel.com/T/
> 
> Thank you for taking all the feedback from others into account
> and doing new versions.
> 
> I was planning on doing an in-depth / foll review of this
> today, but unfortunately a kernel regression somewhere else
> has popped up and that is going to soak up all me work/$dayjob
> time this week, sorry.
> 
> Assuming no major issues are found, the plan definitely is
> to get this in before the 5.18 merge window. I've made a note
> in my calendar to get a full review done no later then
> February 17th.

Thanks for the update.

David

