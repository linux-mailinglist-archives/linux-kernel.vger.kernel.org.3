Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70B34B5E06
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiBNXEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:04:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiBNXD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:03:59 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ADE19B40B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644879831; x=1676415831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LQDocSg91l9vEMUZRg6EgiKUmYdHL9BdY4/boZi/R5Y=;
  b=Ax5iKriuk8OwKR8ILD6lUwNpAJYL8miiC7rcmSQ2eJAsysiIi28bEzoE
   hiCYEcKy0TE6ySFwjnZQLUwSBFbKjuakoLPQJtI2DdylmY7KOEYftRM3o
   aDExkj+TMXHdAXK36xNnJRd20abfKt3ut7+ayLuu/QGSIi9TeHxh87jE+
   0+3k4yiZ85SUInooh2M6aIvzSvpNkLWlO6U9B0sUqm+PU9ZvH802rQ6Zl
   /WuSmc0M1pyMcc9Z8Wai2Ao0AFdAR0pFCC2BgUoHqV9C54QyIqeH6Zc3G
   ISGulIA9ALop7VX5543Ya9REvBKWyCvtD+QaSG6hhyr3zLuRAuTDXT7OZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250409578"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="250409578"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 15:03:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="543974316"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 15:03:50 -0800
Date:   Mon, 14 Feb 2022 15:03:50 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 06/44] mm/pkeys: Add Kconfig options for PKS
Message-ID: <20220214230350.GW785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-7-ira.weiny@intel.com>
 <9c4a8275-236d-67b6-07f9-5e46f66396c0@intel.com>
 <20220128231015.GK785175@iweiny-DESK2.sc.intel.com>
 <f72b0e17-11bf-b12e-fe7a-d38b0833acdc@intel.com>
 <20220204190851.GY785175@iweiny-DESK2.sc.intel.com>
 <20220209053430.GL785175@iweiny-DESK2.sc.intel.com>
 <6b50671d-883f-561a-bf7d-5ae01c2cc312@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b50671d-883f-561a-bf7d-5ae01c2cc312@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 11:20:20AM -0800, Dave Hansen wrote:
> On 2/8/22 21:34, Ira Weiny wrote:
> >>> In other words, there are two things that must happen before the code
> >>> gets compiled in:
> >>>
> >>> 1. Arch support
> >>> 2. One or more features to use the arch support
> >> Yes.  I really think we are both say the same thing with different words.
> > Is the following more clear?
> > 
> > <commit>
> > 
> > PKS is only useful to kernel consumers and is only available on some
> > architectures.  If no kernel consumers are configured or PKS support is
> > not available the PKS code can be eliminated from the compile.
> > 
> > Define a Kconfig structure which allows kernel consumers to detect
> > architecture support (ARCH_HAS_SUPERVISOR_PKEYS) and, if available,
> > indicate that PKS should be compiled in (ARCH_ENABLE_SUPERVISOR_PKEYS).
> > 
> > In this patch ARCH_ENABLE_SUPERVISOR_PKEYS remains off until the first
> > kernel consumer sets it.
> 
> It's a bit more clear.  I wish it was more clear about the problem.  I
> think it would be well-served to add some specifics and clarify the
> *problem*.  Maybe something like:

;-(  Ok.

> 
> == Problem ==
> 
> PKS support is provided by core x86 architecture code.  Its consumers,
> however, may be far-flung device drivers like NVDIMM support.  The PKS
> core architecture code is dead weight without a consumer.

This is not the whole story though.  The far-flung device drivers don't need to
compile their PKS code, or may not be able to support a feature, if
ARCH_HAS_SUPERVISOR_PKEYS is not set.  Also, they may wish to chose a different
implementation for the same functionality if available.  So
ARCH_HAS_SUPERVISOR_PKEYS can affect more than just if PKS code is compiled.
It could affect how drivers chose to implement some higher level feature.

> 
> --- maybe add one example ---
> 
> == Solution ==
> 
> Avoid even compiling in the core PKS code if there are no consumers.

And allow users to avoid compiling PKS code on architectures which
don't support PKS.  Or chose another implementation if possible.

I'll try again.

<msg>

Consumers wishing to implement additional protections on memory pages may be
able to use PKS.  However, PKS is only available on some architectures.

In addition, PKS code, both in the core and in these consumers would be dead
code without PKS being both available and used.  Therefore, if no kernel
consumers are configured or PKS support is not available all the PKS code can
be eliminated from the compile.

Avoid using PKS if the architecture does not support it.  Furthermore,
avoid compiling any PKS code if their are no consumers configured to use 
it.

Define ARCH_HAS_SUPERVISOR_PKEYS to detect architecture support and
define ARCH_ENABLE_SUPERVISOR_PKEYS to indicate the core should compile
in support.

In this patch ARCH_ENABLE_SUPERVISOR_PKEYS remains off until the first
kernel consumer sets it.

</msg>


Ira

> 
> == Details ==
