Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0ED14F4F17
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836952AbiDFAlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445217AbiDEPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:42:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8C62191437
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:08:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9388C23A;
        Tue,  5 Apr 2022 07:08:05 -0700 (PDT)
Received: from bogus (unknown [10.57.43.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14E7D3F5A1;
        Tue,  5 Apr 2022 07:08:03 -0700 (PDT)
Date:   Tue, 5 Apr 2022 15:08:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] ARM: vexpress/spc: Fix doxygen comments
Message-ID: <20220405140800.baww2wrow3hdp5ho@bogus>
References: <20220404130207.1162445-1-sudeep.holla@arm.com>
 <008aae79-4a6c-721f-7ef5-7b73f6d7e000@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008aae79-4a6c-721f-7ef5-7b73f6d7e000@infradead.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, Apr 04, 2022 at 05:21:39PM -0700, Randy Dunlap wrote:
> Hi--
> 
> On 4/4/22 06:02, Sudeep Holla wrote:
> > Kbuild bot reported the following doxygen build warning:
> > 
> >   |  arch/arm/mach-versatile/spc.c:231: warning: This comment starts with
> >   |		'/**', but isn't a kernel-doc comment.
> >   |		Refer Documentation/doc-guide/kernel-doc.rst
> >   |  		* ve_spc_cpu_in_wfi(u32 cpu, u32 cluster)
> > 
> > Fix the issue by dropping the parameters specified in the kernel doc.
> > 
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/linux-doc/202204031026.4ogKxt89-lkp@intel.com
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  arch/arm/mach-vexpress/spc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
> > index 1c6500c4e6a1..8f99d47d4b89 100644
> > --- a/arch/arm/mach-vexpress/spc.c
> > +++ b/arch/arm/mach-vexpress/spc.c
> > @@ -228,7 +228,7 @@ static u32 standbywfi_cpu_mask(u32 cpu, u32 cluster)
> >  }
> >  
> >  /**
> > - * ve_spc_cpu_in_wfi(u32 cpu, u32 cluster)
> > + * ve_spc_cpu_in_wfi()
> 
> This line still needs a "function short description," e.g.
> 
> + * ve_spc_cpu_in_wfi() - fooble the barfloppity
> 
> similar to what you did in patch 2/2.

I did this intentionally, I can move only this from the other patch.
Since I saw few others w/o description, I addressed all at once in the
second patch and just remove warning reported in this patch. I am fine
either way.

> 
> >   *
> >   * @cpu: mpidr[7:0] bitfield describing CPU affinity level within cluster
> >   * @cluster: mpidr[15:8] bitfield describing cluster affinity level
> 
> and I would s/doxygen/kernel-doc/ for both patches.
> 

Sure will do.

-- 
Regards,
Sudeep
