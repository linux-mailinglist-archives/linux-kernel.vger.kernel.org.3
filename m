Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D50574793
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237405AbiGNIuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiGNIul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:50:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BAD3ED72
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657788640; x=1689324640;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+nkwAyhBBbTdcIq1r+Hu2NumNZeEfZRU9U/lzgfMfTI=;
  b=XovSQXpOZcj7uwp0B48ic02wrAcmoV7KTZIOdiw7ZDkok/Gzt4tvdo4n
   e+4BtzD3V9oqFJ/Ak76Gn4fUWXJT+Z5y2wGtlO/wKElr6PJlAH07HSj1J
   hlRsgm+7ghtUvigO+ByLOyuEfTqf3Z0YmeqJKZjaazVMR2WrnmNeq2s3+
   KKu6Rp8xayHaB5Ly8kyiRPOhqMRD6fGtQ7jvOx2qa77AwPZzyN29FVr2Q
   iaVpVoRCTeQbt1BDR+CvQbCmPZ8sZsE91GqK8ql6gqDC4WO2j8k557kbF
   jmB4IASaXlRefKPVgPRFK6Fhb1LcWE/5VmhILzMdxsdvbZNkPe+H6O8c/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="284214479"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="284214479"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 01:50:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="653784267"
Received: from maurocar-mobl2.ger.corp.intel.com (HELO maurocar-mobl2) ([10.252.36.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 01:50:37 -0700
Date:   Thu, 14 Jul 2022 10:50:34 +0200
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH v2 01/39] drm/i915/gvt: Fix kernel-doc for
 intel_gvt_switch_mmio()
Message-ID: <20220714105034.0b370a6a@maurocar-mobl2>
In-Reply-To: <Ys9Am6jkPiVnA+uW@intel.com>
References: <cover.1657699522.git.mchehab@kernel.org>
        <72db6b58c1f223e326f84978267ba064eaf67ff0.1657699522.git.mchehab@kernel.org>
        <Ys8/JP3ITMKF1aHp@intel.com>
        <Ys9Am6jkPiVnA+uW@intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 18:00:59 -0400
Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:

> On Wed, Jul 13, 2022 at 05:54:44PM -0400, Rodrigo Vivi wrote:
> > On Wed, Jul 13, 2022 at 09:11:49AM +0100, Mauro Carvalho Chehab wrote:  
> > > From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > > 
> > > Fix the following W=1 kernel warnings:
> > > 
> > > drivers/gpu/drm/i915/gvt/mmio_context.c:560: warning: expecting
> > > prototype for intel_gvt_switch_render_mmio(). Prototype was for
> > > intel_gvt_switch_mmio() instead.
> > > 
> > > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > > Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>  
> > 
> > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>  
> 
> I actually changed my mind after seeing that in most cases you use "()"
> for the functions and you didn't use for this case...

The documentation build system handles both ways equally, and there's
no consensus kernel-wide about what would be the preferred way[1].

Also, at the html (or pdf) output, they'll all look the same. So, no
difference in practice at the produced documentation.

[1] The current count (using drm-tip 2022y-07m-12d-21h-47m-27s) as basis,
    is:

	$ git ls-files|xargs grep -Pzo "\/\*\*\n \* [_a-zA-Z0-9]+ -" |wc -l
	36680
	$ git ls-files|xargs grep -Pzo "\/\*\*\n \* [_a-zA-Z0-9]+\s*\(\) -" |wc -l
	12068

    So, 48748 documented functions, being ~25% with parenthesis, 
    and ~75% without it.

    Under drivers/gpu, the numbers are:

	$ git ls-files|grep drivers/gpu/|xargs grep -Pzo "\/\*\*\n \* [_a-zA-Z0-9]+\s*\(\) -" |wc -l
	480
	mchehab@sal /new_devel/v4l/tmp $ git ls-files|grep drivers/gpu/|xargs grep -Pzo "\/\*\*\n \* [_a-zA-Z0-9]+ -" |wc -l
	4046

> which one should we pick for consistency?

Yeah, it is nicer to use the same way everywhere. Btw, on media, I was
enforcing one way at the beginning, but I ended giving up doing that
as it was too many efforts for too little. Nowadays, half of media
function declarations have parenthesis, half doesn't.

Anyway, this is what we have at i915 driver, before this series:

	$ grep -Pzo "\/\*\*\n \* [_a-zA-Z0-9]+\s*\(\) -" $(find drivers/gpu/drm/i915 -type f)|wc -l
	53
	$ grep -Pzo "\/\*\*\n \* [_a-zA-Z0-9]+ -" $(find drivers/gpu/drm/i915 -type f)|wc -l
	542

This series include 3 functions with "()" (on patches 1 and 3, both
authored by Jiapeng, and 11 functions without it on my own patches.

I'll change those two patches to remove the "()" for consistency.

I guess I'll add a patch at the end changing the other 53 functions
to drop "()".

Regards,
Mauro
