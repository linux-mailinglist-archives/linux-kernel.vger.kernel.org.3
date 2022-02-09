Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2834AF048
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiBIL5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiBILzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:55:51 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793D0E00FA7A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644404181; x=1675940181;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZzXvGDpuBIFPUCI015ca9co1l1JLyg3bO61AflE667Q=;
  b=WLoYcHIfjaJ/Wmflq0gu+lbvVYVFLHutpnvAo7C26ve2nJF6FaAwmsYk
   Yy/wuritJX/28y+VHl2k5JE7V0H87NRIsRH9rZsgEW4nQ3+YlWfDp8dFO
   91G03ifDuBBvGbVSSD2UktZkZtmnH2WZqGxNXzOdsIk74OMuoOM19Hj6B
   NpaMU3hxT7rRyNwDT9oKfOw0ag02cDFJGl1be/oEYsMEpbroDP82A3onF
   bZuJRQ+E7O1kif6RCbmo7+LcJjJnrN/DKjlCfEOSpEKoFkkL3vfoazYzZ
   9q8gf4z2sKxIGySv9simigmuZca1NVbNMLExWoKg4aOl0V4Jxb4ECjYvR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="236584968"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="236584968"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 02:56:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="485198181"
Received: from ravicha1-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.255.88.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 02:56:15 -0800
Date:   Wed, 9 Feb 2022 23:56:13 +1300
From:   Kai Huang <kai.huang@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@intel.com>, <luto@kernel.org>, <peterz@infradead.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <aarcange@redhat.com>, <ak@linux.intel.com>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <hpa@zytor.com>,
        <jgross@suse.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <jpoimboe@redhat.com>, <knsathya@kernel.org>,
        <pbonzini@redhat.com>, <sdeep@vmware.com>, <seanjc@google.com>,
        <tony.luck@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 00/29] TDX Guest: TDX core support
Message-Id: <20220209235613.652f5720cd196331d7a220ec@intel.com>
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>  60 files changed, 2079 insertions(+), 142 deletions(-)
>  create mode 100644 Documentation/x86/tdx.rst
>  create mode 100644 arch/x86/boot/compressed/tdcall.S
>  create mode 100644 arch/x86/boot/compressed/tdx.c
>  create mode 100644 arch/x86/boot/compressed/tdx.h
>  create mode 100644 arch/x86/boot/io.h
>  create mode 100644 arch/x86/include/asm/shared/io.h
>  create mode 100644 arch/x86/include/asm/shared/tdx.h
>  create mode 100644 arch/x86/include/asm/tdx.h
>  create mode 100644 arch/x86/kernel/tdcall.S
>  create mode 100644 arch/x86/kernel/tdx.c
> 

Hi,

Is it better to change the file name(s) to reflect they are for TDX guest
support, for instance, especially the last one arch/x86/kernel/tdx.c?

TDX host support basically does detection of SEAM, TDX KeyIDs, P-SEAMLDR and
initialize the TDX module, so likely TDX host support will introduce couple of
new files to do above things respectively, and the majority of the code could be
self-contained under some directory (currently under arch/x86/kernel/cpu/tdx/,
but can be changed of course).  Could we have some suggestions on how to
organize?

Thanks,
-Kai
