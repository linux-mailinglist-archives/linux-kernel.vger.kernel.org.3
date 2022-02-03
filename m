Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41214A817D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349685AbiBCJcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:32:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:28901 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238557AbiBCJcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643880737; x=1675416737;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=E5oKH9pNYnnZ4bfD+pbTHXt1O8eiHw5reOksh1C2xaY=;
  b=is0xug6LQ/gmhwFpODmdBV/T3/RkDz/xXD1rwFcCjXhd5/WdP3JM3oh0
   h6d1+rDS4KNFTzMLg1br0ycENcoCKTc3D195wbKGBUNkDo8E//VI8pUns
   h5F2Z4LrBy6JNCAbcpW0lXKTxETntFNYjI5RJVOmWdWhlgZfRvaFfwV4Y
   iIU4ZagLNM9rNeaDJFDc2yusdACAsHGVPkAgWOfUt2pR++mgc+uv7cPor
   Z1WFE8hsxl2VkO3ZUNmVDrwFu1X5bey+TWVzgDj5RNywzDO2w8Tw0KzLj
   T9bsfV6Odr+K1ihMinEYckE5hQ5/RMa0yMUeCG4VKwIQk9frJ0DUfrNXK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308835891"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="308835891"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 01:32:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="566348944"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 03 Feb 2022 01:32:14 -0800
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>, "J . Avila" <elavila@google.com>
References: <CGME20220203030000epcas2p2a924a55a5ae60e8685cd62b66a5482f3@epcas2p2.samsung.com>
 <1643857054-112415-1-git-send-email-dh10.jung@samsung.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH 0/3] support USB offload feature
Message-ID: <27337aa9-2bfd-18d5-cded-7f8ae0f053d9@linux.intel.com>
Date:   Thu, 3 Feb 2022 11:33:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1643857054-112415-1-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.2.2022 4.57, Daehwan Jung wrote:
> This patchset is for USB offload feature, which makes Co-processor to use
> some memories of xhci. Especially it's useful for USB Audio scenario.
> Audio stream would get shortcut because Co-processor directly write/read
> data in xhci memories. It could get speed-up using faster memory like SRAM.
> That's why this also gives vendors flexibilty of memory management.
> Below pathches have been merged in AOSP kernel(android12-5.10) and I put
> together and split into 3 patches.

Can you share the full USB offload support series?

I'd like to see the big picture before taking any exporting and override
patches.

Thanks
-Mathias
 
