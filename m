Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1E05AF52E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiIFT7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiIFT6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:58:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A40F16
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662494114; x=1694030114;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dskIZY0NrVgrM+PxM/nvZ7gE20s9P1sqP9KsU9Rs7BQ=;
  b=RDq6mE/MDaZZzC3Fwx0JcjDpXQG7lCXdHkvVnDLmsf3UoP8ZexjtZGxS
   3Y1WA3ueGsxfMCKsAS2RAL3G/3wZxo5xG85T0TpO4UX1XAefW4qFymXpQ
   TtQ3E/u5iiKPAO+TRCKvJPPEI4XQiUaO2WJqMeJHhMcgwCVA3QpV8f4nf
   x08gokKIi7+74K/o7VaOTouk/FyMOBmP22az09A8v6DyA8kAO242uc+lR
   2Xy9xG0SvLAB6BXTk+1mJ4myiJFl41yqVA0+0VdR4rLmu7szD4tv/VXx4
   NJR6J3hDWslgnWiGlXgs8RvlvvmRdx0NVFZaq35WcCP2Ah4GgWAwFGVH1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="358406144"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="358406144"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="616820492"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 06 Sep 2022 12:52:30 -0700
Received: from maurocar-mobl2 (maurocar-mobl2.ger.corp.intel.com [10.252.44.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 74FEC580890;
        Tue,  6 Sep 2022 12:52:28 -0700 (PDT)
Date:   Tue, 6 Sep 2022 20:58:27 +0200
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Juha-Pekka =?UTF-8?B?SGVpa2tpbMOk?= 
        <juha-pekka.heikkila@intel.com>
Subject: Re: [Intel-gfx] [PATCH v2 16/39] drm/i915: intel_fb: fix a
 kernel-doc issue with Sphinx
Message-ID: <20220906205819.03709faa@maurocar-mobl2>
In-Reply-To: <YtHeySNYE+B3XJ7w@intel.com>
References: <cover.1657699522.git.mchehab@kernel.org>
        <5647d7b6ffe47f53b90342e4ad881d4d4e6b005b.1657699522.git.mchehab@kernel.org>
        <YtHeySNYE+B3XJ7w@intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 17:40:25 -0400
Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:

> On Wed, Jul 13, 2022 at 09:12:04AM +0100, Mauro Carvalho Chehab wrote:
> > We can't use %foo[<something>] as this produces a bad markup.
> > Use instead, the emphasis markup directly.
> > 
> > Fix this issue:
> > 	Documentation/gpu/i915:136: ./drivers/gpu/drm/i915/display/intel_fb.c:280: WARNING: Inline strong start-string without end-string.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>  
> 
> Just trying to understand as well on why in a few you had chosen ```foo```
> and here **foo**. why?
> 

No particular reason. I'll use ``foo`` here too, keeping your reviewed-by.

> anyway, not a blocker:
> 
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>


> 
> 
> 
> > ---
> > 
> > To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> > See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/
> > 
> >  drivers/gpu/drm/i915/display/intel_fb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i915/display/intel_fb.c
> > index b191915ab351..fe72c75a9c79 100644
> > --- a/drivers/gpu/drm/i915/display/intel_fb.c
> > +++ b/drivers/gpu/drm/i915/display/intel_fb.c
> > @@ -276,7 +276,7 @@ lookup_format_info(const struct drm_format_info formats[],
> >   * @cmd: FB add command structure
> >   *
> >   * Returns:
> > - * Returns the format information for @cmd->pixel_format specific to @cmd->modifier[0],
> > + * Returns the format information for @cmd->pixel_format specific to **cmd->modifier[0]**,
> >   * or %NULL if the modifier doesn't override the format.
> >   */
> >  const struct drm_format_info *
> > -- 
> > 2.36.1
> >   
