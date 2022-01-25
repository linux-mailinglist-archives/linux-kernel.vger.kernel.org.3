Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B522C49B89B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345986AbiAYQ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:27:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:7382 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346982AbiAYQZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643127900; x=1674663900;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=pNEbnyLY+nXYgDriBYJiuh8SeETuEBNnzcAZaqb18Wc=;
  b=BiS1mqoW3n02JZW+jM7VYdA+YpmP3HnO6JoNva4wFejWMiiQMuALIygv
   8kcpjU8mq+XqwsjpolODln5WwBQldrdCc/qYDcqQQyq8xmWJiPxc4H1Vk
   gnOFv+GKk1XWYqR4yEVyHGjhUCW9zQVr+jRHBxZ/ZOp//dQARqdAfoY+l
   9KLPoidUfpote6hs1VcEcbUbVkMc34Wy1y0Vh1dDsm80IbChGtTyAXYjB
   0hpaefp6fOdyOTzfdgY+gL/UjQUbWjI+X85IQWX6r+Tgd5AqF6aIZ3n0J
   eKPzf+Zf+bMkJ7RWEv4Juc9weedkfw/m6aUwnzdG9mT4kHODJzrr2CXKm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="229918373"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="229918373"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 08:24:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="479552819"
Received: from jfink-mobl.amr.corp.intel.com (HELO [10.209.2.7]) ([10.209.2.7])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 08:24:56 -0800
Message-ID: <a34be5ca-47e7-95a6-602f-da054e409e85@intel.com>
Date:   Tue, 25 Jan 2022 08:24:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com> <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
 <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
 <cd534ff9-e500-c7ea-426a-347ac2b0830b@linux.intel.com>
 <YeLxE3zQ7Vexk3gv@hirez.programming.kicks-ass.net>
 <dfb311e3-1a83-31a2-3c82-fd982c0757f6@linux.intel.com>
 <Ye/w/lOf4f8+8fDt@hirez.programming.kicks-ass.net>
 <yt9dbl00rmgx.fsf@linux.ibm.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: earlyprintk=xdbc seems broken
In-Reply-To: <yt9dbl00rmgx.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 05:09, Sven Schnelle wrote:
>> Now the documentation states we need this super speed A<->A cable, but
>> could you also update the documentation for usb-c ? There's a fair
>> number of usb-c only devices out there now.
> Stupid beginners question: Would every USB3 A-A cable work, or are the
> debug cables special? I've read the RX/TX pairs have to be swapped, but
> to me it looks like that's always the case?

My understanding is that the 5v line is disconnected.  Here's one cable 
I have:

> https://designintools.intel.com/SVT_DCI_DbC2_3_A_to_A_Debug_Cable_1_Meter_p/itpdciamam1m.htm

I think they snip that line to prevent any chance of current flowing 
between devices.  The cable isn't expensive, but I do remember being 
astounded at how much Intel charged itself for shipping it. ;)

That said, I've also used the same cable Peter has: just a cheap A-to-A 
cable I had lying around.  It surely has VBUS connected, so I usually 
plumb it through a USB hub with a power switch.  This surely isn't the 
"right" way to do it, but it does seem to work in some situations.
