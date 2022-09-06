Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F935AF530
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiIFT7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiIFT6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:58:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7E299B5C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662494127; x=1694030127;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0JkPYEHioOtGLJAxsT5kA+8eXjUWG3XSjrJRIH80fII=;
  b=P7dcf5quFENIUpWjL/MWWo/QEnubmxU37bvwqPdL/mRJjNMjFoYy+fvs
   Cq/Pwhw2UhLPXmq30Hi/4V/iPMARXg3Qb2RG/fScJPQcbjWYXzftHZrxI
   MrGM32sJxrfBmgyWKuK7ok84Nl0y3jfjLwwIHA9WAGX1jfMW8lCneWAWI
   BQ55rfg+uPg9Et8zk4bL08Yxn3uWClmG9cbt5iUM0fXXNWwqaA2mfV6D1
   U5a6gQTL5R/vhlRAJZRqR2rmcKkFav7hVf7i3rDLnAqjSRrVFlKfo8XiY
   YuLV2iOlCO+3s6HaoHNSzTPR76cRgv2MJh+OITESCPvHXz7Vkye8kUtrx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="358406146"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="358406146"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:52:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="717837480"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 06 Sep 2022 12:52:32 -0700
Received: from maurocar-mobl2 (maurocar-mobl2.ger.corp.intel.com [10.252.44.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id CA236580583;
        Tue,  6 Sep 2022 12:52:30 -0700 (PDT)
Date:   Tue, 6 Sep 2022 21:17:47 +0200
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH v2 18/39] drm/i915: intel_pm.c: fix some
 ascii artwork at kernel-doc
Message-ID: <20220906211740.6b92f23d@maurocar-mobl2>
In-Reply-To: <YvIu/oCnkDbdLqou@intel.com>
References: <cover.1657699522.git.mchehab@kernel.org>
        <b3657e96ea87a5803ed27d1cc0d9fa44b2f164cf.1657699522.git.mchehab@kernel.org>
        <YvIu/oCnkDbdLqou@intel.com>
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

On Tue, 9 Aug 2022 05:55:10 -0400
Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:

> On Wed, Jul 13, 2022 at 09:12:06AM +0100, Mauro Carvalho Chehab wrote:
> > Preserving ascii artwork on kernel-docs is tricky, as it needs
> > to respect both the Sphinx rules and be properly parsed by
> > kernel-doc script.
> > 
> > The Sphinx syntax require code-blocks, which is:
> > 
> > 	::
> > 
> > followed by a blank line and indented lines.
> > 
> > But kernel-doc only works fine if the first and the last line
> > are indented with the same amount of spaces.
> > 
> > Also, a "\" at the end means that the next line should be merged
> > with the first one.  
> 
> my first reaction was: "do we really need those new empty ( ) blocks?"
> 
> Then I read this ;)

Yeah, it is tricky to get it right, due to kernel-doc + Sphinx here.
Also, I bet that this would be needed even for ReST files with
C code on it, as it is likely the C domain encoding at Sphinx that
handles continuation lines with "\" at the end...

> 
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> 
> > 
> > Change the ascii artwork to be on code-blocks, starting all
> > lines at the same characters and not ending with a backslash.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > ---
> > 
> > To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> > See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/
> > 
> >  drivers/gpu/drm/i915/intel_pm.c | 33 ++++++++++++++++++---------------
> >  1 file changed, 18 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
> > index f06babdb3a8c..d3393752b04b 100644
> > --- a/drivers/gpu/drm/i915/intel_pm.c
> > +++ b/drivers/gpu/drm/i915/intel_pm.c
> > @@ -684,18 +684,20 @@ static const struct intel_watermark_params i845_wm_info = {
> >   * FIFO is relatively small compared to the amount of data
> >   * fetched.
> >   *
> > - * The FIFO level vs. time graph might look something like:
> > + * The FIFO level vs. time graph might look something like::
> >   *
> > - *   |\   |\
> > - *   | \  | \
> > - * __---__---__ (- plane active, _ blanking)
> > - * -> time
> > + *   ^
> > + *   |   |\   |\      (                          )
> > + *   |   | \  | \     (                          )
> > + *   |   __---__---__ (- plane active, _ blanking)
> > + *   +-------------------> time
> >   *
> > - * or perhaps like this:
> > + * or perhaps like this::
> >   *
> > - *   |\|\  |\|\
> > - * __----__----__ (- plane active, _ blanking)
> > - * -> time
> > + *   ^
> > + *   |     |\|\  |\|\   (                          )
> > + *   |   __----__----__ (- plane active, _ blanking)
> > + *   +-------------------> time
> >   *
> >   * Returns:
> >   * The watermark in bytes
> > @@ -731,13 +733,14 @@ static unsigned int intel_wm_method1(unsigned int pixel_rate,
> >   * FIFO is relatively large compared to the amount of data
> >   * fetched.
> >   *
> > - * The FIFO level vs. time graph might look something like:
> > + * The FIFO level vs. time graph might look something like::
> >   *
> > - *    |\___       |\___
> > - *    |    \___   |    \___
> > - *    |        \  |        \
> > - * __ --__--__--__--__--__--__ (- plane active, _ blanking)
> > - * -> time
> > + *   ^
> > + *   |     |\___       |\___        (                          )
> > + *   |     |    \___   |    \___    (                          )
> > + *   |     |        \  |        \   (                          )
> > + *   |  __ --__--__--__--__--__--__ (- plane active, _ blanking)
> > + *   +---------------------------------> time
> >   *
> >   * Returns:
> >   * The watermark in bytes
> > -- 
> > 2.36.1
> >   
