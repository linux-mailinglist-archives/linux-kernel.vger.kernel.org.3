Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1F94A03F3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiA1Wuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:50:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:49352 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230342AbiA1Wup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643410245; x=1674946245;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JA26AfpgtBLc5rwmnYazxFLNcY1mp1p+8ru5ZKMp4cc=;
  b=F2jwDeca31Zd3+Xsj7OCMrhIVeE+zBAY721A/HhcsCuj3d7gQS/1KnVE
   yi3NXaXe3pkMoszhlcb7wkCFDfXXGN8RBr5mNr4k13/at+Ug/nRSSKVJ/
   9TjowVJ/UGDD5CiQQqmcEFXo0mpaWU/oYyFe+MJE1p3NLCp1XApYDfpq6
   hWcIRTpckSu50oP4T4IW6qOxCrMEc/XCLIyCKXpHE99RHYfLUwhPWMkZU
   UbirXmCyzm8zd7yOIpTN5/9tie6Haxr9yNe8lh3lwmWiKkncvClSi0h5k
   uhUAK7WwhdAoKYlSSCr9CxiMs1p6YqqCKBRnAvM7Er1CjE82z++cpkLdR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="227188842"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="227188842"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 14:50:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697241676"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 14:50:44 -0800
Message-ID: <87297f57-577a-2b33-81fa-935d1756eacb@intel.com>
Date:   Fri, 28 Jan 2022 14:50:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Subject: Re: [PATCH V8 05/44] x86/fpu: Refactor arch_set_user_pkey_access()
Content-Language: en-US
To:     ira.weiny@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-6-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220127175505.851391-6-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 09:54, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Both PKU and PKS update their register values in the same way.  They can
> therefore share the update code.
> 
> Define a helper, pkey_update_pkval(), which will be used to support both
> Protection Key User (PKU) and the new Protection Key for Supervisor
> (PKS) in subsequent patches.
> 
> pkey_update_pkval() contributed by Thomas
> 
> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks better than my original code.  Waaaaaay simpler.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
