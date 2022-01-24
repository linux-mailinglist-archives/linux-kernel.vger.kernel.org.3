Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288434982C1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238703AbiAXOx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:53:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:63871 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231403AbiAXOxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036035; x=1674572035;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=HsIRnM64QqAoEu0GEH2hXeq3tAM799zncK8DTVzxh58=;
  b=By3dSiN0tpelwrSV7D/j0O/mTJUaZLy3RIrBh5l656tcH+6/IlyqmTlJ
   KiDlp9mAmkartjqljfSDpPbbRfYHfVmclDOsEsNt/z2cw554VHAw4TQCy
   D9sHhp1JrIka+L3MjfV5Q/RMchDqjfusioZWbMscrCga2b2jbYf22EnNk
   ujEJGMwflAMZtrfhsQ7NP2mGswIJEYT8PjH/VJPpjk0gcIlny3UNiv1KQ
   R9IkjYjmj3nb8QCIMhpUErM+BGj1ZhwxUEFbLZtmTZWOcUpf8/kr93JAL
   U/pHp9sJVKNHDU52sG9bhSCZnddY01FT6q0tYFyTibyT4rKuxtwLFbHhe
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="270496511"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="270496511"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 06:53:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="562677786"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2022 06:53:52 -0800
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
 <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
 <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com> <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YcGhIm7yqYPk4Nuu@hirez.programming.kicks-ass.net>
 <YeE4rtq6t73OxOi+@hirez.programming.kicks-ass.net>
 <cd534ff9-e500-c7ea-426a-347ac2b0830b@linux.intel.com>
 <YeLxE3zQ7Vexk3gv@hirez.programming.kicks-ass.net>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <dfb311e3-1a83-31a2-3c82-fd982c0757f6@linux.intel.com>
Date:   Mon, 24 Jan 2022 16:55:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YeLxE3zQ7Vexk3gv@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 
> [    0.000000] xhci_dbc:early_xdbc_parse_parameter: dbgp_num: 0
> [    4.984106] xhci_dbc:xdbc_start: waiting for connection timed out, DCPORTSC:0xa0
> [    9.946159] xhci_dbc:xdbc_start: waiting for connection timed out, DCPORTSC:0xa0
> [    9.946163] xhci_dbc:early_xdbc_setup_hardware: failed to setup the connection to host
>
> [   12.818364] xhci_hcd 0000:00:0d.0: xHCI Host Controller
> [   12.818373] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 1
> [   12.820360] xhci_hcd 0000:00:0d.0: xHCI Host Controller
> [   12.820363] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
> [   12.821036] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [   12.821040] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
> [   12.823451] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [   12.823453] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
> [   17.115089] usb usb4-port4: Cannot enable. Maybe the USB cable is bad?
> [   17.115163] usb usb4-port4: config error

Ok, I see it now.
Your setup has two xhci controllers, earlypringk=dbc enables dbc on the first xhci
it finds, which would be at 0000:00:0d.0.
Your cable is connected to the second xhci host at 0000:00:14.0

does using "earlyprintk=xdbc1" work?

Thanks
-Mathias
