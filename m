Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9E14A875E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239467AbiBCPNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:13:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:34517 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234323AbiBCPNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643901205; x=1675437205;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=HvrAzmdR09sq861C3G6Eh3De6Gkmg08YRy47I4Cm4/Q=;
  b=WxMRoEIOgoJZ6bOma8jruYOGCR1zc/3G0EZI3NUsWS/YllqLvhaG5eRO
   tFQaJapWtdwmqeBWql3m8Y0+QKJBLaYsYPeSgk+mSAX8gfV1gzODr35z0
   Htyhwel4SjOuUH2bGRD8pGAFykas8aa0nRCh+qhUCvShExsBSUGELNDPk
   yL6gw4nfVvi8BvLp7zoTNoHbMq72uf6A8k98ipUgiOmTsFrxJzzpPJqyc
   yQu8Nwl4FnZCjrSzFSXh7TKd5PZ5UACy0yAEu9gMP3w+pa5ggKrcRFuRJ
   BfzLabjRFiKmUxVIM4SK+6zGhVdUDwnNwOAqO11iXlD+ZdxTzBDHz27Vo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228812985"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="228812985"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 07:13:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="483265297"
Received: from oshoron-mobl.amr.corp.intel.com (HELO [10.209.125.125]) ([10.209.125.125])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 07:13:24 -0800
Message-ID: <ef32b70f-dcaa-f642-b322-4ef7928e58e5@intel.com>
Date:   Thu, 3 Feb 2022 07:13:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-2-kirill.shutemov@linux.intel.com>
 <87fsp2z8p8.ffs@tglx> <20220201231459.2doc4iaibmuua4qk@black.fi.intel.com>
 <20220203003209.bi6i4llc4jeouuh6@treble>
 <20220203140943.wwi2hk3h3wzsjmdv@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv2 01/29] x86/tdx: Detect running as a TDX guest in early
 boot
In-Reply-To: <20220203140943.wwi2hk3h3wzsjmdv@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 06:09, Kirill A. Shutemov wrote:
> I just realized that we have moved tdx_early_init() back and forth few
> times for this reason. Ughh..

Can you flesh out the changelogs so we don't continue to repeat history,
please?
