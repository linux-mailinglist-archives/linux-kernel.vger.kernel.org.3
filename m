Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DD44AA4AD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355983AbiBDXyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:54:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:29961 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234916AbiBDXyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644018857; x=1675554857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZNxtgZ32zZGXJcx9vyZAks1aVMKptKYDBiIZK+GC6AM=;
  b=LI9c0RJdSQvgxzCUZGGGnt13QOHXkl+KiydMvTWrUl9BF7/QhJ7mEpou
   iCTRNLpcsF554B2cKihwiOerXi3depdtSQ5CAVNZmoa9Y0BAbJSjyDKd4
   MpR0EN8jyAAgq4Aml23tCde1n9GQNcGpKUvV1M8dbcdjs/7+W5oWV/bor
   ty1eOmohZu9AUOAhJQAjuCNhes02px+KEs2i595IIU3FzHl9cnGcrhHDp
   fAlaLPo9AOuYjZy/AYryrTnSpgIPNOr1Wk5o90yj4go4O89r2VFLGMaR4
   ZZYzFGhSsHq0WQJ4CjJ0S81aHgXSCAkPyvgkQT6TehxDstpDyZMZF/+uR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="247295604"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="247295604"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 15:54:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="480990506"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 15:54:16 -0800
Date:   Fri, 4 Feb 2022 15:54:15 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 11/44] mm/pkeys: Define static PKS key array and
 default values
Message-ID: <20220204235415.GC785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-12-ira.weiny@intel.com>
 <f2d05862-9750-fd19-42c0-29aa06bdeb13@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2d05862-9750-fd19-42c0-29aa06bdeb13@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 04:02:05PM -0800, Dave Hansen wrote:
> On 1/27/22 09:54, ira.weiny@intel.com wrote:
> > +#define PKS_INIT_VALUE (PKR_RW_KEY(PKS_KEY_DEFAULT)		| \
> > +			PKR_AD_KEY(1)	| \
> > +			PKR_AD_KEY(2)	| PKR_AD_KEY(3)		| \
> > +			PKR_AD_KEY(4)	| PKR_AD_KEY(5)		| \
> > +			PKR_AD_KEY(6)	| PKR_AD_KEY(7)		| \
> > +			PKR_AD_KEY(8)	| PKR_AD_KEY(9)		| \
> > +			PKR_AD_KEY(10)	| PKR_AD_KEY(11)	| \
> > +			PKR_AD_KEY(12)	| PKR_AD_KEY(13)	| \
> > +			PKR_AD_KEY(14)	| PKR_AD_KEY(15))
> 
> Considering how this is going to get used, let's just make this
> one-key-per-line:
> 
> #define PKS_INIT_VALUE (PKR_RW_KEY(PKS_KEY_DEFAULT)		| \
> 			PKR_AD_KEY(1)	| \
> 			PKR_AD_KEY(2)	| \
> 			PKR_AD_KEY(3)	| \
> 			...

Good idea, done.
Ira

