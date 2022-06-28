Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B0555C307
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344956AbiF1Kgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiF1Kgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:36:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E63531534
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656412609; x=1687948609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qd/+wbTOOfSyyP0NkU7Hz763nXunyVjpMef36WY5hLM=;
  b=b83MlFJN/8s0iRFZ6uNq0CR1DPQH6Pt/XQekjjJ2PPC29Jd1dVR/BOG+
   yOJvf57IsFvsG22+RPCCmryuz+IRGtcTLmAgDlPVbMeZcoOJQtGAE75Sm
   8MRah7SS4v0I2tpXo+9uDQZKFxYxEuD4MzF3t9qQ4YBa7OD2CMZ0DpIEF
   Pw3saz5xv+iDGjgcnpsV/5B8EZcvzmgVii/YG2UTSMkTZoQK8iU/jtCxM
   VEfKap54IFDjycVTInZWmOJdov9e+JkYG41jCEz9XDVPmHr7L30F7XC0s
   tMR+gJTgRdEo0nCCAHTpjlz945idDHUgnju9EKv/867ALNRTrIeNPW0Dm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="281742886"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="281742886"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:36:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="617143863"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:36:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o68aK-000wj9-Ry;
        Tue, 28 Jun 2022 13:36:44 +0300
Date:   Tue, 28 Jun 2022 13:36:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 11/11] mfd: intel_soc_pmic_bxtwc: Fix spelling in the
 comment
Message-ID: <YrrZvEOiiwCo0Xsm@smile.fi.intel.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <20220616165823.4919-11-andriy.shevchenko@linux.intel.com>
 <Yrl5XZOgD8abd+Qm@google.com>
 <YrrL+Mil/B1Gh5VN@smile.fi.intel.com>
 <YrrQT8rxDFuAdzt5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrrQT8rxDFuAdzt5@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:56:31AM +0100, Lee Jones wrote:
> On Tue, 28 Jun 2022, Andy Shevchenko wrote:
> > On Mon, Jun 27, 2022 at 10:33:17AM +0100, Lee Jones wrote:
> > > On Thu, 16 Jun 2022, Andy Shevchenko wrote:
> > 
> > > > -	 * There is known hw bug. Upon reset BIT 5 of register
> > > > +	 * There is known HW bug. Upon reset BIT 5 of register
> > > 
> > > You may as well fix the grammar while you're at it.
> > 
> > Any suggestion from a native speaker? I can propose a few changes, but I'm
> > totally unsure.
> 
> No massive changes, just:
> 
> * There is a known H/W bug. Upon reset, BIT 5 of register
>            -       ---                -
> 
> > > >  	 * BXTWC_CHGR_LVL1_IRQ is 0 which is the expected value. However,
> > > >  	 * later it's set to 1(masked) automatically by hardware. So we
> > > > -	 * have the software workaround here to unmaksed it in order to let
> > > > -	 * charger interrutp work.
> > > > +	 * have the software workaround here to unmasked it in order to let
> > > > +	 * charger interrupt work.
> 
> * place a software workaround here to unmask it again in order to re-enable
>   -------                             ------    -----             ---------
> 
> * the charger interrupt.
>   ---
> 
> Something like that.  Feel free to adapt it further as you see fit.

Thank you, Lee, I will do as suggested!

-- 
With Best Regards,
Andy Shevchenko


